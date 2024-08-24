Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A830C52D6F
	for <ltp@archiver.kernel.org>; Sat, 24 Aug 2024 14:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1724511278; h=date : to :
 message-id : references : in-reply-to : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=yQ+vM/th+ms6KlXkb3pqFCJ3NvfbdWww7d+r5g099Ec=;
 b=ZiZW3KfJ3TTBDKuEJhLnitXYTakHHOhmhHYeiOj6zUmxFIozKRKSHL4imBpAANYzl48a7
 WbwWUv80xWPoEiDT4kAbLxLPbQ+YxzGm/reX5jA9IYNIGZ12dmVMljUGjGDbFkWsdjhmp7W
 AH7KXyb8VKhgznlbOv7+Q7Z/qcFnJKg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4BFDC3D25CD
	for <ltp@archiver.kernel.org>; Sat, 24 Aug 2024 16:54:38 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AF0FE3CAA32
 for <ltp@lists.linux.it>; Sat, 24 Aug 2024 16:54:17 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=oracle.com (client-ip=205.220.177.32;
 helo=mx0b-00069f02.pphosted.com; envelope-from=chuck.lever@oracle.com;
 receiver=lists.linux.it)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 1631E600FDD
 for <ltp@lists.linux.it>; Sat, 24 Aug 2024 16:54:13 +0200 (CEST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47O3tF89018524;
 Sat, 24 Aug 2024 14:54:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 date:from:to:cc:subject:message-id:references:content-type
 :content-transfer-encoding:in-reply-to:mime-version; s=
 corp-2023-11-20; bh=YEBp8nKGFvUIoUDWvlZtNFbgIKqBeUdgjJJ5M5mrwLA=; b=
 bIPmIN50+zsh9ZFdjBFehnWUEpK5sFbLVN3zD9ty5BGJ8p+z42azL99WAj3l1u0T
 KAQo87Ds+ndQcDy9720i+L1soTMZXiYuYzjOZE+RhZgz8A/RM+FFCtj4AND9sSgf
 5NlGY7o43lOqx52zzLedMXyF/2M+DkeggTnYJZcZjX7BhuN+56wjtHO6eq21DvQR
 3hTJkA6v5ddou6sPkbeSzDuB2xu3oJmItWM8uq6oPMKDM2gb/VdlUO4zgL6HhZJi
 kwOOKEcmYSRMXLa95wWeP8om035usPe0QFSu5eGu5coIhaj2U9BFKybDtK34TSHR
 4k+PvX1RAZbHeOC/JB5KRQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4177n40d8k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 24 Aug 2024 14:54:11 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 47OE9JdL001870; Sat, 24 Aug 2024 14:54:11 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam02lp2043.outbound.protection.outlook.com [104.47.51.43])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 417h1grky6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 24 Aug 2024 14:54:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bxrAKG9VPVGczddzc5rtbLpthpKSb7HTXjLG4C2MA6XTL7Y+/pzmeULOudxTLoNlJQ8Ftj6jOgM2IBHMQLtcbs4UEHJ/c0/2oD/V4SQYVWt8QTog5J3EIArJHfefJDib4585u0oNfA/ngs36eRw9GXnQAfrVXlycs4cKfHRPUsdL3STBxe/2Q0Jo5HRmwJGOEvXglFo//O80S+H1+7N8zrcNgQ34zBlo3L5SfSB1qhI+aInwgqH55QYqv4r8JYkeEBT83dXIqOClXGAfAh4o//5KXPiMQcG+hywQJt3ZukqF/6w18pWd8Wb519lf46x1FBcP83cyLk/0ONRGUFF/Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YEBp8nKGFvUIoUDWvlZtNFbgIKqBeUdgjJJ5M5mrwLA=;
 b=PdQklAk13mhKeOmn/mjA3DvBCBn27YWkG3rvs726JHXXqm+HRH71lBYfZxcBYYmNNAyVutD0trZCl0G0uPtUN4wEuwZasrktpyx/p27oVbFvEa5lFYYMKdVSeYQMVnMCb29i0PjETwZe/pwTI4L2xkV08rqmtMMR15KvgA4U34g/9Dp+8Ho8thXFS04qDfKGDLRmG6NLehhkcDeL7vFteEkNjvz445Xgu2JIbMxKQtU4NBgxhKtMFmUmXOQ0FB4AddppO+plMPpEeHJxd1KjbSGnle+tjwIYCq/FYJ/WuJUd07OGE3BWyeIwslek772BAi+hLtQvA52Thk3RkAUX8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YEBp8nKGFvUIoUDWvlZtNFbgIKqBeUdgjJJ5M5mrwLA=;
 b=iM0qb6IxVSNdZXZ1hWpHjhBlO11lD4//W0APgNFcOPwpMwveLW8BHOos6ObLFApyAdEP8vJvcOGM9KF/90zoBlzjvc5+XkhmNMbDc3fKDH0nbvd9zU6XK2vaI7P4RcDx/RN0jCHxkKVFMiVg3mvFxwhYI0DEZARGfJVFOgf44Ic=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB5136.namprd10.prod.outlook.com (2603:10b6:5:38d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Sat, 24 Aug
 2024 14:54:09 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7918.006; Sat, 24 Aug 2024
 14:54:08 +0000
Date: Sat, 24 Aug 2024 10:54:03 -0400
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Zsn0Cyok23EMVHmY@tissot.1015granger.net>
References: <20240814085721.518800-1-pvorel@suse.cz>
 <Zrytfw1DRse3wWRZ@tissot.1015granger.net>
 <20240823064640.GA1217451@pevik>
 <0BDD1287-471E-47A8-A362-DF660806CED6@oracle.com>
 <20240823185302.GA1302254@pevik>
Content-Disposition: inline
In-Reply-To: <20240823185302.GA1302254@pevik>
X-ClientProxiedBy: CH2PR11CA0021.namprd11.prod.outlook.com
 (2603:10b6:610:54::31) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS7PR10MB5136:EE_
X-MS-Office365-Filtering-Correlation-Id: 0688c44c-a467-4962-efbd-08dcc44c9a59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bm10Yjg5K253c2pRMzJySllEcXBiMHQySWc0SnEwVnR5elJwNTBXUXduUldS?=
 =?utf-8?B?MU1icE9KRUN2MCtreXkyR1F2V2VWbi9LemoyTGRwakYxNWZDRWh0elVrOWVE?=
 =?utf-8?B?NTcwemozTS82VGV2d0FpVGJ6NlJSNmVrYm5aZTFDS2lxTHhJOWNrcGpKdkF0?=
 =?utf-8?B?aG9jUkZDSm50Qkd5WGlXb0JhdXl3dVdlRDAwdzhBRnBJRzgzKzVyaDNWNVBF?=
 =?utf-8?B?S0lBY3dxNU5yV2FCeDFDOUdkTzhBTGRVTWdQWDVXUjNkVnJkR2hrcmxoQ0dM?=
 =?utf-8?B?ZGs2Z2wyWElNUGtqK1J4Wk4rd0JYNERGU2ppVjVPRkhBUmdUWmdlQUtkeXpV?=
 =?utf-8?B?bWZyc2hUZk1iYmEya3BoejVvZk8rYUNBeURIOE0wQXRVUUZmcElNSVhvYkdj?=
 =?utf-8?B?OW96VHdsUmlsYU1vQTk0ZXQxNitlUUEvUlR1UEw5N2I5YW5zVzk0ZFRvYXg0?=
 =?utf-8?B?UVJwdzZvUklIWTVBSWhQeDdGQmhQeXFYaFEvYWFXZ2dBRGY1Zlh3Ty9mZnVn?=
 =?utf-8?B?cDhkczBXU3puRzlNR2pYK0JXN2duczdsZ1hVbXd4c2xZWGJWRk5OWUxlZFgz?=
 =?utf-8?B?bEFuTE5ybHRScHF5TVdhbHFtdm5CMTFqNkJPRkJqSkJWSFprV0RNem9pSkVK?=
 =?utf-8?B?U2gzMzZGeWsvNGhteXNBcTBTOGhLLzVVbXdlQjIwalRQNjFRL3dzS1RpdE11?=
 =?utf-8?B?b2JxdEFDV2ttdzZta1Q1QXIzSmQ4enNyLzRydk1tZDQvVFk4MUQ4MDA5UGtF?=
 =?utf-8?B?L3A5YTZLOSt2ZGtmR2NiakhDd0RkNUtPc2tMRm5EZThEajJCUzBscllUQWZu?=
 =?utf-8?B?L2orSkNWd2piVTBic0g3eDhKNmFtcWFEd2c4QmhvZG9WOXMrcUNjV1F5ekQ5?=
 =?utf-8?B?eEQyYm9mWC9UdklRMmpUVWZVWjVoZ1ZWQzdQakVaMlR4QlMyZEtxMUVGTk5y?=
 =?utf-8?B?ZnlpVHBKYjhVWkQ4SThYU0JSc2QzMlpmbHpXYWZBdGNNYXg0TS9oY2NHYzRU?=
 =?utf-8?B?aCtwN2l6N1E1VTZuZ1hFRFJUMkxwVHdHOGtjYU55RnlaamFEZ3UzQkVwTVFk?=
 =?utf-8?B?Y3YrT3ZtajFBSTBVRkM5S3ZCS0drMi9ya1JVNVMvc2ZJczQwdVJDRHloNUM0?=
 =?utf-8?B?SHlubE0rMzc4enZoaGtzR0RwdE1EcVRDdzRiOStDRTFyOXdtL05menhFZjZO?=
 =?utf-8?B?YWJ6enpqMzExek1UNk1kaVliSDdldUJPMmRPYXZFSUpnL0VHSEZjdU5IUWR1?=
 =?utf-8?B?U1ZMd3UxckdicGtXdnJJSG80NGRBaDZqd3IyWkgxa2FHdW1NK3dYeDh6aG1m?=
 =?utf-8?B?QmsvckhYZXdISVh3ZEJ2SGN5ZFFOcUticUwrQ0NDaytvc1pOSTMrOVZaUFB0?=
 =?utf-8?B?SmY0dWx0VnVvTjhFZmd1Z0ZFQlh1VDY4TnNZcVFxN2RvaDFhM1dyRmlTVVEv?=
 =?utf-8?B?dXBXbHBPa0VhUU15NzlXWlppenNOVktMUVhaZnlTMVJabm8vTTlKRkZBN1c2?=
 =?utf-8?B?end5RlhkYWtSN1hnVWt3bEluV3VPcmZIVE5QQTh0K2R4cnhHeFVCQW95d3JT?=
 =?utf-8?B?QzhPdWhQdFJQVnZjWEMzc0xhaGNQSWpYaTFyTm1lT3lSWWdHVFRIS3FFL0ZU?=
 =?utf-8?B?RzFqT3VpcVpoa2VZYkFuUTYxNkE4OWhZWU01bm9STU1RY1JrcU5LTjFYYnBD?=
 =?utf-8?B?Z0FnN2s2RUVSenZTVDFzcStjSWJIM3UzSHc2eWJTQlU3alFlNG1BSDZqK1Nh?=
 =?utf-8?Q?NTSblAjQ7DWD+iIEntdrCYKzXmuYNFGRfGNEcZ6?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN0PR10MB5128.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWl2MWM1L25OTFhkZDlkNmxZNnVUSjREUzU4eGI2d0tCNnRuVTQ4N1B1MU40?=
 =?utf-8?B?eEJGVUFIRk80NmVLY1Q0Sy9PVWRTV3htT0NMeWtOeWtlZUNHS1VMSkppbEVi?=
 =?utf-8?B?U0ZlcW5iV0NEK25wVThjQmdPTGRFV2pZVVhvYms5MlJyWWY2YzBBMlI5OEc1?=
 =?utf-8?B?cDZSb1JXK1hFTWt1OE05NllLcTBhYVJLZ0R3WmYvYzdDSnN6c3BVV3Z5U1hr?=
 =?utf-8?B?YWNQKy9XYWNqRVZNbGI5c0E1YmZzYk40WkJ3ekdYa254U0RzK1FpSkc5dy9v?=
 =?utf-8?B?OU9aeDFkTFBRZlpDRVV3ckUyUGc2cWNBbjhiTmlONW1Lbk5xRnBYcHU5SWF0?=
 =?utf-8?B?amVicndQQmlyRFdKS0NQSU5HN3krOVFMZFdLajJvQlUyb05LNTB0MmtvTzBr?=
 =?utf-8?B?NDlwVmIxNWlpN092SWkrVnpVV2wza1I0dVVWZCtMNVlCaS9aVGs5TEpGZmZm?=
 =?utf-8?B?NnlkVkxzQXdnU3dsSjdrQjZkY1h6VU1JbWZqMzBGUkNZa0ZaNDhaM1ZNVGgr?=
 =?utf-8?B?VVJwSTZ2V0czNkJ6bTd2MFRoRFcwcFhmNlFhVVBXL1RUYkUwQUw2ZFltNEFF?=
 =?utf-8?B?YjlybVp3T2RXcDFqU2ZaTE9WajJyMmFNRW91Ukx4MndyakxQdDE0WmVPbGNP?=
 =?utf-8?B?S3Z1MlFRTDE3bkNlNWFZb2ZjamxEaDFyVU5EOG9EQ3dwdGNvTC9OUklnTGh1?=
 =?utf-8?B?V096SkFXNGtIeldsK0xpTXYyMzZBV1dxeXlIU2Q2aWtManJHUmsyaG9qMUc2?=
 =?utf-8?B?VmpuOEJYR1ZQVU91MmRDTVBRODRZZmdJNTE0LzNTVjdXT1hibWVIWGxZLysv?=
 =?utf-8?B?QmJVbFY5K0lvV21hRHBZbUFUN3NmRUpBcnovNEJuMkd5RTh3T0kxaHk5UWZR?=
 =?utf-8?B?VEUwUzUweXhDeXF6eGVuZWwzUHV4bGxuQXFYRDEycWx0ekd2b1BhRytnOVg2?=
 =?utf-8?B?SVJobGxBVHFGcHJ0bTg5VjkyZ0pqMkFVNWxUdGhLazFyS0l5elVJUGpSSmsv?=
 =?utf-8?B?VUJscENVSEYxd1F5VHRpUnBSZ0VRUk94R1p5TDdRQU0zT09IUlY5R3ZFRDBT?=
 =?utf-8?B?QUw1MWpJOStwL09JY0EycDR5aURsR0Y4M1FqSkRNS1FUZFBZR0JBeHBTWkc4?=
 =?utf-8?B?MDhwVkVpNTNVK2NRQkF3RkRzRFM5Y1AwZ05HMmtmb3hyT01ncXcxR2JPVzZM?=
 =?utf-8?B?aXZzTTVRaUpZTks1dEpBUkRoWGNWT1dXRWhweTI2SitEVnkrVVI4QjhNSU1S?=
 =?utf-8?B?SG9oVVl1UTQwcXVycXRzTUVobFo3YXVOTTZxK2Q2TUpXMDVvVlBqM0ZFaytF?=
 =?utf-8?B?WmtRZUorNEtsM1NkbktuRzY1RlVKazRRWFdIN040bHlHbVA5WkkyNGw4NzJU?=
 =?utf-8?B?azF1VVl6L0VzWDJTdkRPdmxHSEt3ZWlHWXhOUVNPem5CTjlraFN3WmpQcHVG?=
 =?utf-8?B?b25ELytoZlpJdnZhOWs2OEwrYk9YUHg4SzJGbWlwbFdpdmdyNjUwMTYrc0J0?=
 =?utf-8?B?cW95Q2lUV2plaGJXMzZFNGZQMHU4a01oMHpYaENndG8yTVZyRnArbGU3MjBo?=
 =?utf-8?B?R3FpR09jMDUrc242QStJV3JNTXUzN2FVMTRJSk5wQS9Vck1aaGRpajdKdVM2?=
 =?utf-8?B?akhqUHJlV29GZ1Rna0JwMjBTbHFPNjZBRUxIcDRUeXBCczA3NVB1RVZyZU1p?=
 =?utf-8?B?Q0R0b09wdm1jNEZqT1JDL2lTTnd4UFlmbW5xdXZTT1hNR25tdkZlKzF6a0Ez?=
 =?utf-8?B?OUEvVVdCZXdnWmZUbkdPbWZkWWlkU1VpczFHWS94RkNYMzkvMVZsRlVZWFRp?=
 =?utf-8?B?dW9xeW15VHZzMGp4eHFGZTgvVjd1eGczODkwUHhQemRzOUxIOWZSckxYcDI5?=
 =?utf-8?B?WGFVRy85TmlJbE5ZM2kzb2ZrRG5IWm1GcXNQazhQL3VxcC9YbWxvSHJYaSt6?=
 =?utf-8?B?VWJDVlNha2EvWnBOdHBjSGcrRjNaVk9IM25mUFNLckYvVDQvQU9wSW95YjJ6?=
 =?utf-8?B?OHFQMHNBQnNvRVVaQVVjcEh4b1FEVUwzQ2twT21jUFNiWXYyS0FiY0w4bWN1?=
 =?utf-8?B?SzkzR292UHhhUDN1NDFpdXVpbWVEaEhGMnZpL0lSVzJlbG82N3pDeS9acFVo?=
 =?utf-8?Q?QNaUCxsv2WMyZDeX5uEcBK7dv?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: IAiTaqE8b1djpteTTMepmrJUeXaGn5xmNik5ipMd1K30aXXyTjqpLZUBgocRzxZl6yLYV6T/B3JpNm/IqE4lR/AODX8s5Bzkbf81oU/TVvqUkHSji09Jf/8cBMmRHpYaS14IXAu3XbrqW+yOkBen5aGinDJiG8c7WV7muO6r1ErIkZWqpIqqAd1/mIbBmvBgswsjbWfk5kRTnLqZDu22k7oS4TwJtFnO+JPQFXkouU8El2EZg3A92wJIBM92vP5Yt9obW4m+maBfuVX+sLGTD2zSof6hBnewZhSnlYaDRgAKOSSK1MFYRishW5K29aBt0Wcwb38PPj9QtLZDEaSU3TTV7qyWod12MQp9fmlU8ppwyJ46u7JBAF+krfCLMGDs21dtlqgRjEuErupsdphfAmgit4qpoa1C5i5XazKYJBeVXfinUqPyU/t8Zb4bmlhfpbWn0BjAXlQmWjjHJl/0UHeYr7TBvtHKU2LiULFx33JbBFISwsfGu8YZTVuMPjct+5F83z1jUUKjIPrZ/H5rJxfCRIANTJtvvmQp+bmHY32zdJITQoGnV5L9nhVHYOGocdo6A5eDz0H9EKGlRRzti7IRT+L4ExDzsxaxL1AUXJ8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0688c44c-a467-4962-efbd-08dcc44c9a59
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2024 14:54:08.1284 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oFfDutWOlyHUnoP8agTGKBn8Qy0xKtrFqrCq67/VB7oaC7HkgbosNb2p8k1M8yG2STxnAwU0FvnLyk1d/fEDMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5136
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-24_12,2024-08-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408240092
X-Proofpoint-GUID: pxbJQuNfUtx35hVciUE51qENzmCVrLqB
X-Proofpoint-ORIG-GUID: pxbJQuNfUtx35hVciUE51qENzmCVrLqB
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/1] nfsstat01: Update client RPC calls for
 kernel 6.9
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
 Neil Brown <neilb@suse.de>, Josef Bacik <josef@toxicpanda.com>,
 linux-stable <stable@vger.kernel.org>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gRnJpLCBBdWcgMjMsIDIwMjQgYXQgMDg6NTM6MDJQTSArMDIwMCwgUGV0ciBWb3JlbCB3cm90
ZToKPiAKPiAKPiA+ID4gT24gQXVnIDIzLCAyMDI0LCBhdCAyOjQ24oCvQU0sIFBldHIgVm9yZWwg
PHB2b3JlbEBzdXNlLmN6PiB3cm90ZToKPiAKPiA+ID4gSGkgQ2h1Y2ssIE5laWwsIGFsbCwKPiAK
PiA+ID4+IE9uIFdlZCwgQXVnIDE0LCAyMDI0IGF0IDEwOjU3OjIxQU0gKzAyMDAsIFBldHIgVm9y
ZWwgd3JvdGU6Cj4gPiA+Pj4gNi45IG1vdmVkIGNsaWVudCBSUEMgY2FsbHMgdG8gbmFtZXNwYWNl
IGluICJNYWtlIG5mcyBzdGF0cyB2aXNpYmxlIGluCj4gPiA+Pj4gbmV0d29yayBOUyIgcGF0Y2hl
dC4KPiAKPiA+ID4+PiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1uZnMvY292ZXIuMTcw
ODAyNjkzMS5naXQuam9zZWZAdG94aWNwYW5kYS5jb20vCj4gCj4gPiA+Pj4gU2lnbmVkLW9mZi1i
eTogUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+Cj4gPiA+Pj4gLS0tCj4gPiA+Pj4gQ2hhbmdl
cyB2MS0+djI6Cj4gPiA+Pj4gKiBQb2ludCBvdXQgd2hvbGUgcGF0Y2hzZXQsIG5vdCBqdXN0IHNp
bmdsZSBjb21taXQKPiA+ID4+PiAqIEFkZCBhIGNvbW1lbnQgYWJvdXQgdGhlIHBhdGNoc2V0Cj4g
Cj4gPiA+Pj4gSGkgYWxsLAo+IAo+ID4gPj4+IGNvdWxkIHlvdSBwbGVhc2UgYWNrIHRoaXMgc28g
dGhhdCB3ZSBoYXZlIGZpeGVkIG1haW5saW5lPwo+IAo+ID4gPj4+IEZZSSBTb21lIHBhcnRzIGhh
cyBiZWVuIGJhY2twb3J0ZWQsIGUuZy46Cj4gPiA+Pj4gZDQ3MTUxYjc5ZTMyMiAoIm5mczogZXhw
b3NlIC9wcm9jL25ldC9zdW5ycGMvbmZzIGluIG5ldCBuYW1lc3BhY2VzIikKPiA+ID4+PiB0byBh
bGwgc3RhYmxlL0xUUzogNS40LjI3NiwgNS4xMC4yMTcsIDUuMTUuMTU5LCA2LjEuOTEsIDYuNi4z
MS4KPiAKPiA+ID4+PiBCdXQgbW9zdCBvZiB0aGF0IGlzIG5vdCB5ZXQgKGJ1dCBwbGFubmVkIHRv
IGJlIGJhY2twb3J0ZWQpLCBlLmcuCj4gPiA+Pj4gOTM0ODNhYzVmZWM2MiAoIm5mc2Q6IGV4cG9z
ZSAvcHJvYy9uZXQvc3VucnBjL25mc2QgaW4gbmV0IG5hbWVzcGFjZXMiKQo+ID4gPj4+IHNlZSBD
aHVjaydzIHBhdGNoc2V0IGZvciA2LjYKPiA+ID4+PiBodHRwczovL2xvcmUua2VybmVsLm9yZy9s
aW51eC1uZnMvMjAyNDA4MTIyMjM2MDQuMzI1OTItMS1jZWxAa2VybmVsLm9yZy8KPiAKPiA+ID4+
PiBPbmNlIGFsbCBrZXJuZWxzIHVwIHRvIDUuNCBmaXhlZCB3ZSBzaG91bGQgdXBkYXRlIHRoZSB2
ZXJzaW9uLgo+IAo+ID4gPj4+IEtpbmQgcmVnYXJkcywKPiA+ID4+PiBQZXRyCj4gCj4gPiA+Pj4g
dGVzdGNhc2VzL25ldHdvcmsvbmZzL25mc3N0YXQwMS9uZnNzdGF0MDEuc2ggfCA5ICsrKysrKysr
LQo+ID4gPj4+IDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkK
PiAKPiA+ID4+PiBkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL25ldHdvcmsvbmZzL25mc3N0YXQwMS9u
ZnNzdGF0MDEuc2ggYi90ZXN0Y2FzZXMvbmV0d29yay9uZnMvbmZzc3RhdDAxL25mc3N0YXQwMS5z
aAo+ID4gPj4+IGluZGV4IGMyODU2ZWZmMWYuLjFiZWVjYmVjNDMgMTAwNzU1Cj4gPiA+Pj4gLS0t
IGEvdGVzdGNhc2VzL25ldHdvcmsvbmZzL25mc3N0YXQwMS9uZnNzdGF0MDEuc2gKPiA+ID4+PiAr
KysgYi90ZXN0Y2FzZXMvbmV0d29yay9uZnMvbmZzc3RhdDAxL25mc3N0YXQwMS5zaAo+ID4gPj4+
IEBAIC0xNSw3ICsxNSwxNCBAQCBnZXRfY2FsbHMoKQo+ID4gPj4+IGxvY2FsIGNhbGxzIG9wdAo+
IAo+ID4gPj4+IFsgIiRuYW1lIiA9ICJycGMiIF0gJiYgb3B0PSJyIiB8fCBvcHQ9Im4iCj4gPiA+
Pj4gLSAhIHRzdF9uZXRfdXNlX25ldG5zICYmIFsgIiRuZnNfZiIgIT0gIm5mcyIgXSAmJiB0eXBl
PSJyaG9zdCIKPiA+ID4+PiArCj4gPiA+Pj4gKyBpZiB0c3RfbmV0X3VzZV9uZXRuczsgdGhlbgo+
ID4gPj4+ICsgIyAiTWFrZSBuZnMgc3RhdHMgdmlzaWJsZSBpbiBuZXR3b3JrIE5TIiBwYXRjaGV0
Cj4gPiA+Pj4gKyAjIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LW5mcy9jb3Zlci4xNzA4
MDI2OTMxLmdpdC5qb3NlZkB0b3hpY3BhbmRhLmNvbS8KPiA+ID4+PiArIHRzdF9rdmNtcCAtZ2Ug
IjYuOSIgJiYgWyAiJG5mc19mIiA9ICJuZnMiIF0gJiYgdHlwZT0icmhvc3QiCj4gCj4gPiA+PiBI
ZWxsbyBQZXRyLQo+IAo+ID4gPj4gTXkgY29uY2VybiB3aXRoIHRoaXMgZml4IGlzIGl0IHRhcmdl
dHMgdjYuOSBzcGVjaWZpY2FsbHksIHlldCB3ZQo+ID4gPj4ga25vdyB0aGVzZSBmaXhlcyB3aWxs
IGFwcGVhciBpbiBMVFMvc3RhYmxlIGtlcm5lbHMgYXMgd2VsbC4KPiAKPiA+ID4gR3JlYXQhIEkg
c2VlIHlvdSBhbHJlYWR5IGZpeGVkIHVwIHRvIDUuMTUuIEkgc3VwcG9zZSB0aGUgY29kZSBpcyBy
ZWFsbHkKPiA+ID4gYmFja3BvcnRhYmxlIHRvIHRoZSBvdGhlciBzdGlsbCBhY3RpdmUgYnJhbmNo
ZXMgKDUuMTAsIDUuNCwgNC4xOSkuCj4gCj4gPiBJIHBsYW4gdG8gd29yayBvbiBiYWNrcG9ydGlu
ZyB0byB2NS4xMCBuZXh0IHdlZWsuCj4gCj4gPiBJJ3ZlIGJlZW4gYXNrZWQgdG8gbG9vayBhdCB2
NS40LCBidXQgSSdtIG5vdCBzdXJlIGhvdyBkaWZmaWN1bHQKPiA+IHRoYXQgd2lsbCBiZSBiZWNh
dXNlIGl0J3MgbWlzc2luZyBhIGxvdCBvZiBORlNEIHBhdGNoZXMuIEkgd2lsbAo+ID4gbG9vayBp
bnRvIHRoYXQgaW4gYSBjb3VwbGUgb2Ygd2Vla3MuCj4gCj4gPiBJJ20gdmVyeSBsaWtlbHkgdG8g
cHVudCBvbiB2NC4xOSwgdGhvdWdoIE9yYWNsZSdzIHN0YWJsZSBiYWNrcG9ydAo+ID4gdGVhbSBt
aWdodCB0cnkgdG8gdGFja2xlIGl0IGF0IHNvbWUgcG9pbnQuIChwdW4gaW50ZW5kZWQpCj4gCj4g
VGhhbmtzIGEgbG90IGZvciBpbmZvLCB3ZSdsbCBzZWUgd2hhdCB5b3UgLyB5b3VyIE9yYWNsZSBi
YWNrcG9ydCB0ZWFtIHdpbGwKPiBtYW5hZ2UgaW4gdGhlIGVuZC4KPiAKPiA+ID4gV2UgZGlzY3Vz
c2VkIGluIHYxIGhvdyB0byBmaXggdGVzdHMuICBOZWlsIHN1Z2dlc3RlZCB0byBmaXggdGhlIHRl
c3QgdGhlIHdheSBzbwo+ID4gPiB0aGF0IGl0IHdvcmtzIG9uIGFsbCBrZXJuZWxzLiBBcyBJIG5v
dGUgWzFdCj4gCj4gPiA+IDEpIGVpdGhlciB3ZSBnaXZlIHVwIG9uIGNoZWNraW5nIHRoZSBuZXcg
ZnVuY3Rpb25hbGl0eSBzdGlsbCB3b3JrcyAoaWYgd2UKPiA+ID4gZmFsbGJhY2sgdG8gb2xkIGJl
aGF2aW9yKQo+ID4gPiAyKSBvciB3ZSBuZWVkIHRvIHNwZWNpZnkgZnJvbSB3aGljaCBrZXJuZWwg
d2UgZXhwZWN0IG5ldyBmdW5jdGlvbmFsaXR5Cj4gPiA+IChzbyBmYXIgaXQncyA1LjE1LCBJIHN1
cHBvc2UgaXQgd2lsbCBiZSBvbGRlcikuCj4gCj4gPiA+IEkgd291bGQgcHJlZmVyIDIpIHRvIGhh
dmUgbmV3IGZ1bmN0aW9uYWxpdHkgYWx3YXlzIHRlc3RlZC4KPiA+ID4gT3IgYW0gSSBtaXNzaW5n
IHNvbWV0aGluZyBvYnZpb3VzPwo+IAo+ID4gSSBkb24ndCBxdWl0ZSB1bmRlcnN0YW5kIHRoZSBx
dWVzdGlvbi4KPiAKPiA+IFRoZSAib2xkIGZ1bmN0aW9uYWxpdHkiIG9mIHJlcG9ydGluZyB0aGVz
ZSBzdGF0aXN0aWNzIGdsb2JhbGx5Cj4gPiBpcyBicm9rZW4sIGJ1dCB3ZSdyZSBzdHVjayB3aXRo
IGl0IGluIHRoZSBvbGRlciBrZXJuZWxzLiBJIGd1ZXNzCj4gPiB5b3UgbWlnaHQgd2FudCB0byBj
b25maXJtIHRoYXQsIGZvciBhIGdpdmVuIHJlY2VudCBrZXJuZWwKPiA+IHJlbGVhc2UsIHRoZSBz
dGF0cyBhcmUgYWN0dWFsbHkgcGVyLW5hbWVzcGFjZSAtLSB0aGF0J3Mgd2hhdCB3ZQo+ID4gZXhw
ZWN0IGluIGZpeGVkIGtlcm5lbHMuIElzIHRoYXQgd2hhdCB5b3UgbWVhbj8KPiAKPiBZZXMuIEkn
bSBqdXN0IHRyeWluZyB0byBzYXkgdGhhdCBOZWlsJ3MgcHJvcG9zYWwgIndvcmsgZXZlcnl3aGVy
ZSB3aXRob3V0Cj4gY2hlY2tpbmcga2VybmVsIHZlcnNpb24iIHdpbGwgbm90IHdvcmsuIEkgd291
bGQgbGlrZSBuZXh0IHdlZWssIGFmdGVyIHlvdSBzZW5kCj4gNS4xMCBwYXRjaGVzIHRvIGV4cGVj
dCBhbnl0aGluZyA+PSA1LjEwIHdpbGwgaGF2ZSBuZXcgZnVuY3Rpb25hbGl0eQo+IGFuZCB1cGRh
dGUga2VybmVsIHZlcnNpb24gaWYgbW9yZSBnZXRzIGJhY2twb3J0ZWQuCgpJIHdhbnRlZCB0byBi
ZSBzdXJlIHlvdSB3ZXJlIGF3YXJlIG9mIE5laWwncyBzdWdnZXN0aW9uLCBhbmQgaXQKc291bmRz
IGxpa2UgaXQgaXNuJ3Qgd29ya2FibGUgZm9yIHlvdS4gU28sIGZhaXIgZW5vdWdoLiBJIHdpbGwg
Z2V0CnRvIHdvcmsgb24gdjUuMTAueSA7LSkKCgo+IEtpbmQgcmVnYXJkcywKPiBQZXRyCj4gCj4g
PiA+IEtpbmQgcmVnYXJkcywKPiA+ID4gUGV0cgo+IAo+ID4gPiBbMV0gaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvbGludXgtbmZzLzE3MjM2NzM4NzU0OS42MDYyLjcwNzgwMzI5ODM2NDQ1ODY0NjJA
bm9ibGUubmVpbC5icm93bi5uYW1lLwo+IAo+ID4gPj4gTmVpbCBCcm93biBzdWdnZXN0ZWQgYW4g
YWx0ZXJuYXRpdmUgYXBwcm9hY2ggdGhhdCBtaWdodCBub3QgZGVwZW5kCj4gPiA+PiBvbiBrbm93
aW5nIHRoZSBzcGVjaWZpYyBrZXJuZWwgdmVyc2lvbjoKPiAKPiA+ID4+IGh0dHBzOi8vbG9yZS5r
ZXJuZWwub3JnL2xpbnV4LW5mcy8xNzIwNzgyODM5MzQuMTU0NzEuMTMzNzcwNDgxNjY3MDc2OTM2
OTJAbm9ibGUubmVpbC5icm93bi5uYW1lLwo+IAo+ID4gPj4gSFRICj4gCj4gCj4gPiA+Pj4gKyBl
bHNlCj4gPiA+Pj4gKyBbICIkbmZzX2YiICE9ICJuZnMiIF0gJiYgdHlwZT0icmhvc3QiCj4gPiA+
Pj4gKyBmaQo+IAo+ID4gPj4+IGlmIFsgIiR0eXBlIiA9ICJsaG9zdCIgXTsgdGhlbgo+ID4gPj4+
IGNhbGxzPSIkKGdyZXAgJG5hbWUgL3Byb2MvbmV0L3JwYy8kbmZzX2YgfCBjdXQgLWQnICcgLWYk
ZmllbGQpIgo+ID4gPj4+IC0tIAo+ID4gPj4+IDIuNDUuMgoKLS0gCkNodWNrIExldmVyCgotLSAK
TWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
