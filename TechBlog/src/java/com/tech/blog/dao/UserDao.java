
package com.tech.blog.dao;
import com.tech.blog.entities.User;
import java.sql. *;

public class UserDao {
    private Connection con;

    public UserDao(Connection con) {
        this.con = con;
    }
    
    // Method to insert user to database
    public boolean saveUser(User user ){
        boolean f=false;
        try {
            String query="insert into user(name,email,password,gender,about) values(?,?,?,?,?)";
            PreparedStatement pstmt = this.con.prepareStatement(query);
            pstmt.setString(1, user.getName());
            pstmt.setString(2, user.getEmail());
            pstmt.setString(3, user.getPassword());
            pstmt.setString(4, user.getGender());
            pstmt.setString(5, user.getAbout());
            pstmt.executeUpdate();
            f=true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }
    
    //Get user by username and userpassword
    public User getUserByEmailAndPassword(String email,String password){
        User user=null;
        
        try {
            
            String query="select * from user where email=? and password=?";
            PreparedStatement pstmt = this.con.prepareStatement(query);
            pstmt.setString(1,email);
            pstmt.setString(2,password);
            ResultSet set = pstmt.executeQuery();
            
            if(set.next()){
                user = new User();
                user.setName(set.getString("name"));
                user.setEmail(set.getString("email"));
                user.setAbout(set.getString("about"));
                user.setUserId(set.getInt("userId"));
                user.setGender(set.getString("gender"));
                user.setPassword(set.getString("password"));
                user.setRdate(set.getTimestamp("rdate"));
                user.setProfile(set.getString("profile"));
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }
    
    public boolean updateUser(User user){
        boolean f=false;
        try {
            String query="update user set name=?,email=?,password=?,gender=?,about=?,profile=? where userId=?";
            PreparedStatement p=con.prepareStatement(query);
            p.setString(1, user.getName());
            p.setString(2, user.getEmail());
            p.setString(3, user.getPassword());
            p.setString(4, user.getGender());
            p.setString(5, user.getAbout());
            p.setString(6, user.getProfile());
            p.setInt(7, user.getUserId());
            p.executeUpdate();
            f=true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }
    
    public User getUserByUserId(int uId){
        User user=null;
        
        try {
            
            String query="select * from user where userId=?";
            PreparedStatement pstmt = this.con.prepareStatement(query);
            pstmt.setInt(1,uId);
            ResultSet set = pstmt.executeQuery();
            
            if(set.next()){
                user = new User();
                user.setName(set.getString("name"));
                user.setEmail(set.getString("email"));
                user.setAbout(set.getString("about"));
                user.setUserId(set.getInt("userId"));
                user.setGender(set.getString("gender"));
                user.setPassword(set.getString("password"));
                user.setRdate(set.getTimestamp("rdate"));
                user.setProfile(set.getString("profile"));
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }
    
}
