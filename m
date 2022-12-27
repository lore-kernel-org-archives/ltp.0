Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 747EFC10F1B
	for <ltp@archiver.kernel.org>; Tue, 27 Dec 2022 06:31:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EF0AB3CB846
	for <ltp@archiver.kernel.org>; Tue, 27 Dec 2022 07:31:37 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7FA9D3C4F11
 for <ltp@lists.linux.it>; Tue, 27 Dec 2022 07:31:24 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id EA846600680
 for <ltp@lists.linux.it>; Tue, 27 Dec 2022 07:31:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1672122682;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZdkY4plpYvvSZQKEKpgTaijDa5yoEwr/KhJilbViqBM=;
 b=KhL4TSp/ahh19uYywfdJKadlDpUutX4h0SoLPxtfTsF7Z9K4Y7iCsdLCQM/VXWb3Ycn8lT
 Pb0wRVjADxJJygLWWKWG9e55zJCTlNY2/ybyjlKPXX/2+oT2dQy7kSTa4o9cgx0ghDT8Lf
 Bmq2PoBCE7w60TiiHvgp3qb/Wb9PsjI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-83-43DU1JyyOiSoLuZ8oc72vw-1; Tue, 27 Dec 2022 01:31:20 -0500
X-MC-Unique: 43DU1JyyOiSoLuZ8oc72vw-1
Received: by mail-wr1-f70.google.com with SMTP id
 w20-20020adf8bd4000000b00272d0029f18so1126390wra.7
 for <ltp@lists.linux.it>; Mon, 26 Dec 2022 22:31:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZdkY4plpYvvSZQKEKpgTaijDa5yoEwr/KhJilbViqBM=;
 b=VbQZS0FIcVu4OS5qOhg/KlPnNDHhDavZtf3Roif7JeDtly3PrEvIiznh6iiFP5NhsD
 nxDrIwR3jkdle9VClVe1kaq7NvXVSOD4FNs0+7tYe9bINiXzyU+BdN7cMpzBJXIfkoNf
 insiHhR8UvW7fanNrEKhuBjVw4EbnHri9LWX8LxmjEiDxMAyEV6o9DFdH23e5XVJzr/r
 SBffiaV4F1v0StLuJ/+l95PS1kqwJNAQ2mmjDWis5bE0ddJmfAg87ZOWB9jMFw7X1Yl7
 DhenAdXiecn6n51GCSITzbCYP8Epb7pcXRnYDyeBcXNQlYWpEMobuHFZ7jwVmcOFCNK3
 +ThQ==
X-Gm-Message-State: AFqh2kpmK7FGp5DlwCY5I0yK6M90ceuuOaXYzRelOiRh+xbSx4viR0hN
 Nhqg+1UjPFJZcGFPFxZJSg90NJ5fWfdI4jP8rHE1Q1RD4Kp3irg79xPeNvKWjoL5+juJSJpljqL
 XcjMrK0CjE1vpIfQbX/C+db6o5xs=
X-Received: by 2002:a5d:4a90:0:b0:27a:2d68:8c25 with SMTP id
 o16-20020a5d4a90000000b0027a2d688c25mr276385wrq.707.1672122679139; 
 Mon, 26 Dec 2022 22:31:19 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsJDm0Rbv99jRuSR5nm+GDtfp+GiPQQOXeTYv/3EW0346qKh0tSSL+LtxfQ8i7joL5uZcJjZimlq93jYF/ktY0=
X-Received: by 2002:a5d:4a90:0:b0:27a:2d68:8c25 with SMTP id
 o16-20020a5d4a90000000b0027a2d688c25mr276376wrq.707.1672122678813; Mon, 26
 Dec 2022 22:31:18 -0800 (PST)
MIME-Version: 1.0
References: <20221225154213.84183-1-tsahu@linux.ibm.com>
 <20221225154213.84183-7-tsahu@linux.ibm.com>
In-Reply-To: <20221225154213.84183-7-tsahu@linux.ibm.com>
From: Li Wang <liwang@redhat.com>
Date: Tue, 27 Dec 2022 14:31:07 +0800
Message-ID: <CAEemH2fOB=NSnCt=JMhpDU49MwHvP+z7hjmUoEXi-BEM-tvqCw@mail.gmail.com>
To: Tarun Sahu <tsahu@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 06/13] Hugetlb: Migrating libhugetlbfs
 mremap-fixed-normal-near-huge
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

> Migrating the libhugetlbfs/testcases/mremap-fixed-normal-near-huge.c test
>
> Test Description: The kernel has bug for mremap() on some architecture.
> mremap() can cause crashes on architectures with holes in the address
> space (like ia64) and on powerpc with it's distinct page size "slices".
>
> This test get the huge mapping address and mremap() normal mapping
> near to this huge mapping.
>
> Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
> ---
>  runtest/hugetlb                               |   1 +
>  testcases/kernel/mem/.gitignore               |   1 +
>  .../kernel/mem/hugetlb/hugemmap/hugemmap26.c  | 131 ++++++++++++++++++
>  3 files changed, 133 insertions(+)
>  create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap26.c
>
> diff --git a/runtest/hugetlb b/runtest/hugetlb
> index 65265b0fe..55185f2f7 100644
> --- a/runtest/hugetlb
> +++ b/runtest/hugetlb
> @@ -26,6 +26,7 @@ hugemmap21 hugemmap21
>  hugemmap22 hugemmap22
>  hugemmap23 hugemmap23
>  hugemmap25 hugemmap25
> +hugemmap26 hugemmap26
>  hugemmap05_1 hugemmap05 -m
>  hugemmap05_2 hugemmap05 -s
>  hugemmap05_3 hugemmap05 -s -m
> diff --git a/testcases/kernel/mem/.gitignore
> b/testcases/kernel/mem/.gitignore
> index c865a1e55..4886c6a5f 100644
> --- a/testcases/kernel/mem/.gitignore
> +++ b/testcases/kernel/mem/.gitignore
> @@ -25,6 +25,7 @@
>  /hugetlb/hugemmap/hugemmap22
>  /hugetlb/hugemmap/hugemmap23
>  /hugetlb/hugemmap/hugemmap25
> +/hugetlb/hugemmap/hugemmap26
>  /hugetlb/hugeshmat/hugeshmat01
>  /hugetlb/hugeshmat/hugeshmat02
>  /hugetlb/hugeshmat/hugeshmat03
> diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap26.c
> b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap26.c
> new file mode 100644
> index 000000000..03dd248bd
> --- /dev/null
> +++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap26.c
> @@ -0,0 +1,131 @@
> +// SPDX-License-Identifier: LGPL-2.1-or-later
> +/*
> + * Copyright (C) 2009 IBM Corporation.
> + * Author: David Gibson
> + */
> +
> +/*\
> + * [Description]
> + *
> + * Test Description: The kernel has bug for mremap() on some architecture.
> + * mremap() can cause crashes on architectures with holes in the address
> + * space (like ia64) and on powerpc with it's distinct page size "slices".
> + *
> + * This test get the huge mapping address and mremap() normal mapping
> + * near to this huge mapping.
> + */
> +
> +#define _GNU_SOURCE
> +#include <stdio.h>
> +#include <sys/mount.h>
> +#include <limits.h>
> +#include <sys/param.h>
> +#include <sys/types.h>
> +
> +#include "hugetlb.h"
> +
> +#define RANDOM_CONSTANT        0x1234ABCD
> +#define MNTPOINT "hugetlbfs/"
> +
> +static int  fd = -1;
> +static long hpage_size, page_size;
> +
> +static int do_readback(void *p, size_t size, const char *stage)
> +{
> +       unsigned int *q = p;
> +       size_t i;
> +
> +       tst_res(TINFO, "%s(%p, 0x%lx, \"%s\")", __func__, p,
> +              (unsigned long)size, stage);
> +
> +       for (i = 0; i < (size / sizeof(*q)); i++)
> +               q[i] = RANDOM_CONSTANT ^ i;
> +
> +       for (i = 0; i < (size / sizeof(*q)); i++) {
> +               if (q[i] != (RANDOM_CONSTANT ^ i)) {
> +                       tst_res(TFAIL, "Stage \"%s\": Mismatch at offset
> 0x%lx: 0x%x "
> +                                       "instead of 0x%lx", stage, i,
> q[i], RANDOM_CONSTANT ^ i);
> +                       return -1;
> +               }
> +       }
> +       return 0;
> +}
> +
> +static int do_remap(void *target)
> +{
> +       void *a, *b;
> +       int ret;
> +
> +       a = SAFE_MMAP(NULL, page_size, PROT_READ|PROT_WRITE,
> +                 MAP_SHARED|MAP_ANONYMOUS, -1, 0);
> +
> +       ret = do_readback(a, page_size, "base normal");
> +       if (ret)
> +               goto cleanup;
> +       b = mremap(a, page_size, page_size, MREMAP_MAYMOVE | MREMAP_FIXED,
> +                  target);
> +
> +       if (b != MAP_FAILED) {
> +               do_readback(b, page_size, "remapped");
> +               a = b;
> +       } else
> +               tst_res(TINFO|TERRNO, "mremap(MAYMOVE|FIXED) disallowed");
> +
> +cleanup:
> +       SAFE_MUNMAP(a, page_size);
> +       return ret;
> +}
>

Those two functions do_readback() and do_remap() are
copy&past from hugemmap2[4|5].c, what about extracting
them into a common header file(tst_hugetlb.h or mem.h) for
easy reusing?

And I also noticed other tests (hugemmap27) using the same
macro mem barrier(), it'd be great to define it in a header file.


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
