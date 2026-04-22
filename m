Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02373F94CB2
	for <ltp@archiver.kernel.org>; Wed, 22 Apr 2026 05:15:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C38F83E259F
	for <ltp@archiver.kernel.org>; Wed, 22 Apr 2026 07:15:00 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A55CF3E1A84
 for <ltp@lists.linux.it>; Wed, 22 Apr 2026 07:14:42 +0200 (CEST)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com
 [IPv6:2607:f8b0:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 7F26E600726
 for <ltp@lists.linux.it>; Wed, 22 Apr 2026 07:14:41 +0200 (CEST)
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-82d0b68837aso3249574b3a.2
 for <ltp@lists.linux.it>; Tue, 21 Apr 2026 22:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776834880; x=1777439680; darn=lists.linux.it;
 h=content-disposition:mime-version:mail-followup-to:reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VUpuNXvb7bBCUkBFeFYAhZOJsWy+kONaYrEA9R0K2sQ=;
 b=ELYZPgp7+GxYbnSUH/b4m9zBPbyOs6Zu0xHQJ/ORCUMAbQtQYdV2Z37E38CnuUJ2B2
 l4B03yKKUI2tZNij1060KeguroHtghKTYjr/jX1Nd2/r76lLAEvRFhzIvxyR2nzDqUHT
 6EuJJLJ/Fz6raiAtp5nmNiv+VPm3x2wt/LYZmL8LVDmf+/czASUOUc9CItgYryBj/Br/
 3QXxt4UkUcO5qvUGv3g2tpjlxWzRSfOxB3SMlWhvFCw8CO2wN1cPBB06zolLTOyoha5k
 T2nIZcBlcpm1WiXd8SXQBE+E4QQM8S4orJe/MlvU6GbiV6d4JoDuogJedRMVoVdIwZ9A
 nR0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776834880; x=1777439680;
 h=content-disposition:mime-version:mail-followup-to:reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VUpuNXvb7bBCUkBFeFYAhZOJsWy+kONaYrEA9R0K2sQ=;
 b=J/6Met/nk9Ad0a5XsAlKKUPNOiGVKAJKvfir06U6KLeh6c7Nk0dchl9P4EKHPJx2QA
 tzr0YVksJa6vJedtBPtCNth7bQ/XNm46vPwFIufT2IRvpi0rznyPDF2qmsH9+pXkhcRL
 IYoeF3tGMx4or+mf+KDWenxyu5njmME62QGoUaMHRJ+w0sOm2F7UCPO+5VqJTPBvfFln
 hrbqUqDV/H0peYXzZFlJxEep4mZ0ssNLgbpktkIGzwO/n4DfNEcI/aJ9pRtstWFIZwlU
 EEOJ6WRnRZ44BPcHrhPmO+FiI1TD+34Z8RKJxWLv1K0KdWzRvIf/jMQOxgXNC0y5K+Kj
 Rt4A==
X-Gm-Message-State: AOJu0YxKDIOrKrVWz4Vr1/S1DgNhFDgQdbLFUQvqt5nUbl1fexQWsnuP
 lYa5SdyS0O8jvyMNHlB58nHZCvOBC3lyQW/9AAFIN/Ja7L4ezXylYsM=
X-Gm-Gg: AeBDievuJjQ8DFFPDQDZ8gEBEYNBXfe1hozxzmT3tVAW6vCFc1G5E4irYhXqzczHOUi
 +GWAmSX1ri26OWRnvru90Diz1euX0MkBMWa+6+KAFxvsbDSlMzJqekKF0JN0BD8QobsEHGBPW8O
 0jOusoB7J6MnfkQTWABZpkpEX2AGP1XkNSiibnr1BR7Y77wyZ0qP1OXGfxK0x161+90S8OLwz2j
 PQr4CKdEL4P/4hYKC5G+zD51I5B+Ymld+JCQQyHDIy9eFD1F4Q+DCdr7r4VEBi4Hwq/Om2XPST7
 QK40UvODFtac7syvC5Bo3z9wTvgmn+ecDMlUE2cXa97uAkl1kW9QlW1nn2I2Kl9QtTs39k1qjm6
 xe88a21nGJB2oCPgnFzwIQHtClx6uC6LZalUJ02azTnd3o2PBD49poWIo1t3zetH+CCc3vj/ZHc
 EIJdro7q2bTsQm5zrLIPCSU0HXhQG3Iy5J
X-Received: by 2002:a05:6a00:340a:b0:82c:ae0e:dea with SMTP id
 d2e1a72fcca58-82f8c8c39b8mr19343723b3a.32.1776834879787; 
 Tue, 21 Apr 2026 22:14:39 -0700 (PDT)
Received: from localhost ([209.132.188.88]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f8ebb38ddsm14970955b3a.34.2026.04.21.22.14.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 22:14:39 -0700 (PDT)
Date: Wed, 22 Apr 2026 13:14:36 +0800
From: Li Wang <wangli.ahau@gmail.com>
To: Wei Gao <wegao@suse.com>
Message-ID: <aehZPI4rKuzujsj6@gmail.com>
Mail-Followup-To: Wei Gao <wegao@suse.com>, ltp@lists.linux.it,
 Andrea Cervesato <andrea.cervesato@suse.com>,
 Petr Vorel <pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v9] mremap07.c: New test for mremap() with
 MREMAP_DONTUNMAP
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
Reply-To: 20260422023115.27534-1-wegao@suse.com
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Wei,

Wei Gao wrote:

> This test verifies the mremap() syscall with the MREMAP_DONTUNMAP flag.
> It uses userfaultfd to verify that accessing the old memory region
> correctly triggers a page fault after the mapping has been moved.
> 
> MREMAP_DONTUNMAP behavior with userfaultfd was not covered by existing
> mremap tests. This test provides coverage for the feature requested in
> the linked issue.
> 
> Closes: https://github.com/linux-test-project/ltp/issues/1168
> Signed-off-by: Wei Gao <wegao@suse.com>
> ---
> v8->v9:
> - Removed `MREMAP_DONTUNMAP` check from `configure.ac` and moved fallback to `include/lapi/mmap.h`.
> - Renamed address variables to `old_addr` and `new_addr` for clarity.
> - Replaced hardcoded strings with `TEST_STRING_A` and `TEST_STRING_B` macros.
> - Improved code formatting and indentation.
> - Removed `.min_kver = "5.7"` in favor of dynamic feature detection.
> - Added runtime `EINVAL` check to trigger `TCONF` on unsupported kernels.
> - Added verification logic for data content at `new_addr`.
> - Fixed stability issues for multiple test iterations (`-i` option).

Patch merged with some improvements (for better readability and reliability):

--- a/testcases/kernel/syscalls/mremap/mremap07.c
+++ b/testcases/kernel/syscalls/mremap/mremap07.c
@@ -19,7 +19,6 @@
 #include "tst_safe_pthread.h"
 #include "lapi/userfaultfd.h"
 #include "lapi/mmap.h"
-#include "config.h"

 static int page_size;
 static int uffd = -1;
@@ -33,33 +32,24 @@ static void *fault_handler_thread(void *arg LTP_ATTRIBUTE_UNUSED)
 {
        struct uffd_msg msg;
        struct uffdio_copy uffdio_copy;
+       struct pollfd pollfd = { .fd = uffd, .events = POLLIN };

        TST_CHECKPOINT_WAIT(0);

-       struct pollfd pollfd;
-
-       pollfd.fd = uffd;
-       pollfd.events = POLLIN;
-
-       int nready = poll(&pollfd, 1, -1);
-
-       if (nready == -1)
+       if (poll(&pollfd, 1, -1) == -1)
                tst_brk(TBROK | TERRNO, "poll() failed");

-       if (nready == 0)
-               tst_brk(TBROK, "poll() timed out unexpectedly");
-
        SAFE_READ(1, uffd, &msg, sizeof(msg));

        if (msg.event != UFFD_EVENT_PAGEFAULT)
                tst_brk(TBROK, "Received unexpected UFFD_EVENT: %d", msg.event);

-       if ((char *)msg.arg.pagefault.address != old_addr)
+       if (msg.arg.pagefault.address != (unsigned long)old_addr)
                tst_brk(TBROK, "Page fault on unexpected address: %p",
-                       (void *)msg.arg.pagefault.address);
+                               (void *)msg.arg.pagefault.address);

        tst_res(TINFO, "Userfaultfd handler caught a page fault at %p",
-               (void *)msg.arg.pagefault.address);
+                       (void *)msg.arg.pagefault.address);

        uffdio_copy.src = (unsigned long)new_addr;
        uffdio_copy.dst = (unsigned long)old_addr;
@@ -73,12 +63,32 @@ static void *fault_handler_thread(void *arg LTP_ATTRIBUTE_UNUSED)
        return NULL;
 }

+static void check_mremap_dontunmap(void)
+{
+       char *test = SAFE_MMAP(NULL, page_size, PROT_READ | PROT_WRITE,
+                               MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+
+       char *tmp = mremap(test, page_size, page_size,
+                               MREMAP_DONTUNMAP | MREMAP_MAYMOVE, NULL);
+
+       if (tmp == MAP_FAILED) {
+               if (errno == EINVAL)
+                       tst_brk(TCONF | TERRNO,
+                                       "MREMAP_DONTUNMAP not supported");
+               tst_brk(TBROK | TERRNO, "mremap failed");
+       }
+
+       SAFE_MUNMAP(tmp, page_size);
+       SAFE_MUNMAP(test, page_size);
+}
+
 static void setup(void)
 {
        struct uffdio_api uffdio_api;
        struct uffdio_register uffdio_register;

        page_size = getpagesize();
+       check_mremap_dontunmap();
        uffd = SAFE_USERFAULTFD(O_CLOEXEC | O_NONBLOCK, true);

        uffdio_api.api = UFFD_API;
@@ -92,7 +102,7 @@ static void setup(void)

        tst_res(TINFO, "Original mapping created at %p", (void *)old_addr);

-       strcpy(old_addr, TEST_STRING_A);
+       memcpy(old_addr, TEST_STRING_A, sizeof(TEST_STRING_A));

        uffdio_register.range.start = (unsigned long)old_addr;
        uffdio_register.range.len = page_size;
@@ -118,23 +128,17 @@ static void run(void)
        pthread_t handler_thread;

        SAFE_PTHREAD_CREATE(&handler_thread, NULL,
-                           fault_handler_thread, NULL);
+                               fault_handler_thread, NULL);

        new_addr = mremap(old_addr, page_size, page_size,
-                         MREMAP_DONTUNMAP | MREMAP_MAYMOVE, NULL);
-
-       if (new_addr == MAP_FAILED) {
-               if (errno == EINVAL) {
-                       tst_brk(TCONF | TERRNO,
-                               "mremap with MREMAP_DONTUNMAP not supported?");
-               }
+                               MREMAP_DONTUNMAP | MREMAP_MAYMOVE, NULL);
+       if (new_addr == MAP_FAILED)
                tst_brk(TBROK | TERRNO, "mremap failed");
-       }

        tst_res(TINFO, "New mapping created at %p", (void *)new_addr);

        TST_EXP_EQ_STR(new_addr, TEST_STRING_A);
-       strcpy(new_addr, TEST_STRING_B);
+       memcpy(new_addr, TEST_STRING_B, sizeof(TEST_STRING_B));

        TST_CHECKPOINT_WAKE(0);

@@ -148,8 +152,7 @@ static void run(void)
        TST_EXP_EQ_STR(old_addr, TEST_STRING_B);

        SAFE_MUNMAP(new_addr, page_size);
-       new_addr = NULL;
-       strcpy(old_addr, TEST_STRING_A);
+       memcpy(old_addr, TEST_STRING_A, sizeof(TEST_STRING_A));
 }

 static struct tst_test test = {

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
