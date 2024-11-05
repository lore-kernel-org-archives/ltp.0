Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB0BFD1CA19
	for <ltp@archiver.kernel.org>; Tue,  5 Nov 2024 04:14:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CFC7F3D1B05
	for <ltp@archiver.kernel.org>; Tue,  5 Nov 2024 05:14:11 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DA3673D1A54
 for <ltp@lists.linux.it>; Tue,  5 Nov 2024 05:13:40 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwang@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id CDDDF669A7E
 for <ltp@lists.linux.it>; Tue,  5 Nov 2024 05:13:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730780018;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s2sIX2ZmFSbEoSSNsG4Sk2q1r1IstiM5MQMVTyddYL4=;
 b=XsNfHL9rn7qsdu84qy/C9RWoRhciiIUcrw6HypZDIoK4XmPyS6W7G0PQAvZl+AMkVFysfT
 3IvxjkxmTNNlqnHWgo03eb/ZD5CDEQ2wRgQUyn1cBDG1HSBgAnSf4Irbp/RRwmz1GroDu6
 jxBpEoLlB8zrDmc8BSJwXqu4kZxSfgg=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-335-0WhfIgK3Oji2WO4MJkh5ng-1; Mon,
 04 Nov 2024 23:13:36 -0500
X-MC-Unique: 0WhfIgK3Oji2WO4MJkh5ng-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D2AD119560A2
 for <ltp@lists.linux.it>; Tue,  5 Nov 2024 04:13:35 +0000 (UTC)
Received: from dell-per7425-02.rhts.eng.pek2.redhat.com
 (dell-per7425-02.rhts.eng.pek2.redhat.com [10.73.116.18])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 930A219560A3
 for <ltp@lists.linux.it>; Tue,  5 Nov 2024 04:13:33 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Tue,  5 Nov 2024 12:13:25 +0800
Message-ID: <20241105041326.18531-2-liwang@redhat.com>
In-Reply-To: <20241105041326.18531-1-liwang@redhat.com>
References: <20241105041326.18531-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] landlock01: used fixed size for rule_small_size
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

The landlock01 test is failing on kernel v6.12-rc6 with the
following error:

  landlock01.c:49: TFAIL: Size is too small expected EINVAL: ENOMSG (42)

Previously, rule_small_size was calculated conditionally based
on the presence of the handled_access_net field in the struct
landlock_ruleset_attr.

However, the kernel's landlock_create_ruleset() function still uses
the size up to handled_access_fs to determine the minimal acceptable
size for backward compatibility, regardless of any new fields added.

According to the Landlock maintainer[1], this behavior will remain
for backward compatibility reasons. Therefore, it's unnecessary to
conditionally adjust rule_small_size based on new fields.

This patch simplifies the test by setting rule_small_size to
'sizeof(__u64) - 1', which effectively tests the minimal size based
on handled_access_fs.

[1] https://lists.linux.it/pipermail/ltp/2024-July/039084.html

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/syscalls/landlock/landlock01.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/syscalls/landlock/landlock01.c b/testcases/kernel/syscalls/landlock/landlock01.c
index 083685c64..c375e5154 100644
--- a/testcases/kernel/syscalls/landlock/landlock01.c
+++ b/testcases/kernel/syscalls/landlock/landlock01.c
@@ -62,11 +62,17 @@ static void setup(void)
 
 	rule_size = sizeof(struct landlock_ruleset_attr);
 
-#ifdef HAVE_STRUCT_LANDLOCK_RULESET_ATTR_HANDLED_ACCESS_NET
-	rule_small_size = rule_size - sizeof(uint64_t) - 1;
-#else
-	rule_small_size = rule_size - 1;
-#endif
+	/*
+	 * Kernel introduces two new fields 'handled_access_net' and 'scoped'
+	 * in the structure 'landlock_ruleset_attr'. However, in the function
+	 * 'landlock_create_ruleset()', it still uses the first field
+	 * 'handled_access_fs' to calculate the minimal size for backward
+	 * compatibility reason.
+	 *
+	 * Therefore, here test 'sizeof(__u64) - 1' is sufficient to determine
+	 * the minimum size for 'rule_small_size'.
+	 */
+	rule_small_size = sizeof(__u64) - 1;
 
 	rule_big_size = SAFE_SYSCONF(_SC_PAGESIZE) + 1;
 }
-- 
2.47.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
