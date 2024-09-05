-- drop table books;
-- drop table Readers;
-- drop table BorrowingRecords;
-- tạo bảng Books
create table Books(
book_id int auto_increment primary key, -- khóa chính
book_title varchar(100) not null, -- tên sách
book_author varchar(100) not null); -- tác giả
-- tạo bảng Readers
create table Readers(
id int auto_increment primary key, -- khóa chính
name varchar(150) not null, -- tên đọc giả
phone varchar(11) not null, -- số điện thoại của độc giả
email varchar(100)); -- email của độc giả
-- tạo bảng BorrowingRecords
create table BorrowingRecords(
id int auto_increment primary key, -- khóa chính
borrow_date date not null, -- ngày mượn sách
return_date date, -- ngày trả sách
book_id int not null, 
reader_id int not null);

-- thêm khóa phụ cho bảng BorrowingRecords
alter table BorrowingRecords
add foreign key (book_id) references books(book_id);
alter table BorrowingRecords
add foreign key (reader_id) references Readers(id);

-- tạo chỉ mục name trong bảng Readers
create unique index readers_name on readers(name);

-- thêm dữ liệu bảng books
INSERT INTO Books (book_title, book_author)
VALUES 
('Đắc Nhân Tâm', 'Dale Carnegie'),
('1984', 'George Orwell'),
('Cha giàu cha nghèo', 'Robert Kiyosaki'),
('Moby-Dick', 'Herman Melville'),
('Truyện Kiều', 'Nguyễn Du');

-- thêm dữ liệu bảng readers
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

-- thêm dữ liệu bảng BorrowingRecords
INSERT INTO BorrowingRecords (borrow_date, return_date, book_id, reader_id)
VALUES 
('2024-01-15', '2024-01-22', 1, 1),
('2024-02-10', NULL, 2, 2),
('2024-03-05', '2024-03-12', 3, 3);

-- Viết truy vấn SQL để lấy thông tin tất cả các giao dịch mượn sách, bao gồm tên sách,tên độc giả,ngày mượn và ngày trả
select b.book_title  "tên sách",r.name  "tên độc giả",br.borrow_date  "ngày mượn",br.return_date  "ngày trả"
from BorrowingRecords br
join Books b 
on br.book_id = b.book_id
join Readers r 
on br.reader_id = r.id;
--  Viết truy vấn SQL để tìm tất cả các sách mà độc giả bất kỳ đã mượn (ví dụ độc giả có tên Nguyễn Văn A)


