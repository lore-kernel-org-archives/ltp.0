Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5887C433EF
	for <ltp@archiver.kernel.org>; Tue, 22 Feb 2022 14:53:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1ACF93CA1B3
	for <ltp@archiver.kernel.org>; Tue, 22 Feb 2022 15:53:23 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8C8313CA19F
 for <ltp@lists.linux.it>; Tue, 22 Feb 2022 15:53:14 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id EA0661A00115
 for <ltp@lists.linux.it>; Tue, 22 Feb 2022 15:53:13 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3BA3521136;
 Tue, 22 Feb 2022 14:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1645541593; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mVpqhwtH7S0LKQtIbXirypMTQhmH6GFBzUzAqa7eTkA=;
 b=B1mrs9EJy0f/jRInw/OBaqiO7RtQv4Dh7Bbcqq4wcX1eQyv1tPnmYLgesZaZ1ZKWd+AQCY
 JdoJ/GiipdwIXKgNGaTC3uSK/Jn+28V5Qwa3j91sTSyuyOHIwKMQEc0K57o94VhI1MU09Q
 VA+oQQ387deba4N3aw0exYfqjKJ7eig=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2B5EB13BC2;
 Tue, 22 Feb 2022 14:53:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id iI0LCtn4FGLYEAAAMHmgww
 (envelope-from <mkoutny@suse.com>); Tue, 22 Feb 2022 14:53:13 +0000
Date: Tue, 22 Feb 2022 15:53:11 +0100
To: Richard Palethorpe <rpalethorpe@suse.com>
Message-ID: <20220222145311.GB12037@blackbody.suse.cz>
References: <20220222124547.14396-1-rpalethorpe@suse.com>
 <20220222124547.14396-2-rpalethorpe@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220222124547.14396-2-rpalethorpe@suse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/2] API/cgroup: Expose memory_recursiveprot V2
 mount opt
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
From: =?utf-8?q?Michal_Koutn=C3=BD_via_ltp?= <ltp@lists.linux.it>
Reply-To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, Feb 22, 2022 at 12:45:46PM +0000, Richard Palethorpe <rpalethorpe@suse.com> wrote:
> This changes the effect of trunk nodes' memory.low and memory.min on
> their leaf nodes. So we need to change the expectations of some tests.

How much are LTP runs striving to not affect environment?
IIRC, the memory_recursiveprot is "remountable"; in the long-term it's
likely worth watching the memory_recursiveprot behavior only.

I.e. instead of carrying two sets of expectations you can warp the
environment for the set that's more likely.

Michal


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
