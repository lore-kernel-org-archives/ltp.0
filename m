Return-Path: <SRS0=690a=OE=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC0D8C433EF
	for <ltp@archiver.kernel.org>; Tue, 14 Sep 2021 12:25:09 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A19AE6109E
	for <ltp@archiver.kernel.org>; Tue, 14 Sep 2021 12:25:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A19AE6109E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 455223C89FB
	for <ltp@archiver.kernel.org>; Tue, 14 Sep 2021 14:25:08 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 675E63C1DB4
 for <ltp@lists.linux.it>; Tue, 14 Sep 2021 14:24:50 +0200 (CEST)
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com
 [IPv6:2607:f8b0:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id DFA82600F33
 for <ltp@lists.linux.it>; Tue, 14 Sep 2021 14:24:49 +0200 (CEST)
Received: by mail-pg1-x52a.google.com with SMTP id e7so12558783pgk.2
 for <ltp@lists.linux.it>; Tue, 14 Sep 2021 05:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=EhaodaAJ6+q1Kh/O5i4Hjp9otT8Z7aEQjGkZ8UkIoiM=;
 b=XtEhCVZK0V+leStvegVssdkvVJoqsaw8gOWT3ybGtn8K9qTLZYX6m8wP57Yqfkteq5
 dzu6o2+8NpJju8vzzqAZFsh1/tF0OgjMnrEV4UyW/DY8Y63FZvmpffYv1YKjqjE76FFB
 DWP6mA0G4Ti/xmU1kTUQdKe/TePH+3IyLLvhQDQrIlMnkseajTBYMSqJO21BTler0wpX
 pKdKGrhQZNsjaDxMijIFqVZws+JOp0SHRN8xa799oMD0cX/W/AXZN9xD78kdnaz5u7F8
 oCJDJySDE/d32/7ZgbqdCgiEGgYWauHel0GQKy783sO6ExTBTfrdKQNGa0Mzz4z7CVH8
 S/Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=EhaodaAJ6+q1Kh/O5i4Hjp9otT8Z7aEQjGkZ8UkIoiM=;
 b=qyf8Xb1mAQFaPx+V5XXgjv4wKJTbCBLd90dtaQKwqyrEPn9VF/FODWKYYQ2/AX+Rr/
 No20wKCinU11BApXPuN2R6M7dRNJ574Rf74F1FWB4zfP7TUcZm2v6VFTf4Vfr6vpato0
 Tt04Lyihf28wT2UhdPSGCiuXdRgai5n5QbIS/25l4mLZP6ipt18Qd+fVm/g92zjeXCyi
 Bw6rMSIlsjuVKqy/q2A9gv1w8tQM4EkaTGNFA2hRb9gf6hxuCyHuS0NJTNnYdFUpRdjs
 bAjY9izL33FNMCXXardPfn52emEw2ch5Da5XcbxTe7zD9pLkGNto1XZi1tJ8aoWajkoN
 ubsA==
X-Gm-Message-State: AOAM531W+yUjalxJTkeieCMVGXGEqSDBUF+nChAXYQPFOt9JTB88rxDq
 YtD+rBCyRX/lJdpnmvihGpX//AqdJ7vipQ==
X-Google-Smtp-Source: ABdhPJxGb/ss4mUvvUaygYRrcDut9BzzdD7Ant+Z4K740AE1gpA9eI2GiUFUGlDwNxvccHnp4/SLwg==
X-Received: by 2002:a63:df0d:: with SMTP id u13mr15323124pgg.417.1631622287638; 
 Tue, 14 Sep 2021 05:24:47 -0700 (PDT)
Received: from localhost.localdomain
 ([2409:4070:4e95:9173:770c:2c67:ffa6:19ab])
 by smtp.gmail.com with ESMTPSA id d63sm1663606pjk.17.2021.09.14.05.24.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Sep 2021 05:24:46 -0700 (PDT)
From: Naresh Kamboju <naresh.kamboju@linaro.org>
To: ltp@lists.linux.it
Date: Tue, 14 Sep 2021 17:54:25 +0530
Message-ID: <20210914122425.85129-2-naresh.kamboju@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210914122425.85129-1-naresh.kamboju@linaro.org>
References: <20210914122425.85129-1-naresh.kamboju@linaro.org>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] runtest/smoketest: Adding ping01 and ping02 test
 cases
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
Message-ID: <20210914122425.l4spEkeiGnnxI_x76zU2KoWxfKWBxQWLwGVC1RlX7z8@z>

Adding two ping test case to smoketest
ping01 ping01.sh
ping602 ping02.sh -6

Suggested-by: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Suggested-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Naresh Kamboju <naresh.kamboju@linaro.org>
---
 runtest/smoketest | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/runtest/smoketest b/runtest/smoketest
index dd689bd6f..7bebe4a42 100644
--- a/runtest/smoketest
+++ b/runtest/smoketest
@@ -13,3 +13,5 @@ utime01A symlink01 -T utime01
 rename01A symlink01 -T rename01
 splice02 splice02 -s 20
 shell_test01 echo "SUCCESS" | shell_pipe01.sh
+ping01 ping01.sh
+ping602 ping02.sh -6
-- 
2.30.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
