Return-Path: <SRS0=3a48=N4=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B356DC433EF
	for <ltp@archiver.kernel.org>; Mon,  6 Sep 2021 08:35:06 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B16C60F21
	for <ltp@archiver.kernel.org>; Mon,  6 Sep 2021 08:35:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0B16C60F21
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5FA0A3C2600
	for <ltp@archiver.kernel.org>; Mon,  6 Sep 2021 10:35:04 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3C9263C2600
 for <ltp@lists.linux.it>; Mon,  6 Sep 2021 10:34:54 +0200 (CEST)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 90D9E1A004AB
 for <ltp@lists.linux.it>; Mon,  6 Sep 2021 10:34:53 +0200 (CEST)
Received: by mail-pl1-x635.google.com with SMTP id m17so3498410plc.6
 for <ltp@lists.linux.it>; Mon, 06 Sep 2021 01:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=VawpMV67LxPcVjea7MOoAYV96wYg44GAF17hbAPM2dQ=;
 b=f3ml10YqIibrakS02kbccHhF1ZUJVrY61wz7ocLVRhupS/F1HiuGLUI2sMn2QxRx3t
 MtDTWvhlgeWp4nQRvbbrqwakbrNuMkW6tYHlToDFrFC+COLCGLcrBJpR0qidXjULIEQe
 u96IlIALpi8ACk2BobPrXI1r3+rGo+nA8Nc4cr/f/pcCZwA7whWBNYiDkr1dSVUpFYX/
 t6dY6ZTbQA5ZNlh7voxJrhxC5tl3ef+TGBLUwwnzpz9JJvwUfM0zJSz6pIACCIiPxVvk
 xicCWo16PVzC1C7YCDhR0oniYEPjlRKKTOlQQI8A7xg6uIev1zM1LiwuU/Lh5IF2Wzsr
 Ry1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=VawpMV67LxPcVjea7MOoAYV96wYg44GAF17hbAPM2dQ=;
 b=LWhu6WNVkIlHIiURoXC/2YyjAbcuIu4FI9rmXp5yneIsXutCfjG0rsy/5z1eiYHtTc
 +NNfoc2XostzvrnxsPl6TZzteEttfwcw5o2yjL7d3Awif3uEJQSe5WTN79JQ7Pfb5xQ9
 z7D1vLIv6xmZGycJQTyMzpEl0iSUUl1aJuj4gnedJNbcbB43LgCTI9KHZ0ubOEquEmGx
 3glQ0VFt9Grfjt8Gl2jsKRTgJqewgtgR5K6Z4yNCovctJUl/kKeDioAeMn7iL49NTQs4
 3ViCfkOSz2IgG5v1nomtAkP/+JqA3Z6yAQf+bhyRTcYn4elxygoNIpBY2CNCIIm886Uq
 XVaw==
X-Gm-Message-State: AOAM530Ecr2IQHjv8FGGtY5A+szEuy4LirTJJPHGRN+9qhZx32yAj68W
 qhDOyM0+VtCqtsNloytCOVH5yXKqWnWJyA==
X-Google-Smtp-Source: ABdhPJxqkqDNsnuAO10Q3GWOhRvTMoj2fX2EhNHwsOF1Ps8rjhlHL3SsLFnHl1KiodWZ0vGCyjwBTw==
X-Received: by 2002:a17:902:b48d:b0:13a:8c8:a2b1 with SMTP id
 y13-20020a170902b48d00b0013a08c8a2b1mr9913189plr.88.1630917291147; 
 Mon, 06 Sep 2021 01:34:51 -0700 (PDT)
Received: from localhost.localdomain ([124.123.174.194])
 by smtp.gmail.com with ESMTPSA id u15sm6979090pfl.14.2021.09.06.01.34.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Sep 2021 01:34:50 -0700 (PDT)
From: Naresh Kamboju <naresh.kamboju@linaro.org>
To: ltp@lists.linux.it
Date: Mon,  6 Sep 2021 14:04:43 +0530
Message-ID: <20210906083444.82394-1-naresh.kamboju@linaro.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] runtest/smoketest: Remove intermittent failed
 test case route4-change-dst
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
Message-ID: <20210906083443.EFwKAlbhjlrrR8QNqBRAK3eifemP-RhKeOMbDMJqf0A@z>

The test case route4-change-dst fails intermittently creating
the problem for smoketest results verdict. route4-change-dst
is a stress test should not be a part of smoketest. because of
these issues removing route4-change-dst from the smoketest.

Signed-off-by: Naresh Kamboju <naresh.kamboju@linaro.org>
---
 runtest/smoketest | 1 -
 1 file changed, 1 deletion(-)

diff --git a/runtest/smoketest b/runtest/smoketest
index 7f395936e..dd689bd6f 100644
--- a/runtest/smoketest
+++ b/runtest/smoketest
@@ -12,5 +12,4 @@ stat04 symlink01 -T stat04
 utime01A symlink01 -T utime01
 rename01A symlink01 -T rename01
 splice02 splice02 -s 20
-route4-change-dst route-change-dst.sh
 shell_test01 echo "SUCCESS" | shell_pipe01.sh
-- 
2.30.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
