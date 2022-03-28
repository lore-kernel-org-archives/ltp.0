Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47F99C433F5
	for <ltp@archiver.kernel.org>; Mon, 28 Mar 2022 10:13:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 138963C97EA
	for <ltp@archiver.kernel.org>; Mon, 28 Mar 2022 12:13:41 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 48E383C07BE
 for <ltp@lists.linux.it>; Mon, 28 Mar 2022 12:13:30 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 478AE600698
 for <ltp@lists.linux.it>; Mon, 28 Mar 2022 12:13:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648462407;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xqSKVA/VRRfwjU5t9bgH+lPUPCTXXWquRG0IrSNLn9A=;
 b=BwJpGCG2/VSRL8Jw8NJjlzrLH+OJ5Nh5i8tHH54yfhzavtC+k0oF2TRN2eRiTqE0VsySE8
 p34tKMqlzyeJ4ZZHlhfgbTcvliM46cegFtDAi/h+Xuz80GHVsXUtE2fjc0kn+1VZ/Yo5no
 AzUCYFfEjrcDk+Y2igVA1N/Kvx/POmA=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-637-LS9PsdD0PW2VFfACNubFKg-1; Mon, 28 Mar 2022 06:13:26 -0400
X-MC-Unique: LS9PsdD0PW2VFfACNubFKg-1
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-2e61c5a0eb7so113975207b3.22
 for <ltp@lists.linux.it>; Mon, 28 Mar 2022 03:13:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xqSKVA/VRRfwjU5t9bgH+lPUPCTXXWquRG0IrSNLn9A=;
 b=n0aymTqYbsDPBzQsnolzj0/WeRy8jU7Gw7ieg/+hWeG//JK40o16KxavLZCNy8CJ3U
 77gNrNIHWFxusxoFJJDiwMh5SL/6k5JNewv7+H1l0wwvoOgLDQ0bLgDsf0mfYNKAHvio
 nPEE0mBJO1o/RcbJJ2Nn26dw8HuZYKysYA0vNDjPBJnYLOKxjHJBR9MvG2uyfGwA2oLc
 l8ZQ4TnzdTpugUhQEu8PY6nF6Fz6Z+XFeVrH0X7GtoB8hI67hB2Ue8mCoxvoAiX+HQA/
 xGwjF+odRM3WUYo0PshuiXGbVEjfRbRbnfhwMoNIIL/Dx80fqEmpFgwfKV6QYDUfe27Z
 udeA==
X-Gm-Message-State: AOAM532ke0bvVyD/ngMD8h6D6MjHPgTOfgRjfemunw31gpRKe9YNdcaH
 q+D+xvKKZE+pDfGrMHKMits5X8h2aF12s4H/mG0c1WX1DDxU62OAO5W+N1i5zjHmOlSu7c0VodW
 T/i+611cOwbIK+pDbitBV7DJtwCI=
X-Received: by 2002:a25:e78e:0:b0:633:9df1:9fff with SMTP id
 e136-20020a25e78e000000b006339df19fffmr21527067ybh.233.1648462405879; 
 Mon, 28 Mar 2022 03:13:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy8s/7PiqeHbU5ZPkJ9J6cnXIvKGvlRjP4Yu0jdBrLgz8tf3KgtFzDnrBNBFXsQmHHOSwHdkC1OJuDhmtnizos=
X-Received: by 2002:a25:e78e:0:b0:633:9df1:9fff with SMTP id
 e136-20020a25e78e000000b006339df19fffmr21527046ybh.233.1648462405508; Mon, 28
 Mar 2022 03:13:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220325040057.544211-1-liwang@redhat.com> <Yj2V2fu/3Zzio3TZ@yuki>
 <CAEemH2fVf8tMbY4R_O-BrSy7vtmyGgNq3NbYF=LfjyHDbDgkBg@mail.gmail.com>
 <YkF4pVQXMqEO32r2@yuki>
 <CAEemH2dSkAFF6Mh7m=o9Ejnut9iKT-Ud=Wm10+98-1BT9w+TPA@mail.gmail.com>
In-Reply-To: <CAEemH2dSkAFF6Mh7m=o9Ejnut9iKT-Ud=Wm10+98-1BT9w+TPA@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Mon, 28 Mar 2022 18:13:09 +0800
Message-ID: <CAEemH2eSWor_gpVv=vpXCz0+9bt6xK5+2H4zjg66Y=yVPeS1Mg@mail.gmail.com>
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
Content-Type: multipart/mixed; boundary="===============1729646155=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1729646155==
Content-Type: multipart/alternative; boundary="0000000000001b37cc05db449017"

--0000000000001b37cc05db449017
Content-Type: text/plain; charset="UTF-8"

Hi Cyril,

Sorry, I didn't complete my input but sent the email by touch
key combination...  Comments in below.

On Mon, Mar 28, 2022 at 5:54 PM Li Wang <liwang@redhat.com> wrote:


>
>> I did multiply it with 5 just to add some error margin. I guess that we
>> can as well multiply it with 2 if that works well enough.
>>
>
> Ok, I'd like to multiply 5 in case VM needs more.
>
>
>> I do not think that we should get resolution for each clock, the COARSE
>> clock should have the worst resolution of all clocks.
>>
>
> Yes, quite enough for the rest.
> For precise clock, the second part will be zero since divided by 1000000.
>
>     delta = 5 + (res.tv_nsec / 1000000) * 5;
>


My concern here is that seems a bit looser to the rest clocks.
Because "10ms" as delta is a big value to the precise clock since
the resolution of some is only 1ns.
(The delta will be "10ms" on x86_64 and "15ms" on aarch64.)

In my path V2, we can make the second part _zero_ by dividing 1000000.
Then we can keep using the proper delta for each clock.


Test data from x86_64:
========

clock_gettime04.c:108: TINFO: CLOCK_REALTIME: resolution is 1ns
clock_gettime04.c:112: TINFO: delta = : 5
...
clock_gettime04.c:108: TINFO: CLOCK_REALTIME_COARSE: resolution is 1000000ns
clock_gettime04.c:112: TINFO: delta = : 10
clock_gettime04.c:108: TINFO: CLOCK_MONOTONIC: resolution is 1ns
clock_gettime04.c:112: TINFO: delta = : 5
clock_gettime04.c:108: TINFO: CLOCK_MONOTONIC_COARSE: resolution is
1000000ns
clock_gettime04.c:112: TINFO: delta = : 10
clock_gettime04.c:108: TINFO: CLOCK_MONOTONIC_RAW: resolution is 1ns
clock_gettime04.c:112: TINFO: delta = : 5
clock_gettime04.c:108: TINFO: CLOCK_BOOTTIME: resolution is 1ns
clock_gettime04.c:112: TINFO: delta = : 5



>
>
> Test data from aarch4 (kernel-5.14) FYI:
> ===================
> clock_gettime04.c:108: TINFO: CLOCK_REALTIME: resolution is 1ns
> ...
> clock_gettime04.c:108: TINFO: CLOCK_REALTIME_COARSE: resolution is
> 10000000ns
> clock_gettime04.c:108: TINFO: CLOCK_MONOTONIC: resolution is 1ns
> clock_gettime04.c:108: TINFO: CLOCK_MONOTONIC_COARSE: resolution is
> 10000000ns
> clock_gettime04.c:108: TINFO: CLOCK_MONOTONIC_RAW: resolution is 1ns
> clock_gettime04.c:108: TINFO: CLOCK_BOOTTIME: resolution is 1ns
>
>
> --
> Regards,
> Li Wang
>


-- 
Regards,
Li Wang

--0000000000001b37cc05db449017
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Hi=C2=A0Cyril,</div><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div><div class=3D"gmail_default" style=3D"font-size:sma=
ll"><div class=3D"gmail_default">Sorry, I didn&#39;t complete my input but=
=C2=A0sent the email by touch</div><div class=3D"gmail_default">key combina=
tion...=C2=A0 Comments in below.</div></div></div><br><div class=3D"gmail_q=
uote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Mar 28, 2022 at 5:54 PM=
 Li Wang &lt;<a href=3D"mailto:liwang@redhat.com">liwang@redhat.com</a>&gt;=
 wrote:<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex"><div dir=3D"ltr"><div class=3D"gmail_quote"><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">
<br>
I did multiply it with 5 just to add some error margin. I guess that we<br>
can as well multiply it with 2 if that works well enough.<br></blockquote><=
div><br></div><div><div style=3D"font-size:small">Ok, I&#39;d like to multi=
ply=C2=A05 in case VM needs more.</div></div><div><br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">
<br>
I do not think that we should get resolution for each clock, the COARSE<br>
clock should have the worst resolution of all clocks.<br></blockquote><div>=
<br></div><div><div style=3D"font-size:small">Yes, quite enough for the res=
t.=C2=A0</div><div style=3D"font-size:small">For precise clock, the second =
part will be zero since divided=C2=A0by 1000000.</div></div><div style=3D"f=
ont-size:small"><br></div><div style=3D"font-size:small">=C2=A0 =C2=A0 delt=
a =3D 5 + (res.tv_nsec / 1000000) * 5;<br></div></div></div></blockquote><d=
iv><br></div><div><div class=3D"gmail_default" style=3D"font-size:small"><b=
r></div><div class=3D"gmail_default" style=3D"font-size:small">My concern h=
ere is that seems a bit looser to the rest clocks.</div><div class=3D"gmail=
_default" style=3D"font-size:small">Because=C2=A0&quot;10ms&quot; as delta =
is a big value=C2=A0to the precise clock since</div><div class=3D"gmail_def=
ault" style=3D"font-size:small">the resolution of some is only 1ns.=C2=A0</=
div><div class=3D"gmail_default" style=3D"font-size:small">(The delta will =
be &quot;10ms&quot; on x86_64 and &quot;15ms&quot; on aarch64.)</div><div c=
lass=3D"gmail_default" style=3D"font-size:small"><br></div><div class=3D"gm=
ail_default" style=3D"font-size:small">In my path V2, we can make the secon=
d part _zero_ by dividing 1000000.</div><div class=3D"gmail_default" style=
=3D"font-size:small">Then we can keep using the proper delta for each clock=
.</div><br></div><div><br></div><div><div class=3D"gmail_default" style=3D"=
font-size:small">Test data from x86_64:</div><div class=3D"gmail_default" s=
tyle=3D"font-size:small">=3D=3D=3D=3D=3D=3D=3D=3D</div><br></div><div><div =
class=3D"gmail_default" style=3D"font-size:small">clock_gettime04.c:108: TI=
NFO: CLOCK_REALTIME: resolution is 1ns</div>clock_gettime04.c:112: TINFO: d=
elta =3D : 5<br><span class=3D"gmail_default" style=3D"font-size:small">...=
</span><br>clock_gettime04.c:108: TINFO: CLOCK_REALTIME_COARSE: resolution =
is 1000000ns<br>clock_gettime04.c:112: TINFO: delta =3D : 10<br>clock_getti=
me04.c:108: TINFO: CLOCK_MONOTONIC: resolution is 1ns<br>clock_gettime04.c:=
112: TINFO: delta =3D : 5<br>clock_gettime04.c:108: TINFO: CLOCK_MONOTONIC_=
COARSE: resolution is 1000000ns<br>clock_gettime04.c:112: TINFO: delta =3D =
: 10<br>clock_gettime04.c:108: TINFO: CLOCK_MONOTONIC_RAW: resolution is 1n=
s<br>clock_gettime04.c:112: TINFO: delta =3D : 5<br>clock_gettime04.c:108: =
TINFO: CLOCK_BOOTTIME: resolution is 1ns<br>clock_gettime04.c:112: TINFO: d=
elta =3D : 5<br><div class=3D"gmail_default" style=3D"font-size:small"></di=
v><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex"><div dir=3D"ltr"><div class=3D"gmail_quote"><div style=3D"font-size:sma=
ll"></div><div><br></div><div><br></div><div><div style=3D"font-size:small"=
>Test data from aarch4 (kernel-5.14) FYI:</div><div style=3D"font-size:smal=
l">=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</div></div><di=
v><span class=3D"gmail_default" style=3D"font-size:small"></span>clock_gett=
ime04.c:108: TINFO: CLOCK_REALTIME: resolution is 1ns<br><div style=3D"font=
-size:small">...</div>clock_gettime04.c:108: TINFO: CLOCK_REALTIME_COARSE: =
resolution is 10000000ns<br>clock_gettime04.c:108: TINFO: CLOCK_MONOTONIC: =
resolution is 1ns<br>clock_gettime04.c:108: TINFO: CLOCK_MONOTONIC_COARSE: =
resolution is 10000000ns<br>clock_gettime04.c:108: TINFO: CLOCK_MONOTONIC_R=
AW: resolution is 1ns<br>clock_gettime04.c:108: TINFO: CLOCK_BOOTTIME: reso=
lution is 1ns<br><div style=3D"font-size:small"><br></div></div></div><div>=
<br></div>-- <br><div dir=3D"ltr"><div dir=3D"ltr"><div>Regards,<br></div><=
div>Li Wang<br></div></div></div></div>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div><div>Li =
Wang<br></div></div></div></div>

--0000000000001b37cc05db449017--


--===============1729646155==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1729646155==--

