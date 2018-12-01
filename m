From: Li Wang <liwan@redhat.com>
Date: Sat, 1 Dec 2018 17:48:56 +0800
Subject: [LTP] [PATCH] fzsync: limit sampling time
In-Reply-To: <45587008.81059248.1543654685122.JavaMail.zimbra@redhat.com>
References: <c49a5628139703513cb66d84d03953ddb5cc1560.1543489660.git.jstancek@redhat.com>
 <CAEemH2cVjYJLwLvkvS3QK7PwmM=g+HzFFaPo5YK3uAex3SEghA@mail.gmail.com>
 <45587008.81059248.1543654685122.JavaMail.zimbra@redhat.com>
Message-ID: <CAEemH2de7s_c4CRQYbpxEWeCKjtwdzOjZZ68ao_n0Ht+OR1VKg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Sat, Dec 1, 2018 at 4:58 PM Jan Stancek <jstancek@redhat.com> wrote:
>
>
>
> ----- Original Message -----
> > On Thu, Nov 29, 2018 at 7:09 PM Jan Stancek <jstancek@redhat.com> wrote:
> > >
> > > Fixes: #429
> > >
> > > Sampling can take considerably longer time on single CPU
> > > and very slow systems. This patch limits sampling time to
> > > 1/2 of fuzzing runtime (0.25 of test time). If we don't
> > > have enough samples by that time, stop sampling and use
> > > stats we gathered so far.
> >
> > This patch makes sense.
> >
> > >
> > > Signed-off-by: Jan Stancek <jstancek@redhat.com>
> > > ---
> > >  include/tst_fuzzy_sync.h | 15 +++++++++++++--
> > >  1 file changed, 13 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/include/tst_fuzzy_sync.h b/include/tst_fuzzy_sync.h
> > > index 03f69b78bc82..0ca292c141c3 100644
> > > --- a/include/tst_fuzzy_sync.h
> > > +++ b/include/tst_fuzzy_sync.h
> > > @@ -162,6 +162,7 @@ struct tst_fzsync_pair {
> > >          *
> > >          * Defaults to 0.5 (~150 seconds with default timeout).
> > >          */
> > > +       float max_sampling_p;
> > >         float exec_time_p;
> > >         /** Internal; The test time remaining on tst_fzsync_pair_reset() */
> > >         float exec_time_start;
> > > @@ -199,6 +200,7 @@ static void tst_fzsync_pair_init(struct tst_fzsync_pair
> > > *pair)
> > >         CHK(avg_alpha, 0, 1, 0.25);
> > >         CHK(min_samples, 20, INT_MAX, 1024);
> > >         CHK(max_dev_ratio, 0, 1, 0.1);
> > > +       CHK(max_sampling_p, 0, 1, 0.25);
> > >         CHK(exec_time_p, 0, 1, 0.5);
> > >         CHK(exec_loops, 20, INT_MAX, 3000000);
> > >  }
> > > @@ -582,9 +584,18 @@ static inline void tst_fzsync_wait_b(struct
> > > tst_fzsync_pair *pair)
> > >  static inline int tst_fzsync_run_a(struct tst_fzsync_pair *pair)
> > >  {
> > >         int exit = 0;
> > > +       float rem_p = 1 - tst_timeout_remaining() / pair->exec_time_start;
> > > +
> > > +       /* Limit amount of time spent on sampling */
> > > +       if ((pair->max_sampling_p < rem_p)
> > > +               && (pair->sampling > 0)) {
> > > +               tst_res(TINFO, "stopping sampling at %d samples",
> > > +                       pair->sampling);
> >
> > pair->sampling is the number of samples left, so I think the prints
> > might be more precise if calculate the 'pair->min_samples -
> > pair->sampling'(or pair->exec_loop)?
>
> Yes, I was lazy.
>
> >
> > > +               pair->sampling = 0;
> > > +               tst_fzsync_pair_info(pair);
> > > +       }
> > >
> > > -       if (pair->exec_time_p
> > > -           < 1 - tst_timeout_remaining() / pair->exec_time_start) {
> > > +       if (pair->exec_time_p < rem_p) {
> > >                 tst_res(TINFO,
> > >                         "Exceeded execution time, requesting exit");
> > >                 exit = 1;
> >
> > After involving max_sampling_p, here the warning prints will no longer
> > be useful because it will never get 'pair->sampling > 0' when
> > exec_time_p is exhausted.
>
> You're right, "still sampling" warning can't be reached now.
>
> In my first iteration I had it limited only to single CPU systems,
> so the warning was still possible on SMP.
>
> I'll send v2.
>
> >
> > Base on your patch I suggest that:
> >
> > --- a/include/tst_fuzzy_sync.h
> > +++ b/include/tst_fuzzy_sync.h
> > @@ -590,7 +590,7 @@ static inline int tst_fzsync_run_a(struct
> > tst_fzsync_pair *pair)
> >         if ((pair->max_sampling_p < rem_p)
> >                 && (pair->sampling > 0)) {
> >                 tst_res(TINFO, "stopping sampling at %d samples",
> > -                       pair->sampling);
> > +                       pair->exec_loop);
> >                 pair->sampling = 0;
> >                 tst_fzsync_pair_info(pair);
> >         }
> > @@ -599,11 +599,6 @@ static inline int tst_fzsync_run_a(struct
> > tst_fzsync_pair *pair)
> >                 tst_res(TINFO,
> >                         "Exceeded execution time, requesting exit");
> >                 exit = 1;
> > -
> > -               if (pair->sampling > 0) {
> > -                       tst_res(TWARN,
> > -                               "Still sampling, consider increasing
> > LTP_TIMEOUT_MUL");
> > -               }
> >         }
> >
> >         if (++pair->exec_loop > pair->exec_loops) {
> >
> >
> > ======= Snip ========
> >
> > Additionally, If we go this way to limit the sampling time, seems
> > 'pair->min_samples' will become less meaning for fuzzy sync library,
>
> True, but this applies only when sampling goes very slowly.
>
> > because we can just do sampling in a limited time and why we need the
> > minimal samples?
>
> Wouldn't we spend too much time sampling on fast systems
> without much gain?
>
> My impression was we want to get out of sampling phase ASAP,
> so library can start inserting random delays.
>
> Regards,
> Jan
>
> >
> > So what about using limited-time to replace min_samples? Maybe like:
> >
> > --- a/include/tst_fuzzy_sync.h
> > +++ b/include/tst_fuzzy_sync.h
> > @@ -123,19 +123,14 @@ struct tst_fzsync_pair {
> >          */
> >         int delay;
> >         /**
> > -        *  Internal; The number of samples left or the sampling state.
> > +        *  Internal; The number of samples in the sampling phase.
> >          *
> > -        *  A positive value is the number of remaining mandatory
> > +        *  A positive value is the number of past mandatory
> >          *  samples. Zero or a negative indicate some other state.
> >          */
> >         int sampling;
> > -       /**
> > -        * The Minimum number of statistical samples which must be collected.
> > -        *
> > -        * The minimum number of iterations which must be performed before a
> > -        * random delay can be calculated. Defaults to 1024.
> > -        */
> > -       int min_samples;
> > +       /** Internal; Exit sampling phase if this value is 1 */
> > +       int sampling_exit;
> >         /**
> >          * The maximum allowed proportional average deviation.
> >          *
> > @@ -198,7 +193,6 @@ struct tst_fzsync_pair {
> >  static void tst_fzsync_pair_init(struct tst_fzsync_pair *pair)
> >  {
> >         CHK(avg_alpha, 0, 1, 0.25);
> > -       CHK(min_samples, 20, INT_MAX, 1024);
> >         CHK(max_dev_ratio, 0, 1, 0.1);
> >         CHK(max_sampling_p, 0, 1, 0.25);
> >         CHK(exec_time_p, 0, 1, 0.5);
> > @@ -262,7 +256,8 @@ static void tst_fzsync_pair_reset(struct
> > tst_fzsync_pair *pair,
> >         tst_init_stat(&pair->diff_ab);
> >         tst_init_stat(&pair->spins_avg);
> >         pair->delay = 0;
> > -       pair->sampling = pair->min_samples;
> > +       pair->sampling = 0;
> > +       pair->sampling_exit = 0;
> >
> >         pair->exec_loop = 0;
> >
> > @@ -295,7 +290,6 @@ static inline void tst_fzsync_stat_info(struct
> > tst_fzsync_stat stat,
> >   */
> >  static void tst_fzsync_pair_info(struct tst_fzsync_pair *pair)
> >  {
> > -       tst_res(TINFO, "loop = %d", pair->exec_loop);
> >         tst_fzsync_stat_info(pair->diff_ss, "ns", "start_a - start_b");
> >         tst_fzsync_stat_info(pair->diff_sa, "ns", "end_a - start_a");
> >         tst_fzsync_stat_info(pair->diff_sb, "ns", "end_b - start_b");
> > @@ -450,6 +444,9 @@ static void tst_fzsync_pair_update(struct
> > tst_fzsync_pair *pair)
> >         float alpha = pair->avg_alpha;
> >         float per_spin_time, time_delay, dev_ratio;
> >
> > +       if (!pair->sampling_exit)
> > +               ++pair->sampling;
> > +
> >         dev_ratio = (pair->diff_sa.dev_ratio
> >                      + pair->diff_sb.dev_ratio
> >                      + pair->diff_ab.dev_ratio
> > @@ -465,11 +462,13 @@ static void tst_fzsync_pair_update(struct
> > tst_fzsync_pair *pair)
> >                 tst_upd_diff_stat(&pair->diff_ab, alpha,
> >                                   pair->a_end, pair->b_end);
> >                 tst_upd_stat(&pair->spins_avg, alpha, pair->spins);
> > -               if (pair->sampling > 0 && --pair->sampling == 0) {
> > +               if (pair->sampling_exit && pair->sampling > 0) {
> >                         tst_res(TINFO,
> > -                               "Minimum sampling period ended,
> > deviation ratio = %.2f",
> > -                               dev_ratio);
> > +                               "Sampling period ended, total samples = %d,"
> > +                               "deviation ratio = %.2f",
> > +                               pair->sampling, dev_ratio);
> >                         tst_fzsync_pair_info(pair);
> > +                       pair->sampling = 0;
> >                 }
> >         } else if (fabsf(pair->diff_ab.avg) >= 1 && pair->spins_avg.avg >= 1)
> >         {
> >                 per_spin_time = fabsf(pair->diff_ab.avg) /
> >                 pair->spins_avg.avg;
> > @@ -587,23 +586,14 @@ static inline int tst_fzsync_run_a(struct
> > tst_fzsync_pair *pair)
> >         float rem_p = 1 - tst_timeout_remaining() / pair->exec_time_start;
> >
> >         /* Limit amount of time spent on sampling */
> > -       if ((pair->max_sampling_p < rem_p)
> > -               && (pair->sampling > 0)) {
> > -               tst_res(TINFO, "stopping sampling at %d samples",
> > -                       pair->sampling);
> > -               pair->sampling = 0;
> > -               tst_fzsync_pair_info(pair);
> > -       }
> > +       if ((pair->max_sampling_p < rem_p && pair->sampling > 0)
> > +                       || pair->sampling >= 0.25 * pair->exec_loops)
> > +               pair->sampling_exit = 1;
> >
> >         if (pair->exec_time_p < rem_p) {
> >                 tst_res(TINFO,
> >                         "Exceeded execution time, requesting exit");
> >                 exit = 1;
> > -
> > -               if (pair->sampling > 0) {
> > -                       tst_res(TWARN,
> > -                               "Still sampling, consider increasing
> > LTP_TIMEOUT_MUL");
> > -               }
> >         }
> >
> >         if (++pair->exec_loop > pair->exec_loops) {
> >
> > --
> > Regards,
> > Li Wang
> >



-- 
Regards,
Li Wang
