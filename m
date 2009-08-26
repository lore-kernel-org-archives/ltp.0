Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mgahagan@redhat.com>) id 1MgKwN-0005a8-PG
	for ltp-list@lists.sourceforge.net; Wed, 26 Aug 2009 16:01:39 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MgKwJ-0003lT-Hz
	for ltp-list@lists.sourceforge.net; Wed, 26 Aug 2009 16:01:39 +0000
Received: from int-mx06.intmail.prod.int.phx2.redhat.com
	(int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.19])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id n7QG1Ta5018479
	for <ltp-list@lists.sourceforge.net>; Wed, 26 Aug 2009 12:01:29 -0400
Received: from dhcp231-193.rdu.redhat.com (dhcp231-49.rdu.redhat.com
	[10.11.231.49])
	by int-mx06.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP
	id n7QG1SkJ026452
	for <ltp-list@lists.sourceforge.net>; Wed, 26 Aug 2009 12:01:28 -0400
Message-ID: <4A955C57.7020502@redhat.com>
Date: Wed, 26 Aug 2009 12:01:27 -0400
From: Mike Gahagan <mgahagan@redhat.com>
MIME-Version: 1.0
References: <4A92DCAE.5060102@redhat.com>
	<1251194293.5534.24.camel@subratamodak.linux.ibm.com>
In-Reply-To: <1251194293.5534.24.camel@subratamodak.linux.ibm.com>
Content-Type: multipart/mixed; boundary="------------060300040908040304050105"
Subject: Re: [LTP] Bug in memory controller test - memctl test #4 - PATCH
 repost
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
--------------060300040908040304050105
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 08/25/2009 05:58 AM, Subrata Modak wrote:
> On Mon, 2009-08-24 at 14:32 -0400, Mike Gahagan wrote:
>> When running the Memory Controller test # 4, I'm seeing this behavior below.
>>
>> TEST 4: MEMORY CONTROLLER TESTING
>> RUNNING SETUP.....
>> TEST STARTED: Please avoid using system while this test executes
>> /mnt/tests/kernel/distribution/ltp/20090731/ltp-full-20090731/testcases/bin/run_memctl_test.sh:
>> line 327: [: 62955520: unary operator expected
>> TINFO   Memory Resource Controller: stat check test fails in first run
>> /mnt/tests/kernel/distribution/ltp/20090731/ltp-full-20090731/testcases/bin/run_memctl_test.sh:
>> line 364: [: 78704640: unary operator expected
>> TFAIL   Memory Resource Controller: stat check test FAILED
>> *** infinite loop here, script exists memctl_test01 remains running ***
>> ^Cincrementing stop
>>
>> The bash error is due to the 'grep -w "active"' not matching anything so
>> one of the variables isn't getting set like it is supposed to. I believe
>> the test was written with an old version of the memory controller what
>> put a field called memory.stat.active in the file memory.stat. The
>
> Correct. Somebody needs to revisit these tests, as the ABIs has changed.
> Thanks for pointing that out. However, your patch has the following
> problem:
>
> 1) Missing Signed-off-by:
> 2) missing header for unified diff at line 3 of patch
> patching file testcases/kernel/controllers/memctl/run_memctl_test.sh
>
> Please look into them when you send a patch next time ;-)
>
> Regards--
> Subrata
>
>> current memory controller I am testing appears to have replaced this
>> field with "rss". There are fields showing anonymous and file backed
>> pages in memory.stat, but I don't think they are ever going to match the
>> memory.usage.in.bytes the test is looking for. Rss always matches and I
>> believe that is what we should update the check in the test to look for.
>> The attached patch fixes test #4 to compare memory.usage.in.bytes with rss.
>> ------------------------------------------------------------------------------

Hello,

Here is a resubmission of my memctl test patch. It should clear up the 
issues noted above. No functional change from the previous patch.

Signed-off-by: Mike Gahagan <mgahagan@redhat.com>


--------------060300040908040304050105
Content-Type: text/plain;
 name="run_memctl_test.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="run_memctl_test.patch"

 run_memctl_test.sh |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
diff -uNr ltp-full-20090731/testcases/kernel/controllers/memctl/run_memctl_test.sh ltp-full-20090731.new/testcases/kernel/controllers/memctl/run_memctl_test.sh
--- ltp-full-20090731/testcases/kernel/controllers/memctl/run_memctl_test.sh	2009-08-25 16:21:47.298273822 -0400
+++ ltp-full-20090731.new/testcases/kernel/controllers/memctl/run_memctl_test.sh	2009-08-25 16:41:57.606201495 -0400
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

--------------060300040908040304050105
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--------------060300040908040304050105
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------060300040908040304050105--

