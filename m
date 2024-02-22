Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B365BC48BF8
	for <ltp@archiver.kernel.org>; Thu, 22 Feb 2024 04:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1708576909; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=adCLinGeplX6GsLYbjRnRh69nf37gb/eJYQal6o1ixE=;
 b=DkuEW14E+4DNf0gY/mJIq3+3Q8oj5OzN+PsiAOrETo2sn0oavtpgfrlQfe5sbnTFlKVQM
 Ip1UErIn6QKXuOaWgRDjOme450dx+UCr6XTwZ6G6GOXMD2nAy5XLmkRa3qvnZPZOp3F7ZaT
 tU5ROv+V2omLhVzKVYDXUvi8Y4Pu++k=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B287E3D11B1
	for <ltp@archiver.kernel.org>; Thu, 22 Feb 2024 05:41:49 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8756B3CAB05
 for <ltp@lists.linux.it>; Thu, 22 Feb 2024 05:41:28 +0100 (CET)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 9AC32140019E
 for <ltp@lists.linux.it>; Thu, 22 Feb 2024 05:41:27 +0100 (CET)
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2d109e82bd0so96883271fa.3
 for <ltp@lists.linux.it>; Wed, 21 Feb 2024 20:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1708576886; x=1709181686; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=04jMjRy51kjOv/ZyB6N9U9X0rA9zG4n5anMsvWfO3Mg=;
 b=GuSnvGbwaRgxdJAjM3W56ukERD82BqrQjuw0SoxAd1s/nx//PmSga4Y5CSnQ5b0y55
 Y5DyiuaobA/KV3fpnIA7JqQYX1m/xi/09Nm8OAYAwATtZeLPoTPeWkR/H3s/BMH86IJB
 9blJ2OJjX3ujbcIDJR3ESH2wN3dlyWqP9CamwAjgysjZuXctjMJ2uhaZC8FKQMBQWkSD
 vclX+5xTSdVKbLhzz+qIPFGZZEEn0JXaJ2kEGK10c/uuzMRUc3pdg8jt8B4sDSccA30e
 PwHDDMRQf3v3WlSTg/hyde4UlnVagmaME4qhvkMOmSguMAvrhqokOsNvVoZfDLTNwNke
 uSPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708576886; x=1709181686;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=04jMjRy51kjOv/ZyB6N9U9X0rA9zG4n5anMsvWfO3Mg=;
 b=BNo+CXLsH2titK1Fp04PxWbGuGIKUiAeFVCR2p67cc/rp1y5l0fCCCTbQP7EzkhBmM
 bz+RbVRX3VUwxHWlq0cenZ230MF1eKZ43yHWt+WaDasnzclW9S1I93LeAZahiBkP//Sf
 vL05tAgQiybBqaV8uoWSkt0FQhJVqUstbBGYDFbhLEQVmInw0UA3M1sz8/+QUzKoe804
 2DnD/BD2L3bqDwnY7Q/QUL8J8U2s4FhWFaoIAg1tFkOoN+IyV8HZtf6n3ulLgYb5brNs
 L7rbzs/RKFWrNwrJcHTGNLTD0htnjZP117wb9eF000nB/lvY5kKrlI2FNlIkjy58aWjy
 WK/w==
X-Gm-Message-State: AOJu0YzClh4KdPDsfKL1v2KANPpOp83m28jsN28J0/bj4YE2Emq3SVyS
 Rht7MNs8dX0dIJZkY/PuIXtlqdunidaFPW9NlbWeV9cjYICgT8ubNA0RSMdaN8UQfi0eJX3O+UB
 h9Q==
X-Google-Smtp-Source: AGHT+IGdQpj8LTiBxXKlYvFzC/27mRfRwp3dHdUaEwzWqraqxHOnQNzW7mhfk/n9Wjlo3mSH0m3n7A==
X-Received: by 2002:a2e:90c5:0:b0:2d2:4866:b5b0 with SMTP id
 o5-20020a2e90c5000000b002d24866b5b0mr4345108ljg.39.1708576886147; 
 Wed, 21 Feb 2024 20:41:26 -0800 (PST)
Received: from localhost ([223.72.38.233]) by smtp.gmail.com with ESMTPSA id
 w17-20020a17090a8a1100b0029a3a415859sm962461pjn.33.2024.02.21.20.41.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Feb 2024 20:41:25 -0800 (PST)
To: ltp@lists.linux.it
Date: Wed, 21 Feb 2024 23:41:19 -0500
Message-Id: <20240222044119.28500-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] swapoff01.c: Adjust blocks size base on pagesize
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The make_swapfile function will encounter no space error if pagesize
is bigger then 4096, such as ppc64 system use default pagesize 65535.

Signed-off-by: Wei Gao <wegao@suse.com>
---
 testcases/kernel/syscalls/swapoff/swapoff01.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/swapoff/swapoff01.c b/testcases/kernel/syscalls/swapoff/swapoff01.c
index c303588df..71d6c6c04 100644
--- a/testcases/kernel/syscalls/swapoff/swapoff01.c
+++ b/testcases/kernel/syscalls/swapoff/swapoff01.c
@@ -44,7 +44,12 @@ static void setup(void)
 {
 	is_swap_supported(TEST_FILE);
 
-	if (make_swapfile(SWAP_FILE, 65536, 1))
+	int blocks = 65535;
+
+	if (getpagesize() > 4096)
+		blocks = 65535 * 4096 / getpagesize();
+
+	if (make_swapfile(SWAP_FILE, blocks, 1))
 		tst_brk(TBROK, "Failed to create file for swap");
 }
 
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
