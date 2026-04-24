Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F044FED3C3
	for <ltp@archiver.kernel.org>; Fri, 24 Apr 2026 13:26:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DDFCF3E5355
	for <ltp@archiver.kernel.org>; Fri, 24 Apr 2026 15:26:28 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 55CE63E257E
 for <ltp@lists.linux.it>; Fri, 24 Apr 2026 15:26:09 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id ED06A1000D2F
 for <ltp@lists.linux.it>; Fri, 24 Apr 2026 15:26:08 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AC7525BDAD
 for <ltp@lists.linux.it>; Fri, 24 Apr 2026 13:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1777037167; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=tFncOvqwtYGM7/VYDkAbsqrox4jd3donDflrr8YZUvQ=;
 b=zI1l+4bOZHUYwK9DpTyyZfRvUn/b+2lokkkroRfSsfMQKgDwm/qj32TsogLwAw6ufsL7h/
 YR8Ynlytxux2TcVuVY14XfQ4gH0Rdx36DsCvke2xsDkuWhk0UOoINrXdN6+Giy9JPWEEr4
 g1E2qLPb1G5tCbCLw31jJ6K9ECU1NQI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1777037167;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=tFncOvqwtYGM7/VYDkAbsqrox4jd3donDflrr8YZUvQ=;
 b=GvesySnJuVJPMw0A2HPcw099uUY1uFg1k4cgcS/8FR6DjXLsbW+ycsu+QbJcb7Ch459Q4m
 JQIFQ+PGy+eatMAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1777037167; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=tFncOvqwtYGM7/VYDkAbsqrox4jd3donDflrr8YZUvQ=;
 b=zI1l+4bOZHUYwK9DpTyyZfRvUn/b+2lokkkroRfSsfMQKgDwm/qj32TsogLwAw6ufsL7h/
 YR8Ynlytxux2TcVuVY14XfQ4gH0Rdx36DsCvke2xsDkuWhk0UOoINrXdN6+Giy9JPWEEr4
 g1E2qLPb1G5tCbCLw31jJ6K9ECU1NQI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1777037167;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=tFncOvqwtYGM7/VYDkAbsqrox4jd3donDflrr8YZUvQ=;
 b=GvesySnJuVJPMw0A2HPcw099uUY1uFg1k4cgcS/8FR6DjXLsbW+ycsu+QbJcb7Ch459Q4m
 JQIFQ+PGy+eatMAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A53C2593A4
 for <ltp@lists.linux.it>; Fri, 24 Apr 2026 13:26:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 5nogKG9v62lZMwAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Fri, 24 Apr 2026 13:26:07 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 24 Apr 2026 15:26:05 +0200
Message-ID: <20260424132606.61550-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] pty03: Calculate test case count from test case array
 length
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

Use ARRAY_SIZE() to calculate test case count so that the number
does not need to be adjusted manually if anyone adds or removes
another line discipline to the list.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

The actual test cases start at ldiscs[1]. ldiscs[0] is a special value
for initializing the file descriptor before setting the real line
discipline.

 testcases/kernel/pty/pty03.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/pty/pty03.c b/testcases/kernel/pty/pty03.c
index 99c659264..d4da24265 100644
--- a/testcases/kernel/pty/pty03.c
+++ b/testcases/kernel/pty/pty03.c
@@ -146,7 +146,7 @@ static void cleanup(void)
 
 static struct tst_test test = {
 	.test = do_test,
-	.tcnt = 9,
+	.tcnt = ARRAY_SIZE(ldiscs) - 1,
 	.setup = setup,
 	.cleanup = cleanup,
 	.needs_root = 1,
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
