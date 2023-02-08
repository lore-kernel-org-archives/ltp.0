Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B066C636CC
	for <ltp@archiver.kernel.org>; Wed,  8 Feb 2023 09:44:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8646C3CC133
	for <ltp@archiver.kernel.org>; Wed,  8 Feb 2023 10:44:54 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 281BE3C304A
 for <ltp@lists.linux.it>; Wed,  8 Feb 2023 10:44:43 +0100 (CET)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on2073.outbound.protection.outlook.com [40.107.241.73])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id AEC1A200BD4
 for <ltp@lists.linux.it>; Wed,  8 Feb 2023 10:44:41 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kK+siEObXTrXxDD0rx+NuIzxl+VbPZ7TWgS9re6PkfjUSBfGF5/4D+2fCvziD3P1I9g1Qv78InT3VJTBVnPekzoldvgPIQmQlhLGYzOGxkCWtKSVtUrQtf8tQvqEtw91jvXcmvdDyror7fkqhL/eEDoKKIa4qF5CBZre4M70JtIDDvYRKC2Dgra9p/H6MLm2TlZAaXcObkjmy6b5LhL0rjMhlAhHZBBnLAJUjnkI/1DOZcLtlujVl86CCQ4Q5OMtBYbgt9Lx/EAOfPIfL0UQpD3Y9iN0s9o62K19FKDtvC4FN4xOAZwwCQNnH2ysudHe79RLHdEHlWghueyppk30Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UF1Y3SmDH9s4SFM+Q050hsgVszcXWE2KMVtYl3YfCOI=;
 b=imh54gtLwE7CebU6nof0RIJRP7mIkUL88IdQRaexlQM9YwXwETy50yr5PpVBJJitOmLasgg58ftNjfRtf4O2c+vEV609bDrc/mFz4ZNZYBsvVZLF/0s/8enMc1he+VRlpk33e38CTI7Qh5E9g76WobCkfmrPF+eECowxN313fCK9LvttYuBJ1JQBnqUbsTqTGnzWjlwisVC80MJ/8ksjyJZPfir5QfjKqII/6S2EatxIgQuzgDzscA56PYqtf7K5awXv43+3tq+l18b3moueGVYUpZcPUhbxT863odIndLSPbRvLfuI4yhAIlL5brd9qdIzqFrhoT0KGnSSXaTiD3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UF1Y3SmDH9s4SFM+Q050hsgVszcXWE2KMVtYl3YfCOI=;
 b=iIBzClExAMiT3IX6WWgdjAFQBlFpmcT5NgUFHS6ip/yLCTCJruqavTgCDYq/Ul0+lu5hipsQEDVj65In075nUYahno62xFzWgWsUrl+7VPdr21kB4dwIZtBr/e7yaXUl9JD/C06fkRrzatBE7S8vCxuaSDxCScyWwxqDz0chruk2C9UKsdIQByz2WXU85r3euA5rFmEZ/X6jkq1jyjfV/mE5sMSWcapbcsBAT8BMmcMvlL9bUqEymLlKLCk1vFdEiF1vmxqxz3CEgd2X8RgNiSxTcxguaDJvG4QmxaZjHydyueWBUMN+Blc6yUhKICTcvPoKY5P/XG8PqFZ0TzgESg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by DBAPR04MB7207.eurprd04.prod.outlook.com (2603:10a6:10:1b2::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Wed, 8 Feb
 2023 09:44:38 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::a9f4:e4e9:9b9b:2dc6]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::a9f4:e4e9:9b9b:2dc6%6]) with mapi id 15.20.6064.036; Wed, 8 Feb 2023
 09:44:38 +0000
Message-ID: <103359c5-8438-f3c1-53ce-e3d4fb07c7b8@suse.com>
Date: Wed, 8 Feb 2023 10:42:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-US
To: rpalethorpe@suse.de
References: <20220816113142.25638-1-andrea.cervesato@suse.com>
 <20220816113142.25638-3-andrea.cervesato@suse.com> <87r0ym9868.fsf@suse.de>
In-Reply-To: <87r0ym9868.fsf@suse.de>
X-ClientProxiedBy: FR0P281CA0120.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::10) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB6797:EE_|DBAPR04MB7207:EE_
X-MS-Office365-Filtering-Correlation-Id: 27e8b4e4-91bb-4d03-a164-08db09b9182f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XQ/8fzxo+uZ0QNAx/YFaWQR/PHqU0/Fwr8A7jPgOdrkOm5WzCZJZ0YQ+kPZB7o8ZNaasIe7VWXHkaiG3XhXEavejH8dOkzpWv/McPx566CrHbjckG7DxR0I0OE/fKcg4ewifn/zzMbspmYI0oxME5r0eWGsyMltOA0xIxOTpAuVVql0iskOYA4Cd0l56H+e+dCPrnJXiTLSk5pTZqF20oQ2HIbQaTnl5qz6jI0uNh7XJFPZyZnga7/n2iTjgcMCZkygdHD4ZU8ThKo07JIQVYLw4ED/TOJfXlpZerWa0HkGpDdvTs1pRpCn0ikkfsE458OCqTk6mRtqJkVgcRvfL95KdjljWaRikFohJn7M/yx9AyRZVr2vzmTK809E0RdpC09k5CdrLExVDTd87wYyadzmqRx9nmKEl+DNIx12fQL3wITn+yNi48ZxAOgaiaQfbLvpawV9Nbw59xdU6JJGvZ0f1R8EAGNm/NXJ66LY7cDCwzLtR1IfqZo7llMcQGlmh2epWNQqi+uWBJv9Au+KAhzQpt9KxNVhBSwwDXL+Eb7mep3bv+9S0lcZFZOeHArGrzUgEYaKvtwmjP4CTkCz1mZg/lPIZo+snrlvwAX/kh5Z0GIJkvlCf1QzNtbwPnPb5sZklZhTdLNu6b4cxjapsKOPg6SvudxG9HdHXLc4UJ3j7MNtp/ambzZiXIDsU4WeChqJXaj0fvLkcxk8KmAUINsfzZqNNTehR6c7YTeUCcIb6wacKKCynsOd4ICfgFpyRk08WXy2CDEq7lI6hOrVijw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(39850400004)(136003)(346002)(366004)(396003)(376002)(451199018)(31686004)(38100700002)(66899018)(6506007)(41300700001)(8936002)(186003)(26005)(4326008)(6916009)(8676002)(66476007)(66946007)(66556008)(2616005)(36756003)(44832011)(30864003)(5660300002)(316002)(86362001)(31696002)(6486002)(6512007)(53546011)(478600001)(83380400001)(2906002)(2004002)(21314003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MUFObktwRC96NWJpQ1dSYkNYTFZybTdUYkV2Y3c5MDgrQmdUSUcwRk1OS3B0?=
 =?utf-8?B?dlp5VzZrRWt5bTRXd0tFNy9Ec3NUbmNYVzVTQURWTjl1VVo4RTVlTlI0VTRp?=
 =?utf-8?B?OHRlY2hITHNTU2YvNXk4d1phZnZNK1RSVitMcnpYMG02M011eFBUS09SNEZz?=
 =?utf-8?B?R25INStBUE1VQW5DMW9JN0gwUzQxMVJOSEhXbkl2WFJwME14R0x1UHFaVGJn?=
 =?utf-8?B?QStaYmRvRTJkdU91SzVGNWZqOEpGdmZPaDQ5SDExazlXdUYyYk8ydG01TnA0?=
 =?utf-8?B?T3licnJMUnM0bjBDWXUvODY0QjdkMkFkeE43QUY3T29SVk1Jb2pWMVZ5b056?=
 =?utf-8?B?bzJlUjloSzFteVgvQjNWa3VwVytrU3BtdEhSaWdxb3Jhdzd4V1BLVFZNdUdh?=
 =?utf-8?B?aXF2R00wLzZSWXNMWUF2cFJpdkNTaUZuRnYvNWJjUFZTS1czVUtyYTluSnND?=
 =?utf-8?B?NjZUUjZQaTBzT1Z2VER0Z2lXMmRweVNvRHozWDlUWTRXNVBidHNwRzVNWUxN?=
 =?utf-8?B?Sis2QlM4MGczYU9SSTVhNWVrL2xGWW1pWkxwQzZ4MDBGQTBnNXNrTEdpaW8x?=
 =?utf-8?B?ZGJDTjFvclhmMzVFbkpQSU9CUHBlUGlWb1JtQ2dOVDBFdEo3Ujl0dFhlRDIw?=
 =?utf-8?B?L0pwYW1SZ05sYkdUMTQ4Y1BUMEpEVEVudnJzSnJkL2ROSm9tbENYRmsrN3NS?=
 =?utf-8?B?b1N3Z056RzV3MSt0STcxQnpmeCtXYThrVGtNSDhicHJyRGNqZEJ5VlhZa2JT?=
 =?utf-8?B?a2pBam5OY3hhbDU1clVYL3hjZzBCNEtpTEVkb1IzZ0JWeENUbEExeGJOYjVu?=
 =?utf-8?B?N0IzbTlNLzZBTHRFb000RjRKSFVjUjhaR3ZtZFUzeCtXd2FJZWFtcmVtSURX?=
 =?utf-8?B?Zkx2REpUL095c09JNm1NNFAzSHRHWWZ3OXRTTmwvNW1xRVFJSnY5cVVGTE41?=
 =?utf-8?B?cmlJMmZFMmhkZlQ0NDhHYm00cFVpT0lEeUIyWDZxT0tXSVg2dmdMLy9iZGRL?=
 =?utf-8?B?SjlnT1I0OWpHWTNudVJtSGQ2TTQzMXdDd1NpOXZUNnpLNmF0VFBGbE5TN1lZ?=
 =?utf-8?B?SC9JdDRYcVNNVk0vVHJQenFhL0h5d1dUQzY0YSsxa3QxUERkejBuMnJVMGtm?=
 =?utf-8?B?eGd3THB3Q0N5bGl2T3U5aUprbCtKSjNhbXJOZjFZai9LVTZmRG01RFQ2Zkkz?=
 =?utf-8?B?QzlmcGZSbnFmSGwyTWdaTjRUUXFyM3I1WDBlbjM0TUJMbnNOVFo1SUtCY0tQ?=
 =?utf-8?B?ZjJzT0ltQ1ZMYmc3cnRQa1NqeEFBR2pKZEpZUnY1TzFmKzFUbVlKUEE5MWFY?=
 =?utf-8?B?Nk5CalIvL3BydzU2YmVpSUprTHNZanVOMzg4SzlEZXlMZGI5TkpQdVNYbW1h?=
 =?utf-8?B?QytPc1ZybmFRNlhtSDE5U3N2NXdIMExpUkU4S1NFRWFGQU5LRWpZbHZSQ0Ez?=
 =?utf-8?B?QVhKenl6d3N5bGJtWW1qcm1UeEx6WW9UWDliRFhjNmY3aG5vcyt5WGFnbDNw?=
 =?utf-8?B?cjBrK1h6YnA5eWdXWkIvY3BZNitzUDFZT0ZjdC8vZ3pyWWtKazlPR2RhNC9U?=
 =?utf-8?B?OEtqR0owNWJFT3lxT0c1Z2MxR01kbS9nRmJuWkFCMm5zc3pTSHpYVGFpeGlx?=
 =?utf-8?B?cmE5OGFwdnNUcmdMRnZUdGFqUVpFSG5nOC9UaDVWSWJMdVBRZm82WDV0Mkh5?=
 =?utf-8?B?S1JYWW1sY2YzZ3RjY0pYaDhjQ0x5Z0JqNkRXR2VUUDM0NFV2YzZxRGMzS0dY?=
 =?utf-8?B?MTJqOEtuT2d3TWZ0bVFrTllEZjdlRlYwblBsajZNaFoySGNXOTErYS9yaDl1?=
 =?utf-8?B?clpCSExlWWV0bVVNaUdUQnU4NnhEOHJ4TlR4TEk4Qkh2Y3VnRUlyMGR5Nldp?=
 =?utf-8?B?Mk13WjhaNDUraDdpL29ucSt2L0FVbjRYeUNGaUUvVTh5ekdQQzk0ZWtPNXps?=
 =?utf-8?B?cXl2T2R2b2E3VW91cS8rLzZVZ1krRUpwTkU4SUFqbWZsSDloL1VxcS9Uam5V?=
 =?utf-8?B?cm5xWGZBU3lZTkUxa1cvYU5OcDF0U0t3WGJjVW1TRHBrandPcDJTNDRWeEIz?=
 =?utf-8?B?SHBHWFkrbWo5cUZnR2p1cDNXQ0YxNk9MV053K0xTeGdYMGFUK1BMZ1Jid0J0?=
 =?utf-8?B?WUpyK1h6Umo5bWNnaUZHbzVpNnFWZ2tHbnNhK1pCanRscUJjUDhIaThUU0RS?=
 =?utf-8?B?Nnc9PQ==?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27e8b4e4-91bb-4d03-a164-08db09b9182f
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2023 09:44:38.4462 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jAqcFveLJdoE0MICkvD9MUXIlfTMLIkYBfTGr5qKE2345y2sGTo97JvfXR9it6oagiOitCE0Lx+SECfLSpqO8BXBOoYE9nhujNau8taFXWg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7207
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/3] Refactor pidns30 test using new LTP API
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

Hi,

On 11/1/22 13:01, Richard Palethorpe wrote:
> Hello,
>
> Andrea Cervesato via ltp <ltp@lists.linux.it> writes:
>
>> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
>> ---
>>   testcases/kernel/containers/pidns/pidns30.c | 312 +++++---------------
>>   1 file changed, 66 insertions(+), 246 deletions(-)
>>
>> diff --git a/testcases/kernel/containers/pidns/pidns30.c b/testcases/kernel/containers/pidns/pidns30.c
>> index c8b0806c0..b01759a87 100644
>> --- a/testcases/kernel/containers/pidns/pidns30.c
>> +++ b/testcases/kernel/containers/pidns/pidns30.c
>> @@ -1,296 +1,116 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>>   /*
>> -* Copyright (c) Bull S.A.S. 2008
>> -* This program is free software; you can redistribute it and/or modify
>> -* it under the terms of the GNU General Public License as published by
>> -* the Free Software Foundation; either version 2 of the License, or
>> -* (at your option) any later version.
>> -* This program is distributed in the hope that it will be useful,
>> -* but WITHOUT ANY WARRANTY; without even the implied warranty of
>> -* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See
>> -* the GNU General Public License for more details.
>> -* You should have received a copy of the GNU General Public License
>> -* along with this program; if not, write to the Free Software
>> -* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
>> -*
>> -***************************************************************************
>> -* File: pidns30.c
>> -*
>> -*   Description:
>> -*    This testcase checks if the si_pid is correctly set when a process
>> -*    that has registered for notification on a posix mqueue is in a
>> -*    descendant namespace wrt the process that sends a message to that posix
>> -*    mqueue.
>> -*
>> -*   Test Assertion & Strategy:
>> -*    Parent                                   Child
>> -*    --------------------------------------------------------------------------
>> -*    Create a POSIX mqueue.
>> -*    Create a PID namespace container.
>> -*                                             Open that mqueue for reading
>> -*                                             Register for notification when a
>> -*                                                message arrives in that mqueue
>> -*                                             Install a handler for SIGUSR1.
>> -*    Write something to the mqueue.
>> -*                                             Inside the handler, check that
>> -*                                                si_pid is set to 0
>> -*
>> -*   Usage: <for command-line>
>> -*    pidns30
>> -*
>> -*   History:
>> -*    DATE      NAME                             DESCRIPTION
>> -*    01/12/08  Nadia Derbey               Creation of this test.
>> -*              <Nadia.Derbey@bull.net>
>> -*
>> -******************************************************************************/
>> + * Copyright (c) Bull S.A.S. 2008
>> + *               01/12/08  Nadia Derbey <Nadia.Derbey@bull.net>
>> + * Copyright (C) 2022 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
>> + */
>> +
>> +/*\
>> + * [Description]
>> + *
>> + * Clone a process with CLONE_NEWPID flag, register notification on a posix
>> + * mqueue and send a mqueue message from the parent. Then check if signal
>> + * notification contains si_pid of the parent.
>> + */
>> +
>>   #define _GNU_SOURCE 1
>> -#include <sys/wait.h>
>> -#include <sys/types.h>
>>   #include <signal.h>
>> -#include <stdlib.h>
>> -#include <unistd.h>
>> -#include <stdio.h>
>>   #include <mqueue.h>
>> -#include "lapi/syscalls.h"
>> -#include "pidns_helper.h"
>> -#include "test.h"
>> -
>> -char *TCID = "pidns30";
>> -int TST_TOTAL = 1;
>> -
>> -char *mqname = "mq1";
>> -int result = TFAIL;
>> +#include "tst_test.h"
>> +#include "tst_safe_posix_ipc.h"
>> +#include "lapi/namespaces_constants.h"
>>   
>> -int father_to_child[2];
>> -int child_to_father[2];
>> +#define MQNAME "/LTP_PIDNS30_MQ"
>>   
>> -#define CHILD_PID       1
>> -#define PARENT_PID      0
>> -
>> -#define MSG      "HOW ARE YOU"
>> -#define MSG_PRIO 1
>> -
>> -#define NO_STEP	-1
>> -#define F_STEP_0 0x00
>> -#define F_STEP_1 0x01
>> -#define F_STEP_2 0x02
>> -#define F_STEP_3 0x03
>> -#define C_STEP_0 0x10
>> -#define C_STEP_1 0x11
>> -#define C_STEP_2 0x12
>> -
>> -mqd_t rc = -1;
>> -mqd_t mqd = -1;
>> -
>> -static void remove_pipe(int *fd)
>> -{
>> -	close(fd[0]);
>> -	close(fd[1]);
>> -}
>> +static mqd_t mqd = -1;
>> +static int received;
> This should be volatile because it is used in the sighandler.
>
>>   
>>   static void remove_mqueue(mqd_t mqd)
>>   {
>> -	mq_close(mqd);
>> -	tst_syscall(__NR_mq_unlink, mqname);
>> -}
>> -
>> -static void cleanup(void)
>> -{
>> -	if (mqd != -1) {
>> -		remove_mqueue(mqd);
>> -	}
>> -	if (rc != -1) {
>> -		remove_mqueue(rc);
>> -	}
>> -	remove_pipe(father_to_child);
>> -	remove_pipe(child_to_father);
>> -}
>> +	if (mqd != -1)
>> +		SAFE_MQ_CLOSE(mqd);
>>   
>> -static void cleanup_child(void)
>> -{
>> -	if (mqd != -1) {
>> -		tst_syscall(__NR_mq_notify, mqd, NULL);
>> -	}
>> -	cleanup();
>> +	mq_unlink(MQNAME);
> We don't know that mq_unlink ever succeeds as we never check the
> result. This seems like lazyness because it is used at the beginning of
> run where it is expected to fail.
>
>>   }
>>   
>> -/*
>> - * child_signal_handler() - to handle SIGUSR1
>> - *
>> - * XXX (garrcoop): add calls to cleanup_child() -- or should this be handled
>> - * from the libltp signal handler?
>> - */
>> -static void child_signal_handler(int sig, siginfo_t * si, void *unused)
>> +static void child_signal_handler(LTP_ATTRIBUTE_UNUSED int sig, siginfo_t *si, LTP_ATTRIBUTE_UNUSED void *unused)
>>   {
>> -	char buf[256];
>> -	struct mq_attr attr;
>> +	tst_res(TINFO, "Received signal %s from pid %d",
>> tst_strsig(si->si_signo), si->si_pid);
> Again we should avoid calling tst_res in the signal handler
>
>>   
>> -	if (si->si_signo != SIGUSR1) {
>> -		printf("received signal = %d unexpectedly\n", si->si_signo);
>> +	if (si->si_signo != SIGUSR1 || si->si_code != SI_MESGQ ||
>> si->si_pid != 0)
> If the wrong signal or details are sent then we won't get any debug
> information. Unlike with the old version.
>
>>   		return;
>> -	}
>> -
>> -	if (si->si_code != SI_MESGQ) {
>> -		printf("expected signal code SI_MESGQ; got %d instead\n",
>> -		       si->si_code);
>> -		return;
>> -	}
>> -
>> -	if (si->si_pid) {
>> -		printf("expected signal originator PID = 0; got %d instead\n",
>> -		       si->si_pid);
>> -		return;
>> -	} else {
>> -		printf("signal originator PID = 0\n");
>> -		result = TPASS;
>> -	}
>>   
>> -	/*
>> -	 * Now read the message - Be silent on errors since this is not the
>> -	 * test purpose.
>> -	 */
>> -	rc = mq_getattr(si->si_int, &attr);
>> -	if (rc != -1)
>> -		mq_receive(si->si_int, buf, attr.mq_msgsize, NULL);
>> +	received++;
>>   }
>>   
>> -/*
>> - * child_fn() - Inside container
>> - *
>> - * XXX (garrcoop): add more calls to cleanup_child()?
>> - */
>> -int child_fn(void *arg)
>> +static int child_func(LTP_ATTRIBUTE_UNUSED void *arg)
>>   {
>> -	pid_t pid, ppid;
>> +	pid_t cpid, ppid;
>>   	struct sigaction sa;
>>   	struct sigevent notif;
>> -	char buf[5];
>> +	mqd_t mqd_child;
>>   
>> -	/* Set process id and parent pid */
>> -	pid = getpid();
>> +	cpid = getpid();
>>   	ppid = getppid();
>>   
>> -	if (pid != CHILD_PID || ppid != PARENT_PID) {
>> -		printf("pidns was not created\n");
>> -		return 1;
>> +	if (cpid != 1 || ppid != 0) {
>> +		tst_res(TFAIL, "got unexpected result of cpid=%d ppid=%d", cpid, ppid);
>> +		return 0;
> Again TST_EXP_EQ*
>
>>   	}
>>   
>> -	/* Close the appropriate end of each pipe */
>> -	close(child_to_father[0]);
>> -	close(father_to_child[1]);
>> +	TST_CHECKPOINT_WAIT(0);
>>   
>> -	while (read(father_to_child[0], buf, 1) != 1)
>> -		sleep(1);
>> -
>> -	mqd = tst_syscall(__NR_mq_open, mqname, O_RDONLY, 0, NULL);
>> -	if (mqd == -1) {
>> -		perror("mq_open failed");
>> -		return 1;
>> -	} else
>> -		printf("mq_open succeeded\n");
>> -
>> -	/* Register for notification on message arrival */
>> +	mqd_child = SAFE_MQ_OPEN(MQNAME, O_RDONLY, 0, NULL);
>>   	notif.sigev_notify = SIGEV_SIGNAL;
>>   	notif.sigev_signo = SIGUSR1;
>> -	notif.sigev_value.sival_int = mqd;
>> -	if (tst_syscall(__NR_mq_notify, mqd, &notif) == -1) {
>> -		perror("mq_notify failed");
>> -		return 1;
>> -	} else
>> -		printf("successfully registered for notification\n");
>> +	notif.sigev_value.sival_int = mqd_child;
>> +
>> +	SAFE_MQ_NOTIFY(mqd_child, &notif);
>>   
>> -	/* Define handler for SIGUSR1 */
>>   	sa.sa_flags = SA_SIGINFO;
>> -	sigemptyset(&sa.sa_mask);
>> +	SAFE_SIGEMPTYSET(&sa.sa_mask);
>>   	sa.sa_sigaction = child_signal_handler;
>> -	if (sigaction(SIGUSR1, &sa, NULL) == -1) {
>> -		perror("sigaction failed");
>> -		return 1;
>> -	} else
>> -		printf("successfully registered handler for SIGUSR1\n");
>> +	SAFE_SIGACTION(SIGUSR1, &sa, NULL);
>>   
>> -	/* Ask parent to send a message to the mqueue */
>> -	if (write(child_to_father[1], "c:ok", 5) != 5) {
>> -		perror("write failed");
>> -		return 1;
>> -	}
>> -
>> -	sleep(3);
>> +	TST_CHECKPOINT_WAKE_AND_WAIT(0);
>>   
>> -	/* Has parent sent a message? */
>> -	read(father_to_child[0], buf, 5);
>> -	if (strcmp(buf, "f:ok") != 0) {
>> -		printf("parent did not send the message!\n");
>> -		return 1;
>> +	if (received != 1) {
>> +		tst_res(TFAIL, "Signal hasn't been received after mqueue
>> event");
> If we receive more than one signal then this will also be printed. In
> any case we can shorted this with TST_EXP_EQ_*.
I would keep this message because it's easier to read when test fails.
>> +		return 0;
>>   	}
>> -	printf("parent is done - cleaning up\n");
>>   
>> -	cleanup_child();
>> +	tst_res(TPASS, "Signal has been received after mqueue event");
>>   
>> -	exit(0);
>> +	return 0;
>>   }
>>   
>> -static void setup(void)
>> +static void cleanup(void)
>>   {
>> -	tst_require_root();
>> -	check_newpid();
>> +	remove_mqueue(mqd);
>>   }
>>   
>> -int main(void)
>> +static void run(void)
>>   {
>> -	int status;
>> -	char buf[5];
>> -	pid_t cpid;
>> -
>> -	setup();
>> -
>> -	if (pipe(child_to_father) == -1 || pipe(father_to_child) == -1) {
>> -		tst_brkm(TBROK | TERRNO, cleanup, "pipe failed");
>> -	}
>> +	int ret;
>>   
>> -	tst_syscall(__NR_mq_unlink, mqname);
>> +	remove_mqueue(mqd);
>>   
>> -	/* container creation on PID namespace */
>> -	cpid = ltp_clone_quick(CLONE_NEWPID | SIGCHLD, child_fn, NULL);
>> -	if (cpid == -1)
>> -		tst_brkm(TBROK | TERRNO, cleanup, "clone failed");
>> +	ret = ltp_clone_quick(CLONE_NEWPID | SIGCHLD, child_func, NULL);
>> +	if (ret < 0)
>> +		tst_brk(TBROK | TERRNO, "clone failed");
>>   
>> -	mqd =
>> -	    tst_syscall(__NR_mq_open, mqname, O_RDWR | O_CREAT | O_EXCL, 0777,
>> -		    NULL);
>> -	if (mqd == -1)
>> -		tst_brkm(TBROK | TERRNO, cleanup, "mq_open failed");
>> -	else
>> -		tst_resm(TINFO, "successfully created posix mqueue");
>> +	mqd = SAFE_MQ_OPEN(MQNAME, O_RDWR | O_CREAT | O_EXCL, 0777, 0);
>>   
>> -	if (write(father_to_child[1], buf, 1) != 1)
>> -		tst_brkm(TBROK | TERRNO, cleanup, "write failed");
>> +	TST_CHECKPOINT_WAKE_AND_WAIT(0);
>>   
>> -	/* Close the appropriate end of each pipe */
>> -	close(child_to_father[1]);
>> -	close(father_to_child[0]);
>> +	SAFE_MQ_SEND(mqd, "pippo", 5, 1);
>>   
>> -	/* Is container ready */
>> -	read(child_to_father[0], buf, 5);
>> -	if (strcmp(buf, "c:ok") != 0)
>> -		tst_brkm(TBROK, cleanup,
>> -			 "container did not respond as expected!");
>> -
>> -	rc = mq_send(mqd, MSG, strlen(MSG), MSG_PRIO);
>> -	if (rc == -1)
>> -		tst_brkm(TBROK | TERRNO, cleanup, "mq_send failed");
>> -	else
>> -		tst_resm(TINFO, "mq_send succeeded");
>> -
>> -	/* Tell the child the message has been sent */
>> -	if (write(father_to_child[1], "f:ok", 5) != 5)
>> -		tst_brkm(TBROK | TERRNO, cleanup, "write failed");
>> -
>> -	/* Wait for child to finish */
>> -	if (wait(&status) == -1)
>> -		tst_resm(TBROK | TERRNO, "wait failed");
>> -
>> -	cleanup();
>> -
>> -	tst_exit();
>> +	TST_CHECKPOINT_WAKE(0);
>>   }
>> +
>> +static struct tst_test test = {
>> +	.test_all = run,
>> +	.cleanup = cleanup,
>> +	.needs_root = 1,
>> +	.needs_checkpoints = 1,
>> +};
>> -- 
>> 2.35.3
>
Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
