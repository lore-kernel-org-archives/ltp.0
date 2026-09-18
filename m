Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79672C982DA
	for <ltp@archiver.kernel.org>; Fri, 18 Sep 2026 12:52:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0C1493EA161
	for <ltp@archiver.kernel.org>; Fri, 18 Sep 2026 14:51:59 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BA0053EA34F
 for <ltp@lists.linux.it>; Fri, 18 Sep 2026 14:51:36 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 39C3710009C7
 for <ltp@lists.linux.it>; Fri, 18 Sep 2026 14:51:36 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 80B3F1F7C8;
 Fri, 18 Sep 2026 12:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789735891; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E0qbEd1sQ7lFRM6hZgyJutusccUIgF7zcd2uhvAz/QA=;
 b=AkM0fkF0BSBT1dD/Lrpuz0dbXZhL8OWJgrFUz1bRqiqDZPtl7bVpxKDPfo+qA6GMg+Hf8G
 nRSPq8LBZW6uJLXidVuvtIrmiYFz2Okcz9Fk6OngaB0bLk5FnMtVChvoPQiVspXFtUzGPI
 0a7cfMK5tGI2w5EVUo/dN2rS+0o7KQE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789735891;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E0qbEd1sQ7lFRM6hZgyJutusccUIgF7zcd2uhvAz/QA=;
 b=NfbSPgURsaTh8ZakkPhV5+rVtSjCzi1XfS8yCGCK27iwXhPttjYTsrVsGqk018iaUGDZqX
 9zao4cXNOH7Vp/BQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789735887; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E0qbEd1sQ7lFRM6hZgyJutusccUIgF7zcd2uhvAz/QA=;
 b=VG4/UkWLMnQBX+QLcu5fMekovwLNAG2/FwEL6vaI/2NlPL9r2HXtlSUGOL/PhNVCC3RKYi
 kGzIGV1m/cf8vnxfI4BqzaOneRLm3r896jlxmYM7crWNbIcqDqVnQn3X1DQjJe8a4W1sGR
 KsNtEa4aW+83MOfgMKarpu6CRfieKDA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789735887;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E0qbEd1sQ7lFRM6hZgyJutusccUIgF7zcd2uhvAz/QA=;
 b=t23EWeGvV+rd+N3aezX+s1t/+nns+Ruvc0olf9IU92+nGGC63mDTP42Tw9ptD33tQ+5NQy
 jaao6BZx5YxX45DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F2190133CF;
 Fri, 18 Sep 2026 12:51:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ezKRG5EzrWr4FAAAD6G6ig:T2
 (envelope-from <pvorel@suse.cz>); Fri, 18 Sep 2026 12:51:26 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 18 Sep 2026 14:50:20 +0200
Message-ID: <20260918125021.1939455-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918125021.1939455-1-pvorel@suse.cz>
References: <20260918125021.1939455-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-6.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-0.997]; MIME_GOOD(-0.10)[text/plain];
 RCVD_COUNT_TWO(0.00)[2]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCPT_COUNT_SEVEN(0.00)[8];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] tst_assert: Use 'long long' to fix 32bit compat
 mode truncation
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

Using 'long long' in tst_assert_ulong() correctly verifies values on
32bit compat mode truncation.

This fixes failure of shmctl03.c on /proc/sys/kernel/shmall on 32bit
(potentially on other sysfs files).

Reported-by: Wei Gao <wegao@suse.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
[ pvorel: separate into its own commit, write the commit message ]
Co-developed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 lib/tst_assert.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/lib/tst_assert.c b/lib/tst_assert.c
index b68bd5d397..5a4896ac52 100644
--- a/lib/tst_assert.c
+++ b/lib/tst_assert.c
@@ -25,16 +25,17 @@ void tst_assert_int(const char *file, const int lineno, const char *path, int va
 
 void tst_assert_ulong(const char *file, const int lineno, const char *path, unsigned long val)
 {
-	unsigned long sys_val;
+	unsigned long long sys_val;
 
-	safe_file_scanf(file, lineno, NULL, path, "%lu", &sys_val);
+	safe_file_scanf(file, lineno, NULL, path, "%llu", &sys_val);
 
-	if (val == sys_val) {
+	if (val == (unsigned long)sys_val) {
 		tst_res_(file, lineno, TPASS, "%s = %lu", path, val);
 		return;
 	}
 
-	tst_res_(file, lineno, TFAIL, "%s != %lu got %lu", path, val, sys_val);
+	tst_res_(file, lineno, TFAIL, "%s != %lu got %lu",
+		path, val, (unsigned long)sys_val);
 }
 
 void tst_assert_file_int(const char *file, const int lineno, const char *path, const char *prefix, int val)
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
