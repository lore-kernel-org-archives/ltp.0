Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41DAAC4332F
	for <ltp@archiver.kernel.org>; Mon, 19 Dec 2022 18:12:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B0FF53CBAFE
	for <ltp@archiver.kernel.org>; Mon, 19 Dec 2022 19:12:41 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 142AB3C6C93
 for <ltp@lists.linux.it>; Mon, 19 Dec 2022 19:12:30 +0100 (CET)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 271BB600703
 for <ltp@lists.linux.it>; Mon, 19 Dec 2022 19:12:30 +0100 (CET)
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-143ffc8c2b2so12533206fac.2
 for <ltp@lists.linux.it>; Mon, 19 Dec 2022 10:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VPDl4+peJ+VfBAEagz4dSQ+hmm2dERK4VoEQf1HXyYU=;
 b=XxjUpH4L37K//stlgZeYjO30c57vKS1tvzwD6PTzIp5OYfbofe+606665OGNNgfZv+
 4I9yQCG8N6vfgBWpR7py2vANEeoCHbp6/4nsrL66ptm82o0WheCYTNFzuGNDuZaW4Fch
 UHa0S/mmNNRlCV6sA/TxQCmpnY45p/k7KE+5xNtj7osSFMw1wwTWaiWf1mc26srVtApZ
 XqSd/UUOcZLeLdLsdqutOWrNj6sYvzDpP7kKlXZ9kdf2MKy3hi9Axr/tD65J4Y/ererb
 nOjwwt+dSNBCpwuuoEF0+mRweQGmfPXRG9ymvNYzVFI3WErp6tVF8GnhNT9jUNZyCxxR
 otEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VPDl4+peJ+VfBAEagz4dSQ+hmm2dERK4VoEQf1HXyYU=;
 b=XcF8K56wKiNEs8ICDsRjwaBcBA/NLp6AgwrpxFhiTm2BVaNObN7mPqw6DvVf7URWoC
 Ada0dy0/1IQEX4vaxGBPvkDSlSUuuLF/qq4SGuT30o4Oq2T6bV8sPHO623zauclpK/M9
 t1MbVEGZdHeqdP76wyFo9H9QteW846hCVvmJ5KyCnB+kXtbwjEvmGay3TInuD4avnbw/
 cYVuu+Yjcp+CAT1qQtAkcXofSB6C7runCvns51gkeH0rRA9PkEw3gZZATKroR/o/9A2Z
 6aZN7bNakUmV5EI1cTdCc7fnTCeJhR6bye1N/dTvLe2QdwB3mepOlcBbfcTS86yyiZOx
 mwSg==
X-Gm-Message-State: ANoB5pmuxBIUUotlJqNrXb5C9p7r0o+pYokrGXJ74Tg8oxY6WbWF3OOz
 lFf7/QiA07aKn38xczGAROKg9JorgxOeJhmSiOQ=
X-Google-Smtp-Source: AMrXdXuJAexclRtmxgpj08/8VkubVtZH9UYVRAQRnCQLjkfqmUtcMMBueRV4jr3a1m4FN0exYUUiP94YTArCUdim4xU=
X-Received: by 2002:a05:6870:9f09:b0:144:e1eb:419 with SMTP id
 xl9-20020a0568709f0900b00144e1eb0419mr1362051oab.262.1671473548507; Mon, 19
 Dec 2022 10:12:28 -0800 (PST)
MIME-Version: 1.0
References: <20221216094611.2924-1-pvorel@suse.cz>
 <20221216094611.2924-2-pvorel@suse.cz>
In-Reply-To: <20221216094611.2924-2-pvorel@suse.cz>
From: Khem Raj <raj.khem@gmail.com>
Date: Mon, 19 Dec 2022 10:12:02 -0800
Message-ID: <CAMKF1sp8nXx8S-emPadkqz9WHaarRHQ2MK+-QT8uBFAg7FVxKw@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
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
 =?UTF-8?Q?Jan_L=C3=BCbbe?= <jlu@pengutronix.de>,
 Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it,
 automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Fri, Dec 16, 2022 at 1:46 AM Petr Vorel <pvorel@suse.cz> wrote:
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

LGTM

Acked-by: Khem Raj <raj.khem@gmail.com>

>  ~~~~~~~~~~~~~~~~~~
>
>  [align="center",options="header"]
> --
> 2.39.0
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
