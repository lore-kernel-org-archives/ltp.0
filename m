Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7152C83F2C
	for <ltp@archiver.kernel.org>; Mon,  4 Sep 2023 12:54:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9DA643CB911
	for <ltp@archiver.kernel.org>; Mon,  4 Sep 2023 14:54:47 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 097483CB7B8
 for <ltp@lists.linux.it>; Mon,  4 Sep 2023 14:54:36 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 2A8CF200DBC
 for <ltp@lists.linux.it>; Mon,  4 Sep 2023 14:54:35 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 31E5C1F74B;
 Mon,  4 Sep 2023 12:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1693832075; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=CALLfk9xsBWjQFN41lADZ3MnfUEPCQC+fl/cGH8N9TY=;
 b=LIt+Kd3TOjKzWF7cZ0db1QBvXRM3uVoO7MxLmE9sB7K/xu4yMUd+siOrtT00Xh7ECvYbLo
 pLELdZEPghPSOyDsR1ZvRuZZcXjdKJ9UA1kn1lEp4ggVxLheWYWQ2InNDkJYqQsBILvYmY
 3nwqJNS88KoW4iX5i4eXncDtRxh2AnY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1693832075;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=CALLfk9xsBWjQFN41lADZ3MnfUEPCQC+fl/cGH8N9TY=;
 b=bLDKi5Xr/1Gb80lekcYb+1W/DzyptF4DWrnkbduuQbz01VOb0FgiyaJkbjZp99kuZeTw8l
 b8ZEOTwfFuPvE+AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AA07513585;
 Mon,  4 Sep 2023 12:54:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 06dMGIjT9WTveAAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Mon, 04 Sep 2023 12:54:32 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Mon,  4 Sep 2023 14:54:24 +0200
Message-Id: <20230904125424.4011-1-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] Check swap availability in process_madvise01
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

From: Andrea Cervesato <andrea.cervesato@suse.com>

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 .../kernel/syscalls/process_madvise/process_madvise01.c      | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/testcases/kernel/syscalls/process_madvise/process_madvise01.c b/testcases/kernel/syscalls/process_madvise/process_madvise01.c
index 207dc028e..322b4cf60 100644
--- a/testcases/kernel/syscalls/process_madvise/process_madvise01.c
+++ b/testcases/kernel/syscalls/process_madvise/process_madvise01.c
@@ -123,4 +123,9 @@ static struct tst_test test = {
 	.min_kver = "5.10",
 	.needs_checkpoints = 1,
 	.needs_root = 1,
+	.min_swap_avail = MEM_CHILD / TST_KB,
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_SWAP=y",
+		NULL
+	},
 };
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
