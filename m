Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <deller@gmx.de>) id 1Vit7l-0004Vx-A2
	for ltp-list@lists.sourceforge.net; Tue, 19 Nov 2013 21:46:21 +0000
Received: from mout.gmx.net ([212.227.15.18])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1Vit7k-0003mz-6S
	for ltp-list@lists.sourceforge.net; Tue, 19 Nov 2013 21:46:21 +0000
Received: from p100.box ([84.173.38.207]) by mail.gmx.com (mrgmx002) with
	ESMTPSA (Nemesis) id 0MSdz2-1WALcf3No4-00RbcK for
	<ltp-list@lists.sourceforge.net>; Tue, 19 Nov 2013 22:46:13 +0100
Date: Tue, 19 Nov 2013 22:46:12 +0100
From: Helge Deller <deller@gmx.de>
Message-ID: <20131119214612.GA2120@p100.box>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [LTP] [PATCH] fix readv01 testcase for parisc architecture
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

In the second test of readv01 the rd_iovec[] array was not defined or
zero-initialized for vectors which will be accessed by the readv() syscall.
This leads to the fact that on the parisc platform the readv syscall accessed
random memory which is located behind the array.  Fix this problem by adding
two more vectors with address NULL and length 0.

Furthermore, in the test2 itself we tell readv() to read 4 vecors, while
the error message behind it says that it has read CHUNK bytes "followed
by *two* NULL vectors", which then sums up to a total of 3 vectors
instead of 4.
Fix this by calling readv() with only 3 vectors instead of 4.

Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/testcases/kernel/syscalls/readv/readv01.c b/testcases/kernel/syscalls/readv/readv01.c
index d92c1be..ca83310 100644
--- a/testcases/kernel/syscalls/readv/readv01.c
+++ b/testcases/kernel/syscalls/readv/readv01.c
@@ -66,7 +66,9 @@ struct iovec rd_iovec[MAX_IOVEC] = {
 	{(buf2 + CHUNK * 10), CHUNK},
 
 	/* Test case #2 */
-	{(buf2 + CHUNK * 11), CHUNK}
+	{(buf2 + CHUNK * 11), CHUNK},
+	{NULL, 0},
+	{NULL, 0}
 };
 
 char f_name[K_1];
@@ -112,7 +114,7 @@ int main(int ac, char **av)
 
 //test2:
 		l_seek(fd, CHUNK * 12, 0);
-		if (readv(fd, (rd_iovec + 1), 4) != CHUNK) {
+		if (readv(fd, (rd_iovec + 1), 3) != CHUNK) {
 			tst_resm(TFAIL, "readv failed reading %d bytes, "
 				 "followed by two NULL vectors", CHUNK);
 		} else {

------------------------------------------------------------------------------
Shape the Mobile Experience: Free Subscription
Software experts and developers: Be at the forefront of tech innovation.
Intel(R) Software Adrenaline delivers strategic insight and game-changing 
conversations that shape the rapidly evolving mobile landscape. Sign up now. 
http://pubads.g.doubleclick.net/gampad/clk?id=63431311&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
