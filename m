From: Li Wang <liwang@redhat.com>
Date: Mon, 16 Nov 2015 14:00:52 +0800
Subject: [LTP] [PATCH] futex: skip futex_wake04.c if system not support
 huge pages
In-Reply-To: <20151116050627.GA15996@home.allenx.org>
References: <1447576860-9189-1-git-send-email-liwang@redhat.com>
 <20151116050627.GA15996@home.allenx.org>
Message-ID: <CAEemH2ezRDHhyNGHQgzBdMmihB_AXZ91PVcx+21u=9HGnqo9vg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

On Mon, Nov 16, 2015 at 1:06 PM, Wanlong Gao <wanlong.gao@gmail.com> wrote:

> On Sun, Nov 15, 2015 at 04:41:00PM +0800, Li Wang wrote:
> > Testcase fails on system which not support hugepages:
> >
> > futex_wake04    1  TBROK  :  safe_file_ops.c:155: The FILE
> '/proc/sys/vm/nr_hugepages' ended prematurely at futex_wake04.c:74
> > futex_wake04    2  TBROK  :  safe_file_ops.c:155: Remaining cases broken
> >
> > Skip the testcase cases with TCONF rather than failing with TBROK.
> >
> > Signed-off-by: Li Wang <liwang@redhat.com>
> > ---
> >  testcases/kernel/syscalls/futex/futex_wake04.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/testcases/kernel/syscalls/futex/futex_wake04.c
> b/testcases/kernel/syscalls/futex/futex_wake04.c
> > index dcefde8..2d6bd4c 100644
> > --- a/testcases/kernel/syscalls/futex/futex_wake04.c
> > +++ b/testcases/kernel/syscalls/futex/futex_wake04.c
> > @@ -50,6 +50,7 @@
> >
> >  #define PATH_MEMINFO "/proc/meminfo"
> >  #define PATH_NR_HUGEPAGES "/proc/sys/vm/nr_hugepages"
> > +#define PATH_SYS_HUGEPAGES "/sys/kernel/mm/hugepages/"
>
> Why not use the original "/proc/sys/vm/nr_hugepages" to check the hugetlb
> support but add a new one ?
>

In my test system, there exist file "/proc/sys/vm/nr_hugepages" with normal
permission, but reject any R/W operation.

So, if I use   if (access(PATH_NR_HUGEPAGES, F_OK) == -1),  It doesn't work.

# ll /proc/sys/vm/nr_hugepages
-rw-r--r--. 1 root root 0 Nov 15 09:03 /proc/sys/vm/nr_hugepages

# cat /proc/sys/vm/nr_hugepages
cat: write error: Bad address

# cat /proc/meminfo
MemTotal:        8663296 kB
MemFree:         6637056 kB
MemAvailable:    8151744 kB
Buffers:            4160 kB
Cached:          1504192 kB
SwapCached:            0 kB
Active:           946816 kB
Inactive:         788480 kB
Active(anon):     230592 kB
Inactive(anon):     9472 kB
Active(file):     716224 kB
Inactive(file):   779008 kB
Unevictable:           0 kB
Mlocked:               0 kB
SwapTotal:       4652992 kB
SwapFree:        4652992 kB
Dirty:                 0 kB
Writeback:             0 kB
AnonPages:        226944 kB
Mapped:            51456 kB
Shmem:             13120 kB
Slab:             188032 kB
SReclaimable:      63232 kB
SUnreclaim:       124800 kB
KernelStack:        2944 kB
PageTables:         2176 kB
NFS_Unstable:          0 kB
Bounce:                0 kB
WritebackTmp:          0 kB
CommitLimit:     8984640 kB
Committed_AS:     464064 kB
VmallocTotal:   8589934592 kB
VmallocUsed:       53056 kB
VmallocChunk:   8589850624 kB
HardwareCorrupted:     0 kB
AnonHugePages:         0 kB


-- 
Regards,
Li Wang
Email: liwang@redhat.com
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20151116/60c4716c/attachment.html>
