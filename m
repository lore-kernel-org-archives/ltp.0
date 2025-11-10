Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B2F6CCFA13
	for <ltp@archiver.kernel.org>; Mon, 10 Nov 2025 08:54:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 97A6E3CF575
	for <ltp@archiver.kernel.org>; Mon, 10 Nov 2025 09:54:05 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A53B33CA037
 for <ltp@lists.linux.it>; Mon, 10 Nov 2025 09:53:50 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 2D02F140096D
 for <ltp@lists.linux.it>; Mon, 10 Nov 2025 09:53:49 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2C2E91F7D9;
 Mon, 10 Nov 2025 08:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1762764829; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=q1UHazT8RmnJhgLn091LHkZV0Ey1AHBvAcuTeU/4aUY=;
 b=Xi/wIvFr61bLJA7lMeokPKjRgjyWdkxdL8onD/GgklixygUwvXFHnsTOnmp0nL8wA3VufG
 Z1BR6gB1X4uvwSc0xEmBoIZVb6majiW82esa2kft6Buuq8RnLvVjMfo1i/EZzhX4K0wa2S
 QDyA3t8fWmVQ563F27zVVKPV+Y0o+Io=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1762764829;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=q1UHazT8RmnJhgLn091LHkZV0Ey1AHBvAcuTeU/4aUY=;
 b=lAieEN5vzxmTVBDd/t4dG4K/ULMkZYl0pH+Qs8O2uqJ5FishNSu4dfHVQTo93OyO3ebCN1
 ktuNlnYaEWFasTBw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="Xi/wIvFr";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=lAieEN5v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1762764829; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=q1UHazT8RmnJhgLn091LHkZV0Ey1AHBvAcuTeU/4aUY=;
 b=Xi/wIvFr61bLJA7lMeokPKjRgjyWdkxdL8onD/GgklixygUwvXFHnsTOnmp0nL8wA3VufG
 Z1BR6gB1X4uvwSc0xEmBoIZVb6majiW82esa2kft6Buuq8RnLvVjMfo1i/EZzhX4K0wa2S
 QDyA3t8fWmVQ563F27zVVKPV+Y0o+Io=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1762764829;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=q1UHazT8RmnJhgLn091LHkZV0Ey1AHBvAcuTeU/4aUY=;
 b=lAieEN5vzxmTVBDd/t4dG4K/ULMkZYl0pH+Qs8O2uqJ5FishNSu4dfHVQTo93OyO3ebCN1
 ktuNlnYaEWFasTBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AB54113BCC;
 Mon, 10 Nov 2025 08:53:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id nCi+GxyoEWnYRwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 10 Nov 2025 08:53:48 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 10 Nov 2025 09:53:47 +0100
MIME-Version: 1.0
Message-Id: <20251110-kirk_makefile_install_fix-v2-1-d1f61d4fa23a@suse.com>
X-B4-Tracking: v=1; b=H4sIABqoEWkC/42NWw6CMBBFt0Lm25pOEXx8uQ9DSIGpTHiZDhIM6
 d6trMDPc3PvuRsIeSaBW7KBp4WFpzGCOSRQt3Z8kuImMhhtMkTUqmPflYPtyHFPJY8y274vHa/
 qZBCveVW5/HKGuH/52Fl396OI3LLMk//sVwv+0n+sCypUlDqNpOsmS+kub6FjPQ1QhBC+liBNU
 cEAAAA=
X-Change-ID: 20251110-kirk_makefile_install_fix-421196bbf687
To: ltp@lists.linux.it
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762764828; l=1986;
 i=andrea.cervesato@suse.com; s=20250922; h=from:subject:message-id;
 bh=ZLJNFXLFFNQJfJtTvZ2lFBshnYVxHLyuUZWu1cD4Hn0=;
 b=7VOJ1a3/IDJzkdMKBGgA5w3oTHl1hrGot/M3W/TyRyt2ve9EhupBEeSrwW5Qx836Fgtk0Xepp
 RdLBtpGnf5wAB6hy+2JlwPvmi589xv32XL2rS33J9tGg66VrZM3sLpV
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=+8M3XgViLdcdNBM+Jdd90m3pV4jCw2tNsGCy5Rd+qHk=
X-Rspamd-Queue-Id: 2C2E91F7D9
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.com:mid,suse.com:email,suse.cz:email];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] kirk: install only if sources are present
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

From: Andrea Cervesato <andrea.cervesato@suse.com>

Fix kirk Makefile, so source code is copied during install process
only if it's present.

Fixes: 4db20e7d79 ("kirk: move kirk source code inside tools/kirk/kirk-src")
Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Changes in v2:
- git submodule --init if we are inside the folder or during make check
- Link to v1: https://lore.kernel.org/r/20251110-kirk_makefile_install_fix-v1-1-e3f01e0cd53e@suse.com
---
 tools/kirk/Makefile | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/tools/kirk/Makefile b/tools/kirk/Makefile
index 1a09c43ce..10c45789c 100644
--- a/tools/kirk/Makefile
+++ b/tools/kirk/Makefile
@@ -8,15 +8,25 @@ top_srcdir		?= ../..
 include $(top_srcdir)/include/mk/env_pre.mk
 
 BASE_DIR		:= $(abspath $(DESTDIR)/$(prefix))
+KIRK_SRC		?= kirk-src
+
+$(KIRK_SRC)/Makefile:
+ifeq ($(KIRK_SRC),sparse-src)
+	git submodule update --init
+else
+	$(error "Can't find $(KIRK_SRC)/Makefile")
+endif
 
 install:
+ifneq ($(wildcard $(abs_srcdir)/kirk-src/libkirk/*.py),)
 	mkdir -p $(BASE_DIR)/libkirk
 	mkdir -p $(BASE_DIR)/libkirk/channels
 
-	install -m 00644 $(top_srcdir)/tools/kirk/kirk-src/libkirk/*.py $(BASE_DIR)/libkirk
-	install -m 00644 $(top_srcdir)/tools/kirk/kirk-src/libkirk/channels/*.py $(BASE_DIR)/libkirk/channels
-	install -m 00775 $(top_srcdir)/tools/kirk/kirk-src/kirk $(BASE_DIR)/kirk
+	install -m 00644 $(abs_srcdir)/kirk-src/libkirk/*.py $(BASE_DIR)/libkirk
+	install -m 00644 $(abs_srcdir)/kirk-src/libkirk/channels/*.py $(BASE_DIR)/libkirk/channels
+	install -m 00775 $(abs_srcdir)/kirk-src/kirk $(BASE_DIR)/kirk
 
 	cd $(BASE_DIR) && ln -sf kirk runltp-ng
+endif
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk

---
base-commit: 9cde2740ccc86c464cc16862b74d1cb885e4220e
change-id: 20251110-kirk_makefile_install_fix-421196bbf687

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
