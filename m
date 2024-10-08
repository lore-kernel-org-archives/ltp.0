Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EDC6CEF17A
	for <ltp@archiver.kernel.org>; Tue,  8 Oct 2024 14:00:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0F4F73C1C7F
	for <ltp@archiver.kernel.org>; Tue,  8 Oct 2024 16:00:40 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3B0F33C1C0A
 for <ltp@lists.linux.it>; Tue,  8 Oct 2024 15:59:49 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=david@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 4529E1000C21
 for <ltp@lists.linux.it>; Tue,  8 Oct 2024 15:59:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728395987;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SqC2Gbsn8oVt6aOFnIyfx+BCIN7AMBoK5lgfOz3iK7Q=;
 b=eJOtPJHskyrXH1Dhitn0aM8+OyNjoMP9Zih64YWJbF4Z1SGtXvhH9vFPSfXyI8vvn3yUD/
 s1IiHlC3Jj4AqFRSlkodI6M+uW2GLgn4ySKetN4MfCRYc2jw+NIw5BHCFajdc4ib5BmuGX
 4ebZOAcyaUIozHEi7g2Oety2xDadYpA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-176-Zo1N6jhPN52Fe621caQvhQ-1; Tue,
 08 Oct 2024 09:59:44 -0400
X-MC-Unique: Zo1N6jhPN52Fe621caQvhQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 848471954209; Tue,  8 Oct 2024 13:59:43 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.22.33.151])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CBC6D1956088; Tue,  8 Oct 2024 13:59:41 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: ltp@lists.linux.it
Date: Tue,  8 Oct 2024 15:59:33 +0200
Message-ID: <20241008135934.2491333-3-david@redhat.com>
In-Reply-To: <20241008135934.2491333-1-david@redhat.com>
References: <20241008135934.2491333-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/3] move_pages04: remove special-casing for
 kernels < 4.3
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
Cc: David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Let's stop pretending that kernels < 4.3 did the right thing: they
didn't. Let the test fail if we run on these kernels.

Suggested-by: Jan Stancek <jstancek@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 .../kernel/syscalls/move_pages/move_pages04.c      | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/testcases/kernel/syscalls/move_pages/move_pages04.c b/testcases/kernel/syscalls/move_pages/move_pages04.c
index 9fea63afa..7ad4ba78c 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages04.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages04.c
@@ -40,8 +40,7 @@
  *         -ENOENT. Note that kernels >= 4.3 [1] and < 6.12 [2] wrongly returned
  *         -EFAULT by accident.
  *      3. Check if the corresponding status for "shared zero page" is set to:
- *         -ENOENT for kernels < 4.3
- *         -EFAULT for kernels >= 4.3 [1]
+ *         -EFAULT. Note that kernels < 4.3 [1] wrongly returned -ENOENT.
  *      4. Check if the corresponding status for "invalid memory area" is set
  *         to -EFAULT.
  *
@@ -102,12 +101,7 @@ int main(int argc, char **argv)
 	int lc;
 	unsigned int from_node;
 	unsigned int to_node;
-	int ret, exp_zero_page_status;
-
-	if ((tst_kvercmp(4, 3, 0)) >= 0)
-		exp_zero_page_status = -EFAULT;
-	else
-		exp_zero_page_status = -ENOENT;
+	int ret;
 
 	ret = get_allowed_nodes(NH_MEMS, 2, &from_node, &to_node);
 	if (ret < 0)
@@ -189,14 +183,14 @@ int main(int argc, char **argv)
 				tst_strerrno(ENOENT));
 		}
 
-		if (status[ZERO_PAGE] == exp_zero_page_status) {
+		if (status[ZERO_PAGE] == -EFAULT) {
 			tst_resm(TPASS, "status[%d] has expected value",
 				 ZERO_PAGE);
 		} else {
 			tst_resm(TFAIL, "status[%d] is %s, expected %s",
 				ZERO_PAGE,
 				tst_strerrno(-status[ZERO_PAGE]),
-				tst_strerrno(-exp_zero_page_status));
+				tst_strerrno(EFAULT));
 		}
 
 		if (status[INVALID_PAGE] == -EFAULT) {
-- 
2.46.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
