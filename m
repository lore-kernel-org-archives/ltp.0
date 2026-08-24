Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18FADC5DF81
	for <ltp@archiver.kernel.org>; Mon, 24 Aug 2026 10:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1787566548; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=uq7fKNSmokwg3jqut20gp5dhb5P0UKKFj7QWAdwN+BI=;
 b=MT1HEWd0qPx98Nw5l5VocfXdZUB+vq2hvhvxsKhbfFh1UjwGY4hzuwJIlOE3GRhZzaC4Y
 tSipM3nNht1fJvEaMbmc0MM7P6jMP5O/IdjUxJUdG2wyAwc9d/Gl0Z/JXQuLThEnmCQnBTd
 3UyN5vlQHKeOyj9o2HuQFTyxXKah3wQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4C54B3D03E6
	for <ltp@archiver.kernel.org>; Mon, 24 Aug 2026 12:15:48 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 149C23C7136
 for <ltp@lists.linux.it>; Mon, 24 Aug 2026 12:15:27 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 47E3A1A005EB
 for <ltp@lists.linux.it>; Mon, 24 Aug 2026 12:15:27 +0200 (CEST)
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-c197e7e4e94so580884066b.2
 for <ltp@lists.linux.it>; Mon, 24 Aug 2026 03:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1787566527; x=1788171327; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=fcPIwE+uxu91gPv8XTpI8GE4hmZVMAtSS+tJbn6v2p0=;
 b=FrZ4BupHMN8g4TMZNGWerJZ0ey4tZaBLY4JaRxxu89/d1k6qGHOhMluJy+0fVZN1bz
 t1E3FLcPpKdqj+ieGt2Na4+nBnaJnIswJu7d71YCmPEN2dayEWPvNeGYUJxGiOJV6Me7
 Zul0J5RTIHn/wm0j2c8MXL55Ud4xyjAIqng+OVxBhvy/GoMDOzmk+enig4gbrR2XQEyx
 DqkuKXCWcmuEgC/rmPPy5xIJd0OnBDnMSpk5dxOHkQX+7F4xK3X7fs+QeS5GFkUOW9DT
 WCM/QknNRSnrDMAkj/pbwCj2H2vWe6PZbuPxQUSzBrUYPUFcb4IavxcUkcPSRQvwdk+f
 jr+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787566527; x=1788171327;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fcPIwE+uxu91gPv8XTpI8GE4hmZVMAtSS+tJbn6v2p0=;
 b=On1CU3pvH94EYJfNAQqgzgmq8GuJ8+e6LIVmQoZzRn2MAhp1qDXV0PdaIez8a3kptB
 tQUbLeK1xZmRWw9cGFDjdxTiIZTP82sVqDMOE4kMkPBwexKxlH7XEDQh5kmd+kTwatTp
 JF9ZYdu3tA/BqayXW5mo/WWqPgzhyfcRqoZRhnz+HJ2q75VytT7Hjtq9J11CiEgKLZPn
 JVfCJgJLjlm2lo4BDJhNK3A8G7pI/jswLZwWRz77CYzca1qSk1w0f69y+md0ip8m2k3r
 U+ToyT7L7gtN7wJLakfgkxico8ubvD8737cev5k2Xu1J1XbMFWeR+Dx0RSeOU3yaxuUx
 SYsg==
X-Gm-Message-State: AFuF++kF5grIUXih6VbKZz8Ttz1QnpmiQms7mzm5y9msIx0PTS/oBd0D
 TUpHOFBovWn0SI4AHJSYOKMMTe1cpF5w5PCXrAMaDf5wAgAW3wLxyHI155dHpucxoJbAT/ian9/
 YpXrXuaw=
X-Gm-Gg: AR+sD10+K+s0MBDaZ+0Wi01aqB693BGaR67JdDiZxCeGoHAbYqWhqxDmGmT3+ZRmLoN
 mz7hseKeiaUoN2+pir5ujfuuafDCxcTf3sf70WIgRPQoilX6bKr0CBz8EVBEo7MsHnsIV9FDSps
 XoTPEI+f03FVK2+hFtbmN+RG5FGJtlnAxI3/e1BB8Cb8V5R6yn20Tz4emCsdgMqz+PvGE9ZVH9W
 7YeZsv1PZqNVUADLYWsp6M08kYtr5P7ae0bph55Fo2RuRRJILUhga7AWyFlkk3rkuZeLHf+/ZSr
 jYEuEXt15O4TKrSjKMIwo5l9DQRsCwZ6Hj+aZP1RKmX8MohJT/7cqxanRy0afpP176XMOpYpTMT
 WGwa1tBaqlavd4GwwNxufuTbfCCKnPgno/UDv6axpRa899bKuj253QAwFWWUNoDIkvsTpU+nuwX
 88NIMUlIRpuCLtAe9Z94nUC4N0HDI7T6lr80Vf16ePBGuO3Q==
X-Received: by 2002:a17:907:1ca0:b0:c16:14d1:b529 with SMTP id
 a640c23a62f3a-c249262043bmr2008164066b.18.1787566526532; 
 Mon, 24 Aug 2026 03:15:26 -0700 (PDT)
Received: from localhost ([2a07:b241:1004:8300::1000])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c24968abf18sm1278096966b.61.2026.08.24.03.15.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 03:15:26 -0700 (PDT)
To: ltp@lists.linux.it
Date: Mon, 24 Aug 2026 12:15:24 +0200
Message-ID: <20260824101525.176017-1-avinesh.kumar@suse.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] landlock04: Fix false TFAIL in _test_truncate() deny
 path
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
From: Avinesh Kumar via ltp <ltp@lists.linux.it>
Reply-To: Avinesh Kumar <avinesh.kumar@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Avinesh Kumar <avinesh.kumar@suse.com>

commit 8643b01a68cf converted an intentionally-unchecked open() call
(used only to get an fd for the ftruncate() sub-test) into
TST_EXP_FD_OR_FAIL(), wrongly asserting it must fail with EACCES on
the deny path. Its outcome depends on other granted rights and isn't
guaranteed, causing a false TFAIL when it succeeded.

landlock_tester.h:257: TFAIL: open(FILE_TRUNCATE, O_WRONLY, PERM_MODE) invalid retval 4: SUCCESS (0)

Restore the unchecked open() on the deny path, keep SAFE_OPEN() on the
pass path. Also fix SAFE_CLOSE(TST_RET) to SAFE_CLOSE(fd) for consistency.

Fixes: 8643b01a68cf ("tree: Use TST_EXP_PASS_OR_FAIL() and TST_EXP_FD_OR_FAIL()")
Signed-off-by: Avinesh Kumar <avinesh.kumar@suse.com>
---
 testcases/kernel/syscalls/landlock/landlock_tester.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/landlock/landlock_tester.h b/testcases/kernel/syscalls/landlock/landlock_tester.h
index f44721245144..e93f970d87c3 100644
--- a/testcases/kernel/syscalls/landlock/landlock_tester.h
+++ b/testcases/kernel/syscalls/landlock/landlock_tester.h
@@ -254,7 +254,8 @@ static void _test_truncate(const int exp_err)
 	tst_res(TINFO, "Test truncating file");
 
 	TST_EXP_PASS_OR_FAIL(truncate(FILE_TRUNCATE, 10), exp_err);
-	fd = TST_EXP_FD_OR_FAIL(open(FILE_TRUNCATE, O_WRONLY, PERM_MODE), exp_err);
+	fd = exp_err ? open(FILE_TRUNCATE, O_WRONLY, PERM_MODE)
+		     : SAFE_OPEN(FILE_TRUNCATE, O_WRONLY, PERM_MODE);
 	if (fd != -1) {
 		TST_EXP_PASS_OR_FAIL(ftruncate(fd, 10), exp_err);
 		SAFE_CLOSE(fd);
@@ -262,7 +263,7 @@ static void _test_truncate(const int exp_err)
 
 	fd = TST_EXP_FD_OR_FAIL(open(FILE_TRUNCATE, O_WRONLY | O_TRUNC, PERM_MODE), exp_err);
 	if (fd != -1)
-		SAFE_CLOSE(TST_RET);
+		SAFE_CLOSE(fd);
 }
 
 static void tester_run_fs_rules(const int rules, const int result)
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
