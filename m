Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC4CEC44500
	for <ltp@archiver.kernel.org>; Thu, 22 Jan 2026 10:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1769077604; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=UCgmg7h9uL7SQ6RVqpq0kog54jgXwf/LF4CO9RuYBns=;
 b=adj1bPVaGfnzg+q+8nFAFuD92n66sdhPBQLi/vyK+jYzdYM6xvTli7GicZo6sg8DS2VZW
 v1bozHXqcxBmhm5sJu7Aki95Kq1gYGtovLvwtaq/g3Tm78mInZviDCJ/ZoH9GunCDycexYC
 x1Yv37LFWkMJQEA2bU1eJ2lGPXSn5rA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6352F3CB3F4
	for <ltp@archiver.kernel.org>; Thu, 22 Jan 2026 11:26:44 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CA0203CAFD9
 for <ltp@lists.linux.it>; Thu, 22 Jan 2026 11:26:18 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D0DDB600B55
 for <ltp@lists.linux.it>; Thu, 22 Jan 2026 11:26:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769077574;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=IR/ldNxRx5CXL7EDC7ZwctMFqZpgWj+9NUu2AIkPD9E=;
 b=LpLev1TAfGHQgZZ866di5H5uO/jor+h0QGCZoYpQvavpC9dQo2zRpRvBzUM6amY4gIA6GM
 26WqHMCmeckL7i5vxMAVoNQdrKYTrCjtlQ2X7mmOwcktRULx92NQB9Vg3YXQc3tJtXMQWl
 l2Q6K/h71ocR+aIGXmRpJY3pzKy7x40=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-98-yjjawjKONMal7CYe7cd6lw-1; Thu,
 22 Jan 2026 05:26:13 -0500
X-MC-Unique: yjjawjKONMal7CYe7cd6lw-1
X-Mimecast-MFC-AGG-ID: yjjawjKONMal7CYe7cd6lw_1769077572
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4AFB219775A7
 for <ltp@lists.linux.it>; Thu, 22 Jan 2026 10:26:12 +0000 (UTC)
Received: from fedora-laptop-x1.redhat.com (unknown [10.72.116.167])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 091AC30002D8
 for <ltp@lists.linux.it>; Thu, 22 Jan 2026 10:26:10 +0000 (UTC)
To: ltp@lists.linux.it
Date: Thu, 22 Jan 2026 18:26:06 +0800
Message-ID: <20260122102606.87754-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PR8CwrWvS_ZN4Ccp1dj3kIpZ5RuXc4tSjIAoZJD6lBk_1769077572
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] clone10: add support archs
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
From: Li Wang via ltp <ltp@lists.linux.it>
Reply-To: Li Wang <liwang@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/syscalls/clone/clone10.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/testcases/kernel/syscalls/clone/clone10.c b/testcases/kernel/syscalls/clone/clone10.c
index a52ac3568..9ffb49c37 100644
--- a/testcases/kernel/syscalls/clone/clone10.c
+++ b/testcases/kernel/syscalls/clone/clone10.c
@@ -91,4 +91,10 @@ static struct tst_test test = {
 	.cleanup = cleanup,
 	.needs_checkpoints = 1,
 	.test_all = verify_tls,
+	.supported_archs = (const char *const []) {
+		"x86_64",
+		"aarch64",
+		"s390x",
+		NULL
+	}
 };
-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
