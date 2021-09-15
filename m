Return-Path: <SRS0=JaEE=OF=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42FDBC433EF
	for <ltp@archiver.kernel.org>; Wed, 15 Sep 2021 15:25:27 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3689360F5B
	for <ltp@archiver.kernel.org>; Wed, 15 Sep 2021 15:25:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3689360F5B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CCE003C921F
	for <ltp@archiver.kernel.org>; Wed, 15 Sep 2021 17:25:23 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0DE483C2E5D
 for <ltp@lists.linux.it>; Wed, 15 Sep 2021 17:25:13 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 06124201105
 for <ltp@lists.linux.it>; Wed, 15 Sep 2021 17:25:12 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 34B32201C7;
 Wed, 15 Sep 2021 15:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1631719512; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=p5In2H4p4HA6xJM/FP9onaFBdXJqNynEMBrNsDnTEzw=;
 b=ph8MryjHvl9JgStRu4+WXaefqKIyqJ/T8jj35r46TgxD1O7c19O8aPYK8QvOEr8fVAcbVP
 qlKMbWgStldSzCmtcjSKu99BCjz4lHm/6IoFYvHk+7JVIjf9YgLlvczCy4NAdYP4R4VUMX
 IMqdRF8IR0/p2PAiZNyjDw0joZFQio4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1631719512;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=p5In2H4p4HA6xJM/FP9onaFBdXJqNynEMBrNsDnTEzw=;
 b=CV+OSDGVF9qY8NYDiHiH0BhuPsHg1VfrX9GuXlrRFveodGXRCqJ38Mc6YSpFE9qziupgBk
 A7xwHq//RBDmrmAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0352713C37;
 Wed, 15 Sep 2021 15:25:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id mlnLAFgQQmEtIAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 15 Sep 2021 15:25:12 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 15 Sep 2021 17:25:33 +0200
Message-ID: <20210915152533.20902-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/shmctl05: Remove shm segment only when
 created
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
Message-ID: <20210915152533.nMZpqn1NaFu5_IrUMgZk0ItmMAvwHbWM7Mm7IwGke7U@z>

We cannot remove the shm segment unconditionally. On kernels without
SysV IPC support compiled in the test fails with following:

shmctl05.c:50: TCONF: syscall(396) __NR_shmctl not supported
shmctl05.c:96: TWARN: shmget(61455, 4096, 0) failed: ENOENT (2)
shmctl05.c:97: TWARN: shmctl(-1, 0, (nil)) failed: EINVAL (22)

Fixes: 48d382e8daf2 (syscalls/shmctl05.c: Fix leak of shared memory segment)
Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
CC: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 testcases/kernel/syscalls/ipc/shmctl/shmctl05.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl05.c b/testcases/kernel/syscalls/ipc/shmctl/shmctl05.c
index ea7eef6f1..8569322dc 100644
--- a/testcases/kernel/syscalls/ipc/shmctl/shmctl05.c
+++ b/testcases/kernel/syscalls/ipc/shmctl/shmctl05.c
@@ -92,8 +92,16 @@ static void do_test(void)
 static void cleanup(void)
 {
 	int id;
+
 	tst_fzsync_pair_cleanup(&fzsync_pair);
-	id = SAFE_SHMGET(0xF00F, 4096, 0);
+
+	id = shmget(0xF00F, 4096, 0);
+	if (id == -1) {
+		if (errno != ENOENT)
+			tst_res(TWARN | TERRNO, "shmget()");
+		return;
+	}
+
 	SAFE_SHMCTL(id, IPC_RMID, NULL);
 }
 
-- 
2.32.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
