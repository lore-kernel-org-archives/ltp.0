Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20F25C54E67
	for <ltp@archiver.kernel.org>; Wed, 20 Mar 2024 07:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1710920599; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=/Aktm2DxaiONRO8stKEi9qLHGo1ZfIbn2n1PcjJjOPg=;
 b=ghej9gDYn6ZaaijGfqmREgqnscWI3pwPILywCbQu3lbyBZZbXUrS2fkPcMdMi0U9VHfE1
 dT5lwK530xpyN0hJjExHstTT7OWcWtp44iDT8GbiSqoXarNTc6BHZHASYxQuGjfx7PMnclO
 5WMW0fG1uXVGa740JrkD0adQ+AEBLuQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 905B43CE0A1
	for <ltp@archiver.kernel.org>; Wed, 20 Mar 2024 08:43:19 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8B9473CB5E1
 for <ltp@lists.linux.it>; Wed, 20 Mar 2024 08:42:57 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=andestech.com (client-ip=60.248.80.70; helo=atcsqr.andestech.com;
 envelope-from=minachou@andestech.com; receiver=lists.linux.it)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id ABCA16096B1
 for <ltp@lists.linux.it>; Wed, 20 Mar 2024 08:42:53 +0100 (CET)
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 42K7givL080222;
 Wed, 20 Mar 2024 15:42:44 +0800 (+08)
 (envelope-from minachou@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.498.0;
 Wed, 20 Mar 2024 15:42:41 +0800
To: <ltp@lists.linux.it>, <akumar@suse.de>
Date: Wed, 20 Mar 2024 15:42:23 +0800
Message-ID: <20240320074223.683861-1-minachou@andestech.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 42K7givL080222
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] setreuid07: Add missing .needs_tmpdir = 1
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
From: Hui Min Mina Chou via ltp <ltp@lists.linux.it>
Reply-To: Hui Min Mina Chou <minachou@andestech.com>
Cc: Hui Min Mina Chou <minachou@andestech.com>, tim609@andestech.com,
 cynthia@andestech.com, az70021@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Run tests in the tmporary directory.

Fixes: 199f7bc81b67 ("setreuid07.c: Rewrite the test using new LTP API")
Signed-off-by: Hui Min Mina Chou <minachou@andestech.com>
---
 testcases/kernel/syscalls/setreuid/setreuid07.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/setreuid/setreuid07.c b/testcases/kernel/syscalls/setreuid/setreuid07.c
index 5faf3cb7f600..62b9ec4cdcb8 100644
--- a/testcases/kernel/syscalls/setreuid/setreuid07.c
+++ b/testcases/kernel/syscalls/setreuid/setreuid07.c
@@ -60,5 +60,6 @@ static struct tst_test test = {
 	.setup = setup,
 	.test_all = run,
 	.needs_root = 1,
-	.forks_child = 1
+	.forks_child = 1,
+	.needs_tmpdir = 1,
 };
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
