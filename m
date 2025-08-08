Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04BFAC87FD2
	for <ltp@archiver.kernel.org>; Fri,  8 Aug 2025 16:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1754669240; h=message-id :
 date : to : references : in-reply-to : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=qXRDB9JOn/62Ih6P1UT0I104BiMh2J9hIot4PRux5mo=;
 b=d95Xhu84TXp32MEBS3MVs7lTrkQVHvTlrL5Et8BrTsEwmPUjI1DeP7BX0/j1dBQTQVY+C
 L5Avxic7G3aRJhNnBpM9dWSPiji+1Tinf8C/2Y1qGxwFzkFusPlkvg6WfTISUiuNxTKFXGt
 7UKiwsLNshzyZ/PcYuhY7P0JE7F2FEg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2DB693CAC97
	for <ltp@archiver.kernel.org>; Fri,  8 Aug 2025 18:07:20 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4FC643C9A55
 for <ltp@lists.linux.it>; Fri,  8 Aug 2025 18:06:58 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20706.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::706])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits)
 server-digest SHA256) (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 49481600720
 for <ltp@lists.linux.it>; Fri,  8 Aug 2025 18:06:57 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g9RIjUY9QMspTyBI52J9hSwRuM+clgb5PLDapIYyVQwjt8ge4LKfhC5n8WKignb4/TCLoRVZIEm4R9gqRUo7LkxCJwgWF0mh3h/ryEDIzZZYD5Dst6gTiIEU1c8hauhYxgoLqJoAG2tDuGzdYFkVEkoAbS+lXVu/Q06OyPwjY9LP1nAoFLgSTnPUMr7QHVSFz10/JAg7AX/olGydDNFRxr+Pusv6C7Cs1jGPKRMVMWSja6ivqVcyrhlZztcpAvHk6Rj9iRhUUBaxPofkGA5IVpiOlagtBdsJG5EHzlUTTjmkOEHmH6gp0jqfRJ1B8Ko7JuVBXRcgDm58Rrh9W/6NsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4kTtfigpmh5OHP/VOU+zMPIG+iA+rQp7f+tV3orv1pw=;
 b=jSrSNNYO89czBBUxKexs+OnPKacW9BhBG79YgbzBRzj534AenMV6Wthp8lbZ+c5xiOOwvl6pc7N+jPesqzdnPxv2T0gxhSQk7nt6nziadgcyvjy7H+J3LxMzyOO2vnWUOxnGrDzA6gerPTdPNhprDZ8BvAxqAVfjySmYS+xgrWk7B3rVykcN5LnbpzPC/t5P/WVpMTNzIcc1cDHzEw6JfwlM/ejL//FBugRrp3rxBemYBtwI3M9Xvsc3xWVvReSaABOpHJiK7P+EuX9I6GFRZaXa9PJs/qrIrYpHW+9U68zWYWYc5Ye5f6AsoR17OtsbKqEk2O0R7EvHZEvEvRuh8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=codasip.com; dmarc=pass action=none header.from=codasip.com;
 dkim=pass header.d=codasip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codasip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4kTtfigpmh5OHP/VOU+zMPIG+iA+rQp7f+tV3orv1pw=;
 b=PCaZaVrECl491HosEmzqnJPFIVfUglgR4Se3x5TgA/E6eEStjWqGhvYg7W8nv+7XyoBiVtadE7CEvjWnCnP1xoh1uSk3G+2Sf4oyZ9Vp3XMsPbmNksgPLTY9guxIYVT8K1SfjIYayaIBpdYw5yMa0oKe6m2WSnQShB35+0kyMH0lrR3Ddu7ZkZ3n5/gIvvt6Uco+aFgqu2D351w6cBoh2fQm8MRvbIHXPehM/Z+QYTjBuQ5yGAEsSbyE27kSf/AZ0Fg8MfBoHM9+w9Qt0X0V1HWfzFKlIS6rR7LapvoCIIx69Ozbxy286wD4YYdYqmbeYBVIXsYjfQ80PeW9VKm4fg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=codasip.com;
Received: from AM9P192MB0983.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1f4::5)
 by DU0P192MB1913.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:3b3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Fri, 8 Aug
 2025 16:06:55 +0000
Received: from AM9P192MB0983.EURP192.PROD.OUTLOOK.COM
 ([fe80::dda0:cbaf:a692:8443]) by AM9P192MB0983.EURP192.PROD.OUTLOOK.COM
 ([fe80::dda0:cbaf:a692:8443%5]) with mapi id 15.20.9009.013; Fri, 8 Aug 2025
 16:06:53 +0000
Message-ID: <614059f8-983e-4f29-a730-3e0ceb541b9f@codasip.com>
Date: Fri, 8 Aug 2025 18:06:52 +0200
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>
References: <20250731065708.638005-1-florian.schmaus@codasip.com>
 <20250808140435.GB470368@pevik>
Content-Language: en-US
In-Reply-To: <20250808140435.GB470368@pevik>
X-ClientProxiedBy: FR3P281CA0084.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::20) To AM9P192MB0983.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f4::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9P192MB0983:EE_|DU0P192MB1913:EE_
X-MS-Office365-Filtering-Correlation-Id: 18d5075f-fb57-4059-48b4-08ddd6959764
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|1800799024|10070799003|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eTFTQ05mbVRVQTVBVjBkZGFaSFl5a1pya2pnbklqYVdsdmU2Y1FHNlNWQ2Ri?=
 =?utf-8?B?SkdtYWNzdmtwS25lQ2Y5ckxmZStUS21kWnlLWjlSU21mSUhWaEJNcTc2aFF1?=
 =?utf-8?B?MVh3MTNySHFJRWx3RzlCSVNUM2lzN28vZ3hCR1lFeDIzSFk2TjJRejQyTitE?=
 =?utf-8?B?V2J0SHlPeWs3WWtJWlUvazRpRFJvMytoN0JDamp1Z2FsbVpiaS9Vcy81OVdm?=
 =?utf-8?B?TER6d3BYOURxZVg3YTJMSWJ1YzNqY1VvajY4ZDNaSStKbjhkVDFYeEQ4T0p6?=
 =?utf-8?B?UFFGaG9OaUFsL0ZHczZNZ2EvMTFNdW1LTFhzak50QXRtVWMxVUV1UEczSHM3?=
 =?utf-8?B?MGw1Yko3Y081ak1VYzJzNTRBZEN5U25XQjZFQlpOd3hVNUU4ODltejhWSXM4?=
 =?utf-8?B?L29WOEs2c29jVmFPTWpNMzJ1bjdVaGEveFdPbXRaVnYrZ2h5elV0L2JyM2g1?=
 =?utf-8?B?ZHNLQlI0RzNlZVBJdUlzUzUvY1Z5OXBiT1EzV3U4Rk56ZVZOVkJxUWpYOUNJ?=
 =?utf-8?B?VnY4dlI4TlU2QmpKcGI3WUtDV296M1B0YmdPNEQrRFJnS1dUSkR5bnZhcEFh?=
 =?utf-8?B?TnlRS0xwVnB6ZXJIRG43VFlScGpTZFVwRSsraUFxOW9sRTh1aUR4TFBBZjAx?=
 =?utf-8?B?NHB1SEgyOHVrYVFVa2NneWFpNTEyS204Uk9RRUZ5ZzBOOWdrSGFQWWIxZ1Vs?=
 =?utf-8?B?YTVEQVdDUVRwSGZMamdlWkxJRGgwT0psVWZRM3dYRG5CT1g2T0d1b0dmSlZm?=
 =?utf-8?B?ditaTnU2OGhUaC8ycnYxa1VCSFhROHYyZlZadDdER1ZJU3hhSHBxcHZzc2xY?=
 =?utf-8?B?QUxaeDZ5ZThPemNRUk9IdEM1cWRNUGZWZnFRTEx6VVpyRG0vMEVrdDFpYU12?=
 =?utf-8?B?WG00dG1NUDRNazFtOVFETTlpUVJLbTdNY1c5SVJEa09jN3RwM2Z5Z21mNjIv?=
 =?utf-8?B?SlBPN3pTRndQV3dod2RmcFd1aVA4SUVjUGdUR1ErcndzeFNaNm82ZHVVaXQz?=
 =?utf-8?B?ZW5BZEdzREFONkFxcUZCZW9ILzdlZWYrZ0E1MkYzcTVQY2IwdGJjTzNkVXAx?=
 =?utf-8?B?Q0x5OXB0MExYZnJkb21veFd2THVSelVoanFwcjR2QXFIeVMvRnlQM2VpOEU4?=
 =?utf-8?B?S1Y1QjNUK2pkRTNPZ1BHNUhCSzYvaUtzZlFwVi9zMmJoM3VJb1lvR2xobWdp?=
 =?utf-8?B?ZzhmWENUYldaQTI0bnJHM1p2cktKcnpWTFk3akwvR1FrWnVDdlVWdE5uU1ZR?=
 =?utf-8?B?SGRLM0RGajVQcENFT2FyZy9OeXNmM2F1QWR6bjVycWVDTUZGMHZPZ0pTbnVW?=
 =?utf-8?B?K00ydDJtSk5pMkw3d0pqaHJOclkvSFBwcGh0b3JBakcrZ1ZDUDJkd1NrTDQ0?=
 =?utf-8?B?MEtXMFJWVEdDbFF0NTBMTEF2ZWdIQ0tnMWVDaVRiMjF0enJzQWtCRndka3Vo?=
 =?utf-8?B?NkZpd204d3JnajFsOFk2Z1VwNkFGdDJXelE4T3NWM2d4VXlhaDg2dE1lZGFi?=
 =?utf-8?B?U0gxZ0tNN05SUWtSNWM2OHJXaFRZT285U1JPWWdUL2t2SnVnTnVnVWN6NGp0?=
 =?utf-8?B?Qm9aektVZ2tGcmpoZ0xWNk1SemIvd1hZUjF5WFlOc0NGVmNybTRCT0s5dTUw?=
 =?utf-8?B?UzhqUXZXbkRjMkJZZUQ5MDUzL3MzZmRYVWxvRUVwOFhnbkk1TUl1WXFHdVMy?=
 =?utf-8?B?OGV5VUlleitmcW9nMUJmOXJQeFhCOWRxSytESFd4czllTnJhV1c5cXlwZFM4?=
 =?utf-8?B?ZTRrNnJYSTdHeXlBQVFpSlVWSUF6QTFEYisvUHAybHBMMGV2TDMyMmlEcDlW?=
 =?utf-8?B?Z1A1RTBobEhOcEQ2S2xsN2VnQmdKRExSRklsYmlkemRacXFqNEdQMytjN0RQ?=
 =?utf-8?B?Si9GTmdLRW9lMUpMdUlqTTVZVE1pamhlSHhDTjAvMW8vTGtmRDNnd3l4Y2JN?=
 =?utf-8?Q?VcPPMCk2mhE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9P192MB0983.EURP192.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(366016)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGwwY1psWkJvYzJqUE1US2tTU2VxVHhVcmlUTEYxVVBJeXdBR21CVkh4Ym0y?=
 =?utf-8?B?TFMyckJUWlp0b2pQOWNseTE4aWEzZTZ6QlQ0b0FzdlBQdWdkU0g3RmRYeitn?=
 =?utf-8?B?TGdhNERYdnFZR1RhV3dYaW1VSWZBZi9mV1VaMHU2Z3krUkkvSmJrcGNGLytk?=
 =?utf-8?B?MnFMTDVuRjd5enY2SlJrUTJCajBkcjlTQ2JLMTl3bkFKWlUzdDFRTEJyRVJx?=
 =?utf-8?B?L0FMZ1haanNKNkh4OEdUMlNLbEhHV2pOWU5RZG1qNXQxZWNoVmRLdUdpUThs?=
 =?utf-8?B?ZWpuNDF4cW5YbTZycHQvMkZKeWRRcUZoL0tqNy82NkgwS3pLckNGakk0OTQ2?=
 =?utf-8?B?U1JSTDVVWmRra0hBU1I2YjNqTDRheUNQK1htYmtKNXNtRERGS0RRQWx1cmN1?=
 =?utf-8?B?ZG1CQVBVclRyM3BUWnNvSTZlZVpSYnR1Q2VidkJHT21nWGRnZTB4bFlNQTA1?=
 =?utf-8?B?UlJYbzYzbFlWWDk5V0w3aEtuVWRnMGpjcmt0TjUveXVsOWcvNFd2Z3RNV2Zm?=
 =?utf-8?B?ZFVrY2dNQlNNTmVVR2dkTXNVbkxrMVZTekxJbXcrSVVXZm1aMnhvT3g0VmIr?=
 =?utf-8?B?d1IwYnNFWkdCR3pOejAvdG9ZT3YxaEs3YThLREt4Y09yNVpUUGtVbFJRQXFV?=
 =?utf-8?B?N1FHWVRpT252QmpXak9oK2VhbXU5MEl3TWdaWE95ZGNLM21WK2xwU09vWnB2?=
 =?utf-8?B?b0VsdDYzS1ViVGRFbXllYXF2QUJFcWRWelJaUGhxNkxYZURtU1pkSE1vQWk5?=
 =?utf-8?B?UnF0ZzJ0Ri9mekRXeFJFUld0VnoxNlZEZEJnek05MHdvRDUxWjRlTlp0b2U0?=
 =?utf-8?B?c2FyOHQ2b3R6UWlFcVNTb1YrKzBJZGFwNDBVS1FLUTF1VWVUa1Q4MndZRVV3?=
 =?utf-8?B?ZTAwVGt1SzFRNUdBVTQvK0dyQ1N3K2V5aTEzdGFlVER1QTQrc3RsTGhLd2s1?=
 =?utf-8?B?MGZYTmN0aG4zQmFZQkpPaVVDMVJjK2xBTy8wTkhTZ1RXMXdRbHBXQkMrbmR4?=
 =?utf-8?B?Q0xMTlJYNk9HUjF0cWlIV3FMdVFWd2docnJkRU5sVVJUWjFRQmthcEZLQkl6?=
 =?utf-8?B?YU9nZklXbGtPSGtDc3ByLzIwWVpZWU9kL3JMTm5kSlk2R0FydDN0Z2ZkQVNa?=
 =?utf-8?B?T05Wbm9qOE5sSVpHNkMySEFOcXZUTzJCWHhXajVPRFkvQmR2dTFJenJYK28w?=
 =?utf-8?B?cVRkME10QWZVUGhnb0VGb01wdHdERzVsQlYvQ3ZZUkk1UkhEYUVBajhFdHN0?=
 =?utf-8?B?QW5EV2NyVlY4SmRqeXhIQVU4dDFQRzZwMEszVk1vMDdYYS9OMW80OEZQZUtj?=
 =?utf-8?B?RjdmaHVwd3ZpZ2RkWnBVd1paWGwyOXZMbi8yUWhaV2h1YzloREFING5KRW5z?=
 =?utf-8?B?ZlVNeW9KaFdPVHhSeFJPRjBXZU8rbTlSdGZpUitnL2szd0FkREZWdDEvK3po?=
 =?utf-8?B?OFBkYzlLZDhHanYyMXZzSld4M2JSSjZvSVhnaXZmaVZTeWE2cEYyUm9zMHZG?=
 =?utf-8?B?SmFKR0RZcUhVbi9oZjRnMk9Sd3JqcHRZcFpkT0VjalIwaExnZWVvRU5lSjdo?=
 =?utf-8?B?MU9XamVXaExMR0lzNFU1VnJTakxoNHN3WlNTNG12cHU1WHMrOXBFdXAwYXMx?=
 =?utf-8?B?a1BhMGJYeTVOZWMvcWNVS3lGQU9MeDV6WlJFc2cyTHQwWFZSYW93d1dpeFBP?=
 =?utf-8?B?d0hQRFJHY2orNnVhZEhZSDlURGIvR2QwMGpqTG9KbHlkY1BwaE9LV2RVdnBJ?=
 =?utf-8?B?Nnl5U1BraEhiRW9qcVNVblpNUVh4MmZBTVliZ0lKeTVYTmhHU25sL0NDeXRD?=
 =?utf-8?B?aXF3dndpZVRzRWQwNjB0Vkh3RXlnOHJldW1rK3kxaUV3ME43akRWZGFuR3VT?=
 =?utf-8?B?cm5UbW0vNnRoOTRYMUlaSEhGQzhzYkFWbGtCaFVhdTVoZVZHME9BZWFaRTF0?=
 =?utf-8?B?cUxGTHczOFZSekxzY0o2cFNwcDdvRGtEWko3dHFFVndXWmJIMlBMZGJwNGEw?=
 =?utf-8?B?SHNmMklWVU5UNmJiSDNxSmxsaEwzYTVub2tlbDJWNk90d2RTRFk2Nk9uVHl2?=
 =?utf-8?B?TkxuN0taSkFYc1NQYVBkc1hOWnAySnBrVzZhNGJiRHp2U1l2V21CTWhhSUdy?=
 =?utf-8?B?elp6L0JYQ3dtN0s5UlZkS2xFbmEvTmI5M2pjYnJQb3h6d3k3Y2VKcldIMHZo?=
 =?utf-8?B?N2hzR2hiaWVqckZjUlNnMjkvdythbEQ1ZUFMYkgxRTQ5Sm1xNHBmYlFWSExK?=
 =?utf-8?B?SUhGeGNLRzdFZzR0aEpjWjJXeFd3PT0=?=
X-OriginatorOrg: codasip.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18d5075f-fb57-4059-48b4-08ddd6959764
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB0983.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 16:06:53.5878 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d91ffef-bb81-4cbd-b9b8-552583685f20
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fjJj2UNt0pVKhIvTs5tfOi96WJU1VVkFjLjPWaVtc4Uz1MEV1DcsH2qpAOvHio5mrCBvdJdZDLJp1R+cefg1QHAKbjvNJeVuhgtbKTdmNgs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0P192MB1913
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] sigrelse01: Check if signal 34 is available for
 musl compat
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

T24gMDgvMDgvMjAyNSAxNi4wNCwgUGV0ciBWb3JlbCB3cm90ZToKPiBIaSBGbG9yaWFuLAoKSGkg
UGV0ciwKCnRoYW5rcyBmb3IgeW91ciByZXZpZXcuCgo+PiBEbyBub3Qgc2VsZWN0IHNpZ25hbCAz
NCB3aGVuIHRoZSB0ZXN0IGlzIHJ1biB1c2luZyBtdXNsLiBTaWduYWwgMzQgaXMKPj4gdXNlZCBp
bnRlcm5hbGx5IGJ5IG11c2wgYXMgU0lHU1lOQ0NBTEwuIENvbnNlcXVlbnRseSwgbXVzbCdzIHNp
Z25hbCgpCj4+IHdpbGwgcmV0dXJuIHdpdGggYW4gZXJyb3Igc3RhdHVzIGFuZCBlcnJubyBzZXQg
dG8gRUlOVkFMIHdoZW4gdHJ5aW5nCj4+IHRvIHNldHVwIGEgc2lnbmFsIGhhbmRsZXIgZm9yIHNp
Z25hbCAzNCwgY2F1c2luZyB0aGUgc2lncmVsc2UwMSB0ZXN0Cj4+IHRvIGZhaWwuCj4gCj4+IFNp
bmNlIG11c2wgcHJvdmlkZXMgbm8gcHJlcHJvY2Vzc29yIG1hY3JvLCB3ZSBjaGVjayBmb3IgdGhl
Cj4+IGF2YWlsYWJpbGl0eSBvZiBzaWduYWwgMzQgYnkgYXR0ZW1wdGluZyB0byBzZXR1cCBhIHNp
Z25hbCBoYW5kbGVyLiBJZgo+PiBzaWduYWwoKSByZXR1cm5zIFNJR19FUlIgd2l0aCBlcnJubyBz
ZXQgdG8gRUlOVkFMIHRoZW4gd2UgYXNzdW1lIHRoZQo+PiBzaWduYWwgaXMgdW5hdmFpbGFibGUu
IEtub3dpbmcgc2lnbmFsIDM0IGlzIGF2YWlsYWJsZSB3aXRoIGdsaWJjLCB3ZQo+PiBwZXJmb3Jt
IHRoaXMgY2hlY2sgb25seSBpZiBfX0dMSUJDX18gaXMgbm90IGRlZmluZWQuCj4gCj4gLi4uCj4+
ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvc2lncmVsc2Uvc2lncmVsc2UwMS5jCj4g
Cj4+ICsjZGVmaW5lIF9HTlVfU09VUkNFCj4gCj4gVW5mb3J0dW5hdGVseSArI2RlZmluZSBfR05V
X1NPVVJDRSBjYXVzZXMgdGVzdCB0byBoYW5nLCBhdCBsZWFzdCBvbiBnbGliYy4KCkkgZG9uJ3Qg
dGhpbmsgaXQgaGFuZ3MsIGJ1dCB0YWtlcyBhZ2VzIHRvIGNvbXBsZXRlLiBBdCBsZWFzdCwgdGhh
dCBpcyAKd2hhdCBJIGZvdW5kLgoKCj4gQW5kIEkgc2VlIGZvciBtdXNsIGl0IGlzIG5lY2Vzc2Fy
eSB0byBnZXQgc2lnaGFuZGxlcl90Lgo+IFVudGlsIHlvdSBmaXggZ2xpYmMgd2l0aCBfR05VX1NP
VVJDRSBOQUNLLgoKSSB0aGluayBJIGNhbiBnZXQgcmlkIG9mIHRoZSBfR05VX1NPVVJDRS4gSUlS
QyBpdCB3YXMganVzdCBuZWVkZWQgdG8gdXNlIAp0aGUgc2lnaGFuZGxlcl90IHR5cGUuIFdpdGhv
dXQgX0dOVV9TT1VSQ0UsIGRlY2xhcmluZyB0aGUgcmV0dXJuIHZhbHVlIApvZiBzaWduYWwoKSBh
cyB2b2lkKiBzaG91bGQgYWxzbyB3b3JrLgoKCj4gQnV0IG9uIGdsaWJjIGl0IGFsc28gYnJvdWdo
dCBhIHdhcm5pbmcsIHdoaWNoIG1lYW5zIF9HTlVfU09VUkNFIHJlYWxseSBzd2l0Y2hlcwo+IHNv
bWV0aGluZyBvbjoKPiAKPiBzaWdyZWxzZTAxLmM6IEluIGZ1bmN0aW9uIOKAmGNoaWxk4oCZOgo+
IHNpZ3JlbHNlMDEuYzozOTc6MzM6IHdhcm5pbmc6IOKAmHNpZ2hvbGTigJkgaXMgZGVwcmVjYXRl
ZDogVXNlIHRoZSBzaWdwcm9jbWFzayBmdW5jdGlvbiBpbnN0ZWFkIFstV2RlcHJlY2F0ZWQtZGVj
bGFyYXRpb25zXQo+ICAgIDM5NyB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaWYg
KChydiA9IHNpZ2hvbGQoc2lnKSkgIT0gMCkgewo+ICAgICAgICB8ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgXn4KPiBJbiBmaWxlIGluY2x1ZGVkIGZyb20gL3Vzci9pbmNsdWRlL3N5
cy93YWl0Lmg6MzYsCj4gICAgICAgICAgICAgICAgICAgZnJvbSBzaWdyZWxzZTAxLmM6MTA0Ogo+
IC91c3IvaW5jbHVkZS9zaWduYWwuaDozNTU6MTI6IG5vdGU6IGRlY2xhcmVkIGhlcmUKPiAgICAz
NTUgfCBleHRlcm4gaW50IHNpZ2hvbGQgKGludCBfX3NpZykgX19USFJPVwo+ICAgICAgICB8ICAg
ICAgICAgICAgXn5+fn5+fgo+IHNpZ3JlbHNlMDEuYzo0NzI6MjU6IHdhcm5pbmc6IOKAmHNpZ3Jl
bHNl4oCZIGlzIGRlcHJlY2F0ZWQ6IFVzZSB0aGUgc2lncHJvY21hc2sgZnVuY3Rpb24gaW5zdGVh
ZCBbLVdkZXByZWNhdGVkLWRlY2xhcmF0aW9uc10KPiAgICA0NzIgfCAgICAgICAgICAgICAgICAg
ICAgICAgICBpZiAoKHJ2ID0gc2lncmVsc2Uoc2lnKSkgIT0gMCkgewo+ICAgICAgICB8ICAgICAg
ICAgICAgICAgICAgICAgICAgIF5+Cj4gL3Vzci9pbmNsdWRlL3NpZ25hbC5oOjM1OToxMjogbm90
ZTogZGVjbGFyZWQgaGVyZQo+ICAgIDM1OSB8IGV4dGVybiBpbnQgc2lncmVsc2UgKGludCBfX3Np
ZykgX19USFJPVwo+ICAgICAgICB8ICAgICAgICAgICAgXn5+fn5+fn4KPiBzaWdyZWxzZTAxLmM6
IEluIGZ1bmN0aW9uIOKAmHRpbWVvdXTigJk6Cj4gc2lncmVsc2UwMS5jOjY3NToyNTogd2Fybmlu
ZzogdW51c2VkIHBhcmFtZXRlciDigJhzaWfigJkgWy1XdW51c2VkLXBhcmFtZXRlcl0KPiAgICA2
NzUgfCBzdGF0aWMgdm9pZCB0aW1lb3V0KGludCBzaWcpCj4gICAgICAgIHwgICAgICAgICAgICAg
ICAgICAgICB+fn5+Xn5+Cj4gCj4gQWxzbyB0aGlzIGlzIGEgdmVyeSBvbGQgdGVzdCwgd2hpY2gg
bmVlZHMgY2xlYW51cCBhbmQgcmV3cml0ZSB0byBuZXcgTFRQIEFQSQo+IChlLmcuIHJlbW92ZSBv
bGQgdW5peGVzLCBlLmcuIFZBWCBhbmQgZ2V0IHRlc3QgbW9yZSByZWxpYWJsZSkuIEkgc3VwcG9z
ZQo+IGhhbmRsaW5nIHNpZ25hbHMgd2l0aCBMVFAgbGVnYWN5IEFQSSBpcyBicm9rZW4uCj4gCj4+
ICsKPj4gICAjaW5jbHVkZSA8c3lzL3R5cGVzLmg+Cj4+ICAgI2luY2x1ZGUgPHN5cy93YWl0Lmg+
Cj4+ICAgI2luY2x1ZGUgPGVycm5vLmg+Cj4+ICAgI2luY2x1ZGUgPGZjbnRsLmg+Cj4+ICAgI2lu
Y2x1ZGUgPHNpZ25hbC5oPgo+PiArI2luY2x1ZGUgPHN0ZGJvb2wuaD4KPiAKPiBuaXQ6IEkgd291
bGQgcG9zdHBvbmUgdGhpcyBhZnRlciBjb252ZXJzaW9uIHRoaXMgdG8gbmV3IExUUCBBUEkuCj4g
U2NyaXB0IGFscmVhZHkgdXNlcyBsZWdhY3kgZGVmaW5pdGlvbnMKPiAjZGVmaW5lIFRSVUUgMQo+
ICNkZWZpbmUgRkFMU0UgMAo+IGFuZCBvbiBhIGRpZmZlcmVudCBwbGFjZSBoYXBwaWx5IHJldHVy
bnMgMCBvciAxLgo+IE1peGluZyB0aGF0IHdpdGggPHN0ZGJvb2wuaD4gbWFrZXMgZXZlbiBtb3Jl
IG1lc3MuCgpBZ3JlZWQuCgpJIGFtIGdvaW5nIHNlbmQgYSB2MiB0aGF0IGRvZXMgbm90IHVzZSBf
R05VX1NPVVJDRSBub3Igc3RkYm9vbC5oIGFmdGVyIApjaGVja2luZyB0aGF0IGl0IHN0aWxsIGZp
eGVzIG11c2wgY29tcGF0IGZvciB1cyB3aGlsZSBub3QgaW50cm9kdWNpbmcgYSAKcmVncmVzc2lv
biBvbiBnbGliYy4KCi0gRmxvcmlhbgoKCgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczov
L2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
