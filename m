Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A78EC636CD
	for <ltp@archiver.kernel.org>; Tue,  7 Feb 2023 08:21:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 437C53CC23A
	for <ltp@archiver.kernel.org>; Tue,  7 Feb 2023 09:21:16 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0816E3CB111
 for <ltp@lists.linux.it>; Tue,  7 Feb 2023 09:21:05 +0100 (CET)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 911E91400BE8
 for <ltp@lists.linux.it>; Tue,  7 Feb 2023 09:21:02 +0100 (CET)
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 3178KrIH065144;
 Tue, 7 Feb 2023 16:20:53 +0800 (+08)
 (envelope-from minachou@andestech.com)
Received: from atctrx.andestech.com (10.0.15.173) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.498.0; Tue, 7 Feb 2023
 16:20:51 +0800
From: Hui Min Mina Chou <minachou@andestech.com>
To: <ltp@lists.linux.it>, <pvorel@suse.cz>, <chrubis@suse.cz>
Date: Tue, 7 Feb 2023 16:20:41 +0800
Message-ID: <20230207082041.1021333-1-minachou@andestech.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Originating-IP: [10.0.15.173]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 3178KrIH065144
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/getrusage04:Fix tst_resm() format string for
 64bit offset
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
Cc: tim609@andestech.com, az70021@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

This patch fixes the incorrect output on 32bit platform.
The correct way to print tv_usec is cast it to (long long) type and
change the format string to %lld.

Signed-off-by: Hui Min Mina Chou <minachou@andestech.com>
---
 testcases/kernel/syscalls/getrusage/getrusage04.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/syscalls/getrusage/getrusage04.c b/testcases/kernel/syscalls/getrusage/getrusage04.c
index 06b576d79..b03bc549b 100644
--- a/testcases/kernel/syscalls/getrusage/getrusage04.c
+++ b/testcases/kernel/syscalls/getrusage/getrusage04.c
@@ -104,8 +104,9 @@ int main(int argc, char *argv[])
 		tst_count = 0;
 		i = 0;
 		SAFE_GETRUSAGE(cleanup, RUSAGE_THREAD, &usage);
-		tst_resm(TINFO, "utime:%12luus; stime:%12luus",
-			 usage.ru_utime.tv_usec, usage.ru_stime.tv_usec);
+		tst_resm(TINFO, "utime:%12lldus; stime:%12lldus",
+			 (long long)usage.ru_utime.tv_usec,
+			 (long long)usage.ru_stime.tv_usec);
 		ulast = usage.ru_utime.tv_usec;
 		slast = usage.ru_stime.tv_usec;
 
@@ -115,9 +116,9 @@ int main(int argc, char *argv[])
 			sdelta = usage.ru_stime.tv_usec - slast;
 			if (udelta > 0 || sdelta > 0) {
 				i++;
-				tst_resm(TINFO, "utime:%12luus; stime:%12luus",
-					 usage.ru_utime.tv_usec,
-					 usage.ru_stime.tv_usec);
+				tst_resm(TINFO, "utime:%12lldus; stime:%12lldus",
+					 (long long)usage.ru_utime.tv_usec,
+					 (long long)usage.ru_stime.tv_usec);
 				if ((long)udelta > 1000 + (BIAS_MAX * factor_nr)) {
 					sprintf(msg_string,
 						"utime increased > %ldus:",
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
