Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40AA9C433EF
	for <ltp@archiver.kernel.org>; Mon, 28 Mar 2022 09:55:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0989D3C980A
	for <ltp@archiver.kernel.org>; Mon, 28 Mar 2022 11:55:25 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 345533C8CA5
 for <ltp@lists.linux.it>; Mon, 28 Mar 2022 11:55:15 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 23763600677
 for <ltp@lists.linux.it>; Mon, 28 Mar 2022 11:55:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648461312;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Iln8AHbIBWQswIhohmUM0SBhVe3Y3TcMs03viXmJW34=;
 b=Hk0TUx/NKZMj8UQ8vv+eDb06YtyZh4lQtPB9rfgE07HIKT0nCK1hn0iqZdwDuWCgSGZtcV
 kM+UDI3ZUXroU+gRIZ7rb5b45nVbJcmnBrv3gMnhb4hpHayP+OmQs45tXlqpVoJFRzv7z7
 HX/gv8bi+O1K/X1ljbDBZmzuFVajAKo=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-575-oKQXm4umOFyhtFvhonSysQ-1; Mon, 28 Mar 2022 05:55:10 -0400
X-MC-Unique: oKQXm4umOFyhtFvhonSysQ-1
Received: by mail-yb1-f199.google.com with SMTP id
 k13-20020a25c60d000000b006339008b92fso10519402ybf.1
 for <ltp@lists.linux.it>; Mon, 28 Mar 2022 02:55:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Iln8AHbIBWQswIhohmUM0SBhVe3Y3TcMs03viXmJW34=;
 b=00D5Y6pbBTLOSCGFV71Mg3cSGAgnmPgdOqA4IKHLPggCm+eliAH/1YgLGmHRkZA+7W
 5TkI0+TsWCzhRXE3hJ3GxsGeu0NQPumBPUk/SEoQbnv/eqGhoBu3dgNhMSw2lERDAkzn
 +UFd06zzPjGPkSoApB/MzK5xiCdIE5hvt/1kqmGl7/JTbgrFhsCw57VbiIJnQ6lWVnTS
 Dp3zoLp3ytifH1EOv/+5euLg0Syu2Yy0elK+bc1pnp+FUDHK5nwFIb5BBe74Ku0qcDeF
 qhH3cA4IjDA2P1oiPtxUIPdtc5hG47+6MY1N9B0jGYMzHpLb17f8eDHwUVFeGxReydE9
 jMCw==
X-Gm-Message-State: AOAM531JmAp+5BF2KeB9U4YNfdsgyug5eEUGz7dMao3kN2r7PYqt5+nu
 Q30mAglH6ixHK1u5pGuMwj5oALPlb5jEdn3UM5ln18Bk5Y+vbSbKbT0eh5M0F681yxUoReYPFGT
 jigRFDXY5ymOkFKqLyS6hL474zO0=
X-Received: by 2002:a81:1211:0:b0:2e5:d8dd:b3d4 with SMTP id
 17-20020a811211000000b002e5d8ddb3d4mr23780260yws.208.1648461309870; 
 Mon, 28 Mar 2022 02:55:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxpZ8IpsIKubxfKy97lswVVMU6c1xcH9Dp1aA9pQc4m32fsWuERfqYsZxBR0RmKTaOzgQ32iTykqu9nQjGginE=
X-Received: by 2002:a81:1211:0:b0:2e5:d8dd:b3d4 with SMTP id
 17-20020a811211000000b002e5d8ddb3d4mr23780235yws.208.1648461309530; Mon, 28
 Mar 2022 02:55:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220325040057.544211-1-liwang@redhat.com> <Yj2V2fu/3Zzio3TZ@yuki>
 <CAEemH2fVf8tMbY4R_O-BrSy7vtmyGgNq3NbYF=LfjyHDbDgkBg@mail.gmail.com>
 <YkF4pVQXMqEO32r2@yuki>
In-Reply-To: <YkF4pVQXMqEO32r2@yuki>
From: Li Wang <liwang@redhat.com>
Date: Mon, 28 Mar 2022 17:54:55 +0800
Message-ID: <CAEemH2dSkAFF6Mh7m=o9Ejnut9iKT-Ud=Wm10+98-1BT9w+TPA@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] clock_gettime04: set threshold based on the clock
 tick rate
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
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Eirik Fuller <efuller@redhat.com>,
 Waiman Long <llong@redhat.com>, LTP List <ltp@lists.linux.it>
Content-Type: multipart/mixed; boundary="===============0669577800=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0669577800==
Content-Type: multipart/alternative; boundary="000000000000c7e8d705db444eb1"

--000000000000c7e8d705db444eb1
Content-Type: text/plain; charset="UTF-8"

On Mon, Mar 28, 2022 at 4:56 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> > >         clock_getres(CLOCK_REALTIME_COARSE, &res);
> > >
> > >         delta = 5 + (res.tv_nsec / 1000000) * 5;
> > >
> >
> > Sounds reasonable.
> >
> > But I don't understand why you multiply 5 for the resolution
> > (in milliseconds) here. Or, a wiser choice is to get the real
> > resolution for each clockid? i.e.
>
> I did multiply it with 5 just to add some error margin. I guess that we
> can as well multiply it with 2 if that works well enough.
>

Ok, I'd like to multiply 5 in case VM needs more.


> I do not think that we should get resolution for each clock, the COARSE
> clock should have the worst resolution of all clocks.
>

Yes, quite enough for the rest.
For precise clock, the second part will be zero since divided by 1000000.

    delta = 5 + (res.tv_nsec / 1000000) * 5;


Test data from aarch4 (kernel-5.14) FYI:
===================
clock_gettime04.c:108: TINFO: CLOCK_REALTIME: resolution is 1ns
...
clock_gettime04.c:108: TINFO: CLOCK_REALTIME_COARSE: resolution is
10000000ns
clock_gettime04.c:108: TINFO: CLOCK_MONOTONIC: resolution is 1ns
clock_gettime04.c:108: TINFO: CLOCK_MONOTONIC_COARSE: resolution is
10000000ns
clock_gettime04.c:108: TINFO: CLOCK_MONOTONIC_RAW: resolution is 1ns
clock_gettime04.c:108: TINFO: CLOCK_BOOTTIME: resolution is 1ns


-- 
Regards,
Li Wang

--000000000000c7e8d705db444eb1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Mon, Mar 28, 2022 at 4:56 PM Cyril Hrubis &lt;<a=
 href=3D"mailto:chrubis@suse.cz" target=3D"_blank">chrubis@suse.cz</a>&gt; =
wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi!<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0clock_getres(CLOCK_REALTIME_COAR=
SE, &amp;res);<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0delta =3D 5 + (res.tv_nsec / 100=
0000) * 5;<br>
&gt; &gt;<br>
&gt; <br>
&gt; Sounds reasonable.<br>
&gt; <br>
&gt; But I don&#39;t understand why you multiply 5 for the resolution<br>
&gt; (in milliseconds) here. Or, a wiser choice is to get the real<br>
&gt; resolution for each clockid? i.e.<br>
<br>
I did multiply it with 5 just to add some error margin. I guess that we<br>
can as well multiply it with 2 if that works well enough.<br></blockquote><=
div><br></div><div><div class=3D"gmail_default" style=3D"font-size:small">O=
k, I&#39;d like to multiply=C2=A05 in case VM needs more.</div></div><div><=
br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
I do not think that we should get resolution for each clock, the COARSE<br>
clock should have the worst resolution of all clocks.<br></blockquote><div>=
<br></div><div><div class=3D"gmail_default" style=3D"font-size:small">Yes, =
quite enough for the rest.=C2=A0</div><div class=3D"gmail_default" style=3D=
"font-size:small">For precise clock, the second part will be zero since div=
ided=C2=A0by 1000000.</div></div><div class=3D"gmail_default" style=3D"font=
-size:small"><br></div><div class=3D"gmail_default" style=3D"font-size:smal=
l">=C2=A0 =C2=A0 delta =3D 5 + (res.tv_nsec / 1000000) * 5;<br></div><div><=
br></div><div><br></div><div><div class=3D"gmail_default" style=3D"font-siz=
e:small">Test data from aarch4 (kernel-5.14) FYI:</div><div class=3D"gmail_=
default" style=3D"font-size:small">=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D</div></div><div><span class=3D"gmail_default" style=3D"f=
ont-size:small"></span>clock_gettime04.c:108: TINFO: CLOCK_REALTIME: resolu=
tion is 1ns<br><div class=3D"gmail_default" style=3D"font-size:small">...</=
div>clock_gettime04.c:108: TINFO: CLOCK_REALTIME_COARSE: resolution is 1000=
0000ns<br>clock_gettime04.c:108: TINFO: CLOCK_MONOTONIC: resolution is 1ns<=
br>clock_gettime04.c:108: TINFO: CLOCK_MONOTONIC_COARSE: resolution is 1000=
0000ns<br>clock_gettime04.c:108: TINFO: CLOCK_MONOTONIC_RAW: resolution is =
1ns<br>clock_gettime04.c:108: TINFO: CLOCK_BOOTTIME: resolution is 1ns<br><=
div class=3D"gmail_default" style=3D"font-size:small"><br></div></div></div=
><div><br></div>-- <br><div dir=3D"ltr"><div dir=3D"ltr"><div>Regards,<br><=
/div><div>Li Wang<br></div></div></div></div>

--000000000000c7e8d705db444eb1--


--===============0669577800==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0669577800==--

