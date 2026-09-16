Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCE84C88E77
	for <ltp@archiver.kernel.org>; Wed, 16 Sep 2026 09:38:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 467FC3E694F
	for <ltp@archiver.kernel.org>; Wed, 16 Sep 2026 11:38:16 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C54963C98AB
 for <ltp@lists.linux.it>; Wed, 16 Sep 2026 11:38:01 +0200 (CEST)
Received: from mta0.migadu.com (out-150.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::96])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 167A36006F1
 for <ltp@lists.linux.it>; Wed, 16 Sep 2026 11:37:59 +0200 (CEST)
X-Envelope-To: ltp@lists.linux.it
DKIM-Signature: a=rsa-sha256; bh=db/PJf4mIwldmQkdAa2BkgtrS+MzbdZPUceXjxFa4ak=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789551479; v=1; x=1790156279;
 b=Z9GN6J3Q/dvXJuPTo0KpbPeZnMkz7q/G8XBxwzeuC11mgiinbZI9pAcXZ0YjAB+HdCgMqxAW
 Ti5avGEIrqbFj57r3u5lVfqYvMKD9jfb9nOPDjzg7JGYRiH4N82uJpAIhJJLQ7u5gqW6cNzpEy6
 Yl4jcHjkec+85svl9fz+KVjE=
X-Envelope-To: ltp@lists.linux.it
Received: by smtp.migadu.com with ESMTPS id 34bd29999afaa648;
 Wed, 16 Sep 2026 09:37:49 +0000
X-Mizu-Trace-ID: 34bd29999afaa648
X-Migadu-Flow: FLOW_OUT
Date: Wed, 16 Sep 2026 17:37:42 +0800
From: Li Wang <li.wang@linux.dev>
To: Huaisheng Ye <yehuaisheng@open-hieco.net>, tsahu@linux.ibm.com,
 pvorel@suse.cz, ltp@lists.linux.it
Message-ID: <aqpjZsOCq-jDfks_@linux.dev>
Mail-Followup-To: Huaisheng Ye <yehuaisheng@open-hieco.net>,
 tsahu@linux.ibm.com, pvorel@suse.cz, ltp@lists.linux.it
References: <20260914032359.9956-1-yehuaisheng@open-hieco.net>
 <aqpX1P1bNIEol4yt@linux.dev>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aqpX1P1bNIEol4yt@linux.dev>
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] hugemmap10: Account for memory policy in counter
 checks
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> 
> Aside from this patch, my test encountered new failures on a four-node system.
> Without your patch, the surplus failure can be reproduced consistently, so I
> suspect it's a different issue.
> 
> ...
> hugemmap10.c:402: TFAIL: While doing munmap shared after touch: Bad HugePages_Total: expected 1, actual 2
> hugemmap10.c:402: TFAIL: While doing munmap shared after touch: Bad HugePages_Free: expected 1, actual 2
> hugemmap10.c:402: TFAIL: While doing munmap shared after touch: Bad HugePages_Surp: expected 0, actual 1

The test system has four nodes, and only nodes 0 and 2 have memory.
I guess that's what caused the failure when running hugemmap10 during
hugepage allocation.

Something like this:

1. The test pre-allocates 1 hugepage, which defaults to Node 0.

2. When the test runs on Node 2, the kernel dynamically creates a surplus
   hugepage on Node 2 to ensure local memory performance.

3. The global hugepage count becomes 2 (1 on Node 0 + 1 surplus on Node 2).

4. The test expects exactly 1 global hugepage, so it reports a failure.

Below are the test results from patched-hugemmap10 on patched-kernel-6.6.
I'll do more investigation tomorrow.

[root@SL26GA ~]# numactl -H
available: 4 nodes (0-3)
node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79
node 0 size: 31729 MB
node 0 free: 30582 MB
node 1 cpus: 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95
node 1 size: 0 MB
node 1 free: 0 MB
node 2 cpus: 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111
node 2 size: 31896 MB
node 2 free: 30627 MB
node 3 cpus: 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127
node 3 size: 0 MB
node 3 free: 0 MB
node distances:
node   0   1   2   3
  0:  10  15  42  38
  1:  15  10  38  33
  2:  42  38  10  15
  3:  38  33  15  10

[root@SL26GA hugemmap]# numactl --cpunodebind=0 ./hugemmap10
tst_hugepage.c:84: TINFO: 6 hugepage(s) reserved
tst_tmpdir.c:308: TINFO: Using /tmp/LTP_hug9CXa7r as tmpdir (tmpfs filesystem)
tst_test.c:1233: TINFO: Mounting none to /tmp/LTP_hug9CXa7r/hugetlbfs fstyp=hugetlbfs flags=0
tst_test.c:2065: TINFO: LTP version: 20260529
tst_test.c:2068: TINFO: Tested kernel: 6.6.145-9.sl26.x86_64 #1 SMP Thu Sep  3 11:08:39 CST 2026 x86_64
tst_kconfig.c:90: TINFO: Parsing kernel config '/proc/config.gz'
tst_test.c:1893: TINFO: Overall timeout per run is 0h 00m 30s
hugemmap10.c:457: TINFO: Base pool size: 0
hugemmap10.c:384: TINFO: Clean...
hugemmap10.c:435: TINFO: OK
hugemmap10.c:384: TINFO: Untouched, shared...
hugemmap10.c:435: TINFO: OK
hugemmap10.c:384: TINFO: Untouched, private...
hugemmap10.c:435: TINFO: OK
hugemmap10.c:384: TINFO: Touched, shared...
hugemmap10.c:435: TINFO: OK
hugemmap10.c:384: TINFO: Touched, private...
hugemmap10.c:435: TINFO: OK
hugemmap10.c:457: TINFO: Base pool size: 1
hugemmap10.c:384: TINFO: Clean...
hugemmap10.c:435: TINFO: OK
hugemmap10.c:384: TINFO: Untouched, shared...
hugemmap10.c:435: TINFO: OK
hugemmap10.c:384: TINFO: Untouched, private...
hugemmap10.c:435: TINFO: OK
hugemmap10.c:384: TINFO: Touched, shared...
hugemmap10.c:435: TINFO: OK
hugemmap10.c:384: TINFO: Touched, private...
hugemmap10.c:435: TINFO: OK
hugemmap10.c:457: TINFO: Base pool size: 2
hugemmap10.c:384: TINFO: Clean...
hugemmap10.c:435: TINFO: OK
hugemmap10.c:384: TINFO: Untouched, shared...
hugemmap10.c:435: TINFO: OK
hugemmap10.c:384: TINFO: Untouched, private...
hugemmap10.c:435: TINFO: OK
hugemmap10.c:384: TINFO: Touched, shared...
hugemmap10.c:435: TINFO: OK
hugemmap10.c:384: TINFO: Touched, private...
hugemmap10.c:435: TINFO: OK
hugemmap10.c:457: TINFO: Base pool size: 3
hugemmap10.c:384: TINFO: Clean...
hugemmap10.c:435: TINFO: OK
hugemmap10.c:384: TINFO: Untouched, shared...
hugemmap10.c:435: TINFO: OK
hugemmap10.c:384: TINFO: Untouched, private...
hugemmap10.c:435: TINFO: OK
hugemmap10.c:384: TINFO: Touched, shared...
hugemmap10.c:435: TINFO: OK
hugemmap10.c:384: TINFO: Touched, private...
hugemmap10.c:435: TINFO: OK
hugemmap10.c:500: TPASS: Hugepages Counters works as expected.

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0

[root@SL26GA hugemmap]# numactl --cpunodebind=2 ./hugemmap10
tst_hugepage.c:84: TINFO: 6 hugepage(s) reserved
tst_tmpdir.c:308: TINFO: Using /tmp/LTP_hugVJVuKk as tmpdir (tmpfs filesystem)
tst_test.c:1233: TINFO: Mounting none to /tmp/LTP_hugVJVuKk/hugetlbfs fstyp=hugetlbfs flags=0
tst_test.c:2065: TINFO: LTP version: 20260529
tst_test.c:2068: TINFO: Tested kernel: 6.6.145-9.sl26.x86_64 #1 SMP Thu Sep  3 11:08:39 CST 2026 x86_64
tst_kconfig.c:90: TINFO: Parsing kernel config '/proc/config.gz'
tst_test.c:1893: TINFO: Overall timeout per run is 0h 00m 30s
hugemmap10.c:457: TINFO: Base pool size: 0
hugemmap10.c:384: TINFO: Clean...
hugemmap10.c:435: TINFO: OK
hugemmap10.c:384: TINFO: Untouched, shared...
hugemmap10.c:435: TINFO: OK
hugemmap10.c:384: TINFO: Untouched, private...
hugemmap10.c:435: TINFO: OK
hugemmap10.c:384: TINFO: Touched, shared...
hugemmap10.c:435: TINFO: OK
hugemmap10.c:384: TINFO: Touched, private...
hugemmap10.c:435: TINFO: OK
hugemmap10.c:457: TINFO: Base pool size: 1
hugemmap10.c:384: TINFO: Clean...
hugemmap10.c:435: TINFO: OK
hugemmap10.c:384: TINFO: Untouched, shared...
hugemmap10.c:402: TFAIL: While doing munmap shared after touch: Bad HugePages_Total: expected 1, actual 2
hugemmap10.c:402: TFAIL: While doing munmap shared after touch: Bad HugePages_Free: expected 1, actual 2
hugemmap10.c:402: TFAIL: While doing munmap shared after touch: Bad HugePages_Surp: expected 0, actual 1

Summary:
passed   0
failed   3
broken   0
skipped  0
warnings 0


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
