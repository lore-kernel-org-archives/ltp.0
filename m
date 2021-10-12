Return-Path: <SRS0=5AcX=PA=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E6DC433EF
	for <ltp@archiver.kernel.org>; Tue, 12 Oct 2021 09:29:55 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D96060F92
	for <ltp@archiver.kernel.org>; Tue, 12 Oct 2021 09:29:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3D96060F92
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux.it
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9726D3C0E2C
	for <ltp@archiver.kernel.org>; Tue, 12 Oct 2021 11:29:52 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4AB173C0BB6
 for <ltp@lists.linux.it>; Tue, 12 Oct 2021 11:29:44 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 6E2DF1001287
 for <ltp@lists.linux.it>; Tue, 12 Oct 2021 11:29:43 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id BCAC82217E;
 Tue, 12 Oct 2021 09:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1634030982; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Y/NtUPNTexGfrmnvIpn44SbF9fY0w3CDR5aY7iME5v4=;
 b=K4nLNTWbnSfByg0Xk6dTDBz0md8LY8HKEoc3Q3ARUILCXNe09zVd9TGOml8PaMbNyMdFED
 Hd61N9tiH5Z9PR2zADYyZJdp7dHgNXf9QEljNuvyhDf3dfftX9yJ2dlJS+vzJrPrCpEAlb
 OiyIGtz/KuayPMN6lpCE1pEcwMThe0o=
Received: from g78.suse.de (rpalethorpe.udp.ovpn1.nue.suse.de [10.163.24.38])
 by relay2.suse.de (Postfix) with ESMTP id 837FFA3B88;
 Tue, 12 Oct 2021 09:29:42 +0000 (UTC)
To: ltp@lists.linux.it
Date: Tue, 12 Oct 2021 10:28:58 +0100
Message-Id: <20211012092858.29992-1-rpalethorpe@suse.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] msgrcv02: Add negative msgtyp tests
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
From: Richard Palethorpe via ltp <ltp@lists.linux.it>
Reply-To: Richard Palethorpe <rpalethorpe@suse.com>
Cc: Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Test that we do not get higher message types. Also that -1 msgtyp is not
misinterpreted as INT_MAX by using MSG_EXCEPT.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
Suggested-by: Cyril Hrubis <chrubis@suse.cz>
---
 .../kernel/syscalls/ipc/msgrcv/msgrcv02.c     | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv02.c b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv02.c
index cfb7d7446..fba6a5289 100644
--- a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv02.c
+++ b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv02.c
@@ -21,6 +21,8 @@
  *   msgflg and no message of the requested type existed on the message queue.
  */
 
+#define _GNU_SOURCE
+
 #include <string.h>
 #include <sys/wait.h>
 #include <sys/msg.h>
@@ -38,7 +40,7 @@ struct passwd *pw;
 static struct buf {
 	long type;
 	char mtext[MSGSIZE];
-} rcv_buf, snd_buf = {MSGTYPE, "hello"};
+} rcv_buf, snd_buf = {2, "hello"};
 
 static struct tcase {
 	int *id;
@@ -49,12 +51,15 @@ static struct tcase {
 	int exp_user;
 	int exp_err;
 } tcases[] = {
-	{&queue_id, &rcv_buf, 4, 1, 0, 0, E2BIG},
-	{&queue_id, &rcv_buf, MSGSIZE, 1, 0, 1, EACCES},
-	{&queue_id, NULL, MSGSIZE, 1, 0, 0, EFAULT},
-	{&bad_id, &rcv_buf, MSGSIZE, 1, 0, 0, EINVAL},
-	{&queue_id, &rcv_buf, -1, 1, 0, 0, EINVAL},
-	{&queue_id, &rcv_buf, MSGSIZE, 2, IPC_NOWAIT, 0, ENOMSG},
+	{&queue_id, &rcv_buf, MSGSIZE - 1, 2, 0, 0, E2BIG},
+	{&queue_id, &rcv_buf, MSGSIZE,     2, 0, 1, EACCES},
+	{&queue_id, NULL,     MSGSIZE,     2, 0, 0, EFAULT},
+	{&bad_id,   &rcv_buf, MSGSIZE,     2, 0, 0, EINVAL},
+	{&queue_id, &rcv_buf, -1,          2, 0, 0, EINVAL},
+
+	{&queue_id, &rcv_buf, MSGSIZE,  3, IPC_NOWAIT,              0, ENOMSG},
+	{&queue_id, &rcv_buf, MSGSIZE, -1, IPC_NOWAIT,              0, ENOMSG},
+	{&queue_id, &rcv_buf, MSGSIZE, -1, IPC_NOWAIT | MSG_EXCEPT, 0, ENOMSG},
 };
 
 static void verify_msgrcv(struct tcase *tc)
-- 
2.33.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
