From: Li Wang <liwang@redhat.com>
Date: Tue, 30 Jul 2019 14:29:09 +0800
Subject: [LTP] 
	=?utf-8?q?=5BMM_Bug=3F=5D_mmap=28=29_triggers_SIGBUS_while?=
	=?utf-8?b?IGRvaW5nIHRoZeKAiyDigItudW1hX21vdmVfcGFnZXMoKSBmb3Igb2Zm?=
	=?utf-8?q?lined_hugepage_in_background?=
In-Reply-To: <47999e20-ccbe-deda-c960-473db5b56ea0@oracle.com>
References: <CAEemH2dMW6oh6Bbm=yqUADF+mDhuQgFTTGYftB+xAhqqdYV3Ng@mail.gmail.com>
 <47999e20-ccbe-deda-c960-473db5b56ea0@oracle.com>
Message-ID: <CAEemH2d=vEfppCbCgVoGdHed2kuY3GWnZGhymYT1rnxjoWNdcQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Mike,

Thanks for trying this.

On Tue, Jul 30, 2019 at 3:01 AM Mike Kravetz <mike.kravetz@oracle.com>
wrote:
>
> On 7/28/19 10:17 PM, Li Wang wrote:
> > Hi Naoya and Linux-MMers,
> >
> > The LTP/move_page12 V2 triggers SIGBUS in the kernel-v5.2.3 testing.
> >
https://github.com/wangli5665/ltp/blob/master/testcases/kernel/syscalls/move_pages/move_pages12.c
> >
> > It seems like the retry mmap() triggers SIGBUS while doing
thenuma_move_pages() in background. That is very similar to the kernelbug
which was mentioned by commit 6bc9b56433b76e40d(mm: fix race
onsoft-offlining ): A race condition between soft offline andhugetlb_fault
which causes unexpected process SIGBUS killing.
> >
> > I'm not sure if that below patch is making sene to memory-failures.c,
but after building a new kernel-5.2.3 with this change, the problem can NOT
be reproduced.
> >
> > Any comments?
>
> Something seems strange.  I can not reproduce with unmodified 5.2.3

It's not 100% reproducible, I tried ten times only hit 4~6 times fail.

Did you try the test case with patch V3(in my branch)?
https://github.com/wangli5665/ltp/commit/198fca89870c1b807a01b27bb1d2ec6e2af1c7b6

# git clone https://github.com/wangli5665/ltp ltp.wangli --depth=1
# cd ltp.wangli/; make autotools;
# ./configure ; make -j24
# cd testcases/kernel/syscalls/move_pages/
# ./move_pages12
tst_test.c:1100: INFO: Timeout per run is 0h 05m 00s
move_pages12.c:249: INFO: Free RAM 64386300 kB
move_pages12.c:267: INFO: Increasing 2048kB hugepages pool on node 0 to 4
move_pages12.c:277: INFO: Increasing 2048kB hugepages pool on node 1 to 4
move_pages12.c:193: INFO: Allocating and freeing 4 hugepages on node 0
move_pages12.c:193: INFO: Allocating and freeing 4 hugepages on node 1
move_pages12.c:183: PASS: Bug not reproduced
tst_test.c:1145: BROK: Test killed by SIGBUS!
move_pages12.c:117: FAIL: move_pages failed: ESRCH

# uname -r
5.2.3

# numactl -H
available: 4 nodes (0-3)
node 0 cpus: 0 1 2 3 4 5 6 7 32 33 34 35 36 37 38 39
node 0 size: 16049 MB
node 0 free: 15736 MB
node 1 cpus: 8 9 10 11 12 13 14 15 40 41 42 43 44 45 46 47
node 1 size: 16123 MB
node 1 free: 15850 MB
node 2 cpus: 16 17 18 19 20 21 22 23 48 49 50 51 52 53 54 55
node 2 size: 16123 MB
node 2 free: 15989 MB
node 3 cpus: 24 25 26 27 28 29 30 31 56 57 58 59 60 61 62 63
node 3 size: 16097 MB
node 3 free: 15278 MB
node distances:
node   0   1   2   3
  0:  10  20  20  20
  1:  20  10  20  20
  2:  20  20  10  20
  3:  20  20  20  10

> Also, the soft_offline_huge_page() code should not come into play with
> this specific test.

I got the "soft offline xxx.. hugepage failed to isolate" message from
soft_offline_huge_page()
in dmesg log.

=== debug print info ===
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1701,7 +1701,7 @@ static int soft_offline_huge_page(struct page *page,
int flags)
         */
        put_hwpoison_page(hpage);
        if (!ret) {
-               pr_info("soft offline: %#lx hugepage failed to isolate\n",
pfn);
+               pr_info("liwang -- soft offline: %#lx hugepage failed to
isolate\n", pfn);
                return -EBUSY;
        }

# dmesg
...
[ 1068.947205] Soft offlining pfn 0x40b200 at process virtual address
0x7f9d8d000000
[ 1068.987054] Soft offlining pfn 0x40ac00 at process virtual address
0x7f9d8d200000
[ 1069.048478] Soft offlining pfn 0x40a800 at process virtual address
0x7f9d8d000000
[ 1069.087413] Soft offlining pfn 0x40ae00 at process virtual address
0x7f9d8d200000
[ 1069.123285] liwang -- soft offline: 0x40ae00 hugepage failed to isolate
[ 1069.160137] Soft offlining pfn 0x80f800 at process virtual address
0x7f9d8d000000
[ 1069.196009] Soft offlining pfn 0x80fe00 at process virtual address
0x7f9d8d200000
[ 1069.243436] Soft offlining pfn 0x40a400 at process virtual address
0x7f9d8d000000
[ 1069.281301] Soft offlining pfn 0x40a600 at process virtual address
0x7f9d8d200000
[ 1069.318171] liwang -- soft offline: 0x40a600 hugepage failed to isolate

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190730/23d7a58b/attachment-0001.htm>
