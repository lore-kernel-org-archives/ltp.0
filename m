Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8014C606A31E
	for <ltp@archiver.kernel.org>; Tue, 24 Nov 2026 09:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=FEeuD9r/
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3BE0C3E9EC9
	for <ltp@archiver.kernel.org>; Tue, 24 Nov 2026 10:07:43 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 84D8B3E9EC5
 for <ltp@lists.linux.it>; Tue, 24 Nov 2026 10:07:02 +0100 (CET)
Received: from mta0.migadu.com (out-231.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::e7])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 2A71F1A008B0
 for <ltp@lists.linux.it>; Tue, 24 Nov 2026 10:06:59 +0100 (CET)
X-Envelope-To: ltp@lists.linux.it
DKIM-Signature: a=rsa-sha256; bh=R7aumS5gFPVPZk3TtLR9db9WS7J6zZojogX8g2uzi6A=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795511217; v=1; x=1796116017;
 b=FEeuD9r//94GequAn2Hp7fVklaGVEffhYh/jlo2nS6EWDThrJwtinYJZDLvte6JOJtVVbjXp
 4iXYuL8L1Ebne7wHlTLyWEggFsRJb0NEd9CZHjm/O1YYc3N8SKcYwDdYapevxnYULtuRvzspNFN
 Wk3tQpIqhJfY3OVt7GEpI+aA=
X-Envelope-To: ltp@lists.linux.it
Received: by mta12.migadu.com with ESMTPS id 684c18f9f4977665;
 Tue, 24 Nov 2026 09:06:57 +0000
X-Mizu-Trace-ID: 684c18f9f4977665
X-Migadu-Flow: FLOW_OUT
From: "Li Wang (Hieco)" <li.wang@linux.dev>
To: ltp@lists.linux.it
Date: Tue, 24 Nov 2026 17:06:33 +0800
Message-ID: <20261124090633.840656-4-li.wang@linux.dev>
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
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 3/3] build: Recurse into trunk subdirectories in
 parallel
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

Currently, generic_trunk_target traverses $(SUBDIRS) using a serial shell
'for' loop. This serializes directory traversal and prevents 'make -jN'
from building sibling directories in parallel.

Replace the shell loop with target-based recursion:

1. Map each subdirectory to phony targets <dir>-all, <dir>-install and
   <dir>-check, implemented as static pattern rules using $* as the
   directory name.
2. Make 'all', 'install' and 'check' depend on these targets so GNU Make
   can dispatch sibling directories concurrently across available job
   slots.
3. Keep $(MAKE) literal in the recipes so that sub-makes keep access to
   the jobserver and 'make -n' still recurses.
4. Keep $(MAKE_DEPS) as order-only prerequisite. Together with the
   previous patch, libltp.a and libs/ are built exactly once at the
   top-level make invocation before any subdirectory is entered, so
   parallel leaves never race on the library build.
5. Add explicit ordering where a subdirectory produces a library used by
   its siblings (tools before testcases, kernel/lib before the other
   kernel subdirectories, rpc-tirpc before basic_tests), guarded against
   the directories being filtered out.

This cuts full build time by over 20% on multi-core systems.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
Signed-off-by: Li Wang (Hieco) <li.wang@linux.dev>
---
 Makefile                            |  2 ++
 include/mk/generic_trunk_target.inc | 32 ++++++++++++++++++++++-------
 testcases/kernel/Makefile           |  6 ++++++
 testcases/network/rpc/Makefile      |  5 +++++
 4 files changed, 38 insertions(+), 7 deletions(-)

diff --git a/Makefile b/Makefile
index 2efbe8c6c..0abb5c6b4 100644
--- a/Makefile
+++ b/Makefile
@@ -63,6 +63,8 @@ CHECK_TARGETS		:= $(addsuffix -check,testcases lib)
 all: $(addsuffix -all,$(COMMON_TARGETS)) Version
 
 $(MAKE_TARGETS): lib-all libs-all
+# tools contains apicmds/tst_kvercmp required by some testcases
+testcases-all: tools-all
 
 .PHONY: include-all include-install
 include-install: $(top_builddir)/include/config.h include/mk/config.mk include-all
diff --git a/include/mk/generic_trunk_target.inc b/include/mk/generic_trunk_target.inc
index 4186ee9d9..4c86fe1ec 100644
--- a/include/mk/generic_trunk_target.inc
+++ b/include/mk/generic_trunk_target.inc
@@ -91,16 +91,34 @@ ifeq ($(strip $(SUBDIRS)),)
 	$(warning CURDIR is: $(CURDIR))
 	$(error SUBDIRS empty -- did you want generic_leaf_target instead?)
 else
-$(RECURSIVE_TARGETS): %: | $(SUBDIRS)
 ifdef VERBOSE
-	@set -e; for dir in $(SUBDIRS); do \
-	    $(MAKE) -C $$dir -f "$(abs_srcdir)/$$dir/Makefile" $@; \
-	done
+TRUNK_Q		:=
+SUBMAKE_OPTS	:=
 else
-	@set -e; for dir in $(SUBDIRS); do \
-	    $(MAKE) --no-print-directory -C $$dir -f "$(abs_srcdir)/$$dir/Makefile" $@; \
-	done
+TRUNK_Q		:= @
+SUBMAKE_OPTS	:= --no-print-directory
 endif
+
+# Recurse into subdirectories via per-directory phony targets
+# (<dir>-all, <dir>-install, <dir>-check) so that GNU Make can build
+# sibling directories in parallel under -jN. $(MAKE) must appear
+# literally in the recipes so that sub-makes join the jobserver.
+all:     $(addsuffix -all,$(SUBDIRS))
+install: $(addsuffix -install,$(SUBDIRS))
+check:   $(addsuffix -check,$(SUBDIRS))
+
+.PHONY: $(addsuffix -all,$(SUBDIRS)) \
+	$(addsuffix -install,$(SUBDIRS)) \
+	$(addsuffix -check,$(SUBDIRS))
+
+$(addsuffix -all,$(SUBDIRS)): %-all: trunk-all | $(SUBDIRS) $(MAKE_DEPS)
+	$(TRUNK_Q)$(MAKE) $(SUBMAKE_OPTS) -C "$*" -f "$(abs_srcdir)/$*/Makefile" all
+
+$(addsuffix -install,$(SUBDIRS)): %-install: trunk-install | $(SUBDIRS) $(MAKE_DEPS)
+	$(TRUNK_Q)$(MAKE) $(SUBMAKE_OPTS) -C "$*" -f "$(abs_srcdir)/$*/Makefile" install
+
+$(addsuffix -check,$(SUBDIRS)): %-check: trunk-check | $(SUBDIRS) $(MAKE_DEPS)
+	$(TRUNK_Q)$(MAKE) $(SUBMAKE_OPTS) -C "$*" -f "$(abs_srcdir)/$*/Makefile" check
 endif
 
 check: trunk-check
diff --git a/testcases/kernel/Makefile b/testcases/kernel/Makefile
index 29e26742d..90615fbb4 100644
--- a/testcases/kernel/Makefile
+++ b/testcases/kernel/Makefile
@@ -54,3 +54,9 @@ FILTER_OUT_DIRS		+= containers controllers device-drivers fs io ipc mem \
 endif
 
 include $(top_srcdir)/include/mk/generic_trunk_target.mk
+
+# libkerntest.a in lib/ must be built before its consumers
+ifneq ($(filter lib,$(SUBDIRS)),)
+KERNTEST_USERS	:= $(filter-out lib,$(SUBDIRS))
+$(addsuffix -all,$(KERNTEST_USERS)) $(addsuffix -install,$(KERNTEST_USERS)): lib-all
+endif
diff --git a/testcases/network/rpc/Makefile b/testcases/network/rpc/Makefile
index 6ecb1a665..d5ed5814c 100644
--- a/testcases/network/rpc/Makefile
+++ b/testcases/network/rpc/Makefile
@@ -9,3 +9,8 @@ include $(top_srcdir)/include/mk/env_pre.mk
 INSTALL_TARGETS		:= *.sh
 
 include $(top_srcdir)/include/mk/generic_trunk_target.mk
+
+# librpc-tirpc.a in rpc-tirpc/ must be built before basic_tests
+ifneq ($(filter rpc-tirpc,$(SUBDIRS)),)
+basic_tests-all basic_tests-install: rpc-tirpc-all
+endif
-- 
2.56.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
