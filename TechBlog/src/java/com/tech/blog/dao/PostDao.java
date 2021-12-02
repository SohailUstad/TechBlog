package com.tech.blog.dao;

import com.tech.blog.entities.Catogries;
import com.tech.blog.entities.Posts;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PostDao {
    Connection con;

    public PostDao(Connection con) {
        this.con = con;
    }
    
    public ArrayList<Catogries> getAllCatogries(){
        ArrayList<Catogries> list=new ArrayList<>();
        
        try {
            String query="select * from catogries";
            Statement stmt=this.con.createStatement();
            ResultSet rs=stmt.executeQuery(query);
            
            while(rs.next()){
                int cid=rs.getInt("cid");
                String name=rs.getString("name");
                String desc=rs.getString("description");
                Catogries c=new Catogries(cid,name,desc);
                list.add(c);
            }
            
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return list;
    }
    
    public boolean savePost(Posts p){
        boolean flag=false;
        
        try {
            String query="insert into posts(pTitle,pContent,pCode,pPic,catId,userId) values(?,?,?,?,?,?)";
            PreparedStatement pstmt=this.con.prepareStatement(query);
            pstmt.setString(1, p.getpTitle());
            pstmt.setString(2, p.getpContent());
            pstmt.setString(3, p.getpCode());
            pstmt.setString(4, p.getpPic());
            pstmt.setInt(5, p.getCatId());
            pstmt.setInt(6, p.getUserId());
            pstmt.executeUpdate();
            flag=true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return flag;
    }
    
    public List<Posts> getAllPosts(){
        List<Posts> list=new ArrayList<Posts>();
        
        try {
            
            String query="select * from posts order by pid desc";
            PreparedStatement pstmt=this.con.prepareStatement(query);
            ResultSet rs=pstmt.executeQuery();
            
            while(rs.next()){
                int pid=rs.getInt("pid");
                String pTitle=rs.getString("pTitle");
                String pContent=rs.getString("pContent");
                String pCode=rs.getString("pCode");
                String pPic=rs.getString("pPic");
                Timestamp pDate=rs.getTimestamp("pDate");
                int catId=rs.getInt("catId");
                int userId=rs.getInt("userId");
                Posts post=new Posts(pid, pTitle, pContent, pCode, pPic, pDate, catId, userId);
                list.add(post);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return list;
    }
    
    public List<Posts> getPostsByCatId(int catId){
        List<Posts> list;
        list = new ArrayList<Posts>();
        
        try {
            
            String query="SELECT * FROM posts WHERE catId=? order by pid desc;";
            PreparedStatement pstmt=this.con.prepareStatement(query);
            pstmt.setInt(1, catId);
            ResultSet rs=pstmt.executeQuery();
            
            while(rs.next()){
                int pid=rs.getInt("pid");
                String pTitle=rs.getString("pTitle");
                String pContent=rs.getString("pContent");
                String pCode=rs.getString("pCode");
                String pPic=rs.getString("pPic");
                Timestamp pDate=rs.getTimestamp("pDate");
                int userId=rs.getInt("userId");
                Posts post=new Posts(pid, pTitle, pContent, pCode, pPic, pDate, catId, userId);
                list.add(post);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return list;
    }
    
    public Posts getPostByPostId(int postId){
        Posts post=null;
        try {
            
            String query="SELECT * FROM posts WHERE pid=?;";
            PreparedStatement pstmt=this.con.prepareStatement(query);
            pstmt.setInt(1, postId);
            ResultSet rs=pstmt.executeQuery();
            
            while(rs.next()){
                int catId=rs.getInt("catId");
                String pTitle=rs.getString("pTitle");
                String pContent=rs.getString("pContent");
                String pCode=rs.getString("pCode");
                String pPic=rs.getString("pPic");
                Timestamp pDate=rs.getTimestamp("pDate");
                int userId=rs.getInt("userId");
                post=new Posts(postId, pTitle, pContent, pCode, pPic, pDate, catId, userId);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return post;
    }
    
}
