Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FED5C636D4
	for <ltp@archiver.kernel.org>; Fri, 17 Feb 2023 09:32:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8CE3E3CBE04
	for <ltp@archiver.kernel.org>; Fri, 17 Feb 2023 10:32:22 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0DB7E3CB072
 for <ltp@lists.linux.it>; Fri, 17 Feb 2023 10:32:12 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 2C8FC600855
 for <ltp@lists.linux.it>; Fri, 17 Feb 2023 10:32:11 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1B27933706;
 Fri, 17 Feb 2023 09:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1676626331; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jmZqwnWbrcQPRileEEn5h3vF2pt4Z0r+SpGKU9ZzSKk=;
 b=1lDuS346vZxdsVwL2S0/R6QV2QzLzk+xVbbDVvBhuTVeD0VjUxlJzfP4J6+GWh5Dcb4Aqf
 IDMM6RZkHAcSWhpssF5rykqMHo782pOso3UJj19gGx4KBPicLPufjSBLb1uGyHgTcPlh/W
 5Kx2eWOWwgVjkwmXC8rrQM6aGyHLPNU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1676626331;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jmZqwnWbrcQPRileEEn5h3vF2pt4Z0r+SpGKU9ZzSKk=;
 b=Vqza5LYahB0Ak3Ji9T/GbE8rZ24O4voq2ESh0OXBJPPf7WxY4PmfphBbPx+CUAen/+FC7A
 3OwIup+xogrW7ZCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F10D2138E3;
 Fri, 17 Feb 2023 09:32:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id w4XuOZpJ72PqFgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 17 Feb 2023 09:32:10 +0000
Date: Fri, 17 Feb 2023 10:33:37 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <Y+9J8XFW5TA6L7p2@yuki>
References: <20230213134619.27486-1-wegao@suse.com>
 <20230215023438.11370-1-wegao@suse.com> <Y+4MTlm9O/sN3Ety@yuki>
 <20230217041727.GA30450@localhost>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230217041727.GA30450@localhost>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] rseq01: basic test rseq
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
> > > +#if defined(HAVE_SYS_RSEQ_H) && defined(RSEQ_SIG)
> >                                              ^
> > 					     Where is this macro
> > 					     defined?
> RSEQ_SIG is arch specific macro , following are result in my test system:
> 
> find / -name "*.h" | xargs grep RSEQ_SIG
> /usr/include/x86_64-linux-gnu/bits/rseq.h:#define RSEQ_SIG        0x53053053
> 
> dpkg -S /usr/include/x86_64-linux-gnu/bits/rseq.h
> libc6-dev:amd64: /usr/include/x86_64-linux-gnu/bits/rseq.h

If that is a macro defined in a header the it does not make sense to
guard like this. We add fallback definitions instead of disabling code
this way.

> > > +#include <stdio.h>
> > > +#include <sched.h>
> > > +#include "lapi/rseq.h"
> > > +
> > > +static void run(void)
> > > +{
> > > +	check_rseq_available();
> > > +
> > > +	TST_EXP_PASS(!(sched_getcpu() >= 0));
> > 
> > This does not actually check anything useful.
> This case used to test against glibc's implementation, correct me if i am wrong.
> Once i saw following commit in glibc, so i think we can use sched_getcpu 
> do some sanity check for rseq implementation in glibc. 
> 1d350aa060 Linux: Use rseq to accelerate sched_getcpu

The sched_getcpu() would not test rseq at all on anything but glibc and
would give users false hope that rseq was actually tested even if it
was not.

If you want to make sure sched_getcpu() works fine you should write
sched_getcpu() test instead.

> > Very basic test would register rqseq, then loop over available CPUs, pin
> > a process to the CPU and check that rqsed did register the buffers. The
> > very basic test would look like:
> > 
> > https://github.com/torvalds/linux/blob/master/tools/testing/selftests/rseq/basic_test.c
> > 
> 
> Thanks for your feedback, i have a question on test direction, which one is our target?
> 
> 1) Check system call ONLY regardless glibc version/implementation then we move linux kernel test(as above link you mentioned) into our test.
> 
> 2) Check glibc's implemenation for rseq(from 2.35), such as 1.check sched_getcpu, 2.check glibc API 
> how to disable rseq feature which support automaticly from glibc start. (e3e589829d nptl: Add glibc.pthread.rseq tunable to control rseq registration). Then our target is move glibc test case to our test.

Please forget about glibc, it's not the only libc out there. The test
has to work correctly regardless the libc implementation, there are at
least five different libc variants used out there.


-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
