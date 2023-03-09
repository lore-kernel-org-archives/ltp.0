Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20DF2C64EC4
	for <ltp@archiver.kernel.org>; Thu,  9 Mar 2023 08:55:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 550B13CD89C
	for <ltp@archiver.kernel.org>; Thu,  9 Mar 2023 09:55:11 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BB4043CB7F1
 for <ltp@lists.linux.it>; Thu,  9 Mar 2023 09:55:01 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 51667200B28
 for <ltp@lists.linux.it>; Thu,  9 Mar 2023 09:54:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678352098;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=WSnW9TKuhVquM8euUjKEokwJpsRr0uhhEUtle2z3qMI=;
 b=UDOIpnbAG3oX5eaL6MzMlidesGSvt2gxba5IOZA8/tiSkZjqxATMfv/LZ/ODpdXAsgCgWd
 vCR3tFE+tYvppCeL4s4XjpL6uBIko0zOTqe9TeVH4BeBSEyZsepM5gF6XhxpBq4KvMVpwC
 7lbRn1hSUGeiMGBo1obny6FBXzGFIcc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-318-F6eDMpXxPn2J2l_m9Qa8nw-1; Thu, 09 Mar 2023 03:54:57 -0500
X-MC-Unique: F6eDMpXxPn2J2l_m9Qa8nw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C3E01857F40
 for <ltp@lists.linux.it>; Thu,  9 Mar 2023 08:54:56 +0000 (UTC)
Received: from nay-workstation.nay.redhat.com (unused-66-82-86.nay.redhat.com
 [10.66.82.86])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D3990440DD
 for <ltp@lists.linux.it>; Thu,  9 Mar 2023 08:54:55 +0000 (UTC)
From: Ping Fang <pifang@redhat.com>
To: ltp@lists.linux.it
Date: Thu,  9 Mar 2023 16:54:54 +0800
Message-Id: <20230309085454.735531-1-pifang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] setfsuid02_16: Fix uid -1 too large for testing
 16-bit version
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

__kernel_old_uid_t is not defined as 16bit on s390, ppc64le
Then -1 will be translated into UINT_MAX fails the size check.
s390, ppc64le use definition in /usr/include/asm-generic/posix_types.h

typedef unsigned int    __kernel_uid_t;
...
typedef __kernel_uid_t  __kernel_old_uid_t;

x86_64, aarch64 use definition in /usr/include/asm/posix_types_64.h
typedef unsigned short __kernel_old_uid_t;

Signed-off-by: Ping Fang <pifang@redhat.com>
---
 testcases/kernel/syscalls/utils/compat_uid.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/utils/compat_uid.h b/testcases/kernel/syscalls/utils/compat_uid.h
index 94e54f310..7a345a654 100644
--- a/testcases/kernel/syscalls/utils/compat_uid.h
+++ b/testcases/kernel/syscalls/utils/compat_uid.h
@@ -26,7 +26,7 @@
 #include "tst_common.h"
 
 #ifdef TST_USE_COMPAT16_SYSCALL
-typedef __kernel_old_uid_t UID_T;
+typedef unsigned short UID_T;
 int UID_SIZE_CHECK(uid_t uid)
 {
 	/* See high2lowuid in linux/highuid.h
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
