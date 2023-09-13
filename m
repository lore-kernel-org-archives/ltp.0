Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 151C2EDEC7C
	for <ltp@archiver.kernel.org>; Wed, 13 Sep 2023 16:08:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 847A63CE796
	for <ltp@archiver.kernel.org>; Wed, 13 Sep 2023 18:08:06 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8C14B3CB33E
 for <ltp@lists.linux.it>; Wed, 13 Sep 2023 18:07:55 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C68EF603449
 for <ltp@lists.linux.it>; Wed, 13 Sep 2023 18:07:54 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 34D1A1F383;
 Wed, 13 Sep 2023 16:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1694621274;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KTbZ0H/gziT8rsL5P46tAqk1CPXvOXlcQKmk+h2CCYg=;
 b=kajpQITOuOUrsphLL3gqgaKoLgiLsr8J5mlgwnWlkxUKVyccrU4vU0Paxcn4wYeF/yuI0o
 AH3IJW7AUCUYITIPxONKJWy57e30bOE3FqNwo3VeWDdlPRmNfzVJxD70oBnr9nqca/uZbs
 pOjyBytAnTlLa7gq5Xdh1MNsH+Yf6GY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1694621274;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KTbZ0H/gziT8rsL5P46tAqk1CPXvOXlcQKmk+h2CCYg=;
 b=YhctC4K7siLfkJXUrlc4kQcRJGi3veD5/HEKYdfpJAu5xiHdyFC0iuD2vohsfhuaNmmK+G
 WvuagdbJzWmLHfAQ==
Received: from g78 (rpalethorpe.tcp.ovpn1.nue.suse.de [10.163.17.14])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 2D9FD2C142;
 Wed, 13 Sep 2023 16:07:53 +0000 (UTC)
References: <20230803015149.69906-1-iwienand@redhat.com>
 <20230808035641.364676-2-iwienand@redhat.com> <87il8xhr05.fsf@suse.de>
 <ZPlxtKUwOta4GYh2@fedora19.localdomain>
 <65af05ae-bfd1-8153-4662-1bf61be855f3@suse.cz>
 <ZPpOuK9lyWr2wZWI@fedora19.localdomain>
 <845ca8fe-1ae2-13ba-c9e0-a53cf953c0ff@suse.cz>
 <ZP+4xTgAuTBepQge@fedora19.localdomain>
User-agent: mu4e 1.10.7; emacs 29.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Ian Wienand <iwienand@redhat.com>
Date: Wed, 13 Sep 2023 15:35:18 +0100
Organization: Linux Private Site
In-reply-to: <ZP+4xTgAuTBepQge@fedora19.localdomain>
Message-ID: <87r0n2gip5.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
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

> On Fri, Sep 08, 2023 at 11:21:47AM +0200, Martin Doucha wrote:
>> On 08. 09. 23 0:29, Ian Wienand wrote:
>> > I don't think this is the correct way to deal with it.  I think that
>> > you're probably referring to earlier mail where there was a suggestion
>> > that this was a ppc64/vfat specific issue [1].  I was seeing this in a
>> > different context, and I believe the zeros are explained by no data
>> > actually being in the compressed buffers, as explained at [2].  Hence
>> > I think we need to come to some conclusion on actually writing data
>> > during testing.
>> 
>> Well then, did you see the failure on any other filesystem than vfat? I've
>> read this whole e-mail thread again but there is no mention of which
>> filesystems trigger this issue.
>> 
>
> I see this on vfat; the test stops after the failure.  But I think
> focusing on the file-system is a red-herring in this case.  As
> explained at [1] I think the problem is more that there's insufficient
> data written due to the de-deuplication.  This probably exhibits most
> easily on vfat if it's not doing something like writing superblocks in
> other areas of the disk, etc.
>
>> Alternatively, if kernel developers say that the caching behavior in zram is
>> correct, then your v1 patch (adding sync) is the right solution.
>
> I think this explains why it is the test, not the kernel behaviour,
> that is causing the failure.
>
> -i
>
> [1] https://lore.kernel.org/linux-block/ZNB2kORYiKdl3vSq@fedora19.localdomain/#t

I would suggest just using sync, but Petr originally suggested using a
wait loop. Then reported that the bug was still reproducible with the
loop:

https://lore.kernel.org/linux-block/Y3s+Czg8sBsGYO+1@pevik/

Then said it wasn't reproducible. The problem is that if using a loop
doesn't solve it then possibly the VFAT meta-data doesn't get written to
disk in the absence of any pressure.

So instead I'd suggest resurrecting Petr's original patch or at least
his approach. If we merge that and still see failures then maybe it's
worth investigating more with tracing/debugging.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
