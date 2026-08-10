Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4F43C5AD55
	for <ltp@archiver.kernel.org>; Mon, 10 Aug 2026 16:01:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 798A43D0736
	for <ltp@archiver.kernel.org>; Mon, 10 Aug 2026 18:01:19 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2297B3CCDB8
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 18:01:00 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C068310000E4
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 18:00:59 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id F109180E07;
 Mon, 10 Aug 2026 16:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786377655; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QSvWzHR6EvF+B1sLikgDl/tQyK9rZvbM8WhPKM66Zwg=;
 b=XjrN9Md2B9cg+G14NZJbApPnsiFcAFihJstsnIro1khBsB6anz0+4BaNK/7VuSPq8Xj3Xw
 tbXceMm7iEU6tp/K49cmJ/ky0N4LJl8a6K9KKrV+FvurUvniX3/PHSrMVUNlW61vJ7Qp4r
 Yytgj/IP2isG8z0u140WLbrOV+ZzFec=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786377655;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QSvWzHR6EvF+B1sLikgDl/tQyK9rZvbM8WhPKM66Zwg=;
 b=PV62u/dbazvleMen9LEN8AbMsL7yN0t58SBGWKtC1mNbDNvq3N2xsMSCEs3zTtNQZZAmRQ
 s29P0zxpVV8PmaCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786377650; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QSvWzHR6EvF+B1sLikgDl/tQyK9rZvbM8WhPKM66Zwg=;
 b=jRMOHdeMueonL8Ub5KaY+euqfsXeWVx0NBXhLwH4fcMA3gLtdlkTAGjH5VtNVyWMSsoV2z
 v/g63a5XL7Yi9L5qJKW9oZwgbbpDr5T91G2zQD6haiEw8ymdY7+jEKQnI2He0MkeXf6uHn
 sEBJ//bSRSaWD/e3Vtyy214M3nqigfY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786377650;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QSvWzHR6EvF+B1sLikgDl/tQyK9rZvbM8WhPKM66Zwg=;
 b=J6jJRH1QbW3FgbqfjO0/vk4Bqt0/bpwk7EQWyUndnl1FNaJ903nfXv8T22PZy4cJZ2B4bz
 C6ndOf8pu9vuPHAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C9100779B6;
 Mon, 10 Aug 2026 16:00:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id CPLpL7L1eWquLAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 10 Aug 2026 16:00:50 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 10 Aug 2026 18:00:42 +0200
Message-ID: <20260810160048.1040517-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260810160048.1040517-1-pvorel@suse.cz>
References: <20260810160048.1040517-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 1/7] tst_kvercmp: Factor out error handling
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
Changes v1->v2:
* Use proper name for function (underscore at the end)

 lib/tst_kvercmp.c | 23 +++++++++++++++++------
 lib/tst_test.c    |  6 +-----
 2 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/lib/tst_kvercmp.c b/lib/tst_kvercmp.c
index 9e1a511aff..27b156c8bc 100644
--- a/lib/tst_kvercmp.c
+++ b/lib/tst_kvercmp.c
@@ -45,7 +45,7 @@ static char *parse_digit(const char *str, int *d)
 	return end;
 }
 
-int tst_parse_kver(const char *str_kver, int *v1, int *v2, int *v3)
+static int tst_parse_kver_(const char *str_kver, int *v1, int *v2, int *v3)
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
+	rc = tst_parse_kver_(str_kver, v1, v2, v3);
 
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
index 9c5f2617fe..a147521e9d 100644
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
