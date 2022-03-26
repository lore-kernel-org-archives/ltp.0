Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B25F6C433F5
	for <ltp@archiver.kernel.org>; Sat, 26 Mar 2022 13:29:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5CF913C96D1
	for <ltp@archiver.kernel.org>; Sat, 26 Mar 2022 14:29:13 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 758353C8CA0
 for <ltp@lists.linux.it>; Sat, 26 Mar 2022 14:29:02 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 63A59600749
 for <ltp@lists.linux.it>; Sat, 26 Mar 2022 14:29:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648301339;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qq9UyLuCG8VaPTbycmSX3UPJr5/AUzjNiX4dfRZ3bGI=;
 b=d2GB2S4BTCHNVKF6rZA7sEqDhnmJQPDlifGPwptjtTBJfyN/7tmfETU+C5ZRDvp0KqHfRn
 pNI8uhOBNpFjMeUq20SpQ5pXXGNJqsWLrBKoKXM/7mRvwtb96JLz9Sqg95NCP73sYajj+j
 WAX629VDjYdkzL27EymEDZs+FwCklmQ=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-161-UM2gCFDSOzOLW50R4ZMHNg-1; Sat, 26 Mar 2022 09:28:57 -0400
X-MC-Unique: UM2gCFDSOzOLW50R4ZMHNg-1
Received: by mail-yb1-f200.google.com with SMTP id
 j6-20020a25ec06000000b00633c6f3e072so8151342ybh.12
 for <ltp@lists.linux.it>; Sat, 26 Mar 2022 06:28:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qq9UyLuCG8VaPTbycmSX3UPJr5/AUzjNiX4dfRZ3bGI=;
 b=cQGd+eU2YZJoxDXUY0HrOfHJqr6IXHRlNW8eGOGqaDiWstjKsoCZVcHLT9/gbOsko7
 vSjLkFNPvviqAdpWhMD0uPTKZymXrxSxYrj8MdVpeGW+KvKluoGNZhsD3Su7p6G6Yc4I
 QR2HUP0/FrRUANqG1DwcZAxJKDcFcgidnLHva7oDgeDNiEiek77BrNz3PHmgqLttuach
 t8ZcPkAF0xLhPvgVpwtfgVNq+9FrO51nCKNDHYMGNTsdJAylMakVunoOlmy1PLKIyybi
 RE+flApQAydFydQKv5ZZilZePOsVju/XOMzLvj/IeGmXA0XDakRrrykNwQTis6mVgBnV
 mYfg==
X-Gm-Message-State: AOAM531tMz1vptsaucpkkroYwl7je7mJdYgCCmE0VRs29ZBlp4pYIwCx
 YY69ZF0Ip4m/ynqGcr5kkiSJbXR9VRZUKysICQnt4NXu3t+a1x4+5l/3tnqGbLVcU9TpByRPu5/
 qyumT6F7Xw1UgCZMVG7YKWz02xoA=
X-Received: by 2002:a25:e78e:0:b0:633:9df1:9fff with SMTP id
 e136-20020a25e78e000000b006339df19fffmr14671118ybh.233.1648301337087; 
 Sat, 26 Mar 2022 06:28:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwNlLdeG4VTSvpa6fA44jCsiNobp5trr6NwwkoIveXcxeslzSBFvJSU4Fg27/4OhvQ1D2p7m+jERsubrqgUIrQ=
X-Received: by 2002:a25:e78e:0:b0:633:9df1:9fff with SMTP id
 e136-20020a25e78e000000b006339df19fffmr14671101ybh.233.1648301336803; Sat, 26
 Mar 2022 06:28:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220325040057.544211-1-liwang@redhat.com>
 <badfd854-f6c6-24ea-eeec-e2772aff2578@redhat.com>
In-Reply-To: <badfd854-f6c6-24ea-eeec-e2772aff2578@redhat.com>
From: Li Wang <liwang@redhat.com>
Date: Sat, 26 Mar 2022 21:28:43 +0800
Message-ID: <CAEemH2fvJY7wr1EZ9U73k3bbW-+FzFPb+Bngtm2kfQ-b=QA8MQ@mail.gmail.com>
To: Waiman Long <longman@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
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
Content-Type: multipart/mixed; boundary="===============0055699866=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0055699866==
Content-Type: multipart/alternative; boundary="000000000000a9d5dc05db1f0fc6"

--000000000000a9d5dc05db1f0fc6
Content-Type: text/plain; charset="UTF-8"

Waiman Long <longman@redhat.com> wrote:


> >   static void setup(void)
> >   {
> > +     delta = 1000/sysconf(_SC_CLK_TCK) + 5;
> >       if (tst_is_virt(VIRT_ANY)) {
> >               tst_res(TINFO, "Running in a virtual machine, multiply the
> delta by 10.");
> >               delta *= 10;
>
> Actually, only CLOCK_REALTIME_COARSE and CLOCK_MONOTONIC_COARSE use
> clock tick for its time measurement. The rests use a higher resolution
> internal timer. Perhaps, we could have a separate coarse_delta for these
> two cases and use delta for the rest.
>

Good point, at least for aarch64 the CLOCK*_COARSE makes use
of the clock tick is 10ms.

However, as many architectures have varying tick rates and use
dynamically timer, maybe a further method is to get it via clock_getres()
just like Cyril mentioned in another email.

(I draft patch V2 in that email, feel free to review)

-- 
Regards,
Li Wang

--000000000000a9d5dc05db1f0fc6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><div class=3D"gmail_quote"><div dir=3D"ltr" c=
lass=3D"gmail_attr">Waiman Long &lt;<a href=3D"mailto:longman@redhat.com" t=
arget=3D"_blank">longman@redhat.com</a>&gt; wrote:</div><div>=C2=A0</div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">
&gt;=C2=A0 =C2=A0static void setup(void)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0delta =3D 1000/sysconf(_SC_CLK_TCK) + 5;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (tst_is_virt(VIRT_ANY)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tst_res(TINFO, &=
quot;Running in a virtual machine, multiply the delta by 10.&quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0delta *=3D 10;<b=
r>
<br>
Actually, only CLOCK_REALTIME_COARSE and CLOCK_MONOTONIC_COARSE use <br>
clock tick for its time measurement. The rests use a higher resolution <br>
internal timer. Perhaps, we could have a separate coarse_delta for these <b=
r>
two cases and use delta for the rest.<br></blockquote><div><br></div><div><=
div class=3D"gmail_default" style=3D"font-size:small">Good point, at least =
for aarch64 the CLOCK*_COARSE makes use</div><div class=3D"gmail_default" s=
tyle=3D"font-size:small">of the clock tick is 10ms.</div></div><div class=
=3D"gmail_default" style=3D"font-size:small"><br></div><div class=3D"gmail_=
default" style=3D"font-size:small">However, as many architectures have vary=
ing tick rates and use</div><div class=3D"gmail_default" style=3D"font-size=
:small">dynamically timer, maybe a further method is to get it via clock_ge=
tres()</div><div class=3D"gmail_default" style=3D"font-size:small">just lik=
e Cyril mentioned in another email.</div><div class=3D"gmail_default" style=
=3D"font-size:small"><br></div><div class=3D"gmail_default" style=3D"font-s=
ize:small">(I draft patch V2 in that email, feel free to review)</div></div=
><div><br></div>-- <br><div dir=3D"ltr"><div dir=3D"ltr"><div>Regards,<br><=
/div><div>Li Wang<br></div></div></div></div>

--000000000000a9d5dc05db1f0fc6--


--===============0055699866==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0055699866==--

