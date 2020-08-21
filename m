From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Fri, 21 Aug 2020 09:18:43 +0800
Subject: [LTP] [PATCH 2/4] syscalls/kill03,
 04: Cleanup && Convert to new library
In-Reply-To: <CAEemH2eUd3yCuxt3iawHPXKUSryiJprud3HvneSr=JK_1wFhXg@mail.gmail.com>
References: <1597919168-10702-1-git-send-email-zhufy.jy@cn.fujitsu.com>
 <1597919168-10702-2-git-send-email-zhufy.jy@cn.fujitsu.com>
 <CAEemH2eUd3yCuxt3iawHPXKUSryiJprud3HvneSr=JK_1wFhXg@mail.gmail.com>
Message-ID: <43a404a1-dd4b-d091-5723-e756604fbbc8@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li


> 
> Feiyu Zhu <zhufy.jy@cn.fujitsu.com <mailto:zhufy.jy@cn.fujitsu.com>> wrote:
> 
>     ...
>     +#include <unistd.h>
>     +#include "tst_test.h"
>     +
>     +static pid_t real_pid, fake_pid, int_min_pid;
>     +static void cleanup(void);
>     +
>     +static struct tcase {
>     +? ? ? ?int test_sig;
>     +? ? ? ?int exp_errno;
>     +? ? ? ?int child_flag;
> 
> 
> The child_flag field is not necessary, we could prepare a real child in 
> setup()
> and?reclaim it after testing via check the real_pid value, that will be 
> more easily.
When I reviewed this patch in internal, I had the same idea. But when I 
try it and this case will hang because sub test will wait children 
finished by using tst_reap_childrens below:

lib/tst_test.c
static void run_tests(void)
{
	...
	 for (i = 0; i < tst_test->tcnt; i++) {
                 saved_results = *results;
                 tst_test->test(i);

                 if (getpid() != main_pid) {
                         exit(0);
                 }

                 tst_reap_children();

                 if (results_equal(&saved_results, results))
                         tst_brk(TBROK, "Test %i haven't reported 
results!", i);
         }


}

Also, we can use the current process id but it may has unexpected result 
when kill succeed. So fork a child to test maybe a better solution.
> 
> -- 
> Regards,
> Li Wang
> 
> 


