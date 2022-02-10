Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0797BC433EF
	for <ltp@archiver.kernel.org>; Thu, 10 Feb 2022 06:24:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E98723C9DE2
	for <ltp@archiver.kernel.org>; Thu, 10 Feb 2022 07:24:26 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E2A5B3C9AE7
 for <ltp@lists.linux.it>; Thu, 10 Feb 2022 07:24:17 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id BF7DA600E4F
 for <ltp@lists.linux.it>; Thu, 10 Feb 2022 07:24:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1644474255;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/0aiSNr8JOCuiAeclZZQ8rgsfM63rPiVqy6kbVlK+uM=;
 b=DONoJPkX6Ss2kGCIpoBDdwG5fkd0pwGHypOJHQwiWePV6A6gIKKWNI1JXnSMrECBT78QG+
 0StT/UuFnDPPbhV2WKQy+KgAhLzFjeTJSoXGkeGQ+fwvZpXdcV+WibZOjIijN2OPOoWrB2
 nwedFgjRQM7EficLgTYtmM/N/7DGxfo=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-630-3krOQZozOTuUW9gAU77CyA-1; Thu, 10 Feb 2022 01:24:13 -0500
X-MC-Unique: 3krOQZozOTuUW9gAU77CyA-1
Received: by mail-yb1-f199.google.com with SMTP id
 s73-20020a25aa4f000000b0061d764d3c13so10199690ybi.1
 for <ltp@lists.linux.it>; Wed, 09 Feb 2022 22:24:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=VFgCeq1vaz/6H7KQy7lipsGDfLLdU5zH89rkGfZ7znw=;
 b=akl2uE3OJmZaruN/YrK636V2HX+2sBZCkqrP3HQPAwenidDKFkSsmPvoXRhI1HrZVn
 l9k8N0FKtikHTl3oPzTJ9xyaxEhTQI/1IEHucf7o57+R5QS3m+O0u2TF3+cDbuRJZVT3
 pTEYijWVAFRXxsz2IryOVjg5KEVTHy9tXuTFQbaMTQjncwFy8CkQwaL+olfTu5AfRLEM
 7U4G1wMt47KC0bRpRNP+Q7JCdS+uycPGESYxAi7NRVtbkwVBsYhSgES4pS8OlCYbeXX1
 VEcibnre+kDiZCYZ4gZogTVkN9peXLaBV8GLlQfNp1NvNUTn5a5PI3gjwajQIHPFRbgm
 U0+g==
X-Gm-Message-State: AOAM530Jpnms1Q5JKG2iRXJ+GUdraVWTwiPNhsFbcFgB8wwEQAEpKU/f
 Y9TVrCDsAJ/o9AjuvVwOOaOUq+YbYPnxowkA3iPJ2hLhDv9Agq5GfPlyTWUYMFphXRUJZtn9dPP
 1tU+WBd0Sd5eJVjdW9ZK8fZ66fdk=
X-Received: by 2002:a25:bf8b:: with SMTP id l11mr5767594ybk.248.1644474253006; 
 Wed, 09 Feb 2022 22:24:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwbLz5IuDkXxU04S5JtyynMM2mg+BgOWpxcmaOusrqDARbzfpzI6Sm4Qn3qNa2nC/CxGUK/qj4Q+A2A1F+EtFA=
X-Received: by 2002:a25:bf8b:: with SMTP id l11mr5767587ybk.248.1644474252771; 
 Wed, 09 Feb 2022 22:24:12 -0800 (PST)
MIME-Version: 1.0
References: <20220208140322.6842-1-rpalethorpe@suse.com>
 <20220208140322.6842-4-rpalethorpe@suse.com>
 <CAEemH2e2btUUYqj69nWGpXC4B43Dg7+y8-m2udsNCjtZr6s7Tg@mail.gmail.com>
In-Reply-To: <CAEemH2e2btUUYqj69nWGpXC4B43Dg7+y8-m2udsNCjtZr6s7Tg@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Thu, 10 Feb 2022 14:23:57 +0800
Message-ID: <CAEemH2fQgURKROaVH7ZNszpBonGwZn6fNbN4XC8FPCH98J2+VA@mail.gmail.com>
To: Richard Palethorpe <rpalethorpe@suse.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
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
Content-Type: multipart/mixed; boundary="===============0978066891=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0978066891==
Content-Type: multipart/alternative; boundary="000000000000add82405d7a3ffb8"

--000000000000add82405d7a3ffb8
Content-Type: text/plain; charset="UTF-8"

On Wed, Feb 9, 2022 at 7:05 PM Li Wang <liwang@redhat.com> wrote:


> Btw, there are some TFAILs from my manual run.
> (I will look into that try to figure it out tomorrow)
>
> tst_test.c:1521: TINFO: Testing on ext4
> tst_test.c:996: TINFO: Formatting /dev/loop0 with ext4 opts='' extra
> opts=''
> mke2fs 1.46.5 (30-Dec-2021)
> tst_test.c:1452: TINFO: Timeout per run is 0h 05m 00s
> memcontrol04.c:118: TINFO: Child 242775 in leaf_C: Allocating pagecache:
> 52428800
> memcontrol04.c:118: TINFO: Child 242776 in leaf_D: Allocating pagecache:
> 52428800
> memcontrol04.c:118: TINFO: Child 242777 in leaf_F: Allocating pagecache:
> 52428800
> memcontrol04.c:99: TINFO: Child 242778 in trunk_G: Allocating anon:
> 155189248
> memcontrol04.c:170: TPASS: Expect: (A/B memory.current=54181888) ~=
> 52428800
> memcontrol04.c:176: TPASS: Expect: (A/B/C memory.current=30957568) ~=
> 34603008
> memcontrol04.c:178: TPASS: Expect: (A/B/D memory.current=22282240) ~=
> 17825792
> memcontrol04.c:180: TPASS: Expect: (A/B/E memory.current=0) ~= 0
> memcontrol04.c:99: TINFO: Child 242779 in trunk_G: Allocating anon:
> 174063616
> memcontrol04.c:193: TPASS: Expect: (oom events=0) == 0
> memcontrol04.c:196: TPASS: Expect: (low events=373) > 0
> memcontrol04.c:193: TPASS: Expect: (oom events=0) == 0
> memcontrol04.c:196: TPASS: Expect: (low events=373) > 0
> memcontrol04.c:193: TPASS: Expect: (oom events=0) == 0
> memcontrol04.c:198: TPASS: Expect: (low events=0) == 0
> memcontrol04.c:193: TPASS: Expect: (oom events=0) == 0
> memcontrol04.c:198: TFAIL: Expect: (low events=370) == 0
>

It looks like a logic issue here, as we do alloc_pagecache 50MB
respectively in the leaf_cg[C, D, E, F] and only the 'memory.low'
of leaf_cg[E] is large enough (500MB) to avoid triggering low event.
The rest cgroups should all have low events, that kernel behavior
is correct.

This failure should be fix with:

--- a/testcases/kernel/controllers/memcg/memcontrol04.c
+++ b/testcases/kernel/controllers/memcg/memcontrol04.c
@@ -192,7 +192,7 @@ static void test_memcg_low(void)

                TST_EXP_EXPR(oom == 0, "(oom events=%ld) == 0", oom);

-               if (i < E)
+               if (i != E)
                        TST_EXP_EXPR(low > 0, "(low events=%ld) > 0", low)
                else
                        TST_EXP_EXPR(low == 0, "(low events=%ld) == 0",
low);


And better to add "leaf_cg%d" print in the output:
(to show the events from which cgroup)

    TST_EXP_EXPR(oom == 0, "(leaf_cg%d: oom events=%ld) == 0", i, oom);

    if (i != E)
            TST_EXP_EXPR(low > 0, "(leaf_cg%d: low events=%ld) > 0", i,
 low)
    else
             TST_EXP_EXPR(low == 0, "(leaf_cg%d: low events=%ld) == 0", i,
low);

-- 
Regards,
Li Wang

--000000000000add82405d7a3ffb8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Wed, Feb 9, 2022 at 7:05 PM Li Wang &lt;<a href=
=3D"mailto:liwang@redhat.com">liwang@redhat.com</a>&gt; wrote:<br></div><di=
v>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D=
"ltr"><div class=3D"gmail_quote"><div style=3D"font-size:small"></div><div =
style=3D"font-size:small">Btw, there are some TFAILs from my manual run.=C2=
=A0</div><div style=3D"font-size:small">(I will look into that try to figur=
e it out tomorrow)</div><div style=3D"font-size:small"><br></div><div style=
=3D"font-size:small">tst_test.c:1521: TINFO: Testing on ext4<br>tst_test.c:=
996: TINFO: Formatting /dev/loop0 with ext4 opts=3D&#39;&#39; extra opts=3D=
&#39;&#39;<br>mke2fs 1.46.5 (30-Dec-2021)<br>tst_test.c:1452: TINFO: Timeou=
t per run is 0h 05m 00s<br>memcontrol04.c:118: TINFO: Child 242775 in leaf_=
C: Allocating pagecache: 52428800<br>memcontrol04.c:118: TINFO: Child 24277=
6 in leaf_D: Allocating pagecache: 52428800<br>memcontrol04.c:118: TINFO: C=
hild 242777 in leaf_F: Allocating pagecache: 52428800<br>memcontrol04.c:99:=
 TINFO: Child 242778 in trunk_G: Allocating anon: 155189248<br>memcontrol04=
.c:170: TPASS: Expect: (A/B memory.current=3D54181888) ~=3D 52428800<br>mem=
control04.c:176: TPASS: Expect: (A/B/C memory.current=3D30957568) ~=3D 3460=
3008<br>memcontrol04.c:178: TPASS: Expect: (A/B/D memory.current=3D22282240=
) ~=3D 17825792<br>memcontrol04.c:180: TPASS: Expect: (A/B/E memory.current=
=3D0) ~=3D 0<br>memcontrol04.c:99: TINFO: Child 242779 in trunk_G: Allocati=
ng anon: 174063616<br>memcontrol04.c:193: TPASS: Expect: (oom events=3D0) =
=3D=3D 0<br>memcontrol04.c:196: TPASS: Expect: (low events=3D373) &gt; 0<br=
>memcontrol04.c:193: TPASS: Expect: (oom events=3D0) =3D=3D 0<br>memcontrol=
04.c:196: TPASS: Expect: (low events=3D373) &gt; 0<br>memcontrol04.c:193: T=
PASS: Expect: (oom events=3D0) =3D=3D 0<br>memcontrol04.c:198: TPASS: Expec=
t: (low events=3D0) =3D=3D 0<br>memcontrol04.c:193: TPASS: Expect: (oom eve=
nts=3D0) =3D=3D 0<br>memcontrol04.c:198: TFAIL: Expect: (low events=3D370) =
=3D=3D 0<br></div></div></div></blockquote><div><br></div><div class=3D"gma=
il_default" style=3D"font-size:small">It looks like a logic issue here, as =
we do alloc_pagecache 50MB</div><div class=3D"gmail_default" style=3D"font-=
size:small">respectively in the leaf_cg[C, D, E, F] and only the &#39;memor=
y.low&#39;</div><div class=3D"gmail_default" style=3D"font-size:small">of l=
eaf_cg[E] is large enough (500MB) to avoid triggering low event.</div><div =
class=3D"gmail_default" style=3D"font-size:small">The rest cgroups should a=
ll have low events, that kernel behavior</div><div class=3D"gmail_default" =
style=3D"font-size:small">is correct.</div><div class=3D"gmail_default" sty=
le=3D"font-size:small"><br></div><div class=3D"gmail_default" style=3D"font=
-size:small">This failure should be fix with:</div><div class=3D"gmail_defa=
ult" style=3D"font-size:small"><br></div><div class=3D"gmail_default" style=
=3D"font-size:small">--- a/testcases/kernel/controllers/memcg/memcontrol04.=
c<br>+++ b/testcases/kernel/controllers/memcg/memcontrol04.c<br>@@ -192,7 +=
192,7 @@ static void test_memcg_low(void)<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TST_EXP_EXPR(oom =3D=3D 0, &quot;(oom e=
vents=3D%ld) =3D=3D 0&quot;, oom);<br>=C2=A0<br>- =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 if (i &lt; E)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 if (i !=3D E)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TST_EXP_EXPR(low &gt; 0, &quo=
t;(low events=3D%ld) &gt; 0&quot;, low)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 else<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TST_EXP_EXPR(low =3D=3D 0, &quot;=
(low events=3D%ld) =3D=3D 0&quot;, low);<br></div></div><div><br></div><div=
><br></div><div><div class=3D"gmail_default" style=3D"font-size:small">And =
better to add &quot;leaf_cg%d&quot; print in the output:</div><div class=3D=
"gmail_default" style=3D"font-size:small">(to show the events from which cg=
roup)</div><div class=3D"gmail_default" style=3D"font-size:small"><br></div=
><span class=3D"gmail_default" style=3D"font-size:small">=C2=A0 =C2=A0=C2=
=A0</span>TST_EXP_EXPR(oom =3D=3D 0, &quot;(leaf_cg%d: oom events=3D%ld) =
=3D=3D 0&quot;, i, oom);<br><br>=09=09<span class=3D"gmail_default" style=
=3D"font-size:small"></span>=C2=A0 =C2=A0=C2=A0<span class=3D"gmail_default=
"></span>if (i !=3D E)</div><div>=09=09=09<span class=3D"gmail_default" sty=
le=3D"font-size:small"></span>=C2=A0 =C2=A0=C2=A0<span class=3D"gmail_defau=
lt" style=3D"font-size:small"></span>=C2=A0 <span class=3D"gmail_default" s=
tyle=3D"font-size:small"></span>=C2=A0 =C2=A0=C2=A0<span class=3D"gmail_def=
ault"></span>=C2=A0=C2=A0<span class=3D"gmail_default"></span><span class=
=3D"gmail_default"></span>TST_EXP_EXPR(low &gt; 0, &quot;(leaf_cg%d: low ev=
ents=3D%ld) &gt; 0&quot;, i, =C2=A0low)</div><div>=09=09<span class=3D"gmai=
l_default" style=3D"font-size:small"></span>=C2=A0 =C2=A0=C2=A0<span class=
=3D"gmail_default"></span>else</div><div>=09=09=09<span class=3D"gmail_defa=
ult" style=3D"font-size:small"></span>=C2=A0 =C2=A0=C2=A0<span class=3D"gma=
il_default" style=3D"font-size:small"></span>=C2=A0 =C2=A0=C2=A0<span class=
=3D"gmail_default" style=3D"font-size:small"></span>=C2=A0 =C2=A0=C2=A0<spa=
n class=3D"gmail_default" style=3D"font-size:small"></span>=C2=A0<span clas=
s=3D"gmail_default"></span><span class=3D"gmail_default"></span><span class=
=3D"gmail_default"></span><span class=3D"gmail_default"></span>TST_EXP_EXPR=
(low =3D=3D 0, &quot;(leaf_cg%d: low events=3D%ld) =3D=3D 0&quot;, i, low);=
</div><div><br></div>-- <br><div dir=3D"ltr" class=3D"gmail_signature"><div=
 dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></div></div></div=
>

--000000000000add82405d7a3ffb8--


--===============0978066891==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0978066891==--

