Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BA74C43334
	for <ltp@archiver.kernel.org>; Tue, 21 Jun 2022 09:46:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AA3EF3C9430
	for <ltp@archiver.kernel.org>; Tue, 21 Jun 2022 11:45:59 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EE2ED3C2806
 for <ltp@lists.linux.it>; Tue, 21 Jun 2022 11:45:46 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B85096008FF
 for <ltp@lists.linux.it>; Tue, 21 Jun 2022 11:45:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1655804744;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FqeYmmMJZvDlwM9aYfjLGNyBjUY23GS1jDv6RCGhMoQ=;
 b=bKZi7Hg4Tmu27X5bc4C1mnSJ8c85Liq6VnAFOJSf/cy3cj0m1aaxKhAO2/WTR09mYjrdom
 G4VU3NvZm4z+hCHBWhoCfh1ni+u21RZIn+gj6/oiB22TVRgXwXuKfxPBc1vvJNXnN25lvG
 VxunmAIRhcDbCJ6B0k4tfikFwiJUKy0=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-373-65E61MV0Pw6zsp0hwsRT-g-1; Tue, 21 Jun 2022 05:45:42 -0400
X-MC-Unique: 65E61MV0Pw6zsp0hwsRT-g-1
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-3178d560c16so80499187b3.8
 for <ltp@lists.linux.it>; Tue, 21 Jun 2022 02:45:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FqeYmmMJZvDlwM9aYfjLGNyBjUY23GS1jDv6RCGhMoQ=;
 b=3EQWSRUbB5tEiP8PTv9E6AqaInOXVN6HQP5crwru9L6h1p5thp/Y2KVjnzLWBPDNhg
 p6/rbij+Sbeg9cm0dtzN27yGLlp4shokRE8eJP5C5kVWJGOZo3arjuWdissXntskNFyM
 D85n1Ww0bL3PIjGSRbOyC7lneL6IpVgtJQOECXXshszDBZC/ptR4RAW/hHmbbSbURAOg
 qcxhtZeDTolnueMVl+mHzsd4onD0uXrLMlQtLus04DGCCYAEOP11ijQVZ5VKkJaD6+L2
 Juj6R17UuZDLHZbzI9lyEBtvGcIOLC2sw1mAvDpvVNer7XLpyTEH7Oh7Q8Gq2fZ6rtbR
 31gg==
X-Gm-Message-State: AJIora/7GczHpO+S22/1JqqBqyQd56CwUnMk7hgxGhj+nqPoAtIw08mD
 v1+sE2gRJFZJy1P/H5k8m7oKWJJ5dvP4OuYxCgAO9T3YPgcC+8h6Al6q3xV+6dOjN398jXKZuRY
 RLZF8EyLUq+Vl4NPdLJ+SonTgJeI=
X-Received: by 2002:a0d:d588:0:b0:317:a4ab:f27c with SMTP id
 x130-20020a0dd588000000b00317a4abf27cmr16649344ywd.53.1655804741838; 
 Tue, 21 Jun 2022 02:45:41 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tL5sVN20ZsAyADhdoGo0t0+v3D3dl3rpgEj8Oj9FBYcm6irWnAHDKpQZEFGMVAzU8YGXjT1lXdQD0oZ64vYCQ=
X-Received: by 2002:a0d:d588:0:b0:317:a4ab:f27c with SMTP id
 x130-20020a0dd588000000b00317a4abf27cmr16649312ywd.53.1655804741495; Tue, 21
 Jun 2022 02:45:41 -0700 (PDT)
MIME-Version: 1.0
References: <010001816f3c352e-f5ee78c6-1425-42f5-b673-409a0a92ef74-000000@email.amazonses.com>
 <11d7d8a6-c062-03aa-7e7c-f7d3c3c2f095@jv-coder.de>
 <CAASaF6wyH7YJtNaGfR9n-yhnHv9Pc7BvCMYe1EWvwnCMtNhfDQ@mail.gmail.com>
 <60876a29-d589-1de9-b4fd-a9000b8e7d68@jv-coder.de> <871qvi5r97.fsf@suse.de>
In-Reply-To: <871qvi5r97.fsf@suse.de>
From: Li Wang <liwang@redhat.com>
Date: Tue, 21 Jun 2022 17:45:30 +0800
Message-ID: <CAEemH2c=xxHrGiqtaRjM89S==JfsODnJ=D9b+mzaF68sjGRVJw@mail.gmail.com>
To: Richard Palethorpe <rpalethorpe@suse.de>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [REGRESSION] lkft ltp for 6763a36
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
Content-Type: multipart/mixed; boundary="===============0166176730=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0166176730==
Content-Type: multipart/alternative; boundary="0000000000006f461e05e1f21512"

--0000000000006f461e05e1f21512
Content-Type: text/plain; charset="UTF-8"

On Tue, Jun 21, 2022 at 4:56 PM Richard Palethorpe <rpalethorpe@suse.de>
wrote:

> Hello,
>
> Joerg Vehlow <lkml@jv-coder.de> writes:
>
> > Hi Jan,
> >
> > Am 6/21/2022 um 9:22 AM schrieb Jan Stancek:
> >> On Tue, Jun 21, 2022 at 9:15 AM Joerg Vehlow <lkml@jv-coder.de> wrote:
> >>>
> >>> Hi,
> >>>
> >>> Am 6/17/2022 um 3:17 AM schrieb lkft@linaro.org:
> >>>> * qemu_i386, ltp-fs-tests
> >>>>   - read_all_proc
> >>> I've seen this test fail a lot, has anyone ever tried to analyze it? I
> >>> was unable to reproduce the problem when running the test in isolation.
> >>
> >> I see it hit timeouts too (read_all_sys as well). I think it needs
> >> runtime restored to 5minutes as well, atm. it has 30s.
> > Didn't think about that, but at least for the failures I've seen, this
> > is not the reason. The message printed by the test is "Test timeout 5
> > minutes exceeded."
> >
> > Joerg
>
> The main issue with read_all is that it also acts as a stress
> test. Reading some files in proc and sys is very resource intensive
> (e.g. due to lock contention) and varies depending on what state the
> system is in. On some systems this test will take a long time. Also
> there are some files which have to be filtered from the test. This
> varies by system as well.
>

Does it make sense to have a lite version of read_all_sys?
which may only go through files sequentially or under slight stress.

With regard to this stressful read_all, I guess we can put into a dedicated
set and run separately in stress testing.

-- 
Regards,
Li Wang

--0000000000006f461e05e1f21512
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Tue, Jun 21, 2022 at 4:56 PM Richard Palethorpe =
&lt;<a href=3D"mailto:rpalethorpe@suse.de">rpalethorpe@suse.de</a>&gt; wrot=
e:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hello,<br>
<br>
Joerg Vehlow &lt;<a href=3D"mailto:lkml@jv-coder.de" target=3D"_blank">lkml=
@jv-coder.de</a>&gt; writes:<br>
<br>
&gt; Hi Jan,<br>
&gt;<br>
&gt; Am 6/21/2022 um 9:22 AM schrieb Jan Stancek:<br>
&gt;&gt; On Tue, Jun 21, 2022 at 9:15 AM Joerg Vehlow &lt;<a href=3D"mailto=
:lkml@jv-coder.de" target=3D"_blank">lkml@jv-coder.de</a>&gt; wrote:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Hi,<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Am 6/17/2022 um 3:17 AM schrieb <a href=3D"mailto:lkft@linaro.=
org" target=3D"_blank">lkft@linaro.org</a>:<br>
&gt;&gt;&gt;&gt; * qemu_i386, ltp-fs-tests<br>
&gt;&gt;&gt;&gt;=C2=A0 =C2=A0- read_all_proc<br>
&gt;&gt;&gt; I&#39;ve seen this test fail a lot, has anyone ever tried to a=
nalyze it? I<br>
&gt;&gt;&gt; was unable to reproduce the problem when running the test in i=
solation.<br>
&gt;&gt; <br>
&gt;&gt; I see it hit timeouts too (read_all_sys as well). I think it needs=
<br>
&gt;&gt; runtime restored to 5minutes as well, atm. it has 30s.<br>
&gt; Didn&#39;t think about that, but at least for the failures I&#39;ve se=
en, this<br>
&gt; is not the reason. The message printed by the test is &quot;Test timeo=
ut 5<br>
&gt; minutes exceeded.&quot;<br>
&gt;<br>
&gt; Joerg<br>
<br>
The main issue with read_all is that it also acts as a stress<br>
test. Reading some files in proc and sys is very resource intensive<br>
(e.g. due to lock contention) and varies depending on what state the<br>
system is in. On some systems this test will take a long time. Also<br>
there are some files which have to be filtered from the test. This<br>
varies by system as well.<br></blockquote><div><br></div><div class=3D"gmai=
l_default" style=3D"font-size:small"> Does it make sense to have a lite ver=
sion of read_all_sys?</div><div class=3D"gmail_default" style=3D"font-size:=
small">which may only go through files sequentially or under=C2=A0slight=C2=
=A0stress.</div><div class=3D"gmail_default" style=3D"font-size:small"><br>=
</div><div class=3D"gmail_default" style=3D"font-size:small">With regard to=
 this stressful read_all, I guess we can=C2=A0put into a dedicated</div><di=
v class=3D"gmail_default" style=3D"font-size:small">set and run separately =
in stress testing.</div></div><div><br></div>-- <br><div dir=3D"ltr" class=
=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<b=
r></div></div></div></div>

--0000000000006f461e05e1f21512--


--===============0166176730==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0166176730==--

