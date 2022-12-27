Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F12CC10F1B
	for <ltp@archiver.kernel.org>; Tue, 27 Dec 2022 07:08:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6DDA93CB827
	for <ltp@archiver.kernel.org>; Tue, 27 Dec 2022 08:08:49 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DDF8C3CB80E
 for <ltp@lists.linux.it>; Tue, 27 Dec 2022 08:08:38 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id DFEE81400543
 for <ltp@lists.linux.it>; Tue, 27 Dec 2022 08:08:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1672124916;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mxaY84O3kFP5IqpEqfzbmWx+oo6J029RiduT6wWW5+k=;
 b=NrRgD5P6xcjEIOEA+NHic9amoW8xlr9UdYPMpXyPa94tBAZQFnQy3Dyja5LTuEFlgzZuGV
 S71HyiubFqh0DSKzbdGopCVX7y8yfMhXJvlrwI/Zneeb8N3iYL+e2S92YKOI41pJMwYVRA
 RyeJ/IBuNdxeQSuLnI1zmFT92jhRjeQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-393--ZbzhmtSNC6JwlAqAWuwNg-1; Tue, 27 Dec 2022 02:08:34 -0500
X-MC-Unique: -ZbzhmtSNC6JwlAqAWuwNg-1
Received: by mail-wr1-f71.google.com with SMTP id
 i9-20020adfa509000000b0027df24b887fso339590wrb.3
 for <ltp@lists.linux.it>; Mon, 26 Dec 2022 23:08:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mxaY84O3kFP5IqpEqfzbmWx+oo6J029RiduT6wWW5+k=;
 b=AVMoLO1sp2S89LaGjD8eFURiT7aBVOeb4sWB631dYJzyJStodUt12NGKnmZ6oOx/Vz
 F95oaTOdkHOUnvRDFRrOPzlgQ2I4SLjDtxV/IphNbTJhZFzoEYpb8cZ5kdNsVLTzXC4O
 UsNimhRSTzRiiX3nN/ldK+2nBQXmYYMIeliHc6jiGAggBnHlzlYQ3wIhkiF+QvN6aQQs
 S8unqm0h6oeYZcTcjJ8/3yZbfJaRHhpC94ETocQFbYZ+PallHCOvz7Dk/I8RsGwPg/dC
 dpvLKFopcKkz64xqy+gIEUel3GLxAVLBfscLnn2QQRO5FZv8gz8fodwHP9CLNqjYgKOA
 zylw==
X-Gm-Message-State: AFqh2koFGwDuMkmnt5e00mKzc69GZj8//b60uKs1Qtkg8zO0/+WXEnZL
 w8cpCbafxiRCOjTt3aTC3g1dGy4V5x1qyFp+XV5XWEwWjy8xkzzpXwKzHWEWHNJUX1cNwqY9BnD
 NNqRFxNHsrIxjBFmT+0VhT79QhWw=
X-Received: by 2002:a5d:4a90:0:b0:27a:2d68:8c25 with SMTP id
 o16-20020a5d4a90000000b0027a2d688c25mr280065wrq.707.1672124912154; 
 Mon, 26 Dec 2022 23:08:32 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsaML8j/IYQD25S4TlMiCV/K0M4EZAZzUHF2sykPoLmgu6pNrXgdzTdKjxNYGCVn6IVttUrCWB0Uv9Q/TSROgs=
X-Received: by 2002:a5d:4a90:0:b0:27a:2d68:8c25 with SMTP id
 o16-20020a5d4a90000000b0027a2d688c25mr280061wrq.707.1672124911980; Mon, 26
 Dec 2022 23:08:31 -0800 (PST)
MIME-Version: 1.0
References: <20221225154213.84183-1-tsahu@linux.ibm.com>
 <20221225154213.84183-12-tsahu@linux.ibm.com>
In-Reply-To: <20221225154213.84183-12-tsahu@linux.ibm.com>
From: Li Wang <liwang@redhat.com>
Date: Tue, 27 Dec 2022 15:08:20 +0800
Message-ID: <CAEemH2fiOZ+oFpnJvb7c2cS8w5_cKJeUVjdBP1REs9_0d9gaXw@mail.gmail.com>
To: Tarun Sahu <tsahu@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 11/13] Hugetlb: Migrating libhugetlbfs shared
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

> Migrating the libhugetlbfs/testcases/shared.c test
>
> Test Description: This test is basic shared mapping test. Two shared
> mappings are created with same offset on a file. It checks if writing
> to one mapping can be seen to other mapping or not?
>
> Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
>

Reviewed-by: Li Wang <liwang@redhat.com>

> ---
>  runtest/hugetlb                               |  1 +
>  testcases/kernel/mem/.gitignore               |  1 +
>  .../kernel/mem/hugetlb/hugemmap/hugemmap31.c  | 84 +++++++++++++++++++
>  3 files changed, 86 insertions(+)
>  create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap31.c
>
> diff --git a/runtest/hugetlb b/runtest/hugetlb
> index 60cca4eb7..33fd384b4 100644
> --- a/runtest/hugetlb
> +++ b/runtest/hugetlb
> @@ -31,6 +31,7 @@ hugemmap27 hugemmap27
>  hugemmap28 hugemmap28
>  hugemmap29 hugemmap29
>  hugemmap30 hugemmap30
> +hugemmap31 hugemmap31
>  hugemmap05_1 hugemmap05 -m
>  hugemmap05_2 hugemmap05 -s
>  hugemmap05_3 hugemmap05 -s -m
> diff --git a/testcases/kernel/mem/.gitignore
> b/testcases/kernel/mem/.gitignore
> index bb9720452..8375389cd 100644
> --- a/testcases/kernel/mem/.gitignore
> +++ b/testcases/kernel/mem/.gitignore
> @@ -30,6 +30,7 @@
>  /hugetlb/hugemmap/hugemmap28
>  /hugetlb/hugemmap/hugemmap29
>  /hugetlb/hugemmap/hugemmap30
> +/hugetlb/hugemmap/hugemmap31
>  /hugetlb/hugeshmat/hugeshmat01
>  /hugetlb/hugeshmat/hugeshmat02
>  /hugetlb/hugeshmat/hugeshmat03
> diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap31.c
> b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap31.c
> new file mode 100644
> index 000000000..a09905023
> --- /dev/null
> +++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap31.c
> @@ -0,0 +1,84 @@
> +// SPDX-License-Identifier: LGPL-2.1-or-later
> +/*
> + * Copyright (C) 2005-2006 IBM Corporation.
> + * Author: David Gibson & Adam Litke
> + */
> +
> +/*\
> + * [Description]
> + *
> + * This test is basic shared mapping test. Two shared mappings are created
> + * with same offset on a file. It checks if writing to one mapping can be
> + * seen to other mapping or not?
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
> +#define RANDOM_CONSTANT        0x1234ABCD
> +#define MNTPOINT "hugetlbfs/"
> +
> +static long hpage_size;
> +static int fd = -1;
> +
> +static void run_test(void)
> +{
> +       void *p, *q;
> +       unsigned long *pl, *ql;
> +       unsigned long i;
> +
> +       fd = tst_creat_unlinked(MNTPOINT, 0);
> +       p = SAFE_MMAP(NULL, hpage_size, PROT_READ|PROT_WRITE, MAP_SHARED,
> +                fd, 0);
> +
> +       q = SAFE_MMAP(NULL, hpage_size, PROT_READ|PROT_WRITE, MAP_SHARED,
> +                fd, 0);
> +
> +       pl = p;
> +       for (i = 0; i < (hpage_size / sizeof(*pl)); i++)
> +               pl[i] = RANDOM_CONSTANT ^ i;
> +
> +       ql = q;
> +       for (i = 0; i < (hpage_size / sizeof(*ql)); i++) {
> +               if (ql[i] != (RANDOM_CONSTANT ^ i)) {
> +                       tst_res(TFAIL, "Mismatch at offset %lu, Got: %lu,
> Expected: %lu",
> +                                       i, ql[i], RANDOM_CONSTANT ^ i);
> +                       goto cleanup;
> +               }
> +       }
> +
> +       tst_res(TPASS, "Successfully tested data between two shared
> mappings");
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
