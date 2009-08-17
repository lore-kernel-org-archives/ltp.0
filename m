Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1Md13N-0007Zr-PK
	for ltp-list@lists.sourceforge.net; Mon, 17 Aug 2009 12:11:09 +0000
Received: from e38.co.us.ibm.com ([32.97.110.159])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Md13J-0001lV-86
	for ltp-list@lists.sourceforge.net; Mon, 17 Aug 2009 12:11:09 +0000
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e38.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n7HC7BLV016512
	for <ltp-list@lists.sourceforge.net>; Mon, 17 Aug 2009 06:07:11 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7HCAjYb122064
	for <ltp-list@lists.sourceforge.net>; Mon, 17 Aug 2009 06:10:47 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n7HCAhXg000626
	for <ltp-list@lists.sourceforge.net>; Mon, 17 Aug 2009 06:10:44 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
Date: Mon, 17 Aug 2009 17:40:28 +0530
Message-Id: <20090817121026.8902.3224.sendpatchset@subratamodak.linux.ibm.com>
In-Reply-To: <20090817120835.8902.4597.sendpatchset@subratamodak.linux.ibm.com>
References: <20090817120835.8902.4597.sendpatchset@subratamodak.linux.ibm.com>
Subject: [LTP] [PATCH v2 05/05] Add the necessary Interface and Option
	through "runltp"
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

Change the runltp script to actually create an interface for the user:
1) Introduce a new option "-F" for ability to run tests under "Fault Injection Framework",
2) "./runltp -h" will display the new option,
3) Verifies whether Kernel has built-in capabilities for "Fault Injection",

This has no much difference from the last version, except that 'runltp'
has changed in between to include Paul's -S option. This has just been
created over top of it. I will try to move the 'debugfs' checking
logic out of 'runltp' some time in future.

Signed-off-by: Subrata Modak<subrata@linux.vnet.ibm.com>
---

--- ltp-full-20090731.orig/runltp	2009-08-17 10:46:41.000000000 +0530
+++ ltp-full-20090731/runltp	2009-08-17 11:40:34.000000000 +0530
@@ -62,6 +62,8 @@
 #               - Added a new option to mail back LTP reports
 #               May 19 2008 - Modified - Subrata Modak
 #               - Added capability for default Log file generation
+#		Aug 17 2009 - Modified - Subrata Modak
+#		- Added Fault Injection generation Capability through -F Option
 #
 #################################################################################
 
@@ -108,6 +110,7 @@ usage() 
     [ -i NUM_PROCS ] [ -l LOGFILE ] [ -m NUM_PROCS,CHUNKS,BYTES,HANGUP_FLAG ] 
     -N -n [ -o OUTPUTFILE ] -p -q [ -r LTPROOT ] [ -s PATTERN ] [ -t DURATION ]
     -v [ -w CMDFILEADDR ] [ -x INSTANCES ] [ -b DEVICE ] [-B DEVICE_FS_TYPE]
+	[ -F LOOPS,PERCENTAGE ]
                 
     -a EMAIL_TO     EMAIL all your Reports to this E-mail Address
     -c NUM_PROCS    Run LTP under additional background CPU load
@@ -123,6 +126,7 @@ usage() 
                     [CLEAN_FLAG  = unlink file to which random data written, when value 1]
     -e              Prints the date of the current LTP release
     -f CMDFILES     Execute user defined list of testcases (separate with ',')
+	-F LOOPS,PERCENTAGE Induce PERCENTAGE Fault in the Kernel Subsystems, and, run each test for LOOPS loop
     -g HTMLFILE     Create an additional HTML output format
     -h              Help. Prints all available options.
     -i NUM_PROCS    Run LTP under additional background Load on IO Bus
@@ -181,6 +185,9 @@ main()
     local DURATION=""
     local CMDFILEADDR=""
     local FAILCMDFILE=""
+	local INJECT_KERNEL_FAULT=""
+	local INJECT_KERNEL_FAULT_PERCENTAGE=""
+	local INJECT_FAULT_LOOPS_PER_TEST=""
     local LOGFILE_NAME=""
     local LOGFILE=""
     local OUTPUTFILE_NAME=""
@@ -194,7 +201,7 @@ main()
     local DEFAULT_FILE_NAME_GENERATION_TIME=`date +"%Y_%b_%d-%Hh_%Mm_%Ss"`
     version_date=`head -n 1 $LTPROOT/ChangeLog`
 
-    while getopts a:c:C:d:D:f:ehi:g:l:m:Nno:pqr:s:S:t:T:vw:x:b:B: arg
+    while getopts a:c:C:d:D:f:F:ehi:g:l:m:Nno:pqr:s:S:t:T:vw:x:b:B: arg
     do  case $arg in
         a)  EMAIL_TO=$OPTARG
             ALT_EMAIL_OUT=1;;
@@ -264,6 +271,18 @@ main()
             # Can be more then one file, just separate it with ',', like:
             # -f nfs,commands,/tmp/testfile
             CMDFILES=$OPTARG;;
+	F)	INJECT_KERNEL_FAULT=1
+		#Seperate out the NO_OF_LOOPS & FAULT_PERCENTAGE
+		INJECT_FAULT_LOOPS_PER_TEST=`echo $OPTARG |cut -d',' -f1 | tr -d '\n' | tr -d ' '`
+		INJECT_KERNEL_FAULT_PERCENTAGE=`echo $OPTARG |cut -d',' -f2 | tr -d '\n' | tr -d ' '`
+		if [ ! $INJECT_FAULT_LOOPS_PER_TEST ]; then
+			echo "Loops not properly defined. Resorting to default 5..."
+			export INJECT_FAULT_LOOPS_PER_TEST=5
+		fi
+		if [ ! $INJECT_KERNEL_FAULT_PERCENTAGE ]; then
+			echo "Fault Persentage not properly defined. Resorting to default 10..."
+			export INJECT_KERNEL_FAULT_PERCENTAGE=10
+		fi;;
         g)  HTMLFILE_NAME="$OPTARG"
             case $OPTARG in
             /*)
@@ -754,6 +773,28 @@ main()
     echo "Running tests......."
     test_start_time=$(date)
 
+	# User wants testing with Kernel Fault Injection
+	if [ $INJECT_KERNEL_FAULT -eq 1 ] ; then
+		#See if Debugfs is mounted, and
+		#Fault Injection Framework available through Debugfs
+		if [ -d "/sys/kernel/debug/fail_io_timeout" -o \
+			-d "/sys/kernel/debug/fail_make_request" -o \
+			-d "/sys/kernel/debug/fail_page_alloc" -o \
+			-d "/sys/kernel/debug/failslab" ]; then
+			#If atleast one of the Framework is available
+			#Go ahead to Inject Fault & Create required
+			#Command Files for LTP run
+			echo Running tests with Fault Injection Enabled in the Kernel...
+			${LTPROOT}/tools/create_kernel_faults_in_loops_and_probability.pl\
+				${TMP}/alltests $INJECT_FAULT_LOOPS_PER_TEST $INJECT_KERNEL_FAULT_PERCENTAGE > ${TMP}/alltests.tmp
+			cp ${TMP}/alltests.tmp ${TMP}/alltests
+			rm -rf ${TMP}/alltests.tmp
+		else
+			echo Fault Injection not enabled in the Kernel..
+			echo Running tests normally...
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
