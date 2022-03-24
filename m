Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC89CC433F5
	for <ltp@archiver.kernel.org>; Thu, 24 Mar 2022 02:53:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A5F6B3C9814
	for <ltp@archiver.kernel.org>; Thu, 24 Mar 2022 03:53:23 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 42DF33C9447
 for <ltp@lists.linux.it>; Thu, 24 Mar 2022 03:53:13 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 2600F1A00CCD
 for <ltp@lists.linux.it>; Thu, 24 Mar 2022 03:53:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648090390;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BJRZjWb9t90+xJDIFKrwo3PAUm003wGUPLqq5WKpYM0=;
 b=dIW6zsFLJh1W3qOOUQ5Fn8I7XQj4H1JyPWQcLYYY2syhdMG0mNJ6khTS6+oQUp+i/P+TjE
 Lg1pRdgX0YTV7JsVP4ZPTLYCNlQHzCwfmqqq9aSlRF4ffY7jU9E+Bwy9fCY26zIRLhil+Y
 Y8lGN6to+18xpKmCPCGYmAjnSSVUVM8=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-248-toXRN96_PJ2KhHNFSJGtzA-1; Wed, 23 Mar 2022 22:53:08 -0400
X-MC-Unique: toXRN96_PJ2KhHNFSJGtzA-1
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-2e689dfe112so27000077b3.20
 for <ltp@lists.linux.it>; Wed, 23 Mar 2022 19:53:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BJRZjWb9t90+xJDIFKrwo3PAUm003wGUPLqq5WKpYM0=;
 b=uQdadp7HwI6l+BSEGf+9pQ0I8rrI9RkOLtYE/gDcWJmxYOrAMlk+WGv1zO8+3cp+6G
 IYLGWcZ59k+wXnGbItB6r/urdM+F1+ylKB/8eQVqABA6GBTKUUDzlCXG2dYujyunufBc
 uOejYnuQNu42HoXTeCVFinSEQJePVqO5iUR90nCEqnotHkr++nEwveOkhUwtkndqmB/7
 VLjILoNAN0JAZ9Fyl3+T81W7xK9r620pPEGJmQxFzsGQpJpKBrX/VyNXuX0FWVEUu0aE
 JOq2r5QJX5BpgpBznryMQAcuFZ4WSbzKOzEa8dGQEsnLqUnB9epgBe6eXavNllUpL82X
 qBxA==
X-Gm-Message-State: AOAM533yJKisKbPZEnhetIkEJQEj70qgRyd+5BhOJnqpK73/AyPYvvBm
 iNVBQc/qV9aJa+hujBjImH255IQvkxWXzlzXNFfIJ1a6lTlggVAG2CJDjPIQcrp5AJ1o5CVO5jr
 gmdDYH/TBrZaBj6TiB+9xG3pcVfQ=
X-Received: by 2002:a25:1344:0:b0:633:7592:9c0f with SMTP id
 65-20020a251344000000b0063375929c0fmr2862363ybt.211.1648090388270; 
 Wed, 23 Mar 2022 19:53:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyhrf7bvDW1Ol8JgPb7WNEeXAJxFBgxURPlq9+GwrLClbjbTB2T6VEknzFCaHnYxtsQ6ZENKJTx1VnMEl+h0Pk=
X-Received: by 2002:a25:1344:0:b0:633:7592:9c0f with SMTP id
 65-20020a251344000000b0063375929c0fmr2862353ybt.211.1648090387954; Wed, 23
 Mar 2022 19:53:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220311054603.57328-1-liwang@redhat.com>
 <20220311054603.57328-2-liwang@redhat.com> <Yjr0QrgWKDIg63Ye@pevik>
In-Reply-To: <Yjr0QrgWKDIg63Ye@pevik>
From: Li Wang <liwang@redhat.com>
Date: Thu, 24 Mar 2022 10:52:50 +0800
Message-ID: <CAEemH2d-F1FdGfRkUB5+zT16xovLhr7WLxqPk+exa2fpHbBWXg@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/3] include: replace min/max macro by the new
 definition
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
Content-Type: multipart/mixed; boundary="===============0552945253=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0552945253==
Content-Type: multipart/alternative; boundary="00000000000021d4f305daedf2e0"

--00000000000021d4f305daedf2e0
Content-Type: text/plain; charset="UTF-8"

On Wed, Mar 23, 2022 at 6:19 PM Petr Vorel <pvorel@suse.cz> wrote:

> Hi Li,
>
> obviously correct, thanks!
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>

Patchset applied, thanks!


-- 
Regards,
Li Wang

--00000000000021d4f305daedf2e0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Wed, Mar 23, 2022 at 6:19 PM Petr Vorel &lt;<a h=
ref=3D"mailto:pvorel@suse.cz">pvorel@suse.cz</a>&gt; wrote:<br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">Hi Li,<br>
<br>
obviously correct, thanks!<br>
Reviewed-by: Petr Vorel &lt;<a href=3D"mailto:pvorel@suse.cz" target=3D"_bl=
ank">pvorel@suse.cz</a>&gt;<br>
</blockquote><div><br></div><div class=3D"gmail_default" style=3D"font-size=
:small">Patchset applied, thanks!</div></div><br clear=3D"all"><div><br></d=
iv>-- <br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div>=
Regards,<br></div><div>Li Wang<br></div></div></div></div>

--00000000000021d4f305daedf2e0--


--===============0552945253==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0552945253==--

