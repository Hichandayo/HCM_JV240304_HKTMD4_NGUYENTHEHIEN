# xóa bảng Catefory
-- drop table Category;
# xóa bảng Room
-- drop table Room;
# xóa bảng Customer
-- drop table Customer;
# xóa bảng Booking
-- drop table Booking;
# xóa bảng BookingDetail
-- drop table BookingDetail;
# tạo bảng Category
select * FROM Customer WHERE Email NOT REGEXP "^[a-zA-Z0-9][a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]*?[a-zA-Z0-9._-]?@[a-zA-Z0-9][a-zA-Z0-9._-]*?[a-zA-Z0-9]?\\.[a-zA-Z]{2,63}$";
create table Category(
id int auto_increment primary key,
name varchar(100) not null unique,
status tinyint default(1) check(status in (0,1)));
# tạo bảng Room
create table Room(
id int auto_increment primary key,
name varchar(150) not null ,
status tinyint default(1) check(status in (0,1)),
price float not null check(price >= 1000000),
saleprice float default(0) check(saleprice <= price),
createdDate date default(crudate()),
categoryId int not null );

# tạo bảng Customer
create table Customer(
id int auto_increment primary key,
name varchar(150) not null,
email varchar(150) not null unique,
phone varchar(50) not null unique,
address varchar(255),
createdDate date default(curdate()) check(createdDate >= curdate()),
gender tinyint not null check(gender in (0,1,2)),
birthday  date not null);

# tạo bảng Booking
create table Booking(
id int auto_increment primary key,
customerId int not null ,
status tinyint default(1) check( status in (0,1,2,3)),
bookingDate datetime default(curdate()));

# tạo bảng BookingDetail
create table BookingDetail(
bookingId int not null,
RoomId int not null,
price float not null,
startDate Datetime not null,
endDate datetime not null check(enddate > startDate));

# tạo chỉ mục Name trong Room
create unique index Room_name on Room(name);

# tạo chỉ mục price trong Room
create unique index Room_price on Room(price);

# tạo chỉ mục CreatedDate trong Room
create unique index Room_createdDate on Room(createdDate);

#

