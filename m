Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Markos.Chandras@imgtec.com>) id 1Ri4Hq-0001j1-QM
	for ltp-list@lists.sourceforge.net; Tue, 03 Jan 2012 13:20:18 +0000
Received: from multi.imgtec.com ([194.200.65.239])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Ri4Hp-0003LH-Oq
	for ltp-list@lists.sourceforge.net; Tue, 03 Jan 2012 13:20:18 +0000
Message-ID: <4F03008A.5040406@imgtec.com>
Date: Tue, 3 Jan 2012 13:20:10 +0000
From: Markos Chandras <Markos.Chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050606080807020500030900"
Subject: [LTP] [PATCH 14/21] syscalls/ftest: CHUNK macro has a long int type
	value
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
To: ltp-list@lists.sourceforge.net

--------------050606080807020500030900
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit

Hi, please review the attached patch

-- 
markos

--------------050606080807020500030900
Content-Type: text/plain;
	name="0014-syscalls-ftest-CHUNK-macro-has-a-long-int-type-value.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="0014-syscalls-ftest-CHUNK-macro-has-a-long-int-type-value.pa";
	filename*1="tch"

From 5fcdab58fb80e2f0fdaead6f587bad74565d5e3e Mon Sep 17 00:00:00 2001
From: Markos Chandras <markos.chandras@imgtec.com>
Date: Thu, 22 Dec 2011 14:50:46 +0000
Subject: [PATCH 14/21] syscalls/ftest: CHUNK macro has a long int type value

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 testcases/kernel/fs/ftest/ftest05.c |   14 +++++++-------
 testcases/kernel/fs/ftest/ftest07.c |   14 +++++++-------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/testcases/kernel/fs/ftest/ftest05.c b/testcases/kernel/fs/ftest/ftest05.c
index 1744ff8..78a204d 100644
--- a/testcases/kernel/fs/ftest/ftest05.c
+++ b/testcases/kernel/fs/ftest/ftest05.c
@@ -334,12 +334,12 @@ static void dotest(int testers, int me, int fd)
 			 */
 			if (lseek64(fd, CHUNK(chunk), 0) < (off64_t)0) {
 				tst_brkm(TFAIL|TERRNO, NULL,
-					"\tTest[%d]: lseek64(0) fail at %Lx",
+					"\tTest[%d]: lseek64(0) fail at %lx",
 					me, CHUNK(chunk));
 			}
 			if ((xfr = read(fd, buf, csize)) < 0) {
 				tst_brkm(TFAIL|TERRNO, NULL,
-					"\tTest[%d]: read fail at %Lx",
+					"\tTest[%d]: read fail at %lx",
 					me, CHUNK(chunk));
 			}
 			/*
@@ -359,7 +359,7 @@ static void dotest(int testers, int me, int fd)
 				}
 				if (memcmp(buf, zero_buf, csize)) {
 					tst_resm(TFAIL,
-					  "\tTest[%d] bad verify @ 0x%Lx for val %d count %d xfr %d file_max 0x%x, should be %d.",
+					  "\tTest[%d] bad verify @ 0x%lx for val %d count %d xfr %d file_max 0x%x, should be %d.",
 						me, CHUNK(chunk), val, count, xfr, file_max, zero_buf[0]);
 					tst_resm(TINFO, "\tTest[%d]: last_trunc = 0x%x.",
 						me, last_trunc);
@@ -381,7 +381,7 @@ static void dotest(int testers, int me, int fd)
 				}
 				++collide;
 				if (memcmp(buf, val_buf, csize)) {
-					tst_resm(TFAIL, "\tTest[%d] bad verify @ 0x%Lx for val %d count %d xfr %d file_max 0x%x.",
+					tst_resm(TFAIL, "\tTest[%d] bad verify @ 0x%lx for val %d count %d xfr %d file_max 0x%x.",
 						me, CHUNK(chunk), val, count, xfr, file_max);
 					tst_resm(TINFO, "\tTest[%d]: last_trunc = 0x%x.",
 						me, last_trunc);
@@ -399,7 +399,7 @@ static void dotest(int testers, int me, int fd)
 			 */
 			if (lseek64(fd, -((off64_t)xfr), 1) < (off64_t)0) {
 				tst_brkm(TFAIL|TERRNO, NULL,
-					"\tTest[%d]: lseek64(1) fail at %Lx",
+					"\tTest[%d]: lseek64(1) fail at %lx",
 					me, CHUNK(chunk));
 			}
 			if ((xfr = write(fd, val_buf, csize)) < csize) {
@@ -408,7 +408,7 @@ static void dotest(int testers, int me, int fd)
 					fsync(fd);
 				} else {
 					tst_resm(TFAIL|TERRNO,
-						"\tTest[%d]: write fail at %Lx xfr %d",
+						"\tTest[%d]: write fail at %lx xfr %d",
 						me, CHUNK(chunk), xfr);
 				}
 				tst_exit();
@@ -542,4 +542,4 @@ static void cleanup(void)
 
         tst_rmdir();
         tst_exit();
-}
\ No newline at end of file
+}
diff --git a/testcases/kernel/fs/ftest/ftest07.c b/testcases/kernel/fs/ftest/ftest07.c
index 657d8d8..4267268 100644
--- a/testcases/kernel/fs/ftest/ftest07.c
+++ b/testcases/kernel/fs/ftest/ftest07.c
@@ -399,12 +399,12 @@ static void dotest(int testers, int me, int fd)
 			 * Read it.
 			 */
 			if (lseek64(fd, CHUNK(chunk), 0) < 0) {
-				tst_resm(TFAIL, "\tTest[%d]: lseek64(0) fail at %Lx, errno = %d.",
+				tst_resm(TFAIL, "\tTest[%d]: lseek64(0) fail at %lx, errno = %d.",
 					me, CHUNK(chunk), errno);
 				tst_exit();
 			}
 			if ((xfr = readv(fd, &r_iovec[0], MAXIOVCNT)) < 0) {
-				tst_resm(TFAIL, "\tTest[%d]: readv fail at %Lx, errno = %d.",
+				tst_resm(TFAIL, "\tTest[%d]: readv fail at %lx, errno = %d.",
 					me, CHUNK(chunk), errno);
 				tst_exit();
 			}
@@ -425,7 +425,7 @@ static void dotest(int testers, int me, int fd)
 				for (i = 0; i < MAXIOVCNT; i++) {
 					if (memcmp(r_iovec[i].iov_base, zero_iovec[i].iov_base, r_iovec[i].iov_len)) {
 						tst_resm(TFAIL,
-					  	"\tTest[%d] bad verify @ 0x%Lx for val %d count %d xfr %d file_max 0x%x, should be 0.",
+					  	"\tTest[%d] bad verify @ 0x%lx for val %d count %d xfr %d file_max 0x%x, should be 0.",
 							me, CHUNK(chunk), val, count, xfr, file_max);
 						tst_resm(TINFO, "\tTest[%d]: last_trunc = 0x%x.",
 							me, last_trunc);
@@ -449,7 +449,7 @@ static void dotest(int testers, int me, int fd)
 				++collide;
 				for (i = 0; i < MAXIOVCNT; i++) {
 					if (memcmp(r_iovec[i].iov_base, val_iovec[i].iov_base, r_iovec[i].iov_len)) {
-						tst_resm(TFAIL, "\tTest[%d] bad verify @ 0x%Lx for val %d count %d xfr %d file_max 0x%x.",
+						tst_resm(TFAIL, "\tTest[%d] bad verify @ 0x%lx for val %d count %d xfr %d file_max 0x%x.",
 							me, CHUNK(chunk), val, count, xfr, file_max);
 						tst_resm(TINFO, "\tTest[%d]: last_trunc = 0x%x.",
 							me, last_trunc);
@@ -467,7 +467,7 @@ static void dotest(int testers, int me, int fd)
 			 * Writev it.
 			 */
 			if (lseek64(fd, -((off64_t)xfr), 1) <  0) {
-				tst_resm(TFAIL, "\tTest[%d]: lseek64(1) fail at %Lx, errno = %d.",
+				tst_resm(TFAIL, "\tTest[%d]: lseek64(1) fail at %lx, errno = %d.",
 					me, CHUNK(chunk), errno);
 				tst_exit();
 			}
@@ -477,7 +477,7 @@ static void dotest(int testers, int me, int fd)
 					fsync(fd);
 					tst_exit();
 				}
-				tst_resm(TFAIL, "\tTest[%d]: writev fail at %Lx xfr %d, errno = %d.",
+				tst_resm(TFAIL, "\tTest[%d]: writev fail at %lx xfr %d, errno = %d.",
 					me, CHUNK(chunk), xfr, errno);
 				tst_exit();
 			}
@@ -599,4 +599,4 @@ static void term(int sig LTP_ATTRIBUTE_UNUSED)
 		tst_resm(TINFO, "Unlink of '%s' successful.", test_name);
 
 	tst_exit();
-}
\ No newline at end of file
+}
-- 
1.7.1


--------------050606080807020500030900
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Write once. Port to many.
Get the SDK and tools to simplify cross-platform app development. Create 
new or port existing apps to sell to consumers worldwide. Explore the 
Intel AppUpSM program developer opportunity. appdeveloper.intel.com/join
http://p.sf.net/sfu/intel-appdev
--------------050606080807020500030900
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------050606080807020500030900--


