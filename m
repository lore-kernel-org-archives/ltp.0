Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0964C433F5
	for <ltp@archiver.kernel.org>; Tue,  7 Dec 2021 10:29:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 05F1C3C4BF9
	for <ltp@archiver.kernel.org>; Tue,  7 Dec 2021 11:29:46 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2037F3C285B
 for <ltp@lists.linux.it>; Tue,  7 Dec 2021 11:29:17 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 9F6C02000A3
 for <ltp@lists.linux.it>; Tue,  7 Dec 2021 11:29:16 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 0F6C91FD2F;
 Tue,  7 Dec 2021 10:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1638872956; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z55LL4sRdkJJ1aOYg1M3qkRYCmNwO7s3l64fbu9i5Ac=;
 b=BNEe4AtXXvHp2yLK/S5nU2N3a7uf43h3CbsESq9OyQ1Ny0AjLkUBHnsmPIsrlJfFLm+tN2
 O3fn/K1Y0G52c6ylfPUyocfHcOjt6yGIQxn/xfLhCXlPcSmvLhsazXc0dLf8OWGhV3nG+7
 pfsDX0qYYTUer3b0kq8zs1EoGBkBEVU=
Received: from g78.suse.de (rpalethorpe.tcp.ovpn1.nue.suse.de [10.163.17.14])
 by relay2.suse.de (Postfix) with ESMTP id C14AAA3B8B;
 Tue,  7 Dec 2021 10:29:15 +0000 (UTC)
To: ltp@lists.linux.it
Date: Tue,  7 Dec 2021 10:29:04 +0000
Message-Id: <20211207102904.6011-3-rpalethorpe@suse.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211207102904.6011-1-rpalethorpe@suse.com>
References: <20211207102904.6011-1-rpalethorpe@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 3/3] getrusage03,
 setsockopt03: Add sentinel value to tags
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
From: Richard Palethorpe via ltp <ltp@lists.linux.it>
Reply-To: Richard Palethorpe <rpalethorpe@suse.com>
Cc: Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

LTP-005

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 testcases/kernel/syscalls/getrusage/getrusage03.c   | 1 +
 testcases/kernel/syscalls/setsockopt/setsockopt03.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/testcases/kernel/syscalls/getrusage/getrusage03.c b/testcases/kernel/syscalls/getrusage/getrusage03.c
index ef2f62a18..bf5127483 100644
--- a/testcases/kernel/syscalls/getrusage/getrusage03.c
+++ b/testcases/kernel/syscalls/getrusage/getrusage03.c
@@ -180,6 +180,7 @@ static struct tst_test test = {
 	.min_kver = "2.6.32",
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "1f10206cf8e9"},
+		{}
 	},
 	.test = run,
 	.tcnt = ARRAY_SIZE(testfunc_list),
diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt03.c b/testcases/kernel/syscalls/setsockopt/setsockopt03.c
index b7a4447ba..191c4cdfe 100644
--- a/testcases/kernel/syscalls/setsockopt/setsockopt03.c
+++ b/testcases/kernel/syscalls/setsockopt/setsockopt03.c
@@ -81,5 +81,6 @@ static struct tst_test test = {
 	.tags = (const struct tst_tag[]){
 		{"linux-git", "ce683e5f9d04"},
 		{"CVE", "CVE-2016-4997"},
+		{}
 	}
 };
-- 
2.34.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
