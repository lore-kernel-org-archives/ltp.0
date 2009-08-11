Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MavC1-0007LT-2k
	for ltp-list@lists.sourceforge.net; Tue, 11 Aug 2009 17:31:25 +0000
Received: from e3.ny.us.ibm.com ([32.97.182.143])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MavBv-0007h3-DS
	for ltp-list@lists.sourceforge.net; Tue, 11 Aug 2009 17:31:25 +0000
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n7BHOs6h015050
	for <ltp-list@lists.sourceforge.net>; Tue, 11 Aug 2009 13:24:54 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7BHVDlj232616
	for <ltp-list@lists.sourceforge.net>; Tue, 11 Aug 2009 13:31:13 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n7BHSNnw030161
	for <ltp-list@lists.sourceforge.net>; Tue, 11 Aug 2009 13:28:24 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
Date: Tue, 11 Aug 2009 23:01:01 +0530
Message-Id: <20090811173101.7074.31798.sendpatchset@subratamodak.linux.ibm.com>
In-Reply-To: <20090811172957.7074.62874.sendpatchset@subratamodak.linux.ibm.com>
References: <20090811172957.7074.62874.sendpatchset@subratamodak.linux.ibm.com>
Subject: [LTP] [PATCH 05/05] Add the necessary Interface and Option through
	"runltp"
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

Signed-off-by: Subrata Modak <subrata@linux.vnet.ibm.com>
---

--- ltp-full-20090731.orig/runltp	2009-08-11 16:55:24.000000000 +0530
+++ ltp-full-20090731/runltp	2009-08-11 20:28:58.000000000 +0530
@@ -106,6 +106,7 @@ usage() 
     usage: ./${0##*/} [ -a EMAIL_TO ] [ -c NUM_PROCS ] [ -C FAILCMDFILE ] [ -d TMPDIR ]
     [ -D NUM_PROCS,NUM_FILES,NUM_BYTES,CLEAN_FLAG ] -e [ -f CMDFILES(,...) ] [ -g HTMLFILE]
     [ -i NUM_PROCS ] [ -l LOGFILE ] [ -m NUM_PROCS,CHUNKS,BYTES,HANGUP_FLAG ] 
+	[ -F LOOPS,PERCENTAGE ]
     -N -n [ -o OUTPUTFILE ] -p -q [ -r LTPROOT ] [ -s PATTERN ] [ -t DURATION ]
     -v [ -w CMDFILEADDR ] [ -x INSTANCES ] [ -b DEVICE ] [-B DEVICE_FS_TYPE]
                 
@@ -123,6 +124,7 @@ usage() 
                     [CLEAN_FLAG  = unlink file to which random data written, when value 1]
     -e              Prints the date of the current LTP release
     -f CMDFILES     Execute user defined list of testcases (separate with ',')
+	-F LOOPS,PERCENTAGE Induce PERCENTAGE Fault in the Kernel Subsystems, and, run each test for LOOPS loop
     -g HTMLFILE     Create an additional HTML output format
     -h              Help. Prints all available options.
     -i NUM_PROCS    Run LTP under additional background Load on IO Bus
@@ -180,6 +182,9 @@ main()
     local DURATION=""
     local CMDFILEADDR=""
     local FAILCMDFILE=""
+	local INJECT_KERNEL_FAULT=""
+	local INJECT_KERNEL_FAULT_PERCENTAGE=""
+	local INJECT_FAULT_LOOPS_PER_TEST=""
     local LOGFILE_NAME=""
     local LOGFILE=""
     local OUTPUTFILE_NAME=""
@@ -193,7 +198,7 @@ main()
     local DEFAULT_FILE_NAME_GENERATION_TIME=`date +"%Y_%b_%d-%Hh_%Mm_%Ss"`
     version_date=`head -n 1 $LTPROOT/ChangeLog`
 
-    while getopts a:c:C:d:D:f:ehi:g:l:m:Nno:pqr:s:t:T:vw:x:b:B: arg
+    while getopts a:c:C:d:D:f::F:ehi:g:l:m:Nno:pqr:s:t:T:vw:x:b:B: arg
     do  case $arg in
         a)  EMAIL_TO=$OPTARG
             ALT_EMAIL_OUT=1;;
@@ -263,6 +268,18 @@ main()
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
@@ -738,6 +755,28 @@ main()
     echo "Running tests......."
     test_start_time=$(date)
 
+	# User wants testing with Kernel Fault Injection
+	if [ $INJECT_KERNEL_FAULT -eq 1 ] ; then
+		#See if Debugfs is mounted, and
+		#Fault Injection Framework available through Debugfs
+		if [ -d "/debug/fail_io_timeout" -o \
+			-d "/debug/fail_make_request" -o \
+			-d "/debug/fail_page_alloc" -o \
+			-d "/debug/failslab" ]; then
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
