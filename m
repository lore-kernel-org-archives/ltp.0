From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Thu, 27 Jul 2017 14:42:41 +0200
Subject: [LTP] [PATCH v2 2/2] Remove linux_syscall_numbers.h Makefile
In-Reply-To: <20170727124241.6266-1-rpalethorpe@suse.com>
References: <20170727124241.6266-1-rpalethorpe@suse.com>
Message-ID: <20170727124241.6266-2-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This header is now created during configuration.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 include/lapi/syscalls/Makefile | 35 -----------------------------------
 include/mk/testcases.mk        | 14 ++------------
 testcases/kernel/Makefile      | 11 -----------
 3 files changed, 2 insertions(+), 58 deletions(-)
 delete mode 100644 include/lapi/syscalls/Makefile

diff --git a/include/lapi/syscalls/Makefile b/include/lapi/syscalls/Makefile
deleted file mode 100644
index d6e7175c1..000000000
--- a/include/lapi/syscalls/Makefile
+++ /dev/null
@@ -1,35 +0,0 @@
-#
-#    kernel test suite include Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
-# Ngie Cooper, July 2009
-#
-
-top_srcdir		?= ../../..
-
-include $(top_srcdir)/include/mk/env_pre.mk
-
-INSTALL_DIR		:= $(includedir)
-
-MAKE_TARGETS		:= linux_syscall_numbers.h
-
-linux_syscall_numbers.h: $(abs_srcdir)/regen.sh $(wildcard $(abs_srcdir)/*.in)
-	@touch linux_syscall_numbers.h
-	$(SHELL) "$<"
-
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/include/mk/testcases.mk b/include/mk/testcases.mk
index f453f4e35..bf97384a7 100644
--- a/include/mk/testcases.mk
+++ b/include/mk/testcases.mk
@@ -25,10 +25,6 @@ include $(top_srcdir)/include/mk/functions.mk
 
 APICMDS_DIR	:= $(abs_top_builddir)/tools/apicmds
 
-TKI_DIR		:= testcases/kernel/include
-
-LSN_H		:= $(abs_top_builddir)/$(TKI_DIR)/linux_syscall_numbers.h
-
 LIBLTP_DIR	:= $(abs_top_builddir)/lib
 
 LIBLTP		:= $(LIBLTP_DIR)/libltp.a
@@ -39,17 +35,11 @@ $(APICMDS_DIR)/tst_kvercmp: $(APICMDS_DIR)
 $(LIBLTP): $(LIBLTP_DIR)
 	$(MAKE) -C "$^" -f "$(abs_top_srcdir)/lib/Makefile" all
 
-$(LSN_H): $(abs_top_builddir)/$(TKI_DIR)
-	$(MAKE) -C "$^" -f "$(abs_top_srcdir)/$(TKI_DIR)/Makefile" all
-
-MAKE_DEPS	:= $(LIBLTP) $(LSN_H)
-
-# For linux_syscall_numbers.h
-CPPFLAGS	+= -I$(abs_top_builddir)/$(TKI_DIR)
+MAKE_DEPS	:= $(LIBLTP)
 
 INSTALL_DIR	:= testcases/bin
 
 LDLIBS		+= -lltp
 
-$(APICMDS_DIR) $(LIBLTP_DIR) $(abs_top_builddir)/$(TKI_DIR): %:
+$(APICMDS_DIR) $(LIBLTP_DIR): %:
 	mkdir -p "$@"
diff --git a/testcases/kernel/Makefile b/testcases/kernel/Makefile
index 4dd11296f..11aae96fe 100644
--- a/testcases/kernel/Makefile
+++ b/testcases/kernel/Makefile
@@ -66,15 +66,4 @@ FILTER_OUT_DIRS		+= containers controllers device-drivers fs io ipc mem \
 				sched security timers
 endif
 
-MAKE_DEPS		:= include/linux_syscall_numbers.h
-
-include:
-	mkdir -p "$@"
-
-linux-syscall-numbers-clean:: include
-	$(MAKE) -C $^ -f "$(abs_srcdir)/$^/Makefile" clean
-
-include/linux_syscall_numbers.h: include
-	$(MAKE) -C $^ -f "$(abs_srcdir)/$^/Makefile" all
-
 include $(top_srcdir)/include/mk/generic_trunk_target.mk
-- 
2.13.3

