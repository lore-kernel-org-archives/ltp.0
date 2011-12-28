Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1RfnCN-0007z6-Vj
	for ltp-list@lists.sourceforge.net; Wed, 28 Dec 2011 06:41:15 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1RfnCK-0000XQ-WC
	for ltp-list@lists.sourceforge.net; Wed, 28 Dec 2011 06:41:15 +0000
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Date: Wed, 28 Dec 2011 14:40:03 +0800
Message-Id: <1325054403-17741-1-git-send-email-gaowanlong@cn.fujitsu.com>
In-Reply-To: <1322044169-30851-1-git-send-email-gaowanlong@cn.fujitsu.com>
References: <1322044169-30851-1-git-send-email-gaowanlong@cn.fujitsu.com>
Subject: [LTP] [PATCH 7/5] hugemmap: change hard-coded page alloc size to a
	macro
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
To: caspar@casparzhang.com
Cc: ltp-list@lists.sourceforge.net

change the hard-coded alloc size to a macro, because hard-coded is
not a good idea.

Signed-off-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>
---
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c |    3 ++-
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c |    3 ++-
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap03.c |    3 ++-
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c |    3 ++-
 4 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c
index 906f7e4..ca68fb5 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c
@@ -76,6 +76,7 @@
 #include "libmnt.h"
 
 #define BUFFER_SIZE  256
+#define PAGE_ALLOC_SIZE	1024
 
 char TEMPFILE[MAXPATHLEN];
 
@@ -183,7 +184,7 @@ setup(void)
 	tst_tmpdir();
 	mount_point = get_tst_tmpdir();
 	mount_hugetlbfs(mount_point);
-	hugepage_alloc(1024);
+	hugepage_alloc(PAGE_ALLOC_SIZE);
 	snprintf(TEMPFILE, sizeof(TEMPFILE), "%s/mmapfile%d",
 		mount_point, getpid());
 }
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
index 3bbbc46..349e564 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
@@ -67,6 +67,7 @@
 
 #define LOW_ADDR       (void *)(0x80000000)
 #define LOW_ADDR2      (void *)(0x90000000)
+#define PAGE_ALLOC_SIZE	1024
 
 char TEMPFILE[MAXPATHLEN];
 
@@ -197,7 +198,7 @@ setup(void)
 	mount_point = get_tst_tmpdir();
 
 	mount_hugetlbfs(mount_point);
-	hugepage_alloc(1024);
+	hugepage_alloc(PAGE_ALLOC_SIZE);
 
 	snprintf(TEMPFILE, sizeof(TEMPFILE), "%s/mmapfile%d", mount_point, getpid());
 }
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap03.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap03.c
index b17b19d..866ca57 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap03.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap03.c
@@ -57,6 +57,7 @@
 #include "libmnt.h"
 
 #define HIGH_ADDR      (void *)(0x1000000000000)
+#define PAGE_ALLOC_SIZE	1024
 
 char TEMPFILE[MAXPATHLEN];
 
@@ -143,7 +144,7 @@ setup(void)
 	mount_point = get_tst_tmpdir();
 
 	mount_hugetlbfs(mount_point);
-	hugepage_alloc(1024);
+	hugepage_alloc(PAGE_ALLOC_SIZE);
 
 	snprintf(TEMPFILE, sizeof(TEMPFILE), "%s/mmapfile%d", mount_point, getpid());
 }
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
index 9774e87..2eea936 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
@@ -76,6 +76,7 @@
 #include "libmnt.h"
 
 #define BUFFER_SIZE  256
+#define PAGE_ALLOC_SIZE	1024
 
 char TEMPFILE[MAXPATHLEN];
 
@@ -192,7 +193,7 @@ setup()
 	mount_point = get_tst_tmpdir();
 
 	mount_hugetlbfs(mount_point);
-	hugepage_alloc(1024);
+	hugepage_alloc(PAGE_ALLOC_SIZE);
 
 	snprintf(TEMPFILE, sizeof(TEMPFILE), "%s/mmapfile%d", mount_point, getpid());
 }
-- 
1.7.8


------------------------------------------------------------------------------
Write once. Port to many.
Get the SDK and tools to simplify cross-platform app development. Create 
new or port existing apps to sell to consumers worldwide. Explore the 
Intel AppUpSM program developer opportunity. appdeveloper.intel.com/join
http://p.sf.net/sfu/intel-appdev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
