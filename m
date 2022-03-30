Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5087DC433EF
	for <ltp@archiver.kernel.org>; Wed, 30 Mar 2022 13:35:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 23F5B3C9F37
	for <ltp@archiver.kernel.org>; Wed, 30 Mar 2022 15:35:43 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9A0C53C0B78
 for <ltp@lists.linux.it>; Wed, 30 Mar 2022 15:35:32 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 88D701A0068F
 for <ltp@lists.linux.it>; Wed, 30 Mar 2022 15:35:31 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id D061F1F38C
 for <ltp@lists.linux.it>; Wed, 30 Mar 2022 13:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1648647330;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=67DEAlLykcCJxe5df3NmhftFWWJkFaFd7/uBGH+USvA=;
 b=IZm/JgzRgGE6ODM6UujI33e2e5TR4rNJmkBhrdHnaxg+51js9VbPgBbscJlwSCZKs1q0lY
 njVRJ6nV0IZQJsTvKfGnjx70DiyJvsaAo+zWWtjVtJr9+jczJHrrBaHjqPTixB11XRk81B
 siuv8Dn4Kt8nu6r1voZgqm8qBthCScs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1648647330;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=67DEAlLykcCJxe5df3NmhftFWWJkFaFd7/uBGH+USvA=;
 b=/HXzNfTGjmDNyCAXAVhqsfUclJ2PFRTThPygZiqu1y8wAcmXfi1HTb42lmyqjIsKpG9mkv
 FVHKld+X1zfL3RDw==
Received: from g78 (unknown [10.163.24.182])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 90A02A3B82;
 Wed, 30 Mar 2022 13:35:30 +0000 (UTC)
References: <20220310105533.3012-1-chrubis@suse.cz> <YinZzNWCiKalyWhd@yuki>
 <87ee2vclsf.fsf@suse.de> <YjmVyZjCrylha0XW@yuki>
User-agent: mu4e 1.6.10; emacs 27.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 30 Mar 2022 14:29:15 +0100
In-reply-to: <YjmVyZjCrylha0XW@yuki>
Message-ID: <877d8bmulf.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
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
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Cyril Hrubis <chrubis@suse.cz> writes:

> Hi!
>> >> While integer division by zero does trap on x86_64 and causes the SIGFPE
>> >> signal to be delivered it's not the case on all architecutes. At least
>> >> on ARM and PPC64LE division by zero simply returns undefined result
>> >> instead.
>> 
>> Nit picking: even with this patch we are still testing undefined
>> behaviour.
>> 
>>    There are six signals that can be delivered as a consequence of a
>>    hardware exception: SIGBUS, SIGEMT, SIGFPE, SIGILL, SIGSEGV, and
>>    SIGTRAP.  Which of these signals is delivered, for any given
>>    hard- ware exception, is not documented and does not always make
>>    sense.
>> 
>> If dividing by zero produces SIGEMT then it's still valid according to
>> the specification. FPE does stand for floating point exception, but we
>> are dividing integers.
>
> Actually as far as I can tell the POSIX says that for integer division
> by zero you shall get SIGFPE (and si_code in siginfo se tto FPE_INTDIV)
> if the operation traps. It seems to be pretty well defined:
>
> https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/signal.h.html
>
>> >> 
>> >> This patch adds raise(SIGFPE) at the end of the child as a fallback to
>> >> make sure the process is killed with the right signal on all
>> >> architectures.
>> >> 
>> >> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
>> >> ---
>> >>  testcases/kernel/syscalls/waitid/waitid10.c | 5 ++++-
>> >>  1 file changed, 4 insertions(+), 1 deletion(-)
>> >> 
>> >> diff --git a/testcases/kernel/syscalls/waitid/waitid10.c b/testcases/kernel/syscalls/waitid/waitid10.c
>> >> index 869ef18bd..8c351d120 100644
>> >> --- a/testcases/kernel/syscalls/waitid/waitid10.c
>> >> +++ b/testcases/kernel/syscalls/waitid/waitid10.c
>> >> @@ -28,7 +28,10 @@ static void run(void)
>> >>  		volatile int a, zero = 0;
>> >>  
>> >>  		a = 1 / zero;
>> >> -		exit(a);
>> >> +
>> >> +		tst_res(TINFO, "Division by zero didn't trap, raising SIGFPE");
>> >
>> > This patch inroduces 'set but not used' warning for the a variable so
>> > maybe the message should look like:
>> >
>> > 		tst_res(TINFO, "1/0 = %i raising SIGFPE", a);
>> >
>> >> +		raise(SIGFPE);
>> 
>> I'm wondering if we should branch on the architecture. If it's x86[_64]
>> then we only do divide by zero as it's reasonable to think that if the
>> signal is not raised then this is a bug.
>
> That would work too I guess.

I would still use #ifdef to remove raise(SIGFPE) on x86. I think this
makes it a more solid test on x86. As it is defined in the spec I guess
you could do the divide by zero on other arches and we can review the
results to see if any also raise SIGFPE.

With that:
Reviewed-by: Richard Palethorpe <rpalethorpe@suse.com>

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
