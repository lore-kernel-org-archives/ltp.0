Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDD64C433EF
	for <ltp@archiver.kernel.org>; Wed, 12 Jan 2022 09:47:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 424FB3C9493
	for <ltp@archiver.kernel.org>; Wed, 12 Jan 2022 10:47:03 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2F85A3C8BBB
 for <ltp@lists.linux.it>; Wed, 12 Jan 2022 10:46:52 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B1D13200045
 for <ltp@lists.linux.it>; Wed, 12 Jan 2022 10:46:51 +0100 (CET)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id A7A203F31F
 for <ltp@lists.linux.it>; Wed, 12 Jan 2022 09:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1641980803;
 bh=u5ioUUpyJ5qrsZTphOyoKX/ce6k/yLuCulvhEL01bWk=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=mFFceVZpnXrYeKK15KUQZH0cFYLcXnoLw8oKd3z/quZeRpVKDmxcRO+OznBeprmrF
 HLMncEXSfQ0X/36FjPDo5EZIPjKMXeNg9On5dmfGYMyDutyfK6a5VhhfiUAjDpE+3O
 fPhVl60dYIBdxoHUhaQetX55xK2WF/moI0aKdB9W2U388gH8LoDffmUvkvurffZgfV
 lVwShmP3D28woQAaFIzwq2hZd7y29BZOg/NJv87+5K0jOGZxWmIvHYr8iQsHxF7S/U
 9VogcjKA3GzRKEAJ4/FZisRaBUemmsS9vjjygJjFI/NHXhlwZzU3OwVHwa/149x1UT
 l0jTfg64PVYDw==
Received: by mail-ed1-f70.google.com with SMTP id
 q15-20020a056402518f00b003f87abf9c37so1756877edd.15
 for <ltp@lists.linux.it>; Wed, 12 Jan 2022 01:46:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=u5ioUUpyJ5qrsZTphOyoKX/ce6k/yLuCulvhEL01bWk=;
 b=3JlJSgYsQdcLJ1Xvf+Wcs/2WzTCSLSQYDGTw3a6TGopLe9G1MRqCOMY/HIO+w5i8I1
 VsbCwCm1GSoHQKFnwW27jNJ64r1VsT2f1r7lm247yUYgMstKZUaFsPGXJq0mUVayNaip
 PkNkcuA+uFvB8vuAt1HG3LrWHPZoHoer6N4QvHXbaOVuCdXoWzawABZgzhJ7aWr9UL+x
 /rn+z11aR1kaTaP91vvNjMsFG1wTHHhM7z5ivfqjB7rxceHHmHbqbWJSIZYAe3X6nKz1
 ojZos5p3JNWFrEE0WyoeslXxLcc2T6YUD/vAUewzyfA3WNIIUhp+OuRq656WFw2I7q0D
 GhOw==
X-Gm-Message-State: AOAM532k6m6J9kB3A1sdxpCx/4ZtR3GRRfMga5l7kS3JytvM/HwwlgV3
 i4ePEzvxuGUT9QnhEiLdD/TMph206f0nnGXemLwFiXNXnEW497aQID8xwoB5Yw2r4O5a2APD9r5
 YkA8oQLdICCownUxoOuA/pVbwb9kr3ll/E3LVH8XxX7K9
X-Received: by 2002:a50:9e47:: with SMTP id z65mr115096ede.328.1641980802872; 
 Wed, 12 Jan 2022 01:46:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyFs87JM8x4tkveTed3VsGmItWVBlKIqGsQ3KBKzl7UlGODxUjzJJ6xO1FP2vDSWXDzKVZK7NaTF81EvzOj2R0=
X-Received: by 2002:a50:9e47:: with SMTP id z65mr115091ede.328.1641980802721; 
 Wed, 12 Jan 2022 01:46:42 -0800 (PST)
MIME-Version: 1.0
References: <cover.1641376050.git.luke.nowakowskikrijger@canonical.com>
 <91b9d5928cd129ebb21430a60e715113a6a6f6b7.1641376050.git.luke.nowakowskikrijger@canonical.com>
 <CAEemH2dHHNz25Vacu3r49MHgyd+Urk3c=NHMwA6zV=FFAQSpQw@mail.gmail.com>
In-Reply-To: <CAEemH2dHHNz25Vacu3r49MHgyd+Urk3c=NHMwA6zV=FFAQSpQw@mail.gmail.com>
From: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
Date: Wed, 12 Jan 2022 01:46:05 -0800
Message-ID: <CADS1e3f0UMMOyovAGovGp33hQ6ovt1W6h0-RUSVkQRsHWpy=DA@mail.gmail.com>
To: Li Wang <liwang@redhat.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 5/6] tools: Implement tst_cgctl binary utility
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
Content-Type: multipart/mixed; boundary="===============0746162177=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0746162177==
Content-Type: multipart/alternative; boundary="000000000000797ec305d55f728d"

--000000000000797ec305d55f728d
Content-Type: text/plain; charset="UTF-8"

Hi Li,

On Tue, Jan 11, 2022 at 4:43 AM Li Wang <liwang@redhat.com> wrote:

> Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com> wrote:
>
> >  tools/cgroup/Makefile    |  7 ++++
> >  tools/cgroup/tst_cgctl.c | 69 ++++++++++++++++++++++++++++++++++++++++
>
> Looks like putting this tst_cgctl.c in testcase/lib/ will be better,
> we have no necessary to create it under a bit far directory, and
> that tool/ is more generic for LTP, but this process is only for
> shell tests.
>
>
Yeah I will move it over here. I was not sure exactly where it should go.

> +static int cgctl_cleanup(const char *config)
> > +{
> > +    tst_cgroup_scan();
> > +    tst_cgroup_load_config(config);
>
> This tst_cgroup_load_config() does not work as expected.
> From my manual check, the ltp and drain dir have been created
> but it prints " Created_Ltp_Dir=no Created_Drain_Dir=no" strings.
>
> ...
> Detected Roots:
> /sys/fs/cgroup/memory Mounted_Root=no Created_Ltp_Dir=no
> Created_Drain_Dir=no Test_Id=test-1801
> ...
>
>
>
Hm, I'm not sure what this could be. Are you sure when you were reading the
printed info it was in the same invocation as when it was being created?
Because the tst_cgroup_print_config is just pretty directly printing out
the state of the cgroup framework.

> +    tst_cgroup_cleanup();
>
> This does not work as expected too, but the problem should exist
> in previous patches. Anyway, I will look into the details tomorrow.
>
> # ./tst_cgctl cleanup "$_cgroup_state"
> tst_cgroup.c:414: TBROK: Could not find root from config. Roots
> changing between calls?
>
>
Was "/sys/fs/cgroup/cpu,cpuacct" one of the roots that was printed out?
Because if so the way I have it now it would not be able to parse that. I
will look into fixing this.


> > +
> > +    return 0;
> > +}
>
>
> --
> Regards,
> Li Wang
>
>
Thanks again for review,

- Luke

--000000000000797ec305d55f728d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Li, <br></div><br><div class=3D"gmail_quote"><div =
dir=3D"ltr" class=3D"gmail_attr">On Tue, Jan 11, 2022 at 4:43 AM Li Wang &l=
t;<a href=3D"mailto:liwang@redhat.com">liwang@redhat.com</a>&gt; wrote:<br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">Luke Nowakowski-Kri=
jger &lt;<a href=3D"mailto:luke.nowakowskikrijger@canonical.com" target=3D"=
_blank">luke.nowakowskikrijger@canonical.com</a>&gt; wrote:<br>
<br>
&gt;=C2=A0 tools/cgroup/Makefile=C2=A0 =C2=A0 |=C2=A0 7 ++++<br>
&gt;=C2=A0 tools/cgroup/tst_cgctl.c | 69 ++++++++++++++++++++++++++++++++++=
++++++<br>
<br>
Looks like putting this tst_cgctl.c in testcase/lib/ will be better,<br>
we have no necessary to create it under a bit far directory, and<br>
that tool/ is more generic for LTP, but this process is only for<br>
shell tests.<br>
<br></blockquote><div><br></div><div>Yeah I will move it over here. I was n=
ot sure exactly where it should go.=C2=A0 <br></div><div><br></div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex">
&gt; +static int cgctl_cleanup(const char *config)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 tst_cgroup_scan();<br>
&gt; +=C2=A0 =C2=A0 tst_cgroup_load_config(config);<br>
<br>
This tst_cgroup_load_config() does not work as expected.<br>
From my manual check, the ltp and drain dir have been created<br>
but it prints &quot; Created_Ltp_Dir=3Dno Created_Drain_Dir=3Dno&quot; stri=
ngs.<br>
<br>
...<br>
Detected Roots:<br>
/sys/fs/cgroup/memory Mounted_Root=3Dno Created_Ltp_Dir=3Dno<br>
Created_Drain_Dir=3Dno Test_Id=3Dtest-1801<br>
...<br>
<br>
<br></blockquote><div><br></div><div>Hm, I&#39;m not sure what this could b=
e. Are you sure when you were reading the printed info it was in the same i=
nvocation as when it was being created? Because the tst_cgroup_print_config=
 is just pretty directly printing out the state of the cgroup framework.</d=
iv><div> <br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; +=C2=A0 =C2=A0 tst_cgroup_cleanup();<br>
<br>
This does not work as expected too, but the problem should exist<br>
in previous patches. Anyway, I will look into the details tomorrow.<br>
<br>
# ./tst_cgctl cleanup &quot;$_cgroup_state&quot;<br>
tst_cgroup.c:414: TBROK: Could not find root from config. Roots<br>
changing between calls?<br>
<br></blockquote><div><br></div><div>Was &quot;/sys/fs/cgroup/cpu,cpuacct&q=
uot; one of the roots that was printed out? Because if so the way I have it=
 now it would not be able to parse that. I will look into fixing this.</div=
><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return 0;<br>
&gt; +}<br>
<br>
<br>
--<br>
Regards,<br>
Li Wang<br>
<br></blockquote><div><br></div><div>Thanks again for review,</div><div><br=
></div><div>- Luke<br></div></div></div>

--000000000000797ec305d55f728d--

--===============0746162177==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0746162177==--
