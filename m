From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 14 Jan 2021 16:42:04 +0530
Subject: [LTP] Holidays and LTP release
In-Reply-To: <20210113095724.214c904a@kmaincent-XPS-13-7390>
References: <X9tMlNxJbwCWIRnO@yuki.lan> <X/Wq28noppvB5MGw@yuki.lan>
 <20210113095724.214c904a@kmaincent-XPS-13-7390>
Message-ID: <CA+G9fYv1UFr+7ePC7tLjCY4JPsoQdBdf-6Jpr40zmsoYRWVrdQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, 13 Jan 2021 at 14:27, K?ry Maincent <kory.maincent@bootlin.com> wrote:
>
> Hello Cyril,
>
> On Wed, 6 Jan 2021 13:19:39 +0100
> Cyril Hrubis <chrubis@suse.cz> wrote:
>
> > Hi!
> > As you may noticed I'm back and I'm trying to review anything that
> > should be considered for the release.
> >
> > Please let me know if there is anything I should look into.
>
> I don't know if this can be useful before the release but I have made a table of
> the result of my LTP test. The test was run on an iMX8 Quad with OpenEmbedded
> distribution composed of Busybox and Dropbear.

I have a similar problem for semctl09 failed on arm, arm64, i386 and x86_64.

semctl09.c:67: TINFO: Test SYS_semc[ 1067.769270] audit: type=1701
audit(1610604534.411:38): auid=4294967295 uid=0 gid=0 ses=4294967295
pid=6275 comm=\"semctl09\" exe=\"/opt/ltp/testcases/bin/semctl09\"
sig=11 res=1
tl syscall
semctl09.c:132: TINFO: Test SEM_STAT_ANY with nobody user
semctl09.c:155: TPASS: SEM_INFO returned valid index 10 to semid 10
semctl09.c:164: TPASS: Counted used = 1
semctl09.c:112: TPASS: semset_cnt = 1
semctl09.c:119: TPASS: sen_cnt = 2
tst_test.c:1313: TBROK: Test killed by SIGSEGV!

And on i386,

tst_test.c:1263: TINFO: Timeout per run is 0h 15m 00s
semctl09.c:67: TINFO: Test SYS_semctl syscall
semctl09.c:132: TINFO: Test SEM_STAT_ANY with nobody user
semctl09.c:155: TPASS: SEM_INFO returned valid index 11 to semid 11
semctl09.c:164: TPASS: Counted used = 1
semctl09.c:112: TPASS: semset_cnt = 1
semctl09.c:119: TPASS: sen_cnt = 2
semctl09.c:132: TINFO: Test SEM_STAT_ANY with root user
semctl09.c:155: TPASS: SEM_INFO returned valid index 11 to semid 11
semctl09.c:164: TPASS: Counted used = 1
semctl09.c:112: TPASS: semset_cnt = 1
semctl09.c:119: TPASS: sen_cnt = 2
tst_test.c:1263: TINFO: Timeout per run is 0h 15m 00s
semctl09.c:70: TINFO: Test libc semctl()
semctl09.c:132: TINFO: Test SEM_STAT_ANY with nobody user
semctl09.c:149: TFAIL: SEM_STAT_ANY doesn't pass the buffer specified
by the caller to kernel
semctl09.c:132: TINFO: Test SEM_STAT_ANY with root user
semctl09.c:149: TFAIL: SEM_STAT_ANY doesn't pass the buffer specified
by the caller to kernel


only fails on the arm beagleboard-x15 device.

accept02.c:55: TBROK: setsockopt(3, 0, 42, 0xb6f4cf7c, 132) failed: ENODEV (19)

clock_gettime04.c:143: TFAIL: CLOCK_REALTIME: Time travelled backwards
(5): -1610153174499293029 ns
clock_gettime04.c:151: TFAIL: CLOCK_REALTIME_COARSE: Difference
between successive readings greater than 5 ms (4): 9
clock_gettime04.c:158: TPASS: CLOCK_MONOTONIC: Difference between
successive readings is reasonable
clock_gettime04.c:151: TFAIL: CLOCK_MONOTONIC_COARSE: Difference
between successive readings greater than 5 ms (2): 9
clock_gettime04.c:158: TPASS: CLOCK_MONOTONIC_RAW: Difference between
successive readings is reasonable
clock_gettime04.c:158: TPASS: CLOCK_BOOTTIME: Difference between
successive readings is reasonable

getrlimit03.c:168: TPASS: __NR_prlimit64(0) and __NR_ugetrlimit(0)
gave consistent results
tst_test.c:1313: TBROK: Test killed by SIGILL!


on x86_64:
The ioctl_sg01 test killed and reported failed.

tst_test.c:1263: TINFO: Timeout per run is 0h 15m 00s
ioctl_sg01.c:81: TINFO: Found SCSI device /dev/sg1
[  332.383394] ioctl_sg01 invoked oom-killer:
gfp_mask=0x100cca(GFP_HIGHUSER_MOVABLE), order=0, oom_score_adj=0
[  332.393225] CPU: 0 PID: 14622 Comm: ioctl_sg01 Not tainted 5.10.6 #2
[  332.399572] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
2.0b 07/27/2017
[  332.407080] Call Trace:
[  332.409543]  dump_stack+0x7d/0x9f
[  332.412861]  dump_header+0x4f/0x1f3
[  332.416351]  oom_kill_process.cold+0xb/0x10
[  332.420531]  out_of_memory+0x1bb/0x4e0
[  332.424283]  __alloc_pages_slowpath.constprop.0+0xc39/0xd00
[  332.429847]  __alloc_pages_nodemask+0x2a9/0x310
[  332.434379]  alloc_pages_current+0x87/0xe0
[  332.438470]  __page_cache_alloc+0x89/0xb0
[  332.442482]  pagecache_get_page+0xe3/0x280
[  332.446572]  filemap_fault+0x5b1/0xc90
[  332.450316]  ? page_add_file_rmap+0x16c/0x1d0
[  332.454666]  ? alloc_set_pte+0xf2/0x670
[  332.458498]  __do_fault+0x3c/0xa0
[  332.461808]  handle_mm_fault+0xf73/0x1610
[  332.465812]  ? finish_task_switch+0x74/0x230
[  332.470098]  do_user_addr_fault+0x1dc/0x3c0
[  332.474278]  exc_page_fault+0x54/0x110
[  332.478023]  ? asm_exc_page_fault+0x8/0x30
[  332.482112]  asm_exc_page_fault+0x1e/0x30
[  332.486116] RIP: 0033:0x7f7405231130
[  332.489691] Code: Unable to access opcode bytes at RIP 0x7f7405231106.
[  332.496214] RSP: 002b:00007fff9e9afe28 EFLAGS: 00010202
[  332.501430] RAX: 00007f7030e69000 RBX: 0000000000000001 RCX: 00007f7403e69000
[  332.508553] RDX: 0000000000000000 RSI: 0000000001000000 RDI: 00007f7403e69000
[  332.515677] RBP: 00007f7403e69000 R08: 0000000001000000 R09: 0000000000000000
[  332.522801] R10: 0000000000000022 R11: 0000000000000246 R12: 0000000001000000
[  332.529926] R13: 000000000041861a R14: 000000000000003b R15: 0000000000000000
[  332.537092] Mem-Info:
[  332.539376] active_anon:144 inactive_anon:4026083 isolated_anon:0
[  332.539376]  active_file:63 inactive_file:8 isolated_file:0
[  332.539376]  unevictable:0 dirty:33 writeback:0
[  332.539376]  slab_reclaimable:4320 slab_unreclaimable:6040
[  332.539376]  mapped:136 shmem:6370 pagetables:8672 bounce:0
[  332.539376]  free:34555 free_pcp:20 free_cma:0
[  332.570972] Node 0 active_anon:576kB inactive_anon:16104332kB
active_file:180kB inactive_file:4kB unevictable:0kB isolated(anon):0kB
isolated(file):0kB mapped:544kB dirty:132kB writeback:0kB
shmem:25480kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 0kB
writeback_tmp:0kB kernel_stack:2400kB all_unreclaimable? yes
[  332.598731] Node 0 DMA free:15868kB min:64kB low:80kB high:96kB
reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB
active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB
present:15964kB managed:15868kB mlocked:0kB pagetables:0kB bounce:0kB
free_pcp:0kB local_pcp:0kB free_cma:0kB
[  332.625036] lowmem_reserve[]: 0 2173 15940 15940
[  332.629729] Node 0 DMA32 free:64224kB min:9204kB low:11504kB
high:13804kB reserved_highatomic:0KB active_anon:0kB
inactive_anon:2156620kB active_file:0kB inactive_file:0kB
unevictable:0kB writepending:0kB present:2291100kB managed:2225564kB
mlocked:0kB pagetables:4216kB bounce:0kB free_pcp:0kB local_pcp:0kB
free_cma:0kB
[  332.658024] lowmem_reserve[]: 0 0 13766 13766
[  332.662375] Node 0 Normal free:58128kB min:58312kB low:72888kB
high:87464kB reserved_highatomic:0KB active_anon:576kB
inactive_anon:13947404kB active_file:744kB inactive_file:0kB
unevictable:0kB writepending:76kB present:14417920kB
managed:14101104kB mlocked:0kB pagetables:30472kB bounce:0kB
free_pcp:16kB local_pcp:0kB free_cma:0kB
[  332.691695] lowmem_reserve[]: 0 0 0 0
[  332.695361] Node 0 DMA: 1*4kB (U) 1*8kB (U) 1*16kB (U) 1*32kB (U)
1*64kB (U) 1*128kB (U) 1*256kB (U) 0*512kB 1*1024kB (U) 1*2048kB (M)
3*4096kB (M) = 15868kB
[  332.709435] Node 0 DMA32: 2*4kB (UM) 3*8kB (UM) 3*16kB (UM) 2*32kB
(UM) 1*64kB (M) 2*128kB (UM) 1*256kB (M) 1*512kB (U) 0*1024kB 1*2048kB
(M) 15*4096kB (M) = 64720kB
[  332.724210] Node 0 Normal: 784*4kB (UME) 409*8kB (UME) 183*16kB
(UME) 67*32kB (UME) 38*64kB (E) 36*128kB (ME) 28*256kB (ME) 12*512kB
(ME) 4*1024kB (E) 1*2048kB (E) 5*4096kB (U) = 58456kB
[  332.740807] Node 0 hugepages_total=0 hugepages_free=0
hugepages_surp=0 hugepages_size=2048kB
[  332.749257] 6513 total pagecache pages
[  332.753001] 0 pages in swap cache
[  332.756338] Swap cache stats: add 0, delete 0, find 0/0
[  332.761563] Free swap  = 0kB
[  332.764441] Total swap = 0kB
[  332.767316] 4181246 pages RAM
[  332.770306] 0 pages HighMem/MovableOnly
[  332.774137] 95612 pages reserved
[  332.777363] Tasks state (memory values in pages):
[  332.782079] [  pid  ]   uid  tgid total_vm      rss pgtables_bytes
swapents oom_score_adj name
[  332.790713] [    333]     0   333    12626      164   114688
0             0 systemd-journal
[  332.799749] [    348]     0   348    10499      275   114688
0         -1000 systemd-udevd
[  332.808615] [    372]   993   372     8666       79   114688
0             0 systemd-network
[  332.817652] [    384]   992   384     9529       77   122880
0             0 systemd-resolve
[  332.826686] [    387]   996   387     7243      154   106496
0          -900 dbus-daemon
[  332.835375] [    388]     0   388     2313       71    61440
0             0 crond
[  332.843564] [    389]     0   389     2112       19    57344
0             0 syslogd
[  332.851904] [    391]     0   391     3029      783    65536
0             0 haveged
[  332.860250] [    392]     0   392    81271      490   262144
0             0 NetworkManager
[  332.869229] [    393]     0   393     2112       20    61440
0             0 klogd
[  332.877402] [    395]     0   395     8615      107   110592
0             0 systemd-logind
[  332.886353] [    396]     0   396     1075       22    57344
0             0 acpid
[  332.894525] [    398]     0   398    34025      158   167936
0             0 thermald
[  332.902956] [    399]   995   399     9341       81   114688
0             0 avahi-daemon
[  332.911728] [    409]   995   409     9277       68   106496
0             0 avahi-daemon
[  332.920505] [    438] 65534   438     3245       38    65536
0             0 dnsmasq
[  332.928870] [    439]     0   439     3187       33    69632
0             0 agetty
[  332.937130] [    440]     0   440    14707      108   163840
0             0 login
[  332.945328] [    441]     0   441     3187       34    69632
0             0 agetty
[  332.953588] [    444]   998   444   131113      827   241664
0             0 polkitd
[  332.961932] [    461]     0   461     9532      162   118784
0             0 systemd
[  332.970270] [    462]     0   462    16166      462   163840
0             0 (sd-pam)
[  332.978719] [    466]     0   466     4538      104    77824
0             0 sh
[  332.986632] [    471]     0   471    11102       83   135168
0             0 su
[  332.994544] [    472]     0   472     4538      100    77824
0             0 sh
[  333.002455] [    517]     0   517     2396       56    61440
0             0 lava-test-runne
[  333.011487] [    527]     0   527     2396       52    65536
0             0 lava-test-shell
[  333.020525] [    528]     0   528     2396       55    69632
0             0 sh
[  333.028455] [    530]     0   530     2495      169    65536
0             0 ltp.sh
[  333.036707] [    553]     0   553     2495      169    61440
0             0 ltp.sh
[  333.044965] [    554]     0   554     2495      169    61440
0             0 ltp.sh
[  333.053224] [    555]     0   555     2495      169    61440
0             0 ltp.sh
[  333.061473] [    556]     0   556     2561      224    69632
0             0 runltp
[  333.069725] [    557]     0   557     1072       15    53248
0             0 tee
[  333.077725] [    623]     0   623     1103       66    61440
0             0 ltp-pan
[  333.086069] [  14595]     0 14595     3187       34    73728
0             0 agetty
[  333.094347] [  14621]     0 14621     1198       16    49152
0             0 ioctl_sg01
[  333.102951] [  14622]     0 14622  4015311  4014104 32231424
0             0 ioctl_sg01
[  333.111548] oom-kill:constraint=CONSTRAINT_NONE,nodemask=(null),cpuset=/,mems_allowed=0,global_oom,task_memcg=/,task=ioctl_sg01,pid=14622,uid=0
[  333.124428] Out of memory: Killed process 14622 (ioctl_sg01)
total-vm:16061244kB, anon-rss:16056416kB, file-rss:0kB, shmem-rss:0kB,
UID:0 pgtables:31476kB oom_score_adj:0
[  333.374806] oom_reaper: reaped process 14622 (ioctl_sg01), now
anon-rss:0kB, file-rss:0kB, shmem-rss:0kB
tst_test.c:1308: TINFO: If you are running on slow machine, try
exporting LTP_TIMEOUT_MUL > 1
tst_test.c:1309: TBROK: Test killed! (timeout?)


ksm03 and ksm03_1 both failed due to,

tst_device.c:423: TINFO: No device is mounted at /tmp/cgroup_mem
tst_cgroup.c:122: TINFO: Cgroup v2 mount at /tmp/cgroup_mem success
tst_cgroup.c:301: TBROK: Failed to close FILE
'/tmp/cgroup_mem/cgroup.subtree_control': ENOENT (2)

> https://drive.google.com/drive/folders/1fyBOCjwc_3JiJ3MmMZcWh-m_VVZIDlxv?usp=sharing


- Naresh
