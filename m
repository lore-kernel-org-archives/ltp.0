Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A54D2C433EF
	for <ltp@archiver.kernel.org>; Tue, 15 Mar 2022 12:25:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 19EC63C9345
	for <ltp@archiver.kernel.org>; Tue, 15 Mar 2022 13:25:49 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 89E2A3C931E
 for <ltp@lists.linux.it>; Tue, 15 Mar 2022 13:25:21 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 2CEB210005F7
 for <ltp@lists.linux.it>; Tue, 15 Mar 2022 13:25:20 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6C4281F399;
 Tue, 15 Mar 2022 12:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1647347120; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2SoUZn1hEQFjOAEY7RjvewRIUfoGHNTksocmAO1HmFY=;
 b=NnNVLAPai53Tr+lWenYUXJ4irIWGJKIkVRyKKI8XY9W1wU0woZgkyh01s3v17UXhVf+sJp
 DSaBq4NwhHg5DdmZSun+xlDYvQdCxbBulxP3obfhcHPtSNcqTKW2DcPS8k8/lv3DXMjjny
 ECms9XdDr5uneuzkclcPULnbNtgasiA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1647347120;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2SoUZn1hEQFjOAEY7RjvewRIUfoGHNTksocmAO1HmFY=;
 b=PSZaMBkPMYIiKqT6YljTiKljOjiE/w56Mx9tyfDl4TL/ukyv5+iVZ3sH+KRlQAYRg3VWHg
 zB+KdwzQDKuFfxDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4A72813B59;
 Tue, 15 Mar 2022 12:25:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id kDq2ELCFMGL6UAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 15 Mar 2022 12:25:20 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 15 Mar 2022 13:25:15 +0100
Message-Id: <20220315122516.3864-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220315122516.3864-1-pvorel@suse.cz>
References: <20220315122516.3864-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] tst_kernel: Fix search for foo-x86-64 module
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

Although modules.{builtin,dep} contain modules with both dashes and
underscores and use this consistently, there the only exception: modules
for x86_64 arch are always named x86_64 no matter whether they use
dashes or underscore for the rest. E.g. libblake2s-x86-64.

modinfo works with all 4 combinations of libblake2s[-_]x86[-_]64,
thus fix tst_search_driver() to allow the same.

before:
tst_check_driver 3 TPASS: tst_check_drivers libblake2s-x86_64 2>/dev/null passed as expected
libblake2s-x86-64tst_check_driver 3 TFAIL: tst_check_drivers libblake2s-x86-64 failed unexpectedly

after fix:
tst_check_driver 3 TPASS: tst_check_drivers libblake2s-x86_64 2>/dev/null passed as expected
tst_check_driver 3 TPASS: tst_check_drivers libblake2s-x86-64 2>/dev/null passed as expected

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 lib/tst_kernel.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/tst_kernel.c b/lib/tst_kernel.c
index 6db85bff0e..ecf4b917e7 100644
--- a/lib/tst_kernel.c
+++ b/lib/tst_kernel.c
@@ -116,6 +116,11 @@ static int tst_search_driver(const char *driver, const char *file)
 		return -1;
 	}
 
+	/* always search for x86_64 */
+	char *fix = strstr(driver, "x86-64");
+	if (fix)
+		fix[3] = '_';
+
 	SAFE_ASPRINTF(NULL, &search, "/%s.ko", driver);
 
 	f = SAFE_FOPEN(NULL, path, "r");
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
