Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9454DC4332F
	for <ltp@archiver.kernel.org>; Fri, 10 Nov 2023 03:57:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3E53E3CF0FF
	for <ltp@archiver.kernel.org>; Fri, 10 Nov 2023 04:57:19 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C8E0C3CB675
 for <ltp@lists.linux.it>; Fri, 10 Nov 2023 04:57:06 +0100 (CET)
Received: from esa2.hc1455-7.c3s2.iphmx.com (esa2.hc1455-7.c3s2.iphmx.com
 [207.54.90.48])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 949E4100014F
 for <ltp@lists.linux.it>; Fri, 10 Nov 2023 04:57:04 +0100 (CET)
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="139174733"
X-IronPort-AV: E=Sophos;i="6.03,291,1694703600"; d="scan'208";a="139174733"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
 by esa2.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Nov 2023 12:57:02 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com
 [192.168.87.60])
 by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id E2FE3DC146
 for <ltp@lists.linux.it>; Fri, 10 Nov 2023 12:56:59 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 29566D94A3
 for <ltp@lists.linux.it>; Fri, 10 Nov 2023 12:56:59 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id B2A9D200501AA
 for <ltp@lists.linux.it>; Fri, 10 Nov 2023 12:56:58 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.220.121])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 5035A1A008D;
 Fri, 10 Nov 2023 11:56:58 +0800 (CST)
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: ltp@lists.linux.it
Date: Thu,  9 Nov 2023 22:56:48 -0500
Message-Id: <20231110035648.167600-1-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-27988.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-27988.004
X-TMASE-Result: 10--0.631200-10.000000
X-TMASE-MatchedRID: /HyfiRbsgEXMr7kwgO8M5aqHmm/V4M/Pv8jdqvFOu+K4GyTmeN+AbNWr
 FFAqqfvHraf1T9RqEUnZncxzzHd/E3i7G2Wfx0KpxrDvUMltogSgg5fb1w0y11y92pa0KjKSadd
 RQFDhSxAI0JEpLdHmfLFSIkwwwvT7L/tBTZzO5Q0D2WXLXdz+AbKyARzLntncmyiLZetSf8nyb6
 HMFK1qe7zpudJIfq+xC24oEZ6SpSmcfuxsiY4QFLtpQYZ9FCM8nudWlKTuZs7drX3B0Jaxogis3
 5nG64V2OavspSc7k9Q7yyzTaWX+2V3fDpqEdIyNjrFMCaXbWol+5WZgO8GXFZsNEGpLafrrLM/n
 EDLP056e+TDiyH/49wxfkLAfkNNSaAZk0sEcY14=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] vma05.sh: Fix check for core file presence
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

When I tested it, I found that the test produced the error:
vma05 1 TBROK: missing core file

I try to get the generated core file
  rm -rf core*
  { vma05_vdso; } > /dev/null 2>&1
+ ls -l *core*
  [ -f core ] || tst_brk TCONF "missing core file"

<<<test_output>>>
incrementing stop
vma05 1 TINFO: timeout per run is 0h 5m 0s
vma05 1 TPASS: [vsyscall] reported correctly
-rw------- 1 root root 458752 Nov 10 02:16 core.931905
vma05 1 TBROK: missing core file

The test actually generates not core but in the form of core.n
So may be '[ -f core ]' should be changed to '[ -f core* ]'

Fixes: 63529eef ("vma05.sh: Add check for core file presence")
Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 testcases/kernel/mem/vma/vma05.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/mem/vma/vma05.sh b/testcases/kernel/mem/vma/vma05.sh
index a09951462..6f5459308 100755
--- a/testcases/kernel/mem/vma/vma05.sh
+++ b/testcases/kernel/mem/vma/vma05.sh
@@ -54,7 +54,7 @@ vma_report_check()
 
 	rm -rf core*
 	{ vma05_vdso; } > /dev/null 2>&1
-	[ -f core ] || tst_brk TBROK "missing core file"
+	[ -f core* ] || tst_brk TBROK "missing core file"
 
 	TRACE=$(gdb -silent -ex="thread apply all backtrace" -ex="quit"\
 		vma05_vdso ./core* 2> /dev/null)
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
