Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <biannm@cn.fujitsu.com>) id 1PXW0K-0002hi-0N
	for ltp-list@lists.sourceforge.net; Tue, 28 Dec 2010 09:38:04 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PXW0I-0007zd-12
	for ltp-list@lists.sourceforge.net; Tue, 28 Dec 2010 09:38:03 +0000
Message-ID: <4D19AF34.9030907@cn.fujitsu.com>
Date: Tue, 28 Dec 2010 17:34:44 +0800
From: Bian Naimeng <biannm@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH]Fix bug of hugemmap
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Man pages of mmap said: 

  Use of a mapped region can result in these signals:
    SIGSEGV
       Attempted write into a region mapped as read-only.
    SIGBUS
       Attempted access to a portion of the buffer that does not correspond to the
       file (for example, beyond the end of the  file,  including  the  case where
       another process has truncated the file).

So we should make sure the size of file is not zero, otherwise test will fail
when write to the mapped region.

Signed-off-by: Bian Naimeng <biannm@cn.fujitsu.com>

---
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c |   11 +++++++++--
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c |   11 +++++++++--
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c
index 3676f1b..33b3ade 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c
@@ -73,7 +73,8 @@
 #include "test.h"
 #include "usctest.h"
 
-#define BUFFER_SIZE  256
+#define BUFFER_SIZE	256
+#define FILE_SIZE	1024
 
 char* TEMPFILE="mmapfile";
 
@@ -129,12 +130,18 @@ main(int ac, char **av)
 	/* Check looping state if -i option given */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-	        /* Creat a temporary file used for mapping */
+	        /* Creat a temporary file used for mapping,and truncate it */
 		if ((fildes = open(TEMPFILE, O_RDWR | O_CREAT, 0666)) < 0) {
 			tst_brkm(TFAIL, cleanup,
 				 "open() on %s Failed, errno=%d : %s",
 				 TEMPFILE, errno, strerror(errno));
 		}
+		if (ftruncate(fildes, FILE_SIZE) < 0) {
+			close(fildes);
+			tst_brkm(TFAIL, cleanup,
+				 "ftruncate() on %s Failed, errno=%d : %s",
+				 TEMPFILE, errno, strerror(errno));
+		}
 		/* Reset Tst_count in case we are looping. */
 		Tst_count=0;
 
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
index c3b7af2..02d7e9f 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
@@ -74,7 +74,8 @@
 #include "usctest.h"
 #include "system_specific_hugepages_info.h"
 
-#define BUFFER_SIZE  256
+#define BUFFER_SIZE	256
+#define FILE_SIZE	1024
 
 char* TEMPFILE="mmapfile";
 
@@ -135,12 +136,18 @@ main(int ac, char **av)
 	/* Check looping state if -i option given */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-	        /* Creat a temporary file used for mapping */
+	        /* Creat a temporary file used for mapping, and truncate it */
 		if ((fildes = open(TEMPFILE, O_RDWR | O_CREAT, 0666)) < 0) {
 			tst_brkm(TFAIL, cleanup,
 				 "open() on %s Failed, errno=%d : %s",
 				 TEMPFILE, errno, strerror(errno));
 		}
+		if (ftruncate(fildes, FILE_SIZE) < 0) {
+			close(fildes);
+			tst_brkm(TFAIL, cleanup,
+				 "ftruncate() on %s Failed, errno=%d : %s",
+				 TEMPFILE, errno, strerror(errno));
+		}
 		/* Reset Tst_count in case we are looping. */
 		Tst_count=0;
 
-- 
1.7.0.4



------------------------------------------------------------------------------
Learn how Oracle Real Application Clusters (RAC) One Node allows customers
to consolidate database storage, standardize their database environment, and, 
should the need arise, upgrade to a full multi-node Oracle RAC database 
without downtime or disruption
http://p.sf.net/sfu/oracle-sfdevnl
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
