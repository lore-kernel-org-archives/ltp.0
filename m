Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78446CCD19A
	for <ltp@archiver.kernel.org>; Thu, 16 Oct 2025 14:03:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CB88D3CEDF3
	for <ltp@archiver.kernel.org>; Thu, 16 Oct 2025 16:03:48 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 649DD3C7221
 for <ltp@lists.linux.it>; Thu, 16 Oct 2025 16:03:34 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 2F8D0200C7E
 for <ltp@lists.linux.it>; Thu, 16 Oct 2025 16:03:33 +0200 (CEST)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-46e6ba26c50so5909295e9.2
 for <ltp@lists.linux.it>; Thu, 16 Oct 2025 07:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760623412; x=1761228212; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=46W2IU2oFjB1/T/0is2llTfA8PXHIlBZXTRgvqnGCAw=;
 b=j4jPhZAAQL8JHzYMRE7Qa5iqmCWdJN6DU54LeY0ZWWUV3Y7knvEi9qqiSBFt2bJr/W
 XEUakZBFFT9OAQINgPnFVlCQ59rR3P73wr3yug4IQ3nA95riqvYr+QmbAuRPHMiy5mbW
 ozesC+C6uxc1IZqz1bM4G1heVriawlkJEr4M/wdUZDEngJgAWUe+EsnELY2XveOq093x
 7ng4736MkjEHuLtObUtPhvn0IuuqMBctZqlxOQmlocVEvQV3FKo66zLw5IVwgBmR0P1V
 hPNS+wqMVvIbZ4eqlNH06D6O8HGyqjCwXb34i8UyPGffz+D/ZXQIDB+UIi44EiI7SYIM
 pXYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760623412; x=1761228212;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=46W2IU2oFjB1/T/0is2llTfA8PXHIlBZXTRgvqnGCAw=;
 b=UG+qcezK+TIBXYGAm8urOhQ+6SU5slWwQDEwDM/Siannmt3/qrGKYjCMmuClj7dJUj
 mK5Brbifam25sBBLsONfTusaYBCAbtYHwtHe8Smh90OUs0cZR/D6ax6GPqrdxC7Lr3jo
 TSYjzTgpOAE4sK+lXQVuPQl/bDQ4p1a7QpXQ+26oc17eBOTIZbdw3N3ECkgOf34xzu4m
 EhAYhTbnVtz34Y13eX/bXZFaFjcEb5VspkbndK6rLB2AJrMZQcd0RkqlHF154hxSvt6y
 bWLzxtKvmSeEzvReUIk7YS83toKhQ1zYg3aaBU9hlPxVQz+ZdA98cDCaVnM1vM4fcuz8
 Bc3Q==
X-Gm-Message-State: AOJu0Yx32mNUeBthYxYDAA14adf/zyKhkCTFQ/WY2s4KFTgn4bXNBt+f
 4h+jVU+Ilx2Xg47NcOxOmlcq2TJt+mUHvbkhi1zlZFCZ+Ur7lLRxgc52UEyS2gHK37ODAxRbEcq
 rJtM=
X-Gm-Gg: ASbGncsIN/URMdW0njYyKaKn49e5qa4lVz699vmcFBP8QwWAzL8GAFtdumD1c18+xID
 Buxp7x1/lFuUgMFViQfct0QSpb3nR+0y98P5Ej60sxT0f3L/qb21mv/CHTKaN7ZXsnGFznwq2rN
 eHuYVwUDQKOy9/mRaVNdyGFHNxPPpH+D5KXmDr2HmcS79VC4VZDVp84EUIuBduyBt5i8GEfKN7h
 LWd+Yr/7VituhPHOTeDDMZsqoLlibMoW3JWDS6wSkawHia+N/ybdmy8muNPxNYWmyoM2kFm9o1Q
 37NkRRUxLVguIrrPlPmRr9pJCuXkAm06urtLZ+juG194u2TLi29F+/eWWcZU05ZuWQ9TKOiKQcM
 t83eNeXo0b3yJYJDe7HsiaAY/x/upTEv9yzcv9ULrzrXnT7YLseWG0CBpWZBEfu3VhqS7Y51JMr
 MrWHM46LLno9KgQnCA7k0KaFRXGHCwSuw=
X-Google-Smtp-Source: AGHT+IFF9tRdkrvSBaxUb8N3Li3HSrYqsC4pvkLspGBsUUhQflN17R8nrSblV6KU0YROYHBe+OkPjg==
X-Received: by 2002:a05:600c:8b78:b0:471:1548:5042 with SMTP id
 5b1f17b1804b1-4711787dc81mr641525e9.9.1760623412211; 
 Thu, 16 Oct 2025 07:03:32 -0700 (PDT)
Received: from pickles.copeland.me.uk ([149.40.2.133])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4711435b06fsm35684545e9.0.2025.10.16.07.03.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Oct 2025 07:03:31 -0700 (PDT)
From: Ben Copeland <ben.copeland@linaro.org>
To: ltp@lists.linux.it
Date: Thu, 16 Oct 2025 15:03:03 +0100
Message-ID: <20251016140303.1645478-1-ben.copeland@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] oom03: use size_t for memory length to fix 32-bit
 overflow
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

The alloc_mem() function is supposed to test out of memory conditions.
How it works is it calls mmap() on a giant chunk of memory.
It's either LENGTH (2GB) or "TESTMEM * 2 + TST_MB" (3GB) bytes.
This mmap() is generally supposed to succeed.  Then at the bottom of
the alloc_mem() function when we actually try to use all the memory,
the thread is supposed to die with a SIGKILL.

The problem is that length is signed so on a 32-bit system it will be
negative. That means that at the bottom of the function when we loop
through the memory, the for loop is a no-op and there is no SIGKILL.
Fix this by changing the type to size_t which is unsigned.

Signed-off-by: Ben Copeland <ben.copeland@linaro.org>
---
 testcases/kernel/mem/oom/oom.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/mem/oom/oom.h b/testcases/kernel/mem/oom/oom.h
index 41cc681f9..42ed181b0 100644
--- a/testcases/kernel/mem/oom/oom.h
+++ b/testcases/kernel/mem/oom/oom.h
@@ -62,13 +62,14 @@ static inline void set_global_mempolicy(int mempolicy)
 static void set_global_mempolicy(int mempolicy LTP_ATTRIBUTE_UNUSED) { }
 #endif
 
-static int alloc_mem(long int length, int testcase)
+static int alloc_mem(size_t length, int testcase)
 {
 	char *s;
-	long i, pagesz = getpagesize();
+	size_t i;
+	long pagesz = getpagesize();
 	int loop = 10;
 
-	tst_res(TINFO, "thread (%lx), allocating %ld bytes.",
+	tst_res(TINFO, "thread (%lx), allocating %zu bytes.",
 		(unsigned long) pthread_self(), length);
 
 	s = mmap(NULL, length, PROT_READ | PROT_WRITE,
@@ -111,7 +112,7 @@ static void child_alloc(int testcase, int lite, int threads)
 	pthread_t *th;
 
 	if (lite) {
-		int ret = alloc_mem(TESTMEM * 2 + TST_MB, testcase);
+		int ret = alloc_mem((size_t)TESTMEM * 2 + TST_MB, testcase);
 		exit(ret);
 	}
 
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
