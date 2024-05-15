Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D34FC25B75
	for <ltp@archiver.kernel.org>; Wed, 15 May 2024 07:30:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D3F5D3CF38E
	for <ltp@archiver.kernel.org>; Wed, 15 May 2024 09:30:42 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4D0193CC481
 for <ltp@lists.linux.it>; Wed, 15 May 2024 09:30:27 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A7BC21006092
 for <ltp@lists.linux.it>; Wed, 15 May 2024 09:30:26 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AAB562033E;
 Wed, 15 May 2024 07:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715758225;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/SF8R/ivagzYUeqe8Wl8Q5efyprchX5HdQ7xK+L6LKw=;
 b=OZ5mJ7fAsUYow6/EYWAn7dewkmdbTFWhJEuSgOR36TNSFlTWqrwphWrLqd01y1VKFGGheD
 lana/wcf1nFdyJ+XpB+40sZdTMGkD32EORggoYzH5vBjj1dZdk4KQhqIOWIFNzBjUa5nse
 2/4iPija9B3twQmHVUQUFyIa6iS7yN0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715758225;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/SF8R/ivagzYUeqe8Wl8Q5efyprchX5HdQ7xK+L6LKw=;
 b=sj1lTslECp9JXLgqtjH5IzzlDbr6WVMoK/9mt0pBd9nPCYfXoTMY3LXoGG7+MuC1k8xAoP
 +HyvKMkRWLcYNzAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715758225;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/SF8R/ivagzYUeqe8Wl8Q5efyprchX5HdQ7xK+L6LKw=;
 b=OZ5mJ7fAsUYow6/EYWAn7dewkmdbTFWhJEuSgOR36TNSFlTWqrwphWrLqd01y1VKFGGheD
 lana/wcf1nFdyJ+XpB+40sZdTMGkD32EORggoYzH5vBjj1dZdk4KQhqIOWIFNzBjUa5nse
 2/4iPija9B3twQmHVUQUFyIa6iS7yN0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715758225;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/SF8R/ivagzYUeqe8Wl8Q5efyprchX5HdQ7xK+L6LKw=;
 b=sj1lTslECp9JXLgqtjH5IzzlDbr6WVMoK/9mt0pBd9nPCYfXoTMY3LXoGG7+MuC1k8xAoP
 +HyvKMkRWLcYNzAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7A5841372E;
 Wed, 15 May 2024 07:30:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id FfjJHJFkRGahKQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 15 May 2024 07:30:25 +0000
Date: Wed, 15 May 2024 09:30:23 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>,
 Hui Min Mina Chou <minachou@andestech.com>, ltp@lists.linux.it,
 tim609@andestech.com, cynthia@andestech.com
Message-ID: <20240515073023.GA200917@pevik>
References: <20240328083344.277502-1-minachou@andestech.com>
 <20240510153103.GA448405@pevik> <ZkI0L9xkrsJ-mhPN@yuki>
 <20240515072120.GB197249@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240515072120.GB197249@pevik>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]; 
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_TWO(0.00)[2];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/setitimer: Pass the kernel-defined
 struct __kernel_old_itimerval to sys_setitimer().
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

> Hi all,

...
> > Also we should really add tests for the libc wrapper as well, since that
> > is actually more likely to get broken by the double conversion on 32bit
> > arch, but that should be done in an subsequent patches.

> +1. Adding .test_variants with {g,s}etitimer() for {g,s}etitimer0[12].c should
> be trivial. Or did you mean to have test variants also for other functions in
> include/tst_timer.h (e.g. timerfd_{g,s}ettime()) ?

timerfd_{g,s}ettime() (and other functions) test raw syscall with variants for
64bit and the old 32bit. These tests (in testcases/kernel/syscalls/timerfd) are
already quite complicated. I'm not sure if it's a good idea to add also
timerfd_{g,s}ettime() wrappers. But they should be covered as well, right?

> BTW we already test {g,s}etitimer() libc wrapper in getitimer01.c, therefore we
> already have libc wrapper at least somehow covered (the other two test raw
> syscall).

And we of course test {g,s}etitimer() libc wrappers in open posix testsuite.

Kind regards,
Petr

> Once we agree what to do I'll either post a patch or add a ticket for it (or
> feel free to add a ticket yourself).
...

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
