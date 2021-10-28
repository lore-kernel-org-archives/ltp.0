Return-Path: <SRS0=5Ww9=PQ=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A4D8C433EF
	for <ltp@archiver.kernel.org>; Thu, 28 Oct 2021 08:56:55 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C79B60230
	for <ltp@archiver.kernel.org>; Thu, 28 Oct 2021 08:56:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2C79B60230
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A75E83C6B1C
	for <ltp@archiver.kernel.org>; Thu, 28 Oct 2021 10:56:51 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 17F8C3C644A
 for <ltp@lists.linux.it>; Thu, 28 Oct 2021 10:56:40 +0200 (CEST)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A7EF71003A84
 for <ltp@lists.linux.it>; Thu, 28 Oct 2021 10:56:38 +0200 (CEST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19S7M6Df023387
 for <ltp@lists.linux.it>; Thu, 28 Oct 2021 08:56:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=j4uCuQhENa6IIJUMWmQYhOjagX67ISMDRKfrpHd9jZk=;
 b=Xg9dz1slrkYDppQAq5gSwyTeCFXSt+NTvPxjw3j7FFzbsHdeYv/S4ALvUgyWUEGjO/yD
 sbTQjMuJCwdiMopJuMBKBcIQvfIPeEM4p5cnjUQaExJwPHqOdhOdRsXpIH/Fu6UiutbP
 68EwgNJ1RoNYg/wRNdRnVPUCCCrYu0HCkXfVp/f6I1yEFiT7RJUTqznDbu4wz7GK8ALR
 pdvE5niACvd1wPUtVb4fHnZBEyQaDI6jdk5lQBSMpWAVou/1CIqQP9gvdeprjWb9vPTL
 pJL/vpOkzv74hhAUAIQKQnK1jGBuyDxLmR+vSEJxLIRfRJ0fRWi+v1BrswuCP2mPqghU jQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by mx0b-00069f02.pphosted.com with ESMTP id 3byhqr9b52-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <ltp@lists.linux.it>; Thu, 28 Oct 2021 08:56:36 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19S8paux141895
 for <ltp@lists.linux.it>; Thu, 28 Oct 2021 08:56:35 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
 by aserp3020.oracle.com with ESMTP id 3bx4ge04uy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <ltp@lists.linux.it>; Thu, 28 Oct 2021 08:56:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K9PL+XT+IkjvLKgesQ7h9driktmtSxh8Xf+FgVYdRLUJUMaiOkf1sMiBA401VKsRLS7eXrinXDCCeXygE8ysX9UdIKoxSvfV5mDnpGx547WTgqJPY9TQyN7ATJSdFBMxqaCOs0HMNSFVuYGQDk2Z3Jfg27G2B+T5vPYqd19Y/4CIus01n6R/HrVtPUPe1ieHQzyGgiWFn2RS3gFuduji7LhOb6tVSYHHtCmNeKhs7MgegnewpE/BTtgNfbQiJ7nmFSzRzq5nUy+QsPnYHVNc9y5+9YAgG44RdIHbx++gLN6zv5B0U6BihYrJVWTCAG+Szfx4T4/jCHzRlPW8vD2oxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j4uCuQhENa6IIJUMWmQYhOjagX67ISMDRKfrpHd9jZk=;
 b=bHa/viODBrPaO+RY0EXouut/AQaDqIBqlqnMK4c5/3ZwqKIb5jx+iQw9LpIHyS8hEnHZ29nn17WWeGwsmQBEDms3PIA1vYRuyj2Nvxfs1UF79EaWX2/XuSPCysxj2rSr+QDiGb2OIt44ng7OVgmO2gGqZ5OISIrJgFIw69VzK38qWC5WTXu/rI9QhBj2QtZuQowygE3yK5E3jmZy2xJV63lscW0/SU8Vu76BBZrnxj5BvsAr9/WA7nQPbH+puV+Aa5lRq9ECXLepo27t5a9sfTvfDIgjlSsk28nJGQbQjDbBSvzogvBKjCI6mq00QV0l8V67Lx7CaxVg3K8fzOHIDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j4uCuQhENa6IIJUMWmQYhOjagX67ISMDRKfrpHd9jZk=;
 b=yaHaZaV8G63t/9FV/IFVgQ7w5akkRKEJamdmOwm80Ouv/0JlgSrkQS7l8OJynBwFgUQ0URBb2dnDnMGGIb4eSfTruE6FxACO4JCMncbSxM+bQfqwPNXb9+CrSry1gCrVtGvKwAERPrS5i6KjtjpF58MHJncn3sgqq+cnQsR4AUM=
Authentication-Results: lists.linux.it; dkim=none (message not signed)
 header.d=none;lists.linux.it; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4017.namprd10.prod.outlook.com (2603:10b6:a03:1ff::20)
 by BYAPR10MB2630.namprd10.prod.outlook.com (2603:10b6:a02:b1::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Thu, 28 Oct
 2021 08:56:33 +0000
Received: from BY5PR10MB4017.namprd10.prod.outlook.com
 ([fe80::15e9:dafb:489a:b0d5]) by BY5PR10MB4017.namprd10.prod.outlook.com
 ([fe80::15e9:dafb:489a:b0d5%6]) with mapi id 15.20.4628.020; Thu, 28 Oct 2021
 08:56:33 +0000
From: Egor Petrov <egor.petrov@oracle.com>
To: ltp@lists.linux.it
Date: Thu, 28 Oct 2021 11:56:20 +0300
Message-Id: <20211028085620.2499-1-egor.petrov@oracle.com>
X-Mailer: git-send-email 2.32.0.windows.2
X-ClientProxiedBy: LO4P123CA0093.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:191::8) To BY5PR10MB4017.namprd10.prod.outlook.com
 (2603:10b6:a03:1ff::20)
MIME-Version: 1.0
Received: from EPETROV-7310.ru.oracle.com (138.3.203.41) by
 LO4P123CA0093.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:191::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4649.15 via Frontend Transport; Thu, 28 Oct 2021 08:56:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ae3af39-581d-4232-5697-08d999f0d74a
X-MS-TrafficTypeDiagnostic: BYAPR10MB2630:
X-Microsoft-Antispam-PRVS: <BYAPR10MB263023164737D1B1E728D47598869@BYAPR10MB2630.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kZW9wKYIgu+ccKgZSFZEckyrW+Q1bTnVwXUf95+9z+v0QAtEIcxKcbj33xz66mZ4O8lsYjQz5IfCovQ/TbDAWZyS8mZeLYmRhpbpixGro/ZiqmK+G44c37kBxvMf/wb/52UbO3ugRNoo6to1iB7GwMS8Spp9XL1z2VhSo/YMdErnPYA0ItJHiSLqGpBpihJovnG5Zx9KhR1Rzr4049GfqCIH/3BPBaHNQto6BXuyJ6UUsUaNiE2CXIXhePCDCXg6/BrWrlii8WYCjOf9BZDr5QAfwYpBFrfYXAhX2pi1hUCcnSncW10uhkqMt9uOa11m+sM2t2FynfyUKgY3iHUAK6iS16lHjgNKtFqO3i/HsSEi8NzYN+tNDe+qknYSMB+jG8uNWSkAay0I3HAfFdWdDOKN05sHm8WRVERIyl4gLlEFcg43v2B81hyCgM2/aS1gtKhgkjGCYPSXwQCdJLTcdEaKYOwGRiYb3Y84SbMa/8nr7dK47ZsJP+/GBk8n2GxxMqMyDgcxO8BJsW1MbO4r10PatCAuOwKdR7Z2hoEFnC9mll+zbjDcso6m5JjlgbIIFCUJsitQWPkYU2OUCByL34ItJSQ79x61+S7mA0oEKS8lgKjDIo/aF+0h/GgC1RKs2q8RT19i6T4geacltXSRcXNyXlEzmsKwdEZSS6vG+3s65+x9B8f+f+lG+zhfLUxtA9MATKKA8eNy66ooHC6d5Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR10MB4017.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(52116002)(6486002)(2616005)(956004)(36756003)(26005)(4326008)(66946007)(7696005)(6666004)(508600001)(8676002)(8936002)(44832011)(86362001)(107886003)(83380400001)(2906002)(186003)(6916009)(1076003)(66476007)(15650500001)(316002)(5660300002)(38350700002)(38100700002)(4744005)(66556008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gl2AcR/xwDIRbGgo1ShvyCHXtNZCymvIjWvPsjqY3h0jYB0aLxkEzs/ASSCq?=
 =?us-ascii?Q?VHe4HgInuhBghzU1srClX1XaisVr5+oCsBvI1H+4F/mrVM2rLYF0aU76gdTb?=
 =?us-ascii?Q?MEhnFXkqCTCZEbgN1Ce4FIo5rUxCHWgKeABCNA0Dxh+LySQz2mwbwQSs/Ffx?=
 =?us-ascii?Q?vB7+BdjYNTokZdUn6du+s5HHTr5T1Mc+prA9YYtS8mDpfi1MAAfi6BD4rlZF?=
 =?us-ascii?Q?8U4FuriL2TM17TW52WPO+2cqhAW45tWq/b79UPNHLKskGKk9yltJo++CrOER?=
 =?us-ascii?Q?ew3mMi9Dc9hWjrdzwWzuvu6Sz86kx6X+Mtd7SPCyC3fSOMQRjl8cnDYmRGj8?=
 =?us-ascii?Q?NRPAp+QigmHzfQSX+xVAU7Wbx4RsC0OQnr86aYsNxgykqHRdidVefsRdXr2Y?=
 =?us-ascii?Q?afwtn4v0OcnsrTrWKC8R1YK291MDeW2O1WviiImBxbaKufJsppg8tRZC8KvF?=
 =?us-ascii?Q?6TQ9sD/JPfjq+i9CG56KEHjvaMt5HExF4oyPg+5cBA1WcDSWcGHAejR3fH43?=
 =?us-ascii?Q?dEnGnNqp8BAmAKBYcb/14KTGP2E8FqQwR3bbd8lCZfKRYBC5Z3VhIoWrwga0?=
 =?us-ascii?Q?Ftia82rOs2ijfGhCIe5JQFnY2D5+dvvjKFvPREP2PdoxDqNKkDyMpQKw91hV?=
 =?us-ascii?Q?UgW0tm3Yc1QYfycbSVFI7fp+P/IXGEvmeA7FSdFc/hSMLXeBSPXTRT7yDbH4?=
 =?us-ascii?Q?+qSc2KzkgpFobt59JYVAKaLXl/u8/90V7jsjtyPTetlVPfyfJPl/lpq01Nws?=
 =?us-ascii?Q?TLjtZ+hw5AUEgHb6unKkETaxC/r8nv5jOwK8bhKEmIPlgg4hUid/w64yVRp4?=
 =?us-ascii?Q?jd14b10CbDMsT3m38p4QOq4/A0ytpx817rc6Vs8epUxGIHCmBzVLAwDGLvln?=
 =?us-ascii?Q?miRVAM4Ope1QlW4VTjH/R1Ix41PAjmVYt3y3W5SljSEc4XvdNa0mep4uhE+f?=
 =?us-ascii?Q?lJEi8fmOYlbDS9mwnL05mm5FliqpPQ4JxZGkd+jq/QddwB0HR0hFW1HCtA/5?=
 =?us-ascii?Q?dGjTHr8iMnCyiSMNEd6ybPVcNjVUlUCvWuRemCKuHyhHX7RboB+jEN1sJprG?=
 =?us-ascii?Q?Ps85SGV3gR134C6nWPsplTa3v274u/8oni0JdHyPW/HmWfFOnXdr6j0bxZ0q?=
 =?us-ascii?Q?3zY6mcDeLu3ouq2RP7zkBZOeh0brAGBzdmML5QrrWrdKVRStzMrEomdzdmLh?=
 =?us-ascii?Q?l7Er/a9cm8IT/fyb1QymoAFLtH4cEXc5QtrR3cMeWdNxFBV7VkvbXswnqyeI?=
 =?us-ascii?Q?h0gW+iEKvZAHY6gXrA3S3le1BCSxRqXMQufVDQi4dGQrXFyTGwdvRg9JR9Hy?=
 =?us-ascii?Q?A5v3OtZY4PSRkw4BMeDwcgmQJI5ibRu9Dp/D7XWF0UCDNRoVgwMbjfxY2yPR?=
 =?us-ascii?Q?NHp4OUCXSvAtR+JhX4PuEL9JDKsHpytL9Mjdy9sHerKr/W8z//DOlaRWFynL?=
 =?us-ascii?Q?JpFdayypNY699f/KRq6HtA9XPZc4JymJpqhrk05mxVba+36q6qtjX83YutKc?=
 =?us-ascii?Q?+RdPLEIj56aNPZZycEAoQOlRqncX4H+z7zWfaRBW4d133Ky4b/Z4q2SokLQb?=
 =?us-ascii?Q?0LR9pdt1ZlBM4KICeRF/3PLc2MCXuG+IsCNGsodA3+DMqwU+uUhxJsArGD2Q?=
 =?us-ascii?Q?09YhOcneCyEX0lsOPL0n+0k=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ae3af39-581d-4232-5697-08d999f0d74a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4017.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2021 08:56:33.5218 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: awg5HDS8Rxx9P130Wo7+7gMRiD/7lweMVR/fReYhQi5YXWx0SmEuUoo5UY9zrYtu57KY20GIu12i3qsjAJGiPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2630
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10150
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxlogscore=999
 bulkscore=0 phishscore=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2110280046
X-Proofpoint-GUID: ZdiqvphTKTPknwM8IBUBqJZFGGOLaKEX
X-Proofpoint-ORIG-GUID: ZdiqvphTKTPknwM8IBUBqJZFGGOLaKEX
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] lib/tst_kvercmp.c: Update tst_parse_kver() condition
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
Cc: egor.petrov@oracle.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

tst_parse_kver() fails with kernel names like current
mainline kernel "5.15-rc7". Updated condition to fit
this template.

Signed-off-by: Egor Petrov <egor.petrov@oracle.com>
---
 lib/tst_kvercmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/tst_kvercmp.c b/lib/tst_kvercmp.c
index 8bf65d309..dc0daa746 100644
--- a/lib/tst_kvercmp.c
+++ b/lib/tst_kvercmp.c
@@ -65,7 +65,7 @@ int tst_parse_kver(const char *str_kver, int *v1, int *v2, int *v3)
 	/*
 	 * Check for a short version e.g '2.4'
 	 */
-	if (*str == ' ' || *str == '\0')
+	if (*str == ' ' || *str == '\0' || *str == '-')
 		return 0;
 
 	if (*(str++) != '.')
-- 
2.32.0.windows.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
