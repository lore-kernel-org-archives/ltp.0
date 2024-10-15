Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93F0DCFC273
	for <ltp@archiver.kernel.org>; Tue, 15 Oct 2024 07:57:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 65BB53C66D5
	for <ltp@archiver.kernel.org>; Tue, 15 Oct 2024 09:57:37 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7CF4A3C666D
 for <ltp@lists.linux.it>; Tue, 15 Oct 2024 09:57:21 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jstancek@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4859B642085
 for <ltp@lists.linux.it>; Tue, 15 Oct 2024 09:57:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728979038;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=auOwIqLiNn1SqHjhFYQ89rfmqqjsoU6GpL8vsVOfjgY=;
 b=NECUK+T1M6/0oY7aNI4VPAr2iN3MOPtwcqHHjRdg4YFeMYLjBM8tfha3nUZK8bBF5Egxxl
 /GGmDNukqBiuqyQ3c8efGgifdV742uSrwCEzhF8sfZOSxTpCPjli9NNw+bIwVpyTsRGG06
 t5DkXe+o1lfwC2C+zmwoanyijbLADQU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-488-FBo6fKNyOqOGEXbuA4BAjQ-1; Tue,
 15 Oct 2024 03:57:16 -0400
X-MC-Unique: FBo6fKNyOqOGEXbuA4BAjQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9F7B01955E75; Tue, 15 Oct 2024 07:57:15 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.45.224.11])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9720819560AE; Tue, 15 Oct 2024 07:57:14 +0000 (UTC)
From: Jan Stancek <jstancek@redhat.com>
To: ltp@lists.linux.it,
	andrea.cervesato@suse.com
Date: Tue, 15 Oct 2024 09:57:11 +0200
Message-ID: <892adc7c5b174221bf10e796ad29adaaf1559e5c.1728978957.git.jstancek@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/statmount07: drop "invalid buffer size" test
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

The manpage doesn't say that 'smbuf' needs to be valid
for entire range of 'bufsize'.

This check relies on access_ok() check, which can be skipped
on some arches/configs, for example on s390x with
CONFIG_ALTERNATE_USER_ADDRESS_SPACE=y. Test then fails with:
  statmount07.c:117: TFAIL: invalid buffer size succeeded

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/statmount/statmount07.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/testcases/kernel/syscalls/statmount/statmount07.c b/testcases/kernel/syscalls/statmount/statmount07.c
index 0cc83429872f..334c287b791c 100644
--- a/testcases/kernel/syscalls/statmount/statmount07.c
+++ b/testcases/kernel/syscalls/statmount/statmount07.c
@@ -88,15 +88,6 @@ struct tcase {
 		&buff_size,
 		&st_mount
 	},
-	{
-		EFAULT,
-		"invalid buffer size",
-		&mnt_id,
-		0,
-		0,
-		&buff_size_invalid,
-		&st_mount
-	},
 	{
 		EFAULT,
 		"invalid buffer pointer",
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
