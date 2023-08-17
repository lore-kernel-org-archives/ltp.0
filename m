Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DFA1C27C7A
	for <ltp@archiver.kernel.org>; Thu, 17 Aug 2023 08:48:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 42B193CCBFB
	for <ltp@archiver.kernel.org>; Thu, 17 Aug 2023 10:48:18 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 513403CB9A0
 for <ltp@lists.linux.it>; Thu, 17 Aug 2023 10:48:07 +0200 (CEST)
Received: from esa6.hc1455-7.c3s2.iphmx.com (esa6.hc1455-7.c3s2.iphmx.com
 [68.232.139.139])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 7A6381A009BD
 for <ltp@lists.linux.it>; Thu, 17 Aug 2023 10:48:05 +0200 (CEST)
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="129701922"
X-IronPort-AV: E=Sophos;i="6.01,179,1684767600"; d="scan'208";a="129701922"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
 by esa6.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Aug 2023 17:48:04 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com
 [192.168.87.59])
 by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 42CFACD7E4
 for <ltp@lists.linux.it>; Thu, 17 Aug 2023 17:48:01 +0900 (JST)
Received: from aks-ab2.gw.nic.fujitsu.com (aks-ab2.gw.nic.fujitsu.com
 [192.51.207.12])
 by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 344F4BF4AF
 for <ltp@lists.linux.it>; Thu, 17 Aug 2023 17:48:00 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.215.131])
 by aks-ab2.gw.nic.fujitsu.com (Postfix) with ESMTP id 3EEE888704;
 Thu, 17 Aug 2023 17:47:59 +0900 (JST)
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: ltp@lists.linux.it
Date: Thu, 17 Aug 2023 16:47:36 +0800
Message-Id: <1692262056-9171-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1408-9.0.0.1002-27818.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1408-9.0.1002-27818.005
X-TMASE-Result: 10-3.504300-10.000000
X-TMASE-MatchedRID: NGDYxnKYxb05rof3b4z0VE7nLUqYrlslFIuBIWrdOeOjEIt+uIPPOKk4
 lLAFOnmCAd0cn1fMeA7RTa7nAlDj8h8CoWZAsDg5IGmn4OlOtCNPnKxAOPp4WUjINjnv2/BM5t3
 2Pj5vqMhsXqCizdUSQ/WX3hJmWOkR4fp+o8pU5fELwUwfdPoXviqz6w5v8PFzmgzZUSbps7k5d9
 n04fLNZoseTkkUAhr2A0/QfQldaFYdkJ0c0DA2owXGi/7cli9j4f+8Ihmp87ybKItl61J/yZ+in
 TK0bC9eKrauXd3MZDU1qnetUPxv5FIo9Hnxe7qE9zYzCt6JxK+/K6ymEOIuS8wmQWofWjZfUqk2
 a9hCqywfwIoM+jT+nHyOz4hqmskyu10CJ+romxGZbXP29aXx5lPJnXL2yNYdkuo847l05tDEzMy
 Amsz+FHoWLWlXcsZv
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] doc/c-api: Add missing formatting
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 doc/c-test-api.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/doc/c-test-api.txt b/doc/c-test-api.txt
index 44ec5bb3d..e4e88edec 100644
--- a/doc/c-test-api.txt
+++ b/doc/c-test-api.txt
@@ -402,7 +402,7 @@ WARNING: This function is not thread safe.
 void tst_set_max_runtime(int max_runtime);
 -------------------------------------------------------------------------------
 
-Allows for setting max_runtime per test iteration dynamically in the test setup(),
+Allows for setting max_runtime per test iteration dynamically in the test 'setup()',
 the timeout is specified in seconds. There are a few testcases whose runtime
 can vary arbitrarily, these can disable timeouts by setting it to
 TST_UNLIMITED_RUNTIME.
@@ -459,7 +459,7 @@ You write just:
 fd = SAFE_OPEN("/dev/null", O_RDONLY);
 -------------------------------------------------------------------------------
 
-IMPORTANT: The SAFE_CLOSE() function also sets the passed file descriptor to -1
+IMPORTANT: The 'SAFE_CLOSE()' function also sets the passed file descriptor to -1
            after it's successfully closed.
 
 They can also simplify reading and writing of sysfs files, you can, for
@@ -831,7 +831,7 @@ type defined in C99 but this one *DOES NOT* imply 'volatile' (it's just a
 signal handler is either 'volatile int' or 'volatile sig_atomic_t'.
 
 If a crash (e.g. triggered by signal SIGSEGV) is expected in testing, you
-can avoid creation of core files by calling tst_no_corefile() function.
+can avoid creation of core files by calling 'tst_no_corefile()' function.
 This takes effect for process (and its children) which invoked it, unless
 they subsequently modify RLIMIT_CORE.
 
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
