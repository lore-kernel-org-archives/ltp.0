Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48B17CA6007
	for <ltp@archiver.kernel.org>; Thu,  8 Oct 2026 09:41:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 82EF63E3048
	for <ltp@archiver.kernel.org>; Thu,  8 Oct 2026 11:40:58 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3F2223CC4E7
 for <ltp@lists.linux.it>; Thu,  8 Oct 2026 11:40:42 +0200 (CEST)
Received: from mta0.migadu.com (out-13.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 0235A1400DAF
 for <ltp@lists.linux.it>; Thu,  8 Oct 2026 11:40:39 +0200 (CEST)
X-Envelope-To: ltp@lists.linux.it
DKIM-Signature: a=rsa-sha256; bh=0+9M/dSfQHESLShaF2ImC2UyoWiQL7aKSqOBfs8ODPc=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791452437; v=1; x=1792057237;
 b=cisK4smWS3fTF7+7Ki7MpI7rg4PooggzNipNYMC4PeGUAnpa/OGV1kO5R730kNNaIRz3//48
 F2NYCa4DO/tKygTJUa4c6mqZ5Lgd0IbcMG6O5PmGOEQOaWbmD+F3cHFAbKMdETE2IHUVSQSSObJ
 ZkOd15uL7eeqG885MLYPu49c=
X-Envelope-To: ltp@lists.linux.it
Received: by smtp.migadu.com with ESMTPS id 4435f50f0464fef4;
 Thu, 08 Oct 2026 09:40:27 +0000
X-Mizu-Trace-ID: 4435f50f0464fef4
X-Migadu-Flow: FLOW_OUT
Date: Thu, 8 Oct 2026 17:40:22 +0800
From: Li Wang <li.wang@linux.dev>
To: Huaisheng Ye <yehuaisheng@open-hieco.net>
Message-ID: <asdlBnDpEw2xeuRL@linux.dev>
Mail-Followup-To: Huaisheng Ye <yehuaisheng@open-hieco.net>,
 chrubis@suse.cz, pvorel@suse.cz, ltp@lists.linux.it
References: <20260929072412.20979-1-yehuaisheng@open-hieco.net>
 <20260929072412.20979-4-yehuaisheng@open-hieco.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260929072412.20979-4-yehuaisheng@open-hieco.net>
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 3/3] hugemmap10: Account for memory policy in
 private fault checks
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Huaisheng Ye wrote:

> Kernels without private mmap-time reservations or with flags MAP_NORESERVE
> create the reservation when the private VMA first faults. With MPOL_BIND,
> globally free hugepages can be outside the allowed nodes, so this fault
> can create surplus pages even when the global counters appear sufficient.
> 
>     $ numactl --cpunodebind=0 --membind=2 ./hugemmap10 -n
>     tst_hugepage.c:84: TINFO: 3 hugepage(s) reserved
>     tst_tmpdir.c:308: TINFO: Using /tmp/LTP_hugdeSTgL as tmpdir (xfs filesystem)
>     tst_test.c:1218: TINFO: Mounting none to /tmp/LTP_hugdeSTgL/hugetlbfs fstyp=hugetlbfs flags=0
>     tst_test.c:2048: TINFO: LTP version: 20260529-237-g132c8b0a8
>     tst_test.c:2051: TINFO: Tested kernel: 7.3.0-rc1-test-32+ #33 SMP PREEMPT Mon Sep  7 11:50:02 CST 2026 x86_64
>     tst_kconfig.c:90: TINFO: Parsing kernel config '/proc/config.gz'
>     tst_test.c:1876: TINFO: Overall timeout per run is 0h 00m 30s
>     hugemmap10.c:498: TINFO: Base pool size: 0
>     hugemmap10.c:425: TINFO: Clean...
>     hugemmap10.c:476: TINFO: OK
>     hugemmap10.c:425: TINFO: Untouched, shared...
>     hugemmap10.c:476: TINFO: OK
>     hugemmap10.c:425: TINFO: Untouched, private...
>     hugemmap10.c:476: TINFO: OK
>     hugemmap10.c:425: TINFO: Touched, shared...
>     hugemmap10.c:476: TINFO: OK
>     hugemmap10.c:425: TINFO: Touched, private...
>     hugemmap10.c:476: TINFO: OK
>     hugemmap10.c:498: TINFO: Base pool size: 1
>     hugemmap10.c:425: TINFO: Clean...
>     hugemmap10.c:448: TFAIL: While touching the addr after mmap private: Bad HugePages_Total: expected 1, actual 2
>     hugemmap10.c:448: TFAIL: While touching the addr after mmap private: Bad HugePages_Free: expected 0, actual 1
>     hugemmap10.c:448: TFAIL: While touching the addr after mmap private: Bad HugePages_Surp: expected 0, actual 1
> 
>     Summary:
>     passed   0
>     failed   3
>     broken   0
>     skipped  0
>     warnings 0
> 
> Get free hugepages on allowed nodes before touching an unreserved
> private mapping and use the maximum of the global and allowed-node
> shortfalls to calculate the expected counters.
> 
> Signed-off-by: Huaisheng Ye <yehuaisheng@open-hieco.net>

Nice fix!

Reviewed-by: Li Wang <li.wang@linux.dev>

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
