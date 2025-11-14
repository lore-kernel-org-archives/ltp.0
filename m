Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36A9ACEE348
	for <ltp@archiver.kernel.org>; Tue, 18 Nov 2025 17:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1763488634; h=mime-version :
 date : message-id : to : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=0PBoUdZtMlaDOMd8jXO4i5fS6u5bMXM1lg3ciVwTFDc=;
 b=gD4TrNLQXAcPs3jio4VeP/ccY9+CNHvRMqFQnWBcBq7/6MOOFUlhxGnqoRrm40mOCA+e8
 qMTFBiuHCF2QL4nlHBUOYMBSA0g35AGKTSRl3cZhowcEjE+ftEI5R6vC1B3hfPFufvex2Ow
 cB/IT36oCRYVLD8YmF8QdzEHPeOSNak=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4C90B3CF707
	for <ltp@archiver.kernel.org>; Tue, 18 Nov 2025 18:57:14 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EA7CA3CE184
 for <ltp@lists.linux.it>; Fri, 14 Nov 2025 20:52:42 +0100 (CET)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 63A421000743
 for <ltp@lists.linux.it>; Fri, 14 Nov 2025 20:52:42 +0100 (CET)
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-640aaa89697so3287246a12.3
 for <ltp@lists.linux.it>; Fri, 14 Nov 2025 11:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1763149961; x=1763754761; darn=lists.linux.it;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=+DFe9vbca4ZhV/DfLtfDFStqrJX8pRs5Fq1/ftulvro=;
 b=fQFxzcD0mtWUT3MZs0lERFYmaPkXJBvZlmvbS3vshhYypt2HSiqWTc2Ldrz5y0Vyff
 pVA1pNrEo5Hx96uJmAnKrAQpiOlvllTgJdJ6fpyp7IqJz24vSO6spoEyut0BDfmU8n1I
 r3TXaEroqVSvKqgd/Rde30dmasUjOTS++OIynv8ue7SqWDaZQ6Tx23N6PIQjS9gE7q7k
 7PkSZgrObsmaF31ojmf+fLJf8dnQbXbv1hCOGUqlsvctuupX24C8t6u4zgJ25BapZLFE
 lm0EMoXMlWZtYj4nkP+iVgNPQw8vK8G8PwZ3sy81eOgat7Kb5mqcBsPdL968CyWz3+EM
 9E3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763149961; x=1763754761;
 h=to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+DFe9vbca4ZhV/DfLtfDFStqrJX8pRs5Fq1/ftulvro=;
 b=VDd+l4HO7CUCtvZo8eBgRvjb1Yd9DGQMMeFgHuIiiJwd2fWk9N0F+W6TJheux+aCCv
 biUJr1Dx5+3SW5aQsatv/XofxnI20+FFMeaJ/m0JkBjjJ9/AovqBmvbujar62AcvFqlP
 TFQFxV4cvP1fleTOwwKOZys9FXZXACAU+e8Kzy/fwSnNc63k7aWGImCrQwFOc7C+B6jG
 9YeSyEa8YxDRNu5aVm8yKM+oE9sD6WVPSqxiW9aKlHyXTlJjUUqyFs/I2CskmsVYMurM
 82q3/m1r5+D9GaTnsL6N/g0bj7fDUwEepJQiEwnzJ4WxlcA1Pm8gDbbgAGz/f5CEEkyX
 N1/A==
X-Gm-Message-State: AOJu0YwZ5I/4t9jSLjQp63Ln4kHGqedWtcV8rfVSHkKbL77XLPLdM+jJ
 fPaxKmxWXsXbPqmnn7h9auwLVRdS+h4WeMV0QaXGNtE7SnI/oQ8HT9ZdfyvOSzF22/62OHVnvlo
 rLJBz4Dduk/IibSrRC6fQ5B67gcPr/TN09XleF6QjWksxHtDfxrPdpBk/hGE=
X-Gm-Gg: ASbGncu7PjTHaTDC4O7by/7XFxQJBvmhDTmpaI/SmUKcMGPcOASZk7gdR5TyhyVZdiW
 Q3yhU08soHVGJ3qcEqnTPnAIFJraMdayPT7LYWzokh35tZkfJ7tfkhtYWie2Cy84GPS6raUY8c6
 yg39ENCvx23KeaWiRA08I3h/KdpGcpB563AmqHXuOdAQQFPBIPB4e86uFleyDpZJnOV1SOdDhcn
 PX/CrI2UnTE6x8mfJtefLlij5OUrd+kc3AaVTQtomf5fyHHYPMhoS+yEIhOk1qqMZG1VC2ZLOeg
 kH3k4GMgu/KnU78ZVtJx2v/RgyaKq7YzzkrsePSEFiVgGdw=
X-Google-Smtp-Source: AGHT+IFdiScDPAaeHWXDf287JgtVSDR4LDph+owTnDAudiMujsC86zLwSShttOCGJk1IEX2M0+2i0/ryfYMGI5xVxPA=
X-Received: by 2002:a17:907:2d8d:b0:b73:70db:49ab with SMTP id
 a640c23a62f3a-b7370db75a0mr242393066b.35.1763149961226; Fri, 14 Nov 2025
 11:52:41 -0800 (PST)
MIME-Version: 1.0
Date: Fri, 14 Nov 2025 11:52:30 -0800
X-Gm-Features: AWmQ_bl9rkGFUFVpnHuSI71dljjYq-vvTzDKmBVgcXCR7JrQSj-bCLThgXvR16Y
Message-ID: <CAKfqHepUCKimv1xXxsAWw3bZRg=6VWBh7yyWOi=zuNaM5d9Eww@mail.gmail.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Tue, 18 Nov 2025 18:56:53 +0100
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: [LTP] [PATCH] Update clone3 wrapper signature
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
From: Chris Wailes via ltp <ltp@lists.linux.it>
Reply-To: Chris Wailes <chriswailes@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From a932e9d3ee093933a5bd58edecec42a61df2b6c0 Mon Sep 17 00:00:00 2001
From: Chris Wailes <chriswailes@google.com>
Date: Fri, 14 Nov 2025 10:42:21 -0800
Subject: [PATCH] Update clone3 wrapper signature

This CL updates the clone3 wrapper and tests to match the function
signatures used by glibc (internally) and BIONIC (publicly).

Signed-off-by: Chris Wailes <chriswailes@google.com>
---
 include/lapi/sched.h                        | 2 +-
 testcases/kernel/syscalls/clone3/clone301.c | 2 +-
 testcases/kernel/syscalls/clone3/clone302.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/lapi/sched.h b/include/lapi/sched.h
index 36f1ecad9..2fec8e397 100644
--- a/include/lapi/sched.h
+++ b/include/lapi/sched.h
@@ -75,7 +75,7 @@ struct clone_args_minimal {
  uint64_t __attribute__((aligned(8))) tls;
 };

-static inline int clone3(struct clone_args *args, size_t size)
+static inline int clone3(struct clone_args *args, size_t size, int
(*)(void*), void*)
 {
  return tst_syscall(__NR_clone3, args, size);
 }
diff --git a/testcases/kernel/syscalls/clone3/clone301.c
b/testcases/kernel/syscalls/clone3/clone301.c
index deed30b9f..ecd791389 100644
--- a/testcases/kernel/syscalls/clone3/clone301.c
+++ b/testcases/kernel/syscalls/clone3/clone301.c
@@ -123,7 +123,7 @@ static void run(unsigned int n)
  parent_received_signal = 0;
  SAFE_SIGACTION(tc->exit_signal, &psig_action, NULL);

- TEST(pid = clone3(args, sizeof(*args)));
+ TEST(pid = clone3(args, sizeof(*args), NULL, NULL));
  if (pid < 0) {
  tst_res(TFAIL | TTERRNO, "clone3() failed (%d)", n);
  return;
diff --git a/testcases/kernel/syscalls/clone3/clone302.c
b/testcases/kernel/syscalls/clone3/clone302.c
index 9e98f1954..e241be7cd 100644
--- a/testcases/kernel/syscalls/clone3/clone302.c
+++ b/testcases/kernel/syscalls/clone3/clone302.c
@@ -83,7 +83,7 @@ static void run(unsigned int n)
  args->tls = tc->tls;
  }

- TEST(clone3(args, tc->size));
+ TEST(clone3(args, tc->size, NULL, NULL));

  if (!TST_RET)
  exit(EXIT_SUCCESS);
-- 
2.52.0.rc1.455.g30608eb744-goog

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
