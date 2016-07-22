From: Khem Raj <raj.khem@gmail.com>
Date: Thu, 21 Jul 2016 21:26:37 -0700
Subject: [LTP] [PATCH V3 04/23] Remove unused __BEGIN_DECLS and __END_DECLS
In-Reply-To: <20160722042656.22346-1-raj.khem@gmail.com>
References: <20160722042656.22346-1-raj.khem@gmail.com>
Message-ID: <20160722042656.22346-4-raj.khem@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Replace __s32 definitions with int32_t
its not a generally available typedef

Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
 testcases/kernel/syscalls/epoll2/include/epoll.h |  5 -----
 utils/sctp/include/netinet/sctp.h                | 10 +++-------
 2 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/testcases/kernel/syscalls/epoll2/include/epoll.h b/testcases/kernel/syscalls/epoll2/include/epoll.h
index be599c7..d6976d1 100644
--- a/testcases/kernel/syscalls/epoll2/include/epoll.h
+++ b/testcases/kernel/syscalls/epoll2/include/epoll.h
@@ -84,9 +84,6 @@ struct epoll_event
   epoll_data_t data;	/* User data variable */
 } EPOLL_PACKED;
 
-
-__BEGIN_DECLS
-
 /* Creates an epoll instance.  Returns an fd for the new instance.
    The "size" parameter is a hint specifying the number of file
    descriptors to be associated with the new instance.  The fd
@@ -114,6 +111,4 @@ extern int epoll_ctl (int __epfd, int __op, int __fd,
 extern int epoll_wait (int __epfd, struct epoll_event *__events,
 		       int __maxevents, int __timeout) __THROW;
 
-__END_DECLS
-
 #endif /* sys/epoll.h */
diff --git a/utils/sctp/include/netinet/sctp.h b/utils/sctp/include/netinet/sctp.h
index 51f5bfb..c302cdb 100644
--- a/utils/sctp/include/netinet/sctp.h
+++ b/utils/sctp/include/netinet/sctp.h
@@ -37,9 +37,7 @@
 #include <linux/types.h>
 #include <sys/socket.h>
 
-__BEGIN_DECLS
-
-typedef __s32 sctp_assoc_t;
+typedef int32_t sctp_assoc_t;
 
 /* Socket option layer for SCTP */
 #ifndef SOL_SCTP
@@ -658,7 +656,7 @@ struct sctp_assoc_value {
 struct sctp_paddrinfo {
 	sctp_assoc_t		spinfo_assoc_id;
 	struct sockaddr_storage	spinfo_address;
-	__s32			spinfo_state;
+	int32_t			spinfo_state;
 	__u32			spinfo_cwnd;
 	__u32			spinfo_srtt;
 	__u32			spinfo_rto;
@@ -693,7 +691,7 @@ enum sctp_spinfo_state {
  */
 struct sctp_status {
 	sctp_assoc_t		sstat_assoc_id;
-	__s32			sstat_state;
+	int32_t			sstat_state;
 	__u32			sstat_rwnd;
 	__u16			sstat_unackdata;
 	__u16			sstat_penddata;
@@ -862,6 +860,4 @@ int sctp_recvmsg(int s, void *msg, size_t len, struct sockaddr *from,
 /* Return the address length for an address family. */
 int sctp_getaddrlen(sa_family_t family);
 
-__END_DECLS
-
 #endif /* __linux_sctp_h__ */
-- 
2.9.0

