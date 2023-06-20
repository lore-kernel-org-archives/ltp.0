Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18F91EB64D7
	for <ltp@archiver.kernel.org>; Tue, 20 Jun 2023 08:17:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 11E933CE0F7
	for <ltp@archiver.kernel.org>; Tue, 20 Jun 2023 10:17:16 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1E0123CA8D7
 for <ltp@lists.linux.it>; Tue, 20 Jun 2023 10:17:04 +0200 (CEST)
Received: from smtp.priv.miraclelinux.com
 (202x210x215x66.ap202.ftth.ucom.ne.jp [202.210.215.66])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id CE80F1400BC4
 for <ltp@lists.linux.it>; Tue, 20 Jun 2023 10:17:03 +0200 (CEST)
Received: from localhost.localdomain (21A0035i-SL7B460.priv.miraclelinux.com
 [10.2.1.161])
 by smtp.priv.miraclelinux.com (Postfix) with ESMTP id 674EC14006E;
 Tue, 20 Jun 2023 17:17:01 +0900 (JST)
From: Souta Kawahara <souta.kawahara@miraclelinux.com>
To: ltp@lists.linux.it
Date: Tue, 20 Jun 2023 17:08:14 +0900
Message-Id: <84e75a194e19b8519badb8a5db29b928150cca14.1687247631.git.souta.kawahara@miraclelinux.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 1/2] testcases/kernel: Add CVE tag to some existing
 tests.
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

Signed-off-by: Souta Kawahara <souta.kawahara@miraclelinux.com>
---
 testcases/kernel/mem/ksm/ksm05.c                    | 4 ++++
 testcases/kernel/syscalls/ipc/shmat/shmat03.c       | 1 +
 testcases/kernel/syscalls/keyctl/keyctl02.c         | 1 +
 testcases/kernel/syscalls/setsockopt/setsockopt02.c | 4 ++++
 testcases/kernel/syscalls/uname/uname04.c           | 4 ++++
 5 files changed, 14 insertions(+)

diff --git a/testcases/kernel/mem/ksm/ksm05.c b/testcases/kernel/mem/ksm/ksm05.c
index 25f3435b2..1f58c8325 100644
--- a/testcases/kernel/mem/ksm/ksm05.c
+++ b/testcases/kernel/mem/ksm/ksm05.c
@@ -95,6 +95,10 @@ static struct tst_test test = {
 		"CONFIG_KSM=y",
 		NULL
 	},
+	.tags = (const struct tst_tag[]) {
+		{"CVE", "2011-2183"},
+		{}
+	}
 };
 
 #else
diff --git a/testcases/kernel/syscalls/ipc/shmat/shmat03.c b/testcases/kernel/syscalls/ipc/shmat/shmat03.c
index dfa427a56..16bf01009 100644
--- a/testcases/kernel/syscalls/ipc/shmat/shmat03.c
+++ b/testcases/kernel/syscalls/ipc/shmat/shmat03.c
@@ -104,6 +104,7 @@ static struct tst_test test = {
 		{"linux-git", "95e91b831f87"},
 		{"linux-git", "a73ab244f0da"},
 		{"linux-git", "8f89c007b6de"},
+		{"CVE", "2017-5669"},
 		{}
 	}
 };
diff --git a/testcases/kernel/syscalls/keyctl/keyctl02.c b/testcases/kernel/syscalls/keyctl/keyctl02.c
index 572f34b16..35cc2838d 100644
--- a/testcases/kernel/syscalls/keyctl/keyctl02.c
+++ b/testcases/kernel/syscalls/keyctl/keyctl02.c
@@ -144,6 +144,7 @@ static struct tst_test test = {
 	.test_all = do_test,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "b4a1b4f5047e"},
+		{"CVE", "2015-7550"},
 		{}
 	}
 };
diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt02.c b/testcases/kernel/syscalls/setsockopt/setsockopt02.c
index e7621538b..3349c9970 100644
--- a/testcases/kernel/syscalls/setsockopt/setsockopt02.c
+++ b/testcases/kernel/syscalls/setsockopt/setsockopt02.c
@@ -96,4 +96,8 @@ static struct tst_test test = {
 	.needs_root = 1,
 	.setup = setup,
 	.cleanup = cleanup,
+	.tags = (const struct tst_tag[]) {
+		{"CVE", "2017-7308"},
+		{}
+	}
 };
diff --git a/testcases/kernel/syscalls/uname/uname04.c b/testcases/kernel/syscalls/uname/uname04.c
index 2d0851c8b..885368c24 100644
--- a/testcases/kernel/syscalls/uname/uname04.c
+++ b/testcases/kernel/syscalls/uname/uname04.c
@@ -79,4 +79,8 @@ static void run(unsigned int test_nr)
 static struct tst_test test = {
 	.test = run,
 	.tcnt = 2,
+	.tags = (const struct tst_tag[]) {
+		{"CVE", "2012-0957"},
+		{}
+	}
 };
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
