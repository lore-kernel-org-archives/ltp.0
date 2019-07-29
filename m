From: Mike Kravetz <mike.kravetz@oracle.com>
Date: Mon, 29 Jul 2019 12:00:41 -0700
Subject: [LTP] 
 =?utf-8?q?=5BMM_Bug=3F=5D_mmap=28=29_triggers_SIGBUS_while?=
 =?utf-8?b?IGRvaW5nIHRoZeKAiyDigItudW1hX21vdmVfcGFnZXMoKSBmb3Igb2ZmbGlu?=
 =?utf-8?q?ed_hugepage_in_background?=
In-Reply-To: <CAEemH2dMW6oh6Bbm=yqUADF+mDhuQgFTTGYftB+xAhqqdYV3Ng@mail.gmail.com>
References: <CAEemH2dMW6oh6Bbm=yqUADF+mDhuQgFTTGYftB+xAhqqdYV3Ng@mail.gmail.com>
Message-ID: <47999e20-ccbe-deda-c960-473db5b56ea0@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 7/28/19 10:17 PM, Li Wang wrote:
> Hi Naoya and Linux-MMers,
> 
> The LTP/move_page12 V2 triggers SIGBUS in the kernel-v5.2.3 testing.
> https://github.com/wangli5665/ltp/blob/master/testcases/kernel/syscalls/move_pages/move_pages12.c
> 
> It seems like the retry mmap() triggers SIGBUS while doing thenuma_move_pages() in background. That is very similar to the kernelbug which was mentioned by commit 6bc9b56433b76e40d(mm: fix race onsoft-offlining ): A race condition between soft offline andhugetlb_fault which causes unexpected process SIGBUS killing.
> 
> I'm not sure if that below patch is making sene to memory-failures.c, but after building a new kernel-5.2.3 with this change, the problem can NOT be reproduced. 
> 
> Any comments?

Something seems strange.  I can not reproduce with unmodified 5.2.3

[root@f23d move_pages]# uname -r
5.2.3
[root@f23d move_pages]# PATH=$PATH:$PWD ./move_pages12
tst_test.c:1096: INFO: Timeout per run is 0h 05m 00s
move_pages12.c:201: INFO: Free RAM 6725424 kB
move_pages12.c:219: INFO: Increasing 2048kB hugepages pool on node 0 to 4
move_pages12.c:229: INFO: Increasing 2048kB hugepages pool on node 1 to 4
move_pages12.c:145: INFO: Allocating and freeing 4 hugepages on node 0
move_pages12.c:145: INFO: Allocating and freeing 4 hugepages on node 1
move_pages12.c:135: PASS: Bug not reproduced

Summary:
passed   1
failed   0
skipped  0
warnings 0

Also, the soft_offline_huge_page() code should not come into play with
this specific test.
-- 
Mike Kravetz
