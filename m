Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60D7EEDE998
	for <ltp@archiver.kernel.org>; Thu, 14 Sep 2023 09:00:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 84BB43CE733
	for <ltp@archiver.kernel.org>; Thu, 14 Sep 2023 10:59:59 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B08A13CB291
 for <ltp@lists.linux.it>; Thu, 14 Sep 2023 10:59:48 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 67341602BAC
 for <ltp@lists.linux.it>; Thu, 14 Sep 2023 10:59:46 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 13D1C21887;
 Thu, 14 Sep 2023 08:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1694681985;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xar5aASVzItjmU+UQHARuSaIZLKjh5MYNpT5TQn7dq4=;
 b=pT7JCGFZz/UDTFty9bAyZneQvsn2yuWo4NUcQrCx/3L6MNyFjmCKs2sKUzq+c4nE2PQrKD
 skEzs3D0YAiZP5cZN35nacsK9Zv5dTbhMBmo9I7IjfAWhTlbDZJ33NwTmCyrqAE5CwbkUY
 lpD/Gp2weGJW+c92Q0VltRM52Ip857o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1694681985;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xar5aASVzItjmU+UQHARuSaIZLKjh5MYNpT5TQn7dq4=;
 b=C/t8LfLgEIvYaDSWfp9t3Y5FToMMlSkt403b82BUaOb/eNdCiN3pY1yeV9eTeoma1Cf75l
 QDwW84k2lqHlxkBg==
Received: from g78 (rpalethorpe.tcp.ovpn1.nue.suse.de [10.163.17.14])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id B40F52C142;
 Thu, 14 Sep 2023 08:59:44 +0000 (UTC)
References: <20230803015149.69906-1-iwienand@redhat.com>
 <20230808035641.364676-2-iwienand@redhat.com> <87il8xhr05.fsf@suse.de>
 <ZPlxtKUwOta4GYh2@fedora19.localdomain>
 <65af05ae-bfd1-8153-4662-1bf61be855f3@suse.cz>
 <ZPpOuK9lyWr2wZWI@fedora19.localdomain>
 <845ca8fe-1ae2-13ba-c9e0-a53cf953c0ff@suse.cz>
 <ZP+4xTgAuTBepQge@fedora19.localdomain> <87r0n2gip5.fsf@suse.de>
 <ZQI14xCNkc4wjpC2@fedora19.localdomain>
User-agent: mu4e 1.10.7; emacs 29.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Ian Wienand <iwienand@redhat.com>
Date: Thu, 14 Sep 2023 08:37:46 +0100
Organization: Linux Private Site
In-reply-to: <ZQI14xCNkc4wjpC2@fedora19.localdomain>
Message-ID: <87msxpgmf4.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] kernel/device-drivers/zram/zram01.sh : don't
 fill from /dev/zero
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

Ian Wienand <iwienand@redhat.com> writes:

> On Wed, Sep 13, 2023 at 03:35:18PM +0100, Richard Palethorpe wrote:
>> I would suggest just using sync, but Petr originally suggested using a
>> wait loop. Then reported that the bug was still reproducible with the
>> loop:
>> 
>> https://lore.kernel.org/linux-block/Y3s+Czg8sBsGYO+1@pevik/
>> 
>> Then said it wasn't reproducible. The problem is that if using a loop
>> doesn't solve it then possibly the VFAT meta-data doesn't get written to
>> disk in the absence of any pressure.
>> 
>> So instead I'd suggest resurrecting Petr's original patch or at least
>> his approach. If we merge that and still see failures then maybe it's
>> worth investigating more with tracing/debugging.
>
> I do not think the original patch [1] is the correct solution in light
> of the further investigation that has happened after it was proposed.
>
> [2] is about the clearest explaination I can come up with, other than
> the patch description and comments added in the v2 patch [3].  I am of
> the opinion that to be useful these tests need to explicitly make sure
> they are not just writing data that can be de-duplicated.  I do not
> believe the the intent of these tests was to have the only data
> managed by the disk a very small amount of file-system metadata.
>
> Sorry to sound like a broken record, but I spent some time
> investigating the paths taken with [2] and confirming the stats that
> were coming out were not due to some kernel issue, but it really was
> that the backing area had no pages allocated to it at all.
>
> Looping on a sync might make the test pass in more cases, but I hope
> we can agree the idea is to make the test better, not just pass so we
> can continue to ignore it.

We don't want to remove coverage of ZRAM_SAME! A bug in ZRAM_SAME is a
potential expoit or data-corruption.

If you want to change the test you have to show where ZRAM_SAME is being
covered instead.

It's not that I think ZRAM_SAME is any more or less important than the
true compression path. It's that if we never allow coverage to be
swapped out or removed, then we systematically increase coverage.

>
> -i
>
> [1] https://lore.kernel.org/linux-block/20221107191136.18048-2-pvorel@suse.cz/
> [2] https://lore.kernel.org/linux-block/ZNB2kORYiKdl3vSq@fedora19.localdomain/
> [3] https://lore.kernel.org/ltp/ZPpOuK9lyWr2wZWI@fedora19.localdomain/T/#m1e037003252012ac115e57285a926db77380897f


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
