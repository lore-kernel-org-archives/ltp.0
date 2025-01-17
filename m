Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90FC6C02183
	for <ltp@archiver.kernel.org>; Fri, 17 Jan 2025 13:58:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5B0C53C7BC6
	for <ltp@archiver.kernel.org>; Fri, 17 Jan 2025 14:58:39 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9825D3C2204
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 14:58:22 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=afazekas@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id F3DF6142E9F3
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 14:58:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737122300;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=0beefTFvZzpZwEpF4/5tJwAz3RVPnkp6RudxClAh6Z8=;
 b=XW3ckYtZnVonxYf+Ji1ACnBRVCKjt7qc03rHhwOTvgTTY/8yjpnRt7K6bGSJsw/QdeV4pl
 LlffB5VTy2pbGWp6N4qk5pgyWoeHskMDBBD+myUe3P3Fj2/S4qVgRChTQsDcMQCGUrKcrL
 WHbJeIN0NmJ0R/OXVoaf3ZyAdZSbh+8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-387-RUHsauMkMwmer6LD-MMSVQ-1; Fri,
 17 Jan 2025 08:58:18 -0500
X-MC-Unique: RUHsauMkMwmer6LD-MMSVQ-1
X-Mimecast-MFC-AGG-ID: RUHsauMkMwmer6LD-MMSVQ
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 04E5319560BB
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 13:58:18 +0000 (UTC)
Received: from interceptor.brq.redhat.com (unknown [10.43.2.84])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0D78119560B0; Fri, 17 Jan 2025 13:58:16 +0000 (UTC)
From: Attila Fazekas <afazekas@redhat.com>
To: ltp@lists.linux.it
Date: Fri, 17 Jan 2025 14:57:43 +0100
Message-ID: <20250117135745.909549-1-afazekas@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Sl6seleCZAWym2kBJhFoBKB4HhqBtPqpZIp-Z0hEerA_1737122298
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/2] sched_football: isolcpus handling
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

sched_football expects each player thread is scheduleable
to all of the physical CPU threads, however for example
when you are using isolcpus by default you threads are
not scheduled to some CPU. It leads to the test hangs.
591c56b045b2d44a0f4ba1a13545420b23e909b5 solved was a 
similar issue in realtime/prio-preempt .

Attila Fazekas (2):
  lib: move get_numcpus to librttest.[ch]
  sched_football: use get_numcpus()

 testcases/realtime/func/prio-preempt/prio-preempt.c | 13 -------------
 .../realtime/func/sched_football/sched_football.c   |  2 +-
 testcases/realtime/include/librttest.h              |  4 ++++
 testcases/realtime/lib/librttest.c                  | 13 +++++++++++++
 4 files changed, 18 insertions(+), 14 deletions(-)

-- 
2.47.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
