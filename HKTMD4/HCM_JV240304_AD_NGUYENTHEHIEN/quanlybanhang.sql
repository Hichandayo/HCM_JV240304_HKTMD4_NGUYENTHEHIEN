#### xóa bảng Catefory
-- drop table Category;
#### xóa bảng Room
-- drop table Room;
#### xóa bảng Customer
-- drop table Customer;
#### xóa bảng Booking
-- drop table Booking;
#### xóa bảng BookingDetail
-- drop table BookingDetail;

select * FROM Customer WHERE Email NOT REGEXP "^[a-zA-Z0-9][a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]*?[a-zA-Z0-9._-]?@[a-zA-Z0-9][a-zA-Z0-9._-]*?[a-zA-Z0-9]?\\.[a-zA-Z]{2,63}$";
#### tạo bảng Category
create table Category(
id int auto_increment primary key,
name varchar(100) not null unique,
status tinyint default(1) check(status in (0,1)));

#### tạo bảng Room
create table Room(
id int auto_increment primary key,
name varchar(150) not null ,
status tinyint default(1) check(status in (0,1)),
price float not null ,
saleprice float default(0),
createdDate date default(curdate()),
categoryId int not null );

#### tạo bảng Customer
create table Customer(
id int auto_increment primary key,
name varchar(150) not null,
email varchar(150) not null unique,
phone varchar(50) not null unique,
address varchar(255),
createdDate date default(curdate()),
gender tinyint not null check(gender in (0,1,2)),
birthday  date not null);

#### tạo bảng Booking
create table Booking(
id int auto_increment primary key,
customerId int not null ,
status tinyint default(1) check( status in (0,1,2,3)),
bookingDate datetime default(curdate()));

#### tạo bảng BookingDetail
create table BookingDetail(
bookingId int not null,
RoomId int not null,
price float not null,
startDate Datetime not null,
endDate datetime not null );

#### tạo chỉ mục Name trong Room
create  index Room_name on Room(name);

#### tạo chỉ mục price trong Room
create  index Room_price on Room(price);

#### tạo chỉ mục CreatedDate trong Room
create  index room_createddate on Room(createdDate);

#### thêm khóa phụ 
alter table BookingDetail
add foreign key (bookingId) references Booking(id);
alter table BookingDetail
add foreign key (RoomId) references Room(id);

#### thêm dữ liệu vào bảng Category
INSERT INTO Category (name, status)
VALUES 
('Deluxe', 1),
('Suite', 1),
('Standard', 1),
('Executive', 1),
('Single', 1),
('Double', 1);

#### thêm dữ liệu vào bảng Room
INSERT INTO Room (name, status, price, saleprice,  categoryId)
VALUES 
('Room 11', 1, 1500000, 1300000,  1),
('Room 12', 1, 1200000, 1000000,  1),
('Room 13', 1, 1300000, 1200000,  2),
('Room 666', 1, 1400000, 1300000,  2),
('Room 999', 1, 1100000, 1000000, 3),
('Room 771', 1, 1000000, 900000,  3),
('Room 49', 1, 1600000, 1500000,  4),
('Room 53', 1, 1800000, 1700000,  4),
('Room 3', 1, 1200000, 1100000,  5),
('Room 7', 1, 1000000, 950000,  5),
('Room 9', 1, 1300000, 1200000,  6),
('Room 23', 1, 1500000, 1400000,  6),
('Room 30', 1, 1400000, 1300000,  2),
('Room 69', 1, 1600000, 1500000,  1),
('Room 96', 1, 1700000, 1600000,  3);

#### thêm dữ liệu vào bảng Customer
INSERT INTO Customer (name, email, phone, address,  gender, birthday)
VALUES
('John Doe', 'john@example.com', '0123456789', '123 HCM', 0, '1990-05-15'),
('Jane Smith', 'jane@example.com', '0123456788', '456 DA NANG',  1, '1992-08-22'),
('Tom Brown', 'tom@example.com', '0123456787', '789 HOI AN',  0, '1989-12-12'),
('Mary Johnson', 'mary@example.com', '0123456786', '321 HA NOI',1, '1995-01-25'),
('Emily White', 'emily@example.com', '0123456785', '654 HUE', 2, '1991-03-19');

#### thêm dữ liệu vào bảng Booking
INSERT INTO Booking (customerId, status, bookingDate)
VALUES
(1, 1, NOW()),
(2, 1, NOW()),
(3, 1, NOW()),
(4, 1, NOW()),
(5, 1, NOW());
#### cập nhật lại trạng thái của bảng Booking
update Booking set status = 3 where id= 4;
update Booking set status = 0 where id= 1 ;

#### thêm dữ liệu vào bảng BookingDetail
INSERT INTO BookingDetail (bookingId, RoomId, price, startDate, endDate)
VALUES
(1, 1, 1300000, '2024-08-15', '2024-08-20'),
(1, 2, 1000000, '2024-08-15', '2024-08-20'),
(2, 3, 1200000, '2024-09-01', '2024-09-10'),
(2, 4, 1300000, '2024-09-01', '2024-09-10'),
(3, 5, 1000000, '2024-10-01', '2024-10-07'),
(3, 6, 1100000, '2024-10-01', '2024-10-07'),
(4, 7, 1400000, '2024-11-15', '2024-11-20'),
(4, 8, 1500000, '2024-11-15', '2024-11-20'),
(5, 9, 1000000, '2024-12-01', '2024-12-05'),
(5, 10, 950000, '2024-12-01', '2024-12-05');

#### Lấy ra danh phòng có sắp xếp giảm dần theo Price gồm các cột sau:Id,Name,Price,SalePrice,Status,CategoryName,CreatedDate
select r.id Id,r.name 'Tên Phòng',r.price 'Giá Phòng',r.saleprice 'Giá Giảm',r.status 'Trạng Thái',c.name 'Loại Phòng',r.createdDate 'Ngày Tạo'
from Room r join Category c 
on r.categoryId = c.id
order by r.price desc;


#### Lấy ra danh sách Category gồm:Id,Name,TotalRoom,Status(Trong đó cột Status nếu = 0 là Ẩn , = 1 là Hiển thị)
select c.id ID, c.name 'Tên', COUNT(r.id) 'Tổng Số Phòng',
    case
        when c.status = 1 then 'Hiển thị'
        when c.status = 0 then 'Ẩn'
    end 'Trạng Thái'
from Category c left join Room r 
on c.id = r.categoryId
group by c.id, c.name, c.status;

#### Truy vấn danh sách Customer gồm:Id,Name,Email,Phone,Address,CreatedDate,Gender,BirthDay,Age(Age là cột suy ra từ BirthDay,Gender nếu = 0 là Nam, 1 là Nữ, 2 là khác)
select id ID ,name 'Tên',email 'Email',phone 'Số Điện Thoại',address 'Địa Chỉ',createdDate 'Giờ Tạo',
	case
	when gender = 0 then 'Nam'
	when gender = 1 then 'Nữ'
	when gender = 2 then 'Khác'
    end  'Giới Tính',
    birthday 'Sinh Nhật',
    TIMESTAMPDIFF(year, birthday, CURDATE()) 'Tuổi'
from Customer;

#### Truy vấn danh sách Customergồm:Id,Name,Email,Phone,Address,CreatedDate,Gender,BirthDay, Age (Age là cột suy ra từ BirthDay, Gender nếu = 0 là Nam,1 là Nữ ,2 là khác)
select id ID ,name 'Tên',email 'Email',phone 'Phone',address 'Địa Chỉ',createdDate 'Giờ Tạo',
	case
	when gender = 0 then 'Nam'
	when gender = 1 then 'Nữ'
	when gender = 2 then 'Khác'
    end  'Giới Tính',
    birthday 'Sinh Nhật',
    TIMESTAMPDIFF(year, birthday, CURDATE()) 'Tuổi'
from Customer;

#### View v_getRoomInfo Lấy ra danh sách của 10 phòng có giá cao nhất
create view v_getRoomInfo as
select id, name, price, saleprice, status, categoryId, createdDate
from Room
order by price desc limit 10;
select * from v_getRoomInfo; -- truy vấn

#### View v_getBookingList hiển thị danh sách phiếu đặt hàng gồm :Id,BookingDate,Status,CusName,Email, Phone,TotalAmount ( Trong đó cột Status nếu = 0 Chưa duyệt,= 1 Đã duyệt,= 2 Đã thanh toán,= 3 Đã hủy)
create view v_getBookingList as
select b.id 'ID',b.bookingDate 'Ngày Đặt',
    case 
        when b.status = 0 then 'Chưa duyệt'
        when b.status = 1 then 'Đã duyệt'
        when b.status = 2 then 'Đã thanh toán'
        when b.status = 3 then 'Đã hủy'
    end 'Trạng Thái',
c.name 'Tên Khách Hàng',c.email 'Email',c.phone 'Số Điện Thoại',SUM(bd.price) 'Tổng Tiền'
from Booking b
join Customer c on b.customerId = c.id
join BookingDetail bd on b.id = bd.bookingId
group by b.id, b.bookingDate, b.status, c.name, c.email, c.phone;

SELECT * FROM v_getBookingList; -- truy vấn

#### Thủ tục addRoomInfo thực hiện thêm mới Room,khi gọi thủ tục truyền đầy đủ các giá trị của bảng Room (Trừ cột tự động tăng)
-- xóa procedure
drop procedure addRoomInfo;
delimiter //
create  procedure addRoomInfo(p_name varchar(150),p_status tinyint,p_price float,p_saleprice float,p_createdDate date,p_categoryId int)
begin 
insert into Room(name, status, price, saleprice, createdDate, categoryId)
values (p_name, p_status, p_price,p_saleprice, p_createdDate, p_categoryId);
end;//

call addRoomInfo('Dark Room 666', 1, 6000000, 1800000, '2024-09-05', 1); -- thêm vào
####  Thủ tục getBookingByCustomerId hiển thị danh sách phieus đặt phòng của khách hàng theo Id khách hàng gồm :Id, BookingDate,Status, TotalAmount(Trong đó cột Status nếu = 0 Chưa duyệt, = 1 Đã duyệt,= 2 Đã thanh toán , = 3 Đã hủy),Khi gọi thủ tục truyền vào id của khách hàng
delimiter //
create procedure getBookingByCustomerId(customerId int)
begin
	select b.id,b.bookingdate,
	case 
		when b.status = 0 then 'Chưa Duyệt'
		when b.status = 1 then 'Đã Duyệt'
		when b.status = 2 then 'Đã Thanh Toán'
		when b.status = 3 then 'Đã Hủy'
	end as 'Trạng Thái',
	SUM(bd.price)  'Tổng Tiền' 
    from booking b join BookingDetail bd
	on b.id= bd.bookingId where b.customerId = customerId
	group by b.id, b.bookingDate, b.status;
end;//
call getBookingByCustomerId(5);

#### Thủ tục getRoomPaginate lấy ra danh sách phòng có phân trang gồm :Id,Name,Price,SalePrice, Khi gọi thủ tuc truyền vào limit và page
-- xóa procedure
drop procedure getRoomPaginate;

delimiter //
create procedure getRoomPaginate(limitSlot int, page int)
begin 
 DECLARE offset int;
  SET offset = (page - 1) * limitSlot;
select id,name, Price, SalePrice
 from Room
 LIMIT limitslot OFFSET offset;
end;//
-- truy vấn
call getRoomPaginate(5,2); -- truyền vào số lượng hiển thị trên trang và số lượng trang


#### Tạo trigger tr_Check_Price_Value sao cho khi thêm hoặc sửa phòng Room nếu nếu giá trị của cột Price > 5.000.000 thì tự động chuyển về 5.000.000 và in ra thông báo‘Giá phòng lớn nhất 5triệu’
delimiter //
create trigger tr_Check_Price_Value
before insert on Room
for each row
begin
	if new.price > 5000000 then
		set new.price = 5000000;
        signal sqlstate '45000' set message_text = 'Giá phòng lớn nhất 5 triệu';
	end if;
end;//

#### Tạo trigger tr_check_Room_NotAllow khi thực hiện đặt phòng, nếu ngày đến (StartDate) và ngày đi(EndDate) của đơn hiện tại mà phòng đã có người đặt rồi thì
