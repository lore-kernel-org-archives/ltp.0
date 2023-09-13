Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50EACCA5512
	for <ltp@archiver.kernel.org>; Wed, 13 Sep 2023 09:28:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 734023CB531
	for <ltp@archiver.kernel.org>; Wed, 13 Sep 2023 11:28:04 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5864C3C9947
 for <ltp@lists.linux.it>; Wed, 13 Sep 2023 11:27:53 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 4568814010E8
 for <ltp@lists.linux.it>; Wed, 13 Sep 2023 11:27:51 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 984831F385
 for <ltp@lists.linux.it>; Wed, 13 Sep 2023 09:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1694597271; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gjr3pMkXcKQdOYWU7UjzRw0knf2ho7eRxl6RMqwQYjA=;
 b=NnHwRXR885DkjxNddnApgXaNaPSYhvhTqcRieoilVinWOQNGBI9yuKlZZkie3qa7iNvtml
 KEDOs6n2MPMIo4Mio5t5YRRa3QPs6qxvH9ybZobbDhbynetoyLdMMrrzD1q/Ipj44EF1Go
 2pYlHbpTNeaclrixSSJbrdoUNsc+70w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1694597271;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gjr3pMkXcKQdOYWU7UjzRw0knf2ho7eRxl6RMqwQYjA=;
 b=RGZBGwK4YQoUJ/tILYsIrmhpHLRHJrm4tTMhqUm8Vlu/l/iFk5lIIjpcQWrTKYillU0HoP
 9VP9BiU8QPXKoVBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8AE7913582
 for <ltp@lists.linux.it>; Wed, 13 Sep 2023 09:27:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Ly45IZeAAWVlQwAAMHmgww
 (envelope-from <mkittler@suse.de>)
 for <ltp@lists.linux.it>; Wed, 13 Sep 2023 09:27:51 +0000
From: Marius Kittler <mkittler@suse.de>
To: ltp@lists.linux.it
Date: Wed, 13 Sep 2023 11:27:51 +0200
Message-ID: <11689901.tHia2Qjv5r@linux-9lzf>
In-Reply-To: <d57f969b-2b3c-4835-b9d0-b3b8f6b964e2@suse.com>
References: <20230912144351.13494-1-mkittler@suse.de>
 <20230912144351.13494-2-mkittler@suse.de>
 <d57f969b-2b3c-4835-b9d0-b3b8f6b964e2@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Am Mittwoch, 13. September 2023, 11:11:42 CEST schrieb Andrea Cervesato:
> Hi!
> 
>   I generally suggest to refactor test into new API if a structural
> change is needed.

That is why I refrained from a structural change and implemented the fix with 
the minimum amount of change possible. This way the risk of introducing new 
bugs should be very small and the low "hanging fruit" is grabbed.

> I would suggest to take a look at the code a bit closer and to guess how
> much effort we should put in order to rewrite it with new API.

I guess it would be doable and if that's wanted I can do that as the next step 
as a separate commit. Not sure how long it'll take me, maybe a couple of hours 
or a day (since I'm still new to ltp). (There is no ticket asking about such a 
refactoring explicitly so I honestly don't know whether it is wanted or 
whether we should invest our time better elsewhere.)




-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
