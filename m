Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B963EC433F5
	for <ltp@archiver.kernel.org>; Mon, 11 Apr 2022 09:44:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1C14E3CA519
	for <ltp@archiver.kernel.org>; Mon, 11 Apr 2022 11:44:37 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 21E9E3CA3CF
 for <ltp@lists.linux.it>; Mon, 11 Apr 2022 11:44:27 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 3C60F200936
 for <ltp@lists.linux.it>; Mon, 11 Apr 2022 11:44:25 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2878D21112
 for <ltp@lists.linux.it>; Mon, 11 Apr 2022 09:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1649670265; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=EX85Ldp73KhqmZTTFFqqEI3E9H19v4eZfNTjyGcILf8=;
 b=mYeHF0bP9z2I/MvUxDdlWDQRWbYUNnDvbjC3SKsD7lLHB1UjpXsy76l+rX5bBK3BaTxnwY
 CAMzSj3d5RguiJxLoOypAviOapBAbIPwAX2kmrgUXXaBJI4BehdTYhd+WAe6cjWfQ6cog7
 zLTjVLQOl6kx7t2fxLNlPVHtzRKz56U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1649670265;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=EX85Ldp73KhqmZTTFFqqEI3E9H19v4eZfNTjyGcILf8=;
 b=c+wZq8QzXlAV1ZW3Tt2a352+I2Rq0j29GsN6p9xxPa4H5OtpojkVqayHnNaYmyh/6RkgA7
 1br/t/8xV0xSilAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 148B313A93
 for <ltp@lists.linux.it>; Mon, 11 Apr 2022 09:44:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id HfrKA3n4U2KxTAAAMHmgww
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Mon, 11 Apr 2022 09:44:25 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 11 Apr 2022 11:44:24 +0200
Message-Id: <20220411094424.15286-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/io_submit: Flush IO completion queue
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

Running io_submit01 or io_submit02 with high number of iterations
(e.g. io_submit01 -i 200) would result in bogus errors because the kernel
queue will get clogged with completed requests. Fix this by calling
io_getevents() to flush the completion queue.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 testcases/kernel/syscalls/io_submit/io_submit01.c | 8 +++++++-
 testcases/kernel/syscalls/io_submit/io_submit02.c | 9 +++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/io_submit/io_submit01.c b/testcases/kernel/syscalls/io_submit/io_submit01.c
index 28d93d7f1..db541fc01 100644
--- a/testcases/kernel/syscalls/io_submit/io_submit01.c
+++ b/testcases/kernel/syscalls/io_submit/io_submit01.c
@@ -114,13 +114,19 @@ static const char *errno_name(int err)
 static void verify_io_submit(unsigned int n)
 {
 	struct tcase *t = &tcases[n];
-	int ret;
+	struct io_event evbuf;
+	struct timespec timeout = { .tv_sec = 1 };
+	int i, ret;
 
 	ret = io_submit(*t->ctx, t->nr, t->iocbs);
 
 	if (ret == t->exp_errno) {
 		tst_res(TPASS, "io_submit() with %s failed with %s",
 			t->desc, errno_name(t->exp_errno));
+
+		for (i = 0; i < ret; i++)
+			io_getevents(*t->ctx, 1, 1, &evbuf, &timeout);
+
 		return;
 	}
 
diff --git a/testcases/kernel/syscalls/io_submit/io_submit02.c b/testcases/kernel/syscalls/io_submit/io_submit02.c
index acb42cb8f..38b8555d8 100644
--- a/testcases/kernel/syscalls/io_submit/io_submit02.c
+++ b/testcases/kernel/syscalls/io_submit/io_submit02.c
@@ -70,12 +70,21 @@ static void cleanup(void)
 
 static void run(unsigned int i)
 {
+	struct io_event evbuf;
+	struct timespec timeout = { .tv_sec = 1 };
+	long j;
+
 	TEST(tst_syscall(__NR_io_submit, *tc[i].ctx, tc[i].nr, tc[i].iocbs));
 
 	if (TST_RET == tc[i].nr)
 		tst_res(TPASS, "io_submit() %s", tc[i].desc);
 	else
 		tst_res(TFAIL, "io_submit() returns %ld, expected %ld", TST_RET, tc[i].nr);
+
+	for (j = 0; j < TST_RET; j++) {
+		tst_syscall(__NR_io_getevents, *tc[i].ctx, 1, 1, &evbuf,
+			&timeout);
+	}
 }
 
 static struct tst_test test = {
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
