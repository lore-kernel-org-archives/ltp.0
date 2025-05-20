Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 621AEC3ABDD
	for <ltp@archiver.kernel.org>; Tue, 20 May 2025 15:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1747754235; h=message-id :
 date : to : references : in-reply-to : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=wyAj/yuBta4bqKMlqPJVvB6e5CtgvosGexNUf829cXY=;
 b=A6SoFX2z3oocVc8Ca0jxMcjC8r366mUPwW/vN/q8ur1J9dqMdesc03jA26KBO3ie7U8vo
 wTq1NWeLnHU6qHKtsvr+TzewIfAchc3gxOhGfCxemLh+iOLBgaQ/F6v2OCUxLWWLZlJSlQZ
 3jR6SLWHvbBstus+6Or/bOxMoRVcrkg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 908FF3CC780
	for <ltp@archiver.kernel.org>; Tue, 20 May 2025 17:17:15 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AE75B3CC6F9
 for <ltp@lists.linux.it>; Tue, 20 May 2025 17:16:53 +0200 (CEST)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 5D16B1000798
 for <ltp@lists.linux.it>; Tue, 20 May 2025 17:16:48 +0200 (CEST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54KEOMPX020007;
 Tue, 20 May 2025 15:16:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=11XcZbZmq/lNie/5i/HroIbQbW0n7vHnhVvOuZtDdAg=; b=
 TXjh8BC2CcdAh550/FghIRWmSAK4MYIV1xnjLgEuSiN0bGrt0iuTS/dT7pjH21rs
 uL4ON/ioLnwyK7taxZ0Lq89Jsg2Zxr1sZ112179sGTf4LkaPZKESMnrwV7H/25Ki
 OWzoX5GOcma79LaOGcqBF5JoE0euXRUl1pmagCODDDMy34Y2bXO4ws37VHY92n/j
 uAQDDYWlnK76IBStW+hsn3GsA4Wm5a0f+OvvUxF6k1Vx/4v/1km9mXJAFj8qrlYr
 R/+myGCSFOZymiW9rAHJdoUI0YprSWSxNTJeRY5rNVO9d+jjwUooHf7bb4d/6HvH
 UBd8gATZkZvVtpHIp17J9g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46rufdr5wx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 20 May 2025 15:16:47 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54KFBcA6017452; Tue, 20 May 2025 15:16:46 GMT
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazlp17010006.outbound.protection.outlook.com [40.93.1.6])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 46pgw8da5v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 20 May 2025 15:16:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NHfOu4mLG8HDVqrcrF7asbzvAJdUoym1+LLJwAZuPJJea4ooQuUkdCQ9YRJO0Y4HLwNX4qMFPDbbJjhkpXznKtLNxumg2b+PfcOgaow8aKrmko6Sq6pUAxmdq2V7N+kKPPNZmz71hpHgAz44/afnhwI2FtXD6bEmpFMwdWntGhJ/ZZWLcnkODKxZzyA6hmg9jPc0nOfLQj4+THxCB93Th98xXbdO2LgaxQfedXUHWu5dacHyyOsICukKoNef89hY+K1VPuRjPW0m0V7PRhMFCA2A1lrLFZ43oeAHvbCMaNvW+/ct97HKPLBR0LV9NyPhPHUmxliC8nWL3gR8tae0NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=11XcZbZmq/lNie/5i/HroIbQbW0n7vHnhVvOuZtDdAg=;
 b=uPK3FyVWm7u8jCkv3/E5HZXrCr1dJLv2rIycYIHuGVlU3IiNgBoX5mYMPRl/0dCAqiKWcLSRL/+xFH1+j2pNlOk1I1z5k8ITRP4s5BhFJKeK3KvO20elJh3X0YUxbt+fengWWza15pe8wsw2NkYZyh80J2pA1fCWkcihhzjs5chrylD+p+Zn8fjfJdV8nBBWyHXLLqqjpSk+eFNELRrCD9i8sAW5EoND5w7ra4cR/FmD1aPjhlruzkNWbSv8A8mNRnySbYUppUxOahSyzde2pXWxt/VcK5kd+sEX2aiGL3i0lLIm3JU03XT2rM5PLUOHyyiLsxWVih9bbaZlxfhyAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=11XcZbZmq/lNie/5i/HroIbQbW0n7vHnhVvOuZtDdAg=;
 b=BoBDmj8kxIxzyDeEYspiXVcePp0Kzlx18KLuKITg8kBcjYZ0hJYgD5rusg3g5TQq7RFla3SLrKM/G/Jm4xsx+WxlIqlyfcwZjUoFbd0VD7n3Dlb6UcIVFSVy9LTAvTyVez+Oh5h/jfcRTFlp7OMbkxCHcz/y+FqXv7BH0gJmuh0=
Received: from DS7PR10MB5134.namprd10.prod.outlook.com (2603:10b6:5:3a1::23)
 by DS7PR10MB7374.namprd10.prod.outlook.com (2603:10b6:8:eb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Tue, 20 May
 2025 15:16:43 +0000
Received: from DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63]) by DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63%5]) with mapi id 15.20.8699.024; Tue, 20 May 2025
 15:16:43 +0000
Message-ID: <e20262e4-6df1-4b26-ae43-da6c8b3bcc6d@oracle.com>
Date: Tue, 20 May 2025 11:16:41 -0400
User-Agent: Mozilla Thunderbird
To: Li Wang <liwang@redhat.com>
References: <5964b0f9-e422-46b9-bab1-04e699e2f5f6@oracle.com>
 <CAEemH2e7+2o=rM3sCoDVXgepjWessmtX9FOgHa15Ue7uFLwUSg@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAEemH2e7+2o=rM3sCoDVXgepjWessmtX9FOgHa15Ue7uFLwUSg@mail.gmail.com>
X-ClientProxiedBy: CH5PR04CA0009.namprd04.prod.outlook.com
 (2603:10b6:610:1f4::15) To DS7PR10MB5134.namprd10.prod.outlook.com
 (2603:10b6:5:3a1::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5134:EE_|DS7PR10MB7374:EE_
X-MS-Office365-Filtering-Correlation-Id: 8192e60c-486b-438c-1e2e-08dd97b15413
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TVdsRi9hVmV3UlpDRnVqUSs1VmtSMHEwTjhjQnBSMG1ZZCsvQWxBL1Q2Smxt?=
 =?utf-8?B?NDJKY0xTL29ZdDFBVHpodHlqK24veXNKdWFuRnM1MVA5QVZINm9nRFpRZG1m?=
 =?utf-8?B?Vm1PcUdPVkIzM1JiV3FIbDAwQ3JlLzV0UVcxMUpDdXdIaG9UcEtDM3QrWVJ6?=
 =?utf-8?B?OTdCVEJiVHZxcUNrZHdqTFZQMlpoTEprQm5lNnN6V0Y0RGVRd2JBY2VLS29a?=
 =?utf-8?B?aUpidVNnNk5XUDRCaW5tbWVpZm1ZN1JSV08xVmJWQnYzMnZmSXNNcG9TaHJC?=
 =?utf-8?B?MHJadm9LanBOdk44cFUzdU4vcHZXZ012RmtLNisxeXFWeWZOd3lRZ0tGNStj?=
 =?utf-8?B?Z0Y4MW1QWStuZUoyZER3bGgxTUlWLytDd2ZVYVhMK1hpcU9tVzhRaDB5NElr?=
 =?utf-8?B?NGcyZnJwSlJ4WXhveUdROGlWcGZrZTZIYSthR2h1aEhka2pwRjNCdDVDMmIr?=
 =?utf-8?B?dUgzRnRxME9FaHhRd2drRitEMFlYaTMzOTRMZjk1M2t5dlBIMjdUWFg5TDNx?=
 =?utf-8?B?azF6RERGbElCa0ZRTnJOVmxBYUFydWljbFZub1RtS3BmeXpFZWZTRHRrTStY?=
 =?utf-8?B?b3RJSHVjOVJybU4vVktrUVEwNCtzeVdvcHZjMzZVMTB0ejZBYlhDbm1kZG9O?=
 =?utf-8?B?dlQ4V09RRFl2ZmR4VDd1UUM2Ti9YTUI4dFU2YkdqSzh0eTBqWCtMZHE1Z1hB?=
 =?utf-8?B?WlFWMXkvbkdpdUlSRndYZmY1dWNYbnZLSlRVbkhvS2VNWXVMc0Y0S3dvYTly?=
 =?utf-8?B?QysyT01TYklENllHZE5la1pqcXV5ZTlCbUFSckw3aFZXYjVTU044WFFMSjdG?=
 =?utf-8?B?aVp3UUxaejJ5a1F5eUwxWHM3K1dZNnhNQXdlaXl1cmJjQlErYnFYY0FwM05q?=
 =?utf-8?B?N280VXNkS3QyeW9aMWcxMzAvKy84Z1VMUDRVSlNyUER6clFRRWI2VXBHNVFG?=
 =?utf-8?B?ZEUweVowSTNURUd4bDQvQUZhU29tVGlUcmx2bXBiT3M0SjZRSDFhMUVucnpF?=
 =?utf-8?B?dWZwUTVpV3A4ek53SkhURFhHZC9aV0IrRlJLVUNCTm1rMDNHaVFmUWZwTVVQ?=
 =?utf-8?B?UHEyelNzTTl2SEQ4WkNYelFoYXZxaFQ3SzR4K09oU0hBeXVzK3paQ2tQWSt6?=
 =?utf-8?B?MTZXc0NXL1NkSzJ2TTI4K1RsK1hqclQxU2NBVzhHTkU3UkRuQzAwKzRxVnhD?=
 =?utf-8?B?QW4wUFB4T0JJTFBNUjhNc05WR1RRN3d1Y2luRUsvZThGaGRBbkllS2dzM0Mr?=
 =?utf-8?B?RU9oV0hURXVaejJaMUpCMzViT1ppSkJwbXlXdTVPVExBUktrajc5dXhham50?=
 =?utf-8?B?NkNlMUxiTy9iT3FFMEZKZ1ovK1YydFUyamUxbGJueTBNUzV6Qk9IRkxLS2xm?=
 =?utf-8?B?elgwQi9MYUlxNnVsUG5ubnI5REFScWtuQnpRejVyMXhWcFh5ZGk3OFVaUVhN?=
 =?utf-8?B?QUNmWFk0cFNLOVI4NzdoMzRic3lYUk5UTm5WMHJOZGZGQXhsTC84WGtsVURl?=
 =?utf-8?B?K21qb0ZNbFVoTGIxTjVRQ3lNcDFOUmdBdTJiUEtrMVlmNXBPRFc2RHhSTnpE?=
 =?utf-8?B?dGgxMC9IbWFKZEUzZlhmZlRjRjZsUHBDR0tLQnZZcDc4N3Q3dzI2dHF0bm1H?=
 =?utf-8?B?LzZMaElYV28vMTh3dTN5UktnYTJrV0lnRjg2Tlp3VzE2V2NNTldQSnI0TXdk?=
 =?utf-8?B?aXR1L0pBT3RkTGVVc3kzb2JiOFFRenNqZEkvMGtacjdIaWJ0ckZTOU1xVDRw?=
 =?utf-8?B?K3MxeGs4VWFLVU1RZGZRa21uVWpuL2VmZXp2NFU2cjNZVnhLUkpGOVdmRlNP?=
 =?utf-8?B?Tlk1Ulord2ZCS2xQQkFsZ1AzZnM1SDZLNmVNeDl1aTNxWnZiYzVoblQrM3RB?=
 =?utf-8?B?NnlkYm5BRUVHMlUxekpZY3RMVDl5V3IzNEhBaThQRm9VN0NIeEpLY0NYeHVX?=
 =?utf-8?Q?ON+xPUG0rlM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR10MB5134.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDNkTjI3UWhBSVlkMUFNTE4zaHYydzF1RUdZbEtWdFlKeU1VQmVxZkh6QWJH?=
 =?utf-8?B?VTVEV0R5ZEsvSFMxNVlOaGQ2TlZqc1BFYXVLdHc1QmNWbTFZVW9LSDdiTnJj?=
 =?utf-8?B?d0ZzYlVpVzgwOXhRTFNvM3BGTmkvdHpIcUNkei82dGZTbytuMGhsd2dZenZk?=
 =?utf-8?B?RFk5SmtIeW9GM2RDd3RjUk9lU09yS1A1WGZncitGZkJmTVRyNDlQU0dPa2Zt?=
 =?utf-8?B?OGV3a0xPK1JTTmRvZ3VmYzJHZldCN3RhYlRWeEVFTTdOQndhSHE1RjBMSk5D?=
 =?utf-8?B?eVVOaGRnd0VSVzNhb0lZTTJNcThES2RxdjkrdzR4dzFVcDEwREp1M1lWM2JH?=
 =?utf-8?B?eVhkNWRGTUxiMmtuRG5uc05FUlo2TEtlY2pZaE9jRnYzcS9IQnZ6allOc3NM?=
 =?utf-8?B?eWRrazJSbDQ4NHRxbXU2djh4SWNWU0hkL1VnSTlVbXVvaWFybW12TmE0dGJL?=
 =?utf-8?B?VzFOczU0enV4cnJmT2lZVFRjMnZpcTRxZU5zcm4yRDViWFYzOTFtZXZYeWVT?=
 =?utf-8?B?L1BIT0ExSldWOFVLeHRWYmpLS0JsaE45MHdTWFpjcTN4Mk96ZkpYclFHakZx?=
 =?utf-8?B?T0Q3bUhDeFY3elRmUjcwV1ZMVkRGNnlzOUtCT1NrUHplRTRJSUlTZWFQMjY3?=
 =?utf-8?B?M0FzSi81SHJSZjlyQW1MTEpHTlpGbVh3RDJWU0lhQ3UzckZWTC9kOFM2OFFE?=
 =?utf-8?B?TmY1SjBlR0ZraXhzdGhVeHh6RnpVOWI5UlIwUW41VW1uSXlscGw1cGl2RjB0?=
 =?utf-8?B?OGd2MjJsSEJNOWdjUllBclRFb0NQd3doN0tRVXNkNHI3YTZGMWxMYkhoY1Bt?=
 =?utf-8?B?WTQrM0wwbHduRHdIRkhaakJST09KOC9Heko1QkY2WExwZHRlaklSWkJiQkh5?=
 =?utf-8?B?M3NVUjUvK1lSakE0K2NJZ25lelZmemJpZlMrMFRtM1hTTEVyQjNNT2F2UGdJ?=
 =?utf-8?B?SFFhU0JkTElwL1dtNzhjTFpiU2Judk1XRTQxaE9ZeFgyd1ErYUZYNi9oell2?=
 =?utf-8?B?K1h6YVc2UzVLZWs4ZDFrNkxveXd4SE93K0MwTktiR0syaXFmeGE5K1VEVUxx?=
 =?utf-8?B?UzlVTmJuQ2hNTmU3MFdTWS9VMTRDU01MZDVQQ1FEZS9nWjVKbWJBYVN0Z1Iz?=
 =?utf-8?B?TUwvUjFuNVRMdDZPc1RMSzJBNnJJeWg0N2p4VEV6M0hKMzBPeE5MazJRQkJI?=
 =?utf-8?B?ZG5VamtucStaWG5TL0VndHA3YktPc0VjQ3RYd1hTLzI3N0o1b29sR3hIK2Fp?=
 =?utf-8?B?WDJsQ004ZHlYd0YveHNJVnMxSFN4WFdoVEV2MlhCQ0wzbjBsVmpmSVQxUnIx?=
 =?utf-8?B?T3hRUEQ3ZnFmU1lCcUFnOHJEZC9sUUovTHhvdW5jM0dqUmcrazZ4U0JOWHo0?=
 =?utf-8?B?NEprQnlJUGdZZndYN1JxbUxZamhPVFhITW1tRHZQdzlHbnNUYkx0Sk95Ti9B?=
 =?utf-8?B?U2JSemJ0alFGOGVBTXdwU0FMWlVXTW13YmZUZUMzbjVlaXRuWFZ3dEdFdEF2?=
 =?utf-8?B?R0c4NEpOR1dBclgweWVwMTh6bTBiTDBtVWo2YTBHQUFhUnpDY0NzZkxjRnZ0?=
 =?utf-8?B?TVdjSElaZ3hoY3Noa3dLd1kyKzF5R2hIQ0ZoeE5HcVJXdE14ZkhFV3hyNHl2?=
 =?utf-8?B?ci9RUVNaS1hlUm15VVJSOXR0dnVzc1RPcm9FWjJRbEloeXRKY01MQjJTMFNj?=
 =?utf-8?B?QXJUejRCc2ZQQ1dSaS9CVzhqWTNhM0J3UXRYcmZGKytnOHRURkZ0ZEdNcFRB?=
 =?utf-8?B?TXR4NTZxYmVia1Z4SEtDRHZZUHI2bmw3Vnp0ZTg1L0hIeXBNalBaWDVDVWQv?=
 =?utf-8?B?VHA1TDNub3BJVVBFeGV6WjRPMTZxa05sbGZrQzhGNFRaelR0cWFLNlIwVFZP?=
 =?utf-8?B?cW9hNCttMWFSZW5MZ2ZYaUxxYllISktHNjJ6Z1RNUERqSjV0OHo5MnBVU3c1?=
 =?utf-8?B?UC9XQ2krQW12THFvSitOQmp1My9OY1pSTjdjdlBNQVJ5bHlCbFF5TzBNTEdQ?=
 =?utf-8?B?VEk2RHZRUWIzaGtYb2VEeFFRU2ZiKzZKUWFQVUJqMnJLUVM5VlptVHlyWWFR?=
 =?utf-8?B?OGlKZWNsQjJUZ1NFLy9MR0Mwb0N1dXlIaWU4QWFjRmxwQ0VqR0lPay92d1Ex?=
 =?utf-8?B?WG0vZHYzMm9pU09DaUNkV0ZKbnJLM0RORzF6ZTl3NjRxZllKaUFhb2cwWFhX?=
 =?utf-8?B?OVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: LC42D+OFqkrZRNYdXMLPQSlt8lovO+87mtrtaGKgmGSv3kGVINDNkcOYOKPX47jiRk+8v68Rdnzrt1W6RnUQooUlARBiLSxlNtzWYwJfdOPrBF8jpoWplMq6BgAjMUm46nufxZMVX4Vg4a8rmEhhOUp1w5uSFR8fWA5TozE2bkzBIzf7lJbKp92R+/ZhRbrHmQkbt1Fbafrboz3DD63RBprU/Nx7d/DKFv7wv3bV9YhYaaTbuwNbVl2dY5ugFfI3JmEA5wsCQJo0jnqXf2zn33Zt8/GsLkqRZE5mD924aDLR5bwiFg3ev1nWJL5n3dYWFTvpgULr2Pdul3Nl56nXGW0IQva21t0BkqbUitqhTwxz1Xg0ILAZnAkQW/1uPe7p4TQDskZEhMw5cItuwpLMUq8BeUu2AZ4ilVbytzjeH/b2swR6tDPZJ97Qbl38rFFtB8IUS3eJ3LkfSLcYW2LGKMyyj9yQwlSBThofTg2DJ+ddo4LkvN2p4nTtNgzqv/d8pNxAu/svlfapNiiFn41/Hyj5ruiyfIBfm3xKrUiIayEroLLaGGxsdPvpHhmN/22PcUMs98+ejvtn3hRjl9ngU/A0YeMfdmY95u7wx+f1U/0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8192e60c-486b-438c-1e2e-08dd97b15413
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5134.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 15:16:43.4188 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mtaF1CBbZ9BEWpkPXt257lFOC6HNZ0kaoy8WFSVMUGPHs0JTDPLlVMq+DaIfrngznhIoVDnkf0ebzfyI6VKJIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7374
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_06,2025-05-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 suspectscore=0 spamscore=0
 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505070000
 definitions=main-2505200124
X-Proofpoint-GUID: 5AvjdDUpjJmeLPPvOe9mkXsu1oprU3cx
X-Proofpoint-ORIG-GUID: 5AvjdDUpjJmeLPPvOe9mkXsu1oprU3cx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDEyNCBTYWx0ZWRfXwyCMAgpgauQp
 K1R7LAPFxqXTc7eCfpbDS2NS2E/MBJ39Sz6jPszbzuzO0ODznCTricbZx/iB2Wibeci+PuVZiMR
 ulzcBESDMa+A3xp+erWmY3NGxp/Ot9GF8KgtccUqxbWyLT8UHfwYb8U1g8UY4mQkIDQ1lYCCeff
 Z4QzPTI1LqoMO43jdKTN6N9R/et4OLT5NLkkB0UxK4LWyKYB39yFEL2EPIWXJew7LgmjaW1HA/A
 +tUKCrASNtiD94ZhfS3aQJ3FbqRoNXFiykdPIAcCFXQCrI6+jac150qa6Q25MaO+pYoH0t09vKl
 Qil1U6BS+g3jyoQuB/d25yqbMztUjjNofBTCT438S+Pl41EMlpot/ucte5d/vUb98boRehHpNST
 /aKs0NpjI/uMSd7q94F1LMqRgsJ8BLxbQK5onm4Hk461JkpGd/mYIwUHL/MhgBKlmJdMEv++
X-Authority-Analysis: v=2.4 cv=c/SrQQ9l c=1 sm=1 tr=0 ts=682c9cdf b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10
 a=NEAV23lmAAAA:8 a=KWHlveBwcnenlY_BMGkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:13188
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] latest ltp not building on RHEL 9.6 ?
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gNS8xOS8yNSA4OjM4IFBNLCBMaSBXYW5nIHdyb3RlOgo+IE9uIFR1ZSwgTWF5IDIwLCAyMDI1
IGF0IDI6NDDigK9BTSBDaHVjayBMZXZlciB2aWEgbHRwIDxsdHBAbGlzdHMubGludXguaXQ+IHdy
b3RlOgo+Pgo+PiBIaSAtCj4+Cj4+IE15IGRhaWx5IENJIGJ1aWxkcyBsdHAgYW5kIHJ1bnMgaXQg
YWdhaW5zdCBteSBuZnNkLXRlc3RpbmcgYnJhbmNoLgo+PiBGb3IgdGhlIHBhc3Qgd2VlayBvciBz
bywgdGhlIGx0cCBidWlsZCBmYWlscyB3aXRoOgo+Pgo+PiBJbiBmaWxlIGluY2x1ZGVkIGZyb20g
Y3ZlLTIwMTctMTY5MzkuYzoyODoKPj4gLi4vLi4vaW5jbHVkZS9sYXBpL3NjaGVkLmg6MTg6ODog
ZXJyb3I6IHJlZGVmaW5pdGlvbiBvZiDigJhzdHJ1Y3Qgc2NoZWRfYXR0cuKAmQo+PiAgICAxOCB8
IHN0cnVjdCBzY2hlZF9hdHRyIHsKPj4gICAgICAgfCAgICAgICAgXn5+fn5+fn5+fgo+PiBJbiBm
aWxlIGluY2x1ZGVkIGZyb20gL3Vzci9pbmNsdWRlL2JpdHMvc2NoZWQuaDo2MCwKPj4gICAgICAg
ICAgICAgICAgICBmcm9tIC91c3IvaW5jbHVkZS9zY2hlZC5oOjQzLAo+PiAgICAgICAgICAgICAg
ICAgIGZyb20gLi4vLi4vaW5jbHVkZS9sYXBpL3NjaGVkLmg6MTAsCj4+ICAgICAgICAgICAgICAg
ICAgZnJvbSBjdmUtMjAxNy0xNjkzOS5jOjI4Ogo+PiAvdXNyL2luY2x1ZGUvbGludXgvc2NoZWQv
dHlwZXMuaDoxMDI6ODogbm90ZTogb3JpZ2luYWxseSBkZWZpbmVkIGhlcmUKPj4gICAxMDIgfCBz
dHJ1Y3Qgc2NoZWRfYXR0ciB7Cj4+ICAgICAgIHwgICAgICAgIF5+fn5+fn5+fn4KPj4KPj4gVGhl
IHRlc3QgcnVubmVyIGlzIGEgUkhFTCA5LjYgZ3Vlc3QuIEkgZG9uJ3Qgc2VlIGFueSByZWNlbnQg
Y2hhbmdlcyB0bwo+PiBsdHAgaW4gdGhpcyBhcmVhLCBzbyBwZXJoYXBzIDkuNiBtb2RpZmllZCAv
dXNyL2luY2x1ZGUvbGludXgvc2NoZWQuaCA/Cj4gCj4gSSBzYXcgdGhhdCBMVFAgaGFzIGFscmVh
ZHkgaGFuZGxlIHRoYXQgY29uZmxpY3QgaW4gbGFwaSBoZWFkZXIgZmlsZSwgaW4gY29tbWl0Cj4g
aHR0cHM6Ly9naXRodWIuY29tL2xpbnV4LXRlc3QtcHJvamVjdC9sdHAvY29tbWl0L2M0ODcwMGQ4
Y2RiZTZkMGQ3OGZkYTZlNmNjNjU4OTcyNDY0YjVjY2QKPiAKPiBDYW4geW91IHByb3ZpZGUgdGhl
IHZlcnNpb24gb2YgeW91ciBrZXJuZWwtaGVhZGVyIGFuZCBnbGliYz8KPiAKPiBlLmcuCj4gJCBy
cG0gLXFmIC91c3IvaW5jbHVkZS9saW51eC9zY2hlZC90eXBlcy5oCj4gCj4gJCBycG0gLXFmIC91
c3IvaW5jbHVkZS9iaXRzL3NjaGVkLmgKCkhpIQoKSSB0ZXN0IHJlY2VudCBrZXJuZWxzIGluIHRo
aXMgc2V0LXVwLCBzbyBJIGluY2x1ZGVkIHRoZSBvdXRwdXQgb2YKInVuYW1lIiBpbiBjYXNlIHRo
YXQgaXMgcmVsZXZhbnQuCgpba2Rldm9wc0BsdHAtbm90aWZ5IH5dJCB1bmFtZSAtcgo2LjE1LjAt
cmM2LWc3Mjc4NTY5NzQwZjYKW2tkZXZvcHNAbHRwLW5vdGlmeSB+XSQgcnBtIC1xZiAvdXNyL2lu
Y2x1ZGUvbGludXgvc2NoZWQvdHlwZXMuaAprZXJuZWwtaGVhZGVycy01LjE0LjAtNTcwLjE3LjEu
ZWw5XzYueDg2XzY0CltrZGV2b3BzQGx0cC1ub3RpZnkgfl0kIHJwbSAtcWYgL3Vzci9pbmNsdWRl
L2JpdHMvc2NoZWQuaApnbGliYy1oZWFkZXJzLTIuMzQtMTY4LmVsOV82LjE0Lng4Nl82NApba2Rl
dm9wc0BsdHAtbm90aWZ5IH5dJCBjYXQgL2V0Yy9yZWRoYXQtcmVsZWFzZQpSZWQgSGF0IEVudGVy
cHJpc2UgTGludXggcmVsZWFzZSA5LjYgKFBsb3cpCltrZGV2b3BzQGx0cC1ub3RpZnkgfl0kCgpJ
IGd1ZXNzIG9uZSB0aGluZyBJIG1pZ2h0IHRyeSBpcyBydW5uaW5nIHRoZSBsdHAgYnVpbGQgb24g
YSBzdG9jawpSSEVMIDkuNiBrZXJuZWwuIEknbSBub3Qgc3VyZSBpZiB0aGUgdGVzdCB3b3JrZmxv
dyByZXBsYWNlcyB0aGUKa2VybmVsIGhlYWRlcnMgdW5kZXIgL3Vzci9pbmNsdWRlLgoKCi0tIApD
aHVjayBMZXZlcgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0
L2xpc3RpbmZvL2x0cAo=
