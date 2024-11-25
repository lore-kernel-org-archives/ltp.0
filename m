Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02F9BD58D6A
	for <ltp@archiver.kernel.org>; Mon, 25 Nov 2024 16:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1732553838; h=message-id :
 date : to : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=38h+eaZeV3n0TjXXFW+IlbQFZPmdDKni1BWbRTZcfIY=;
 b=SpyQBnaeN/Gn14XyyX2D+dAM6E0E+BWnDVXDGFpfu3fTiByi/M2O9o00T6CBmrdwUQDmX
 H6OYglcLQEat+hQc2+q7mybsQsPbjrr4/rJly+Rb2jDiTYJrL18W8bJLScacvgs4Ry5Jq5h
 vfo9+KsoOyaOPY0I4q8HvTgqCOBcjSc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0E6213DACE1
	for <ltp@archiver.kernel.org>; Mon, 25 Nov 2024 17:57:18 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2643A3DACCF
 for <ltp@lists.linux.it>; Mon, 25 Nov 2024 17:56:57 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=oracle.com (client-ip=205.220.177.32;
 helo=mx0b-00069f02.pphosted.com; envelope-from=harshvardhan.j.jha@oracle.com;
 receiver=lists.linux.it)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 508A6212FC0
 for <ltp@lists.linux.it>; Mon, 25 Nov 2024 17:56:55 +0100 (CET)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4APFfNH0008453
 for <ltp@lists.linux.it>; Mon, 25 Nov 2024 16:56:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=corp-2023-11-20; bh=RpgvtQ5N1n+/0pBr
 XXqrlBjHhzz80Yru8mf9mqThjvI=; b=c16q8HjRazxE41Z8Wk9eCahoWoUTBMEU
 LMFy5la96Fk1tQPS4M/If35MnPJoPBIV7tWwALOIHNLRaoGmISahE4skJmwKgdRp
 NMWInwKwXHX2B2iflBrxjgoY3boqBwBRv8wCy6eJvLJ5S0nWqGeeN1r9Oqri2gho
 JqfEkeh/rh10MAH2aWKYE4kIRBAi/MlGPh9JxXe99uPMyGUrmpvxFBnQLx7jnEwZ
 gsghEkl1Nt4FKBxHySHjZUnl0qA1hH464DZ41zC0MLja5Vso3mgCZpid4UrmWLJL
 llJqXGN1fqjC572j3+fXJiUZ4+y86iHSNTjFNcln7148UjAO0FoiLA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43382kbkte-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <ltp@lists.linux.it>; Mon, 25 Nov 2024 16:56:53 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4APFoi49027076
 for <ltp@lists.linux.it>; Mon, 25 Nov 2024 16:56:52 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4335ge556s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <ltp@lists.linux.it>; Mon, 25 Nov 2024 16:56:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QjX2I0wSWmimAV0bGyQff2IUD7ZpBGwGvTeDvOlvmUZlV0ZmgBclPgPsVogtPFHVIwaWathbJFnQeS2OHUha5ElTY4jUsAxdNY4SCp0Oh0J4sXAoZDH23rFNnIc+Rn0breNNxD5JLcGy+BNGeg5mjc46h8EfwZA66PSznFWdRJN4weZqO35YB50MCyi3cpdmvkX2ReMiW2kq9dTChW6cUSjqG9/RTmzgwBtIi8qekZBm1D5P4tNWamxpBCimgXNxBRP1I1vVAw0BQ0zATKcW6Gc6CyHwXIkINp82KNSAg8rbEA31D6qvJU8X80jAEvirgr1M3kyBLJL9dpAfp8gnYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RpgvtQ5N1n+/0pBrXXqrlBjHhzz80Yru8mf9mqThjvI=;
 b=Gud0kLLrBImSBBIRKNRcFW4i/69LXmdL4Od1w1Dfrhb7Rgo0TRJlagJYr/Nfd4iiRoh3wrbohgK2GgeTAJZFCDJAfdYRLvBk/qjX4u7ZZih/04f0MHGgtvTI9N6JEHlzx+JvcTL6R91IXpQrzwZREITJH/SspyfmX92r6LuV6d6tSxMMJCtrxbdpI9VYt7zkm3CA60PvKhm5kYCxuTM4yxVvM4hquJxobf1T469PLD7xHOwCfV7GQLWgm0TPIBJOVvlSW0GpJkJD8ksMM9vgCYLcN9hBldZL1Kl9H6+9eGIX27flkCRRFuyIoO30AAgq003Vva/gYURkuULLZDdptw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RpgvtQ5N1n+/0pBrXXqrlBjHhzz80Yru8mf9mqThjvI=;
 b=ULRK1AL3ABlPwG0DcRgzvTRWfVnaZvse4AXi6tZq/eXGX2PoDbZTjQDp0O7AIYz7pg/XKFdHoJpCD0SmyIYHqdjF0jkeZiUP1UOoYf9cmeogHgynOomVAEy8QlcB8RDg3Oo3r1MtMs/Bqpw4uJL67+NFra7VBsWm0AGIn125fhg=
Received: from PH7PR10MB6505.namprd10.prod.outlook.com (2603:10b6:510:200::11)
 by SJ0PR10MB6423.namprd10.prod.outlook.com (2603:10b6:a03:44d::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Mon, 25 Nov
 2024 16:56:50 +0000
Received: from PH7PR10MB6505.namprd10.prod.outlook.com
 ([fe80::83d9:1bf1:52cf:df54]) by PH7PR10MB6505.namprd10.prod.outlook.com
 ([fe80::83d9:1bf1:52cf:df54%3]) with mapi id 15.20.8182.018; Mon, 25 Nov 2024
 16:56:50 +0000
Message-ID: <252cea0b-67b3-4843-a365-a4a9cff6e24c@oracle.com>
Date: Mon, 25 Nov 2024 22:26:45 +0530
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: ltp@lists.linux.it
X-ClientProxiedBy: SG2PR02CA0129.apcprd02.prod.outlook.com
 (2603:1096:4:188::19) To PH7PR10MB6505.namprd10.prod.outlook.com
 (2603:10b6:510:200::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR10MB6505:EE_|SJ0PR10MB6423:EE_
X-MS-Office365-Filtering-Correlation-Id: c2f6743b-8d0b-4f20-1b8a-08dd0d7227f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QmQwa0xEcmFGYmhmaWx6OEZLMEgxMDlRMTdYeGxyVHlxejUxMm5YY0svcU42?=
 =?utf-8?B?M1dyQ2laMlpxbUFQWktMYUhOeWdjMGJFYXVGZXFzVUVNbnJrS1ZzUVRETlFs?=
 =?utf-8?B?ZldubkVKQ3pUR0hJcldiZ0dpNTNTcER2RFl5MDVxSDR6SU9JTTNrTmdYNFZ1?=
 =?utf-8?B?U05GUHdYL3BJaEZrM3h3OGcxU2R1NUFaVDZkZGlZSXlSR3JPREt2T09kWU0z?=
 =?utf-8?B?ZVY2NktNYmpkbmV4cHhvTVJvM1Q2MHJrVWxid2MvS0kvVk5FUEk4Q3BtNFo4?=
 =?utf-8?B?NEdxMWhPbUtXdVZNVXRLVEYwb0dyNFc3UXJ1NGZrNmk0MExDM08ydnVtczhF?=
 =?utf-8?B?YU5KTVBVOW5PaDl3N0dwSVExa0xVcTNPUGcwRXRod2JOSW01WFRXck04M0Zm?=
 =?utf-8?B?MHVFZ0NqaU1LL1NMVllxcmdIN2d5ZzU3Z0dXZzl1cHYxY0xjZlAwVUliQ3k1?=
 =?utf-8?B?L2xZOGRwVHRHeTZSdUlFT29lQzBzbjFJVHpieFA2ZUxwaWlFMmIzVG9PaVEw?=
 =?utf-8?B?dGx0SExRU3d4UlNWaUZUUjVjaFNxMUV3a0Fvd2xUUmgyMTFQb2QxZlFjQVlT?=
 =?utf-8?B?eWorbHViSEJ6dGt4OGJSRi82UGFXRE8xMW5lVmUxMnFYMDA1Uy9BVkl4Z0Yv?=
 =?utf-8?B?amsrVG5TUmYxdGdzZmtJNnV6MS92VThjaHgvekM0aHB3WjVMazhBQWpsa01L?=
 =?utf-8?B?QkdhVDJCQzlVb3d6N3R4ZGxPL3pwTDZnVi9vdTJIQWt6RVRMQ3NHR1ZpL0lp?=
 =?utf-8?B?MWhMaVVtTmZ0cjRhNmp0ZkhhMjZ1ZXR0VnJRQ3I1cEE1YXlWNWtVT0lqcDdG?=
 =?utf-8?B?djRVYVVvYTZUNUF6Nm9nM2ZCS3h5dEVNODlrb04wdHZjbFBna0g3NHJEYUhP?=
 =?utf-8?B?Rkh0ODFwbVY0R0xDTTFCeWc5UXhQL2RmUWRJTlZBYlRBMG04UkszVzVqejJI?=
 =?utf-8?B?T0N0UkxkSm1Fekhod0xXZENnZ1h1ZVJxd1NjTW1EOWpiSDROUDk5MVFCRm5j?=
 =?utf-8?B?K2pydnhpeE9kcDhuNHZSMStrdFQ4YitZME9UQ3VDak5VSFhlektKdE1IeGh0?=
 =?utf-8?B?S3NkdUtqSUhCWkRPM0lmU2VHZGN6a1RFK2d3TlpsTzRwREwyc1l1NEtrV05u?=
 =?utf-8?B?empKWXFKR2g5enp1a3VwS20zdlFVZFNFRG85Ty8yTDNORHJ3Qzl1TjEwZ2o4?=
 =?utf-8?B?VlBDVjVPRzBiaTZmUHhZRzJOQ1VJblhROW4zRkpOOGJUTEV5eWNHSktFNzRm?=
 =?utf-8?B?ZnNrK1l5elFIdWhISVNXbm1aKzN5U3kreGQzdGN1THl4bFJDQjNrQTdCY3Ny?=
 =?utf-8?B?dU5nVG9oVVBvWnI5MWNKN3BQYUhzanJJMnl2SHB4b3g3S0d2WjRQby94dDA0?=
 =?utf-8?B?Mm03L2c4TmQ1MjJTMTBUM2p0cWpXMGU5UXFaVHJ0eDNGbnlvUFhuUUpkR1F3?=
 =?utf-8?B?WU1Pd2lONXhaRk04WWx4L0Z6bXFySHUwWnBxZEpmLzB5cTA5Tyt0Mk16VkFt?=
 =?utf-8?B?UURCdUVPV25LdS8xR3VhMWhBYlhTdFdGTE5kVGhNY1B6ZGQ4clk1eHNMYzkr?=
 =?utf-8?B?ZnFKbWdTUG9xZFJ0U09JeEp3bGdaaWlSSy9YNnZ1Y3R4aEs2NlVNVDA4cTZM?=
 =?utf-8?B?MHRHM2lXMGFpN1l5LzBQcmZWLzFkTHV5S3JGdHdRY3hmNklSc3d2VGhIdHhO?=
 =?utf-8?B?b21Hb1h5Y0pJR0t2S3RYUis5cGZrSzRQYXkvZFhOU3RlazAxRFpuT2Fwbkd1?=
 =?utf-8?B?aTJMZDhlWGhvZVdNYkptZ1RSaXVaUyt4SHM1Ty85REFLdjZ1UjVsWGdLQktN?=
 =?utf-8?Q?KKRyOLnVF4l68fuTUHYnTq/EH+XZW97zsannc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR10MB6505.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHVtSWtWQ2paVElBZWFiaUNqL05Xc1ZwK0MrNHczWUFneG1QWHp1cTk5SktY?=
 =?utf-8?B?QWpkTkJ5TGZUQjdCQWJJUTZ2OVJad1ppRk50UkQ3bXgvQWZTOXdqd3FLdjVE?=
 =?utf-8?B?NWQxK01heEV0b2lmVDJGT05nUlZYNFdpVGdnRDdWMnVuZUw2ZzgyQU1UMHdl?=
 =?utf-8?B?ODhWS01MbjY2djJhMHV0Q1VnNGcrcmhyMWFvZ3pOeGx4RUpmSGNPZ0ZIaHdD?=
 =?utf-8?B?UXNiRGd5TEV3Yk5lWTg4MEN1SjR1WkxPV3FmQ1N2VVp2d08yV1h6a1U3SnRm?=
 =?utf-8?B?WHZGN1JYNDIxbWd2NDBMTitaZlNkNFd2RjlPWUxPRStCT0RVYXJtTVRVZGVY?=
 =?utf-8?B?WUpkb2ViUFRlYmljMmw2bjdHWHh1QlNGREozdlpzN2JWODRHc0ErQ2xvaTAv?=
 =?utf-8?B?Z3hNN0N5c2xKdkptUFNnUkVXRU9HQXZLVW5rMm9hbmpKN3NNdmcwY3VlQzd3?=
 =?utf-8?B?REEra0EvTE55ZytTOCswYUU3eThzWTMxNWo0RzFKa0o2ajJadEhyOElmMVlH?=
 =?utf-8?B?dXRNZHZITjlyRW5hK3M5YldFUEVlb1VGWVJkaW93dTBZZjVRSUtxS1VBTm4v?=
 =?utf-8?B?eU56T3RoS29sVDUzYjNzRlM1V1dMV3lSUndFTUV6YXh6dDRrZmRPRWVURnlr?=
 =?utf-8?B?Y0tjWDkvSlVtV1NaUjcyTEEzbEcwSXRjZTA5enVOMWd0dytnTE1HYkFsaTBi?=
 =?utf-8?B?cjZQOWF1VThndEZscGRsenM1S0QyQXY4NmJ1dkNRZGswV3pFb3N6bXpxaUo4?=
 =?utf-8?B?SW5Ibi8wLzJqa0RNZGw2WnJtZFNQZ0p1NEltdWtFd2IyTkdwd1JmY1k0eEdQ?=
 =?utf-8?B?V3lHL1hQRFZyWU1Xc0VjZDJ0ekd0SHFTTXo5MWpuWXhxQkVRakl4VmZOTlJP?=
 =?utf-8?B?bVdRQjlXekw3bGp6MVN1eU9tUDJsZnlpK055cGQ1TjBBN2FCUDJ2YW0ySkww?=
 =?utf-8?B?Q25vTFY5M1pva1Rrb2NGQU5QZ1NWK1pjNDg5SzlROFVGUzJGWTFkTGhySVlK?=
 =?utf-8?B?VHJPQTNyN2wyUGJrWUJUL1d3K2hXbDQ3YnJiaS8vejJUTG5tWWh4OStpdGlL?=
 =?utf-8?B?MEsvUVp6OW96eklHelhaRHA5SXBna1EvU1A2VXRrZWZxQnZMNzBpbk04RHB3?=
 =?utf-8?B?a2Z3YWEyc0l3bFZGL3RmalpmdTdsY1M2WmJ3bUJGVWdwdVVTL2Z4VTNoeTRI?=
 =?utf-8?B?ZHV3ZElkU3ZFTjkwV01WcDBIK1ZPWWhoejRuTy9zcXhHWHRCeGJpWkhoT0N4?=
 =?utf-8?B?WDY3dUZVVjBFU3JVT1JGeTFtM1BCOXkvcEJHTXR5clFzNVhTdk1aWUZLclQ2?=
 =?utf-8?B?R3RLMUZnOVhxakptL296WHVMS0s4UERXK1RYQURvdnZDMnp3eWJSTnIvWGRW?=
 =?utf-8?B?TTMrZHp6aWFRM0k0aEFtN3hzMzBEclpkU05QZzBhRUZNRXllYlJxN1hRbVdS?=
 =?utf-8?B?ZEc3aW1jZDZtd1BUTWNWOUVNbUhPSDBMOXlFalVNeHNtT0NRK0hSTXJmcWFi?=
 =?utf-8?B?ck85eENOVklMVlhCTm1WRkR1MDhvNmJhOGwzdkJGR0h1YzFYb3lhU0U0Qjlw?=
 =?utf-8?B?dWc5emppQTBpcmZ2Vmp3d0d1OW5EbGV6aC9kYXVWTHZKRzZ0R1JETnRTakEw?=
 =?utf-8?B?RERGVUxCVUZBZFpoR0hKckw5eTV0VDRXakJQR2NXNUdxK0lKUXFsSWVId3V2?=
 =?utf-8?B?MW5YSnIzdEgwTEQ5anNOUXZwd2VnQ0tyWkpCU0JHT21vM1pZSXhZbVF4em1C?=
 =?utf-8?B?b3g0RVd3SVZzbkNNb29UWFdzZVE1K3cwaUJHTDBCUEZXVG1YTzN5RXlIUm1z?=
 =?utf-8?B?UEpUR1ZrWm04YnF6aHh1bmU1ejNNc3NsTW94ZkF2MmtrLzBtYVV2cmVsa0l6?=
 =?utf-8?B?SUpkKy9nL1BSUnVyd3Vadmt2Y0tUU0dSNlNHenpHaThGekF1VXlCQy9YTHBt?=
 =?utf-8?B?ZTdMWkhMTHFURElQMmZ6U1ZOcUZDYVFXTXBYenArTG9lOVFZTHRjYmROZmc2?=
 =?utf-8?B?bFFNK2lPcEp0T1MvZEpVYjNDM1hIRFlLay9FVFhUVHU5R3lZWnpPV0Q2OG1z?=
 =?utf-8?B?aEpiNlRaV292YnMzZ1B4ZlpBRi9tRnhFMGxoZDIyY2NGd0ZvOHU5blZMb0xC?=
 =?utf-8?B?aXJLaTZxb3Nmb24rWnZpUWRvOTdwUnFBTkN0R25kMTM2cVVWSE5zTys4QzI4?=
 =?utf-8?B?V2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: s7IgvLOHyQqPh/9X6ohlNtM1cqNbiUqNMCuG35uZzPkeEqudTxdff2O6lWjfYM6ATS8O8ysJT4FSziUwHqHqiH5NHIB0P1eRzXp33cqewcRMlv5UuJeHRh94DHrq3UcWwZCOp1E7HK1BGhFvFgSw4A5Al9/eCypdHkHmjsrFoxbYSH4nMxL6nXZ0nvgggFhfJ+n7qXBwqYMiKuvuNOCBnwpYRNeC4vUclCIQ+NdNVGI+H//ZJRzsQych2uRDp9+vfj58EM8IqL+1rWJoUBIlfq3hSBeQhMmRyVJkDovGiEXTUrbyLK9hZkyrag9eGhQtMAIEouFvRdoipiBQIc3PV84KvoEuUY7cEDeKeMDhbefpS7OGjKMyZFq19o28dLuMxV9Sk7KMG0RgJD/3mKMEWcVwKYSUa04ws0HAejBzNTbxzoez2zwva6lr3WbAXAiPTTUgkXBy3tW7kn6VdfmTrR8AnsEea6Lid0hDras4eF7TdGGWdrInPf5twRRS3nLuwVLmz3sTghLpI2nfBMJGy2qDPE4mJyPFHBRwyhm6xG5o5TaiRVAhZQDLUqI4SAEkm0T7aJFUdlZgO4ZDe8AYJ4o2HGLcKVjSapRJecEgB2w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2f6743b-8d0b-4f20-1b8a-08dd0d7227f1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR10MB6505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 16:56:50.7091 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k/r5tgwTug7Xb9HaH8kHUXLBGdQNKyx8NPJHK1eduh4jpQF3gWEf4hxSiKWKW+mmzl0PfFGTTOv8El4nd+ofSfl56qZ8DPX9x44Rvm8+TGE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6423
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-11-25_10,2024-11-25_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411250141
X-Proofpoint-ORIG-GUID: O2y9I0RPklaJCjJ0VpdxXDJr1PHY-SNI
X-Proofpoint-GUID: O2y9I0RPklaJCjJ0VpdxXDJr1PHY-SNI
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] Issue faced in memcg_stat_rss while running mainline kernels
 between 6.7 and 6.8
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgdGhlcmUsCgpJJ3ZlIGJlZW4gZ2V0dGluZyB0ZXN0IGZhaWx1cmVzIG9uIHRoZSBtZW1jZ19z
dGF0X3JzcyB0ZXN0Y2FzZSBmb3IKbWFpbmxpbmUgNi4xMiBrZXJuZWxzIHdpdGggMyB0ZXN0cyBm
YWlsaW5nIGFuZCBvbmUgYmVpbmcgYnJva2VuLgoKUnVubmluZyB0ZXN0cy4uLi4uLi4KPDw8dGVz
dF9zdGFydD4+Pgp0YWc9bWVtY2dfc3RhdF9yc3Mgc3RpbWU9MTczMjAwMzUwMApjbWRsaW5lPSJt
ZW1jZ19zdGF0X3Jzcy5zaCIKY29udGFjdHM9IiIKYW5hbHlzaXM9ZXhpdAo8PDx0ZXN0X291dHB1
dD4+PgppbmNyZW1lbnRpbmcgc3RvcAptZW1jZ19zdGF0X3JzcyAxIFRJTkZPOiBSdW5uaW5nOiBt
ZW1jZ19zdGF0X3Jzcy5zaAptZW1jZ19zdGF0X3JzcyAxIFRJTkZPOiBUZXN0ZWQga2VybmVsOiBM
aW51eCBoYXJqaGEtb2w5a2Rldmx0cAo2LjEyLjAtbWFzdGVyLjIwMjQxMDIxLmVsOS52MS54ODZf
NjQgIzEgU01QIFBSRUVNUFRfRFlOQU1JQyBNb24gT2N0IDIxCjA2OjI0OjIyIFBEVCAyMDI0IHg4
Nl82NCB4ODZfNjQgeDg2XzY0IEdOVS9MaW51eAptZW1jZ19zdGF0X3JzcyAxIFRJTkZPOiBVc2lu
ZwovdGVtcGRpci9sdHAtWTRBRVVtS1ZJRS9MVFBfbWVtY2dfc3RhdF9yc3Mua0VoRDBRdnZNdyBh
cyB0bXBkaXIgKHhmcwpmaWxlc3lzdGVtKQptZW1jZ19zdGF0X3JzcyAxIFRJTkZPOiB0aW1lb3V0
IHBlciBydW4gaXMgMGggNW0gMHMKbWVtY2dfc3RhdF9yc3MgMSBUSU5GTzogc2V0IC9zeXMvZnMv
Y2dyb3VwL21lbW9yeS9tZW1vcnkudXNlX2hpZXJhcmNoeQp0byAwIGZhaWxlZAptZW1jZ19zdGF0
X3JzcyAxIFRJTkZPOiBTZXR0aW5nIHNobW1heAptZW1jZ19zdGF0X3JzcyAxIFRJTkZPOiBSdW5u
aW5nIG1lbWNnX3Byb2Nlc3MgLS1tbWFwLWFub24gLXMgMjY2MjQwCm1lbWNnX3N0YXRfcnNzIDEg
VElORk86IFdhcm1pbmcgdXAgcGlkOiA5MzY3Cm1lbWNnX3N0YXRfcnNzIDEgVElORk86IFByb2Nl
c3MgaXMgc3RpbGwgaGVyZSBhZnRlciB3YXJtIHVwOiA5MzY3Cm1lbWNnX3N0YXRfcnNzIDEgVEZB
SUw6IHJzcyBpcyAwLCAyNjYyNDAgZXhwZWN0ZWQKbWVtY2dfc3RhdF9yc3MgMiBUSU5GTzogUnVu
bmluZyBtZW1jZ19wcm9jZXNzIC0tbW1hcC1maWxlIC1zIDQwOTYKbWVtY2dfc3RhdF9yc3MgMiBU
SU5GTzogV2FybWluZyB1cCBwaWQ6IDkzODMKbWVtY2dfc3RhdF9yc3MgMiBUSU5GTzogUHJvY2Vz
cyBpcyBzdGlsbCBoZXJlIGFmdGVyIHdhcm0gdXA6IDkzODMKbWVtY2dfc3RhdF9yc3MgMiBUUEFT
UzogcnNzIGlzIDAgYXMgZXhwZWN0ZWQKbWVtY2dfc3RhdF9yc3MgMyBUSU5GTzogUnVubmluZyBt
ZW1jZ19wcm9jZXNzIC0tc2htIC1rIDMgLXMgNDA5NgptZW1jZ19zdGF0X3JzcyAzIFRJTkZPOiBX
YXJtaW5nIHVwIHBpZDogOTQ0NgptZW1jZ19zdGF0X3JzcyAzIFRJTkZPOiBQcm9jZXNzIGlzIHN0
aWxsIGhlcmUgYWZ0ZXIgd2FybSB1cDogOTQ0NgptZW1jZ19zdGF0X3JzcyAzIFRQQVNTOiByc3Mg
aXMgMCBhcyBleHBlY3RlZAptZW1jZ19zdGF0X3JzcyA0IFRJTkZPOiBSdW5uaW5nIG1lbWNnX3By
b2Nlc3MgLS1tbWFwLWFub24gLS1tbWFwLWZpbGUKLS1zaG0gLXMgMjY2MjQwCm1lbWNnX3N0YXRf
cnNzIDQgVElORk86IFdhcm1pbmcgdXAgcGlkOiA5NDYyCm1lbWNnX3N0YXRfcnNzIDQgVElORk86
IFByb2Nlc3MgaXMgc3RpbGwgaGVyZSBhZnRlciB3YXJtIHVwOiA5NDYyCm1lbWNnX3N0YXRfcnNz
IDQgVFBBU1M6IHJzcyBpcyAyNjYyNDAgYXMgZXhwZWN0ZWQKbWVtY2dfc3RhdF9yc3MgNSBUSU5G
TzogUnVubmluZyBtZW1jZ19wcm9jZXNzIC0tbW1hcC1sb2NrMSAtcyAyNjYyNDAKbWVtY2dfc3Rh
dF9yc3MgNSBUSU5GTzogV2FybWluZyB1cCBwaWQ6IDk0NzkKbWVtY2dfc3RhdF9yc3MgNSBUSU5G
TzogUHJvY2VzcyBpcyBzdGlsbCBoZXJlIGFmdGVyIHdhcm0gdXA6IDk0NzkKbWVtY2dfc3RhdF9y
c3MgNSBURkFJTDogcnNzIGlzIDAsIDI2NjI0MCBleHBlY3RlZAptZW1jZ19zdGF0X3JzcyA2IFRJ
TkZPOiBSdW5uaW5nIG1lbWNnX3Byb2Nlc3MgLS1tbWFwLWFub24gLXMgMjY2MjQwCm1lbWNnX3N0
YXRfcnNzIDYgVElORk86IFdhcm1pbmcgdXAgcGlkOiA5NDk1Cm1lbWNnX3N0YXRfcnNzIDYgVElO
Rk86IFByb2Nlc3MgaXMgc3RpbGwgaGVyZSBhZnRlciB3YXJtIHVwOiA5NDk1Cm1lbWNnX3N0YXRf
cnNzIDYgVEZBSUw6IHJzcyBpcyAwLCAyNjYyNDAgZXhwZWN0ZWQKbWVtY2dfc3RhdF9yc3MgNiBU
QlJPSzogdGltZWQgb3V0IG9uIG1lbW9yeS51c2FnZV9pbl9ieXRlcyA0MDk2IDI2NjI0MAoyNjYy
NDAKL29wdC9sdHAtMjAyNDA5MzAvdGVzdGNhc2VzL2Jpbi90c3RfdGVzdC5zaDogbGluZSAxNTg6
wqAgOTQ5NQpLaWxsZWTCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG1lbWNnX3By
b2Nlc3MgIiRAIsKgICh3ZDoKL3N5cy9mcy9jZ3JvdXAvbWVtb3J5L2x0cC90ZXN0LTkzMDgvbHRw
XzkzMDgpCgpTdW1tYXJ5OgpwYXNzZWTCoMKgIDMKZmFpbGVkwqDCoCAzCmJyb2tlbsKgwqAgMQpz
a2lwcGVkwqAgMAp3YXJuaW5ncyAwCjw8PGV4ZWN1dGlvbl9zdGF0dXM+Pj4KaW5pdGlhdGlvbl9z
dGF0dXM9Im9rIgpkdXJhdGlvbj0xNyB0ZXJtaW5hdGlvbl90eXBlPWV4aXRlZCB0ZXJtaW5hdGlv
bl9pZD0zIGNvcmVmaWxlPW5vCmN1dGltZT0xMyBjc3RpbWU9NTgKPDw8dGVzdF9lbmQ+Pj4KSU5G
TzogbHRwLXBhbiByZXBvcnRlZCBzb21lIHRlc3RzIEZBSUwKTFRQIFZlcnNpb246IDIwMjQwOTMw
CgpJJ20gbm90IHN1cmUgd2hldGhlciB0aGlzIGVycm9yIGlzIGR1ZSB0byB0aGUga2VybmVsIG9y
IHRoZSB0ZXN0Y2FzZQpiZWluZyBvdXRkYXRlZC4gSSBrbm93IHRoYXQgc2luY2UgY2dyb3VwIHYy
IGlzIHRoZSBkZWZhdWx0IHVwc3RyZWFtIGFuZApjZ3JvdXAgdjEgaXMgbm93IGEgbGVnYWN5IG9w
dGlvbiwgdGhpcyBzcGVjaWZpYyB0ZXN0Y2FzZSBpcyBub3QKcGFydGljdWxhcmx5IGhpZ2hlciBp
biB0aGUgcHJpb3JpdHkgbGlzdCwgYnV0IGp1c3QgdG8gYmUgc3VyZSwgSSB3YW50ZWQKdG8gdmVy
aWZ5IHRoaXMgZnJvbSB5b3VyIHNpZGUuIFBsZWFzZSBsZXQgbWUga25vdyB3aGV0aGVyIHRoaXMg
ZXJyb3IgaXMKY29taW5nIGR1ZSB0byB0aGUgdGVzdGNhc2UgYmVpbmcgb3V0ZGF0ZWQgb3IgdGhp
cyBpbiBmYWN0IGlzIGEgdmFsaWQKa2VybmVsIGVycm9yLgoKSSByYW4gYSBiaXNlY3Qgb24gbWVt
Y2dfc3RhdF9yc3MgdGVzdCB1cG9uIG1haW5saW5lIGtlcm5lbHMgYW5kIHNhdyB0aGUKYmlzZWN0
IHJhbmdlIG5hcnJvdyBkb3duIGJldHdlZW4gNi43IGFuZCA2Ljggd2hpY2ggZnVydGhlciBpc29s
YXRlZCB0bzoKaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQv
c3RhYmxlL2xpbnV4LmdpdC9jb21taXQvP2lkPTdkN2VmMGE0Njg2YWJlNDNjZDc2YTE0MWIzNDBh
MzQ4ZjQ1ZWNkZjIKVGhpcyBjb21taXQgd2FzIHBhcnQgb2YgYSA1IHBhdGNoIHNlcmllcyBhbmQg
SSB3YXNuJ3QgYWJsZSB0byByZXZlcnQgaXQKb24gNi4xMiB3aXRob3V0IGdldHRpbmcgYSBzZXJp
ZXMgb2YgY29uZmxpY3RzLgpTbywgd2hhdCBJIGRpZCB3YXMgY2hlY2tvdXQgdGhlIFNIQSBiZWZv
cmUgdGhpcyBwYXRjaCBzZXJpZXMKNGEzYmZiZDE2OTllMjMwNjczMTgwOWQ1MGQ0ODA2MzQwMTJl
ZDRkZSBhbmQgYWZ0ZXIgdGhlIHBhdGNoIHNlcmllcwo3ZDdlZjBhNDY4NmFiZTQzY2Q3NmExNDFi
MzQwYTM0OGY0NWVjZGYyIGFuZCByYW4gdGhpcyB0ZXN0LgoKVGhlIG1hY2hpbmUgaGFkIDMyR0Ig
UmFtIGFuZCA0Q1BVcy4KClRoZSBzdGVwcyB0byByZXByb2R1Y2UgdGhpcyBhcmU6CgojIS9iaW4v
YmFzaAoKIyBBZnRlciBzZXR0aW5nIGRlZmF1bHQga2VybmVsIHRvIHRoZSBkZXNpcmVkIG9uZQpp
ZiAhIGdyZXAgLXEgInVuaWZpZWRfY2dyb3VwX2hpZXJhcmNoeT0wIiAvcHJvYy9jbWRsaW5lOyB0
aGVuCsKgwqDCoMKgwqDCoMKgIHN1ZG8gZ3J1YmJ5IC0tdXBkYXRlLWtlcm5lbCBERUZBVUxUCi0t
YXJncz0ic3lzdGVtZC51bmlmaWVkX2Nncm91cF9oaWVyYXJjaHk9MCIKwqDCoMKgwqDCoMKgwqAg
c3VkbyBncnViYnkgLS11cGRhdGUta2VybmVsIERFRkFVTFQKLS1hcmdzPSJzeXN0ZW1kLmxlZ2Fj
eV9zeXN0ZW1kX2Nncm91cF9jb250cm9sbGVyIgrCoMKgwqDCoMKgwqDCoCBzdWRvIGdydWJieSAt
LXVwZGF0ZS1rZXJuZWwgREVGQVVMVCAtLWFyZ3Mgc2VsaW51eD0wCsKgwqDCoMKgwqDCoMKgIHN1
ZG8gc2VkIC1pICIvXlNFTElOVVg9L3MvPS4qLz1kaXNhYmxlZC8iIC9ldGMvc2VsaW51eC9jb25m
aWcKwqDCoMKgwqDCoMKgwqAgc3VkbyByZWJvb3QKZmkKCmNkIC9vcHQvbHRwCnJtIC1yZiAvdG1w
ZGlyCm1rZGlyIC90ZW1wZGlyCi4vcnVubHRwIC1kIC90ZW1wZGlywqAgLXMgbWVtY2dfc3RhdF9y
c3MKCgpUaGUgcmVzdWx0cyBvYnRhaW5lZCB3ZXJlOgoKUHJlIGJpc2VjdCBjdWxwcml0ICg0YTNi
ZmJkMTY5OWUyMzA2NzMxODA5ZDUwZDQ4MDYzNDAxMmVkNGRlKToKCjw8PHRlc3Rfc3RhcnQ+Pj4K
dGFnPW1lbWNnX3N0YXRfcnNzIHN0aW1lPTE3MzE3NTQwNzgKY21kbGluZT0ibWVtY2dfc3RhdF9y
c3Muc2giCmNvbnRhY3RzPSIiCmFuYWx5c2lzPWV4aXQKPDw8dGVzdF9vdXRwdXQ+Pj4KaW5jcmVt
ZW50aW5nIHN0b3AKbWVtY2dfc3RhdF9yc3MgMSBUSU5GTzogUnVubmluZzogbWVtY2dfc3RhdF9y
c3Muc2gKbWVtY2dfc3RhdF9yc3MgMSBUSU5GTzogVGVzdGVkIGtlcm5lbDogTGludXggaGFyamhh
LW9sOWtkZXZsdHAKNi43LjAtbWFzdGVycHJlLjIwMjQxMTEuZWw5LnJjMS54ODZfNjQgIzEgU01Q
IFBSRUVNUFRfRFlOQU1JQyBGcmkgTm92IDE1CjExOjU2OjEwIFBTVCAyMDI0IHg4Nl82NCB4ODZf
NjQgeDg2XzY0IEdOVS9MaW51eAptZW1jZ19zdGF0X3JzcyAxIFRJTkZPOiBVc2luZwovdGVtcGRp
ci9sdHAtU3pFOUFESzZNTS9MVFBfbWVtY2dfc3RhdF9yc3MuNm9wMjhzTVhPMiBhcyB0bXBkaXIg
KHhmcwpmaWxlc3lzdGVtKQptZW1jZ19zdGF0X3JzcyAxIFRJTkZPOiB0aW1lb3V0IHBlciBydW4g
aXMgMGggNW0gMHMKbWVtY2dfc3RhdF9yc3MgMSBUSU5GTzogc2V0IC9zeXMvZnMvY2dyb3VwL21l
bW9yeS9tZW1vcnkudXNlX2hpZXJhcmNoeQp0byAwIGZhaWxlZAptZW1jZ19zdGF0X3JzcyAxIFRJ
TkZPOiBTZXR0aW5nIHNobW1heAptZW1jZ19zdGF0X3JzcyAxIFRJTkZPOiBSdW5uaW5nIG1lbWNn
X3Byb2Nlc3MgLS1tbWFwLWFub24gLXMgMjY2MjQwCm1lbWNnX3N0YXRfcnNzIDEgVElORk86IFdh
cm1pbmcgdXAgcGlkOiAzNDIzNwptZW1jZ19zdGF0X3JzcyAxIFRJTkZPOiBQcm9jZXNzIGlzIHN0
aWxsIGhlcmUgYWZ0ZXIgd2FybSB1cDogMzQyMzcKbWVtY2dfc3RhdF9yc3MgMSBUUEFTUzogcnNz
IGlzIDI2NjI0MCBhcyBleHBlY3RlZAptZW1jZ19zdGF0X3JzcyAxIFRCUk9LOiB0aW1lZCBvdXQg
b24gbWVtb3J5LnVzYWdlX2luX2J5dGVzIDQwOTYgMjY2MjQwCjI2NjI0MAovb3B0L2x0cC0yMDI0
MDkzMC90ZXN0Y2FzZXMvYmluL3RzdF90ZXN0LnNoOiBsaW5lIDE1ODogMzQyMzcKS2lsbGVkwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBtZW1jZ19wcm9jZXNzICIkQCLCoCAod2Q6
Ci9zeXMvZnMvY2dyb3VwL21lbW9yeS9sdHAvdGVzdC0zNDE4MC9sdHBfMzQxODApCgpTdW1tYXJ5
OgpwYXNzZWTCoMKgIDEKZmFpbGVkwqDCoCAwCmJyb2tlbsKgwqAgMQpza2lwcGVkwqAgMAp3YXJu
aW5ncyAwCjw8PGV4ZWN1dGlvbl9zdGF0dXM+Pj4KCgpQb3N0IGJpc2VjdCBjdWxwcml0KDdkN2Vm
MGE0Njg2YWJlNDNjZDc2YTE0MWIzNDBhMzQ4ZjQ1ZWNkZjIpOgoKPDw8dGVzdF9zdGFydD4+Pgp0
YWc9bWVtY2dfc3RhdF9yc3Mgc3RpbWU9MTczMTc1NTMzOQpjbWRsaW5lPSJtZW1jZ19zdGF0X3Jz
cy5zaCIKY29udGFjdHM9IiIKYW5hbHlzaXM9ZXhpdAo8PDx0ZXN0X291dHB1dD4+PgppbmNyZW1l
bnRpbmcgc3RvcAptZW1jZ19zdGF0X3JzcyAxIFRJTkZPOiBSdW5uaW5nOiBtZW1jZ19zdGF0X3Jz
cy5zaAptZW1jZ19zdGF0X3JzcyAxIFRJTkZPOiBUZXN0ZWQga2VybmVsOiBMaW51eCBoYXJqaGEt
b2w5a2Rldmx0cAo2LjcuMC1tYXN0ZXJwb3N0LjIwMjQxMTEuZWw5LnJjMS54ODZfNjQgIzEgU01Q
IFBSRUVNUFRfRFlOQU1JQyBGcmkgTm92CjE1IDExOjU1OjQxIFBTVCAyMDI0IHg4Nl82NCB4ODZf
NjQgeDg2XzY0IEdOVS9MaW51eAptZW1jZ19zdGF0X3JzcyAxIFRJTkZPOiBVc2luZwovdGVtcGRp
ci9sdHAtRzZjZ2U0Q2tyUi9MVFBfbWVtY2dfc3RhdF9yc3MuMXpybTZYMDJDTyBhcyB0bXBkaXIg
KHhmcwpmaWxlc3lzdGVtKQptZW1jZ19zdGF0X3JzcyAxIFRJTkZPOiB0aW1lb3V0IHBlciBydW4g
aXMgMGggNW0gMHMKbWVtY2dfc3RhdF9yc3MgMSBUSU5GTzogc2V0IC9zeXMvZnMvY2dyb3VwL21l
bW9yeS9tZW1vcnkudXNlX2hpZXJhcmNoeQp0byAwIGZhaWxlZAptZW1jZ19zdGF0X3JzcyAxIFRJ
TkZPOiBTZXR0aW5nIHNobW1heAptZW1jZ19zdGF0X3JzcyAxIFRJTkZPOiBSdW5uaW5nIG1lbWNn
X3Byb2Nlc3MgLS1tbWFwLWFub24gLXMgMjY2MjQwCm1lbWNnX3N0YXRfcnNzIDEgVElORk86IFdh
cm1pbmcgdXAgcGlkOiA5MDgzCm1lbWNnX3N0YXRfcnNzIDEgVElORk86IFByb2Nlc3MgaXMgc3Rp
bGwgaGVyZSBhZnRlciB3YXJtIHVwOiA5MDgzCm1lbWNnX3N0YXRfcnNzIDEgVEZBSUw6IHJzcyBp
cyAwLCAyNjYyNDAgZXhwZWN0ZWQKbWVtY2dfc3RhdF9yc3MgMSBUQlJPSzogdGltZWQgb3V0IG9u
IG1lbW9yeS51c2FnZV9pbl9ieXRlcyA0MDk2IDI2NjI0MAoyNjYyNDAKL29wdC9sdHAtMjAyNDA5
MzAvdGVzdGNhc2VzL2Jpbi90c3RfdGVzdC5zaDogbGluZSAxNTg6wqAgOTA4MwpLaWxsZWTCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG1lbWNnX3Byb2Nlc3MgIiRAIsKgICh3ZDoK
L3N5cy9mcy9jZ3JvdXAvbWVtb3J5L2x0cC90ZXN0LTkwMjQvbHRwXzkwMjQpCgpTdW1tYXJ5Ogpw
YXNzZWTCoMKgIDAKZmFpbGVkwqDCoCAxCmJyb2tlbsKgwqAgMQpza2lwcGVkwqAgMAp3YXJuaW5n
cyAwCjw8PGV4ZWN1dGlvbl9zdGF0dXM+Pj4KClRoYW5rcyAmIFJlZ2FyZHMsCgoKLS0gCk1haWxp
bmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
