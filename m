Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73C50C19776
	for <ltp@archiver.kernel.org>; Fri, 28 Feb 2025 09:15:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 07E703C9D0D
	for <ltp@archiver.kernel.org>; Fri, 28 Feb 2025 10:15:21 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1A26A3C93B5
 for <ltp@lists.linux.it>; Fri, 28 Feb 2025 10:15:04 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwang@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 345F6656FEC
 for <ltp@lists.linux.it>; Fri, 28 Feb 2025 10:15:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740734101;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=kUhWI68fsHxI2dDXCBF2uflHZKWOdQqkIsaj34RZqA8=;
 b=dy4TvoQ9sgxAX39+iDIXKSo+yAFn39/FDIQ1o2NIQDaFPsv4djh5cs8OwATNDcAf3/jPHH
 0XPggvUMl+tkH5kO352vDe4e1FLiNiu3Wh/peD775LI9aOiWBhc0QnpKI62J65ISEdS2rP
 oexBk1yfjtmeUlcp2ifoP9oFJxt6HpQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-43-muHKM9lqNZqQEKSsm7QDsg-1; Fri,
 28 Feb 2025 04:14:59 -0500
X-MC-Unique: muHKM9lqNZqQEKSsm7QDsg-1
X-Mimecast-MFC-AGG-ID: muHKM9lqNZqQEKSsm7QDsg_1740734098
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4DE7F18004A7
 for <ltp@lists.linux.it>; Fri, 28 Feb 2025 09:14:58 +0000 (UTC)
Received: from dell-per7425-02.rhts.eng.pek2.redhat.com
 (dell-per7425-02.rhts.eng.pek2.redhat.com [10.73.116.18])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0899119560AE
 for <ltp@lists.linux.it>; Fri, 28 Feb 2025 09:14:56 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Fri, 28 Feb 2025 17:14:51 +0800
Message-ID: <20250228091451.579579-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -NhRN55_nuKkkqc7JXB8PjGQZrlYc07WdLe3gx9R59M_1740734098
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] resource: explicitly define _LARGEFILE64_SOURCE
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

Fix compilation errors on Alpine Linux (musl) by explicitly defining
_LARGEFILE64_SOURCE instead of _GNU_SOURCE. This ensures that 64-bit
resource limit structures (e.g., struct rlimit64) are properly exposed
in <sys/resource.h>.

To resolve the compiling error on Alpine:
  https://github.com/linux-test-project/ltp/actions/runs/13580985467/job/37966850497

Fixes: de44d81d1f5 ("setrlimit06: cover the setting resource limit64")
Signed-off-by: Li Wang <liwang@redhat.com>
---
 include/lapi/resource.h                           | 2 +-
 testcases/kernel/syscalls/setrlimit/setrlimit06.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/lapi/resource.h b/include/lapi/resource.h
index 7c4530523..fec03d83b 100644
--- a/include/lapi/resource.h
+++ b/include/lapi/resource.h
@@ -7,7 +7,7 @@
 #ifndef LAPI_RESOURCE_H__
 #define LAPI_RESOURCE_H__
 
-#define _GNU_SOURCE
+#define _LARGEFILE64_SOURCE
 
 #include <sys/resource.h>
 #include "config.h"
diff --git a/testcases/kernel/syscalls/setrlimit/setrlimit06.c b/testcases/kernel/syscalls/setrlimit/setrlimit06.c
index b587e250c..e8e378182 100644
--- a/testcases/kernel/syscalls/setrlimit/setrlimit06.c
+++ b/testcases/kernel/syscalls/setrlimit/setrlimit06.c
@@ -16,7 +16,7 @@
  * c3bca5d450b62 ("posix-cpu-timers: Ensure set_process_cpu_timer is always evaluated")
  */
 
-#define _GNU_SOURCE
+#define _LARGEFILE64_SOURCE
 #include <errno.h>
 #include <sys/types.h>
 #include <unistd.h>
-- 
2.48.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
