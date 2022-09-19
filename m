Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B728BECAAA1
	for <ltp@archiver.kernel.org>; Mon, 19 Sep 2022 03:28:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7DC933CAC9C
	for <ltp@archiver.kernel.org>; Mon, 19 Sep 2022 05:28:07 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A56403C945D
 for <ltp@lists.linux.it>; Mon, 19 Sep 2022 05:27:58 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 9EB27140021F
 for <ltp@lists.linux.it>; Mon, 19 Sep 2022 05:27:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1663558076;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lB0+EynWbEFLHVlorm+Atil0YzYQxpwn35F1QwspG+0=;
 b=hF1DY4rc2HH/vL7QlmKVDIJKWNNkXrks6x6yKK6PSgAhVpd9TyrXV/LH1/htCHFy1jLNZI
 4PdH/f7eSoHIsBWgtYufGEBgAr/DKZxgoR1XzFHj6ovaSh6ABTxbw/7Z+BsmCejQrWIMJk
 fhg7qJw6C34rBSgyf7b3NdzNSoiBz0A=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-249-pohTuMmMNMafVHWRrQX9Hg-1; Sun, 18 Sep 2022 23:27:52 -0400
X-MC-Unique: pohTuMmMNMafVHWRrQX9Hg-1
Received: by mail-ua1-f71.google.com with SMTP id
 a26-20020ab0081a000000b003b752547aadso7832034uaf.22
 for <ltp@lists.linux.it>; Sun, 18 Sep 2022 20:27:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=lB0+EynWbEFLHVlorm+Atil0YzYQxpwn35F1QwspG+0=;
 b=1K2pXYTztrhAR4eI05X6GpK1cCJUksJisx9CYS80eqGGpmFNE5AluG1vzEHhvMfge+
 P4nkNvWxKPcJPZ5a/iQwRv5xbdeNDY0conlOfkybOEMZ6+tsPHPo2gTMvVh+g0xYAIzJ
 Xor4W0xv1AbC2TvKp6eF3pRWah39xhSgNXHCVzlXJsreOqh/luRAUunnYkjzEPALE856
 YmrK1nXG2XH8Ah7JpUkY+mglAkR58kX+Nip8bm3Xkc7A/q1/rxaNsttI6U0tyDf6FBbn
 3Ks4BIeX6wo1xS6Tg0MoZUV4JTu31SQVHy0joKWdX5nQsyfdFbttyJn/TwX17Jzgql6+
 uWVQ==
X-Gm-Message-State: ACrzQf1O1vu3urPNkwOaaV4YneTdMUqyikHkGAmsxsTTthJEXNokd7ga
 9dleUo2R2FjklrBnl0/EgEnVVlB1xzQv5xjxnkTylEhLNYPrNgZuyD7iDMMgAGXBEver5+Of1LG
 aRJU65LzhBiTZPYHuI4leYPGfbGc=
X-Received: by 2002:a67:e109:0:b0:398:563f:eb0a with SMTP id
 d9-20020a67e109000000b00398563feb0amr5357916vsl.57.1663558072113; 
 Sun, 18 Sep 2022 20:27:52 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM430ri4Lg2ObySpwbn1owbyUIB5XmB3wExNwez93DI3NFRZVKpZjy/asSpLdgfkF7gMufDf5RX3dEQXfqhOCb0=
X-Received: by 2002:a67:e109:0:b0:398:563f:eb0a with SMTP id
 d9-20020a67e109000000b00398563feb0amr5357909vsl.57.1663558071860; Sun, 18 Sep
 2022 20:27:51 -0700 (PDT)
MIME-Version: 1.0
References: <010001834b528ae5-11a8d4c7-4e72-4f8d-af66-e9ec2a864017-000000@email.amazonses.com>
 <YyfeaeMsvACB5dcf@pevik>
In-Reply-To: <YyfeaeMsvACB5dcf@pevik>
From: Li Wang <liwang@redhat.com>
Date: Mon, 19 Sep 2022 11:27:40 +0800
Message-ID: <CAEemH2ddod62+jkLjvxbNAwPxF8DrVGcyH3fKEJfkLrGaLZJng@mail.gmail.com>
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
Content-Type: multipart/mixed; boundary="===============0991018431=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0991018431==
Content-Type: multipart/alternative; boundary="000000000000efd5c105e8ff4b52"

--000000000000efd5c105e8ff4b52
Content-Type: text/plain; charset="UTF-8"

On Mon, Sep 19, 2022 at 11:14 AM Petr Vorel <pvorel@suse.cz> wrote:

> Hi all,
>
> > ## Build
> > * kernel: 5.18.19
> > * git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
> > * git branch: linux-5.18.y
> > * git commit: 22a992953741ad79c07890d3f4104585e52ef26b
> > * git describe: cea142b
> > * test details: https://qa-reports.linaro.org/lkft/ltp/build/cea142b
>
> > ## Test Regressions (compared to 98140f3)
> > * qemu_i386, ltp-controllers
> >   - cpuacct_100_100
>
> > * qemu_x86_64, ltp-cve
> >   - cve-2018-1000204
> OK, 3252ea38d ("ioctl_sg01: Add max_runtime") didn't help.
>
> looking at the log [1] I don't see anything obvious why test timeouts:
>

tst_pollute_memory() consume time is proportional to the amount of
free RAM, it is hard to find one fixed value of max_runtime to fit all test
platforms.

From my experience, if you limited this test only run with small
machine (e.g. RAM <= 32G), that performs well with whatever
bare metal or VM, no timeout ever.



>
> tst_test.c:1524: TINFO: Timeout per run is 0h 00m 30s
> ioctl_sg01.c:81: TINFO: Found SCSI device /dev/sg1
> Test timeouted, sending SIGKILL!
> tst_test.c:1575: TINFO: If you are running on slow machine, try exporting
> LTP_TIMEOUT_MUL > 1
> tst_test.c:1577: TBROK: Test killed! (timeout?)
>
> Summary:
> passed   0
> failed   0
> broken   1
> skipped  0
> warnings 0
>
> @lkft I haven't find dmesg after starting running tests in the test
> details [2].
> Is there any? I really like you keep the history [3], thanks! It'd be
> great if
> you could print the test name into dmesg, so that it can be visible which
> test
> caused particular message / kernel oops.
>
> Also, it'd be great if you could put some header for each test with the
> test
> name or at least blank line to separate the end of the summary.
>
> Kind regards,
> Petr
>
> [1]
> https://qa-reports.linaro.org/lkft/ltp/build/cea142b/testrun/11956785/suite/ltp-cve/test/cve-2018-1000204/log
> [2]
> https://qa-reports.linaro.org/lkft/ltp/build/cea142b/testrun/11956785/suite/ltp-cve/test/cve-2018-1000204/details/
> [3]
> https://qa-reports.linaro.org/lkft/ltp/build/cea142b/testrun/11956785/suite/ltp-cve/test/cve-2018-1000204/history/
>
>
> > ## Metric Regressions (compared to 98140f3)
> > No metric regressions found.
>
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
>
> > ## Test Fixes (compared to 98140f3)
> > * qemu_arm64, ltp-controllers
> >   - cpuacct_100_100
>
>
> > ## Metric Fixes (compared to 98140f3)
> > No metric fixes found.
>
> > ## Test result summary
> > total: 12630, pass: 10739, fail: 161, skip: 1730, xfail: 0
>
> > ## Build Summary
>
> > ## Test suites summary
> > * log-parser-boot
> > * log-parser-test
> > * ltp-cap_bounds
> > * ltp-commands
> > * ltp-containers
> > * ltp-controllers
> > * ltp-cpuhotplug
> > * ltp-crypto
> > * ltp-cve
> > * ltp-dio
> > * ltp-fcntl-locktests
> > * ltp-filecaps
> > * ltp-fs
> > * ltp-fs_bind
> > * ltp-fs_perms_simple
> > * ltp-fsx
> > * ltp-hugetlb
> > * ltp-io
> > * ltp-ipc
> > * ltp-math
> > * ltp-mm
> > * ltp-nptl
> > * ltp-pty
> > * ltp-sched
> > * ltp-securebits
> > * ltp-syscalls
> > * ltp-tracing
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
>
>

-- 
Regards,
Li Wang

--000000000000efd5c105e8ff4b52
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Mon, Sep 19, 2022 at 11:14 AM Petr Vorel &lt;<a =
href=3D"mailto:pvorel@suse.cz">pvorel@suse.cz</a>&gt; wrote:<br></div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">Hi all,<br>
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
br></blockquote><div><br></div><div><div class=3D"gmail_default" style=3D"f=
ont-size:small">tst_pollute_memory() consume time is proportional to the=C2=
=A0amount of</div><div class=3D"gmail_default" style=3D"font-size:small">fr=
ee RAM, it is hard to find one fixed value of max_runtime to fit all test</=
div><div class=3D"gmail_default" style=3D"font-size:small">platforms.</div>=
<div class=3D"gmail_default" style=3D"font-size:small"><br></div><div class=
=3D"gmail_default" style=3D"font-size:small">From my experience,=C2=A0if yo=
u limited this test only run with small</div><div class=3D"gmail_default" s=
tyle=3D"font-size:small">machine (e.g. RAM &lt;=3D 32G), that performs well=
 with whatever</div><div class=3D"gmail_default" style=3D"font-size:small">=
bare metal or VM, no timeout ever.</div><br></div><div>=C2=A0</div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex">
<br>
tst_test.c:1524: TINFO: Timeout per run is 0h 00m 30s<br>
ioctl_sg01.c:81: TINFO: Found SCSI device /dev/sg1<br>
Test timeouted, sending SIGKILL!<br>
tst_test.c:1575: TINFO: If you are running on slow machine, try exporting L=
TP_TIMEOUT_MUL &gt; 1<br>
tst_test.c:1577: TBROK: Test killed! (timeout?)<br>
<br>
Summary:<br>
passed=C2=A0 =C2=A00<br>
failed=C2=A0 =C2=A00<br>
broken=C2=A0 =C2=A01<br>
skipped=C2=A0 0<br>
warnings 0<br>
<br>
@lkft I haven&#39;t find dmesg after starting running tests in the test det=
ails [2].<br>
Is there any? I really like you keep the history [3], thanks! It&#39;d be g=
reat if<br>
you could print the test name into dmesg, so that it can be visible which t=
est<br>
caused particular message / kernel oops.<br>
<br>
Also, it&#39;d be great if you could put some header for each test with the=
 test<br>
name or at least blank line to separate the end of the summary.<br>
<br>
Kind regards,<br>
Petr<br>
<br>
[1] <a href=3D"https://qa-reports.linaro.org/lkft/ltp/build/cea142b/testrun=
/11956785/suite/ltp-cve/test/cve-2018-1000204/log" rel=3D"noreferrer" targe=
t=3D"_blank">https://qa-reports.linaro.org/lkft/ltp/build/cea142b/testrun/1=
1956785/suite/ltp-cve/test/cve-2018-1000204/log</a><br>
[2] <a href=3D"https://qa-reports.linaro.org/lkft/ltp/build/cea142b/testrun=
/11956785/suite/ltp-cve/test/cve-2018-1000204/details/" rel=3D"noreferrer" =
target=3D"_blank">https://qa-reports.linaro.org/lkft/ltp/build/cea142b/test=
run/11956785/suite/ltp-cve/test/cve-2018-1000204/details/</a><br>
[3] <a href=3D"https://qa-reports.linaro.org/lkft/ltp/build/cea142b/testrun=
/11956785/suite/ltp-cve/test/cve-2018-1000204/history/" rel=3D"noreferrer" =
target=3D"_blank">https://qa-reports.linaro.org/lkft/ltp/build/cea142b/test=
run/11956785/suite/ltp-cve/test/cve-2018-1000204/history/</a><br>
<br>
<br>
&gt; ## Metric Regressions (compared to 98140f3)<br>
&gt; No metric regressions found.<br>
<br>
&gt; Reported-by: Linux Kernel Functional Testing &lt;<a href=3D"mailto:lkf=
t@linaro.org" target=3D"_blank">lkft@linaro.org</a>&gt;<br>
<br>
<br>
&gt; ## Test Fixes (compared to 98140f3)<br>
&gt; * qemu_arm64, ltp-controllers<br>
&gt;=C2=A0 =C2=A0- cpuacct_100_100<br>
<br>
<br>
&gt; ## Metric Fixes (compared to 98140f3)<br>
&gt; No metric fixes found.<br>
<br>
&gt; ## Test result summary<br>
&gt; total: 12630, pass: 10739, fail: 161, skip: 1730, xfail: 0<br>
<br>
&gt; ## Build Summary<br>
<br>
&gt; ## Test suites summary<br>
&gt; * log-parser-boot<br>
&gt; * log-parser-test<br>
&gt; * ltp-cap_bounds<br>
&gt; * ltp-commands<br>
&gt; * ltp-containers<br>
&gt; * ltp-controllers<br>
&gt; * ltp-cpuhotplug<br>
&gt; * ltp-crypto<br>
&gt; * ltp-cve<br>
&gt; * ltp-dio<br>
&gt; * ltp-fcntl-locktests<br>
&gt; * ltp-filecaps<br>
&gt; * ltp-fs<br>
&gt; * ltp-fs_bind<br>
&gt; * ltp-fs_perms_simple<br>
&gt; * ltp-fsx<br>
&gt; * ltp-hugetlb<br>
&gt; * ltp-io<br>
&gt; * ltp-ipc<br>
&gt; * ltp-math<br>
&gt; * ltp-mm<br>
&gt; * ltp-nptl<br>
&gt; * ltp-pty<br>
&gt; * ltp-sched<br>
&gt; * ltp-securebits<br>
&gt; * ltp-syscalls<br>
&gt; * ltp-tracing<br>
<br>
-- <br>
Mailing list info: <a href=3D"https://lists.linux.it/listinfo/ltp" rel=3D"n=
oreferrer" target=3D"_blank">https://lists.linux.it/listinfo/ltp</a><br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div><div>Li =
Wang<br></div></div></div></div>

--000000000000efd5c105e8ff4b52--


--===============0991018431==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0991018431==--

