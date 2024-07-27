show tables;

create table product (
    id int primary key auto_increment,
    name varchar(100) not null,
    price decimal(10, 2) not null,
    description TEXT,
    thumbnail_url varchar(255),
    image_url varchar(255)
);