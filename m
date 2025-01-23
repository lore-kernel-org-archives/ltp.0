Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 632ACC02182
	for <ltp@archiver.kernel.org>; Thu, 23 Jan 2025 11:19:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7EF743C2E38
	for <ltp@archiver.kernel.org>; Thu, 23 Jan 2025 12:19:30 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B4E6E3C2BB9
 for <ltp@lists.linux.it>; Thu, 23 Jan 2025 12:19:14 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=afazekas@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C4FA61BE4D21
 for <ltp@lists.linux.it>; Thu, 23 Jan 2025 12:19:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737631151;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=HeYNt0SGdsjkM/kEDZQtD8zGHSU9pa4vlen5TY0dpeU=;
 b=KfvN5Z2mdeFXjG1/Qt5mY6GF3ZZUnTpIuKPpn/gociBYTIODPDphw0OIgJz1EbZxXf0vcB
 CGJANC5hQB4UWWkQNQN4gLJe8+utTV+ZCuZZbHL79Hhdfwmw2WRe3h7CsQec/OlGFDfFpn
 Up6lMu/YtRvV69bhtVJ+GCWszRbzdSg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-567-SnefL-usP5G0SVPVuXs99w-1; Thu,
 23 Jan 2025 06:19:10 -0500
X-MC-Unique: SnefL-usP5G0SVPVuXs99w-1
X-Mimecast-MFC-AGG-ID: SnefL-usP5G0SVPVuXs99w
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A62A01956087
 for <ltp@lists.linux.it>; Thu, 23 Jan 2025 11:19:09 +0000 (UTC)
Received: from interceptor.brq.redhat.com (unknown [10.43.2.84])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9466C195608A; Thu, 23 Jan 2025 11:19:08 +0000 (UTC)
From: Attila Fazekas <afazekas@redhat.com>
To: ltp@lists.linux.it
Date: Thu, 23 Jan 2025 12:18:54 +0100
Message-ID: <20250123111854.28412-1-afazekas@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9_Gftanjr7kH4y55LWzbCCfSCZiwZTNMKv_PGupU7NA_1737631149
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] realtime/librttest: get_numcpus() fix leak
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
Cc: Attila Fazekas <afazekas@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

As pointed out on the mailing list this function has
a memory leak, fixing it.

Signed-off-by: Attila Fazekas <afazekas@redhat.com>
---
 testcases/realtime/lib/librttest.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/testcases/realtime/lib/librttest.c b/testcases/realtime/lib/librttest.c
index 03566f36d..99ce78b33 100644
--- a/testcases/realtime/lib/librttest.c
+++ b/testcases/realtime/lib/librttest.c
@@ -768,11 +768,13 @@ int get_numcpus(void)
 {
 	long numcpus_conf = sysconf(_SC_NPROCESSORS_CONF);
 	size_t size = CPU_ALLOC_SIZE(numcpus_conf);
+	int cpu_count;
 	cpu_set_t *cpuset = CPU_ALLOC(numcpus_conf);
 
 	CPU_ZERO_S(size, cpuset);
 	/* Get the number of cpus accessible to the current process */
 	sched_getaffinity(0, size, cpuset);
-
-	return CPU_COUNT_S(size, cpuset);
+	cpu_count = CPU_COUNT_S(size, cpuset);
+	CPU_FREE(cpuset);
+	return cpu_count;
 }
-- 
2.47.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
