Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8674C00140
	for <ltp@archiver.kernel.org>; Thu, 18 Aug 2022 07:40:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 976DD3CA22A
	for <ltp@archiver.kernel.org>; Thu, 18 Aug 2022 09:40:02 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6469C3C6651
 for <ltp@lists.linux.it>; Thu, 18 Aug 2022 09:39:52 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B0D71200769
 for <ltp@lists.linux.it>; Thu, 18 Aug 2022 09:39:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660808390;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=4UD63cZS4g2uyD2E70CnP0CDyzYgA5M6F5MRv2ka//c=;
 b=Mi1wFguSWHLMVjzWQGUpBp6xV10FGKCpn/TK23wCIIMUR0enmrCAyUCSY34iyewdPo+opE
 sn+MMX4YT6I1HSoBB0QUvfqjLP4iW7f7rqbMeXdsSkmUiQ7MRDH7HgI1RtohEeTPdJGXts
 RT/iRysLAq+NY7GA59we4m0U/rJB/S8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-361-EL4lOZKdMGWzQl_8VI0SGA-1; Thu, 18 Aug 2022 03:39:41 -0400
X-MC-Unique: EL4lOZKdMGWzQl_8VI0SGA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DDDAE1C0754E
 for <ltp@lists.linux.it>; Thu, 18 Aug 2022 07:39:40 +0000 (UTC)
Received: from janakin.usersys.redhat.com (unknown [10.40.193.221])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4385A492CA4
 for <ltp@lists.linux.it>; Thu, 18 Aug 2022 07:39:40 +0000 (UTC)
From: Jan Stancek <jstancek@redhat.com>
To: ltp@lists.linux.it
Date: Thu, 18 Aug 2022 09:39:33 +0200
Message-Id: <564338cc537d103ed2cc4556ddbe074aeb7bdb47.1660808346.git.jstancek@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH COMMITTED] syscalls/delete_module: drop static
 declaration
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

Recent builds with upstream kernel catch static/non-static mismatch
and fail to build:
  CC [M]  /root/ltp/testcases/kernel/syscalls/delete_module/dummy_del_mod.o
  /root/ltp/testcases/kernel/syscalls/delete_module/dummy_del_mod.o: error: local symbol 'dummy_func_test' was exported
  make[1]: *** [scripts/Makefile.build:249: /root/ltp/testcases/kernel/syscalls/delete_module/dummy_del_mod.o] Error 1

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/delete_module/dummy_del_mod.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/testcases/kernel/syscalls/delete_module/dummy_del_mod.c b/testcases/kernel/syscalls/delete_module/dummy_del_mod.c
index 04a0b321bee9..0ca7bea37e3b 100644
--- a/testcases/kernel/syscalls/delete_module/dummy_del_mod.c
+++ b/testcases/kernel/syscalls/delete_module/dummy_del_mod.c
@@ -14,8 +14,6 @@
 #include <linux/proc_fs.h>
 #include <linux/kernel.h>
 
-static int dummy_func_test(void);
-
 /* Dummy function called by dependent module */
 int dummy_func_test(void)
 {
-- 
2.27.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
