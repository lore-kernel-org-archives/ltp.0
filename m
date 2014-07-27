Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1XBKL4-0004nL-CK
	for ltp-list@lists.sourceforge.net; Sun, 27 Jul 2014 09:01:54 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XBKL2-0003DB-Ec
	for ltp-list@lists.sourceforge.net; Sun, 27 Jul 2014 09:01:54 +0000
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Date: Sun, 27 Jul 2014 17:00:53 +0800
Message-ID: <1406451654-14224-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
In-Reply-To: <53D4BB5B.5030701@cn.fujitsu.com>
References: <53D4BB5B.5030701@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH v2 1/2] lib: add SAFE_RENAME()
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

Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
---
 include/safe_macros.h |  5 +++++
 lib/safe_macros.c     | 16 ++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/include/safe_macros.h b/include/safe_macros.h
index f521347..a79c4ad 100644
--- a/include/safe_macros.h
+++ b/include/safe_macros.h
@@ -266,5 +266,10 @@ int safe_mkfifo(const char *file, const int lineno,
 #define SAFE_MKFIFO(cleanup_fn, pathname, mode) \
 	safe_mkfifo(__FILE__, __LINE__, (cleanup_fn), (pathname), (mode))
 
+int safe_rename(const char *file, const int lineno, void (*cleanup_fn)(void),
+		const char *oldpath, const char *newpath);
+#define SAFE_RENAME(cleanup_fn, oldpath, newpath) \
+	safe_rename(__FILE__, __LINE__, (cleanup_fn), (oldpath), (newpath))
+
 #endif /* __SAFE_MACROS_H__ */
 #endif /* __TEST_H__ */
diff --git a/lib/safe_macros.c b/lib/safe_macros.c
index a07cffa..eefacae 100644
--- a/lib/safe_macros.c
+++ b/lib/safe_macros.c
@@ -768,3 +768,19 @@ int safe_mkfifo(const char *file, const int lineno,
 
 	return rval;
 }
+
+int safe_rename(const char *file, const int lineno, void (*cleanup_fn)(void),
+		const char *oldpath, const char *newpath)
+{
+	int rval;
+
+	rval = rename(oldpath, newpath);
+
+	if (rval == -1) {
+		tst_brkm(TBROK | TERRNO, cleanup_fn,
+			 "%s:%d: rename(%s, %s) failed",
+			 file, lineno, oldpath, newpath);
+	}
+
+	return rval;
+}
-- 
1.8.2.1


------------------------------------------------------------------------------
Want fast and easy access to all the code in your enterprise? Index and
search up to 200,000 lines of code with a free copy of Black Duck
Code Sight - the same software that powers the world's largest code
search on Ohloh, the Black Duck Open Hub! Try it now.
http://p.sf.net/sfu/bds
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
