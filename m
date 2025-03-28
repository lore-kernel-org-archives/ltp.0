Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39CA0C28B20
	for <ltp@archiver.kernel.org>; Fri, 28 Mar 2025 09:59:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CDF603CA305
	for <ltp@archiver.kernel.org>; Fri, 28 Mar 2025 10:59:24 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 114803CA286
 for <ltp@lists.linux.it>; Fri, 28 Mar 2025 10:58:01 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A3D3D1400429
 for <ltp@lists.linux.it>; Fri, 28 Mar 2025 10:58:00 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9DB452119E;
 Fri, 28 Mar 2025 09:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1743155870; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iYkQWM+uJ0TZ0X9rIx5og3JU6leBt66Ft4DU5ZH1A4M=;
 b=lSurrjxMtmspQXaL4X1Ad3xHbCshzvfJhd0uAzI66lWamYQfESP2SVD7v8rRtTNCGnlFzo
 i9hlOWC5EVwJj663l81H12G2iiLn81aRoLb9icUzk1oYjYVV1yYpbl5QAnuZZmd4xEpM/g
 XXB6U2BST9Kclhgj6aiVieaukaSXiA0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1743155870;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iYkQWM+uJ0TZ0X9rIx5og3JU6leBt66Ft4DU5ZH1A4M=;
 b=c8q/Eoslw2/V+mztpoSSSiJZmV7ry7/wiVzKsRCZu5C2GLG30dCmGZf/riiKfJqz//75NK
 qAsL5EqvXt22fYDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1743155870; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iYkQWM+uJ0TZ0X9rIx5og3JU6leBt66Ft4DU5ZH1A4M=;
 b=lSurrjxMtmspQXaL4X1Ad3xHbCshzvfJhd0uAzI66lWamYQfESP2SVD7v8rRtTNCGnlFzo
 i9hlOWC5EVwJj663l81H12G2iiLn81aRoLb9icUzk1oYjYVV1yYpbl5QAnuZZmd4xEpM/g
 XXB6U2BST9Kclhgj6aiVieaukaSXiA0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1743155870;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iYkQWM+uJ0TZ0X9rIx5og3JU6leBt66Ft4DU5ZH1A4M=;
 b=c8q/Eoslw2/V+mztpoSSSiJZmV7ry7/wiVzKsRCZu5C2GLG30dCmGZf/riiKfJqz//75NK
 qAsL5EqvXt22fYDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8155213998;
 Fri, 28 Mar 2025 09:57:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oJ+rHp5y5mcWHwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 28 Mar 2025 09:57:50 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 28 Mar 2025 10:57:46 +0100
Message-ID: <20250328095747.169011-5-pvorel@suse.cz>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250328095747.169011-1-pvorel@suse.cz>
References: <20250328095747.169011-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-6.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.cz:email];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 4/5] Makefile: Update 'doc' target, add 'doc-clean'
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

'doc' target previously run docparse documentation. Point it to doc/
directory so that it build sphinx docs. doc/ dir has metadata/ dir as
dependency, no need to specify it. Call also '.venv' target.

NOTE: it's still possible to avoid virtualenv by calling 'make -C doc'

Add 'doc-clean': to remove only generated data (not optional .venv).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Changes in v4:
* Use 'setup' instead of '.venv' in the top level doc target

 Makefile | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 5066789349..6aa77e1b9b 100644
--- a/Makefile
+++ b/Makefile
@@ -170,7 +170,13 @@ INSTALL_TARGETS		+= $(addprefix $(DESTDIR)/$(bindir)/,$(BINDIR_INSTALL_SCRIPTS))
 $(INSTALL_TARGETS): $(INSTALL_DIR) $(DESTDIR)/$(bindir)
 
 .PHONY: doc
-doc: metadata-all
+doc:
+	$(MAKE) -C $(abs_builddir)/doc setup
+	$(MAKE) -C $(abs_builddir)/doc
+
+.PHONY: doc-clean
+doc-clean:
+	$(MAKE) -C $(abs_builddir)/doc clean
 
 .PHONY: check
 check: $(CHECK_TARGETS)
-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
