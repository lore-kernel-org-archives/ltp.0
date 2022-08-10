Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 941A2C00140
	for <ltp@archiver.kernel.org>; Wed, 10 Aug 2022 20:18:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B13483C948F
	for <ltp@archiver.kernel.org>; Wed, 10 Aug 2022 22:18:37 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E03CE3C922F
 for <ltp@lists.linux.it>; Wed, 10 Aug 2022 22:18:25 +0200 (CEST)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 868081400273
 for <ltp@lists.linux.it>; Wed, 10 Aug 2022 22:18:19 +0200 (CEST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27AJiDgX029938;
 Wed, 10 Aug 2022 20:18:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=7mKZpEKm57BjgHJgGVFkeIWpIvBs3FBZJTe1NbZueQY=;
 b=zrJSwpS4oEeVzdI0xulQrczCfMjHlhE8CU79Kndx/bwj59eQsIbW8I9PHiNAsBm1QAUb
 3uO1RsPkpsrFx0KokQtP9y/vqMJBuIEP/Zz5WZh+pRQGSdW/vyUrJoxVuSivKtn87UMH
 ozGSdcL2KuicCsgSV94EsDKPjz/ZWjzW8HwENJslag0uSv3RPzHLWrOujgTnX6E/YvJB
 LPwyAUBd0U4ypL8to/pxFXempOvS5aA0JgoyvYKC2gn5BYBSdTqNDP3VYH1HZFYQss3o
 RMn6kJ498Mm9xrQFqwtsthKO5LR5CYR8KV43orITibihlanA0lGOAN8DP6Qmdy0zPPow 2w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3huwqgjyee-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 10 Aug 2022 20:18:17 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 27AJjq34001690; Wed, 10 Aug 2022 20:18:16 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3huwqg80ud-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 10 Aug 2022 20:18:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=liz1dlF+oBVrKeI4Vb9gyDzuD9Xhqt1v7v29Vb8zanoMy49Nc3L5cnms7MZlznUegUXYljDoUH8gq3uEidll+0qFftqif5xtvKP6ieEEw4uo3FAF0UJoahkoc5uUwvacHnOecumt119JGjdWPxuXCqmnyLn1usz28cjEGMWlRDOUj6xFFF6vpRER4IP830Q+p9G7W1oZ5bLq3sSE7kNqRxJOh0wSEuzhe3lMg6dIFjjJYEqEAPEetikPSTkYQ536xfoVkyWpRv4OZ71PjwcyxwSNayOj/NfhGPHoatMSxIZ3ULFHtTK5FCTJBsMbqOgKw8qppZEGderZNPnPFpV2yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7mKZpEKm57BjgHJgGVFkeIWpIvBs3FBZJTe1NbZueQY=;
 b=WUV/N3HgvXsONQDB98I5hdc9qbPyzx3KxWr6n87K9z5QfaROk9eVn8iFaAaof7fSkt5prCOuYi+IFikxJca6TqCxydQb9rwIVp01r/fFGkjQ/h/DEUV/IkfuPGAUdvDXH9EDqB5kLINK44iGKon5joebvG9mzBqv5lJSGv8ZZpkqwY34QGaeNSA7938z4z3tdDtQOYLai386fRv0FLs/g8OHa6jW7lycqM2B82KN7JWztDbrlm9pSyPFKmfWzk/sAiHxsJqbyQz7ZvCJNP+JNLDLsxa4B3jxksUVX3QsxcyZaSwRiOYGANoruIaYvLcXuioDtbFIFPHXDn2wPmj2fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7mKZpEKm57BjgHJgGVFkeIWpIvBs3FBZJTe1NbZueQY=;
 b=RMZU0diEgXPkuP99PyFIR/1eKIEwcCOV32Kx6/y9a8irithEtqXrJR/Vns7EhmqrsGRx+2EdrDPAt2BxBIp/nNrETWt//tb1ZERHXqYuuQTLODW54aIyAhHOpzmVm+NMeWHZ4LRlCz6TEaaRBUe78FClT51EcrstIk+s86qLTSQ=
Received: from PH0PR10MB5481.namprd10.prod.outlook.com (2603:10b6:510:ea::5)
 by DM6PR10MB3548.namprd10.prod.outlook.com (2603:10b6:5:17b::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Wed, 10 Aug
 2022 20:18:14 +0000
Received: from PH0PR10MB5481.namprd10.prod.outlook.com
 ([fe80::5559:3c10:3e61:e798]) by PH0PR10MB5481.namprd10.prod.outlook.com
 ([fe80::5559:3c10:3e61:e798%4]) with mapi id 15.20.5525.010; Wed, 10 Aug 2022
 20:18:14 +0000
Message-ID: <cedb3470-8351-2fe1-7719-4e3515692a4b@oracle.com>
Date: Wed, 10 Aug 2022 22:18:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>
References: <1659975072-29808-1-git-send-email-william.roche@oracle.com>
 <1659975072-29808-2-git-send-email-william.roche@oracle.com>
 <YvPkOHRgUGx0QVMi@pevik>
From: William Roche <william.roche@oracle.com>
In-Reply-To: <YvPkOHRgUGx0QVMi@pevik>
X-ClientProxiedBy: AS4P189CA0023.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5db::11) To PH0PR10MB5481.namprd10.prod.outlook.com
 (2603:10b6:510:ea::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 12c31955-ebe1-42d4-b6a3-08da7b0d741d
X-MS-TrafficTypeDiagnostic: DM6PR10MB3548:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pCGPxqBBkzYRJl/1416T9rXgy5ySYMDvLDTIIfQbvnp4Xw9V/yMLsJNzcQ1AOhPH9mZWf9iVzUfZLT4IRpzeT+l5AX+B4fWuU8lICZrTnR3q4D+2WRDqGJT3IqI9+lKuHVshfEIzvGYdkGt7VFB2y7mRnXAauneYT7pOONrWed4hxTE94ElTzS8nBpSo6hD1+yIVDw5Gdxd13a98hM38x1HyYb2vHHgwEHZS8yfiXmQBK167+1RMLkJIVC0grslDssysoci86XNhKpsUkxEKFAePXf0+ahjqJSSpaiQSBgL82PkyyJYV0ADrVVrktK25gTT9qm0AEpnTbfSbRnMlLFglF/zLZBD+ckLNUnIBKk/77+uEDWHcf5k+4jz09t6p393JeqPSp5jXsaKQmZV0AKftE8D8Hg3XKcOoTylORFfnBKVqRRNx9pn5mmiB2R03I3LGAY3XUQw4eX9UHf9gZyXTt0U2VAjbmi+NHAconx/uucOioUcLZWD4J6XDqcEzwxxQxiJfhOEN3cdixpivuI8eDpK+WE3fCYAWSUygfFxunU6xW8W949ALspxADskZ9PrOBitZixWFsIiboGef8p5XFnGjjauoQhO93uFfdFpsZQRl34G7xZQSQJjqlybAO2LG5aDmLJKw2Siv3G9jMTD5qgfN8qXJRXaonFnDQsGEyHCpRxUpqmX3S48u5WvqcKlkKfUBZ4YLZu/mZcP+fO85MlMSFJUiBKhlWuAAORvr/E0REke5eJ48l8/fkAafDuFgyQNpy3BScogyYL+P/jm6Oau4X5P2Q1sKSQUh34HMqAuNfehpzgY5x7/OlN2v
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5481.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(376002)(346002)(366004)(39860400002)(396003)(136003)(4326008)(8676002)(44832011)(66946007)(66476007)(66556008)(30864003)(2906002)(36756003)(6486002)(478600001)(316002)(6916009)(53546011)(41300700001)(86362001)(6512007)(6506007)(26005)(6666004)(31696002)(38100700002)(31686004)(5660300002)(8936002)(2616005)(186003)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QndaWGpWYlE2T1RrY0JnOUdVTjl0SWFSc0JZYk56ZWR4Y1FCQnpBaE5id0RL?=
 =?utf-8?B?eXo4QzUzNUwwQUwrMHorYkJGdlI4bDhuK0VIaFU2Q1dIVDVqeFh2WFhtOE03?=
 =?utf-8?B?YS8zYlpWMlcwR2E0L1BndE16cys4S3g4TkxTUVhWQVlCMGlWWUVubFl1QTdl?=
 =?utf-8?B?T0hKcUFneVo3TzVOOGdxNVQ3OG1FZmlOU3pzajhPb2NQL0drQnVWdW1US2la?=
 =?utf-8?B?K0VjVy9lMUh2TXU4amZqaE1HamZ1UFpLNzEwVTdDcTdGNWxXNEN0T0pvOHFX?=
 =?utf-8?B?OHY2L1ZjMG11Tk5waUlQTEJsTGRTOTJab2VzYko2VVVEbU1nYWFudDJZQXZz?=
 =?utf-8?B?MFhOM3F6UXBKVlN1TzRNcWNGOVhXSjJJTVNmTXBpV0J2Q2tjRHExYjFsTTB3?=
 =?utf-8?B?RC9EeUczSUV3cFUrL0w0bnRYZ0ZxMVJGSjNDR0VRNFFraURnVWRuaGVmVVJL?=
 =?utf-8?B?SVFXTlFxYzBWaTYvYTd1WGtqdW5aSHYwWVJTaTZ2b25lWktSNmk2QzdGby95?=
 =?utf-8?B?NEVOLzgvYVhaUW9CL3IxS0NlWUtnYUFLd01ZclNXYmhJbm82aUJpclZDbm1H?=
 =?utf-8?B?SGpGbmM0OW12eUg3TzlBK2V4Uzd5TzlCODFPaFFGMi9VZFBQc2ZxbGdXRWx4?=
 =?utf-8?B?STM3ZUVQb2VaWHNJejZROHQ1bFdjYzIyenU5NUN0UGY4ZWo0YWNwQ3Qvc1c5?=
 =?utf-8?B?dFZhY3Eyd0J1S1o3eDkyZHZFcFBHcW5uZ25NMitXUTY3WlFxditKdUtKbzRv?=
 =?utf-8?B?R2tRTG9tbWtDcmxiNTUwOXVrT0E1M3BVdVdScnJsck9SaTJIQ3hsMUtwbTJ3?=
 =?utf-8?B?b0RzZDVsZG5qaWdOUGRKZjZsQ2dOdkgzZS9RK1J0a0MzWXMyZ3ArTyt1dkg1?=
 =?utf-8?B?ZjcxaW1kQ1gwZ2FjTm1rdmFxRTFlbUdob0FvYXBnak56SXVFTDJlRDd0SU5I?=
 =?utf-8?B?NXVaNlN5bGZiYU1lakJQUzZ6eUV4NHp0cDR4TFkrM2wvZWFoVGowclZaREYw?=
 =?utf-8?B?Nm5yci9lMiszVlN0SGkvdFFhemJ3MW9DUnBwZUZQS1Z2RXU4eUZlVVU1SDN0?=
 =?utf-8?B?Z2IxS0ZwQ3BubzhVMndtWGhqd0FmcldoZlJUTC9jRFJEOUlWZ2hxeEZYUUh5?=
 =?utf-8?B?Tmo5bEQ3d3o2L2IxN3Z0anFtbXhybHBSVjZWYUdPaG1CWHdLQndpcHR2Z3FB?=
 =?utf-8?B?d3RncjJYWmxveDRCQW1Kblprd3kxWGZRdDZieDUwVlBKM1J2ejMydHFDSGVG?=
 =?utf-8?B?Z2MrTktXYjRmSzBDNTR0dmFRd1dkNVBrZ0h5WFhpcHJCdzNzZEhIbFN3SUtP?=
 =?utf-8?B?d1ZzV2xyaWFoWE5VMWgxNUpBaFlQTzNPeTNVbFg5NThBOCsxdFp0cW8zbk9K?=
 =?utf-8?B?eDVyUjBRUTlRaUpCOUNZUG1Uci9aanZzTkwydXpIV3BBdTlBa2E1REYzUE9x?=
 =?utf-8?B?VFdnNXd3bzg1VjYrbUY1bklJZUIyQWliR2syNjB6cGVVdzhTR2EwYklsUm1G?=
 =?utf-8?B?aU9MN2dMQWdTTkErT0ttSHlTc0tsZERySHJBdjBIWER3ZmJHSWVUTTMyV1Jp?=
 =?utf-8?B?VHBpV2VGcitNWjhaQkl0YVBzZlNTclYyRXhMQ3FlblF1eHZBSnd0U0NuYXVa?=
 =?utf-8?B?K3ViSFdxU2N3dXJDR2IwWno0ZzlHbkI2WnRKaWdrbkg4ZzVrMVFXMjRCWCs3?=
 =?utf-8?B?eFhGOXZOeGJXSEVLazRNRlpTZy9CRHBaaHFreVcxd1d5RWxJQ0FUQnRva0Jv?=
 =?utf-8?B?VXUybVVva2wvSGdPTEIvbyttaExCLzV3b0hqQU16LzQ0VFk2YU5Qc2YrRFd5?=
 =?utf-8?B?Wjh0cm1QTXZiNVlHeHJQVGM2QTdvSkxwbHptcmlOZUFRYWxlOVp5MlF5cndT?=
 =?utf-8?B?UjJVbFEwQkFRUVl1d3FZSTVwOU1nSWU3R2FES1Z2R3l1dlV4bGNmMzFER1BF?=
 =?utf-8?B?UUlwL2IxTzA3eUdXbHBGUkpKVnVER2ZRalFXakpHN1kwM0RVanhZUzBPZ2xF?=
 =?utf-8?B?bWxOVGtLMUpMODRCNG9SbndEemlWMGdWanNEd1V3dG54Yms0Y3V5Q1NIakIv?=
 =?utf-8?B?dSsxY0M1UE4yaEVSUVo5YlMybEFFVDU1TW9xOUZzMndQTVpZN1ZkaERIVzZw?=
 =?utf-8?B?bDFUZ2NneGRndzYvSlB6Q3RNYSt4MkRNQ2gwV0NEVWY0SitXaTNHc08wYlpP?=
 =?utf-8?B?cnc9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12c31955-ebe1-42d4-b6a3-08da7b0d741d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5481.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2022 20:18:14.0491 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pkihjijQO41GtD9US8LoGLAamiwUesCxnM4DRc3Ll21ERdAcBDbcPsveS4ARMbszrcD9nnpbEy95viFjVaJdeWe7C5ugrB3f165SB9dUpmk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3548
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-10_14,2022-08-10_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208100061
X-Proofpoint-GUID: w3MBCPm63i3D2mbU7lO7g1Jx4tZoVTBJ
X-Proofpoint-ORIG-GUID: w3MBCPm63i3D2mbU7lO7g1Jx4tZoVTBJ
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [LTP PATCH v1 1/1] syscalls/madvise11: Add some memory
 page soft-offlining control
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
Cc: ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Thank you very much Petr for your feedback.

The 2 failure cases you told me about look very different:

Fedora is failing on the cleanup phase, and I need to investigate that.
But SLE12-SP2 kernel makes the test-case fail in a way that seems to 
indicate it has a problem dealing with soft-offlined pages and may need 
some fixes.

Please let me try out Fedora 5.13.16-200.fc34.x86_64, and if you have a 
pointer where I could find it (?) that could help.

Thanks,
William.


On 10/08/2022 19:00, Petr Vorel wrote:
> Hi William,
>
> I tested your madvise11 on various x86_64 VMs and it fails on two:
>
> # ./madvise11 # Fedora 5.13.16-200.fc34.x86_64
> madvise11.c:136: TINFO: Thread [18]: allocate_offline() returned 0, succeeded.  Thread exiting
> madvise11.c:175: TPASS: soft-offline/alloc stress test finished successfully
> madvise11.c:316: TINFO: Restore 900 Soft-offlined pages
> tst_test.c:1583: TBROK: Test killed by SIGSEGV!
>
> # ./madvise11 # SLE12-SP2 4.4.21-69-default
> tst_test.c:1528: TINFO: Timeout per run is 0h 05m 30s
> madvise11.c:56: TFAIL: SIGBUS Received
>
> # strace -ff ./madvise11
> ...
> [pid  3463] mprotect(0x7fcda9ff9000, 4096, PROT_NONE) = 0
> [pid  3463] clone(child_stack=0x7fcdaa7f8ff0, flags=CLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD|CLONE_SYSVSEM|CLONE_SETTLS|CLONE_PARENT_SETTID|CLONE_CHILD_CLEARTID, parent_tidptr=0x7fcdaa7f99d0, tls=0x7fcdaa7f9700, child_tidptr=0x7fcdaa7f99d0) = 3523
> [pid  3463] futex(0x7fcdc881301c, FUTEX_WAKE, 2147483647 <unfinished ...>
> [pid  3480] <... futex resumed> )       = 0
> [pid  3480] mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_SHARED|MAP_ANONYMOUS, -1, 0) = 0x7fcdc8812000
> [pid  3480] madvise(0x7fcdc8812000, 4096, MADV_SOFT_OFFLINE <unfinished ...>
> [pid  3478] <... futex resumed> )       = 0
> [pid  3478] mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_SHARED|MAP_ANONYMOUS, -1, 0) = 0x7fcdc8811000
> [pid  3478] madvise(0x7fcdc8811000, 4096, MADV_SOFT_OFFLINE <unfinished ...>
> [pid  3476] <... futex resumed> )       = 0
> [pid  3476] mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_SHARED|MAP_ANONYMOUS, -1, 0) = 0x7fcdc8810000
> [pid  3476] madvise(0x7fcdc8810000, 4096, MADV_SOFT_OFFLINE <unfinished ...>
> [pid  3474] <... futex resumed> )       = 0
> [pid  3474] mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_SHARED|MAP_ANONYMOUS, -1, 0) = 0x7fcdc880f000
> [pid  3474] madvise(0x7fcdc880f000, 4096, MADV_SOFT_OFFLINE <unfinished ...>
> [pid  3469] <... futex resumed> )       = 0
> [pid  3469] mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_SHARED|MAP_ANONYMOUS, -1, 0) = 0x7fcdc880e000
> [pid  3469] madvise(0x7fcdc880e000, 4096, MADV_SOFT_OFFLINE <unfinished ...>
> [pid  3467] <... futex resumed> )       = 0
> [pid  3480] <... madvise resumed> )     = 0
> [pid  3480] mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_SHARED|MAP_ANONYMOUS, -1, 0) = 0x7fcdc880d000
> [pid  3480] --- SIGBUS {si_signo=SIGBUS, si_code=0x4, si_addr=0x7fcdc880d000} ---
> [pid  3480] write(2, "madvise11.c:56: \33[1;31mTFAIL: \33["..., 50madvise11.c:56: TFAIL: SIGBUS Received
> ) = 50
> [pid  3480] exit_group(7)               = ?
> [pid  3480] +++ exited with 7 +++
> [pid  3478] +++ exited with 7 +++
> [pid  3476] +++ exited with 7 +++
> [pid  3474] +++ exited with 7 +++
> [pid  3469] +++ exited with 7 +++
> [pid  3468] +++ exited with 7 +++
> [pid  3467] +++ exited with 7 +++
> [pid  3466] +++ exited with 7 +++
> [pid  3465] +++ exited with 7 +++
> strace: Exit of unknown pid 3492 ignored
> strace: Exit of unknown pid 3491 ignored
> strace: Exit of unknown pid 3489 ignored
> strace: Exit of unknown pid 3488 ignored
> strace: Exit of unknown pid 3497 ignored
> strace: Exit of unknown pid 3500 ignored
> [pid  3464] +++ exited with 7 +++
>
> I would not be too concerned about old SLE12-SP2 kernel, but at least failure on
> relatively new Fedora 34 kernel would be good to fix.
>
> Also adding .min_kver = "2.6.33" is IMHO not necessary, it's old enough
> (LTP wouldn't be even compiled on such old kernel).
>
> Kind regards,
> Petr
>
>> Stress the soft-offlining code while allocating memory to verify
>> the replaced pages use and content. If everything works fine,
>> retore all soft-offlined pages and exit.
>> Signed-off-by: William Roche <william.roche@oracle.com>
>> Acked-by: Liam Merwick <liam.merwick@oracle.com>
>> ---
>>   testcases/kernel/syscalls/madvise/.gitignore  |   1 +
>>   testcases/kernel/syscalls/madvise/Makefile    |   2 +
>>   testcases/kernel/syscalls/madvise/madvise11.c | 381 ++++++++++++++++++
>>   3 files changed, 384 insertions(+)
>>   create mode 100644 testcases/kernel/syscalls/madvise/madvise11.c
>> diff --git a/testcases/kernel/syscalls/madvise/.gitignore b/testcases/kernel/syscalls/madvise/.gitignore
>> index 002d8e5d9..6e5b92ab7 100644
>> --- a/testcases/kernel/syscalls/madvise/.gitignore
>> +++ b/testcases/kernel/syscalls/madvise/.gitignore
>> @@ -6,3 +6,4 @@
>>   /madvise08
>>   /madvise09
>>   /madvise10
>> +/madvise11
>> diff --git a/testcases/kernel/syscalls/madvise/Makefile b/testcases/kernel/syscalls/madvise/Makefile
>> index 044619fb8..78613df11 100644
>> --- a/testcases/kernel/syscalls/madvise/Makefile
>> +++ b/testcases/kernel/syscalls/madvise/Makefile
>> @@ -6,3 +6,5 @@ top_srcdir		?= ../../../..
>>   include $(top_srcdir)/include/mk/testcases.mk
>>   include $(top_srcdir)/include/mk/generic_leaf_target.mk
>> +
>> +madvise11: CFLAGS += -pthread
>> diff --git a/testcases/kernel/syscalls/madvise/madvise11.c b/testcases/kernel/syscalls/madvise/madvise11.c
>> new file mode 100644
>> index 000000000..9ea745aca
>> --- /dev/null
>> +++ b/testcases/kernel/syscalls/madvise/madvise11.c
>> @@ -0,0 +1,381 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (c) 2022 Oracle and/or its affiliates.
>> + */
>> +
>> +/*\
>> + * [Description]
>> + * Stress the VMM and soft-offline code by spawning N threads which
>> + * allocate memory pages and soft-offline them repeatedly.
>> + * Control that soft-offlined pages get correctly replaced: with the
>> + * same content and without SIGBUS generation when accessed.
>> + * Could be used for example as a regression test-case for the
>> + * poisoned soft-offlined pages case fixed by upstream commit
>> + * d4ae9916ea29 (mm: soft-offline: close the race against page allocation)
>> + */
>> +
>> +#include <stdio.h>
>> +#include <pthread.h>
>> +#include <stdlib.h>
>> +#include <unistd.h>
>> +#include <math.h>
>> +#include <assert.h>
>> +#include <errno.h>
>> +#include <stdint.h>
>> +#include <sys/types.h>
>> +#include <sys/mman.h>
>> +#include <sys/klog.h>
>> +#include <time.h>
>> +
>> +#include "tst_test.h"
>> +#include "tst_safe_pthread.h"
>> +#include "tst_safe_clocks.h"
>> +#include "tst_safe_stdio.h"
>> +#include "lapi/mmap.h"
>> +
>> +#define NUM_THREADS	60	/* Number of threads to create */
>> +#define NUM_LOOPS	 3	/* Number of loops per-thread */
>> +#define NUM_PAGES	 5	/* Max number of allocated pages for each loop */
>> +
>> +/* needed module to online back pages */
>> +#define HW_MODULE	"hwpoison_inject"
>> +
>> +static pthread_t *thread_id;		/* ptr to an array of spawned threads */
>> +static long PAGESIZE;
>> +static char beginningTag[BUFSIZ];	/* kmsg tag indicating our test start */
>> +static int hwpoison_probe = 0;		/* do we have to probe hwpoison_inject? */
>> +
>> +static void my_yield(void)
>> +{
>> +	static const struct timespec t0 = { 0, 0 };
>> +	nanosleep(&t0, NULL);
>> +}
>> +
>> +/* a SIGBUS received is a confirmation of test failure */
>> +static void sigbus_handler(int signum) {
>> +	tst_res(TFAIL, "SIGBUS Received");
>> +	_exit(signum);
>> +}
>> +
>> +/*
>> + * allocate_offline() - Allocate and offline test called per-thread
>> + *
>> + * This function does the allocation and offline by mmapping an
>> + * anonymous page and offlining it.
>> + *
>> + * Return:
>> + *  0: success
>> + *  1: failure
>> + */
>> +static int allocate_offline(int tnum)
>> +{
>> +	int loop;
>> +	const int MAXPTRS = NUM_PAGES;
>> +
>> +	for (loop = 0; loop < NUM_LOOPS; loop++) {
>> +		long *ptrs[MAXPTRS];
>> +		int num_alloc;
>> +		int i;
>> +
>> +		/* loop terminates in one of two ways:
>> +		 * 1. after MAXPTRS iterations
>> +		 * 2. if page alloc fails
>> +		 */
>> +		for (num_alloc = 0; num_alloc < MAXPTRS; num_alloc++) {
>> +
>> +			/* alloc the next page - the problem is more rapidly reproduced with MAP_SHARED */
>> +			ptrs[num_alloc] = mmap(NULL, PAGESIZE, PROT_READ|PROT_WRITE, MAP_SHARED|MAP_ANONYMOUS, -1, 0);
>> +			/* terminate loop if alloc fails */
>> +			if (!ptrs[num_alloc])
>> +				break;
>> +			/* write a uniq content */
>> +			ptrs[num_alloc][0] = num_alloc;
>> +			ptrs[num_alloc][1] = tnum;
>> +
>> +			/* soft-offline requested */
>> +			if (madvise(ptrs[num_alloc], PAGESIZE, MADV_SOFT_OFFLINE) == -1) {
>> +				if (errno != EINVAL && errno != EBUSY)
>> +					tst_res(TFAIL | TERRNO, "madvise failed");
>> +				if (errno == EINVAL)
>> +					tst_res(TCONF, "madvise() didn't support MADV_SOFT_OFFLINE");
>> +				return errno;
>> +			}
>> +		}
>> +
>> +		/* verify if the offlined pages content has changed */
>> +		for (i = 0; i < num_alloc; i++) {
>> +			if (ptrs[i][0] != i || ptrs[i][1] != tnum) {
>> +				tst_res(TFAIL,
>> +					"pid[%d] tnum[%d]: fail: bad sentinel value\n",
>> +					getpid(), tnum);
>> +				return 1;
>> +			}
>> +			munmap(ptrs[i], PAGESIZE);
>> +		}
>> +
>> +		my_yield();
>> +		if (!tst_remaining_runtime()) {
>> +			tst_res(TINFO, "Thread [%d]: Test runtime is over, exiting", tnum);
>> +			break;
>> +		}
>> +	}
>> +
>> +	/* Success! */
>> +	return 0;
>> +}
>> +
>> +static void *alloc_mem(void *threadnum)
>> +{
>> +	int err;
>> +	int tnum = (int)(uintptr_t)threadnum;
>> +
>> +	/* waiting for other threads starting */
>> +	TST_CHECKPOINT_WAIT(0);
>> +
>> +	err = allocate_offline(tnum);
>> +	tst_res(TINFO,
>> +		"Thread [%d]: allocate_offline() returned %d, %s.  Thread exiting",
>> +		tnum, err, (err ? "failed" : "succeeded"));
>> +	return (void *)(uintptr_t) (err ? -1 : 0);
>> +}
>> +
>> +static void stress_alloc_offl(void)
>> +{
>> +	struct sigaction my_sigaction;
>> +	int thread_index;
>> +	int thread_failure = 0;
>> +
>> +	/* SIGBUS is a failure criteria */
>> +	my_sigaction.sa_handler = sigbus_handler;
>> +	if (sigaction(SIGBUS, &my_sigaction, NULL) == -1)
>> +		tst_res(TFAIL | TERRNO, "Signal handler attach failed");
>> +
>> +	/* create all threads */
>> +	for (thread_index = 0; thread_index < NUM_THREADS; thread_index++) {
>> +		SAFE_PTHREAD_CREATE(&thread_id[thread_index], NULL, alloc_mem,
>> +				    (void *)(uintptr_t)thread_index);
>> +	}
>> +
>> +	/* wake up all threads */
>> +	TST_CHECKPOINT_WAKE2(0, NUM_THREADS);
>> +
>> +	/* wait for all threads to finish */
>> +	for (thread_index = 0; thread_index < NUM_THREADS; thread_index++) {
>> +		void *status;
>> +
>> +		SAFE_PTHREAD_JOIN(thread_id[thread_index], &status);
>> +		if ((intptr_t)status != 0) {
>> +			tst_res(TFAIL, "thread [%d] - exited with errors",
>> +				thread_index);
>> +			thread_failure++;
>> +		}
>> +	}
>> +
>> +	if (thread_failure == 0)
>> +		tst_res(TPASS, "soft-offline/alloc stress test finished successfully");
>> +}
>> +
>> +/*
>> + * ------------
>> + * Cleanup code:
>> + * The idea is to retrieve all the pfn numbers that have been soft-offined
>> + * (generating a "Soft offlining pfn 0x..." message in the kernel ring buffer)
>> + * by the current test (since a "beginningTag" message we write when starting).
>> + * And to put these pages back online by writing the pfn number to the
>> + * <debugfs>/hwpoison/unpoison-pfn special file.
>> + * ------------
>> + */
>> +#define OFFLINE_PATTERN "Soft offlining pfn 0x"
>> +#define OFFLINE_PATTERN_LEN sizeof(OFFLINE_PATTERN)
>> +
>> +/* return the pfn if the kmsg msg is a soft-offline indication*/
>> +static unsigned long parse_kmsg_soft_offlined_pfn(char *line, ssize_t len)
>> +{
>> +	char *pos;
>> +	unsigned long addr = 0UL;
>> +
>> +	pos = strstr(line, OFFLINE_PATTERN);
>> +	if (pos == NULL)
>> +		return 0UL;
>> +
>> +	pos += OFFLINE_PATTERN_LEN-1;
>> +	if (pos > (line + len))
>> +		return 0UL;
>> +
>> +	addr = strtoul(pos, NULL, 16);
>> +	if ((addr == ULONG_MAX) && (errno == ERANGE))
>> +		return 0UL;
>> +
>> +	return addr;
>> +}
>> +
>> +/* return the pfns seen in kernel message log */
>> +static int populate_from_klog(char* beginTag, unsigned long *pfns, int max)
>> +{
>> +	int found = 0, fd, beginningTag_found = 0;
>> +	ssize_t sz;
>> +	unsigned long pfn;
>> +	char buf[BUFSIZ];
>> +
>> +	fd = SAFE_OPEN("/dev/kmsg", O_RDONLY|O_NONBLOCK);
>> +
>> +	while (found < max) {
>> +		sz = read(fd, buf, sizeof(buf));
>> +		/* kmsg returns EPIPE if record was modified while reading */
>> +		if (sz < 0 && errno == EPIPE)
>> +			continue;
>> +		if (sz <= 0)
>> +			break;
>> +		if (!beginningTag_found) {
>> +			if (strstr(buf, beginTag))
>> +				beginningTag_found = 1;
>> +			continue;
>> +		}
>> +		pfn = parse_kmsg_soft_offlined_pfn(buf, sz);
>> +		if (pfn)
>> +			pfns[found++] = pfn;
>> +	}
>> +	SAFE_CLOSE(fd);
>> +	return found;
>> +}
>> +
>> +/*
>> + * Read the given file to search for the key.
>> + * If a valuePtr is given, copy the remaining of the line right
>> + * after the found key to the given location.
>> + * Return 1 if the key is found.
>> + */
>> +static int find_in_file(char *path, char *key, char *valuePtr)
>> +{
>> +	char line[4096];
>> +	char *pos = NULL;
>> +	int found = 0;
>> +	FILE *file = SAFE_FOPEN(path, "r");
>> +	while (fgets(line, sizeof(line), file)) {
>> +		pos = strstr(line, key);
>> +		if (pos) {
>> +			found = 1;
>> +			if (valuePtr)
>> +				strncpy(valuePtr, pos + strlen(key),
>> +					line + strlen(line) - pos);
>> +			break;
>> +		}
>> +	}
>> +	SAFE_FCLOSE(file);
>> +	return found;
>> +}
>> +
>> +static void unpoison_this_pfn(unsigned long pfn, int fd)
>> +{
>> +	char pfn_str[19]; /* unsigned long to ascii: 0x...\0 */
>> +
>> +	snprintf(pfn_str, sizeof(pfn_str), "0x%lx", pfn);
>> +	SAFE_WRITE(0, fd, pfn_str, strlen(pfn_str));
>> +}
>> +
>> +/* Find and open the <debugfs>/hwpoison/unpoison-pfn special file */
>> +static int open_unpoison_pfn(void)
>> +{
>> +	char *added_file_path = "/hwpoison/unpoison-pfn";
>> +	const char *const cmd_modprobe[] = {"modprobe", HW_MODULE, NULL};
>> +	char debugfs_fp[4096];
>> +
>> +	if (!find_in_file("/proc/modules", HW_MODULE, NULL))
>> +		hwpoison_probe = 1;
>> +
>> +	/* probe hwpoison only if it isn't already there */
>> +	if (hwpoison_probe)
>> +		SAFE_CMD(cmd_modprobe, NULL, NULL);
>> +
>> +	/* debugfs mount point */
>> +	if (find_in_file("/etc/mtab", "debugfs ", debugfs_fp) == 0)
>> +		return -1;
>> +	strcpy(strstr(debugfs_fp, " "), added_file_path);
>> +
>> +	return (SAFE_OPEN(debugfs_fp, O_WRONLY));
>> +}
>> +
>> +/*
>> + * Get all the Offlined PFNs indicated in the dmesg output
>> + * starting after the given beginning tag, and request a debugfs
>> + * hwpoison/unpoison-pfn for each of them.
>> + */
>> +static void unpoison_pfn(char* beginTag)
>> +{
>> +
>> +	/* maximum of pages to deal with */
>> +	const int MAXPFN = NUM_THREADS*NUM_LOOPS*NUM_PAGES;
>> +	unsigned long pfns[MAXPFN];
>> +	const char *const cmd_rmmod[] = {"rmmod", HW_MODULE, NULL};
>> +	int found_pfns, fd;
>> +
>> +	fd = open_unpoison_pfn();
>> +	if (fd >= 0) {
>> +		found_pfns = populate_from_klog(beginTag, pfns, MAXPFN);
>> +
>> +		tst_res(TINFO,"Restore %d Soft-offlined pages", found_pfns);
>> +		/* unpoison in reverse order */
>> +		while (found_pfns-- > 0)
>> +			unpoison_this_pfn(pfns[found_pfns], fd);
>> +
>> +		SAFE_CLOSE(fd);
>> +	}
>> +	/* remove hwpoison only if we probed it */
>> +	if (hwpoison_probe)
>> +		SAFE_CMD(cmd_rmmod, NULL, NULL);
>> +}
>> +
>> +/*
>> + * Create and write a beginning tag to the kernel buffer to be used on cleanup
>> + * when trying to restore the soft-offlined pages of our test run.
>> + */
>> +static void write_beginningTag_to_kmsg(void)
>> +{
>> +	int fd;
>> +
>> +	fd = SAFE_OPEN("/dev/kmsg", O_WRONLY);
>> +	if (fd < 0) {
>> +		tst_res(TCONF | TERRNO,"/dev/kmsg not available for writing");
>> +		return;
>> +	}
>> +	snprintf(beginningTag, sizeof(beginningTag),
>> +		 "Soft-offlining pages test starting (pid: %ld)",
>> +		 (long)getpid());
>> +	SAFE_WRITE(1, fd, beginningTag, strlen(beginningTag));
>> +	SAFE_CLOSE(fd);
>> +}
>> +
>> +static void setup(void)
>> +{
>> +	thread_id = SAFE_MALLOC(sizeof(pthread_t) * NUM_THREADS);
>> +	PAGESIZE = sysconf(_SC_PAGESIZE);
>> +	write_beginningTag_to_kmsg();
>> +}
>> +
>> +static void cleanup(void)
>> +{
>> +	if (thread_id) {
>> +		free(thread_id);
>> +		thread_id = NULL;
>> +	}
>> +	unpoison_pfn(beginningTag);
>> +}
>> +
>> +static struct tst_test test = {
>> +	.min_kver = "2.6.33",
>> +	.needs_root = 1,
>> +	.needs_drivers = (const char *const []) {
>> +		HW_MODULE,
>> +		NULL
>> +	},
>> +	.needs_cmds = (const char *[]) {
>> +		"modprobe",
>> +		"rmmod",
>> +		NULL
>> +	},
>> +	.max_runtime = 300,
>> +	.needs_checkpoints = 1,
>> +	.setup = setup,
>> +	.cleanup = cleanup,
>> +	.test_all = stress_alloc_offl,
>> +};

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
