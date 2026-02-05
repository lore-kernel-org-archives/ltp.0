Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12DAAEC1EAB
	for <ltp@archiver.kernel.org>; Thu,  5 Feb 2026 12:17:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B51683CE2E9
	for <ltp@archiver.kernel.org>; Thu,  5 Feb 2026 13:17:51 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7CC383CE071
 for <ltp@lists.linux.it>; Thu,  5 Feb 2026 13:16:15 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D6FA31400779
 for <ltp@lists.linux.it>; Thu,  5 Feb 2026 13:16:14 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8F5943E7BF;
 Thu,  5 Feb 2026 12:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1770293751; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RFhSfk9+jqs4UCJ7VWiJNwRkEozh/58Peu4/f3FM39c=;
 b=wuatrukObDfZFwDPNBOFCnAUQ2Vll0j9Aou9O0ReXSKoW2g10CBvDyU1AK1FHXHflrmS+J
 7SkAPtN82w7ObDIlVDHUEx6XTu5Pke2ns0O3sygaEuyHmSLTqTB6wejXaps276E76+UTt4
 8k1IC3u0vUoo19OX199a4hm7lGKA4As=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1770293751;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RFhSfk9+jqs4UCJ7VWiJNwRkEozh/58Peu4/f3FM39c=;
 b=dWR1aPXi0W/aesx2ME8ZfX4S9fp9VvWiWfRGdQRH4zuI1oXLhd+PEvCtGsUjdWO+EDJT49
 Nm+W9AXIaikAZoDA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=wuatrukO;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=dWR1aPXi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1770293751; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RFhSfk9+jqs4UCJ7VWiJNwRkEozh/58Peu4/f3FM39c=;
 b=wuatrukObDfZFwDPNBOFCnAUQ2Vll0j9Aou9O0ReXSKoW2g10CBvDyU1AK1FHXHflrmS+J
 7SkAPtN82w7ObDIlVDHUEx6XTu5Pke2ns0O3sygaEuyHmSLTqTB6wejXaps276E76+UTt4
 8k1IC3u0vUoo19OX199a4hm7lGKA4As=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1770293751;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RFhSfk9+jqs4UCJ7VWiJNwRkEozh/58Peu4/f3FM39c=;
 b=dWR1aPXi0W/aesx2ME8ZfX4S9fp9VvWiWfRGdQRH4zuI1oXLhd+PEvCtGsUjdWO+EDJT49
 Nm+W9AXIaikAZoDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 019223EA63;
 Thu,  5 Feb 2026 12:15:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uP4rO/aJhGmHXwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 05 Feb 2026 12:15:50 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  5 Feb 2026 13:15:40 +0100
Message-ID: <20260205121540.329921-7-pvorel@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260205121540.329921-1-pvorel@suse.cz>
References: <20260205121540.329921-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 RCPT_COUNT_TWELVE(0.00)[16];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:mid,suse.cz:dkim,suse.cz:email];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FREEMAIL_CC(0.00)[suse.cz,suse.com,suse.de,redhat.com,virtuozzo.com,lists.yoctoproject.org,sony.com,free.fr,bootlin.com,linaro.org,gmail.com];
 RCVD_TLS_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_TRACE(0.00)[suse.cz:+];
 R_RATELIMIT(0.00)[to_ip_from(RLptdp67iqnr7ezcrba78cogj5)];
 FREEMAIL_ENVRCPT(0.00)[free.fr,gmail.com]
X-Rspamd-Queue-Id: 8F5943E7BF
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 6/6] kirk: Remove runltp-ng symlink
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
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Vasileios Almpanis <vasileios.almpanis@virtuozzo.com>,
 Tim Bird <Tim.Bird@sony.com>, Julien Olivain <ju.o@free.fr>,
 automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

kirk is here long enough to remove the symlink.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 tools/kirk/Makefile | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/kirk/Makefile b/tools/kirk/Makefile
index 876eb3e2ed..859afde6e6 100644
--- a/tools/kirk/Makefile
+++ b/tools/kirk/Makefile
@@ -17,8 +17,6 @@ ifneq ($(wildcard $(abs_srcdir)/kirk-src/libkirk/*.py),)
 	install -m 00644 $(abs_srcdir)/kirk-src/libkirk/*.py $(BASE_DIR)/libkirk
 	install -m 00644 $(abs_srcdir)/kirk-src/libkirk/channels/*.py $(BASE_DIR)/libkirk/channels
 	install -m 00775 $(abs_srcdir)/kirk-src/kirk $(BASE_DIR)/kirk
-
-	cd $(BASE_DIR) && ln -sf kirk runltp-ng
 endif
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
