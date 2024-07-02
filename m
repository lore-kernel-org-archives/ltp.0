Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA51DC3065C
	for <ltp@archiver.kernel.org>; Tue,  2 Jul 2024 22:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1719960974; h=message-id :
 date : to : references : in-reply-to : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=VPbVw2tMoQaN06K3mw3Jnw5Jb9lZFmegCblPJWyE/YA=;
 b=SVXkYaexXOoxCuQkzO3G1TgI3w03xIriwz2zNS9jExuwHd4XwRpWy4jvSvggVPc9gKSHF
 Omjmdrpd7soJiuVAZijkPwJ32Wpy0XPhwtguaxsKJ4y19zPKK4L97ZktQf0ZuaPOVqMvFgJ
 WBESwNmGXWSqEkfTteWjEm9CqlO9NKs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9B66E3D3EEE
	for <ltp@archiver.kernel.org>; Wed,  3 Jul 2024 00:56:14 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5B56D3C221F
 for <ltp@lists.linux.it>; Wed,  3 Jul 2024 00:55:50 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=oracle.com (client-ip=205.220.177.32;
 helo=mx0b-00069f02.pphosted.com; envelope-from=calum.mackay@oracle.com;
 receiver=lists.linux.it)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 3F9FD600F91
 for <ltp@lists.linux.it>; Wed,  3 Jul 2024 00:55:47 +0200 (CEST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 462L0707025934;
 Tue, 2 Jul 2024 22:55:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:cc:subject:to:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=yhxFosrGGrTjej80RrEYxvdA4NbAGB+BZ0qAEBiifvM=; b=
 ld7eY4OYYeHRxulgZu8Ubh/DY6aNIEXtfgPwKuNWDmKYkvkobANTbRhsBHP51kas
 HW680hoWrOStfOLKRgZ9Cpan1hZQYlbkKwqugUZkXXdG+q5pYCk8fCVoW5AwF8yv
 00XpwxC4Lx52ti8p3EJWad0pQFqP6CvqwxTryOljbHpbfa68K9l2bIZ/OdKsi4Mw
 fYR6qxvWL+MarvzpILkz4ZmSVsco4UbPzVu1XjXs+ztyzIA0ajuoRTG/15c2Wtxx
 cpybPFl6pbWsFUBKzdEeGYAkVtsxHSBTA8t+/QSr8NCjm9VMVrkHvPgGYlYBwBJn
 b361IUpsU4Yo019VKgkqqw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 402922xybn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 02 Jul 2024 22:55:39 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 462ME2Kt010198; Tue, 2 Jul 2024 22:55:39 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4028qet231-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 02 Jul 2024 22:55:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YNR3uWXbWilpUFE8m+jsMKJv5VZKfy3C7ljrws6w9z3/ifYEbjit1I1L8JpJcCN7I6OQmPnoRU8/bnLT6CRgd7QFTLJPGJf0rDqxE2W82vWVXmqGCr4IE72+AyHXVPxC1fvC3vE+kqWBGXYoRu1SHazKyy0krW512ZUYEUkeiJgNkeO6vtuFBjnxaM/OmSdjPr80xUrRaOs7l6NC3IZIqglY2VlID64zVsIJUgC0IfQPiEB7NkP9bEBT57y+szM8R33r6m5Zj5FRAtWvNBsaNbmnl8AgfQojvb6PD/5uCjA+ktZjoilH6YkOhI8XBE/QGSfeTT0zSsrKJWe3r+WuNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yhxFosrGGrTjej80RrEYxvdA4NbAGB+BZ0qAEBiifvM=;
 b=ogHH3DSvh1gvJzWYpYnmIVqc6vglNxD5GfRKIHDieDRoBELrOp1J19GRhK/NFRLX+ghDxDc/MmqpXpLceDUOMM1jCEWh4rn80teBKPOlma1xWIVZtmOkxE8KEZcXllebuuK4zRM6j8A6JZp722A+hp5HGdf6hPp/nFeIy/110orAmSeKUIirWkOzAfO4ENmkaz+T6ovxmPPPvWejPFW/cBMf4TpVIJC4tv+zkfmgIXxgoheTUEjphSAooK6Nv2rGbVkt9jCsQOD32iWOs3Oi7j0ceLge4rlw4TQ5fcYrHyQ+/oxB+4DsyjDErRzYIjJvuIt0xWIw30pEBH1UXqvI8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yhxFosrGGrTjej80RrEYxvdA4NbAGB+BZ0qAEBiifvM=;
 b=rdWWK3F/wZdzAYV5XpSBFlbkutD8mW2Rr1FnIWDGfXQ7+qJOfpOpkBjin9Y5CaoxrywJUkycrwhH60wch19rqElwUhFjK6xc/92ALOs0GB8BIQ076cSuSQ7/qCZc2R/Fhr/wvn+6f0aFxD6E4rmez6gCksnnA4Oh+cFaR4lrUfA=
Received: from BN0PR10MB5143.namprd10.prod.outlook.com (2603:10b6:408:12c::7)
 by MW4PR10MB6297.namprd10.prod.outlook.com (2603:10b6:303:1e1::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Tue, 2 Jul
 2024 22:55:36 +0000
Received: from BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::783:503f:ea07:74c7]) by BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::783:503f:ea07:74c7%4]) with mapi id 15.20.7719.029; Tue, 2 Jul 2024
 22:55:36 +0000
Message-ID: <2fc3a3fd-7433-45ba-b281-578355dca64c@oracle.com>
Date: Tue, 2 Jul 2024 23:55:32 +0100
User-Agent: Thunderbird Daily
To: Petr Vorel <pvorel@suse.cz>
References: <d4b235df-4ee5-4824-9d48-e3b3c1f1f4d1@oracle.com>
Content-Language: en-GB
Autocrypt: addr=calum.mackay@oracle.com; keydata=
 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
 smRifw1wGg==
Organization: Oracle
In-Reply-To: <d4b235df-4ee5-4824-9d48-e3b3c1f1f4d1@oracle.com>
X-ClientProxiedBy: LO4P123CA0368.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18e::13) To BN0PR10MB5143.namprd10.prod.outlook.com
 (2603:10b6:408:12c::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5143:EE_|MW4PR10MB6297:EE_
X-MS-Office365-Filtering-Correlation-Id: bad2fcc3-0854-44f6-6c44-08dc9aea162c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a29zaTlNZDBvYUp2UUpvYmlIUFVSbDNJV0hJRjAzYURJUGd6eTkrNmpWT2NH?=
 =?utf-8?B?ZmxPdzVTQUFnWlN1MmtaL3BPTFVJRXA0NkExTWM1NlhnNS83S0oyWUl1WHJL?=
 =?utf-8?B?L0xnZWx4VHZmYVpoRFVsZmRSWk9vY1Zwb2t1emIvb3dGRm5tWmVSUUQ3RWEv?=
 =?utf-8?B?S2hHaHdkTktWMnFkTWFBd3Nla3k4MnltVWlsWXJSa1hMYnlWbzF2Z281Mmw5?=
 =?utf-8?B?ZitENCtySDNsWU55bWs2QVBTamdFOEptZG4weUxsVFVROFRjczRKYmR5d215?=
 =?utf-8?B?RlBzMTlkeWJkU0dzTWxMK0QwSFk2cmhVemFEanZZTHAxYkVhNTY2dGY0Sjcv?=
 =?utf-8?B?b25oWWk4RkEvbXVPTjFmUi9XNU1EN1VzenlQaVJycENmYk5sa2VMM2Q4VTFo?=
 =?utf-8?B?amUya0ZiU2xMSWpkNG9GRFVWMUFXRkdCeXZ3dXBCUTdVT0hQaDRxWVVWRW53?=
 =?utf-8?B?TXNNenV2SUc5anoyN2tDUnBHVHdUbXJLYS9WTUZTYklCemExempBeXViZ0wr?=
 =?utf-8?B?UlZrWkpGZzVyelFYdmxkbVBJV1paMHY1RUFOMXBORUVxT0taNklyd0JURisz?=
 =?utf-8?B?NlVmajRtMEt4aWVWdWJ3N3ZWUUpnYktPYmF0Y2lCaTBrMC9qanN5SUIzMUt3?=
 =?utf-8?B?QU9kaFU4bnE4N0hxbjBYbkNobEtyTzhZb1dkQ2VsaDJxVkdiSXVQRWUwNlhZ?=
 =?utf-8?B?NnJzaGtiSWdRcmowSlZITHJnalZrYzQyRm1GR2NKTDk3MVdPU25ZVXVOdGhV?=
 =?utf-8?B?L2ZtKysxZHc1eEwzRGdBMWV3WElIaUF0NzJsa2RmZWEvQko3RVpkc2pyOXh4?=
 =?utf-8?B?eHYwOGNEejNEL0w5OFlld2FBSVRmOENCNjRoRGtlN3BkRkpBaHh0dWF3RFRY?=
 =?utf-8?B?V3BJRGpHWmd1M0ZKc2xPQ2p3N0V0RGMxZGs3VjRoSllkeW9kbFQ1QVNGUncy?=
 =?utf-8?B?QmVya2NZWWZsRGFZOHFqTDBXaVg1aHdrVmRGN29WRkNUemZiRHZydFdFcXdO?=
 =?utf-8?B?WTEyKzltOEFhZDZPVGh0di9paUlVVWJWMlRBMDEvUVpXeUlPaWY4L1NZVWNR?=
 =?utf-8?B?bTJjTmE0MndHZUlyLzcyODM0UGlKMzFaaSt6TUtwQi9BZ3BOeWkxVWVLbjhF?=
 =?utf-8?B?V05IUVpIWXBkRDI2cU9HQmVMaHB2bXVQSkNLaWxBcURUWGVHQkFFUWZYR056?=
 =?utf-8?B?S0ExNHU5YTJTU3FKU1FjNWZVOUtRYWNhM0tCYkNTdkE1dzVHbU5ad1lRS0Jt?=
 =?utf-8?B?U0NqTCtIRmJWVktkcXNGeUNtZFFQNlhib00waG41QUw3RUpOdFI0QWE5c3R3?=
 =?utf-8?B?ZUtzVlFpekZPbVJveFFrdUk0bzEwTzFSVzY1enN0emJ2c0ZEVnNpRmlpS0RH?=
 =?utf-8?B?UThhcGZIbXNkd2dHQjFETWpIQ1owbDlLeEQrQ01EdVFSOG9Rc2dFdlB6RENi?=
 =?utf-8?B?aGkrQ0x0WCtjcDJuaHltT3FVblZvWWpjR1FkSVQrL2dJb1Y0d0lpTkhZc2Zi?=
 =?utf-8?B?SUpQQXNYOE9rTWRMNm51UXRMRis5S21tN2E2aXI2TndRbXNSb0VlL1dCSXFP?=
 =?utf-8?B?Zmd1Skd0M2g5d3VjaWpsUW9Gc2xncEQ2ZTQ0a3JNRHFaTVBpQVk5eHZMQlA2?=
 =?utf-8?B?MHEwYlZJMCs4YlpKUDA2aFJWYmNNOVhKQkdId2lvOWduWUxYOTEwS0ovTFU3?=
 =?utf-8?B?bUJjd3M5TGpxWXkwWXRya3FMRTdaY3J0SmRaYndzREREN25KelFnSmhGN2F4?=
 =?utf-8?Q?4Gc35A9GTRbCmVodCg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN0PR10MB5143.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmZIcjZVYUYzMHdLVXI4b01Ub2o3cE9JUHVTekZlTStmMVR0ZkxqK0xXR1F5?=
 =?utf-8?B?elE3NTJQcXJCZ2hlQnpkcWljcWYwZnd3VEowZXdDTmYzM2RXRVZEdjZJdUQr?=
 =?utf-8?B?S2V2Wi9YOW5SVVU2ZXRYWFRUcjUxcFNWKzVMKzJ0QnY3UzgyZWtFaWswQmJw?=
 =?utf-8?B?UUZlNWpGeEtHRDBCM3NxWEwwdmN2NDdBY2hnZlN5akxudW5xejZZT3dyaER3?=
 =?utf-8?B?R3JDTTFtNVZiSzVnK1RSa2VPUC9qYmNOK2VCbGV4UmFCVEVFQWNxQldMWDZN?=
 =?utf-8?B?SFVza3VON0lkYi9ZSjJ1RklkT0R1ZnBHK042MGsyUGl6ankveGpxTmVqUkVW?=
 =?utf-8?B?VkRpNzA2eXd3b2FGTGJiMGNLQTc0Rm5YQUFNaGJDdkR0U2ErWlU4cTZ6MzY4?=
 =?utf-8?B?ckxVNGxUZ2lmUTkvdmx5UW4wZ2VTdXBIcGRtV3daeUJYQUdNakE5aDFGWXBG?=
 =?utf-8?B?bDExLzdIVDMwS2FleGhFd3FzMU9UT2h3UTcwSE5xK2k5MDRxcVVFQWRreEc2?=
 =?utf-8?B?T1JJREg3NW9mUTJkWW40QzBOdDNNOXprWlhUaCtQYWlGc0laSjBIU09CbWFL?=
 =?utf-8?B?czFQTjNOSTIrZE9CZFBoaFBIcWhEb1hndzJ2K1hQZ3JKL0hyUVcrV05MTDRn?=
 =?utf-8?B?aUdFMXNqbXgvU3RQK25BZy82dlFWN3gzcUNMR1ZsTkVUa2NBQXlXYUJ5WlVu?=
 =?utf-8?B?RGsxM0pQSm5FZ2FqSnN6eWJlQzZhZ2tDNU5vNkQ0dFc4OEk4TUorQkRHdFlJ?=
 =?utf-8?B?V2crb3ZDY0JtT3JHREpjTCtxODNaMVRNaGUwZnVzZGdUODJiNFk4cWhJMFM3?=
 =?utf-8?B?SUVUZmY2S3pWMERFT2h2amJRU0pjcEJ6YWdFbjFiMm4vdkF1ZG50NmEwWXRs?=
 =?utf-8?B?UUppSEVqb2ZXbHAwMlNXa2ljOElzNVdpb3M2RWx0WUQycmRvOFZXMlJNWnRZ?=
 =?utf-8?B?YXo5OG45Rm0xekV2WHA4K1g2WG1EQjlKKzhpWjMzSG5CS1dxcXE1cU80ejFG?=
 =?utf-8?B?MXcxUWVWR0xVeFBYY3BUcDVOZlVuOGJ4VzBOS2lTUk0wRHZIRFpwOG82L1J6?=
 =?utf-8?B?OUdGaTJlZTJCT1ljSDh0SWVwZmM5cWtlZnQ2ZGI4bzI1UmM1Y0lnK1dsNmM4?=
 =?utf-8?B?TGwwa3Z2S0dsNk5GQUxnWWxiSjVCcUhDelJDcU81Q2VQK1NlZWRxWStuVEZG?=
 =?utf-8?B?cUEvVGVvSkZVTk1ncmhXMnlXWEpPYmViaEg1aGFpbG8waVZ5MUpWRTNkamtv?=
 =?utf-8?B?T3B6TVF5dExXZU91T2tmRStuQXQrN0RFNFBpenNGVkxBZFdXek1SL0ZXaVNQ?=
 =?utf-8?B?SjFXNlVCd2srWi9nUXJFYmhlbFRRZkk0Q0NtNUVxU2txcjJOUE5oRS9ZWTVW?=
 =?utf-8?B?UjNsMVpTZEI2U0RFSXdHSXlreEFORFpucTNJTm5qbkpBb0RsSGorQ2R1UE1Y?=
 =?utf-8?B?bURLV0tVQUhidkhCdXZMNzQzMHRGMkpIVWhsc1l6VThja1dOUkZhQk5MUnJh?=
 =?utf-8?B?QUx4RlhmRzJUOHBhVThTa3NjM0ZxMW52cnhQWEhMeWRxQUMwNlA0eVhVM1ZV?=
 =?utf-8?B?ZnBEbkd2VWRpcTlXTGZuNDVoRDRTWFZrdDJra1JCRXhkN1pEQzRFdVlmMmYy?=
 =?utf-8?B?OU5PRUpNdktROWU5TU5XNlU3S1ZJSWlnWmY3bEdNdUtIZ1ppYUoycHJBcHZ3?=
 =?utf-8?B?cmpRRnlLZWJtS3lmRHFDU0FFaFVpTTZNNk1TTElnWkp6eHMxOVZKQ0lESkpM?=
 =?utf-8?B?WEZQOEJ0N3ZkdTMrYWx2R1RBVFo3OGxZOXJZOVVTdGQvU3pLT3k5ZFNzUEg4?=
 =?utf-8?B?Q09WSC9reU5aaHQrM2c2WlJEL2tmdnZxa3ZRMjNCanJ2NHF6aGJCSDUzUzIy?=
 =?utf-8?B?OEM0MFJyYno1REwxQWFWUll4MklZT0JMMTlGZzBrYk01cS9jUk9nT2pXWUFW?=
 =?utf-8?B?TWl3Nk1FZ3VwcnZaU1ZxVkp1eGttb2NhSk5jYU1iSUJLRUlTYVRSSHJFMGNZ?=
 =?utf-8?B?YzRZMlNiZ1dUdVJYUUVCbCtZS0ZGWWhBbG90WU1RdDNuRFhUdXp0d1FiQ2ZG?=
 =?utf-8?B?aXpWWXBvcXlrMXZINEE4QklTSC8reUZTSWVveTBMbHlQcFJra042UFRIVUhY?=
 =?utf-8?B?aFhyZ0dYa2gxMkJwWi85bThiWDFlaXB5ZmdSd3hVMUtXMFU2UGtZT25XaWIv?=
 =?utf-8?B?Nmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: gH/8ojPmAsaYnN0S2MZYKHaEYJTd0RnmncSnFMkmqhePI0vCYJfRFRtiDC+OBtlpMyBnF01aveQabZOQYB8jskgSG43NursPZRoCkKGtlkSYeWs1PKGDSSoIkUrGpzbgwNLyV3e2ygY0UOmbuUwjaDVk5pmctEmHjt0dlFf0BrdZMzvUNsL33jHR+9kbqMjPNXj/T8YeOPyqwEcVY/ScISf00vgEw/BSeQrbXsNnSCCHnhWAPvuhsIjXnHKWrc9EMQEqTj//P0UMQkns4zwBokYddqbHU9LeBXSsprzSuIos5uPF13wppn23W9bpW+FJJNHpbikxcl/sXbjpj7BApuU2QchNMAo8nDS8g/NGHyxmXuxdGHmEqFJXzBa4QxJxtiwYEwDjAAKmif/E2a+VAOmP/6ggSpWgiqPe2194JmhxQVVR0l9pdRg9ALARjfsrr+9Wg342Obq4GHVI3XpQfED3WyWdzEppt8OoGL/E6wJ1pyLocyXQW/fJDmbg9kjCb5q+yMQQ/+GjbPWp4bc8xZkydeZ72sOm0d4WoyMejnWG5qx/RwTZOTMEN62o85ySsrfPS/bgyxuZQ2HpvXPslcl6R1izicb1mwjGVg5sAmw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bad2fcc3-0854-44f6-6c44-08dc9aea162c
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5143.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 22:55:36.6396 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XT5NDD5NlbgBAsIKkI3YcwGSHkJoR4Meb7yzBBwfPE230/ju6k46fWOMWmyyOvFZrUYqVqXz2rDPnT1OgUJAUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6297
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-02_16,2024-07-02_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407020168
X-Proofpoint-GUID: kmiSDvgmTrREdlH4A45bstYfZr_gS_6v
X-Proofpoint-ORIG-GUID: kmiSDvgmTrREdlH4A45bstYfZr_gS_6v
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] nfsstat01: Update client RPC calls for kernel
 6.9
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
From: Calum Mackay via ltp <ltp@lists.linux.it>
Reply-To: Calum Mackay <calum.mackay@oracle.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
 NeilBrown <neilb@suse.de>, Jeff Layton <jlayton@kernel.org>,
 Sherry Yang <sherry.yang@oracle.com>, linux-stable <stable@vger.kernel.org>,
 Josef Bacik <josef@toxicpanda.com>, anna@kernel.org,
 Trond Myklebust <trondmy@hammerspace.com>,
 Calum Mackay <calum.mackay@oracle.com>, kernel-team@fb.com, ltp@lists.linux.it
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

VG8gY2xhcmlmeeKApgoKT24gMDIvMDcvMjAyNCA1OjU0IHBtLCBDYWx1bSBNYWNrYXkgd3JvdGU6
Cj4gaGkgUGV0ciwKPiAKPiBJIG5vdGljZWQgeW91ciBMVFAgcGF0Y2ggWzFdWzJdIHdoaWNoIGFk
anVzdHMgdGhlIG5mc3N0YXQwMSB0ZXN0IG9uIHY2LjkgCj4ga2VybmVscywgdG8gYWNjb3VudCBm
b3IgSm9zZWYncyBjaGFuZ2VzIFszXSwgd2hpY2ggcmVzdHJpY3QgdGhlIE5GUy9SUEMgCj4gc3Rh
dHMgcGVyLW5hbWVzcGFjZS4KPiAKPiBJIHNlZSB0aGF0IEpvc2VmJ3MgY2hhbmdlcyB3ZXJlIGJh
Y2twb3J0ZWQsIGFzIGZhciBiYWNrIGFzIGxvbmd0ZXJtIAo+IHY1LjQsCgpTb3JyeSwgdGhhdCdz
IG5vdCBxdWl0ZSBhY2N1cmF0ZS4KCkpvc2VmJ3MgTkZTIGNsaWVudCBjaGFuZ2VzIHdlcmUgYWxs
IGJhY2twb3J0ZWQgZnJvbSB2Ni45LCBhcyBmYXIgYXMgCmxvbmd0ZXJtIHY1LjQueToKCjIwNTdh
NDhkMGRkMCBzdW5ycGM6IGFkZCBhIHN0cnVjdCBycGNfc3RhdHMgYXJnIHRvIHJwY19jcmVhdGVf
YXJncwpkNDcxNTFiNzllMzIgbmZzOiBleHBvc2UgL3Byb2MvbmV0L3N1bnJwYy9uZnMgaW4gbmV0
IG5hbWVzcGFjZXMKMTU0ODAzNmVmMTIwIG5mczogbWFrZSB0aGUgcnBjX3N0YXQgcGVyIG5ldCBu
YW1lc3BhY2UKCgpPZiBKb3NlZidzIE5GUyBzZXJ2ZXIgY2hhbmdlcywgZm91ciB3ZXJlIGJhY2tw
b3J0ZWQgZnJvbSB2Ni45IHRvIHY2Ljg6Cgo0MThiOTY4N2RlY2Ugc3VucnBjOiB1c2UgdGhlIHN0
cnVjdCBuZXQgYXMgdGhlIHN2YyBwcm9jIHByaXZhdGUKZDk4NDE2Y2MyMTU0IG5mc2Q6IHJlbmFt
ZSBORlNEX05FVF8qIHRvIE5GU0RfU1RBVFNfKgo5MzQ4M2FjNWZlYzYgbmZzZDogZXhwb3NlIC9w
cm9jL25ldC9zdW5ycGMvbmZzZCBpbiBuZXQgbmFtZXNwYWNlcwo0YjE0ODg1NDExZjcgbmZzZDog
bWFrZSBhbGwgb2YgdGhlIG5mc2Qgc3RhdHMgcGVyLW5ldHdvcmsgbmFtZXNwYWNlCgphbmQgdGhl
IG90aGVycyByZW1haW5lZCBvbmx5IGluIHY2Ljk6CgphYjQyZjRkOWEyNmYgc3VucnBjOiBkb24n
dCBjaGFuZ2UgLT5zdl9zdGF0cyBpZiBpdCBkb2Vzbid0IGV4aXN0CmEyMjE0ZWQ1ODhmYiBuZnNk
OiBzdG9wIHNldHRpbmcgLT5wZ19zdGF0cyBmb3IgdW51c2VkIHN0YXRzCmYwOTQzMjM4Njc2NiBz
dW5ycGM6IHBhc3MgaW4gdGhlIHN2X3N0YXRzIHN0cnVjdCB0aHJvdWdoIHN2Y19jcmVhdGVfcG9v
bGVkCjNmNmVmMTgyZjE0NCBzdW5ycGM6IHJlbW92ZSAtPnBnX3N0YXRzIGZyb20gc3ZjX3Byb2dy
YW0KZTQxZWU0NGNjNmE0IG5mc2Q6IHJlbW92ZSBuZnNkX3N0YXRzLCBtYWtlIHRoX2NudCBhIGds
b2JhbCBjb3VudGVyCjE2ZmI5ODA4YWIyYyBuZnNkOiBtYWtlIHN2Y19zdGF0IHBlci1uZXR3b3Jr
IG5hbWVzcGFjZSBpbnN0ZWFkIG9mIGdsb2JhbAoKCgpJJ20gd29uZGVyaW5nIGlmIHRoaXMgZGlm
ZmVyZW5jZSBiZXR3ZWVuIE5GUyBjbGllbnQsIGFuZCBORlMgc2VydmVyLCAKc3RhdCBiZWhhdmlv
dXIsIGFjcm9zcyBrZXJuZWwgdmVyc2lvbnMsIG1heSBwZXJoYXBzIGNhdXNlIHNvbWUgdXNlciAK
Y29uZnVzaW9uPwoKCmNoZWVycywKY2FsdW0uCgoKCgo+IHNvIHlvdXIgY2hlY2sgZm9yIGtlcm5l
bCB2ZXJzaW9uICI2LjkiIGluIHRoZSB0ZXN0IG1heSBuZWVkIHRvIGJlIAo+IGFkanVzdGVkLCBp
ZiBMVFAgaXMgaW50ZW5kZWQgdG8gYmUgcnVuIG9uIHN0YWJsZSBrZXJuZWxzPwo+IAo+IGJlc3Qg
d2lzaGVzLAo+IGNhbHVtLgo+IAo+IAo+IFsxXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9sdHAv
MjAyNDA2MjAxMTExMjkuNTk0NDQ5LTEtcHZvcmVsQHN1c2UuY3ovCj4gWzJdIGh0dHBzOi8vcGF0
Y2h3b3JrLm96bGFicy5vcmcvcHJvamVjdC9sdHAvIAo+IHBhdGNoLzIwMjQwNjIwMTExMTI5LjU5
NDQ0OS0xLXB2b3JlbEBzdXNlLmN6Lwo+IFszXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51
eC1uZnMvIAo+IGNvdmVyLjE3MDgwMjY5MzEuZ2l0Lmpvc2VmQHRveGljcGFuZGEuY29tLwoKCgot
LSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRw
Cg==
