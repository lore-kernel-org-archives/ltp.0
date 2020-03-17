From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 17 Mar 2020 17:28:57 +0100
Subject: [LTP] [COMMITTED] [PATCH] lapi/capability.h: Add CAP_SYS_RESOURCE
Message-ID: <20200317162857.1641-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 include/lapi/capability.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/lapi/capability.h b/include/lapi/capability.h
index edc315e6d..fde27efd3 100644
--- a/include/lapi/capability.h
+++ b/include/lapi/capability.h
@@ -36,6 +36,10 @@
 # define CAP_AUDIT_READ       37
 #endif
 
+#ifndef CAP_SYS_RESOURCE
+# define CAP_SYS_RESOURCE     24
+#endif
+
 #ifndef CAP_TO_INDEX
 # define CAP_TO_INDEX(x)     ((x) >> 5)
 #endif
-- 
2.24.1

