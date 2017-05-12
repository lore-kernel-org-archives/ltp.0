From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 12 May 2017 19:54:41 +0530
Subject: [LTP] LTP: readahead02 failed
Message-ID: <CA+G9fYvHus+AB1CD4AGxw3pOAKavO=gQ0W2zfPSZ-qkUac9U-w@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Team,

readahead02 failed on HiKey board with below error message.
1. Any minimal limitation of Buffers size or Cached size should have
to pass this test case ?  if yes we would change test logic to detect
and skip test run.
2. The first FAIL message is not giving enough information (*) there
is a room for improvement here.
3.  strace output show Invalid argument for readahead()

readahead(3, 0, 67108864)               = -1 EINVAL (Invalid argument)
write(1, "readahead02    1  TFAIL  :  read"..., 100readahead02    1
TFAIL  :  readahead02.c:86: unexpected failure - returned value = -1,
expected: 0
) = 100

The man page have explanation of EINVAL is
EINVAL fd  does  not  refer  to a file type to which readahead() can be applied.

Test output:
-----------------
readahead02    0  TINFO  :  creating test file of size: 67108864
readahead02    0  TINFO  :  read_testfile(0)
readahead02    0  TINFO  :  read_testfile(1)
readahead02    1  TFAIL  :  readahead02.c:86: unexpected failure -
returned value = -1, expected: 0 (*)
readahead02    0  TINFO  :  readahead calls made: 0
readahead02    2  TPASS  :  offset is still at 0 as expected
readahead02    0  TINFO  :  read_testfile(0) took: 124831 usec
readahead02    0  TINFO  :  read_testfile(1) took: 124712 usec
readahead02    0  TINFO  :  read_testfile(0) read: 0 bytes
readahead02    0  TINFO  :  read_testfile(1) read: 0 bytes
readahead02    3  TFAIL  :  readahead02.c:333: readahead failed to save any I/O
readahead02    0  TINFO  :  cache can hold at least: 19068 kB
readahead02    0  TINFO  :  read_testfile(0) used cache: 0 kB
readahead02    0  TINFO  :  read_testfile(1) used cache: 0 kB
readahead02    4  TCONF  :  readahead02.c:354: Page cache on your
system is too small to hold whole testfile.

Meminfo
------------
root@hikey:~# cat /proc/meminfo
MemTotal:        1922076 kB
MemFree:         1736568 kB
MemAvailable:    1780900 kB
Buffers:            5272 kB
Cached:            92676 kB
SwapCached:            0 kB
Active:            30416 kB
Inactive:          83260 kB
Active(anon):      16244 kB
Inactive(anon):     8348 kB
Active(file):      14172 kB
Inactive(file):    74912 kB
Unevictable:           0 kB
Mlocked:               0 kB
SwapTotal:             0 kB
SwapFree:              0 kB
Dirty:                84 kB
Writeback:             0 kB
AnonPages:         15832 kB
Mapped:            21860 kB
Shmem:              8828 kB
Slab:              45048 kB
SReclaimable:      23132 kB
SUnreclaim:        21916 kB
KernelStack:        3056 kB
PageTables:          660 kB
NFS_Unstable:          0 kB
Bounce:                0 kB
WritebackTmp:          0 kB
CommitLimit:      961036 kB
Committed_AS:     153972 kB
VmallocTotal:   258867136 kB
VmallocUsed:           0 kB
VmallocChunk:          0 kB
AnonHugePages:      6144 kB
CmaTotal:          65536 kB
CmaFree:           59036 kB
HugePages_Total:       0
HugePages_Free:        0
HugePages_Rsvd:        0
HugePages_Surp:        0
Hugepagesize:       2048 kB

Linux kernel Version:
----------------------------
Linux Version is 4.11.0-next-20170512, #1 SMP PREEMPT Fri May 12
03:26:58 UTC 2017

Thank you.

Best regards
Naresh Kamboju
