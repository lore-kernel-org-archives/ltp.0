Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE95606A31B
	for <ltp@archiver.kernel.org>; Tue, 20 Oct 2026 16:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=VzOU+gmI;
	dkim=fail reason="signature verification failed" header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=3mMoo8jE;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=VzOU+gmI;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=3mMoo8jE
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C799A3E9AC4
	for <ltp@archiver.kernel.org>; Tue, 20 Oct 2026 18:43:34 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C88AB3E28E7
 for <ltp@lists.linux.it>; Tue, 20 Oct 2026 18:42:48 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 48B8160013E
 for <ltp@lists.linux.it>; Tue, 20 Oct 2026 18:42:48 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B5ED321D46;
 Tue, 20 Oct 2026 16:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1792514567; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QNu/iGNKCpixhATAau+ZuL5exueGx9SfpUoaGFMW05I=;
 b=VzOU+gmIyXEfpn7RTjDiJuwEY2B50keehiIYIPfEy6O6RdeqKYzUWRIXy0N4p+EBfbwYcI
 WWA3P7VEXd07nyE9XNclhjhncQiE7hHboix+vvqH1E7mKJioUUxypClRq7au87X7k+G1Mb
 /n2t9pho1nA3OUaViwnLrA3tCM/EUz8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1792514567;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QNu/iGNKCpixhATAau+ZuL5exueGx9SfpUoaGFMW05I=;
 b=3mMoo8jE4Ys89NHO0MMF1B0M3XcsK+z2SxcqKnMKeoxsDz9Za07YPKNShs8ACIhS6kJ6/w
 NwB19h7L9AeBrVDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1792514567; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QNu/iGNKCpixhATAau+ZuL5exueGx9SfpUoaGFMW05I=;
 b=VzOU+gmIyXEfpn7RTjDiJuwEY2B50keehiIYIPfEy6O6RdeqKYzUWRIXy0N4p+EBfbwYcI
 WWA3P7VEXd07nyE9XNclhjhncQiE7hHboix+vvqH1E7mKJioUUxypClRq7au87X7k+G1Mb
 /n2t9pho1nA3OUaViwnLrA3tCM/EUz8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1792514567;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QNu/iGNKCpixhATAau+ZuL5exueGx9SfpUoaGFMW05I=;
 b=3mMoo8jE4Ys89NHO0MMF1B0M3XcsK+z2SxcqKnMKeoxsDz9Za07YPKNShs8ACIhS6kJ6/w
 NwB19h7L9AeBrVDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 30F88136CC;
 Tue, 20 Oct 2026 16:42:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id fMmFGwWa12r7TgAAD6G6ig:T4
 (envelope-from <andrea.cervesato@suse.de>); Tue, 20 Oct 2026 16:42:47 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 20 Oct 2026 18:42:46 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Message-Id: <20261020-build_system_optimize-v2-3-b527ac7cf835@suse.com>
References: <20261020-build_system_optimize-v2-0-b527ac7cf835@suse.com>
In-Reply-To: <20261020-build_system_optimize-v2-0-b527ac7cf835@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792514565; l=4889;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=2SvMprzgJ8QrzlpMpwdxd8fCBJWJTE1H2oYKa5uvRew=;
 b=DDYD0ExqESKGL4mdWzhCxfO2Jc0FQ/UH6aihpW2u64I1fekT386/Ka/zoZBxkwhxhK3APPjxB
 iFF1ybeo+YxD3kx3rNqBae+tNfHtORI1gZ06AJM2a1EXzsS1Azx6YAS
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCPT_COUNT_THREE(0.00)[3]
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 3/3] build: Parallelize subdirectory recursion in
 generic_trunk_target
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

From: Andrea Cervesato <andrea.cervesato@mailbox.org>

Currently, generic_trunk_target traverses $(SUBDIRS) using a serial shell
'for' loop. This serializes directory traversal and prevents 'make -jN'
from building sibling directories in parallel.

Replace the shell loop with target-based recursion:
1. Map each subdirectory to a phony target: <dir>-all, <dir>-install,
   and <dir>-check.
2. Make 'all', 'install', and 'check' depend on these targets so GNU Make
   can dispatch them concurrently across available job slots.
3. In each recipe, strip the suffix with $(patsubst %-<action>,%,$@) to
   extract the directory name and invoke $(MAKE) -C <dir>.
4. Add explicit ordering dependencies where subdirectories produce
   libraries required by sibling directories (tools before testcases,
   kernel/lib before syscalls and mem, rpc-tirpc before basic_tests).

This cuts full build time by over 20% on multi-core systems.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 Makefile                            |  2 ++
 include/mk/generic_trunk_target.inc | 35 ++++++++++++++++++++++++++++-------
 testcases/kernel/Makefile           |  3 +++
 testcases/network/rpc/Makefile      |  3 +++
 4 files changed, 36 insertions(+), 7 deletions(-)

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
index eff7fa33c..1b91166ff 100644
--- a/include/mk/generic_trunk_target.inc
+++ b/include/mk/generic_trunk_target.inc
@@ -106,15 +106,36 @@ ifeq ($(strip $(SUBDIRS)),)
 	$(warning CURDIR is: $(CURDIR))
 	$(error SUBDIRS empty -- did you want generic_leaf_target instead?)
 else
-$(RECURSIVE_TARGETS): %: | $(SUBDIRS)
+# Recurse into subdirectories in parallel instead of using a serial shell loop.
+# Each subdirectory is mapped to a phony target (<dir>-all, <dir>-install, etc.).
+# GNU Make can then schedule sibling directories concurrently under -jN.
+all:     $(addsuffix -all,$(SUBDIRS))
+install: $(addsuffix -install,$(SUBDIRS))
+check:   $(addsuffix -check,$(SUBDIRS))
+
+.PHONY: $(addsuffix -all,$(SUBDIRS)) $(addsuffix -install,$(SUBDIRS)) $(addsuffix -check,$(SUBDIRS))
+
+# For each target (e.g. 'open-all'), strip the suffix to get the directory name,
+# build trunk-local targets first, and ensure the subdirectory exists.
+$(addsuffix -all,$(SUBDIRS)): trunk-all | $(SUBDIRS) $(MAKE_DEPS)
 ifdef VERBOSE
-	@set -e; for dir in $(SUBDIRS); do \
-	    $(MAKE) -C $$dir -f "$(abs_srcdir)/$$dir/Makefile" $@; \
-	done
+	$(MAKE) -C "$(patsubst %-all,%,$@)" -f "$(abs_srcdir)/$(patsubst %-all,%,$@)/Makefile" all
 else
-	@set -e; for dir in $(SUBDIRS); do \
-	    $(MAKE) --no-print-directory -C $$dir -f "$(abs_srcdir)/$$dir/Makefile" $@; \
-	done
+	@$(MAKE) --no-print-directory -C "$(patsubst %-all,%,$@)" -f "$(abs_srcdir)/$(patsubst %-all,%,$@)/Makefile" all
+endif
+
+$(addsuffix -install,$(SUBDIRS)): trunk-install | $(SUBDIRS) $(MAKE_DEPS)
+ifdef VERBOSE
+	$(MAKE) -C "$(patsubst %-install,%,$@)" -f "$(abs_srcdir)/$(patsubst %-install,%,$@)/Makefile" install
+else
+	@$(MAKE) --no-print-directory -C "$(patsubst %-install,%,$@)" -f "$(abs_srcdir)/$(patsubst %-install,%,$@)/Makefile" install
+endif
+
+$(addsuffix -check,$(SUBDIRS)): trunk-check | $(SUBDIRS) $(MAKE_DEPS)
+ifdef VERBOSE
+	$(MAKE) -C "$(patsubst %-check,%,$@)" -f "$(abs_srcdir)/$(patsubst %-check,%,$@)/Makefile" check
+else
+	@$(MAKE) --no-print-directory -C "$(patsubst %-check,%,$@)" -f "$(abs_srcdir)/$(patsubst %-check,%,$@)/Makefile" check
 endif
 endif
 
diff --git a/testcases/kernel/Makefile b/testcases/kernel/Makefile
index 29e26742d..3bf5e433e 100644
--- a/testcases/kernel/Makefile
+++ b/testcases/kernel/Makefile
@@ -54,3 +54,6 @@ FILTER_OUT_DIRS		+= containers controllers device-drivers fs io ipc mem \
 endif
 
 include $(top_srcdir)/include/mk/generic_trunk_target.mk
+
+# libkerntest.a in lib/ must be built before syscalls and mem consumers
+syscalls-all mem-all: lib-all
diff --git a/testcases/network/rpc/Makefile b/testcases/network/rpc/Makefile
index 6ecb1a665..8d12bdf1e 100644
--- a/testcases/network/rpc/Makefile
+++ b/testcases/network/rpc/Makefile
@@ -9,3 +9,6 @@ include $(top_srcdir)/include/mk/env_pre.mk
 INSTALL_TARGETS		:= *.sh
 
 include $(top_srcdir)/include/mk/generic_trunk_target.mk
+
+# librpc-tirpc.a in rpc-tirpc/ must be built before basic_tests
+basic_tests-all: rpc-tirpc-all

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
