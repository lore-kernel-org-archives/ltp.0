Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gux.fnst@cn.fujitsu.com>) id 1WvHdL-00016A-7k
	for ltp-list@lists.sourceforge.net; Fri, 13 Jun 2014 02:54:27 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WvHdJ-0007gm-9B
	for ltp-list@lists.sourceforge.net; Fri, 13 Jun 2014 02:54:27 +0000
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s5D2sHlU022963
	for <ltp-list@lists.sourceforge.net>; Fri, 13 Jun 2014 10:54:17 +0800
From: Xing Gu <gux.fnst@cn.fujitsu.com>
Date: Fri, 13 Jun 2014 10:53:17 +0800
Message-ID: <1402627999-11535-1-git-send-email-gux.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH 1/3] lib: Add SAFE_CHOWN()
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

Signed-off-by: Xing Gu <gux.fnst@cn.fujitsu.com>
---
 include/safe_macros.h |  5 +++++
 lib/safe_macros.c     | 15 +++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/include/safe_macros.h b/include/safe_macros.h
index ea1e976..f521347 100644
--- a/include/safe_macros.h
+++ b/include/safe_macros.h
@@ -231,6 +231,11 @@ int safe_fchmod(const char *file, const int lineno, void (cleanup_fn)(void),
 #define SAFE_FCHMOD(cleanup_fn, fd, mode) \
 	safe_fchmod(__FILE__, __LINE__, (cleanup_fn), (fd), (mode))
 
+int safe_chown(const char *file, const int lineno, void (cleanup_fn)(void),
+			const char *path, uid_t owner, gid_t group);
+#define SAFE_CHOWN(cleanup_fn, path, owner, group) \
+	safe_chown(__FILE__, __LINE__, (cleanup_fn), (path), (owner), (group))
+
 int safe_fchown(const char *file, const int lineno, void (cleanup_fn)(void),
                 int fd, uid_t owner, gid_t group);
 #define SAFE_FCHOWN(cleanup_fn, fd, owner, group) \
diff --git a/lib/safe_macros.c b/lib/safe_macros.c
index 13cc08e..a07cffa 100644
--- a/lib/safe_macros.c
+++ b/lib/safe_macros.c
@@ -662,6 +662,21 @@ int safe_fchmod(const char *file, const int lineno,
 	return rval;
 }
 
+int safe_chown(const char *file, const int lineno, void (cleanup_fn)(void),
+			const char *path, uid_t owner, gid_t group)
+{
+	int rval;
+
+	rval = chown(path, owner, group);
+
+	if (rval == -1) {
+		tst_brkm(TBROK | TERRNO, cleanup_fn,
+			"%s:%d: chown(%s,%d,%d) failed",
+			file, lineno, path, owner, group);
+	}
+
+	return rval;
+}
 
 int safe_fchown(const char *file, const int lineno, void (cleanup_fn)(void),
                 int fd, uid_t owner, gid_t group)
-- 
1.9.3


------------------------------------------------------------------------------
HPCC Systems Open Source Big Data Platform from LexisNexis Risk Solutions
Find What Matters Most in Your Big Data with HPCC Systems
Open Source. Fast. Scalable. Simple. Ideal for Dirty Data.
Leverages Graph Analysis for Fast Processing & Easy Data Exploration
http://p.sf.net/sfu/hpccsystems
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
