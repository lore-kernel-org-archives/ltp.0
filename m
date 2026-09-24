Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 947FBC9830E
	for <ltp@archiver.kernel.org>; Thu, 24 Sep 2026 11:25:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CC8283E655B
	for <ltp@archiver.kernel.org>; Thu, 24 Sep 2026 13:25:51 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7C7A03E657B
 for <ltp@lists.linux.it>; Thu, 24 Sep 2026 13:25:26 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D06A81A00CAF
 for <ltp@lists.linux.it>; Thu, 24 Sep 2026 13:25:25 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BE6081FF06;
 Thu, 24 Sep 2026 11:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790249120; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E0qbEd1sQ7lFRM6hZgyJutusccUIgF7zcd2uhvAz/QA=;
 b=JfkEHEWre1Yj1cZjNjzcaz1o5lX74VtXU0ZQ79VjP4rAkFF565pF3bUS6w4L09YT0gJdpO
 YmwcQNgFPppGyXtv040HVVTbo5/oLap0d8bPLR9/XSHn2M7f3dpVU02DYASa6BjIB9umEu
 12+0UI5SHKGp2pKVLHRsxQWmXDiBoIk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790249120;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E0qbEd1sQ7lFRM6hZgyJutusccUIgF7zcd2uhvAz/QA=;
 b=cmcD1Q2hmQNtCe5SB2LH6Pqs7K5f0UD7vZu79oEvGkbzF30uB1JuWcXfhgfWLTtgn6Nvc+
 gOwZKdB7WuHJZJAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790249116; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E0qbEd1sQ7lFRM6hZgyJutusccUIgF7zcd2uhvAz/QA=;
 b=hYb/1ugTLNbTfPVggcduVfWY/W8U3tzi25wH0rJxkybKGBgDEyt8Bg/Z1FCizlMvzJTTEz
 NpvL+KtBViDr6epjag9cfdKEiojCug7t1OkJLGCErnBhJXjo4hZkuXX+qKIdPRH/CBdyCG
 YiXd+KkgewOJ8V6wBFycI6YTjGcoe+Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790249116;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E0qbEd1sQ7lFRM6hZgyJutusccUIgF7zcd2uhvAz/QA=;
 b=4LdTby8KAJLhdeKlqcQFyGP48A1qOxta5xLwmYVZKENzY9x7nQjnhW6rPtp5vOfEcwYf9a
 Fgclk0bJLvGr/+BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5D8161366F;
 Thu, 24 Sep 2026 11:25:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id y/X9L5sItWoLIQAAD6G6ig:T2
 (envelope-from <pvorel@suse.cz>); Thu, 24 Sep 2026 11:25:16 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 24 Sep 2026 13:25:12 +0200
Message-ID: <20260924112514.2375626-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924112514.2375626-1-pvorel@suse.cz>
References: <20260924112514.2375626-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-6.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-0.997]; MIME_GOOD(-0.10)[text/plain];
 RCVD_COUNT_TWO(0.00)[2]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCPT_COUNT_SEVEN(0.00)[7];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:mid,suse.cz:email,imap1.dmz-prg2.suse.org:helo];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/3] tst_assert: Use 'long long' to fix 32bit
 compat mode truncation
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
