Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MavCH-0006XG-Uu
	for ltp-list@lists.sourceforge.net; Tue, 11 Aug 2009 17:31:41 +0000
Received: from e1.ny.us.ibm.com ([32.97.182.141])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MavC5-0005DJ-GY
	for ltp-list@lists.sourceforge.net; Tue, 11 Aug 2009 17:31:36 +0000
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n7BHVLFX008716
	for <ltp-list@lists.sourceforge.net>; Tue, 11 Aug 2009 13:31:21 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7BHVO74252356
	for <ltp-list@lists.sourceforge.net>; Tue, 11 Aug 2009 13:31:24 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n7BHVN23000324
	for <ltp-list@lists.sourceforge.net>; Tue, 11 Aug 2009 13:31:23 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
Date: Tue, 11 Aug 2009 23:01:14 +0530
Message-Id: <20090811173114.7074.36036.sendpatchset@subratamodak.linux.ibm.com>
In-Reply-To: <20090811172957.7074.62874.sendpatchset@subratamodak.linux.ibm.com>
References: <20090811172957.7074.62874.sendpatchset@subratamodak.linux.ibm.com>
Subject: [LTP] [RESULTS] Results of test run for "Fault Injection Framework"
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: LTP Mailing List <ltp-list@lists.sourceforge.net>
Cc: Sachin P Sant <sachinp@linux.vnet.ibm.com>, Mike Frysinger <vapier@gentoo.org>, Michael Reed <mreed10@us.ibm.com>, Nate Straz <nate@refried.org>, Paul Larson <paul.larson@ubuntu.com>, Manoj Iyer <manoj.iyer@ubuntu.com>, Balbir Singh <balbir@linux.vnet.ibm.com>

Now comes the actual test output the framework will generate. Below are the test
results with and without this Infrastructure on my following machine:

# uname -a
Linux 2.6.29-gcov #1 SMP Fri Jun 19 12:14:27 IST 2009 i686 i686 i386 GNU/Linux

# /runltp -f mm -o ltp_without_fault_injection.out
================================================================================
<<<test_start>>>
tag=mm01 stime=1250003204
cmdline="mmap001 -m 10000"
contacts=""
analysis=exit
<<<test_output>>>
mmap001     0  TINFO  :  mmap()ing file of 10000 pages or 40960000 bytes
mmap001     1  TPASS  :  mmap() completed successfully.
mmap001     0  TINFO  :  touching mmaped memory
mmap001     2  TPASS  :  we're still here, mmaped area must be good
mmap001     3  TPASS  :  msync() was successful
mmap001     4  TPASS  :  munmap() was successful
<<<execution_status>>>
initiation_status="ok"
duration=1 termination_type=exited termination_id=0 corefile=no
cutime=4 cstime=52
<<<test_end>>>
<<<test_start>>>
tag=mm02 stime=1250003205
cmdline="mmap001"
contacts=""
analysis=exit
<<<test_output>>>
mmap001     0  TINFO  :  mmap()ing file of 1000 pages or 4096000 bytes
mmap001     1  TPASS  :  mmap() completed successfully.
mmap001     0  TINFO  :  touching mmaped memory
mmap001     2  TPASS  :  we're still here, mmaped area must be good
mmap001     3  TPASS  :  msync() was successful
mmap001     4  TPASS  :  munmap() was successful
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=1 cstime=5
<<<test_end>>>
<<<test_start>>>
tag=mtest01 stime=1250003205
cmdline="mtest01 -p80"
contacts=""
analysis=exit
<<<test_output>>>
mtest01     0  TINFO  :  Total memory used needed to reach maxpercent = 4923782 kbytes
mtest01     0  TINFO  :  Total memory already used on system = 205396 kbytes
mtest01     0  TINFO  :  Filling up 80% of ram which is 4718386 kbytes
mtest01     1  TPASS  :  4718386 kbytes allocated only.
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=1
<<<test_end>>>
<<<test_start>>>
tag=mtest01w stime=1250003205
cmdline="mtest01 -p80 -w"
contacts=""
analysis=exit
<<<test_output>>>
mtest01     0  TINFO  :  Total memory used needed to reach maxpercent = 4923782 kbytes
mtest01     0  TINFO  :  Total memory already used on system = 215896 kbytes
mtest01     0  TINFO  :  Filling up 80% of ram which is 4707886 kbytes
mtest01     1  TPASS  :  4707886 kbytes allocated and used.
<<<execution_status>>>
initiation_status="ok"
duration=60 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=mtest05 stime=1250003265
cmdline="  mmstress"
contacts=""
analysis=exit
<<<test_output>>>
mmstress    0  TINFO  :  run mmstress -h for all options
mmstress    0  TINFO  :  test1: Test case tests the race condition between simultaneous read faults in the same address space.
mmstress    1  TPASS  :  TEST 1 Passed
mmstress    0  TINFO  :  test2: Test case tests the race condition between simultaneous write faults in the same address space.
mmstress    2  TPASS  :  TEST 2 Passed
mmstress    0  TINFO  :  test3: Test case tests the race condition between simultaneous COW faults in the same address space.
mmstress    3  TPASS  :  TEST 3 Passed
mmstress    0  TINFO  :  test4: Test case tests the race condition between simultaneous READ faults in the same address space. The file mapped is /dev/zero
mmstress    4  TPASS  :  TEST 4 Passed
mmstress    0  TINFO  :  test5: Test case tests the race condition between simultaneous fork - exit faults in the same address space.
mmstress    5  TPASS  :  TEST 5 Passed
mmstress    0  TINFO  :  test6: Test case tests the race condition between simultaneous fork -exec - exit faults in the same address space.
mmstress    6  TPASS  :  TEST 6 Passed
mmstress    7  TPASS  :  Test Passed
<<<execution_status>>>
initiation_status="ok"
duration=7 termination_type=exited termination_id=0 corefile=no
cutime=2 cstime=782
<<<test_end>>>
<<<test_start>>>
tag=mtest06_2 stime=1250003272
cmdline="mmap2 -x 0.002 -a -p"
contacts=""
analysis=exit
<<<test_output>>>
MM Stress test, map/write/unmap large file
	Test scheduled to run for:       0.002000
	Size of temp file in GB:         1
file mapped at 0x7c53b000
changing file content to 'A'
unmapped file at 0x7c53b000
file mapped at 0x7c53b000
changing file content to 'A'
unmapped file at 0x7c53b000
file mapped at 0x7c53b000
changing file content to 'A'
Test ended, success
<<<execution_status>>>
initiation_status="ok"
duration=7 termination_type=exited termination_id=0 corefile=no
cutime=45 cstime=668
<<<test_end>>>
<<<test_start>>>
tag=mtest06_3 stime=1250003279
cmdline="mmap3 -x 0.002 -p"
contacts=""
analysis=exit
<<<test_output>>>



Test is set to run with the following parameters:
	Duration of test: [0.002000]hrs
	Number of threads created: [40]
	number of map-write-unmaps: [1000]
	map_private?(T=1 F=0): [1]



Map address = 0xa3ed6000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa335a000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa3480000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa3ed6000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa3918000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa35a6000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa3a3e000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa37f2000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa3db0000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa3c8a000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa36cc000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa3b64000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa2369000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa3735000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa1fb8000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa3ae6000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa385b000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa287f000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa2d95000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa20de000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa3d71000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa25f4000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa0906000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa3020000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa1d2d000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa1817000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa3536000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa0f8f000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa32ab000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x9ed14000
Num iter: [2]
Total Num Iter: [1000]Map address = 0xa0d90000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa2b0a000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa118e000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x9eb15000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x9ef13000
Num iter: [2]
Total Num Iter: [1000]Map address = 0xa010a000
Num iter: [2]
Total Num Iter: [1000]Map address = 0x9ff0b000
Num iter: [2]
Total Num Iter: [1000]Map address = 0xa0309000
Num iter: [2]
Total Num Iter: [1000]Map address = 0xa1aa2000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa23f5000
Num iter: [2]
Total Num Iter: [1000]Map address = 0x9f90e000
Num iter: [2]
Total Num Iter: [1000]Map address = 0x9fb0d000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x9f112000
Num iter: [2]
Total Num Iter: [1000]Map address = 0xa0b91000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x9f510000
Num iter: [2]
Total Num Iter: [1000]Map address = 0xa0508000
Num iter: [2]
Total Num Iter: [1000]Map address = 0xa138d000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x9fd0c000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa158c000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa3a9b000
Num iter: [2]
Total Num Iter: [1000]Map address = 0xa0707000
Num iter: [2]
Total Num Iter: [1000]Map address = 0x9f70f000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa37c5000
Num iter: [2]
Total Num Iter: [1000]Map address = 0xa3d26000
Num iter: [2]
Total Num Iter: [1000]Map address = 0x9f311000
Num iter: [2]
Total Num Iter: [1000]Test ended, success
<<<execution_status>>>
initiation_status="ok"
duration=8 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=521
<<<test_end>>>
<<<test_start>>>
tag=mem01 stime=1250003287
cmdline="mem01"
contacts=""
analysis=exit
<<<test_output>>>
mem01       0  TINFO  :  Free Mem:	1962 Mb
mem01       0  TINFO  :  Free Swap:	3944 Mb
mem01       0  TINFO  :  Total Free:	5906 Mb
mem01       0  TINFO  :  Total Tested:	1008 Mb
mem01       0  TINFO  :  touching 1008MB of malloc'ed memory (linear)
mem01       1  TPASS  :  malloc - alloc of 1008MB succeeded
<<<execution_status>>>
initiation_status="ok"
duration=3 termination_type=exited termination_id=0 corefile=no
cutime=7 cstime=289
<<<test_end>>>
<<<test_start>>>
tag=mem02 stime=1250003290
cmdline="mem02"
contacts=""
analysis=exit
<<<test_output>>>
mem02       1  TPASS  :  calloc - calloc of 64MB of memory succeeded
mem02       2  TPASS  :  malloc - malloc of 64MB of memory succeeded
mem02       3  TPASS  :  realloc - realloc of 5 bytes succeeded
mem02       4  TPASS  :  realloc - realloc of 15 bytes succeeded
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=38 cstime=37
<<<test_end>>>
<<<test_start>>>
tag=mem03 stime=1250003290
cmdline="mem03"
contacts=""
analysis=exit
<<<test_output>>>
<<<execution_status>>>
initiation_status="ok"
duration=1 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=1
<<<test_end>>>
<<<test_start>>>
tag=page01 stime=1250003291
cmdline="page01"
contacts=""
analysis=exit
<<<test_output>>>
page01      1  TPASS  :  Test passed
<<<execution_status>>>
initiation_status="ok"
duration=1 termination_type=exited termination_id=0 corefile=no
cutime=6 cstime=24
<<<test_end>>>
<<<test_start>>>
tag=page02 stime=1250003292
cmdline="page02"
contacts=""
analysis=exit
<<<test_output>>>
page02      1  TPASS  :  Test passed
<<<execution_status>>>
initiation_status="ok"
duration=1 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=2
<<<test_end>>>
<<<test_start>>>
tag=data_space stime=1250003293
cmdline="data_space"
contacts=""
analysis=exit
<<<test_output>>>
data_space    1  TPASS  :  Test passed
<<<execution_status>>>
initiation_status="ok"
duration=1 termination_type=exited termination_id=0 corefile=no
cutime=258 cstime=5
<<<test_end>>>
<<<test_start>>>
tag=stack_space stime=1250003294
cmdline="stack_space"
contacts=""
analysis=exit
<<<test_output>>>
stack_space    1  TPASS  :  Test passed
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=9 cstime=1
<<<test_end>>>
<<<test_start>>>
tag=shmt02 stime=1250003294
cmdline="shmt02"
contacts=""
analysis=exit
<<<test_output>>>
shmt02      1  TPASS  :  shmget
shmt02      2  TPASS  :  shmat
shmt02      3  TPASS  :  Correct shared memory contents
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=shmt03 stime=1250003294
cmdline="shmt03"
contacts=""
analysis=exit
<<<test_output>>>
shmt03      1  TPASS  :  shmget
shmt03      2  TPASS  :  1st shmat
shmt03      3  TPASS  :  2nd shmat
shmt03      4  TPASS  :  Correct shared memory contents
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=shmt04 stime=1250003294
cmdline="shmt04"
contacts=""
analysis=exit
<<<test_output>>>
shmt04      1  TPASS  :  shmget,shmat
shmt04      2  TPASS  :  shmdt
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=1
<<<test_end>>>
<<<test_start>>>
tag=shmt05 stime=1250003294
cmdline="shmt05"
contacts=""
analysis=exit
<<<test_output>>>
shmt05      1  TPASS  :  shmget & shmat
shmt05      2  TPASS  :  2nd shmget & shmat
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=shmt06 stime=1250003294
cmdline="shmt06"
contacts=""
analysis=exit
<<<test_output>>>
shmt06      1  TPASS  :  shmget,shmat
shmt06      2  TPASS  :  shmdt
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=shmt07 stime=1250003294
cmdline="shmt07"
contacts=""
analysis=exit
<<<test_output>>>
shmt07      1  TPASS  :  shmget,shmat
shmt07      1  TPASS  :  shmget,shmat
shmt07      2  TPASS  :  cp & cp+1 correct
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=1
<<<test_end>>>
<<<test_start>>>
tag=shmt08 stime=1250003294
cmdline="shmt08"
contacts=""
analysis=exit
<<<test_output>>>
shmt08      1  TPASS  :  shmget,shmat
shmt08      2  TPASS  :  shmdt
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=shmt09 stime=1250003294
cmdline="shmt09"
contacts=""
analysis=exit
<<<test_output>>>
shmt09      1  TPASS  :  sbrk, sbrk, shmget, shmat
shmt09      2  TPASS  :  sbrk, shmat
shmt09      3  TPASS  :  sbrk, shmat
shmt09      4  TPASS  :  sbrk
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=shmt10 stime=1250003294
cmdline="shmt10"
contacts=""
analysis=exit
<<<test_output>>>
shmt10      1  TPASS  :  shmat,shmdt
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=3
<<<test_end>>>
<<<test_start>>>
tag=shm_test01 stime=1250003294
cmdline="shm_test -l 10 -t 2"
contacts=""
analysis=exit
<<<test_output>>>
pid[30625]: shmat_rd_wr(): shmget():success got segment id 1212420
pid[30625]: do_shmat_shmadt(): got shmat address = 0xb6f02000
pid[30625]: shmat_rd_wr(): shmget():success got segment id 1212420
pid[30625]: do_shmat_shmadt(): got shmat address = 0xb6e55000
pid[30625]: shmat_rd_wr(): shmget():success got segment id 1245189
pid[30625]: do_shmat_shmadt(): got shmat address = 0xb6f02000
pid[30625]: shmat_rd_wr(): shmget():success got segment id 1245189
pid[30625]: do_shmat_shmadt(): got shmat address = 0xb6e55000
pid[30625]: shmat_rd_wr(): shmget():success got segment id 1277956
pid[30625]: do_shmat_shmadt(): got shmat address = 0xb6f02000
pid[30625]: shmat_rd_wr(): shmget():success got segment id 1277956
pid[30625]: do_shmat_shmadt(): got shmat address = 0xb6e55000
pid[30625]: shmat_rd_wr(): shmget():success got segment id 1310725
pid[30625]: do_shmat_shmadt(): got shmat address = 0xb6f02000
pid[30625]: shmat_rd_wr(): shmget():success got segment id 1310725
pid[30625]: do_shmat_shmadt(): got shmat address = 0xb6e55000
pid[30625]: shmat_rd_wr(): shmget():success got segment id 1343492
pid[30625]: do_shmat_shmadt(): got shmat address = 0xb6f02000
pid[30625]: shmat_rd_wr(): shmget():success got segment id 1343492
pid[30625]: do_shmat_shmadt(): got shmat address = 0xb6e55000
pid[30625]: shmat_rd_wr(): shmget():success got segment id 1376261
pid[30625]: do_shmat_shmadt(): got shmat address = 0xb6f02000
pid[30625]: shmat_rd_wr(): shmget():success got segment id 1376261
pid[30625]: do_shmat_shmadt(): got shmat address = 0xb6e55000
pid[30625]: shmat_rd_wr(): shmget():success got segment id 1409028
pid[30625]: do_shmat_shmadt(): got shmat address = 0xb6f02000
pid[30625]: shmat_rd_wr(): shmget():success got segment id 1409028
pid[30625]: do_shmat_shmadt(): got shmat address = 0xb6e55000
pid[30625]: shmat_rd_wr(): shmget():success got segment id 1441797
pid[30625]: do_shmat_shmadt(): got shmat address = 0xb6f02000
pid[30625]: shmat_rd_wr(): shmget():success got segment id 1441797
pid[30625]: do_shmat_shmadt(): got shmat address = 0xb6e55000
pid[30625]: shmat_rd_wr(): shmget():success got segment id 1474564
pid[30625]: do_shmat_shmadt(): got shmat address = 0xb6f02000
pid[30625]: shmat_rd_wr(): shmget():success got segment id 1474564
pid[30625]: do_shmat_shmadt(): got shmat address = 0xb6e55000
pid[30625]: shmat_rd_wr(): shmget():success got segment id 1507333
pid[30625]: do_shmat_shmadt(): got shmat address = 0xb6f02000
pid[30625]: shmat_rd_wr(): shmget():success got segment id 1507333
pid[30625]: do_shmat_shmadt(): got shmat address = 0xb6e55000
<<<execution_status>>>
initiation_status="ok"
duration=31 termination_type=exited termination_id=0 corefile=no
cutime=724 cstime=5363
<<<test_end>>>
<<<test_start>>>
tag=mallocstress01 stime=1250003325
cmdline="mallocstress"
contacts=""
analysis=exit
<<<test_output>>>
Thread [47]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [43]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [39]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [31]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [23]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [35]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [7]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [11]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [3]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [15]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [51]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [19]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [55]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [27]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [59]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [54]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [38]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [14]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [10]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [46]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [42]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [34]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [18]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [22]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [50]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [58]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [6]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [30]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [26]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [2]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [41]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [21]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [33]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [57]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [49]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [13]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [29]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [45]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [53]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [17]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [9]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [1]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [37]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [25]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [5]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [32]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [36]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [12]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [56]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [48]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [52]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [24]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [16]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [40]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [44]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [4]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [28]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [0]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [8]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [20]: allocate_free() returned 0, succeeded.  Thread exiting.
main(): test passed.
<<<execution_status>>>
initiation_status="ok"
duration=8 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=787
<<<test_end>>>
<<<test_start>>>
tag=mmapstress01 stime=1250003333
cmdline="mmapstress01 -p 20 -t 0.2"
contacts=""
analysis=exit
<<<test_output>>>
file data okay
mmapstress01    1  TPASS  :  Test passed
<<<execution_status>>>
initiation_status="ok"
duration=12 termination_type=exited termination_id=0 corefile=no
cutime=1371 cstime=758
<<<test_end>>>
<<<test_start>>>
tag=mmapstress02 stime=1250003345
cmdline="mmapstress02"
contacts=""
analysis=exit
<<<test_output>>>
mmapstress02    1  TPASS  :  Test passed

<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=mmapstress03 stime=1250003345
cmdline="mmapstress03"
contacts=""
analysis=exit
<<<test_output>>>
mmapstress03    1  TPASS  :  Test passed
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=1
<<<test_end>>>
<<<test_start>>>
tag=mmapstress04 stime=1250003345
cmdline="TMPFILE=`mktemp /tmp/example.XXXXXXXXXX`; ls -lR /usr/include/ > $TMPFILE; mmapstress04 $TMPFILE"
contacts=""
analysis=exit
<<<test_output>>>
mmapstress04    1  TPASS  :  Test passed

<<<execution_status>>>
initiation_status="ok"
duration=8 termination_type=exited termination_id=0 corefile=no
cutime=32 cstime=201
<<<test_end>>>
<<<test_start>>>
tag=mmapstress05 stime=1250003353
cmdline="mmapstress05"
contacts=""
analysis=exit
<<<test_output>>>
mmapstress05    1  TPASS  :  Test passed

<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=mmapstress06 stime=1250003353
cmdline="mmapstress06 20"
contacts=""
analysis=exit
<<<test_output>>>
mmapstress06    1  TPASS  :  Test passed

<<<execution_status>>>
initiation_status="ok"
duration=20 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=mmapstress07 stime=1250003373
cmdline="TMPFILE=`mktemp /tmp/example.XXXXXXXXXXXX`; mmapstress07 $TMPFILE"
contacts=""
analysis=exit
<<<test_output>>>
mmapstress07    1  TPASS  :  Test passed

<<<execution_status>>>
initiation_status="ok"
duration=1 termination_type=exited termination_id=0 corefile=no
cutime=2 cstime=21
<<<test_end>>>
<<<test_start>>>
tag=mmapstress08 stime=1250003374
cmdline="mmapstress08"
contacts=""
analysis=exit
<<<test_output>>>
mmapstress08    1  TPASS  :  Test passed

<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=1
<<<test_end>>>
<<<test_start>>>
tag=mmapstress09 stime=1250003374
cmdline="mmapstress09 -p 20 -t 0.2"
contacts=""
analysis=exit
<<<test_output>>>
map data okay
mmapstress09    1  TPASS  :  Test passed

<<<execution_status>>>
initiation_status="ok"
duration=12 termination_type=exited termination_id=0 corefile=no
cutime=1401 cstime=730
<<<test_end>>>
<<<test_start>>>
tag=mmapstress10 stime=1250003386
cmdline="mmapstress10 -p 20 -t 0.2"
contacts=""
analysis=exit
<<<test_output>>>
file data okay
mmapstress10    1  TPASS  :  Test passed

incrementing stop
<<<execution_status>>>
initiation_status="ok"
duration=12 termination_type=exited termination_id=0 corefile=no
cutime=992 cstime=1123
<<<test_end>>>
================================================================================

================================================================================
# ./runltp -f mm -F 6,15 -o ltp_with_fault_injection.out
================================================================================
<<<test_start>>>
tag=mm01 stime=1250003204
cmdline="mmap001 -m 10000"
contacts=""
analysis=exit
<<<test_output>>>
mmap001     0  TINFO  :  mmap()ing file of 10000 pages or 40960000 bytes
mmap001     1  TPASS  :  mmap() completed successfully.
mmap001     0  TINFO  :  touching mmaped memory
mmap001     2  TPASS  :  we're still here, mmaped area must be good
mmap001     3  TPASS  :  msync() was successful
mmap001     4  TPASS  :  munmap() was successful
<<<execution_status>>>
initiation_status="ok"
duration=1 termination_type=exited termination_id=0 corefile=no
cutime=4 cstime=52
<<<test_end>>>
<<<test_start>>>
tag=mm02 stime=1250003205
cmdline="mmap001"
contacts=""
analysis=exit
<<<test_output>>>
mmap001     0  TINFO  :  mmap()ing file of 1000 pages or 4096000 bytes
mmap001     1  TPASS  :  mmap() completed successfully.
mmap001     0  TINFO  :  touching mmaped memory
mmap001     2  TPASS  :  we're still here, mmaped area must be good
mmap001     3  TPASS  :  msync() was successful
mmap001     4  TPASS  :  munmap() was successful
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=1 cstime=5
<<<test_end>>>
<<<test_start>>>
tag=mtest01 stime=1250003205
cmdline="mtest01 -p80"
contacts=""
analysis=exit
<<<test_output>>>
mtest01     0  TINFO  :  Total memory used needed to reach maxpercent = 4923782 kbytes
mtest01     0  TINFO  :  Total memory already used on system = 205396 kbytes
mtest01     0  TINFO  :  Filling up 80% of ram which is 4718386 kbytes
mtest01     1  TPASS  :  4718386 kbytes allocated only.
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=1
<<<test_end>>>
<<<test_start>>>
tag=mtest01w stime=1250003205
cmdline="mtest01 -p80 -w"
contacts=""
analysis=exit
<<<test_output>>>
mtest01     0  TINFO  :  Total memory used needed to reach maxpercent = 4923782 kbytes
mtest01     0  TINFO  :  Total memory already used on system = 215896 kbytes
mtest01     0  TINFO  :  Filling up 80% of ram which is 4707886 kbytes
mtest01     1  TPASS  :  4707886 kbytes allocated and used.
<<<execution_status>>>
initiation_status="ok"
duration=60 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=mtest05 stime=1250003265
cmdline="  mmstress"
contacts=""
analysis=exit
<<<test_output>>>
mmstress    0  TINFO  :  run mmstress -h for all options
mmstress    0  TINFO  :  test1: Test case tests the race condition between simultaneous read faults in the same address space.
mmstress    1  TPASS  :  TEST 1 Passed
mmstress    0  TINFO  :  test2: Test case tests the race condition between simultaneous write faults in the same address space.
mmstress    2  TPASS  :  TEST 2 Passed
mmstress    0  TINFO  :  test3: Test case tests the race condition between simultaneous COW faults in the same address space.
mmstress    3  TPASS  :  TEST 3 Passed
mmstress    0  TINFO  :  test4: Test case tests the race condition between simultaneous READ faults in the same address space. The file mapped is /dev/zero
mmstress    4  TPASS  :  TEST 4 Passed
mmstress    0  TINFO  :  test5: Test case tests the race condition between simultaneous fork - exit faults in the same address space.
mmstress    5  TPASS  :  TEST 5 Passed
mmstress    0  TINFO  :  test6: Test case tests the race condition between simultaneous fork -exec - exit faults in the same address space.
mmstress    6  TPASS  :  TEST 6 Passed
mmstress    7  TPASS  :  Test Passed
<<<execution_status>>>
initiation_status="ok"
duration=7 termination_type=exited termination_id=0 corefile=no
cutime=2 cstime=782
<<<test_end>>>
<<<test_start>>>
tag=mtest06_2 stime=1250003272
cmdline="mmap2 -x 0.002 -a -p"
contacts=""
analysis=exit
<<<test_output>>>
MM Stress test, map/write/unmap large file
	Test scheduled to run for:       0.002000
	Size of temp file in GB:         1
file mapped at 0x7c53b000
changing file content to 'A'
unmapped file at 0x7c53b000
file mapped at 0x7c53b000
changing file content to 'A'
unmapped file at 0x7c53b000
file mapped at 0x7c53b000
changing file content to 'A'
Test ended, success
<<<execution_status>>>
initiation_status="ok"
duration=7 termination_type=exited termination_id=0 corefile=no
cutime=45 cstime=668
<<<test_end>>>
<<<test_start>>>
tag=mtest06_3 stime=1250003279
cmdline="mmap3 -x 0.002 -p"
contacts=""
analysis=exit
<<<test_output>>>



Test is set to run with the following parameters:
	Duration of test: [0.002000]hrs
	Number of threads created: [40]
	number of map-write-unmaps: [1000]
	map_private?(T=1 F=0): [1]



Map address = 0xa3ed6000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa335a000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa3480000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa3ed6000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa3918000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa35a6000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa3a3e000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa37f2000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa3db0000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa3c8a000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa36cc000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa3b64000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa2369000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa3735000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa1fb8000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa3ae6000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa385b000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa287f000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa2d95000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa20de000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa3d71000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa25f4000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa0906000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa3020000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa1d2d000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa1817000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa3536000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa0f8f000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa32ab000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x9ed14000
Num iter: [2]
Total Num Iter: [1000]Map address = 0xa0d90000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa2b0a000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa118e000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x9eb15000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x9ef13000
Num iter: [2]
Total Num Iter: [1000]Map address = 0xa010a000
Num iter: [2]
Total Num Iter: [1000]Map address = 0x9ff0b000
Num iter: [2]
Total Num Iter: [1000]Map address = 0xa0309000
Num iter: [2]
Total Num Iter: [1000]Map address = 0xa1aa2000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa23f5000
Num iter: [2]
Total Num Iter: [1000]Map address = 0x9f90e000
Num iter: [2]
Total Num Iter: [1000]Map address = 0x9fb0d000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x9f112000
Num iter: [2]
Total Num Iter: [1000]Map address = 0xa0b91000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x9f510000
Num iter: [2]
Total Num Iter: [1000]Map address = 0xa0508000
Num iter: [2]
Total Num Iter: [1000]Map address = 0xa138d000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x9fd0c000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa158c000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa3a9b000
Num iter: [2]
Total Num Iter: [1000]Map address = 0xa0707000
Num iter: [2]
Total Num Iter: [1000]Map address = 0x9f70f000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa37c5000
Num iter: [2]
Total Num Iter: [1000]Map address = 0xa3d26000
Num iter: [2]
Total Num Iter: [1000]Map address = 0x9f311000
Num iter: [2]
Total Num Iter: [1000]Test ended, success
<<<execution_status>>>
initiation_status="ok"
duration=8 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=521
<<<test_end>>>
<<<test_start>>>
tag=mem01 stime=1250003287
cmdline="mem01"
contacts=""
analysis=exit
<<<test_output>>>
mem01       0  TINFO  :  Free Mem:	1962 Mb
mem01       0  TINFO  :  Free Swap:	3944 Mb
mem01       0  TINFO  :  Total Free:	5906 Mb
mem01       0  TINFO  :  Total Tested:	1008 Mb
mem01       0  TINFO  :  touching 1008MB of malloc'ed memory (linear)
mem01       1  TPASS  :  malloc - alloc of 1008MB succeeded
<<<execution_status>>>
initiation_status="ok"
duration=3 termination_type=exited termination_id=0 corefile=no
cutime=7 cstime=289
<<<test_end>>>
<<<test_start>>>
tag=mem02 stime=1250003290
cmdline="mem02"
contacts=""
analysis=exit
<<<test_output>>>
mem02       1  TPASS  :  calloc - calloc of 64MB of memory succeeded
mem02       2  TPASS  :  malloc - malloc of 64MB of memory succeeded
mem02       3  TPASS  :  realloc - realloc of 5 bytes succeeded
mem02       4  TPASS  :  realloc - realloc of 15 bytes succeeded
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=38 cstime=37
<<<test_end>>>
<<<test_start>>>
tag=mem03 stime=1250003290
cmdline="mem03"
contacts=""
analysis=exit
<<<test_output>>>
<<<execution_status>>>
initiation_status="ok"
duration=1 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=1
<<<test_end>>>
<<<test_start>>>
tag=page01 stime=1250003291
cmdline="page01"
contacts=""
analysis=exit
<<<test_output>>>
page01      1  TPASS  :  Test passed
<<<execution_status>>>
initiation_status="ok"
duration=1 termination_type=exited termination_id=0 corefile=no
cutime=6 cstime=24
<<<test_end>>>
<<<test_start>>>
tag=page02 stime=1250003292
cmdline="page02"
contacts=""
analysis=exit
<<<test_output>>>
page02      1  TPASS  :  Test passed
<<<execution_status>>>
initiation_status="ok"
duration=1 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=2
<<<test_end>>>
<<<test_start>>>
tag=data_space stime=1250003293
cmdline="data_space"
contacts=""
analysis=exit
<<<test_output>>>
data_space    1  TPASS  :  Test passed
<<<execution_status>>>
initiation_status="ok"
duration=1 termination_type=exited termination_id=0 corefile=no
cutime=258 cstime=5
<<<test_end>>>
<<<test_start>>>
tag=stack_space stime=1250003294
cmdline="stack_space"
contacts=""
analysis=exit
<<<test_output>>>
stack_space    1  TPASS  :  Test passed
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=9 cstime=1
<<<test_end>>>
<<<test_start>>>
tag=shmt02 stime=1250003294
cmdline="shmt02"
contacts=""
analysis=exit
<<<test_output>>>
shmt02      1  TPASS  :  shmget
shmt02      2  TPASS  :  shmat
shmt02      3  TPASS  :  Correct shared memory contents
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=shmt03 stime=1250003294
cmdline="shmt03"
contacts=""
analysis=exit
<<<test_output>>>
shmt03      1  TPASS  :  shmget
shmt03      2  TPASS  :  1st shmat
shmt03      3  TPASS  :  2nd shmat
shmt03      4  TPASS  :  Correct shared memory contents
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=shmt04 stime=1250003294
cmdline="shmt04"
contacts=""
analysis=exit
<<<test_output>>>
shmt04      1  TPASS  :  shmget,shmat
shmt04      2  TPASS  :  shmdt
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=1
<<<test_end>>>
<<<test_start>>>
tag=shmt05 stime=1250003294
cmdline="shmt05"
contacts=""
analysis=exit
<<<test_output>>>
shmt05      1  TPASS  :  shmget & shmat
shmt05      2  TPASS  :  2nd shmget & shmat
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=shmt06 stime=1250003294
cmdline="shmt06"
contacts=""
analysis=exit
<<<test_output>>>
shmt06      1  TPASS  :  shmget,shmat
shmt06      2  TPASS  :  shmdt
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=shmt07 stime=1250003294
cmdline="shmt07"
contacts=""
analysis=exit
<<<test_output>>>
shmt07      1  TPASS  :  shmget,shmat
shmt07      1  TPASS  :  shmget,shmat
shmt07      2  TPASS  :  cp & cp+1 correct
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=1
<<<test_end>>>
<<<test_start>>>
tag=shmt08 stime=1250003294
cmdline="shmt08"
contacts=""
analysis=exit
<<<test_output>>>
shmt08      1  TPASS  :  shmget,shmat
shmt08      2  TPASS  :  shmdt
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=shmt09 stime=1250003294
cmdline="shmt09"
contacts=""
analysis=exit
<<<test_output>>>
shmt09      1  TPASS  :  sbrk, sbrk, shmget, shmat
shmt09      2  TPASS  :  sbrk, shmat
shmt09      3  TPASS  :  sbrk, shmat
shmt09      4  TPASS  :  sbrk
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=shmt10 stime=1250003294
cmdline="shmt10"
contacts=""
analysis=exit
<<<test_output>>>
shmt10      1  TPASS  :  shmat,shmdt
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=3
<<<test_end>>>
<<<test_start>>>
tag=shm_test01 stime=1250003294
cmdline="shm_test -l 10 -t 2"
contacts=""
analysis=exit
<<<test_output>>>
pid[30625]: shmat_rd_wr(): shmget():success got segment id 1212420
pid[30625]: do_shmat_shmadt(): got shmat address = 0xb6f02000
pid[30625]: shmat_rd_wr(): shmget():success got segment id 1212420
pid[30625]: do_shmat_shmadt(): got shmat address = 0xb6e55000
pid[30625]: shmat_rd_wr(): shmget():success got segment id 1245189
pid[30625]: do_shmat_shmadt(): got shmat address = 0xb6f02000
pid[30625]: shmat_rd_wr(): shmget():success got segment id 1245189
pid[30625]: do_shmat_shmadt(): got shmat address = 0xb6e55000
pid[30625]: shmat_rd_wr(): shmget():success got segment id 1277956
pid[30625]: do_shmat_shmadt(): got shmat address = 0xb6f02000
pid[30625]: shmat_rd_wr(): shmget():success got segment id 1277956
pid[30625]: do_shmat_shmadt(): got shmat address = 0xb6e55000
pid[30625]: shmat_rd_wr(): shmget():success got segment id 1310725
pid[30625]: do_shmat_shmadt(): got shmat address = 0xb6f02000
pid[30625]: shmat_rd_wr(): shmget():success got segment id 1310725
pid[30625]: do_shmat_shmadt(): got shmat address = 0xb6e55000
pid[30625]: shmat_rd_wr(): shmget():success got segment id 1343492
pid[30625]: do_shmat_shmadt(): got shmat address = 0xb6f02000
pid[30625]: shmat_rd_wr(): shmget():success got segment id 1343492
pid[30625]: do_shmat_shmadt(): got shmat address = 0xb6e55000
pid[30625]: shmat_rd_wr(): shmget():success got segment id 1376261
pid[30625]: do_shmat_shmadt(): got shmat address = 0xb6f02000
pid[30625]: shmat_rd_wr(): shmget():success got segment id 1376261
pid[30625]: do_shmat_shmadt(): got shmat address = 0xb6e55000
pid[30625]: shmat_rd_wr(): shmget():success got segment id 1409028
pid[30625]: do_shmat_shmadt(): got shmat address = 0xb6f02000
pid[30625]: shmat_rd_wr(): shmget():success got segment id 1409028
pid[30625]: do_shmat_shmadt(): got shmat address = 0xb6e55000
pid[30625]: shmat_rd_wr(): shmget():success got segment id 1441797
pid[30625]: do_shmat_shmadt(): got shmat address = 0xb6f02000
pid[30625]: shmat_rd_wr(): shmget():success got segment id 1441797
pid[30625]: do_shmat_shmadt(): got shmat address = 0xb6e55000
pid[30625]: shmat_rd_wr(): shmget():success got segment id 1474564
pid[30625]: do_shmat_shmadt(): got shmat address = 0xb6f02000
pid[30625]: shmat_rd_wr(): shmget():success got segment id 1474564
pid[30625]: do_shmat_shmadt(): got shmat address = 0xb6e55000
pid[30625]: shmat_rd_wr(): shmget():success got segment id 1507333
pid[30625]: do_shmat_shmadt(): got shmat address = 0xb6f02000
pid[30625]: shmat_rd_wr(): shmget():success got segment id 1507333
pid[30625]: do_shmat_shmadt(): got shmat address = 0xb6e55000
<<<execution_status>>>
initiation_status="ok"
duration=31 termination_type=exited termination_id=0 corefile=no
cutime=724 cstime=5363
<<<test_end>>>
<<<test_start>>>
tag=mallocstress01 stime=1250003325
cmdline="mallocstress"
contacts=""
analysis=exit
<<<test_output>>>
Thread [47]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [43]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [39]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [31]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [23]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [35]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [7]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [11]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [3]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [15]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [51]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [19]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [55]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [27]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [59]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [54]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [38]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [14]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [10]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [46]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [42]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [34]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [18]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [22]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [50]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [58]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [6]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [30]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [26]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [2]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [41]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [21]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [33]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [57]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [49]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [13]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [29]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [45]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [53]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [17]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [9]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [1]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [37]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [25]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [5]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [32]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [36]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [12]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [56]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [48]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [52]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [24]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [16]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [40]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [44]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [4]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [28]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [0]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [8]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [20]: allocate_free() returned 0, succeeded.  Thread exiting.
main(): test passed.
<<<execution_status>>>
initiation_status="ok"
duration=8 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=787
<<<test_end>>>
<<<test_start>>>
tag=mmapstress01 stime=1250003333
cmdline="mmapstress01 -p 20 -t 0.2"
contacts=""
analysis=exit
<<<test_output>>>
file data okay
mmapstress01    1  TPASS  :  Test passed
<<<execution_status>>>
initiation_status="ok"
duration=12 termination_type=exited termination_id=0 corefile=no
cutime=1371 cstime=758
<<<test_end>>>
<<<test_start>>>
tag=mmapstress02 stime=1250003345
cmdline="mmapstress02"
contacts=""
analysis=exit
<<<test_output>>>
mmapstress02    1  TPASS  :  Test passed

<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=mmapstress03 stime=1250003345
cmdline="mmapstress03"
contacts=""
analysis=exit
<<<test_output>>>
mmapstress03    1  TPASS  :  Test passed
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=1
<<<test_end>>>
<<<test_start>>>
tag=mmapstress04 stime=1250003345
cmdline="TMPFILE=`mktemp /tmp/example.XXXXXXXXXX`; ls -lR /usr/include/ > $TMPFILE; mmapstress04 $TMPFILE"
contacts=""
analysis=exit
<<<test_output>>>
mmapstress04    1  TPASS  :  Test passed

<<<execution_status>>>
initiation_status="ok"
duration=8 termination_type=exited termination_id=0 corefile=no
cutime=32 cstime=201
<<<test_end>>>
<<<test_start>>>
tag=mmapstress05 stime=1250003353
cmdline="mmapstress05"
contacts=""
analysis=exit
<<<test_output>>>
mmapstress05    1  TPASS  :  Test passed

<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=mmapstress06 stime=1250003353
cmdline="mmapstress06 20"
contacts=""
analysis=exit
<<<test_output>>>
mmapstress06    1  TPASS  :  Test passed

<<<execution_status>>>
initiation_status="ok"
duration=20 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=mmapstress07 stime=1250003373
cmdline="TMPFILE=`mktemp /tmp/example.XXXXXXXXXXXX`; mmapstress07 $TMPFILE"
contacts=""
analysis=exit
<<<test_output>>>
mmapstress07    1  TPASS  :  Test passed

<<<execution_status>>>
initiation_status="ok"
duration=1 termination_type=exited termination_id=0 corefile=no
cutime=2 cstime=21
<<<test_end>>>
<<<test_start>>>
tag=mmapstress08 stime=1250003374
cmdline="mmapstress08"
contacts=""
analysis=exit
<<<test_output>>>
mmapstress08    1  TPASS  :  Test passed

<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=1
<<<test_end>>>
<<<test_start>>>
tag=mmapstress09 stime=1250003374
cmdline="mmapstress09 -p 20 -t 0.2"
contacts=""
analysis=exit
<<<test_output>>>
map data okay
mmapstress09    1  TPASS  :  Test passed

<<<execution_status>>>
initiation_status="ok"
duration=12 termination_type=exited termination_id=0 corefile=no
cutime=1401 cstime=730
<<<test_end>>>
<<<test_start>>>
tag=mmapstress10 stime=1250003386
cmdline="mmapstress10 -p 20 -t 0.2"
contacts=""
analysis=exit
<<<test_output>>>
file data okay
mmapstress10    1  TPASS  :  Test passed

incrementing stop
<<<execution_status>>>
initiation_status="ok"
duration=12 termination_type=exited termination_id=0 corefile=no
cutime=992 cstime=1123
<<<test_end>>>
================================================================================

Regards--
Subrata


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
