From: Li Wang <liwang@redhat.com>
Date: Wed, 15 Feb 2017 17:38:46 +0800
Subject: [LTP] madvise07.c:72: FAIL: Did not receive SIGBUS
In-Reply-To: <227667312.4337607.1487081174657.JavaMail.zimbra@redhat.com>
References: <CAEemH2ddpwBet_2crzv+sOJ9P84fscFH1re4SCo1dD_PKGgsgA@mail.gmail.com>
 <20170213090837.GA16973@rei.lan>
 <227667312.4337607.1487081174657.JavaMail.zimbra@redhat.com>
Message-ID: <CAEemH2fQehJ-g__jn5EB670tS4BmwQKU6LVmNkdmOZ-YLZugHA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Feb 14, 2017 at 10:06 PM, Jan Stancek <jstancek@redhat.com> wrote:
>
>
> ----- Original Message -----
>> From: "Cyril Hrubis" <chrubis@suse.cz>
>> To: "Li Wang" <liwang@redhat.com>
>> Cc: richiejp@f-m.fm, ltp@lists.linux.it
>> Sent: Monday, 13 February, 2017 10:08:37 AM
>> Subject: Re: [LTP] madvise07.c:72: FAIL: Did not receive SIGBUS
>>
>> Hi!
>> > I'm trying to run ltp on upstream kernel-4.10.0-rc7, and found that
>> > madvise07 always failing with no SIGBUS received when mmap the PRIVATE
>> > memory. I hope to know if there're some relevant stuff about this
>> > issue.
>> > Any discussion or document for that?
>>
>> Looks like a plain old kernel bug to me.
>
> Or maybe MADV_HWPOISON is supposed to work only for faulted-in pages?

Looks like this thought is reasonable. Since the flag MAP_PRIVATE
creates a private copy-on-write page mapping, it means the testcase
will poison the read-only empty zero page many times if we reserve
more than one page. I did a test and verify that imagination.

e.g  Only running madvise07 PRIVATE part with 4pages on rhel7.3

# dmesg
[   62.322637] Injecting memory failure for page 1c9d at 7f0594254000
[   62.329660] MCE 0x1c9d: reserved kernel page still referenced by 1 users
[   62.337143] MCE 0x1c9d: reserved kernel page recovery: Failed
[   91.505460] Injecting memory failure for page 1c9d at 7f09ab16e000
[   91.512363] MCE 0x1c9d: already hardware poisoned
[   91.517620] Injecting memory failure for page 1c9d at 7f09ab16f000
[   91.524516] MCE 0x1c9d: already hardware poisoned
[   91.529763] Injecting memory failure for page 1c9d at 7f09ab170000
[   91.536659] MCE 0x1c9d: already hardware poisoned



And a patch in upstream kernel to fix a similar problem like that, it
make sense to fix our LTP case madvise07.c.

commit 29b4eedee67b449534214058e1bcb36307a7f1dc
Author: Wanpeng Li <liwanp@linux.vnet.ibm.com>
Date:   Wed Sep 11 14:22:59 2013 -0700

    mm/hwpoison.c: fix held reference count after unpoisoning empty zero page



> It works fine for me with change below:
>
> diff --git a/testcases/kernel/syscalls/madvise/madvise07.c b/testcases/kernel/syscalls/madvise/madvise07.c
> index 2f8c42e..f5fd4b7 100644
> --- a/testcases/kernel/syscalls/madvise/madvise07.c
> +++ b/testcases/kernel/syscalls/madvise/madvise07.c
> @@ -44,13 +44,13 @@ static int maptypes[] = {
>
>  static void run_child(int maptype)
>  {
> -       const size_t msize = 4096;
> +       const size_t msize = getpagesize();
>         void *mem = NULL;
>
>         mem = SAFE_MMAP(NULL,
>                         msize,
>                         PROT_READ | PROT_WRITE,
> -                       MAP_ANONYMOUS | maptype,
> +                       MAP_ANONYMOUS | maptype | MAP_POPULATE,
>                         -1,
>                         0);
>

An other way I propose to fix the problem is just to using the page
before madvise():

$ git diff
diff --git a/testcases/kernel/syscalls/madvise/madvise07.c
b/testcases/kernel/syscalls/madvise/madvise07.c
index 2f8c42e..0ed5307 100644
--- a/testcases/kernel/syscalls/madvise/madvise07.c
+++ b/testcases/kernel/syscalls/madvise/madvise07.c
@@ -54,6 +54,8 @@ static void run_child(int maptype)
                        -1,
                        0);

+       *((char *)mem) = 'a';
+
        tst_res(TINFO, "madvise(%p, %zu, MADV_HWPOISON)", mem, msize);
        if (madvise(mem, msize, MADV_HWPOISON) == -1) {
                if (errno == EINVAL)



>
>>
>> > # uname -r
>> > 4.10.0-rc7
>> >
>> > # ./madvise07
>> > tst_test.c:794: INFO: Timeout per run is 0h 05m 00s
>> > madvise07.c:57: INFO: madvise(0x7f25bdd7e000, 4096, MADV_HWPOISON)
>> > madvise07.c:72: FAIL: Did not receive SIGBUS after accessing
>> > MAP_PRIVATE memory marked with MADV_HWPOISON
>>
>> If you reach this TFAIL the child wasn't killed with a signal after it
>> accessed memory marked with MADV_HWPOISON.
>>
>> What hardware is this?
>
> I'm seeing it on x86 KVM guest, with 2.6.32 (RHEL6.0), 3.10 (RHEL7), 4.8 and 4.9 kernels.
>
>>
>> > madvise07.c:57: INFO: madvise(0x7f25bdd7e000, 4096, MADV_HWPOISON)
>> > madvise07.c:90: PASS: madvise(..., MADV_HWPOISON) on MAP_SHARED memory
>>
>> --
>> Cyril Hrubis
>> chrubis@suse.cz
>>
>> --
>> Mailing list info: https://lists.linux.it/listinfo/ltp
>>



-- 
Regards,
Li Wang
Email: liwang@redhat.com
