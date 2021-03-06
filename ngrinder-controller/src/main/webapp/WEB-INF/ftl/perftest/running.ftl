<div class="row">
	<div class="span5">
		<fieldSet>
			<legend>
				<@spring.message "perfTest.testRunning.summary"/>
			</legend>
		</fieldSet>
		<div class="form-horizontal form-horizontal-3" style="margin-top:10px;">
			<fieldset>
				<div class="control-group"> 
					<label class="control-label"><@spring.message "perfTest.testRunning.vusers"/></label>
					<div class="controls">
						<strong>${(test.vuserPerAgent)!}</strong>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label"><@spring.message "perfTest.testRunning.agents"/></label>
					<div class="controls">
						<span>${(test.agentCount)!}</span>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label"><@spring.message "perfTest.testRunning.processes"/></label>
					<div class="controls">
						${(test.processes)!} 
						<span class="badge badge-info pull-right"><@spring.message "perfTest.testRunning.running"/> <span id="process_data"></span></span>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label"><@spring.message "perfTest.testRunning.threads"/></label>
					<div class="controls">
						${(test.threads)!} <span class="badge badge-info pull-right"><@spring.message "perfTest.testRunning.running"/> <span id="thread_data"></span></span>
					</div>
				</div>
				<hr>
				<div class="control-group">
					<label class="control-label"><@spring.message "perfTest.configuration.targetHost"/></label>
					<div class="controls">
						<#if test?exists && test.targetHosts?has_content>
							<#list test.targetHosts?split(",") as host>
								${host?trim}<br>
							</#list>
						</#if>
					</div>
				</div>
				<hr>
				<div class="control-group">
					<#if test??>
						<#if test.threshold == "D">
							<label class="control-label"> <@spring.message "perfTest.configuration.duration"/> </label>
							<div class="controls">
								<span>${(test.durationStr)!}</span>
								<code>HH:MM:SS</code>
							</div>
						<#else>
							<label class="control-label"> <@spring.message "perfTest.configuration.runCount"/> </label>
							<div class="controls">
								${(test.runCount)!}
								<span class="badge badge-success pull-right"> <span id="running_count"></span>  <@spring.message "perfTest.table.runcount"/></span>
							</div>
						</#if>
					</#if>
				</div>
				<div class="control-group">
					<label class="control-label"><@spring.message "perfTest.testRunning.targetStatus"/></label>
				</div>
				<div class="control-group">
					<div id="monitor_status" style="font-size:12px;margin-left:-20px">
					</div>
				</div>
				<div class="control-group">
					<label class="control-label"><@spring.message "perfTest.testRunning.agentStatus"/></label>
				</div>
				<div class="control-group">
					<div id="agent_status" style="font-size:12px;margin-left:-20px">  
					</div>
				</div>

			</fieldset>
		</div>
	</div>
	<!-- end ruuning content left -->
	
	<div class="span7">
		<fieldSet>
			<legend>
				<@spring.message "perfTest.testRunning.tpsStatistics"/> 
				<span class="badge badge-success" style="vertical-align:middle;">
					<@spring.message "perfTest.testRunning.runTime"/> <span id="running_time"></span>
				</span>
				<a id="stop_test_btn" class="btn btn-danger pull-right" sid="${(test.id)!}">
					<@spring.message "common.button.stop"/>
				</a>		
			</legend> 
		</fieldSet>
		<div id="running_tps_chart" class="chart" style="width: 530px; height: 300px"></div>
		<div class="tabbable">
			<ul class="nav nav-tabs" style="" id="sample_tab">
				<li><a href="#last_sample_tab" tid="ls"><@spring.message "perfTest.testRunning.latestsample"/></a></li>
				<li><a href="#accumulated_sample_tab" tid="as"><@spring.message "perfTest.testRunning.accumulatedstatistic"/></a></li>
			</ul>
			<div class="tab-content">
				<div class="tab-pane" id="last_sample_tab">
					<table class="table table-striped table-bordered ellipsis" id="last_sample_table">
						<colgroup>
							<col width="30px">
							<col width="85px">
							<col width="85px">
							<col width="55px">
							<col width="60px">
							<col width="65px">
							<col width="65px">
							<col width="55px">
						</colgroup>
						<thead>
							<tr>
								<th class="no-click"><@spring.message "perfTest.testRunning.testID"/></th>
								<th class="no-click"><@spring.message "perfTest.table.testName"/></th>
								<th class="no-click"><@spring.message "perfTest.testRunning.successfulTest"/></th>
								<th class="no-click"><@spring.message "perfTest.table.errors"/></th>
								<th class="no-click" title="<@spring.message "perfTest.table.meantime"/>">MTT</th>
								<th class="no-click"><@spring.message "perfTest.table.tps"/></th>
								<th class="no-click"><@spring.message "perfTest.testRunning.responseBytePerSecond"/></th>
								<th class="no-click" title='<@spring.message "perfTest.testRunning.meanTimeToFirstByte"/>'>MTFB</th>
							</tr>
						</thead>
						<tbody>
						</tbody>
					</table>
				</div>
				<div class="tab-pane" id="accumulated_sample_tab">
					<table class="table table-striped table-bordered ellipsis" id="accumulated_sample_table"> 
						<colgroup>
							<col width="30px">
							<col width="85px">
							<col width="85px">
							<col width="55px">
							<col width="60px">
							<col width="65px">
							<col width="65px">
							<col width="55px">
						</colgroup>
						<thead>
							<tr>
								<th class="no-click"><@spring.message "perfTest.testRunning.testID"/></th>
								<th class="no-click"><@spring.message "perfTest.table.testName"/></th>
								<th class="no-click"><@spring.message "perfTest.testRunning.successfulTest"/></th>
								<th class="no-click"><@spring.message "perfTest.table.errors"/></th>
								<th class="no-click" title="<@spring.message "perfTest.table.meantime"/>">MTT</th>
								<th class="no-click"><@spring.message "perfTest.table.tps"/></th>
								<th class="no-click"><@spring.message "perfTest.detail.peakTPS"/></th>
								<th class="no-click" title="<@spring.message "perfTest.testRunning.mtsd.help"/>">MTSD</th>
							</tr>
						</thead>
						<tbody>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
	<!-- end running content right -->
</div>
<script>
	var curPeakTps = 0;
	var curTps = 0;
	var curRunningTime = 0;
	var curRunningProcesses = 0;
	var curRunningThreads = 0;
	var curRunningCount = 0;
	var curStatus = false;
	var curAgentPerfStates = [];
	var agentPerfStates = [];
	function refreshData() {
		var refreshDiv = $("<div></div>");
		var peakTps = 50;
		refreshDiv.load(
			"${req.getContextPath()}/perftest/<#if test??>${(test.id)?c}<#else>0</#if>/running/sample",
			{},
			function() {
				$("#running_time").text(showRunTime(curRunningTime));
				if (curStatus == true) {
					$("#last_sample_table tbody").html(refreshDiv.find("#last_sample_table_item"));
					$("#accumulated_sample_table tbody").html(refreshDiv.find("#accumulated_sample_table_item"));
		
					$("#process_data").text(curRunningProcesses);
					$("#thread_data").text(curRunningThreads);
					$("#running_count").text(curRunningCount);
					$("#agent_status").html(createMonitoringStatusString(curAgentStat));
					$("#monitor_status").html(createMonitoringStatusString(curMonitorStat));
					peakTps = curPeakTps;
					if (curPeakTps < 10) {
						preakTps = 10;
					}
					testTpsData.enQueue(curTps);
				} else { 
					if ($('#running_section_tab:hidden')[0]) {
						window.clearInterval(objTimer);
						return;
					} else {
						testTpsData.enQueue(0);
					}
				}
		
				if (testTpsData.getSize() > (60 / samplingInterval)) {
					testTpsData.deQueue();
				}
		
				showChart('running_tps_chart', testTpsData.aElement, peakTps, samplingInterval);
			}
		);
	}
	
	function createMonitoringStatusString(status) {
		var monitorStatusString = "<ul>";
		for ( var i = 0; i < status.length; i++) {
			var each = status[i];
			monitorStatusString = monitorStatusString + "<li class='monitor_status'><div style='wdith:100%;' class='ellipsis'><span title='" + each.agentFull + "'><b>" + each.agent + "</b></span> CPU-"
				+ each.cpu + "% MEM-" + each.mem + "% ";
			if (each.recievedPerSec != "0B" || each.sentPerSec != "0B") { 
				monitorStatusString = monitorStatusString + "/ RX-"+ each.recievedPerSec + " TX-" + each.sentPerSec + "</dv></li>";
			};
		}
		monitorStatusString += "</ul>"; 
		return monitorStatusString;
	}
	
	function showRunTime(s) {
		if (s < 60) {
			return "" + s + "s";
		}
		if (s < 3600) {
			return "" + parseInt(s / 60) + "m " + (s % 60) + "s";
		}
		if (s < 86400) {
			return "" + parseInt(s / 3600) + "h " + parseInt(s % 3600 / 60) + "m " + (s % 3600 % 60) + "s";
		}
	
		return "" + parseInt(s / 86400) + "d " + parseInt(s % 86400 / 3600) + "h " + parseInt(s % 86400 % 3600 / 60) + "m " + (s % 86400 % 3600 % 60) + "s";
	}
	
	function showChart(containerId, data, peakTps) {
		if (jqplotObj) {
			replotChart(jqplotObj, data, peakTps, undefined, samplingInterval);
		} else { 
			jqplotObj = drawChart(containerId, data, undefined, samplingInterval);
		}
	}
	
	function stopTests(ids) {
		$.ajax({
	  		url: "${req.getContextPath()}/perftest/stop",
			type: "POST",
	  		data: {"ids":ids},
			dataType:'json',
	    	success: function(res) {
	    		if (res.success) {
		    		showSuccessMsg("<@spring.message "perfTest.table.message.success.stop"/>");
	    		} else {
		    		showErrorMsg("<@spring.message "perfTest.table.message.error.stop"/>:" + res.message);
	    		}
	    	},
	    	error: function() {
	    		showErrorMsg("<@spring.message "perfTest.table.message.error.stop"/>!");
	    	}
	  	});
	}
	
	$(document).ready(function() {
		$("#stop_test_btn").click(function() {
			var id = $(this).attr("sid");
			bootbox.confirm("<@spring.message "perfTest.table.message.confirm.stop"/>", "<@spring.message "common.button.cancel"/>", "<@spring.message "common.button.ok"/>", function(result) {
				if (result) {
					stopTests(id);
				}
			});
		});
	});
</script>
