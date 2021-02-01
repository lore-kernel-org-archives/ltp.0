From: Martin Doucha <mdoucha@suse.cz>
Date: Mon,  1 Feb 2021 17:39:47 +0100
Subject: [LTP] [PATCH 3/4] Add CAP_SYS_CHROOT to lapi/capability.h
In-Reply-To: <20210201163948.24783-1-mdoucha@suse.cz>
References: <20210201163948.24783-1-mdoucha@suse.cz>
Message-ID: <20210201163948.24783-3-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 include/lapi/capability.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/lapi/capability.h b/include/lapi/capability.h
index fde27efd3..95cb6819b 100644
--- a/include/lapi/capability.h
+++ b/include/lapi/capability.h
@@ -24,6 +24,10 @@
 # define CAP_NET_RAW          13
 #endif
 
+#ifndef CAP_SYS_CHROOT
+# define CAP_SYS_CHROOT       18
+#endif
+
 #ifndef CAP_SYS_ADMIN
 # define CAP_SYS_ADMIN        21
 #endif
-- 
2.30.0

