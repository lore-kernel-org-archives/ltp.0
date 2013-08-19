Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1VBPfT-0005wc-1D
	for ltp-list@lists.sourceforge.net; Mon, 19 Aug 2013 13:38:47 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VBPfR-0000eT-Nm
	for ltp-list@lists.sourceforge.net; Mon, 19 Aug 2013 13:38:47 +0000
Received: from int-mx12.intmail.prod.int.phx2.redhat.com
	(int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r7JDcdDb001383
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 19 Aug 2013 09:38:39 -0400
From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 19 Aug 2013 15:38:34 +0200
Message-Id: <b02ceb0270268de40055e69232d12c3a3422f7f4.1376919310.git.jstancek@redhat.com>
Subject: [LTP] [PATCH/RFC] aiodio: make read_sparse use same mode as writers
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
To: ltp-list@lists.sourceforge.net

Starting with 3.10 dio_sparse sporadically fails, because
read() in read_sparse returns garbage and dio_sparse testcase
fails with:
  dio_sparse    0  TINFO  :  Dirtying free blocks
  dio_sparse    0  TINFO  :  Starting I/O tests
  non zero buffer at buf[0] => 0xffffffaa,ffffffaa,ffffffaa,ffffffaa
  non-zero read at offset 0
  dio_sparse    0  TINFO  :  Killing childrens(s)
  dio_sparse    1  TFAIL  :  1 children(s) exited abnormally

Issue is that we have parent opening file as O_DIRECT and
children trying to read from it without O_DIRECT, which is
discouraged in man pages.

open(2) says:
"Applications should avoid mixing O_DIRECT and normal I/O to the same
file, and especially to overlapping byte regions in the same file."

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/io/ltp-aiodio/aiodio_sparse.c |    2 +-
 testcases/kernel/io/ltp-aiodio/common_sparse.h |    4 ++--
 testcases/kernel/io/ltp-aiodio/dio_sparse.c    |    2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/io/ltp-aiodio/aiodio_sparse.c b/testcases/kernel/io/ltp-aiodio/aiodio_sparse.c
index 944e12b..705bbc5 100644
--- a/testcases/kernel/io/ltp-aiodio/aiodio_sparse.c
+++ b/testcases/kernel/io/ltp-aiodio/aiodio_sparse.c
@@ -279,7 +279,7 @@ int main(int argc, char **argv)
 	for (i = 0; i < num_children; i++) {
 		switch (pid[i] = fork()) {
 		case 0:
-			read_sparse(filename, filesize);
+			read_sparse(filename, filesize, O_DIRECT);
 			break;
 		case -1:
 			while (i-- > 0)
diff --git a/testcases/kernel/io/ltp-aiodio/common_sparse.h b/testcases/kernel/io/ltp-aiodio/common_sparse.h
index f7f4ef4..6a294cb 100644
--- a/testcases/kernel/io/ltp-aiodio/common_sparse.h
+++ b/testcases/kernel/io/ltp-aiodio/common_sparse.h
@@ -104,7 +104,7 @@ char *check_zero(char *buf, int size)
  * either there is a hole in the file,
  * or zeroes were actually written by parent.
  */
-static void read_sparse(char *filename, int filesize)
+static void read_sparse(char *filename, int filesize, int mode)
 {
 	int fd;
 	int  i, j, r;
@@ -114,7 +114,7 @@ static void read_sparse(char *filename, int filesize)
 	 * Wait for the file to appear.
 	 */
 	for (i = 0; i < 10000; i++) {
-		fd = open(filename, O_RDONLY);
+		fd = open(filename, O_RDONLY | mode);
 
 		if (fd != -1)
 			break;
diff --git a/testcases/kernel/io/ltp-aiodio/dio_sparse.c b/testcases/kernel/io/ltp-aiodio/dio_sparse.c
index 7ad5f80..eaaea14 100644
--- a/testcases/kernel/io/ltp-aiodio/dio_sparse.c
+++ b/testcases/kernel/io/ltp-aiodio/dio_sparse.c
@@ -153,7 +153,7 @@ int main(int argc, char **argv)
 	for (i = 0; i < num_children; i++) {
 		switch (pid[i] = fork()) {
 		case 0:
-			read_sparse(filename, filesize);
+			read_sparse(filename, filesize, O_DIRECT);
 			break;
 		case -1:
 			while (i-- > 0)
-- 
1.7.1


------------------------------------------------------------------------------
Get 100% visibility into Java/.NET code with AppDynamics Lite!
It's a free troubleshooting tool designed for production.
Get down to code-level detail for bottlenecks, with <2% overhead. 
Download for free and get started troubleshooting in minutes. 
http://pubads.g.doubleclick.net/gampad/clk?id=48897031&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
