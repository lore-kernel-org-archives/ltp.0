Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49DF3EB64D8
	for <ltp@archiver.kernel.org>; Tue, 20 Jun 2023 08:17:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AC1BD3CC48F
	for <ltp@archiver.kernel.org>; Tue, 20 Jun 2023 10:17:26 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 66FF43CD344
 for <ltp@lists.linux.it>; Tue, 20 Jun 2023 10:17:11 +0200 (CEST)
Received: from smtp.priv.miraclelinux.com
 (202x210x215x66.ap202.ftth.ucom.ne.jp [202.210.215.66])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 408D610009DA
 for <ltp@lists.linux.it>; Tue, 20 Jun 2023 10:17:09 +0200 (CEST)
Received: from localhost.localdomain (21A0035i-SL7B460.priv.miraclelinux.com
 [10.2.1.161])
 by smtp.priv.miraclelinux.com (Postfix) with ESMTP id C590C14006E;
 Tue, 20 Jun 2023 17:17:07 +0900 (JST)
From: Souta Kawahara <souta.kawahara@miraclelinux.com>
To: ltp@lists.linux.it
Date: Tue, 20 Jun 2023 17:08:15 +0900
Message-Id: <47b3fb5d30bf7a1884f7dc0970832d0b07f8174a.1687247631.git.souta.kawahara@miraclelinux.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <84e75a194e19b8519badb8a5db29b928150cca14.1687247631.git.souta.kawahara@miraclelinux.com>
References: <84e75a194e19b8519badb8a5db29b928150cca14.1687247631.git.souta.kawahara@miraclelinux.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 2/2] syscalls/keyctl07: Use correct CVE tag
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

Signed-off-by: Souta Kawahara <souta.kawahara@miraclelinux.com>
---
 testcases/kernel/syscalls/keyctl/keyctl07.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/keyctl/keyctl07.c b/testcases/kernel/syscalls/keyctl/keyctl07.c
index 875ef0bb8..d9e20db5f 100644
--- a/testcases/kernel/syscalls/keyctl/keyctl07.c
+++ b/testcases/kernel/syscalls/keyctl/keyctl07.c
@@ -104,7 +104,7 @@ static struct tst_test test = {
 	.test_all = do_test,
 	.forks_child = 1,
 	.tags = (const struct tst_tag[]) {
-		{"CVE", "2017-12912"},
+		{"CVE", "2017-12192"},
 		{"linux-git", "37863c43b2c6"},
 		{}
 	}
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
