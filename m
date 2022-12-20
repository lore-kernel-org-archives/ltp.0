Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CF46C4332F
	for <ltp@archiver.kernel.org>; Tue, 20 Dec 2022 05:00:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 217833CBB33
	for <ltp@archiver.kernel.org>; Tue, 20 Dec 2022 06:00:54 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CEC223CBAC0
 for <ltp@lists.linux.it>; Tue, 20 Dec 2022 06:00:44 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B00D41400513
 for <ltp@lists.linux.it>; Tue, 20 Dec 2022 06:00:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671512442;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vsPAo+pI0v5ViuM0RGuGLpewsdt8ur1GTmAcb81ZJoY=;
 b=D7RGZ+iHPLW/Upio9W6jv2tuCO2eLJSqSKPqTVDcjZvHrUpc1Y0QPOtTgM+1+rgQNhIHjI
 eABbgYuNLI8ySsuP2rtjBnMujkjnoSd8IE/oKmYg6aohtTXy0fHBt0XAanMdrFBVemtRFz
 rY4RmyZFrG/EFkDzIXUxTAqtxSmzJ8A=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-426-5Mnh9m6hPVKbyUMqmQ5SLQ-1; Tue, 20 Dec 2022 00:00:38 -0500
X-MC-Unique: 5Mnh9m6hPVKbyUMqmQ5SLQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 m17-20020a05600c3b1100b003cf9cc47da5so6040289wms.9
 for <ltp@lists.linux.it>; Mon, 19 Dec 2022 21:00:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vsPAo+pI0v5ViuM0RGuGLpewsdt8ur1GTmAcb81ZJoY=;
 b=zkkRrXbvaXLa9C5IOIorskin4jooRI5S31YLOVt9M/ckboWKsvKmcJ0Cu2+wfQnnvT
 PrOME8zS5kihmbKuLrEBKP9UMQ1YwXkKdhjmHrjy1YMvv4QJCgxNUNAPHx3RKylL7fSg
 VY/eWQ3n2+SQ92Q5h5DUcm8YTQNsFz0wcNuxAkCsv5qkiDi5z6HHMR6SsNbJHhRiqmyT
 NY+9nEGtdJ1ttbMY8rnu0hdEIhGqOAzNChdOc+Ym2LV5GV7sDxd7bbRoBqp6Yyg49Rp+
 qo3nFGi6Yp5lqBkq2+1Bgg+txqDm8ONnTtSGPDsdhWcHEqonDMBUrTzvd3dX28nYcAVs
 jZGw==
X-Gm-Message-State: ANoB5pnAe3NWCmlPAt+X1JCQAuBbr5dU37rPzSozjBotZOj4VZ5iQBEX
 BAmNM6qeVmvS4PYbwW3G9+42VoMVExY/eNzWcqA1fXSnwXsFUt7g6eW4qBlbTkUrSdh7TvBiDgU
 4vywafhZUSrh28HEGNJ1VijeDF/c=
X-Received: by 2002:adf:fcc9:0:b0:242:3a48:1757 with SMTP id
 f9-20020adffcc9000000b002423a481757mr19487569wrs.528.1671512437122; 
 Mon, 19 Dec 2022 21:00:37 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7CByON687gQCjLlHB5oFhp/yRJSCEUDfKAPgOZVU3o4pt0HPnxD5nz5WniP+s6wgjdUCIVAS2PqVPtEKnX6EI=
X-Received: by 2002:adf:fcc9:0:b0:242:3a48:1757 with SMTP id
 f9-20020adffcc9000000b002423a481757mr19487559wrs.528.1671512436857; Mon, 19
 Dec 2022 21:00:36 -0800 (PST)
MIME-Version: 1.0
References: <20221216094611.2924-1-pvorel@suse.cz>
 <20221216094611.2924-3-pvorel@suse.cz>
In-Reply-To: <20221216094611.2924-3-pvorel@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Tue, 20 Dec 2022 13:00:25 +0800
Message-ID: <CAEemH2fPZ3AJuDKUm9RkXijjL6c1-ObHMFaLFVENCoKVc0Qr5A@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [RFC PATCH 2/2] doc: Document used C standard
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
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 =?UTF-8?Q?Jan_L=C3=BCbbe?= <jlu@pengutronix.de>, Khem Raj <raj.khem@gmail.com>,
 Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it,
 automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Fri, Dec 16, 2022 at 5:46 PM Petr Vorel <pvorel@suse.cz> wrote:

> which was added in dc7be30e25 ("config: Explicitly set gnu99")
>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
>

Reviewed-by: Li Wang <liwang@redhat.com>


> ---
> BTW I guess after CentOS 7 EOL we should raise std.
>
>  doc/supported-kernel-libc-versions.txt | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/doc/supported-kernel-libc-versions.txt
> b/doc/supported-kernel-libc-versions.txt
> index f89c4882fb..b5f12962b2 100644
> --- a/doc/supported-kernel-libc-versions.txt
> +++ b/doc/supported-kernel-libc-versions.txt
> @@ -70,3 +70,8 @@ Minimal supported (although untested) kernel version is
> 3.0.
>                                   for list of files which need to be
> deleted in order to compile under musl).
>  | binder (Android) | Please use
> https://android.googlesource.com/platform/external/ltp/[AOSP fork].
>  |==================================
> +
> +1.5 Used C standard
> +~~~~~~~~~~~~~~~~~~~
> +
> +LTP now compiles with '-std=gnu99'.
> --
> 2.39.0
>
>

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
