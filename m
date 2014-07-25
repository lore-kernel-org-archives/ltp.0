Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1XAZwj-0006tm-G8
	for ltp-list@lists.sourceforge.net; Fri, 25 Jul 2014 07:29:41 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XAZwh-0006BE-6C
	for ltp-list@lists.sourceforge.net; Fri, 25 Jul 2014 07:29:41 +0000
Message-ID: <53D20734.2070500@cn.fujitsu.com>
Date: Fri, 25 Jul 2014 15:28:52 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
References: <53D1ED3D.2070907@cn.fujitsu.com>
	<2004760862.15127357.1406271918376.JavaMail.zimbra@redhat.com>
In-Reply-To: <2004760862.15127357.1406271918376.JavaMail.zimbra@redhat.com>
Subject: Re: [LTP] Segmentation fault when running sched_setaffinity01 in
	RHEL5.10GA
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
To: Jan Stancek <jstancek@redhat.com>
Cc: LTP <ltp-list@lists.sourceforge.net>

Hi Jan,

On 07/25/2014 03:05 PM, Jan Stancek wrote:
> 
> 
> ----- Original Message -----
>> From: "Xiaoguang Wang" <wangxg.fnst@cn.fujitsu.com>
>> To: "LTP" <ltp-list@lists.sourceforge.net>
>> Cc: "Jan Stancek" <jstancek@redhat.com>
>> Sent: Friday, 25 July, 2014 7:38:05 AM
>> Subject: Segmentation fault when running sched_setaffinity01  in RHEL5.10GA
>>
>> Hi,
>>
>> When we run sched_setaffinity01 in RHEL5.10GA, it occurs a segmentation
>> fault.
>> Below is the possible reason.
>>
>> Hi Jan, would you please help to confirm this problem. I'm afraid RHEL5.10GA
>> is an old
>> distribution, which many people may not use it now, thanks!
> 
> Hi,
> 
> RHEL5.10 GA was January 2013, it's an older codebase, but release is quite recent.
> 
> I ran this on RHEL5.3:
> 
> (gdb) r
> Starting program: /root/ltp/testcases/kernel/syscalls/sched_setaffinity/sched_setaffinity01 
> Detaching after fork from child process 7692.
> 
> Program received signal SIGSEGV, Segmentation fault.
> __sched_setaffinity_new (pid=<value optimized out>, cpusetsize=<value optimized out>, cpuset=<value optimized out>)
>     at ../sysdeps/unix/sysv/linux/sched_setaffinity.c:62
> 62	    if (((char *) cpuset)[cnt] != '\0')
> (gdb) list
> 57	    }
> 58	
> 59	  /* We now know the size of the kernel cpumask_t.  Make sure the user
> 60	     does not request to set a bit beyond that.  */
> 61	  for (size_t cnt = __kernel_cpumask_size; cnt < cpusetsize; ++cnt)
> 62	    if (((char *) cpuset)[cnt] != '\0')
> 63	      {
> 64	        /* Found a nonzero byte.  This means the user request cannot be
> 65		   fulfilled.  */
> 66		__set_errno (EINVAL);
> (gdb) p __kernel_cpumask_size
> $1 = 32
> (gdb) p cpusetsize
> $2 = <value optimized out>
> 
> 
> Looking at sources of glibc-2.5 (RHEL5.10) and glibc-2.17 (RHEL7), code leading
> up to this place looks identical. So, I agree with your findings. I see 2 options:
> 
> 1) find cpuset size in same way as glibc does it
> 
> 2) call syscall directly (and don't use glibc wrapper):
> 
> diff --git a/testcases/kernel/syscalls/sched_setaffinity/sched_setaffinity01.c b/testcases/kernel/syscalls/sched_setaffinity/sched_setaffinity01.c
> index 0ac4478..0c0488f 100644
> --- a/testcases/kernel/syscalls/sched_setaffinity/sched_setaffinity01.c
> +++ b/testcases/kernel/syscalls/sched_setaffinity/sched_setaffinity01.c
> @@ -42,6 +42,7 @@
>  #include "usctest.h"
>  #include "safe_macros.h"
>  #include "sched_setaffinity.h"
> +#include "linux_syscall_numbers.h"
>  
>  char *TCID = "sched_setaffinity01";
>  
> @@ -151,7 +152,7 @@ int main(int argc, char *argv[])
>         for (lc = 0; TEST_LOOPING(lc); lc++) {
>                 tst_count = 0;
>                 for (i = 0; i < TST_TOTAL; i++) {
> -                       TEST(sched_setaffinity(*(test_cases[i].pid),
> +                       TEST(ltp_syscall(__NR_sched_setaffinity, *(test_cases[i].pid),
>                                                 *(test_cases[i].mask_size),
>                                                 *(test_cases[i].mask)));
> 
> 

Thanks very much for your quick response, cool.
Using syscall directly would be OK, but we should also add a note to later reader explaining why we do not use glibc wrapper.

Regards,
Xiaoguang Wang

> # ./sched_setaffinity01 
> sched_setaffinity01    1  TPASS  :  expected failure with 'Bad address'
> sched_setaffinity01    2  TPASS  :  expected failure with 'Invalid argument'
> sched_setaffinity01    3  TPASS  :  expected failure with 'No such process'
> sched_setaffinity01    4  TPASS  :  expected failure with 'Operation not permitted'
> 
> # uname -r
> 2.6.18-128.37.1.el5
> 
> Regards,
> Jan
> 
>>
>>
>> Glibc provides a encapsulation for the raw kernel sched_setaffinity(2) system
>> call,
>> the corresponding code is below(The version of glibc I used is
>> glibc-2.5-20061008T1257-RHEL5.11Beta):
>> I delete some code just for simple.
>>
>> #######################################################################################
>>
>> /* Size definition for CPU sets.  */
>> # define __CPU_SETSIZE  1024
>> # define __NCPUBITS     (8 * sizeof (__cpu_mask))
>>
>> /* Type for array elements in 'cpu_set'.  */
>> typedef unsigned long int __cpu_mask;
>>
>> /* Basic access functions.  */
>> # define __CPUELT(cpu)  ((cpu) / __NCPUBITS)
>>
>> /* Data structure to describe CPU mask.  */
>> typedef struct
>> {
>>   __cpu_mask __bits[__CPU_SETSIZE / __NCPUBITS];
>> } cpu_set_t;
>>
>>
>> int __sched_setaffinity_new (pid_t pid, size_t cpusetsize, const cpu_set_t
>> *cpuset)
>> {
>>   if (__builtin_expect (__kernel_cpumask_size == 0, 0))
>>     {
>>       int res;
>>
>>       while (res = INTERNAL_SYSCALL (sched_getaffinity, err, 3, getpid (),
>>                                      psize, p),
>>              INTERNAL_SYSCALL_ERROR_P (res, err)
>>              && INTERNAL_SYSCALL_ERRNO (res, err) == EINVAL)
>>      	....
>>
>>       __kernel_cpumask_size = res;
>>     }
>>
>>   /* We now know the size of the kernel cpumask_t.  Make sure the user
>>      does not request to set a bit beyond that.  */
>>   for (size_t cnt = __kernel_cpumask_size; cnt < cpusetsize; ++cnt)
>>     if (((char *) cpuset)[cnt] != '\0')
>>       {
>>         /* Found a nonzero byte.  This means the user request cannot be
>>            fulfilled.  */
>>         __set_errno (EINVAL);
>>         return -1;
>>       }
>>
>>   return INLINE_SYSCALL (sched_setaffinity, 3, pid, cpusetsize, cpuset);
>> }
>> #######################################################################################
>>
>> Glibc in RHEL5.10GA does not provide CPU_ALLOC_SIZE marco, so in ltp
>> testcases/kernel/syscalls/sched_setaffinity/sched_setaffinity.h,
>> we define one.
>> #######################################################################################
>> #ifndef CPU_ALLOC_SIZE
>> #define CPU_ALLOC_SIZE(size) sizeof(cpu_set_t)
>> #endif
>> #######################################################################################
>>
>> Then CPU_ALLOC_SIZE would always return 128 in RHEL5.10GA, that is when we
>> test EFAULT for sched_setaffinity(2),
>> the passed cpusetsize is 128. But look at __sched_setaffinity_new() above, it
>> first call
>> raw sched_getaffinity(2) to get  the size of the kernel cpumask_t, In
>> RHEL5.10GA,
>> this value depends on CONFIG_NR_CPUS, if CONFIG_NR_CPUS is 255, the raw
>> sched_getaffinity(2) will return 32.
>> In this case, __kernel_cpumask_size would be 32, cpusetsize is 128. Give that
>> we're testing
>> EFAULT, cpuset is a invalid pointer, if cnt > 32, it will generate
>> segmentation fault in glibc code,
>> so this case exits abnormally
>>
>> As why this test case can run normally in RHEL6.5GA or RHEL7.0GA, it's
>> because
>> sched_getaffinity(2) in old kernel(RHEL5.10GA) return sizeof(cpumask_t),
>> which totally depends on CONFIG_NR_CPUS.
>> In newer kernel, sched_getaffinity(2) returns the smaller one between
>> min_t(size_t, len, cpumask_size()),
>> here len is the value passed to sched_getaffinity as cpusetsize,
>> cpumask_size() is the max allowed length.
>> so we can ensure __kernel_cpumask_size will never smaller cpusetsize, so the
>> segmentation fault won't occur.
>>
>> So I also think CPU_ALLOC and CPU_ALLOC_SIZE is wrong in
>> testcases/kernel/syscalls/sched_setaffinity/sched_setaffinity.h. We should
>> refer to the implementation in glibc. or we define CPU_ALLOC_SIZE using raw
>> sched_getaffinity as a workaround in older kernel . See below code:
>> #########################################################################################
>>
>>         int ret;
>>         cpu_set_t cst;
>>
>>         memset(&cst, 0, sizeof(cst));
>>
>>         ret = syscall(__NR_sched_getaffinity, getpid(),
>>                       sizeof(cpu_set_t), &cst);
>>         if (ret < 0) {
>>                 fprintf(stderr, "sched_getaffinity failed: %s\n",
>>                         strerror(errno));
>>                 return 1;
>>         } else {
>>                 printf("length of bit mask the kernel uses to represent the
>>                 CPU"
>>                        ": %d\n", ret);
>>         }
>> #########################################################################################
>>
>> Regards,
>> Xiaoguang Wang
>>
> .
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
