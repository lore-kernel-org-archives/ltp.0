Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE459F5A8DE
	for <ltp@archiver.kernel.org>; Wed, 22 Apr 2026 11:32:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C60253E53BD
	for <ltp@archiver.kernel.org>; Wed, 22 Apr 2026 13:32:03 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BF0C63E4A7E
 for <ltp@lists.linux.it>; Wed, 22 Apr 2026 13:31:45 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 51BB760071D
 for <ltp@lists.linux.it>; Wed, 22 Apr 2026 13:31:45 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 575A15BD36;
 Wed, 22 Apr 2026 11:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776857504; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=6xK4CSGxLMq1WUmHZtEF+OqIdVWDbJytcCQcVJdaH1k=;
 b=049ak8Bqz7fntEw0AAlr4b3UozfDQ8dUL0gR7/QdEQOf95N28gKpVshA75f1iL0u2RwEkY
 QLeh7gLA1U/+Lo87ipwghkPeYOR2YLgB2k1abbXwxGVEHMTBemGLFGO/NiS2KCR9sF5lXp
 RiIP/90KsUiNBD6o5wRpwR7owV3akDw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776857504;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=6xK4CSGxLMq1WUmHZtEF+OqIdVWDbJytcCQcVJdaH1k=;
 b=VP08ROSqHDRW70EtR879/khUo6Pk6qkrzc8hJL4FO5a3PdvBVQOlXwVdDd44v4Tk8qMire
 SixIScZsQDdWv5DQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=049ak8Bq;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=VP08ROSq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776857504; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=6xK4CSGxLMq1WUmHZtEF+OqIdVWDbJytcCQcVJdaH1k=;
 b=049ak8Bqz7fntEw0AAlr4b3UozfDQ8dUL0gR7/QdEQOf95N28gKpVshA75f1iL0u2RwEkY
 QLeh7gLA1U/+Lo87ipwghkPeYOR2YLgB2k1abbXwxGVEHMTBemGLFGO/NiS2KCR9sF5lXp
 RiIP/90KsUiNBD6o5wRpwR7owV3akDw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776857504;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=6xK4CSGxLMq1WUmHZtEF+OqIdVWDbJytcCQcVJdaH1k=;
 b=VP08ROSqHDRW70EtR879/khUo6Pk6qkrzc8hJL4FO5a3PdvBVQOlXwVdDd44v4Tk8qMire
 SixIScZsQDdWv5DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1ACEC593AF;
 Wed, 22 Apr 2026 11:31:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 3ASSBaCx6Gl2MgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 22 Apr 2026 11:31:44 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 22 Apr 2026 13:31:36 +0200
Message-ID: <20260422113136.416482-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 SUSPICIOUS_RECIPS(1.50)[]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FREEMAIL_CC(0.00)[suse.cz,redhat.com,gmail.com,suse.com];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCPT_COUNT_SEVEN(0.00)[8]; TAGGED_RCPT(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.cz:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Queue-Id: 575A15BD36
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] include: Remove 'make install' support
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

LTP headers aren't needed to be installed, they are unusable without LTP
core library anyway (which is not separated from sources). Therefore
newly added Makefile for 'make check' in 684cae7552 ("include/lapi: add
leaf Makefile") did not support it. Remove it also from
include/Makefile.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

trivial patch, but I'd appreciate your ack that we really don't want
headers to be installed. Otherwise it'd have to be added also to
include/lapi/Makefile (added in 684cae7552).

Kind regards,
Petr

 include/Makefile | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/include/Makefile b/include/Makefile
index 84cd4ed6e3..7fe72a2557 100644
--- a/include/Makefile
+++ b/include/Makefile
@@ -1,19 +1,12 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (C) 2009, Cisco Systems Inc.
+# Copyright (c) Linux Test Project, 2026
 # Ngie Cooper, July 2009
 
 top_srcdir		?= ..
 
 include $(top_srcdir)/include/mk/env_pre.mk
 
-INSTALL_DIR		:= $(includedir)
-
-INSTALL_MODE		:= 00644
-
-INSTALL_TARGETS		:= *.h
-
-MAKE_TARGETS		:=
-
 .PHONY: ac-clean ac-distclean ac-maintainer-clean distclean maintainer-clean
 distclean:: clean ac-distclean
 maintainer-clean:: distclean ac-maintainer-clean
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
