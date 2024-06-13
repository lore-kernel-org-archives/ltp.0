Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFEFFC41513
	for <ltp@archiver.kernel.org>; Thu, 13 Jun 2024 15:30:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 355393D0C7A
	for <ltp@archiver.kernel.org>; Thu, 13 Jun 2024 17:30:38 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 05F993D0C1A
 for <ltp@lists.linux.it>; Thu, 13 Jun 2024 17:30:07 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=mdoucha@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 27CAC140032B
 for <ltp@lists.linux.it>; Thu, 13 Jun 2024 17:30:06 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C578C3732E
 for <ltp@lists.linux.it>; Thu, 13 Jun 2024 15:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1718292604; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hFNgfoF3qirvCM7MAFIXrx93h8yHoID77BrfqCTTcqs=;
 b=WlHjuAzHKfoC5GPucP2EZ4qO7h6yBJwfaeb9Hcp2FCgjrYLufVqchqFTHaWFMTv09qEhc9
 4b0mDc0YbOF5qDJNPXpjjDxN2JOBfwEq278UOW37HWNZioGtDZftxu+5wxuH4gIALNK339
 WH13h/00UzP8n4uqjjYk52z4irHAwOc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1718292604;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hFNgfoF3qirvCM7MAFIXrx93h8yHoID77BrfqCTTcqs=;
 b=dp554r/usu7XbjMhA9cwQdXa2exieiu3Aa3zGibsjDunEEmyJQsDytya5AvjnibihYWEQ8
 BUvh7Ms0ZU2Wr5Bw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1718292604; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hFNgfoF3qirvCM7MAFIXrx93h8yHoID77BrfqCTTcqs=;
 b=WlHjuAzHKfoC5GPucP2EZ4qO7h6yBJwfaeb9Hcp2FCgjrYLufVqchqFTHaWFMTv09qEhc9
 4b0mDc0YbOF5qDJNPXpjjDxN2JOBfwEq278UOW37HWNZioGtDZftxu+5wxuH4gIALNK339
 WH13h/00UzP8n4uqjjYk52z4irHAwOc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1718292604;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hFNgfoF3qirvCM7MAFIXrx93h8yHoID77BrfqCTTcqs=;
 b=dp554r/usu7XbjMhA9cwQdXa2exieiu3Aa3zGibsjDunEEmyJQsDytya5AvjnibihYWEQ8
 BUvh7Ms0ZU2Wr5Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B391F13AA0
 for <ltp@lists.linux.it>; Thu, 13 Jun 2024 15:30:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KPelK3wQa2bmYgAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 13 Jun 2024 15:30:04 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 13 Jun 2024 17:29:05 +0200
Message-ID: <20240613152909.22000-2-mdoucha@suse.cz>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240613152909.22000-1-mdoucha@suse.cz>
References: <20240613152909.22000-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] cve-2015-3290: Check for mishandled modify_ldt()
 return value
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

The kernel intentionally prevents modify_ldt() return value sign
extension to 64bit long. Some libc versions return the value as is
instead of correctly setting errno. Check for incorrect return value
handling and rectify the problem if needed.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 testcases/cve/cve-2015-3290.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/testcases/cve/cve-2015-3290.c b/testcases/cve/cve-2015-3290.c
index 0aad26d74..171667d4a 100644
--- a/testcases/cve/cve-2015-3290.c
+++ b/testcases/cve/cve-2015-3290.c
@@ -195,13 +195,26 @@ static void set_ldt(void)
 		.useable	 = 0
 	};
 
-	TEST((int)tst_syscall(__NR_modify_ldt, 1, &data_desc,
-		sizeof(data_desc)));
-	if (TST_RET == -EINVAL) {
-		tst_brk(TCONF | TRERRNO,
+	TEST(tst_syscall(__NR_modify_ldt, 1, &data_desc, sizeof(data_desc)));
+
+	/*
+	 * The kernel intentionally casts modify_ldt() return value
+	 * to unsigned int to prevent sign extension to 64 bits. This may
+	 * result in syscall() returning the value as is instead of setting
+	 * errno and returning -1.
+	 */
+	if (TST_RET > 0 && ((int)TST_RET) < 0) {
+		tst_res(TINFO,
+			"WARNING: Libc mishandled modify_ldt() return value");
+		TST_ERR = -(int)TST_RET;
+		TST_RET = -1;
+	}
+
+	if (TST_RET == -1 && TST_ERR == EINVAL) {
+		tst_brk(TCONF | TTERRNO,
 			"modify_ldt: 16-bit data segments are probably disabled");
 	} else if (TST_RET != 0) {
-		tst_brk(TBROK | TRERRNO, "modify_ldt");
+		tst_brk(TBROK | TTERRNO, "modify_ldt");
 	}
 }
 
-- 
2.44.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
