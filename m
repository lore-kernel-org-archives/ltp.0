Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26F14C433EF
	for <ltp@archiver.kernel.org>; Mon, 20 Jun 2022 08:08:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 885C73C93B3
	for <ltp@archiver.kernel.org>; Mon, 20 Jun 2022 10:08:48 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BECA83C039E
 for <ltp@lists.linux.it>; Mon, 20 Jun 2022 10:08:36 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C253A6008A7
 for <ltp@lists.linux.it>; Mon, 20 Jun 2022 10:08:35 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id F3C501F383;
 Mon, 20 Jun 2022 08:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1655712515;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a85kQP03KlwNMa6r5AB7BE9gDrhG4quaSOidpxS/8c0=;
 b=0hmec/tbzVpEdZYOv/4adSy2pYa8W0glEwk/U8l6IcZVonHfw+tUYMj4XFg6ZdLZ26B4Q5
 hBI3RWPGx0h9Ef/C0IYD8wZkOuAbz7D3D9ZZyXFsorox6P8e2iJnLajT33wdMqNWfjfxE1
 LPjwVQhvMmpqncRaGpcYC+UejMhkQwU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1655712515;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a85kQP03KlwNMa6r5AB7BE9gDrhG4quaSOidpxS/8c0=;
 b=1olbsvx4J/x69RiJqpEaPrpUOvJkOhO60gULB5WjHZObFBLQh0c/hhznKY7Y3fv6HMlk7u
 EywhSgTBMl43HGBw==
Received: from g78 (unknown [10.163.24.226])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id A62832C141;
 Mon, 20 Jun 2022 08:08:34 +0000 (UTC)
References: <20220615090648.405100-1-liwang@redhat.com>
 <875yl1jbkq.fsf@suse.de>
 <CAEemH2egR16PDbTASg9pJxBdY3w8B_=XEf+Du9hbLaqR0X3Wsw@mail.gmail.com>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Li Wang <liwang@redhat.com>
Date: Mon, 20 Jun 2022 08:44:35 +0100
In-reply-to: <CAEemH2egR16PDbTASg9pJxBdY3w8B_=XEf+Du9hbLaqR0X3Wsw@mail.gmail.com>
Message-ID: <87a6a769kt.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH] madvise06: shrink to 1 MADV_WILLNEED page to
 stabilize the test
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
Cc: Paul Bunyan <pbunyan@redhat.com>, Rafael Aquini <aquini@redhat.com>,
 LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello Li,

Li Wang <liwang@redhat.com> writes:

> Hi Richard,
>
> Richard Palethorpe <rpalethorpe@suse.de> wrote:
>  
>  > --- a/testcases/kernel/syscalls/madvise/madvise06.c
>  > +++ b/testcases/kernel/syscalls/madvise/madvise06.c
>  > @@ -164,7 +164,7 @@ static int get_page_fault_num(void)
>  >  
>  >  static void test_advice_willneed(void)
>  >  {
>  > -     int loops = 50, res;
>  > +     int loops = 100, res;
>  >       char *target;
>  >       long swapcached_start, swapcached;
>  >       int page_fault_num_1, page_fault_num_2;
>  > @@ -202,23 +202,32 @@ static void test_advice_willneed(void)
>  >               "%s than %ld Kb were moved to the swap cache",
>  >               res ? "more" : "less", PASS_THRESHOLD_KB);
>  >  
>  > -
>  > -     TEST(madvise(target, PASS_THRESHOLD, MADV_WILLNEED));
>  > +     loops = 100;
>  > +     SAFE_FILE_LINES_SCANF("/proc/meminfo", "SwapCached: %ld", &swapcached_start);
>  > +     TEST(madvise(target, pg_sz, MADV_WILLNEED));
>  >       if (TST_RET == -1)
>  >               tst_brk(TBROK | TTERRNO, "madvise failed");
>  > +     do {
>  > +             loops--;
>  > +             usleep(100000);
>  > +             if (stat_refresh_sup)
>  > +                     SAFE_FILE_PRINTF("/proc/sys/vm/stat_refresh", "1");
>  > +             SAFE_FILE_LINES_SCANF("/proc/meminfo", "SwapCached: %ld",
>  > +                             &swapcached);
>  > +     } while (swapcached < swapcached_start + pg_sz/1024 && loops > 0);
>  >  
>  >       page_fault_num_1 = get_page_fault_num();
>  >       tst_res(TINFO, "PageFault(madvice / no mem access): %d",
>  >                       page_fault_num_1);
>  > -     dirty_pages(target, PASS_THRESHOLD);
>  > +     dirty_pages(target, pg_sz);
>
>  Adding the loop makes sense to me. However I don't understand why you
>  have also switched from PASS_THRESHOLD to only a single page?
>
> In the test, we use two checks combined to confirm the bug reproduces:
>
>   1. swap cached increasing less than PASS_THRESHOLD_KB
>   2. page_fault number large than expected
>
> The 2. case is more easily get failed on kind of platforms and hard
> to count an average value for tolerating. So maybe we just reduce
> the page to one that would not affect the final result. Because we
> rely on both checks happening simultaneously then assume a bug.
>
>  
>  
>  I guess calling MADV_WILLNEED on a single page is the least realistic
>  scenario.
>
> Okay, perhaps it's a step backward:).
>
> I was just thinking it is a regression test and if 1 page works to reproduce
> that (but more chunks of memory easily cause false positive), why not.

That makes sense, but this test has also found other bugs. I'm not sure
if they are reproducible with only one page.

>
>  
>  
>  If there is an issue with PASS_THRESHOLD perhaps we could scale it based
>  on page size?
>
> This sounds acceptable too.
>
> How many pages do you think are proper, 100 or more?
> and, loosen the faulted-out numbers to 1/10 pages?

I suppose that 100 pages would be too much memory on some systems. I
guess at least 2 or 3 pages are needed so there is some
traversal. Beyond that I don't know what would make a difference.

If there are only max 3 pages and we have a loop, I would not expect any
to be faulted. Although maybe we could allow 1/3 because MADV_WILLNEED
is only an advisory and a lot of time has been spent discussing this
test already.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
