Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CC7AC001DB
	for <ltp@archiver.kernel.org>; Tue,  8 Aug 2023 12:45:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7FAFF3CE13C
	for <ltp@archiver.kernel.org>; Tue,  8 Aug 2023 14:45:04 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B6BF73CD0F0
 for <ltp@lists.linux.it>; Tue,  8 Aug 2023 14:44:53 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id ED5B71A007A3
 for <ltp@lists.linux.it>; Tue,  8 Aug 2023 14:44:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691498691;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=J5ThpiqdxOuXtPqp6LxDOqCTwc4Xqh0f/Bwv7hh2flA=;
 b=GO81yJpbYmpQ6FLHhBUyOCfN0CSF8wUm8CyizpkyQSo1b2AjjwOnB9yqnYlgqCwyp/UBRV
 sqEf2QFqL8KogU6Aq2F/OPSjRe/0o6kKMwjRMeyhCUjY5F2oAz825UbeZGcs8Bb20NLSdH
 JNdEVoqYr3p5+bl2SCxhO6JoGBCqtuw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-184-0qtUywcMM2qt2U4Q4hB9Lw-1; Tue, 08 Aug 2023 08:44:50 -0400
X-MC-Unique: 0qtUywcMM2qt2U4Q4hB9Lw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D77A785CCE1
 for <ltp@lists.linux.it>; Tue,  8 Aug 2023 12:44:49 +0000 (UTC)
Received: from liwang-workstation.lab.eng.nay.redhat.com (unknown
 [10.66.145.229])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9DF111121315;
 Tue,  8 Aug 2023 12:44:48 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Tue,  8 Aug 2023 20:44:45 +0800
Message-Id: <20230808124445.980419-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] io_uring: enable I/O Uring before testing
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
Cc: Jeff Moyer <jmoyer@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Given that the upstream kernel is going to introduce io_uring_disabled
knob which disables the creation of new io_uring instances system-wide.

The new sysctl is designed to let a user with root on the machine
enable and disable io_uring system-wide at runtime without requiring
a kernel recompilation or a reboot.

See: https://patchwork.kernel.org/project/io-uring/patch/20230630151003.3622786-2-matteorizzo@google.com/

Without this patch, LTP/io_uring test complains:

  io_uring01.c:82: TFAIL: io_uring_setup() failed: EPERM (1)
  io_uring02.c:213: TBROK: io_uring_setup() failed: EPERM (1)

Reproted-by: Jeff Moyer <jmoyer@redhat.com>
Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/syscalls/io_uring/io_uring01.c | 5 +++++
 testcases/kernel/syscalls/io_uring/io_uring02.c | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/testcases/kernel/syscalls/io_uring/io_uring01.c b/testcases/kernel/syscalls/io_uring/io_uring01.c
index 70151bb85..ab1ec00d6 100644
--- a/testcases/kernel/syscalls/io_uring/io_uring01.c
+++ b/testcases/kernel/syscalls/io_uring/io_uring01.c
@@ -264,5 +264,10 @@ static struct tst_test test = {
 	.bufs = (struct tst_buffers []) {
 		{&iov, .iov_sizes = (int[]){BLOCK_SZ, -1}},
 		{}
+	},
+	.save_restore = (const struct tst_path_val[]) {
+		{"/proc/sys/kernel/io_uring_disabled", "0",
+			TST_SR_SKIP_MISSING | TST_SR_TCONF_RO},
+		{}
 	}
 };
diff --git a/testcases/kernel/syscalls/io_uring/io_uring02.c b/testcases/kernel/syscalls/io_uring/io_uring02.c
index c5c770074..c9d4bbcb1 100644
--- a/testcases/kernel/syscalls/io_uring/io_uring02.c
+++ b/testcases/kernel/syscalls/io_uring/io_uring02.c
@@ -255,6 +255,11 @@ static struct tst_test test = {
 		TST_CAP(TST_CAP_REQ, CAP_SYS_CHROOT),
 		{}
 	},
+	.save_restore = (const struct tst_path_val[]) {
+		{"/proc/sys/kernel/io_uring_disabled", "0",
+			TST_SR_SKIP_MISSING | TST_SR_TCONF_RO},
+		{}
+	},
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "9392a27d88b9"},
 		{"linux-git", "ff002b30181d"},
-- 
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
