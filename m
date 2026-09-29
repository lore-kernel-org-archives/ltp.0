Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D91CCA5FA7
	for <ltp@archiver.kernel.org>; Tue, 29 Sep 2026 08:43:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 88B383E4C15
	for <ltp@archiver.kernel.org>; Tue, 29 Sep 2026 10:43:14 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 891823CD737
 for <ltp@lists.linux.it>; Tue, 29 Sep 2026 10:42:57 +0200 (CEST)
Received: from mail-ej2-x0e.google.com (mail-ej2-x0e.google.com
 [IPv6:2a00:1450:4864:34::e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 451C46007B4
 for <ltp@lists.linux.it>; Tue, 29 Sep 2026 10:42:57 +0200 (CEST)
Received: by mail-ej2-x0e.google.com with SMTP id
 a640c23a62f3a-c2dc2d5dc0fso29419266b.3
 for <ltp@lists.linux.it>; Tue, 29 Sep 2026 01:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790671377; x=1791276177; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/3qDSIke56NADZYKV/GnoapHDwXPaC8pX67lxqNCKgI=;
 b=DSt13euuMx7Ccn6mxpy7z18Q6nBUa0XgwH+sdAsKJKRTusWdLPhdUxgC4zZq3rSf7e
 0vrrAm8Ni8TafWoacLwD78D9iiI8kU8xvg6eccv0c2uKItploVBXPwlFlYY0/ViZvH/k
 EG0Kz2BxEP1F21JYGUXf0qxtFmtXAibIVEOLcW2KHCGHIuiITGu5tm3vEKvtdJFxQysS
 MNA21O4oXm8kRqKt9gGBE25PsvtmslU6mVHoIgomJIrSmbG9EozKn22e2EP+UqRWYGv0
 /O7xC+JaJAZpHQQvQp5cq1yjSLc54Ld/90azrP+TNiJWXV5ULKOlF8oSW0v02E3sMkXM
 5eLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790671377; x=1791276177;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/3qDSIke56NADZYKV/GnoapHDwXPaC8pX67lxqNCKgI=;
 b=p2NV+T9gCUsDplJgu5U++yfhxwJLLgPNrTzcmST2WLg9XfO3V1jQa8XtNHb24jxwCr
 fcxp8NqwqTz41QXcnPGJrQDA6DLpG1JO7Cx6Uo7iiVEg1Budf47z3F32E5LtThzlklET
 wjPXd76GlYZaBHSbzC63KemGlqno90KNOHQcwRY9n8AR30UzsDNCCZlZz9EZfuY7ydFK
 cS6yuyUUm1RKbzuvcW4Qan/On1MLn0+JV0jV9mAGwa/CZKREwN6Gh1TTsOAMC8tZ0UTs
 N6Q9hpfGDl8OFwiw52lMaX9E50H0lfiStRbHJkcS4MrpEpn9MQnHRTUGj/CbPspM1589
 0+rQ==
X-Gm-Message-State: AFq9FYLaJ5zyJ6ixkZ8nIedSvMKhJQxMX5hZRnieFTFpGxyUstbKKt7a
 OWJ4OikMPREDMqPcSmasgR4KrgyhF5CvdvBnp1TO3STbBmsjje85CgAhEY59qEdy9peobXBkDzL
 DA7QM
X-Gm-Gg: AYBFou25qnNjvjjmM2tinyBHYH+TlAGyNeV7gcnQk13xAD8AGeMyFUqiDBNwWKqsOST
 v9YmuT5h+swA5+hDy4DTmdoMr9Mgs5z+ZmuDqe482MTDNyxuuVtsFGY5wPYVin53G/UoyFTBLrp
 LpuyABKb5RX0XXZHlRd0pB0Z4mLBEXfbctELIi+imu7/Dtl0IMYPwprppIRqDNxOBl143qwvhsa
 bYC0rhKH2ZSjZvzUNSqvM/meXMhgT0em69iajGPGyeNV5HtrZUA/gD4xlibYAKDicnu9A2xRIlf
 Urz+mQVarVzPejnP3yaK4jSOwq1/ptaKs/C7NAfdCvPjp23ph7EB45U4dSHy7AcfGVs3Hofhymm
 9LkkK4ONOPFrtnHWrgfQRf0CHldkm34xhyJf92HdmOAN6uPS4DPyxzmT9YbJGFLR18G909daVh1
 81jgqtQvZPAIUFGr0fPUPuIMDb5ZLbJrDL9q+f8LVYjG6gFBr1/9rBb9NK5PSI2gyKpeQL3x1aw
 8hDjEKySKD59++KaLY2VjW5X57eP7ndZg==
X-Received: by 2002:a17:907:da2:b0:c2d:cf71:dd0b with SMTP id
 a640c23a62f3a-c2dcf722f18mr522581666b.1.1790671376614; 
 Tue, 29 Sep 2026 01:42:56 -0700 (PDT)
Received: from localhost (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2dd68a6f18sm287948966b.52.2026.09.29.01.42.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 01:42:56 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: ltp@lists.linux.it
Date: Tue, 29 Sep 2026 10:42:53 +0200
Message-ID: <20260929084253.3093742-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] tst_clone: Fix child detection on sparc
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

On sparc the clone syscall does not return 0 in the child. It returns
the parent pid, so the child thinks it is the parent.

Save the pid before the clone and compare it after.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 lib/tst_clone.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/lib/tst_clone.c b/lib/tst_clone.c
index 296cd40ac0a0..d7f005a2d2a5 100644
--- a/lib/tst_clone.c
+++ b/lib/tst_clone.c
@@ -20,6 +20,9 @@ pid_t tst_clone(const struct tst_clone_args *tst_args)
 	};
 	int flags;
 	pid_t pid = -1;
+#ifdef __sparc__
+	pid_t parent_pid = tst_getpid();
+#endif
 
 	tst_flush();
 
@@ -44,5 +47,10 @@ pid_t tst_clone(const struct tst_clone_args *tst_args)
 	if (pid == -1)
 		return -2;
 
+#ifdef __sparc__
+	if (pid == parent_pid)
+		pid = 0;
+#endif
+
 	return pid;
 }
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
