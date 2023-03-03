Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC316C678D4
	for <ltp@archiver.kernel.org>; Fri,  3 Mar 2023 14:24:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 576933CC1BC
	for <ltp@archiver.kernel.org>; Fri,  3 Mar 2023 15:24:06 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 26AAD3CAFCD
 for <ltp@lists.linux.it>; Fri,  3 Mar 2023 15:23:55 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2060b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1b::60b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 53C8F600A72
 for <ltp@lists.linux.it>; Fri,  3 Mar 2023 15:23:54 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JiE4RKas2ac5bXlN7ilnYHdkZ/EQOb2vkuG42nMUkV8AAL9V/8Dqz9bDx/nVHfHtHvI56EtpxpJ319UpV1UEalu3HsbzdEivKPKe3vNicRFDLwsyhiA4a7/vukLMKGN1igVY2wQ/nXIr9GhRQ80jCH8W3X/dXSA1eMdQA7EKgkw/QRmU8Ao1UYWNmKkErG+AoEgxbN2TiohZzBT/B+TbovU6MK9e853GgC3eSmnggo54T2W9Sx3PytZpNflza2XNUMLZ9RoCO4Yh1PdUt7AIANwcE0Ej7EtkfHh56Pzk6wYjf4+aZanuIGuQ4Ti7ckd2zxz124LUL6lCCZmgMEpzZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t+o1/LCUUuEOHK2B+FDz79hfn7qfxMHUdJRZm1mvl6c=;
 b=nK0/7P1/Ijo+AiVnlKZxRCZz7RBMeGwsmsCS2Dq852IlGo6lu+TmG77Av0tq9dx7MWe8yIN7JRfY1sjZdX05leSC+D7PVrFKd10rE17J0GzxGcv09/qbM2neFZ1m/wwfwD2FtphlgP+zLBU5eVFGWB9u+tD9pLzX5Kv3tkhLvuQrI1sFkcOcXJjo2HNxJb7tYxu88UuFbJYt/UIIsxn3rxPuC30nT/GPGwZXqRtmmoLEUh9B1y4+4sIA5RltXAHn6P1Oj841ZlW8Po89Jvn7/6gEwzzWjM3lp1Lxare1H7ArqyVjVVFFipF2dLLohPTpncGVFmwyLqrRrQgSN1sQDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t+o1/LCUUuEOHK2B+FDz79hfn7qfxMHUdJRZm1mvl6c=;
 b=ntZXhDOV4BvHwxnv0kW+jUXZKEw2Op7aIztboZtXmFE5wfZ4pqD0qIqXqh5AOaJCLSLvFRXxpVbwHLUKF0WJFgE7n3M8e6pbbr2uV4/YUooq20miZiXsUOZhZ4QvvAT5D7enKlAOSC9jlDu8qqYQmOnVkcCbYQ5+fWQgXo87U2aHHvpB0ihpOu3cR9gjJAuHJ7FvuTSwRok+bQthfauS22Ht0/+saTf0AvFnIbnnyskE9h70xe0qHPCIneQYftxmtFlIKY4LbHVP8weEux2nU4d8jL2+Jqj5O/padlmTjv5m6YEziP8f0JHOjPuQ65K9R74t5QMsJKGPmpKnj/JFQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by AS5PR04MB9924.eurprd04.prod.outlook.com (2603:10a6:20b:67e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.17; Fri, 3 Mar
 2023 14:23:53 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::e6db:281a:b03d:39ca]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::e6db:281a:b03d:39ca%3]) with mapi id 15.20.6156.021; Fri, 3 Mar 2023
 14:23:53 +0000
Message-ID: <72ff2c7a-4054-6a5c-c801-0188af5a3edd@suse.com>
Date: Fri, 3 Mar 2023 15:21:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20230303094253.20952-1-andrea.cervesato@suse.de>
 <20230303142943.GA24485@pevik>
In-Reply-To: <20230303142943.GA24485@pevik>
X-ClientProxiedBy: FR3P281CA0034.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::20) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB6797:EE_|AS5PR04MB9924:EE_
X-MS-Office365-Filtering-Correlation-Id: 957e30f0-4d73-4a26-aabe-08db1bf2ea21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xduWe0g6UDFpi4aA0U/83RIrWqsZ+MnegO8bya9VN3IBaS6fyt3m0/bQPCOwQTQB4XyP+j+R4A8luS3+TiptO3eFo7N7ltJIQLuUB58jUuax/H7os9BiAxkFYJHXX1Jl7n6Kml6BOrYxxn1QNXPgQcs4qyRl8YumpDB+xAfu5fAGR8FkdTYPPQS/TOkRRPPYx00MpXC9TQHOZ/dooSFqcQJ9tSTa7PftVxNN7lygEmI/5zp3ROuJYDvNAQRnJUwBc5POVFGpKreqET1HXh5NL7vegh+SNZ/Th1AUxHd4FMuXjQxZS2MI/hi9eTxuk1LAxq6kFWD+q7tMN1xySdFl9WCRygxdAoPCOHvJwz0ru3fSShLwcxIZfVxrz1XIZoISCJRohLYpQwMFPGfO0zFErGg1tTpLHY4BCP5T15pJmC166/bCVYnSSRQfxqBhwIqpOvrgBCBQjhoEHLpKCEXhMno/0c6yRHdGDhpZEPI2aTaserKsEOWdf3rO83RLUY7yNe7ar9Xhl1FAjC3um+Gm3mXdzWgok4rG6uebdNQy6pdjm9DFqWgeQcLlHJNsIRPUj0zRtumPaNsVQyEMGOL49qpDaHQD2aW3RSVpZL49/vg4fdqijT6m2Zomt1yq6qnqkpQcOLDyUspyxgsV+P1zTso5U7/ehi3wrIFN4y+juSr7qn0GOxf+/O1Nr54HeIO40bMq3o2oXnybdAPpc+4e7L+tSKdgbGxy+W7uUslD+tg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(346002)(366004)(396003)(136003)(39860400002)(376002)(451199018)(66556008)(66946007)(110136005)(66476007)(8676002)(316002)(36756003)(4326008)(41300700001)(2906002)(53546011)(6512007)(6666004)(478600001)(6506007)(26005)(186003)(86362001)(31696002)(6486002)(38100700002)(4744005)(31686004)(2616005)(5660300002)(8936002)(44832011)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGMwelNEZkVRUkFlOEJmbWtoWFU3dXRYam1KZEZuYTdSekFBZEZld2JJbXdY?=
 =?utf-8?B?OG5uVnpnVFRLcHBtSHg3MzFGWHZvUmRiUEtaTWQ1SmpWbnk2RDFOV1RMVE5F?=
 =?utf-8?B?dnB3WG1RSVYvSSs3SzFGNlRabWJ3elRhV3VTTW5WdklScldDb21tZU5obnNi?=
 =?utf-8?B?STB3THFrNEFYTUtqOWx0c2VVbW80YnRPREtqRjZmM0RUbDlNcWhLQnMxNC9S?=
 =?utf-8?B?TUlKcEh0SWRXVnpqY3hqam9CcUVuNGNSQkZFc1RhWmdpWDZ1cHJEWVB1bngr?=
 =?utf-8?B?WEtXdm5sTk41ajNTLy8rZlB0emdUTmVLcitaMGhQNTdHY3liYUxXcUxReFpI?=
 =?utf-8?B?RkdvRVFHR1A2V1JOcjFuYTlUYTltSjM5cm5iUUs3TjlyM1VGMWFlUGNhMU9w?=
 =?utf-8?B?NVd5RDZxMkRVeHd2RFBRcDg0b3daU1FsSUhNQmlBWWpnUHFqbVZGZHViK2g1?=
 =?utf-8?B?Y3J0RWFydG9pNTVvbzZKbXYvYUFITHdCeWpleEtnaHcvQ3dUWlhnSVJXb1VJ?=
 =?utf-8?B?TE9MYXdVdjAzS2tWOTNUekZiTGk0WEF5RSs0K1N3TmUrV2tVVDNUeHJLUm9E?=
 =?utf-8?B?dEppQmwzbVNHSkV3S0h1Y2lwM2NkK0lzaW82Mnk5Q3BkVWc4WHdoTmg5L1Z1?=
 =?utf-8?B?dVZhbWp6elkvcXQzcmxiRFNTVGNuU28rcDRjUWJ5dzRZSGZpaE1MSXc2S1ph?=
 =?utf-8?B?SFE3WWtYeHhQV1krdHJLRXI0dU13Mk5pSDgxZU5ObHU5MkxOemltUlkzMERs?=
 =?utf-8?B?WC8zNThJMm1OMm9JdDhBajdsbjdKN3hTNURYMWQwV2U5eXJNWEFVcFdVdEJL?=
 =?utf-8?B?S05ITEFHUEM5YTBSNS9FVitMRHZGTUxEcS9kT0hNMkt3bXdSTzI5eUNMTGhR?=
 =?utf-8?B?dFdvRGdlZnUzcHhLTTlKK1BiT1BFeGlzQkRER1cwUENBRG01U1hvM1EyOGJu?=
 =?utf-8?B?aVh6S0xzNkFBT21aSC9wRjhxSFg2b2FYWEZBOE5nazUwdFoxM3VQMVhlWFNu?=
 =?utf-8?B?Ujh6V2FRZlJOdjVaNFZyZW1yUVJIdmVlbnhGMGtiYWUvZWdFNHNYUXJLNDl3?=
 =?utf-8?B?N2FSTUF5cTVFZU5Hc05vakVLSThWMDJZRzlMbTU1ZTAxRDJKWDhlMjhSdlly?=
 =?utf-8?B?Q2U3ZU05OFVndFlNWldUMHdpejltQyt0V2haMHJVVWVDSVFMWEphQTAxdlcr?=
 =?utf-8?B?bFZmeFNYcVRxMzMwRkZMSU5ZcFJUZDNnMG1MQzZETGpuMXVOdlJCL1dSQVkr?=
 =?utf-8?B?TForMFNLOWhxRXBnVmg0V3NvZjluU3JDOTRvdnBoaEtCY0gvV2lWVENBTU9K?=
 =?utf-8?B?Q0owNGVtbUNCazVZZ1gyNlczVERyNDBhQUF1bGVEM01yU0NjTkFKOU9YVlNF?=
 =?utf-8?B?TEI2SytVbXM3cUh6UXdKNm5NRGd0WHNuUE5ZNTBaVWptQVVYZmtwbUhEVUxy?=
 =?utf-8?B?ZnB2dGVXbjNpbFRMZzlzaVRKOFV5UmlPdU1yK0tTNVpaTWpQSjBzY0E5Qk9L?=
 =?utf-8?B?SlpyeGtURVlySnRuUVU5WVBJQTgyenF6T2JJZVpwQ2dZcVFqMmdPMlVMRnZS?=
 =?utf-8?B?TDlrOGtKUElHSlBHODlHNTEzTG9kRnNpMXFJelVSOVAwTE9BOE1IbHJBZ0Nk?=
 =?utf-8?B?N082Tm8xcVMzcXQzY0E0cXZ5STY0VTJKcE03ODRhdHZwbjJFdjlUMXJjMUJT?=
 =?utf-8?B?WkJxZW9CWVgxUkNSYWtvdWFtMDUvTG5BTzJVZjlNWWJlOHo3SG1vMWVubUFl?=
 =?utf-8?B?VEJBRWh1T0VrV01KMzV0S2NXeU1sbDNJT0Y1dHd4SXZqbytkYVhIQUlVUmg2?=
 =?utf-8?B?ZmhNV01rR0o0MnBQbHdkYXZVUmJLUFpuL1ppN1d3N0JVQlREbXBzZVJhRW05?=
 =?utf-8?B?VUwwVXZsT2RJVnVDaktIdUtPUHBTQ3B1bzRwSkZENFh1N3oxWXlXTlZnWWFp?=
 =?utf-8?B?Y0tpYjhHWHJla0lrK2NMbG5LS0hzU3VNeXNqcVVTeWxoYzZjMlVkMUZ5NHdU?=
 =?utf-8?B?b1FZcUhuclFEbkpTMThaOVladUNJZ3Y1ejhNUk85MDY0RGdVTUxHcCtMYW84?=
 =?utf-8?B?dDdES2l3cHM4ZnZOSCtyMWdTWjVsY1Fqa2lEcmVyUy9sS081WStRUUI4bzJI?=
 =?utf-8?B?WHlFTFMrbytvR1dFUVNxWjA0ekZGeTh4OU42TDgzdEM4YVU3K0xwR0F1L2dH?=
 =?utf-8?B?a2c9PQ==?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 957e30f0-4d73-4a26-aabe-08db1bf2ea21
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2023 14:23:52.9354 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y7PefQ2/tCb/kxs5YhsP2R8CsSkWD7qiC3D6rY4q650EMYLr22lDQnoy2VG3Y3Jvmc8kVPt0ghS0bS1l6OBiLoytAx4T1JqaXxMxK2FizQs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9924
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Rewrite ns_exec tool using new LTP API
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

Hi Petr,

On 3/3/23 15:29, Petr Vorel wrote:
> Hi Andrea,
>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>
> I'm going to merge without struct tst_test workarounds.
> IMHO it works without it. Or am I missing something?
Unfortunately it's needed because of SAFE_CLONE. We can't use it without 
forcing "forks_child = 1".
> Kind regards,
> Petr

Beware that this patch will touch the whole network testing suites since 
it's used in "tst_net.sh".

Regards,
Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
