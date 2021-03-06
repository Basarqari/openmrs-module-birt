<%@ include file="/WEB-INF/template/include.jsp" %>

<!-- Include javascript from core -->
<openmrs:htmlInclude file="/scripts/jquery/jquery-1.3.2.min.js"/>
<openmrs:htmlInclude file="/scripts/jquery-ui/js/jquery-ui-1.7.2.custom.min.js" />


<script type="text/javascript" language="javascript">	
	function PopupCenter(pageURL, title,w,h) {
		var left = (screen.width/2)-(w/2);
		var top = (screen.height/2)-(h/2);
		var targetWin = window.open (pageURL, title, 'toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=no, resizable=no, copyhistory=no, width='+w+', height='+h+', top='+top+', left='+left);
	}
	

	$j(document).ready(function() {
		$j('#addUpgradePopup').dialog({
			autoOpen: false,
			modal: true,
			title: '<spring:message code="birt.newDataSetDefinition" javaScriptEscape="true"/>',
			width: '50%'
		});
		
		$j('#newDsdEditLink').click(function() {
			$j('#addUpgradePopup').dialog('open');
		});
		
		$j('#mapParametersFormCancelButton').click(function(event){			
			$j('#addUpgradePopup').dialog('close');
		});
		
		$j('#mapParametersFormSubmitButton').click(function(event){
			var existingKeys = [<c:forEach items="${existingKeys}" var="c" varStatus="cStat">'${c}'<c:if test="${!cStat.last}">,</c:if></c:forEach>];
			var newKey = $j('#newDsdKey').val();
			
			for (var i=0; i<existingKeys.length; i++) {
				if (existingKeys[i] == newKey) {
					alert('That key is already in use, please choose another.')
					return false;
				}
			}
			$j('#mapParametersForm').submit();
			$j('#newDsdKey').val('');
			
		});
		
	});
	
</script>

	<a style="font-weight:bold;" href="#" id="newDsdEditLink">[+] <spring:message code="birt.newDataSetDefinition"/></a>
	<div id="addUpgradePopup">
			
			<form id="mapParametersForm" method="post" action="report.form">
			<input type="hidden" name="mapped" value="mappedForm"/>	
			<input type="hidden" name="type" value="${report.reportDefinition['class'].name}"/>
			<input type="hidden" name="uuid" value="${report.reportDefinition.uuid}"/>
			<input type="hidden" name="reportId" value="${report.reportDefinition.id}"/>
			<input type="hidden" name="currentKey" value=""/>
			<input type="hidden" name="property" value="dataSetDefinitions"/>											
				<table>
					<tr>
						<td>Key:</td>
						<td><input type="text" name="newKey" id="newDsdKey" size="20" value="${param.newKey}"/></td>
					</tr>
					<tr>
						<td>DataSetDefinition:</td>
						<td>					
							<select id="jest" name="mappedUuid">								
								<c:forEach items="${dataSetDefinitionProperties}" var="dataSetDefinitionProperty" >
										<option value="${dataSetDefinitionProperty.value}">${dataSetDefinitionProperty.key}</option>									
								</c:forEach>
							</select>						
						</td>
					</tr>
				</table>				
				<hr style="color:blue;"/>
				<div style="width:100%; text-align:left;">
					<input type="button" id="mapParametersFormSubmitButton" class="ui-button ui-state-default ui-corner-all" value="Submit"/>
					<input type="button" id="mapParametersFormCancelButton" class="ui-button ui-state-default ui-corner-all" value="Cancel"/>
				</div>
			</form>											
		<br/>
	</div>
	