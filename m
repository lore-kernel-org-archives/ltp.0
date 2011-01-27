Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <biannm@cn.fujitsu.com>) id 1PiO0x-0000Ye-IT
	for ltp-list@lists.sourceforge.net; Thu, 27 Jan 2011 09:19:39 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1PiO0v-0002cA-FE
	for ltp-list@lists.sourceforge.net; Thu, 27 Jan 2011 09:19:39 +0000
Message-ID: <4D413877.6000003@cn.fujitsu.com>
Date: Thu, 27 Jan 2011 17:18:47 +0800
From: Bian Naimeng <biannm@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [POSIX][PATCH]fix test conformance/interfaces/aio_cancel/7-1.c
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

When i test conformance/interfaces/aio_cancel/7-1 on the same OS,
it will report some different results, such as PASS, UNRESOLVED.
The probable one is UNRESOLVED, it looks not a stable case.

After applying following patch, the test will become stable.

Signed-off-by: Bian Naimeng <biannm@cn.fujitsu.com>

---
 .../conformance/interfaces/aio_cancel/7-1.c        |  192 ++++++++++++--------
 1 files changed, 112 insertions(+), 80 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/7-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/7-1.c
index c37f184..a410152 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/7-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/7-1.c
@@ -43,14 +43,81 @@
 #define BUF_NB		128
 #define BUF_SIZE	1024
 
+int
+setup_aio_request(struct aiocb *aiocb[], char *bufs[], int count, int fd)
+{
+	int i = 0;
+
+	for (i = 0; i < count; i++) {
+		memset(aiocb[i], 0, sizeof(struct aiocb));
+
+		aiocb[i]->aio_fildes = fd;
+		memset(bufs[i], 0, BUF_SIZE);
+		aiocb[i]->aio_buf = bufs[i];
+		aiocb[i]->aio_nbytes = BUF_SIZE;
+		aiocb[i]->aio_offset = 0;
+		aiocb[i]->aio_sigevent.sigev_notify = SIGEV_NONE;
+
+		if (aio_write(aiocb[i]) == -1) {
+			printf(TNAME " loop %d: Error at aio_write(): %s\n",
+			       i, strerror(errno));
+			return -1;
+		}
+	}
+
+	return 0;
+}
+
+int
+create_aio_request(struct aiocb *aiocb[], char *bufs[], int count)
+{
+	int i = 0;
+
+	for (i = 0; i < count; i++) {
+		aiocb[i] = malloc(sizeof(struct aiocb));
+		if (aiocb[i] == NULL) {
+			printf(TNAME " Error at malloc(): %s\n",
+				strerror(errno));
+			return -1;
+		}
+
+		bufs[i] = malloc(BUF_SIZE);
+		if (bufs[i] == NULL) {
+			printf(TNAME " Error at malloc(): %s\n",
+		       		strerror(errno));
+			return -1;
+		}
+	}
+
+	return 0;
+}
+
+void
+destroy_aio_request(struct aiocb *aiocb[], char *bufs[], int count)
+{
+	int i = 0;
+
+	for (i = 0; i < count; i++) {
+		if (bufs[i]) {
+			free(bufs[i]);
+			bufs[i] = NULL;
+		}
+		if (aiocb[i]) {
+			free(aiocb[i]);
+			aiocb[i] = NULL;
+		}
+	}
+}
+
 int main()
 {
 	char tmpfname[256];
 	int fd;
 	struct aiocb *aiocb[BUF_NB];
+	char *bufs[BUF_NB];
 	int i;
 	int in_progress;
-	int gret;
+	int gret, trying = 100;
 
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		return PTS_UNSUPPORTED;
@@ -70,96 +137,61 @@ int main()
 	unlink(tmpfname);
 
 	/* create AIO req */
+	if (create_aio_request(aiocb, bufs, BUF_NB) == -1) {
+		printf(TNAME " Error at create aio requests\n");
 
-	for (i = 0; i < BUF_NB; i++)
-	{
-		aiocb[i] = malloc(sizeof(struct aiocb));
-		if (aiocb[i] == NULL)
-		{
-			printf(TNAME " Error at malloc(): %s\n",
-		       		strerror(errno));
-			return PTS_UNRESOLVED;
-		}
-		aiocb[i]->aio_fildes = fd;
-		aiocb[i]->aio_buf = malloc(BUF_SIZE);
-		if (aiocb[i]->aio_buf == NULL)
-		{
-			printf(TNAME " Error at malloc(): %s\n",
-		       		strerror(errno));
-			return PTS_UNRESOLVED;
-		}
-		aiocb[i]->aio_nbytes = BUF_SIZE;
-		aiocb[i]->aio_offset = 0;
-		aiocb[i]->aio_sigevent.sigev_notify = SIGEV_NONE;
-
-		if (aio_write(aiocb[i]) == -1)
-		{
-			printf(TNAME " loop %d: Error at aio_write(): %s\n",
-			       i, strerror(errno));
-			return PTS_FAIL;
-		}
+		destroy_aio_request(aiocb, bufs, BUF_NB);
+		close(fd);
+		return PTS_UNRESOLVED;
 	}
 
-	/* try to cancel all
-	 * we hope to have enough time to cancel at least one
-	 */
-
-	gret = aio_cancel(fd, NULL);
-	if (gret == -1)
-	{
-		printf(TNAME " Error at aio_cancel(): %s\n",
-		       strerror(errno));
-		return PTS_FAIL;
-	}
+	do {
+		if (setup_aio_request(aiocb, bufs, BUF_NB, fd) == -1) {
+			printf(TNAME " Error at set aio requests\n");
 
-	close(fd);
+			destroy_aio_request(aiocb, bufs, BUF_NB);
+			close(fd);
+			return PTS_UNRESOLVED;
+		}
 
-	do {
-		in_progress = 0;
-		for (i = 0; i < BUF_NB; i++)
-		{
+		/*
+		 * try to cancel all
+		 * we hope to have enough time to cancel at least one
+		 */
+		gret = aio_cancel(fd, NULL);
+		if (gret == -1) {
+			printf(TNAME " Error at aio_cancel(): %s\n",
+				strerror(errno));
+			destroy_aio_request(aiocb, bufs, BUF_NB);
+			close(fd);
+			return PTS_FAIL;
+		} else if (gret == AIO_NOTCANCELED) {
 			int ret;
 
-			ret = (aio_error(aiocb[i]));
-
-			if (ret == -1)
-			{
-				printf(TNAME " Error at aio_error(): %s\n",
-		       			strerror(errno));
-				return PTS_FAIL;
-			}
-			else if (ret == EINPROGRESS)
-			{
-				/* at this point, all operations should be:
-				 *    canceled
-				 * or in progress
-				 *    with aio_cancel() == AIO_NOTCANCELED
-				 */
-
-				if (gret != AIO_NOTCANCELED)
-				{
-					printf(TNAME " Error at aio_error(): %s\n", strerror(errno));
-					return PTS_FAIL;
-				}
+			for (i = 0; i < BUF_NB; i++) {
+				ret = (aio_error(aiocb[i]));
+				if (ret == EINPROGRESS || ret == 0) {
+					destroy_aio_request(aiocb,bufs,BUF_NB);
+					close(fd);
 
-				in_progress = 1;
-			}
-			else if (ret == 0)
-			{
-				/* we seek one not canceled and check why.
-				 * (perhaps) it has not been canceled
-				 * because it was in progress
-				 * during the cancel operation
-				 */
-
-				if (gret == AIO_NOTCANCELED)
-				{
-					printf ("Test PASSED\n");
+					printf("Test PASSED\n");
 					return PTS_PASS;
 				}
 			}
+
+			printf(TNAME " aio_cancel return AIO_NOTCANCELED, "
+			       "but no request was processed\n");
+
+			destroy_aio_request(aiocb, bufs, BUF_NB);
+			close(fd);
+			return PTS_FAIL;
 		}
-	} while (in_progress);
+	} while (trying --);
+
+	destroy_aio_request(aiocb, bufs, BUF_NB);
+	close(fd);
+
+	printf("Test unresolved\n");
 
 	return PTS_UNRESOLVED;
-}
\ No newline at end of file
+}
-- 
1.7.0.4




-- 
Regards
Bian Naimeng


------------------------------------------------------------------------------
Special Offer-- Download ArcSight Logger for FREE (a $49 USD value)!
Finally, a world-class log management solution at an even better price-free!
Download using promo code Free_Logger_4_Dev2Dev. Offer expires 
February 28th, so secure your free ArcSight Logger TODAY! 
http://p.sf.net/sfu/arcsight-sfd2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
