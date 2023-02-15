Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88F08C636CC
	for <ltp@archiver.kernel.org>; Wed, 15 Feb 2023 14:42:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CC0FD3CC44A
	for <ltp@archiver.kernel.org>; Wed, 15 Feb 2023 15:42:38 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7893D3CB4DB
 for <ltp@lists.linux.it>; Wed, 15 Feb 2023 15:42:28 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C443B60063B
 for <ltp@lists.linux.it>; Wed, 15 Feb 2023 15:42:27 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8E1E620B38
 for <ltp@lists.linux.it>; Wed, 15 Feb 2023 14:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1676472146; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ot8XN1uYTY7ZzggVbugLXT2j2fSNqt2o7hc2wJFnWpI=;
 b=Z+QD8r3e39bjDpG9QmNRRu7nd0rmWTlCAE0LKl4Lp8vfNzQk8x8sPdABBbTY95tzBDEL8w
 9WZsxcrb2RidJDt/yUEulMWEisSmj1lULZYWdD8ApBqFivsr2AgvwaFhQXOuYeg1o0HzUe
 j76s8zNQlCI49qCb7vRAY8x1uZ6Kd9A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1676472146;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ot8XN1uYTY7ZzggVbugLXT2j2fSNqt2o7hc2wJFnWpI=;
 b=FaguNfV7/jTRNp14utVfsZM9LHAyq9DSlT+64/PWXU1UqOQKy12nsLyDhGEb28jTNqREiT
 E6aR37thFlQgHcCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7EDCE13483
 for <ltp@lists.linux.it>; Wed, 15 Feb 2023 14:42:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id F+YgHlLv7GMKDgAAMHmgww
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 15 Feb 2023 14:42:26 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 15 Feb 2023 15:42:25 +0100
Message-Id: <20230215144225.25008-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] cve-2015-3290: Fix tst_syscall() return value
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

The modify_ldt() syscall returns 32-bit signed integer value. Recent changes
in tst_syscall() caused the value to be interpreted as unsigned on older
kernels/glibc, which breaks the cve-2015-3290 test. Add explicit type cast
to fix it.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 testcases/cve/cve-2015-3290.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/testcases/cve/cve-2015-3290.c b/testcases/cve/cve-2015-3290.c
index f61d2809b..a2a8fcedd 100644
--- a/testcases/cve/cve-2015-3290.c
+++ b/testcases/cve/cve-2015-3290.c
@@ -195,7 +195,8 @@ static void set_ldt(void)
 		.useable	 = 0
 	};
 
-	TEST(tst_syscall(__NR_modify_ldt, 1, &data_desc, sizeof(data_desc)));
+	TEST((int)tst_syscall(__NR_modify_ldt, 1, &data_desc,
+		sizeof(data_desc)));
 	if (TST_RET == -EINVAL) {
 		tst_brk(TCONF | TRERRNO,
 			"modify_ldt: 16-bit data segments are probably disabled");
-- 
2.39.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
