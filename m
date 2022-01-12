Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4540C433EF
	for <ltp@archiver.kernel.org>; Wed, 12 Jan 2022 08:29:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 83F553C949B
	for <ltp@archiver.kernel.org>; Wed, 12 Jan 2022 09:29:49 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 978173C4EC5
 for <ltp@lists.linux.it>; Wed, 12 Jan 2022 09:29:39 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 1146620091E
 for <ltp@lists.linux.it>; Wed, 12 Jan 2022 09:29:38 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1D4F821637;
 Wed, 12 Jan 2022 08:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1641976178; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tiw11RY/GQ3XXnGfTwkv6l1ytqqoiDPIS34IHgY1lXc=;
 b=u/S/vuJrWJFMHiQdHLoqZSi8sFbTR0fnocMf2bhS//Sr3qWyype3pEwnTPxVXGwZJAR5Lx
 LjJ/yD7z+KIJRgZMeK/LZslGwoyK1L4A2xDqlW9iGxW5mE+YbQuY95RcvFnDLLF7z8MvEl
 lE9V4eW81tPKnh+5jFaVHMCBWQbfioc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1641976178;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tiw11RY/GQ3XXnGfTwkv6l1ytqqoiDPIS34IHgY1lXc=;
 b=gxOzblXrhzGzILC3Bj8vXPANryNm/rR5LONBPXTMPf7l6aYTWIpZu9+wLratxf+3LcUtIC
 vgwJraEv2q+c43Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 082FE13B2D;
 Wed, 12 Jan 2022 08:29:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id siQqAXKR3mE1KwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 12 Jan 2022 08:29:38 +0000
Date: Wed, 12 Jan 2022 09:31:13 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Message-ID: <Yd6R0Th45Y1NLqTN@yuki>
References: <YY0o7jAxgIHvmczq@yuki>
 <1639380414-24390-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1639380414-24390-5-git-send-email-xuyang2018.jy@fujitsu.com>
 <YdhhTeot7Z9861B0@yuki> <61DBD6D0.1000104@fujitsu.com>
 <YdxGrO40TwVJmeWG@yuki> <61DD2937.6060609@fujitsu.com>
 <Yd1iOp2I5LrJtJDz@yuki> <61DE34A9.8010000@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <61DE34A9.8010000@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 5/6] syscalls/quotactl09: Test error when quota
 info hidden in filesystem
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > Ah, that's what I have missed. But still, what happen if we pass fd to a
> > regular file to the quotactl_fd()? Shouldn't we test that case too?
> Good suggestion.
> Yes, AFAIK, the fd point to superblock, every subcmd will check quota 
> feature bit or whether enable but return different errno.
> 
> I will test Q_QUOTAON with regular file fd because it is the most 
> meaningful.

And we can always try to pass a fd pointing to a socket, that shouldn't
be associated with any block device at all.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
