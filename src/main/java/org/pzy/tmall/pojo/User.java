package org.pzy.tmall.pojo;

public class User {
    private Integer id;

    private String name;

    private String password;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password == null ? null : password.trim();
    }

    public String getAnonymousName(){
        if (null == this.name)
            return null;
        if (name.length() == 0)
            return "*";
        if (name.length() == 2)
            return name.substring(0, 1) + "*";
        char[] charArr = name.toCharArray();
        for (int i = 0; i < charArr.length; i++)
            charArr[i] = '*';
        return String.valueOf(charArr);
    }
}