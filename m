From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Wed, 4 Apr 2018 19:12:54 +0800
Subject: [LTP] [PATCH v2] sctp/sctp_big_chunk.c: Fix compiler error
In-Reply-To: <fe226cc4-3c0a-0b4b-e618-e31e28647d07@oracle.com>
References: <fe226cc4-3c0a-0b4b-e618-e31e28647d07@oracle.com>
Message-ID: <1522840374-10311-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

On old distros(e.g. RHEL5), Compilation failed because of redefinitions
from linux/sctp.h(including linux/in.h) and netinet/in.h, as below:
----------------------------------------------------------------------
In file included from /usr/include/linux/sctp.h:54,
                 from ../../../include/lapi/sctp.h:22,
                 from sctp_big_chunk.c:35:
/usr/include/linux/in.h:26: error: redeclaration of enumerator ‘IPPROTO_IP’
/usr/include/netinet/in.h:33: error: previous definition of ‘IPPROTO_IP’ was here
...
----------------------------------------------------------------------

1) Remove the include of linux/sctp.h to fix it.
2) Include netinet/sctp.h, if it was available.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 configure.ac        | 2 +-
 include/lapi/sctp.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/configure.ac b/configure.ac
index 9358064..9208f1c 100644
--- a/configure.ac
+++ b/configure.ac
@@ -44,8 +44,8 @@ AC_CHECK_HEADERS([ \
     linux/mempolicy.h \
     linux/module.h \
     linux/netlink.h \
-    linux/sctp.h \
     mm.h \
+    netinet/sctp.h \
     pthread.h \
     sys/epoll.h \
     sys/fanotify.h \
diff --git a/include/lapi/sctp.h b/include/lapi/sctp.h
index 69adc7a..647052b 100644
--- a/include/lapi/sctp.h
+++ b/include/lapi/sctp.h
@@ -18,8 +18,8 @@
 #ifndef LAPI_SCTP_H__
 #define LAPI_SCTP_H__
 
-#ifdef HAVE_LINUX_SCTP_H
-# include <linux/sctp.h>
+#ifdef HAVE_NETINET_SCTP_H
+# include <netinet/sctp.h>
 #endif
 
 #ifndef SCTP_SOCKOPT_BINDX_ADD
-- 
1.8.3.1



