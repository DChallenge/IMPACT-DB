
CREATE TABLE Country
(
  id           BIGINT  NOT NULL DEFAULT PK, AUTO_INCREMENT COMMENT '시스템 관리 ID',
  country_name VARCHAR NOT NULL DEFAULT UNIQUE COMMENT '나라 이름',
  PRIMARY KEY (id)
) COMMENT '나라';

CREATE TABLE Interest
(
  id            BIGINT  NOT NULL DEFAULT PK, AUTO_INCREMENT COMMENT '시스템 관리 ID',
  interest_name VARCHAR NOT NULL DEFAULT UNIQUE,
  PRIMARY KEY (id)
) COMMENT '관심 분야';

CREATE TABLE News
(
  id           BIGINT    NOT NULL DEFAULT PK, AUTO_INCREMENT COMMENT '시스템 관리 ID',
  title        VARCHAR   NOT NULL COMMENT '뉴스 제목 ',
  content      TEXT      NOT NULL COMMENT '뉴스 요약 내용',
  source_id    BIGINT    NOT NULL DEFAULT FK -> NewsSource(id) COMMENT '언론사 ID',
  category_id  BIGINT    NOT NULL DEFAULT FK -> NewsCategory(id) COMMENT '카테고리 ID',
  published_at DATETIME  NOT NULL COMMENT '뉴스 발행일',
  created_at   TIMESTAMP NOT NULL DEFAULT DEFAULT CURRENT_TIMESTAMP COMMENT '데이터 저장 날짜',
  PRIMARY KEY (id)
) COMMENT '뉴스';

CREATE TABLE NewsCategory
(
  id                 BIGINT  NOT NULL DEFAULT PK, AUTO_INCREMETNT COMMENT '시스템 관리 ID',
  news_category_name VARCHAR NOT NULL COMMENT '카테고리 이름',
  PRIMARY KEY (id)
) COMMENT '뉴스 카테고리';

CREATE TABLE NewsCrawlingMetadata
(
  id             BIGINT    NOT NULL DEFAULT PK, AUTO_INCREMENT COMMENT '시스템 관리 ID',
  news_id        BIGINT    NOT NULL DEFAULT FK -> News(id),
  crawl_source   VARCHAR   NOT NULL COMMENT '크롤링한 사이트',
  crawl_date     TIMESTAMP NOT NULL DEFAULT DEFAULT CURRENT_TIMESTAMP COMMENT '크롤링한 날짜',
  parsing_status ENUM      NOT NULL DEFAULT DEFAULT '실패' COMMENT '파싱 성공 여부',
  error_message  TEXT      NULL     COMMENT '크롤링 실패 시 오류 메시지',
  PRIMARY KEY (id)
) COMMENT '뉴스 크롤링 데이터';

CREATE TABLE NewsLikes
(
  id       BIGINT    NOT NULL DEFAULT PK, AUTO_INCREMENT COMMENT '시스템 관리 ID',
  user_id  BIGINT    NOT NULL DEFAULT FK -> User(id),
  news_id  BIGINT    NOT NULL DEFAULT FK -> News(id),
  liked_at TIMESTAMP NULL     DEFAULT DEFAULT CURRENT_TIMESTAMP COMMENT '좋아요 시간',
  PRIMARY KEY (id)
) COMMENT '뉴스 좋아요';

CREATE TABLE NewsRecommendation
(
  id         BIGINT    NOT NULL DEFAULT PK, AUTO_INCREMENT COMMENT '시스템 관리 ID',
  user_id    BIGINT    NOT NULL DEFAULT FK -> User(id),
  news_id    BIGINT    NOT NULL DEFAULT FK -> News(id),
  score      FLOAT     NOT NULL COMMENT '추천 점수 (높을수록 우선 추천)',
  created_at TIMESTAMP NOT NULL DEFAULT DEFAULT CURRENT_TIMESTAMP COMMENT '추천 생성일',
  PRIMARY KEY (id)
) COMMENT '뉴스 사용자 추천';

CREATE TABLE NewsScore
(
  id                BIGINT NOT NULL DEFAULT PK, AUTO_INCREMETNT COMMENT '시스템 관리 ID',
  news_id           BIGINT NOT NULL DEFAULT FK -> News(id),
  bias_score        FLOAT  NOT NULL COMMENT '성향 점수 (-1~1)',
  reliability_score FLOAT  NOT NULL COMMENT '신뢰도 점수 (0~1)',
  PRIMARY KEY (id)
) COMMENT '뉴스 평가 점수';

CREATE TABLE NewsShares
(
  id        BIGINT    NOT NULL DEFAULT PK, AUTO_INCREMENT COMMENT '시스템 관리 ID',
  user_id   BIGINT    NOT NULL DEFAULT FK -> User(id),
  news_id   BIGINT    NOT NULL DEFAULT FK -> News(id),
  shared_at TIMESTAMP NOT NULL DEFAULT DEFAULT CURRENT_TIMESTAMP COMMENT '공유 시간',
  PRIMARY KEY (id)
) COMMENT '뉴스 공유';

CREATE TABLE NewsSource
(
  id               BIGINT  NOT NULL DEFAULT PK, AUTO_INCREMETNT COMMENT '시스템 관리 ID',
  news_source_name VARCHAR NOT NULL DEFAULT UNIQUE COMMENT '언론사 이름',
  PRIMARY KEY (id)
) COMMENT '언론사 정보';

CREATE TABLE NewsViews
(
  id        BIGINT    NOT NULL DEFAULT PK, AUTO_INCREMENT COMMENT '시스템 관리 ID',
  user_id   BIGINT    NOT NULL DEFAULT FK -> User(id),
  news_id   BIGINT    NOT NULL DEFAULT FK -> News(id),
  viewed_at TIMESTAMP NOT NULL DEFAULT DEFAULT CURRENT_TIMESTAMP COMMENT '조회 시간',
  PRIMARY KEY (id)
) COMMENT '뉴스 조회';

CREATE TABLE Petition
(
  id         BIGINT    NOT NULL DEFAULT PK, AUTO_INCREMENT COMMENT '시스템 관리 ID',
  title      VARCHAR   NOT NULL COMMENT '청원 제목',
  content    TEXT      NOT NULL COMMENT '청원 내용',
  status     ENUM      NOT NULL COMMENT 'ENUM('진행 중', '종료')',
  started_at TIMESTAMP NOT NULL COMMENT '청원 시작 날짜',
  ended_at   TIMESTAMP NOT NULL COMMENT '청원 종료 날짜',
  PRIMARY KEY (id)
) COMMENT '청원';

CREATE TABLE petitionCrawlingMetadata
(
  id             BIGINT    NOT NULL DEFAULT PK, AUTO_INCREMENT COMMENT '시스템 관리 ID',
  petition_id    BIGINT    NOT NULL DEFAULT FK -> Petition(id),
  crawl_source   VARCHAR   NOT NULL COMMENT '크롤링한 사이트',
  crawl_date     TIMESTAMP NOT NULL DEFAULT DEFAULT CURRENT_TIMESTAMP COMMENT '크롤링한 날짜',
  parsing_status ENUM      NOT NULL DEFAULT DEFAULT '실패' COMMENT '파싱 성공 여부',
  error_message  TEXT      NULL     COMMENT '크롤링 실패 시 오류 메시지',
  PRIMARY KEY (id)
) COMMENT '청원 크롤링 데이터';

CREATE TABLE PetitionLikes
(
  id          BIGINT    NOT NULL DEFAULT PK, AUTO_INCREMENT COMMENT '시스템 관리 ID',
  user_id     BIGINT    NOT NULL DEFAULT FK -> User(id),
  petition_id BIGINT    NOT NULL DEFAULT FK -> Petition(id),
  liked_at    TIMESTAMP NOT NULL DEFAULT DEFAULT CURRENT_TIMESTAMP COMMENT '좋아요 시간',
  PRIMARY KEY (id)
) COMMENT '청원 좋아요';

CREATE TABLE PetitionRecommendation
(
  id          BIGINT    NOT NULL DEFAULT PK, AUTO_INCREMENT COMMENT '시스템 관리 ID',
  user_id     BIGINT    NOT NULL DEFAULT FK -> User(id),
  petition_id BIGINT    NOT NULL DEFAULT FK -> Petition(id),
  score       FLOAT     NOT NULL COMMENT '추천 점수 (높을수록 우선 추천)',
  created_at  TIMESTAMP NOT NULL DEFAULT DEFAULT CURRENT_TIMESTAMP COMMENT '추천 생성일',
  PRIMARY KEY (id)
) COMMENT '청원 맞춤 추천';

CREATE TABLE PetitionShares
(
  id          BIGINT    NOT NULL DEFAULT PK, AUTO_INCREMENT COMMENT '시스템 관리 ID',
  user_id     BIGINT    NOT NULL DEFAULT FK -> User(id),
  petition_id BIGINT    NOT NULL DEFAULT FK -> Petition(id),
  shared_at   TIMESTAMP NOT NULL DEFAULT DEFAULT CURRENT_TIMESTAMP COMMENT '공유 시간',
  PRIMARY KEY (id)
) COMMENT '청원 공유';

CREATE TABLE PetitionSimulation
(
  id          BIGINT NOT NULL DEFAULT PK, AUTO_INCREMENT COMMENT '시스템 관리 ID',
  petition_id BIGINT NOT NULL DEFAULT FK -> Petition(id),
  scenario    TEXT   NOT NULL,
  PRIMARY KEY (id)
) COMMENT '청원 시뮬레이션';

CREATE TABLE PetitionViews
(
  id          BIGINT    NOT NULL DEFAULT PK, AUTO_INCREMENT COMMENT '시스템 관리 ID',
  user_id     BIGINT    NOT NULL DEFAULT FK -> User(id),
  petition_id BIGINT    NOT NULL DEFAULT FK -> Petition(id),
  viewed_at   TIMESTAMP NOT NULL DEFAULT DEFAULT CURRENT_TIMESTAMP COMMENT '조회 시간',
  PRIMARY KEY (id)
) COMMENT '청원 조회';

CREATE TABLE PetitonVotes
(
  petiton_id BIGINT    NOT NULL DEFAULT PK, AUTO_INCREMENT, FK -> Petition(id) COMMENT '시스템 관리 ID',
  vote_count INT       NOT NULL DEFAULT DEFAULT 0,
  updated_at TIMESTAMP NOT NULL DEFAULT DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '마지막 업데이트 시간',
  PRIMARY KEY (petiton_id)
) COMMENT '청원 동의';

CREATE TABLE Policy
(
  id      BIGINT  NOT NULL DEFAULT PK, AUTO_INCREMENT COMMENT '시스템 관리 ID',
  title   VARCHAR NOT NULL COMMENT '정책 제목',
  content TEXT    NOT NULL COMMENT '정책 설명',
  status  ENUM    NOT NULL COMMENT 'ENUM('심사 중', '통과', '폐기')',
  PRIMARY KEY (id)
) COMMENT '정책';

CREATE TABLE PolicyCrawlingMetadata
(
  id             BIGINT    NOT NULL DEFAULT PK, AUTO_INCREMENT COMMENT '시스템 관리 ID',
  policy_id      BIGINT    NOT NULL DEFAULT FK -> Policy(id),
  crawl_source   VARCHAR   NOT NULL COMMENT '크롤링한 사이트',
  crawl_date     TIMESTAMP NOT NULL DEFAULT DEFAULT CURRENT_TIMESTAMP COMMENT '크롤링한 날짜',
  parsing_status ENUM      NOT NULL DEFAULT DEFAULT '실패' COMMENT '파싱 성공 여부',
  error_message  TEXT      NULL     COMMENT '크롤링 실패 시 오류 메시지',
  PRIMARY KEY (id)
) COMMENT '정책 크롤링 데이터';

CREATE TABLE PolicyLikes
(
  id        BIGINT    NOT NULL DEFAULT PK, AUTO_INCREMENT COMMENT '시스템 관리 ID',
  user_id   BIGINT    NOT NULL DEFAULT FK -> User(id),
  policy_id BIGINT    NOT NULL DEFAULT FK -> Policy(id),
  liked_at  TIMESTAMP NOT NULL DEFAULT DEFAULT CURRENT_TIMESTAMP COMMENT '좋아요 시간',
  PRIMARY KEY (id)
) COMMENT '정책 좋아요';

CREATE TABLE PolicyRecommendation
(
  id         BIGINT    NOT NULL DEFAULT PK, AUTO_INCREMENT COMMENT '시스템 관리 ID',
  user_id    BIGINT    NOT NULL DEFAULT FK -> User(id),
  policy_id  BIGINT    NOT NULL DEFAULT FK -> Policy(id),
  score      FLOAT     NOT NULL COMMENT '추천 점수 (높을수록 우선 추천)',
  created_at TIMESTAMP NOT NULL DEFAULT DEFAULT CURRENT_TIMESTAMP COMMENT '추천 생성일',
  PRIMARY KEY (id)
) COMMENT '정책 사용자 추천';

CREATE TABLE PolicyShares
(
  id        BIGINT    NOT NULL DEFAULT PK, AUTO_INCREMENT COMMENT '시스템 관리 ID',
  user_id   BIGINT    NOT NULL DEFAULT FK -> User(id),
  policy_id BIGINT    NOT NULL DEFAULT FK -> Policy(id),
  shared_at TIMESTAMP NOT NULL DEFAULT DEFAULT CURRENT_TIMESTAMP COMMENT '공유 시간',
  PRIMARY KEY (id)
) COMMENT '정책 공유';

CREATE TABLE PolicySimulation
(
  id        BIGINT NOT NULL DEFAULT PK, AUTO_INCREMENT COMMENT '시스템 관리 ID',
  policy_id BIGINT NOT NULL DEFAULT FK -> Policy(id),
  scenario  TEXT   NOT NULL,
  PRIMARY KEY (id)
) COMMENT '정책 시뮬레이션';

CREATE TABLE PolicyViews
(
  id        BIGINT    NOT NULL DEFAULT PK, AUTO_INCREMENT COMMENT '시스템 관리 ID',
  user_id   BIGINT    NOT NULL DEFAULT FK -> User(id),
  policy_id BIGINT    NOT NULL DEFAULT FK -> Policy(id),
  viewed_at TIMESTAMP NOT NULL DEFAULT DEFAULT CURRENT_TIMESTAMP COMMENT '조회 시간',
  PRIMARY KEY (id)
) COMMENT '정책 조회';

CREATE TABLE Region
(
  region_id   BIGINT  NOT NULL DEFAULT PK, AUTO_INCREMENT COMMENT '시스템 관리 ID',
  country_id  BIGINT  NOT NULL DEFAULT FK -> Country(id),
  region_name VARCHAR NOT NULL DEFAULT UNIQUE COMMENT '지역 이름',
  PRIMARY KEY (region_id)
) COMMENT '지역';

CREATE TABLE User
(
  id         BIGINT    NOT NULL DEFAULT PK, AUTO_INCREMENT COMMENT '시스템 관리 ID',
  email      VARCHAR   NOT NULL DEFAULT UNIQUE COMMENT '로그인 ID ',
  username   VARCHAR   NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT DEFAULT CURRENT_TIMESTAMP COMMENT '가입 날짜',
  updated_at TIMESTAMP NULL     DEFAULT DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '정보 수정 날짜',
  PRIMARY KEY (id)
) COMMENT '사용자';

CREATE TABLE UserInterests
(
  user_id     BIGINT NOT NULL DEFAULT PK, FK -> User(id),
  interest_id BIGINT NOT NULL DEFAULT PK, FK -> Interest(id),
  PRIMARY KEY (user_id, interest_id)
) COMMENT '사용자 관심사';

CREATE TABLE UserLocation
(
  user_id   BIGINT NOT NULL DEFAULT PK, FK -> User(id),
  region_id BIGINT NOT NULL DEFAULT FK -> Regkion(id),
  PRIMARY KEY (user_id, region_id)
) COMMENT '사용자 위치';

CREATE TABLE UserProfile
(
  user_id BIGINT NOT NULL DEFAULT PK, FK -> User(id),
  age     INT    NULL    ,
  gender  ENUM   NULL     COMMENT '('M', 'F', 'Other')',
  mbti    ENUM   NULL    ,
  PRIMARY KEY (user_id)
) COMMENT '사용자 프로필';

ALTER TABLE UserProfile
  ADD CONSTRAINT FK_User_TO_UserProfile
    FOREIGN KEY (user_id)
    REFERENCES User (id);

ALTER TABLE Region
  ADD CONSTRAINT FK_Country_TO_Region
    FOREIGN KEY (country_id)
    REFERENCES Country (id);

ALTER TABLE UserLocation
  ADD CONSTRAINT FK_User_TO_UserLocation
    FOREIGN KEY (user_id)
    REFERENCES User (id);

ALTER TABLE Region
  ADD CONSTRAINT FK_UserLocation_TO_Region
    FOREIGN KEY (region_id)
    REFERENCES UserLocation (region_id);

ALTER TABLE UserInterests
  ADD CONSTRAINT FK_Interest_TO_UserInterests
    FOREIGN KEY (interest_id)
    REFERENCES Interest (id);

ALTER TABLE UserInterests
  ADD CONSTRAINT FK_User_TO_UserInterests
    FOREIGN KEY (user_id)
    REFERENCES User (id);

ALTER TABLE News
  ADD CONSTRAINT FK_NewsSource_TO_News
    FOREIGN KEY (source_id)
    REFERENCES NewsSource (id);

ALTER TABLE News
  ADD CONSTRAINT FK_NewsCategory_TO_News
    FOREIGN KEY (category_id)
    REFERENCES NewsCategory (id);

ALTER TABLE NewsScore
  ADD CONSTRAINT FK_News_TO_NewsScore
    FOREIGN KEY (news_id)
    REFERENCES News (id);

ALTER TABLE NewsLikes
  ADD CONSTRAINT FK_User_TO_NewsLikes
    FOREIGN KEY (user_id)
    REFERENCES User (id);

ALTER TABLE NewsLikes
  ADD CONSTRAINT FK_News_TO_NewsLikes
    FOREIGN KEY (news_id)
    REFERENCES News (id);

ALTER TABLE NewsShares
  ADD CONSTRAINT FK_User_TO_NewsShares
    FOREIGN KEY (user_id)
    REFERENCES User (id);

ALTER TABLE NewsShares
  ADD CONSTRAINT FK_News_TO_NewsShares
    FOREIGN KEY (news_id)
    REFERENCES News (id);

ALTER TABLE NewsViews
  ADD CONSTRAINT FK_User_TO_NewsViews
    FOREIGN KEY (user_id)
    REFERENCES User (id);

ALTER TABLE NewsViews
  ADD CONSTRAINT FK_News_TO_NewsViews
    FOREIGN KEY (news_id)
    REFERENCES News (id);

ALTER TABLE PolicySimulation
  ADD CONSTRAINT FK_Policy_TO_PolicySimulation
    FOREIGN KEY (policy_id)
    REFERENCES Policy (id);

ALTER TABLE PolicyLikes
  ADD CONSTRAINT FK_User_TO_PolicyLikes
    FOREIGN KEY (user_id)
    REFERENCES User (id);

ALTER TABLE PolicyShares
  ADD CONSTRAINT FK_User_TO_PolicyShares
    FOREIGN KEY (user_id)
    REFERENCES User (id);

ALTER TABLE PolicyViews
  ADD CONSTRAINT FK_User_TO_PolicyViews
    FOREIGN KEY (user_id)
    REFERENCES User (id);

ALTER TABLE PolicyLikes
  ADD CONSTRAINT FK_Policy_TO_PolicyLikes
    FOREIGN KEY (policy_id)
    REFERENCES Policy (id);

ALTER TABLE PolicyShares
  ADD CONSTRAINT FK_Policy_TO_PolicyShares
    FOREIGN KEY (policy_id)
    REFERENCES Policy (id);

ALTER TABLE PolicyViews
  ADD CONSTRAINT FK_Policy_TO_PolicyViews
    FOREIGN KEY (policy_id)
    REFERENCES Policy (id);

ALTER TABLE PetitionLikes
  ADD CONSTRAINT FK_User_TO_PetitionLikes
    FOREIGN KEY (user_id)
    REFERENCES User (id);

ALTER TABLE PetitionShares
  ADD CONSTRAINT FK_User_TO_PetitionShares
    FOREIGN KEY (user_id)
    REFERENCES User (id);

ALTER TABLE PetitionViews
  ADD CONSTRAINT FK_User_TO_PetitionViews
    FOREIGN KEY (user_id)
    REFERENCES User (id);

ALTER TABLE PetitionLikes
  ADD CONSTRAINT FK_Petition_TO_PetitionLikes
    FOREIGN KEY (petition_id)
    REFERENCES Petition (id);

ALTER TABLE PetitionShares
  ADD CONSTRAINT FK_Petition_TO_PetitionShares
    FOREIGN KEY (petition_id)
    REFERENCES Petition (id);

ALTER TABLE PetitionViews
  ADD CONSTRAINT FK_Petition_TO_PetitionViews
    FOREIGN KEY (petition_id)
    REFERENCES Petition (id);

ALTER TABLE PetitonVotes
  ADD CONSTRAINT FK_Petition_TO_PetitonVotes
    FOREIGN KEY (petiton_id)
    REFERENCES Petition (id);

ALTER TABLE PetitionSimulation
  ADD CONSTRAINT FK_Petition_TO_PetitionSimulation
    FOREIGN KEY (petition_id)
    REFERENCES Petition (id);

ALTER TABLE NewsRecommendation
  ADD CONSTRAINT FK_User_TO_NewsRecommendation
    FOREIGN KEY (user_id)
    REFERENCES User (id);

ALTER TABLE PolicyRecommendation
  ADD CONSTRAINT FK_User_TO_PolicyRecommendation
    FOREIGN KEY (user_id)
    REFERENCES User (id);

ALTER TABLE PetitionRecommendation
  ADD CONSTRAINT FK_User_TO_PetitionRecommendation
    FOREIGN KEY (user_id)
    REFERENCES User (id);

ALTER TABLE NewsRecommendation
  ADD CONSTRAINT FK_News_TO_NewsRecommendation
    FOREIGN KEY (news_id)
    REFERENCES News (id);

ALTER TABLE PolicyRecommendation
  ADD CONSTRAINT FK_Policy_TO_PolicyRecommendation
    FOREIGN KEY (policy_id)
    REFERENCES Policy (id);

ALTER TABLE PetitionRecommendation
  ADD CONSTRAINT FK_Petition_TO_PetitionRecommendation
    FOREIGN KEY (petition_id)
    REFERENCES Petition (id);

ALTER TABLE NewsCrawlingMetadata
  ADD CONSTRAINT FK_News_TO_NewsCrawlingMetadata
    FOREIGN KEY (news_id)
    REFERENCES News (id);

ALTER TABLE PolicyCrawlingMetadata
  ADD CONSTRAINT FK_Policy_TO_PolicyCrawlingMetadata
    FOREIGN KEY (policy_id)
    REFERENCES Policy (id);

ALTER TABLE petitionCrawlingMetadata
  ADD CONSTRAINT FK_Petition_TO_petitionCrawlingMetadata
    FOREIGN KEY (petition_id)
    REFERENCES Petition (id);
