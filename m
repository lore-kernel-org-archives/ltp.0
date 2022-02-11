Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 476E6C433EF
	for <ltp@archiver.kernel.org>; Fri, 11 Feb 2022 16:24:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 06F643C9F05
	for <ltp@archiver.kernel.org>; Fri, 11 Feb 2022 17:24:39 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C11913C0E63
 for <ltp@lists.linux.it>; Fri, 11 Feb 2022 17:24:29 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 4DEBB1A016D1
 for <ltp@lists.linux.it>; Fri, 11 Feb 2022 17:24:29 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A06261F3A2;
 Fri, 11 Feb 2022 16:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1644596668; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=UBRoEZ1UAxQuNmCxYIBT1xix/vvHyircrUoIjaieyUM=;
 b=JyYePdXXVcR+LS5lxim2JnQmR2sjKBmxcLNNum2e74wTHSyByA4lLd9ISnowhl/0KbHpSo
 O4XnJIQX+HXOkkBZaUvZy/YXXCtvYC3X+Mu0bKwH839zL0AlC1LRrGJcJHwrwsITXp7aN3
 s1CGGVNbYgrUJOBYlC6sbvVqjphKVYc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1644596668;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=UBRoEZ1UAxQuNmCxYIBT1xix/vvHyircrUoIjaieyUM=;
 b=NjI8vQWZa1bpM0L6awjOVTFm5w+bIE5asGTAJtepU1GMPrQUS4lTM2t1ZrdqUR7zSKZqoq
 2QNzxbvv3pYQYKCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6CB9D13C9A;
 Fri, 11 Feb 2022 16:24:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id cuARGLyNBmL+agAAMHmgww
 (envelope-from <blezhepekov@suse.de>); Fri, 11 Feb 2022 16:24:28 +0000
From: Bogdan Lezhepekov <blezhepekov@suse.de>
To: ltp@lists.linux.it
Date: Fri, 11 Feb 2022 18:24:26 +0200
Message-Id: <20220211162426.12284-1-blezhepekov@suse.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] syscalls/swapping01: Use .needs_kconfigs instead
 of .setup
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

needs_kconfigs is more beneficial for docparser

Signed-off-by: Bogdan Lezhepekov <blezhepekov@suse.de>
---
 testcases/kernel/mem/swapping/swapping01.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/testcases/kernel/mem/swapping/swapping01.c b/testcases/kernel/mem/swapping/swapping01.c
index 3b4f0a61a..f6133cc0d 100644
--- a/testcases/kernel/mem/swapping/swapping01.c
+++ b/testcases/kernel/mem/swapping/swapping01.c
@@ -155,18 +155,15 @@ static void check_swapping(void)
 	SAFE_WAITPID(pid, &status, 0);
 }
 
-static void setup(void)
-{
-	if (access("/proc/swaps", F_OK))
-		tst_brk(TCONF, "swap not supported by kernel");
-}
-
 static struct tst_test test = {
 	.needs_root = 1,
 	.forks_child = 1,
 	.min_mem_avail = 10,
 	.test_all = test_swapping,
-	.setup = setup,
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_SWAP=y",
+		NULL
+	},
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "50a15981a1fa"},
 		{}
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
