Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <siva.padhy@lge.com>) id 1Vfgo9-0005kW-Jy
	for ltp-list@lists.sourceforge.net; Mon, 11 Nov 2013 02:00:53 +0000
Received: from lgeamrelo02.lge.com ([156.147.1.126])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Vfgo7-0006pv-Jq
	for ltp-list@lists.sourceforge.net; Mon, 11 Nov 2013 02:00:53 +0000
From: Siva Padhy <siva.padhy@lge.com>
Date: Mon, 11 Nov 2013 10:51:25 +0900
Message-ID: <81212EE27BC298499DBD7CA069AAD07142E38D167A@LGEVEXMBAPSVC2.LGE.NET>
Content-Language: en-US
MIME-Version: 1.0
Subject: [LTP] [PATCH V2] BindMounts: fix to properly unmount during cleanup
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

The fs_bind testcases creates the mount directories for testing.
When the testcase exits, those directories were not properly unmounted.
The reason of the issues are:

 1. Some directories were kept mounted, even after the cleanup() routine, as the unmount code is missing.
 2. Some "umount" command execution fails, as they are dependent on some other mounted directories.

Error Report
------------
rbind/test02    1  TPASS  :  rbind/test02: PASSED
/kvt.new/ltp/testscripts/test_fs_bind.sh    0  TWARN  :  rbind/test02 did not properly clean up "/tmp/ltp-XXXX9qdYqG/sandbox"

rbind/test38    1  TPASS  :  rbind/test38: PASSED
/kvt.new/ltp/testscripts/test_fs_bind.sh    0  TWARN  :  rbind/test38 did not properly clean up "/tmp/ltp-XXXX9qdYqG/sandbox"

This patch add/reorder the unmount code to fix the above TWARN messages.

Modified-by: Jan Stancek <jstancek@redhat.com>
Signed-off-by: Siva  <siva.padhy@lge.com>
---
 testcases/kernel/fs/fs_bind/rbind/test02 |   18 +++++++-----------
 testcases/kernel/fs/fs_bind/rbind/test38 |    4 ++--
 2 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/testcases/kernel/fs/fs_bind/rbind/test02 b/testcases/kernel/fs/fs_bind/rbind/test02
index 3ab7b6c..f68f691 100755
--- a/testcases/kernel/fs/fs_bind/rbind/test02
+++ b/testcases/kernel/fs/fs_bind/rbind/test02
@@ -1,5 +1,4 @@
 #!/bin/bash
-
 #
 # Copyright (c) International Business Machines  Corp., 2005
 # Author: Avantika Mathur (mathurav@us.ibm.com)
@@ -38,9 +37,6 @@ trap 'ERR=$? ; ERR_MSG="caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LI
 while /bin/true ; do
 	# This loop is for error recovery purposes only
 
-
-
-
 	"${FS_BIND_ROOT}/bin/makedir" share parent1
 	"${FS_BIND_ROOT}/bin/makedir" priv parent2
 	"${FS_BIND_ROOT}/bin/makedir" share share1
@@ -74,10 +70,10 @@ if [ -n "${ERR_MSG}" ]; then
 fi
 trap '' ERR
 {
+	umount parent2/child2/b
 	umount parent1/child1/a
-	umount parent1/child1/b
-	umount parent1/child1
-	umount parent1/child1
+	umount parent2/child2
+	umount share1
 	umount parent1/child1
 	umount parent1/child1
 	umount share1
@@ -90,11 +86,11 @@ trap '' ERR
 
 if [ $result -ne 0 ]
 then
-        tst_resm TFAIL "rbind/test02: FAILED: rbind: shared child to private parent."
-        exit 1
+	tst_resm TFAIL "rbind/test02: FAILED: rbind: shared child to private parent."
+	exit 1
 else
-        tst_resm TPASS "rbind/test02: PASSED"
-        exit 0
+	tst_resm TPASS "rbind/test02: PASSED"
+	exit 0
 fi
 
 
diff --git a/testcases/kernel/fs/fs_bind/rbind/test38 b/testcases/kernel/fs/fs_bind/rbind/test38
index c9cf3e1..ae7477e 100755
--- a/testcases/kernel/fs/fs_bind/rbind/test38
+++ b/testcases/kernel/fs/fs_bind/rbind/test38
@@ -1,5 +1,4 @@
 #!/bin/bash
-
 #
 # Copyright (c) International Business Machines  Corp., 2005
 # Author: Avantika Mathur (mathurav@us.ibm.com)
@@ -82,10 +81,11 @@ trap '' ERR
 	umount parent1/child1
 	umount parent2/child1
 	umount parent2/child1
-	umount parent2/child2
 	umount parent2
 	umount share1
 	umount share1
+	umount share2
+	umount parent2/child2
 
 	rm -rf parent* share*
 	cleanup
-- 
1.7.9.5


------------------------------------------------------------------------------
November Webinars for C, C++, Fortran Developers
Accelerate application performance with scalable programming models. Explore
techniques for threading, error checking, porting, and tuning. Get the most 
from the latest Intel processors and coprocessors. See abstracts and register
http://pubads.g.doubleclick.net/gampad/clk?id=60136231&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
