Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1WIbHS-0004Tm-Ft
	for ltp-list@lists.sourceforge.net; Wed, 26 Feb 2014 09:59:58 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WIbHR-0002hG-LK
	for ltp-list@lists.sourceforge.net; Wed, 26 Feb 2014 09:59:58 +0000
Received: from ucsinet22.oracle.com (ucsinet22.oracle.com [156.151.31.94])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s1Q9xpSh015926
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 26 Feb 2014 09:59:51 GMT
Received: from userz7021.oracle.com (userz7021.oracle.com [156.151.31.85])
	by ucsinet22.oracle.com (8.14.5+Sun/8.14.5) with ESMTP id
	s1Q9xo7F006281
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Wed, 26 Feb 2014 09:59:50 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
	by userz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s1Q9xoE7002017
	for <ltp-list@lists.sourceforge.net>; Wed, 26 Feb 2014 09:59:50 GMT
Message-ID: <530DBB2D.1090406@oracle.com>
Date: Wed, 26 Feb 2014 14:00:13 +0400
From: Alexey Kodanev <alexey.kodanev@oracle.com>
MIME-Version: 1.0
Subject: [LTP] network tests: help script to run commands on remote host
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list <ltp-list@lists.sourceforge.net>
Cc: Vasily Isaenko <vasily.isaenko@oracle.com>

Hi!
There are some network tests which need to run various commands on the 
remote host. So is it a good idea to add a help script which does that 
according to chosen network protocol: rsh or ssh?

If yes, we can have a script like tst_rhost_run (or tst_run_rcmd...) in 
the ltp/tools, or somewhere else.

I did something similar in the submitted tcp_fastopen test, so the 
script could be as follows:

if [ "$use_ssh" -eq 1 ]; then
	ssh -n -f $user_name@$RHOST "sh -c 'nohup $rcmd &'" > /dev/null 2>&1
else
	rsh -n -l $user_name $RHOST "sh -c 'nohup $rcmd &'" > /dev/null 2>&1
fi

if [ $? -ne 0 ]; then
	tst_brkm TBROK NULL "No route to host $RHOST"
	exit 2
fi

Any suggestions, ideas?

Best regards,
Alexey


------------------------------------------------------------------------------
Flow-based real-time traffic analytics software. Cisco certified tool.
Monitor traffic, SLAs, QoS, Medianet, WAAS etc. with NetFlow Analyzer
Customize your own dashboards, set traffic alerts and generate reports.
Network behavioral analysis & security monitoring. All-in-one tool.
http://pubads.g.doubleclick.net/gampad/clk?id=126839071&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
