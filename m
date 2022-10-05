Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3181C433FE
	for <ltp@archiver.kernel.org>; Wed,  5 Oct 2022 14:26:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4E7703CAE25
	for <ltp@archiver.kernel.org>; Wed,  5 Oct 2022 16:26:29 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C20B23CAE0C
 for <ltp@lists.linux.it>; Wed,  5 Oct 2022 16:26:00 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B6EEB2009C6
 for <ltp@lists.linux.it>; Wed,  5 Oct 2022 16:25:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1664979958;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BfAzXk8j0006KC44Bs6llcLoBaG4KiUX8G14QMCYLyI=;
 b=RNIyYCi0UyZrjeKTCIQJXXZT0GYYhl85NkAUmH0uvjzfLa6SKMeGA+aQVw5Og9nPdY0FbT
 4oRb6mgB/6ZGOfy9/WqDKTMi3jmyvsSLXnFT0JK0ei9SFZ/Se121idB1edA14hYhAr9+ye
 AtD7ZXECg7JGK1hK0Lk8u9p9JnuKHuY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-286-TlfnSSU7Oeq7Z8eeNjeRYA-1; Wed, 05 Oct 2022 10:25:52 -0400
X-MC-Unique: TlfnSSU7Oeq7Z8eeNjeRYA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 925EC2932481;
 Wed,  5 Oct 2022 14:25:52 +0000 (UTC)
Received: from janakin.usersys.redhat.com (unknown [10.40.193.28])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EAC2C17585;
 Wed,  5 Oct 2022 14:25:51 +0000 (UTC)
From: Jan Stancek <jstancek@redhat.com>
To: ltp@lists.linux.it
Date: Wed,  5 Oct 2022 16:25:44 +0200
Message-Id: <90a93e9b87fda1811a00a35f8a549f2a1125ba0d.1664979933.git.jstancek@redhat.com>
In-Reply-To: <cf13ddfffdb08e0771be253ac6911febb96a47c4.1664979933.git.jstancek@redhat.com>
References: <cf13ddfffdb08e0771be253ac6911febb96a47c4.1664979933.git.jstancek@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/4] correct order of parameters in SAFE_WRITE()
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

And use new enum.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/containers/pidns/pidns13.c   | 2 +-
 testcases/kernel/containers/userns/userns08.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/containers/pidns/pidns13.c b/testcases/kernel/containers/pidns/pidns13.c
index bdc1097fd7d3..39fd6df7f4c4 100644
--- a/testcases/kernel/containers/pidns/pidns13.c
+++ b/testcases/kernel/containers/pidns/pidns13.c
@@ -96,7 +96,7 @@ static void child_fn(unsigned int cinit_no)
 		SAFE_CLOSE(pipe_fd[0]);
 
 		TST_CHECKPOINT_WAIT(1);
-		SAFE_WRITE(pipe_fd[1], 1, "test\n", 5);
+		SAFE_WRITE(SAFE_WRITE_ALL, pipe_fd[1], "test\n", 5);
 	}
 
 	exit(0);
diff --git a/testcases/kernel/containers/userns/userns08.c b/testcases/kernel/containers/userns/userns08.c
index bde944f224ba..0f1cb54a9dfe 100644
--- a/testcases/kernel/containers/userns/userns08.c
+++ b/testcases/kernel/containers/userns/userns08.c
@@ -118,7 +118,7 @@ static void setup(void)
 {
 	int fd = SAFE_OPEN("restricted", O_CREAT | O_WRONLY, 0700);
 
-	SAFE_WRITE(fd, 1, "\n", 1);
+	SAFE_WRITE(SAFE_WRITE_ALL, fd, "\n", 1);
 	SAFE_CLOSE(fd);
 
 	SAFE_TRY_FILE_PRINTF("/proc/sys/user/max_user_namespaces", "%d", 10);
-- 
2.27.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
