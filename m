Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MfVw3-0003Il-5z
	for ltp-list@lists.sourceforge.net; Mon, 24 Aug 2009 09:33:55 +0000
Received: from e9.ny.us.ibm.com ([32.97.182.139])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MfVvv-00058Y-Va
	for ltp-list@lists.sourceforge.net; Mon, 24 Aug 2009 09:33:55 +0000
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e9.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n7O9WJd2009702
	for <ltp-list@lists.sourceforge.net>; Mon, 24 Aug 2009 05:32:19 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7O9Xg1e252874
	for <ltp-list@lists.sourceforge.net>; Mon, 24 Aug 2009 05:33:42 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n7O9UiOP011428
	for <ltp-list@lists.sourceforge.net>; Mon, 24 Aug 2009 05:30:45 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
Date: Mon, 24 Aug 2009 15:03:08 +0530
Message-Id: <20090824093307.31997.37906.sendpatchset@subratamodak.linux.ibm.com>
In-Reply-To: <20090824093204.31997.18175.sendpatchset@subratamodak.linux.ibm.com>
References: <20090824093204.31997.18175.sendpatchset@subratamodak.linux.ibm.com>
Subject: [LTP] [RESULTS] The Actual results of the tests run with the new
	interface
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

Now, the actual results of test run using and not-using this infrastructure:

====================================================
# ./runltp -f mm -o ltp_mm_test_general
====================================================
<<<test_start>>>
tag=mm01 stime=1251102056
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
cutime=5 cstime=50
<<<test_end>>>
<<<test_start>>>
tag=mm02 stime=1251102057
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
cutime=1 cstime=6
<<<test_end>>>
<<<test_start>>>
tag=mtest01 stime=1251102057
cmdline="mtest01 -p80"
contacts=""
analysis=exit
<<<test_output>>>
mtest01     0  TINFO  :  Total memory used needed to reach maxpercent = 4923782 kbytes
mtest01     0  TINFO  :  Total memory already used on system = 903100 kbytes
mtest01     0  TINFO  :  Filling up 80% of ram which is 4020682 kbytes
mtest01     1  TPASS  :  4020682 kbytes allocated only.
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=mtest01w stime=1251102057
cmdline="mtest01 -p80 -w"
contacts=""
analysis=exit
<<<test_output>>>
mtest01     0  TINFO  :  Total memory used needed to reach maxpercent = 4923782 kbytes
mtest01     0  TINFO  :  Total memory already used on system = 911080 kbytes
mtest01     0  TINFO  :  Filling up 80% of ram which is 4012702 kbytes
mtest01     1  TPASS  :  4012702 kbytes allocated and used.
<<<execution_status>>>
initiation_status="ok"
duration=49 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=mtest05 stime=1251102106
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
duration=8 termination_type=exited termination_id=0 corefile=no
cutime=4 cstime=786
<<<test_end>>>
<<<test_start>>>
tag=mtest06_2 stime=1251102114
cmdline="mmap2 -x 0.002 -a -p"
contacts=""
analysis=exit
<<<test_output>>>
MM Stress test, map/write/unmap large file
	Test scheduled to run for:       0.002000
	Size of temp file in GB:         1
file mapped at 0x7c5fe000
changing file content to 'A'
unmapped file at 0x7c5fe000
file mapped at 0x7c5fe000
changing file content to 'A'
unmapped file at 0x7c5fe000
file mapped at 0x7c5fe000
changing file content to 'A'
Test ended, success
<<<execution_status>>>
initiation_status="ok"
duration=7 termination_type=exited termination_id=0 corefile=no
cutime=37 cstime=675
<<<test_end>>>
<<<test_start>>>
tag=mtest06_3 stime=1251102121
cmdline="mmap3 -x 0.002 -p"
contacts=""
analysis=exit
<<<test_output>>>



Test is set to run with the following parameters:
	Duration of test: [0.002000]hrs
	Number of threads created: [40]
	number of map-write-unmaps: [1000]
	map_private?(T=1 F=0): [1]



Map address = 0xa3d0e000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa3d0e000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa3d0e000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa3d0e000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa07b0000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa3526000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x9fa6c000
Num iter: [2]
Total Num Iter: [1000]Map address = 0xa2750000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa3720000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa0f98000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa294a000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa3812000
Num iter: [2]
Total Num Iter: [1000]Map address = 0xa3d0e000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa3b14000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa2556000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa2f38000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa332c000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x9f47e000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x9ffc8000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa138c000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa3132000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa1192000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x9f284000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa197a000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x9fdce000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x9f678000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa2d3e000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa2b44000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa09aa000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa1b74000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa235c000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa05b6000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa1586000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa1d6e000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa0d9e000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa1780000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa391a000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa2162000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa1f68000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa03bc000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa386a000
Num iter: [2]
Total Num Iter: [1000]Map address = 0xa0ba4000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x9f872000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa37ba000
Num iter: [2]
Total Num Iter: [1000]Map address = 0xa3a90000
Num iter: [2]
Total Num Iter: [1000]Map address = 0xa34fa000
Num iter: [2]
Total Num Iter: [1000]Map address = 0xa3c48000
Num iter: [2]
Total Num Iter: [1000]Map address = 0xa3762000
Num iter: [2]
Total Num Iter: [1000]Map address = 0xa0952000
Num iter: [2]
Total Num Iter: [1000]Map address = 0xa3812000
Num iter: [2]
Total Num Iter: [1000]Map address = 0xa3eb0000
Num iter: [2]
Total Num Iter: [1000]Map address = 0xa3e00000
Num iter: [2]
Total Num Iter: [1000]Map address = 0xa3bf0000
Num iter: [2]
Total Num Iter: [1000]Map address = 0xa33f2000
Num iter: [2]
Total Num Iter: [1000]Map address = 0xa34a2000
Num iter: [2]
Total Num Iter: [1000]Map address = 0xa38c2000
Num iter: [2]
Total Num Iter: [1000]Map address = 0xa3ae8000
Num iter: [2]
Total Num Iter: [1000]Map address = 0xa3cf8000
Num iter: [2]
Total Num Iter: [1000]Map address = 0xa36b2000
Num iter: [2]
Total Num Iter: [1000]Map address = 0xa370a000
Num iter: [2]
Total Num Iter: [1000]Map address = 0xa3e58000
Num iter: [3]
Total Num Iter: [1000]Map address = 0xa339a000
Num iter: [2]
Total Num Iter: [1000]Map address = 0xa3da8000
Num iter: [2]
Total Num Iter: [1000]Map address = 0xa344a000
Num iter: [2]
Total Num Iter: [1000]Map address = 0xa3552000
Num iter: [2]
Total Num Iter: [1000]Map address = 0xa35aa000
Num iter: [2]
Total Num Iter: [1000]Map address = 0xa3602000
Num iter: [2]
Total Num Iter: [1000]Map address = 0xa3d50000
Num iter: [2]
Total Num Iter: [1000]Map address = 0xa3ca0000
Num iter: [2]
Total Num Iter: [1000]Map address = 0xa32ea000
Num iter: [2]
Total Num Iter: [1000]Map address = 0xa365a000
Num iter: [2]
Total Num Iter: [1000]Map address = 0xa3342000
Num iter: [2]
Total Num Iter: [1000]Map address = 0xa3b40000
Num iter: [2]
Total Num Iter: [1000]Map address = 0xa3b98000
Num iter: [3]
Total Num Iter: [1000]Map address = 0xa01c2000
Num iter: [2]
Total Num Iter: [1000]Map address = 0xa3da8000
Num iter: [2]
Total Num Iter: [1000]Map address = 0xa3e58000
Num iter: [2]
Total Num Iter: [1000]Map address = 0xa3e00000
Num iter: [2]
Total Num Iter: [1000]Map address = 0xa3eb0000
Num iter: [2]
Total Num Iter: [1000]Map address = 0xa3d50000
Num iter: [3]
Total Num Iter: [1000]Map address = 0x9ef22000
Num iter: [2]
Total Num Iter: [1000]Map address = 0xa3b5c000
Num iter: [3]
Total Num Iter: [1000]Map address = 0xa3b5c000
Num iter: [3]
Total Num Iter: [1000]Test ended, success
<<<execution_status>>>
initiation_status="ok"
duration=8 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=540
<<<test_end>>>
<<<test_start>>>
tag=mem01 stime=1251102129
cmdline="mem01"
contacts=""
analysis=exit
<<<test_output>>>
mem01       0  TINFO  :  Free Mem:	1961 Mb
mem01       0  TINFO  :  Free Swap:	3944 Mb
mem01       0  TINFO  :  Total Free:	5905 Mb
mem01       0  TINFO  :  Total Tested:	1008 Mb
mem01       0  TINFO  :  touching 1008MB of malloc'ed memory (linear)
mem01       1  TPASS  :  malloc - alloc of 1008MB succeeded
<<<execution_status>>>
initiation_status="ok"
duration=3 termination_type=exited termination_id=0 corefile=no
cutime=8 cstime=289
<<<test_end>>>
<<<test_start>>>
tag=mem02 stime=1251102132
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
cutime=44 cstime=32
<<<test_end>>>
<<<test_start>>>
tag=mem03 stime=1251102132
cmdline="mem03"
contacts=""
analysis=exit
<<<test_output>>>
<<<execution_status>>>
initiation_status="ok"
duration=1 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=page01 stime=1251102133
cmdline="page01"
contacts=""
analysis=exit
<<<test_output>>>
page01      1  TPASS  :  Test passed
<<<execution_status>>>
initiation_status="ok"
duration=1 termination_type=exited termination_id=0 corefile=no
cutime=4 cstime=23
<<<test_end>>>
<<<test_start>>>
tag=page02 stime=1251102134
cmdline="page02"
contacts=""
analysis=exit
<<<test_output>>>
page02      1  TPASS  :  Test passed
<<<execution_status>>>
initiation_status="ok"
duration=1 termination_type=exited termination_id=0 corefile=no
cutime=1 cstime=2
<<<test_end>>>
<<<test_start>>>
tag=data_space stime=1251102135
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
tag=stack_space stime=1251102136
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
tag=shmt02 stime=1251102136
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
tag=shmt03 stime=1251102136
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
cutime=0 cstime=1
<<<test_end>>>
<<<test_start>>>
tag=shmt04 stime=1251102136
cmdline="shmt04"
contacts=""
analysis=exit
<<<test_output>>>
shmt04      1  TPASS  :  shmget,shmat
shmt04      2  TPASS  :  shmdt
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=shmt05 stime=1251102136
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
tag=shmt06 stime=1251102136
cmdline="shmt06"
contacts=""
analysis=exit
<<<test_output>>>
shmt06      1  TPASS  :  shmget,shmat
shmt06      2  TPASS  :  shmdt
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=1
<<<test_end>>>
<<<test_start>>>
tag=shmt07 stime=1251102136
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
cutime=0 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=shmt08 stime=1251102136
cmdline="shmt08"
contacts=""
analysis=exit
<<<test_output>>>
shmt08      1  TPASS  :  shmget,shmat
shmt08      2  TPASS  :  shmdt
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=1
<<<test_end>>>
<<<test_start>>>
tag=shmt09 stime=1251102136
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
tag=shmt10 stime=1251102136
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
tag=shm_test01 stime=1251102136
cmdline="shm_test -l 10 -t 2"
contacts=""
analysis=exit
<<<test_output>>>
pid[2061]: shmat_rd_wr(): shmget():success got segment id 410386436
pid[2061]: do_shmat_shmadt(): got shmat address = 0xb6e12000
pid[2061]: shmat_rd_wr(): shmget():success got segment id 410386436
pid[2061]: do_shmat_shmadt(): got shmat address = 0xb6c94000
pid[2061]: shmat_rd_wr(): shmget():success got segment id 410419205
pid[2061]: do_shmat_shmadt(): got shmat address = 0xb6e12000
pid[2061]: shmat_rd_wr(): shmget():success got segment id 410419205
pid[2061]: do_shmat_shmadt(): got shmat address = 0xb6c94000
pid[2061]: shmat_rd_wr(): shmget():success got segment id 410451972
pid[2061]: do_shmat_shmadt(): got shmat address = 0xb6e12000
pid[2061]: shmat_rd_wr(): shmget():success got segment id 410451972
pid[2061]: do_shmat_shmadt(): got shmat address = 0xb6c94000
pid[2061]: shmat_rd_wr(): shmget():success got segment id 410484741
pid[2061]: do_shmat_shmadt(): got shmat address = 0xb6e12000
pid[2061]: shmat_rd_wr(): shmget():success got segment id 410484741
pid[2061]: do_shmat_shmadt(): got shmat address = 0xb6c94000
pid[2061]: shmat_rd_wr(): shmget():success got segment id 410517508
pid[2061]: do_shmat_shmadt(): got shmat address = 0xb6e12000
pid[2061]: shmat_rd_wr(): shmget():success got segment id 410517508
pid[2061]: do_shmat_shmadt(): got shmat address = 0xb6c94000
pid[2061]: shmat_rd_wr(): shmget():success got segment id 410550277
pid[2061]: do_shmat_shmadt(): got shmat address = 0xb6e12000
pid[2061]: shmat_rd_wr(): shmget():success got segment id 410550277
pid[2061]: do_shmat_shmadt(): got shmat address = 0xb6c94000
pid[2061]: shmat_rd_wr(): shmget():success got segment id 410583044
pid[2061]: do_shmat_shmadt(): got shmat address = 0xb6e12000
pid[2061]: shmat_rd_wr(): shmget():success got segment id 410583044
pid[2061]: do_shmat_shmadt(): got shmat address = 0xb6c94000
pid[2061]: shmat_rd_wr(): shmget():success got segment id 410615813
pid[2061]: do_shmat_shmadt(): got shmat address = 0xb6e12000
pid[2061]: shmat_rd_wr(): shmget():success got segment id 410615813
pid[2061]: do_shmat_shmadt(): got shmat address = 0xb6c94000
pid[2061]: shmat_rd_wr(): shmget():success got segment id 410648580
pid[2061]: do_shmat_shmadt(): got shmat address = 0xb6e12000
pid[2061]: shmat_rd_wr(): shmget():success got segment id 410648580
pid[2061]: do_shmat_shmadt(): got shmat address = 0xb6c94000
pid[2061]: shmat_rd_wr(): shmget():success got segment id 410681349
pid[2061]: do_shmat_shmadt(): got shmat address = 0xb6e12000
pid[2061]: shmat_rd_wr(): shmget():success got segment id 410681349
pid[2061]: do_shmat_shmadt(): got shmat address = 0xb6c94000
<<<execution_status>>>
initiation_status="ok"
duration=67 termination_type=exited termination_id=0 corefile=no
cutime=986 cstime=12353
<<<test_end>>>
<<<test_start>>>
tag=mallocstress01 stime=1251102203
cmdline="mallocstress"
contacts=""
analysis=exit
<<<test_output>>>
Thread [7]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [51]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [43]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [35]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [47]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [15]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [55]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [3]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [19]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [11]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [23]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [39]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [31]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [27]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [59]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [14]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [58]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [38]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [34]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [2]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [18]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [54]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [42]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [30]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [26]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [10]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [46]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [50]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [6]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [22]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [5]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [33]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [29]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [57]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [53]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [41]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [17]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [13]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [1]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [37]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [45]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [49]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [9]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [21]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [25]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [52]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [24]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [32]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [28]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [40]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [44]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [4]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [48]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [20]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [12]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [36]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [0]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [56]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [16]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [8]: allocate_free() returned 0, succeeded.  Thread exiting.
main(): test passed.
<<<execution_status>>>
initiation_status="ok"
duration=8 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=771
<<<test_end>>>
<<<test_start>>>
tag=mmapstress01 stime=1251102211
cmdline="mmapstress01 -p 20 -t 0.2"
contacts=""
analysis=exit
<<<test_output>>>
file data okay
mmapstress01    1  TPASS  :  Test passed
<<<execution_status>>>
initiation_status="ok"
duration=12 termination_type=exited termination_id=0 corefile=no
cutime=1364 cstime=766
<<<test_end>>>
<<<test_start>>>
tag=mmapstress02 stime=1251102223
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
tag=mmapstress03 stime=1251102223
cmdline="mmapstress03"
contacts=""
analysis=exit
<<<test_output>>>
mmapstress03    1  TPASS  :  Test passed
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=mmapstress04 stime=1251102223
cmdline="TMPFILE=`mktemp /tmp/example.XXXXXXXXXX`; ls -lR /usr/include/ > $TMPFILE; mmapstress04 $TMPFILE"
contacts=""
analysis=exit
<<<test_output>>>
mmapstress04    1  TPASS  :  Test passed

<<<execution_status>>>
initiation_status="ok"
duration=8 termination_type=exited termination_id=0 corefile=no
cutime=30 cstime=199
<<<test_end>>>
<<<test_start>>>
tag=mmapstress05 stime=1251102231
cmdline="mmapstress05"
contacts=""
analysis=exit
<<<test_output>>>
mmapstress05    1  TPASS  :  Test passed

<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=1
<<<test_end>>>
<<<test_start>>>
tag=mmapstress06 stime=1251102231
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
tag=mmapstress07 stime=1251102251
cmdline="TMPFILE=`mktemp /tmp/example.XXXXXXXXXXXX`; mmapstress07 $TMPFILE"
contacts=""
analysis=exit
<<<test_output>>>
mmapstress07    1  TPASS  :  Test passed

<<<execution_status>>>
initiation_status="ok"
duration=1 termination_type=exited termination_id=0 corefile=no
cutime=1 cstime=22
<<<test_end>>>
<<<test_start>>>
tag=mmapstress08 stime=1251102252
cmdline="mmapstress08"
contacts=""
analysis=exit
<<<test_output>>>
mmapstress08    1  TPASS  :  Test passed

<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=mmapstress09 stime=1251102252
cmdline="mmapstress09 -p 20 -t 0.2"
contacts=""
analysis=exit
<<<test_output>>>
map data okay
mmapstress09    1  TPASS  :  Test passed

<<<execution_status>>>
initiation_status="ok"
duration=12 termination_type=exited termination_id=0 corefile=no
cutime=1454 cstime=733
<<<test_end>>>
<<<test_start>>>
tag=mmapstress10 stime=1251102264
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
cutime=986 cstime=1125
<<<test_end>>>
====================================================


====================================================
# ./runltp -f mm -M 1 -o ltp_mm_test_only_memory_leak_check
====================================================
<<<test_start>>>
tag=mm01 stime=1251102277
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
cutime=5 cstime=51
<<<test_end>>>
<<<test_start>>>
tag=mm01_valgrind_memory_leak_check stime=1251102278
cmdline=" valgrind -q --leak-check=full --trace-children=yes  mmap001  -m  10000 "
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
duration=5 termination_type=exited termination_id=0 corefile=no
cutime=317 cstime=62
<<<test_end>>>
<<<test_start>>>
tag=mm02 stime=1251102283
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
tag=mm02_valgrind_memory_leak_check stime=1251102283
cmdline=" valgrind -q --leak-check=full --trace-children=yes  mmap001 "
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
duration=1 termination_type=exited termination_id=0 corefile=no
cutime=83 cstime=12
<<<test_end>>>
<<<test_start>>>
tag=mtest01 stime=1251102284
cmdline="mtest01 -p80"
contacts=""
analysis=exit
<<<test_output>>>
mtest01     0  TINFO  :  Total memory used needed to reach maxpercent = 4923782 kbytes
mtest01     0  TINFO  :  Total memory already used on system = 135952 kbytes
mtest01     0  TINFO  :  Filling up 80% of ram which is 4787830 kbytes
mtest01     1  TPASS  :  4787830 kbytes allocated only.
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=mtest01_valgrind_memory_leak_check stime=1251102284
cmdline=" valgrind -q --leak-check=full --trace-children=yes  mtest01  -p80 "
contacts=""
analysis=exit
<<<test_output>>>
mtest01     0  TINFO  :  Total memory used needed to reach maxpercent = 4923782 kbytes
mtest01     0  TINFO  :  Total memory already used on system = 146140 kbytes
mtest01     0  TINFO  :  Filling up 80% of ram which is 4777642 kbytes
mtest01     1  TPASS  :  4777642 kbytes allocated only.
<<<execution_status>>>
initiation_status="ok"
duration=1 termination_type=exited termination_id=0 corefile=no
cutime=52 cstime=8
<<<test_end>>>
<<<test_start>>>
tag=mtest01w stime=1251102285
cmdline="mtest01 -p80 -w"
contacts=""
analysis=exit
<<<test_output>>>
mtest01     0  TINFO  :  Total memory used needed to reach maxpercent = 4923782 kbytes
mtest01     0  TINFO  :  Total memory already used on system = 136564 kbytes
mtest01     0  TINFO  :  Filling up 80% of ram which is 4787218 kbytes
mtest01     1  TPASS  :  4787218 kbytes allocated and used.
<<<execution_status>>>
initiation_status="ok"
duration=70 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=mtest01w_valgrind_memory_leak_check stime=1251102355
cmdline=" valgrind -q --leak-check=full --trace-children=yes  mtest01  -p80  -w "
contacts=""
analysis=exit
<<<test_output>>>
mtest01     0  TINFO  :  Total memory used needed to reach maxpercent = 4923782 kbytes
mtest01     0  TINFO  :  Total memory already used on system = 120248 kbytes
mtest01     0  TINFO  :  Filling up 80% of ram which is 4803534 kbytes
mtest01     1  TPASS  :  4803534 kbytes allocated and used.
<<<execution_status>>>
initiation_status="ok"
duration=278 termination_type=exited termination_id=0 corefile=no
cutime=61 cstime=18
<<<test_end>>>
<<<test_start>>>
tag=mtest05 stime=1251102633
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
duration=6 termination_type=exited termination_id=0 corefile=no
cutime=4 cstime=757
<<<test_end>>>
<<<test_start>>>
tag=mtest05_valgrind_memory_leak_check stime=1251102639
cmdline=" valgrind -q --leak-check=full --trace-children=yes      mmstress "
contacts=""
analysis=exit
<<<test_output>>>
mmstress    0  TINFO  :  run mmstress -h for all options
mmstress    0  TINFO  :  test1: Test case tests the race condition between simultaneous read faults in the same address space.
==6121== Syscall param write(buf) points to uninitialised byte(s)
==6121==    at 0xB12423: __write_nocancel (in /lib/libpthread-2.5.so)
==6121==    by 0x80497B4: test1 (mmstress.c:580)
==6121==    by 0x8049C9A: main (mmstress.c:975)
==6121==  Address 0x4023028 is 0 bytes inside a block of size 40,955,904 alloc'd
==6121==    at 0x40053C0: malloc (vg_replace_malloc.c:149)
==6121==    by 0x80493E2: map_and_thread (mmstress.c:407)
==6121==    by 0x80497B4: test1 (mmstress.c:580)
==6121==    by 0x8049C9A: main (mmstress.c:975)
mmstress    1  TPASS  :  TEST 1 Passed
mmstress    0  TINFO  :  test2: Test case tests the race condition between simultaneous write faults in the same address space.
==6121== 
==6121== Syscall param write(buf) points to uninitialised byte(s)
==6121==    at 0xB1244B: (within /lib/libpthread-2.5.so)
==6121==    by 0x8049764: test2 (mmstress.c:609)
==6121==    by 0x8049C9A: main (mmstress.c:975)
==6121==  Address 0x4023028 is 0 bytes inside a block of size 40,955,904 alloc'd
==6121==    at 0x40053C0: malloc (vg_replace_malloc.c:149)
==6121==    by 0x80493E2: map_and_thread (mmstress.c:407)
==6121==    by 0x8049764: test2 (mmstress.c:609)
==6121==    by 0x8049C9A: main (mmstress.c:975)
mmstress    2  TPASS  :  TEST 2 Passed
mmstress    0  TINFO  :  test3: Test case tests the race condition between simultaneous COW faults in the same address space.
==6121== 
==6121== Syscall param write(buf) points to uninitialised byte(s)
==6121==    at 0xB1244B: (within /lib/libpthread-2.5.so)
==6121==    by 0x8049714: test3 (mmstress.c:638)
==6121==    by 0x8049C9A: main (mmstress.c:975)
==6121==  Address 0x4023028 is 0 bytes inside a block of size 40,955,904 alloc'd
==6121==    at 0x40053C0: malloc (vg_replace_malloc.c:149)
==6121==    by 0x80493E2: map_and_thread (mmstress.c:407)
==6121==    by 0x8049714: test3 (mmstress.c:638)
==6121==    by 0x8049C9A: main (mmstress.c:975)
mmstress    3  TPASS  :  TEST 3 Passed
mmstress    0  TINFO  :  test4: Test case tests the race condition between simultaneous READ faults in the same address space. The file mapped is /dev/zero
==6121== 
==6121== Syscall param write(buf) points to uninitialised byte(s)
==6121==    at 0xB1244B: (within /lib/libpthread-2.5.so)
==6121==    by 0x80496C4: test4 (mmstress.c:667)
==6121==    by 0x8049C9A: main (mmstress.c:975)
==6121==  Address 0x4023028 is 0 bytes inside a block of size 40,955,904 alloc'd
==6121==    at 0x40053C0: malloc (vg_replace_malloc.c:149)
==6121==    by 0x80493E2: map_and_thread (mmstress.c:407)
==6121==    by 0x80496C4: test4 (mmstress.c:667)
==6121==    by 0x8049C9A: main (mmstress.c:975)
mmstress    4  TPASS  :  TEST 4 Passed
mmstress    0  TINFO  :  test5: Test case tests the race condition between simultaneous fork - exit faults in the same address space.
mmstress    5  TPASS  :  TEST 5 Passed
mmstress    0  TINFO  :  test6: Test case tests the race condition between simultaneous fork -exec - exit faults in the same address space.
mmstress    6  TPASS  :  TEST 6 Passed
mmstress    7  TPASS  :  Test Passed
<<<execution_status>>>
initiation_status="ok"
duration=42 termination_type=exited termination_id=0 corefile=no
cutime=2382 cstime=3487
<<<test_end>>>
<<<test_start>>>
tag=mtest06_2 stime=1251102681
cmdline="mmap2 -x 0.002 -a -p"
contacts=""
analysis=exit
<<<test_output>>>
MM Stress test, map/write/unmap large file
	Test scheduled to run for:       0.002000
	Size of temp file in GB:         1
file mapped at 0x7c6ab000
changing file content to 'A'
unmapped file at 0x7c6ab000
file mapped at 0x7c6ab000
changing file content to 'A'
unmapped file at 0x7c6ab000
file mapped at 0x7c6ab000
changing file content to 'A'
Test ended, success
<<<execution_status>>>
initiation_status="ok"
duration=8 termination_type=exited termination_id=0 corefile=no
cutime=38 cstime=676
<<<test_end>>>
<<<test_start>>>
tag=mtest06_2_valgrind_memory_leak_check stime=1251102689
cmdline=" valgrind -q --leak-check=full --trace-children=yes  mmap2  -x  0.002  -a  -p "
contacts=""
analysis=exit
<<<test_output>>>
MM Stress test, map/write/unmap large file
	Test scheduled to run for:       0.002000
	Size of temp file in GB:         1
file mapped at 0x63dba000
changing file content to 'A'
Test ended, success
<<<execution_status>>>
initiation_status="ok"
duration=7 termination_type=exited termination_id=0 corefile=no
cutime=724 cstime=48
<<<test_end>>>
<<<test_start>>>
tag=mtest06_3 stime=1251102696
cmdline="mmap3 -x 0.002 -p"
contacts=""
analysis=exit
<<<test_output>>>



Test is set to run with the following parameters:
	Duration of test: [0.002000]hrs
	Number of threads created: [40]
	number of map-write-unmaps: [1000]
	map_private?(T=1 F=0): [1]



Map address = 0xa3f33000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa3927000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa3aaa000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa3015000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa3198000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa3db0000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa3c2d000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x9f441000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa1195000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa3aaa000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa3f33000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa3621000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa0185000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x9eb86000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa0308000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa2eaf000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa0002000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa28dd000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa2022000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa2bc6000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x9f72a000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x9fe7f000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa349e000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa331b000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x9fb96000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa1d39000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa3927000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa37a4000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa147e000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa230b000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x9f8ad000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa05f1000
Num iter: [2]
Total Num Iter: [1000]Map address = 0xa25f4000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa1a50000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x9e89d000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x9f158000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa0eac000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x9ee6f000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa1767000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa08da000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa3d66000
Num iter: [2]
Total Num Iter: [1000]Map address = 0xa3d1c000
Num iter: [2]
Total Num Iter: [1000]Map address = 0xa0bc3000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa3ee9000
Num iter: [2]
Total Num Iter: [1000]Map address = 0xa3d6d000
Num iter: [2]
Total Num Iter: [1000]Test ended, success
<<<execution_status>>>
initiation_status="ok"
duration=8 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=558
<<<test_end>>>
<<<test_start>>>
tag=mtest06_3_valgrind_memory_leak_check stime=1251102704
cmdline=" valgrind -q --leak-check=full --trace-children=yes  mmap3  -x  0.002  -p "
contacts=""
analysis=exit
<<<test_output>>>



Test is set to run with the following parameters:
	Duration of test: [0.002000]hrs
	Number of threads created: [40]
	number of map-write-unmaps: [1000]
	map_private?(T=1 F=0): [1]



Map address = 0x792a000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x7a3d000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x7b50000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x792a000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x7d76000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x194ba000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x196e0000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x197f3000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x19a19000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x7dfe000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x7c63000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x19181000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x7e86000
Num iter: [2]
Total Num Iter: [1000]Map address = 0x19b2c000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x7dfe000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x7d76000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x7bd8000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x792a000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x19294000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x19a19000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x19906000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x19bb4000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x193a7000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x197f3000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x79b2000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x1906e000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x193a7000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x196e0000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x7a3d000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x19294000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x195cd000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x7d73000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x792a000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x193a7000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x7ac5000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x7f11000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x194ba000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x7d73000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x7c60000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x19181000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x197f3000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x792a000
Num iter: [2]
Total Num Iter: [1000]Map address = 0x792a000
Num iter: [2]
Total Num Iter: [1000]Map address = 0x193b6000
Num iter: [2]
Total Num Iter: [1000]Map address = 0x191cf000
Num iter: [2]
Total Num Iter: [1000]Map address = 0x19b21000
Num iter: [2]
Total Num Iter: [1000]Map address = 0x1993a000
Num iter: [2]
Total Num Iter: [1000]Map address = 0x19c82000
Num iter: [2]
Total Num Iter: [1000]Map address = 0x1a050000
Num iter: [2]
Total Num Iter: [1000]Map address = 0x1993a000
Num iter: [2]
Total Num Iter: [1000]Map address = 0x19678000
Num iter: [2]
Total Num Iter: [1000]Map address = 0x19a9b000
Num iter: [2]
Total Num Iter: [1000]Map address = 0x19bfc000
Num iter: [2]
Total Num Iter: [1000]Map address = 0x7bec000
Num iter: [2]
Total Num Iter: [1000]Map address = 0x197d9000
Num iter: [2]
Total Num Iter: [1000]Map address = 0x7eae000
Num iter: [2]
Total Num Iter: [1000]Map address = 0x1993a000
Num iter: [2]
Total Num Iter: [1000]Map address = 0x7d4d000
Num iter: [2]
Total Num Iter: [1000]Test ended, success



Test is set to run with the following parameters:
	Duration of test: [0.002000]hrs
	Number of threads created: [40]
	number of map-write-unmaps: [1000]
	map_private?(T=1 F=0): [1]



Map address = 0x792a000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x7a3d000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x7b50000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x792a000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x7d76000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x194ba000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x196e0000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x197f3000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x19a19000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x7dfe000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x7c63000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x19181000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x7e86000
Num iter: [2]
Total Num Iter: [1000]Map address = 0x19b2c000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x7dfe000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x7d76000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x7bd8000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x792a000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x19294000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x19a19000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x19906000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x19bb4000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x193a7000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x197f3000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x79b2000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x1906e000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x193a7000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x196e0000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x7a3d000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x19294000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x195cd000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x7d73000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x792a000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x193a7000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x7ac5000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x7f11000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x194ba000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x7d73000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x7c60000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x19181000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x197f3000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x792a000
Num iter: [2]
Total Num Iter: [1000]Map address = 0x792a000
Num iter: [2]
Total Num Iter: [1000]Map address = 0x193b6000
Num iter: [2]
Total Num Iter: [1000]Map address = 0x191cf000
Num iter: [2]
Total Num Iter: [1000]Map address = 0x19b21000
Num iter: [2]
Total Num Iter: [1000]Map address = 0x1993a000
Num iter: [2]
Total Num Iter: [1000]Map address = 0x19c82000
Num iter: [2]
Total Num Iter: [1000]Map address = 0x1a050000
Num iter: [2]
Total Num Iter: [1000]Map address = 0x1993a000
Num iter: [2]
Total Num Iter: [1000]Map address = 0x19678000
Num iter: [2]
Total Num Iter: [1000]Map address = 0x19a9b000
Num iter: [2]
Total Num Iter: [1000]Map address = 0x19bfc000
Num iter: [2]
Total Num Iter: [1000]Map address = 0x7bec000
Num iter: [2]
Total Num Iter: [1000]Map address = 0x197d9000
Num iter: [2]
Total Num Iter: [1000]Map address = 0x7eae000
Num iter: [2]
Total Num Iter: [1000]Map address = 0x1993a000
Num iter: [2]
Total Num Iter: [1000]Map address = 0x7d4d000
Num iter: [2]
Total Num Iter: [1000]Test ended, success
Map address = 0x7eae000
Num iter: [2]
Total Num Iter: [1000]Map address = 0x1a312000
Num iter: [2]
Total Num Iter: [1000]Map address = 0x1aaae000
Num iter: [2]
Total Num Iter: [1000]Map address = 0x7a8b000
Num iter: [2]
Total Num Iter: [1000]Map address = 0x19330000
Num iter: [2]
Total Num Iter: [1000]Map address = 0x792a000
Num iter: [2]
Total Num Iter: [1000]Map address = ==6371== 
==6371== 5,440 bytes in 40 blocks are possibly lost in loss record 1 of 1
==6371==    at 0x40046FF: calloc (vg_replace_malloc.c:279)
==6371==    by 0x97ED49: _dl_allocate_tls (in /lib/ld-2.5.so)
==6371==    by 0xB0BB92: pthread_create@@GLIBC_2.1 (in /lib/libpthread-2.5.so)
==6371==    by 0x8048FDC: main (mmap3.c:402)
<<<execution_status>>>
initiation_status="ok"
duration=20 termination_type=exited termination_id=0 corefile=no
cutime=1591 cstime=503
<<<test_end>>>
<<<test_start>>>
tag=mem01 stime=1251102724
cmdline="mem01"
contacts=""
analysis=exit
<<<test_output>>>
mem01       0  TINFO  :  Free Mem:	1954 Mb
mem01       0  TINFO  :  Free Swap:	3945 Mb
mem01       0  TINFO  :  Total Free:	5900 Mb
mem01       0  TINFO  :  Total Tested:	1008 Mb
mem01       0  TINFO  :  touching 1008MB of malloc'ed memory (linear)
mem01       1  TPASS  :  malloc - alloc of 1008MB succeeded
<<<execution_status>>>
initiation_status="ok"
duration=3 termination_type=exited termination_id=0 corefile=no
cutime=7 cstime=289
<<<test_end>>>
<<<test_start>>>
tag=mem01_valgrind_memory_leak_check stime=1251102727
cmdline=" valgrind -q --leak-check=full --trace-children=yes  mem01 "
contacts=""
analysis=exit
<<<test_output>>>
mem01       0  TINFO  :  Free Mem:	1945 Mb
mem01       0  TINFO  :  Free Swap:	3945 Mb
mem01       0  TINFO  :  Total Free:	5890 Mb
mem01       0  TINFO  :  Total Tested:	1008 Mb
mem01       0  TINFO  :  touching 1008MB of malloc'ed memory (linear)
mem01       1  TPASS  :  malloc - alloc of 1008MB succeeded
<<<execution_status>>>
initiation_status="ok"
duration=4 termination_type=exited termination_id=0 corefile=no
cutime=94 cstime=378
<<<test_end>>>
<<<test_start>>>
tag=mem02 stime=1251102731
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
duration=1 termination_type=exited termination_id=0 corefile=no
cutime=39 cstime=36
<<<test_end>>>
<<<test_start>>>
tag=mem02_valgrind_memory_leak_check stime=1251102732
cmdline=" valgrind -q --leak-check=full --trace-children=yes  mem02 "
contacts=""
analysis=exit
<<<test_output>>>
mem02       1  TPASS  :  calloc - calloc of 64MB of memory succeeded
mem02       2  TPASS  :  malloc - malloc of 64MB of memory succeeded
mem02       3  TPASS  :  realloc - realloc of 5 bytes succeeded
mem02       4  TPASS  :  realloc - realloc of 15 bytes succeeded
<<<execution_status>>>
initiation_status="ok"
duration=12 termination_type=exited termination_id=0 corefile=no
cutime=1156 cstime=52
<<<test_end>>>
<<<test_start>>>
tag=mem03 stime=1251102744
cmdline="mem03"
contacts=""
analysis=exit
<<<test_output>>>
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=mem03_valgrind_memory_leak_check stime=1251102744
cmdline=" valgrind -q --leak-check=full --trace-children=yes  mem03 "
contacts=""
analysis=exit
<<<test_output>>>
==6417== Syscall param write(buf) points to unaddressable byte(s)
==6417==    at 0xA53273: __write_nocancel (in /lib/libc-2.5.so)
==6417==    by 0x9F3994: new_do_write (in /lib/libc-2.5.so)
==6417==    by 0x9F3C7E: _IO_do_write@@GLIBC_2.1 (in /lib/libc-2.5.so)
==6417==    by 0x9F4455: _IO_file_sync@@GLIBC_2.1 (in /lib/libc-2.5.so)
==6417==    by 0x9E908B: fflush (in /lib/libc-2.5.so)
==6417==    by 0x8049B1B: tst_flush (tst_res.c:451)
==6417==    by 0x8049B7A: tst_exit (tst_res.c:591)
==6417==    by 0x8048D95: cleanup (mem03.c:178)
==6417==    by 0x80491F5: main (mem03.c:142)
==6417==  Address 0x4009000 is not stack'd, malloc'd or (recently) free'd
<<<execution_status>>>
initiation_status="ok"
duration=1 termination_type=exited termination_id=0 corefile=no
cutime=54 cstime=7
<<<test_end>>>
<<<test_start>>>
tag=page01 stime=1251102745
cmdline="page01"
contacts=""
analysis=exit
<<<test_output>>>
page01      1  TPASS  :  Test passed
<<<execution_status>>>
initiation_status="ok"
duration=1 termination_type=exited termination_id=0 corefile=no
cutime=5 cstime=24
<<<test_end>>>
<<<test_start>>>
tag=page01_valgrind_memory_leak_check stime=1251102746
cmdline=" valgrind -q --leak-check=full --trace-children=yes  page01 "
contacts=""
analysis=exit
<<<test_output>>>
page01      1  TPASS  :  Test passed
<<<execution_status>>>
initiation_status="ok"
duration=7 termination_type=exited termination_id=0 corefile=no
cutime=1146 cstime=122
<<<test_end>>>
<<<test_start>>>
tag=page02 stime=1251102753
cmdline="page02"
contacts=""
analysis=exit
<<<test_output>>>
page02      1  TPASS  :  Test passed
<<<execution_status>>>
initiation_status="ok"
duration=1 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=1
<<<test_end>>>
<<<test_start>>>
tag=page02_valgrind_memory_leak_check stime=1251102754
cmdline=" valgrind -q --leak-check=full --trace-children=yes  page02 "
contacts=""
analysis=exit
<<<test_output>>>
==6527== 
==6527== 524,288 bytes in 1 blocks are possibly lost in loss record 2 of 2
==6527==    at 0x40053C0: malloc (vg_replace_malloc.c:149)
==6527==    by 0x8048FCD: main (page02.c:134)
==6528== 
==6528== 524,288 bytes in 1 blocks are possibly lost in loss record 2 of 2
==6528==    at 0x40053C0: malloc (vg_replace_malloc.c:149)
==6528==    by 0x8048FCD: main (page02.c:134)
==6529== 
==6529== 524,288 bytes in 1 blocks are possibly lost in loss record 2 of 2
==6529==    at 0x40053C0: malloc (vg_replace_malloc.c:149)
==6529==    by 0x8048FCD: main (page02.c:134)
==6530== 
==6530== 524,288 bytes in 1 blocks are possibly lost in loss record 2 of 2
==6530==    at 0x40053C0: malloc (vg_replace_malloc.c:149)
==6530==    by 0x8048FCD: main (page02.c:134)
==6531== 
==6531== 524,288 bytes in 1 blocks are possibly lost in loss record 2 of 2
==6531==    at 0x40053C0: malloc (vg_replace_malloc.c:149)
==6531==    by 0x8048FCD: main (page02.c:134)
page02      1  TPASS  :  Test passed
<<<execution_status>>>
initiation_status="ok"
duration=4 termination_type=exited termination_id=0 corefile=no
cutime=122 cstime=16
<<<test_end>>>
<<<test_start>>>
tag=data_space stime=1251102758
cmdline="data_space"
contacts=""
analysis=exit
<<<test_output>>>
data_space    1  TPASS  :  Test passed
<<<execution_status>>>
initiation_status="ok"
duration=1 termination_type=exited termination_id=0 corefile=no
cutime=258 cstime=6
<<<test_end>>>
<<<test_start>>>
tag=data_space_valgrind_memory_leak_check stime=1251102759
cmdline=" valgrind -q --leak-check=full --trace-children=yes  data_space "
contacts=""
analysis=exit
<<<test_output>>>
==6547== 
==6547== 32 bytes in 1 blocks are definitely lost in loss record 2 of 5
==6547==    at 0x40053C0: malloc (vg_replace_malloc.c:149)
==6547==    by 0x8049049: dotest (data_space.c:265)
==6547==    by 0x80495FE: runtest (data_space.c:172)
==6547==    by 0x80496C2: main (data_space.c:146)
==6547== 
==6547== 
==6547== 4,096 bytes in 1 blocks are definitely lost in loss record 3 of 5
==6547==    at 0x40053C0: malloc (vg_replace_malloc.c:149)
==6547==    by 0x8049079: dotest (data_space.c:271)
==6547==    by 0x80495FE: runtest (data_space.c:172)
==6547==    by 0x80496C2: main (data_space.c:146)
==6547== 
==6547== 
==6547== 4,096 bytes in 1 blocks are definitely lost in loss record 4 of 5
==6547==    at 0x40053C0: malloc (vg_replace_malloc.c:149)
==6547==    by 0x8049061: dotest (data_space.c:268)
==6547==    by 0x80495FE: runtest (data_space.c:172)
==6547==    by 0x80496C2: main (data_space.c:146)
==6547== 
==6547== 
==6547== 1,048,576 bytes in 1 blocks are definitely lost in loss record 5 of 5
==6547==    at 0x40053C0: malloc (vg_replace_malloc.c:149)
==6547==    by 0x8049091: dotest (data_space.c:274)
==6547==    by 0x80495FE: runtest (data_space.c:172)
==6547==    by 0x80496C2: main (data_space.c:146)
==6548== 
==6548== 32 bytes in 1 blocks are definitely lost in loss record 2 of 5
==6548==    at 0x40053C0: malloc (vg_replace_malloc.c:149)
==6548==    by 0x8049049: dotest (data_space.c:265)
==6548==    by 0x80495FE: runtest (data_space.c:172)
==6548==    by 0x80496C2: main (data_space.c:146)
==6548== 
==6548== 
==6548== 4,096 bytes in 1 blocks are definitely lost in loss record 3 of 5
==6548==    at 0x40053C0: malloc (vg_replace_malloc.c:149)
==6548==    by 0x8049079: dotest (data_space.c:271)
==6548==    by 0x80495FE: runtest (data_space.c:172)
==6548==    by 0x80496C2: main (data_space.c:146)
==6548== 
==6548== 
==6548== 4,096 bytes in 1 blocks are definitely lost in loss record 4 of 5
==6548==    at 0x40053C0: malloc (vg_replace_malloc.c:149)
==6548==    by 0x8049061: dotest (data_space.c:268)
==6548==    by 0x80495FE: runtest (data_space.c:172)
==6548==    by 0x80496C2: main (data_space.c:146)
==6548== 
==6548== 
==6548== 1,048,576 bytes in 1 blocks are definitely lost in loss record 5 of 5
==6548==    at 0x40053C0: malloc (vg_replace_malloc.c:149)
==6548==    by 0x8049091: dotest (data_space.c:274)
==6548==    by 0x80495FE: runtest (data_space.c:172)
==6548==    by 0x80496C2: main (data_space.c:146)
==6549== 
==6549== 32 bytes in 1 blocks are definitely lost in loss record 2 of 5
==6549==    at 0x40053C0: malloc (vg_replace_malloc.c:149)
==6549==    by 0x8049049: dotest (data_space.c:265)
==6549==    by 0x80495FE: runtest (data_space.c:172)
==6549==    by 0x80496C2: main (data_space.c:146)
==6549== 
==6549== 
==6549== 4,096 bytes in 1 blocks are definitely lost in loss record 3 of 5
==6549==    at 0x40053C0: malloc (vg_replace_malloc.c:149)
==6549==    by 0x8049079: dotest (data_space.c:271)
==6549==    by 0x80495FE: runtest (data_space.c:172)
==6549==    by 0x80496C2: main (data_space.c:146)
==6549== 
==6549== 
==6549== 4,096 bytes in 1 blocks are definitely lost in loss record 4 of 5
==6549==    at 0x40053C0: malloc (vg_replace_malloc.c:149)
==6549==    by 0x8049061: dotest (data_space.c:268)
==6549==    by 0x80495FE: runtest (data_space.c:172)
==6549==    by 0x80496C2: main (data_space.c:146)
==6549== 
==6549== 
==6549== 1,048,576 bytes in 1 blocks are definitely lost in loss record 5 of 5
==6549==    at 0x40053C0: malloc (vg_replace_malloc.c:149)
==6549==    by 0x8049091: dotest (data_space.c:274)
==6549==    by 0x80495FE: runtest (data_space.c:172)
==6549==    by 0x80496C2: main (data_space.c:146)
==6550== 
==6550== 32 bytes in 1 blocks are definitely lost in loss record 2 of 5
==6550==    at 0x40053C0: malloc (vg_replace_malloc.c:149)
==6550==    by 0x8049049: dotest (data_space.c:265)
==6550==    by 0x80495FE: runtest (data_space.c:172)
==6550==    by 0x80496C2: main (data_space.c:146)
==6550== 
==6550== 
==6550== 4,096 bytes in 1 blocks are definitely lost in loss record 3 of 5
==6550==    at 0x40053C0: malloc (vg_replace_malloc.c:149)
==6550==    by 0x8049079: dotest (data_space.c:271)
==6550==    by 0x80495FE: runtest (data_space.c:172)
==6550==    by 0x80496C2: main (data_space.c:146)
==6550== 
==6550== 
==6550== 4,096 bytes in 1 blocks are definitely lost in loss record 4 of 5
==6550==    at 0x40053C0: malloc (vg_replace_malloc.c:149)
==6550==    by 0x8049061: dotest (data_space.c:268)
==6550==    by 0x80495FE: runtest (data_space.c:172)
==6550==    by 0x80496C2: main (data_space.c:146)
==6550== 
==6550== 
==6550== 1,048,576 bytes in 1 blocks are definitely lost in loss record 5 of 5
==6550==    at 0x40053C0: malloc (vg_replace_malloc.c:149)
==6550==    by 0x8049091: dotest (data_space.c:274)
==6550==    by 0x80495FE: runtest (data_space.c:172)
==6550==    by 0x80496C2: main (data_space.c:146)
==6551== 
==6551== 32 bytes in 1 blocks are definitely lost in loss record 2 of 5
==6551==    at 0x40053C0: malloc (vg_replace_malloc.c:149)
==6551==    by 0x8049049: dotest (data_space.c:265)
==6551==    by 0x80495FE: runtest (data_space.c:172)
==6551==    by 0x80496C2: main (data_space.c:146)
==6551== 
==6551== 
==6551== 4,096 bytes in 1 blocks are definitely lost in loss record 3 of 5
==6551==    at 0x40053C0: malloc (vg_replace_malloc.c:149)
==6551==    by 0x8049079: dotest (data_space.c:271)
==6551==    by 0x80495FE: runtest (data_space.c:172)
==6551==    by 0x80496C2: main (data_space.c:146)
==6551== 
==6551== 
==6551== 4,096 bytes in 1 blocks are definitely lost in loss record 4 of 5
==6551==    at 0x40053C0: malloc (vg_replace_malloc.c:149)
==6551==    by 0x8049061: dotest (data_space.c:268)
==6551==    by 0x80495FE: runtest (data_space.c:172)
==6551==    by 0x80496C2: main (data_space.c:146)
==6551== 
==6551== 
==6551== 1,048,576 bytes in 1 blocks are definitely lost in loss record 5 of 5
==6551==    at 0x40053C0: malloc (vg_replace_malloc.c:149)
==6551==    by 0x8049091: dotest (data_space.c:274)
==6551==    by 0x80495FE: runtest (data_space.c:172)
==6551==    by 0x80496C2: main (data_space.c:146)
==6552== 
==6552== 32 bytes in 1 blocks are definitely lost in loss record 2 of 5
==6552==    at 0x40053C0: malloc (vg_replace_malloc.c:149)
==6552==    by 0x8049049: dotest (data_space.c:265)
==6552==    by 0x80495FE: runtest (data_space.c:172)
==6552==    by 0x80496C2: main (data_space.c:146)
==6552== 
==6552== 
==6552== 4,096 bytes in 1 blocks are definitely lost in loss record 3 of 5
==6552==    at 0x40053C0: malloc (vg_replace_malloc.c:149)
==6552==    by 0x8049079: dotest (data_space.c:271)
==6552==    by 0x80495FE: runtest (data_space.c:172)
==6552==    by 0x80496C2: main (data_space.c:146)
==6552== 
==6552== 
==6552== 4,096 bytes in 1 blocks are definitely lost in loss record 4 of 5
==6552==    at 0x40053C0: malloc (vg_replace_malloc.c:149)
==6552==    by 0x8049061: dotest (data_space.c:268)
==6552==    by 0x80495FE: runtest (data_space.c:172)
==6552==    by 0x80496C2: main (data_space.c:146)
==6552== 
==6552== 
==6552== 1,048,576 bytes in 1 blocks are definitely lost in loss record 5 of 5
==6552==    at 0x40053C0: malloc (vg_replace_malloc.c:149)
==6552==    by 0x8049091: dotest (data_space.c:274)
==6552==    by 0x80495FE: runtest (data_space.c:172)
==6552==    by 0x80496C2: main (data_space.c:146)
==6553== 
==6553== 32 bytes in 1 blocks are definitely lost in loss record 2 of 5
==6553==    at 0x40053C0: malloc (vg_replace_malloc.c:149)
==6553==    by 0x8049049: dotest (data_space.c:265)
==6553==    by 0x80495FE: runtest (data_space.c:172)
==6553==    by 0x80496C2: main (data_space.c:146)
==6553== 
==6553== 
==6553== 4,096 bytes in 1 blocks are definitely lost in loss record 3 of 5
==6553==    at 0x40053C0: malloc (vg_replace_malloc.c:149)
==6553==    by 0x8049079: dotest (data_space.c:271)
==6553==    by 0x80495FE: runtest (data_space.c:172)
==6553==    by 0x80496C2: main (data_space.c:146)
==6553== 
==6553== 
==6553== 4,096 bytes in 1 blocks are definitely lost in loss record 4 of 5
==6553==    at 0x40053C0: malloc (vg_replace_malloc.c:149)
==6553==    by 0x8049061: dotest (data_space.c:268)
==6553==    by 0x80495FE: runtest (data_space.c:172)
==6553==    by 0x80496C2: main (data_space.c:146)
==6553== 
==6553== 
==6553== 1,048,576 bytes in 1 blocks are definitely lost in loss record 5 of 5
==6553==    at 0x40053C0: malloc (vg_replace_malloc.c:149)
==6553==    by 0x8049091: dotest (data_space.c:274)
==6553==    by 0x80495FE: runtest (data_space.c:172)
==6553==    by 0x80496C2: main (data_space.c:146)
==6554== 
==6554== 32 bytes in 1 blocks are definitely lost in loss record 2 of 5
==6554==    at 0x40053C0: malloc (vg_replace_malloc.c:149)
==6554==    by 0x8049049: dotest (data_space.c:265)
==6554==    by 0x80495FE: runtest (data_space.c:172)
==6554==    by 0x80496C2: main (data_space.c:146)
==6554== 
==6554== 
==6554== 4,096 bytes in 1 blocks are definitely lost in loss record 3 of 5
==6554==    at 0x40053C0: malloc (vg_replace_malloc.c:149)
==6554==    by 0x8049079: dotest (data_space.c:271)
==6554==    by 0x80495FE: runtest (data_space.c:172)
==6554==    by 0x80496C2: main (data_space.c:146)
==6554== 
==6554== 
==6554== 4,096 bytes in 1 blocks are definitely lost in loss record 4 of 5
==6554==    at 0x40053C0: malloc (vg_replace_malloc.c:149)
==6554==    by 0x8049061: dotest (data_space.c:268)
==6554==    by 0x80495FE: runtest (data_space.c:172)
==6554==    by 0x80496C2: main (data_space.c:146)
==6554== 
==6554== 
==6554== 1,048,576 bytes in 1 blocks are definitely lost in loss record 5 of 5
==6554==    at 0x40053C0: malloc (vg_replace_malloc.c:149)
==6554==    by 0x8049091: dotest (data_space.c:274)
==6554==    by 0x80495FE: runtest (data_space.c:172)
==6554==    by 0x80496C2: main (data_space.c:146)
==6556== 
==6556== 32 bytes in 1 blocks are definitely lost in loss record 2 of 5
==6556==    at 0x40053C0: malloc (vg_replace_malloc.c:149)
==6556==    by 0x8049049: dotest (data_space.c:265)
==6556==    by 0x80495FE: runtest (data_space.c:172)
==6556==    by 0x80496C2: main (data_space.c:146)
==6556== 
==6556== 
==6556== 4,096 bytes in 1 blocks are definitely lost in loss record 3 of 5
==6556==    at 0x40053C0: malloc (vg_replace_malloc.c:149)
==6556==    by 0x8049079: dotest (data_space.c:271)
==6556==    by 0x80495FE: runtest (data_space.c:172)
==6556==    by 0x80496C2: main (data_space.c:146)
==6556== 
==6556== 
==6556== 4,096 bytes in 1 blocks are definitely lost in loss record 4 of 5
==6556==    at 0x40053C0: malloc (vg_replace_malloc.c:149)
==6556==    by 0x8049061: dotest (data_space.c:268)
==6556==    by 0x80495FE: runtest (data_space.c:172)
==6556==    by 0x80496C2: main (data_space.c:146)
==6556== 
==6556== 
==6556== 1,048,576 bytes in 1 blocks are definitely lost in loss record 5 of 5
==6556==    at 0x40053C0: malloc (vg_replace_malloc.c:149)
==6556==    by 0x8049091: dotest (data_space.c:274)
==6556==    by 0x80495FE: runtest (data_space.c:172)
==6556==    by 0x80496C2: main (data_space.c:146)
==6555== 
==6555== 32 bytes in 1 blocks are definitely lost in loss record 2 of 5
==6555==    at 0x40053C0: malloc (vg_replace_malloc.c:149)
==6555==    by 0x8049049: dotest (data_space.c:265)
==6555==    by 0x80495FE: runtest (data_space.c:172)
==6555==    by 0x80496C2: main (data_space.c:146)
==6555== 
==6555== 
==6555== 4,096 bytes in 1 blocks are definitely lost in loss record 3 of 5
==6555==    at 0x40053C0: malloc (vg_replace_malloc.c:149)
==6555==    by 0x8049079: dotest (data_space.c:271)
==6555==    by 0x80495FE: runtest (data_space.c:172)
==6555==    by 0x80496C2: main (data_space.c:146)
==6555== 
==6555== 
==6555== 4,096 bytes in 1 blocks are definitely lost in loss record 4 of 5
==6555==    at 0x40053C0: malloc (vg_replace_malloc.c:149)
==6555==    by 0x8049061: dotest (data_space.c:268)
==6555==    by 0x80495FE: runtest (data_space.c:172)
==6555==    by 0x80496C2: main (data_space.c:146)
==6555== 
==6555== 
==6555== 1,048,576 bytes in 1 blocks are definitely lost in loss record 5 of 5
==6555==    at 0x40053C0: malloc (vg_replace_malloc.c:149)
==6555==    by 0x8049091: dotest (data_space.c:274)
==6555==    by 0x80495FE: runtest (data_space.c:172)
==6555==    by 0x80496C2: main (data_space.c:146)
data_space    1  TPASS  :  Test passed
<<<execution_status>>>
initiation_status="ok"
duration=65 termination_type=exited termination_id=0 corefile=no
cutime=12948 cstime=51
<<<test_end>>>
<<<test_start>>>
tag=stack_space stime=1251102824
cmdline="stack_space"
contacts=""
analysis=exit
<<<test_output>>>
stack_space    1  TPASS  :  Test passed
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=10 cstime=1
<<<test_end>>>
<<<test_start>>>
tag=stack_space_valgrind_memory_leak_check stime=1251102824
cmdline=" valgrind -q --leak-check=full --trace-children=yes  stack_space "
contacts=""
analysis=exit
<<<test_output>>>
stack_space    1  TPASS  :  Test passed
<<<execution_status>>>
initiation_status="ok"
duration=5 termination_type=exited termination_id=0 corefile=no
cutime=830 cstime=43
<<<test_end>>>
<<<test_start>>>
tag=shmt02 stime=1251102829
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
tag=shmt02_valgrind_memory_leak_check stime=1251102829
cmdline=" valgrind -q --leak-check=full --trace-children=yes  shmt02 "
contacts=""
analysis=exit
<<<test_output>>>
shmt02      1  TPASS  :  shmget
shmt02      2  TPASS  :  shmat
shmt02      3  TPASS  :  Correct shared memory contents
<<<execution_status>>>
initiation_status="ok"
duration=1 termination_type=exited termination_id=0 corefile=no
cutime=46 cstime=6
<<<test_end>>>
<<<test_start>>>
tag=shmt03 stime=1251102830
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
cutime=0 cstime=1
<<<test_end>>>
<<<test_start>>>
tag=shmt03_valgrind_memory_leak_check stime=1251102830
cmdline=" valgrind -q --leak-check=full --trace-children=yes  shmt03 "
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
cutime=47 cstime=6
<<<test_end>>>
<<<test_start>>>
tag=shmt04 stime=1251102830
cmdline="shmt04"
contacts=""
analysis=exit
<<<test_output>>>
shmt04      1  TPASS  :  shmget,shmat
shmt04      2  TPASS  :  shmdt
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=shmt04_valgrind_memory_leak_check stime=1251102830
cmdline=" valgrind -q --leak-check=full --trace-children=yes  shmt04 "
contacts=""
analysis=exit
<<<test_output>>>
shmt04      1  TPASS  :  shmget,shmat
shmt04      2  TPASS  :  shmdt
<<<execution_status>>>
initiation_status="ok"
duration=1 termination_type=exited termination_id=0 corefile=no
cutime=56 cstime=8
<<<test_end>>>
<<<test_start>>>
tag=shmt05 stime=1251102831
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
tag=shmt05_valgrind_memory_leak_check stime=1251102831
cmdline=" valgrind -q --leak-check=full --trace-children=yes  shmt05 "
contacts=""
analysis=exit
<<<test_output>>>
shmt05      1  TPASS  :  shmget & shmat
shmt05      2  TPASS  :  2nd shmget & shmat
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=46 cstime=7
<<<test_end>>>
<<<test_start>>>
tag=shmt06 stime=1251102831
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
tag=shmt06_valgrind_memory_leak_check stime=1251102831
cmdline=" valgrind -q --leak-check=full --trace-children=yes  shmt06 "
contacts=""
analysis=exit
<<<test_output>>>
shmt06      1  TPASS  :  shmget,shmat
shmt06      2  TPASS  :  shmdt
<<<execution_status>>>
initiation_status="ok"
duration=1 termination_type=exited termination_id=0 corefile=no
cutime=56 cstime=8
<<<test_end>>>
<<<test_start>>>
tag=shmt07 stime=1251102832
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
tag=shmt07_valgrind_memory_leak_check stime=1251102832
cmdline=" valgrind -q --leak-check=full --trace-children=yes  shmt07 "
contacts=""
analysis=exit
<<<test_output>>>
shmt07      1  TPASS  :  shmget,shmat
shmt07      1  TPASS  :  shmget,shmat
shmt07      2  TPASS  :  cp & cp+1 correct
<<<execution_status>>>
initiation_status="ok"
duration=1 termination_type=exited termination_id=0 corefile=no
cutime=55 cstime=7
<<<test_end>>>
<<<test_start>>>
tag=shmt08 stime=1251102833
cmdline="shmt08"
contacts=""
analysis=exit
<<<test_output>>>
shmt08      1  TPASS  :  shmget,shmat
shmt08      2  TPASS  :  shmdt
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=1
<<<test_end>>>
<<<test_start>>>
tag=shmt08_valgrind_memory_leak_check stime=1251102833
cmdline=" valgrind -q --leak-check=full --trace-children=yes  shmt08 "
contacts=""
analysis=exit
<<<test_output>>>
shmt08      1  TPASS  :  shmget,shmat
shmt08      2  TPASS  :  shmdt
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=47 cstime=5
<<<test_end>>>
<<<test_start>>>
tag=shmt09 stime=1251102833
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
tag=shmt09_valgrind_memory_leak_check stime=1251102833
cmdline=" valgrind -q --leak-check=full --trace-children=yes  shmt09 "
contacts=""
analysis=exit
<<<test_output>>>
shmat1: Invalid argument
shmt09      1  TPASS  :  sbrk, sbrk, shmget, shmat
shmt09      2  TPASS  :  sbrk, shmat
shmt09      3  TFAIL  :  Error: shmat Failed, shmid = 411271172, errno = 22

<<<execution_status>>>
initiation_status="ok"
duration=1 termination_type=exited termination_id=1 corefile=no
cutime=52 cstime=7
<<<test_end>>>
<<<test_start>>>
tag=shmt10 stime=1251102834
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
tag=shmt10_valgrind_memory_leak_check stime=1251102834
cmdline=" valgrind -q --leak-check=full --trace-children=yes  shmt10 "
contacts=""
analysis=exit
<<<test_output>>>
shmt10      1  TPASS  :  shmat,shmdt
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=67 cstime=13
<<<test_end>>>
<<<test_start>>>
tag=shm_test01 stime=1251102834
cmdline="shm_test -l 10 -t 2"
contacts=""
analysis=exit
<<<test_output>>>
pid[6632]: shmat_rd_wr(): shmget():success got segment id 411369476
pid[6632]: do_shmat_shmadt(): got shmat address = 0xb6d3e000
pid[6632]: shmat_rd_wr(): shmget():success got segment id 411369476
pid[6632]: do_shmat_shmadt(): got shmat address = 0xb6b31000
pid[6632]: shmat_rd_wr(): shmget():success got segment id 411402245
pid[6632]: do_shmat_shmadt(): got shmat address = 0xb6d3e000
pid[6632]: shmat_rd_wr(): shmget():success got segment id 411402245
pid[6632]: do_shmat_shmadt(): got shmat address = 0xb6b31000
pid[6632]: shmat_rd_wr(): shmget():success got segment id 411435012
pid[6632]: do_shmat_shmadt(): got shmat address = 0xb6d3e000
pid[6632]: shmat_rd_wr(): shmget():success got segment id 411435012
pid[6632]: do_shmat_shmadt(): got shmat address = 0xb6b31000
pid[6632]: shmat_rd_wr(): shmget():success got segment id 411467781
pid[6632]: do_shmat_shmadt(): got shmat address = 0xb6d3e000
pid[6632]: shmat_rd_wr(): shmget():success got segment id 411467781
pid[6632]: do_shmat_shmadt(): got shmat address = 0xb6b31000
pid[6632]: shmat_rd_wr(): shmget():success got segment id 411500548
pid[6632]: do_shmat_shmadt(): got shmat address = 0xb6d3e000
pid[6632]: shmat_rd_wr(): shmget():success got segment id 411500548
pid[6632]: do_shmat_shmadt(): got shmat address = 0xb6b31000
pid[6632]: shmat_rd_wr(): shmget():success got segment id 411533317
pid[6632]: do_shmat_shmadt(): got shmat address = 0xb6d3e000
pid[6632]: shmat_rd_wr(): shmget():success got segment id 411533317
pid[6632]: do_shmat_shmadt(): got shmat address = 0xb6b31000
pid[6632]: shmat_rd_wr(): shmget():success got segment id 411566084
pid[6632]: do_shmat_shmadt(): got shmat address = 0xb6d3e000
pid[6632]: shmat_rd_wr(): shmget():success got segment id 411566084
pid[6632]: do_shmat_shmadt(): got shmat address = 0xb6b31000
pid[6632]: shmat_rd_wr(): shmget():success got segment id 411598853
pid[6632]: do_shmat_shmadt(): got shmat address = 0xb6d3e000
pid[6632]: shmat_rd_wr(): shmget():success got segment id 411598853
pid[6632]: do_shmat_shmadt(): got shmat address = 0xb6b31000
pid[6632]: shmat_rd_wr(): shmget():success got segment id 411631620
pid[6632]: do_shmat_shmadt(): got shmat address = 0xb6d3e000
pid[6632]: shmat_rd_wr(): shmget():success got segment id 411631620
pid[6632]: do_shmat_shmadt(): got shmat address = 0xb6b31000
pid[6632]: shmat_rd_wr(): shmget():success got segment id 411664389
pid[6632]: do_shmat_shmadt(): got shmat address = 0xb6d3e000
pid[6632]: shmat_rd_wr(): shmget():success got segment id 411664389
pid[6632]: do_shmat_shmadt(): got shmat address = 0xb6b31000
<<<execution_status>>>
initiation_status="ok"
duration=93 termination_type=exited termination_id=0 corefile=no
cutime=1462 cstime=16865
<<<test_end>>>
<<<test_start>>>
tag=shm_test01 stime=1251102927
cmdline="shm_test_valgrind_memory_leak_check  valgrind -q --leak-check=full --trace-children=yes  -l  10  -t  2 "
contacts=""
analysis=exit
<<<test_output>>>
<<<execution_status>>>
initiation_status="pan(5767): execvp of 'shm_test_valgrind_memory_leak_check' (tag shm_test01) failed.  errno:2  No such file or directory"
duration=0 termination_type=exited termination_id=2 corefile=no
cutime=0 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=mallocstress01 stime=1251102927
cmdline="mallocstress"
contacts=""
analysis=exit
<<<test_output>>>
Thread [3]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [39]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [15]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [7]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [43]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [51]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [35]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [23]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [11]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [47]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [19]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [31]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [27]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [55]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [59]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [34]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [26]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [42]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [54]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [38]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [2]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [10]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [46]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [18]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [58]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [50]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [6]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [14]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [30]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [22]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [25]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [13]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [17]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [21]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [29]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [1]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [37]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [53]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [41]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [57]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [5]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [9]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [33]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [45]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [49]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [20]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [48]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [36]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [16]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [40]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [28]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [12]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [44]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [32]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [0]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [56]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [4]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [24]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [52]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [8]: allocate_free() returned 0, succeeded.  Thread exiting.
main(): test passed.
<<<execution_status>>>
initiation_status="ok"
duration=7 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=775
<<<test_end>>>
<<<test_start>>>
tag=mallocstress01 stime=1251102934
cmdline="mallocstress_valgrind_memory_leak_check  valgrind -q --leak-check=full --trace-children=yes "
contacts=""
analysis=exit
<<<test_output>>>
<<<execution_status>>>
initiation_status="pan(5767): execvp of 'mallocstress_valgrind_memory_leak_check' (tag mallocstress01) failed.  errno:2  No such file or directory"
duration=1 termination_type=exited termination_id=2 corefile=no
cutime=0 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=mmapstress01 stime=1251102935
cmdline="mmapstress01 -p 20 -t 0.2"
contacts=""
analysis=exit
<<<test_output>>>
file data okay
mmapstress01    1  TPASS  :  Test passed
<<<execution_status>>>
initiation_status="ok"
duration=12 termination_type=exited termination_id=0 corefile=no
cutime=1386 cstime=702
<<<test_end>>>
<<<test_start>>>
tag=mmapstress01_valgrind_memory_leak_check stime=1251102947
cmdline=" valgrind -q --leak-check=full --trace-children=yes  mmapstress01  -p  20  -t  0.2 "
contacts=""
analysis=exit
<<<test_output>>>
file data okay
mmapstress01    1  TPASS  :  Test passed
==17074== 
==17074== 4,096 bytes in 1 blocks are definitely lost in loss record 3 of 4
==17074==    at 0x40053C0: malloc (vg_replace_malloc.c:149)
==17074==    by 0x80493A6: fileokay (mmapstress01.c:648)
==17074==    by 0x804A1B5: main (mmapstress01.c:434)
<<<execution_status>>>
initiation_status="ok"
duration=12 termination_type=exited termination_id=0 corefile=no
cutime=2230 cstime=245
<<<test_end>>>
<<<test_start>>>
tag=mmapstress02 stime=1251102959
cmdline="mmapstress02"
contacts=""
analysis=exit
<<<test_output>>>
mmapstress02    1  TPASS  :  Test passed

<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=1
<<<test_end>>>
<<<test_start>>>
tag=mmapstress02_valgrind_memory_leak_check stime=1251102959
cmdline=" valgrind -q --leak-check=full --trace-children=yes  mmapstress02 "
contacts=""
analysis=exit
<<<test_output>>>
mmapstress02    1  TPASS  :  Test passed

<<<execution_status>>>
initiation_status="ok"
duration=1 termination_type=exited termination_id=0 corefile=no
cutime=53 cstime=6
<<<test_end>>>
<<<test_start>>>
tag=mmapstress03 stime=1251102960
cmdline="mmapstress03"
contacts=""
analysis=exit
<<<test_output>>>
mmapstress03    1  TPASS  :  Test passed
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=1 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=mmapstress03_valgrind_memory_leak_check stime=1251102960
cmdline=" valgrind -q --leak-check=full --trace-children=yes  mmapstress03 "
contacts=""
analysis=exit
<<<test_output>>>

valgrind: m_syswrap/syswrap-generic.c:1004 (do_brk): Assertion 'aseg' failed.
==17213==    at 0x38016499: report_and_quit (m_libcassert.c:136)
==17213==    by 0x380167C3: vgPlain_assert_fail (m_libcassert.c:200)
==17213==    by 0x3804419C: vgSysWrap_generic_sys_brk_before (syswrap-generic.c:1004)
==17213==    by 0x3804BAEF: vgPlain_client_syscall (syswrap-main.c:719)
==17213==    by 0x380381D9: vgPlain_scheduler (scheduler.c:721)
==17213==    by 0x38057103: run_a_thread_NORETURN (syswrap-linux.c:87)

sched status:
  running_tid=1

Thread 1: status = VgTs_Runnable
==17213==    at 0xA5A770: brk (in /lib/libc-2.5.so)
==17213==    by 0xA5A80C: sbrk (in /lib/libc-2.5.so)
==17213==    by 0x8048F3E: main (mmapstress03.c:156)


Note: see also the FAQ.txt in the source distribution.
It contains workarounds to several common problems.

If that doesn't help, please report this bug to: www.valgrind.org

In the bug report, send all the above text, the valgrind
version, and what Linux distro you are using.  Thanks.

<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=1 corefile=no
cutime=34 cstime=7
<<<test_end>>>
<<<test_start>>>
tag=mmapstress04 stime=1251102960
cmdline="TMPFILE=`mktemp /tmp/example.XXXXXXXXXX`; ls -lR /usr/include/ > $TMPFILE; mmapstress04 $TMPFILE"
contacts=""
analysis=exit
<<<test_output>>>
mmapstress04    1  TPASS  :  Test passed

<<<execution_status>>>
initiation_status="ok"
duration=8 termination_type=exited termination_id=0 corefile=no
cutime=30 cstime=196
<<<test_end>>>
<<<test_start>>>
tag=mmapstress04_valgrind_memory_leak_check stime=1251102968
cmdline=" valgrind -q --leak-check=full --trace-children=yes  TMPFILE=`mktemp  /tmp/example.XXXXXXXXXX`;  ls  -lR  /usr/include/  >  $TMPFILE;  mmapstress04  $TMPFILE "
contacts=""
analysis=exit
<<<test_output>>>
valgrind: TMPFILE=/tmp/example.YvDjU17221: No such file or directory
sh: $TMPFILE: ambiguous redirect
Usage: mmapstress04 filename startoffset
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=1 corefile=no
cutime=0 cstime=1
<<<test_end>>>
<<<test_start>>>
tag=mmapstress05 stime=1251102968
cmdline="mmapstress05"
contacts=""
analysis=exit
<<<test_output>>>
mmapstress05    1  TPASS  :  Test passed

<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=1
<<<test_end>>>
<<<test_start>>>
tag=mmapstress05_valgrind_memory_leak_check stime=1251102968
cmdline=" valgrind -q --leak-check=full --trace-children=yes  mmapstress05 "
contacts=""
analysis=exit
<<<test_output>>>
mmapstress05    1  TPASS  :  Test passed

<<<execution_status>>>
initiation_status="ok"
duration=1 termination_type=exited termination_id=0 corefile=no
cutime=53 cstime=6
<<<test_end>>>
<<<test_start>>>
tag=mmapstress06 stime=1251102969
cmdline="mmapstress06 20"
contacts=""
analysis=exit
<<<test_output>>>
mmapstress06    1  TPASS  :  Test passed

<<<execution_status>>>
initiation_status="ok"
duration=20 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=1
<<<test_end>>>
<<<test_start>>>
tag=mmapstress06_valgrind_memory_leak_check stime=1251102989
cmdline=" valgrind -q --leak-check=full --trace-children=yes  mmapstress06  20 "
contacts=""
analysis=exit
<<<test_output>>>
mmapstress06    1  TPASS  :  Test passed

<<<execution_status>>>
initiation_status="ok"
duration=20 termination_type=exited termination_id=0 corefile=no
cutime=47 cstime=6
<<<test_end>>>
<<<test_start>>>
tag=mmapstress07 stime=1251103009
cmdline="TMPFILE=`mktemp /tmp/example.XXXXXXXXXXXX`; mmapstress07 $TMPFILE"
contacts=""
analysis=exit
<<<test_output>>>
mmapstress07    1  TPASS  :  Test passed

<<<execution_status>>>
initiation_status="ok"
duration=1 termination_type=exited termination_id=0 corefile=no
cutime=1 cstime=21
<<<test_end>>>
<<<test_start>>>
tag=mmapstress07_valgrind_memory_leak_check stime=1251103010
cmdline=" valgrind -q --leak-check=full --trace-children=yes  TMPFILE=`mktemp  /tmp/example.XXXXXXXXXXXX`;  mmapstress07  $TMPFILE "
contacts=""
analysis=exit
<<<test_output>>>
valgrind: TMPFILE=/tmp/example.yUyviVD17237: No such file or directory
Usage: mmapstress07 filename holesize e_pageskip sparseoff
	*holesize should be a multiple of pagesize
	*e_pageskip should be 1 always 
	*sparseoff should be a multiple of pagesize
Example: mmapstress07 myfile 4096 1 8192
mmapstress07    1  TFAIL  :  Test failed

mmapstress07    0  TWARN  :  tst_rmdir(): TESTDIR was NULL; no removal attempted
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=5 corefile=no
cutime=0 cstime=2
<<<test_end>>>
<<<test_start>>>
tag=mmapstress08 stime=1251103010
cmdline="mmapstress08"
contacts=""
analysis=exit
<<<test_output>>>
mmapstress08    1  TPASS  :  Test passed

<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=mmapstress08_valgrind_memory_leak_check stime=1251103010
cmdline=" valgrind -q --leak-check=full --trace-children=yes  mmapstress08 "
contacts=""
analysis=exit
<<<test_output>>>
==17241== Warning: client syscall munmap tried to modify addresses 0x804F000-0x3FFFFFFF
mmapstress08: errno = 22: munmap failed
mmapstress08    1  TFAIL  :  Test failed

<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=1 corefile=no
cutime=49 cstime=7
<<<test_end>>>
<<<test_start>>>
tag=mmapstress09 stime=1251103010
cmdline="mmapstress09 -p 20 -t 0.2"
contacts=""
analysis=exit
<<<test_output>>>
map data okay
mmapstress09    1  TPASS  :  Test passed

<<<execution_status>>>
initiation_status="ok"
duration=12 termination_type=exited termination_id=0 corefile=no
cutime=1385 cstime=733
<<<test_end>>>
<<<test_start>>>
tag=mmapstress09_valgrind_memory_leak_check stime=1251103022
cmdline=" valgrind -q --leak-check=full --trace-children=yes  mmapstress09  -p  20  -t  0.2 "
contacts=""
analysis=exit
<<<test_output>>>
map data okay
mmapstress09    1  TPASS  :  Test passed

<<<execution_status>>>
initiation_status="ok"
duration=14 termination_type=exited termination_id=0 corefile=no
cutime=2398 cstime=273
<<<test_end>>>
<<<test_start>>>
tag=mmapstress10 stime=1251103036
cmdline="mmapstress10 -p 20 -t 0.2"
contacts=""
analysis=exit
<<<test_output>>>
file data okay
mmapstress10    1  TPASS  :  Test passed

<<<execution_status>>>
initiation_status="ok"
duration=12 termination_type=exited termination_id=0 corefile=no
cutime=983 cstime=1127
<<<test_end>>>
<<<test_start>>>
tag=mmapstress10_valgrind_memory_leak_check stime=1251103048
cmdline=" valgrind -q --leak-check=full --trace-children=yes  mmapstress10  -p  20  -t  0.2 "
contacts=""
analysis=exit
<<<test_output>>>
file data okay
mmapstress10    1  TPASS  :  Test passed

==10349== 
==10349== 4,096 bytes in 1 blocks are definitely lost in loss record 3 of 4
==10349==    at 0x40053C0: malloc (vg_replace_malloc.c:149)
==10349==    by 0x8049415: fileokay (mmapstress10.c:804)
==10349==    by 0x804A4DC: main (mmapstress10.c:494)
incrementing stop
<<<execution_status>>>
initiation_status="ok"
duration=13 termination_type=exited termination_id=0 corefile=no
cutime=2202 cstime=270
<<<test_end>>>
====================================================


====================================================
# ./runltp -f mm -M 3 -o ltp_mm_test_memory_leak_check-and-thread_concurrency_checks
====================================================
<<<test_start>>>
tag=mm01 stime=1251103062
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
cutime=5 cstime=51
<<<test_end>>>
<<<test_start>>>
tag=mm01_valgrind_memory_leak_check stime=1251103063
cmdline=" valgrind -q --leak-check=full --trace-children=yes  mmap001  -m  10000 "
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
duration=5 termination_type=exited termination_id=0 corefile=no
cutime=317 cstime=60
<<<test_end>>>
<<<test_start>>>
tag=mm01_valgrind_thread_concurrency_check stime=1251103068
cmdline=" valgrind -q --tool=helgrind --trace-children=yes  mmap001  -m  10000 "
contacts=""
analysis=exit
<<<test_output>>>

Helgrind is currently not working, because:
 (a) it is not yet ready to handle the Vex IR and the use with 64-bit
     platforms introduced in Valgrind 3.0.0
 (b) we need to get thread operation tracking working again after
     the changes added in Valgrind 2.4.0
 If you want to use Helgrind, you'll have to use Valgrind 2.2.0, which is
 the most recent Valgrind release that contains a working Helgrind.

Sorry for the inconvenience.  Let us know if this is a problem for you.
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=1 corefile=no
cutime=0 cstime=1
<<<test_end>>>
<<<test_start>>>
tag=mm02 stime=1251103068
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
cutime=1 cstime=6
<<<test_end>>>
<<<test_start>>>
tag=mm02_valgrind_memory_leak_check stime=1251103068
cmdline=" valgrind -q --leak-check=full --trace-children=yes  mmap001 "
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
duration=1 termination_type=exited termination_id=0 corefile=no
cutime=82 cstime=11
<<<test_end>>>
<<<test_start>>>
tag=mm02_valgrind_thread_concurrency_check stime=1251103069
cmdline=" valgrind -q --tool=helgrind --trace-children=yes  mmap001 "
contacts=""
analysis=exit
<<<test_output>>>

Helgrind is currently not working, because:
 (a) it is not yet ready to handle the Vex IR and the use with 64-bit
     platforms introduced in Valgrind 3.0.0
 (b) we need to get thread operation tracking working again after
     the changes added in Valgrind 2.4.0
 If you want to use Helgrind, you'll have to use Valgrind 2.2.0, which is
 the most recent Valgrind release that contains a working Helgrind.

Sorry for the inconvenience.  Let us know if this is a problem for you.
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=1 corefile=no
cutime=0 cstime=1
<<<test_end>>>
<<<test_start>>>
tag=mtest01 stime=1251103069
cmdline="mtest01 -p80"
contacts=""
analysis=exit
<<<test_output>>>
mtest01     0  TINFO  :  Total memory used needed to reach maxpercent = 4923782 kbytes
mtest01     0  TINFO  :  Total memory already used on system = 137012 kbytes
mtest01     0  TINFO  :  Filling up 80% of ram which is 4786770 kbytes
mtest01     1  TPASS  :  4786770 kbytes allocated only.
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=mtest01_valgrind_memory_leak_check stime=1251103069
cmdline=" valgrind -q --leak-check=full --trace-children=yes  mtest01  -p80 "
contacts=""
analysis=exit
<<<test_output>>>
mtest01     0  TINFO  :  Total memory used needed to reach maxpercent = 4923782 kbytes
mtest01     0  TINFO  :  Total memory already used on system = 147048 kbytes
mtest01     0  TINFO  :  Filling up 80% of ram which is 4776734 kbytes
mtest01     1  TPASS  :  4776734 kbytes allocated only.
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=51 cstime=9
<<<test_end>>>
<<<test_start>>>
tag=mtest01_valgrind_thread_concurrency_check stime=1251103069
cmdline=" valgrind -q --tool=helgrind --trace-children=yes  mtest01  -p80 "
contacts=""
analysis=exit
<<<test_output>>>

Helgrind is currently not working, because:
 (a) it is not yet ready to handle the Vex IR and the use with 64-bit
     platforms introduced in Valgrind 3.0.0
 (b) we need to get thread operation tracking working again after
     the changes added in Valgrind 2.4.0
 If you want to use Helgrind, you'll have to use Valgrind 2.2.0, which is
 the most recent Valgrind release that contains a working Helgrind.

Sorry for the inconvenience.  Let us know if this is a problem for you.
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=1 corefile=no
cutime=0 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=mtest01w stime=1251103069
cmdline="mtest01 -p80 -w"
contacts=""
analysis=exit
<<<test_output>>>
mtest01     0  TINFO  :  Total memory used needed to reach maxpercent = 4923782 kbytes
mtest01     0  TINFO  :  Total memory already used on system = 137024 kbytes
mtest01     0  TINFO  :  Filling up 80% of ram which is 4786758 kbytes
mtest01     1  TPASS  :  4786758 kbytes allocated and used.
<<<execution_status>>>
initiation_status="ok"
duration=63 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=1
<<<test_end>>>
<<<test_start>>>
tag=mtest01w_valgrind_memory_leak_check stime=1251103132
cmdline=" valgrind -q --leak-check=full --trace-children=yes  mtest01  -p80  -w "
contacts=""
analysis=exit
<<<test_output>>>
mtest01     0  TINFO  :  Total memory used needed to reach maxpercent = 4923782 kbytes
mtest01     0  TINFO  :  Total memory already used on system = 117956 kbytes
mtest01     0  TINFO  :  Filling up 80% of ram which is 4805826 kbytes
mtest01     1  TPASS  :  4805826 kbytes allocated and used.
<<<execution_status>>>
initiation_status="ok"
duration=278 termination_type=exited termination_id=0 corefile=no
cutime=71 cstime=17
<<<test_end>>>
<<<test_start>>>
tag=mtest01w_valgrind_thread_concurrency_check stime=1251103410
cmdline=" valgrind -q --tool=helgrind --trace-children=yes  mtest01  -p80  -w "
contacts=""
analysis=exit
<<<test_output>>>

Helgrind is currently not working, because:
 (a) it is not yet ready to handle the Vex IR and the use with 64-bit
     platforms introduced in Valgrind 3.0.0
 (b) we need to get thread operation tracking working again after
     the changes added in Valgrind 2.4.0
 If you want to use Helgrind, you'll have to use Valgrind 2.2.0, which is
 the most recent Valgrind release that contains a working Helgrind.

Sorry for the inconvenience.  Let us know if this is a problem for you.
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=1 corefile=no
cutime=0 cstime=2
<<<test_end>>>
<<<test_start>>>
tag=mtest05 stime=1251103410
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
cutime=4 cstime=772
<<<test_end>>>
<<<test_start>>>
tag=mtest05_valgrind_memory_leak_check stime=1251103417
cmdline=" valgrind -q --leak-check=full --trace-children=yes      mmstress "
contacts=""
analysis=exit
<<<test_output>>>
mmstress    0  TINFO  :  run mmstress -h for all options
mmstress    0  TINFO  :  test1: Test case tests the race condition between simultaneous read faults in the same address space.
==10864== Syscall param write(buf) points to uninitialised byte(s)
==10864==    at 0xB12423: __write_nocancel (in /lib/libpthread-2.5.so)
==10864==    by 0x80497B4: test1 (mmstress.c:580)
==10864==    by 0x8049C9A: main (mmstress.c:975)
==10864==  Address 0x4023028 is 0 bytes inside a block of size 40,955,904 alloc'd
==10864==    at 0x40053C0: malloc (vg_replace_malloc.c:149)
==10864==    by 0x80493E2: map_and_thread (mmstress.c:407)
==10864==    by 0x80497B4: test1 (mmstress.c:580)
==10864==    by 0x8049C9A: main (mmstress.c:975)
mmstress    1  TPASS  :  TEST 1 Passed
mmstress    0  TINFO  :  test2: Test case tests the race condition between simultaneous write faults in the same address space.
==10864== 
==10864== Syscall param write(buf) points to uninitialised byte(s)
==10864==    at 0xB1244B: (within /lib/libpthread-2.5.so)
==10864==    by 0x8049764: test2 (mmstress.c:609)
==10864==    by 0x8049C9A: main (mmstress.c:975)
==10864==  Address 0x4023028 is 0 bytes inside a block of size 40,955,904 alloc'd
==10864==    at 0x40053C0: malloc (vg_replace_malloc.c:149)
==10864==    by 0x80493E2: map_and_thread (mmstress.c:407)
==10864==    by 0x8049764: test2 (mmstress.c:609)
==10864==    by 0x8049C9A: main (mmstress.c:975)
mmstress    2  TPASS  :  TEST 2 Passed
mmstress    0  TINFO  :  test3: Test case tests the race condition between simultaneous COW faults in the same address space.
==10864== 
==10864== Syscall param write(buf) points to uninitialised byte(s)
==10864==    at 0xB1244B: (within /lib/libpthread-2.5.so)
==10864==    by 0x8049714: test3 (mmstress.c:638)
==10864==    by 0x8049C9A: main (mmstress.c:975)
==10864==  Address 0x4023028 is 0 bytes inside a block of size 40,955,904 alloc'd
==10864==    at 0x40053C0: malloc (vg_replace_malloc.c:149)
==10864==    by 0x80493E2: map_and_thread (mmstress.c:407)
==10864==    by 0x8049714: test3 (mmstress.c:638)
==10864==    by 0x8049C9A: main (mmstress.c:975)
mmstress    3  TPASS  :  TEST 3 Passed
mmstress    0  TINFO  :  test4: Test case tests the race condition between simultaneous READ faults in the same address space. The file mapped is /dev/zero
==10864== 
==10864== Syscall param write(buf) points to uninitialised byte(s)
==10864==    at 0xB1244B: (within /lib/libpthread-2.5.so)
==10864==    by 0x80496C4: test4 (mmstress.c:667)
==10864==    by 0x8049C9A: main (mmstress.c:975)
==10864==  Address 0x4023028 is 0 bytes inside a block of size 40,955,904 alloc'd
==10864==    at 0x40053C0: malloc (vg_replace_malloc.c:149)
==10864==    by 0x80493E2: map_and_thread (mmstress.c:407)
==10864==    by 0x80496C4: test4 (mmstress.c:667)
==10864==    by 0x8049C9A: main (mmstress.c:975)
mmstress    4  TPASS  :  TEST 4 Passed
mmstress    0  TINFO  :  test5: Test case tests the race condition between simultaneous fork - exit faults in the same address space.
mmstress    5  TPASS  :  TEST 5 Passed
mmstress    0  TINFO  :  test6: Test case tests the race condition between simultaneous fork -exec - exit faults in the same address space.
mmstress    6  TPASS  :  TEST 6 Passed
mmstress    7  TPASS  :  Test Passed
<<<execution_status>>>
initiation_status="ok"
duration=40 termination_type=exited termination_id=0 corefile=no
cutime=2317 cstime=3479
<<<test_end>>>
<<<test_start>>>
tag=mtest05_valgrind_thread_concurrency_check stime=1251103457
cmdline=" valgrind -q --tool=helgrind --trace-children=yes      mmstress "
contacts=""
analysis=exit
<<<test_output>>>

Helgrind is currently not working, because:
 (a) it is not yet ready to handle the Vex IR and the use with 64-bit
     platforms introduced in Valgrind 3.0.0
 (b) we need to get thread operation tracking working again after
     the changes added in Valgrind 2.4.0
 If you want to use Helgrind, you'll have to use Valgrind 2.2.0, which is
 the most recent Valgrind release that contains a working Helgrind.

Sorry for the inconvenience.  Let us know if this is a problem for you.
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=1 corefile=no
cutime=0 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=mtest06_2 stime=1251103457
cmdline="mmap2 -x 0.002 -a -p"
contacts=""
analysis=exit
<<<test_output>>>
MM Stress test, map/write/unmap large file
	Test scheduled to run for:       0.002000
	Size of temp file in GB:         1
file mapped at 0x7c6c7000
changing file content to 'A'
unmapped file at 0x7c6c7000
file mapped at 0x7c6c7000
changing file content to 'A'
unmapped file at 0x7c6c7000
file mapped at 0x7c6c7000
changing file content to 'A'
Test ended, success
<<<execution_status>>>
initiation_status="ok"
duration=7 termination_type=exited termination_id=0 corefile=no
cutime=43 cstime=668
<<<test_end>>>
<<<test_start>>>
tag=mtest06_2_valgrind_memory_leak_check stime=1251103464
cmdline=" valgrind -q --leak-check=full --trace-children=yes  mmap2  -x  0.002  -a  -p "
contacts=""
analysis=exit
<<<test_output>>>
MM Stress test, map/write/unmap large file
	Test scheduled to run for:       0.002000
	Size of temp file in GB:         1
file mapped at 0x63abb000
changing file content to 'A'
Test ended, success
<<<execution_status>>>
initiation_status="ok"
duration=8 termination_type=exited termination_id=0 corefile=no
cutime=720 cstime=52
<<<test_end>>>
<<<test_start>>>
tag=mtest06_2_valgrind_thread_concurrency_check stime=1251103472
cmdline=" valgrind -q --tool=helgrind --trace-children=yes  mmap2  -x  0.002  -a  -p "
contacts=""
analysis=exit
<<<test_output>>>

Helgrind is currently not working, because:
 (a) it is not yet ready to handle the Vex IR and the use with 64-bit
     platforms introduced in Valgrind 3.0.0
 (b) we need to get thread operation tracking working again after
     the changes added in Valgrind 2.4.0
 If you want to use Helgrind, you'll have to use Valgrind 2.2.0, which is
 the most recent Valgrind release that contains a working Helgrind.

Sorry for the inconvenience.  Let us know if this is a problem for you.
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=1 corefile=no
cutime=0 cstime=1
<<<test_end>>>
<<<test_start>>>
tag=mtest06_3 stime=1251103472
cmdline="mmap3 -x 0.002 -p"
contacts=""
analysis=exit
<<<test_output>>>



Test is set to run with the following parameters:
	Duration of test: [0.002000]hrs
	Number of threads created: [40]
	number of map-write-unmaps: [1000]
	map_private?(T=1 F=0): [1]



Map address = 0xa3e1b000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa3e1b000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa3cff000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa3e1b000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa3cff000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa3e1b000
Num iter: [2]
Total Num Iter: [1000]Map address = 0xa3e1b000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa3be3000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa3cff000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa3be3000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa3921000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa2ced000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa36e9000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa34b1000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa39ab000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa3279000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa3041000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa2645000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa3805000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa3e1b000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa35cd000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa3395000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa2529000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa2ab5000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa1dff000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa2037000
Num iter: [2]
Total Num Iter: [1000]Map address = 0xa240d000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa2f25000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa2e09000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa1f1b000
Num iter: [2]
Total Num Iter: [1000]Map address = 0xa2bd1000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa3be3000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa287d000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa2999000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa315d000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa3921000
Num iter: [2]
Total Num Iter: [1000]Map address = 0xa2761000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa1a21000
Num iter: [3]
Total Num Iter: [1000]Map address = 0xa214b000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa1aab000
Num iter: [2]
Total Num Iter: [1000]Map address = 0xa3ac7000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa1ce3000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa2267000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa22f1000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa3c75000
Num iter: [2]
Total Num Iter: [1000]Map address = 0xa3e23000
Num iter: [2]
Total Num Iter: [1000]Map address = 0xa20c1000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa3ead000
Num iter: [2]
Total Num Iter: [1000]Map address = 0xa1bc7000
Num iter: [2]
Total Num Iter: [1000]Map address = 0xa39b3000
Num iter: [2]
Total Num Iter: [1000]Map address = 0xa3897000
Num iter: [2]
Total Num Iter: [1000]Map address = 0xa3cff000
Num iter: [1]
Total Num Iter: [1000]Map address = 0xa3a3d000
Num iter: [2]
Total Num Iter: [1000]Map address = 0xa380d000
Num iter: [2]
Total Num Iter: [1000]Map address = 0xa3e23000
Num iter: [2]
Total Num Iter: [1000]Map address = 0xa3ead000
Num iter: [2]
Total Num Iter: [1000]Map address = 0xa168d000
Num iter: [3]
Total Num Iter: [1000]Map address = 0xa39d3000
Num iter: [2]
Total Num Iter: [1000]Map address = 0xa34f9000
Num iter: [3]
Total Num Iter: [1000]Map address = 0xa2cc2000
Num iter: [4]
Total Num Iter: [1000]Map address = 0xa3721000
Num iter: [3]
Total Num Iter: [1000]Map address = 0xa3697000
Num iter: [2]
Total Num Iter: [1000]Map address = 0xa335b000
Num iter: [2]
Total Num Iter: [1000]Map address = 0xa3835000
Num iter: [2]
Total Num Iter: [1000]Map address = 0xa2e60000
Num iter: [2]
Total Num Iter: [1000]Map address = 0xa346f000
Num iter: [2]
Total Num Iter: [1000]Map address = 0xa3583000
Num iter: [2]
Total Num Iter: [1000]Map address = 0xa33e5000
Num iter: [3]
Total Num Iter: [1000]Map address = 0xa17a1000
Num iter: [3]
Total Num Iter: [1000]Map address = 0xa2eea000
Num iter: [2]
Total Num Iter: [1000]Map address = 0xa2c38000
Num iter: [3]
Total Num Iter: [1000]Map address = 0xa182b000
Num iter: [3]
Total Num Iter: [1000]Map address = 0xa1717000
Num iter: [2]
Total Num Iter: [1000]Map address = 0xa360d000
Num iter: [2]
Total Num Iter: [1000]Map address = 0xa3c85000
Num iter: [2]
Total Num Iter: [1000]Map address = 0xa3d99000
Num iter: [2]
Total Num Iter: [1000]Map address = 0xa37ab000
Num iter: [2]
Total Num Iter: [1000]Map address = 0xa2d4c000
Num iter: [2]
Total Num Iter: [1000]Map address = 0xa3ead000
Num iter: [2]
Total Num Iter: [1000]Map address = 0xa3b71000
Num iter: [2]
Total Num Iter: [1000]Map address = 0xa3bfb000
Num iter: [2]
Total Num Iter: [1000]Map address = 0xa3d0f000
Num iter: [3]
Total Num Iter: [1000]Map address = 0xa3ae7000
Num iter: [2]
Total Num Iter: [1000]Map address = 0xa3e23000
Num iter: [2]
Total Num Iter: [1000]Map address = 0xa2dd6000
Num iter: [2]
Total Num Iter: [1000]Map address = 0xa38bf000
Num iter: [2]
Total Num Iter: [1000]Map address = 0xa3949000
Num iter: [3]
Total Num Iter: [1000]Map address = 0xa3a5d000
Num iter: [2]
Total Num Iter: [1000]Map address = 0xa2f74000
Num iter: [2]
Total Num Iter: [1000]Map address = 0xa2851000
Num iter: [3]
Total Num Iter: [1000]Map address = 0xa246a000
Num iter: [2]
Total Num Iter: [1000]Map address = 0xa18b5000
Num iter: [3]
Total Num Iter: [1000]Map address = 0xa1c9c000
Num iter: [3]
Total Num Iter: [1000]Map address = 0xa2083000
Num iter: [2]
Total Num Iter: [1000]Map address = 0xa3c6d000
Num iter: [3]
Total Num Iter: [1000]Map address = 0xa3dd2000
Num iter: [3]
Total Num Iter: [1000]Map address = 0xa21ee000
Num iter: [4]
Total Num Iter: [1000]Map address = 0xa2089000
Num iter: [3]
Total Num Iter: [1000]Map address = 0xa2a4c000
Num iter: [4]
Total Num Iter: [1000]Map address = 0xa28e7000
Num iter: [3]
Total Num Iter: [1000]Map address = 0xa2782000
Num iter: [5]
Total Num Iter: [1000]Map address = 0xa2e7b000
Num iter: [4]
Total Num Iter: [1000]Map address = 0xa3c6d000
Num iter: [3]
Total Num Iter: [1000]Map address = 0xa2bb1000
Num iter: [3]
Total Num Iter: [1000]Map address = 0xa2d16000
Num iter: [4]
Total Num Iter: [1000]Map address = 0xa24b8000
Num iter: [3]
Total Num Iter: [1000]Map address = 0xa1990000
Num iter: [3]
Total Num Iter: [1000]Map address = 0xa3145000
Num iter: [4]
Total Num Iter: [1000]Map address = 0xa1561000
Num iter: [3]
Total Num Iter: [1000]Map address = 0xa1f24000
Num iter: [3]
Total Num Iter: [1000]Map address = 0xa383e000
Num iter: [3]
Total Num Iter: [1000]Map address = 0xa182b000
Num iter: [3]
Total Num Iter: [1000]Map address = 0xa1dbf000
Num iter: [4]
Total Num Iter: [1000]Map address = 0xa3ceb000
Num iter: [6]
Total Num Iter: [1000]Map address = 0xa3210000
Num iter: [5]
Total Num Iter: [1000]Map address = 0xa31c3000
Num iter: [4]
Total Num Iter: [1000]Map address = 0xa325d000
Num iter: [4]
Total Num Iter: [1000]Map address = 0xa13fc000
Num iter: [3]
Total Num Iter: [1000]Map address = 0xa1af5000
Num iter: [3]
Total Num Iter: [1000]Map address = 0xa36d9000
Num iter: [3]
Total Num Iter: [1000]Map address = 0xa3c9e000
Num iter: [4]
Total Num Iter: [1000]Map address = 0xa3956000
Num iter: [5]
Total Num Iter: [1000]Map address = 0xa3574000
Num iter: [3]
Total Num Iter: [1000]Map address = 0xa3dd2000
Num iter: [3]
Total Num Iter: [1000]Map address = 0xa39a3000
Num iter: [3]
Total Num Iter: [1000]Map address = 0xa2353000
Num iter: [3]
Total Num Iter: [1000]Map address = 0xa2fe0000
Num iter: [3]
Total Num Iter: [1000]Map address = 0xa1297000
Num iter: [3]
Total Num Iter: [1000]Map address = 0xa3d85000
Num iter: [4]
Total Num Iter: [1000]Map address = 0xa3eea000
Num iter: [4]
Total Num Iter: [1000]Map address = 0xa3b08000
Num iter: [4]
Total Num Iter: [1000]Map address = 0xa1132000
Num iter: [3]
Total Num Iter: [1000]Map address = 0xa16c6000
Num iter: [3]
Total Num Iter: [1000]Map address = 0xa32aa000
Num iter: [3]
Total Num Iter: [1000]Map address = 0xa1c5a000
Num iter: [4]
Total Num Iter: [1000]Map address = 0xa261d000
Num iter: [4]
Total Num Iter: [1000]Map address = 0xa340f000
Num iter: [3]
Total Num Iter: [1000]Map address = 0xa0a39000
Num iter: [4]
Total Num Iter: [1000]Map address = 0xa3d38000
Num iter: [5]
Total Num Iter: [1000]Map address = 0xa38bc000
Num iter: [4]
Total Num Iter: [1000]Map address = 0xa2b64000
Num iter: [5]
Total Num Iter: [1000]Map address = 0xa0fcd000
Num iter: [4]
Total Num Iter: [1000]Map address = 0xa3909000
Num iter: [4]
Total Num Iter: [1000]Map address = 0xa2f93000
Num iter: [4]
Total Num Iter: [1000]Map address = 0xa2f46000
Num iter: [4]
Total Num Iter: [1000]Map address = 0xa3176000
Num iter: [5]
Total Num Iter: [1000]Map address = 0xa2278000
Num iter: [4]
Total Num Iter: [1000]Map address = 0xa0d03000
Num iter: [3]
Total Num Iter: [1000]Map address = 0xa0b9e000
Num iter: [3]
Total Num Iter: [1000]Map address = 0xa095e000
Num iter: [4]
Total Num Iter: [1000]Map address = 0xa0e68000
Num iter: [4]
Total Num Iter: [1000]Map address = 0xa3e50000
Num iter: [4]
Total Num Iter: [1000]Map address = 0xa3e9d000
Num iter: [5]
Total Num Iter: [1000]Map address = 0xa3e50000
Num iter: [4]
Total Num Iter: [1000]Map address = 0xa3eea000
Num iter: [4]
Total Num Iter: [1000]Map address = 0xa3eea000
Num iter: [4]
Total Num Iter: [1000]Map address = 0xa3eea000
Num iter: [7]
Total Num Iter: [1000]Map address = 0xa3e9d000
Num iter: [5]
Total Num Iter: [1000]Map address = 0xa3eea000
Num iter: [4]
Total Num Iter: [1000]Map address = 0xa3e50000
Num iter: [5]
Total Num Iter: [1000]Map address = 0xa3eea000
Num iter: [5]
Total Num Iter: [1000]Map address = 0xa3e9d000
Num iter: [6]
Total Num Iter: [1000]Map address = 0xa3eea000
Num iter: [6]
Total Num Iter: [1000]Map address = 0xa3e03000
Num iter: [6]
Total Num Iter: [1000]Map address = 0xa3e50000
Num iter: [5]
Total Num Iter: [1000]Map address = 0xa3db6000
Num iter: [5]
Total Num Iter: [1000]Map address = 0xa3e9d000
Num iter: [5]
Total Num Iter: [1000]Map address = 0xa3d1c000
Num iter: [4]
Total Num Iter: [1000]Map address = 0xa3d69000
Num iter: [4]
Total Num Iter: [1000]Map address = 0xa3eea000
Num iter: [5]
Total Num Iter: [1000]Map address = 0xa3c82000
Num iter: [4]
Total Num Iter: [1000]Map address = 0xa3ccf000
Num iter: [4]
Total Num Iter: [1000]Map address = 0xa3c35000
Num iter: [4]
Total Num Iter: [1000]Map address = 0xa3be8000
Num iter: [4]
Total Num Iter: [1000]Map address = 0xa3a1a000
Num iter: [5]
Total Num Iter: [1000]Map address = 0xa39cd000
Num iter: [5]
Total Num Iter: [1000]Map address = 0xa3b9b000
Num iter: [4]
Total Num Iter: [1000]Map address = 0xa3b4e000
Num iter: [4]
Total Num Iter: [1000]Map address = 0xa3980000
Num iter: [6]
Total Num Iter: [1000]Map address = 0xa3a67000
Num iter: [6]
Total Num Iter: [1000]Map address = 0xa384c000
Num iter: [4]
Total Num Iter: [1000]Map address = 0xa3b01000
Num iter: [5]
Total Num Iter: [1000]Map address = 0xa37ff000
Num iter: [5]
Total Num Iter: [1000]Map address = 0xa3ab4000
Num iter: [5]
Total Num Iter: [1000]Map address = 0xa3933000
Num iter: [5]
Total Num Iter: [1000]Map address = 0xa38e6000
Num iter: [5]
Total Num Iter: [1000]Map address = 0xa3899000
Num iter: [5]
Total Num Iter: [1000]Map address = 0xa3eea000
Num iter: [7]
Total Num Iter: [1000]Map address = 0xa3eea000
Num iter: [5]
Total Num Iter: [1000]Map address = 0xa3e50000
Num iter: [5]
Total Num Iter: [1000]Map address = 0xa3e9d000
Num iter: [6]
Total Num Iter: [1000]Map address = 0xa3e03000
Num iter: [5]
Total Num Iter: [1000]Map address = 0xa3db6000
Num iter: [5]
Total Num Iter: [1000]Map address = 0xa3d69000
Num iter: [5]
Total Num Iter: [1000]Map address = 0xa3c35000
Num iter: [6]
Total Num Iter: [1000]Map address = 0xa3c82000
Num iter: [8]
Total Num Iter: [1000]Map address = 0xa3d1c000
Num iter: [6]
Total Num Iter: [1000]Map address = 0xa3ccf000
Num iter: [7]
Total Num Iter: [1000]Map address = 0xa3be8000
Num iter: [6]
Total Num Iter: [1000]Map address = 0xa3765000
Num iter: [5]
Total Num Iter: [1000]Map address = 0xa3718000
Num iter: [4]
Total Num Iter: [1000]Map address = 0xa36cb000
Num iter: [4]
Total Num Iter: [1000]Map address = 0xa3bd7000
Num iter: [6]
Total Num Iter: [1000]Map address = 0xa37b2000
Num iter: [5]
Total Num Iter: [1000]Map address = 0xa3d87000
Num iter: [7]
Total Num Iter: [1000]Map address = 0xa3a27000
Num iter: [6]
Total Num Iter: [1000]Test ended, success
<<<execution_status>>>
initiation_status="ok"
duration=8 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=682
<<<test_end>>>
<<<test_start>>>
tag=mtest06_3_valgrind_memory_leak_check stime=1251103480
cmdline=" valgrind -q --leak-check=full --trace-children=yes  mmap3  -x  0.002  -p "
contacts=""
analysis=exit
<<<test_output>>>



Test is set to run with the following parameters:
	Duration of test: [0.002000]hrs
	Number of threads created: [40]
	number of map-write-unmaps: [1000]
	map_private?(T=1 F=0): [1]



Map address = 0x792a000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x792a000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x792a000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x7d28000
Num iter: [2]
Total Num Iter: [1000]Map address = 0x792a000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x1906e000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x7b29000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x19e04000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x1a762000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x195ce000
Num iter: [2]
Total Num Iter: [1000]Map address = 0x792a000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x7b29000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x1c37c000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x1a003000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x19c05000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x1ba1e000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x7d7e000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x1a364000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x19c05000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x1aec1000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x1906e000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x792a000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x1bc1d000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x1be1c000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x1a563000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x1b81f000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x1a961000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x1c01b000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x1926d000
Num iter: [1]
Total Num Iter: [1000]Map address = 0x1b421000
Num iter: [1]
Total Num Iter: [1000]Test ended, success
==11106== 
==11106== 5,440 bytes in 40 blocks are possibly lost in loss record 1 of 1
==11106==    at 0x40046FF: calloc (vg_replace_malloc.c:279)
==11106==    by 0x97ED49: _dl_allocate_tls (in /lib/ld-2.5.so)
==11106==    by 0xB0BB92: pthread_create@@GLIBC_2.1 (in /lib/libpthread-2.5.so)
==11106==    by 0x8048FDC: main (mmap3.c:402)
<<<execution_status>>>
initiation_status="ok"
duration=21 termination_type=exited termination_id=0 corefile=no
cutime=1636 cstime=472
<<<test_end>>>
<<<test_start>>>
tag=mtest06_3_valgrind_thread_concurrency_check stime=1251103501
cmdline=" valgrind -q --tool=helgrind --trace-children=yes  mmap3  -x  0.002  -p "
contacts=""
analysis=exit
<<<test_output>>>

Helgrind is currently not working, because:
 (a) it is not yet ready to handle the Vex IR and the use with 64-bit
     platforms introduced in Valgrind 3.0.0
 (b) we need to get thread operation tracking working again after
     the changes added in Valgrind 2.4.0
 If you want to use Helgrind, you'll have to use Valgrind 2.2.0, which is
 the most recent Valgrind release that contains a working Helgrind.

Sorry for the inconvenience.  Let us know if this is a problem for you.
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=1 corefile=no
cutime=0 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=mem01 stime=1251103501
cmdline="mem01"
contacts=""
analysis=exit
<<<test_output>>>
mem01       0  TINFO  :  Free Mem:	1960 Mb
mem01       0  TINFO  :  Free Swap:	3943 Mb
mem01       0  TINFO  :  Total Free:	5904 Mb
mem01       0  TINFO  :  Total Tested:	1008 Mb
mem01       0  TINFO  :  touching 1008MB of malloc'ed memory (linear)
mem01       1  TPASS  :  malloc - alloc of 1008MB succeeded
<<<execution_status>>>
initiation_status="ok"
duration=3 termination_type=exited termination_id=0 corefile=no
cutime=11 cstime=309
<<<test_end>>>
<<<test_start>>>
tag=mem01_valgrind_memory_leak_check stime=1251103504
cmdline=" valgrind -q --leak-check=full --trace-children=yes  mem01 "
contacts=""
analysis=exit
<<<test_output>>>
mem01       0  TINFO  :  Free Mem:	1946 Mb
mem01       0  TINFO  :  Free Swap:	3944 Mb
mem01       0  TINFO  :  Total Free:	5891 Mb
mem01       0  TINFO  :  Total Tested:	1008 Mb
mem01       0  TINFO  :  touching 1008MB of malloc'ed memory (linear)
mem01       1  TPASS  :  malloc - alloc of 1008MB succeeded
<<<execution_status>>>
initiation_status="ok"
duration=5 termination_type=exited termination_id=0 corefile=no
cutime=90 cstime=382
<<<test_end>>>
<<<test_start>>>
tag=mem01_valgrind_thread_concurrency_check stime=1251103509
cmdline=" valgrind -q --tool=helgrind --trace-children=yes  mem01 "
contacts=""
analysis=exit
<<<test_output>>>

Helgrind is currently not working, because:
 (a) it is not yet ready to handle the Vex IR and the use with 64-bit
     platforms introduced in Valgrind 3.0.0
 (b) we need to get thread operation tracking working again after
     the changes added in Valgrind 2.4.0
 If you want to use Helgrind, you'll have to use Valgrind 2.2.0, which is
 the most recent Valgrind release that contains a working Helgrind.

Sorry for the inconvenience.  Let us know if this is a problem for you.
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=1 corefile=no
cutime=0 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=mem02 stime=1251103509
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
tag=mem02_valgrind_memory_leak_check stime=1251103509
cmdline=" valgrind -q --leak-check=full --trace-children=yes  mem02 "
contacts=""
analysis=exit
<<<test_output>>>
mem02       1  TPASS  :  calloc - calloc of 64MB of memory succeeded
mem02       2  TPASS  :  malloc - malloc of 64MB of memory succeeded
mem02       3  TPASS  :  realloc - realloc of 5 bytes succeeded
mem02       4  TPASS  :  realloc - realloc of 15 bytes succeeded
<<<execution_status>>>
initiation_status="ok"
duration=12 termination_type=exited termination_id=0 corefile=no
cutime=1154 cstime=52
<<<test_end>>>
<<<test_start>>>
tag=mem02_valgrind_thread_concurrency_check stime=1251103521
cmdline=" valgrind -q --tool=helgrind --trace-children=yes  mem02 "
contacts=""
analysis=exit
<<<test_output>>>

Helgrind is currently not working, because:
 (a) it is not yet ready to handle the Vex IR and the use with 64-bit
     platforms introduced in Valgrind 3.0.0
 (b) we need to get thread operation tracking working again after
     the changes added in Valgrind 2.4.0
 If you want to use Helgrind, you'll have to use Valgrind 2.2.0, which is
 the most recent Valgrind release that contains a working Helgrind.

Sorry for the inconvenience.  Let us know if this is a problem for you.
<<<execution_status>>>
initiation_status="ok"
duration=1 termination_type=exited termination_id=1 corefile=no
cutime=0 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=mem03 stime=1251103522
cmdline="mem03"
contacts=""
analysis=exit
<<<test_output>>>
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=1
<<<test_end>>>
<<<test_start>>>
tag=mem03_valgrind_memory_leak_check stime=1251103522
cmdline=" valgrind -q --leak-check=full --trace-children=yes  mem03 "
contacts=""
analysis=exit
<<<test_output>>>
==11159== Syscall param write(buf) points to unaddressable byte(s)
==11159==    at 0xA53273: __write_nocancel (in /lib/libc-2.5.so)
==11159==    by 0x9F3994: new_do_write (in /lib/libc-2.5.so)
==11159==    by 0x9F3C7E: _IO_do_write@@GLIBC_2.1 (in /lib/libc-2.5.so)
==11159==    by 0x9F4455: _IO_file_sync@@GLIBC_2.1 (in /lib/libc-2.5.so)
==11159==    by 0x9E908B: fflush (in /lib/libc-2.5.so)
==11159==    by 0x8049B1B: tst_flush (tst_res.c:451)
==11159==    by 0x8049B7A: tst_exit (tst_res.c:591)
==11159==    by 0x8048D95: cleanup (mem03.c:178)
==11159==    by 0x80491F5: main (mem03.c:142)
==11159==  Address 0x4009000 is not stack'd, malloc'd or (recently) free'd
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=54 cstime=6
<<<test_end>>>
<<<test_start>>>
tag=mem03_valgrind_thread_concurrency_check stime=1251103522
cmdline=" valgrind -q --tool=helgrind --trace-children=yes  mem03 "
contacts=""
analysis=exit
<<<test_output>>>

Helgrind is currently not working, because:
 (a) it is not yet ready to handle the Vex IR and the use with 64-bit
     platforms introduced in Valgrind 3.0.0
 (b) we need to get thread operation tracking working again after
     the changes added in Valgrind 2.4.0
 If you want to use Helgrind, you'll have to use Valgrind 2.2.0, which is
 the most recent Valgrind release that contains a working Helgrind.

Sorry for the inconvenience.  Let us know if this is a problem for you.
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=1 corefile=no
cutime=0 cstime=1
<<<test_end>>>
<<<test_start>>>
tag=page01 stime=1251103522
cmdline="page01"
contacts=""
analysis=exit
<<<test_output>>>
page01      1  TPASS  :  Test passed
<<<execution_status>>>
initiation_status="ok"
duration=1 termination_type=exited termination_id=0 corefile=no
cutime=4 cstime=23
<<<test_end>>>
<<<test_start>>>
tag=page01_valgrind_memory_leak_check stime=1251103523
cmdline=" valgrind -q --leak-check=full --trace-children=yes  page01 "
contacts=""
analysis=exit
<<<test_output>>>
page01      1  TPASS  :  Test passed
<<<execution_status>>>
initiation_status="ok"
duration=7 termination_type=exited termination_id=0 corefile=no
cutime=1145 cstime=123
<<<test_end>>>
<<<test_start>>>
tag=page01_valgrind_thread_concurrency_check stime=1251103530
cmdline=" valgrind -q --tool=helgrind --trace-children=yes  page01 "
contacts=""
analysis=exit
<<<test_output>>>

Helgrind is currently not working, because:
 (a) it is not yet ready to handle the Vex IR and the use with 64-bit
     platforms introduced in Valgrind 3.0.0
 (b) we need to get thread operation tracking working again after
     the changes added in Valgrind 2.4.0
 If you want to use Helgrind, you'll have to use Valgrind 2.2.0, which is
 the most recent Valgrind release that contains a working Helgrind.

Sorry for the inconvenience.  Let us know if this is a problem for you.
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=1 corefile=no
cutime=0 cstime=1
<<<test_end>>>
<<<test_start>>>
tag=page02 stime=1251103530
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
tag=page02_valgrind_memory_leak_check stime=1251103531
cmdline=" valgrind -q --leak-check=full --trace-children=yes  page02 "
contacts=""
analysis=exit
<<<test_output>>>
==11271== 
==11271== 524,288 bytes in 1 blocks are possibly lost in loss record 2 of 2
==11271==    at 0x40053C0: malloc (vg_replace_malloc.c:149)
==11271==    by 0x8048FCD: main (page02.c:134)
==11272== 
==11272== 524,288 bytes in 1 blocks are possibly lost in loss record 2 of 2
==11272==    at 0x40053C0: malloc (vg_replace_malloc.c:149)
==11272==    by 0x8048FCD: main (page02.c:134)
==11273== 
==11273== 524,288 bytes in 1 blocks are possibly lost in loss record 2 of 2
==11273==    at 0x40053C0: malloc (vg_replace_malloc.c:149)
==11273==    by 0x8048FCD: main (page02.c:134)
==11274== 
==11274== 524,288 bytes in 1 blocks are possibly lost in loss record 2 of 2
==11274==    at 0x40053C0: malloc (vg_replace_malloc.c:149)
==11274==    by 0x8048FCD: main (page02.c:134)
==11275== 
==11275== 524,288 bytes in 1 blocks are possibly lost in loss record 2 of 2
==11275==    at 0x40053C0: malloc (vg_replace_malloc.c:149)
==11275==    by 0x8048FCD: main (page02.c:134)
page02      1  TPASS  :  Test passed
<<<execution_status>>>
initiation_status="ok"
duration=4 termination_type=exited termination_id=0 corefile=no
cutime=122 cstime=15
<<<test_end>>>
<<<test_start>>>
tag=page02_valgrind_thread_concurrency_check stime=1251103535
cmdline=" valgrind -q --tool=helgrind --trace-children=yes  page02 "
contacts=""
analysis=exit
<<<test_output>>>

Helgrind is currently not working, because:
 (a) it is not yet ready to handle the Vex IR and the use with 64-bit
     platforms introduced in Valgrind 3.0.0
 (b) we need to get thread operation tracking working again after
     the changes added in Valgrind 2.4.0
 If you want to use Helgrind, you'll have to use Valgrind 2.2.0, which is
 the most recent Valgrind release that contains a working Helgrind.

Sorry for the inconvenience.  Let us know if this is a problem for you.
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=1 corefile=no
cutime=0 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=data_space stime=1251103535
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
tag=data_space_valgrind_memory_leak_check stime=1251103536
cmdline=" valgrind -q --leak-check=full --trace-children=yes  data_space "
contacts=""
analysis=exit
<<<test_output>>>
==11289== 
==11289== 32 bytes in 1 blocks are definitely lost in loss record 2 of 5
==11289==    at 0x40053C0: malloc (vg_replace_malloc.c:149)
==11289==    by 0x8049049: dotest (data_space.c:265)
==11289==    by 0x80495FE: runtest (data_space.c:172)
==11289==    by 0x80496C2: main (data_space.c:146)
==11289== 
==11289== 
==11289== 4,096 bytes in 1 blocks are definitely lost in loss record 3 of 5
==11289==    at 0x40053C0: malloc (vg_replace_malloc.c:149)
==11289==    by 0x8049079: dotest (data_space.c:271)
==11289==    by 0x80495FE: runtest (data_space.c:172)
==11289==    by 0x80496C2: main (data_space.c:146)
==11289== 
==11289== 
==11289== 4,096 bytes in 1 blocks are definitely lost in loss record 4 of 5
==11289==    at 0x40053C0: malloc (vg_replace_malloc.c:149)
==11289==    by 0x8049061: dotest (data_space.c:268)
==11289==    by 0x80495FE: runtest (data_space.c:172)
==11289==    by 0x80496C2: main (data_space.c:146)
==11289== 
==11289== 
==11289== 1,048,576 bytes in 1 blocks are definitely lost in loss record 5 of 5
==11289==    at 0x40053C0: malloc (vg_replace_malloc.c:149)
==11289==    by 0x8049091: dotest (data_space.c:274)
==11289==    by 0x80495FE: runtest (data_space.c:172)
==11289==    by 0x80496C2: main (data_space.c:146)
==11290== 
==11290== 32 bytes in 1 blocks are definitely lost in loss record 2 of 5
==11290==    at 0x40053C0: malloc (vg_replace_malloc.c:149)
==11290==    by 0x8049049: dotest (data_space.c:265)
==11290==    by 0x80495FE: runtest (data_space.c:172)
==11290==    by 0x80496C2: main (data_space.c:146)
==11290== 
==11290== 
==11290== 4,096 bytes in 1 blocks are definitely lost in loss record 3 of 5
==11290==    at 0x40053C0: malloc (vg_replace_malloc.c:149)
==11290==    by 0x8049079: dotest (data_space.c:271)
==11290==    by 0x80495FE: runtest (data_space.c:172)
==11290==    by 0x80496C2: main (data_space.c:146)
==11290== 
==11290== 
==11290== 4,096 bytes in 1 blocks are definitely lost in loss record 4 of 5
==11290==    at 0x40053C0: malloc (vg_replace_malloc.c:149)
==11290==    by 0x8049061: dotest (data_space.c:268)
==11290==    by 0x80495FE: runtest (data_space.c:172)
==11290==    by 0x80496C2: main (data_space.c:146)
==11290== 
==11290== 
==11290== 1,048,576 bytes in 1 blocks are definitely lost in loss record 5 of 5
==11290==    at 0x40053C0: malloc (vg_replace_malloc.c:149)
==11290==    by 0x8049091: dotest (data_space.c:274)
==11290==    by 0x80495FE: runtest (data_space.c:172)
==11290==    by 0x80496C2: main (data_space.c:146)
==11291== 
==11291== 32 bytes in 1 blocks are definitely lost in loss record 2 of 5
==11291==    at 0x40053C0: malloc (vg_replace_malloc.c:149)
==11291==    by 0x8049049: dotest (data_space.c:265)
==11291==    by 0x80495FE: runtest (data_space.c:172)
==11291==    by 0x80496C2: main (data_space.c:146)
==11291== 
==11291== 
==11291== 4,096 bytes in 1 blocks are definitely lost in loss record 3 of 5
==11291==    at 0x40053C0: malloc (vg_replace_malloc.c:149)
==11291==    by 0x8049079: dotest (data_space.c:271)
==11291==    by 0x80495FE: runtest (data_space.c:172)
==11291==    by 0x80496C2: main (data_space.c:146)
==11291== 
==11291== 
==11291== 4,096 bytes in 1 blocks are definitely lost in loss record 4 of 5
==11291==    at 0x40053C0: malloc (vg_replace_malloc.c:149)
==11291==    by 0x8049061: dotest (data_space.c:268)
==11291==    by 0x80495FE: runtest (data_space.c:172)
==11291==    by 0x80496C2: main (data_space.c:146)
==11291== 
==11291== 
==11291== 1,048,576 bytes in 1 blocks are definitely lost in loss record 5 of 5
==11291==    at 0x40053C0: malloc (vg_replace_malloc.c:149)
==11291==    by 0x8049091: dotest (data_space.c:274)
==11291==    by 0x80495FE: runtest (data_space.c:172)
==11291==    by 0x80496C2: main (data_space.c:146)
==11292== 
==11292== 32 bytes in 1 blocks are definitely lost in loss record 2 of 5
==11292==    at 0x40053C0: malloc (vg_replace_malloc.c:149)
==11292==    by 0x8049049: dotest (data_space.c:265)
==11292==    by 0x80495FE: runtest (data_space.c:172)
==11292==    by 0x80496C2: main (data_space.c:146)
==11292== 
==11292== 
==11292== 4,096 bytes in 1 blocks are definitely lost in loss record 3 of 5
==11292==    at 0x40053C0: malloc (vg_replace_malloc.c:149)
==11292==    by 0x8049079: dotest (data_space.c:271)
==11292==    by 0x80495FE: runtest (data_space.c:172)
==11292==    by 0x80496C2: main (data_space.c:146)
==11292== 
==11292== 
==11292== 4,096 bytes in 1 blocks are definitely lost in loss record 4 of 5
==11292==    at 0x40053C0: malloc (vg_replace_malloc.c:149)
==11292==    by 0x8049061: dotest (data_space.c:268)
==11292==    by 0x80495FE: runtest (data_space.c:172)
==11292==    by 0x80496C2: main (data_space.c:146)
==11292== 
==11292== 
==11292== 1,048,576 bytes in 1 blocks are definitely lost in loss record 5 of 5
==11292==    at 0x40053C0: malloc (vg_replace_malloc.c:149)
==11292==    by 0x8049091: dotest (data_space.c:274)
==11292==    by 0x80495FE: runtest (data_space.c:172)
==11292==    by 0x80496C2: main (data_space.c:146)
==11293== 
==11293== 32 bytes in 1 blocks are definitely lost in loss record 2 of 5
==11293==    at 0x40053C0: malloc (vg_replace_malloc.c:149)
==11293==    by 0x8049049: dotest (data_space.c:265)
==11293==    by 0x80495FE: runtest (data_space.c:172)
==11293==    by 0x80496C2: main (data_space.c:146)
==11293== 
==11293== 
==11293== 4,096 bytes in 1 blocks are definitely lost in loss record 3 of 5
==11293==    at 0x40053C0: malloc (vg_replace_malloc.c:149)
==11293==    by 0x8049079: dotest (data_space.c:271)
==11293==    by 0x80495FE: runtest (data_space.c:172)
==11293==    by 0x80496C2: main (data_space.c:146)
==11293== 
==11293== 
==11293== 4,096 bytes in 1 blocks are definitely lost in loss record 4 of 5
==11293==    at 0x40053C0: malloc (vg_replace_malloc.c:149)
==11293==    by 0x8049061: dotest (data_space.c:268)
==11293==    by 0x80495FE: runtest (data_space.c:172)
==11293==    by 0x80496C2: main (data_space.c:146)
==11293== 
==11293== 
==11293== 1,048,576 bytes in 1 blocks are definitely lost in loss record 5 of 5
==11293==    at 0x40053C0: malloc (vg_replace_malloc.c:149)
==11293==    by 0x8049091: dotest (data_space.c:274)
==11293==    by 0x80495FE: runtest (data_space.c:172)
==11293==    by 0x80496C2: main (data_space.c:146)
==11298== 
==11298== 32 bytes in 1 blocks are definitely lost in loss record 2 of 5
==11298==    at 0x40053C0: malloc (vg_replace_malloc.c:149)
==11298==    by 0x8049049: dotest (data_space.c:265)
==11298==    by 0x80495FE: runtest (data_space.c:172)
==11298==    by 0x80496C2: main (data_space.c:146)
==11298== 
==11298== 
==11298== 4,096 bytes in 1 blocks are definitely lost in loss record 3 of 5
==11298==    at 0x40053C0: malloc (vg_replace_malloc.c:149)
==11298==    by 0x8049079: dotest (data_space.c:271)
==11298==    by 0x80495FE: runtest (data_space.c:172)
==11298==    by 0x80496C2: main (data_space.c:146)
==11298== 
==11298== 
==11298== 4,096 bytes in 1 blocks are definitely lost in loss record 4 of 5
==11298==    at 0x40053C0: malloc (vg_replace_malloc.c:149)
==11298==    by 0x8049061: dotest (data_space.c:268)
==11298==    by 0x80495FE: runtest (data_space.c:172)
==11298==    by 0x80496C2: main (data_space.c:146)
==11298== 
==11298== 
==11298== 1,048,576 bytes in 1 blocks are definitely lost in loss record 5 of 5
==11298==    at 0x40053C0: malloc (vg_replace_malloc.c:149)
==11298==    by 0x8049091: dotest (data_space.c:274)
==11298==    by 0x80495FE: runtest (data_space.c:172)
==11298==    by 0x80496C2: main (data_space.c:146)
==11294== 
==11294== 32 bytes in 1 blocks are definitely lost in loss record 2 of 5
==11294==    at 0x40053C0: malloc (vg_replace_malloc.c:149)
==11294==    by 0x8049049: dotest (data_space.c:265)
==11294==    by 0x80495FE: runtest (data_space.c:172)
==11294==    by 0x80496C2: main (data_space.c:146)
==11294== 
==11294== 
==11294== 4,096 bytes in 1 blocks are definitely lost in loss record 3 of 5
==11294==    at 0x40053C0: malloc (vg_replace_malloc.c:149)
==11294==    by 0x8049079: dotest (data_space.c:271)
==11294==    by 0x80495FE: runtest (data_space.c:172)
==11294==    by 0x80496C2: main (data_space.c:146)
==11294== 
==11294== 
==11294== 4,096 bytes in 1 blocks are definitely lost in loss record 4 of 5
==11294==    at 0x40053C0: malloc (vg_replace_malloc.c:149)
==11294==    by 0x8049061: dotest (data_space.c:268)
==11294==    by 0x80495FE: runtest (data_space.c:172)
==11294==    by 0x80496C2: main (data_space.c:146)
==11294== 
==11294== 
==11294== 1,048,576 bytes in 1 blocks are definitely lost in loss record 5 of 5
==11294==    at 0x40053C0: malloc (vg_replace_malloc.c:149)
==11294==    by 0x8049091: dotest (data_space.c:274)
==11294==    by 0x80495FE: runtest (data_space.c:172)
==11294==    by 0x80496C2: main (data_space.c:146)
==11295== 
==11295== 32 bytes in 1 blocks are definitely lost in loss record 2 of 5
==11295==    at 0x40053C0: malloc (vg_replace_malloc.c:149)
==11295==    by 0x8049049: dotest (data_space.c:265)
==11295==    by 0x80495FE: runtest (data_space.c:172)
==11295==    by 0x80496C2: main (data_space.c:146)
==11295== 
==11295== 
==11295== 4,096 bytes in 1 blocks are definitely lost in loss record 3 of 5
==11295==    at 0x40053C0: malloc (vg_replace_malloc.c:149)
==11295==    by 0x8049079: dotest (data_space.c:271)
==11295==    by 0x80495FE: runtest (data_space.c:172)
==11295==    by 0x80496C2: main (data_space.c:146)
==11295== 
==11295== 
==11295== 4,096 bytes in 1 blocks are definitely lost in loss record 4 of 5
==11295==    at 0x40053C0: malloc (vg_replace_malloc.c:149)
==11295==    by 0x8049061: dotest (data_space.c:268)
==11295==    by 0x80495FE: runtest (data_space.c:172)
==11295==    by 0x80496C2: main (data_space.c:146)
==11295== 
==11295== 
==11295== 1,048,576 bytes in 1 blocks are definitely lost in loss record 5 of 5
==11295==    at 0x40053C0: malloc (vg_replace_malloc.c:149)
==11295==    by 0x8049091: dotest (data_space.c:274)
==11295==    by 0x80495FE: runtest (data_space.c:172)
==11295==    by 0x80496C2: main (data_space.c:146)
==11297== 
==11297== 32 bytes in 1 blocks are definitely lost in loss record 2 of 5
==11297==    at 0x40053C0: malloc (vg_replace_malloc.c:149)
==11297==    by 0x8049049: dotest (data_space.c:265)
==11297==    by 0x80495FE: runtest (data_space.c:172)
==11297==    by 0x80496C2: main (data_space.c:146)
==11297== 
==11297== 
==11297== 4,096 bytes in 1 blocks are definitely lost in loss record 3 of 5
==11297==    at 0x40053C0: malloc (vg_replace_malloc.c:149)
==11297==    by 0x8049079: dotest (data_space.c:271)
==11297==    by 0x80495FE: runtest (data_space.c:172)
==11297==    by 0x80496C2: main (data_space.c:146)
==11297== 
==11297== 
==11297== 4,096 bytes in 1 blocks are definitely lost in loss record 4 of 5
==11297==    at 0x40053C0: malloc (vg_replace_malloc.c:149)
==11297==    by 0x8049061: dotest (data_space.c:268)
==11297==    by 0x80495FE: runtest (data_space.c:172)
==11297==    by 0x80496C2: main (data_space.c:146)
==11297== 
==11297== 
==11297== 1,048,576 bytes in 1 blocks are definitely lost in loss record 5 of 5
==11297==    at 0x40053C0: malloc (vg_replace_malloc.c:149)
==11297==    by 0x8049091: dotest (data_space.c:274)
==11297==    by 0x80495FE: runtest (data_space.c:172)
==11297==    by 0x80496C2: main (data_space.c:146)
==11296== 
==11296== 32 bytes in 1 blocks are definitely lost in loss record 2 of 5
==11296==    at 0x40053C0: malloc (vg_replace_malloc.c:149)
==11296==    by 0x8049049: dotest (data_space.c:265)
==11296==    by 0x80495FE: runtest (data_space.c:172)
==11296==    by 0x80496C2: main (data_space.c:146)
==11296== 
==11296== 
==11296== 4,096 bytes in 1 blocks are definitely lost in loss record 3 of 5
==11296==    at 0x40053C0: malloc (vg_replace_malloc.c:149)
==11296==    by 0x8049079: dotest (data_space.c:271)
==11296==    by 0x80495FE: runtest (data_space.c:172)
==11296==    by 0x80496C2: main (data_space.c:146)
==11296== 
==11296== 
==11296== 4,096 bytes in 1 blocks are definitely lost in loss record 4 of 5
==11296==    at 0x40053C0: malloc (vg_replace_malloc.c:149)
==11296==    by 0x8049061: dotest (data_space.c:268)
==11296==    by 0x80495FE: runtest (data_space.c:172)
==11296==    by 0x80496C2: main (data_space.c:146)
==11296== 
==11296== 
==11296== 1,048,576 bytes in 1 blocks are definitely lost in loss record 5 of 5
==11296==    at 0x40053C0: malloc (vg_replace_malloc.c:149)
==11296==    by 0x8049091: dotest (data_space.c:274)
==11296==    by 0x80495FE: runtest (data_space.c:172)
==11296==    by 0x80496C2: main (data_space.c:146)
data_space    1  TPASS  :  Test passed
<<<execution_status>>>
initiation_status="ok"
duration=66 termination_type=exited termination_id=0 corefile=no
cutime=12968 cstime=53
<<<test_end>>>
<<<test_start>>>
tag=data_space_valgrind_thread_concurrency_check stime=1251103602
cmdline=" valgrind -q --tool=helgrind --trace-children=yes  data_space "
contacts=""
analysis=exit
<<<test_output>>>

Helgrind is currently not working, because:
 (a) it is not yet ready to handle the Vex IR and the use with 64-bit
     platforms introduced in Valgrind 3.0.0
 (b) we need to get thread operation tracking working again after
     the changes added in Valgrind 2.4.0
 If you want to use Helgrind, you'll have to use Valgrind 2.2.0, which is
 the most recent Valgrind release that contains a working Helgrind.

Sorry for the inconvenience.  Let us know if this is a problem for you.
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=1 corefile=no
cutime=0 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=stack_space stime=1251103602
cmdline="stack_space"
contacts=""
analysis=exit
<<<test_output>>>
stack_space    1  TPASS  :  Test passed
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=10 cstime=2
<<<test_end>>>
<<<test_start>>>
tag=stack_space_valgrind_memory_leak_check stime=1251103602
cmdline=" valgrind -q --leak-check=full --trace-children=yes  stack_space "
contacts=""
analysis=exit
<<<test_output>>>
stack_space    1  TPASS  :  Test passed
<<<execution_status>>>
initiation_status="ok"
duration=4 termination_type=exited termination_id=0 corefile=no
cutime=828 cstime=45
<<<test_end>>>
<<<test_start>>>
tag=stack_space_valgrind_thread_concurrency_check stime=1251103606
cmdline=" valgrind -q --tool=helgrind --trace-children=yes  stack_space "
contacts=""
analysis=exit
<<<test_output>>>

Helgrind is currently not working, because:
 (a) it is not yet ready to handle the Vex IR and the use with 64-bit
     platforms introduced in Valgrind 3.0.0
 (b) we need to get thread operation tracking working again after
     the changes added in Valgrind 2.4.0
 If you want to use Helgrind, you'll have to use Valgrind 2.2.0, which is
 the most recent Valgrind release that contains a working Helgrind.

Sorry for the inconvenience.  Let us know if this is a problem for you.
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=1 corefile=no
cutime=0 cstime=1
<<<test_end>>>
<<<test_start>>>
tag=shmt02 stime=1251103606
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
tag=shmt02_valgrind_memory_leak_check stime=1251103606
cmdline=" valgrind -q --leak-check=full --trace-children=yes  shmt02 "
contacts=""
analysis=exit
<<<test_output>>>
shmt02      1  TPASS  :  shmget
shmt02      2  TPASS  :  shmat
shmt02      3  TPASS  :  Correct shared memory contents
<<<execution_status>>>
initiation_status="ok"
duration=1 termination_type=exited termination_id=0 corefile=no
cutime=46 cstime=6
<<<test_end>>>
<<<test_start>>>
tag=shmt02_valgrind_thread_concurrency_check stime=1251103607
cmdline=" valgrind -q --tool=helgrind --trace-children=yes  shmt02 "
contacts=""
analysis=exit
<<<test_output>>>

Helgrind is currently not working, because:
 (a) it is not yet ready to handle the Vex IR and the use with 64-bit
     platforms introduced in Valgrind 3.0.0
 (b) we need to get thread operation tracking working again after
     the changes added in Valgrind 2.4.0
 If you want to use Helgrind, you'll have to use Valgrind 2.2.0, which is
 the most recent Valgrind release that contains a working Helgrind.

Sorry for the inconvenience.  Let us know if this is a problem for you.
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=1 corefile=no
cutime=0 cstime=1
<<<test_end>>>
<<<test_start>>>
tag=shmt03 stime=1251103607
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
tag=shmt03_valgrind_memory_leak_check stime=1251103607
cmdline=" valgrind -q --leak-check=full --trace-children=yes  shmt03 "
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
cutime=46 cstime=6
<<<test_end>>>
<<<test_start>>>
tag=shmt03_valgrind_thread_concurrency_check stime=1251103607
cmdline=" valgrind -q --tool=helgrind --trace-children=yes  shmt03 "
contacts=""
analysis=exit
<<<test_output>>>

Helgrind is currently not working, because:
 (a) it is not yet ready to handle the Vex IR and the use with 64-bit
     platforms introduced in Valgrind 3.0.0
 (b) we need to get thread operation tracking working again after
     the changes added in Valgrind 2.4.0
 If you want to use Helgrind, you'll have to use Valgrind 2.2.0, which is
 the most recent Valgrind release that contains a working Helgrind.

Sorry for the inconvenience.  Let us know if this is a problem for you.
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=1 corefile=no
cutime=0 cstime=1
<<<test_end>>>
<<<test_start>>>
tag=shmt04 stime=1251103607
cmdline="shmt04"
contacts=""
analysis=exit
<<<test_output>>>
shmt04      1  TPASS  :  shmget,shmat
shmt04      2  TPASS  :  shmdt
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=shmt04_valgrind_memory_leak_check stime=1251103607
cmdline=" valgrind -q --leak-check=full --trace-children=yes  shmt04 "
contacts=""
analysis=exit
<<<test_output>>>
shmt04      1  TPASS  :  shmget,shmat
shmt04      2  TPASS  :  shmdt
<<<execution_status>>>
initiation_status="ok"
duration=1 termination_type=exited termination_id=0 corefile=no
cutime=56 cstime=9
<<<test_end>>>
<<<test_start>>>
tag=shmt04_valgrind_thread_concurrency_check stime=1251103608
cmdline=" valgrind -q --tool=helgrind --trace-children=yes  shmt04 "
contacts=""
analysis=exit
<<<test_output>>>

Helgrind is currently not working, because:
 (a) it is not yet ready to handle the Vex IR and the use with 64-bit
     platforms introduced in Valgrind 3.0.0
 (b) we need to get thread operation tracking working again after
     the changes added in Valgrind 2.4.0
 If you want to use Helgrind, you'll have to use Valgrind 2.2.0, which is
 the most recent Valgrind release that contains a working Helgrind.

Sorry for the inconvenience.  Let us know if this is a problem for you.
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=1 corefile=no
cutime=0 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=shmt05 stime=1251103608
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
tag=shmt05_valgrind_memory_leak_check stime=1251103608
cmdline=" valgrind -q --leak-check=full --trace-children=yes  shmt05 "
contacts=""
analysis=exit
<<<test_output>>>
shmt05      1  TPASS  :  shmget & shmat
shmt05      2  TPASS  :  2nd shmget & shmat
<<<execution_status>>>
initiation_status="ok"
duration=1 termination_type=exited termination_id=0 corefile=no
cutime=47 cstime=6
<<<test_end>>>
<<<test_start>>>
tag=shmt05_valgrind_thread_concurrency_check stime=1251103609
cmdline=" valgrind -q --tool=helgrind --trace-children=yes  shmt05 "
contacts=""
analysis=exit
<<<test_output>>>

Helgrind is currently not working, because:
 (a) it is not yet ready to handle the Vex IR and the use with 64-bit
     platforms introduced in Valgrind 3.0.0
 (b) we need to get thread operation tracking working again after
     the changes added in Valgrind 2.4.0
 If you want to use Helgrind, you'll have to use Valgrind 2.2.0, which is
 the most recent Valgrind release that contains a working Helgrind.

Sorry for the inconvenience.  Let us know if this is a problem for you.
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=1 corefile=no
cutime=0 cstime=1
<<<test_end>>>
<<<test_start>>>
tag=shmt06 stime=1251103609
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
tag=shmt06_valgrind_memory_leak_check stime=1251103609
cmdline=" valgrind -q --leak-check=full --trace-children=yes  shmt06 "
contacts=""
analysis=exit
<<<test_output>>>
shmt06      1  TPASS  :  shmget,shmat
shmt06      2  TPASS  :  shmdt
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=56 cstime=8
<<<test_end>>>
<<<test_start>>>
tag=shmt06_valgrind_thread_concurrency_check stime=1251103609
cmdline=" valgrind -q --tool=helgrind --trace-children=yes  shmt06 "
contacts=""
analysis=exit
<<<test_output>>>

Helgrind is currently not working, because:
 (a) it is not yet ready to handle the Vex IR and the use with 64-bit
     platforms introduced in Valgrind 3.0.0
 (b) we need to get thread operation tracking working again after
     the changes added in Valgrind 2.4.0
 If you want to use Helgrind, you'll have to use Valgrind 2.2.0, which is
 the most recent Valgrind release that contains a working Helgrind.

Sorry for the inconvenience.  Let us know if this is a problem for you.
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=1 corefile=no
cutime=0 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=shmt07 stime=1251103609
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
tag=shmt07_valgrind_memory_leak_check stime=1251103609
cmdline=" valgrind -q --leak-check=full --trace-children=yes  shmt07 "
contacts=""
analysis=exit
<<<test_output>>>
shmt07      1  TPASS  :  shmget,shmat
shmt07      1  TPASS  :  shmget,shmat
shmt07      2  TPASS  :  cp & cp+1 correct
<<<execution_status>>>
initiation_status="ok"
duration=1 termination_type=exited termination_id=0 corefile=no
cutime=55 cstime=7
<<<test_end>>>
<<<test_start>>>
tag=shmt07_valgrind_thread_concurrency_check stime=1251103610
cmdline=" valgrind -q --tool=helgrind --trace-children=yes  shmt07 "
contacts=""
analysis=exit
<<<test_output>>>

Helgrind is currently not working, because:
 (a) it is not yet ready to handle the Vex IR and the use with 64-bit
     platforms introduced in Valgrind 3.0.0
 (b) we need to get thread operation tracking working again after
     the changes added in Valgrind 2.4.0
 If you want to use Helgrind, you'll have to use Valgrind 2.2.0, which is
 the most recent Valgrind release that contains a working Helgrind.

Sorry for the inconvenience.  Let us know if this is a problem for you.
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=1 corefile=no
cutime=0 cstime=1
<<<test_end>>>
<<<test_start>>>
tag=shmt08 stime=1251103610
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
tag=shmt08_valgrind_memory_leak_check stime=1251103610
cmdline=" valgrind -q --leak-check=full --trace-children=yes  shmt08 "
contacts=""
analysis=exit
<<<test_output>>>
shmt08      1  TPASS  :  shmget,shmat
shmt08      2  TPASS  :  shmdt
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=46 cstime=6
<<<test_end>>>
<<<test_start>>>
tag=shmt08_valgrind_thread_concurrency_check stime=1251103610
cmdline=" valgrind -q --tool=helgrind --trace-children=yes  shmt08 "
contacts=""
analysis=exit
<<<test_output>>>

Helgrind is currently not working, because:
 (a) it is not yet ready to handle the Vex IR and the use with 64-bit
     platforms introduced in Valgrind 3.0.0
 (b) we need to get thread operation tracking working again after
     the changes added in Valgrind 2.4.0
 If you want to use Helgrind, you'll have to use Valgrind 2.2.0, which is
 the most recent Valgrind release that contains a working Helgrind.

Sorry for the inconvenience.  Let us know if this is a problem for you.
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=1 corefile=no
cutime=1 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=shmt09 stime=1251103610
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
tag=shmt09_valgrind_memory_leak_check stime=1251103610
cmdline=" valgrind -q --leak-check=full --trace-children=yes  shmt09 "
contacts=""
analysis=exit
<<<test_output>>>
shmat1: Invalid argument
shmt09      1  TPASS  :  sbrk, sbrk, shmget, shmat
shmt09      2  TPASS  :  sbrk, shmat
shmt09      3  TFAIL  :  Error: shmat Failed, shmid = 412254212, errno = 22

<<<execution_status>>>
initiation_status="ok"
duration=1 termination_type=exited termination_id=1 corefile=no
cutime=52 cstime=6
<<<test_end>>>
<<<test_start>>>
tag=shmt09_valgrind_thread_concurrency_check stime=1251103611
cmdline=" valgrind -q --tool=helgrind --trace-children=yes  shmt09 "
contacts=""
analysis=exit
<<<test_output>>>

Helgrind is currently not working, because:
 (a) it is not yet ready to handle the Vex IR and the use with 64-bit
     platforms introduced in Valgrind 3.0.0
 (b) we need to get thread operation tracking working again after
     the changes added in Valgrind 2.4.0
 If you want to use Helgrind, you'll have to use Valgrind 2.2.0, which is
 the most recent Valgrind release that contains a working Helgrind.

Sorry for the inconvenience.  Let us know if this is a problem for you.
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=1 corefile=no
cutime=0 cstime=1
<<<test_end>>>
<<<test_start>>>
tag=shmt10 stime=1251103611
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
tag=shmt10_valgrind_memory_leak_check stime=1251103611
cmdline=" valgrind -q --leak-check=full --trace-children=yes  shmt10 "
contacts=""
analysis=exit
<<<test_output>>>
shmt10      1  TPASS  :  shmat,shmdt
<<<execution_status>>>
initiation_status="ok"
duration=1 termination_type=exited termination_id=0 corefile=no
cutime=66 cstime=13
<<<test_end>>>
<<<test_start>>>
tag=shmt10_valgrind_thread_concurrency_check stime=1251103612
cmdline=" valgrind -q --tool=helgrind --trace-children=yes  shmt10 "
contacts=""
analysis=exit
<<<test_output>>>

Helgrind is currently not working, because:
 (a) it is not yet ready to handle the Vex IR and the use with 64-bit
     platforms introduced in Valgrind 3.0.0
 (b) we need to get thread operation tracking working again after
     the changes added in Valgrind 2.4.0
 If you want to use Helgrind, you'll have to use Valgrind 2.2.0, which is
 the most recent Valgrind release that contains a working Helgrind.

Sorry for the inconvenience.  Let us know if this is a problem for you.
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=1 corefile=no
cutime=0 cstime=1
<<<test_end>>>
<<<test_start>>>
tag=shm_test01 stime=1251103612
cmdline="shm_test -l 10 -t 2"
contacts=""
analysis=exit
<<<test_output>>>
pid[11380]: shmat_rd_wr(): shmget():success got segment id 412352516
pid[11380]: do_shmat_shmadt(): got shmat address = 0xb6c7c000
pid[11380]: shmat_rd_wr(): shmget():success got segment id 412352516
pid[11380]: do_shmat_shmadt(): got shmat address = 0xb696a000
pid[11380]: shmat_rd_wr(): shmget():success got segment id 412385285
pid[11380]: do_shmat_shmadt(): got shmat address = 0xb6c7c000
pid[11380]: shmat_rd_wr(): shmget():success got segment id 412385285
pid[11380]: do_shmat_shmadt(): got shmat address = 0xb696a000
pid[11380]: shmat_rd_wr(): shmget():success got segment id 412418052
pid[11380]: do_shmat_shmadt(): got shmat address = 0xb6c7c000
pid[11380]: shmat_rd_wr(): shmget():success got segment id 412418052
pid[11380]: do_shmat_shmadt(): got shmat address = 0xb696a000
pid[11380]: shmat_rd_wr(): shmget():success got segment id 412450821
pid[11380]: do_shmat_shmadt(): got shmat address = 0xb6c7c000
pid[11380]: shmat_rd_wr(): shmget():success got segment id 412450821
pid[11380]: do_shmat_shmadt(): got shmat address = 0xb696a000
pid[11380]: shmat_rd_wr(): shmget():success got segment id 412483588
pid[11380]: do_shmat_shmadt(): got shmat address = 0xb6c7c000
pid[11380]: shmat_rd_wr(): shmget():success got segment id 412483588
pid[11380]: do_shmat_shmadt(): got shmat address = 0xb696a000
pid[11380]: shmat_rd_wr(): shmget():success got segment id 412516357
pid[11380]: do_shmat_shmadt(): got shmat address = 0xb6c7c000
pid[11380]: shmat_rd_wr(): shmget():success got segment id 412516357
pid[11380]: do_shmat_shmadt(): got shmat address = 0xb696a000
pid[11380]: shmat_rd_wr(): shmget():success got segment id 412549124
pid[11380]: do_shmat_shmadt(): got shmat address = 0xb6c7c000
pid[11380]: shmat_rd_wr(): shmget():success got segment id 412549124
pid[11380]: do_shmat_shmadt(): got shmat address = 0xb696a000
pid[11380]: shmat_rd_wr(): shmget():success got segment id 412581893
pid[11380]: do_shmat_shmadt(): got shmat address = 0xb6c7c000
pid[11380]: shmat_rd_wr(): shmget():success got segment id 412581893
pid[11380]: do_shmat_shmadt(): got shmat address = 0xb696a000
pid[11380]: shmat_rd_wr(): shmget():success got segment id 412614660
pid[11380]: do_shmat_shmadt(): got shmat address = 0xb6c7c000
pid[11380]: shmat_rd_wr(): shmget():success got segment id 412614660
pid[11380]: do_shmat_shmadt(): got shmat address = 0xb696a000
pid[11380]: shmat_rd_wr(): shmget():success got segment id 412647429
pid[11380]: do_shmat_shmadt(): got shmat address = 0xb6c7c000
pid[11380]: shmat_rd_wr(): shmget():success got segment id 412647429
pid[11380]: do_shmat_shmadt(): got shmat address = 0xb696a000
<<<execution_status>>>
initiation_status="ok"
duration=137 termination_type=exited termination_id=0 corefile=no
cutime=1744 cstime=25579
<<<test_end>>>
<<<test_start>>>
tag=shm_test01 stime=1251103749
cmdline="shm_test_valgrind_memory_leak_check  valgrind -q --leak-check=full --trace-children=yes  -l  10  -t  2 "
contacts=""
analysis=exit
<<<test_output>>>
<<<execution_status>>>
initiation_status="pan(10502): execvp of 'shm_test_valgrind_memory_leak_check' (tag shm_test01) failed.  errno:2  No such file or directory"
duration=0 termination_type=exited termination_id=2 corefile=no
cutime=0 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=shm_test01 stime=1251103749
cmdline="shm_test_valgrind_thread_concurrency_check  valgrind -q --tool=helgrind --trace-children=yes  -l  10  -t  2 "
contacts=""
analysis=exit
<<<test_output>>>
<<<execution_status>>>
initiation_status="pan(10502): execvp of 'shm_test_valgrind_thread_concurrency_check' (tag shm_test01) failed.  errno:2  No such file or directory"
duration=0 termination_type=exited termination_id=2 corefile=no
cutime=0 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=mallocstress01 stime=1251103749
cmdline="mallocstress"
contacts=""
analysis=exit
<<<test_output>>>
Thread [7]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [31]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [15]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [39]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [35]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [3]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [47]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [19]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [43]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [55]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [27]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [11]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [23]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [51]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [59]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [14]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [58]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [18]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [22]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [46]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [42]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [10]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [34]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [2]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [26]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [30]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [6]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [50]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [54]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [38]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [53]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [1]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [13]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [45]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [33]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [41]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [37]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [5]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [9]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [21]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [29]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [25]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [49]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [57]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [17]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [0]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [24]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [8]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [44]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [20]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [28]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [48]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [52]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [4]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [40]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [12]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [36]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [32]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [16]: allocate_free() returned 0, succeeded.  Thread exiting.
Thread [56]: allocate_free() returned 0, succeeded.  Thread exiting.
main(): test passed.
<<<execution_status>>>
initiation_status="ok"
duration=8 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=831
<<<test_end>>>
<<<test_start>>>
tag=mallocstress01 stime=1251103757
cmdline="mallocstress_valgrind_memory_leak_check  valgrind -q --leak-check=full --trace-children=yes "
contacts=""
analysis=exit
<<<test_output>>>
<<<execution_status>>>
initiation_status="pan(10502): execvp of 'mallocstress_valgrind_memory_leak_check' (tag mallocstress01) failed.  errno:2  No such file or directory"
duration=0 termination_type=exited termination_id=2 corefile=no
cutime=0 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=mallocstress01 stime=1251103757
cmdline="mallocstress_valgrind_thread_concurrency_check  valgrind -q --tool=helgrind --trace-children=yes "
contacts=""
analysis=exit
<<<test_output>>>
<<<execution_status>>>
initiation_status="pan(10502): execvp of 'mallocstress_valgrind_thread_concurrency_check' (tag mallocstress01) failed.  errno:2  No such file or directory"
duration=0 termination_type=exited termination_id=2 corefile=no
cutime=0 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=mmapstress01 stime=1251103757
cmdline="mmapstress01 -p 20 -t 0.2"
contacts=""
analysis=exit
<<<test_output>>>
file data okay
mmapstress01    1  TPASS  :  Test passed
<<<execution_status>>>
initiation_status="ok"
duration=12 termination_type=exited termination_id=0 corefile=no
cutime=1374 cstime=757
<<<test_end>>>
<<<test_start>>>
tag=mmapstress01_valgrind_memory_leak_check stime=1251103769
cmdline=" valgrind -q --leak-check=full --trace-children=yes  mmapstress01  -p  20  -t  0.2 "
contacts=""
analysis=exit
<<<test_output>>>
file data okay
mmapstress01    1  TPASS  :  Test passed
==22149== 
==22149== 4,096 bytes in 1 blocks are definitely lost in loss record 3 of 4
==22149==    at 0x40053C0: malloc (vg_replace_malloc.c:149)
==22149==    by 0x80493A6: fileokay (mmapstress01.c:648)
==22149==    by 0x804A1B5: main (mmapstress01.c:434)
<<<execution_status>>>
initiation_status="ok"
duration=13 termination_type=exited termination_id=0 corefile=no
cutime=2214 cstime=254
<<<test_end>>>
<<<test_start>>>
tag=mmapstress01_valgrind_thread_concurrency_check stime=1251103782
cmdline=" valgrind -q --tool=helgrind --trace-children=yes  mmapstress01  -p  20  -t  0.2 "
contacts=""
analysis=exit
<<<test_output>>>

Helgrind is currently not working, because:
 (a) it is not yet ready to handle the Vex IR and the use with 64-bit
     platforms introduced in Valgrind 3.0.0
 (b) we need to get thread operation tracking working again after
     the changes added in Valgrind 2.4.0
 If you want to use Helgrind, you'll have to use Valgrind 2.2.0, which is
 the most recent Valgrind release that contains a working Helgrind.

Sorry for the inconvenience.  Let us know if this is a problem for you.
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=1 corefile=no
cutime=0 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=mmapstress02 stime=1251103782
cmdline="mmapstress02"
contacts=""
analysis=exit
<<<test_output>>>
mmapstress02    1  TPASS  :  Test passed

<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=1
<<<test_end>>>
<<<test_start>>>
tag=mmapstress02_valgrind_memory_leak_check stime=1251103782
cmdline=" valgrind -q --leak-check=full --trace-children=yes  mmapstress02 "
contacts=""
analysis=exit
<<<test_output>>>
mmapstress02    1  TPASS  :  Test passed

<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=53 cstime=6
<<<test_end>>>
<<<test_start>>>
tag=mmapstress02_valgrind_thread_concurrency_check stime=1251103782
cmdline=" valgrind -q --tool=helgrind --trace-children=yes  mmapstress02 "
contacts=""
analysis=exit
<<<test_output>>>

Helgrind is currently not working, because:
 (a) it is not yet ready to handle the Vex IR and the use with 64-bit
     platforms introduced in Valgrind 3.0.0
 (b) we need to get thread operation tracking working again after
     the changes added in Valgrind 2.4.0
 If you want to use Helgrind, you'll have to use Valgrind 2.2.0, which is
 the most recent Valgrind release that contains a working Helgrind.

Sorry for the inconvenience.  Let us know if this is a problem for you.
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=1 corefile=no
cutime=0 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=mmapstress03 stime=1251103782
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
tag=mmapstress03_valgrind_memory_leak_check stime=1251103782
cmdline=" valgrind -q --leak-check=full --trace-children=yes  mmapstress03 "
contacts=""
analysis=exit
<<<test_output>>>

valgrind: m_syswrap/syswrap-generic.c:1004 (do_brk): Assertion 'aseg' failed.
==22293==    at 0x38016499: report_and_quit (m_libcassert.c:136)
==22293==    by 0x380167C3: vgPlain_assert_fail (m_libcassert.c:200)
==22293==    by 0x3804419C: vgSysWrap_generic_sys_brk_before (syswrap-generic.c:1004)
==22293==    by 0x3804BAEF: vgPlain_client_syscall (syswrap-main.c:719)
==22293==    by 0x380381D9: vgPlain_scheduler (scheduler.c:721)
==22293==    by 0x38057103: run_a_thread_NORETURN (syswrap-linux.c:87)

sched status:
  running_tid=1

Thread 1: status = VgTs_Runnable
==22293==    at 0xA5A770: brk (in /lib/libc-2.5.so)
==22293==    by 0xA5A80C: sbrk (in /lib/libc-2.5.so)
==22293==    by 0x8048F3E: main (mmapstress03.c:156)


Note: see also the FAQ.txt in the source distribution.
It contains workarounds to several common problems.

If that doesn't help, please report this bug to: www.valgrind.org

In the bug report, send all the above text, the valgrind
version, and what Linux distro you are using.  Thanks.

<<<execution_status>>>
initiation_status="ok"
duration=1 termination_type=exited termination_id=1 corefile=no
cutime=34 cstime=6
<<<test_end>>>
<<<test_start>>>
tag=mmapstress03_valgrind_thread_concurrency_check stime=1251103783
cmdline=" valgrind -q --tool=helgrind --trace-children=yes  mmapstress03 "
contacts=""
analysis=exit
<<<test_output>>>

Helgrind is currently not working, because:
 (a) it is not yet ready to handle the Vex IR and the use with 64-bit
     platforms introduced in Valgrind 3.0.0
 (b) we need to get thread operation tracking working again after
     the changes added in Valgrind 2.4.0
 If you want to use Helgrind, you'll have to use Valgrind 2.2.0, which is
 the most recent Valgrind release that contains a working Helgrind.

Sorry for the inconvenience.  Let us know if this is a problem for you.
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=1 corefile=no
cutime=0 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=mmapstress04 stime=1251103783
cmdline="TMPFILE=`mktemp /tmp/example.XXXXXXXXXX`; ls -lR /usr/include/ > $TMPFILE; mmapstress04 $TMPFILE"
contacts=""
analysis=exit
<<<test_output>>>
mmapstress04    1  TPASS  :  Test passed

<<<execution_status>>>
initiation_status="ok"
duration=8 termination_type=exited termination_id=0 corefile=no
cutime=29 cstime=199
<<<test_end>>>
<<<test_start>>>
tag=mmapstress04_valgrind_memory_leak_check stime=1251103791
cmdline=" valgrind -q --leak-check=full --trace-children=yes  TMPFILE=`mktemp  /tmp/example.XXXXXXXXXX`;  ls  -lR  /usr/include/  >  $TMPFILE;  mmapstress04  $TMPFILE "
contacts=""
analysis=exit
<<<test_output>>>
valgrind: TMPFILE=/tmp/example.xcsCt22302: No such file or directory
sh: $TMPFILE: ambiguous redirect
Usage: mmapstress04 filename startoffset
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=1 corefile=no
cutime=0 cstime=1
<<<test_end>>>
<<<test_start>>>
tag=mmapstress04_valgrind_thread_concurrency_check stime=1251103791
cmdline=" valgrind -q --tool=helgrind --trace-children=yes  TMPFILE=`mktemp  /tmp/example.XXXXXXXXXX`;  ls  -lR  /usr/include/  >  $TMPFILE;  mmapstress04  $TMPFILE "
contacts=""
analysis=exit
<<<test_output>>>
valgrind: TMPFILE=/tmp/example.WPTZq22308: No such file or directory
sh: $TMPFILE: ambiguous redirect
Usage: mmapstress04 filename startoffset
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=1 corefile=no
cutime=1 cstime=1
<<<test_end>>>
<<<test_start>>>
tag=mmapstress05 stime=1251103791
cmdline="mmapstress05"
contacts=""
analysis=exit
<<<test_output>>>
mmapstress05    1  TPASS  :  Test passed

<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=1
<<<test_end>>>
<<<test_start>>>
tag=mmapstress05_valgrind_memory_leak_check stime=1251103791
cmdline=" valgrind -q --leak-check=full --trace-children=yes  mmapstress05 "
contacts=""
analysis=exit
<<<test_output>>>
mmapstress05    1  TPASS  :  Test passed

<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=53 cstime=6
<<<test_end>>>
<<<test_start>>>
tag=mmapstress05_valgrind_thread_concurrency_check stime=1251103791
cmdline=" valgrind -q --tool=helgrind --trace-children=yes  mmapstress05 "
contacts=""
analysis=exit
<<<test_output>>>

Helgrind is currently not working, because:
 (a) it is not yet ready to handle the Vex IR and the use with 64-bit
     platforms introduced in Valgrind 3.0.0
 (b) we need to get thread operation tracking working again after
     the changes added in Valgrind 2.4.0
 If you want to use Helgrind, you'll have to use Valgrind 2.2.0, which is
 the most recent Valgrind release that contains a working Helgrind.

Sorry for the inconvenience.  Let us know if this is a problem for you.
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=1 corefile=no
cutime=0 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=mmapstress06 stime=1251103791
cmdline="mmapstress06 20"
contacts=""
analysis=exit
<<<test_output>>>
mmapstress06    1  TPASS  :  Test passed

<<<execution_status>>>
initiation_status="ok"
duration=20 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=1
<<<test_end>>>
<<<test_start>>>
tag=mmapstress06_valgrind_memory_leak_check stime=1251103811
cmdline=" valgrind -q --leak-check=full --trace-children=yes  mmapstress06  20 "
contacts=""
analysis=exit
<<<test_output>>>
mmapstress06    1  TPASS  :  Test passed

<<<execution_status>>>
initiation_status="ok"
duration=21 termination_type=exited termination_id=0 corefile=no
cutime=48 cstime=6
<<<test_end>>>
<<<test_start>>>
tag=mmapstress06_valgrind_thread_concurrency_check stime=1251103832
cmdline=" valgrind -q --tool=helgrind --trace-children=yes  mmapstress06  20 "
contacts=""
analysis=exit
<<<test_output>>>

Helgrind is currently not working, because:
 (a) it is not yet ready to handle the Vex IR and the use with 64-bit
     platforms introduced in Valgrind 3.0.0
 (b) we need to get thread operation tracking working again after
     the changes added in Valgrind 2.4.0
 If you want to use Helgrind, you'll have to use Valgrind 2.2.0, which is
 the most recent Valgrind release that contains a working Helgrind.

Sorry for the inconvenience.  Let us know if this is a problem for you.
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=1 corefile=no
cutime=0 cstime=1
<<<test_end>>>
<<<test_start>>>
tag=mmapstress07 stime=1251103832
cmdline="TMPFILE=`mktemp /tmp/example.XXXXXXXXXXXX`; mmapstress07 $TMPFILE"
contacts=""
analysis=exit
<<<test_output>>>
mmapstress07    1  TPASS  :  Test passed

<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=2 cstime=20
<<<test_end>>>
<<<test_start>>>
tag=mmapstress07_valgrind_memory_leak_check stime=1251103832
cmdline=" valgrind -q --leak-check=full --trace-children=yes  TMPFILE=`mktemp  /tmp/example.XXXXXXXXXXXX`;  mmapstress07  $TMPFILE "
contacts=""
analysis=exit
<<<test_output>>>
valgrind: TMPFILE=/tmp/example.AYtLaKr22343: No such file or directory
Usage: mmapstress07 filename holesize e_pageskip sparseoff
	*holesize should be a multiple of pagesize
	*e_pageskip should be 1 always 
	*sparseoff should be a multiple of pagesize
Example: mmapstress07 myfile 4096 1 8192
mmapstress07    1  TFAIL  :  Test failed

mmapstress07    0  TWARN  :  tst_rmdir(): TESTDIR was NULL; no removal attempted
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=5 corefile=no
cutime=0 cstime=2
<<<test_end>>>
<<<test_start>>>
tag=mmapstress07_valgrind_thread_concurrency_check stime=1251103832
cmdline=" valgrind -q --tool=helgrind --trace-children=yes  TMPFILE=`mktemp  /tmp/example.XXXXXXXXXXXX`;  mmapstress07  $TMPFILE "
contacts=""
analysis=exit
<<<test_output>>>
valgrind: TMPFILE=/tmp/example.jJEyRPt22348: No such file or directory
Usage: mmapstress07 filename holesize e_pageskip sparseoff
	*holesize should be a multiple of pagesize
	*e_pageskip should be 1 always 
	*sparseoff should be a multiple of pagesize
Example: mmapstress07 myfile 4096 1 8192
mmapstress07    1  TFAIL  :  Test failed

mmapstress07    0  TWARN  :  tst_rmdir(): TESTDIR was NULL; no removal attempted
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=5 corefile=no
cutime=0 cstime=1
<<<test_end>>>
<<<test_start>>>
tag=mmapstress08 stime=1251103832
cmdline="mmapstress08"
contacts=""
analysis=exit
<<<test_output>>>
mmapstress08    1  TPASS  :  Test passed

<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=mmapstress08_valgrind_memory_leak_check stime=1251103832
cmdline=" valgrind -q --leak-check=full --trace-children=yes  mmapstress08 "
contacts=""
analysis=exit
<<<test_output>>>
==22352== Warning: client syscall munmap tried to modify addresses 0x804F000-0x3FFFFFFF
mmapstress08: errno = 22: munmap failed
mmapstress08    1  TFAIL  :  Test failed

<<<execution_status>>>
initiation_status="ok"
duration=1 termination_type=exited termination_id=1 corefile=no
cutime=47 cstime=8
<<<test_end>>>
<<<test_start>>>
tag=mmapstress08_valgrind_thread_concurrency_check stime=1251103833
cmdline=" valgrind -q --tool=helgrind --trace-children=yes  mmapstress08 "
contacts=""
analysis=exit
<<<test_output>>>

Helgrind is currently not working, because:
 (a) it is not yet ready to handle the Vex IR and the use with 64-bit
     platforms introduced in Valgrind 3.0.0
 (b) we need to get thread operation tracking working again after
     the changes added in Valgrind 2.4.0
 If you want to use Helgrind, you'll have to use Valgrind 2.2.0, which is
 the most recent Valgrind release that contains a working Helgrind.

Sorry for the inconvenience.  Let us know if this is a problem for you.
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=1 corefile=no
cutime=1 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=mmapstress09 stime=1251103833
cmdline="mmapstress09 -p 20 -t 0.2"
contacts=""
analysis=exit
<<<test_output>>>
map data okay
mmapstress09    1  TPASS  :  Test passed

<<<execution_status>>>
initiation_status="ok"
duration=12 termination_type=exited termination_id=0 corefile=no
cutime=1424 cstime=731
<<<test_end>>>
<<<test_start>>>
tag=mmapstress09_valgrind_memory_leak_check stime=1251103845
cmdline=" valgrind -q --leak-check=full --trace-children=yes  mmapstress09  -p  20  -t  0.2 "
contacts=""
analysis=exit
<<<test_output>>>
map data okay
mmapstress09    1  TPASS  :  Test passed

<<<execution_status>>>
initiation_status="ok"
duration=13 termination_type=exited termination_id=0 corefile=no
cutime=2387 cstime=268
<<<test_end>>>
<<<test_start>>>
tag=mmapstress09_valgrind_thread_concurrency_check stime=1251103858
cmdline=" valgrind -q --tool=helgrind --trace-children=yes  mmapstress09  -p  20  -t  0.2 "
contacts=""
analysis=exit
<<<test_output>>>

Helgrind is currently not working, because:
 (a) it is not yet ready to handle the Vex IR and the use with 64-bit
     platforms introduced in Valgrind 3.0.0
 (b) we need to get thread operation tracking working again after
     the changes added in Valgrind 2.4.0
 If you want to use Helgrind, you'll have to use Valgrind 2.2.0, which is
 the most recent Valgrind release that contains a working Helgrind.

Sorry for the inconvenience.  Let us know if this is a problem for you.
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=1 corefile=no
cutime=0 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=mmapstress10 stime=1251103858
cmdline="mmapstress10 -p 20 -t 0.2"
contacts=""
analysis=exit
<<<test_output>>>
file data okay
mmapstress10    1  TPASS  :  Test passed

<<<execution_status>>>
initiation_status="ok"
duration=12 termination_type=exited termination_id=0 corefile=no
cutime=992 cstime=1117
<<<test_end>>>
<<<test_start>>>
tag=mmapstress10_valgrind_memory_leak_check stime=1251103870
cmdline=" valgrind -q --leak-check=full --trace-children=yes  mmapstress10  -p  20  -t  0.2 "
contacts=""
analysis=exit
<<<test_output>>>
file data okay
mmapstress10    1  TPASS  :  Test passed

==15259== 
==15259== 4,096 bytes in 1 blocks are definitely lost in loss record 3 of 4
==15259==    at 0x40053C0: malloc (vg_replace_malloc.c:149)
==15259==    by 0x8049415: fileokay (mmapstress10.c:804)
==15259==    by 0x804A4DC: main (mmapstress10.c:494)
<<<execution_status>>>
initiation_status="ok"
duration=13 termination_type=exited termination_id=0 corefile=no
cutime=2196 cstime=268
<<<test_end>>>
<<<test_start>>>
tag=mmapstress10_valgrind_thread_concurrency_check stime=1251103883
cmdline=" valgrind -q --tool=helgrind --trace-children=yes  mmapstress10  -p  20  -t  0.2 "
contacts=""
analysis=exit
<<<test_output>>>

Helgrind is currently not working, because:
 (a) it is not yet ready to handle the Vex IR and the use with 64-bit
     platforms introduced in Valgrind 3.0.0
 (b) we need to get thread operation tracking working again after
     the changes added in Valgrind 2.4.0
 If you want to use Helgrind, you'll have to use Valgrind 2.2.0, which is
 the most recent Valgrind release that contains a working Helgrind.

Sorry for the inconvenience.  Let us know if this is a problem for you.
incrementing stop
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=1 corefile=no
cutime=0 cstime=0
<<<test_end>>>
====================================================


====================================================
# ./runltp -f nptl -o ltp_nptl_test_general
====================================================
<<<test_start>>>
tag=nptl01 stime=1251103885
cmdline="nptl01"
contacts=""
analysis=exit
<<<test_output>>>
nptl01      0  TINFO  :  Starting test, please wait.
nptl01      0  TINFO  :  Success thru loop 10000 of 100000
nptl01      0  TINFO  :  Success thru loop 20000 of 100000
nptl01      0  TINFO  :  Success thru loop 30000 of 100000
nptl01      0  TINFO  :  Success thru loop 40000 of 100000
nptl01      0  TINFO  :  Success thru loop 50000 of 100000
nptl01      0  TINFO  :  Success thru loop 60000 of 100000
nptl01      0  TINFO  :  Success thru loop 70000 of 100000
nptl01      0  TINFO  :  Success thru loop 80000 of 100000
nptl01      0  TINFO  :  Success thru loop 90000 of 100000
nptl01      1  TPASS  :  Test completed successfully!
incrementing stop
<<<execution_status>>>
initiation_status="ok"
duration=3 termination_type=exited termination_id=0 corefile=no
cutime=51 cstime=352
<<<test_end>>>
<<<test_start>>>
tag=nptl01 stime=1251108222
cmdline="nptl01"
contacts=""
analysis=exit
<<<test_output>>>
nptl01      0  TINFO  :  Starting test, please wait.
nptl01      0  TINFO  :  Success thru loop 10000 of 100000
nptl01      0  TINFO  :  Success thru loop 20000 of 100000
nptl01      0  TINFO  :  Success thru loop 30000 of 100000
nptl01      0  TINFO  :  Success thru loop 40000 of 100000
nptl01      0  TINFO  :  Success thru loop 50000 of 100000
nptl01      0  TINFO  :  Success thru loop 60000 of 100000
nptl01      0  TINFO  :  Success thru loop 70000 of 100000
nptl01      0  TINFO  :  Success thru loop 80000 of 100000
nptl01      0  TINFO  :  Success thru loop 90000 of 100000
nptl01      1  TPASS  :  Test completed successfully!
incrementing stop
<<<execution_status>>>
initiation_status="ok"
duration=3 termination_type=exited termination_id=0 corefile=no
cutime=71 cstime=314
<<<test_end>>>
====================================================


====================================================
# ./runltp -f nptl -M 2-o ltp_nptl_test_thread_concurrency_check
====================================================
<<<test_start>>>
tag=nptl01 stime=1251108226
cmdline="nptl01"
contacts=""
analysis=exit
<<<test_output>>>
nptl01      0  TINFO  :  Starting test, please wait.
nptl01      0  TINFO  :  Success thru loop 10000 of 100000
nptl01      0  TINFO  :  Success thru loop 20000 of 100000
nptl01      0  TINFO  :  Success thru loop 30000 of 100000
nptl01      0  TINFO  :  Success thru loop 40000 of 100000
nptl01      0  TINFO  :  Success thru loop 50000 of 100000
nptl01      0  TINFO  :  Success thru loop 60000 of 100000
nptl01      0  TINFO  :  Success thru loop 70000 of 100000
nptl01      0  TINFO  :  Success thru loop 80000 of 100000
nptl01      0  TINFO  :  Success thru loop 90000 of 100000
nptl01      1  TPASS  :  Test completed successfully!
<<<execution_status>>>
initiation_status="ok"
duration=3 termination_type=exited termination_id=0 corefile=no
cutime=72 cstime=320
<<<test_end>>>
<<<test_start>>>
tag=nptl01_valgrind_thread_concurrency_check stime=1251108229
cmdline=" valgrind -q --tool=helgrind --trace-children=yes  nptl01 "
contacts=""
analysis=exit
<<<test_output>>>

Helgrind is currently not working, because:
 (a) it is not yet ready to handle the Vex IR and the use with 64-bit
     platforms introduced in Valgrind 3.0.0
 (b) we need to get thread operation tracking working again after
     the changes added in Valgrind 2.4.0
 If you want to use Helgrind, you'll have to use Valgrind 2.2.0, which is
 the most recent Valgrind release that contains a working Helgrind.

Sorry for the inconvenience.  Let us know if this is a problem for you.
incrementing stop
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=1 corefile=no
cutime=0 cstime=1
<<<test_end>>>
====================================================


====================================================
# ./runltp -f nptl -M 3-o ltp_nptl_test_thread_concurrency_check-and-memory_leak_checks
====================================================
<<<test_start>>>
tag=nptl01 stime=1251108229
cmdline="nptl01"
contacts=""
analysis=exit
<<<test_output>>>
nptl01      0  TINFO  :  Starting test, please wait.
nptl01      0  TINFO  :  Success thru loop 10000 of 100000
nptl01      0  TINFO  :  Success thru loop 20000 of 100000
nptl01      0  TINFO  :  Success thru loop 30000 of 100000
nptl01      0  TINFO  :  Success thru loop 40000 of 100000
nptl01      0  TINFO  :  Success thru loop 50000 of 100000
nptl01      0  TINFO  :  Success thru loop 60000 of 100000
nptl01      0  TINFO  :  Success thru loop 70000 of 100000
nptl01      0  TINFO  :  Success thru loop 80000 of 100000
nptl01      0  TINFO  :  Success thru loop 90000 of 100000
nptl01      1  TPASS  :  Test completed successfully!
<<<execution_status>>>
initiation_status="ok"
duration=4 termination_type=exited termination_id=0 corefile=no
cutime=49 cstime=315
<<<test_end>>>
<<<test_start>>>
tag=nptl01_valgrind_memory_leak_check stime=1251108233
cmdline=" valgrind -q --leak-check=full --trace-children=yes  nptl01 "
contacts=""
analysis=exit
<<<test_output>>>
nptl01      0  TINFO  :  Starting test, please wait.
nptl01      0  TINFO  :  Success thru loop 10000 of 100000
nptl01      0  TINFO  :  Success thru loop 20000 of 100000
nptl01      0  TINFO  :  Success thru loop 30000 of 100000
nptl01      0  TINFO  :  Success thru loop 40000 of 100000
nptl01      0  TINFO  :  Success thru loop 50000 of 100000
nptl01      0  TINFO  :  Success thru loop 60000 of 100000
nptl01      0  TINFO  :  Success thru loop 70000 of 100000
nptl01      0  TINFO  :  Success thru loop 80000 of 100000
nptl01      0  TINFO  :  Success thru loop 90000 of 100000
nptl01      1  TPASS  :  Test completed successfully!
==18312== 
==18312== 136 bytes in 1 blocks are possibly lost in loss record 1 of 1
==18312==    at 0x40046FF: calloc (vg_replace_malloc.c:279)
==18312==    by 0x97ED49: _dl_allocate_tls (in /lib/ld-2.5.so)
==18312==    by 0xB0BB92: pthread_create@@GLIBC_2.1 (in /lib/libpthread-2.5.so)
==18312==    by 0x8048DDC: create_child_thread (nptl01.c:196)
==18312==    by 0x80494AD: main (nptl01.c:246)
<<<execution_status>>>
initiation_status="ok"
duration=29 termination_type=exited termination_id=0 corefile=no
cutime=1220 cstime=2049
<<<test_end>>>
<<<test_start>>>
tag=nptl01_valgrind_thread_concurrency_check stime=1251108262
cmdline=" valgrind -q --tool=helgrind --trace-children=yes  nptl01 "
contacts=""
analysis=exit
<<<test_output>>>

Helgrind is currently not working, because:
 (a) it is not yet ready to handle the Vex IR and the use with 64-bit
     platforms introduced in Valgrind 3.0.0
 (b) we need to get thread operation tracking working again after
     the changes added in Valgrind 2.4.0
 If you want to use Helgrind, you'll have to use Valgrind 2.2.0, which is
 the most recent Valgrind release that contains a working Helgrind.

Sorry for the inconvenience.  Let us know if this is a problem for you.
incrementing stop
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=1 corefile=no
cutime=0 cstime=0
<<<test_end>>>
====================================================

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
