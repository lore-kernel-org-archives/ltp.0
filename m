Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F4167C4332F
	for <ltp@archiver.kernel.org>; Sun,  9 Oct 2022 06:55:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 887EE3CAE67
	for <ltp@archiver.kernel.org>; Sun,  9 Oct 2022 08:55:52 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B44C13CAE60
 for <ltp@lists.linux.it>; Sun,  9 Oct 2022 08:55:27 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id ECFF26005E4
 for <ltp@lists.linux.it>; Sun,  9 Oct 2022 08:55:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1665298525;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=sVVyrUAHo1YlNp7FGSYU6HtQJmSfN+Nkac8xYHRA3CM=;
 b=hoAKnCcYwc+DyHtJjW4NQ98d3TTtRG99HHsnaKd0rBnUQhPkAh4PLLTlA3YOG0xGYu1kHp
 4AtsGBwKW3YTij/Zxh7Y/ETdzA43YkzsXaDLZvGFW5zHz5ejrvxn9YFQXsB7QnlJy1A2V8
 DWBRVPPeA64qBlKtWrNP7xQvwAzaZEY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-350-fdlZuuhCOtOKbpNHVAlcVg-1; Sun, 09 Oct 2022 02:55:23 -0400
X-MC-Unique: fdlZuuhCOtOKbpNHVAlcVg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5EC9185A583
 for <ltp@lists.linux.it>; Sun,  9 Oct 2022 06:55:23 +0000 (UTC)
Received: from liwang-workstation.nay.redhat.com
 (dhcp-66-81-187.nay.redhat.com [10.66.81.187])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 67C1A40C9559
 for <ltp@lists.linux.it>; Sun,  9 Oct 2022 06:55:22 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Sun,  9 Oct 2022 14:55:19 +0800
Message-Id: <20221009065520.3236525-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] getitimer02: add ITIMER_VIRTUAL timer error check
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
 testcases/kernel/syscalls/getitimer/getitimer02.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/getitimer/getitimer02.c b/testcases/kernel/syscalls/getitimer/getitimer02.c
index 863e8e0a8..cd98dcce8 100644
--- a/testcases/kernel/syscalls/getitimer/getitimer02.c
+++ b/testcases/kernel/syscalls/getitimer/getitimer02.c
@@ -27,8 +27,9 @@ static struct tcase {
        struct itimerval **val;
        int exp_errno;
 } tcases[] = {
-       {ITIMER_REAL, &invalid, EFAULT},
-       {-ITIMER_PROF, &value, EINVAL},
+       {ITIMER_REAL,    &invalid, EFAULT},
+       {ITIMER_VIRTUAL, &invalid, EFAULT},
+       {-ITIMER_PROF,   &value,   EINVAL},
 };
 
 static int sys_getitimer(int which, void *curr_value)
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
