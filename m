Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAD79D132A3
	for <ltp@archiver.kernel.org>; Mon,  4 Nov 2024 09:57:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4313B3D0513
	for <ltp@archiver.kernel.org>; Mon,  4 Nov 2024 10:57:52 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 62B643D02EE
 for <ltp@lists.linux.it>; Mon,  4 Nov 2024 10:57:35 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jstancek@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C72FA1BC846F
 for <ltp@lists.linux.it>; Mon,  4 Nov 2024 10:57:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730714253;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=IWgw8c9HIuEoZ+aI50536aOY+cI281ZmdRC7efbEraE=;
 b=fE+C+/WnKauKLvHNxEoEdO2YjJxHBUsoRhEfS8x91kzsv+LRxkgK0ki/fcdRpJTAlTLnPg
 J61mupBhkfQFqm5BxLGY+9czBfG9DZ4Wdc8nh9xJ19p7ntpMSbTk8biENI63LVwEv1TrGY
 4t83bMOGJ1avW1hAVrqPj4qbpBhuL2A=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-206-tHAI_Up-OeO5cDYRZx-9FA-1; Mon,
 04 Nov 2024 04:57:31 -0500
X-MC-Unique: tHAI_Up-OeO5cDYRZx-9FA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C01631955F4A
 for <ltp@lists.linux.it>; Mon,  4 Nov 2024 09:57:30 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.45.224.81])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DDEDB19560AD
 for <ltp@lists.linux.it>; Mon,  4 Nov 2024 09:57:29 +0000 (UTC)
From: Jan Stancek <jstancek@redhat.com>
To: ltp@lists.linux.it
Date: Mon,  4 Nov 2024 10:57:24 +0100
Message-ID: <a0c8683d576671c055a4fe5edde45b5232a27660.1730714163.git.jstancek@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] lapi/sched.h: don't include itself
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

The header appears to be including itself by mistake.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 include/lapi/sched.h | 1 -
 1 file changed, 1 deletion(-)

Looks trivial to point I'm doubting if I'm missing something.

diff --git a/include/lapi/sched.h b/include/lapi/sched.h
index 8e7748d6e8d8..36f1ecad93c2 100644
--- a/include/lapi/sched.h
+++ b/include/lapi/sched.h
@@ -13,7 +13,6 @@
 #include <inttypes.h>
 #include "config.h"
 #include "lapi/syscalls.h"
-#include "lapi/sched.h"
 
 /* sched_attr is not defined in glibc < 2.41 */
 #ifndef SCHED_ATTR_SIZE_VER0
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
