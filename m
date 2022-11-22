Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CF88C4332F
	for <ltp@archiver.kernel.org>; Tue, 22 Nov 2022 08:12:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7B6173CCAD5
	for <ltp@archiver.kernel.org>; Tue, 22 Nov 2022 09:12:23 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BCCD73C0367
 for <ltp@lists.linux.it>; Tue, 22 Nov 2022 09:12:12 +0100 (CET)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com
 [205.220.166.238])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 07D531433CFD
 for <ltp@lists.linux.it>; Tue, 22 Nov 2022 09:12:07 +0100 (CET)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
 by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 2AM80Ija019499; Tue, 22 Nov 2022 00:12:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
 h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=PPS06212021;
 bh=Z4BKuG7zzXD5DB2LNa1ylfJiPsiOfUvx5EUQF9sfOhc=;
 b=ba8Hd5JqiUEEnwg8OiIePeokM+Fwwik/AMjy361pZpgMuYo9EOOGT8pdQa631qhcOC9P
 X2GkCU9r92HLPphWxvogFn1D+aR534xm6nhiXIG56hS2q5AJ4ITBRSwgeHxj4inZuNCU
 ByGOU+ZqpiNgBqnMmM+/nnj9MuDoy5lKco8PbSRN5eeaTUjxK6J972/ArEKxRuAMdb6H
 vnt3CoB/lF5duMOnV7yJ/IsAoi0I0ee1JqW1EoxHIpqHfaUyp21QXl+bXMPVUUQcmnB2
 SuKm0xBelZo/Ia/1cMohdxPy6LvoJQ7Lq2JDnRMhW+je/ejeDXD5a/vx6ZG21Bvbs7HM 0w== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
 by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3kxua6a82n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Nov 2022 00:12:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DO2TAfEqIGAK76145E+DNdmxR2p6WfGs0xA5yBw98C1cXZYpmzs3J4brc4AGGkvDqtG4sw/0WRIxT3tCeH4nLEKJlsvHtKaIW8FVaS1/6BYO9eRREks0mTzQQWcHWYoqVAiCU10Mpc8S1Joqx/RxG6dRGRRv0aDdY1gzo/R2akZHNwNau/eQ07GWJzeNMD1Cegk7yrgNoqGYhmju9Z13jjkGtSmLtIxg753vPLrZlyr13JrFa4KePLfo5urgq3rvH0JDcdCQ+aPxtL/B8Fv5Yyx42uI/zXoCPfTgHtaoLRprIvr/bqncePvXNR7xePeM6zqnFov1ESPcxTjRSZNH3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z4BKuG7zzXD5DB2LNa1ylfJiPsiOfUvx5EUQF9sfOhc=;
 b=W0YLzCm2dcFMz8I54g90p1hKh958QblCtKdW3pqqhI0nVYvfcdFe8cXTOnogC2NQYITW5QTkBe/H4HaA8a7n42IJa/YbWzjAvaHk3RL3ZI++jmlX4tUix8G5O313w0+vymbhTf+xDUskmwmP2xMra7z/8SxyP9U0cgVcP9rsWlQFHTXPMeiPR4sAkyZ+jdGzm+Oqu9L5i+BNd4X6LQyYojYWJlv35xTc2myZdftK6mDQv7Pxhi1XkYKuEL7950+dRWxnY0LbaWx13SPUc1lqNyY6JQn7zJPy/iKL4FDsKu/ASFU8Z9vLYku6kHKsCwBVc6WR5wjKPS7ML29+BOKdoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MWHPR11MB1358.namprd11.prod.outlook.com (2603:10b6:300:23::8)
 by PH8PR11MB6756.namprd11.prod.outlook.com (2603:10b6:510:1cb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Tue, 22 Nov
 2022 08:11:59 +0000
Received: from MWHPR11MB1358.namprd11.prod.outlook.com
 ([fe80::fca6:eedf:ad46:d1df]) by MWHPR11MB1358.namprd11.prod.outlook.com
 ([fe80::fca6:eedf:ad46:d1df%3]) with mapi id 15.20.5834.015; Tue, 22 Nov 2022
 08:11:59 +0000
From: He Zhe <zhe.he@windriver.com>
To: ltp@lists.linux.it
Date: Tue, 22 Nov 2022 16:11:42 +0800
Message-Id: <20221122081142.2433326-1-zhe.he@windriver.com>
X-Mailer: git-send-email 2.25.1
X-ClientProxiedBy: SL2P216CA0087.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2::20) To MWHPR11MB1358.namprd11.prod.outlook.com
 (2603:10b6:300:23::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR11MB1358:EE_|PH8PR11MB6756:EE_
X-MS-Office365-Filtering-Correlation-Id: ea8c7bee-4d8e-4b27-1200-08dacc613a58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8TVzhe6At76j2+r9qepeCovDr9BGs+1tApNxvrcAW7kIBCqPSL17kWB/BTP7BtICqlak096RCFIutBUTUmzT6hd3Z8YLTYmgMjsVC0bP4sJJWrhmzRv2SpSaUixJTMhYCOp7Rdms7fHiqDJDPUkLxSnL+M2no47exJFe9XsV2UNF6lchILOL7NQ54W8mmDkng+oerwHou+73MEhuIPXLiO60d1KtEWWoOWvfAJw9+Ltolvr+RTj4C0Q0kfkgOMbM7gjT4pVU4bj7BNm2k5GJb9gx4PHT/EpUkrvVJzC3rC7FO1DPaZcsHzrcy3/D6A9k4fSV0l80XbNJlhsrwAIoMEYyFqOtMWPaNn5iXoXRwuRMeSYE9uKPSY6ZRn+pW+qUyYeHXEcpfLb7DMHdO42c0X+RsRnqY/e61Gf7/fsHuzh9OHcjuzBWU9hlG8dTgVI4r33ZZtf95PizJTxZKFRVBu1iLSYcjCv1FmrQ2EDAGVQUsUUpGl0yzINI2MwdVsdDye/iD/EffCivQPg3AvRFmWtoxs1aBKimfXHPNcWBWhIj08uKtVRB06/jvEgW7i5ZKqqIVBX3s5nMFdtuZOldurXBTiH5ZagPfQn8p2+yD9JRBXNa41b8rOylQVHg03qzfUIQXbYiWr2DFs70PjF+d4xrCXyeGDYUfpB5fKCy6saKAgRuwdqa4jFrdu0tSIyEtyGVHnRtfrwdgtOECdmxwA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR11MB1358.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39850400004)(366004)(396003)(376002)(136003)(346002)(451199015)(2616005)(2906002)(1076003)(186003)(478600001)(6666004)(66556008)(26005)(66946007)(6512007)(6506007)(4326008)(5660300002)(316002)(66476007)(38100700002)(8676002)(36756003)(6916009)(52116002)(8936002)(83380400001)(6486002)(38350700002)(86362001)(41300700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XWNK5Ko8c9hLcDA3rvLP/bVa1sQfL95BPrMuLATLj3DSMYykb5SyQibV7Rkn?=
 =?us-ascii?Q?vjCnmjuqLOFMPYKyj4yFbdzJUAB7uE/pSyxLUZtKmXemRquuBaMBHM4yKJt1?=
 =?us-ascii?Q?aGjsJgGcCaviFnPA+yWBJvIbVY/ivdK9IUMw7D9ps9D/PmfwfHTlSuWroidC?=
 =?us-ascii?Q?EJCvrQuIWXMvl5hf4KS2L5AEZnBhOc8ssEX9sYQ1kYJ5nWDnyDviFEAQNPgE?=
 =?us-ascii?Q?wbb12CUIGx8OpHfCcTfoOFgvwgQFp2J3QqrVtiLZndGBjMHL12EjmTcWtyoc?=
 =?us-ascii?Q?Key8ApURz8x3ScWyPe3NhU6kjnVpJQnUryqn7UbuLAe1r/zJYWy7f9Eoaw3t?=
 =?us-ascii?Q?pZLwjKqe9jdbGyiijGhnP6EcQA3WZqx1CdIOCDyXQtoeRQx8jHRvCOJHLypA?=
 =?us-ascii?Q?p+x7GghouWPkfm8/E/CNkFc7pdM9apGiAZsHGhSrXiW1auxb101t2R3nO5se?=
 =?us-ascii?Q?2+7AgoZ3CZb9yI3v2EC5lvCzjX2aTAygvb97M5h6neYSkvF5FMVbFxYhoYQW?=
 =?us-ascii?Q?welvnKA0i4O98D3W7/JC9HHW0OBLbQIMrIBtpLBlB+r+GcIG5cXCVpSJCm/O?=
 =?us-ascii?Q?+ghVyDld/o34jiI8+OqBxyEqiDfDK/Ny6ZHebiUlpk36/JUtq3i0fOoTpQOQ?=
 =?us-ascii?Q?StJW6Z1Shm0PRYjOnrGk884YRJDfP6/XomSiqSK/1kMMBgf2/XPTQ06QqI+H?=
 =?us-ascii?Q?xRxM5j1mcvVnfBxIwcjaPfb2OKj+71Oj2V5EI/NMWl4C4unDg18VGyHcianZ?=
 =?us-ascii?Q?jBWC0d5GdvAik6Lrijz5R/Igoc6ipEOMTfV7qBxvTMHGZDRRZgkecfh16cMH?=
 =?us-ascii?Q?lhmVhbe6SbqvPSvGqevdFg4Lz9gLZDbFeLxbLgPFwZ4q7DJ5JUB5gIHmh/R/?=
 =?us-ascii?Q?QWMTFnHDL+6fKuYTUpsbo2y6+HshEJnTcPrdpIdyB1ksDeleTygFrjCNxI0g?=
 =?us-ascii?Q?cMC4SOPysO51lkbzz4tYBJTeCgX82d3Q09xrkiVf/dBArmHwBwN4zcGCcOne?=
 =?us-ascii?Q?mqcFUp78zTYmKZh+TIjcgVF7Kh/3xDWomLTQL/EULs9rhci85+VXj/JnbcxS?=
 =?us-ascii?Q?njEZb4wKW/TBwyRtaj0l08Bw05xZZSY9oSBv6SqCRocVC2/p5IvhyI4nCSyv?=
 =?us-ascii?Q?AcnuO7bsputjaLpRD167N7KQFlRS2cTuZZFEZM33U3tCOTkTg4ndAlJNM/4L?=
 =?us-ascii?Q?emGD4YIePveQWJ/1KHm3CGvMXEOtZ1208n9BNkjxAyd2bmuAE3GaAKjnDSNr?=
 =?us-ascii?Q?jC6PYyRinKfDPAIM0TEMDKxVxC391LWCq6pRpVlG10YqWVi8+DfNsjLmIqNz?=
 =?us-ascii?Q?DLgK+aL2y7rcM7kyQKKFA9hQVfgk6T1Z57n+H5o1Ay9gED63Y/EYHb23xaCv?=
 =?us-ascii?Q?lmLxjD+U66ClZW+y4W+uhGUjCtKhu5XW6M0hpB5K3u6LORs4X247SkitU74v?=
 =?us-ascii?Q?Ks7a/Fh5PWUpsysbmD4f6+aIk/5jaHLsZYSEanvvU4ID5WxZbmlhybm+zILd?=
 =?us-ascii?Q?WigpNycGyjRrJJDYF+KhB3fl3JwWFoqlVej3uw6iuFOtdRtVmp6voXmF/+EX?=
 =?us-ascii?Q?ZPzDXh7CfZLlINy59mQ20DmUbtIJgd0OBLqolL92?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea8c7bee-4d8e-4b27-1200-08dacc613a58
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1358.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2022 08:11:59.2215 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s1brae8t9dfFL8Rs6z0JQEmftOoN8cMFO1EQ6/Nan627X3RVD8GTl+RrTXy8uH4Z+5HsSfwqQ1sZ4QeUtGpbrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6756
X-Proofpoint-ORIG-GUID: kCczqVIrBih5ZICXKPHgK_GzglRypNPY
X-Proofpoint-GUID: kCczqVIrBih5ZICXKPHgK_GzglRypNPY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-22_04,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0
 spamscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 mlxlogscore=704
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211220061
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
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
