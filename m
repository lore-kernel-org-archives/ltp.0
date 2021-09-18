Return-Path: <SRS0=tzzg=OI=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5CF2C433F5
	for <ltp@archiver.kernel.org>; Sat, 18 Sep 2021 12:12:44 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D30A6127A
	for <ltp@archiver.kernel.org>; Sat, 18 Sep 2021 12:12:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6D30A6127A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E2CF03C8828
	for <ltp@archiver.kernel.org>; Sat, 18 Sep 2021 14:12:42 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8CF8E3C881C
 for <ltp@lists.linux.it>; Sat, 18 Sep 2021 14:11:50 +0200 (CEST)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E7D701A0021E
 for <ltp@lists.linux.it>; Sat, 18 Sep 2021 14:11:49 +0200 (CEST)
Received: by mail-pl1-x62c.google.com with SMTP id n18so7966207plp.7
 for <ltp@lists.linux.it>; Sat, 18 Sep 2021 05:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1iJ7CvXMjxsijpayuUup30QczKpcfiUHoENNJe4F7fM=;
 b=mL8EQU0mdD2cyHw1LgRFozSNJppMjtwJqvAU4mtCwRgIpSntp91+rcTEjWXE2xBhjl
 yqr2whjer/kKQXdLmEm2PfCxbIuVory0wACLce4AmyJIPSuJkxjIkDckLaHFJfzSyy/+
 boSNOh+9HqY9ef5Xjl5ZVgVbuQVnMucpgGX4BNbJyHE3WhNApVTVfnErqnNptU3eNdeL
 DJhl4/uCbdSaZY3+po3Nr6wr3fNX0G+/tJcNP80b3H6Nj+egY+Drps5WUEX0D/3Lulub
 lkVwO4kfZxlEgyxGOqs59GPSEor8iGK4D7y9e845IEWUFq03FKea44KT3gx89k3lTbQP
 sblQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1iJ7CvXMjxsijpayuUup30QczKpcfiUHoENNJe4F7fM=;
 b=1pkB41wHeCnu+veVTEcAkHvdzzPDR99JJkUK6Y5VwpdPaq3K6+7DEtZmEmrIGj5ic5
 OyJohk+AR54bvQdTkJuONPWg8xI6/N9nwYJiaCNVf6OC+sP7u1keRdvGoSlYBK9leqpt
 q2UbUy5F5M0e5ZY8um00fB294F7v3chtmq0Qb6pq/Ye8r6GN4N5+8oCJY0H+D2veT8Qb
 lx1hQWxkRgy0UEQJx3rk6vyLk5WShhSr3F5zLBT/pHDHUQWC9bv4yjd7LhRyZ0CIINW+
 v3FIuiNsY+gaOKadlLsaHI9CJ6YajJ8/B5IoVkXfPWf3wpgV/NOyri9JZRqS0NJsO1Gd
 Q6Uw==
X-Gm-Message-State: AOAM532BTFiOWka5Cl0YC+59QHLeyZzhlTLzlsjDDE1UAkAAMqETdPYC
 z2Eugywq8ipaBKQBLTRVfcckk5LU75L8mnrs
X-Google-Smtp-Source: ABdhPJwzv4WXSBRdqLQx1bQA1PJlTqbJYTKoO+bfI5acAiJYmnUPo/pCX9q9KxtydalDaJxj1I7k+A==
X-Received: by 2002:a17:90a:8009:: with SMTP id
 b9mr17743371pjn.15.1631967108432; 
 Sat, 18 Sep 2021 05:11:48 -0700 (PDT)
Received: from fedora34.. (125x103x255x1.ap125.ftth.ucom.ne.jp.
 [125.103.255.1])
 by smtp.gmail.com with ESMTPSA id g13sm9255556pfi.176.2021.09.18.05.11.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Sep 2021 05:11:47 -0700 (PDT)
From: QI Fuli <fukuri.sai@gmail.com>
X-Google-Original-From: QI Fuli <qi.fuli@fujitsu.com>
To: ltp@lists.linux.it
Date: Sat, 18 Sep 2021 21:11:14 +0900
Message-ID: <20210918121114.10694-6-qi.fuli@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210918121114.10694-1-qi.fuli@fujitsu.com>
References: <20210918121114.10694-1-qi.fuli@fujitsu.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 5/5] syscalls/dup2: rename dup205 to dup204
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
Cc: QI Fuli <qi.fuli@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
Message-ID: <20210918121114.I7AYv649YVq5WpYQUtm-kTkZ15kFD_HoAeDMa9mJ9yk@z>

From: QI Fuli <qi.fuli@fujitsu.com>

Signed-off-by: QI Fuli <qi.fuli@fujitsu.com>
---
 runtest/syscalls                                      | 1 -
 testcases/kernel/syscalls/dup2/.gitignore             | 1 -
 testcases/kernel/syscalls/dup2/Makefile               | 2 +-
 testcases/kernel/syscalls/dup2/{dup205.c => dup204.c} | 2 +-
 4 files changed, 2 insertions(+), 4 deletions(-)
 rename testcases/kernel/syscalls/dup2/{dup205.c => dup204.c} (97%)

diff --git a/runtest/syscalls b/runtest/syscalls
index 29d7752c7..75304f2f1 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -152,7 +152,6 @@ dup201 dup201
 dup202 dup202
 dup203 dup203
 dup204 dup204
-dup205 dup205
 
 dup3_01 dup3_01
 dup3_02 dup3_02
diff --git a/testcases/kernel/syscalls/dup2/.gitignore b/testcases/kernel/syscalls/dup2/.gitignore
index 6c4685b80..0c9a8cd75 100644
--- a/testcases/kernel/syscalls/dup2/.gitignore
+++ b/testcases/kernel/syscalls/dup2/.gitignore
@@ -2,4 +2,3 @@
 /dup202
 /dup203
 /dup204
-/dup205
diff --git a/testcases/kernel/syscalls/dup2/Makefile b/testcases/kernel/syscalls/dup2/Makefile
index 28fc158e4..fcdd146b7 100644
--- a/testcases/kernel/syscalls/dup2/Makefile
+++ b/testcases/kernel/syscalls/dup2/Makefile
@@ -6,7 +6,7 @@ top_srcdir		?= ../../../..
 include $(top_srcdir)/include/mk/testcases.mk
 
 ifeq ($(ANDROID),1)
-FILTER_OUT_MAKE_TARGETS	+= dup201 dup205
+FILTER_OUT_MAKE_TARGETS	+= dup201 dup204
 endif
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/dup2/dup205.c b/testcases/kernel/syscalls/dup2/dup204.c
similarity index 97%
rename from testcases/kernel/syscalls/dup2/dup205.c
rename to testcases/kernel/syscalls/dup2/dup204.c
index e6fc175c3..5ac263143 100644
--- a/testcases/kernel/syscalls/dup2/dup205.c
+++ b/testcases/kernel/syscalls/dup2/dup204.c
@@ -23,7 +23,7 @@ static void setup(void)
 {
 	min = getdtablesize();	/* get number of files allowed open */
 	fildes = SAFE_MALLOC((min + 10) * sizeof(int));
-	sprintf(pfilname, "./dup205.%d\n", getpid());
+	sprintf(pfilname, "./dup204.%d\n", getpid());
 }
 
 static void cleanup(void)
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
