From: Li Wang <liwang@redhat.com>
Date: Thu, 21 Jan 2021 17:30:23 +0800
Subject: [LTP] [PATCH 1/1] swapping01: make test more robust
In-Reply-To: <87zh14rrxm.fsf@oc8242746057.ibm.com>
References: <20210115143246.369676-1-egorenar@linux.ibm.com>
 <CAEemH2fDzPp3D6KZ_G0UDbS=eh2tWDAcy7CTt_4Yw7FUT4zGxg@mail.gmail.com>
 <87zh14rrxm.fsf@oc8242746057.ibm.com>
Message-ID: <CAEemH2fy8Zsu6Vz_DWOSHtBxQDMSemsw3bQNDqTdLOG27JiMPQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexander,

On Wed, Jan 20, 2021 at 3:26 PM Alexander Egorenkov <egorenar@linux.ibm.com>
wrote:

> ...
>
> Hi,
>
> i did more tests as promised.
> Your patch didn't help :( Still seeing failures.
>
> With your patch:
> ----------------
> swapping01.c:148: TPASS: no heavy swapping detected, 7282 MB swapped.
> swapping01.c:107: TINFO: available physical memory: 7303 MB
> swapping01.c:110: TINFO: try to allocate: 9494 MB
> swapping01.c:113: TINFO: memory allocated: 9494 MB
> swapping01.c:148: TPASS: no heavy swapping detected, 6204 MB swapped.
> swapping01.c:107: TINFO: available physical memory: 7299 MB
> swapping01.c:110: TINFO: try to allocate: 9488 MB
> swapping01.c:113: TINFO: memory allocated: 9488 MB
> swapping01.c:144: TFAIL: heavy swapping detected: 9490 MB swapped.
>
> Summary:
> passed   27
> failed   1
> skipped  0
> warnings 0
>
>
> W/O your patch:
> ---------------
> swapping01.c:147: TPASS: no heavy swapping detected, 2229 MB swapped.
> swapping01.c:106: TINFO: available physical memory: 7311 MB
> swapping01.c:109: TINFO: try to allocate: 9504 MB
> swapping01.c:112: TINFO: memory allocated: 9504 MB
> swapping01.c:147: TPASS: no heavy swapping detected, 2249 MB swapped.
> swapping01.c:106: TINFO: available physical memory: 7306 MB
> swapping01.c:109: TINFO: try to allocate: 9498 MB
> swapping01.c:112: TINFO: memory allocated: 9498 MB
> swapping01.c:143: TFAIL: heavy swapping detected: 9496 MB swapped.
>
> Summary:
> passed   23
> failed   1
> skipped  0
> warnings 0
>
>
>
> I can easily reproduce the problem inside an LPAR with 8GB RAM and 20GB
> swap. But could *NOT* reproduce it inside a zVM w/o any patches, might be
> fluke or some other unknown factors probably.


> My patch seems to work very well, couldn't reproduce the problem with it
> applied :/
>

I'm now a little bit doubt the lawful of swapping01 since I can easily get
heavy-swapping[1] when increasing the value of COE_SLIGHT_OVER
(which means just to request more available memory).

The original purpose of swapping01 seems to verify NO heavy-swapping
with slightly over-use available memory, but it doesn't have a standard
to evaluate/say how much is slightly over-use(the default set 1.3*phy_mem).
But I guess that might influence by different config of system, e.g the
system
you tried with 8GB RAM and 20GB swap, that swap more likely to be overused.

Anyway, these are my personal perspective, maybe wrong, we still need more
investigation.

[1] the conception of heavy-swapping in this test define by:
     swapped > mem_available_init

--------------------------------

The test FAIL(With and W/O your patch) on an aarch64 platform:
(allocate 2*mem_available but not 1.3*mem_available)

# free -h
              total        used        free      shared  buff/cache
available
Mem:          5.4Gi       329Mi       5.0Gi       0.0Ki       152Mi
4.6Gi
Swap:         6.0Gi       194Mi       5.8Gi

 # ./swapping01
tst_test.c:1263: TINFO: Timeout per run is 0h 05m 00s
swapping01.c:107: TINFO: available physical memory: 4745 MB
swapping01.c:109: TINFO: try to allocate: 9491 MB
swapping01.c:112: TINFO: memory allocated: 9491 MB
swapping01.c:135: TINFO: DEBUG-INFO: swap_free_init = 6107200,
swap_free_now = 1339520, swap_consum(swap_free_init - swap_free_now) =
4767680
swapping01.c:135: TINFO: DEBUG-INFO: swap_free_init = 6107200,
swap_free_now = 1196160, swap_consum(swap_free_init - swap_free_now) =
4911040
swapping01.c:135: TINFO: DEBUG-INFO: swap_free_init = 6107200,
swap_free_now = 1200256, swap_consum(swap_free_init - swap_free_now) =
4906944
swapping01.c:150: TFAIL: heavy swapping detected: 4791 MB swapped.

(Debug-Info shows that 'swap_free_now' dynamically changes
not only decrease but also increase during the testing, it looks like
the system tries to reclaim some memory and do balance for a while.
But the worth saying, no OOM occurred during the above memory
overused.)

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210121/1fb09957/attachment.htm>
