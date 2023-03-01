Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81355C6FA9D
	for <ltp@archiver.kernel.org>; Wed,  1 Mar 2023 14:17:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 90D743CCE20
	for <ltp@archiver.kernel.org>; Wed,  1 Mar 2023 15:16:58 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7E4E53CB2CF
 for <ltp@lists.linux.it>; Wed,  1 Mar 2023 15:16:47 +0100 (CET)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id DF71510011A8
 for <ltp@lists.linux.it>; Wed,  1 Mar 2023 15:16:45 +0100 (CET)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 321D33kX007915 for <ltp@lists.linux.it>; Wed, 1 Mar 2023 14:16:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=QHpqk6H+Sg/D5ckbZzW5JqpSDtBhRTS2bC2/LzSWl3c=;
 b=L6DyeNpnvdCoEuSsLsfh2iqX2hASo0/6zATm32o6cgFQ2u3xEb+nx54tSlt2yXLgzl29
 4L2ZnQbCngImrPyPugcnvihr8J0/sDEoCb3pUs8XUZkmlOXC0SStbhmagIyoUnLqzfWF
 rdDbyk9/S2WP6KEn/3QxEd1VkNplQtPt2zfzNyE73uAKsFEgSGUsmH2VjUFK6uPuLjOF
 yNRtdXcJbsXrkkVhU0aS55Mzn3cGMY3piJJzGjZntg2WJ2AE4obaH5m39maxXVT4rTQ3
 nd8HYPy/E7EYLpncfrWtwqTH3K08doswL1e9kY5e1NUIUw3Us2XL+9GWGzIPONoAw+3/ 3Q== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nybb2h39b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <ltp@lists.linux.it>; Wed, 01 Mar 2023 14:16:43 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 321CopJq013067
 for <ltp@lists.linux.it>; Wed, 1 Mar 2023 14:16:42 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3ny8s8gxwv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <ltp@lists.linux.it>; Wed, 01 Mar 2023 14:16:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nMGd3Wg1rHHGwrv6IZkLwtPdci82EnEvDNhG1l/DWEy3OWXr4uhiGhJuVBGNdELLxWc7MwFfyFq3uT9FXV3rIuo3qpDoVZ2Zuh/BBl/yRHcUe4fr8+U8LUVsTD2eKf2Kjlk7TP9ixIFFNrS+ce8CEOEDEysCF9bzz/JsnaX4KiCKTpU05i/T0Yxmn5Y6amPRilNuqzfchL2d8/Yb/z42ffgKrqDddVKqAg9FZmgXq7mY4JpotGIx60qgbcxRYgb9itart8RhN3EpfOkIQIMjatxppPtzLjX04wduhI4UEONl0z11/e7B3I889rrFHrmF8uN+uu8+/OAzSTby7oIIJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QHpqk6H+Sg/D5ckbZzW5JqpSDtBhRTS2bC2/LzSWl3c=;
 b=YSRB7TV94shWuGsQlP8ag1slWGRKT3CvlFLnsrRJZRZVWz9mD+qjXry6n7eLEZhNh+C0rT7TVcswRz+vIcRykXyJAraohrFOk2q2F9+rOxGw+Akz4P/EOBFJAiFYciiSxhCtfRXGTcm3bFLfXkUCNzWwoeJdwhj4gDMWj4gURtLDcBsYZZfRNf83PqCvKlcln5NEfMK6/aOQKvDL1m3OFRBdgGu6zO8NN3TH7NJle/Bt0upcsTPwltfWtbgdAqjYO9UnL++wBn+JmGo/k89h+TeXyHUsS/3OTn3LMy8Kj7nOHcEIvHhlU977Mayk5L1YFg557hF659lDl7rf5j2AwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QHpqk6H+Sg/D5ckbZzW5JqpSDtBhRTS2bC2/LzSWl3c=;
 b=LnbSVn3Boo4FEV2QKozQjDg2Qhvfw+iAywrFGuE5KGQ1bHRqCo3TL8ETzmDWcyjWAAnESlt7THNm2AenDM+5b++JpXNwkMRpcnU7sX1+7jyn0JXOVZB45vQopdjBD/K64l73yLS41GUyj/XDZ5ynhZqRnwa9Mx/BQZGk1MOiLFQ=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BLAPR10MB4819.namprd10.prod.outlook.com (2603:10b6:208:307::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18; Wed, 1 Mar
 2023 14:16:38 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::93c9:c99e:5ab:4319]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::93c9:c99e:5ab:4319%7]) with mapi id 15.20.6156.017; Wed, 1 Mar 2023
 14:16:38 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: ltp@lists.linux.it
Date: Wed,  1 Mar 2023 09:16:34 -0500
Message-Id: <20230301141634.2881117-1-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.0
X-ClientProxiedBy: YT4PR01CA0185.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:110::29) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|BLAPR10MB4819:EE_
X-MS-Office365-Filtering-Correlation-Id: 665c0d56-69d2-4d30-0f15-08db1a5f9246
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XmzCFwBlktHfDJNcM1kbUTGqSPbjhqLHdJj1naNbxH8AFGkdDwhRibjcCuqPHMLOJxrdjM6eb1peoEAfCL8qZsw+piqkkk2z60iOO+/Y+5j3GjQdjPw7MZme3bbgcZ2EFrPFBx7ChZZn2B5kGzWGaJkkktBNw1ClGSeX7DdRsoIeJmUcFHMgh3rK3wN2PMIEE8E735eJLt2T5KaR/XbdPWR5utKr6us8JnGhMRjkHAJyQ9MuNn6OGFMr9NnNBalcCnlx9P6X1l5e8F2i7qeLX7wO+sq897D+WiTZ2Aky+uB8LerXBL2E47XUZ9kD+aWi8zkSIceaF1VbgYYVrcqb5Dmm6eOs+YPI1/n8fKTnRdMd2+h0I1z6R1OD5AigM3/G3qkuw3y3RVr9AqjbyQTPr5MZhzaiH+nTDqsfT2OHh5MP6gQN2ZBpyuyKf0Z2EzaHUY4Ew6yZRD0U3y8m62DfdDGFFFqUAGbWuJw8DsJZGFUZe7g1qsAfVXqQsD0WB4oa95zmdGk2oHSzKZj479WGufXhTtjQiRPr7Ft5hRDjEge7lYjSuoN6AgNXYDNsIWyrhmLVM1K/SQ98nVRp3to7y87E2et9kEB3O/RgkcIUeCQGqF/5xPGQFoe35UWy56zg6iU3xv4CimAA5ZcxOEXE5nNDMnBC8FKWxzxaFUXcdsbA8yHc3h1Jy8t1qz8kTz3u
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR10MB3022.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(346002)(136003)(366004)(376002)(39860400002)(396003)(451199018)(41300700001)(8936002)(1076003)(26005)(5660300002)(8676002)(66476007)(4326008)(6916009)(66946007)(186003)(66556008)(86362001)(316002)(36756003)(83380400001)(966005)(6486002)(478600001)(6512007)(2906002)(6666004)(107886003)(6506007)(38100700002)(2616005)(2004002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Bsq0gnYPtahmmEDMGsh30pIy/tz+iVg8xNmj4IMdgfD84H0Bh/5gfxX00eUD?=
 =?us-ascii?Q?tt9VprhAorqFzyZfzaI0Hx0lWfksGNfcJh6pFhkvqv7PLCB5UDYFNmoGZM5q?=
 =?us-ascii?Q?ES6NPYXB28IiXosJWunmkqUfxOFroE6xeoYr8vfEIrwkj2NNb6JUN+DmrtVD?=
 =?us-ascii?Q?MshCi9VU4Yd/Oko+wOQyeADUfqLOBpgqvAmo/0Vmrt1m+giMZg3d07xZqoa4?=
 =?us-ascii?Q?9bsejr9dfRV67gwYzODKqDiIj5qusbomC3j2dt7SPse2iPKyYeryZ7rrzKg+?=
 =?us-ascii?Q?ngVRdOi7lqS0XXUBfQEo7artLVZxS/IoolGWy2a1Et8C4/LfdukxmfJ5qsaI?=
 =?us-ascii?Q?eMJ4Da80AuzcjOYHWKZWMpG8IyCL9WohuFRoBhBjlM6DHEphOkbABdgHUPJ/?=
 =?us-ascii?Q?c27aIWvfW52N0IxsZaO6yICt4uoQ1d4rW3Pyydql35KVxwLBR1fFPnuAkaU1?=
 =?us-ascii?Q?jrempajZgCS4ey2mssOhIq7v0VFBEH11sa1nxnR+F50paqtoLw1EOUoX8qdn?=
 =?us-ascii?Q?/r0SbRfKnr4Dl0zjM2imWLHnPeV8g1OarQsJCNZla3eZZw7vbOV093UiDo+J?=
 =?us-ascii?Q?DvO5XyImfgMUN6AfecD976rvHm5n1pAM2jhbYptgpn8OhLu2dP8JAI3r7lXd?=
 =?us-ascii?Q?z0+MCfzch03n2EdIH8010hrEQewYR4QFMKINzRqm3lGW7uQSRNeNF0Vu2ybR?=
 =?us-ascii?Q?uDsnkjsOteOInenlqqlRnPIeJzHbBkTKalmlOYDcgm0qCAEvFEh9BaGg4bdk?=
 =?us-ascii?Q?+zVTvAzlO+VqDzg4CntHkyeGSwCAQ+zQh4MXuORyJVHP6DWScfJY1tg21XC0?=
 =?us-ascii?Q?rAQZeR0UAMPIUiyKvPxuB5tc1gWnOA1tQOAi8RKJoQZWIdDpVs3VVqLw5lT6?=
 =?us-ascii?Q?/WV/nD8T+kg4Fy3A9UvmZwQugyIa7onJ7z6GrBAviq+eHKc0G5rbJQRl6gO5?=
 =?us-ascii?Q?LtXhsxw77hZY/nzzfubDR+11/FOSMsE8mnnGzQUPmMzFTfg/dCpfEqhm7gpB?=
 =?us-ascii?Q?6lgpEqp/n+FZHwgVqwpO8jqOVVrHvhWS+YQrzcr7eIMmMUlkqLTZ/0yEL8fN?=
 =?us-ascii?Q?2JlTibi4k2UdVJLaFNccWcYPv9qrbE09hNGXyaqIG1XNjqFbYkEDdqj5UZc6?=
 =?us-ascii?Q?e9OMszVYYqqt4pjT/gTQsCvZ159lNWLa4eIB7HcbeT8S1EYmp0HZ1+KZv/Hn?=
 =?us-ascii?Q?xzstVVwwEeNANwg+Q4U3CNLN1NsbyoKVcpl6JEA9vb2iTvA1RUS7HIHq3SLY?=
 =?us-ascii?Q?RDGr+H5XVKg5In5elJn20CVcLsXsR8ssdpat2Y/WQMok2ot0CPvsCvMWReyg?=
 =?us-ascii?Q?jeTWJFNR2tjHP9+a8sm3IPGRql7VaKo0h0u1DAlo/KjBo1E9oG/ULp5BxvnP?=
 =?us-ascii?Q?lCLrObrnmfziHjYXvdWGKUb2Qllcb236HhOmiEcAQ26z0sjIOQg3aERNwvjX?=
 =?us-ascii?Q?4tSMvOcFMwVFBTUoykx1+s1isvFHhiAIGBSoDN/R6t17BJsF5dvCDiqHCKh7?=
 =?us-ascii?Q?5n2wRLHHUeQkgjyt9E9bEIDvnlBMLSd0AiOZ/7o5dbe3h3qbWFhol6tX2DI+?=
 =?us-ascii?Q?u0MoxyXhhadFLmq0WLpI7GIE0owklAO8Xs8cdloKRL4YfmmQNU4mOui4z4Jt?=
 =?us-ascii?Q?Fw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: tth5nK6sKl4pOKEZUID8cLhxpGix0EeIxpVFR2KQT7Iwl23tvPkXWSiRHu/OrKSZM3s1nnDe9MDynuI/L15ZxBaFCCQaboPgj/PND0BxzhQD5J1VyMVLtnhLuU9yzG2qyno2TEEuozxfU9xIVG6OHSBWRSFQaypK8T1HqdhcTsdDrcVT0jE1AEcfg3cY7rz6oCxhVCVuxmgz2sRJJYi/uMuEUwPJOlRjhKrs2FQxsIK42g/KiKKkg/GBrbyoQeA6mrnYkNtpZbIWBCqqWVonyKdLxv6915MRyVRaziFfMPUopq9V9pRzFiZyke/wrttj63h3bounJvCmzNsbMY7bEWkbCqBgUxQZLxJMoEp6lkytFrvwbo0eLYLzBqTkzQeyqQaCi+soXSWSi1j4WTnUfXc76C39DSsZ84rreBTZdULoVNuJmpyvNvyQ/atQTivXYALLokcLK5nVT+28zvGCN3hatWoB9xLjFaYtITnbMfq6hGfvp6POfwPQfb46HNpxnq0mNvIs9q1plLGF7sH+USLCnl8HNq30o4qHfceJYwyH6DdHfzEDgod7yEuwCOY+gW80YVEFuRzONFoKLcwVrr9quRHiu7Q5fq2UIqMJaBw6ICNG1WQYd0RhEULBEAT3ih4dRGrW8wY1O1igm7ALHxpmY8POYcdruYJVQeZIUKTi5fUR6LsWTraHWw8KsC9U0tl2F4EPwKsg1hzwER+lgGvghYm9rlLVxno4DOg06yvdSgCsuWOIWU1HaeQ2eb+3
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 665c0d56-69d2-4d30-0f15-08db1a5f9246
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 14:16:38.1962 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lAWC7n/ynJWyWwA81pkSx9S7nSfwNLKc++APK3Ow5wQbAxBW6rFJW08cc6RxgKAp66hC/9q372xqYvzS/EFoKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4819
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-01_11,2023-03-01_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 spamscore=0
 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=979 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303010119
X-Proofpoint-GUID: zPNCEXWTZ89Jeu7Aq-EWzQeiL-WDrJB5
X-Proofpoint-ORIG-GUID: zPNCEXWTZ89Jeu7Aq-EWzQeiL-WDrJB5
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] mprotect: Add mprotect05 testcase
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
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Add a test that uses mprotect to split and combine VMAs.  Created to
ensure the correctness of the VMA iterator after a bug report.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=217061
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 .../kernel/syscalls/mprotect/mprotect05.c     | 118 ++++++++++++++++++
 1 file changed, 118 insertions(+)
 create mode 100644 testcases/kernel/syscalls/mprotect/mprotect05.c

diff --git a/testcases/kernel/syscalls/mprotect/mprotect05.c b/testcases/kernel/syscalls/mprotect/mprotect05.c
new file mode 100644
index 000000000..36f137544
--- /dev/null
+++ b/testcases/kernel/syscalls/mprotect/mprotect05.c
@@ -0,0 +1,118 @@
+/*
+ * Copyright (c) International Business Machines  Corp., 2001
+ *
+ * This program is free software;  you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ * the GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program;  if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ */
+
+/*
+ * DESCRIPTION
+ *	Testcase to check the mprotect(2) system call split/merge
+ *
+ * ALGORITHM
+ *	Create a mapped region using mmap with READ permission.
+ *	Create different VMAs in stripes with mprotect (exec & write)
+ *	mprotect over middle & write area, causing vma_merge of prev & next
+ *	before hitting the limnits.
+ *
+ */
+
+#include <sys/mman.h>
+#include <sys/wait.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <limits.h>
+#include <stdlib.h>
+#include "test.h"
+
+#include "safe_macros.h"
+
+static void sighandler(int sig);
+static void cleanup(void);
+static void setup(void);
+
+char *TCID = "mprotect05";
+int TST_TOTAL = 1;
+static int fd;
+static char file1[BUFSIZ];
+
+static char *addr = MAP_FAILED;
+static unsigned long fullsize;
+
+int main(int ac, char **av)
+{
+	int lc;
+	int fd;
+	unsigned long pagesize;
+
+	tst_parse_opts(ac, av, NULL, NULL);
+
+	setup();
+
+	pagesize = getpagesize();
+	fullsize = 5 * pagesize;
+
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		fd = SAFE_OPEN(cleanup, file1, O_RDWR | O_CREAT, 0777);
+
+		addr = SAFE_MMAP(cleanup, 0, fullsize, PROT_READ,
+				MAP_SHARED, fd, 0);
+
+		TEST(mprotect(addr + pagesize, pagesize*1, PROT_EXEC));
+		if (TEST_RETURN)
+			tst_resm(TFAIL | TERRNO, "mprotect failed to write");
+
+		TEST(mprotect(addr + 3*pagesize, pagesize, PROT_WRITE));
+		if (TEST_RETURN)
+			tst_resm(TFAIL | TERRNO, "mprotect failed to write");
+
+		TEST(mprotect(addr + pagesize, pagesize*4, PROT_READ));
+		if (TEST_RETURN)
+			tst_resm(TFAIL | TERRNO, "mprotect failed to write");
+
+		SAFE_MUNMAP(cleanup, addr, fullsize);
+		addr = MAP_FAILED;
+		SAFE_CLOSE(cleanup, fd);
+		SAFE_UNLINK(cleanup, file1);
+	}
+
+	cleanup();
+	tst_exit();
+}
+
+static void sighandler(int sig)
+{
+	_exit((sig == SIGSEGV) ? 0 : sig);
+}
+
+static void setup(void)
+{
+	tst_sig(FORK, sighandler, cleanup);
+
+	TEST_PAUSE;
+
+	tst_tmpdir();
+
+	sprintf(file1, "mprotect05.tmp.%d", getpid());
+}
+
+static void cleanup(void)
+{
+	if (addr != MAP_FAILED) {
+		SAFE_MUNMAP(NULL, addr, fullsize);
+		SAFE_CLOSE(NULL, fd);
+	}
+
+	tst_rmdir();
+}
-- 
2.39.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
