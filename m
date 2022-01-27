Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20799C433EF
	for <ltp@archiver.kernel.org>; Thu, 27 Jan 2022 06:13:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A07B33C974B
	for <ltp@archiver.kernel.org>; Thu, 27 Jan 2022 07:13:18 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C18703C0DEA
 for <ltp@lists.linux.it>; Thu, 27 Jan 2022 07:13:08 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 4310010006A5
 for <ltp@lists.linux.it>; Thu, 27 Jan 2022 07:13:07 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 2F65A212B5;
 Thu, 27 Jan 2022 06:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1643263987; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8dzIbdZkaDEqoyA15H/Q2LQD/UhJMhLW6ZX+OmfATMM=;
 b=fAh24NDEirIzPtbgATHEbkKaCjBx3G48lAS556Auz+4nYQ4UKWMnI4FI3gUi2JTwxRpSPP
 8f9DmWibHKiyOaAlCX8iB20jQc3UnI3dwMaiTVHcPN2cpPbM9ddR3oNy5dXLxsOkMUaDl5
 f8c4b/cebvAcHDGtHPLdHU1OJo1mqXk=
Received: from g78.suse.de (unknown [10.163.24.90])
 by relay2.suse.de (Postfix) with ESMTP id E6DC7A3B81;
 Thu, 27 Jan 2022 06:13:06 +0000 (UTC)
To: ltp@lists.linux.it
Date: Thu, 27 Jan 2022 06:12:20 +0000
Message-Id: <20220127061225.23368-2-rpalethorpe@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220127061225.23368-1-rpalethorpe@suse.com>
References: <20220127061225.23368-1-rpalethorpe@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/6] memcontrol02: Remove O_TMPFILE TCONF check
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
From: Richard Palethorpe via ltp <ltp@lists.linux.it>
Reply-To: Richard Palethorpe <rpalethorpe@suse.com>
Cc: Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

We don't use O_TMPFILE anymore because the whole FS is temporary.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 testcases/kernel/controllers/memcg/memcontrol02.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/testcases/kernel/controllers/memcg/memcontrol02.c b/testcases/kernel/controllers/memcg/memcontrol02.c
index 9fa4ff811..548f36829 100644
--- a/testcases/kernel/controllers/memcg/memcontrol02.c
+++ b/testcases/kernel/controllers/memcg/memcontrol02.c
@@ -94,16 +94,7 @@ static void alloc_pagecache_50M_check(void)
 	const char *const file_key_fmt =
 		TST_CGROUP_VER_IS_V1(cg_test, "memory") ? "cache %zd" : "file %zd";
 
-	TEST(open(TMPDIR"/tmpfile", O_RDWR | O_CREAT, 0600));
-
-	if (TST_RET < 0) {
-		if (TST_ERR == EOPNOTSUPP)
-			tst_brk(TCONF, "O_TMPFILE not supported by FS");
-
-		tst_brk(TBROK | TTERRNO,
-			"open(%s, O_TMPFILE | O_RDWR | O_EXCL", TMPDIR"/.");
-	}
-	fd = TST_RET;
+	fd = SAFE_OPEN(TMPDIR"/tmpfile", O_RDWR | O_CREAT, 0600);
 
 	SAFE_CGROUP_SCANF(cg_child, "memory.current", "%zu", &current);
 	tst_res(TINFO, "Created temp file: memory.current=%zu", current);
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
