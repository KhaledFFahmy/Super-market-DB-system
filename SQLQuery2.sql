/*==============================================================*/
/* Table: CART                                                  */
/*==============================================================*/
create table CART (
   CART_ID              numeric(15)          not null,
   SSN                  numeric(15)          not null,
   constraint PK_CART primary key (CART_ID)
)
go

/*==============================================================*/
/* Index: ADD2_FK                                               */
/*==============================================================*/




create nonclustered index ADD2_FK on CART (SSN ASC)
go

/*==============================================================*/
/* Table: CUSTOMER                                              */
/*==============================================================*/
create table CUSTOMER (
   SSN                  numeric(15)          not null,
   PAYMENT_ID           numeric(15)          null,
   CART_ID              numeric(15)          null,
   FNAME                varchar(30)          not null,
   LNAME                varchar(30)          not null,
   PHONE                numeric(15)          not null,
   HOUSE_NUM            numeric(10)          not null,
   ADDRESS              varchar(50)          not null,
   USERNAME             varchar(30)          not null,
   PASSWORD             numeric(30)          not null,
   constraint PK_CUSTOMER primary key (SSN)
)
go

/*==============================================================*/
/* Index: DOES_FK                                               */
/*==============================================================*/




create nonclustered index DOES_FK on CUSTOMER (PAYMENT_ID ASC)
go

/*==============================================================*/
/* Index: ADD_FK                                                */
/*==============================================================*/




create nonclustered index ADD_FK on CUSTOMER (CART_ID ASC)
go

/*==============================================================*/
/* Table: "IN"                                                  */
/*==============================================================*/
create table "IN" (
   PID                  numeric(15)          not null,
   CID                  numeric(15)          not null,
   constraint PK_IN primary key (PID, CID)
)
go

/*==============================================================*/
/* Index: IN_FK                                                 */
/*==============================================================*/




create nonclustered index IN_FK on "IN" (PID ASC)
go

/*==============================================================*/
/* Index: IN2_FK                                                */
/*==============================================================*/




create nonclustered index IN2_FK on "IN" (CID ASC)
go

/*==============================================================*/
/* Table: ORDERS                                                */
/*==============================================================*/
create table ORDERS (
   ORDER_ID             numeric(15)          not null,
   SSN                  numeric(15)          not null,
   PROMO_CODE           varchar(20)          null,
   ORDER_MONTH          numeric(2)           null,
   ORDER_YEAR           numeric(4)           null,
   TOTAL_PRICE          numeric(20)          null,
   constraint PK_ORDERS primary key (ORDER_ID)
)
go

/*==============================================================*/
/* Index: APPLIED_TO2_FK                                        */
/*==============================================================*/




create nonclustered index APPLIED_TO2_FK on ORDERS (PROMO_CODE ASC)
go

/*==============================================================*/
/* Index: MAKES_FK                                              */
/*==============================================================*/




create nonclustered index MAKES_FK on ORDERS (SSN ASC)
go

/*==============================================================*/
/* Table: ORDER_PRODUCT                                         */
/*==============================================================*/
create table ORDER_PRODUCT (
   ID                   numeric(10)          not null,
   ORDER_ID             numeric(15)          not null,
   PID                  numeric(15)          not null,
   QUANTITY             numeric(20)          null,
   constraint PK_ORDER_PRODUCT primary key (ID)
)
go

/*==============================================================*/
/* Index: ICLUDES_FK                                            */
/*==============================================================*/




create nonclustered index ICLUDES_FK on ORDER_PRODUCT (ORDER_ID ASC)
go

/*==============================================================*/
/* Table: PAYMENT                                               */
/*==============================================================*/
create table PAYMENT (
   PAYMENT_ID           numeric(15)          not null,
   SSN                  numeric(15)          not null,
   AMOUNT               numeric(10)          not null,
   PAYMENT_METHOD       varchar(15)          not null,
   constraint PK_PAYMENT primary key (PAYMENT_ID)
)
go

/*==============================================================*/
/* Index: DOES2_FK                                              */
/*==============================================================*/




create nonclustered index DOES2_FK on PAYMENT (SSN ASC)
go

/*==============================================================*/
/* Table: PCATEGORY                                             */
/*==============================================================*/
create table PCATEGORY (
   CID                  numeric(15)          not null,
   CNAME                varchar(30)          not null,
   constraint PK_PCATEGORY primary key (CID)
)
go

/*==============================================================*/
/* Table: PRODUCT                                               */
/*==============================================================*/
create table PRODUCT (
   PID                  numeric(15)          not null,
   CART_ID              numeric(15)          not null,
   NAME                 varchar(30)          null,
   PRICE                numeric(10)          null,
   QUANTITY             numeric(20)          null,
   constraint PK_PRODUCT primary key (PID)
)
go

/*==============================================================*/
/* Index: INCLUDS_FK                                            */
/*==============================================================*/




create nonclustered index INCLUDS_FK on PRODUCT (CART_ID ASC)
go

/*==============================================================*/
/* Table: PROMOTION                                             */
/*==============================================================*/
create table PROMOTION (
   PROMO_CODE           varchar(20)          not null,
   ORDER_ID             numeric(15)          null,
   DISCOUNT_VALUE       numeric(3)           not null,
   VALID_UPTO           datetime             not null,
   constraint PK_PROMOTION primary key (PROMO_CODE)
)
go

/*==============================================================*/
/* Index: APPLIED_TO_FK                                         */
/*==============================================================*/




create nonclustered index APPLIED_TO_FK on PROMOTION (ORDER_ID ASC)
go

alter table CART
   add constraint FK_CART_ADD2_CUSTOMER foreign key (SSN)
      references CUSTOMER (SSN)
go

alter table CUSTOMER
   add constraint FK_CUSTOMER_ADD_CART foreign key (CART_ID)
      references CART (CART_ID)
go

alter table CUSTOMER
   add constraint FK_CUSTOMER_DOES_PAYMENT foreign key (PAYMENT_ID)
      references PAYMENT (PAYMENT_ID)
go

alter table "IN"
   add constraint FK_IN_IN_PRODUCT foreign key (PID)
      references PRODUCT (PID)
go

alter table "IN"
   add constraint FK_IN_IN2_PCATEGOR foreign key (CID)
      references PCATEGORY (CID)
go

alter table ORDERS
   add constraint FK_ORDERS_APPLIED_T_PROMOTIO foreign key (PROMO_CODE)
      references PROMOTION (PROMO_CODE)
go

alter table ORDERS
   add constraint FK_ORDERS_MAKES_CUSTOMER foreign key (SSN)
      references CUSTOMER (SSN)
go

alter table ORDER_PRODUCT
   add constraint FK_ORDER_PR_HAS_A_PRODUCT foreign key (PID)
      references PRODUCT (PID)
go

alter table ORDER_PRODUCT
   add constraint FK_ORDER_PR_ICLUDES_ORDERS foreign key (ORDER_ID)
      references ORDERS (ORDER_ID)
go

alter table PAYMENT
   add constraint FK_PAYMENT_DOES2_CUSTOMER foreign key (SSN)
      references CUSTOMER (SSN)
go

alter table PRODUCT
   add constraint FK_PRODUCT_INCLUDES_CART foreign key (CART_ID)
      references CART (CART_ID)
go

alter table PROMOTION
   add constraint FK_PROMOTIO_APPLIED_T_ORDERS foreign key (ORDER_ID)
      references ORDERS (ORDER_ID)
go
if exists (select 1
            from  sysindexes
           where  id    = object_id('CUSTOMER')
            and   name  = 'DOES_FK'
            and   indid > 0
            and   indid < 255)
   drop index CUSTOMER.DOES_FK
go
Select TOP(1)  P.NAME, count(O.PID) as total From PRODUCT as P
Inner join ORDER_PRODUCT as O on P.PID = O.PID
Group by P.NAME
Order by total desc



Select TOP(1) PID, NAME                                                                        
From PRODUCT
Where PID not in (select distinct PID from ORDER_PRODUCT ,ORDERS
where ORDER_PRODUCT.ORDER_ID=ORDERS.ORDER_ID
And ORDERS.ORDER_MONTH=4
)

Select TOP(1) CUSTOMER.FNAME     
From CUSTOMER Left join ORDERS on 
CUSTOMER.SSN=ORDERS.SSN
Where ORDERS.SSN is null  AND ORDER_ID not in (select distinct SSN from ORDERS
Where orders.ORDER_YEAR=2021
)
GROUP BY CUSTOMER.FNAME

Select TOP(1) C.FNAME, sum(P.AMOUNT) AS totalpayment
from CUSTOMER as c inner join PAYMENT as p on
c.SSN=p.SSN
inner join ORDERS as o
on c.SSN=o.SSN
where o.ORDER_MONTH=5
Group by c.FNAME
Order by sum(P.AMOUNT) desc


Select TOP(1) PC.CNAME, count (INN.CID) AS TOTAL
From PCATEGORY AS PC,[supermarket].[dbo].[IN] AS INN
WHERE PC.CID=INN.CID
Group by PC.CNAME
Order by TOTAL desc



select product.PID,PRODUCT.NAME,PRODUCT.PRICE,PRODUCT.QUANTITY ,count(orders.SSN) as totalcustomers from order_product , orders,PRODUCT
where order_product.ORDER_ID=orders.ORDER_ID
AND ORDER_PRODUCT.PID=PRODUCT.PID
group by product.PID,PRODUCT.NAME,PRODUCT.PRICE,PRODUCT.QUANTITY
