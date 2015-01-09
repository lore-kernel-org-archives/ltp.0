Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1Y9P8R-000265-Ai
	for ltp-list@lists.sourceforge.net; Fri, 09 Jan 2015 02:17:11 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Y9P8O-0003hT-BN
	for ltp-list@lists.sourceforge.net; Fri, 09 Jan 2015 02:17:11 +0000
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t092GKAn006752
	for <ltp-list@lists.sourceforge.net>; Fri, 9 Jan 2015 10:16:20 +0800
Message-ID: <1420769778.369.14.camel@G08JYZSD130126.localdomain>
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Fri, 9 Jan 2015 10:16:18 +0800
MIME-Version: 1.0
Subject: [LTP] [PATCH] Fix warning
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
To: ltp-list <ltp-list@lists.sourceforge.net>

* Fix "warning: comparison of unsigned expression < 0 is always false":
Some variable value number are defined as unsigned number. When they are
compared with zero, the zero would cast to an unsigned number. And it would be
always false. Fix these by defining them as signed number. And some cleanup.

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 testcases/kernel/io/disktest/dump.c                           |  2 +-
 testcases/kernel/syscalls/munmap/munmap01.c                   |  2 +-
 testcases/kernel/syscalls/munmap/munmap02.c                   |  2 +-
 .../kernel/syscalls/remap_file_pages/remap_file_pages01.c     | 11 +++++++----
 .../kernel/syscalls/remap_file_pages/remap_file_pages02.c     |  2 +-
 testcases/network/tcp_cmds/perf_lan/pingpong.c                |  6 +++---
 utils/sctp/lib/connectx.c                                     |  6 +++---
 7 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/testcases/kernel/io/disktest/dump.c b/testcases/kernel/io/disktest/dump.c
index eef119b..ffb5ce1 100644
--- a/testcases/kernel/io/disktest/dump.c
+++ b/testcases/kernel/io/disktest/dump.c
@@ -173,7 +173,7 @@ int dump_data(FILE * stream, const char *buff, const size_t buff_siz,
 
 int do_dump(child_args_t * args)
 {
-	size_t NumBytes = 0;
+	ssize_t NumBytes = 0;
 	OFF_T TargetLBA, TotalBytes = 0;
 	char *buff;
 	fd_t fd;
diff --git a/testcases/kernel/syscalls/munmap/munmap01.c b/testcases/kernel/syscalls/munmap/munmap01.c
index 67eb74b..0c16f34 100644
--- a/testcases/kernel/syscalls/munmap/munmap01.c
+++ b/testcases/kernel/syscalls/munmap/munmap01.c
@@ -152,7 +152,7 @@ int main(int ac, char **av)
  */
 void setup(void)
 {
-	size_t page_sz;		/* system page size */
+	int page_sz;
 
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
diff --git a/testcases/kernel/syscalls/munmap/munmap02.c b/testcases/kernel/syscalls/munmap/munmap02.c
index 2832e24..b7eca33 100644
--- a/testcases/kernel/syscalls/munmap/munmap02.c
+++ b/testcases/kernel/syscalls/munmap/munmap02.c
@@ -83,7 +83,7 @@
 char *TCID = "munmap02";
 int TST_TOTAL = 1;
 
-size_t page_sz;			/* system page size */
+static int page_sz;
 char *addr;			/* addr of memory mapped region */
 int fildes;			/* file descriptor for tempfile */
 unsigned int map_len;		/* length of the region to be mapped */
diff --git a/testcases/kernel/syscalls/remap_file_pages/remap_file_pages01.c b/testcases/kernel/syscalls/remap_file_pages/remap_file_pages01.c
index 42ed804..6a45ebf 100644
--- a/testcases/kernel/syscalls/remap_file_pages/remap_file_pages01.c
+++ b/testcases/kernel/syscalls/remap_file_pages/remap_file_pages01.c
@@ -92,7 +92,7 @@
 /* Test case defines */
 #define WINDOW_START 0x48000000
 
-size_t page_sz;
+static int page_sz;
 size_t page_words;
 size_t cache_pages;
 size_t cache_sz;
@@ -183,7 +183,8 @@ again:
 		if (remap_file_pages(page, page_sz * 2, 0,
 				     (window_pages - i - 2), 0) == -1) {
 			tst_resm(TFAIL | TERRNO,
-				 "remap_file_pages error for page=%p, page_sz=%zu, window_pages=%zu",
+				 "remap_file_pages error for page=%p, "
+				 "page_sz=%d, window_pages=%zu",
 				 page, (page_sz * 2), (window_pages - i - 2));
 			cleanup(data);
 		}
@@ -196,7 +197,8 @@ again:
 		if (i & 1) {
 			if (data[i * page_sz] != window_pages - i) {
 				tst_resm(TFAIL,
-					 "hm, mapped incorrect data, data[%zu]=%d, (window_pages-%d)=%zu",
+					 "hm, mapped incorrect data, "
+					 "data[%d]=%d, (window_pages-%d)=%zu",
 					 (i * page_sz), data[i * page_sz], i,
 					 (window_pages - i));
 				cleanup(data);
@@ -204,7 +206,8 @@ again:
 		} else {
 			if (data[i * page_sz] != window_pages - i - 2) {
 				tst_resm(TFAIL,
-					 "hm, mapped incorrect data, data[%zu]=%d, (window_pages-%d-2)=%zu",
+					 "hm, mapped incorrect data, "
+					 "data[%d]=%d, (window_pages-%d-2)=%zu",
 					 (i * page_sz), data[i * page_sz], i,
 					 (window_pages - i - 2));
 				cleanup(data);
diff --git a/testcases/kernel/syscalls/remap_file_pages/remap_file_pages02.c b/testcases/kernel/syscalls/remap_file_pages/remap_file_pages02.c
index d00d7ce..003ac77 100644
--- a/testcases/kernel/syscalls/remap_file_pages/remap_file_pages02.c
+++ b/testcases/kernel/syscalls/remap_file_pages/remap_file_pages02.c
@@ -83,7 +83,7 @@
 /* Test case defines */
 #define WINDOW_START 0x48000000
 
-size_t page_sz;
+static int page_sz;
 size_t page_words;
 size_t cache_pages;
 size_t cache_sz;
diff --git a/testcases/network/tcp_cmds/perf_lan/pingpong.c b/testcases/network/tcp_cmds/perf_lan/pingpong.c
index d02b552..746891e 100644
--- a/testcases/network/tcp_cmds/perf_lan/pingpong.c
+++ b/testcases/network/tcp_cmds/perf_lan/pingpong.c
@@ -207,7 +207,7 @@ int main(int argc, char *argv[])
 		while (1) {
 
 			len = sizeof(packet);
-			size_t cc;
+			ssize_t cc;
 			socklen_t fromlen;
 
 			/* Receive packet from socket */
@@ -239,7 +239,7 @@ int echopkt(int datalen, int npackets)
 	static uint8_t outpack[MAXPACKET];
 	register icmp_t *icp = (icmp_t *) outpack;
 	int i;
-	size_t cc;
+	ssize_t cc;
 
 	register u_char *datap = &outpack[8];
 
@@ -282,7 +282,7 @@ int echopkt(int datalen, int npackets)
 		if (i < 0 || i != cc) {
 			if (i < 0)
 				perror("sendto");
-			tst_resm(TINFO, "wrote %s %d chars, ret=%d",
+			tst_resm(TINFO, "wrote %s %zd chars, ret=%d",
 				 hostname, cc, i);
 			fflush(stdout);
 		}
diff --git a/utils/sctp/lib/connectx.c b/utils/sctp/lib/connectx.c
index b691f6b..cf8f5ed 100644
--- a/utils/sctp/lib/connectx.c
+++ b/utils/sctp/lib/connectx.c
@@ -66,7 +66,7 @@ static int __connectx_addrsize(const struct sockaddr *addrs,
 
 int __sctp_connectx(int fd, struct sockaddr *addrs, int addrcnt)
 {
-	socklen_t addrs_size = __connectx_addrsize(addrs, addrcnt);
+	int addrs_size = __connectx_addrsize(addrs, addrcnt);
 
 	if (addrs_size < 0)
 		return addrs_size;
@@ -117,7 +117,7 @@ static int __connectx(int fd, struct sockaddr *addrs, socklen_t addrs_size,
 int sctp_connectx2(int fd, struct sockaddr *addrs, int addrcnt,
 		      sctp_assoc_t *id)
 {
-	socklen_t addrs_size = __connectx_addrsize(addrs, addrcnt);
+	int addrs_size = __connectx_addrsize(addrs, addrcnt);
 
 	if (addrs_size < 0)
 		return addrs_size;
@@ -128,7 +128,7 @@ int sctp_connectx2(int fd, struct sockaddr *addrs, int addrcnt,
 int sctp_connectx3(int fd, struct sockaddr *addrs, int addrcnt,
 		      sctp_assoc_t *id)
 {
-	socklen_t addrs_size = __connectx_addrsize(addrs, addrcnt);
+	int addrs_size = __connectx_addrsize(addrs, addrcnt);
 	int status;
 	struct sctp_getaddrs_old param;
 	socklen_t opt_len = sizeof(param);
-- 
1.9.3




------------------------------------------------------------------------------
Dive into the World of Parallel Programming! The Go Parallel Website,
sponsored by Intel and developed in partnership with Slashdot Media, is your
hub for all things parallel software development, from weekly thought
leadership blogs to news, videos, case studies, tutorials and more. Take a
look and join the conversation now. http://goparallel.sourceforge.net
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
