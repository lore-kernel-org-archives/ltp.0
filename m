Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A171AC19F2D
	for <ltp@archiver.kernel.org>; Tue,  9 Aug 2022 08:33:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 47B063C9590
	for <ltp@archiver.kernel.org>; Tue,  9 Aug 2022 10:33:41 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 804A73C0596
 for <ltp@lists.linux.it>; Tue,  9 Aug 2022 10:33:31 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 0187020093B
 for <ltp@lists.linux.it>; Tue,  9 Aug 2022 10:33:27 +0200 (CEST)
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 2798XKXW018699;
 Tue, 9 Aug 2022 16:33:20 +0800 (+08)
 (envelope-from dylan@andestech.com)
Received: from atctrx.andestech.com (10.0.12.119) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.498.0; Tue, 9 Aug 2022
 16:33:18 +0800
From: Dylan Jhong <dylan@andestech.com>
To: <ltp@lists.linux.it>
Date: Tue, 9 Aug 2022 16:27:01 +0800
Message-ID: <20220809082701.2366582-1-dylan@andestech.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Originating-IP: [10.0.12.119]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 2798XKXW018699
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] pan/ltp-pan.c: Add execution time field in
 results/logs
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
Cc: alankao@andestech.com, dminus@andestech.com, randolph@andestech.com,
 x5710999x@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The current log only shows the success or failure of testcases, but
execution time is also one of the important indicators to observe LTP
testcases.

In this patch, we modified the format of the logs in results/ and added
a column to record the execution time.

Signed-off-by: Dylan Jhong <dylan@andestech.com>
---
 pan/ltp-pan.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/pan/ltp-pan.c b/pan/ltp-pan.c
index 0bdb51477..1bb255b4a 100644
--- a/pan/ltp-pan.c
+++ b/pan/ltp-pan.c
@@ -132,7 +132,11 @@ zoo_t zoofile;
 static char *reporttype = NULL;
 
 /* Common format string for ltp-pan results */
-#define ResultFmt	"%-50s %-10.10s"
+#define ResultFmt           "%-50s %-10.10s"
+#define ExitValTitleFmt     "%-12.12s"
+#define ExitValFmt          "%-12d"
+#define ExecTimeTitleFmt    "%-20.20s"
+#define ExecTimeFmt         "%-20d"
 
 /* zoolib */
 int rec_signal;			/* received signal */
@@ -354,10 +358,10 @@ int main(int argc, char **argv)
 			fprintf(logfile, "Test Start Time: %s\n", s);
 			fprintf(logfile,
 				"-----------------------------------------\n");
-			fprintf(logfile, ResultFmt" %-10.10s\n",
-				"Testcase", "Result", "Exit Value");
-			fprintf(logfile, ResultFmt" %-10.10s\n",
-				"--------", "------", "------------");
+			fprintf(logfile, ResultFmt" "ExitValTitleFmt" "ExecTimeTitleFmt"\n",
+				"Testcase", "Result", "Exit Value", "Execution Time(sec)");
+			fprintf(logfile, ResultFmt" "ExitValTitleFmt" "ExecTimeTitleFmt"\n",
+				"--------", "------", "----------", "-------------------");
 		}
 		fflush(logfile);
 	}
@@ -829,10 +833,11 @@ check_pids(struct tag_pgrp *running, int *num_active, int keep_active,
 						}
 
 						fprintf(logfile,
-							ResultFmt" %-5d\n",
+							ResultFmt" "ExitValFmt" "ExecTimeFmt"\n",
 							running[i].cmd->name,
 							result_str,
-							w);
+							w,
+							(int)(t - running[i].mystime));
 					}
 
 					fflush(logfile);
@@ -1108,10 +1113,11 @@ run_child(struct coll_entry *colle, struct tag_pgrp *active, int quiet_mode,
 				if (termid != 0)
 					++ * failcnt;
 
-				fprintf(logfile, ResultFmt" %-5d\n",
+				fprintf(logfile, ResultFmt" "ExitValFmt" "ExecTimeFmt"\n",
 					colle->name,
 					((termid != 0) ? "FAIL" : "PASS"),
-					termid);
+					termid,
+					(int)(end_time - active->mystime));
 			}
 			fflush(logfile);
 		}
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
