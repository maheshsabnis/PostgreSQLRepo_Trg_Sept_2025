-- Create a new role named appadmin
/*
LOGIN: Allows the role to log in (i.e., act as a user).

PASSWORD: Sets the password for login.
*/
Create role appadmin with Login Password 'secure_password';

-- Create a User and Assign the Role
Create user mahesh with password 'P@ssw0rd_';
-- Grant the appadmin role to the user mahesh
Grant appadmin to mahesh;

