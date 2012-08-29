Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <shuang.qiu@oracle.com>) id 1T6dKm-0007SM-S9
	for ltp-list@lists.sourceforge.net; Wed, 29 Aug 2012 08:09:08 +0000
Received: from acsinet15.oracle.com ([141.146.126.227])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1T6dKh-0002RX-Ft
	for ltp-list@lists.sourceforge.net; Wed, 29 Aug 2012 08:09:08 +0000
Message-ID: <503DCE12.2000707@oracle.com>
Date: Wed, 29 Aug 2012 16:08:50 +0800
From: Shuang Qiu <shuang.qiu@oracle.com>
MIME-Version: 1.0
References: <1768335107.59483055.1346044605729.JavaMail.root@redhat.com>
	<503C36CC.20201@oracle.com> <503CBEBF.2040101@redhat.com>
In-Reply-To: <503CBEBF.2040101@redhat.com>
Subject: Re: [LTP] [PATCH] Set tunable value of min_free_kbytes lower
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
To: ZhouPing Liu <zliu@redhat.com>
Cc: ltp-list@lists.sourceforge.net

On 08/28/2012 08:51 PM, ZhouPing Liu wrote:
> On 08/28/2012 11:11 AM, Shuang Qiu wrote:
>> On 08/27/2012 01:16 PM, Zhouping Liu wrote:
>>>
>>> ----- Original Message -----
>>> For the issue that min_free_kbytes caused system hang, I prepared a 
>>> patch for it,
>>> at the same time, in order to enlarge the case's coverage, I add a 
>>> new case(2x default_tune)
>>> I have tested it in my box, it's good.
>>>
>>> Shuang, can you review and test the patch?
>>>
>>> diff --git a/testcases/kernel/mem/tunable/min_free_kbytes.c 
>>> b/testcases/kernel/mem/tunable/min_free_kbytes.c
>>> index 00ead04..ded0e45 100644
>>> --- a/testcases/kernel/mem/tunable/min_free_kbytes.c
>>> +++ b/testcases/kernel/mem/tunable/min_free_kbytes.c
>>> @@ -10,7 +10,8 @@
>>>    * the current free memory with the tunable value repeatedly.
>>>    *
>>>    * a) default min_free_kbytes with all overcommit memory policy
>>> - * b) half of mem_free with all overcommit memory policy
>>> + * b) 2x default value with all overcommit memory policy
>>> + * c) 10% of MemFree or %5 MemTotal with all overcommit memory policy
>>>    *
>>> ********************************************************************
>>>    * Copyright (C) 2012 Red Hat, Inc.
>>> @@ -115,20 +116,27 @@ int main(int argc, char *argv[])
>>>   static void test_tune(unsigned long overcommit_policy)
>>>   {
>>>          int status;
>>> -       int pid[2];
>>> +       int pid[3];
>>>          int ret, i;
>>> -       unsigned long tune, memfree;
>>> +       unsigned long tune, memfree, memtotal;
>>>            set_sys_tune("overcommit_memory", overcommit_policy, 1);
>>>   -       for (i = 0; i < 2; i++) {
>>> +       for (i = 0; i < 3; i++) {
>>>                  /* case1 */
>>>                  if (i == 0)
>>>                          set_sys_tune("min_free_kbytes", 
>>> default_tune, 1);
>>>                  /* case2 */
>>> -               else {
>>> +               else if (i == 1) {
>>> +                       set_sys_tune("min_free_kbytes", 2 * 
>>> default_tune, 1);
>>> +               /* case3 */
>>> +               } else {
>>>                          memfree = read_meminfo("MemFree:");
>>> -                       tune = memfree / 2;
>>> +                       memtotal = read_meminfo("MemTotal:");
>>> +                       tune = memfree / 10;
>>> +                       if (tune > (memtotal / 20))
>>> +                               tune = memtotal / 20;
>>> +
>>>                          set_sys_tune("min_free_kbytes", tune, 1);
>>>                  }
>> Hi Zhouping,
>> I have tested this patch,it works.
>>
>> But I found another problem with this case that it is not work 
>> expectedly with the scenario that i386 system(PAE kernel) which has 
>> >4GB memory.
>> i.e. In i386 system with 7GB free memory,it could only eat about 3GB 
>> memory in one mem-hog fork process.
>
> yes, you are right.
> I tried to fork several processes to hog memory, but I don't think 
> it's a better way, so a good solution(I think) is included in below 
> patch.
>
>>
>> And we can also patch the overflow issue which I mentioned before:
>>
>> The type of total_mem "unsigned long" is not suitable with nowadays
>> memory ,it will overflow(with i386) in line 177:map_count = total_mem
>> *
>> KB / MAP_SIZE and the value of map_count is not correct.
>> Using "unsigned long long" could fix this issue.
>
> after re-check the code, I found map_count was not necessary, so I 
> removed it,
> at the same time, it fixed your the overflow issue.
>
> please review the patch again, if you agree the fix, I will send a 
> formal patch set in new subject:
>
> diff --git a/testcases/kernel/mem/tunable/min_free_kbytes.c 
> b/testcases/kernel/mem/tunable/min_free_kbytes.c
> index ded0e45..af25597 100644
> --- a/testcases/kernel/mem/tunable/min_free_kbytes.c
> +++ b/testcases/kernel/mem/tunable/min_free_kbytes.c
> @@ -158,8 +158,18 @@ static void test_tune(unsigned long 
> overcommit_policy)
>                                     "child unexpectedly failed: %d", 
> status);
>                 } else if (overcommit_policy == 1) {
>                         if (!WIFSIGNALED(status) || WTERMSIG(status) 
> != SIGKILL)
> +                       {
> +#if __WORDSIZE == 32
> +                               if (total_mem < 3145728UL)
> +#endif
>                                 tst_resm(TFAIL,
>                                     "child unexpectedly failed: %d", 
> status);
> +#if __WORDSIZE == 32
> +                               else
> +                                       tst_resm(TINFO, "Child can't 
> allocate "
> +                                           ">3Gb memory in 32bit 
> system");
> +#endif
> +                       }
>                 } else {
>                         if (WIFEXITED(status)) {
>                                 if (WEXITSTATUS(status) != 0) {
> @@ -177,31 +187,23 @@ static void test_tune(unsigned long 
> overcommit_policy)
>
>  static int eatup_mem(unsigned long overcommit_policy)
>  {
> -       int map_count, i;
>         int ret = 0;
>         unsigned long memfree;
> -       void **addrs;
> -
> -       map_count = total_mem * KB / MAP_SIZE;
> -       addrs = (void **)malloc(map_count * sizeof(void *));
> -       if (addrs == NULL) {
> -               perror("malloc");
> -               return -1;
> -       }
> +       void *addrs;
>
>         memfree = read_meminfo("MemFree:");
>         printf("memfree is %lu kB before eatup mem\n", memfree);
> -       for (i = 0; i < map_count; i++) {
> -               addrs[i] = mmap(NULL, MAP_SIZE, PROT_READ|PROT_WRITE,
> +       while (1) {
> +               addrs = mmap(NULL, MAP_SIZE, PROT_READ|PROT_WRITE,
>                     MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
> -               if (addrs[i] == MAP_FAILED) {
> +               if (addrs == MAP_FAILED) {
>                         if (overcommit_policy != 1 && errno != ENOMEM) {
>                                 perror("mmap");
>                                 ret = -1;
>                         }
>                         break;
>                 }
> -               memset(addrs[i], i, MAP_SIZE);
> +               memset(addrs, 1, MAP_SIZE);
>         }
>         memfree = read_meminfo("MemFree:");
>         printf("memfree is %lu kB after eatup mem\n", memfree);
>
I agree the fix and it works fine.

Thanks
Shuang
> Thanks,
> Zhouping



------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
