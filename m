Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF6CFC3DA7F
	for <ltp@archiver.kernel.org>; Mon, 12 Aug 2024 10:32:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 063BB3D20F0
	for <ltp@archiver.kernel.org>; Mon, 12 Aug 2024 12:32:15 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A94423C9F45
 for <ltp@lists.linux.it>; Mon, 12 Aug 2024 12:31:58 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jstancek@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 12583100094E
 for <ltp@lists.linux.it>; Mon, 12 Aug 2024 12:31:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723458716;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=w2k3sIHY3FnAeea/XVWREiV4WtXVOVd5x14GuZtUPRU=;
 b=Hk20i2/VL9E8xc5oo5twxpc+9yjh/Bu1fAvIO3Llue9rQiv8LqA09eeAhBrCS3q1g9R1Aj
 di3jjQs7dDHvBTW4sEA28tW7f3b26aeBWN4qZnd1VnRSSI+loazu/55y9WxUCX4TJgRHdA
 avjfYfIQ32eNXtUQ9nURbi59fmEaQOA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-275-00jZIOZ_MGayKBZXnrKfog-1; Mon,
 12 Aug 2024 06:31:54 -0400
X-MC-Unique: 00jZIOZ_MGayKBZXnrKfog-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DC00E1944EAF
 for <ltp@lists.linux.it>; Mon, 12 Aug 2024 10:31:53 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.45.225.12])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E1DAC19560AD
 for <ltp@lists.linux.it>; Mon, 12 Aug 2024 10:31:52 +0000 (UTC)
From: Jan Stancek <jstancek@redhat.com>
To: ltp@lists.linux.it
Date: Mon, 12 Aug 2024 12:31:42 +0200
Message-ID: <9a9b743304c2b6ad1a045f26d33304a3350cdf4c.1723458583.git.jstancek@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/execve04,
 creat07: skip for kernels 6.11 and later
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

The behaviour is allowed since commit:
  2a010c412853 ("fs: don't block i_writecount during exec")
that landed in 6.11-rc1.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/creat/creat07.c   | 10 ++++++++++
 testcases/kernel/syscalls/execve/execve04.c | 10 ++++++++++
 2 files changed, 20 insertions(+)

diff --git a/testcases/kernel/syscalls/creat/creat07.c b/testcases/kernel/syscalls/creat/creat07.c
index 7bd32ab4d328..f157e1a8fbb2 100644
--- a/testcases/kernel/syscalls/creat/creat07.c
+++ b/testcases/kernel/syscalls/creat/creat07.c
@@ -47,7 +47,17 @@ static void verify_creat(void)
 	SAFE_WAITPID(pid, NULL, 0);
 }
 
+static void setup(void)
+{
+	if ((tst_kvercmp(6, 11, 0)) >= 0) {
+		tst_brk(TCONF, "Skipping test, write to executed file is "
+			"allowed since 6.11-rc1.\n"
+			"2a010c412853 (\"fs: don't block i_writecount during exec\")");
+	}
+}
+
 static struct tst_test test = {
+	.setup = setup,
 	.test_all = verify_creat,
 	.needs_checkpoints = 1,
 	.forks_child = 1,
diff --git a/testcases/kernel/syscalls/execve/execve04.c b/testcases/kernel/syscalls/execve/execve04.c
index 3bac642e5412..7bbfece85906 100644
--- a/testcases/kernel/syscalls/execve/execve04.c
+++ b/testcases/kernel/syscalls/execve/execve04.c
@@ -65,7 +65,17 @@ static void do_child(void)
 	exit(0);
 }
 
+static void setup(void)
+{
+	if ((tst_kvercmp(6, 11, 0)) >= 0) {
+		tst_brk(TCONF, "Skipping test, write to executed file is "
+			"allowed since 6.11-rc1.\n"
+			"2a010c412853 (\"fs: don't block i_writecount during exec\")");
+	}
+}
+
 static struct tst_test test = {
+	.setup = setup,
 	.test_all = verify_execve,
 	.forks_child = 1,
 	.child_needs_reinit = 1,
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
