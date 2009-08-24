Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MfVvB-0003CY-HS
	for ltp-list@lists.sourceforge.net; Mon, 24 Aug 2009 09:33:01 +0000
Received: from e8.ny.us.ibm.com ([32.97.182.138])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MfVv4-0003aP-Ef
	for ltp-list@lists.sourceforge.net; Mon, 24 Aug 2009 09:33:01 +0000
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e8.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n7O5WMdp015898
	for <ltp-list@lists.sourceforge.net>; Mon, 24 Aug 2009 01:32:22 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7O9Wnck248972
	for <ltp-list@lists.sourceforge.net>; Mon, 24 Aug 2009 05:32:49 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n7O9WmiG022921
	for <ltp-list@lists.sourceforge.net>; Mon, 24 Aug 2009 05:32:48 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
Date: Mon, 24 Aug 2009 15:02:35 +0530
Message-Id: <20090824093224.31997.5188.sendpatchset@subratamodak.linux.ibm.com>
In-Reply-To: <20090824093204.31997.18175.sendpatchset@subratamodak.linux.ibm.com>
References: <20090824093204.31997.18175.sendpatchset@subratamodak.linux.ibm.com>
Subject: [LTP] [PATCH 01/02] Create the necessary Interface with runltp
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: LTP Mailing List <ltp-list@lists.sourceforge.net>
Cc: Sachin P Sant <sachinp@linux.vnet.ibm.com>, Mike Frysinger <vapier@gentoo.org>, Michael Reed <mreed10@us.ibm.com>, Nate Straz <nate@refried.org>, Paul Larson <paul.larson@ubuntu.com>, Manoj Iyer <manoj.iyer@ubuntu.com>, Balbir Singh <balbir@linux.vnet.ibm.com>

Introducing a new Option "-M" in LTP, which will take 1 argument of the type
of Checks that you would need to do for the LTP tests. Even, if you would like
to use these check options, it internally checks whether the desired tool
is available on your machine. It goes ahead and then does the necessary checks
on your tests. One limitation is that if you choose both the "Fault Injection"
and "Memory Leak Checks" simultaneously, then "Memory Leak Checks" will not work,
as we would not like to test how "Fault Injection" works when "Valgrind" is
running.

Signed-off-by: Subrata Modak<subrata@linux.vnet.ibm.com>
---

--- ltp-full-20090731.orig/runltp	2009-08-23 23:02:34.000000000 +0530
+++ ltp-full-20090731/runltp	2009-08-24 12:15:20.000000000 +0530
@@ -138,6 +138,10 @@ usage() 
                     [CHUNKS      = malloc these many chunks (default is 1 when value 0 or undefined)]
                     [BYTES       = malloc CHUNKS of BYTES bytes (default is 256MB when value 0 or undefined) ]
                     [HANGUP_FLAG = hang in a sleep loop after memory allocated, when value 1]
+	-M CHECK_TYPE
+		[CHECK_TYPE=1 => Full Memory Leak Check tracing children as well]
+		[CHECK_TYPE=2 => Thread Concurrency Check tracing children as well]
+		[CHECK_TYPE=3 => Full Memory Leak & Thread Concurrency Check tracing children as well]
     -N              Run all the networking tests. 
     -n              Run LTP with network traffic in background.
     -o OUTPUTFILE   Redirect test output to a file.
@@ -188,6 +192,8 @@ main()
 	local INJECT_KERNEL_FAULT=""
 	local INJECT_KERNEL_FAULT_PERCENTAGE=""
 	local INJECT_FAULT_LOOPS_PER_TEST=""
+	local VALGRIND_CHECK=""
+	local VALGRIND_CHECK_TYPE=""
     local LOGFILE_NAME=""
     local LOGFILE=""
     local OUTPUTFILE_NAME=""
@@ -201,7 +207,7 @@ main()
     local DEFAULT_FILE_NAME_GENERATION_TIME=`date +"%Y_%b_%d-%Hh_%Mm_%Ss"`
     version_date=`head -n 1 $LTPROOT/ChangeLog`
 
-    while getopts a:c:C:d:D:f:F:ehi:g:l:m:Nno:pqr:s:S:t:T:vw:x:b:B: arg
+    while getopts a:c:C:d:D:f:F:ehi:g:l:m:M:Nno:pqr:s:S:t:T:vw:x:b:B: arg
     do  case $arg in
         a)  EMAIL_TO=$OPTARG
             ALT_EMAIL_OUT=1;;
@@ -350,7 +356,10 @@ main()
                     $CHUNKS --vm-bytes $BYTES >/dev/null 2>&1 &
             fi
             GENLOAD=1;;
-    
+	M)
+		VALGRIND_CHECK=1
+		VALGRIND_CHECK_TYPE="$OPTARG";;
+
         N)  RUN_NETEST=1;;
     
         n)  
@@ -774,7 +783,7 @@ main()
     test_start_time=$(date)
 
 	# User wants testing with Kernel Fault Injection
-	if [ $INJECT_KERNEL_FAULT -eq 1 ] ; then
+	if [ $INJECT_KERNEL_FAULT ] ; then
 		#See if Debugfs is mounted, and
 		#Fault Injection Framework available through Debugfs
 		if [ -d "/sys/kernel/debug/fail_io_timeout" -o \
@@ -795,6 +804,29 @@ main()
 		fi
 	fi
 
+	## Valgrind Check will work only when Kernel Fault Injection is not expected,
+	## We do not want to test Faults when valgrind is running
+	if [ $VALGRIND_CHECK ]; then
+		if [ ! $INJECT_KERNEL_FAULT ]; then
+			which valgrind || VALGRIND_CHECK_TYPE=XYZ
+			case $VALGRIND_CHECK_TYPE in
+				1)
+				${LTPROOT}/tools/create_valgrind_check.pl ${TMP}/alltests 1 > ${TMP}/alltests.tmp
+				cp ${TMP}/alltests.tmp ${TMP}/alltests
+				rm -rf ${TMP}/alltests.tmp;;
+				2)
+				${LTPROOT}/tools/create_valgrind_check.pl ${TMP}/alltests 2 > ${TMP}/alltests.tmp
+				cp ${TMP}/alltests.tmp ${TMP}/alltests
+				rm -rf ${TMP}/alltests.tmp;;
+				3)
+				${LTPROOT}/tools/create_valgrind_check.pl ${TMP}/alltests 3 > ${TMP}/alltests.tmp
+				cp ${TMP}/alltests.tmp ${TMP}/alltests
+				rm -rf ${TMP}/alltests.tmp;;
+				*) echo "Invalid Memory Check Type, or, Valgrind is not available";;
+			esac
+		fi
+	fi
+
     # Some tests need to run inside the "bin" directory.
     cd "${LTPROOT}/testcases/bin"
     ${LTPROOT}/pan/ltp-pan $QUIET_MODE -e -S $INSTANCES $DURATION -a $$ -n $$ $PRETTY_PRT -f ${TMP}/alltests $LOGFILE $OUTPUTFILE $FAILCMDFILE

---
Regards--
Subrata


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
