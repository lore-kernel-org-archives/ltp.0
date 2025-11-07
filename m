Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 238A9CCF9F8
	for <ltp@archiver.kernel.org>; Fri,  7 Nov 2025 10:31:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BE03B3CEF95
	for <ltp@archiver.kernel.org>; Fri,  7 Nov 2025 11:31:26 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E55E73CEFAD
 for <ltp@lists.linux.it>; Fri,  7 Nov 2025 11:29:55 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5FFF8600F08
 for <ltp@lists.linux.it>; Fri,  7 Nov 2025 11:29:55 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 738F31F45B;
 Fri,  7 Nov 2025 10:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1762511384; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vzQ1blI7FWOqomm7ei0RckwJeSRm9U96y55XxRMB04w=;
 b=ioJiOOnD2KMqMxCYrDdHZZyFqjxGVgWqc5d+3GPkL1B3bBnHqNbWmJuuHvAtmp49rwCl3U
 1FgeftA1h9aoOWsYUAtVh/sPfrPXTt68gSwfYECCsRnjevY/IW/sX2TRzQwCJApbXyEs+p
 +JPekl1q7wnUxRbjcCEvbZhjrg4c8Xs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1762511384;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vzQ1blI7FWOqomm7ei0RckwJeSRm9U96y55XxRMB04w=;
 b=TyYbXY92gOxyARiG4/bww+YXd9eQ8dEaFVtdaHocfwAyYwJiNYbU7be33XS5RvWUly6eeo
 UlqkbN5JyQIZdODA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1762511384; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vzQ1blI7FWOqomm7ei0RckwJeSRm9U96y55XxRMB04w=;
 b=ioJiOOnD2KMqMxCYrDdHZZyFqjxGVgWqc5d+3GPkL1B3bBnHqNbWmJuuHvAtmp49rwCl3U
 1FgeftA1h9aoOWsYUAtVh/sPfrPXTt68gSwfYECCsRnjevY/IW/sX2TRzQwCJApbXyEs+p
 +JPekl1q7wnUxRbjcCEvbZhjrg4c8Xs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1762511384;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vzQ1blI7FWOqomm7ei0RckwJeSRm9U96y55XxRMB04w=;
 b=TyYbXY92gOxyARiG4/bww+YXd9eQ8dEaFVtdaHocfwAyYwJiNYbU7be33XS5RvWUly6eeo
 UlqkbN5JyQIZdODA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2FD1E132DD;
 Fri,  7 Nov 2025 10:29:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id GEu6BRjKDWlKQQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 07 Nov 2025 10:29:44 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri,  7 Nov 2025 11:29:35 +0100
Message-ID: <20251107102939.1111074-5-pvorel@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251107102939.1111074-1-pvorel@suse.cz>
References: <20251107102939.1111074-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-6.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_CONTAINS_FROM(1.00)[]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-0.986]; MIME_GOOD(-0.10)[text/plain];
 RCVD_COUNT_TWO(0.00)[2]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 4/8] tst_test.c: Change results_equal() return type to
 bool
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

Also add doc (don't use kerneldoc as this is a internal function which
does not need to be in LTP online doc).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 lib/tst_test.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index 1725844b54..449ddb6ba5 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1086,21 +1086,26 @@ static bool check_kver(const char *min_kver, const int brk_nosupp)
 	return true;
 }
 
-static int results_equal(struct results *a, struct results *b)
+/*
+ * Checks if the struct results values are equal.
+ *
+ * return: true if results are equal, false otherwise.
+ */
+static bool results_equal(struct results *a, struct results *b)
 {
 	if (a->passed != b->passed)
-		return 0;
+		return false;
 
 	if (a->failed != b->failed)
-		return 0;
+		return false;
 
 	if (a->skipped != b->skipped)
-		return 0;
+		return false;
 
 	if (a->broken != b->broken)
-		return 0;
+		return false;
 
-	return 1;
+	return true;
 }
 
 static int needs_tmpdir(void)
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
