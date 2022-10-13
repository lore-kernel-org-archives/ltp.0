Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66EE2C433FE
	for <ltp@archiver.kernel.org>; Thu, 13 Oct 2022 09:13:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4D8A03CAED6
	for <ltp@archiver.kernel.org>; Thu, 13 Oct 2022 11:13:40 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1511E3C6DE4
 for <ltp@lists.linux.it>; Thu, 13 Oct 2022 11:13:30 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 76BF31A01105
 for <ltp@lists.linux.it>; Thu, 13 Oct 2022 11:13:29 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C953721F19;
 Thu, 13 Oct 2022 09:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1665652408; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QCxcZ3WmtsoJAmUyo0sH53YhACee6pA56wE/cy4/RIY=;
 b=jOCKtLBySI6E9Nd8tCfp+66qlTagVkuSAVHAUAgniDXPy+gpyyIUy3W21opL0VBfn47Tgp
 ih55Jif5ZyKbYr5gunOC6rqZ9ty/XrTSuDW4rXlggaVLhoPgsnyvOf5HzUv1/lzRybPF+c
 NrCPe3OEkljoEcon/ABm6MeQY4GR6TQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1665652408;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QCxcZ3WmtsoJAmUyo0sH53YhACee6pA56wE/cy4/RIY=;
 b=RRv9W7OgJwt8lohMqSRwqqXvtKsfyt6Wo/KALLzMMz7hubpSa31WOr45CvaZY0+BrCOuhq
 NU7UUMi38Tut/FBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A9B7F13AAA;
 Thu, 13 Oct 2022 09:13:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id K5rVJrjWR2PFBgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 13 Oct 2022 09:13:28 +0000
Date: Thu, 13 Oct 2022 11:15:14 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Edward Liaw <edliaw@google.com>
Message-ID: <Y0fXIt38+VlpDn6v@yuki>
References: <20221006184228.3281392-1-edliaw@google.com>
 <Y0RbGMRj8rDC2Eti@yuki>
 <CAG4es9XqHPZJ2Tu9pKy8cpGBy-6Bb=Ztgw5tS-BMroWDdUFW7w@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAG4es9XqHPZJ2Tu9pKy8cpGBy-6Bb=Ztgw5tS-BMroWDdUFW7w@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 0/4] mmapstress01: refactor to ltp framework
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
Cc: kernel-team@android.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > * I'm failing to see why we need to block SIGALRM just before alarm(0)
> >   as far as I can tell it's completely useless. Also blocking signals
> >   while we refork looks questionable.
> >
> 
> Is the reason it's blocking signals while reforking is due to the second
> choice in https://man7.org/linux/man-pages/man7/signal-safety.7.html?  I'm
> not familiar with signal handling.
> ```
> Block signal delivery in the main program when calling
> functions that are unsafe or operating on global data that is
> also accessed by the signal handler.
> ```

I do not think that this is a valid reason. What that paragraph is
trying to tell is that you either have to avoid calling anything that
modifies global state and may cause trouble or block signals in sections
that do the same but in the normal program context. Either way that
effectively makes sure that such code is never run concurently.

For example calling malloc()/free() modifies locks and data structures
in libc, it's not safe to be called from signal handler and can easily
cause deadlocks and corruptions. Technically you can avoid that either
by not calling malloc()/free() from a signal handler, or by disabling
signal handlers before you call malloc()/free() or anything that may
possibly call malloc()/free() in the rest of the program.

In this case the signal handler is as simple as it gets, it only sets a
global flag that is checked in the while () loop that reforks. And the
only important thing we do there is the fork(). However fork() cannot be
interrupted by a signal and return EINTR so it cannot even fail. It
would probably made some sense if we wanted to setup different signal
handlers in the child and avoid getting signals before we do so, but
that's not the case here either.

So either this is a leftover code that was there to protect something
that has been removed long in the past, or copy&pasted code from a
different test that acutally made use of that. At least I do not see any
other reason to have it there.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
