Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A11D1C433EF
	for <ltp@archiver.kernel.org>; Fri, 18 Mar 2022 07:44:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 73A683C94B3
	for <ltp@archiver.kernel.org>; Fri, 18 Mar 2022 08:44:28 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8DFCB3C93AB
 for <ltp@lists.linux.it>; Fri, 18 Mar 2022 08:44:17 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 8D64D1A01165
 for <ltp@lists.linux.it>; Fri, 18 Mar 2022 08:44:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1647589455;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UVdCyPHFFXRuIPGEIczjfcZrSoi/WJzGPE8Iol5GXNA=;
 b=TgIaBVRdoOPnKIHj0natxzKBtv9hNi0Hi9mp/73WwmacvDq2mh2L3AsIxHLv2XP2xfZ0em
 SgvSmyaXDf6R+bi1Lqo8rA2exd/DtwgpZ3msIVqDjEVlSJ0uPr0aOewv8yAzrnkY9fCMzl
 W16bO/1LxlZYfEMqsfDYLwqNNOCd9dU=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-651-uXYLZDiwON68l2bWXOvRMw-1; Fri, 18 Mar 2022 03:44:08 -0400
X-MC-Unique: uXYLZDiwON68l2bWXOvRMw-1
Received: by mail-yb1-f200.google.com with SMTP id
 x11-20020a5b0f0b000000b0062277953037so6260890ybr.21
 for <ltp@lists.linux.it>; Fri, 18 Mar 2022 00:44:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=UVdCyPHFFXRuIPGEIczjfcZrSoi/WJzGPE8Iol5GXNA=;
 b=AK4WH9QQbgBVZ8TIlEgwrOExlYhczzbs20kUWMOv0q4/+I2WZTJxRgDq9rGaGBMAvq
 E2FZs9aWql3wO/4goxnthUNPxwOoUJX23eBPoWPZfOkDl/ZS1y5D4Q36yELsjXl0HC8G
 4mWDXyqwRFQSZM+8DM9K2KEw72BRM8lvwoLHP6itgE6Z0iBLsL4W5JYMbLyyrG7Iwhu8
 P4IEQaDy8oXKKZzgbePR/fa7BICnXTEOjBpWerA8Okp9roQUNAzeWolwuUjl2foZh66Z
 y++eAzHH/9H4sIQq9SDaP2P3gAyTlai6E+LQ/Y/9axnXarx6BZ3XXqkBKX+WjORq40ul
 3V/g==
X-Gm-Message-State: AOAM533Z17k7Q26jdG9oOHiFyTBsQrQ5q+9O/ozlafjdCFXIipBfFW20
 Leiaj1Im05MTA6gFagVAWrn9F0VAlGpTynISHg/za0YloW/T4fz6Lr//UK0TObMjFA63GtPBV+s
 8fNddTEJ4dY3Rb4KX9Ab9IVzlRM4=
X-Received: by 2002:a81:bf54:0:b0:2e5:c117:83cf with SMTP id
 s20-20020a81bf54000000b002e5c11783cfmr6650017ywk.25.1647589447698; 
 Fri, 18 Mar 2022 00:44:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw+EZonFnVTWQGVCuL8SPoGdM5FrXMcjUWRtXrCsUMF70blmTn2MuHc+T5CbLZsRYhlWQwcLjZUNz9IFDrpvmE=
X-Received: by 2002:a81:bf54:0:b0:2e5:c117:83cf with SMTP id
 s20-20020a81bf54000000b002e5c11783cfmr6650004ywk.25.1647589447487; Fri, 18
 Mar 2022 00:44:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220316150429.2873-1-pvorel@suse.cz> <YjH9dDef3w7Iu3vG@pevik>
 <CAEemH2cB+k+dbS_N=S0jGs9H3ct1wBUYhuaR-+V7wRVtydVN_g@mail.gmail.com>
 <YjQ1WKtV0amHh4Aq@pevik>
In-Reply-To: <YjQ1WKtV0amHh4Aq@pevik>
From: Li Wang <liwang@redhat.com>
Date: Fri, 18 Mar 2022 15:43:52 +0800
Message-ID: <CAEemH2e8af4Y=1vGTL36OjKy2TbuYRBwYFkf7fHT7pfjg6-87w@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC][PATCH 1/1] ci: Ubuntu xenial -> bionic
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
Content-Type: multipart/mixed; boundary="===============0883497713=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0883497713==
Content-Type: multipart/alternative; boundary="000000000000c0e7e905da794f5f"

--000000000000c0e7e905da794f5f
Content-Type: text/plain; charset="UTF-8"

On Fri, Mar 18, 2022 at 3:31 PM Petr Vorel <pvorel@suse.cz> wrote:

> Hi Li, Cyril,
>
> > Hi Petr,
>
> > On Wed, Mar 16, 2022 at 11:08 PM Petr Vorel <pvorel@suse.cz> wrote:
>
> > > Tested
>
> > > * bionic
> > > https://github.com/pevik/ltp/actions/runs/1993375270
>
> > > * focal
> > > https://github.com/pevik/ltp/actions/runs/1993443143
>
> > > And as I noted xenial still works. I wanted to avoid false positives
> when
> > > repos
> > > get down, but obviously we have 4 years time (ends in 01 Apr 2026).
>
>
> > +1 for bionic. (we can do an upgrade to focal when bionic reach EOL)
>
> > According to the release cycle page[1] of ubuntu ORG, the
> > Xenial (16.04) version is being deprecated, which means
> > no hardware and maintenance updates anymore. But we (LTP)
> > still merging new features and regression testcases, I'm afraid
> > that will bring some known failures in Xenial then to cost energy
> > for debugging.
>
> So you'd keep Xenial until the end of it's Extended Security Maintenance
> (ESM)
> support in 2026? I'm not sure myself if it's a good idea to drop Xenial
> now and
>

No no, I mean drop the Xenial as your patch did.

The ESM seems only to include security updates but does not include
hardware and general maintenance.



> solve these problems. Maybe we should hold this change for some time.
> And if we upgrade to bionic, it would be good to finish a docs of supported
> kernel/(g)libc/distro versions.
>
> Kind regards,
> Petr
>
> > [1]https://ubuntu.com/about/release-cycle
>
>

-- 
Regards,
Li Wang

--000000000000c0e7e905da794f5f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Fri, Mar 18, 2022 at 3:31 PM Petr Vorel &lt;<a h=
ref=3D"mailto:pvorel@suse.cz">pvorel@suse.cz</a>&gt; wrote:<br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">Hi Li, Cyril,<br>
<br>
&gt; Hi Petr,<br>
<br>
&gt; On Wed, Mar 16, 2022 at 11:08 PM Petr Vorel &lt;<a href=3D"mailto:pvor=
el@suse.cz" target=3D"_blank">pvorel@suse.cz</a>&gt; wrote:<br>
<br>
&gt; &gt; Tested<br>
<br>
&gt; &gt; * bionic<br>
&gt; &gt; <a href=3D"https://github.com/pevik/ltp/actions/runs/1993375270" =
rel=3D"noreferrer" target=3D"_blank">https://github.com/pevik/ltp/actions/r=
uns/1993375270</a><br>
<br>
&gt; &gt; * focal<br>
&gt; &gt; <a href=3D"https://github.com/pevik/ltp/actions/runs/1993443143" =
rel=3D"noreferrer" target=3D"_blank">https://github.com/pevik/ltp/actions/r=
uns/1993443143</a><br>
<br>
&gt; &gt; And as I noted xenial still works. I wanted to avoid false positi=
ves when<br>
&gt; &gt; repos<br>
&gt; &gt; get down, but obviously we have 4 years time (ends in 01 Apr 2026=
).<br>
<br>
<br>
&gt; +1 for bionic. (we can do an upgrade to focal when bionic reach EOL)<b=
r>
<br>
&gt; According to the release cycle page[1] of ubuntu ORG, the<br>
&gt; Xenial (16.04) version is being deprecated, which means<br>
&gt; no hardware and maintenance updates anymore. But we (LTP)<br>
&gt; still merging new features and regression testcases, I&#39;m afraid<br=
>
&gt; that will bring some known failures in Xenial then to cost energy<br>
&gt; for debugging.<br>
<br>
So you&#39;d keep Xenial until the end of it&#39;s Extended Security Mainte=
nance (ESM)<br>
support in 2026? I&#39;m not sure myself if it&#39;s a good idea to drop Xe=
nial now and<br></blockquote><div><br></div><div><div class=3D"gmail_defaul=
t" style=3D"font-size:small">No no, I mean drop the Xenial as your patch di=
d.</div><div class=3D"gmail_default" style=3D"font-size:small"><br></div><d=
iv class=3D"gmail_default" style=3D"font-size:small">The ESM seems only=C2=
=A0to include security updates but does=C2=A0not include</div><div class=3D=
"gmail_default" style=3D"font-size:small">hardware and general maintenance.=
</div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">
solve these problems. Maybe we should hold this change for some time.<br>
And if we upgrade to bionic, it would be good to finish a docs of supported=
<br>
kernel/(g)libc/distro versions.<br>
<br>
Kind regards,<br>
Petr<br>
<br>
&gt; [1]<a href=3D"https://ubuntu.com/about/release-cycle" rel=3D"noreferre=
r" target=3D"_blank">https://ubuntu.com/about/release-cycle</a><br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div><div>Li =
Wang<br></div></div></div></div>

--000000000000c0e7e905da794f5f--


--===============0883497713==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0883497713==--

