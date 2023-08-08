Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 681F0C001DB
	for <ltp@archiver.kernel.org>; Tue,  8 Aug 2023 06:21:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 552D73CD4FC
	for <ltp@archiver.kernel.org>; Tue,  8 Aug 2023 08:21:04 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 364793C9984
 for <ltp@lists.linux.it>; Tue,  8 Aug 2023 08:20:51 +0200 (CEST)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com
 [205.220.178.238])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id CB974200A16
 for <ltp@lists.linux.it>; Tue,  8 Aug 2023 08:20:48 +0200 (CEST)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
 by mx0a-0064b401.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 3785dDZT026819 for <ltp@lists.linux.it>; Tue, 8 Aug 2023 06:20:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
 h=from:to:cc:subject:date:message-id:content-transfer-encoding
 :content-type:mime-version; s=PPS06212021; bh=lBUPZ0QLZ4dU/OSWuT
 IkDoiMIe5b7hIcZEu6WwF5a7M=; b=Ve9BBPsT/RbGjnCCOaD/fE7L0d7NzwA08E
 xCzKnsHgAumGp4Nu6R73Vyjv0jXnnRXsJNsXbuewSqlZwhAA4IFgLrNAmngqbTRr
 +QXmSJxbrHC6CvllCx1SGHLDWu/YxVrQvKJl6iAQfmPfvIfGEZyEnIDTu0PRH2iE
 ikvEAhP48a+EScpeYkNl5Mr9cMHOdgZoKIZIpmokIqjtbQNUmGTLgbJhEn0ah2W7
 qxuFrj5QgjsmnncbOtIM3TrRqOkaWpPsC68VV97A7UZpSuU3I6bE/+rzyU3Aiovl
 3uytlF8T9BkNqhYvdmxJYPzFOEFhA4FZX91MHZksb85V+BUKSgyw==
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
 by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3s9bmx2bw1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Tue, 08 Aug 2023 06:20:47 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nin4Gj48sR0dhxhPI6L4W6RHAUK9MHbTrQHrKrL8P8JJqKuFk1tH3EB3z6AaB7EitP8/QuV90brhYZ/wyTog0V25zwJw3ENOZ0cHAcLUXwWxED92a1qmnCOzzCA4iG+llbq26R0Vqpqh7iYNV2dvV8nI4kTLgmLlhj6+IBcvabP2rC5WHv/PmfP6eBy+emMdoggcFq15cMfFKLdwL4OWf6/7p0+CIW+uwP0Y2+ynpCFRrz+NxFNRSnLVk9UP9uaRTFWrlTp1Zixu7NFu0ElUsj7vVeWTMp8CH1ewoFcURC9m2DvlMVZxsgE+agbItKjxOWPveWs43WaZf6cperIFDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lBUPZ0QLZ4dU/OSWuTIkDoiMIe5b7hIcZEu6WwF5a7M=;
 b=nD68ONwxmEhXEX/r7AZYaY/tL5+zwz4ArUH/pzcn8W3j6dhMfuNr+b5h2flac6G5HSAS8BrtsexcjcmBl7q0q1FgNEi0Csp2dF8rpWCZWn9AdrcEUWcQUblFg62z+TqKB2zTuIrMtwHyt44irFspF1hMx7rg+/BhS3DjRis38cmrPBKeGVkQ2qwtjgN2IG83BpDVwib1SBraQ5Gw4K9Zuplm4dvUj4OctjxRYVXUZkQMjNUyylstEWEk5EIc0rYzrAxGtyQ/mBmBqG1I3dfMk+zlgCVkknJuL6mOnHxBPC0myoaVi+3U3ddMv/lQf7nBWQ3K6lApuCJLMoOVyjQzkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO1PR11MB4979.namprd11.prod.outlook.com (2603:10b6:303:99::16)
 by CO1PR11MB4948.namprd11.prod.outlook.com (2603:10b6:303:9b::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 06:20:45 +0000
Received: from CO1PR11MB4979.namprd11.prod.outlook.com
 ([fe80::575b:1409:b37d:d186]) by CO1PR11MB4979.namprd11.prod.outlook.com
 ([fe80::575b:1409:b37d:d186%4]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 06:20:45 +0000
To: ltp@lists.linux.it
Date: Tue,  8 Aug 2023 14:20:25 +0800
Message-Id: <20230808062025.2991984-1-Xin.Wang@windriver.com>
X-Mailer: git-send-email 2.34.1
X-ClientProxiedBy: SG2PR04CA0190.apcprd04.prod.outlook.com
 (2603:1096:4:14::28) To CO1PR11MB4979.namprd11.prod.outlook.com
 (2603:10b6:303:99::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4979:EE_|CO1PR11MB4948:EE_
X-MS-Office365-Filtering-Correlation-Id: a9a53475-70bb-49e0-879b-08db97d79976
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: idwd+z/tlNJtunjLX10FS4Vh7JA0LPpvDM5ADjMGTYq2hshrcMktuFzk+QtkIuxRESftxXj0M7SbCoCOYR/qSGUWKQgfo0IDUcle4N8O1cIe79u2rOaZgCpyTdIoUTeOj8FBGCr2h21fMSE2RhTmuN5o75Utsn33TRJMS+N+COLN5gFPEZor5L89qFeuuC+ptsnqav0Yl5o8MkVc4uausLxOd3Q1X/DCEVnpM8FBJQtHDaBVDtByE9qDUJ6piVegjL5l9D+NZfRXrKhJkgyxqX+FucF1E3vrfnd8sJGR13s+p7dWW8CllNaiIGP6b4Pc8zSRkP8M9J2f2yd1nM+H8+dyMhN39yUOX7zkujBwbX6Wyzy8duMOjrQMbO94NsS2ooSN6sTU9F+9C4gsWAuwWXDOaToJxo+SvahVq0OR+T/lljSwGy8VklUJY5pzJjfUQJAMlXYRl3XSbtUWqztE+hmQHeQqipHI4Xs8d4VHuOIwAlb5eOSeXdtcWIJeBe338o+Iy5xaa6MPDLRrBcGfk+ZUoDpy+zoDF51Sfc+0nFbjp4i/KAk8M2vilPU+pqs2BT5hLs+m+wgV7LyjZkLyMvZGadSX499gFFXhc4zuQGvG7+BR3o2UE2toYOvRKtpwGw4Y2uTpKXXyi8Gz0UW2+GrvZUkhOEoYasSjxBQQGFBbBRhp129Kqv8CVeZRjFwQ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4979.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(136003)(39850400004)(396003)(366004)(90021799007)(1800799003)(186006)(451199021)(90011799007)(1076003)(41300700001)(26005)(107886003)(2906002)(5660300002)(83380400001)(8676002)(8936002)(2616005)(478600001)(6916009)(86362001)(316002)(38350700002)(38100700002)(6486002)(6506007)(66476007)(66556008)(52116002)(6666004)(66946007)(6512007)(4326008)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?54+QRL8QEhPcz5Gy8FVr0ot+1ikSdad+a7C/lVSKyY2rgQi5+CQZLR8XGPJT?=
 =?us-ascii?Q?mlqH1N9fW87AWH91PTZeSByImi72jwXxVTJ41ipnkkO0mrcyjQ90spEDm5ZD?=
 =?us-ascii?Q?/13P6Y84x5EKb1/Dzt5Wj/eTMK1MsKanz0yCq1CuCT51alQ7bVMtRow34urc?=
 =?us-ascii?Q?49drcsbIltmFAWX+YcmFCEpPSJGrqkmDpGlx5OYx1SLMAHcj9R+0QzkD9rQO?=
 =?us-ascii?Q?JIAberfsl7Ft7KG5ixWy6fIJArBcn6izYliuOjTWGimGnTwQ+jy2KfpDORbT?=
 =?us-ascii?Q?VYBjjQmfahra5xq495uEqNTYVgRh4bQU7gYkTMN15z+aa10dpRYcxKB+K0H2?=
 =?us-ascii?Q?HZ41ObftjKmIIHE4cucjw8MHgyri3CmsXvCmHMYqshpkP1z0cOhMfePpT/F5?=
 =?us-ascii?Q?DbYLTLr+L6V8CzzjN55IwyO7RL4P9wT7R5uN5xNPsr8zef/jVcWcFZMxv/bH?=
 =?us-ascii?Q?US/6+gwDwZceTVUZzswbC6qdCvKDI0jFhbyJVBRE+IYQK7a9ul9FQG3+nxEQ?=
 =?us-ascii?Q?9Lnk7cw4E2RjaYBGkezqaxVXX4pI+iywuVJMo9qUPb8mXjrH+tdq3Iv8tBi7?=
 =?us-ascii?Q?VDMksJqWhW1wkMBFxMKCbHRaxoP8tfaDIlxsl5f9EMdwaeHwZlFA+ABlJna1?=
 =?us-ascii?Q?/N0jzd/3OtCk6Y+IrnUv66KBw0FavGPDlHIrKU0QI5AzjGG3OUsf9Kj4Fwiz?=
 =?us-ascii?Q?dLgEz2Nvqq1DAYejrv7Hw3U/HufzopjpuJXESuHxpKEp+t/4Egd6NLZHJ7Qg?=
 =?us-ascii?Q?Hm9s6C8CgNchlcPAa/unxIdov1ZCIgRaRGrOP0Xz1D4jjlo6G5QJoLYh1dVC?=
 =?us-ascii?Q?w4x/DKyu4+ARmR0Q6lGDRNU9FMQOumoUWmp5hChYhY1J1UwOfb6pRCtW5Iwb?=
 =?us-ascii?Q?T3VvJEZImyGh63lPUWypXCPSCBhakPG1A19mDWvEohQqQAiKQTtuqMfVo6XE?=
 =?us-ascii?Q?6OChOLx1yhmrWbRm8Jw04Mx+CDnfvI2/6dup9REC2O1hrrWV4bgVolFK/ii5?=
 =?us-ascii?Q?J6ttiWO/EF3ivPVKQgmGpjdeKcgtj+JCfS7v/flCNg817C5v+oWJ5t97OZog?=
 =?us-ascii?Q?UXisgFNlsRvhxsIbb15wIOF1bsQ6R7flbIkPfIsgGuCiDzo9SuSuBc6lOb7A?=
 =?us-ascii?Q?VGQKvvdb4Gm/T0Rilx8PdHHPK7j7WT19NvYqCY+bavhtesJObPv5hn/unDRQ?=
 =?us-ascii?Q?CTQFSZrRVRymbm/bKdLTm4t5VX+mIiLoR1m1ut7D+c9fKW0HHWnZ0m+MV5U9?=
 =?us-ascii?Q?uxkgJQT+Udj8/HLWWnudO0AcMJ5QmezQ6owMJlWJfuZOG2GY4wHv1wR6f6xp?=
 =?us-ascii?Q?1LqjF+r8QuJU0/Fur3ufwF4a+yFMXWZr1clrznPWJym2y4g1rse5RHqWn5/Z?=
 =?us-ascii?Q?ZcgKJ4Y8m9BmaSYv8gM1+pp72iCJMi1ErElv1WBoN/oDOWHOyExH3btkFUEw?=
 =?us-ascii?Q?pNtmArVrOu9lmGlk8Zzmkar69uuUa9iMKEFQac5XEAE9hJFEyG6IJILRqOsA?=
 =?us-ascii?Q?XZkIaeVc+jmeuP3r0Lst+RBNEMXaYA4TxPwWtIzx9cHWZYv/tQdw7nEoyBhP?=
 =?us-ascii?Q?kSSKmO5y5S3Mi9Fu3OCt3hDG3vZY5cdOac45gYLe?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9a53475-70bb-49e0-879b-08db97d79976
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4979.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 06:20:45.3311 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EAvtCzNZ9m+AZYt5/86yBQe48a/ZNpLYQfnrqDux7nAMyYVltUPa/5Fzhx3j4E5QbmTpHJl6IYcaRMiIDPRLtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4948
X-Proofpoint-ORIG-GUID: pSCoBbqFD6Q3Zml1TVzTJWHuuV_Vr9So
X-Proofpoint-GUID: pSCoBbqFD6Q3Zml1TVzTJWHuuV_Vr9So
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-08_04,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011
 lowpriorityscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 bulkscore=0 mlxscore=0 malwarescore=0 mlxlogscore=878
 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2306200000 definitions=main-2308080056
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] fs/fsx-linux/fsx-linux.c: Add measurement of
 execution time
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
From: Xin Wang via ltp <ltp@lists.linux.it>
Reply-To: Xin Wang <Xin.Wang@windriver.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

fsx-linux.c is usually used for file system regression testing and total execution time also more and more receives attention.
Add measurement of execution time in fsx-linux.c:
[fsx-linux]$ PATH=$PATH:$PWD ./fsx-linux -N 20000 /tmp/test/test.ini

All operations completed A-OK!
Elapsed Test Time 0.388891

Signed-off-by: Xin.Wang@windriver.com
---
 testcases/kernel/fs/fsx-linux/fsx-linux.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/fs/fsx-linux/fsx-linux.c b/testcases/kernel/fs/fsx-linux/fsx-linux.c
index 64c27a0f5..71b719782 100644
--- a/testcases/kernel/fs/fsx-linux/fsx-linux.c
+++ b/testcases/kernel/fs/fsx-linux/fsx-linux.c
@@ -1115,7 +1115,8 @@ int main(int argc, char **argv)
 	int i, style, ch;
 	char *endp;
 	int dirpath = 0;
-
+	struct timeval time_start, time_end, time_diff;
+	
 	goodfile[0] = 0;
 	logfile[0] = 0;
 
@@ -1336,12 +1337,24 @@ int main(int argc, char **argv)
 	} else
 		check_trunc_hack();
 
+	gettimeofday(&time_start, NULL);
 	while (numops == -1 || numops--)
 		test();
 
 	close_test_files();
+	gettimeofday(&time_end, NULL);
+
 	prt("All operations completed A-OK!\n");
 
+	time_diff.tv_sec = time_end.tv_sec - time_start.tv_sec;
+	time_diff.tv_usec = time_end.tv_usec - time_start.tv_usec;
+	if (time_diff.tv_usec < 0) {
+		time_diff.tv_usec += 1000000;
+		time_diff.tv_sec -= 1; 
+	}
+	prt("Elapsed Test Time %lu.%06lu\n",
+        (unsigned long)time_diff.tv_sec, time_diff.tv_usec);
+	
 	if (tf_buf)
 		free(tf_buf);
 
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
