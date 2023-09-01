Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64B92CA0FE6
	for <ltp@archiver.kernel.org>; Fri,  1 Sep 2023 12:52:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C96613CC5B4
	for <ltp@archiver.kernel.org>; Fri,  1 Sep 2023 14:52:38 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 137A53CB66E
 for <ltp@lists.linux.it>; Fri,  1 Sep 2023 14:52:26 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1b::62f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 3F986140005A
 for <ltp@lists.linux.it>; Fri,  1 Sep 2023 14:52:26 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lMJiyYjjo/dCrZIrEb7916pUXJBSvrMTc6s96CGoEMgN+W/94GmWHSiCNmE/KUqdbHaDCecB+Kus+qMa4OysRwrADrla9/qdKFxwQUqNeNh+o4u6zNzm9TpKbeaBePosrInAGsaTG3CxMgL+G0SApnZWM0Qr4XuI8B0qnMnH+pg1/GP7cxE4iyq/MzlunyVTKluxRtN/jZFVcCvaf0dYckE9DjC/ALrCS1YlVr9pyESyq94x0hSOIAs3rYdu/Z5+xMHaMbwvN2z2p/h4vR8xS1jzf45PB310ZWLVdPgxfH+kv7ZTyn8DSI4fZFCI6uGscF3fxPSeZWlBOROoq8tFAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oQ0/HpXSbbxSWimjvs8DCYWmaPhMP9PEyYc734O69Mc=;
 b=nMgZAHLX5wCvRLQHwKFIZf1dvq+wsIYiIhOaeJyIqKAhnmUdgyTMR9IcCj4PzEu1HcMo9XOD/DEDJbkQuBOB05qPye7snxNQZA1ycdy4/OA9yTzgqiGDVAukwz+SicFzFcAzgVTC+uGARlpAyUDvqMO/OxQfBxTBFReehKxuWC2bJAke48Lthoy0+hl/9/86neobfCr8Sgxj+CNkYDhp2Y4IrhgTYW/3LnFx70Zs06AlnTS1yb2s7lwwxzIMgNtHRPZjPKPq43LS1lbId4rsvNwHYJKMXAejQNqKMcEgdtvB3iGsBls4Wpd/XZtr14P4ONzlyEWdpYqClJkmhU74Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oQ0/HpXSbbxSWimjvs8DCYWmaPhMP9PEyYc734O69Mc=;
 b=bUrp9nZlmmhkXfXcgrD/B/RvUg9lSnGkFUsWYyk/BxWJ4I9v6XrxpiM6WrNr2iTqQt5j89U2rOKnGGIX1Y2zXWQX7AhhDsaXnM74ZEd5NYAOxMV2xXaPWp9JEX2z/giDVwDalrvZS951YLNQMRMobyLVTf8P9DIzVuyPWYyrMIXNQUguqk5kQCDWxnoEoDR9KJjhvtqVYdLWd4zZcXyzQzeEpsceKSgdJDS5Fba9P+PU3FjhMQdb2un1GOTbEgh/Z/i6mkHgy2eq8btLYH0lXhj7PKElGW63pVeYuTE5KJBNIJVlqNvHciJDB3WHvZs4IzCRbSmGnmh4Vwl7u1fUzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.26; Fri, 1 Sep
 2023 12:52:24 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::c33:be0b:88be:b96e]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::c33:be0b:88be:b96e%4]) with mapi id 15.20.6678.031; Fri, 1 Sep 2023
 12:52:24 +0000
Message-ID: <7058a129-f1b8-4a52-a6b2-7c0fd6643dee@suse.com>
Date: Fri, 1 Sep 2023 14:52:20 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Cyril Hrubis <chrubis@suse.cz>, Petr Vorel <pvorel@suse.cz>
References: <20230829073821.2580-1-andrea.cervesato@suse.de>
 <ZO8d3GO_jFgNAXNY@rei> <20230901103758.GC323151@pevik>
 <ZPHWK_Msrqbpmvtt@yuki> <20230901123126.GA343678@pevik>
 <ZPHayoB7_I6Xy8-k@yuki>
In-Reply-To: <ZPHayoB7_I6Xy8-k@yuki>
X-ClientProxiedBy: FR0P281CA0165.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::13) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB6797:EE_|AM9PR04MB7586:EE_
X-MS-Office365-Filtering-Correlation-Id: b5bf6fb8-625f-4872-2d9d-08dbaaea4a19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ccpMELzgSZ3i6Kj5V4CmS7rFt3snUspjOHcYEScQt4xQjMaZALY0s54k8RCop2FBSntqGO4tAEfWvtxzM60CXphgnrRpt41zikB8bYAFwOgJ6VwBSfgvfJw8vuL7sgLg+Z/znuXkFBYNuNPQz4nbVegVSVR8dyZk3+4BAb9wogzpQrmEFjM6PMS4d0YvAzf4SOjrYIOz8izC+5GQskl4ABXJhKJaJ2KNGphHBQBKlAo7hFBiIcRSZGNMc5+6YT2BvEE640K9lndX4ZVcBluuwHnyk83493IgyF6f2jUZ6B+Gn26iDCa2OFipp0/g+rU3wYb2b54t1Z/Egfvu9nCZGkMJ28kHXmCmfpyIbXYIsrr6EX8hDP91RD1vkF3goPnicX1z+S8lu0WvhfycOetZUeHIISFxHm/KwWofQcdNF7OlBYAzi53n12ONVTg+fjWXkrnzecI9CUCZ5t56UsJAiQ6Qx4sjSB6ALIT5k2rN+M8g3Z7IrvjCzc3xjMRCp66Q8EdyZ3WMUYr2oYZEauatp4wKoAkS0l4+T/upD++G/1nAN6CafT18/8iH1cz/QezEsxoJsU1K+0LKdPBWqOlDEzy/eGYy9YeFNQZVrT92T+kcMZ2sEn1tr3EDa2WJTZo9u9p0c25DDUEUuo/UTeU/gQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(396003)(366004)(346002)(136003)(376002)(451199024)(1800799009)(186009)(6486002)(6506007)(6666004)(6512007)(53546011)(478600001)(2616005)(26005)(2906002)(66556008)(44832011)(66476007)(316002)(41300700001)(66946007)(110136005)(5660300002)(8936002)(8676002)(4326008)(36756003)(558084003)(31696002)(86362001)(38100700002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXpDZVd6RHQ4ZG1TTGIyekNkYXg1d0NhYkFqallCbVoyRThWSEtxdVRMdFg1?=
 =?utf-8?B?dnZYdVhCWmZnUWNzWExybkE5SW5uQ0NmZnRCWEJWQStXZ2wyQ2RxWG4wdklQ?=
 =?utf-8?B?ODVEckFvbUU1VVVONlBjWWw5SXF2UHJGK0lndFlVN2hIQzVYRkJDUXRDRitq?=
 =?utf-8?B?SXlPS2ZUU2o4ZUxhRnBQWjd1eGI3WWVJNEZmU1pnYUtrMWQvN3hNcWQ5K1Nk?=
 =?utf-8?B?ZTdtMmdrZ3J0YTQvaG4zUVNEREdVeWp3NmFCZk8zRlBnMGdtcHp0cW5WRkNE?=
 =?utf-8?B?bmZtRWowQUI4YVQrQmhCQ1Q3WFltcEFqVkJiZk95eW8rK2UzbkVjOUF3aWYv?=
 =?utf-8?B?RUFTTnZxbVFSUFZmNDdwcGVHUGhjNytUQ0UvL3dQNTB5eVBIWWVnNWxiLzB6?=
 =?utf-8?B?T3ZnZU93Z2lpRm1DZVFUejVNL1ZOOFZJQmI1LytYR1ErcUpNNmUyamNXbzJK?=
 =?utf-8?B?ZGRONTdwdE1iK2pDVGFOVmhGWHVSaVVnd0FvNjhYK2hwSmhMUkV2L2ViQ2Fs?=
 =?utf-8?B?Z1pFUnB3OVYxL09CZU9SbHlKSitLcnVaUmMzVVJRdnFmRTl3VWt0bytUcFk2?=
 =?utf-8?B?akQ3N2hndWVXQUE3VWRGY3hYVFBXSjI0eUsxbDBOcHpKZStuOGUrV3Z5Q1p5?=
 =?utf-8?B?YVUvUDlJY2xqdmJ0U205dEFwc3BWc3k4RlhQamhCaGZ4SGpGb0xWZDhXR0tW?=
 =?utf-8?B?WFIyK2FIbG95UEtpYlRMRUtsUzNIdTZCWUVFQkh6RmUyNWJzbDVtZlZNTGkz?=
 =?utf-8?B?SEFQMWVpNUFwR1hwRzZMQTFOM3pWSENyUHVkK09YRVpmUXBnYjdFMmNDalo1?=
 =?utf-8?B?VE5MYkRTQ21qMTRLY3JiZDlyNURZalN6eFduUEIvakQwVDV0VGNZSnFRR25F?=
 =?utf-8?B?cFFsTnIvamxNeFoxdUh0QlZ3dFRDaUtqUGl0RTJTRmdseXNxYVpndVkwbVpS?=
 =?utf-8?B?Vis0UDR4UWNxMU93dStkb1BsaXVGYjJzeFFUbzg1L2FpTVpKTjRPZS9ZbXBL?=
 =?utf-8?B?dTMvT0VkMXNNQ3FvRTl0MmNIZ0l0VnQ5NEJiT0ovYldqKzZiMjJZRVJoU2hC?=
 =?utf-8?B?d0JpWkFmVkhXeERuODVsZmR5QUk4ZS96b0IvYVVZWVJucUxaRDBaVWExd0FC?=
 =?utf-8?B?QjUxS2ZtSStZV0NrcGZibzlXRjczZStMQXUxeEJvRjk1MzlGYVVPSmNWUjE2?=
 =?utf-8?B?UWtXR0ZWOUhQVnRGdFBFVUhlRUphc0JiZWVOai9XVWNwbkZITUs1L1RXSS9Z?=
 =?utf-8?B?eENKTVhteFQvY0ttbUo1cU1vSWlIcHlTRDUzWGdLN2cxV2Q4aHZlZFo5M1Fn?=
 =?utf-8?B?UlVKWDVuNE5qZTJibnRxM05iemdIZFk5MFBzS1pRdTMxK3RLcEIwQ0JValpO?=
 =?utf-8?B?bDhxOFY1cjhVVDJsL0tFMzRVUHV4Y1RTOVRZdFhySXp5eTV3N2daL3grNU00?=
 =?utf-8?B?VGVJTnpKK2s3R3RveEZQeXhqRGsvK21lazdWV282c2tyeHZhcUpBSUtJdWpt?=
 =?utf-8?B?SmFyZkVVcitPcTUzTnRwUkdnc3d5WktPTnl4bWNvbDlVZ01lbXFzbjNTQzVT?=
 =?utf-8?B?bTkyMGhsd0dyd2ljT3hiUVljK1B3cFM1WmZ4b2xkZ1pwNEdseG83RS9KbnFU?=
 =?utf-8?B?VFFTQUNzQmk2MURHUEFVR1p6WFJLVW1XNlFqTFFNN054azlycEd5TGtocTNL?=
 =?utf-8?B?MnNvRXpXVmpzd2NXUmsrU0xGTm5MajQ5SWhlNkpHTzBIZDIvZkNLdEdhVFpp?=
 =?utf-8?B?cUxnMU9IQ3BVMVBhZTM3SnhwMGljS2hsNmYzR3NwbjdBVVhucm9xakRFS3li?=
 =?utf-8?B?SUhRQ1g4R1ZqaGxhK3JzOTFiVENDaGk3eDlna2I2dkNyNVlHQkp3WEtpY3Ar?=
 =?utf-8?B?YzNnbGVxOEdKY2FBMHpwT05WbUZIeVpjc0xNY0tCQmU1R3hGdzJLUGE3MENt?=
 =?utf-8?B?MCtac3Q5OTZMdE1KOVdLc3RCQWdNR0VxTjFUWTZQNlU2TFY0N0NMSmJRV2Jn?=
 =?utf-8?B?ZXJjUndmb3hpcTIwcGRISG12TkpEenk3Z2dVQ3RQY3p0dWdLaDhuKzlkVDI2?=
 =?utf-8?B?NUJMOUkwem5ZYjB2cm5oWW1pR0c0V3ZHQ2sweXluMlBSYVFuSW53d2U0b2xJ?=
 =?utf-8?B?WlI5MFNnUm9NemhhOHJOK0lmOW5QVndYb1NXT3V6UFk1VERsN0w5a25JYkNv?=
 =?utf-8?B?cVE9PQ==?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5bf6fb8-625f-4872-2d9d-08dbaaea4a19
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2023 12:52:24.6553 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XwqCKAOwyuahzTyhpLRfBgHAsXELIVmpr5BNknvPAu1QZQyJ1Txa0cdiVICzMwaYhkhgNbwnThVc66xlXgu/aRRMimg/CMBQfpaQyC4M9kQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7586
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] Add process_madvise01 test
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

Hi!

On 9/1/23 14:36, Cyril Hrubis wrote:
> Hi!
>> BTW I wonder if we should add 'vmstat' or 'cat /proc/meminfo' to ver_linux.
> cat /proc/meminfo sounds like a good idea.
>
Maybe do we need a flag in tst_test to check if swap is available or 
not? Something similar to .min_mem_avail.

Andrea Cervesato


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
