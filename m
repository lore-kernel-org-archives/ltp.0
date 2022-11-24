Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A664C4332F
	for <ltp@archiver.kernel.org>; Thu, 24 Nov 2022 06:18:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 56AF23CC923
	for <ltp@archiver.kernel.org>; Thu, 24 Nov 2022 07:18:00 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E0AA43C03AE
 for <ltp@lists.linux.it>; Thu, 24 Nov 2022 07:17:46 +0100 (CET)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com
 [205.220.178.238])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id CBCE9600705
 for <ltp@lists.linux.it>; Thu, 24 Nov 2022 07:17:41 +0100 (CET)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
 by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 2AO6HcB1015433; Thu, 24 Nov 2022 06:17:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
 h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=PPS06212021;
 bh=wgOe5Qvl5YZq8qBX8uWhQDqhn9CZiXiICAqnpCcWo2A=;
 b=AILTT0eSR1etSGD63HDMuFZQ9eWoOtJ+WEU+/jNfLDtSsN3y1uF3DWQBcH67DT6LkKLE
 +mXBcWthGEu8sFE/jCAqoTt257Fxt2xYV7/0dPgTXezS46EE/9eUJv+L3S8YA3BcJpaY
 4OEkj7erCPK4EqzvMMckhp82vO67mlfChM4/IsmqhjPvoqu+0zRBWY5TQt63GIRS3XXR
 ilAVPqZxki0wC5Spcvz+MVm935lsLEhRLdzvOe1551gmozfUdir6BspVZ3tdw5gnS3JR
 87DiwgcuZvrkKY/Ra8GDLitb+/nS3hq42mZs8TMKrtiEKkSu0c5hYCs3htK7IBZiUaeM Sg== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
 by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3kxnxj411r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Nov 2022 06:17:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R0mCixCmdDn3CnGqizVYNX5jINgzuKOjWK+3/bBLKHB4msMXV6qBq836ID1q+twsjJ5OKqvht/6zdoAuUHfhg489rga/AFKwhavz5h46C+fLfPCGJtmOG/zyf8nO/i6nOHQu6xFHouJdtlIWaw7aZ8RSGp4UdcQC5a//ZaQZpocFjjQoWQl5SGvc5fytPbNwCaLp54ZZolF1PrFsz+izkg1xilnTwXJgN4N4OTUHJTU7LUVSJk2BcswOT4am1f6cQi+IYS0TD3UxmjetsQV82NjX/7V2bvk5Ngw5o6kkNEKMd/TiLnGajrIdsc+EFVT6pqR1B8Pt0x8jXAmuCtA2GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wgOe5Qvl5YZq8qBX8uWhQDqhn9CZiXiICAqnpCcWo2A=;
 b=PLb3sH3f0TF8l6C6cG7p50P7pSJ8LFz0WBilg1Mu7uS8BuzKafseb9/ybEWaF09260aD4yeS9PVm9Tql3BkUknJ5BTErZvWe9XOdCYWO5WQWguvCMZiSw0S64ZpvTI74Cq3YCVY0QA6/1zxFEg+2k3qFSOjjqcoxdUC3SsXkAQglulJIKiUwFUjRYwFO6gwE2OFn2EPxl9uzqViE18qC1TjoFFDgeRR2leAJ6w1UQ9rO9+XzLdf8vS8vxV/EBluFHvT78Lg/E4gE2NM4kEnzZZI9tgVn5OiwBuXM7ed9KSkxYOTtqRisbrcuJhp3z8mHV+eLzstCa18uznEyKlSNZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MWHPR11MB1358.namprd11.prod.outlook.com (2603:10b6:300:23::8)
 by DM4PR11MB6018.namprd11.prod.outlook.com (2603:10b6:8:5e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Thu, 24 Nov
 2022 06:17:36 +0000
Received: from MWHPR11MB1358.namprd11.prod.outlook.com
 ([fe80::dfdc:1e8b:daa4:455c]) by MWHPR11MB1358.namprd11.prod.outlook.com
 ([fe80::dfdc:1e8b:daa4:455c%3]) with mapi id 15.20.5857.019; Thu, 24 Nov 2022
 06:17:36 +0000
From: He Zhe <zhe.he@windriver.com>
To: ltp@lists.linux.it
Date: Thu, 24 Nov 2022 14:17:15 +0800
Message-Id: <20221124061715.1211833-1-zhe.he@windriver.com>
X-Mailer: git-send-email 2.25.1
X-ClientProxiedBy: SG3P274CA0004.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::16)
 To MWHPR11MB1358.namprd11.prod.outlook.com
 (2603:10b6:300:23::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR11MB1358:EE_|DM4PR11MB6018:EE_
X-MS-Office365-Filtering-Correlation-Id: b205b6aa-07d8-4eec-3c94-08dacde39329
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X9a6GLqR2NcdNFAGZLBMhOE4Hocrji+hsA6SXLEliFAldBH6eSVcaLFdbIH4uZJU/VgleLoF7dIRDVyUSTNwMz42See2znyEDjBGKo3d6RCLl+tG06UFPGcye0el2mI0Wg9aAyepEWHAxT3+0F4tZy5U+DQGyD3q6JjsTqZ8fVgASuH1B9D0slz68kMO+tudf/ofpgGgbOI2kbdNwguI6zs09kHdH2LyufrtMnp4ODKjcTiI4QkgMPZTA1V3iuD4oAlc8VFPHrbFXEi4c3nR1ktpXDiaGsYgnwNC7rmresHQXjohFNf42L0eK3ay0Zjz+S91VyrKrtBYdtBmpTgUZZhkD2D5gWeI5oSfLVcxeKTlms2pNe3nHo9uCm7PmfyUO0+eEAYsKXlJUfTzXN/uCsdz8HjgM7T9dz8NE5RQ5O1vldAGztnlbiaoYEO0PByCt9/ZGQUbYVvQuxza2fxK6PKXsrDrGtxu+MP4t12djICZSKnOcZWAosKgNemks3GbAdUDLH7xd4l7YWQYw5PxOXfshru+ooNrYqtJIfQAI9EpILP3faGRsSpOQf3zG617JA2pkiRoTe2DhLt4DpbRzXldaV8i/1OTF0UWqvK22eqfstW/Td13iyP/RpFvCD5WG1voePoC/cWtcADI9gvTf1jWKSr3F/7W2tht9gbr/o1iRVZAKRRXR6AOZ5Ej8eDC
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR11MB1358.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(396003)(346002)(39850400004)(366004)(136003)(451199015)(6666004)(26005)(6512007)(6506007)(186003)(1076003)(2616005)(66476007)(66556008)(66946007)(86362001)(4326008)(8676002)(52116002)(5660300002)(8936002)(36756003)(41300700001)(6486002)(478600001)(38350700002)(38100700002)(83380400001)(316002)(6916009)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4TD83I+crqG+rIuJ6hqLPX17D7y0DiKPypeqL5CwUSYH2xLOyxdSqdX1B+wO?=
 =?us-ascii?Q?5l36MkKkqoHXevDMtaN5yRiGTKTMIS+p5WklV0vk3SW317lWRlwSiHoKdtPP?=
 =?us-ascii?Q?5tGhCnoeeDpZFlCORmECcPfWn70xzjwggOgJ7vvqfAkDJRslH+O5EuVx5aCF?=
 =?us-ascii?Q?w6r/FLNXcWAmXnp5s0AcbtPfjl1ZXzn2d0wDYnNqE+/EWhSJjB1wYFAsT2cw?=
 =?us-ascii?Q?2FkR5UlQXWsbvo7Aww5wQk9xY8pnyy1TKYQmY+O3Uunj/dz1ZL1A7XXQV76i?=
 =?us-ascii?Q?eJYjarzHbip3BtwDdo+zD4UllVI8wO4SIQF6zDKFeTGNAb14+C9izVVCNET/?=
 =?us-ascii?Q?8C22rntH4asKSxEbF7YGP7cLxpsReCROLFZKYatXKO/3LB+2U221G/0WPNcL?=
 =?us-ascii?Q?aLWAUWSqFaJZR4xd+cnCD5avlQGsJecRmMx+toFt3f9UUJMTHACg0JRo8nNz?=
 =?us-ascii?Q?m3Aj4yaHtnbtvOfGAmUtLYvKh9GEWxYbgOGh0zYJItBmIaIwd7ljn5EXDtYq?=
 =?us-ascii?Q?KXrx0PQPh1axOAQ5OWZyN/PZdYNp319GqXj/oRN5e1hE6K/UXOPd0UIZZcWi?=
 =?us-ascii?Q?Onp9INEKyuvYx9Mw3arA9pcV2Jq5nTTIAdtqgV247sEQA1iB2as2bqAmUvAS?=
 =?us-ascii?Q?4LtHJHItWhZuqgVeYCsP+0te6T310/RsZEKK9XAdD9P2uQbaVgsj3TaoZRc7?=
 =?us-ascii?Q?Lk0Mcb7og2v/ibepgjanG15pKFZkYg4csUwQgYip9E6sev1jeldcEd11NU0V?=
 =?us-ascii?Q?CkTC2mRU/i+BT6ZPYStj+fvfVvYrRsk/uu5YqPaZXiJVPzkVeheOW2PRsAEz?=
 =?us-ascii?Q?Pg0K3rfdioVhcO/R+B1wp/eHPqFzJMdt1iBMWm7qffdsTy/3RiRabdQ+bsiO?=
 =?us-ascii?Q?cYLw0xLGpgHwfER0dDBN81trEB6WE6e2T5YKG7X+cWzw37IyriThhaHZHIRU?=
 =?us-ascii?Q?gLolmysKp2Im/dugmnwmUzxajBiq3ylVhy9EkXM3XgU8hDw2EvXZXPog2NfL?=
 =?us-ascii?Q?AOT1jSvjhZXmy9SY9Macq8to9EJ50ye5fvGnFlg7T5HoBl+giEEFjK8AM67G?=
 =?us-ascii?Q?18kIPVzqUz+ZknSMopZS030DUOxLYVIsj5RKGUDTjaM4h/UsB1B1kaxNuxVW?=
 =?us-ascii?Q?cxJlQbn5ugXND74SbXF47cxJsELTvUUwhv9RQXg0K89V93jUSZvRRGsEpu79?=
 =?us-ascii?Q?psCdFHR+VlbJNLpWVuOFZ5HYEyp6wkTWMg8lWO28hjVqbB3UWj15ZnFERyp9?=
 =?us-ascii?Q?1FqcVAwdJwCcWIZrfMxanJ62HvfqHnA7sLXzgy2WWh2ki6WL9MnVEZhSxFpG?=
 =?us-ascii?Q?m3fwzNS06e5sx+JAA+zGnaF4KmeosdMBzzHXKAS6o/tV5sQBm7PtjnaNpx/C?=
 =?us-ascii?Q?Q6gehS9OxC8xJdu/fHlp/l45Oj916wSnhsHDUnZu68tsS24uuWThgAUnrVxt?=
 =?us-ascii?Q?vsGfBSe10YboJLWsTOYhigWdiSFTNRrzrOnp5aNmHUvFO9VZRFjStDI3feYy?=
 =?us-ascii?Q?hDi+k7Io4dV96mGMddtYg3GVAe64xMPyX9yTK7Tb7q7akqxPmSDHzsM7XXy3?=
 =?us-ascii?Q?3hJ4RJ1E+V663Gpat+ckgVfcdty9lbuqa6VJkPwz?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b205b6aa-07d8-4eec-3c94-08dacde39329
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1358.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2022 06:17:36.2661 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X6XmAZ3nXB93Qhdkqu+8JG2UEvvYAumoMDqHNzGpGiEEFOhaZcB7fo4plAFJTWOovAj9gjnxaO7s9w4fplhvcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6018
X-Proofpoint-GUID: Rrv0HeGtvI8DfPCxfS16dKhGIZ9Vn6-Z
X-Proofpoint-ORIG-GUID: Rrv0HeGtvI8DfPCxfS16dKhGIZ9Vn6-Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-24_04,2022-11-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxscore=0
 spamscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=702
 priorityscore=1501 clxscore=1015 malwarescore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211240048
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4] syscalls/prctl04: Fix false positive report when
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

The child process expectedly should not receive the expected siganl, SIGSYS,
when kernel does not support SECCOMP_MODE_FILTER. The original verify_prctl
does not realize it and gives a FAIL for not receiving the signal.

This patch tests if SECCOMP_MODE_FILTER is supported in setup and adds a
variable to record it and to inform verify_prctl later to skip the case.

Before this patch:
root@xilinx-zynq:~# /opt/ltp/testcases/bin/prctl04
tst_test.c:1431: TINFO: Timeout per run is 0h 05m 00s
prctl04.c:221: TINFO: kernel support PR_GET/SET_SECCOMP
prctl04.c:132: TPASS: prctl(PR_SET_SECCOMP) sets SECCOMP_MODE_STRICT succeed
prctl04.c:205: TPASS: SECCOMP_MODE_STRICT doesn't permit GET_SECCOMP call
prctl04.c:140: TPASS: SECCOMP_MODE_STRICT permits read(2) write(2) and _exit(2)
prctl04.c:205: TPASS: SECCOMP_MODE_STRICT doesn't permit close(2)
prctl04.c:162: TCONF: kernel doesn't support SECCOMP_MODE_FILTER
prctl04.c:162: TCONF: kernel doesn't support SECCOMP_MODE_FILTER
prctl04.c:162: TCONF: kernel doesn't support SECCOMP_MODE_FILTER
prctl04.c:212: TFAIL: SECCOMP_MODE_FILTER permits exit() unexpectedly
prctl04.c:162: TCONF: kernel doesn't support SECCOMP_MODE_FILTER

After this patch:
root@xilinx-zynq:~# /opt/ltp/testcases/bin/prctl04
tst_test.c:1431: TINFO: Timeout per run is 0h 05m 00s
prctl04.c:225: TINFO: kernel supports PR_GET/SET_SECCOMP
prctl04.c:135: TPASS: prctl(PR_SET_SECCOMP) sets SECCOMP_MODE_STRICT succeed
prctl04.c:209: TPASS: SECCOMP_MODE_STRICT doesn't permit GET_SECCOMP call
prctl04.c:143: TPASS: SECCOMP_MODE_STRICT permits read(2) write(2) and _exit(2)
prctl04.c:209: TPASS: SECCOMP_MODE_STRICT doesn't permit close(2)
prctl04.c:161: TCONF: kernel doesn't support SECCOMP_MODE_FILTER
prctl04.c:161: TCONF: kernel doesn't support SECCOMP_MODE_FILTER
prctl04.c:161: TCONF: kernel doesn't support SECCOMP_MODE_FILTER
prctl04.c:161: TCONF: kernel doesn't support SECCOMP_MODE_FILTER

Fixes: 3ddc217d7 ("syscalls/prctl04.c: New test for prctl() with PR_{SET,GET}_SECCOMP:)

Signed-off-by: He Zhe <zhe.he@windriver.com>
Reviewed-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
v2: Add a variable to record the support status instead of exit(1)
v3: Move mode_filter_not_supported check a bit upper to save a prctl call
v4: Update commit log, judge mode_filter_not_supported first

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
+		if (tc->pass_flag == 2 && mode_filter_not_supported == 0)
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
