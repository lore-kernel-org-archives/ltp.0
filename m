Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9383CCD183
	for <ltp@archiver.kernel.org>; Thu, 16 Oct 2025 12:40:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0AD973CEDE7
	for <ltp@archiver.kernel.org>; Thu, 16 Oct 2025 14:40:51 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B7F163CEC33
 for <ltp@lists.linux.it>; Thu, 16 Oct 2025 14:40:35 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 228781400E62
 for <ltp@lists.linux.it>; Thu, 16 Oct 2025 14:40:35 +0200 (CEST)
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-4256866958bso454540f8f.1
 for <ltp@lists.linux.it>; Thu, 16 Oct 2025 05:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760618434; x=1761223234; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yK4WwIhQJZEvoQz6zXkyq94vBRq+aJF3Hp0q/BMMiTs=;
 b=LR3uqh2ZFBcr4iGy/NaGAdk2ggkNPf0lMwkOEjRjEfUrF+3Cno5oFlIdFjZvxhskhw
 9nySjLSRpC3pgliXaWK8O8e1vMmRK8O4nSLiDO7fUrTvsPv+qKs6Tucxznwe0PTwcj1J
 Lne7lbTf/RfFTbkm3S7eoc/Fk6OIXeBJXA91buEamsteye+0xn+U0ZAXAOUK+wqWjnbl
 OJyYL7/ZMfwCL1ytlDekHrTeOIPj2JafkerfsPoZ8ioUl6NN6ewjSodUMttCoy69wE7U
 uY119wlqFHMfYBSRKknqMzjd2dI363Wt09Q8k3PrXvs7byZuyDTjWRpDr/e6YnlTp4VG
 otEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760618434; x=1761223234;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yK4WwIhQJZEvoQz6zXkyq94vBRq+aJF3Hp0q/BMMiTs=;
 b=pheh7BQEsf1RQzc4MkQ9PL5bf7xKLs1MVtqWrmNj9jZGFhmtlcaWz1qyivvqtLd7Xr
 fS5PSkmsIre/ljwlQYqsKACASZ9WusjS2u5TJzN6DM4enHy/VEXH+0gnRWC+djDhFqW6
 TNDjI4PLuk7KZtEVMUMwXJCgRflb3guro2EaIFt54vr5sfXyulmIFmF+AV+q+z45dush
 nuEHLggg732N75Gx6Ze5ScrjoT/gnnkrN9Ym4DRygzGP7IrotBex4DX3ax419jrL+enr
 vcHYBo6jW0K3WzOAsoIi+hsfB1uRpqP9ocxyIQqyDkaWBe7S4Ow4qTzcLXIUliOT699K
 fSsA==
X-Gm-Message-State: AOJu0YwKtwbARhsqh27L8GK0qJARKQLBgNMlNParPqiYk7j4O+axws+v
 j0g4O4R5LOMzAD4ri1o13U1u5WQmpl2kww5i/rJSGW03NBjVTX4eu71UbPhDUsqW5cCrG8fQu/w
 UpTE=
X-Gm-Gg: ASbGncvgqMactkCH1SrNcn1Ip3e0uLu7Dtm1NUiENK2yQiLeb1gg1Yc3KVAE8iIUBt2
 4pLdaOXzY5+mM/sFmSgrHtzBWjackoBhC7NhQR+2WzBqepWrhUv8pV8tkLnVBVGMN6Srr5wspHw
 ue5dn4S/FJS9wgtB4UqKy3U7/qJaAYTWLN47vUGvPcvZzLx3nUsYZ5qjqB66XEZgcPgwZdzeE7Q
 gq2fFXu28bJHoD3bBwi80eCvFsQJvUE20/sv0XJ4IuRBf7sNO5r+q6AFTVarIjmKd3ULzqZaysI
 OgdqDoMTeBd1dlvTu4NtBu4hA24Dtcomxa/QPrjK8PjXARw227AGeD+R7nkJEQ+z9zyy/Uwqmix
 VaWWpznKddXTScBJe0BgwKuEQflHmA7eOs7v3tHynfEPzTFgTnXATrSu+pGxTH4jDozkv0cHP2J
 TnsKvNZ/2ZPKezIRMhXYYPh0zFlxE8b8o2V6TBNNyoSA==
X-Google-Smtp-Source: AGHT+IHXOrjjtg8mTrM8o7QJDIAOx/mwi9sBuWA2aHZbngzBsQhDx49V6mFfiXr7p4Ix34VF+xiMKA==
X-Received: by 2002:a05:6000:71e:b0:427:72:4c9 with SMTP id
 ffacd0b85a97d-42700720595mr1382002f8f.26.1760618434261; 
 Thu, 16 Oct 2025 05:40:34 -0700 (PDT)
Received: from pickles.copeland.me.uk ([149.40.2.133])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426f6773726sm9026696f8f.49.2025.10.16.05.40.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Oct 2025 05:40:33 -0700 (PDT)
From: Ben Copeland <ben.copeland@linaro.org>
To: ltp@lists.linux.it
Date: Thu, 16 Oct 2025 13:40:25 +0100
Message-ID: <20251016124025.1472694-1-ben.copeland@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] overcommit_memory: Fix integer overflow and 32-bit
 limits
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
Cc: arnd@arndb.de, lkft-triage@lists.linaro.org, dan.carpenter@linaro.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The overcommit test uses sum_total, the sum (memory and swap) to test
the overcommit settings.

This fixes two problems on 32-bit systems. The first is seen with a
integer overflow can occur when calculating sum_total * 2, if the
sum_total is larger than 2GB. The second is limited virtual address
space (2-3GB) means the test can fail from address space exhaustion
before overcommit has been tested.

Now the test runs correctly on low-memory 32-bit systems while avoiding
both the overflow bug and virtual address space issues.

Acked-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Ben Copeland <ben.copeland@linaro.org>
---
 .../kernel/mem/tunable/overcommit_memory.c    | 31 ++++++++++++++-----
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/testcases/kernel/mem/tunable/overcommit_memory.c b/testcases/kernel/mem/tunable/overcommit_memory.c
index 9b2cb479d..d4faaeee0 100644
--- a/testcases/kernel/mem/tunable/overcommit_memory.c
+++ b/testcases/kernel/mem/tunable/overcommit_memory.c
@@ -131,24 +131,41 @@ static void overcommit_memory_test(void)
 	TST_SYS_CONF_LONG_SET(OVERCOMMIT_MEMORY, 2, 1);
 
 	update_mem_commit();
-	alloc_and_check(commit_left * 2, EXPECT_FAIL);
-	alloc_and_check(commit_limit + total_batch_size, EXPECT_FAIL);
-	update_mem_commit();
-	alloc_and_check(commit_left / 2, EXPECT_PASS);
+	/* Skip tests that would overflow or exceed 32-bit address space */
+	if (tst_kernel_bits() == 64 || (unsigned long)commit_left <= TST_GB / TST_KB) {
+		alloc_and_check(commit_left * 2, EXPECT_FAIL);
+		alloc_and_check(commit_limit + total_batch_size, EXPECT_FAIL);
+		update_mem_commit();
+		alloc_and_check(commit_left / 2, EXPECT_PASS);
+	} else {
+		tst_res(TCONF, "Skipping large allocation tests due to address space limits");
+	}
 
 	/* start to test overcommit_memory=0 */
 	TST_SYS_CONF_LONG_SET(OVERCOMMIT_MEMORY, 0, 1);
 
 	update_mem();
 	alloc_and_check(free_total / 2, EXPECT_PASS);
-	alloc_and_check(sum_total * 2, EXPECT_FAIL);
+	/* Skip if sum_total * 2 would exceed address space.
+	 * On 32-bit, skip when sum_total > ULONG_MAX/4 (~1GB).
+	 * Most 32-bit systems with <=1GB RAM can map 2x that in 3GB vaddr space.
+	 * Systems with 2GB+ RAM likely cannot fit allocations in vaddr space. */
+	if (tst_kernel_bits() == 64 || (unsigned long)sum_total <= TST_GB / TST_KB) {
+		alloc_and_check(sum_total * 2, EXPECT_FAIL);
+	} else {
+		tst_res(TCONF, "Skipping large allocation test due to address space limits");
+	}
 
 	/* start to test overcommit_memory=1 */
 	TST_SYS_CONF_LONG_SET(OVERCOMMIT_MEMORY, 1, 1);
 
 	alloc_and_check(sum_total / 2, EXPECT_PASS);
-	alloc_and_check(sum_total, EXPECT_PASS);
-	alloc_and_check(sum_total * 2, EXPECT_PASS);
+	if (tst_kernel_bits() == 64 || (unsigned long)sum_total <= TST_GB / TST_KB) {
+		alloc_and_check(sum_total, EXPECT_PASS);
+		alloc_and_check(sum_total * 2, EXPECT_PASS);
+	} else {
+		tst_res(TCONF, "Skipping large allocation tests due to address space limits");
+	}
 
 }
 
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
