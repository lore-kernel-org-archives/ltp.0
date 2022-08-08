Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22783C25B0C
	for <ltp@archiver.kernel.org>; Mon,  8 Aug 2022 11:10:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AF2FC3C94FB
	for <ltp@archiver.kernel.org>; Mon,  8 Aug 2022 13:10:47 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7B5173C712D
 for <ltp@lists.linux.it>; Mon,  8 Aug 2022 13:10:35 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 9F0C9600125
 for <ltp@lists.linux.it>; Mon,  8 Aug 2022 13:10:32 +0200 (CEST)
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 278BALqt027433;
 Mon, 8 Aug 2022 19:10:21 +0800 (+08)
 (envelope-from dylan@andestech.com)
Received: from atctrx.andestech.com (10.0.12.119) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.498.0; Mon, 8 Aug 2022
 19:10:19 +0800
From: Dylan Jhong <dylan@andestech.com>
To: <ltp@lists.linux.it>
Date: Mon, 8 Aug 2022 19:04:16 +0800
Message-ID: <20220808110416.2244071-1-dylan@andestech.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Originating-IP: [10.0.12.119]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 278BALqt027433
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] fs_bind: Fix incorrect mount option
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
Cc: alankao@andestech.com, x5710999x@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Fix the "--make-[r]share" option of mount, which should be
"--make-[r]shared".

Reference:
    https://linux.die.net/man/8/mount

Signed-off-by: Dylan Jhong <dylan@andestech.com>
---
 testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind33.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind33.sh b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind33.sh
index 170f7c42b..13704ce2e 100755
--- a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind33.sh
+++ b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind33.sh
@@ -17,11 +17,11 @@ test()
 
 	EXPECT_PASS mount --rbind dir1 dir2
 	EXPECT_PASS mount --make-rslave dir2
-	EXPECT_PASS mount --make-share dir2
+	EXPECT_PASS mount --make-shared dir2
 
 	EXPECT_PASS mount --rbind dir2 dir3
 	EXPECT_PASS mount --make-rslave dir3
-	EXPECT_PASS mount --make-share dir3
+	EXPECT_PASS mount --make-shared dir3
 
 	EXPECT_PASS mount --rbind dir3 dir4
 	EXPECT_PASS mount --make-rslave dir4
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
