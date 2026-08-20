Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47733C5DF82
	for <ltp@archiver.kernel.org>; Thu, 20 Aug 2026 07:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1787210538; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=CXfaA4cHYwQNdMXOOicmpZKiRwRST+BGxtr2AqMiBkc=;
 b=impc/9CD+Ht07I4tyFv8hhnCgg5iN+AGmwHiGK+U8SZSyj5AXe39cpvnb6sPjfN+lc9Mq
 DfS1a45M8EZR8gfHvbHmVqP/ZSFOeYUhXd8outXvFTO86jsYK+NX2Ckr3xJ9n30PmSxQg4S
 wOknyNot7FshYqAhQpxq1ER2v3+TLP0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4CC913CE107
	for <ltp@archiver.kernel.org>; Thu, 20 Aug 2026 09:22:18 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 044293CD5B2
 for <ltp@lists.linux.it>; Thu, 20 Aug 2026 09:21:54 +0200 (CEST)
Received: from Atcsqr.andestech.com (atcsqr.andestech.com [220.128.198.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id BF61B1400552
 for <ltp@lists.linux.it>; Thu, 20 Aug 2026 09:21:51 +0200 (CEST)
Received: from mail.andestech.com (atcpcs55.andestech.com [10.0.1.155])
 by Atcsqr.andestech.com with ESMTPS id 67K7Lg6N049551
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <ltp@lists.linux.it>; Thu, 20 Aug 2026 15:21:42 +0800 (+08)
 (envelope-from cyyang772@andestech.com)
Received: from ATCPCS34.andestech.com (10.0.1.134) by atcpcs55.andestech.com
 (10.0.1.155) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.43; Thu, 20 Aug
 2026 15:21:42 +0800
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS34.andestech.com
 (10.0.1.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Aug
 2026 15:21:42 +0800
To: <ltp@lists.linux.it>
Date: Thu, 20 Aug 2026 15:21:33 +0800
Message-ID: <20260820072133.2036117-1-cyyang772@andestech.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs55.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 67K7Lg6N049551
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] lib: test: check systemd in tst_virt_hyperv() as
 tst_test.sh
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
From: Victor Cheng-Yen Yang via ltp <ltp@lists.linux.it>
Reply-To: Victor Cheng-Yen Yang <cyyang772@andestech.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Guard tst_virt_hyperv() in the old shell API with a command lookup, as
the tst_test.sh version already does. Without systemd installed every
test calling it printed "systemd-detect-virt: not found" to stderr.

Signed-off-by: Victor Cheng-Yen Yang <cyyang772@andestech.com>
---
 testcases/lib/test.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/testcases/lib/test.sh b/testcases/lib/test.sh
index d26cf5df0..edae1313e 100644
--- a/testcases/lib/test.sh
+++ b/testcases/lib/test.sh
@@ -331,6 +331,8 @@ tst_virt_hyperv()
 {
 	local v
 
+	command -v systemd-detect-virt > /dev/null 2>&1 || return 1
+
 	v="$(systemd-detect-virt)"
 
 	[ $? -eq 0 ] || return 1
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
