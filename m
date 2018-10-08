From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Mon, 08 Oct 2018 14:32:32 +0200
Subject: [LTP] [PATCH v2 2/4] fzsync: Simplify API with start/end race
	calls and limit exec time
In-Reply-To: <CAEemH2f1NZut2amfmntr0+rr7GTzFCCgT3LoOQmO_n=jMhmKdA@mail.gmail.com>
References: <20180910084442.17720-1-rpalethorpe@suse.com>
 <20180910084442.17720-3-rpalethorpe@suse.com>
 <CAEemH2f1NZut2amfmntr0+rr7GTzFCCgT3LoOQmO_n=jMhmKdA@mail.gmail.com>
Message-ID: <87ftxgy5y7.fsf@rpws.prws.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Li Wang <liwang@redhat.com> writes:

> Hi Richard,
>
> Sorry for late reply. This patch V2 is good, not sure if below comments are
> useful to you, so just FYI.
>
> Richard Palethorpe <rpalethorpe@suse.com> wrote:
>
>> Make it so the test writer simply has to mark the beginning and end of a
>> race
>> in each thread. Previously they must choose where to call a delay and
>> where to
>> call a timestamp function which is used to calculate the delay as well as
>> the
>> update function.
>> ...
>> +       /**
>> +        * Internal; Number of spins to use in the delay.
>> +        *
>> +        * A negative value delays thread A and a positive delays thread B.
>> +        */
>> +       int delay;
>> +       /**
>> +        *  Internal; The number of samples left or the sampling state.
>> +        *
>> +        *  A positive value is the number of remaining mandatory
>> +        *  samples. Zero or a negative indicate ssome other state.
>>
>
> s/ssome/some/, a typo here?
>
> +
>> +       /** Internal; Atomic counter used by fzsync_pair_wait() */
>>         int a_cntr;
>> +       /** Internal; Atomic counter used by fzsync_pair_wait() */
>>         int b_cntr;
>> +       /** Internal; Used by tst_fzsync_pair_exit() and
>> fzsync_pair_wait() */
>>         int exit;
>> +       /**
>> +        * The maximum desired execution time as a proportion of the
>> timeout
>> +        *
>> +        * A value x so that 0 < x < 1 which decides how long the test
>> should
>> +        * be run for (assuming the loop limit is not exceeded first).
>> +        *
>> +        * Defaults to 0.1 (~30 seconds with default timeout).
>> +        */
>> +       float exec_time_p;
>> +       /** Internal; The test time remaining on tst_fzsync_pair_reset() */
>> +       float exec_time_start;
>>
>
> I think maybe call it as 'exec_time_remain' or 'exec_time_total' is better?
> because this value is the remain part of the whole timeout time before next
> resetting.

I'm not sure, it is quite confusing either way. Probably
'exec_time_remaining_at_start' is less confusing, but it is too long. I
can't think of anything which is short and accurate.

>
> +
>> -#define TST_FZSYNC_PAIR_INIT { \
>> -       .avg_alpha = 0.25,      \
>> -       .delay_inc = 1,         \
>> -       .update_gap = 0xF,      \
>> -       .info_gap = 0x7FFFF     \
>> +static void tst_fzsync_pair_init(struct tst_fzsync_pair *pair)
>> +{
>> +       CHK(avg_alpha, 0, 1, 0.25);
>> +       CHK(min_samples, 20, INT_MAX, 1024);
>> +       CHK(max_dev_ratio, 0, 1, 0.1);
>> +       CHK(exec_time_p, 0, 1, 0.2);
>>
>
> The code comment says the default is 0.1, but why here gives 0.2?

It should be 0.1 here as well.

>
> +static void tst_fzsync_pair_reset(struct tst_fzsync_pair *pair,
>> +                                 void *(*run_b)(void *))
>> +{
>> +       tst_fzsync_pair_cleanup(pair);
>> +
>> +       tst_init_stat(&pair->diff_ss);
>> +       tst_init_stat(&pair->diff_sa);
>> +       tst_init_stat(&pair->diff_sb);
>> +       tst_init_stat(&pair->diff_ab);
>> +       tst_init_stat(&pair->spins_avg);
>> +       pair->delay = 0;
>> +       pair->sampling = pair->min_samples;
>> +
>> +       pair->exec_loop = 0;
>> +
>> +       pair->a_cntr = 0;
>> +       pair->b_cntr = 0;
>> +       tst_atomic_store(0, &pair->exit);
>> +       if (run_b)
>> +               SAFE_PTHREAD_CREATE(&pair->thread_b, 0, run_b, 0);
>> +
>> +       pair->exec_time_start = (float)tst_timeout_remaining();
>
>
> Here we start to get the whole remain time before reaching timeout
> aborting, and base on that to comparing in tst_fzsync_run_a() to guarantee
> test exit when execute time exceed. That's fine, but it is too early to get
> the time here I guess, because samples collection will also cost some of
> the limitation_time(~30 seconds), and we don't know what proportion the
> sampling occupied in exec_time_p, if it's too much, then there only has
> very little time on race execution.

The race can still happen during the sampling period (although for some
tests it is unlikely).

>
> To avoid this, maybe we should make the limitation time all spend on race
> execution but any on samplings.
> So, I suggest to get pair->exec_time_start value after samples data
> collection in the end of tst_fzsync_pair_update() function.

I don't like the sampling time being bounding only by the overall test
timeout. Users really hate test broken messages. Possibly if the test
timeouts before the sampling period has finished, then we could return
TWARN or TCONF saying that the test did not have enough time to execute?

--
Thank you,
Richard.
