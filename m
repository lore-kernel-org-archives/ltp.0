Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B238C433FE
	for <ltp@archiver.kernel.org>; Wed,  5 Oct 2022 14:26:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B92A93CAE10
	for <ltp@archiver.kernel.org>; Wed,  5 Oct 2022 16:26:07 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4267E3C2730
 for <ltp@lists.linux.it>; Wed,  5 Oct 2022 16:25:56 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B2554601323
 for <ltp@lists.linux.it>; Wed,  5 Oct 2022 16:25:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1664979954;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=bM+1a0i0u6RSv0JJcyKoU0bO1/bKfwQ4xbFjEwUBQUs=;
 b=GniembUKelboTqSJ4JdotsbJewfZMYG/donu91Qo98j70IVLT9HUzfcFcNplY1uXs0nv1o
 xKpJK5lUR6/kaVzDASeOKAzFBvV49Y9b3awtX8RHfsgNKjvtsQ4enfeodMJwdYy3kx/Wb8
 33JfgQxsdUTfLc5g0g1L48JKCn4pyAI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-516-SUQuIhZFMUWHsz8L_Hjxxw-1; Wed, 05 Oct 2022 10:25:51 -0400
X-MC-Unique: SUQuIhZFMUWHsz8L_Hjxxw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C11473C025C5;
 Wed,  5 Oct 2022 14:25:50 +0000 (UTC)
Received: from janakin.usersys.redhat.com (unknown [10.40.193.28])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0551617585;
 Wed,  5 Oct 2022 14:25:49 +0000 (UTC)
From: Jan Stancek <jstancek@redhat.com>
To: ltp@lists.linux.it
Date: Wed,  5 Oct 2022 16:25:42 +0200
Message-Id: <cf13ddfffdb08e0771be253ac6911febb96a47c4.1664979933.git.jstancek@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/4] mmapstress04: use SAFE_WRITE_RETRY from LTP
 library
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

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/mem/mmapstress/mmapstress04.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/testcases/kernel/mem/mmapstress/mmapstress04.c b/testcases/kernel/mem/mmapstress/mmapstress04.c
index ceede7eaa860..d71c469bc6c8 100644
--- a/testcases/kernel/mem/mmapstress/mmapstress04.c
+++ b/testcases/kernel/mem/mmapstress/mmapstress04.c
@@ -32,17 +32,6 @@ static void setup(void)
 		MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);
 }
 
-static void write_fully(int fd, void *buf, int len)
-{
-	int ret;
-
-	do {
-		ret = SAFE_WRITE(0, fd, buf, len);
-		buf += ret;
-		len -= ret;
-	} while (len > 0);
-}
-
 static void mmapstress04(void)
 {
 	int i, j, rofd, rwfd;
@@ -85,7 +74,7 @@ static void mmapstress04(void)
 	buf = SAFE_MALLOC(page_size);
 	memset(buf, 'a', page_size);
 	for (i = 0; i < 6 * 64; i++)
-		write_fully(rwfd, buf, page_size);
+		SAFE_WRITE(SAFE_WRITE_RETRY, rwfd, buf, page_size);
 	free(buf);
 	SAFE_CLOSE(rwfd);
 
-- 
2.27.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
