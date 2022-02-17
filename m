Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED1D5C433EF
	for <ltp@archiver.kernel.org>; Thu, 17 Feb 2022 03:14:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1CC8E3CA079
	for <ltp@archiver.kernel.org>; Thu, 17 Feb 2022 04:14:08 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0F5F63C129E
 for <ltp@lists.linux.it>; Thu, 17 Feb 2022 04:13:58 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id AD9CD1A01759
 for <ltp@lists.linux.it>; Thu, 17 Feb 2022 04:13:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1645067636;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j8CHDcfT/2McVlvi0orDtxujCbWqowF4AiFRrBZI4iw=;
 b=KhAQDwitPOqPDXyq6bKETnpaRnr+qRY7nSwCKe9Vvc/8jhVXudK1VEGkkql2xy7iObraen
 7QlKV4fxFwyME6l+mH78Esm6SfaoMLXk92Yp5g4YHagSIkQyXnJ7wupOV4hJTqQ3O3PEBn
 1Wf98/HSPajFbVsJ15uDKy83bQyTP9g=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-553-vax0CDtPPJKTikmrg1pwdg-1; Wed, 16 Feb 2022 22:13:54 -0500
X-MC-Unique: vax0CDtPPJKTikmrg1pwdg-1
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-2d2c8f1221cso2876987b3.16
 for <ltp@lists.linux.it>; Wed, 16 Feb 2022 19:13:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=j8CHDcfT/2McVlvi0orDtxujCbWqowF4AiFRrBZI4iw=;
 b=PQdDxsE85S/UciOSNRiJXMku1usrwiCWBi+VfsUrikQOw10h6Os6sB9dfr1xZZIfma
 QY2gMuaNhTN1MXoblvUx06pznImsU9IlqivYLnKH0H5+R4yR9f8PThZUq60w2HINHfgJ
 J2X6QEOTKiJzeD4WT2N110c8H1t1DxbRcvUwNT1HamdGdwtkLrIRl+IpqRno3ukMXV9T
 1EMV6MpDKt91cp6m1h2/pr1+bY/QcC7K14i1he2LzFrTwr1IZgl48cLCGSjHL7M3jRah
 Q1GAwNxUAdHO/8NquMleuV3jNTKGFyzGIteJscqpqlm6d1sraLTi0zT9rL8A64xVc0MK
 kgwQ==
X-Gm-Message-State: AOAM530yI6tFO8eshY7KhcwwJtdn1zygbqHMYuPLWubNGHDBywqlahG4
 0vPqhYu6b6M502cWPTHIycWYuH6mTFY9Gojiw9QMDnY6YpcmNaOV98kqw9mNTO5qyg1x0WAqR97
 OLm56zHVMXj7UdxNW6abqGhrV0wQ=
X-Received: by 2002:a25:b209:0:b0:622:393f:e5f6 with SMTP id
 i9-20020a25b209000000b00622393fe5f6mr794627ybj.145.1645067633940; 
 Wed, 16 Feb 2022 19:13:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwa9swoTPB77SvfTn4OHg0CGVMdV54ZD5IWi3og4oWWYTB0L0/Io6D5iOrbxt1ZobZjtYuc3UFWy7z9Vard8C8=
X-Received: by 2002:a25:b209:0:b0:622:393f:e5f6 with SMTP id
 i9-20020a25b209000000b00622393fe5f6mr794616ybj.145.1645067633649; Wed, 16 Feb
 2022 19:13:53 -0800 (PST)
MIME-Version: 1.0
References: <20220208140322.6842-1-rpalethorpe@suse.com>
 <20220208140322.6842-3-rpalethorpe@suse.com>
 <CAEemH2fjSLAdY4xO7WMekGX=3sPFjt0xVknNxJedk1-agsb3zQ@mail.gmail.com>
 <Yg0XwAb1LOso6dtf@rei>
In-Reply-To: <Yg0XwAb1LOso6dtf@rei>
From: Li Wang <liwang@redhat.com>
Date: Thu, 17 Feb 2022 11:13:40 +0800
Message-ID: <CAEemH2fwb6ggm+aA4DmvbO4Ut0nDK46AyZ7efJSXqsLFPMcwPw@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>, Richard Palethorpe <rpalethorpe@suse.de>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] API/cgroup: Shorten cgroup to cg in most
 symbols
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, LTP List <ltp@lists.linux.it>,
 Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
Content-Type: multipart/mixed; boundary="===============0536082090=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0536082090==
Content-Type: multipart/alternative; boundary="000000000000ef81c805d82e274e"

--000000000000ef81c805d82e274e
Content-Type: text/plain; charset="UTF-8"

On Wed, Feb 16, 2022 at 11:27 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> > To be honest, I only wanted that tst_cg_test pointer :).
> >
> > But I have no objection to renaming 'tst_cgroup_*' to 'tst_cg_*'
> > for the whole APIs. (Though I don't like it)
> >
> > Let's hear more voices from peers.
>
> Actually I like it, having the common prefix shortened to just tst_cg_
> makes it easier to read, at least for me.
>

Well, two to one, thanks for the comments :).

@Richard Palethorpe <rpalethorpe@suse.de>  Hi Richard,
Feel free to push 1/3 and 2/3 patches, in case someone (I guess Luke)
waiting for the code rebase on it.

We can hold patch 3/3(memcontrol04) for a while for fail debugging.
(I am involved in another stuff these days, will look back on that soon)


-- 
Regards,
Li Wang

--000000000000ef81c805d82e274e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Wed, Feb 16, 2022 at 11:27 PM Cyril Hrubis &lt;<=
a href=3D"mailto:chrubis@suse.cz" target=3D"_blank">chrubis@suse.cz</a>&gt;=
 wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi!<br>
&gt; To be honest, I only wanted that tst_cg_test pointer :).<br>
&gt; <br>
&gt; But I have no objection to renaming &#39;tst_cgroup_*&#39; to &#39;tst=
_cg_*&#39;<br>
&gt; for the whole APIs. (Though I don&#39;t like it)<br>
&gt; <br>
&gt; Let&#39;s hear more voices from peers.<br>
<br>
Actually I like it, having the common prefix shortened to just tst_cg_<br>
makes it easier to read, at least for me.<br></blockquote><div><br></div><d=
iv><div class=3D"gmail_default" style=3D"font-size:small">Well, two to one,=
 thanks for the comments :).</div><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div><div class=3D"gmail_default" style=3D"font-size:sma=
ll"><a class=3D"gmail_plusreply" id=3D"m_-188876710831400570plusReplyChip-0=
" href=3D"mailto:rpalethorpe@suse.de" target=3D"_blank">@Richard Palethorpe=
</a>=C2=A0 Hi Richard,</div><div class=3D"gmail_default" style=3D"font-size=
:small">Feel free to push 1/3 and 2/3 patches, in case someone (I guess Luk=
e)<br></div><div class=3D"gmail_default" style=3D"font-size:small">waiting =
for the code rebase on it.=C2=A0</div><div class=3D"gmail_default" style=3D=
"font-size:small"><br></div><div class=3D"gmail_default" style=3D"">We can =
hold patch 3/3(memcontrol04) for a while=C2=A0for=C2=A0fail debugging.</div=
><div class=3D"gmail_default" style=3D"">(I am involved in another stuff th=
ese days, will look back on that soon)<br></div><br></div></div><div><br></=
div>-- <br><div dir=3D"ltr"><div dir=3D"ltr"><div>Regards,<br></div><div>Li=
 Wang<br></div></div></div></div>

--000000000000ef81c805d82e274e--


--===============0536082090==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0536082090==--

