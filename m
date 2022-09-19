Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4753EECAAD3
	for <ltp@archiver.kernel.org>; Mon, 19 Sep 2022 03:36:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3B9CC3CA9DD
	for <ltp@archiver.kernel.org>; Mon, 19 Sep 2022 05:36:00 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 17C5E3C945D
 for <ltp@lists.linux.it>; Mon, 19 Sep 2022 05:35:48 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8CC5314002D7
 for <ltp@lists.linux.it>; Mon, 19 Sep 2022 05:35:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1663558546;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=k9atJ5AJtJRTnFCBr1P/dB6OXF/q+iNNxR3zW/0cH8o=;
 b=QeUKl/Hf7tb0ntqlUllYhOxtrEv7AfMRYyRbOB5yM4rbaZlWjYMmdMuvKZ3SNveKV4W9lS
 nTJ8yCAwx6dGfgbmTZkA2mz5XMeCx68OJUVD3hbS5c8GMMSl45N9rrdPOuWPuSa+p+dnp4
 9oFAHSWMeF4+KiE1Mbc+Prm0paGDaTc=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-397-FEimdDQwPgyQKv32DBe-Qw-1; Sun, 18 Sep 2022 23:35:44 -0400
X-MC-Unique: FEimdDQwPgyQKv32DBe-Qw-1
Received: by mail-ua1-f69.google.com with SMTP id
 d1-20020ab03181000000b003beefd10211so3467938uan.20
 for <ltp@lists.linux.it>; Sun, 18 Sep 2022 20:35:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=k9atJ5AJtJRTnFCBr1P/dB6OXF/q+iNNxR3zW/0cH8o=;
 b=Ortyh5AzSILkmZeQWdD6xWuHmEz+yIZ70lGfrvfGGDGEiRnT4ZLJQLQ1izTnIs0D93
 PytqadHyMCsUzw0xj9Xz3Shok2NTrUroBctRQLpXMSedAx0MaH3iVg+q0jbu5cvGFAPI
 fxalDp/1cceDJM8WpIBUAt8Eiw5tYspkeomhIATsisDvc+pxqvW1uloXrEy48g64JfZc
 AV/QX8IetXRLSJcg/vs0c6CDBCej62SiYJLL7hDvfdR1lWmJBLfHMgs3fXB359je1+KX
 dcTVDTCNsg/l66nhRQPmj5ukq8NRgbmty5YXiAiABK/jHXNxV6Md8Xa8j0MCAmVmGix5
 aY0w==
X-Gm-Message-State: ACrzQf2dd1FX7uHnTQu+CJloOmpdLEwxgPnt6LCSaZdfzfkmR2PF2oD/
 w2i/z/kIvs8KiZUB29/G0D47llF4BA7+YLzWTOKnauIplu5ArgE/sjvbZ1hPe5Nv2JE/oaxUR1K
 x2CxbzeQDx2xGOoJJ75DDb8HwHTQ=
X-Received: by 2002:a67:e109:0:b0:398:563f:eb0a with SMTP id
 d9-20020a67e109000000b00398563feb0amr5363271vsl.57.1663558544020; 
 Sun, 18 Sep 2022 20:35:44 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4fpIX44kdwy6FhpI8GIO2LQ7RM2FMiJMjy1NbLFqDW49t7vaCUHK8r7gUCX06Fa6JHzBIIRAaRayQhLofyB/Q=
X-Received: by 2002:a67:e109:0:b0:398:563f:eb0a with SMTP id
 d9-20020a67e109000000b00398563feb0amr5363265vsl.57.1663558543693; Sun, 18 Sep
 2022 20:35:43 -0700 (PDT)
MIME-Version: 1.0
References: <010001834b528ae5-11a8d4c7-4e72-4f8d-af66-e9ec2a864017-000000@email.amazonses.com>
 <YyfeaeMsvACB5dcf@pevik>
 <CAEemH2ddod62+jkLjvxbNAwPxF8DrVGcyH3fKEJfkLrGaLZJng@mail.gmail.com>
In-Reply-To: <CAEemH2ddod62+jkLjvxbNAwPxF8DrVGcyH3fKEJfkLrGaLZJng@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Mon, 19 Sep 2022 11:35:32 +0800
Message-ID: <CAEemH2cLKhrE5SVjfd5Got3adf9+C0dJeuP-qY_r98fDUr2gMQ@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [REGRESSION] lkft ltp for cea142b
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
Cc: lkft@linaro.org, LTP List <ltp@lists.linux.it>,
 lkft-triage@lists.linaro.org, Martin Doucha <martin.doucha@suse.com>
Content-Type: multipart/mixed; boundary="===============0857595242=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0857595242==
Content-Type: multipart/alternative; boundary="0000000000000f736205e8ff68e8"

--0000000000000f736205e8ff68e8
Content-Type: text/plain; charset="UTF-8"

On Mon, Sep 19, 2022 at 11:27 AM Li Wang <liwang@redhat.com> wrote:

>
>
> On Mon, Sep 19, 2022 at 11:14 AM Petr Vorel <pvorel@suse.cz> wrote:
>
>> Hi all,
>>
>> > ## Build
>> > * kernel: 5.18.19
>> > * git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
>> > * git branch: linux-5.18.y
>> > * git commit: 22a992953741ad79c07890d3f4104585e52ef26b
>> > * git describe: cea142b
>> > * test details: https://qa-reports.linaro.org/lkft/ltp/build/cea142b
>>
>> > ## Test Regressions (compared to 98140f3)
>> > * qemu_i386, ltp-controllers
>> >   - cpuacct_100_100
>>
>> > * qemu_x86_64, ltp-cve
>> >   - cve-2018-1000204
>> OK, 3252ea38d ("ioctl_sg01: Add max_runtime") didn't help.
>>
>> looking at the log [1] I don't see anything obvious why test timeouts:
>>
>
> tst_pollute_memory() consume time is proportional to the amount of
> free RAM, it is hard to find one fixed value of max_runtime to fit all test
> platforms.
>
> From my experience, if you limited this test only run with small
> machine (e.g. RAM <= 32G), that performs well with whatever
> bare metal or VM, no timeout ever.
>

Btw, we did that by setting a test filter before LTP running, also we could
add a field .max_mem_avail to tst_test struct for achieving that, but not
sure if it's worth doing that at this moment.

-- 
Regards,
Li Wang

--0000000000000f736205e8ff68e8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Mon, Sep 19, 2022 at 11:27 AM Li Wang &lt;<a hre=
f=3D"mailto:liwang@redhat.com">liwang@redhat.com</a>&gt; wrote:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div dir=
=3D"ltr"><div style=3D"font-size:small"><br></div></div><br><div class=3D"g=
mail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Sep 19, 2022 at 1=
1:14 AM Petr Vorel &lt;<a href=3D"mailto:pvorel@suse.cz" target=3D"_blank">=
pvorel@suse.cz</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">Hi all,<br>
<br>
&gt; ## Build<br>
&gt; * kernel: 5.18.19<br>
&gt; * git: <a href=3D"https://gitlab.com/Linaro/lkft/mirrors/stable/linux-=
stable-rc" rel=3D"noreferrer" target=3D"_blank">https://gitlab.com/Linaro/l=
kft/mirrors/stable/linux-stable-rc</a><br>
&gt; * git branch: linux-5.18.y<br>
&gt; * git commit: 22a992953741ad79c07890d3f4104585e52ef26b<br>
&gt; * git describe: cea142b<br>
&gt; * test details: <a href=3D"https://qa-reports.linaro.org/lkft/ltp/buil=
d/cea142b" rel=3D"noreferrer" target=3D"_blank">https://qa-reports.linaro.o=
rg/lkft/ltp/build/cea142b</a><br>
<br>
&gt; ## Test Regressions (compared to 98140f3)<br>
&gt; * qemu_i386, ltp-controllers<br>
&gt;=C2=A0 =C2=A0- cpuacct_100_100<br>
<br>
&gt; * qemu_x86_64, ltp-cve<br>
&gt;=C2=A0 =C2=A0- cve-2018-1000204<br>
OK, 3252ea38d (&quot;ioctl_sg01: Add max_runtime&quot;) didn&#39;t help.<br=
>
<br>
looking at the log [1] I don&#39;t see anything obvious why test timeouts:<=
br></blockquote><div><br></div><div><div style=3D"font-size:small">tst_poll=
ute_memory() consume time is proportional to the=C2=A0amount of</div><div s=
tyle=3D"font-size:small">free RAM, it is hard to find one fixed value of ma=
x_runtime to fit all test</div><div style=3D"font-size:small">platforms.</d=
iv><div style=3D"font-size:small"><br></div><div style=3D"font-size:small">=
From my experience,=C2=A0if you limited this test only run with small</div>=
<div style=3D"font-size:small">machine (e.g. RAM &lt;=3D 32G), that perform=
s well with whatever</div><div style=3D"font-size:small">bare metal or VM, =
no timeout ever.</div></div></div></div></blockquote><div><br></div><div cl=
ass=3D"gmail_default" style=3D"font-size:small">Btw, we did that by setting=
 a test filter before LTP running, also we could</div><div class=3D"gmail_d=
efault" style=3D"font-size:small">add a field .max_mem_avail to tst_test st=
ruct for achieving that, but not</div><div class=3D"gmail_default" style=3D=
"font-size:small">sure if it&#39;s worth doing that at this moment.</div></=
div><div><br></div>-- <br><div dir=3D"ltr" class=3D"gmail_signature"><div d=
ir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></div></div></div>

--0000000000000f736205e8ff68e8--


--===============0857595242==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0857595242==--

