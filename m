From: Hongzhi, Song <hongzhi.song@windriver.com>
Date: Wed, 17 Oct 2018 13:52:57 +0800
Subject: [LTP] [PATCH] open_posix_testsuite/mmap24-2: Relax condition a
 bit
In-Reply-To: <20181016130209.GB6980@rei>
References: <1539226733-18212-1-git-send-email-hongzhi.song@windriver.com>
 <20181016130209.GB6980@rei>
Message-ID: <21d93aaa-3047-42b4-cb8e-747ef1036a53@windriver.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it



On 10/16/2018 09:02 PM, Cyril Hrubis wrote:
> Hi!
>> Linux kernel code: arch/mips/mm/mmap.c
>> if (flags & MAP_FIXED) {
>>      /* Even MAP_FIXED mappings must reside within TASK_SIZE */
>>      if (TASK_SIZE - len < addr)
>>          return -EINVAL;
>>
>> Relax the condition and accept both ENOMEM and EINVAL
>> as expected outcome.
> Hmm, it's always complicated with these POSIX tests, since we have to
> follow the POSIX specification there.
>
> And the POSIX clearly says that mmap() shall fail with ENOMEM if
> MAP_FIXED was specified, and the range [addr,addr+len) exceeds that
> allowed for the address space of a process. So I guess that the best
> solution here would be limiting the address space with rlimit, so that
> we actually happen to hit the ENOMEM instead of EINVAL.
I just referred to follow commit which has similar issue.

     [commit id: e7bab61882847]
     syscalls/mmap15: relax condition a bit

     High address is arch specific, and it also occasionally changes
     as can be se总共可用的内存大小的最en in history of this test.

     Relax the co总共可用的内存大小的最ndition and accept both ENOMEM and 
EINVAL
     as expected outcome.
     总共可用的内存大小的最
     Fixes: #390

Mips returns EINVAL and never returns ENOMEM if [addr+len]
  exceeds task size. I think it's has no relation with rlimit.

--Hongzhi

>
> At least we cannot say that we passed the test with EINVAL because the
> assertion we tried to test wasn't triggered.
>

