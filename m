Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05723E7717D
	for <ltp@archiver.kernel.org>; Wed, 11 Dec 2024 09:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1733909399; h=date : to :
 message-id : references : in-reply-to : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=PNvO8nDiCFY7eYXOvwJIrH7uBeKaVv4v0uoDxPyGe9A=;
 b=MTqRTVZJuLRfPJJeVSDvJNuxkwoMla0Rr2UtqcUB6rVD0StP4UfjDkhFoQMp2E5WO3Gn1
 2zWf4yH8EycC+wr/UB+h6Eyhl0RyQluYxV5jywThKCkDwRJwPD4BrJM2qG8a9a9p1pRl2+Q
 bZ4uUxx95Ns94/RBXzJBShu/GIVmXTg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1025D3E7CDE
	for <ltp@archiver.kernel.org>; Wed, 11 Dec 2024 10:29:59 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 073DE3E13E2
 for <ltp@lists.linux.it>; Wed, 11 Dec 2024 10:29:38 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=oracle.com (client-ip=205.220.165.32;
 helo=mx0a-00069f02.pphosted.com; envelope-from=lorenzo.stoakes@oracle.com;
 receiver=lists.linux.it)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id F12071000744
 for <ltp@lists.linux.it>; Wed, 11 Dec 2024 10:29:36 +0100 (CET)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BB8ROSI017117;
 Wed, 11 Dec 2024 09:29:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=corp-2023-11-20; bh=nCnfZhL0tO4SpHgBe3
 wXOZ3TWyNpTlTCBE4ctG6zIBw=; b=LkI3GT48HyNfAdnXG6L0+rFC5yOOy1/C5/
 sjkpWCcQKEDPKSN/t+50zWvi7CEuh0lCr4hyTMdpIObjHuW+hiQc37JiUdJfO+GG
 6HUJPkhJFEARE+mGyMoOAUbXqpt01a8A4J3/0Uiu8PeHUiKDQ/QXRwpPOJ6ZCclN
 yTb/XjMI9eAsQuXCyP6fg8kM+/6MYhwgGmJKpcRncCG3M3cZBBwDtsIkBz3n/k+2
 eWNyPbAndCHGMkGbEsSFJO/fs9MAXLY4AXWJcQ4svVHozH1gJqlNAdgEm75Da890
 tQQUNOjHewiD2YjUNobq00BkVvDhhSw4x/UxFKSWnKttofeeg+Jg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43ce897yvm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 11 Dec 2024 09:29:34 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4BB7MHDw008616; Wed, 11 Dec 2024 09:29:33 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 43cct9gmrk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 11 Dec 2024 09:29:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h/lHD65VT32uq5LskT3hz4ek3hzBrqxCqafAJaIgPYjstc/yWdoXrW8e4WkWSUoxVjSG2pP2FjjDGJJ4j4mioVbBZR65XRLnQSJUhDF+WVGXwGrzfgKS9xiGGh2ugB+YDeJaLV3iQluvnN+k2fXVF5x5gvLm+HNyZ7d78DvTQesaAg4TGMnZWr21UBmZ16+d7I8B4hGMJPsx7uTFa2+2x8wfjbZRIo7UkePa7yQqmZ3pCgJHlZHCoNHhPSaTAMVZG213tkXEC0YoGEEtgVhVbbZZ5vZ14TO8lM26bufKawqevfW8CmsVrUD/nJ1r1bjoFEF+wqQB8v/L4PZjK/FK3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nCnfZhL0tO4SpHgBe3wXOZ3TWyNpTlTCBE4ctG6zIBw=;
 b=HlYbiqrj90ORDrIMOpHG/pUIIpDQ2XOrS2eFCIQh3Fbu/5J2n1j+6h1vs3GOPMRPNZyUXxeQY+lOBikWCf9Wm8x42Ig7FsFol8KF0nQroVzrNhSntggRjEB0K53ZS9+9aWOEa6Dbk/gDKZdHzuUF43ThZCVg95mX0T25IF8qO9+QVSAOSmiEtJ4+cmeZ3gHqz6mCF4u2mpdVrjyb2CXFnjnHHCDWSkk1PPBvhucG9RQ5ZdO91RSljndU28jOW/DU+WUmtXUS6kV1f15TD7HiwM8EVHrZVOU6Y41PzS1df+s0zNWzm+gV2gMrj9xImj/drLe2b7vVvJxkOYMuosWzrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nCnfZhL0tO4SpHgBe3wXOZ3TWyNpTlTCBE4ctG6zIBw=;
 b=KiSKf/5hTpvqpgrAoMHvdeIhOge8+7akoCtCDDcBorVeDAeQoYazg7wahlR736nN6RrBpVQhi/4NCtVcFCsAquwcliqLoWvyNom765sbPbHkzwNUn5XdPbVL7gjJ9wbpgq5baUILg8BxLKxdOk2KfJxns3jQ44VM2va8/UnmZZI=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by BN0PR10MB4871.namprd10.prod.outlook.com (2603:10b6:408:128::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Wed, 11 Dec
 2024 09:29:25 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8251.008; Wed, 11 Dec 2024
 09:29:25 +0000
Date: Wed, 11 Dec 2024 09:29:22 +0000
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <76fb3af9-0a29-4b3b-9c1f-d66bedabbd73@lucifer.local>
References: <20241203-madvise_guard_install-v1-0-c0485abbfc73@suse.com>
 <20241203-madvise_guard_install-v1-2-c0485abbfc73@suse.com>
 <20241211003048.GG386508@pevik>
Content-Disposition: inline
In-Reply-To: <20241211003048.GG386508@pevik>
X-ClientProxiedBy: LO2P265CA0471.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a2::27) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|BN0PR10MB4871:EE_
X-MS-Office365-Filtering-Correlation-Id: fe33caae-3188-4288-4f99-08dd19c64db4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4rTVSuUFNG5V/PtRvc4ByjHI33/8KKDMmYqbi8qZm22qsCrSsRs0Ttf923HD?=
 =?us-ascii?Q?W8V9TcZws7/dNTfUs8NfqOJNzY2+3wJUgHkVu2RXaTOss5eMqax5mpVlY0KX?=
 =?us-ascii?Q?4BPgKEbmf/PzII2Wi/Ib2QiaRZX8ePgD00JcLgeZV7Ec3TmfMzs2CmE5QHP5?=
 =?us-ascii?Q?CjiZUg/jVyfvRCkKXQcjiLnNLRcrWjShoi601eqFlfHszFsywip8rLtbiu0v?=
 =?us-ascii?Q?deSuALnuIp0sIhGjVIwgzeht5LcV2QTaouw37fN/sJNt88djj3mKyEk3IvY6?=
 =?us-ascii?Q?SIEE/5z53sHTszVZWO/iPLCjmNSetzf1X7WuHIWVmwbakmh8UsGkdGXZGYL/?=
 =?us-ascii?Q?7XW/KbIZ/KzVrV9cBXMSHBWu9rhxYkkSySZ/x3GcXB1kwX78oAT1rWH83dWL?=
 =?us-ascii?Q?sbEbNGHmRid4aBfAriF5ap+/WMiDEGIL+KM6ZuNHNjrTrXcMEiFmy3PngfM7?=
 =?us-ascii?Q?8XdAEtNB6VAM8QGPmnb06Shus/DerNZ5gNPKl3zKTH3wK5OguU89lFjP8G6f?=
 =?us-ascii?Q?cGrEer8CBG+03jYfZvT6SQQoWU98m1h1xunDwOAiWo98qUkt172RkUouHIhe?=
 =?us-ascii?Q?G8WZQqKQgw6eswmrQjkSGWHZhdV3HodTmVBAwNYq0kAInLBCic9wGcmk3tB0?=
 =?us-ascii?Q?bXQ7MfqZHuGiqFeqrpj6NPj4GZfn0/UgGNtFb8XH+MmFqVGfyiar4+BOapKm?=
 =?us-ascii?Q?IDntVU3tyQ8y9NvD6gMzX2+CmpnWLPz5YEWMh8jST3FFWYublqYKFwPXUHwH?=
 =?us-ascii?Q?wOL7PoNOmL2rHsEDRdJCWx2yiXDvGWugG7zs5dFGJmnFo97dcPqMtZbiyGXo?=
 =?us-ascii?Q?5P4dTM8+al6TYt8CdnaBS/TPLrYYsrhNIVE+Rg+eaRLO0B22XrxGHTgWP+Ys?=
 =?us-ascii?Q?1kIxJAzDQuZBUyQUDkV7IZdXa3Ou+xc7cL5XfW6dLTYZPNJ158cNdNw60J1k?=
 =?us-ascii?Q?xTbaz3E4MJJxP8WEKWnixQe7FceAcjw574a1Fz1WMv2GPJJvkbnjZU7CEZ5U?=
 =?us-ascii?Q?gxBNBKVRh5uhvXtXE91AA0Wr4E8qoI0OXcnYV0GZwv6Gmbr9PVwDgbEm8KBJ?=
 =?us-ascii?Q?5vZ4PhXZ9Dnxu+gBIiIrjx42apH7zbG0HBNuFRt7qT+5uZP1Gzs4jTeZGByP?=
 =?us-ascii?Q?oTCgZR8cberL1aLINPVply/9KKs+waXNzhMUS1+NubM9WOkLwiLFlZkuiJhW?=
 =?us-ascii?Q?tpAVAgxJ9J2mOfYcczFXWlyTFOCAHft07uzNIyPGmfnwK5PhrWyZWvqUalxp?=
 =?us-ascii?Q?185fAV0BK/R/+bNa/3jkWmjQV0TKpkY/mN4OctLaCNb/3o6XxOpuPgx0fcZL?=
 =?us-ascii?Q?+No=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3366.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AfAP4ZvaSjlqJ8GvoCvoLHRdvcvvhvA1/UIW1OmqFwdhfJf/gCZGnjY36BIV?=
 =?us-ascii?Q?uCfC9H4rpv0cNn2vGm+RPesTEc/tCm/c2ASaDlUYOpWGHzdU5xdWxLK/1ywp?=
 =?us-ascii?Q?KnXHhNU4MlIvRsqclm+WnamOAaaRxEukYTtkgZdaZnqxp/bCrJzWdO7v3uku?=
 =?us-ascii?Q?rw++tr8i2TU5/lvWkAFlyzYTucRaBmIacdnjZrDFXAmuD65Lj7oQFP76uw5Y?=
 =?us-ascii?Q?o8dP4kJBTu//7BZztbYxynaBE0WomFZvX5vz4vBqH3voTHCUt+lHp/O5Kzmm?=
 =?us-ascii?Q?8UZKTKjPPgQTuXslkYb41jciOlUAfcekSctVmjBmZ16czk2J1KX0mA/u+Jxy?=
 =?us-ascii?Q?zvsrhKfWCI2WX/nZ/xSJYyggF9eVlmfFPGGB02txq0jZPGeZc2KzZKcnKm3L?=
 =?us-ascii?Q?P5TNSOs1LjgQdyvRg2gGDXXQkkEYLPDqE4Pf3RhDCfnMIIpkU0ct1ngd2H6w?=
 =?us-ascii?Q?OAN9qWnaoRXc0c9hr3HI95BkDAo1Y7otxqNaqWPwTj+Odzd7MboVZiSbIBIj?=
 =?us-ascii?Q?vGVd82qSDNj0idLK1sdQlhE4x0ns8pff890Y+XWOxF34flhuyRmwpJX69Wt0?=
 =?us-ascii?Q?2NVppoRaryT6xcfi/pasqzqkXD0Wwi9ZoxET5JYkAl57kqmq7CmulyLneuov?=
 =?us-ascii?Q?GmyaDjRbzcKJ65DGQJEHEdRVGlvsfViGL0Fpx6k1uUiOYJZkVW0OU/A4XdbV?=
 =?us-ascii?Q?6yWZAub1xF7z1axBhA5sf/qh4uBF8HU2VlW6NY83X7xOetgkwM1wdwaABrRb?=
 =?us-ascii?Q?OeXDvCflE8sYEtqka4dHku114dt9ye56mTdyOCIA4I25NUKwionF5szPHGkH?=
 =?us-ascii?Q?aqtccfwwXQeWuHY7OcgVizeulxBuqGZ8Kfb6cK5eQdNA8wE2NeWkVu27toO5?=
 =?us-ascii?Q?79WEFcH5LTIjzFxZHDgO/P6/nhleAXwREMgNwuEymtJ+ngUcA7ovgktiwfq7?=
 =?us-ascii?Q?Habcv4nvVDmnD7S9Njo4U/8gbkpudm7xcKxvxt87y3qrm29T9uYlS3xQBBw1?=
 =?us-ascii?Q?Eer94TsXpFUdhMfkB3edwYNcdyO1CKMPe4kRWAuHEBCkRjaO05vcTM1EekXr?=
 =?us-ascii?Q?rcO6akvpRvaRgvgnYCfpmO0Dj63JeD+ihf75pBvu6vqwjjgn74ivg+H2sBzO?=
 =?us-ascii?Q?SYP5t0B5y72skQjZgdCWbeJirYIEfiasZmnQAdG7W9EaZ3hmk2tZklA1QdFk?=
 =?us-ascii?Q?5fNyrVywm7bHUQemO/yAXhwGmQ7Xu2TSjkxXenaX0ZvqcK5R7ZL7uNKs4YFn?=
 =?us-ascii?Q?hj0MYF/Dh3JNJmMAKlkhiSAq2utdnbTnwhKT5zjF4rFBvwfKXHw8UlTFuxM6?=
 =?us-ascii?Q?yZuto8RtB0fXtw92fX87T0PCTs9GTo+NRliuMu4Y9bFNcwoNBVbJLGltrvUs?=
 =?us-ascii?Q?s84f0hrIJ+gobmDa82AGDpIClveu/gTDMDGHd3NLCOsp+2oBprkq0HuXTQkp?=
 =?us-ascii?Q?VJb4ykN23bN5FZzPdXB/X+rIhLv6QTmvN7XpI0QW68sREtXg1w3rHY6LATSP?=
 =?us-ascii?Q?QOWnADTkEw8lQujI/msGMsCPeBtKnvsyusjo11JW/YNvjJUii6TZd3PgdiKO?=
 =?us-ascii?Q?6mMCpcxsFQWox1C6YtB4aB4VtLdNtRxIGYvR00LU8u1S0fbrNKDf8NJG5gEn?=
 =?us-ascii?Q?Ww=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: LIsDo9GA9fSuCzZweqpcwfiIb9RoI0nKepBULM/+MpKdLLA5XWEwWAwN6x9e6xzHbGIQHaoS3Xmgjli6VsR/QDjTfUicju/MbSVA3LGCJQq4TkZZYvUQ+7pl8IZcmocaI+STDYuWxNpq/KNQt+MAijuBT3UsMwoG7TL7ugVEQWk3O4TssO4S1RO1QlDr/OUPPChiBuqD+WkvW/7pqOhwBd3TRTGDOtlHH1MFPmy0JUPCYGFR6IDvx2uJtYq1Ff51biVLOJdy+8nDigUBF4ioXGJ8Zl8tYU7qUWndUEXdyxEQzSkE45OZm3XXeDheXcvc8UMJu3vHIVyLoj661JP+k0hpwUi43x/PujmEXNUAQoR8q14TD5XUCm36DILG5g25DcGThckPqiRsRgZH6/X4SFuy0VomPcZUyZwyZrva5lC0Iqz4TIp9ewSG8iYCfg9MCHlr16oypMZ5m529LNbyR/d2yRwl8Ep/RfbbADDujxKIfOwPgmBvawGc/nmMpWPRs3j8I+wOyRnwEm7mIqu3TpFvhxpiS5thwKvrMyA47OfOFgSFc4wZKZe51TXCRlwXmBEZd+1E+YurB4GZH6RMm1ONE8mAZOeXhxjzSyGVRNo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe33caae-3188-4288-4f99-08dd19c64db4
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 09:29:25.7288 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4M7u/AxQ6YHjOHCxQ8RGeS4b7/GIjOYdB20sG45TYycR48yp7Dy8ikrwKUfLrMEVsXdsK2mcxAc/rE3zj/yCEIm03jSmrTsttTtKo3wZqFk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4871
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-11_09,2024-12-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412110071
X-Proofpoint-GUID: PMceujNyorx2_ZKKe5sega01slmZk4t0
X-Proofpoint-ORIG-GUID: PMceujNyorx2_ZKKe5sega01slmZk4t0
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] Add madvise12 test
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
From: Lorenzo Stoakes via ltp <ltp@lists.linux.it>
Reply-To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, Dec 11, 2024 at 01:30:48AM +0100, Petr Vorel wrote:
> Hi Andrea,
>
> [ I dared to Cc Lorenzo, the author of the kernel implementation ]

I'm not that scary am I? :)))

Feel free to cc- me on anything relating to this even if obviously in the
LTP project happy to be included! :)

>
> > Verify that MADV_GUARD_INSTALL is causing SIGSEGV when someone is
> > trying to access memory advised with it.
>
> Test LGTM, thanks for covering a new kernel feature.

All good, looks fine to me, though might be worth expanding over time, we
have some self tests in the kernel for this, see
tools/testing/selftests/mm/guard-pages.c.

But it's nice to have a basic LTP regression test to assert the fundamental
thing is working as it should, and also nice that you implement it from
your perspective rather than mine, where I am obviously rather influenced
by implementation details.

Also note I submitted man pages for the change, you can pull it from [0]
and view it via:

$ man --manpath=. 2 madvise

[0]:git://git.kernel.org/pub/scm/docs/man-pages/man-pages.git

Hopefully these will get distributed around soon!

Thanks for doing this for my feature, much appreciated overall!

Cheers, Lorenzo

>
> Closes: https://github.com/linux-test-project/ltp/issues/1210
>
> > Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> > ---
> >  runtest/syscalls                              |   1 +
> >  testcases/kernel/syscalls/madvise/.gitignore  |   1 +
> >  testcases/kernel/syscalls/madvise/madvise12.c | 102 ++++++++++++++++++++++++++
> >  3 files changed, 104 insertions(+)
>
> > diff --git a/runtest/syscalls b/runtest/syscalls
> > index 5fd62617df1a116b1d94c57ff30f74693320a2ab..ded035ee82d0e97c67cc1e7c487b010634b2d1a0 100644
> > --- a/runtest/syscalls
> > +++ b/runtest/syscalls
> > @@ -1000,6 +1000,7 @@ madvise08 madvise08
> >  madvise09 madvise09
> >  madvise10 madvise10
> >  madvise11 madvise11
> > +madvise12 madvise12
>
> >  newuname01 newuname01
>
> > diff --git a/testcases/kernel/syscalls/madvise/.gitignore b/testcases/kernel/syscalls/madvise/.gitignore
> > index 722ac3c34306bac414313f1ce36ca98d715cd04c..758e601a9c4e7682a925f16184d14f2357009bc2 100644
> > --- a/testcases/kernel/syscalls/madvise/.gitignore
> > +++ b/testcases/kernel/syscalls/madvise/.gitignore
> > @@ -8,3 +8,4 @@
> >  /madvise09
> >  /madvise10
> >  /madvise11
> > +/madvise12
> > diff --git a/testcases/kernel/syscalls/madvise/madvise12.c b/testcases/kernel/syscalls/madvise/madvise12.c
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..2bdf843f016a7c9d175a31b76ae805d63c4cbc80
> > --- /dev/null
> > +++ b/testcases/kernel/syscalls/madvise/madvise12.c
> > @@ -0,0 +1,102 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Copyright (c) 2024 Andrea Cervesato <andrea.cervesato@suse.com>
> > + */
> > +
> > +/*\
> > + * [Description]
> > + *
> > + * Verify that MADV_GUARD_INSTALL is causing SIGSEGV when someone is accessing
> > + * memory advised with it.
>
> Maybe add:
> 	* This is a test for feature implemented in
> 	* 662df3e5c376 ("mm: madvise: implement lightweight guard page mechanism")
>
> The rest LGTM.
>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>
> Kind regards,
> Petr
>
> > + *
> > + * [Algorithm]
> > + *
> > + * - allocate a certain amount of memory
> > + * - advise memory with MADV_GUARD_INSTALL
> > + * - access to memory from within a child and verify it gets killed by SIGSEGV
> > + * - release memory with MADV_GUARD_REMOVE
> > + * - verify that memory has not been modified before child got killed
> > + * - modify memory within a new child
> > + * - verify that memory is accessable and child was not killed by SIGSEGV
> > + */
> > +
> > +#include "tst_test.h"
> > +#include "lapi/mmap.h"
> > +
> > +#define MAP_SIZE (8 * TST_KB)
> > +
> > +static char *addr;
> > +
> > +static void run(void)
> > +{
> > +	pid_t pid;
> > +	int status;
> > +
> > +	memset(addr, 0, MAP_SIZE);
> > +
> > +	TST_EXP_PASS(madvise(addr, MAP_SIZE, MADV_GUARD_INSTALL));
> > +
> > +	pid = SAFE_FORK();
> > +	if (!pid) {
> > +		tst_res(TINFO, "Modifying memory content");
> > +
> > +		memset(addr, 'a', MAP_SIZE);
> > +		exit(0);
> > +	}
> > +
> > +	SAFE_WAITPID(pid, &status, 0);
> > +
> > +	if (WIFSIGNALED(status) && WTERMSIG(status) == SIGSEGV)
> > +		tst_res(TPASS, "Child ended by SIGSEGV as expected");
> > +	else
> > +		tst_res(TFAIL, "Child: %s", tst_strstatus(status));
> > +
> > +	TST_EXP_PASS(madvise(addr, MAP_SIZE, MADV_GUARD_REMOVE));
> > +
> > +	for (int i = 0; i < MAP_SIZE; i++) {
> > +		if (addr[i] == 'a') {
> > +			tst_res(TFAIL, "Memory content has been modified");
> > +			return;
> > +		}
> > +	}
> > +
> > +	tst_res(TPASS, "Memory content didn't change");
> > +
> > +	pid = SAFE_FORK();
> > +	if (!pid) {
> > +		tst_res(TINFO, "Modifying memory content");
> > +
> > +		memset(addr, 'b', MAP_SIZE);
> > +		exit(0);
> > +	}
> > +
> > +	SAFE_WAITPID(pid, &status, 0);
> > +
> > +	if (!WIFSIGNALED(status))
> > +		tst_res(TPASS, "Child ended without being signaled");
> > +	else
> > +		tst_res(TFAIL, "Child ended with %s", tst_strstatus(status));
> > +}
> > +
> > +static void setup(void)
> > +{
> > +	addr = SAFE_MMAP(NULL, MAP_SIZE,
> > +			PROT_READ | PROT_WRITE,
> > +			MAP_PRIVATE | MAP_ANONYMOUS,
> > +			-1, 0);
> > +}
> > +
> > +static void cleanup(void)
> > +{
> > +	if (addr)
> > +		SAFE_MUNMAP(addr, MAP_SIZE);
> > +}
> > +
> > +static struct tst_test test = {
> > +	.test_all = run,
> > +	.setup = setup,
> > +	.cleanup = cleanup,
> > +	.needs_root = 1,
> > +	.forks_child = 1,
> > +	.min_kver = "6.13",
> > +};
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
