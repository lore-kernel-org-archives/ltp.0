Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D72F9C433FE
	for <ltp@archiver.kernel.org>; Tue, 15 Nov 2022 09:24:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9B21E3CD14A
	for <ltp@archiver.kernel.org>; Tue, 15 Nov 2022 10:24:21 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5C0DE3CA363
 for <ltp@lists.linux.it>; Tue, 15 Nov 2022 10:24:12 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 96E0C600906
 for <ltp@lists.linux.it>; Tue, 15 Nov 2022 10:24:10 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id B1B0F1F8C5;
 Tue, 15 Nov 2022 09:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1668504248;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U7aP6CyJfIPYZLhBbFnbKdDhsam0p/7Cqq91HD2HfJM=;
 b=E/Liq7sKO1LKJNFMa2DasLcyrjHZDmrAv9qwl9UaAHVr8DdV1gFvMUndzad/Pn/3xBWLlm
 YaI9GqaPmiNVg6xGbFMN4NG7DtqQ/iXUFlWsuYxRtEg7k45DyhuQ3ZBphnG0pCg2eKidpB
 IcLVHsNkc7jXcQ3CCbmm4qjHvjAHmZw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1668504248;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U7aP6CyJfIPYZLhBbFnbKdDhsam0p/7Cqq91HD2HfJM=;
 b=W8HAFLWV6z/UEr/O3tEjeOh9Oao+zMxt2OYy+Bghlf419t4JgNTcpDRWxYbZCSEqkabWv9
 6Bi07O12yfvSarDw==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 7A58A2C142;
 Tue, 15 Nov 2022 09:24:08 +0000 (UTC)
References: <20221112040107.3953862-1-liwang@redhat.com>
 <87pmdpsfdv.fsf@suse.de>
 <CAEemH2fJJ8Fv0=OMjdh3d8QaEdr1ivLUuHs_8=D6qV6-YZhbwQ@mail.gmail.com>
User-agent: mu4e 1.8.11; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Li Wang <liwang@redhat.com>
Date: Tue, 15 Nov 2022 08:44:11 +0000
Organization: Linux Private Site
In-reply-to: <CAEemH2fJJ8Fv0=OMjdh3d8QaEdr1ivLUuHs_8=D6qV6-YZhbwQ@mail.gmail.com>
Message-ID: <87h6z0sh8o.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] setitimer01: add interval timer test
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
Cc: Andrea Cervesato <acervesato@suse.de>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Li Wang <liwang@redhat.com> writes:

> On Mon, Nov 14, 2022 at 11:52 PM Richard Palethorpe <rpalethorpe@suse.de> wrote:
>
>  Hello,
>
>  Li Wang <liwang@redhat.com> writes:
>
>  > Split checking the return ovalue from testing the signal is
>  > delivered, so that we could use two time value for verifying.
>  >
>  > Also, adding interval timer test by handling the signal at
>  > least 10 times. After that recover the signal behavior to
>  > default and do deliver-signal checking.
>  >
>  > Signed-off-by: Li Wang <liwang@redhat.com>
>  > ---
>  >  .../kernel/syscalls/setitimer/setitimer01.c   | 63 ++++++++++++-------
>  >  1 file changed, 39 insertions(+), 24 deletions(-)
>  >
>  > diff --git a/testcases/kernel/syscalls/setitimer/setitimer01.c b/testcases/kernel/syscalls/setitimer/setitimer01.c
>  > index 1f631d457..260590b0e 100644
>  > --- a/testcases/kernel/syscalls/setitimer/setitimer01.c
>  > +++ b/testcases/kernel/syscalls/setitimer/setitimer01.c
>  > @@ -22,8 +22,10 @@
>  >  #include "tst_safe_clocks.h"
>  >  
>  >  static struct itimerval *value, *ovalue;
>  > +static volatile unsigned long sigcnt;
>  >  static long time_step;
>  > -static long time_count;
>  > +static long time_sec;
>  > +static long time_usec;
>  >  
>  >  static struct tcase {
>  >       int which;
>  > @@ -40,54 +42,66 @@ static int sys_setitimer(int which, void *new_value, void *old_value)
>  >       return tst_syscall(__NR_setitimer, which, new_value, old_value);
>  >  }
>  >  
>  > -static void set_setitimer_value(int usec, int o_usec)
>  > +static void sig_routine(int signo LTP_ATTRIBUTE_UNUSED)
>  >  {
>  > -     value->it_value.tv_sec = 0;
>  > -     value->it_value.tv_usec = usec;
>  > -     value->it_interval.tv_sec = 0;
>  > -     value->it_interval.tv_usec = 0;
>  > +     sigcnt++;
>  > +}
>  >  
>  > -     ovalue->it_value.tv_sec = o_usec;
>  > -     ovalue->it_value.tv_usec = o_usec;
>  > -     ovalue->it_interval.tv_sec = 0;
>  > -     ovalue->it_interval.tv_usec = 0;
>  > +static void set_setitimer_value(int sec, int usec)
>  > +{
>  > +     value->it_value.tv_sec = sec;
>  > +     value->it_value.tv_usec = usec;
>  > +     value->it_interval.tv_sec = sec;
>  > +     value->it_interval.tv_usec = usec;
>  >  }
>  >  
>  >  static void verify_setitimer(unsigned int i)
>  >  {
>  >       pid_t pid;
>  >       int status;
>  > -     long margin;
>  >       struct tcase *tc = &tcases[i];
>  >  
>  > +     tst_res(TINFO, "tc->which = %s", tc->des);
>  > +
>  >       pid = SAFE_FORK();
>  >  
>  >       if (pid == 0) {
>  > -             tst_res(TINFO, "tc->which = %s", tc->des);
>  > -
>  >               tst_no_corefile(0);
>  >  
>  > -             set_setitimer_value(time_count, 0);
>  > +             set_setitimer_value(time_sec, time_usec);
>  >               TST_EXP_PASS(sys_setitimer(tc->which, value, NULL));
>  >  
>  > -             set_setitimer_value(5 * time_step, 7 * time_step);
>  > +             set_setitimer_value(2 * time_sec, 2 * time_usec);
>
>  IDK if there was some reason for choosing 5 and 7 in the first place?
>
> I don't see any necessary reasons for using prime numbers here.
>
> @Andrea, did I miss something?
>
>  
>  
>  Andrea seemed to be going through the prime numbers.
>
>  >               TST_EXP_PASS(sys_setitimer(tc->which, value, ovalue));
>  >  
>  > -             tst_res(TINFO, "tv_sec=%ld, tv_usec=%ld",
>  > -                     ovalue->it_value.tv_sec,
>  > -                     ovalue->it_value.tv_usec);
>  > +             TST_EXP_EQ_LI(ovalue->it_interval.tv_sec, time_sec);
>  > +             TST_EXP_EQ_LI(ovalue->it_interval.tv_usec, time_usec);
>  > +
>  > +             tst_res(TINFO, "ovalue->it_value.tv_sec=%ld, ovalue->it_value.tv_usec=%ld",
>  > +                     ovalue->it_value.tv_sec, ovalue->it_value.tv_usec);
>  >  
>  >               /*
>  >                * ITIMER_VIRTUAL and ITIMER_PROF timers always expire a
>  >                * time_step afterward the elapsed time to make sure that
>  >                * at least counters take effect.
>  >                */
>  > -             margin = tc->which == ITIMER_REAL ? 0 : time_step;
>  > +             long margin = (tc->which == ITIMER_REAL) ? 0 : time_step;
>
>  Looks like an unecessary change?
>
> Yes, but the 'margin' is only used in children, and I moved
> the declaration here is just to highlight and cause attention
> in code reading.

It's a valid change, but the benefit is very minor IMO. I would prefer
to have the 'git blame' show the original commit which added this logic.

>
>  
>  
>  >  
>  > -             if (ovalue->it_value.tv_sec != 0 || ovalue->it_value.tv_usec > time_count + margin)
>  > +             if (ovalue->it_value.tv_sec > time_sec ||
>  > +                             ovalue->it_value.tv_usec > time_usec + margin)
>
>  Looking at the man page, technically speaking the valid range for
>  ovalue->it_value.tv_sec is 0 to value->it_value.tv_sec when
>  ovalue->it_value.tv_usec > 0.
>
> Good point!! Seems we have to split the situation into two,
>
> 1. no tv_sec elapse happen, just check
>     'it_value.tv_usec' within [0, time_usec + margin]
>
> 2. tv_sec elapses happen, then check 
>     'it_value.tv_sec' within [0, time_sec]
>
> Something maybe like:
>
> --- a/testcases/kernel/syscalls/setitimer/setitimer01.c
> +++ b/testcases/kernel/syscalls/setitimer/setitimer01.c
> @@ -87,9 +87,17 @@ static void verify_setitimer(unsigned int i)
>                  */
>                 long margin = (tc->which == ITIMER_REAL) ? 0 : time_step;
>  
> -               if (ovalue->it_value.tv_sec > time_sec ||
> -                               ovalue->it_value.tv_usec > time_usec + margin)
> -                       tst_res(TFAIL, "Ending counters are out of range");
> +               if (ovalue->it_value.tv_sec == time_sec) {
> +                       if (ovalue->it_value.tv_usec < 0 ||
> +                                       ovalue->it_value.tv_usec > time_usec + margin)
> +                               tst_res(TFAIL, "ovalue->it_value.tv_usec is out of range: %ld",
> +                                               ovalue->it_value.tv_usec);
> +               } else {
> +                       if (ovalue->it_value.tv_sec < 0 ||
> +                                       ovalue->it_value.tv_sec > time_sec)
> +                               tst_res(TFAIL, "ovalue->it_value.tv_sec is out of range: %ld",
> +                                               ovalue->it_value.tv_usec);
> +               }

Yes, I think this is correct.

>  
>                 SAFE_SIGNAL(tc->signo, sig_routine);
>
>  
>  
>  Practically speaking we have to assume a large amount of time has passed
>  when using ITIMER_REAL. It has to be *much* larger than a VM is likely
>  to be paused for and then successfully resumed. Or the amount of time a
>  clock may be corrected by (for e.g. with NTP).
>
> Hmm, not sure if I understand correctly above, will that
> timer value be out of the range but reasonable?
>
> Or is there any additional situation we should cover?

Sorry that is confusing.

The question is what happens if the clock jumps backwards?

I don't see anything which says it_value.tv_sec can't go out of
range. OTOH I would expect it to compensate for large jumps in time.

If the test randomly fails because it_value.tv_sec > time_sec then what
action will we take?

>
>  
>  
>  >                       tst_res(TFAIL, "Ending counters are out of range");
>
>  While we are here; we should make our lives easier when the test fails
>  by printing any relevant values.
>
> We already do that in the above print, but it's fine to have that here as well.


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
