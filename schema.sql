CREATE TABLE MUSICIAN (
    nickname VARCHAR(16) UNIQUE NOT NULL,
    firstName VARCHAR(20) NOT NULL,
    lastName VARCHAR(20) NOT NULL, 
    e_mail VARCHAR(100) UNIQUE,
    locality VARCHAR(16) NOT NULL, 
    bestInstrument VARCHAR(16) NOT NULL,
    telephoneNumber VARCHAR(16) UNIQUE NOT NULL,
    isCertified BIT NOT NULL,
    isMaster BIT NOT NULL,
    PRIMARY KEY (nickname)
);

CREATE TABLE GENRE(
    genreName VARCHAR(16) UNIQUE NOT NULL,
    genreDescription VARCHAR(128) NOT NULL,
    origin VARCHAR(256) NOT NULL,
    nickname VARCHAR(16) NOT NULL FOREIGN KEY REFERENCES MUSICIAN
        ON DELETE CASCADE
        ON UPDATE NO ACTION,
    PRIMARY KEY (genreName); 
)

CREATE TABLE INFLUENCE(
    genreName VARCHAR(16) NOT NULL FOREIGN KEY REFERENCES MUSICIAN
        ON DELETE CASCADE
        ON UPDATE NO ACTION,
    nickname VARCHAR(16) NOT NULL FOREIGN KEY REFERENCES MUSICIAN
        ON DELETE CASCADE
        ON UPDATE NO ACTION,
    PRIMARY KEY (genreName, nickname)
)

CREATE TABLE FOLLOW(
    genreName VARCHAR(16) NOT NULL FOREIGN KEY REFERENCES MUSICIAN
        ON DELETE CASCADE
        ON UPDATE NO ACTION,
    nickname VARCHAR(16) NOT NULL FOREIGN KEY REFERENCES MUSICIAN
        ON DELETE CASCADE
        ON UPDATE NO ACTION,
    PRIMARY KEY (genreName, nickname)
)

CREATE TABLE DISCUSSION(
    discussionID INT UNIQUE NOT NULL,
    timestampDiscussion TIMESTAMP NOT NULL,
    title VARCHAR(16) NOT NULL,
    average INT NOT NULL,
    PRIMARY KEY (discussionID)
)

CREATE TABLE COMMENT(
    commentText VARCHAR(32) NOT NULL,
    timestampComment TIMESTAMP NOT NULL,
    commentID INT UNIQUE NOT NULL,
    discussionID INT NOT NULL FOREIGN KEY REFERENCES DISCUSSION 
        ON DELETE CASCADE
        ON UPDATE NO ACTION,
    PRIMARY KEY(commentID)
)

CREATE TABLE POST(
    discussionID INT NOT NULL FOREIGN KEY REFERENCES DISCUSSION 
        ON DELETE CASCADE
        ON UPDATE NO ACTION,

    commentID INT NOT NULL FOREIGN KEY REFERENCES COMMENT 
        ON DELETE CASCADE
        ON UPDATE NO ACTION,

    nickname VARCHAR(16) NOT NULL FOREIGN KEY REFERENCES MUSICIAN 
        ON DELETE CASCADE
        ON UPDATE NO ACTION,

    PRIMARY KEY(discussionID, commentID, nickname)
)

CREATE TABLE REACTION(
    nickname VARCHAR(16) NOT NULL FOREIGN KEY REFERENCES MUSICIAN 
        ON DELETE CASCADE
        ON UPDATE NO ACTION,
    discussionID INT NOT NULL FOREIGN KEY REFERENCES DISCUSSION 
        ON DELETE CASCADE
        ON UPDATE NO ACTION,
    vote ENUM('upvote', 'downvote'),
    dateAndTime TIMESTAMP NOT NULL,
    PRIMARY KEY (nickname, discussionID)
) 

CREATE TABLE HASHTAG(
    hashtagName VARCHAR(10) UNIQUE NOT NULL,
    nickname VARCHAR(16) NOT NULL FOREIGN KEY REFERENCES MUSICIAN 
        ON DELETE CASCADE
        ON UPDATE NO ACTION,
    PRIMARY KEY (hashtagName)
)

CREATE TABLE POST_REFERENCE(
    discussionID INT NOT NULL FOREIGN KEY REFERENCES DISCUSSION 
        ON DELETE CASCADE
        ON UPDATE NO ACTION,
    hashtagName VARCHAR(10) NOT NULL FOREIGN KEY REFERENCES HASHTAG
        ON DELETE CASCADE
        ON UPDATE NO ACTION,
    PRIMARY KEY(discussionID, hashtagName)
)

CREATE TABLE CHAT_PARTICIPANT(
    participantID INT UNIQUE NOT NULL,
    entryDate Date UNIQUE NOT NULL,
    exitDate Date,
    
)