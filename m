Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0D9FC4332F
	for <ltp@archiver.kernel.org>; Fri, 11 Nov 2022 08:38:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 53F3A3CD52E
	for <ltp@archiver.kernel.org>; Fri, 11 Nov 2022 09:38:26 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C688E3C0181
 for <ltp@lists.linux.it>; Tue,  8 Nov 2022 02:05:18 +0100 (CET)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com
 [IPv6:2607:f8b0:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 030821400B80
 for <ltp@lists.linux.it>; Tue,  8 Nov 2022 02:05:18 +0100 (CET)
Received: by mail-pf1-x430.google.com with SMTP id b185so12411313pfb.9
 for <ltp@lists.linux.it>; Mon, 07 Nov 2022 17:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+9NiTraJTVI3GZSgQulM4QdB39VgKWNnbTrt/IiQ+Zs=;
 b=ZPTfykv3GFLo2GZPuvohfWNbYYG1PB0gSDVQ7SQgnq5zL9xmlEXwcKOTOFdR1t6yP5
 6sFjxRjPNbOpKCszIBZNELwVeWRE1cGMnsmIgWd5oTRdTLYRb84e+Odos42KCv6KtgXm
 2QZXjS80ZNX6fUoo3yOgmoLezTu6Y2Cep31SQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+9NiTraJTVI3GZSgQulM4QdB39VgKWNnbTrt/IiQ+Zs=;
 b=K3McPghwBNRnRUpqsgjQgzPvKc1C8AiJCZNxQgp7w/KV8bEsuBtJK7F1ThknkxSNDB
 q5pebhz+4C6QMrwFUMuzqEZKj/EIbjEdsfooW1e0fogfx6KaL8PTzBxjdLVwXKrJ2ZSM
 +sQa/gYUlWknzV8QMblhvv7H19KXTrsgF+qDhJwEZNqNVRQ682RATvdAySnXbXlxSPhf
 f1VD6McXBgMiPOMUurUAz1igChYX39QWjv7gg6k4AtrmTqZ9z+XFipIF7QfQ4X2B5Fc9
 uEgLEFm4Gc/DmVijqsnszZ34T4E/VPQS9+imIKQhBmNz/UCv0TXT6hd6eJ2eunPiWR5j
 Om+A==
X-Gm-Message-State: ACrzQf0Eq/ksNXR/kytqunJjYYCD1UYxXQp9m+vlTlxDn5yRQSi6ogfF
 4qAT7GMzoJgppUleRnasrxazsQ==
X-Google-Smtp-Source: AMsMyM4k/IRQ3yHRp4KWi+gUwm6Rw1wJ6/tpCXcW4fyYfLEBxbpPL1/bVgm/DLIXtSVfzSABqnOyNg==
X-Received: by 2002:a05:6a00:22cf:b0:56d:1c55:45d0 with SMTP id
 f15-20020a056a0022cf00b0056d1c5545d0mr50553101pfj.54.1667869516351; 
 Mon, 07 Nov 2022 17:05:16 -0800 (PST)
Received: from google.com ([240f:75:7537:3187:8d5d:1342:1172:9487])
 by smtp.gmail.com with ESMTPSA id
 k17-20020a63ff11000000b0046f9f4a2de6sm4743649pgi.74.2022.11.07.17.05.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Nov 2022 17:05:15 -0800 (PST)
Date: Tue, 8 Nov 2022 10:05:11 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Y2mrRxHhVi/QEiUf@google.com>
References: <20221107191136.18048-1-pvorel@suse.cz>
 <Y2l3vJb1y2Jynf50@google.com> <Y2l89dt/t8M6+9go@pevik>
 <Y2mJ42Ap7VIZu32Y@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y2mJ42Ap7VIZu32Y@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Fri, 11 Nov 2022 09:38:05 +0100
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
Cc: Jens Axboe <axboe@kernel.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>,
 OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, Minchan Kim <minchan@kernel.org>,
 ltp@lists.linux.it, linux-kselftest@vger.kernel.org,
 Nitin Gupta <ngupta@vflare.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On (22/11/07 23:42), Petr Vorel wrote:
[..]
> 15859712        0        0 26214400   196608      242        0
> zram01 7 TINFO: /sys/block/zram1/mm_stat
> 15859712        0        0 26214400   196608      242        0
> zram01 7 TINFO: /sys/block/zram1/mm_stat
> 15859712        0        0 26214400   196608      242        0
> zram01 7 TINFO: /sys/block/zram1/mm_stat
> 15859712        0        0 26214400   196608      242        0
> zram01 7 TINFO: /sys/block/zram1/mm_stat
> 15859712        0        0 26214400   196608      242        0
> zram01 7 TINFO: /sys/block/zram1/mm_stat
> 15859712        0        0 26214400   196608      242        0
> zram01 7 TINFO: /sys/block/zram1/mm_stat
> 15859712        0        0 26214400   196608      242        0
> zram01 7 TBROK: "loop_read_mem_used_total /sys/block/zram1/mm_stat" timed out

Looking at mm_stat_show(), mem_used can be 0 when mm_stat_show() is
called on un-initialized device

---
...
        u64 orig_size, mem_used = 0;
        long max_used;
        ssize_t ret;

        memset(&pool_stats, 0x00, sizeof(struct zs_pool_stats));

        down_read(&zram->init_lock);
        if (init_done(zram)) {
                mem_used = zs_get_total_pages(zram->mem_pool);
                zs_pool_stats(zram->mem_pool, &pool_stats);
        }
...
---

Can you check if init_done() returns true in your tests?

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
