Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 733B5C38145
	for <ltp@archiver.kernel.org>; Wed,  7 Sep 2022 11:06:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 946A33CA9A2
	for <ltp@archiver.kernel.org>; Wed,  7 Sep 2022 13:05:58 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 114763CA6F8
 for <ltp@lists.linux.it>; Wed,  7 Sep 2022 13:05:48 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 4ADC11A00FB5
 for <ltp@lists.linux.it>; Wed,  7 Sep 2022 13:05:47 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0523E33CDF;
 Wed,  7 Sep 2022 11:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1662548747;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZCFvk9f9IbO0BZbFv8nXvZmNfu6TS91OpiCQVkcBjV0=;
 b=Z28eKqAnKtELIuTIs76m6LdvR60XI2XNnWHh0s6+/2q45kr1LuwMWyr2ari6IXAkI7YZsD
 0pcb0Y7zGR9Vv9vKi8h6ESdbAff1kYQBVHC+fNeS7hxZ90uutfGewlte7yf1FK7dD9+1aS
 z7aDxUBZYOQfMDFVcLqcLwakvyu+SJk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1662548747;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZCFvk9f9IbO0BZbFv8nXvZmNfu6TS91OpiCQVkcBjV0=;
 b=wPCOOqAu1GygzS3o+WpRovSWoCvKSNe7s1KwvkWuveCGC2ZUENedDsSMdNnKEw6PMMwCHR
 etjZz0i62qRwVFCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C934F13486;
 Wed,  7 Sep 2022 11:05:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Mt+kLwp7GGNJWQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 07 Sep 2022 11:05:46 +0000
Date: Wed, 7 Sep 2022 13:05:44 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Matthew Bobrowski <repnop@google.com>
Message-ID: <Yxh7CPmqHz2ybwr5@pevik>
References: <20220906092615.15116-1-pvorel@suse.cz>
 <YxhHJ9HaADTWzPpY@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YxhHJ9HaADTWzPpY@google.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/3] fanotify{14,20}: cleanup
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> On Tue, Sep 06, 2022 at 11:26:12AM +0200, Petr Vorel wrote:
> > Hi,

> > just an example how to further cleanup fanotify tests by using test macros
> > from include/tst_test_macros.h. This can wait till Amir's FAN_MARK_IGNORE
> > patchset [1] is merged (unless there is going to be v2).

> > fanotify20 is an example what I'd address in the code, fanotify14 just
> > uses newly added TST_EXP_FD_ERRNO() (more cleanup here and actually in
> > other tests could be done).

> So, are you suggesting that we have a TODO list? ;)
Well, I would not dare this :). Amir wrote he's planning to do some cleanup,
but if you kernel maintainers are busy, I can do it. We really appreciate how
well you maintain tests for your kernel subsystem (I wish there were more kernel
maintainers as active as you).

> > I also admit code in include/tst_test_macros.h is a bit hard to read due
> > being macro. We should probably add some documentation to it.

> Documentation is always nice. A lot of time could be saved as a result
> of not having to decipher a given macro.
It's on my TODO list, hopefully I'll do it soon.

Kind regards,
Petr

> /M

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
