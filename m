Return-Path: <SRS0=ntep=PO=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9623C433EF
	for <ltp@archiver.kernel.org>; Tue, 26 Oct 2021 07:44:59 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CD0A61039
	for <ltp@archiver.kernel.org>; Tue, 26 Oct 2021 07:44:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3CD0A61039
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7368D3C678B
	for <ltp@archiver.kernel.org>; Tue, 26 Oct 2021 09:44:57 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 090CC3C1AEB
 for <ltp@lists.linux.it>; Tue, 26 Oct 2021 09:44:48 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id DE064600728
 for <ltp@lists.linux.it>; Tue, 26 Oct 2021 09:44:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635234285;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qq3rFaZc+vLdTHARxOsH2dm9IYwZWjMvLuuSLh8qB5Q=;
 b=FGhWre4KWcmulgOwAZPzQQ3EF7a8YgTNyc3Eu8BKK9Zr+/bnpYNEGfxtZc6A225a9C6rpJ
 UdG2jOdxBMEPrEJxJFWh/DkLV38Esfc5xbQkdIJyBm6I94sD8hyKwbTmI+CA23NLqB2AlT
 bX/01lIemcWL9WgTtk3mP5De+yK0uZY=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-509-nEBxbMVWNnSwl3XkAqKDbg-1; Tue, 26 Oct 2021 03:44:43 -0400
X-MC-Unique: nEBxbMVWNnSwl3XkAqKDbg-1
Received: by mail-yb1-f200.google.com with SMTP id
 x16-20020a25b910000000b005b6b7f2f91cso21652903ybj.1
 for <ltp@lists.linux.it>; Tue, 26 Oct 2021 00:44:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qq3rFaZc+vLdTHARxOsH2dm9IYwZWjMvLuuSLh8qB5Q=;
 b=MdqxiwrFoNvCvtaPFbdDh445CzVv/0hO1xyqAZ1xi5KZlfIKFfDxQI5MVqqnJz/2cE
 IgNR0faiq1u4a9OL+MMxKcIR0yHt6FSlpVHQJBi9CCGGsg3S6VRt4ctI4S39RGsl+3+p
 NmkM/pE46XwS50gYLqzkiXtVibHAqSwXKGG0gK3JL4WRZWrazHx1cyJm3D0K8r0KRbJs
 hEcXlYNzFF3FFd7QR0CVTkHqYXeZsHD7AgHjLiK1DNZGr6hiQX4/elwqq/krVH55jS2F
 LjiWvCbMI5hPxMdcp+KWdzdioeb1KDkQ8oNp64QtmgHvq9Ljt+PFA6m+xr0G4mFl6157
 0+xA==
X-Gm-Message-State: AOAM532ASz92NFZngH/mINlcwxuUYBgH2KV4ygLxbwlYsoY09cCZV5Em
 1BJ2FiYyIXDTGWR4hbe1ruwry7Zisvi3+jV4WVlEGQooaNvx248zL1C5i8khHprdlt5X+RnERPG
 PEJig7I0lo3GqP/VfrGJ+iWdVayI=
X-Received: by 2002:a5b:912:: with SMTP id a18mr20220106ybq.144.1635234282861; 
 Tue, 26 Oct 2021 00:44:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyTrRTFUserDidaxitTbASnDBSi5nBO2f4+bzlAw2EOhd5dwPttye042FEqLKp56qTQA1m7i5o3Zljmrv9Z3/M=
X-Received: by 2002:a5b:912:: with SMTP id a18mr20220093ybq.144.1635234282632; 
 Tue, 26 Oct 2021 00:44:42 -0700 (PDT)
MIME-Version: 1.0
References: <20211025160134.9283-1-chrubis@suse.cz>
 <20211025160134.9283-7-chrubis@suse.cz>
 <CAEemH2dQcUW5k3Rv-n3=CrznqwpFta3P28QrB0oVZPZH6PyNuw@mail.gmail.com>
 <YXeqxPwYuAVvrMdv@yuki>
In-Reply-To: <YXeqxPwYuAVvrMdv@yuki>
From: Li Wang <liwang@redhat.com>
Date: Tue, 26 Oct 2021 15:44:30 +0800
Message-ID: <CAEemH2eGMNYRDo8drkEesqqBG1HfNAX2O=WPenCa1W0v-S-Lmg@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 6/6] lib: Add tst_set_runtime() & remove
 tst_set_timeout()
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
Content-Type: multipart/mixed; boundary="===============1630902921=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1630902921==
Content-Type: multipart/alternative; boundary="0000000000008a8e9c05cf3ca6a6"

--0000000000008a8e9c05cf3ca6a6
Content-Type: text/plain; charset="UTF-8"

On Tue, Oct 26, 2021 at 3:13 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> > > Rarely there is a need to set the test runtime dynamically, the only
> > > tests in LTP that does this are the timer tests that can get two
> > > parameters, number of iterations and sleep time, and the test runtime
> is
> > > close to the multiplication of these two.
> > >
> > > It's still cleaner to set the runtime and let the test library figure
> > > out the timeout in this case.
> > >
> >
> > If so, should we consider to hinden the .timeout in struct tst_test
> > to prevent users from changing it?
>
> If we decide to apply this patchset that would be logical end result.
> There are only a few .timeout = foo left in the codebase after this
> patchset that either disable timeout for the few unpredictable cases or
> shorten it to make the test timeout faster if it gets stuck. We can deal
> with these by making the .max_runtime accept -1 and by shortening the
> default timeout considerably.
>

Yes, that should be great.

After a quick reviewing the whole patchset, I feel that .timeout is
redundant since .max_runtime can do more thing to totally replace
it by the end.

----------------

Btw, it looks weird to simply double the runtime by plus MAX(10u, runtime)
in the runtime_to_timeout, I guess you probably just wanna another
10sec for some reclaiming work.

And the .max_runtime is also maximal time per test iteration,
but from the output below misleading me to think it is for the
whole test time.

See:

# LTP_TIMEOUT_MUL=1 ./pty03
tst_test.c:1376: TINFO: Test max runtime 360s
tst_test.c:1371: TINFO: Timeout per run is 0h 12m 00s
....



>
> > IIRC, we currently have ".timeout == -1" to disable test timed
> > out in unsure situation, e.g some OOM tests. But in this patch,
> > I saw you remove that, but not handle it in tst_set_runtime.
>
> Ah, right, I've removed the timeout == -1 handling by mistake. I wanted
> to keep it working after this patchset as well until a follow up
> patchset deals with the rest of the tests that set the .timeout.
>

Sound good.

-- 
Regards,
Li Wang

--0000000000008a8e9c05cf3ca6a6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Tue, Oct 26, 2021 at 3:13 PM Cyril Hrubis &lt;<a=
 href=3D"mailto:chrubis@suse.cz">chrubis@suse.cz</a>&gt; wrote:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">Hi!<br>
&gt; &gt; Rarely there is a need to set the test runtime dynamically, the o=
nly<br>
&gt; &gt; tests in LTP that does this are the timer tests that can get two<=
br>
&gt; &gt; parameters, number of iterations and sleep time, and the test run=
time is<br>
&gt; &gt; close to the multiplication of these two.<br>
&gt; &gt;<br>
&gt; &gt; It&#39;s still cleaner to set the runtime and let the test librar=
y figure<br>
&gt; &gt; out the timeout in this case.<br>
&gt; &gt;<br>
&gt; <br>
&gt; If so, should we consider to hinden the .timeout in struct tst_test<br=
>
&gt; to prevent users from changing it?<br>
<br>
If we decide to apply this patchset that would be logical end result.<br>
There are only a few .timeout =3D foo left in the codebase after this<br>
patchset that either disable timeout for the few unpredictable cases or<br>
shorten it to make the test timeout faster if it gets stuck. We can deal<br=
>
with these by making the .max_runtime accept -1 and by shortening the<br>
default timeout considerably.<br></blockquote><div><br></div><div><div clas=
s=3D"gmail_default" style=3D"font-size:small">Yes, that should be great.</d=
iv><div class=3D"gmail_default" style=3D"font-size:small"><br></div><div cl=
ass=3D"gmail_default" style=3D"font-size:small">After a quick reviewing the=
 whole patchset, I feel that .timeout is</div><div class=3D"gmail_default" =
style=3D"font-size:small">redundant since .max_runtime can do more thing to=
 totally replace</div><div class=3D"gmail_default" style=3D"font-size:small=
">it by the end.</div><div class=3D"gmail_default" style=3D"font-size:small=
"><br></div><div class=3D"gmail_default" style=3D"font-size:small">--------=
--------</div><div class=3D"gmail_default" style=3D"font-size:small"><br></=
div><div class=3D"gmail_default" style=3D"font-size:small">Btw, it looks we=
ird to simply double the runtime by plus MAX(10u, runtime)</div><div class=
=3D"gmail_default" style=3D"font-size:small">in the=C2=A0runtime_to_timeout=
, I guess you probably just wanna another</div><div class=3D"gmail_default"=
 style=3D"font-size:small">10sec for some reclaiming work.</div><div class=
=3D"gmail_default" style=3D"font-size:small"><br></div><div class=3D"gmail_=
default" style=3D"font-size:small">And the .max_runtime is also maximal tim=
e per test iteration,</div><div class=3D"gmail_default" style=3D"font-size:=
small">but from the output below misleading me to think it is for the</div>=
<div class=3D"gmail_default" style=3D"font-size:small">whole test time.</di=
v><div class=3D"gmail_default" style=3D"font-size:small"><br></div><div cla=
ss=3D"gmail_default" style=3D"font-size:small">See:</div><div class=3D"gmai=
l_default" style=3D"font-size:small"><br></div><div class=3D"gmail_default"=
 style=3D"font-size:small"># LTP_TIMEOUT_MUL=3D1 ./pty03 <br>tst_test.c:137=
6: TINFO: Test max runtime 360s<br>tst_test.c:1371: TINFO: Timeout per run =
is 0h 12m 00s<br></div><div class=3D"gmail_default" style=3D"font-size:smal=
l">....</div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">
<br>
&gt; IIRC, we currently have &quot;.timeout =3D=3D -1&quot; to disable test=
 timed<br>
&gt; out in unsure situation, e.g some OOM tests. But in this patch,<br>
&gt; I saw you remove that, but not handle it in tst_set_runtime.<br>
<br>
Ah, right, I&#39;ve removed the timeout =3D=3D -1 handling by mistake. I wa=
nted<br>
to keep it working after this patchset as well until a follow up<br>
patchset deals with the rest of the tests that set the .timeout.<br></block=
quote><div><br></div><div><div class=3D"gmail_default" style=3D"font-size:s=
mall">Sound good.=C2=A0</div></div><div>=C2=A0</div></div>-- <br><div dir=
=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div>=
<div>Li Wang<br></div></div></div></div>

--0000000000008a8e9c05cf3ca6a6--


--===============1630902921==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1630902921==--

