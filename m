From: Mike Kravetz <mike.kravetz@oracle.com>
Date: Tue, 30 Jul 2019 17:44:22 -0700
Subject: [LTP] 
 =?utf-8?q?=5BMM_Bug=3F=5D_mmap=28=29_triggers_SIGBUS_while?=
 =?utf-8?b?IGRvaW5nIHRoZeKAiyDigItudW1hX21vdmVfcGFnZXMoKSBmb3Igb2ZmbGlu?=
 =?utf-8?q?ed_hugepage_in_background?=
In-Reply-To: <CAEemH2d=vEfppCbCgVoGdHed2kuY3GWnZGhymYT1rnxjoWNdcQ@mail.gmail.com>
References: <CAEemH2dMW6oh6Bbm=yqUADF+mDhuQgFTTGYftB+xAhqqdYV3Ng@mail.gmail.com>
 <47999e20-ccbe-deda-c960-473db5b56ea0@oracle.com>
 <CAEemH2d=vEfppCbCgVoGdHed2kuY3GWnZGhymYT1rnxjoWNdcQ@mail.gmail.com>
Message-ID: <a65e748b-7297-8547-c18d-9fb07202d5a0@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 7/29/19 11:29 PM, Li Wang wrote:
> It's not 100% reproducible, I tried ten times only hit 4~6 times fail.
> 
> Did you try the test case with patch V3(in my branch)?
> https://github.com/wangli5665/ltp/commit/198fca89870c1b807a01b27bb1d2ec6e2af1c7b6
> 

My bad!  I was using an old version of the test without the soft offline
testing.

> # git clone https://github.com/wangli5665/ltp ltp.wangli --depth=1
> # cd ltp.wangli/; make autotools;
> # ./configure ; make -j24
> # cd testcases/kernel/syscalls/move_pages/
> # ./move_pages12 
> tst_test.c:1100: INFO: Timeout per run is 0h 05m 00s
> move_pages12.c:249: INFO: Free RAM 64386300 kB
> move_pages12.c:267: INFO: Increasing 2048kB hugepages pool on node 0 to 4
> move_pages12.c:277: INFO: Increasing 2048kB hugepages pool on node 1 to 4
> move_pages12.c:193: INFO: Allocating and freeing 4 hugepages on node 0
> move_pages12.c:193: INFO: Allocating and freeing 4 hugepages on node 1
> move_pages12.c:183: PASS: Bug not reproduced
> tst_test.c:1145: BROK: Test killed by SIGBUS!
> move_pages12.c:117: FAIL: move_pages failed: ESRCH

Yes, I can recreate.

When I see this failure, the SIGBUS is the result of a huge page allocation
failure.  The allocation was in response to a page fault.

Note that running the test will deplete memory of the system as huge pages
are marked 'poisoned' and can not be reused.  So, each run of the test will
take additional memory offline.

A SIGBUS is the normal behavior for a hugetlb page fault failure due to
lack of huge pages.  Ugly, but that is the design.  I do not believe this
test should not be experiencing this due to reservations taken at mmap
time.  However, the test is combining faults, soft offline and page
migrations, so the there are lots of moving parts.

I'll continue to investigate.

Naoya may have more context as he contributed to both the kernel code and
the testcase.
-- 
Mike Kravetz
