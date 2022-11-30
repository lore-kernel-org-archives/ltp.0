Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06D8CC4332F
	for <ltp@archiver.kernel.org>; Wed, 30 Nov 2022 13:14:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2DDB73CC516
	for <ltp@archiver.kernel.org>; Wed, 30 Nov 2022 14:13:59 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F247E3CC504
 for <ltp@lists.linux.it>; Wed, 30 Nov 2022 14:13:49 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 694EB6008EC
 for <ltp@lists.linux.it>; Wed, 30 Nov 2022 14:13:49 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7F78021AE3;
 Wed, 30 Nov 2022 13:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1669814028; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QMqIMLvz3+1l+FhDkrIpIZ34xCRF5AmmrJ0G8Ay79b4=;
 b=BkGqteraa4cRVx9Vit1biRWt74Nhuj9vNZQEZ5mWsu2OiL42FsKicZUsdRjBdhwKIIuaSe
 nMSuROLcaXc3l6z3Q1g455lcUO4f4NFwysxtanxqSyB+0K1V5elcEtrFOsYih0jB4rdnkK
 AGd3MVoOC1mdPhcjJ2X0fM13kasaF1k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1669814028;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QMqIMLvz3+1l+FhDkrIpIZ34xCRF5AmmrJ0G8Ay79b4=;
 b=B5r6ClmS0SNnC2EROWKNHAisnmzJ1wzPmX0JUSYJ7wlz5TyZB8N2gKyHJiFqvjLSwyvygq
 ojmRzC6HDPJu11BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3E66F1331F;
 Wed, 30 Nov 2022 13:13:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id b4SVCAxXh2PZVgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 30 Nov 2022 13:13:48 +0000
Date: Wed, 30 Nov 2022 14:15:06 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Teo Couprie Diaz <teo.coupriediaz@arm.com>
Message-ID: <Y4dXWopbsqbyDZMF@yuki>
References: <20221128091508.75414-1-teo.coupriediaz@arm.com>
 <Y4UMUqkLijWXOWu6@pevik> <Y4YEnmDLD7AEMHrr@yuki>
 <Y4YK6uhK94C0vrVR@pevik> <Y4YLvhQfIW1SW1XB@yuki>
 <448cb776-770d-3235-c0d9-3c9005663790@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <448cb776-770d-3235-c0d9-3c9005663790@arm.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 0/1] brk: use direct syscalls
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> >> WDYT about .test_variants? In that case it'd be tested also on musl
> >> or any platform where it's implemented.
> > I would got for it, that way we would test both the kernel implemntation
> > and that libc does something sensible, e.g. returns error.
> >
> I'm still quite new to LTP, so I might be understanding things wrong.
> 
> My understanding of your conversation is that you're suggesting using 
> the .test_variants to have one version of the tests going through the 
> libc wrappers as usual, eventually skipping the test with TCONF if the 
> libc wrapper does not implement the syscall, and one version which would 
> be the the direct syscall I am suggesting in this patch.
> 
> Would that be correct ? If so it does make sense to me, I could try 
> implementing that.

Yes, exactly this.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
