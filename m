Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CF66C4345F
	for <ltp@archiver.kernel.org>; Mon, 15 Apr 2024 21:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1713215272; h=date : to :
 message-id : references : in-reply-to : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=6GKMN57rfMm6vqp+j+RKIo6jC7dEyJDtMwsguXzGZMs=;
 b=Shw8Gs+kxv/JRcw7KgGqPaBwzs3AOAylJrxipN7jKMMEirDWs3qmvAJQevI0R2dLS557W
 lgdDvuxlJeCY2OYK3v6f9DBeXXiMDcQDX/mJCtYkmv7p4OGU/QlEfPHdnIfXow8/Tl7vhQw
 A6eDKcXRIoxdrcG1Res4GZ2ySrb0UuQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2C2D93CFA58
	for <ltp@archiver.kernel.org>; Mon, 15 Apr 2024 23:07:52 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2F7273CF91A
 for <ltp@lists.linux.it>; Mon, 15 Apr 2024 23:07:28 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=oracle.com (client-ip=205.220.177.32;
 helo=mx0b-00069f02.pphosted.com; envelope-from=chuck.lever@oracle.com;
 receiver=lists.linux.it)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id DD2D5600C46
 for <ltp@lists.linux.it>; Mon, 15 Apr 2024 23:07:26 +0200 (CEST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 43FKmqBC019069; Mon, 15 Apr 2024 21:07:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-11-20;
 bh=RWKjeDS/S30bpJUxKdDQbir5FA4CZJE3hSOclIENrU4=;
 b=GRNeGsNicvaksdQRXd/OU/NkfeCAOHSOPMXkURQzHwpQ/iAoPhOpb+KW5SH2gcMSdAIx
 W72SruvnczulKjzAtteER7/BTUGkt8uP58l5dGk1wTl6NFterKcfZbPzs4qDO/2QxZgg
 8axTJIanby8Me6Ak+UfAs432/IoAzgh91BSs3CjvvdFJWlYwoe1GBqJq8RdN4hSxrBm0
 cOFdF9EKTyTmK7xaHO8Gn62ehOLitnFBBt+ey2NL315jh5HWr4MJkphtuZeZPoyg5Isc
 4RUm9DMBqiLpH+P1ZlOzEKDqZFopPiAO+7lf8fBeI50boKhoD4mgaruZYthYVDQ/ke5/ 3Q== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xfgujkvjs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 15 Apr 2024 21:07:22 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 43FKWqXn021762; Mon, 15 Apr 2024 21:07:22 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3xfggcm6b6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 15 Apr 2024 21:07:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Van726O2MZC13kraNHAFT5h0brvYHlP62o3vR56qidVHlAtJnG631j0W7HdOIodDQVa9IBYAfHkNl/HZpEPvbbUDk6DscU3UXiLE1Q6S+egh1SsUFyozErL1xCSn2E/NCEzZQc2dLfsZ4vC5OVjqg3HHHFuxgiVp6cO9gNCUnhzAPBCX4N7YdBmYAbS8mKRAXrEAl6y+qBICC2hxjLETQk522mU+MnXeIoNLW5YfYqfImLrxI3eVPIy044OUSMvE8q4VVXg1K8JH8eKnGoCChcl3urpgHWLz7MSZBqbGTciu2VQdQb0ob99aqBbD0F34MDuEFKFCRW5XTiqawiqU1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RWKjeDS/S30bpJUxKdDQbir5FA4CZJE3hSOclIENrU4=;
 b=aZ0dTkVpRIAamctZDmihuZNRY0GoATiNldNZQEKFSMcaE4tgvusBrJMMkNdp6jzxlDgu19SJPdfp4YLE0VfaZGTHTwuk14H5iBct1AjahVxMMEYoqcZyE/G94VhEFM+tnf2KpyESY9PVOSi66jxn2puZj+bmUpniHKjl7B77dZwTkiTwCva2xA6Ode2oY9akpIvrfOKG2smRo8D8kvNgjA+PRr4QNZCtLR4IgwZ2unLEwVbBV/ZBy29PhuHfkBmSR91hCPo/hGQq9reT2EAudIi+LFm5OluDB5NroC6vBmohBhdBI1swRb+L1gZpAj7b7pAWflcoeFMd8WHJgQEvZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RWKjeDS/S30bpJUxKdDQbir5FA4CZJE3hSOclIENrU4=;
 b=wUvIHdFWYEsB35Tsnh5vs9pkMg3+4FWcZrbjhv+pmUufqqjmLGcsWEKb0Jnq6TeZZRjQwsYQFbeo6a6MQl+vPFLXFC1YuCS/UkvpnuCVCYreoCh/qKcl7KDz9FEREUwPuyeksXCRB6YbuF3GywdpNwlwThe2r8lI9ssZ0uZFj1A=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CYXPR10MB7976.namprd10.prod.outlook.com (2603:10b6:930:df::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 21:07:19 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.7452.049; Mon, 15 Apr 2024
 21:07:19 +0000
Date: Mon, 15 Apr 2024 17:07:17 -0400
To: Jeff Layton <jlayton@kernel.org>
Message-ID: <Zh2XBV/sW67dx+wp@tissot.1015granger.net>
References: <20240415172133.553441-1-pvorel@suse.cz>
 <7A48C70E-BAAB-4A1C-A41B-ABC30287D8B7@oracle.com>
 <d895ad115632912df228913d4a86e7f597b22599.camel@kernel.org>
 <6820832A-9F38-4DE7-8EE4-7AAC8CF06FD4@oracle.com>
 <5052616ca4c2789ffcc51a27cbff060e2fbdb7b4.camel@kernel.org>
Content-Disposition: inline
In-Reply-To: <5052616ca4c2789ffcc51a27cbff060e2fbdb7b4.camel@kernel.org>
X-ClientProxiedBy: CH0PR04CA0081.namprd04.prod.outlook.com
 (2603:10b6:610:74::26) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CYXPR10MB7976:EE_
X-MS-Office365-Filtering-Correlation-Id: b5954170-07b0-4428-85b3-08dc5d90099d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cWpwMC85MEtKQmRhWURmciswY0hNMkVqTmhaS3VncGhBWlpkdDFGUXhXKzRV?=
 =?utf-8?B?TCtoV3BkR3ppUjUxdzJpNlQxNGtGNzMrUnRSckd2bk9OeHErcmtkTnJiazBt?=
 =?utf-8?B?bHBoQ1dkOXc5eGRWNzFTYnZJN2hLMG1qVFZING94TU84SzhDWUV5Tk4xMnIx?=
 =?utf-8?B?VnRRZS9aR015Q2ZRRlRtTlhYRkZ1TjZLbUtuM1ExeW9IWlBDcHI1Q1NPZmJu?=
 =?utf-8?B?WTd4b29JbGg2dm5QSU5nSXlNbnloc0V6cmZVcCtsSjFSMUtLMTZBWW13MVFJ?=
 =?utf-8?B?TlIwR2Z0WDNPR0JSb0NsdUJPMFdEUFV6a3p4Y2dMc3ArOG5Ob3VTK1JkWktW?=
 =?utf-8?B?ajRPRnAwN3c0bDF5NnBlWnA3QzkrZjFEZkhpWlhiUU9MNWZuM2FBSThNVmZM?=
 =?utf-8?B?WHhkYlJwTy9YdWkvcnVwTlk5SUR3Y0ppOEdORnRKV3JndHJndWlUMmJPZTJO?=
 =?utf-8?B?cnhOS0tLWUhBcHVQYW02UlNiV3k0eE9LYy9LVTRZaGYvNUllTndMQTR1R1pB?=
 =?utf-8?B?enRBYWZCdldxS0JxRnhhZVBMWkdUTDl1NWZVRkcwbVRHdWVoUk10UHpsRnJ5?=
 =?utf-8?B?dCt4TzEzVHZpQ3UwZVdrQ3ZkOXBqVFp5aDFNWXVmS252c2dRV2RvREl5TWhL?=
 =?utf-8?B?elowRnlpZ3A3ZE92NmFBWEEzRnFYRFNJbnFPRG1nYzl4MEhVMzBKeDQ4a1M4?=
 =?utf-8?B?TnpKWm55dllOTUdwVFcxdGRDdWhnT0pHKzhMMkMzbWVvMVUwaEU2ejAxaDFu?=
 =?utf-8?B?VlhvUk40U2N3NXp3aC9TSkFIREpEeWE5UDV1c1BoeXF1eDhOY2VBSzNHNDdD?=
 =?utf-8?B?aWU4K3QwWW1qbmRRWnV5U1JxdFhSRnFZZVI1c3Byd2QrUW9nSExVdnNEMTBk?=
 =?utf-8?B?TUV6d216Wm96MHdDMmtWUlVDSzVYZGRoeHVYTzF3UzdNc0lDTjEzRjFkeldw?=
 =?utf-8?B?OXNkNjVVZDkyZ0tKVThrdnpxWmNidFpzb1hmWmYrR3ZsWktpMWtGaGlBYm1i?=
 =?utf-8?B?Nm15ZWJBSDZvNmczbUxvUTBSS3Y3OHlrWllaVGhlNjZPNmFzQlhmL29nRzU0?=
 =?utf-8?B?NHVqL3BNWG9Da3BGQ0hya21RQ1FycHY2czJCaWd1N0xSaHh2cEl4TWVRd1p1?=
 =?utf-8?B?WFU3ZmhGZzlYVjd0TlkvYlRFcWg1czJ5QTh2RGNWMFlZNWh3cHQ3NkMyVTJR?=
 =?utf-8?B?eUR4bjhVL08ySFJJOVJ4TndEdXBWSHFUMW1DMDMrMnV3ZGxGUUMrelM1Z1d5?=
 =?utf-8?B?OTNNbm1tcWFTQXZFNndJRmc4aGhmSkhpUmZzU1lNUkNOd0djSE5nWXFwdEVq?=
 =?utf-8?B?bWh4MVpSMWRMRHBQcnRCUzRJVTlYT042Ym8rUjBZdVJBSjduSkxWMzRhTTlT?=
 =?utf-8?B?K2ZWek9kcG43elpweFhnb0FYc1BqMFBZSmhlOEtXQWs3TEtnMmlTNnIvVVYy?=
 =?utf-8?B?a1JxaWloNTNPMEtxdGJyWWVMZ0RsWmV1bFBWa3ZIMGx4SzhDVG5FOEhkNUVm?=
 =?utf-8?B?QjlMa0R4N1BxNm5Ob2JScnpzNnoyWmozOHVtVXRrUHBPaFp1eE45N3NNYWpB?=
 =?utf-8?B?NTRvc0NVQUtJcFJ6eEw4TnltWmtPa0NnSEg3c2J1eFlqQnN0S1RyU0VaVDY5?=
 =?utf-8?B?Y05VdjFOdkNLbUhWUFdoSmRqNUJFQjV5NEYyZ3FuSVFKWkkyWDhZV0ZJQnRH?=
 =?utf-8?B?eXBqd2RCaThrTzJSQXFQZkhHd29GZE1laFdyZEgyUERSalpUZFNONFdBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN0PR10MB5128.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVc1TS9iK3JmT2Z5ajFrcVE5Mmo3RzBXR1A4WnRuQ2p2N0VNSmM0dFZEQ2Vi?=
 =?utf-8?B?Mzl3cGpqb0hSejloc1RFTklSak1XZXJzTGZ4bUk1d0RvL3dWcUpYZjEra1do?=
 =?utf-8?B?cEdDQVViRFB5NWJESHFXbGM5ZmozbUU0QWZUUUdFNjZaVmY1UUxyQnFMLzRR?=
 =?utf-8?B?MmlYQlJFa3hvNGZSZGNLMENOV0dpR0xpQ0s0a2FZbE52QnNIL3M3OERobWo0?=
 =?utf-8?B?Q3VSVGVxcE95aW1qYTlUVlk2M3lWQ08yOFA1NXM3bndzbisxMXBDSDFOMHJW?=
 =?utf-8?B?VTVhbXljNHAwRENGM0tJZEFTcU12d1pHcDRrNGI1QzI0TlpUaXZYWVkzSjlW?=
 =?utf-8?B?dC9vNUNNOGFtVUN3V1BVTHNIeXJ2OFAyakJETGZETmhvMjNER0duaTZoQVVy?=
 =?utf-8?B?cnpBRk1XN3NrTy9QMEhaeWk1cGFrbTRjc2E2RnZSYmlnVGVsUnVzN3lkTXNy?=
 =?utf-8?B?dDJNclhGaFJ4S0dIY0lIV3BjTS9LdU5zQ1JqZVo0UEw0K21WdUo2VDFXdlhX?=
 =?utf-8?B?aXAzSmlKQStUUE5aRkVKNncybXp5MG9tZ3V4K0l5WEdvZjBaWWVyVHl4dHBh?=
 =?utf-8?B?aW44T2JQaElvVHlEcS93ODBlSHhPK0JkdVNQRVdzaU8xb3pobVhRNDQwNmkv?=
 =?utf-8?B?Qy96MDZ4a3FwYXk2aVh3ZktVN1BvV1diVHBHMkptMTJRWm11YTcvNnRhQk92?=
 =?utf-8?B?YkxXU0Vta0UwaEt1UERlT245VWF1c0Fvbjk5SzhZaWVNcDFsZk4xTUo5ckF2?=
 =?utf-8?B?NXBmR0MzdjFrTFkxSjFXUDVMZm85ZkFRdW9oV2FhK2RMdHloRmFUckRiYW9h?=
 =?utf-8?B?amx2STF5YjZFSGxIY2IrTTlaSG1NNXJkLzdvNDVwS1R5ei9BN2FsbDRxands?=
 =?utf-8?B?d000WDROb3JIck9FTk1wZ1ZCR21NRzRBdGpYT1FReDFQZ3BJRW9JY2dFRFZi?=
 =?utf-8?B?VTFIT2g5RjFqRC8zbnpTY2I2QUo5ODArcjduYnFNOW1FcldzZTg5M2hYVG9y?=
 =?utf-8?B?SFdkSEFoRzYxMndJcUhpRkF3aWZtc3daQm8wTFlFdzgxL0VXaVkyWWpmS2pX?=
 =?utf-8?B?Y3I3RkEvVHpqZ3NYUFJJTmwrM0E2bDBGQnoySGpucU83VFpObE1TZ25FQXVp?=
 =?utf-8?B?dm5Fb3VvYXVtL1poWUJsWlF2V3R1S09EcW9Mb0VHVnUwM1hYRk8vcWdJaHhR?=
 =?utf-8?B?QWdrYTJKRjh2UFRjMFdtM1RzRlZ3YjBEYjBPci9TWWtQM1g1aWlwb0FPVmQr?=
 =?utf-8?B?MmdqWGZjeVllZm81aEJyelpLM3h0WCtjc2RMLzArYmRFL090ZkNnUTdBNnRu?=
 =?utf-8?B?NW1HRlhtNWNBbkxmYzF4UEIzM3R3TlBjcEhlTGIzMTlORnRydGMrUS9xWnFr?=
 =?utf-8?B?eitZekpjQkJCTnA0aDJ3SDVJMjBwWmtKejNGNldPZXhQZXNkQ3lwd2UwazJr?=
 =?utf-8?B?NFI1SGlOT3NkanNLZlBmQTlXZnA5ZFBmTWVYdFFVR0xFdzJHL2U5TlRDSVpj?=
 =?utf-8?B?RFB3VUdjN1NENHRWR3BISmhaaENIRkJ2VGp2emxLWWhvMVNDS01yaUNlSkpl?=
 =?utf-8?B?c0tudmFrNW9nZC9NQjcrR09Rc1JrbCttczZkUmtFYjJ0K0JzQ1lGMVZweXpK?=
 =?utf-8?B?ZEVWS1VpckpUU3VJc3lheXV1UDJXSW95VkZLTWZ2ZWdPTGVoWkJrTXlpcDZh?=
 =?utf-8?B?SjBJamcvY0VDMUtjRVpUSk9rSHRhQVVKUytJOXdQVzROaFhhc1lpUVBFQmZX?=
 =?utf-8?B?ZkxHMjJFREFyeFJTcXZKbXNNUnFNeFhmejN2TVY3MVlVU3pWYkhrcHluVTc3?=
 =?utf-8?B?TnBRa2ZlVm5Qbk1QWm4vWFRKMzhUbWQyMklaMDlYRmZQNkJRaEpYZ3VsaVMx?=
 =?utf-8?B?WFc2OC9SdFNTNkUwSWtlT25IWXVXQ3I5SkVmN3JCNm5wSHc3eUE3RmtGUlpY?=
 =?utf-8?B?RGVIM3VMUG8xUVBHbzIyT3U0aUx4djZHbXk5RzFCamhIWDJJTmx2K0tYTW9W?=
 =?utf-8?B?RXNYL0RNRGZ5SWU5WDkyQndRS3JtTGNXTTRzMGRZZi9GNyt6QjlrYUphbXRB?=
 =?utf-8?B?T3lFcElFM2ZYUjdESFdQQTgxZC9IZ1locHkyZ0Y3dXVpTFpNU3dhMHZDUlpF?=
 =?utf-8?B?VWxUZUpQN1prWjJzdzg0cnFYUkhiWVVya1pBMUZUU2xnZlB5b3NJTmQvQ3VZ?=
 =?utf-8?B?c2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: XFTPo068ME79LlAOWUg6xft57k9y4xScY6O4Toj4OKkP1TAA0kJwkW+IcXj7+ISJ5A8/8oinUGiYctbBpYqrhGo3gknYn/gS4ZCYA9OcwWVpQLXKFTBhRciyDbnIMDw6faioLQz4HdUhQjvwDunVQxel/NybsUMw3pxY3uBrk2CYiv9lrQGp8ubhto5OiaA2ikdLAfyPiZQTBzWMHYnf+oOt0FlmdZGY7V4sUYA8PlEbpPuxZktKAbXiD0zIPIzHfvfQFzRPlY2V2IFoek5OzXCkKH017fOaOfxHf0iD8rleWNnrjIy867rHFiNS3kFnN0s+3e6GklQpyPjjedbWCkadENV9qzJNO9BMM7iKBaEsNC6JQoFl2rsm4x0/VBUDJOex1HH38MNmiQHdrSSe3ypad/NzdlLVqdyySBrt1Q+0P0WJCUyxyxrdomk0UCvzVqvDnn6wDzJ5V+orQ8qPxWBCKdxIF5cNJ4leGJ5pY5rpJ+gGDvfKH4LELoNlH0wRXd/j8hy6OHGV8sLp6y58HsdFCZt/HeLnN1odicsIjhRrBTbrFpu8RH2VdBbp5+hb7v3w7uq6QDIDQZeDq5t5jsste2EQJyS1XjzomPLWEnA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5954170-07b0-4428-85b3-08dc5d90099d
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 21:07:19.9063 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4ZAsKGQQ8xw/+3/Xgf3tcq+Ce/yacQ6qvLCzT/EjQd9P005eRe1pd0kn/OayA6odr+pgeTXq2BNHWmf748jBTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR10MB7976
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-15_18,2024-04-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxscore=0 mlxlogscore=654
 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404150140
X-Proofpoint-ORIG-GUID: eyMWa24Ig0zbLzlkgIwpzHOP7h0WA2vj
X-Proofpoint-GUID: eyMWa24Ig0zbLzlkgIwpzHOP7h0WA2vj
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
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
Cc: Neil Brown <neilb@suse.de>,
 Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gTW9uLCBBcHIgMTUsIDIwMjQgYXQgMDE6NDM6MzdQTSAtMDQwMCwgSmVmZiBMYXl0b24gd3Jv
dGU6Cj4gT24gTW9uLCAyMDI0LTA0LTE1IGF0IDE3OjM3ICswMDAwLCBDaHVjayBMZXZlciBJSUkg
d3JvdGU6Cj4gPiAKPiA+ID4gT24gQXByIDE1LCAyMDI0LCBhdCAxOjM14oCvUE0sIEplZmYgTGF5
dG9uIDxqbGF5dG9uQGtlcm5lbC5vcmc+IHdyb3RlOgo+ID4gPiAKPiA+ID4gT24gTW9uLCAyMDI0
LTA0LTE1IGF0IDE3OjI3ICswMDAwLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6Cj4gPiA+ID4gCj4g
PiA+ID4gPiBPbiBBcHIgMTUsIDIwMjQsIGF0IDE6MjHigK9QTSwgUGV0ciBWb3JlbCA8cHZvcmVs
QHN1c2UuY3o+IHdyb3RlOgo+ID4gPiA+ID4gCj4gPiA+ID4gPiAvcHJvYy9mcy9uZnNkL25mc3Y0
cmVjb3ZlcnlkaXIgc3RhcnRlZCBmcm9tIGtlcm5lbCA2LjggcmVwb3J0IEVJTlZBTC4KPiA+ID4g
PiA+IAo+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+
Cj4gPiA+ID4gPiAtLS0KPiA+ID4gPiA+IEhpLAo+ID4gPiA+ID4gCj4gPiA+ID4gPiBAIEplZmYs
IENodWNrLCBOZWlsLCBORlMgZGV2czogVGhlIHBhdGNoIGl0c2VsZiB3aGl0ZWxpc3QgcmVhZGlu
Zwo+ID4gPiA+ID4gL3Byb2MvZnMvbmZzZC9uZnN2NHJlY292ZXJ5ZGlyIGluIExUUCB0ZXN0LiBJ
IHN1c3BlY3QgcmVhZGluZyBmYWlsZWQKPiA+ID4gPiA+IHdpdGggRUlOVkFMIGluIDYuOCB3YXMg
YSBkZWxpYmVyYXRlIGNoYW5nZSBhbmQgZXhwZWN0ZWQgYmVoYXZpb3Igd2hlbgo+ID4gPiA+ID4g
Q09ORklHX05GU0RfTEVHQUNZX0NMSUVOVF9UUkFDS0lORyBpcyBub3Qgc2V0Ogo+ID4gPiA+IAo+
ID4gPiA+IEknbSBub3Qgc3VyZSBpdCB3YXMgZGVsaWJlcmF0ZS4gVGhpcyBzZWVtcyBsaWtlIGEg
YmVoYXZpb3IKPiA+ID4gPiByZWdyZXNzaW9uLiBKZWZmPwo+ID4gPiA+IAo+ID4gPiAKPiA+ID4g
SSBkb24ndCB0aGluayBJIGludGVuZGVkIHRvIG1ha2UgaXQgcmV0dXJuIC1FSU5WQUwuIEkgZ3Vl
c3MgdGhhdCdzIHdoYXQKPiA+ID4gaGFwcGVucyB3aGVuIHRoZXJlIGlzIG5vIGVudHJ5IGZvciBp
dCBpbiB0aGUgd3JpdGVfb3AgYXJyYXkuCj4gPiA+IAo+ID4gPiBXaXRoIENPTkZJR19ORlNEX0xF
R0FDWV9DTElFTlRfVFJBQ0tJTkcgZGlzYWJsZWQsIHRoYXQgZmlsZSBoYXMgbm8KPiA+ID4gbWVh
bmluZyBvciB2YWx1ZSBhdCBhbGwgYW55bW9yZS4gTWF5YmUgd2Ugc2hvdWxkIGp1c3QgcmVtb3Zl
IHRoZSBkZW50cnkKPiA+ID4gYWx0b2dldGhlciB3aGVuIENPTkZJR19ORlNEX0xFR0FDWV9DTElF
TlRfVFJBQ0tJTkcgaXMgZGlzYWJsZWQ/Cj4gPiAKPiA+IE15IHVuZGVyc3RhbmRpbmcgb2YgdGhl
IHJ1bGVzIGFib3V0IG1vZGlmeWluZyB0aGlzIHBhcnQgb2YKPiA+IHRoZSBrZXJuZWwtdXNlciBp
bnRlcmZhY2UgaXMgdGhhdCB0aGUgZmlsZSBoYXMgdG8gc3RheSwgZXZlbgo+ID4gdGhvdWdoIGl0
J3Mgbm93IGEgbm8tb3AuCj4gPiAKPiAKPiBEb2VzIGl0PyAgV2hlcmUgYXJlIHRoZXNlIHJ1bGVz
IHdyaXR0ZW4/IAo+IAo+IFdoYXQgc2hvdWxkIHdlIGhhdmUgaXQgZG8gbm93IHdoZW4gcmVhZCBh
bmQgd3JpdHRlbj8gTWF5YmUgRU9QTk9UU1VQUAo+IHdvdWxkIGJlIGJldHRlciwgaWYgd2UgY2Fu
IG1ha2UgaXQganVzdCByZXR1cm4gYW4gZXJyb3I/Cj4gCj4gV2UgY291bGQgYWxzbyBtYWtlIGl0
IGp1c3QgZGlzY2FyZCB3cml0dGVuIGRhdGEsIGFuZCBwcmVzZW50IGEgYmxhbmsKPiBzdHJpbmcg
d2hlbiByZWFkLiBXaGF0IGRvIHRoZSBydWxlcyBzYXkgd2UgYXJlIHJlcXVpcmVkIHRvIGRvIGhl
cmU/CgpUaGUgYmVzdCBJIGNvdWxkIGZpbmQgd2FzIERvY3VtZW50YXRpb24vcHJvY2Vzcy9zdGFi
bGUtYXBpLW5vbnNlbnNlLnJzdC4KClRlbGwgeW91IHdoYXQsIHlvdSBhbmQgUGV0ciB3b3JrIG91
dCB3aGF0IHlvdSdkIGxpa2UgdG8gZG8sIGxldCdzCmZpZ3VyZSBvdXQgdGhlIHJpZ2h0IHNldCBv
ZiBmb2xrcyB0byByZXZpZXcgY2hhbmdlcyBpbiAvcHJvYywgYW5kCndlJ2xsIGdvIGZyb20gdGhl
cmUuIElmIG5vLW9uZSBoYXMgYSBwcm9ibGVtIHJlbW92aW5nIHRoZSBmaWxlLCBJJ20Kbm90IGdv
aW5nIHRvIHN0YW5kIGluIHRoZSB3YXkuCgoKLS0gCkNodWNrIExldmVyCgotLSAKTWFpbGluZyBs
aXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
