Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD675CD3435
	for <ltp@archiver.kernel.org>; Tue,  3 Sep 2024 14:04:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D43BF3C4FCF
	for <ltp@archiver.kernel.org>; Tue,  3 Sep 2024 16:04:03 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9FF2E3C4B95
 for <ltp@lists.linux.it>; Tue,  3 Sep 2024 16:03:47 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 010846002F9
 for <ltp@lists.linux.it>; Tue,  3 Sep 2024 16:03:46 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 417FF1F385;
 Tue,  3 Sep 2024 14:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1725372225; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=h7w5iHwwc4Mr6Ux5C/QF1+x5laEO1NnJdTmf0Gy/rnk=;
 b=u3wbodBUk+zZ9rUDJamGvSiydJr0BKPGPPGGh44VqSHZKH7GxsTict4usRF76kGVGyjtTs
 88gMB2D4rmmaYAyDG+IIi55UcNDntzJ4Okwovgrvp8K3j5mADTlEOAeStu/3lkxgNBLB1l
 mAnrR0V7HH8gQ1qkVRIs4s7bid+Bi0Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1725372225;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=h7w5iHwwc4Mr6Ux5C/QF1+x5laEO1NnJdTmf0Gy/rnk=;
 b=bujLbQS9gWyYnMJi1/sZTJ7NvRrHp3as/p9XETrakY1CZWsOBWgEvQxX+hoXIzqKpgxnlu
 pZFKKUl5ssA2J4Bg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1725372225; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=h7w5iHwwc4Mr6Ux5C/QF1+x5laEO1NnJdTmf0Gy/rnk=;
 b=u3wbodBUk+zZ9rUDJamGvSiydJr0BKPGPPGGh44VqSHZKH7GxsTict4usRF76kGVGyjtTs
 88gMB2D4rmmaYAyDG+IIi55UcNDntzJ4Okwovgrvp8K3j5mADTlEOAeStu/3lkxgNBLB1l
 mAnrR0V7HH8gQ1qkVRIs4s7bid+Bi0Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1725372225;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=h7w5iHwwc4Mr6Ux5C/QF1+x5laEO1NnJdTmf0Gy/rnk=;
 b=bujLbQS9gWyYnMJi1/sZTJ7NvRrHp3as/p9XETrakY1CZWsOBWgEvQxX+hoXIzqKpgxnlu
 pZFKKUl5ssA2J4Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 206E113A52;
 Tue,  3 Sep 2024 14:03:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4/aGBkEX12YLUwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 03 Sep 2024 14:03:45 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue,  3 Sep 2024 16:03:26 +0200
Message-ID: <20240903140326.773060-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 ARC_NA(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/1] swapoff01: Define max_runtime 45s
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

Test run mostly below 1 sec per filesystem, only NTFS is very slow
~ 10-15 sec depending on architecture.

Also this is the only tests in syscalls which fails on due timeout on
emulated risc-v with LTP_TIMEOUT_MUL=2,LTP_RUNTIME_MUL=2 (with the
default 30s runtime => 1 min due LTP_RUNTIME_MUL=2).

Therefore set runtime to 45s, that should be enough even for slow
risc-v and not that high for other archs.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Changes v1->v2:
* 60 => 45

 testcases/kernel/syscalls/swapoff/swapoff01.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/syscalls/swapoff/swapoff01.c b/testcases/kernel/syscalls/swapoff/swapoff01.c
index 314630267d..ef75c92de0 100644
--- a/testcases/kernel/syscalls/swapoff/swapoff01.c
+++ b/testcases/kernel/syscalls/swapoff/swapoff01.c
@@ -53,5 +53,6 @@ static struct tst_test test = {
 	.all_filesystems = 1,
 	.needs_root = 1,
 	.test_all = verify_swapoff,
+	.max_runtime = 45,
 	.setup = setup
 };
-- 
2.45.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
