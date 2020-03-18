From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 18 Mar 2020 16:37:53 +0100
Subject: [LTP] [PATCH v2 1/9] lapi/namespace_constants.h: Add CLONE_NEWTIME
In-Reply-To: <20200318153801.3529-1-chrubis@suse.cz>
References: <20200318153801.3529-1-chrubis@suse.cz>
Message-ID: <20200318153801.3529-2-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 include/lapi/namespaces_constants.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/lapi/namespaces_constants.h b/include/lapi/namespaces_constants.h
index da4a7a4a1..8f73c4302 100644
--- a/include/lapi/namespaces_constants.h
+++ b/include/lapi/namespaces_constants.h
@@ -24,5 +24,8 @@
 #ifndef CLONE_NEWUTS
 #  define CLONE_NEWUTS	0x04000000
 #endif
+#ifndef CLONE_NEWTIME
+#  define CLONE_NEWTIME 0x00000080
+#endif
 
 #endif /* __NAMESPACES_CONSTANTS_H__ */
-- 
2.24.1

