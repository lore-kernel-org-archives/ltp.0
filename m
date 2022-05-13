Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2599C433EF
	for <ltp@archiver.kernel.org>; Fri, 13 May 2022 09:05:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D6FB53CA9CB
	for <ltp@archiver.kernel.org>; Fri, 13 May 2022 11:05:37 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B2C9C3C1BCA
 for <ltp@lists.linux.it>; Fri, 13 May 2022 11:05:27 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 36FDF6001E1
 for <ltp@lists.linux.it>; Fri, 13 May 2022 11:05:26 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5AE3921AA4;
 Fri, 13 May 2022 09:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1652432726; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=p6IpurA2kKyi5YYCZnMlgNsFoiBUB6wgkbvzAqCleHo=;
 b=k2bjk1FvTsWHyO+nAuDDKDcnyRKC2Xp3Fnpy/59utws//9lu7yjHX3CYr7vXP/FYWk7okg
 e3kLriLfxfiW7xfi+Vdee449fSozDWgl87L+DdKb69ZlWlrXC2P/BSf2KaYGr4hXnOs12F
 7+Y97QwjpD9fO8NcAoL6nhHiiXhT8oI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1652432726;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=p6IpurA2kKyi5YYCZnMlgNsFoiBUB6wgkbvzAqCleHo=;
 b=96OAtSYlF815h/eyLmLZE9z0kW85Gb3LCo7xpB8UpucZOxlU2xYlnY2nhAQQi3GYxPSdog
 wwySPprUdruyryBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3C86413A84;
 Fri, 13 May 2022 09:05:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id EiOIC1YffmJ6cQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 13 May 2022 09:05:26 +0000
Date: Fri, 13 May 2022 11:07:40 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <Yn4f3HLBTJ/ehtyh@yuki>
References: <20220512131002.26093-1-chrubis@suse.cz>
 <CAEemH2dV04-F1mFHiCodQV+uWMbMWxEVy3hW+iqSv6zyJwjyMg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2dV04-F1mFHiCodQV+uWMbMWxEVy3hW+iqSv6zyJwjyMg@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] waitid10: raise SIGFPE directly
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Better to have code comments to explain the reason here,
> just for better readability.

What exactly should we comment there, something as:

Triggering SIGFPE by invalid instruction is not always possible, some
architectures does not trap division-by-zero at all and even when it's
possible we would have to fight the compiler optimizations that have
tendency to remove undefined operations.

> And vote for merging before the new release as well.

That's what I'm aiming for.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
