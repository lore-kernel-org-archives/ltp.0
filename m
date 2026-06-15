Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B174CD98CE
	for <ltp@archiver.kernel.org>; Mon, 15 Jun 2026 06:59:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E5C0E3E4E3D
	for <ltp@archiver.kernel.org>; Mon, 15 Jun 2026 08:59:38 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 638923C19F0
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 03:14:26 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D4534600445
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 03:14:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781486065; x=1813022065;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=9dhE9WCJJMFac4NW8agr8xZUUZx9o6LAAmH7018m0zU=;
 b=fLpsgYj+iDHEEJ/sAhPJVf5U7H7EGnQYj1QphNffTfVIBn76j330sYXF
 mnQbRCQaA5qfBzJlMAXYVeycNNK2hMuRJOFHJcsdufpx4pLPvtR4GqGz6
 fQmYYvYFyG08oPxUEFg93wO10edR+apkgQH07BCaMH/PxIN4JvuksbZ3l
 suIVB/i7lAXu1XKGXpOqEVKmyoVPFTo4hqEh2uxMYyJSpKqZXguLiOjS5
 lLyEn/RoJtEYcAx1GDogsI0T8ZJzQ3GzOabNS8ATnjMv57OU95oGNNolz
 rjhq6NlHz7hTAtgX6UPVxRiOrfc7LgTyU89YrNTEGum11rBOgTAmySRsT Q==;
X-CSE-ConnectionGUID: BhIO7DoVSd+S3Ag7JslOfQ==
X-CSE-MsgGUID: OWyaZlYUQEWA5cIo9nhcAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11817"; a="84789868"
X-IronPort-AV: E=Sophos;i="6.24,205,1774335600"; d="scan'208";a="84789868"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jun 2026 18:14:21 -0700
X-CSE-ConnectionGUID: fLDyD29tTzqN8mKXPt4F5A==
X-CSE-MsgGUID: /5Lqvi6STlqHwJARxl3imA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,205,1774335600"; d="scan'208";a="285442099"
Received: from ubuntu22-04.sh.intel.com ([10.239.182.71])
 by orviesa001.jf.intel.com with ESMTP; 14 Jun 2026 18:14:20 -0700
From: Wenbo Ma <wenbo1.ma@intel.com>
To: ltp@lists.linux.it
Date: Mon, 15 Jun 2026 09:29:11 +0800
Message-Id: <20260615012911.36607-1-wenbo1.ma@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 15 Jun 2026 08:59:10 +0200
Subject: [LTP] [PATCH] open_posix/pthread_sigmask/18-1: Fix race condition
 in signal thread join
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
Cc: Wenbo Ma <wenbo1.ma@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

When WITH_SYNCHRO is defined, the signal sender threads (th_sig1 and
th_sig2) may block on sem_wait() after the main loop exits. This causes
pthread_join() to hang indefinitely since those threads never wake up.

Post to both semaphores before joining to ensure the signal threads
can proceed and exit cleanly.

Signed-off-by: Wenbo Ma <wenbo1.ma@intel.com>
---
 .../conformance/interfaces/pthread_sigmask/18-1.c            | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_sigmask/18-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_sigmask/18-1.c
index f303e9854..e4606813e 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_sigmask/18-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_sigmask/18-1.c
@@ -293,6 +293,11 @@ int main(void)
 	}
 	while (do_it);
 
+#ifdef WITH_SYNCHRO
+	sem_post(&semsig1);
+	sem_post(&semsig2);
+#endif
+
 	if ((ret = pthread_join(th_sig1, NULL))) {
 		UNRESOLVED(ret, "Signal 1 sender thread join failed");
 	}
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
