Return-Path: <SRS0=ZNpR=QE=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB067C433EF
	for <ltp@archiver.kernel.org>; Wed, 17 Nov 2021 21:23:33 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79D29615E6
	for <ltp@archiver.kernel.org>; Wed, 17 Nov 2021 21:23:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 79D29615E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 45C833C8849
	for <ltp@archiver.kernel.org>; Wed, 17 Nov 2021 22:23:30 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 16E593C8821
 for <ltp@lists.linux.it>; Wed, 17 Nov 2021 22:23:17 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 2FFB3200C28
 for <ltp@lists.linux.it>; Wed, 17 Nov 2021 22:23:15 +0100 (CET)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E41813F177
 for <ltp@lists.linux.it>; Wed, 17 Nov 2021 21:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1637184192;
 bh=hkP7XrrTOpPJrHU+KmNy1tHdQgw7PVvJubIEVUvBjGU=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=g1JOkKtwAhd84dY3L0fNz0oR0y+5tMEVwMio1nSGiwgD0WTfGRLSLMin4DIvSqBys
 GpYx5DcrfpPmNqYxGbKRt4O/F7ncZxwZ+JqEg+IlzgyJbn3qfp0y2wZiVm8B2oSJLf
 BfFOe616zw+AlfDSJYRYG+mlQM4dvQ5s8wws9ibu3iE/W4F/sAEvZ0E5SRp47LsjHM
 uxHP+9TN2LgHeO4MnhSkSnSLP5y65pCtkIreY/nKCLyqIBaG3tyUvjD7kpLz5+4dNU
 Et3N6scRphOkLGy5OBvgCn/ZeaYYvCrgcW6UwL/NfWysomIbGDCE3KXiuSviehUsfa
 uooGSm+6PAFPg==
Received: by mail-ed1-f70.google.com with SMTP id
 r16-20020a056402019000b003e6cbb77ed2so3324957edv.10
 for <ltp@lists.linux.it>; Wed, 17 Nov 2021 13:23:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hkP7XrrTOpPJrHU+KmNy1tHdQgw7PVvJubIEVUvBjGU=;
 b=RVqlbX9KBVrHytoqh5YtHaE/N1bzDNvIaV+Vy2z0HIjbEnDkBilMUQ4V5iSPX4Rj7r
 mpY1dvXPa0ZNN0MDRp53robs01oPiOfWNvMHYIw55iPSgsvvqH+E6gXdfmSB5QogxbFs
 Mbx3iqnXzXQUL5Whuejj59xRdRNkB+UD+rZziAIx/1O+ncgzYadmVa6W9yWCmfx+K6c0
 m5mwchWeIGHtFlmlpKoHPrv26joAxbXVeu3zDapqCM4TUcotFbzYZ81chhU5up28YixO
 fZlrDscEC2QdmQQ0zrG8nEzJxCCHOBUeLHG5A9QiqQK4PGPaD0Tyxfd3FewHJyxV4H0I
 nlJQ==
X-Gm-Message-State: AOAM533CK1Y7WXsPbVter6oM8/PTy8ARgqBqcclpxJbV6TlqhNk83Pcq
 xfC7Rk9RWFWiBhRUAhw2M7f2N5lrLtbWMZqko0ln9CMeUPaqGI6tBd7BPXm+/OTLaPRQAIqE77l
 qoPpRcgnCYUxk0UHsjTf+7VrNFeK3rLwm2OxlDUD0Ktfi
X-Received: by 2002:a17:907:1689:: with SMTP id
 hc9mr25500741ejc.445.1637184192390; 
 Wed, 17 Nov 2021 13:23:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzTYG2n5YFwrSZhyKCniEshuqMwZ8R255AsC0qwcpKoDvZyKv4vUWnrHSS+w9IYg6aBWHImST4xYPQXvl3REsA=
X-Received: by 2002:a17:907:1689:: with SMTP id
 hc9mr25500708ejc.445.1637184192157; 
 Wed, 17 Nov 2021 13:23:12 -0800 (PST)
MIME-Version: 1.0
References: <20211115182613.38151-1-luke.nowakowskikrijger@canonical.com>
 <87h7ccbeds.fsf@suse.de>
In-Reply-To: <87h7ccbeds.fsf@suse.de>
From: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
Date: Wed, 17 Nov 2021 13:23:01 -0800
Message-ID: <CADS1e3fDnHM=QXVE8HC5Vnu=ip3GYrctEkUykvrW+Y5ExqSpKQ@mail.gmail.com>
To: rpalethorpe@suse.de
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] controllers/memcg: update regression tests to
 work under cgroup2
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
Cc: ltp@lists.linux.it
Content-Type: multipart/mixed; boundary="===============1636391508=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1636391508==
Content-Type: multipart/alternative; boundary="00000000000034c0c605d102a600"

--00000000000034c0c605d102a600
Content-Type: text/plain; charset="UTF-8"

Hi Richard,

I see what you mean, it would not work if both hierarchies exist. I will do
something similar to the patch you linked as that has cleared up a lot of
my misunderstandings about it. While I am there I will update the tests to
use the newer test APIs.

Thanks for the review.

- Luke

On Tue, Nov 16, 2021 at 2:09 AM Richard Palethorpe <rpalethorpe@suse.de>
wrote:

> Hello Luke,
>
> Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com> writes:
>
> > Some tests no longer make sense under cgroup2, while other tests just
> > needed to be updated to use new parameters introduced by the cgroup2
> > interface.
> >
> > Signed-off-by: Luke Nowakowski-Krijger <
> luke.nowakowskikrijger@canonical.com>
> > ---
> >  .../memcg/regression/memcg_regression_test.sh | 41 ++++++++++++++++---
> >  .../memcg/regression/memcg_test_1.c           | 12 +++++-
> >  .../memcg/regression/memcg_test_3.c           |  8 ++++
> >  .../memcg/regression/memcg_test_4.sh          | 18 ++++++--
> >  4 files changed, 68 insertions(+), 11 deletions(-)
> >
> > diff --git
> a/testcases/kernel/controllers/memcg/regression/memcg_regression_test.sh
> b/testcases/kernel/controllers/memcg/regression/memcg_regression_test.sh
> > index c91a4069e..ad88d49d1 100755
> > ---
> a/testcases/kernel/controllers/memcg/regression/memcg_regression_test.sh
> > +++
> b/testcases/kernel/controllers/memcg/regression/memcg_regression_test.sh
> > @@ -103,7 +103,12 @@ check_kernel_bug()
> >  test_1()
> >  {
> >       mkdir memcg/0/
> > -     echo 0 > memcg/0/memory.limit_in_bytes
> > +
> > +     if [ "$cgroup_ver" = "cgroup2" ]; then
> > +             echo 0 > memcg/0/memory.max
> > +     else
> > +             echo 0 > memcg/0/memory.limit_in_bytes
> > +     fi
> >
> >       ./memcg_test_1
> >
> > @@ -124,6 +129,16 @@ test_1()
> >
> #---------------------------------------------------------------------------
> >  test_2()
> >  {
> > +     # for cgroup2 the default behaivor is to check the new memory
> limit and
> > +     # then to start killing processes if oom. This test then doesen't
> > +     # make sense as we don't expect EBUSY to be returned. The shrink
> > +     # operation (write to memory.max in cgroup2) would kill the pid1
> process
> > +     # and exit.
> > +     if [ "$cgroup_ver" = "cgroup2" ]; then
> > +             tst_resm TCONF "cgroup2 found, skipping test"
> > +             return
> > +     fi
> > +
> >       ./memcg_test_2 &
> >       pid1=$!
> >       sleep 1
> > @@ -177,12 +192,20 @@ test_2()
> >  test_3()
> >  {
> >       mkdir memcg/0
> > -     for pid in `cat memcg/tasks`; do
> > -             echo $pid > memcg/0/tasks 2> /dev/null
> > +     if [ "$cgroup_ver" = "cgroup2" ]; then
> > +             memcg_procs=memcg/cgroup.procs
> > +             memcg_subprocs=memcg/0/cgroup.procs
> > +     else
> > +             memcg_procs=memcg/tasks
> > +             memcg_subprocs=memcg/0/tasks
> > +     fi
> > +
> > +     for pid in `cat $memcg_procs`; do
> > +             echo $pid > $memcg_subprocs 2> /dev/null
> >       done
> >
> > -     for pid in `cat memcg/0/tasks`; do
> > -             echo $pid > memcg/tasks 2> /dev/null
> > +     for pid in `cat $memcg_subprocs`; do
> > +             echo $pid > $memcg_procs 2> /dev/null
> >       done
> >       rmdir memcg/0
> >
> > @@ -218,13 +241,19 @@ test_4()
> >  }
> >
> >  # main
> > +cgroup_ver=$(grep "/sys/fs/cgroup" /proc/mounts | cut -d' ' -f1)
> >  failed=0
> >  mkdir memcg/
> >
> >  for cur in $(seq 1 $TST_TOTAL); do
> >       export TST_COUNT=$cur
> >
> > -     mount -t cgroup -o memory xxx memcg/
> > +     if [ "$cgroup_ver" = "cgroup2" ]; then
> > +             mount -t cgroup2 xxx memcg/
> > +     else
> > +             mount -t cgroup -o memory xxx memcg/
> > +     fi
> > +
> >       if [ $? -ne 0 ]; then
> >               tst_resm TFAIL "failed to mount memory subsystem"
> >               failed=1
> > diff --git
> a/testcases/kernel/controllers/memcg/regression/memcg_test_1.c
> b/testcases/kernel/controllers/memcg/regression/memcg_test_1.c
> > index c7fb948fe..b9277e633 100644
> > --- a/testcases/kernel/controllers/memcg/regression/memcg_test_1.c
> > +++ b/testcases/kernel/controllers/memcg/regression/memcg_test_1.c
> > @@ -33,6 +33,16 @@
> >
> >  #define FORKED_PROC_COUNT    10
> >
> > +static int open_cgroup_procs(void)
> > +{
> > +     int fd = open("memcg/0/tasks", O_WRONLY);
> > +     if (fd >= 0)
> > +             return fd;
> > +
> > +     fd = open("memcg/0/cgroup.procs", O_WRONLY);
> > +     return fd;
> > +}
> > +
> >  int main(void)
> >  {
> >       char buf[10];
> > @@ -40,7 +50,7 @@ int main(void)
> >       int loop;
> >       int pid;
> >       int size = getpagesize();
> > -     int fd = open("memcg/0/tasks", O_WRONLY);
> > +     int fd = open_cgroup_procs();
> >
> >       if (fd < 0)
> >               return 1;
> > diff --git
> a/testcases/kernel/controllers/memcg/regression/memcg_test_3.c
> b/testcases/kernel/controllers/memcg/regression/memcg_test_3.c
> > index 75a6e1545..d5531fe87 100644
> > --- a/testcases/kernel/controllers/memcg/regression/memcg_test_3.c
> > +++ b/testcases/kernel/controllers/memcg/regression/memcg_test_3.c
> > @@ -66,6 +66,14 @@ static void setup(void)
> >       SAFE_MKDIR(MNTPOINT, 0644);
> >
> >       ret = mount("memcg", MNTPOINT, "cgroup", 0, "memory");
> > +
> > +     if (!ret) {
> > +             mount_flag = 1;
> > +             return;
> > +     }
> > +
> > +     ret = mount("memcg", MNTPOINT, "cgroup2", 0, NULL);
> > +
> >       if (ret) {
> >               if (errno == ENOENT)
> >                       tst_brk(TCONF | TERRNO, "memcg not supported");
> > diff --git
> a/testcases/kernel/controllers/memcg/regression/memcg_test_4.sh
> b/testcases/kernel/controllers/memcg/regression/memcg_test_4.sh
> > index 620031366..287864b81 100755
> > --- a/testcases/kernel/controllers/memcg/regression/memcg_test_4.sh
> > +++ b/testcases/kernel/controllers/memcg/regression/memcg_test_4.sh
> > @@ -22,9 +22,19 @@
> >  ##
>       ##
> >
> ################################################################################
> >
> > +cgroup_ver=$(grep "/sys/fs/cgroup" /proc/mounts | cut -d' ' -f1)
>
> Unfortunately this doesn't work when both V1 and V2 hierarchies are
> mounted. You need to check that the memory controller is enabled on
> V2. Also it's possible to mount CGroups at alternate locations.
>
> Please see the recent patch from Masayoshi:
>
> https://patchwork.ozlabs.org/project/ltp/patch/20211113041706.12893-1-msys.mizuma@gmail.com/
>
> > +
> > +if [ "$cgroup_ver" = 'cgroup2' ]; then
> > +     cgroup_proc=cgroup.procs
> > +     cgroup_mem_limit=memory.max
> > +else
> > +     cgroup_proc=tasks
> > +     cgroup_mem_limit=memory.limit_in_bytes
> > +fi
> > +
> >  # attach current task to memcg/0/
> >  mkdir memcg/0
> > -echo $$ > memcg/0/tasks
> > +echo $$ > memcg/0/${cgroup_proc}
> >
> >  ./memcg_test_4 &
> >  pid=$!
> > @@ -35,13 +45,13 @@ sleep 1
> >  sleep 1
> >
> >  # shrink memory, and then 80M will be swapped
> > -echo 40M > memcg/0/memory.limit_in_bytes
> > +echo 40M > memcg/0/${cgroup_mem_limit}
> >
> >  # turn off swap, and swapoff will be killed
> >  swapoff -a
> >  sleep 1
> > -echo $pid > memcg/tasks 2> /dev/null
> > -echo $$ > memcg/tasks 2> /dev/null
> > +echo $pid > memcg/${cgroup_proc} 2> /dev/null
> > +echo $$ > memcg/${cgroup_proc} 2> /dev/null
> >
> >  # now remove the cgroup
> >  rmdir memcg/0
> > --
> > 2.32.0
>
>
> --
> Thank you,
> Richard.
>

--00000000000034c0c605d102a600
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Richard, <br></div><div><br></div><div>I see what =
you mean, it would not work if both hierarchies exist. I will do something =
similar to the patch you linked as that has cleared up a lot of my misunder=
standings about it. While I am there I will update the tests to use the new=
er test APIs.=C2=A0</div><div><br></div><div>Thanks for the review.</div><d=
iv><br></div><div>- Luke<br></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Tue, Nov 16, 2021 at 2:09 AM Richard Palet=
horpe &lt;<a href=3D"mailto:rpalethorpe@suse.de">rpalethorpe@suse.de</a>&gt=
; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hello L=
uke,<br>
<br>
Luke Nowakowski-Krijger &lt;<a href=3D"mailto:luke.nowakowskikrijger@canoni=
cal.com" target=3D"_blank">luke.nowakowskikrijger@canonical.com</a>&gt; wri=
tes:<br>
<br>
&gt; Some tests no longer make sense under cgroup2, while other tests just<=
br>
&gt; needed to be updated to use new parameters introduced by the cgroup2<b=
r>
&gt; interface.<br>
&gt;<br>
&gt; Signed-off-by: Luke Nowakowski-Krijger &lt;<a href=3D"mailto:luke.nowa=
kowskikrijger@canonical.com" target=3D"_blank">luke.nowakowskikrijger@canon=
ical.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 .../memcg/regression/memcg_regression_test.sh | 41 +++++++++++++=
+++---<br>
&gt;=C2=A0 .../memcg/regression/memcg_test_1.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0| 12 +++++-<br>
&gt;=C2=A0 .../memcg/regression/memcg_test_3.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 8 ++++<br>
&gt;=C2=A0 .../memcg/regression/memcg_test_4.sh=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 | 18 ++++++--<br>
&gt;=C2=A0 4 files changed, 68 insertions(+), 11 deletions(-)<br>
&gt;<br>
&gt; diff --git a/testcases/kernel/controllers/memcg/regression/memcg_regre=
ssion_test.sh b/testcases/kernel/controllers/memcg/regression/memcg_regress=
ion_test.sh<br>
&gt; index c91a4069e..ad88d49d1 100755<br>
&gt; --- a/testcases/kernel/controllers/memcg/regression/memcg_regression_t=
est.sh<br>
&gt; +++ b/testcases/kernel/controllers/memcg/regression/memcg_regression_t=
est.sh<br>
&gt; @@ -103,7 +103,12 @@ check_kernel_bug()<br>
&gt;=C2=A0 test_1()<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0mkdir memcg/0/<br>
&gt; -=C2=A0 =C2=A0 =C2=A0echo 0 &gt; memcg/0/memory.limit_in_bytes<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if [ &quot;$cgroup_ver&quot; =3D &quot;cgroup2&qu=
ot; ]; then<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0echo 0 &gt; memcg/0/m=
emory.max<br>
&gt; +=C2=A0 =C2=A0 =C2=A0else<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0echo 0 &gt; memcg/0/m=
emory.limit_in_bytes<br>
&gt; +=C2=A0 =C2=A0 =C2=A0fi<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0./memcg_test_1<br>
&gt;=C2=A0 <br>
&gt; @@ -124,6 +129,16 @@ test_1()<br>
&gt;=C2=A0 #---------------------------------------------------------------=
------------<br>
&gt;=C2=A0 test_2()<br>
&gt;=C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0# for cgroup2 the default behaivor is to check th=
e new memory limit and<br>
&gt; +=C2=A0 =C2=A0 =C2=A0# then to start killing processes if oom. This te=
st then doesen&#39;t<br>
&gt; +=C2=A0 =C2=A0 =C2=A0# make sense as we don&#39;t expect EBUSY to be r=
eturned. The shrink<br>
&gt; +=C2=A0 =C2=A0 =C2=A0# operation (write to memory.max in cgroup2) woul=
d kill the pid1 process<br>
&gt; +=C2=A0 =C2=A0 =C2=A0# and exit.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if [ &quot;$cgroup_ver&quot; =3D &quot;cgroup2&qu=
ot; ]; then<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tst_resm TCONF &quot;=
cgroup2 found, skipping test&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return<br>
&gt; +=C2=A0 =C2=A0 =C2=A0fi<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0./memcg_test_2 &amp;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0pid1=3D$!<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0sleep 1<br>
&gt; @@ -177,12 +192,20 @@ test_2()<br>
&gt;=C2=A0 test_3()<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0mkdir memcg/0<br>
&gt; -=C2=A0 =C2=A0 =C2=A0for pid in `cat memcg/tasks`; do<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0echo $pid &gt; memcg/=
0/tasks 2&gt; /dev/null<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if [ &quot;$cgroup_ver&quot; =3D &quot;cgroup2&qu=
ot; ]; then<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memcg_procs=3Dmemcg/c=
group.procs<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memcg_subprocs=3Dmemc=
g/0/cgroup.procs<br>
&gt; +=C2=A0 =C2=A0 =C2=A0else<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memcg_procs=3Dmemcg/t=
asks<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memcg_subprocs=3Dmemc=
g/0/tasks<br>
&gt; +=C2=A0 =C2=A0 =C2=A0fi<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0for pid in `cat $memcg_procs`; do<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0echo $pid &gt; $memcg=
_subprocs 2&gt; /dev/null<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0done<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 =C2=A0for pid in `cat memcg/0/tasks`; do<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0echo $pid &gt; memcg/=
tasks 2&gt; /dev/null<br>
&gt; +=C2=A0 =C2=A0 =C2=A0for pid in `cat $memcg_subprocs`; do<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0echo $pid &gt; $memcg=
_procs 2&gt; /dev/null<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0done<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0rmdir memcg/0<br>
&gt;=C2=A0 <br>
&gt; @@ -218,13 +241,19 @@ test_4()<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 # main<br>
&gt; +cgroup_ver=3D$(grep &quot;/sys/fs/cgroup&quot; /proc/mounts | cut -d&=
#39; &#39; -f1)<br>
&gt;=C2=A0 failed=3D0<br>
&gt;=C2=A0 mkdir memcg/<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 for cur in $(seq 1 $TST_TOTAL); do<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0export TST_COUNT=3D$cur<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 =C2=A0mount -t cgroup -o memory xxx memcg/<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if [ &quot;$cgroup_ver&quot; =3D &quot;cgroup2&qu=
ot; ]; then<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mount -t cgroup2 xxx =
memcg/<br>
&gt; +=C2=A0 =C2=A0 =C2=A0else<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mount -t cgroup -o me=
mory xxx memcg/<br>
&gt; +=C2=A0 =C2=A0 =C2=A0fi<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if [ $? -ne 0 ]; then<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tst_resm TFAIL &=
quot;failed to mount memory subsystem&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0failed=3D1<br>
&gt; diff --git a/testcases/kernel/controllers/memcg/regression/memcg_test_=
1.c b/testcases/kernel/controllers/memcg/regression/memcg_test_1.c<br>
&gt; index c7fb948fe..b9277e633 100644<br>
&gt; --- a/testcases/kernel/controllers/memcg/regression/memcg_test_1.c<br>
&gt; +++ b/testcases/kernel/controllers/memcg/regression/memcg_test_1.c<br>
&gt; @@ -33,6 +33,16 @@<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #define FORKED_PROC_COUNT=C2=A0 =C2=A0 10<br>
&gt;=C2=A0 <br>
&gt; +static int open_cgroup_procs(void)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int fd =3D open(&quot;memcg/0/tasks&quot;, O_WRON=
LY);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (fd &gt;=3D 0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return fd;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0fd =3D open(&quot;memcg/0/cgroup.procs&quot;, O_W=
RONLY);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return fd;<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 int main(void)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0char buf[10];<br>
&gt; @@ -40,7 +50,7 @@ int main(void)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int loop;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int pid;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int size =3D getpagesize();<br>
&gt; -=C2=A0 =C2=A0 =C2=A0int fd =3D open(&quot;memcg/0/tasks&quot;, O_WRON=
LY);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int fd =3D open_cgroup_procs();<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (fd &lt; 0)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 1;<br>
&gt; diff --git a/testcases/kernel/controllers/memcg/regression/memcg_test_=
3.c b/testcases/kernel/controllers/memcg/regression/memcg_test_3.c<br>
&gt; index 75a6e1545..d5531fe87 100644<br>
&gt; --- a/testcases/kernel/controllers/memcg/regression/memcg_test_3.c<br>
&gt; +++ b/testcases/kernel/controllers/memcg/regression/memcg_test_3.c<br>
&gt; @@ -66,6 +66,14 @@ static void setup(void)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0SAFE_MKDIR(MNTPOINT, 0644);<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D mount(&quot;memcg&quot;, MNTPOINT, &=
quot;cgroup&quot;, 0, &quot;memory&quot;);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (!ret) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mount_flag =3D 1;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ret =3D mount(&quot;memcg&quot;, MNTPOINT, &quot;=
cgroup2&quot;, 0, NULL);<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (errno =3D=3D=
 ENOENT)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0tst_brk(TCONF | TERRNO, &quot;memcg not supported&quot;);<br>
&gt; diff --git a/testcases/kernel/controllers/memcg/regression/memcg_test_=
4.sh b/testcases/kernel/controllers/memcg/regression/memcg_test_4.sh<br>
&gt; index 620031366..287864b81 100755<br>
&gt; --- a/testcases/kernel/controllers/memcg/regression/memcg_test_4.sh<br=
>
&gt; +++ b/testcases/kernel/controllers/memcg/regression/memcg_test_4.sh<br=
>
&gt; @@ -22,9 +22,19 @@<br>
&gt;=C2=A0 ##=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ##<br>
&gt;=C2=A0 ################################################################=
################<br>
&gt;=C2=A0 <br>
&gt; +cgroup_ver=3D$(grep &quot;/sys/fs/cgroup&quot; /proc/mounts | cut -d&=
#39; &#39; -f1)<br>
<br>
Unfortunately this doesn&#39;t work when both V1 and V2 hierarchies are<br>
mounted. You need to check that the memory controller is enabled on<br>
V2. Also it&#39;s possible to mount CGroups at alternate locations.<br>
<br>
Please see the recent patch from Masayoshi:<br>
<a href=3D"https://patchwork.ozlabs.org/project/ltp/patch/20211113041706.12=
893-1-msys.mizuma@gmail.com/" rel=3D"noreferrer" target=3D"_blank">https://=
patchwork.ozlabs.org/project/ltp/patch/20211113041706.12893-1-msys.mizuma@g=
mail.com/</a><br>
<br>
&gt; +<br>
&gt; +if [ &quot;$cgroup_ver&quot; =3D &#39;cgroup2&#39; ]; then<br>
&gt; +=C2=A0 =C2=A0 =C2=A0cgroup_proc=3Dcgroup.procs<br>
&gt; +=C2=A0 =C2=A0 =C2=A0cgroup_mem_limit=3Dmemory.max<br>
&gt; +else<br>
&gt; +=C2=A0 =C2=A0 =C2=A0cgroup_proc=3Dtasks<br>
&gt; +=C2=A0 =C2=A0 =C2=A0cgroup_mem_limit=3Dmemory.limit_in_bytes<br>
&gt; +fi<br>
&gt; +<br>
&gt;=C2=A0 # attach current task to memcg/0/<br>
&gt;=C2=A0 mkdir memcg/0<br>
&gt; -echo $$ &gt; memcg/0/tasks<br>
&gt; +echo $$ &gt; memcg/0/${cgroup_proc}<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 ./memcg_test_4 &amp;<br>
&gt;=C2=A0 pid=3D$!<br>
&gt; @@ -35,13 +45,13 @@ sleep 1<br>
&gt;=C2=A0 sleep 1<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 # shrink memory, and then 80M will be swapped<br>
&gt; -echo 40M &gt; memcg/0/memory.limit_in_bytes<br>
&gt; +echo 40M &gt; memcg/0/${cgroup_mem_limit}<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 # turn off swap, and swapoff will be killed<br>
&gt;=C2=A0 swapoff -a<br>
&gt;=C2=A0 sleep 1<br>
&gt; -echo $pid &gt; memcg/tasks 2&gt; /dev/null<br>
&gt; -echo $$ &gt; memcg/tasks 2&gt; /dev/null<br>
&gt; +echo $pid &gt; memcg/${cgroup_proc} 2&gt; /dev/null<br>
&gt; +echo $$ &gt; memcg/${cgroup_proc} 2&gt; /dev/null<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 # now remove the cgroup<br>
&gt;=C2=A0 rmdir memcg/0<br>
&gt; -- <br>
&gt; 2.32.0<br>
<br>
<br>
-- <br>
Thank you,<br>
Richard.<br>
</blockquote></div></div>

--00000000000034c0c605d102a600--

--===============1636391508==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1636391508==--
