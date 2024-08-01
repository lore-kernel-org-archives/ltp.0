Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D2FEC3DA4A
	for <ltp@archiver.kernel.org>; Thu,  1 Aug 2024 12:15:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E5DFC3D1F41
	for <ltp@archiver.kernel.org>; Thu,  1 Aug 2024 14:15:40 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E42BB3D0B2B
 for <ltp@lists.linux.it>; Thu,  1 Aug 2024 14:15:25 +0200 (CEST)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id E6EB31001128
 for <ltp@lists.linux.it>; Thu,  1 Aug 2024 14:15:24 +0200 (CEST)
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6bb96ef0e96so321806d6.2
 for <ltp@lists.linux.it>; Thu, 01 Aug 2024 05:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722514524; x=1723119324; darn=lists.linux.it;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gMUSNP2McIZYLI/eEqL71k9IIU1p92v1M4zsyL7gmUw=;
 b=umPhiO/tsOOXANqO0EL2h/cehFV7Osibl9sg6rDiZ/3bIgA7T/BQaCnkB6WxPfNjYa
 FveSLJBvgXt888pbsg4ZHl/NZYGrneF+ZVMLLBoWkusx/bvAu8p7CXRbwLaAvGGt7wxR
 wiyS81ESpRtPaTDnnikdwDBlF9KQDbtVul/B95ZEkeFYjuUW4KC2ZPkYWbPj0KKxmOz+
 jrs55qDsZffGCfdMrnfjLYTquNxLwlVPBX/hbNIXSlSQusKJVy2pfTkEHucQYETgxSUd
 ih2cGDqTdOdWkQ4S5IO0QJ8rwxVhD61pSkb4uWq/4aPQ0Q9yRjI8EJ3vJdGULLgHypFc
 J9uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722514524; x=1723119324;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gMUSNP2McIZYLI/eEqL71k9IIU1p92v1M4zsyL7gmUw=;
 b=XvqGMwPl71qdGUcITmCwsNpQD/ppn5YheUNYs3kE3CdoNBD47+EiIXKPYivZ5mxdbX
 OfVYFa21iC5oiMXfx2RYVnZ5shNa3YRjBg3xsOQSDMCUBdEMgz7C8JhvTTs81mLQ0nYz
 tkERXJ3nvd2hgoBDSJTwBvq711LAZHzEnw7DLJb7AZIh9jMThb5zQRlxoHc9e2tNRIfa
 A9SDAGIw+rR5uPS4D7iqfjiJyGZyPGSeTyIi8raQ0US6JINrrnWiRMoNtapaaOmqeBnd
 dLEIqjMAsZMDIybzTwZQ/31HPj1GVmPvhqG+5a81LPln7tiUNpPkubQEolxmCBaZtant
 Xg0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUHCsIXcj9qMBY500C63XaBVoBooON9E2B0oDD2nYzlYbuwKMjQmUC7kloEQq8fgT7qWxZ6d34otjsABzH5O0JhJg=
X-Gm-Message-State: AOJu0Yy+0ODaBrGd03M7WQDaFbiKzjndADG1VzHD8i+hT/rvcPoKxfuJ
 XoxVZRcq2LL1ZJ+ewPIGjGCNC6ZQlncwN0RYgwDHv+nAMSwJE8w4P7pxskalsio619ENKBv09o0
 2nSCLpR2QhCpH3eTFoWRjbSz0Tbko0Fr8cS6PCA==
X-Google-Smtp-Source: AGHT+IFN8GyusAMlwPnyqnOG7/ueYNnLw/0qHFR1Shl54BK7ppVbx7z56cuWtYALt23SNjfnuCU8fpBPoSop8vef/nE=
X-Received: by 2002:a05:6214:311e:b0:6b2:b557:c551 with SMTP id
 6a1803df08f44-6bb8d7ccd57mr2706336d6.27.1722514523446; Thu, 01 Aug 2024
 05:15:23 -0700 (PDT)
MIME-Version: 1.0
References: <20240722145443.19104-1-chrubis@suse.cz>
 <20240729205112.GA1287954@pevik>
In-Reply-To: <20240729205112.GA1287954@pevik>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Thu, 1 Aug 2024 14:15:12 +0200
Message-ID: <CADYN=9LQGmMopUD1sfy71YVKmBUNTMgh=k8brL0EDdhCDOzcfA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] sched: starvation: Autocallibrate the timeout
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
Cc: joe.liu@mediatek.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Mon, 29 Jul 2024 at 22:51, Petr Vorel <pvorel@suse.cz> wrote:
>
> Hi all,
>
> > Instead of hardcoding the values we attempt to measure the CPU speed and
> > set the runtime accordingly. Given that the difference in the duration
> > of the test when the kernel is buggy is about 30x we do not have to have
> > a precise callibration, just very rough estimate if we are running on a
> > server or small ARM board would suffice.
>
> > So we attempt to measure how long does a bussy loop take and base the
> > default timeout on that. On x86_64 CPUs the resulting runtime seems to
> > be between 2x and 10x of the actual runtime which seems to be in the
> > required range.
>
> > We also make sure to check the runtime at the end of the test because
> > the failures could have been masked by a timeout multiplier, i.e. if you
> > set LTP_TIMEOUT_MUL=10 the test would previously pass on a buggy kernel
> > as well. The side efect is that we now get better PASS/FAIL messages as
> > well.
>
> > Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> > ---
>
> > Changes in v3:
>
> > - Increased the CALLIBRATE_LOOPS a bit, since some of the numbers
> >   reported by the linaro lab had the runtime very close to the
> >   calculated runtime.
>
> Anders, Joe, can you please recheck?

I've tested this patch on 1 arm HW and 2 arm64 HW's. see the results below.

arm HW:
===== [1;36mstarvation[0m =====
command: starvation
[ 42.782470] /usr/local/bin/kirk[369]: starting test starvation (starvation)
tst_test.c:1734: [1;34mTINFO: [0mLTP version: 20180118-5676-gc035435ba
tst_test.c:1618: [1;34mTINFO: [0mTimeout per run is 0h 05m 24s
starvation.c:84: [1;32mTPASS: [0msched_setaffinity(0, sizeof(mask),
&mask) returned 0
starvation.c:52: [1;34mTINFO: [0mCPU did 120000000 loops in 106903us
tst_test.c:1626: [1;34mTINFO: [0mUpdating max runtime to 0h 01m 46s
tst_test.c:1618: [1;34mTINFO: [0mTimeout per run is 0h 07m 10s
starvation.c:133: [1;32mTPASS: [0mHaven't reproduced scheduller starvation.
Summary:
passed   2
failed   0
broken   0
skipped  0
warnings 0
Duration: 1m 2s

arm64 HW1:
===== [1;36mstarvation[0m =====
command: starvation
[   52.326682] /usr/local/bin/kirk[371]: starting test starvation (starvation)
[   52.326682] /usr/local/bin/kirk[371]: starting test starvation (starvation)
tst_test.c:1734: [1;34mTINFO: [0mLTP version: 20180118-5676-gc035435ba
tst_test.c:1618: [1;34mTINFO: [0mTimeout per run is 0h 05m 24s
starvation.c:84: [1;32mTPASS: [0msched_setaffinity(0, sizeof(mask),
&mask) returned 0
starvation.c:52: [1;34mTINFO: [0mCPU did 120000000 loops in 170664us
tst_test.c:1626: [1;34mTINFO: [0mUpdating max runtime to 0h 02m 50s
tst_test.c:1618: [1;34mTINFO: [0mTimeout per run is 0h 08m 14s
starvation.c:133: [1;32mTPASS: [0mHaven't reproduced scheduller starvation.
Summary:
passed   2
failed   0
broken   0
skipped  0
warnings 0
Duration: 1m 31s

arm64 HW2:
===== [1;36mstarvation[0m =====
command: starvation
[   25.461437] /usr/local/bin/kirk[781]: starting test starvation (starvation)
tst_test.c:1734: [1;34mTINFO: [0mLTP version: 20180118-5676-gc035435ba
tst_test.c:1618: [1;34mTINFO: [0mTimeout per run is 0h 05m 24s
starvation.c:84: [1;32mTPASS: [0msched_setaffinity(0, sizeof(mask),
&mask) returned 0
starvation.c:52: [1;34mTINFO: [0mCPU did 120000000 loops in 136451us
tst_test.c:1626: [1;34mTINFO: [0mUpdating max runtime to 0h 02m 16s
tst_test.c:1618: [1;34mTINFO: [0mTimeout per run is 0h 07m 40s
[   29.165003] sd 0:0:0:0: [sda] Starting disk
[   35.815791] sd 0:0:0:0: [sda] Starting disk
[   39.911757] sd 0:0:0:0: [sda] Starting disk
[   47.079469] sd 0:0:0:0: [sda] Starting disk
[   52.716832] sd 0:0:0:0: [sda] Starting disk
[   57.831781] sd 0:0:0:0: [sda] Starting disk
[   63.975740] sd 0:0:0:0: [sda] Starting disk
[   69.095887] sd 0:0:0:0: [sda] Starting disk
[   74.983623] sd 0:0:0:0: [sda] Starting disk
[   77.799749] sd 0:0:0:0: [sda] Starting disk
[   80.871712] sd 0:0:0:0: [sda] Starting disk
[   87.015762] sd 0:0:0:0: [sda] Starting disk
[   92.903786] sd 0:0:0:0: [sda] Starting disk
starvation.c:133: [1;32mTPASS: [0mHaven't reproduced scheduller starvation.
Summary:
passed   2
failed   0
broken   0
skipped  0
warnings 0
Duration: 1m 7s

Tested-by: Anders Roxell <anders.roxell@linaro.org>

Cheers,
Anders

>
> > - Removed some curly braces, as suggested by pvorel
>
> > - Added runtime check at the end of test to avoid false positives with
> >   LTP_TIMEOUT_MUL.
>
> Great!
>
> LGTM.
>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>
> Tested-by: Petr Vorel <pvorel@suse.cz>
>
> Tested on Tumbleweed (kernel 6.10.1):
>
> tst_tmpdir.c:316: TINFO: Using /tmp/LTP_starv8seE as tmpdir (tmpfs filesystem)
> tst_test.c:1806: TINFO: LTP version: 20240524
> tst_test.c:1650: TINFO: Timeout per run is 0h 00m 30s
> starvation.c:71: TINFO: Setting affinity to CPU 0
> tst_test.c:1658: TINFO: Updating max runtime to 0h 04m 00s
> tst_test.c:1650: TINFO: Timeout per run is 0h 04m 30s
> starvation.c:117: TPASS: wait_for_pid(child_pid) passed
>
> => test runs ~ 13s - 19s on aarch64, ppc64le and x86_64. Therefore not sure if
> 04m max runtime is good.
>
> I'll have tomorrow some tests on various SLES versions.
>
> Kind regards,
> Petr
>
> > .../kernel/sched/cfs-scheduler/starvation.c   | 41 +++++++++++++++++--
> >  1 file changed, 38 insertions(+), 3 deletions(-)
>
> > diff --git a/testcases/kernel/sched/cfs-scheduler/starvation.c b/testcases/kernel/sched/cfs-scheduler/starvation.c
> > index 9ac388fdc..e707e0865 100644
> > --- a/testcases/kernel/sched/cfs-scheduler/starvation.c
> > +++ b/testcases/kernel/sched/cfs-scheduler/starvation.c
> > @@ -21,11 +21,38 @@
> >  #include <sched.h>
>
> >  #include "tst_test.h"
> > +#include "tst_safe_clocks.h"
> > +#include "tst_timer.h"
>
> >  static char *str_loop;
> > -static long loop = 2000000;
> > +static long loop = 1000000;
> >  static char *str_timeout;
> > -static int timeout = 240;
> > +static int timeout;
> > +
> > +#define CALLIBRATE_LOOPS 120000000
> > +
> > +static int callibrate(void)
> > +{
> > +     int i;
> > +     struct timespec start, stop;
> > +     long long diff;
> > +
> > +     for (i = 0; i < CALLIBRATE_LOOPS; i++)
> > +             __asm__ __volatile__ ("" : "+g" (i) : :);
> > +
> > +     SAFE_CLOCK_GETTIME(CLOCK_MONOTONIC_RAW, &start);
> > +
> > +     for (i = 0; i < CALLIBRATE_LOOPS; i++)
> > +             __asm__ __volatile__ ("" : "+g" (i) : :);
> > +
> > +     SAFE_CLOCK_GETTIME(CLOCK_MONOTONIC_RAW, &stop);
> > +
> > +     diff = tst_timespec_diff_us(stop, start);
> > +
> > +     tst_res(TINFO, "CPU did %i loops in %llius", CALLIBRATE_LOOPS, diff);
> > +
> > +     return diff;
> > +}
>
> >  static int wait_for_pid(pid_t pid)
> >  {
> > @@ -78,6 +105,8 @@ static void setup(void)
>
> >       if (tst_parse_int(str_timeout, &timeout, 1, INT_MAX))
> >               tst_brk(TBROK, "Invalid number of timeout '%s'", str_timeout);
> > +     else
> > +             timeout = callibrate() / 1000;
>
> >       tst_set_max_runtime(timeout);
> >  }
> > @@ -114,7 +143,13 @@ static void do_test(void)
> >               sleep(1);
>
> >       SAFE_KILL(child_pid, SIGTERM);
> > -     TST_EXP_PASS(wait_for_pid(child_pid));
> > +
> > +     if (!tst_remaining_runtime())
> > +             tst_res(TFAIL, "Scheduller starvation reproduced.");
> > +     else
> > +             tst_res(TPASS, "Haven't reproduced scheduller starvation.");
> > +
> > +     TST_EXP_PASS_SILENT(wait_for_pid(child_pid));
> >  }
>
> >  static struct tst_test test = {

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
