Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0EB8C433EF
	for <ltp@archiver.kernel.org>; Tue, 14 Dec 2021 06:32:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7BD3D3C104E
	for <ltp@archiver.kernel.org>; Tue, 14 Dec 2021 07:32:29 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E20B73C042D
 for <ltp@lists.linux.it>; Tue, 14 Dec 2021 07:32:19 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E7D9D1A014B2
 for <ltp@lists.linux.it>; Tue, 14 Dec 2021 07:32:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1639463537;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E15QgULcL7w7S9asHYORAEphJ/GVFyU1JXeY7tOTFoA=;
 b=aFU6QOMnQk7VOEPeOKcEfjFnADZORmFxez+FR1q/GSggk9tdUIxfdkEKMyA8tYYqnAJG/m
 BPP9lCz8GntjW5aWhE/10d73zhAfN9FewFZvQ608G48lnYcBsc4JaT8mmPTOWPfZAyK+5C
 Qw9XHy3JdBa25v1jYuODSIdhRVxU/cg=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-221-iPr-tXPpM4KQOdIlNYCwKg-1; Tue, 14 Dec 2021 01:32:13 -0500
X-MC-Unique: iPr-tXPpM4KQOdIlNYCwKg-1
Received: by mail-yb1-f198.google.com with SMTP id
 r18-20020a25ac52000000b005c9047c420bso34973021ybd.4
 for <ltp@lists.linux.it>; Mon, 13 Dec 2021 22:32:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=E15QgULcL7w7S9asHYORAEphJ/GVFyU1JXeY7tOTFoA=;
 b=etMft83FyTyShNPnyHmK83gVeCaq4UQdg4Zfv7THbNjIYR9TlNNC261E54TZXBYvvc
 +ohloQqOVhTMufUYjFQLVVhyDeTUusnR+/7FsDxm6kqNpqOURlN7EeBe9KyUj8n1qbXS
 FqVMdJURB76p3pldUGUpwKFeZPT5lupifOg8hXUml1ecvKtxeZiIo0vFZtvSNr2aNTeT
 gnLoSB1dMuK1rp8qJ8zUtIR6mIfhuFPPF0D88MRoX+ECKHirha5xra4Y8J6Fm1dRRprB
 VCxLXSxRlalRw5zAn5cN4q6RB1MmAphycEF5qOv48S45HSp2nHrEqQNT6ULPuHI0a9of
 w/Yw==
X-Gm-Message-State: AOAM530de8q9qOro1kBUCi4+peUHzbKhJhK/YZeO/KpEopUcukYuFcYP
 wKOkpGatat3zt9ffyWH/sGFMpIyIKr/ZbhbUpGQGWDeRynprLw/fkJQBw1Ml//MSWgNd7Kbf/je
 cdBx5elONf6vW6AD1CAccNL3jjDo=
X-Received: by 2002:a25:ce94:: with SMTP id x142mr3788694ybe.145.1639463532808; 
 Mon, 13 Dec 2021 22:32:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwMtD2DOd+dh9NR3ndXpDboT6GpI1KZStFxU7cp3dAC5P9519tjrxK1iMtdO0+vSp46/urCh1qzDHndwJrHnrc=
X-Received: by 2002:a25:ce94:: with SMTP id x142mr3788672ybe.145.1639463532484; 
 Mon, 13 Dec 2021 22:32:12 -0800 (PST)
MIME-Version: 1.0
References: <CAEemH2d+-rqscLPdn8q0AEkKaCSkCZ-pET_E=eWWN7Z=aB1k0w@mail.gmail.com>
 <CAASaF6zRCAYo3f4bRc+mxKHnprwtworq-fCif81ECZUWawumbQ@mail.gmail.com>
 <85404e01-f8f0-7209-8ce1-9e8a2a416e86@suse.cz> <Ybdxt/KBUQ6ZKHmY@yuki>
In-Reply-To: <Ybdxt/KBUQ6ZKHmY@yuki>
From: Li Wang <liwang@redhat.com>
Date: Tue, 14 Dec 2021 14:31:59 +0800
Message-ID: <CAEemH2db+BWoHJBGCfohA6EvnuCmPk9OZMHHCaz=+t_aeN5TsQ@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
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
Content-Type: multipart/mixed; boundary="===============0021170602=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0021170602==
Content-Type: multipart/alternative; boundary="00000000000079f4b705d3155971"

--00000000000079f4b705d3155971
Content-Type: text/plain; charset="UTF-8"

On Tue, Dec 14, 2021 at 12:15 AM Cyril Hrubis <chrubis@suse.cz> wrote:


> > Protecting the test harness is a bad idea because oom_score_adj is
> > inherited by child processes and it'll affect other tests as well. Given
> > the nature of OOM tests, I'd rather not assume that the protection will
> > be properly removed at the end.
>
> This should be easily doable since the test library forks right before
> it executes the test, so we have a single place where the score has to
> be reset.
>

I think so. And we can even export the function as global to
make it easy to enable/cancel the OOM protection for any
process at any time we wanted. Then, just resetting the child
process oom_score_adj to 0 can avoid to inherited from the
lib-process score as well.

e.g.

    void tst_enable_oom_protection(pid_t pid)
    void tst_cancel_oom_protection(pid_t pid)



>
> For new library tests there is a process that does nothing but waits for
> the actuall test pid to finish and kills it on timeout. It really makes
> sense to protect this exact process and maybe even mlock() it into the
> memory.
>

+1


-- 
Regards,
Li Wang

--00000000000079f4b705d3155971
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Tue, Dec 14, 2021 at 12:15 AM Cyril Hrubis &lt;<=
a href=3D"mailto:chrubis@suse.cz">chrubis@suse.cz</a>&gt; wrote:</div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; Protecting the test harness is a bad idea because oom_score_adj is<br>
&gt; inherited by child processes and it&#39;ll affect other tests as well.=
 Given<br>
&gt; the nature of OOM tests, I&#39;d rather not assume that the protection=
 will<br>
&gt; be properly removed at the end.<br>
<br>
This should be easily doable since the test library forks right before<br>
it executes the test, so we have a single place where the score has to<br>
be reset.<br></blockquote><div><br></div><div><div class=3D"gmail_default" =
style=3D"font-size:small">I think so. And we can even export the function a=
s global=C2=A0to</div><div class=3D"gmail_default" style=3D"font-size:small=
">make it easy to enable/cancel the OOM protection for any=C2=A0</div><div =
class=3D"gmail_default" style=3D"font-size:small">process at any time we wa=
nted. Then, just resetting the child</div><div class=3D"gmail_default" styl=
e=3D"font-size:small">process oom_score_adj to 0 can avoid to inherited fro=
m the</div><div class=3D"gmail_default" style=3D"font-size:small">lib-proce=
ss score as well.</div><div class=3D"gmail_default" style=3D"font-size:smal=
l"><br></div><div class=3D"gmail_default" style=3D"font-size:small">e.g.</d=
iv><div class=3D"gmail_default" style=3D"font-size:small"><br></div><div cl=
ass=3D"gmail_default" style=3D"font-size:small">=C2=A0 =C2=A0 void tst_enab=
le_oom_protection(pid_t pid)</div><div class=3D"gmail_default" style=3D"fon=
t-size:small">=C2=A0 =C2=A0 void tst_cancel_oom_protection(pid_t pid)</div>=
<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">
<br>
For new library tests there is a process that does nothing but waits for<br=
>
the actuall test pid to finish and kills it on timeout. It really makes<br>
sense to protect this exact process and maybe even mlock() it into the<br>
memory.<br></blockquote><div><br></div><div class=3D"gmail_default" style=
=3D"font-size:small">+1</div><div class=3D"gmail_default" style=3D"font-siz=
e:small"><br></div></div><div><br></div>-- <br><div dir=3D"ltr" class=3D"gm=
ail_signature"><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></di=
v></div></div></div>

--00000000000079f4b705d3155971--


--===============0021170602==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0021170602==--

