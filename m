Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60C2DC021A0
	for <ltp@archiver.kernel.org>; Mon, 17 Feb 2025 09:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1739785870; h=message-id :
 date : to : references : in-reply-to : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=pM3rVMCZGWr/YBD6Q7iIOpqA9nPw1Ex1yCI3VtioloU=;
 b=jOFk1Y7841SnRd9tpWT5QHpYsHVaPsnZrEsKghakb5jaiEWCDF9BVxP2jmu8txbQNnSAC
 SmVGeduQPd8y7UWQU19q5sNNc9BwxE3LU2XpgscFllZHcNSBQu3Yw2Y/P6KiVrIuLuu+nay
 jgPucAhDdI/co0CvALJdmXX8Pe0HUgw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D59A03C9BC0
	for <ltp@archiver.kernel.org>; Mon, 17 Feb 2025 10:51:10 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8708B3C7A94
 for <ltp@lists.linux.it>; Mon, 17 Feb 2025 10:50:49 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=oracle.com (client-ip=205.220.177.32;
 helo=mx0b-00069f02.pphosted.com; envelope-from=harshvardhan.j.jha@oracle.com;
 receiver=lists.linux.it)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 553576013BC
 for <ltp@lists.linux.it>; Mon, 17 Feb 2025 10:50:47 +0100 (CET)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51H6tbO3026610;
 Mon, 17 Feb 2025 09:50:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=P+QUsd44hfqtBkuZMrCvuu0JQSQg5mSdRmPovuWFUmU=; b=
 PShTcq/Ba5cJ4ZhZvczPxuXdxeEpMTrEo9qc0adwPYZhLM23wAacPFxLbeSR+AWl
 3RQIECGQBqYNAyM3qXSSi4XYAWPWOe+4my4KSJlUuV6dwzpgkTJS7V0B1orZZOMd
 CFXNftv8psLHiRO+SR7iwzSdhf7XIGRjnevzuy3f4BoVVUcpBlWPz1M1MOWAIL0X
 uj3Ussn4OKQVphMhfVp5n9nWMSsisPWzPyZfhnS1fJP5H/13cjYGniHowso3W2Ld
 b1wPqupyFGgUpeVriCjGrSWeTwKEFEONvKrJWJWVDtrxJQ1QYAV/dUCo1lzsLmfN
 d+UrUdviejS3mNDJrc2D1g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44tjhsbvmv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Feb 2025 09:50:45 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 51H9Kteu038544; Mon, 17 Feb 2025 09:50:44 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 44thc7q6q5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Feb 2025 09:50:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oMg7mfCIVvoWwkinB8Oh2uc3dMSug5OGRL66FG0x5Mo5VpxuoO4r+4dd40mV4b6tnR6shMvWZaWhXYV7elvo0SEF6g9OVf3Cp2E+M9UCWjtxaam/0nIubTbZr43PEaRi+BoQC22ZKbWp8Are6RHsQ2K/YjtRNzP6yN8cpVBtM17Wq5f908mOEezXTd67ggz0zzBO+NI1JZE4Hsk/sBWpMLpWj5P3g/nlXHIpRn8jNEe0uEQ8caoX7lgLcGjskcL8629eAGLEEIUKztrX8XsvG1yxjVLLp9osBmUrabWNFYwnaMWRTLUqOwf7MEJgbzLc5c960vC6LGwaJAYsq4W5cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P+QUsd44hfqtBkuZMrCvuu0JQSQg5mSdRmPovuWFUmU=;
 b=xbCMDhuky9Xn9nx6PWwRNssHVicRxL4uo3cqGFcj2BMr25RFJFf2m/1un5FcWUZ4cEejAO38Ek9Tem0CzdDZrnJvNX28gFGaNfoz9+ncJQ+8wdFDk7WVJwecEqUwDReqG8XI+gnm4wHWRcqRmIXLzs58sHWd7dBikeaMtWIgqUpTuXd4XBhyYy0uVKR/pFQ0kN9jm+t8kQ3q2Gx96g1OpElTeRbCw0cIr6xwlTPeepItY3omtjClC8Ubj/fZ6sJjMPFZYIdHWuo0+d60OP+F5DonVSvzRDjtOpLC0cUj7o0T/4yT3hsKpeuihMJ0KB6eQjNXueouhFl7XVb7oFcBpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P+QUsd44hfqtBkuZMrCvuu0JQSQg5mSdRmPovuWFUmU=;
 b=MFy+DYT8DvA7ANa3xSszaPzO+J51m6xG4XXC18Ob6Nfr/vZ+YVtZVFjgrSkaLde0DTuP0LMW8EMhVo+HSoLbl3qhaht50Y/i7YEcQ8zjPLlGdiA7Z9wvIn4CJU3fJpDf9MwTyJlPVvF/s20b6/u5dFHs9ypCJ/6WkoAYoRQJPsE=
Received: from PH7PR10MB6505.namprd10.prod.outlook.com (2603:10b6:510:200::11)
 by MN0PR10MB5960.namprd10.prod.outlook.com (2603:10b6:208:3cc::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Mon, 17 Feb
 2025 09:50:42 +0000
Received: from PH7PR10MB6505.namprd10.prod.outlook.com
 ([fe80::83d9:1bf1:52cf:df54]) by PH7PR10MB6505.namprd10.prod.outlook.com
 ([fe80::83d9:1bf1:52cf:df54%3]) with mapi id 15.20.8445.013; Mon, 17 Feb 2025
 09:50:42 +0000
Message-ID: <5feb6b6b-3f69-46a6-a7ae-b02a81df2953@oracle.com>
Date: Mon, 17 Feb 2025 15:20:36 +0530
User-Agent: Mozilla Thunderbird
To: Li Wang <liwang@redhat.com>, Jin Guojie <guojie.jin@gmail.com>
References: <6b486134-632b-42d7-bc01-b8f6905ee7ca.jinguojie.jgj@alibaba-inc.com>
 <CA+B+MYQd1_URO66whTCnVd7Kd7EwNPvBrnE-eQQEvTqTLXGYTg@mail.gmail.com>
 <CAEemH2eroaD4es23EdOWNmaD+NL-2HKffPieMgJg06R3NENbAg@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAEemH2eroaD4es23EdOWNmaD+NL-2HKffPieMgJg06R3NENbAg@mail.gmail.com>
X-ClientProxiedBy: SI1PR02CA0048.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::11) To PH7PR10MB6505.namprd10.prod.outlook.com
 (2603:10b6:510:200::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR10MB6505:EE_|MN0PR10MB5960:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e3eabb2-bc45-4061-b2ae-08dd4f388a9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ekgxaVc4TUJxWVptN0piNHViUkUrUjgzeHB1ajM5eCtOdHBjVmU3dzJrNnA1?=
 =?utf-8?B?U28vcUxRaTNKSlc4czg5THFra0JWUktjT2NxZlZNbStPWmtMMk1UOFdKSnly?=
 =?utf-8?B?ZFNta3VSaCsvTHA0VUEvRmljdWN6eDRKNm5rMEpCbFlsZHNWUm15OXAxQ0lS?=
 =?utf-8?B?bUk1Z3lPQ0N6ZksrTElHVUN2K1F2ZklEenhFNUpmU1oya1Q4clBOaXpuZ0Fy?=
 =?utf-8?B?MWlMMUdNT3p0aUJFTkhuc1NSQm05Y0prSXRtQU1TYTRacUZsdXhMZ3FLQ3kv?=
 =?utf-8?B?ckRYRUJYbTUvTEhoallQODcwbndIN3pLMXJmYUxjL2hRb0pScmp6U0V5NDZP?=
 =?utf-8?B?SUxuaWFUK2Yyb3VvZGpSa3RBNENrOS9Wak1YYjEzZzJidExpM29TWXlxNUZE?=
 =?utf-8?B?ekhxY1hoMDdmZG9jV0hmWEI4eU5PQXNNWUVXdEptSlh6NmhUelUxeGJRSWYx?=
 =?utf-8?B?cFpybnd6ZEpTVXA0QjZOY2hjbkwzWXVkQVBQK295NWFlY200RXFwVlY0UDE5?=
 =?utf-8?B?SCs3VmhIbmVpTWdBN0JOOGhjZ2tVbGJmekpFNkoycllOcktOTEljcDJwQlJ3?=
 =?utf-8?B?U0V3UHFKQll2ZU5tVzNyMDc5Y3VweEZKZUQrVzR1RWh3K1JQaytKVTJGdE1v?=
 =?utf-8?B?YWtEWkpKSEdIanlycWcrbGVsZTRjRW1PT1FNZUs2ZWt3V3RSdlMxUjBtSThW?=
 =?utf-8?B?TW0vVndUVzZjRDRwOVNIMGxGYVhwKys5SGwxNU1KK0YxbFZHWGlLMVJQL2Nn?=
 =?utf-8?B?eFM1ZDZ5T2Z1V2hqMjZSZGs1dXRVMGxFVW8vbUp6V1MxaStlUjVrLzQyNk0v?=
 =?utf-8?B?RGQyY05UWnRSRXV6QzVWNG5nWEZkTTJqL1grR0NqRm53YWcvTjVtRFNNTnJy?=
 =?utf-8?B?MGVrMjlKZFkzVWVDNzdVd1ZQMnRpTkJnUnVCL0Q1VnJuQzIwM2NUTDA1Qk42?=
 =?utf-8?B?bHN2cFVEYTNacEhPZHpGZitJTGZSZGJPQUhGK3BRR1hYU1FhRkdBTWdKam1G?=
 =?utf-8?B?SHF3dVZuZW8xUzVtR0xvaW5DWkdVOWdKcU9LTnNkYTRCUCtNTW1md3Robzgr?=
 =?utf-8?B?L08wcHdya09CMEZjd05xYTBQNjRHN042eWd3cVNwbC9Jc0ZIOTM0dUNDYXk3?=
 =?utf-8?B?TGJNck9sbzFjaFlmY3N5cEJqb3c2VE1YdDFER2VLdUc4YjhKQlFKL1k2cXJR?=
 =?utf-8?B?Zy9IME9WU0EzNmk1OXNUNE1BTGFrblo5QkNkSDNHZ0FoanR2QXNKSHhtTUpm?=
 =?utf-8?B?RG9kQ0VMbzdHVExDNEVvbnJGTTcxVWJwdytER3hhNGYwK29TS2lBTUNBb0VT?=
 =?utf-8?B?RnU3bG0rSWVQRzB6VXlOQTdNakJjNldOMTdUL2xQWjg3dXlxYTNFWDJwT2g3?=
 =?utf-8?B?eEcxVG5sRjNkOXdiWUQ3dGUxekY5UUREa0kwbjFPN0c1RmtwSy9pSFVoc21P?=
 =?utf-8?B?RHNJaG5Wbk5IU21lMno4RUZQRktEQzRHT1E4Q3pzSjRwdkQza2dHVkg5VWFj?=
 =?utf-8?B?c2JYckNjK3B4M2RSczkzcmZLM1ZYb3lSNVBiRk1CelNVU1R6VURXN1FUM1RH?=
 =?utf-8?B?djZVci9aRldXVVNwN2o0QTN2VVpnU1FzU2ZVK2lGOVRjWis1QUthcG1yTnBQ?=
 =?utf-8?B?WHFnRno5NnloMVBYMlNzdkJHNFhQM0I1bzNwQnlVMElZU2hKSXR1ZEZ3MUpW?=
 =?utf-8?B?dVFGNFFyRVViWGJiTFNacHcrTFVJaEpGeGs2U040U251NEY0dDVmR1hzTlBC?=
 =?utf-8?B?RUcvbU56WmZlTFREMk9oT2xwdjJ2YUlzRU1hbEtLbUtiUU5uNy9vTThYRlgr?=
 =?utf-8?B?R3A0b1cxMGpHQ1hGZFhXeFJFM1c3cGRqVlNYN3JlbGI3dm4vUDBsNE1adWxS?=
 =?utf-8?Q?U8HMvYIFbf5d/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR10MB6505.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cTlxRjh6aTNsOW9hOFA1M05IalNXd2t6eGV4U1pXZUNPTFRud080bDgwT0di?=
 =?utf-8?B?cGc3Y3RzVXovem0xOVhxeld2eGtjUDNFQ2xUY2ZlU1o3M2hkcHlESzBod1Fi?=
 =?utf-8?B?YWF0d2Z4ejRKdGZRZm9hSGZSbHJvdWwwQmRpcUd0dHRxTFI0N0JhSXpxd2gx?=
 =?utf-8?B?SHdHWnV3TDhKbEdqbW5hV3NMUjBmUVFteno4ZW5rd3NydHRKaUhpcDVKRGNP?=
 =?utf-8?B?MDdhMjJhcERaMk5wQncyR1dPSEZUd2tSYnlXblVnVHFwK3dHd1hvN3AwTFlo?=
 =?utf-8?B?akRCbWxheldFR25PWWQwQmVGZHF5Mk5ib2dRdWVYTFY2VXozWnAvV29KVXRu?=
 =?utf-8?B?YzY2MGpSOGdEd0tUdFNEb2RVR1hidGZVbklOY2dlOWxJQVBSbzU4ZWkzSGpu?=
 =?utf-8?B?ejZiQTRqeW5aZWxVcGYycEFpZG9HSXFwWDg3QzVybjY0dG91bHBtWmR2SGh2?=
 =?utf-8?B?QXB6VytsUnoyUGZBK0wwaEVLTCtNeFUwMmhHRm1uVjR0WXpoRE1BNGhwVUNM?=
 =?utf-8?B?OGtlaWp6MWNHZWEyNnNqbG5LWUdJZ3VOQjVGcXB1dkNqRWRjbys2YldEWVVn?=
 =?utf-8?B?cjRNNElrV1d4VnpKWWVsWHFqVmUzNlpYVk9UMUxPUFF4Q1VRM2lSdnZnUUJq?=
 =?utf-8?B?eG84Vk0zKzh4Ym1PN09MdEgvUEtPT1J4S2o0R1I1THR3YU5ITnVPMUxIRUtk?=
 =?utf-8?B?dXdua2htSkhMb1ZzeXZOWG5yTkVFYWxTN2hDOUFwcThPOVZOYlhGaDYxYlZJ?=
 =?utf-8?B?cDBHTDFTUEJYM2Fjajh2dDE0TVJPNHk5Q05rS3VRSFFqdzRFaW1hRUxraUds?=
 =?utf-8?B?T05tNnVFU2Njd1l2VTJueFdLU0FESnB0UXVSNWdXYmNLMlFHUE9nKy9JaFFJ?=
 =?utf-8?B?WDhLaVZEWWl1SXlBdjZkd0pCU2JTL3JIQXNEdTlTNUwxSy9paHBaQkw1WDhR?=
 =?utf-8?B?Sk54cVhwR2NtMFJCSWdjSzIxeVlEaE1zOW5DelYxdzVUSHZJK2t4R2daR1Vq?=
 =?utf-8?B?SnF2UUsrRUgwMVA4Q3pkc3NzemtJWCs5c0QzMzRjaVQ0am5FYVZHR0pDQWZx?=
 =?utf-8?B?blhqSkwrUHlkVlplNFRYbER2b2czV0lvNGI3M0F6TTFRWW5UUCs5Y1BEbWcy?=
 =?utf-8?B?TSt5TGZDWU1HbjFVT0EvbXFTR2c2SkF6ZGIvU2gxMkM2dzZLamVSaG03dGpn?=
 =?utf-8?B?SDZNdzJ1RnBtZ1F0UzRRamd4aElCY3haT0tlR0hRcmpyNm9nT3FBVDg5MVdG?=
 =?utf-8?B?MTlNQng1VTFvWU42elpMWlJPcUFSU0tjLzhHSmtwSkYyK3JOUG5FR2FFdkdU?=
 =?utf-8?B?Mm5MUXJ6allqY2llT1BGSkN4SDN4RitjcENZdDlJZ3pBU2ZLanlWQ25NQWhM?=
 =?utf-8?B?Qm03aXgyL0FHL2ZHS0dqNkR6S3hoL0RJZVk3UHpRRExQSHpUa2U4NkN5Wmpr?=
 =?utf-8?B?Y0tMYlNXK2pGT3Z1Ui91d0pNNzV5cEVNK1JnUS96VU5ISU0xN3dIbUx0bkFI?=
 =?utf-8?B?U2w5UytNR1ZQajc3UzFrRlJpU0JuU3d2WVZMUUwxbkNPVlRVSkZCc1N3RXI1?=
 =?utf-8?B?YTJvcVUxN1hNWXZ6WGx0OVAyZjRSbDBJK0IxUCszMkMrOFBLZnAyTWxhUjUz?=
 =?utf-8?B?N0xNbERRcnVHeHpnZW1xdjFmV3Y1UmIyL3c3SkNvdUQ1SHZBeWhWQ2RyK2Rk?=
 =?utf-8?B?Z0VVZHozc0g4bnFZZE5VTElHcGJKblhPWUVUT1ljL1V6YlhHSXBjeUFQWnlp?=
 =?utf-8?B?UkYycWNwcVR0em81eGVCMXg5cVdKNnlBUnVXZHVZUjV1bjlXdEl1TlFoUzEz?=
 =?utf-8?B?MUpLOXdxUGQ1R0RFMGFTUTlHa1FqUlhGREhKQmxGRTdScE85YUY5UmxkM2Jy?=
 =?utf-8?B?ZGluNGFlYXcyVGhGVXBzam5oeElkL3ZpRTVJMCs3TU1oQ3I0V0d6aVprWTBs?=
 =?utf-8?B?eWVxQzlqWWJ1WG1UR1VkTTQ4bCtudEliOUs1Q05FNHJXSnZzMTZ1WmlGQVRs?=
 =?utf-8?B?OWt1dG9HZVBLNnpJcWQvVHpYb1lYTEZZcnRaUEEzK3pDbU9UMlBCb0haNmQz?=
 =?utf-8?B?d05TVmdaQkpTclVhQ3FxQUtCNXY2SGhORENtcGVBeDZSVG05MllsTU1IVWxF?=
 =?utf-8?B?OXVGVjJDTFZlaVBCbDlVR3NEUStob1ZqYW0rZ2dyb2x5RVAwN0tIaGU4K0pi?=
 =?utf-8?B?SEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: QitYjTQbnAtB5QX6ow1Q/u0bwyE+KkHZ/E/mtOs2oI8njz8Sk6v0S147wppjwZiLcoArWHC3l4vA+qr5jo86qsiXVu0Fb0PMYbDqSRlfUA7G5VNR8HfBgIoVCcDPJhLTGnLH1vSXFvzCx2ogLnq+M3tOFY96lkDfJn2Y6HVgHeOqa6ZakjfbT+mhieAy50VQVIC1B0D9TnY8B86folu9dmQnab/dVcG7qLq2G+ZYzpoBW30F4+3CjnVUvAaT8QX+D1AF2f4tul1bLX28qDXBMgeOuSS0S0Az5xhyuM0fVcf5g9ApYXfyZwkf5sEx4yLRoEIHBZTvFsOA3oPl5aK/Rs8qno7mL8kv8xKmHgn7QY8Dt651TE0Xj4UwF9iYqXIJa5R9Zregjt2VPNHECSFIJz+WGV/5Sl5Wg0EOjI2D2jIX8TUN743HxvlldYcXVV5yNdtgevHm3GPBx/xDpemSkdc+UZnRQt7HIvvX8TtAnn/TXIKADtoeVew0McRWVNbpIzSrKsXzyCdEhsh021V52d4hhH5I/EdIvAOCD4JL+QOzEc7/aMkj8GYpzLfoOBjO46JPr4JvSGPoPAjGp86Jw6CA7G8eIns4TO0ZOhVge3Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e3eabb2-bc45-4061-b2ae-08dd4f388a9d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR10MB6505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 09:50:42.2771 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: difDwE75BFEzjTVvWI/XRaOh5d3pWyjViGHYyI+/aS7GmhBtGAFloJuW3Mf3cWiFZQimoZiF8+dYU0+Ef+BwYhAbOd/B8x7t5dzuIIZELNc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB5960
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-17_04,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxscore=0 adultscore=0
 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502170086
X-Proofpoint-GUID: aLlt0YJM7I_Vw4XnZmVtwN9MxDKU2iLI
X-Proofpoint-ORIG-GUID: aLlt0YJM7I_Vw4XnZmVtwN9MxDKU2iLI
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] memcg/memcontrol04: Fix judgment for
 recursive_protection
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
Cc: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Ck9uIDE3LzAyLzI1IDEwOjIxIEFNLCBMaSBXYW5nIHdyb3RlOgo+IEhpIEd1b2ppZSwKPgo+IEkg
aGVscGVkIHJlYmFzZSB0aGUgcGF0Y2ggdG8gdGhlIGxhdGVzdCBhbmQgcHVzaGVkIGl0wqB3aXRo
IGFuIGltcHJvdmVkCj4gZGVzY3JpcHRpb24sIHRoYW5rcyBmb3IgeW91IHdvcmshCgoKSGkgTGks
ClVzaW5nIHRoZSBsYXRlc3QgTFRQIHZlcnNpb24gbWFrZXMgdGhlIHByZXZpb3VzIHRlc3QgZmFp
bHVyZXMgZGlzYXBwZWFyCm9uIDYuMTQga2VybmVsLgoKVGhhbmtzICYgUmVnYXJkcywKSGFyc2h2
YXJkaGFuCgoKPgo+IC0tIAo+IFJlZ2FyZHMsCj4gTGkgV2FuZwoKLS0gCk1haWxpbmcgbGlzdCBp
bmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
