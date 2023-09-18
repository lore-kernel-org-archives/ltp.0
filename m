Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 115ACC46CA1
	for <ltp@archiver.kernel.org>; Mon, 18 Sep 2023 09:24:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8827B3CE4D5
	for <ltp@archiver.kernel.org>; Mon, 18 Sep 2023 11:24:41 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5D5943CAA0F
 for <ltp@lists.linux.it>; Mon, 18 Sep 2023 11:24:31 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id BF5B560B2D8
 for <ltp@lists.linux.it>; Mon, 18 Sep 2023 11:24:30 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 4CAC21F892;
 Mon, 18 Sep 2023 09:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1695029070;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZPp/Fjd7bD8yNQ7DUsIEbnpxuFRqB6rqdQAwf4ejX+U=;
 b=O53o1JlcUJaQgzPllbrq2rg1CPv0oNGHss6T9nn/uiyK4OPSduYSIsEhxGo8PWa3C7/Ujp
 SRIWN/FHDJ+3I7wDyqXdUgoImFOeyS4hEELp0V0i1ELfq1qERi1NT+NhXWrja/dDCLeVZE
 rjGyBP3oTZSpNx8BqHTy8KmB+iVh/uA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1695029070;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZPp/Fjd7bD8yNQ7DUsIEbnpxuFRqB6rqdQAwf4ejX+U=;
 b=r0WA8pMTUfzdKdj3+2mqUri5xyPKVVq/XBnmou4i+hlwScwK7QioPF3xinhRKnil4jg0Wj
 +tx69J3usGkgm0BQ==
Received: from g78 (rpalethorpe.tcp.ovpn1.nue.suse.de [10.163.17.14])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id E59802C142;
 Mon, 18 Sep 2023 09:24:29 +0000 (UTC)
References: <20230808035641.364676-2-iwienand@redhat.com>
 <87il8xhr05.fsf@suse.de> <ZPlxtKUwOta4GYh2@fedora19.localdomain>
 <65af05ae-bfd1-8153-4662-1bf61be855f3@suse.cz>
 <ZPpOuK9lyWr2wZWI@fedora19.localdomain>
 <845ca8fe-1ae2-13ba-c9e0-a53cf953c0ff@suse.cz>
 <ZP+4xTgAuTBepQge@fedora19.localdomain> <87r0n2gip5.fsf@suse.de>
 <ZQI14xCNkc4wjpC2@fedora19.localdomain> <87msxpgmf4.fsf@suse.de>
 <ZQLowDHRBq8QhQwu@fedora19.localdomain>
User-agent: mu4e 1.10.7; emacs 29.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Ian Wienand <iwienand@redhat.com>
Date: Mon, 18 Sep 2023 09:24:47 +0100
Organization: Linux Private Site
In-reply-to: <ZQLowDHRBq8QhQwu@fedora19.localdomain>
Message-ID: <87edivhm0i.fsf@suse.de>
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

> On Thu, Sep 14, 2023 at 08:37:46AM +0100, Richard Palethorpe wrote:
>> We don't want to remove coverage of ZRAM_SAME! A bug in ZRAM_SAME is a
>> potential expoit or data-corruption.
>>
>> If you want to change the test you have to show where ZRAM_SAME is being
>> covered instead.
>
> The patch v2 has always had the comment and intent
>
> +	# To make sure we are actually testing both the same-page and
> +	# compression paths, we first pad with zeros but then fill
> +	# with a compressible series of alternatiting 0x00 and 0xFF.
> +	# This should assure we stress the compression path and can
> +	# calculate the compression level reliabily.
>
> I believe this tests both paths, and in a more rigorous manner than the
> extant test.
>
> -i

I did miss that, however it's actually more rigorous (read "complete")
to test these things seperately. Or even better to test them seperately
then together. Because if only writing out same-page's and a single page
with some meta-data in results in a bug, then your method would not find
that.

You're still swapping one type of coverage for another.

So I'm still in favor of accepting Petr's original patch and of course I
would welcome what you are proposing as additional coverage.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
