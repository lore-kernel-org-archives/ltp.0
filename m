Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <weijg.fnst@cn.fujitsu.com>) id 1Ys3g8-0002dL-P3
	for ltp-list@lists.sourceforge.net; Tue, 12 May 2015 06:28:32 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Ys3g7-0001jQ-Sk
	for ltp-list@lists.sourceforge.net; Tue, 12 May 2015 06:28:32 +0000
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t4C6R7LP022500
	for <ltp-list@lists.sourceforge.net>; Tue, 12 May 2015 14:27:07 +0800
From: "Wei,Jiangang" <weijg.fnst@cn.fujitsu.com>
Date: Tue, 12 May 2015 14:27:29 +0800
Message-ID: <1431412049-24348-5-git-send-email-weijg.fnst@cn.fujitsu.com>
In-Reply-To: <1431412049-24348-1-git-send-email-weijg.fnst@cn.fujitsu.com>
References: <1431412049-24348-1-git-send-email-weijg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH v2 5/5] kernel/mem/mmapstress: avoid resource leak
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

* Avoid memory leak by allocate readbuf on the stack,
  not by malloc.

* close file descriptor explicitly before return.

Signed-off-by: Wei,Jiangang <weijg.fnst@cn.fujitsu.com>
---
 testcases/kernel/mem/mmapstress/mmapstress01.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/mem/mmapstress/mmapstress01.c b/testcases/kernel/mem/mmapstress/mmapstress01.c
index 0baf0e2..ed1466a 100644
--- a/testcases/kernel/mem/mmapstress/mmapstress01.c
+++ b/testcases/kernel/mem/mmapstress/mmapstress01.c
@@ -602,9 +602,9 @@ int fileokay(char *file, uchar_t * expbuf)
 	struct stat statbuf;
 #endif /* LARGE_FILE */
 	size_t mapsize;
-	uchar_t *readbuf;
 	unsigned mappages;
 	unsigned pagesize = sysconf(_SC_PAGE_SIZE);
+	char readbuf[pagesize];
 	int fd;
 	int cnt;
 	unsigned i, j;
@@ -641,7 +641,6 @@ int fileokay(char *file, uchar_t * expbuf)
 		perror("lseek");
 		anyfail();
 	}
-	readbuf = malloc(pagesize);
 
 	if (statbuf.st_size - sparseoffset > SIZE_MAX) {
 		fprintf(stderr, "size_t overflow when setting up map\n");
@@ -668,6 +667,7 @@ int fileokay(char *file, uchar_t * expbuf)
 				(void)fprintf(stderr, "read %d of %ld bytes\n",
 					      (i * pagesize) + cnt,
 					      (long)mapsize);
+				close(fd);
 				return 0;
 			}
 		}
@@ -688,6 +688,7 @@ int fileokay(char *file, uchar_t * expbuf)
 					      "(fsize %ld)\n", i, j,
 					      statbuf.st_size);
 #endif /* LARGE_FILE */
+				close(fd);
 				return 0;
 			}
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
