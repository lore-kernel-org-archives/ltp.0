Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 773A2C25B47
	for <ltp@archiver.kernel.org>; Fri, 27 Oct 2023 17:43:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DF3DB3CCB19
	for <ltp@archiver.kernel.org>; Fri, 27 Oct 2023 19:43:39 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 93A013CACCC
 for <ltp@lists.linux.it>; Fri, 27 Oct 2023 19:43:28 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id EE14C1000D80
 for <ltp@lists.linux.it>; Fri, 27 Oct 2023 19:43:27 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8C5C21FDCD;
 Fri, 27 Oct 2023 17:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1698428606; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=QI8Q3tuTA5njk5aokl8iwOnKr5hwkecJ9iWmML8mYQM=;
 b=sU3iMfAQ0qtpCUW3a6lCymAHjFVcwcWlKZLamx9jR9yqxT1OTPXswu3kKEvUJr8gzdEh+O
 +NiHKE0zjgFlOpbV1QT/KeApxK+C8G92ax7+ICpUvjZYZsXbgEFahEWNVLj9+TSFdh8rKs
 aKeK1+IMC7+OsUm2wWuZFOcLROfM3GY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1698428606;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=QI8Q3tuTA5njk5aokl8iwOnKr5hwkecJ9iWmML8mYQM=;
 b=TM6KeYlOK9mRYdZbJLoSzyDPehwLD8bM7goGCLMhv5hJUZK7hdyGlOkqRTibVT55lM1ufO
 PGtQpy65PsAxbiAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2A7091358C;
 Fri, 27 Oct 2023 17:43:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id rRW9B772O2WLVQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 27 Oct 2023 17:43:26 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 27 Oct 2023 19:43:22 +0200
Message-ID: <20231027174322.710674-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] compat_16.mk: Cleanup INTERMEDIATE object syntax
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
Cc: Stanislav Kholmanskikh <stanislav.kholmanskikh@bell-sw.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Li Wang <liwang@redhat.com>

INTERMEDIATE object syntax is not necessary, thus remove it.

Suggested-by: Li Wang <liwang@redhat.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/syscalls/utils/compat_16.mk | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/testcases/kernel/syscalls/utils/compat_16.mk b/testcases/kernel/syscalls/utils/compat_16.mk
index 71a8cc56f..8effa2b05 100644
--- a/testcases/kernel/syscalls/utils/compat_16.mk
+++ b/testcases/kernel/syscalls/utils/compat_16.mk
@@ -53,11 +53,8 @@ CPPFLAGS		+= -I$(abs_srcdir) -I$(abs_srcdir)/../utils
 SRCS			?= $(sort $(wildcard $(abs_srcdir)/*.c))
 
 MAKE_TARGETS		:= $(notdir $(patsubst %.c,%,$(SRCS)))
-MAKE_TARGETS_OBJS_WO_COMPAT_16	:= $(addsuffix .o,$(MAKE_TARGETS))
 MAKE_TARGETS		+= $(addsuffix _16,$(MAKE_TARGETS))
 
-# XXX (garrcoop): This code should be put in question as it cannot be applied
-# (no .h file, no TST_USE_NEWER64_SYSCALL def).
 DEF_16			:= TST_USE_COMPAT16_SYSCALL
 
 ifeq ($(USE_LEGACY_COMPAT_16_H),1)
@@ -66,13 +63,5 @@ else
 COMPAT_16_H     := $(abs_srcdir)/../utils/compat_tst_16.h
 endif
 
-ifneq ($(wildcard $(COMPAT_16_H)),)
-$(MAKE_TARGETS_OBJS_WO_COMPAT_16): $(COMPAT_16_H)
-.INTERMEDIATE: $(MAKE_TARGETS_OBJS_WO_COMPAT_16)
-endif
-
-%_16: CPPFLAGS += -D$(DEF_16)=1
-# XXX (garrcoop): End section of code in question..
-
 %_16.o: %.c $(COMPAT_16_H)
 	$(COMPILE.c) $(OUTPUT_OPTION) $<
-- 
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
