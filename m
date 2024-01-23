Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD0A2C47258
	for <ltp@archiver.kernel.org>; Tue, 23 Jan 2024 16:27:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3240A3CE213
	for <ltp@archiver.kernel.org>; Tue, 23 Jan 2024 17:27:41 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E84EB3CB939
 for <ltp@lists.linux.it>; Tue, 23 Jan 2024 17:26:54 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 05574608A65
 for <ltp@lists.linux.it>; Tue, 23 Jan 2024 17:26:54 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7B7ED22308;
 Tue, 23 Jan 2024 16:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706027213; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qhpS5dVdrSAN30nXGY8gue30P+GQRMTVPIwBgvdZuA8=;
 b=G33TwztsDcyohGI/xdznmrSMj0qP8NVEL0ki+456Vz8lOLyOpEk+lvfREWzQQZD0+Keujj
 AVJx4a4DGRUcMJJhUEeMDr+ojxQ+YrW7dUSnDP60qahz7Ihi7Mi3hPLSzjkg2s55BccfLv
 iSZOCgqaYrMxxIoe8CMQhrD5yxEwJdU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706027213;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qhpS5dVdrSAN30nXGY8gue30P+GQRMTVPIwBgvdZuA8=;
 b=teQPo60Sr6XpYDrKVaecHb/dLLvNZYzj/YBDth7FAQjZxMUXWc2HOV0dapk883WDDrcYJ2
 XClKcPp5yR2QXTDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706027213; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qhpS5dVdrSAN30nXGY8gue30P+GQRMTVPIwBgvdZuA8=;
 b=G33TwztsDcyohGI/xdznmrSMj0qP8NVEL0ki+456Vz8lOLyOpEk+lvfREWzQQZD0+Keujj
 AVJx4a4DGRUcMJJhUEeMDr+ojxQ+YrW7dUSnDP60qahz7Ihi7Mi3hPLSzjkg2s55BccfLv
 iSZOCgqaYrMxxIoe8CMQhrD5yxEwJdU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706027213;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qhpS5dVdrSAN30nXGY8gue30P+GQRMTVPIwBgvdZuA8=;
 b=teQPo60Sr6XpYDrKVaecHb/dLLvNZYzj/YBDth7FAQjZxMUXWc2HOV0dapk883WDDrcYJ2
 XClKcPp5yR2QXTDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EC74013786;
 Tue, 23 Jan 2024 16:26:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6JzbNczor2V+CwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 23 Jan 2024 16:26:52 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 23 Jan 2024 17:26:45 +0100
Message-ID: <20240123162647.210424-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240123162647.210424-1-pvorel@suse.cz>
References: <20240123162647.210424-1-pvorel@suse.cz>
MIME-Version: 1.0
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=G33Twzts;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=teQPo60S
X-Spamd-Result: default: False [9.66 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAM_FLAG(5.00)[]; FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 R_MISSING_CHARSET(2.50)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 BROKEN_CONTENT_TYPE(1.50)[]; RCPT_COUNT_FIVE(0.00)[6];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; MX_GOOD(-0.01)[];
 MID_CONTAINS_FROM(1.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.03)[56.70%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 7B7ED22308
X-Spamd-Bar: +++++++++
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/4] commands: Fix tst_brk TFAIL
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

It needs to be replaced with tst_res TFAIL and return

Fixes: 1878502f6 ("tst_test.sh/tst_brk(): Allow only TBROK and TCONF")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/commands/gzip/gzip_tests.sh | 3 ++-
 testcases/commands/mv/mv_tests.sh     | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/testcases/commands/gzip/gzip_tests.sh b/testcases/commands/gzip/gzip_tests.sh
index fdc933ea2..3262c555b 100755
--- a/testcases/commands/gzip/gzip_tests.sh
+++ b/testcases/commands/gzip/gzip_tests.sh
@@ -82,7 +82,8 @@ test1()
 	gzip -r tst_gzip.tmp > tst_gzip.err 2>&1
 	if [ $? -ne 0 ]; then
 		cat tst_gzip.err
-		tst_brk TFAIL "Test #1: gzip -r failed"
+		tst_res TFAIL "Test #1: gzip -r failed"
+		return
 	fi
 
 	tst_res TINFO "Test #1: creating output file"
diff --git a/testcases/commands/mv/mv_tests.sh b/testcases/commands/mv/mv_tests.sh
index 91648dd8f..ae8b8701d 100755
--- a/testcases/commands/mv/mv_tests.sh
+++ b/testcases/commands/mv/mv_tests.sh
@@ -88,7 +88,8 @@ test1()
 	mv tst_mv.old tst_mv.new > tst_mv.err 2>&1
 	if [ $? -ne 0 ]; then
 		cat tst_mv.err
-		tst_brk TFAIL "Test #1: 'mv tst_mv.old tst_mv.new' failed"
+		tst_res TFAIL "Test #1: 'mv tst_mv.old tst_mv.new' failed"
+		return
 	fi
 
 	tst_res TINFO "Test #1: creating output file"
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
