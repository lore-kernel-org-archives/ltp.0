From: Alexander Egorenkov <egorenar@linux.ibm.com>
Date: Wed, 20 Jan 2021 08:25:09 +0100
Subject: [LTP] [PATCH 1/1] swapping01: make test more robust
In-Reply-To: <CAEemH2fDzPp3D6KZ_G0UDbS=eh2tWDAcy7CTt_4Yw7FUT4zGxg@mail.gmail.com>
References: <20210115143246.369676-1-egorenar@linux.ibm.com>
 <CAEemH2fDzPp3D6KZ_G0UDbS=eh2tWDAcy7CTt_4Yw7FUT4zGxg@mail.gmail.com>
Message-ID: <87zh14rrxm.fsf@oc8242746057.ibm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Li Wang <liwang@redhat.com> writes:

> Hi Alexander,
>
> Alexander Egorenkov <egorenar@linux.ibm.com> wrote:
>
>> ...
>> swapping01.c:106: TINFO: available physical memory:* 7348 MB*
>> swapping01.c:109: TINFO: try to allocate: 9552 MB
>> swapping01.c:112: TINFO: memory allocated: 9552 MB
>> swapping01.c:140: TINFO: swap free init: 25019 MB
>> swapping01.c:141: TINFO: swap free now: 20484 MB
>> swapping01.c:149: TPASS: no heavy swapping detected, *4534 MB swapped.*
>> ...
>> swapping01.c:106: TINFO: available physical memory:* 7318 MB*
>> swapping01.c:109: TINFO: try to allocate: 9514 MB
>> swapping01.c:112: TINFO: memory allocated: 9514 MB
>> swapping01.c:140: TINFO: swap free init: 25019 MB
>> swapping01.c:141: TINFO: swap free now: 17697 MB
>> swapping01.c:145: TFAIL: heavy swapping detected:* 7322 MB swapped.*
>>
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
> -- 
> Regards,
> Li Wang
>
>     This Message Is From an External Sender         
>     This message came from outside your organization.         
> Hi Alexander,
>
> Alexander Egorenkov <egorenar@linux.ibm.com> wrote:
>
>  ...
>  swapping01.c:106: TINFO: available physical memory: 7348 MB
>  swapping01.c:109: TINFO: try to allocate: 9552 MB
>  swapping01.c:112: TINFO: memory allocated: 9552 MB
>  swapping01.c:140: TINFO: swap free init: 25019 MB
>  swapping01.c:141: TINFO: swap free now: 20484 MB
>  swapping01.c:149: TPASS: no heavy swapping detected, 4534 MB swapped.
>  ...
>  swapping01.c:106: TINFO: available physical memory: 7318 MB
>  swapping01.c:109: TINFO: try to allocate: 9514 MB
>  swapping01.c:112: TINFO: memory allocated: 9514 MB
>  swapping01.c:140: TINFO: swap free init: 25019 MB
>  swapping01.c:141: TINFO: swap free now: 17697 MB
>  swapping01.c:145: TFAIL: heavy swapping detected: 7322 MB swapped.
>
> Looking at the memory status from the output, it only detects available
> memory 7318MB in the fourth time (< 7348MB, second/third time).
> But memory heavy swapped in the third and fourth time(7323MB, 7322MB swapped).
>
> Obviously, the last two tests influenced by the first-three running. 
>
> How reproducible of this FAIL? And, Could you help verify whether the following cleanup works?
> (Also, provide /proc/meminfo or kernel version will help to locate the issues).
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
> -- 
> Regards,
> Li Wang


Hi,

i did more tests as promised.
Your patch didn't help :( Still seeing failures.

With your patch:
----------------
swapping01.c:148: TPASS: no heavy swapping detected, 7282 MB swapped.
swapping01.c:107: TINFO: available physical memory: 7303 MB
swapping01.c:110: TINFO: try to allocate: 9494 MB
swapping01.c:113: TINFO: memory allocated: 9494 MB
swapping01.c:148: TPASS: no heavy swapping detected, 6204 MB swapped.
swapping01.c:107: TINFO: available physical memory: 7299 MB
swapping01.c:110: TINFO: try to allocate: 9488 MB
swapping01.c:113: TINFO: memory allocated: 9488 MB
swapping01.c:144: TFAIL: heavy swapping detected: 9490 MB swapped.

Summary:
passed   27
failed   1
skipped  0
warnings 0


W/O your patch:
---------------
swapping01.c:147: TPASS: no heavy swapping detected, 2229 MB swapped.
swapping01.c:106: TINFO: available physical memory: 7311 MB
swapping01.c:109: TINFO: try to allocate: 9504 MB
swapping01.c:112: TINFO: memory allocated: 9504 MB
swapping01.c:147: TPASS: no heavy swapping detected, 2249 MB swapped.
swapping01.c:106: TINFO: available physical memory: 7306 MB
swapping01.c:109: TINFO: try to allocate: 9498 MB
swapping01.c:112: TINFO: memory allocated: 9498 MB
swapping01.c:143: TFAIL: heavy swapping detected: 9496 MB swapped.

Summary:
passed   23
failed   1
skipped  0
warnings 0



I can easily reproduce the problem inside an LPAR with 8GB RAM and 20GB
swap. But could *NOT* reproduce it inside a zVM w/o any patches, might be
fluke or some other unknown factors probably.

My patch seems to work very well, couldn't reproduce the problem with it
applied :/ 




cat /proc/meminfo
MemTotal:        8167132 kB
MemFree:         7379376 kB
MemAvailable:    7396252 kB
Buffers:           14952 kB
Cached:            55280 kB
SwapCached:         3772 kB
Active:            42584 kB
Inactive:          58776 kB
Active(anon):       2872 kB
Inactive(anon):    36224 kB
Active(file):      39712 kB
Inactive(file):    22552 kB
Unevictable:       19248 kB
Mlocked:           19248 kB
SwapTotal:      25053176 kB
SwapFree:       24916556 kB
Dirty:                16 kB
Writeback:             0 kB
AnonPages:         48352 kB
Mapped:            33416 kB
Shmem:                16 kB
KReclaimable:      78404 kB
Slab:             195456 kB
SReclaimable:      78404 kB
SUnreclaim:       117052 kB
KernelStack:       12576 kB
PageTables:         4612 kB
NFS_Unstable:          0 kB
Bounce:                0 kB
WritebackTmp:          0 kB
CommitLimit:    29136740 kB
Committed_AS:    1004504 kB
VmallocTotal:   534773760 kB
VmallocUsed:      171464 kB
VmallocChunk:          0 kB
Percpu:           167200 kB
AnonHugePages:     11264 kB
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
DirectMap4k:        5120 kB
DirectMap1M:     4189184 kB
DirectMap2G:     4194304 kB


uname -a
Fedora 33, 5.11.0-20210118.rc3.git0.0bf60767445f.300.fc33.s390x

Regards
Alex
