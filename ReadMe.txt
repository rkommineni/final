README
Collaborators: Linda Xu and Rupa Kommineni
live host: calm-savannah-1810.herokuapp.com
github URL: https://github.com/rkommineni/final

Local Version v. Live Host
local version uses sqlite, so the gemfile, config/database.yml, app/models/book.rb are different between local version and live host due to different databases used.

Project Summary:
In this project,we built a platform for freelancers to write and publish their own books. 
As a registered user, a person is able to create a new book, add chapters to the book and edit and delete the book and chapters. For the simplicity of testing, we used content url as a substitute for chapter content. A registered user is also able to comment on each chapter, as well as rate and write reviews on each book. User is able to update and delete their reviews later on. But a user can only add and delete the comment. The reason that we do not provide update function for comment is due to the short length of a comment.
A registered user is also able to add books to wishlist and bookshelf. Wishlist holds the books that a user intends to read in the future while a bookshelf holds the books that a user has already finished reading but find it worth awhile to preserve and go back to in the future. 
As a non-registered user(reader), a person is able to read books, chapters, reviews, comments, together with viewing the book author's profile page. But the person cannot do any update, delete, or add functions. 
A person can also search for book by titles in the search box. 


Design Decisions:
We have decided to preserve "ghost books" (i.e. the books without authors). The ghost book is caused by an author deletes his/her own profile. The reason that we do not delete their books, and other publications is because we think the content remains a valuable asset even though the user has decided to quit our website. 
Although the wishlist and bookshelf overlap quite a bit in terms of development, we kept 2 separate categories for utility reasons. If we meshed these two together, it will be very difficult for users who have a large number of collections to dig through and find out which one is which. 
A book can have multiple authors. When a book is created by a user, this user will be the primary author. The primary author can add multiple authors to the book. Once an author is added to the book, it has the same privileges as the primary author. 
