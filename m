From: Antoine Tenart <atenart@kernel.org>
Date: Mon, 22 Mar 2021 09:55:50 +0100
Subject: [LTP] [net] 5478fcd0f4:
 BUG:sleeping_function_called_from_invalid_context_at_include/linux/sched/mm.h
In-Reply-To: <20210322083553.GI32426@xsang-OptiPlex-9020>
References: <20210322083553.GI32426@xsang-OptiPlex-9020>
Message-ID: <161640335063.3537.6668586361113979688@kwain.local>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

I only had a quick look at this, but I think the issue should be fixed
with:

diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index e16d54aabd4c..3ae3c20eb64c 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -1378,7 +1378,7 @@ static ssize_t xps_queue_show(struct net_device *dev, unsigned int index,
        nr_ids = dev_maps ? dev_maps->nr_ids :
                 (type == XPS_CPUS ? nr_cpu_ids : dev->num_rx_queues);
 
-       mask = bitmap_zalloc(nr_ids, GFP_KERNEL);
+       mask = bitmap_zalloc(nr_ids, GFP_ATOMIC);
        if (!mask) {
                rcu_read_unlock();
                return -ENOMEM;

I'll run some tests and send a fix.

Antoine

Quoting kernel test robot (2021-03-22 09:35:53)
> 
> FYI, we noticed the following commit (built with gcc-9):
> 
> commit: 5478fcd0f48322e04ae6c173ad3a1959e066dc83 ("net: embed nr_ids in the xps maps")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> 
> 
> in testcase: ltp
> version: ltp-x86_64-14c1f76-1_20210319
> with following parameters:
> 
>         disk: 1HDD
>         fs: xfs
>         test: fs-02
>         ucode: 0xde
> 
> test-description: The LTP testsuite contains a collection of tools for testing the Linux kernel and related features.
> test-url: http://linux-test-project.github.io/
> 
> 
> on test machine: 8 threads Intel(R) Core(TM) i7-7700 CPU @ 3.60GHz with 32G memory
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>
> 
> 
> [  253.104647] BUG: sleeping function called from invalid context at include/linux/sched/mm.h:196
> [  253.113269] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 9371, name: read_all
> [  253.121296] CPU: 1 PID: 9371 Comm: read_all Tainted: G          I       5.12.0-rc2-00796-g5478fcd0f483 #1
> [  253.130887] Hardware name: Dell Inc. OptiPlex 7050/062KRH, BIOS 1.2.0 12/22/2016
> [  253.138288] Call Trace:
> [  253.140734] dump_stack (kbuild/src/consumer/lib/dump_stack.c:122) 
> [  253.144055] ___might_sleep.cold (kbuild/src/consumer/kernel/sched/core.c:8331 kbuild/src/consumer/kernel/sched/core.c:8288) 
> [  253.148161] __kmalloc (kbuild/src/consumer/include/linux/sched/mm.h:196 kbuild/src/consumer/mm/slab.h:497 kbuild/src/consumer/mm/slub.c:2826 kbuild/src/consumer/mm/slub.c:2915 kbuild/src/consumer/mm/slub.c:4051) 
> [  253.151568] ? xps_rxqs_show (kbuild/src/consumer/net/core/net-sysfs.c:1498 (discriminator 2)) 
> [  253.155498] xps_rxqs_show (kbuild/src/consumer/net/core/net-sysfs.c:1498 (discriminator 2)) 
> [  253.159255] sysfs_kf_seq_show (kbuild/src/consumer/fs/sysfs/file.c:62) 
> [  253.163273] seq_read_iter (kbuild/src/consumer/fs/seq_file.c:227) 
> [  253.167030] new_sync_read (kbuild/src/consumer/fs/read_write.c:416 (discriminator 1)) 
> [  253.170787] vfs_read (kbuild/src/consumer/fs/read_write.c:496) 
> [  253.174105] ksys_read (kbuild/src/consumer/fs/read_write.c:634) 
> [  253.177334] do_syscall_64 (kbuild/src/consumer/arch/x86/entry/common.c:46) 
> [  253.180923] entry_SYSCALL_64_after_hwframe (kbuild/src/consumer/arch/x86/entry/entry_64.S:112) 
> [  253.185978] RIP: 0033:0x7fa906c7c50e
> [ 253.189555] Code: 48 8b 15 cd aa 00 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b6 0f 1f 80 00 00 00 00 8b 05 3a ef 00 00 85 c0 75 16 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 5a c3 66 0f 1f 84 00 00 00 00 00 41 54 49 89
> All code
> ========
>    0:   48 8b 15 cd aa 00 00    mov    0xaacd(%rip),%rdx        # 0xaad4
>    7:   f7 d8                   neg    %eax
>    9:   64 89 02                mov    %eax,%fs:(%rdx)
>    c:   48 c7 c0 ff ff ff ff    mov    $0xffffffffffffffff,%rax
>   13:   eb b6                   jmp    0xffffffffffffffcb
>   15:   0f 1f 80 00 00 00 00    nopl   0x0(%rax)
>   1c:   8b 05 3a ef 00 00       mov    0xef3a(%rip),%eax        # 0xef5c
>   22:   85 c0                   test   %eax,%eax
>   24:   75 16                   jne    0x3c
>   26:   31 c0                   xor    %eax,%eax
>   28:   0f 05                   syscall 
>   2a:*  48 3d 00 f0 ff ff       cmp    $0xfffffffffffff000,%rax         <-- trapping instruction
>   30:   77 5a                   ja     0x8c
>   32:   c3                      retq   
>   33:   66 0f 1f 84 00 00 00    nopw   0x0(%rax,%rax,1)
>   3a:   00 00 
>   3c:   41 54                   push   %r12
>   3e:   49                      rex.WB
>   3f:   89                      .byte 0x89
> 
> Code starting with the faulting instruction
> ===========================================
>    0:   48 3d 00 f0 ff ff       cmp    $0xfffffffffffff000,%rax
>    6:   77 5a                   ja     0x62
>    8:   c3                      retq   
>    9:   66 0f 1f 84 00 00 00    nopw   0x0(%rax,%rax,1)
>   10:   00 00 
>   12:   41 54                   push   %r12
>   14:   49                      rex.WB
>   15:   89                      .byte 0x89
> [  253.208339] RSP: 002b:00007ffcb9e87038 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> [  253.215926] RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007fa906c7c50e
> [  253.223064] RDX: 00000000000003ff RSI: 00007ffcb9e874f0 RDI: 0000000000000004
> [  253.230203] RBP: 00007fa906a9d000 R08: 0000000000000020 R09: 0000000000000000
> [  253.237342] R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffcb9e870f0
> [  253.244481] R13: 0000000046178f11 R14: 00007ffcb9e870f1 R15: 00007ffcb9e874f0
> [  253.311298] WARNING! power/level is deprecated; use power/control instead
> [  253.391095] bdi 8:16: the stable_pages_required attribute has been removed. Use the stable_writes queue attribute instead.
> [  253.461822] LTP: starting fs_racer (fs_racer.sh -t 5)
> [  253.462425] read_all.c:446: TPASS: Finished reading files
> [  253.467003]
> [  253.474072]
> [  253.474074]
> [  253.477410] Summary:
> [  253.477413]
> [  253.484390] passed   1
> [  253.484394]
> [  253.489272] failed   0
> [  253.489275]
> [  253.494226] broken   0
> [  253.494229]
> [  253.498785] skipped  0
> [  253.498787]
> [  253.503077] warnings 0
> [  253.503079]
> [  253.507819] <<<execution_status>>>
> [  253.507822]
> [  253.513662] initiation_status="ok"
> [  253.513665]
> [  253.520191] duration=2 termination_type=exited termination_id=0 corefile=no
> [  253.520195]
> [  253.529408] cutime=31 cstime=146
> [  253.529411]
> [  253.534670] <<<test_end>>>
> [  253.534673]
> [  253.539491] <<<test_start>>>
> [  253.539493]
> [  253.544909] tag=fs_racer stime=1616256119
> [  253.544912]
> [  253.551150] cmdline="fs_racer.sh -t 5"
> [  253.551153]
> [  253.556903] contacts=""
> [  253.556906]
> [  253.561450] analysis=exit
> [  253.561453]
> [  253.566269] <<<test_output>>>
> [  253.566272]
> [  253.571088] 1052827
> [  253.571091]
> [  253.574964] 28626
> [  253.574967]
> [  253.578713] 1968932
> [  253.578715]
> [  253.582631] 1266945
> [  253.582634]
> [  253.586490] 560991
> [  253.586492]
> [  253.590260] 624408
> [  253.590263]
> [  253.594108] 1824335
> [  253.594111]
> [  253.597994] 544694
> [  253.597996]
> [  253.601834] 1480574
> [  253.601837]
> [  255.471244] 1313272
> [  255.471248]
> [  255.475221] 86184
> [  255.475224]
> [  255.479101] 1728568
> [  255.479104]
> [  255.483123] 226081
> [  255.483126]
> [  255.500155] 1048554
> [  255.500160]
> [  255.504223] 1268410
> [  255.504225]
> [  255.508281] 1717154
> [  255.508284]
> [  255.512349] 1306802
> [  255.512352]
> [  255.516330] 440748
> [  255.516333]
> [  255.520196] 79348
> [  255.520200]
> [  255.524114] 1129184
> [  255.524118]
> [  255.528199] 1587817
> [  255.528202]
> [  255.532269] 1389507
> [  255.532272]
> [  255.536349] 1027069
> [  255.536352]
> [  255.540361] 1513046
> [  255.540364]
> [  255.544272] 449232
> [  255.544275]
> [  255.866251] 83254
> [  255.866255]
> [  255.870121] 1198889
> 
> 
> To reproduce:
> 
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         bin/lkp install                job.yaml  # job file is attached in this email
>         bin/lkp split-job --compatible job.yaml
>         bin/lkp run                    compatible-job.yaml
> 
> 
> 
> ---
> 0DAY/LKP+ Test Infrastructure                   Open Source Technology Center
> https://lists.01.org/hyperkitty/list/lkp@lists.01.org       Intel Corporation
> 
> Thanks,
> Oliver Sang
> 
