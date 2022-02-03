Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBD11C433F5
	for <ltp@archiver.kernel.org>; Thu,  3 Feb 2022 09:22:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A4B783C9AA6
	for <ltp@archiver.kernel.org>; Thu,  3 Feb 2022 10:22:34 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7E61F3C95EF
 for <ltp@lists.linux.it>; Thu,  3 Feb 2022 10:22:25 +0100 (CET)
Received: from de-smtp-delivery-102.mimecast.com
 (de-smtp-delivery-102.mimecast.com [194.104.111.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id AEC2C1000D15
 for <ltp@lists.linux.it>; Thu,  3 Feb 2022 10:22:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com;
 s=mimecast20200619; t=1643880143;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=D7ZzY/VJyEAWh8vbt6ycW8XF5IOdzKlrj4OkMLwFmcw=;
 b=L7cjeRxEbWMg6bHn84TqMR47DXeYQzzLkeDHqd+k/84VFSlm1TlQncsTT9KpDIsPCiBEJI
 gWSKY7OBfdYSdlRUsZu09FFTXBK6yooqSNzfvEPqGi5O1cgxCRm1K7q+f6HrB6zIFk+EvV
 gC/6+tUB/pyebArJmk5s1EJS3EhB5s0=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2112.outbound.protection.outlook.com [104.47.17.112]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-36-zKm-7YtQNdqRvdfaaK64RA-1; Thu, 03 Feb 2022 10:22:22 +0100
X-MC-Unique: zKm-7YtQNdqRvdfaaK64RA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i07j8hBp6dFtQMZR838Sw6cjB8ATu3s2XvQhuQsw00e6eaRPBEhle4NVTBeD1GtiwbkPxO09u2cxbgRdYrY14ksxgAn8cZ8Ivjnc9wfNZQwMoljfDGn/hhjaIFThMicl+IfkuZRLAj4MYETm5ia4E+Ad1ystISq25TTlLuyGTyuWsvI1DfjrMou494Fr+D2WVswcdAlnjvt9ETC8fi9Elcpva2QXwwkVi1X5TG1vm4fnOKCbV9mEL9VsQQupkKPoS51NjipQR4E+xDRj2s7AqX59J7VsphmZRXeyC4qP9gRN9aNgzJf/WTxw6XSfAxio1Iewr7qpLsqdCpuSpKwROw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D7ZzY/VJyEAWh8vbt6ycW8XF5IOdzKlrj4OkMLwFmcw=;
 b=Y1BRwoHZUZAWFtFkf42f7d0HgWlmXkUrE5Fkx2ihm1Kl4WEgAdJy9PC5ictqBojQx9tMjwV3DYfukIgiSIp8SXhNa5k3pY3ELjKcLrOH6W58Dp0GRshxuiQOS4wYlgNondxo7cTFJCB4aaLc5LFPDFvOmZfiskY5gFGmGhl/oLp3IXrLTu94zy62xvL+DMkfG2KkIvjMvCPd+GLLaYVihtNYwDAdJxEonyRehA5BoyBrcZkXcAU98HZSpaWrJVOLEvsA4FTtxQoliEIln5Qwr6BhtGHYqTse8qkCJruLrZJO1IXEMKAYWvIqa3Iy2VblS07sq8SZGEVUeZ+KfbY5pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by VI1PR04MB4046.eurprd04.prod.outlook.com (2603:10a6:803:4d::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Thu, 3 Feb
 2022 09:22:21 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::69ee:ea32:8cf8:2e02]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::69ee:ea32:8cf8:2e02%4]) with mapi id 15.20.4951.012; Thu, 3 Feb 2022
 09:22:21 +0000
Message-ID: <1fbbeba9-aa4e-81b3-0b56-c92b9b7d8356@suse.com>
Date: Thu, 3 Feb 2022 10:22:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Content-Language: en-US
To: rpalethorpe@suse.de, Petr Vorel <pvorel@suse.cz>
References: <20220201142230.20243-1-andrea.cervesato@suse.de>
 <Yfo5P7ZZI33xz+6K@pevik> <8735l0y07y.fsf@suse.de>
In-Reply-To: <8735l0y07y.fsf@suse.de>
X-ClientProxiedBy: AS9PR05CA0004.eurprd05.prod.outlook.com
 (2603:10a6:20b:488::11) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bcc0a6f6-4b55-43dd-8c67-08d9e6f6ae62
X-MS-TrafficTypeDiagnostic: VI1PR04MB4046:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB4046FE496EBF6375F266BF94F8289@VI1PR04MB4046.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ojBxgQwtFwaDQlUlRbo+Jvt9h+MBT7n/KGwp1F1Uh5KNXdq6o1l+r/ZWT9RCJVFqofUM3Yto+cJ7CxKsWzonRwwfEPT5zWJ5XwIG6vpAgrttkB4bpWqj1YynrkDB5OVxGtUJ0IKpBrF27KJLBoyxOe7ol+uHuhT5ota1PrMQEcP9UdKtltKWqQHoCwDemzUJuI4u5RqjJivSV1tTFBIOjLRAk625LsQm+OgxKgJh+ZMOnqpHtfiyv3xyNcsj+iC4BtLRHxcwCLlFRTz9yucKy+/65CIfaIUcAha+9tVSS0yukOYweA0YrQMngsNU/0HOKcBwB4Nl41qbd2Q/bfywnlFKuzc1AfjcbvgG+RhYhEqJ/MjqBCSbibvtYqfrbhMKNgD559Fg/n6y0xyDcNyLRv2VfYCfFhHDsiUa8yrrZ2r/q3yFPBFV6jsk2DNzQa4UyIFhzuD2xSfRhpXZZRFj3rjd58q9rrCm5+hOZiHpw/V+tQWw0Gi76k/tddWh0virSSyK0BEwcAbREp+hxLIg30e9DFdTJmx3v2ZXq801Z5CakT4MhMSu0ftwFJXhGu3zZ6ZlQzNnjlAaE6SD/0gMpR/MVX7WMFoxFveg2LgepG+f5eSApCetAf2YmSbLWt/oeGqSiNRMXk96gMQ86Y8F/yE0z53BZN1B14RenDjGnaWmcFsa1dt0IzAiJkd5hWQ2gBgnJeiNZox8ThGTlxzXXNW/bJ/1dWXK3fVPAxK13ODfcObKxluZIyp+pmSQwdpBNP6QAwKegB0WSNfIix+lLczy2XrBuCNZTkqo8h8XiYiKGmBJCBsoZ6jmkXaJFUXpdp0H+ioKy4b0F4bvakLcRC9Jti6bHb9AJPU+3tMS7YQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(8936002)(8676002)(4326008)(36756003)(6512007)(6506007)(53546011)(66556008)(66946007)(186003)(5660300002)(33964004)(2906002)(66476007)(38100700002)(44832011)(26005)(2616005)(166002)(54906003)(83380400001)(86362001)(31696002)(31686004)(966005)(6486002)(316002)(6916009)(508600001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1lIMVYxRTVPSnJ3QnBQM3h1enNYRmZidThDUDNGRDZINThrQzN6QW5JK1dN?=
 =?utf-8?B?cEUyMVB2Y2xMdWxNdm5VOWNoR2FlcFpHUVN5Y2I0SHlSTk8wWHlxZkYzMVVl?=
 =?utf-8?B?WWRwem5ETlRyTC9tdnZvdHIzT1hmUXRoMUNoQlRCU09qMXpETFNkMUFkSGpQ?=
 =?utf-8?B?bStqOGl6STRxeGcrZ0svbHc4dlNaYVVYbVVlc3JNb1ZqTDJWMkhkdU1IdXpF?=
 =?utf-8?B?N056cWJHRHJzV3JMcWE5aUlwOTMrQUxiUE5iTzlVRm85QzVtWU5kaEJSY25r?=
 =?utf-8?B?SWJWamovUW8ySDJhRk9lWi9IZCtBa3JDQjZpOUM0SjNsaUhzcGJTUk4ydUVx?=
 =?utf-8?B?NlNkQ0xYMFZabU5PY3kyT2JHLzJkY1NVdEJBaVVEa1ZDVjV0MUxPS3BLSlVt?=
 =?utf-8?B?RW5IOUV0MGtHNFBDQ0svTE05ZjZEU0JNQWxlcnZjUWM5Myt6UWtqODVsU2NG?=
 =?utf-8?B?c0czL0dwSTQ5UDlnZWNEekpWaGI3SjNDMDczSHd2anV3TzVDSHViMU9nRi9J?=
 =?utf-8?B?UEpuOUdLTVhwS2NPd0ZaNTlucTJxbHJzUUFSeG5oTlFlcUpMSlVXT0JRRnZY?=
 =?utf-8?B?V3J3cGsreHhVcHl5bnlVWTlGSEpNMExQQklnR1RNL3drdjM3cVE2Uko4aHVE?=
 =?utf-8?B?T3pXZzVIQmw0MWxaVXVsV3RueXpkcWhtRURwdFIvOTRoWGpueVpTUzB5OGp4?=
 =?utf-8?B?ZUdOcjhWVGZvQXhqL1pwZFFRWTM3U2c5ZUxqTjNxVHRxT21wbTZRa2pSTEFx?=
 =?utf-8?B?TzJjM1JNY3E5ZEJTaGVTc2RCTzlscWFyTWIzVVlKNEY5L0JUTzFTemxaYVVk?=
 =?utf-8?B?eDN0OUc5WWhtUDZKaUpqVCtWS0pqNlNuNlBHSkg5aTVHTHFVUDJ5VER4SS9Q?=
 =?utf-8?B?dCtRUnU2KzFGWHhzcWRkVy9DMmZUeHZhUlRJR3A3bjZXdGVvZTYwQzYwYzVV?=
 =?utf-8?B?cG80dmMwYnZNUGZhRlF6ZCtPNzk4OGxVaUNEcXVhNXNpY3NpRjc0ZWd1ZTRr?=
 =?utf-8?B?dEp5NENqV05FaXNsODdBdDlqbVJRb2FLYmRpVGYvZmdnQ0tVNDl4LzNGMThM?=
 =?utf-8?B?MUs2OGJDbFVCQm5QcnhwRmlUOE10SGVFWXYvNWVjMEk5d2R2d1pETE9JK0xw?=
 =?utf-8?B?dVRxOFRYSUhGZ1ovUFJUUWRXK0hjNVhJNnBxK2o5MmlOSzVqK2VURCsyWUJu?=
 =?utf-8?B?eE5MVFhwL0lmMVZMYnIvbzN2R0VpYmRLcnphbkIvcjZQS2pKQ1k3b08xN3VD?=
 =?utf-8?B?WHdhRVZ5OWVOQjI4RDBlVkZzRUhKNy9RWmVGZy95WDhhSjhtVmhrd0F6QkY0?=
 =?utf-8?B?eFlnTnJPSm5VdC9IY1pvR3pTTnF5aWpUUUtFU014TUJMTEIyZkdERDlmbFcr?=
 =?utf-8?B?K3JsSE1iaHF6TDZYYmZSN2ttcnRXUWhuckVuM25xMVYvWmlVbXBETUptREY5?=
 =?utf-8?B?Nm5OcVZHWWRzMHRSNWNxeC9KWUlhbUdYeTliQ2g5dUVPeE5qM1B6T1pFR1M2?=
 =?utf-8?B?R0lzUm45djdHZlo3OXl1UWl1ZkFQL0tYYzljekMzWFdqbStjZ1liT0xLQW1q?=
 =?utf-8?B?TmJ0eTVrNVliSnpTQldrbXpkZldza3FvbWxoSGJFMmx0Q1g5Tm9yeHFlRTNl?=
 =?utf-8?B?cTNSWjRmc01UZU9pSmtUZ1NGZU84amljM3ZycTdjTjloaS95NHhYUGhVbVNm?=
 =?utf-8?B?L1N6T1ZSU28yS2hnN3hxU05INXZlQ2hTVkhFVE5JckJ1SzdXdFBhWnVEaVpP?=
 =?utf-8?B?OEdqeFkzR3g5T1BicWJhWmEwcmVSL0trZ2pIZmthbG9xZjFYVmZDRFpOTk11?=
 =?utf-8?B?L2hvbU56ZCtBcTFUUHhvSlBKUEJmbmplOUUvd0NIVGNOL0ZyVFFQVDBoNDd5?=
 =?utf-8?B?L2pqSUhBY3h5M1FPWVlvUlZ3V1MrOWRndFRvWnh2aXh3a240RDUwckoyNkxQ?=
 =?utf-8?B?S0t5b0NyUnRvbzRObk51SlhFYk45NEFsV1pZYkhmTjFoNXkvRUlTcjR5L3Nq?=
 =?utf-8?B?blZVbGpvTC9Oc0N2ZW5MMDh4VXlzcFF4dk9oMEsxUnpCUnk3VVprcEMzOVJE?=
 =?utf-8?B?VGVOQmRhNnp2NG9oYWVxSnc4SGJZMXlVL2lnNVRuczIyanNocWdpczVWdkdx?=
 =?utf-8?B?RDl1b25DT2tsK2pFQkZxZk0vQ25NZVJCaHYxeDBlL2c4bEsyUndUYXU4dUVY?=
 =?utf-8?B?TldyaUlVRE9VbUZMQjdQN2FTQUpSN0VsQmRhaXl5Y2RkUGJjMW5KRDFkYVpa?=
 =?utf-8?B?ZWc4cmdLRGd6N2t5c2FUQ1ZNVUV3PT0=?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcc0a6f6-4b55-43dd-8c67-08d9e6f6ae62
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2022 09:22:21.2454 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /6u3KMGok9Pl0UA6JPzARc7efep3PfOgPeHgBbF7wUhUBtUDQ6cM/mppqJEZYSgqbBrid1Pw0Zpzdnh6LSasjmWIX8pimYFkx1KWktcPQrQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4046
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Extract libclone from
 testcases/kernel/containers
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
Content-Type: multipart/mixed; boundary="===============0145680378=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0145680378==
Content-Type: multipart/alternative;
 boundary="------------DLmP65Np62yr2lynJZbQzzRo"
Content-Language: en-US

--------------DLmP65Np62yr2lynJZbQzzRo
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi!

On 2/3/22 06:31, Richard Palethorpe wrote:
> Hello,
>
> Petr Vorel<pvorel@suse.cz>  writes:
>
>> Hi Andrea,
>>
>> [ Cc Richie, Li ]
>> https://lore.kernel.org/ltp/20220201142230.20243-1-andrea.cervesato@suse.de/
>>
>>> libclone has been added to the libs folder and updated with the new
>>> LTP API. This library will be used by containers tests, which will be
>>> updated to the new LTP API as well.
>> I suppose you want to use it for containers (still use legacy API), which
>> already use it. I remember Richie not considering libclone.h as a good source
>> and suggesting to use SAFE_CLONE() for simple cases.
>>
>> https://lore.kernel.org/ltp/878s7k59tk.fsf@suse.de/
>>
>> We probably need some wrapper for containers, but we should recheck, whether
>> we want to take a different approach. Code in the functions is really a bit weird.
>>
> Yeah tst_clone.{c,h} is the new library which uses clone3 + a
> compatability layer if clone3 is not available. This avoids reinventing
> a cloning API to some extent because the clone3 interface is nice IMO.
>
> Also IMO tests should be rewritten to use tst_clone, I just haven't had
> chance to do that.
libclone does also a several other things, such as executing a process 
under unshared namespace and that is used by mountns testcases. So maybe 
we can just call it in an another way or find a way to recycle the 
libclone code.
> BTW we need to test cloning into a CGroup, so I'll probably add that
> soon.
>
--------------DLmP65Np62yr2lynJZbQzzRo
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><font size="4">Hi!</font><br>
    </p>
    <div class="moz-cite-prefix">On 2/3/22 06:31, Richard Palethorpe
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:8735l0y07y.fsf@suse.de">
      <pre class="moz-quote-pre" wrap="">Hello,

Petr Vorel <a class="moz-txt-link-rfc2396E" href="mailto:pvorel@suse.cz">&lt;pvorel@suse.cz&gt;</a> writes:

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">Hi Andrea,

[ Cc Richie, Li ]
<a class="moz-txt-link-freetext" href="https://lore.kernel.org/ltp/20220201142230.20243-1-andrea.cervesato@suse.de/">https://lore.kernel.org/ltp/20220201142230.20243-1-andrea.cervesato@suse.de/</a>

</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">libclone has been added to the libs folder and updated with the new
LTP API. This library will be used by containers tests, which will be
updated to the new LTP API as well.
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">I suppose you want to use it for containers (still use legacy API), which
already use it. I remember Richie not considering libclone.h as a good source
and suggesting to use SAFE_CLONE() for simple cases.

<a class="moz-txt-link-freetext" href="https://lore.kernel.org/ltp/878s7k59tk.fsf@suse.de/">https://lore.kernel.org/ltp/878s7k59tk.fsf@suse.de/</a>

We probably need some wrapper for containers, but we should recheck, whether
we want to take a different approach. Code in the functions is really a bit weird.

</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Yeah tst_clone.{c,h} is the new library which uses clone3 + a
compatability layer if clone3 is not available. This avoids reinventing
a cloning API to some extent because the clone3 interface is nice IMO.

Also IMO tests should be rewritten to use tst_clone, I just haven't had
chance to do that.
</pre>
    </blockquote>
    libclone does also a several other things, such as executing a
    process under unshared namespace and that is used by mountns
    testcases. So maybe we can just call it in an another way or find a
    way to recycle the libclone code.<br>
    <blockquote type="cite" cite="mid:8735l0y07y.fsf@suse.de">
      <pre class="moz-quote-pre" wrap="">
BTW we need to test cloning into a CGroup, so I'll probably add that
soon.

</pre>
    </blockquote>
  </body>
</html>

--------------DLmP65Np62yr2lynJZbQzzRo--


--===============0145680378==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0145680378==--

