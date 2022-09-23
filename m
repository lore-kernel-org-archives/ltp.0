Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4E1DC6FA82
	for <ltp@archiver.kernel.org>; Fri, 23 Sep 2022 07:26:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1487B3CAD61
	for <ltp@archiver.kernel.org>; Fri, 23 Sep 2022 09:26:33 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4B54B3CAAC7
 for <ltp@lists.linux.it>; Fri, 23 Sep 2022 09:26:23 +0200 (CEST)
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr00045.outbound.protection.outlook.com [40.107.0.45])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5A9636007A9
 for <ltp@lists.linux.it>; Fri, 23 Sep 2022 09:26:22 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JdNbtfMD/bLOyd6tcHU3vDU9RYo9i9iIjNALFFhJSAKj/l7Lg8cUR12FnjQxASkKhrNvJ71/dTL4lE/gvMopwNvuJwQVT2NVA+DUukBHZEliVzvP6LC7rgJ7j7nRxSfpORsYm//1fh2mWfGGpThUdVjdSevJ+kjZMBrdzRbAi1cTzBFqBTODGEmBtSvlgn/HwGz9Ahc50pRsl0iJp9eR4hnYHHWzAeDsBz+hgK4ZsNswy/9vjti8iV0osiYms/jtHqjleiZoDf+touCq0b9yovMG1PU0ap2E3SlOk+nC1cKPnIKw/q4Pd+kDFVDWnLzoTIAot5ggopnm6F3mdQjsOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zh5+6HK3dbAkf+q+JcwAFjHyF46qu1UrxD8l4KnMDgQ=;
 b=K+stu81vbDmq/Mpq6DVcmqsslktONJ6zASwd7CulNjjp13CnqtlcB8ISUeMgprVPPYEqRsRC08RG6ZbVZsJ03ow16W0As942edyUT1Ai1ci0PDfm4cngFcsCA2ZpLqro3v6giGDa2ktQlklmpW06YeEL80LE3icdoIsGJVYd4cJqr3eCEs+bmpjKIO9uOuT5G9cpZvx26wb4+bG5L4HGwIi3q/mECJhi/gAcNWO77hyuwD8J+eCzrWkLR4aLQed7logK9dqSbp3VTemx8Uv4eOD9I3BbyPsKvYMhljNFcZYUbbGvPX41eTAZ3NoP+i9/63mP0b4K66PSJRCNbH3U1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zh5+6HK3dbAkf+q+JcwAFjHyF46qu1UrxD8l4KnMDgQ=;
 b=b4SGyBJ622F4K0oKtoZX7RqGzmux7stxOoMIsB1gytut5n66ZymYeir7qkDP6e540rUYs+pBxh4pLgN5yjRfX5CJEshl4tvmV/FMf9kw1E+4iYizTtnE/ZpT0u7ZPPNKk4IZchD3eSkfWLNaxs/lei9G4zhj3CD3vPPnXlyeWh89rEXRfYVBaR9+gItFW0/dby6bv+/cPqvr0SZEMWqRtRrZmrReG2/UKJwOpL09YbYvq0oLzmfSMkb0R0qUs5xodJV6RAGdLMb80dZgXqRHv8wlFN0GR9kBxB5HV8WFJ2p/WEtzOKErLH0pk7rclPmpQEKc9awyUJCtpf6sbdr7rg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by AS4PR04MB9385.eurprd04.prod.outlook.com (2603:10a6:20b:4e8::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.17; Fri, 23 Sep
 2022 07:26:21 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::70f1:c68e:b73f:d399]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::70f1:c68e:b73f:d399%5]) with mapi id 15.20.5654.018; Fri, 23 Sep 2022
 07:26:20 +0000
Message-ID: <dacec9f0-e0b1-a42f-9166-d9b64fd81f2a@suse.com>
Date: Fri, 23 Sep 2022 09:25:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>
References: <20220922122047.9368-1-andrea.cervesato@suse.com>
 <YyzPOkOKRpKjSeN5@pevik>
In-Reply-To: <YyzPOkOKRpKjSeN5@pevik>
X-ClientProxiedBy: FR3P281CA0104.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::20) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB6797:EE_|AS4PR04MB9385:EE_
X-MS-Office365-Filtering-Correlation-Id: c3cc9ec2-8088-4895-c45a-08da9d34e95b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IAgypItL4dw6qLZYOGejemDNph70m9vkjoGakkr9TofKfWLOag3Ee4MNFH3ZGlGi99Wq3kwZrtUpE5cFRH85Ynn0pWOzs3/TCIS884ItMZe2JmaGYxv2c7MCdc8DUAIMKgnDM3b+4gh3q4Ps3Udqu3nzU6AI+lCeOE1H/hT0SfkIDfJ1GTwzqc7U8skobLdfh0z4+1PIwA12BH+TeQFs68goF0v1P92Udh5olD0EYei9uLf8eBEVaJN9B6oupgzFw126tyWqENg3hw2cX8RfMVHOnjjWnpPnPHd7BVK8STVozp05v6DdPE2TqwrNFvPbSH0HG1RRRONf5IvgZdMyy1koPHnYZPSvZ6loRA1WlvMFGSBVwjesTQEfRrNKDGfvhScs+ucxEbHTJMYBf8phKC7vLxAlNcZFzzQlxy/zyyS4E5g3U8utowRIm6UsesG+hWFUG3kwoiIvOltSJYKOXcR6bs42CJIygTbplHRHo2lm2vAxBr7moo/foqLNs8ZrLwrz3r07eBle+09io6gVPufqeukS95ev+UC/Dut1TOBpKSf7B86To0MAQS/cTKl4xAiGgDKrDDbG+zwJomd712F8mnxcjQaOgr6RkBrLWtjRgsXFVrv6KZk7Bp+u1RWMZFmzt6R9ltFSh4tW7h71a8X+JlyADyusKiLIaIY3KreMZ6W1jvyx3FX+us8E+maetpXdM1iXnE5POpjCEIP0qDlPTR9GPZTIWKqxHH0x+B4PVOosxVDeXSsB32g6XLiwoGgQHPr2w2gHIuEWRKsmJxs5/5fczUF/jNieboH9y9g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(136003)(396003)(376002)(366004)(346002)(39860400002)(451199015)(316002)(6916009)(2906002)(36756003)(53546011)(2616005)(6506007)(44832011)(6512007)(8936002)(4326008)(186003)(41300700001)(6666004)(26005)(66946007)(66556008)(5660300002)(66476007)(8676002)(38100700002)(86362001)(31696002)(558084003)(6486002)(478600001)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S29jUTNUM2dQazB4L3RrNk5iT2VVV2hBM3dselU3U0c1RHc3RXZIc2NuUFlK?=
 =?utf-8?B?U083VVpLUWtOMzNoNVhHNEF1UHM3S2greWJkZERod0Q0eXRHZGN2R3lhSTAz?=
 =?utf-8?B?UzI4c1lnOXVxMkd1YkxrLzJBaFZoV0MxcTBRZHEyM0tDRnk3anR5ZzMyV3Nw?=
 =?utf-8?B?NElieVVTL0RWbVpDYnVWV1hzQWsrazQ5QkZIMGkxOXRyWHNyaWVLaldGbnlv?=
 =?utf-8?B?TmZ5T1FtbTgrbGJsY3RKSzlKTnhGRFpNU2ZNRTh4QXY2bDFhbFpxYko0SWxC?=
 =?utf-8?B?MnQ4UXRiVEhjYzYrb0xlMUsvVm4yM3c5dXU5WDMyc1pvL2xSOGJMQmF0cFRP?=
 =?utf-8?B?RFBKU3dkOFd0aklBckdhSHZDOWNzY0xXNytxVUxORGpoeVRONnlHVUEySS9E?=
 =?utf-8?B?SGtUd2xNZWZBV2hFQldxZjl3dGo4M044bEpsbC8rYW4ra2pjVmg1am0wWWJ0?=
 =?utf-8?B?OXkxdzY2MHJHd3N0YzhxSFlMazEwc0I1WFkrTm1IRklpdkltWGVHUFRscmpC?=
 =?utf-8?B?ZndBUlphcU1BdTNHbG0xRk9GUndodFVqRjhqeFVjSUI3d0REcEU3OVpIYnRP?=
 =?utf-8?B?d2RlZnFTbTVzV2YrbUh1OFNka3NENnRXZk11c3RTQlh3WHpmTnVpcTV1a1Ew?=
 =?utf-8?B?bkZjZnJxQVdaZmprL2lIMnFnemZad0JaK0NENVUwTTF2TzRXOFJsQVd0YzRE?=
 =?utf-8?B?bEZrQlBwL2w0WmhRTUNSMmthYmM5ZWZQSGgvQ1hRQXpJNzQwblpJaUlrMHo1?=
 =?utf-8?B?d2xJNC9pRDVvQmt2ak9lTmdMdHpBV1NQZTI0NzhFS0lLN0wwNG0xeVJhcFVU?=
 =?utf-8?B?cVlKejB0b2xhOGNobUVnbCtQN0Fia2Q5ZGJQV0VBK0ZsZFY1cVp0c2ZYeWo0?=
 =?utf-8?B?bnlxd2swRjB3dlUvclFqQTh3K0hBT1ZwVzllbUdFbytKMS9xUTNWTzJaazFs?=
 =?utf-8?B?UzVkeGQzM0pEZ2d3dG1qSE9Ba0lXWEl3TXMweWZsTFlqaDhoVXBSM2w2bEpi?=
 =?utf-8?B?bjBmS09ydGxtRTRpU2dqMlYyVHZlV1hicHJ2aHpkNENPT1R6VFovYXRGVnl2?=
 =?utf-8?B?ckp5R3NxNDNFUTNSRTV5dlMwUlU3YkFiWEEzZUNGTVFIM0tGay9UWk9Xa3h1?=
 =?utf-8?B?NDhvYU1keno4TENRU3dleGVVeFMxY0UvNkNLNDdaYVVoNU41bEpUYURrV0xj?=
 =?utf-8?B?MldjVkVEYXhibzdpdUFNeElEdFVDelpZMDNBWTlVNkE2M0NzZWhKYU9nUnE3?=
 =?utf-8?B?ZGVUNTZLbzNpQmM4MTZTcXFlUTJ3ajZGcUpGRDR1T1lXUnBMaDRvaVkvOVJv?=
 =?utf-8?B?WkJCY0YxVkJNK1AxNjZvd3RFdVM3RmJYQ0xDYXB5cmFBeE8wbDNsOXkwSjNl?=
 =?utf-8?B?VUQ4KzdKbW5kMHRYZENrdTB4NHRoVk9PZGVGSSswUDdRVktiTlFXcnk4TUtl?=
 =?utf-8?B?bmxoU3ZiU25udkZJZ2Y5RGZSSE56YUFVZDZ5ejBGdlgrOGhwdmJ0OHg1aXdK?=
 =?utf-8?B?VmNSVkhFSHNtZXpJODhTMjZwc3RZcDNhS0xFWWpKNzFCb0IrcGZ3dlFCNm5L?=
 =?utf-8?B?SnNkYkJNK1NEbWpJQkRRMUJxclVSQmw1aHdmZWdoSHU3N00yajFTNDYvcGVH?=
 =?utf-8?B?c1dianJQMW5YRCtWcDFiTVk0K3V4eG9YY0gzdm9nYmRKWjZxbDRxY0R6V3dj?=
 =?utf-8?B?dExLZmV1Y0llYVo4TG8yVFVBT1d1NjhDenJmeDM1UmFYOHl5bjllV1dHanZF?=
 =?utf-8?B?bGEyMG16MDk1WXBxUVlQT2pDRDF2RHR4TjlMSWpJOGl6dmhnRlp6VlgyYTFS?=
 =?utf-8?B?UlhCaG9GaWVzYWE0NUhEMitYZGVvNFRHUDZCV2JTemFWVVlMSXExdlBoSExU?=
 =?utf-8?B?WUQ5dzAzNG1PU0lMdzhJTHA1eXhxUTdWUWFOY1hxWittamdJK1NpSmhCa0ZL?=
 =?utf-8?B?OVgraGg5ejBqalVZUTl4YS9abnVFMTFWQU4zY1BqNVMxYzM4c1dDeXNlNUx2?=
 =?utf-8?B?UUIzWHFvUmtXT21yMnBqN0l1ZG9laTU5YVEzcGNEL0dSa2RGdktFSHZ3cmFl?=
 =?utf-8?B?WDVrR0tmMmtPdGlVbmFQeFBqSVh2NmNPaHp1aC9sUmFkcFRoVW1qS09PL0Yy?=
 =?utf-8?B?R1BuVzRMdk9FT1FrUnpyRlVxT3hubkQrY0F4T0w3Y1Mra2FjZk5iNDNuU3dr?=
 =?utf-8?B?R0E9PQ==?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3cc9ec2-8088-4895-c45a-08da9d34e95b
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 07:26:20.7186 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1n/QhAN57ZRladsr+jw4LMpSzI26PGcYS0txoF7qqN4aXLw3CbVzGwtaVwRozF8TC7aXXe5zs2osraqjpI+xOvCmx3IBOaoq6wxZ6JmlbD0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9385
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Let user decide command alias in ar01.sh
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

Hi Petr!

On 9/22/22 23:10, Petr Vorel wrote:
> Hi Andrea,
>
>> Now it's possible to select ar alias by exporting AR variable before
>> running ar01.sh test.
> Why? To allow testing ar from cross compilation toolchain?
>
> Kind regards,
> Petr

Exactly.

Regards,
Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
