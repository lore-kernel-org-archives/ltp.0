Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33820C433EF
	for <ltp@archiver.kernel.org>; Thu, 10 Feb 2022 07:12:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 86F6C3C9DFC
	for <ltp@archiver.kernel.org>; Thu, 10 Feb 2022 08:12:50 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B2F283C9DB0
 for <ltp@lists.linux.it>; Thu, 10 Feb 2022 08:12:40 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E36C9200BBC
 for <ltp@lists.linux.it>; Thu, 10 Feb 2022 08:12:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1644477157;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iuiW4hXzK5Ume8LxwCr9e5ZLVu/WiCaTGLK5ISvFFpA=;
 b=eM5/gXz4raJ7gJFrFQEUImuwOx1Y2eR9gKXR9YSAorE+jmZODdPVSZssuH/oBES1b3kPq2
 37KsIj1Ul+L/D35jDiEmljCwMW275HAKa2zSLbpe3pbfHPILeoEvEqMKK5l+7cf32OciuX
 l6BYSYF9ufVcO81z2NK265XYh27pwYU=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-454-z5QPL6x0OwGZYMZiau3tSQ-1; Thu, 10 Feb 2022 02:12:35 -0500
X-MC-Unique: z5QPL6x0OwGZYMZiau3tSQ-1
Received: by mail-yb1-f199.google.com with SMTP id
 x1-20020a25a001000000b0061c64ee0196so10303042ybh.9
 for <ltp@lists.linux.it>; Wed, 09 Feb 2022 23:12:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+2XCeqrkPL8p5NFZ40EonCP9bSwCGFoh5PXMkHD0ItA=;
 b=XBs6v684Z5ZrWsAvlNyck9x5I/UOPfv+pQoSlBDIErwevvGQ0e/7WhKp2s5kQDd4K7
 eIkpWDniHD8nN5Tuby84zAE3tBEd/mbPY+Sq4QJpCEbqNtZBCgzNz6+kmcHwxU0L8Phm
 OSMhVPE3tatfY0S5YA1wCf/r6XgE/xOjGjgYoceBILOEb2F73b3/s0SeDGPdi0Qgzj5q
 Twy4PUCqDVxBd8eatVoZN6v1M+mEi9UxxXovgODO10KyGQd0LPlWSqPmeEWYqrrrxaRE
 E2HOcJ7g6cLtdXmFxZ7ipHoWZ89+hU3tNTyJmO5Rf0iu5T9YyfJvNgCIYXYq64GH9P+u
 b5TA==
X-Gm-Message-State: AOAM530Fvn4WyUxECZ26Bq+CiobKCcQFe8MhaA4ZdXqzZCNYP8YcZCrj
 w+OK9mk5R3X/DM9bPATlwawziiAR96N6QauQER+ul61W4m2Fy/RT4n36k0JEO4Ju+DIr81E3Zwv
 8KYgscoMpj3zZDJrNVfcYqEOlY3c=
X-Received: by 2002:a25:45:: with SMTP id 66mr5819193yba.102.1644477155165;
 Wed, 09 Feb 2022 23:12:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyNYPtYnZco/3j7+OUXMqkdSPmrgKcGNp4r0yOyseC8SHx/XPmU7bWpXnFdlRXYUoGWw9Yy7i3hrP7shbRjdNA=
X-Received: by 2002:a25:45:: with SMTP id 66mr5819182yba.102.1644477154952;
 Wed, 09 Feb 2022 23:12:34 -0800 (PST)
MIME-Version: 1.0
References: <20220208140322.6842-1-rpalethorpe@suse.com>
 <20220208140322.6842-4-rpalethorpe@suse.com>
 <CAEemH2e2btUUYqj69nWGpXC4B43Dg7+y8-m2udsNCjtZr6s7Tg@mail.gmail.com>
 <CAEemH2fQgURKROaVH7ZNszpBonGwZn6fNbN4XC8FPCH98J2+VA@mail.gmail.com>
In-Reply-To: <CAEemH2fQgURKROaVH7ZNszpBonGwZn6fNbN4XC8FPCH98J2+VA@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Thu, 10 Feb 2022 15:12:20 +0800
Message-ID: <CAEemH2fgDbmPLAQBOFD-6Q1N66XWV_NZCWWx2CEfP9=KFNh-xA@mail.gmail.com>
To: Richard Palethorpe <rpalethorpe@suse.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
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
Content-Type: multipart/mixed; boundary="===============1740607418=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1740607418==
Content-Type: multipart/alternative; boundary="000000000000a9a92105d7a4ac6a"

--000000000000a9a92105d7a4ac6a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 10, 2022 at 2:23 PM Li Wang <liwang@redhat.com> wrote:

>
>
> On Wed, Feb 9, 2022 at 7:05 PM Li Wang <liwang@redhat.com> wrote:
>
>
>> Btw, there are some TFAILs from my manual run.
>> (I will look into that try to figure it out tomorrow)
>>
>> tst_test.c:1521: TINFO: Testing on ext4
>> tst_test.c:996: TINFO: Formatting /dev/loop0 with ext4 opts=3D'' extra
>> opts=3D''
>> mke2fs 1.46.5 (30-Dec-2021)
>> tst_test.c:1452: TINFO: Timeout per run is 0h 05m 00s
>> memcontrol04.c:118: TINFO: Child 242775 in leaf_C: Allocating pagecache:
>> 52428800
>> memcontrol04.c:118: TINFO: Child 242776 in leaf_D: Allocating pagecache:
>> 52428800
>> memcontrol04.c:118: TINFO: Child 242777 in leaf_F: Allocating pagecache:
>> 52428800
>> memcontrol04.c:99: TINFO: Child 242778 in trunk_G: Allocating anon:
>> 155189248
>> memcontrol04.c:170: TPASS: Expect: (A/B memory.current=3D54181888) ~=3D
>> 52428800
>> memcontrol04.c:176: TPASS: Expect: (A/B/C memory.current=3D30957568) ~=
=3D
>> 34603008
>> memcontrol04.c:178: TPASS: Expect: (A/B/D memory.current=3D22282240) ~=
=3D
>> 17825792
>> memcontrol04.c:180: TPASS: Expect: (A/B/E memory.current=3D0) ~=3D 0
>> memcontrol04.c:99: TINFO: Child 242779 in trunk_G: Allocating anon:
>> 174063616
>> memcontrol04.c:193: TPASS: Expect: (oom events=3D0) =3D=3D 0
>> memcontrol04.c:196: TPASS: Expect: (low events=3D373) > 0
>> memcontrol04.c:193: TPASS: Expect: (oom events=3D0) =3D=3D 0
>> memcontrol04.c:196: TPASS: Expect: (low events=3D373) > 0
>> memcontrol04.c:193: TPASS: Expect: (oom events=3D0) =3D=3D 0
>> memcontrol04.c:198: TPASS: Expect: (low events=3D0) =3D=3D 0
>> memcontrol04.c:193: TPASS: Expect: (oom events=3D0) =3D=3D 0
>> memcontrol04.c:198: TFAIL: Expect: (low events=3D370) =3D=3D 0
>>
>
> It looks like a logic issue here, as we do alloc_pagecache 50MB
> respectively in the leaf_cg[C, D, E, F] and only the 'memory.low'
>

My apologies, the leaf_cg[E] does not have 50MB page cache
allocating, that is the main reason with no memory reclaims happening.
'500MB' low boundary obviously overcommitment, so leaf_cg[E] will
get the part of parent=E2=80=99s protection proportional to its actual memo=
ry
usage. However, it doesn't matter for this case, leaf_cg[E] can get
no event grows as well. Because it has no memory consumption at all.

The fix is still effective unless I misread something again:).



> of leaf_cg[E] is large enough (500MB) to avoid triggering low event.
> The rest cgroups should all have low events, that kernel behavior
> is correct.
>
> This failure should be fix with:
>
> --- a/testcases/kernel/controllers/memcg/memcontrol04.c
> +++ b/testcases/kernel/controllers/memcg/memcontrol04.c
> @@ -192,7 +192,7 @@ static void test_memcg_low(void)
>
>                 TST_EXP_EXPR(oom =3D=3D 0, "(oom events=3D%ld) =3D=3D 0",=
 oom);
>
> -               if (i < E)
> +               if (i !=3D E)
>                         TST_EXP_EXPR(low > 0, "(low events=3D%ld) > 0", l=
ow)
>                 else
>                         TST_EXP_EXPR(low =3D=3D 0, "(low events=3D%ld) =
=3D=3D 0",
> low);
>
>
> And better to add "leaf_cg%d" print in the output:
> (to show the events from which cgroup)
>
>     TST_EXP_EXPR(oom =3D=3D 0, "(leaf_cg%d: oom events=3D%ld) =3D=3D 0", =
i, oom);
>
>     if (i !=3D E)
>             TST_EXP_EXPR(low > 0, "(leaf_cg%d: low events=3D%ld) > 0", i,
>  low)
>     else
>              TST_EXP_EXPR(low =3D=3D 0, "(leaf_cg%d: low events=3D%ld) =
=3D=3D 0",
> i, low);
>
> --
> Regards,
> Li Wang
>


--=20
Regards,
Li Wang

--000000000000a9a92105d7a4ac6a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Thu, Feb 10, 2022 at 2:23 PM Li Wang &lt;<a href=
=3D"mailto:liwang@redhat.com">liwang@redhat.com</a>&gt; wrote:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div dir=3D=
"ltr"><div style=3D"font-size:small"><br></div></div><br><div class=3D"gmai=
l_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Feb 9, 2022 at 7:05 =
PM Li Wang &lt;<a href=3D"mailto:liwang@redhat.com" target=3D"_blank">liwan=
g@redhat.com</a>&gt; wrote:<br></div><div>=C2=A0</div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex"><div dir=3D"ltr"><div class=3D"gmail_quote"><d=
iv style=3D"font-size:small"></div><div style=3D"font-size:small">Btw, ther=
e are some TFAILs from my manual run.=C2=A0</div><div style=3D"font-size:sm=
all">(I will look into that try to figure it out tomorrow)</div><div style=
=3D"font-size:small"><br></div><div style=3D"font-size:small">tst_test.c:15=
21: TINFO: Testing on ext4<br>tst_test.c:996: TINFO: Formatting /dev/loop0 =
with ext4 opts=3D&#39;&#39; extra opts=3D&#39;&#39;<br>mke2fs 1.46.5 (30-De=
c-2021)<br>tst_test.c:1452: TINFO: Timeout per run is 0h 05m 00s<br>memcont=
rol04.c:118: TINFO: Child 242775 in leaf_C: Allocating pagecache: 52428800<=
br>memcontrol04.c:118: TINFO: Child 242776 in leaf_D: Allocating pagecache:=
 52428800<br>memcontrol04.c:118: TINFO: Child 242777 in leaf_F: Allocating =
pagecache: 52428800<br>memcontrol04.c:99: TINFO: Child 242778 in trunk_G: A=
llocating anon: 155189248<br>memcontrol04.c:170: TPASS: Expect: (A/B memory=
.current=3D54181888) ~=3D 52428800<br>memcontrol04.c:176: TPASS: Expect: (A=
/B/C memory.current=3D30957568) ~=3D 34603008<br>memcontrol04.c:178: TPASS:=
 Expect: (A/B/D memory.current=3D22282240) ~=3D 17825792<br>memcontrol04.c:=
180: TPASS: Expect: (A/B/E memory.current=3D0) ~=3D 0<br>memcontrol04.c:99:=
 TINFO: Child 242779 in trunk_G: Allocating anon: 174063616<br>memcontrol04=
.c:193: TPASS: Expect: (oom events=3D0) =3D=3D 0<br>memcontrol04.c:196: TPA=
SS: Expect: (low events=3D373) &gt; 0<br>memcontrol04.c:193: TPASS: Expect:=
 (oom events=3D0) =3D=3D 0<br>memcontrol04.c:196: TPASS: Expect: (low event=
s=3D373) &gt; 0<br>memcontrol04.c:193: TPASS: Expect: (oom events=3D0) =3D=
=3D 0<br>memcontrol04.c:198: TPASS: Expect: (low events=3D0) =3D=3D 0<br>me=
mcontrol04.c:193: TPASS: Expect: (oom events=3D0) =3D=3D 0<br>memcontrol04.=
c:198: TFAIL: Expect: (low events=3D370) =3D=3D 0<br></div></div></div></bl=
ockquote><div><br></div><div style=3D"font-size:small">It looks like a logi=
c issue here, as we do alloc_pagecache 50MB</div><div style=3D"font-size:sm=
all">respectively in the leaf_cg[C, D, E, F] and only the &#39;memory.low&#=
39;</div></div></div></blockquote><div><br></div><div><div class=3D"gmail_d=
efault" style=3D"font-size:small">My apologies, the leaf_cg[E] does not hav=
e 50MB page cache</div><div class=3D"gmail_default" style=3D"font-size:smal=
l">allocating, that is the main reason with no memory reclaims happening.</=
div><div class=3D"gmail_default" style=3D"font-size:small">&#39;500MB&#39; =
low boundary obviously=C2=A0overcommitment, so leaf_cg[E] will</div>get the=
 part of parent=E2=80=99s protection proportional to its actual memory</div=
><div>usage.<span class=3D"gmail_default" style=3D"font-size:small"> Howeve=
r, it doesn&#39;t matter for this case,=C2=A0</span>leaf_cg[E] <span class=
=3D"gmail_default" style=3D"font-size:small"></span>can=C2=A0<span class=3D=
"gmail_default" style=3D"font-size:small">get</span></div><div>no event gro=
ws as well.<span class=3D"gmail_default" style=3D"font-size:small"> Because=
 it has no memory consumption at all.</span></div><div><br></div><div><div =
class=3D"gmail_default" style=3D"font-size:small">The fix is still effectiv=
e unless I misread something again:).</div></div><div><br></div><div>=C2=A0=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><d=
iv class=3D"gmail_quote"><div style=3D"font-size:small">of leaf_cg[E] is la=
rge enough (500MB) to avoid triggering low event.</div><div style=3D"font-s=
ize:small">The rest cgroups should all have low events, that kernel behavio=
r</div><div style=3D"font-size:small">is correct.</div><div style=3D"font-s=
ize:small"><br></div><div style=3D"font-size:small">This failure should be =
fix with:</div><div style=3D"font-size:small"><br></div><div style=3D"font-=
size:small">--- a/testcases/kernel/controllers/memcg/memcontrol04.c<br>+++ =
b/testcases/kernel/controllers/memcg/memcontrol04.c<br>@@ -192,7 +192,7 @@ =
static void test_memcg_low(void)<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 TST_EXP_EXPR(oom =3D=3D 0, &quot;(oom events=3D=
%ld) =3D=3D 0&quot;, oom);<br>=C2=A0<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 if (i &lt; E)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (i !=3D E)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TST_EXP_EXPR(low &gt; 0, &quot;(low =
events=3D%ld) &gt; 0&quot;, low)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 else<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TST_EXP_EXPR(low =3D=3D 0, &quot;(low ev=
ents=3D%ld) =3D=3D 0&quot;, low);<br></div></div><div><br></div><div><br></=
div><div><div style=3D"font-size:small">And better to add &quot;leaf_cg%d&q=
uot; print in the output:</div><div style=3D"font-size:small">(to show the =
events from which cgroup)</div><div style=3D"font-size:small"><br></div><sp=
an class=3D"gmail_default" style=3D"font-size:small">=C2=A0 =C2=A0=C2=A0</s=
pan>TST_EXP_EXPR(oom =3D=3D 0, &quot;(leaf_cg%d: oom events=3D%ld) =3D=3D 0=
&quot;, i, oom);<br><br>=09=09<span class=3D"gmail_default" style=3D"font-s=
ize:small"></span>=C2=A0 =C2=A0=C2=A0<span class=3D"gmail_default"></span>i=
f (i !=3D E)</div><div>=09=09=09<span class=3D"gmail_default" style=3D"font=
-size:small"></span>=C2=A0 =C2=A0=C2=A0<span class=3D"gmail_default" style=
=3D"font-size:small"></span>=C2=A0 <span class=3D"gmail_default" style=3D"f=
ont-size:small"></span>=C2=A0 =C2=A0=C2=A0<span class=3D"gmail_default"></s=
pan>=C2=A0=C2=A0<span class=3D"gmail_default"></span><span class=3D"gmail_d=
efault"></span>TST_EXP_EXPR(low &gt; 0, &quot;(leaf_cg%d: low events=3D%ld)=
 &gt; 0&quot;, i, =C2=A0low)</div><div>=09=09<span class=3D"gmail_default" =
style=3D"font-size:small"></span>=C2=A0 =C2=A0=C2=A0<span class=3D"gmail_de=
fault"></span>else</div><div>=09=09=09<span class=3D"gmail_default" style=
=3D"font-size:small"></span>=C2=A0 =C2=A0=C2=A0<span class=3D"gmail_default=
" style=3D"font-size:small"></span>=C2=A0 =C2=A0=C2=A0<span class=3D"gmail_=
default" style=3D"font-size:small"></span>=C2=A0 =C2=A0=C2=A0<span class=3D=
"gmail_default" style=3D"font-size:small"></span>=C2=A0<span class=3D"gmail=
_default"></span><span class=3D"gmail_default"></span><span class=3D"gmail_=
default"></span><span class=3D"gmail_default"></span>TST_EXP_EXPR(low =3D=
=3D 0, &quot;(leaf_cg%d: low events=3D%ld) =3D=3D 0&quot;, i, low);</div><d=
iv><br></div>-- <br><div dir=3D"ltr"><div dir=3D"ltr"><div>Regards,<br></di=
v><div>Li Wang<br></div></div></div></div>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div><div>Li =
Wang<br></div></div></div></div>

--000000000000a9a92105d7a4ac6a--


--===============1740607418==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1740607418==--

