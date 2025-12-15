Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31B7DD5B84A
	for <ltp@archiver.kernel.org>; Mon, 15 Dec 2025 16:05:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CEED43D02EE
	for <ltp@archiver.kernel.org>; Mon, 15 Dec 2025 17:05:20 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C503F3D010B
 for <ltp@lists.linux.it>; Mon, 15 Dec 2025 17:05:01 +0100 (CET)
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com
 [IPv6:2607:f8b0:4864:20::e2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 8F790600657
 for <ltp@lists.linux.it>; Mon, 15 Dec 2025 17:04:56 +0100 (CET)
Received: by mail-vs1-xe2a.google.com with SMTP id
 ada2fe7eead31-5dfccb35b10so2531086137.3
 for <ltp@lists.linux.it>; Mon, 15 Dec 2025 08:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765814695; x=1766419495; darn=lists.linux.it;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=g2VM3spcP/IKkPHxWi2VraLjKE9pZ7gwpiQa39s63Zk=;
 b=Wga4jrmAMVEFuNWGo5FyJ7IPs/iT62S/zx5qDEepjzIlln9hmcwpzs6zFv8GjkRaQ5
 rVWSsONQ6eX6KOiE1UfII+hHi0TmVSFh+hC3+KNBIw7Jb/0vst8nMgmGEx8VTYbIZvx6
 HJBH8pM7e4BPpPSdyPXD1GUzlYTRJB4HPJgs98QvJnSnYexIJU6eJMUEnJjc7zmkFos1
 xp68PGWZ+U0Cyf2UyFY3jYc6f2ThiQ01Wz4PEmW7eRaTAdowYZW4Qn4cwW+79bKvJO7r
 ZILkqIgtYSxEwpgCFa4549TKEfTzpXtZT0C3N7nKv6uhyl67hBGhrO3OqZOH84c/7Ze9
 RDMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765814695; x=1766419495;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g2VM3spcP/IKkPHxWi2VraLjKE9pZ7gwpiQa39s63Zk=;
 b=YZwUBxN/i3epso7CcQKRA9rSWdeNC8XAHFmqeroDOyIGyyN+etzcvMFYh76YYd8+tY
 z09npngeezaQIby2YE0A7HJdEq4DUcUQgbZsPyi0ym2Z4EZ5PIwLqXv5ZlcjlCTzdU38
 IE8Yv3CHQu44oZCB3QyoF0usKbrljppxdz3TEMKDuN2kS0wW/afj/iH7aiYTCs4QfuK4
 7yL31jjQuIaCyZI788v8t+gBaFICdPKpYhP120ViwU8r8kdl74OeNexP4TFlapl6wtqL
 c0y6pWtjm3MEobBXzK34Z3wxzQPOM/UbVWRtDA4uqqtMV6K10KWEFI+Zq854IXMzahRY
 WOiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBmnvvpmkdZQWvFCZV3hUh+lAQ4pWk4ZuajcJWscRhbmaHZbs39WSboHDIxscJbtdldwU=@lists.linux.it
X-Gm-Message-State: AOJu0YwsgPHuYfFugZmcUNINa3pk1m4CQbu1b9GN53BMHJlB2IspzX88
 ll5qLrTix1tAcRVKARcPycGRND51LJiYa96G2kXbaiKKH6RdgJcvB6LchVP1uYOqR3J77BU97u6
 32NO3+IUoD41LuYkZynoaKh1ruNE1orgdgFRpSjyz
X-Gm-Gg: AY/fxX6ouOIK3cnHQA1ZUMTte1W0MmKmrtyEAQij8gfjmSH6uhRHZI+wu+MDbxNwL8N
 fWgjp+QHJsM31PKTNPEA8Ynisps9/GB1HZUmmo/z3vXLCweMK/TDTHkqv20zYZ/qnBzsgJqa35Y
 7NIZIsQqcYGWc/TZZb6fj+grx2LX95U9dS6ulJqwsuoUDEy6QCO7tGjdzE1/Q2SZQcOk/s6v4pv
 mFXFS8UldYLH10oc3n2RpZU9NuaVvRiQkRJl93KcLF18MdB48vrLHTApZEJFDbZAXvaKiG0CqLb
 /qI=
X-Google-Smtp-Source: AGHT+IExLJMWZWpPv7b2jYrrbz5rtUa7B7yv0FeZhmRRJfFpaP5VNPZBuImXMvv0mk9snrYBm39ihSq9e3SX/KiP/RQ=
X-Received: by 2002:a05:6102:f06:b0:5db:32dc:f05b with SMTP id
 ada2fe7eead31-5e827837dd1mr4154945137.42.1765814695020; Mon, 15 Dec 2025
 08:04:55 -0800 (PST)
MIME-Version: 1.0
References: <20251215-fix_ci-v1-1-792d418fc240@suse.com>
 <20251215155532.GD272695@pevik>
In-Reply-To: <20251215155532.GD272695@pevik>
From: Ben Copeland <ben.copeland@linaro.org>
Date: Mon, 15 Dec 2025 16:04:43 +0000
X-Gm-Features: AQt7F2pxrDn57AJMScDr0SkQLFTF1n5blpYEgyUUSJwLLc8Pf4weNYqFGLHvy6s
Message-ID: <CAL0q8a6bP0TJn4xCBoL0sRKeLatXYMw3qUGJQszZ5+1tHv83Qw@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] ci: fix patch download when using curl
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Mon, 15 Dec 2025 at 15:55, Petr Vorel <pvorel@suse.cz> wrote:
>
> Hi Andrea,
>
> > curl started to fail on CI after bots have been introduced to verify
> > that a human is interacting with patchwork. This creates an issue when
> > we need to download patches, since at the very first redirection we will
> > miss the server hosting our patches. By using `--location-trusted`, we
> > trust the bots redirection and we make sure that it's possible to
> > download the patch which is going to be applied via `git am`.
>
> > Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> > ---
> >  .github/workflows/ci-docker-build.yml | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> > diff --git a/.github/workflows/ci-docker-build.yml b/.github/workflows/ci-docker-build.yml
> > index 09eb8bb6d446b3e7100f43844942a5dd3976badb..408eb9a69f5cbebf725751633db46169be288bb8 100644
> > --- a/.github/workflows/ci-docker-build.yml
> > +++ b/.github/workflows/ci-docker-build.yml
> > @@ -155,7 +155,7 @@ jobs:
> >          git config --global --add safe.directory "$GITHUB_WORKSPACE"
>
> >          git checkout -b review_patch_series_"${{ inputs.SERIES_ID }}"
> > -        curl -k "${{ inputs.SERIES_MBOX }}" | git am
> > +        curl -k -L --max-redirs 1 --location-trusted "${{ inputs.SERIES_MBOX }}" | git am
>
> Hopefully --max-redirs 1 is enough.
> Thanks for looking into this!

I suggest adding --retry to the CURL call. --retry 3. At least then
when curl fails, it won't fail on the first?

Ben

>
> Acked-by: Petr Vorel <pvorel@suse.cz>
>
> Kind regards,
> Petr
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
