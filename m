Return-Path: <SRS0=7Ptb=QG=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1303C433F5
	for <ltp@archiver.kernel.org>; Fri, 19 Nov 2021 07:46:37 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A65661B1B
	for <ltp@archiver.kernel.org>; Fri, 19 Nov 2021 07:46:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1A65661B1B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jv-coder.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A75CF3C89A0
	for <ltp@archiver.kernel.org>; Fri, 19 Nov 2021 08:46:35 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 916C83C891E
 for <ltp@lists.linux.it>; Fri, 19 Nov 2021 08:46:14 +0100 (CET)
Received: from mail.jv-coder.de (mail.jv-coder.de [5.9.79.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 009E5601404
 for <ltp@lists.linux.it>; Fri, 19 Nov 2021 08:46:13 +0100 (CET)
Received: from ubuntu.localdomain (unknown [188.195.115.12])
 by mail.jv-coder.de (Postfix) with ESMTPSA id E9E8B9FD8F;
 Fri, 19 Nov 2021 07:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jv-coder.de; s=dkim;
 t=1637307973; bh=eyIp8tR1te44cf9Z1XM6ms51yrUt2ndYHZYmgPs7KSc=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=uumnPxK80wBf3kuBsjtM/q2dHpiHuJr1TKlFKIgc5wNeAUjw8+hou+rreVthxZI2a
 DyvFsBChfgk7bUG7BjMJEfXCKWS6TiKyFugLul7T6EsKyy54irn3VqOXbXfbSFjvZ9
 erUy5+SXz0PotvLIknHNFZRXRweXcO1QQeJumF9E=
From: Joerg Vehlow <lkml@jv-coder.de>
To: ltp@lists.linux.it
Date: Fri, 19 Nov 2021 08:45:51 +0100
Message-Id: <20211119074602.857595-2-lkml@jv-coder.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211119074602.857595-1-lkml@jv-coder.de>
References: <20211119074602.857595-1-lkml@jv-coder.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 01/12] posix/pthread_create/15-1: Supress warning
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
Cc: Joerg Vehlow <joerg.vehlow@aox-tech.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Joerg Vehlow <joerg.vehlow@aox-tech.de>

generate-makefiles.sh gave the following warning:
conformance/interfaces/pthread_create/15-1.c should be test.

The script has a strange implementation, that just greps for "main" in the c file.
Based on that it decides if the file should be a test or a run-test.
Other tests in the suite including the main-function from testfrmw/threads_scenarii.c
also use a comment, that supresses the message

Signed-off-by: Joerg Vehlow <joerg.vehlow@aox-tech.de>
---
 .../conformance/interfaces/pthread_create/15-1.c                 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_create/15-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_create/15-1.c
index e8c003fd4..a05db679b 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_create/15-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_create/15-1.c
@@ -76,6 +76,7 @@
 /***********************************    Test cases  *****************************************/
 /********************************************************************************************/
 
+/* main is defined in the next file */
 #define STD_MAIN
 #include "../testfrmw/threads_scenarii.c"
 
-- 
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
