From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Fri, 3 Jul 2020 13:52:32 +0800
Subject: [LTP] [PATCH V7 05/19] syscalls/sched_rr_get_interval: Add
 support for time64 tests
In-Reply-To: <20200703031532.bjkwhkpfobdsxj4p@vireshk-i7>
References: <cover.1593152309.git.viresh.kumar@linaro.org>
 <325a43a851acca8bb242011a1d62063c8154653c.1593152309.git.viresh.kumar@linaro.org>
 <20200702130654.GC9101@yuki.lan> <20200703031532.bjkwhkpfobdsxj4p@vireshk-i7>
Message-ID: <fb2f4706-2739-9ab7-3b1f-a741cf055680@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Viresh

> On 02-07-20, 15:06, Cyril Hrubis wrote:
>> Btw, we may as well add a check that the value is consistent with
>> /proc/sys/kernel/sched_rr_timeslice_ms.

I guess cyril may want to add a check using TST_ASSERT_INT api like this

TST_ASSERT_INT("/proc/sys/kernel/sched_rr_timeslice_ms", tst_ts_to_ms(tp));

> diff --git a/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval01.c b/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval01.c
> index 31d7b5d56a52..0641b6651502 100644
> --- a/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval01.c
> +++ b/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval01.c
> @@ -44,6 +44,7 @@ static void setup(void)
>   static void run(void)
>   {
>          struct test_variants *tv = &variants[tst_variant];
> +       unsigned long long timeslice_ms;
>   
>          TEST(tv->func(0, tst_ts_get(&tp)));
>   
> @@ -54,6 +55,8 @@ static void run(void)
>                          TST_RET);
>          }
>   
> +       SAFE_FILE_SCANF("/proc/sys/kernel/sched_rr_timeslice_ms", "%llu", &timeslice_ms);
> +
>          if (!tst_ts_valid(&tp)) {
>                  tst_res(TPASS, "Time quantum %llis %llins",
>                          tst_ts_get_sec(tp), tst_ts_get_nsec(tp));
> @@ -62,6 +65,7 @@ static void run(void)
>                          tst_ts_get_sec(tp), tst_ts_get_nsec(tp));
>          }
>   
> +       tst_res(TINFO, "%llu: %llu", timeslice_ms, tst_ts_to_ms(tp));
>   }
>   
>   static struct tst_test test = {
>
>
>
> and it is coming as:
>
> sched_rr_get_interval01.c:68: INFO: 25: 100
>
> They aren't consistent here. Perhaps because first one is system wide
> while other one is per process ?

It is strange.
On my machine, the two values are all 100. AFAIK, it has a bug (set in milliseconds but the result is shown in jiffies.) on old kernel whenCONFIG_HZ is not 1000. what kernel version do you test?
[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=975e155ed8732cb81f55c021c441ae662dd040b5

>


-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200703/d6b8e72a/attachment.htm>
