Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E26C7C00140
	for <ltp@archiver.kernel.org>; Fri,  5 Aug 2022 06:26:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 48CAF3C8D70
	for <ltp@archiver.kernel.org>; Fri,  5 Aug 2022 08:26:49 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 891CA3C1BBD
 for <ltp@lists.linux.it>; Fri,  5 Aug 2022 08:26:39 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 85DC41000412
 for <ltp@lists.linux.it>; Fri,  5 Aug 2022 08:26:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1659680797;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OoelHV59oCnBSPNKZNEwwOObwpyMNewH/YGw4E3rB9c=;
 b=TYrLC7QsSD2DiKGFOkzP/8FVh5ZyBHmQUprpuBf9s57e9rR6f4bEusKddPAIv7pPqzB/8R
 dbfmwp4jDt6vPqXbzgy6xu+YsGihzRWcnQD/mUpA2wqRAgsdX2jGh/jJaUFIlCmBq/+HY4
 WQJwUZ9ttgzWOc9qbpHmXh8GQCuvJR0=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-189-o4S-j-lvOMCuo_oTExYM5w-1; Fri, 05 Aug 2022 02:26:35 -0400
X-MC-Unique: o4S-j-lvOMCuo_oTExYM5w-1
Received: by mail-lj1-f200.google.com with SMTP id
 z7-20020a2ebe07000000b0025e5c7d6a2eso487866ljq.20
 for <ltp@lists.linux.it>; Thu, 04 Aug 2022 23:26:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc;
 bh=OoelHV59oCnBSPNKZNEwwOObwpyMNewH/YGw4E3rB9c=;
 b=JussGH8ZSKcCC0Bo6LuzyyIYCO5qqEUUlc5cpK9CF1WmtwdN7rWIj0FF4wWwJ+Mak/
 VxpApvuHpcJ+CBJfwpS1uQKwLPuUAvmNXDtzOLiEqdLrVHotVIxCrkFzRIpWOSkp5K6Z
 pP+A1lgm3negntl9Xq/9JM23JkHAWy883oL0+lL6HOhTQwdD0X6G85RcBNKxc8R9gFTU
 9AyqZCMvpevNL/vwTcO2peS1yWkgkf0MEs8ZomEuIFK7okpQlwwViZIF01z+cwFcSHZY
 o4QIE8zc1TPbtEMYtAhC+FmQ0EYaEfG2rfSo5SSzOvnsjBczej+XRTUZqi2AKz+EdG7F
 MH8A==
X-Gm-Message-State: ACgBeo1LkzVN2R3CG22beayuJ9w3CpZvKhS35dNqq5e79LdDB3mHWT69
 Xor8angdJKJMeePGL08usLs2BAHChxRzRJeF8N5WorCgDTpAp5+MS9NqokzZovtTWnbeKeA/aX7
 HhHmahF4cM52AHPd9EIhEbTjowdI=
X-Received: by 2002:a2e:b282:0:b0:25e:46b6:ff33 with SMTP id
 2-20020a2eb282000000b0025e46b6ff33mr1572645ljx.503.1659680794216; 
 Thu, 04 Aug 2022 23:26:34 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4rA0H/Up42QPyPtqx4H3Jo8PWOH5yM4PVkgJqLgDzMxGuNAU5sfcgpmWJHJZWDehTK1W5aR5S1Mtccb7gbn4c=
X-Received: by 2002:a2e:b282:0:b0:25e:46b6:ff33 with SMTP id
 2-20020a2eb282000000b0025e46b6ff33mr1572637ljx.503.1659680793977; Thu, 04 Aug
 2022 23:26:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220725100641.11625-1-rpalethorpe@suse.com>
 <CAEemH2ck+baL4PA5F5OoL1VRCS+W=CJHpXJbx9-jUNVa9ofR0Q@mail.gmail.com>
 <874jystixh.fsf@suse.de>
In-Reply-To: <874jystixh.fsf@suse.de>
From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 5 Aug 2022 08:26:17 +0200
Message-ID: <CAASaF6zUBJCKbSRwQtosyxocKXdc8SDZmA_43SeVBTLbwDNJ2Q@mail.gmail.com>
To: rpalethorpe@suse.de
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, Aug 4, 2022 at 12:14 PM Richard Palethorpe <rpalethorpe@suse.de> wrote:
>
> Hello Li,
>
> Li Wang <liwang@redhat.com> writes:
>
> > Hi Richard, All,
> >
> > On Mon, Jul 25, 2022 at 6:06 PM Richard Palethorpe <rpalethorpe@suse.com> wrote:
> >
> >  Kill and restart workers that take too long to read a file. The
> >  default being 10% of max_runtime. A custom time can be set with the
> >  new -t option.
> >
> >  This is to prevent a worker from blocking forever in a read. Currently
> >  when this happens the whole test times out and any remaining files in
> >  the worker's queue are not tested.
> >
> >  As a side effect we can now also set the timeout very low to cause
> >  partial reads. However setting it to less than the time it takes to
> >  start (fork) a new worker is treated as an error. Forking takes much
> >  longer than most reads.
> >
> >  A number of other possible issues were fixed as well as a side effect
> >  of changing the scheduling:
> >
> >  + The worker queues are now filled in a
> >    "round robin" way. Before this only happened when -r was large
> >    enough.
> >  + When testing is finished the main process waits on the child procs before
> >    destroying the semaphores and worker queues.
> >  + max_runtime is set to 100 secs. This is so that the worker timeout
> >    is a round number.
> >  + Files which don't implement O_NONBLOCK and may block, no longer need
> >    to be avoided. Even if they refuse to die immediately;
> >    although this may result in TBROK due to zombie processes.
> >
> >  Note that with a worker timeout of 1s, 2 to 3 files will usually timeout on
> >  my workstation. With 2s, none will. In any case testing completes in
> >  under 3s for proc, sys or dev.
> >
> >  This is much faster than many other machines. It's quite likely the
> >  worker timeout and max_runtime need to be increased on small and very
> >  large machines. This can be done manually by setting LTP_RUNTIME_MUL.
> >
> > Yes, apart from a bit of difficulty (at least for me) to comprehend the detailed
> > behavior of this scheduler :).
> >
> > Thanks for your improvements! Just one tiny query below.
> >
> > Reviewed-by: Li Wang <liwang@redhat.com>
>
> Thanks!
> >
> >
> >  --- a/testcases/kernel/fs/read_all/read_all.c
> >  +++ b/testcases/kernel/fs/read_all/read_all.c
> >  ...
> >
> >  +#include <signal.h>
> >   #include <sys/types.h>
> >   #include <sys/stat.h>
> >  +#include <sys/wait.h>
> >   #include <lapi/fnmatch.h>
> >   #include <stdlib.h>
> >   #include <stdio.h>
> >  @@ -43,7 +45,10 @@
> >   #include <pwd.h>
> >   #include <grp.h>
> >
> >  +#include "tst_atomic.h"
> >  +#include "tst_safe_clocks.h"
> >   #include "tst_test.h"
> >  +#include "tst_timer.h"
> >
> >   #define QUEUE_SIZE 16384
> >   #define BUFFER_SIZE 1024
> >  @@ -55,11 +60,15 @@ struct queue {
> >          int front;
> >          int back;
> >          char data[QUEUE_SIZE];
> >
> > I doubt whether we need to maintain a queue to store the paths.
> > During the test it seems only one path is being pushed in the q->data[],
> > so the rest of the space is wasted, right?
> >
> > By shrinking the QUEUE_SIZE to equal BUFFER_SIZE, the test
> > still works normally.
>
> The rest of the space should be being used unless it is buggy. It's a
> circle buffer with multiple (variable length) items delimited by \0.
>
> However it's a very good point you make. It's true that having a
> multi-item queue on each worker is not necessary.
>
> At most we need two buffers (or a flip buffer) on each worker, one
> containing the current path being worked on and one with the next path
> to be worked on.
>
> This would be much simpler than the circle buffer queue I originally
> implemented. It may mean the workers are more likely to starve while
> waiting for the main process. However the main process usually adds work
> far faster than the workers can consume it.
>
> So we should probably swap the queue for a flip buffer. I'll look into
> that and merge this patchset as it is for now.

Thanks for the improvements.


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
