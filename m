Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77EE8C6FD1C
	for <ltp@archiver.kernel.org>; Thu, 23 Mar 2023 16:05:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8F1753CE320
	for <ltp@archiver.kernel.org>; Thu, 23 Mar 2023 17:05:27 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1034B3CD2F4
 for <ltp@lists.linux.it>; Thu, 23 Mar 2023 17:05:17 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by in-3.smtp.seeweb.it (Postfix) with ESMTP id 2BDEE1A00CDE
 for <ltp@lists.linux.it>; Thu, 23 Mar 2023 17:05:16 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 41AD91FB
 for <ltp@lists.linux.it>; Thu, 23 Mar 2023 09:05:59 -0700 (PDT)
Received: from e126380.arm.com (unknown [10.57.53.10])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4A3E73F766
 for <ltp@lists.linux.it>; Thu, 23 Mar 2023 09:05:14 -0700 (PDT)
From: Teo Couprie Diaz <teo.coupriediaz@arm.com>
To: ltp@lists.linux.it
Date: Thu, 23 Mar 2023 16:05:07 +0000
Message-Id: <20230323160508.672397-1-teo.coupriediaz@arm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] safe_open: Add missing mode from some calls
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

safe_open expects a mode when creating or using a temporary file, which is
read via a variadic argument.
Add the mode when it is missing for a few tests.

Signed-off-by: Teo Couprie Diaz <teo.coupriediaz@arm.com>
---
This was detected on Morello[0] as the missing mode triggered an access
outside of capability bounds when processing the variadic argument.

CI Build: https://github.com/Teo-CD/ltp/actions/runs/4502201455

[0]: https://www.morello-project.org/

 .../kernel/syscalls/name_to_handle_at/name_to_handle_at01.c     | 2 +-
 .../kernel/syscalls/open_by_handle_at/open_by_handle_at01.c     | 2 +-
 testcases/kernel/syscalls/utimensat/utimensat01.c               | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/name_to_handle_at/name_to_handle_at01.c b/testcases/kernel/syscalls/name_to_handle_at/name_to_handle_at01.c
index 9677b06719e3..6535fdf5c0ed 100644
--- a/testcases/kernel/syscalls/name_to_handle_at/name_to_handle_at01.c
+++ b/testcases/kernel/syscalls/name_to_handle_at/name_to_handle_at01.c
@@ -72,7 +72,7 @@ static void setup(void)
 	dir_fd = SAFE_OPEN(TEST_DIR, O_DIRECTORY);
 	SAFE_CHDIR(TEST_DIR);
 	SAFE_TOUCH(TEST_FILE, 0600, NULL);
-	file_fd = SAFE_OPEN("foo_file", O_RDWR | O_CREAT);
+	file_fd = SAFE_OPEN("foo_file", O_RDWR | O_CREAT, 0600);
 	fhp = allocate_file_handle(AT_FDCWD, TEST_FILE);
 }
 
diff --git a/testcases/kernel/syscalls/open_by_handle_at/open_by_handle_at01.c b/testcases/kernel/syscalls/open_by_handle_at/open_by_handle_at01.c
index 76be720cad78..6171229f0b6f 100644
--- a/testcases/kernel/syscalls/open_by_handle_at/open_by_handle_at01.c
+++ b/testcases/kernel/syscalls/open_by_handle_at/open_by_handle_at01.c
@@ -55,7 +55,7 @@ static void setup(void)
 	dir_fd = SAFE_OPEN(TEST_DIR, O_DIRECTORY);
 	SAFE_CHDIR(TEST_DIR);
 	SAFE_TOUCH(TEST_FILE, 0600, NULL);
-	file_fd = SAFE_OPEN("foo_file", O_RDWR | O_CREAT);
+	file_fd = SAFE_OPEN("foo_file", O_RDWR | O_CREAT, 0600);
 
 	f_fhp = allocate_file_handle(AT_FDCWD, TEST_FILE);
 	d_fhp = allocate_file_handle(AT_FDCWD, TEST_FILE);
diff --git a/testcases/kernel/syscalls/utimensat/utimensat01.c b/testcases/kernel/syscalls/utimensat/utimensat01.c
index ac267e7d9f84..a2897b42288d 100644
--- a/testcases/kernel/syscalls/utimensat/utimensat01.c
+++ b/testcases/kernel/syscalls/utimensat/utimensat01.c
@@ -233,7 +233,7 @@ static void run(unsigned int i)
 		dfd = SAFE_OPEN(TEST_DIR, tc->oflags);
 
 	if (tc->pathname) {
-		fd = SAFE_OPEN(tc->pathname, O_WRONLY | O_CREAT);
+		fd = SAFE_OPEN(tc->pathname, O_WRONLY | O_CREAT, 0200);
 		pathname = tc->pathname;
 		SAFE_CHMOD(tc->pathname, tc->mode);
 		reset_time(pathname, dfd, tc->flags, i);
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
