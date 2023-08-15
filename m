Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DABADC001B0
	for <ltp@archiver.kernel.org>; Tue, 15 Aug 2023 10:54:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7B6333CD1AF
	for <ltp@archiver.kernel.org>; Tue, 15 Aug 2023 12:54:29 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 20BFC3C967F
 for <ltp@lists.linux.it>; Tue, 15 Aug 2023 12:54:17 +0200 (CEST)
Received: from esa3.hc1455-7.c3s2.iphmx.com (esa3.hc1455-7.c3s2.iphmx.com
 [207.54.90.49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 0A8336001FA
 for <ltp@lists.linux.it>; Tue, 15 Aug 2023 12:54:15 +0200 (CEST)
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="128188532"
X-IronPort-AV: E=Sophos;i="6.01,174,1684767600"; d="scan'208";a="128188532"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
 by esa3.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Aug 2023 19:54:12 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com
 [192.168.87.61])
 by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 995A97FB69
 for <ltp@lists.linux.it>; Tue, 15 Aug 2023 19:54:09 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 90A14D6140
 for <ltp@lists.linux.it>; Tue, 15 Aug 2023 19:54:08 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.215.131])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 05D14200649E9;
 Tue, 15 Aug 2023 19:54:07 +0900 (JST)
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: ltp@lists.linux.it
Date: Tue, 15 Aug 2023 18:53:37 +0800
Message-Id: <1692096817-15512-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-27814.003
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-27814.003
X-TMASE-Result: 10--11.649600-10.000000
X-TMASE-MatchedRID: cW5UfOyvKhE23AXUgL0utazGfgakLdjaaEANKbBJN106FHRWx2FGsL8F
 Hrw7frluf146W0iUu2vNs+hSjQLHEDKEOf80TKXQOjf3A4DTYuFZoq85oEW2FAGJiBxi7iVxysx
 /ZixtIIryZnEl0t0eu9BrVWcP/4U9JZ+ovZY/XBFIcJTn2HkqsRgff28UuvITFFqcwE7P4SI3KV
 6TwldBNzf3LjDSfF32QxzKhFiXIPBUAmzcvaRR98IkzTqL3E/WTSz0JdEAJbQum94DE3gzX7qSN
 KTkl986m6WfEFBBxPqdONIB9b2owAGm89tONGRnqhcdnP91eXGUO3k9AyCPTfLIj08N6FsEsvOv
 U1bC85z3gkZLY/qIz3dNoXv6UJm+EfIWTKnSZvk1PRCuPh/FNUEe5VjFzwNb6qVTmlduXY+jxYy
 RBa/qJcFwgTvxipFa9xS3mVzWUuCRTpSQiv9X7bRBGWsEXd5lPs2j5ry5SDZjmzq5drM54dSPYu
 dJ95b2ouJhNp2axJnTq9HaTRi2VA==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH]
 build-system-guide.txt/c-test-api.txt/c-test-tutorial-simple.txt/c-test-tutorial-simple.txt:
 fix typo
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
 doc/build-system-guide.txt             | 2 +-
 doc/c-test-api.txt                     | 6 +++---
 doc/c-test-tutorial-simple.txt         | 2 +-
 doc/supported-kernel-libc-versions.txt | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/doc/build-system-guide.txt b/doc/build-system-guide.txt
index b8d267b4b..e078fa7f7 100644
--- a/doc/build-system-guide.txt
+++ b/doc/build-system-guide.txt
@@ -106,7 +106,7 @@ The 'REQ_VERSION_MAJOR' and 'REQ_VERSION_PATCH' describe minimal kernel
 version for which the build system tries to build the module.
 
 The buildsystem is also forward compatible with changes in Linux kernel
-internal API so that if modul fails to build the failure is ignored both on
+internal API so that if module fails to build the failure is ignored both on
 build and installation. If the userspace counterpart of the test fails to load
 the module because the file does not exists, the test is skipped.
 
diff --git a/doc/c-test-api.txt b/doc/c-test-api.txt
index 74871e6c8..44ec5bb3d 100644
--- a/doc/c-test-api.txt
+++ b/doc/c-test-api.txt
@@ -20,7 +20,7 @@ Let's start with an example, following code is a simple test for a 'getenv()'.
  * [Description]
  * Tests basic functionality of getenv().
  *
- *  - create an env variable and verify that getenv() can get get it
+ *  - create an env variable and verify that getenv() can get it
  *  - call getenv() with nonexisting variable name, check that it returns NULL
  */
 
@@ -579,7 +579,7 @@ These two functions are intended for runtime kernel version detection. They
 parse the output from 'uname()' and compare it to the passed values.
 
 The return value is similar to the 'strcmp()' function, i.e. zero means equal,
-negative value means that the kernel is older than than the expected value and
+negative value means that the kernel is older than the expected value and
 positive means that it's newer.
 
 The second function 'tst_kvercmp2()' allows for specifying per-vendor table of
@@ -1949,7 +1949,7 @@ available to the children (see the capabilities (7) manual pages).
 
 However a lot of problems can be solved by using 'tst_cap_action(struct
 tst_cap  *cap)' directly which can be called at any time. This also helps if
-you wish to drop a capability at the begining of setup.
+you wish to drop a capability at the beginning of setup.
 
 1.33 Reproducing race-conditions
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
diff --git a/doc/c-test-tutorial-simple.txt b/doc/c-test-tutorial-simple.txt
index 62930fdcb..c691c1dd9 100644
--- a/doc/c-test-tutorial-simple.txt
+++ b/doc/c-test-tutorial-simple.txt
@@ -940,7 +940,7 @@ the 'index' where you are then able to un-stage some parts before
 re-committing.
 
 You can also use +edit+ and +git commit --amend+ together to change a commit
-deep in your history, but without reseting the 'index'. The 'index' contains
+deep in your history, but without resetting the 'index'. The 'index' contains
 changes which you have staged with +git add+, but not yet committed.
 
 So now that the commit history has been cleaned up, we need to submit a patch
diff --git a/doc/supported-kernel-libc-versions.txt b/doc/supported-kernel-libc-versions.txt
index 6b9970872..e3d9cd92f 100644
--- a/doc/supported-kernel-libc-versions.txt
+++ b/doc/supported-kernel-libc-versions.txt
@@ -62,7 +62,7 @@ Minimal supported kernel version is 3.10.
 [align="center",options="header"]
 |==================================
 | Libc      | Note
-| https://www.gnu.org/software/libc/[GNU C Library (glibc)] | Targetted libc, tested both compilation and actual test results.
+| https://www.gnu.org/software/libc/[GNU C Library (glibc)] | Targeted libc, tested both compilation and actual test results.
 | https://uclibc-ng.org/[uClibc-ng] | Although not being tested it should work as well as it attempt to maintain a glibc compatible interface.
 | https://www.uclibc.org/[uClibc]   | Older https://www.uclibc.org/[uClibc] might have problems.
 | https://musl.libc.org/[musl] | Not yet fully supported (see
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
