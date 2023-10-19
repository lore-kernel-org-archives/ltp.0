Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64327CDB465
	for <ltp@archiver.kernel.org>; Thu, 19 Oct 2023 08:56:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 709873CF54D
	for <ltp@archiver.kernel.org>; Thu, 19 Oct 2023 10:56:48 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CB73C3C84B2
 for <ltp@lists.linux.it>; Thu, 19 Oct 2023 10:56:38 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 02F1C1A027A5
 for <ltp@lists.linux.it>; Thu, 19 Oct 2023 10:56:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697705796;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=hjA0kU+AkV7hgdiMtV6QXl3Lms3nHYRMlAYFGcvZYEk=;
 b=WOiXPyEP1RR9zwfy0UkIX2QZ3VFrI5rT8cwJPg9Ni62DBoOuvAbQIfFw5K42PDZM36fLQr
 e6F/Sgs8dsDD4VtTouZPvJ2vkFC7guw5thUszFoSZs+Qmn/EtO6zZ6Wwrjjg97OiR+aak8
 FXPDSU/0Y+Dk1IczwIQ0uXjnB6DY6oA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-3-k3gs8sf_PeiT_V6I0MPy2A-1; Thu, 19 Oct 2023 04:56:32 -0400
X-MC-Unique: k3gs8sf_PeiT_V6I0MPy2A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 19B88380670E
 for <ltp@lists.linux.it>; Thu, 19 Oct 2023 08:56:32 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.45.225.167])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A35A11C060AE
 for <ltp@lists.linux.it>; Thu, 19 Oct 2023 08:56:31 +0000 (UTC)
From: Jan Stancek <jstancek@redhat.com>
To: ltp@lists.linux.it
Date: Thu, 19 Oct 2023 10:51:53 +0200
Message-Id: <272dd7b41f4e1049c7428d2de2ac97814ed900ba.1697705468.git.jstancek@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/process_madvise01: fix smaps scan and
 min_swap_avail
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

smaps matching can prematurely end, because the comparison to "VmFlags"
string is not exact. So depending on address on line, it can break
before it finds Swap line. This makes the test fail on recent aarch64
kernels.

min_swap_avail per documentation is in MB not KB.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/process_madvise/process_madvise.h   | 2 +-
 testcases/kernel/syscalls/process_madvise/process_madvise01.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/process_madvise/process_madvise.h b/testcases/kernel/syscalls/process_madvise/process_madvise.h
index c4570e5309de..5b227ada099e 100644
--- a/testcases/kernel/syscalls/process_madvise/process_madvise.h
+++ b/testcases/kernel/syscalls/process_madvise/process_madvise.h
@@ -54,7 +54,7 @@ static inline void read_address_mapping(unsigned long address, struct addr_mappi
 		if (!found)
 			continue;
 
-		if (found && strcmp(line, "VmFlags") >= 0)
+		if (found && strncmp(line, "VmFlags", 7) == 0)
 			break;
 
 		if (sscanf(line, "%31[^:]: %d", label, &value) > 0) {
diff --git a/testcases/kernel/syscalls/process_madvise/process_madvise01.c b/testcases/kernel/syscalls/process_madvise/process_madvise01.c
index 322b4cf60353..0fd3c1ef4f80 100644
--- a/testcases/kernel/syscalls/process_madvise/process_madvise01.c
+++ b/testcases/kernel/syscalls/process_madvise/process_madvise01.c
@@ -123,7 +123,7 @@ static struct tst_test test = {
 	.min_kver = "5.10",
 	.needs_checkpoints = 1,
 	.needs_root = 1,
-	.min_swap_avail = MEM_CHILD / TST_KB,
+	.min_swap_avail = MEM_CHILD / TST_MB,
 	.needs_kconfigs = (const char *[]) {
 		"CONFIG_SWAP=y",
 		NULL
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
