Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82684C433F5
	for <ltp@archiver.kernel.org>; Wed,  9 Feb 2022 11:05:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D5CD73C9BA1
	for <ltp@archiver.kernel.org>; Wed,  9 Feb 2022 12:05:47 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 16DE53C68DE
 for <ltp@lists.linux.it>; Wed,  9 Feb 2022 12:05:37 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 68FD51400063
 for <ltp@lists.linux.it>; Wed,  9 Feb 2022 12:05:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1644404735;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/mnBN/pFPHjBXbFNZ7Qfzyqns2WVVd+hFRqPcDyRDsY=;
 b=TDHiQRcHIUR8GRjzXUZ85FDmd7gmszInPTPJ4EKGQL01nFrFobK3KCqhnkOod/7UG+NQWs
 l6GasnGTAAiSjXDJXqNw/DeFNoKiYUimcZ+ec5/URpudd0SdEkk9oOIVJoPtjyKYnW8al2
 FTYOENTSSkoBCgpKtalWkkaNOeq77lg=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-2-mOGUt89fOYO6Pbbcm6Ccag-1; Wed, 09 Feb 2022 06:05:31 -0500
X-MC-Unique: mOGUt89fOYO6Pbbcm6Ccag-1
Received: by mail-yb1-f199.google.com with SMTP id
 m10-20020a25800a000000b0061daa5b7151so4028358ybk.10
 for <ltp@lists.linux.it>; Wed, 09 Feb 2022 03:05:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/mnBN/pFPHjBXbFNZ7Qfzyqns2WVVd+hFRqPcDyRDsY=;
 b=7GHmBkXMnXjWoFZKUBJjRJOiVqumnCvfJi3GXFxnc5PK+evi1u/z7n6NTFVi+ZOjAf
 gdDCLXwSdXKyHKLpv9cljIJp962h+fTTYQ3HN++GM1ufRrYkolqi5qt1KH+q1I98ccYf
 LhBWXSGcrUzpt/1EKfdjKjhAs4TmDtqhqKhs9gQsVrzB2bbd4xFTFHw/EHN7AG5Qemo4
 BTUdoYtwe61Jw/Mh/CFmgbuPYPhyiP/sAVkZpxvJOgGL11MfTR5EudlsXZVfMsHsGbFo
 4zA5HKxMV/F3dmWW2+EJjt8mVUAM5hlyTFCHqarhfsEV5hj6n46E8XxpObrG+PTqhq0Y
 gheQ==
X-Gm-Message-State: AOAM5317+9nSvzlvVJpyFdGT1aozePDR6TW3uAi+hm9Z4VtgAFsJdnEW
 76mBv0PJd37WGK9B3YQpl6SS1lvVlB8SRLASIuHlS5ve1Klkao9RKS5z6/PoKolfEvLV5J+pWDD
 L04nzCDchZjPdeMtPPGf7CD9bKl8=
X-Received: by 2002:a81:e543:: with SMTP id c3mr1474935ywm.370.1644404730619; 
 Wed, 09 Feb 2022 03:05:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzmREduhwxXWIyo8i2tVRnlr/zrUZjEl4Zt68fqrc2GT0B3BzY9cVo/EDkyXvvXv4iC6rqAqWNn9dLTEUqBPNQ=
X-Received: by 2002:a81:e543:: with SMTP id c3mr1474911ywm.370.1644404730326; 
 Wed, 09 Feb 2022 03:05:30 -0800 (PST)
MIME-Version: 1.0
References: <20220208140322.6842-1-rpalethorpe@suse.com>
 <20220208140322.6842-4-rpalethorpe@suse.com>
In-Reply-To: <20220208140322.6842-4-rpalethorpe@suse.com>
From: Li Wang <liwang@redhat.com>
Date: Wed, 9 Feb 2022 19:05:16 +0800
Message-ID: <CAEemH2e2btUUYqj69nWGpXC4B43Dg7+y8-m2udsNCjtZr6s7Tg@mail.gmail.com>
To: Richard Palethorpe <rpalethorpe@suse.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/3] memcontrol04: Copy from kselftest
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: multipart/mixed; boundary="===============0484072924=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0484072924==
Content-Type: multipart/alternative; boundary="000000000000d1834605d793cf88"

--000000000000d1834605d793cf88
Content-Type: text/plain; charset="UTF-8"

On Tue, Feb 8, 2022 at 10:04 PM Richard Palethorpe via ltp <
ltp@lists.linux.it> wrote:

> At first glance this test looks the same as memcontrol03. However
> there are some significant changes which complicate combining the two.
>
> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
> ---
>  runtest/controllers                           |   1 +
>  testcases/kernel/controllers/memcg/.gitignore |   1 +
>  .../kernel/controllers/memcg/memcontrol04.c   | 228 ++++++++++++++++++
>  3 files changed, 230 insertions(+)
>  create mode 100644 testcases/kernel/controllers/memcg/memcontrol04.c
>
> diff --git a/runtest/controllers b/runtest/controllers
> index 4a6f919af..3108a2561 100644
> --- a/runtest/controllers
> +++ b/runtest/controllers
> @@ -20,6 +20,7 @@ memcg_control         memcg_control_test.sh
>  memcontrol01 memcontrol01
>  memcontrol02 memcontrol02
>  memcontrol03 memcontrol03
> +memcontrol04 memcontrol04
>
>  cgroup_fj_function_debug cgroup_fj_function.sh debug
>  cgroup_fj_function_cpuset cgroup_fj_function.sh cpuset
> diff --git a/testcases/kernel/controllers/memcg/.gitignore
> b/testcases/kernel/controllers/memcg/.gitignore
> index 49df1582c..3883cede6 100644
> --- a/testcases/kernel/controllers/memcg/.gitignore
> +++ b/testcases/kernel/controllers/memcg/.gitignore
> @@ -8,3 +8,4 @@
>  memcontrol01
>  memcontrol02
>  memcontrol03
> +memcontrol04
> diff --git a/testcases/kernel/controllers/memcg/memcontrol04.c
> b/testcases/kernel/controllers/memcg/memcontrol04.c
> new file mode 100644
> index 000000000..cdfeff4a4
> --- /dev/null
> +++ b/testcases/kernel/controllers/memcg/memcontrol04.c
> @@ -0,0 +1,228 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*\
> + *
> + * [Description]
> + *
> + * Conversion of the forth kself test in cgroup/test_memcontrol.c.
> + *
> + * Original description:
> + * "First, this test creates the following hierarchy:
> + * A       memory.low = 50M,  memory.max = 200M
> + * A/B     memory.low = 50M,  memory.current = 50M
> + * A/B/C   memory.low = 75M,  memory.current = 50M
> + * A/B/D   memory.low = 25M,  memory.current = 50M
> + * A/B/E   memory.low = 500M, memory.current = 0
> + * A/B/F   memory.low = 0,    memory.current = 50M
> + *
> + * Usages are pagecache
> + * Then it creates A/G and creates a significant
> + * memory pressure in it.
> + *
> + * A/B    memory.current ~= 50M
> + * A/B/C  memory.current ~= 33M
> + * A/B/D  memory.current ~= 17M
> + * A/B/E  memory.current ~= 0
> + *
> + * After that it tries to allocate more than there is unprotected
> + * memory in A available, and checks that memory.low protects
> + * pagecache even in this case."
> + *
> + * The closest thing to memory.low on V1 is soft_limit_in_bytes which
> + * uses a different mechanism and has different semantics. So we only
> + * test on V2 like the selftest. We do test on more file systems, but
> + * not tempfs becaue it can't evict the page cache without swap. Also
> + * we avoid filesystems which allocate extra memory for buffer heads.
> + *
> + * The tolerances have been increased from the self tests.
> + */
> +
> +#define _GNU_SOURCE
> +
> +#include <inttypes.h>
> +
> +#include "memcontrol_common.h"
> +
> +#define TMPDIR "mntdir"
> +
> +static struct tst_cg_group *trunk_cg[3];
> +static struct tst_cg_group *leaf_cg[4];
> +static int fd = -1;
> +
> +enum checkpoints {
> +       CHILD_IDLE
> +};
> +
> +enum trunk_cg {
> +       A,
> +       B,
> +       G
> +};
> +
> +enum leaf_cg {
> +       C,
> +       D,
> +       E,
> +       F
> +};
> +
> +static void cleanup_sub_groups(void)
> +{
> +       size_t i;
> +
> +       for (i = ARRAY_SIZE(leaf_cg); i > 0; i--) {
> +               if (!leaf_cg[i - 1])
> +                       continue;
> +
> +               leaf_cg[i - 1] = tst_cg_group_rm(leaf_cg[i - 1]);
> +       }
> +
> +       for (i = ARRAY_SIZE(trunk_cg); i > 0; i--) {
> +               if (!trunk_cg[i - 1])
> +                       continue;
> +
> +               trunk_cg[i - 1] = tst_cg_group_rm(trunk_cg[i - 1]);
> +       }
> +}
> +
> +static void alloc_anon_in_child(const struct tst_cg_group *const cg,
> +                               const size_t size)
> +{
> +       const pid_t pid = SAFE_FORK();
> +
> +       if (pid) {
> +               tst_reap_children();
> +               return;
> +       }
> +
> +       SAFE_CG_PRINTF(cg, "cgroup.procs", "%d", getpid());
> +
> +       tst_res(TINFO, "Child %d in %s: Allocating anon: %"PRIdPTR,
> +               getpid(), tst_cg_group_name(cg), size);
> +       alloc_anon(size);
> +
> +       exit(0);
> +}
> +
> +static void alloc_pagecache_in_child(const struct tst_cg_group *const cg,
> +                                    const size_t size)
> +{
> +       const pid_t pid = SAFE_FORK();
> +
> +       if (pid) {
> +               tst_reap_children();
> +               return;
> +       }
> +
> +       SAFE_CG_PRINTF(cg, "cgroup.procs", "%d", getpid());
> +
> +       tst_res(TINFO, "Child %d in %s: Allocating pagecache: %"PRIdPTR,
> +               getpid(), tst_cg_group_name(cg), size);
> +       alloc_pagecache(fd, size);
> +
> +       exit(0);
> +}
> +
> +static void test_memcg_min(void)
>

test_memcg_low() ^



> +{
> +       long c[4];
> +       unsigned int i;
> +
> +       fd = SAFE_OPEN(TMPDIR"/tmpfile", O_RDWR | O_CREAT, 0600);
> +       trunk_cg[A] = tst_cg_group_mk(tst_cg, "trunk_A");
> +
> +       SAFE_CG_SCANF(trunk_cg[A], "memory.low", "%ld", c);
> +       if (c[0]) {
> +               tst_brk(TCONF,
> +                       "memory.low already set to %ld on parent group",
> c[0]);
> +       }
> +
> +       SAFE_CG_PRINT(trunk_cg[A], "cgroup.subtree_control", "+memory");
> +
> +       SAFE_CG_PRINT(trunk_cg[A], "memory.max", "200M");
> +       SAFE_CG_PRINT(trunk_cg[A], "memory.swap.max", "0");
> +
> +       trunk_cg[B] = tst_cg_group_mk(trunk_cg[A], "trunk_B");
> +
> +       SAFE_CG_PRINT(trunk_cg[B], "cgroup.subtree_control", "+memory");
> +
> +       trunk_cg[G] = tst_cg_group_mk(trunk_cg[A], "trunk_G");
> +
> +       for (i = 0; i < ARRAY_SIZE(leaf_cg); i++) {
> +               leaf_cg[i] = tst_cg_group_mk(trunk_cg[B],
> +                                                "leaf_%c", 'C' + i);
> +
> +               if (i == E)
> +                       continue;
> +
> +               alloc_pagecache_in_child(leaf_cg[i], MB(50));
> +       }
> +
> +       SAFE_CG_PRINT(trunk_cg[A], "memory.low", "50M");
> +       SAFE_CG_PRINT(trunk_cg[B], "memory.low", "50M");
> +       SAFE_CG_PRINT(leaf_cg[C], "memory.low", "75M");
> +       SAFE_CG_PRINT(leaf_cg[D], "memory.low", "25M");
> +       SAFE_CG_PRINT(leaf_cg[E], "memory.low", "500M");
> +       SAFE_CG_PRINT(leaf_cg[F], "memory.low", "0");
> +
> +       alloc_anon_in_child(trunk_cg[G], MB(148));
> +
> +       SAFE_CG_SCANF(trunk_cg[B], "memory.current", "%ld", c);
> +       TST_EXP_EXPR(values_close(c[0], MB(50), 5),
> +                    "(A/B memory.current=%ld) ~= %d", c[0], MB(50));
> +
> +       for (i = 0; i < ARRAY_SIZE(leaf_cg); i++)
> +               SAFE_CG_SCANF(leaf_cg[i], "memory.current", "%ld", c + i);
> +
> +       TST_EXP_EXPR(values_close(c[0], MB(33), 20),
> +                    "(A/B/C memory.current=%ld) ~= %d", c[0], MB(33));
> +       TST_EXP_EXPR(values_close(c[1], MB(17), 20),
> +                    "(A/B/D memory.current=%ld) ~= %d", c[1], MB(17));
> +       TST_EXP_EXPR(values_close(c[2], 0, 1),
> +                    "(A/B/E memory.current=%ld) ~= 0", c[2]);
> +
> +       alloc_anon_in_child(trunk_cg[G], MB(166));
> +
> +       for (i = 0; i < ARRAY_SIZE(leaf_cg); i++) {
> +               long low, oom;
> +
> +               SAFE_CG_LINES_SCANF(leaf_cg[i], "memory.events",
> +                                       "low %ld", &low);
> +               SAFE_CG_LINES_SCANF(leaf_cg[i], "memory.events",
> +                                       "oom %ld", &oom);
> +
> +               TST_EXP_EXPR(oom == 0, "(oom events=%ld) == 0", oom);
> +
> +               if (i < E)
> +                       TST_EXP_EXPR(low > 0, "(low events=%ld) > 0", low)
> +               else
> +                       TST_EXP_EXPR(low == 0, "(low events=%ld) == 0",
> low);
> +       }
> +
> +       cleanup_sub_groups();
> +       SAFE_CLOSE(fd);
> +       SAFE_UNLINK(TMPDIR"/tmpfile");
> +}
> +
> +static void cleanup(void)
> +{
> +       cleanup_sub_groups();
> +       if (fd > -1)
> +               SAFE_CLOSE(fd);
> +}
> +
> +static struct tst_test test = {
> +       .cleanup = cleanup,
> +       .test_all = test_memcg_min,
>

test_memcg_low  ^



> +       .mount_device = 1,
> +       .dev_min_size = 256,
> +       .mntpoint = TMPDIR,
> +       .all_filesystems = 1,
> +       .skip_filesystems = (const char *const[]){
> +               "exfat", "vfat", "fuse", "ntfs", "tmpfs", NULL
> +       },
> +       .forks_child = 1,
> +       .needs_root = 1,
> +       .needs_checkpoints = 1,
> +       .needs_cgroup_ver = TST_CG_V2,
> +       .needs_cgroup_ctrls = (const char *const[]){ "memory", NULL },
> +};
>


Apart from the tiny issues and controversy on renaming in patch2/3.
The test itself looks good if we decide to go separate with memcontrol03.c

Btw, there are some TFAILs from my manual run.
(I will look into that try to figure it out tomorrow)

tst_test.c:1521: TINFO: Testing on ext4
tst_test.c:996: TINFO: Formatting /dev/loop0 with ext4 opts='' extra opts=''
mke2fs 1.46.5 (30-Dec-2021)
tst_test.c:1452: TINFO: Timeout per run is 0h 05m 00s
memcontrol04.c:118: TINFO: Child 242775 in leaf_C: Allocating pagecache:
52428800
memcontrol04.c:118: TINFO: Child 242776 in leaf_D: Allocating pagecache:
52428800
memcontrol04.c:118: TINFO: Child 242777 in leaf_F: Allocating pagecache:
52428800
memcontrol04.c:99: TINFO: Child 242778 in trunk_G: Allocating anon:
155189248
memcontrol04.c:170: TPASS: Expect: (A/B memory.current=54181888) ~= 52428800
memcontrol04.c:176: TPASS: Expect: (A/B/C memory.current=30957568) ~=
34603008
memcontrol04.c:178: TPASS: Expect: (A/B/D memory.current=22282240) ~=
17825792
memcontrol04.c:180: TPASS: Expect: (A/B/E memory.current=0) ~= 0
memcontrol04.c:99: TINFO: Child 242779 in trunk_G: Allocating anon:
174063616
memcontrol04.c:193: TPASS: Expect: (oom events=0) == 0
memcontrol04.c:196: TPASS: Expect: (low events=373) > 0
memcontrol04.c:193: TPASS: Expect: (oom events=0) == 0
memcontrol04.c:196: TPASS: Expect: (low events=373) > 0
memcontrol04.c:193: TPASS: Expect: (oom events=0) == 0
memcontrol04.c:198: TPASS: Expect: (low events=0) == 0
memcontrol04.c:193: TPASS: Expect: (oom events=0) == 0
memcontrol04.c:198: TFAIL: Expect: (low events=370) == 0


-- 
Regards,
Li Wang

--000000000000d1834605d793cf88
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Tue, Feb 8, 2022 at 10:04 PM Richard Palethorpe =
via ltp &lt;<a href=3D"mailto:ltp@lists.linux.it">ltp@lists.linux.it</a>&gt=
; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">At firs=
t glance this test looks the same as memcontrol03. However<br>
there are some significant changes which complicate combining the two.<br>
<br>
Signed-off-by: Richard Palethorpe &lt;<a href=3D"mailto:rpalethorpe@suse.co=
m" target=3D"_blank">rpalethorpe@suse.com</a>&gt;<br>
---<br>
=C2=A0runtest/controllers=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
=C2=A0testcases/kernel/controllers/memcg/.gitignore |=C2=A0 =C2=A01 +<br>
=C2=A0.../kernel/controllers/memcg/memcontrol04.c=C2=A0 =C2=A0| 228 +++++++=
+++++++++++<br>
=C2=A03 files changed, 230 insertions(+)<br>
=C2=A0create mode 100644 testcases/kernel/controllers/memcg/memcontrol04.c<=
br>
<br>
diff --git a/runtest/controllers b/runtest/controllers<br>
index 4a6f919af..3108a2561 100644<br>
--- a/runtest/controllers<br>
+++ b/runtest/controllers<br>
@@ -20,6 +20,7 @@ memcg_control=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memcg_cont=
rol_test.sh<br>
=C2=A0memcontrol01 memcontrol01<br>
=C2=A0memcontrol02 memcontrol02<br>
=C2=A0memcontrol03 memcontrol03<br>
+memcontrol04 memcontrol04<br>
<br>
=C2=A0cgroup_fj_function_debug cgroup_fj_function.sh debug<br>
=C2=A0cgroup_fj_function_cpuset cgroup_fj_function.sh cpuset<br>
diff --git a/testcases/kernel/controllers/memcg/.gitignore b/testcases/kern=
el/controllers/memcg/.gitignore<br>
index 49df1582c..3883cede6 100644<br>
--- a/testcases/kernel/controllers/memcg/.gitignore<br>
+++ b/testcases/kernel/controllers/memcg/.gitignore<br>
@@ -8,3 +8,4 @@<br>
=C2=A0memcontrol01<br>
=C2=A0memcontrol02<br>
=C2=A0memcontrol03<br>
+memcontrol04<br>
diff --git a/testcases/kernel/controllers/memcg/memcontrol04.c b/testcases/=
kernel/controllers/memcg/memcontrol04.c<br>
new file mode 100644<br>
index 000000000..cdfeff4a4<br>
--- /dev/null<br>
+++ b/testcases/kernel/controllers/memcg/memcontrol04.c<br>
@@ -0,0 +1,228 @@<br>
+// SPDX-License-Identifier: GPL-2.0<br>
+/*\<br>
+ *<br>
+ * [Description]<br>
+ *<br>
+ * Conversion of the forth kself test in cgroup/test_memcontrol.c.<br>
+ *<br>
+ * Original description:<br>
+ * &quot;First, this test creates the following hierarchy:<br>
+ * A=C2=A0 =C2=A0 =C2=A0 =C2=A0memory.low =3D 50M,=C2=A0 memory.max =3D 20=
0M<br>
+ * A/B=C2=A0 =C2=A0 =C2=A0memory.low =3D 50M,=C2=A0 memory.current =3D 50M=
<br>
+ * A/B/C=C2=A0 =C2=A0memory.low =3D 75M,=C2=A0 memory.current =3D 50M<br>
+ * A/B/D=C2=A0 =C2=A0memory.low =3D 25M,=C2=A0 memory.current =3D 50M<br>
+ * A/B/E=C2=A0 =C2=A0memory.low =3D 500M, memory.current =3D 0<br>
+ * A/B/F=C2=A0 =C2=A0memory.low =3D 0,=C2=A0 =C2=A0 memory.current =3D 50M=
<br>
+ *<br>
+ * Usages are pagecache<br>
+ * Then it creates A/G and creates a significant<br>
+ * memory pressure in it.<br>
+ *<br>
+ * A/B=C2=A0 =C2=A0 memory.current ~=3D 50M<br>
+ * A/B/C=C2=A0 memory.current ~=3D 33M<br>
+ * A/B/D=C2=A0 memory.current ~=3D 17M<br>
+ * A/B/E=C2=A0 memory.current ~=3D 0<br>
+ *<br>
+ * After that it tries to allocate more than there is unprotected<br>
+ * memory in A available, and checks that memory.low protects<br>
+ * pagecache even in this case.&quot;<br>
+ *<br>
+ * The closest thing to memory.low on V1 is soft_limit_in_bytes which<br>
+ * uses a different mechanism and has different semantics. So we only<br>
+ * test on V2 like the selftest. We do test on more file systems, but<br>
+ * not tempfs becaue it can&#39;t evict the page cache without swap. Also<=
br>
+ * we avoid filesystems which allocate extra memory for buffer heads.<br>
+ *<br>
+ * The tolerances have been increased from the self tests.<br>
+ */<br>
+<br>
+#define _GNU_SOURCE<br>
+<br>
+#include &lt;inttypes.h&gt;<br>
+<br>
+#include &quot;memcontrol_common.h&quot;<br>
+<br>
+#define TMPDIR &quot;mntdir&quot;<br>
+<br>
+static struct tst_cg_group *trunk_cg[3];<br>
+static struct tst_cg_group *leaf_cg[4];<br>
+static int fd =3D -1;<br>
+<br>
+enum checkpoints {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0CHILD_IDLE<br>
+};<br>
+<br>
+enum trunk_cg {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0A,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0B,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0G<br>
+};<br>
+<br>
+enum leaf_cg {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0C,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0D,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0E,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0F<br>
+};<br>
+<br>
+static void cleanup_sub_groups(void)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0size_t i;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D ARRAY_SIZE(leaf_cg); i &gt; 0; i--) =
{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!leaf_cg[i - 1]=
)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0continue;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0leaf_cg[i - 1] =3D =
tst_cg_group_rm(leaf_cg[i - 1]);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D ARRAY_SIZE(trunk_cg); i &gt; 0; i--)=
 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!trunk_cg[i - 1=
])<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0continue;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0trunk_cg[i - 1] =3D=
 tst_cg_group_rm(trunk_cg[i - 1]);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+}<br>
+<br>
+static void alloc_anon_in_child(const struct tst_cg_group *const cg,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const size_t size)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0const pid_t pid =3D SAFE_FORK();<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (pid) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tst_reap_children()=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0SAFE_CG_PRINTF(cg, &quot;cgroup.procs&quot;, &q=
uot;%d&quot;, getpid());<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0tst_res(TINFO, &quot;Child %d in %s: Allocating=
 anon: %&quot;PRIdPTR,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0getpid(), tst_cg_gr=
oup_name(cg), size);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0alloc_anon(size);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0exit(0);<br>
+}<br>
+<br>
+static void alloc_pagecache_in_child(const struct tst_cg_group *const cg,<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const size_t size)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0const pid_t pid =3D SAFE_FORK();<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (pid) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tst_reap_children()=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0SAFE_CG_PRINTF(cg, &quot;cgroup.procs&quot;, &q=
uot;%d&quot;, getpid());<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0tst_res(TINFO, &quot;Child %d in %s: Allocating=
 pagecache: %&quot;PRIdPTR,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0getpid(), tst_cg_gr=
oup_name(cg), size);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0alloc_pagecache(fd, size);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0exit(0);<br>
+}<br>
+<br>
+static void test_memcg_min(void)<br></blockquote><div><br></div><div><div =
class=3D"gmail_default" style=3D"font-size:small">test_memcg_low() ^</div><=
br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0long c[4];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int i;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fd =3D SAFE_OPEN(TMPDIR&quot;/tmpfile&quot;, O_=
RDWR | O_CREAT, 0600);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0trunk_cg[A] =3D tst_cg_group_mk(tst_cg, &quot;t=
runk_A&quot;);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0SAFE_CG_SCANF(trunk_cg[A], &quot;memory.low&quo=
t;, &quot;%ld&quot;, c);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (c[0]) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tst_brk(TCONF,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&quot;memory.low already set to %ld on parent group&quot;, c[0]);=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0SAFE_CG_PRINT(trunk_cg[A], &quot;cgroup.subtree=
_control&quot;, &quot;+memory&quot;);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0SAFE_CG_PRINT(trunk_cg[A], &quot;memory.max&quo=
t;, &quot;200M&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0SAFE_CG_PRINT(trunk_cg[A], &quot;memory.swap.ma=
x&quot;, &quot;0&quot;);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0trunk_cg[B] =3D tst_cg_group_mk(trunk_cg[A], &q=
uot;trunk_B&quot;);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0SAFE_CG_PRINT(trunk_cg[B], &quot;cgroup.subtree=
_control&quot;, &quot;+memory&quot;);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0trunk_cg[G] =3D tst_cg_group_mk(trunk_cg[A], &q=
uot;trunk_G&quot;);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; ARRAY_SIZE(leaf_cg); i++) =
{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0leaf_cg[i] =3D tst_=
cg_group_mk(trunk_cg[B],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 &quot;leaf_%c&quot;, &#39;C&#39; + i);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (i =3D=3D E)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0continue;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0alloc_pagecache_in_=
child(leaf_cg[i], MB(50));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0SAFE_CG_PRINT(trunk_cg[A], &quot;memory.low&quo=
t;, &quot;50M&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0SAFE_CG_PRINT(trunk_cg[B], &quot;memory.low&quo=
t;, &quot;50M&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0SAFE_CG_PRINT(leaf_cg[C], &quot;memory.low&quot=
;, &quot;75M&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0SAFE_CG_PRINT(leaf_cg[D], &quot;memory.low&quot=
;, &quot;25M&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0SAFE_CG_PRINT(leaf_cg[E], &quot;memory.low&quot=
;, &quot;500M&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0SAFE_CG_PRINT(leaf_cg[F], &quot;memory.low&quot=
;, &quot;0&quot;);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0alloc_anon_in_child(trunk_cg[G], MB(148));<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0SAFE_CG_SCANF(trunk_cg[B], &quot;memory.current=
&quot;, &quot;%ld&quot;, c);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0TST_EXP_EXPR(values_close(c[0], MB(50), 5),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quo=
t;(A/B memory.current=3D%ld) ~=3D %d&quot;, c[0], MB(50));<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; ARRAY_SIZE(leaf_cg); i++)<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SAFE_CG_SCANF(leaf_=
cg[i], &quot;memory.current&quot;, &quot;%ld&quot;, c + i);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0TST_EXP_EXPR(values_close(c[0], MB(33), 20),<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quo=
t;(A/B/C memory.current=3D%ld) ~=3D %d&quot;, c[0], MB(33));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0TST_EXP_EXPR(values_close(c[1], MB(17), 20),<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quo=
t;(A/B/D memory.current=3D%ld) ~=3D %d&quot;, c[1], MB(17));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0TST_EXP_EXPR(values_close(c[2], 0, 1),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quo=
t;(A/B/E memory.current=3D%ld) ~=3D 0&quot;, c[2]);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0alloc_anon_in_child(trunk_cg[G], MB(166));<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; ARRAY_SIZE(leaf_cg); i++) =
{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0long low, oom;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SAFE_CG_LINES_SCANF=
(leaf_cg[i], &quot;memory.events&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;low=
 %ld&quot;, &amp;low);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SAFE_CG_LINES_SCANF=
(leaf_cg[i], &quot;memory.events&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;oom=
 %ld&quot;, &amp;oom);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TST_EXP_EXPR(oom =
=3D=3D 0, &quot;(oom events=3D%ld) =3D=3D 0&quot;, oom);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (i &lt; E)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0TST_EXP_EXPR(low &gt; 0, &quot;(low events=3D%ld) &gt; 0&quot;, l=
ow)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0TST_EXP_EXPR(low =3D=3D 0, &quot;(low events=3D%ld) =3D=3D 0&quot=
;, low);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0cleanup_sub_groups();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0SAFE_CLOSE(fd);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0SAFE_UNLINK(TMPDIR&quot;/tmpfile&quot;);<br>
+}<br>
+<br>
+static void cleanup(void)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0cleanup_sub_groups();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (fd &gt; -1)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SAFE_CLOSE(fd);<br>
+}<br>
+<br>
+static struct tst_test test =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.cleanup =3D cleanup,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.test_all =3D test_memcg_min,<br></blockquote><=
div><br></div><div><div class=3D"gmail_default" style=3D"font-size:small">t=
est_memcg_low=C2=A0 ^</div><br></div><div>=C2=A0</div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.mount_device =3D 1,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.dev_min_size =3D 256,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.mntpoint =3D TMPDIR,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.all_filesystems =3D 1,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.skip_filesystems =3D (const char *const[]){<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;exfat&quot;, =
&quot;vfat&quot;, &quot;fuse&quot;, &quot;ntfs&quot;, &quot;tmpfs&quot;, NU=
LL<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.forks_child =3D 1,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.needs_root =3D 1,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.needs_checkpoints =3D 1,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.needs_cgroup_ver =3D TST_CG_V2,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.needs_cgroup_ctrls =3D (const char *const[]){ =
&quot;memory&quot;, NULL },<br>
+};<br></blockquote><div><br></div><div><br></div><div class=3D"gmail_defau=
lt" style=3D"font-size:small">Apart from the tiny issues and controversy on=
 renaming in patch2/3.=C2=A0</div><div class=3D"gmail_default" style=3D"fon=
t-size:small">The test itself looks good if we decide to go separate with m=
emcontrol03.c</div><div class=3D"gmail_default" style=3D"font-size:small"><=
br></div><div class=3D"gmail_default" style=3D"font-size:small">Btw, there =
are some TFAILs from my manual run.=C2=A0</div><div class=3D"gmail_default"=
 style=3D"font-size:small">(I will look into that try to figure it out tomo=
rrow)</div><div class=3D"gmail_default" style=3D"font-size:small"><br></div=
><div class=3D"gmail_default" style=3D"font-size:small">tst_test.c:1521: TI=
NFO: Testing on ext4<br>tst_test.c:996: TINFO: Formatting /dev/loop0 with e=
xt4 opts=3D&#39;&#39; extra opts=3D&#39;&#39;<br>mke2fs 1.46.5 (30-Dec-2021=
)<br>tst_test.c:1452: TINFO: Timeout per run is 0h 05m 00s<br>memcontrol04.=
c:118: TINFO: Child 242775 in leaf_C: Allocating pagecache: 52428800<br>mem=
control04.c:118: TINFO: Child 242776 in leaf_D: Allocating pagecache: 52428=
800<br>memcontrol04.c:118: TINFO: Child 242777 in leaf_F: Allocating pageca=
che: 52428800<br>memcontrol04.c:99: TINFO: Child 242778 in trunk_G: Allocat=
ing anon: 155189248<br>memcontrol04.c:170: TPASS: Expect: (A/B memory.curre=
nt=3D54181888) ~=3D 52428800<br>memcontrol04.c:176: TPASS: Expect: (A/B/C m=
emory.current=3D30957568) ~=3D 34603008<br>memcontrol04.c:178: TPASS: Expec=
t: (A/B/D memory.current=3D22282240) ~=3D 17825792<br>memcontrol04.c:180: T=
PASS: Expect: (A/B/E memory.current=3D0) ~=3D 0<br>memcontrol04.c:99: TINFO=
: Child 242779 in trunk_G: Allocating anon: 174063616<br>memcontrol04.c:193=
: TPASS: Expect: (oom events=3D0) =3D=3D 0<br>memcontrol04.c:196: TPASS: Ex=
pect: (low events=3D373) &gt; 0<br>memcontrol04.c:193: TPASS: Expect: (oom =
events=3D0) =3D=3D 0<br>memcontrol04.c:196: TPASS: Expect: (low events=3D37=
3) &gt; 0<br>memcontrol04.c:193: TPASS: Expect: (oom events=3D0) =3D=3D 0<b=
r>memcontrol04.c:198: TPASS: Expect: (low events=3D0) =3D=3D 0<br>memcontro=
l04.c:193: TPASS: Expect: (oom events=3D0) =3D=3D 0<br>memcontrol04.c:198: =
TFAIL: Expect: (low events=3D370) =3D=3D 0<br></div><div class=3D"gmail_def=
ault" style=3D"font-size:small"><br></div></div><div><br></div>-- <br><div =
dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></d=
iv><div>Li Wang<br></div></div></div></div>

--000000000000d1834605d793cf88--


--===============0484072924==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0484072924==--

