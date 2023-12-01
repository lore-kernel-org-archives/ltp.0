Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B5D2C4167B
	for <ltp@archiver.kernel.org>; Fri,  1 Dec 2023 00:59:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 678383CDC2D
	for <ltp@archiver.kernel.org>; Fri,  1 Dec 2023 01:59:44 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D3C8F3CB29F
 for <ltp@lists.linux.it>; Fri,  1 Dec 2023 01:59:26 +0100 (CET)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04on0622.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0c::622])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 013C5603131
 for <ltp@lists.linux.it>; Fri,  1 Dec 2023 01:59:26 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NmvJ3xuq15rlQgS1sDLNMNNwyNOrBBd3q9+5LCcDD3t4IBYORPsw9s3hbkDCYwwy6k3S4kxD6rxjCIBpxTPrI4AshMshAfHBBgZYVDJxT5quk95F1IdCEu38UVNRq6K/XEmyfZoBfWC/JAtzp8/3mX0/IyUde2BEIe5UWU8AHObTwcPm3oHnxmlPK+MDXJeDTDtL0uNf7emLZUQKgFjzjUqhLxUgyAAj65Ai9iWQ6cbERxZgIG9xXXW9BsAmDC5VyntXkrjlxhhUk7b32Ga8F3TwoR8nQRZNF4RcqWaHueBP8eVudkGxS9uWz0RqS7uaH72HILxMuU27DEA+CDw5aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uTTqh3cyIqDbKz74Jlu7XgxBlYBlBgALoqngIf325uM=;
 b=PNqSJMazuPrV5jg2dPh0uESdqVAeAJX/ICupcWFTXfq+B0M82ZmLlwqaaAIbDVRWlPnKY+JgE4PTTl8v37evmZg8Fewg+75XD0Ty4oR9boddD1XHMGWlquLTmArI40qArJ59PFTjQdGOnuuGAnjHJwPeDNptfvu+BbPG34Mt5UWlKmLgrsBmvR1QkTfZgX7VONxBUvWa6WijiQt1WKre4AxjnONVAVvwtpJ0rVehIi6AM51vdhtGpq/L+eCRvT11EDP508JfilSKr6wgHVp8RVifLJVILk5GqhuMDVrgw9igqD9TBjFdHIZtX00dtsppySNpMgyONL47FiUS5s/r8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uTTqh3cyIqDbKz74Jlu7XgxBlYBlBgALoqngIf325uM=;
 b=zeSGTjJogIPKHZyPzRJWQgPcuRei+U1U82coXZFVkaAk34F3c1Kg4aAhMH5iEBdey4AR6zCOpLqjx1mwNkoKmf4jKqdhaWVL/KbiL1Tvle+f+oJawMfRdxKFyve0DK+K5ubKZaCsJZIPv3fNOUY27O6MIxvMqgvmaSsk7L5qyXRQvwJ/jpPo8OHe0EQz/LmMA8yBWZaxBA/+uMmi/srCCTQOeu7ESdcZ8Lj0srxYWHE+UidkKCcLofbfs8SbHoB3JNsnxYKsM0op8xv8aN1XFvJkFxmhwJx1yWltx6q3r/sC33ugCMOq01hLAVMKA3GDQevrdGCiwQmNy3LlXz8oHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com (2603:10a6:20b:3f6::21)
 by AS8PR04MB8183.eurprd04.prod.outlook.com (2603:10a6:20b:3f1::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.15; Fri, 1 Dec
 2023 00:59:24 +0000
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::9d39:5718:5401:764d]) by AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::9d39:5718:5401:764d%5]) with mapi id 15.20.7068.012; Fri, 1 Dec 2023
 00:59:24 +0000
To: ltp@lists.linux.it
Date: Thu, 30 Nov 2023 19:59:01 -0500
Message-Id: <20231201005902.15630-2-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231201005902.15630-1-wegao@suse.com>
References: <20230925112245.30701-1-wegao@suse.com>
 <20231201005902.15630-1-wegao@suse.com>
X-ClientProxiedBy: VI1PR08CA0213.eurprd08.prod.outlook.com
 (2603:10a6:802:15::22) To AS8PR04MB8199.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8199:EE_|AS8PR04MB8183:EE_
X-MS-Office365-Filtering-Correlation-Id: 442782f1-c443-4d69-d455-08dbf208c286
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DG+KwhhEflDOti1cF8QcXCYUmBE9UBpVqZ+T1hdoEyn1an7M04UTHybuVAmiT2QkeV8PrYnLzjoAJxPOhDHRUe8NzU4aW6ihygQST+HARL/aGwkHGVdtsVhAV4VxORPCDHeCmyy0rbdfrvC02ARivaf6Dugd4T4vjlH27cPWBK3a3y+LQkrVll11KBqaFDNyc8Ny3qHhd7hiqdhlJLMhSmVRDnXcjs3Q9ZOBTym+wLMpeqHMMT7oPGVEbvd5ky+Bcg9n47kVvhN01CxqoM9dQEPJ4fqWfIfx78Od+AaSDWPNDt5Ri7w5Pjiekn6J14s2anYXPdAwMO078B2xNXEvHDv0WsEUWPsNsXr9DWfoPFVeLi+hS2jjo6T2lQaZ2HLntQBzy7m5pDaiUwk8GlChcjY0EvVQ3Dxa/tuKpgSByGkWNXXBSZuf17fJMbF734IwXVx+Q7iPaYTn2Hf/+tuntxJWCmOHYZvBcEGhwsmf10s6dSp1GddxgLOZHJKZIKv9NjolhBpKCV5FdxLqgtgBCyveixTwuEbv9Um9aFabyCZhME50B2xK5Dv8iLG8H1sS42iOcrn1hrtF/Oi1M4IvPWHcwk/8I5xnjchda6HDpJY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8199.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(366004)(376002)(346002)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(83380400001)(26005)(2616005)(107886003)(1076003)(86362001)(36756003)(38100700002)(5660300002)(6512007)(6506007)(6666004)(508600001)(4326008)(66946007)(6916009)(66476007)(66556008)(8676002)(8936002)(316002)(2906002)(41300700001)(6486002)(2004002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EDTjYH2Eve3xr8y4mKbbyIzUuX7p0ws7JTGhnzcS5jzr/bMAOAJLaoUfQXuN?=
 =?us-ascii?Q?zoaDYJjnG3KROOjyUZKnrI5glCD/UwAXO3i/9fp14eK6AxssqPHfSUXqieE2?=
 =?us-ascii?Q?bIF5arkW2JefkiwNrJfv8OpbgbldsUVteq+CulieenSOhr67S8xIuziBqSx3?=
 =?us-ascii?Q?1VBN+wkr7H7JbG2kksW9tk0C15rSVMS3AmdPAUJ8beVb4Ae9JWYctGMGYqRQ?=
 =?us-ascii?Q?M+XnB4uJX5SNbWWCGWRpcM5XzExY1Ig/pXBiFmzGOsTsEBrp/Ae8F1LPytRH?=
 =?us-ascii?Q?pvAhqLrcsPITh8X17YbdRcvqAc0jbq/CYYwqfBJ1FdtJ5G+R6drDgi4LaOGn?=
 =?us-ascii?Q?SvGLpHFXmDxmcrcRq/rQk0lniUT2PnmiKgW3kHoo3Q2XVKtSE6zHtNduXl/X?=
 =?us-ascii?Q?arm7ro6mFq9vehy6RM1pHkxLv8zQ5qOMOkoqVJ2dqxg+3Z0oMhIR5hivq79r?=
 =?us-ascii?Q?5EH3Vgo75934hYLgi4NlKU7ArjYLB2Ew4mRmIvYkdmxyXfijIhuioZwUjP3s?=
 =?us-ascii?Q?iphPQ8HaYQAzItpxsABbX5TZtlG3K8wwE7/FBlo+/Dd5tMdZT/WxJRT4ErKZ?=
 =?us-ascii?Q?+YK4nWG9pcfL+LO16neRFNXCId47csh8gQ9JVNWAqZZBit3kYIctpO7yR92F?=
 =?us-ascii?Q?JBkMWcVYqqmpw9IwJnSakhVE0/6Z77FHoua7zXQtPgK6LE5mg/YusBBVYgSw?=
 =?us-ascii?Q?4o0P2y8N3/UIBEbq4kxyfXR+M6iS+ExUVtI6JbSaVKb2HhBxa5VZrybqECOU?=
 =?us-ascii?Q?K0SLhdpQOx4sKa9bQgdr2ysRL3lEfroiiPGH4R7N+9jt86qpgaVDSpbEE0YM?=
 =?us-ascii?Q?PIeB579NsiNiUgCDVsiwQTUbWLOBu+WQdg4EN4TGetm3kyJC/qRmSUHRSH2l?=
 =?us-ascii?Q?qNCCVMuelqj4guELcC4h6ugf5tNwKJ5mbFwP4xlHs7PEHfmk1WEbRHkjCf5m?=
 =?us-ascii?Q?IQIjkuJqI7xg7Z2DSPzuEx5f4XfXIgMtTvFx0UV+OCbTe9W+T96uMAQHqgSC?=
 =?us-ascii?Q?KGV5L2pQ3R8W/+PNOy7hgtQbzMM4kENfwamZS601CJu3Fh/ozV8EfyDA6upU?=
 =?us-ascii?Q?hlQhPDWD1f4WuusfzJ9queGVIxhU/BASjyJei18MSpGjIk2PFtVM6VzU1RrT?=
 =?us-ascii?Q?fUsLgvz5JJPRkHlsuurcBlLmY8lYwrBmJrojSvVhcoQezEPaad1qsGqC7eVD?=
 =?us-ascii?Q?qwHuzVamZy+amNCW8Iovov2riVKzvWtoRnDTTpd7eG81wKBR4lHSMO1RfmvH?=
 =?us-ascii?Q?jmhZL3lqQXLBWbxBZj0Y7apF9PwiqzbiwI3YRhJNhevna3YjHsD92uAOAM0j?=
 =?us-ascii?Q?jYzfKZDIV2r7EaI7kckX1rzrbaJrJzIC8zteE5qXBl3wXHjEZvuEBXs4g6Cj?=
 =?us-ascii?Q?pSH1zamUT+/AxY62zZ8ds0t7cjKO1PLReLfwT6xozkECVJrOGIykRPyQcpTr?=
 =?us-ascii?Q?/PGGAM+/U/nQ296QWf9lmMlKWnVN8W+dDKRqClX8QlOtVoe5NgEAuN8FeOiG?=
 =?us-ascii?Q?yNkdoJR4GJmdkOw8nisedvh4uh9zO68KEr4wYrql7xrTOm7nxd080suqX0TF?=
 =?us-ascii?Q?2FHtjd9muJMIgOAo2lk=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 442782f1-c443-4d69-d455-08dbf208c286
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8199.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 00:59:24.4731 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ryKocAdxhY0SzMIfOZzqxBUhGj2vmMgMhEhrazOcs4e0WoZQFgwiWZ3WZPFaEovj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8183
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/2] ptrace05: Refactor the test using new LTP API
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

Signed-off-by: Wei Gao <wegao@suse.com>
---
 testcases/kernel/syscalls/ptrace/ptrace05.c | 179 ++++++--------------
 1 file changed, 50 insertions(+), 129 deletions(-)

diff --git a/testcases/kernel/syscalls/ptrace/ptrace05.c b/testcases/kernel/syscalls/ptrace/ptrace05.c
index 541018393..267d5f9d2 100644
--- a/testcases/kernel/syscalls/ptrace/ptrace05.c
+++ b/testcases/kernel/syscalls/ptrace/ptrace05.c
@@ -1,178 +1,99 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
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
+ * Copyright (c) Linux Test Project, 2009-2019
+ * Copyright (C) 2009, Ngie Cooper
+ * Copyright (c) 2023 Wei Gao <wegao@suse.com>
+ */
+
+/*\
+ * [Description]
  *
- *   You should have received a copy of the GNU General Public License along
- *   with this program; if not, write to the Free Software Foundation, Inc.,
- *   51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ * This test ptraces itself as per arbitrarily specified signals,
+ * over 0 to SIGRTMAX range.
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
 #include <sys/ptrace.h>
-
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
+	int signum = 0;
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
-	for (signum = start_signum; signum <= end_signum; signum++) {
-
+	for (signum = 0; signum <= SIGRTMAX; signum++) {
 		if (signum >= __SIGRTMIN && signum < SIGRTMIN)
 			continue;
 
-		switch (child = fork()) {
-		case -1:
-			tst_brkm(TBROK | TERRNO, NULL, "fork() failed");
-		case 0:
+		child = SAFE_FORK();
 
-			if (ptrace(PTRACE_TRACEME, 0, NULL, NULL) != -1) {
-				tst_resm(TINFO, "[child] Sending kill(.., %d)",
-					 signum);
-				if (kill(getpid(), signum) < 0) {
-					tst_resm(TINFO | TERRNO,
-						 "[child] kill(.., %d) failed.",
-						 signum);
-				}
+		if (child == 0) {
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
-					 "Failed to ptrace(PTRACE_TRACEME, ...) "
-					 "properly");
-
+				tst_brk(TFAIL | TERRNO,
+						"Failed to ptrace(PTRACE_TRACEME, ...) "
+						"properly");
 			}
+
 			/* Shouldn't get here if signum == 0. */
 			exit((signum == 0 ? 0 : 2));
-			break;
-
-		default:
-
-			waitpid(child, &status, 0);
+		} else {
+			SAFE_WAITPID(child, &status, 0);
 
 			switch (signum) {
 			case 0:
 				if (WIFEXITED(status)
 				    && WEXITSTATUS(status) == 0) {
-					tst_resm(TPASS,
-						 "kill(.., 0) exited "
-						 "with 0, as expected.");
+					tst_res(TPASS,
+						 "kill(.., 0) exited with 0, as expected.");
 				} else {
-					tst_resm(TFAIL,
-						 "kill(.., 0) didn't exit "
-						 "with 0.");
+					tst_brk(TFAIL | TERRNO,
+						 "kill(.., 0) didn't exit with 0.");
 				}
 				break;
 			case SIGKILL:
 				if (WIFSIGNALED(status)) {
 					/* SIGKILL must be uncatchable. */
 					if (WTERMSIG(status) == SIGKILL) {
-						tst_resm(TPASS,
-							 "Killed with SIGKILL, "
-							 "as expected.");
+						tst_res(TPASS,
+							 "Killed with SIGKILL, as expected.");
 					} else {
-						tst_resm(TPASS,
-							 "Didn't die with "
-							 "SIGKILL (?!) ");
+						tst_brk(TFAIL | TERRNO,
+							 "Didn't die with SIGKILL (?!) ");
 					}
 				} else if (WIFEXITED(status)) {
-					tst_resm(TFAIL,
-						 "Exited unexpectedly instead "
-						 "of dying with SIGKILL.");
+					tst_res(TFAIL | TERRNO,
+						 "Exited unexpectedly instead of dying with SIGKILL.");
 				} else if (WIFSTOPPED(status)) {
-					tst_resm(TFAIL,
-						 "Stopped instead of dying "
-						 "with SIGKILL.");
+					tst_res(TFAIL | TERRNO,
+						 "Stopped instead of dying with SIGKILL.");
 				}
 				break;
 				/* All other processes should be stopped. */
 			default:
-				if (WIFSTOPPED(status)) {
-					tst_resm(TPASS, "Stopped as expected");
-				} else {
-					tst_resm(TFAIL, "Didn't stop as "
-						 "expected.");
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
-				}
-
+				if (WIFSTOPPED(status))
+					tst_res(TPASS, "Stopped as expected");
+				else
+					tst_res(TFAIL | TERRNO, "Didn't stop as expected.");
 				break;
-
 			}
 
 		}
-		/* Make sure the child dies a quick and painless death ... */
-		kill(child, 9);
-
+		if (signum != 0 && signum != SIGKILL)
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
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
