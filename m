Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <weijg.fnst@cn.fujitsu.com>) id 1YsUiI-0004FQ-AH
	for ltp-list@lists.sourceforge.net; Wed, 13 May 2015 11:20:34 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YsUiA-0007W4-R6
	for ltp-list@lists.sourceforge.net; Wed, 13 May 2015 11:20:34 +0000
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t4DBJ2ls004325
	for <ltp-list@lists.sourceforge.net>; Wed, 13 May 2015 19:19:02 +0800
From: "Wei,Jiangang" <weijg.fnst@cn.fujitsu.com>
Date: Wed, 13 May 2015 19:19:43 +0800
Message-ID: <1431515986-22287-2-git-send-email-weijg.fnst@cn.fujitsu.com>
In-Reply-To: <1431515986-22287-1-git-send-email-weijg.fnst@cn.fujitsu.com>
References: <1431515986-22287-1-git-send-email-weijg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH 2/5] testcases/kernel/syscalls/fcntl: use TERRNO flag
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
To: ltp-list@lists.sourceforge.net

Signed-off-by: Wei,Jiangang <weijg.fnst@cn.fujitsu.com>
---
 testcases/kernel/syscalls/fcntl/fcntl19.c | 51 ++++++++--------------
 testcases/kernel/syscalls/fcntl/fcntl21.c | 72 +++++++++++--------------------
 2 files changed, 43 insertions(+), 80 deletions(-)

diff --git a/testcases/kernel/syscalls/fcntl/fcntl19.c b/testcases/kernel/syscalls/fcntl/fcntl19.c
index a542cfc..5775684 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl19.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl19.c
@@ -101,12 +101,11 @@ void setup(void)
 	snprintf(template, PATH_MAX, "fcntl19XXXXXX");
 
 	if ((fd = mkstemp(template)) < 0) {
-		tst_resm(TFAIL, "Couldn't open temp file! errno = %d", errno);
+		tst_resm(TFAIL|TERRNO, "Couldn't open temp file!");
 	}
 
 	if (write(fd, buf, STRINGSIZE) < 0) {
-		tst_resm(TFAIL, "Couldn't write to temp file! errno = %d",
-			 errno);
+		tst_resm(TFAIL|TERRNO, "Couldn't write to temp file!");
 	}
 
 	memset(&act, 0, sizeof(act));
@@ -114,7 +113,7 @@ void setup(void)
 	sigemptyset(&act.sa_mask);
 	sigaddset(&act.sa_mask, SIGCLD);
 	if ((sigaction(SIGCLD, &act, NULL)) < 0) {
-		tst_resm(TFAIL, "SIGCLD signal setup failed, errno: %d", errno);
+		tst_resm(TFAIL|TERRNO, "SIGCLD signal setup failed!");
 		fail = 1;
 	}
 }
@@ -203,7 +202,7 @@ void unlock_file(void)
 	struct flock fl;
 
 	if (do_lock(F_SETLK, (short)F_UNLCK, (short)0, 0, 0) < 0) {
-		tst_resm(TFAIL, "fcntl on file failed, errno =%d", errno);
+		tst_resm(TFAIL|TERRNO, "fcntl on file failed!");
 		fail = 1;
 	}
 	do_test(&fl, F_WRLCK, 0, 0, 0);
@@ -324,14 +323,12 @@ int main(int ac, char **av)
 		 * section just before the lock
 		 */
 		if (do_lock(F_SETLK, (short)F_WRLCK, (short)0, 10, 5) < 0) {
-			tst_resm(TFAIL, "fcntl on file failed, errno =%d",
-				 errno);
+			tst_resm(TFAIL|TERRNO, "fcntl on file failed!");
 			fail = 1;
 		}
 
 		if (do_lock(F_SETLK, (short)F_UNLCK, (short)0, 5, 5) < 0) {
-			tst_resm(TFAIL, "fcntl on file failed, errno =%d",
-				 errno);
+			tst_resm(TFAIL|TERRNO, "fcntl on file failed!");
 			fail = 1;
 		}
 
@@ -367,14 +364,12 @@ int main(int ac, char **av)
 		 * ends at the first byte of the write lock.
 		 */
 		if (do_lock(F_SETLK, (short)F_WRLCK, (short)0, 10, 5) < 0) {
-			tst_resm(TFAIL, "fcntl on file failed, errno =%d",
-				 errno);
+			tst_resm(TFAIL|TERRNO, "fcntl on file failed!");
 			fail = 1;
 		}
 
 		if (do_lock(F_SETLK, (short)F_UNLCK, (short)0, 5, 6) < 0) {
-			tst_resm(TFAIL, "fcntl on file failed, errno =%d",
-				 errno);
+			tst_resm(TFAIL|TERRNO, "fcntl on file failed!");
 			fail = 1;
 		}
 
@@ -411,14 +406,12 @@ int main(int ac, char **av)
 		 * unlock that overlaps the front of the write
 		 */
 		if (do_lock(F_SETLK, (short)F_WRLCK, (short)0, 10, 5) < 0) {
-			tst_resm(TFAIL, "fcntl on file failed, errno =%d",
-				 errno);
+			tst_resm(TFAIL|TERRNO, "fcntl on file failed!");
 			fail = 1;
 		}
 
 		if (do_lock(F_SETLK, (short)F_UNLCK, (short)0, 5, 8) < 0) {
-			tst_resm(TFAIL, "fcntl on file failed, errno =%d",
-				 errno);
+			tst_resm(TFAIL|TERRNO, "fcntl on file failed!");
 			fail = 1;
 		}
 
@@ -455,14 +448,12 @@ int main(int ac, char **av)
 		 * section in the middle of it
 		 */
 		if (do_lock(F_SETLK, (short)F_WRLCK, (short)0, 10, 10) < 0) {
-			tst_resm(TFAIL, "fcntl on file failed, errno =%d",
-				 errno);
+			tst_resm(TFAIL|TERRNO, "fcntl on file failed!");
 			fail = 1;
 		}
 
 		if (do_lock(F_SETLK, (short)F_UNLCK, (short)0, 13, 5) < 0) {
-			tst_resm(TFAIL, "fcntl on file failed, errno =%d",
-				 errno);
+			tst_resm(TFAIL|TERRNO, "fcntl on file failed!");
 			fail = 1;
 		}
 
@@ -505,14 +496,12 @@ int main(int ac, char **av)
 		 * unlock that overlaps the end
 		 */
 		if (do_lock(F_SETLK, (short)F_WRLCK, (short)0, 10, 5) < 0) {
-			tst_resm(TFAIL, "fcntl on file failed, errno =%d",
-				 errno);
+			tst_resm(TFAIL|TERRNO, "fcntl on file failed!");
 			fail = 1;
 		}
 
 		if (do_lock(F_SETLK, (short)F_UNLCK, (short)0, 13, 5) < 0) {
-			tst_resm(TFAIL, "fcntl on file failed, errno =%d",
-				 errno);
+			tst_resm(TFAIL|TERRNO, "fcntl on file failed!");
 			fail = 1;
 		}
 
@@ -549,14 +538,12 @@ int main(int ac, char **av)
 		 * starting at the last byte of the write lock
 		 */
 		if (do_lock(F_SETLK, (short)F_WRLCK, (short)0, 10, 5) < 0) {
-			tst_resm(TFAIL, "fcntl on file failed, errno =%d",
-				 errno);
+			tst_resm(TFAIL|TERRNO, "fcntl on file failed!");
 			fail = 1;
 		}
 
 		if (do_lock(F_SETLK, (short)F_UNLCK, (short)0, 14, 5) < 0) {
-			tst_resm(TFAIL, "fcntl on file failed, errno =%d",
-				 errno);
+			tst_resm(TFAIL|TERRNO, "fcntl on file failed!");
 			fail = 1;
 		}
 
@@ -594,14 +581,12 @@ int main(int ac, char **av)
 		 * lock
 		 */
 		if (do_lock(F_SETLK, (short)F_WRLCK, (short)0, 10, 5) < 0) {
-			tst_resm(TFAIL, "fcntl on file failed, errno =%d",
-				 errno);
+			tst_resm(TFAIL|TERRNO, "fcntl on file failed!");
 			fail = 1;
 		}
 
 		if (do_lock(F_SETLK, (short)F_UNLCK, (short)0, 16, 0) < 0) {
-			tst_resm(TFAIL, "fcntl on file failed, errno =%d",
-				 errno);
+			tst_resm(TFAIL|TERRNO, "fcntl on file failed!");
 			fail = 1;
 		}
 
diff --git a/testcases/kernel/syscalls/fcntl/fcntl21.c b/testcases/kernel/syscalls/fcntl/fcntl21.c
index 5307021..b59b128 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl21.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl21.c
@@ -99,12 +99,11 @@ void setup(void)
 	snprintf(template, PATH_MAX, "fcntl21XXXXXX");
 
 	if ((fd = mkstemp(template)) < 0) {
-		tst_resm(TFAIL, "Couldn't open temp file! errno = %d", errno);
+		tst_resm(TFAIL|TERRNO, "Couldn't open temp file!");
 	}
 
 	if (write(fd, buf, STRINGSIZE) < 0) {
-		tst_resm(TFAIL, "Couldn't write to temp file! errno = %d",
-			 errno);
+		tst_resm(TFAIL|TERRNO, "Couldn't write to temp file!");
 	}
 
 	memset(&act, 0, sizeof(act));
@@ -112,7 +111,7 @@ void setup(void)
 	sigemptyset(&act.sa_mask);
 	sigaddset(&act.sa_mask, SIGCLD);
 	if ((sigaction(SIGCLD, &act, NULL)) < 0) {
-		tst_resm(TFAIL, "SIGCLD signal setup failed, errno: %d", errno);
+		tst_resm(TFAIL|TERRNO, "SIGCLD signal setup failed!");
 		fail = 1;
 	}
 }
@@ -138,8 +137,7 @@ void do_child(void)
 	while (1) {
 		child_get(&fl);
 		if (fcntl(fd, F_GETLK, &fl) < 0) {
-			tst_resm(TFAIL, "fcntl on file failed, errno =%d",
-				 errno);
+			tst_resm(TFAIL|TERRNO, "fcntl on file failed!");
 			fail = 1;
 		}
 		child_put(&fl);
@@ -210,7 +208,7 @@ void unlock_file(void)
 	struct flock fl;
 
 	if (do_lock(F_SETLK, (short)F_UNLCK, (short)0, 0, 0) < 0) {
-		tst_resm(TFAIL, "fcntl on file failed, errno =%d", errno);
+		tst_resm(TFAIL|TERRNO, "fcntl on file failed!");
 		fail = 1;
 	}
 	do_test(&fl, F_WRLCK, 0, 0, 0);
@@ -330,8 +328,7 @@ int main(int ac, char **av)
 		 * Set a read lock on the whole file
 		 */
 		if (do_lock(F_SETLK, (short)F_RDLCK, (short)0, 0, 0) < 0) {
-			tst_resm(TFAIL, "fcntl on file failed, errno =%d",
-				 errno);
+			tst_resm(TFAIL|TERRNO, "fcntl on file failed!");
 			fail = 1;
 		}
 
@@ -361,8 +358,7 @@ int main(int ac, char **av)
 		 * Set a write lock on the whole file
 		 */
 		if (do_lock(F_SETLK, (short)F_WRLCK, (short)0, 0, 0) < 0) {
-			tst_resm(TFAIL, "fcntl on file failed, errno =%d",
-				 errno);
+			tst_resm(TFAIL|TERRNO, "fcntl on file failed!");
 			fail = 1;
 		}
 
@@ -394,14 +390,12 @@ int main(int ac, char **av)
 		 * at the begining
 		 */
 		if (do_lock(F_SETLK, (short)F_RDLCK, (short)0, 10, 5) < 0) {
-			tst_resm(TFAIL, "fcntl on file failed, errno =%d",
-				 errno);
+			tst_resm(TFAIL|TERRNO, "fcntl on file failed!");
 			fail = 1;
 		}
 
 		if (do_lock(F_SETLK, (short)F_WRLCK, (short)0, 1, 5) < 0) {
-			tst_resm(TFAIL, "fcntl on file failed, errno =%d",
-				 errno);
+			tst_resm(TFAIL|TERRNO, "fcntl on file failed!");
 			fail = 1;
 		}
 
@@ -444,14 +438,12 @@ int main(int ac, char **av)
 		 * write lock just before
 		 */
 		if (do_lock(F_SETLK, (short)F_RDLCK, (short)0, 10, 5) < 0) {
-			tst_resm(TFAIL, "fcntl on file failed, errno =%d",
-				 errno);
+			tst_resm(TFAIL|TERRNO, "fcntl on file failed!");
 			fail = 1;
 		}
 
 		if (do_lock(F_SETLK, (short)F_WRLCK, (short)0, 5, 5) < 0) {
-			tst_resm(TFAIL, "fcntl on file failed, errno =%d",
-				 errno);
+			tst_resm(TFAIL|TERRNO, "fcntl on file failed!");
 			fail = 1;
 		}
 
@@ -494,14 +486,12 @@ int main(int ac, char **av)
 		 * ends at the first byte of the read lock
 		 */
 		if (do_lock(F_SETLK, (short)F_RDLCK, (short)0, 10, 5) < 0) {
-			tst_resm(TFAIL, "fcntl on file failed, errno =%d",
-				 errno);
+			tst_resm(TFAIL|TERRNO, "fcntl on file failed!");
 			fail = 1;
 		}
 
 		if (do_lock(F_SETLK, (short)F_WRLCK, (short)0, 5, 6) < 0) {
-			tst_resm(TFAIL, "fcntl on file failed, errno =%d",
-				 errno);
+			tst_resm(TFAIL|TERRNO, "fcntl on file failed!");
 			fail = 1;
 		}
 
@@ -544,14 +534,12 @@ int main(int ac, char **av)
 		 * lock that overlaps the front of the read.
 		 */
 		if (do_lock(F_SETLK, (short)F_RDLCK, (short)0, 10, 5) < 0) {
-			tst_resm(TFAIL, "fcntl on file failed, errno =%d",
-				 errno);
+			tst_resm(TFAIL|TERRNO, "fcntl on file failed!");
 			fail = 1;
 		}
 
 		if (do_lock(F_SETLK, (short)F_WRLCK, (short)0, 5, 8) < 0) {
-			tst_resm(TFAIL, "fcntl on file failed, errno =%d",
-				 errno);
+			tst_resm(TFAIL|TERRNO, "fcntl on file failed!");
 			fail = 1;
 		}
 
@@ -594,14 +582,12 @@ int main(int ac, char **av)
 		 * lock in the middle of it
 		 */
 		if (do_lock(F_SETLK, (short)F_RDLCK, (short)0, 10, 10) < 0) {
-			tst_resm(TFAIL, "fcntl on file failed, errno =%d",
-				 errno);
+			tst_resm(TFAIL|TERRNO, "fcntl on file failed!");
 			fail = 1;
 		}
 
 		if (do_lock(F_SETLK, (short)F_WRLCK, (short)0, 13, 5) < 0) {
-			tst_resm(TFAIL, "fcntl on file failed, errno =%d",
-				 errno);
+			tst_resm(TFAIL|TERRNO, "fcntl on file failed!");
 			fail = 1;
 		}
 
@@ -648,8 +634,7 @@ int main(int ac, char **av)
 		 * lock that overlaps the end
 		 */
 		if (do_lock(F_SETLK, (short)F_RDLCK, (short)0, 10, 5) < 0) {
-			tst_resm(TFAIL, "fcntl on file failed, errno =%d",
-				 errno);
+			tst_resm(TFAIL|TERRNO, "fcntl on file failed!");
 			fail = 1;
 		}
 
@@ -657,8 +642,7 @@ int main(int ac, char **av)
 		 * Set a write lock on the whole file
 		 */
 		if (do_lock(F_SETLK, (short)F_WRLCK, (short)0, 13, 5) < 0) {
-			tst_resm(TFAIL, "fcntl on file failed, errno =%d",
-				 errno);
+			tst_resm(TFAIL|TERRNO, "fcntl on file failed!");
 			fail = 1;
 		}
 
@@ -701,8 +685,7 @@ int main(int ac, char **av)
 		 * lock starting at the last byte of the read lock
 		 */
 		if (do_lock(F_SETLK, (short)F_RDLCK, (short)0, 10, 5) < 0) {
-			tst_resm(TFAIL, "fcntl on file failed, errno =%d",
-				 errno);
+			tst_resm(TFAIL|TERRNO, "fcntl on file failed!");
 			fail = 1;
 		}
 
@@ -710,8 +693,7 @@ int main(int ac, char **av)
 		 * Set a write lock on the whole file.
 		 */
 		if (do_lock(F_SETLK, (short)F_WRLCK, (short)0, 14, 5) < 0) {
-			tst_resm(TFAIL, "fcntl on file failed, errno =%d",
-				 errno);
+			tst_resm(TFAIL|TERRNO, "fcntl on file failed!");
 			fail = 1;
 		}
 
@@ -755,8 +737,7 @@ int main(int ac, char **av)
 		 * read lock.
 		 */
 		if (do_lock(F_SETLK, (short)F_RDLCK, (short)0, 10, 5) < 0) {
-			tst_resm(TFAIL, "fcntl on file failed, errno =%d",
-				 errno);
+			tst_resm(TFAIL|TERRNO, "fcntl on file failed!");
 			fail = 1;
 		}
 
@@ -764,8 +745,7 @@ int main(int ac, char **av)
 		 * Set a write lock on the whole file
 		 */
 		if (do_lock(F_SETLK, (short)F_WRLCK, (short)0, 15, 5) < 0) {
-			tst_resm(TFAIL, "fcntl on file failed, errno =%d",
-				 errno);
+			tst_resm(TFAIL|TERRNO, "fcntl on file failed!");
 			fail = 1;
 		}
 
@@ -808,14 +788,12 @@ int main(int ac, char **av)
 		 * lock that starts past the end of the read lock.
 		 */
 		if (do_lock(F_SETLK, (short)F_RDLCK, (short)0, 10, 5) < 0) {
-			tst_resm(TFAIL, "fcntl on file failed, errno =%d",
-				 errno);
+			tst_resm(TFAIL|TERRNO, "fcntl on file failed!");
 			fail = 1;
 		}
 
 		if (do_lock(F_SETLK, (short)F_WRLCK, (short)0, 16, 5) < 0) {
-			tst_resm(TFAIL, "fcntl on file failed, errno =%d",
-				 errno);
+			tst_resm(TFAIL|TERRNO, "fcntl on file failed!");
 			fail = 1;
 		}
 
-- 
1.9.3


------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
