Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17BE6C4332F
	for <ltp@archiver.kernel.org>; Mon, 26 Dec 2022 06:57:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 952AA3CB86C
	for <ltp@archiver.kernel.org>; Mon, 26 Dec 2022 07:57:39 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 58A2B3C8524
 for <ltp@lists.linux.it>; Mon, 26 Dec 2022 07:57:30 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 19FBD600641
 for <ltp@lists.linux.it>; Mon, 26 Dec 2022 07:57:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1672037847;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DcTK8AK43+/facpewyegSYfAU3CNKGn/sd8DZv63L0w=;
 b=c8t4DkFhKb9KMq+2z3QB+vB8V3kZYBJ1ffYOYR2T9FWjETFcNUOc6OHDMgTeOXt56a71yX
 MopW8jvct/zbB5oP0pvq9Nde7QzfF52E9OJt7b9sOaMb+SMcP5pmCbTaNUEPiNE0Msp4Xa
 Ek8mgmxwhKhHc0acAQpRM/Cz5VgS25s=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-218-n03wdCxfMQ2oPJRYSDD_-Q-1; Mon, 26 Dec 2022 01:57:25 -0500
X-MC-Unique: n03wdCxfMQ2oPJRYSDD_-Q-1
Received: by mail-wm1-f72.google.com with SMTP id
 m38-20020a05600c3b2600b003d23f8c6ebdso4739865wms.0
 for <ltp@lists.linux.it>; Sun, 25 Dec 2022 22:57:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DcTK8AK43+/facpewyegSYfAU3CNKGn/sd8DZv63L0w=;
 b=gR9hI6dcnyewho/5hqWBgyp9745QkqeNmYgDOgT/EusmdfJHrkDQmqy4MfJT1lZ9TQ
 Xe8ejjST5RDfv7pCkYcH2QKe1iMFcY/CvZrQc1lU2S2/KdK5HleSAc7U1kjPgerDRXUB
 yKHd0k3KpSHeW6KfI1e+0oegwUG+Jv0dPnRZbhpclHlH961Z9EX4hOIbGJZ2QOYJ3OIb
 MyZPP2k7TbjeRVCKrqgVrcrfykbJiptQ9l8iDWuUcJMKTEhkT8OimA1FrKIGC3Hq3hUZ
 QTUsCbX1CgYzZmhlZA7NplmSpJ+HypEfSzeh9DnafOLloZXArdpKzAe7DMp72HoawHQM
 KKEg==
X-Gm-Message-State: AFqh2kryFgT5bKf9Kmf4FJUtMNV4zpBGVa8QB13RMAcgM3Jo1jxbAzfj
 KeI0AZ1+HwyuymEKA2/1uSaF/psnJhlPD4ZaJA/Vo1nC3F8m7da/kkHgmuiMD1Ctt+pf8q07+QV
 khHyD6a9bJSWQ7Ag0LN69j20v+0o=
X-Received: by 2002:a5d:444d:0:b0:242:3a48:1757 with SMTP id
 x13-20020a5d444d000000b002423a481757mr666159wrr.528.1672037844043; 
 Sun, 25 Dec 2022 22:57:24 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvFz3Ot4vthezhcYx1VP+GFZ8dPN5ifZX4t6v2t2emoGeJCB1Emr3ruTidlTT5op6FeAEw5Sw/NWw07LdMd11I=
X-Received: by 2002:a5d:444d:0:b0:242:3a48:1757 with SMTP id
 x13-20020a5d444d000000b002423a481757mr666157wrr.528.1672037843852; Sun, 25
 Dec 2022 22:57:23 -0800 (PST)
MIME-Version: 1.0
References: <20221225154213.84183-1-tsahu@linux.ibm.com>
 <20221225154213.84183-3-tsahu@linux.ibm.com>
In-Reply-To: <20221225154213.84183-3-tsahu@linux.ibm.com>
From: Li Wang <liwang@redhat.com>
Date: Mon, 26 Dec 2022 14:57:12 +0800
Message-ID: <CAEemH2dB6RqzSnmN2CH0f1ZtG5sO9T2-RmDSg4cOR2-m-12b7g@mail.gmail.com>
To: Tarun Sahu <tsahu@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 02/13] Hugetlb: Migrating libhugetlbfs mmap-cow
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

On Sun, Dec 25, 2022 at 11:42 PM Tarun Sahu <tsahu@linux.ibm.com> wrote:

> Migrating the libhugetlbfs/testcases/mmap-cow.c test
>
> Test Description: Tests copy-on-write semantics of large pages where a
> number of threads map the same file with the MAP_PRIVATE flag. The threads
> then write into their copy of the mapping and recheck the contents to
> ensure they were not corrupted by the other threads.
>
> Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
> ---
>  runtest/hugetlb                               |   1 +
>  testcases/kernel/mem/.gitignore               |   1 +
>  .../kernel/mem/hugetlb/hugemmap/hugemmap21.c  | 131 ++++++++++++++++++
>  3 files changed, 133 insertions(+)
>  create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap21.c
>
> diff --git a/runtest/hugetlb b/runtest/hugetlb
> index 2dffa8421..71b4d57e4 100644
> --- a/runtest/hugetlb
> +++ b/runtest/hugetlb
> @@ -22,6 +22,7 @@ hugemmap17 hugemmap17
>  hugemmap18 hugemmap18
>  hugemmap19 hugemmap19
>  hugemmap20 hugemmap20
> +hugemmap21 hugemmap21
>  hugemmap05_1 hugemmap05 -m
>  hugemmap05_2 hugemmap05 -s
>  hugemmap05_3 hugemmap05 -s -m
> diff --git a/testcases/kernel/mem/.gitignore
> b/testcases/kernel/mem/.gitignore
> index dfd372892..74edfa392 100644
> --- a/testcases/kernel/mem/.gitignore
> +++ b/testcases/kernel/mem/.gitignore
> @@ -21,6 +21,7 @@
>  /hugetlb/hugemmap/hugemmap18
>  /hugetlb/hugemmap/hugemmap19
>  /hugetlb/hugemmap/hugemmap20
> +/hugetlb/hugemmap/hugemmap21
>  /hugetlb/hugeshmat/hugeshmat01
>  /hugetlb/hugeshmat/hugeshmat02
>  /hugetlb/hugeshmat/hugeshmat03
> diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap21.c
> b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap21.c
> new file mode 100644
> index 000000000..481edb4b0
> --- /dev/null
> +++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap21.c
> @@ -0,0 +1,131 @@
> +// SPDX-License-Identifier: LGPL-2.1-or-later
> +/*
> + * Copyright (C) 2005-2006 IBM Corporation.
> + * Author: David Gibson & Adam Litke
> + */
> +
> +/*\
> + * [Description]
> + *
> + * Tests copy-on-write semantics of large pages where a number of threads
> + * map the same file with the MAP_PRIVATE flag. The threads then write
> + * into their copy of the mapping and recheck the contents to ensure they
> + * were not corrupted by the other threads.
> + */
> +
> +#include <stdio.h>
> +#include <sys/mount.h>
> +#include <limits.h>
> +#include <sys/param.h>
> +#include <sys/types.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include <sys/stat.h>
> +#include <fcntl.h>
> +#include <unistd.h>
> +#include <sys/shm.h>
> +#include <sys/wait.h>
> +
> +#include "hugetlb.h"
> +
> +#define BUF_SZ 256
> +#define THREADS 5
> +#define NR_HUGEPAGES 6
> +#define MNTPOINT "hugetlbfs/"
> +
> +static int fd = -1;
> +static long hpage_size;
> +
> +static void do_work(int thread, size_t size, int fd)
> +{
> +       char *addr;
> +       size_t i;
> +       char pattern = thread+65;
> +
> +       addr = SAFE_MMAP(NULL, size, PROT_READ|PROT_WRITE, MAP_PRIVATE,
> fd, 0);
> +
> +       tst_res(TINFO, "Thread %d (pid %d): Mapped at address %p",
> +              thread, getpid(), addr);
> +
> +       for (i = 0; i < size; i++)
> +               memcpy((char *)addr+i, &pattern, 1);
> +
> +       if (msync(addr, size, MS_SYNC))
> +               tst_brk(TBROK|TERRNO, "Thread %d (pid %d): msync() failed",
> +                               thread, getpid());
> +
> +       for (i = 0; i < size; i++)
> +               if (addr[i] != pattern) {
> +                       tst_res(TFAIL, "thread %d (pid: %d): Corruption at
> %p; "
> +                                  "Got %c, Expected %c", thread, getpid(),
> +                                  &addr[i], addr[i], pattern);
> +                       goto cleanup;
> +               }
> +       tst_res(TINFO, "Thread %d (pid %d): Pattern verified",
> +                       thread, getpid());
>

Maybe combining the address output with the content of patterns is better?

i.e.

--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap21.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap21.c
@@ -45,9 +45,6 @@ static void do_work(int thread, size_t size, int fd)

        addr = SAFE_MMAP(NULL, size, PROT_READ|PROT_WRITE, MAP_PRIVATE, fd,
0);

-       tst_res(TINFO, "Thread %d (pid %d): Mapped at address %p",
-              thread, getpid(), addr);
-
        for (i = 0; i < size; i++)
                memcpy((char *)addr+i, &pattern, 1);

@@ -62,8 +59,8 @@ static void do_work(int thread, size_t size, int fd)
                                   &addr[i], addr[i], pattern);
                        goto cleanup;
                }
-       tst_res(TINFO, "Thread %d (pid %d): Pattern verified",
-                       thread, getpid());
+       tst_res(TINFO, "Thread %d (pid %d): Pattern %c verified at address
%p",
+                       thread, getpid(), pattern, addr);

 cleanup:
        SAFE_MUNMAP(addr, size);



> +
> +cleanup:
> +       SAFE_MUNMAP(addr, size);
> +       exit(0);
> +}
> +
> +static void run_test(void)
> +{
> +       char *addr;
> +       size_t size, itr;
> +       int i, pid;
> +       pid_t *wait_list;
> +
> +       wait_list = SAFE_MALLOC(THREADS * sizeof(pid_t));
> +       size = (NR_HUGEPAGES / (THREADS+1)) * hpage_size;
> +
> +
> +       /* First, mmap the file with MAP_SHARED and fill with data
> +        * If this is not done, then the fault handler will not be
> +        * called in the kernel since private mappings will be
> +        * created for the children at prefault time.
> +        */
> +       addr = SAFE_MMAP(NULL, size, PROT_READ|PROT_WRITE, MAP_SHARED, fd,
> 0);
> +
> +       for (itr = 0; itr < size; itr += 8)
> +               memcpy(addr+itr, "deadbeef", 8);
> +
> +       for (i = 0; i < THREADS; i++) {
> +               pid = SAFE_FORK();
> +
> +               if (pid == 0)
> +                       do_work(i, size, fd);
> +
> +               wait_list[i] = pid;
> +       }
> +       tst_reap_children();
> +
> +       SAFE_MUNMAP(addr, size);
> +       free(wait_list);
> +       tst_res(TPASS, "mmap COW working as expected.");
> +}
> +
> +static void setup(void)
> +{
> +       hpage_size = SAFE_READ_MEMINFO(MEMINFO_HPAGE_SIZE)*1024;
>

We do have a dedicated function named tst_get_hugepage_size();
could be used for getting huge page size.

The rest part looks good to me.

Reviewed-by: Li Wang <liwang@redhat.com>



> +       fd = tst_creat_unlinked(MNTPOINT, 0);
> +}
> +
> +static void cleanup(void)
> +{
> +       if (fd >= 1)
> +               SAFE_CLOSE(fd);
> +}
> +
> +static struct tst_test test = {
> +       .needs_root = 1,
> +       .mntpoint = MNTPOINT,
> +       .needs_hugetlbfs = 1,
> +       .needs_tmpdir = 1,
> +       .forks_child = 1,
> +       .setup = setup,
> +       .cleanup = cleanup,
> +       .test_all = run_test,
> +       .hugepages = {NR_HUGEPAGES, TST_NEEDS},
> +};
> --
> 2.31.1
>
>

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
