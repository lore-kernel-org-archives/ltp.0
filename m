Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB312C54E71
	for <ltp@archiver.kernel.org>; Wed, 21 May 2025 14:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1747836269; h=message-id :
 date : to : references : in-reply-to : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=qgSfylZ1wPp6xDK3H3ZEeMzhdlcgRuQA5ybQABmaCeM=;
 b=F4rIfd/Izu7SafawpmxSs25ry0EWWEWxsw3mveCh+HTW+6FDLy41thX8BcIPBy9PrlUvv
 YHboBP/zJyRidBBEi6aV5XMZhvOzgYW7uGExkU1ju2nFrtR5UfGbS0CjGdSsw3BBDBNZbIc
 6nmfthmb+mWa+BS5cmMECj5hKIfJiRQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 295003CC7EC
	for <ltp@archiver.kernel.org>; Wed, 21 May 2025 16:04:29 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8DE253C9AEC
 for <ltp@lists.linux.it>; Wed, 21 May 2025 16:04:06 +0200 (CEST)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 3B8AF6158EB
 for <ltp@lists.linux.it>; Wed, 21 May 2025 16:04:02 +0200 (CEST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54LE2dmL007414;
 Wed, 21 May 2025 14:04:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=ylz1VyplOLzmJsE+eRI+t9CKdF9mB2eCBdU/Zxm7XJ0=; b=
 bBeZwJmh6qwKCLAds9QJmC0liDVDx226rZt2VTD+Kmdd6iEVk+f+PfvuHRGqZAvA
 7Kh1rAtSQKErbYyMXfL3x3XzF793tz2NIaW1KVz0K633/UXcHghoel0lG4IO+GLE
 /x3qauQcsd+tpPdpxkwh5LsIL1mEF+fmGGC8Bz6FqmGvdNcLWPkP9ANrYQieYfjq
 oYzrkb/aATw8vTAyPdB+I4p6CWIE4aSMcAieqZcJ9eJWYT7cLp7SEWq8EGtMJMrk
 tSUm6MXxjq3UqwkpYAwZe+rmwgoyrFL6NCYosKe5bihRWa1DWK6eqiPs1CyV7sLl
 yl9uelF5qgDG8LdhlRU9nw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46sg83r0c9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 21 May 2025 14:04:00 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54LDmtLn011251; Wed, 21 May 2025 14:03:58 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 46rwen5btx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 21 May 2025 14:03:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QFRhWy0zJZ4eg9JET45CN87pQrwOx2MrJLUH3wbrDIjiXXrz4qe9l+859hqz1XB8ycKIwHgntuGmls9Elp7bwEeplb6vxXS9wR23ohGFUbLLajTa6NpL7cwcMsC5fn2OppD+pPt+vfGGsPOZDOwkgv/2VlvJh5l9Z6iGwHQfg/na5K75krHih0r7uN9XHH3/QOVttdykiOxSL4yPSgsEXJnJD/Gmy9agECOum59daJMrUrgFUAD9IGdDmvbTKxozpck+9rPDIAvY+EMI6hJ5SbfY2ykyWwfKKJ403NZ1SHMRAncjgE3New7mKW54WdmCBwbcURIpwOoxnuwX+6wCvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ylz1VyplOLzmJsE+eRI+t9CKdF9mB2eCBdU/Zxm7XJ0=;
 b=SiiBzOiAXIqdhs3OG+d2dAkROQZIDS4er+s9cq0R5G3iHTap0OC+avmSisiWz7jSyRnPIRgQlMerx1N0wPlqS7m5AXAdzgCGbAZQa8DIYK4o6pDkWt1Zal/XvAjOP3F+qGn5LREWWEOsx7x2bpqngTw335eqZAXeT75NpaSjkrMVw5tZUqsZISyyYr+gPvcstIdSkmUHnIXBa32mH9I8kt/hfV0HmYR6GOhjEQCg/+G8cVD01tkeDGOcdH806NieBv/DjpW336UHErK07SsrWGW94bg0C+UZV6KC1/g2VXgyCrFAt+hKFDT+NEi/ofa5zI5JvrhkV58H1hFLPLDBNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ylz1VyplOLzmJsE+eRI+t9CKdF9mB2eCBdU/Zxm7XJ0=;
 b=zf6EL8Z7B+R4HYjmyhqYQnbn/hZC6HTdDQMwvjicTPKyPqB+50CIr7xE6bRDcnYdgfpS03shk/UUgkhuiy8CCC0QkGf9qFMudVKbdP/K1ErKV5SzLA+EYsOyFTsQn+3/6q03KS3wDUAPIICrA+RpvHT/wmwX8V8IU/QMS/Y5yfU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA0PR10MB7602.namprd10.prod.outlook.com (2603:10b6:208:488::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Wed, 21 May
 2025 14:03:47 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8746.031; Wed, 21 May 2025
 14:03:47 +0000
Message-ID: <d97a9350-bf8c-4010-bfbf-6ce2053e0c0e@oracle.com>
Date: Wed, 21 May 2025 10:03:44 -0400
User-Agent: Mozilla Thunderbird
To: Li Wang <liwang@redhat.com>
References: <5964b0f9-e422-46b9-bab1-04e699e2f5f6@oracle.com>
 <CAEemH2e7+2o=rM3sCoDVXgepjWessmtX9FOgHa15Ue7uFLwUSg@mail.gmail.com>
 <e20262e4-6df1-4b26-ae43-da6c8b3bcc6d@oracle.com>
 <CAEemH2eYbE076mjEGNGmABywH6vrTauGJzuO98cibcw=6yp-iA@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAEemH2eYbE076mjEGNGmABywH6vrTauGJzuO98cibcw=6yp-iA@mail.gmail.com>
X-ClientProxiedBy: CH2PR08CA0003.namprd08.prod.outlook.com
 (2603:10b6:610:5a::13) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA0PR10MB7602:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bb0fc41-24fe-4485-34fe-08dd98704dfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Tnp2dGxuU0gwVDdqNmhNREFzQ3QrM0VRaExRSUFrQlppY01ta3h0MHRwU0ZQ?=
 =?utf-8?B?bE53aDR1YkxiNVR0T3pCOUVESmpiZldXd3BnRVAvQ3Mxc3JrV1FQUW9nOTZC?=
 =?utf-8?B?UkR1ZnZpQTJYSU9jOEVoaDNKNlR4RDN5bXBUckptRnpmNEVmandRdG1kRXFF?=
 =?utf-8?B?UExZRHhHTUgxKys3bzB4Wmc1OGgrSTUxZzNyVFJBZE9oR2plNFZUc0lzdkxN?=
 =?utf-8?B?ejBwdGlrK09LendkaHVDN21ZYzM2LzJaZ0tDcVA4ODZ4U2l1bkFwK25aSURX?=
 =?utf-8?B?MzJpRnhYTk1QRGlZYkUzbUJxVkRCMW9vaXZXQUFycCtZdEdhMnJhckRVL1Zz?=
 =?utf-8?B?T0FSSGRKMERYVVE1dDlaVXhCREp2a25MeEoyNUQ2VUlZRSs3ZW5KZTFpSnVI?=
 =?utf-8?B?M3U3SnNtQm5TQnNJT1BveGRRMloyRGNwTTdxUzBTM1htWEhwenE3UUgyYmZX?=
 =?utf-8?B?dTdORGFsenROUms0SzlBS0xHVnBENzlaaWI5L2Z3cWtZQW9OeUFoc0JGYVE0?=
 =?utf-8?B?ejNacXl2S3B4b0t3Q3NuVzlId3RNV21aSzBUTGg0bmxiMkJTR0xPZ0VqMnhn?=
 =?utf-8?B?cHBzVnB6c1p6d1gxQTl3VE12U0RNT3dPRzhWOGFZNStEYzVBNHFCSGxkRk1C?=
 =?utf-8?B?NXVDRmNudHV2OHE5WlErcWZtNlJNUXFjelBkSkwwbVhmVmNjbmd2YWNHWmho?=
 =?utf-8?B?dXczN3o5eVF2QnhZMldFVXpqYnpMdzFrZ2tIdzBzbVN6ZzJhbUUxTFJLbzVj?=
 =?utf-8?B?ZVVrcGhnc3ZnWVlVU0N0anJCOWNPZDk0dDBjbWZ4eVFScGxDVE14QVFCRXFk?=
 =?utf-8?B?UkxwTDBQaGtxQjFkL1lJYml0b1luV0V1am9TaVF4RTh2eDZLVUh0TWg0ZTVT?=
 =?utf-8?B?NkhtbkpMUU1oVzdwdm1GaHZpTHorWW1EM3hhVms3MHVEVDhZQTF6TFhFRDd0?=
 =?utf-8?B?SHhSdU1XOXdJVEVxYmxVYk93NU9qblVkTmpaUHZ2RjVyVDgzcjJRbE90enAv?=
 =?utf-8?B?a1RlM3JpdTlLMkRXd2Q4WmpkNGVPNzJNNWdLZ2tNZ3hYV1E1dmR4Sk9DTE1V?=
 =?utf-8?B?S0ROUEdRMHgwVUxrQ1ZDanErTTMvT3pRK1c1NXVZSkhsOWFBbmYxYmRKS3I0?=
 =?utf-8?B?TE9KVnVvcm1DT2RNc09KVW1uQWNvTUh2dnlSRzRiRDdUM1pDRUJQaFN5bzlO?=
 =?utf-8?B?NVhqT0RWYWZqN3Q2RGxjOFNzKzhyaGJhMUhuRWNXK0YvV0lQQm8wdERJMUdB?=
 =?utf-8?B?WW9TVnF2ZE9CWE5SSEhjY2JTem1aOFV3NFdFWkVRS0RaUThSU1g1NVU1MDN6?=
 =?utf-8?B?bzN5TUhEdDBIVjlUZ2F3amQ4Tm9LWnp6K1d2d3FuSW5Pdi9EQnBHUFQxYnJN?=
 =?utf-8?B?UVh6K083K29JTE5rOXJNMkM2UEYzbHk3SVpOZ1NOSmtZYkFHQ2tPWlV1Y3NZ?=
 =?utf-8?B?YStDeU9VaVIzMHd1NzY4OXN6VmpBVVhlcHl6QXRKT3d1ZU5kRVY1cjI5aDdP?=
 =?utf-8?B?Ykx3VGFmdHU2RDRFMWRuOElsSi95Q2k5cFZDckQ0TkFZdmxsVFZLVk9DVFJx?=
 =?utf-8?B?NFFZbnVZcTFIU2FwT0lxejlyaXFudmhPb2c4QXdmY25UaTFlUDNraTZQVnRU?=
 =?utf-8?B?aGJHd3NpUWViQlp3dXpOUHgxTmtUN1d2NzVBZWg5MGhkcnUyamZGT1VHS2Vv?=
 =?utf-8?B?WHlUbW93R0sySGJ2SHlxcVVRb05FOTJUd2xwVGUvM1JwM2FpajRGeVgyODFx?=
 =?utf-8?B?WGpuNzhQNWV6RXlZQ09yZ3pjS2I3WmZQM1dZc0Y5N2xjKzRNbjdkc0JqT0V3?=
 =?utf-8?B?cC9ya3dNLytoa0YzVDNEMzVhcnJKNmFMbHB5LzVTSGY0ZXBpTUJZQlJBdS80?=
 =?utf-8?B?MXJWSXdxTjVmNjYyZm11TklFWEphSU55VENCYW9RL2dZRnNrR0RTRDBab3B3?=
 =?utf-8?Q?cplX7Leiv50=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN0PR10MB5128.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWRHc2pXT3RBckVJVEJrLzlMVEFETXlNZzVHM1lkc1RLQXdTZU50VTByd0xl?=
 =?utf-8?B?Ti9zcFZZWk8rSXh2Sm1DOVNLRUxMMjRFRzRsc2RPUkVtZ2RlK1k5dUNWa2R4?=
 =?utf-8?B?eG03MkRyaXpNZVNPajMxdWQ3dlA5bVhrMGRoY0l3amFwLzJvWGVVZkp0b3dT?=
 =?utf-8?B?bHpVTXkwMENvTXh1bE43TjBlQnNzL21kSWZuTldiM1QySTF0c080Nk5GMUM0?=
 =?utf-8?B?ZWE3Rmo3VWh3RU52bTBJQ3NlUGg3R29aQ0V1WEkwdVNWaXcrZ3FJZFNDNFpm?=
 =?utf-8?B?a1NuaWx3NHdKdkFiT1k0Q1FLZVh2Vnl3Z3JzV0JUaVZZSGl2YUVlL1NSMmlF?=
 =?utf-8?B?KytDcjFpY3ZLRU9RYUloVUJ2a0NqTzY3TER0V1dsNk1vTlVNZDJiNnUyR2pY?=
 =?utf-8?B?ck9YT3E4Y1hUUTV4S0dwaDRuVmt2TG5Lb0FlSVV6SWk0dUFHUVlpRGJlQ1gy?=
 =?utf-8?B?VXNLNmh1RU9ybTR3akZUN1J2VXdxdURLQlFsSXFjNGhlcFlBNmdibGNFVzhU?=
 =?utf-8?B?c2lzWEdZVHVJQ05Yczd4LytJTVo2YVBnbW5kVHVnbmhOc0VLU1VORUc2eFlL?=
 =?utf-8?B?QjA0QnEyQk1nMWs4T0NMWnFMZCtwZHdtVkUwaTNpd0tsYzFIZnd4bG0zRmQ2?=
 =?utf-8?B?L3d6V0NoK25hV1dURFVUS3dUM2tsVUx0WFYvLy9tWWRqRWpJbDRlSEZOYmtm?=
 =?utf-8?B?dVFNR0ZwSHJSNTRCOElmbVNtc1JkRjBxejZ4eG5PbXhVMUJ2RHBpSVZEZHR5?=
 =?utf-8?B?ZmVScVZRRlppeU1VY2xsZEg0UHpBR2k1L25lSzFPRkVYR0VPTi9ZeUoyUktB?=
 =?utf-8?B?VWY3MGNXVXFHbGwxZElpb0huRWdwQURUZ2xxbVl6Q1Bxa1RackNNcmlWZE9u?=
 =?utf-8?B?elA1ZnhrdlZpb0VpODVuWE9XQmpEUDRBODVRK0JydEFyemVoSXJLWGR1NU1N?=
 =?utf-8?B?R0tWVzJCMGpRckhFQ0FjV3BNSktLSzVrYzFtdkMxemtkcjMwNWROcFFuWmcy?=
 =?utf-8?B?RVRDL2NqUmNpVkpIdXZMWDE5TVQ5Rk5oM3MyMUZYWDV3NEJ3UUhwL0hNR2c2?=
 =?utf-8?B?ZmVVTE5iZjM4Uk44eTdTemNSMncwVjRjbUFrbmt5aWdlZUJqbVlQM01ibzMv?=
 =?utf-8?B?Y1Z4clc1ZXhEcUlxMmVDbXFjeFREeHFOekxzVXk4QnZzb3U1MXdWekZGQ1Y0?=
 =?utf-8?B?TEp4LzVDa2UyOXAzZWpoQWx6bERlcWJXbTlKZVdiRzhqNmVuUUxtZ0g2TDNS?=
 =?utf-8?B?R3JaZlZ0ZkFHMHBmSVJwOTdFOFFOa21tMGZrdHVKM1cwaDhNNlVZYnFYK0NZ?=
 =?utf-8?B?SHBrTEd4U0tvT0paenNjTVo3TDVOR2IyY1ljSXdNVm4vQ3R5ZXA0Zk44WG5z?=
 =?utf-8?B?S20vTnJqWWtGcDhvN3JoNThlRFFNUjluak9wdXZGSkpRUUl2ZCtWTlowT0lB?=
 =?utf-8?B?TWd5OHBkU1pIY2c4aU1waTJ4ZUZVczc4U2VPQ0kyaW8xV0o5dzM2QXhDNlhi?=
 =?utf-8?B?RUNGUzJIYWdIZVJNVnlveVRidkMwVGNkTWVXZVNTYTdveXpVRWsvaUMxa3RO?=
 =?utf-8?B?S0xyekY5SElHbVBURTR0YUxEdTIvZ1RlL2JqbkRIT01qVWQvbk95SlMvSFR0?=
 =?utf-8?B?eVd3WHRDdFAzRnhKYytldXRyekNPM3JxbnI1bG9lTXRsSzNXTHZ1QkNIVnpo?=
 =?utf-8?B?QXROcUd3QlZqQ2haY2JOclVjTHp6WHFXNFRvSks0S1JiNHVadzk5YW9lbnIr?=
 =?utf-8?B?K1hYYjlFUDhIUmVxV000b2hwQ3pPTlh3ajVNWWFDQ05HZjZBdEpGdUxqNlhK?=
 =?utf-8?B?dXJmU0pHZCtyNFZvVkFYc0FYbHZsSSs5cXR0bXdETXNSZzY3cEpaNS9KcHRV?=
 =?utf-8?B?RG5GTmZTQi9COWFWTXFkUHBvalRtN1VSMDVDTGE0emJHaW9JQWJ2enc0djlY?=
 =?utf-8?B?TklnV3phalZpS2tLY0dQb1FnK2J6ZmdxbFR6UlIrY1VlSkdZdDd0M3hDdVpO?=
 =?utf-8?B?a0ZzYW5RNitHNGFGSDdIR1ZydEFkdUNMUkNaVmxQU3BnVXNnV2tmKzV0MlhK?=
 =?utf-8?B?aGpwS0owYnoycmsvRHFPd0hMMVR4ZUN0Z0RZMy9WVGFCTklCekFXVkRxS1lL?=
 =?utf-8?Q?+EBSdqWkttteoJWyuBL5rX41Y?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: m7tE5EHMdaUOAHBVTkR8pt9622My+AlEwIr+Sy7rr8yI3eLv7ImfBtx5S4FWrSjpNzgHVwq23ib7gthgrriUkutdPIhpF9XOweIghpY8ZN736RARImQkysMEQ8MnValdVvKSDVuCAQRk8gHyEx0LCv6Zm0tG3u53nUyuZR2WqsF5pzVaK8gDwm1LC1PL/b5kowNIIcclTSyXui6M1RV7MPm0q/Hz6K/P7Gk1EcPCvH3zC7NRJKWJiRYBCE294ZA9vPvTiZfAVp5mymZXiFX9AjdbwsG55aiEEWko8qWq3V8lag7wya681Ni4E7JTcGufHULH4eyUW/OUSPL4iCm3vLvmW5HC8QveaIXFaRS0T2zqn82z07usYWpglVGaB8K3Jj00nB2TDchQw0w1GhUwMV83JoNmU9M7ZaADjnkzwA2PXBweiu+K9lGz+qD6OYgSbW5uVyWQjEB0pD38iXvZDROrNwDECQc75VJDGJjzXqn+lrAKjpZm75E4U3iGcUZG65yEJ+Qu6wPZa63zVD71l5Lf+P1faEB+lC2leMniU8C75lO+8ie3sWH3QxNVEM6BJKWya8jN/IeOZCeiUgMPxgqqjE9hfTrpKk+IpK4EEU4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bb0fc41-24fe-4485-34fe-08dd98704dfe
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 14:03:47.3065 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wMJYajp4U7/s0XuZdvEP4hupNHG8eBAwMbzRQdgJvKNqZ1E4wo3pw3CdSOkV8Ya9xQhPsGxmGhgsEmXYUVvJJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7602
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_04,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 spamscore=0
 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2505210137
X-Proofpoint-ORIG-GUID: 1fMmTexyhsXv5ff91ayiYi_vDpsFPFqk
X-Authority-Analysis: v=2.4 cv=BqmdwZX5 c=1 sm=1 tr=0 ts=682ddd51 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10
 a=NEAV23lmAAAA:8 a=yPCof4ZbAAAA:8 a=myehC1Qalm_GzOFL9WwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:14714
X-Proofpoint-GUID: 1fMmTexyhsXv5ff91ayiYi_vDpsFPFqk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDEzNyBTYWx0ZWRfX4Je+z7XwM7LS
 pqOBf5g+a9jflRtT5MgniJ+4ladBBxb/o/mJ2ZqXIU0EcxcxsQtWzQ5pAK3dyS/w41F880srf81
 K3w1eH1fZS2OUAMpYHn/SxnsdhMxi+6qTF554r9fAbRmUk62G+8K5S7mNrH6AGwJjac96ctbQZZ
 9ArQXADg+J2B7H3jEoMyT50bj5MqRNH7JPbAgY5fTv/zu7Outais9Lgi62XUaI5QvlnAf4wP0II
 VEemqSY2uTSUct1Rn6EVy4Wku3mW9oIVpweVHYjhLjEbr2KhqBJ+iWSm9YbFDhIXN0uQq4mYbkk
 Qcj+W7NPT/5rmKy4P62xwWrhPH6C4530lSmBzNx2qpCxPLc3++AbL6rUbWVY4U7jbK3/QX3Jdx/
 rOZzGi4d9Sal8B5m2LawJR8o1WPGM+AtLLyqQM1VktYejZps0qF98GcFfQDjc3LUkD0DuHYz
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
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

T24gNS8yMC8yNSAxMDowMCBQTSwgTGkgV2FuZyB3cm90ZToKPiBPbiBUdWUsIE1heSAyMCwgMjAy
NSBhdCAxMToxNuKAr1BNIENodWNrIExldmVyIDxjaHVjay5sZXZlckBvcmFjbGUuY29tPiB3cm90
ZToKPj4KPj4gT24gNS8xOS8yNSA4OjM4IFBNLCBMaSBXYW5nIHdyb3RlOgo+Pj4gT24gVHVlLCBN
YXkgMjAsIDIwMjUgYXQgMjo0MOKAr0FNIENodWNrIExldmVyIHZpYSBsdHAgPGx0cEBsaXN0cy5s
aW51eC5pdD4gd3JvdGU6Cj4+Pj4KPj4+PiBIaSAtCj4+Pj4KPj4+PiBNeSBkYWlseSBDSSBidWls
ZHMgbHRwIGFuZCBydW5zIGl0IGFnYWluc3QgbXkgbmZzZC10ZXN0aW5nIGJyYW5jaC4KPj4+PiBG
b3IgdGhlIHBhc3Qgd2VlayBvciBzbywgdGhlIGx0cCBidWlsZCBmYWlscyB3aXRoOgo+Pj4+Cj4+
Pj4gSW4gZmlsZSBpbmNsdWRlZCBmcm9tIGN2ZS0yMDE3LTE2OTM5LmM6Mjg6Cj4+Pj4gLi4vLi4v
aW5jbHVkZS9sYXBpL3NjaGVkLmg6MTg6ODogZXJyb3I6IHJlZGVmaW5pdGlvbiBvZiDigJhzdHJ1
Y3Qgc2NoZWRfYXR0cuKAmQo+Pj4+ICAgIDE4IHwgc3RydWN0IHNjaGVkX2F0dHIgewo+Pj4+ICAg
ICAgIHwgICAgICAgIF5+fn5+fn5+fn4KPj4+PiBJbiBmaWxlIGluY2x1ZGVkIGZyb20gL3Vzci9p
bmNsdWRlL2JpdHMvc2NoZWQuaDo2MCwKPj4+PiAgICAgICAgICAgICAgICAgIGZyb20gL3Vzci9p
bmNsdWRlL3NjaGVkLmg6NDMsCj4+Pj4gICAgICAgICAgICAgICAgICBmcm9tIC4uLy4uL2luY2x1
ZGUvbGFwaS9zY2hlZC5oOjEwLAo+Pj4+ICAgICAgICAgICAgICAgICAgZnJvbSBjdmUtMjAxNy0x
NjkzOS5jOjI4Ogo+Pj4+IC91c3IvaW5jbHVkZS9saW51eC9zY2hlZC90eXBlcy5oOjEwMjo4OiBu
b3RlOiBvcmlnaW5hbGx5IGRlZmluZWQgaGVyZQo+Pj4+ICAgMTAyIHwgc3RydWN0IHNjaGVkX2F0
dHIgewo+Pj4+ICAgICAgIHwgICAgICAgIF5+fn5+fn5+fn4KPj4+Pgo+Pj4+IFRoZSB0ZXN0IHJ1
bm5lciBpcyBhIFJIRUwgOS42IGd1ZXN0LiBJIGRvbid0IHNlZSBhbnkgcmVjZW50IGNoYW5nZXMg
dG8KPj4+PiBsdHAgaW4gdGhpcyBhcmVhLCBzbyBwZXJoYXBzIDkuNiBtb2RpZmllZCAvdXNyL2lu
Y2x1ZGUvbGludXgvc2NoZWQuaCA/Cj4+Pgo+Pj4gSSBzYXcgdGhhdCBMVFAgaGFzIGFscmVhZHkg
aGFuZGxlIHRoYXQgY29uZmxpY3QgaW4gbGFwaSBoZWFkZXIgZmlsZSwgaW4gY29tbWl0Cj4+PiBo
dHRwczovL2dpdGh1Yi5jb20vbGludXgtdGVzdC1wcm9qZWN0L2x0cC9jb21taXQvYzQ4NzAwZDhj
ZGJlNmQwZDc4ZmRhNmU2Y2M2NTg5NzI0NjRiNWNjZAo+Pj4KPj4+IENhbiB5b3UgcHJvdmlkZSB0
aGUgdmVyc2lvbiBvZiB5b3VyIGtlcm5lbC1oZWFkZXIgYW5kIGdsaWJjPwo+Pj4KPj4+IGUuZy4K
Pj4+ICQgcnBtIC1xZiAvdXNyL2luY2x1ZGUvbGludXgvc2NoZWQvdHlwZXMuaAo+Pj4KPj4+ICQg
cnBtIC1xZiAvdXNyL2luY2x1ZGUvYml0cy9zY2hlZC5oCj4+Cj4+IEhpIQo+Pgo+PiBJIHRlc3Qg
cmVjZW50IGtlcm5lbHMgaW4gdGhpcyBzZXQtdXAsIHNvIEkgaW5jbHVkZWQgdGhlIG91dHB1dCBv
Zgo+PiAidW5hbWUiIGluIGNhc2UgdGhhdCBpcyByZWxldmFudC4KPj4KPj4gW2tkZXZvcHNAbHRw
LW5vdGlmeSB+XSQgdW5hbWUgLXIKPj4gNi4xNS4wLXJjNi1nNzI3ODU2OTc0MGY2Cj4+IFtrZGV2
b3BzQGx0cC1ub3RpZnkgfl0kIHJwbSAtcWYgL3Vzci9pbmNsdWRlL2xpbnV4L3NjaGVkL3R5cGVz
LmgKPj4ga2VybmVsLWhlYWRlcnMtNS4xNC4wLTU3MC4xNy4xLmVsOV82Lng4Nl82NAo+PiBba2Rl
dm9wc0BsdHAtbm90aWZ5IH5dJCBycG0gLXFmIC91c3IvaW5jbHVkZS9iaXRzL3NjaGVkLmgKPj4g
Z2xpYmMtaGVhZGVycy0yLjM0LTE2OC5lbDlfNi4xNC54ODZfNjQKPj4gW2tkZXZvcHNAbHRwLW5v
dGlmeSB+XSQgY2F0IC9ldGMvcmVkaGF0LXJlbGVhc2UKPj4gUmVkIEhhdCBFbnRlcnByaXNlIExp
bnV4IHJlbGVhc2UgOS42IChQbG93KQo+PiBba2Rldm9wc0BsdHAtbm90aWZ5IH5dJAo+Pgo+PiBJ
IGd1ZXNzIG9uZSB0aGluZyBJIG1pZ2h0IHRyeSBpcyBydW5uaW5nIHRoZSBsdHAgYnVpbGQgb24g
YSBzdG9jawo+PiBSSEVMIDkuNiBrZXJuZWwuIEknbSBub3Qgc3VyZSBpZiB0aGUgdGVzdCB3b3Jr
ZmxvdyByZXBsYWNlcyB0aGUKPj4ga2VybmVsIGhlYWRlcnMgdW5kZXIgL3Vzci9pbmNsdWRlLgo+
IAo+IAo+IFRoYXQncyB3ZWlyZCwgSSB3YXNuJ3QgYWJsZSB0byByZXByb2R1Y2UgdGhpcyBvbiB0
aGUgc2FtZSBlbnYuCj4gWW91ciB0ZXN0IHN5c3RlbSBtYXkgYmUgcG9sbHV0ZWQgd2l0aCBuZXcg
a2VybmVsIGhlYWRlcnMuCgpJIGdldCB0aGUgc2FtZSBlcnJvciB3aGV0aGVyIHRoZSBzdG9jayBr
ZXJuZWwgb3IgYSBjdXN0b20ga2VybmVsIGlzIGluCnVzZS4gVGhlIHN5c3RlbSBpcyBhbiBBV1Mg
aW5zdGFuY2UgYnVpbHQgZnJvbSB0aGUgZ3JvdW5kIHVwIHdpdGgKdGVycmFmb3JtIGJlZm9yZSBl
YWNoIHRlc3QgcnVuLCBzbyB0aGVyZSBpcyBubyBkZWJyaXMgZnJvbSBwcmV2aW91cwp0ZXN0cy4K
Ckxvb2tzIGxpa2UgdGhlIHByb2JsZW0gaXMgYWN0dWFsbHkgdGhhdCBteSB0ZXN0IGVudmlyb25t
ZW50IGlzIHN0aWxsCmNsb25pbmcgbHRwIGNvbW1pdCBiMGFlMWVlMjM5MmQgKCJycGNfc3ZjXzE6
IEZpeCBpbmNvbXBhdGlibGUgcG9pbnRlcgp0eXBlIGVycm9yIikgaW5zdGVhZCBvZiBIRUFELiBT
byBpdCdzIG1pc3NpbmcgY29tbWl0IGM0ODcwMGQ4Y2RiZQooInNjaGVkX2F0dHI6IERvIG5vdCBk
ZWZpbmUgZm9yIGdsaWJjID49IDIuNDEiKS4KCk9uY2UgSSBjaGFuZ2VkIG15IHRlc3Qgd29ya2Zs
b3cgdG8gY2xvbmUgTFRQIGZyb20gSEVBRCBpbnN0ZWFkIG9mIHRoZQpvbGRlciBjb21taXQsIHRo
aXMgYnVpbGQgZmFpbHVyZSBnb2VzIGF3YXkuCgpUaGFuayB5b3UsIExpLCBmb3IgeW91ciBhZHZp
Y2UhCgoKPiBBbmQsIHlvdSBtaWdodCBuZWVkIHRvIG1hbnVhbGx5IGNoZWNrIHRoZSBzdHJ1Y3Qg
c2NoZWRfYXR0cgo+IGluIGJvdGggIC91c3IvaW5jbHVkZS9iaXRzL3NjaGVkLmggYW5kIC91c3Iv
aW5jbHVkZS9saW51eC9zY2hlZC90eXBlcy5oCj4gdG8gc2VlIGlmIHNvbWV0aGluZyBkaWZmZXJl
bnQuCj4gCj4gIyBjYXQgL3Vzci9pbmNsdWRlL2JpdHMvc2NoZWQuaAo+IC4uLgo+ICA1NCAvKiBV
c2UgIiIgdG8gd29yayBhcm91bmQgaW5jb3JyZWN0IG1hY3JvIGV4cGFuc2lvbiBvZiB0aGUKPiAg
NTUgICAgX19oYXNfaW5jbHVkZSBhcmd1bWVudCAoR0NDIFBSIDgwMDA1KS4gICovCj4gIDU2ICMg
aWZkZWYgX19oYXNfaW5jbHVkZQo+ICA1NyAjICBpZiBfX2hhc19pbmNsdWRlICgibGludXgvc2No
ZWQvdHlwZXMuaCIpCj4gIDU4IC8qIFNvbWUgb2xkZXIgTGludXggdmVyc2lvbnMgZGVmaW5lZCBz
Y2hlZF9wYXJhbSBpbgo+IDxsaW51eC9zY2hlZC90eXBlcy5oPi4gICovCj4gIDU5ICMgICBkZWZp
bmUgc2NoZWRfcGFyYW0gX19nbGliY19tYXNrX3NjaGVkX3BhcmFtCj4gIDYwICMgICBpbmNsdWRl
IDxsaW51eC9zY2hlZC90eXBlcy5oPgo+ICA2MSAjICAgdW5kZWYgc2NoZWRfcGFyYW0KPiAgNjIg
IyAgZW5kaWYKPiAgNjMgIyBlbmRpZgo+ICA2NCAjIGlmbmRlZiBTQ0hFRF9BVFRSX1NJWkVfVkVS
MAo+ICA2NSAjICBpbmNsdWRlIDxsaW51eC90eXBlcy5oPgo+ICA2NiAjICBkZWZpbmUgU0NIRURf
QVRUUl9TSVpFX1ZFUjAgNDgKPiAgNjcgIyAgZGVmaW5lIFNDSEVEX0FUVFJfU0laRV9WRVIxIDU2
Cj4gIDY4IHN0cnVjdCBzY2hlZF9hdHRyCj4gIDY5IHsKPiAgNzAgICBfX3UzMiBzaXplOwo+ICA3
MSAgIF9fdTMyIHNjaGVkX3BvbGljeTsKPiAgNzIgICBfX3U2NCBzY2hlZF9mbGFnczsKPiAgNzMg
ICBfX3MzMiBzY2hlZF9uaWNlOwo+ICA3NCAgIF9fdTMyIHNjaGVkX3ByaW9yaXR5Owo+ICA3NSAg
IF9fdTY0IHNjaGVkX3J1bnRpbWU7Cj4gIDc2ICAgX191NjQgc2NoZWRfZGVhZGxpbmU7Cj4gIDc3
ICAgX191NjQgc2NoZWRfcGVyaW9kOwo+ICA3OCAgIF9fdTMyIHNjaGVkX3V0aWxfbWluOwo+ICA3
OSAgIF9fdTMyIHNjaGVkX3V0aWxfbWF4Owo+ICA4MCAgIC8qIEFkZGl0aW9uYWwgZmllbGRzIG1h
eSBiZSBhZGRlZCBhdCB0aGUgZW5kLiAgKi8KPiAgODEgfTsKPiAgODIgIyBlbmRpZiAvKiAhU0NI
RURfQVRUUl9TSVpFX1ZFUjAgKi8KPiAKPiAKPiAjIGNhdCAvdXNyL2luY2x1ZGUvbGludXgvc2No
ZWQvdHlwZXMuaAo+IC4uLgo+IAo+ICNkZWZpbmUgU0NIRURfQVRUUl9TSVpFX1ZFUjAgNDggLyog
c2l6ZW9mIGZpcnN0IHB1Ymxpc2hlZCBzdHJ1Y3QgKi8KPiAjZGVmaW5lIFNDSEVEX0FUVFJfU0la
RV9WRVIxIDU2IC8qIGFkZDogdXRpbF97bWluLG1heH0gKi8KPiAKPiBzdHJ1Y3Qgc2NoZWRfYXR0
ciB7Cj4gX191MzIgc2l6ZTsKPiAKPiBfX3UzMiBzY2hlZF9wb2xpY3k7Cj4gX191NjQgc2NoZWRf
ZmxhZ3M7Cj4gCj4gLyogU0NIRURfTk9STUFMLCBTQ0hFRF9CQVRDSCAqLwo+IF9fczMyIHNjaGVk
X25pY2U7Cj4gCj4gLyogU0NIRURfRklGTywgU0NIRURfUlIgKi8KPiBfX3UzMiBzY2hlZF9wcmlv
cml0eTsKPiAKPiAvKiBTQ0hFRF9ERUFETElORSAqLwo+IF9fdTY0IHNjaGVkX3J1bnRpbWU7Cj4g
X191NjQgc2NoZWRfZGVhZGxpbmU7Cj4gX191NjQgc2NoZWRfcGVyaW9kOwo+IAo+IC8qIFV0aWxp
emF0aW9uIGhpbnRzICovCj4gX191MzIgc2NoZWRfdXRpbF9taW47Cj4gX191MzIgc2NoZWRfdXRp
bF9tYXg7Cj4gCj4gfTsKPiAKPiAKPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSB0ZXN0IHJl
c3VsdCBvbiBteSBjbGVhbiA5LjYgLS0tLS0tLS0tLS0tLS0tLS0tLS0KPiAKPiAjIGNhdCAvZXRj
L3JlZGhhdC1yZWxlYXNlCj4gUmVkIEhhdCBFbnRlcnByaXNlIExpbnV4IHJlbGVhc2UgOS42IChQ
bG93KQo+IAo+ICMgdW5hbWUgLXIKPiA1LjE0LjAtNTcwLjE3LjEuZWw5XzYueDg2XzY0Cj4gCj4g
IyBycG0gLXFmIC91c3IvaW5jbHVkZS9saW51eC9zY2hlZC90eXBlcy5oCj4ga2VybmVsLWhlYWRl
cnMtNS4xNC4wLTU3MC4xNy4xLmVsOV82Lng4Nl82NAo+IAo+ICMgcnBtIC1xZiAvdXNyL2luY2x1
ZGUvYml0cy9zY2hlZC5oCj4gZ2xpYmMtaGVhZGVycy0yLjM0LTE2OC5lbDlfNi4xNC54ODZfNjQK
PiAKPiAKPiAjIFY9MSBtYWtlCj4gZ2NjIC1JLi4vLi4vaW5jbHVkZSAtSS4uLy4uL2luY2x1ZGUg
LUkuLi8uLi9pbmNsdWRlL29sZC8gLVdmb3JtYXQKPiAtV2Vycm9yPWZvcm1hdC1zZWN1cml0eSAt
V2Vycm9yPWltcGxpY2l0LWZ1bmN0aW9uLWRlY2xhcmF0aW9uCj4gLVdlcnJvcj1yZXR1cm4tdHlw
ZSAtZm5vLWNvbW1vbiAtZyAtTzIgLWZuby1zdHJpY3QtYWxpYXNpbmcgLXBpcGUKPiAtV2FsbCAt
VyAtV29sZC1zdHlsZS1kZWZpbml0aW9uIC1zdGQ9Z251OTkgLURfR05VX1NPVVJDRSAtTC4uLy4u
L2xpYgo+IGN2ZS0yMDE3LTE2OTM5LmMgIC1sbHRwIC1vIGN2ZS0yMDE3LTE2OTM5Cj4gCj4gIyBl
Y2hvICQ/Cj4gMAo+IAoKCi0tIApDaHVjayBMZXZlcgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBo
dHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
