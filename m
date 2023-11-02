Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D566C4332F
	for <ltp@archiver.kernel.org>; Thu,  2 Nov 2023 23:01:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 62CCF3CE9A8
	for <ltp@archiver.kernel.org>; Fri,  3 Nov 2023 00:01:11 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 428193CC879
 for <ltp@lists.linux.it>; Fri,  3 Nov 2023 00:00:59 +0100 (CET)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com
 [IPv6:2607:f8b0:4864:20::b4a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 0466C200AE4
 for <ltp@lists.linux.it>; Fri,  3 Nov 2023 00:00:58 +0100 (CET)
Received: by mail-yb1-xb4a.google.com with SMTP id
 3f1490d57ef6-da39d244087so1819998276.3
 for <ltp@lists.linux.it>; Thu, 02 Nov 2023 16:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1698966057; x=1699570857; darn=lists.linux.it;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=7fdLGZEb8G4wad+8Y777R+0IyTLfUBXfCHUCw1nOPNk=;
 b=co+Y70gwGVGrb16ubTVy2W2pdvyGsGw5tv5B0Qn5hAqJUBkWoSqi5iVrfbYkY+JMDx
 fZ3FhJ120Z2oNa5Y+HBiuaFZUZPZWhI2SCDISeMqFPyX+kPLwvNlVL0Y9cWHdDf/EPdT
 L4uBXPkydFzHfOhSL5rsxGZIX9ZQzBsycYraZTG/GZE3WBgkLEniw4XZH7OqH0G5HFEc
 MpuSq6gLcWMeg/iYccG9Sqp6DvYzDDOPNvVLh4XBOzLIX5YUWkIX7Jp7567UAvus1VTT
 Mv17bdkpshpvYpVD5QzABzZV2KnWdk+rNzqH/Ih3KZ0Zypb6O/uwrs0qvZhjwFZhpjGn
 67bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698966057; x=1699570857;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7fdLGZEb8G4wad+8Y777R+0IyTLfUBXfCHUCw1nOPNk=;
 b=uaWazMUcNGzbqh+5PR//d59zXbYAzPcUZQR2RAHX/Q8Q2J9JQd/U885RnVj4VN2sAv
 reUBEkGyUEOtLrlGygvkekXjKiCHZtW215wdjmk0XNYIYMp7LMk2vQqd4ctbvQnn6REi
 qByzcCIohkzw+I9NkzoJ/4LTQ+B2lRD4YW/Vsn2AGM3+fDgfZlrQJzzUzTxTe3aBkWEt
 /JHg2jlIk+NMbWGwTLGfRFF5rGm8rW3BXdzNFBa4shBxVOk2f9l1SQlpgXCz6TrMKlFD
 GI4DBZtzl867VoHzO2hekF+v9IEM0sINqC1yxZngEvjWVT3gN4AiVozVyvxMWopTJGI+
 prlA==
X-Gm-Message-State: AOJu0YyXYkgrO06L0dADgUKwSuK8E7eYRw0mpgkK+yLnYZrHxJzFFKKS
 ARR5FuZODymHLqPgqRMYoswhigIDVGBvs+PzQJb6H8xDjx/ktX9EHXl2viQYk5P5gOZdQqv0zcv
 GtqaTB1qxfNrW+xO7wn1MfhxMNunZ1pTPekdjryLYHsgnq2bTc6KPVWAW
X-Google-Smtp-Source: AGHT+IFce1hHS+k9xDINw+Kn9QTaxignJLHB/evrxLNIH3iusbRT8kYFknGEoIUX7nr/+saqbHiW1BXTRXg=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a25:add5:0:b0:d9a:4f4c:961b with SMTP id
 d21-20020a25add5000000b00d9a4f4c961bmr371470ybe.1.1698966057647; Thu, 02 Nov
 2023 16:00:57 -0700 (PDT)
Date: Thu,  2 Nov 2023 23:00:53 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231102230054.3195864-1-edliaw@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] madvise11: Allow test to skip if MADV_SOFT_OFFLINE is
 not supported
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
Cc: kernel-team@android.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

madvise11 will exit with TFAIL if CONFIG_MEMORY_FAILURE is not
configured.  Skip the TFAIL if EINVAL is returned by madvise.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 testcases/kernel/syscalls/madvise/madvise11.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/madvise/madvise11.c b/testcases/kernel/syscalls/madvise/madvise11.c
index 3cde85ef5..0793319d2 100644
--- a/testcases/kernel/syscalls/madvise/madvise11.c
+++ b/testcases/kernel/syscalls/madvise/madvise11.c
@@ -162,7 +162,7 @@ static void *alloc_mem(void *threadnum)
 	err = allocate_offline(tnum);
 	tst_res(TINFO,
 		"Thread [%d] returned %d, %s.", tnum, err, (err ? "failed" : "succeeded"));
-	return (void *)(uintptr_t) (err ? -1 : 0);
+	return (void *)(uintptr_t) err;
 }
 
 static void stress_alloc_offl(void)
@@ -188,8 +188,9 @@ static void stress_alloc_offl(void)
 
 		SAFE_PTHREAD_JOIN(thread_ids[thread_index], &status);
 		if ((intptr_t)status != 0) {
-			tst_res(TFAIL, "thread [%d] - exited with errors",
-				thread_index);
+			if ((intptr_t)status != EINVAL)
+				tst_res(TFAIL, "thread [%d] - exited with errors",
+					thread_index);
 			thread_failure++;
 		}
 	}
-- 
2.42.0.869.gea05f2083d-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
