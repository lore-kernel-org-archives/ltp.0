Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBD27CA0EE0
	for <ltp@archiver.kernel.org>; Fri, 15 Aug 2025 08:20:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 660323CBED9
	for <ltp@archiver.kernel.org>; Fri, 15 Aug 2025 10:20:36 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6FF8D3C2CC6
 for <ltp@lists.linux.it>; Fri, 15 Aug 2025 10:20:01 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B42636001F4
 for <ltp@lists.linux.it>; Fri, 15 Aug 2025 10:20:00 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A3D2E218E5;
 Fri, 15 Aug 2025 08:19:59 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7443713A8B;
 Fri, 15 Aug 2025 08:19:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wHzBGq/tnmg/GAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 15 Aug 2025 08:19:59 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 15 Aug 2025 10:19:41 +0200
Message-ID: <20250815081942.584153-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250815081942.584153-1-pvorel@suse.cz>
References: <20250815081942.584153-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: A3D2E218E5
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 1/2] Makefile: Add kernel modules related make
 targets
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

LTP contains few kernel modules and tests which are using them.  These
require to be built with the same kernel headers as the running kernel
(SUT). Sometimes the best way to achieve this is to compile them on the
SUT.

Add 'modules', 'modules-clean' and 'modules-install' make targets to
make it easier to build them.

Reviewed-by: Li Wang <liwang@redhat.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 INSTALL  | 10 ++++++++++
 Makefile | 21 +++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/INSTALL b/INSTALL
index cbe27f32ea..10c19d4105 100644
--- a/INSTALL
+++ b/INSTALL
@@ -165,6 +165,16 @@ PKG_CONFIG_LIBDIR=/usr/lib/i386-linux-gnu/pkgconfig CFLAGS=-m32 LDFLAGS=-m32 ./c
 * Arch Linux
 PKG_CONFIG_LIBDIR=/usr/lib32/pkgconfig CFLAGS=-m32 LDFLAGS=-m32 ./configure
 
+Kernel modules
+--------------
+
+LTP contains few kernel modules and tests which are using them.
+These require to be built with the same kernel headers as the running kernel (SUT).
+Sometimes the best way to achieve this is to compile them on the SUT.
+
+'modules', 'modules-clean' and 'modules-install' make targets are shortcuts
+to build just these modules and tests.
+
 Android Users
 -------------
 
diff --git a/Makefile b/Makefile
index eab40da8a6..b2cc77463c 100644
--- a/Makefile
+++ b/Makefile
@@ -212,6 +212,27 @@ endif
 test-metadata: metadata-all
 	$(MAKE) -C $(abs_srcdir)/metadata test
 
+MODULE_DIRS :=  $(shell \
+	dirname $$(grep -l 'include.*module\.mk' $$(find testcases/ -type f -name 'Makefile')))
+
+
+.PHONY: modules modules-clean modules-install
+modules:
+	@$(foreach dir,$(MODULE_DIRS),\
+		echo "Build $(dir)";\
+		$(MAKE) -C $(abs_srcdir)/$(dir) || exit $$?; \
+)
+modules-clean:
+	@$(foreach dir,$(MODULE_DIRS),\
+		echo "Build $(dir)";\
+		$(MAKE) -C $(abs_srcdir)/$(dir) clean || exit $$?; \
+)
+modules-install: modules
+	@$(foreach dir,$(MODULE_DIRS),\
+		echo "Build $(dir)";\
+		$(MAKE) -C $(abs_srcdir)/$(dir) install || exit $$?; \
+)
+
 ## Help
 .PHONY: help
 help:
-- 
2.50.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
