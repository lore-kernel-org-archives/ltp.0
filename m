Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E9DCC433EF
	for <ltp@archiver.kernel.org>; Tue, 22 Mar 2022 09:22:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B4A623C8809
	for <ltp@archiver.kernel.org>; Tue, 22 Mar 2022 10:22:21 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3E02A3C05F5
 for <ltp@lists.linux.it>; Tue, 22 Mar 2022 10:22:11 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 462CE1400243
 for <ltp@lists.linux.it>; Tue, 22 Mar 2022 10:22:09 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F22B41F385;
 Tue, 22 Mar 2022 09:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1647940928; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EWkF6pPz4y1yahyQ0E3wRDTAKWn/vnjEZRS7+j+/pKY=;
 b=ejhPoDLfFNpeWMGk/pUIxHAEtRmOc+Aqidkvl9wyuF6V41aBEWNpBrTdNaclgWt0vPmJKe
 Xg0sWqnfiEYoUMpJDOHT8q7L+Xrths7dNthLpo5jq25+Wfj2ZivGF3A/f1XOQV6LQm6Yt3
 nNQ8EHQBGvqD7vDpLUIrmyLh8w68rq8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1647940928;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EWkF6pPz4y1yahyQ0E3wRDTAKWn/vnjEZRS7+j+/pKY=;
 b=zDlkEgAiEby1qj4iUUNs7A2exWPcw4rALzUHaCVKyEXOG3cSYD+5H2mSk0l2BtDgITECEa
 ZkQCAp/FhjI0FzAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DAA69133B6;
 Tue, 22 Mar 2022 09:22:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 5FaCNECVOWLqCAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 22 Mar 2022 09:22:08 +0000
Date: Tue, 22 Mar 2022 10:24:25 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.de>
Message-ID: <YjmVyZjCrylha0XW@yuki>
References: <20220310105533.3012-1-chrubis@suse.cz> <YinZzNWCiKalyWhd@yuki>
 <87ee2vclsf.fsf@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87ee2vclsf.fsf@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/waitid10: Fix on ARM,
 PPC and possibly others
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
> >> While integer division by zero does trap on x86_64 and causes the SIGFPE
> >> signal to be delivered it's not the case on all architecutes. At least
> >> on ARM and PPC64LE division by zero simply returns undefined result
> >> instead.
> 
> Nit picking: even with this patch we are still testing undefined
> behaviour.
> 
>    There are six signals that can be delivered as a consequence of a
>    hardware exception: SIGBUS, SIGEMT, SIGFPE, SIGILL, SIGSEGV, and
>    SIGTRAP.  Which of these signals is delivered, for any given
>    hard- ware exception, is not documented and does not always make
>    sense.
> 
> If dividing by zero produces SIGEMT then it's still valid according to
> the specification. FPE does stand for floating point exception, but we
> are dividing integers.

Actually as far as I can tell the POSIX says that for integer division
by zero you shall get SIGFPE (and si_code in siginfo se tto FPE_INTDIV)
if the operation traps. It seems to be pretty well defined:

https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/signal.h.html

> >> 
> >> This patch adds raise(SIGFPE) at the end of the child as a fallback to
> >> make sure the process is killed with the right signal on all
> >> architectures.
> >> 
> >> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> >> ---
> >>  testcases/kernel/syscalls/waitid/waitid10.c | 5 ++++-
> >>  1 file changed, 4 insertions(+), 1 deletion(-)
> >> 
> >> diff --git a/testcases/kernel/syscalls/waitid/waitid10.c b/testcases/kernel/syscalls/waitid/waitid10.c
> >> index 869ef18bd..8c351d120 100644
> >> --- a/testcases/kernel/syscalls/waitid/waitid10.c
> >> +++ b/testcases/kernel/syscalls/waitid/waitid10.c
> >> @@ -28,7 +28,10 @@ static void run(void)
> >>  		volatile int a, zero = 0;
> >>  
> >>  		a = 1 / zero;
> >> -		exit(a);
> >> +
> >> +		tst_res(TINFO, "Division by zero didn't trap, raising SIGFPE");
> >
> > This patch inroduces 'set but not used' warning for the a variable so
> > maybe the message should look like:
> >
> > 		tst_res(TINFO, "1/0 = %i raising SIGFPE", a);
> >
> >> +		raise(SIGFPE);
> 
> I'm wondering if we should branch on the architecture. If it's x86[_64]
> then we only do divide by zero as it's reasonable to think that if the
> signal is not raised then this is a bug.

That would work too I guess.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
