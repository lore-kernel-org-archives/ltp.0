Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0FE8C10F1B
	for <ltp@archiver.kernel.org>; Tue, 27 Dec 2022 06:56:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D24C43CB831
	for <ltp@archiver.kernel.org>; Tue, 27 Dec 2022 07:56:47 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9FEF93C4F11
 for <ltp@lists.linux.it>; Tue, 27 Dec 2022 07:56:38 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 93FA56002A8
 for <ltp@lists.linux.it>; Tue, 27 Dec 2022 07:56:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1672124195;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Z6AhBhRjHiLL0faUe5hS9Bm2kjZzfl3N9rQC93l2dKE=;
 b=DoI18bz36+RaTsJrgKA9tb7cznydNFTh8GJ21BrpplguZxNfDqyGzo2XHMp6dGKmdllzle
 buoGnhv5Wpg2ZIJP8EakSyTBLt2NLHkPITyTyg7BZ+0xmdRonT0FnRQiDI1mbBg3DwpRzZ
 ZJ4V3/nwVBdt1KAPs0AUUiXyXJdAM7U=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-59-24YRZrZLMQeQGhnRYYwzIQ-1; Tue, 27 Dec 2022 01:56:33 -0500
X-MC-Unique: 24YRZrZLMQeQGhnRYYwzIQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 21-20020a05600c021500b003d227b209e1so2986623wmi.1
 for <ltp@lists.linux.it>; Mon, 26 Dec 2022 22:56:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Z6AhBhRjHiLL0faUe5hS9Bm2kjZzfl3N9rQC93l2dKE=;
 b=zCZ2rshIUcUNJr/ixWh3d2q/tcEPimSUYimDOLv8gymJoVNyznj3QVS5suM0VWQ1XG
 lxy2VmlLkkyTD+ZY/cm45fffbWYyLWPfdED8Flb6UA2sayYjqwgVSFYwn90PearqIbB6
 87HVf1uelgyj9P5Spa8Sk22OGOnq0jUoIrDwDVCPrIF0P3vTVW5Ob07B2MFWaJk8abz5
 HoTuA3YmsGBTtS6gBXnpn17mQLvjBy1oil8/EAwAP+JyXe+NSxRCGGD1minjNsdy44TO
 4J7+VgiAE7D1hk/2whQSvezD6SD5jBiQ59CS/ERpMH8FYc6JOe8x0HEYpCQRuqfoN4yw
 /qJA==
X-Gm-Message-State: AFqh2kqObC+fajJcayvgmET95b4XWpC8zy5VyIoscDIwb8UhEtO5cRkv
 Ucm3qdCAEXPFUPyYXEIyhAfnUsAKWuZ4MvE06SkHgzfvbVbzzV659GqLB7/dLwDktp7KfBs65sq
 0v2/bzYbmNZBqY8VE7ucuEn4Vmqk=
X-Received: by 2002:a5d:6a81:0:b0:27a:d81:1127 with SMTP id
 s1-20020a5d6a81000000b0027a0d811127mr382587wru.42.1672124192924; 
 Mon, 26 Dec 2022 22:56:32 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuR9UWRtRyLm2UleXwCDP9YVp6VYu1igy7mjNl0dzLF6Q/YlZfg+23OUfEkOP1d2RSZZiYlV4OPqqTnJGTjWEw=
X-Received: by 2002:a5d:6a81:0:b0:27a:d81:1127 with SMTP id
 s1-20020a5d6a81000000b0027a0d811127mr382586wru.42.1672124192676; Mon, 26 Dec
 2022 22:56:32 -0800 (PST)
MIME-Version: 1.0
References: <20221225154213.84183-1-tsahu@linux.ibm.com>
 <20221225154213.84183-10-tsahu@linux.ibm.com>
In-Reply-To: <20221225154213.84183-10-tsahu@linux.ibm.com>
From: Li Wang <liwang@redhat.com>
Date: Tue, 27 Dec 2022 14:56:21 +0800
Message-ID: <CAEemH2er5-hO2Sv0OTGNzzWXAgdhnE-0jQHVGRG+Y+eHosW6fw@mail.gmail.com>
To: Tarun Sahu <tsahu@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 09/13] Hugetlb: Migrating libhugetlbfs private
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

On Sun, Dec 25, 2022 at 11:43 PM Tarun Sahu <tsahu@linux.ibm.com> wrote:

> Migrating the libhugetlbfs/testcases/private.c test
>
> Test Description: The test do mmap() with shared mapping and write.
> It matches the data with private mmap() and then change it with other
> data. It checks shared mapping data if data is not contaiminated by
> private mapping.
>
> Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
> ---
>  runtest/hugetlb                               |   1 +
>  testcases/kernel/mem/.gitignore               |   1 +
>  .../kernel/mem/hugetlb/hugemmap/hugemmap29.c  | 115 ++++++++++++++++++
>  3 files changed, 117 insertions(+)
>  create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap29.c
>
> diff --git a/runtest/hugetlb b/runtest/hugetlb
> index 95afe009e..6ec8d1018 100644
> --- a/runtest/hugetlb
> +++ b/runtest/hugetlb
> @@ -29,6 +29,7 @@ hugemmap25 hugemmap25
>  hugemmap26 hugemmap26
>  hugemmap27 hugemmap27
>  hugemmap28 hugemmap28
> +hugemmap29 hugemmap29
>  hugemmap05_1 hugemmap05 -m
>  hugemmap05_2 hugemmap05 -s
>  hugemmap05_3 hugemmap05 -s -m
> diff --git a/testcases/kernel/mem/.gitignore
> b/testcases/kernel/mem/.gitignore
> index 2f8ed0df0..fef0a76d6 100644
> --- a/testcases/kernel/mem/.gitignore
> +++ b/testcases/kernel/mem/.gitignore
> @@ -28,6 +28,7 @@
>  /hugetlb/hugemmap/hugemmap26
>  /hugetlb/hugemmap/hugemmap27
>  /hugetlb/hugemmap/hugemmap28
> +/hugetlb/hugemmap/hugemmap29
>  /hugetlb/hugeshmat/hugeshmat01
>  /hugetlb/hugeshmat/hugeshmat02
>  /hugetlb/hugeshmat/hugeshmat03
> diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap29.c
> b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap29.c
> new file mode 100644
> index 000000000..2d921e169
> --- /dev/null
> +++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap29.c
> @@ -0,0 +1,115 @@
> +// SPDX-License-Identifier: LGPL-2.1-or-later
> +/*
> + * Copyright (C) 2005-2006 IBM Corporation.
> + * Author: David Gibson & Adam Litke
> + */
> +
> +/*\
> + * [Description]
> + *
> + * The test do mmap() with shared mapping and write. It matches the data
> + * with private mmap() and then change it with other data. It checks
> + * shared mapping data if data is not contaiminated by private mapping.
> + * Similiarly checks for private data if it is not contaminated by
> changing
> + * shared mmap data.
> + */
> +
> +#define _GNU_SOURCE
> +#include <stdio.h>
> +#include <sys/mount.h>
> +#include <limits.h>
> +#include <sys/param.h>
> +#include <setjmp.h>
> +#include <sys/types.h>
> +
> +#include "hugetlb.h"
> +
> +#define C1     0x1234ABCD
> +#define C2  0xFEDC9876
>

Dont mix tabs and spaces ^

Reviewed-by: Li Wang <liwang@redhat.com>



> +
> +#define MNTPOINT "hugetlbfs/"
> +static unsigned long hpage_size;
> +static int fd = -1;
> +
> +static void run_test(void)
> +{
> +       void *p, *q;
> +       unsigned int *pl, *ql;
> +       unsigned long i;
> +
> +       fd = tst_creat_unlinked(MNTPOINT, 0);
> +       p = SAFE_MMAP(NULL, hpage_size, PROT_READ|PROT_WRITE, MAP_SHARED,
> +                fd, 0);
> +
> +       pl = p;
> +       for (i = 0; i < (hpage_size / sizeof(*pl)); i++)
> +               pl[i] = C1 ^ i;
> +
> +       q = SAFE_MMAP(NULL, hpage_size, PROT_READ|PROT_WRITE, MAP_PRIVATE,
> +                fd, 0);
> +
> +       ql = q;
> +       for (i = 0; i < (hpage_size / sizeof(*ql)); i++) {
> +               if (ql[i] != (C1 ^ i)) {
> +                       tst_res(TFAIL, "Mismatch at offset %lu, got: %u,
> expected: %lu",
> +                                       i, ql[i], C1 ^ i);
> +                       goto cleanup;
> +               }
> +       }
> +
> +       for (i = 0; i < (hpage_size / sizeof(*ql)); i++)
> +               ql[i] = C2 ^ i;
> +
> +       for (i = 0; i < (hpage_size / sizeof(*ql)); i++) {
> +               if (ql[i] != (C2 ^ i)) {
> +                       tst_res(TFAIL, "PRIVATE mismatch at offset %lu,
> got: %u, expected: %lu",
> +                                       i, ql[i], C2 ^ i);
> +                       goto cleanup;
> +               }
> +       }
> +
> +       for (i = 0; i < (hpage_size / sizeof(*pl)); i++) {
> +               if (pl[i] != (C1 ^ i)) {
> +                       tst_res(TFAIL, "SHARED map contaminated at offset
> %lu, "
> +                                       "got: %u, expected: %lu", i,
> pl[i], C1 ^ i);
> +                       goto cleanup;
> +               }
> +       }
> +
> +       memset(p, 0, hpage_size);
> +
> +       for (i = 0; i < (hpage_size / sizeof(*ql)); i++) {
> +               if (ql[i] != (C2 ^ i)) {
> +                       tst_res(TFAIL, "PRIVATE map contaminated at offset
> %lu, "
> +                                       "got: %u, expected: %lu", i,
> ql[i], C2 ^ i);
> +                       goto cleanup;
> +               }
> +       }
> +       tst_res(TPASS, "Successfully tested shared/private mmaping and its
> data");
> +cleanup:
> +       SAFE_MUNMAP(p, hpage_size);
> +       SAFE_MUNMAP(q, hpage_size);
> +       SAFE_CLOSE(fd);
> +}
> +
> +static void setup(void)
> +{
> +       hpage_size = SAFE_READ_MEMINFO(MEMINFO_HPAGE_SIZE)*1024;
> +}
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
> +       .hugepages = {2, TST_NEEDS},
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
