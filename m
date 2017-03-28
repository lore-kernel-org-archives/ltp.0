From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 28 Mar 2017 12:01:14 +0200
Subject: [LTP] [RFC] [PATCH] lib32: Add support for linking 32bit programs
	on 64bit
Message-ID: <20170328100114.29730-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This is proof of concept for building 32bit testcases on 64bit platform.

What we do is:

* Configure test if compiler supports -m32
  TODO: Does 32bit compiler accept -m32?
        If so, we should fail the test on 32bit
	platforms by default.

* The directory lib32 contains symlinks of minimal set of sources
  needed to link newlib testcase + Makefile.

* The testcases.mk builds 32bit library as well if
  32bit compiler was installed (-m32 configure test was succesful)

* And finally the env_post.mk switches between lib and lib32 depeding
  on if -m32 was passed in the CFLAGS

TODO: Check if LTP works with -m32 in CFLAGS passed to configure as well

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 configure.ac                               |  1 +
 include/mk/config.mk.in                    |  2 ++
 include/mk/env_post.mk                     |  4 ++++
 include/mk/testcases.mk                    |  9 +++++++
 lib32/Makefile                             | 38 ++++++++++++++++++++++++++++++
 lib32/errnos.h                             |  1 +
 lib32/ltp_priv.h                           |  1 +
 lib32/safe_file_ops.c                      |  1 +
 lib32/safe_macros.c                        |  1 +
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
 m4/ltp-m32.m4                              | 36 ++++++++++++++++++++++++++++
 testcases/kernel/syscalls/add_key/Makefile |  2 ++
 24 files changed, 109 insertions(+)
 create mode 100644 lib32/Makefile
 create mode 120000 lib32/errnos.h
 create mode 120000 lib32/ltp_priv.h
 create mode 120000 lib32/safe_file_ops.c
 create mode 120000 lib32/safe_macros.c
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
index 6b765f0..3c519d3 100644
--- a/configure.ac
+++ b/configure.ac
@@ -190,5 +190,6 @@ LTP_CHECK_EPOLL_PWAIT
 LTP_CHECK_KEYUTILS_SUPPORT
 LTP_CHECK_SYNC_ADD_AND_FETCH
 LTP_CHECK_BUILTIN_CLEAR_CACHE
+LTP_CHECK_CC_M32
 
 AC_OUTPUT
diff --git a/include/mk/config.mk.in b/include/mk/config.mk.in
index dde2a9e..c160211 100644
--- a/include/mk/config.mk.in
+++ b/include/mk/config.mk.in
@@ -76,6 +76,8 @@ LDFLAGS			+= $(WLDFLAGS)
 CFLAGS			+= $(DEBUG_CFLAGS) $(OPT_CFLAGS) $(WCFLAGS)
 CXXFLAGS		+= $(DEBUG_CXXFLAGS) $(OPT_CXXFLAGS) $(WCXXFLAGS)
 
+CC_M32			:= @CC_M32@
+
 LINUX_VERSION		:= @LINUX_VERSION@
 LINUX_DIR		:= @LINUX_DIR@
 LINUX_VERSION_MAJOR	:= @LINUX_VERSION_MAJOR@
diff --git a/include/mk/env_post.mk b/include/mk/env_post.mk
index 4c57fff..fdf13e2 100644
--- a/include/mk/env_post.mk
+++ b/include/mk/env_post.mk
@@ -35,7 +35,11 @@ vpath %.c $(abs_srcdir)
 # For config.h, et all.
 CPPFLAGS			+= -I$(top_srcdir)/include -I$(top_builddir)/include -I$(top_srcdir)/include/old/
 
+ifeq ($(filter -m32,$(CFLAGS)),)
 LDFLAGS				+= -L$(top_builddir)/lib
+else
+LDFLAGS				+= -L$(top_builddir)/lib32
+endif
 
 ifeq ($(UCLINUX),1)
 CPPFLAGS			+= -D__UCLIBC__ -DUCLINUX
diff --git a/include/mk/testcases.mk b/include/mk/testcases.mk
index f453f4e..03446f2 100644
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
 
+ifneq ($(CC_M32),)
+MAKE_DEPS	+= $(LIBLTP32)
+endif
+
 # For linux_syscall_numbers.h
 CPPFLAGS	+= -I$(abs_top_builddir)/$(TKI_DIR)
 
diff --git a/lib32/Makefile b/lib32/Makefile
new file mode 100644
index 0000000..221b71e
--- /dev/null
+++ b/lib32/Makefile
@@ -0,0 +1,38 @@
+#
+#    lib Makefile.
+#
+#    Copyright (C) 2009, Cisco Systems Inc.
+#
+#    This program is free software; you can redistribute it and/or modify
+#    it under the terms of the GNU General Public License as published by
+#    the Free Software Foundation; either version 2 of the License, or
+#    (at your option) any later version.
+#
+#    This program is distributed in the hope that it will be useful,
+#    but WITHOUT ANY WARRANTY; without even the implied warranty of
+#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#    GNU General Public License for more details.
+#
+#    You should have received a copy of the GNU General Public License along
+#    with this program; if not, write to the Free Software Foundation, Inc.,
+#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+# Ngie Cooper, July 2009
+#
+
+top_srcdir		?= ..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+
+CFLAGS			+= -I -DLTPLIB -m32
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
diff --git a/lib32/errnos.h b/lib32/errnos.h
new file mode 120000
index 0000000..caff095
--- /dev/null
+++ b/lib32/errnos.h
@@ -0,0 +1 @@
+../lib/errnos.h
\ No newline at end of file
diff --git a/lib32/ltp_priv.h b/lib32/ltp_priv.h
new file mode 120000
index 0000000..783e267
--- /dev/null
+++ b/lib32/ltp_priv.h
@@ -0,0 +1 @@
+../lib/ltp_priv.h
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
index 0000000..e5b3ff6
--- /dev/null
+++ b/m4/ltp-m32.m4
@@ -0,0 +1,36 @@
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
+AC_DEFUN([LTP_CHECK_CC_M32],[dnl
+
+flag="-m32"
+AC_MSG_CHECKING([if $CC supports $flag])
+
+backup_cflags="$CFLAGS"
+CFLAGS="$CFLAGS $flag"
+
+AC_LINK_IFELSE(
+	[AC_LANG_PROGRAM([])],
+	[CC_M32="$flag"]
+	[AC_MSG_RESULT([yes])],
+	[AC_MSG_RESULT([no])]
+)
+
+AC_SUBST(CC_M32)
+CFLAGS="$backup_cflags"
+
+])
diff --git a/testcases/kernel/syscalls/add_key/Makefile b/testcases/kernel/syscalls/add_key/Makefile
index 2ef86f0..0db5233 100644
--- a/testcases/kernel/syscalls/add_key/Makefile
+++ b/testcases/kernel/syscalls/add_key/Makefile
@@ -20,4 +20,6 @@ top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
 
+CFLAGS += $(CC_M32)
+
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
-- 
2.10.2

