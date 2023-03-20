Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 873D9C7618A
	for <ltp@archiver.kernel.org>; Mon, 20 Mar 2023 09:23:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 77C633CCC52
	for <ltp@archiver.kernel.org>; Mon, 20 Mar 2023 10:23:49 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D06D23C5ACF
 for <ltp@lists.linux.it>; Mon, 20 Mar 2023 10:23:39 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id BA260200077
 for <ltp@lists.linux.it>; Mon, 20 Mar 2023 10:23:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679304217;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=VFwVzqW+J8P2AFQNi1yB/oWGb15ZS7OsMin3Epg7UWg=;
 b=cX6d7WaygVz/pa3mCxA/CdRHpN16FuBiHRoByOR/ZBuiRDkBUed8rjOAXsUgzJs6o7oaNh
 XNXb4QV0RR1Ok9DWSEOF/dT/6jy9Z+tvw7v35Y+Tbry+2b0gAs7Lvr3DyR87//hcTchiKD
 D0p8Sxuok9TPEue9cuQ4KUb/HcPa2Ck=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-387-PuJd026YNv-A_COxumN35Q-1; Mon, 20 Mar 2023 05:23:35 -0400
X-MC-Unique: PuJd026YNv-A_COxumN35Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 81E2E1C05191
 for <ltp@lists.linux.it>; Mon, 20 Mar 2023 09:23:35 +0000 (UTC)
Received: from nay-workstation.nay.redhat.com (unused-66-82-86.nay.redhat.com
 [10.66.82.86])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 46CBC2166B29;
 Mon, 20 Mar 2023 09:23:33 +0000 (UTC)
From: Ping Fang <pifang@redhat.com>
To: ltp@lists.linux.it
Date: Mon, 20 Mar 2023 17:23:32 +0800
Message-Id: <20230320092332.36187-1-pifang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] getcpu01: Fix strtoul incorrectly returns 0
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
Cc: shichen@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

get_nodeid() find nodeid by iterate /sys/devices/system/node/nodeX/cpuY.
But there are cpulist and cpumap, which will report 0 in strtoul.
On multi-node numa system, the last iteration nodeX directory mismatch
the cpu0 node id. Then fail the test. The following shows on a 4 node
numa system. The last iteration stopped under /node1. so expected node
id 1. Then failed.

getcpu01.c:98: TINFO: cpu:0, cpu_id:0, de->d_name:node2
getcpu01.c:99: TINFO: dn->d_name:cpulist
getcpu01.c:98: TINFO: cpu:0, cpu_id:0, de->d_name:node0
getcpu01.c:99: TINFO: dn->d_name:cpulist
getcpu01.c:98: TINFO: cpu:0, cpu_id:0, de->d_name:node3
getcpu01.c:99: TINFO: dn->d_name:cpulist
getcpu01.c:98: TINFO: cpu:0, cpu_id:0, de->d_name:node1
getcpu01.c:99: TINFO: dn->d_name:cpulist
getcpu01.c:128: TFAIL: getcpu() returned wrong value expected  node id:1
returned  node id:0, cpu_set:0

Reported-by: Shizhao Chen <shichen@redhat.com>
Signed-off-by: Ping Fang <pifang@redhat.com>
---
 testcases/kernel/syscalls/getcpu/getcpu01.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/getcpu/getcpu01.c b/testcases/kernel/syscalls/getcpu/getcpu01.c
index f6fcc4fc1..9842c8999 100644
--- a/testcases/kernel/syscalls/getcpu/getcpu01.c
+++ b/testcases/kernel/syscalls/getcpu/getcpu01.c
@@ -69,6 +69,7 @@ static unsigned int get_nodeid(unsigned int cpu_id)
 	DIR *directory_parent, *directory_node;
 	struct dirent *de, *dn;
 	char directory_path[PATH_MAX];
+	char *invalid_number;
 	unsigned int cpu;
 	int node_id = 0;
 
@@ -91,7 +92,9 @@ static unsigned int get_nodeid(unsigned int cpu_id)
 			while ((dn = readdir(directory_node)) != NULL) {
 				if (strncmp(dn->d_name, "cpu", 3))
 					continue;
-				cpu = strtoul(dn->d_name + 3, NULL, 0);
+				cpu = strtoul(dn->d_name + 3, &invalid_number, 0);
+				if (strcmp(invalid_number, "\0"))
+					continue;
 				if (cpu == cpu_id) {
 					node_id =
 					    strtoul(de->d_name + 4, NULL, 0);
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
