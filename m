Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 806DFC433F5
	for <ltp@archiver.kernel.org>; Tue,  1 Mar 2022 03:28:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3A7EB3CA184
	for <ltp@archiver.kernel.org>; Tue,  1 Mar 2022 04:28:47 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8DFA53C9DD8
 for <ltp@lists.linux.it>; Tue,  1 Mar 2022 04:28:36 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 11A952002DE
 for <ltp@lists.linux.it>; Tue,  1 Mar 2022 04:28:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646105314;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FfwOSWgZv8IQlPsR3xuM7VoTCcWxNyvq8Kv+/nKc6UQ=;
 b=JM+hH42tzdk8uhOC4kralNDh3G0tDnoGaghrIL3o7k5JrJVLxcaicbPlq47fMmrY6nxOVs
 Z/U5kBZI1BYkNkBPLXSP5PjTSli+c40CcJWTl+cJLi3eQywYIYjRC7lIhysD+PAH0nOMx5
 ECP5JrprmtUiXoe9EexPXWr2SeWTNCk=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-49-TLGP5XSGPZWqkN9S2VWl7w-1; Mon, 28 Feb 2022 22:28:32 -0500
X-MC-Unique: TLGP5XSGPZWqkN9S2VWl7w-1
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-2dbd2b5e180so19810837b3.3
 for <ltp@lists.linux.it>; Mon, 28 Feb 2022 19:28:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FfwOSWgZv8IQlPsR3xuM7VoTCcWxNyvq8Kv+/nKc6UQ=;
 b=p0nAqfp7As8aAkTDgojjuQBFCtGA3zz1U8iuo/rsspy/fkhKt1L2EHrby++pWur49B
 MsFUNNO33eUj9aZdPyrydfVmjSS7VfnpkUcT3qak0VOanSV4WvW+BJ834JLasSGDBx9j
 uX4qXok4UyS2Pp+Le/Wwt0TvIt55+jlLg6Vt/0n21AEquBEBzAewlVzgXlU/RtDR7eGK
 8gdVU+rzvAvSnhbOTof+O+YGFyupbAExoSLyfjpIJeL2itaTfWsZ/y6rR671m3S3df6Z
 HLk3UsLxEw/KPvvHEhVcmHjcVs75iHV00lZ4haPMiI1IsU28TSjaLf7ZbHS3MNWzp7Ht
 fWyA==
X-Gm-Message-State: AOAM5315aet78g1siy1slvjsXSqEenfFz4kUKtDpTczY0mr5Jv6KzTP6
 2OxsmG4yQCKOZ6i7nGQXZ2vtXNBXB7sDZ5uBEcCOblFPQex3kBavEhvmxu7BWctMeH/gUZgQq59
 6ZENXSfaeHQ8dhAI7eKxlkAc8we4=
X-Received: by 2002:a5b:5d0:0:b0:623:c68d:d473 with SMTP id
 w16-20020a5b05d0000000b00623c68dd473mr21809037ybp.506.1646105311941; 
 Mon, 28 Feb 2022 19:28:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzNB8/D11+Rn/TmsUlgPH4HrFW5MTgkdhX/O7MjyxRogmQ4gg1QTMbzQ0d6h2uEeF+eiy0CTkUBARqnp+myi8Q=
X-Received: by 2002:a5b:5d0:0:b0:623:c68d:d473 with SMTP id
 w16-20020a5b05d0000000b00623c68dd473mr21809029ybp.506.1646105311771; Mon, 28
 Feb 2022 19:28:31 -0800 (PST)
MIME-Version: 1.0
References: <20220222124547.14396-1-rpalethorpe@suse.com>
 <20220222124547.14396-2-rpalethorpe@suse.com>
 <20220222145311.GB12037@blackbody.suse.cz> <87y21via5o.fsf@suse.de>
In-Reply-To: <87y21via5o.fsf@suse.de>
From: Li Wang <liwang@redhat.com>
Date: Tue, 1 Mar 2022 11:28:17 +0800
Message-ID: <CAEemH2f1Uue7Et78=_LnT10o7ZSj+wt_ABPcUn3QCwKDgm_6Sg@mail.gmail.com>
To: Richard Palethorpe <rpalethorpe@suse.de>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/2] API/cgroup: Expose memory_recursiveprot V2
 mount opt
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
Cc: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 LTP List <ltp@lists.linux.it>
Content-Type: multipart/mixed; boundary="===============1952730961=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1952730961==
Content-Type: multipart/alternative; boundary="0000000000005f132805d91fc295"

--0000000000005f132805d91fc295
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 28, 2022 at 5:59 PM Richard Palethorpe <rpalethorpe@suse.de>
wrote:

> Hello Michal,
>
> Michal Koutn=C3=BD <mkoutny@suse.com> writes:
>
> > On Tue, Feb 22, 2022 at 12:45:46PM +0000, Richard Palethorpe <
> rpalethorpe@suse.com> wrote:
> >> This changes the effect of trunk nodes' memory.low and memory.min on
> >> their leaf nodes. So we need to change the expectations of some tests.
> >
> > How much are LTP runs striving to not affect environment?
>
> As a general rule we try to leave the environment as we found it so that
> testing is more deterministic. For the CGroup testing in particular I
> decided not to change anything so that we do not have to worry about how
> the init system will react.
>

+1

>
> > IIRC, the memory_recursiveprot is "remountable"; in the long-term it's
> > likely worth watching the memory_recursiveprot behavior only.
> >
> > I.e. instead of carrying two sets of expectations you can warp the
> > environment for the set that's more likely.
> >
> > Michal
>
> Thinking about it, the reason why I was testing without
> memory_recursiveprot is because I'm just direct booting the kernel with
> bash as init and running the test. So the LTP is mounting the CGroups
> and it should mount with memory_recursiveprot, but it is not.
>
> Probably we have to support older products as well which don't have
> memory_recursiveprot enabled and are using V2 (unlikely I guess, but it
> is safest to assume this is the case). So we can still run the test, but
> report CONF instead of PASS/FAIL. This way we will at least still catch
> kernel warnings and panics.
>

This sounds reasonable at least to me.

Reviewed-by: Li Wang <liwang@redhat.com>

--=20
Regards,
Li Wang

--0000000000005f132805d91fc295
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Mon, Feb 28, 2022 at 5:59 PM Richard Palethorpe =
&lt;<a href=3D"mailto:rpalethorpe@suse.de">rpalethorpe@suse.de</a>&gt; wrot=
e:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hello Michal,=
<br>
<br>
Michal Koutn=C3=BD &lt;<a href=3D"mailto:mkoutny@suse.com" target=3D"_blank=
">mkoutny@suse.com</a>&gt; writes:<br>
<br>
&gt; On Tue, Feb 22, 2022 at 12:45:46PM +0000, Richard Palethorpe &lt;<a hr=
ef=3D"mailto:rpalethorpe@suse.com" target=3D"_blank">rpalethorpe@suse.com</=
a>&gt; wrote:<br>
&gt;&gt; This changes the effect of trunk nodes&#39; memory.low and memory.=
min on<br>
&gt;&gt; their leaf nodes. So we need to change the expectations of some te=
sts.<br>
&gt;<br>
&gt; How much are LTP runs striving to not affect environment?<br>
<br>
As a general rule we try to leave the environment as we found it so that<br=
>
testing is more deterministic. For the CGroup testing in particular I<br>
decided not to change anything so that we do not have to worry about how<br=
>
the init system will react.<br></blockquote><div><br></div><div class=3D"gm=
ail_default" style=3D"font-size:small">+1</div><div class=3D"gmail_default"=
 style=3D"font-size:small"></div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">
<br>
&gt; IIRC, the memory_recursiveprot is &quot;remountable&quot;; in the long=
-term it&#39;s<br>
&gt; likely worth watching the memory_recursiveprot behavior only.<br>
&gt;<br>
&gt; I.e. instead of carrying two sets of expectations you can warp the<br>
&gt; environment for the set that&#39;s more likely.<br>
&gt;<br>
&gt; Michal<br>
<br>
Thinking about it, the reason why I was testing without<br>
memory_recursiveprot is because I&#39;m just direct booting the kernel with=
<br>
bash as init and running the test. So the LTP is mounting the CGroups<br>
and it should mount with memory_recursiveprot, but it is not.<br>
<br>
Probably we have to support older products as well which don&#39;t have<br>
memory_recursiveprot enabled and are using V2 (unlikely I guess, but it<br>
is safest to assume this is the case). So we can still run the test, but<br=
>
report CONF instead of PASS/FAIL. This way we will at least still catch<br>
kernel warnings and panics.<br></blockquote><div><br></div><div class=3D"gm=
ail_default" style=3D"font-size:small">This sounds reasonable at least to m=
e.</div><div class=3D"gmail_default" style=3D"font-size:small"><br></div><d=
iv class=3D"gmail_default" style=3D"font-size:small">Reviewed-by: Li Wang &=
lt;<a href=3D"mailto:liwang@redhat.com">liwang@redhat.com</a>&gt;</div></di=
v><div><br></div>-- <br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=
=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></div></div></div>

--0000000000005f132805d91fc295--


--===============1952730961==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1952730961==--

