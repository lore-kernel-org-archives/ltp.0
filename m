Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33F59C87FCB
	for <ltp@archiver.kernel.org>; Fri,  1 Aug 2025 09:42:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 086823CCEDB
	for <ltp@archiver.kernel.org>; Fri,  1 Aug 2025 11:42:29 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0A6ED3CCA2C
 for <ltp@lists.linux.it>; Fri,  1 Aug 2025 11:42:12 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 0FDA8100054B
 for <ltp@lists.linux.it>; Fri,  1 Aug 2025 11:42:11 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6C96421BC3;
 Fri,  1 Aug 2025 09:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1754041330; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ePgTKieRRHhX/gso9ji8GnWWQFLhTjmcuqyAVmepKyI=;
 b=YKWVS9WgdVoISdOdUY/ruUNTlyqsysEeT0ggxMrRAh7qY5ZY08BQ77aREUc1Vu+zCknlib
 x3Hdz5wv1KuDB82o38EVNpPJAf+Xu5ibaXpDURElGsp9xW85Fqls99AwrSBrDkuWdfeFj/
 SlejXOd2OqEKNqKTSqouDqjIgmffq3w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1754041330;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ePgTKieRRHhX/gso9ji8GnWWQFLhTjmcuqyAVmepKyI=;
 b=85BmWfgtKxKo7eeuXq5HEiYUhb3a8jRVP7j+Hriuw52a7rJhDxz0fz9xl2/bDgBpbj8Ec2
 O/Wjrkwao3pFVZDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1754041330; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ePgTKieRRHhX/gso9ji8GnWWQFLhTjmcuqyAVmepKyI=;
 b=YKWVS9WgdVoISdOdUY/ruUNTlyqsysEeT0ggxMrRAh7qY5ZY08BQ77aREUc1Vu+zCknlib
 x3Hdz5wv1KuDB82o38EVNpPJAf+Xu5ibaXpDURElGsp9xW85Fqls99AwrSBrDkuWdfeFj/
 SlejXOd2OqEKNqKTSqouDqjIgmffq3w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1754041330;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ePgTKieRRHhX/gso9ji8GnWWQFLhTjmcuqyAVmepKyI=;
 b=85BmWfgtKxKo7eeuXq5HEiYUhb3a8jRVP7j+Hriuw52a7rJhDxz0fz9xl2/bDgBpbj8Ec2
 O/Wjrkwao3pFVZDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 346E4138A5;
 Fri,  1 Aug 2025 09:42:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id WO9VC/KLjGiiPgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 01 Aug 2025 09:42:10 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri,  1 Aug 2025 11:42:05 +0200
Message-ID: <20250801094205.965645-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[]; ARC_NA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] Makefile: Add make 'modules' target
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

LTP contains few kernel modules and tests which are using them.  These
require to be built with the same kernel headers as the running kernel
(SUT). Sometimes the best way to achieve this is to compile them on the
SUT. Add make 'modules' target to make it easier to build them.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi all,

We build these modules in openQA during testing.  Hope you don't mind to
keep the list of directories with kernel modules in LTP (instead of
maintaining it outside). And hopefully it helps others which might face
the same problem.

I tempted to add also 'make install' to the target to shortcut
'make modules && make modules install' to just 'make modules', but that
would not be a clean and consistent approach.

Kind regards,
Petr

 INSTALL  |  8 ++++++++
 Makefile | 14 ++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/INSTALL b/INSTALL
index cbe27f32ea..a7d48a45b3 100644
--- a/INSTALL
+++ b/INSTALL
@@ -165,6 +165,14 @@ PKG_CONFIG_LIBDIR=/usr/lib/i386-linux-gnu/pkgconfig CFLAGS=-m32 LDFLAGS=-m32 ./c
 * Arch Linux
 PKG_CONFIG_LIBDIR=/usr/lib32/pkgconfig CFLAGS=-m32 LDFLAGS=-m32 ./configure
 
+Kernel modules
+--------------
+
+LTP contains few kernel modules and tests which are using them.
+These require to be built with the same kernel headers as the running kernel (SUT).
+Sometimes the best way to achieve this is to compile them on the SUT.
+'make modules' target is a shortcut to build these kernel modules and tests.
+
 Android Users
 -------------
 
diff --git a/Makefile b/Makefile
index eab40da8a6..9042bdc945 100644
--- a/Makefile
+++ b/Makefile
@@ -212,6 +212,20 @@ endif
 test-metadata: metadata-all
 	$(MAKE) -C $(abs_srcdir)/metadata test
 
+MODULE_DIRS := commands/insmod \
+	testcases/kernel/firmware \
+	testcases/kernel/device-drivers \
+	testcases/kernel/syscalls/delete_module \
+	testcases/kernel/syscalls/finit_module \
+	testcases/kernel/syscalls/init_module
+
+.PHONY: modules
+modules:
+	@$(foreach dir,$(MODULE_DIRS),\
+		echo "Build $(dir)";\
+		$(MAKE) -C $(abs_srcdir)/$(dir); \
+)
+
 ## Help
 .PHONY: help
 help:
-- 
2.50.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
