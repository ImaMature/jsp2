<%@page import="DTO.Cart"%>
<%@page import="java.util.ArrayList"%>
<%@page import="DAO.PorderDao"%>
<%@page import="DTO.Login"%>
<%@page import="DTO.Porder"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
//���� [ 1. �ֹ� db����ϰ� -> 2. �ֹ� ��ǰ ����ŭ �ֹ� �� ���]

	//1. �ֹ� ���
		//1) ȸ�� ��ȣ : m_num : ����
		//2) ������ : order_name
		//3) �����ڿ���ó : order_phone
		//4) �������ּ� : order_address
		//5) �ֹ��ѱݾ� : order_pay
		//6) �������� : order_payment
		//7) ��ۺ� : delivery_pay
		//8) ��ۿ�û���� : order_contents
	
	//2. �ֹ� �� [���� �ֹ� ����� �ȴٴ� ������] : �ݺ���
		//�ֹ���ȣ : order_num : db
		//��ǰ��ȣ : p_num : īƮ ����
		//���ż��� : p_count : īƮ ����
		//��ۻ��� : delivery_state : ���ǰ� [1]
				
	//3. ��� ���� [ ��ǰ ������Ʈ ]
			
	//4. īƮ���� �ʱ�ȭ
	
//ajax�� �̿��� �Ű����� ��û
String order_name = request.getParameter("order_name");
String order_phone = request.getParameter("order_phone");
String order_address = request.getParameter("order_address");
int order_pay = Integer.parseInt(request.getParameter("order_pay"));
String order_payment = request.getParameter("order_payment");
int delivery_pay = Integer.parseInt(request.getParameter("delivery_pay"));
String order_contents = request.getParameter("order_contents");
//System.out.print(order_contents);

//productpayment
Login login = (Login)session.getAttribute("login"); //�α��� ���� ��û
//System.out.print("login : "+  login.toString());

//DB�� �����ϱ� ���� ��üȭ
Porder porder = new Porder(login.getM_num(), order_name, order_phone, order_address, 
				order_pay, order_payment, delivery_pay, order_contents);

//īƮ ���� ȣ�� (īƮ�� DB�� �����ϱ� ����)
//��ٱ��� ���� �̸� [ �̸� : cart + ���̵� / �� : cart����Ʈ ]
String sname = "cart"+login.getM_id();
ArrayList<Cart> carts = (ArrayList<Cart>)session.getAttribute(sname);

//DB�����ϱ�
boolean rs = PorderDao.getporderDao().orderwrite(porder, carts);

System.out.println("rs : " + rs);
if(rs){
	out.print("1"); session.setAttribute(sname, null); //��ٱ��� �ʱ�ȭ
}else{
	out.print("0");
}
//�����ϱ� ������ ��
//out.print(order_name + order_phone + order_address + order_pay + order_payment + delivery_pay + order_contents);	
%>