From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu,  6 Apr 2017 14:46:41 +0200
Subject: [LTP] [RFC] [PATCH v2] lib32: Add support for linking 32bit
	programs on 64bit
Message-ID: <20170406124641.30179-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This is proof of concept for building 32bit testcases on 64bit platform.

What we do is:

* Configure test if compiler supports -m32

* Configure test if compiler supports atomic operations with -m32
  (we have to use fallbacks in tst_atomic.h otherwise)

* The directory lib32 contains symlinks of minimal set of sources
  needed to link newlib testcase + Makefile.

* The testcases.mk builds 32bit library as well if
  32bit compiler was installed (-m32 configure test was succesful)

* And finally the env_post.mk switches between adding -L path to lib or
  lib32 depeding on if -m32 was passed in global CFLAGS and/or in the
  target specific CFLAGS

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---

I've tried for quite minimalistic approach here, instead of trying to detect if
we are on 64bit machine or not we just detect if compiler supports -m32 or not
and build lib32 if we can. We will build the test library twice in case that
32bit compiler supports -m32 but that shouldn't do any harm.


---
 configure.ac                               |  1 +
 include/mk/config.mk.in                    |  2 ++
 include/mk/env_post.mk                     | 21 ++++++++++--
 include/mk/testcases.mk                    |  9 +++++
 include/tst_atomic.h                       |  3 +-
 lib32/Makefile                             | 53 ++++++++++++++++++++++++++++++
 lib32/errnos.h                             |  1 +
 lib32/safe_file_ops.c                      |  1 +
 lib32/safe_macros.c                        |  1 +
 lib32/safe_net.c                           |  1 +
 lib32/signame.h                            |  1 +
 lib32/tst_ansi_color.c                     |  1 +
 lib32/tst_checkpoint.c                     |  1 +
 lib32/tst_device.c                         |  1 +
 lib32/tst_fill_file.c                      |  1 +
 lib32/tst_kvercmp.c                        |  1 +
 lib32/tst_mkfs.c                           |  1 +
 lib32/tst_res.c                            |  1 +
 lib32/tst_resource.c                       |  1 +
 lib32/tst_run_cmd.c                        |  1 +
 lib32/tst_safe_macros.c                    |  1 +
 lib32/tst_test.c                           |  1 +
 lib32/tst_tmpdir.c                         |  1 +
 m4/ltp-m32.m4                              | 50 ++++++++++++++++++++++++++++
 testcases/kernel/syscalls/add_key/Makefile |  2 ++
 25 files changed, 155 insertions(+), 3 deletions(-)
 create mode 100644 lib32/Makefile
 create mode 120000 lib32/errnos.h
 create mode 120000 lib32/safe_file_ops.c
 create mode 120000 lib32/safe_macros.c
 create mode 120000 lib32/safe_net.c
 create mode 120000 lib32/signame.h
 create mode 120000 lib32/tst_ansi_color.c
 create mode 120000 lib32/tst_checkpoint.c
 create mode 120000 lib32/tst_device.c
 create mode 120000 lib32/tst_fill_file.c
 create mode 120000 lib32/tst_kvercmp.c
 create mode 120000 lib32/tst_mkfs.c
 create mode 120000 lib32/tst_res.c
 create mode 120000 lib32/tst_resource.c
 create mode 120000 lib32/tst_run_cmd.c
 create mode 120000 lib32/tst_safe_macros.c
 create mode 120000 lib32/tst_test.c
 create mode 120000 lib32/tst_tmpdir.c
 create mode 100644 m4/ltp-m32.m4

diff --git a/configure.ac b/configure.ac
index ecc9a26..1013812 100644
--- a/configure.ac
+++ b/configure.ac
@@ -189,5 +189,6 @@ LTP_CHECK_EPOLL_PWAIT
 LTP_CHECK_KEYUTILS_SUPPORT
 LTP_CHECK_SYNC_ADD_AND_FETCH
 LTP_CHECK_BUILTIN_CLEAR_CACHE
+LTP_CHECK_CFLAGS_M32
 
 AC_OUTPUT
diff --git a/include/mk/config.mk.in b/include/mk/config.mk.in
index dde2a9e..c7d5a96 100644
--- a/include/mk/config.mk.in
+++ b/include/mk/config.mk.in
@@ -76,6 +76,8 @@ LDFLAGS			+= $(WLDFLAGS)
 CFLAGS			+= $(DEBUG_CFLAGS) $(OPT_CFLAGS) $(WCFLAGS)
 CXXFLAGS		+= $(DEBUG_CXXFLAGS) $(OPT_CXXFLAGS) $(WCXXFLAGS)
 
+CFLAGS_M32		:= @CFLAGS_M32@
+
 LINUX_VERSION		:= @LINUX_VERSION@
 LINUX_DIR		:= @LINUX_DIR@
 LINUX_VERSION_MAJOR	:= @LINUX_VERSION_MAJOR@
diff --git a/include/mk/env_post.mk b/include/mk/env_post.mk
index 4c57fff..7d92d8a 100644
--- a/include/mk/env_post.mk
+++ b/include/mk/env_post.mk
@@ -35,8 +35,6 @@ vpath %.c $(abs_srcdir)
 # For config.h, et all.
 CPPFLAGS			+= -I$(top_srcdir)/include -I$(top_builddir)/include -I$(top_srcdir)/include/old/
 
-LDFLAGS				+= -L$(top_builddir)/lib
-
 ifeq ($(UCLINUX),1)
 CPPFLAGS			+= -D__UCLIBC__ -DUCLINUX
 endif
@@ -56,6 +54,25 @@ MAKE_TARGETS			:= $(filter-out $(FILTER_OUT_MAKE_TARGETS),$(MAKE_TARGETS))
 
 CLEAN_TARGETS			+= $(MAKE_TARGETS) *.o *.pyc
 
+#
+# We link against lib32 only if:
+# * -m32 wasn't passed in global (configure) CFLAGS
+# * -m32 was passed in target specific CFLAGS
+#
+# The testcases must do:
+#
+# foo: CFLAGS += $(CFLAGS_M32)
+#
+# In order to compile the test in 32bit mode on 64bit arch, which takes care of
+# the situation when -m32 is not supported by compiler, since $(CFLAGS_M32) is
+# empty and we default to linking against (possibly 64bit) lib/ directory.
+#
+ifeq ($(filter -m32,$(CFLAGS)),)
+$(MAKE_TARGETS): LDFLAGS += -L$(top_builddir)/lib$(subst -m,,$(filter -m32,$(CFLAGS)))
+else
+LDFLAGS			 += -L$(top_builddir)/lib
+endif
+
 # Majority of the files end up in testcases/bin...
 INSTALL_DIR			?= testcases/bin
 
diff --git a/include/mk/testcases.mk b/include/mk/testcases.mk
index f453f4e..687c2ec 100644
--- a/include/mk/testcases.mk
+++ b/include/mk/testcases.mk
@@ -30,8 +30,10 @@ TKI_DIR		:= testcases/kernel/include
 LSN_H		:= $(abs_top_builddir)/$(TKI_DIR)/linux_syscall_numbers.h
 
 LIBLTP_DIR	:= $(abs_top_builddir)/lib
+LIBLTP_DIR32	:= $(abs_top_builddir)/lib32
 
 LIBLTP		:= $(LIBLTP_DIR)/libltp.a
+LIBLTP32	:= $(LIBLTP_DIR32)/libltp.a
 
 $(APICMDS_DIR)/tst_kvercmp: $(APICMDS_DIR)
 	$(MAKE) -C "$^" -f "$(abs_top_srcdir)/tools/apicmds/Makefile" all
@@ -39,11 +41,18 @@ $(APICMDS_DIR)/tst_kvercmp: $(APICMDS_DIR)
 $(LIBLTP): $(LIBLTP_DIR)
 	$(MAKE) -C "$^" -f "$(abs_top_srcdir)/lib/Makefile" all
 
+$(LIBLTP32): $(LIBLTP_DIR32)
+	$(MAKE) -C "$^" -f "$(abs_top_srcdir)/lib32/Makefile" all
+
 $(LSN_H): $(abs_top_builddir)/$(TKI_DIR)
 	$(MAKE) -C "$^" -f "$(abs_top_srcdir)/$(TKI_DIR)/Makefile" all
 
 MAKE_DEPS	:= $(LIBLTP) $(LSN_H)
 
+ifneq ($(CFLAGS_M32),)
+MAKE_DEPS	+= $(LIBLTP32)
+endif
+
 # For linux_syscall_numbers.h
 CPPFLAGS	+= -I$(abs_top_builddir)/$(TKI_DIR)
 
diff --git a/include/tst_atomic.h b/include/tst_atomic.h
index 35a3b34..5ee8889 100644
--- a/include/tst_atomic.h
+++ b/include/tst_atomic.h
@@ -20,7 +20,8 @@
 
 #include "config.h"
 
-#if HAVE_SYNC_ADD_AND_FETCH == 1
+#if (!defined(M32) && HAVE_SYNC_ADD_AND_FETCH == 1) \
+    || (defined(M32) && HAVE_SYNC_ADD_AND_FETCH_M32 == 1)
 static inline int tst_atomic_add_return(int i, int *v)
 {
 	return __sync_add_and_fetch(v, i);
diff --git a/lib32/Makefile b/lib32/Makefile
new file mode 100644
index 0000000..72d65e7
--- /dev/null
+++ b/lib32/Makefile
@@ -0,0 +1,53 @@
+#
+# lib32 Makefile.
+#
+# Copyright (C) 2017, Cyril Hrubis <chrubis@suse.cz>
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License along
+# with this program; if not, write to the Free Software Foundation, Inc.,
+# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+
+#
+# We build the 32bit library only if -m32 is supported by the compiler
+# it looks like some 32bit compilers does not support the flag while others
+# do, hence the easiest solution is to build the library if we can.
+#
+top_srcdir		?= ..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+
+ifneq ($(CFLAGS_M32),)
+
+CFLAGS			+= -DLTPLIB -m32 -DM32
+
+ifneq ($(ANDROID),1)
+FILTER_OUT_DIRS		+= android_libpthread android_librt
+else
+FILTER_OUT_LIBSRCS	+= tlibio.c tst_path_has_mnt_flags.c
+endif
+
+LIB			:= libltp.a
+
+include $(top_srcdir)/include/mk/lib.mk
+include $(top_srcdir)/include/mk/generic_trunk_target.mk
+
+else
+
+all:
+
+clean:
+
+install:
+
+endif
diff --git a/lib32/errnos.h b/lib32/errnos.h
new file mode 120000
index 0000000..caff095
--- /dev/null
+++ b/lib32/errnos.h
@@ -0,0 +1 @@
+../lib/errnos.h
\ No newline at end of file
diff --git a/lib32/safe_file_ops.c b/lib32/safe_file_ops.c
new file mode 120000
index 0000000..eeb29a7
--- /dev/null
+++ b/lib32/safe_file_ops.c
@@ -0,0 +1 @@
+../lib/safe_file_ops.c
\ No newline at end of file
diff --git a/lib32/safe_macros.c b/lib32/safe_macros.c
new file mode 120000
index 0000000..832d7ae
--- /dev/null
+++ b/lib32/safe_macros.c
@@ -0,0 +1 @@
+../lib/safe_macros.c
\ No newline at end of file
diff --git a/lib32/safe_net.c b/lib32/safe_net.c
new file mode 120000
index 0000000..c367c2c
--- /dev/null
+++ b/lib32/safe_net.c
@@ -0,0 +1 @@
+../lib/safe_net.c
\ No newline at end of file
diff --git a/lib32/signame.h b/lib32/signame.h
new file mode 120000
index 0000000..f59345b
--- /dev/null
+++ b/lib32/signame.h
@@ -0,0 +1 @@
+../lib/signame.h
\ No newline at end of file
diff --git a/lib32/tst_ansi_color.c b/lib32/tst_ansi_color.c
new file mode 120000
index 0000000..14d8c5d
--- /dev/null
+++ b/lib32/tst_ansi_color.c
@@ -0,0 +1 @@
+../lib/tst_ansi_color.c
\ No newline at end of file
diff --git a/lib32/tst_checkpoint.c b/lib32/tst_checkpoint.c
new file mode 120000
index 0000000..28e332f
--- /dev/null
+++ b/lib32/tst_checkpoint.c
@@ -0,0 +1 @@
+../lib/tst_checkpoint.c
\ No newline at end of file
diff --git a/lib32/tst_device.c b/lib32/tst_device.c
new file mode 120000
index 0000000..f8c7982
--- /dev/null
+++ b/lib32/tst_device.c
@@ -0,0 +1 @@
+../lib/tst_device.c
\ No newline at end of file
diff --git a/lib32/tst_fill_file.c b/lib32/tst_fill_file.c
new file mode 120000
index 0000000..7439f3e
--- /dev/null
+++ b/lib32/tst_fill_file.c
@@ -0,0 +1 @@
+../lib/tst_fill_file.c
\ No newline at end of file
diff --git a/lib32/tst_kvercmp.c b/lib32/tst_kvercmp.c
new file mode 120000
index 0000000..ac15523
--- /dev/null
+++ b/lib32/tst_kvercmp.c
@@ -0,0 +1 @@
+../lib/tst_kvercmp.c
\ No newline at end of file
diff --git a/lib32/tst_mkfs.c b/lib32/tst_mkfs.c
new file mode 120000
index 0000000..a0e0421
--- /dev/null
+++ b/lib32/tst_mkfs.c
@@ -0,0 +1 @@
+../lib/tst_mkfs.c
\ No newline at end of file
diff --git a/lib32/tst_res.c b/lib32/tst_res.c
new file mode 120000
index 0000000..f2083bc
--- /dev/null
+++ b/lib32/tst_res.c
@@ -0,0 +1 @@
+../lib/tst_res.c
\ No newline at end of file
diff --git a/lib32/tst_resource.c b/lib32/tst_resource.c
new file mode 120000
index 0000000..a3c021e
--- /dev/null
+++ b/lib32/tst_resource.c
@@ -0,0 +1 @@
+../lib/tst_resource.c
\ No newline at end of file
diff --git a/lib32/tst_run_cmd.c b/lib32/tst_run_cmd.c
new file mode 120000
index 0000000..d57dbb6
--- /dev/null
+++ b/lib32/tst_run_cmd.c
@@ -0,0 +1 @@
+../lib/tst_run_cmd.c
\ No newline at end of file
diff --git a/lib32/tst_safe_macros.c b/lib32/tst_safe_macros.c
new file mode 120000
index 0000000..a1bf8c5
--- /dev/null
+++ b/lib32/tst_safe_macros.c
@@ -0,0 +1 @@
+../lib/tst_safe_macros.c
\ No newline at end of file
diff --git a/lib32/tst_test.c b/lib32/tst_test.c
new file mode 120000
index 0000000..a82ad7a
--- /dev/null
+++ b/lib32/tst_test.c
@@ -0,0 +1 @@
+../lib/tst_test.c
\ No newline at end of file
diff --git a/lib32/tst_tmpdir.c b/lib32/tst_tmpdir.c
new file mode 120000
index 0000000..a34cf42
--- /dev/null
+++ b/lib32/tst_tmpdir.c
@@ -0,0 +1 @@
+../lib/tst_tmpdir.c
\ No newline at end of file
diff --git a/m4/ltp-m32.m4 b/m4/ltp-m32.m4
new file mode 100644
index 0000000..7234415
--- /dev/null
+++ b/m4/ltp-m32.m4
@@ -0,0 +1,50 @@
+dnl Copyright (c) 2017 Cyril Hrubis <chrubis@suse.cz>
+dnl
+dnl This program is free software; you can redistribute it and/or
+dnl modify it under the terms of the GNU General Public License as
+dnl published by the Free Software Foundation; either version 2 of
+dnl the License, or (at your option) any later version.
+dnl
+dnl This program is distributed in the hope that it would be useful,
+dnl but WITHOUT ANY WARRANTY; without even the implied warranty of
+dnl MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+dnl GNU General Public License for more details.
+dnl
+dnl You should have received a copy of the GNU General Public License
+dnl along with this program; if not, write the Free Software Foundation,
+dnl Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+dnl
+
+AC_DEFUN([LTP_CHECK_CFLAGS_M32],[dnl
+
+flag="-m32"
+AC_MSG_CHECKING([if $CC supports $flag])
+
+backup_cflags="$CFLAGS"
+CFLAGS="$CFLAGS $flag"
+
+AC_LINK_IFELSE(
+	[AC_LANG_PROGRAM([])],
+	[CFLAGS_M32="$flag"]
+	[AC_MSG_RESULT([yes])],
+	[AC_MSG_RESULT([no])]
+)
+
+AC_SUBST(CFLAGS_M32)
+
+AC_MSG_CHECKING([for __sync_add_and_fetch with -m32])
+AC_LINK_IFELSE([AC_LANG_SOURCE([
+int main(void) {
+	int i = 0;
+	return __sync_add_and_fetch(&i, 1);
+}])],[has_saac="yes"])
+
+if test "x$has_saac" = xyes; then
+	AC_DEFINE(HAVE_SYNC_ADD_AND_FETCH_M32,1,[Define to 1 if you have __sync_add_and_fetch with -m32])
+	AC_MSG_RESULT(yes)
+else
+	AC_MSG_RESULT(no)
+fi
+
+CFLAGS="$backup_cflags"
+])
diff --git a/testcases/kernel/syscalls/add_key/Makefile b/testcases/kernel/syscalls/add_key/Makefile
index 2ef86f0..508e502 100644
--- a/testcases/kernel/syscalls/add_key/Makefile
+++ b/testcases/kernel/syscalls/add_key/Makefile
@@ -20,4 +20,6 @@ top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
 
+add_key02: CFLAGS += $(CFLAGS_M32)
+
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
-- 
2.10.2

