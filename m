Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAB6BCE7A94
	for <ltp@archiver.kernel.org>; Mon, 25 Sep 2023 11:36:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AE5AB3CDCF2
	for <ltp@archiver.kernel.org>; Mon, 25 Sep 2023 13:36:16 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 83D663C998B
 for <ltp@lists.linux.it>; Mon, 25 Sep 2023 13:36:05 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20629.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7d00::629])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 915F51A010B2
 for <ltp@lists.linux.it>; Mon, 25 Sep 2023 13:36:04 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H7IDpP4KvtfN2YHC2yx+HhO+0hdavFLBDKMwDjgBwwASRH89lXpeslmuwDhgPLEHJEjPYRAvGpHv3swziPguxneDBjrEI7zvDtA2FSHUjgJNDaHDDqAjENSBjlYjjEnN8x0Ip5fVp2ldoSd5u83zXv5b6ZUf9P4QoMe7/xeRAnWRdO5nssGzD3fGyQGIlk+IQHOD2jkKMwUnCxM78FfDm+Nj8G2jPsvrztmY5+V8KFyaelUQpW7bLQG13Zr8wdFEHn9qT9e40R9LxXZrujiJqGU5UN5pJTnJKAqT60sRTeCi/568zR3dl23dbt2tQjWMZTxIOiiIN3wDZFBOSXJnuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hSj9VRZd1b3NyiGWiU0BSZYWRDoS5Jcsy1H9WtYTc2A=;
 b=JHERzDzBhQDYuGzm39GSSvb1eYYFS1mAMo469IEYCxEEUq2a83THary8WG8x30HSEtkpINv5FZpbUvBY+2RmH3jDGFr9d70QfWJEVWeYAicM9dzrn6iCFQHgNfGddhCQDA7QOpOV5utcvn+09Gr3VxAlnoZ56A9b/IPt4PtFL9m+7bnzmiYsbSOVdOMBARKM58ehkHL77jy+N3EY62dQSqhxej6D51F6NAeiZuqrV8jZ5N1x/9tY2pjmOHy5U9gGvDw6iOLUrLN3x1XDAOFkAx74PaO5Q7fo/ij7pOWzBeWmi6nrbBXJ2rhCAI8XN6ii+en9kUapgptFVBPePflHVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hSj9VRZd1b3NyiGWiU0BSZYWRDoS5Jcsy1H9WtYTc2A=;
 b=aJdS8iOQnVzpbB1SHUuTQU5kEgyYFkwgR21Z8FYs1DEk61JlFbsL7RdXpjVHVc1bYZ+wb+Uy6xNhGROL9cFD+crdOVOu5bamu72ZpIqC+UwsKngdceKA58DeX27Ju4lVaGUj/1Abn53eKwMhCmpUR5SSF8NKtSjzKO0RfeVUAiv8bszElfwaJw73frkiWmvXSA0m4ZuVNQdzTj03qrgFIVvP5BAjAlBDENutYj1fBYTEDdP3Y0PvutusSl1ifugClM9RHcZC4sGAnRWPaqyPrbHfZIoLSp9yuiChYiHKTN0HI7ZbgTP5tbSmY/qgN8B6DiuQbZRFu0egkDk154LGjg==
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com (2603:10a6:20b:3f6::21)
 by DU2PR04MB8982.eurprd04.prod.outlook.com (2603:10a6:10:2e1::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 11:36:01 +0000
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::41dd:e42:e86b:c92f]) by AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::41dd:e42:e86b:c92f%4]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 11:36:01 +0000
To: Wei Gao <wegao@suse.com>, "ltp@lists.linux.it" <ltp@lists.linux.it>
Thread-Topic: [PATCH v1 2/2] d
Thread-Index: AQHZ76EHMhhRSK6sZEmg+ec9urn1KLAraXyQ
Date: Mon, 25 Sep 2023 11:36:01 +0000
Message-ID: <AS8PR04MB819968FBF293CB490CB657A3DEFCA@AS8PR04MB8199.eurprd04.prod.outlook.com>
References: <20230925110422.19167-1-wegao@suse.com>
 <20230925110422.19167-3-wegao@suse.com>
In-Reply-To: <20230925110422.19167-3-wegao@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8199:EE_|DU2PR04MB8982:EE_
x-ms-office365-filtering-correlation-id: ba653066-62e1-4043-bc2f-08dbbdbb987d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WrUJodF3pEnmHAcANvknGudCXh+ZiiJ29VCWHz6QfwpuAFnB+m3Vytu9zUBWwiQU12LKkRaUpFM08LR2/o9ZptTp15dZpf8DVGKMbmlQvt2zE8GCVw9i2pqdxXi1Tr9cRQBEJsbb1I7RL+p7z75tXPUSBVE/l7NJiw4eouGclXngDPA5wvRmwP8+7nTu5D2HHHpgXkWo9FH1eOWmWXTy6A+cHKOV/dArr63q7+5YGP6B9YNk2Pc+Aj5l+bS1MndolHu8TQqdBugBhCZrcVv3QE4ggXLGTnUzR1Wq7Vded93MFMn0jPn+ASVrlToBwe3aKZQZ5u6lZMMC35zLdjna6BQ9eNwm+91U2eOd5cyrDXWmqqrVCSJJqnQ8d5NH1JmmEWKmQrTwTcz17rm0LjJAOky5X7vhE5ydnRZJtrwyyC5NGxDRKnq+d0jQmdbc+C3jwA6jQTsKpi3a6aekkNqb43hthMqv7KJRNeAEYy4leciAT0GTKWjU4zM0nfFGhbXZ/Inon9vTsL40d/b/a4ZueDbVojvQXCOdYSqWLq7CuQhu2+inw63Faypd/G8FY6drLCAbKemXF889PypGILUj3xzlhl6tNPUXuwP2MY/x+EsnmVSSW0FhwPCyfibLxX2db0MdWx8ua5os2QwNy2w8gA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8199.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(376002)(39850400004)(136003)(346002)(230922051799003)(186009)(1800799009)(451199024)(30864003)(2906002)(52536014)(5660300002)(110136005)(66946007)(66476007)(66446008)(64756008)(66556008)(76116006)(478600001)(71200400001)(53546011)(9686003)(7696005)(26005)(6506007)(8936002)(8676002)(316002)(41300700001)(83380400001)(122000001)(86362001)(38100700002)(38070700005)(55016003)(33656002)(2004002)(579004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AiJq9LEyyYX57rw6T9wT4rbd6RQ2VznEjBwJm9yNTRPoP6yEIpQulbiSNLDd?=
 =?us-ascii?Q?bdm0z4i8g4tN7/742uMgBfbp7vJIaflUZHFcd/QJOSSOqWzJ3E6WtWG4VuvK?=
 =?us-ascii?Q?LuhpiAHFFKiDSHDgB/PD0zKJmmXiNoJaiXwADHTyyKbJhuLU2dBI6BqttB71?=
 =?us-ascii?Q?geCyfibEr0NGSkMR1O5CT/EfsJs49E9BWPEMsLGXoMusTksEIQdj8/qtDYQo?=
 =?us-ascii?Q?xiovK6P7OsioBEpxfd27yXvEYZxl8wtAupZUzMJ3NhOHLPCqMl92r+NVZRAT?=
 =?us-ascii?Q?8c0WbBzZ+8GzXb1dzqFXpj1o3qGOhUD6duqQtXaOxvxOMSB5jaYxkRrKufY+?=
 =?us-ascii?Q?k1kmlhIYAYNh/6owgT3aM8dZWbq6GRhkZl2m5/BQX+Rstm077M7DiVWyxARu?=
 =?us-ascii?Q?lLCrkPV0strsfJ1NhyeZluJ0Yq/VfMc8oekYOeSHSq1vWFTGfy34Y0Ra9mrf?=
 =?us-ascii?Q?/02oes4uG2oH/m4vaFhE3HobxON0ncuzYcppMizORjMorhraXd136QOvttYb?=
 =?us-ascii?Q?U1xMnfJnd/smrssihMvA2ATW/KPhOq5DeLcpyhsgmL0C/l29Elg/SvK3kvj8?=
 =?us-ascii?Q?QNvwYrsnKOIt2jeXEczR6TW7ItfPkwuNuIwWNCwP8KG14pAbWH61bpRWYUlt?=
 =?us-ascii?Q?0pU7kRwpmpjNhDgMhES0Q4SJZqVb7BwUyMvZo1ZkYfsn/R2JWgScXVVF0ooB?=
 =?us-ascii?Q?2ygwLoOGl7bgIYPkyvkrfR69naw6gqNJGzrlEMJJRzSeADBs2tHTZboTHRJQ?=
 =?us-ascii?Q?nBn2z77aXi6/PN1DWIbIdEAeqQE7cO2mb01orhctLH6F6oPmB/eKQhbmJsgc?=
 =?us-ascii?Q?tgQGYwR/ilc5m+89ZjxjxR8/7TWR250Xzzu+6JF7GK1XQhBAoY0y2XHuDgbs?=
 =?us-ascii?Q?yYptx8oUlyKQEwXxihd3O/AuBMRROirYVarUUSCA74WiBusqtTp+Hc99p+fv?=
 =?us-ascii?Q?ZJaLj6hfnGtfRTGijeejLsPDcnX4I5nM3OrBlmglog6Y0fSRwx80LGwFzXOf?=
 =?us-ascii?Q?y9RznEuRN57zKkhImDZzVfISOsgGSkpoz3olpm1rewGZzLIEum6YoE+6pzfN?=
 =?us-ascii?Q?q9uuWRmFMVPjxrDTWApXct6/Nuiq9m3hye62VBvk2MQspybgdyXRJZd/Z+Fp?=
 =?us-ascii?Q?yKhPxTuNkzGH5HyrGXNySXSAzvqsJr4Cs4CAU2r9IA4+6IYDP53tYLEw+JUM?=
 =?us-ascii?Q?wWOUzdsazXqg7t8hPdTdo/L2XmkWC8DpkkP5GcPk0f/mwA6x/fFm4dMWUS2l?=
 =?us-ascii?Q?ZLJIP+Vs9eeLu/bri3iJK12IF00GpzLptSRp0nQtMlZbNxU+evEVPwqz//y7?=
 =?us-ascii?Q?Cw3tVf/Ye75FvnrdqfhpJUkgae3q1IaQiWpu+WgreJqH65VUECUhX4iWalIH?=
 =?us-ascii?Q?uPkpkGI1XCGkK5X1uwadxSswL+qcFcKT9yfvTzsNxuky1019RRy7EvJsJgRT?=
 =?us-ascii?Q?487TaueKCPoLvRZmS7KS2ELc/9vLwv5rHWGMUcJLTwbCWp9GC9kW1hLwEhTi?=
 =?us-ascii?Q?KtRIv1ysmAXZH9ts3sxqJ52QLrA58AuLOvXw3L965ahM1mDbPld7ADZeW40e?=
 =?us-ascii?Q?+WFXYSYdhYrCMLcXEws=3D?=
MIME-Version: 1.0
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8199.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba653066-62e1-4043-bc2f-08dbbdbb987d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2023 11:36:01.7716 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XTw5Q7zOdsxytSo0B+zUL/WolcNrsN/+iHFx49hk1BUhadpBY2s4DfNTIiXEYrvf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8982
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 2/2] d
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Sorry for the garbage email, please SKIP this email.

-----Original Message-----
From: Wei Gao <wegao@suse.com> 
Sent: Monday, September 25, 2023 7:04 PM
To: Wei Gao <wegao@suse.com>; ltp@lists.linux.it
Subject: [PATCH v1 2/2] d

Signed-off-by: Wei Gao <wegao@suse.com>
---
 testcases/kernel/syscalls/ptrace/ptrace05.c | 147 +++-------  testcases/kernel/syscalls/ptrace/ptrace06.c | 306 +++++++++++---------
 2 files changed, 214 insertions(+), 239 deletions(-)

diff --git a/testcases/kernel/syscalls/ptrace/ptrace05.c b/testcases/kernel/syscalls/ptrace/ptrace05.c
index 54cfa4d7b..4904b959c 100644
--- a/testcases/kernel/syscalls/ptrace/ptrace05.c
+++ b/testcases/kernel/syscalls/ptrace/ptrace05.c
@@ -1,122 +1,67 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
- ******************************************************************************
- *
- *   ptrace05 - an app which ptraces itself as per arbitrarily specified signals,
- *   over a user specified range.
- *
- *   Copyright (C) 2009, Ngie Cooper
- *
- *   This program is free software; you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY; without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *   GNU General Public License for more details.
+ * Copyright (C) 2009, Ngie Cooper
+ * Copyright (c) 2023 Wei Gao <wegao@suse.com> */
+
+/*\
+ * [Description]
  *
- *   You should have received a copy of the GNU General Public License along
- *   with this program; if not, write to the Free Software Foundation, Inc.,
- *   51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  ptrace05 - an app which ptraces itself as per arbitrarily specified 
+ signals
  *
- ******************************************************************************
  */
 
-#include <sys/types.h>
-#include <sys/wait.h>
-#include <signal.h>
-#include <errno.h>
-#include <libgen.h>
-#include <math.h>
 #include <stdlib.h>
-#include <stdio.h>
-#include <string.h>
-#include <unistd.h>
-
 #include <config.h>
 #include "ptrace.h"
 
-#include "test.h"
 #include "lapi/signal.h"
+#include "tst_test.h"
 
-char *TCID = "ptrace05";
-int TST_TOTAL = 0;
-
-int usage(const char *);
-
-int usage(const char *argv0)
-{
-	fprintf(stderr, "usage: %s [start-signum] [end-signum]\n", argv0);
-	return 1;
-}
-
-int main(int argc, char **argv)
+static void run(void)
 {
 
-	int end_signum = -1;
-	int signum;
-	int start_signum = -1;
+	int end_signum = SIGRTMAX;
+	int signum = 0;
+	int start_signum = 0;
 	int status;
 
 	pid_t child;
 
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	if (start_signum == -1) {
-		start_signum = 0;
-	}
-	if (end_signum == -1) {
-		end_signum = SIGRTMAX;
-	}
-
 	for (signum = start_signum; signum <= end_signum; signum++) {
 
-		if (signum >= __SIGRTMIN && signum < SIGRTMIN)
-			continue;
-
-		switch (child = fork()) {
+		switch (child = SAFE_FORK()) {
 		case -1:
-			tst_brkm(TBROK | TERRNO, NULL, "fork() failed");
+			tst_brk(TBROK | TERRNO, "fork() failed");
 		case 0:
 
-			if (ptrace(PTRACE_TRACEME, 0, NULL, NULL) != -1) {
-				tst_resm(TINFO, "[child] Sending kill(.., %d)",
-					 signum);
-				if (kill(getpid(), signum) < 0) {
-					tst_resm(TINFO | TERRNO,
-						 "[child] kill(.., %d) failed.",
-						 signum);
-				}
+			TEST(ptrace(PTRACE_TRACEME, 0, NULL, NULL));
+			if (TST_RET != -1) {
+				tst_res(TINFO, "[child] Sending kill(.., %d)",
+						signum);
+				SAFE_KILL(getpid(), signum);
 			} else {
-
-				/*
-				 * This won't increment the TST_COUNT var.
-				 * properly, but it'll show up as a failure
-				 * nonetheless.
-				 */
-				tst_resm(TFAIL | TERRNO,
+				tst_brk(TFAIL | TERRNO,
 					 "Failed to ptrace(PTRACE_TRACEME, ...) "
 					 "properly");
-
 			}
-			/* Shouldn't get here if signum == 0. */
-			exit((signum == 0 ? 0 : 2));
+
+			exit(0);
 			break;
 
 		default:
 
-			waitpid(child, &status, 0);
+			SAFE_WAITPID(child, &status, 0);
 
 			switch (signum) {
 			case 0:
 				if (WIFEXITED(status)
 				    && WEXITSTATUS(status) == 0) {
-					tst_resm(TPASS,
+					tst_res(TPASS,
 						 "kill(.., 0) exited "
 						 "with 0, as expected.");
 				} else {
-					tst_resm(TFAIL,
+					tst_brk(TFAIL | TERRNO,
 						 "kill(.., 0) didn't exit "
 						 "with 0.");
 				}
@@ -125,20 +70,20 @@ int main(int argc, char **argv)
 				if (WIFSIGNALED(status)) {
 					/* SIGKILL must be uncatchable. */
 					if (WTERMSIG(status) == SIGKILL) {
-						tst_resm(TPASS,
+						tst_res(TPASS,
 							 "Killed with SIGKILL, "
 							 "as expected.");
 					} else {
-						tst_resm(TPASS,
+						tst_brk(TFAIL | TERRNO,
 							 "Didn't die with "
 							 "SIGKILL (?!) ");
 					}
 				} else if (WIFEXITED(status)) {
-					tst_resm(TFAIL,
+					tst_brk(TFAIL | TERRNO,
 						 "Exited unexpectedly instead "
 						 "of dying with SIGKILL.");
 				} else if (WIFSTOPPED(status)) {
-					tst_resm(TFAIL,
+					tst_brk(TFAIL | TERRNO,
 						 "Stopped instead of dying "
 						 "with SIGKILL.");
 				}
@@ -146,35 +91,21 @@ int main(int argc, char **argv)
 				/* All other processes should be stopped. */
 			default:
 				if (WIFSTOPPED(status)) {
-					tst_resm(TPASS, "Stopped as expected");
+					tst_res(TPASS, "Stopped as expected");
 				} else {
-					tst_resm(TFAIL, "Didn't stop as "
+					tst_brk(TFAIL | TERRNO, "Didn't stop as "
 						 "expected.");
-					if (kill(child, 0)) {
-						tst_resm(TINFO,
-							 "Is still alive!?");
-					} else if (WIFEXITED(status)) {
-						tst_resm(TINFO,
-							 "Exited normally");
-					} else if (WIFSIGNALED(status)) {
-						tst_resm(TINFO,
-							 "Was signaled with "
-							 "signum=%d",
-							 WTERMSIG(status));
-					}
-
 				}
-
 				break;
-
 			}
-
 		}
-		/* Make sure the child dies a quick and painless death ... */
-		kill(child, 9);
 
+		if (signum != 0 && signum != 9)
+			SAFE_PTRACE(PTRACE_CONT, child, NULL, NULL);
 	}
-
-	tst_exit();
-
 }
+
+static struct tst_test test = {
+	.test_all = run,
+	.forks_child = 1,
+};
diff --git a/testcases/kernel/syscalls/ptrace/ptrace06.c b/testcases/kernel/syscalls/ptrace/ptrace06.c
index c0cb3b9bd..5829faea4 100644
--- a/testcases/kernel/syscalls/ptrace/ptrace06.c
+++ b/testcases/kernel/syscalls/ptrace/ptrace06.c
@@ -1,32 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
+ * Copyright (c) 2008 Analog Devices Inc.
+ * Copyright (c) 2023 Wei Gao <wegao@suse.com> */
+
+/*\
+ * [Description]
+ *
  * check out-of-bound/unaligned addresses given to
  *  - {PEEK,POKE}{DATA,TEXT,USER}
  *  - {GET,SET}{,FG}REGS
  *  - {GET,SET}SIGINFO
  *
- * Copyright (c) 2008 Analog Devices Inc.
- *
- * Licensed under the GPL-2 or later
  */
 
 #define _GNU_SOURCE
 
-#include <errno.h>
-#include <stdbool.h>
-#include <stdio.h>
 #include <stdlib.h>
-#include <unistd.h>
-
 #include <config.h>
-#include "ptrace.h"
 
-#include "test.h"
-#include "spawn_ptrace_child.h"
-#include "config.h"
+#include "ptrace.h"
+#include "tst_test.h"
 
 /* this should be sizeof(struct user), but that info is only found
  * in the kernel asm/user.h which is not exported to userspace.
  */
+
 #if defined(__i386__)
 #define SIZEOF_USER 284
 #elif defined(__x86_64__)
@@ -35,168 +34,213 @@
 #define SIZEOF_USER 0x1000	/* just pick a big number */
 #endif
 
-char *TCID = "ptrace06";
-
 struct test_case_t {
 	int request;
 	long addr;
 	long data;
 } test_cases[] = {
 	{
-	PTRACE_PEEKDATA,.addr = 0}, {
-	PTRACE_PEEKDATA,.addr = 1}, {
-	PTRACE_PEEKDATA,.addr = 2}, {
-	PTRACE_PEEKDATA,.addr = 3}, {
-	PTRACE_PEEKDATA,.addr = -1}, {
-	PTRACE_PEEKDATA,.addr = -2}, {
-	PTRACE_PEEKDATA,.addr = -3}, {
-	PTRACE_PEEKDATA,.addr = -4}, {
-	PTRACE_PEEKTEXT,.addr = 0}, {
-	PTRACE_PEEKTEXT,.addr = 1}, {
-	PTRACE_PEEKTEXT,.addr = 2}, {
-	PTRACE_PEEKTEXT,.addr = 3}, {
-	PTRACE_PEEKTEXT,.addr = -1}, {
-	PTRACE_PEEKTEXT,.addr = -2}, {
-	PTRACE_PEEKTEXT,.addr = -3}, {
-	PTRACE_PEEKTEXT,.addr = -4}, {
-	PTRACE_PEEKUSER,.addr = SIZEOF_USER + 1}, {
-	PTRACE_PEEKUSER,.addr = SIZEOF_USER + 2}, {
-	PTRACE_PEEKUSER,.addr = SIZEOF_USER + 3}, {
-	PTRACE_PEEKUSER,.addr = SIZEOF_USER + 4}, {
-	PTRACE_PEEKUSER,.addr = -1}, {
-	PTRACE_PEEKUSER,.addr = -2}, {
-	PTRACE_PEEKUSER,.addr = -3}, {
-	PTRACE_PEEKUSER,.addr = -4}, {
-	PTRACE_POKEDATA,.addr = 0}, {
-	PTRACE_POKEDATA,.addr = 1}, {
-	PTRACE_POKEDATA,.addr = 2}, {
-	PTRACE_POKEDATA,.addr = 3}, {
-	PTRACE_POKEDATA,.addr = -1}, {
-	PTRACE_POKEDATA,.addr = -2}, {
-	PTRACE_POKEDATA,.addr = -3}, {
-	PTRACE_POKEDATA,.addr = -4}, {
-	PTRACE_POKETEXT,.addr = 0}, {
-	PTRACE_POKETEXT,.addr = 1}, {
-	PTRACE_POKETEXT,.addr = 2}, {
-	PTRACE_POKETEXT,.addr = 3}, {
-	PTRACE_POKETEXT,.addr = -1}, {
-	PTRACE_POKETEXT,.addr = -2}, {
-	PTRACE_POKETEXT,.addr = -3}, {
-	PTRACE_POKETEXT,.addr = -4}, {
-	PTRACE_POKEUSER,.addr = SIZEOF_USER + 1}, {
-	PTRACE_POKEUSER,.addr = SIZEOF_USER + 2}, {
-	PTRACE_POKEUSER,.addr = SIZEOF_USER + 3}, {
-	PTRACE_POKEUSER,.addr = SIZEOF_USER + 4}, {
-	PTRACE_POKEUSER,.addr = -1}, {
-	PTRACE_POKEUSER,.addr = -2}, {
-	PTRACE_POKEUSER,.addr = -3}, {
-	PTRACE_POKEUSER,.addr = -4},
+	PTRACE_PEEKDATA, .addr = 0}, {
+	PTRACE_PEEKDATA, .addr = 1}, {
+	PTRACE_PEEKDATA, .addr = 2}, {
+	PTRACE_PEEKDATA, .addr = 3}, {
+	PTRACE_PEEKDATA, .addr = -1}, {
+	PTRACE_PEEKDATA, .addr = -2}, {
+	PTRACE_PEEKDATA, .addr = -3}, {
+	PTRACE_PEEKDATA, .addr = -4}, {
+	PTRACE_PEEKTEXT, .addr = 0}, {
+	PTRACE_PEEKTEXT, .addr = 1}, {
+	PTRACE_PEEKTEXT, .addr = 2}, {
+	PTRACE_PEEKTEXT, .addr = 3}, {
+	PTRACE_PEEKTEXT, .addr = -1}, {
+	PTRACE_PEEKTEXT, .addr = -2}, {
+	PTRACE_PEEKTEXT, .addr = -3}, {
+	PTRACE_PEEKTEXT, .addr = -4}, {
+	PTRACE_PEEKUSER, .addr = SIZEOF_USER + 1}, {
+	PTRACE_PEEKUSER, .addr = SIZEOF_USER + 2}, {
+	PTRACE_PEEKUSER, .addr = SIZEOF_USER + 3}, {
+	PTRACE_PEEKUSER, .addr = SIZEOF_USER + 4}, {
+	PTRACE_PEEKUSER, .addr = -1}, {
+	PTRACE_PEEKUSER, .addr = -2}, {
+	PTRACE_PEEKUSER, .addr = -3}, {
+	PTRACE_PEEKUSER, .addr = -4}, {
+	PTRACE_POKEDATA, .addr = 0}, {
+	PTRACE_POKEDATA, .addr = 1}, {
+	PTRACE_POKEDATA, .addr = 2}, {
+	PTRACE_POKEDATA, .addr = 3}, {
+	PTRACE_POKEDATA, .addr = -1}, {
+	PTRACE_POKEDATA, .addr = -2}, {
+	PTRACE_POKEDATA, .addr = -3}, {
+	PTRACE_POKEDATA, .addr = -4}, {
+	PTRACE_POKETEXT, .addr = 0}, {
+	PTRACE_POKETEXT, .addr = 1}, {
+	PTRACE_POKETEXT, .addr = 2}, {
+	PTRACE_POKETEXT, .addr = 3}, {
+	PTRACE_POKETEXT, .addr = -1}, {
+	PTRACE_POKETEXT, .addr = -2}, {
+	PTRACE_POKETEXT, .addr = -3}, {
+	PTRACE_POKETEXT, .addr = -4}, {
+	PTRACE_POKEUSER, .addr = SIZEOF_USER + 1}, {
+	PTRACE_POKEUSER, .addr = SIZEOF_USER + 2}, {
+	PTRACE_POKEUSER, .addr = SIZEOF_USER + 3}, {
+	PTRACE_POKEUSER, .addr = SIZEOF_USER + 4}, {
+	PTRACE_POKEUSER, .addr = -1}, {
+	PTRACE_POKEUSER, .addr = -2}, {
+	PTRACE_POKEUSER, .addr = -3}, {
+	PTRACE_POKEUSER, .addr = -4},
 #ifdef PTRACE_GETREGS
 	{
-	PTRACE_GETREGS,.data = 0}, {
-	PTRACE_GETREGS,.data = 1}, {
-	PTRACE_GETREGS,.data = 2}, {
-	PTRACE_GETREGS,.data = 3}, {
-	PTRACE_GETREGS,.data = -1}, {
-	PTRACE_GETREGS,.data = -2}, {
-	PTRACE_GETREGS,.data = -3}, {
-	PTRACE_GETREGS,.data = -4},
+	PTRACE_GETREGS, .data = 0}, {
+	PTRACE_GETREGS, .data = 1}, {
+	PTRACE_GETREGS, .data = 2}, {
+	PTRACE_GETREGS, .data = 3}, {
+	PTRACE_GETREGS, .data = -1}, {
+	PTRACE_GETREGS, .data = -2}, {
+	PTRACE_GETREGS, .data = -3}, {
+	PTRACE_GETREGS, .data = -4},
 #endif
 #ifdef PTRACE_GETFGREGS
 	{
-	PTRACE_GETFGREGS,.data = 0}, {
-	PTRACE_GETFGREGS,.data = 1}, {
-	PTRACE_GETFGREGS,.data = 2}, {
-	PTRACE_GETFGREGS,.data = 3}, {
-	PTRACE_GETFGREGS,.data = -1}, {
-	PTRACE_GETFGREGS,.data = -2}, {
-	PTRACE_GETFGREGS,.data = -3}, {
-	PTRACE_GETFGREGS,.data = -4},
+	PTRACE_GETFGREGS, .data = 0}, {
+	PTRACE_GETFGREGS, .data = 1}, {
+	PTRACE_GETFGREGS, .data = 2}, {
+	PTRACE_GETFGREGS, .data = 3}, {
+	PTRACE_GETFGREGS, .data = -1}, {
+	PTRACE_GETFGREGS, .data = -2}, {
+	PTRACE_GETFGREGS, .data = -3}, {
+	PTRACE_GETFGREGS, .data = -4},
 #endif
 #ifdef PTRACE_SETREGS
 	{
-	PTRACE_SETREGS,.data = 0}, {
-	PTRACE_SETREGS,.data = 1}, {
-	PTRACE_SETREGS,.data = 2}, {
-	PTRACE_SETREGS,.data = 3}, {
-	PTRACE_SETREGS,.data = -1}, {
-	PTRACE_SETREGS,.data = -2}, {
-	PTRACE_SETREGS,.data = -3}, {
-	PTRACE_SETREGS,.data = -4},
+	PTRACE_SETREGS, .data = 0}, {
+	PTRACE_SETREGS, .data = 1}, {
+	PTRACE_SETREGS, .data = 2}, {
+	PTRACE_SETREGS, .data = 3}, {
+	PTRACE_SETREGS, .data = -1}, {
+	PTRACE_SETREGS, .data = -2}, {
+	PTRACE_SETREGS, .data = -3}, {
+	PTRACE_SETREGS, .data = -4},
 #endif
 #ifdef PTRACE_SETFGREGS
 	{
-	PTRACE_SETFGREGS,.data = 0}, {
-	PTRACE_SETFGREGS,.data = 1}, {
-	PTRACE_SETFGREGS,.data = 2}, {
-	PTRACE_SETFGREGS,.data = 3}, {
-	PTRACE_SETFGREGS,.data = -1}, {
-	PTRACE_SETFGREGS,.data = -2}, {
-	PTRACE_SETFGREGS,.data = -3}, {
-	PTRACE_SETFGREGS,.data = -4},
+	PTRACE_SETFGREGS, .data = 0}, {
+	PTRACE_SETFGREGS, .data = 1}, {
+	PTRACE_SETFGREGS, .data = 2}, {
+	PTRACE_SETFGREGS, .data = 3}, {
+	PTRACE_SETFGREGS, .data = -1}, {
+	PTRACE_SETFGREGS, .data = -2}, {
+	PTRACE_SETFGREGS, .data = -3}, {
+	PTRACE_SETFGREGS, .data = -4},
 #endif
 #if HAVE_DECL_PTRACE_GETSIGINFO
 	{
-	PTRACE_GETSIGINFO,.data = 0}, {
-	PTRACE_GETSIGINFO,.data = 1}, {
-	PTRACE_GETSIGINFO,.data = 2}, {
-	PTRACE_GETSIGINFO,.data = 3}, {
-	PTRACE_GETSIGINFO,.data = -1}, {
-	PTRACE_GETSIGINFO,.data = -2}, {
-	PTRACE_GETSIGINFO,.data = -3}, {
-	PTRACE_GETSIGINFO,.data = -4},
+	PTRACE_GETSIGINFO, .data = 0}, {
+	PTRACE_GETSIGINFO, .data = 1}, {
+	PTRACE_GETSIGINFO, .data = 2}, {
+	PTRACE_GETSIGINFO, .data = 3}, {
+	PTRACE_GETSIGINFO, .data = -1}, {
+	PTRACE_GETSIGINFO, .data = -2}, {
+	PTRACE_GETSIGINFO, .data = -3}, {
+	PTRACE_GETSIGINFO, .data = -4},
 #endif
 #if HAVE_DECL_PTRACE_SETSIGINFO
 	{
-	PTRACE_SETSIGINFO,.data = 0}, {
-	PTRACE_SETSIGINFO,.data = 1}, {
-	PTRACE_SETSIGINFO,.data = 2}, {
-	PTRACE_SETSIGINFO,.data = 3}, {
-	PTRACE_SETSIGINFO,.data = -1}, {
-	PTRACE_SETSIGINFO,.data = -2}, {
-	PTRACE_SETSIGINFO,.data = -3}, {
-	PTRACE_SETSIGINFO,.data = -4},
+	PTRACE_SETSIGINFO, .data = 0}, {
+	PTRACE_SETSIGINFO, .data = 1}, {
+	PTRACE_SETSIGINFO, .data = 2}, {
+	PTRACE_SETSIGINFO, .data = 3}, {
+	PTRACE_SETSIGINFO, .data = -1}, {
+	PTRACE_SETSIGINFO, .data = -2}, {
+	PTRACE_SETSIGINFO, .data = -3}, {
+	PTRACE_SETSIGINFO, .data = -4},
+#endif
+};
+
+#define SPT(x) [PTRACE_##x] = #x,
+static char *strings[] = {
+	SPT(TRACEME)
+	SPT(PEEKTEXT)
+	SPT(PEEKDATA)
+	SPT(PEEKUSER)
+	SPT(POKETEXT)
+	SPT(POKEDATA)
+	SPT(POKEUSER)
+#ifdef PTRACE_GETREGS
+	SPT(GETREGS)
+#endif
+#ifdef PTRACE_SETREGS
+	SPT(SETREGS)
+#endif
+#ifdef PTRACE_GETSIGINFO
+	SPT(GETSIGINFO)
+#endif
+#ifdef PTRACE_SETSIGINFO
+	SPT(SETSIGINFO)
+#endif
+#ifdef PTRACE_GETFGREGS
+	SPT(GETFGREGS)
+#endif
+#ifdef PTRACE_SETFGREGS
+	SPT(SETFGREGS)
 #endif
+	SPT(KILL)
+	SPT(SINGLESTEP)
 };
 
-int TST_TOTAL = ARRAY_SIZE(test_cases);
+static inline char *strptrace(int request) {
+	return strings[request];
+}
+
+static void child(void)
+{
+	SAFE_PTRACE(PTRACE_TRACEME, 0, NULL, NULL);
+	execl("/bin/echo", "/bin/echo", NULL);
+	exit(0);
+}
 
-int main(int argc, char *argv[])
+static void run(void)
 {
 	size_t i;
-	long ret;
-	int saved_errno;
+	int pid;
+	int status;
 
-	tst_parse_opts(argc, argv, NULL, NULL);
+	pid = SAFE_FORK();
 
-	make_a_baby(argc, argv);
+	if (!pid)
+		child();
+
+	SAFE_WAIT(&status);
+
+	if (!WIFSTOPPED(status))
+		tst_brk(TBROK, "child %d was not stopped", pid);
 
 	for (i = 0; i < ARRAY_SIZE(test_cases); ++i) {
 		struct test_case_t *tc = &test_cases[i];
 
-		errno = 0;
-		ret =
-		    ptrace(tc->request, pid, (void *)tc->addr,
-			   (void *)tc->data);
-		saved_errno = errno;
-		if (ret != -1)
-			tst_resm(TFAIL,
+		TEST(ptrace(tc->request, pid, (void *)tc->addr,
+					(void *)tc->data));
+		if (TST_RET != -1)
+			tst_brk(TFAIL | TERRNO,
 				 "ptrace(%s, ..., %li, %li) returned %li instead of -1",
 				 strptrace(tc->request), tc->addr, tc->data,
-				 ret);
-		else if (saved_errno != EIO && saved_errno != EFAULT)
-			tst_resm(TFAIL,
+				 TST_RET);
+		else if (TST_ERR != EIO && TST_ERR != EFAULT)
+			tst_brk(TFAIL | TERRNO,
 				 "ptrace(%s, ..., %li, %li) expected errno EIO or EFAULT; actual: %i (%s)",
 				 strptrace(tc->request), tc->addr, tc->data,
-				 saved_errno, strerror(saved_errno));
+				 TST_ERR, strerror(TST_ERR));
 		else
-			tst_resm(TPASS,
+			tst_res(TPASS,
 				 "ptrace(%s, ..., %li, %li) failed as expected",
 				 strptrace(tc->request), tc->addr, tc->data);
 	}
 
-	/* hopefully this worked */
-	ptrace(PTRACE_KILL, pid, NULL, NULL);
+	SAFE_PTRACE(PTRACE_CONT, pid, NULL, NULL);
 
-	tst_exit();
 }
+
+static struct tst_test test = {
+	.test_all = run,
+	.forks_child = 1,
+};
--
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
