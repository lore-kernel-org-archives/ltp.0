Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4583C02180
	for <ltp@archiver.kernel.org>; Thu, 16 Jan 2025 08:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1737014868; h=message-id :
 date : to : references : in-reply-to : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=OyO23QlmCZVN5JsD4STn6t9IfpsV7quUgE0Qo4+ZTo8=;
 b=aLrmhX2nmSPAz1vxHKnR/Fk2swUw8/I2w0/EbW20a6H26bCw70RvuStZDclq/94S4aXBd
 TtmW+hz7dcguE7MJVNyByBhz86SrKrvpKSd0D6lTM/eu4dunfwM48jd9QUGird3bFyA6DVI
 Xt5iSPoQ6lK18lnldSxL7aF5y54XPbA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 09CCB3C7B9C
	for <ltp@archiver.kernel.org>; Thu, 16 Jan 2025 09:07:48 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DE7823C4FB5
 for <ltp@lists.linux.it>; Thu, 16 Jan 2025 09:07:28 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=oracle.com (client-ip=205.220.165.32;
 helo=mx0a-00069f02.pphosted.com; envelope-from=harshvardhan.j.jha@oracle.com;
 receiver=lists.linux.it)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id AE7DB63004B
 for <ltp@lists.linux.it>; Thu, 16 Jan 2025 09:07:25 +0100 (CET)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50G1uF3p015798;
 Thu, 16 Jan 2025 08:07:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=tIvJ/BmNgk5tEagzdY/YeD0frvunOOda24ooK9qItYs=; b=
 i6dGbyKtb9HGbDMl4r6SfNi32e3u1sqWJfcztk3zTYgOCppC/XY4KX/RPSkj55pq
 2WcM10176obYjdVhD5QKcc3cFWMelN1xoT5BStI1BtvQXumC2T1gytI/n31SL1Pj
 NM7Pfe1McWMPEBiCRym2f+5GZQfoOiVSTfKUAE12eBm0i1Q3DlHQaWNSmHDmhjvb
 kP8kW2Q9FdBvD6wH5IlE/lUGlGQx2mObCujedWNjraaT4gP6Rw+nR7PiLYvJW6I3
 ooRnGuZnCu9dX7qEh8yvtnvh7MEQx0QnuKJZCcE0kbMcz5Ab25FUWdjVoPZvEaG6
 GHrfIZAvxZxAAdNNHpUrXw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 443f7y9qh6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Jan 2025 08:07:23 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 50G6hQUk032082; Thu, 16 Jan 2025 08:07:22 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 443f3ag6e1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Jan 2025 08:07:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fVfDos/WEDbdKmIt2BTSAGIw80JG1bneubUJOtP3TP77vLXfMICCVkuzcTkc9yueqwUIi1zWcg+YFFTsXZyINsIB4RBGZmUU6mypcKbs0wauL0UCOwjrn5W3h7V5QkN5dFDuELjDUfjhHVME7C3/1c2FGWSzPch0RDhZclB20C3MFkOivyY0rGp4e7p7QG4cZjqbYg8G27KtkRdIPFPL/neX4c+qLxS7YwPyMqR49vSiDuC3I/wrERCwFKaSKTvGnRzaapFsBb0W+uzkSJgF/7Xai2e8qAx7ro4iSNizA4w/gcKiyXOTmuOZg0x/OuY5ZWn3kPhwKz/9sGpv00HzGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tIvJ/BmNgk5tEagzdY/YeD0frvunOOda24ooK9qItYs=;
 b=rIPKEevEoOC7C6Onk8MX2t4WtEIZV0+VEBwpSdfH6P1dA5EIS+NxPxT6YPUsSdUD6mPEQ3l4Sl1QbUe1i6DZTvqaRM5EiXsUuGzWIsNXtMofWceM37VpMz4BzgN2OZkQ4vGS+Tx3WcUP1oIxEreB33Q9DmCHfY0rZqVhlvzGtTmv1G+pels/MQs9eiq4fim9bYM5soVNZRf451pw+jBfTQK2JrVQZTetNAWczBIyj1Xf1wsWAdeRkNmU6gqiFo1trWIkKRaQ4MXxDko+E3V7xeXUKO0iH7Gs4mlgo4wsg6XdcxGsqc2w6uw96K0L/iFF9Hywax9IkYZsZ79amRIRMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tIvJ/BmNgk5tEagzdY/YeD0frvunOOda24ooK9qItYs=;
 b=NSCUwy7kBI6Decr82o38DmtHtVO75KAAAClwT4xR2FXhke40sd7FFvHYbe/LocdyWVnF2pD3owW5vVRbNM7l+HzyC8eRNlJQitJiCPs16YeyMMt7WsyhxPqkMugs9efsKlnUuylq2FaqPErO9BEI5NflWDLpZ9MAJqsdihifn7s=
Received: from MW4PR10MB6510.namprd10.prod.outlook.com (2603:10b6:303:224::8)
 by BY5PR10MB4306.namprd10.prod.outlook.com (2603:10b6:a03:211::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Thu, 16 Jan
 2025 08:07:19 +0000
Received: from MW4PR10MB6510.namprd10.prod.outlook.com
 ([fe80::299:724:f009:e817]) by MW4PR10MB6510.namprd10.prod.outlook.com
 ([fe80::299:724:f009:e817%4]) with mapi id 15.20.8335.017; Thu, 16 Jan 2025
 08:07:19 +0000
Message-ID: <6ee7b877-19cc-4eda-9ea7-abf3af0a1b57@oracle.com>
Date: Thu, 16 Jan 2025 13:37:14 +0530
User-Agent: Mozilla Thunderbird
To: Michal Hocko <mhocko@suse.com>, Petr Vorel <pvorel@suse.cz>
References: <e66fcf77-cf9d-4d14-9e42-1fc4564483bc@oracle.com>
 <PH7PR10MB650583A6483E7A87B43630BDAC302@PH7PR10MB6505.namprd10.prod.outlook.com>
 <20250115125241.GD648257@pevik> <20250115225920.GA669149@pevik>
 <Z4i6-WZ73FgOjvtq@tiehlicka>
Content-Language: en-US
In-Reply-To: <Z4i6-WZ73FgOjvtq@tiehlicka>
X-ClientProxiedBy: KL1P15301CA0039.APCP153.PROD.OUTLOOK.COM
 (2603:1096:820:6::27) To MW4PR10MB6510.namprd10.prod.outlook.com
 (2603:10b6:303:224::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6510:EE_|BY5PR10MB4306:EE_
X-MS-Office365-Filtering-Correlation-Id: ddaada56-1f95-476d-b27e-08dd3604cc63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d0ppd253amREWDFITHNCOEc1RnF2SlZZSFNnSGpta3VWVUMwK2RmYnc5WE5h?=
 =?utf-8?B?VXhIazlUcGVNcXlaSENQTWp5aVE3R0RjK29EUmVTeElrMktVWGNSeEN1VHI2?=
 =?utf-8?B?eU1JVTFTQVRmc3pGaFk0UGtyVjJlQlhlYnFuQkl2TmRJTzA2K2JISTdqcFRh?=
 =?utf-8?B?bE1ReDBTTWIxYmxzeUFwVHV6bkJpUWI0T0NjWnU5U0VQdmg2aWRhRE1XM1NL?=
 =?utf-8?B?WlZkVndDNmkycFZjK1FqSzNHamtlVGpaSHpKcHRvbmtEZGV1SS9oZVlENzFS?=
 =?utf-8?B?Vzh3c1YxOU9vT3A5ZTVDRGF5d0lEVUVNSThBbmowaTVFZ1JJTVNwclltM2xn?=
 =?utf-8?B?Ny92RWhIblR2WmlaclVWQW9PUGF4TUVtRXYxTmpud0xERjFnZXVRTzdtZW9u?=
 =?utf-8?B?Q04xRWMvc01ienp4ckFSdUFMdDhPWndCWlhlTVk0YlVmZDlNZHRGOFNiOE02?=
 =?utf-8?B?R29hZ25ndHRBd2VGZlZXKzhieUp5TFBIbG9rdFVadjlCaTg3Wkl0N3NFdVR3?=
 =?utf-8?B?SzRzNFlXMGdOT08ySGdSdmFXSHFKWWZVL1o2d2ZkYXI3VDNiSzc3dTl5Sk12?=
 =?utf-8?B?TmppMW1ndC94VjA5S1hsUmlGRkR0ZXhBd3RMY0ppRlFPRXRnWFRJUGdLWmNt?=
 =?utf-8?B?SW9LM1VDOXp2aVo2QWx6ZDFQOVh4bEhGYXljNnVQbWxaTEZxeTVrQnFKRWt6?=
 =?utf-8?B?OUF3R3hDSDBwRmFHQ1p0ZitkaFlHVnhVT29KM3ZOSjdraDJ3VGFrcUJEZmhz?=
 =?utf-8?B?NFdmb0ZMcm51RysyUXBVSzVTMGR0ZlJub0dQWlZjK2t4SzBjcjJWU1NCZnpa?=
 =?utf-8?B?NjhTQkhud1kyTk1Yb1ZKS1Bqb0RSbUpxSlBNUFo1NExjMWlTV1pCSVZQK28w?=
 =?utf-8?B?UmtaTVlBaUkrL3pVQ1hiYjJ1ZlJrZzdxMEZqYUlTQ1YvSkh5V0lYdUIveGdN?=
 =?utf-8?B?WHhtOTZtYk1aWGhkem5SMlBRWHg0UG9UMThzMCtoT2dnTmV2U3AwTkFNK3hF?=
 =?utf-8?B?dXBvTnZkSUxBd0w2b0UveXhzYXloc05TWmUxUWZvcHd1ZHpkY3ZQaFhkVzNk?=
 =?utf-8?B?Q0pYWHh5UEpJVldPMnhxdVBrZ1dxT2NDbXVmb05GRWJod3BrMGZpZlJPNTJZ?=
 =?utf-8?B?WjZYK3psKzN1NmlDejBRc09WNThOeVpBeWkwV1Vzdi9wcStkMjlETlNxTE5L?=
 =?utf-8?B?MHdTNGJsdmlibzVZOTdObE5KM3hybVpEOGhvY0pCVnUwcjBCSE1sNVZIbU9N?=
 =?utf-8?B?V3N0Wlhjdnp5UFJpMkJHZUo0RFpXUWpKNm9BM1FOM0tUZTQyeE1FZ0VuU3hN?=
 =?utf-8?B?RU44ZWYvQmVIRkYrd1BWYzlkdTg0c3pmejdxUDdRZGo1STdWK25MVEFGVFlX?=
 =?utf-8?B?RXBHck1hRXI5bWlxUy8vQzZza0NFaWtKUitzN3NBby9TeDJHQm14eDNjMkl6?=
 =?utf-8?B?dERyK0RjeG5BL0haSDZJcTVZUnhrOTM5bWViZDUyOXlYMjVVQm1sc1Yyazkv?=
 =?utf-8?B?cFQzT2tGNWZpUW80V2VVRlZjdWl1akZhL0tOSkxOb25uQXdjaDJrK1c0SEpQ?=
 =?utf-8?B?Vm1SL2QxT1FpcU5QdWRkWEg4RFVGUmlQbVlOT0pSOHloT1ZhQ0kyRktMUmJO?=
 =?utf-8?B?WFFxbmdTaEw5UldLOVk5TCswMTJXS1YrKzZ1TmRZNnBHRFllbXA3MVNIS0ox?=
 =?utf-8?B?VFR2TWd3ZnZRRFdvckRIamNtUkNJZW10d1Q2TUZENGY0NTVycldnRFhReENo?=
 =?utf-8?B?eXNwcFo3MVAyVDJlUFlubkVtOUxTMnUxaEFia3ZBNGlJNE8xNnlhd0VQK0xV?=
 =?utf-8?B?OURnUjFEMysyMENQR3lpK0hzTGtKN0ZTM2Mxd0I5NTl2MG5hdEg3T0NkM3Fa?=
 =?utf-8?Q?jBNmqhvpEG5Nb?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6510.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3RKUFhGWjEwK2MvQ1I1RHJScFo2dTV6R3JGUGlwWDdndWhoa2VWRWZPUVA1?=
 =?utf-8?B?VHB2czlKS1NYMFh0a3dod09JRFNwcFVaVmltYy84STFzQSt2ZlpvNmVTS3Rx?=
 =?utf-8?B?QmFvM2l2a1dGcHIrUFVXWldPTkQ3SFdBWWY3SzNsMUVaVHF1c0VPVFZmNzI0?=
 =?utf-8?B?QUdRM3RqempoNWVneG5qQWJHRGVCWER6Z2RHR1NUcFU3WEVxQmYzMzhyenRj?=
 =?utf-8?B?MzFscUV2OFlDOW9EYVcrR0tpQUVSS29VbnVSU0MvT043bHM5VUNjNkswRTF4?=
 =?utf-8?B?SUFaSHRVWUdidlcraC9Gb3lVeng5UXlnMmJQcXFaSjFrOWdBUDhHM3VHQTRW?=
 =?utf-8?B?U2FwanR3WGZFSUROZk00dm9vYU41NGdmVDdkUTlHMC9XNHU2NmRhWkRmTGE5?=
 =?utf-8?B?MFdwZGdTbllhSFlyWUVnUkVscGE0OWhoWUlpNGYxc0pvNCtJWFJpUHY4ZW4w?=
 =?utf-8?B?Vkw0NGRRSHc0K24vbUhjZDRLa1VjWXQzYnFsUVMydU42M3dPMUt3SnhsM0xH?=
 =?utf-8?B?WXJSeFN1aVdzVCtkMHZCZ000ZTYrdWloaG5tLzQrQ2d6aEpiYUE2dEoyWTM2?=
 =?utf-8?B?QkkwN0VyYzZxMHZZbC9EZTZzVlpQd21wNWUzWC9aRUxaR3NGcy9GNVBsM3BL?=
 =?utf-8?B?WE9UQmsvc1BoMjlCWXJBL0hmME5aU1VtTXB3RlU5cjZXRDMzSVF0ZHR4QlU0?=
 =?utf-8?B?eE05YmlNeGk0bm9VbmtxUjFkS3pLYkNFdU5tV3NHajRVVnYxQ2syQTlIWkNz?=
 =?utf-8?B?VllKU0VCSnFHK1V1RFRMbG5Db001a0ZsS1lXY1d0Tkplbkw3RzZGUkFzc2ky?=
 =?utf-8?B?MzkzWTI0VktJNmNCQ1FaZ3I5TjhEQ3ZzZDhuSDg3bVY2Z0FUUkM4UXZFTFRj?=
 =?utf-8?B?UU9GYWQxcXdnQytGS3BabmtnN1VQTjhwRlJkelVYM09yUyt5Y0xDTEpVQTBl?=
 =?utf-8?B?NzNPUDd3V0Q3VWtJQzBhejc0YXAvRXFEd2pySkZvNGY4QUM2dExsWFZZelF3?=
 =?utf-8?B?K0Z0bXYzRkFzWlBXaDFMamluVEoveXlCTWFTU0Z1NzF2djExS2NPaU00NjhD?=
 =?utf-8?B?ZEtCNVpVVlFraVROSWVoRk02c0NBYVJnNEdOVkI4TzVSWDMreHJQdWxKRG1Y?=
 =?utf-8?B?RVJ4c05vV0YyWFkzWWFsZkVpVjRVb1BFTVdtVHhEaHM4WUZjOVBNOHlrUmMr?=
 =?utf-8?B?T3hkK1hiUW44eVhWMFhiRHlpelk4eGNZYmM3VER5dVdqRFBNd1hvRFVDRDJs?=
 =?utf-8?B?RG81L1JFWHpGdHdxVWpvZk53Rjg0YmRaV0IyWVBpVjZUYWcvcitSQk9ieXhX?=
 =?utf-8?B?MG9kUXQ1SGFVRVErNHN6bjZZVk1Va1JHZlJWZ0tsNWZ1RHVwTENBWDR0Mnhv?=
 =?utf-8?B?bjBRWWNCcmpFNFhwanFXamVjTXUxaE5lYW9CTXUvQTRpeWxoK01hQzIrVGxx?=
 =?utf-8?B?Y3JLaS9lb3RvQ3BWRzdTRVBZcEZuWFUxVVlLSE1qcVcvQlROWVk2eWVTK3Fu?=
 =?utf-8?B?NG5nRnF1V0I1R0NuMnJLVkZ5ZVNqeG54U21VcWhWMFZ1QWR5SEdyRG5BTExN?=
 =?utf-8?B?RkRDM0JldnN5SkZzdVk0eUZFa0hpK2pBTXoxYmFUZ2VpbE4ydWJLMlNvWGtl?=
 =?utf-8?B?MjlNUXNleThaVmhLTlZON1ZrMGNRODNqK1RkejVhb1RCTjN2V0RpZ1NIa2xt?=
 =?utf-8?B?dCt3UkdqWEZZZWpnbWd6aGZZZkt4djA4aU11ektWeUJVUHVuODQvQlRiOGI2?=
 =?utf-8?B?QUwxNk5JQ3VIQndTN25kYmM4N2RyVEZGMDFFTmNLVi80cE9JNVpEL2szbitZ?=
 =?utf-8?B?MWNSMVl2UTlqMUlwT0k0K2ltS252OWo0YVhzSkFCdmMraEkxZmphZlB0dGIx?=
 =?utf-8?B?U2N4ekt1QTdQT2d3RzRhRi9YbjhHdlBNQkRoQWozNHl2Q1JEZnh1akJJVTZB?=
 =?utf-8?B?SDJzcnczUjVwSytlZUhTTXpZNXBEZlg1aE9WSS9haURoU2N5VEgvaFVXYVNm?=
 =?utf-8?B?aEIzOXg5UVE1STNjMFJPdU9RcllaN3V6aGFKamFSRlZOVk14ZXRHdVN2Rk54?=
 =?utf-8?B?a0NzdjY3K1ZBZjV2dXJqZG5BWmFrUjdoL2JiU2lKVGg4NFdURVArSlhZUjlT?=
 =?utf-8?B?dW1QUk5paS9pcE9Cd1V4ZXpGNkdVaC9YRm1yckp1T2MwZU9GeWJ0bHhhQkZI?=
 =?utf-8?B?Snc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: cZBpKewocKUF8YccZwgEtNjvrr4rus3APvwkdS3M2UfG/f3/ISUt43vBSmurcAY3ppDRcYFdQEYZZus/c6C7Hn7f7wSq95o2a1NlQRbVkNdvFON0c9ApVyNdYkOTbilsU8UGqNZXpHtAITo0OTAJUReMAsii19dY3tLn4Fd3y0spIM47h4pgSrJ47eJFDuwYMAAmmSwK6uVUQLWHhILErWYhCX8xuG170D6Y1Btx5eXhnXXJOLFk0c/CYutttoF18UeT0sjUfw4BNFRhfigMgQYdZV0d0YabgjbV9x/Fxpu4HK/+8RAKxbi6Fln31gpX2ciLGUGJbmV8IjGb9Pw4sU73cf8casxiHRnRqsV/aWoB2ft14Y1Cz5HMk7kGsishLEyEATZ+YdmCfSTfB/CQgZ2Kxyx1fL++1RWSh0a4PohRyp1jsCKaVmgu2Wb9fg7aDQ0Bx/vQMIbTohN4/x4P0MlWJj5s0HKNed4mWIJUAIyGYuoac4mZBkKely+xl8KQNDtDFyfh3rmaUcQg05bipNz5aaCVRx35awp85v/SGHoX2UGgichG4e+wPtOP1KHFnQwoVTooWzGbpf5RwXawsaQt95ajUNrAJvRLYtJU4NE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddaada56-1f95-476d-b27e-08dd3604cc63
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6510.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 08:07:19.6062 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6duwwZud9ZlnNmYAg05Fq7jrOhxK24AldPDE3vDhY8cHEfOP0wIULJklLtIJ1dLUeYbwNgsbwpVq65/geotmRQeNbER8AQgilHyV2qI2NI8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4306
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-16_03,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501160058
X-Proofpoint-ORIG-GUID: j3EqMnTMCf8iUFebqanJE_LS2fRacjwm
X-Proofpoint-GUID: j3EqMnTMCf8iUFebqanJE_LS2fRacjwm
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Issue faced in memcg_stat_rss while running mainline
 kernels between 6.7 and 6.8
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

SGVsbG8gTWljaGFsCk9uIDE2LzAxLzI1IDE6MjMgUE0sIE1pY2hhbCBIb2NrbyB3cm90ZToKPiBI
aSwKPgo+IE9uIFdlZCAxNS0wMS0yNSAyMzo1OToyMCwgUGV0ciBWb3JlbCB3cm90ZToKPj4gSGkg
SGFyc2h2YXJkaGFuLAo+Pgo+PiBbIENjIGNncm91cHNAdmdlci5rZXJuZWwub3JnOiBGWUkgcHJv
YmxlbSBpbiByZWNlbnQga2VybmVsIHVzaW5nIGNncm91cCB2MSBdCj4gSXQgaXMgaGFyZCB0byBk
ZWN5cGhlciB0aGUgb3V0cHV0IGFuZCBuYWlsIGRvd24gYWN0dWFsIGZhaWx1cmUuIENvdWxkCj4g
c29tZWJvZHkgZG8gYSBUTDtEUiBzdW1tYXJ5IG9mIHRoZSBmYWlsdXJlLCBzaW5jZSB3aGVuIGl0
IGhhcHBlbnMsIGlzIGl0Cj4gcmVhbGx5IHYxIHNwZWNpZmljPwoKVGhlIHRlc3QgbHRwX21lbWNn
X3N0YXRfcnNzIGlzIGluZGVlZCBjZ3JvdXAgdjEgc3BlY2lmaWMuCgpUaGUgdGVzdCBzdGFydGVk
IGZhaWxpbmcgc29vbiBhZnRlciB0aGlzIGNvbW1pdCA3ZDdlZjBhNDY4NmFiIG1tOiBtZW1jZzoK
cmVzdG9yZSBzdWJ0cmVlIHN0YXRzIGZsdXNoaW5nCgpUaGlzIGNvbW1pdCB3YXMgcGFydCBvZiBh
IDUgcGF0Y2ggc2VyaWVzOgo1MDhiZWQ4ODQ3NjdhIG1tOiBtZW1jZzogY2hhbmdlIGZsdXNoX25l
eHRfdGltZSB0byBmbHVzaF9sYXN0X3RpbWUKZTBiZjFkYzg1OWZkZCBtbTogbWVtY2c6IG1vdmUg
dm1zdGF0cyBzdHJ1Y3RzIGRlZmluaXRpb24gYWJvdmUgZmx1c2hpbmcgY29kZQo4ZDU5ZDIyMTRj
MjM2IG1tOiBtZW1jZzogbWFrZSBzdGF0cyBmbHVzaGluZyB0aHJlc2hvbGQgcGVyLW1lbWNnCmIw
MDY4NDcyMjI2MjMgbW06IHdvcmtpbmdzZXQ6IG1vdmUgdGhlIHN0YXRzIGZsdXNoIGludG8Kd29y
a2luZ3NldF90ZXN0X3JlY2VudCgpCjdkN2VmMGE0Njg2YWIgbW06IG1lbWNnOiByZXN0b3JlIHN1
YnRyZWUgc3RhdHMgZmx1c2hpbmcKClRoZSB0ZXN0IGxvZyByZXR1cm5zIHRoaXM6Cgo8PDx0ZXN0
X3N0YXJ0Pj4+CnRhZz1tZW1jZ19zdGF0X3JzcyBzdGltZT0xNzMxNzU1MzM5CmNtZGxpbmU9Im1l
bWNnX3N0YXRfcnNzLnNoIgpjb250YWN0cz0iIgphbmFseXNpcz1leGl0Cjw8PHRlc3Rfb3V0cHV0
Pj4+CmluY3JlbWVudGluZyBzdG9wCm1lbWNnX3N0YXRfcnNzIDEgVElORk86IFJ1bm5pbmc6IG1l
bWNnX3N0YXRfcnNzLnNoCm1lbWNnX3N0YXRfcnNzIDEgVElORk86IFRlc3RlZCBrZXJuZWw6IExp
bnV4IGhhcmpoYS1vbDlrZGV2bHRwCjYuNy4wLW1hc3RlcnBvc3QuMjAyNDExMS5lbDkucmMxLng4
Nl82NCAjMSBTTVAgUFJFRU1QVF9EWU5BTUlDIEZyaSBOb3YKMTUgMTE6NTU6NDEgUFNUIDIwMjQg
eDg2XzY0IHg4Nl82NCB4ODZfNjQgR05VL0xpbnV4Cm1lbWNnX3N0YXRfcnNzIDEgVElORk86IFVz
aW5nCi90ZW1wZGlyL2x0cC1HNmNnZTRDa3JSL0xUUF9tZW1jZ19zdGF0X3Jzcy4xenJtNlgwMkNP
IGFzIHRtcGRpciAoeGZzCmZpbGVzeXN0ZW0pCm1lbWNnX3N0YXRfcnNzIDEgVElORk86IHRpbWVv
dXQgcGVyIHJ1biBpcyAwaCA1bSAwcwptZW1jZ19zdGF0X3JzcyAxIFRJTkZPOiBzZXQgL3N5cy9m
cy9jZ3JvdXAvbWVtb3J5L21lbW9yeS51c2VfaGllcmFyY2h5CnRvIDAgZmFpbGVkCm1lbWNnX3N0
YXRfcnNzIDEgVElORk86IFNldHRpbmcgc2htbWF4Cm1lbWNnX3N0YXRfcnNzIDEgVElORk86IFJ1
bm5pbmcgbWVtY2dfcHJvY2VzcyAtLW1tYXAtYW5vbiAtcyAyNjYyNDAKbWVtY2dfc3RhdF9yc3Mg
MSBUSU5GTzogV2FybWluZyB1cCBwaWQ6IDkwODMKbWVtY2dfc3RhdF9yc3MgMSBUSU5GTzogUHJv
Y2VzcyBpcyBzdGlsbCBoZXJlIGFmdGVyIHdhcm0gdXA6IDkwODMKbWVtY2dfc3RhdF9yc3MgMSBU
RkFJTDogcnNzIGlzIDAsIDI2NjI0MCBleHBlY3RlZAptZW1jZ19zdGF0X3JzcyAxIFRCUk9LOiB0
aW1lZCBvdXQgb24gbWVtb3J5LnVzYWdlX2luX2J5dGVzIDQwOTYgMjY2MjQwCjI2NjI0MAovb3B0
L2x0cC0yMDI0MDkzMC90ZXN0Y2FzZXMvYmluL3RzdF90ZXN0LnNoOiBsaW5lIDE1ODrCoCA5MDgz
CktpbGxlZMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbWVtY2dfcHJvY2VzcyAi
JEAiwqAgKHdkOgovc3lzL2ZzL2Nncm91cC9tZW1vcnkvbHRwL3Rlc3QtOTAyNC9sdHBfOTAyNCkK
ClN1bW1hcnk6CnBhc3NlZMKgwqAgMApmYWlsZWTCoMKgIDEKYnJva2VuwqDCoCAxCnNraXBwZWTC
oCAwCndhcm5pbmdzIDAKPDw8ZXhlY3V0aW9uX3N0YXR1cz4+PgoKSXQgaXMgaW1wb3J0YW50IHRv
IG5vdGUgdGhhdCB0aGUgZW50aXJlIHRlc3Qgc3VpdGUgZGlkbid0IGV2ZW4gZXhlY3V0ZQphcyB0
aGUgc2Vjb25kIHRlc3QgaXRzZWxmIHdhcyBicm9rZW4uClRoZSBsYXRlc3QgNi4xMiBhbHNvIHNo
b3dzIGVycm9ycyBpbiB0aGlzIHRlc3Qgc3VpdGUgdXBvbiBleHBsaWNpdGx5CmVuYWJsaW5nIGNn
cm91cHMgdjEuCgpUaGFua3MgJiBSZWdhcmRzLApIYXJzaHZhcmRoYW4KCi0tIApNYWlsaW5nIGxp
c3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
