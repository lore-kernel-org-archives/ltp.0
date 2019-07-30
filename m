From: Li Wang <liwang@redhat.com>
Date: Tue, 30 Jul 2019 14:38:47 +0800
Subject: [LTP] 
	=?utf-8?q?=5BMM_Bug=3F=5D_mmap=28=29_triggers_SIGBUS_while?=
	=?utf-8?b?IGRvaW5nIHRoZeKAiyDigItudW1hX21vdmVfcGFnZXMoKSBmb3Igb2Zm?=
	=?utf-8?q?lined_hugepage_in_background?=
In-Reply-To: <47999e20-ccbe-deda-c960-473db5b56ea0@oracle.com>
References: <CAEemH2dMW6oh6Bbm=yqUADF+mDhuQgFTTGYftB+xAhqqdYV3Ng@mail.gmail.com>
 <47999e20-ccbe-deda-c960-473db5b56ea0@oracle.com>
Message-ID: <CAEemH2eEMS7xrYwTjK8sbNg7OvC7ogRGs24TN8xkkwV1PD4amg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Jul 30, 2019 at 3:01 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
...
> Something seems strange.  I can not reproduce with unmodified 5.2.3
>
> [root@f23d move_pages]# uname -r
> 5.2.3
> [root@f23d move_pages]# PATH=$PATH:$PWD ./move_pages12
> tst_test.c:1096: INFO: Timeout per run is 0h 05m 00s
> move_pages12.c:201: INFO: Free RAM 6725424 kB
> move_pages12.c:219: INFO: Increasing 2048kB hugepages pool on node 0 to 4
> move_pages12.c:229: INFO: Increasing 2048kB hugepages pool on node 1 to 4
> move_pages12.c:145: INFO: Allocating and freeing 4 hugepages on node 0
> move_pages12.c:145: INFO: Allocating and freeing 4 hugepages on node 1
> move_pages12.c:135: PASS: Bug not reproduced
>
> Summary:
> passed   1
> failed   0
> skipped  0
> warnings 0

FYI:

And, from your test log, it looks like you were running an old LTP
version, the test#2 was added in move_page12 in the latest master
branch.

So, the completely test log should be included two-part:

# ./move_pages12
tst_test.c:1100: INFO: Timeout per run is 0h 05m 00s
move_pages12.c:252: INFO: Free RAM 63759028 kB
move_pages12.c:270: INFO: Increasing 2048kB hugepages pool on node 0 to 4
move_pages12.c:280: INFO: Increasing 2048kB hugepages pool on node 1 to 6
move_pages12.c:196: INFO: Allocating and freeing 4 hugepages on node 0
move_pages12.c:196: INFO: Allocating and freeing 4 hugepages on node 1
move_pages12.c:186: PASS: Bug not reproduced
move_pages12.c:186: PASS: Bug not reproduced

Summary:
passed   2
failed   0
skipped  0
warnings 0


-- 
Regards,
Li Wang
