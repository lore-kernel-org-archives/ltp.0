Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF98606A321
	for <ltp@archiver.kernel.org>; Tue, 24 Nov 2026 09:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=oC7MowRl
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AED883E9ECA
	for <ltp@archiver.kernel.org>; Tue, 24 Nov 2026 10:07:30 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 52B663E9197
 for <ltp@lists.linux.it>; Tue, 24 Nov 2026 10:06:53 +0100 (CET)
Received: from mta1.migadu.com (out-30.mta1.migadu.com [95.215.58.30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 4E92D60084F
 for <ltp@lists.linux.it>; Tue, 24 Nov 2026 10:06:52 +0100 (CET)
X-Envelope-To: ltp@lists.linux.it
DKIM-Signature: a=rsa-sha256; bh=Foj2VwTs5tKXi8Vj0Pd6mcZXsPITeJx5tCp0JB1x0uk=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795511211; v=1; x=1796116011;
 b=oC7MowRlejg1RDpjMHaJxf+hRBlnaawveRPJIIDRl2BC+GgZ2I45GNV8Sr2mtjodCo1BO+6C
 uVg9Wssjt9OxYsZQeSh3r/f6HigfQ/TufrL4vY91lQjTqUokPVOu9PAJ6F2iIZTtZ6tfbAfczG5
 p6IiNl5sUqzlPbBwPKUO+zoQ=
X-Envelope-To: ltp@lists.linux.it
Received: by mta12.migadu.com with ESMTPS id 159b9e1623b9961e;
 Tue, 24 Nov 2026 09:06:51 +0000
X-Mizu-Trace-ID: 159b9e1623b9961e
X-Migadu-Flow: FLOW_OUT
From: "Li Wang (Hieco)" <li.wang@linux.dev>
To: ltp@lists.linux.it
Date: Tue, 24 Nov 2026 17:06:32 +0800
Message-ID: <20261124090633.840656-3-li.wang@linux.dev>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261124090633.840656-1-li.wang@linux.dev>
References: <20261124090633.840656-1-li.wang@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 2/3] build: Build shared libraries once when make
 runs in testcases/
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Andrea Cervesato <andrea.cervesato@suse.com>

Running make directly under testcases/ (for example
"make -C testcases/kernel/syscalls -j8") can start many sub-makes in
parallel. Each leaf can then reach the $(LIBLTP) rule in
testcases.mk and call "$(MAKE) -C lib" at the same time. This builds
the same library more than once, and parallel builds can race on
libltp.a. libkerntest.a and the libs/ libraries have the same
problem.

Add include/mk/generic_lib_deps.inc and include it from both the
generic leaf and trunk targets. When make is started inside
testcases/ (MAKELEVEL == 0), the file adds libltp.a, the libs/
libraries and, for testcases/ and testcases/kernel/*, libkerntest.a
to MAKE_DEPS. Leaf targets and trunk subdirectories depend on
MAKE_DEPS as order-only prerequisites. As a result, the libraries
are built once, in the top-level make process, before any
subdirectory is entered.

The library targets are .PHONY, so lib/, libs/ and
testcases/kernel/lib/ are always entered and their own Makefiles
decide what to rebuild. A change to the library sources is therefore
picked up. Because the prerequisites are order-only, tests that are
already linked are not relinked.

Remove the old $(LIBLTP) rule and "MAKE_DEPS := $(LIBLTP)" from
include/mk/testcases.mk, which the new file replaces. Builds started
from the top-level directory are not affected.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
Signed-off-by: Li Wang (Hieco) <li.wang@linux.dev>
---
 include/mk/generic_leaf_target.inc  |  2 ++
 include/mk/generic_lib_deps.inc     | 34 +++++++++++++++++++++++++++++
 include/mk/generic_trunk_target.inc |  8 +++++++
 include/mk/testcases.mk             |  5 +----
 testcases/kernel/include/lib.mk     |  2 ++
 5 files changed, 47 insertions(+), 4 deletions(-)
 create mode 100644 include/mk/generic_lib_deps.inc

diff --git a/include/mk/generic_leaf_target.inc b/include/mk/generic_leaf_target.inc
index 7c685fea7..533381b9f 100644
--- a/include/mk/generic_leaf_target.inc
+++ b/include/mk/generic_leaf_target.inc
@@ -76,6 +76,8 @@
 # INSTALL_DIR			:= $(libdir)
 #
 
+include $(top_srcdir)/include/mk/generic_lib_deps.inc
+
 .PHONY: all clean install check
 
 ifneq ($(strip $(MAKE_TARGETS)),)
diff --git a/include/mk/generic_lib_deps.inc b/include/mk/generic_lib_deps.inc
new file mode 100644
index 000000000..666b3f9ef
--- /dev/null
+++ b/include/mk/generic_lib_deps.inc
@@ -0,0 +1,34 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) Linux Test Project, 2026
+
+ifeq ($(MAKELEVEL),0)
+
+ifneq ($(filter $(abs_top_builddir)/testcases%,$(CURDIR)),)
+
+MAKE_DEPS += $(abs_top_builddir)/lib/libltp.a
+MAKE_DEPS += $(abs_top_builddir)/libs-all
+
+.PHONY: $(abs_top_builddir)/lib/libltp.a
+$(abs_top_builddir)/lib/libltp.a:
+	mkdir -m 00755 -p "$(@D)"
+	$(MAKE) -C "$(@D)" -f "$(abs_top_srcdir)/lib/Makefile" all
+
+.PHONY: $(abs_top_builddir)/libs-all
+$(abs_top_builddir)/libs-all: $(LTPLIBS_FILES) | $(abs_top_builddir)/lib/libltp.a
+	mkdir -m 00755 -p "$(abs_top_builddir)/libs"
+	$(MAKE) -C "$(abs_top_builddir)/libs" -f "$(abs_top_srcdir)/libs/Makefile" all
+
+endif
+
+ifneq ($(filter $(abs_top_builddir)/testcases $(abs_top_builddir)/testcases/kernel%,$(filter-out $(abs_top_builddir)/testcases/kernel/lib,$(CURDIR))),)
+
+MAKE_DEPS += $(abs_top_builddir)/testcases/kernel/lib/libkerntest.a
+
+.PHONY: $(abs_top_builddir)/testcases/kernel/lib/libkerntest.a
+$(abs_top_builddir)/testcases/kernel/lib/libkerntest.a: | $(abs_top_builddir)/lib/libltp.a
+	mkdir -m 00755 -p "$(@D)"
+	$(MAKE) -C "$(@D)" -f "$(abs_top_srcdir)/testcases/kernel/lib/Makefile" all
+
+endif
+
+endif
diff --git a/include/mk/generic_trunk_target.inc b/include/mk/generic_trunk_target.inc
index f9db7896a..4186ee9d9 100644
--- a/include/mk/generic_trunk_target.inc
+++ b/include/mk/generic_trunk_target.inc
@@ -36,6 +36,8 @@ RECURSIVE_TARGETS		?= all install check
 
 $(eval $(get_make_dirs))
 
+include $(top_srcdir)/include/mk/generic_lib_deps.inc
+
 .PHONY: $(RECURSIVE_TARGETS) $(addprefix trunk-,$(RECURSIVE_TARGETS))
 
 $(SUBDIRS): %:
@@ -78,6 +80,12 @@ endif
 
 install: trunk-install
 
+ifneq ($(strip $(MAKE_DEPS)),)
+ifneq ($(strip $(filter all install,$(RECURSIVE_TARGETS))),)
+$(filter all install,$(RECURSIVE_TARGETS)): | $(MAKE_DEPS)
+endif
+endif
+
 # Print out CURDIR to check for a recursion issue.
 ifeq ($(strip $(SUBDIRS)),)
 	$(warning CURDIR is: $(CURDIR))
diff --git a/include/mk/testcases.mk b/include/mk/testcases.mk
index 5960d7485..f9ff93928 100644
--- a/include/mk/testcases.mk
+++ b/include/mk/testcases.mk
@@ -15,10 +15,7 @@ LIBLTP		:= $(LIBLTP_DIR)/libltp.a
 $(APICMDS_DIR)/tst_kvercmp: | $(APICMDS_DIR)
 	$(MAKE) -C "$(APICMDS_DIR)" -f "$(abs_top_srcdir)/tools/apicmds/Makefile" all
 
-$(LIBLTP): | $(LIBLTP_DIR)
-	$(MAKE) -C "$(LIBLTP_DIR)" -f "$(abs_top_srcdir)/lib/Makefile" all
-
-MAKE_DEPS	:= $(LIBLTP)
+MAKE_DEPS	:=
 
 INSTALL_DIR	:= testcases/bin
 
diff --git a/testcases/kernel/include/lib.mk b/testcases/kernel/include/lib.mk
index c1a0c6d52..8f1ec5313 100644
--- a/testcases/kernel/include/lib.mk
+++ b/testcases/kernel/include/lib.mk
@@ -29,8 +29,10 @@ LDFLAGS			+= -L$(LIBKERNTEST_DIR)
 $(LIBKERNTEST_DIR):
 	mkdir -p "$@"
 
+ifneq ($(MAKELEVEL),0)
 $(LIBKERNTEST): | $(LIBKERNTEST_DIR)
 	$(MAKE) -C "$(LIBKERNTEST_DIR)" -f "$(LIBKERNTEST_SRCDIR)/Makefile" all
+endif
 
 MAKE_DEPS		+= $(LIBKERNTEST)
 
-- 
2.56.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
