Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4E08CD11C2
	for <ltp@archiver.kernel.org>; Fri,  5 Apr 2024 14:39:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3608C3CEF50
	for <ltp@archiver.kernel.org>; Fri,  5 Apr 2024 16:39:27 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 67D933CE213
 for <ltp@lists.linux.it>; Fri,  5 Apr 2024 16:39:11 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 278936691AB
 for <ltp@lists.linux.it>; Fri,  5 Apr 2024 16:39:10 +0200 (CEST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7748521AAE;
 Fri,  5 Apr 2024 14:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1712327948; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=h61Gr0RFPRT97VZPEjpaHqg+8DB14LwmE3x76UttGdk=;
 b=T0GRwetjqIrYxOWNCAK6G1c6eGtgZ124HmbsCQ/PvRjv/yLCukLc8ANmlK5ovZUfWRk/vB
 MQ9Q5tjuZ0PhT3CUqubtVVboEMFkkt0fed/hdTXsabvv9Hi6f3OwzIO7sVKtk62GGMTeWe
 OZmZU5XfO9T4YzeHPcLM2CYAUnVTxA0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1712327948;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=h61Gr0RFPRT97VZPEjpaHqg+8DB14LwmE3x76UttGdk=;
 b=zf71BK2J61OabJs0pgYeRE8AntTHxWbKxst11HsJGKCYtM2UaNNNE4QGNZlbLb6UCy7Her
 lUQD04h7L9adCGDA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=T0GRwetj;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=zf71BK2J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1712327948; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=h61Gr0RFPRT97VZPEjpaHqg+8DB14LwmE3x76UttGdk=;
 b=T0GRwetjqIrYxOWNCAK6G1c6eGtgZ124HmbsCQ/PvRjv/yLCukLc8ANmlK5ovZUfWRk/vB
 MQ9Q5tjuZ0PhT3CUqubtVVboEMFkkt0fed/hdTXsabvv9Hi6f3OwzIO7sVKtk62GGMTeWe
 OZmZU5XfO9T4YzeHPcLM2CYAUnVTxA0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1712327948;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=h61Gr0RFPRT97VZPEjpaHqg+8DB14LwmE3x76UttGdk=;
 b=zf71BK2J61OabJs0pgYeRE8AntTHxWbKxst11HsJGKCYtM2UaNNNE4QGNZlbLb6UCy7Her
 lUQD04h7L9adCGDA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 4B4E5139E8;
 Fri,  5 Apr 2024 14:39:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap2.dmz-prg2.suse.org with ESMTPSA id AlcTEQwNEGaASAAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Fri, 05 Apr 2024 14:39:08 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri,  5 Apr 2024 16:39:04 +0200
Message-ID: <20240405143904.642340-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-0.16 / 50.00]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; BAYES_HAM(-0.15)[68.84%];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[4]; DKIM_TRACE(0.00)[suse.cz:+]
X-Spamd-Bar: /
X-Rspamd-Queue-Id: 7748521AAE
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [COMMITTED][PATCH 1/1] doc: Remove make install
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

make install in doc is broken on out-of-tree builds. Although we may
want to install generated docs (final html), for now just disable the
target to fix CI. Previously was the install target used just for
installing man pages (which are deprecated anyway).

Fixes: 4a72aada8 ("New LTP documentation")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Makefile b/Makefile
index 49d91f4d5..96edd5a80 100644
--- a/Makefile
+++ b/Makefile
@@ -38,7 +38,6 @@ export UCLINUX
 # We're not using uclinux based targets (default).
 ifneq ($(UCLINUX),1)
 COMMON_TARGETS		:= pan utils
-INSTALL_TARGETS		:= doc
 endif
 
 define target_to_dir_dep_mapping
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
