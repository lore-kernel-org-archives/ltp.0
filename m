Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <maninder1.s@samsung.com>) id 1Z2a71-0004TL-DZ
	for ltp-list@lists.sourceforge.net; Wed, 10 Jun 2015 07:07:47 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1Z2a70-0005fr-9n
	for ltp-list@lists.sourceforge.net; Wed, 10 Jun 2015 07:07:47 +0000
Received: from epcpsbgr5.samsung.com
	(u145.gpu120.samsung.co.kr [203.254.230.145])
	by mailout3.samsung.com (Oracle Communications Messaging Server
	7.0.5.31.0 64bit (built May  5 2014))
	with ESMTP id <0NPP028H6VSR3P20@mailout3.samsung.com> for
	ltp-list@lists.sourceforge.net; Wed, 10 Jun 2015 16:07:39 +0900 (KST)
Date: Wed, 10 Jun 2015 07:07:27 +0000 (GMT)
From: Maninder Singh <maninder1.s@samsung.com>
MIME-version: 1.0
MIME-version: 1.0
Message-id: <1446190768.810921433920047675.JavaMail.weblogic@epmlwas05b>
Subject: [LTP] PATCH 8/8] kernel/libcpuset.c: remove explicit NULL check
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
 .../controllers/cpuset/cpuset_lib/libcpuset.c      |   15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/testcases/kernel/controllers/cpuset/cpuset_lib/libcpuset.c b/testcases/kernel/controllers/cpuset/cpuset_lib/libcpuset.c
index d2d3c12..83ff5cd 100644
--- a/testcases/kernel/controllers/cpuset/cpuset_lib/libcpuset.c
+++ b/testcases/kernel/controllers/cpuset/cpuset_lib/libcpuset.c
@@ -601,8 +601,7 @@ static void update_mask_sizes()
 			nodemask_sz = s2nbits(buf + strlen(nodemask_prefix));
 	}
 done:
-	if (buf != NULL)
-		free(buf);
+	free(buf);
 	if (fp != NULL)
 		fclose(fp);
 	if (cpumask_sz == 0)
@@ -634,8 +633,7 @@ err:
 		bitmask_free(cp->cpus);
 	if (cp && cp->mems)
 		bitmask_free(cp->mems);
-	if (cp)
-		free(cp);
+	free(cp);
 	return NULL;
 }
 
@@ -2588,8 +2586,7 @@ static void add_pidblock(const char *file, struct pidblock **ppbhead)
 err:
 	if (fp)
 		fclose(fp);
-	if (pb)
-		free(pb);
+	free(pb);
 }
 
 static void read_task_file(const char *relpath, struct pidblock **ppbhead)
@@ -2722,8 +2719,7 @@ void cpuset_freepidlist(struct cpuset_pidlist *pl)
 {
 	if (pl && pl->pids)
 		free(pl->pids);
-	if (pl)
-		free(pl);
+	free(pl);
 }
 
 static int __cpuset_move(pid_t pid, const char *path)
@@ -3655,8 +3651,7 @@ eol:
 err:
 	if (elinenum)
 		*elinenum = linenum;
-	if (linebuf)
-		free(linebuf);
+	free(linebuf);
 	return -1;
 }
 
-- 
1.7.9.5

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
