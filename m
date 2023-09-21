Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0761BE706FC
	for <ltp@archiver.kernel.org>; Thu, 21 Sep 2023 09:36:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 58E213CDE9B
	for <ltp@archiver.kernel.org>; Thu, 21 Sep 2023 11:36:49 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EB6533CA21C
 for <ltp@lists.linux.it>; Thu, 21 Sep 2023 11:36:38 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id CB2361401226
 for <ltp@lists.linux.it>; Thu, 21 Sep 2023 11:36:37 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 30C3D1FE3E;
 Thu, 21 Sep 2023 09:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1695288997;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LVsQIzG+SFDBy6t8rD7Hs+PbRPNFjpjqmmSU2GxBwzo=;
 b=kcsQedM20ccwUgkTq9OO/yaE2P9BH3sQDH1mkxGutWcFGW4M+KQANZlL+TnyeGTX2MdB+g
 JzLNpYcXGtbUOBqew6q/bFUH6mfGuYTzfCK1B6bZ3qCja2tv91eoFlpJCpsCWbT2j1jjm7
 Ey32EfGvg1KI0YBiSK/PTDD7hCT2ObM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1695288997;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LVsQIzG+SFDBy6t8rD7Hs+PbRPNFjpjqmmSU2GxBwzo=;
 b=vnul6PA4CDzvrk5aUULShTemGkGN3Hfvwgwf0qFPdlQT9/wAs5ZY9gGUwynWwP0HKHTHZq
 /jcOZLhuYEzQhACA==
Received: from g78 (rpalethorpe.tcp.ovpn1.nue.suse.de [10.163.17.14])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 9190A2C142;
 Thu, 21 Sep 2023 09:36:36 +0000 (UTC)
References: <ZPlxtKUwOta4GYh2@fedora19.localdomain>
 <65af05ae-bfd1-8153-4662-1bf61be855f3@suse.cz>
 <ZPpOuK9lyWr2wZWI@fedora19.localdomain>
 <845ca8fe-1ae2-13ba-c9e0-a53cf953c0ff@suse.cz>
 <ZP+4xTgAuTBepQge@fedora19.localdomain> <87r0n2gip5.fsf@suse.de>
 <ZQI14xCNkc4wjpC2@fedora19.localdomain> <87msxpgmf4.fsf@suse.de>
 <ZQLowDHRBq8QhQwu@fedora19.localdomain> <87edivhm0i.fsf@suse.de>
 <ZQuZrkayZ+04bC2f@fedora19.localdomain>
User-agent: mu4e 1.10.7; emacs 29.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Ian Wienand <iwienand@redhat.com>
Date: Thu, 21 Sep 2023 10:34:16 +0100
Organization: Linux Private Site
In-reply-to: <ZQuZrkayZ+04bC2f@fedora19.localdomain>
Message-ID: <877cojg95o.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
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

> On Mon, Sep 18, 2023 at 09:24:47AM +0100, Richard Palethorpe wrote:
>> I did miss that, however it's actually more rigorous (read "complete")
>> to test these things seperately. Or even better to test them seperately
>> then together. Because if only writing out same-page's and a single page
>> with some meta-data in results in a bug, then your method would not find
>> that.
>
> I've just posted v3 [1] that separates out the two testing paths which
> I hope addresses these concerns.

Great! please note that in the mean time I merged Petr's patch. So you
may need to rebase. I haven't looked at it yet due to the upcoming
release.

>
> Thanks
>
> -i
>
> [1] https://lore.kernel.org/ltp/ZQuYiFMOSq1tMTBs@fedora19.localdomain/T/#u


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
