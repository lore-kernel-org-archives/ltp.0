Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0610DC4332F
	for <ltp@archiver.kernel.org>; Wed, 19 Oct 2022 02:18:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 54DB63CB107
	for <ltp@archiver.kernel.org>; Wed, 19 Oct 2022 04:18:57 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BCD5E3C87AD
 for <ltp@lists.linux.it>; Wed, 19 Oct 2022 04:18:46 +0200 (CEST)
Received: from mail3.bemta32.messagelabs.com (mail3.bemta32.messagelabs.com
 [195.245.230.82])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 990FD1000A42
 for <ltp@lists.linux.it>; Wed, 19 Oct 2022 04:18:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1666145924; i=@fujitsu.com;
 bh=dgxViXUkbs9CMiMqWbUbBuK+yRCYZcRctv8OvReiOIA=;
 h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=IO4hG8KDpMDHlu3si4/++9c8Fdw/lJkCEP3dJYh8XnjEV+LF1G1Na6OO0ipFEhKJ7
 UY9MVYfkVRR8l9FixraY715y/CQdcXXwdQHMBEvQhgPKPKszdfGihZex91VhlCNkk4
 2XuG1O8HiYNrUG6Iv6EKg+jw8q3kc40iy+3BJOtDmK/7VMnZkG/UoeECbF1z6J6hCO
 pybKCUO34qaop36CUHyXIptkAiTo/Q1+wmZYi3IfPketDR9GisB27hBjmViD+suPc/
 YFYPeWWhk2loAVKFAhNgLqKESRTP+8uxh8hE5ugOtq7+SvPssGGeZhm6ESUQmu7U6u
 GlBhGNqKwegXw==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFIsWRWlGSWpSXmKPExsViZ8OxWbc5zj/
 Z4N5mTYsV33cwOjB67Pu9jjWAMYo1My8pvyKBNWPrrmXMBX9ZKp7e/8XewLiJpYuRi0NI4BSj
 xMvv3ewQzl4miS8n7zF3MXICOXsYJVq3KoDYbAKaEs86F4DFRQQkJDoa3rKD2MwC6hLLJ/1iA
 rGFBZwkft/8DRZnEVCV2Ny5CSzOK+Apsf7rZUYQW0JAQWLKw/fMEHFBiZMzn7BAzJGQOPjiBT
 NEjaLEpY5vUPUVErNmtTFB2GoSV89tYp7AyD8LSfssJO0LGJlWMZoVpxaVpRbpGprpJRVlpme
 U5CZm5uglVukm6qWW6panFpfoGuollhfrpRYX6xVX5ibnpOjlpZZsYgQGY0ox0/MdjGeX/dE7
 xCjJwaQkyjvnm1+yEF9SfkplRmJxRnxRaU5q8SFGGQ4OJQlegQj/ZCHBotT01Iq0zBxgZMCkJ
 Th4lER4SyKB0rzFBYm5xZnpEKlTjLocm/Z1HWAWYsnLz0uVEufNjQUqEgApyijNgxsBi9JLjL
 JSwryMDAwMQjwFqUW5mSWo8q8YxTkYlYR5E0FW8WTmlcBtegV0BBPQEaZb/ECOKElESEk1MM0
 8KFbrV3DFcH9rv3xMUuYCt8Nyh7ibpzVrzv2sbX5t5oHITxN1zszmk+SfEiOnISS2QyR+9tHy
 5su+QRK6vBvOv9Av5/jydk28qqDtq8kN18x+v1we+PZXfDmz0n6nZ8xzi/7asL2b0RnCsCXl6
 Z/zkfNv5S3jWXzESGbK1rJ8iWOWuWUJKd8dXp40WOBx52BoQ73Q8SenDze836Ajfu4S9zZV9g
 Px3DtPMUpVHSk28/kj+vtF4/v34bYq2Zqx3Js3HCoKOCQX1t2uLPD128292QJ2GlsaE39OY9C
 38Uz7dvxz1b8QjshrbAL1LE8vzD+zr3B+37/gxDQP7TN33RrErfQ2rIhOKpos+FLpnxJLcUai
 oRZzUXEiAOOBBjlNAwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-8.tower-585.messagelabs.com!1666145923!17908!1
X-Originating-IP: [62.60.8.179]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.100.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 13965 invoked from network); 19 Oct 2022 02:18:43 -0000
Received: from unknown (HELO n03ukasimr04.n03.fujitsu.local) (62.60.8.179)
 by server-8.tower-585.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 19 Oct 2022 02:18:43 -0000
Received: from n03ukasimr04.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTP id 526D5156
 for <ltp@lists.linux.it>; Wed, 19 Oct 2022 03:18:43 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126
 [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTPS id 45FCA142
 for <ltp@lists.linux.it>; Wed, 19 Oct 2022 03:18:43 +0100 (BST)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Wed, 19 Oct 2022 03:18:41 +0100
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Wed, 19 Oct 2022 11:19:13 +0800
Message-ID: <1666149553-26514-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] tst_safe_file_at: Add missing stat related header
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

This fixes compilation on apline:last.

I have verified this[1].

[1]https://github.com/xuyang0410/ltp/actions/runs/3278267589/jobs/5396469021

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 include/tst_safe_file_at.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/tst_safe_file_at.h b/include/tst_safe_file_at.h
index 082a5acd9..a1aa19fad 100644
--- a/include/tst_safe_file_at.h
+++ b/include/tst_safe_file_at.h
@@ -7,6 +7,8 @@
 #define TST_SAFE_FILE_AT_H
 
 #include <sys/types.h>
+#include <sys/stat.h>
+#include <unistd.h>
 #include <stdarg.h>
 
 #define SAFE_OPENAT(dirfd, path, oflags, ...)			\
-- 
2.27.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
