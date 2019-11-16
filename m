From: Jan Stancek <jstancek@redhat.com>
Date: Sat, 16 Nov 2019 06:56:39 -0500 (EST)
Subject: [LTP] 
 =?utf-8?q?=E2=9D=8C_FAIL=3A_Test_report_for_kernel_5=2E4?=
 =?utf-8?q?=2E0-rc7-875fef4=2Ecki_=28mainline=2Ekernel=2Eorg=29?=
In-Reply-To: <cki.492ED7396B.CQPXHDBTDS@redhat.com>
References: <cki.492ED7396B.CQPXHDBTDS@redhat.com>
Message-ID: <1833930614.12688158.1573905399800.JavaMail.zimbra@redhat.com>
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
>        https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>             Commit: 875fef493f21 - Merge tag 'ceph-for-5.4-rc8' of
>             git://github.com/ceph/ceph-client
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
>   https://artifacts.cki-project.org/pipelines/287844
> 
> One or more kernel tests failed:
> 
>     x86_64:
>      ? LTP lite

@CKI: You should update your LTP, in new one this test skips debugfs.

I didn't get reported crash [1], but file below seems to have potential for that:

# cat /sys/kernel/debug/device_component/mei::b638ab7e-94e2-4ea2-a552-d1c54b627f04:01
master name                                            status
-------------------------------------------------------------
mei::b638ab7e-94e2-4ea2-a552-d1c54b627f04:01            not bound

device name                                            status
-------------------------------------------------------------
?
?????????(w
           ????0?O????              not registered


[1]
[ 5812.625994] general protection fault: 0000 [#1] SMP PTI 
[ 5812.632787] CPU: 3 PID: 441221 Comm: read_all Not tainted 5.4.0-rc7-875fef4.cki #1 
[ 5812.642012] Hardware name: Intel Corporation SandyBridge Platform/LosLunas CRB, BIOS ASNBCPT1.86C.0061.P00.1101131110 01/13/2011 
[ 5812.655452] RIP: 0010:string_nocheck+0x34/0x50 
[ 5812.661430] Code: 66 85 c0 74 3c 83 e8 01 4c 8d 5c 07 01 31 c0 eb 19 49 39 fa 76 03 44 88 07 48 83 c7 01 41 8d 71 01 48 83 c0 01 4c 39 df 74 0f <44> 0f b6 04 02 41 89 c1 89 c6 45 84 c0 75 d8 4c 89 d2 e9 15 ff ff 
[ 5812.683864] RSP: 0018:ffffac63a16d7d18 EFLAGS: 00010246 
[ 5812.690674] RAX: 0000000000000000 RBX: ffffac63a16d7db0 RCX: ffff0a0200002804 
[ 5812.699459] RDX: 64656e69666e6f63 RSI: ffff890f85e44000 RDI: ffff890f85e4313b 
[ 5812.708263] RBP: ffff890f85e44000 R08: ffffffff981bfa38 R09: ffff890f85e430e8 
[ 5812.717061] R10: ffff890f85e44000 R11: ffff891085e4313a R12: 64656e69666e6f63 
[ 5812.725790] R13: ffff0a0200002804 R14: 0000000000000ec5 R15: ffffffff9816cdf6 
[ 5812.734503] FS:  00007f31a535f740(0000) GS:ffff890f8b8c0000(0000) knlGS:0000000000000000 
[ 5812.744161] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033 
[ 5812.751348] CR2: 00007fb60c983640 CR3: 0000000142c88003 CR4: 00000000000606e0 
[ 5812.759974] Call Trace: 
[ 5812.763632]  string+0x42/0x50 
[ 5812.767829]  vsnprintf+0x276/0x4f0 
[ 5812.772478]  seq_vprintf+0x30/0x50 
[ 5812.777122]  seq_printf+0x53/0x70 
[ 5812.781682]  ? do_filp_open+0xa5/0x100 
[ 5812.786701]  component_devices_show+0x103/0x120 
[ 5812.792557]  seq_read+0xcd/0x400 
[ 5812.797053]  full_proxy_read+0x53/0x80 
[ 5812.802110]  vfs_read+0x9d/0x150 
[ 5812.806631]  ksys_read+0x5f/0xe0 
[ 5812.811147]  do_syscall_64+0x5b/0x180 
[ 5812.816118]  entry_SYSCALL_64_after_hwframe+0x44/0xa9 
[ 5812.822590] RIP: 0033:0x7f31a553e842 
[ 5812.827507] Code: 97 00 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb be 0f 1f 80 00 00 00 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 0f 05 <48> 3d 00 f0 ff ff 77 56 c3 0f 1f 44 00 00 48 83 ec 28 48 89 54 24 

