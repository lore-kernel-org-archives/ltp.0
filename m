Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD221C3DA7A
	for <ltp@archiver.kernel.org>; Fri,  6 Jan 2023 05:21:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6A2953CB7E3
	for <ltp@archiver.kernel.org>; Fri,  6 Jan 2023 06:21:06 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D78233C2461
 for <ltp@lists.linux.it>; Fri,  6 Jan 2023 06:20:52 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id F1A6C1A0048F
 for <ltp@lists.linux.it>; Fri,  6 Jan 2023 06:20:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1672982449;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XhelEfje8iEYJLmojFVYloYwGa2pFzPZFRj0jNiSjtw=;
 b=TK4H2D1BMU3Scq2thMxE1FpcWAodK8rlCnQEjCMACZ6mfNu+glzeA0QNKHsnRNuu4NvIis
 lFdCnSiIue/ddCjT72CCKwMQQVsIn34VAp6CZAdgyKsN7zsxfPGb6B3tiAe0kTQCoE6Ff4
 RYhlBocM3wl67BUUsGHJtVMeAISeXKI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-404-QThygSlqN4CoKypG3T5RRg-1; Fri, 06 Jan 2023 00:20:47 -0500
X-MC-Unique: QThygSlqN4CoKypG3T5RRg-1
Received: by mail-wm1-f69.google.com with SMTP id
 a6-20020a05600c224600b003d1f3ed49adso112648wmm.4
 for <ltp@lists.linux.it>; Thu, 05 Jan 2023 21:20:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XhelEfje8iEYJLmojFVYloYwGa2pFzPZFRj0jNiSjtw=;
 b=X8pKGqv/mAilyA2v3r6Y9urSVh9epm1VZteO4iIBcVHejWF58foNJ515TaCbKqIhi1
 UfTGZiAbdtbrsgJa9/q1FCnNm6G1vjH3QNA/D1ku3ecB7IEtOojt2Z6g+kEXimJEA7ZZ
 c6GEeTAlOWV+DzyCUqnB8+YbkvwTioD2uCRyBXHDlTaO/VwxEK5SS8mF6t1JwsFT7WT0
 Vs0ljEtUBqDWd1f4pZkcH/838xKCtGHorl3TZySs9mNnmLuCKAQdvgkUn9yXTrnrLvvx
 NoWDh+erQWY+dMQRDrzPM77zIOjivdjSJE5xQvDZBQ0zFKl0Uv4aaFck1bYDUIJVEsrI
 c+8Q==
X-Gm-Message-State: AFqh2kr+i9xTDTJeb30K/7fjPqH3TTUnzzIzsW1LVydVmDmhytfw2zKI
 7xdav0qV6uA364cikQNri05AuRdLZUwpZV04cHBXYrdnThZv7qmvDZMVfAlhZlWl2658KuhvgOn
 QqJQ0uepcGGiOpYSJ7yj+Pryg4Bw=
X-Received: by 2002:a05:600c:501f:b0:3d1:de6e:8afb with SMTP id
 n31-20020a05600c501f00b003d1de6e8afbmr3654472wmr.92.1672982445971; 
 Thu, 05 Jan 2023 21:20:45 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuLDwfDMHURmUN68HKo3eBHzvZzwmx1xwVxNHH4SYbhlahb+WcnzBOaxKG5QLpWA7oJl1R9OO3FRnS9eY9yUK8=
X-Received: by 2002:a05:600c:501f:b0:3d1:de6e:8afb with SMTP id
 n31-20020a05600c501f00b003d1de6e8afbmr3654468wmr.92.1672982445562; Thu, 05
 Jan 2023 21:20:45 -0800 (PST)
MIME-Version: 1.0
References: <20230104122224.369467-1-tsahu@linux.ibm.com>
In-Reply-To: <20230104122224.369467-1-tsahu@linux.ibm.com>
From: Li Wang <liwang@redhat.com>
Date: Fri, 6 Jan 2023 13:20:34 +0800
Message-ID: <CAEemH2eMBOKLknhqpWO4Kcnrpf5y3oHXzaZyYKpT5Ey5qrZ=iw@mail.gmail.com>
To: Tarun Sahu <tsahu@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2 0/13][PART 4] Hugetlb:Migrating the
 libhugetlbfs tests
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
Cc: sbhat@linux.ibm.com, aneesh.kumar@linux.ibm.com, geetika@linux.ibm.com,
 vaibhav@linux.ibm.com, rpalethorpe@suse.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Tarrun,

Thanks for your work! I did some cleanup and merged all.

--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap20.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap20.c
@@ -14,40 +14,41 @@
 #include "hugetlb.h"

 #define MNTPOINT "hugetlbfs/"
-static int  fd = -1;
+
+static int fd = -1;
 static unsigned long hpage_size;
-static struct testcase {
+
+static struct tcase {
        int flags;
        char *flags_str;
-} testcases[] = {
+} tcases[] = {
        {MAP_PRIVATE, "MAP_PRIVATE"},
        {MAP_SHARED, "MAP_SHARED"},
-       {MAP_PRIVATE|MAP_LOCKED, "MAP_PRIVATE|MAP_LOCKED"},
-       {MAP_SHARED|MAP_LOCKED, "MAP_SHARED|MAP_LOCKED"},
+       {MAP_PRIVATE | MAP_LOCKED, "MAP_PRIVATE | MAP_LOCKED"},
+       {MAP_SHARED | MAP_LOCKED, "MAP_SHARED | MAP_LOCKED"},
 };

-static void run_test(unsigned int num)
+static void run_test(unsigned int i)
 {
-       void *p;
-       int flags = testcases[num].flags;
-       char *flags_str = testcases[num].flags_str;
        int ret;
+       void *p;
+       struct tcase *tc = &tcases[i];

        fd = tst_creat_unlinked(MNTPOINT, 0);
-       p = SAFE_MMAP(0, hpage_size, PROT_READ|PROT_WRITE, flags, fd, 0);
+       p = SAFE_MMAP(0, hpage_size, PROT_READ|PROT_WRITE, tc->flags, fd,
0);

        ret = mlock(p, hpage_size);
        if (ret) {
-               tst_res(TFAIL|TERRNO, "mlock() failed (flags %s)",
flags_str);
+               tst_res(TFAIL|TERRNO, "mlock() failed (flags %s)",
tc->flags_str);
                goto cleanup;
        }

        ret = munlock(p, hpage_size);
        if (ret)
-               tst_res(TFAIL|TERRNO, "munlock() failed (flags %s)",
flags_str);
+               tst_res(TFAIL|TERRNO, "munlock() failed (flags %s)",
tc->flags_str);
        else
-               tst_res(TPASS, "mlock/munlock with %s hugetlb mmap",
-                               flags_str);
+               tst_res(TPASS, "mlock/munlock with %s hugetlb mmap",
tc->flags_str);
+
 cleanup:
        SAFE_MUNMAP(p, hpage_size);
        SAFE_CLOSE(fd);
@@ -74,7 +75,7 @@ static void cleanup(void)
 }

 static struct tst_test test = {
-       .tcnt = ARRAY_SIZE(testcases),
+       .tcnt = ARRAY_SIZE(tcases),
        .needs_root = 1,
        .mntpoint = MNTPOINT,
        .needs_hugetlbfs = 1,
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap21.c
b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap21.c
index ce3c5866e..a8e332ebd 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap21.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap21.c
@@ -37,16 +37,18 @@ static void do_work(int thread, size_t size, int fd)
                memcpy((char *)addr+i, &pattern, 1);

        if (msync(addr, size, MS_SYNC))
-               tst_brk(TBROK|TERRNO, "Thread %d (pid %d): msync() failed",
+               tst_brk(TBROK | TERRNO, "Thread %d (pid %d): msync()
failed",
                                thread, getpid());

-       for (i = 0; i < size; i++)
+       for (i = 0; i < size; i++) {
                if (addr[i] != pattern) {
                        tst_res(TFAIL, "thread %d (pid: %d): Corruption at
%p; "
                                   "Got %c, Expected %c", thread, getpid(),
                                   &addr[i], addr[i], pattern);
                        goto cleanup;
                }
+       }
+
        tst_res(TINFO, "Thread %d (pid %d): Pattern verified",
                        thread, getpid());

@@ -57,21 +59,21 @@ cleanup:

 static void run_test(void)
 {
+       int i, pid;
        char *addr;
        size_t size, itr;
-       int i, pid;
        pid_t *wait_list;

        wait_list = SAFE_MALLOC(THREADS * sizeof(pid_t));
        size = (NR_HUGEPAGES / (THREADS+1)) * hpage_size;

-
-       /* First, mmap the file with MAP_SHARED and fill with data
+       /*
+        * First, mmap the file with MAP_SHARED and fill with data
         * If this is not done, then the fault handler will not be
         * called in the kernel since private mappings will be
         * created for the children at prefault time.
         */
-       addr = SAFE_MMAP(NULL, size, PROT_READ|PROT_WRITE, MAP_SHARED, fd,
0);
+       addr = SAFE_MMAP(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED,
fd, 0);

        for (itr = 0; itr < size; itr += 8)
                memcpy(addr+itr, "deadbeef", 8);
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap22.c
b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap22.c
index 567d0448c..c2deab477 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap22.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap22.c
@@ -42,6 +42,7 @@ static void run_test(unsigned int iter)
                        }
                }
        }
+
        for (i = 0; i < NR_HUGEPAGES; i++) {
                pattern = 65+(i%26);
                memset(m+(i*hpage_size), pattern, hpage_size);
@@ -58,6 +59,7 @@ static void run_test(unsigned int iter)
                        }
                }
        }
+
        tst_res(TPASS, "Iter %u: Successfully verified the mmap area.",
iter);

 cleanup:
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap23.c
b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap23.c
index dcb9abff7..4c1cff325 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap23.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap23.c
@@ -22,7 +22,8 @@ static sigjmp_buf sig_escape;
 static void *sig_expected = MAP_FAILED;
 static long hpage_size;
 static void *addr;
-static struct testcase {
+
+static struct tcase {
        char *tname;
        unsigned long len1;
        int prot1;
@@ -53,14 +54,16 @@ static struct testcase {
 static void sig_handler(int signum, siginfo_t *si, void *uc)
 {
        (void)uc;
+
        if (signum == SIGSEGV) {
                tst_res(TINFO, "SIGSEGV at %p (sig_expected=%p)",
si->si_addr,
                       sig_expected);
                if (si->si_addr == sig_expected)
                        siglongjmp(sig_escape, 1);
                tst_res(TFAIL, "SIGSEGV somewhere unexpected");
-       } else
+       } else {
                tst_res(TFAIL, "Unexpected signal %s", strsignal(signum));
+       }
 }

 static int test_read(void *p)
@@ -118,7 +121,6 @@ static int test_prot(void *p, int prot, char *prot_str)
                        tst_res(TFAIL, "read failed on mmap(prot %s)",
prot_str);
                        return -1;
                }
-
        } else {
                if (r != -1) {
                        tst_res(TFAIL, "read succeeded on mmap(prot %s)",
prot_str);
@@ -155,39 +157,42 @@ static int test_prot(void *p, int prot, char
*prot_str)
                        break;
                }
        }
+
        return 0;
 }

-static void run_test(unsigned int num)
+static void run_test(unsigned int i)
 {
        void *p;
        int ret;
+       struct tcase *tc = &tcases[i];

-       tst_res(TINFO, "Test Name: %s", tcases[num].tname);
+       tst_res(TINFO, "Test Name: %s", tc->tname);

-       p = SAFE_MMAP(NULL, tcases[num].len1*hpage_size,
-                       tcases[num].prot1, MAP_SHARED, fd, 0);
+       p = SAFE_MMAP(NULL, tc->len1*hpage_size, tc->prot1, MAP_SHARED, fd,
0);

-       ret = test_prot(p, tcases[num].prot1, tcases[num].prot1_str);
+       ret = test_prot(p, tc->prot1, tc->prot1_str);
        if (ret)
                goto cleanup;
-       ret = mprotect(p, tcases[num].len2*hpage_size, tcases[num].prot2);
+
+       ret = mprotect(p, tc->len2*hpage_size, tc->prot2);
        if (ret != 0) {
                tst_res(TFAIL|TERRNO, "%s: mprotect(prot %s)",
-                               tcases[num].tname, tcases[num].prot2_str);
+                               tc->tname, tc->prot2_str);
                goto cleanup;
        }

-       ret = test_prot(p, tcases[num].prot2, tcases[num].prot2_str);
+       ret = test_prot(p, tc->prot2, tc->prot2_str);
        if (ret)
                goto cleanup;
-       if (tcases[num].len2 < tcases[num].len1)
-               ret = test_prot(p + tcases[num].len2*hpage_size,
tcases[num].prot1,
-                               tcases[num].prot1_str);

-       tst_res(TPASS, "Successfully tested mprotect %s",
tcases[num].tname);
+       if (tc->len2 < tc->len1)
+               ret = test_prot(p + tc->len2*hpage_size, tc->prot1,
tc->prot1_str);
+
+       tst_res(TPASS, "Successfully tested mprotect %s", tc->tname);
+
 cleanup:
-       SAFE_MUNMAP(p, tcases[num].len1*hpage_size);
+       SAFE_MUNMAP(p, tc->len1*hpage_size);
 }

 static void setup(void)
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap24.c
b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap24.c
index 3316f04c2..a465aadec 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap24.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap24.c
@@ -65,7 +65,9 @@ static int init_slice_boundary(int fd)
                tst_res(TFAIL|TERRNO, "couldn't find 2 free neighbour
slices");
                return -1;
        }
+
        tst_res(TINFO, "using slice_boundary: 0x%lx", slice_boundary);
+
        return 0;
 }

@@ -152,7 +154,9 @@ static void run_test(void)
        }
        if (ret)
                goto cleanup;
+
        tst_res(TPASS, "Successful");
+
 cleanup:
        if (p)
                SAFE_MUNMAP(p, p_size);
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap25.c
b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap25.c
index 055a430e2..71beb90d3 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap25.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap25.c
@@ -33,14 +33,17 @@ static int do_remap(int fd, void *target)
        ret = do_readback(a, hpage_size, "base huge");
        if (ret)
                goto cleanup;
+
        b = mremap(a, hpage_size, hpage_size, MREMAP_MAYMOVE | MREMAP_FIXED,
                   target);

        if (b != MAP_FAILED) {
                ret = do_readback(b, hpage_size, "remapped");
                a = b;
-       } else
+       } else {
                tst_res(TINFO|TERRNO, "mremap(MAYMOVE|FIXED) disallowed");
+       }
+
 cleanup:
        SAFE_MUNMAP(a, hpage_size);
        return ret;
@@ -85,12 +88,15 @@ static void run_test(void)
        ret = do_readback(p, hpage_size, "base normal page");
        if (ret)
                goto cleanup;
+
        ret = do_remap(fd, p - hpage_size);
        if (ret)
                goto cleanup;
+
        ret = do_remap(fd, p + hpage_size);
        if (ret == 0)
                tst_res(TPASS, "Successfully tested mremap hpage near
normal mapping");
+
 cleanup:
        SAFE_CLOSE(fd);
 }
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap26.c
b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap26.c
index db2d9ce81..609f2b63b 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap26.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap26.c
@@ -34,14 +34,16 @@ static int do_remap(void *target)
        ret = do_readback(a, page_size, "base normal");
        if (ret)
                goto cleanup;
+
        b = mremap(a, page_size, page_size, MREMAP_MAYMOVE | MREMAP_FIXED,
                   target);

        if (b != MAP_FAILED) {
                do_readback(b, page_size, "remapped");
                a = b;
-       } else
+       } else {
                tst_res(TINFO|TERRNO, "mremap(MAYMOVE|FIXED) disallowed");
+       }

 cleanup:
        SAFE_MUNMAP(a, page_size);
@@ -54,8 +56,7 @@ static void run_test(void)
        int ret;

        fd = tst_creat_unlinked(MNTPOINT, 0);
-       p = SAFE_MMAP(NULL, 3*hpage_size, PROT_READ|PROT_WRITE, MAP_SHARED,
-                fd, 0);
+       p = SAFE_MMAP(NULL, 3*hpage_size, PROT_READ|PROT_WRITE, MAP_SHARED,
fd, 0);

        SAFE_MUNMAP(p, hpage_size);

@@ -68,12 +69,15 @@ static void run_test(void)
        ret = do_readback(p, hpage_size, "base hugepage");
        if (ret)
                goto cleanup;
+
        ret = do_remap(p - page_size);
        if (ret)
                goto cleanup;
+
        ret = do_remap(p + hpage_size);
        if (ret == 0)
                tst_res(TPASS, "Successfully tested mremap normal near
hpage mapping");
+
 cleanup:
        SAFE_MUNMAP(p, hpage_size);
        SAFE_CLOSE(fd);
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap27.c
b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap27.c
index 42dc55558..218d9e190 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap27.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap27.c
@@ -14,7 +14,6 @@
  */

 #include <setjmp.h>
-
 #include "hugetlb.h"

 #define MNTPOINT "hugetlbfs/"
@@ -26,13 +25,15 @@ static void *sig_expected = MAP_FAILED;
 static void sig_handler(int signum, siginfo_t *si, void *uc)
 {
        (void)uc;
+
        if (signum == SIGBUS) {
                if (si->si_addr == sig_expected)
                        siglongjmp(sig_escape, 1);
                tst_res(TFAIL, "SIGBUS somewhere unexpected: %p (expected:
%p)",
                                si->si_addr, sig_expected);
-       } else
+       } else {
                tst_res(TFAIL, "Unexpected signal %s", strsignal(signum));
+       }
 }

 static int test_write(void *p)
@@ -81,6 +82,7 @@ static void run_test(void)
                tst_res(TPASS, "Successful with SIGSEGV received");
                goto cleanup;
        }
+
        /* Provisioning succeeded because of overcommit */
        if (SAFE_READ_MEMINFO(MEMINFO_HPAGE_SURP) ==
                        surp_hugepages + 1) {



-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
