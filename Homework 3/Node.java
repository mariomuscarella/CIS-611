class Node {
  static final int m = 5; 
  static final int mkey = m-1;
  static final int mnkey = m/2;

  Node parent=null; 

  int count=0;      

  Comparable [] key = new Comparable[m];

  Node [] child =  new Node[m];

  Node(Comparable k, Node P,Node r) {
    key[1] =k;   
    child[0]=P;
    child[1]=r;
    parent=null;
    if (P !=null) {P.parent=r.parent=this;}
    count++;
  }

  Node(){}

  public String toString() {
    String s=new String("[ ");
    for (int i=1;i<=count;i++)
      s=s.concat(key[i] + " ");
    return s;
  }

  int search(Comparable k) {
    if (k.compareTo(key[1])<0)
      return 0;
    else {
      int w = count;
      while ((k.compareTo(key[w]) < 0) && (w > 1)) w--;
      return w;
    }
  }

  int isIn(Comparable k) {
    if (k.compareTo(key[1])<0)
        return 0;
    else    {
      int w = count;
      while (w >= 1 && k.compareTo(key[w]) != 0) w--;
      return w;
    }
  }

  Node insert (Comparable k, Node right) {
    Node yright=null;
    int p=search(k);
    if (count < mkey) {
      count++;
      for(int i=count;i>p+1;i--) {
        key[i]=key[i-1];child[i]=child[i-1];
      }
      key[p+1]=k;
      child[p+1]=right;
      if (right !=null) right.parent=this;
    }
   else {
      yright = new Node();
      yright.parent=parent;  
      if (p < mnkey) {
        for (int i=mnkey, j=0;i<=count;i++,j++) {
          yright.key[j]=key[i];
          yright.child[j]=child[i];
          if (yright.child[j] != null) yright.child[j].parent=yright;
        }
        count=mnkey-1;
        insert(k,right);
        yright.count=mkey - mnkey;
      }
      else if (p == mnkey) {
        
        for (int i=mnkey+1, j=1;i<=count;i++,j++) {
          yright.key[j]=key[i];
          yright.child[j]=child[i];
          if (yright.child[j] != null) yright.child[j].parent=yright;
        }
        yright.key[0]=k;
        yright.child[0]=right;
        if (right != null) right.parent=yright;
        count=mnkey;
        yright.count=mkey - mnkey;
      }
      else {
        for (int i=mnkey+1, j=0;i<=count;i++,j++) {
          yright.key[j]=key[i];
          yright.child[j]=child[i];
          if (yright.child[j] != null) yright.child[j].parent=yright;
        }
        count=mnkey;
        yright.count=mkey - mnkey - 1;
        yright.insert(k,right);
      }
    }
    return yright;
  }
}