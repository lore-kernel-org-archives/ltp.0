Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DE78C5DF88
	for <ltp@archiver.kernel.org>; Fri, 21 Aug 2026 05:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1787291662; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=UjK3LggC0P7nJRABHQufPds3Tfn6q2QRmqPqr7cJJ/8=;
 b=Q3t/hp4Xuoz2xHVvWxf8O1puKTqvz2FpIeSAK/75AM0Nw6C44/GOGue4MLajFtKZAYYyR
 nDqTRYcwtOPqsO4mt6MLh3c+xNOurn3lHsJ9khrQBczIMTSoYvQS9HbrSbmgSWEHNYQaFsj
 SQWrwEt4aXalOL0nE2VQLAeKhfHl1x0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1DA583CFF65
	for <ltp@archiver.kernel.org>; Fri, 21 Aug 2026 07:54:22 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 412733CF417
 for <ltp@lists.linux.it>; Fri, 21 Aug 2026 07:53:57 +0200 (CEST)
Received: from Atcsqr.andestech.com (atcsqr.andestech.com [220.128.198.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id DFCDF1400335
 for <ltp@lists.linux.it>; Fri, 21 Aug 2026 07:53:54 +0200 (CEST)
Received: from mail.andestech.com (atcpcs53.andestech.com [10.0.1.153])
 by Atcsqr.andestech.com with ESMTPS id 67L5rl6Z038043
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <ltp@lists.linux.it>; Fri, 21 Aug 2026 13:53:47 +0800 (+08)
 (envelope-from cyyang772@andestech.com)
Received: from ATCPCS34.andestech.com (10.0.1.134) by atcpcs53.andestech.com
 (10.0.1.153) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.43; Fri, 21 Aug
 2026 13:53:47 +0800
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS34.andestech.com
 (10.0.1.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Aug
 2026 13:53:46 +0800
To: <ltp@lists.linux.it>
Date: Fri, 21 Aug 2026 13:53:41 +0800
Message-ID: <20260821055341.2079284-1-cyyang772@andestech.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs53.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 67L5rl6Z038043
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] starvation: honor -t instead of calibrating
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
From: Victor Cheng-Yen Yang via ltp <ltp@lists.linux.it>
Reply-To: Victor Cheng-Yen Yang <cyyang772@andestech.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

tst_parse_int() returns 0 both when the option is absent and when it
parses successfully, so its return value cannot distinguish the two.

Use the zero-initialized timeout as the "not set" sentinel and skip
calibration entirely when -t is supplied correctly.

Signed-off-by: Victor Cheng-Yen Yang <cyyang772@andestech.com>
---
 testcases/kernel/sched/cfs-scheduler/starvation.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/sched/cfs-scheduler/starvation.c b/testcases/kernel/sched/cfs-scheduler/starvation.c
index 045254ba4..ff041bdcd 100644
--- a/testcases/kernel/sched/cfs-scheduler/starvation.c
+++ b/testcases/kernel/sched/cfs-scheduler/starvation.c
@@ -107,7 +107,8 @@ static void setup(void)
 
 	if (tst_parse_int(str_timeout, &timeout, 1, INT_MAX))
 		tst_brk(TBROK, "Invalid number of timeout '%s'", str_timeout);
-	else
+
+	if (!timeout)
 		timeout = callibrate() / 1000;
 
 	if (tst_has_slow_kconfig())
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
