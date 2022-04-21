Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F422C433F5
	for <ltp@archiver.kernel.org>; Thu, 21 Apr 2022 06:37:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5BED03CA6C9
	for <ltp@archiver.kernel.org>; Thu, 21 Apr 2022 08:37:11 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BDAC23C6934
 for <ltp@lists.linux.it>; Thu, 21 Apr 2022 08:37:00 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B3846600909
 for <ltp@lists.linux.it>; Thu, 21 Apr 2022 08:36:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1650523018;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+3EfUude5sMsp08omVnSey6BHu3dIQdGRHjluQYGkIU=;
 b=ZiLQq6BBDR11/wMMP1jHhFEzXOHdfP0oAY7/dyCZSgebFsDFO23QguvInAJ2ICLjyKxRnh
 uHqhBfb9tqeM63jYbTXWiqC/G1UbJLSH9rf2clAvyi3tODkQ/uPoKPcFLjOyvq6pgfhxNL
 SieLHuEWJ0DA6aUKPHwekxXaN+lWm20=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-507-s4UjIIlqNI6Y3cq67E5Hmw-1; Thu, 21 Apr 2022 02:36:56 -0400
X-MC-Unique: s4UjIIlqNI6Y3cq67E5Hmw-1
Received: by mail-yb1-f200.google.com with SMTP id
 i5-20020a258b05000000b006347131d40bso3523537ybl.17
 for <ltp@lists.linux.it>; Wed, 20 Apr 2022 23:36:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+3EfUude5sMsp08omVnSey6BHu3dIQdGRHjluQYGkIU=;
 b=gCGZAG4KrhoKYU5c6EUkB/zoiFsPFQwIZ4EZ2ovFMPtM2O7hK/T86GUreIgdRc3LiV
 2uy9sregWRQllBg5HUVK+tRjuJQzfK+CP87Ibtg71sBZZxxuUa0NTRHEK070llKMfoHc
 YmByhnbY1OVs9td1/yq/0+c9+2wylo7U2Y03OkBmKnTo6qtGs4Sk6uVmhd+AE7ivfywG
 brkki+rQlnNHiygjVcin0eHOkmMevFBGqfjrHLQtStQamnx1CemwCJFc2Gdwvdnf8EGp
 9dm7vaWW3PK4f1ziDMOHVv/oubqpGisuI8IRSdse1IZTVIZg5asEmBaEzIFFq1X7t7HS
 hnyQ==
X-Gm-Message-State: AOAM533Mh8yk39mOFoxhjij2l7HiR7EP808tBoMMemQ0hIXIGlzDSdfX
 6WtY/99EI+8OSEZXLzRkwBI9cMsFcqMYRoH5+fjz/0oLblQavhej3FrhjCQmzwrgCLpxD7uW/1K
 4Jv0+lQN9EVULcu2dxCY6BulMypk=
X-Received: by 2002:a81:af63:0:b0:2ec:e6a:7281 with SMTP id
 x35-20020a81af63000000b002ec0e6a7281mr25291373ywj.170.1650523015786; 
 Wed, 20 Apr 2022 23:36:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx8gAv2TtsjIwDtgr8yZSqGK5CMt6Kg2CZrkFtYV05fevohWXecO/E/xX3njZO0vkMRcFYCVfJbTaoNSVzN70A=
X-Received: by 2002:a81:af63:0:b0:2ec:e6a:7281 with SMTP id
 x35-20020a81af63000000b002ec0e6a7281mr25291353ywj.170.1650523015135; Wed, 20
 Apr 2022 23:36:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220420114720.1463473-1-liwang@redhat.com>
 <Yl/3FchHScs8YS6c@yuki>
 <CAEemH2dTCBpynB3wj_8eTVvvJR_V4fGPZNvt_35noqdykKi52g@mail.gmail.com>
 <YmAB++5hoIjNwMkB@yuki>
In-Reply-To: <YmAB++5hoIjNwMkB@yuki>
From: Li Wang <liwang@redhat.com>
Date: Thu, 21 Apr 2022 14:36:41 +0800
Message-ID: <CAEemH2dH-ROGcRbgjtbWC6VO5x+sHB7JrpDqFs7Qveys6U_7Ng@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] ioctl09: wait for udevd complete the uevent
 handling
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
Content-Type: multipart/mixed; boundary="===============1451633922=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1451633922==
Content-Type: multipart/alternative; boundary="00000000000002dc7905dd2456d2"

--00000000000002dc7905dd2456d2
Content-Type: text/plain; charset="UTF-8"

On Wed, Apr 20, 2022 at 8:50 PM Cyril Hrubis <chrubis@suse.cz> wrote:


>
> > Note, the `udevadm settle` uses 180s as default timeout as well,
> > but it can work, I will look into udevadm.c to see if that does
> > something additional besides the waiting.
>
> I guess that the difference is that when we wait on a socket actively we
> return sooner than with the exp backoff. By definition the exp backoff
> may wait for twice as long as the udevadm and because of that the test
> may actually timeout because we waited just a little bit longer.
>

That's right, I overlooked that exp backoff time is longer than the set
value.



>
> > If so, we might need to remove the TST_RETRY_FN_EXP_BACKOFF
> > from this test.
>
> That would be valid option, remove the exp backoff and wait activelly.
>

Yes, wait actively and confirm event handling is completed.
(`udevadm settle` is the direct way I can think of now)



> Btw we already have an infrastructure for matching kernel event uevents
> in the kernel/uevent/ directory. If we split the uevent.h there into a
> header and libs/ltpuevent/ we could simply wait for the event by filling
> in the uevent_desc structure and calling wait_for_uevents().
>

Good to know this, I have looked through that but am afraid it can't
fully satisfy our requirements.

Because the wait_for_uevents is only falling into an infinite loop
and returns if detecting the expected UEVENT (which was sent
from the kernel function kobject_uevent_env).

The key point here is, we have to confirm `udevd` completed the UEVENT
handling, otherwise only detecting event exists is not enough, there is
still
potentially get the race condition again if the event queue there.


-- 
Regards,
Li Wang

--00000000000002dc7905dd2456d2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Wed, Apr 20, 2022 at 8:50 PM Cyril Hrubis &lt;<a=
 href=3D"mailto:chrubis@suse.cz">chrubis@suse.cz</a>&gt; wrote:<br></div><d=
iv>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"> <br>
&gt; Note, the `udevadm settle` uses 180s as default timeout as well,<br>
&gt; but it can work, I will look into udevadm.c to see if that does<br>
&gt; something additional besides the waiting.<br>
<br>
I guess that the difference is that when we wait on a socket actively we<br=
>
return sooner than with the exp backoff. By definition the exp backoff<br>
may wait for twice as long as the udevadm and because of that the test<br>
may actually timeout because we waited just a little bit longer.<br></block=
quote><div><br></div><div><div class=3D"gmail_default" style=3D"font-size:s=
mall">That&#39;s right, I overlooked that exp backoff time is longer than t=
he set value.</div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">
<br>
&gt; If so, we might need to remove the TST_RETRY_FN_EXP_BACKOFF<br>
&gt; from this test.<br>
<br>
That would be valid option, remove the exp backoff and wait activelly.<br><=
/blockquote><div><br></div><div><div class=3D"gmail_default" style=3D"font-=
size:small">Yes, wait actively and confirm event handling is completed.</di=
v><div class=3D"gmail_default" style=3D"font-size:small">(`udevadm settle` =
is the direct way I can think of now)</div><br></div><div>=C2=A0</div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">
Btw we already have an infrastructure for matching kernel event uevents<br>
in the kernel/uevent/ directory. If we split the uevent.h there into a<br>
header and libs/ltpuevent/ we could simply wait for the event by filling<br=
>
in the uevent_desc structure and calling wait_for_uevents().<br></blockquot=
e><div><br></div><div><div class=3D"gmail_default" style=3D"font-size:small=
">Good to know this, I have looked through that but am afraid it can&#39;t<=
/div><div class=3D"gmail_default" style=3D"font-size:small">fully satisfy o=
ur requirements.=C2=A0</div><div class=3D"gmail_default" style=3D"font-size=
:small"><br></div><div class=3D"gmail_default" style=3D"font-size:small">Be=
cause the wait_for_uevents is only falling into an infinite loop</div><div =
class=3D"gmail_default" style=3D"font-size:small">and returns if detecting =
the expected UEVENT (which was sent</div><div class=3D"gmail_default" style=
=3D"font-size:small">from the kernel function kobject_uevent_env).</div><di=
v class=3D"gmail_default" style=3D"font-size:small"><br></div><div class=3D=
"gmail_default" style=3D"font-size:small">The key point here is, we have to=
 confirm `udevd` completed the UEVENT</div><div class=3D"gmail_default" sty=
le=3D"font-size:small">handling, otherwise only detecting event exists is n=
ot enough, there is still</div><div class=3D"gmail_default" style=3D"font-s=
ize:small">potentially get the race condition again=C2=A0if the event queue=
 there.</div><br></div><div>=C2=A0</div></div>-- <br><div dir=3D"ltr" class=
=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<b=
r></div></div></div></div>

--00000000000002dc7905dd2456d2--


--===============1451633922==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1451633922==--

