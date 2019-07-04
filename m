From: Hongzhi, Song <hongzhi.song@windriver.com>
Date: Thu, 4 Jul 2019 09:56:03 +0800
Subject: [LTP] Bug Report: diotest4 fails on mips64
In-Reply-To: <818477200.31466413.1562158387201.JavaMail.zimbra@redhat.com>
References: <dc4e1e30-face-9039-db90-5a6dae2fc2ea@windriver.com>
 <1731168043.30655111.1561720172996.JavaMail.zimbra@redhat.com>
 <77f916ad-58e3-bf0c-e1e7-da8fc3397ba4@windriver.com>
 <818477200.31466413.1562158387201.JavaMail.zimbra@redhat.com>
Message-ID: <b3536126-309b-5641-aeb8-de36180a8395@windriver.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


On 7/3/19 8:53 PM, Jan Stancek wrote:
> ----- Original Message -----
>> Thanks for your work.
>>
>> I will backport the patch to my project after merged.
> Does it mean, that patch I posted fixes problem for you?


Not for me, for LTP.

I just found the bug. Even if there is no me, the bug still exists.


Do you think the manually selecting addr for mmap is reasonable?

And the addr points to the top of heap.


|  >shm_base = (char *)(((long)sbrk(0) + (shmsz - 1)) & ~(shmsz - 1));

|? >shm_base = mmap(shm_base, 0x100000, PROT_READ | PROT_WRITE,


>
> Do you have good/bad kernel version? I was looking at recent
> upstream changes, but didn't spot anything that could explain
> that EINVAL.


I didn't test all versions of kernel. But after v5.1-mips can raise the 
problem.

Maybe the bug exists on mips since the testcase is created.

I guess that few people use mips now, so the bug is not found in time.


--Hongzhi


>>
>> --Hongzhi
>>
>>
>>
>> On 6/28/19 7:09 PM, Jan Stancek wrote:
>>> ----- Original Message -----
>>>> *Ltp:*
>>>>
>>>> latest master
>>>>
>>>>
>>>> *Kernel:*
>>>>
>>>> After v5.1 ARCH=mips64
>>>>
>>>>
>>>> *Error info:*
>>>>
>>>> diotest4 10 TBROK : diotest4.c:368: can't mmap file: Invalid argument
>>>> diotest4 11 TBROK : diotest4.c:368: Remaining cases broken
>>>>
>>>>
>>>> I think the first argument of mmap is invalid.
>>>>
>>>>    ?? >shm_base = (char *)(((long)sbrk(0) + (shmsz - 1)) & ~(shmsz - 1));
>>>>
>>>>    ?? >shm_base = mmap(shm_base, 0x100000, PROT_READ | PROT_WRITE,
>>> I don't see any note why that mmap needs to be MAP_FIXED. I'd drop it,
>>> let kernel pick an address:
>>>
>>> diff --git a/testcases/kernel/io/direct_io/diotest4.c
>>> b/testcases/kernel/io/direct_io/diotest4.c
>>> index e4616e400abd..bf200cd41a27 100644
>>> --- a/testcases/kernel/io/direct_io/diotest4.c
>>> +++ b/testcases/kernel/io/direct_io/diotest4.c
>>> @@ -352,18 +352,14 @@ int main(int argc, char *argv[])
>>>           total++;
>>>
>>>           /* Test-10: read, write to a mmaped file */
>>> -       shm_base = (char *)(((long)sbrk(0) + (shmsz - 1)) & ~(shmsz - 1));
>>> -       if (shm_base == NULL) {
>>> -               tst_brkm(TBROK, cleanup, "sbrk failed: %s",
>>> strerror(errno));
>>> -       }
>>>           offset = 4096;
>>>           count = bufsize;
>>>           if ((fd = open(filename, O_DIRECT | O_RDWR)) < 0) {
>>>                   tst_brkm(TBROK, cleanup, "can't open %s: %s",
>>>                            filename, strerror(errno));
>>>           }
>>> -       shm_base = mmap(shm_base, 0x100000, PROT_READ | PROT_WRITE,
>>> -                       MAP_SHARED | MAP_FIXED, fd, 0);
>>> +       shm_base = mmap(0, 0x100000, PROT_READ | PROT_WRITE,
>>> +                       MAP_SHARED, fd, 0);
>>>           if (shm_base == (caddr_t) - 1) {
>>>                   tst_brkm(TBROK, cleanup, "can't mmap file: %s",
>>>                            strerror(errno));
>>>
