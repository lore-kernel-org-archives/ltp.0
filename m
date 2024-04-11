Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4423BC4345F
	for <ltp@archiver.kernel.org>; Thu, 11 Apr 2024 14:32:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C03483CF840
	for <ltp@archiver.kernel.org>; Thu, 11 Apr 2024 16:32:18 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E79113C0F55
 for <ltp@lists.linux.it>; Thu, 11 Apr 2024 16:30:32 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 4B93F140709B
 for <ltp@lists.linux.it>; Thu, 11 Apr 2024 16:30:32 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D237D375A8;
 Thu, 11 Apr 2024 14:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1712845829; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UtgigCZdzHh9M2adQHM91U0IH/Ef66LmKIuQ5wrzlEc=;
 b=WA5ERPEqwgobHwhbjiaEL7a8uW3Wa2KxrA8pvWBWilVkFu3a5yhrG1u3o2egTrErqmJuLK
 bNHN6wnHe52w5Ry6hzbyflu3GIz6mKG8cw9nM8AhbsEltWN9Tl6TfiwC5GxRWbBMZpUviP
 lBOWRB3cKwopkajbsyQGeUxWOTFSAqQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1712845829;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UtgigCZdzHh9M2adQHM91U0IH/Ef66LmKIuQ5wrzlEc=;
 b=7f0xY5Iuz76nlXK6mh8xEHzNzTq1iq4poAw8404rH5gELJFalGdanr2G9S6Ad7rxCDo+Ek
 BGndHt3J85Ou8ABw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=WA5ERPEq;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=7f0xY5Iu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1712845829; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UtgigCZdzHh9M2adQHM91U0IH/Ef66LmKIuQ5wrzlEc=;
 b=WA5ERPEqwgobHwhbjiaEL7a8uW3Wa2KxrA8pvWBWilVkFu3a5yhrG1u3o2egTrErqmJuLK
 bNHN6wnHe52w5Ry6hzbyflu3GIz6mKG8cw9nM8AhbsEltWN9Tl6TfiwC5GxRWbBMZpUviP
 lBOWRB3cKwopkajbsyQGeUxWOTFSAqQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1712845829;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UtgigCZdzHh9M2adQHM91U0IH/Ef66LmKIuQ5wrzlEc=;
 b=7f0xY5Iuz76nlXK6mh8xEHzNzTq1iq4poAw8404rH5gELJFalGdanr2G9S6Ad7rxCDo+Ek
 BGndHt3J85Ou8ABw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B011913888;
 Thu, 11 Apr 2024 14:30:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0HNvKQX0F2ZZRgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 11 Apr 2024 14:30:29 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 11 Apr 2024 16:29:56 +0200
Message-ID: <20240411143025.352507-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240411143025.352507-1-pvorel@suse.cz>
References: <20240411143025.352507-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-0.99 / 50.00]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; BAYES_HAM(-0.98)[87.00%];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; TO_DN_SOME(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Spamd-Bar: /
X-Rspamd-Queue-Id: D237D375A8
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 02/31] make: Remove WITH_POWER_MANAGEMENT_TESTSUITE
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

It was introduced only for UCLINUX.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 include/mk/features.mk.in | 7 -------
 runtest/Makefile          | 4 ----
 testcases/kernel/Makefile | 5 +----
 3 files changed, 1 insertion(+), 15 deletions(-)

diff --git a/include/mk/features.mk.in b/include/mk/features.mk.in
index 802ee0ba8..c2b64b549 100644
--- a/include/mk/features.mk.in
+++ b/include/mk/features.mk.in
@@ -36,13 +36,6 @@ WITH_METADATA_PDF		:= @WITH_METADATA_PDF@
 
 # Test suite knobs
 
-# Enable testcases/kernel/power_management's compile and install?
-ifeq ($(UCLINUX),1)
-WITH_POWER_MANAGEMENT_TESTSUITE	:= no
-else
-WITH_POWER_MANAGEMENT_TESTSUITE	:= yes
-endif
-
 # Enable testcases/open_posix_testsuite's compile and install?
 WITH_OPEN_POSIX_TESTSUITE	:= @WITH_OPEN_POSIX_TESTSUITE@
 
diff --git a/runtest/Makefile b/runtest/Makefile
index 6a1565b6a..0f95e69fa 100644
--- a/runtest/Makefile
+++ b/runtest/Makefile
@@ -32,10 +32,6 @@ UNWANTED_FILES		:= Makefile CVS STAX
 
 INSTALL_MODE		:= 00644
 
-ifneq ($(WITH_POWER_MANAGEMENT_TESTSUITE),yes)
-UNWANTED_FILES		+= power_management_tests
-endif
-
 INSTALL_TARGETS		:= $(filter-out $(UNWANTED_FILES),$(notdir $(patsubst $(abs_srcdir)/%,%,$(sort $(wildcard $(abs_srcdir)/*)))))
 
 MAKE_TARGETS		:=
diff --git a/testcases/kernel/Makefile b/testcases/kernel/Makefile
index bf890e175..3ca0e74bd 100644
--- a/testcases/kernel/Makefile
+++ b/testcases/kernel/Makefile
@@ -32,6 +32,7 @@ SUBDIRS			+= connectors \
 			   logging \
 			   mem \
 			   numa \
+			   power_management \
 			   pty \
 			   sched \
 			   security \
@@ -40,10 +41,6 @@ SUBDIRS			+= connectors \
 			   uevents \
 			   watchqueue \
 
-ifeq ($(WITH_POWER_MANAGEMENT_TESTSUITE),yes)
-SUBDIRS			+= power_management
-endif
-
 ifeq ($(WITH_KVM_TESTSUITE),yes)
 SUBDIRS			+= kvm
 endif
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
