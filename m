Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AF79C28D13
	for <ltp@archiver.kernel.org>; Fri, 19 Aug 2022 23:27:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4470D3CA2F6
	for <ltp@archiver.kernel.org>; Sat, 20 Aug 2022 01:27:26 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7CE373C8CA7
 for <ltp@lists.linux.it>; Sat, 20 Aug 2022 01:27:13 +0200 (CEST)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com
 [IPv6:2607:f8b0:4864:20::1149])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 331272000AF
 for <ltp@lists.linux.it>; Sat, 20 Aug 2022 01:27:13 +0200 (CEST)
Received: by mail-yw1-x1149.google.com with SMTP id
 00721157ae682-335420c7bfeso99465767b3.16
 for <ltp@lists.linux.it>; Fri, 19 Aug 2022 16:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=cc:to:from:subject:mime-version:message-id:date:from:to:cc;
 bh=kTQK3xFAOMLGxLGLetA6LA8XJgvx2MNP7UBCBDdXr0A=;
 b=HZvCxrt0YXQHQA0rZPoWMqGh/STgvauHNkw6nZBXZbP9wkt5EbO9K2i2W53lvIITY0
 StyPRGPo62J8Z1JTqC8imCslxqDyF43QpKW1PDrXwPLBBlJE8i7Z/PjWMZFvbhh78lXk
 xiWrKKaXJqoMW2ugOt7NAjmMjNIHGEs20On1iIc6TbVDgLCyk0cBnGPtNQ5Noh6BPJ0h
 6nzT+72IcW8ZHgV9zQQ5TXZ7DPvw/EKXfjGb+bi/jhZVw93cs3OOA58/LgSuWK83xT6Y
 6YRN9ZiJl443D6QuUEpBgbmxD7C4NY/M3e8yl75eW7tzyX6OFB+iHRRa58Q1bgmLKdBx
 2nMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
 :from:to:cc;
 bh=kTQK3xFAOMLGxLGLetA6LA8XJgvx2MNP7UBCBDdXr0A=;
 b=1H17eCqquPFfHxz+uLRh4QJLNgffH3AHD+G5hV8QLPBOsjt5AIBbAeR9jl9kqEiF5U
 asGq2oEdbFoCfnkRBRuX0YBV2zOuVXfd3FqU5DK3W2JABDqrr/aqe7IzForuYd18BFbH
 CduoMdYClMIuim+kwuC8BVftjOx7hk3wVjuIAoy4eoLqCBhKaiAwvFNAxKUnxqbbkm9P
 uA5ZHFxU89EIXj1GjoGGCcJ2Xydeou8wb9KXNy0JqaNMT7qlZK/VRkTPf1wHimFliw4r
 XGaf9vhR4Hzxn9+z2qe3/p0pEkKpF8B1gwCmxDCs7EMdsYGKKc5M7QvVyfh2UOm3gFFs
 uyVw==
X-Gm-Message-State: ACgBeo1kX6k6tuCsD6kOqYVWKKQGFtIkmhGczuY4m2j5K2RfYA0BlLu6
 GLVbI8yyVsKZ3beJkBPmRWA2YTgo1bvUIUYIULgzJY64ohfkGkBg9fTxW2VMr0I85IyqGt63mia
 sb2Xsv6ypaeTDGy+L7leYsHtBV8xFZETY+ItUmutApXQSE3/qJnJcASYQ
X-Google-Smtp-Source: AA6agR6EyWjIbrNzMKYYzu2XAf22Uxz0ny+CCv//I9X+P9aDqSpILS7P25qMdgFjMVAazk7Ek4S5IfE3cCk=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:4be])
 (user=edliaw job=sendgmr) by 2002:a05:6902:102c:b0:686:2a0d:9c06
 with SMTP id
 x12-20020a056902102c00b006862a0d9c06mr10016097ybt.72.1660951631849; Fri, 19
 Aug 2022 16:27:11 -0700 (PDT)
Date: Fri, 19 Aug 2022 23:27:06 +0000
Message-Id: <20220819232706.2009052-1-edliaw@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.2.609.g9ff673ca1a-goog
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] syscalls/signal06: loop being clobbered by syscall
 on clang
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
From: Edward Liaw via ltp <ltp@lists.linux.it>
Reply-To: Edward Liaw <edliaw@google.com>
Cc: vmartensson@google.com, kernel-team@android.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Indicate to the compiler that the syscall will modify registers rcx
and r11 to prevent loop from getting clobbered.

Signed-off-by: Edward Liaw <edliaw@google.com>

---
I added an output operand for the result so that the compiler would know
that rax is clobbered as well.
---
 testcases/kernel/syscalls/signal/signal06.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/signal/signal06.c b/testcases/kernel/syscalls/signal/signal06.c
index 64f886ee3..cf0706ea4 100644
--- a/testcases/kernel/syscalls/signal/signal06.c
+++ b/testcases/kernel/syscalls/signal/signal06.c
@@ -72,8 +72,8 @@ void test(void)
 	while (D == VALUE && loop < LOOPS) {
 		/* sys_tkill(pid, SIGHUP); asm to avoid save/reload
 		 * fp regs around c call */
-		asm ("" : : "a"(__NR_tkill), "D"(pid), "S"(SIGHUP));
-		asm ("syscall" : : : "ax");
+		int unused;
+		asm volatile ("syscall" : "=a"(unused) : "a"(__NR_tkill), "D"(pid), "S"(SIGHUP) : "rcx", "r11");
 
 		loop++;
 	}
-- 
2.37.2.609.g9ff673ca1a-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
