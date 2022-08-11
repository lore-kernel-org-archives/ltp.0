Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 874F9C19F2A
	for <ltp@archiver.kernel.org>; Thu, 11 Aug 2022 11:41:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 73E293C958E
	for <ltp@archiver.kernel.org>; Thu, 11 Aug 2022 13:41:31 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7B9303C0294
 for <ltp@lists.linux.it>; Thu, 11 Aug 2022 13:41:21 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id CC0B1200B6B
 for <ltp@lists.linux.it>; Thu, 11 Aug 2022 13:41:20 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CC3B322242;
 Thu, 11 Aug 2022 11:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1660217955; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rH6QaVrBSCHfPEO5XNT6WK4/x5yvXmadvkqPVEsTueg=;
 b=nZ7OwdlKMLgOrLvMTJIyNNgBCZNwSxYq+IdGYFZRuQm3ZlGhjLf006WDDdfD3b+cnygLuf
 lPw7d1hJos99C2p1FLAOu7VHqIz9PYoPnYinkzFRDkEDbPQPv3fVUMVzccz/ny3lb4/O1e
 +en0XvULEuU2cYHZK3gUtWjeQBaZPGE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1660217955;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rH6QaVrBSCHfPEO5XNT6WK4/x5yvXmadvkqPVEsTueg=;
 b=mn3OE0kktLcLXKL21+ktrM4s77AUhx4fJmddjzIIXKDFqgFijx1Mnt+4y7S9NAsIanTILM
 r0spmUVIU1KDXQAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B37031342A;
 Thu, 11 Aug 2022 11:39:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id pU93KmPq9GKPLwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 11 Aug 2022 11:39:15 +0000
Date: Thu, 11 Aug 2022 13:41:06 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Dylan Jhong <dylan@andestech.com>
Message-ID: <YvTq0qDxxFTarRbi@yuki>
References: <20220809082701.2366582-1-dylan@andestech.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220809082701.2366582-1-dylan@andestech.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] pan/ltp-pan.c: Add execution time field in
 results/logs
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
Cc: randolph@andestech.com, x5710999x@gmail.com, dminus@andestech.com,
 alankao@andestech.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> The current log only shows the success or failure of testcases, but
> execution time is also one of the important indicators to observe LTP
> testcases.
> 
> In this patch, we modified the format of the logs in results/ and added
> a column to record the execution time.

I think that there are at least two reasons not to apply this patch:

1. The ltp-pan is in maintenance mode only and is going to be replaced
   by a different solution that is way more powerful [1]

2. There are likely automated tools parsing the ltp-pan logfiles that
   may get broken by this

[1] https://lists.linux.it/pipermail/ltp/2022-August/029933.html

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
