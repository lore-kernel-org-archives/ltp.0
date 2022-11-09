Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 699FEC4332F
	for <ltp@archiver.kernel.org>; Wed,  9 Nov 2022 22:08:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E75B43CD763
	for <ltp@archiver.kernel.org>; Wed,  9 Nov 2022 23:08:17 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 27B7B3CD722
 for <ltp@lists.linux.it>; Wed,  9 Nov 2022 23:08:09 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A517C6008DD
 for <ltp@lists.linux.it>; Wed,  9 Nov 2022 23:08:07 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DDD1F337BA;
 Wed,  9 Nov 2022 22:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1668031686;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7urUNskayTd1SGPbO2jRA+qHJ9m4P64m8g/fnY2xxEc=;
 b=P8uXFlGhXKDLvAC/8peds9cZpAHDUAwEzRuseDyVYNHKwSPR/HYHBUm9H7Ur1a2lUIcyeH
 qT4u4B91xFS9SKUsVBIJnSptB0p8Gm7WNZE8i+HHSIn+IFg3omAQSUapC/n6puNDwZkdU2
 DAA/cr+hKvUlUwIoVE3nDVMIJM/Vz94=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1668031686;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7urUNskayTd1SGPbO2jRA+qHJ9m4P64m8g/fnY2xxEc=;
 b=2KI7jo8WCBbi0rC6LB2o4uN2Dx9AP/bVharrGirY9awbEubefsqGuks6uGs9nzzo3qkxyK
 BFrH3x45c+mNGaAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5AB4A139F1;
 Wed,  9 Nov 2022 22:08:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id GbG1FMYkbGM/GQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 09 Nov 2022 22:08:06 +0000
Date: Wed, 9 Nov 2022 23:08:04 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Message-ID: <Y2wkxBEnbP9jM0h3@pevik>
References: <20221107191136.18048-1-pvorel@suse.cz>
 <Y2l3vJb1y2Jynf50@google.com> <Y2l89dt/t8M6+9go@pevik>
 <Y2mJ42Ap7VIZu32Y@pevik> <Y2mrRxHhVi/QEiUf@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y2mrRxHhVi/QEiUf@google.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/1] Possible bug in zram on ppc64le on vfat
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: Jens Axboe <axboe@kernel.dk>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 Minchan Kim <minchan@kernel.org>, ltp@lists.linux.it,
 linux-kselftest@vger.kernel.org, Nitin Gupta <ngupta@vflare.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Sergey, Minchan, all,


> On (22/11/07 23:42), Petr Vorel wrote:
> [..]
> > 15859712        0        0 26214400   196608      242        0
> > zram01 7 TINFO: /sys/block/zram1/mm_stat
> > 15859712        0        0 26214400   196608      242        0
> > zram01 7 TINFO: /sys/block/zram1/mm_stat
> > 15859712        0        0 26214400   196608      242        0
> > zram01 7 TINFO: /sys/block/zram1/mm_stat
> > 15859712        0        0 26214400   196608      242        0
> > zram01 7 TINFO: /sys/block/zram1/mm_stat
> > 15859712        0        0 26214400   196608      242        0
> > zram01 7 TINFO: /sys/block/zram1/mm_stat
> > 15859712        0        0 26214400   196608      242        0
> > zram01 7 TINFO: /sys/block/zram1/mm_stat
> > 15859712        0        0 26214400   196608      242        0
> > zram01 7 TBROK: "loop_read_mem_used_total /sys/block/zram1/mm_stat" timed out

> Looking at mm_stat_show(), mem_used can be 0 when mm_stat_show() is
> called on un-initialized device

> ---
> ...
>         u64 orig_size, mem_used = 0;
>         long max_used;
>         ssize_t ret;

>         memset(&pool_stats, 0x00, sizeof(struct zs_pool_stats));

>         down_read(&zram->init_lock);
>         if (init_done(zram)) {
>                 mem_used = zs_get_total_pages(zram->mem_pool);
>                 zs_pool_stats(zram->mem_pool, &pool_stats);
>         }
> ...
> ---

> Can you check if init_done() returns true in your tests?

I'm sorry, it took me some time to find machine where I'd be compile kernel.
Yes, init_done() returns non-zero (1), code goes into if clause and sets
mem_used. I'll check also for mem_used value.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
