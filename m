Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F03DC433F5
	for <ltp@archiver.kernel.org>; Thu, 20 Jan 2022 12:16:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8E2CE3C96AE
	for <ltp@archiver.kernel.org>; Thu, 20 Jan 2022 13:16:55 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7E4DD3C87FE
 for <ltp@lists.linux.it>; Thu, 20 Jan 2022 13:16:45 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id DE7711000DC7
 for <ltp@lists.linux.it>; Thu, 20 Jan 2022 13:16:44 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EF53B1F3A9;
 Thu, 20 Jan 2022 12:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1642681003;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4hz+M81CBkA4L70jtMLxAkCdYjdeT4Uf1tS1zHvt07U=;
 b=pZtPVKH3ucxbFFHSQdauDwPbeJ6rYkOHQkgGKIlZqT8BYjFXEUCxOwFXPIZHh4tJwxXQeg
 KLavu74RFoJlHSwHkCTOnWFjZcUKSyqw68Z8rkbMU7ncUzp0vii0Q34CulIBdtxv3oRNLn
 PLWm1tuTaYG0tMwSGYSVfWx3ne9h+Fg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1642681003;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4hz+M81CBkA4L70jtMLxAkCdYjdeT4Uf1tS1zHvt07U=;
 b=29KW8KTG+y2fqKyUgPzF0pqEP7Oy14r0800ohW2vAcKduu0V0CpkL1qV/6BDLCTrWlFqx7
 HQIXhhor2/Jh9lDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D058E13B51;
 Thu, 20 Jan 2022 12:16:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id zMMkMatS6WHfWQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 20 Jan 2022 12:16:43 +0000
Date: Thu, 20 Jan 2022 13:16:42 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <YelSqq5cG6JHFtyh@pevik>
References: <20220119152732.21189-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220119152732.21189-1-andrea.cervesato@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Replace ltp_syscall with tst_syscall
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea,

> This modification is a first step into the old LTP API replacement and
> it has been completed with the following procedure:
> - removed ltp_syscall
> - replaced ltp_syscall with tst_syscall inside all tests
> - reshuffled headers inside tests to import tst_test.h before
>   lapi/syscalls.h
So far we've done cleanup as whole test one by one.
Sure, why not solving one issue once.

Generally LGTM. I'd just appreciate if tst_test.h didn't have to be loaded at
first, but that's a minor issue.

also with these whole tree patches it's a problem that it either breaks some of
other patches (they will not be applicable) or this patch will not be applicable
(if not applied soon after the release).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
