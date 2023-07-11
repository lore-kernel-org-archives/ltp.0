Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23322EB64DC
	for <ltp@archiver.kernel.org>; Tue, 11 Jul 2023 11:20:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9B2433CED2F
	for <ltp@archiver.kernel.org>; Tue, 11 Jul 2023 13:20:13 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3596A3CB7E2
 for <ltp@lists.linux.it>; Tue, 11 Jul 2023 13:20:01 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::62b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 52D32140020C
 for <ltp@lists.linux.it>; Tue, 11 Jul 2023 13:20:01 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MI1i/FoXSOK0KjF4aWjAL68mZh5+yDkeqX000RHR32a3r7tsYy3gN6eyW71oqFTFe9/l9e5cAc/1JAkTuZkZMi3nW4BQDrE+eNioJMU/LBzJWqbFeHRYBZH2g+TO1eLcrG+FvXLhtGyX4IDUvgmBF5IwLkitbMh3d+/15+dwgzJjS+e9WWpuPqHOUmGiMXQPNcC/s4/ms024/4NDZ6Jhlf+YvySWm0y1QODCJpHwncMOHfTSjyjOfAS+iq3EJbdzQI97uLJ5H4HGL6CdSnYmtov/XvC/61MCHXAeto1548Z/drXgRCWCnIKthqV0tkMyn8QPZDmuacywbXtVl9iphA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wNMejie4x/TdjKVU3XKo7NrqHym+lNWyavSxK9gJkaw=;
 b=REPCUfSZNPNf295/AYmO1Ds2AUkpvOYqPJJPbo5D/38E1Jq49EubzKHg2e9UUc9P0Y5dHjfAvf1IgokN+dsUBDep6i8dmLpa26fU+I9rUdzQGsv2BhNEhNNcyMydOEuQIc5TJPonS0uKtr8Sq/s5oM6iIBORmkt6uO+GdXAFpH69gSJ5BtMXVqplKpMy5vch1hILGaigoua80/g6t5xCuZmK22e4BY2lwX1Yb1Bmta9FNlFA8KzFryYRptjPXUWPAFJf9gmnzDpSozUIJHaTx6cz2ZGub4a4/IziHwCGREHTlcxCxpm8IJWr+MCz0fNX8I6Wdx0GphD5MeUwo+6pbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wNMejie4x/TdjKVU3XKo7NrqHym+lNWyavSxK9gJkaw=;
 b=oqI15MX1ia3tvrcvHhYIuxewZO6VK+/wJTwM9q2R8tUmXybZ/YoprWW++dwjnHB7OwdCMFKTYrM7GmaSRgD7i+rPHdrRVkmxzC0gua+C9aQ7UJm7QRA81ZALVC69xDGEOd99A9+0XHYkAS4459ojoBhiZesTD9B9+Jqi3FJBT3GxvPtRkMLIjg/vBOEl6CS9UIpb3nvMWPOs1l0oE19gNyzQ9P7g0DG9LYKqpuR6U8X8dBQ8HmqdKOaffBniAEXpWeiSeLq5CxjGaOrHYTO5V2oA4vIWtiwt5iclmIlhq07+3EedcNicdu0t3YmUKpQvqvcZAwPBr8LDiHRRU51X5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by DB9PR04MB9723.eurprd04.prod.outlook.com (2603:10a6:10:4ce::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.26; Tue, 11 Jul
 2023 11:19:58 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::4b97:9c5:9bab:4e53]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::4b97:9c5:9bab:4e53%3]) with mapi id 15.20.6565.028; Tue, 11 Jul 2023
 11:19:58 +0000
Message-ID: <530aac70-b05b-32e6-4b0d-ae874c00d742@suse.com>
Date: Tue, 11 Jul 2023 13:17:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
To: Petr Vorel <pvorel@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20230705141223.31468-1-andrea.cervesato@suse.de>
 <20230705141223.31468-3-andrea.cervesato@suse.de>
 <20230711111419.GB722759@pevik>
Content-Language: en-US
In-Reply-To: <20230711111419.GB722759@pevik>
X-ClientProxiedBy: FR3P281CA0130.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::11) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB6797:EE_|DB9PR04MB9723:EE_
X-MS-Office365-Filtering-Correlation-Id: fbea0bf3-8b18-4851-3d9f-08db8200c2c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DE13hHpfHrsy2vQPJQKgi8DSZ1EuxDuv9gwDLTnGC3GGTgjjl1VGgWWdBkfzzGsbt+nAjEGGf7ZueUER/6Hu5C1UqiXXGjJHWb43SjL/vBIhRNMYM1nKg2zwF332bvbdgw0KXzF4MpaVHrA1SpaFcGCiFWwIiylSKQm+mkIFV80dI9mGeTM/mIt7BPuRpn63SlrmOGIwy2gYwhrwkGKmKfgqgaOULZHpS5dMVr2QvQ+jb0Q+TDFLGsQsd2b1mNexOvWvade3axd3cvzOg5K3Do/XnKlPPgQEsdGy2a/tuoNrKm/VHHY6i0eqgvLzL1sIqcQo+iIkfwt8RD+k9uess14u/GgDQaw7ZzUdwOZ4kv4H8XzO9pmiUob6erUeI96ytziyT9L2SEb7HiQvvC+NPj34WqKB4HddzfFxo2CDQgxWw09bCACENSUk4DgGYAipSDqDTS/MwXRTCU7yVqikSOvT/90MtHRf046/gSLBYobgDkFo0NFQLa6TtmJbto2UoXSxK/7yNveDBbnTecuixpNnzs/l85W7zPSoJKq3UqRjGduhlxbPiW+Cfqr9awp0Z54ZBmP/4bLoiwS5V4kU5K2qeNBe6UeP44Px2NKmetG2KMr2rbsGl1fVl239mc8uLrApgGkB6wAOXlR1QhEGxUhsE5z1M8+11ye7Y+7m/+Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(346002)(39860400002)(376002)(366004)(396003)(136003)(451199021)(31696002)(53546011)(6506007)(41300700001)(26005)(6512007)(31686004)(186003)(2616005)(478600001)(110136005)(6666004)(6486002)(4326008)(44832011)(66556008)(66476007)(38100700002)(66946007)(316002)(86362001)(5660300002)(8676002)(8936002)(4744005)(36756003)(2906002)(2004002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TE1HWDFoWjNpU3VSWERUa0lOMXNXUzNFamN0d3ZXVjZTYVpwMGZNVktOUXkz?=
 =?utf-8?B?MXl1b1dhSDJyRW04WFVnZ1RPL0JaSGtROW1tM3JoaWN6N2ZGdTQ2aURvOHR4?=
 =?utf-8?B?cDVwenNpcVBTeWp5YURCdHpwRHRpS2QyVmZOMVhWcURDZXR5YlQyeDd3Qy8v?=
 =?utf-8?B?ZEMxSHpRRjVyNllMNXVmRC90WXQ5TE53eU13dHBjRWxheWpaVmlrcFNPWUVM?=
 =?utf-8?B?UWZPbkFudSt2SWN0QmIvTUFBeUdKcmtOUFl3MkZWZ3pqejRHMGVUTFFpTy9S?=
 =?utf-8?B?bzJkUGN3RDdJeVg3cy9rVFRNY1YyakptU0dJa3AybGNZcXEzTWNyMGR1eGtF?=
 =?utf-8?B?c0xrenFVSnJXWWI1SkxCcVR3eS9NeUtHYUcxSW53cjdYUzgySkdXa00zL3py?=
 =?utf-8?B?SVJpc2xyZHlBNnBIZTdTeGxoNmtIbFBLWExuVTVidGtXQkhmdEN5WXJOY01U?=
 =?utf-8?B?K1NiV3E1aXplWVZrUEV6NklvczZuazhSbk85dnRUcEZSV05nUjlZYXg3Tisw?=
 =?utf-8?B?Z3UweElVLy9lUGpvNHZBaTZ0SzFVYm1ua0tVTXJnSHBJbzZieFphemxWUXNQ?=
 =?utf-8?B?eUZ4VysyZm9GMEJOUzVsM0xXVXE1aDJsWWRnRFlhendydUdkbU85TXNQb3Rj?=
 =?utf-8?B?Vm1xQ2xDTHVNRHNqRFYxOE5nVHJ6WWRnODUrNWNsZDVacGRLNW5YQTRsUjFC?=
 =?utf-8?B?NnU1QzQ3L1doUkY4N1hIWTc2VTMrQk4yVTF1SHo3SmlGbVVCeWd3ME1FMzE3?=
 =?utf-8?B?OTVydEd6aS96VGlUdDN6cXROQVNJL2NkSWFlSExSSm9ZQ1FXaGZrek9MMUlw?=
 =?utf-8?B?aE5GQ3Vuc2NqbE1PcTZFUS9TUWovcTdOWmFRcFU2QzNNS1lMeHhYV0VZTlNJ?=
 =?utf-8?B?YlNwZ2pENjFmYlVCNVBwSnl0QVdhUVlBWkhueGl3QkU2YU8zV0orV3oyTElm?=
 =?utf-8?B?aUROTmpMMHlYbms1a2VMZzY1ZUNHZGM5MHBZeWxxY1VpZzI4RHVHM1JHanA5?=
 =?utf-8?B?bXREZzBJa1FVbWdFUUlKVnRVRktscTJTdmFPQWV4bUFMWEdVNm5nRUVtV0ZG?=
 =?utf-8?B?UG9Ya1Q2a1ZmaUFzNUlXWjdjNkJib1NhcXMxQi9EUkFnWUYyL0FJOHZ4RitH?=
 =?utf-8?B?UzBSYWgvS3ozNmNXU1JKVVJaeFExRjE3VWc2bXRGYUdvMDdWOGdWVVZ2eTRT?=
 =?utf-8?B?dStXdktOdFhHVWZpNS8zaXhPN1RmNFJvMG9aeVRtWE5pbnFBdVVGVHNId0hS?=
 =?utf-8?B?VTVRclJtK2JQdk13YnVsNTEvMndQZUFxdlJiUFluaG0rMWI2UFFyMlNZTHhu?=
 =?utf-8?B?UmdMU0JQUlhnNUpuZG4ydzAzaHNpVi92U3F3d2h5dUd5N3JvK2ZOS0VseXpJ?=
 =?utf-8?B?LzBFMTVBWDJTaHU0Z0FxYWg1cVcxQnl0Z3o3TzhzdThldXFsYkhDZ1NQOEVS?=
 =?utf-8?B?QkUvZDQ5N0grSVhYQzZjNW8wa2dmdXV3RUNWT3kxbGtta3JXY3kwZUVzcCtC?=
 =?utf-8?B?SjVGN0RhUEMxYmloYlRQUUVLM2QrQ0c0dzNLTmlIOGVpQkwzUkdBNkZiU01Q?=
 =?utf-8?B?QU5nd1JKUmloM3NnbUx4NjBaOU85MFk0REFXblFUdWYrYjlWa2FveDE5L1NR?=
 =?utf-8?B?QkVtK282NHQzTklDQmNzVUdieHI4cENZSnhhYkQ5c1dNNUZPU1g4VVA4VDBq?=
 =?utf-8?B?d2lFOUFmTVQzOXppeUF0cXZkVjY4aFFiS0I3MlFiZ1IwT1hYWnBjVDZhbTRv?=
 =?utf-8?B?VTRGNXRyZllIelJKc1Q2anVvNzRKVDFGT3BCM1k4dm1ydzc1ZTBFSGxzbVZj?=
 =?utf-8?B?cWJ1K0p2VWRhdTFONEYwWE1wblFqYVBOWGhKd09WVzI1K0JoZWJTeFhnT2c2?=
 =?utf-8?B?eWtrc1pBbjB5aFgvTlZDMXJ5Z2l6WGpTK0MzYnpxUlAxeGZpMnc5V1NnSFNk?=
 =?utf-8?B?amVxbXd2QU9RUzlYa1hvNGVobStZVHFZM2pMOUtubDJJZUJ0SndqR2NFNC9O?=
 =?utf-8?B?MGRRdVNBTUZWeThyWEFqWGJld09ad3VRZ1VZSndwQ05WdWxtQjEvUTVCdjhB?=
 =?utf-8?B?TDBwbUxaMitzRHY2M1hJUnFuQm4wTW1iMjUxeUgxME55Q2NwTTF5Z0wrUzY4?=
 =?utf-8?B?REp5UWZWYjB5NGZGM0FGZFdJcnRweWExdGdMYzBWdUxRYXd4clFDNnRHR3lS?=
 =?utf-8?B?cWc9PQ==?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbea0bf3-8b18-4851-3d9f-08db8200c2c6
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 11:19:58.4249 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d/OGvHcJ7Zb5LeFS03rIcZOgCuIZp1AZIvRGmiFrsIo6diXrHP/PuF72Q/AcTaZ+4GQzhWI5Lr9poM/4BMg94ZBmlLHyuwYlWRTW5HhDGl8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9723
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v8 2/4] Refactor mqns_04 using new LTP API
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

yes, I forgot it for all the other patches. I kindly ask you if you can 
do it in the merge window.
Thanks
Andrea


On 7/11/23 13:14, Petr Vorel wrote:
> Hi Andrea,
>
>> +++ b/testcases/kernel/containers/mqns/mqns_04.c
>> @@ -1,187 +1,167 @@
>> +// SPDX-License-Identifier: GPL-2.0
>>   /*
>> -* Copyright (c) International Business Machines Corp., 2009
>> -* This program is free software; you can redistribute it and/or modify
>> -* it under the terms of the GNU General Public License as published by
>> -* the Free Software Foundation; either version 2 of the License, or
>> -* (at your option) any later version.
> or (at your option) any later version => SPDX-License-Identifier: GPL-2.0-or-later
>
> This can be fixed by person who merges the patchset.
>
> Kind regards,
> Petr



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
