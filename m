From: Jan Stancek <jstancek@redhat.com>
Date: Sat, 30 Nov 2019 16:56:43 -0500 (EST)
Subject: [LTP] 
 =?utf-8?q?=E2=9D=8C_FAIL=3A_Test_report_for_kernel_5=2E3?=
 =?utf-8?q?=2E13-3b5f971=2Ecki_=28stable-queue=29?=
In-Reply-To: <cki.6C6A189643.3T2ZUWEMOI@redhat.com>
References: <cki.6C6A189643.3T2ZUWEMOI@redhat.com>
Message-ID: <1738119916.14437244.1575151003345.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> 
> Hello,
> 
> We ran automated tests on a recent commit from this kernel tree:
> 
>        Kernel repo:
>        git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
>             Commit: 3b5f97139acc - KVM: PPC: Book3S HV: Flush link stack on
>             guest exit to host kernel
> 
> The results of these automated tests are provided below.
> 
>     Overall result: FAILED (see details below)
>              Merge: OK
>            Compile: OK
>              Tests: FAILED
> 
> All kernel binaries, config files, and logs are available for download here:
> 
>   https://artifacts.cki-project.org/pipelines/314344
> 
> One or more kernel tests failed:
> 
>     ppc64le:
>      ? LTP

I suspect kernel bug.

There were couple of 'math' runtest related failures in recent couple days.
In all cases, some data file used by test was missing. Presumably because
binary that generates it crashed.

I managed to reproduce one failure with this CKI build, which I believe
is the same problem.

We crash early during load, before any LTP code runs:

(gdb) r
Starting program: /mnt/testarea/ltp/testcases/bin/genasin

Program received signal SIGBUS, Bus error.
dl_main (phdr=0x10000040, phnum=<optimized out>, user_entry=0x7fffffffe760, auxv=<optimized out>) at rtld.c:1362
1362        switch (ph->p_type)
(gdb) bt
#0  dl_main (phdr=0x10000040, phnum=<optimized out>, user_entry=0x7fffffffe760, auxv=<optimized out>) at rtld.c:1362
#1  0x00007ffff7fcf3c8 in _dl_sysdep_start (start_argptr=<optimized out>, dl_main=0x7ffff7fb37b0 <dl_main>) at ../elf/dl-sysdep.c:253
#2  0x00007ffff7fb1d1c in _dl_start_final (arg=arg@entry=0x7fffffffee20, info=info@entry=0x7fffffffe870) at rtld.c:445
#3  0x00007ffff7fb2f5c in _dl_start (arg=0x7fffffffee20) at rtld.c:537
#4  0x00007ffff7fb14d8 in _start () from /lib64/ld64.so.2
(gdb) f 0
#0  dl_main (phdr=0x10000040, phnum=<optimized out>, user_entry=0x7fffffffe760, auxv=<optimized out>) at rtld.c:1362
1362        switch (ph->p_type)
(gdb) l
1357      /* And it was opened directly.  */
1358      ++main_map->l_direct_opencount;
1359
1360      /* Scan the program header table for the dynamic section.  */
1361      for (ph = phdr; ph < &phdr[phnum]; ++ph)
1362        switch (ph->p_type)
1363          {
1364          case PT_PHDR:
1365            /* Find out the load address.  */
1366            main_map->l_addr = (ElfW(Addr)) phdr - ph->p_vaddr;

(gdb) p ph
$1 = (const Elf64_Phdr *) 0x10000040

(gdb) p *ph
Cannot access memory at address 0x10000040

(gdb) info proc map
process 1110670
Mapped address spaces:

          Start Addr           End Addr       Size     Offset objfile
          0x10000000         0x10010000    0x10000        0x0 /mnt/testarea/ltp/testcases/bin/genasin
          0x10010000         0x10030000    0x20000        0x0 /mnt/testarea/ltp/testcases/bin/genasin
      0x7ffff7f90000     0x7ffff7fb0000    0x20000        0x0 [vdso]
      0x7ffff7fb0000     0x7ffff7fe0000    0x30000        0x0 /usr/lib64/ld-2.30.so
      0x7ffff7fe0000     0x7ffff8000000    0x20000    0x20000 /usr/lib64/ld-2.30.so
      0x7ffffffd0000     0x800000000000    0x30000        0x0 [stack]

(gdb) x/1x 0x10000040
0x10000040:     Cannot access memory at address 0x10000040

# /mnt/testarea/ltp/testcases/bin/genasin
Bus error (core dumped)

However, as soon as I copy that binary somewhere else, it works fine:

# cp /mnt/testarea/ltp/testcases/bin/genasin /tmp
# /tmp/genasin
# echo $?
0

# cp /mnt/testarea/ltp/testcases/bin/genasin /mnt/testarea/ltp/testcases/bin/genasin2
# /mnt/testarea/ltp/testcases/bin/genasin2
# echo $?
0

# /mnt/testarea/ltp/testcases/bin/genasin
Bus error (core dumped)

# diff /mnt/testarea/ltp/testcases/bin/genasin /mnt/testarea/ltp/testcases/bin/genasin2; echo $?
0

# lscpu
Architecture:                    ppc64le
Byte Order:                      Little Endian
CPU(s):                          160
On-line CPU(s) list:             0-159
Thread(s) per core:              4
Core(s) per socket:              20
Socket(s):                       2
NUMA node(s):                    2
Model:                           2.2 (pvr 004e 1202)
Model name:                      POWER9, altivec supported
Frequency boost:                 enabled
CPU max MHz:                     3800.0000
CPU min MHz:                     2166.0000
L1d cache:                       1.3 MiB
L1i cache:                       1.3 MiB
L2 cache:                        10 MiB
L3 cache:                        200 MiB
NUMA node0 CPU(s):               0-79
NUMA node8 CPU(s):               80-159
Vulnerability Itlb multihit:     Not affected
Vulnerability L1tf:              Not affected
Vulnerability Mds:               Not affected
Vulnerability Meltdown:          Mitigation; RFI Flush, L1D private per thread
Vulnerability Spec store bypass: Mitigation; Kernel entry/exit barrier (eieio)
Vulnerability Spectre v1:        Mitigation; __user pointer sanitization, ori31 speculation barrier enabled
Vulnerability Spectre v2:        Mitigation; Indirect branch cache disabled, Software link stack flush
Vulnerability Tsx async abort:   Not affected

