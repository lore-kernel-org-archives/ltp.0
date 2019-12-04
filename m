From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 4 Dec 2019 03:18:26 -0500 (EST)
Subject: [LTP] 
 =?utf-8?q?=E2=9D=8C_FAIL=3A_Test_report_for_kernel_5=2E3?=
 =?utf-8?q?=2E14-a8a1bb9=2Ecki_=28stable-queue=29?=
In-Reply-To: <cki.E29F90E1D2.DNJBK7BQCI@redhat.com>
References: <cki.E29F90E1D2.DNJBK7BQCI@redhat.com>
Message-ID: <2014617876.14947317.1575447506379.JavaMail.zimbra@redhat.com>
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
>             Commit: a8a1bb9b6315 - platform/x86: hp-wmi: Fix ACPI errors
>             caused by passing 0 as input size
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
>   https://artifacts.cki-project.org/pipelines/322089
> 
> One or more kernel tests failed:
> 
>     x86_64:
>      ? LTP
>      ? Boot test
>      ? Boot test
> 

Boot tests look like false positives. LTP hit kernel oops:
  https://artifacts.cki-project.org/pipelines/322089/logs/x86_64_host_1_console.log

[ 2418.739440] LTP: starting request_key01 
[ 2418.742799] LTP: starting request_key02 
[ 2420.749042] LTP: starting request_key03 
[ 2420.751635] encrypted_key: keyword 'update' not allowed when called from .instantiate method 
[ 2420.877090] encrypted_key: keyword 'update' not allowed when called from .instantiate method 
[ 2420.879700] encrypted_key: keyword 'update' not allowed when called from .instantiate method 
...
[ 2421.147659] general protection fault: 0000 [#1] SMP PTI 
[ 2421.148884] CPU: 0 PID: 439814 Comm: request_key03 Tainted: G        W         5.3.14-a8a1bb9.cki #1 
[ 2421.150916] Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011 
[ 2421.152199] RIP: 0010:kmem_cache_alloc+0x75/0x220 
[ 2421.153244] Code: 01 00 00 4c 8b 45 00 65 49 8b 50 08 65 4c 03 05 d9 ef d4 4b 4d 8b 20 4d 85 e4 0f 84 71 01 00 00 8b 5d 20 48 8b 7d 00 4c 01 e3 <48> 33 1b 48 33 9d 70 01 00 00 40 f6 c7 0f 0f 85 6e 01 00 00 48 8d 
[ 2421.157370] RSP: 0018:ffffa22a80ae3d30 EFLAGS: 00010282 
[ 2421.158530] RAX: 0000000000000000 RBX: bb86d0eb53aa6367 RCX: 00000000000003f9 
[ 2421.160108] RDX: 000000000001cdad RSI: 0000000000000dc0 RDI: 000000000002d680 
[ 2421.161675] RBP: ffff8d7c3b01ae00 R08: ffff8d7c3ba2d680 R09: 000000003f010000 
[ 2421.163275] R10: 0000000000000004 R11: 0000000063736564 R12: bb86d0eb53aa6367 
[ 2421.164854] R13: 0000000000000dc0 R14: ffffffffb442447b R15: ffff8d7c3b01ae00 
[ 2421.166449] FS:  00007f0ce5368600(0000) GS:ffff8d7c3ba00000(0000) knlGS:0000000000000000 
[ 2421.168225] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033 
[ 2421.169508] CR2: 00007fb3e59f8380 CR3: 000000013972e005 CR4: 00000000007606f0 
[ 2421.171073] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000 
[ 2421.172660] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400 
[ 2421.174222] PKRU: 55555554 
[ 2421.174851] Call Trace: 
[ 2421.175410]  key_alloc+0x12b/0x450 
[ 2421.176175]  request_key_and_link+0x256/0x6a0 
[ 2421.177146]  ? keyring_alloc+0x70/0x70 
[ 2421.178005]  ? key_default_cmp+0x20/0x20 
[ 2421.178882]  __x64_sys_request_key+0xf4/0x190 
[ 2421.179856]  do_syscall_64+0x5f/0x1a0 
[ 2421.180695]  entry_SYSCALL_64_after_hwframe+0x44/0xa9 
[ 2421.181814] RIP: 0033:0x7f0ce529a1ad 
[ 2421.182624] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d ab 5c 0c 00 f7 d8 64 89 01 48 
[ 2421.186749] RSP: 002b:00007fff61b77af8 EFLAGS: 00000246 ORIG_RAX: 00000000000000f9 
[ 2421.188407] RAX: ffffffffffffffda RBX: 00007f0ce5368580 RCX: 00007f0ce529a1ad 
[ 2421.189994] RDX: 00000000004132e2 RSI: 00000000004132c5 RDI: 0000000000413367 
[ 2421.191576] RBP: 000000002647d069 R08: 0000000000000000 R09: 0000000000000000 
[ 2421.193145] R10: 00000000fffffffd R11: 0000000000000246 R12: 000000000006b605 
[ 2421.194730] R13: 0000000000413367 R14: 00000000000186a0 R15: 00000000000043fb 
<followed by more call traces>

