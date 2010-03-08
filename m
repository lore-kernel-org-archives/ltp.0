Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <shiwh@cn.fujitsu.com>) id 1NoT9C-0002GE-Fj
	for ltp-list@lists.sourceforge.net; Mon, 08 Mar 2010 02:56:46 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NoT9A-0002YB-Sm
	for ltp-list@lists.sourceforge.net; Mon, 08 Mar 2010 02:56:46 +0000
Message-ID: <4B946761.8030301@cn.fujitsu.com>
Date: Mon, 08 Mar 2010 10:56:33 +0800
From: Shi Weihua <shiwh@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050500070505030102020201"
Subject: [LTP] [BUG?] container_test.sh: should to delete
 check_for_unshare's source in cvs/git ?
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
To: Garrett Cooper <yanegomi@gmail.com>, Rishikesh <risrajak@linux.vnet.ibm.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------050500070505030102020201
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Tested the latest cvs version (about Mar 1) on my x86_64 (2.6.33).
The following message occured:
--------------------------------
<<<test_start>>>
tag=Containers stime=1267527554
cmdline="container_test.sh"
contacts=""
analysis=exit
<<<test_output>>>
/opt/ltp/testcases/bin/container_test.sh: line 13: check_for_unshare: command not found
Running utsns tests.
unshare tests
test 1 (unshare)
test 2 (unshare)
......
--------------------------------

I noticed that check_for_unshare had been deleted in LTP-20091031.
In ./ChangeLog (from latest cvs version)
   ...
   2905	LTP-20091031
   ...
   3141 Removed Files:
   3142 ltp/README.ltp-devel
   3143 ltp/config.mk.in
   3144 ltp/ltp-devel.spec
   3145 ltp/testcases/kernel/containers/check_for_unshare.c
   ...
   3997 LTP-20090930

Also, i noticed check_for_unshare commentted in container_test.sh in 
release version of FEBRUARY 2010. pls check the diff between cvs version 
and release version of Feb in attached file.

Now, my question: should to delete check_for_unshare's source in cvs/git ?

--------------050500070505030102020201
Content-Type: text/plain;
 name="container_test.sh.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="container_test.sh.diff"

--- ltp/testcases/kernel/containers/container_test.sh	2010-02-22 14:21:40.000000000 -0500
+++ ltp-full-20100228/testcases/kernel/containers/container_test.sh	2010-03-03 11:43:19.000000000 -0500
@@ -10,11 +10,11 @@
 # any later version.
 
 #check_utsns_enabled
-check_for_unshare
-if [ $? -eq 1 ]; then
-	echo "Unshare not supported.  Not running container tests"
-	exit 0
-fi
+#check_for_unshare
+#if [ $? -eq 1 ]; then
+#	echo "Unshare not supported.  Not running container tests"
+#	exit 0
+#fi
 check_utsns_enabled
 if [ $? -eq 0 ]; then
 	echo "Running utsns tests."
@@ -46,11 +46,22 @@ else
 	echo "ipc namespaces not enabled in kernel.  Not running ipcns tests."
 fi
 
-echo "Running pidns tests."
-runpidnstest.sh
+check_pidns_enabled
+if [ $? -eq 0 ]; then
+	echo "Running pidns tests."
+	runpidnstest.sh
+else
+	echo "Process id namespaces not enabled in kernel.  Not running pidns tests."
+fi
 
-echo "Running POSIX message queue tests."
-runmqnstest.sh
+check_mqns_enabled
+if [ $? -eq 0 ]; then
+    echo "Running POSIX message queue tests."
+    runmqnstest.sh
+else
+    echo "Posix message queues or ipc namespaces not enabled in kernel."
+    echo "Not running mqns tests."
+fi
 
 check_netns_enabled
 if [ $? -eq 0 ]; then
@@ -59,4 +70,3 @@ if [ $? -eq 0 ]; then
 else
 	echo "Network namespaces not enabled in kernel.  Not running netns tests."
 fi
-

--------------050500070505030102020201
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
--------------050500070505030102020201
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------050500070505030102020201--

