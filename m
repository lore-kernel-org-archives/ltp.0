Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36A7DC87FCB
	for <ltp@archiver.kernel.org>; Wed,  6 Aug 2025 21:14:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F1DE53C8B42
	for <ltp@archiver.kernel.org>; Wed,  6 Aug 2025 23:14:48 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DAB353C83C3
 for <ltp@lists.linux.it>; Wed,  6 Aug 2025 23:14:33 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id D4B951000233
 for <ltp@lists.linux.it>; Wed,  6 Aug 2025 23:14:31 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id ECE8433820;
 Wed,  6 Aug 2025 21:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1754514869; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=y+7S6grM1RwVezfnFkfj3CPTukjJjq60IlXj6TBd7/I=;
 b=ql7TKzpzkxxR/0mysNln9+speABdxH+eK6X65bJyxSg+3v5qgXrq7F6Nn/WSxOwiTi1qD1
 hEX/hUXeEm0ztRwtu9y7aESI95dFVBsrU1CgpnbEZtyVxXMFe30BXmVdUc+1Feyv6eoZ1n
 AxkRxLFrKh2qBtyinFf4z1gzG7bdfzQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1754514869;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=y+7S6grM1RwVezfnFkfj3CPTukjJjq60IlXj6TBd7/I=;
 b=/S8KSyoCsbdZZdvvBB8yzJzSbABav/4t8AKAxCA5ZSBc7NJzCtoIUle34iDsO/etz2eZB8
 j+2fGuVhrZKD7QAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1754514868; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=y+7S6grM1RwVezfnFkfj3CPTukjJjq60IlXj6TBd7/I=;
 b=SV2inFdYzh8SThiRfOVvGMqoBB8AkmXh78QbTo225KRuIhHttAx28Yu0FsqsD2T5pHrgXo
 qYGggYvlCyBFyQ3h9vhdiJaC8GeAExqySDGbKUptuDf/3EWGqWWRKR6ndvuTwHINMfsPDD
 UZJmdlhzPAQkdp35TXvRTns5KYSw4pw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1754514868;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=y+7S6grM1RwVezfnFkfj3CPTukjJjq60IlXj6TBd7/I=;
 b=n+JW0BNz3+oQB1GpR1quhCawDr3IxTLye9tTh+FIj3yCqsK61TTHpGAeOycJBpqQfQDBXy
 uFb+HGQGyFxPwYDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7716A13ABE;
 Wed,  6 Aug 2025 21:14:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Dr2KF7TFk2jNdgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 06 Aug 2025 21:14:28 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed,  6 Aug 2025 23:14:19 +0200
Message-ID: <20250806211420.445452-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[suse.cz:mid,suse.cz:email,ozlabs.org:url,imap1.dmz-prg2.suse.org:helo];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.cz:email];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 1/2] Makefile: Add kernel modules related make
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

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Changes v2->v3:
* Automatic detection (Li), note: without 'sort -u' as there should be
  single Makefile in directory.

Link to v2:
https://patchwork.ozlabs.org/project/ltp/patch/20250801100935.974351-1-pvorel@suse.cz/
https://lore.kernel.org/ltp/20250801100935.974351-1-pvorel@suse.cz/

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
index eab40da8a6..cdad8b10ce 100644
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
+		$(MAKE) -C $(abs_srcdir)/$(dir); \
+)
+modules-clean:
+	@$(foreach dir,$(MODULE_DIRS),\
+		echo "Build $(dir)";\
+		$(MAKE) -C $(abs_srcdir)/$(dir) clean; \
+)
+modules-install: modules
+	@$(foreach dir,$(MODULE_DIRS),\
+		echo "Build $(dir)";\
+		$(MAKE) -C $(abs_srcdir)/$(dir) install; \
+)
+
 ## Help
 .PHONY: help
 help:
-- 
2.50.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
