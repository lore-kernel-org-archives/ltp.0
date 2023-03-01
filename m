Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24C9DC7EE23
	for <ltp@archiver.kernel.org>; Wed,  1 Mar 2023 19:34:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7D7B33CDD3E
	for <ltp@archiver.kernel.org>; Wed,  1 Mar 2023 20:34:06 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 036943CBB80
 for <ltp@lists.linux.it>; Wed,  1 Mar 2023 20:33:54 +0100 (CET)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A737314010C1
 for <ltp@lists.linux.it>; Wed,  1 Mar 2023 20:33:51 +0100 (CET)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 321Fwp4N017752 for <ltp@lists.linux.it>; Wed, 1 Mar 2023 19:33:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=Upiy0c0q8pLeJW7YXut9mt+27HMeCwqbNLkX3KH7eak=;
 b=idWhXYN9ecXYXBpa3dEjs0nv9N1hST8guHVmNiR5gPsQJLOe8Cm3AlVAUv/TDNsbbNjU
 UcEFeZQf6s2nEzjaq2Lrbzc168CD2bcNFILJSBYhCxguL/3Uc4/vgTdojpzfXLLQquKU
 bNJIsUwGYFLF3M1REIVnGvA9RfbZ1iiaUzvGhtK/3XDI+ST7b6Imw9HBnkbbHWIQ9SV5
 KQMXY6xktjcC0q4u3LjbcK3PNpuPIOO+tesqyJpo+NdCCIh1mqp4QQWldFYc9jg4HvpM
 3dLkafunkEl/R8Bro7mM/p2YyZbqYf024IgCt/0yXF7GuSmf+sR0vdVdGJZdjNpmbPa9 FA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nyba2a0at-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <ltp@lists.linux.it>; Wed, 01 Mar 2023 19:33:50 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 321ImrCb015936
 for <ltp@lists.linux.it>; Wed, 1 Mar 2023 19:33:49 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3ny8s99xp0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <ltp@lists.linux.it>; Wed, 01 Mar 2023 19:33:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cv2Ef1k6qpZG7j5nfhNueoKT+7uRVVmAlswSzScPmKJX+LbY5eVS7A5R/SSTm9oU1QjxfvObth2n/jIW+Od9cNKk+NNlI6BjTJNzUapXWXWQPkX4Cgm8MKbu9y8KL2rnfueHilql5Uljf922Cp4Yhg95xJOxspIOPfCNgm2/FWdJkP0Tt0G6dm4FdtbYlfS6AKQAQUh7aiLzwun1kJSc3yd/NmDCNFR9QRNhtBji5MLMg3H9P1dgsscKbWw54X2Tq8g8lJQAiUD/k6DltHHv1cM0F/cUhJWWtAz7SBsqAaWTRdygXxD3Wc+xbt8JV0Tx2vER/037UMIRK1tHc79sJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Upiy0c0q8pLeJW7YXut9mt+27HMeCwqbNLkX3KH7eak=;
 b=TPZjYf99Y/6t8+dpv4IqGCShKli4xUmSuqvanAIp29BuhP8IR+vlI0mM9RM9sx0F23biOhWyRysVGAzHjoqrfvRQQhucOfH0M3tNDdUGm6IVgzKzymCf67RxrJKj9m4DlnCAZABHdT895EqYbAxIiUH1ylfq4iyfCRcPP1QUvPBUwKYxvjX4CjDsnm8qK0GJdUtTHRWo19dSZ8Wr2W6JhJGLm/CATG7rsc4Sd8WBZKLQXXm2wUBKi56Tw/mqjvp6PDCbt4wYBL5lKQXcUC2U/VSf+uvjkLuYfBkyveXYPKuL2wbz1yjPlCDHMo34Z1BO+BpQI0yeCDedP+QQ3gxmzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Upiy0c0q8pLeJW7YXut9mt+27HMeCwqbNLkX3KH7eak=;
 b=i4h/H3lw4DNXEiVaVHe1g2Yl0cL8TuUe77zt/iFA0Egcw950MXcEBMiLOfKgWQpOYnKnRVxZkxCrB9rjjwHiDMZiKVE5+ISYvYp6amL6TshCiqYjOKlKbeXXiZv2bIyaHepTrV4ZHoglhfs+3Qtjwr7jpaMtfhWE26r/Zzq+gWI=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN7PR10MB6619.namprd10.prod.outlook.com (2603:10b6:806:2ae::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.17; Wed, 1 Mar
 2023 19:33:47 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::93c9:c99e:5ab:4319]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::93c9:c99e:5ab:4319%7]) with mapi id 15.20.6156.017; Wed, 1 Mar 2023
 19:33:47 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: ltp@lists.linux.it
Date: Wed,  1 Mar 2023 14:33:32 -0500
Message-Id: <20230301193332.27694-1-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
X-ClientProxiedBy: YT4PR01CA0373.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fd::15) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SN7PR10MB6619:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d404c98-0d8a-4b26-af87-08db1a8be06d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NpIiv6h7hoeEo6PVpNAp1ts2rbjVU9vlIKBY7+9vH0wVjntJqmW4VX+9Fk1XxMZaK/FStzd5LHYjUA/1QMy3Oxg3S8NVaWHdG0yfhYkONEo96nJRfw6lm8apwd7VCy9NeEgrmpu8/hl2Z/SpUbn4pJhr6nX9ILvpCAFbaw5wUjfIknJr4weNpdyhTqConGdCVQfZOYbJVdHoAG0wmZ9hLXlJQDG0hSW/A0bcK1g3zbRSOYMQXEUY4GnVj2SyBPAfQE7FRHh3b/W/t/pd+HO3vkyRABlwdSEXOBO8jwFdCRoSLpyTbduroqZaUxaCPsdDejYsNAaTDIebtLYqQdtIWApPdHC0uw6qVSLXCyBfti6VP+kH7LD+2UuhW96v4UWfKbNoA8SoM/ez0VazMI/0+ax8rtBtdF7r6Z5L5+0jgRq87x7jqNcAyHoHm+5rro5Tes/0lmpe8CEnGlpyFCe88Ttbsv+vOoefhOEHnDpR9xRQO5FMCIgejiInRKEfEegX+ZR46pxp0X+CzlPECtWaDmPtOd+CmEySMlWEG4zEv8X+Z5nSvAq4osXW1zy2KB8ejMWZBdgfU7PAXLZpy66IqWRhuQQhny2MgCDIVso4ISbrEUlJX2Kyn1fsV4Nvlrr0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR10MB3022.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(366004)(346002)(376002)(396003)(136003)(39860400002)(451199018)(6486002)(66556008)(66946007)(6916009)(8676002)(66476007)(36756003)(4326008)(8936002)(41300700001)(2906002)(86362001)(5660300002)(38100700002)(107886003)(966005)(316002)(478600001)(6666004)(83380400001)(186003)(26005)(6512007)(6506007)(1076003)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3LXcpw/OZSVa/4M5mFTtwPJFNc8lkBF/fTbY62621A5pQJsVEf7OUuJCi/Ap?=
 =?us-ascii?Q?PbMXeyDoQ0dgsIm2F2WK9EWV9nWlV23aEwdbRcXpgQ2STh+h3HaMRcu7OoGv?=
 =?us-ascii?Q?qjl61MGXV4sn3OTrh2JMvTnIVgtCqMnSjCgky45tEQH9p7hkEmcQZ2j8iFrI?=
 =?us-ascii?Q?wyHJp34Nmm55LrZA3RhasjZ9fn0HDvnUEKnJTIYRQhgLx+a3csik5oxxYo98?=
 =?us-ascii?Q?XtNBG1Y46L1/SWmJPMXRdxpieSGF+QG+c96bVBquhLGEXa8GfWysIhxyj6Da?=
 =?us-ascii?Q?uwhXGZVV+mmIumRr1MMg67VnAoVhuyVmpQukLsNDiRh8RwLP8I8ZEM4Tp5U9?=
 =?us-ascii?Q?yZ3TRaJ7W8y0hqKulb8sG6my0XdYUivK8XXRzWIrC6+Z0kxG39Ra1+mh1tne?=
 =?us-ascii?Q?w4Ud9j6SbORwOCQ0uPD7uTx0wBDTG6soxZhWmomVpNenVnoGAagqSPJpICjO?=
 =?us-ascii?Q?p+ljNrYbfe69mT+M0/2N8Y9ChqN5w+9JJ0zbuCc99n5QGRuM29HLp6vm+ihZ?=
 =?us-ascii?Q?gGFKwYzO9koS6GvXPNCaScQiW7T18t+4rkOC6tFjYC7m8+ZC/I4/h1MFSIya?=
 =?us-ascii?Q?tW6J1tBdTByzR3FE8LdcLk5P6L/jvhPsn5H6efxMXWm+DdJOf9KcdOdZ6Ot2?=
 =?us-ascii?Q?y/sTCrD8WBtJOFldjR6iUWH5ER4QMv7uOuLBdjooZEgPqWVOmmUv6YTZl8X9?=
 =?us-ascii?Q?krworfl5lhD+uQ5/V5W4YdvWUvVjC9i31W632x8MigMBVvO741sN52Cn1yTB?=
 =?us-ascii?Q?ZdWq1F84nLjOShUJWMtwCQH7ED0UrSQ3trOI1pFG0uYt2SW9qoN4e6nzI3Ph?=
 =?us-ascii?Q?r/HeRrC6Ua4Tf/2DYTvkK5qWkCJd9j8Z4XzNVJij5/VC6XQ7dgsrJMrU04yN?=
 =?us-ascii?Q?lIN4T2ASDf218cWvhrdyeYEjm7ZOUZyW9K4Q/50EsTaIBpUIXS0O9nEM3d/3?=
 =?us-ascii?Q?XqzS4bPxV06PhDxmdhq3Y1UIG7Th3ONtjUbsjmCm17tAXL4d9Z6SwImPgA+W?=
 =?us-ascii?Q?dLBa2x90MB0HC9E26ZciqIuqoO9dMAb5Q6BgiDJbrDwKcv4qHB2GVO2kyXoH?=
 =?us-ascii?Q?CyHGH9S/iTAG2STJFsT+vzenbaTs/ARzBFkSLSd6eEeJVwiX683nL/kOxW06?=
 =?us-ascii?Q?EBxJkNP7d2PGnL3ad8JkmcXmIlRFHLXe4gFjw1lcrFmUPVCxD7kp52z2PD+k?=
 =?us-ascii?Q?9FlEdk3Sfm0RD37U2jcf0R/9HB1tcIciGAeFpgg6sCwpll6Yj72qiRjb0+8e?=
 =?us-ascii?Q?PPO1L9rgUlnexZkVbH58E1Cg+Z+3bQOTbk74roS/BT33t5TaTqmM7oERnaFb?=
 =?us-ascii?Q?hUva0SIK56LD2w8IMU8w87OIbusEdAn0JxZ7fmlF8dmBvd5qgYRXNl77cSoz?=
 =?us-ascii?Q?ZP76dllblJpiAob3oshk5GgLHS/IJsuQfK2wYfJLJsLqKZCIg/jgQ3CA5+h2?=
 =?us-ascii?Q?JcfQQFSC+IwSCwjuCLw7I5gXBihcLKpThvKcnd51G6kCMhmSLRRmhO0SmU7u?=
 =?us-ascii?Q?Qs9VfpWj0a3pJlC4rum0q6weQD2WUnrtMTqkQMSmo1yg3OnDlxWASzJIoW4C?=
 =?us-ascii?Q?9fz4Id7lumnEM+wzcPtM9kt58btY1OsGme6xWMnnhTJi9PdAjTaD2Tcs3i8A?=
 =?us-ascii?Q?8g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: BoKh1CqHVGvN+9oE9BGiMNZi4Yc9IZTZmlMkMZPVIQwqo56FmWu3ShUYlTkk6dRfMJd7NLxLiCdKVbPin2b9EmV0Y9c0EqE9IaNpC1h+YRm9NJ9opv4DimguNXtXRKCNfWWTY7fICmkeEV/6sG7eJ83BsIi7n8m8HgmvFMVS0FTbW/ymK3c1IQ2rKaxFtJFBWzbAhvNiIg5+cPCJ0WeDS9SGThpBuoK5XJSzqfHte2h8iChmDwzbv/msNBCCKYHfnA0rbiV6ZDgMhaBbIRFj7xVLhfFjq6vlX01hvhxxzQNsdrfuxqhNNEEDz1Us2lxs0i0UtrsZN5i3Cpg2/ILQ6+xRkA/j9jkGtegk47KGmNZYq5jzykkBhS8hkP2vyP41E9/uqvE4YWifA+voALXOmjwor1Or8v9kxOoCFOFwKSnkncBip0hX/5YMkIylY0pYuXAdM3xfy6RMhbsFzpOfFwqi6Yd8/bG/AdF58l8iF4Ch26eY0fsTYFBjc5WIY0ue2pq9xxMMGmihRS+jD0Qm4zm03647tiYVakohQNglRumRVzv8sZQZJ6Unp6RmqUwqOfZIl1fzavXFiUbtpRMknunvh4ZUqr1SsQ+ybJQBZag9jvzYuk5qvXacsNgj2tBhb3qSfo978WkfKUJkwbAbaOHMsxk6GdqTNFA7nrSimyQnli1GNNCh8HuFGJg93weNpml+4FRDTrk+BiWs+t2ktQQRDg5aR/t30xHGI3BkdsShIxrisiIMRnIWWM70zpx/
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d404c98-0d8a-4b26-af87-08db1a8be06d
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 19:33:47.2993 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D3Bu+udBkJKRgOfBjXaUbaGsaEiqI67yD7H0KNZShlNkwI0wTroZVkiZUkPYJaWEmMsRtn4djRwLvQJ/JF4J/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6619
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-01_15,2023-03-01_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 bulkscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303010156
X-Proofpoint-GUID: aYX-RV1-1IMqK--Bc9IVKXtx5G14WK7-
X-Proofpoint-ORIG-GUID: aYX-RV1-1IMqK--Bc9IVKXtx5G14WK7-
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] mprotect: Add mprotect05 testcase
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
 .../kernel/syscalls/mprotect/mprotect05.c     | 69 +++++++++++++++++++
 1 file changed, 69 insertions(+)
 create mode 100644 testcases/kernel/syscalls/mprotect/mprotect05.c

diff --git a/testcases/kernel/syscalls/mprotect/mprotect05.c b/testcases/kernel/syscalls/mprotect/mprotect05.c
new file mode 100644
index 000000000..974e026ae
--- /dev/null
+++ b/testcases/kernel/syscalls/mprotect/mprotect05.c
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2023 Oracle and/or its affiliates. All Rights Reserved.
+ * Author: Liam R. Howlett <liam.howlett@oracle.com>
+ */
+
+/*\
+ * [Description]
+ *
+ *	Testcase to check the mprotect(2) system call split and merge
+ *
+ * Reference links:
+ *  - https://bugzilla.kernel.org/show_bug.cgi?id=217061
+ *
+ */
+
+#include <errno.h>
+#include <stdio.h>
+
+#include "tst_test.h"
+
+#define TEST_FILE "mprotect05-testfile"
+
+static int fd;
+static char *addr = MAP_FAILED;
+static unsigned long pagesize;
+static unsigned long fullsize;
+
+static void setup(void)
+{
+	pagesize = getpagesize();
+	fullsize = 5 * pagesize;
+}
+
+static void run(void)
+{
+	fd = SAFE_OPEN(TEST_FILE, O_RDWR | O_CREAT, 0777);
+	addr = SAFE_MMAP(0, fullsize, PROT_READ, MAP_SHARED, fd, 0);
+
+	if (mprotect(addr + pagesize, pagesize, PROT_EXEC))
+		tst_res(TFAIL | TERRNO, "mprotect failed to exec");
+
+	if (mprotect(addr + 3 * pagesize, pagesize, PROT_WRITE))
+		tst_res(TFAIL | TERRNO, "mprotect failed to write");
+
+	if (mprotect(addr + pagesize, pagesize * 4, PROT_READ))
+		tst_res(TFAIL | TERRNO, "mprotect failed to read");
+
+	SAFE_MUNMAP(addr, fullsize);
+	SAFE_CLOSE(fd);
+	addr = MAP_FAILED;
+	SAFE_UNLINK(TEST_FILE);
+	tst_res(TPASS, "test successfull");
+}
+
+static void cleanup(void)
+{
+	if (addr != MAP_FAILED) {
+		SAFE_MUNMAP(addr, fullsize);
+		SAFE_CLOSE(fd);
+	}
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_tmpdir  = 1,
+};
-- 
2.39.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
