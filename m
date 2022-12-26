Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DC75C4332F
	for <ltp@archiver.kernel.org>; Mon, 26 Dec 2022 04:49:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D52573CC87A
	for <ltp@archiver.kernel.org>; Mon, 26 Dec 2022 05:49:13 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 79B063CB8A2
 for <ltp@lists.linux.it>; Mon, 26 Dec 2022 05:49:02 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 6C8D8600097
 for <ltp@lists.linux.it>; Mon, 26 Dec 2022 05:48:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1672030138;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2nWX4kUGxaJ24kr3v9btkPzU7xsVi5jh9D4ja2WKGrg=;
 b=gL2z85l7jpgJkNHMchlNa7j5nFZHI09hFmrXaZ2ebi/x6+Twzgv8uzkvX8NxMt3rORQJGJ
 NRuEDxBLeoguKggeeRtLXKFnkyluOFeWXpYhwZzMxwqigNOzqp2ffWGbNf82xppymMrlAq
 ABj20qorKMJ6Xvo8nVSKRk87Fb3i+Mc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-296-xE19gClaPRibhcaNmw3QeA-1; Sun, 25 Dec 2022 23:48:57 -0500
X-MC-Unique: xE19gClaPRibhcaNmw3QeA-1
Received: by mail-wr1-f69.google.com with SMTP id
 i26-20020adfaada000000b0027c76c49445so191492wrc.13
 for <ltp@lists.linux.it>; Sun, 25 Dec 2022 20:48:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2nWX4kUGxaJ24kr3v9btkPzU7xsVi5jh9D4ja2WKGrg=;
 b=rqHcbPXyJ62vCAdDK2OFgUUDwZkjeYmbkPm5Dt6GYtxsomBh+U3ldzwmwEqIEP+uvh
 nq6vK3n+olaqjPGtC2AMYnyAmO7ETIlJDXOjJ5Vsio0cEJ7O4yfhmeNegLDE671K4kQ8
 y8u7H3CA+//2tf8mlkD78LcAtbhOP+EFV/Jkj5W4qjkGmRL76RuMSGxlcppX1BYuw0Mr
 Th6HfmbHDT0omLZ8ZTRqFgDW8EgPBzhamVdzwycEqNCuoF/IWghGAGIdaxKEwOthT9Ba
 UIDriaOHovm0SkXBKFjkGb0l/hb6zsjplTlYrIWNLs9j5Yf/OSpVxI4h6mIi+UFMM4xa
 gYZg==
X-Gm-Message-State: AFqh2krCIDFswGf/QuSZ1gOAkisnf/GDzcJ4kfdFxPcQUm9uSvSioQlK
 +L4GFyzc1DeqMDgY8V7vylDe9TG07W7Qcwz3MY8Yq4zuGks8bvBYqxj7KXNL25EGqyjqq1rC1he
 fjmNsWpXP3UUUK2nbuxq5FL96mBU=
X-Received: by 2002:a5d:4a90:0:b0:27a:2d68:8c25 with SMTP id
 o16-20020a5d4a90000000b0027a2d688c25mr147461wrq.707.1672030135815; 
 Sun, 25 Dec 2022 20:48:55 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsvxukh+FgCp45qjK03h/4IOkQb1U7ifXF2/w8hwDT405boXMNTDfjrCnsqjnRAl3iprkS8ubtV18tH/fUfQ6g=
X-Received: by 2002:a5d:4a90:0:b0:27a:2d68:8c25 with SMTP id
 o16-20020a5d4a90000000b0027a2d688c25mr147458wrq.707.1672030135657; Sun, 25
 Dec 2022 20:48:55 -0800 (PST)
MIME-Version: 1.0
References: <20221225154213.84183-1-tsahu@linux.ibm.com>
 <20221225154213.84183-2-tsahu@linux.ibm.com>
In-Reply-To: <20221225154213.84183-2-tsahu@linux.ibm.com>
From: Li Wang <liwang@redhat.com>
Date: Mon, 26 Dec 2022 12:48:44 +0800
Message-ID: <CAEemH2eyO686YNSSdRE7vDhyU9qYEsdNLfwFUiv_a+jK1QeLiA@mail.gmail.com>
To: Tarun Sahu <tsahu@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 01/13] Hugetlb: Migrating libhugetlbfs mlock
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

> Migrating the libhugetlbfs/testcases/mlock.c test
>
> Test Description: The test checks that mlocking hugetlb areas works
> with all combinations of MAP_PRIVATE and MAP_SHARED with and without
> MAP_LOCKED specified.
>
> Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
> ---
>  runtest/hugetlb                               |  1 +
>  testcases/kernel/mem/.gitignore               |  1 +
>  .../kernel/mem/hugetlb/hugemmap/hugemmap20.c  | 88 +++++++++++++++++++
>  3 files changed, 90 insertions(+)
>  create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap20.c
>
> diff --git a/runtest/hugetlb b/runtest/hugetlb
> index 4da1525a7..2dffa8421 100644
> --- a/runtest/hugetlb
> +++ b/runtest/hugetlb
> @@ -21,6 +21,7 @@ hugemmap16 hugemmap16
>  hugemmap17 hugemmap17
>  hugemmap18 hugemmap18
>  hugemmap19 hugemmap19
> +hugemmap20 hugemmap20
>  hugemmap05_1 hugemmap05 -m
>  hugemmap05_2 hugemmap05 -s
>  hugemmap05_3 hugemmap05 -s -m
> diff --git a/testcases/kernel/mem/.gitignore
> b/testcases/kernel/mem/.gitignore
> index b6b3e5ddd..dfd372892 100644
> --- a/testcases/kernel/mem/.gitignore
> +++ b/testcases/kernel/mem/.gitignore
> @@ -20,6 +20,7 @@
>  /hugetlb/hugemmap/hugemmap17
>  /hugetlb/hugemmap/hugemmap18
>  /hugetlb/hugemmap/hugemmap19
> +/hugetlb/hugemmap/hugemmap20
>  /hugetlb/hugeshmat/hugeshmat01
>  /hugetlb/hugeshmat/hugeshmat02
>  /hugetlb/hugeshmat/hugeshmat03
> diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap20.c
> b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap20.c
> new file mode 100644
> index 000000000..9607d58b7
> --- /dev/null
> +++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap20.c
> @@ -0,0 +1,88 @@
> +// SPDX-License-Identifier: LGPL-2.1-or-later
> +/*
> + * Copyright (C) 2005-2006 David Gibson & Adam Litke, IBM Corporation.
> + * Author: David Gibson & Adam Litke
> + */
> +
> +/*\
> + * [Description]
> + *
> + * The test checks that mlocking hugetlb areas works with all combinations
> + * of MAP_PRIVATE and MAP_SHARED with and without MAP_LOCKED specified.
> + */
> +
> +#include <stdio.h>
> +#include <sys/mount.h>
> +#include <limits.h>
> +#include <sys/param.h>
> +#include <sys/types.h>
> +#include <sys/resource.h>
> +
> +#include "hugetlb.h"
> +
> +#define MNTPOINT "hugetlbfs/"
> +static int  fd = -1;
> +static unsigned long hpage_size;
> +
> +static void test_simple_mlock(int flags, char *flags_str)
> +{
> +       void *p;
> +       int ret;
> +
> +       fd = tst_creat_unlinked(MNTPOINT, 0);
> +       p = SAFE_MMAP(0, hpage_size, PROT_READ|PROT_WRITE, flags, fd, 0);
> +
> +       ret = mlock(p, hpage_size);
> +       if (ret) {
> +               tst_res(TFAIL|TERRNO, "mlock() failed (flags %s)",
> flags_str);
> +               goto cleanup;
> +       }
> +
> +       ret = munlock(p, hpage_size);
> +       if (ret)
> +               tst_res(TFAIL|TERRNO, "munlock() failed (flags %s)",
> flags_str);
> +       else
> +               tst_res(TPASS, "mlock/munlock with %s hugetlb mmap",
> +                               flags_str);
> +cleanup:
> +       SAFE_MUNMAP(p, hpage_size);
> +       SAFE_CLOSE(fd);
> +}
> +
> +static void run_test(void)
> +{
>



> +       struct rlimit limit_info;
> +
> +       if (getrlimit(RLIMIT_MEMLOCK, &limit_info))
> +               tst_res(TWARN|TERRNO, "Unable to read locked memory
> rlimit");
> +       if (limit_info.rlim_cur < hpage_size)
> +               tst_brk(TCONF, "Locked memory ulimit set below huge page
> size");
>

These lines are better for moving into setup() phase. And, I'd propose
printing the value of 'limit_info.rlim_cur' and 'hpage_size' when TCONF.

The default value of max-locked-memory is smaller than hpage_size on
both RHEL8 and 9, which means this test will TCONF and skip running.
I'm hesitating should we temporally cancel the limitations and make
this test can really perform then restore that value to the original,
is this change make sense? WDYT?



> +
> +       test_simple_mlock(MAP_PRIVATE, "MAP_PRIVATE");
> +       test_simple_mlock(MAP_SHARED, "MAP_SHARED");
> +       test_simple_mlock(MAP_PRIVATE|MAP_LOCKED,
> "MAP_PRIVATE|MAP_LOCKED");
> +       test_simple_mlock(MAP_SHARED|MAP_LOCKED, "MAP_SHARED|MAP_LOCKED");
>

If we define an additional function like flags_to_str(int flags) for
converting
the flag into a string, which will be more simple for reading.

static char *flags_to_str(int flags)
{
       ...
}

static void test_simple_mlock(int flags)
{
        char *flags_str = flags_to_str(flags);
        ...
}



> +
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
