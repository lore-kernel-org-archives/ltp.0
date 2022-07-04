Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADE1CCCA479
	for <ltp@archiver.kernel.org>; Mon,  4 Jul 2022 10:03:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1FA0C3C9FDE
	for <ltp@archiver.kernel.org>; Mon,  4 Jul 2022 12:03:03 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D381F3C9C35
 for <ltp@lists.linux.it>; Mon,  4 Jul 2022 12:02:52 +0200 (CEST)
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
 by in-3.smtp.seeweb.it (Postfix) with ESMTP id 8560C1A00886
 for <ltp@lists.linux.it>; Mon,  4 Jul 2022 12:02:50 +0200 (CEST)
IronPort-Data: =?us-ascii?q?A9a23=3AVdz/ha+xMlc/De3WyQbkDrUDkXyTJUtcMsCJ2f8?=
 =?us-ascii?q?bfWQNrUok0DwCmmsWCm2CP/uOYWX3e9t2a4+0oUgF78WBztZkTldlrnsFo1Bi8?=
 =?us-ascii?q?5ScXYvDRqvT04J+FuWaFQQ/qZx2huDodKjYdVeB4Ef9WlTdhSMkj/vQHOKlULe?=
 =?us-ascii?q?s1h1ZHmeIdg9w0HqPpMZp2uaEsfDha++8kYuaT//3YTdJ6BYoWo4g0J9vnTs01?=
 =?us-ascii?q?BjEVJz0iXRlDRxDlAe2e3D4l/vzL4npR5fzatE88uJX24/+IL+FEmPxp3/BC/u?=
 =?us-ascii?q?ulPD1b08LXqXPewOJjxK6WYD72l4b+HN0if19aZLwam8O49mNt9txxdNNpdq+T?=
 =?us-ascii?q?xw1FqPRmuUBSAQeGCZ7VUFD0OadfiLm4ZfLkCUqdFOpmZ2CFnoeOZEA0uJ2Gn1?=
 =?us-ascii?q?Vs/gZLi0dKBGf799aaprTpvJE35xldZe0ethE/CwI8N0QNt5+KbirfkkAzYYwM?=
 =?us-ascii?q?O8Mu/1z?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3ATFGcSK4t1k2oXpzzJAPXwDnXdLJyesId70hD?=
 =?us-ascii?q?6qkXc20xTiX4rbHLoB11737JYVoqNE3I+urwWpVoI0m9yXcd2+B4Vt3OYOCMgg?=
 =?us-ascii?q?WVxe9ZgrcKuweQeBEW6NQtrZtIQuxvDsHqF1hmgYLf6Am8Kdwpx96K68mT9IHj?=
 =?us-ascii?q?5kYoXQd3cLth8gs8Lg6aF3d9TA5ACYF8O4Gb4qN81kOdUEVSfsKmHWMEQuSGg9?=
 =?us-ascii?q?XKkajtaRkACwViyCTmt0LO1ILH?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; d="scan'208";a="127218307"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
 by heian.cn.fujitsu.com with ESMTP; 04 Jul 2022 18:02:48 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
 by cn.fujitsu.com (Postfix) with ESMTP id D773E4D17179
 for <ltp@lists.linux.it>; Mon,  4 Jul 2022 18:02:43 +0800 (CST)
Received: from G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Mon, 4 Jul 2022 18:02:42 +0800
Received: from G08FNSTD200033.g08.fujitsu.local (10.167.225.189) by
 G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Mon, 4 Jul 2022 18:02:46 +0800
From: Chen Hanxiao <chenhx.fnst@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Mon, 4 Jul 2022 18:02:43 +0800
Message-ID: <20220704100243.844-1-chenhx.fnst@fujitsu.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
X-yoursite-MailScanner-ID: D773E4D17179.AD7E5
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: chenhx.fnst@fujitsu.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] docparse/Makefile: fix a typo
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

s/not not/not

Signed-off-by: Chen Hanxiao <chenhx.fnst@fujitsu.com>
---
 docparse/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docparse/Makefile b/docparse/Makefile
index e6e9f05ba..20851fba6 100644
--- a/docparse/Makefile
+++ b/docparse/Makefile
@@ -19,7 +19,7 @@ METADATA_GENERATOR_PARAMS_HTML := -f xhtml
 METADATA_GENERATOR_PARAMS_PDF := -f pdf
 METADATA_GENERATOR_PARAMS_HTML_CHUNKED := -f chunked
 else ifeq ($(METADATA_GENERATOR),)
-$(error 'METADATA_GENERATOR' not not configured, run ./configure in the root directory)
+$(error 'METADATA_GENERATOR' not configured, run ./configure in the root directory)
 else
 $(error '$(METADATA_GENERATOR)' not supported, only asciidoctor and asciidoc are supported)
 endif
-- 
2.18.1




-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
