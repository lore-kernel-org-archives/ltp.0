Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7097FC43334
	for <ltp@archiver.kernel.org>; Tue, 21 Jun 2022 07:05:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5A3FA3C940F
	for <ltp@archiver.kernel.org>; Tue, 21 Jun 2022 09:05:34 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4717C3C0F84
 for <ltp@lists.linux.it>; Tue, 21 Jun 2022 09:05:24 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 3DED21A0090C
 for <ltp@lists.linux.it>; Tue, 21 Jun 2022 09:05:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1655795121;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=FyUjsvD78YYJgD04brdtTzG/pR/lAFlBbPw11JI7xj0=;
 b=Zrf36KNxPQ8aZ7d20n0iV8pKFM8WPBPRK7LtU24LdFcnSlTC0JTkQ9tSbTGELdSeubm5Ya
 QGRGMZxw+vZxvaaoNVxEe8NsJujK4isCjqTUVduHWXyt5Krxh/dMIzxVjMbv+uj8rWpMKz
 HOKsL0tllrr5ASulNKX1sYl7ttN0gi0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-651-2ob3w2yMNZmTufHNEvEipw-1; Tue, 21 Jun 2022 03:05:20 -0400
X-MC-Unique: 2ob3w2yMNZmTufHNEvEipw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0D5DB80029D
 for <ltp@lists.linux.it>; Tue, 21 Jun 2022 07:05:20 +0000 (UTC)
Received: from janakin.usersys.redhat.com (unknown [10.40.195.95])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A34E3492CA3
 for <ltp@lists.linux.it>; Tue, 21 Jun 2022 07:05:19 +0000 (UTC)
From: Jan Stancek <jstancek@redhat.com>
To: ltp@lists.linux.it
Date: Tue, 21 Jun 2022 09:05:16 +0200
Message-Id: <2873e7f25ac44d2c103a030bfc5f1d30e0fe80a9.1655795105.git.jstancek@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jstancek@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/migrate_pages03: restore runtime to 5m
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

Arches with large pages have trouble completing all loops in 30s,
restore runtime to 5m.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/migrate_pages/migrate_pages03.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/syscalls/migrate_pages/migrate_pages03.c b/testcases/kernel/syscalls/migrate_pages/migrate_pages03.c
index c6afb4cce05d..ce1aa5be421d 100644
--- a/testcases/kernel/syscalls/migrate_pages/migrate_pages03.c
+++ b/testcases/kernel/syscalls/migrate_pages/migrate_pages03.c
@@ -134,6 +134,7 @@ static void migrate_test(void)
 }
 
 static struct tst_test test = {
+	.max_runtime = 300,
 	.min_kver = "2.6.32",
 	.needs_root = 1,
 	.setup = setup,
-- 
2.27.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
