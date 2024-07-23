Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64D21C3DA63
	for <ltp@archiver.kernel.org>; Tue, 23 Jul 2024 17:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1721757372; h=message-id :
 date : to : references : in-reply-to : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=YIYuYSIn0j1uGGM8MWbrI9CvOlhM/P+1dQ8rvs80ncE=;
 b=gfr3290QKWolITmw2Y0t0WZxudZWlPGynyTnzib1R7d/aGdb2V5RvfdYyR+1IuFIbr2Jp
 bETeF/iUZkBQajldN8nAsErcsunZ4S86KA4Fv9d7mQ50r6aKxZLK5FCBn+lVxYRsbMcTar5
 fGaDRCCrL6WnoG06RWIGfEjmJLJrWLI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BCDC33D1C07
	for <ltp@archiver.kernel.org>; Tue, 23 Jul 2024 19:56:12 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A041A3C74E7
 for <ltp@lists.linux.it>; Tue, 23 Jul 2024 19:55:49 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=oracle.com (client-ip=205.220.165.32;
 helo=mx0a-00069f02.pphosted.com;
 envelope-from=samasth.norway.ananda@oracle.com; receiver=lists.linux.it)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 03BE6602282
 for <ltp@lists.linux.it>; Tue, 23 Jul 2024 19:55:43 +0200 (CEST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46NGQUxg021347;
 Tue, 23 Jul 2024 17:55:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=oO7bfyKFgzB98CxLewGQ6jBVXG2fzqUZFLgmJm36JIM=; b=
 RUjrA9/NBxqwxJ4jGr3IVhu3zmXHKK/6BHH5+5cwGEUOvTOgohKr8mYmjZQw9ruI
 /0tfqiPlWIh+TreqgF+3XPbpyXyjZTAxmyAdOnNOcB/fbb9ohhGSccdzckmHfNSo
 RofUusrpg4Y4kBdkV6Af4lJPmiaIZU/deExstNF5AbcOOijYIIlEJFxfzqbw1KGA
 NJ7ZUEa+Lsi6nEmne5J8rRfF0L3he1YVVIXGIaAbBnj0A5ijIeYwetMP8pK7Hf6q
 tIQ7dOq4RT0JsKr8JQ34mjGAtf0YNg5jxIr2bjABAyME2iwVaXtbiY39ByQI55pm
 2Z5HfOq7bgWgQxHHhz2bYA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40hfxpfeu7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Jul 2024 17:55:41 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46NGvSmr040073; Tue, 23 Jul 2024 17:55:40 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 40h26msuk4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Jul 2024 17:55:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oqG9GkG71I7Gf8b8JH0We44PwOcA8ku1gDI4TjmDaIzDIOJErdRV7ZGW9zQeDjrwvq39HEsgm+7MGyZxJeWuPwMHjRJqBG1GjC8JzQXwDbKNTWa8fy2MPqQB20CdVO5plG1QRVoIvUDHZm7MVbe7j+RHk+TDRY1C5V0xTaKP1ER9u95OhC/LHj3FKh4PIZnYP4cIpF0qwy8riQu5Z6SuAgh9IxQ/C/tnxY3/EHmed8/EWrH1XiRJx7PH4KREzpai+L0q7NlREI1qbLRdfPJCJoGric+5mKkjNoRphKRUJmMlSpl3gRb322KkfCEI/+QSg40G3StWczmPEojF9/FzbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oO7bfyKFgzB98CxLewGQ6jBVXG2fzqUZFLgmJm36JIM=;
 b=vR2Ml9cmKFECP76vfBkADEbkY91ROeAIPTs/Jm9xUArs+2H0wmpL0Jq+84e0+6hnf5kZ5NK33NCYCO3jG6tszj8oYc62OyPEtwovR86eg91npCtq3XOg6BV12MspXzFG2llW9fvPMxYr0BAdBgXD8iuojHwe4N4ZHc2+5nwngaDxt3rank7BgUHccub47cFrpaojUkiCA22bcbi3JDTH0X2lxC/ZjGKdgp9HqBgm8EiDu4Hv6dalo6OSEF5ylwN68GS8RIoqUUv2eUyX/ZM/QKMTtm5vzETIBTRYUfckRLW/O8UFEQgM8B2H+M6SdLztGwM5kJP7H02iw9OEhitncg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oO7bfyKFgzB98CxLewGQ6jBVXG2fzqUZFLgmJm36JIM=;
 b=Y1qyby5x3mpY/RzS4mqm6Kx31iZdZt1grkLgdgFvlV0utzciYkboULKVMWNSQxFZ9pfMELVLeouI6YQL6lpjUqu8n0CWgkwwG/lQNuAq9EpJ1ndLLV4uQLXasOW3Rrq7SayU55ikkcu+iKQ+6mKoGsN5FxKhSBbFUbau7oqIaek=
Received: from CY8PR10MB6707.namprd10.prod.outlook.com (2603:10b6:930:93::22)
 by CY8PR10MB6540.namprd10.prod.outlook.com (2603:10b6:930:58::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Tue, 23 Jul
 2024 17:55:38 +0000
Received: from CY8PR10MB6707.namprd10.prod.outlook.com
 ([fe80::ccf3:1df:e15d:7465]) by CY8PR10MB6707.namprd10.prod.outlook.com
 ([fe80::ccf3:1df:e15d:7465%6]) with mapi id 15.20.7784.015; Tue, 23 Jul 2024
 17:55:38 +0000
Message-ID: <0865e127-cd49-4d8a-b334-039f94b80e76@oracle.com>
Date: Tue, 23 Jul 2024 10:55:35 -0700
User-Agent: Mozilla Thunderbird
To: Li Wang <liwang@redhat.com>
References: <20240626010532.2845919-1-samasth.norway.ananda@oracle.com>
 <CAEemH2fskxgP9cFB-8zztts1qqtCJ2g01A=4+w6OxU6O_pE-9w@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAEemH2fskxgP9cFB-8zztts1qqtCJ2g01A=4+w6OxU6O_pE-9w@mail.gmail.com>
X-ClientProxiedBy: BYAPR11CA0091.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::32) To CY8PR10MB6707.namprd10.prod.outlook.com
 (2603:10b6:930:93::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB6707:EE_|CY8PR10MB6540:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d5689ca-468e-4b96-4c39-08dcab40a8ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U0VsZ0ZGeVc0U3NJTHhhMlhWN3d3ODk3blFUNkorc1dBSEJyV3p6R3NPREF3?=
 =?utf-8?B?TUpKWDhpNEJJeUFMRkN3VE9pSzh4N3ZMck9WZlIxVWxzWkZDb2V6YVRzbDFl?=
 =?utf-8?B?TTFvcy9OQ3o2T1JaK3JYK0Q3aDVMb016Nm0yYWhFK1hobUtFS2pnOHFHSGMy?=
 =?utf-8?B?NTJvUGxzVmgyRUFIcHVtSmJwQkRyMEtTT3V1ODNlUEQzbVIzcE5LR2tCSlMx?=
 =?utf-8?B?MjhGd09lN0xoQVNLd0xMdHBTWkRObFBkSGdyMkxVTFk1SEZUQ0JHNXNZcmZP?=
 =?utf-8?B?OE9WOHZnZWdycG9VcW1lRUpjaXlSMmovYWJzRFRlYXY4WDFlbE9BNWhTQlZ4?=
 =?utf-8?B?N2MyRkxMT0Zod1hDQXMxV1FnRzNNY2JiaFkreXZlRFkxUjRXRzNPall5VHhy?=
 =?utf-8?B?eklSbDBTUkVEQ1ZiV0pveUZJbWlTMFZvQnBHZE91V09LR0I1c3Njbk5LL0tM?=
 =?utf-8?B?cWlWQXR1eTc3NlVVSE1veFBkMEliSS9KN3FlMTc2TWVTMy81empUamJSclUx?=
 =?utf-8?B?VktleVY4Sjd1TytJYXByS3FiVnNuby9UVW9UZjJLNlRVR2xYUi9McTNYYnBE?=
 =?utf-8?B?S2hjSzhjbnY5ZkhXeWhqVjVKMHU1Tk1mQVpvRjdtNkF4ZEpTTFhmM2tXZVl1?=
 =?utf-8?B?UEJKcDJqbmxUS083R3lKc0hsTG5YdVdFYnhOb05vVWJxaHl0WDVDQ0ZIbkxJ?=
 =?utf-8?B?TkdVbDZXOTF1TS8zeTdDbEt5amtoU3d3cWphcmpPVXhsN09nMUc1UVhIenY1?=
 =?utf-8?B?UXh4YXBONEVaNE9qNE5jN0FtaWhrTWM5eVJLWC9JSldjMDFFMGZJNStFd1Ja?=
 =?utf-8?B?N08vaXJtM3Y3RkljdVlTUjBYMWlIZGdUS3RaVXNMMktJZWo3Ty84M0tPMnQ2?=
 =?utf-8?B?ZjFkTk95QkR1Ui9YYWluWEFDMmM3NER1QU5reGQxK3hoWkxweVY4VU9jZU15?=
 =?utf-8?B?Z3Vad1FJdmppQjU5d1lpL2lrdkN3RkFiWk9UN29INHhXZVY0RU1tQWdhVFVO?=
 =?utf-8?B?L212NnlHdEo0VWdnYmhRTUJlaFpETzFxcVRRNWpsdldNWVZXUjZCUXBKVWMz?=
 =?utf-8?B?cTM3Wkd6MFhnNmZBb2lhOVlmUzA5aW1OV1c0b1JISTVBVmpQVGt5SWJ1aC9T?=
 =?utf-8?B?dU5DYmMxc2ZGdFhoNi9pTXBUQlBhZ0phazZFSlA5YUswTmpab3c0NFA5TVli?=
 =?utf-8?B?c05jNFlTa0lqVjBEak5CS2cwQU9WUzFNNjRJWFBWZHhtT3Z2K3ExeEoxbDRk?=
 =?utf-8?B?WEwzcHQ5cUNDZ25LWVExcThycTFVelh3MHNEN2k3SmpPWGZaM3oxOThVbnRT?=
 =?utf-8?B?cGtOVE1JZk05VUhURjZCZjhoK1dkbXg3c0lsWms4c25MT1BpcytHR2xGSWVP?=
 =?utf-8?B?c0wrTHpaUUx0blJHUnQwOGVJdTZvTUNQbmM0SVRqcExPOHY2ZU1rZWlzeGRt?=
 =?utf-8?B?K1kvN1FqUnVUVDc0OUxDd1FveFJzVmtXZnVNcG9CaEJSSWVsZk1OMnNnSWZX?=
 =?utf-8?B?OFBtZUdBUUpjdkk1RDF2cDZVMG1tTFUxR2NUai9wODJta29BREpLU0dvWWZO?=
 =?utf-8?B?UGhNM1FqbSs1dTI4MThWTE9hUFZNZHhnVHV2aXpxNTZCQS90L01MOVdtZTcy?=
 =?utf-8?B?QXZuSGY4SWdiaUh5QWNsbVdDa3ZPaXBsYmoyS3FST01wMnZ2TkF5NERXNXhv?=
 =?utf-8?B?aldBZ2MzQm1GZVcvMFkvV09tMXowQzRqc0ZlUXUzTUpWbFREZEM2VW5pSHJJ?=
 =?utf-8?Q?dpwTqpiLCQTI+DwFZ8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR10MB6707.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFhib0svNTcyendJMGFMWVJ2eUJ6WlhSTCtEank4U3JjU1R3dHF1SGVGRDBj?=
 =?utf-8?B?dmNXZ1pLUE1QT3d0dVViN00wRHo2WStyT3RXK1FsNVZIZXhoUFhTZXhtRElm?=
 =?utf-8?B?dXExRWhCNVN3LzJJZnY1Nkc4R1FZL2xaSXcvM29PaVZta1dhelhCU3l4S2xW?=
 =?utf-8?B?ZVZYdmZhd09KOHVjNTAwZ25veEQ4WXNkSVpnRXZOd1J6TDk0MU9TYjhPb0py?=
 =?utf-8?B?ZDZQeEN4K2F5NjkrSWZpbTJZT0ZhWlFWTUZFMHVQS0NyMzJZRVhCWEhTVklz?=
 =?utf-8?B?M0JabmExcXBpajRlMVgyOTZ1VHpaYnlwL2RQUW9iVk1vNlIwaFl1Z1NwckM3?=
 =?utf-8?B?dnVhOW9nTzJYVlRyL1VwWjFvejRmcnk3dTJtL1ZrajV2bnlBdEx5TEsrZFFS?=
 =?utf-8?B?TFg3SDhlYTZnWXM2SmdPZVc5ZWk1OXc3aGw4QWRxMHY1SDExVVp5Y0xwUGMv?=
 =?utf-8?B?eHcxQmdtSVI1MlNDRS9IVVhKT1hMY0p4WU9GS01RL1FTUHRTWjVtMkVuL0dN?=
 =?utf-8?B?SFh3S3grVmRSUjZRRlNRdlVGUTB1YWVSUzN2UEowVDZ4aWZoVUlDcU85LzlC?=
 =?utf-8?B?V2xuSmlHOXJyMXJpelRFYUd5KzhjK2lLUktRbE1KN2hzZkJBZzJFMjVkM09x?=
 =?utf-8?B?UDdSZTZ0eDI2SWppMDFIaWE3cnppUkdWYmtnT2NtZ1M0OEJ2cXo0RTRTd2Rz?=
 =?utf-8?B?TnpoeHBHR2toTlM2OXJpZ29IRVhUdHBrV0YzR0lSVkJQTC9GQzJBVzBXTklY?=
 =?utf-8?B?L1hvdWh1bGRKMFdjU3c2R1Z4d056MjVDeCt0MUpWMTI5ZE5QcktyQ1A4NGxo?=
 =?utf-8?B?R3lrZWZidlhDNmlSR1VwZEZVK0g1YUU0Uk9TTlpnODFsalRxcEJTTE5WeSsx?=
 =?utf-8?B?U0RsZ2pRVnVDcmw3TXZTNllTdXJwOFVzcTM5a1NyTktGOXhhQ3BURC9HUUhh?=
 =?utf-8?B?RFQ0N0llWG9yU3FCRDlrNUdGbS84VmhhQnJWVlJjSDZrNEV6cWc2cVBJMTg4?=
 =?utf-8?B?a3hvWS8vQXNHNFJhNGtJNit4VlExZnBocmVGdk1Qd21QcVNYYUh6bXVMRzIx?=
 =?utf-8?B?YW5JMkJzMWJQeU9MUVRTSUtTOEdGeDQzaHVCQ3RBNnRlQjBKTFlmWkQxMUUv?=
 =?utf-8?B?ZkhaYUk1NnhnK0VXcEE5UDRUWXp4YTlhb2xzYjFJT3BDN2NhWktGSjFHaDAz?=
 =?utf-8?B?bTE0b1FjZW84UWU4QkF5ZlJxZ01RR09hMjNIeDRkdnVZYitBZm9LMHZxblNM?=
 =?utf-8?B?TFJrOGdCZmFmM3pkSWlUbjNYeko0VW1BdGlvRWpHTmwwUFBsZ1hoSnZ0RmJJ?=
 =?utf-8?B?K2c3eHhLelFCWkVoY05LN09TTVR1STF1SUpzSFp0RkVFQ3BaS2dzY3gxUGQ0?=
 =?utf-8?B?N0RpTHhVdERqK2JxdkJZZVU1TFdqcUdMYnZyMGZTNW5HWHE1c1JyUjdDclZ2?=
 =?utf-8?B?N0EwNGw1eXI1bEp1ZlBIWU1yemdDOUhFYTllN05Ud0ROa05sYnJ3anZ5bHZG?=
 =?utf-8?B?RHhPTE40cDdzVVh2QW16T0JrOUlKOXVzOVJwcXQ4ZXRjcHp6bElWaU8yUDRP?=
 =?utf-8?B?RTEwalRvU2lzcXBTOFF3YjQrdEhDdGluT24xRzNTRXZqeHpEMHVORzJheXUz?=
 =?utf-8?B?VUFaa0dab3haN3QzaG1HOWovc2FlV1dOKzVXRDdZeGlYbmZrMXpVSGJxNDB6?=
 =?utf-8?B?WEw2QmQ1V01yOUN6SGxkYUVRMkNaa3FvZ0dLY3FCQ0xXTENocUJsbm55MDBa?=
 =?utf-8?B?bWN6NVFBd3dQdTZtQkhDRFVBMktEdThXUWhVTGhLRmZYTzFweFJVc0NWNUQr?=
 =?utf-8?B?NFFQbmNiY3JSZVRHY2tDb3A1RHhDZ1FMRFBBeGQzSkFrLzYvRDM5NjFGb014?=
 =?utf-8?B?QnBDbUxBZkdlb251ZmRUeitJaDJCczk5ckV5WDB0cy9aUDFWay8yeFJzWXlZ?=
 =?utf-8?B?OVV0UmI2bGQ2amFNY0N2aXN0YzJYZE1qT1k2UUlBQWpnVGNEdVNPOHF1djNp?=
 =?utf-8?B?cUhOYnk2MEwxNkdPQ2tCaWRham9qQzB4bW1rbjFEem84N1BBaDl6cFdWMnlh?=
 =?utf-8?B?MFA1cUp3L2lIZXFXZWFEWGNvSi92cnIwcDUvcjVybERyRHVKVlBaQldzcmxu?=
 =?utf-8?B?cThTS0dWKzZINTRyTHpNTGtUL1FsNnIvVHJFZmJJTWxJeC9ZMHNGSkFkcWxU?=
 =?utf-8?B?Znc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 3mNNwaWX3TsxVWGA7SunKx9/glsQM0J218Y3A+MeaXcocl4d649pxCJTjJar9RcXdgC+W8sDG+wF0Y328ZpRxPML4ccNrDDqVeJUajxwi4VezjfUOpNbkSmWsZZmm8C9pSV6lAjP0PLOpNoaapNq0a9zFOSlQ6f4DnlRv78sYx3X4jr+0DcdmPaSBMZtN6htw8u5f070MQIJTDH7Iv1lP1/Z8zHKE7Wp/gG7gqccGFcGGoEKaSygk7+1pb6dwaZbONckq0Ixwn/es7XZXgU93R+66XaTeJqwzFW+wQq4YLnS6AfUr5VagLHg9SZ8v+lCnSBhfqJ7ZgGQutrwc+PuCIbw72rHpCG7Al1MlVMd6cZh9/2zSFk1Ha+MOVEC88Cu2pgjiEV65mr8uBQXThoqLQYXlhhS9bKw6h2fX+oqdh8zh9MXd+cAx12LcOAusKxgEQpxntV3j9ArP+0uVC740hCSUTX7HhQ6B0REHFPXzZctl0a0SQa3uKQqrJW8TVPBkBOOWXFVHGwesrziyMfLI95pOsjzuxzij7s8xDue6HHvPPLh1f1i2KLutkRsuzZbKy07JYiB2kwDmxPmffo4QDfodLjfNCj1o2npZISF510=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d5689ca-468e-4b96-4c39-08dcab40a8ad
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB6707.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2024 17:55:37.7331 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vG/EtEax7FTp1YuNGH24ggAdjcVepqDvV6hPTqb0YPCsS0aSqqC2jufHdIp4FOFG/TBVXkTLPOyA6pa4NRyh6F7a4pUaTrcUC+3yAxiMgRCSUNbouqMC1tzxSXGXzpCb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6540
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-23_07,2024-07-23_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407230123
X-Proofpoint-GUID: npIqyxPIw9-auGzlHGIL_ZfA8T1HvbKc
X-Proofpoint-ORIG-GUID: npIqyxPIw9-auGzlHGIL_ZfA8T1HvbKc
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [External] : Re: [PATCH] fallocate03:
 FALLOC_FL_PUNCH_HOLE must be used with FALLOC_FL_KEEP_SIZE
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
From: Samasth via ltp <ltp@lists.linux.it>
Reply-To: samasth.norway.ananda@oracle.com
Cc: ltp@lists.linux.it
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

CgpPbiA3LzQvMjQgMTI6NTMgQU0sIExpIFdhbmcgd3JvdGU6Cj4gSGkgU2FtYXN0aCwKPiAKPiBT
b3JyecKgZm9yIHRoZSBsYXRlIHJlcGx5LCBiYXNlIG9uIHlvdXIgdGVzdCBmYWlsdXJlLCB3aGlj
aCBrZXJuZWwgCj4gdmVyc2lvbiBhbmQKPiBGUy10eXBlIGRpZCB5b3UgdXNlPwo+IAoKTGksIEkg
YW0gdXNpbmcgdGhlIHY2LjEwIGtlcm5lbCBhbmQgdGhlIEZTLXR5cGUgaXMgbmZzdmVycz00LjIu
IFRoZSAKZmFsbG9jYXRlKCkgY2FsbCBpcyBvbmx5IHN1cHBvcnRlZCBvdmVyIE5GU3Y0LjIgYW5k
IHNob3VsZCBzaG93IGEgcHJvcGVyIAptZXNzYWdlIHdoZW4gcnVuIG92ZXIgTkZTdjQuMSBvciBi
ZWxvdy4KClRoZSBvdXRwdXQgSSBnZXQgb24gTkZTdjQuMiBpcwoKPDw8dGVzdF9vdXRwdXQ+Pj4K
aW5jcmVtZW50aW5nIHN0b3AKdHN0X3Rlc3QuYzoxNzMzOiBUSU5GTzogTFRQIHZlcnNpb246IDIw
MjIwMTIxLTE5NjMtZzgzMGE3MDVkNgp0c3RfdGVzdC5jOjE2MTc6IFRJTkZPOiBUaW1lb3V0IHBl
ciBydW4gaXMgMGggMDBtIDMwcwpmYWxsb2NhdGUwMy5jOjgzOiBUUEFTUzogZmFsbG9jYXRlKGZk
LCBERUZBVUxUX01PREUsIDIwOTcxNTIsIDEwNDg1NzYpIApwYXNzZWQKZmFsbG9jYXRlMDMuYzo4
MzogVFBBU1M6IGZhbGxvY2F0ZShmZCwgREVGQVVMVF9NT0RFLCAxMjU4MjkxMiwgMTA0ODU3Nikg
CnBhc3NlZApmYWxsb2NhdGUwMy5jOjgzOiBUUEFTUzogZmFsbG9jYXRlKGZkLCBERUZBVUxUX01P
REUsIDE3ODI1NzkyLCAxMDQ4NTc2KSAKcGFzc2VkCmZhbGxvY2F0ZTAzLmM6ODM6IFRQQVNTOiBm
YWxsb2NhdGUoZmQsIERFRkFVTFRfTU9ERSwgMjYyMTQ0MDAsIDEwNDg1NzYpIApwYXNzZWQKZmFs
bG9jYXRlMDMuYzo4MzogVEZBSUw6IGZhbGxvY2F0ZShmZCwgRkFMTE9DX0ZMX0tFRVBfU0laRSwg
MjA5NzE1MiwgCjEwNDg1NzYpIGZhaWxlZDogRU9QTk9UU1VQUCAoOTUpCmZhbGxvY2F0ZTAzLmM6
ODM6IFRGQUlMOiBmYWxsb2NhdGUoZmQsIEZBTExPQ19GTF9LRUVQX1NJWkUsIDEyNTgyOTEyLCAK
MTA0ODU3NikgZmFpbGVkOiBFT1BOT1RTVVBQICg5NSkKZmFsbG9jYXRlMDMuYzo4MzogVEZBSUw6
IGZhbGxvY2F0ZShmZCwgRkFMTE9DX0ZMX0tFRVBfU0laRSwgMTk5MjI5NDQsIAoxMDQ4NTc2KSBm
YWlsZWQ6IEVPUE5PVFNVUFAgKDk1KQpmYWxsb2NhdGUwMy5jOjgzOiBURkFJTDogZmFsbG9jYXRl
KGZkLCBGQUxMT0NfRkxfS0VFUF9TSVpFLCAyNzI2Mjk3NiwgCjEwNDg1NzYpIGZhaWxlZDogRU9Q
Tk9UU1VQUCAoOTUpCgpTdW1tYXJ5OgpwYXNzZWQgICA0CmZhaWxlZCAgIDQKYnJva2VuICAgMApz
a2lwcGVkICAwCndhcm5pbmdzIDAKCldoZW4gSSBydW4gaXQgb24gTkZTdjQuMSBvciBiZWxvdyBh
bGwgdGhlIHRlc3RzIGZhaWwgd2l0aCBFT1BOT1RTVVBQLgoKPiAgRnJvbSB0aGUgZmFsbG9jYXRl
KCkgbWFudWFsLCBJIHNlZSB0aGF0Ogo+ICJUaGUgRkFMTE9DX0ZMX1BVTkNIX0hPTEUgZmxhZyBt
dXN0IGJlIE9SZWQgd2l0aEZBTExPQ19GTF9LRUVQX1NJWkUgaW4gbW9kZSIKPiAKPiBCdXQgaXQg
ZG9lc24ndCBtZWFuIHdlIHdvdWxkbid0IHVzZSBGQUxMT0NfRkxfS0VFUF9TSVpFIHNpbmdseSBp
biB0aGlzIHRlc3QuCgpPaCBva2F5LiBTb3JyeSBtaXN0b29rIHRoYXQuCgpUaGFua3MsClNhbWFz
dGguCgo+IAo+IAo+IAo+IE9uIFdlZCwgSnVuIDI2LCAyMDI0IGF0IDk6MDbigK9BTSBTYW1hc3Ro
IE5vcndheSBBbmFuZGEgdmlhIGx0cCAKPiA8bHRwQGxpc3RzLmxpbnV4Lml0IDxtYWlsdG86bHRw
QGxpc3RzLmxpbnV4Lml0Pj4gd3JvdGU6Cj4gCj4gICAgIFRoZSBmYWxsb2NhdGUwMyBsdHAgdGVz
dCBmYWlscyB3aXRoICJmYWlsZWQ6IEVPUE5PVFNVUFAiIGlmIHdlIGp1c3QgdXNlCj4gICAgIEZB
TExPQ19GTF9LRUVQX1NJWkUgZm9yIHRoZSBtb2RlIGluc3RlYWQgb2YgT1JpbmcgaXQgd2l0aAo+
ICAgICBGQUxMT0NfRkxfUFVOQ0hfSE9MRS4KPiAKPiAgICAgU2lnbmVkLW9mZi1ieTogU2FtYXN0
aCBOb3J3YXkgQW5hbmRhCj4gICAgIDxzYW1hc3RoLm5vcndheS5hbmFuZGFAb3JhY2xlLmNvbQo+
ICAgICA8bWFpbHRvOnNhbWFzdGgubm9yd2F5LmFuYW5kYUBvcmFjbGUuY29tPj4KPiAgICAgLS0t
Cj4gICAgICDCoHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZmFsbG9jYXRlL2ZhbGxvY2F0ZTAz
LmMgfCAxMCArKysrKy0tLS0tCj4gICAgICDCoDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMo
KyksIDUgZGVsZXRpb25zKC0pCj4gCj4gICAgIGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVs
L3N5c2NhbGxzL2ZhbGxvY2F0ZS9mYWxsb2NhdGUwMy5jCj4gICAgIGIvdGVzdGNhc2VzL2tlcm5l
bC9zeXNjYWxscy9mYWxsb2NhdGUvZmFsbG9jYXRlMDMuYwo+ICAgICBpbmRleCBiM2U2YjM4MTcu
LjIwY2UxM2NkNCAxMDA2NDQKPiAgICAgLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9m
YWxsb2NhdGUvZmFsbG9jYXRlMDMuYwo+ICAgICArKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2Nh
bGxzL2ZhbGxvY2F0ZS9mYWxsb2NhdGUwMy5jCj4gICAgIEBAIC0zMCwxMCArMzAsMTAgQEAgc3Rh
dGljIHN0cnVjdCB0ZXN0X2Nhc2Ugewo+ICAgICAgwqAgwqAgwqAgwqAge0RFRkFVTFRfTU9ERSwg
QkxPQ0tTX1dSSVRURU59LAo+ICAgICAgwqAgwqAgwqAgwqAge0RFRkFVTFRfTU9ERSwgQkxPQ0tT
X1dSSVRURU4gKyBIT0xFX1NJWkVfSU5fQkxPQ0tTIC8gMiAtIDF9LAo+ICAgICAgwqAgwqAgwqAg
wqAge0RFRkFVTFRfTU9ERSwgQkxPQ0tTX1dSSVRURU4gKyBIT0xFX1NJWkVfSU5fQkxPQ0tTICsg
MX0sCj4gICAgIC3CoCDCoCDCoCDCoHtGQUxMT0NfRkxfS0VFUF9TSVpFLCAyfSwKPiAgICAgLcKg
IMKgIMKgIMKge0ZBTExPQ19GTF9LRUVQX1NJWkUsIEJMT0NLU19XUklUVEVOfSwKPiAgICAgLcKg
IMKgIMKgIMKge0ZBTExPQ19GTF9LRUVQX1NJWkUsIEJMT0NLU19XUklUVEVOICsgSE9MRV9TSVpF
X0lOX0JMT0NLUyAvCj4gICAgIDIgKyAxfSwKPiAgICAgLcKgIMKgIMKgIMKge0ZBTExPQ19GTF9L
RUVQX1NJWkUsIEJMT0NLU19XUklUVEVOICsgSE9MRV9TSVpFX0lOX0JMT0NLUyArIDJ9Cj4gICAg
ICvCoCDCoCDCoCDCoHtGQUxMT0NfRkxfS0VFUF9TSVpFIHwgRkFMTE9DX0ZMX1BVTkNIX0hPTEUs
IDJ9LAo+ICAgICArwqAgwqAgwqAgwqB7RkFMTE9DX0ZMX0tFRVBfU0laRSB8IEZBTExPQ19GTF9Q
VU5DSF9IT0xFLCBCTE9DS1NfV1JJVFRFTn0sCj4gICAgICvCoCDCoCDCoCDCoHtGQUxMT0NfRkxf
S0VFUF9TSVpFIHwgRkFMTE9DX0ZMX1BVTkNIX0hPTEUsIEJMT0NLU19XUklUVEVOCj4gICAgICsg
SE9MRV9TSVpFX0lOX0JMT0NLUyAvIDIgKyAxfSwKPiAgICAgK8KgIMKgIMKgIMKge0ZBTExPQ19G
TF9LRUVQX1NJWkUgfCBGQUxMT0NfRkxfUFVOQ0hfSE9MRSwgQkxPQ0tTX1dSSVRURU4KPiAgICAg
KyBIT0xFX1NJWkVfSU5fQkxPQ0tTICsgMn0KPiAgICAgIMKgfTsKPiAKPiAgICAgIMKgc3RhdGlj
IGludCBibG9ja19zaXplOwo+ICAgICBAQCAtODIsNyArODIsNyBAQCBzdGF0aWMgdm9pZCB2ZXJp
ZnlfZmFsbG9jYXRlKHVuc2lnbmVkIGludCBucikKPiAgICAgIMKgIMKgIMKgIMKgIFRTVF9FWFBf
UEFTUygKPiAgICAgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGZhbGxvY2F0ZShmZCwgdGMtPm1v
ZGUsIHRjLT5vZmZzZXQgKiBibG9ja19zaXplLAo+ICAgICBibG9ja19zaXplKSwKPiAgICAgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgICJmYWxsb2NhdGUoZmQsICVzLCAlbGQsICVkKSIsCj4gICAg
IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHRjLT5tb2RlID8gIkZBTExPQ19GTF9LRUVQX1NJWkUi
IDogIkRFRkFVTFRfTU9ERSIsCj4gICAgICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHRjLT5tb2Rl
ID8gIkZBTExPQ19GTF9LRUVQX1NJWkUgfAo+ICAgICBGQUxMT0NfRkxfUFVOQ0hfSE9MRSIgOiAi
REVGQVVMVF9NT0RFIiwKPiAgICAgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHRjLT5vZmZzZXQg
KiBibG9ja19zaXplLCBibG9ja19zaXplKTsKPiAgICAgIMKgfQo+IAo+ICAgICAtLSAKPiAgICAg
Mi40NS4yCj4gCj4gCj4gICAgIC0tIAo+ICAgICBNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9s
aXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAKPiAgICAgPGh0dHBzOi8vdXJsZGVmZW5zZS5jb20v
djMvX19odHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cF9fOyEhQUNXVjVOOU0yUlY5
OWhRIUltVVJDdjdiWF9ONGNIRVE2MHlIZ01MME5CSXFZY2pQZEpONEtvdDRJYTZvOXJCYjJUd2Vk
d3lSMFExV3laLUktTkNqWHlhZl9pLUZlLUwyaDVPN21mNCQ+Cj4gCj4gCj4gCj4gLS0gCj4gUmVn
YXJkcywKPiBMaSBXYW5nCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGlu
dXguaXQvbGlzdGluZm8vbHRwCg==
