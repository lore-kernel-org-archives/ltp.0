Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22A0DC77B7C
	for <ltp@archiver.kernel.org>; Fri,  5 May 2023 08:17:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3738B3CB6DB
	for <ltp@archiver.kernel.org>; Fri,  5 May 2023 10:17:12 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5E68B3CB67E
 for <ltp@lists.linux.it>; Fri,  5 May 2023 10:17:01 +0200 (CEST)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id AFE7414010E4
 for <ltp@lists.linux.it>; Fri,  5 May 2023 10:16:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1683274618; x=1714810618;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=s3xc3S5WrOG07WeSgm456EQJetSGa6jQJ1cON4cw2Mk=;
 b=Mrsf+cyLz/lC4lzXckXlNHQIbEjzlBkQhVOhQBnXLKBGw8yU6XDTO4zC
 myL5sepOiNU/KLBcvP411gsyCjXgRRnLPucMQ7ahtyczP+/tG3X2MUj9r
 heubgTbQfLruHCcaR/G9vadrcsoUid/I9hwgh76Jn9PjNOZo72NCHInYz
 owvWaljqwEFvqiVBAwPeVPck3S30AwunRGuhR7JjOOohz9EmBGt7EDcUt
 V0jR8GI8oF3Qw6VyJnt1KcBdhP0iEeYEMcBDEXYw7uHYyOVnWxv6F2sO9
 vLW5hlgZdSmszbKL93Ju9zXXsWqxgpyStF220sV2YPeRfr1/p+y5TGqN7 g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="349196584"
X-IronPort-AV: E=Sophos;i="5.99,251,1677571200"; d="scan'208";a="349196584"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2023 01:16:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="674947837"
X-IronPort-AV: E=Sophos;i="5.99,251,1677571200"; d="scan'208";a="674947837"
Received: from xpf.sh.intel.com ([10.239.182.130])
 by orsmga006.jf.intel.com with ESMTP; 05 May 2023 01:16:45 -0700
From: Pengfei Xu <pengfei.xu@intel.com>
To: ltp@lists.linux.it
Date: Fri,  5 May 2023 16:18:43 +0800
Message-Id: <efa47acd652c93a54fb66e17183524b54e561533.1683274510.git.pengfei.xu@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1683274510.git.pengfei.xu@intel.com>
References: <cover.1683274510.git.pengfei.xu@intel.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 1/1] libs: libltpnuma: Fix one fake failure when
 CXL(Compute eXpress Link) node memory is not used
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
Cc: Heng Su <heng.su@intel.com>, rpalethorpe@suse.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Intel sapphire rapids server, BIOS could allocate one memory block for CXL
node when the server boot up, and this node "MemUsed" is 0 when CXL is not
used like as follow:
"
cat /sys/devices/system/node/node2/meminfo
Node 2 MemTotal:        4194304 kB
Node 2 MemFree:         4194304 kB
Node 2 MemUsed:               0 kB
...
"

And it caused get_mempolicy01/02 and set_mempolicy01/02/03/04 cases to fail
like as follow sample:
"
tag=get_mempolicy01 stime=1683272855
cmdline="get_mempolicy01"
contacts=""
analysis=exit
<<<test_output>>>
incrementing stop
tst_test.c:1560: TINFO: Timeout per run is 0h 00m 30s
tst_numa.c:200: TINFO: Found 3 NUMA memory nodes
tst_numa.c:165: TWARN: Failed to parse '/sys/devices/system/node/node2/meminfo'
get_mempolicy01.c:188: TINFO: test #1: policy: MPOL_DEFAULT, no target
get_mempolicy01.c:191: TPASS: policy: MPOL_DEFAULT, no target passed
get_mempolicy01.c:188: TINFO: test #2: policy: MPOL_BIND
get_mempolicy01.c:191: TPASS: policy: MPOL_BIND passed
get_mempolicy01.c:188: TINFO: test #3: policy: MPOL_INTERLEAVE
get_mempolicy01.c:191: TPASS: policy: MPOL_INTERLEAVE passed
get_mempolicy01.c:188: TINFO: test #4: policy: MPOL_PREFERRED, no target
get_mempolicy01.c:191: TPASS: policy: MPOL_PREFERRED, no target passed
get_mempolicy01.c:188: TINFO: test #5: policy: MPOL_PREFERRED
get_mempolicy01.c:191: TPASS: policy: MPOL_PREFERRED passed
get_mempolicy01.c:188: TINFO: test #6: policy: MPOL_DEFAULT, flags: MPOL_F_ADDR, no target
get_mempolicy01.c:191: TPASS: policy: MPOL_DEFAULT, flags: MPOL_F_ADDR, no target passed
get_mempolicy01.c:188: TINFO: test #7: policy: MPOL_BIND, flags: MPOL_F_ADDR
get_mempolicy01.c:191: TPASS: policy: MPOL_BIND, flags: MPOL_F_ADDR passed
get_mempolicy01.c:188: TINFO: test #8: policy: MPOL_INTERLEAVE, flags: MPOL_F_ADDR
get_mempolicy01.c:191: TPASS: policy: MPOL_INTERLEAVE, flags: MPOL_F_ADDR passed
get_mempolicy01.c:188: TINFO: test #9: policy: MPOL_PREFERRED, flags: MPOL_F_ADDR, no target
get_mempolicy01.c:191: TPASS: policy: MPOL_PREFERRED, flags: MPOL_F_ADDR, no target passed
get_mempolicy01.c:188: TINFO: test #10: policy: MPOL_PREFERRED, flags: MPOL_F_ADDR
get_mempolicy01.c:191: TPASS: policy: MPOL_PREFERRED, flags: MPOL_F_ADDR passed

Summary:
passed   10
failed   0
broken   0
skipped  0
warnings 1
...
--------                                           ------     ----------
get_mempolicy01                                    FAIL       4
"
So fixed the fake failure when CXL node memory is not being used.

Signed-off-by: Pengfei Xu <pengfei.xu@intel.com>
---
 libs/libltpnuma/tst_numa.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/libs/libltpnuma/tst_numa.c b/libs/libltpnuma/tst_numa.c
index ef4c8e879..f6f577657 100644
--- a/libs/libltpnuma/tst_numa.c
+++ b/libs/libltpnuma/tst_numa.c
@@ -161,8 +161,11 @@ static int node_has_enough_memory(int node, size_t min_kb)
 
 	fclose(fp);
 
-	if (!mem_total || !mem_used) {
-		tst_res(TWARN, "Failed to parse '%s'", path);
+	tst_res(TINFO,"Node%i: mem_total:%ld kB, mem_used:%ld kB", node,
+	        mem_total, mem_used);
+
+	if (!mem_total) {
+		tst_res(TWARN, "Failed to parse '%s', MemTotal is 0", path);
 		return 0;
 	}
 
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
