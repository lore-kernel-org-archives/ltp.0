From: Li Wang <liwang@redhat.com>
Date: Wed, 25 Nov 2020 20:50:39 +0800
Subject: [LTP] [PATCH] fzsync: skip test when avaliable CPUs less than 2
In-Reply-To: <04c4b073-6ad3-836a-7f63-7632a4e6ddb7@suse.cz>
References: <20201125101633.30154-1-liwang@redhat.com> <87eekhof3i.fsf@suse.de>
 <04c4b073-6ad3-836a-7f63-7632a4e6ddb7@suse.cz>
Message-ID: <CAEemH2ctWEp-B1yfB0cfCy6eP0dSwWLxcdsukV45GyF4SEQVmg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Nov 25, 2020 at 7:56 PM Martin Doucha <mdoucha@suse.cz> wrote:

> On 25. 11. 20 12:22, Richard Palethorpe wrote:
> > Hello Li,
> >
> > Li Wang <liwang@redhat.com> writes:
> >
> >> It makes no sense to run parallel thread to simulate race conditions on
> >> system with CPU number less than two, especially for kvm guest, it does
> >> not have any chance to get real parallel running and probably encounter
> >> failure as below:
> >
> > Most of the tests using FuzzySync do not need true parallism. We were
> > able to reproduce a number of race conditions on a single vCPU. Infact
> > it may actually benefit some races because one thread has to pause to
> > allow the other to run, perhaps creating a huge race window.

>
> >>
> >> === 100% reproducible on a 1cpu guest ===
> >>
> >> cmdline="af_alg07"
> >> contacts=""
> >> analysis=exit
> >> <<<test_output>>>
> >> tst_test.c:1248: TINFO: Timeout per run is 0h 05m 00s
> >> ../../../include/tst_fuzzy_sync.h:507: TINFO: Minimum sampling period
> ended
> >> ../../../include/tst_fuzzy_sync.h:330: TINFO: loop = 1024, delay_bias =
> 0
> >> ../../../include/tst_fuzzy_sync.h:318: TINFO: start_a - start_b: { avg
> = -137522ns, avg_dev = 854248ns, dev_ratio = 6.21 }
> >> ../../../include/tst_fuzzy_sync.h:318: TINFO: end_a - start_a  : { avg
> =  1915ns, avg_dev =   535ns, dev_ratio = 0.28 }
> >> ../../../include/tst_fuzzy_sync.h:318: TINFO: end_b - start_b  : { avg
> =  1885ns, avg_dev =    42ns, dev_ratio = 0.02 }
> >> ../../../include/tst_fuzzy_sync.h:318: TINFO: end_a - end_b    : { avg
> = -137492ns, avg_dev = 854818ns, dev_ratio = 6.22 }
> >> ../../../include/tst_fuzzy_sync.h:318: TINFO: spins            : { avg
> = 554786  , avg_dev =  7355  , dev_ratio = 0.01 }
> >> ../../../include/tst_fuzzy_sync.h:636: TINFO: Exceeded execution time,
> requesting exit
> >> af_alg07.c:96: TFAIL: fchownat() failed to fail, kernel may be
> vulnerable
> >>
> >> Signed-off-by: Li Wang <liwang@redhat.com>
> >> CC: Richard Palethorpe <rpalethorpe@suse.de>
> >> ---
> >>  include/tst_fuzzy_sync.h | 3 +++
> >>  1 file changed, 3 insertions(+)
> >>
> >> diff --git a/include/tst_fuzzy_sync.h b/include/tst_fuzzy_sync.h
> >> index 4141f5c64..2e864b312 100644
> >> --- a/include/tst_fuzzy_sync.h
> >> +++ b/include/tst_fuzzy_sync.h
> >> @@ -281,6 +281,9 @@ static void tst_init_stat(struct tst_fzsync_stat *s)
> >>  static void tst_fzsync_pair_reset(struct tst_fzsync_pair *pair,
> >>                                void *(*run_b)(void *))
> >>  {
> >> +    if (get_nprocs() < 2)
> >> +            tst_brk(TCONF, "Fuzzy Sync requires at least two CPUs
> available");
> >> +
> >>      tst_fzsync_pair_cleanup(pair);
> >>
> >>      tst_init_stat(&pair->diff_ss);
> >
> > Perhaps this test would pass with more loops and a big enough delay
> > range, but this is also wasting time on a single vCPU. I'm not sure
> > whether we should filter this test at the LTP level; it may trigger the
> > bug on some single CPU configs.
>
> No, af_alg07 requires 2 CPUs, otherwise it'll report false positives.
> The test will pass only if fchownat() hits a half-closed socket and
> returns error. But IIRC the half-closed socket will be destroyed during
> reschedule which means there's no race window to hit anymore. But it
> would be better to put the TCONF condition into the test itself.
>

+1
Correct, I stand by Martin's point.

And we can avoid adding this patch to FuzzySync lib, but for af_alg07 2cpus
is required.
(maybe go with Cyril's suggest to add .min_cpus)

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20201125/630b5666/attachment.htm>
