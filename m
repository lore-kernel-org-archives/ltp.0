Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA5FBC71145
	for <ltp@archiver.kernel.org>; Thu, 24 Aug 2023 06:46:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 92BA83CC4D0
	for <ltp@archiver.kernel.org>; Thu, 24 Aug 2023 08:46:44 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3DD183CC494
 for <ltp@lists.linux.it>; Thu, 24 Aug 2023 08:46:33 +0200 (CEST)
Received: from smtp.priv.miraclelinux.com
 (202x210x215x66.ap202.ftth.ucom.ne.jp [202.210.215.66])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D95AF1401202
 for <ltp@lists.linux.it>; Thu, 24 Aug 2023 08:46:31 +0200 (CEST)
Received: from localhost.localdomain (21A0035i-SL7B460.priv.miraclelinux.com
 [10.2.1.161])
 by smtp.priv.miraclelinux.com (Postfix) with ESMTP id 523D8140052;
 Thu, 24 Aug 2023 15:46:29 +0900 (JST)
From: Souta Kawahara <souta.kawahara@miraclelinux.com>
To: ltp@lists.linux.it
Date: Thu, 24 Aug 2023 15:36:22 +0900
Message-Id: <447b0209996f33c5d7f6f5e0f146ca1abfe28346.1692858827.git.souta.kawahara@miraclelinux.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 1/1] doc/c-test-api.txt: fix wrong chapter number
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

Chapter number "1.36" was duplicated.
Incremented the second "1.36" and subsequent chapters.

Signed-off-by: Souta Kawahara <souta.kawahara@miraclelinux.com>
---
 doc/c-test-api.txt | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/doc/c-test-api.txt b/doc/c-test-api.txt
index e4e88edec..3c059bb3a 100644
--- a/doc/c-test-api.txt
+++ b/doc/c-test-api.txt
@@ -2141,7 +2141,7 @@ the prefix field of file pointed by path equals to the value passed to this func
 Also having a similar api pair TST_ASSERT_FILE_INT/STR(path, prefix, val) to assert
 the field value of file.
 
-1.36 Using Control Group
+1.37 Using Control Group
 ~~~~~~~~~~~~~~~~~~~~~~~~
 
 Some LTP tests need specific Control Group configurations.  'tst_cgroup.h'
@@ -2322,19 +2322,19 @@ kernel docs. Presently the LTP library does not attempt to handle most
 differences in semantics. It does the minimal amount of work to make testing on
 both V1 and V2 feasible.
 
-1.37 Require minimum numbers of CPU for a testcase
+1.38 Require minimum numbers of CPU for a testcase
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 Some tests require more than specific number of CPU. It can be defined with
 `.min_cpus = N`.
 
-1.38 Require minimum size of MemAvailable for a testcase
+1.39 Require minimum size of MemAvailable for a testcase
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 Some tests require more than specific size(MB) of MemAvailable. It can be defined
 with `.min_mem_avail = N`.
 
-1.39 Test tags
+1.40 Test tags
 ~~~~~~~~~~~~~~
 
 Test tags are name-value pairs that can hold any test metadata.
@@ -2376,7 +2376,7 @@ struct tst_test test = {
 };
 -------------------------------------------------------------------------------
 
-1.40 Testing on the specific architecture
+1.41 Testing on the specific architecture
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 Testcases for specific arch should be limited on that only being supported
 platform to run, we now involve a '.supported_archs' to achieve this feature
@@ -2412,7 +2412,7 @@ static struct tst_test test = {
 };
 -------------------------------------------------------------------------------
 
-1.41 Skipping test based on system state
+1.42 Skipping test based on system state
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 Test can be skipped on various conditions: on enabled SecureBoot
 ('.skip_in_secureboot = 1'), lockdown ('.skip_in_lockdown = 1') or in 32-bit
-- 
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
