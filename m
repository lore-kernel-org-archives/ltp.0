From: Li Wang <liwang@redhat.com>
Date: Wed, 24 Feb 2021 16:04:26 +0800
Subject: [LTP] [PATCH RFC 2/2] swapping01: check memory swap usage per
 process
In-Reply-To: <CAEemH2cSwtVXi2fXam2aKG0XOEd3-hfZGgQ+o4K2_vyThMrTEg@mail.gmail.com>
References: <20210125064747.26759-1-liwang@redhat.com>
 <20210125064747.26759-2-liwang@redhat.com>
 <YA7i/eQagkj0Jxsy@yuki.lan>
 <CAEemH2cSwtVXi2fXam2aKG0XOEd3-hfZGgQ+o4K2_vyThMrTEg@mail.gmail.com>
Message-ID: <CAEemH2fVTtYP-5KwAU8O7Nr8NQawMb3p6_qo4e37Hxahnay8VA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

On Tue, Jan 26, 2021 at 1:25 PM Li Wang <liwang@redhat.com> wrote:

> Hi Cyril,
>
> On Mon, Jan 25, 2021 at 11:24 PM Cyril Hrubis <chrubis@suse.cz> wrote:
>
>> Hi!
>> > Since previously swapping01 read the system FreeSwap for counting
>> > usage of swap-size, that's not precise on system especially with
>> > eating-memory daemon??in the background. Now, we try to check the
>> > 'VmmSwap' in proc/PID/status??per process, to get rid of??the potential
>> > influence from??other processes??which easily leads to false positive.
>>
>> I've been looking for a while at the kernel commit:
>>
>> commit 50a15981a1fac7e019ff7c3cba87531fb580f065
>> Author: Martin Schwidefsky <schwidefsky@de.ibm.com>
>> Date:   Sun Jul 24 10:47:59 2011 +0200
>>
>>     [S390] reference bit testing for unmapped pages
>>
>> For which this test seems to be a reproducer and as far as I can tell
>> this fix is not correct.
>>
>> If I understand correctly what we are trying to test here is that the
>> kernel will not attempt to swap out unreferenced pages, so we have to,
>> by definition, look at the system counters not the process ones.
>>
>
> Thanks for point out this! Seems we were all working towards
> making the test robust but neglect it's a reproducer:).
>
>
> As we have discussed many unsure things will take side effect to
> the system swap-counting, that's what we do NOT want to expect.
> Maybe, can we encapsulate all of the means in a process to avoid
> involving the whole system swap-counting. e.g.
>
> Child:
>          to touch unreferenced pages (via
> alloc&write&free 1.3*MemAvailable) [1]
>          alloc&wirte 1.3*MemAvailable
>          raise(SIGSTOP)
>          ...
> Parent:
>          waiting for child suspension
>          check child's VmSwap to see if heavy-swap occurs in a process
>          ...
>
> Does this make some sense to the test or, any else suggestion?
>
> [1] As to perform alloc&write&free, the system pages will go through a
> completed life cycle from buddy-system to active-list to inactive-list
> then back to buddy-system, which reflect to a page status is theoretically
> like:
> "inactive,unreferenced -> active,referenced -> ... ->inactive,unreferenced"
> so that might helpful to produce what the kernel target commit fixed
> situation.
>

To verify this assumption, I run the swapping01 with/without my patch-V2
against an unfix-kernel(2.6.39). Seems swap out unreferenced pages also
could be occurred in a single process, which gives me some confidence to
send out my patch V2.

-------
Reproduce the bug easily with an unfix-kernel

# uname  -r
2.6.39

# free -m
             total       used       free     shared    buffers     cached
Mem:          2006       1559        447          0         22       1359
-/+ buffers/cache:        178       1828
Swap:         4031         12       4019

# ./swapping01
tst_test.c:1263: TINFO: Timeout per run is 0h 05m 00s
swapping01.c:110: TINFO: available physical memory: 1896 MB
swapping01.c:113: TINFO: try to allocate: 2466 MB
swapping01.c:148: TFAIL: heavy swapping detected: 1905 MB swapped.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210224/24561ebb/attachment-0001.htm>
