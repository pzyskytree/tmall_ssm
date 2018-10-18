# Tmall_SSM

This is a Java web project which imitates the famous Chinese online shopping website Tmall. It supports all the major functions of any shopping websites, such as user register, login, logout, list products by category, search by key word, check product in detail and it also implements the entire process of shopping, like add to cart, checkout, generate orders, keep track of orders, review products so on and so forth.

## Getting Started

Just like many Java project, before running it, we need to install Java and a suitable IDE on our PC.

### Prerequisites

Firstly, we need install Java JDK, JRE and set some environmental variables on our operating system. Below are some instructions.

[Install Java JDK in Windows](https://www.guru99.com/install-java.html)

[Install Java JDK in Ubuntu](https://thishosting.rocks/install-java-ubuntu/)

The next step is to select an IDE, I recommend to use Eclipse and IntelliJ IDEA, here are the links of download page.

[Download Eclipse](https://www.eclipse.org/downloads/) 

[Download IntelliJ IDEA](https://www.jetbrains.com/idea/specials/idea/ultimate.html?gclid=CjwKCAjwu5veBRBBEiwAFTqDwayjHjdCI4RosCJHAPG6U5t0AQgg1yx_d1HqvWEn0JwiNmx1Wv5JKRoCCKAQAvD_BwE&gclsrc=aw.ds&dclid=CPuHspnRjt4CFQWRswodIQMEVw) 

### Installing

After cloning the project into your local machine, you need to add it into your IDE as a project. 

Take IntelliJ IDEA as an example,  click File->Open File or Project, select the "pom.xml", which will open the project with Maven. 

To run the project, you need install Maven at first:

[install maven in Windows](https://www.mkyong.com/maven/how-to-install-maven-in-windows/)

[install maven in Ubunto](https://www.mkyong.com/maven/how-to-install-maven-in-ubuntu/)

Then in the Run/Debug configuration page, you need to add a maven builder.

Set the setting file and repository as the folder where you install the maven, like:

```
mavenFolder\.m2\settings.xml
mavenFolder\.m2\repository
```

I use tomcat as server and listen to the 8080 port, to start the server, set the command line parameter as:

```
tomcat7:run
```

Once you start the server, you can visit the home page, by typing the URL on your browser: 

```
http://localhost:8080/tmall_ssm/home
```

## Code Structure

This system is quite complex, so I separate them into several folders.

### Back-End

The backend is implemented with Java and all the codes are in the **org.pzy.tmall** source folders. Based their function and responsibility, they are distributed into 6 sub-directories.

* controller : contain all the Spring MVC controllers, which directly handle the HTTP request.
* interceptor: check user login status, being called before requests are handled by controller.
* mapper:  a series of interfaces, used to execute SQL command defined in .xml files to CRUD on data.
* pojo: all the data types, which are in accord with the data in database.
* service: define several APIs called by controller, handle business logic by using the method in mapper
* util: several utilities to process special data like uploaded image.

### Front-End

All the front end codes are written in .jsp files with Java, Vue.js, HTML, Bootstrap, jQuery. They are distributed in three folders；

* admin: all the codes for data management pages, which are only accessible for administrators.
* fore: pages available for customers.
* include: some pages that are integrated into the pages in previous folders, and some shared codes in different pages as well.

## Built With

* [Spring](https://spring.io/), [MyBatis](http://www.mybatis.org/mybatis-3/), [Spring MVC](https://docs.spring.io/spring/docs/current/spring-framework-reference/web.html)- The back-end web framework used
* [Vue.js](https://vuejs.org/), [jQuery](https://jquery.com/), [Bootstrap](https://getbootstrap.com/)- The front-end web framework used
* [Maven](https://maven.apache.org/) - Dependency Management

## Versioning

Version-1.0

## Authors

* Zeyu Pan *Initial work* - [Github](https://github.com/pzyskytree/)

## License

This project is licensed under the MIT License.
