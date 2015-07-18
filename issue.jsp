<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script	src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
<link rel="stylesheet" href="css/style.css">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>select issue</title>
<style type="text/css">
.addressClass{
	font-family: "Helvetica Neue",Helvetica,Arial,sans-serif;
  font-size: 16px;
  line-height: 1.5;
  color: #222;
	}
</style>
<script type="text/javascript">
$(function(){
	
	$("input[name='issuetype']").click(function(){
		var issuetype=$("input[name='issuetype']:checked").val();
		if(issuetype==='Other Issues'){
			$("#commentboxtr").css("display","table-row");
		}else{
			$("#commentboxtr").css("display","none");
		}
	});
	
	/* $('#issuebox').change(function(){
		
		var issuetype=$(this).val();
		if(issutype==='Other Issues'){
			$("#Other Issues").css("display","block");
		}else{
			$("#Other Issues").css("display","none");
		}
	}); */
	
});
function savemyissue(){
	$("#issueform").submit();
}
</script>
</head>
<body style="background: none;">
<form method="post" action="saveLocation.jsp" id="issueform">
<div style="width: 600px;margin: 50px auto;" >
	


<table style="width: 100%">
   	<tr class="addressClass">
   		<td style="width: 120px;vertical-align: top;"><b>Store Name </b></td>
   		<td  style="width:*;vertical-align: top;" id="storenamespan"><%=request.getParameter("storename") %></td>
   	</tr>
   	<tr class="addressClass">
   		<td style="vertical-align: top;"><b>Store Address </b></td>
   		<td id="storeaddspan"><%=request.getParameter("storeaddress") %></td>
   	</tr>
   	<tr>
   		<td colspan="2" style="width: 50px">&nbsp;</td>
   	</tr>
   	<tr class="addressClass">
   		<td style="vertical-align: top;"><b>Select Issue </b></td>
   		<td id="">
   			<input type="radio" name="issuetype" value="Asked for another card">Asked for another card<br/>
   			<input type="radio" name="issuetype" value="Said terminal not working for AmEx">Said terminal not working for AmEx<br/>
   			<input type="radio" name="issuetype" value="Said pay more for AmEx">Said pay more for AmEx<br/>
   			<input type="radio" name="issuetype" value="Asked for Min/Max amount for AmEx">Asked for Min/Max amount for AmEx<br/>
   			<input type="radio" name="issuetype" value="Offered a discount on another card">Offered a discount on another card<br/>
   			<input type="radio" name="issuetype" value="Said they do not take AmEx cards">Said they do not take AmEx cards<br/>
   			<input type="radio" name="issuetype" value="No credit cards accepted">No credit cards accepted<br/>
   			<input type="radio" name="issuetype" value="Other Issues">Other Issues<br/>
   		</td>
   	</tr>
   	<tr id='commentboxtr' style="display: none;">
	   	<td style="vertical-align: top;width: 120px"><b>Comment</b></td>
	   	<td style="width: *"><textarea rows="4" cols="30" name="comment"></textarea> </td>
   	</tr>
   	<tr>
   		<td colspan="2" style="width: 50px">&nbsp;</td>
   	</tr>
   	<tr>
   		<td></td>
   		<td  style="width: 50px"><input	type="button"  class="login login-submit" id='submitpage' 
   value="Submit" onclick="savemyissue()" style="cursor: pointer;width: 250px;"></td>
   	</tr>
   </table><br/>
	<!-- <div class="addressClass"><b>Select Issue</b>  	
    	<select id='issuebox' >
    		<option value="~"></option>
    		<option value="Asked for another card">Asked for another card</option>
    		<option value="Said terminal not working for AmEx">Said terminal not working for AmEx</option>
    		<option value="Said pay more for AmEx">Said pay more for AmEx</option>
    		<option value="Asked for Min/Max amount for AmEx">Asked for Min/Max amount for AmEx</option>
    		<option value="Offered a discount on another card">Offered a discount on another card</option>
    		<option value="Said they do not take AmEx cards">Said they do not take AmEx cards</option>
    		<option value="No credit cards accepted">No credit cards accepted</option>
    		<option value="Other Issues">Other Issues</option>
    	</select>
    	
    	</div> -->
</div>
</form>
</body>
</html>