Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CF60C83F17
	for <ltp@archiver.kernel.org>; Tue, 15 Jul 2025 08:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1752567660; h=message-id :
 date : to : references : in-reply-to : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=ANaRXM1F2+iPcXHpyh51ITl6PtcQQgXvRI30lYjn0cY=;
 b=m/zyDjy4Ons381PLyv527TpdNj8oW5z0BzMrSvUf7QEK8hcjAlM9P1gMdgdjrVeIPLrt+
 YUo+jH1NWIMKB0ymFj+tRFQL+uw0/FcoWoJmuatQ19rYfF1tTEw83VrTu8THIWNFsfl2xLJ
 QFGE4hh+NTt7FUnADVy7Six7D1fc7y8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D9D473CCB9F
	for <ltp@archiver.kernel.org>; Tue, 15 Jul 2025 10:21:00 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E777B3CCAB7
 for <ltp@lists.linux.it>; Tue, 15 Jul 2025 10:20:40 +0200 (CEST)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20707.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::707])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits)
 server-digest SHA256) (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id CD7511400F93
 for <ltp@lists.linux.it>; Tue, 15 Jul 2025 10:20:39 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Os9vsg/duVQ2ova7PN5XypeAVarc12sMeBHrGFfsCcJh+ZvER1cWOOb2fjA7gLmIjS/TR7J52BTGXd5MqpfUm6k9y9x1WFTU8HMNoIx0B0LqXu9JlJxdv4kRqry69tfnYiAoG+sP1ikQ35vGn+8izyR8gQ7FnpYtMNQGLNlst27D/5c/qRxH+ryh4PEIfFdGG3CVfSOOgJ+/xLo0/D2vTwrODYL5LH5DdKkBHk8qG2h4OdQvhRTO2wm+TS7DNSN5QeFUoEsi0gZOY+EKthaworAThzUMc2zz9h7a9kX5lyW6cl4wjB7WYOdb/OZmiDd7ZyvYgLzW7BFF+0sEOg3pTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l/0s/QpEnD4wf13xBxbOPucFf2hdfWIWKXZTpYkzjSY=;
 b=HGQDoKcxQSlup6+fPrn0T1y4KgERDnP1G30B/9PuOXV1jNivtwxgKBfzAGFCcsIJGE6UqBLObE0s5QVfBfEkb3kJz1k+YbC6huxkOVf97ZP6pIg7VJzHTqmyEZYRusYi/aBnZ/WfXOsOHi8nRrhNGednto6QDsZ4wXHe+v5x7uCFeMGIP1Pco5GjIhpFvXJXp6RiRXxWzKZbRrTTNjOkhP4Fz7I34SsG49V5u4Y3gC0RcAWvdQ4jM3+JMCYehYn0o0oxs1/6URq9qBtUYqESRbZ6hcqdnmEtbM9RQNqNjYj5GeVkBzRnxMrElb1WV7qHvNnizk46Uo/L1tArHUHxYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=codasip.com; dmarc=pass action=none header.from=codasip.com;
 dkim=pass header.d=codasip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codasip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l/0s/QpEnD4wf13xBxbOPucFf2hdfWIWKXZTpYkzjSY=;
 b=HFjGBiH0j1i/HZ+HkGg4zdPUsy4xZWK1lQUbOZg84s4mWCgGalcvCZMW4gE+n7VkPSTIQdV9E2EzXtDOEO6bV9VUPGvUVtUP127ZbCtAwmAUyzKZoxB2FDjm64Ib15AOk1Gvs2rv1I+qkqiYzQBNCMGASyCxnlQfV/AZ0xNu0A5RUFpK8OMJxDKLh9EOIPhn4cprcYmhFN64sCduIa97RNggye3roQ3WoIyd9tvEuv98E6DxtomGOngpFdBD/VC+2b/u7sQ3AJfOSyxuU+kyjumH/XSGU9bQCsvEuR/xOXp5wTxWj1G/jEq0H9lmSgiPS3AXGdTvIBjHfkfZbdnG5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=codasip.com;
Received: from AM9P192MB0983.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1f4::5)
 by AM7P192MB0772.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:178::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Tue, 15 Jul
 2025 08:20:38 +0000
Received: from AM9P192MB0983.EURP192.PROD.OUTLOOK.COM
 ([fe80::dda0:cbaf:a692:8443]) by AM9P192MB0983.EURP192.PROD.OUTLOOK.COM
 ([fe80::dda0:cbaf:a692:8443%5]) with mapi id 15.20.8943.012; Tue, 15 Jul 2025
 08:20:37 +0000
Message-ID: <88c6d73e-8d1b-4f95-be17-06f9fe6d35c8@codasip.com>
Date: Tue, 15 Jul 2025 10:20:36 +0200
User-Agent: Mozilla Thunderbird
To: Andrea Cervesato <andrea.cervesato@suse.com>
References: <775c5a55-6079-44f3-9af4-11587bcec468@codasip.com>
 <b7694ccf-6efd-40fd-8918-89a26f51f6f3@suse.com>
Content-Language: en-US
In-Reply-To: <b7694ccf-6efd-40fd-8918-89a26f51f6f3@suse.com>
X-ClientProxiedBy: FR4P281CA0284.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::8) To AM9P192MB0983.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f4::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9P192MB0983:EE_|AM7P192MB0772:EE_
X-MS-Office365-Filtering-Correlation-Id: dd5f7355-a5d6-46bf-93e9-08ddc3787a9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|10070799003|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RmJsRGltQkd6R3NWVDI2SHdIN3pIbXUxRUdkc0ZXM2VjUy9oWDFhTVJzSHdx?=
 =?utf-8?B?WG1QczFZUEVMeTA0amxJekJSZTZyVmVNWmdyNG4rZW9wdUNqdm5yWmo5bCtN?=
 =?utf-8?B?U3ViSzZMbWt5aUZJZHZZZzF6WDN5c3ZyeHp2R0Z3QnQ5Yk1wK0xpN2FJNDNP?=
 =?utf-8?B?V1dCQTRVOE1pOVkwT09HKzgwVUJiV0p4UzdmMlgwYyt6ZWRUK2hwNEZyYXdO?=
 =?utf-8?B?Rkx3K3gwazJCRzF5QklGUWNETDdBa29idW14T3lMTUdBc21OVXBZVUR5bi9N?=
 =?utf-8?B?NllBMWw1ekJoS0xSdjNmZ2ZKYkMzUHhIc1hZODJGR0UxT1NzTmNQUUZiQzdw?=
 =?utf-8?B?NnZ3UkpQYy95ejllZjdSSENIK2VnTTU3ZlBTRGpleW5Gb1g5MFRlTnA3dCtH?=
 =?utf-8?B?YnRTenZWQXU5Q1dQNnp0LzhnbFhQUE5tNnFQWWhWWGsrMkkrSEZiUjcreC9w?=
 =?utf-8?B?QitmLytmN0RmMktSeDNxcnBhNGVTbXBvcXpBeUNzajdINnE5SDhtYnVkYkll?=
 =?utf-8?B?SDFxZDJTV2wzall1T0RZRCttQWk2TWR4S2FodHV0NmtHZSt2YnVQbEVkT0F6?=
 =?utf-8?B?SGUxYUF1VE5VOTV3em1uZ2FuQVg0a3FtZFZBRFJ1aGE5MXpKNkdsUlFJanFx?=
 =?utf-8?B?aTZSMWk2SHBndmhZWEg5M3dFMkFKWGNyWDZJMThQYU84WFU5c3prK2F6YVU0?=
 =?utf-8?B?OUpXUVJneTVhNUFFb3JoOU43L0JIeTFZdzlUL2w5cWRNckJ6MEx1L2o1OEcx?=
 =?utf-8?B?c0pPZTBkeDFJOGxONG1XYjRXVkphRWNnVnZlanZmNlI3Y1JKUWUwQ2RUOFNu?=
 =?utf-8?B?ZmNJcUpGRVlleFk2Skl3K0xZMHBMT0JmUlE4eXdaMG1WQkU2eHVqWTZ2enln?=
 =?utf-8?B?bE9ZYTVZUmJQd3NuaUQrcWw1ME9iN29wbzVvOUhLQWFaRmQ1NkcrVkZma1Vj?=
 =?utf-8?B?Q0dpN3ZTWGk2Q1RyZ2paZm1rRGZNRlZUcWIvUUpLRmNqVWhobXdPZkIvMEtr?=
 =?utf-8?B?QTgwai84ZEJaNmV5NFA3cEw5UlAyNkdmdzFNelhrNk51VUN1OWF4L0N0QnBL?=
 =?utf-8?B?bVMyMUFqNDdvb1UyUmVpSzBnQ2IvbHgrZzZPcmxXM0tEVE91NFQ5YTc3MFIr?=
 =?utf-8?B?NWlJYlk4aFJWQjU5RXEzS2xYYkp2dFpUMHZtT1lKaUdYVE8vVXl6cUZNc0Yy?=
 =?utf-8?B?bmxQSVB1Sm9RMGVIbThlVTRGYkRUZXR3b05ZM0RybFd5dkMvQ1AvSENXUkpw?=
 =?utf-8?B?cC91cC9XTnRadHRnS2pCRzFORkVtM3lMSmN1RlIwN0xTdjNIa2hueHljbWx0?=
 =?utf-8?B?KzJFbjhsUFpoT280dGlYN1ZXdTZ5cmJ3YTVQNFNrZHV6MjhoNVZ3RWc4bEVw?=
 =?utf-8?B?Sit1Z3QwV3FuUDhmdW1qV3ZXSldTN25FbTNJT0dzK2FiMzBKZlNIZW5BcWU2?=
 =?utf-8?B?OVVPQXdqckMzcVRmRW16VFVjYko5WlUzczllaUk4Y2E3MG5KT1Q4a1lqRkp0?=
 =?utf-8?B?NlRKNUNOQ2pRK1R2NU04QUFaS05QWkVZMC8raHViOGw4TlpwV1FFdHRKenpu?=
 =?utf-8?B?c2xJQk9EV0xnMzFzQ3RNQ29ZNVZVUnF4L0JtR2hOUksyNURNY0RFSnpwUkww?=
 =?utf-8?B?N2c1S200OTB3Wmo4T1JyRk1pMVJyNGt2OUtaU1dlcE51TDdtVFNzdDZ2Rjlm?=
 =?utf-8?B?Tzd4bDNMRHZTemFadHp2RHpIVHJGK1NJb3l0NVl5SlZtQ1hmQk9vSjE1Z212?=
 =?utf-8?B?bDBReHc0Z3drRlo5aERFR1p1L01LYTFaNFJLRjZzY3R2bXhjRUZNRjB4bUQ3?=
 =?utf-8?Q?7V7iJmnATEYiqZMkb1UFV1Xfe0eaWV7dv4OTw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9P192MB0983.EURP192.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(7053199007); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MU52YVpUVk5XRE4zYlRYNFEwNkpwbkFwbWRzVkVicDFZVTFBaUs5Tnh5WE1H?=
 =?utf-8?B?WVozZURSTGRjZS9SVS9JaVViM2taejU4UDlXODZhUWdvN3UxM1FQaWZyVUxP?=
 =?utf-8?B?S3QxTGQydjAvUzA4amIyb0ZNbDFCWXFZdjVGMWIyWlNIcmIwZXVydzNONmFv?=
 =?utf-8?B?SGFFcWE1Qkpib1R4V1BwbGQ2TEFxTWx6Tk9QY2pXS0pqbktOTjhnQmp5cUFN?=
 =?utf-8?B?YVh2TE5POXh2bTUrZGR4SEFUR1NRZUJkaEExVm9UMXAydk9LcWNraW00N0g4?=
 =?utf-8?B?RW0zTTZrT1c4TUJPR3VRODF1WHVBZTljZVQ2WDk5aXB2SzZJc0d4WmFNZGg5?=
 =?utf-8?B?NnFxRVU5K3ZYNWxlUFFYMmN4SDl5dVQ0WUIwOHZrY1lkdm16RWtaWUVZVHRt?=
 =?utf-8?B?OWJSRG1iZHNrb0xZMERUeEtQZE1iNUtXUHJhcElCMElZaXBaN2NiUWxEb05Y?=
 =?utf-8?B?YjJrY2RNUnZYenpMNjNPWEp4SFd5bi9MNkpOUXNkSGY2dGhvZEcydUFKT0dV?=
 =?utf-8?B?aGhJMFJTMDM2bXM2YjQzNVBTN1ozWW9zY3F4cjFSanI3VGp0TGF3bk1KVlZ4?=
 =?utf-8?B?MFJicksvNEtlRDcrQWNxcmFlZUU1bEJDYTV6cnRUdVhwbTh2VUJjNVJhUEFn?=
 =?utf-8?B?WWNTOUZUcUFIQWxJNkhXd2RUM3pPWkw1SHV0blAwb3ZZWW5hK20vcDl1Ni9K?=
 =?utf-8?B?RHhpNERtUnZlWmxLNlFxY1NqWklXMk4zTXA0cy9odWNpRVJXY2NwL0dlenNU?=
 =?utf-8?B?dWxhSGgyaGxvekorQmdKMzk2NnliYjJKUXBGazg5MnZPaUxOaXg3eVVVd0Za?=
 =?utf-8?B?L3A4VHpEMkF1VERwbUNQc0hYanRWa3YvSXNkYytZTTJ4a2JnZXRlKzltTXdK?=
 =?utf-8?B?MGh6YlEwS1hxaXJtTmNBWjZQanEzY3dBWlBGYjg3VkphTFRFdkd1a1NiWG1s?=
 =?utf-8?B?STZ1dkVwZHZlc21SQ2xCL1JkSmtLdjdncThFZEgzME4zN0t5YWpEeXZkRGw3?=
 =?utf-8?B?MkZ5SFVqVmUwREJ3QVJ0bkQwSTlNaFROSThBbEdSODRKdEhNVkZxTkhuWkRP?=
 =?utf-8?B?WjcrSVltUXlhQkJDNkVBMVY3VlVGNFBOT3BxRElkR2VQU0xjVEloRmRHTWlB?=
 =?utf-8?B?WDNISW5PdUpMNG9yQStHd0ZPa3Z3SHdNZENoMmRSMHNaOGpXcnhNUWdZZVJ3?=
 =?utf-8?B?TWpZdzBQMFlYbmhDNUhWeUdBTzBpVVJmWENoNmlWNTcrbG1mWWUwRVpvRWw2?=
 =?utf-8?B?dzRWRnBPbXJwSjJxYm04WFVRQysxcWs0b1d4YVVMdVc2WWlPcE9zZFI1bWRF?=
 =?utf-8?B?dkNyYmZPVHRVQ1BYT0FrcUlBTEUwQ1JldzQzdXVaNy91Q25leTVWdG9USkpC?=
 =?utf-8?B?Ky9Lc1ExSGhkUmNIRFMzNHVseHZBUzlEWTRBS1J2QzFDN3JxUXlYQVZPZjBL?=
 =?utf-8?B?aW5oTU96c3d4cDE0MUhrWklXNHVpS3BkYU50NFY2YmQ3WVc1OUdyaU1MbWQv?=
 =?utf-8?B?SWdVanJHZFhkeXRlK0x3UHh0ZGZERUJLS3E3REZCMHBmMTRyVmFUNWNTUm92?=
 =?utf-8?B?a3ZodE9VdjJsTjhnRmJXTzlQVWt2NXl1SU1vRUxSMXV6SzV1UlNVTkUrcHdC?=
 =?utf-8?B?REovL01idStxNE9YRFRkZDlYbHVnbC9uTVFONnJXbkdKdXZzVFpVYnFjVUhD?=
 =?utf-8?B?QnphR2F0U2UyNnJWTTB2OW9jdGpvQWlzWXFjT0hMMHRkVDkvMURSVnNvMWpo?=
 =?utf-8?B?bUg0MzFZNmNOR0h6bjk1TnhYR1ZFRlZ1NDRaNjJhejJheExZZUpPSEVjNFRY?=
 =?utf-8?B?cFRJdlQzQkhyRG1VV1RodXVVNHpvWndIQTlUTDd2blhhVDNCZERCUnZHbjJJ?=
 =?utf-8?B?cGR2VUpsTkNRb3RXdTZRaUJuOTBlSVJlNVhoZFR5UENiOWVlSXJwZk9nQXVM?=
 =?utf-8?B?L3luNHdiR3VjQ2thMEVGUkhlL2FjWE9ESGVxT2RKTHJuR1paUExNek95V3pp?=
 =?utf-8?B?aTdvVXhCSVdjdkhWV3RVTmQwWm5ScnhUcVpjNnhkbDNCUlpIRzdSUm0wWm0y?=
 =?utf-8?B?SklHdEpUdGZ5Slp6dzU0UUJsakREU3lDeHFOSFhOWXpDWEF4SEV3dVhWV0g1?=
 =?utf-8?B?dTV4R1VJM1E0MmlDR2V3U0tQNC9NTlFIZG9JWlNJRFA1ZWpXOWRDTlU4QTVJ?=
 =?utf-8?B?bmdMNnFqK01CU3o0RTZJMUZURHJlQkhOSzRpSm9vZGs1QTBkR2NXa0o4SFpQ?=
 =?utf-8?B?SDZ3MStOUUtydVlrZEVwU3lPb3VRPT0=?=
X-OriginatorOrg: codasip.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd5f7355-a5d6-46bf-93e9-08ddc3787a9b
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB0983.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 08:20:37.8616 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d91ffef-bb81-4cbd-b9b8-552583685f20
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YnYzny9/HAKIzvtgq0+BAR1CBVzbwVgcRb7O0gCSIEj5iLi7nrxR7FR4nQ4k3qjhkR2qKi/U7UGBxCfQkExYNkHv5hwPaMypw4Amc8Iv600=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7P192MB0772
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] sigrelse01: Fix out-of-bounds read when invoking
 write()
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

T24gMTUvMDcvMjAyNSAxMC4xNywgQW5kcmVhIENlcnZlc2F0byB3cm90ZToKPiBbWW91IGRvbid0
IG9mdGVuIGdldCBlbWFpbCBmcm9tIGFuZHJlYS5jZXJ2ZXNhdG9Ac3VzZS5jb20uIExlYXJuIHdo
eSAKPiB0aGlzIGlzIGltcG9ydGFudCBhdCBodHRwczovL2FrYS5tcy9MZWFybkFib3V0U2VuZGVy
SWRlbnRpZmljYXRpb24gXQo+IAo+IEhpIQoKSGkgQW5kcmVhLAoKCj4gY2FuIHlvdSBwbGVhc2Ug
Y2hlY2sgd2h5IHRoaXMgcGF0Y2ggaXMgbm90IGFwcGx5aW5nIGZpcnN0PwoKU29tZXRoaW5nIGFk
ZGVkIGFuIGFkZGl0aW9uYWwgbGluZSBicmVhayBhbG9uZyB0aGUgd2F5IHRvIHlvdS4gVGhlICJk
aWZmIAotLWdpdCBhL3Rlc3RjYXNlcy/igKYiIHNob3VsZCBiZSBvbmUgbGluZSBpbnN0ZWFkIG9m
IHR3by4gU2VlIG15IHByZXZpb3VzIApyZXBseSB0byBXZWkgYXQKCmh0dHBzOi8vbGlzdHMubGlu
dXguaXQvcGlwZXJtYWlsL2x0cC8yMDI1LUp1bHkvMDQ0MzQ1Lmh0bWwKCi0gRmxvcmlhbgoKCi0t
IApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
