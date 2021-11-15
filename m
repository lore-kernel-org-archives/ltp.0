Return-Path: <SRS0=J9GY=QC=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD16FC433EF
	for <ltp@archiver.kernel.org>; Mon, 15 Nov 2021 08:15:57 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8234B61AA5
	for <ltp@archiver.kernel.org>; Mon, 15 Nov 2021 08:15:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8234B61AA5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jv-coder.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D0AD63C8154
	for <ltp@archiver.kernel.org>; Mon, 15 Nov 2021 09:15:55 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AF8843C1C46
 for <ltp@lists.linux.it>; Mon, 15 Nov 2021 09:15:35 +0100 (CET)
Received: from mail.jv-coder.de (mail.jv-coder.de [5.9.79.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 31A5E140012C
 for <ltp@lists.linux.it>; Mon, 15 Nov 2021 09:15:35 +0100 (CET)
Received: from ubuntu.localdomain (unknown [188.195.115.12])
 by mail.jv-coder.de (Postfix) with ESMTPSA id 7003A9FEAA;
 Mon, 15 Nov 2021 08:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jv-coder.de; s=dkim;
 t=1636964134; bh=fzrT0Wx+LKnHmjJbRQJB5a9LYDqjonbDNSMGd4/iC0o=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=ftePt80of4JbM4w9I0ssWbBPhKODpUujn9lIh67WkIpGOt9dkizrOPqh8OAvCvnPN
 k1zFeCKEcDw57ISu69dQrNjZDhUF08e6bTgA1ne5gs5SZLvdr9KCWpOLMgoqgWioHJ
 LJA0T9dbAGu+Vi9Kox0utHS2QzxKSbKY+lMt8Qpo=
From: Joerg Vehlow <lkml@jv-coder.de>
To: ltp@lists.linux.it,
	bogdan.lezhepekov@suse.com
Date: Mon, 15 Nov 2021 09:15:25 +0100
Message-Id: <20211115081526.384856-3-lkml@jv-coder.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211115081526.384856-1-lkml@jv-coder.de>
References: <20211115081526.384856-1-lkml@jv-coder.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/3] realtime/librttest: Fix memory leaks
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
Cc: Joerg Vehlow <joerg.vehlow@aox-tech.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Joerg Vehlow <joerg.vehlow@aox-tech.de>

Signed-off-by: Joerg Vehlow <joerg.vehlow@aox-tech.de>
---
 testcases/realtime/lib/librttest.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/testcases/realtime/lib/librttest.c b/testcases/realtime/lib/librttest.c
index 89e2bfc6e..eaa623b72 100644
--- a/testcases/realtime/lib/librttest.c
+++ b/testcases/realtime/lib/librttest.c
@@ -226,6 +226,8 @@ int rt_init_long(const char *options, const struct option *longopts,
 
 	calibrate_busyloop();
 
+	free(all_options);
+
 	/*
 	 * atexit() order matters here - buffer_print() will be called before
 	 * buffer_fini().
@@ -378,6 +380,7 @@ void join_thread(int i)
 		if (t->pthread)
 			pthread_join(t->pthread, NULL);
 		list_del(&t->_threads);
+		free(t);
 	}
 }
 
@@ -397,6 +400,7 @@ void join_threads(void)
 		if (p->pthread)
 			pthread_join(p->pthread, NULL);
 		list_del(&p->_threads);
+		free(p);
 	}
 }
 
-- 
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
