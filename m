Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD954CFC299
	for <ltp@archiver.kernel.org>; Tue, 15 Oct 2024 11:49:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1FDF03C674E
	for <ltp@archiver.kernel.org>; Tue, 15 Oct 2024 13:49:06 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 472903C65EA
 for <ltp@lists.linux.it>; Tue, 15 Oct 2024 13:48:50 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jstancek@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 1F9B5206C52
 for <ltp@lists.linux.it>; Tue, 15 Oct 2024 13:48:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728992928;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E0HC48+1AFS02s0xPGCDIIDobxv5j0y8KwcSdP9KUcI=;
 b=csSj45V5jMkXxAmgKDgSn1/Z8AAW4CfFv1z1TSJ9Rs+pOzjkaf7i5Q4O2rkWbP642/CKq7
 CpVaW97W86udbPW8sK7kcgYOP+cd9dGrGhSsidxT8fzJ4UE6o8pC5teubtzBMxQDz6sKFO
 mu6XrLG7/+G2BrhZF3fYkq2omuSUDYI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-116-yKLJn6LKP26otgRQY0sm6g-1; Tue,
 15 Oct 2024 07:48:44 -0400
X-MC-Unique: yKLJn6LKP26otgRQY0sm6g-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0F3961956046; Tue, 15 Oct 2024 11:48:43 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.45.224.11])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EC0651956089; Tue, 15 Oct 2024 11:48:41 +0000 (UTC)
From: Jan Stancek <jstancek@redhat.com>
To: ltp@lists.linux.it,
	andrea.cervesato@suse.com
Date: Tue, 15 Oct 2024 13:48:14 +0200
Message-ID: <d53bcc8476d4c2ef37b92543b2f7fe8338420f0b.1728992854.git.jstancek@redhat.com>
In-Reply-To: <892adc7c5b174221bf10e796ad29adaaf1559e5c.1728978957.git.jstancek@redhat.com>
References: <892adc7c5b174221bf10e796ad29adaaf1559e5c.1728978957.git.jstancek@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] syscalls/statmount07: change "invalid buffer size"
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

The manpage doesn't say that 'smbuf' needs to be valid
for entire range of 'bufsize'.

This check relies on access_ok() check, which can be skipped
on some arches/configs, for example on s390x with
CONFIG_ALTERNATE_USER_ADDRESS_SPACE=y. Test then fails with:
  statmount07.c:117: TFAIL: invalid buffer size succeeded

Change the test to use buffer that crosses partially
into PROT_NONE area.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/statmount/statmount07.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/statmount/statmount07.c b/testcases/kernel/syscalls/statmount/statmount07.c
index 0cc83429872f..58fcc20acce7 100644
--- a/testcases/kernel/syscalls/statmount/statmount07.c
+++ b/testcases/kernel/syscalls/statmount/statmount07.c
@@ -20,10 +20,10 @@
 static struct statmount *st_mount;
 static struct statmount *st_mount_null;
 static struct statmount *st_mount_small;
+static struct statmount *st_mount_bad;
 static uint64_t mnt_id;
 static uint64_t mnt_id_dont_exist = -1;
 static size_t buff_size;
-static size_t buff_size_invalid = -1;
 
 struct tcase {
 	int exp_errno;
@@ -90,12 +90,12 @@ struct tcase {
 	},
 	{
 		EFAULT,
-		"invalid buffer size",
+		"buffer crosses to PROT_NONE",
 		&mnt_id,
 		0,
 		0,
-		&buff_size_invalid,
-		&st_mount
+		&buff_size,
+		&st_mount_bad
 	},
 	{
 		EFAULT,
@@ -139,6 +139,7 @@ static struct tst_test test = {
 	.bufs = (struct tst_buffers []) {
 		{&st_mount, .size = sizeof(struct statmount)},
 		{&st_mount_small, .size = sizeof(struct statmount)},
+		{&st_mount_bad, .size = 1},
 		{}
 	}
 };
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
