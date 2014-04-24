Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1WdH8w-0001ul-Um
	for ltp-list@lists.sourceforge.net; Thu, 24 Apr 2014 10:44:39 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WdH8v-0001cK-BM
	for ltp-list@lists.sourceforge.net; Thu, 24 Apr 2014 10:44:38 +0000
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s3OAiTQC032439
	for <ltp-list@lists.sourceforge.net>; Thu, 24 Apr 2014 18:44:29 +0800
Message-ID: <1398336249.2318.3.camel@G08JYZSD130126>
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Thu, 24 Apr 2014 18:44:09 +0800
MIME-Version: 1.0
Subject: [LTP] [PATCH 1/3] safe_macros: Add SAFE_GETRESUID and SAFE_GETRESGID
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
 include/safe_macros.h | 10 ++++++++++
 lib/safe_macros.c     | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/include/safe_macros.h b/include/safe_macros.h
index 25846f4..e9fc485 100644
--- a/include/safe_macros.h
+++ b/include/safe_macros.h
@@ -126,6 +126,16 @@ int	safe_setuid(const char *file, const int lineno,
 #define SAFE_SETUID(cleanup_fn, uid) \
 	safe_setuid(__FILE__, __LINE__, cleanup_fn, (uid))
 
+int	safe_getresuid(const char *file, const int lineno,
+	    void (*cleanup_fn)(void), uid_t *ruid, uid_t *euid, uid_t *suid);
+#define SAFE_GETRESUID(cleanup_fn, ruid, euid, suid) \
+	safe_getresuid(__FILE__, __LINE__, cleanup_fn, (ruid), (euid), (suid))
+
+int	safe_getresgid(const char *file, const int lineno,
+	    void (*cleanup_fn)(void), gid_t *rgid, gid_t *egid, gid_t *sgid);
+#define SAFE_GETRESGID(cleanup_fn, rgid, egid, sgid) \
+	safe_getresgid(__FILE__, __LINE__, cleanup_fn, (rgid), (egid), (sgid))
+
 int	safe_unlink(const char *file, const int lineno,
 	    void (*cleanup_fn)(void), const char *pathname);
 #define SAFE_UNLINK(cleanup_fn, pathname) \
diff --git a/lib/safe_macros.c b/lib/safe_macros.c
index 0d805e9..b4fe02f 100644
--- a/lib/safe_macros.c
+++ b/lib/safe_macros.c
@@ -310,6 +310,38 @@ int safe_setuid(const char *file, const int lineno, void (*cleanup_fn) (void),
 	return rval;
 }
 
+int safe_getresuid(const char *file, const int lineno, void (*cleanup_fn)(void),
+		   uid_t *ruid, uid_t *euid, uid_t *suid)
+{
+	int rval;
+
+	rval = getresuid(ruid, euid, suid);
+	if (rval == -1) {
+		tst_brkm(TBROK | TERRNO, cleanup_fn,
+			 "%s:%d: getresuid(%u, %u, %u) failed",
+			 file, lineno, (unsigned) *ruid, (unsigned) *euid,
+			 (unsigned) *suid);
+	}
+
+	return rval;
+}
+
+int safe_getresgid(const char *file, const int lineno, void (*cleanup_fn)(void),
+		   gid_t *rgid, gid_t *egid, gid_t *sgid)
+{
+	int rval;
+
+	rval = getresgid(rgid, egid, sgid);
+	if (rval == -1) {
+		tst_brkm(TBROK | TERRNO, cleanup_fn,
+			 "%s:%d: getresgid(%u, %u, %u) failed",
+			 file, lineno, (unsigned) *rgid, (unsigned) *egid,
+			 (unsigned) *sgid);
+	}
+
+	return rval;
+}
+
 int safe_unlink(const char *file, const int lineno, void (*cleanup_fn) (void),
                 const char *pathname)
 {
-- 
1.8.4.2




------------------------------------------------------------------------------
Start Your Social Network Today - Download eXo Platform
Build your Enterprise Intranet with eXo Platform Software
Java Based Open Source Intranet - Social, Extensible, Cloud Ready
Get Started Now And Turn Your Intranet Into A Collaboration Platform
http://p.sf.net/sfu/ExoPlatform
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
