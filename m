Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4F2AC4332F
	for <ltp@archiver.kernel.org>; Fri, 14 Oct 2022 02:01:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E503E3CAF1D
	for <ltp@archiver.kernel.org>; Fri, 14 Oct 2022 04:01:31 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C0BF43C9586
 for <ltp@lists.linux.it>; Fri, 14 Oct 2022 04:01:20 +0200 (CEST)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id CF42A601CC6
 for <ltp@lists.linux.it>; Fri, 14 Oct 2022 04:01:16 +0200 (CEST)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.53])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MpTzT6QH7zpVsF
 for <ltp@lists.linux.it>; Fri, 14 Oct 2022 09:57:25 +0800 (CST)
Received: from canpemm500005.china.huawei.com (7.192.104.229) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 14 Oct 2022 10:00:38 +0800
Received: from canpemm500005.china.huawei.com ([7.192.104.229]) by
 canpemm500005.china.huawei.com ([7.192.104.229]) with mapi id 15.01.2375.031; 
 Fri, 14 Oct 2022 10:00:38 +0800
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH 2/2] needs_root: Add setting of needs_root
Thread-Index: Adjfbx+oGBWt4wJITsKsr4wxJodqjg==
Date: Fri, 14 Oct 2022 02:00:38 +0000
Message-ID: <5eebb471e7dc4cc18758462a918d0596@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.67.110.209]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] needs_root: Add setting of needs_root
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: zhaogongyi via ltp <ltp@lists.linux.it>
Reply-To: zhaogongyi <zhaogongyi@huawei.com>
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

> 
> > > > Hi Petr,
> 
> > > > It is failed on my system:
> 
> > > > sh-4.4$ ./msgget03
> > > > tst_test.c:1535: TINFO: Timeout per run is 0h 00m 30s
> > > > msgget03.c:42: TINFO: Current environment 0 message queues are
> > > already
> > > > in use
> > > > msgget03.c:45: TBROK: Failed to open FILE
> '/proc/sys/kernel/msgmni'
> > > > for writing: EACCES (13)
> 
> > > Ah, b740bfac5 ("msgget03: Set custom queue limit") causes the need
> > > for root. IMHO this one is valid.
> 
> > > I'd suggest to remove needs_root for needs_device and
> mount_device
> > > now (i.e. send v2).
> 
> > Just remove the patch 1 and keep adding needs_root in patch 2?
> 
> If you haven't added it to any test which would have needs_device or
> mount_device, then v2 can be kept.
> 
> But process_vm_readv02 works for me (on master, on Debian) without
> root:
> 
> $ ./process_vm_readv02
> tst_test.c:1526: TINFO: Timeout per run is 0h 00m 30s
> process_vm_readv02.c:32: TINFO: child 0: memory allocated and
> initialized
> process_vm_readv02.c:49: TINFO: child 1: reading string from same
> memory location
> process_vm_readv02.c:61: TPASS: expected string received
> 
> Summary:
> passed   1
> failed   0
> broken   0
> skipped  0
> warnings 0
> 
> Also process_vm_readv03, process_vm_writev02 (I stopped checking
> now).
> 
> Why you need it?
> 


On my system, these testcases failed and report EPERM:

sh-4.4$ ./process_vm_readv02
tst_test.c:1528: TINFO: Timeout per run is 0h 00m 30s
process_vm_readv02.c:32: TINFO: child 0: memory allocated and initialized
process_vm_readv02.c:49: TINFO: child 1: reading string from same memory location
process_vm_readv02.c:55: TBROK: process_vm_readv: EPERM
process_vm_readv02.c:107: TFAIL: child 1: exited with 2

Summary:
passed   0
failed   1
broken   1
skipped  0
warnings 0

sh-4.4$ ./process_vm_readv03
tst_test.c:1528: TINFO: Timeout per run is 0h 00m 30s
process_vm_readv03.c:165: TINFO: bufsize=1024, remote_iovecs=1024, local_iovecs=8
process_vm_readv03.c:83: TINFO: child_alloc: memory allocated and initialized
process_vm_readv03.c:110: TINFO: child_read: reading string from same memory location
process_vm_readv03.c:114: TFAIL: process_vm_read() failed: EPERM (1)
process_vm_readv03.c:118: TBROK: process_vm_readv: expected 1024 bytes but got -1
process_vm_readv03.c:185: TFAIL: child_read: exited with 2
process_vm_readv03.c:165: TINFO: bufsize=1024, remote_iovecs=512, local_iovecs=16
process_vm_readv03.c:83: TINFO: child_alloc: memory allocated and initialized
process_vm_readv03.c:110: TINFO: child_read: reading string from same memory location
process_vm_readv03.c:114: TFAIL: process_vm_read() failed: EPERM (1)
process_vm_readv03.c:118: TBROK: process_vm_readv: expected 1024 bytes but got -1
process_vm_readv03.c:185: TFAIL: child_read: exited with 2
process_vm_readv03.c:165: TINFO: bufsize=1024, remote_iovecs=256, local_iovecs=32
process_vm_readv03.c:83: TINFO: child_alloc: memory allocated and initialized
process_vm_readv03.c:110: TINFO: child_read: reading string from same memory location
process_vm_readv03.c:114: TFAIL: process_vm_read() failed: EPERM (1)
process_vm_readv03.c:118: TBROK: process_vm_readv: expected 1024 bytes but got -1
process_vm_readv03.c:185: TFAIL: child_read: exited with 2
process_vm_readv03.c:165: TINFO: bufsize=1024, remote_iovecs=128, local_iovecs=64
process_vm_readv03.c:83: TINFO: child_alloc: memory allocated and initialized
process_vm_readv03.c:110: TINFO: child_read: reading string from same memory location
process_vm_readv03.c:114: TFAIL: process_vm_read() failed: EPERM (1)
process_vm_readv03.c:118: TBROK: process_vm_readv: expected 1024 bytes but got -1
process_vm_readv03.c:185: TFAIL: child_read: exited with 2
process_vm_readv03.c:165: TINFO: bufsize=1024, remote_iovecs=64, local_iovecs=128
process_vm_readv03.c:83: TINFO: child_alloc: memory allocated and initialized
process_vm_readv03.c:110: TINFO: child_read: reading string from same memory location
process_vm_readv03.c:114: TFAIL: process_vm_read() failed: EPERM (1)
process_vm_readv03.c:118: TBROK: process_vm_readv: expected 1024 bytes but got -1
process_vm_readv03.c:185: TFAIL: child_read: exited with 2
process_vm_readv03.c:165: TINFO: bufsize=1024, remote_iovecs=32, local_iovecs=256
process_vm_readv03.c:83: TINFO: child_alloc: memory allocated and initialized
process_vm_readv03.c:110: TINFO: child_read: reading string from same memory location
process_vm_readv03.c:114: TFAIL: process_vm_read() failed: EPERM (1)
process_vm_readv03.c:118: TBROK: process_vm_readv: expected 1024 bytes but got -1
process_vm_readv03.c:185: TFAIL: child_read: exited with 2
process_vm_readv03.c:165: TINFO: bufsize=1024, remote_iovecs=16, local_iovecs=512
process_vm_readv03.c:83: TINFO: child_alloc: memory allocated and initialized
process_vm_readv03.c:110: TINFO: child_read: reading string from same memory location
process_vm_readv03.c:114: TFAIL: process_vm_read() failed: EPERM (1)
process_vm_readv03.c:118: TBROK: process_vm_readv: expected 1024 bytes but got -1
process_vm_readv03.c:185: TFAIL: child_read: exited with 2
process_vm_readv03.c:165: TINFO: bufsize=1024, remote_iovecs=8, local_iovecs=1024
process_vm_readv03.c:83: TINFO: child_alloc: memory allocated and initialized
process_vm_readv03.c:110: TINFO: child_read: reading string from same memory location
process_vm_readv03.c:114: TFAIL: process_vm_read() failed: EPERM (1)
process_vm_readv03.c:118: TBROK: process_vm_readv: expected 1024 bytes but got -1
process_vm_readv03.c:185: TFAIL: child_read: exited with 2
process_vm_readv03.c:165: TINFO: bufsize=131072, remote_iovecs=1024, local_iovecs=8
process_vm_readv03.c:83: TINFO: child_alloc: memory allocated and initialized
process_vm_readv03.c:110: TINFO: child_read: reading string from same memory location
process_vm_readv03.c:114: TFAIL: process_vm_read() failed: EPERM (1)
process_vm_readv03.c:118: TBROK: process_vm_readv: expected 131072 bytes but got -1
process_vm_readv03.c:185: TFAIL: child_read: exited with 2
process_vm_readv03.c:165: TINFO: bufsize=131072, remote_iovecs=512, local_iovecs=16
process_vm_readv03.c:83: TINFO: child_alloc: memory allocated and initialized
process_vm_readv03.c:110: TINFO: child_read: reading string from same memory location
process_vm_readv03.c:114: TFAIL: process_vm_read() failed: EPERM (1)
process_vm_readv03.c:118: TBROK: process_vm_readv: expected 131072 bytes but got -1
process_vm_readv03.c:185: TFAIL: child_read: exited with 2
process_vm_readv03.c:165: TINFO: bufsize=131072, remote_iovecs=256, local_iovecs=32
process_vm_readv03.c:83: TINFO: child_alloc: memory allocated and initialized
process_vm_readv03.c:110: TINFO: child_read: reading string from same memory location
process_vm_readv03.c:114: TFAIL: process_vm_read() failed: EPERM (1)
process_vm_readv03.c:118: TBROK: process_vm_readv: expected 131072 bytes but got -1
process_vm_readv03.c:185: TFAIL: child_read: exited with 2
process_vm_readv03.c:165: TINFO: bufsize=131072, remote_iovecs=128, local_iovecs=64
process_vm_readv03.c:83: TINFO: child_alloc: memory allocated and initialized
process_vm_readv03.c:110: TINFO: child_read: reading string from same memory location
process_vm_readv03.c:114: TFAIL: process_vm_read() failed: EPERM (1)
process_vm_readv03.c:118: TBROK: process_vm_readv: expected 131072 bytes but got -1
process_vm_readv03.c:185: TFAIL: child_read: exited with 2
process_vm_readv03.c:165: TINFO: bufsize=131072, remote_iovecs=64, local_iovecs=128
process_vm_readv03.c:83: TINFO: child_alloc: memory allocated and initialized
process_vm_readv03.c:110: TINFO: child_read: reading string from same memory location
process_vm_readv03.c:114: TFAIL: process_vm_read() failed: EPERM (1)
process_vm_readv03.c:118: TBROK: process_vm_readv: expected 131072 bytes but got -1
process_vm_readv03.c:185: TFAIL: child_read: exited with 2
process_vm_readv03.c:165: TINFO: bufsize=131072, remote_iovecs=32, local_iovecs=256
process_vm_readv03.c:83: TINFO: child_alloc: memory allocated and initialized
process_vm_readv03.c:110: TINFO: child_read: reading string from same memory location
process_vm_readv03.c:114: TFAIL: process_vm_read() failed: EPERM (1)
process_vm_readv03.c:118: TBROK: process_vm_readv: expected 131072 bytes but got -1
process_vm_readv03.c:185: TFAIL: child_read: exited with 2
process_vm_readv03.c:165: TINFO: bufsize=131072, remote_iovecs=16, local_iovecs=512
process_vm_readv03.c:83: TINFO: child_alloc: memory allocated and initialized
process_vm_readv03.c:110: TINFO: child_read: reading string from same memory location
process_vm_readv03.c:114: TFAIL: process_vm_read() failed: EPERM (1)
process_vm_readv03.c:118: TBROK: process_vm_readv: expected 131072 bytes but got -1
process_vm_readv03.c:185: TFAIL: child_read: exited with 2
process_vm_readv03.c:165: TINFO: bufsize=131072, remote_iovecs=8, local_iovecs=1024
process_vm_readv03.c:83: TINFO: child_alloc: memory allocated and initialized
process_vm_readv03.c:110: TINFO: child_read: reading string from same memory location
process_vm_readv03.c:114: TFAIL: process_vm_read() failed: EPERM (1)
process_vm_readv03.c:118: TBROK: process_vm_readv: expected 131072 bytes but got -1
process_vm_readv03.c:185: TFAIL: child_read: exited with 2

Summary:
passed   0
failed   32
broken   16
skipped  0
warnings 0



sh-4.4$ ./process_vm_writev02
tst_test.c:1528: TINFO: Timeout per run is 0h 00m 30s
process_vm_writev02.c:32: TINFO: child 0: allocate memory
process_vm_writev02.c:55: TINFO: child 1: write to the same memory location
process_vm_writev02.c:65: TFAIL: tst_syscall(__NR_process_vm_writev, pid_alloc, &local, 1UL, &remote, 1UL, 0UL) failed: EPERM (1)
process_vm_writev02.c:69: TBROK: process_vm_writev: expected 100000 bytes but got -1
process_vm_writev02.c:112: TFAIL: write child: exited with 2
process_vm_writev02.c:45: TFAIL: child 0: found 100000 differences from expected data

Summary:
passed   0
failed   3
broken   1
skipped  0
warnings 0

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
