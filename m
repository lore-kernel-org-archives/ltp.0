Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1O9v3J-0004S2-Be
	for ltp-list@lists.sourceforge.net; Thu, 06 May 2010 06:59:21 +0000
Received: from e33.co.us.ibm.com ([32.97.110.151])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1O9v3I-0000ZX-Fg
	for ltp-list@lists.sourceforge.net; Thu, 06 May 2010 06:59:21 +0000
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
	[9.17.195.107])
	by e33.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o466tE4U029719
	for <ltp-list@lists.sourceforge.net>; Thu, 6 May 2010 00:55:14 -0600
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP
	id o466xDJI091598
	for <ltp-list@lists.sourceforge.net>; Thu, 6 May 2010 00:59:14 -0600
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o466xDgK008687
	for <ltp-list@lists.sourceforge.net>; Thu, 6 May 2010 00:59:13 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
Date: Thu, 06 May 2010 12:29:01 +0530
Message-Id: <20100506065859.23879.73287.sendpatchset@subratamodak.linux.ibm.com>
In-Reply-To: <20100506065548.23879.63131.sendpatchset@subratamodak.linux.ibm.com>
References: <20100506065548.23879.63131.sendpatchset@subratamodak.linux.ibm.com>
Subject: [12/12 FAILURE] LTPX cron tests fails
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============7025722260736605520=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Linus Test Project <ltp-list@lists.sourceforge.net>
Cc: Sharyathi Nagesh <sharyath@in.ibm.com>, Sachin P Sant <ssant@in.ibm.com>, "SUZUKI K. POULOSE" <suzuki@in.ibm.com>, B N Poornima <bnpoorni@in.ibm.com>

--===============7025722260736605520==

Subject: LTP�� cron_tests fails

Issues Description Below:
========================================
# vi runtest/cron_tests
cron_tests export TCdat=$LTPROOT/testcases/bin; cron_tests.sh
<EOF>

Run LTP with the following command:
# ./runltp -f cron_tests
<<<test_start>>>
tag=cron stime=1272004510
cmdline="export TCdat=$LTPROOT/testcases/bin; cron_tests.sh"
contacts=""
analysis=exit
<<<test_output>>>
cron01      0  TINFO  :  Test #1: crontab <filename> installs the crontab file
cron01      0  TINFO  :  Test #1: cron schedules the job listed in crontab
file.
cron01      0  TINFO  :  Test #1: Installing cron job ...
cron01      0  TINFO  :  Test #1: Cronjob installed successfully
cron01      0  TINFO  :  Test #1: /var/log/cron: Trying altenate log...
cron01      1  TFAIL  :  Test #1: crontab activity not recorded in
/var/log/messages.
cron01      0  TINFO  :  Test #1: Values are good:
    Expected 8;     Received 8
cron01      0  TINFO  :  Test #1: Values are good:
    Expected 9;     Received 9
cron01      0  TINFO  :  Test #1: Values are good:
    Expected 10;     Received 10
cron01      0  TINFO  :  Test #1: Values are good:
    Expected 11;     Received 11
cron01      0  TINFO  :  Test #1: Values are good:
    Expected 12;     Received 12
cron01      0  TINFO  :  Test #1: /var/log/cron: alternate...
cron01      1  TFAIL  :  Test #1: Test failed. Reason:
cron02      0  TINFO  :  Test #2: crontab -r removes the crontab file.
cron02      0  TINFO  :  Test #2: installing crontab file.
cron02      0  TINFO  :  Test #1: /var/log/cron: alternate...
cron02      2  TFAIL  :  Test #2: crontab activity not recorded in
var/log/messages.
cron02      0  TINFO  :  Test #2: uninstalling crontab file.
cron02      0  TINFO  :  Test #1: /var/log/cron: alternate...
cron02      2  TFAIL  :  Test #2: crontab activity not recorded in
var/log/messages.
cron03      0  TINFO  :  Test #3: crontab -l lists the cronjobs installed
cron03      0  TINFO  :  Test #3: installing crontab file ...
cron03      0  TINFO  :  Test #3: Cron job installed.
cron03      0  TINFO  :  Test #3: crontab -l listed cronjob tst2_cronprg.sh
cron03      0  TINFO  :  Test #3: uninstalling crontab file.
cron03      0  TINFO  :  crontab uninstalled all jobs for user
cron03      3  TPASS  :  crontab did not list any cronjobs
<<<execution_status>>>
initiation_status="ok"
duration=434 termination_type=exited termination_id=4 corefile=no
cutime=3 cstime=22
<<<test_end>>>

Regards--
Subrata



--===============7025722260736605520==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--===============7025722260736605520==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============7025722260736605520==--
