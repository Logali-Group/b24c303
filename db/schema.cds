namespace com.logaligroup;

using {
    cuid,
    managed,
    sap.common.CodeList
} from '@sap/cds/common';

type decimal : Decimal(6, 2);

entity Products : cuid, managed {
    product      : String(8);
    productName  : String(40);
    productUrl   : String;
    availability : Association to VH_Status;
    rating       : Decimal(3, 2);
    price        : decimal;
    currency     : String default 'USD';
    detail       : Association to Details; // detail_ID
    toReviews    : Association to many Reviews
                       on toReviews.product = $self;
    toInventory  : Association to many Inventory
                       on toInventory.product = $self;
};

entity Details : cuid {
    baseUnit   : String(2);
    heigth     : decimal;
    width      : decimal;
    depth      : decimal;
    weight     : decimal;
    unitVolume : String(2);
    unitWeight : String(2);
};

entity Suppliers : cuid {
    supplier     : String(9);
    supplierName : String(40);
    webAddress   : String;
    contact      : Association to Contacts; // contact_ID
};

entity Contacts : cuid {
    fullName    : String(80);
    email       : String(120);
    phoneNumber : String(12);
};

entity Reviews : cuid {
    rating       : Decimal(3, 2);
    creationDate : Date;
    user         : String(40);
    review       : LargeString;
    product      : Association to Products; //Almacena el ID del Producto en el campo product_ID
};

entity Inventory : cuid {
    deparment : String;
    min       : Int16;
    max       : Int16;
    value     : Int32;
    lotSize   : decimal;
    quantity  : decimal;
    unit      : String;
    product   : Association to Products; //Almacena el ID del Producto en el campo product
};


//VH = Value Help
entity VH_Categories : cuid {
    category        : String;
    toSubCategories : Association to many VH_SubCategories
                          on toSubCategories.category = $self;
};

entity VH_SubCategories : cuid {
    subCategory : String;
    category    : Association to VH_Categories;
};

entity VH_Departments : cuid {
    deparment : String;
};

entity VH_Status : CodeList {
    key code : String enum {
            InStock        = 'In Stock';
            LowAvalibility = 'Low Avalibility';
            NotInStock     = 'Not In Stock';
        };
};
