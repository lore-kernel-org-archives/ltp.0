Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BE63C433EF
	for <ltp@archiver.kernel.org>; Tue, 15 Feb 2022 09:50:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 642793CA05E
	for <ltp@archiver.kernel.org>; Tue, 15 Feb 2022 10:50:52 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B37A93C9FEE
 for <ltp@lists.linux.it>; Tue, 15 Feb 2022 10:50:43 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 41329600E32
 for <ltp@lists.linux.it>; Tue, 15 Feb 2022 10:50:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1644918640;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=52RhE/nAUAy0w5bMEImJDac6iPshQ6g+L1JsDV2cwe8=;
 b=E37COMPjdS4ougfMt5XukzDwCeKrFMOg/6662fkYX101V9LJA2fDMX63qq3QwquCoM6qwP
 qmXKighiIAo71J7OOMYm5SVBO9I/AgI3A7R+2f0rDhZYYPAORkQi+mIfadVJQ+hELObYJ/
 qBfoeojJTrLfJB4xy3FjbsW9/YB5ZTE=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-275-IO8DpUuJOWulbFNvzVfjrw-1; Tue, 15 Feb 2022 04:50:35 -0500
X-MC-Unique: IO8DpUuJOWulbFNvzVfjrw-1
Received: by mail-yb1-f199.google.com with SMTP id
 b187-20020a251bc4000000b0061e15c5024fso39469915ybb.4
 for <ltp@lists.linux.it>; Tue, 15 Feb 2022 01:50:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=52RhE/nAUAy0w5bMEImJDac6iPshQ6g+L1JsDV2cwe8=;
 b=BSa143tVh76NjL5gCbp8fbIpZn+BEszg7OSsIOdEy+0LZkw8Foz3ORmBbnnySAaWFu
 8xZtaux/NUSctMk3b+3B7ow8ko5XW5w1NtrfIsYWQ7n9+50TEadrR8CYjMZ4WwuwpBu0
 9i7QPsQpBYMbsZgtYpQbRmnOdGDluUR3LkkQfl1uoVoVhdE/CyLSABT9rXS0jz4Ulmhw
 9sCMwuDVG5AjV2zdqG4LDVsoxiUbci4mQGlvEnPsIjykgYzuNv9yOkXRoG9DGi2DrvRu
 /OuvNMvLRlMo/xBbcLSCAdI4h+3c2wD44U5v1LNl39lfgH9T9tBOwkyAbyHpPBRRw8NN
 kZfw==
X-Gm-Message-State: AOAM530Oeu6Z/7fxnmwwNo0FRlYalCoPRiPoATtzsRDfyFNuIVXAlcXC
 eB7hOwvrD/LmXnFzLO5e8wp68Eknyd/5HydqVXXg8sO3uOW8IefhOYx6jg65/ZuebbJ7wDXrkRz
 fqIn82QmCegKYY+SEUDh1heoyDGc=
X-Received: by 2002:a81:ae45:: with SMTP id g5mr2898882ywk.90.1644918634962;
 Tue, 15 Feb 2022 01:50:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxBW0huTPLhZi9aEY45xYidkRMdsI3XU1mNd/42wfdCIWQzcMEYdq6DHil8/AneMjstci7thH5xw5m2Q+ABeGo=
X-Received: by 2002:a81:ae45:: with SMTP id g5mr2898866ywk.90.1644918634749;
 Tue, 15 Feb 2022 01:50:34 -0800 (PST)
MIME-Version: 1.0
References: <20220214165129.32686-1-mdoucha@suse.cz>
 <CAEemH2c=+3_HBez0Pn6Yyx+v4PXJpwD3HZtPt87BR6AohtKvUw@mail.gmail.com>
 <ec14e0ce-21fe-43bf-a8fb-15b2ccd97c8a@suse.cz> <Ygt0vbPsoGc8gIsy@pevik>
In-Reply-To: <Ygt0vbPsoGc8gIsy@pevik>
From: Li Wang <liwang@redhat.com>
Date: Tue, 15 Feb 2022 17:50:21 +0800
Message-ID: <CAEemH2dh9Q9COFhmTjK-wGWf_W6fYGtLsXRBXBa7qHAkua7dHQ@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] test_children_cleanup.sh: Fix race condition
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
Content-Type: multipart/mixed; boundary="===============0090091599=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0090091599==
Content-Type: multipart/alternative; boundary="000000000000e8b67305d80b76fb"

--000000000000e8b67305d80b76fb
Content-Type: text/plain; charset="UTF-8"

On Tue, Feb 15, 2022 at 5:39 PM Petr Vorel <pvorel@suse.cz> wrote:

> > On 15. 02. 22 5:30, Li Wang wrote:
> > > It doesn't work for all platforms and we can not guarantee how long it
> will
> > > cost before PID 1 reaps zombie process.
>
> > > Also, I just get to know that  Docker does not run processes under a
> > > special init process that properly reaps child processes, so that it is
> > > possible for the container to end up with zombie processes that cause
> > > all sorts of trouble.
>
> > > I even try adding `kill -SIGCHLD 1` but does not work as expected.
>
> > > See CI jobs:
> > >
> https://github.com/wangli5665/ltp/runs/5194270998?check_suite_focus=true
> > > <
> https://mail.google.com/mail/u/1/%E2%80%8Bhttps://github.com/wangli5665/ltp/runs/5194270998?check_suite_focus=true
> >
>
> > > Therefore, I suggest giving a chance to my refined patch V2 :).
>
> > When I was testing the libtest yesterday on a moderately stressed
> > machine, I actually saw the child process still in the R state during
>

That might cause by signal asynchronous processing when the system is under
pressure.


> > the first state check a couple of times. That's why I've added looping
> > with delay.


> > On the other hand I did not see any zombies even after several hundred
> > tries. But I can add a zombie check to my patch a well.
> I'd be for it. As Li noticed, containers behave really differently
> (maybe it'd be faster to debug tests using podman).
>

Right, we have to consider many scenarios:

1.  asynchronous processing signal so that child still in 'R'
2.  the child correctly terminated on bare-metal system
3. allow zombied while running by docker (without a formal init(PID 1)
process)

Especially scenario-3 confused me for quite a while.

@Martin, feel free to send the patch that includes the above.
or I can help summarize these in the commit description.


-- 
Regards,
Li Wang

--000000000000e8b67305d80b76fb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Tue, Feb 15, 2022 at 5:39 PM Petr Vorel &lt;<a h=
ref=3D"mailto:pvorel@suse.cz">pvorel@suse.cz</a>&gt; wrote:<br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">&gt; On 15. 02. 22 5:30, Li Wan=
g wrote:<br>
&gt; &gt; It doesn&#39;t work for all platforms and we can not guarantee ho=
w long it will<br>
&gt; &gt; cost before PID 1 reaps zombie process.<br>
<br>
&gt; &gt; Also, I just get to know that =C2=A0Docker does not run processes=
 under a<br>
&gt; &gt; special init process that properly reaps child processes, so that=
 it is<br>
&gt; &gt; possible for the container to end up with zombie processes that c=
ause<br>
&gt; &gt; all sorts of trouble.<br>
<br>
&gt; &gt; I even try adding `kill -SIGCHLD 1` but does not work as expected=
.<br>
<br>
&gt; &gt; See CI jobs:<br>
&gt; &gt; =C2=A0=C2=A0<a href=3D"https://github.com/wangli5665/ltp/runs/519=
4270998?check_suite_focus=3Dtrue" rel=3D"noreferrer" target=3D"_blank">http=
s://github.com/wangli5665/ltp/runs/5194270998?check_suite_focus=3Dtrue</a><=
br>
&gt; &gt; &lt;<a href=3D"https://mail.google.com/mail/u/1/%E2%80%8Bhttps://=
github.com/wangli5665/ltp/runs/5194270998?check_suite_focus=3Dtrue" rel=3D"=
noreferrer" target=3D"_blank">https://mail.google.com/mail/u/1/%E2%80%8Bhtt=
ps://github.com/wangli5665/ltp/runs/5194270998?check_suite_focus=3Dtrue</a>=
&gt;<br>
<br>
&gt; &gt; Therefore, I suggest giving a chance to my refined patch V2 :).<b=
r>
<br>
&gt; When I was testing the libtest yesterday on a moderately stressed<br>
&gt; machine, I actually saw the child process still in the R state during<=
br></blockquote><div><br></div><div><div class=3D"gmail_default" style=3D"f=
ont-size:small">That might cause by=C2=A0signal asynchronous processing whe=
n the system is under pressure.</div><div class=3D"gmail_default" style=3D"=
font-size:small"></div></div><div>=C2=A0</div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">
&gt; the first state check a couple of times. That&#39;s why I&#39;ve added=
 looping<br>
&gt; with delay.</blockquote><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">
<br>
&gt; On the other hand I did not see any zombies even after several hundred=
<br>
&gt; tries. But I can add a zombie check to my patch a well.<br>
I&#39;d be for it. As Li noticed, containers behave really differently<br>
(maybe it&#39;d be faster to debug tests using podman).<br></blockquote><di=
v><br></div><div><div class=3D"gmail_default" style=3D"font-size:small">Rig=
ht, we have to consider many scenarios:</div><div class=3D"gmail_default" s=
tyle=3D"font-size:small"><br></div><div class=3D"gmail_default" style=3D"fo=
nt-size:small">1.=C2=A0 asynchronous processing signal so that child still=
=C2=A0in &#39;R&#39;=C2=A0</div><div class=3D"gmail_default" style=3D"font-=
size:small">2.=C2=A0 the child correctly terminated on bare-metal system</d=
iv><div class=3D"gmail_default" style=3D"font-size:small">3.  allow zombied=
 while running by docker (without a formal init(PID 1) process)</div><br></=
div><div><div class=3D"gmail_default" style=3D"font-size:small">Especially =
scenario-3 confused me for quite a while.</div><br></div><div><div class=3D=
"gmail_default" style=3D"font-size:small">@Martin, feel free to send the pa=
tch that includes the above.</div><div class=3D"gmail_default" style=3D"fon=
t-size:small">or I can help summarize these in the commit description.</div=
><br></div></div><div><br></div>-- <br><div dir=3D"ltr" class=3D"gmail_sign=
ature"><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></div>=
</div></div>

--000000000000e8b67305d80b76fb--


--===============0090091599==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0090091599==--

