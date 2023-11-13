Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A25B4C4332F
	for <ltp@archiver.kernel.org>; Mon, 13 Nov 2023 09:38:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9BA273CE54C
	for <ltp@archiver.kernel.org>; Mon, 13 Nov 2023 10:38:57 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1A0DF3C2969
 for <ltp@lists.linux.it>; Mon, 13 Nov 2023 10:38:46 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C0101600648
 for <ltp@lists.linux.it>; Mon, 13 Nov 2023 10:38:45 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id AF6911F750
 for <ltp@lists.linux.it>; Mon, 13 Nov 2023 09:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1699868324;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YXfeW706mGO2DJERm1vP2tSv+vnR6q7xdNXmpL3VaRM=;
 b=m8ML929q7u+2giUVVusg2pIf2UfRLdTJriJwGXSiqiliqVOq4gYQzWVGIaJ3YgFv463Tie
 i/tNlKUj2EwdLllGDbEjVKkVl0SDHVxwTtmAPJZrAKd0BwZRBct0z0O0k2AVB8Jj6erUs3
 upI62OF9HnSi2HHMEUTpPwFcYUnfgds=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1699868324;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YXfeW706mGO2DJERm1vP2tSv+vnR6q7xdNXmpL3VaRM=;
 b=ypdf/sYd57zw2YYgWrWa16H5m9XdJaJRFDeE2Gsy0R6EyoqPaksHibohqyP5LKav92aUjZ
 22G9NiDPVzpGQpBw==
Received: from g78 (rpalethorpe.udp.ovpn1.prg.suse.de [10.100.228.202])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 5B6A32C5B4;
 Mon, 13 Nov 2023 09:38:44 +0000 (UTC)
References: <20230912144351.13494-1-mkittler@suse.de>
 <20230912144351.13494-2-mkittler@suse.de>
 <d57f969b-2b3c-4835-b9d0-b3b8f6b964e2@suse.com>
 <11689901.tHia2Qjv5r@linux-9lzf>
User-agent: mu4e 1.10.7; emacs 29.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Marius Kittler <mkittler@suse.de>
Date: Mon, 13 Nov 2023 09:31:36 +0000
Organization: Linux Private Site
In-reply-to: <11689901.tHia2Qjv5r@linux-9lzf>
Message-ID: <87h6lqat7g.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 1/2] Ensure prio is within valid range in
 `rt-migrate.c`
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

Marius Kittler <mkittler@suse.de> writes:

> Am Mittwoch, 13. September 2023, 11:11:42 CEST schrieb Andrea Cervesato:
>> Hi!
>> 
>>   I generally suggest to refactor test into new API if a structural
>> change is needed.
>
> That is why I refrained from a structural change and implemented the fix with 
> the minimum amount of change possible. This way the risk of introducing new 
> bugs should be very small and the low "hanging fruit" is grabbed.
>
>> I would suggest to take a look at the code a bit closer and to guess how
>> much effort we should put in order to rewrite it with new API.
>
> I guess it would be doable and if that's wanted I can do that as the next step 
> as a separate commit. Not sure how long it'll take me, maybe a couple of hours 
> or a day (since I'm still new to ltp). (There is no ticket asking about such a 
> refactoring explicitly so I honestly don't know whether it is wanted or 
> whether we should invest our time better elsewhere.)

I merged it and the fix looks good. Thanks!

I'm not sure it is worth applying little fixes to these tests without a
rewrite or investigating wether this test is a duplicate, but it's done
now.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
