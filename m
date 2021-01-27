From: liuxp11@chinatelecom.cn <liuxp11@chinatelecom.cn>
Date: Wed, 27 Jan 2021 18:04:35 +0800
Subject: [LTP] [PATCH 1/2] syscalls/ioctl: ioctl_sg01.c: ioctl_sg01
 invoked oom-killer
References: <1611570288-23040-1-git-send-email-liuxp11@chinatelecom.cn>, 
 <YBE03REJywKIlM0X@yuki.lan>
Message-ID: <2021012718043566596022@chinatelecom.cn>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

[root@test-env-nm05-compute-14e5e72e38 ~]# cat /proc/meminfo
MemTotal:       526997420 kB
MemFree:        520224908 kB
MemAvailable:   519936744 kB
Buffers:               0 kB
Cached:          2509036 kB
SwapCached:            0 kB
Active:           906868 kB
Inactive:        2398084 kB
Active(anon):     816396 kB
Inactive(anon):    77236 kB
Active(file):      90472 kB
Inactive(file):  2320848 kB
Unevictable:      610056 kB
Mlocked:          610056 kB
SwapTotal:             0 kB
SwapFree:              0 kB
Dirty:                 0 kB
Writeback:             0 kB
AnonPages:       1406336 kB
Mapped:           118628 kB
Shmem:             84400 kB
KReclaimable:     193752 kB
Slab:             703668 kB
SReclaimable:     193752 kB
SUnreclaim:       509916 kB
KernelStack:       12672 kB
PageTables:        14056 kB
NFS_Unstable:          0 kB
Bounce:                0 kB
WritebackTmp:          0 kB
CommitLimit:    263498708 kB
Committed_AS:   10263760 kB
VmallocTotal:   34359738367 kB
VmallocUsed:      651756 kB
VmallocChunk:          0 kB
Percpu:            62464 kB
HardwareCorrupted:    88 kB
AnonHugePages:         0 kB
ShmemHugePages:        0 kB
ShmemPmdMapped:        0 kB
FileHugePages:         0 kB
FilePmdMapped:         0 kB
CmaTotal:              0 kB
CmaFree:               0 kB
HugePages_Total:       0
HugePages_Free:        0
HugePages_Rsvd:        0
HugePages_Surp:        0
Hugepagesize:       2048 kB
Hugetlb:               0 kB
DirectMap4k:     1371808 kB
DirectMap2M:    49661952 kB
DirectMap1G:    486539264 kB

[root@test-env-nm05-compute-14e5e72e38 ~]# cat  /proc/sys/vm/min_free_kbytes
90112




 
From: Cyril Hrubis
Date: 2021-01-27 17:39
To: Xinpeng Liu
CC: ltp
Subject: Re: [LTP] [PATCH 1/2] syscalls/ioctl: ioctl_sg01.c: ioctl_sg01 invoked oom-killer
Hi!
> MemTotal:       198101744 kB
> MemFree:        189303148 kB
> MemAvailable:   188566732 kB
 
This sounds really strange, usually MemFree is smaller than MemAvailable
since MemFree does not include page cache.
 
Is this freshly booted system?
 
Can you send the whole meminfo here please?
 
-- 
Cyril Hrubis
chrubis@suse.cz
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210127/d67a18b3/attachment.htm>
