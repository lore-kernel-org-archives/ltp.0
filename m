From: Harish <harish@linux.ibm.com>
Date: Fri, 3 Jul 2020 17:56:10 +0530
Subject: [LTP] [PATCH V4 5/6] syscalls: Don't pass struct timespec to
 tst_syscall()
In-Reply-To: <CAEemH2cu_o2eCHQB1_Bo0aQiR2WK6knbBtD83-5_77gZZbA-Ow@mail.gmail.com>
References: <c47220ecab3c7570f5387cd71894c977009ad3d8.1590572545.git.viresh.kumar@linaro.org>
 <9562fdf4debd759439ee7f468008177003db9513.1592457867.git.viresh.kumar@linaro.org>
 <CAEemH2cu_o2eCHQB1_Bo0aQiR2WK6knbBtD83-5_77gZZbA-Ow@mail.gmail.com>
Message-ID: <01e75ebb-224d-064c-7438-deb1da34204c@linux.ibm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

+1. I am also facing the same issue with many similar tests.

# uname -rm
4.18.0-211.el8.ppc64le ppc64le

Regards,
Harish

On 7/3/20 3:25 PM, Li Wang wrote:
> Hi Viresh,
> Seems this patch involved a new regression:(.
>
> Viresh Kumar <viresh.kumar@linaro.org 
> <mailto:viresh.kumar@linaro.org>> wrote:
>
>     ...
>
>     +typedef int (*mysyscall)(clockid_t clk_id, void *ts);
>     +
>     +int syscall_supported_by_kernel(mysyscall func)
>     +{
>     +? ? ? ?int ret;
>     +
>     +? ? ? ?ret = func(0, NULL); 
>
>     +? ? ? ?if (ret == -1 && errno == ENOSYS)
>     +? ? ? ? ? ? ? ?return 0;
>     +
>     +? ? ? ?return 1;
>     +}
>     ...?}
>
>     ?int tst_clock_gettime(clockid_t clk_id, struct timespec *ts)
>     ?{
>     -? ? ? ?return tst_syscall(__NR_clock_gettime, clk_id, ts);
>     +? ? ? ?struct tst_ts tts = { 0, };
>     +? ? ? ?static mysyscall func;
>     +? ? ? ?int ret;
>     +
>     +#if (__NR_clock_gettime64 != __LTP__NR_INVALID_SYSCALL)
>     +? ? ? ?if (!func &&
>     syscall_supported_by_kernel(sys_clock_gettime64)) {
>
>
> To invoke?sys_clock_gettime64 here?makes no chance to choose the 
> correct syscall version since tst_syscall() will?exit directly when 
> getting ENOSYS.
>
> We got many tests TCONF like the mmap18 did as below:
> -------------------
> # uname -rm
> 5.8.0-rc2+ aarch64
> # ./mmap18
> tst_test.c:1247: INFO: Timeout per run is 0h 05m 00s
> ../include/tst_timer.h:214: CONF: syscall(403) __NR_clock_gettime64 
> not supported
>
> the function call trace:
> -----------------------------
> testrun()
> get_time_ms
> ...
> tst_clock_gettime
> syscall_supported_by_kernel
> sys_clock_gettime64
> tst_syscall(__NR_clock_gettime64, ...)
>
>
> ---- syscalls/regen.sh -----
> #define tst_syscall(NR, ...) ({ \\
> ? ? ? ? int tst_ret; \\
> ? ? ? ? if (NR == __LTP__NR_INVALID_SYSCALL) { \\
> ? ? ? ? ? ? ? ? errno = ENOSYS; \\
> ? ? ? ? ? ? ? ? tst_ret = -1; \\
> ? ? ? ? } else { \\
> ? ? ? ? ? ? ? ? tst_ret = syscall(NR, ##__VA_ARGS__); \\
> ? ? ? ? } \\
> ? ? ? ? if (tst_ret == -1 && errno == ENOSYS) { \\
> ? ? ? ? ? ? ? ? tst_brk(TCONF, "syscall(%d) " #NR " not supported", 
> NR); \\
> ? ? ? ? } \\
> ? ? ? ? tst_ret; \\
> })
>
>     +? ? ? ? ? ? ? ?func = sys_clock_gettime64;
>     +? ? ? ? ? ? ? ?tts.type = TST_KERN_TIMESPEC;
>     +? ? ? ?}
>     +#endif
>     +
>     +? ? ? ?if (!func && syscall_supported_by_kernel(sys_clock_gettime)) {
>     +? ? ? ? ? ? ? ?func = sys_clock_gettime;
>     +? ? ? ? ? ? ? ?tts.type = TST_KERN_OLD_TIMESPEC;
>     +? ? ? ?}
>     +
>     +? ? ? ?if (!func) {
>     +? ? ? ? ? ? ? ?tst_res(TCONF, "clock_gettime() not available");
>     +? ? ? ? ? ? ? ?errno = ENOSYS;
>     +? ? ? ? ? ? ? ?return -1;
>     +? ? ? ?}
>     +
>     +? ? ? ?ret = func(clk_id, tst_ts_get(&tts));
>     +? ? ? ?ts->tv_sec = tst_ts_get_sec(tts);
>     +? ? ? ?ts->tv_nsec = tst_ts_get_nsec(tts);
>     +? ? ? ?return ret;
>     ?}
>
>
> Regards,
> Li Wang
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200703/d81b89ee/attachment.htm>
