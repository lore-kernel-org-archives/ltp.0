Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84469E9537B
	for <ltp@archiver.kernel.org>; Wed,  4 Feb 2026 11:55:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2B9643CE0A3
	for <ltp@archiver.kernel.org>; Wed,  4 Feb 2026 12:55:11 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C51003CE127
 for <ltp@lists.linux.it>; Wed,  4 Feb 2026 12:54:11 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6016514002B5
 for <ltp@lists.linux.it>; Wed,  4 Feb 2026 12:54:10 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D56063E712;
 Wed,  4 Feb 2026 11:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1770206024; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RFhSfk9+jqs4UCJ7VWiJNwRkEozh/58Peu4/f3FM39c=;
 b=UjPA/T+ACqA7O6RuiN2cdGOyy2TR1+7xBSh1tQhVDboCoQBGiyYWn/i7UnKnJAdLTQxPGd
 tUiLQzZh1BlZhG7Xh3qsOttiSXVNUzLAb7z7nc81CB/ZwInHwhxrnHwrnqO9lXjYYSqxBC
 kMgsIGVD59FzydEFUgl39wpJkgcdDSM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1770206024;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RFhSfk9+jqs4UCJ7VWiJNwRkEozh/58Peu4/f3FM39c=;
 b=52jKyPYy/Dbvq/waOTzo6UgR0qbyTSTZQne2tZUtg/hvaQ8vIUElJNC3LUSid9nqSaKkSe
 OnhZ7Xs6x91EwUAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1770206024; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RFhSfk9+jqs4UCJ7VWiJNwRkEozh/58Peu4/f3FM39c=;
 b=UjPA/T+ACqA7O6RuiN2cdGOyy2TR1+7xBSh1tQhVDboCoQBGiyYWn/i7UnKnJAdLTQxPGd
 tUiLQzZh1BlZhG7Xh3qsOttiSXVNUzLAb7z7nc81CB/ZwInHwhxrnHwrnqO9lXjYYSqxBC
 kMgsIGVD59FzydEFUgl39wpJkgcdDSM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1770206024;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RFhSfk9+jqs4UCJ7VWiJNwRkEozh/58Peu4/f3FM39c=;
 b=52jKyPYy/Dbvq/waOTzo6UgR0qbyTSTZQne2tZUtg/hvaQ8vIUElJNC3LUSid9nqSaKkSe
 OnhZ7Xs6x91EwUAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 70BE83EA64;
 Wed,  4 Feb 2026 11:53:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oMJVGkgzg2kcCwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 04 Feb 2026 11:53:44 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed,  4 Feb 2026 12:53:39 +0100
Message-ID: <20260204115339.224261-5-pvorel@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260204115339.224261-1-pvorel@suse.cz>
References: <20260204115339.224261-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_CC(0.00)[suse.cz,suse.com,suse.de,redhat.com,virtuozzo.com,lists.yoctoproject.org,sony.com,free.fr,bootlin.com,linaro.org];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[15]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 FROM_HAS_DN(0.00)[];
 R_RATELIMIT(0.00)[to_ip_from(RL67q8k7jcs7b17wgfxef7j4ei)];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FREEMAIL_ENVRCPT(0.00)[free.fr]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 4/4] kirk: Remove runltp-ng symlink
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
