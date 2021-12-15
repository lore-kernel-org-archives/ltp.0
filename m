Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5602FC433F5
	for <ltp@archiver.kernel.org>; Wed, 15 Dec 2021 07:50:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 39B883C8F6A
	for <ltp@archiver.kernel.org>; Wed, 15 Dec 2021 08:50:28 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3873C3C8DD1
 for <ltp@lists.linux.it>; Wed, 15 Dec 2021 08:50:12 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 7789560083D
 for <ltp@lists.linux.it>; Wed, 15 Dec 2021 08:50:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1639554609;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g/3xvew+IayN9K3f9EZZEJUoNJcDUrYb4XHD13MnCcU=;
 b=BrBMwEYsVcpKTvccPbj1DPcjQl9fCfUT7n8DnfjwW+ftPgp3RH8GlK6MBC5XzC4QrRQcNB
 VBQl0sUDc9wKaAQe3gkit04WjIqst7+Ojk5Uc5Z93GNKiVy1U5t80dAaVSjoAbTG83rM+g
 HdgFS6YyhBp5JCHa9ABkNDOGS6CflUQ=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-461-ONbywlIQPvOJXWxezQ4Gvg-1; Wed, 15 Dec 2021 02:50:08 -0500
X-MC-Unique: ONbywlIQPvOJXWxezQ4Gvg-1
Received: by mail-yb1-f199.google.com with SMTP id
 j204-20020a2523d5000000b005c21574c704so41477831ybj.13
 for <ltp@lists.linux.it>; Tue, 14 Dec 2021 23:50:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=g/3xvew+IayN9K3f9EZZEJUoNJcDUrYb4XHD13MnCcU=;
 b=FMK0G7PVv+4IiHmj03fPnWhuCpMZstzG75NgPFz+nDOrk/+8FYJZaYdsW75PXRl1yW
 SDVcU8DNWWHNGT7yoI+DpBsesXf4hL3w2ePbnsvbA12dmte58qLwUCQTyPPbs118LxeH
 20bYYLyPE2l9FeiF9KNk1Xhh/ZUkTPGKMbxTfqLS1B5gSYuKKOBAeZnnhLebGr7DOo8g
 BATlB4RKfS8FZXXU9Wju/K/qVkWeGYexoknZvBx9USQnDE5A6/Inly5QPVkLSsL/2+gj
 XBb71mYqdWrdUmgs8O45oOVjXbT4WYemBUumzBx9o3hXtGQ7f4GQIwlSMQYvgQzX5rlt
 I6AQ==
X-Gm-Message-State: AOAM531ArrJUabRSd1mMEH3LEIroFsjpHFqVJbGnyvDZxvxHZXUMwdDv
 NJGtivq0VzWb9i+A7XOpEFcfkAQZBx8y6mY9dtKLecojwyWpsPorfQTC7HewnQHIhh9WXQeUeR4
 amhLB0/cSazexLUwXLbWP7DDKUUw=
X-Received: by 2002:a25:9bc9:: with SMTP id w9mr4433112ybo.398.1639554607770; 
 Tue, 14 Dec 2021 23:50:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwJcnhv6x4VOOD5eHP1pLizEMyOuYUJvNHMANiKk77LcR9E4FdmPV8zj2XHJvFdOOIrQs4vBFT4VgqUCE7JY34=
X-Received: by 2002:a25:9bc9:: with SMTP id w9mr4433095ybo.398.1639554607580; 
 Tue, 14 Dec 2021 23:50:07 -0800 (PST)
MIME-Version: 1.0
References: <20211214144309.6704-1-pvorel@suse.cz>
 <20211214144309.6704-4-pvorel@suse.cz>
 <YbjAOffrWpsMvinQ@yuki> <YbjKV7yUJS+njaCY@pevik>
In-Reply-To: <YbjKV7yUJS+njaCY@pevik>
From: Li Wang <liwang@redhat.com>
Date: Wed, 15 Dec 2021 15:49:54 +0800
Message-ID: <CAEemH2eXMWXt5GeY8EXaoPbS66-fju71iY+hJERNKMip+DqxLA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 3/3] lib: Add support for debugging
 .all_filesystems
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
Content-Type: multipart/mixed; boundary="===============1626115722=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1626115722==
Content-Type: multipart/alternative; boundary="000000000000f99e8c05d32a8d10"

--000000000000f99e8c05d32a8d10
Content-Type: text/plain; charset="UTF-8"

On Wed, Dec 15, 2021 at 12:46 AM Petr Vorel <pvorel@suse.cz> wrote:

> Hi Cyril, Li,
>
> > Hi!
> > > +| 'LTP_SINGLE_FS_TYPE'  | Testing only specified filesystem instead
> all
> >                                          ^   ^
> >                                        |   "specifies"
> >                                        there should be comma or dash here
>
> I meant "specific", i.e. Testing only specific filesystem instead all
> supported,
>

+1



> but "Testing only - specifies filesystem instead all supported" makes more
> sense.
>

Hmm, I think it also makes sense to people who care about the
only one filesystem on their product. So this should _NOT_ be limit
for test/debug, because it can help to reduce testing time for specific
requirements.

Let's just provide a variable and leave the usage to users:).



>
> > Other than that the rest looks fine, for the patchset:
> > Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
>
> Thanks! Waiting for Li and others for input before merging it.
>

Good work.
Reviewed-by: Li Wang <liwang@redhat.com>


-- 
Regards,
Li Wang

--000000000000f99e8c05d32a8d10
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Wed, Dec 15, 2021 at 12:46 AM Petr Vorel &lt;<a =
href=3D"mailto:pvorel@suse.cz">pvorel@suse.cz</a>&gt; wrote:<br></div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">Hi Cyril, Li,<br>
<br>
&gt; Hi!<br>
&gt; &gt; +| &#39;LTP_SINGLE_FS_TYPE&#39;=C2=A0 | Testing only specified fi=
lesystem instead all<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 ^=C2=A0 =C2=A0^<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 =C2=A0&quot;specifies&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 there=
 should be comma or dash here<br>
<br>
I meant &quot;specific&quot;, i.e. Testing only specific filesystem instead=
 all supported,<br></blockquote><div><br></div><div><div class=3D"gmail_def=
ault" style=3D"font-size:small">+1</div><br></div><div>=C2=A0</div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex">
but &quot;Testing only - specifies filesystem instead all supported&quot; m=
akes more<br>
sense.<br></blockquote><div><br></div><div><div class=3D"gmail_default" sty=
le=3D"font-size:small">Hmm, I think it also makes sense to people who care =
about the</div><div class=3D"gmail_default" style=3D"font-size:small">only =
one filesystem on their product. So this should _NOT_ be limit</div><div cl=
ass=3D"gmail_default" style=3D"font-size:small">for test/debug, because it =
can help to reduce testing time for specific=C2=A0</div><div class=3D"gmail=
_default" style=3D"font-size:small">requirements.=C2=A0</div><div class=3D"=
gmail_default" style=3D"font-size:small"><br></div><div class=3D"gmail_defa=
ult" style=3D"font-size:small">Let&#39;s just provide a variable and=C2=A0l=
eave the usage to users:).</div><br></div><div>=C2=A0</div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">
<br>
&gt; Other than that the rest looks fine, for the patchset:<br>
&gt; Reviewed-by: Cyril Hrubis &lt;<a href=3D"mailto:chrubis@suse.cz" targe=
t=3D"_blank">chrubis@suse.cz</a>&gt;<br>
<br>
Thanks! Waiting for Li and others for input before merging it.<br></blockqu=
ote><div><br></div><div class=3D"gmail_default" style=3D"font-size:small">G=
ood work.</div><div class=3D"gmail_default" style=3D"font-size:small"></div=
><div><span class=3D"gmail_default" style=3D"font-size:small"></span>Review=
ed-by: Li Wang &lt;<a href=3D"mailto:liwang@redhat.com" target=3D"_blank">l=
iwang@redhat.com</a>&gt;</div><div><br></div></div><div><br></div>-- <br><d=
iv dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br>=
</div><div>Li Wang<br></div></div></div></div>

--000000000000f99e8c05d32a8d10--


--===============1626115722==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1626115722==--

