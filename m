Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D404DC433FE
	for <ltp@archiver.kernel.org>; Wed, 16 Nov 2022 10:24:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 47C073CD03D
	for <ltp@archiver.kernel.org>; Wed, 16 Nov 2022 11:24:14 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DD9573CAFBA
 for <ltp@lists.linux.it>; Wed, 16 Nov 2022 11:24:03 +0100 (CET)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com
 [205.220.166.238])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id F08C01A00A26
 for <ltp@lists.linux.it>; Wed, 16 Nov 2022 11:23:59 +0100 (CET)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
 by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 2AG9kLG6021153
 for <ltp@lists.linux.it>; Wed, 16 Nov 2022 02:23:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
 h=from : to :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=PPS06212021;
 bh=7ldeTq8mfkep7kA6JomlYIrnMiFkuWNsyGcZTWTCv4s=;
 b=m8TXSXyWBifPpeS2RDaoWpu+ziL9xX5iN5oYAS1DfizZ+vHUIO3eoSD340leOZN6FrZj
 DwXZzgFDAMM0OaodS31VISTemwk1Gr27pv7/o/Fn5ENm4jl0am5ie8I0sVLoAwWABYYv
 8iJGGFuigDGw5+S9czFp/Jvop0490OORVbSI3BcQGyxpjHr7aBPODO8h3nO7/Guez/Ok
 lviELRmeFar/by5iMOphbc0YnpakQnBotVcJmkz1mGZSWVOiHyOj40fkEz2BIalS0/bI
 GwA/nqd/jIcRXxgJMeEvz54kh2IIHZbpID9GraNygt+Idu1WxlT2OA9mcNSHHc09XuIf RQ== 
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
 by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3kt7n9b5wu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Wed, 16 Nov 2022 02:23:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WoTSTy+pa4jKJ/O1l7fdx0YBaZKQoLtcPMI9k4WAXW7iuANDWYHtwae87VHnK21zbetKU00diTN06YvWuYfIgmHSuDLoLQNKKjGy0s4JeuUaA3hXy1gxkQDu6GQmT8sUv8FI9PjWbuRX+NTGv2NqGICiTlfCtDAJ1ITL8mVPzANMxY/ZqvkzFw29ofEzY+KcwG7HB6KGbKwnJEz+k7+5FIi0cAB6liDtb9vhwL9NTe46NFgR4k0iU2kwZD0JPfYGWsyM/8ZcYx/cRfb4jPiLcGlyZr9dRJ/fIebr5j+/+1rIf4YDYubg1JVETp1rh1pCXSPMxHU1lhjw9Yd307UHXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ldeTq8mfkep7kA6JomlYIrnMiFkuWNsyGcZTWTCv4s=;
 b=UZED3Mnd6HBc0+6O8EIRBAWpL9O0XM1qdUj9ld7X1yx3E91mtSLODJjAQHGn+49WPd0ACLfjPmlW+CLHqaSXOS0QvD5xhTI2ByIwD6i8sEzhnoNeeKh4ICYnx4shSBscRN0Ku4n5iJoH2icH4wQYoGuLb7Drpz7y/rJHPgPiaBBxYMgodmBPB2xlLAQj2VRFDmXwfS+gzMWSIc0tam/BSxO5YUhfXG9gmdmeKEISdRLp1Cfs3Ql/hBloZrOeSlxT/Xrc3uKb+izaqrqwla8XjU3yV0UVCt80PxpePhWagEZ8pu8mpH6eNieuXbNnv96bfvxEsUX1H1MNKVRHwqunvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MWHPR11MB1358.namprd11.prod.outlook.com (2603:10b6:300:23::8)
 by CY8PR11MB6940.namprd11.prod.outlook.com (2603:10b6:930:58::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Wed, 16 Nov
 2022 10:23:53 +0000
Received: from MWHPR11MB1358.namprd11.prod.outlook.com
 ([fe80::fca6:eedf:ad46:d1df]) by MWHPR11MB1358.namprd11.prod.outlook.com
 ([fe80::fca6:eedf:ad46:d1df%3]) with mapi id 15.20.5813.019; Wed, 16 Nov 2022
 10:23:53 +0000
From: He Zhe <zhe.he@windriver.com>
To: ltp@lists.linux.it
Date: Wed, 16 Nov 2022 18:23:34 +0800
Message-Id: <20221116102334.741189-1-zhe.he@windriver.com>
X-Mailer: git-send-email 2.25.1
X-ClientProxiedBy: YQBPR0101CA0294.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6d::18) To MWHPR11MB1358.namprd11.prod.outlook.com
 (2603:10b6:300:23::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR11MB1358:EE_|CY8PR11MB6940:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f208aed-1ebe-4d27-ac02-08dac7bca893
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M/FLSjNHdZNER2x9Tjf00JdLkt6xrnt3QpejOSIdO1FAT37IpAZ3uQ1QH6A/FKigyV2Xzk3GuZYCcJ6lT6q6cAjavHHbvSOAS5akKrL7uOMy28kQNKxxCTa3dJrDWAXMe1RHH0ZQd3jeVCTMMCLMUDp27pkhG1ExWRZgkMegYYCostZ0E8yPPJsikbf1j+ASLBZ3NP3KR93Vf7mCy8yUVa05F6vlnmzzqETdS7gnYK5am5UHG0lUPVdLxn3oVgvljcnPLepLQSsEu4mQb3F7P5POqLAyYbUlnfXgPDHy6Wj+tUmnAK1AFLdD+eu1ibGU/ZmS9MqdRWtx/rprTOFvxADibSefeiVAGJsIzqiKuWQIMmj8GS0FGPSClt4gkqGddrhedmk740SVOWKEFDbLZg9ti0SeZuRez7wimB66WnJG6EDNEJT1YrL3HpVB7op0DeKKs5hHNOX0V8GWq7FPAL7O1Qhm//1nwcFef/npnl0KTPmZ/bzmaVMN1A9sApV+42Q7peQaAzabkuMTS2hUEkO+UvIlwRRrtlYGNzd167xu9djV7QRufiVG7WwbwDAgFEHYtrqZLERlNFTcVWDt19akVseg2EtGnTmUstA6m9VJ7/oy3S+cBk6Sdy5wkhGx4GMRj0meyFHWJRu98qDMoxH65+nJUGbAAJ/we5sS4TvgB+D8ZUqBsElBW4pxOu6mkC4JEtpOHMnqM0ILx01JEG6NSQsxd1PqZNekKzxeJLbugrHRPPQ6V93nWJlBDm4de2ORoTXmzujojTRTvWO21w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR11MB1358.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(396003)(136003)(39850400004)(346002)(366004)(451199015)(478600001)(6486002)(52116002)(6666004)(6506007)(6916009)(316002)(66556008)(41300700001)(8676002)(66476007)(8936002)(186003)(1076003)(2616005)(36756003)(5660300002)(2906002)(66946007)(86362001)(83380400001)(38100700002)(26005)(6512007)(38350700002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DcXgKJJp4YQRg8jKrsTQXOj7OS6wrZtELD8UE2+QMUJAcvGmlP3JVFRs05Oz?=
 =?us-ascii?Q?cTbtFvBv/djLj4RKUYzjohViezZIWMulvkeM6e0IK4AmvumO6XXBuhG3gx+r?=
 =?us-ascii?Q?dNS1Q5ngP+6eXgrAsWklKB3RYs0WbCqloASDuOqxU870exkbAVcnBikecGEE?=
 =?us-ascii?Q?G01YhLZNHmwuY9bu12/coQvbyU0QdN7ctyaWyc0E/7zJ7alag0PXf6BT253Q?=
 =?us-ascii?Q?QCGCWo/H0jeHvvWKT1nJAm19i3nzMBCn1dxWO5bNai1eqrihp1maTL/MbeJ9?=
 =?us-ascii?Q?MMl0c93xvIwqn/Gv4wkCRAAzSBkxKVxItg5I8NdGkke2wTUYXg+PXJSrbi3S?=
 =?us-ascii?Q?tCjf7NH/bH8H2x524QTRBr+ULqNtwaNSMVZmZ/ty5PS9ZyFzj8bHASgeOTE0?=
 =?us-ascii?Q?E4mLS/3tf3FCpzxuaDQihonZs3i0hf8xGK5FEm/YKyA1rExDcVXQAdGA5isx?=
 =?us-ascii?Q?gvJz13RgmFs8Ywoeep0AK9+++4lP2gyuTSEGz4qSIIiGobRJlDbVsTjPeZt8?=
 =?us-ascii?Q?9IhKbGq0noxDP/RF1eL9KhxLZgKhvvDqF6AGAL692sJpsgALwYzp6WijQX3m?=
 =?us-ascii?Q?uNsSJWMuwEo+Rt+d9FtV60puSx0+yo+MG6v/jSI6xvgnQGZ8vWyW9kyMBev8?=
 =?us-ascii?Q?MImmRhtdhYVuW2RRJdTd3Kb7QANistWjPUnoFLcnMJYxwuHeSCR5cTiv15BU?=
 =?us-ascii?Q?V8CsSrOEDZZbukutB/DwoOIAfhzYkR1j5zx3tFmceiZV3ReduRDPMeAsU5+Y?=
 =?us-ascii?Q?LEa4L5eOeop7pZAfWArThGir450YxGYiqe9a1k3Q16n5t8qaVk8I/C9hMBv2?=
 =?us-ascii?Q?OT2IoIU/O2r/uI8R3wWROZqnw3/dsXIj2sdXOy3t4bXhFxmPzrnZ5xS7z542?=
 =?us-ascii?Q?m+zeMjKymVwiUCrzK8QAmwZUNeWzXan4YUj5aoDakFdqDIEWKp8iHT9130zv?=
 =?us-ascii?Q?FCVnNfcDxcFnOKAclVU5MG91JkuiYx0Nbb3DYSnDkZcdG/7YEDK2zHUjH+h/?=
 =?us-ascii?Q?XT4WmND1Rd5yEpardJXKD6kfYuE7U6WAtTWwEUynt/MCRyo8MqxDmPXCs/34?=
 =?us-ascii?Q?aoyG1CKP9TSiKeYvUlB5y9TzlDp2WR6OOQ4fa5FWNd+2dThYabQzph3ZY0y8?=
 =?us-ascii?Q?6Bd7mQUB47YxWyI8EtEsPrGXoTN9BKq1jUJFnrzYE16r6HQ0lldXrIu8AQeB?=
 =?us-ascii?Q?ittZktupLk9HscxJWU2Q40LYky2gvuCYDjmYyHGxxzGxTub9NnkbdaPpSI0q?=
 =?us-ascii?Q?t3v0SDpU+Ye/4oZiDfKozhwseN72WkETR6TCzvNCJcMg8WQ2+uWgmtYmO2Pk?=
 =?us-ascii?Q?jfk2Q5+HAsVfxBV477NnlqweNkGtc8MYTAHYEMusRDTAjGKXdmAC/ZL32w4V?=
 =?us-ascii?Q?ClE990d3z6GaC7zPu+ugP89MVaGI8t68vQKq7Yw+cf/1MdzUjpfvf7+TsESs?=
 =?us-ascii?Q?fp7bHOgTTksny3XyAMkwM9njvDF4yQUA1yFigypmU+j36a48gk5AQtlBtmQr?=
 =?us-ascii?Q?F/ZCz385h44/eXAxxcdF+JmJKjcR5dvCGKBP6Zo2R2bkO/gg7alXO4CqVa96?=
 =?us-ascii?Q?Qu5kq0K0ndfAKbHjnBwq3sXoZBCjcQN1rPGSqdyx?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f208aed-1ebe-4d27-ac02-08dac7bca893
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1358.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 10:23:53.7374 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aWeSjJEjuuOJ+u6aJA9yEphGD6SIrgObisl2100n1lBU2IAqx3tPot5hT/6iAhAU/mIbBZOD+nRa1b1T+7il1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6940
X-Proofpoint-ORIG-GUID: i3SeNVwadIQ7bxdpZgB3BdTZN4dnNPQ5
X-Proofpoint-GUID: i3SeNVwadIQ7bxdpZgB3BdTZN4dnNPQ5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-16_01,2022-11-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0
 bulkscore=0 malwarescore=0 priorityscore=1501 adultscore=0 suspectscore=0
 spamscore=0 mlxlogscore=436 lowpriorityscore=0 mlxscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211160072
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/prctl04: Fix false positive report when
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

This patch makes the child process exit with 1 to indicate such case.

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
 testcases/kernel/syscalls/prctl/prctl04.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/prctl/prctl04.c b/testcases/kernel/syscalls/prctl/prctl04.c
index b9f4c2a10..868b35a29 100644
--- a/testcases/kernel/syscalls/prctl/prctl04.c
+++ b/testcases/kernel/syscalls/prctl/prctl04.c
@@ -158,12 +158,14 @@ static void check_filter_mode(int val)
 
 	TEST(prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER, &strict));
 	if (TST_RET == -1) {
-		if (TST_ERR == EINVAL)
+		if (TST_ERR == EINVAL) {
 			tst_res(TCONF,
 				"kernel doesn't support SECCOMP_MODE_FILTER");
-		else
+			exit(1);
+		} else {
 			tst_res(TFAIL | TERRNO,
 				"prctl(PR_SET_SECCOMP) sets SECCOMP_MODE_FILTER failed");
+		}
 		return;
 	}
 
@@ -208,7 +210,7 @@ static void verify_prctl(unsigned int n)
 			return;
 		}
 
-		if (tc->pass_flag == 2)
+		if (!(WIFEXITED(status) && WEXITSTATUS(status) == 1) && tc->pass_flag == 2)
 			tst_res(TFAIL,
 				"SECCOMP_MODE_FILTER permits exit() unexpectedly");
 	}
-- 
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
