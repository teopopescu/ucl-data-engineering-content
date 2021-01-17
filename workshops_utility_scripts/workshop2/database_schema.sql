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

create table ws2.user_order(
    user_id int references ws2.user("user_id"),
    order_id int references ws2.order("order_id")
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