Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <serge@us.ibm.com>) id 1MgBVn-0003Ag-1k
	for ltp-list@lists.sourceforge.net; Wed, 26 Aug 2009 05:57:35 +0000
Received: from e34.co.us.ibm.com ([32.97.110.152])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MgBVf-00007K-2t
	for ltp-list@lists.sourceforge.net; Wed, 26 Aug 2009 05:57:35 +0000
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e34.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n7Q5rHLg009023
	for <ltp-list@lists.sourceforge.net>; Tue, 25 Aug 2009 23:53:17 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7Q5vHS5224758
	for <ltp-list@lists.sourceforge.net>; Tue, 25 Aug 2009 23:57:17 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n7Q5vGIU006741
	for <ltp-list@lists.sourceforge.net>; Tue, 25 Aug 2009 23:57:17 -0600
Date: Wed, 26 Aug 2009 00:57:14 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
Message-ID: <20090826055713.GA22281@us.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [LTP] [PATCH 1/1] netns: don't run sysfsview testcase
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
To: LTP <ltp-list@lists.sourceforge.net>

It can't pass right now, and leaves the system in a bad state on
its inevitable failure.

Leave the testcase there though since one day we will hopefully
support it.

Signed-off-by: Serge Hallyn <serge@us.ibm.com>
---
 testcases/kernel/containers/netns/runnetnstest.sh |   25 ++++++++++++--------
 1 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/testcases/kernel/containers/netns/runnetnstest.sh b/testcases/kernel/containers/netns/runnetnstest.sh
index 8a52e7b..e5ae694 100755
--- a/testcases/kernel/containers/netns/runnetnstest.sh
+++ b/testcases/kernel/containers/netns/runnetnstest.sh
@@ -90,16 +90,21 @@ else
 fi
 echo
 
-sysfsview
-rc=$?
-if [ $rc -ne 0 ]; then
-    exit_code=$rc
-    errmesg="$errmesg sysfsview: return code is $exit_code ; "
-    echo $errmesg
-else
-   echo "sysfsview: PASS"
-fi
-echo
+# sysfs tagging does not exist, so this test can't pass.  In
+# fact at the moment it fails when mount -t sysfs none /sys is
+# refused, fails in a bad state, leaving the system hard to
+# reboot.  Revisit enabling this test when per-container sysfs
+# views are supported.
+#sysfsview
+#rc=$?
+#if [ $rc -ne 0 ]; then
+#    exit_code=$rc
+#    errmesg="$errmesg sysfsview: return code is $exit_code ; "
+#    echo $errmesg
+#else
+#   echo "sysfsview: PASS"
+#fi
+#echo
 
 par_chld_ftp
 rc=$?
-- 
1.6.0.4


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
