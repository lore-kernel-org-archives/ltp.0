Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BAD3C433F5
	for <ltp@archiver.kernel.org>; Tue, 22 Feb 2022 16:09:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B970D3CA1DB
	for <ltp@archiver.kernel.org>; Tue, 22 Feb 2022 17:09:31 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 08ACC3C8F91
 for <ltp@lists.linux.it>; Tue, 22 Feb 2022 17:09:20 +0100 (CET)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04on071e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0e::71e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 4BF6A14052E8
 for <ltp@lists.linux.it>; Tue, 22 Feb 2022 17:09:20 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=he2qr1kzVY181v32MbrkavNCodZ1kF1mXuX8rL3Dna0DD6KUa4TVupQ1qEuiKyQ6ARe9HmJ2KFv6gVIBto2HD/p6ScC0Gmpe6/kZ7WmKbcIaeqrVowdCh+HMBrq/QH7GB/5r/sbknhswNtKidxoQ8Mtw2fxuf0yDMEC8D9L0Q+1dmJIQh32dUtDVEl1bTCDNN8BW/QC0LRQHXVm2E+gosiTUIqXBypXOP4M5Q1gfwfeJ1iPjSaXvm+6WHx61iwj5oP1V5rHWi9YfbSmCSWdKgtsRG/E1rwXb2wyCMtLauuzLReqxopmVzbZblptm6+rejbb0RSnqcP+U57lgeRgOfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NLNkJ9EoP2MWvo6/sLBUmORt3Oq8Z1zFxl2kr1aSH+w=;
 b=PeLHG7wZ4rwmBE7t19Aa8JV6MKDaSWahJ6pjT7TR3fqgJ7B0k0Ogb9c5ww8tff2fqPC4PzAf8C68ZPYbXiDGb7cec2HK1pV1CBeyZMm9WkI9hvkOF3teQ2ED0o1g6ZJc8lJO6ebi+LE+BoyyevYIJKz/Kz2DoGpWxSslew9ORF20sceC461Ih85J8Tg6mxXmCO7tmGw0F73EY35UNBbZ7hmQeBbyJHvwujUGaC1zvQetd0v8P/Q4gpH6lIAjWORop136rt92FAhlBaBJa6WxDYVCOvwnueQNIs0CtudLoHlOE+bB9cFCF7/30N72cdDcQXjKslZK9/ehE9AFsRhdBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NLNkJ9EoP2MWvo6/sLBUmORt3Oq8Z1zFxl2kr1aSH+w=;
 b=iFc5RCQgdDhy0ii9phxD1iIRB5UdlvdNNHxBPIxmozKNFIycjUFwzaBifCQrjTgu/O2iwkWmUiKv7nKjzMIAoaaKW9vdwlJC2tSf7uD2F6RDdvFnEXcICj4YWy9h8e42tXYdZxt/YFS9FZ7v1RfK8wa3TMYInI5tzxFVznr/ZTM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VE1PR08MB5630.eurprd08.prod.outlook.com (2603:10a6:800:1ae::7)
 by DB6PR0802MB2167.eurprd08.prod.outlook.com (2603:10a6:4:83::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Tue, 22 Feb
 2022 16:09:18 +0000
Received: from VE1PR08MB5630.eurprd08.prod.outlook.com
 ([fe80::316f:48ca:9e97:4660]) by VE1PR08MB5630.eurprd08.prod.outlook.com
 ([fe80::316f:48ca:9e97:4660%8]) with mapi id 15.20.4995.027; Tue, 22 Feb 2022
 16:09:18 +0000
Message-ID: <26fe8a19-8557-5a63-7e5f-fb126e8eed95@virtuozzo.com>
Date: Tue, 22 Feb 2022 19:09:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To: Cyril Hrubis <chrubis@suse.cz>
References: <20220222155514.2255913-1-nikita.yushchenko@virtuozzo.com>
 <YhUKtWP8dwNBAcmy@yuki>
In-Reply-To: <YhUKtWP8dwNBAcmy@yuki>
X-ClientProxiedBy: GV3P280CA0100.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:8::14) To VE1PR08MB5630.eurprd08.prod.outlook.com
 (2603:10a6:800:1ae::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d5f29ff1-272e-4b73-971a-08d9f61dad90
X-MS-TrafficTypeDiagnostic: DB6PR0802MB2167:EE_
X-Microsoft-Antispam-PRVS: <DB6PR0802MB216734A03AC609E79ADDAA1DF43B9@DB6PR0802MB2167.eurprd08.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5mObvoCzNvgTVugmTiTlSD1ET9IAQXNAaAVxc4jcUjriY5fSJYmdrxcxQNbAuU7AIuj4rx4O4znTH8cDjjLp5eRuDCoGPSyfP9ytQ4cpiIq6ScsponYOLQw279VPkUV4ZjK8I3q6G32Cw2KFJpwqsmm4XGTD7O6anrrOVxLdKE85YH7CWKS3BGxVtqi7eLEvDGNaD65SZPYglMdWdWv2MuOj+9NBD62o48+koeRZADQOw6cpGxDH+E6PR7OPNHTEzAjr4AEKuV10kew1mDF12QWLkQcQgvoEuiD4mlPhIaWGcHpth8rZmHJs5a9Qim6SrNerNKoYzrEIdYnEqGhQNmb8wPUeBVpIK+BGLR1O9RdFkiQC6yVmWzWY2PmSoBM0Euj9BEFNF9cX97GU66lD2ouihwDXkDAVwTSAEzNTn8wkRx5BFxqHGvyE2KIvTCmSwq0yHqnqvj/UnlmsfTVloUl6PXIlC+l4ARR0b44jkNmx6B6X4Bj9gP68jR8+bVMfDcQz4fNmMb16vzzv9zXaMTe3F7aapGXbZzACPAtJhaFoHdRw0976Wh4JjADRpM9rf01nb1di6B9tOuaBRSr2tmVK5uy/qtwJPLfwTh0IVT8or3aL/x9fh0T7Ui5EKZ8kMJF6WVF2le+G8KPtcLl2+T+7xHBpxSDt2su4F2NxbSfVlTHjIbeMbV+Gq5+kJPVT+xgtFU9Og7Pn2ofLOrTmcYUY62SP/Qxwsit+SPIxp4g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VE1PR08MB5630.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66476007)(6916009)(66946007)(26005)(8936002)(66556008)(186003)(5660300002)(4326008)(86362001)(31696002)(8676002)(316002)(44832011)(4744005)(2616005)(31686004)(6486002)(36756003)(6666004)(6506007)(2906002)(38100700002)(508600001)(6512007)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QklBZ3hBMWk2dFh6YlNub2JBVXJoY1dVTmNzWWlsY1BrejU3dzRVUG1CY0JF?=
 =?utf-8?B?cXZoNTZuQXJmcVd4VC8rWFJPVVhFeklHQmRQOTFXeURwMCtJRkJJdC9MVC9D?=
 =?utf-8?B?dEhQY1BIeGRMNDZaQWtIUjV4R2N6WmNYQ2NjLzE3bU0zZUh0YUlyWXRwSDlw?=
 =?utf-8?B?SzNPb2dpREtyRGhrMlhGdEpjSDVJOUlTQUlUZGpueG1IcE5PbUMvNng2ZEpE?=
 =?utf-8?B?WjN1VlkrWUZSSi9pQTZKS0JtWEphZDg5NDhKRkdrRHJ2QTZuVjYrSFhLUUFz?=
 =?utf-8?B?d1lyWEZ2RS9ZVHZ3bm11ZzlBUE00K202OTM0Z0Z3YWJZL3F2bEJQMmx6cEZS?=
 =?utf-8?B?QVFheWxCMEZFclFPWXdiNTZNQjlqWFJMdW81d2Z0SmFOM1BoOUNQRVcvdjIz?=
 =?utf-8?B?MzBTRjlnRUc5MEx4d1g2TjlZNmdrZkRtY3A3aGJMZnpyZkRZRUc4bjBhM2J3?=
 =?utf-8?B?THExUHFULzJPbDB3SXY0T3B3MTJvdVRxclpWKzVHUmUxSm9oTldXaC80V0NN?=
 =?utf-8?B?a2prcE0zQnlIWmtiYlZZQk9IbWJNVmJIbnYrY253bWM5QWVkbGpvQ1B5KzVS?=
 =?utf-8?B?dW9adXBTYmFHbjM1bG9HTnA1bmZnNGxUNkcyWi92Q3FFc1d4N1RHOWtkRUpR?=
 =?utf-8?B?bTgyK1BCQ2tCcnR3WHhJditHeXRjTDhrbTIyRlhPbVJka3l3WmMweHFaZUFm?=
 =?utf-8?B?bk9mTXlycVV1V3podzNXSVkzdmNlWENZS25OZUV1QkFwWEltR3RwYnN1SG9U?=
 =?utf-8?B?UDhBWEFRNk5EcWRRd0oyVUZmN1g2WnN2SUlpaktkalBjZ01WQ28wdzYwb2tE?=
 =?utf-8?B?cCtrSEVoaEJscVlKb0p5Wk1UYkRZdHpzck1ZSGhlem1mQU8wVnMzdTF0dnFG?=
 =?utf-8?B?eUwwdzFkQlNVSGpjRGdRR0ZtYVkwUldyakE1YklxdklCcWZ6MFBuSTRoVGhP?=
 =?utf-8?B?eHRhcTBBOVRDS3JNMi93Y2pTKzI5bHZHTzRrSFdSMFhHRUI3QmNwd1pnR3I3?=
 =?utf-8?B?bjJhOVpRVXB3ejNxTGt6bXJyQTc2cFpvMnFmRTNxMEFGc001TlZZVVcyS3NI?=
 =?utf-8?B?MXZNUWd6NmU5OTFEelVsZmZDZ2ZRYzRzbmZrL1JGbUczZzlyczFPWFlMS01I?=
 =?utf-8?B?aUZtNmJNNHN3ZXd0TjNOV3BsaXRsN2QzemowSkRPd01DQnJwQXpSQ1krN2Fv?=
 =?utf-8?B?RlZNZmZoQnhncXBDby94SmtCVTlqcWsrK1IrTXJaaEw4c0U1V0UrTkR6MVd5?=
 =?utf-8?B?cVJuYjljY0V2UlgzRk5mZVJBa2hvRm5oZEErZ1hGL2RKVzRMa1Y2eCtlcU0w?=
 =?utf-8?B?OUlzOVNuQ3BDWmprVkNyTTQyL2xlUVNXbWdDY0FiN2Q2M2hRK1lXamU4UnlX?=
 =?utf-8?B?cVYyUTljZ1dDNGhYT0Ixd3V0dWlKcks2bVZlT2RvVy9lOHUvNnF0bUUyVWps?=
 =?utf-8?B?dHVIUDJzemVxRWsrZTJuZVYyQVlkRG5ML290TTFPTUVabUZMQkpkZ3hJNVRT?=
 =?utf-8?B?YThXZ1U2OGx3OFNqV0JQcDM1Q2RQSk5OQkd4azFPTzJySGNxUWpmaWcraFEr?=
 =?utf-8?B?N2x6ZHpvY0VBZ0RqUnNIeEhyZ3hIalNETVIwL3UwOGdNNzEzeWp2VG8vMjZJ?=
 =?utf-8?B?a1Z0MG5Ybjk0bDdRLzZvMC9mYWpXRndaL2dsTVkrZ2h5TWdDMk15WFg4WUhI?=
 =?utf-8?B?NndrR0ZFQVZJVFY0Z1dYS0xISkF2WVdzNjFLM0gyaURXWnVwWVJOSDIwa1NV?=
 =?utf-8?B?bEc3VlpZVEEwQ0ZONDFGVDdOUGtXNTFheXA3QVMzMHhmc3grbnFYTEZ4ZDdR?=
 =?utf-8?B?Y21NVm9FTHo5NXlDWjZsQWQrSitpYUdaNDBHSUpzNGM5a1praWxhQlFmN0xn?=
 =?utf-8?B?UkZ6WTJVaitEc0VFZTFxaGpIdHBEM1dyLzRmUEdKdTZGT3ovSGhmNXNPaFg2?=
 =?utf-8?B?QkVBaXgrMlBQVmVZSHJpTmd1ZGhYbXM5YVFJekVhakc2QmRVK21XYy9EMk9O?=
 =?utf-8?B?TkpWUGxRR25uMkNzRUFqRzJvcmVHVVVBTWc4Z0NTY2Fvd3JESnNNK2JJTHd6?=
 =?utf-8?B?ZU9YVmdOeDZVcWJ6Y1dFSis4ejB2NVlnWTcxTGZaWFgrK0c2TUE2NlBPbS9F?=
 =?utf-8?B?aVNPb2UrZ3hmSnVLWjFRTzZzVDdkR0p6SHpKY2IyWWh1MnlsN3hXb0lFb0FG?=
 =?utf-8?B?NVU3WDMra0t3YlozTmY3TFRlRE9mVmdTN2s4RGMwRHNOR1kyLzZTS0xudmVZ?=
 =?utf-8?B?eDRZOFlIcFNQakF1WTJBZFVhejlRPT0=?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5f29ff1-272e-4b73-971a-08d9f61dad90
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB5630.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2022 16:09:17.8554 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LF4IlAdPcaujvVRyg91Hz/e0Q7zJ4VtsTZU4EyjEQzr4C5+3u8D/zlHUpTw9V9jtyidbYtXVduq1A5Ci92KZJdb+aJDIVX6J2UWqlufJ9oA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0802MB2167
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] testcases/lib: introduce sysctl wrapper
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
From: Nikita Yushchenko via ltp <ltp@lists.linux.it>
Reply-To: Nikita Yushchenko <nikita.yushchenko@virtuozzo.com>
Cc: kernel@openvz.org, ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

>> Linux sysctl utility does not propagate errors returned from proc writes
>> to it's exit code:
>>
>>> sysctl -q -w net.ipv4.tcp_congestion_control=dctcp
>> sysctl: setting key "net.ipv4.tcp_congestion_control": Operation not permitted
>>> echo $?
>> 0
> 
> I wonder why we use sysctl in the first place, all that it does in our
> case is write to /proc/sys/net/.... file. I guess that it may be easier
> if we just echo the value into the corresponding files instead.

LTP sometimes uses sysctl under 'tst_net_run' wrapper

Using shell redirection under wrapper is quite tricky if possible at all.

Nikita


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
