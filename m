Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A273ECE579
	for <ltp@archiver.kernel.org>; Mon,  9 Sep 2024 09:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1725873033; h=date : to :
 message-id : references : in-reply-to : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=HOSMr3Vz/zkSqLucgkhzvmtEmwSvO2yUZgqgqJQKHs8=;
 b=LeNk2mNXmNBFRQx47No4Ysf8p2Q8Lwgh/T/mxLPz8nfCdZ0h13duqPGulextf34S+QHs2
 MAx5qQse+GapUr3A1oM0LD/qGsDNkuNJw+X/xpZbLMI5prHJVLonFlxfyS5vb4UX0a8xnlb
 kNNdW9k92kxWNEVn6DerSRgFM6CZLHY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7B1B23C12F5
	for <ltp@archiver.kernel.org>; Mon,  9 Sep 2024 11:10:33 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CAEA33C094A
 for <ltp@lists.linux.it>; Mon,  9 Sep 2024 11:10:11 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=oracle.com (client-ip=205.220.165.32;
 helo=mx0a-00069f02.pphosted.com; envelope-from=lorenzo.stoakes@oracle.com;
 receiver=lists.linux.it)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E5D4C200C27
 for <ltp@lists.linux.it>; Mon,  9 Sep 2024 11:10:10 +0200 (CEST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4891tpbk031249;
 Mon, 9 Sep 2024 09:09:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 date:from:to:cc:subject:message-id:references:content-type
 :in-reply-to:mime-version; s=corp-2023-11-20; bh=0OAGSCzFSe1+1hj
 RcbzB86zEb6sKQ/A6AfGwvM7iAiM=; b=nCZonIk3oanmdYmJR4o6LtNLeX1dZD7
 B1XHFWwuSuAuDuzvz2tCT3HkyTgyLZqAGOLtY0yezcuq51vn8ZsfUNN4/onBhQzM
 WQJXsXYdIVITblphkoi7Ix+7OtedFyYVLq2A1JR3//DziE4BNWvWWt+InfcIk7XM
 mGxXwhsvPGZ9v0YtvtDeGJ4ZGJRdtgU+7On/Olqx/xNGVksFtOU3gH1eQ+QDWXFL
 lvej2aHGOuluNK1e/iGiSAHvIv3R4J1Xj6JbszBFo65L40O3iIPhHjs1JIcuUuQD
 WVOBIHEFLTddbLRhXK54I5Milr52U0ehFtO+U2yZm6mSzLsYChhfxuw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41gdrb2dj5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 09 Sep 2024 09:09:58 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 48972a5C019848; Mon, 9 Sep 2024 09:09:49 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 41gd9degmj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 09 Sep 2024 09:09:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=st2Z5qFWyRwIazwHHzrUlY648STJelHT8DuK5+iCiYTamhs7Qa+CPvI2HxDOl+hrX78981NuzgY82ZmLx9scxCK503howx+Bd6hB235hid1RPil43Ts0cBYBfZzkgR/XJFlaO4okhhPRRv6mHEm1BB9T4a6LEzxgOydjxBlyPvxdxLk/Y/6X2ilE5o/YJqvD5946xVtGlnXtdN7c51+eCi+p/7PBsI6zDZMdsqaklSO42sHbnrYO2F3po0JEmi3lHqCCmqEnWx7r2f5bbmY49YJaI1RynhPIHvbhfTdgSSHHUHsm9kjaCQS7QByyxc+9UZgZB51Ed+5BMah+0qa0/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0OAGSCzFSe1+1hjRcbzB86zEb6sKQ/A6AfGwvM7iAiM=;
 b=paZX+mryHAiF8fkemdk1f+ih7sdn/XlnGFcSaWs0m73SnIpUpWtYQ4mnoRDKS5q2PKlDGQ6bRkFvCmevLUu/kzX8CQ6cQJmSsGRCSnMY+f1DVY69F8fuTT9QQDmjACZgtU78LnsgPEiM9zU9e4nBZYTjkt9xSDGh76DC48XIPzhE6JgSQ6AMRXrlvWJfGXPl5M9DPan47sXs3hiQ1xpbVDuywbtV33joToMy0dRDFfjF3326Y47SiFnyFZFj4QPbkmK9C2I3SpJyUcIkNljo1FySfR6ukUvlJ/rikLfUmxk5ISqLSxZqtjjcuSqf7qSPnF+njcAO/nA7pAlgPU3LcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0OAGSCzFSe1+1hjRcbzB86zEb6sKQ/A6AfGwvM7iAiM=;
 b=LqQzTCqn8m1iDUewpWuwGPsia4uU92Wtv0YV153ugrw8VeFgdrxRGL/8pJ/pqekbrb3COZaXKvJpgSJACc9Z3B7etwx2kHOkbKU5B2iy6zjP+hJcqCAgy7xXB7vqOXQkGdP6g4GhJQGBsdOdg1hwKh7JXkWUhQlInPRbipmGkQY=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by BN0PR10MB5175.namprd10.prod.outlook.com (2603:10b6:408:115::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.14; Mon, 9 Sep
 2024 09:09:47 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.7939.016; Mon, 9 Sep 2024
 09:09:47 +0000
Date: Mon, 9 Sep 2024 10:09:43 +0100
To: Xiao Yang <ice_yangxiao@163.com>
Message-ID: <9a899c60-cb88-4991-8c5f-3fb14c8a09b8@lucifer.local>
References: <20240909050226.2053-1-ice_yangxiao@163.com>
Content-Disposition: inline
In-Reply-To: <20240909050226.2053-1-ice_yangxiao@163.com>
X-ClientProxiedBy: LO4P123CA0533.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2c5::18) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|BN0PR10MB5175:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f7985a4-0411-4a8a-3b0e-08dcd0af26f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ByESAx1lBFNNSpQVvoMxM/hUmp6ZuknYWU7ZJyovcO7n7hinu61/lxtlwXDc?=
 =?us-ascii?Q?Gzouzw8j6s/LjhQk3kmvSSuBZxdbzjznypiXAa1UrgxyMzhQ2aiGWdzlEWX9?=
 =?us-ascii?Q?vS/6IEj80vl+km3RUC05vI66a/TYUXYUgmOdiiEFCFyllPQlMr61F1ybsbT7?=
 =?us-ascii?Q?bgFOv31Aarr59No+0x0gCSXs0AQl5qogVHptjTBwppRB9/jYq3pYb5/P/R21?=
 =?us-ascii?Q?gToB230BEMULCzJy0CQP6yBBKv20qOpIroyAB5yGxBa8Wmkr22FqP7PHZXih?=
 =?us-ascii?Q?0LEXPQ6ikZ3nqOWQHuWCMFZdDNJdhdyPMQafGTaQEQuuTgVPudmMFc1od3TV?=
 =?us-ascii?Q?xVOuEo0DCSXJAx0r3uxoa/j4exGMdmuCUZ0JUQzIs9m31Jcn6354TZG/DJGu?=
 =?us-ascii?Q?BvMQF/LlbcJQmAqwnbwEfzAXRLTVKVrjoUB8ML+jC7dBfSEEqvMCMWY39TEK?=
 =?us-ascii?Q?rRnxQIvU8vPT+WF/s6uktctjMSq5jf8sMhBFI7rfwDvfe1Rns7AnHKMdzaR9?=
 =?us-ascii?Q?75EZNmXBQtqR7QL/MQxq+NKVdM3vwO7KdSeOfy2tKvaUYumVVGMbN0n3dIvZ?=
 =?us-ascii?Q?1yKWh7cOzc/faUOdAWP8HFWs7KShNzIy73840H3r4T2wCO6yMa1i9lPeWqag?=
 =?us-ascii?Q?HyYFWqUlK5iDylcEKFsjLTDxYTzmgkQpPHmTgYo6yqsPT4sR8CrwQRtvvgCJ?=
 =?us-ascii?Q?Fhs6tpOfZP1z5pK4Nr/wZMolubpPMJGOay73jpB8FhRHFnAFkNZZqBR09jsK?=
 =?us-ascii?Q?Ab/Y81nYrXC+ATjcyvuDgNnQFQUOtdt4zvdLFoUqYnWVdIJkET1htTgjtSfy?=
 =?us-ascii?Q?gMHcOCxW+aGXsW2Fn2sZ/VuF/SQJy+YJuarTP8nGpQfHdYigejbot+r3kefS?=
 =?us-ascii?Q?My8aZq5Vq3NmkpvByfjVNqai6osvdHaU2bezGGsQl4VGG9+A6DmEzuBsUGgp?=
 =?us-ascii?Q?+x482MlvV8kdEX60S8K4K4N0k3ASI46NFL3TWrcuNKJcfm9/iSaYR7PBTYNT?=
 =?us-ascii?Q?QoaDfIG00zd0vQEAyx4mQCBY7EozwT2ZjK5/Cip5WpT8scRA2QxCZ5112+Lb?=
 =?us-ascii?Q?ARPAoMxJSm99BCCPcGWap63srZ1oR2Y+r2iViDYhZ/7EN3WwYGRe0GSYwkc3?=
 =?us-ascii?Q?/9LTwwBpn3A7V4jYaqlhrF9dTKYO5kSm2RvNVsijbQitJTh6j/h34EYnDkgh?=
 =?us-ascii?Q?6OzFfrQbdID/FdwVYiBP/XswcBWmI1GjuNX9W5UGdxAR+Un/5PyoT6+cp2De?=
 =?us-ascii?Q?+wxgDvxZOLqfRpdazcafX1gG54yTdeJc3MdbzpsBQCQUZxmFeOe/98jkj3tX?=
 =?us-ascii?Q?cL4m4MjLpCZ3IYZdTLDx1qQ3+onrW7gv1nC9qveoIiCwDtU8DgP2iErW+EyF?=
 =?us-ascii?Q?Ek0zmuo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR10MB5613.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YFK91OcoGkyXpxIzyUcVwMFFyyJXWsQq6QkVqPgxBQqgnRySgBXpYUZIVTi1?=
 =?us-ascii?Q?6LetpjYZ7ueRXAir1U5jirTyhUxnqqCSrnyTQ6EDujKcUY5bFHKNxyb4uaaQ?=
 =?us-ascii?Q?Cid6dnyAfIFXUvCrbTPFT0xblzzoOgEHOjbtc4K/PrNrsJsbFLHO1dj33pxx?=
 =?us-ascii?Q?Bk5ReTIP528h9iA0AlvxghclyVE82hR8gIEAuFWhMZ7BkUJ7dGlCIAk5uYI+?=
 =?us-ascii?Q?XxnaMKLtQ83iW0DkTJmoPOMKGwvCWP7biFxFlwkKK8E2pdIGYPukuXo8i5MY?=
 =?us-ascii?Q?/dwRspqtzP/2TGV/aLBoH3AV6P9CH7L7pN6UdOc2tBrrdVttVnp2Y/P5LuQw?=
 =?us-ascii?Q?r5pEC/8G/ZgGk1TBYaqRTHZ+lqyTCwBeQaeQlenTxKiZAPmqRuUYHcaQ/Ku1?=
 =?us-ascii?Q?gh4bvXpSGP8z1j6mTvBEhqOVFDxeyzKVF749i6ZL69TBt8Ss0ouf1DTjjSHx?=
 =?us-ascii?Q?IgBjZn0ucbVb7ek1ASWREfpLgC00EzqXz+K4e6db5LC7anqt0UT/bL5aL2HZ?=
 =?us-ascii?Q?FhdLH73QEyIOtPYc8+z27J4VddqJsgPmJP0lQMbh1RVeitdXKDSO5aZQWkdv?=
 =?us-ascii?Q?qm4DWQMTcdfsr1SJ93If/Ax1ZKigSQhufnV+SvQ1BoibrUTKgeVnLl4k9Lrf?=
 =?us-ascii?Q?+hEPX+2nQZU3uyVMmeoPW52XdMGwNyMDbcmeWWD3cywAerS6CRXmtg8WpZ+W?=
 =?us-ascii?Q?3PIGjc/b68FebdwmpVfQctowsxrevoPFrUbkYkSMNjCGh1v/d8d4p2P6KiqK?=
 =?us-ascii?Q?H4wAsLfj1J9RjxcBoVsi3bMDvza1eJTG7z4YTqk09liJ3XdiiCprFrqi8LAf?=
 =?us-ascii?Q?niKLRlwEpqTJvTL3lLS9nJ1q9iERdICPpY2eJWNohnICH/jZ8/qyiWG9WJDw?=
 =?us-ascii?Q?HmntM8jxUZ2UrjiXgm6Vdv2bIpZB1+/C1ucRJlvGNCA7Aa7HDV7JMvrNcbEU?=
 =?us-ascii?Q?jU5kGymR2CgJTO58SVqyV/d1NJqobYAa5iBaJ7ISHhWL8y11PN4W9EveeLqI?=
 =?us-ascii?Q?i53I+++ZZKWzFmewoOkBxOY9FfED/eZe/fpBaj5YV74vxgQFZ8o3IgIaVHKr?=
 =?us-ascii?Q?e7o3BBkzH8zkobodWsVA/roqEsem33jar07HFYQkublRJ28mnmOz5aFaZJj7?=
 =?us-ascii?Q?Duj9qnlX/UgcsULtmVPt6MAoUCJiMvgxXmWHRm96gIfPVL0f8FgEsVZfaUdw?=
 =?us-ascii?Q?aUGd3LwWP1GA3gihvfJ6CRgK/MJbFoZ4w6zYFxC67g1TI3LhCr+KncTfWAwj?=
 =?us-ascii?Q?PtQVt1MFcYHnrkGej96anjumRYBywYi/7kEtJvNktXaIDskUynvEZW7YNENs?=
 =?us-ascii?Q?95KOLPFs6Pb9vHYof9ZBbRJRma0Jt7th2OdhGLDgKRhVPZm6yFs2b9NZAHA7?=
 =?us-ascii?Q?fTbOr8bHrjx4fJ09ypvM3geC5zepk1Ho4e2LzDxWjWLPaXnF0jR+dBOPy7Qe?=
 =?us-ascii?Q?3HGJR3/7T2EgITZmfWAcp0640grskHbahkKABut0/tx4OdYHMnzpv23gy7t2?=
 =?us-ascii?Q?Oxw3HobRsEYfJOWo1fLs26g+MsMIxDVJW3k5hbIyf0nw9SxaKAP4IQAaND1/?=
 =?us-ascii?Q?OVGXJGOeNQlCIUWOwityUUR/eiIgeiLVkNg/9JWlICP4eV/JFLuSrx5XDExB?=
 =?us-ascii?Q?Jw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: XP4JpnUV53GEiWvHS8JXUrbdC+8Yr2cQ8W4dbFWNgg25/VFjOi5oLSG8YVf0BUhYCtjC8zDoMtOx9AmAjfo20613nMsVuNui8WPZs2kxpmsSmqnqr4/IIcXJJPbn7cXRmqf+3Y84VUdIPsUM0aKBJgIjJDdRAtsZzWfroZPQbB4Cn1XjLiuBa2u1izgkl83WktHppWFieLuByWsAJTpRdopfoy9QgaTHvGtEuMzafGO+1VjSTeRmnKS/dQBmd5kKPyFJ/Inc/4Bxbi0W+MdHIk/qNxTrOIq86fW68xxMQUsS+hVebVPvat7l9lSuJKOZXwrKhpPkEuFpFrkaC3BPcKmqlMhjLRYZY0+62Gc6w4oQGB+LTWEfHMn9w20RCHuQpI9gboxlXGQYpdDMecIlk+zqKSPTCsxD83rs+pIxJz92oXJdF9s8RKIe3+AGpzkBXHGlap6rPwDijI5TOM26v/Q4hEaj0qa33z9356LEk5HHLvDdRiZl8R8RoypsRwMBCeYSOav5D4qTa5VZhEh1jZ6JY4dRHhL98L20yx7WIWPHuIso1t85r9mHzIEaVdFkp3JgNsXk6sKNC+gKNf/15V2b9j1KGuNj2V/78dG/F4U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f7985a4-0411-4a8a-3b0e-08dcd0af26f9
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 09:09:47.2919 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Un4nSitU7M8JoG0Ei79lHAraAvMkziN4WdDMfOUobVM2e+Ma4LAWofzN+aqbcSXg6dm8aG95JQDaEel7ZWDHbgGqYvQKtO/QNfULuMcJAaw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5175
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-09_02,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 suspectscore=0
 bulkscore=0 mlxscore=0 phishscore=0 malwarescore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409090072
X-Proofpoint-ORIG-GUID: RPH6qlE7i-_-tYgUmaQ-uV8SGlO3bCkr
X-Proofpoint-GUID: RPH6qlE7i-_-tYgUmaQ-uV8SGlO3bCkr
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] mm/vma: Return the exact errno for __split_vma()
 and mas_store_gfp()
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
Cc: linux-kernel@vger.kernel.org, Liam.Howlett@oracle.com, linux-mm@kvack.org,
 oliver.sang@intel.com, Vlastimil Babka <vbabka@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Mon, Sep 09, 2024 at 02:02:26PM GMT, Xiao Yang wrote:
> __split_vma() and mas_store_gfp() returns several types of errno on
> failure so don't ignore them in vms_gather_munmap_vmas(). For example,
> __split_vma() returns -EINVAL when an unaligned huge page is unmapped.
> This issue is reproduced by ltp memfd_create03 test.

Thanks for this! :)

Though pedantic note - please ensure to check scripts/get_maintainer.pl and cc-
the reviewers and maintainer, the maintainer being Andrew and the
reviewers being me, Liam and Vlastimil.

The maintainer is especially important as it's Andrew who'll take the patch
;)

I've cc'd them here :)

>
> Fixes: 6898c9039bc8 ("mm/vma: extract the gathering of vmas from do_vmi_align_munmap()")
> Signed-off-by: Xiao Yang <ice_yangxiao@163.com>
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202409081536.d283a0fb-oliver.sang@intel.com
> ---
>  mm/vma.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/mm/vma.c b/mm/vma.c
> index 8d1686fc8d5a..3feeea9a8c3d 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -1200,7 +1200,8 @@ int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
>  			goto start_split_failed;
>  		}
>
> -		if (__split_vma(vms->vmi, vms->vma, vms->start, 1))
> +		error = __split_vma(vms->vmi, vms->vma, vms->start, 1);
> +		if (error)
>  			goto start_split_failed;

We'd probably want to stop assigning error = ENOMEM and just leave it
uninitialised if we're always going to assign it rather than filter.

You'd want to make sure that you caught any case that relies on it being
pre-assigned though.

>  	}
>  	vms->prev = vma_prev(vms->vmi);
> @@ -1220,12 +1221,14 @@ int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
>  		}
>  		/* Does it split the end? */
>  		if (next->vm_end > vms->end) {
> -			if (__split_vma(vms->vmi, next, vms->end, 0))
> +			error = __split_vma(vms->vmi, next, vms->end, 0);
> +			if (error)
>  				goto end_split_failed;

Related to point above, In this and above, you are now resetting error to 0
should this succeed while some later code might rely on this not being the
case.

Basically I'd prefer us, if Liam is cool with it, to just not initialise
error and assign when an error actually occurs.

But we filtered for a reason, need to figure out if that is still
needed...
m
>  		}
>  		vma_start_write(next);
>  		mas_set(mas_detach, vms->vma_count++);
> -		if (mas_store_gfp(mas_detach, next, GFP_KERNEL))
> +		error = mas_store_gfp(mas_detach, next, GFP_KERNEL);
> +		if (error)
>  			goto munmap_gather_failed;
>
>  		vma_mark_detached(next, true);
> --
> 2.46.0
>

I'm in general in favour of what this patch does (modulo the points about
not initialising error and checking that we don't rely on it being
initialised above), but it very much need's Liam's input.

If Liam is cool with it, I'll add tags, but let's hold off on this until we
have confirmation from him.

Thanks!

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
