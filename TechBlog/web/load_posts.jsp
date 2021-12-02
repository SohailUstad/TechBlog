<%@page import="com.tech.blog.dao.UserDao"%>
<%@page import="com.tech.blog.entities.User"%>
<%@page import="com.tech.blog.entities.Posts"%>
<%@page import="java.util.List"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="com.tech.blog.dao.PostDao"%>
<div class="row">
    <%
//        Thread.sleep(100);
        PostDao postd = new PostDao(ConnectionProvider.getConnection());
        int cid = Integer.parseInt(request.getParameter("cid"));

        List<Posts> posts = null;
        UserDao userDao = new UserDao(ConnectionProvider.getConnection());

        if (cid == 0) {
            posts = postd.getAllPosts();
        } else {
            posts = postd.getPostsByCatId(cid);
        }

        if (posts.size() == 0) {
            out.print("<h3>No Post available in this category</h3>");
            return;
        }

        for (Posts p : posts) {
    %>
    <div class="col-md-6 mt-2">
        <div class="card">
            <img class="card-img-top" src="blog_pics/<%= p.getpPic()%>" alt="Card image cap" style="height: 250px;width:100%">
            <div class="card-body">
                <h4><%= p.getpTitle()%></h4>
                <p><%= p.getpContent()%></p>
                <div class="card-footer primary-background text-center">
                    <a href="" class="btn btn-outline-dark btn-sm"><i class="fa fa-thumbs-o-up"></i> <span>20</span></a>
                    <a href="show_posts_detail.jsp?post_id=<%= p.getpId() %>" class="btn btn-outline-dark btn-sm">Read More</a>
                    <a href="" class="btn btn-outline-dark btn-sm"><i class="fa fa-commenting-o"></i> <span>20</span></a>
                </div>
            </div>
        </div>
    </div>
    <%
        }
    %>
</div>