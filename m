Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92221C10F1B
	for <ltp@archiver.kernel.org>; Wed, 28 Dec 2022 03:15:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E01313CB867
	for <ltp@archiver.kernel.org>; Wed, 28 Dec 2022 04:15:42 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2E05A3C4F11
 for <ltp@lists.linux.it>; Wed, 28 Dec 2022 04:15:31 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 69ECC100075F
 for <ltp@lists.linux.it>; Wed, 28 Dec 2022 04:15:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1672197328;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4VdXdgSs9eYacLuRN7xQR2GyGRYgxKwQlBnIQ+aL6X0=;
 b=Ighu8amxB1hE5IWyTFXJ9xJMR/mKU3mH/47OEXxRHv/SlJoiFk+m9CK1pK6ynZXF35l6pj
 n/H68F6DJgjNLzRm+aKrWGdln6h9EojdwnmLQ4SGFXNwC+AxmKvpCkflCJ1/wy6aHuyfmY
 8eIrjOxeaJTsj4UgRp3vt5k8Rt3Tjcg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-360-i_hsvIUVP7Kua_G_vT6KVQ-1; Tue, 27 Dec 2022 22:15:26 -0500
X-MC-Unique: i_hsvIUVP7Kua_G_vT6KVQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 m8-20020a05600c3b0800b003d96bdce12fso5994632wms.9
 for <ltp@lists.linux.it>; Tue, 27 Dec 2022 19:15:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4VdXdgSs9eYacLuRN7xQR2GyGRYgxKwQlBnIQ+aL6X0=;
 b=gwOQy4Avh76ZJFAm9D+s07XuzXR5Uhr7j2JYOt0I6Ua65W0CQLLVKVdv9BYAECALf6
 eYumGEzciiIOO0ir8GFjjBOoCLw1MguOQMImjAWsKaZrc+Shl0WBdFBXDA/m0Rp4rYzJ
 kRe1laDRysxh1PjaUvkUMyknG/ygim2ihXJp6/DQNIP58jKbi+Y4kk6PXtbar4KfiSHM
 yf/vzSR3JnRfdTiM7uSaWsK3xQsjBVn9Wdo2KzXtCjsFZsBDBWtIGBCmZE/vDs9w6zV6
 1x6zklJsQNPznUvT5OB6SJ6Bjs6QhY29qYnh7kpkxK+aP5N47K8U/kLGNfBFBVuuoYqG
 s1ow==
X-Gm-Message-State: AFqh2krzqDnjpSw3zk2xP4AVWc8zEg13DChLtoao5ChmuL44us4xgBBq
 cU470+cocX1zmdpjJHNKV86xd+t5OQlUbXBBq56wKhAec6m+TcEVc7KOe5NONddpehoTEbS6F48
 pCxm8iAhdaV73nuKpsfXpnIr334g=
X-Received: by 2002:a05:600c:201:b0:3d3:58d1:258f with SMTP id
 1-20020a05600c020100b003d358d1258fmr1137143wmi.121.1672197325053; 
 Tue, 27 Dec 2022 19:15:25 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsAKv3raqR+yU4QF5z30KpJ3DPPAweB1PjScYIP5XqgUn6TH7WYEE6n6l5lEgZygFJvqna2N5Fv220a4YFDILo=
X-Received: by 2002:a05:600c:201:b0:3d3:58d1:258f with SMTP id
 1-20020a05600c020100b003d358d1258fmr1137136wmi.121.1672197324791; Tue, 27 Dec
 2022 19:15:24 -0800 (PST)
MIME-Version: 1.0
References: <20221225154213.84183-1-tsahu@linux.ibm.com>
 <20221225154213.84183-13-tsahu@linux.ibm.com>
In-Reply-To: <20221225154213.84183-13-tsahu@linux.ibm.com>
From: Li Wang <liwang@redhat.com>
Date: Wed, 28 Dec 2022 11:15:13 +0800
Message-ID: <CAEemH2f9QsOP9Jn2uhBvFnE3gQi6Rx6dFT_Vz3S9Wo5t4q+7gg@mail.gmail.com>
To: Tarun Sahu <tsahu@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 12/13] Hugetlb: Migrating libhugetlbfs shm-fork
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

> Migrating the libhugetlbfs/testcases/shm-fork.c test
>
> Test Description: Test shared memory behavior when multiple threads are
> Test shared memory behavior when multiple threads are attached
> to a segment.  A segment is created and then children are
> spawned which attach, write, read (verify), and detach from the
> shared memory segment.
>
> Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
> ---
>  runtest/hugetlb                               |   1 +
>  testcases/kernel/mem/.gitignore               |   1 +
>  .../kernel/mem/hugetlb/hugefork/hugefork02.c  | 104 ++++++++++++++++++
>  3 files changed, 106 insertions(+)
>  create mode 100644 testcases/kernel/mem/hugetlb/hugefork/hugefork02.c
>
> diff --git a/runtest/hugetlb b/runtest/hugetlb
> index 33fd384b4..348a7dc5f 100644
> --- a/runtest/hugetlb
> +++ b/runtest/hugetlb
> @@ -2,6 +2,7 @@ hugefallocate01 hugefallocate01
>  hugefallocate02 hugefallocate02
>
>  hugefork01 hugefork01
> +hugefork02 hugefork02 -P 3 -s 5
>
>  hugemmap01 hugemmap01
>  hugemmap02 hugemmap02
> diff --git a/testcases/kernel/mem/.gitignore
> b/testcases/kernel/mem/.gitignore
> index 8375389cd..0c1311303 100644
> --- a/testcases/kernel/mem/.gitignore
> +++ b/testcases/kernel/mem/.gitignore
> @@ -2,6 +2,7 @@
>  /hugetlb/hugefallocate/hugefallocate01
>  /hugetlb/hugefallocate/hugefallocate02
>  /hugetlb/hugefork/hugefork01
> +/hugetlb/hugefork/hugefork02
>  /hugetlb/hugemmap/hugemmap01
>  /hugetlb/hugemmap/hugemmap02
>  /hugetlb/hugemmap/hugemmap04
> diff --git a/testcases/kernel/mem/hugetlb/hugefork/hugefork02.c
> b/testcases/kernel/mem/hugetlb/hugefork/hugefork02.c
> new file mode 100644
> index 000000000..6596bf81f
> --- /dev/null
> +++ b/testcases/kernel/mem/hugetlb/hugefork/hugefork02.c
> @@ -0,0 +1,104 @@
> +// SPDX-License-Identifier: LGPL-2.1-or-later
> +/*
> + * Copyright (C) 2005-2006 David Gibson & Adam Litke, IBM Corporation.
> + * Author: David Gibson & Adam Litke
> + */
> +
> +/*\
> + * [Description]
> + *
> + * Test shared memory behavior when multiple threads are attached to a
> + * segment. A segment is created and then children are spawned which
> + * attach, write, read (verify), and detach from the shared memory
> segment.
> + */
> +
> +#define _GNU_SOURCE
> +#include <stdio.h>
> +#include <sys/mount.h>
> +#include <limits.h>
> +#include <sys/param.h>
> +#include <setjmp.h>
> +#include <sys/types.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include <sys/shm.h>
> +
> +#include "tst_safe_sysv_ipc.h"
> +#include "hugetlb.h"
> +
> +static int shmid = -1;
> +
> +#define NR_HUGEPAGES 5
>



> +#define NUMPROCS 20
>

Defining a fixed number to fork children might not be wise.

A sanity way is to detect the available NCPUS and create
corresponding children (or twice the amount), this will benefit
small machines (e.g. KVM guest with only single CPU).
For a system with a larger number of CPUs, just choose 20 as
the default will be OK.

LTP has tst_ncpus_available() function for getting available NCPUS.



> +#define MNTPOINT "hugetlbfs/"
>


> +#define MAX_PROCS 200
> +#define BUF_SZ 256
>

I don't see any places using these two macros.


+
> +static long hpage_size;
> +
> +static void do_child(int thread, unsigned long size)
> +{
> +       volatile char *shmaddr;
> +       int j;
> +       unsigned long k;
> +
> +       for (j = 0; j < 5; j++) {
> +               shmaddr = SAFE_SHMAT(shmid, 0, SHM_RND);
> +
> +               for (k = 0; k < size; k++)
> +                       shmaddr[k] = (char) (k);
> +               for (k = 0; k < size; k++)
> +                       if (shmaddr[k] != (char)k) {
> +                               tst_res(TFAIL, "Thread %d, Offset %lu
> mismatch", thread, k);
> +                               goto cleanup;
> +                       }
> +
> +               SAFE_SHMDT((const void *)shmaddr);
> +       }
> +cleanup:
> +       exit(0);
> +}
> +
> +static void run_test(void)
> +{
> +       unsigned long size;
> +       int pid;
> +       int i;
> +
> +       size = hpage_size * NR_HUGEPAGES;
> +       shmid = SAFE_SHMGET(2, size, SHM_HUGETLB|IPC_CREAT|SHM_R|SHM_W);
> +
> +       for (i = 0; i < NUMPROCS; i++) {
> +               pid = SAFE_FORK();
> +
> +               if (pid == 0)
> +                       do_child(i, size);
> +       }
> +
> +       tst_reap_children();
> +       tst_res(TPASS, "Successfully tested shared hugetlb memory with
> multiple procs");
> +}
> +
> +static void setup(void)
> +{
> +       hpage_size = SAFE_READ_MEMINFO(MEMINFO_HPAGE_SIZE)*1024;
> +}
> +
> +static void cleanup(void)
> +{
> +       if (shmid >= 0)
> +               SAFE_SHMCTL(shmid, IPC_RMID, NULL);
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
