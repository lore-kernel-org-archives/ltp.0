Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 509C0C433FE
	for <ltp@archiver.kernel.org>; Sat, 19 Nov 2022 13:06:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 510763CCD71
	for <ltp@archiver.kernel.org>; Sat, 19 Nov 2022 14:06:51 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8178A3C2B4D
 for <ltp@lists.linux.it>; Sat, 19 Nov 2022 14:06:42 +0100 (CET)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com
 [205.220.178.238])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8017D1408DE8
 for <ltp@lists.linux.it>; Sat, 19 Nov 2022 14:06:40 +0100 (CET)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
 by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 2AJCw10Y011653; Sat, 19 Nov 2022 13:06:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
 h=from : to : cc :
 subject : date : message-id : content-type : mime-version; s=PPS06212021;
 bh=vPKRGExUjaSoyt//zj7p7bmc3OgvI3XAxLVsYBwObpI=;
 b=MFZuMFwDWUw8HQt20P6JTxo0S6iFKJH7z03qT+IJTL+lKEgOAvJM185+XvlYGXfpM+gp
 lWFmUHs0/1Yis69gaLpIdOGMuAxI9EF7zAHePyVK7cMguWXkJZ4B3NCGXAk3vwDUd0tT
 JMnQHBxFQq5k+4btZHlCROFogaiUHqPEtwS8ywJ86s6Sc6IWXMyTmKB7MeN0rIhdVzQA
 8KZyhjisop2qUtGb2Vqic9VT0J2o5i6A6k4UBGuGIvQXcBn78sXA/m0sCNkPngqcjMnF
 SuBEcY+dh/icFUCI0PNvIUnJtTHCI62SjTk8p7OShl2cZ0klqIVODBZOZP7TDtuILpJk mw== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
 by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3kxnxj09kn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 19 Nov 2022 13:06:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kGaWFH2jkb1H6kVFZ5FJaScJW9xpu0dcfuJ2pW8g6bCOtt401uwwkt9mc66tiv/AIhE+UQ9t46kCGk8qZfNndx9yzDENQYFpsd7I+1jIrj79qWHiDfQp5wweSTgFv37oWyHVRPLNEvE3JcjHkqQHjjViYJ6RJ2YhVuNLceVsa0gYTyzc78lQ3OHWTREiQPzw79bc0aV50lXWJMwYbE8oZANb2CSuIjMBwLRT9NdEdjBr/eqS73VgORa3VnztLfH6sCY/LPXkrhP3F8/QlhG7DKhZm1TbPnXymbVVCOB2ZzqJ5oxAZd53qBkN4Jx+jY7XMnDkE1PGMysKQA61ZtKJhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vPKRGExUjaSoyt//zj7p7bmc3OgvI3XAxLVsYBwObpI=;
 b=PLeX8V4v+NmgDpar8AqfRiEd/+ha4wXuBj292BR+wvmUvyNeJhwIdysjW4sCYZcLgZUh2KHOsA/ghVzwSH/1f3YR4IQJgeIIAdf0OJYar5kjMH9GzbISZLWKPHKeni6e9kIoSwoH1zl8ra0ngbEzfcb2V7voS/WrCTStEIZrmpaIldHcSJ8X2eoGh9sng448wAw/3Et++egybbeGcz97O4YEkYCMXesPtAe/ngumkRstKQaF/PNnglga2Com0uO2fDu1HZm1+PHEV7h3ym9OfNytaGO/gE/ijSJTgNwajxYv3SgcipPXK1FrL3sRC4TD9x4t1J4NV7gmoVUATjWY1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MWHPR11MB1358.namprd11.prod.outlook.com (2603:10b6:300:23::8)
 by PH0PR11MB5808.namprd11.prod.outlook.com (2603:10b6:510:129::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9; Sat, 19 Nov
 2022 13:06:37 +0000
Received: from MWHPR11MB1358.namprd11.prod.outlook.com
 ([fe80::fca6:eedf:ad46:d1df]) by MWHPR11MB1358.namprd11.prod.outlook.com
 ([fe80::fca6:eedf:ad46:d1df%3]) with mapi id 15.20.5834.009; Sat, 19 Nov 2022
 13:06:37 +0000
From: He Zhe <zhe.he@windriver.com>
To: ltp@lists.linux.it
Date: Sat, 19 Nov 2022 21:06:19 +0800
Message-Id: <20221119130619.10107-1-zhe.he@windriver.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: SL2P216CA0195.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:1a::11) To MWHPR11MB1358.namprd11.prod.outlook.com
 (2603:10b6:300:23::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR11MB1358:EE_|PH0PR11MB5808:EE_
X-MS-Office365-Filtering-Correlation-Id: ade0f801-ebd3-4e04-9167-08daca2ee421
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kd06E5bZApMpwPT1+xGwk0UQMqHf2zjbcIL0L94zazoXfySLJyJYRjjwFJiABUHpdW51Op7MiE3DKdAO8W96c5IuU/D9aihd3DVT/Ya2rsvDR+65FY1p6NHDmmKhP9wKj1hVYL2fF6LNSAqYI18V0/8wOcYPhjZLK40UHxziEVtngOhEp9157nfDW+5TFxnwy0EPcD5p6iFuOBib/8fRB7gi2XZpAzBEeKVVAZTm/ZJXVuKE+PGzUDtiMX8KPiafJbZK4Kw6eTffzR7XYA4ENXDR0LxJYc6pRkOlnoiBmgu78/iWm3+R+itQ94H65qRjLx0RVevz7/hRMtXU1z4x2JhQTPDpxCZU8cwYXG3uHdqSC/31uLgB/UXtKKU1K0mdbkyKQtHlLjj5/aoMAw7f5U+j9KcuG/mE4NOmYWXQSSshtUmY9lwMO4AbY1BWjFn+m8myVF4VxW/HZYonYoSiq+NTMT2Q0wnaUtAEQDJgm59Q4s8IBAVT9DQEnfpKvhYR8Y3Ryxf2kZD/2v+oslsMnkZz2PyOrGFGEpo4rjHzoVo626sLoeUp5t4S/s/CpfoHLYwPdKYdB3ouw7aJgw1XNw3IGTXJeZtPqY5J/J4uq7nrUyMZ3hu4WYUpGaLQSEvSaUz7dZ4WTQjZtj15FvJpr7OfVl5Y+WRtKTVw0AfEjoB08In2pgvIKmMcr6lt4/aEKJHD/yCrbsoBBvw5nlIJNg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR11MB1358.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(396003)(39840400004)(346002)(366004)(136003)(451199015)(2906002)(83380400001)(6666004)(41300700001)(66946007)(66476007)(66556008)(4326008)(8676002)(26005)(6506007)(6512007)(5660300002)(52116002)(186003)(316002)(36756003)(1076003)(8936002)(86362001)(6916009)(2616005)(6486002)(478600001)(38350700002)(38100700002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gfqh15wwT+xulbxt6RwbDCv6AVTlwdB4Vgb4mmXIn1vlru9uQIbeS/mvknMY?=
 =?us-ascii?Q?ZPfIgswINl2V5+y4xK5g4DdJ9fRcY3hGGzh/C51ysz70LPR4zTgdyZO9654B?=
 =?us-ascii?Q?TKzkEXHP2tLqjh0x0y+4UlwKVn/y/MX/jD+KxwciGh4tkZoljqsMyGCe0OQp?=
 =?us-ascii?Q?hSrfLF/Tzdnet3JS7HdGisbqsDIuazUYiKBWlQoheI0dgUNg6r0CDrmmXaeO?=
 =?us-ascii?Q?RpLuwYup+sP7hiwcFMPfTXHXIezrhtuViNek3fN5Xn7gi1m6jclJzrZgGFWf?=
 =?us-ascii?Q?q1lBu9QxO0H4Nm1ktuSGUqe+Zoqoq7PorHBrpE9iakXFnfguk3ImVlE8weZY?=
 =?us-ascii?Q?O2mqjSeKuiWytO1x52FTivAWCsVWX8P863/F8GViiATlvbf4CrKhnPAHu++T?=
 =?us-ascii?Q?5yWYgG3DKjhy6a8YfOMjEmGb//ZY7yGUff8jn/dMz2WCxZ598hafYcIoONVW?=
 =?us-ascii?Q?v41a4tPNFMRY6p18xSj3BPw2mmDiSEWNkrTm7cItZsuBYbnOHG1q9dw/fNe5?=
 =?us-ascii?Q?X9Akai4erfF2NGo0oT7f5H27b4UWOguD/CmXKK5Sbp3JVX2wZLy5X4qmP+PT?=
 =?us-ascii?Q?vUDFP33he4bN22EBx2bFIl4pRkkNoaY4r8qZLqKEsFlHEX6q2IXcqo5XqPtc?=
 =?us-ascii?Q?gidUNgwQsDVcwcURNPhJ7TbJQfyOljeJa5LysQoJwzZMqRwDVURfZ24vG2Nv?=
 =?us-ascii?Q?QADzl32Qp3w4YuwLRDiqlK5pRhJl7uhOoUIE8hAkTTXit9CsG7A1vBdhr1TC?=
 =?us-ascii?Q?0cmpdhbAB16L7lY2ocgZ1sEo2h1oktd5H3qbv9V0lxRE7dNLTx2HRvp+yDX7?=
 =?us-ascii?Q?VYFnf5HVHC8O3l+V2YwTmgsgxKIRBmumm6xRsxuUKXltQYqXA/0llvlLYcXc?=
 =?us-ascii?Q?spWHezxFAesY36wH2o4OePn5uSi2MCUrwFfuXf5wLLN54aHahdWpzrkG9Rwl?=
 =?us-ascii?Q?wfgGCz8Gr1F97iVJ9bdMgF9loIp12sLXBxaByiycMZsQNl3VRcV/XvKpRzW4?=
 =?us-ascii?Q?6MouAk9heGSDsvLdXJLSKaaR3qKguP/PvMVoZn+TmoYOS1G7EGJ2TKquDEAO?=
 =?us-ascii?Q?fgXsTDYr/0IczKRnAYh0I73BTyIRfGoh0Mw1a2x1dsyKW76ou65ZYdiNXMjm?=
 =?us-ascii?Q?NEhWlK1SxjJ8WeROmBFMoMTJEMDLaqUO6uQj4lYLsVgiqC32oqzBQgSe5YFj?=
 =?us-ascii?Q?RQPHZ7Gz6ikjGPzlzhpdu5j/mFQe34ZiLVnMBgtnBh07KWGj5TeShbpYqxlS?=
 =?us-ascii?Q?lE9R3jYDywdX8+o0JAwCgvtHco1hjr1z0d1+RIfymokhLhU/f2ASlGRC9mTc?=
 =?us-ascii?Q?rgsLgT/pghJIcxHWendij3Nvy0YBbqL3yEt0b/F6B8/JhtAoNULHIuubZmKh?=
 =?us-ascii?Q?jYclXREbc0ONn8lcdvuWl+VRrJnwfZKOpQc8mAJTTRo81R8ZUEn4ONsEbmHJ?=
 =?us-ascii?Q?mrXCkMRWFPYbEGw3/fyfrX3Xgxn1lzQNCXWUd5AVdf89g1JwdIBvRpIqPEPw?=
 =?us-ascii?Q?m7iqoXpLcjeLJnr76B/bYkUsw3eSMa1Nh1F68ByeE1Ou4wtPngFNxP8XN+wN?=
 =?us-ascii?Q?72l66k+y+hA64LCAHPg0mRiALlsY+nL9789/m/2J?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ade0f801-ebd3-4e04-9167-08daca2ee421
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1358.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2022 13:06:37.2776 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jx6QY42FBy+G+vOvjO2yzx8pOMrhlb5/5BrVWR0yvnLAgJtz4k7w2W/E9ZqLNQlytwUJbn3lcZRIVdh8DVa8sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5808
X-Proofpoint-GUID: CyXlqGjhcRox74jiHyqrOby6rQB00Vu3
X-Proofpoint-ORIG-GUID: CyXlqGjhcRox74jiHyqrOby6rQB00Vu3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-18_08,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxscore=0
 spamscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=707
 priorityscore=1501 clxscore=1015 malwarescore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211190098
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] syscalls/prctl04: Fix false positive report when
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

 testcases/kernel/syscalls/prctl/prctl04.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/syscalls/prctl/prctl04.c b/testcases/kernel/syscalls/prctl/prctl04.c
index b9f4c2a10..94e8db273 100644
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
@@ -158,9 +161,8 @@ static void check_filter_mode(int val)
 
 	TEST(prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER, &strict));
 	if (TST_RET == -1) {
-		if (TST_ERR == EINVAL)
-			tst_res(TCONF,
-				"kernel doesn't support SECCOMP_MODE_FILTER");
+		if (mode_filter_not_supported == 1 && TST_ERR == EINVAL)
+			tst_res(TCONF, "kernel doesn't support SECCOMP_MODE_FILTER");
 		else
 			tst_res(TFAIL | TERRNO,
 				"prctl(PR_SET_SECCOMP) sets SECCOMP_MODE_FILTER failed");
@@ -208,7 +210,7 @@ static void verify_prctl(unsigned int n)
 			return;
 		}
 
-		if (tc->pass_flag == 2)
+		if (mode_filter_not_supported == 0 && tc->pass_flag == 2)
 			tst_res(TFAIL,
 				"SECCOMP_MODE_FILTER permits exit() unexpectedly");
 	}
@@ -218,7 +220,17 @@ static void setup(void)
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
2.17.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
