Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D78EDC7EE31
	for <ltp@archiver.kernel.org>; Fri, 27 Jun 2025 03:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1750994050; h=message-id :
 date : to : references : in-reply-to : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=WGmWsnk/dwuiovMEQS+fHRIvgAhRxiROJgp8RmcEL84=;
 b=dHS3QctHAnu0fnY1U95FC8DlJ84dgH7dDNQH1dX/uTgxt8SBKqtwRSGEbRENsKfTo+NjO
 NVfcxFjVOKVoj0UJwAE+Nw3iqEfBBmCD+Tl2xk+5mVW1vpmP14WhTTDSMUAd/6IZC7+2JpM
 lVXnAyVPcv7Pn44/mVTBq7xBNF6VeuM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EE8A33C6BA8
	for <ltp@archiver.kernel.org>; Fri, 27 Jun 2025 05:14:09 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 49E243C1A25
 for <ltp@lists.linux.it>; Fri, 27 Jun 2025 05:13:48 +0200 (CEST)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id AD277600786
 for <ltp@lists.linux.it>; Fri, 27 Jun 2025 05:13:45 +0200 (CEST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55QFtles000980;
 Fri, 27 Jun 2025 03:13:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=ty9qD8XJSXxSNa1Xex2mzw4e+AK0zw59eowl9d4Jgw0=; b=
 Eq8vaQvssJPbzwMPinAHWyAlKD/moeBNGs9nD/ptdTDl5/7LOuYbNEJMoR26BuRt
 3yrf0Nq2fVGtnyJPF4B/2izuVgiIqZpc2gLTBPmyL1Z3c+UbbwViayZPt4IQnLSg
 M8y4lXURhWYUpu+eXSLlABJkJFRS+k/l4guqkhpPxdhI7XNJ87NmXpwoKFkwehb5
 QmN45PZfEKLuTbcVginfXihKxSeOIjI4RogVrvpOBDTLRL/7BSLAZUI3asLwHFA+
 DRDYJihmGX4YgXbSx/wDdtMSF+0PLc+nqW/m1xLhModhfvoPOH8jnYVtVQkNUYXM
 wfyWLj17D7zBpaeotDWvWg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ds7v36y6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 27 Jun 2025 03:13:43 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 55R3AplH002592; Fri, 27 Jun 2025 03:13:42 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 47h0gvrbwq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 27 Jun 2025 03:13:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lw/yLVFTkIFwvtBqsj67CQTr1C8hxsaYDaM5fXWrHSgYnN8IR27rsUoCG2vQCwkJJlSzDQBYxUwmvAThtX5Kg5BbnUvBlLa5FNU65rTIb4AzaGeCV8fk4s5DBIP1kZtA/Tj4NTViZSOASYS3BfI8iXNSkdq5aCExzmHpudPePVlVxjCxMoc7Oq5pJ4oeJdOQNxds9lHKgh+Ic2WtxgDJJI+/xw4DrfgRq7i8IuJGyqkdJFGFY6mL+d+KdrVppYWZRomuyjtStBKrzt+1PPBoiEAMeAcHnFDkxr7wGf4gOKFt3shkE+dpVJ1QHT1QUGSlWnDQFDjofdp5YYobz7GdWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ty9qD8XJSXxSNa1Xex2mzw4e+AK0zw59eowl9d4Jgw0=;
 b=d1K5s6QCfKHDRaoJCZB4P/ON/5kYxBSdu0ES6M0EdmY8WAXfY/MHLSUFKL2l/JuNmNRgHpYXA1iqSV+n/hxTis5svxAavzTbXVHYyFyI/oHIZMw3XOrNEOSomEEYx9Tg5zx78yMQKWPtuOlFL5sdg0JbAX7L+9+7Dp3Orfspn8utngdzzOW2YhaDdLzgnk1oSMLRn0NI1yIqBk/iWdoPesuNNsBqxVq0q/Xq2/wPobHpZxlJDKncOLlqZJTU2CxHdMMDBS2DcmHTwImlbcJvXc3CBStZDWuK0OtvWOkXNiBSg2wmQAMtrKNqBlEsAq24BH1v3eO7oIV8OC5yhe8Qlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ty9qD8XJSXxSNa1Xex2mzw4e+AK0zw59eowl9d4Jgw0=;
 b=SZcedVjLs6C72MgrtZN6N5lXxe1Xs4z7Oc0pIDfzFSWCfbJR4APh6+KrO/CCE0JAdFtFyfsLgPmUUH8MUn1zyYP25tZHkZ1UaRKmndkQg5D20N+ZIYuLor7k9G4k/RNHEZKMmzLgdY0fSji9+Vv8qrxcrWdy8/52KqGqgc9Ahik=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by CH2PR10MB4376.namprd10.prod.outlook.com (2603:10b6:610:a7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.30; Fri, 27 Jun
 2025 03:13:39 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%5]) with mapi id 15.20.8880.015; Fri, 27 Jun 2025
 03:13:38 +0000
Message-ID: <94bce2af-8b36-4846-959a-3a2a798b2a59@oracle.com>
Date: Fri, 27 Jun 2025 08:43:31 +0530
User-Agent: Mozilla Thunderbird
To: Mike Tipton <mike.tipton@oss.qualcomm.com>, ltp@lists.linux.it
References: <20250626194707.3053036-1-mike.tipton@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250626194707.3053036-1-mike.tipton@oss.qualcomm.com>
X-ClientProxiedBy: MA0PR01CA0119.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:11d::19) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|CH2PR10MB4376:EE_
X-MS-Office365-Filtering-Correlation-Id: d26c29e9-5d35-4f6a-32a0-08ddb5289c66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZXF1d0djRTJzZ0FJaDZxN2pnbzVrVlVqbHg2aW9KRVRCS3lubTZwU1RYcnBL?=
 =?utf-8?B?OVQ4QVNMeWVVQlRhWU1lNW5uamFzZU5kRThlcDdINzNrTmRzY1I3aTkrK29D?=
 =?utf-8?B?MmJDc2pGUzBsVmE3Zlo3L3kvU2lOd2VYby90QURvWUJXWVZUMkh0ZkJmbThD?=
 =?utf-8?B?Rjl6eHMzSTNpa0NQMkliM3NQdnlyZ3FIcmxhZ3ZQMXRHOE8zeHNoNDQ1NVdE?=
 =?utf-8?B?VkU3clBpZ1pQVG9qczQwbVpiUytMeGhjclRpdnI0ZEZIb2NuSndsZjR3THlH?=
 =?utf-8?B?VitqYW1UQ3I0UHkzM0RJNUN1c1RtcDdnWUhLQjNEbW91RWM0RThOMitHT1Bm?=
 =?utf-8?B?Tmp5dnEvSXRVTWszTC9xMFJQWDZpbkp6ckt5VEJmaGFKUjRzWmVVRW9jeC9H?=
 =?utf-8?B?SFFnZXpiak1EZlZPUXR5UzV5dVJjNStvME4wbDZRTm41ZDNvMGp0QVgyNEZt?=
 =?utf-8?B?OVA0Ri9iY0JMcmpoaWRMbnFaQXhRNDUwNXB6clgrS0dLVkdvUEJXT3YwaDl5?=
 =?utf-8?B?Z3E4TkRpQ1JUaEkxVE1EdVpOODNYcGk4RlNKMDV6MFVWZm5FQWhKVS9tWFpS?=
 =?utf-8?B?bHg1SUQ3MHZRdUZDK0ltUVAyc0R5VXhQWWNuUFV2MlUzbWIwRkg5aCtnZFhB?=
 =?utf-8?B?Ym0vQ2U1NjAvdXJJYXRITXpobkkxR1FBcnhIVU9yUFE5SGtveTcyYTRTU3BO?=
 =?utf-8?B?dnFURko2RFc3bWRaaXZRNDlzZmNFdmpwT0svNWdwSVowOCtiVDFXWEwxYUVo?=
 =?utf-8?B?N1ZoVllpdVJSTlA0cEJNODNIcWYybXhHYVNBRllGVjh2SlA4dWFuQUxoRG40?=
 =?utf-8?B?aVVGblNzakY4TVRvQitFNGlqU2l2OGVISHJ4SEhXOWJ1MCtScisrQUpqZTk2?=
 =?utf-8?B?VWJ4M08xbFkvMzEwYytBQ3NVWDcvaVVJaVVUTlVmZ1FiSkpQWmJtdjh1Tm9D?=
 =?utf-8?B?b2FqWkpuUDZ5ZjROTjZLbmx4ekI1UXFaSFBTL2pUMWlndWxYRDhjRjJMZS9S?=
 =?utf-8?B?TzJwWG9mYVhueXZuRVJLckhRSzBsVWhxd1lZYXd0WjNFRHdIK0lMWWpCek9s?=
 =?utf-8?B?Rkw1ODNTSDNxb1RuREFVUXkwV3FyUnlUbGJCVUI5Y3k1YkJTTG41L2k3NXZQ?=
 =?utf-8?B?RXh4b1prSVZMWHJWa2xKR1dMVUhUZmcxbTVPczJtaGhEaU5vd0pyNUxFNWFr?=
 =?utf-8?B?ZlNGQXNNa0hOS29LMTdJMW1qZ3RqY0wxQWJxQjA2QTFFSU0yMzg2VVFEVXhQ?=
 =?utf-8?B?NWVUcEpWMGVOSktrK3NLYyt1OWRTN3BPY3JTVE1zZ3B6bms2ckV3U1ZQU0hX?=
 =?utf-8?B?NzhxbUROT0c3emdpU1h3c1ZxNHpRQUdHZGoybjBjdXdKdGMvSDVjQnNJMktx?=
 =?utf-8?B?OHhRdzVzaEtIZXoxZEV3UWg2cExLUEFvbk5QZERVMGhlT09MSEdQUDV5RVd6?=
 =?utf-8?B?ell5dzNiRW85UVJleHN5NjVhTXp0MzRVSG9rNm83My9GY1JNS3E0MnVWQm1h?=
 =?utf-8?B?L3YvbGxQZVZkUnpmSVd2clBaanZoeGhoTVhPZlBla2o4M0VETVdqbmpFRU5P?=
 =?utf-8?B?WUdBcUUrdXVWT2cxZGxrYWNJSDdaV1R3VEFCUTRPSjJsaStTSElJVndGSWV0?=
 =?utf-8?B?RXJEdXduK1hRMGJLdi9aYThjdStQQWhWakJKOFJXTHpHVnE0UUNHRDJpbVVu?=
 =?utf-8?B?dDBUOW1MR1Z6ZTNjV2hqRFpEOFhIdEpPMkFjL1FjL003M041OXBYN2dFM1Nx?=
 =?utf-8?B?N2lsbGR2UXRBNFY2VWtVVnZnT01SWTdzaXU4UVZHZFRRSHp3SjFFYnhHU0xt?=
 =?utf-8?B?eWVWZXV0YnBQbTZFRjBMcjd6c1pPN3NBTFhUa0lqM2pLMHkzTG5qeS9YbWsr?=
 =?utf-8?B?YXlYMmFmTExwSFBiRWF2V2xOTk1IYllCUmFUdFM2R09EVkI2VHFqRGtWU3RM?=
 =?utf-8?Q?c/y8ppkwn0s=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR10MB5328.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d1dBd3czaWUrY3Y3MGlNOWhVaWdkWVRRSEgxK3drWTUvd0d0b2ZqWFVCOS9G?=
 =?utf-8?B?MHBBM05HcjBqK2NKeDhXbzVyNHdCTTRaSW5VQTN0YW5zT3QvNVFyYUZ1SUZF?=
 =?utf-8?B?TmtSVU9MTUJUUWkzRDlMM2luOHIvaXh2Sks1TjZHSktzYVI3bjJOZVcxVWtT?=
 =?utf-8?B?SUZ3eXRYWXd6d1ZoSjVXOGtTZVZGVGZya3FRbHE1WU45bFV5QVdmRnRVY0c5?=
 =?utf-8?B?K1NoRjM1WHRSV3UwS3VVdVJlenkwNG9PQ0NZUTljT2tnUkNxQ2pHK0RVdHRs?=
 =?utf-8?B?SVZDczhlenVBczR5Z281V1JMT2xTZkg0bVl5Zjd5QjUwSWp4RUd6L243Z1BG?=
 =?utf-8?B?MGNBd3JZeHhscEdQeXlRQUlBUEZObjNjL09WOEdzbjJDc081K2V4SWIxNVZQ?=
 =?utf-8?B?eHJNS2VuWm1IQ2FCQ1I1a2lMNDNLRkx1Y2FmQ0xxK1QwUGx0UER0SmJnVDlv?=
 =?utf-8?B?dWxtaGNBbnQramFLTDJuUkwyc29ZRy9OV1lsUTlQRzVtaFQyQXdOZXJxTEZS?=
 =?utf-8?B?Vm5pajhickRFakFSVWNuem56NUtuL3hMMFNScXo0VWVJUFNUM21ueFpDd0xk?=
 =?utf-8?B?akJLSXduUno1S2FaSVJuYVZpV255YTl4cENMelhWbGNOZUEwdW91bk1ueit1?=
 =?utf-8?B?U1EvSitmeFo4bkhzOVNOU2ppUmhvSDVZdEFLUEFhb1E4L1NtOFo5cjd4SzFR?=
 =?utf-8?B?T2gyd2JXT1FYQm9FZ3JGZVpNdjlDTXJlVEQ0NUxrS1NuQVdBaU8wdVc5U1hq?=
 =?utf-8?B?RlJMQjhpcXk2M3dmV044SU1ES084Nk96cUxCWS9iQUd1SHY2WEpNTGxVSk5w?=
 =?utf-8?B?dU5kdEZhVzNEbW40MU1YWEs1M1Ywd3JMdk5za0VnMWNLc0pERTBvRjZiUXBh?=
 =?utf-8?B?bHNzVUJsbERuZUFESGdpaDlVM0YreHZiRUFlZFNNMUJhaTBhVm1ZMmpmdk5Y?=
 =?utf-8?B?ZlA3Y21yM3dZakRRck40QkFwMUpWZkFRS3EvRHpxOEFIMC9Ra25yUnQrbDUv?=
 =?utf-8?B?cm9qQW5vRFhJaDRHVTc0RWFKeFVqdWF1eWFhaVV2K2hKYU81SjVGVzFQVzFB?=
 =?utf-8?B?VnM4WGJOU3d3RlV2TThUZXppQmJVZEhiZ2psR0xjNVlJeW04S3lHSE1pbGEr?=
 =?utf-8?B?WTAxNFcvUUxaMnBoMHFVaVhHVnpoN2JKM1hSVzR5SFJTcFhGNkY3bmxnYzY3?=
 =?utf-8?B?eFBESms2OXFRS2ZoNHZhSHhzWThScVV5TWxrSDdOTlZiMWtMZFhWZWxxRitJ?=
 =?utf-8?B?a0tON1lodk5xQ2ZqaStaaHkrWTJTNHFkaGpzYktUT2JQYnFITFQ5ZzlrWHU5?=
 =?utf-8?B?eDcrS1BaLzlYSWQ2MzFjV0l3bDNWQzNLTUJPd0FoYjZmMzhaM1BrM0gvcGts?=
 =?utf-8?B?bytpNWx2eDBDcTczSXdGRGRVS214QkY3b1dCdlVzYk5hbTlmd3BUR3dqS1BP?=
 =?utf-8?B?TXdLRkR6NUNZZUVKZkNxVkVBT3RQVjBnM2xXem8zMmRNY3pxQ1hkY3o4WWZI?=
 =?utf-8?B?a2hYamhGWGF1Yk92WjM4L1Q5UE4rTStsNTFsMm1BM25pSXh2cEVqT1lMazVL?=
 =?utf-8?B?cFQ1RTY3byt4cmJQSS9QaXJFb2wzY3JBclFDMmRCWDhYV25yQU5wVnc3OExM?=
 =?utf-8?B?VGtrbzdsTjJDU05jOGZBVlluVzg0MG1RQmNUN2x0aEduazN6TVV2NnlnL2tt?=
 =?utf-8?B?aFBEVldQTTZ3V0trdTJHaVhuTlBJM1lpd2YwZm5laHpDb09SVXYreW5LLzNS?=
 =?utf-8?B?TEN1ZEVBTExydU9kSWtwL0tUSFNjL1FhWWlEOE8wcEtlb3lUellQSjZneS93?=
 =?utf-8?B?RUZyRVNiWUsrRnRsaFQyMURQRnBuSi9ialltUUwwb0lHa0FQM0NiOFpMOWRn?=
 =?utf-8?B?SEdjZHBRdEd1TGZpNWZXamRnYTNrTEF0cmlPK0JITWF4bzBxMDU4ZE42QVlX?=
 =?utf-8?B?K3QyQXhTZjJ1VjVpZmpIWVNVZnZyOUs0Z0RDYTVuVk9vcjJIOE1KeUtGMGU3?=
 =?utf-8?B?L0l5a3pHOWxiWk9nYXNkaHFvandadEZTOHczZ29tK0xoYlFsOHRWek1tbUhE?=
 =?utf-8?B?MzlPU3JyWXlkaXFlSHduOTF4bHlnQXFzUFlja2JQVStTOVp4MURXaGVKaGhi?=
 =?utf-8?B?QjZEZmV4cHRKSGU5cFBSc0xxNldJbldLYUtpR3JJMFU5T29yS3VaM3lBM3k4?=
 =?utf-8?B?ZVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 3PBb2PilwzU+s+lIyf6HmUKwoNCCs/F+AQk9J1xgze21sELzjo8zNL+qDbv+kNgZ/PSnsR9/MfMCCKKiE0wapTP3hqdB7CG+9THSCDl85Syn3MSaz7YzDmz5XgI2Hl74/s0OOX9RU2N+aAOXRzNwEgLRE8w0aj8dly+XXBmdcGyv+qSAHBkPKwOGStDcsmMGsDS1g0iIEnJ79AXQVFXL35N52tRjAX2XHEaJx+xmGcitMk3cCGz50z2tznTBpimLYfe0TYeEoHV8DXKnBfzUseyOnl0bsi884POmt7y4MKfNdT0/HHY9b64dX3sFgR5/L1NkxKsjGE999bPTHRq97KZQlorNVyJJ4ayvM61LkiqUn/GbV92CO3scWAhquQ2qZG9vW29Y5lL1A4QXeaayTD6Q2pdwwYfa6hPd6DZ+RHfdLcKXJXtsmUw3QMmaJd+n+h3QY1EpNupVvUzCIyXBA+yC0FHsr1XN3IMzZZl+GsbVd8N0HFL9w8k3oxZizvYP/p1GMB84fPlAkQBUEJQdLRyDcIW20JXLdTnY3CNFQXe7nMlEUpJB3GI/HpcW1a/hPmQi3TadYA94rjlA4uhGKlXqQoE+BfvnvMtXAQQQqXk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d26c29e9-5d35-4f6a-32a0-08ddb5289c66
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 03:13:38.7332 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dB0OM1eyZJ+Zp2GZcr6i82kdUNHO2EtZHj4pkDhO3cLJnUe5ivSM2CRysUodeerY2nN+99Ew3VCJd/o7IObtbMmJtLL0d44LEYUmUgIou7g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4376
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_01,2025-06-26_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=999
 suspectscore=0 adultscore=0 mlxscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506270021
X-Proofpoint-GUID: TVp31ckuaLRpTwqxQDbJPMA8-PByq5Ve
X-Authority-Analysis: v=2.4 cv=CeII5Krl c=1 sm=1 tr=0 ts=685e0c67 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=EUspDBNiAAAA:8 a=tj74MtzeQJuImk1p5owA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: TVp31ckuaLRpTwqxQDbJPMA8-PByq5Ve
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI3MDAyNCBTYWx0ZWRfX2Fbm81COmygm
 6iOmS2elFOOAD54jvRXqQw+RfAoXzEPriFd++D3TQsIRF5IKiyNbSJjSvCEae8GadfTPVSzZA+F
 xD/9mbire4cvaGumCEUWEBjhERmAiC1QRw4h5nA9Deq7hsrTYp71f6vRp/bSmunVyxjn0C849J/
 ZFl25BT2Wi03goRwJLCfzwNtiX0Cn6+jjvZYaAlpxXqLuVRjjkbWwFc/oII5yyME/IBVlXkORED
 pqdFzMecKBLfpdAwmNotFwDIqY2jBe/sVlA3FBh8MOeABTobcSe+BoX8XIZT8MxTrrrBvH8mQTl
 YOvqejojyz0mTX3lz25PRmX7a5aJr8Cw6p38YsjwxdL0bIXyImtg5/5IWKQQy0F90Rrut7aK868
 ukMQK022qAX6mcz0/KkxBBBA+22DQBmK+f1p4rYRjmtZZuuBTOGiDWNLHkwFg+rcYvBEUnRX
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [External] : [PATCH] device-drivers/cpufreq_boost: Don't
 hardcode to CPU0
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
From: ALOK TIWARI via ltp <ltp@lists.linux.it>
Reply-To: ALOK TIWARI <alok.a.tiwari@oracle.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>



On 6/27/2025 1:17 AM, Mike Tipton via ltp wrote:
> Some systems don't support boost on every CPU, such as on many Qualcomm
> chipsets. And if boost isn't supported on CPU0, then the test will fail
> since there's no performance improvement.
> 
> Instead of hardcoding CPU0, find the first CPU that belongs to a cpufreq
> policy with boost enabled.
> 
> Signed-off-by: Mike Tipton <mike.tipton@oss.qualcomm.com>
> ---
>   .../device-drivers/cpufreq/cpufreq_boost.c    | 58 ++++++++++++++++---
>   1 file changed, 50 insertions(+), 8 deletions(-)
> 
> diff --git a/testcases/kernel/device-drivers/cpufreq/cpufreq_boost.c b/testcases/kernel/device-drivers/cpufreq/cpufreq_boost.c
> index 67917b3fea25..5469126d2d12 100644
> --- a/testcases/kernel/device-drivers/cpufreq/cpufreq_boost.c
> +++ b/testcases/kernel/device-drivers/cpufreq/cpufreq_boost.c
> @@ -55,10 +55,14 @@ static int id = -1;
>   
>   static int boost_value;
>   
> -const char governor[]	= SYSFS_CPU_DIR "cpu0/cpufreq/scaling_governor";
> +static int cpu;
> +
> +static const char _governor[] = SYSFS_CPU_DIR "cpu%d/cpufreq/scaling_governor";
> +static char governor[64];
>   static char governor_name[16];
>   
> -const char maxspeed[]	= SYSFS_CPU_DIR "cpu0/cpufreq/scaling_max_freq";
> +static const char _maxspeed[] = SYSFS_CPU_DIR "cpu%d/cpufreq/scaling_max_freq";
> +static char maxspeed[64];
>   
>   static void check_set_turbo(char *file, char *off)
>   {
> @@ -84,6 +88,40 @@ static void cleanup(void)
>   		FILE_PRINTF(governor, "%s", governor_name);
>   }
>   
> +static int find_boost_cpu(void)
> +{
> +	char buf[64];
> +	int fd, i;
> +
> +	/*
> +	 * The files we're looking for only exist for acpi_cpufreq. Continue
> +	 * assuming CPU0 for intel_pstate.
> +	 */
> +	if (!strcmp(cdrv[id].name, "intel_pstate"))
> +		return 0;
> +
> +	for (i = 0;; i++) {
> +		snprintf(buf, sizeof(buf), SYSFS_CPU_DIR "cpu%d", i);
> +		fd = open(buf, O_RDONLY);
> +		if (fd == -1)
> +			break;
> +
> +		close(fd);
> +
> +		snprintf(buf, sizeof(buf), SYSFS_CPU_DIR "cpu%d/cpufreq/boost", i);
> +		fd = open(buf, O_RDONLY);
> +		if (fd == -1)
> +			continue;
> +
> +		close(fd);
> +		tst_resm(TINFO, "found boost-capable CPU (CPU%d)", i);
> +		return i;
> +	}
> +
> +	tst_resm(TINFO, "didn't find boost-capable CPU (assuming CPU0)");
> +	return 0;
> +}
> +
>   static void setup(void)
>   {
>   	int fd;
> @@ -109,6 +147,10 @@ static void setup(void)
>   	tst_resm(TINFO, "found '%s' driver, sysfs knob '%s'",
>   		cdrv[id].name, cdrv[id].file);
>   
> +	cpu = find_boost_cpu();
> +	snprintf(governor, sizeof(governor), _governor, cpu);
> +	snprintf(maxspeed, sizeof(governor), _maxspeed, cpu);

why sizeof(governor) not sizeof(maxspeed)

> +
>   	tst_sig(FORK, DEF_HANDLER, cleanup);
>   
>   	SAFE_FILE_SCANF(NULL, cdrv[i].file, "%d", &boost_value);
> @@ -120,16 +162,16 @@ static void setup(void)
>   	if (!strcmp(cdrv[i].name, "intel_pstate") && boost_value == cdrv[i].off)
>   		check_set_turbo(cdrv[i].file, cdrv[i].off_str);
>   

Thanks,
Alok

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
