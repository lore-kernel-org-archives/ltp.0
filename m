Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4454DC19F2B
	for <ltp@archiver.kernel.org>; Thu,  4 Aug 2022 10:14:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 88C3C3C9501
	for <ltp@archiver.kernel.org>; Thu,  4 Aug 2022 12:14:17 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F1B223C4FC3
 for <ltp@lists.linux.it>; Thu,  4 Aug 2022 12:14:06 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 9AF84601BED
 for <ltp@lists.linux.it>; Thu,  4 Aug 2022 12:14:04 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 98DFB34A57;
 Thu,  4 Aug 2022 10:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1659608043;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=De/SpeZM8ZAa/P1RfxrkGpN/xnYAKkvsj0pZbWA5sRE=;
 b=pHOMufDHb3mnlxISW+lhd0ShNl0t6QGnFH8RiEAxa/SgfrXSrcCAHo+R99+UjnlUrw4bPd
 Qqa1AQRjGPwN1NwJouzb3PLYe3y1melmf/gPMmtYkNpeoqtLqZeRkCIZJfjxXt2Hh1paFI
 x3jF8Wf1h4zVs396yTAKPtkoF8peRgA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1659608043;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=De/SpeZM8ZAa/P1RfxrkGpN/xnYAKkvsj0pZbWA5sRE=;
 b=mezpDmo4vBgV4yqzR8xXt/oGqO9KSlKIYkuOEbI4Ny4o1WDWfJKWPLCct6ELFLNrFAz7ew
 x1wtbZ7tP5fpWnDg==
Received: from g78 (unknown [10.163.17.14])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 392EB2C16E;
 Thu,  4 Aug 2022 10:14:03 +0000 (UTC)
References: <20220725100641.11625-1-rpalethorpe@suse.com>
 <CAEemH2ck+baL4PA5F5OoL1VRCS+W=CJHpXJbx9-jUNVa9ofR0Q@mail.gmail.com>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Li Wang <liwang@redhat.com>
Date: Thu, 04 Aug 2022 10:47:43 +0100
In-reply-to: <CAEemH2ck+baL4PA5F5OoL1VRCS+W=CJHpXJbx9-jUNVa9ofR0Q@mail.gmail.com>
Message-ID: <874jystixh.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/4] read_all: Add worker timeout and rewrite
 scheduling
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello Li,

Li Wang <liwang@redhat.com> writes:

> Hi Richard, All,
>
> On Mon, Jul 25, 2022 at 6:06 PM Richard Palethorpe <rpalethorpe@suse.com> wrote:
>
>  Kill and restart workers that take too long to read a file. The
>  default being 10% of max_runtime. A custom time can be set with the
>  new -t option.
>
>  This is to prevent a worker from blocking forever in a read. Currently
>  when this happens the whole test times out and any remaining files in
>  the worker's queue are not tested.
>
>  As a side effect we can now also set the timeout very low to cause
>  partial reads. However setting it to less than the time it takes to
>  start (fork) a new worker is treated as an error. Forking takes much
>  longer than most reads.
>
>  A number of other possible issues were fixed as well as a side effect
>  of changing the scheduling:
>
>  + The worker queues are now filled in a
>    "round robin" way. Before this only happened when -r was large
>    enough.
>  + When testing is finished the main process waits on the child procs before
>    destroying the semaphores and worker queues.
>  + max_runtime is set to 100 secs. This is so that the worker timeout
>    is a round number.
>  + Files which don't implement O_NONBLOCK and may block, no longer need
>    to be avoided. Even if they refuse to die immediately;
>    although this may result in TBROK due to zombie processes.
>
>  Note that with a worker timeout of 1s, 2 to 3 files will usually timeout on
>  my workstation. With 2s, none will. In any case testing completes in
>  under 3s for proc, sys or dev.
>
>  This is much faster than many other machines. It's quite likely the
>  worker timeout and max_runtime need to be increased on small and very
>  large machines. This can be done manually by setting LTP_RUNTIME_MUL.
>
> Yes, apart from a bit of difficulty (at least for me) to comprehend the detailed
> behavior of this scheduler :). 
>
> Thanks for your improvements! Just one tiny query below.
>
> Reviewed-by: Li Wang <liwang@redhat.com>

Thanks!
>
>   
>  --- a/testcases/kernel/fs/read_all/read_all.c
>  +++ b/testcases/kernel/fs/read_all/read_all.c
>  ...
>
>  +#include <signal.h>
>   #include <sys/types.h>
>   #include <sys/stat.h>
>  +#include <sys/wait.h>
>   #include <lapi/fnmatch.h>
>   #include <stdlib.h>
>   #include <stdio.h>
>  @@ -43,7 +45,10 @@
>   #include <pwd.h>
>   #include <grp.h>
>
>  +#include "tst_atomic.h"
>  +#include "tst_safe_clocks.h"
>   #include "tst_test.h"
>  +#include "tst_timer.h"
>
>   #define QUEUE_SIZE 16384
>   #define BUFFER_SIZE 1024
>  @@ -55,11 +60,15 @@ struct queue {
>          int front;
>          int back;
>          char data[QUEUE_SIZE];
>
> I doubt whether we need to maintain a queue to store the paths.
> During the test it seems only one path is being pushed in the q->data[],
> so the rest of the space is wasted, right?
>
> By shrinking the QUEUE_SIZE to equal BUFFER_SIZE, the test
> still works normally.

The rest of the space should be being used unless it is buggy. It's a
circle buffer with multiple (variable length) items delimited by \0.

However it's a very good point you make. It's true that having a
multi-item queue on each worker is not necessary.

At most we need two buffers (or a flip buffer) on each worker, one
containing the current path being worked on and one with the next path
to be worked on.

This would be much simpler than the circle buffer queue I originally
implemented. It may mean the workers are more likely to starve while
waiting for the main process. However the main process usually adds work
far faster than the workers can consume it.

So we should probably swap the queue for a flip buffer. I'll look into
that and merge this patchset as it is for now.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
