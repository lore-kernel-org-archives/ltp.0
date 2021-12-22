Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 160EEC433EF
	for <ltp@archiver.kernel.org>; Wed, 22 Dec 2021 11:29:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1E4433C9284
	for <ltp@archiver.kernel.org>; Wed, 22 Dec 2021 12:29:52 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8ADC93C092C
 for <ltp@lists.linux.it>; Wed, 22 Dec 2021 12:29:42 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id BFA45600906
 for <ltp@lists.linux.it>; Wed, 22 Dec 2021 12:29:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1640172580;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TyLjKLdurOAt7cI1JmKcVz12OObFj7sIkFgfYFdinT0=;
 b=b7Vjk50D91u0npWx0aQ5cmrZ5Jk8qHXI57C/3xPDIUY6IYdW//IXRVBOiUe0azfqozwVX2
 krzfEVfLHWQASK8BmxCDucAx+yIGP0gM5IG3vGpjPlMFnMMzNwVRHBFf65vlYW0uY0+w/9
 Ev4BBCqs2IJX1YMlujMcDn7gdIvgO9Y=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-2-C5DW32J9OySnYzEZDGfmdA-1; Wed, 22 Dec 2021 06:29:38 -0500
X-MC-Unique: C5DW32J9OySnYzEZDGfmdA-1
Received: by mail-yb1-f197.google.com with SMTP id
 d205-20020a251dd6000000b0060977416ad4so3388206ybd.16
 for <ltp@lists.linux.it>; Wed, 22 Dec 2021 03:29:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TyLjKLdurOAt7cI1JmKcVz12OObFj7sIkFgfYFdinT0=;
 b=sXrv+ZdNsv7ckbpFmBCkJVe4EfKqBgcs6SFmB12ulAYu6fhEc/Od8nswbqmf4YOz9B
 XMka0ULtmIvNyNxAUTRz7jCDM8y1vm8a3s83XPTrpjytVihwcbDlj5CFd8gxHdZJPXQd
 ASt0YsuRjh0B15ysWukueGqE4Zyrqqv0jP84teiHPn66MI+2P+ZLKkwY3Wn3Ps5UDp1T
 yAXgDVa9KutDUtWZyBfr11buuRCiL1LYrKnIUYCphNKdqCiqg3dRf6BhbEYQazyS2ccp
 O4ucvRUu2Z9Vuvddsa9JRsQK6CVnmgdB25af95GSSu56sDpfX1Tu0pxvc2ekWrILP2Yg
 8E0A==
X-Gm-Message-State: AOAM531K0Q+C9CvzOoglmVR2MCHPnmjI+xzRXC5Ee849x5wPMQAhzMaS
 xXOnCRIs6XKRVbBqDLa/OMRtqGRvG0A/hGY/tryKN0LjoZ/Uz5A/98Md9TpHjPDxztw4XSgQZ+E
 XwXkmJNu2hAKQ+7CK2Lk+U6vc8z8=
X-Received: by 2002:a25:b13:: with SMTP id 19mr3876473ybl.71.1640172577559;
 Wed, 22 Dec 2021 03:29:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxC/uzQ8JdUFmLdqew0tOKwx1soyTiKaBrOoyDF+tcVJnDeknuPJxWrWwUZ7KOunjctdHjrRf1mIoAjWEkfW6c=
X-Received: by 2002:a25:b13:: with SMTP id 19mr3876433ybl.71.1640172577247;
 Wed, 22 Dec 2021 03:29:37 -0800 (PST)
MIME-Version: 1.0
References: <20211221193500.31950-1-pvorel@suse.cz>
 <61C28CB8.3050209@fujitsu.com>
 <CAEemH2cqTErtNZka8X3L3AgOhy-a2x8fqy1k-QKJWiXc7wA2fA@mail.gmail.com>
 <61C2C02A.90104@fujitsu.com> <YcLeaPJmSvmUJwJO@pevik>
 <61C2E3DB.9070004@fujitsu.com>
 <CAEemH2dpLJ9N57TpMhW3wMkd-V0cZMPWyH_sXn6KjXoWJWUC4g@mail.gmail.com>
 <YcL5XG6azJuGTys7@yuki> <YcL82UGphHruor3+@pevik> <YcMArVLw7UbLT/wi@yuki>
 <YcMCao3J5PIPaTWe@pevik>
In-Reply-To: <YcMCao3J5PIPaTWe@pevik>
From: Li Wang <liwang@redhat.com>
Date: Wed, 22 Dec 2021 19:29:24 +0800
Message-ID: <CAEemH2dMxEfDwxJ_LO+DK=J+Tkfuxg1F0+5UEoM4oK47A_ZxyA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>,
 Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: multipart/mixed; boundary="===============1302859932=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1302859932==
Content-Type: multipart/alternative; boundary="000000000000d6899005d3ba6f61"

--000000000000d6899005d3ba6f61
Content-Type: text/plain; charset="UTF-8"

On Wed, Dec 22, 2021 at 6:48 PM Petr Vorel <pvorel@suse.cz> wrote:

> > I've sent v2, which checks CAP_SYS_ADMIN and CAP_SYS_RESOURCE,
> > > but feel free just to bring simpler solution.
>
> > I still think that the most acurate test would be just writing to the
> > file and checking the result.
> OK. Anybody taking this (so that not more people working on it)?


I'm considering using both of the two methods.

-- 
Regards,
Li Wang

--000000000000d6899005d3ba6f61
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Wed, Dec 22, 2021 at 6:48 PM Petr Vorel &lt;<a h=
ref=3D"mailto:pvorel@suse.cz">pvorel@suse.cz</a>&gt; wrote:</div><div dir=
=3D"ltr" class=3D"gmail_attr"><br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">
&gt; &gt; I&#39;ve sent v2, which checks CAP_SYS_ADMIN and CAP_SYS_RESOURCE=
,<br>
&gt; &gt; but feel free just to bring simpler solution.<br>
<br>
&gt; I still think that the most acurate test would be just writing to the<=
br>
&gt; file and checking the result.<br>
OK. Anybody taking this (so that not more people working on it)?</blockquot=
e><div><br></div><div><div class=3D"gmail_default" style=3D"font-size:small=
">I&#39;m considering using both of the two methods.</div></div></div><div>=
<br></div>-- <br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr=
"><div>Regards,<br></div><div>Li Wang<br></div></div></div></div>

--000000000000d6899005d3ba6f61--


--===============1302859932==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1302859932==--

