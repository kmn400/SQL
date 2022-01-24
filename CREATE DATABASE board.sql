CREATE DATABASE board
    DEFAULT CHARACTER SET = 'utf8mb4';

CREATE TABLE date_list (
    date_id INT AUTO_INCREMENT comment '날짜번호',
    member_id INT NOT NULL comment '멤버의 기본키',
    photo_board_id INT NOT NULL comment '게시물의 기본키',
    PRIMARY KEY(date_id)
)ENGINE = INNODB DEFAULT character set utf8 collate utf8_general_ci;

CREATE TABLE member (
    member_id INT AUTO_INCREMENT comment '회원번호',
    id VARCHAR(10) NOT NULL comment '아이디',
    password VARCHAR(15) NOT NULL comment '비밀번호',
    name VARCHAR(10) NOT NULL comment '이름',
    sex INT NOT NULL comment '성별 0은 여자 1은 남자',
    phone VARCHAR(11) NOT NULL comment '전화번호',
    status INT DEFAULT 0 comment '상태 1은 삭제',
    PRIMARY KEY(member_id)
) ENGINE = INNODB DEFAULT character set utf8 collate utf8_general_ci;

CREATE TABLE photo_board (
    photo_board_id INT AUTO_INCREMENT comment '게시물번호',
    title VARCHAR(50) NOT NULL comment '제목',
    content TEXT(1500) NOT NULL comment '내용',
    image MEDIUMBLOB comment '이미지',
    member_id VARCHAR(10) NOT NULL comment '멤버 기본키',
    write_time DATETIME DEFAULT NOW() comment '현재 작성 시간',
    status INT DEFAULT 0 comment '상태 1은 삭제',
    PRIMARY KEY(photo_board_id)
) ENGINE = INNODB DEFAULT character set utf8 collate utf8_general_ci;

