From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Fri, 23 Mar 2018 18:31:16 +0300
Subject: [LTP] [PATCH] include/lapi/dccp.h: check linux/dccp.h in configure
Message-ID: <1521819076-27327-1-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 configure.ac        |    1 +
 include/lapi/dccp.h |    4 +++-
 2 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/configure.ac b/configure.ac
index 9ff37af..1721ff2 100644
--- a/configure.ac
+++ b/configure.ac
@@ -36,6 +36,7 @@ AC_CHECK_HEADERS([ \
     ifaddrs.h \
     keyutils.h \
     linux/can.h \
+    linux/dccp.h \
     linux/genetlink.h \
     linux/keyctl.h \
     linux/if_packet.h \
diff --git a/include/lapi/dccp.h b/include/lapi/dccp.h
index 1d7fa05..0d852ad 100644
--- a/include/lapi/dccp.h
+++ b/include/lapi/dccp.h
@@ -18,7 +18,9 @@
 #ifndef LAPI_DCCP_H__
 #define LAPI_DCCP_H__
 
-#include <linux/dccp.h>
+#ifdef HAVE_LINUX_DCCP_H
+# include <linux/dccp.h>
+#endif
 
 #ifndef DCCP_SOCKOPT_SERVICE
 # define DCCP_SOCKOPT_SERVICE	2
-- 
1.7.1

