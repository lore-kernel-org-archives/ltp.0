Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3C16C67861
	for <ltp@archiver.kernel.org>; Mon,  8 Apr 2024 21:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1712613053; h=message-id :
 date : to : references : in-reply-to : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=99yPLcJhZUvdfRrZSIxq28nejvjDj6NRKs3LJh0g8jQ=;
 b=NcxsnEk/9Y1XPhnChoNhVFlcfbSLJVouzCmCuJ3eYOy3+X/USL44YHFoYS+iroYS1JiBO
 OG7y/M7MFdrcWNYuaMNYN7TXHNP8e6XuZADO+zS1Z8l3PDTnu/iW1XQnfC0SscDWNKl8aXp
 OaVhVycXa18nl5gt1Imy437p/DISPZA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 90AB03CF5FB
	for <ltp@archiver.kernel.org>; Mon,  8 Apr 2024 23:50:53 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 98BAA3C0F52
 for <ltp@lists.linux.it>; Mon,  8 Apr 2024 23:50:30 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=oracle.com (client-ip=205.220.165.32;
 helo=mx0a-00069f02.pphosted.com;
 envelope-from=samasth.norway.ananda@oracle.com; receiver=lists.linux.it)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 18FBE1A00FD2
 for <ltp@lists.linux.it>; Mon,  8 Apr 2024 23:50:26 +0200 (CEST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 438LnMwH007098; Mon, 8 Apr 2024 21:50:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=V/eYDCyIm3CrfnwxH07owwPznqqqi5ogNpYXCnfe0Pg=;
 b=BjzXLRG6bFKTGb0+Qt7/IjtsCbJLasY2EDFYBP+qfTmZfj8Ur4j3Q5yY6sSjFfSVllOj
 YKKrqZtXPqjuUuNt2SyibhWQdfklxF1Cv7SIS7DCQaGIVongu+vMmMV+JNa7zmu3ErZY
 qCB/M553mZX9iQGyKxKAhtRjUGnrdkslz8BTF3rtGnid4GE5TolycCDXymKspP+0ntDD
 Z6VWCESLoH+CSrDnlmChIGl2hG28XvUEUpjBhlpZUpPLca027GC5kPuBJTE26YynRCFn
 QWYVoYudRNJkj5NBImlQyqjXsv42pMazT+Q8MRRUqR94GXjpdahE2PzBchMmhsu+tLVP Mw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xaxxvbr69-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 08 Apr 2024 21:50:24 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 438LBuKb040040; Mon, 8 Apr 2024 21:50:22 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3xavucajt8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 08 Apr 2024 21:50:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PcNTj330N322SzCiFC4KsgDe230ckYe+C31as2R3CKx5ShcoG7qXE7obYFqKN8HWRyGPYCgl7U+RzRC0aIVHtoV1Cqbwq9x8dKy62mMhbzzgCsg6u070gCK5M0j3x8/sjzk+Om6/SdpuTG0gUlMc8hJJ54ZlCpQ0N4yjL8DnLocm4JwPsBB116CGoFnZgV4bJdt9PBXm1LzqbxitqT/hC2/o1uNLEx8L389NNSsvua5QR9CEmtwzb6fgujj3+QAgGfExKGC8GuQU8E/BiKw/f/1IHRUS1pKp5Vr1nq/zwlVrhQT9Hk/qmKVhsueNllhJX1ORm2697Blk2/0Ow2c0zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V/eYDCyIm3CrfnwxH07owwPznqqqi5ogNpYXCnfe0Pg=;
 b=HC+FjGDVSzYcuxXbagICC4khOd9KuXhrYxQPPmOwPLKJgGPtdsucFLVwfhAJdimk0tlZ9PKM7F47ynx9c9vuTRQh9cG92CPzjpjRLpTJ/WXy4EQ849dIqytTmw31qtteJicNVkNWwm7aPZG7n7ozzen3wLlFotKaSiPzJ7HogDjtkI8QGYd1Lt0ysIqpl61Z50+3wqkV6RjfyGmo3wPFj+AzzlmNcYId2YVeqoLHcMbGTzKLNMPsy5iH4deDT9Q4+/aH3xdiX9AY4+pJm1qvdEuaE7x2i+7GOTSQv1A7hfQ2VCmsLd3knespw/L7QBm39htD2ow7VO37nI1CFcKMBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V/eYDCyIm3CrfnwxH07owwPznqqqi5ogNpYXCnfe0Pg=;
 b=K5BqjSnpTcPpYBJxhIv1BHi3bdt99nLfXjowaXJ8nslXDlCVwxTUfEj2/iEyZwLCTeBOE2kZjezbV/CyVZPjQV4IRMRK9ZNQ4+DY3byVVYLTpSVL5p6o4B4vSSRghwCtDlRMq3uNiY7NlyE86ZrChOKla0nvelotLxDRAopoPlM=
Received: from DM6PR10MB3817.namprd10.prod.outlook.com (2603:10b6:5:1fd::22)
 by SA1PR10MB5760.namprd10.prod.outlook.com (2603:10b6:806:23f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 8 Apr
 2024 21:50:20 +0000
Received: from DM6PR10MB3817.namprd10.prod.outlook.com
 ([fe80::d1b7:21b3:9974:8ac8]) by DM6PR10MB3817.namprd10.prod.outlook.com
 ([fe80::d1b7:21b3:9974:8ac8%7]) with mapi id 15.20.7409.053; Mon, 8 Apr 2024
 21:50:20 +0000
Message-ID: <e2368059-647c-4d98-8c90-2cc5f3bb34a4@oracle.com>
Date: Mon, 8 Apr 2024 14:50:16 -0700
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>
References: <20240401150015.301640-1-samasth.norway.ananda@oracle.com>
 <Zg_oLGuLcssY-rYY@yuki>
Content-Language: en-US
In-Reply-To: <Zg_oLGuLcssY-rYY@yuki>
X-ClientProxiedBy: MN2PR01CA0028.prod.exchangelabs.com (2603:10b6:208:10c::41)
 To DM6PR10MB3817.namprd10.prod.outlook.com
 (2603:10b6:5:1fd::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3817:EE_|SA1PR10MB5760:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dYneZgTsKPyASEav5Q3oo4HTmy6xRsYyl8schcS5U2cqWE//fEqm/kvFzJkoRZz7GegkmQgyHAAfY2DMAuaX4DuzspTNE6+nxaJp8kbpKm1WftMQznKWU/WGMHzKyhkg1/hYkbgRzeeXonm+iZw0XqjFs1LKiK+wkLRlR7VgWaR/3AnBFzlU82HmTrpEkSBqlehZ8mHiF5XYEtTZBmi2RPkXjh67nOCwm6rK0IIETX/c6vWx8QxI7ccDaShZ17n2wD66t1mscIKF2os5D9xYVt3zs2xpDQCIGKjxvWq+iWhFJoKntXySf7fH1jLbBR76UhDB1HK9ABlTksZ9JWTHiBD68AlignhEdHEGxBB/bOwn3q7lGxYdl4zMEsw9XxtFoJ579NsWpKmXJJBVEoamerK30Jv+iPzbeYEXveZLl6rlvnFNdZ7/VrKT2RQ/a4042IHkvtXfnl378X0mfMZkN1bxdGmKOZryrIPftp3EeLK7dZH9iWQFS2T9KaPMGqftZytsXQxkS2kmA+Zl9eILT7uAWjrq0YoLb+IeUjIWLE90YBkTBakP43x+8ngKCnlEP7ME9mplY1b7G8kWapcuVzBHRf9li81Kz8symqDIKbQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR10MB3817.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVBKRy91R2hxQUdHTllOMnYvcnhvSkV1aGQ5ek5BWmk2bDErUXNmcDBVczNB?=
 =?utf-8?B?bVhKaW9pUUp6NHJEU1d0eW5wdWN6SkhqNWtnbkR1OFRNczJ5UXM3Z3hldGF6?=
 =?utf-8?B?S1ZoLzV0cGFZVUdKeFlHd3ZhNWZ0RUl0eC83dmdVOWJIUTdSL3VmblpyWWtt?=
 =?utf-8?B?bzk5eVVJMXpoL3pMSkFNdGJTdlJPbnZXSXBaL21FNTNLMFNIcXpmaS9FTjlm?=
 =?utf-8?B?aHJzdElLV1BacXZVSUZkeVprM3lnYXFvcVJOY1dUUFJaU3FHU3d2QXB6Zi9h?=
 =?utf-8?B?MXFURkd1RGdLc0g5QTUzdVhNOCtnZW1TSlQ0RkRMUEljRWFFdElnbkNwb2Nx?=
 =?utf-8?B?UkE3aHF3NHlnUis3QTd1Q0o3S2RCRWZWODl3NG1FWHh0OXRkVFo3dFhwTHZw?=
 =?utf-8?B?K2FsSXJvOWZ4T3pqakVUdjgvN21CUkRTaWJQTVdoOWtValY1SW1NN0tmelYw?=
 =?utf-8?B?Rk0rc25hMXFSWmhZMk03Qk1GdWZ1UTV2bytvNE5sNWV2dFBhSDh0WmViUG9l?=
 =?utf-8?B?VDVEK041Vi8za2V1Sk9pTmJ1SnFQNlRzQjlTTk1Qd1JPOHRiSHNuS3dITnRE?=
 =?utf-8?B?c3E2VVJET3VsV3YrcnVXOUREQTVCVHJZV1dWVzBNK1Z1TkZta3duSkVoQUw2?=
 =?utf-8?B?dldFWE0renl6dE5QMjdWUEdxa1ByNC8rL1RsTG9PK3JGT2Q3TWtNN2t4Witr?=
 =?utf-8?B?dVVrQU9peDdwNWQ4akN0a0NwR2Rwb2hDVlpIVUk5Ykp6dXVqMjU0NGdVdTlD?=
 =?utf-8?B?eUpLVlVRVWVLbWphTWJEd2J6VzZrbzhrNm1oTWt6UWhMU2x1SWhqY29FSHg5?=
 =?utf-8?B?OC9HckVCU2Z6dHhkbkFRM3gyT04zTzNkZHBsWkFKeVp4d2RqN1d2T2lJU2F2?=
 =?utf-8?B?MEJ6K25KRUQyTXJKMy9UWHpoeFBHd2tnclZOWjdpczlDbVErZHNBVVBUNWNU?=
 =?utf-8?B?bmFUKy9LVElKd1R2VHo5K1lFWWhOdzlVOVE3UnR1b01UUHhjNnRNakFKcjJ4?=
 =?utf-8?B?YmhKOGxCcUllcWRwQVNEL0dLRW0wSEhxdjF1eVAyQUQ5MjMvcnVpa2tBYWF5?=
 =?utf-8?B?WDRRUFFjWVJZQzUyMENiQ0Y1aU1saGJTZFVPaEVNWExpQ3lBWWg4WTBrd0g1?=
 =?utf-8?B?bG5mN2ZZSjF0QVcvdmp4WG50MWZDYzAvY3A2UVRlQmNFdnR5VFFQQ0l0YnRm?=
 =?utf-8?B?Sk9pcFhIVUgrOE9YRVRRdjFXS0xCSHBOMlRyNzBnRkcxTGFPUHp4VzZIZVFl?=
 =?utf-8?B?YlZHTFZtZ1ZSdTU5enBDRzRYc1ZYdWhmK2Y4SXl2bzArVkM2ZnhzZS8wdU05?=
 =?utf-8?B?dGNZRHVSWTg3aER0V21lY2lmY0xWbTE5RDRXZ2p3eWd4V1ZtUEkxMWl2NXhD?=
 =?utf-8?B?dndQMDVrcFJ5NUZlUDJrWnptbFlCc1VaTGkrN2NLRE5aSXFDdjNTRTBadVZC?=
 =?utf-8?B?STA3bWV4WkV1eDJvaWdzN3VqU2R1cVduSjdnMEU3ZDg2K3ZvVmJrQnJDNDlI?=
 =?utf-8?B?bjE2alYvb0VycU5kb2t0WW9xMENYRFEzZ2dHN1U4ei9rODE4YWN3UWY4TDNs?=
 =?utf-8?B?RWYxb0RPQm9Bcjkwa0daaFg4QzhHL21EQmU1VVExeWk2Y24yV0k2TzBwWTJU?=
 =?utf-8?B?MllHZjhHaDEwVTlOaDl0MHo1ZDRjMUJ1SmdDVi9VQ1k2TVlJa3doVWxodGRS?=
 =?utf-8?B?dG5la1hmWmQ4anMrdEN5dVdiRVFKbWU4VXdyaUJ0VzJ2YkhrTSsxSGQ0OU9S?=
 =?utf-8?B?VkNjbnBUYWt2MDM4Q1dRNVhwWVFya2s1eDZ0YVRGVHM3cEMyenZLNW03b25G?=
 =?utf-8?B?TklUekxmRUNWVG15NFRGSE9tODZoUC9LdXErcTRoMS91U24xN2dOUTM4RVYz?=
 =?utf-8?B?eE90bFVoL3I3Z0VXSlYrYU5SWUNKNUNiM1ZZZnJ5RlNDcW94bUNZOU9IYnJK?=
 =?utf-8?B?dG9UR0tHU2hWaWdUY3ZZZG9YOExwRk5tamhUc054WEoxditWa0lsN0RaTUlh?=
 =?utf-8?B?TVFxMXA1aFB5L1U4WjZQL29wc29Eb3hETXQybVkxeHVrNW9wMHdOcG50NlZk?=
 =?utf-8?B?SGdmYzVEZHBJeFdGMHhQYlAwZUtHS0NFYmVZZ1Q1eHJCamU1dFBiZGNFaUlU?=
 =?utf-8?B?N0xXVkVMS3FxSGtlTVAzdVZqYkl5L1Q4TXdKeDNCN1Q1RnB1WllpWEFKKyty?=
 =?utf-8?B?dUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: QpMMwwyI6LMxyEhXBJAAOGZ8ZSbVtlMhfeD0oKJ2G2IKvErUuWivPNz33iBKjZmK603nYe3ZuI1vD/87sYU895JDKCSVyNEF/9FvmxwBL+yOX0Fyed1jZRtxvvEpmORAQSmkzH+AWCkyZtRZcqGwXjSJmUkCfNQpGtoT2CUyaujFD2GDVw3C/laH4ZKUW3y+BcOul7z2UvufTNeXZsLOdzI+jYfn+MUSa5YL9IpidlCrJchNRM1iF+bB1vyuvSKnCTdjeBQitDrB9sM6RPuXixt+4baMZk3dPXjQ2A4//oSsx+t175u0MG8XrQ6dscpG/RUvyn8qjFgzlcJDzs700dl2QO4xUcBZtNX+kSRuUXIFPidVVTDfNpWH182hTbgeGiVUTyocLeFks7h5z7qAD0lIiyOTQ1I+S7GtRrOz6ME/fPogP06i6HSssD7jnjXyzawUFVSaOC70NJbFkKDwT6WK56WRSNFx0lZRVaZQy7NID7TLqZMk4ZBVyxPjaAX7Nb/AnTw+67Mv14Hduajr9jcc6OJz3YvbZ1kprGExmzySf7ULdIwft31Q5bBf6bZ80i7zpLjwI4KfejEI+/YYAo6fZRYGZlCt6KqjoyLLbDE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b53b8098-1c32-403a-0d61-08dc5815e2e2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3817.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 21:50:20.5311 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pWzpJ+vIbBOZVceqEDcovB5ndEhyYSrzbzIGWQlIOjRGle7HLgH+bqwaGRFtgq9x44P9ojEAZwh/bPrIn+2qCsfZqj2O46g0/1Og/vm18EzrpiKCeWzQ/dbJ7RiTKnMA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5760
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-08_17,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxscore=0 mlxlogscore=999
 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404080167
X-Proofpoint-ORIG-GUID: UfPkceQIDn8BixeTFKfbzIbj5ywctpOz
X-Proofpoint-GUID: UfPkceQIDn8BixeTFKfbzIbj5ywctpOz
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] mremap06: fallocate is not supported on nfsv3
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
From: Samasth via ltp <ltp@lists.linux.it>
Reply-To: samasth.norway.ananda@oracle.com
Cc: calum.mackay@oracle.com, ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>



On 4/5/24 5:01 AM, Cyril Hrubis wrote:
> Hi!
>> The function fallocate() is not supported on nfsv3. Thus when we run the
>> mremap06 test over a nfsv3 filesystem the test fails.
> 
> Can we rather than this just skip the test on nfsv3?
> 
> If we want to skip the test on nfs in generall we can just set
> .skip_filesystems = {"nfs", NULL} in the tst_test structure.
> 
> I'm not sure if we can easily detect the nfs version. The test library
> does that by checking the NFS_SUPER_MAGIC againts stat, but there is a
> single SUPER_MAGIC for all nfs versions.
> 
> So if we want to keep the test enabled for nfsv4 we can exit with TCONF
> when the call fails only when we are on NFS with tst_fs_type() and check
> that against TST_NFS_MAGIC.
> 

Hi Cyril,

Wanted to mention that fallocate() is only supported over NFSv4.2 in 
particular. it's not supported over NFSv3, v4.0 or v4.1.
I could even see on the fallocate ltp tests that it is handled the same 
manner.

Thanks,
Samasth.

>> Signed-off-by: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
>> ---
>>   testcases/kernel/syscalls/mremap/mremap06.c | 8 +++++++-
>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/testcases/kernel/syscalls/mremap/mremap06.c b/testcases/kernel/syscalls/mremap/mremap06.c
>> index 3bbaf441a..362b03e19 100644
>> --- a/testcases/kernel/syscalls/mremap/mremap06.c
>> +++ b/testcases/kernel/syscalls/mremap/mremap06.c
>> @@ -104,8 +104,14 @@ static void setup(void)
>>   	fd = SAFE_OPEN("testfile", O_CREAT | O_RDWR | O_TRUNC, 0600);
>>   
>>   	ret = fallocate(fd, 0, 0, mmap_size);
>> -	if (ret == -1)
>> +	if (ret != 0) {
>> +		if (errno == EOPNOTSUPP || errno == ENOSYS) {
>> +			tst_brk(TCONF,
>> +				"fallocate system call is not implemented");
>> +		}
>>   		tst_brk(TBROK, "fallocate() failed");
>> +		return;
> 
> The return shouldn't be here, tst_brk() does not return.
> 
>> +	}
>>   
>>   	buf = SAFE_MMAP(0, mmap_size, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
>>   
>> -- 
>> 2.43.0
>>
>>
>> -- 
>> Mailing list info: https://lists.linux.it/listinfo/ltp
> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
