Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7C7EC77B7A
	for <ltp@archiver.kernel.org>; Thu, 18 May 2023 11:32:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 29C443CD436
	for <ltp@archiver.kernel.org>; Thu, 18 May 2023 13:32:32 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BA0E33CB727
 for <ltp@lists.linux.it>; Thu, 18 May 2023 13:32:22 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 70AF9200A15
 for <ltp@lists.linux.it>; Thu, 18 May 2023 13:32:21 +0200 (CEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 5FA4E60ED5
 for <ltp@lists.linux.it>; Thu, 18 May 2023 11:32:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93744C433EF
 for <ltp@lists.linux.it>; Thu, 18 May 2023 11:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1684409538;
 bh=QqJkuxav7NhxMnPB09D+QeuZ1OVZGxaFmB1irTQyLB4=;
 h=From:To:Subject:Date:From;
 b=Ml6onRm4vklS/i1AsBGmEzEOk/TU9wpBZ+ZA5gzozfr07m7IGDGBz7G0tweArDhAg
 S/+AzoN1G/7S9T1XZcvwGXcrDVl/7MjsKNTPg2s6IKw57OSThdBzPRX7dVwQeFblrJ
 VxvBJswdEhbIMgNqP2bjhjjPLHMbB9keFm6sk445r+wmyAG/UXza6HICqjzjoqd1QJ
 AVoQN3x54FJ9Uf+V2mf0tvY+OpOeih+2SZCBmpNH5cDcnW+dRcFj91IWM6QLQBl9/T
 05gA6TMWn+lgvN0dj4w3qEiFTolzYA3EvlNxWRygovE5JSa1w/7m7rcUniU5KrBKUZ
 bKePaNng0F3Kg==
From: Jeff Layton <jlayton@kernel.org>
To: ltp@lists.linux.it
Date: Thu, 18 May 2023 07:32:16 -0400
Message-Id: <20230518113216.126233-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/statx06: use a fine-grained timestamp for
 the second time fetch
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

I have a patchset in progress to change the kernel to sometimes use
fine-grained timestamps for the mtime/ctime. With this, the statx06 test
sometimes fails.

Change the test to grab a fine-grained timestamp for the "after" value,
which fixes the issue.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 testcases/kernel/syscalls/statx/statx06.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/statx/statx06.c b/testcases/kernel/syscalls/statx/statx06.c
index ce82b905bebd..fa75982b0901 100644
--- a/testcases/kernel/syscalls/statx/statx06.c
+++ b/testcases/kernel/syscalls/statx/statx06.c
@@ -109,7 +109,7 @@ static void test_statx(unsigned int test_nr)
 	clock_wait_tick();
 	tc->operation();
 	clock_wait_tick();
-	SAFE_CLOCK_GETTIME(CLOCK_REALTIME_COARSE, &after_time);
+	SAFE_CLOCK_GETTIME(CLOCK_REALTIME, &after_time);
 
 	TEST(statx(AT_FDCWD, TEST_FILE, 0, STATX_ALL, &buff));
 	if (TST_RET != 0) {
-- 
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
