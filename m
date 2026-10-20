Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54897606A31D
	for <ltp@archiver.kernel.org>; Tue, 20 Oct 2026 10:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=fpeh/PXE;
	dkim=fail reason="signature verification failed" header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=oAGASEZS;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=fpeh/PXE;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=oAGASEZS
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0DB3D3EA61B
	for <ltp@archiver.kernel.org>; Tue, 20 Oct 2026 12:52:43 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EB6623EA605
 for <ltp@lists.linux.it>; Tue, 20 Oct 2026 12:52:26 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5B3B66002C9
 for <ltp@lists.linux.it>; Tue, 20 Oct 2026 12:52:26 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8D4041F7A9;
 Tue, 20 Oct 2026 10:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1792493545; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=MM1gRNtjZRcPn6MRPxkeq7IY71Yi3OsEiv3ea80jtZA=;
 b=fpeh/PXEIJf6VEvnvBJ6psmcL/lckVen94DIjiiprYi3PAvhK5AU/9I0Xy+UsbZwOXikmy
 0qasE1YELj98zAXq22LljmREl2jyNTujuaMvw+REh7QHghgy83MFU/eQV6Os0jvB5HmrTM
 /oBpXs65s1Sd+vZSi6wuUkNbw30iI18=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1792493545;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=MM1gRNtjZRcPn6MRPxkeq7IY71Yi3OsEiv3ea80jtZA=;
 b=oAGASEZS8/3kG2vSihCVaffE7bW8vZ7ICxoDb1+XzKBk1/CKq3jddecvIMEigd48wm20Zf
 vWDFVB62k52YvhDA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="fpeh/PXE";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=oAGASEZS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1792493545; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=MM1gRNtjZRcPn6MRPxkeq7IY71Yi3OsEiv3ea80jtZA=;
 b=fpeh/PXEIJf6VEvnvBJ6psmcL/lckVen94DIjiiprYi3PAvhK5AU/9I0Xy+UsbZwOXikmy
 0qasE1YELj98zAXq22LljmREl2jyNTujuaMvw+REh7QHghgy83MFU/eQV6Os0jvB5HmrTM
 /oBpXs65s1Sd+vZSi6wuUkNbw30iI18=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1792493545;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=MM1gRNtjZRcPn6MRPxkeq7IY71Yi3OsEiv3ea80jtZA=;
 b=oAGASEZS8/3kG2vSihCVaffE7bW8vZ7ICxoDb1+XzKBk1/CKq3jddecvIMEigd48wm20Zf
 vWDFVB62k52YvhDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4AE4E136CC;
 Tue, 20 Oct 2026 10:52:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QaIKCOlH12p4WAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 20 Oct 2026 10:52:25 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 20 Oct 2026 12:52:25 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Message-Id: <20261020-build_system_optimize-v1-1-744f9fa88908@suse.com>
X-B4-Tracking: v=1; b=H4sIAOhH12oC/yXMWw6CMBBG4a2QebbJtBhi3IoxBNofHSOXdIpRC
 Xu3yOP3cM5CiihQOhcLRbxEZRwy7KEgf2+GG4yEbHLsKsuOTTvLM9T60YS+HqckvXxhKh+4PJY
 dn2Apt1NEJ+//93LdrXP7gE/bjNb1ByOhtSJ5AAAA
X-Change-ID: 20261020-build_system_optimize-6cd0343f08e1
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792493545; l=5506;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=c4ZdEEMA5gwbSIU1w9ba+WtjmaEHmwFf5JRiYrSUVDw=;
 b=42ApRH1I2psBH3Mq/ih6LkrCoK3YshDu0ccg+GH4Xl4zNXgutQqu81Afeya8GbWgT4nHc6Am2
 hqSYGU24rlCD2DGmnUgB+s/fe89ezF9GflWVOZ7t+0TsD+hxcn4Yyv+
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim, suse.com:email,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
X-Spam-Level: 
X-Rspamd-Queue-Id: 8D4041F7A9
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] build: Parallelize subdirectory recursion in
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
The following results show how this optimization moves compile times
really far from what we have now. With a single threaded build, LTP
would take approximately 12 minutes to compile. With a multi-threaded
build on 16 CPUs, this drops down to ~46 seconds.

time make -j16

Executed in   45.96 secs    fish           external
   usr time  519.11 secs    0.24 millis  519.11 secs
   sys time  167.13 secs    1.08 millis  167.13 secs
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
index f9db7896a..6975507e8 100644
--- a/include/mk/generic_trunk_target.inc
+++ b/include/mk/generic_trunk_target.inc
@@ -83,15 +83,36 @@ ifeq ($(strip $(SUBDIRS)),)
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

---
base-commit: 2ae4cfe69b9010018f2e5df6fa4bbba21810d4f2
change-id: 20261020-build_system_optimize-6cd0343f08e1

Best regards,
--  
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
