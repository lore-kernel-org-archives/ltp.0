From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Thu, 14 Sep 2017 08:45:20 +0800
Subject: [LTP] [PATCH] cve/cve-2016-10044.c: Fix compilation without
	READ_IMPLIES_EXEC
Message-ID: <1505349920-4620-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Compilation failed on some older distributions(e.g. RHEL5.11) due to
undefined READ_IMPLIES_EXEC in <sys/personality.h>, so we fix it.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 include/lapi/personality.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/lapi/personality.h b/include/lapi/personality.h
index 5b55438..d85baa0 100644
--- a/include/lapi/personality.h
+++ b/include/lapi/personality.h
@@ -27,4 +27,8 @@
 # define UNAME26 0x0020000
 #endif
 
+#ifndef READ_IMPLIES_EXEC
+# define READ_IMPLIES_EXEC 0x0400000
+#endif
+
 #endif	/* PERSONALITY_H */
-- 
1.8.3.1



