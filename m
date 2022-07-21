Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 276AFC43334
	for <ltp@archiver.kernel.org>; Thu, 21 Jul 2022 06:31:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B1A5F3C9D96
	for <ltp@archiver.kernel.org>; Thu, 21 Jul 2022 08:31:05 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5AA893C9808
 for <ltp@lists.linux.it>; Thu, 21 Jul 2022 08:30:54 +0200 (CEST)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5BB66600695
 for <ltp@lists.linux.it>; Thu, 21 Jul 2022 08:30:54 +0200 (CEST)
Received: by mail-lf1-x129.google.com with SMTP id bp17so1259984lfb.3
 for <ltp@lists.linux.it>; Wed, 20 Jul 2022 23:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=IYoQxNSTNPsHjHHdnVSJTy6XvsIdkgtZZ+m+9kxdaVU=;
 b=cZTmE+yyZgkjRauw/z93i+eKr30+XFGJf4rOsbFIOkshDTO7DtT6DgMU1FfySEgVZ4
 8tcRWKJXfXdsE8ND0zp0iQcQSqDDQBRnGm3IUm/+0CTLKKxFRjAGEEMDftVCqoLiHDKz
 JbQCZRl2mvkzBVXQZYKO+7jcUFAfzihTz/sz4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=IYoQxNSTNPsHjHHdnVSJTy6XvsIdkgtZZ+m+9kxdaVU=;
 b=BuPUOC/NRa/83SUc61XPegWvNqwOywl5LKtyXjscFGxXHhw8jywnWsjqApHStOjpeJ
 14I0V+/nztTWbqi5JcHxf16Ui1Eue/PL/8so/yMOyY5LxuyhM1TTdsi6z5JctBW4zLkr
 NRl3qmMJqGffWUmYvawpf4SA9Hq+XZ3DDQCuyx1nn2NkJ4+UxAxVyPh/d4ECz7SFs2yS
 xlvqE6q2zLyYb7DXmp/OWJwbqogI5OCdyX25KwKSlCUO3f7ZMQQ2i5YeRwXROafuew39
 wC0n3Rxx9q6mGURiKX0QETlfv+ZaM4bfiNiYpV6nV74O2vf06sPNgMAPBpaiUweoS41g
 b/7Q==
X-Gm-Message-State: AJIora+a5KtRsk6QXtWN72RY7hKaeIFmbGFYj6UXmvDakTOaw1VlN1xQ
 iYwfJkfQ1JZWW4rurNrUIB+1kn6nGsyJEv6YmCMyeA==
X-Google-Smtp-Source: AGRyM1usdgJl116CRWoUjAKiyWdkZRovdyYrhs9Y/nxMXs1ETjBLO8msMh63pAMXzRER3QO83WcRywU7CnVHOdkIVMk=
X-Received: by 2002:a05:6512:1389:b0:489:d0bb:241e with SMTP id
 p9-20020a056512138900b00489d0bb241emr22781346lfa.536.1658385053417; Wed, 20
 Jul 2022 23:30:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220715072951.859586-1-dario.binacchi@amarulasolutions.com>
 <CAFqt6zaMnfGhwxnnJrbW1eoiGy46-WNUe8H-iqztRmZW5Z8jfQ@mail.gmail.com>
In-Reply-To: <CAFqt6zaMnfGhwxnnJrbW1eoiGy46-WNUe8H-iqztRmZW5Z8jfQ@mail.gmail.com>
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date: Thu, 21 Jul 2022 08:30:41 +0200
Message-ID: <CABGWkvqonbDuSXk_iaxV4a-uBtHqeSUqAufj+LZULAVqb+u07Q@mail.gmail.com>
To: Souptick Joarder <jrdr.linux@gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] can: slcan: do not sleep with a spin lock held
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
Cc: kbuild test robot <lkp@intel.com>,
 Linux Memory Management List <linux-mm@kvack.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jeroen Hofstee <jhofstee@victronenergy.com>, linux-kernel@vger.kernel.org,
 linux-can@vger.kernel.org, lkp@lists.01.org,
 Eric Dumazet <edumazet@google.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 kernel test robot <oliver.sang@intel.com>,
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>,
 Paolo Abeni <pabeni@redhat.com>, Jiri Slaby <jirislaby@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, ltp@lists.linux.it,
 Wolfgang Grandegger <wg@grandegger.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello Souptick,

On Thu, Jul 21, 2022 at 3:58 AM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> On Fri, Jul 15, 2022 at 1:00 PM Dario Binacchi
> <dario.binacchi@amarulasolutions.com> wrote:
> >
> > We can't call close_candev() with a spin lock held, so release the lock
> > before calling it. After calling close_candev(), we can update the
> > fields of the private `struct can_priv' without having to acquire the
> > lock.
>
> But here we are updating private 'struct can_priv' before close_candev() while
> taking the lock.  If we go by change logs, then spin_unlock_bh() need to called
> before close_candev() and we can update the private 'struct can_priv'
> in existing place.

sl-> rcount and sl-> xleft are not part of 'struct can_priv' and can
be reset after
calling netif_stop_queu() because it inhibits any serial reception/transmission.

Thanks and regards,
Dario

>
> >
> > Fixes: c4e54b063f42f ("can: slcan: use CAN network device driver API")
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> > Link: https://lore.kernel.org/linux-kernel/Ysrf1Yc5DaRGN1WE@xsang-OptiPlex-9020/
> > Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> >
> > ---
> >
> > Changes in v3:
> > - Update the commit message.
> > - Reset sl->rcount and sl->xleft before releasing the spin lock.
> >
> > Changes in v2:
> > - Release the lock just before calling the close_candev().
> >
> >  drivers/net/can/slcan/slcan-core.c | 7 +++----
> >  1 file changed, 3 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/net/can/slcan/slcan-core.c b/drivers/net/can/slcan/slcan-core.c
> > index 54d29a410ad5..d40ddc596596 100644
> > --- a/drivers/net/can/slcan/slcan-core.c
> > +++ b/drivers/net/can/slcan/slcan-core.c
> > @@ -689,15 +689,14 @@ static int slc_close(struct net_device *dev)
> >                 clear_bit(TTY_DO_WRITE_WAKEUP, &sl->tty->flags);
> >         }
> >         netif_stop_queue(dev);
> > +       sl->rcount   = 0;
> > +       sl->xleft    = 0;
> > +       spin_unlock_bh(&sl->lock);
> >         close_candev(dev);
> >         sl->can.state = CAN_STATE_STOPPED;
> >         if (sl->can.bittiming.bitrate == CAN_BITRATE_UNKNOWN)
> >                 sl->can.bittiming.bitrate = CAN_BITRATE_UNSET;
> >
> > -       sl->rcount   = 0;
> > -       sl->xleft    = 0;
> > -       spin_unlock_bh(&sl->lock);
> > -
> >         return 0;
> >  }
> >
> > --
> > 2.32.0
> >
> >



-- 

Dario Binacchi

Embedded Linux Developer

dario.binacchi@amarulasolutions.com

__________________________________


Amarula Solutions SRL

Via Le Canevare 30, 31100 Treviso, Veneto, IT

T. +39 042 243 5310
info@amarulasolutions.com

www.amarulasolutions.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
