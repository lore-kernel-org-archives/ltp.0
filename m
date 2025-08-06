Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B47BC87FCB
	for <ltp@archiver.kernel.org>; Wed,  6 Aug 2025 21:15:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1CCB93C85F2
	for <ltp@archiver.kernel.org>; Wed,  6 Aug 2025 23:15:06 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5EBAA3C8A9F
 for <ltp@lists.linux.it>; Wed,  6 Aug 2025 23:14:38 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id BE79A1000479
 for <ltp@lists.linux.it>; Wed,  6 Aug 2025 23:14:37 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3C0F833821;
 Wed,  6 Aug 2025 21:14:29 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F320313AFB;
 Wed,  6 Aug 2025 21:14:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2DujObTFk2jNdgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 06 Aug 2025 21:14:28 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed,  6 Aug 2025 23:14:20 +0200
Message-ID: <20250806211420.445452-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250806211420.445452-1-pvorel@suse.cz>
References: <20250806211420.445452-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 3C0F833821
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 2/2] modules.mk: Add FORCE_MODULES=1 to fail on
 error
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: =?UTF-8?q?Ricardo=20B=20=2E=20Marli=C3=A8re?= <rbm@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Kernel modules deliberately not fail on error due kABI
(Linux Kernel Driver Interface) not being stable [1].

But that also silently hides modules not being build due change
(LTP module needs to be updated) or distro bug.

Introduce FORCE_MODULES=1 variable for make to force fail on error.
This can happen if
* package for building kernel modules is not installed
* LTP kernel module error mentioned above

$ make modules FORCE_MODULES=1
Build testcases/kernel/syscalls/finit_module
 Check that package for building kernel modules for 6.6.15-amd64 is installed and try again.
 * openSUSE/SLES: kernel-default-devel
 * Fedora/RHEL: kernel-devel/kernel-headers
 * Debian/Ubuntu: linux-kbuild
 You can build anyway by omitting FORCE_MODULES=1.  Stop.
...

NOTE: previously added 'modules' make target keeps trying to build all
modules (don't stop on first error).

[1] https://docs.kernel.org/process/stable-api-nonsense.html

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
New in v3

 INSTALL              |  6 ++++++
 include/mk/module.mk | 21 ++++++++++++++++++++-
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/INSTALL b/INSTALL
index 10c19d4105..7c25c23347 100644
--- a/INSTALL
+++ b/INSTALL
@@ -172,9 +172,15 @@ LTP contains few kernel modules and tests which are using them.
 These require to be built with the same kernel headers as the running kernel (SUT).
 Sometimes the best way to achieve this is to compile them on the SUT.
 
+Due Linux Kernel Driver Interface unstability [1], error during building kernel
+modules does not break the build. Make errors fatal can be done by FORCE_MODULES=1
+make variable.
+
 'modules', 'modules-clean' and 'modules-install' make targets are shortcuts
 to build just these modules and tests.
 
+[1] https://docs.kernel.org/process/stable-api-nonsense.html)
+
 Android Users
 -------------
 
diff --git a/include/mk/module.mk b/include/mk/module.mk
index c3cbf9c21f..65054ae502 100644
--- a/include/mk/module.mk
+++ b/include/mk/module.mk
@@ -1,14 +1,22 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
-# Copyright (c) Linux Test Project, 2014-2021
+# Copyright (c) Linux Test Project, 2014-2025
 # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
 #
 # Include it to build kernel modules.
 # REQ_VERSION_MAJOR and REQ_VERSION_PATCH must be defined beforehand.
+#
+# FORCE_MODULES=1: Forcing to fail on error or missing kernel headers (e.g. for CI)).
 
 $(if $(REQ_VERSION_MAJOR),,$(error You must define REQ_VERSION_MAJOR))
 $(if $(REQ_VERSION_PATCH),,$(error You must define REQ_VERSION_PATCH))
 
+define newline
+
+
+endef
+n := $(newline)
+
 ifeq ($(WITH_MODULES),no)
 SKIP := 1
 else
@@ -24,6 +32,15 @@ endif
 
 ifneq ($(SKIP),0)
 MAKE_TARGETS := $(filter-out %.ko, $(MAKE_TARGETS))
+ifeq ($(FORCE_MODULES),1)
+$(error Kernel modules not built!$(n)\
+Check that package for building kernel modules for $(LINUX_VERSION)\
+is installed and try again.$(n)\
+* openSUSE/SLES: kernel-default-devel$(n)\
+* Fedora/RHEL: kernel-devel/kernel-headers$(n)\
+* Debian/Ubuntu: linux-kbuild$(n)\
+You can build anyway by omitting FORCE_MODULES=1)
+endif
 endif
 
 ifneq ($(filter install clean,$(MAKECMDGOALS)),)
@@ -41,7 +58,9 @@ MODULE_SOURCES := $(patsubst %.ko,%.c,$(filter %.ko, $(MAKE_TARGETS)))
 # kernel internal API changes. The user-space test will return TCONF, if it
 # doesn't find the module (i.e. it wasn't built either due to kernel-devel
 # missing or module build failure).
+ifneq ($(FORCE_MODULES),1)
 %.ko: %.c .dep_modules ;
+endif
 
 .dep_modules: $(MODULE_SOURCES)
 	@echo "Building modules: $(MODULE_SOURCES)"
-- 
2.50.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
