public class Btree {
  Node root_=null;
  Btree() {}

  void tree () {
    dis(root_,1); 
  }

  public String toString() {
    return "{ " + pr(root_) + " }"; 
  }

  void add (Comparable k) { 
    if (root_ == null) {
      root_= new Node(k,null,null);        
      return;
    }
    Node r=contains(root_,k); 
    if (r.isIn(k) != 0) return; 
    //unsure how to process duplicate values using the comparable 
    //if a thought happens, will submit second time on blackboard
    insert(r,k,null);
  }

  boolean checkCount(Node n) {
    if (n.count < Node.mnkey) {
      return false;
    }
    if (n.child[0] != null )
      for (int i=0;i<=n.count;i++)
        if (!checkCount(n.child[i])) 
          return false;
    return true;
  }
 
  boolean check () {
    if(root_ == null) return true;
    if (root_.child[0] != null )
        for (int i=0;i<=root_.count;i++)
            if (!checkCount(root_.child[i])) 
                return false;

    for (int i=1;i<root_.count;i++) 
      if (root_.key[i].compareTo(root_.key[i+1]) > 0) {
        return false;
      }

    for (int i=1;i<=root_.count;i++) {
      if (!check(root_.child[i-1],root_.key[i],false)) return false;
      if (!check(root_.child[i],root_.key[i],true)) return false;
    }
    return true;
  }

  boolean check (Node t, Comparable val, boolean greater) {
    if (t==null) return true;

    if (greater && t.key[1].compareTo(val) < 0) {
        return false;
    }

    if (!greater && t.key[t.count].compareTo(val) > 0){
      return false;
    }
    if (greater && !check(t.child[0],val,true)) return false;

    if (!greater && !check(t.child[t.count],val,false)) return false;

    for (int i=1;i<t.count;i++) 
      if (t.key[i].compareTo(t.key[i+1]) > 0){
        return false;
      }

    for (int i=1;i<=t.count;i++) {
      if(!check(t.child[i-1],t.key[i],false)) return false;
      if(!check(t.child[i],t.key[i],true)) return false;
    }
    return true;
  }

  void insert(Node r, Comparable k, Node right) {
    Node xright = r.insert(k,right);
    if (xright == null)    return;
    Comparable xkey=xright.key[0];
    if(r.parent == null)
      root_= new Node(xkey,root_,xright);        
    else
      insert(r.parent,xkey,xright);
  }

  Comparable find (Comparable o) { 
    Node tmp = contains(root_,o);
    if (tmp == null)
      return null;
    int i=tmp.isIn(o);
    if(i>0)
      return tmp.key[i];
    else 
      return null;
  }

  boolean empty() {
    return root_ == null ? true : false;
  }

  Node contains(Node r, Comparable k) {
    if (r == null)
        return null;
    else {
      int w = r.search(k);
      if (w != 0 && k.compareTo(r.key[w]) == 0)
        return r;
      else {
        Node f = contains(r.child[w],k);
        if (f == null) 
          return r;
        else
          return f;
      }
    }
  }

  String pr(Node r) {
    String s=new String();
    if (r != null) {
      for (int i = 0; i < r.count; i++) {
        s=s.concat(pr(r.child[i]));
        s=s.concat(r.key[i+1] + " ");
      }
      s=s.concat(pr(r.child[r.count]));
    }
    return s;
  }

  void dis(Node r, int depth) {
    if (r != null)    {
      for (int i = r.count; i >= 1; i--) {
        dis(r.child[i],depth+4);
        for (int j = 1; j <= depth; j++) System.out.print(" ");
        System.out.println(r.key[i]);
      }
      dis(r.child[0], depth+4);
     }
  }

  int levels() {
	int l =0;
	Node t=root_;
	while (t !=null) {
	    l++;
	    t=t.child[0];
	}
	return l;
  } 
}