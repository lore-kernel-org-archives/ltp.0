Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6458DC433EF
	for <ltp@archiver.kernel.org>; Mon, 13 Jun 2022 16:04:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 664E63C9434
	for <ltp@archiver.kernel.org>; Mon, 13 Jun 2022 18:04:21 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 98B5D3C8F82
 for <ltp@lists.linux.it>; Mon, 13 Jun 2022 18:04:09 +0200 (CEST)
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com
 [IPv6:2607:f8b0:4864:20::e36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id EDD2F600858
 for <ltp@lists.linux.it>; Mon, 13 Jun 2022 18:04:08 +0200 (CEST)
Received: by mail-vs1-xe36.google.com with SMTP id j39so6313286vsv.11
 for <ltp@lists.linux.it>; Mon, 13 Jun 2022 09:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=A/nPcYt4Q8aE3g5+S+oxTmltyxy8JxslPGiELtQ4Y6U=;
 b=PHo0gqLLaaUk3t4surzUOwyt5sfVBdkhbdeIPU9ByvkaMEmT2VMuJmHn2h7fVKt26U
 6Vy8oyLEXHq7UxWlUrlA8lpHSKTdkcZqz4Np08q4b5nsuHuA3+QCMHrWQSizKH8JZBLp
 fAfJUg/QIREvk2c+3dNJCofrNAcHH2miP4VroXznNXdEZv2gZfoYwkYY5Zr6adIYHktW
 wUmriqebJ+OHnrManfIVbSde9QOzBMtXeBbVVG4pnLZjrmbcmrDNbvFE2Yq9QQnM5uf9
 2JuW/gjzri8B7UT/W5dAhuP0sjnFM/sh7yF9D3nJpWRgkyDSB8fSJiBi3F9wse0oFVT0
 yxuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=A/nPcYt4Q8aE3g5+S+oxTmltyxy8JxslPGiELtQ4Y6U=;
 b=slkMOJ1TiSjpZOI52irc0oF1yAMyZSpYlV79oHcIgDM/yeVwxe6VGAKYWMPxDyAhou
 W8tpKjGtvVeRPIaY15hhpgO7WS1yl3ECvOdvDAZ7KtOrKdSbAFXnZtm2N4Y0iIYwjpbq
 k0Hi+uB5YAwKLO6KTF3bcTEkaYbGTBRCXrYH98p8MLhZ4h1AJePfzMjhNqcQloLwrYqX
 yPbt9QwRsWU0s+F8VFZyQ1eL1ZfhrgEYk/7+ZcWsYh6MN81M+x6Q3NheG2vTRVlKX7rr
 5CueR51a40TWUVAFFBlP4o9iARH8A+fQec8Bm4hAH96YOqleDiGcUCn6S14+4yX+WNjk
 4VIg==
X-Gm-Message-State: AJIora9CM8KWidsmbAt+q0TC5UcyKk4PtDeQLhqwz3OvllgyWuH5MoJT
 K27+OGQMmN4mLBJgBzlILRi96utd7h1o6gRi0iFovY9+LPDebg==
X-Google-Smtp-Source: AGRyM1ucl9nulR8Xe8rZYLZ4+Vet9O6dNxfgGWTsB1X55hAt2wauivhGSiA5yN7eNimpe5Sz6k+dDXOWUIyVc4HkHgE=
X-Received: by 2002:a05:6102:c50:b0:34c:2063:ae5e with SMTP id
 y16-20020a0561020c5000b0034c2063ae5emr203873vss.71.1655136247842; Mon, 13 Jun
 2022 09:04:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220613143826.1328830-1-amir73il@gmail.com>
 <20220613143826.1328830-2-amir73il@gmail.com>
 <CAOQ4uxjfuQ5oj8V8weD+-ChvXZ9nXy=MB285dAn1zQKV6dn2cA@mail.gmail.com>
 <YqdWY1C/xBi3/tgG@pevik>
In-Reply-To: <YqdWY1C/xBi3/tgG@pevik>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 13 Jun 2022 19:03:56 +0300
Message-ID: <CAOQ4uxh6aJq+uMsFOBBeG+S3OTGABP2qmb7oDXOATa35A83H3g@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/5] syscalls/inotify12: Introduce test for
 inotify mask flags
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
Cc: Matthew Bobrowski <repnop@google.com>, Jan Kara <jack@suse.cz>,
 LTP List <ltp@lists.linux.it>, Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Mon, Jun 13, 2022 at 6:23 PM Petr Vorel <pvorel@suse.cz> wrote:
>
> Hi Amir,
>
> > > diff --git a/testcases/kernel/syscalls/inotify/inotify12.c b/testcases/kernel/syscalls/inotify/inotify12.c
> ...
> > > +static struct tst_test test = {
> > > +       .timeout = 10,
>
> > OOPS should be changed to .max_runtime = 10
>
> > > +       .needs_tmpdir = 1,
> > > +       .cleanup = cleanup,
> > > +       .test = verify_inotify,
> > > +       .tcnt = ARRAY_SIZE(tcases),
> > > +       .tags = (const struct tst_tag[]) {
> > > +               {"linux-git", "a32e697cda27"},
> > > +               {}
>
> > Missing }
>
> > Sorry, I hadn't notice this build failure before posting.
>
> No big deal, we can fix this before merge.
>
> And we have to try again to decide how to quickly merge tests for rc kernel.

Right.. forgot about that.
FWIW, the specific fix of test inotify12 is already in stable kernels
(v5.10.121, ...)

Thanks,
Amir.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
