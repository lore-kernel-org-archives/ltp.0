From: Harish <harish@linux.ibm.com>
Date: Mon, 6 Jul 2020 14:14:09 +0530
Subject: [LTP] [PATCH V4 5/6] syscalls: Don't pass struct timespec to
 tst_syscall()
In-Reply-To: <CAEemH2cN735haDmyqbNa_LwDgumFqAspYfJaKRpsOg0Rij9tEA@mail.gmail.com>
References: <c47220ecab3c7570f5387cd71894c977009ad3d8.1590572545.git.viresh.kumar@linaro.org>
 <9562fdf4debd759439ee7f468008177003db9513.1592457867.git.viresh.kumar@linaro.org>
 <CAEemH2cu_o2eCHQB1_Bo0aQiR2WK6knbBtD83-5_77gZZbA-Ow@mail.gmail.com>
 <20200703125927.GA11556@yuki.lan>
 <CAEemH2cN735haDmyqbNa_LwDgumFqAspYfJaKRpsOg0Rij9tEA@mail.gmail.com>
Message-ID: <1513894e-d23e-055e-df27-d8cf36b8c609@linux.ibm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

I tried the suggested patch, but was unsuccessful in running the test. 
Here is my diff.

diff --git a/lib/tst_clocks.c b/lib/tst_clocks.c
index bc0bef273..7b465b1f6 100644
--- a/lib/tst_clocks.c
+++ b/lib/tst_clocks.c
@@ -14,11 +14,11 @@

 ?typedef int (*mysyscall)(clockid_t clk_id, void *ts);

-int syscall_supported_by_kernel(mysyscall func)
+int syscall_supported_by_kernel(long sysnr)
 ?{
 ???? int ret;

-??? ret = func(0, NULL);
+??? ret = syscall(sysnr, 0, NULL);
 ???? if (ret == -1 && errno == ENOSYS)
 ???? ??? return 0;

@@ -32,13 +32,13 @@ int tst_clock_getres(clockid_t clk_id, struct 
timespec *res)
 ???? int ret;

 ?#if (__NR_clock_getres_time64 != __LTP__NR_INVALID_SYSCALL)
-??? if (!func && syscall_supported_by_kernel(sys_clock_getres64)) {
+??? if (!func && syscall_supported_by_kernel(__NR_clock_getres_time64)) {
 ???? ??? func = sys_clock_getres64;
 ???? ??? tts.type = TST_KERN_TIMESPEC;
 ???? }
 ?#endif

-??? if (!func && syscall_supported_by_kernel(sys_clock_getres)) {
+??? if (!func && syscall_supported_by_kernel(__NR_clock_getres)) {
 ???? ??? func = sys_clock_getres;
 ???? ??? tts.type = TST_KERN_OLD_TIMESPEC;
 ???? }
@@ -62,13 +62,13 @@ int tst_clock_gettime(clockid_t clk_id, struct 
timespec *ts)
 ???? int ret;

 ?#if (__NR_clock_gettime64 != __LTP__NR_INVALID_SYSCALL)
-??? if (!func && syscall_supported_by_kernel(sys_clock_gettime64)) {
+??? if (!func && syscall_supported_by_kernel(__NR_clock_gettime64)) {
 ???? ??? func = sys_clock_gettime64;
 ???? ??? tts.type = TST_KERN_TIMESPEC;
 ???? }
 ?#endif

-??? if (!func && syscall_supported_by_kernel(sys_clock_gettime)) {
+??? if (!func && syscall_supported_by_kernel(__NR_clock_gettime)) {
 ???? ??? func = sys_clock_gettime;
 ???? ??? tts.type = TST_KERN_OLD_TIMESPEC;
 ???? }
@@ -91,13 +91,13 @@ int tst_clock_settime(clockid_t clk_id, struct 
timespec *ts)
 ???? static mysyscall func;

 ?#if (__NR_clock_settime64 != __LTP__NR_INVALID_SYSCALL)
-??? if (!func && syscall_supported_by_kernel(sys_clock_settime64)) {
+??? if (!func && syscall_supported_by_kernel(__NR_clock_settime64)) {
 ???? ??? func = sys_clock_settime64;
 ???? ??? tts.type = TST_KERN_TIMESPEC;
 ???? }
 ?#endif

-??? if (!func && syscall_supported_by_kernel(sys_clock_settime)) {
+??? if (!func && syscall_supported_by_kernel(__NR_clock_settime)) {
 ???? ??? func = sys_clock_settime;
 ???? ??? tts.type = TST_KERN_OLD_TIMESPEC;
 ???? }


$ ./runltp -s max_map_count
...
...
Running tests.......
<<<test_start>>>
tag=max_map_count stime=1594019344
cmdline="max_map_count -i 10"
contacts=""
analysis=exit
<<<test_output>>>
incrementing stop
tst_test.c:1247: INFO: Timeout per run is 0h 05m 00s
../include/tst_timer.h:214: CONF: syscall(403) __NR_clock_gettime64 not 
supported

Summary:
passed?? 0
failed?? 0
skipped? 1
warnings 0
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=32 corefile=no
cutime=0 cstime=0
<<<test_end>>>

Is there anything I am missing here? Thanks in advance.

Regards,
Harish

On 7/4/20 12:44 PM, Li Wang wrote:
> Hi Cyril,
>
> On Fri, Jul 3, 2020 at 8:59 PM Cyril Hrubis <chrubis@suse.cz 
> <mailto:chrubis@suse.cz>> wrote:
>
>     Hi!
>     I guess that we need:
>
>
> This method works for me, plz could you correct some typos as below.
>
>
>     diff --git a/lib/tst_clocks.c b/lib/tst_clocks.c
>     index bc0bef273..c0727a34c 100644
>     --- a/lib/tst_clocks.c
>     +++ b/lib/tst_clocks.c
>     @@ -14,11 +14,11 @@
>
>     ?typedef int (*mysyscall)(clockid_t clk_id, void *ts);
>
>     -int syscall_supported_by_kernel(mysyscall func)
>     +int syscall_supported_by_kernel(long sysnr)
>     ?{
>     ? ? ? ? int ret;
>
>     -? ? ? ?ret = func(0, NULL);
>     +? ? ? ?ret = syscall(sysnr, func(0, NULL);
>
> This line should be: ret = syscall(sysnr, 0, NULL);
>
>     ? ? ? ? if (ret == -1 && errno == ENOSYS)
>     ? ? ? ? ? ? ? ? return 0;
>
>     @@ -32,13 +32,13 @@ int tst_clock_getres(clockid_t clk_id, struct
>     timespec *res)
>     ? ? ? ? int ret;
>
>     ?#if (__NR_clock_getres_time64 != __LTP__NR_INVALID_SYSCALL)
>     -? ? ? ?if (!func &&
>     syscall_supported_by_kernel(sys_clock_getres64)) {
>     +? ? ? ?if (!func &&
>     syscall_supported_by_kernel(__NR_clock_getres64)) {
>
> if (!func && syscall_supported_by_kernel(__NR_clock_getres_time64 )) {
>
>     ? ? ? ? ? ? ? ? func = sys_clock_getres64;
>     ? ? ? ? ? ? ? ? tts.type = TST_KERN_TIMESPEC;
>     ? ? ? ? }
>     ?#endif
>
>     -? ? ? ?if (!func && syscall_supported_by_kernel(sys_clock_getres)) {
>     +? ? ? ?if (!func && syscall_supported_by_kernel(__NR_clock_getres)) {
>     ? ? ? ? ? ? ? ? func = sys_clock_getres;
>     ? ? ? ? ? ? ? ? tts.type = TST_KERN_OLD_TIMESPEC;
>     ? ? ? ? }
>     @@ -62,13 +62,13 @@ int tst_clock_gettime(clockid_t clk_id, struct
>     timespec *ts)
>     ? ? ? ? int ret;
>
>     ?#if (__NR_clock_gettime64 != __LTP__NR_INVALID_SYSCALL)
>     -? ? ? ?if (!func &&
>     syscall_supported_by_kernel(sys_clock_gettime64)) {
>     +? ? ? ?if (!func &&
>     syscall_supported_by_kernel(__NR_clock_gettime64)) {
>     ? ? ? ? ? ? ? ? func = sys_clock_gettime64;
>     ? ? ? ? ? ? ? ? tts.type = TST_KERN_TIMESPEC;
>     ? ? ? ? }
>     ?#endif
>
>     -? ? ? ?if (!func && syscall_supported_by_kernel(sys_clock_gettime)) {
>     +? ? ? ?if (!func &&
>     syscall_supported_by_kernel(__NR_clock_gettime)) {
>     ? ? ? ? ? ? ? ? func = sys_clock_gettime;
>     ? ? ? ? ? ? ? ? tts.type = TST_KERN_OLD_TIMESPEC;
>     ? ? ? ? }
>     @@ -91,13 +91,13 @@ int tst_clock_settime(clockid_t clk_id, struct
>     timespec *ts)
>     ? ? ? ? static mysyscall func;
>
>     ?#if (__NR_clock_settime64 != __LTP__NR_INVALID_SYSCALL)
>     -? ? ? ?if (!func &&
>     syscall_supported_by_kernel(sys_clock_settime64)) {
>     +? ? ? ?if (!func &&
>     syscall_supported_by_kernel(__NR_clock_settime64)) {
>     ? ? ? ? ? ? ? ? func = sys_clock_settime64;
>     ? ? ? ? ? ? ? ? tts.type = TST_KERN_TIMESPEC;
>     ? ? ? ? }
>     ?#endif
>
>     -? ? ? ?if (!func && syscall_supported_by_kernel(sys_clock_settime)) {
>     +? ? ? ?if (!func &&
>     syscall_supported_by_kernel(__NR_clock_settime)) {
>     ? ? ? ? ? ? ? ? func = sys_clock_settime;
>     ? ? ? ? ? ? ? ? tts.type = TST_KERN_OLD_TIMESPEC;
>     ? ? ? ? }
>
>     -- 
>     Cyril Hrubis
>     chrubis@suse.cz <mailto:chrubis@suse.cz>
>
>
>
> -- 
> Regards,
> Li Wang
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200706/df87a1ec/attachment-0001.htm>
