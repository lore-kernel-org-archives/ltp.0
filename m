Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23844C433EF
	for <ltp@archiver.kernel.org>; Wed, 22 Dec 2021 09:49:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 311F83C9256
	for <ltp@archiver.kernel.org>; Wed, 22 Dec 2021 10:49:09 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2F7D93C042E
 for <ltp@lists.linux.it>; Wed, 22 Dec 2021 10:48:59 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 2A7B314013B4
 for <ltp@lists.linux.it>; Wed, 22 Dec 2021 10:48:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1640166536;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=e0Jb5Wx14nujM2wwBKCB1bMM5LgMfa4FH5IxJ9Pa/y8=;
 b=YxtVxS9Za27ZXpjVmoGjWIu+29CZmwNqkzS521fgaAQZE+/vi8Ix9awbcMOoD7LZJLyTrt
 3dc/C4u4+QZKzTtGgt1REjsDv5oU6LZ3x/J7QdLnsanku/faKOyGYaPxYV5lVGKFUOIFsI
 n7dZTHFUNKoLHCBJlwMoIgf1cD3tZ/0=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-507--Wen5tHKNGuk2uolXfSLkw-1; Wed, 22 Dec 2021 04:48:53 -0500
X-MC-Unique: -Wen5tHKNGuk2uolXfSLkw-1
Received: by mail-yb1-f197.google.com with SMTP id
 d205-20020a251dd6000000b0060977416ad4so3011338ybd.16
 for <ltp@lists.linux.it>; Wed, 22 Dec 2021 01:48:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=e0Jb5Wx14nujM2wwBKCB1bMM5LgMfa4FH5IxJ9Pa/y8=;
 b=wYSA/uabLzinrPYELZDn0Eep966A3ftMFWcmrppGSIg1F0kJLFAsKO/C3Pn44t4YO8
 J+3zRD6qanytyNy5+MUSnqBxQNvGj5sNfboJLmgIpBk/rvnGF1X/BFNlR6q34POOXMcN
 hMl6BlRcC1Qbu9xPnMDNUZ7ivHL9/wU75r7+Vuicc6XFGXVYOEnH4mgvB7UimXSNG8lx
 FVF4l5uTXas6igQ8c4H1g7AYieRvj89yUL1nTxdGPnAOx03dvh29wGkdW9Uzzr5PylFY
 MP00gKqTplXUfoDMctE5xne2jrsF5iSvqeg6uMo0zvcOsL3oWGfl6qMCc0EHqpWAuU3m
 zLPA==
X-Gm-Message-State: AOAM530uB3Y9W6RD7Pa51KSFN1m1kN9Zcv39IbPDO1Plb8CIbD//szU8
 4NyiXYGRI3aSiXdIp67B7+OSO+f/ZgvsjcTSf0YWjA3CNTRWWbTbUzGniSMipSvKprnxOFVViAl
 VssY7/FVU+9N/+LdhAnafe8+GnEU=
X-Received: by 2002:a25:b13:: with SMTP id 19mr3389633ybl.71.1640166532455;
 Wed, 22 Dec 2021 01:48:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzHa4x09J/B3N2DTl83NINrqBRbU/AdV9jShSJsvbRWNB/Ie+b2/5KFBDQ4mrQ4+haoXvdZjRptmku0PbvuCbg=
X-Received: by 2002:a25:b13:: with SMTP id 19mr3389611ybl.71.1640166532187;
 Wed, 22 Dec 2021 01:48:52 -0800 (PST)
MIME-Version: 1.0
References: <20211221193500.31950-1-pvorel@suse.cz>
 <61C28CB8.3050209@fujitsu.com>
 <CAEemH2cqTErtNZka8X3L3AgOhy-a2x8fqy1k-QKJWiXc7wA2fA@mail.gmail.com>
 <61C2C02A.90104@fujitsu.com> <YcLeaPJmSvmUJwJO@pevik>
 <61C2E3DB.9070004@fujitsu.com>
In-Reply-To: <61C2E3DB.9070004@fujitsu.com>
From: Li Wang <liwang@redhat.com>
Date: Wed, 22 Dec 2021 17:48:36 +0800
Message-ID: <CAEemH2dpLJ9N57TpMhW3wMkd-V0cZMPWyH_sXn6KjXoWJWUC4g@mail.gmail.com>
To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] lib: Skip tst_{disable,
 enable}_oom_protection() for non-root
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: multipart/mixed; boundary="===============2027017264=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============2027017264==
Content-Type: multipart/alternative; boundary="00000000000086280d05d3b907d7"

--00000000000086280d05d3b907d7
Content-Type: text/plain; charset="UTF-8"

Hi Xu, Petr,

On Wed, Dec 22, 2021 at 4:37 PM xuyang2018.jy@fujitsu.com <
xuyang2018.jy@fujitsu.com> wrote:

> Hi Petr
> > Hi Xu,
> >
> >>> This is not working as expected in Github CI. I'm still looking at the
> >>> problem.
> >>>
> https://github.com/wangli5665/ltp/runs/4602025797?check_suite_focus=true
> >> I tested local but it works well. I guess ci fails because of linux user
> >> namespace. Maybe we should require CAP_SYS_RESOURCE cap instead of using
> >> geteuid.
> > Good catch, verifying.
> You can refer to my ltp fork
> https://github.com/xuyang0410/ltp/commits/oom_kill_ci_fixes


+1

I was thinking of adding the permission but that's
might not be a good way for the namespace. Like your
method which only does check and return is better.

-- 
Regards,
Li Wang

--00000000000086280d05d3b907d7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Hi Xu, Petr,</div></div><br><div class=3D"gmail_quote"><div d=
ir=3D"ltr" class=3D"gmail_attr">On Wed, Dec 22, 2021 at 4:37 PM <a href=3D"=
mailto:xuyang2018.jy@fujitsu.com">xuyang2018.jy@fujitsu.com</a> &lt;<a href=
=3D"mailto:xuyang2018.jy@fujitsu.com">xuyang2018.jy@fujitsu.com</a>&gt; wro=
te:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi Petr<br>
&gt; Hi Xu,<br>
&gt;<br>
&gt;&gt;&gt; This is not working as expected in Github CI. I&#39;m still lo=
oking at the<br>
&gt;&gt;&gt; problem.<br>
&gt;&gt;&gt; <a href=3D"https://github.com/wangli5665/ltp/runs/4602025797?c=
heck_suite_focus=3Dtrue" rel=3D"noreferrer" target=3D"_blank">https://githu=
b.com/wangli5665/ltp/runs/4602025797?check_suite_focus=3Dtrue</a><br>
&gt;&gt; I tested local but it works well. I guess ci fails because of linu=
x user<br>
&gt;&gt; namespace. Maybe we should require CAP_SYS_RESOURCE cap instead of=
 using<br>
&gt;&gt; geteuid.<br>
&gt; Good catch, verifying.<br>
You can refer to my ltp fork<br>
<a href=3D"https://github.com/xuyang0410/ltp/commits/oom_kill_ci_fixes" rel=
=3D"noreferrer" target=3D"_blank">https://github.com/xuyang0410/ltp/commits=
/oom_kill_ci_fixes</a></blockquote><div><br></div><div class=3D"gmail_defau=
lt" style=3D"font-size:small">+1=C2=A0</div><div class=3D"gmail_default" st=
yle=3D"font-size:small"><br></div><div class=3D"gmail_default" style=3D"fon=
t-size:small">I was thinking of adding the permission but that&#39;s</div><=
div class=3D"gmail_default" style=3D"font-size:small">might not be a good w=
ay for the namespace. Like your</div><div class=3D"gmail_default" style=3D"=
font-size:small">method which only does check and return=C2=A0is better.</d=
iv></div><div><br></div>-- <br><div dir=3D"ltr" class=3D"gmail_signature"><=
div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></div></div></=
div>

--00000000000086280d05d3b907d7--


--===============2027017264==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============2027017264==--

