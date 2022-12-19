Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBF20C4332F
	for <ltp@archiver.kernel.org>; Mon, 19 Dec 2022 09:52:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9970B3CBAC3
	for <ltp@archiver.kernel.org>; Mon, 19 Dec 2022 10:52:55 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7CC273C8765
 for <ltp@lists.linux.it>; Mon, 19 Dec 2022 10:52:46 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 686DE600677
 for <ltp@lists.linux.it>; Mon, 19 Dec 2022 10:52:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671443563;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BvqPZ+aWRxViNFrgwwfRekjP1M/P0QhM+/c3A4zCANE=;
 b=J6zOKdWoj4RrzYXdzk3Z0gnb95CzDt6hwJEyprHzz5KCMmppuTpzbcl6E2fSxDGkSimU7J
 4Zf69tBPm4W31ECjMLjFZrmy8P7c5LBObjRbrQP6tPLFE/Er34MrdTx1JgNSkZn8lz9qsb
 89LQlfKHkCDjftT5n8J6yotnqF3WAy4=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-57-ZqD7YR2aPN-EiE3CpTAByQ-1; Mon, 19 Dec 2022 04:52:42 -0500
X-MC-Unique: ZqD7YR2aPN-EiE3CpTAByQ-1
Received: by mail-vs1-f72.google.com with SMTP id
 t125-20020a675f83000000b003b152cdaea7so2213818vsb.15
 for <ltp@lists.linux.it>; Mon, 19 Dec 2022 01:52:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BvqPZ+aWRxViNFrgwwfRekjP1M/P0QhM+/c3A4zCANE=;
 b=HfeHbnLM9rSbp2urwgag+5DLFVA1eb0Owpai/5h7O1HQibS6gH8/7YfPKv0MDisjhV
 EYibJ0znf7Cl4HyAM1releWsvbnGuA5+KYPL//5y9V6ioepL3BR07GZ2GJ7zsMtMXUft
 FQrCQMENRVVjhYfYWwQzi5MmpGLTbz7JA3GmB9S3X+AUKb1dzyLzpm3GkLrOYEZt/SiK
 aU5rYg/KjiOSWWr8nR6B3rmlIJ6dzQZvGDS+Y8tNL+6iaL1Bo12OPSl1XtqIB8zdiuTa
 5ost6wwtk+BVbItaTaiQuxWGxy9jetcEWzKJTYeBYWUdYtoer4Ky5TEvdbLN1bz5fm2Y
 0VUg==
X-Gm-Message-State: ANoB5pm9WwvyLeUgcjPUhyfSEKHg4ADGXUkwaBbnQGqsuufwFZOMdFYb
 fR1JsyaiRQ99p/rCSlvXpsmDHFPB6XgDMos93qIfrUtulbPLp7QLxUBG5FSjc0c6YlQcbHL30VQ
 eQm1hPzydYT0Qz0cIDZ6qPrPmNLo=
X-Received: by 2002:a05:6102:1354:b0:3b1:3bb4:3d7e with SMTP id
 j20-20020a056102135400b003b13bb43d7emr15329604vsl.8.1671443561560; 
 Mon, 19 Dec 2022 01:52:41 -0800 (PST)
X-Google-Smtp-Source: AA0mqf693Vx7grnAPlH3tbqKmXO7S0U4Gt+C0FVbhq6NbXax/0Nz31M2AAmsxaqiHP5aiAPIMCwb46l1hHdVA/3PZM4=
X-Received: by 2002:a05:6102:1354:b0:3b1:3bb4:3d7e with SMTP id
 j20-20020a056102135400b003b13bb43d7emr15329603vsl.8.1671443561223; Mon, 19
 Dec 2022 01:52:41 -0800 (PST)
MIME-Version: 1.0
References: <20221216094611.2924-1-pvorel@suse.cz>
 <20221216094611.2924-2-pvorel@suse.cz>
In-Reply-To: <20221216094611.2924-2-pvorel@suse.cz>
From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 19 Dec 2022 10:52:22 +0100
Message-ID: <CAASaF6yUfeCS_MnTiYR1v291d=A0xzijDRJqz1SgGORvnCEXbg@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 1/2] doc: State the minimal kernel version
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

On Fri, Dec 16, 2022 at 10:46 AM Petr Vorel <pvorel@suse.cz> wrote:
>
> Because the tested version does not automatically mean the minimal
> supported.
>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Hi all,
>
> I'm sorry to bother you, many of you concentrate on current mainline (or
> supported stable) instead of digging into history. But you might know
> about somebody who still cares about 3.x. Although not many of these
> people would try to run recent LTP on these old versions, but we never
> know.
>
> I started with 3.0 as that was the result of the old discussions over
> ML.  I'm perfectly ok, if we raise it to 3.10, which is tested.
> I guess after CentOS 7 EOL we should raise support even higher.

I'd be fine with raising it to 3.10, that still covers CentOS7 for now.
(3.10 will be 10 years old in couple months)

Acked-by: Jan Stancek <jstancek@redhat.com>

>
> The motivation is to state the version here, instead in
> doc/c-test-api.txt
> https://patchwork.ozlabs.org/project/ltp/patch/1671166923-2173-7-git-send-email-xuyang2018.jy@fujitsu.com/
>
> Also stating kernel version limits minimal libc version.
> Thus I'm not going to start a discussion about what libc version we
> support.
>
> Kind regards,
> Petr
>
>  doc/supported-kernel-libc-versions.txt | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/doc/supported-kernel-libc-versions.txt b/doc/supported-kernel-libc-versions.txt
> index e48e3aeae3..f89c4882fb 100644
> --- a/doc/supported-kernel-libc-versions.txt
> +++ b/doc/supported-kernel-libc-versions.txt
> @@ -51,7 +51,12 @@ distribution you may as well reconsider you life choices.
>  | s390x         | cross compilation
>  |==================================
>
> -1.3 Supported libc
> +1.3 Minimal supported kernel version
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +Minimal supported (although untested) kernel version is 3.0.
> +
> +1.4 Supported libc
>  ~~~~~~~~~~~~~~~~~~
>
>  [align="center",options="header"]
> --
> 2.39.0
>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
