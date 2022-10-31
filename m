Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 021DFFA3740
	for <ltp@archiver.kernel.org>; Mon, 31 Oct 2022 07:35:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 235833CA9A2
	for <ltp@archiver.kernel.org>; Mon, 31 Oct 2022 08:35:12 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B35D53C08E6
 for <ltp@lists.linux.it>; Mon, 31 Oct 2022 08:34:59 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 3EF021A006F2
 for <ltp@lists.linux.it>; Mon, 31 Oct 2022 08:34:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1667201696;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=itcuSKht76ay4bZH+naeSFke/Meg8hgY9CYbisQyE/c=;
 b=DW7ggB2KZtSp9OidSB4EOFO9pe4R7Iq15/KX0epu36NjOUaNkUl/TTjtXKGKmBveEUrTKV
 dOr/4/N0xzamnBPCMBYzYTK2Ip7L+BbIVEqSBIlL7PSqTxvlPfU4MpbWDeAeN7o98aTcFG
 u/1MM+8MpWJoAFma9eVVG+qYqAgzhTE=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-158-HyzjYxwbMG2g635nPbFm7g-1; Mon, 31 Oct 2022 03:34:53 -0400
X-MC-Unique: HyzjYxwbMG2g635nPbFm7g-1
Received: by mail-ot1-f70.google.com with SMTP id
 43-20020a9d062e000000b00667d91e96b0so6056653otn.13
 for <ltp@lists.linux.it>; Mon, 31 Oct 2022 00:34:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=itcuSKht76ay4bZH+naeSFke/Meg8hgY9CYbisQyE/c=;
 b=bFd3MZNs6eA6j9BFuLIa591w3bhVawjXRDuUnFp04jrYDDZZir8FZxb2PasDONLny+
 HUyx3qahY3KCdAKQVO1dJ+uBZmZBSb2pPbLjck2D+4lpm1P200rrVdvJHrxgHDmjrfPG
 kGbdnK/MDTsRRfg7WOQWjGEh5Fus03pp3YFagPZZO5NzTcLteZPSvUup3R0xKmWRkP4w
 2xiZ0sUMYj1BJ9AaATSwMdMPpHucemISgAMfXjqQ5CSJmSys+ri3KWG7JDPurZVBuwZf
 8op0Ufkrie4UCLibzUNuNnJ4Z6i3n3misPAe+dw6pP/01R4YuQILqE46W6qZ0TeJHKmu
 BCQg==
X-Gm-Message-State: ACrzQf2NHKguZjXO35J0J1YJNcAgfNE7bI8e22hkBn54Ayk2twJimD5l
 RHjUnFh2bsp2Jl/3NSHy6Sja1R1rW3NHFvFTW6yvwq46ahMrSTsNSQVv+eAgjTLYqEnM6rR2ghE
 GgPYjLMlAgMcMK+dXZQKEbmo5P0c=
X-Received: by 2002:a05:6870:40cc:b0:13c:d606:27e8 with SMTP id
 l12-20020a05687040cc00b0013cd60627e8mr3753559oal.107.1667201692858; 
 Mon, 31 Oct 2022 00:34:52 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7rXlYw9qcmKtDZFsQ1LHF5zktBMsbXp9NoohpK5sLwDqQP1KWQpxHB/R14Je2sNgI/bwRsmdMWpo+Esob9yQM=
X-Received: by 2002:a05:6870:40cc:b0:13c:d606:27e8 with SMTP id
 l12-20020a05687040cc00b0013cd60627e8mr3753549oal.107.1667201692571; Mon, 31
 Oct 2022 00:34:52 -0700 (PDT)
MIME-Version: 1.0
References: <20221029071344.45447-1-tsahu@linux.ibm.com>
 <20221029071344.45447-4-tsahu@linux.ibm.com>
In-Reply-To: <20221029071344.45447-4-tsahu@linux.ibm.com>
From: Li Wang <liwang@redhat.com>
Date: Mon, 31 Oct 2022 15:34:39 +0800
Message-ID: <CAEemH2eorzpq=duqXbNLy3C0Ysxjo6fe5Ne7XqgArDQuKZHB6w@mail.gmail.com>
To: Tarun Sahu <tsahu@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 3/4] Hugetlb: Migrating libhugetlbfs
 chunk-overcommit
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
Cc: aneesh.kumar@linux.ibm.com, sbhat@linux.ibm.com, geetika@linux.ibm.com,
 ltp@lists.linux.it, vaibhav@linux.ibm.com
Content-Type: multipart/mixed; boundary="===============0608296219=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0608296219==
Content-Type: multipart/alternative; boundary="000000000000a7b61c05ec4fa4c2"

--000000000000a7b61c05ec4fa4c2
Content-Type: text/plain; charset="UTF-8"

On Sat, Oct 29, 2022 at 3:14 PM Tarun Sahu <tsahu@linux.ibm.com> wrote:

> Migrating the libhugetlbfs/testcases/chunk-overcommit.c test
>
> Test Description: Some kernel versions after hugepage demand allocation was
> added used a dubious heuristic to check if there was enough hugepage space
> available for a given mapping.  The number of not-already-instantiated
> pages in the mapping was compared against the total hugepage free pool. It
> was very easy to confuse this heuristic into overcommitting by allocating
> hugepage memory in chunks, each less than the total available pool size but
> together more than available.  This would generally lead to OOM SIGKILLs of
> one process or another when it tried to instantiate pages beyond the
> available pool.
>
> Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
> ---
>  runtest/hugetlb                               |   1 +
>  testcases/kernel/mem/.gitignore               |   1 +
>  .../kernel/mem/hugetlb/hugemmap/hugemmap08.c  | 144 ++++++++++++++++++
>  3 files changed, 146 insertions(+)
>  create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap08.c
>
> diff --git a/runtest/hugetlb b/runtest/hugetlb
> index f7ff81cb3..664f18827 100644
> --- a/runtest/hugetlb
> +++ b/runtest/hugetlb
> @@ -4,6 +4,7 @@ hugemmap04 hugemmap04
>  hugemmap05 hugemmap05
>  hugemmap06 hugemmap06
>  hugemmap07 hugemmap07
> +hugemmap08 hugemmap08
>  hugemmap05_1 hugemmap05 -m
>  hugemmap05_2 hugemmap05 -s
>  hugemmap05_3 hugemmap05 -s -m
> diff --git a/testcases/kernel/mem/.gitignore
> b/testcases/kernel/mem/.gitignore
> index df5256ec8..003ce422b 100644
> --- a/testcases/kernel/mem/.gitignore
> +++ b/testcases/kernel/mem/.gitignore
> @@ -5,6 +5,7 @@
>  /hugetlb/hugemmap/hugemmap05
>  /hugetlb/hugemmap/hugemmap06
>  /hugetlb/hugemmap/hugemmap07
> +/hugetlb/hugemmap/hugemmap08
>  /hugetlb/hugeshmat/hugeshmat01
>  /hugetlb/hugeshmat/hugeshmat02
>  /hugetlb/hugeshmat/hugeshmat03
> diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap08.c
> b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap08.c
> new file mode 100644
> index 000000000..61db030d5
> --- /dev/null
> +++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap08.c
> @@ -0,0 +1,144 @@
> +// SPDX-License-Identifier: LGPL-2.1-or-later
> +/*
> + * Copyright (C) 2005-2006 David Gibson & Adam Litke, IBM Corporation.
> + * Author: David Gibson & Adam Litke
> + */
> +
> +/*\
> + * [Description]
> + *
> + * Chunk Overcommit:
> + * Some kernel versions after hugepage demand allocation was added used a
> + * dubious heuristic to check if there was enough hugepage space available
> + * for a given mapping.  The number of not-already-instantiated pages in
> + * the mapping was compared against the total hugepage free pool. It was
> + * very easy to confuse this heuristic into overcommitting by allocating
> + * hugepage memory in chunks, each less than the total available pool size
> + * but together more than available.  This would generally lead to OOM
> + * SIGKILLs of one process or another when it tried to instantiate pages
> + * beyond the available pool.
> + *
> + * HISTORY
> + *
> + */
> +
> +#define _GNU_SOURCE
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <sys/mount.h>
> +#include <limits.h>
> +#include <sys/param.h>
> +#include <sys/types.h>
> +#include <sys/wait.h>
> +#include <signal.h>
> +
> +#include "hugetlb.h"
> +
> +#define PROC_OVERCOMMIT "/proc/sys/vm/nr_overcommit_hugepages"
> +#define WITH_OVERCOMMIT 0
> +#define WITHOUT_OVERCOMMIT 1
> +
> +static long hpage_size;
> +
> +static void test_chunk_overcommit(void)
> +{
> +       unsigned long totpages, chunk1, chunk2;
> +       void *p, *q;
> +       pid_t child;
> +       int status;
> +
> +       totpages = SAFE_READ_MEMINFO("HugePages_Free:");
> +
> +       chunk1 = (totpages / 2) + 1;
> +       chunk2 = totpages - chunk1 + 1;
> +
> +       tst_res(TINFO, "Free: %ld hugepages available: "
> +              "chunk1=%ld chunk2=%ld", totpages, chunk1, chunk2);
> +
> +       p = SAFE_MMAP(NULL, chunk1*hpage_size, PROT_READ|PROT_WRITE,
> MAP_SHARED,
> +                tst_hugetlb_fd, 0);
> +
> +       q = mmap(NULL, chunk2*hpage_size, PROT_READ|PROT_WRITE, MAP_SHARED,
> +                tst_hugetlb_fd, chunk1*hpage_size);
> +       if (q == MAP_FAILED) {
> +               if (errno != ENOMEM) {
> +                       tst_res(TFAIL | TERRNO, "mmap() chunk2");
> +                       goto cleanup1;
> +               } else {
> +                       tst_res(TPASS, "Successful without overcommit
> pages");
> +                       goto cleanup1;
> +               }
> +       }
> +
> +       tst_res(TINFO, "Looks like we've overcommitted, testing...");
> +       /* Looks like we're overcommited, but we need to confirm that
> +        * this is bad.  We touch it all in a child process because an
> +        * overcommit will generally lead to a SIGKILL which we can't
> +        * handle, of course.
> +        */
> +       child = SAFE_FORK();
> +
> +       if (child == 0) {
> +               memset(p, 0, chunk1*hpage_size);
> +               memset(q, 0, chunk2*hpage_size);
> +               exit(0);
> +       }
> +
> +       SAFE_WAITPID(child, &status, 0);
> +
> +       if (WIFSIGNALED(status)) {
> +               tst_res(TFAIL, "Killed by signal '%s' due to overcommit",
> +                    tst_strsig(WTERMSIG(status)));
> +               goto cleanup2;
> +       }
> +
> +       tst_res(TPASS, "Successful with overcommit pages");
> +
> +cleanup2:
> +       SAFE_MUNMAP(q, chunk2*hpage_size);
> +
> +cleanup1:
> +       SAFE_MUNMAP(p, chunk1*hpage_size);
> +       SAFE_FTRUNCATE(tst_hugetlb_fd, 0);
> +}
> +
> +static void run_test(unsigned int test_type)
> +{
> +       unsigned long saved_oc_hugepages;
> +
> +       SAFE_FILE_SCANF(PROC_OVERCOMMIT, "%ld", &saved_oc_hugepages);
>

There is unnecessary to read PROC_OVERCOMMIT value again,
we already save/restore it in struct tst_path_val[], so here we
can set it directly to what we expected no matter if the original is 0 or 2.

static void run_test(unsigned int test_type)
{
        switch (test_type) {
        case WITHOUT_OVERCOMMIT:
                tst_res(TINFO, "Without overcommit testing...");
                SAFE_FILE_PRINTF(PROC_OVERCOMMIT, "%d", 0);
                break;
        case WITH_OVERCOMMIT:
                tst_res(TINFO, "With overcommit testing...");
                SAFE_FILE_PRINTF(PROC_OVERCOMMIT, "%d", 2);
                break;
    }
    test_chunk_overcommit();
}



> +       switch (test_type) {
> +       case WITHOUT_OVERCOMMIT:
> +               tst_res(TINFO, "Without overcommit testing...");
> +               if (saved_oc_hugepages > 0)
> +                       SAFE_FILE_PRINTF(PROC_OVERCOMMIT, "%d", 0);
> +               break;
> +       case WITH_OVERCOMMIT:
> +               tst_res(TINFO, "With overcommit testing...");
> +               if (saved_oc_hugepages == 0)
> +                       SAFE_FILE_PRINTF(PROC_OVERCOMMIT, "%d", 2);
> +               break;
> +       }
> +       test_chunk_overcommit();
> +}
> +
> +static void setup(void)
> +{
> +       hpage_size = SAFE_READ_MEMINFO("Hugepagesize:")*1024;
> +}
> +
> +static struct tst_test test = {
> +       .needs_root = 1,
> +       .needs_hugetlbfs = 1,
> +       .needs_unlinked_hugetlb_file = 1,
> +       .forks_child = 1,
> +       .save_restore = (const struct tst_path_val[]) {
> +               {PROC_OVERCOMMIT, NULL},
> +               {}
> +       },
> +       .tcnt = 2,
> +       .setup = setup,
> +       .test = run_test,
> +       .hugepages = {3, TST_NEEDS},
> +};
> +
> --
> 2.31.1
>
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
>
>

-- 
Regards,
Li Wang

--000000000000a7b61c05ec4fa4c2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Sat, Oct 29, 2022 at 3:14 PM Tarun Sahu &lt;<a h=
ref=3D"mailto:tsahu@linux.ibm.com">tsahu@linux.ibm.com</a>&gt; wrote:<br></=
div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex">Migrating the libhuge=
tlbfs/testcases/chunk-overcommit.c test<br>
<br>
Test Description: Some kernel versions after hugepage demand allocation was=
<br>
added used a dubious heuristic to check if there was enough hugepage space<=
br>
available for a given mapping.=C2=A0 The number of not-already-instantiated=
<br>
pages in the mapping was compared against the total hugepage free pool. It<=
br>
was very easy to confuse this heuristic into overcommitting by allocating<b=
r>
hugepage memory in chunks, each less than the total available pool size but=
<br>
together more than available.=C2=A0 This would generally lead to OOM SIGKIL=
Ls of<br>
one process or another when it tried to instantiate pages beyond the<br>
available pool.<br>
<br>
Signed-off-by: Tarun Sahu &lt;<a href=3D"mailto:tsahu@linux.ibm.com" target=
=3D"_blank">tsahu@linux.ibm.com</a>&gt;<br>
---<br>
=C2=A0runtest/hugetlb=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A01 =
+<br>
=C2=A0testcases/kernel/mem/.gitignore=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
=C2=A0.../kernel/mem/hugetlb/hugemmap/hugemmap08.c=C2=A0 | 144 ++++++++++++=
++++++<br>
=C2=A03 files changed, 146 insertions(+)<br>
=C2=A0create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap08.c=
<br>
<br>
diff --git a/runtest/hugetlb b/runtest/hugetlb<br>
index f7ff81cb3..664f18827 100644<br>
--- a/runtest/hugetlb<br>
+++ b/runtest/hugetlb<br>
@@ -4,6 +4,7 @@ hugemmap04 hugemmap04<br>
=C2=A0hugemmap05 hugemmap05<br>
=C2=A0hugemmap06 hugemmap06<br>
=C2=A0hugemmap07 hugemmap07<br>
+hugemmap08 hugemmap08<br>
=C2=A0hugemmap05_1 hugemmap05 -m<br>
=C2=A0hugemmap05_2 hugemmap05 -s<br>
=C2=A0hugemmap05_3 hugemmap05 -s -m<br>
diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitign=
ore<br>
index df5256ec8..003ce422b 100644<br>
--- a/testcases/kernel/mem/.gitignore<br>
+++ b/testcases/kernel/mem/.gitignore<br>
@@ -5,6 +5,7 @@<br>
=C2=A0/hugetlb/hugemmap/hugemmap05<br>
=C2=A0/hugetlb/hugemmap/hugemmap06<br>
=C2=A0/hugetlb/hugemmap/hugemmap07<br>
+/hugetlb/hugemmap/hugemmap08<br>
=C2=A0/hugetlb/hugeshmat/hugeshmat01<br>
=C2=A0/hugetlb/hugeshmat/hugeshmat02<br>
=C2=A0/hugetlb/hugeshmat/hugeshmat03<br>
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap08.c b/testcases=
/kernel/mem/hugetlb/hugemmap/hugemmap08.c<br>
new file mode 100644<br>
index 000000000..61db030d5<br>
--- /dev/null<br>
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap08.c<br>
@@ -0,0 +1,144 @@<br>
+// SPDX-License-Identifier: LGPL-2.1-or-later<br>
+/*<br>
+ * Copyright (C) 2005-2006 David Gibson &amp; Adam Litke, IBM Corporation.=
<br>
+ * Author: David Gibson &amp; Adam Litke<br>
+ */<br>
+<br>
+/*\<br>
+ * [Description]<br>
+ *<br>
+ * Chunk Overcommit:<br>
+ * Some kernel versions after hugepage demand allocation was added used a<=
br>
+ * dubious heuristic to check if there was enough hugepage space available=
<br>
+ * for a given mapping.=C2=A0 The number of not-already-instantiated pages=
 in<br>
+ * the mapping was compared against the total hugepage free pool. It was<b=
r>
+ * very easy to confuse this heuristic into overcommitting by allocating<b=
r>
+ * hugepage memory in chunks, each less than the total available pool size=
<br>
+ * but together more than available.=C2=A0 This would generally lead to OO=
M<br>
+ * SIGKILLs of one process or another when it tried to instantiate pages<b=
r>
+ * beyond the available pool.<br>
+ *<br>
+ * HISTORY<br>
+ *<br>
+ */<br>
+<br>
+#define _GNU_SOURCE<br>
+#include &lt;stdio.h&gt;<br>
+#include &lt;stdlib.h&gt;<br>
+#include &lt;sys/mount.h&gt;<br>
+#include &lt;limits.h&gt;<br>
+#include &lt;sys/param.h&gt;<br>
+#include &lt;sys/types.h&gt;<br>
+#include &lt;sys/wait.h&gt;<br>
+#include &lt;signal.h&gt;<br>
+<br>
+#include &quot;hugetlb.h&quot;<br>
+<br>
+#define PROC_OVERCOMMIT &quot;/proc/sys/vm/nr_overcommit_hugepages&quot;<b=
r>
+#define WITH_OVERCOMMIT 0<br>
+#define WITHOUT_OVERCOMMIT 1<br>
+<br>
+static long hpage_size;<br>
+<br>
+static void test_chunk_overcommit(void)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long totpages, chunk1, chunk2;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0void *p, *q;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0pid_t child;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int status;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0totpages =3D SAFE_READ_MEMINFO(&quot;HugePages_=
Free:&quot;);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0chunk1 =3D (totpages / 2) + 1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0chunk2 =3D totpages - chunk1 + 1;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0tst_res(TINFO, &quot;Free: %ld hugepages availa=
ble: &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;chunk1=3D%ld chunk2=
=3D%ld&quot;, totpages, chunk1, chunk2);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0p =3D SAFE_MMAP(NULL, chunk1*hpage_size, PROT_R=
EAD|PROT_WRITE, MAP_SHARED,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tst_hugetlb_fd, 0)=
;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0q =3D mmap(NULL, chunk2*hpage_size, PROT_READ|P=
ROT_WRITE, MAP_SHARED,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tst_hugetlb_fd, ch=
unk1*hpage_size);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (q =3D=3D MAP_FAILED) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (errno !=3D ENOM=
EM) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0tst_res(TFAIL | TERRNO, &quot;mmap() chunk2&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0goto cleanup1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0tst_res(TPASS, &quot;Successful without overcommit pages&quot;);<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0goto cleanup1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0tst_res(TINFO, &quot;Looks like we&#39;ve overc=
ommitted, testing...&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Looks like we&#39;re overcommited, but we ne=
ed to confirm that<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * this is bad.=C2=A0 We touch it all in a chil=
d process because an<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * overcommit will generally lead to a SIGKILL =
which we can&#39;t<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * handle, of course.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0child =3D SAFE_FORK();<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (child =3D=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memset(p, 0, chunk1=
*hpage_size);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memset(q, 0, chunk2=
*hpage_size);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exit(0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0SAFE_WAITPID(child, &amp;status, 0);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (WIFSIGNALED(status)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tst_res(TFAIL, &quo=
t;Killed by signal &#39;%s&#39; due to overcommit&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tst_=
strsig(WTERMSIG(status)));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto cleanup2;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0tst_res(TPASS, &quot;Successful with overcommit=
 pages&quot;);<br>
+<br>
+cleanup2:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0SAFE_MUNMAP(q, chunk2*hpage_size);<br>
+<br>
+cleanup1:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0SAFE_MUNMAP(p, chunk1*hpage_size);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0SAFE_FTRUNCATE(tst_hugetlb_fd, 0);<br>
+}<br>
+<br>
+static void run_test(unsigned int test_type)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long saved_oc_hugepages;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0SAFE_FILE_SCANF(PROC_OVERCOMMIT, &quot;%ld&quot=
;, &amp;saved_oc_hugepages);<br></blockquote><div><br></div><div><div class=
=3D"gmail_default" style=3D"font-size:small">There is unnecessary to read P=
ROC_OVERCOMMIT value again,</div><div class=3D"gmail_default" style=3D"font=
-size:small">we already save/restore it in struct tst_path_val[], so here w=
e</div><div class=3D"gmail_default" style=3D"font-size:small">can set it di=
rectly to what we expected no matter if the original is 0 or 2.</div><div c=
lass=3D"gmail_default" style=3D"font-size:small"><br></div><div class=3D"gm=
ail_default" style=3D"font-size:small">static void run_test(unsigned int te=
st_type)<br>{<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 switch (test_type) {<br>=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 case WITHOUT_OVERCOMMIT:<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tst_res(TINFO, &quot;Without overcommit tes=
ting...&quot;);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
SAFE_FILE_PRINTF(PROC_OVERCOMMIT, &quot;%d&quot;, 0);<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 case WITH_OVERCOMMIT:<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 tst_res(TINFO, &quot;With overcommit testing...&quot;);<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SAFE_FILE_PRINTF(PROC_=
OVERCOMMIT, &quot;%d&quot;, 2);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 break;<br>=C2=A0 =C2=A0 }<br>=C2=A0 =C2=A0 test_chunk_ove=
rcommit();<br>}<br></div><br></div><div>=C2=A0</div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0switch (test_type) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0case WITHOUT_OVERCOMMIT:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tst_res(TINFO, &quo=
t;Without overcommit testing...&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (saved_oc_hugepa=
ges &gt; 0)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0SAFE_FILE_PRINTF(PROC_OVERCOMMIT, &quot;%d&quot;, 0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0case WITH_OVERCOMMIT:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tst_res(TINFO, &quo=
t;With overcommit testing...&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (saved_oc_hugepa=
ges =3D=3D 0)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0SAFE_FILE_PRINTF(PROC_OVERCOMMIT, &quot;%d&quot;, 2);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0test_chunk_overcommit();<br>
+}<br>
+<br>
+static void setup(void)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0hpage_size =3D SAFE_READ_MEMINFO(&quot;Hugepage=
size:&quot;)*1024;<br>
+}<br>
+<br>
+static struct tst_test test =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.needs_root =3D 1,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.needs_hugetlbfs =3D 1,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.needs_unlinked_hugetlb_file =3D 1,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.forks_child =3D 1,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.save_restore =3D (const struct tst_path_val[])=
 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{PROC_OVERCOMMIT, N=
ULL},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.tcnt =3D 2,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.setup =3D setup,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.test =3D run_test,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.hugepages =3D {3, TST_NEEDS},<br>
+};<br>
+<br>
-- <br>
2.31.1<br>
<br>
<br>
-- <br>
Mailing list info: <a href=3D"https://lists.linux.it/listinfo/ltp" rel=3D"n=
oreferrer" target=3D"_blank">https://lists.linux.it/listinfo/ltp</a><br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div><div>Li =
Wang<br></div></div></div></div>

--000000000000a7b61c05ec4fa4c2--


--===============0608296219==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0608296219==--

