Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mgahagan@redhat.com>) id 1MfeMj-0001Oj-Bf
	for ltp-list@lists.sourceforge.net; Mon, 24 Aug 2009 18:34:01 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MfeMi-0006wP-BG
	for ltp-list@lists.sourceforge.net; Mon, 24 Aug 2009 18:34:01 +0000
Received: from int-mx03.intmail.prod.int.phx2.redhat.com
	(int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.16])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id n7OIXqhV008597
	for <ltp-list@lists.sourceforge.net>; Mon, 24 Aug 2009 14:33:52 -0400
Received: from dhcp231-193.rdu.redhat.com (dhcp231-49.rdu.redhat.com
	[10.11.231.49])
	by int-mx03.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP
	id n7OIXpqs031601
	for <ltp-list@lists.sourceforge.net>; Mon, 24 Aug 2009 14:33:51 -0400
Message-ID: <4A92DCAE.5060102@redhat.com>
Date: Mon, 24 Aug 2009 14:32:14 -0400
From: Mike Gahagan <mgahagan@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090907050507030702040000"
Subject: [LTP] Bug in memory controller test - memctl test #4
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------090907050507030702040000
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

When running the Memory Controller test # 4, I'm seeing this behavior below.

TEST 4: MEMORY CONTROLLER TESTING
RUNNING SETUP.....
TEST STARTED: Please avoid using system while this test executes
/mnt/tests/kernel/distribution/ltp/20090731/ltp-full-20090731/testcases/bin/run_memctl_test.sh: 
line 327: [: 62955520: unary operator expected
TINFO   Memory Resource Controller: stat check test fails in first run
/mnt/tests/kernel/distribution/ltp/20090731/ltp-full-20090731/testcases/bin/run_memctl_test.sh: 
line 364: [: 78704640: unary operator expected
TFAIL   Memory Resource Controller: stat check test FAILED
*** infinite loop here, script exists memctl_test01 remains running ***
^Cincrementing stop

The bash error is due to the 'grep -w "active"' not matching anything so 
one of the variables isn't getting set like it is supposed to. I believe 
the test was written with an old version of the memory controller what 
put a field called memory.stat.active in the file memory.stat. The 
current memory controller I am testing appears to have replaced this 
field with "rss". There are fields showing anonymous and file backed 
pages in memory.stat, but I don't think they are ever going to match the 
memory.usage.in.bytes the test is looking for. Rss always matches and I 
believe that is what we should update the check in the test to look for. 
The attached patch fixes test #4 to compare memory.usage.in.bytes with rss.

--------------090907050507030702040000
Content-Type: text/plain;
 name="run_memctl_test.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="run_memctl_test.patch"

--- ltp-full-20090731/testcases/kernel/controllers/memctl/run_memctl_test.sh	2008-05-26 07:26:44.000000000 -0400
+++ run_memctl_test.sh.new	2009-08-24 14:17:12.475154507 -0400
@@ -323,7 +323,7 @@
 		check_mem_allocated;# $MEM_TOTAL;
 		# now we can check the memory usage from both files
 		USAGE_FROM_STAT=`cat /dev/memctl/group_1/memory.stat \
-					| grep -w "active" | cut -d" " -f2`;
+					| grep -w "rss" | cut -d" " -f2`;
 		if [ $USAGE_FROM_USAGE_IN_BYTES -eq $USAGE_FROM_STAT ]
 		then
 			echo "memory usage from memory.usage_in_bytes= $USAGE_FROM_USAGE_IN_BYTES";
@@ -360,7 +360,7 @@
 
 		# now we can check the memory usage from both files
 		USAGE_FROM_STAT=`cat /dev/memctl/group_1/memory.stat \
-					| grep -w "active" | cut -d" " -f2`;
+					| grep -w "rss" | cut -d" " -f2`;
 		if [ $USAGE_FROM_USAGE_IN_BYTESGRP1_MEMUSAGE -eq $USAGE_FROM_STAT ] \
 							&& [ $FIRST_STEP_PASS -eq 1 ]
 		then

--------------090907050507030702040000
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--------------090907050507030702040000
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------090907050507030702040000--

