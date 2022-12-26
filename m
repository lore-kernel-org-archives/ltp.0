Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A81AC4332F
	for <ltp@archiver.kernel.org>; Mon, 26 Dec 2022 07:33:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8EE4A3CB88B
	for <ltp@archiver.kernel.org>; Mon, 26 Dec 2022 08:33:57 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 12AD83C217C
 for <ltp@lists.linux.it>; Mon, 26 Dec 2022 08:33:47 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 8F17D60064B
 for <ltp@lists.linux.it>; Mon, 26 Dec 2022 08:33:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1672040024;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pJvhi+bFtPQ9DHSPwAmVkTvJywgFJN2TlgiXKjWx3jY=;
 b=MsG9IUkxLyfcC/9wxF9cL2A6eUt5L+jkoPYFCQlDiEe55AI9nfcwKmkRZjGK+Sh1IuFGJK
 Shb0nnBqNeI8F4Rud5IKHnHHQVsVrBOLow9rTU+Hra0VR8ANVLvIv1a+yEp4lbHU2EjgcS
 rXR5TK9v+rVQxlwf/XP+UGUcvzd6SlY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-613-8rMJ5MYcMCKDk9TI7wqsBQ-1; Mon, 26 Dec 2022 02:33:42 -0500
X-MC-Unique: 8rMJ5MYcMCKDk9TI7wqsBQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 i7-20020a05600c354700b003d62131fe46so7728670wmq.5
 for <ltp@lists.linux.it>; Sun, 25 Dec 2022 23:33:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pJvhi+bFtPQ9DHSPwAmVkTvJywgFJN2TlgiXKjWx3jY=;
 b=GPTcm+huV83zXrZhT5gXvZCn1ipSXzu0ORdewZFvK+AqKp3bT1NzLJx8/0NSpq0DBM
 btCQxirMIytnwXT7E4GwoQPYJca/32XxCE1p1BUAmOopfNkhfMy6ZHB8+YYQBXvBVGHf
 mtGTIs6+tK/PDNZGRz2sCZby1AsfJ9NVnQ+6Ap4jU8WA61geqoYL/vuxvC/Yx41VqKR7
 x/Q4uqnq/ooaQTfS98Nl0wPMpe8vLxx3ssA38JjVwc7zrUV2iPVUVsYO6gBS7g7XR+pN
 MiakdzD06McOJVOVE1/mv9CVLGW+hUrXqdhjh7R+BcMpMJEB/vISjyGuJKp4ghmpAhHt
 dxRA==
X-Gm-Message-State: AFqh2krnGLlh8Cc/j8eWsP75RE7gaggnMSFZ18v5MWAWMy6KoZA5BdwS
 o00lcGRwR7OTUmALLKwnXHzdNXdO3ARCgFRQmTv486HNltPle0lufK6O0b/MpzV1AKqjSLcTa40
 b9cT3YKuIyag0IxAr7KpoPX5dg6k=
X-Received: by 2002:a5d:6a81:0:b0:27a:d81:1127 with SMTP id
 s1-20020a5d6a81000000b0027a0d811127mr237702wru.42.1672040021205; 
 Sun, 25 Dec 2022 23:33:41 -0800 (PST)
X-Google-Smtp-Source: AMrXdXs8bs54ja2fSl4APVy6rf109NTHSNZrIh5p9vKt8JFoHnlCwQcvNWu8932UAa3pT4aM2RfG6Nv0pD6OsPe0l4k=
X-Received: by 2002:a5d:6a81:0:b0:27a:d81:1127 with SMTP id
 s1-20020a5d6a81000000b0027a0d811127mr237697wru.42.1672040020961; Sun, 25 Dec
 2022 23:33:40 -0800 (PST)
MIME-Version: 1.0
References: <20221225154213.84183-1-tsahu@linux.ibm.com>
 <20221225154213.84183-4-tsahu@linux.ibm.com>
In-Reply-To: <20221225154213.84183-4-tsahu@linux.ibm.com>
From: Li Wang <liwang@redhat.com>
Date: Mon, 26 Dec 2022 15:33:29 +0800
Message-ID: <CAEemH2cGvChng=31zyR+_U8DYeB_zZ9dCqqmuisB2QfVkxgw5w@mail.gmail.com>
To: Tarun Sahu <tsahu@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 03/13] Hugetlb: Migrating libhugetlbfs mmap-gettest
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

> Migrating the libhugetlbfs/testcases/mmap-gettest.c test
>
> Test Description: This baseline test validates that a mapping of a
> certain size can be created, correctly.  Once created, all the pages are
> filled with a pattern and rechecked to test for corruption. The mapping is
> then released.  This process is repeated for a specified number of
> iterations.
>
> Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
>

Reviewed-by: Li Wang <liwang@redhat.com>

> ---
>  runtest/hugetlb                               |   1 +
>  testcases/kernel/mem/.gitignore               |   1 +
>  .../kernel/mem/hugetlb/hugemmap/hugemmap22.c  | 104 ++++++++++++++++++
>  3 files changed, 106 insertions(+)
>  create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap22.c
>
> diff --git a/runtest/hugetlb b/runtest/hugetlb
> index 71b4d57e4..8e80db140 100644
> --- a/runtest/hugetlb
> +++ b/runtest/hugetlb
> @@ -23,6 +23,7 @@ hugemmap18 hugemmap18
>  hugemmap19 hugemmap19
>  hugemmap20 hugemmap20
>  hugemmap21 hugemmap21
> +hugemmap22 hugemmap22
>  hugemmap05_1 hugemmap05 -m
>  hugemmap05_2 hugemmap05 -s
>  hugemmap05_3 hugemmap05 -s -m
> diff --git a/testcases/kernel/mem/.gitignore
> b/testcases/kernel/mem/.gitignore
> index 74edfa392..0fd01dbce 100644
> --- a/testcases/kernel/mem/.gitignore
> +++ b/testcases/kernel/mem/.gitignore
> @@ -22,6 +22,7 @@
>  /hugetlb/hugemmap/hugemmap19
>  /hugetlb/hugemmap/hugemmap20
>  /hugetlb/hugemmap/hugemmap21
> +/hugetlb/hugemmap/hugemmap22
>  /hugetlb/hugeshmat/hugeshmat01
>  /hugetlb/hugeshmat/hugeshmat02
>  /hugetlb/hugeshmat/hugeshmat03
> diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap22.c
> b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap22.c
> new file mode 100644
> index 000000000..50addbe62
> --- /dev/null
> +++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap22.c
> @@ -0,0 +1,104 @@
> +// SPDX-License-Identifier: LGPL-2.1-or-later
> +/*
> + * Copyright (C) 2005-2006 IBM Corporation.
> + * Author: David Gibson & Adam Litke
> + */
> +
> +/*\
> + * [Description]
> + *
> + * This baseline test validates that a mapping of a certain size can be
> + * created, correctly.  Once created, all the pages are filled with a
> + * pattern and rechecked to test for corruption. The mapping is then
> + * released. This process is repeated for a specified number of
> + * iterations.
> + */
> +
> +#include <stdio.h>
> +#include <sys/mount.h>
> +#include <unistd.h>
> +#include <unistd.h>
> +
> +#include "hugetlb.h"
> +
> +#define ITERATIONS 10
>

I don't think we need too many iterations, it will cost too
much time and easily timed out on a slower machine,
so at most cycling up two times should be enough.



> +#define NR_HUGEPAGES 2
> +#define MNTPOINT "hugetlbfs/"
> +
> +static unsigned long hpage_size;
> +static int fd = -1;
> +
> +static void test_per_iteration(size_t size, int iter)
> +{
> +       char *m;
> +       size_t i, j;
> +       char pattern = 'A';
> +
> +       fd = tst_creat_unlinked(MNTPOINT, 0);
> +       m = SAFE_MMAP(NULL, size, (PROT_READ|PROT_WRITE), MAP_SHARED, fd,
> 0);
> +
> +       for (i = 0; i < NR_HUGEPAGES; i++) {
> +               for (j = 0; j < hpage_size; j++) {
> +                       if (*(m+(i*hpage_size)+j) != 0) {
> +                               tst_res(TFAIL, "Iter %d: Verifying the
> mmap area failed. "
> +                                    "Got %c, expected 0", iter,
> +                                    *(m+(i*hpage_size)+j));
> +                               goto cleanup;
> +                       }
> +               }
> +       }
> +       for (i = 0; i < NR_HUGEPAGES; i++) {
> +               pattern = 65+(i%26);
> +               memset(m+(i*hpage_size), pattern, hpage_size);
> +       }
> +
> +       for (i = 0; i < NR_HUGEPAGES; i++) {
> +               pattern = 65+(i%26);
> +               for (j = 0; j < hpage_size; j++) {
> +                       if (*(m+(i*hpage_size)+j) != pattern) {
> +                               tst_res(TFAIL, "Verifying the mmap area
> failed. "
> +                                    "got: %c, expected: %c",
> +                                    *(m+(i*hpage_size)+j), pattern);
> +                               goto cleanup;
> +                       }
> +               }
> +       }
> +
> +cleanup:
> +       SAFE_MUNMAP(m, size);
> +       SAFE_CLOSE(fd);
> +}
> +
> +static void run_test(void)
> +{
> +       size_t size;
> +       int i;
> +
> +       size = NR_HUGEPAGES * hpage_size;
> +       for (i = 0; i < ITERATIONS; i++)
> +               test_per_iteration(size, i);
> +
> +       tst_res(TPASS, "Successfully verified the mmap area.");
> +}
> +
> +static void setup(void)
> +{
> +       hpage_size = SAFE_READ_MEMINFO(MEMINFO_HPAGE_SIZE)*1024;
>

hpage_size = tst_get_hugepage_size();

+}
> +
> +static void cleanup(void)
> +{
> +       if (fd >= 0)
> +               SAFE_CLOSE(fd);
> +}
> +
> +static struct tst_test test = {
> +       .needs_root = 1,
> +       .mntpoint = MNTPOINT,
> +       .needs_hugetlbfs = 1,
> +       .needs_tmpdir = 1,
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
