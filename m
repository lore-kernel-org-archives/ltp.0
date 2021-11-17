Return-Path: <SRS0=ZNpR=QE=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A02F0C433F5
	for <ltp@archiver.kernel.org>; Wed, 17 Nov 2021 07:07:40 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EE5F61BE5
	for <ltp@archiver.kernel.org>; Wed, 17 Nov 2021 07:07:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1EE5F61BE5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6DFC53C87DB
	for <ltp@archiver.kernel.org>; Wed, 17 Nov 2021 08:07:38 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 778F73C0BB4
 for <ltp@lists.linux.it>; Wed, 17 Nov 2021 08:07:18 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E625F1A014B4
 for <ltp@lists.linux.it>; Wed, 17 Nov 2021 08:07:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637132836;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cTBpqqVFtTKp4nenvIAM62WfwaK5oagg0HZJi4VMZPg=;
 b=UmWCBxAoFlOjkL39xTyf7L8ryl0nnq3yZzYtkAg86IXLg4aiWUnSpumBWHdInKkPSR87qB
 HojTQH+te2O45ZsjNJBFdI9xy4GzaeoStopfxJO8kHO0WkZvsZ1yNXc13OX2TI8IPl4QRE
 kjcleeY+ElJTute5AnIJ+8Gw3lxQ2i8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-zlL1nbS4M0eV56ELPskghg-1; Wed, 17 Nov 2021 02:07:15 -0500
X-MC-Unique: zlL1nbS4M0eV56ELPskghg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5D4DA1922961;
 Wed, 17 Nov 2021 07:07:14 +0000 (UTC)
Received: from liwang-workstation.nay.redhat.com (unknown [10.66.81.187])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4BCC35F4E0;
 Wed, 17 Nov 2021 07:07:13 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Wed, 17 Nov 2021 15:07:08 +0800
Message-Id: <20211117070708.2174932-3-liwang@redhat.com>
In-Reply-To: <20211117070708.2174932-1-liwang@redhat.com>
References: <20211117070708.2174932-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 3/3] max_map_count: replace ifdefs by tst_arch
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

Signed-off-by: Li Wang <liwang@redhat.com>
Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/mem/tunable/max_map_count.c | 46 ++++++++++----------
 1 file changed, 24 insertions(+), 22 deletions(-)

diff --git a/testcases/kernel/mem/tunable/max_map_count.c b/testcases/kernel/mem/tunable/max_map_count.c
index 4f0ad0037..a4c3dbf8e 100644
--- a/testcases/kernel/mem/tunable/max_map_count.c
+++ b/testcases/kernel/mem/tunable/max_map_count.c
@@ -55,7 +55,6 @@
 
 static long old_max_map_count = -1;
 static long old_overcommit = -1;
-static struct utsname un;
 
 static void setup(void)
 {
@@ -66,9 +65,6 @@ static void setup(void)
 	old_max_map_count = get_sys_tune("max_map_count");
 	old_overcommit = get_sys_tune("overcommit_memory");
 	set_sys_tune("overcommit_memory", 0, 1);
-
-	if (uname(&un) != 0)
-		tst_brk(TBROK | TERRNO, "uname error");
 }
 
 static void cleanup(void)
@@ -91,24 +87,30 @@ static bool filter_map(const char *line)
 	if (ret != 1)
 		return false;
 
-#if defined(__x86_64__) || defined(__x86__)
-	/* On x86, there's an old compat vsyscall page */
-	if (!strcmp(buf, "[vsyscall]"))
-		return true;
-#elif defined(__ia64__)
-	/* On ia64, the vdso is not a proper mapping */
-	if (!strcmp(buf, "[vdso]"))
-		return true;
-#elif defined(__arm__)
-	/* Skip it when run it in aarch64 */
-	if ((!strcmp(un.machine, "aarch64"))
-	|| (!strcmp(un.machine, "aarch64_be")))
-		return false;
-
-	/* Older arm kernels didn't label their vdso maps */
-	if (!strncmp(line, "ffff0000-ffff1000", 17))
-		return true;
-#endif
+	switch (tst_arch.type) {
+	case TST_X86:
+	case TST_X86_64:
+		/* On x86, there's an old compat vsyscall page */
+		if (!strcmp(buf, "[vsyscall]"))
+			return true;
+		break;
+	case TST_IA64:
+		/* On ia64, the vdso is not a proper mapping */
+		if (!strcmp(buf, "[vdso]"))
+			return true;
+		break;
+	case TST_ARM:
+		/* Skip it when run it in aarch64 */
+		if (tst_kernel_bits() == 64)
+			return false;
+
+		/* Older arm kernels didn't label their vdso maps */
+		if (!strncmp(line, "ffff0000-ffff1000", 17))
+			return true;
+		break;
+	default:
+		break;
+	};
 
 	return false;
 }
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
