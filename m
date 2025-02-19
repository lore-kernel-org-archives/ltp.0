Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 294D2C021AA
	for <ltp@archiver.kernel.org>; Wed, 19 Feb 2025 13:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1739970625; h=message-id :
 date : to : references : in-reply-to : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=Ymt5qeOPznb41xRjA6dsfFEPonXNYDWIIQkMEI4r3bk=;
 b=iTYkLH+tj1MqqezrpNOUKEhvKh7cYWILlUwEADvTKmtdvEUfOkXQskBCktcuN8jhvEjKy
 LxydqJmwKpuRhfGw3kC9X61aBUxUiOys4zYw8CZKu0FkoTKzerrhO54lxeI4umFSS45t3FF
 wEXG9c9iRdEVP84OxPiBaGKgfU0pu7o=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6738F3C301F
	for <ltp@archiver.kernel.org>; Wed, 19 Feb 2025 14:10:25 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0FE3E3C2A78
 for <ltp@lists.linux.it>; Wed, 19 Feb 2025 14:10:03 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=oracle.com (client-ip=205.220.177.32;
 helo=mx0b-00069f02.pphosted.com; envelope-from=rhythm.m.mahajan@oracle.com;
 receiver=lists.linux.it)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 321AB600CF8
 for <ltp@lists.linux.it>; Wed, 19 Feb 2025 14:10:01 +0100 (CET)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51JD7Vla001050;
 Wed, 19 Feb 2025 13:10:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=laSzQ6M6RPcGvMByGOm7zkA2cwJxTTM57wb2rmcrRk8=; b=
 Ir1AKcnA5Jf8Jmm8YZvOKXMyrGUXa6RiIwrpfc9aCMB2sFVRPzC4t+GGpgrtiN34
 MYfFbSzK5F2oykTz+oEXCetWG4LKXoKslQiw6CQ9F9+BC14UjWUwAghOIWuQhOfh
 I1uo0MBpFnziCSepG1RGGQstjevl5jAf9u0+/hDdrxk6WEmY5eCT6kJfHmgyYn40
 PWNMBOGdpoktUZPJ2GRhvQgPWruoMzdEU75rNAwoAQa9Pg04Yt85Y8rKUafSG++X
 lXhEhnuGHYtE5PzB9Y9y7NS0DBuEBYcN4wECX0auenM1UrKkxI4ZSDsmbDKf+cXA
 vYqYcLpR6uPhK1wHQ1sbRw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44w00n1khe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Feb 2025 13:10:00 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 51JC0nL1012061; Wed, 19 Feb 2025 13:09:59 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 44w0b2f00c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Feb 2025 13:09:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EOPVNS6we3mLNNsZaCLPe6AeROG9R1e1vHgnEwwICbjexikpCyRTxeWXvoNWOsbLbaIkx29Y45h83i74rPBo6bEbsGceT+wXB7Fc9iexNDpokTXzVzgtm+82+VX3rUxmno10Ktd80US2pVEzDw+FUquJRmBGUUZx33dFUG3SMmr4pvjQfBc9ZQuCPgaoz6JmtFDyeGOP/II1/ZlW9vUctc4NA4LSw8q9NFcVEzXAS40pp0732tftxUcdLKKIeHLq1b6e5+pUHwECqk0vsDXUf0CmBHA2+fa1+Ts6mU/p1wdSPT8pjt05IiZprlcqrSl59qh3zcejlaYrprRtSm/o9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=laSzQ6M6RPcGvMByGOm7zkA2cwJxTTM57wb2rmcrRk8=;
 b=MvbaaiYvVGjOwirJci2Od9y1s1pTDDgAdA84/1P3+KXM4RcIiXIZzy3hvdc+RvRZrBUHNTStQfE6t8lH83/UjdLpDcYPa852BfzEhk1aocpejYAfvIUt5r+QS2Nv/IUThoJpSVpL83iaOJdtF0h5fpZWZ5Nfm9R9ESJmb2ntQn2/cLu1ZXdMCpVO6TBtewRBZU8LH0lIv8VYZ5+2uqeXKWgohO62scuU630zS4DvAzXUSVHILEhE1bIJXTiguAmgUBQtSEH7BF42wdEIjGYiIRaQdYrLxN+dXCcToUymkPdKfifcYjM4L7Z/AvdvOHAFJIfrlThgNEC88SC3acZ82Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=laSzQ6M6RPcGvMByGOm7zkA2cwJxTTM57wb2rmcrRk8=;
 b=K+/nAHgQ/AVnN4+aoGlV1n/1Hmlp3GkaDGqIz85aO3xSv2zwhhoF/izyXGjOgkdgZipHIFmYDIqRmh4e4tOndIlI/e/j3+UGoFEn5ejoPfiZCUOcl0Khh+uVV1/HL6LP7viN9R9OBeHKjqaCVC2joW/HWmuFj7Qt6DljlxR/taM=
Received: from BLAPR10MB5380.namprd10.prod.outlook.com (2603:10b6:208:333::14)
 by CH3PR10MB7836.namprd10.prod.outlook.com (2603:10b6:610:1b1::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Wed, 19 Feb
 2025 13:09:57 +0000
Received: from BLAPR10MB5380.namprd10.prod.outlook.com
 ([fe80::ef73:6117:7d5b:3227]) by BLAPR10MB5380.namprd10.prod.outlook.com
 ([fe80::ef73:6117:7d5b:3227%5]) with mapi id 15.20.8466.015; Wed, 19 Feb 2025
 13:09:57 +0000
Message-ID: <0600a8e5-6943-44ba-a8ad-c173d6d0a3e6@oracle.com>
Date: Wed, 19 Feb 2025 18:39:50 +0530
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>
References: <BLAPR10MB53806691A64D8003A5D0FD5CBCFF2@BLAPR10MB5380.namprd10.prod.outlook.com>
 <40043b19-65a9-47b1-a759-4f1478d3faba@oracle.com> <Z68-rXnMHNi2LEY3@yuki.lan>
Content-Language: en-US
In-Reply-To: <Z68-rXnMHNi2LEY3@yuki.lan>
X-ClientProxiedBy: SI2PR02CA0020.apcprd02.prod.outlook.com
 (2603:1096:4:195::7) To BLAPR10MB5380.namprd10.prod.outlook.com
 (2603:10b6:208:333::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5380:EE_|CH3PR10MB7836:EE_
X-MS-Office365-Filtering-Correlation-Id: 31653ecb-64e3-4c67-169a-08dd50e6b54a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ejNJUzY1NWlmT1BDQ3VnRjB1TExDbGlOc2RKUGxEYitSNUUvYTFsQ1BjOEMw?=
 =?utf-8?B?QVVSSHNrOVk0Q0V4NWZBVWJkSWJwNDRHS0FjYldyeUNuck12SlJNdElxMlkr?=
 =?utf-8?B?dGhjM0s3RWhXdDB0Uk5EWDJacFBSZFFBU1BEUWgvUlNNRmhRQTlRQ3d3bWZY?=
 =?utf-8?B?VGEyVmZ3SGZCSFMxTy91ZjNTNVgyeWdLdVFVWGVDQ1haWmFoVlo4azN0d2J5?=
 =?utf-8?B?ODNVVUxDbFV6QzA0YkY5L3ZVQUtkTmJCN3dYZ1JrN1NQeEw0OGk2T21VSkJw?=
 =?utf-8?B?K29RVUdqTVJma0FZWk9KdTVROE9TNEtTTFMvRWJzbENlZUROTFFma3AyWVpo?=
 =?utf-8?B?ZEtDMzNmUTA3N0IrVmNmaVM3K2VaRjNidExnRXFha2NuNW1Ecm8rU3FVMEQ4?=
 =?utf-8?B?YnVXbVFjMjVsYjBDSGZlYWFmaVdXaHBTWSs3WFQyenUyMW5FMFlmc0hoeTZj?=
 =?utf-8?B?TGZ2SEFraEpYNExJL1JBMVp3VWt1UUN5bzAzSi9ycWdSelNZU3V3cEI4dllM?=
 =?utf-8?B?Z1VBOVBBMHVvV0NubVg4cmVLUVlmQzBpRVpSK2QzUXNPM0JqLytHQjQ5ZmNw?=
 =?utf-8?B?N2tDU1huMStQaHlEZEo2eDFTZHNlSW5keGE5R3llWUdiemdWR1d6bU1XaHlJ?=
 =?utf-8?B?ZXRqWEN2T2MrdWYwREx3a291TzhFSkZJeTZXcUl1enlXd0VscnZCRjNRZ1V3?=
 =?utf-8?B?amlsMXJ6cnBrTGg1dGFSc0gxMFRBQzgzVW0xaUN0eXhzaWU1UThRbHY2WXFT?=
 =?utf-8?B?MUlvRFhCVHNpUGQ3ckRLbEMzTjJLaW5DY0NxVkdGSlFTSnZCNHhJWk5NR3BB?=
 =?utf-8?B?NXl4VFdxZHVMWG90cmw1bzVjNFl1cVlNRnBjdVJVenMrQURYM3gwMkN1Y2NF?=
 =?utf-8?B?dVp4WklSWkxoWUZ1OEN4VnFDcGo1c1VDdUNkdjZBUVF6WW9scWdpUnF4ZW1j?=
 =?utf-8?B?cU1yUTVNMWwrZk9NWk5JUVc2U0Z0aGc5ZzIvNGxmVUpZRGxLdnZhemJnZ2FV?=
 =?utf-8?B?WjhaK0Q5NEZ1YU0zcUR1SHBzOUp0U0hNRWFqUXlDcFlCL1NRdllwUFVaUDhx?=
 =?utf-8?B?NTRiOWUxaFl6ZXVoR0ROT2NXeGJHcFhOKzVvSGluMGw1QVhCSWVZMjgrM0wy?=
 =?utf-8?B?dllrOXhxazR0MW5qOVB4akFIb2xGalE5L1ozNHJwVjcza3hjQU0zWDgyd1gr?=
 =?utf-8?B?QkFHTHhlTmkwWWdkRUpObkcwSGJwUTFkdzRkZUJZeWFteTNld0NDdlBOTDUw?=
 =?utf-8?B?UTU0bzk2SDN0am5BeFZWS3JLWmp3bE9iUWdvK1pXdjc1Z1pnZWNjSmRWNVhr?=
 =?utf-8?B?cFdWNEV5WDVqRjBPdzd5R2JSMXZISXZRYXJSSnc5VXBTZlc3M2RZZFVxRDI0?=
 =?utf-8?B?UGRvYWRkR1hyU0EwNUhYRW5WdksxTC9PNkIyWWU3VElkTDRvMWRQWkJiQVRq?=
 =?utf-8?B?M3FBay9QZUl4WUViLzdveUFkOFZLOVlBRGV3Y1ZTOEdaYXNaVWx4S25GR0FV?=
 =?utf-8?B?NmpTTFFvOThUQzZHb3hUSGlOMHpwTExIcjZGL0psOWxWcCtiZllkcGwvdXhl?=
 =?utf-8?B?Q2ZCYWZNa2dMdEUzWmNRYWx0ZFFGQ0ppR3lQYXJCaWRGdzg4aUFlSld1K3Vk?=
 =?utf-8?B?N1I3ZXBNZmNvUHN0cXdXaGdWVDIrb3Evb3B3L1JhQzI0dFRGbzgxclo1NXdJ?=
 =?utf-8?B?blVxVStYYTAvNURRbWc0VkEwMUxMdjJ4ajJKM0tISWtxSXFYY2VjeDV5YTBY?=
 =?utf-8?B?QTgyaGV1RkVKeHhKK2FZYTJ0Y0lwbVloMWluNlY4bG1RMjhPcUN2Q0ZNU0JW?=
 =?utf-8?B?N1JqYWZYWGd1ZmkyUzZKUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB5380.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dEpERzlqRFYvOWZPTWhLVWlOVXhCRjZuTGovVm55MUVYclFvbkNyTTZnMkd6?=
 =?utf-8?B?MktxSFhmOWYySjZmRlhwRk5UZWxEbXlUQ2V0Ykt6Z1JlcHFFL2Jtd1RPU1RL?=
 =?utf-8?B?TE5hdCtoRHM4S09WNEFRdnJtVFFQcWpENnVRM3cxTk5lTHlSVmp5UUNweVFR?=
 =?utf-8?B?N1A2bUwxVzZGTkwwVG9EdXlMN3FYbUpCTVRTeXdGaXpBTGFyd2RheTZZckxu?=
 =?utf-8?B?T3g4a2RyNy9QMHovbUVyUE5XN2VVRUx0MlBuSkg2NFdQVGxzaEVQTGFab2V6?=
 =?utf-8?B?K1dUbmNvVTZTWVNtdlFZYUZIdHk5SUJVNnhLZWlOak93V2JMY1RUZDFyNnlP?=
 =?utf-8?B?L1owM3VYZzJaNUlpdlpwdUFlT1ZNTWUrbndFSHVOeTIvNFVhWFNNc21sNHND?=
 =?utf-8?B?SDV0ZktQei9rUDM1ZW9vRFNabm8xdFUvUGh0aGxFYWpISFphRDJGck1YQ3E4?=
 =?utf-8?B?Z3lnbGxHdm4zbnI3ejVUUkorNlR0T2o4dUhCdkNvUEliSnQxZ0hINllWVkNk?=
 =?utf-8?B?Z3NUUnBIR3NIb3hkZ2NMTk1QT3BQMjZVUkVpbUY4VEJvTFJkKy9MWWhsT0Fn?=
 =?utf-8?B?WTFzclFsZjAzWWpVU3duakZqWTliR01CT0h3Rk1rVzhTTVoxM3Q5K3VaNUhV?=
 =?utf-8?B?UThlaTRJVUhRMnJ1T2R4Rm9xZGJZWnZlK2VIaGE1OU91UXM0MDNYWjA2WjZP?=
 =?utf-8?B?Mk8wdDV3VTg0cXFENmVSL3lxK01IS3VKV1NjVDM5Z3VuVDhJYlB1bEFmZVla?=
 =?utf-8?B?V25RNzVyQlFFU2V2YWJpdEVEcFZrR3p0OUdQSGRrZ3hJVVFFQXp3Y0ZmMWkw?=
 =?utf-8?B?Ui9sSmIwUVRUQm1pWURkM2l6YjNUaUdWeEs2cm91OHdYdWR6aUhJNUFUUTMw?=
 =?utf-8?B?d3lFTUNsalR6R1V0U0VuclNHR1F3Z3h3S1ZsanI1aVd6aDNiNkc5cjdpOWNl?=
 =?utf-8?B?OE9CTFFOZW9oSndpMTNEeTVmcXhaRFkxVmlSRnRRRDZwZnV1UjQwbUcva0V0?=
 =?utf-8?B?RTcrdU1NYnphR1dSSjQ0UkVXVGIxaE5SZnVXcSsrN2h5cVFYQWJTWXdGV3hx?=
 =?utf-8?B?bjk4VWIyTVA0d01FV3VZcTlEdnEvUWJ2K1RqMmFOQWJiUm1zMkhmdnNoakh6?=
 =?utf-8?B?aUpCWTJqNnd1YmI1SHF3dnZiTDdnTGw1Z1BKSnAzNElFLzQyNkg4ck5NVmN4?=
 =?utf-8?B?SUVDMllOWEVhT1JNaVRBUlFWQkhVYUkvZU5EZS95Nk5UMG5DaDVtM0xUREJi?=
 =?utf-8?B?UGFUQjNpdWNlbHZxRGUrbnUvZHhVcERzeTJ5ajJra0pwTVhicDY2RmVnQ2ht?=
 =?utf-8?B?SzhqY1NnSUc4d29kV1FBQUl3ZXJra2lpYUZXLzYrTk1SeDlSM2dFQWFicDRt?=
 =?utf-8?B?STN6NjBFQnQ2UllNbWMzM085ek9CVW5OWFc1OVVuQ1VPQ002M2hPRzN3R1Ir?=
 =?utf-8?B?R3FLb0p4L2VRaXJZYkExQU56SVgxTVpOVlJ6Z1NyS1RxWmpHQ2g2dy8wSDY4?=
 =?utf-8?B?VzBSelVqd3g1RGV5NFFadkN4RWFXeFh3enRrTlM4OUJJN0xSclRRQTZ0QnVo?=
 =?utf-8?B?N2xVeUpSMk5nNURhN0sxNkhETkFMb3lBODVieG1lVnlsMVprTmN0T2ZaVk1Z?=
 =?utf-8?B?WGhnWlI5QmVjZW1hSThIVGdnWm1GQy81NWRiSmViT1ZQNFNJSjZoM2Y0azZW?=
 =?utf-8?B?U3BoL0RjNkIxK2FNTlZxOWJwTDZJckY0VnJoR2RpUkZTeFpvN2dKMGUzb1Qz?=
 =?utf-8?B?S0xtUjRrb3pMZEtkZWt1VmZuVzBQQVJVQ2dKemllZUhjd2RIZmswV2FlR0Rz?=
 =?utf-8?B?ZFdSYUJuMEhtci90dHMwV0VIanVaZ2NERTFKWGFVWStITGFmWExPNmV5WmVp?=
 =?utf-8?B?bFlrSm1IdHJvV2NrRHJib3lKSzlSREV0bXZJbE83dERmMGJRdDRIRVBUckhP?=
 =?utf-8?B?YzVOS3VOeTF5R3B3Sjl0Q1BBYU90ZXFvZ0d4dXA2Yi9uU0llemt5ZVl5anc2?=
 =?utf-8?B?ZEl1QWk0K2JxKy8vSVdCaHRNNkMyV2cwcEM3LzBEcmFubmhnWjlXMldNSE9O?=
 =?utf-8?B?Y2VUVTF3T1JmNDlEd3VWT214d3dscUF5YUcrRDExbnFJR3AyazJreEROTUpz?=
 =?utf-8?B?WWlxTTljREZDQmUvK3ExUXN5cHg1VGY4QkdsaHRmUXZJVHlaVWFCcy81Snli?=
 =?utf-8?B?d1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: IczIcvZMvSMRYekacIgv24E9cx4hpjhQp9VGcdDHccClaJ2dyY5OnT37w5/BBhvlumM5jLnmbgmbJFScz9IQGbzQajKYw4q6Ve3BkwZgjMpFtQ0PkIzmbOLm34Y5Q3FPvOFodDvTlVRdt0URU/FwubQ3NHTyRY5VmBsF+lxcEBuRtBVcpWqhSbLkgzqBpc0n3QoXlHrYQ09aoUxAkn1vNfvL6egW9/3kojIur63GoSl0yl+O2DDnc+1Vyi7Zjy51Yd2pD4xWgxt0O4SiEyNvWp3AufkFkxXt5VsYl9gyNwJIzXVEG5UZbi7oI6yiC9DejniGxgBNWnUbJOBbvUxEGWDO7MNfp3//60WKxZYJIVRUyP/5M/W+rF40GjE1iIMXPXL0phqZkl3z9w52Okj7dX8ZP27NT9C6pMOAf/nlyIiiV7oKZNCdDY28uROpvsDQTlxoA802zEx59OPz6h5SNC4AajvNF3MJIshOHuNMuQdYvnA0uMVIdQ+OwYEcuc+amWRYSPhF1HrZnVXho1eEj8BZUJ9YAC6wMyoZCNA+Ox5wmLr3XdlI+O0ehC3XEdHuQYaPCoK/mV8SIyj+jX93hjk/NOkcj6SO8mWkho4LYMc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31653ecb-64e3-4c67-169a-08dd50e6b54a
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5380.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 13:09:57.4381 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mb7QVqIApbhgtebZLxp3lnVvkkOjaFpx5+KpXcmoZ7RGSeTEoF9IW66B3w8sMM+mFE+yNGGgqVzhhpYUPLfirVdDwu7N1PElvupxjsfJ/d4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7836
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_05,2025-02-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxscore=0 spamscore=0
 adultscore=0 malwarescore=0 suspectscore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502190106
X-Proofpoint-ORIG-GUID: CGULU5nXzP7lHA1et619-YD6E8auBwpT
X-Proofpoint-GUID: CGULU5nXzP7lHA1et619-YD6E8auBwpT
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [External] : Re: fcntl27 and fcntl27_64 tests fail on
 nfsv3& nfsv4 for mainline 6.14 kernels
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
From: "rhythm.m.mahajan--- via ltp" <ltp@lists.linux.it>
Reply-To: rhythm.m.mahajan@oracle.com
Cc: "andrea.manzini@suse.com" <andrea.manzini@suse.com>,
 Darren Kenny <darren.kenny@oracle.com>,
 Ramanan Govindarajan <ramanan.govindarajan@oracle.com>,
 Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>



On 14/02/25 6:31 pm, Cyril Hrubis wrote:
> Hi!
>>> The test no longer fails with the revert of the commit
>>>
>>> cce93d3a3 Refactor with new API and merge fcntl27 + fcntl28
>>>
>>> https://urldefense.com/v3/__https://github.com/linux-test-project/ltp/commit/cce93d3a3__;!!ACWV5N9M2RV99hQ!IMGHSxQSJYhWjvrzfHgJc3CEekFq3RgaB1HNAyHJ7Z7IUpKS4eenQPuL6ZD9U6TCPpvJFkvTrbUJtIELXulBIQ$  <https://urldefense.com/v3/__https://github.com/__;!!ACWV5N9M2RV99hQ!IMGHSxQSJYhWjvrzfHgJc3CEekFq3RgaB1HNAyHJ7Z7IUpKS4eenQPuL6ZD9U6TCPpvJFkvTrbUJtIFE98p36w$
>>> linux-test-project/ltp/commit/cce93d3a3>
>>>
>>> Could you please confirm if this is a test case issue or a kernel issue?
> 
> Before the test cleanup it did only check if an attempt to set read
> lease on a file opened for writing failed. Now the test checks that it
> fails with a specific errno i.e. EAGAIN, since that is returned by the
> rest of the filesystems.

Hi,
Just to confirm, so is failing of fcntl27 test caused by this commit, or 
is it something that needs to be fixed in the kernel code?
After the revert of this commit, the test no longer fails.

Thanks,
Rhythm

> 


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
