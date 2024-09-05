#### tạo cơ sở dữ liệu
create database md04_database_thuchanh_cb;
#### use vào cơ sở dữ liệu
use md04_database_thuchanh_cb;
#### xóa bảng books
-- drop table books;
#### xóa bảng Readers
-- drop table Readers;
#### xóa bảng BorrowingRecords
-- drop table BorrowingRecords;


#### tạo bảng Books (Bảng sách)
create table Books(
book_id int auto_increment primary key, -- khóa chính
book_title varchar(100) not null, -- tên sách
book_author varchar(100) not null); -- tác giả

#### tạo bảng Readers (bảng độc giả)
create table Readers( 
id int auto_increment primary key, -- khóa chính
name varchar(150) not null, -- tên đọc giả
phone varchar(11) not null, -- số điện thoại của độc giả
email varchar(100)); -- email của độc giả

#### tạo bảng BorrowingRecords (bảng giao dịch mượn trả)
create table BorrowingRecords(
id int auto_increment primary key, -- khóa chính
borrow_date date not null, -- ngày mượn sách
return_date date, -- ngày trả sách
book_id int not null, 
reader_id int not null);

#### thêm khóa phụ cho bảng BorrowingRecords
alter table BorrowingRecords
add foreign key (book_id) references books(book_id);
alter table BorrowingRecords
add foreign key (reader_id) references Readers(id);

#### tạo chỉ mục name trong bảng Readers
create unique index readers_name on readers(name);

#### thêm dữ liệu bảng books
INSERT INTO Books (book_title, book_author)
VALUES 
('Đắc Nhân Tâm', 'Dale Carnegie'),
('1984', 'George Orwell'),
('Cha giàu cha nghèo', 'Robert Kiyosaki'),
('Moby-Dick', 'Herman Melville'),
('Truyện Kiều', 'Nguyễn Du');

#### thêm dữ liệu bảng readers
INSERT INTO Readers (name, phone, email)
VALUES 
('Nguyen Van A', '0901234567', 'a@gmail.com'),
('Tran Thi B', '0912345678', 'b@gmail.com'),
('Le Van C', '0923456789', 'c@gmail.com'),
('Hoang Thi D', '0934567890', 'd@gmail.com'),
('Pham Van E', '0945678901', 'e@gmail.com'),
('Nguyen Thi F', '0956789012', 'f@gmail.com'),
('Do Van G', '0967890123', 'g@gmail.com'),
('Bui Thi H', '0978901234', 'h@gmail.com'),
('Tran Van I', '0989012345', 'i@gmail.com'),
('Le Thi J', '0990123456', 'j@gmail.com'),
('Vo Van K', '0902345678', 'k@gmail.com'),
('Nguyen Thi L', '0913456789', 'l@gmail.com'),
('Pham Van M', '0924567890', 'm@gmail.com'),
('Bui Thi N', '0935678901', 'n@gmail.com'),
('Le Van O', '0946789012', 'o@gmail.com');

#### thêm dữ liệu bảng BorrowingRecords
INSERT INTO BorrowingRecords (borrow_date, return_date, book_id, reader_id)
VALUES 
    ('2024-08-01', '2024-08-15', 1, 1),
    ('2024-08-02', '2024-08-16', 2, 2),
    ('2024-08-03', '2024-08-17', 1, 3),
    ('2024-08-04', '2024-08-18', 4, 2),
    ('2024-08-05', '2024-08-19', 5, 5),
    ('2024-08-06', '2024-08-20', 2, 2),
    ('2024-08-07', '2024-08-21', 1, 7),
    ('2024-08-08', '2024-08-22', 3, 3),
    ('2024-08-09', '2024-08-23', 3, 9),
    ('2024-08-10', '2024-08-24', 1, 3),
    ('2024-08-11', '2024-08-25', 4, 3),
    ('2024-08-12', '2024-08-26', 1, 12),
    ('2024-08-13', '2024-08-27', 3, 3),
    ('2024-08-14', '2024-08-28', 1, 14),
    ('2024-08-15', '2024-08-29', 3, 15);

#### Yêu cầu 1 (Sử dụng lệnh SQL để truy vấn cơ bản):
#### 1. Viết truy vấn SQL để lấy thông tin tất cả các giao dịch mượn sách, bao gồm tên sách,tên độc giả,ngày mượn và ngày trả
select b.book_title  "Tên Sách",rd.name  "Tên Độc Giả",br.borrow_date  "Ngày Mượn",br.return_date  "Ngày Trả" from BorrowingRecords br join Books b 
on br.book_id = b.book_id
join Readers rd 
on br.reader_id = rd.id;

####  2.Viết truy vấn SQL để tìm tất cả các sách mà độc giả bất kỳ đã mượn (ví dụ độc giả có tên Nguyễn Văn A)
select b.book_title  "Tên Sách",rd.name  "Tên Độc Giả",br.borrow_date  "Ngày Mượn",br.return_date  "Ngày Trả" from BorrowingRecords br join Books b 
on br.book_id = b.book_id
join Readers rd 
on br.reader_id = rd.id
where rd.name = 'Le Van c'; -- Nhập tên Độc giả muốn tìm vào

#### 3.Đếm số lần một cuốn sách đã được mượn
select b.book_title  "Tên Sách",COUNT(br.id)  "Số Lần Mượn" from BorrowingRecords br join Books b 
on br.book_id = b.book_id
group by b.book_title;

#### 4.Truy vấn tên của độc giả đã mượn nhiều sách nhất
select r.name  "Tên Học Giả",COUNT(br.id)  "Tổng Số Lần Mượn" from BorrowingRecords br join Readers r
on br.reader_id = r.id
group by r.name
order by COUNT(br.id) desc limit 1 ;

#### Yêu cầu 2 (Sử dụng lệnh SQL tạo View):
#### 1.Tạo một view tên là borrowed_books để hiển thị thông tin của tất cả các sách đã được mượn, bao gồm tên sách, tên độc giả, và ngày mượn. Sử dụng các bảng Books, Readers và BorrowingRecords.
create view borrowed_books as
select Books.book_title  'Tên Sách',Readers.name  'Tên Độc Giả',BorrowingRecords.borrow_date  'Ngày Mượn' from BorrowingRecords join Books 
on BorrowingRecords.book_id = Books.book_id
join Readers 
on BorrowingRecords.reader_id = Readers.id;

#### Yêu cầ 3 (Sử dụng lệnh SQL tạo thủ tục Stored Procedure)
####  1.Viết một thủ tục tên là get_books_borrowed_by_reader nhận một tham số là reader_id .Thủ tục này sẽ trả về danh sách các sách mà độc giả đó đã mượn,bao gồm tên sách và ngày mượn.
delimiter //
create procedure get_books_borrowed_by_reader(reader_id int)
begin
    select Books.book_title  'Tên Sách',BorrowingRecords.borrow_date  'Ngày Mượn' from BorrowingRecords join Books 
    on BorrowingRecords.book_id = Books.book_id
    where BorrowingRecords.reader_id = reader_id;
end; //
call get_books_borrowed_by_reader(5);  -- điển vào số ID mà bạn muốn tìm kiếm

