Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 922D7C0219D
	for <ltp@archiver.kernel.org>; Thu, 13 Feb 2025 13:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1739452568; h=message-id :
 date : to : references : in-reply-to : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=+X5hs3jZwd0ClMc4coi8/jgGRbIwVnqeTUsA6J0VJxc=;
 b=ZaAAs71TAiwCHm7LJIv9awXPghNV+WAEdC4YmlPluzTHMy0PCZhQm4U/UdmM24nWYcf0g
 1Evx9vQv/riyqyNkkIBoqSiebDOlXvK2Ahy0E3SgMyW+kjf2FzbkpKF6qHVtrzBlK4EevVW
 NwXgHsam47H78RUlbEJ9ozHVd/m6ZNU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EA0BB3C9A9D
	for <ltp@archiver.kernel.org>; Thu, 13 Feb 2025 14:16:07 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ADD623C077F
 for <ltp@lists.linux.it>; Thu, 13 Feb 2025 14:15:45 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=oracle.com (client-ip=205.220.165.32;
 helo=mx0a-00069f02.pphosted.com; envelope-from=harshvardhan.j.jha@oracle.com;
 receiver=lists.linux.it)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 62FD210301E1
 for <ltp@lists.linux.it>; Thu, 13 Feb 2025 14:15:43 +0100 (CET)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51D8gFxK027363;
 Thu, 13 Feb 2025 13:15:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=3vFBIru+L5UVrc+B6FexkZbK3DBPybu1vlMfmHfb1Ik=; b=
 Bm+7SXIP8/9s4SFb5KpFNfOkG6cxdvqExXbJL/lUgeAkwircYwmjSWFPv46iVHbA
 28MfMmlppNv0O0a65zVzONi7qp6vQhPoKeugggo8WdPb6v4sdI/L85308/WQJuBT
 zL5Vr50q2vcTZJRx9uOanZi6LMIPmAkeTLqypFQWRkrFBsMIT8Ple8hNXBwhPI6X
 qjTifinZMzoUAh4Kn0+krhqVtFEM0Fvj/gJ63N5FcnUz5IUoXAvnqzGa/hZ/i1Vl
 wDVTHsNbf6NG4JVp8rxrlDpPTwaAfuu8wSma2VB3ZiB3JMgretceAGEp9bUOL6AB
 ScTuxKE2NlcFF+bczxLDqw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0tg9n7y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 13 Feb 2025 13:15:41 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 51DC4UO2012412; Thu, 13 Feb 2025 13:15:40 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 44nwqbp681-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 13 Feb 2025 13:15:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pdFbjzdJlGJbUKZSJ0ph4HcNz6Ms7eqP854EAqiyUCHPeoQJ1OOBKRrE+0nxEAjFQTKQvQOJQaVJNdYGVLf3FVnBbO72jmN3Jd8eJIwhKYNECmb553qKoKmSOaPNo6J/jCpUFMBJGHwwVrV1GONIQqKHrpW91bEYsKgfGiafDtpPJ+FfuxstuEJZxWzn0NFKKHCu94ivFWYrAEQDyIwBysNBLV/NngpgQFMN/VEcmqLRTuNLfTburs9MtGY+k12F+2aNRdPjOSXdMgtlHnca4W74YL+B8K9xbDotaxG6fYPNmFRa6fANICVv4OPCeEwyAOamVx9ReocFUe0CMUgF5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3vFBIru+L5UVrc+B6FexkZbK3DBPybu1vlMfmHfb1Ik=;
 b=nvlLgaYxrvrLNeiQpWQ8n5LWQkQ8ZYUfncBeFY0eJbc/sZuDy1owS6P5aMAvUjF9ZX+h7IWYU+bp9GGp5JJXuhvw+r6bLAX3byJQwbA+WvAKNFtdWU+DKsJ17qi9XYrYAlc8anPEH2J4s/I/qRdXM1K6P5MB3zqPENpJ6R2pS9e6P2H36cS7r0peeJWYpARbCKFUGHXp+CWDTbuhVzgag4KJqn/fGPnT6D8iccXN/9CnvBsZDC5g4/NnuOWzvuX75TVfBJBC3du8FSumgPCn84BhaT+le1cA5lu/mAvyPQbXhwVt1WgYs9flJLTCx+1Yx5PY26AJySLt2si9JykbOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3vFBIru+L5UVrc+B6FexkZbK3DBPybu1vlMfmHfb1Ik=;
 b=lqZ0HWfmGrrmDG5v/ZHQStlbr8oqzDOO42Kszz/H02PWCVfAfxSODja9YzfAoOPalDfgBDcQO4LCSqVOXGyd91W9qTzwlTRcB0vb+tsZTnDKuO31mGeD+1tLRIuTdwIU3aKMbwz6regv+4Ai1NPWcYSf4v+qVtnzgU1GHjgot9w=
Received: from PH7PR10MB6505.namprd10.prod.outlook.com (2603:10b6:510:200::11)
 by PH0PR10MB5896.namprd10.prod.outlook.com (2603:10b6:510:146::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.10; Thu, 13 Feb
 2025 13:15:38 +0000
Received: from PH7PR10MB6505.namprd10.prod.outlook.com
 ([fe80::83d9:1bf1:52cf:df54]) by PH7PR10MB6505.namprd10.prod.outlook.com
 ([fe80::83d9:1bf1:52cf:df54%3]) with mapi id 15.20.8445.013; Thu, 13 Feb 2025
 13:15:38 +0000
Message-ID: <7baba4f6-3560-4965-b62d-43efc09555fd@oracle.com>
Date: Thu, 13 Feb 2025 18:45:33 +0530
User-Agent: Mozilla Thunderbird
To: Li Wang <liwang@redhat.com>
References: <cf44d644-bfce-4c88-8011-7fa5c15a8d9d@oracle.com>
 <CAEemH2fxMxbApmaszJGLvRSG9e0T7ZAYUD=hxBSw9JFZgqan7A@mail.gmail.com>
 <CAEemH2cmPbDp15DOmOy3dmoLjRYHPcAD9Q_fts==EF8YDUJMGQ@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAEemH2cmPbDp15DOmOy3dmoLjRYHPcAD9Q_fts==EF8YDUJMGQ@mail.gmail.com>
X-ClientProxiedBy: KL1PR02CA0019.apcprd02.prod.outlook.com
 (2603:1096:820:d::6) To PH7PR10MB6505.namprd10.prod.outlook.com
 (2603:10b6:510:200::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR10MB6505:EE_|PH0PR10MB5896:EE_
X-MS-Office365-Filtering-Correlation-Id: 89492fba-a77b-476c-dfd1-08dd4c30823b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bmJTK1VzYTRzMFUzMDYzc2NLakE3K1FDZ3RWL1g0YnZrdFZLNlJ0VGRmVmdl?=
 =?utf-8?B?b0RzOHMyRGJEeEFqWHFIUWtTZFBUYlowWHFRWEhMdDdzRlFaeDdvU1lROFNk?=
 =?utf-8?B?RWVPankvWHNZRHBJcGdhbUp2Y3pra2lSTFNLUExyeEhoa2tidGNoR015TjFP?=
 =?utf-8?B?dkZDbGpFRk5qVS9mQUxCL1UramhibnQ0TFRZMEhSLzJCQUx5RlVMOHhIU2dl?=
 =?utf-8?B?ZkgyeGlXWXRQM1dXVitHN3gyU0d6cHBwT0dwN2ZaTHVGMGhXS1JkdU1ocDQ1?=
 =?utf-8?B?bmxXeFFWcHZJekxjbFlvNlU1eTBYL1B1SjFyMG13ZSsxKzBxd2VsZzM4a21K?=
 =?utf-8?B?WiszMnJtNUhPM1VqVmFTSG9ZTnJ6QnM3OTBSK0VmM2NUSGhRaEdneGs2aS9j?=
 =?utf-8?B?QUtFeXZnM09jdWNRRWh1SXVIR25sUlZjbGtvS05BcTE2Y1duZVFVd2dOK0NM?=
 =?utf-8?B?VTZSVCtRY2VFeHpCc3c2STBNUHNQVy9qQ0pRUlphUFJvRmhQNGk5WVNZZmZK?=
 =?utf-8?B?a241b3pmeERwaTEvUnhLS3I5UTJCdnhUVlVCWHZnRHhSakgybzdURklpVHZn?=
 =?utf-8?B?UzNTV080NXQ5Um92T2NidGVOd2d0YVAwa3Qyd2ZMZ2pxdTBuSStwYlpvTm9k?=
 =?utf-8?B?TG1GbDNYT3VpNGdiR0JOTmcyTjR6bzYycmtPSS9nQW9vZm5tdllYVjY0TTVx?=
 =?utf-8?B?aGppOWFjN0FHeFF5aEhuY0FYcWVhaGRsa3grK2lUODcvTlJvOTRlb2JubTFB?=
 =?utf-8?B?NUE3N1RTTGwvZCtRNU0vWVRhQXVOSG1SWFBCTHg2b01pbmpnMGpmdzFWOUxl?=
 =?utf-8?B?QzBDUWt4NGpTZVk0SkFnN0R6SzlWcGhhSVFyd2ZSellWVzhobllVcys0dDRG?=
 =?utf-8?B?UUJxeG5maFhKZWpLTlIwWjRqbzlwZ09kS2IrdHBaeldHUStLT2JLMHBzV2xi?=
 =?utf-8?B?dzZzZWdUUzdzU1ljY2VOclgwMlV3bkVhTk5pL3luS2JMMVZ3V1o5NysvTGNU?=
 =?utf-8?B?UXNHaWdEQVEzSjhLMzF6YnRGMVIwaUcrMnpIaEZxNXEzN1VrZW9ING9kYlM1?=
 =?utf-8?B?OWFkQ1dGRTFHbzI3VnlPSzAwZzhBdXZ4bVg3Uy9UaytvRkVkTVdSZzE5S2lz?=
 =?utf-8?B?OXdlTzVJNVE4UUgvRTJjK2E1a2hGREhDSmlFUVpXMHRibTBxZnM1R3NZVytt?=
 =?utf-8?B?TXJRRnRvWlp1NjJjSjBrSEl4dHJNRkFpU2FCclI3UWVicDB3c1FDSy9rYW50?=
 =?utf-8?B?YWtDaStNM05uVFlFTmErQkpjSkRGOWJVRi9IbDF5dllheXU0VFpBN2JqZHB0?=
 =?utf-8?B?VFFrc0NCYnAxaXNqZDRMblRnYTV5bDRqd2FzMUlaWktiWkF6dnhHZFRvOVh6?=
 =?utf-8?B?MDhzZWpnSlRYemFaM2tnYzBaVFZreUd6dGJsYVBKUFNJeGI4MnBMY2laakg1?=
 =?utf-8?B?MDRNdGQxYnRKdHlCbXFTRndNNFhQaVpHb0xPeVRuUEtEWHY5QWtmTkw3NElm?=
 =?utf-8?B?SVY3a0x6NTcvR3F4ekRmcVBHcHB6WTN6NUllcFNja0xkTHJzbHFDcE5IZlQ2?=
 =?utf-8?B?OTRleXJJSWgxSDlMMHBlbEJzYlMzczY4M0VsSUlmc2JrOUNKVTJxNEVEcklk?=
 =?utf-8?B?N0xkWTBveFRQZEFPREFhNkVXQVlzTmJzdGpuRmdRKzRYdE1TN0dBRkVwZGRZ?=
 =?utf-8?B?WlN3ZXd1WkVYNGVQNGk2NmlUTHlteFh0NUtsM21MNFp4ckM4NUszMyt5SWxY?=
 =?utf-8?B?RER6VzdLbDdKWlZ1SEJNb2NnMXlmQzBETFh2aVBxU3ZVQmdQYStSclJneGl3?=
 =?utf-8?B?ZUZjRytwNi9Oa2xITCs2UT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR10MB6505.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(13003099007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZW50UW4wUzlyTlJ3UVRTQ2NvclR1eFBIVWthYmdwNmlkRUw3MGJwNmV4WGdZ?=
 =?utf-8?B?b2hlK0x2TFdEbEExbTZpMTBzd05pYjhMZTQ3ejBORWw0Vnp5YVhHU3hsRmdP?=
 =?utf-8?B?RFVXc0N2U1V4WUdUSGQxTUJkaTVOWXZKTDdZMXNqekhkcVVoV3VXL3c3TlI4?=
 =?utf-8?B?cnRJdzI5YkhITTA5SW13YTAvK3hqSzUzSWdrWXFkWUV4bkpQOElFZ2lMYkdW?=
 =?utf-8?B?QW43TldDK3BOTXVUSjV3eDJ1MmExMm91ekZtWGNZZWUrTHk3ay9pS1pvakxF?=
 =?utf-8?B?ald5V0RDUXJIaUwvSzkzdm9QL28yYmVqZ1pINVBBcVhQbSsrSjFHVTZwcmFB?=
 =?utf-8?B?K3MxdzdtSGpjbXNEMnRZUTcxYjdXWThDREUwZ09wMXlkNXd3YnBUbTlsb01u?=
 =?utf-8?B?L1dQWHZSRisvcHNjRHZ2QkQ1R2s0NUkyRVJXdVBtOE1YclBQV3VCQ2VnTE5w?=
 =?utf-8?B?WU1ZZ1diVUQ5Z25MM3M1TnNmY1ZaMkc2cGZzaEQwMDh2aVlEMnZQU3haNTVD?=
 =?utf-8?B?K1VYbWJHQTdEZXFOVlFjVHJFbHZsSWdzakZINkxUVEl3azZCREZxZG8zK2dI?=
 =?utf-8?B?S21sVmJCTmtiSkpsa0Z6aGgrdjlLWStCT1ZPaFlPY0ZUWXQ0K3dBbzd6V2Rk?=
 =?utf-8?B?ZytLRDJ1NVAvcTVINU9ZVzZScXBjdCswbVRaWWdseEtkKzZUYVI1M2QwdmxR?=
 =?utf-8?B?MWNQNG1ZWDJSL2tVTEl6M0lPV1FQanJRRlJZVUczNWZSQ2lTaVVqWmN3ZGsr?=
 =?utf-8?B?YXZ4UXUxNW1tdnJVZytkeElnb3dsWFhwVUxaeWt5TDNIdG5hb3l0djA3Vkt0?=
 =?utf-8?B?V051Mld2NTcrYlhLcGtudHRRR1lZOHVQRWg5aHVvRk8xSjFSTlYvd3k4eDR5?=
 =?utf-8?B?UW4rTjIvMFJyN0VNLzl5ZEluNUdLM3lDalVqU0hZL1N0a0dlbzRuL2FTMnJn?=
 =?utf-8?B?dnlZb3pNTjQ0THdoWDJYQkgwOFowcUhQdDFUKzBKMU94VWpVaDdjaXVXeDBW?=
 =?utf-8?B?dmxyM25IZFAzWW1ta2FHaXR1WnRpbjg4bUlxRWErM1h0VzA1U1hTbS9Gd2pT?=
 =?utf-8?B?VWFkcnBVTGZWYXRkWFM3dGJpR2tLa2F6czBQaDM0b1dPY2hPR2pEQjVqVmVr?=
 =?utf-8?B?cWlKdG93WmlBSGsrVUxVZHovanZjWDNmMUlidWpBSnRmNzVOMFpwMXlHZ2FV?=
 =?utf-8?B?WC95M2YvS1JZN3RxdFpMczJpaUZFNG9vSDF0UTNSQmVreExjV1Z3ejFwMnR2?=
 =?utf-8?B?NzdwSTJDOFB5bDkzbTRlZ0VzZEJIRENVTisydVB3aFl2WGxuVmc0OTRQWk94?=
 =?utf-8?B?YnVldzJXcnVIa2dPM3laWWROSmhTZmFoV3dMVHBVWEYvZnpKdzNPWWROZU5P?=
 =?utf-8?B?YmJXQ1locC90Z2VwdzhKM01DRFk0SW5WQUo1T2Q4dDJqTVBiQXI0UVFFcUxZ?=
 =?utf-8?B?K3kzd3A0STNNakt1Z0ZYcGxpc1Izd0dTdW5NTWlud0hwd1EwRFE3OXgwUzM3?=
 =?utf-8?B?R0JmaEVZRCt4UFJFR1ZJOS9JSFlibHpDSnc0dDN5b01HejArSnB2bVU0U1gx?=
 =?utf-8?B?RUdWVXRBakFyUXlZZXdrUlVwY3NUemtSc01vcUJta2Z1YytLdVI3NUY0L3gx?=
 =?utf-8?B?U0xuT2VzVHBnREtJUUl1VE5lMFdZUWUrNkVHZUtpT2pRd3JTR1h6eERmWlNB?=
 =?utf-8?B?TmZ5MUVEZHNtcE9EQVNFQ0tpTHM0RFMvUElOY0hpN2lWWllMTGZpd2F2Q2hj?=
 =?utf-8?B?YmdHblNIZlRsZ01pUlNBY2xkVW9BWTVKQStCSDBYejg3M3NiK01ROXZFNUN6?=
 =?utf-8?B?dC9Ia2pxUDBqbHk2bGJhcmQvaEZjbXBNZ0NocUNmTzh3SDdKZFJKRTluSUc4?=
 =?utf-8?B?UlhtSlE4cWdNeUV2djlPbGw5OUlQaEtiZVY5QzR0OEVxN1R2SDBPbWFCc1JK?=
 =?utf-8?B?NGovaG9WUU1YaXhyQ3o3QWhRRzlVZ1RoS2FJd1ZGQ3hGUUtOTnRTOEwwYjdo?=
 =?utf-8?B?WHViVUNNWGRBOWw1cDh1RnBxdjhGb2hIMFo2Z0hpdzhyQVFveEIvazVqcHRX?=
 =?utf-8?B?ZEN0L3pheUxEbmVZcGhIM2RGdmlJTmdOa2F0UjUwQjhhRmRzZXBrQnJXN1hV?=
 =?utf-8?B?eXd4MUp5L3dBRVVjdENPcTRaUkNSTW10Uk93UXBqVTVZVVpXdkl4R0Ywa3gy?=
 =?utf-8?B?blE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: iNIMN4G5498L+9Syq/VZLodJEqSz5+kYNa/baByui0SDkDGgW9+W8W4mMqUIKviufiuP1wiPd7lq/ImY4CjzlYWOrC76TMQqSN+W4w08jt/etGiol8TxvIG5e05WJUwWtn6tXS3Z+y9E7TWQ/HxZD6HaftgaHPjEQi5gIctRu84j2jpi/sHuX5RYiAmWUxnQDlyjHOEnlXyvIlV8VuydhzK+ZHiUw01K2dVzcbaG0r+ABKhYARF37vDm9UbDDASYWiA1V5RcTDymK1ouRmf0TkNkDajtLuI7v/ZKiOMutyuYLl77FvPlRU/sk/z/kROCo0sYj2E5cxZABTQfqUl4+v28iEsChExdz33X7K0sGlkIOeTthfQBwCLAkmK7tpjOMzH+CukBHZtvRrWF9THBYahoVC5iNoJgJAUVRYC9Sd5i1wnbuOv0kiiP88JHQrCvwFdAUcXMBzR3BQswzdNGc+MlIY/Kf81Wbn1uBZFIOB5grdKbkXUz1ONhww/A89TGNbQNBtNly0lmjisL7U9VF1cCKm34vWCOUjwPTQyaFoLeb27+Hvr93ZBZJZugee823iWEToELJjc8VRZqlJW/CiWfsOT7gjnovxJii86DXZg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89492fba-a77b-476c-dfd1-08dd4c30823b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR10MB6505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 13:15:38.6756 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tqQOFz3oSAtAJDJ5DMJxsEz1bnV0oJkXU9xcQyr8oADEZIW+ugnlJvgmBTIHPEFRTDmHAHySLT6u8OKmEXoImL4Kf9+oVGgLVgPhyJWKC5Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5896
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_06,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502130102
X-Proofpoint-GUID: J0y3FNKZXe_tPEz3CDwVbAviHPtZBJZx
X-Proofpoint-ORIG-GUID: J0y3FNKZXe_tPEz3CDwVbAviHPtZBJZx
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Test failures obtained on 6.14 kernel in memcontrol04 test
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
From: Harshvardhan Jha via ltp <ltp@lists.linux.it>
Reply-To: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>
Cc: cgroups@vger.kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Ck9uIDEzLzAyLzI1IDU6NDcgUE0sIExpIFdhbmcgd3JvdGU6Cj4KPgo+IE9uIFRodSwgRmViIDEz
LCAyMDI1IGF0IDg6MTbigK9QTSBMaSBXYW5nIDxsaXdhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4K
PiAgICAgV2hhdCBraW5kIG9mIGZhaWx1cmVzIGRpZCB5b3UgaGl0Pwo+ICAgICBDYW4geW91IHRy
eSB0aGlzIHNvbHV0aW9uIHRvIHNlZSBpZiBpdCBwcm9wZXJseSB3b3JrcyAod2l0aCBDZ3JvdXAK
PiAgICAgdjIpPwo+Cj4KPiBJIG1lYW4gdGhpczoKPiBodHRwczovL2xpc3RzLmxpbnV4Lml0L3Bp
cGVybWFpbC9sdHAvMjAyNS1KYW51YXJ5LzA0MTY1My5odG1sCj4gPGh0dHBzOi8vdXJsZGVmZW5z
ZS5jb20vdjMvX19odHRwczovL2xpc3RzLmxpbnV4Lml0L3BpcGVybWFpbC9sdHAvMjAyNS1KYW51
YXJ5LzA0MTY1My5odG1sX187ISFBQ1dWNU45TTJSVjk5aFEhTU5CRmhPcmZUVVhiZGpHOEhhZ2Zt
SXRxcUQxSTFOX2RuNVFqbFd2OWktS0FlRUpIUzBOcTY3ZkUxc3BIRVFSRDJpYTRHMFBkblpRWDFi
TXJQOHFDUFEkPgo+CgpJJ20gbm90IGFibGUgdG8gYXBwbHkgaXQ6Cgrina8gYjQgYW0KaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvbHRwL0NBK0IrTVlTbUFqRlFUYnQ5OEFaai1DUkZTV1QtZE1jLTNk
QWQ1bVE9UzZyREVZcStTd0BtYWlsLmdtYWlsLmNvbS8KQW5hbHl6aW5nIDUgbWVzc2FnZXMgaW4g
dGhlIHRocmVhZApBbmFseXppbmcgMCBjb2RlLXJldmlldyBtZXNzYWdlcwpDaGVja2luZyBhdHRl
c3RhdGlvbiBvbiBhbGwgbWVzc2FnZXMsIG1heSB0YWtlIGEgbW9tZW50Li4uCi0tLQrCoCDinJcg
W1BBVENIIHYzXSBtZW1jZy9tZW1jb250cm9sMDQ6IEZpeCBqdWRnbWVudCBmb3IgcmVjdXJzaXZl
X3Byb3RlY3Rpb24KwqDCoMKgICsgUmV2aWV3ZWQtYnk6IExpIFdhbmcgPGxpd2FuZ0ByZWRoYXQu
Y29tPiAo4pyXIERLSU0vcmVkaGF0LmNvbSkKwqDCoMKgICsgQWNrZWQtYnk6IFBldHIgVm9yZWwg
PHB2b3JlbEBzdXNlLmN6PiAo4pyXIERLSU0vc3VzZS5jeikKwqAgLS0tCsKgIOKclyBCQURTSUc6
IERLSU0vZ21haWwuY29tCi0tLQpUb3RhbCBwYXRjaGVzOiAxCi0tLQrCoExpbms6Cmh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL3IvQ0ErQitNWVNtQWpGUVRidDk4QVpqLUNSRlNXVC1kTWMtM2RBZDVt
UT1TNnJERVlxK1N3QG1haWwuZ21haWwuY29tCsKgQmFzZTogbm90IHNwZWNpZmllZArCoMKgwqDC
oMKgwqAgZ2l0IGFtCi4vdjNfMjAyNTAxMTVfZ3VvamllX2ppbl9tZW1jZ19tZW1jb250cm9sMDRf
Zml4X2p1ZGdtZW50X2Zvcl9yZWN1cnNpdmVfcHJvdGVjdGlvbi5tYngKCuKdryBnaXQgYW0gLTMg
Ki5tYngKQXBwbHlpbmc6IG1lbWNnL21lbWNvbnRyb2wwNDogRml4IGp1ZGdtZW50IGZvciByZWN1
cnNpdmVfcHJvdGVjdGlvbgplcnJvcjogY29ycnVwdCBwYXRjaCBhdCBsaW5lIDU2CmVycm9yOiBj
b3VsZCBub3QgYnVpbGQgZmFrZSBhbmNlc3RvcgpQYXRjaCBmYWlsZWQgYXQgMDAwMSBtZW1jZy9t
ZW1jb250cm9sMDQ6IEZpeCBqdWRnbWVudCBmb3IKcmVjdXJzaXZlX3Byb3RlY3Rpb24KaGludDog
VXNlICdnaXQgYW0gLS1zaG93LWN1cnJlbnQtcGF0Y2g9ZGlmZicgdG8gc2VlIHRoZSBmYWlsZWQg
cGF0Y2gKV2hlbiB5b3UgaGF2ZSByZXNvbHZlZCB0aGlzIHByb2JsZW0sIHJ1biAiZ2l0IGFtIC0t
Y29udGludWUiLgpJZiB5b3UgcHJlZmVyIHRvIHNraXAgdGhpcyBwYXRjaCwgcnVuICJnaXQgYW0g
LS1za2lwIiBpbnN0ZWFkLgpUbyByZXN0b3JlIHRoZSBvcmlnaW5hbCBicmFuY2ggYW5kIHN0b3Ag
cGF0Y2hpbmcsIHJ1biAiZ2l0IGFtIC0tYWJvcnQiLgoKCj4gwqAKPgo+Cj4KPiAgICAgT24gVGh1
LCBGZWIgMTMsIDIwMjUgYXQgNjo1N+KAr1BNIEhhcnNodmFyZGhhbiBKaGEgdmlhIGx0cAo+ICAg
ICA8bHRwQGxpc3RzLmxpbnV4Lml0PiB3cm90ZToKPgo+ICAgICAgICAgSGkgdGhlcmUsCj4gICAg
ICAgICBJIGVuY291bnRlcmVkIGEgZmV3IHZhcmlhYmxlcyBmb3IgbWVtY29udHJvbDA0IHRlc3Qg
b24gNi4xNAo+ICAgICAgICAga2VybmVsLgo+ICAgICAgICAgVGhlc2UgaGFkIGNncm91cCB2MiBl
bmFibGVkLiBUaGUgZmFpbHVyZXMgZGlzYXBwZWFyIHdoZW5ldmVyCj4gICAgICAgICBjZ3JvdXAg
djEKPiAgICAgICAgIGlzIGluc3RlYWQgdXNlZC4KPgo+Cj4gICAgICAgICBUaGFua3MgJiBSZWdh
cmRzLAo+ICAgICAgICAgSGFyc2h2YXJkaGFuCj4KPiAgICAgICAgIC0tIAo+ICAgICAgICAgTWFp
bGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCj4gICAg
ICAgICA8aHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vbGlzdHMubGludXguaXQv
bGlzdGluZm8vbHRwX187ISFBQ1dWNU45TTJSVjk5aFEhTU5CRmhPcmZUVVhiZGpHOEhhZ2ZtSXRx
cUQxSTFOX2RuNVFqbFd2OWktS0FlRUpIUzBOcTY3ZkUxc3BIRVFSRDJpYTRHMFBkblpRWDFiTXVi
TmxwbUEkPgo+Cj4KPgo+ICAgICAtLSAKPiAgICAgUmVnYXJkcywKPiAgICAgTGkgV2FuZwo+Cj4K
Pgo+IC0tIAo+IFJlZ2FyZHMsCj4gTGkgV2FuZwpUaGFua3MgJiBSZWdhcmRzLApIYXJzaHZhcmRo
YW4KCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5m
by9sdHAK
