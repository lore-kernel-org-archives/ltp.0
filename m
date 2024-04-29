Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8905FC4345F
	for <ltp@archiver.kernel.org>; Mon, 29 Apr 2024 19:40:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D17B03C8952
	for <ltp@archiver.kernel.org>; Mon, 29 Apr 2024 21:40:40 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1A0803C0326
 for <ltp@lists.linux.it>; Mon, 29 Apr 2024 21:40:25 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=akumar@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 154631400271
 for <ltp@lists.linux.it>; Mon, 29 Apr 2024 21:40:24 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4E7911F766
 for <ltp@lists.linux.it>; Mon, 29 Apr 2024 19:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1714419622; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=idiaMebJrPiQXIXIIsZUhr5/caZcpCRpoD83cw4bM9k=;
 b=o7YY0LfxS7FaUB/s5KHxsg2K/SWrFEovbaeSdSNIgZICBdjk4N+GW6KIHMORIrVxqTbijF
 23pcTu4+hcx+ggwftJ3vTo/UtbP9tAbcGub05ZrETQuB83QBE1vkYE3wk7gD9nspFtIk+1
 dQ8fRdXKI1nSu/0ygKoy7c4vOBXwEQM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1714419622;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=idiaMebJrPiQXIXIIsZUhr5/caZcpCRpoD83cw4bM9k=;
 b=c5xCNShxZFnLtrRaM3Xwy/wmoiO+yB5rBJX6kKmZjCPp8OvljESEQPpg+zwgTszF2hYgIx
 1c+d3HDNfz6yjcCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1714419622; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=idiaMebJrPiQXIXIIsZUhr5/caZcpCRpoD83cw4bM9k=;
 b=o7YY0LfxS7FaUB/s5KHxsg2K/SWrFEovbaeSdSNIgZICBdjk4N+GW6KIHMORIrVxqTbijF
 23pcTu4+hcx+ggwftJ3vTo/UtbP9tAbcGub05ZrETQuB83QBE1vkYE3wk7gD9nspFtIk+1
 dQ8fRdXKI1nSu/0ygKoy7c4vOBXwEQM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1714419622;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=idiaMebJrPiQXIXIIsZUhr5/caZcpCRpoD83cw4bM9k=;
 b=c5xCNShxZFnLtrRaM3Xwy/wmoiO+yB5rBJX6kKmZjCPp8OvljESEQPpg+zwgTszF2hYgIx
 1c+d3HDNfz6yjcCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 41837138A7
 for <ltp@lists.linux.it>; Mon, 29 Apr 2024 19:40:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id IBrlD6b3L2bebQAAD6G6ig
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Mon, 29 Apr 2024 19:40:22 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Mon, 29 Apr 2024 21:40:20 +0200
Message-ID: <20240429194021.5523-1-akumar@suse.de>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 MIME_GOOD(-0.10)[text/plain]; TO_DN_NONE(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 ARC_NA(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email, imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/mmap06: use macro TST_EXP_FAIL_PTR_VOID()
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

Signed-off-by: Avinesh Kumar <akumar@suse.de>
---
 testcases/kernel/syscalls/mmap/mmap06.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/testcases/kernel/syscalls/mmap/mmap06.c b/testcases/kernel/syscalls/mmap/mmap06.c
index 615743fa7..02c186a3a 100644
--- a/testcases/kernel/syscalls/mmap/mmap06.c
+++ b/testcases/kernel/syscalls/mmap/mmap06.c
@@ -56,16 +56,7 @@ static void run(unsigned int i)
 {
 	struct tcase *tc = &tcases[i];
 
-	TESTPTR(mmap(NULL, tc->length, tc->prot, tc->flags, fd, 0));
-
-	if (TST_RET_PTR != MAP_FAILED) {
-		tst_res(TFAIL, "mmap() was successful unexpectedly");
-		SAFE_MUNMAP(TST_RET_PTR, MMAPSIZE);
-	} else if (TST_ERR == tc->exp_errno) {
-		tst_res(TPASS | TERRNO, "mmap() failed with");
-	} else {
-		tst_res(TFAIL | TERRNO, "mmap() failed unexpectedly");
-	}
+	TST_EXP_FAIL_PTR_VOID(mmap(NULL, tc->length, tc->prot, tc->flags, fd, 0), tc->exp_errno);
 }
 
 static void cleanup(void)
-- 
2.44.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
