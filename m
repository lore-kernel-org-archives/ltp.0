Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8011EC55ABA
	for <ltp@archiver.kernel.org>; Wed,  5 Aug 2026 15:16:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F08F73E714E
	for <ltp@archiver.kernel.org>; Wed,  5 Aug 2026 17:16:33 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2EDFB3CE30B
 for <ltp@lists.linux.it>; Wed,  5 Aug 2026 17:15:10 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 668EC60068B
 for <ltp@lists.linux.it>; Wed,  5 Aug 2026 17:15:09 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AC1353DF4;
 Wed,  5 Aug 2026 15:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785942903; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tTpjfvQCmY5Qw1VQuj7QGVXJw+fYnmtojCIZCK4x87g=;
 b=gfMtudg7KAbYapUqNcGqOm8la4C0tjgo2Pus4wzIXmHWwrfBQ7UStobNXqO1FACTcY1rtk
 mKGNTE2C/5pQdc6p88/sg0bKU3nodm0Q8zg7YRsQNS1dbFuMOxNibdIn7xUmgTp3EV2YgP
 5Zt76haIp30hzBkdT/kAcoPuq6mQIZs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785942903;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tTpjfvQCmY5Qw1VQuj7QGVXJw+fYnmtojCIZCK4x87g=;
 b=VxXORjep3HXcGnAjIS6DQdPcRyh3J98PFn5dxeSlx0X2XQW0ZwxCc3w3Ty2K+iUiMKtWyY
 cDvGMWFeD5ZrBXBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785942899; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tTpjfvQCmY5Qw1VQuj7QGVXJw+fYnmtojCIZCK4x87g=;
 b=LNJ99u6eSLtPmTzriNzfIgm/braWJMkVpdTBooiY3S+VK3/4l7xODVRXK4lAQ2mxSY64H4
 +iGgvV+LRIfVyKQxxTcapi2OqEJzOnQTxhx/TNKSBZSJvZMXQPNLGFzkkmJmeG+lZmh6gA
 P7vkz6WrrKVrWE21W37dzi+R/CHmUag=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785942899;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tTpjfvQCmY5Qw1VQuj7QGVXJw+fYnmtojCIZCK4x87g=;
 b=KhEqLViGVtCKuTkYWqtIA5IrcFmZio5qjKDNXbCcYieTstjlORVGat9P8T91IlKICmf/Kx
 jk6atDSjTejO2NDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5C081779EB;
 Wed,  5 Aug 2026 15:14:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oNHBEnNTc2qsGgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 05 Aug 2026 15:14:59 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed,  5 Aug 2026 17:14:43 +0200
Message-ID: <20260805151451.648990-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260805151451.648990-1-pvorel@suse.cz>
References: <20260805151451.648990-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-6.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[7]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid, suse.cz:email,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 1/9] tst_kvercmp: Factor out error handling
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

Error check was already on 2 places (and possibly more will be added in
the future).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
New in v4.

 lib/tst_kvercmp.c | 23 +++++++++++++++++------
 lib/tst_test.c    |  6 +-----
 2 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/lib/tst_kvercmp.c b/lib/tst_kvercmp.c
index 9e1a511aff..c0714073d4 100644
--- a/lib/tst_kvercmp.c
+++ b/lib/tst_kvercmp.c
@@ -45,7 +45,7 @@ static char *parse_digit(const char *str, int *d)
 	return end;
 }
 
-int tst_parse_kver(const char *str_kver, int *v1, int *v2, int *v3)
+static int _tst_parse_kver(const char *str_kver, int *v1, int *v2, int *v3)
 {
 	const char *str = str_kver;
 
@@ -81,17 +81,28 @@ int tst_parse_kver(const char *str_kver, int *v1, int *v2, int *v3)
 	return 0;
 }
 
-int tst_kvcmp(const char *cur_kver, int r1, int r2, int r3)
+int tst_parse_kver(const char *str_kver, int *v1, int *v2, int *v3)
 {
-	int a1, a2, a3;
-	int testver, currver;
+	int rc;
+
+	rc = _tst_parse_kver(str_kver, v1, v2, v3);
 
-	if (tst_parse_kver(cur_kver, &a1, &a2, &a3)) {
+	if (rc) {
 		tst_resm(TWARN,
 			 "Invalid kernel version %s, expected %%d.%%d.%%d",
-		         cur_kver);
+		         str_kver);
 	}
 
+	return rc;
+}
+
+int tst_kvcmp(const char *cur_kver, int r1, int r2, int r3)
+{
+	int a1, a2, a3;
+	int testver, currver;
+
+	tst_parse_kver(cur_kver, &a1, &a2, &a3);
+
 	testver = (r1 << 20) + (r2 << 10) + r3;
 	currver = (a1 << 20) + (a2 << 10) + a3;
 
diff --git a/lib/tst_test.c b/lib/tst_test.c
index 5c3607016e..351b155700 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1067,11 +1067,7 @@ static bool check_kver(const char *min_kver, const int brk_nosupp)
 	char *msg;
 	int v1, v2, v3;
 
-	if (tst_parse_kver(min_kver, &v1, &v2, &v3)) {
-		tst_res(TWARN,
-			"Invalid kernel version %s, expected %%d.%%d.%%d",
-			min_kver);
-	}
+	tst_parse_kver(min_kver, &v1, &v2, &v3);
 
 	if (tst_kvercmp(v1, v2, v3) < 0) {
 		msg = "The test requires kernel %s or newer";
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
