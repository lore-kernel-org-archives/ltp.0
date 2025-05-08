Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 980FFC3ABBC
	for <ltp@archiver.kernel.org>; Fri,  9 May 2025 07:52:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 381AD3CC16E
	for <ltp@archiver.kernel.org>; Fri,  9 May 2025 09:52:46 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A13463CC0B7
 for <ltp@lists.linux.it>; Thu,  8 May 2025 18:40:38 +0200 (CEST)
Received: from gnu.wildebeest.org (gnu.wildebeest.org [45.83.234.184])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 79972600AFA
 for <ltp@lists.linux.it>; Thu,  8 May 2025 18:40:35 +0200 (CEST)
Received: from r6.localdomain (82-217-174-174.cable.dynamic.v4.ziggo.nl
 [82.217.174.174])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by gnu.wildebeest.org (Postfix) with ESMTPSA id 5215E303C2A0;
 Thu,  8 May 2025 18:40:35 +0200 (CEST)
Received: by r6.localdomain (Postfix, from userid 1000)
 id F3CF7340687; Thu, 08 May 2025 18:40:34 +0200 (CEST)
Message-ID: <3c55aaf36ed4312cdfd603808db295ac09617412.camel@klomp.org>
From: Mark Wielaard <mark@klomp.org>
To: Petr Vorel <pvorel@suse.cz>, Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 08 May 2025 18:40:34 +0200
In-Reply-To: <20250506080520.GA64990@pevik>
References: <20250429052247.GA144682@pevik> <aBSVO8uOE86UGIcp@yuki.lan>
 <4428939d-dc71-488b-9728-030accaca3e8@suse.cz> <aBh9Z4QA2YcdOFq1@rei.lan>
 <20250506080520.GA64990@pevik>
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Fri, 09 May 2025 09:52:10 +0200
Subject: Re: [LTP] LTP in valgrind :)
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
Cc: ltp@lists.linux.it, Martin Cermak <mcermak@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr, Hi ltp hackers,

On Tue, 2025-05-06 at 10:05 +0200, Petr Vorel wrote:
> > > > It also opens some interesting questions, i.e. how do we make comparing
> > > > results from two different tests easier. Currently they grep the test
> > > > results for a summary, but maybe we can do better.
> 
> > > One option is to extract all TPASS/TFAIL/TWARN/TBROK/TCONF messages, 
> > > discard any message contents past the file:line header and then compare 
> > > whether the sanitized output is identical. That'll take care of random 
> > > values in the output while ensuring that the test went through the same 
> > > code paths as before. We could provide a sanitizer script for that.
> 
> > Maybe we can even add an option to the test library to supress the
> > messages in output, that would be fairly simple.
> 
> @Martin @Mark: feel free to comment what we can do for you :).
> Whole thread:
> https://lore.kernel.org/ltp/20250505195003.GB137650@pevik/T/#t

Thanks. Something small, but if you could CC
valgrind-developers@lists.sourceforge.net on new ltp releases that
would be great.

I saw a question at the top of that thread about "They consider some
test long running". In general that is not about the actual ltp tests
(we currently only run the testcases/kernel/syscalls ones), but because
valgrind:

a) is basically a giant Just In Time compiler, which instruments all
code, and might slow down your code 20x (yeah, we know).

b) serializes all threads, so only one thread runs at a time, all
parallel code is executed as if it was serial code.

c) memcheck keeps track of all memory to see if values are "valid"
(have a known value written to them). This cost about 25% more memory
than the program itself uses (and might actually double the amount).

So for now we have the following exclude file:
https://sourceware.org/cgit/valgrind/tree/auxprogs/ltp-excludes.txt

bind06
epoll-ltp
fork14
futex_cmp_requeue01
futex_cmp_requeue02
inotify09
msgstress01
pidfd_send_signal01
pidfd_send_signal02
pidfd_send_signal03
sendmsg03
setsockopt06
setsockopt07
signal05
signal06
timerfd_settime02

We haven't yet analyzed them to see what exactly makes them so slow
(under valgrind). It was more important to get the ltpchecks run on all
our CI systems:
https://builder.sourceware.org/buildbot/#/builders?tags=valgrind
Some of those systems only have 8GB of memory or are fairly slow
(specifically the arm32 and riscv builders).

The pidfd_send_signal tests are excluded because they seemed to kill
the container they were running inside. Again, this could be a valgrind
bug. valgrind doesn't implement a proper syscall wrapper for
pidfd_send_signal so it might be possible we are just killing a random
process...

Cheers,

Mark

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
