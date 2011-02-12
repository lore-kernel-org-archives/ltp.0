Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1PoJk2-0005Lz-EF
	for ltp-list@lists.sourceforge.net; Sat, 12 Feb 2011 17:58:42 +0000
Received: from e2.ny.us.ibm.com ([32.97.182.142])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.74) id 1PoJk1-0002kd-6g
	for ltp-list@lists.sourceforge.net; Sat, 12 Feb 2011 17:58:42 +0000
From: Subrata Modak <subrata@linux.vnet.ibm.com>
Date: Sat, 12 Feb 2011 23:28:28 +0530
Message-Id: <20110212175827.6308.29198.sendpatchset@subratamodak.linux.ibm.com>
Subject: [LTP] [PATCH] Fix Usage Reference of those tools utilities
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
To: LTP Mailing List <ltp-list@lists.sf.net>

Useful scripts under ltp/tools are no more installed @{LTP_ROOT}/tools,
they are done under @{LTP_ROOT}/bin. Change their reference accordingly
inside 'runltp' script. Nobody noticed this early as probably these
options are least used in LTP ;-)

Signed-off-by: Subrata Modak <subrata@linux.vnet.ibm.com>

---
diff --git a/runltp b/runltp
index 2c6785f..381e123 100755
--- a/runltp
+++ b/runltp
@@ -779,7 +779,7 @@ main()
 			#Go ahead to Inject Fault & Create required
 			#Command Files for LTP run
 			echo Running tests with Fault Injection Enabled in the Kernel...
-			${LTPROOT}/tools/create_kernel_faults_in_loops_and_probability.pl\
+			${LTPROOT}/bin/create_kernel_faults_in_loops_and_probability.pl\
 				${TMP}/alltests $INJECT_FAULT_LOOPS_PER_TEST $INJECT_KERNEL_FAULT_PERCENTAGE > ${TMP}/alltests.tmp
 			cp ${TMP}/alltests.tmp ${TMP}/alltests
 			rm -rf ${TMP}/alltests.tmp
@@ -796,15 +796,15 @@ main()
 			which valgrind || VALGRIND_CHECK_TYPE=XYZ
 			case $VALGRIND_CHECK_TYPE in
 				1)
-				${LTPROOT}/tools/create_valgrind_check.pl ${TMP}/alltests 1 > ${TMP}/alltests.tmp
+				${LTPROOT}/bin/create_valgrind_check.pl ${TMP}/alltests 1 > ${TMP}/alltests.tmp
 				cp ${TMP}/alltests.tmp ${TMP}/alltests
 				rm -rf ${TMP}/alltests.tmp;;
 				2)
-				${LTPROOT}/tools/create_valgrind_check.pl ${TMP}/alltests 2 > ${TMP}/alltests.tmp
+				${LTPROOT}/bin/create_valgrind_check.pl ${TMP}/alltests 2 > ${TMP}/alltests.tmp
 				cp ${TMP}/alltests.tmp ${TMP}/alltests
 				rm -rf ${TMP}/alltests.tmp;;
 				3)
-				${LTPROOT}/tools/create_valgrind_check.pl ${TMP}/alltests 3 > ${TMP}/alltests.tmp
+				${LTPROOT}/bin/create_valgrind_check.pl ${TMP}/alltests 3 > ${TMP}/alltests.tmp
 				cp ${TMP}/alltests.tmp ${TMP}/alltests
 				rm -rf ${TMP}/alltests.tmp;;
 				*) echo "Invalid Memory Check Type, or, Valgrind is not available";;
@@ -859,7 +859,7 @@ main()
        export TEST_OUTPUT_DIRECTORY="$LTPROOT/output"
        export TEST_LOGS_DIRECTORY=$LOGS_DIRECTORY
        echo "Generating HTML Output.....!!"
-       ( perl $LTPROOT/bin/genhtml.pl $LTPROOT/tools/html_report_header.txt test_start test_end test_output execution_status $OUTPUT_DIRECTORY  > $HTMLFILE; )   
+       ( perl $LTPROOT/bin/genhtml.pl $LTPROOT/bin/html_report_header.txt test_start test_end test_output execution_status $OUTPUT_DIRECTORY  > $HTMLFILE; )   
        echo "Generated HTML Output.....!!"
        echo "Location: $HTMLFILE";
 
---

Regards--
Subrata


------------------------------------------------------------------------------
The ultimate all-in-one performance toolkit: Intel(R) Parallel Studio XE:
Pinpoint memory and threading errors before they happen.
Find and fix more than 250 security defects in the development cycle.
Locate bottlenecks in serial and parallel code that limit performance.
http://p.sf.net/sfu/intel-dev2devfeb
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
