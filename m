From: Mason <slash.tmp@free.fr>
Date: Wed, 18 May 2016 18:12:03 +0200
Subject: [LTP] Some tests fail with over-commit disabled
Message-ID: <573C9453.5040503@free.fr>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

On a system with 1.5 GB of memory and no swap:

$ cat /proc/meminfo 
MemTotal:        1555140 kB
MemFree:         1472304 kB
MemAvailable:    1467212 kB
Buffers:               0 kB
Cached:            71080 kB
SwapCached:            0 kB
Active:            10300 kB
Inactive:          61368 kB
Active(anon):      10300 kB
Inactive(anon):    61368 kB
Active(file):          0 kB
Inactive(file):        0 kB
Unevictable:           0 kB
Mlocked:               0 kB
HighTotal:        794624 kB
HighFree:         721836 kB
LowTotal:         760516 kB
LowFree:          750468 kB
SwapTotal:             0 kB
SwapFree:              0 kB
Dirty:                 0 kB
Writeback:             0 kB
AnonPages:           520 kB
Mapped:             1460 kB
Shmem:             71080 kB
Slab:               5264 kB
SReclaimable:       1264 kB
SUnreclaim:         4000 kB
KernelStack:         272 kB
PageTables:           68 kB
NFS_Unstable:          0 kB
Bounce:                0 kB
WritebackTmp:          0 kB
CommitLimit:      777568 kB
Committed_AS:      72764 kB
VmallocTotal:     245760 kB
VmallocUsed:       18708 kB
VmallocChunk:     226272 kB


Some tests PASS when over-commit is enabled, but FAIL when it is disabled.

$ sysctl -w vm.overcommit_memory=0 && msgctl09
vm.overcommit_memory = 0
msgctl09    1  TPASS  :  msgctl09 ran successfully!

$ sysctl -w vm.overcommit_memory=2 && msgctl09
vm.overcommit_memory = 2
Fork failure in the second child of child group 4
Fork failure in the first child of child group 10
msgctl09    1  TFAIL  :  msgctl09.c:203: Child exit status = 1
Fork failure in the first child of child group 14
Fork failure in the second child of child group 15
Fork failure in the first child of child group 3
Fork failure in the second child of child group 2
Fork failure in the second child of child group 8
Fork failure in the second child of child group 7
/tmp$ Fork failure in the first child of child group 6
Fork failure in the first child of child group 11
Fork failure in the first child of child group 9
Fork failure in the first child of child group 12
Fork failure in the first child of child group 1
Fork failure in the first child of child group 0


Raising the overcommit amount doesn't seem to help (much).

$ sysctl -w vm.overcommit_ratio=95
$ grep Commit /proc/meminfo 
CommitLimit:     1477380 kB
Committed_AS:      72764 kB
$ sysctl -w vm.overcommit_memory=2 && msgctl09
vm.overcommit_memory = 2
Fork failure in the second child of child group 9
msgctl09    1  TFAIL  :  msgctl09.c:203: Child exit status = 1
Fork failure in the second child of child group 4
/tmp$ Fork failure in the second child of child group 1
Fork failure in the second child of child group 15
Fork failure in the second child of child group 0
Fork failure in the second child of child group 5
Fork failure in the first child of child group 7


I expected ulimit -s 500 to help, but it doesn't... Not sure why.

$ sysctl -w vm.overcommit_memory=2 && msgctl09
vm.overcommit_memory = 2
Fork failure in the second child of child group 10
Fork failure in the second child of child group 3
Fork failure in the first child of child group 14
Fork failure in the first child of child group 7
Fork failure in the second child of child group 0
Fork failure in the first child of child group 5
Fork failure in the first child of child group 1
Fork failure in the second child of child group 12
Fork failure in the second child of child group 6
Fork failure in the first child of child group 11
Fork failure in the second child of child group 2
msgctl09    1  TFAIL  :  msgctl09.c:203: Child exit status = 1


Does anyone have an idea why fork is failing?

Regards.
