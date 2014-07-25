Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1XAayb-0001aI-Uf
	for ltp-list@lists.sourceforge.net; Fri, 25 Jul 2014 08:35:42 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XAaya-0001Nc-Ux
	for ltp-list@lists.sourceforge.net; Fri, 25 Jul 2014 08:35:41 +0000
Message-ID: <53D216D0.6010706@oracle.com>
Date: Fri, 25 Jul 2014 12:35:28 +0400
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
References: <428ab3048d90dc9d998143aea2b2a624b43d5220.1406276230.git.jstancek@redhat.com>
In-Reply-To: <428ab3048d90dc9d998143aea2b2a624b43d5220.1406276230.git.jstancek@redhat.com>
Subject: Re: [LTP] [PATCH] sched_setaffinity01: use ltp_syscall
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Jan Stancek <jstancek@redhat.com>, ltp-list@lists.sourceforge.net



On 07/25/2014 12:18 PM, Jan Stancek wrote:
> Using glibc wrapper on kernel with smaller CONFIG_NR_CPUS (for example
> 255) leads to segmentation fault in glibc, because it triggers check,
> which is verifying that there are no bits set beyond size of kernel cpu
> mask:
>
> int
> __sched_setaffinity_new (pid_t pid, size_t cpusetsize, const cpu_set_t *cpuset)
>    ...
>    /* We now know the size of the kernel cpumask_t.  Make sure the user
>       does not request to set a bit beyond that.  */
>    for (size_t cnt = __kernel_cpumask_size; cnt < cpusetsize; ++cnt)
>      if (((char *) cpuset)[cnt] != '\0') --> CRASH HERE
>
> Call this syscall directly with ltp_syscall().
>
> Reported-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
> Signed-off-by: Jan Stancek <jstancek@redhat.com>

Acked-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>


> ---
>   .../sched_setaffinity/sched_setaffinity01.c        |   11 ++++++++---
>   1 files changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/sched_setaffinity/sched_setaffinity01.c b/testcases/kernel/syscalls/sched_setaffinity/sched_setaffinity01.c
> index 0ac4478..33a90b8 100644
> --- a/testcases/kernel/syscalls/sched_setaffinity/sched_setaffinity01.c
> +++ b/testcases/kernel/syscalls/sched_setaffinity/sched_setaffinity01.c
> @@ -42,6 +42,7 @@
>   #include "usctest.h"
>   #include "safe_macros.h"
>   #include "sched_setaffinity.h"
> +#include "linux_syscall_numbers.h"
>
>   char *TCID = "sched_setaffinity01";
>
> @@ -151,9 +152,13 @@ int main(int argc, char *argv[])
>   	for (lc = 0; TEST_LOOPING(lc); lc++) {
>   		tst_count = 0;
>   		for (i = 0; i < TST_TOTAL; i++) {
> -			TEST(sched_setaffinity(*(test_cases[i].pid),
> -						*(test_cases[i].mask_size),
> -						*(test_cases[i].mask)));
> +			/* Avoid calling glibc wrapper function, as it may
> +			 * try to read/validate data in cpu mask. This test
> +			 * is passing invalid pointer on purpose. */
> +			TEST(ltp_syscall(__NR_sched_setaffinity,
> +				*(test_cases[i].pid),
> +				*(test_cases[i].mask_size),
> +				*(test_cases[i].mask)));
>
>   			if (TEST_RETURN != -1)
>   				tst_resm(TFAIL,
>

------------------------------------------------------------------------------
Want fast and easy access to all the code in your enterprise? Index and
search up to 200,000 lines of code with a free copy of Black Duck
Code Sight - the same software that powers the world's largest code
search on Ohloh, the Black Duck Open Hub! Try it now.
http://p.sf.net/sfu/bds
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
