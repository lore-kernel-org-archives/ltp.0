Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 109DEC4828D
	for <ltp@archiver.kernel.org>; Mon,  5 Feb 2024 10:27:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 649063CC6C9
	for <ltp@archiver.kernel.org>; Mon,  5 Feb 2024 11:27:21 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3E33D3C9959
 for <ltp@lists.linux.it>; Mon,  5 Feb 2024 11:27:02 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwang@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 09EC2600BB5
 for <ltp@lists.linux.it>; Mon,  5 Feb 2024 11:27:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707128820;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=jC5x2GRk9HIrCeP5HMb73AdND7/u+0pEVNZZ5JwGuMU=;
 b=Btz3ExeSLwK/4t2rUH24/1PHNdfF/ew62DXWPxrV92jOj52/qn87D59QiHjnoUOwjLJNeg
 j2zUkKdQ2Ind2cTRJnoX8QzHQK5zD/zJRnsczg4vjVlJgeK5kYLUEoHqmWcn3j+u7eBHdj
 1FSjQn6L9EVcU0OxsbavExCDvkpSJsM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-xC9eysfjMNGKYhAp08qSBQ-1; Mon, 05 Feb 2024 05:26:58 -0500
X-MC-Unique: xC9eysfjMNGKYhAp08qSBQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A0C0185A58B
 for <ltp@lists.linux.it>; Mon,  5 Feb 2024 10:26:58 +0000 (UTC)
Received: from liwang-workstation.lab.eng.nay.redhat.com (unknown
 [10.66.145.229])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 244182166B31;
 Mon,  5 Feb 2024 10:26:56 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Mon,  5 Feb 2024 18:26:53 +0800
Message-Id: <20240205102653.2789879-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] process_state: Enhancement of process state detection
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

The functions will be more robust against process names with
unusual characters and will correctly read the state character
from the /proc/[pid]/stat file. This is a necessary change
because the process name, which is a free-form string, can
contain spaces and other characters that would otherwise
disrupt the simple parsing logic of the original format string.

e.g.
 $ cat /proc/792442/stat
 792442 (Web Content) S 164213 4351 4351 0 -1 4194560 ...

Reported-by: Ian Wienand <iwienand@redhat.com>
Signed-off-by: Li Wang <liwang@redhat.com>
Cc: Chunyu Hu <chuhu@redhat.com>
---
 lib/tst_process_state.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/tst_process_state.c b/lib/tst_process_state.c
index 08a9d0966..c15283c3d 100644
--- a/lib/tst_process_state.c
+++ b/lib/tst_process_state.c
@@ -22,7 +22,7 @@ int tst_process_state_wait(const char *file, const int lineno,
 
 	for (;;) {
 		safe_file_scanf(file, lineno, cleanup_fn, proc_path,
-				"%*i %*s %c", &cur_state);
+				"%*[^)]%*c %c", &cur_state);
 
 		if (state == cur_state)
 			break;
@@ -54,7 +54,7 @@ int tst_process_state_wait2(pid_t pid, const char state)
 			return 1;
 		}
 
-		if (fscanf(f, "%*i %*s %c", &cur_state) != 1) {
+		if (fscanf(f, "%*[^)]%*c %c", &cur_state) != 1) {
 			fclose(f);
 			fprintf(stderr, "Failed to read '%s': %s\n",
 				proc_path, strerror(errno));
-- 
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
