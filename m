Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <penght@cn.fujitsu.com>) id 1SAH9v-0005tj-5n
	for ltp-list@lists.sourceforge.net; Wed, 21 Mar 2012 08:44:43 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SAH9p-0007VM-1W
	for ltp-list@lists.sourceforge.net; Wed, 21 Mar 2012 08:44:43 +0000
From: Peng Haitao <penght@cn.fujitsu.com>
Date: Wed, 21 Mar 2012 16:43:28 +0800
Message-Id: <1332319408-18331-1-git-send-email-penght@cn.fujitsu.com>
In-Reply-To: <4F6310E3.2000403@cn.fujitsu.com>
References: <4F6310E3.2000403@cn.fujitsu.com>
Subject: [LTP] [PATCH v5] aio_read:8-1.c: Forget initializing struct aiocb
	before using it
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
To: gaowanlong@cn.fujitsu.com, yanegomi@gmail.com
Cc: ltp-list@lists.sourceforge.net

There are 2 changes in this patch.
 1. Initialize the aiocb struct before using it.
 2. If Prioritized Input and Output option is supported, submit the
    aiocb with invalid aio_reqprio, else return untested.

Signed-off-by: Peng Haitao <penght@cn.fujitsu.com>
---
 .../conformance/interfaces/aio_read/8-1.c               |   13 +++++++------
 .../conformance/interfaces/aio_write/6-1.c              |   15 ++++++++-------
 2 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_read/8-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_read/8-1.c
index 8054eeb..ea0538e 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_read/8-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_read/8-1.c
@@ -14,7 +14,8 @@
  *
  * method:
  *
- *	- fill in an aiocb with a NULL aio_buf
+ *	- if Prioritized Input and Output option is supported, fill in an
+ *	  aiocb with invalid aio_reqprio.
  *	- call aio_read
  *	- check aio_read return value
  */
@@ -41,11 +42,11 @@ int main()
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		return PTS_UNSUPPORTED;
 
-	/* submit a request with a NULL buffer */
-	aiocb.aio_fildes = 0;
-	aiocb.aio_buf = NULL;
-	aiocb.aio_nbytes = 0;
-	aiocb.aio_offset = 0;
+	if (sysconf(_SC_PRIORITIZED_IO) < 200112L)
+		return PTS_UNTESTED;
+
+	memset(&aiocb, 0, sizeof(struct aiocb));
+	aiocb.aio_reqprio = -1;
 
 	if (aio_read(&aiocb) != -1) {
 		printf(TNAME " aio_read() should fail!\n");
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_write/6-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_write/6-1.c
index 98b8d0d..744c82c 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_write/6-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_write/6-1.c
@@ -14,7 +14,8 @@
  *
  * method:
  *
- *	- fill in an aiocb with a NULL aio_buf
+ *	- if Prioritized Input and Output option is supported, fill in an
+ *	  aiocb with invalid aio_reqprio
  *	- call aio_write
  *	- check aio_write return value
  *
@@ -42,11 +43,11 @@ int main()
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		return PTS_UNSUPPORTED;
 
-	/* submit a request with a NULL buffer */
-	aiocb.aio_fildes = 0;
-	aiocb.aio_buf = NULL;
-	aiocb.aio_nbytes = 0;
-	aiocb.aio_offset = 0;
+	if (sysconf(_SC_PRIORITIZED_IO) < 200112L)
+		return PTS_UNTESTED;
+
+	memset(&aiocb, 0, sizeof(struct aiocb));
+	aiocb.aio_reqprio = -1;
 
 	if (aio_write(&aiocb) != -1)
 	{
@@ -62,4 +63,4 @@ int main()
 
 	printf ("Test PASSED\n");
 	return PTS_PASS;
-}
\ No newline at end of file
+}
-- 
1.7.10.rc1


------------------------------------------------------------------------------
This SF email is sponsosred by:
Try Windows Azure free for 90 days Click Here 
http://p.sf.net/sfu/sfd2d-msazure
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
