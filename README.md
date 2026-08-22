# HARDTECH - SIMPLE PHP/CSS WEBSITE

Requirements:
- PHP 5.5+ (works with newer PHP versions too)
- MySQL
- Apache/XAMPP/WAMP/Laragon

1. Create a MySQL database named:
   hardtech

2. Import the provided hardtech.sql file into that database.

3. Put this folder inside your web server directory:
   XAMPP: htdocs/hardtech_shop
   WAMP: www/hardtech_shop

4. Open config.php and change:
   $host, $db, $user, $pass
   if your MySQL settings are different.

5. Open:
   http://localhost/hardtech_shop/

Main database tables used by this simple version:
- categories
- items
- sellers

The cart uses PHP sessions so JavaScript is not required.

No JS is used.

### Credits
- Saad Almalki
