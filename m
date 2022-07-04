Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC77BC43334
	for <ltp@archiver.kernel.org>; Mon,  4 Jul 2022 11:45:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 39CEB3CA017
	for <ltp@archiver.kernel.org>; Mon,  4 Jul 2022 13:45:35 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C06713C9839
 for <ltp@lists.linux.it>; Mon,  4 Jul 2022 13:45:25 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 28CFE2001CD
 for <ltp@lists.linux.it>; Mon,  4 Jul 2022 13:45:24 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 17107224EB
 for <ltp@lists.linux.it>; Mon,  4 Jul 2022 11:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1656935124; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=lv1HrHg9ecFE9uElGu6tHvz/E5ODGLZ7O/nmIjpfAgM=;
 b=HqsEXwMnvILYGDanWUW0/7vJljAKKG/s/bOfj4Z55DFwTjJQ/jp5XFbLpU/lEsVF+zr0wG
 jHIrJ6vaoF4bKl9ROqkRnXeI6d15uaYredD4ROooMHTiXrK+0VgmDHNnIfl7K6M29a5jIA
 8BIvSGtrlQQ4PfmoasuPvtwj4N9/2I8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1656935124;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=lv1HrHg9ecFE9uElGu6tHvz/E5ODGLZ7O/nmIjpfAgM=;
 b=J/rDDymkWT18Judd2FIroa34HcITjjdrZhMDszimMNi3s7j5FOXXn7Wf99ZYeon2SCNe76
 ymmqwQdObve9gzAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 062CC13451
 for <ltp@lists.linux.it>; Mon,  4 Jul 2022 11:45:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id HJeXANTSwmJpGQAAMHmgww
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Mon, 04 Jul 2022 11:45:24 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Mon,  4 Jul 2022 13:45:23 +0200
Message-Id: <20220704114523.10409-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] msgget03: Set custom queue limit
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

The runtime limit patchset has reduced default test timeout to 30 seconds
which is not enough for msgget03 on some archs. Set custom queue count
limit to make the test faster.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 testcases/kernel/syscalls/ipc/msgget/msgget03.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/ipc/msgget/msgget03.c b/testcases/kernel/syscalls/ipc/msgget/msgget03.c
index 711886e17..2257ae0f9 100644
--- a/testcases/kernel/syscalls/ipc/msgget/msgget03.c
+++ b/testcases/kernel/syscalls/ipc/msgget/msgget03.c
@@ -41,7 +41,8 @@ static void setup(void)
 	tst_res(TINFO, "Current environment %d message queues are already in use",
 		used_cnt);
 
-	SAFE_FILE_SCANF("/proc/sys/kernel/msgmni", "%i", &maxmsgs);
+	maxmsgs = used_cnt + 32;
+	SAFE_FILE_PRINTF("/proc/sys/kernel/msgmni", "%i", maxmsgs);
 
 	queues = SAFE_MALLOC((maxmsgs - used_cnt) * sizeof(int));
 
@@ -73,5 +74,9 @@ static struct tst_test test = {
 	.needs_tmpdir = 1,
 	.setup = setup,
 	.cleanup = cleanup,
-	.test_all = verify_msgget
+	.test_all = verify_msgget,
+	.save_restore = (const struct tst_path_val[]){
+		{"/proc/sys/kernel/msgmni", NULL},
+		{}
+	}
 };
-- 
2.36.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
