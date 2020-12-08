From: Feiyu Zhu <zhufy.jy@cn.fujitsu.com>
Date: Tue, 8 Dec 2020 05:07:46 -0500
Subject: [LTP] [PATCH 2/3] lapi/msg.h: Add MSG_STAT_ANY
In-Reply-To: <1607422067-15500-1-git-send-email-zhufy.jy@cn.fujitsu.com>
References: <1607422067-15500-1-git-send-email-zhufy.jy@cn.fujitsu.com>
Message-ID: <1607422067-15500-2-git-send-email-zhufy.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Feiyu Zhu <zhufy.jy@cn.fujitsu.com>
---
 include/lapi/msg.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/lapi/msg.h b/include/lapi/msg.h
index d649f33..0295111 100644
--- a/include/lapi/msg.h
+++ b/include/lapi/msg.h
@@ -12,4 +12,8 @@
 # define MSG_COPY  040000  /* copy (not remove) all queue messages */
 #endif
 
+#ifndef MSG_STAT_ANY
+# define MSG_STAT_ANY 13
+#endif
+
 #endif
-- 
1.8.3.1



