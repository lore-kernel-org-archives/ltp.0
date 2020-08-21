From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Fri, 21 Aug 2020 10:21:47 +0800
Subject: [LTP] [PATCH 2/4] syscalls/kill03,
 04: Cleanup && Convert to new library
In-Reply-To: <CAEemH2fjgYGLD0+JozNcMqv3Eo0eAwK8+BKOCo0QZihUPiP6eg@mail.gmail.com>
References: <1597919168-10702-1-git-send-email-zhufy.jy@cn.fujitsu.com>
 <1597919168-10702-2-git-send-email-zhufy.jy@cn.fujitsu.com>
 <CAEemH2eUd3yCuxt3iawHPXKUSryiJprud3HvneSr=JK_1wFhXg@mail.gmail.com>
 <43a404a1-dd4b-d091-5723-e756604fbbc8@cn.fujitsu.com>
 <CAEemH2fjgYGLD0+JozNcMqv3Eo0eAwK8+BKOCo0QZihUPiP6eg@mail.gmail.com>
Message-ID: <ebb95886-a352-ab26-2d40-8a3e2e7fa62f@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li


> 
> 
> On Fri, Aug 21, 2020 at 9:18 AM Yang Xu <xuyang2018.jy@cn.fujitsu.com 
> <mailto:xuyang2018.jy@cn.fujitsu.com>> wrote:
> 
>     Hi Li
> 
> 
>      >
>      > Feiyu Zhu <zhufy.jy@cn.fujitsu.com
>     <mailto:zhufy.jy@cn.fujitsu.com> <mailto:zhufy.jy@cn.fujitsu.com
>     <mailto:zhufy.jy@cn.fujitsu.com>>> wrote:
>      >
>      >? ? ?...
>      >? ? ?+#include <unistd.h>
>      >? ? ?+#include "tst_test.h"
>      >? ? ?+
>      >? ? ?+static pid_t real_pid, fake_pid, int_min_pid;
>      >? ? ?+static void cleanup(void);
>      >? ? ?+
>      >? ? ?+static struct tcase {
>      >? ? ?+? ? ? ?int test_sig;
>      >? ? ?+? ? ? ?int exp_errno;
>      >? ? ?+? ? ? ?int child_flag;
>      >
>      >
>      > The child_flag field is not necessary, we could prepare a real
>     child in
>      > setup()
>      > and?reclaim it after testing via check the real_pid value, that
>     will be
>      > more easily.
>     When I reviewed this patch in internal, I had the same idea. But when I
>     try it and this case will hang because sub test will wait children
>     finished by using tst_reap_childrens below:
> 
>     lib/tst_test.c
>     static void run_tests(void)
>     {
>      ? ? ? ? ...
>      ? ? ? ? ?for (i = 0; i < tst_test->tcnt; i++) {
>      ? ? ? ? ? ? ? ? ?saved_results = *results;
>      ? ? ? ? ? ? ? ? ?tst_test->test(i);
> 
>      ? ? ? ? ? ? ? ? ?if (getpid() != main_pid) {
>      ? ? ? ? ? ? ? ? ? ? ? ? ?exit(0);
>      ? ? ? ? ? ? ? ? ?}
> 
>      ? ? ? ? ? ? ? ? ?tst_reap_children();
> 
>      ? ? ? ? ? ? ? ? ?if (results_equal(&saved_results, results))
>      ? ? ? ? ? ? ? ? ? ? ? ? ?tst_brk(TBROK, "Test %i haven't reported
>     results!", i);
>      ? ? ? ? ?}
> 
> 
>     }
> 
>     Also, we can use the current process id but it may has unexpected
>     result
>     when kill succeed. So fork a child to test maybe a better solution.
> 
> 
> Hmm, sorry for the uncleared description, actually I meant, to use real_pid
> instead of the?tc->child_flag directly, then start to reclaim the child 
> when the
> real_pid test finishing.
> 
> Does this below diff work for you?
It looks well. But the real_pid only valid when the first sub test and 
the real pid is equals to 0 when using -i parameters because we have 
killed this children.

For pid = 0, it means  then sig is sent to every process in the process 
group of the calling process.  So it looks like we test different thing 
when using -i parameters.  What do you think about this?
> 
> --- a/testcases/kernel/syscalls/kill/kill03.c
> +++ b/testcases/kernel/syscalls/kill/kill03.c
> @@ -21,24 +21,17 @@ static void cleanup(void);
>  ?static struct tcase {
>  ? ? ? ? int test_sig;
>  ? ? ? ? int exp_errno;
> - ? ? ? int child_flag;
>  ? ? ? ? pid_t *pid;
>  ?} tcases[] = {
> - ? ? ? {2000, EINVAL, 1, &real_pid},
> - ? ? ? {SIGKILL, ESRCH, 0, &fake_pid},
> - ? ? ? {SIGKILL, ESRCH, 0, &int_min_pid}
> + ? ? ? {2000, EINVAL, &real_pid},
> + ? ? ? {SIGKILL, ESRCH, &fake_pid},
> + ? ? ? {SIGKILL, ESRCH, &int_min_pid}
>  ?};
> 
>  ?static void verify_kill(unsigned int n)
>  ?{
>  ? ? ? ? struct tcase *tc = &tcases[n];
> 
> - ? ? ? if (tc->child_flag) {
> - ? ? ? ? ? ? ? real_pid = SAFE_FORK();
> - ? ? ? ? ? ? ? if (!real_pid)
> - ? ? ? ? ? ? ? ? ? ? ? pause();
> - ? ? ? }
> -
>  ? ? ? ? TEST(kill(*tc->pid, tc->test_sig));
>  ? ? ? ? if (TST_RET != -1) {
>  ? ? ? ? ? ? ? ? tst_res(TFAIL, "kill should fail but not, return %ld", 
> TST_RET);
> @@ -51,14 +44,19 @@ static void verify_kill(unsigned int n)
>  ? ? ? ? ? ? ? ? tst_res(TFAIL | TTERRNO, "kill expected %s but got",
>  ? ? ? ? ? ? ? ? ? ? ? ? tst_strerrno(tc->exp_errno));
> 
> - ? ? ? if (tc->child_flag) {
> + ? ? ? if (real_pid) {
>  ? ? ? ? ? ? ? ? cleanup();
>  ? ? ? ? ? ? ? ? real_pid = 0;
>  ? ? ? ? }
> +
>  ?}
> 
>  ?static void setup(void)
>  ?{
> + ? ? ? real_pid = SAFE_FORK();
> + ? ? ? if (!real_pid)
> + ? ? ? ? ? ? ? pause();
> +
>  ? ? ? ? fake_pid = tst_get_unused_pid();
>  ? ? ? ? int_min_pid = INT_MIN;
>  ?}
> -- 
> Regards,
> Li Wang


