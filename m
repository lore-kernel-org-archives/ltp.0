Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <Poornima.Nayak@in.ibm.com>) id 1N9t2S-0002sc-3v
	for ltp-list@lists.sourceforge.net; Mon, 16 Nov 2009 04:18:04 +0000
Received: from e28smtp06.in.ibm.com ([122.248.162.6])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1N9t2K-0003LA-KU
	for ltp-list@lists.sourceforge.net; Mon, 16 Nov 2009 04:18:04 +0000
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
	by e28smtp06.in.ibm.com (8.14.3/8.13.1) with ESMTP id nAG4HkKf005215
	for <ltp-list@lists.sourceforge.net>; Mon, 16 Nov 2009 09:47:46 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nAG4HklD3514500
	for <ltp-list@lists.sourceforge.net>; Mon, 16 Nov 2009 09:47:46 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	nAG4HjuP023037
	for <ltp-list@lists.sourceforge.net>; Mon, 16 Nov 2009 09:47:45 +0530
In-Reply-To: <20091112121455.16825.70322.sendpatchset@localhost.localdomain>
References: <20091112121455.16825.70322.sendpatchset@localhost.localdomain>
MIME-Version: 1.0
Message-ID: <OFADCFBB49.BAA313D3-ON65257670.00168E44-65257670.0017980F@in.ibm.com>
From: Poornima Nayak <Poornima.Nayak@in.ibm.com>
Date: Mon, 16 Nov 2009 09:49:10 +0530
Subject: Re: [LTP] [PATCH] Power Management: Fix missing make targets.
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2758396394196505809=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: sachinp@linux.vnet.ibm.com, qingbo yuan <yuanbor.maillist@gmail.com>
Cc: ltp-list@lists.sourceforge.net

This is a multipart message in MIME format.
--===============2758396394196505809==
Content-Type: multipart/alternative;
	boundary="=_alternative 0017980765257670_="

This is a multipart message in MIME format.
--=_alternative 0017980765257670_=
Content-Type: text/plain; charset="US-ASCII"

Hi

Patch to handle this issue was mailed on 20/8/2009. Garret Cooper had 
replied that makefile-infra-rework patch will take care of this 
requirement. If makefile-infra-rework patch is in this error should not 
have come up or makefile-rework-patch might have some issue.

Anyway there was reply from maintainer, the patch which I had sent will be 
integrated till Garret Cooper's patch gets in. I am not sure how this 
issue would have come up. 
I feel its better to check in this patch to avoid Power Management test 
case failures.

Regards
Poornima



From:
sachinp@linux.vnet.ibm.com
To:
ltp-list@lists.sourceforge.net
Cc:
sachinp@linux.vnet.ibm.com
Date:
11/12/2009 06:37 PM
Subject:
[LTP] [PATCH] Power Management: Fix missing make targets.



Make sure required binaries used by the power management tests are 
compiled and
installed properly. Without the required MAKE TARGETS the test fails with

<<<test_output>>>
Are we really executing this ?
/opt/ltp/testcases/bin/runpwtests.sh: line 57: check_kv_arch: command not 
found
.....
Power_Management    7  TPASS  :  CPUIDLE sysfs tests passed
/opt/ltp/testcases/bin/runpwtests.sh: line 173: get_sched_values: command 
not
found

Patch is against LTP October version.

Signed-off-by: Sachin Sant <sachinp@in.ibm.com>
---
diff -Naurp a/testcases/kernel/power_management/Makefile 
b/testcases/kernel/power_management/Makefile
--- a/testcases/kernel/power_management/Makefile 2009-11-12 
13:02:57.000000000 +0530
+++ b/testcases/kernel/power_management/Makefile 2009-11-12 
13:04:03.000000000 +0530
@@ -26,6 +26,6 @@ $(eval $(call generate_vpath_rule,c,$(sr
 
 INSTALL_TARGETS                                 := lib/*.py *.py *.sh
 
-MAKE_TARGETS                            :=
+MAKE_TARGETS                            := check_kv_arch get_sched_values
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 
30-Day 
trial. Simplify your report design, integration and deployment - and focus 
on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list


--=_alternative 0017980765257670_=
Content-Type: text/html; charset="US-ASCII"

<font size=2 face="sans-serif">Hi</font>
<br>
<br><font size=2 face="sans-serif">Patch to handle this issue was mailed
on 20/8/2009. Garret Cooper had replied that </font><tt><font size=2>makefile-infra-rework
patch</font></tt><font size=2 face="sans-serif"> will take care of this
requirement. If makefile-infra-rework patch is in this error should not
have come up or makefile-rework-patch might have some issue.</font>
<br>
<br><font size=2 face="sans-serif">Anyway there was reply from maintainer,
the patch which I had sent will be integrated till Garret Cooper's patch
gets in. I am not sure how this issue would have come up. </font>
<br><font size=2 face="sans-serif">I feel its better to check in this patch
to avoid Power Management test case failures.</font>
<br>
<br><font size=2 face="sans-serif">Regards</font>
<br><font size=2 face="sans-serif">Poornima</font>
<br>
<br>
<br>
<table width=100%>
<tr valign=top>
<td><font size=1 color=#5f5f5f face="sans-serif">From:</font>
<td><font size=1 face="sans-serif">sachinp@linux.vnet.ibm.com</font>
<tr valign=top>
<td><font size=1 color=#5f5f5f face="sans-serif">To:</font>
<td><font size=1 face="sans-serif">ltp-list@lists.sourceforge.net</font>
<tr>
<td valign=top><font size=1 color=#5f5f5f face="sans-serif">Cc:</font>
<td><font size=1 face="sans-serif">sachinp@linux.vnet.ibm.com</font>
<tr valign=top>
<td><font size=1 color=#5f5f5f face="sans-serif">Date:</font>
<td><font size=1 face="sans-serif">11/12/2009 06:37 PM</font>
<tr valign=top>
<td><font size=1 color=#5f5f5f face="sans-serif">Subject:</font>
<td><font size=1 face="sans-serif">[LTP] [PATCH] Power Management: Fix
missing make targets.</font></table>
<br>
<hr noshade>
<br>
<br>
<br><tt><font size=2>Make sure required binaries used by the power management
tests are compiled and<br>
installed properly. Without the required MAKE TARGETS the test fails with<br>
<br>
&lt;&lt;&lt;test_output&gt;&gt;&gt;<br>
Are we really executing this ?<br>
/opt/ltp/testcases/bin/runpwtests.sh: line 57: check_kv_arch: command not
found<br>
.....<br>
Power_Management &nbsp; &nbsp;7 &nbsp;TPASS &nbsp;: &nbsp;CPUIDLE sysfs
tests passed<br>
/opt/ltp/testcases/bin/runpwtests.sh: line 173: get_sched_values: command
not<br>
found<br>
<br>
Patch is against LTP October version.<br>
<br>
Signed-off-by: Sachin Sant &lt;sachinp@in.ibm.com&gt;<br>
---<br>
diff -Naurp a/testcases/kernel/power_management/Makefile b/testcases/kernel/power_management/Makefile<br>
--- a/testcases/kernel/power_management/Makefile &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; 2009-11-12 13:02:57.000000000 +0530<br>
+++ b/testcases/kernel/power_management/Makefile &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; 2009-11-12 13:04:03.000000000 +0530<br>
@@ -26,6 +26,6 @@ $(eval $(call generate_vpath_rule,c,$(sr<br>
 <br>
 INSTALL_TARGETS &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp;:= lib/*.py *.py *.sh<br>
 <br>
-MAKE_TARGETS &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp;:=<br>
+MAKE_TARGETS &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp;:= check_kv_arch get_sched_values<br>
 <br>
 include $(top_srcdir)/include/mk/generic_leaf_target.mk<br>
<br>
------------------------------------------------------------------------------<br>
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day
<br>
trial. Simplify your report design, integration and deployment - and focus
on <br>
what you do best, core application coding. Discover what's new with<br>
Crystal Reports now. &nbsp;</font></tt><a href="http://p.sf.net/sfu/bobj-july"><tt><font size=2>http://p.sf.net/sfu/bobj-july</font></tt></a><tt><font size=2><br>
_______________________________________________<br>
Ltp-list mailing list<br>
Ltp-list@lists.sourceforge.net<br>
</font></tt><a href="https://lists.sourceforge.net/lists/listinfo/ltp-list"><tt><font size=2>https://lists.sourceforge.net/lists/listinfo/ltp-list</font></tt></a><tt><font size=2><br>
</font></tt>
<br>
--=_alternative 0017980765257670_=--


--===============2758396394196505809==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--===============2758396394196505809==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============2758396394196505809==--

