Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FC52C4332F
	for <ltp@archiver.kernel.org>; Tue, 20 Dec 2022 13:22:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 012C93CBAA2
	for <ltp@archiver.kernel.org>; Tue, 20 Dec 2022 14:22:24 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 79D4F3CBA68
 for <ltp@lists.linux.it>; Tue, 20 Dec 2022 14:22:15 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id DA0F4600745
 for <ltp@lists.linux.it>; Tue, 20 Dec 2022 14:22:14 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 40B743FBFA
 for <ltp@lists.linux.it>; Tue, 20 Dec 2022 13:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1671542534;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qqceK5I3euHrJrKekV74U7rMaw3l/+avz+QY1ZFyuwk=;
 b=GOHyQ2XP7vTF4ZPog14NAXKu8DMxG5mzdWIUMUP9o7L6Ar/H9rVRP2ZVu0UDJtqPLvTAhM
 8F17nftTqRC6PrJsITzEehX93GA1fllxTUR2wXnmfBHhRaCcA077SOXN0Gm9fIpE5moLGI
 7E1pwKVOO1zHoxImFk39XphQ+oY9I5A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1671542534;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qqceK5I3euHrJrKekV74U7rMaw3l/+avz+QY1ZFyuwk=;
 b=QNd2r0+4czDnvIpTJx1MsPAGuzehDpqAIX1EqPcvx2qV+4GK9/DtzzCPnZauVCWB6fzfLv
 MgUu8HUFcHeBYXAA==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 1467C2C141;
 Tue, 20 Dec 2022 13:22:14 +0000 (UTC)
References: <20221216115052.30511-1-pvorel@suse.cz> <Y5xt5K1HWp8lHau8@pevik>
User-agent: mu4e 1.8.13; emacs 28.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Tue, 20 Dec 2022 13:19:10 +0000
Organization: Linux Private Site
In-reply-to: <Y5xt5K1HWp8lHau8@pevik>
Message-ID: <871qoutdks.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] aiocp.c: TCONF on O_DIRECT on tmpfs
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
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Petr Vorel <pvorel@suse.cz> writes:

> Hi,
>
> hm, it looks like it requires to skip tmpfs, as all tests TCONF:
> aiocp.c:231: TINFO: Maximum AIO blocks: 65536
> tst_device.c:541: TINFO: Use BTRFS specific strategy
> tst_device.c:559: TBROK: BTRFS ioctl failed. Is . on a tmpfs?: ENOTTY (25)
>
> I check if it'd work without
> e1b1ae66b2 ("tst_find_backing_dev: Get dev name from /sys/dev/block/*/uevent")
>
> Kind regards,
> Petr

tmpfs is not backed by a block device so there is no block size. Unless
we treat the page size as the block size. So possibly tst_dev_block_size
should return the page size.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
