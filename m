From: Li Wang <liwang@redhat.com>
Date: Wed, 24 Feb 2021 17:44:40 +0800
Subject: [LTP] [PATCH v2] swapping01: check memory swap usage per process
In-Reply-To: <20210224082500.18106-1-liwang@redhat.com>
References: <20210224082500.18106-1-liwang@redhat.com>
Message-ID: <CAEemH2cJfUnDz7ZF3X4=xACsEhHLk+ywgTD_F8eZP-VnNyS=wA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

 Li Wang <liwang@redhat.com> wrote:

Issue:
>
> Currently test swapping01 read the system FreeSwap for counting usage of
> swap-size, that's not precise on system especially with eating-memory
> daemon
> in the background.
>
> Improvement:
>
> Considering that swap out unreferenced pages also could be occurred in a
> single process. So that we encapsulate all of the means in a single process
> to avoid involving the whole system swap-counting. Then only try to check
> the
> 'VmSwap' in proc/PID/status per process, to get rid of the potential
> influence
> from other processes which easily leads to false positive.  e.g.
>
> Child:
>          touch unreferenced pages (via alloc&write&free 1.3*MemAvailable)
> [1]
>          alloc&wirte 1.3*MemAvailable
>          raise(SIGSTOP)
>          ...
> Parent:
>          waiting for child suspension
>          check child's VmSwap to see if heavy-swap occurs in a process
>          ...
>
> [1] As to perform alloc&write&free, the system pages will go through a
> completed life cycle from buddy-system to active-list to inactive-list
> then back to buddy-system, which reflect to a page status is theoretically
> like:
> "inactive,unreferenced -> active,referenced -> ... ->inactive,unreferenced"
> so that will helpful to produce what the kernel target commit fixed
> situation.
>
> New reproducer works well with unfix-kernel:
>
>   # uname  -r
>   2.6.39
>
>   # ./swapping01
>   tst_test.c:1263: TINFO: Timeout per run is 0h 05m 00s
>   swapping01.c:110: TINFO: available physical memory: 1896 MB
>   swapping01.c:113: TINFO: try to allocate: 2466 MB
>   swapping01.c:148: TFAIL: heavy swapping detected: 1905 MB swapped.
>

BTW, to be on the safe side, I tried on kernel-3.2.0 (with dropping that
fix commit), it also could be reproduced in such a single process way.
But after adding back the revert commit, swapping01 gets PASS in 100 times.

I think it can prove that the patch makes some sense to swapping01.

# uname  -rm
3.2.0+ s390x


FAIL on kernel reverts that fix-commit
----------------------
# ./swapping01 -i 100
tst_test.c:1263: TINFO: Timeout per run is 0h 05m 00s
swapping01.c:110: TINFO: available physical memory: 1895 MB
swapping01.c:113: TINFO: try to allocate: 2464 MB
swapping01.c:148: TFAIL: heavy swapping detected: 1905 MB swapped.


PASS on kernel includes that fix-commit
----------------------
# ./swapping01 -i 100
tst_test.c:1263: TINFO: Timeout per run is 0h 05m 00s
swapping01.c:110: TINFO: available physical memory: 1876 MB
swapping01.c:113: TINFO: try to allocate: 2439 MB
swapping01.c:152: TPASS: no heavy swapping detected, 593 MB swapped.
swapping01.c:110: TINFO: available physical memory: 1919 MB
swapping01.c:113: TINFO: try to allocate: 2495 MB
swapping01.c:152: TPASS: no heavy swapping detected, 650 MB swapped.
...

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210224/5515c34e/attachment.htm>
