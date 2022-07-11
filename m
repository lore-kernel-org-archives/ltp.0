Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D78B3C433EF
	for <ltp@archiver.kernel.org>; Mon, 11 Jul 2022 10:22:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C45073CA7A0
	for <ltp@archiver.kernel.org>; Mon, 11 Jul 2022 12:22:03 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B06E03CA677
 for <ltp@lists.linux.it>; Mon, 11 Jul 2022 12:21:51 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 4D29C1A00811
 for <ltp@lists.linux.it>; Mon, 11 Jul 2022 12:21:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1657534908;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GkeOlMUWmgAwjzITU/vTg+TCbg/TC37gQcoCbEEvWLo=;
 b=U6Wdk/CFK6XG9LBVopd4YCFIOl9qyOKBZym1eKYAgS0StGFYcitE8JFsGo7mCAh3rUdAqG
 iiUoH+QTkt2aEkNPO67alzKiaUJILRuGuMZdDbLBZHkcbK5VYlw6IRWancVOgYSFORrGg7
 s83w0HvU/i8cynSgc9GjhDpO76D1QrE=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-633-YbR9FzT5OXuNcYMCm9d3Gg-1; Mon, 11 Jul 2022 06:21:47 -0400
X-MC-Unique: YbR9FzT5OXuNcYMCm9d3Gg-1
Received: by mail-yb1-f200.google.com with SMTP id
 i9-20020a258b09000000b0066efe437da6so2906840ybl.5
 for <ltp@lists.linux.it>; Mon, 11 Jul 2022 03:21:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GkeOlMUWmgAwjzITU/vTg+TCbg/TC37gQcoCbEEvWLo=;
 b=Xfb8dOs+7b0MZAHaKg9M8+EiCqttWJJpaYYNLTwfrnIPxKUvdc/PmLQnefl511sLn6
 fXLIvnCp6dRTerq7ztf1XVu2kjBbaQdyehs7RNRdGhGVHa1n40OdI2Xkj0HLFzgNZIAw
 xOLwtxNs2kuj10OrjWTMIAj3cPKBbKJT+twDJsdeGRcNftQ28Q3nUu3z2VNogmzNBUiA
 d0oY248qkAhtxd2q2IeuojmugN0aEJL/jnwoqZ1V8YNYwP/ciQh0i+oSq04uviX1fRKj
 tb96K9PwFyljKKsKMOnvQfoe5/n6scmxj2PUNe2Vxy1ax54kFNRYKy2whoGRC81/oHc1
 P4tw==
X-Gm-Message-State: AJIora+326lyctw3it5tHxHW9sO4tyZGU0XC7O0ggmqw7MU/mL7rAr8q
 mArARZH9ldUM7dYn8e//ElXXy7xXcKqqw+M10pKdx3C/GtpkaWHFRqqaasZ6Ja7J0LhBJ73QtJr
 WpOc6uOUYFZWzX0m/Q1/4vgl/hB0=
X-Received: by 2002:a0d:f685:0:b0:31d:7685:8a90 with SMTP id
 g127-20020a0df685000000b0031d76858a90mr5013785ywf.12.1657534906397; 
 Mon, 11 Jul 2022 03:21:46 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sb9s9Oec2rMAmx7WjxBwbIL44TAtsr8fui2L++t1HTJ6UW3Z4UPPDA6MG2OMrV0zAFzZLaB2+nkIlDjynck7U=
X-Received: by 2002:a0d:f685:0:b0:31d:7685:8a90 with SMTP id
 g127-20020a0df685000000b0031d76858a90mr5013755ywf.12.1657534905838; Mon, 11
 Jul 2022 03:21:45 -0700 (PDT)
MIME-Version: 1.0
References: <1657190760-2272-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <87o7xwneq7.fsf@suse.de>
In-Reply-To: <87o7xwneq7.fsf@suse.de>
From: Li Wang <liwang@redhat.com>
Date: Mon, 11 Jul 2022 18:21:34 +0800
Message-ID: <CAEemH2fCd=iVmBcV-X_DnnHQiXNK1HrpvYgTvd+OU+jC=55HPw@mail.gmail.com>
To: Richard Palethorpe <rpalethorpe@suse.de>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] security/dirtyc0w: fix typo
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
Content-Type: multipart/mixed; boundary="===============0747183166=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0747183166==
Content-Type: multipart/alternative; boundary="00000000000044099c05e384ebd0"

--00000000000044099c05e384ebd0
Content-Type: text/plain; charset="UTF-8"

Richard Palethorpe <rpalethorpe@suse.de> wrote:

Hello,
>
> Yang Xu <xuyang2018.jy@fujitsu.com> writes:
>
> > s/dirtyc0w/dirtycow/
>
> I assume it's l33t speak, not a typo. Did the spelling cause a problem?
>

+1, yes leetspeak is widely used in online gaming and hacker area.

-- 
Regards,
Li Wang

--00000000000044099c05e384ebd0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div><div class=3D"gmail_default" style=3D"font-size:sma=
ll">Richard Palethorpe &lt;<a href=3D"mailto:rpalethorpe@suse.de">rpalethor=
pe@suse.de</a>&gt; wrote:<br></div><div class=3D"gmail_default" style=3D"fo=
nt-size:small"><br></div></div><div class=3D"gmail_quote"><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">Hello,<br>
<br>
Yang Xu &lt;<a href=3D"mailto:xuyang2018.jy@fujitsu.com" target=3D"_blank">=
xuyang2018.jy@fujitsu.com</a>&gt; writes:<br>
<br>
&gt; s/dirtyc0w/dirtycow/<br>
<br>
I assume it&#39;s l33t speak, not a typo. Did the spelling cause a problem?=
<br></blockquote><div><br></div>+1, yes leetspeak is widely used in online =
gaming and hacker area.</div><div><br></div>-- <br><div dir=3D"ltr" class=
=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<b=
r></div></div></div></div>

--00000000000044099c05e384ebd0--


--===============0747183166==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0747183166==--

