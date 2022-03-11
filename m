Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4427C433F5
	for <ltp@archiver.kernel.org>; Fri, 11 Mar 2022 05:46:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2E1D53C887F
	for <ltp@archiver.kernel.org>; Fri, 11 Mar 2022 06:46:57 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 510EE3C8B13
 for <ltp@lists.linux.it>; Fri, 11 Mar 2022 06:46:17 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id BC1071A01473
 for <ltp@lists.linux.it>; Fri, 11 Mar 2022 06:46:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646977575;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vsRbbIAeyr7ZCI1p8Z2qjD/XOFXju7z+bGKbMUsEJIo=;
 b=VhS9B3ksjDa60AkMMBpApg1vkyKYXdEUjZ/PqDeZDn3d7FiWHfb4pQermIDAzYLJJGIhko
 dLYIEMjuQFEmSexhIeGuC64X6hoDAKr4TumXJn2OnotuYbqTmlDGNIrHG3C0ohGzKLnikw
 nAXy/yq0JYkQoVzYpFsa3w+5GX2iFrI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-312-fdUF7I01PRKSVVJbBOSLqQ-1; Fri, 11 Mar 2022 00:46:11 -0500
X-MC-Unique: fdUF7I01PRKSVVJbBOSLqQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C4C591091DA1
 for <ltp@lists.linux.it>; Fri, 11 Mar 2022 05:46:10 +0000 (UTC)
Received: from liwang-workstation.nay.redhat.com (unknown [10.66.81.187])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C1024108D4;
 Fri, 11 Mar 2022 05:46:09 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Fri, 11 Mar 2022 13:46:02 +0800
Message-Id: <20220311054603.57328-3-liwang@redhat.com>
In-Reply-To: <20220311054603.57328-1-liwang@redhat.com>
References: <20220311054603.57328-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/3] lib: adding unnecessary pointer comparison
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

The intention is to ensure that _a and _b have compatible type by
comparing their addresses; only if _a and _b have compatible types
will pointers to them have compatible type. The result of the
comparison is ignored, so the only effect is to provoke a diagnostic
from the compiler if _a and _b have incompatible types.

The goal is to avoid taking the minimum/maximum of values of different
types, because the result can be surprising.

Btw, I don't think we need to port the latest version of min/max from
linux/include/linux/minmax.h because it has an additional constant
expression checker. Actually, we (LTP) do have some tests pass variable
to MIN/MAX and it should _not_ be working at that senario.

Signed-off-by: Li Wang <liwang@redhat.com>
Cc: Chunyu Hu <chuhu@redhat.com>
---
 include/tst_minmax.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/tst_minmax.h b/include/tst_minmax.h
index 6417dd703..9d7d596fc 100644
--- a/include/tst_minmax.h
+++ b/include/tst_minmax.h
@@ -9,6 +9,7 @@
 # define MIN(a, b) ({ \
 	typeof(a) _a = (a); \
 	typeof(b) _b = (b); \
+	(void) (&_a == &_b); \
 	_a < _b ? _a : _b; \
 })
 #endif /* MIN */
@@ -17,6 +18,7 @@
 # define MAX(a, b) ({ \
 	typeof(a) _a = (a); \
 	typeof(b) _b = (b); \
+	(void) (&_a == &_b); \
 	_a > _b ? _a : _b; \
 })
 #endif /* MAX */
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
