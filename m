Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBE63C4332F
	for <ltp@archiver.kernel.org>; Tue, 22 Nov 2022 16:00:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 366133CCAF2
	for <ltp@archiver.kernel.org>; Tue, 22 Nov 2022 17:00:09 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A00623CCAB6
 for <ltp@lists.linux.it>; Tue, 22 Nov 2022 09:01:55 +0100 (CET)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com
 [205.220.166.238])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8D19C140B2CE
 for <ltp@lists.linux.it>; Tue, 22 Nov 2022 09:01:51 +0100 (CET)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
 by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 2AM7Virg016737; Tue, 22 Nov 2022 00:01:41 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
 h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=PPS06212021;
 bh=Z4BKuG7zzXD5DB2LNa1ylfJiPsiOfUvx5EUQF9sfOhc=;
 b=r0wlXOeMutNPKd6WPBtf6tjgITo/6eotn6rdIEO7LJSo76R1+qrKMNTmTuS81QYnUm5s
 1DBEYguq5yEXtErlWSVOWLTiZv472fLOYsE7XlNGVHDS46p58q1i3IPJ61+pHJWX9Ym1
 e2g+uhjAM4g+xNlhWOh4yVLCQ7sxE7FsSnjk18ch/o2rvFs4e4W8j9qdfPB6j+EKMXg8
 clGyUpKd6KcvP/2Fz2qqBwYpMKbD562aPO95HPmNeZAXOJbx+Dt3AQ+kjxsngIYnrc8B
 FngnReTpNdPgcmgoZ3hlZX6eaKQSouN6RKEs/PT08TRGQGfP3uE3VEs3PYeXhAIeyCbn Lw== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
 by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3kxua6a7v2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Nov 2022 00:01:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ea7afQeYKIImyxIM2HPp/035azrhrdv5xt9JNNgXaOn1QKTn7khN4CBtOJUbuiKfOXAx7YjAQfHEBvbN4Slzk2HkNxMRd0ACpD5hoZ/mtPZ5FBaKGH1GdHXj//hMCyghKVUiMpXEovKdVZIpaBY4r5gMsvPpWgGoeDWy2N0KUUc+4RMvvvTIQqBhUe/W+Ape649oTfvs0uTaMsW+VrFUzWdmUa6RoAomv8hymFbAgA3RW8wwoJFAriNOP3og/vA00fBG6ykVikhLRKA+rccPlbciETQeTa348QoOEKPuoOlI2PydcUwquwW6FLIGBHkTliyoNglNFUkuDSJ9bf3qFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z4BKuG7zzXD5DB2LNa1ylfJiPsiOfUvx5EUQF9sfOhc=;
 b=JDsll4mMt0upgZ7e8DSRIFgBOW/GRk+ywy+M+tMhXKs1FMKVftuzvu0FQS+MN2x9WKk2POjp9PPzlEDg7pLyO95TnmoCsTvHS3eBS/bfqMFTOufCnH36/254iGsAHVsuJWbglgvdPBCWiSDLzT8d9rJsQhZu5jVylAcyMDw0PIlUUFnlrNHNyt6ofdAHTtTb2WHMfS3xSfkgdrhDiPabYfXHB1xmoHx4+wKmh4Cv1piZqLm9hAGUR7btjfSKkdR3FvySCbeDcecoodbuSNVvTc86rBfJrB46sUlcT9ZrTm5tOu7PgWt+hOq4/IaQDCgFPXwvcXIRmvJyVxJF2Ti5qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MWHPR11MB1358.namprd11.prod.outlook.com (2603:10b6:300:23::8)
 by SA2PR11MB5196.namprd11.prod.outlook.com (2603:10b6:806:119::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Tue, 22 Nov
 2022 08:01:39 +0000
Received: from MWHPR11MB1358.namprd11.prod.outlook.com
 ([fe80::fca6:eedf:ad46:d1df]) by MWHPR11MB1358.namprd11.prod.outlook.com
 ([fe80::fca6:eedf:ad46:d1df%3]) with mapi id 15.20.5834.015; Tue, 22 Nov 2022
 08:01:38 +0000
From: He Zhe <zhe.he@windriver.com>
To: ltp@lists.linux.it
Date: Tue, 22 Nov 2022 16:01:19 +0800
Message-Id: <20221122080119.2396826-1-zhe.he@windriver.com>
X-Mailer: git-send-email 2.25.1
X-ClientProxiedBy: SL2P216CA0095.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:3::10) To MWHPR11MB1358.namprd11.prod.outlook.com
 (2603:10b6:300:23::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR11MB1358:EE_|SA2PR11MB5196:EE_
X-MS-Office365-Filtering-Correlation-Id: 76b680f6-2a9c-4cf8-8241-08dacc5fc7e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QmxX2Teqhd3FY9GtblbolqTN34n/lQStxoHhRiJ38hilrNPRsUFlweDXyWRPgS+fIp1TF7a+RdJsh/TFKTzewCS2BN1xvY3tE/v7ohyF8pFHMkwFZeAN73sO0aHWsgV19wCjA01Bck1AuFR4Q/bE63IH9l8wbOTLCD2f3PtaUFN7KXZVDC45RYddD2M4RQeduUhC5RMEX+7eJayzT07r4wPM7WNZ2oipCrYa9DXecoeRvBLPxd9S3/PZtby1yrADOuRSgGhQjBucBHIJUNgmQ/PjTZvdwfwu/GmXI+VyByHJ1icfM2tO34pEl9cCOF8V1hXzwlmWFyym1ncwrrLA/m8836gfQoVrFdvA8+PQSi55x4r60+/rl0j/hfqyUE/PFTaqupVzNA7toWpEG4zYKJioxUTvKfDELZKMpbIurVH3d2hLZbgpkF0ezPp1GeJhVtTeqYcb5lQ1rd+e95OEpKfreh5izIi+BX712HpuLlwi9Rg6qzoWeG7M4fD3reP3AUNMv7qF3Fdsxnaf8YG7dJJPSAcS9doPqzbw9FW8aO4/0JkCjdwNmT1gIby3xr46y8iEe8zFnq9BLyLBmVSWfjP5BlXzN+mDLMqV984FVH/qwLVJlGLe9Nn9JiKPq3cDdC9UZhKxHoHA/rRKkJ3A48WjfPk9U3g9szqaruR3GaAg4+OmO7HfIsmyfmUrpIR/+77h0wiuDjpszENamiretQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR11MB1358.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39850400004)(376002)(136003)(396003)(366004)(346002)(451199015)(6506007)(6486002)(52116002)(6916009)(6666004)(478600001)(5660300002)(66556008)(6512007)(26005)(66476007)(1076003)(8676002)(66946007)(2616005)(8936002)(186003)(41300700001)(36756003)(2906002)(316002)(83380400001)(86362001)(4326008)(38350700002)(38100700002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2gbbatYdw0eHfALSyLKgTHnsiWhMjvZ8Bv8xjTGpr64Hd1c3X0YASz3U9ojI?=
 =?us-ascii?Q?RES1z5xKdoX4vyzG1JeWDYwo4RTRBwNh8AHHOkFU4fxjjNfn4XKqgYgblX2F?=
 =?us-ascii?Q?CNuYeTWS821t5amd2ICZ5OYtlvkBRmegjNvp0EPBuzpJuEQLA06xri9qEg3+?=
 =?us-ascii?Q?F5BCmuKBKvFB/DQnJV0vVz7LCCVdiIl77pwi4fztRgegIr8uC8yWyGw3eTVX?=
 =?us-ascii?Q?EM/FhN/jUq5sJ9N4Ac0SZvLY46eLySo4L6mE227zeHL2bzhFo4E/bHLui97U?=
 =?us-ascii?Q?/OOJs8Fr0PmbvLVl0RkhvVeo5lxQu/rjaYDnfdvZqk2xJrHqGBe51E5SxXmM?=
 =?us-ascii?Q?lf3pZB7f1tQJCiwD4rzxEEJF+cY8a/gmjujNa0JPbKqR5cnPmjkawMRjLauv?=
 =?us-ascii?Q?LZj+fymJa0lDj4GpgPiPDUXifDQ7WXYiN2Ab9GD+K56FsTeYbknAmkIp0kVd?=
 =?us-ascii?Q?tx+/JCdrvSm94R4mmlWfDaK+pGXBZ5JVnFRQOgy6OtbGoKVcYoiicXYjX+Uu?=
 =?us-ascii?Q?9ptGYP6zYkPuJquErSEJtiXdMVAc2ZCwN7n/pf3oFEw0WhKDIk7Jum+QeffN?=
 =?us-ascii?Q?hRrDjua+yKx7GYTF/0U18jJB20choEOWg9LebKWdk2TOT8y6KfMTEbAuO0Cy?=
 =?us-ascii?Q?f4NurmjQ/EWlx+idepS5pFp/vnW2Y8galbj5Fs216C9mja/e3A4SCm6W3nkK?=
 =?us-ascii?Q?TvyP87846KEhTEoz7p72kjxoodIDkjSI+ltlJ0rVs8FpU+nwhtYUcOzg9oFO?=
 =?us-ascii?Q?OnjwuY26MLwwALxHxHuCy8z3NOFTNafAQOgmF6pjjjdLgDK7Qi0w84YQpP57?=
 =?us-ascii?Q?k/pyyWnbJ6iScT1ouDOisY4PmvHvTXKAPbICjc65HPrjaSX30IDmRhlIT/xo?=
 =?us-ascii?Q?XoFsyqJAG8A+ZMn1maOS3OoQWFnqkyI7EMj45od/it/SkPTnC8P86Nla68A2?=
 =?us-ascii?Q?1Gaz5fQ5hjCz31BUnoNtqHuXsfL6m3MYHsaxyD2lghRUW4BgzIcC+a+fjS/e?=
 =?us-ascii?Q?L0UGc8JwBYzAyjb+vqkRLUJVOBqpvmcyfDhqqRZX5sTJv6+rwyHcl7JFZVkd?=
 =?us-ascii?Q?UONgEfjCucOMRvjkHLs3fMVE2S6jZmrKhUJpzMinxGJuflC7ejMWS5W19tJJ?=
 =?us-ascii?Q?kJkrY+7RZ8bi+fN+GJwPGZhND+VobZ+XtG1XO6zq+TSwxPZeFPVL34AtAyjq?=
 =?us-ascii?Q?AVhHCp5Q1sroCRoFeTGw5QSsj9J1cbUPhSQeb9qij7CvXEE/OuVI5rrqSgPU?=
 =?us-ascii?Q?UaHNvDiDTcJiKHiJk9DvmILI/m4yTupPMMpjg6EwkroIUDDqcQf50030TXjq?=
 =?us-ascii?Q?ppAztwi6WpdmnV9+dwZQ+dCCQrB+xCNCT3v9i8Mc4sZbmMm4h0ljl+Pw6CM3?=
 =?us-ascii?Q?Dvl6j0jY0ERM/S7YH/DB9JUEVgAiyFuLJURLhpon0jMg6r/JG+bSGJNZ/TtT?=
 =?us-ascii?Q?JvtnDMyXR8BCiZadgEkZMHHMntI+pXAfqNQpXZH6L7zKFi43CMuF98UC6lpS?=
 =?us-ascii?Q?v2ZwbhZOlxT/QOhPo+hb9QXWV704viHhNCZEECgE45HLfP50/V3lr3cj+Nl+?=
 =?us-ascii?Q?J2vB36px3u6oMHWULK/h2X6bzTw/9w10g0Szprun?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76b680f6-2a9c-4cf8-8241-08dacc5fc7e6
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1358.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2022 08:01:38.7827 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xG1grxNCZhOlzLDrzLvao/JNjr1nBYMlkkO6sGfvwuoA6jYi8BRxYeEBNSEJoezBLJ+5l2QN2DEm2wzN4CuVCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5196
X-Proofpoint-ORIG-GUID: yOqMflXgEYOc3vVZfsycTGseiOteizZ4
X-Proofpoint-GUID: yOqMflXgEYOc3vVZfsycTGseiOteizZ4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-22_04,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0
 spamscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 clxscore=1011 impostorscore=0 priorityscore=1501 mlxlogscore=704
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211220059
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Tue, 22 Nov 2022 16:59:59 +0100
Subject: [LTP] [PATCH v3] syscalls/prctl04: Fix false positive report when
 SECCOMP_MODE_FILTER is not supported
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

The child process really should not receive the expected siganl, SIGSYS, when
kernel doesn't support SECCOMP_MODE_FILTER.

This patch tests if SECCOMP_MODE_FILTER is supported in setup and adds a
variable to record it.

Before this patch:
root@xilinx-zynq:~# /opt/ltp/testcases/bin/prctl04
tst_test.c:1431: TINFO: Timeout per run is 0h 05m 00s
---- snip ----
prctl04.c:154: TCONF: kernel doesn't support SECCOMP_MODE_FILTER
prctl04.c:154: TCONF: kernel doesn't support SECCOMP_MODE_FILTER
prctl04.c:154: TCONF: kernel doesn't support SECCOMP_MODE_FILTER
prctl04.c:204: TFAIL: SECCOMP_MODE_FILTER permits exit() unexpectedly
prctl04.c:154: TCONF: kernel doesn't support SECCOMP_MODE_FILTER

After this patch:
root@xilinx-zynq:~# /opt/ltp/testcases/bin/prctl04
tst_test.c:1431: TINFO: Timeout per run is 0h 05m 00s
---- snip ----
prctl04.c:154: TCONF: kernel doesn't support SECCOMP_MODE_FILTER
prctl04.c:154: TCONF: kernel doesn't support SECCOMP_MODE_FILTER
prctl04.c:154: TCONF: kernel doesn't support SECCOMP_MODE_FILTER
prctl04.c:154: TCONF: kernel doesn't support SECCOMP_MODE_FILTER

Signed-off-by: He Zhe <zhe.he@windriver.com>
---
v2: Add a variable to record the support status instead of exit(1)
v3: Move mode_filter_not_supported check a bit upper to save a prctl call

 testcases/kernel/syscalls/prctl/prctl04.c | 30 +++++++++++++++++------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/testcases/kernel/syscalls/prctl/prctl04.c b/testcases/kernel/syscalls/prctl/prctl04.c
index b9f4c2a10..d3de4b0d6 100644
--- a/testcases/kernel/syscalls/prctl/prctl04.c
+++ b/testcases/kernel/syscalls/prctl/prctl04.c
@@ -93,6 +93,9 @@ static struct tcase {
 	"SECCOMP_MODE_FILTER doesn't permit exit()"}
 };
 
+
+static int mode_filter_not_supported;
+
 static void check_filter_mode_inherit(void)
 {
 	int childpid;
@@ -154,16 +157,17 @@ static void check_filter_mode(int val)
 {
 	int fd;
 
+	if (mode_filter_not_supported == 1) {
+		tst_res(TCONF, "kernel doesn't support SECCOMP_MODE_FILTER");
+		return;
+	}
+
 	fd = SAFE_OPEN(FNAME, O_RDWR | O_CREAT, 0666);
 
 	TEST(prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER, &strict));
 	if (TST_RET == -1) {
-		if (TST_ERR == EINVAL)
-			tst_res(TCONF,
-				"kernel doesn't support SECCOMP_MODE_FILTER");
-		else
-			tst_res(TFAIL | TERRNO,
-				"prctl(PR_SET_SECCOMP) sets SECCOMP_MODE_FILTER failed");
+		tst_res(TFAIL | TERRNO,
+			"prctl(PR_SET_SECCOMP) sets SECCOMP_MODE_FILTER failed");
 		return;
 	}
 
@@ -208,7 +212,7 @@ static void verify_prctl(unsigned int n)
 			return;
 		}
 
-		if (tc->pass_flag == 2)
+		if (mode_filter_not_supported == 0 && tc->pass_flag == 2)
 			tst_res(TFAIL,
 				"SECCOMP_MODE_FILTER permits exit() unexpectedly");
 	}
@@ -218,7 +222,17 @@ static void setup(void)
 {
 	TEST(prctl(PR_GET_SECCOMP));
 	if (TST_RET == 0) {
-		tst_res(TINFO, "kernel support PR_GET/SET_SECCOMP");
+		tst_res(TINFO, "kernel supports PR_GET/SET_SECCOMP");
+
+		TEST(prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER, NULL));
+		if (TST_RET == -1)
+			if (TST_ERR == EINVAL) {
+				mode_filter_not_supported = 1;
+				return;
+			}
+
+		tst_res(TINFO, "kernel supports SECCOMP_MODE_FILTER");
+
 		return;
 	}
 
-- 
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
