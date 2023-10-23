Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4588BC001E0
	for <ltp@archiver.kernel.org>; Mon, 23 Oct 2023 14:18:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 74ACF3CECB2
	for <ltp@archiver.kernel.org>; Mon, 23 Oct 2023 16:18:53 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BFD1A3CECA6
 for <ltp@lists.linux.it>; Mon, 23 Oct 2023 15:57:24 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by in-7.smtp.seeweb.it (Postfix) with ESMTP id F3201200DD9
 for <ltp@lists.linux.it>; Mon, 23 Oct 2023 15:57:23 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 341A1FEC;
 Mon, 23 Oct 2023 06:58:03 -0700 (PDT)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com
 [10.1.194.65])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B02893F64C;
 Mon, 23 Oct 2023 06:57:21 -0700 (PDT)
From: Kevin Brodsky <kevin.brodsky@arm.com>
To: ltp@lists.linux.it
Date: Mon, 23 Oct 2023 14:56:46 +0100
Message-Id: <20231023135647.2157030-3-kevin.brodsky@arm.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20231023135647.2157030-1-kevin.brodsky@arm.com>
References: <20231023135647.2157030-1-kevin.brodsky@arm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 23 Oct 2023 16:18:31 +0200
Subject: [LTP] [PATCH 2/3] syscalls/msgctl06: Pass an appropriate struct to
 msgsnd()
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
Cc: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

msgsnd() expects a pointer to a struct as second argument. If a
pointer to a short buffer is provided instead, both the type and
message read by the kernel will be garbage. This went unnoticed as
the sent message is never read back in this test.

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 testcases/kernel/syscalls/ipc/msgctl/msgctl06.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/ipc/msgctl/msgctl06.c b/testcases/kernel/syscalls/ipc/msgctl/msgctl06.c
index 6f54763833ed..c1264b71e0e4 100644
--- a/testcases/kernel/syscalls/ipc/msgctl/msgctl06.c
+++ b/testcases/kernel/syscalls/ipc/msgctl/msgctl06.c
@@ -139,12 +139,16 @@ static void verify_msgctl(unsigned int n)
 static void setup(void)
 {
 	struct msqid_ds temp_buf;
+	struct buf {
+		long type;
+		char text[5];
+	} msgbuf = {MSGTYPE, "abcd"};
 	ltpuser = SAFE_GETPWNAM("nobody");
 	nobody_uid = ltpuser->pw_uid;
 	root_uid = 0;
 
 	msg_id = SAFE_MSGGET(IPC_PRIVATE, IPC_CREAT | MSG_RW);
-	SAFE_MSGSND(msg_id, "abcd", 4, 0);
+	SAFE_MSGSND(msg_id, &msgbuf, sizeof(msgbuf.text), 0);
 
 	TEST(msgctl(msg_id, MSG_STAT_ANY, &temp_buf));
 	if (TST_RET == -1) {
-- 
2.38.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
