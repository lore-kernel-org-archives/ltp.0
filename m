Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AE9CCDB474
	for <ltp@archiver.kernel.org>; Mon, 23 Oct 2023 06:20:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D59CE3CE1AD
	for <ltp@archiver.kernel.org>; Mon, 23 Oct 2023 08:20:04 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 16CE43C84B5
 for <ltp@lists.linux.it>; Mon, 23 Oct 2023 08:19:53 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3287F1000A45
 for <ltp@lists.linux.it>; Mon, 23 Oct 2023 08:19:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698041990;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=6qv8tE/rbOZIjFAj0ey3YhESytJaLOcof1uITD10yaI=;
 b=NY5m4gHAQy45tW3gHVdahtOxpTj1ngtqB3/wQ38JUE6+HRhVvTEvZEBOPEUBofSUcd4O6I
 P+2sbywBpI3IMdra39Ya84T3Jl9Ae44QmOuLPMvJPU40Y1NKPUElTJ4KK9vBTGfYvVPqOG
 G6LnLRXEqpc9GZJu6OdkmCspqW5QWgg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-492-MqBjbLdqPwqnVYiQx3ZuTA-1; Mon, 23 Oct 2023 02:19:48 -0400
X-MC-Unique: MqBjbLdqPwqnVYiQx3ZuTA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5DA16382134A
 for <ltp@lists.linux.it>; Mon, 23 Oct 2023 06:19:48 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.45.225.167])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E9D1240C6F7B
 for <ltp@lists.linux.it>; Mon, 23 Oct 2023 06:19:47 +0000 (UTC)
From: Jan Stancek <jstancek@redhat.com>
To: ltp@lists.linux.it
Date: Mon, 23 Oct 2023 08:15:08 +0200
Message-Id: <2800f26d04df5fdffcff170224154c44b6ebc23f.1698041671.git.jstancek@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH COMMITTED] syscalls/writev07: add note with known
 kernel fixes for this test
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

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/writev/writev07.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/testcases/kernel/syscalls/writev/writev07.c b/testcases/kernel/syscalls/writev/writev07.c
index b725f08db0da..99734025c9bf 100644
--- a/testcases/kernel/syscalls/writev/writev07.c
+++ b/testcases/kernel/syscalls/writev/writev07.c
@@ -18,6 +18,10 @@
  *
  *   See: [RFC] writev() semantics with invalid iovec in the middle
  *        https://marc.info/?l=linux-kernel&m=147388891614289&w=2
+ *
+ * This is also regression test for kernel commits:
+ *   20c64ec83a9f ("iomap: fix a regression for partial write errors")
+ *   3ac974796e5d ("iomap: fix short copy in iomap_write_iter()")
  */
 
 #include <errno.h>
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
