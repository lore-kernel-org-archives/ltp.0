Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Shivakumar.Haravi@aricent.com>) id 1U0VQi-0006Xa-D0
	for ltp-list@lists.sourceforge.net; Wed, 30 Jan 2013 11:02:12 +0000
Received: from jaguar.aricent.com ([121.241.96.11])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1U0VQg-00081Y-3Y
	for ltp-list@lists.sourceforge.net; Wed, 30 Jan 2013 11:02:12 +0000
Received: from jaguar.aricent.com (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id E0B3336B33
	for <ltp-list@lists.sourceforge.net>;
	Wed, 30 Jan 2013 16:31:47 +0530 (IST)
Received: from GUREXHT01.ASIAN.AD.ARICENT.COM (gurexht01.asian.ad.aricent.com
	[10.203.171.136])
	by jaguar.aricent.com (Postfix) with ESMTP id CAB3A36B3B
	for <ltp-list@lists.sourceforge.net>;
	Wed, 30 Jan 2013 16:31:47 +0530 (IST)
From: Shivakumar Haravi <Shivakumar.Haravi@aricent.com>
Date: Wed, 30 Jan 2013 16:28:45 +0530
Message-ID: <C0DEA5E8FC36694CB7391338195EAAEB05E7C35378@GUREXMB02.ASIAN.AD.ARICENT.COM>
References: <57E53D9CB50FBA49AB1A1E1BF8D5DE5505F56D0619@GUREXMB02.ASIAN.AD.ARICENT.COM>,
	<C0DEA5E8FC36694CB7391338195EAAEB05E7C35377@GUREXMB02.ASIAN.AD.ARICENT.COM>
In-Reply-To: <C0DEA5E8FC36694CB7391338195EAAEB05E7C35377@GUREXMB02.ASIAN.AD.ARICENT.COM>
Content-Language: en-US
MIME-Version: 1.0
Subject: [LTP] Need help
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
To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Greetings,


I am facing problem while executing one scripts. This script is related to wifi stress and script is running  on target board (Panda board).



1. I have included one wifi stress script under /testcases/bin/ folder.

2. I have created command file that contains test tag and command

3. If I tried to execute that script.(Ex: ./runltp -p -l results.log -f WIFI ).



Following error  getting displayed.



Running tests.......

<<<test_start>>>

tag=wifi_test stime=946685002

cmdline="wifi_test"

contacts=""

analysis=exit

<<<test_output>>>

<<<execution_status>>>

initiation_status="pan(2415): execvp of 'wifi_test' (tag wifi_test) failed.  errno:2  No such file or directory"

duration=0 termination_type=exited termination_id=2 corefile=no

cutime=0 cstime=0

<<<test_end>>>

incrementing stop

INFO: ltp-pan reported all tests PASS

LTP Version: 20120903



       ###############################################################



            Done executing testcases.

            LTP Version:  20120903



NOTE: I am able to execute this script on X86 machine.

Kindly guide me how to proceed next and let me is there any input is required from my end to analyses this issue.



Thanks in-advance,

Shivakumar









===============================================================================
Please refer to http://www.aricent.com/legal/email_disclaimer.html
for important disclosures regarding this electronic communication.
===============================================================================

------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_jan
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
