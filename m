Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1XAaHU-0007Ul-4o
	for ltp-list@lists.sourceforge.net; Fri, 25 Jul 2014 07:51:08 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XAaHS-0000yh-SD
	for ltp-list@lists.sourceforge.net; Fri, 25 Jul 2014 07:51:08 +0000
Message-ID: <53D20C5B.10702@oracle.com>
Date: Fri, 25 Jul 2014 11:50:51 +0400
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
References: <53D1ED3D.2070907@cn.fujitsu.com> <53D1FBB3.1030601@oracle.com>
	<53D20804.4050909@cn.fujitsu.com>
In-Reply-To: <53D20804.4050909@cn.fujitsu.com>
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
To: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Cc: LTP <ltp-list@lists.sourceforge.net>



On 07/25/2014 11:32 AM, Xiaoguang Wang wrote:
> Hi,
>
> On 07/25/2014 02:39 PM, Stanislav Kholmanskikh wrote:
>>
>>
>> On 07/25/2014 09:38 AM, Xiaoguang Wang wrote:
>>> Hi,
>>>
>>> When we run sched_setaffinity01 in RHEL5.10GA, it occurs a segmentation fault.
>>> Below is the possible reason.
>>
>> Hi!
>>
>> I though I'd checked this test case on OL5 before submission. Let me check it again.
>
> OL5 is based RHEL5?
Yes.
> If it is, please also check your CONFIG_NR_CPUS in kernel config file. If it's 1024 or greater,
> this case will not fail. In my environment, this value is 255, thanks!

I initially tested it with 2.6.39-400.212.1.el5uek on OL5, and it passed.
[root@ol5-x64 sched_setaffinity]# grep CONFIG_NR_CPUS 
/boot/config-2.6.39-400.212.1.el5uek.debug
CONFIG_NR_CPUS=4096

Now I checked it with 2.6.18-371.3.1.0.1.el5 and it failed as you said:
[root@ol5-x64 sched_setaffinity]# grep CONFIG_NR_CPUS 
/boot/config-2.6.18-371.3.1.0.1.el5
CONFIG_NR_CPUS=255

Thanks for your findings.

I would also vote for the ltp_syscall(__NR_sched_setaffinity, ...) 
variant proposed by Jan.


>
> Regards,
> Xiaoguang Wang
>>
>>>
>>> Hi Jan, would you please help to confirm this problem. I'm afraid RHEL5.10GA is an old
>>> distribution, which many people may not use it now, thanks!
>>>
>>>
>>> Glibc provides a encapsulation for the raw kernel sched_setaffinity(2) system call,
>>> the corresponding code is below(The version of glibc I used is glibc-2.5-20061008T1257-RHEL5.11Beta):
>>> I delete some code just for simple.
>>>
>>> #######################################################################################
>>>
>>> /* Size definition for CPU sets.  */
>>> # define __CPU_SETSIZE  1024
>>> # define __NCPUBITS     (8 * sizeof (__cpu_mask))
>>>
>>> /* Type for array elements in 'cpu_set'.  */
>>> typedef unsigned long int __cpu_mask;
>>>
>>> /* Basic access functions.  */
>>> # define __CPUELT(cpu)  ((cpu) / __NCPUBITS)
>>>
>>> /* Data structure to describe CPU mask.  */
>>> typedef struct
>>> {
>>>     __cpu_mask __bits[__CPU_SETSIZE / __NCPUBITS];
>>> } cpu_set_t;
>>>
>>>
>>> int __sched_setaffinity_new (pid_t pid, size_t cpusetsize, const cpu_set_t *cpuset)
>>> {
>>>     if (__builtin_expect (__kernel_cpumask_size == 0, 0))
>>>       {
>>>         int res;
>>>
>>>         while (res = INTERNAL_SYSCALL (sched_getaffinity, err, 3, getpid (),
>>>                                        psize, p),
>>>                INTERNAL_SYSCALL_ERROR_P (res, err)
>>>                && INTERNAL_SYSCALL_ERRNO (res, err) == EINVAL)
>>>            ....
>>>
>>>         __kernel_cpumask_size = res;
>>>       }
>>>
>>>     /* We now know the size of the kernel cpumask_t.  Make sure the user
>>>        does not request to set a bit beyond that.  */
>>>     for (size_t cnt = __kernel_cpumask_size; cnt < cpusetsize; ++cnt)
>>>       if (((char *) cpuset)[cnt] != '\0')
>>>         {
>>>           /* Found a nonzero byte.  This means the user request cannot be
>>>              fulfilled.  */
>>>           __set_errno (EINVAL);
>>>           return -1;
>>>         }
>>>
>>>     return INLINE_SYSCALL (sched_setaffinity, 3, pid, cpusetsize, cpuset);
>>> }
>>> #######################################################################################
>>>
>>> Glibc in RHEL5.10GA does not provide CPU_ALLOC_SIZE marco, so in ltp testcases/kernel/syscalls/sched_setaffinity/sched_setaffinity.h,
>>> we define one.
>>> #######################################################################################
>>> #ifndef CPU_ALLOC_SIZE
>>> #define CPU_ALLOC_SIZE(size) sizeof(cpu_set_t)
>>> #endif
>>> #######################################################################################
>>>
>>> Then CPU_ALLOC_SIZE would always return 128 in RHEL5.10GA, that is when we test EFAULT for sched_setaffinity(2),
>>> the passed cpusetsize is 128. But look at __sched_setaffinity_new() above, it first call
>>> raw sched_getaffinity(2) to get  the size of the kernel cpumask_t, In RHEL5.10GA,
>>> this value depends on CONFIG_NR_CPUS, if CONFIG_NR_CPUS is 255, the raw sched_getaffinity(2) will return 32.
>>> In this case, __kernel_cpumask_size would be 32, cpusetsize is 128. Give that we're testing
>>> EFAULT, cpuset is a invalid pointer, if cnt > 32, it will generate segmentation fault in glibc code,
>>> so this case exits abnormally
>>>
>>> As why this test case can run normally in RHEL6.5GA or RHEL7.0GA, it's because
>>> sched_getaffinity(2) in old kernel(RHEL5.10GA) return sizeof(cpumask_t), which totally depends on CONFIG_NR_CPUS.
>>> In newer kernel, sched_getaffinity(2) returns the smaller one between min_t(size_t, len, cpumask_size()),
>>> here len is the value passed to sched_getaffinity as cpusetsize, cpumask_size() is the max allowed length.
>>> so we can ensure __kernel_cpumask_size will never smaller cpusetsize, so the segmentation fault won't occur.
>>>
>>> So I also think CPU_ALLOC and CPU_ALLOC_SIZE is wrong in testcases/kernel/syscalls/sched_setaffinity/sched_setaffinity.h. We should
>>> refer to the implementation in glibc. or we define CPU_ALLOC_SIZE using raw sched_getaffinity as a workaround in older kernel . See below code:
>>> #########################################################################################
>>>
>>>           int ret;
>>>           cpu_set_t cst;
>>>
>>>           memset(&cst, 0, sizeof(cst));
>>>
>>>           ret = syscall(__NR_sched_getaffinity, getpid(),
>>>                         sizeof(cpu_set_t), &cst);
>>>           if (ret < 0) {
>>>                   fprintf(stderr, "sched_getaffinity failed: %s\n",
>>>                           strerror(errno));
>>>                   return 1;
>>>           } else {
>>>                   printf("length of bit mask the kernel uses to represent the CPU"
>>>                          ": %d\n", ret);
>>>           }
>>> #########################################################################################
>>>
>>> Regards,
>>> Xiaoguang Wang
>>>
>>> ------------------------------------------------------------------------------
>>> Want fast and easy access to all the code in your enterprise? Index and
>>> search up to 200,000 lines of code with a free copy of Black Duck
>>> Code Sight - the same software that powers the world's largest code
>>> search on Ohloh, the Black Duck Open Hub! Try it now.
>>> http://p.sf.net/sfu/bds
>>> _______________________________________________
>>> Ltp-list mailing list
>>> Ltp-list@lists.sourceforge.net
>>> https://lists.sourceforge.net/lists/listinfo/ltp-list
>>>
>> .
>>
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
