From: Li Wang <liwang@redhat.com>
Date: Mon, 29 Jul 2019 13:17:27 +0800
Subject: [LTP] =?utf-8?q?=5BMM_Bug=3F=5D_mmap=28=29_triggers_SIGBUS_while?=
	=?utf-8?b?IGRvaW5nIHRoZeKAiyDigItudW1hX21vdmVfcGFnZXMoKSBmb3Igb2Zm?=
	=?utf-8?q?lined_hugepage_in_background?=
Message-ID: <CAEemH2dMW6oh6Bbm=yqUADF+mDhuQgFTTGYftB+xAhqqdYV3Ng@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Naoya and Linux-MMers,

The LTP/move_page12 V2 triggers SIGBUS in the kernel-v5.2.3 testing.
https://github.com/wangli5665/ltp/blob/master/testcases/kernel/syscalls/move_pages/move_pages12.c

It seems like the retry mmap() triggers SIGBUS while doing the
numa_move_pages()
in background. That is very similar to the kernel bug which was mentioned
by commit 6bc9b56433b76e40d(mm: fix race on soft-offlining ): A race
condition between soft offline and hugetlb_fault which causes unexpected
process SIGBUS killing.

I'm not sure if that below patch is making sene to memory-failures.c, but after
building a new kernel-5.2.3 with this change, the problem can NOT be
reproduced.

Any comments?

----------------------------------
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1695,15 +1695,16 @@ static int soft_offline_huge_page(struct page
*page, int flags)
        unlock_page(hpage);

        ret = isolate_huge_page(hpage, &pagelist);
+       if (!ret) {
+               pr_info("soft offline: %#lx hugepage failed to isolate\n",
pfn);
+               return -EBUSY;
+       }
+
        /*
         * get_any_page() and isolate_huge_page() takes a refcount each,
         * so need to drop one here.
         */
        put_hwpoison_page(hpage);
-       if (!ret) {
-               pr_info("soft offline: %#lx hugepage failed to isolate\n",
pfn);
-               return -EBUSY;
-       }


----- test on kernel-v5.2.3 ------
# ./move_pages12
tst_test.c:1100: INFO: Timeout per run is 0h 05m 00s
move_pages12.c:251: INFO: Free RAM 194212832 kB
move_pages12.c:269: INFO: Increasing 2048kB hugepages pool on node 0 to 4
move_pages12.c:279: INFO: Increasing 2048kB hugepages pool on node 1 to 6
move_pages12.c:195: INFO: Allocating and freeing 4 hugepages on node 0
move_pages12.c:195: INFO: Allocating and freeing 4 hugepages on node 1
move_pages12.c:185: PASS: Bug not reproduced
tst_test.c:1145: BROK: Test killed by SIGBUS!
move_pages12.c:114: FAIL: move_pages failed: ESRCH

----- test on kernel-v5.2.3  + above patch------
# ./move_pages12
tst_test.c:1100: INFO: Timeout per run is 0h 05m 00s
move_pages12.c:252: INFO: Free RAM 64780164 kB
move_pages12.c:270: INFO: Increasing 2048kB hugepages pool on node 0 to 7
move_pages12.c:280: INFO: Increasing 2048kB hugepages pool on node 1 to 10
move_pages12.c:196: INFO: Allocating and freeing 4 hugepages on node 0
move_pages12.c:196: INFO: Allocating and freeing 4 hugepages on node 1
move_pages12.c:186: PASS: Bug not reproduced
move_pages12.c:186: PASS: Bug not reproduced
--
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190729/f91efb92/attachment.htm>
