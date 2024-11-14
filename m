Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FA9AD6A25B
	for <ltp@archiver.kernel.org>; Thu, 14 Nov 2024 23:49:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 92A2A3D71FE
	for <ltp@archiver.kernel.org>; Fri, 15 Nov 2024 00:49:39 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 712423D7209
 for <ltp@lists.linux.it>; Fri, 15 Nov 2024 00:48:47 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 14782237BA1
 for <ltp@lists.linux.it>; Fri, 15 Nov 2024 00:48:47 +0100 (CET)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4319399a411so10614945e9.2
 for <ltp@lists.linux.it>; Thu, 14 Nov 2024 15:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731628126; x=1732232926; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3NezokX9sei53GefW5VQ62zvzA0OLb2Sr9QOx01h0+c=;
 b=VJi0yljml84X2DsjS8xAcui41PdsO5dOEtjxHLgDuMsoh8E7Pfgk8dvS5vdytMyBLk
 71tf0fUR7eg8HmJ1c4RcezDmS8+dx+B8J9aI6XmlCczLR5szR/AuWviFBqRcz21KQcph
 2bO0VmNkzNYGv4n+KXUNcojN4YqwevMaGq1ugERJ9ee+x5BxU/kbi4dM8qkPtTraajbj
 +94+C+mpJ+e2zCRcmuFxdQtkUJO0DhrM41yIhi+VrARco2cIiU8IM7XDeszYaUoUO9w2
 YxVksywI21FIrz5qQ+G3WgUxuvrUJSRpL/X6Hz5VWjxXAtdLhWEBCTirpZyUjYZ82oDN
 ECsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731628126; x=1732232926;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3NezokX9sei53GefW5VQ62zvzA0OLb2Sr9QOx01h0+c=;
 b=iKOniFACTIkKRl6nnymq6LqyD3JrqI7c98rKPvB9rZsRtmdG/QCUCyd4FBqzf83nVL
 B10HlVzy1GoAF8wWsZ2wNJyGpi8tVMmCxPPCu84Lv2m3D6OuJavOQlfoJHHETRL6GiYe
 cR8IcZnJxN5KRW5gLhLSK8c1X0sD2YpW6WK1jC/MvHsS4HqVHLxB00UsvKKavbfXOqU+
 ex9w1dQxkWAiwNSd1W+/ecb6E5hMBoKojzJnfErrxIFYtNj87lQawIDnJxwFfdeEn8kY
 iOjwl3U2y5Pap1SseYag0yKfl72MTRfm728WwUVILze1KRmtVsnhx9nbfrpALbDigs80
 xScw==
X-Gm-Message-State: AOJu0YzrgZBULGKbLfbBYxxUaw9OUde4ykl5kFjWzn4foYdwpMblabbb
 cGowB+AvfyIrSCTCb9PDTVQ5P8D3+PTVv8F9jghNYx5LFYqhCsE6IIrmLg==
X-Google-Smtp-Source: AGHT+IET2xvJToNyBxETsi1MYU8HJFsJV1tdQTaZ/x5McoIfS5wbVRynP+fgWJeq50lIJYJkUHUsvQ==
X-Received: by 2002:a05:6000:4007:b0:37d:4a16:81d6 with SMTP id
 ffacd0b85a97d-38225a05272mr381212f8f.24.1731628126395; 
 Thu, 14 Nov 2024 15:48:46 -0800 (PST)
Received: from x230.suse.cz (gw1.ms-free.net. [185.243.124.10])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3821ada2e35sm2789402f8f.5.2024.11.14.15.48.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 15:48:45 -0800 (PST)
From: Petr Vorel <petr.vorel@gmail.com>
To: ltp@lists.linux.it
Date: Fri, 15 Nov 2024 00:48:37 +0100
Message-ID: <20241114234839.1680432-3-petr.vorel@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241114234839.1680432-1-petr.vorel@gmail.com>
References: <20241114234839.1680432-1-petr.vorel@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/3] rt_tgsigqueueinfo01: Convert doc to docparse
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

Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
---
 .../syscalls/rt_tgsigqueueinfo/rt_tgsigqueueinfo01.c      | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/rt_tgsigqueueinfo/rt_tgsigqueueinfo01.c b/testcases/kernel/syscalls/rt_tgsigqueueinfo/rt_tgsigqueueinfo01.c
index 2f603be945..9e45f35f78 100644
--- a/testcases/kernel/syscalls/rt_tgsigqueueinfo/rt_tgsigqueueinfo01.c
+++ b/testcases/kernel/syscalls/rt_tgsigqueueinfo/rt_tgsigqueueinfo01.c
@@ -1,17 +1,17 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2019 Linaro Limited. All rights reserved.
+ * Copyright (c) Linux Test Project, 2019-2024
  * Author: Sumit Garg <sumit.garg@linaro.org>
  */
 
-/*
- * Test rt_tgsigqueueinfo
- *
- * This tests the rt_tgsigqueueinfo() syscall. It sends the signal and data
+/*\
+ * Basic test for rt_tgsigqueueinfo(2) syscall. It sends the signal and data
  * to the single thread specified by the combination of tgid, a thread group
  * ID, and tid, a thread in that thread group.
  *
  * Also this implement 3 tests differing on the basis of signal sender:
+ *
  * - Sender and receiver is the same thread.
  * - Sender is parent of the thread.
  * - Sender is different thread.
-- 
2.45.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
