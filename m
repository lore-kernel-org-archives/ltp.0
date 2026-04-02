Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DDE1D39418
	for <ltp@archiver.kernel.org>; Thu,  2 Apr 2026 12:19:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BE5493E2F3C
	for <ltp@archiver.kernel.org>; Thu,  2 Apr 2026 14:19:28 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B9C843E2F46
 for <ltp@lists.linux.it>; Thu,  2 Apr 2026 14:14:34 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 5DF071400965
 for <ltp@lists.linux.it>; Thu,  2 Apr 2026 14:14:34 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7F1864D333
 for <ltp@lists.linux.it>; Thu,  2 Apr 2026 12:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1775132073; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gl5QEmmcwbZzkevVcZsc+3wPu0LY6R8n6gAbM93qBC4=;
 b=lAG+whiEt6TtrBQtEDo+ZUJotJ+qfJMwW3vwrI6JTsCZdlBmFx4hAs39aA1jM0oW30lVlU
 LiqFxfJzzYtTEDQjbjeGt2Gq4z58k75H+NOPIBGQ4TTUJ1iztuYn1qWl68eJ+X6jIqRrTr
 WuTKYCsR0VpL+a9yWyH2Gg4iGzBcg28=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1775132073;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gl5QEmmcwbZzkevVcZsc+3wPu0LY6R8n6gAbM93qBC4=;
 b=VtlodIyRN3FR8BORKPXjnUTDAwF0cqSQ9SA86anBmnyVRQCmfKKbT8urY3AUYy7UYrcHfV
 lGVCRLIE4PgcP2Ag==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=lAG+whiE;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=VtlodIyR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1775132073; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gl5QEmmcwbZzkevVcZsc+3wPu0LY6R8n6gAbM93qBC4=;
 b=lAG+whiEt6TtrBQtEDo+ZUJotJ+qfJMwW3vwrI6JTsCZdlBmFx4hAs39aA1jM0oW30lVlU
 LiqFxfJzzYtTEDQjbjeGt2Gq4z58k75H+NOPIBGQ4TTUJ1iztuYn1qWl68eJ+X6jIqRrTr
 WuTKYCsR0VpL+a9yWyH2Gg4iGzBcg28=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1775132073;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gl5QEmmcwbZzkevVcZsc+3wPu0LY6R8n6gAbM93qBC4=;
 b=VtlodIyRN3FR8BORKPXjnUTDAwF0cqSQ9SA86anBmnyVRQCmfKKbT8urY3AUYy7UYrcHfV
 lGVCRLIE4PgcP2Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 67BB54A0B0
 for <ltp@lists.linux.it>; Thu,  2 Apr 2026 12:14:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id N+tpGKldzmn+DgAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 02 Apr 2026 12:14:33 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  2 Apr 2026 14:13:55 +0200
Message-ID: <20260402121356.31266-17-chrubis@suse.cz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260402121356.31266-1-chrubis@suse.cz>
References: <20260402121356.31266-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_ONE(0.00)[1]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_NONE(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid, suse.cz:dkim, suse.cz:email,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 7F1864D333
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 16/17] lib: tst_test: Remove now unused needs_drivers
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

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 include/tst_test.h | 5 -----
 lib/tst_test.c     | 9 ---------
 2 files changed, 14 deletions(-)

diff --git a/include/tst_test.h b/include/tst_test.h
index ddfe9d4d6..752688c45 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -498,10 +498,6 @@ struct tst_fs {
  *                  to the test temporary directory from the LTP datafiles
  *                  directory.
  *
- * @needs_drivers: A NULL terminated array of kernel modules required to run
- *                 the test. The module has to be build in or present in order
- *                 for the test to run.
- *
  * @save_restore: A {} terminated array of /proc or /sys files that should
  *                saved at the start of the test and restored at the end. See
  *                tst_sys_conf_save() and :ref:`struct tst_path_val` for details.
@@ -605,7 +601,6 @@ struct tst_fs {
 	int (*sample)(int clk_id, long long usec);
 
 	const char *const *resource_files;
-	const char * const *needs_drivers;
 
 	const struct tst_path_val *save_restore;
 
diff --git a/lib/tst_test.c b/lib/tst_test.c
index 2d62ab164..26f6510a0 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1487,15 +1487,6 @@ static void do_setup(int argc, char *argv[])
 		}
 	}
 
-	if (tst_test->needs_drivers) {
-		const char *name;
-		int i;
-
-		for (i = 0; (name = tst_test->needs_drivers[i]); ++i)
-			if (tst_check_driver(name))
-				tst_brk(TCONF, "%s driver not available", name);
-	}
-
 	if (tst_test->mount_device)
 		tst_test->format_device = 1;
 
-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
