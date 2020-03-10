From: Ronald Monthero <rmonther@redhat.com>
Date: Tue, 10 Mar 2020 12:44:54 +1000
Subject: [LTP] Fix build error because of undefined CAP_SYS_TIME
Message-ID: <CAGR3Yi6r+caUYV+yZYHGsuRUPQBbpsN_PJOTTSvHwE2VARy92g@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Details of the build log at pr#654
https://github.com/linux-test-project/ltp/pull/654

Signed-off-by: Ronald Monthero <rmonther@redhat.com>
---
diff --git a/include/lapi/capability.h b/include/lapi/capability.h
index 8833f0605..8ed68bfce 100644
--- a/include/lapi/capability.h
+++ b/include/lapi/capability.h
@@ -24,6 +24,10 @@
 # define CAP_NET_RAW          13
 #endif

+#ifndef CAP_SYS_TIME
+#define CAP_SYS_TIME          25
+#endif
+
 #ifndef CAP_SYS_ADMIN
 # define CAP_SYS_ADMIN        21
 #endif
---
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200310/1561eedc/attachment.htm>
