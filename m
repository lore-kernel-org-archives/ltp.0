Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32848C433EF
	for <ltp@archiver.kernel.org>; Thu, 21 Jul 2022 08:32:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BC3423CA00A
	for <ltp@archiver.kernel.org>; Thu, 21 Jul 2022 10:32:07 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4C91C3C0EF2
 for <ltp@lists.linux.it>; Thu, 21 Jul 2022 03:58:17 +0200 (CEST)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 2037E10005AF
 for <ltp@lists.linux.it>; Thu, 21 Jul 2022 03:58:17 +0200 (CEST)
Received: by mail-pj1-x1030.google.com with SMTP id
 n10-20020a17090a670a00b001f22ebae50aso123578pjj.3
 for <ltp@lists.linux.it>; Wed, 20 Jul 2022 18:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ftZmQnNxSbBgGxR5gxqXE4IdbtT6X/p5Ec8B9Vn+x7g=;
 b=qrRsvYIvHunFmKLnL0KKZbsoF09Zae5Nyxvvp2JUqqOcFmHuOoxROb4Y6mPqazxavg
 rGfHsgv+zn+DUzRYJ4SbH/V2z3b2JKQL9j7fTxh3dYNw1cgM3P5MaCtBBFzaV3SvqqcM
 pNfoobD89tofIJPydUuJrl5oJDVQ2pBV8TpDI3lHn6paymKtf1UxTHC4EgwMY/fmh4iI
 Im5gckNJ/CB1WldghugzlBjcs1wZRPQH6d73De7jcFjsmIWIpq56LOYdaa4N7cZMs2+R
 fEQXwhvMuf3m4rwTLSkBVeQhLxkSGDL+e+xt3BCoyjvokTPaRnI7ILbaYaAFF6EeV/gk
 06JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ftZmQnNxSbBgGxR5gxqXE4IdbtT6X/p5Ec8B9Vn+x7g=;
 b=WoDoIQYAosyuUaGj4wW3yP180R3tnWL/sTI+WPf8VnTPW/K4SakBRZJDvsLArf2T4F
 qkXPDe5L7EqrALtcQv0yiLLQ+C4GSwrxEOQ2gAJuYaAlYrD+AZenS/KtfLzymzZvVq9J
 H3Omeerc99H1QkL4Tvxq2pxO7uje7xDEALfIhEjpHT77zL2bXEEP+K4ZswFmEp+t4Wnp
 OG0a4+gNjZvGJ9Wmp4+1oWo4MMFSQL60IQfDorVlenpZJ/WVPjV16kkJ9jC6JZyzZU0s
 Q3iG4ZL0CdS2CJFrycJ06LB/wATA53fQRXj6bGr0ZuouAYs/tloyXcmFG80hHX0qyq8L
 GYWQ==
X-Gm-Message-State: AJIora+26ZFAT0diWheV0jgh4t67jaNBs9rQ2YF8NRqb7JiXp/nCzwuT
 xO/JfyjrPQWRw2TT1y3cS6o8ME9aly+Y68yvFXk=
X-Google-Smtp-Source: AGRyM1t6N7pQcjCsI7OAPPR2xzUGupyIxto7KPa5rosYau5ExUl6th5F/uXzTmwuWKLkGf+X0VhV2mO9Jk/JkPR4BUk=
X-Received: by 2002:a17:90a:b785:b0:1f1:be59:a607 with SMTP id
 m5-20020a17090ab78500b001f1be59a607mr8540324pjr.84.1658368695502; Wed, 20 Jul
 2022 18:58:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220715072951.859586-1-dario.binacchi@amarulasolutions.com>
In-Reply-To: <20220715072951.859586-1-dario.binacchi@amarulasolutions.com>
From: Souptick Joarder <jrdr.linux@gmail.com>
Date: Thu, 21 Jul 2022 07:28:03 +0530
Message-ID: <CAFqt6zaMnfGhwxnnJrbW1eoiGy46-WNUe8H-iqztRmZW5Z8jfQ@mail.gmail.com>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Thu, 21 Jul 2022 10:31:56 +0200
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

On Fri, Jul 15, 2022 at 1:00 PM Dario Binacchi
<dario.binacchi@amarulasolutions.com> wrote:
>
> We can't call close_candev() with a spin lock held, so release the lock
> before calling it. After calling close_candev(), we can update the
> fields of the private `struct can_priv' without having to acquire the
> lock.

But here we are updating private 'struct can_priv' before close_candev() while
taking the lock.  If we go by change logs, then spin_unlock_bh() need to called
before close_candev() and we can update the private 'struct can_priv'
in existing place.

>
> Fixes: c4e54b063f42f ("can: slcan: use CAN network device driver API")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Link: https://lore.kernel.org/linux-kernel/Ysrf1Yc5DaRGN1WE@xsang-OptiPlex-9020/
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
>
> ---
>
> Changes in v3:
> - Update the commit message.
> - Reset sl->rcount and sl->xleft before releasing the spin lock.
>
> Changes in v2:
> - Release the lock just before calling the close_candev().
>
>  drivers/net/can/slcan/slcan-core.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/can/slcan/slcan-core.c b/drivers/net/can/slcan/slcan-core.c
> index 54d29a410ad5..d40ddc596596 100644
> --- a/drivers/net/can/slcan/slcan-core.c
> +++ b/drivers/net/can/slcan/slcan-core.c
> @@ -689,15 +689,14 @@ static int slc_close(struct net_device *dev)
>                 clear_bit(TTY_DO_WRITE_WAKEUP, &sl->tty->flags);
>         }
>         netif_stop_queue(dev);
> +       sl->rcount   = 0;
> +       sl->xleft    = 0;
> +       spin_unlock_bh(&sl->lock);
>         close_candev(dev);
>         sl->can.state = CAN_STATE_STOPPED;
>         if (sl->can.bittiming.bitrate == CAN_BITRATE_UNKNOWN)
>                 sl->can.bittiming.bitrate = CAN_BITRATE_UNSET;
>
> -       sl->rcount   = 0;
> -       sl->xleft    = 0;
> -       spin_unlock_bh(&sl->lock);
> -
>         return 0;
>  }
>
> --
> 2.32.0
>
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
