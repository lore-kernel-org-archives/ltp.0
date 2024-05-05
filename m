Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BC97C4345F
	for <ltp@archiver.kernel.org>; Sun,  5 May 2024 11:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1714907111; h=mime-version :
 message-id : to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=qtbZheEEQq251QUHamaIFo9bBQvIvp7HVhtejhkwC9A=;
 b=aJF4i7kVdhcOy4R1IFlvqqzXNyzujE9njR+iKB8Tt9pUs4xJyek7trDIVIdVAlc7cJnem
 2dIN/xA2uTQUY73eo3XlKQ0N21gLiAgs/PgIgrajid7nwH7C3r9V6CQK3KA1HQs1z5RSfxr
 6n5hDVEEsvlVVXXs5YGMw+u3SL/PwbM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EE05F3CD966
	for <ltp@archiver.kernel.org>; Sun,  5 May 2024 13:05:10 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2B50D3CD657
 for <ltp@lists.linux.it>; Sun,  5 May 2024 13:04:49 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=web.de
 (client-ip=212.227.15.3; helo=mout.web.de; envelope-from=wine.dev@web.de;
 receiver=lists.linux.it)
Received: from mout.web.de (mout.web.de [212.227.15.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits)
 server-digest SHA256) (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 4D1D410060B4
 for <ltp@lists.linux.it>; Sun,  5 May 2024 13:04:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1714907088; x=1715511888; i=wine.dev@web.de;
 bh=/9YjdNIZsshtrUFCxlMGz9sbm5RmFY8Nyh9wYJOzCSA=;
 h=X-UI-Sender-Class:MIME-Version:Message-ID:From:To:Subject:
 Content-Type:Date:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=SqTqERtelHqV27yai/NyCi/qdIMx5poWZun2ehRAeTCk5jNpqz+NMEr1OT7MW1kC
 XxD4yqiWZ/+kQvi5IN5G0xddNQqpS5EEp9AlOyqC06PDFmES5lia2MZxd1SyROasE
 mzmj6IbaIQZ9FsA2+X1rxjYi7QiFyZMBSMIHvNEYz06rYQL7EuePU6HwabLRIN+ZQ
 MLY9YLvqBUhkdnkjJBPMgAYVGMMA+dhKiHMDzR1OC0QXiXQDOdUGiBHLPf9iGmihq
 GADYySoAElT9X3Q2IvX8plLYOcojSGHMJqndORb2AqMudLzKi8k5poXsYaelg83IR
 eAqvYDs+pYMEF7pQFQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [79.232.214.172] ([79.232.214.172]) by web-mail.web.de
 (3c-app-webde-bs13.server.lan [172.19.170.13]) (via HTTP); Sun, 5 May 2024
 13:04:48 +0200
MIME-Version: 1.0
Message-ID: <trinity-3d4cbcc6-9f74-4c0e-a556-de3b554a217a-1714907088044@3c-app-webde-bs13>
To: ltp@lists.linux.it
Date: Sun, 5 May 2024 13:04:48 +0200
Importance: normal
Sensitivity: Normal
X-Priority: 3
X-Provags-ID: V03:K1:CcOUwexgMPufAAQ+fXe0c0IVsl3BVTH8/Vau3e8GYKq7GbMthhlT0ThV6NpB87UEXIFM0
 9fMv5WQPUjSy2cK/wrT1AgbrA3xT6EPf9hWZqI5ryRbkVcc+THRVewKnbnN4989+gShFrZqufsFZ
 zfe7feD8RSQZtwWarBO1dnup6vIz3ddKNynhiohaako2qjOgeRdChPAlGjpu91/afkNFrPB5UAVc
 /LKA1kd6/AayN+kG0zHjdMmBe++ABmTXSQ1quR05bQaUBNcPvAxUffXKb4Mq7f9PAHQGQ7X4oH+0
 Sg=
UI-OutboundReport: notjunk:1;M01:P0:5jS6culgZzo=;Y2OlPZLOMdcZ1e6jFj4i+jCgbQb
 ZeHG3kOxjFSfllcGiW2T1opWaQ13YNsYPIHvNO7T+QHLIrFkKxkZhFeqhRZzxdx7WYOxY+TMX
 XfiFM2SZEj0ciyfvtHKvIiZPCdEGqJuSNRZFPjAMdCnWVmRDmFuCOsVoRhOjx08ZNpwcFY6J4
 iqNS4Vf431Kv9wKcBM78RkVIPRMgRxScJapGqbFi2Grdr6cfN7GGDNInnnrM8V6PCTyYWBJAP
 of/+TUzbSCZJUOA06SZFakZMAry6Qxuvs9vOUd5btUYnpFnMa8F8zxeAExgAvj5+L2U1sQU6Z
 HN2veS4oAXbRTIybz9eII144Lle4siJFpAffdC77CrFoBWbEmtfvd7aVS2PZPhldtHXVV39sO
 oI+tdXs2JCkjO0En/hMHdhe9O6lSplMiThqogfeyiwtq2ugHUmn1EOLco83lQHyJLNqkCPsPR
 aP1VyvmqgJ86DcvjaxfY1DI+5wKyjKp3k4KwJ6KruGPjT4JxmoGbFkazhBFY4FRwSqLC28EPr
 o+bS7U+UhwJba9yPiAFNJwFi3qp8laR7mxSUYvcqTT+lIMX38FsEWtCF/UR6AukTNwedXVhEH
 KojJcztfctViwyVblCP9Zq/d1JkCEZ6I0HANRlg7Ot6AbMeLhhVdnuGNoyZa1bplGx2oZIHg9
 QeE8y+5BncXlwmLT+QPPAGjuXtuuiLHSVZX5V16u75D2tmxBDR9gwk7+e4L9Fdw=
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] open_posix_testsuite: Avoid non portable GCC
 extensions without a guard
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
From: Detlef Riekenberg via ltp <ltp@lists.linux.it>
Reply-To: Detlef Riekenberg <wine.dev@web.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The GCC extension "__attribute__" breaks other compiler
and produces 458 test failures.


--
Regards ... Detlef

Signed-off-by: Detlef Riekenberg <wine.dev@web.de>
---
 .../open_posix_testsuite/include/posixtest.h  | 27 ++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/testcases/open_posix_testsuite/include/posixtest.h b/testcases/open_posix_testsuite/include/posixtest.h
index d1b298488..07979b736 100644
--- a/testcases/open_posix_testsuite/include/posixtest.h
+++ b/testcases/open_posix_testsuite/include/posixtest.h
@@ -20,9 +20,30 @@
 #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof(arr[0]))
 #endif

-#define PTS_ATTRIBUTE_NORETURN		__attribute__((noreturn))
-#define PTS_ATTRIBUTE_UNUSED		__attribute__((unused))
-#define PTS_ATTRIBUTE_UNUSED_RESULT	__attribute__((warn_unused_result))
+/* __attribute__ is a non portable gcc extension */
+/* TODO: Add support for C23 attributes */
+#if defined __has_attribute
+#  if __has_attribute(noreturn)
+#    define PTS_ATTRIBUTE_NORETURN      __attribute__((noreturn))
+#  endif
+#  if __has_attribute(unused)
+#    define PTS_ATTRIBUTE_UNUSED        __attribute__((unused))
+#  endif
+#  if __has_attribute(warn_unused_result)
+#    define PTS_ATTRIBUTE_UNUSED_RESULT __attribute__((warn_unused_result))
+#  endif
+#endif
+
+#ifndef PTS_ATTRIBUTE_NORETURN
+#define PTS_ATTRIBUTE_NORETURN
+#endif
+#ifndef PTS_ATTRIBUTE_UNUSED
+#define PTS_ATTRIBUTE_UNUSED
+#endif
+#ifndef PTS_ATTRIBUTE_UNUSED_RESULT
+#define PTS_ATTRIBUTE_UNUSED_RESULT
+#endif
+

 #define PTS_WRITE_MSG(msg) do { \
          if (write(STDOUT_FILENO, msg, sizeof(msg) - 1)) { \
--
2.40.1



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
