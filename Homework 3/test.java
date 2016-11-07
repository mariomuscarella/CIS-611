public class test {
  public static void main(String[] arg) {
    Btree bplus= new Btree();
    bplus.add("25");
  
    bplus.add("50");
    
    bplus.add("75");
    
    bplus.add("05");
    
    bplus.add("10");
    
    bplus.add("15");
    
    bplus.add("20");
    
    bplus.add("25");
    
    bplus.add("28");
    
    bplus.add("30");
    
    bplus.add("50");
    
    bplus.add("55");
    
    bplus.add("60");
    
    bplus.add("75");
    
    bplus.add("85");
    
    bplus.add("80");
    
    bplus.add("90");
    
    bplus.add("65");
    
    System.out.println("************* After initial fill *************");
    bplus.tree();
    
    bplus.add("28");
    
    bplus.add("70");
    
    bplus.add("95");
    
    System.out.println("************* After insterting *************");
    bplus.tree();
    
   
    
  }
}