From: Li Wang <liwang@redhat.com>
Date: Fri, 26 Jul 2019 21:21:55 +0800
Subject: [LTP] [PATCH v2] move_pages12: handle errno EBUSY for
 madvise(..., MADV_SOFT_OFFLINE)
In-Reply-To: <20190726121255.GA28028@rei.lan>
References: <20190725033713.8551-1-liwang@redhat.com>
 <20190726121255.GA28028@rei.lan>
Message-ID: <CAEemH2c96sB1ZA_vnTxSaBy-v=G_WnR58LX+Wt=Q8=UxO0dNtQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> Why so complicated?
> What about just doing usleep() and continue in case of the failure?

Seems I was falling too deep in this bug itself:).

I thought there are two situations we might hit ENOMEM:
1. In the first loop(i == 0), this should be a different issue and
better to break the test.
2. the test hit EBUSY and race condition results in ENOMEM in a
general loop(i >= 1), here we should retry to do mmap(). Even the
retries get arrive LOOPS the test should goto exit and report PASS
with print run times.

To be honest, your simple way also works for those two situations, we
just need to add one more sentence to judge if 'i == 0' before the
break.

So, I agree with you suggest here.


New found by this test:
===================

----------Patch V1---------
I run the patch v1(with EBUSY ignored and no mmap() retry on ENOMEM)
and always get PASS.

# ./move_pages12
tst_test.c:1100: INFO: Timeout per run is 0h 05m 00s
move_pages12.c:251: INFO: Free RAM 189624232 kB
move_pages12.c:269: INFO: Increasing 2048kB hugepages pool on node 0 to 6
move_pages12.c:279: INFO: Increasing 2048kB hugepages pool on node 1 to 4
move_pages12.c:195: INFO: Allocating and freeing 4 hugepages on node 0
move_pages12.c:195: INFO: Allocating and freeing 4 hugepages on node 1
move_pages12.c:185: PASS: Bug not reproduced
i = 4
move_pages12.c:185: PASS: Bug not reproduced

Summary:
passed   2
failed   0
skipped  0
warnings 0

----------Patch V2---------------
But patch v2(no matter go with my complicated retries or you simple
method), It always gets killed by SIGBUS in the retrys mmap() on
ENOMEM, I guess it is a new kernel problem (not same as the first
SIGBUS without commit 6bc9b56433b).

# ./move_pages12
tst_test.c:1100: INFO: Timeout per run is 0h 05m 00s
move_pages12.c:251: INFO: Free RAM 194212832 kB
move_pages12.c:269: INFO: Increasing 2048kB hugepages pool on node 0 to 4
move_pages12.c:279: INFO: Increasing 2048kB hugepages pool on node 1 to 6
move_pages12.c:195: INFO: Allocating and freeing 4 hugepages on node 0
move_pages12.c:195: INFO: Allocating and freeing 4 hugepages on node 1
move_pages12.c:185: PASS: Bug not reproduced
i = 4
i = 6
i = 8
...
i = 136
i = 138
i = 140
tst_test.c:1145: BROK: Test killed by SIGBUS!

Summary:
passed   1
failed   0
skipped  0
warnings 0
move_pages12.c:114: FAIL: move_pages failed: ESRCH


-----system env-----
# uname -r
5.3.0-rc1+

# numactl -H
available: 4 nodes (0-3)
node 0 cpus: 0 1 2 3 16 17 18 19
node 0 size: 32171 MB
node 0 free: 25358 MB
node 1 cpus: 4 5 6 7 20 21 22 23
node 1 size: 16125 MB
node 1 free: 5565 MB
node 2 cpus: 8 9 10 11 24 25 26 27
node 2 size: 96765 MB
node 2 free: 90646 MB
node 3 cpus: 12 13 14 15 28 29 30 31
node 3 size: 64482 MB
node 3 free: 60820 MB
node distances:
node   0   1   2   3
  0:  10  11  11  11
  1:  11  10  11  11
  2:  11  11  10  11
  3:  11  11  11  10

So, maybe we have to re-evaluate this patch V2 and to figure out why
the retry mmap() hitting SIGBUS fails.

--
Regards,
Li Wang
