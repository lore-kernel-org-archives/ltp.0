From: Martin Doucha <mdoucha@suse.cz>
Date: Mon,  1 Feb 2021 17:39:45 +0100
Subject: [LTP] [PATCH 1/4] Prevent linker issues in lapi/io_uring.h
Message-ID: <20210201163948.24783-1-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Fallback io_uring syscall wrappers were not defined as static inline. This
will lead to linker issues when safe function variants get added to LTP
library.

Also add check for <linux/io_uring.h> to configure script and #include it
in the LAPI header if it's available.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 configure.ac            |  1 +
 include/lapi/io_uring.h | 17 +++++++++++------
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/configure.ac b/configure.ac
index 8bdb96300..9fb50c173 100644
--- a/configure.ac
+++ b/configure.ac
@@ -49,6 +49,7 @@ AC_CHECK_HEADERS_ONCE([ \
     linux/if_alg.h \
     linux/if_ether.h \
     linux/if_packet.h \
+    linux/io_uring.h \
     linux/keyctl.h \
     linux/mempolicy.h \
     linux/module.h \
diff --git a/include/lapi/io_uring.h b/include/lapi/io_uring.h
index 174e81e4d..9d280f155 100644
--- a/include/lapi/io_uring.h
+++ b/include/lapi/io_uring.h
@@ -18,6 +18,10 @@
 
 #include "lapi/syscalls.h"
 
+#ifdef HAVE_LINUX_IO_URING_H
+#include <linux/io_uring.h>
+#endif
+
 #ifndef IOSQE_FIXED_FILE
 
 #ifndef __kernel_rwf_t
@@ -260,8 +264,8 @@ struct io_uring_probe {
 
 
 #ifndef HAVE_IO_URING_REGISTER
-int io_uring_register(int fd, unsigned int opcode, void *arg,
-		      unsigned int nr_args)
+static inline int io_uring_register(int fd, unsigned int opcode, void *arg,
+	unsigned int nr_args)
 {
 	return tst_syscall(__NR_io_uring_register, fd, opcode, arg, nr_args);
 }
@@ -269,22 +273,23 @@ int io_uring_register(int fd, unsigned int opcode, void *arg,
 
 
 #ifndef HAVE_IO_URING_SETUP
-int io_uring_setup(unsigned int entries, struct io_uring_params *p)
+static inline int io_uring_setup(unsigned int entries,
+	struct io_uring_params *p)
 {
 	return tst_syscall(__NR_io_uring_setup, entries, p);
 }
 #endif /* HAVE_IO_URING_SETUP */
 
 #ifndef HAVE_IO_URING_ENTER
-int io_uring_enter(int fd, unsigned int to_submit, unsigned int min_complete,
-		   unsigned int flags, sigset_t *sig)
+static inline int io_uring_enter(int fd, unsigned int to_submit,
+	unsigned int min_complete, unsigned int flags, sigset_t *sig)
 {
 	return tst_syscall(__NR_io_uring_enter, fd, to_submit, min_complete,
 			flags, sig, _NSIG / 8);
 }
 #endif /* HAVE_IO_URING_ENTER */
 
-void io_uring_setup_supported_by_kernel(void)
+static inline void io_uring_setup_supported_by_kernel(void)
 {
 	if ((tst_kvercmp(5, 1, 0)) < 0) {
 		TEST(syscall(__NR_io_uring_setup, NULL, 0));
-- 
2.30.0

