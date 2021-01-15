create schema ws2;

drop table if exists ws2.cart_product;
drop table if exists ws2.product_discount;
drop table if exists ws2.order_product;
drop table if exists ws2.wish_product;
drop table if exists ws2.order;
drop table if exists ws2.product;
drop table if exists ws2.wishlist;
drop table if exists ws2.cart;
drop table if exists ws2.user;
drop table if exists ws2.pii;

create table ws2.pii (
    user_id       serial primary key,
    first_name    varchar(256),
    last_name     varchar(256),
    email         varchar(256) unique not null,
    national_id   varchar(256),
    country_of_residence varchar(256),

    unique(national_id, country_of_residence)
);

create table ws2.user (
    user_id        int primary key references ws2.pii("user_id"),
    age            int,
    address        varchar(256)
);

create table ws2.order (
    order_id     serial primary key,
    order_total  numeric,
    order_status  varchar(11) check(order_status in ('in_progress', 'finished')),
    created_at   timestamp without time zone,
    updated_at   timestamp without time zone
);

create table ws2.product (
    product_id         serial primary key,
    product_category   varchar(4) check(product_category in ('cat1', 'cat2', 'cat3')),
    product_price      numeric,
    product_description varchar(512),
    in_stock             boolean
);

create table ws2.order_product (
    order_id        int references ws2.order("order_id"),
    product_id        int references ws2.product("product_id")
);

create table ws2.product_discount (
    discount_id     serial primary key,
    product_id      int references ws2.product("product_id"),
    discount_percentage  numeric check(discount_percentage >=0 and discount_percentage <= 100),
    discount_start_date     timestamp without time zone,
    discount_expirty_date     timestamp without time zone
);

create table ws2.wishlist (
    wish_id     serial primary key,
    user_id     int references ws2.user("user_id"),
    created_at   timestamp without time zone,
    updated_at   timestamp without time zone
);

create table ws2.wish_product (
    wish_id int references ws2.wishlist("wish_id"),
    product_id int references ws2.product("product_id")
);

create table ws2.cart (
    cart_id    serial primary key,
    user_id    int references ws2.user("user_id")
);

create table ws2.cart_product (
    cart_id       int references ws2.cart("cart_id"),
    product_id       int references ws2.product("product_id")
);

insert into ws2.pii (first_name, last_name, email, national_id, country_of_residence) values
('FN1', 'LN1', 'E1', 'NID1', 'C1'), 
('FN2', 'LN2', 'E2', 'NID2', 'C2'),
('FN3', 'LN3', 'E3', 'NID3', 'C3'),
('FN4', 'LN4', 'E4', 'NID4', 'C4'), 
('FN5', 'LN5', 'E5', 'NID5', 'C5'),
('FN6', 'LN6', 'E6', 'NID6', 'C6'); 

insert into ws2.user (user_id, age, address) values
(1, 70, 'ADR1'),
(2, 60, 'ADR2'),
(3, 50, 'ADR3'),
(4, 40, 'ADR4'),
(5, 30, 'ADR5'),
(6, 20, 'ADR6');

insert into ws2.order (order_total, order_status, created_at, updated_at) values
(60, 'finished', '2021-02-04 00:00:00+00', '2021-02-04 00:00:00+00'),
(120, 'finished', '2021-02-04 00:00:00+00', '2021-02-04 00:00:00+00'),
(190, 'finished', '2021-02-04 00:00:00+00', '2021-02-04 00:00:00+00'),
(30, 'finished', '2021-02-04 00:00:00+00', '2021-02-04 00:00:00+00'),
(30, 'finished', '2021-02-04 00:00:00+00', '2021-02-04 00:00:00+00'),
(160, 'finished', '2021-02-04 00:00:00+00', '2021-02-04 00:00:00+00'),
(100, 'finished', '2021-02-04 00:00:00+00', '2021-02-04 00:00:00+00'),
(30, 'finished', '2021-02-04 00:00:00+00', '2021-02-04 00:00:00+00'),
(20, 'finished', '2021-02-04 00:00:00+00', '2021-02-04 00:00:00+00'),
(180, 'finished', '2021-02-04 00:00:00+00', '2021-02-04 00:00:00+00');

insert into ws2.product (product_category, product_price, product_description, in_stock) values
('cat1', 10, 'D1', true),
('cat1', 20, 'D2', true),
('cat1', 30, 'D3', true),
('cat2', 40, 'D4', false),
('cat2', 50, 'D5', true),
('cat2', 60, 'D6', true),
('cat2', 70, 'D7', true),
('cat3', 80, 'D8', true),
('cat3', 90, 'D9', true),
('cat3', 100, 'D10', true);

insert into ws2.order_product (order_id, product_id) values
(1, 1),
(1, 2),
(1, 3),
(2, 1),
(2, 1),
(2, 10),
(3, 1),
(3, 2),
(3, 3),
(3, 3),
(3, 10),
(4, 3),
(5, 3),
(6, 3),
(6, 5),
(6, 8),
(7, 2),
(7, 3),
(7, 5),
(8, 3),
(9, 2),
(10, 5),
(10, 6),
(10, 7);

insert into ws2.product_discount (product_id, discount_percentage, discount_start_date, discount_expirty_date) values
(5, 10, '2021-02-04 00:00:00+00', '2021-02-04 00:00:00+00'),
(8, 50, '2021-02-04 00:00:00+00', '2021-02-04 00:00:00+00');


insert into ws2.wishlist (user_id, created_at, updated_at) values 
(1, '2021-02-04 00:00:00+00', '2021-02-04 00:00:00+00'),
(2, '2021-02-04 00:00:00+00', '2021-02-04 00:00:00+00'),
(3, '2021-02-04 00:00:00+00', '2021-02-04 00:00:00+00');

insert into ws2.wish_product (wish_id, product_id) values
(1, 4),
(2, 4),
(3, 4);

insert into ws2.cart (user_id) values
(2),
(5);

insert into ws2.cart_product (cart_id, product_id) values
(1, 1),
(1, 5),
(2, 2),
(2, 2),
(2, 8);
