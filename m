From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 13 Jan 2021 08:51:07 +0100
Subject: [LTP] [PATCH v2 0/3] Build fix undefined struct file_handle
Message-ID: <20210113075110.31628-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

changes v1->v2:
* use autotools to detect struct file_handle

Kind regards,
Petr

diff --git configure.ac configure.ac
index 06be1c094..e44e25cc6 100644
--- configure.ac
+++ configure.ac
@@ -148,6 +148,12 @@ AC_CHECK_TYPES([struct acct_v3],,,[#include <sys/acct.h>])
 AC_CHECK_TYPES([struct af_alg_iv, struct sockaddr_alg],,,[# include <linux/if_alg.h>])
 AC_CHECK_TYPES([struct fanotify_event_info_fid, struct fanotify_event_info_header],,,[#include <sys/fanotify.h>])
 AC_CHECK_TYPES([struct file_dedupe_range],,,[#include <linux/fs.h>])
+
+AC_CHECK_TYPES([struct file_handle],,,[
+#define _GNU_SOURCE
+#include <fcntl.h>
+])
+
 AC_CHECK_TYPES([struct fs_quota_statv],,,[#include <xfs/xqm.h>])
 AC_CHECK_TYPES([struct if_nextdqblk],,,[#include <linux/quota.h>])
 AC_CHECK_TYPES([struct iovec],,,[#include <sys/uio.h>])
diff --git include/lapi/fcntl.h include/lapi/fcntl.h
index ab460beb3..e08970c4f 100644
--- include/lapi/fcntl.h
+++ include/lapi/fcntl.h
@@ -141,13 +141,13 @@
 # define MAX_HANDLE_SZ	128
 #endif
 
-#ifndef HAVE_NAME_TO_HANDLE_AT
+#ifndef HAVE_STRUCT_FILE_HANDLE
 struct file_handle {
 	unsigned int handle_bytes;
 	int handle_type;
 	/* File identifier.  */
 	unsigned char f_handle[0];
 };
-#endif /* HAVE_NAME_TO_HANDLE_AT */
+#endif /* HAVE_STRUCT_FILE_HANDLE */
 
 #endif /* __LAPI_FCNTL_H__ */

Petr Vorel (3):
  lapi: Move struct file_handle into lapi/fcntl.h
  fanotify: Fix build on undefined struct file_handle
  syscalls: Remove unused include <fcntl.h>

 configure.ac                                           |  6 ++++++
 include/lapi/fcntl.h                                   | 10 ++++++++++
 include/lapi/name_to_handle_at.h                       |  9 +--------
 testcases/kernel/syscalls/fanotify/fanotify.h          |  2 +-
 testcases/kernel/syscalls/fanotify/fanotify09.c        |  1 -
 testcases/kernel/syscalls/fanotify/fanotify13.c        |  1 -
 testcases/kernel/syscalls/fanotify/fanotify15.c        |  1 -
 testcases/kernel/syscalls/fanotify/fanotify16.c        |  1 -
 .../syscalls/name_to_handle_at/name_to_handle_at01.c   |  1 -
 .../syscalls/name_to_handle_at/name_to_handle_at02.c   |  1 -
 .../syscalls/open_by_handle_at/open_by_handle_at01.c   |  1 -
 .../syscalls/open_by_handle_at/open_by_handle_at02.c   |  1 -
 12 files changed, 18 insertions(+), 17 deletions(-)

-- 
2.29.2

