Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFF35C433F5
	for <ltp@archiver.kernel.org>; Fri,  7 Jan 2022 19:58:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 96EFF3C924D
	for <ltp@archiver.kernel.org>; Fri,  7 Jan 2022 20:58:46 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3B4993C7E7A
 for <ltp@lists.linux.it>; Fri,  7 Jan 2022 20:58:35 +0100 (CET)
Received: from de-smtp-delivery-102.mimecast.com
 (de-smtp-delivery-102.mimecast.com [194.104.111.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D67EB1400C68
 for <ltp@lists.linux.it>; Fri,  7 Jan 2022 20:58:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com;
 s=mimecast20200619; t=1641585514;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9PktX5Me43XaYV2/sUh6D3sJiwel2wNC4NpP7jV0jh0=;
 b=gsi7uXb3pH12kofBg38/4cL4CRDFN5E4paQ0stTc09Ci5wRYcNi2YEILZK+1oVLIwZiXsV
 ejezpe6GuVsF28u+8LexSVGMOqJf2fxPClnd9zjMqhys+guVN2W2H4+GZb9qRVGiL6906+
 V2z1y+qo+46B/riznahvIgpp36YdGq4=
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur02lp2057.outbound.protection.outlook.com [104.47.5.57]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-34-3UXztLd2MuadNGXYgHXAyA-1; Fri, 07 Jan 2022 20:58:33 +0100
X-MC-Unique: 3UXztLd2MuadNGXYgHXAyA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bRhsvgZjft16zPW5yb4QSjKfOxAI05RNhQKL6ACYxTwsimOENvLVjGlPCLGSAU8s6dsbmb5OFs+d1ODrSHWJO+lZvoU9LzqIDJ+y8tcpP7Vlmaig34u49I/baoWX9QxgDi0JdpMkUFTs91JcJ0s0excKu8vjMTC/rQuQRo5ktTJdXOgsco+0flMqijlSE9JMqSM0cz41SWDBU1N4ynCvzuFJcp2tocPOk03UpIazKvrjSmFoMRANgJ0aZtXwXvj/LzguYhPu/biMSPlZ/xXs2Sa+uz6NsUAqsp+MbDW5gr77fH4hnw1qLLDEd9deCo8RWVbYXBb3J4Mimyjm4cD/og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9PktX5Me43XaYV2/sUh6D3sJiwel2wNC4NpP7jV0jh0=;
 b=gdxHIIg5eE/GeJHqnebbxvMC//HLDAlxWXDuSFoPp7fvktiZmT6KxjczHpQebqf4CLj+dJsJ9HoqMIxO1LERmPcpDjq+CybcEF+HEnn5Jlu7NMRQvkVIGuZFvXRMIqtqLD4gE3x49bZsdnCFf13sZNmfaoCtYW3yBGddiaZMdtXwSK/VhOnUNH9U4VkSD8HyzQA4p0Yrhg18xHuVUdhU81HY/g52xbBjeRPzBEZ0LHK8Hc3Eis/vb93LAs+04Tr894k3v09Y3EbxkUJzcpmLZA6btTl3MVbyCne9uTOe8vIrv8JWfDWQeH5vdY7qATF/qcTf6NS8SSzmZbeMrSO29g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by VI1PR0401MB2288.eurprd04.prod.outlook.com (2603:10a6:800:28::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Fri, 7 Jan
 2022 19:58:31 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::5012:8a6:610:e0b3]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::5012:8a6:610:e0b3%5]) with mapi id 15.20.4867.011; Fri, 7 Jan 2022
 19:58:31 +0000
Message-ID: <6b4c8458-4a56-7356-a31e-8bca05e4977c@suse.com>
Date: Fri, 7 Jan 2022 20:58:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Content-Language: en-US
To: Cyril Hrubis <chrubis@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20220107163834.7086-1-andrea.cervesato@suse.de>
 <YdiZv6yQfxWMHKJh@yuki>
In-Reply-To: <YdiZv6yQfxWMHKJh@yuki>
X-ClientProxiedBy: AM6P195CA0004.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:209:81::17) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fc7ec908-ef68-4005-c2fc-08d9d218142d
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2288:EE_
X-Microsoft-Antispam-PRVS: <VI1PR0401MB2288DCDFCDFA1B12C78F9E24F84D9@VI1PR0401MB2288.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JClsvp3YAkv5b+U1FM7z7VigbCv84hVZSFBxHS86d1z2Qhmp2KLC3+rmtl6SrLSlhce5M89cbZFTI44vgFD92HGR/wwjF3i42LSpUEyKvjt2nDNFdFqvFLdS7vMGnQYK8y3ScT2OqWidGXNCeRYfvPNSgOzS99aauLZimcqhWB4yaGT2godz/z31XOhywwvSwyQhnYa94JMFKtkyyslRXE3BUJNhRQ57feyyrUspgB8fplOMC6Nfgs+zkI+/H2cUDV8f+Oo5SOrJpS5UtFjrwGS9pnCXwFDPj4t8+8jn67k11U1J3jwboe3OJRaEQsxEyMjtxxBl79kwhxfQ9xS4is96Db8lD3fqQCggr/cHbUHMrUdiskBJfCQZt7ifHmG6JrMko8OAKJ3v5AKqZCLm1ud+we6uLinVidKKdsfkXww3B5DGYbbBiSD4bZotSSp4kntvnGyLIII5SGuSfyEapOqoL0enbHgENA843ddAmjlGiYwapSr0/TNrCuOLW2YYmbbVDJ0bVUaCDmRG3qv1PTe/uKO5MxpfzDrcHXhqcY6TA/qCeyIzknRv6/IdkQBAltPdMOoK2IbH4fJzDQfmf9Nkq3B6ywckzanddT9x52yO+QdaYGN9oEL4IHDpwcKytyzVuv0Ka+rSpGt3IwSP7qn/hQHVCFsNWgD6aSetT7ip5vIaQRFROTz1Q+st+fBvkXr8U+ezBXtm9+qry0brlsp2kFFp1iJBR2WTQCnOEeD0WGRjNk8d/HtidQO/QYvsvKsYeK7BkdfitEOLK1A+Hg0Ber5Vw1PA05u369DAgpbxt9WAJPVHDR+AECNrl2ud
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(6486002)(508600001)(31696002)(316002)(966005)(86362001)(31686004)(66946007)(2616005)(38100700002)(4326008)(36756003)(2906002)(83380400001)(53546011)(6506007)(110136005)(186003)(5660300002)(8676002)(8936002)(66556008)(66476007)(26005)(6512007)(44832011)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2psWTJCOG4wT1NIMWoxV2Rwa3RNd0pSY3hUWkJ0TFVLcWJyVTdyaE1GZlhy?=
 =?utf-8?B?b0U5dHNiK041b1Roa0R3dGIzd1kramxJRmNmUzBoMjY2T08zR3hoeXcxNURy?=
 =?utf-8?B?VmRxcTM3VWVYcWJSV0tubkkxb3hpZzBvdHFoeVQ3K2puZnRtaDZ1UDZqbjhw?=
 =?utf-8?B?dmMwOVQvZGFYUWhBZnpaSDJtWVJGb0dMK2JIWnVRRjlWZnBvcTVGcURXSEJa?=
 =?utf-8?B?L3IwMkptZGhDR2N2b2R3SHFzdzl5dkd3bFVOQ21FMktLbXZyRWZjR0J5em9R?=
 =?utf-8?B?VCtjczBsUExPalhOMXJFZElNRmJHUVF4SEhRblRjZWZ4LzJraG5BN3N0SHZr?=
 =?utf-8?B?Nk5kMUZ4VWpjK0dCbTVhNlg2WWRwcHcveWM3aDVhd3NWUk9OcnFDMmg3Qkdm?=
 =?utf-8?B?MnREWXMxazFQaFU2WkN3R3NMVHk0SkJpaFlRaEdRV0RINTUxNzZ0QzF1MkJU?=
 =?utf-8?B?Qlk1cmI2WVRjaHZnc0JLY2FFcVZhZ0twcmYwUTV2VGNXYktWNThoZGxFaitY?=
 =?utf-8?B?QXFvZzBOTEtxV1p3UlF6RVZEd284S2NGbENPKzJuWUZJSGl1UmRnME80SXV1?=
 =?utf-8?B?Q1RsRis3ZmVXUEhKTXBlOUZsbWp2eDNYbHpKbWxSNkhRRCs1MU5qMGMzNGV4?=
 =?utf-8?B?M2R6eERlSTQvSmtuWWZKQ2dmU2FxZFNybUVJbVIrVHlzbDB5WnhNSWlPTkRy?=
 =?utf-8?B?dGg2dDRaQ2trU2kwdFpPRkJHbjJ0UmsrVUtDR2dtYnJoMXJ0S1dTMTd2SjVS?=
 =?utf-8?B?dDB6bDhlOUZsbTBaaDAyb1M5QjAwL3FrVXlYbFd2WlY4ZkhGOG5aRmcvbVg5?=
 =?utf-8?B?aTdGcUFOUUc4aWQ5dGxyRTh2ZEJJaitJbVhJOTRHSXhNak5IOXdlbk1BTWtP?=
 =?utf-8?B?cDM5TVBqZ0QxemdBTW5SaityL3dNV1NWamI1OVBrdjhzSTB4MUJmTm4zbFdD?=
 =?utf-8?B?WkNRTTR2R2piVWVYT1hIYXltVENJZFBNRmdnNldyU2JsM25tUnlnVDcxS0M2?=
 =?utf-8?B?QWZVT1MxRGRyRWlRTHlMY0Q4K1A1NHhJV2dIV3JGWUtndGQ2U0k4WlFKNkh4?=
 =?utf-8?B?OTF2OHZNbnRaUEhwVG5STWgrTDVySU1KQWNQQVljUDE4LzNTTnp3eWh0SWx5?=
 =?utf-8?B?czNTMEhmVkRYUURqUkpPdmlnOGU1M2tqNWxDWmRWRHhlMEI3eHFjMTVsL3RS?=
 =?utf-8?B?QnVRczZWbFpxVFA5QndpMzR2UFNFRDJZUWFEVDkySHd6VEN2SHc1L0JwMUcz?=
 =?utf-8?B?dUdpQ0ZmOWM2aUtqVHJVWHNXKzBzOE1QTFlzc2NYL1F1T0VBU2MvbnRJY21U?=
 =?utf-8?B?ZEpYUDgzZ1dNN2dlQnVndzg3TWtCUDhmUTJaaVhGL0J0MXM3T1o5cmRscWRI?=
 =?utf-8?B?aEJpR0ZoL1VPRDQzTURxWlZVVUF2NUpoQmJaWWFqQnQ5Nm9TOHEvbEhSVkRL?=
 =?utf-8?B?ekU3QyttdE9GWlQyMUJyRHJSaG8yUW9OVVp6QzRocXVBOG82K3VXTUVjcFZv?=
 =?utf-8?B?Ry9oV1hLNjFhZXRvUzJjNzFHWThHZFAyMGxXVlBONURXZS9BeWZIb0JFRTUx?=
 =?utf-8?B?WkF5c1g4VVBWOFFkL3g0QitkTytZRDkwWHRKaDM2SGkrRm9abHV6MEZaOGNm?=
 =?utf-8?B?WlpUZWdEQUplcytLc0Z1cXFlZUF6bENxcHRodG0xLzBveTZ2bjJJUXZTVTVT?=
 =?utf-8?B?RnA4bUI0eUh2NXk1UGhrT1pFaVZpZ0RDbXJ0eFhIZjBCcURYV2NYVEFzNjJP?=
 =?utf-8?B?TVJmMkRXQmVjaVN6MFhqbUlDaVpUSVJzY0s3ZVIzNlJPZXA4WXNSYzNhNE5m?=
 =?utf-8?B?cDhhMjFIOU5hZjdoOGMzVngwdWRRdFBURlpRN0txNitvd0Y2YnlZWUZNZHZa?=
 =?utf-8?B?WEhYYXh1MXlXZVEzeWIxbk9uYXpRMzBaQnRSSVE1RDdkc0FRYVppNkNXUXdJ?=
 =?utf-8?B?R1MvTHk2eTN4R0hWK2YwdHpmdHhQODJBa3p5SXNsMW5rbTRuM011Mm9ReFVE?=
 =?utf-8?B?UWlMRzI2cDN2WHY1L0loV2cySXAyRjYwczM2d1RKL29mOVFyUVMzZVZ4Wkky?=
 =?utf-8?B?WVBUN25qS050ZmN4U3dPME1lRkdDOGVmWjF2Wit0Q011MVR3RGREaXljL1hB?=
 =?utf-8?B?TW9xdFkwVlYvOTdQZmlTeDZ1SFJxNVBKV2hiamlFL3VaQ3NTejdrUnMvemc5?=
 =?utf-8?B?dXdEekhZaERwTlIrbk1mSXY1dFM5djBjcktSUGxSVk9kbmhyU3FQZmtJa1Bp?=
 =?utf-8?B?SDZJSG42YVA2L1FHYjl2MWRhaXJBPT0=?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc7ec908-ef68-4005-c2fc-08d9d218142d
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2022 19:58:31.0320 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bf9j4G3/LvdhD+ss37qRvY3/Dirx24AtnmUoVoBXYD4xw+53AoIvX+UrEi0Foth3K3qmO6NQoTEGCHMZW0lXj+/POG/8WvZuPbgYgqw4Chk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2288
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] Add wqueue01 test
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi !

On 1/7/22 20:51, Cyril Hrubis wrote:
> Hi!
>> diff --git a/testcases/kernel/watchqueue/common.h b/testcases/kernel/watchqueue/common.h
>> new file mode 100644
>> index 000000000..97e210a29
>> --- /dev/null
>> +++ b/testcases/kernel/watchqueue/common.h
>> @@ -0,0 +1,132 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (C) 2021 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
>> + */
>> +
>> +#ifndef WQUEUE_COMMON_H__
>> +#define WQUEUE_COMMON_H__
>> +
>> +#include "tst_test.h"
>> +#include "lapi/watch_queue.h"
>> +#include "lapi/keyctl.h"
>> +
>> +static struct watch_notification_filter wqueue_filter = {
>> +	.nr_filters	= 2,
>> +	.filters = {
>> +		[0]	= {
>> +			.type			= WATCH_TYPE_META,
>> +			.subtype_filter[0]	= UINT_MAX,
>> +		},
>> +		[1]	= {
>> +			.type			= WATCH_TYPE_KEY_NOTIFY,
>> +			.subtype_filter[0]	= UINT_MAX,
>> +		},
>> +	},
>> +};
>> +
>> +static const char *key_subtypes[256] = {
>> +	[NOTIFY_KEY_INSTANTIATED]	= "instantiated",
>> +	[NOTIFY_KEY_UPDATED]		= "updated",
>> +	[NOTIFY_KEY_LINKED]		= "linked",
>> +	[NOTIFY_KEY_UNLINKED]		= "unlinked",
>> +	[NOTIFY_KEY_CLEARED]		= "cleared",
>> +	[NOTIFY_KEY_REVOKED]		= "revoked",
>> +	[NOTIFY_KEY_INVALIDATED]	= "invalidated",
>> +	[NOTIFY_KEY_SETATTR]		= "setattr",
>> +};
>> +
>> +static inline int wqueue_key_event(struct watch_notification *n, size_t len, unsigned int wtype, int type)
>> +{
>> +	struct key_notification *k;
>> +	const char* msg;
>> +
>> +	if (wtype != WATCH_TYPE_KEY_NOTIFY)
>> +		return 0;
>> +
>> +	if (len != sizeof(struct key_notification))
>> +		tst_brk(TBROK, "Incorrect key message length");
>> +
>> +	k = (struct key_notification *)n;
>> +	msg = key_subtypes[n->subtype];
> Actually we have no guarantee that the subtype is not pointing outside
> of the array, do we?
>
> I tend to write the code that converts flags to names as a function with
> a switch:
>
> 	switch (foo) {
> 	case FOO_A:
> 		retrun "FOO_A";
> 	case FOO_B:
> 		return "FOO_B";
> 	default:
> 		return "Invalid value?!";
> 	}
>
> which does not suffer this problem. Otherwise you would have to check
> the bounds before attempts to get the value.
Sure
>> +	tst_res(TINFO, "KEY %08x change=%u[%s] aux=%u",
>> +	    k->key_id, n->subtype, msg, k->aux);
>> +
>> +	if (n->subtype == type)
>> +        return 1;
>> +
>> +    return 0;
> Wrong indentation here.
>
>> +}
>> +
>> +static inline key_serial_t wqueue_add_key(int fd)
>> +{
>> +	key_serial_t key;
>> +
>> +	key = add_key("user", "ltptestkey", "a", 1, KEY_SPEC_SESSION_KEYRING);
>> +	if (key == -1)
>> +		tst_brk(TBROK, "add_key error: %s", tst_strerrno(errno));
>> +
>> +	keyctl(KEYCTL_WATCH_KEY, key, fd, 0x01);
>> +	keyctl(KEYCTL_WATCH_KEY, KEY_SPEC_SESSION_KEYRING, fd, 0x02);
> The KEYCTL_WATCH_KEY is recent addition you should add a fallback
> definition to the lapi/keyctl.h as well.
Alright
>> +	return key;
>> +}
>> +
>> +static inline int wqueue_watch(int buf_size, struct watch_notification_filter *filter)
>> +{
>> +	int pipefd[2];
>> +	int fd;
>> +
>> +	SAFE_PIPE2(pipefd, O_NOTIFICATION_PIPE);
>> +
>> +	fd = pipefd[0];
>> +
>> +	SAFE_IOCTL(fd, IOC_WATCH_QUEUE_SET_SIZE, buf_size);
>> +	SAFE_IOCTL(fd, IOC_WATCH_QUEUE_SET_FILTER, filter);
>> +
>> +	return fd;
>> +}
>> +
>> +typedef void (*wqueue_callback) (struct watch_notification *n, size_t len, unsigned int wtype);
>> +
>> +static void wqueue_consumer(int fd, wqueue_callback cb)
>> +{
>> +	unsigned char buffer[433], *p, *end;
>> +	union {
>> +		struct watch_notification n;
>> +		unsigned char buf1[128];
>> +	} n;
>> +	ssize_t buf_len;
>> +
>> +	tst_res(TINFO, "Reading watch queue events");
>> +
>> +	buf_len = SAFE_READ(0, fd, buffer, sizeof(buffer));
>> +
>> +	p = buffer;
>> +	end = buffer + buf_len;
>> +	while (p < end) {
>> +		size_t largest, len;
>> +
>> +		largest = end - p;
>> +		if (largest > 128)
>> +			largest = 128;
>> +
>> +		if (largest < sizeof(struct watch_notification))
>> +			tst_brk(TBROK, "Short message header: %zu", largest);
>> +
>> +		memcpy(&n, p, largest);
>> +
>> +		tst_res(TINFO, "NOTIFY[%03zx]: ty=%06x sy=%02x i=%08x",
>> +				p - buffer, n.n.type, n.n.subtype, n.n.info);
>> +
>> +		len = n.n.info & WATCH_INFO_LENGTH;
>> +		if (len < sizeof(n.n) || len > largest)
>> +			tst_brk(TBROK, "Bad message length: %zu/%zu", len, largest);
>> +
>> +		cb(&n.n, len, n.n.type);
>> +
>> +		p += len;
>> +	}
>> +}
>> +
>> +#endif
>> diff --git a/testcases/kernel/watchqueue/wqueue01.c b/testcases/kernel/watchqueue/wqueue01.c
>> new file mode 100644
>> index 000000000..33a9de3db
>> --- /dev/null
>> +++ b/testcases/kernel/watchqueue/wqueue01.c
>> @@ -0,0 +1,41 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (C) 2021 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
>> + */
>> +
>> +/*\
>> + * [Description]
>> + *
>> + * Test if keyctl update is correctly recognized by watch queue.
>> + */
>> +
>> +#include "tst_test.h"
>> +#include "lapi/keyctl.h"
>> +#include "common.h"
>> +
>> +static void saw_key_updated(struct watch_notification *n, size_t len, unsigned int wtype)
>> +{
>> +	if (wqueue_key_event(n, len, wtype, NOTIFY_KEY_UPDATED))
>> +		tst_res(TPASS, "keyctl update has been recognized");
>> +	else
>> +		tst_res(TFAIL, "keyctl update has not been recognized");
>> +}
>> +
>> +static void run(void)
>> +{
>> +	int fd;
>> +	key_serial_t key;
>> +
>> +	fd = wqueue_watch(256, &wqueue_filter);
>> +	key = wqueue_add_key(fd);
>> +
>> +	keyctl(KEYCTL_UPDATE, key, "b", 1);
>> +	wqueue_consumer(fd, saw_key_updated);
> For some reason I do not like the callback here, but I guess that
> anything else would be a bit more complicated, so we may as well live
> with it.
>
>> +	SAFE_CLOSE(fd);
>> +}
>> +
>> +static struct tst_test test = {
>> +	.test_all = run,
>> +	.needs_root = 1,
> What do we need the root for?
I kept it there after having EPERM using ioctl, but it's not needed indeed.
>> +};
>> -- 
>> 2.34.1
>>
>>
>> -- 
>> Mailing list info: https://lists.linux.it/listinfo/ltp


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
