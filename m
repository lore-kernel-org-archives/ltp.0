Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <weijg.fnst@cn.fujitsu.com>) id 1YqdjN-0005NV-3h
	for ltp-list@lists.sourceforge.net; Fri, 08 May 2015 08:34:01 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YqdjL-0003KT-Vp
	for ltp-list@lists.sourceforge.net; Fri, 08 May 2015 08:34:01 +0000
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t488WYht012401
	for <ltp-list@lists.sourceforge.net>; Fri, 8 May 2015 16:32:34 +0800
From: "Wei,Jiangang" <weijg.fnst@cn.fujitsu.com>
Date: Fri, 8 May 2015 16:33:18 +0800
Message-ID: <1431073998-29052-1-git-send-email-weijg.fnst@cn.fujitsu.com>
In-Reply-To: <20150507132127.GD28637@rei.suse.de>
References: <20150507132127.GD28637@rei.suse.de>
MIME-Version: 1.0
Subject: [LTP] [PATCH v3 3/5] kernel/mem/hugetlb/lib: do refactor for
	getuserid
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
 testcases/kernel/mem/hugetlb/lib/libipc.c | 33 +++++++++++++++++++++++--------
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/testcases/kernel/mem/hugetlb/lib/libipc.c b/testcases/kernel/mem/hugetlb/lib/libipc.c
index 21fd8da..91cc952 100644
--- a/testcases/kernel/mem/hugetlb/lib/libipc.c
+++ b/testcases/kernel/mem/hugetlb/lib/libipc.c
@@ -83,17 +83,34 @@ int getipckey(void)
  */
 int getuserid(char *user)
 {
-	struct passwd *ent;
+	struct passwd pwd;
+	struct passwd *result;
+	char *buf;
+	size_t buflen;
+	int s;
 
-	ent = malloc(sizeof(struct passwd));
-	if (ent == NULL)
-		tst_brkm(TBROK | TERRNO, cleanup, "malloc ent");
+	buflen = sysconf(_SC_GETPW_R_SIZE_MAX);
+	if (buflen == -1)
+		/* Should be more than enough */
+		buflen = 16384;
 
-	ent = getpwnam(user);
-	if (ent == NULL)
-		tst_brkm(TBROK | TERRNO, cleanup, "getpwnam");
+	buf = malloc(buflen);
+	if (buf == NULL)
+		tst_brkm(TBROK, NULL, "malloc failed.\n");
 
-	return ent->pw_uid;
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
