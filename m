Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53740CCF9E5
	for <ltp@archiver.kernel.org>; Mon, 27 Oct 2025 14:23:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5865D3C65DA
	for <ltp@archiver.kernel.org>; Mon, 27 Oct 2025 15:23:13 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E97123C1008
 for <ltp@lists.linux.it>; Mon, 27 Oct 2025 15:22:57 +0100 (CET)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 737EF20074B
 for <ltp@lists.linux.it>; Mon, 27 Oct 2025 15:22:57 +0100 (CET)
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-87c43c19947so791206d6.2
 for <ltp@lists.linux.it>; Mon, 27 Oct 2025 07:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761574976; x=1762179776; darn=lists.linux.it;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KvQYFgona4Lh6HM59QwMF6haTCcRbTN7dae+voz5cDA=;
 b=TRO3jjZ/M4Nafj5q/8Fn6E1hlUrcTSXhqqdHL3qdm3xiFniFOlwck41ad6KfjQXYMY
 brqmiukz2rFXP6Gfi0ceXmEskWcfM62TfnbRFEWY/MhdxaKjU0Jwi/7M9RCH37sAJ4kt
 DXWkgBE1HB3gNeE3nlHDvqVMio9ITU0tq5yfmQFaLGVgL4ENnYNA1bPiDKpskjI6mGEI
 aj1lrwkoXhVnSyWAK8meLwhFS6wzAse/YGqG10l/SOhRxcE93LUEjn3K4CYR9wRSxYP3
 Ciu2FyWRnwgMnZpIKLEiUiDzU00847sLSdS9CaOETHk4hlHC1tfdheqB8lzdRysqU4I2
 xX4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761574976; x=1762179776;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KvQYFgona4Lh6HM59QwMF6haTCcRbTN7dae+voz5cDA=;
 b=i7OPAlE4Ofw6LyMAeQcsxsVTiwv0AMDV5FQJrDf3Jdxf43LyJIQiFIMv9GnWQ1vMTf
 4Ne+NjRP4SjQ2jSEAQNz+XnvgD22M6EMmBYFSYt9XAE4UFjpFmkhBjoKxcsOs6XI4ggB
 jfjX+l4ZJxQN5nbqYoSQAFvY/jc/kGcd895KeGBeRWeMhUOULbc+HqDmhClYoG1uTHv9
 wb7OY+i1joy5MoeDxLzb94Z1XUB3EKolcd/m7Uq55PtMF0a890SeOOfGVBmnJLTAWMtl
 uKsxWF6Q2Z5m/TVJdL3eptwdNfiNuHd3R6iBn1yOY681NlSdXY/GStVnohTebm01TPCF
 7W8g==
X-Gm-Message-State: AOJu0YziyRxctVb6XrtnhdlFl9RdIufz5a1/ft4p9Fit83a4qbCA52W8
 BHmS8SFJR8iolcA+PiCP2GFgtk35cCo4VlkjhzdIpy1JD/S6NNvZ2ZGRn9gRoPR6q/kouGSFJKz
 3rF5xoJaVOxgJtfxlJoxbhV5Mx1/dy/ERBJFgA7b+CYt85Er8yT/0
X-Gm-Gg: ASbGnctU+cTPp0sJqu0XT45aNDZOVm//Vx8lStVLcYwk11oZi/xSvO6+pZaRVzfYeYE
 2jDaExJ4wZMjszSdTh99ubKRJYCeWka3lzDycrvszi+U3EG9+52UJ3qAuyf8HVboFMSMWNUgk48
 o9yGxRySZywPYjOxWCZmycmz0kE56tmDJowVFU582nXgcitUST8Ub9URTb1npMHAlqEdJBg3gbN
 f76e2fUeo/N6rqsQjnAuARo2BLMAoa0rhgq/Mxo2LDOtILaLwTxTRzG/ABDVtTCgyEzhP/Z+Ubm
 D3L3
X-Google-Smtp-Source: AGHT+IHxxNfZ2qE/cZ7G/cpWmIAlEfIAarUMF74D4hne0Qrl+NWqosz+u5hK5bfAgshWPQ5C1l9gw7VxxehePdLiwJw=
X-Received: by 2002:a05:6214:d04:b0:87d:ad10:215b with SMTP id
 6a1803df08f44-87de70b4540mr185970126d6.1.1761574975862; Mon, 27 Oct 2025
 07:22:55 -0700 (PDT)
MIME-Version: 1.0
References: <20251024125649.2343520-1-anders.roxell@linaro.org>
 <aP81KaVnfcm1sj8j@rei>
In-Reply-To: <aP81KaVnfcm1sj8j@rei>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Mon, 27 Oct 2025 15:22:44 +0100
X-Gm-Features: AWmQ_bmP47erE6KiyHlpnx1T56wiJWqYE1KdBN0nW3bHh10KRUXVOoiQWvlm_MA
Message-ID: <CADYN=9Lfr6cN_dz18AXrSepe+f8-wb3=tYC9rG_A5e=G3-+zKA@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] isofs: Add ISO9660 kernel config requirement
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
Cc: dan.carpenter@linaro.org, ltp@lists.linux.it, benjamin.copeland@linaro.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Mon, 27 Oct 2025 at 10:03, Cyril Hrubis <chrubis@suse.cz> wrote:
>
> Hi!
> >  TST_NEEDS_CMDS="mount umount"
> >  TST_NEEDS_TMPDIR=1
> > +TST_NEEDS_KCONFIGS="CONFIG_ISO9660_FS=y | CONFIG_ISO9660_FS=m"
>
> If you add just TST_NEEDS_KCONFIGS="CONFIG_ISO9660_FS" it will match both
> =y and =m I've added this shortcut to the library so that we do not need
> to write it as you did above.

Oh great, I didn't know. I'll send a v2 shortly.

Cheers,
Anders

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
