Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56C21E6B271
	for <ltp@archiver.kernel.org>; Fri,  1 Nov 2024 13:02:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C0A5B3CD524
	for <ltp@archiver.kernel.org>; Fri,  1 Nov 2024 14:02:26 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 903BB3CD3E3
 for <ltp@lists.linux.it>; Fri,  1 Nov 2024 14:02:11 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jstancek@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 01FEA1BC13FE
 for <ltp@lists.linux.it>; Fri,  1 Nov 2024 14:02:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730466128;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=J32rTCTNbKDqCkGEb+69AT4zBD0ug0RYQfmXiUR0KyU=;
 b=e7yJlBWUMemsaWRQYj9quGPsJnAshJdRW0K1nlMSigDg43n28I5PnRnPC3pmZYtbfKVUWi
 c2G2Xuv5+tg05DP/v2s4L7CnQEqgtSuDwXQT+04Q3C3hyhj1Lue0CacHYPNNM5WgPGHUbs
 7LtzOS7SnZoR5x6LTtNOUrpzTP+vWKU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-637-TzebjEZVOHCG97WlaYqRLg-1; Fri,
 01 Nov 2024 09:02:06 -0400
X-MC-Unique: TzebjEZVOHCG97WlaYqRLg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 169871944D45
 for <ltp@lists.linux.it>; Fri,  1 Nov 2024 13:02:05 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.45.224.119])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3B50B1956052
 for <ltp@lists.linux.it>; Fri,  1 Nov 2024 13:02:03 +0000 (UTC)
From: Jan Stancek <jstancek@redhat.com>
To: ltp@lists.linux.it
Date: Fri,  1 Nov 2024 14:02:01 +0100
Message-ID: <5be090bd107e8cff5823fc35d9c0b9c8ee082ec6.1730466072.git.jstancek@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/sched_getattr02: use a fixed size for EINVAL
 test
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

Test is using a 'size' based on sizeof(struct sched_attr), but
since c48700d8cdbe ("sched_attr: Do not define for glibc >= 2.41")
that structure can now be defined by glibc which also defines additional
fields.

The kernel only checks if size is smaller than SCHED_ATTR_SIZE_VER0 (48 bytes).
Man page mentions this size directly, so just use a fixed size for the test.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/sched_getattr/sched_getattr02.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/sched_getattr/sched_getattr02.c b/testcases/kernel/syscalls/sched_getattr/sched_getattr02.c
index 5efec2ff5a95..d2099d09f532 100644
--- a/testcases/kernel/syscalls/sched_getattr/sched_getattr02.c
+++ b/testcases/kernel/syscalls/sched_getattr/sched_getattr02.c
@@ -51,7 +51,7 @@ static struct test_case {
 } test_cases[] = {
 	{&unused_pid, &attr_copy, sizeof(struct sched_attr), 0, ESRCH},
 	{&pid, NULL, sizeof(struct sched_attr), 0, EINVAL},
-	{&pid, &attr_copy, sizeof(struct sched_attr) - 1, 0, EINVAL},
+	{&pid, &attr_copy, 47, 0, EINVAL},
 	{&pid, &attr_copy, sizeof(struct sched_attr), 1000, EINVAL}
 };
 
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
