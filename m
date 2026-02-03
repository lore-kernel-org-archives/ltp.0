Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F79CE83070
	for <ltp@archiver.kernel.org>; Tue,  3 Feb 2026 09:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1770111825; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=BUT56TWGT+3S9q5eb0JFSFxUdufSV/EfREDQ92Y6kD0=;
 b=RGEd6mFNcUu/UXiA8atCnk/fD2KK8siuy4IQrwsMegWgH9CJcSBuBrxxtd7O8rXPnZ25c
 Oyiel6nATLcgrCNbJrh6bkXO6sRkbznrgX1Z1H9OkENIRMme/vmwnVytVsXd3T0RugvsPJ2
 dXSohYAlT2s0+FtXjoKJ8WTG4drkWFU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 874BB3CD08A
	for <ltp@archiver.kernel.org>; Tue,  3 Feb 2026 10:43:45 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 775C93CCFF7
 for <ltp@lists.linux.it>; Tue,  3 Feb 2026 10:43:21 +0100 (CET)
Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id CE97510008F1
 for <ltp@lists.linux.it>; Tue,  3 Feb 2026 10:43:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
 Content-Type; bh=+vnGmAz5vRseVEmLxDq1Ev09TgyvAAsUzSDgLtBv2b0=; b=l7g/am6yS1u4
 NPcjfRjkwBF7LMDK6W4OZVsOkM0CenNR9KtqKdbb3+CerQ1iintjseqIK5gm/8GhunlATvu7kJT6B
 LcAgmYq1zeRaPu1CL78KEC7hD6wRIic2HFCcgqIkxq/ZEZc/JLIVGDt6M6etrMwSb5uzFoxGaHv/i
 K8aLObaQREdZMGzTsIWkFg0iyDu49/JanU0/g48yaJlcO24AO0Tbb7SJDcJ7uH12wDbalgJNblJbC
 g1QdrfoocledLRlI4wSVtfzoaW+e+UFBMWtoPcNbrdz5O3bz/QB/KWESIUpfJbBlNeeGiXLnlQM/P
 mItPHSUym1qckjdHfAc/mw==;
Received: from [130.117.225.5] (helo=dev010.aci.vzint.dev)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <vasileios.almpanis@virtuozzo.com>)
 id 1vnCvW-00F4Ss-2H for ltp@lists.linux.it;
 Tue, 03 Feb 2026 10:43:11 +0100
To: ltp@lists.linux.it
Date: Tue,  3 Feb 2026 09:43:05 +0000
Message-ID: <20260203094317.685385-1-vasileios.almpanis@virtuozzo.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] runltp: fix regex for disabled testcases
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
From: Vasileios Almpanis via ltp <ltp@lists.linux.it>
Reply-To: Vasileios Almpanis <vasileios.almpanis@virtuozzo.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Currently for all disabled testcases we append TCONF
so that they don't completely disappear from the results.
Unfortunately this regex also matches comments that
include the testcase name creating multiple results for the
same testcase as with the folloing example.

  sed -n '/\<cgroup\>/p' runtest/controllers
  cgroup		cgroup_regression_test.sh
  # Stress test for debug cgroup
  # Stress test for cpuset cgroup
  # Stress test for cpu cgroup
  # Stress test for cpuacct cgroup
  # Stress test for memory cgroup
  # Stress test for freezer cgroup
  # Stress test for devices cgroup
  # Stress test for blkio cgroup
  # Stress test for net_cls cgroup
  # Stress test for perf_event cgroup
  # Stress test for net_prio cgroup
  # Stress test for hugetlb cgroup

Add a line anchor to the regex to not match
lines not related to the disabled testcases.

Signed-off-by: Vasileios Almpanis <vasileios.almpanis@virtuozzo.com>
---
 runltp | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/runltp b/runltp
index 0d9062569..e1748e493 100755
--- a/runltp
+++ b/runltp
@@ -650,7 +650,7 @@ EOF
     if [ -n "${SKIPFILE}" ]; then
         for test_name in $(awk '{print $1}' "${SKIPFILE}"); do
             case "${test_name}" in \#*) continue;; esac
-            sed -i "/\<${test_name}\>/c\\${test_name} exit 32;" alltests
+            sed -i "/^\<${test_name}\>/c\\${test_name} exit 32;" alltests
         done
     fi
 
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
