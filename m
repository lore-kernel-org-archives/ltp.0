Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6398C4345F
	for <ltp@archiver.kernel.org>; Tue, 16 Apr 2024 18:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1713293445; h=date : to :
 message-id : references : in-reply-to : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=NT+ZX8jb0zB3qccbuyu77mPHoal7MP33jzajv1+tgEY=;
 b=pvUlPDNDk48J3iJtiXJgppp8LgddG506zLSHX1dvS3DSTXOCWaljbMXemipT19q9ii691
 jrbxS2ZHKUjaZs1Rs7+hZfjRIsdVwEO+83sznWZqEqZ4nL4vcEadIsKtwy7FQzFv9RIRBo5
 lffx9R6VwcpfUf08k8Pi0YzQpfqeW4Q=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B8C973CFAFF
	for <ltp@archiver.kernel.org>; Tue, 16 Apr 2024 20:50:45 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9E9A23CF2F9
 for <ltp@lists.linux.it>; Tue, 16 Apr 2024 20:50:23 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=oracle.com (client-ip=205.220.165.32;
 helo=mx0a-00069f02.pphosted.com; envelope-from=chuck.lever@oracle.com;
 receiver=lists.linux.it)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 5C8C61A00FA1
 for <ltp@lists.linux.it>; Tue, 16 Apr 2024 20:50:21 +0200 (CEST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 43GHiNpx009416; Tue, 16 Apr 2024 18:50:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-11-20;
 bh=HOJE8Q238E2mnLtxGyEGm/C7/iCu0epwiX/vvLSh7rk=;
 b=EIx1AXOgcTJ2SVze78z/TQ+Qyx5jyewyMuDol+/ZjbsUaIHA15pEiL6uuXKvKA7CzQoY
 DqMeAEkeRsyv7/zJM9kXooqNyB5PBEWD+Plh7BXcZodzOV127OUmgPKvIsdCQFlb5Ax1
 FAO98jqWeiL+PVK39QHynrCKGsgsY9Twk7Mc3MHYa/a0uJGMJ/TzlAiTL6jOzoLD354I
 DiYTgojENOlsBQE55E4NLvykIcP5FaxipAtjmDbo/MFZlUxe1VUopQnogZO9+62YD14w
 wy49El2gyaBEKI59JrHMVGSH6mmd0QG0kdokqVx5t8aCVag44S4+Eq3iwAVziw1HpsAL tA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xfgn2p23k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Apr 2024 18:50:16 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 43GIaZWC014381; Tue, 16 Apr 2024 18:50:15 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3xfggdxfmc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Apr 2024 18:50:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SGT11UrlwHPI2ygSFDb6LvFMYc2EUuZidRwllDziL/dslWNHAJvCJTVQPWMqbxelDTv8zdU2kkvDU8sxYQ1nbQFsN0C+DEFSFS04/CVrwuxjrS9qYCkOf3vy4gd1cvDa+lHz8q0pBExdt/54RH7xMfPFADw7ALG3VeeUfA35D2AfTIete2fG6PzdO8xRibsvoTLYrb8uI5hItd8E2T2jkl07Fit5KoPNuvpJ2EAdYar6WjgZUCZRvNvnPfk6XOqYD/wtREMJKzPIGu+olnT8LxY7YPLDASwA94mDa4o/NGMDVTjJKkJrYR1LDgB0lJc79fnb/AazZHUNg0co15H0ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HOJE8Q238E2mnLtxGyEGm/C7/iCu0epwiX/vvLSh7rk=;
 b=dn429FMQMXw3AOWZ6yWf6Uavg3AymquHr8n3Dg5WQ5KmS+EDnR22kjoG0MJWI8jOZkOsfRz5NsnI6w3/j7MenfNMvMRS94BAb/zWF5+XA+wwIOklOfdWunNynW7AaPSMGEP0eESAvwatrv4+4PDlGOHPQ8UGb0EZQH+3rtkviEPCAKmSXw7nMcKIn+h0VeeAPKQoGgssbRu7iHD/q5zW4HBqXJ1I8guW6wXpM7X0WsCpzqgm4k2Jc6Vr1nMHugJw4NT7CS1jYN7gZIMWWJ2Szcqc3L17tGoVU8EBwoktiaX96h6K7WAKgKTXrNtCCVC7g3ElCPStkq7+VPio9CXhCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HOJE8Q238E2mnLtxGyEGm/C7/iCu0epwiX/vvLSh7rk=;
 b=sATSj6DMGmGJQVKcqzOoMcNLmTlnxWsis2P0Ij34cygnxr5yJWacuRyKqE+LsGWGfho+0eoUt9YHxr3fDc1StTZos/VKAkzaL4hRt+dLReRPx4FFhuAlQlxioaPCDryxx2qEAlCC/Oe1St4WKJDYuU3/00AkboXif6LocERi0Tk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB7297.namprd10.prod.outlook.com (2603:10b6:8:d8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 18:50:12 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 18:50:12 +0000
Date: Tue, 16 Apr 2024 14:50:09 -0400
To: NeilBrown <neilb@suse.de>
Message-ID: <Zh7IYTE0yVc3s+7l@tissot.1015granger.net>
References: <> <Zh2XBV/sW67dx+wp@tissot.1015granger.net>
 <171322513118.17212.2981486436520645718@noble.neil.brown.name>
Content-Disposition: inline
In-Reply-To: <171322513118.17212.2981486436520645718@noble.neil.brown.name>
X-ClientProxiedBy: CH0PR13CA0014.namprd13.prod.outlook.com
 (2603:10b6:610:b1::19) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS7PR10MB7297:EE_
X-MS-Office365-Filtering-Correlation-Id: 590f3153-b295-46cc-f36d-08dc5e460bd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GHtRXDtP+sQVtr25actW1vnfp/YpdqBSsEhY6YmxzerABbHrNduAWGODtjZzDJioqbWVyNiGPw3qbHUSPqVR5rVdjGrEnNvCKB2HhhEyCiD2ycv8Fraig9Mrchgij2X0d88d93Sg0XnZOO10oD8rGq04VpZDecoY0qbndiLFKDAvGtEYeAaHwIDIvpRP14JtwgU47SG6YUqOQjWpuhvBCCCOq4j2eazD7XfegS5nsIh+LMU1JfWlZ9sbNtnl6SwfX9AxVnducsdSs3usU0APLYPPo8ja5DseW0/g40RWDxY1llR44Gye+RocryfrU46QypMyKAroA9l6zK/uWngxuoOVMuCRuPYRLaHH0X09QHHD9aLVEgHpgf516b1xvBc9c2q4GJE9GDxgMMQPjj0cEemZtTz4L8kNI7sd4153dtTDjF55maifN6L0gZWme7kHRw7sD0zHHmNlojP3I3qNvclIdZe0NIqi6bm+t/4DIVBhGjEwpqxaUXtoumcUEkLE4nc+PAYL0RHbsaCcdTBhHV5PhXxT1tu+0EesXsyroo6bdHzuzJgc+tvLxp4Pbwj0O4+iC6+ngmVKsSVdqpWgGjczs6o3P6VRHwOtz5Os4fo52RFClCxC+MsQ0Zznopsclrtv1YJGIm7+D2ocOF+HPDYp6RZZtax4UCcDHM7XZCM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN0PR10MB5128.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGd0M3J3U21IeUdBNHZHekF3OGl0U2E3R1VLWStWanFKVThRamF0VFByL1F5?=
 =?utf-8?B?aXpWUHhXb3ZaM01sMk44NW9Wd3A4RWFucFFqM0JpZXA3UTVybzVnTXFuRGtZ?=
 =?utf-8?B?dlpCTitubWpwZEorYmJpTUNuN21aTyt4U3AzM1hlN3lwbnlZWUtraVAwZVBn?=
 =?utf-8?B?YzFVaiswYXI3YlBRQVFqTGdNTXBkMUVkZ0hOcHdjRWtYSG1PRGtZNGJDdVR2?=
 =?utf-8?B?T0gxeWV4bWZHUmJEaTBqbkFYU1gwZWpPQ0V5OStUUndnNjZybGxvVk1WTWJJ?=
 =?utf-8?B?SGxHU2VFR0dCa3FiL2pXSG1GRFV2aGwvWGpXd240SHRVOHE3U0Y5OEFzcWlW?=
 =?utf-8?B?SFd5NWV6YlRQQ0NtRFh4WDIzdDZueGR4bkE5TmQxd1pNbGNIWWNxRHFBUTJB?=
 =?utf-8?B?bzBXZXJFUXdEa2R2NkgycnczYk5xQzIvaXlFcEQ4WDIrcDNpeWJkbjhkVzMw?=
 =?utf-8?B?anJRdjZhUzJjY2F5WTQ1L1NBait6RnFZTjBCeUhTVzhFRjM5alVGSm9GUitv?=
 =?utf-8?B?N1JXbFl6UnFYREF3SmlDdVRIMmNQYnlMWUlMYWd5d3U0dWhiRmo5REhLQlNx?=
 =?utf-8?B?MlBZY09KNjlvS25HUGZONGg4MGdUeDBpeE9uOC9TdE0wZlpxTDRZMThWdkQ0?=
 =?utf-8?B?WVp2aXpWbHlsU2JrVzBJZkk2RE5NVDNYN2t6ZEJtQ0t2WlA5NGxSN0JvMmJn?=
 =?utf-8?B?UFBnc3NJTmZHQmYzS3MyRWJFdG5YZUFHVlYwSTVSMnhVbURodWIxRGRBK2R4?=
 =?utf-8?B?ZVJxVUJDeG9SN0Nuczg1Zy9sOE5XMEE2UkFGV291SVNwZUdjSy92VDZtMmQv?=
 =?utf-8?B?bjhpZlRPTVk1cDZSQnNSV01hNTZsQ1RweVVRbXRGb3NaWkNZZk1kazAveEdm?=
 =?utf-8?B?VHpWUEE1V3pDQ3BiTG1UdWJ3UGlYejFTbllLb3IzaVdYaWROSjc2d2xXWGpP?=
 =?utf-8?B?Sm5pcDlFNXhOd2VTRmZ2NGxmZlBOVkhYemFocHNwWDRXQ0FPbnhteFdFMW5p?=
 =?utf-8?B?VzhEWU42Z2JGellrZ3NzRzB5R1A2cmZGYjJqMEdUd0xhYU9pVytpUld0NEN1?=
 =?utf-8?B?TG5meXI2SEU4Z0FIWnBTU3dvRGNjWmZkUUZBZkc0cUVTSTN3YVRQa2RLclJ1?=
 =?utf-8?B?bjExTXdxY3RRd3ZOazlpWGwzb1FjanZScXRuMmh6c1AzaWh1UEk2dnptUEtw?=
 =?utf-8?B?ZVBTSHVVL2lDQmF3c0Q2YTdzMHFjd1N4bm8xejhWNWJuUFpqMnYvOFZKaHJJ?=
 =?utf-8?B?NlNITU9jbWw3aWY4VXRxMjdLaVl6WHhSYitZMzlncVlRbGxxaEhvMUI1TVlN?=
 =?utf-8?B?TWNEQVNPRm83S3VTQjE0a2lTNXBGbGV0cmRkNGI5N2ZscUIyQVMwczBIRFov?=
 =?utf-8?B?M0FJSkFsOEpaZUZUY01EWnRpRkdMSVJhUWptbDM3QUdvNkdBL1cweXN6SHVp?=
 =?utf-8?B?emxqaTBpanB0dU8zQnFSYnVzdDJlQlRIcy80VG1ETFhaSjFoaE84VjYvNEZ4?=
 =?utf-8?B?K2ZLbW9wNXkwS3N3S2Qzc0lrNHlOaFVPcy91RWZEVEFBcUZPSDBYc0pzVzZC?=
 =?utf-8?B?UnpJc3hRM3JGK3c5c3BjYkNRWkRkYmlCQTVIbGl0TUJyRk1TUDdnRGd2TkQ0?=
 =?utf-8?B?UnNNSFp4MWVlQ044M05GdG5BeEU5aTRaZUpjb1l6VDRjbjFLRFRGSVQyRUVk?=
 =?utf-8?B?S0JWN01zYld1WGlZakVjc3V5czkwWkFuTHlGVllxdUM1NHc3YWsvaS9uZlE0?=
 =?utf-8?B?NnBIbGpvYTY1MVBNYWFMT2Z3blNkWHNoZkwwUWZlL3Fhci9ZeVc0MEcyM1Yz?=
 =?utf-8?B?MFYrTHVGa3BmSWwvejRTaFdpRUlibG1YOHFCeEdqdTBFS25lb3JIQXJhWnFE?=
 =?utf-8?B?ZjdHc2dWWUkxNzRHM3pkT1A4U0hjVElZOGxoaXlBRkgwSll6MmJNWGUrOUJE?=
 =?utf-8?B?NnVUZ3g2Yy9GS2lKa1l1dms4ZngzalhPeFlJNlJkckIyK25ERXlyN21XNEVy?=
 =?utf-8?B?cmRBTStwcUgrazV2T1doRmJaenFuWFgxYkxoZ0hVT1pRait5bE9wODFzVUVw?=
 =?utf-8?B?Y3QrQlVzZk9Ca3BBTzZ3eCt0UmRuUXd0SzdQOTNmWW9rbE1RRkI5am1pSVlF?=
 =?utf-8?B?YXBHTm53N0tPMmpienlCVjZyQlA0NlRpWHM4RjNUVXFRWFd3cjY2Q2drSWdk?=
 =?utf-8?B?MEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: DvmxSH476F0bHzrZ5Bu83I+uYWqhvmuukxMHXcRaGVYHoIRw4YBdacWUAfveoNKNQQxWIreGifJAyxJst/7kj33/yNUf7zHPEWwIZFgSIIz9/aLE5cPi+i4xomnza4FvHC6jHdmzq5rx3/lHa3YUZ5XZhFdoDQSf2L0Lxb8fRh+JUONfLK92CIP0+tWy3HsOM6aoH6ssaFleD6h5VsPhVcn568NqQpUkCSukkH6dras28Nwpmc1Dqq6sKx1tsgR6DSw5GUQvrKXIfF5m4WQL9uF1rFfB+TQAgySfEv0HsWGrjKH6lLLVKeiWwBBwHAkjmJCUD+NMFWSHPitDuAP0eY2r4TJkAHGzCiAseoR0wn+NyezrE3MSdtSq8xfN0Tsbbf2z/bspYW5FZ0OsJJI8jMgsjt1T332OE5hC486QPShShSUYM/qjdrjdmSKn7EbmRRb/wyRmJTEHKVB1YxDl1t1CGZ2qFxZrg6JBcjONRqcQPSn3y5ATp4SdrcBesRYwsoiXyNpWkU37j99Nf83icF+snYIhQmUFTFrI7hHtJneqVxoQ0EbOpjHQ0DmChW+nbM/jgxAFHoPs6ORB6a09YDIYC9owWm9WpYdVUcnmPFY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 590f3153-b295-46cc-f36d-08dc5e460bd6
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 18:50:12.2437 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yvsdgmuhaDf8FKSZrhvujVJBFh1+6xLdPhrBbtU0KQUpDMeR2hlZtgNgPH1gmXybTv4SXpSj6x6yWjo9XkFUfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7297
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-16_16,2024-04-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 phishscore=0 bulkscore=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404160119
X-Proofpoint-ORIG-GUID: k1bsuQruAF4_QtEHIriVwe57PA_sSOx9
X-Proofpoint-GUID: k1bsuQruAF4_QtEHIriVwe57PA_sSOx9
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] proc01: Whitelist
 /proc/fs/nfsd/nfsv4recoverydir
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
From: Chuck Lever via ltp <ltp@lists.linux.it>
Reply-To: Chuck Lever <chuck.lever@oracle.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
 Jeff Layton <jlayton@kernel.org>, "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVHVlLCBBcHIgMTYsIDIwMjQgYXQgMDk6NTI6MTFBTSArMTAwMCwgTmVpbEJyb3duIHdyb3Rl
Ogo+IE9uIFR1ZSwgMTYgQXByIDIwMjQsIENodWNrIExldmVyIHdyb3RlOgo+ID4gT24gTW9uLCBB
cHIgMTUsIDIwMjQgYXQgMDE6NDM6MzdQTSAtMDQwMCwgSmVmZiBMYXl0b24gd3JvdGU6Cj4gPiA+
IE9uIE1vbiwgMjAyNC0wNC0xNSBhdCAxNzozNyArMDAwMCwgQ2h1Y2sgTGV2ZXIgSUlJIHdyb3Rl
Ogo+ID4gPiA+IAo+ID4gPiA+ID4gT24gQXByIDE1LCAyMDI0LCBhdCAxOjM14oCvUE0sIEplZmYg
TGF5dG9uIDxqbGF5dG9uQGtlcm5lbC5vcmc+IHdyb3RlOgo+ID4gPiA+ID4gCj4gPiA+ID4gPiBP
biBNb24sIDIwMjQtMDQtMTUgYXQgMTc6MjcgKzAwMDAsIENodWNrIExldmVyIElJSSB3cm90ZToK
PiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+ID4gT24gQXByIDE1LCAyMDI0LCBhdCAxOjIx4oCvUE0s
IFBldHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6PiB3cm90ZToKPiA+ID4gPiA+ID4gPiAKPiA+ID4g
PiA+ID4gPiAvcHJvYy9mcy9uZnNkL25mc3Y0cmVjb3ZlcnlkaXIgc3RhcnRlZCBmcm9tIGtlcm5l
bCA2LjggcmVwb3J0IEVJTlZBTC4KPiA+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gPiBTaWduZWQt
b2ZmLWJ5OiBQZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4KPiA+ID4gPiA+ID4gPiAtLS0KPiA+
ID4gPiA+ID4gPiBIaSwKPiA+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gPiBAIEplZmYsIENodWNr
LCBOZWlsLCBORlMgZGV2czogVGhlIHBhdGNoIGl0c2VsZiB3aGl0ZWxpc3QgcmVhZGluZwo+ID4g
PiA+ID4gPiA+IC9wcm9jL2ZzL25mc2QvbmZzdjRyZWNvdmVyeWRpciBpbiBMVFAgdGVzdC4gSSBz
dXNwZWN0IHJlYWRpbmcgZmFpbGVkCj4gPiA+ID4gPiA+ID4gd2l0aCBFSU5WQUwgaW4gNi44IHdh
cyBhIGRlbGliZXJhdGUgY2hhbmdlIGFuZCBleHBlY3RlZCBiZWhhdmlvciB3aGVuCj4gPiA+ID4g
PiA+ID4gQ09ORklHX05GU0RfTEVHQUNZX0NMSUVOVF9UUkFDS0lORyBpcyBub3Qgc2V0Ogo+ID4g
PiA+ID4gPiAKPiA+ID4gPiA+ID4gSSdtIG5vdCBzdXJlIGl0IHdhcyBkZWxpYmVyYXRlLiBUaGlz
IHNlZW1zIGxpa2UgYSBiZWhhdmlvcgo+ID4gPiA+ID4gPiByZWdyZXNzaW9uLiBKZWZmPwo+ID4g
PiA+ID4gPiAKPiA+ID4gPiA+IAo+ID4gPiA+ID4gSSBkb24ndCB0aGluayBJIGludGVuZGVkIHRv
IG1ha2UgaXQgcmV0dXJuIC1FSU5WQUwuIEkgZ3Vlc3MgdGhhdCdzIHdoYXQKPiA+ID4gPiA+IGhh
cHBlbnMgd2hlbiB0aGVyZSBpcyBubyBlbnRyeSBmb3IgaXQgaW4gdGhlIHdyaXRlX29wIGFycmF5
Lgo+ID4gPiA+ID4gCj4gPiA+ID4gPiBXaXRoIENPTkZJR19ORlNEX0xFR0FDWV9DTElFTlRfVFJB
Q0tJTkcgZGlzYWJsZWQsIHRoYXQgZmlsZSBoYXMgbm8KPiA+ID4gPiA+IG1lYW5pbmcgb3IgdmFs
dWUgYXQgYWxsIGFueW1vcmUuIE1heWJlIHdlIHNob3VsZCBqdXN0IHJlbW92ZSB0aGUgZGVudHJ5
Cj4gPiA+ID4gPiBhbHRvZ2V0aGVyIHdoZW4gQ09ORklHX05GU0RfTEVHQUNZX0NMSUVOVF9UUkFD
S0lORyBpcyBkaXNhYmxlZD8KPiA+ID4gPiAKPiA+ID4gPiBNeSB1bmRlcnN0YW5kaW5nIG9mIHRo
ZSBydWxlcyBhYm91dCBtb2RpZnlpbmcgdGhpcyBwYXJ0IG9mCj4gPiA+ID4gdGhlIGtlcm5lbC11
c2VyIGludGVyZmFjZSBpcyB0aGF0IHRoZSBmaWxlIGhhcyB0byBzdGF5LCBldmVuCj4gPiA+ID4g
dGhvdWdoIGl0J3Mgbm93IGEgbm8tb3AuCj4gPiA+ID4gCj4gPiA+IAo+ID4gPiBEb2VzIGl0PyAg
V2hlcmUgYXJlIHRoZXNlIHJ1bGVzIHdyaXR0ZW4/IAo+ID4gPiAKPiA+ID4gV2hhdCBzaG91bGQg
d2UgaGF2ZSBpdCBkbyBub3cgd2hlbiByZWFkIGFuZCB3cml0dGVuPyBNYXliZSBFT1BOT1RTVVBQ
Cj4gPiA+IHdvdWxkIGJlIGJldHRlciwgaWYgd2UgY2FuIG1ha2UgaXQganVzdCByZXR1cm4gYW4g
ZXJyb3I/Cj4gPiA+IAo+ID4gPiBXZSBjb3VsZCBhbHNvIG1ha2UgaXQganVzdCBkaXNjYXJkIHdy
aXR0ZW4gZGF0YSwgYW5kIHByZXNlbnQgYSBibGFuawo+ID4gPiBzdHJpbmcgd2hlbiByZWFkLiBX
aGF0IGRvIHRoZSBydWxlcyBzYXkgd2UgYXJlIHJlcXVpcmVkIHRvIGRvIGhlcmU/Cj4gPiAKPiA+
IFRoZSBiZXN0IEkgY291bGQgZmluZCB3YXMgRG9jdW1lbnRhdGlvbi9wcm9jZXNzL3N0YWJsZS1h
cGktbm9uc2Vuc2UucnN0Lgo+ID4gCj4gPiBUZWxsIHlvdSB3aGF0LCB5b3UgYW5kIFBldHIgd29y
ayBvdXQgd2hhdCB5b3UnZCBsaWtlIHRvIGRvLCBsZXQncwo+ID4gZmlndXJlIG91dCB0aGUgcmln
aHQgc2V0IG9mIGZvbGtzIHRvIHJldmlldyBjaGFuZ2VzIGluIC9wcm9jLCBhbmQKPiA+IHdlJ2xs
IGdvIGZyb20gdGhlcmUuIElmIG5vLW9uZSBoYXMgYSBwcm9ibGVtIHJlbW92aW5nIHRoZSBmaWxl
LCBJJ20KPiA+IG5vdCBnb2luZyB0byBzdGFuZCBpbiB0aGUgd2F5Lgo+IAo+IEkgZG9uJ3QgdGhp
bmsgd2UgbmVlZCBhbnkgZXh0ZXJuYWwgcmV2aWV3IGZvciB0aGlzLiAgV2hpbGUgdGhlIGZpbGUg
aXMKPiBpbiAvcHJvYywgaXQgaXMgbm90IGluIHByb2NmcyBidXQgaW4gbmZzZGZzLiAgU28gcGVv
cGxlIG91dCBzaWRlIHRoZQo+IG5mc2QgY29tbXVuaXR5IGFyZSB1bmxpa2VseSB0byBjYXJlLiAg
QW5kIHRoaXMgaXNuJ3QgYSBoYXJkIHJlbW92YWwuICBJdAo+IGlzIGp1c3QgYSBuZXcgY29uZmln
IG9wdGlvbiB0aGF0IGFsbG93cyBhIGZpbGUgdG8gYmUgcmVtb3ZlZC4KPiAKPiBJIHRoaW5rIHdl
IGRvIHdhbnQgdG8gY29tcGxldGVseSByZW1vdmUgdGhlIGZpbGUsIG5vdCBqdXN0IGxldCBpdCBy
ZXR1cm4KPiBhbiBlcnJvcjoKCidrYXksIG5vIG9iamVjdGlvbi4KCkNhbiB5b3Ugc2VuZCBhbiAi
b2ZmaWNpYWwiIHBhdGNoIHdpdGggYSBkZXNjcmlwdGlvbiBhbmQgU09CPwoKCj4gLS0tIGEvZnMv
bmZzZC9uZnNjdGwuYwo+ICsrKyBiL2ZzL25mc2QvbmZzY3RsLmMKPiBAQCAtNTEsNyArNTEsOSBA
QCBlbnVtIHsKPiAgI2lmZGVmIENPTkZJR19ORlNEX1Y0Cj4gIAlORlNEX0xlYXNldGltZSwKPiAg
CU5GU0RfR3JhY2V0aW1lLAo+ICsjaWZkZWYgQ09ORklHX05GU0RfTEVHQUNZX0NMSUVOVF9UUkFD
S0lORwo+ICAJTkZTRF9SZWNvdmVyeURpciwKPiArI2VuZGlmCj4gIAlORlNEX1Y0RW5kR3JhY2Us
Cj4gICNlbmRpZgo+ICAJTkZTRF9NYXhSZXNlcnZlZAo+IEBAIC0xMzYwLDcgKzEzNjIsOSBAQCBz
dGF0aWMgaW50IG5mc2RfZmlsbF9zdXBlcihzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiLCBzdHJ1Y3Qg
ZnNfY29udGV4dCAqZmMpCj4gICNpZmRlZiBDT05GSUdfTkZTRF9WNAo+ICAJCVtORlNEX0xlYXNl
dGltZV0gPSB7Im5mc3Y0bGVhc2V0aW1lIiwgJnRyYW5zYWN0aW9uX29wcywgU19JV1VTUnxTX0lS
VVNSfSwKPiAgCQlbTkZTRF9HcmFjZXRpbWVdID0geyJuZnN2NGdyYWNldGltZSIsICZ0cmFuc2Fj
dGlvbl9vcHMsIFNfSVdVU1J8U19JUlVTUn0sCj4gKyNpZmRlZiBDT05GSUdfTkZTRF9MRUdBQ1lf
Q0xJRU5UX1RSQUNLSU5HCj4gIAkJW05GU0RfUmVjb3ZlcnlEaXJdID0geyJuZnN2NHJlY292ZXJ5
ZGlyIiwgJnRyYW5zYWN0aW9uX29wcywgU19JV1VTUnxTX0lSVVNSfSwKPiArI2VuZGlmCj4gIAkJ
W05GU0RfVjRFbmRHcmFjZV0gPSB7InY0X2VuZF9ncmFjZSIsICZ0cmFuc2FjdGlvbl9vcHMsIFNf
SVdVU1J8U19JUlVHT30sCj4gICNlbmRpZgo+ICAJCS8qIGxhc3Qgb25lICovIHsiIn0KPiAKPiAK
PiBNeSB1bmRlcnN0YW5kIG9mIHRoZSBzdGFiaWxpdHkgcnVsZSBpcyAiaWYgTGludXMgZG9lc24n
dCBoZWFyIGFib3V0IGl0LAo+IHRoZW4gaXQgaXNuJ3QgYSByZWdyZXNzaW9uIi4gIEFsc28ga25v
d24gYXMgIm5vIGhhcm0sIG5vIGZvdWwiLgo+IAo+IFNvIGlmIHdlIG1hbmFnZSB0aGUgY2hhbmdl
IHRvIGV2ZXJ5b25lJ3Mgc2F0aXNmYWN0aW9uLCB0aGVuIGl0IGlzCj4gcGVyZmVjdGx5IE9LIHRv
IG1ha2UgdGhlIGNoYW5nZS4gIG5mcy11dGlscyBhbHJlYWR5IGhhbmRsZXMgYSBtaXNzaW5nCj4g
ZmlsZSBmYWlybHkgd2VsbCAtIHlvdSBnZXQgYSBEX0dFTkVSQUwgbG9nIG1lc3NhZ2UsIGJ1dCB0
aGF0IGlzIGFsbC4KPiBQZXRyJ3MgZml4IGZvciBsdHAgc2hvdWxkIGFsbG93IGl0IHRvIHdvcmsu
ICBJIHdvdWxkIGJlIGdyZWF0bHkKPiBzdXJwcmlzZWQgaWYgYW55dGhpbmcgZWxzZSAoZXhjZXB0
IHBvc3NpYmx5IG90aGVyIHRlc3RpbmcgY29kZSkgd291bGQKPiBjYXJlLgo+IAo+IE5laWxCcm93
bgoKLS0gCkNodWNrIExldmVyCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMu
bGludXguaXQvbGlzdGluZm8vbHRwCg==
