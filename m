Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <maninder1.s@samsung.com>) id 1Z2a3y-0004wF-UM
	for ltp-list@lists.sourceforge.net; Wed, 10 Jun 2015 07:04:38 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1Z2a3x-0003qV-4R
	for ltp-list@lists.sourceforge.net; Wed, 10 Jun 2015 07:04:38 +0000
Received: from epcpsbgr3.samsung.com
	(u143.gpu120.samsung.co.kr [203.254.230.143])
	by mailout1.samsung.com (Oracle Communications Messaging Server
	7.0.5.31.0 64bit (built May  5 2014))
	with ESMTP id <0NPP02O1EVNAMMC0@mailout1.samsung.com> for
	ltp-list@lists.sourceforge.net; Wed, 10 Jun 2015 16:04:22 +0900 (KST)
Date: Wed, 10 Jun 2015 07:04:29 +0000 (GMT)
From: Maninder Singh <maninder1.s@samsung.com>
MIME-version: 1.0
MIME-version: 1.0
Message-id: <1390423659.810531433919869667.JavaMail.weblogic@epmlwas05b>
Subject: [LTP] [PATCH 3/8] tools:proc/readproc.c: remove explicit NULL check
 before free
Reply-To: maninder1.s@samsung.com
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
To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

No need of NULL check before free

Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
Signed-off-by: Akhilesh Kumar <akhilesh.k@samsung.com>
---
 tools/top-LTP/proc/readproc.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/top-LTP/proc/readproc.c b/tools/top-LTP/proc/readproc.c
index fd366e7..ead9623 100644
--- a/tools/top-LTP/proc/readproc.c
+++ b/tools/top-LTP/proc/readproc.c
@@ -275,8 +275,7 @@ static char **file2strvec(const char *directory, const char *what)
 		if (n == 0 && rbuf == 0)
 			return NULL;	/* process died between our open and read */
 		if (n < 0) {
-			if (rbuf)
-				free(rbuf);
+			free(rbuf);
 			return NULL;	/* read error */
 		}
 		if (end_of_file && buf[n - 1])	/* last read char not null */
@@ -289,8 +288,7 @@ static char **file2strvec(const char *directory, const char *what)
 	}
 	close(fd);
 	if (n <= 0 && !end_of_file) {
-		if (rbuf)
-			free(rbuf);
+		free(rbuf);
 		return NULL;	/* read error */
 	}
 	endbuf = rbuf + tot;	/* count space for pointers */
-- 
1.7.9.5

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
