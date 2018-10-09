From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 9 Oct 2018 11:28:22 +0200
Subject: [LTP] LTP: futex_wake04 hangs forever on i386
In-Reply-To: <3dbee853-6bce-d057-f42a-655a8f2991c3@linaro.org>
References: <CA+G9fYs13QZtsREe3dvic+G6VPQ1dJroKH0sguBiNdtizRTeNQ@mail.gmail.com>
 <20181008133059.GB30978@rei>
 <3dbee853-6bce-d057-f42a-655a8f2991c3@linaro.org>
Message-ID: <20181009092821.GA16630@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> >> LTP syscall test case futex_wake04 hangs forever on i386 kernel 
> >> running on x86_64 server machine.
> >> 
> >> Test PASS on qemu_i386 and other devices. Test HANGs on i386 (i386
> >>  kernel booting on x86_64 machine).
> >> 
> >> output, incrementing stop futex_wake04    0  TINFO  : Hugepagesize
> >> 4194304
> > 
> > Looks like we are trying to fault 4GB hugepage, that may be quite 
> > slow, but then, the test is a kernel reproducer as well.
> 
> This is i386 without PAE so the hugepage here is 4 MB (or else it would
> be a 2 MB with PAE). I have configured the same environment on my side:

Ah, my bad, the test prints the size in bytes and not in kbytes as it's
in /proc/meminfo. So indeed this is 4MB.

> (k)inaddy@bug3984:~$ sudo hugeadm --hard --pool-pages-max 4M:128
> (k)inaddy@bug3984:~$ sudo hugeadm --hard --pool-pages-min 4M:128
> (k)inaddy@bug3984:~$ sudo hugeadm --pool-list
>        Size  Minimum  Current  Maximum  Default
>     4194304      128      128      128        *
> 
> And ran the test with 500 iterations, multiple times, without a single
> issue.
> 
> (k)root@bug3984:~$ while true; do cat /proc/meminfo | grep -i
> hugepages_free; done
> 
> Shoes me the hugepages are being used:
> 
> HugePages_Free:       93
> HugePages_Free:        4
> HugePages_Free:      128
> HugePages_Free:        0
> HugePages_Free:      128
> HugePages_Free:        1
> HugePages_Free:        8
> HugePages_Free:      128
> HugePages_Free:       27
> HugePages_Free:        0
> HugePages_Free:      102
> 
> > Can you connect to the process with gdb and check if we happened to 
> > timeout before or after the two threads that are are supposed to 
> > trigger kernel bug are started?
> > 
> 
> Reading the test and commit 13d60f4b6a it looks like this test is
> testing futexes indexes stored in hugepages (one in head and the other
> outside the hugepage head) and a indexing problem on which futex() was
> signalized as non-contended.
> 
> Kernel code was using page->index (of page hosting the futex) for futex
> offset and, after this commit, it started taking in consideration if the
> page was a hugepage (head or tail) or a compound page, when then it
> would use the compound_idx for the futex offset, fixing the issue.
> 
> In order for the issue to happen we would have to face:
> 
> test thread #1                    test thread #2
> --------------                    --------------
> [hugepage #1 head] *futex1 offset [hugepage #1 head]
> [page]                            [page] *futex2 offset
> [page]                            [page]
> [page]                            [page]
> ...                               ...
> 
> where futex2 key points to futex1.
> 
> And test case does NOT look like something intermittent (since it is a
> lock ordering issue - depending on pthreads sharing futexes - with wrong
> futexes indexes, like described in kernel commit).
> 
> * Test case problem would either happen or not *
> 
> I tried to extend a bit number of iterations and something caught my 
> attention... when running the same test, multiple times, after some time 
> I would face something like:
> 
> futex_wake04    0  TINFO  :  Thread 7495 not sleeping yet
> futex_wake04    0  TINFO  :  Thread 7495 not sleeping yet
> futex_wake04    0  TINFO  :  Thread 7495 not sleeping yet
> futex_wake04    0  TINFO  :  Thread 7495 not sleeping yet
> futex_wake04    0  TINFO  :  Thread 7495 not sleeping yet
> futex_wake04    0  TINFO  :  Thread 7495 not sleeping yet
> futex_wake04    0  TINFO  :  Thread 7495 not sleeping yet
> futex_wake04    0  TINFO  :  Thread 7495 not sleeping yet
> futex_wake04    0  TINFO  :  Thread 7495 not sleeping yet
> 
> And there wasn't a second thread task id inside:
> 
> /proc/<pid>/task/{<pid>, <tid1>, <tid2>}
> 
> like it should.
> 
> Likely the task creation (because of error ? check last part) logic here 
> was faster than wait_for_threads() logic could expect... causing a race 
> for the test's logic.

That shouldn't really happen, the wait_for_threads(2) function is called
in a loop until there are two sleeping threads under the
/proc/$pid/task/ directory (minus the main thread). So unless there is a
problem with starting a thread or locking on a futex the loop will end
eventually and the futexes are unlocked only after this loop finishes.

> * This would explain the timeout error we had, right ? *
> 
> Since stdout/stderr are being directed to a file: @Naresh, is it 
> possible to get output from stdout/err files from the same LKFT URL you 
> showed ?
> 
> * Wait, there is more ... *
> 
> While running the test, and monitoring meminfo, I could see the 
> HugePages_Total oscillating:
> 
> HugePages_Total:       1
> HugePages_Free:        1
> HugePages_Rsvd:        0
> HugePages_Surp:        0
> 
> HugePages_Total:       1
> HugePages_Free:        1
> HugePages_Rsvd:        0
> HugePages_Surp:        0
> 
> HugePages_Total:      54
> HugePages_Free:       53
> HugePages_Rsvd:        0
> HugePages_Surp:        0
> 
> HugePages_Total:       1
> HugePages_Free:        1
> HugePages_Rsvd:        0
> HugePages_Surp:        0
> 
> HugePages_Total:       1
> HugePages_Free:        0
> HugePages_Rsvd:        0
> HugePages_Surp:        0
> 
> HugePages_Total:     101
> HugePages_Free:      101
> HugePages_Rsvd:        0
> HugePages_Surp:        0
> 
> HugePages_Total:     128
> HugePages_Free:      128
> HugePages_Rsvd:        0
> HugePages_Surp:        0
> 
> HugePages_Total:       1
> HugePages_Free:        1
> HugePages_Rsvd:        0
> HugePages_Surp:        0
> 
> HugePages_Total:       1
> HugePages_Free:        0
> HugePages_Rsvd:        0
> HugePages_Surp:        0
> 
> despite the fact that I had configured:
> 
> (k)inaddy@bug3984:~$ sudo hugeadm --hard --pool-pages-min 4M:128
> (k)inaddy@bug3984:~$ sudo hugeadm --hard --pool-pages-max 4M:128
> 
> And had "128" for HugePages_Total in the beginning of the test. Number 
> of hugepages total oscillates during a successful test and, at the very 
> end, the number for HugePages_Total goes back to 128. I have disabled 
> THP completely after this test and there was the same result.
>
> Reading hugetlb_report_meminfo() in hugetlb.c, I am not sure (struct 
> hstat *h)->nr_huge_pages should change that much (through new hugepages 
> being asked for, sysctl, or numa balance, among other options). I'll try 
> to trace this tomorrow to see who is touching the HugePages_Total during 
> the test.

That is because the test modifies the size of the huge pages pool itself
in the test setup so that it can run on a systems where the default is
set to 0. I guess that we should change it so that it check if the
orig_hugepages is non-zero or not and only change the value if it's
zero.

-- 
Cyril Hrubis
chrubis@suse.cz
