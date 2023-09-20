Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E373CE79AC
	for <ltp@archiver.kernel.org>; Wed, 20 Sep 2023 07:31:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 307FD3CDEBE
	for <ltp@archiver.kernel.org>; Wed, 20 Sep 2023 09:31:23 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 64A853CA3D7
 for <ltp@lists.linux.it>; Wed, 20 Sep 2023 09:31:12 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id ABC6A10004AA
 for <ltp@lists.linux.it>; Wed, 20 Sep 2023 09:31:11 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BF29A1F390;
 Wed, 20 Sep 2023 07:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1695195070; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=fOO8JsiQ0uh61rwa3zaf9eM2cUFgNQSPt7cL1X61XYI=;
 b=tZinCoJSsXmdbuWk7WWvaCrola7XZ4ZWvQx5kSdxBKfDojJKo7LPZcBwRD7gLG+M/IOwGU
 dHoOUh4ThrK+XhbCw1S7JBdLlTk3EQ7o1CYcaQSimSCqB6qwJvQg5VRaIoCC0W93VgH8cL
 knEYHSR7DJUokbHrKCm2zfc3Ead/1Gs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1695195070;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=fOO8JsiQ0uh61rwa3zaf9eM2cUFgNQSPt7cL1X61XYI=;
 b=j+y34Sk1MGMJ+vvpOGfg2FmgN+cPL+R/eB6YX3skg9wz4bcB70l2tEEDaScmecrIQ7cuEm
 7g/weoe+CTod0dBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7D9181333E;
 Wed, 20 Sep 2023 07:31:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id MWGoG76fCmVMNAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 20 Sep 2023 07:31:10 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 20 Sep 2023 09:31:07 +0200
Message-Id: <20230920073107.277212-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PUSHED][PATCH 1/1] mqns_04.c: Remove useless tag needs_tmpdir
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

Test uses .needs_checkpoints = 1, which implies it.
Reported by docparse generation.

Fixes: 0733461e7 ("Refactor mqns_04 using new LTP API")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/containers/mqns/mqns_04.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/testcases/kernel/containers/mqns/mqns_04.c b/testcases/kernel/containers/mqns/mqns_04.c
index 24aad4273..2d943e1b6 100644
--- a/testcases/kernel/containers/mqns/mqns_04.c
+++ b/testcases/kernel/containers/mqns/mqns_04.c
@@ -135,7 +135,6 @@ static struct tst_test test = {
 	.cleanup = cleanup,
 	.needs_root = 1,
 	.forks_child = 1,
-	.needs_tmpdir = 1,
 	.needs_checkpoints = 1,
 	.options = (struct tst_option[]) {
 		{ "m:", &str_op, "Child process isolation <clone|unshare>" },
-- 
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
