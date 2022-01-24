
/* 0. 테이블 구성 쿼리*/
CREATE DATABASE board
    DEFAULT CHARACTER SET = 'utf8mb4';

/*날짜 기준 게시물 관리 쿼리
    -> 회원 정보 테이블과 사진 게시판 테이블을 담아,
    날짜 기준으로 정리해주는 상위 테이블.

    (내가 생각한 것 : date_list 테이블 안에 회원과 게시판 정보를 담아,
    날짜를 기준으로 정리하고자 함.)*/
CREATE TABLE date_list (
    date_id INT AUTO_INCREMENT comment '날짜번호',
    member_id INT NOT NULL comment '멤버의 기본키',
    photo_board_id INT NOT NULL comment '게시물의 기본키',
    PRIMARY KEY(date_id)
)ENGINE = INNODB DEFAULT character set utf8 collate utf8_general_ci;

/*회원 정보 테이블 생성 쿼리*/
CREATE TABLE member (
    member_id INT AUTO_INCREMENT comment '회원번호',
    _id VARCHAR(10) NOT NULL comment '아이디',
    password VARCHAR(15) NOT NULL comment '비밀번호',
    name VARCHAR(10) NOT NULL comment '이름',
    sex INT NOT NULL comment '성별 0은 여자 1은 남자',
    phone VARCHAR(11) NOT NULL comment '전화번호',
    status INT DEFAULT 0 comment '상태 1은 삭제',
    PRIMARY KEY(member_id)
) ENGINE = INNODB DEFAULT character set utf8 collate utf8_general_ci;

/*사진 게시판 테이블 생성 쿼리*/
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

/* 1. 회원가입 쿼리*/
/*아이디 중복 체크*/
SELECT 
    count(*)
FROM
    member
WHERE
    _id = 'abc1233';

/*중복된 아이디가 없다면 member 테이블에 insert*/
INSERT INTO member
    (_id, password, name, sex, phone)
VALUES
    ('abc123', '123456789', '홍길동', 0, '01098761234');

/* 2. 게시판 리스트 쿼리*/
SELECT
    (SELECT _id FROM member WHERE _id = board.member_id) as id,
    board.title,
    (SELECT name FROM member WHERE _id = board.member_id) as writer,
    board.write_time
FROM
    photo_board as board
WHERE
    board.status = 0
ORDER BY
    board.write_time DESC,
    board.photo_board_id DESC
LIMIT
    0, 20;

/*작성자 이름 검색 기능 추가*/
SELECT
    (SELECT _id FROM member WHERE _id = board.member_id) as id,
    board.title,
    (SELECT name FROM member WHERE _id = board.member_id) as writer,
    board.write_time
FROM
    photo_board as board
WHERE
    board.status = 0
AND
    name = '홍길동'/* 작성자 이름 검색 조건문 작성 어려움*/
ORDER BY
    board.write_time DESC,
    board.photo_board_id DESC
LIMIT
    0, 20;

/*제목 검색 기능 추가*/
SELECT
    (SELECT _id FROM member WHERE _id = board.member_id) as id,
    board.title,
    (SELECT name FROM member WHERE _id = board.member_id) as writer,
    board.write_time
FROM
    photo_board as board
WHERE
    board.status = 0
AND
    board.title LIKE '%제목%'
ORDER BY
    board.write_time DESC,
    board.photo_board_id DESC
LIMIT
    0, 20;

/*게시물 등록 쿼리*/
INSERT INTO photo_board
    (title, content, member_id, image) /*id를 어떻게 insert해야 하는지 모르겠음*/
VALUES
    ('제목1', '내용1', 'abcd123', image['killer.jpg']); /* 이미지 파일을 어떻게 넣어야 하는지 모르겠음*/


/*게시물 삭제 쿼리*/
SELECT
    COUNT(*)
FROM
    photo_board as board
WHERE
    board.status = 0
AND
    board.photo_board_id = 1
AND
    board.member_id = 33;

UPDATE
    photo_board
SET
    status = 1
WHERE
    photo_board.photo_board_id = 1;

/*게시물 수정 쿼리*/
SELECT
    COUNT(*)
FROM
    photo_board
WHERE
    photo_board.status = 0
AND
    photo_board.photo_board_id = 2
AND
    photo_board.member_id = 44;

UPDATE
    photo_board
SET
    title = '수정 제목',
    content = '수정 내용'
WHERE
    photo_board.photo_board_id = 2;
