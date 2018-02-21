# Tracker

Design Choices:

Database tables:

1. Users - name, email
2. Taskdetails - title, description, completion status, time, user_id

Design choices - Functionality:

1. The app an be logged in with user name or email.
2. Once logged in, user can view the list of all the lists aassigned to him/her.
3. User can also view his details with the "Account details" link
4. "admin" user can view the list of all the tasks (irrespective assigned to anyone)
5. "admin" has rights to view the list of all the users
6. creating/editing a task has hours and minutes(15 min interval) input boxes. which accepts the use input  as hours and minutes, converts them into mintues and stores it to the database.
7. when showing the task details, the time is extracted from database and again segregated to hours and minutes to show it to the user for user convinience.
8. When the "admin" tries to delete the user, who has assigned tasks, error message is thrown. 
9. admin login credentials :
   name : admin
   email : admin@admin.com 
