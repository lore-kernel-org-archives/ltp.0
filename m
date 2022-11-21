Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11DB2C4332F
	for <ltp@archiver.kernel.org>; Mon, 21 Nov 2022 09:41:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7CC693CCBAE
	for <ltp@archiver.kernel.org>; Mon, 21 Nov 2022 10:41:26 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0454F3C0F12
 for <ltp@lists.linux.it>; Mon, 21 Nov 2022 10:41:16 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 37C8264476B
 for <ltp@lists.linux.it>; Mon, 21 Nov 2022 10:41:15 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 89EBD21AC3;
 Mon, 21 Nov 2022 09:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1669023675;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x4svcpQifmjNQouc72E4WUVyl0JmTYJ7FIcleg5VVfk=;
 b=Za0f7AJe52OAjDc+cUdFIv/Y3rnSPBO8l20gpsDrU1H93th+sbNje4hWKKXjRqFXYV3YrY
 RqVP7Mcm/stCzCkCyaKDEXv1yAc9FnowwdBJbI8KnQ9J4peC3pcY/zvjV41XJ1jrL4svS/
 gyMG0jMUz7BfWw+tSp9ZGPMdecMJuTg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1669023675;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x4svcpQifmjNQouc72E4WUVyl0JmTYJ7FIcleg5VVfk=;
 b=NFMaWY01+uSO0f1Y0Zr7QgM+Cnj/KWqdg9BIFqEYLqsVklQOuUf4c23ApJ7B9VcYgP5ynm
 +M8hE/zF9aNf0vCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 26C491377F;
 Mon, 21 Nov 2022 09:41:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id fMYECLtHe2MkdAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 21 Nov 2022 09:41:15 +0000
Date: Mon, 21 Nov 2022 10:41:13 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Message-ID: <Y3tHuWygsBqmmpwV@pevik>
References: <20221107191136.18048-1-pvorel@suse.cz>
 <Y2l3vJb1y2Jynf50@google.com>
 <3ac740c0-954b-5e68-b413-0adc7bc5a2b5@suse.cz>
 <Y22b3wWs2QfMjJHi@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y22b3wWs2QfMjJHi@google.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
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
 Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>,
 linux-kselftest@vger.kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Sergey,

> On (22/11/10 15:29), Martin Doucha wrote:
> > New version of LTP test zram01 found a sysfile issue with zram devices
> > mounted using VFAT filesystem. When when all available space is filled, e.g.
> > by `dd if=/dev/zero of=/mnt/zram0/file`, the corresponding sysfile
> > /sys/block/zram0/mm_stat will report that the compressed data size on the
> > device is 0 and total memory usage is also 0. LTP test zram01 uses these
> > values to calculate compression ratio, which results in division by zero.

> > The issue is specific to PPC64LE architecture and the VFAT filesystem. No
> > other tested filesystem has this issue and I could not reproduce it on other
> > archs (s390 not tested). The issue appears randomly about every 3 test runs
> > on SLE-15SP2 and 15SP3 (kernel 5.3). It appears less frequently on SLE-12SP5
> > (kernel 4.12). Other SLE version were not tested with the new test version
> > yet. The previous version of the test did not check the VFAT filesystem on
> > zram devices.

> Whoooaa...

> > I've tried to debug the issue and collected some interesting data (all
> > values come from zram device with 25M size limit and zstd compression
> > algorithm):
> > - mm_stat values are correct after mkfs.vfat:
> > 65536      220    65536 26214400    65536        0        0        0

> > - mm_stat values stay correct after mount:
> > 65536      220    65536 26214400    65536        0        0        0

> > - the bug is triggered by filling the filesystem to capacity (using dd):
> > 4194304        0        0 26214400   327680       64        0        0

> Can you try using /dev/urandom for dd, not /dev/zero?
> Do you still see zeroes in sysfs output or some random values?

I'm not sure if Martin had time to rerun the test. I was not able to reproduce
the problem any more on machine where the test was failing. But I'll have look
into this during this week.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
