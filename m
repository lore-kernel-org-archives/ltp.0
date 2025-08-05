Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B821FC87FD1
	for <ltp@archiver.kernel.org>; Tue,  5 Aug 2025 09:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1754385999; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=a+Iz6KWE7HUzXHtVifpDdjb4rDjNJiox0SJpyylB8gw=;
 b=LKtRzPczZ1Bx4UNvTtedDHeps69csFgSN5XhWOZ6PVJPYyfl90aDMhw1zd7bvuEU8sucB
 7gC1AUwenY7NTwd+0JlOVREXVgza3HHLiHu9142sFoUIkhPGz+vS6n9TMEuXdPW2NJpGCs+
 /nM803cf/seSAcKgaAp12THQAtzad+g=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E4E843C7BB9
	for <ltp@archiver.kernel.org>; Tue,  5 Aug 2025 11:26:39 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5B1C33C736A
 for <ltp@lists.linux.it>; Tue,  5 Aug 2025 11:26:20 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 94E781A00939
 for <ltp@lists.linux.it>; Tue,  5 Aug 2025 11:26:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754385978;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=biXOO8Qew6azqDkaqGBjAcgeBoNg3mIN+z9BQ7XWwZg=;
 b=e2YGjviE9hD/luefUy+1/0ITqPmASQov/Oofqs59cNut9+zyFXn2iQmJ+4JAEYKVaSCFYS
 V5VH7VTlVL181blkPS/Qetz7LzyR0BsreYwVi2NUKGm01ri0LkUkXONn0E+DvEqad8WJL6
 usrsdCOfRGnB5oMT+z4hjtqtv74fSIY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-688-YfQGIEhrMlegw-a8CRO7pQ-1; Tue,
 05 Aug 2025 05:26:16 -0400
X-MC-Unique: YfQGIEhrMlegw-a8CRO7pQ-1
X-Mimecast-MFC-AGG-ID: YfQGIEhrMlegw-a8CRO7pQ_1754385975
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A4ECA1800115
 for <ltp@lists.linux.it>; Tue,  5 Aug 2025 09:26:15 +0000 (UTC)
Received: from t14ultra.redhat.com (unknown [10.44.32.5])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CB5761800B75
 for <ltp@lists.linux.it>; Tue,  5 Aug 2025 09:26:14 +0000 (UTC)
To: ltp@lists.linux.it
Date: Tue,  5 Aug 2025 11:27:23 +0200
Message-ID: <39ee7abdee12e22074b40d46775d69d37725b932.1754386027.git.jstancek@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _hgB1KKTwxqtwvXGvT5TVXmTusu_E0ovRozjWat9EW4_1754385975
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/epoll_ctl04: add ELOOP to expected errnos
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
From: Jan Stancek via ltp <ltp@lists.linux.it>
Reply-To: Jan Stancek <jstancek@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Kernel commit f2e467a48287 ("eventpoll: Fix semi-unbounded recursion")
added an extra checks for determining the maximum depth of an upwards walk,
which startign with 6.17-rc kernels now hits ELOOP before EINVAL.

Add ELOOP to list of expected errnos.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/epoll_ctl/epoll_ctl04.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/epoll_ctl/epoll_ctl04.c b/testcases/kernel/syscalls/epoll_ctl/epoll_ctl04.c
index 955959b6b266..feb49623b15e 100644
--- a/testcases/kernel/syscalls/epoll_ctl/epoll_ctl04.c
+++ b/testcases/kernel/syscalls/epoll_ctl/epoll_ctl04.c
@@ -51,13 +51,16 @@ static void cleanup(void)
 
 static void verify_epoll_ctl(void)
 {
+	const int exp_errnos[] = {EINVAL, ELOOP};
+
 	new_epfd = epoll_create(1);
 	if (new_epfd == -1)
 		tst_brk(TBROK | TERRNO, "fail to create epoll instance");
 
 	events.data.fd = epfd;
-	TST_EXP_FAIL(epoll_ctl(new_epfd, EPOLL_CTL_ADD, epfd, &events), EINVAL,
-		     "epoll_ctl(..., EPOLL_CTL_ADD, ...) with number of nesting is 5");
+	TST_EXP_FAIL2_ARR(epoll_ctl(new_epfd, EPOLL_CTL_ADD, epfd, &events),
+		exp_errnos, ARRAY_SIZE(exp_errnos),
+		"epoll_ctl(..., EPOLL_CTL_ADD, ...) with number of nesting is 5");
 	SAFE_CLOSE(new_epfd);
 }
 
-- 
2.47.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
