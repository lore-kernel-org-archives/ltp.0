Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FE0AC433EF
	for <ltp@archiver.kernel.org>; Wed, 16 Feb 2022 10:14:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 704E83CA092
	for <ltp@archiver.kernel.org>; Wed, 16 Feb 2022 11:14:07 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 311663C9C38
 for <ltp@lists.linux.it>; Wed, 16 Feb 2022 11:13:58 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 0B6FD100134F
 for <ltp@lists.linux.it>; Wed, 16 Feb 2022 11:13:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1645006435;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YDL1cmvGwVfGPNV1ZwVn/lZtkxBAbZrTIxhfVF05/Cg=;
 b=haDec2wgEF4AuAUgJRZL/oE8TSyTvEWo2dt/zcNf7mp0QwYz72wyY4hQE5lDlxd0W1Ld6x
 clhXb0b91aHEz7Ndx6CcQPcdWY6Xaza+JcufLKdQF27McS8wiz0Igv5eoKJrWs9FgvgMFb
 HwcEHOVntVhgwo4DSfbpKcVsz7ImqWE=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-625-kQc0ijqbNoC0ONAnmVHFPQ-1; Wed, 16 Feb 2022 05:13:53 -0500
X-MC-Unique: kQc0ijqbNoC0ONAnmVHFPQ-1
Received: by mail-yb1-f199.google.com with SMTP id
 c10-20020a251c0a000000b0062272fc32bfso3192421ybc.17
 for <ltp@lists.linux.it>; Wed, 16 Feb 2022 02:13:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YDL1cmvGwVfGPNV1ZwVn/lZtkxBAbZrTIxhfVF05/Cg=;
 b=KK+BBK/lIpP9dkHOu0pG/s6SOE0hgBUabyYxk2XasYWY5zoV/4yAxJSQFhlHHQv93X
 B4kKp9mWRml0QcqJfDkGsXBfQc2CFSZKd4uCdVP2WLWzETgGPxWxU01oHwLEvQdKYWHE
 OnENkw+WnC1DLKz2PciRyg7WY265XH+cJTu7HrGmlIsM49sISVCfIkIifeoIE7mqcgPW
 dEl0uUUUh/qX03lizZuTGbJOu7FVHtBK/bvAw5vviZkjbOYgWrdxL/E24V2SUPlNXoU9
 yW8SXY+hTwB++GaGPIRT/ZV//m71M0wKZMhbC7PAEBvmYCC2obfSrhfhXL3ed2BBa7Mo
 pzrQ==
X-Gm-Message-State: AOAM530VsrqPY+qfNuzVTCN7AnydheZXsJkmaQ2BjEjIodNPNxbQ6RaQ
 RvHZ4/+EprIp9EgjAym7G3qV4VTl7AqrVgGJlEbcoG1PvDlqfPgh2v0/52n/DMUxIsRoLThMAl5
 KnV0+NJYDkQycVvhmlpvuFAG69bI=
X-Received: by 2002:a81:a9c2:0:b0:2d0:f58c:3959 with SMTP id
 g185-20020a81a9c2000000b002d0f58c3959mr1749148ywh.170.1645006433132; 
 Wed, 16 Feb 2022 02:13:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzK7rW8koC7daY58/Rnoo3L1/fyahbSdaU7A3QFcXulx3kDq7I1gSBSwHkZPgICOiLQoxWayql10XI3uqIs48A=
X-Received: by 2002:a81:a9c2:0:b0:2d0:f58c:3959 with SMTP id
 g185-20020a81a9c2000000b002d0f58c3959mr1749140ywh.170.1645006432815; Wed, 16
 Feb 2022 02:13:52 -0800 (PST)
MIME-Version: 1.0
References: <20220208140322.6842-1-rpalethorpe@suse.com>
 <20220208140322.6842-4-rpalethorpe@suse.com>
 <CAEemH2e2btUUYqj69nWGpXC4B43Dg7+y8-m2udsNCjtZr6s7Tg@mail.gmail.com>
 <CAEemH2fQgURKROaVH7ZNszpBonGwZn6fNbN4XC8FPCH98J2+VA@mail.gmail.com>
 <CAEemH2fgDbmPLAQBOFD-6Q1N66XWV_NZCWWx2CEfP9=KFNh-xA@mail.gmail.com>
 <871r06kmlq.fsf@suse.de>
In-Reply-To: <871r06kmlq.fsf@suse.de>
From: Li Wang <liwang@redhat.com>
Date: Wed, 16 Feb 2022 18:13:38 +0800
Message-ID: <CAEemH2cdnUQ5rC5aokEyYK462bOO6bL9-vUHPWfsonaMxjHyCA@mail.gmail.com>
To: Richard Palethorpe <rpalethorpe@suse.de>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
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
Content-Type: multipart/mixed; boundary="===============0224458190=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0224458190==
Content-Type: multipart/alternative; boundary="00000000000014ec7805d81fe8e1"

--00000000000014ec7805d81fe8e1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Richard,

On Mon, Feb 14, 2022 at 2:07 PM Richard Palethorpe <rpalethorpe@suse.de>
wrote:

> Hello Li,
>
> Li Wang <liwang@redhat.com> writes:
>
> > On Thu, Feb 10, 2022 at 2:23 PM Li Wang <liwang@redhat.com> wrote:
> >
> >  On Wed, Feb 9, 2022 at 7:05 PM Li Wang <liwang@redhat.com> wrote:
> >
> >  Btw, there are some TFAILs from my manual run.
> >  (I will look into that try to figure it out tomorrow)
> >
> >  tst_test.c:1521: TINFO: Testing on ext4
> >  tst_test.c:996: TINFO: Formatting /dev/loop0 with ext4 opts=3D'' extra
> opts=3D''
> >  mke2fs 1.46.5 (30-Dec-2021)
> >  tst_test.c:1452: TINFO: Timeout per run is 0h 05m 00s
> >  memcontrol04.c:118: TINFO: Child 242775 in leaf_C: Allocating
> pagecache: 52428800
> >  memcontrol04.c:118: TINFO: Child 242776 in leaf_D: Allocating
> pagecache: 52428800
> >  memcontrol04.c:118: TINFO: Child 242777 in leaf_F: Allocating
> pagecache: 52428800
> >  memcontrol04.c:99: TINFO: Child 242778 in trunk_G: Allocating anon:
> 155189248
> >  memcontrol04.c:170: TPASS: Expect: (A/B memory.current=3D54181888) ~=
=3D
> 52428800
> >  memcontrol04.c:176: TPASS: Expect: (A/B/C memory.current=3D30957568) ~=
=3D
> 34603008
> >  memcontrol04.c:178: TPASS: Expect: (A/B/D memory.current=3D22282240) ~=
=3D
> 17825792
> >  memcontrol04.c:180: TPASS: Expect: (A/B/E memory.current=3D0) ~=3D 0
> >  memcontrol04.c:99: TINFO: Child 242779 in trunk_G: Allocating anon:
> 174063616
> >  memcontrol04.c:193: TPASS: Expect: (oom events=3D0) =3D=3D 0
> >  memcontrol04.c:196: TPASS: Expect: (low events=3D373) > 0
> >  memcontrol04.c:193: TPASS: Expect: (oom events=3D0) =3D=3D 0
> >  memcontrol04.c:196: TPASS: Expect: (low events=3D373) > 0
> >  memcontrol04.c:193: TPASS: Expect: (oom events=3D0) =3D=3D 0
> >  memcontrol04.c:198: TPASS: Expect: (low events=3D0) =3D=3D 0
> >  memcontrol04.c:193: TPASS: Expect: (oom events=3D0) =3D=3D 0
> >  memcontrol04.c:198: TFAIL: Expect: (low events=3D370) =3D=3D 0
> >
> >  It looks like a logic issue here, as we do alloc_pagecache 50MB
> >  respectively in the leaf_cg[C, D, E, F] and only the 'memory.low'
> >
> > My apologies, the leaf_cg[E] does not have 50MB page cache
> > allocating, that is the main reason with no memory reclaims happening.
> > '500MB' low boundary obviously overcommitment, so leaf_cg[E] will
> > get the part of parent=E2=80=99s protection proportional to its actual =
memory
> > usage. However, it doesn't matter for this case, leaf_cg[E] can get
> > no event grows as well. Because it has no memory consumption at all.
>
> leaf_cg[F]'s memory.low =3D=3D 0. So how can it have reclaim events where
> memory.current < memory.low?
>
> Testing on the upstream kernel there are no low events in F.
>

A bit weird...

From my test, it indeed has the events that occur.
(even the original test fail as the same)
And the leaf_cg[F]'s memory.current is almost 1MB.

# uname -r
5.17.0-rc4.liwang
...
tst_test.c:1521: TINFO: Testing on xfs
tst_test.c:996: TINFO: Formatting /dev/loop0 with xfs opts=3D'' extra opts=
=3D''
tst_test.c:1452: TINFO: Timeout per run is 0h 05m 00s
memcontrol04.c:118: TINFO: Child 21200 in leaf_C: Allocating pagecache:
52428800
memcontrol04.c:118: TINFO: Child 21201 in leaf_D: Allocating pagecache:
52428800
memcontrol04.c:118: TINFO: Child 21202 in leaf_F: Allocating pagecache:
52428800
memcontrol04.c:99: TINFO: Child 21203 in trunk_G: Allocating anon: 15518924=
8
memcontrol04.c:170: TPASS: Expect: (A/B memory.current=3D54083584) ~=3D 524=
28800
memcontrol04.c:176: TPASS: Expect: (A/B/C memory.current=3D29822976) ~=3D
34603008
memcontrol04.c:178: TPASS: Expect: (A/B/D memory.current=3D22061056) ~=3D
17825792
memcontrol04.c:180: TPASS: Expect: (A/B/E memory.current=3D0) ~=3D 0
memcontrol04.c:99: TINFO: Child 21204 in trunk_G: Allocating anon: 17406361=
6
memcontrol04.c:193: TPASS: Expect: (leaf_cg0: oom events=3D0) =3D=3D 0
memcontrol04.c:196: TPASS: Expect: (leaf_cg0: low events=3D427) > 0
memcontrol04.c:193: TPASS: Expect: (leaf_cg1: oom events=3D0) =3D=3D 0
memcontrol04.c:196: TPASS: Expect: (leaf_cg1: low events=3D427) > 0
memcontrol04.c:193: TPASS: Expect: (leaf_cg2: oom events=3D0) =3D=3D 0
memcontrol04.c:198: TPASS: Expect: (leaf_cg2: low events=3D0) =3D=3D 0
memcontrol04.c:193: TPASS: Expect: (leaf_cg3: oom events=3D0) =3D=3D 0
memcontrol04.c:198: TFAIL: Expect: (leaf_cg3: low events=3D415) =3D=3D 0

Summary:
passed   44
failed   4
broken   0
skipped  0
warnings 0


# pwd
/root/linux-5.17-rc4/tools/testing/selftests/cgroup

# ./test_memcontrol
ok 1 test_memcg_subtree_control
ok 2 test_memcg_current
ok 3 test_memcg_min
not ok 4 test_memcg_low

--=20
Regards,
Li Wang

--00000000000014ec7805d81fe8e1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Hi Richard,</div></div><br><div class=3D"gmail_quote"><div di=
r=3D"ltr" class=3D"gmail_attr">On Mon, Feb 14, 2022 at 2:07 PM Richard Pale=
thorpe &lt;<a href=3D"mailto:rpalethorpe@suse.de">rpalethorpe@suse.de</a>&g=
t; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hello =
Li,<br>
<br>
Li Wang &lt;<a href=3D"mailto:liwang@redhat.com" target=3D"_blank">liwang@r=
edhat.com</a>&gt; writes:<br>
<br>
&gt; On Thu, Feb 10, 2022 at 2:23 PM Li Wang &lt;<a href=3D"mailto:liwang@r=
edhat.com" target=3D"_blank">liwang@redhat.com</a>&gt; wrote:<br>
&gt;<br>
&gt;=C2=A0 On Wed, Feb 9, 2022 at 7:05 PM Li Wang &lt;<a href=3D"mailto:liw=
ang@redhat.com" target=3D"_blank">liwang@redhat.com</a>&gt; wrote:<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 Btw, there are some TFAILs from my manual run. <br>
&gt;=C2=A0 (I will look into that try to figure it out tomorrow)<br>
&gt;<br>
&gt;=C2=A0 tst_test.c:1521: TINFO: Testing on ext4<br>
&gt;=C2=A0 tst_test.c:996: TINFO: Formatting /dev/loop0 with ext4 opts=3D&#=
39;&#39; extra opts=3D&#39;&#39;<br>
&gt;=C2=A0 mke2fs 1.46.5 (30-Dec-2021)<br>
&gt;=C2=A0 tst_test.c:1452: TINFO: Timeout per run is 0h 05m 00s<br>
&gt;=C2=A0 memcontrol04.c:118: TINFO: Child 242775 in leaf_C: Allocating pa=
gecache: 52428800<br>
&gt;=C2=A0 memcontrol04.c:118: TINFO: Child 242776 in leaf_D: Allocating pa=
gecache: 52428800<br>
&gt;=C2=A0 memcontrol04.c:118: TINFO: Child 242777 in leaf_F: Allocating pa=
gecache: 52428800<br>
&gt;=C2=A0 memcontrol04.c:99: TINFO: Child 242778 in trunk_G: Allocating an=
on: 155189248<br>
&gt;=C2=A0 memcontrol04.c:170: TPASS: Expect: (A/B memory.current=3D5418188=
8) ~=3D 52428800<br>
&gt;=C2=A0 memcontrol04.c:176: TPASS: Expect: (A/B/C memory.current=3D30957=
568) ~=3D 34603008<br>
&gt;=C2=A0 memcontrol04.c:178: TPASS: Expect: (A/B/D memory.current=3D22282=
240) ~=3D 17825792<br>
&gt;=C2=A0 memcontrol04.c:180: TPASS: Expect: (A/B/E memory.current=3D0) ~=
=3D 0<br>
&gt;=C2=A0 memcontrol04.c:99: TINFO: Child 242779 in trunk_G: Allocating an=
on: 174063616<br>
&gt;=C2=A0 memcontrol04.c:193: TPASS: Expect: (oom events=3D0) =3D=3D 0<br>
&gt;=C2=A0 memcontrol04.c:196: TPASS: Expect: (low events=3D373) &gt; 0<br>
&gt;=C2=A0 memcontrol04.c:193: TPASS: Expect: (oom events=3D0) =3D=3D 0<br>
&gt;=C2=A0 memcontrol04.c:196: TPASS: Expect: (low events=3D373) &gt; 0<br>
&gt;=C2=A0 memcontrol04.c:193: TPASS: Expect: (oom events=3D0) =3D=3D 0<br>
&gt;=C2=A0 memcontrol04.c:198: TPASS: Expect: (low events=3D0) =3D=3D 0<br>
&gt;=C2=A0 memcontrol04.c:193: TPASS: Expect: (oom events=3D0) =3D=3D 0<br>
&gt;=C2=A0 memcontrol04.c:198: TFAIL: Expect: (low events=3D370) =3D=3D 0<b=
r>
&gt;<br>
&gt;=C2=A0 It looks like a logic issue here, as we do alloc_pagecache 50MB<=
br>
&gt;=C2=A0 respectively in the leaf_cg[C, D, E, F] and only the &#39;memory=
.low&#39;<br>
&gt;<br>
&gt; My apologies, the leaf_cg[E] does not have 50MB page cache<br>
&gt; allocating, that is the main reason with no memory reclaims happening.=
<br>
&gt; &#39;500MB&#39; low boundary obviously overcommitment, so leaf_cg[E] w=
ill<br>
&gt; get the part of parent=E2=80=99s protection proportional to its actual=
 memory<br>
&gt; usage. However, it doesn&#39;t matter for this case, leaf_cg[E] can ge=
t<br>
&gt; no event grows as well. Because it has no memory consumption at all.<b=
r>
<br>
leaf_cg[F]&#39;s memory.low =3D=3D 0. So how can it have reclaim events whe=
re<br>
memory.current &lt; memory.low?<br>
<br>
Testing on the upstream kernel there are no low events in F.<br></blockquot=
e><div><br></div><div><div class=3D"gmail_default" style=3D"font-size:small=
">A bit weird...</div><br></div><div><div class=3D"gmail_default" style=3D"=
font-size:small">From my test, it indeed has the events that occur.</div><d=
iv class=3D"gmail_default" style=3D"font-size:small">(even the original tes=
t fail as the same)</div><div class=3D"gmail_default" style=3D"font-size:sm=
all">And the leaf_cg[F]&#39;s memory.current is almost 1MB.</div><br></div>=
<div><div class=3D"gmail_default" style=3D"font-size:small"><span class=3D"=
gmail_default"></span># uname -r</div><div class=3D"gmail_default" style=3D=
"font-size:small">5.17.0-rc4.liwang</div><div class=3D"gmail_default" style=
=3D"font-size:small"></div><div class=3D"gmail_default" style=3D"font-size:=
small">...</div></div><div class=3D"gmail_default" style=3D"font-size:small=
">tst_test.c:1521: TINFO: Testing on xfs</div>tst_test.c:996: TINFO: Format=
ting /dev/loop0 with xfs opts=3D&#39;&#39; extra opts=3D&#39;&#39;<br>tst_t=
est.c:1452: TINFO: Timeout per run is 0h 05m 00s<br>memcontrol04.c:118: TIN=
FO: Child 21200 in leaf_C: Allocating pagecache: 52428800<br>memcontrol04.c=
:118: TINFO: Child 21201 in leaf_D: Allocating pagecache: 52428800<br>memco=
ntrol04.c:118: TINFO: Child 21202 in leaf_F: Allocating pagecache: 52428800=
<br>memcontrol04.c:99: TINFO: Child 21203 in trunk_G: Allocating anon: 1551=
89248<br>memcontrol04.c:170: TPASS: Expect: (A/B memory.current=3D54083584)=
 ~=3D 52428800<br>memcontrol04.c:176: TPASS: Expect: (A/B/C memory.current=
=3D29822976) ~=3D 34603008<br>memcontrol04.c:178: TPASS: Expect: (A/B/D mem=
ory.current=3D22061056) ~=3D 17825792<br>memcontrol04.c:180: TPASS: Expect:=
 (A/B/E memory.current=3D0) ~=3D 0<br>memcontrol04.c:99: TINFO: Child 21204=
 in trunk_G: Allocating anon: 174063616<br>memcontrol04.c:193: TPASS: Expec=
t: (leaf_cg0: oom events=3D0) =3D=3D 0<br>memcontrol04.c:196: TPASS: Expect=
: (leaf_cg0: low events=3D427) &gt; 0<br>memcontrol04.c:193: TPASS: Expect:=
 (leaf_cg1: oom events=3D0) =3D=3D 0<br>memcontrol04.c:196: TPASS: Expect: =
(leaf_cg1: low events=3D427) &gt; 0<br>memcontrol04.c:193: TPASS: Expect: (=
leaf_cg2: oom events=3D0) =3D=3D 0<br>memcontrol04.c:198: TPASS: Expect: (l=
eaf_cg2: low events=3D0) =3D=3D 0<br>memcontrol04.c:193: TPASS: Expect: (le=
af_cg3: oom events=3D0) =3D=3D 0<br>memcontrol04.c:198: TFAIL: Expect: (lea=
f_cg3: low events=3D415) =3D=3D 0<br><br>Summary:<br>passed =C2=A0 44<br>fa=
iled =C2=A0 4<br>broken =C2=A0 0<br>skipped =C2=A00<br>warnings 0</div><div=
 class=3D"gmail_quote"><br></div><div class=3D"gmail_quote"><br></div><div =
class=3D"gmail_quote"><div class=3D"gmail_default" style=3D"font-size:small=
"># pwd</div>/root/linux-5.17-rc4/tools/testing/selftests/cgroup<br><br><sp=
an class=3D"gmail_default" style=3D"font-size:small"></span># ./test_memcon=
trol <br>ok 1 test_memcg_subtree_control<br>ok 2 test_memcg_current<br>ok 3=
 test_memcg_min<br>not ok 4 test_memcg_low<br><div class=3D"gmail_default" =
style=3D"font-size:small"><br></div></div>-- <br><div dir=3D"ltr" class=3D"=
gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></=
div></div></div></div>

--00000000000014ec7805d81fe8e1--


--===============0224458190==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0224458190==--

