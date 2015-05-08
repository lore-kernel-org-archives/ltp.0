Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <weijg.fnst@cn.fujitsu.com>) id 1Yqdhh-0005In-Om
	for ltp-list@lists.sourceforge.net; Fri, 08 May 2015 08:32:17 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Yqdhf-000822-Dd
	for ltp-list@lists.sourceforge.net; Fri, 08 May 2015 08:32:17 +0000
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t488UfB0012263
	for <ltp-list@lists.sourceforge.net>; Fri, 8 May 2015 16:30:41 +0800
From: "Wei,Jiangang" <weijg.fnst@cn.fujitsu.com>
Date: Fri, 8 May 2015 16:31:21 +0800
Message-ID: <1431073881-28951-1-git-send-email-weijg.fnst@cn.fujitsu.com>
In-Reply-To: <554C57EF.6070603@cn.fujitsu.com>
References: <554C57EF.6070603@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH v3 2/5] kernel/syscalls/ipc/lib: rewrite getuserid
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

* No need to allocate memory for getpwnam()'s return,
  So remove these codes.

* replace getpwnam() with getpwnam_r() that is thread-safe.

Signed-off-by: Wei,Jiangang <weijg.fnst@cn.fujitsu.com>
---
 testcases/kernel/syscalls/ipc/lib/libipc.c | 43 +++++++++++++++++++-----------
 1 file changed, 28 insertions(+), 15 deletions(-)

diff --git a/testcases/kernel/syscalls/ipc/lib/libipc.c b/testcases/kernel/syscalls/ipc/lib/libipc.c
index f10e257..63304f8 100644
--- a/testcases/kernel/syscalls/ipc/lib/libipc.c
+++ b/testcases/kernel/syscalls/ipc/lib/libipc.c
@@ -141,21 +141,34 @@ void rm_sema(int sem_id)
  */
 int getuserid(char *user)
 {
-	struct passwd *ent;
-
-	/* allocate some space for the passwd struct */
-	if ((ent = malloc(sizeof(struct passwd))) == NULL) {
-		tst_brkm(TBROK, cleanup, "couldn't allocate space for passwd"
-			 " structure");
-	}
-
-	/* get the uid value for the user */
-	if ((ent = getpwnam(user)) == NULL) {
-		tst_brkm(TBROK, cleanup, "Couldn't get password entry for %s",
-			 user);
-	}
-
-	return (ent->pw_uid);
+	struct passwd pwd;
+	struct passwd *result;
+	char *buf;
+	size_t buflen;
+	int s;
+
+	buflen = sysconf(_SC_GETPW_R_SIZE_MAX);
+	if (buflen == -1)
+		/* Should be more than enough */
+		buflen = 16384;
+
+	buf = malloc(buflen);
+	if (buf == NULL)
+		tst_brkm(TBROK, NULL, "malloc failed.\n");
+
+	s = getpwnam_r(user, &pwd, buf, buflen, &result);
+	if (result == NULL) {
+		free(buf);
+		if (s == 0) {
+			tst_brkm(TBROK, NULL, "Not found: %s", user);
+		} else {
+			tst_brkm(TBROK, NULL, "getpwnam_r failed. (%d) %s",
+				(s), strerror(s));
+		}
+	}
+	free(buf);
+
+	return pwd.pw_uid;
 }
 
 /*
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
