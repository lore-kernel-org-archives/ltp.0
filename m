Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DCC1C10F1B
	for <ltp@archiver.kernel.org>; Tue, 27 Dec 2022 07:06:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 32ABF3CB848
	for <ltp@archiver.kernel.org>; Tue, 27 Dec 2022 08:05:57 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DC5543CA6BC
 for <ltp@lists.linux.it>; Tue, 27 Dec 2022 08:05:47 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C5BA66000E7
 for <ltp@lists.linux.it>; Tue, 27 Dec 2022 08:05:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1672124745;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CcFbT4WKjZoJkVnhhmKeaEJIMaQrSMhFu90jlA7BDIw=;
 b=FEA8gGKrOROcFpjL+idXVWWZTqJXvxKQZGt00HX5T8P9YwNZm4sB1rOw9+nEjo9c4FQB8d
 s9VpzoA9eOfa8xI1ze0BTQYR7pcLNJdHYO/tQ6O7s4ydHS/89HTb4sC7uQl1Ei8N/FSR9t
 96HuTdAO17Kddt2kF44zEWcUMztxCrA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-458-_SdO-ZAbMvmxf24u-hhVXg-1; Tue, 27 Dec 2022 02:05:43 -0500
X-MC-Unique: _SdO-ZAbMvmxf24u-hhVXg-1
Received: by mail-wm1-f72.google.com with SMTP id
 n8-20020a05600c294800b003d1cc68889dso2989844wmd.7
 for <ltp@lists.linux.it>; Mon, 26 Dec 2022 23:05:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CcFbT4WKjZoJkVnhhmKeaEJIMaQrSMhFu90jlA7BDIw=;
 b=fEt9fhmk25VNeBXgf8USXZwLJazS2rqd3qghj9aLeR5NR2DlSVEqbsHS+MMgpCpszE
 hhqj8iDrcmCm1tppBhisx4hzR/xeeF1yvDfxexWlqit7gdoXuHA9HozRvK2RIN5rPAoH
 zmDqsFQQNVsgCdxc7nfvMiGd4fljAQ8odlO9Ff6qrTMvNlJCzZez5gk8NjMQlZcaBNeZ
 A3VsMeCLvI4X36xOe541Mboaa2oDZFgv9l8ds4bl86TnzRMBwPLsLqI+POEjgre5abe7
 eRdQI6yVVKRBhb7Pw5Y1DVWtNU2DWg/Bp1dZz32IANJ5Ezq3VN5eMyE77UPFajPafA8M
 4GfQ==
X-Gm-Message-State: AFqh2kowy39s1d/fEjUBZw+xnEEmaNB8v8MAuseG/l/wefvMKkPUV7Fk
 OzRvJf6SIXH1uZMNIeEN+6WEBWGDKCiXcrLO8tZag8r1bAHHYbTbGkhc+dyjqzY6QxuW7xMfvIs
 cVjfg+yfH5I0kp2TMfFPOvt4LkBc=
X-Received: by 2002:a05:6000:1e13:b0:271:2ddc:80b9 with SMTP id
 bj19-20020a0560001e1300b002712ddc80b9mr734871wrb.316.1672124741952; 
 Mon, 26 Dec 2022 23:05:41 -0800 (PST)
X-Google-Smtp-Source: AMrXdXu9x34P6vbslo1rjBAEwanFk0hTwQeCLDQZO7GYTdGsWwoNsmBRk2gXMbA1bkJhIgZF60epGAw2MRvP8stqsLQ=
X-Received: by 2002:a05:6000:1e13:b0:271:2ddc:80b9 with SMTP id
 bj19-20020a0560001e1300b002712ddc80b9mr734869wrb.316.1672124741730; Mon, 26
 Dec 2022 23:05:41 -0800 (PST)
MIME-Version: 1.0
References: <20221225154213.84183-1-tsahu@linux.ibm.com>
 <20221225154213.84183-11-tsahu@linux.ibm.com>
In-Reply-To: <20221225154213.84183-11-tsahu@linux.ibm.com>
From: Li Wang <liwang@redhat.com>
Date: Tue, 27 Dec 2022 15:05:30 +0800
Message-ID: <CAEemH2c6tQpu7nbp=P9N__O0qzsjnhF2QY+2VNw4r9qAAndtQw@mail.gmail.com>
To: Tarun Sahu <tsahu@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 10/13] Hugetlb: Migrating libhugetlbfs
 readahead_reserve
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

> Migrating the libhugetlbfs/testcases/readahead_reserve.c test
>
> Test Description: readahead() on some kernels can cause the reservation
> counter to get corrupted. The problem is that the patches are allocated
> for the reservation but not faulted in at the time of allocation. The
> counters do not get updated and effectively "leak". This test
> identifies whether the kernel is vulnerable to the problem or not.
> It's fixed in kernel by 'commit f2deae9d4e70
> ("Remove implementation of readpage from the hugetlbfs_aops")'.
>
> Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
> ---
>  runtest/hugetlb                               |  1 +
>  testcases/kernel/mem/.gitignore               |  1 +
>  .../kernel/mem/hugetlb/hugemmap/hugemmap30.c  | 85 +++++++++++++++++++
>  3 files changed, 87 insertions(+)
>  create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap30.c
>
> diff --git a/runtest/hugetlb b/runtest/hugetlb
> index 6ec8d1018..60cca4eb7 100644
> --- a/runtest/hugetlb
> +++ b/runtest/hugetlb
> @@ -30,6 +30,7 @@ hugemmap26 hugemmap26
>  hugemmap27 hugemmap27
>  hugemmap28 hugemmap28
>  hugemmap29 hugemmap29
> +hugemmap30 hugemmap30
>  hugemmap05_1 hugemmap05 -m
>  hugemmap05_2 hugemmap05 -s
>  hugemmap05_3 hugemmap05 -s -m
> diff --git a/testcases/kernel/mem/.gitignore
> b/testcases/kernel/mem/.gitignore
> index fef0a76d6..bb9720452 100644
> --- a/testcases/kernel/mem/.gitignore
> +++ b/testcases/kernel/mem/.gitignore
> @@ -29,6 +29,7 @@
>  /hugetlb/hugemmap/hugemmap27
>  /hugetlb/hugemmap/hugemmap28
>  /hugetlb/hugemmap/hugemmap29
> +/hugetlb/hugemmap/hugemmap30
>  /hugetlb/hugeshmat/hugeshmat01
>  /hugetlb/hugeshmat/hugeshmat02
>  /hugetlb/hugeshmat/hugeshmat03
> diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap30.c
> b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap30.c
> new file mode 100644
> index 000000000..9a0709af1
> --- /dev/null
> +++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap30.c
> @@ -0,0 +1,85 @@
> +// SPDX-License-Identifier: LGPL-2.1-or-later
> +/*
> + * Copyright (C) 2005-2006 IBM Corporation.
> + * Author: Mel Gorman
> + */
> +
> +/*\
> + * [Description]
> + *
> + * readahead() on some kernels can cause the reservation counter to get
> + * corrupted. The problem is that the pages are allocated for the
> + * reservation but not faulted in at the time of allocation. The
> + * counters do not get updated and effectively "leak". This test
> + * identifies whether the kernel is vulnerable to the problem or not.
> + * It's fixed in kernel by commit f2deae9d4e70.
> + */
> +
> +#define _GNU_SOURCE
>


> +#include <fcntl.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <sys/mount.h>
> +#include <limits.h>
> +#include <sys/param.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include <sys/types.h>
>

I just found these header files are not needed, this test
still compiles fine without including them. The possible
reason is that we already indirectly include them via hugetlb.h.

This comment also works for other tests.

Reviewed-by: Li Wang <liwang@redhat.com>



> +
> +#include "hugetlb.h"
> +
> +#define MNTPOINT "hugetlbfs/"
> +static long hpage_size;
> +static int fd = -1;
> +
> +static void run_test(void)
> +{
> +       void *p;
> +       unsigned long initial_rsvd, map_rsvd, readahead_rsvd, end_rsvd;
> +
> +       fd = tst_creat_unlinked(MNTPOINT, 0);
> +       initial_rsvd = SAFE_READ_MEMINFO(MEMINFO_HPAGE_RSVD);
> +
> +       p = SAFE_MMAP(NULL, hpage_size, PROT_READ|PROT_WRITE, MAP_SHARED,
> +                fd, 0);
> +       map_rsvd = SAFE_READ_MEMINFO(MEMINFO_HPAGE_RSVD);
> +       tst_res(TINFO, "map_rsvd: %lu", map_rsvd);
> +
> +       readahead(fd, 0, hpage_size);
> +       readahead_rsvd = SAFE_READ_MEMINFO(MEMINFO_HPAGE_RSVD);
> +       tst_res(TINFO, "readahead_rsvd: %lu", readahead_rsvd);
> +
> +       memset(p, 1, hpage_size);
> +
> +       SAFE_MUNMAP(p, hpage_size);
> +       SAFE_CLOSE(fd);
> +       end_rsvd = SAFE_READ_MEMINFO(MEMINFO_HPAGE_RSVD);
> +
> +       TST_EXP_EQ_LU(end_rsvd, initial_rsvd);
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
> +       .tags = (struct tst_tag[]) {
> +               {"linux-git", "f2deae9d4e70"},
> +               {}
> +       },
> +       .needs_root = 1,
> +       .mntpoint = MNTPOINT,
> +       .needs_hugetlbfs = 1,
> +       .needs_tmpdir = 1,
> +       .setup = setup,
> +       .cleanup = cleanup,
> +       .test_all = run_test,
> +       .hugepages = {1, TST_NEEDS},
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
