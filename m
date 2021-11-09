Return-Path: <SRS0=8di7=P4=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30FC0C433EF
	for <ltp@archiver.kernel.org>; Tue,  9 Nov 2021 13:09:44 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D7CD61105
	for <ltp@archiver.kernel.org>; Tue,  9 Nov 2021 13:09:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8D7CD61105
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CA0173C0889
	for <ltp@archiver.kernel.org>; Tue,  9 Nov 2021 14:09:41 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9F3233C08CE
 for <ltp@lists.linux.it>; Tue,  9 Nov 2021 14:09:20 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7D1641001567
 for <ltp@lists.linux.it>; Tue,  9 Nov 2021 14:09:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1636463358;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AzvbXr+EOdQYuhWjiw4exns9/MJqBNyCFOl9PoRGsN8=;
 b=V3fM1qbizeHMFHjxGK1VlNGT2kXm/u2fD2kfybUfWV9JE601GRrt63nm1o8diVPa1sjRGV
 B4BrSFMnDkKUgtlpLOgN9KGNfKkquNpMwMdMOzQkmYivYWhKY1AtcaiYNOQWof0SuJLDwN
 p6kIONmR3owyncOStGIAmVNKBkrUSYQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-548-YDkSi4DDN7G-j7m9SUx35Q-1; Tue, 09 Nov 2021 08:09:16 -0500
X-MC-Unique: YDkSi4DDN7G-j7m9SUx35Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 27E40100C660
 for <ltp@lists.linux.it>; Tue,  9 Nov 2021 13:09:16 +0000 (UTC)
Received: from liwang-workstation.nay.redhat.com (unknown [10.66.81.187])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 575EE5D9DE
 for <ltp@lists.linux.it>; Tue,  9 Nov 2021 13:09:15 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Tue,  9 Nov 2021 21:09:10 +0800
Message-Id: <20211109130910.1583233-3-liwang@redhat.com>
In-Reply-To: <20211109130910.1583233-1-liwang@redhat.com>
References: <20211109130910.1583233-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 3/3] max_map_count: replace ifdefs by tst_arch
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
---
 testcases/kernel/mem/tunable/max_map_count.c | 46 ++++++++++----------
 1 file changed, 24 insertions(+), 22 deletions(-)

diff --git a/testcases/kernel/mem/tunable/max_map_count.c b/testcases/kernel/mem/tunable/max_map_count.c
index 4f0ad0037..bd5af0ff6 100644
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
+	case TST_I386:
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
