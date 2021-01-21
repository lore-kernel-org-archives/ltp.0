From: Li Wang <liwang@redhat.com>
Date: Thu, 21 Jan 2021 17:44:16 +0800
Subject: [LTP] [PATCH 1/1] swapping01: make test more robust
In-Reply-To: <YAgmPjaf8iRn20x2@pevik>
References: <20210115143246.369676-1-egorenar@linux.ibm.com>
 <CAEemH2fDzPp3D6KZ_G0UDbS=eh2tWDAcy7CTt_4Yw7FUT4zGxg@mail.gmail.com>
 <87zh14rrxm.fsf@oc8242746057.ibm.com> <YAgmPjaf8iRn20x2@pevik>
Message-ID: <CAEemH2cseOGtSem9vhChygLNeYz6E0bVEu+u-UH8agLBoHJo4Q@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,

Thanks for your debugging.

On Wed, Jan 20, 2021 at 8:47 PM Petr Vorel <pvorel@suse.cz> wrote:

> Hi Alexander, Li,
>
> First I found quite hard to have correct setup to avoid TCONF "Not enough
> swap
> space to test". It often requires to add additional swap file via mkswap
> && swapon
> and use some RAM with:
>
> dd if=/dev/zero of=/dev/shm/fill bs=1k count=14024k
>
> It'd be great if test could do required setup itself.
> And it'd also help at least to print swap_free_init and mem_over_max in
> that TCONF:
>
>         if (swap_free_init < mem_over_max)
> -               tst_brk(TCONF, "Not enough swap space to test.");
> +               tst_brk(TCONF, "Not enough swap space to test (%ld <
> %ld)", swap_free_init, mem_over_max);
>
>
> I tried to debug swapping01 on s390x (without this patch) with using
> additional
> swap and eat RAM with dd. and got bus error (core dumped). Is that due too
> aggressive memory eating? I'm not able to crash it on intel arch.
>

I think it is the correct behavior on your system, noticed that you tried
with almost 14G(1k*14024k) on /dev/shm, but the MemFree is only
3218768 kB on your system. Since the size of /dev/shm is limited by
excess RAM, so that couldn't provide such a huge ramdisk for your test
and get SIGBUS eventually.

(you can have a look the size of /dev/shm/fill is far less than 14G, I
believe)


>
> # strace ./swapping01
> execve("./swapping01", ["./swapping01"], 0x3ffdd9fdd30 /* 163 vars */) = 0
> brk(NULL)                               = 0x18ce000
> mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
> 0x3ffb41fc000
> access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or
> directory)
> openat(AT_FDCWD, "/etc/ld.so.cache", O_RDONLY|O_CLOEXEC) = 3
> fstat(3, {st_mode=S_IFREG|0644, st_size=51982, ...}) = 0
> mmap(NULL, 51982, PROT_READ, MAP_PRIVATE, 3, 0) = 0x3ffb4100000
> close(3)                                = 0
> openat(AT_FDCWD, "/lib64/libpthread.so.0", O_RDONLY|O_CLOEXEC) = 3
> read(3,
> "\177ELF\2\2\1\0\0\0\0\0\0\0\0\0\0\3\0\26\0\0\0\1\0\0\0\0\0\0\205\370"...,
> 832) = 832
> fstat(3, {st_mode=S_IFREG|0755, st_size=160168, ...}) = 0
> mmap(NULL, 143720, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) =
> 0x3ffb4080000
> mprotect(0x3ffb409d000, 4096, PROT_NONE) = 0
> mmap(0x3ffb409e000, 8192, PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1d000) = 0x3ffb409e000
> mmap(0x3ffb40a0000, 12648, PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x3ffb40a0000
> close(3)                                = 0
> openat(AT_FDCWD, "/lib64/libc.so.6", O_RDONLY|O_CLOEXEC) = 3
> read(3,
> "\177ELF\2\2\1\3\0\0\0\0\0\0\0\0\0\3\0\26\0\0\0\1\0\0\0\0\0\2\263\250"...,
> 832) = 832
> fstat(3, {st_mode=S_IFREG|0755, st_size=2012560, ...}) = 0
> mmap(NULL, 1765032, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0)
> = 0x3ffb3e80000
> mprotect(0x3ffb4025000, 4096, PROT_NONE) = 0
> mmap(0x3ffb4026000, 24576, PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1a5000) = 0x3ffb4026000
> mmap(0x3ffb402c000, 11944, PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x3ffb402c000
> close(3)                                = 0
> mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
> 0x3ffb41fa000
> mprotect(0x3ffb4026000, 12288, PROT_READ) = 0
> mprotect(0x3ffb409e000, 4096, PROT_READ) = 0
> mprotect(0x1025000, 4096, PROT_READ)    = 0
> mprotect(0x3ffb41a7000, 4096, PROT_READ) = 0
> munmap(0x3ffb4100000, 51982)            = 0
> set_tid_address(0x3ffb41fb060)          = 124658
> set_robust_list(0x3ffb41fb070, 24)      = 0
> rt_sigaction(SIGRTMIN, {sa_handler=0x3ffb4088050, sa_mask=[],
> sa_flags=SA_SIGINFO}, NULL, 8) = 0
> rt_sigaction(SIGRT_1, {sa_handler=0x3ffb4088108, sa_mask=[],
> sa_flags=SA_RESTART|SA_SIGINFO}, NULL, 8) = 0
> rt_sigprocmask(SIG_UNBLOCK, [RTMIN RT_1], NULL, 8) = 0
> prlimit64(0, RLIMIT_STACK, NULL, {rlim_cur=8192*1024,
> rlim_max=RLIM64_INFINITY}) = 0
> getpid()                                = 124658
> geteuid()                               = 0
> openat(AT_FDCWD, "/sys/devices/system/cpu/online", O_RDONLY|O_CLOEXEC) = 3
> read(3, "0-1\n", 8192)                  = 4
> close(3)                                = 0
> access("/dev/shm", F_OK)                = 0
> getpid()                                = 124658
> openat(AT_FDCWD, "/dev/shm/ltp_swapping01_124658", O_RDWR|O_CREAT|O_EXCL,
> 0600) = 3
> chmod("/dev/shm/ltp_swapping01_124658", 0666) = 0
> ftruncate(3, 4096)                      = 0
> mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_SHARED, 3, 0) = 0x3ffb4100000
> unlink("/dev/shm/ltp_swapping01_124658") = 0
> close(3)                                = 0
> rt_sigaction(SIGALRM, {sa_handler=0x1005a88, sa_mask=[ALRM],
> sa_flags=SA_RESTART}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 8) = 0
> rt_sigaction(SIGUSR1, {sa_handler=0x1005910, sa_mask=[USR1],
> sa_flags=SA_RESTART}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 8) = 0
> --- SIGBUS {si_signo=SIGBUS, si_code=BUS_ADRERR, si_addr=0x3ffb4100000} ---
> +++ killed by SIGBUS (core dumped) +++
> Bus error (core dumped)
>
> $ cat /proc/meminfo
> MemTotal:       12300520 kB
> MemFree:         3218768 kB
> MemAvailable:    5748908 kB
> Buffers:            6956 kB
> Cached:          8756848 kB
> SwapCached:            0 kB
> Active:          6651856 kB
> Inactive:        2152212 kB
> Active(anon):    6198384 kB
> Inactive(anon):    24904 kB
> Active(file):     453472 kB
> Inactive(file):  2127308 kB
> Unevictable:       18292 kB
> Mlocked:           18292 kB
> SwapTotal:       2538488 kB
> SwapFree:        2538488 kB
> Dirty:                16 kB
> Writeback:             0 kB
> AnonPages:         56544 kB
> Mapped:            32840 kB
> Shmem:           6175368 kB
> KReclaimable:     105912 kB
> Slab:             156604 kB
> SReclaimable:     105912 kB
> SUnreclaim:        50692 kB
> KernelStack:        6672 kB
> PageTables:         1976 kB
> NFS_Unstable:          0 kB
> Bounce:                0 kB
> WritebackTmp:          0 kB
> CommitLimit:     8688748 kB
> Committed_AS:    6360300 kB
> VmallocTotal:   132120576 kB
> VmallocUsed:       49520 kB
> VmallocChunk:          0 kB
> Percpu:            67680 kB
> AnonHugePages:     22528 kB
> ShmemHugePages:        0 kB
> ShmemPmdMapped:        0 kB
> CmaTotal:              0 kB
> CmaFree:               0 kB
> HugePages_Total:       0
> HugePages_Free:        0
> HugePages_Rsvd:        0
> HugePages_Surp:        0
> Hugepagesize:       1024 kB
> Hugetlb:               0 kB
> DirectMap4k:        6144 kB
> DirectMap1M:     4188160 kB
> DirectMap2G:     8388608 kB
>
> Kind regards,
> Petr
>
>

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210121/8c2a8e63/attachment-0001.htm>
