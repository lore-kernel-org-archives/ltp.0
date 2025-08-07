Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5500C87FCF
	for <ltp@archiver.kernel.org>; Thu,  7 Aug 2025 06:30:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 725093C9205
	for <ltp@archiver.kernel.org>; Thu,  7 Aug 2025 08:30:18 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B81A13C9205
 for <ltp@lists.linux.it>; Thu,  7 Aug 2025 08:29:49 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 33C2F140007D
 for <ltp@lists.linux.it>; Thu,  7 Aug 2025 08:29:48 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2F2891F804;
 Thu,  7 Aug 2025 06:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1754548184; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OxobGhxsde/JAt586PtgAb+gXh3GUxUm5UfgJyExXFo=;
 b=d968GhJE58UGw9yxUQ6cPG5hUrw9zSjN5G4rHvJ+7QHR7hBTD6qeH5phR7wkdwEJRhQRJ3
 WrmrWu9zsygYoS7vZOguVmEcabQHvAouyWW7Zqm67aXUzID678Gh8VO684pHecEuFLx+3w
 81rsMViN/vtSFnk4vH7Sbe0pVMoqYrI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1754548184;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OxobGhxsde/JAt586PtgAb+gXh3GUxUm5UfgJyExXFo=;
 b=+ocU9LtkEnu1FS8IhN+zMvZ+kVtMiEQJu4Qb67+nqCsfuNjqo03xbC+gMm4C0Qic/C5wLo
 dUD7Dv6w3gas/PAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1754548184; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OxobGhxsde/JAt586PtgAb+gXh3GUxUm5UfgJyExXFo=;
 b=d968GhJE58UGw9yxUQ6cPG5hUrw9zSjN5G4rHvJ+7QHR7hBTD6qeH5phR7wkdwEJRhQRJ3
 WrmrWu9zsygYoS7vZOguVmEcabQHvAouyWW7Zqm67aXUzID678Gh8VO684pHecEuFLx+3w
 81rsMViN/vtSFnk4vH7Sbe0pVMoqYrI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1754548184;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OxobGhxsde/JAt586PtgAb+gXh3GUxUm5UfgJyExXFo=;
 b=+ocU9LtkEnu1FS8IhN+zMvZ+kVtMiEQJu4Qb67+nqCsfuNjqo03xbC+gMm4C0Qic/C5wLo
 dUD7Dv6w3gas/PAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F3AA513969;
 Thu,  7 Aug 2025 06:29:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UEUwOtdHlGjoBAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 07 Aug 2025 06:29:43 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  7 Aug 2025 08:29:41 +0200
Message-ID: <20250807062941.348971-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250807062941.348971-1-pvorel@suse.cz>
References: <20250807062941.348971-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-6.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_CONTAINS_FROM(1.00)[]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_COUNT_TWO(0.00)[2]; FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_FIVE(0.00)[5];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 2/2] modules.mk: Add FORCE_MODULES=1 to fail on
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
Changes v3->v4:
* Fix build on `make modules FORCE_MODULES=1` (Li)

Link to v3:
https://patchwork.ozlabs.org/project/ltp/patch/20250806211420.445452-2-pvorel@suse.cz/

 INSTALL              |  6 ++++++
 include/mk/module.mk | 24 +++++++++++++++++++++++-
 2 files changed, 29 insertions(+), 1 deletion(-)

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
index c3cbf9c21f..3e97f01289 100644
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
@@ -22,8 +30,18 @@ SKIP ?= $(shell \
 endif
 endif
 
+$(info skip: $(SKIP), FORCE_MODULES: $(FORCE_MODULES))
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
@@ -45,6 +63,10 @@ MODULE_SOURCES := $(patsubst %.ko,%.c,$(filter %.ko, $(MAKE_TARGETS)))
 
 .dep_modules: $(MODULE_SOURCES)
 	@echo "Building modules: $(MODULE_SOURCES)"
+ifneq ($(FORCE_MODULES),1)
 	-$(MAKE) -C $(LINUX_DIR) M=$(abs_srcdir)
+else
+	$(MAKE) -C $(LINUX_DIR) M=$(abs_srcdir)
+endif
 	rm -rf *.mod.c *.o *.ko.unsigned modules.order .tmp* .*.ko .*.cmd Module.symvers
 	@touch .dep_modules
-- 
2.50.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
