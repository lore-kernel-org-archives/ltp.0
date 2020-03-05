From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 5 Mar 2020 11:24:48 -0500 (EST)
Subject: [LTP] 
 =?utf-8?q?=E2=9D=8C_FAIL=3A_Test_report_for_kernel_5=2E5?=
 =?utf-8?q?=2E7-60528b7=2Ecki_=28stable-queue=29?=
In-Reply-To: <cki.EED856DF66.LLEP90YP5M@redhat.com>
References: <cki.EED856DF66.LLEP90YP5M@redhat.com>
Message-ID: <2065777364.10425170.1583425488638.JavaMail.zimbra@redhat.com>
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
>        https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
>             Commit: 60528b79e30a - kvm: nVMX: VMWRITE checks unsupported
>             field before read-only field
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
>   https://cki-artifacts.s3.us-east-2.amazonaws.com/index.html?prefix=datawarehouse/2020/03/04/471505
> 
> One or more kernel tests failed:
> 
>     s390x:
>      ? LTP

All instances of similar panics [1] manifest mostly on s390 and at
first glance look like memory corruptions.

I'm looking to confirm, whether this has been fixed by:

  commit 6fcca0fa48118e6d63733eb4644c6cd880c15b8f
  Author: Suren Baghdasaryan <surenb@google.com>
  Date:   Mon Feb 3 13:22:16 2020 -0800

    sched/psi: Fix OOB write when writing 0 bytes to PSI files

[1] 
[  437.397455] addressing exception: 0005 ilc:2 [#1] SMP       
[  437.397464] Modules linked in: sunrpc ghash_s390 prng aes_s390 des_s390 libde 
s qeth_l2 qeth qdio ccwgroup sha512_s390 vfio_ccw vfio_mdev mdev vfio_iommu_type 
1 sha1_s390 vfio ip_tables xfs libcrc32c crc32_vx_s390 sha256_s390 sha_common da 
sd_eckd_mod dasd_mod pkey zcrypt                                                 
[  437.397490] CPU: 3 PID: 1029 Comm: read_all Not tainted 5.5.7-60528b7.cki #1  
[  437.397493] Hardware name: IBM 2964 N96 400 (z/VM 6.4.0)                      
[  437.397497] Krnl PSW : 0704e00180000000 00000000bbf4e508 (collect_percpu_time 
s+0xd0/0x240)                                                                    
[  437.397507]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:2 PM:0 RI: 
0 EA:3                                                                           
[  437.397511] Krnl GPRS: 0000000142374000 0000000142314000 0000000000000000 000 
00000bca4d5a8                                                                    
[  437.397514]            0000000000000000 0000000000000000 0000000142314014 000 
0000000000000                                                                    
[  437.397518]            000003e00092fce0 000003e00092fd20 0000000000000001 000 
0000142314000                                                                    
[  437.397521]            00000001e47d6000 00000001fb07fd40 00000000bbf4e4c8 000 
003e00092fc00                                                                    
[  437.397539] Krnl Code: 00000000bbf4e4fc: b90400b1            lgr     %r11,%r1 
                                                                                 
[  437.397539]            00000000bbf4e500: 41601014            la      %r6,20(% 
r1)                                                                              
[  437.397539]           #00000000bbf4e504: 5870b000            l       %r7,0(%r 
11)                                                                              
[  437.397539]           >00000000bbf4e508: a7710001            tmll    %r7,1    
[  437.397539]            00000000bbf4e50c: a774006d            brc     7,000000 
00bbf4e5e6                                                                       
[  437.397539]            00000000bbf4e510: c0e5fffabadc        brasl   %r14,000 
00000bbea5ac8                                                                    
[  437.397539]            00000000bbf4e516: d20f80006000        mvc     0(16,%r8 
),0(%r6)                                                                         
[  437.397539]            00000000bbf4e51c: d20780106010        mvc     16(8,%r8 
),16(%r6)                                                                        
[  437.397556] Call Trace:                                                       
[  437.397559]  [<00000000bbf4e508>] collect_percpu_times+0xd0/0x240             
[  437.397561] ([<00000000bbf4e4c8>] collect_percpu_times+0x90/0x240)            
[  437.397563]  [<00000000bbf4f380>] psi_show+0x68/0x1c0                         
[  437.397568]  [<00000000bc17494c>] seq_read+0xe4/0x4d8                         
[  437.397572]  [<00000000bc142dc4>] vfs_read+0x94/0x160                         
[  437.397573]  [<00000000bc1431a0>] ksys_read+0x68/0xf8                         
[  437.397578]  [<00000000bc75d668>] system_call+0xdc/0x2c8                      
[  437.397579] Last Breaking-Event-Address:                                      
[  437.397580]  [<00000000bc75eba8>] __s390_indirect_jump_r14+0x0/0xc            
[  437.397583] ---[ end trace 59a09ffb5f96cb2a ]---                

