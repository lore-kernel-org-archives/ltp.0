From: Khem Raj <raj.khem@gmail.com>
Date: Sat,  9 Jan 2016 01:13:58 +0000
Subject: [LTP] [PATCH V2 10/32] replace __BEGIN_DECLS and __END_DECLS
In-Reply-To: <1452302060-103643-1-git-send-email-raj.khem@gmail.com>
References: <1452302060-103643-1-git-send-email-raj.khem@gmail.com>
Message-ID: <1452302060-103643-10-git-send-email-raj.khem@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

They are not portable across libc implementations
therefore replace them with expanded macros

Include <asm-generic/types.h> to get __s32 definitions
its not a generally available typedef

Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
 testcases/kernel/syscalls/epoll2/include/epoll.h | 8 ++++++--
 utils/sctp/include/netinet/sctp.h                | 9 +++++++--
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/epoll2/include/epoll.h b/testcases/kernel/syscalls/epoll2/include/epoll.h
index be599c7..8cc5e7e 100644
--- a/testcases/kernel/syscalls/epoll2/include/epoll.h
+++ b/testcases/kernel/syscalls/epoll2/include/epoll.h
@@ -85,7 +85,9 @@ struct epoll_event
 } EPOLL_PACKED;
 
 
-__BEGIN_DECLS
+#ifdef __cplusplus
+extern "C" {
+#endif
 
 /* Creates an epoll instance.  Returns an fd for the new instance.
    The "size" parameter is a hint specifying the number of file
@@ -114,6 +116,8 @@ extern int epoll_ctl (int __epfd, int __op, int __fd,
 extern int epoll_wait (int __epfd, struct epoll_event *__events,
 		       int __maxevents, int __timeout) __THROW;
 
-__END_DECLS
+#ifdef __cplusplus
+}
+#endif
 
 #endif /* sys/epoll.h */
diff --git a/utils/sctp/include/netinet/sctp.h b/utils/sctp/include/netinet/sctp.h
index 51f5bfb..c61aef3 100644
--- a/utils/sctp/include/netinet/sctp.h
+++ b/utils/sctp/include/netinet/sctp.h
@@ -35,9 +35,12 @@
 
 #include <stdint.h>
 #include <linux/types.h>
+#include <asm-generic/types.h>
 #include <sys/socket.h>
 
-__BEGIN_DECLS
+#ifdef __cplusplus
+extern "C" {
+#endif
 
 typedef __s32 sctp_assoc_t;
 
@@ -862,6 +865,8 @@ int sctp_recvmsg(int s, void *msg, size_t len, struct sockaddr *from,
 /* Return the address length for an address family. */
 int sctp_getaddrlen(sa_family_t family);
 
-__END_DECLS
+#ifdef __cplusplus
+}
+#endif
 
 #endif /* __linux_sctp_h__ */
-- 
2.7.0

