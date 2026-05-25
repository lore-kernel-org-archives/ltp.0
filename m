Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B75DCD5BBF
	for <ltp@archiver.kernel.org>; Mon, 25 May 2026 07:39:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 96E823E23EA
	for <ltp@archiver.kernel.org>; Mon, 25 May 2026 09:39:44 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 75AC73C72EC
 for <ltp@lists.linux.it>; Mon, 25 May 2026 09:39:26 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 141B71400346
 for <ltp@lists.linux.it>; Mon, 25 May 2026 09:39:25 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B483764A73;
 Mon, 25 May 2026 07:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1779694764; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=alHE5JUt0U0sYwYTG/18u+rZE0004yKMVd63MumsDUw=;
 b=RYbwQ7siITF4beXOCxcAYZ19UWUZJnl07sgsuaw2QtRNk6+DjammnsHp7O5DMiNesbRqDB
 r+OGB4K4h9DtSLyLKDfBHNOJ1FngfpZR1kenOZsMnypHXbzjd5KG71fNgVwGCz8TVLoKXT
 KlX4RF4bb8zOjepVSOqTkvT/UYvAQrk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1779694764;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=alHE5JUt0U0sYwYTG/18u+rZE0004yKMVd63MumsDUw=;
 b=ezlHewWKNUUkqfucw97zXLNKHmWfQXP+euOxLrZPxQpqxIw3Vfe/8UVef6qOAX+TdL9hSq
 2nYdaxt73kLf9XDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1779694764; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=alHE5JUt0U0sYwYTG/18u+rZE0004yKMVd63MumsDUw=;
 b=RYbwQ7siITF4beXOCxcAYZ19UWUZJnl07sgsuaw2QtRNk6+DjammnsHp7O5DMiNesbRqDB
 r+OGB4K4h9DtSLyLKDfBHNOJ1FngfpZR1kenOZsMnypHXbzjd5KG71fNgVwGCz8TVLoKXT
 KlX4RF4bb8zOjepVSOqTkvT/UYvAQrk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1779694764;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=alHE5JUt0U0sYwYTG/18u+rZE0004yKMVd63MumsDUw=;
 b=ezlHewWKNUUkqfucw97zXLNKHmWfQXP+euOxLrZPxQpqxIw3Vfe/8UVef6qOAX+TdL9hSq
 2nYdaxt73kLf9XDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 89B9059B1E;
 Mon, 25 May 2026 07:39:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6KBuIKz8E2roIQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 25 May 2026 07:39:24 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 25 May 2026 09:39:21 +0200
Message-ID: <20260525073921.172426-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] min_free_kbytes: TCONF on errno ENOMEM, add break
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

On machine with 16 GM RAM and ~6 GB swap fork() fails on ENOMEM.
Treat that as TCONF.

While at it, add missing break in case.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
I guess we cannot fix this with .min_mem_avail, because it depends also
on available swap.

Also, my investigation was triggered by random failures since this fix
was merged:
355124aea9 ("mem/tunable:min_free_kbytes: fix disabled check_monitor flag") [1]

Kind regards,
Petr

[1] https://github.com/linux-test-project/ltp/commit/355124aea99c7c7d40140c969a53ed892421dee9

 testcases/kernel/mem/tunable/min_free_kbytes.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/mem/tunable/min_free_kbytes.c b/testcases/kernel/mem/tunable/min_free_kbytes.c
index a62e4ae9d9..45a3bfc8b1 100644
--- a/testcases/kernel/mem/tunable/min_free_kbytes.c
+++ b/testcases/kernel/mem/tunable/min_free_kbytes.c
@@ -108,7 +108,8 @@ static void test_tune(unsigned long overcommit_policy)
 		fflush(stdout);
 		switch (pid[i] = fork()) {
 		case -1:
-			tst_brk(TBROK | TERRNO, "fork");
+			tst_brk((errno == ENOMEM ? TCONF : TBROK) | TERRNO, "fork");
+			break;
 		case 0:
 			ret = eatup_mem(overcommit_policy);
 			exit(ret);
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
