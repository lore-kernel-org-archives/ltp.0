Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <siva.padhy@lge.com>) id 1VdzgW-0006eM-Jx
	for ltp-list@lists.sourceforge.net; Wed, 06 Nov 2013 09:46:00 +0000
Received: from lgeamrelo02.lge.com ([156.147.1.126])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VdzgV-0001xv-6b
	for ltp-list@lists.sourceforge.net; Wed, 06 Nov 2013 09:46:00 +0000
From: Siva Padhy <siva.padhy@lge.com>
Date: Wed, 6 Nov 2013 18:45:51 +0900
Message-ID: <81212EE27BC298499DBD7CA069AAD071428CD96A5A@LGEVEXMBAPSVC2.LGE.NET>
Content-Language: en-US
MIME-Version: 1.0
Subject: [LTP] [PATCH v2] BindMounts: fix to properly unmount during cleanup
 in fs_bind
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

While running fs_bound testcases, some test directory structure are mounted
using -rbind option. While exiting the testcase the umount is not properly
done, hence the below testcase are falling into TWARN.

  fs_bind/test02
  fs_bind/test38

The warning message is as below for respective testcases
  TWARN  :  rbind/test02 did not properly clean up "/tmp/ltp-XXXX9qdYqG/sandbox"
  TWARN  :  rbind/test38 did not properly clean up "/tmp/ltp-XXXX9qdYqG/sandbox"

This patch unmount all the mounted/submounted parts of the filesystem properly.

Change-Id: Ica6d1799b89e933587c11c1755dff996ddbdf8c5
Signed-off-by: Siva <siva.padhy@lge.com>
---
 testcases/kernel/fs/fs_bind/rbind/test02 |    2 ++
 testcases/kernel/fs/fs_bind/rbind/test38 |    5 +++++
 2 files changed, 7 insertions(+)

diff --git a/testcases/kernel/fs/fs_bind/rbind/test02 b/testcases/kernel/fs/fs_bind/rbind/test02
index 3ab7b6c..eab9cdc 100755
--- a/testcases/kernel/fs/fs_bind/rbind/test02
+++ b/testcases/kernel/fs/fs_bind/rbind/test02
@@ -76,8 +76,10 @@ trap '' ERR
 {
 	umount parent1/child1/a
 	umount parent1/child1/b
+	umount parent2/child2/b
 	umount parent1/child1
 	umount parent1/child1
+	umount parent2/child2
 	umount parent1/child1
 	umount parent1/child1
 	umount share1
diff --git a/testcases/kernel/fs/fs_bind/rbind/test38 b/testcases/kernel/fs/fs_bind/rbind/test38
index c9cf3e1..c944ce5 100755
--- a/testcases/kernel/fs/fs_bind/rbind/test38
+++ b/testcases/kernel/fs/fs_bind/rbind/test38
@@ -77,6 +77,7 @@ trap '' ERR
 {
 	umount share1/a
 	umount parent1/child1/b
+	umount parent2/child1/b
 	umount parent2/child1/c
 	umount parent1/child1
 	umount parent1/child1
@@ -86,6 +87,10 @@ trap '' ERR
 	umount parent2
 	umount share1
 	umount share1
+	umount parent1
+	umount share2
+	umount parent2/child2
+	umount parent2
 
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
