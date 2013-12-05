Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1VoYQj-0004CN-Ro
	for ltp-list@lists.sourceforge.net; Thu, 05 Dec 2013 12:53:21 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VoYQh-00064Y-P8
	for ltp-list@lists.sourceforge.net; Thu, 05 Dec 2013 12:53:21 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id rB5CrBXO030448
	for <ltp-list@lists.sourceforge.net>; Thu, 5 Dec 2013 20:53:11 +0800
Message-ID: <1386247987.1542.9.camel@G08JYZSD130126>
From: "zenglg.jy" <zenglg.jy@cn.fujitsu.com>
Date: Thu, 05 Dec 2013 20:53:07 +0800
Mime-Version: 1.0
Subject: [LTP] [PATCH v2 1/4] add SAFE_FSTAT macro
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


Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 include/safe_macros.h |  5 +++++
 lib/safe_macros.c     | 15 +++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/include/safe_macros.h b/include/safe_macros.h
index adf4d09..1a6acdd 100644
--- a/include/safe_macros.h
+++ b/include/safe_macros.h
@@ -175,5 +175,10 @@ long safe_sysconf(const char *file, const int lineno,
 #define SAFE_SYSCONF(cleanup_fn, name) \
 	safe_sysconf(__FILE__, __LINE__, cleanup_fn, name)
 
+int safe_fstat(const char *file, const int lineno, void (cleanup_fn)(void),
+	       int fd, struct stat *buf);
+#define SAFE_FSTAT(cleanup_fn, fd, buf) \
+	safe_fstat(__FILE__, __LINE__, (cleanup_fn), (fd), (buf))
+
 #endif /* __SAFE_MACROS_H__ */
 #endif /* __TEST_H__ */
diff --git a/lib/safe_macros.c b/lib/safe_macros.c
index 4da9914..dea8241 100644
--- a/lib/safe_macros.c
+++ b/lib/safe_macros.c
@@ -438,3 +438,18 @@ long safe_sysconf(const char *file, const int lineno,
 
 	return rval;
 }
+
+int safe_fstat(const char *file, const int lineno,
+	       void (cleanup_fn)(void), int fd, struct stat *buf)
+{
+	int rval;
+
+	rval = fstat(fd, buf);
+
+	if (rval == -1) {
+		tst_brkm(TBROK | TERRNO, cleanup_fn,
+			 "fstat  failed at %s:%d", file, lineno);
+	}
+
+	return rval;
+}
-- 
1.8.2.1





------------------------------------------------------------------------------
Sponsored by Intel(R) XDK 
Develop, test and display web and hybrid apps with a single code base.
Download it for free now!
http://pubads.g.doubleclick.net/gampad/clk?id=111408631&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
