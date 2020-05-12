From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Tue, 12 May 2020 22:32:22 +0800
Subject: [LTP] [PATCH 2/2] syscalls/pidfd_open*.c: Drop .min_kver flag
In-Reply-To: <c63909b8-a666-bf56-c747-78eff8c138b3@163.com>
References: <20200430085742.1663-1-yangx.jy@cn.fujitsu.com>
 <20200430085742.1663-2-yangx.jy@cn.fujitsu.com>
 <20200504051107.edvfiqloegt3ak5o@vireshk-i7>
 <b74eac89-11fc-9a7c-c337-ffe6f19ec7b8@163.com>
 <20200505033507.oerhoby6aif3leea@vireshk-i7>
 <c63909b8-a666-bf56-c747-78eff8c138b3@163.com>
Message-ID: <5EBAB376.4030804@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2020/5/5 17:30, Xiao Yang wrote:
>>>>>        TST_CHECKPOINT_WAKE(0);
>>>>> @@ -49,8 +47,14 @@ static void run(void)
>>>>>            tst_res(TPASS, "pidfd_open() passed");
>>>>>    }
>>>>> +static void setup(void)
>>>>> +{
>>>>> +    // Check if pidfd_open(2) is not supported
>>>>> +    tst_syscall(__NR_pidfd_open, -1, 0);
>>>>> +}
>>>>> +
>>>>>    static struct tst_test test = {
>>>>> -    .min_kver = "5.3",
>>>>> +    .setup = setup,
>>>>>        .test_all = run,
>>>>>        .forks_child = 1,
>>>>>        .needs_checkpoints = 1,
>>>> Please have a look at fsopen_supported_by_kernel() in lapi/fsmount.h
>>>> and make such a helper.
>>> First, I want to explain my check point:
>>>
>>> Passing invalid argument can check the support of pidfd_open(2) by
>>> ENOSYS
>>> errno and we don't need to close the pidfd.
>>>
>>> Second, I don't like the implementation of
>>> fsopen_supported_by_kernel() and
>>> give some suggestions:
>>>
>>> a) syscall()/tst_syscall() is enough to check the support of
>>> pidfd_open(2)
>>> and 'tst_kvercmp(5, 2, 0)) < 0' will skip the check
>>>
>>>      if a kernel on distribution is newer than v5.2 but drop the
>>> support of
>>> pidfd_open(2) on purpose.
>> I don't think kernel can drop support of syscalls just like that, we
>> can't break user space. And if that is done, we need to fix userspace
>> again separately for that.
>
> Hi Viresh,
>
> It is just a possible situation? for example:
>
> Upstream kernel introduces btrfs filesystem long long ago but the kernel
>
> of RHEL8 drops btrfs filesystem because of some reasons.
>
>>
>> We came to the implementation of fsopen_supported_by_kernel() after a
>> lot of reviews and decided on that and so I asked you for the sake of
>> keeping similar code throughout LTP (of course there will be old
>> usages which are different) to have a similar implementation.
>>
>> Anyway, I will leave it to Cyril to decide on that :)
>
> Hi Cyril,
>
> Do you have any comment on the implementation of
> fsopen_supported_by_kernel() and
>
> my check point(i.e. check the support of pidfd_open(2) by passing
> invalid argument ).
Hi Cyril,

Do you have comment on the support check of 
pidfd_open()/fsopen_supported_by_kernel()?

Thank you in advance.

Best Regards,
Xiao Yang



