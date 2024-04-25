Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07DC1C4345F
	for <ltp@archiver.kernel.org>; Thu, 25 Apr 2024 02:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1714010686; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=GZNgmvMKwvXvNj3FAaUj9QZkMSOH0b4JQxZjMA9+70s=;
 b=SjNOx0+8rzBMUYvtIAadjCc7CJO8apHeSZAqc9hixaVGYfBk4p3DFJWvkpevQJhvOpCpA
 dF01onq189Uiijh0Tg1f/yol9n86nQF8LVQk2ir2GSVvJp+dED8w8GUimzhkReRThThxnuL
 nMzCPV+m70Qyet8HMoet3iNr3+HOOto=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1CD893D008A
	for <ltp@archiver.kernel.org>; Thu, 25 Apr 2024 04:04:46 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E2DB23D006B
 for <ltp@lists.linux.it>; Thu, 25 Apr 2024 04:03:41 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 94A171A00CA1
 for <ltp@lists.linux.it>; Thu, 25 Apr 2024 04:03:40 +0200 (CEST)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-41b5082bf0aso27545e9.3
 for <ltp@lists.linux.it>; Wed, 24 Apr 2024 19:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1714010620; x=1714615420; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2G+mNglTJV66v9xhQa4lqeRmhvCPwv3TC8vwC8ma5RU=;
 b=CsEBBwKLCtn4uwyHNVdxpoTn/TJwA3/TqD6HIywrUkU0SQjS2yPOk29WoIv3xhA3VF
 uKGyR7UqJ7FLHLOb+vEkhRqgxbnnHYFKTxUGFa8KIaS7IF4pW/GXoYB6mj71FRo7arS8
 8ndqLXJJhuTj1jpehDA1Ty3T5vjb3paflwvm3Fjofdz6AOaB0xhfQ58/UWP7HD1lFFus
 KARGLpFLC2DdNgAtEUXV71jAMSDoa85yMtH++HwyqX2wQF3OOrWfCoqA5jnH4RpQNZ1y
 w2/32A5BvWXm3Phqvyr1fjSMf6k08R84hTEfdzzHOIaDcB24ppALniVQnX6JKWWihOkw
 e/Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714010620; x=1714615420;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2G+mNglTJV66v9xhQa4lqeRmhvCPwv3TC8vwC8ma5RU=;
 b=NjVCKgl6y7QVpPwxjsRp4H2HJbF3cpu7YOVXxwfhRit8E72lJlGqd3bYoNIOrgHu6U
 G3/p4vTakTeMuOYUe9+5xnHZsnMsRE+6Vhvr45119UpmszAEEsHQY1n1hfVcQLXtJiWR
 QJwDH1IE/4cNs6JGEljrNIhPAxTsXZqDJ188FRMQkEkEG0BVV8vgeokwbLsJQNkRspdE
 1bYNgBpw/rwxPZY1o5I8CGC3lMyFMBaVDYBNWUwjtTepYZR607fJJHfwxKX8MOYTMPBc
 A0FRi9LV0OgB2d2ub1MQqhXM9s0fovwXgDastHD4iFEYVFlvyhMu813ZQaiE6sL4Mr4L
 GbMw==
X-Gm-Message-State: AOJu0YxlDHutz9FR6tn88N5yzN8fLQI8EcLf5kLcHgGFi1nFvKl6ePdp
 GlK1KRviwRkioLYZb2QJ6qel4RNCPV4xcdSkCVv6y9+lZPlIRRS9ShYpldZMN2C1EateuO7EYYA
 =
X-Google-Smtp-Source: AGHT+IHp4TCLBwVlTlpTNMdzMbJ/KhykVc1ELsHX0yuB0m5QaH+dFeCbw8BpRKnCP0EjP/0PrxoSEA==
X-Received: by 2002:a05:600c:1c16:b0:416:2a95:6e8b with SMTP id
 j22-20020a05600c1c1600b004162a956e8bmr3175593wms.26.1714010619971; 
 Wed, 24 Apr 2024 19:03:39 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:dc1a:df90:dc1a:df90])
 by smtp.gmail.com with ESMTPSA id
 e4-20020a05600c4e4400b0041b0f10fc7asm3399906wmq.31.2024.04.24.19.03.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 19:03:39 -0700 (PDT)
To: ltp@lists.linux.it
Date: Wed, 24 Apr 2024 22:03:07 -0400
Message-Id: <20240425020308.25367-3-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240425020308.25367-1-wegao@suse.com>
References: <20240415025100.2103-1-wegao@suse.com>
 <20240425020308.25367-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/3] sbrk01.c: Use TST_EXP_PASS_PTR_VOID
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

Signed-off-by: Wei Gao <wegao@suse.com>
---
 testcases/kernel/syscalls/sbrk/sbrk01.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/syscalls/sbrk/sbrk01.c b/testcases/kernel/syscalls/sbrk/sbrk01.c
index bb78d9a7b..39e92094b 100644
--- a/testcases/kernel/syscalls/sbrk/sbrk01.c
+++ b/testcases/kernel/syscalls/sbrk/sbrk01.c
@@ -26,12 +26,8 @@ static void run(unsigned int i)
 {
 	struct tcase *tc = &tcases[i];
 
-	TESTPTR(sbrk(tc->increment));
-
-	if (TST_RET_PTR == (void *) -1)
-		tst_res(TFAIL | TTERRNO, "sbrk(%ld) failed", tc->increment);
-	else
-		tst_res(TPASS, "sbrk(%ld) returned %p", tc->increment, TST_RET_PTR);
+	TST_EXP_PASS_PTR_VOID(sbrk(tc->increment),
+		"sbrk(%ld) returned %p", tc->increment, TST_RET_PTR);
 }
 
 static struct tst_test test = {
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
