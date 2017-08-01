From: Yury Norov <ynorov@caviumnetworks.com>
Date: Wed, 2 Aug 2017 00:39:31 +0300
Subject: [LTP] LTP build issues
Message-ID: <20170801213931.gajssq5kldsv46rz@yury-thinkpad>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi all,

I just pulled latest LTP sources and try to build it for the arm64/ilp32 with
toolchain provided by Linaro.
http://people.linaro.org/~maxim.kuvyrkov/experimental/preview-cross-aarch64-linux-gnu_ilp32.tar.xz

And I see that build fails due to multiple reasons. At first I had to revert
patches 817d8095f (Rename linux_syscall_numbers.h to lapi/syscalls.h)
and 4d0d149c4 (Remove linux_syscall_numbers.h Makefile)
because there'ds no lapi/syscalls.h file, and so build becomes broken.

There are also other reasons for build failures that dirty-fixed in patch
below. Could someone comment it and/or share proper fix?

Yury

diff --git a/testcases/cve/cve-2016-7117.c b/testcases/cve/cve-2016-7117.c
index 42e90da10..9f5d649b9 100644
--- a/testcases/cve/cve-2016-7117.c
+++ b/testcases/cve/cve-2016-7117.c
@@ -64,6 +64,7 @@
 #define RECV_TIMEOUT 1
 #define ATTEMPTS 0x1FFFFF
 
+#define HAVE_STRUCT_MMSGHDR
 #ifndef HAVE_STRUCT_MMSGHDR
 struct mmsghdr {
 	struct msghdr msg_hdr;
diff --git a/testcases/kernel/syscalls/fstatat/fstatat01.c b/testcases/kernel/syscalls/fstatat/fstatat01.c
index 840d7b60e..038577327 100644
--- a/testcases/kernel/syscalls/fstatat/fstatat01.c
+++ b/testcases/kernel/syscalls/fstatat/fstatat01.c
@@ -58,6 +58,7 @@ static const char *filenames[TEST_CASES];
 static const int expected_errno[] = { 0, 0, ENOTDIR, EBADF, EINVAL, 0 };
 static const int flags[] = { 0, 0, 0, 0, 9999, 0 };
 
+#define HAVE_FSTATAT
 #if !defined(HAVE_FSTATAT)
 #if (__NR_fstatat64 > 0)
 int fstatat(int dirfd, const char *filename, struct stat64 *statbuf, int flags)
diff --git a/testcases/kernel/syscalls/keyctl/Makefile b/testcases/kernel/syscalls/keyctl/Makefile
index bb3d3a41d..654503e37 100644
--- a/testcases/kernel/syscalls/keyctl/Makefile
+++ b/testcases/kernel/syscalls/keyctl/Makefile
@@ -18,8 +18,8 @@
 
 top_srcdir		?= ../../../..
 
-keyctl02: LDLIBS	+=-lpthread $(KEYUTILS_LIBS)
-keyctl03: LDLIBS	+=$(KEYUTILS_LIBS)
+keyctl02: LDLIBS	+=-lpthread #$(KEYUTILS_LIBS)
+#keyctl03: LDLIBS	+=$(KEYUTILS_LIBS)
 
 include $(top_srcdir)/include/mk/testcases.mk
 
diff --git a/testcases/kernel/syscalls/preadv/preadv.h b/testcases/kernel/syscalls/preadv/preadv.h
index f3ac30db3..b00138983 100644
--- a/testcases/kernel/syscalls/preadv/preadv.h
+++ b/testcases/kernel/syscalls/preadv/preadv.h
@@ -21,6 +21,7 @@
 #include "config.h"
 #include "linux_syscall_numbers.h"
 
+#define HAVE_PREADV
 #if !defined(HAVE_PREADV)
 int preadv(int fd, const struct iovec *iov, int iovcnt, off_t offset)
 {
diff --git a/testcases/kernel/syscalls/pwritev/pwritev.h b/testcases/kernel/syscalls/pwritev/pwritev.h
index 4970036ef..6fd01ad4c 100644
--- a/testcases/kernel/syscalls/pwritev/pwritev.h
+++ b/testcases/kernel/syscalls/pwritev/pwritev.h
@@ -21,6 +21,7 @@
 #include "config.h"
 #include "linux_syscall_numbers.h"
 
+#define HAVE_PWRITEV
 #if !defined(HAVE_PWRITEV)
 int pwritev(int fd, const struct iovec *iov, int iovcnt, off_t offset)
 {
diff --git a/testcases/kernel/syscalls/request_key/Makefile b/testcases/kernel/syscalls/request_key/Makefile
index 9add429d4..4f3d6bbc6 100644
--- a/testcases/kernel/syscalls/request_key/Makefile
+++ b/testcases/kernel/syscalls/request_key/Makefile
@@ -19,6 +19,7 @@ top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
 
-LDLIBS		+= $(KEYUTILS_LIBS)
+#LDLIBS		+= $(KEYUTILS_LIBS)
+#LDLIBS		+= -lkeyutils
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
