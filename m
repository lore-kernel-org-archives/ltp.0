Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99AA0F557EF
	for <ltp@archiver.kernel.org>; Mon, 20 Apr 2026 10:12:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E61873E2DBE
	for <ltp@archiver.kernel.org>; Mon, 20 Apr 2026 12:12:52 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AE9D63E264F
 for <ltp@lists.linux.it>; Mon, 20 Apr 2026 12:12:33 +0200 (CEST)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com
 [IPv6:2607:f8b0:4864:20::82b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A85756008FA
 for <ltp@lists.linux.it>; Mon, 20 Apr 2026 12:12:32 +0200 (CEST)
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-50baafd6c4aso34028231cf.1
 for <ltp@lists.linux.it>; Mon, 20 Apr 2026 03:12:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776679951; cv=none;
 d=google.com; s=arc-20240605;
 b=frMDrGekkWo5yCgBxbKPsTvpDkIpgb1QdsQZiAyaRGRJ1OtkxcPigiVqSryIFjCV4b
 0K39HtobJEG8a4wFH5ZDeeFiWBoUWQJF4HgBc8hLfX8myPBnoAgclehEdBPvZKcg/kmt
 GYC14v8wpAAZsxBGlC/M6vYLmLIcvHxA27NfvWRGUhSrNTUDKa5ChCoxqYnYzQo/eLLL
 WXfPkXGS1bDSDcV6KvTVOh99Es7KbrLlNUZIAD9j6bMGdEEMFey11S++ungqEJkK3yVt
 KUTfNvqsEmHZRGwMnvFXdsEBcS1h8Fi7gJblxCdr500jmGSC406JihzhjbTQ9ggc1W4q
 dPYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=1/4AZflGvZJsf1IN92T9ukMNX/2xjBErC1z/zar7mGk=;
 fh=zX7aXG63M/MDaAeMtz74XL/j2pKIuI298owFH4lsNpM=;
 b=h5DsJTjZtyFfyDoUSLOViN320VDoQkqGdxu8TuHutCGGruonfFvTx38fiGBEINc3+p
 jFDilCwHEsVq/0tawKePhURekOdbhXSWsouBoW0f/3cCPFHLLlvYH1To3zeZNzDmAaXe
 zvAE6XhpYbEet8GYwvr+U8Kv9xf+SAURFfu0o3EEjqVSAXOL1llnIWDkqiCyXIxW94QT
 9KTqN+wVGbgDddnj+mGl5lveb9MpMJEtjRItmf9NvosrHKGwsFk9fVeMuVFxMxHD+fUb
 i0A92xRqrUZVXfxRo3JWqABeLiCP/Hj/WroyXiGKWGD1z+oFmsOTsK4OMulcHdEv7Z6T
 OwoA==; darn=lists.linux.it
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776679951; x=1777284751; darn=lists.linux.it;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1/4AZflGvZJsf1IN92T9ukMNX/2xjBErC1z/zar7mGk=;
 b=cCLfit6eul5cyq9VButLQNNtxf24wPvKFxKXcHGHZEEoXexOE0DNBu4I3xcOkiZ64J
 ZbeD6EH4C6+b3Kpo0ATwb9N4jDryt1YrcfRILfDKp0IFGcrRXzbeEr5EWzNLBLHUfJ+x
 av2ntg+RwStGmFR+o7r0UO4z3CT3essQSraFLbVjwY9+lkkaCWnIfOsYikgVabxNlnWS
 wBaGyZWAoCcCIL+wqOC9JKAK916pTkv/oIhwsRIACa6KzoPAQ2Sju5SpG3lppR1DC+Jb
 OQsnDq3t4bfQmhY9sivKKUJi3umexRTe3sYbhbJ3+pYG3YMArU0L3aq8Myd8krxBFshd
 qn9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776679951; x=1777284751;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1/4AZflGvZJsf1IN92T9ukMNX/2xjBErC1z/zar7mGk=;
 b=fYTGbixET5Tnmhzt/LvEbPIytbeog6/FGAalfRExtUUNUZTqOJI7RYSKb8Q37+hmqM
 9iTCs6+D1ZdE7o9ZBK4ZYBR3eAujwHutsPtXZ5wcpLVgsemAz4uV238lBPWUn1QY32rL
 cBOXWfqBgbgzfC9KKcy8wAZwF9a2cKJnYv5T+dKGPgBf/KqJghQJ8PkCURqVmX/icOBr
 95POjj+0+fVOOI/CRPBoDHch4S9bFknExvfTK73+JfXPgcRsFaSPcM9zcVMBxs1ygZJq
 L1iyY3cS+EOSFsF7aSBTYx+IAL3e8qwGW0XILM1HrT1+OacL7vg+GcErdcjZwvTQmDAw
 VE9Q==
X-Gm-Message-State: AOJu0YytnFmINdx2Sy+bBcmA7NyXSSYGK/t0lJ7bWG5b176Q9LiJrp6c
 Gcgz6c0n6H5qJa2+OFN75G6TXZ6b06e+X7GJaQUWSOOO4YCUuInPm5A2m8HEWpAoRG1Msa6UxkN
 3uYgHD7Q7rhYf4jiuSLDJdRp2tqTo66fDKhY=
X-Gm-Gg: AeBDieu5oBkw4MvslhuPBPeJhsv5QoKcq3W9S7qwnAngjnRQYTp6be9oElNYC9bN4nl
 uzzDy2tPgoMjylsz78htvcLhc1SAtYbFaWc7DfGVY7eDeqNiEbExL918LuvHrSl8actefhJSH2N
 Ien4Qpbyt2KyAJ37DRS4uHWXfRpdHxUnf+0+sZxKItb1jXX14Ha+BXqXLrgPB1qYOJFeXiiGFXQ
 BGeIpctE0AUEEr3kfevijga9IwdDss1adCzlqdzv2vapmCzvRMB39BaKK8RVVmnx3QHOv/LT3J2
 Bii3xqsRfrPWO50C
X-Received: by 2002:a05:622a:2449:b0:50e:6399:eed4 with SMTP id
 d75a77b69052e-50e6399f879mr21092061cf.27.1776679951318; Mon, 20 Apr 2026
 03:12:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260417065332.23663-1-wegao@suse.com>
 <20260417122804.23890-1-wegao@suse.com>
In-Reply-To: <20260417122804.23890-1-wegao@suse.com>
From: Li Wang <wangli.ahau@gmail.com>
Date: Mon, 20 Apr 2026 18:12:19 +0800
X-Gm-Features: AQROBzCJoUsswJZ0mNlknzEZucMYUoKm7F-7nCwLCeVV32N8R2S4gRqzE-FKmoA
Message-ID: <CANgNiRxgPHo1yQGbT=QGK0NKQEAWO0_9qk6+xiXiC1S6vWvmfw@mail.gmail.com>
To: Wei Gao <wegao@suse.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v8] mremap07.c: New test for mremap() with
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Wei,

This is an excellent test design, but still few places need
refactoring in my opinion.

Wei Gao via ltp <ltp@lists.linux.it> wrote:

> --- a/configure.ac
> +++ b/configure.ac
> @@ -46,6 +46,7 @@ AC_CHECK_DECLS([MADV_MERGEABLE],,,[#include <sys/mman.h>])
>  AC_CHECK_DECLS([NFTA_CHAIN_ID, NFTA_VERDICT_CHAIN_ID],,,[#include <linux/netfilter/nf_tables.h>])
>  AC_CHECK_DECLS([PR_CAPBSET_DROP, PR_CAPBSET_READ],,,[#include <sys/prctl.h>])
>  AC_CHECK_DECLS([SEM_STAT_ANY],,,[#include <sys/sem.h>])
> +AC_CHECK_DECLS([MREMAP_DONTUNMAP],,,[#include <linux/mman.h>])

I didn't go through all the previous discussion, but can we define
MREMAP_DONTUNMAP in the lapi/mmap.h then remove the .min_kver
and TST_TEST_TCONF?

> +++ b/testcases/kernel/syscalls/mremap/mremap07.c
...

> +#define _GNU_SOURCE
> +#include <poll.h>
> +#include <pthread.h>
> +#include <linux/mman.h>
> +
> +#include "tst_test.h"
> +#include "tst_safe_pthread.h"
> +#include "lapi/userfaultfd.h"
> +#include "config.h"
> +
> +#if HAVE_DECL_MREMAP_DONTUNMAP
> +
> +static int page_size;
> +static int uffd = -1;

> +static char *fault_addr;
> +static char *new_remap_addr;

The two variables are not clear enough, I would suggest using
old_addr, new_addr directly.

> +static const char *test_string = "Hello, world! This is a test string that fills up a page.";

We can just define in macro:

    #define TEST_STRING_A "ABCD"
    #define TEST_STRING_B "EFGH"


> +static void setup(void)
> +{
> +       page_size = getpagesize();
> +       struct uffdio_api uffdio_api;
> +       struct uffdio_register uffdio_register;
> +
> +       uffd = SAFE_USERFAULTFD(O_CLOEXEC | O_NONBLOCK, true);
> +
> +       uffdio_api.api = UFFD_API;
> +       uffdio_api.features = 0;
> +       SAFE_IOCTL(uffd, UFFDIO_API, &uffdio_api);
> +
> +       fault_addr = SAFE_MMAP(NULL, page_size,
> +               PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);

When we need indentation it's best to format it via "=" (if you use vim:).
And make the newline start from the first "(" position in a function.

> +
> +       tst_res(TINFO, "Original mapping created at %p", (void *)fault_addr);
> +
> +       strcpy(fault_addr, "ABCD");
> +
> +       uffdio_register.range.start = (unsigned long)fault_addr;
> +       uffdio_register.range.len = page_size;
> +       uffdio_register.mode = UFFDIO_REGISTER_MODE_MISSING;
> +       SAFE_IOCTL(uffd, UFFDIO_REGISTER, &uffdio_register);
> +}
> +
...
> +static void run(void)
> +{
> +       pthread_t handler_thread;
> +
> +       SAFE_PTHREAD_CREATE(&handler_thread, NULL,
> +               fault_handler_thread, NULL);
> +
> +       new_remap_addr = mremap(fault_addr, page_size, page_size,
> +               MREMAP_DONTUNMAP | MREMAP_MAYMOVE, NULL);
> +
> +       if (new_remap_addr == MAP_FAILED)
> +               tst_brk(TBROK | TERRNO, "mremap failed");
> +
> +       tst_res(TINFO, "New mapping created at %p", (void *)new_remap_addr);
> +

I strongly suggest verifying content of thenew_addr right after the
page migration
to ensure the PTEs were moved correctly without data loss.

    TST_EXP_EQ_STR(new_addr, "ABCD");

> +       strcpy(new_remap_addr, test_string);
> +
> +       TST_CHECKPOINT_WAKE(0);
> +
> +       tst_res(TINFO, "Main thread accessing old address %p to trigger fault",
> +                       (void *)fault_addr);
> +
> +       (void)*(volatile char *)fault_addr;
> +
> +       SAFE_PTHREAD_JOIN(handler_thread, NULL);
> +
> +       TST_EXP_EQ_STR(fault_addr, test_string);
> +
> +       SAFE_MUNMAP(new_remap_addr, page_size);

Add strcpy(old_addr, TEST_STRING_A); to support -i N.

Below is a diff version base on your patch:

--- a/testcases/kernel/syscalls/mremap/mremap07.c
+++ b/testcases/kernel/syscalls/mremap/mremap07.c
@@ -25,10 +25,11 @@

 static int page_size;
 static int uffd = -1;
-static char *fault_addr;
-static char *new_remap_addr;
+static char *old_addr;
+static char *new_addr;

-static const char *test_string = "Hello, world! This is a test string
that fills up a page.";
+#define TEST_STRING_A "ABCD"
+#define TEST_STRING_B "EFGH"

 static void *fault_handler_thread(void *arg LTP_ATTRIBUTE_UNUSED)
 {
@@ -55,13 +56,13 @@ static void *fault_handler_thread(void *arg
LTP_ATTRIBUTE_UNUSED)
        if (msg.event != UFFD_EVENT_PAGEFAULT)
                tst_brk(TBROK, "Received unexpected UFFD_EVENT: %d", msg.event);

-       if ((char *)msg.arg.pagefault.address != fault_addr)
+       if ((char *)msg.arg.pagefault.address != old_addr)
                tst_brk(TBROK, "Page fault on unexpected address: %p",
(void *)msg.arg.pagefault.address);

        tst_res(TINFO, "Userfaultfd handler caught a page fault at
%p", (void *)msg.arg.pagefault.address);

-       uffdio_copy.src = (unsigned long)new_remap_addr;
-       uffdio_copy.dst = (unsigned long)fault_addr;
+       uffdio_copy.src = (unsigned long)new_addr;
+       uffdio_copy.dst = (unsigned long)old_addr;
        uffdio_copy.len = page_size;
        uffdio_copy.mode = 0;
        uffdio_copy.copy = 0;
@@ -74,24 +75,26 @@ static void *fault_handler_thread(void *arg
LTP_ATTRIBUTE_UNUSED)

 static void setup(void)
 {
-       page_size = getpagesize();
        struct uffdio_api uffdio_api;
        struct uffdio_register uffdio_register;

+       page_size = getpagesize();
        uffd = SAFE_USERFAULTFD(O_CLOEXEC | O_NONBLOCK, true);

        uffdio_api.api = UFFD_API;
        uffdio_api.features = 0;
        SAFE_IOCTL(uffd, UFFDIO_API, &uffdio_api);

-       fault_addr = SAFE_MMAP(NULL, page_size,
-               PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+       old_addr = SAFE_MMAP(NULL, page_size,
+                       PROT_READ | PROT_WRITE,
+                       MAP_PRIVATE | MAP_ANONYMOUS,
+                       -1, 0);

-       tst_res(TINFO, "Original mapping created at %p", (void *)fault_addr);
+       tst_res(TINFO, "Original mapping created at %p", (void *)old_addr);

-       strcpy(fault_addr, "ABCD");
+       strcpy(old_addr, TEST_STRING_A);

-       uffdio_register.range.start = (unsigned long)fault_addr;
+       uffdio_register.range.start = (unsigned long)old_addr;
        uffdio_register.range.len = page_size;
        uffdio_register.mode = UFFDIO_REGISTER_MODE_MISSING;
        SAFE_IOCTL(uffd, UFFDIO_REGISTER, &uffdio_register);
@@ -99,11 +102,11 @@ static void setup(void)

 static void cleanup(void)
 {
-       if (new_remap_addr && new_remap_addr != MAP_FAILED)
-               SAFE_MUNMAP(new_remap_addr, page_size);
+       if (new_addr && new_addr != MAP_FAILED)
+               SAFE_MUNMAP(new_addr, page_size);

-       if (fault_addr && fault_addr != MAP_FAILED)
-               SAFE_MUNMAP(fault_addr, page_size);
+       if (old_addr && old_addr != MAP_FAILED)
+               SAFE_MUNMAP(old_addr, page_size);

        if (uffd != -1)
                SAFE_CLOSE(uffd);
@@ -111,34 +114,36 @@ static void cleanup(void)

 static void run(void)
 {
+       new_addr = NULL;
        pthread_t handler_thread;

        SAFE_PTHREAD_CREATE(&handler_thread, NULL,
-               fault_handler_thread, NULL);
+                               fault_handler_thread, NULL);

-       new_remap_addr = mremap(fault_addr, page_size, page_size,
-               MREMAP_DONTUNMAP | MREMAP_MAYMOVE, NULL);
+       new_addr = mremap(old_addr, page_size, page_size,
+                               MREMAP_DONTUNMAP | MREMAP_MAYMOVE, NULL);

-       if (new_remap_addr == MAP_FAILED)
+       if (new_addr == MAP_FAILED)
                tst_brk(TBROK | TERRNO, "mremap failed");

-       tst_res(TINFO, "New mapping created at %p", (void *)new_remap_addr);
+       tst_res(TINFO, "New mapping created at %p", (void *)new_addr);

-       strcpy(new_remap_addr, test_string);
+       TST_EXP_EQ_STR(new_addr, TEST_STRING_A);
+       strcpy(new_addr, TEST_STRING_B);

        TST_CHECKPOINT_WAKE(0);

        tst_res(TINFO, "Main thread accessing old address %p to trigger fault",
-                       (void *)fault_addr);
+                       (void *)old_addr);

-       (void)*(volatile char *)fault_addr;
+       (void)*(volatile char *)old_addr;

        SAFE_PTHREAD_JOIN(handler_thread, NULL);

-       TST_EXP_EQ_STR(fault_addr, test_string);
+       TST_EXP_EQ_STR(old_addr, TEST_STRING_B);

-       SAFE_MUNMAP(new_remap_addr, page_size);
-       new_remap_addr = NULL;
+       SAFE_MUNMAP(new_addr, page_size);
+       strcpy(old_addr, TEST_STRING_A);
 }

 static struct tst_test test = {



-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
