Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12BAAC433EF
	for <ltp@archiver.kernel.org>; Fri,  4 Feb 2022 13:14:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4EC2E3C9ABE
	for <ltp@archiver.kernel.org>; Fri,  4 Feb 2022 14:14:38 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D16B33C9AC7
 for <ltp@lists.linux.it>; Fri,  4 Feb 2022 14:14:20 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 9610B1A008A3
 for <ltp@lists.linux.it>; Fri,  4 Feb 2022 14:14:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1643980458;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GhlqGN1OksTvPMf9PHhq7dXDcabzfc0/8i5wzOHgFc0=;
 b=G/6LY8wUMV6pDGpDM/ncPaBMRjSzkidCGNIqZMYV1GwWLJFcOG3c8ntqhedbJu11NLETJu
 uYSbVnUfogkt1VfBGuhVWYzYiYI7fhYSL7hS2NQSNpNTXeQNj9u8cfvsOY3a3xEA7GzJfa
 6fhJRA0aCjAIOfmG22g75UsyCCSyN4g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-660-iGkC9yVQNx2hpr0BQv0XXA-1; Fri, 04 Feb 2022 08:14:16 -0500
X-MC-Unique: iGkC9yVQNx2hpr0BQv0XXA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1909381F029
 for <ltp@lists.linux.it>; Fri,  4 Feb 2022 13:14:16 +0000 (UTC)
Received: from janakin.usersys.redhat.com (unknown [10.40.192.58])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9482017001
 for <ltp@lists.linux.it>; Fri,  4 Feb 2022 13:14:15 +0000 (UTC)
From: Jan Stancek <jstancek@redhat.com>
To: ltp@lists.linux.it
Date: Fri,  4 Feb 2022 14:14:01 +0100
Message-Id: <b10d44db50b76cf5332cff491b5f22500b2b88c6.1643980361.git.jstancek@redhat.com>
In-Reply-To: <cover.1643980361.git.jstancek@redhat.com>
References: <cover.1643980361.git.jstancek@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jstancek@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/2] tst_test_macros: add TST_EXP_FAIL_SILENT
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

This variant does not print TPASS messages when
SCALL fails as expected.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 doc/c-test-api.txt        |  3 +++
 include/tst_test_macros.h | 15 ++++++++++-----
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/doc/c-test-api.txt b/doc/c-test-api.txt
index 6f4de3f80f95..9119e094dbfd 100644
--- a/doc/c-test-api.txt
+++ b/doc/c-test-api.txt
@@ -298,6 +298,9 @@ The 'TST_EXP_FAIL2()' is the same as 'TST_EXP_FAIL()' except the return value is
 expected to be non-negative integer if call passes. These macros build upon the
 +TEST()+ macro and associated variables.
 
+'TST_EXP_FAIL_SILENT()' and 'TST_EXP_FAIL2_SILENT()' variants are less verbose
+and do not print TPASS messages when SCALL fails as expected.
+
 [source,c]
 -------------------------------------------------------------------------------
 TEST(socket(AF_INET, SOCK_RAW, 1));
diff --git a/include/tst_test_macros.h b/include/tst_test_macros.h
index ec8c38523344..f7de8d00a666 100644
--- a/include/tst_test_macros.h
+++ b/include/tst_test_macros.h
@@ -163,7 +163,7 @@ extern void *TST_RET_PTR;
 			TST_MSG_(TPASS, " passed", #SCALL, ##__VA_ARGS__);     \
 	} while (0)                                                            \
 
-#define TST_EXP_FAIL_(PASS_COND, SCALL, SSCALL, ERRNO, ...)                    \
+#define TST_EXP_FAIL_(SILENT, PASS_COND, SCALL, SSCALL, ERRNO, ...)            \
 	do {                                                                   \
 		TEST(SCALL);                                                   \
 		                                                               \
@@ -181,8 +181,9 @@ extern void *TST_RET_PTR;
 		}                                                              \
 		                                                               \
 		if (TST_ERR == (ERRNO)) {                                      \
-			TST_MSG_(TPASS | TTERRNO, " ",                         \
-				 SSCALL, ##__VA_ARGS__);                       \
+			if (!SILENT)                                           \
+				TST_MSG_(TPASS | TTERRNO, " ",                 \
+				        SSCALL, ##__VA_ARGS__);                \
 			TST_PASS = 1;                                          \
 		} else {                                                       \
 			TST_MSGP_(TFAIL | TTERRNO, " expected %s",             \
@@ -191,9 +192,13 @@ extern void *TST_RET_PTR;
 		}                                                              \
 	} while (0)
 
-#define TST_EXP_FAIL(SCALL, ERRNO, ...) TST_EXP_FAIL_(TST_RET == 0, SCALL, #SCALL, ERRNO, ##__VA_ARGS__)
+#define TST_EXP_FAIL(SCALL, ERRNO, ...) TST_EXP_FAIL_(0, TST_RET == 0, SCALL, #SCALL, ERRNO, ##__VA_ARGS__)
 
-#define TST_EXP_FAIL2(SCALL, ERRNO, ...) TST_EXP_FAIL_(TST_RET >= 0, SCALL, #SCALL, ERRNO, ##__VA_ARGS__)
+#define TST_EXP_FAIL2(SCALL, ERRNO, ...) TST_EXP_FAIL_(0, TST_RET >= 0, SCALL, #SCALL, ERRNO, ##__VA_ARGS__)
+
+#define TST_EXP_FAIL_SILENT(SCALL, ERRNO, ...) TST_EXP_FAIL_(1, TST_RET == 0, SCALL, #SCALL, ERRNO, ##__VA_ARGS__)
+
+#define TST_EXP_FAIL2_SILENT(SCALL, ERRNO, ...) TST_EXP_FAIL_(1, TST_RET >= 0, SCALL, #SCALL, ERRNO, ##__VA_ARGS__)
 
 #define TST_EXP_EXPR(EXPR, FMT, ...)						\
 	tst_res_(__FILE__, __LINE__, (EXPR) ? TPASS : TFAIL, "Expect: " FMT, ##__VA_ARGS__);
-- 
2.27.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
