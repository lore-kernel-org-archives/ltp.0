Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3260C43217
	for <ltp@archiver.kernel.org>; Fri,  4 Nov 2022 12:08:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 74BDC3CAF8B
	for <ltp@archiver.kernel.org>; Fri,  4 Nov 2022 13:08:54 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1A71D3CB410
 for <ltp@lists.linux.it>; Fri,  4 Nov 2022 13:06:10 +0100 (CET)
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
 by in-2.smtp.seeweb.it (Postfix) with ESMTP id A3BAC6008DA
 for <ltp@lists.linux.it>; Fri,  4 Nov 2022 00:30:26 +0100 (CET)
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
 by vmicros1.altlinux.org (Postfix) with ESMTP id 1379472C983;
 Fri,  4 Nov 2022 02:30:25 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [193.43.10.9])
 by imap.altlinux.org (Postfix) with ESMTPSA id C0FB54A472A;
 Fri,  4 Nov 2022 02:30:24 +0300 (MSK)
From: Vitaly Chikunov <vt@altlinux.org>
To: Cyril Hrubis <chrubis@suse.cz>,
	LTP List <ltp@lists.linux.it>
Date: Fri,  4 Nov 2022 02:30:18 +0300
Message-Id: <20221103233018.62846-1-vt@altlinux.org>
X-Mailer: git-send-email 2.33.4
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/statx01: Fix reading 64-bit mnt_id value
 from mountinfo on i586
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
Cc: "Dmitry V . Levin" <ldv@altlinux.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Fix sscanf format flag for 'uint64_t mnt_id'. Reading 'uint64_t' as
'%ld' causes intermittent false positive test error:

  statx01.c:82: TFAIL: statx.stx_mnt_id(23) is different from mount_id(13820440305888919575) in /proc/self/mountinfo

because that way 'mnt_id' is filled incompletely on 32-bit
architectures.

Reported-by: Dmitry V. Levin <ldv@altlinux.org>
Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
---
 testcases/kernel/syscalls/statx/statx01.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/statx/statx01.c b/testcases/kernel/syscalls/statx/statx01.c
index 24c5e9758..60b50958b 100644
--- a/testcases/kernel/syscalls/statx/statx01.c
+++ b/testcases/kernel/syscalls/statx/statx01.c
@@ -65,7 +65,7 @@ static void test_mnt_id(struct statx *buf)
 	file = SAFE_FOPEN("/proc/self/mountinfo", "r");
 
 	while (fgets(line, sizeof(line), file)) {
-		if (sscanf(line, "%ld %*d %d:%d", &mnt_id, &line_mjr, &line_mnr) != 3)
+		if (sscanf(line, "%"SCNu64" %*d %d:%d", &mnt_id, &line_mjr, &line_mnr) != 3)
 			continue;
 
 		if (line_mjr == buf->stx_dev_major && line_mnr == buf->stx_dev_minor)
-- 
2.33.4


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
