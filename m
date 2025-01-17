Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3E41C02188
	for <ltp@archiver.kernel.org>; Fri, 17 Jan 2025 13:59:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5BC333C7C2B
	for <ltp@archiver.kernel.org>; Fri, 17 Jan 2025 14:59:20 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 32E013C7BD8
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 14:58:26 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=afazekas@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 970C6620DCA
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 14:58:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737122304;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PdxdlPr9inzf0PAvG8DnNOHRXeyzzzP6zHNQbS8EOBA=;
 b=cinsqprzwhZr9uIstPXKwT/bOC7U69lWKiBVTWrsE2JPJcbamM7Z04vSi/Vs1XurH7k4Jq
 0ZXwkTdgwEAPUeAO+3xkIjY/XZLSqOFzZC3NEaXgmqJeHe7SeYZeMVvf0y9o5Qy9yHOUaw
 58jdMZWvnWjkcHfswzx4UAUR7E9QWCM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-472--y-kQb4xMBWZjzypv17g1w-1; Fri,
 17 Jan 2025 08:58:22 -0500
X-MC-Unique: -y-kQb4xMBWZjzypv17g1w-1
X-Mimecast-MFC-AGG-ID: -y-kQb4xMBWZjzypv17g1w
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6E94E195608B
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 13:58:21 +0000 (UTC)
Received: from interceptor.brq.redhat.com (unknown [10.43.2.84])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 564FB19560A3; Fri, 17 Jan 2025 13:58:19 +0000 (UTC)
From: Attila Fazekas <afazekas@redhat.com>
To: ltp@lists.linux.it
Date: Fri, 17 Jan 2025 14:57:45 +0100
Message-ID: <20250117135745.909549-3-afazekas@redhat.com>
In-Reply-To: <20250117135745.909549-1-afazekas@redhat.com>
References: <20250117135745.909549-1-afazekas@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: KD3V_Vf9Ec6etLV4QvBDpTd9NSNPwiFoozy5nlD7TJs_1737122301
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/2] sched_football: use get_numcpus()
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

sched_football can hang in systems where not all CPU cores
are available, using get_numcpus() to account
for things like isolated cores.

Signed-off-by: Attila Fazekas <afazekas@redhat.com>
---
 testcases/realtime/func/sched_football/sched_football.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/realtime/func/sched_football/sched_football.c b/testcases/realtime/func/sched_football/sched_football.c
index 763b41f23..5ffc1ff46 100644
--- a/testcases/realtime/func/sched_football/sched_football.c
+++ b/testcases/realtime/func/sched_football/sched_football.c
@@ -140,7 +140,7 @@ static void do_test(void)
 	int i;
 
 	if (players_per_team == 0)
-		players_per_team = sysconf(_SC_NPROCESSORS_ONLN);
+		players_per_team = get_numcpus();
 
 	tst_atomic_store(0, &players_ready);
 
-- 
2.47.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
