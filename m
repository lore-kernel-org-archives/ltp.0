Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D9B3C433F5
	for <ltp@archiver.kernel.org>; Sun,  9 Oct 2022 06:23:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A21B33CAE5A
	for <ltp@archiver.kernel.org>; Sun,  9 Oct 2022 08:23:35 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 69F8E3CA29C
 for <ltp@lists.linux.it>; Sun,  9 Oct 2022 08:23:24 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 38C0910007F3
 for <ltp@lists.linux.it>; Sun,  9 Oct 2022 08:23:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1665296601;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=taX3csvzQwTjmm1IcO4YsHzGRABSbGUcy+z2QUq2kp4=;
 b=WThsPwMEc6QTTSZVMZ4tMvv1Z5jBnG1mCXs9C5bVgv5sSrP1ZldGbcaJqGuRQMSjJk8dmr
 s0mvJngmEIHTSgFUDkkM+LgqGOh6hF24/ISfVt6UTlFXknrQZkjp5oe1nDy2biGkuB0W3y
 S2ilohths/Ax+ZFQIgP4skupfsawyWA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-642-e0fUgpY1NpKjCSRK8mlEnQ-1; Sun, 09 Oct 2022 02:23:19 -0400
X-MC-Unique: e0fUgpY1NpKjCSRK8mlEnQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 b7-20020a05600c4e0700b003bde2d860d1so5159753wmq.8
 for <ltp@lists.linux.it>; Sat, 08 Oct 2022 23:23:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=taX3csvzQwTjmm1IcO4YsHzGRABSbGUcy+z2QUq2kp4=;
 b=s7md38mWL+0g65JKli9rQGr+r79XYxEXbXmWsbR2jeyFUrw2BhkNmmVVAts7oVzyei
 JB5bazWftKqqrHgjDDgnMOajZ2BZtAQmN6uVeTyiE+HMxQ53mHPkBut9CnbE4GVaMcOL
 VhZzs98p+kvaGgufhlxELX3H9UNOZ17ALEYWor4fbJDfXJdAhQjyfV8YjskOzGZtlINA
 subSnLTltXbM2NpxHuGF2YHrNm/VUI96gbhExKgZ31mW8axGqjqvnLvln69mHCRbjBS4
 6plEKLd3OnPPM27wsh9sGsqB1AOKWjdEjwDZXkffkj/cpDS2CFXBFVtIQLiSuiSHexGp
 tF1w==
X-Gm-Message-State: ACrzQf1YR0L/QuPMxqngIzL9NWDNybvDSqXnEfctHQ7sgekSWMik8NCg
 CcG7eOV7e2c3F7PCl0uvDj9qwxaGm0h+qQicbxr+ffzuMA4j6oMGrLl3no0n/5jZaVDxKzzoZG+
 qxMylV5NLU6dJPkEy0MWmBz4Cevg=
X-Received: by 2002:a05:600c:3d93:b0:3b4:c28f:6a2b with SMTP id
 bi19-20020a05600c3d9300b003b4c28f6a2bmr8462278wmb.121.1665296598694; 
 Sat, 08 Oct 2022 23:23:18 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7aNJEZwwEkFrEOdO6d1tEUGvtl7GcX7EpSd3KEZW7odThjeTKvGqmie5BbaWEZ3AYZ2y8T9cHcBZ0oUtqhUSw=
X-Received: by 2002:a05:600c:3d93:b0:3b4:c28f:6a2b with SMTP id
 bi19-20020a05600c3d9300b003b4c28f6a2bmr8462263wmb.121.1665296598469; Sat, 08
 Oct 2022 23:23:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220720071743.28371-1-akumar@suse.de>
 <CAEemH2dbXXHh-6PsMWtmo4gBmc5iWYAfbEe95U4_0jEK66b+Zg@mail.gmail.com>
In-Reply-To: <CAEemH2dbXXHh-6PsMWtmo4gBmc5iWYAfbEe95U4_0jEK66b+Zg@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Sun, 9 Oct 2022 14:23:07 +0800
Message-ID: <CAEemH2dL0jXWXMod_omEN6xD1_t5r-VXrj8OLxpDaDbaP=2n0w@mail.gmail.com>
To: Avinesh Kumar <akumar@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] getitimer01.c: convert to new LTP API
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
Content-Type: multipart/mixed; boundary="===============0540561715=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0540561715==
Content-Type: multipart/alternative; boundary="00000000000032acb505ea9414bc"

--00000000000032acb505ea9414bc
Content-Type: text/plain; charset="UTF-8"

On Thu, Jul 21, 2022 at 3:07 PM Li Wang <liwang@redhat.com> wrote:

> Hi Avinesh,
>
> Avinesh Kumar <akumar@suse.de> wrote:
>
>
>> +       for (i = 0; i < 3; i++) {
>> +               TST_EXP_PASS(getitimer(itimer_name[i], &value));
>> +               TST_EXP_EQ_LI(value.it_value.tv_sec, 0);
>> +               TST_EXP_EQ_LI(value.it_value.tv_usec, 0);
>>
>
> This is just to verify getittimer() works well when there is none
> of a specific interval timer being set.
>
> Maybe we can add some more tests to check if it fully implements
> the documented behavior? Or, at least confirming it gets expected
> signals for different types of timers-specified is also necessary.
>

After looking into this syscall specifically, those below 'which' types
are more useful to setitimer() [1]. So we could achieve more tests there but
not for getitimer().

I made some improvements and pushed this patch. Thanks!

[1]
https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/syscalls/setitimer/setitimer01.c



>
>   ITIMER_REAL:         At each expiration, a SIGALRM signal is generated.
>   ITIMER_VIRTUAL :  At each expiration, a SIGVTALRM signal is generated.
>   ITIMER_PROF:        At each expiration, a SIGPROF signal is generated.
>
> see: https://man7.org/linux/man-pages/man2/setitimer.2.html
>
> --
> Regards,
> Li Wang
>


-- 
Regards,
Li Wang

--00000000000032acb505ea9414bc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Thu, Jul 21, 2022 at 3:07 PM Li Wang &lt;<a href=
=3D"mailto:liwang@redhat.com">liwang@redhat.com</a>&gt; wrote:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div dir=3D=
"ltr"><div style=3D"font-size:small">Hi=C2=A0Avinesh,</div><div style=3D"fo=
nt-size:small"><br></div><div style=3D"font-size:small">Avinesh Kumar &lt;<=
a href=3D"mailto:akumar@suse.de" target=3D"_blank">akumar@suse.de</a>&gt; w=
rote:<br></div></div><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"g=
mail_attr">=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; 3; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TST_EXP_PASS(getiti=
mer(itimer_name[i], &amp;value));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TST_EXP_EQ_LI(value=
.it_value.tv_sec, 0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TST_EXP_EQ_LI(value=
.it_value.tv_usec, 0);<br></blockquote><div><br></div><div style=3D"font-si=
ze:small">This is just to verify getittimer() works well when there is none=
</div><div style=3D"font-size:small">of a specific interval timer being set=
.=C2=A0</div><div style=3D"font-size:small"><br></div><div style=3D"font-si=
ze:small">Maybe we can add some more tests to check if it fully implements<=
/div><div style=3D"font-size:small">the documented behavior? Or, at least c=
onfirming it gets expected</div><div style=3D"font-size:small">signals for =
different types of timers-specified is also necessary.</div></div></div></b=
lockquote><div><br></div><div><div class=3D"gmail_default" style=3D"font-si=
ze:small">After looking into this syscall specifically, those below &#39;wh=
ich&#39; types</div><div class=3D"gmail_default" style=3D"font-size:small">=
are more useful to setitimer() [1]. So we could achieve more tests there bu=
t</div><div class=3D"gmail_default" style=3D"font-size:small">not for getit=
imer().</div><div class=3D"gmail_default" style=3D"font-size:small"><br></d=
iv><div class=3D"gmail_default" style=3D"font-size:small">I made some impro=
vements and pushed this patch. Thanks!</div><div class=3D"gmail_default" st=
yle=3D"font-size:small"><br></div><div class=3D"gmail_default" style=3D"fon=
t-size:small">[1]=C2=A0<a href=3D"https://github.com/linux-test-project/ltp=
/blob/master/testcases/kernel/syscalls/setitimer/setitimer01.c">https://git=
hub.com/linux-test-project/ltp/blob/master/testcases/kernel/syscalls/setiti=
mer/setitimer01.c</a></div><br></div><div>=C2=A0</div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex"><div dir=3D"ltr"><div class=3D"gmail_quote"><d=
iv style=3D"font-size:small"><br></div><span class=3D"gmail_default" style=
=3D"font-size:small">=C2=A0 </span>ITIMER_REAL<span class=3D"gmail_default"=
 style=3D"font-size:small">:</span> <span class=3D"gmail_default" style=3D"=
font-size:small">=C2=A0 =C2=A0 =C2=A0 =C2=A0</span><span class=3D"gmail_def=
ault" style=3D"font-size:small"></span>=C2=A0At each expiration, a SIGALRM =
signal is generated.=C2=A0</div><div class=3D"gmail_quote"><span class=3D"g=
mail_default" style=3D"font-size:small">=C2=A0 </span>ITIMER_VIRTUAL<span c=
lass=3D"gmail_default" style=3D"font-size:small"> :</span> <span class=3D"g=
mail_default" style=3D"font-size:small"></span>=C2=A0At each expiration, a =
SIGVTALRM signal is generated.=C2=A0</div><div class=3D"gmail_quote"><span =
class=3D"gmail_default" style=3D"font-size:small">=C2=A0 </span>ITIMER_PROF=
<span class=3D"gmail_default" style=3D"font-size:small">:</span> <span clas=
s=3D"gmail_default" style=3D"font-size:small">=C2=A0 =C2=A0 =C2=A0 </span><=
span class=3D"gmail_default" style=3D"font-size:small">=C2=A0</span>At each=
 expiration, a SIGPROF signal is generated.</div><div class=3D"gmail_quote"=
><br><div style=3D"font-size:small">see:=C2=A0<a href=3D"https://man7.org/l=
inux/man-pages/man2/setitimer.2.html" target=3D"_blank">https://man7.org/li=
nux/man-pages/man2/setitimer.2.html</a></div></div><div><br></div>-- <br><d=
iv dir=3D"ltr"><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></di=
v></div></div></div>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div><div>Li =
Wang<br></div></div></div></div>

--00000000000032acb505ea9414bc--


--===============0540561715==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0540561715==--

