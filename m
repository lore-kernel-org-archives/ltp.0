Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA603CDB474
	for <ltp@archiver.kernel.org>; Mon, 23 Oct 2023 14:19:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4B7663CECB6
	for <ltp@archiver.kernel.org>; Mon, 23 Oct 2023 16:19:16 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EAF213CECA6
 for <ltp@lists.linux.it>; Mon, 23 Oct 2023 15:57:24 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by in-7.smtp.seeweb.it (Postfix) with ESMTP id 7844F200DD1
 for <ltp@lists.linux.it>; Mon, 23 Oct 2023 15:57:23 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AAC73C15;
 Mon, 23 Oct 2023 06:58:02 -0700 (PDT)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com
 [10.1.194.65])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0E5F63F64C;
 Mon, 23 Oct 2023 06:57:20 -0700 (PDT)
From: Kevin Brodsky <kevin.brodsky@arm.com>
To: ltp@lists.linux.it
Date: Mon, 23 Oct 2023 14:56:45 +0100
Message-Id: <20231023135647.2157030-2-kevin.brodsky@arm.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20231023135647.2157030-1-kevin.brodsky@arm.com>
References: <20231023135647.2157030-1-kevin.brodsky@arm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 23 Oct 2023 16:18:31 +0200
Subject: [LTP] [PATCH 1/3] syscalls/{,
 f}setxattr: Fix passing of value pointer
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
Cc: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

tc[i].value is a pointer to the actual value pointer, it therefore
needs to be dereferenced before passing it down to {f,}setxattr()
(which is already done as expected in the TEST() line below).

This brokenness went unnoticed as the initial value (garbage before
this patch) is never read back - this call is only used to create
the key.

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 testcases/kernel/syscalls/fsetxattr/fsetxattr01.c | 2 +-
 testcases/kernel/syscalls/setxattr/setxattr01.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/fsetxattr/fsetxattr01.c b/testcases/kernel/syscalls/fsetxattr/fsetxattr01.c
index d799e477f49c..b65b27bdf9ac 100644
--- a/testcases/kernel/syscalls/fsetxattr/fsetxattr01.c
+++ b/testcases/kernel/syscalls/fsetxattr/fsetxattr01.c
@@ -140,7 +140,7 @@ static void verify_fsetxattr(unsigned int i)
 {
 	/* some tests might require existing keys for each iteration */
 	if (tc[i].keyneeded) {
-		SAFE_FSETXATTR(fd, tc[i].key, tc[i].value, tc[i].size,
+		SAFE_FSETXATTR(fd, tc[i].key, *tc[i].value, tc[i].size,
 				XATTR_CREATE);
 	}
 
diff --git a/testcases/kernel/syscalls/setxattr/setxattr01.c b/testcases/kernel/syscalls/setxattr/setxattr01.c
index 8cd2821d0c6c..31f41369a608 100644
--- a/testcases/kernel/syscalls/setxattr/setxattr01.c
+++ b/testcases/kernel/syscalls/setxattr/setxattr01.c
@@ -137,7 +137,7 @@ static void verify_setxattr(unsigned int i)
 {
 	/* some tests might require existing keys for each iteration */
 	if (tc[i].keyneeded) {
-		SAFE_SETXATTR(FNAME, tc[i].key, tc[i].value, tc[i].size,
+		SAFE_SETXATTR(FNAME, tc[i].key, *tc[i].value, tc[i].size,
 				XATTR_CREATE);
 	}
 
-- 
2.38.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
