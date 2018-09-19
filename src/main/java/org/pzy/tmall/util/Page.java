package org.pzy.tmall.util;

public class Page {
    private int start;
    private int count;
    private int total;
    private String param;

    private static final int defaultCount = 5;

    public int getStart() {
        return start;
    }

    public void setStart(int start) {
        this.start = start;
    }

    public int getCount() {
        return count;
    }

    public void setCount(int count) {
        this.count = count;
    }

    public int getTotal() {
        return total;
    }

    public void setTotal(int total) {
        this.total = total;
    }

    public String getParam() {
        return param;
    }

    public void setParam(String param) {
        this.param = param;
    }

    public Page(){
        count = defaultCount;
    }

    public Page(int start, int count){
        this.start = start;
        this.count = count;
    }

    public boolean isHasPrevious(){
        return start != 0;
    }

    public boolean isHasNext(){
        return (start + count) < total;
    }

    public int getTotalPage(){
        int page = total / count + (total % count == 0 ? 0 : 1);
        if (page == 0)
            page = 1;
        return page;
    }

    public int getLast(){
        int last = total - (total % count);
        if (total % count == 0){
            last = total - count;
        }
        return last < 0 ? 0 : last;
    }

    @Override
    public String toString() {
        return "Page [start=" + start + ", count=" + count + ", total=" + total + ", getStart()=" + getStart()
                + ", getCount()=" + getCount() + ", isHasPrevious()=" + isHasPrevious() + ", isHasNext()="
                + isHasNext() + ", getTotalPage()=" + getTotalPage() + ", getLast()=" + getLast() + "]";
    }



}
