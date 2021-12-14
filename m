Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EE56C433F5
	for <ltp@archiver.kernel.org>; Tue, 14 Dec 2021 06:46:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1CBC63C8C69
	for <ltp@archiver.kernel.org>; Tue, 14 Dec 2021 07:46:51 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E41B33C104E
 for <ltp@lists.linux.it>; Tue, 14 Dec 2021 07:46:41 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id DC1A86010BB
 for <ltp@lists.linux.it>; Tue, 14 Dec 2021 07:46:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1639464399;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4Ld8WAKhQKk4DQfaVovbjNQlUg7zpOwVilCG7BdekII=;
 b=I2/YI/T6m3rxi0n8zIsCp/FUbHo0EWA4BagH8RaRihEZCWf0Q+PIS2BQHNWk45Xy5nrCpM
 LVVrfK1cLDZGbso3fMpsOfunHLy5cVFpz0B/cnbW5RQbHkms9+bO0h1iUnZnpplgp1KgFR
 m+mPjCwUuUGfxxw8HFE4nLkZpm0h31Q=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-186-fVzY5SzdPxiBsD8Qh0JxqA-1; Tue, 14 Dec 2021 01:46:37 -0500
X-MC-Unique: fVzY5SzdPxiBsD8Qh0JxqA-1
Received: by mail-yb1-f199.google.com with SMTP id
 e131-20020a25d389000000b005fb5e6eb757so34876883ybf.22
 for <ltp@lists.linux.it>; Mon, 13 Dec 2021 22:46:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4Ld8WAKhQKk4DQfaVovbjNQlUg7zpOwVilCG7BdekII=;
 b=1l55cq0a0kcsALULNs9HANr2EAT2nELRL1Op1gOpuLg9QlLbKj4ATzDcIcn7zOQ0v6
 mRp/3CUtWCE8jFOLh6V2+49X9juCmpP99EIoypvT2W1h+KzEL6IFvQOJ2GmQhtb4LXj4
 +7Rm2j34ti0snRKZuL3lT9I0KOUMoyGSldQtdg7entybUprAlyAYQkv8x9Yg7Emm8Jdz
 UHL9ecoXf4BEWDPc+kVVjCr58BT8uxOUFIXRTufx10jBd2FX4K0PK8ooWX0UfvebLYAl
 6Dq547LYpualPFht0fUUt1Iw7nnOS2xcVtygRQOxv3kcTy4jWebhcmwy/GCn5VYpeMWr
 pxnA==
X-Gm-Message-State: AOAM532JFbeH2y0ivycSdaxIoJ87T3ZCIHMZm1f/TGtH1CsY3iwSAmHB
 WSjTuPOfYcG4ZOzD4/2crDrR2gxTZ8dyl5N48BFmRGrhRmHC2uvpma5KiS7AkiGE5657MyxZYgs
 DJZhNZxAzW1ACL3LmSGQ2vXoRrNw=
X-Received: by 2002:a25:9bc9:: with SMTP id w9mr3764815ybo.398.1639464397368; 
 Mon, 13 Dec 2021 22:46:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw81aawr23xUcSw0dtyDmB1LSBtcout6fOtMZPFnBqo3R7F5yysi1RuJQR3VuZAX/xsk06RSA68xBCZJXrSYmc=
X-Received: by 2002:a25:9bc9:: with SMTP id w9mr3764799ybo.398.1639464397138; 
 Mon, 13 Dec 2021 22:46:37 -0800 (PST)
MIME-Version: 1.0
References: <CAEemH2d+-rqscLPdn8q0AEkKaCSkCZ-pET_E=eWWN7Z=aB1k0w@mail.gmail.com>
 <CAASaF6zRCAYo3f4bRc+mxKHnprwtworq-fCif81ECZUWawumbQ@mail.gmail.com>
 <85404e01-f8f0-7209-8ce1-9e8a2a416e86@suse.cz> <Ybdxt/KBUQ6ZKHmY@yuki>
 <771fb3e4-06be-1d08-9036-b35feed14128@suse.cz>
In-Reply-To: <771fb3e4-06be-1d08-9036-b35feed14128@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Tue, 14 Dec 2021 14:46:21 +0800
Message-ID: <CAEemH2epi98pXBj358maCnCpQO+7AX9uWu0QWXqi8ZBP8unQHA@mail.gmail.com>
To: Martin Doucha <mdoucha@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC] enable OOM protection for the library and test
 process?
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
Content-Type: multipart/mixed; boundary="===============2027239921=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============2027239921==
Content-Type: multipart/alternative; boundary="00000000000003893605d3158db6"

--00000000000003893605d3158db6
Content-Type: text/plain; charset="UTF-8"

On Tue, Dec 14, 2021 at 12:59 AM Martin Doucha <mdoucha@suse.cz> wrote:

> On 13. 12. 21 17:15, Cyril Hrubis wrote:
> > Hi!
> >> I'm afraid it won't be that easy. The main cause of OOM killer going
> >> postal and killing processes with tiny memory footprint is that a
> >> process executing the mlock() syscall cannot be targeted by OOM killer
> >> at all. That's a known issue in the kernel with no easy fix.
> >
> > This is only single test out of at least 10 that can trigger OOM, right?
>
> All 5 oom* tests in the mm runfile have mlock() subtest. All of them can
> end up killing the whole userspace by accident. And all of them
> regularly do so in our automated test system.
>

It is possible, but avoid enabling the OOM protection on lib-process
can miss this panic? I guess no, because lib-process is not eaten
too much memory and there are many other processes that still have
the big potential to be killed.

So we might shouldn't believe protect main or lib process will add the
possibility to kill PID 1, in other words, do protection or not, the
panic/bug
can't be perfectly avoided, so why not do it? Or I have something
that misunderstands you here.

-- 
Regards,
Li Wang

--00000000000003893605d3158db6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Tue, Dec 14, 2021 at 12:59 AM Martin Doucha &lt;=
<a href=3D"mailto:mdoucha@suse.cz">mdoucha@suse.cz</a>&gt; wrote:<br></div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">On 13. 12. 21 17:15, Cyri=
l Hrubis wrote:<br>
&gt; Hi!<br>
&gt;&gt; I&#39;m afraid it won&#39;t be that easy. The main cause of OOM ki=
ller going<br>
&gt;&gt; postal and killing processes with tiny memory footprint is that a<=
br>
&gt;&gt; process executing the mlock() syscall cannot be targeted by OOM ki=
ller<br>
&gt;&gt; at all. That&#39;s a known issue in the kernel with no easy fix.<b=
r>
&gt; <br>
&gt; This is only single test out of at least 10 that can trigger OOM, righ=
t?<br>
<br>
All 5 oom* tests in the mm runfile have mlock() subtest. All of them can<br=
>
end up killing the whole userspace by accident. And all of them<br>
regularly do so in our automated test system.<br></blockquote><div><br></di=
v><div><div class=3D"gmail_default" style=3D"font-size:small">It is possibl=
e, but=C2=A0avoid enabling the OOM protection on lib-process</div><div clas=
s=3D"gmail_default" style=3D"font-size:small">can miss this panic? I guess =
no, because lib-process is not eaten</div><div class=3D"gmail_default" styl=
e=3D"font-size:small">too much memory and there are many other processes th=
at still have</div><div class=3D"gmail_default" style=3D"font-size:small">t=
he big potential to be killed.</div><div class=3D"gmail_default" style=3D"f=
ont-size:small"><br></div></div><div class=3D"gmail_default" style=3D"font-=
size:small">So we might shouldn&#39;t believe=C2=A0protect main or lib proc=
ess will add the</div><div class=3D"gmail_default" style=3D"font-size:small=
">possibility to kill PID 1, in other words, do protection or not, the pani=
c/bug</div><div class=3D"gmail_default" style=3D"font-size:small">can&#39;t=
 be perfectly avoided, so why not do it? Or I have something</div><div clas=
s=3D"gmail_default" style=3D"font-size:small">that misunderstands you here.=
</div></div><div><br></div>-- <br><div dir=3D"ltr" class=3D"gmail_signature=
"><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></div></div=
></div>

--00000000000003893605d3158db6--


--===============2027239921==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============2027239921==--

