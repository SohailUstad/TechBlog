<%-- 
    Document   : show_posts_detail
    Created on : Dec 2, 2021, 12:32:44 PM
    Author     : susta
--%>
<%@page import="com.tech.blog.entities.Message"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.tech.blog.entities.Catogries"%>
<%@page import="com.tech.blog.entities.Posts"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="com.tech.blog.dao.PostDao"%>
<%@page import="com.tech.blog.entities.User"%>
<%@page errorPage="error_page.jsp" %>
<%

    User user = (User) session.getAttribute("currentUser");
    if (user == null) {
        response.sendRedirect("login_page.jsp");
    }

%>
<%    int postId = Integer.parseInt(request.getParameter("post_id"));
    PostDao pdao = new PostDao(ConnectionProvider.getConnection());
    Posts p = pdao.getPostByPostId(postId);

%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <link href="css/mystyle.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <style>
            .banner-background{
                clip-path: polygon(30% 0%, 70% 0%, 100% 0, 100% 94%, 52% 100%, 29% 91%, 0 100%, 0 0);

            }
        </style>
        <title><%= p.getpTitle()%></title>
    </head>
    <body>
        <!<!-- Nav-bar -->

        <nav class="navbar navbar-expand-lg navbar-dark primary-background">
            <a class="navbar-brand" href="index.jsp"> <span class="fa fa-asterisk"></span> TechBlog</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item active">
                        <a class="nav-link" href="#"><span class="fa fa-bell-o"></span>LearnCode With Sohail <span class="sr-only">(current)</span></a>
                    </li>

                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <span class="fa fa-briefcase"></span>Categories
                        </a>
                        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                            <a class="dropdown-item" href="#">Programming Languages</a>
                            <a class="dropdown-item" href="#">Data Structures</a>
                            <div class="dropdown-divider"></div>
                            <a class="dropdown-item" href="#">Project Implementation</a>
                        </div>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#"><span class="fa fa-address-book-o"></span>Contact</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#"  data-toggle="modal" data-target="#add-post-modal"><span class="fa fa-address-book-o"></span>Post</a>
                    </li>

                </ul>
                <ul class="navbar-nav mr-right">
                    <li class="nav-item">
                        <a class="nav-link" href="#!" data-toggle="modal" data-target="#profileModal"><span class="	fa fa-user-circle"></span> <%= user.getName()%></a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link" href="LogOutServlet"><span class="	fa fa-user-plus"></span>LogOut</a>
                    </li>
                </ul>

            </div>
        </nav>


        <!-- Nav-bar CLose -->

        <%

            Message m = (Message) session.getAttribute("msg");
            if (m != null) {
        %>

        <div class="alert alert-danger" role="alert">
            <%= m.getContent()%>
        </div>
        <%
            }

            session.removeAttribute("msg");
        %>


        


        <!-- Start of model -->

        <!-- Modal -->
        <div class="modal fade" id="profileModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header primary-background text-white">
                        <h5 class="modal-title" id="exampleModalLabel">TechBlog</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="container text-center">
                            <img src="pics/<%= user.getProfile()%>" style="border-radius: 50%;max-width: 150px;">
                            <h5 class="modal-title mt-3" id="exampleModalLabel"><%= user.getName()%></h5>

                            <!-- Detaile -->

                            <div id="profile-detailes">
                                <table class="table">
                                    <tbody>
                                        <tr>
                                            <th scope="row">ID :</th>
                                            <td><%= user.getUserId()%></td>

                                        </tr>
                                        <tr>
                                            <th scope="row">Email</th>
                                            <td><%= user.getEmail()%></td>

                                        </tr>
                                        <tr>
                                            <th scope="row">Gender</th>
                                            <td><%= user.getGender()%></td>

                                        </tr>
                                        <tr>
                                            <th scope="row">About</th>
                                            <td><%= user.getAbout()%></td>

                                        </tr>
                                        <tr>
                                            <th scope="row">Registration</th>
                                            <td><%= user.getRdate()%></td>

                                        </tr>
                                    </tbody>
                                </table>
                            </div>

                            <div style="display: none;" id="profile-edit">

                                <h2>Please Edit Carefully</h2>
                                <form action="EditServlet" method="post" enctype="multipart/form-data">
                                    <table class="table">
                                        <tr>
                                            <td>ID :</td>
                                            <td><%= user.getUserId()%></td>
                                        </tr>
                                        <tr>
                                            <td>Email :</td>
                                            <td><input class="form-control" type="email" name="user_email" value="<%= user.getEmail()%>" ></td>
                                        </tr>
                                        <tr>
                                            <td>Name :</td>
                                            <td><input class="form-control" type="text" name="user_name" value="<%= user.getName()%>" ></td>
                                        </tr>
                                        <tr>
                                            <td>Password :</td>
                                            <td><input class="form-control" type="Password" name="user_password" value="<%= user.getPassword()%>" ></td>
                                        </tr>
                                        <tr>
                                            <td>Gender :</td>
                                            <td><%= user.getGender().toUpperCase()%></td>
                                        </tr>
                                        <tr>
                                            <td>About :</td>
                                            <td> 
                                                <textarea name="user_about" rows="3" class="form-control"><%= user.getAbout()%></textarea>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Select Profile Image :</td>
                                            <td> 
                                                <input type="file" class="form-control" name="user_image">
                                            </td>
                                        </tr>
                                    </table>
                                    <div class="container">
                                        <button class="btn btn-outline-primary" type="submit">Save</button>
                                    </div>
                                </form>

                            </div>

                            <!-- Detailes Close -->

                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        <button id="edit-profile-button" type="button" class="btn btn-primary">Edit</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- End Of model -->

        <!--add post modal-->




        <!-- Modal -->
        <div class="modal fade" id="add-post-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Provide the post details</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form id="add-post-form" action="AddPostServlet" method="post">


                            <div class="form-group">
                                <select class="form-control" name="cid">
                                    <option selected disabled>---select category---</option>
                                    <%

                                        PostDao postd = new PostDao(ConnectionProvider.getConnection());
                                        ArrayList<Catogries> list = postd.getAllCatogries();
                                        for (Catogries c : list) {

                                    %>


                                    <option value="<%= c.getCid()%>"><%= c.getName()%></option>

                                    <%}%>
                                </select>

                            </div>


                            <div class="form-group">
                                <input type="text" placeholder="Enter post title here" class="form-control" name="pTitle" autocomplete="off">
                            </div>
                            <div class="form-group">
                                <textarea class="form-control" placeholder="Enter your content here" name="pContent"></textarea>
                            </div>
                            <div class="form-group">
                                <textarea class="form-control" placeholder="Enter your program code here" name="pCode"></textarea>
                            </div>
                            <div class="form-group">
                                <label>Upload image</label><br>
                                <input class="form-control" type="file" name="pic">
                            </div>


                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                <button type="submit" class="btn btn-primary">Post</button>
                            </div>

                        </form>
                    </div>

                </div>
            </div>
        </div>


        <!--end of post modal-->


        <!-- javascript -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
        <script>
                                $(document).ready(function () {
                                    let editStatus = false;
                                    $('#edit-profile-button').click(function () {
                                        if (editStatus == false) {
                                            $('#profile-detailes').hide();
                                            $('#profile-edit').show();
                                            $(this).text("Back");
                                            editStatus = true;
                                        } else {
                                            $('#profile-detailes').show();
                                            $('#profile-edit').hide();
                                            $(this).text("Edit");
                                            editStatus = false;

                                        }
                                    });
                                });
        </script>

        <script>

            $(document).ready(function (e) {
                $("#add-post-form").on("submit", function (event) {
                    event.preventDefault();
                    alert("submitted")
                    let form = new FormData(this);

                    $.ajax({
                        url: "AddPostServlet",
                        type: 'POST',
                        data: form,
                        success: function (data, textStatus, jqXHR) {
                            console.log(data);
                            if (data.trim() == 'successful') {
                                swal("Good job!", "Saved Successfully", "success");
                            } else {
                                swal("Error!!", "Something went wrong please try again", "error");
                            }
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            swal("Error!!", "Something went wrong please try again", "error");
                        },
                        contentType: false,
                        processData: false

                    });
                });
            });

        </script>
        
    </body>
</html>
