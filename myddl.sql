

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';


DROP SCHEMA IF EXISTS dbms24;
CREATE SCHEMA dbms24;
USE dbms24;

CREATE TABLE recipes (
  recipe_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  recipe_name VARCHAR(45) NOT NULL,
  recipe_type ENUM(cooking, baking) NOT NULL,
  ethnic_cuisine_id INT UNSIGNED,
  `description` text NOT NULL,
  `level` TINYINT UNSIGNED NOT NULL CHECK (level BETWEEN 1 AND 5),
  tip1 TEXT,
  tip2 TEXT,
  tip3 TEXT,
  preparation_time TIME,
  cooking_time TIME,
  portion INT UNSIGNED NOT NULL,
  basic_ingredient_id INT UNSIGNED.
  PRIMARY KEY  (recipe_id),
  CONSTRAINT `fk_recipes_ethnic_cuisine` FOREIGN KEY (ethnic_cuisine_id) REFERENCES  ethnic_cuisine(ethnic_cuisine_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_recipes_ingredient` FOREIGN KEY (basic_ingredient_id) REFERENCES  ingredients(ingredient_id) ON DELETE RESTRICT ON UPDATE CASCADE

);

CREATE TABLE ethnic_cuisine (
  ethnic_cuisine_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  ethnic_cuisine_name VARCHAR(50) NOT NULL,
  PRIMARY KEY  (ethnic_cuisine_id),
);

CREATE TABLE meal (
    meal_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    meal_name VARCHAR(50) NOT NULL,
    PRIMARY KEY (meal_id)
);

CREATE TABLE recipe_Meals (
  recipe_id INT UNSIGNED NOT NULL,
  meal_id INT UNSIGNED NOT NULL,
  PRIMARY KEY (recipe_id, meal_id),
  CONSTRAINT fk_recipe_meals_recipes FOREIGN KEY (recipe_id) REFERENCES recipes(recipe_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_recipe_meals_meals` FOREIGN KEY (meal_id) REFERENCES meals(meal_id) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE tags (
  tag_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  tag_name VARCHAR(50) NOT NULL,
  PRIMARY KEY (tag_id)
);

CREATE TABLE recipe_Tags (
  recipe_id INT UNSIGNED NOT NULL,
  tag_id INT UNSIGNED NOT NULL,
  PRIMARY KEY (recipe_id, tag_id),
  CONSTRAINT `fk_recipe_tags_recipe` FOREIGN KEY (recipe_id) REFERENCES recipes(recipe_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_recipe_tags_tag` FOREIGN KEY (tag_id) REFERENCES tags(tag_id) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE equipment (
  equipment_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  equipment_name VARCHAR(50) NOT NULL,
  instructions TEXT NOT NULL
);

CREATE TABLE recipe_equipment (
  recipe_id INT UNSIGNED NOT NULL,
  equipment_id INT UNSIGNED NOT NULL,
  PRIMARY KEY (recipe_id, equipment_id),
  CONSTRAINT `fk_recipe_equipment_recipe` FOREIGN KEY (recipe_id) REFERENCES recipes(recipe_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_recipe_equipment_equipment` FOREIGN KEY (equipment_id) REFERENCES equipment(equipment_id) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE steps (
    step_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    recipe_id UNSIGNED NOT NULL,
    instructions TEXT NOT NULL, 
    step_number int UNSIGNED NOT NULL,
    PRIMARY KEY (`step_id`),
    CONSTRAINT `fk_steps_recipe` FOREIGN KEY (`recipe_id`) REFERENCES `recipes`(`recipe_id`) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE ingredients (
    ingredient_id INT UNSIGNED AUTO_INCREMENT, 
    ingredient_name VARCHAR(50) NOT NULL,
    group_id INT UNSIGNED,
    PRIMARY KEY (ingredient_id),
    CONSTRAINT `fk_ingredients_group` FOREIGN KEY(group_id) REFERENCES food_group(group_id) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE recipe_ingredients (
   recipe_id INT UNSIGNED NOT NULL,
   ingredient_id  INT UNSIGNED NOT NULL,
   quantity  DECIMAL(10, 2) NOT NULL,
   unit  VARCHAR(50),
  PRIMARY KEY (recipe_id , ingredient_id),
  CONSTRAINT `fk_recipe_ingredients_recipe` FOREIGN KEY (recipe_id) REFERENCES recipes(recipe_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_recipe_ingredients_ingredient` FOREIGN KEY (ingredient_id) REFERENCES ingredients(ingredient_id) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE food_group ( 
    group_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    group_name VARCHAR(50) NOT NULL,
    description TEXT,
    PRIMARY KEY (group_id) 
);



