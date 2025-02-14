Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1D44C021A4
	for <ltp@archiver.kernel.org>; Fri, 14 Feb 2025 11:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1739534079; h=message-id :
 date : to : references : in-reply-to : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=CDxduNeBq8jlbn30SyVFozF5cuvoIKZDibpwrUxFH5o=;
 b=EbMHMdy0HOY2G5FwgmS20T4iw2UaI9r95Zz4HpKJbOiGqyMT+Z4MehdKYtqii6cDy72R3
 ZUTz1PZsTWm940VjKViNnUhAYPtbhbDDRtgq1h7pZg6jmeHpmc/r4qJDuO25bRzGhx4TVGu
 zMIFPWzOpdbB27TVSs5JdUf2Yzn/+R0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 356E13C9AFD
	for <ltp@archiver.kernel.org>; Fri, 14 Feb 2025 12:54:39 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BECB53C90F9
 for <ltp@lists.linux.it>; Fri, 14 Feb 2025 12:54:17 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=oracle.com (client-ip=205.220.165.32;
 helo=mx0a-00069f02.pphosted.com; envelope-from=rhythm.m.mahajan@oracle.com;
 receiver=lists.linux.it)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5B50E600D6F
 for <ltp@lists.linux.it>; Fri, 14 Feb 2025 12:54:15 +0100 (CET)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51EBfega018963;
 Fri, 14 Feb 2025 11:54:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=A0ZzrjVb/zxATUkmPVEUcdkvjTgMHstFWxpZ7hDe77g=; b=
 gnRbSClZC8jrtx9M3KXtT9RyRvmf6ssWWvsVI2gaxMVY2zbKxg85sktZlgF2B/zX
 jF0BdCpvPaP+eEVuJUyhJrLMZxIz9GLxKfs/7Ub26FgA1O6iEUKNAieksqz7ureV
 t3pK8oZ+wDZVadBbUShNnfqfotUDXUKD7bLk9QTIGqFAhdnwOCxvQptHCmL/yk1v
 raxVWB/GyxOTRc21Ds7LzGeIlei5VGRIZRTMXIAxtquVDHFZftn7J7Zos1PPdq7i
 54MaPlWeZZ0/DnBDak5pOILLiR8cx7njLjK3SkTdmYEG/qRFh5rkaxGV0sFuzAWD
 72RbNGC021v55CSE4/buUA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0q2kjas-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Feb 2025 11:54:12 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 51E9UMma025143; Fri, 14 Feb 2025 11:54:11 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 44nwqkn2tc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Feb 2025 11:54:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hBbc0VbhBPXgZe3Tpw/Ssi906dHNW/cmknWhYvGnQH8TXUJiiqVmuhWI8z22ve/efjPeIkoTY0wdLT0SY+nRUx42ZXd3RqZe1XKtJAmvQoouO26kZ0CcFBCjDLSpgulILe4Kqqje837W72bpNGPFpmPBGamleWU77lL0geD86cvkCwsRqQl9qbCRggz/rnSwO/R1qGrvymMr/nR08D+5V2diLL+0dL5kCXRNnt7PHUn2SI70MhhuJqNsi7OsPvCx5SRJ//fEUM8TGD4r7QisteNis/J3e1zNtN05F6XKsL8d2eTaP+NCNr49aMAzsAf6B+iX7J6C+Dq+f6mtYpPxXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A0ZzrjVb/zxATUkmPVEUcdkvjTgMHstFWxpZ7hDe77g=;
 b=xOK1Hg82cBsnSNxBqTqUwbud+CYkQYF+1fsPIZwGHJR6l8lP7UYOddgNl4pHwEuOW2F4GHI8JRgZTQilmOnKWNedFOjcW2RyV11YJ4rMRkWxGGx+QKnhbmMbwOWZVe3dvQBwxZhK3b3wD/D+LlZSp+HiFPmVGzEPrZ1+v76E46+HtqaZZZKw7VWWSp45ENhcsmPlbTC2ZgIIWV20zah8M1K4FAcwGQBtryhg4Ip96MEL0CaxPIU03U2AXf/ShoNx8cqvU2PXhET3yzgC6nY0WjxojBk+FyGZFg5PH3HsHMTejl2BGVlhE1dH5QW1Lo/qeejmq/B2r99BYa69HHIqaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A0ZzrjVb/zxATUkmPVEUcdkvjTgMHstFWxpZ7hDe77g=;
 b=L9C0pVNDPAhdbrEveTxUfk8vxUIUGZzGdWdJIvGuugt3lth94E6Y+viyMzqTzGjX6Aig4Kf76DAVomY/gOHlGN5hPRbmPwiFiyMKjxqIIPDu/iN/IXVGLGJvS6UcSoZA9Ytkn8ns3xi4E9Md/OtMt3JtheRaVtlhGi6qJy6Be3Y=
Received: from BLAPR10MB5380.namprd10.prod.outlook.com (2603:10b6:208:333::14)
 by CYXPR10MB7898.namprd10.prod.outlook.com (2603:10b6:930:dd::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Fri, 14 Feb
 2025 11:54:09 +0000
Received: from BLAPR10MB5380.namprd10.prod.outlook.com
 ([fe80::ef73:6117:7d5b:3227]) by BLAPR10MB5380.namprd10.prod.outlook.com
 ([fe80::ef73:6117:7d5b:3227%5]) with mapi id 15.20.8445.017; Fri, 14 Feb 2025
 11:54:09 +0000
Message-ID: <1955d517-ea20-41de-a5de-43c5e7c1ada0@oracle.com>
Date: Fri, 14 Feb 2025 17:24:02 +0530
User-Agent: Mozilla Thunderbird
To: Amir Goldstein <amir73il@gmail.com>
References: <BLAPR10MB5380CCF4F8E99589DF0312EBBCFF2@BLAPR10MB5380.namprd10.prod.outlook.com>
 <CAOQ4uxg3wAr7Brse9xORsPp0XqCKTxMmnc_DRWuQ2bVZUSZRpQ@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAOQ4uxg3wAr7Brse9xORsPp0XqCKTxMmnc_DRWuQ2bVZUSZRpQ@mail.gmail.com>
X-ClientProxiedBy: SI2P153CA0020.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::19) To BLAPR10MB5380.namprd10.prod.outlook.com
 (2603:10b6:208:333::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5380:EE_|CYXPR10MB7898:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ea64240-27bb-4ef0-6180-08dd4cee49da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UWFRUWdXdERwNG4yUFY3aFJPKzJrSlpaUnVVcGpaUDI5NmtEcHg4clJjcm5L?=
 =?utf-8?B?UFE4REhhY3VXNHYvTC9GNi85b2prNDNQVE9tTUdIaFpxb21yTFVTY2VzRDli?=
 =?utf-8?B?bDU2TVpRVy9vb2Z1MGQzZ3ZCdnVPUEgxV3JmdERxK1hpYzYzNTU4SVZpcHJR?=
 =?utf-8?B?K08xUXhqQTBkQTFlaitGbjBUMkIzUXNVZWQwbUY5NU1teUZnaDkxMGc2ZjFY?=
 =?utf-8?B?YnhsVkxtNkNiMHRITEUzSDNZdEVuS25RWmNPaGlDRHZ4VWkxSmx6L3lZZy81?=
 =?utf-8?B?V1J3WEZZdklTYTlacWtLSjRiT3BZaTFWcHZ4ZFNHWnBJQmZJMVVGWmRQR1pr?=
 =?utf-8?B?Yzd3TG90OThHZHc4aTBoNVc3bElJZldkM3dYUit3d21xOElESWc5S1ZRNmcz?=
 =?utf-8?B?YTdFUVlUUzhVb2RkNXM0bmZ3ZmlNN2FzM3VnV0Z3MFlZdmw3RWcxVEpZeXh3?=
 =?utf-8?B?ZUozaVdXL1BpeFZ6MmluYXlPSnpxb0xYYkc4VEpzeFZkQ050WDBoeDd5SzNs?=
 =?utf-8?B?VmVPRVJqTERKYk8yNlBnY3BsUDBFeW1ZUmZVbjVoZjh1M2djVncyVW5IcmRB?=
 =?utf-8?B?NXZxVmJkYnFJbHVxLzFuMkQxRTRqbVQ5cW9FNFZmWllEN1VsWjFMdlY0bDVE?=
 =?utf-8?B?SkNNLzhCa1RXdGxGSWVGYUJGdlV0ZzhwdXZ4T2R2WU81djhmaisxRlpWdndh?=
 =?utf-8?B?a090S2s4dG0rVEl0QzBFaFN4KytFQUxIdENOZ2hQcnc2MFMwMWZoUUZPUVRK?=
 =?utf-8?B?WXhpWTVzc1k4QW13UXByaGNjVGh4SkNvODZtbXJuQTNzNEdMOGVFcWZId2VN?=
 =?utf-8?B?S2NZRFlKYzdENUc3ZXdOZWp5bEtLSXNMTnNwb0hINmtId3BsZXJJb2d1aHZr?=
 =?utf-8?B?QUFVZG9NSFEvNkd3WEt2YkZnU1ZUNFJ3OW9FbjJNdW0reThaRTNYREdtbVBZ?=
 =?utf-8?B?YzdyckNHOERDM0JsbU9wTHk0TDNFWWc1Njc1cXRFV1hVUXdyQzBDTWhtc1Vy?=
 =?utf-8?B?RGJJUkxGb3UzYjdURG5NMmE2STFOTU90MVk5SkViZEs2SDk3RTdpYktsZkxy?=
 =?utf-8?B?ZS9Majc2Uml1VmtZYUl2OG55S2pNdGxxYVA0RVVEamxCQkpvcUlhRXMyWmFT?=
 =?utf-8?B?ZlJCV1lvQkhjZGQ4YTRaU0o5ZFd3aWxoRGpkUmVCV21xS0ttZkJjWWpVcW0v?=
 =?utf-8?B?TFR0S3dsM1JRR3BLc1l4dk42dklZKzJEeSswVGQwR2RvRk56aVhqQi83dCsx?=
 =?utf-8?B?ekpZdW8rM3d3MWtFRDlnZlpYeVVaeWtMU1U2UTNJd3dIZW1IbFFDdWowWFhF?=
 =?utf-8?B?ak1oQ0V3bFFydUViMm9ybGZlTHpBVW45d3FBekFsdzlqWXZFdGpJcWtkVWRT?=
 =?utf-8?B?eDhBYm5Hd2E4N3gyZjBHbks5MG9EaGZvMFBJMmRDN0w1S1BQOEdsSUNXcVkz?=
 =?utf-8?B?d3NlVTY0MWFKbGJ3Y0l4dmpaN2tIYm13QWNuTW9jZUk0REF6azRxV0V3SS8r?=
 =?utf-8?B?Sy9OcXRqOFpBK0swNWFVc2JKdkpuc2kyNFRtVjIyTmxYMWJXS3VpZkR6R1Ey?=
 =?utf-8?B?N053Z2lrQmYxZGhEUVhubldCemRpMHJ2c0RxSytpejVGMnozYy9DN3M0RWJZ?=
 =?utf-8?B?YTltZUxjL3lIUCtLSG8zbGxBbU9PWkEyeW1hQ2lIY3hiMmltRll2SUlMV1h1?=
 =?utf-8?B?bGd2YmJoa3F6M1pvMFhsVE1jeXloYXNLaFFncXhuMmF5WFJKYVk2ckFVNFls?=
 =?utf-8?B?by9GWUd5ZUZnTFAyZGttWDNIemN6a3dOdnVESHIzaHRsd1hkZlV2M3NiSjBt?=
 =?utf-8?B?TzE1eEVYallnTTYxdUdwMkE2MDJQRUNqM2NQeW0xS1F2TEx0bkovVWNnR1NF?=
 =?utf-8?Q?vaihBIOCPirxi?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB5380.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2JIS0xGUWZiQzRIWXJOK2ZwNUErMGdySXAyekppNlVCMzgwT1hCU0FESmdN?=
 =?utf-8?B?aEl2QWdkN0JkK3E3Z1A5aGJOWmxZU2FHN2VWakd6RDkxeG1JZUxNVkpHNnpo?=
 =?utf-8?B?bkNoN05uYmhGdlQxbXlLTnFLVTJqVVJSdzlDbUI0MzBGaXNsdmVSQ1pxTE9m?=
 =?utf-8?B?SHU4dDU4MFl0UU5HOHdVSUpMSWhIZmE1SHoxc2xXZitRWkNGOGlualV3WXFE?=
 =?utf-8?B?SUE5SHVNM3J4bEhPSHlaN0JrcHh1ZDA4UDdsakVqVGgycm5WUFd4RXVlN01Z?=
 =?utf-8?B?Q1g4UUQyWHF1eElhcFhqYlYzalQ2VjRGY1VBZERjOHluWEdQVHNCQmR3SlBp?=
 =?utf-8?B?M0xnay9jekFjalFNYytwc0xJR29TWTdKVlNQNDE2S3hPeVJ5R0FkRG1pNlE3?=
 =?utf-8?B?UlpLUkJMTzd0Y3dWNVlhVU9Sd1VpZnlkbmIyazZmMW8rVzBGckc2WS9BSlA1?=
 =?utf-8?B?QXl3Nmx3VTc2dlFuSGUrVURRRVJTbXorcGV4U1JVM2JuVmhGK1ZCbzkxcHdB?=
 =?utf-8?B?bnRHRjdLMGtsQmoxTk15Wmt6dTFWTGxRNHVybXN0dTAvTVpvZ2I5Yy8yc3pB?=
 =?utf-8?B?ZjVhZTlaTDVFS3VHbSt4c2U3WWlXbElaYXhkS2VCZkttN3JhYnJ0NkhlSlMr?=
 =?utf-8?B?a3dva0tEY3E1YVZ5SGdFdzJSNk9sTWUvdjJuZmJoRWVhK2krK3ZpWGpoZ01x?=
 =?utf-8?B?dG5UWCtndnRlZW5HOW5ocytscFRSaTNCMHdvV2JOQURTSHFaa01RNGxmdlY0?=
 =?utf-8?B?NkJuNnA0UGpMQXZ4eDNwMDlmT1VlRzlkYzROUWZjdm1sRmpvQy9sVUFoQzZa?=
 =?utf-8?B?NlZyRi9yaFRNZXZEcVZQdk5QLzdvajBPdGtHUXdsR3NVNURuQmpCcUM2S2c1?=
 =?utf-8?B?bldiWGs0U3VvZEw4bDNTVUVlekc3cFRkWXhUUHR1bXo1VVFnc2hiUDF0OXJk?=
 =?utf-8?B?UnNXOXZwckVsYmlQRU9IbmJiVXFRcEZ4L05oM2ZWZ0MxeDMzdWNJWGxuZWV5?=
 =?utf-8?B?YkY4dVFnMXRFT3FuZndRL3dLU0VsNUl0ckQ3a2p1SWZNMjFaMlo1bEljVlhk?=
 =?utf-8?B?V2JJMURyTEhOTzJsaFdvNUphNVN1bWdQY3lHUlRuVTVwc1owYjBYUS90cTZR?=
 =?utf-8?B?NTRLSklWNjJwUndqTlZ5b3lIWEdMQm5kMjBhbW1zTUU2a3pvWHF2Y3ZqOVBC?=
 =?utf-8?B?MVY2WXhjbEhRWnV5VjJSMUhvSnh2Rjd1akNBb3R6LzdWZC9UWmVFclNnMXVu?=
 =?utf-8?B?ZkVmQWNvekx2dUtpVk56WEl6WjJuWkxuZG1na3hEdmg0akFVa3NMamNIZTFE?=
 =?utf-8?B?T2xHTXVBR3hTSnRKNHFDV1VmUE1UTE1YZ0IwdnhyNHRKVFpOTEo3RlJTcWsx?=
 =?utf-8?B?TWdYZ0ZKcFVkbzNWT2p4S05OaHdIVnE1YlhnZ0VKSlMzM1FwakozSjE4VUds?=
 =?utf-8?B?emZyNXMwbDdUaWR6TUxBUDdwWWFjTzh4Z1B2cDBjNXRTNWt4SXVPc0RHNDdj?=
 =?utf-8?B?WVZPTWw1Ukx2aDFwOGdXMjdWUkFXK2JkbFJoUUdIY2xOZncrTDk1WkJXQkRS?=
 =?utf-8?B?b09FYmZIcTczaC9wQ3c5U3VmTi9IT3VldzNFdGpadnRacXMvZmdQMzhTNmlI?=
 =?utf-8?B?QTZWUHZsMUFCcUF3Q0hmRk9HWjUrc1cxZUJDZzV5aXhzY3IxNElScVZMb1lq?=
 =?utf-8?B?L3JDT091VmlFazFaVFlGdWR5dEdUUy9WdGhPRWovNEFOQUkzdnNod0dkcHBI?=
 =?utf-8?B?UjRzRFAzSGlaT3U4dVFSeW9pZlZtRUNLci9QZ2lpdmZVTnczSkd6ZlVjV3pS?=
 =?utf-8?B?MlcxQy9qRzFjVzZRMENIdzdoWndoSFRzQ0d1VFRQY3htZWd3anliR3FOOGlI?=
 =?utf-8?B?cnVwaEQ2cUpWYkRhaFU2SU5jSjJHL3ByWlhrVmEzOC9ja29ITDVoQVBBbmNW?=
 =?utf-8?B?QlYrU1hVMWMrZGRXUFZyRzRwZ3BoTStDUmNRRmNtdzEvRlZQbDBaMjlyaVYz?=
 =?utf-8?B?K0EzSElIaFZVb1BMTU8weWtUNWMwblZBdm56U3BCd1BWREE4c21ZTzJLNFpq?=
 =?utf-8?B?MG5pRGtyUEZHVWF3Wm1QdEtHRjRBWUJueHRRRmJUTm5rdWNrVGZjU01yRTZx?=
 =?utf-8?B?citBUTlXcTV5Mm1kamVRVzhyZjkzSHVwSk1TNnJLZDBhQXpVc1FoSlNhVUdk?=
 =?utf-8?B?OHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 7Aw9n3LirSv4lcxTeM4iWuQZJ8lv6qKNl6+xCpLysybejdUvvoUCAxXTp4/EzMtxNodMwzaRq8qax+fW9V2KzshpuWEUY5Da0wXqigQpjPyZ9bEpid06wTwB7B/1ovwDx7x9Ya7OVQEoVgTVMSlj0wHgz5o4KfqM55hblTHG1an8rpDlPLIKCybKqPkTwRckpN8+FRT162N7yL+c4I62KWJN3YzEK03Te4dkz8jaa9rtqwbBsFMY7aVPtL/d3JwrO8uRGNY595wS+PtJP73U7qcvWYDdX1UGR3hR9AfvWNGAEcGzz0RGon0wfRg/SfjFolYDC8ctH2/zzdnH8zev92HodQpAesY0m0lQqulySy7ZOubq6pL8a/HN6vwHRh6uZPqijTfamAr6bca0bzIoynG+dueCrdHWgNF/cJxydaSHC19vpivfGXvbL6YwVcVPGt6e2QhvNlo1TIHq6NekO13AH0Hd/jBD+EXG6KpHtD2R73avVsN4VXlZ4Fj0QizVgj6w6N6dmljEHZJdVTrdwfUurmUOmiDvG8B2fzfKVVCEj7ET2pVQwWM2NlsZogKSTTvugDUhpKkReJkmG0odAHYT/L0iplbWunKdv3bSIs0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ea64240-27bb-4ef0-6180-08dd4cee49da
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5380.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 11:54:09.4970 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5KguRtAAGiIqi+uojwtYxy6p7/LgdLCm5KijMn4UtgD2JK9OPttvGIicpj8ztAGVu3sF2mZHQItJ8arDqDqQ8AIbChY1nMVz3Oll0o3goVs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR10MB7898
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-14_05,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxlogscore=999
 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502140087
X-Proofpoint-GUID: gaa2202ET6m6Go3Wm-_hUspSi0NxKI8h
X-Proofpoint-ORIG-GUID: gaa2202ET6m6Go3Wm-_hUspSi0NxKI8h
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [External] : Re: fanotify01 test fails on nfsv3& nfsv4
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
Cc: "jack@suse.cz" <jack@suse.cz>, Darren Kenny <darren.kenny@oracle.com>,
 Ramanan Govindarajan <ramanan.govindarajan@oracle.com>,
 Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgQW1pciwKCk9uIDEzLzAyLzI1IDg6MzAgcG0sIEFtaXIgR29sZHN0ZWluIHdyb3RlOgo+IE9u
IFRodSwgRmViIDEzLCAyMDI1IGF0IDI6MjnigK9QTSBSaHl0aG0gTWFoYWphbgo+IDxyaHl0aG0u
bS5tYWhhamFuQG9yYWNsZS5jb20+IHdyb3RlOgo+Pgo+PiBIaSwKPj4KPj4gZmFub3RpZnkwMSB0
ZXN0IGZhaWxzIG9uIG5mc3YzJiBuZnN2NCBmb3IgbWFpbmxpbmUgNi4xNCBrZXJuZWxzLgo+Pgo+
Pgo+Pgo+PiBta2RpciAvdG1wZGlyCj4+Cj4+IHl1bSBpbnN0YWxsIG5mcy11dGlscyAgLXkKPj4K
Pj4gZWNobyAiL21lZGlhICoocncsbm9fcm9vdF9zcXVhc2gsc3luYykiID4vZXRjL2V4cG9ydHMK
Pj4KPj4gc3lzdGVtY3RsIHN0YXJ0IG5mcy1zZXJ2ZXIuc2VydmljZQo+Pgo+PiBtb3VudCAtbyBy
dyxuZnN2ZXJzPTMgMTI3LjAuMC4xOi9tZWRpYSAvdG1wZGlyCj4+Cj4+Cj4+Cj4+IGNkIC9vcHQv
bHRwCj4+Cj4+IC4vcnVubHRwIC1kIC90bXBkaXIgIC1zIGZhbm90aWZ5MDEKPj4KPj4KPj4KPj4g
ZmFub3RpZnkwMS5jOjM0MDogVEZBSUw6IGZhbm90aWZ5X21hcmsoZmRfbm90aWZ5LCAweDAwMDAw
MDAxLCAweDAwMDAwMDA4LCAtMTAwLCAiLiIpIGV4cGVjdGVkIEVOT0RFVjogRVhERVYgKDE4KQo+
Pgo+PiBmYW5vdGlmeTAxLmM6MzQwOiBURkFJTDogZmFub3RpZnlfbWFyayhmZF9ub3RpZnksIDB4
MDAwMDAwMDEsIDB4MDAwMDAwMDgsIC0xMDAsICIuIikgZXhwZWN0ZWQgRU5PREVWOiBFWERFViAo
MTgpCj4+Cj4+IGZhbm90aWZ5MDEuYzozNDA6IFRGQUlMOiBmYW5vdGlmeV9tYXJrKGZkX25vdGlm
eSwgMHgwMDAwMDAwMSwgMHgwMDAwMDAwOCwgLTEwMCwgIi4iKSBleHBlY3RlZCBFTk9ERVY6IEVY
REVWICgxOCkKPj4KPj4gZmFub3RpZnkwMS5jOjM0MDogVEZBSUw6IGZhbm90aWZ5X21hcmsoZmRf
bm90aWZ5LCAweDAwMDAwMDAxLCAweDAwMDAwMDA4LCAtMTAwLCAiLiIpIGV4cGVjdGVkIEVOT0RF
VjogRVhERVYgKDE4KQo+Pgo+PiBmYW5vdGlmeTAxLmM6MzQwOiBURkFJTDogZmFub3RpZnlfbWFy
ayhmZF9ub3RpZnksIDB4MDAwMDAwMDEsIDB4MDAwMDAwMDgsIC0xMDAsICIuIikgZXhwZWN0ZWQg
RU5PREVWOiBFWERFViAoMTgpCj4+Cj4+IGZhbm90aWZ5MDEuYzozNDA6IFRGQUlMOiBmYW5vdGlm
eV9tYXJrKGZkX25vdGlmeSwgMHgwMDAwMDAwMSwgMHgwMDAwMDAwOCwgLTEwMCwgIi4iKSBleHBl
Y3RlZCBFTk9ERVY6IEVYREVWICgxOCkKPj4KPj4gZmFub3RpZnkwMS5jOjM0MDogVEZBSUw6IGZh
bm90aWZ5X21hcmsoZmRfbm90aWZ5LCAweDAwMDAwMDAxLCAweDAwMDAwMDA4LCAtMTAwLCAiLiIp
IGV4cGVjdGVkIEVOT0RFVjogRVhERVYgKDE4KQo+Pgo+PiBmYW5vdGlmeTAxLmM6MzQwOiBURkFJ
TDogZmFub3RpZnlfbWFyayhmZF9ub3RpZnksIDB4MDAwMDAwMDEsIDB4MDAwMDAwMDgsIC0xMDAs
ICIuIikgZXhwZWN0ZWQgRU5PREVWOiBFWERFViAoMTgpCj4+Cj4+IGZhbm90aWZ5MDEuYzozNDA6
IFRGQUlMOiBmYW5vdGlmeV9tYXJrKGZkX25vdGlmeSwgMHgwMDAwMDAwMSwgMHgwMDAwMDAwOCwg
LTEwMCwgIi4iKSBleHBlY3RlZCBFTk9ERVY6IEVYREVWICgxOCkKPj4KPj4gZmFub3RpZnkwMS5j
OjM0MDogVEZBSUw6IGZhbm90aWZ5X21hcmsoZmRfbm90aWZ5LCAweDAwMDAwMDAxLCAweDAwMDAw
MDA4LCAtMTAwLCAiLiIpIGV4cGVjdGVkIEVOT0RFVjogRVhERVYgKDE4KQo+Pgo+PiBmYW5vdGlm
eTAxLmM6MzQwOiBURkFJTDogZmFub3RpZnlfbWFyayhmZF9ub3RpZnksIDB4MDAwMDAwMDEsIDB4
MDAwMDAwMDgsIC0xMDAsICIuIikgZXhwZWN0ZWQgRU5PREVWOiBFWERFViAoMTgpCj4+Cj4+IGZh
bm90aWZ5MDEuYzozNDA6IFRGQUlMOiBmYW5vdGlmeV9tYXJrKGZkX25vdGlmeSwgMHgwMDAwMDAw
MSwgMHgwMDAwMDAwOCwgLTEwMCwgIi4iKSBleHBlY3RlZCBFTk9ERVY6IEVYREVWICgxOCkKPj4K
Pj4gZmFub3RpZnkwMS5jOjM0MDogVEZBSUw6IGZhbm90aWZ5X21hcmsoZmRfbm90aWZ5LCAweDAw
MDAwMDAxLCAweDAwMDAwMDA4LCAtMTAwLCAiLiIpIGV4cGVjdGVkIEVOT0RFVjogRVhERVYgKDE4
KQo+Pgo+PiBmYW5vdGlmeTAxLmM6MzQwOiBURkFJTDogZmFub3RpZnlfbWFyayhmZF9ub3RpZnks
IDB4MDAwMDAwMDEsIDB4MDAwMDAwMDgsIC0xMDAsICIuIikgZXhwZWN0ZWQgRU5PREVWOiBFWERF
ViAoMTgpCj4+Cj4+IGZhbm90aWZ5MDEuYzozNDA6IFRGQUlMOiBmYW5vdGlmeV9tYXJrKGZkX25v
dGlmeSwgMHgwMDAwMDAwMSwgMHgwMDAwMDAwOCwgLTEwMCwgIi4iKSBleHBlY3RlZCBFTk9ERVY6
IEVYREVWICgxOCkKPj4KPj4gZmFub3RpZnkwMS5jOjM0MDogVEZBSUw6IGZhbm90aWZ5X21hcmso
ZmRfbm90aWZ5LCAweDAwMDAwMDAxLCAweDAwMDAwMDA4LCAtMTAwLCAiLiIpIGV4cGVjdGVkIEVO
T0RFVjogRVhERVYgKDE4KQo+Pgo+PiBmYW5vdGlmeTAxLmM6MzQwOiBURkFJTDogZmFub3RpZnlf
bWFyayhmZF9ub3RpZnksIDB4MDAwMDAwMDEsIDB4MDAwMDAwMDgsIC0xMDAsICIuIikgZXhwZWN0
ZWQgRU5PREVWOiBFWERFViAoMTgpCj4+Cj4+IGZhbm90aWZ5MDEuYzozNDA6IFRGQUlMOiBmYW5v
dGlmeV9tYXJrKGZkX25vdGlmeSwgMHgwMDAwMDAwMSwgMHgwMDAwMDAwOCwgLTEwMCwgIi4iKSBl
eHBlY3RlZCBFTk9ERVY6IEVYREVWICgxOCkKPj4KPj4gZmFub3RpZnkwMS5jOjM0MDogVEZBSUw6
IGZhbm90aWZ5X21hcmsoZmRfbm90aWZ5LCAweDAwMDAwMDAxLCAweDAwMDAwMDA4LCAtMTAwLCAi
LiIpIGV4cGVjdGVkIEVOT0RFVjogRVhERVYgKDE4KQo+Pgo+PiBmYW5vdGlmeTAxLmM6MzQwOiBU
RkFJTDogZmFub3RpZnlfbWFyayhmZF9ub3RpZnksIDB4MDAwMDAwMDEsIDB4MDAwMDAwMDgsIC0x
MDAsICIuIikgZXhwZWN0ZWQgRU5PREVWOiBFWERFViAoMTgpCj4+Cj4+IGZhbm90aWZ5MDEuYzoz
NDA6IFRGQUlMOiBmYW5vdGlmeV9tYXJrKGZkX25vdGlmeSwgMHgwMDAwMDAwMSwgMHgwMDAwMDAw
OCwgLTEwMCwgIi4iKSBleHBlY3RlZCBFTk9ERVY6IEVYREVWICgxOCkKPj4KPj4KPj4KPj4gV2Ug
aGF2ZSBiZWVuIHNlZWluZyB0aGlzIGZhaWx1cmUgc2luY2UgNi45Cj4+Cj4+Cj4+Cj4+IFRoZSB0
ZXN0IG5vIGxvbmdlciBmYWlscyB3aXRoIHRoZSByZXZlcnQgb2YgdGhlIGNvbW1pdAo+Pgo+PiAz
NTkwNDdjOTcgZmFub3RpZnkwMTogVGVzdCBzZXR0aW5nIHR3byBtYXJrcyBvbiBkaWZmZXJlbnQg
ZmlsZXN5c3RlbXMKPj4KPj4gaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vZ2l0
aHViLmNvbS9saW51eC10ZXN0LXByb2plY3QvbHRwL2NvbW1pdC8zNTkwNDdjOTdfXzshIUFDV1Y1
TjlNMlJWOTloUSFOdmlSdGpMQ3plMlpmbkQ3WHR3QUVna19lQWRzb0JvZGZuYUFWZ3pzcGhrTmN4
V2lTMWIwWXUxYlVVakdPRXItN3lIZkNZbFB6MVd6SmhVRTJkSXdqUSQKPj4KPj4KPj4KPj4gQ291
bGQgeW91IHBsZWFzZSBjb25maXJtIGlmIHRoaXMgaXMgYSB0ZXN0IGNhc2UgaXNzdWUgb3IgYSBr
ZXJuZWwgaXNzdWU/Cj4gCj4gVGVzdCBpc3N1ZSBmb3IgdGhlIGNhc2Ugd2hlcmUKPiAiVE1QRElS
IGRvZXMgbm90IHN1cHBvcnQgcmVwb3J0aW5nIGV2ZW50cyB3aXRoIGZpZCBmcm9tIG11bHRpIGZz
Igo+IGZvciByZWFzb25zIG90aGVyIHRoYW4gRVhERVYgKGkuZS4gYnRyZnMgc3Vidm9sKS4KPiAK
PiBDYW4geW91IHRlc3QgdGhpcyBwYXRjaC4KClRoaXMgcGF0Y2ggZml4ZXMgdGhlIGlzc3VlLgoK
VGhhbmtzLApSaHl0aG0KCj4gCj4gVGhhbmtzLAo+IEFtaXIuCj4gCj4gLS0tIGEvdGVzdGNhc2Vz
L2tlcm5lbC9zeXNjYWxscy9mYW5vdGlmeS9mYW5vdGlmeTAxLmMKPiArKysgYi90ZXN0Y2FzZXMv
a2VybmVsL3N5c2NhbGxzL2Zhbm90aWZ5L2Zhbm90aWZ5MDEuYwo+IEBAIC0zNzUsNyArMzc1LDcg
QEAgc3RhdGljIHZvaWQgc2V0dXAodm9pZCkKPiAgICAgICAgICB9Cj4gCj4gICAgICAgICAgaWYg
KGZhbm90aWZ5X2ZsYWdzX3N1cHBvcnRlZF9vbl9mcyhGQU5fUkVQT1JUX0ZJRCwKPiBGQU5fTUFS
S19NT1VOVCwgRkFOX09QRU4sICIuIikpIHsKPiAtICAgICAgICAgICAgICAgaW5vZGVfbWFya19m
aWRfeGRldiA9IGVycm5vOwo+IC0gICAgICAgICAgICAgICB0c3RfcmVzKFRJTkZPLCAiVE1QRElS
IGRvZXMgbm90IHN1cHBvcnQgcmVwb3J0aW5nCj4gZXZlbnRzIHdpdGggZmlkIGZyb20gbXVsdGkg
ZnMiKTsKPiArICAgICAgICAgICAgICAgaW5vZGVfbWFya19maWRfeGRldiA9IChlcnJubyA9PSBF
Tk9ERVYpID8gRVhERVYgOiBlcnJubzsKPiArICAgICAgICAgICAgICAgdHN0X3JlcyhUSU5GTywg
IlRNUERJUiBkb2VzIG5vdCBzdXBwb3J0IHJlcG9ydGluZwo+IGV2ZW50cyB3aXRoIGZpZCBmcm9t
IG11bHRpIGZzIgo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIiAoZXJybm8gPSAl
ZCkiLCBlcnJubyk7Cj4gICAgICAgICAgfQo+ICAgfQoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzog
aHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
