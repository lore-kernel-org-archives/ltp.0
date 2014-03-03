Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1WKQxh-0003TG-4H
	for ltp-list@lists.sourceforge.net; Mon, 03 Mar 2014 11:23:09 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WKQxf-0000UF-3x
	for ltp-list@lists.sourceforge.net; Mon, 03 Mar 2014 11:23:09 +0000
Message-ID: <1393845775.1984.10.camel@G08JYZSD130126>
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Mon, 03 Mar 2014 19:22:55 +0800
In-Reply-To: <1720660524.12179720.1393837634610.JavaMail.zimbra@redhat.com>
References: <1392372604.2085.10.camel@G08JYZSD130126>
	<1795224124.5672526.1392809381205.JavaMail.zimbra@redhat.com>
	<1392889204.2053.7.camel@G08JYZSD130126>
	<1392889813.2053.10.camel@G08JYZSD130126>
	<1128042688.6449127.1392894329625.JavaMail.zimbra@redhat.com>
	<929738145.6498501.1392901385804.JavaMail.zimbra@redhat.com>
	<1393832848.1991.19.camel@G08JYZSD130126>
	<1393833079.1991.22.camel@G08JYZSD130126>
	<1720660524.12179720.1393837634610.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Subject: [LTP] [PATCH v5 1/3] safe_macros: Add SAFE_GETRLIMIT and
	SAFE_SETRLIMIT
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
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 include/safe_macros.h | 10 ++++++++++
 lib/safe_macros.c     | 30 ++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/include/safe_macros.h b/include/safe_macros.h
index 207affc..bdd974c 100644
--- a/include/safe_macros.h
+++ b/include/safe_macros.h
@@ -196,5 +196,15 @@ int safe_lstat(const char *file, const int lineno, void (cleanup_fn)(void),
 #define SAFE_LSTAT(cleanup_fn, path, buf) \
 	safe_lstat(__FILE__, __LINE__, (cleanup_fn), (path), (buf))
 
+int safe_getrlimit(const char *file, const int lineno, void (cleanup_fn)(void),
+		   int resource, struct rlimit *rlim);
+#define SAFE_GETRLIMIT(cleanup_fn, resource, rlim) \
+	safe_getrlimit(__FILE__, __LINE__, (cleanup_fn), (resource), (rlim))
+
+int safe_setrlimit(const char *file, const int lineno, void (cleanup_fn)(void),
+		   int resource, const struct rlimit *rlim);
+#define SAFE_SETRLIMIT(cleanup_fn, resource, rlim) \
+	safe_setrlimit(__FILE__, __LINE__, (cleanup_fn), (resource), (rlim))
+
 #endif /* __SAFE_MACROS_H__ */
 #endif /* __TEST_H__ */
diff --git a/lib/safe_macros.c b/lib/safe_macros.c
index ad24195..e8795ef 100644
--- a/lib/safe_macros.c
+++ b/lib/safe_macros.c
@@ -500,3 +500,33 @@ int safe_lstat(const char *file, const int lineno,
 
 	return rval;
 }
+
+int safe_getrlimit(const char *file, const int lineno,
+		   void (cleanup_fn)(void), int resource, struct rlimit *rlim)
+{
+	int rval;
+
+	rval = getrlimit(resource, rlim);
+
+	if (rval == -1) {
+		tst_brkm(TBROK | TERRNO, cleanup_fn,
+			 "getrlimit failed at %s:%d", file, lineno);
+	}
+
+	return rval;
+}
+
+int safe_setrlimit(const char *file, const int lineno, void (cleanup_fn)(void),
+		   int resource, const struct rlimit *rlim)
+{
+	int rval;
+
+	rval = setrlimit(resource, rlim);
+
+	if (rval == -1) {
+		tst_brkm(TBROK | TERRNO, cleanup_fn,
+			 "setrlimit failed at %s:%d", file, lineno);
+	}
+
+	return rval;
+}
-- 
1.8.4.2




------------------------------------------------------------------------------
Subversion Kills Productivity. Get off Subversion & Make the Move to Perforce.
With Perforce, you get hassle-free workflows. Merge that actually works. 
Faster operations. Version large binaries.  Built-in WAN optimization and the
freedom to use Git, Perforce or both. Make the move to Perforce.
http://pubads.g.doubleclick.net/gampad/clk?id=122218951&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
