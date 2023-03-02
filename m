Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89C7BC6FA8E
	for <ltp@archiver.kernel.org>; Thu,  2 Mar 2023 07:16:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 845BD3CB9F3
	for <ltp@archiver.kernel.org>; Thu,  2 Mar 2023 08:16:42 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C1EF23CCE04
 for <ltp@lists.linux.it>; Thu,  2 Mar 2023 08:16:22 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 30385600C57
 for <ltp@lists.linux.it>; Thu,  2 Mar 2023 08:16:21 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 934CA1FE65;
 Thu,  2 Mar 2023 07:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1677741381; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EgSowtxOOK+SnqarRpBUgAkRxrCQGUAdRTr0wokmdV0=;
 b=HkJZ32SQbiyIcEzFirH0iKkWDEc9S7CdDK03zgys/SsV0UwTx8eVpZXbPOPPFF/ZYuu0SM
 g1orKuJn5PZ2CgCFgVuEsxZolK1T6oLZ6eEHg/CYwCSi1w6/7VEQ/gIfkFK2HL9iZbdzMT
 LoLpvjWuK3ntsD4XNUEN8zPl1UUHNtQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EEB4F13A5C;
 Thu,  2 Mar 2023 07:16:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 0IAoMURNAGRxeQAAMHmgww
 (envelope-from <wegao@suse.com>); Thu, 02 Mar 2023 07:16:20 +0000
To: ltp@lists.linux.it
Date: Thu,  2 Mar 2023 02:15:54 -0500
Message-Id: <20230302071555.18420-2-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230302071555.18420-1-wegao@suse.com>
References: <20230120010533.11202-1-wegao@suse.com>
 <20230302071555.18420-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 1/2] Move semaphore/ tests to semop/
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

There is no point in having two different directories with semop()
testcaes so it would make sense to move these two tests into the
syscalls/ipc/semop/ directory as semop04 and semop05.
So we move ipc/semaphore/ tests to syscalls/ipc/semop/.
Also update runtest files accordingly.

Signed-off-by: Wei Gao <wegao@suse.com>
---
 runtest/syscalls                              |  2 ++
 testcases/kernel/ipc/semaphore/.gitignore     |  2 --
 testcases/kernel/ipc/semaphore/Makefile       | 30 -------------------
 .../kernel/syscalls/ipc/semop/.gitignore      |  2 ++
 testcases/kernel/syscalls/ipc/semop/Makefile  |  5 +++-
 .../sem01.c => syscalls/ipc/semop/semop04.c}  |  0
 .../sem02.c => syscalls/ipc/semop/semop05.c}  |  0
 7 files changed, 8 insertions(+), 33 deletions(-)
 delete mode 100644 testcases/kernel/ipc/semaphore/.gitignore
 delete mode 100644 testcases/kernel/ipc/semaphore/Makefile
 rename testcases/kernel/{ipc/semaphore/sem01.c => syscalls/ipc/semop/semop04.c} (100%)
 rename testcases/kernel/{ipc/semaphore/sem02.c => syscalls/ipc/semop/semop05.c} (100%)

diff --git a/runtest/syscalls b/runtest/syscalls
index ae37a1192..54cbc6ece 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1239,6 +1239,8 @@ semget06 semget06
 semop01 semop01
 semop02 semop02
 semop03 semop03
+semop04 semop04
+semop05 semop05
 
 send01 send01
 send02 send02
diff --git a/testcases/kernel/ipc/semaphore/.gitignore b/testcases/kernel/ipc/semaphore/.gitignore
deleted file mode 100644
index 944e5ca1e..000000000
--- a/testcases/kernel/ipc/semaphore/.gitignore
+++ /dev/null
@@ -1,2 +0,0 @@
-/sem01
-/sem02
diff --git a/testcases/kernel/ipc/semaphore/Makefile b/testcases/kernel/ipc/semaphore/Makefile
deleted file mode 100644
index 9ab85745d..000000000
--- a/testcases/kernel/ipc/semaphore/Makefile
+++ /dev/null
@@ -1,30 +0,0 @@
-#
-#    testcases/kernel/ipc/semaphore Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
-# Ngie Cooper, July 2009
-#
-
-top_srcdir		?= ../../../..
-
-include $(top_srcdir)/include/mk/testcases.mk
-
-CPPFLAGS 		+= -I../include
-LDLIBS			+= -lpthread
-
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/ipc/semop/.gitignore b/testcases/kernel/syscalls/ipc/semop/.gitignore
index bb57f08af..cc67b1862 100644
--- a/testcases/kernel/syscalls/ipc/semop/.gitignore
+++ b/testcases/kernel/syscalls/ipc/semop/.gitignore
@@ -1,3 +1,5 @@
 /semop01
 /semop02
 /semop03
+/semop04
+/semop05
diff --git a/testcases/kernel/syscalls/ipc/semop/Makefile b/testcases/kernel/syscalls/ipc/semop/Makefile
index 6b2b26d05..43afffb3f 100644
--- a/testcases/kernel/syscalls/ipc/semop/Makefile
+++ b/testcases/kernel/syscalls/ipc/semop/Makefile
@@ -7,6 +7,9 @@ LTPLIBS = ltpnewipc
 
 include $(top_srcdir)/include/mk/testcases.mk
 
-LTPLDLIBS  = -lltpnewipc
+semop01: LTPLDLIBS  = -lltpnewipc
+semop02: LTPLDLIBS  = -lltpnewipc
+semop03: LTPLDLIBS  = -lltpnewipc
+semop05: LDLIBS    += -lpthread
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/ipc/semaphore/sem01.c b/testcases/kernel/syscalls/ipc/semop/semop04.c
similarity index 100%
rename from testcases/kernel/ipc/semaphore/sem01.c
rename to testcases/kernel/syscalls/ipc/semop/semop04.c
diff --git a/testcases/kernel/ipc/semaphore/sem02.c b/testcases/kernel/syscalls/ipc/semop/semop05.c
similarity index 100%
rename from testcases/kernel/ipc/semaphore/sem02.c
rename to testcases/kernel/syscalls/ipc/semop/semop05.c
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
