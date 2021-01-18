From: Alexander Egorenkov <egorenar@linux.ibm.com>
Date: Mon, 18 Jan 2021 15:04:34 +0100
Subject: [LTP] [PATCH 1/1] swapping01: make test more robust
In-Reply-To: <CAEemH2fDzPp3D6KZ_G0UDbS=eh2tWDAcy7CTt_4Yw7FUT4zGxg@mail.gmail.com>
References: <20210115143246.369676-1-egorenar@linux.ibm.com>
 <CAEemH2fDzPp3D6KZ_G0UDbS=eh2tWDAcy7CTt_4Yw7FUT4zGxg@mail.gmail.com>
Message-ID: <87lfcqjq8d.fsf@oc8242746057.ibm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Li Wang <liwang@redhat.com> writes:

>
> Looking at the memory status from the output, it only detects available
> memory 7318MB in the fourth time (< 7348MB, second/third time).
> But memory heavy swapped in the third and fourth time(7323MB, 7322MB
> swapped).
>
> Obviously, the last two tests influenced by the first-three running.
>
> How reproducible of this FAIL? And, Could you help verify whether the
> following cleanup works?
> (Also, provide /proc/meminfo or kernel version will help to locate the
> issues).
>
> --- a/testcases/kernel/mem/swapping/swapping01.c
> +++ b/testcases/kernel/mem/swapping/swapping01.c
> @@ -81,6 +81,7 @@ static void test_swapping(void)
>
>  static void init_meminfo(void)
>  {
> +       SAFE_FILE_PRINTF("/proc/sys/vm/drop_caches", "3");
>         swap_free_init = SAFE_READ_MEMINFO("SwapFree:");
>         if (FILE_LINES_SCANF("/proc/meminfo", "MemAvailable: %ld",
>                 &mem_available_init)) {
>

Thanks for looking into it.
I usually need no more than 100 iterations to reproduce a FAIL, but on
our CI system it frequently fails immediately, that's why i started
tweaking the test.

Output from today's CI:
      tst_test.c:1248: TINFO: Timeout per run is 0h 05m 00s
      swapping01.c:106: TINFO: available physical memory: 5472 MB
      swapping01.c:109: TINFO: try to allocate: 7114 MB
      swapping01.c:112: TINFO: memory allocated: 7114 MB
      swapping01.c:143: TFAIL: heavy swapping detected: 5502 MB swapped.

      Summary:
      passed   0
      failed   1
      skipped  0
      warnings 0


With my "fix"" i couldn't reproduce the problem even with more than 1000
iterations but i admit my "fix"" was a lucky shot :(


cat /proc/meminfo

MemTotal:        8172412 kB
MemFree:           87304 kB
MemAvailable:      95244 kB
Buffers:            1392 kB
Cached:            31792 kB
SwapCached:         2052 kB
Active:            21244 kB
Inactive:        6587284 kB
Active(anon):       2956 kB
Inactive(anon):  6581060 kB
Active(file):      18288 kB
Inactive(file):     6224 kB
Unevictable:       19624 kB
Mlocked:           19624 kB
SwapTotal:      25720840 kB
SwapFree:       25531728 kB
Dirty:               136 kB
Writeback:             0 kB
AnonPages:       6596012 kB
Mapped:            31976 kB
Shmem:                16 kB
KReclaimable:     117076 kB
Slab:             284640 kB
SReclaimable:     117076 kB
SUnreclaim:       167564 kB
KernelStack:       10160 kB
PageTables:        17900 kB
NFS_Unstable:          0 kB
Bounce:                0 kB
WritebackTmp:          0 kB
CommitLimit:    29807044 kB
Committed_AS:    9102816 kB
VmallocTotal:   534773760 kB
VmallocUsed:      171424 kB
VmallocChunk:          0 kB
Percpu:           261120 kB
AnonHugePages:   3451904 kB
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
Hugepagesize:       1024 kB
Hugetlb:               0 kB
DirectMap4k:        6144 kB
DirectMap1M:     2091008 kB
DirectMap2G:     6291456 kB

kernel version:
5.11.0-20210118.rc3.git0.b3a3cbdec55b


I'm going to test your patch today extensively and then report back.

Regards
Alex
