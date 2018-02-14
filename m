From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Wed, 14 Feb 2018 15:34:50 +0800
Subject: [LTP] [PATCH] syscalls/mmap17.c: Add new regression test
In-Reply-To: <1544687918.1306598.1518385631571.JavaMail.zimbra@redhat.com>
References: <1517565794-1769-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <1069626938.5781132.1517566821086.JavaMail.zimbra@redhat.com>
 <5A7835B2.9030406@cn.fujitsu.com>
 <940714833.169417.1517830921395.JavaMail.zimbra@redhat.com>
 <5A794E19.3000201@cn.fujitsu.com>
 <195340110.511328.1517946794955.JavaMail.zimbra@redhat.com>
 <1808841957.523089.1517951700941.JavaMail.zimbra@redhat.com>
 <5A7AEB8A.90509@cn.fujitsu.com>
 <1544687918.1306598.1518385631571.JavaMail.zimbra@redhat.com>
Message-ID: <5A83E69A.6070306@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi Cyril,

What do you think of this test? :-)

Thanks,
Xiao Yang
于 2018/02/12 5:47, Jan Stancek 写道:
> ----- Original Message -----
>> On 2018/02/07 5:15, Jan Stancek wrote:
>>> ----- Original Message -----
>>>> ----- Original Message -----
>>>>>> The patch you referenced is x86 specific, so we can restrict the test to
>>>>>> x86.
>>>>>> Also please set the minimum kernel version this is expected to fail on.
>>>>> 1) Before commit c64b04f, we couldn't read phys_addr_bits from
>>>>> /proc/cpuinfo in 32-bit kernel on x86.
>>>>> 2) On non-x86 architectures, we couldn't read phys_addr_bits from
>>>>> /proc/cpuinfo as well.
>>>>>
>>>>> According to above reasons, i perfer to check phys_addr_bits in
>>>>> /proc/cpuinfo rather than the minimum
>>>>> kernel version and x86 architecture.   We can skip this test if
>>>>> phys_addr_bits isn't available.
>>>> I was referring to kernel patch. Does it make sense for this test
>>>> to run on older kernels? Based on description it might crash, so
>>>> presumably yes.
>>> Though you need to be root and write to /dev/mem - which seems
>>> like very rare use-case.
>>>
>>>> But do we also want to report FAIL on older kernels if mmap succeeds?
>>>> That does not violate any docs.
>>>>
>>>>> addr[0] = 'a';
>>>> If mmap works, this has potential of triggering signal,
>>>> which will lead to TBROK.
>>> older kernels with lot of DEBUG options can survive:
>>>
>>> # uname -r
>>> 3.10.0-810.el7.x86_64.debug
>>>
>>> # ./mmap17
>>> tst_test.c:980: INFO: Timeout per run is 0h 05m 00s
>>> a1
>>> tst_test.c:1020: INFO: If you are running on slow machine, try exporting
>>> LTP_TIMEOUT_MUL>   1
>>> tst_test.c:1021: BROK: Test killed! (timeout?)
>>>
>>> Summary:
>>> passed   0
>>> failed   0
>>> skipped  0
>>> warnings 0
>>>
>>> I'd limit it to 4.14 and later - I'm assuming most people won't care
>>> about this bug and we can ignore all outcomes from older kernels.
>>> What do you think?
>> Hi Jan,
>>
>> Thanks for your comment.  :-)
>>
>> With 3.10.0-830.el7.x86_64 and 2.6.32-696.el6.x86_64, this case can trigger a
>> crash easily,
>> so i want to run it on older kernels.  But, we can ignore all outcomes from
>> older kernels
>> as you said.
>>
>> If an invalid physical address was refused by mmap() or didn't trigger a
>> crash, can we think
>> the bug didn't exist due to some protection mechanisms?
> That or it corrupted different place in memory. Or somebody backported
> a patch to older kernel that changes behaviour in some other way.
>
>> Please see the following code:
> That should work, though it still feels to me like test for
> very unusual corner-case. I'd be interested to hear what
> other people think.
>
> Regards,
> Jan
>
>> --------------------------------------------------------------------
>> static void verify_mmap(void)
>> {
>>           char *addr;
>>
>>           addr = mmap(NULL, 1, PROT_READ | PROT_WRITE, MAP_SHARED, fd,
>>           1ULL<<phys_addr_bits);
>>           if (addr == MAP_FAILED)
>>                   exit(0);
>>
>>           addr[0] = 'a';
>>           SAFE_MUNMAP(addr, 1);
>>           exit(1);
>> }
>>
>> static void do_mmap(void)
>> {
>>           pid_t pid;
>>           int status;
>>
>>           pid = SAFE_FORK();
>>           if (!pid)
>>                   verify_mmap();
>>
>>           SAFE_WAITPID(pid,&status, 0);
>>           if (WIFEXITED(status)&&   !WEXITSTATUS(status))
>>                   tst_res(TPASS, "Refused to map invalid physical address");
>>           else
>>                   tst_res(TPASS, "Mapped invalid physical address didn't
>>                   trigger a crash");
>> }
>> --------------------------------------------------------------------
>>
>> Thanks,
>> Xiao Yang
>>
>>> Regards,
>>> Jan
>>>
>>>
>>>
>>
>>
>>
>
> .
>



