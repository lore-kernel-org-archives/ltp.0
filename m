Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91AFCCCFA1A
	for <ltp@archiver.kernel.org>; Mon, 10 Nov 2025 08:11:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0B7BD3CF56D
	for <ltp@archiver.kernel.org>; Mon, 10 Nov 2025 09:11:14 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B82E83CD77F
 for <ltp@lists.linux.it>; Mon, 10 Nov 2025 09:10:56 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 170FB2005DE
 for <ltp@lists.linux.it>; Mon, 10 Nov 2025 09:10:55 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 43EF433683;
 Mon, 10 Nov 2025 08:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1762762255; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ux3E8/uqoIA4cEtmhoSUToaG1SeC3/QeqCdRNz+J9Jo=;
 b=wG6vVOyrofS4yDDIwBlGOQszTnAwEiD8Sba0xD4X6UV8xCwg3gnI1RgcuMxR+ZkSeG4ZsR
 B7MdCSYShila/K1mkFjP+dRmNxkG3YIAq+qnb13lfWHmkHJzDEeuBjLKFf71kczit0qlpP
 ZyFQi5K2Dbasudfmvzqq99exGy5cIl8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1762762255;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ux3E8/uqoIA4cEtmhoSUToaG1SeC3/QeqCdRNz+J9Jo=;
 b=OAgmuabIzKwXtkdMrP0K9t3WPyDvyyclEZ73wsJQzJbJFtUzCOSj9scXozqI3YwmYUgt59
 yA6rn56wnFpfbICg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=wG6vVOyr;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=OAgmuabI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1762762255; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ux3E8/uqoIA4cEtmhoSUToaG1SeC3/QeqCdRNz+J9Jo=;
 b=wG6vVOyrofS4yDDIwBlGOQszTnAwEiD8Sba0xD4X6UV8xCwg3gnI1RgcuMxR+ZkSeG4ZsR
 B7MdCSYShila/K1mkFjP+dRmNxkG3YIAq+qnb13lfWHmkHJzDEeuBjLKFf71kczit0qlpP
 ZyFQi5K2Dbasudfmvzqq99exGy5cIl8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1762762255;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ux3E8/uqoIA4cEtmhoSUToaG1SeC3/QeqCdRNz+J9Jo=;
 b=OAgmuabIzKwXtkdMrP0K9t3WPyDvyyclEZ73wsJQzJbJFtUzCOSj9scXozqI3YwmYUgt59
 yA6rn56wnFpfbICg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9C6B613BA1;
 Mon, 10 Nov 2025 08:10:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id u+GZGQ6eEWk2HAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 10 Nov 2025 08:10:54 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 10 Nov 2025 09:10:46 +0100
MIME-Version: 1.0
Message-Id: <20251110-kirk_makefile_install_fix-v1-1-e3f01e0cd53e@suse.com>
X-B4-Tracking: v=1; b=H4sIAAWeEWkC/x2M0QqEIBAAfyX2OaGVy6t+JUL0br1bNAs9Qoj+P
 bnHgZk5IVNiyjA1JyQ6OPMWK2DbwOtr4ocEvyuD7GSPiJ3wnLxejSfHgTTH/DMhaMdFPCTiqKx
 1anhC7fdUnfJ/z8t13ccZPutrAAAA
X-Change-ID: 20251110-kirk_makefile_install_fix-421196bbf687
To: ltp@lists.linux.it
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762762254; l=1460;
 i=andrea.cervesato@suse.com; s=20250922; h=from:subject:message-id;
 bh=msqlFU2fMDG/L7p4GFnAFhorEWCWaIsSDpXSUrJvx2I=;
 b=9Eqw9QvIqs9i07Wd5IJRjysza1fSNKPO63oDbBZH/HBnkpDykkzP+m9Y8afrC2SjjZqNxYjmt
 bxidwhzJasEB5DAeDbocrTC3pkfvd2UquO69iOqL+IEYefB2StTrm+X
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=+8M3XgViLdcdNBM+Jdd90m3pV4jCw2tNsGCy5Rd+qHk=
X-Rspamd-Queue-Id: 43EF433683
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] kirk: install only if sources are present
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

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 tools/kirk/Makefile | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/kirk/Makefile b/tools/kirk/Makefile
index 1a09c43ce..876eb3e2e 100644
--- a/tools/kirk/Makefile
+++ b/tools/kirk/Makefile
@@ -10,13 +10,15 @@ include $(top_srcdir)/include/mk/env_pre.mk
 BASE_DIR		:= $(abspath $(DESTDIR)/$(prefix))
 
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
