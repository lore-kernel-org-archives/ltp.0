Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DC21C433F5
	for <ltp@archiver.kernel.org>; Wed, 22 Dec 2021 09:30:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8C9F93C9262
	for <ltp@archiver.kernel.org>; Wed, 22 Dec 2021 10:29:58 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7FA2E3C0B90
 for <ltp@lists.linux.it>; Wed, 22 Dec 2021 10:29:49 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D130B200AD9
 for <ltp@lists.linux.it>; Wed, 22 Dec 2021 10:29:48 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E921E1F384;
 Wed, 22 Dec 2021 09:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1640165387;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xpBZliC/cTte7Qf5XUgchu+0l4ubgyZrkVcK2w3c3q0=;
 b=Py9Nh9rjGiGkCFCCD0PEw+bDxLS4Q2pggptBoC+AoNw4CfnT9ibQkEf9o8vjqVEmSrmg16
 AgvMXIJC+iWKG+p+rO3h9fDNfQlW3aOC0W3at+ipMMIwWa7EnylEn4naJu1JCpdK/jkRPF
 ppLtz8NxSnWJk6Td92l7C61B9gOpwz0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1640165387;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xpBZliC/cTte7Qf5XUgchu+0l4ubgyZrkVcK2w3c3q0=;
 b=EJZzO/Mt+DABYdSnxWN6au5Hphwb3NV0vYbA1VPFZU7HswWL/Q6EflMuHeRGXNbM2Lxm0t
 qq2k/qFxli8vBmAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A682913CE7;
 Wed, 22 Dec 2021 09:29:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id rSnOJgvwwmE2XQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 22 Dec 2021 09:29:47 +0000
Date: Wed, 22 Dec 2021 10:29:46 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Jan Stancek <jstancek@redhat.com>
Message-ID: <YcLwChC5sOagOnIW@pevik>
References: <20211220180748.36A90A3B8E@relay2.suse.de>
 <20211221113042.21357-1-rpalethorpe@suse.com>
 <YcIVPdcjt8javBGv@pevik>
 <CAASaF6zQK=w5+QzUGM8wfOLJNUHFKPJP5dE_XnQUaya5if3VMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAASaF6zQK=w5+QzUGM8wfOLJNUHFKPJP5dE_XnQUaya5if3VMQ@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH] API: Allow testing of kernel features in
 development
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, LTP List <ltp@lists.linux.it>,
 automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Jan, all,

> > ....
> > > +++ b/runtest/syscalls-unstable
> > How about having name syscalls-next? Although there can be tests which are from
> > some kernel maintainer tree (it does not have to be limited to next tree),
> > unstable can mean "tests which aren't fixed yet and thus buggy".

> staging?
IMHO better than unstable, just staging is in kernel for not yet ready drivers
which need to cleanup, thus it could be confusing similar way as unstable.

But this should be ok, we document the purpose.

> IMO separate runtest would be enough, any notes why and how test was developed
> could be in comments in code, where people can find it (less metadata
> to maintain),
> and those comments could stay there after feature is accepted to
> mainline, we just
> move test between runtest files.

+1, actually the simplest solution.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
