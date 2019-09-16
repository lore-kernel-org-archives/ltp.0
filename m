From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Mon, 16 Sep 2019 21:37:50 +0800
Subject: [LTP] the reproducible rate of ltp testcases af_alg05
Message-ID: <11cd58ab-b7f4-a311-19d9-0515cf9a1fcb@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Eric

 ?? I run ltp testcases af_alg05 on 3.10.0-1062.el7.x86_64, it sometimes 100% crash . it somtimes the first one passes and the second one crash.

 ?? 100% crash(4G memory ,i5 cpu)

 ?? the second test, this case crashes (8G memory, i5 cpu)

 ?? It seems memory size will affect the reproducible. Is it right?
	
    I think I hit this crash, crash log as below:
[  140.006433] alg: No test for fips(ansi_cprng) (fips_ansi_cprng)
[  140.071830] BUG: unable to handle kernel paging request at fffffac945724000
[  140.071835] IP: [<ffffffffbcd2cbec>] scatterwalk_done+0x4c/0x60
[  140.071841] PGD 13f5d3067 PUD 13f5d2067 PMD 0
[  140.071844] Oops: 0000 [#1] SMP
.......
[  140.071905] RIP: 0010:[<ffffffffbcd2cbec>]  [<ffffffffbcd2cbec>] scatterwalk_done+0x4c/0x60
.....
140.071920] Call Trace:
[  140.071924]  [<ffffffffbcd2fa6e>] ? blkcipher_walk_done+0x21e/0x2b0
[  140.071927]  [<ffffffffbcd2fe5c>] blkcipher_walk_next+0x35c/0x3d0
[  140.071929]  [<ffffffffbcd2ff5a>] blkcipher_walk_first+0x8a/0x1a0
[  140.071932]  [<ffffffffbcd3008f>] blkcipher_walk_virt+0x1f/0x30
[  140.071934]  [<ffffffffbcd3d0d6>] crypto_cbc_decrypt+0x66/0x260
[  140.071937]  [<ffffffffbca7c31f>] ? gup_pud_range+0x13f/0x2a0
[  140.071940]  [<ffffffffbcd2efa1>] async_decrypt+0x51/0x70
[  140.071942]  [<ffffffffbcd2efa1>] ? async_decrypt+0x51/0x70
[  140.071944]  [<ffffffffbcd420a9>] skcipher_recvmsg+0x3a9/0x400
[  140.071947]  [<ffffffffbd02c6ec>] sock_aio_read.part.9+0x14c/0x170
[  140.071949]  [<ffffffffbd02c731>] sock_aio_read+0x21/0x30
[  140.071952]  [<ffffffffbcc47ac3>] do_sync_read+0x93/0xe0
[  140.071954]  [<ffffffffbcc485a5>] vfs_read+0x145/0x170
[  140.071956]  [<ffffffffbcc493bf>] SyS_read+0x7f/0xf0
[  140.071959]  [<ffffffffbd18be21>] ? system_call_after_swapgs+0xae/0x146
[  140.071961]  [<ffffffffbd18bede>] system_call_fastpath+0x25/0x2a
[  140.071963]  [<ffffffffbd18be21>] ? system_call_after_swapgs+0xae/0x146
[  140.071964] Code: c8 41 39 c1 41 0f 46 c1 a9 ff 0f 00 00 74 04 85 d2 75 29 85 f6 74 17 49 8b 00 83 e9 01 c1 e9 0c 48 c1 e1 06 48 83 e0 fc 48 01 c1 <48> 8b 01 85 d2 74 0a 55 48 89 e5 e8 54 fd ff ff 5d f3 c3 90 66
[  140.071992] RIP  [<ffffffffbcd2cbec>] scatterwalk_done+0x4c/0x60
[  140.071994]  RSP <ffff89261e787a90>
  
ps: Tomorrow I will use server machine to test with 16 or 32G memory.

Thanks
Yang Xu



-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190916/2c10aa8c/attachment.htm>
