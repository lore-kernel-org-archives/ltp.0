Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4627ACCA479
	for <ltp@archiver.kernel.org>; Wed, 13 Jul 2022 15:36:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 35E9D3CA8CE
	for <ltp@archiver.kernel.org>; Wed, 13 Jul 2022 17:36:12 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2ECD93CA757
 for <ltp@lists.linux.it>; Wed, 13 Jul 2022 17:36:02 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 33AAC600BFA
 for <ltp@lists.linux.it>; Wed, 13 Jul 2022 17:36:00 +0200 (CEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 44C28618B6;
 Wed, 13 Jul 2022 15:35:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F184C34114;
 Wed, 13 Jul 2022 15:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1657726558;
 bh=mgxy9tQlFOmuXGe/eDtjY4cNpf4Y+AzDQIzHZ79WdcU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=pYuTs0tk2wj9krwWwVU7XAoM7TqSndfIBr601D0J36JHSuzoIsmSftnD3LfBN6j5f
 CYyX76ZU0MrLKgJD/zO+5IhBxFj7Ecl2Nv56vs33nbQsSofTebQ0St3dfQAy2/JxL6
 RpzqIQIwIHqfOlPztwzTmSGZW4F4OGi0ri2DGtJ0=
Date: Wed, 13 Jul 2022 17:35:54 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Message-ID: <Ys7mWmIfuJy+1ax7@kroah.com>
References: <20220713151947.56379-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220713151947.56379-1-dario.binacchi@amarulasolutions.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] can: slcan: do not sleep with a spin lock held
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
Cc: lkp@intel.com, lkp@lists.01.org, netdev@vger.kernel.org,
 Jeroen Hofstee <jhofstee@victronenergy.com>, linux-kernel@vger.kernel.org,
 linux-can@vger.kernel.org, Linux Memory Management List <linux-mm@kvack.org>,
 Eric Dumazet <edumazet@google.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 kernel test robot <oliver.sang@intel.com>,
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Jakub Kicinski <kuba@kernel.org>,
 Marc Kleine-Budde <mkl@pengutronix.de>, Paolo Abeni <pabeni@redhat.com>,
 Jiri Slaby <jirislaby@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 ltp@lists.linux.it, Wolfgang Grandegger <wg@grandegger.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, Jul 13, 2022 at 05:19:47PM +0200, Dario Binacchi wrote:
> We can't call close_candev() with a spin lock held, so release the lock
> before calling it.
> 
> Fixes: c4e54b063f42f ("can: slcan: use CAN network device driver API")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Link: https://lore.kernel.org/linux-kernel/Ysrf1Yc5DaRGN1WE@xsang-OptiPlex-9020/
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> 
> ---
> 
>  drivers/net/can/slcan/slcan-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/can/slcan/slcan-core.c b/drivers/net/can/slcan/slcan-core.c
> index 54d29a410ad5..6aaf2986effc 100644
> --- a/drivers/net/can/slcan/slcan-core.c
> +++ b/drivers/net/can/slcan/slcan-core.c
> @@ -688,6 +688,7 @@ static int slc_close(struct net_device *dev)
>  		/* TTY discipline is running. */
>  		clear_bit(TTY_DO_WRITE_WAKEUP, &sl->tty->flags);
>  	}
> +	spin_unlock_bh(&sl->lock);
>  	netif_stop_queue(dev);

Can you have a lock held when calling netif_stop_queue()?  You don't
mention this in your changelog text :(

thanks,

greg k-h

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
