package db;

public class CrewListBean {
	private int crno;
	private String crname;	
	private int crprice;
	private String crimg;
	private String crinfo;
	private String crcate;
	
	public CrewListBean() {}

	public CrewListBean(int crno, String crname, int crprice, String crimg, String crinfo, String crcate) {
		
		this.crno = crno;
		this.crname = crname;
		this.crprice = crprice;
		this.crimg = crimg;
		this.crinfo = crinfo;
		this.crcate = crcate;
	}

	public int getCrno() {
		return crno;
	}

	public void setCrno(int crno) {
		this.crno = crno;
	}

	public String getCrname() {
		return crname;
	}

	public void setCrname(String crname) {
		this.crname = crname;
	}

	public int getCrprice() {
		return crprice;
	}

	public void setCrprice(int crprice) {
		this.crprice = crprice;
	}

	public String getCrimg() {
		return crimg;
	}

	public void setCrimg(String crimg) {
		this.crimg = crimg;
	}

	public String getCrinfo() {
		return crinfo;
	}

	public void setCrinfo(String crinfo) {			
		this.crinfo = crinfo;
	}
	
	public String getCrcate() {
		return crcate;
	}
	
	public void setCrcate(String crcate) {
		this.crcate=crcate;
	}
	
	
}
