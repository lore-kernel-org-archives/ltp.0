Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84F38C83F1A
	for <ltp@archiver.kernel.org>; Mon, 14 Jul 2025 16:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1752511855; h=message-id :
 date : to : references : in-reply-to : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=2UcYA8MFN2qWX8V6SQ00we/QuIJTEHJf357gz1ED6fY=;
 b=ezM/xuU9r2X+ToXYFN/5tJEfq6GbezU71ayp+hG6SfUo8f/n8dsHkxXe7dz86WmxgSeKG
 UV30L2ps8XkEMLxAfbkDHARgjwh/PIM3omH7UBtXIPAvrq/drpYzdiFxX0hXYtbYH1LoL82
 JkBfKOFz/BTkwJuniWGUID2W6eyGlGQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9CF373CBB00
	for <ltp@archiver.kernel.org>; Mon, 14 Jul 2025 18:50:55 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B63BB3C03F4
 for <ltp@lists.linux.it>; Mon, 14 Jul 2025 18:50:34 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2072d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::72d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits)
 server-digest SHA256) (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 329B220033E
 for <ltp@lists.linux.it>; Mon, 14 Jul 2025 18:50:33 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fouprkv3EqJ8TCGFFdnyv4rwGoVA6eKEo7hLiQGt54Zf3qQETy2tmmZKCXTtGGaUEiZacvaTOfjNjVOScB5sZp9wSKqmA9lXMAGqJF2slOmXeGd72naCMy4iOnISqHYW7KaWQUGuZzWxr5vXDacMA70GleMUlxg/F/t/lloeQUks6vidKTJ1CBS3oOD44ct7LSiUKsg5ZX7yoS478FuM9x2QTsKrXxX0k7KEM+skpHjF+ZNAOd1QVS5CyPw1rWaTxA+GhdpE1qOqFWhB/1jSzjPp5OniP9hqaIpOF+ifnVcW96MVGY8ux+gNmBkE6ieLQiHf7VDH6Gvi/trvU9ICTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h2ujtLsZqnUUPdsbEjde5/MfT1PXtogmH271A4Z5eHM=;
 b=SetS/DhttJW2qNMSjZ+rD+y/dqtKLFJ45aogpe5d+zb/BER/aoNtCJb37Q/S1pHMGFr5CJ8ycgBkI/K+g9PiQvKZC8IlLtaMxmOdJJwE4/XmbIY2sFyakVKtue9yljQ3Yx/iWsDAYkRYCfW2NGeMthBDhgWd1T5KbtTbuOjHuAIQQI//Su9U/nXNCm5Jj3hi+TepGSxtPWlQdmldoXMclT1+FowM+b9PlERNHuhB8Dz66qNn5lG3epNa7XP6Jt2e/QmVuK7ag+cLJc58bFuWS7bTntNCKd9fMGzd1FzDVf4OMOt76FjCdLeaiSVzRSR0O4JHIWpwCCVyIVtB56XlrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=codasip.com; dmarc=pass action=none header.from=codasip.com;
 dkim=pass header.d=codasip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codasip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h2ujtLsZqnUUPdsbEjde5/MfT1PXtogmH271A4Z5eHM=;
 b=aa9kFQyvXrkLOYzbBrr0soqKnjBZw95U9SQ/T01dDzIuw0P3S2232uB4Nkjdg5scl5bLuRjRk3hl9AZ42WRbfTOGPUwrCYLBOqbBE1Xx/8CH28mC/nimdJcgaCgxiJ1owbRlDwvOUVQHnMrR2SUhTkgmqj6aGQHYb6bjf22f4b+UOUzghJRScSQe4+Z5KMpdSbc33lUHLf0FX3R16KM0XHoDKcKve9YNtxtSDeDWAVcI8XAeXGjPN+GZVb5mZ/1MWBmy3OIh6OudBIVE+/Fziomwi2VODBY+xnoVD5NaudzGq+15aIhwe043+92UcJWv28fyiqL/sQyFUOJsvA3mLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=codasip.com;
Received: from AM9P192MB0983.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1f4::5)
 by VI2P192MB2294.EURP192.PROD.OUTLOOK.COM (2603:10a6:800:227::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Mon, 14 Jul
 2025 16:50:30 +0000
Received: from AM9P192MB0983.EURP192.PROD.OUTLOOK.COM
 ([fe80::dda0:cbaf:a692:8443]) by AM9P192MB0983.EURP192.PROD.OUTLOOK.COM
 ([fe80::dda0:cbaf:a692:8443%5]) with mapi id 15.20.8943.012; Mon, 14 Jul 2025
 16:50:30 +0000
Message-ID: <dcbaf88b-2d51-45b5-869f-5234d3fab4df@codasip.com>
Date: Mon, 14 Jul 2025 18:50:28 +0200
User-Agent: Mozilla Thunderbird
To: Wei Gao <wegao@suse.com>
References: <dbaa90bc-9f35-48f6-9072-0ab2b23dd6b9@codasip.com>
 <aHWsnL8bUYkTJt21@MiWiFi-CR6608-srv>
Content-Language: en-US
In-Reply-To: <aHWsnL8bUYkTJt21@MiWiFi-CR6608-srv>
X-ClientProxiedBy: FR4P281CA0264.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::18) To AM9P192MB0983.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f4::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9P192MB0983:EE_|VI2P192MB2294:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a50ca7b-c8d0-4c46-6a31-08ddc2f68a9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|10070799003|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WVNma2VkM2tueTNuSmx5aWhOQkpWQmxNQ0xQQkUwOGJ0eDUxREF1SW5JeTY4?=
 =?utf-8?B?SVZudFF3cHFIeU11dWRjcVJLVm9JL1JoNDAraHoxVllLTFpkdzhsdWZiYWdj?=
 =?utf-8?B?WU0rbUpRNHg4cERxMmRwMnNWazNjbUk3aDFnMW1HbkpmUHA2emVDdlpUUG1o?=
 =?utf-8?B?eVdZWTJxZ0pIYkg3S2JJQTVYeUJSS1RwTU95aU1NcHFvZ1VLNVdrVnU0K0Jz?=
 =?utf-8?B?aWd5QmxaM3A4dE5nTkZJQmgySHlub2xodGFVTXR4YzBTaGFDTUhENlg1WTJn?=
 =?utf-8?B?ZkxnRWRBZ3hxU2pQemJYbkxKa05XRXpCRmdudW1KUDZIY1ExYmgxVmdpT3B4?=
 =?utf-8?B?aVNaZmV3aXFKbzdYVUZ0MCtQRmJCRXV2azFKeGR0QWxxUFQyQnozK01OYTFh?=
 =?utf-8?B?VWJNQmp3RDE2Z1FVcXFsQWdOaUY3NU9pZ1FPa1hWVWJaWjVNYklEQjFlaGVl?=
 =?utf-8?B?R3pVUG55QzhoWnEvNHk2VVYrVHEwdEdheTMxVEpRL3p2Wk5TeHo3YU1mSXNJ?=
 =?utf-8?B?L205YmhwbENTWTk0aTlZcklDZkhGWDJSNGI5UlNHb2FQMVVzTG0rQU1ibTc1?=
 =?utf-8?B?TGZqZFcyNUw2dyt6cGxlVkgzMmpmVVYyVTRvNlI1VUJZNHNXKzFidGoxQ0Nx?=
 =?utf-8?B?MCs3VHNRenhnVTMxMU0vd2NpWHhRSml0T3k2YVYxd1orM1NLMFBtc1hGckVE?=
 =?utf-8?B?RDF3Zis1OXdCMEptdVZDWDFVU2U1OWM3eFZnNThueTRUODh6Q2MxTjcyWmFp?=
 =?utf-8?B?TFFZVlFBdS9iaENFRUtuUEhOdWpobDFmc1U1ZHhEaDJRU0FrNVZQL2pkbWRC?=
 =?utf-8?B?SmppcWtrTmdQWnVyemh6NGtvcFlIdDBSU3h2VTdwdnJudGVMU3gvNEFZQ0tk?=
 =?utf-8?B?S3dFYnNIcE82RHFyT1d3MUZwaXJ5NU9GbDJ2dmplT0llckJYc29GVFJ4bi9j?=
 =?utf-8?B?TFU0L1VtdlFqeXg3Y2J6a1NEUDU4aXhKTlZqNFR0UWVjN05MS2VNMkNkSUhG?=
 =?utf-8?B?L2taWkZCRm1XWmdEdmd0Z0J5eG9BME1LYWl0Z3V3eTAvbHdjbUhaTEpWYzN6?=
 =?utf-8?B?d002TU9WUnhReGJOUVBSM2lsWHVWdy9IV2ozcWlrNUxKZjdRM0lyaU82UzU1?=
 =?utf-8?B?eDRiVU9UZUl6LzcxbmN3a3ROYW9sZjNFTGJvU3ptUjI0TjBjTWFYdjNGY1VT?=
 =?utf-8?B?T2tyT0hkNndhWk1lUEhrWVZyUi9MV0FxRVB4MVpkVWZ1OHpxb1FROWR4Z2lx?=
 =?utf-8?B?UEU1OWUwUEZXbk1zemp5ZVgvd1B1Vm16RTJIM2d0NzZjZ240THA4c2srZ1lM?=
 =?utf-8?B?TkxPWUhzTWFSVlVVUVkrUGhpUG9mb3NEOHVhOUNiR0lDaUI5YUh5TmJtUXlR?=
 =?utf-8?B?TUZWTEo0S2l5dWR3SkJsQTJFRk00YzJVSGQxZFNrMnNBRWd1MEtOYnVxYlFC?=
 =?utf-8?B?Z1g3STRGRjdwcXRXUUJxS1ZkMS9wKzQyeGhackN0aWtEeHJ3R1dVcWc2cTly?=
 =?utf-8?B?ZEdmZ1NSd2E0OUsybms1Sk00b2w1Ulc0OTZ1R0M4bHRtcktBYlFRSjFCOUE2?=
 =?utf-8?B?WGt1Zjh1WnU5UFRhNm5Hb0lQOTBiZ2NFYm9FK1ZlYUlOVllSajRIYnA3NlRh?=
 =?utf-8?B?TDAxT1hzZk1KRUV1T0I5UWtwWkFPSlNkYW1CNDBqSC9LUlU3dlA3YWhFVmFq?=
 =?utf-8?B?aDUyQVFnZFhGbHZwaE0vRnJGemxleFFsbHcrSGFhak5oTXJhYm1IZCtzRnlG?=
 =?utf-8?B?MTRuVUYzWVhZRFFFK3Ywb3JpeHJXaDhVVVd6dHBHbkxqeU8yRklxbG0rS0Zh?=
 =?utf-8?B?YVN2aTZJbGpnN0tac3liRmRNcjZld3YwcEtWNVAraE93em03czU3SGtKL0pM?=
 =?utf-8?B?WGd1Slp0a2E4emxOZ2JMK21ncEtBSiswdS9JZ1hnT0JydUFVMU91Ym51cDhK?=
 =?utf-8?Q?BdjkPOTyoAg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9P192MB0983.EURP192.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(7053199007); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QlBXVmZQU3JxN3RHYXZGUGFmYStDUW5Pc3p4Rk8xZ2U0cUp1N1p6TnY5cDZW?=
 =?utf-8?B?Tm9jT0FHNFJZSytQRExRb0QybStjQkozS2w4TWxNUS9tRjBLbkdnK1NINjJ1?=
 =?utf-8?B?TXVkdEZHWURoejBHMmRQY3ZCQjRBa1VwV1NVMHo3UzNvYSswZ0ZiQVByTHRW?=
 =?utf-8?B?RnA2RmIzbTM1cFliVnFYT0NXMkxadm5acEsvVkp2MEtCVllUVE5xRW10bmNZ?=
 =?utf-8?B?eUpvb2ovM29zR0tNOCtHZWtsR212YTk5Y0lGTHk5bmZBUm0xN25oVHg0a0Fp?=
 =?utf-8?B?WG5sczloNk4zeForVGNBSFc5Sk1teUd3ZmNtbjRBNjdXdGExYWIyalRkWGhX?=
 =?utf-8?B?MHpMYUFOcmwra1hub3VJVGkvTThvUkJVVHJXQXFtMm8xWEt2K1BFMkcwVERB?=
 =?utf-8?B?TGM2RmJoYWxaajM1ZnZ2aWRqZDFacXdrVEFuNlVXb3B4RzViV1pHNTFsUG1J?=
 =?utf-8?B?dUZ4S3NiQWQvVnQrY1BWUHNBRnBEc1N5ZlRvemt5T3JqZng4d05tQnVRQ21E?=
 =?utf-8?B?YXNrYnQ1a0FHTHdBMXJ2Slp2MXpFQXlHcjEveUFiKzdnZmZJeXNEd2ZmZnA1?=
 =?utf-8?B?R0RLcXFXOWE2bytJMUxtTHhvZmxVeVJ5OHFlcmtEYjNCc1hzWGpEYzd1TnMr?=
 =?utf-8?B?a1U2L0Z1eDhOMGtJNmFGOWZEbEdGa2hkdEphVzh5T3VyRDlOblF3aEQ0Z0Zy?=
 =?utf-8?B?dS80c2RZK214RklpSnI1MGNoQ1lwd25OZFRRVWpIdGR6VXJJdkFFSXJCelVV?=
 =?utf-8?B?L1MwazZnUTI4MWJmL1NHQXVRWEs2OHA2enlHa1FPcGR6KzVWQ0FnSHg3WG9z?=
 =?utf-8?B?cUR2N1FEemdzNXkxRHhlNHVJUEdKSkdTT1F2OGZsSW4xMk9DOE5BNDBMMzI1?=
 =?utf-8?B?eEIvZXFkRGNMQnBKU2hualJxaVR2WnNpdU9pVi9keDh1Tmd5eG0zblBjKy9k?=
 =?utf-8?B?MExVSjVhdUQwVkxqSzF5dGNuTTJlMlNFdTBpa2J2N29XM1gzUWtzVzhxaEFH?=
 =?utf-8?B?S1UwblZ1WGhyUnlONzl4bEMybFRzeUxlYWNKRHhua1RRVHdwaWF4djVXK1Zy?=
 =?utf-8?B?dGVDTzJLR3dIeVNKak4zVGZOSGYwVkJFdGpyamZMOVZieU9iVnhNRFJ2UHJo?=
 =?utf-8?B?OWhkUEU3Z0VVNUYyai9jSU1nRWRMMWdxMTNJajc4YXY5d3VsWEoyNTBJTVFz?=
 =?utf-8?B?c2NqREMxdGx3WVFwdFdrYXo0L25QZDNmakJmNm5QRWdGbHhhb3JQVE9KK3VR?=
 =?utf-8?B?OUF2K0c4MWJuNDV2WTQ0MmRmUUlmT1ZDMHpTRmkzaFBHTzBaWUhtSlQxa1hF?=
 =?utf-8?B?Q3o0bGdVT3hZY0ozcm4yRVlJYnVEUHVib09jNXRIMXVKS0xhQ2tTQVREMEhp?=
 =?utf-8?B?eXNyTlpjZFV6T0lZVk1lbVM5Yy85REFFcWRaOXlzSXc4WTZGbldqU0kyd2FK?=
 =?utf-8?B?NXNjV2lYSU9WUXdheFlvYkptNnYxN1EzejY4WlB0TDRwM1ZxQWY2R0FmY1Jh?=
 =?utf-8?B?OTBJQnBFY0VPUDZuVlhGNXBNakNpbHVVbGZIR2dDRy9UNXFFb0Ixb21XRmM2?=
 =?utf-8?B?RXU1NnJzbHdhNTh5NGxkaFB2Ty9uL2o3UWpFVTI5K05yeGF5TEROdTh0OFdp?=
 =?utf-8?B?eGRFalc3NjdwaUpjOUhJZkxvbWQrQ2FxallTbUN4YVJhVFlibkgwYzBOUDdl?=
 =?utf-8?B?L1VjVnc0Y1pKaFhDSThwMi9VWXBqQ01wMGFsVWJoY1ZJV2R2amp6VXQ5Nmxz?=
 =?utf-8?B?bVpjcTFNejMwUStwOCtKWktxZWdOVG95T1NKcWtxVy9DODJzdG1Zb1lPaXFx?=
 =?utf-8?B?bHZQeGVIVW95cjZVejdJNUFDaDdsODVGVVFjcGFMQXRTMXFEelFWbUM5U3lO?=
 =?utf-8?B?WGFKblFxakN1UitGRzE3SFFtck1rSmF6WXZWa1VITnVDaUYrYmIwUGZma3hN?=
 =?utf-8?B?UHRoZTh0SHVzd1owNVdZTEVoVFNuR1JsWlpZY01wb3pydUFXdjA2V3JGQnl3?=
 =?utf-8?B?UlVtTE5ONTdzeE1nTzFRS0cyTXhKWWVONHlROUFxZ0EwNW9RQ1hTOXBwRlg1?=
 =?utf-8?B?MkY0QWNUSmMxYUhBNThPUUZraHRadEd3VnNrSWMycEFjZkFQdnlXc2F4d2tC?=
 =?utf-8?B?UGM1d29vZjR1RUJTSzBRV01qeHRqMHdLSGVOMDFWOWhKRmp2TGVwMmVDckFF?=
 =?utf-8?B?Rjl3T0t3N2ExcWJWWkdOa2t1bStJRW1nNVI4N25Ed0htUzRXSFpnRG8zVytj?=
 =?utf-8?B?S2RGLzVZLzNDYVlLN2ZvV1AwSGpnPT0=?=
X-OriginatorOrg: codasip.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a50ca7b-c8d0-4c46-6a31-08ddc2f68a9f
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB0983.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 16:50:30.1614 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d91ffef-bb81-4cbd-b9b8-552583685f20
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qiKPjzIfWJ4gpkW6ZGuZLZ2IbW6ULaQBsTEa+RFdYriqj3PFnNR+fKQfsgh/JhxJV+OH+zl/mfJ55Y9X7UPX/BSlO9+dfj9BAJIaSB2hWYA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2P192MB2294
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] fanotify22: Make 'dev' the last debugfs argument
 for musl compat
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
From: Florian Schmaus via ltp <ltp@lists.linux.it>
Reply-To: Florian Schmaus <florian.schmaus@codasip.com>
Cc: ltp@lists.linux.it
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gMTUvMDcvMjAyNSAwMy4xOSwgV2VpIEdhbyB3cm90ZToKPiBbWW91IGRvbid0IG9mdGVuIGdl
dCBlbWFpbCBmcm9tIHdlZ2FvQHN1c2UuY29tLiBMZWFybiB3aHkgdGhpcyBpcyBpbXBvcnRhbnQg
YXQgaHR0cHM6Ly9ha2EubXMvTGVhcm5BYm91dFNlbmRlcklkZW50aWZpY2F0aW9uIF0KPiAKPiBP
biBGcmksIEp1bCAxMSwgMjAyNSBhdCAwNjo1NTo1OFBNICswMjAwLCBGbG9yaWFuIFNjaG1hdXMg
dmlhIGx0cCB3cm90ZToKPj4gVGhlIGRlYnVnZnMoOCkgbWFuIHBhZ2Ugc3BlY2lmaWVzIHRoYXQg
dGhlIGRldmljZSB0byBvcGVyYXRlIG9uIHNob3VsZAo+PiBiZSB0aGUgbGFzdCBhcmd1bWVudC4g
U28gaW5zdGVhZCBvZgo+Pgo+PiBkZWJ1Z2ZzIC13IC9kZXYvbG9vcDIgLVIgInNpZiBpbnRlcm5h
bF9kaXIvYmFkX2RpciBtb2RlIDB4ZmYiCj4+Cj4+IHRoZSBjb3JyZWN0IGNvbW1hbmQgbGluZSBp
bnZvY2F0aW9uIHdvdWxkIGJlCj4+Cj4+IGRlYnVnZnMgLXcgLVIgInNpZiBpbnRlcm5hbF9kaXIv
YmFkX2RpciBtb2RlIDB4ZmYiIC9kZXYvbG9vcDIKPj4KPj4gVGhlIGZvcm1lciB3b3JrcyBvbiBn
bGliYy1iYXNlZCBzeXN0ZW1zLCBkdWUgdG8gZ2xpYmMncyBvcHRpbmQKPj4gaGFuZGxpbmcuIEhv
d2V2ZXIsIGl0IGJyZWFrcyBvbiBtdXNsLWJhc2VkIHN5c3RlbXMsIHdoZXJlIHRoZQo+PiBmYW5v
dGlmeTIyIHRlc3Qgd2lsbCBoYW5nIGJlY2F1c2UgZGVidWdmcyBpcyBhd2FpdGluZyB1c2VyIGlu
cHV0Lgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBGbG9yaWFuIFNjaG1hdXMgPGZsb3JpYW4uc2NobWF1
c0Bjb2Rhc2lwLmNvbT4KPj4gLS0tCj4+ICAgdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mYW5v
dGlmeS9mYW5vdGlmeTIyLmMgfCAyICstCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9u
KCspLCAxIGRlbGV0aW9uKC0pCj4+Cj4+IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL3N5
c2NhbGxzL2Zhbm90aWZ5L2Zhbm90aWZ5MjIuYwo+PiBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2Fs
bHMvZmFub3RpZnkvZmFub3RpZnkyMi5jCj4+IGluZGV4IDIwYzdhNmFjYTI0My4uMzU3ZTc0ZGJj
NzAyIDEwMDY0NAo+PiAtLS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2Zhbm90aWZ5L2Zh
bm90aWZ5MjIuYwo+PiArKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2Zhbm90aWZ5L2Zh
bm90aWZ5MjIuYwo+PiBAQCAtNjEsNyArNjEsNyBAQCBzdGF0aWMgdm9pZCB0cmlnZ2VyX2ZzX2Fi
b3J0KHZvaWQpCj4+ICAgIHN0YXRpYyB2b2lkIGRvX2RlYnVnZnNfcmVxdWVzdChjb25zdCBjaGFy
ICpkZXYsIGNoYXIgKnJlcXVlc3QpCj4+ICAgewo+PiAtICAgICBjb25zdCBjaGFyICpjb25zdCBj
bWRbXSA9IHsiZGVidWdmcyIsICItdyIsIGRldiwgIi1SIiwgcmVxdWVzdCwgTlVMTH07Cj4+ICsg
ICAgIGNvbnN0IGNoYXIgKmNvbnN0IGNtZFtdID0geyJkZWJ1Z2ZzIiwgIi13IiwgIi1SIiwgcmVx
dWVzdCwgZGV2LCBOVUxMfTsKPj4gICAgICAgIFNBRkVfQ01EKGNtZCwgTlVMTCwgTlVMTCk7Cj4+
ICAgfQo+PiAtLQo+PiAyLjQ5LjEKPj4KPiBUaGFua3MgZm9yIHlvdXIgcGF0Y2guCgoKVGhhbmtz
IGZvciB5b3VyIHJlc3BvbnNlLgoKCj4gCj4gQ0kgZ2l2ZSBmb2xsb3dpbmcgZXJyb3IsIGkgdGhp
bmsgZGlmZiBoZWFkZXIgaGFzIGZvcm1hdCBpc3N1ZSBuZWVkCj4gZml4ZWQuIEJUVyB5b3UgYW5v
dGhlciBwYXRjaCBzZWVtcyBoYXMgc2FtZSBpc3N1ZS4KPiAKPiBlcnJvcjogZ2l0IGRpZmYgaGVh
ZGVyIGxhY2tzIGZpbGVuYW1lIGluZm9ybWF0aW9uIHdoZW4gcmVtb3ZpbmcgMSBsZWFkaW5nIHBh
dGhuYW1lIGNvbXBvbmVudCAobGluZSA2KQo+IGhpbnQ6IFVzZSAnZ2l0IGFtIC0tc2hvdy1jdXJy
ZW50LXBhdGNoPWRpZmYnIHRvIHNlZSB0aGUgZmFpbGVkIHBhdGNoCgpZb3UgYXJlIHJpZ2h0LiBT
b21ldGhpbmcgYWRkZWQgYW4gYWRkaXRpb25hbCBsaW5lIGJyZWFrIGFsb25nIHRoZSB3YXkgdG8g
CnlvdS4gVGhlICJkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL+KApiIgc2hvdWxkIGJlIG9uZSBsaW5l
IGluc3RlYWQgb2YgdHdvLgoKSSdsbCB0cnkgdG8gZml4IHRoZSBtYWlsIHNldHVwIGFuZCByZXNl
bmQuIFNvcnJ5IGZvciB0aGUgaW5jb252ZW5pZW5jZS4KCi0gRmxvcmlhbgoKLS0gCk1haWxpbmcg
bGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
