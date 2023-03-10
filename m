Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16C31C6FA99
	for <ltp@archiver.kernel.org>; Fri, 10 Mar 2023 07:10:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7F10E3CD809
	for <ltp@archiver.kernel.org>; Fri, 10 Mar 2023 08:10:49 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E52523CB707
 for <ltp@lists.linux.it>; Fri, 10 Mar 2023 08:10:39 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4123A6002EA
 for <ltp@lists.linux.it>; Fri, 10 Mar 2023 08:10:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678432237;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=YFauOVOJnktqgiWdmKMk4uaN8URAdXizDzh5RjCufGY=;
 b=GoVCmd0uf5ZkFtelSVgzMkQFiJvG+rmmOIW1DEad4mE3BHliUfvG3DCpyGG3RngVr5J2UX
 XRWZGThiSBCoRMswE2HgRBz5Pa98N/xHnXY8PDoYd25DHQIvzQsWxGMr63MX2SaxeU9UZB
 Ob9vpXiCqlcpDnbZOmu/E/b6ZoX5QO0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-665-sUgq4KK6MG6wgXZOzd_kLg-1; Fri, 10 Mar 2023 02:10:33 -0500
X-MC-Unique: sUgq4KK6MG6wgXZOzd_kLg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8C8ED1C05AC4;
 Fri, 10 Mar 2023 07:10:33 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.45.225.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E47F61121315;
 Fri, 10 Mar 2023 07:10:32 +0000 (UTC)
From: Jan Stancek <jstancek@redhat.com>
To: ltp@lists.linux.it
Date: Fri, 10 Mar 2023 08:10:10 +0100
Message-Id: <fb88846b13f4b0c39c6e3f44b67454f5c3857f6d.1678432077.git.jstancek@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] endian_switch01.c: drop unused main4()
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

Drop the unused main4() and move AT_HWCAP check to check_le_switch_supported().
Tested on RHEL7.9 3.10 based kernel, and RHEL9.0 5.14.0 based kernel.

Acked-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 .../kernel/syscalls/switch/endian_switch01.c    | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/testcases/kernel/syscalls/switch/endian_switch01.c b/testcases/kernel/syscalls/switch/endian_switch01.c
index eae193fc15f2..d965aed56dfd 100644
--- a/testcases/kernel/syscalls/switch/endian_switch01.c
+++ b/testcases/kernel/syscalls/switch/endian_switch01.c
@@ -15,6 +15,7 @@
 #include <stdlib.h>
 #include <unistd.h>
 #include <elf.h>
+#include <sys/auxv.h>
 #include <sys/types.h>
 #include <sys/wait.h>
 #include "tst_test.h"
@@ -40,6 +41,9 @@ void check_le_switch_supported(void)
 		exit(errno);
 	}
 
+	if (!(getauxval(AT_HWCAP) & PPC_FEATURE_TRUE_LE))
+		tst_brk(TCONF, "Processor does not support little-endian mode");
+
 	SAFE_WAIT(&status);
 	if (WIFSIGNALED(status)) {
 		int sig = WTERMSIG(status);
@@ -94,19 +98,6 @@ static struct tst_test test = {
 	.forks_child = 1,
 };
 
-int main4(int argc, char **argv, LTP_ATTRIBUTE_UNUSED char **envp,
-	unsigned long *auxv)
-{
-	for (; *auxv != AT_NULL && *auxv != AT_HWCAP; auxv += 2)
-		;
-
-	if (!(auxv[0] == AT_HWCAP && (auxv[1] & PPC_FEATURE_TRUE_LE)))
-		tst_brk(TCONF, "Processor does not support little-endian mode");
-
-	tst_run_tcases(argc, argv, &test);
-	return 0;
-}
-
 #else /* defined (__powerpc64__) || (__powerpc__) */
 TST_TEST_TCONF("This system does not support running of switch() syscall");
 #endif
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
