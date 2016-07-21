From: Chunyu Hu <chuhu@redhat.com>
Date: Thu, 21 Jul 2016 06:31:58 -0400 (EDT)
Subject: [LTP] [PATCH] madvise06: wait a bit after madvise() call
In-Reply-To: <578F8CB6.2020602@redhat.com>
References: <8eb6f485a46b9d9fb62eec232bf7bcb2d4cf4215.1468848169.git.jstancek@redhat.com>
 <20160719055844.GA31704@gmail.com>
 <1822250385.6269456.1468911402613.JavaMail.zimbra@redhat.com>
 <20160719085756.GB31704@gmail.com> <578F8CB6.2020602@redhat.com>
Message-ID: <597691787.18542977.1469097118207.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> From: "Jan Stancek" <jstancek@redhat.com>
> To: "Li Wang" <liwang@redhat.com>
> Cc: ltp@lists.linux.it
> Sent: Wednesday, July 20, 2016 10:37:42 PM
> Subject: Re: [LTP] [PATCH] madvise06: wait a bit after madvise() call
> 
> On 07/19/2016 10:57 AM, Li Wang wrote:
> >>
> >> My impression was that kernel bug was consistently reproducible,
> >> if not then let's replace the loop with one bigger sleep.
> > 
> > Sorry, I remember it's not, from what I test on an bad (unfix) kernel.
> > it always report PASS with this patch.
> 
> Attached is a different approach, that watches progress of SwapCached
> from /proc/meminfo and as soon as it sees 128M increase it takes that
> as PASS or gives up after 5 seconds with FAIL.
> 
> GOOD kernel:
> tst_test.c:701: INFO: Timeout per run is 300s
> madvise06.c:98: INFO: SwapCached (before madvise): 53576
> madvise06.c:113: INFO: SwapCached (after madvise): 568080
> madvise06.c:115: PASS: Regression test pass
> 
> BAD kernel:
> # ./madvise06
> tst_test.c:701: INFO: Timeout per run is 300s
> madvise06.c:98: INFO: SwapCached (before madvise): 43712
> madvise06.c:113: INFO: SwapCached (after madvise): 45636
> madvise06.c:117: FAIL: Bug has been reproduced
> 
> If you still have the setup, can you try how reliable is this approach?

I also had a try on my desktop. I copied the file as a.c and compiled it in ltp.
Result is that if the sys is fresh with low Cache, it can pass rightly. But if 
the Cache is before exhausted, it can hit failure, as the thresh_hold is too
large to get there. Just FYI. 

[root@dhcp-chuhu mem]# uname -r
4.7.0-rc3+
 
[root@dhcp-chuhu mem]# cat /proc/meminfo 
MemTotal:        7796148 kB
MemFree:         6637888 kB
MemAvailable:    6589052 kB
Buffers:               0 kB
Cached:           260124 kB
SwapCached:        38096 kB
Active:           725856 kB
Inactive:         252788 kB
Active(anon):     710456 kB
Inactive(anon):   123060 kB
Active(file):      15400 kB
Inactive(file):   129728 kB
Unevictable:          32 kB
Mlocked:              32 kB
SwapTotal:       7995388 kB
SwapFree:        6986700 kB
Dirty:                32 kB
Writeback:             0 kB
AnonPages:        716448 kB
Mapped:            72004 kB
Shmem:            114968 kB
Slab:              78160 kB
SReclaimable:      26956 kB
SUnreclaim:        51204 kB
KernelStack:        7856 kB
PageTables:        25568 kB
NFS_Unstable:          0 kB
Bounce:                0 kB
WritebackTmp:          0 kB
CommitLimit:    11893460 kB
Committed_AS:    4073896 kB
VmallocTotal:   34359738367 kB
VmallocUsed:           0 kB
VmallocChunk:          0 kB
HardwareCorrupted:     0 kB
AnonHugePages:     67584 kB
CmaTotal:              0 kB
CmaFree:               0 kB
HugePages_Total:       0
HugePages_Free:        0
HugePages_Rsvd:        0
HugePages_Surp:        0
Hugepagesize:       2048 kB
DirectMap4k:      139580 kB
DirectMap2M:     8040448 kB
[root@dhcp-chuhu mem]# ./a 
tst_test.c:701: INFO: Timeout per run is 300s
a.c:97: INFO: SwapCached (before madvise): 121032
a.c:112: INFO: SwapCached (after madvise): 123928
a.c:116: FAIL: Bug has been reproduced

Summary:
passed   0
failed   1
skipped  0
warnings 0
[root@dhcp-c

> Regards,
> Jan
> 
> 
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
> 

-- 
Regards,
Chunyu Hu

