Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFABCC636CC
	for <ltp@archiver.kernel.org>; Wed,  8 Feb 2023 09:53:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 59D283CC0FC
	for <ltp@archiver.kernel.org>; Wed,  8 Feb 2023 10:53:32 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EAC8F3C304A
 for <ltp@lists.linux.it>; Wed,  8 Feb 2023 10:53:20 +0100 (CET)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04on0620.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0d::620])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A625810004BA
 for <ltp@lists.linux.it>; Wed,  8 Feb 2023 10:53:19 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TTOPR+0LQlZOADVHHMhg4MFxuiDgdivRvXCv/P5rF9W7w/WUDDrqLnXsDAtDB2q8oNOF7q7Kdx5Yl6JJl8YhTLVQZ2YO7QRd6kLEpNicJhaoNnLwgcrNkokvp5IJFWSFgTbBEHNyndo0Ro4gCMOeYOFKUpPZclGDc38yo8Qh4kOg4u9o5lMOoaKVELTLQPEeLgjIU/1v5c7ZmUipEi+IdLXvAUFgmA+GjEgyue5TtGWrfPzPYtNrRKLN9TS7eu2nG5Hrw01xqgYPwhLK6c5dq8vtOSC/HBfZ0VHCadV0AYCzrpvmzMSAXcqUOe7uSdO7eUVavxxVukI12iXwMKgZkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yMjALytVxQVMSswcA0IRUX5Yl1fxQRaFGoDX1Ktzj5w=;
 b=ZmPlAATnv6wZxAu/lXV9UAHLbuPbIw8dSWFr+Pvn8NmEw9beeBVFI/3JE4iZ5ZKZ3YN2RUf9CPunKOasznZ8ZUl/GgNWjshz6mp/Ep0UZRgfl6RnbpS5+miKFPF+X9ck3oDezQ4y6qcePq13ol0UD9BtAMQ8fEn9qNxFdCepSN/xYhptOA0IOjVEauru30PLzktOXOb7bL/16pqUsw6bmiuyrCWI2O2uo8fkyICo2sgwhfu3OMa/M/9g7v04m8iQIv1rIZC206lDfDCM/i8UKCkZSDuJ0k0Lo7gT48tEgkvZgt7JGxhKs5DJ57iwTsFjv+MpZ24dUTHXlBxm8aDYVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yMjALytVxQVMSswcA0IRUX5Yl1fxQRaFGoDX1Ktzj5w=;
 b=KRyw7rNGQbKxIpbSOeyJXUZSzQG7IPHwFG8K9txrPVVJYWSF6FoGBrv6nXWt6951Kep143mPeKcJbXxvIDerwl4Nk67H+RGH9BED8fipLmx37pGHv+IBgeX5eiJuS3BuP9F4RaINsWXeFX29aHeSpAL7neDYFnGQW372ib51WPBnaPkKGRANBGBvh9iOnFBuh+4BGlDoUQSA6aDNjCVxA+wrudg+H8nzCauRUq2X/1MDJYD7hW46UklYPvgJheTmzM4smJ0CfWKsHxMFZ0B/GwI6BU+fdZJVDt3/OIpSsjBwm7q9PjOVqej9z40Hucr8YQdwDYQfHQacq/2yli0oSg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by AS8PR04MB8612.eurprd04.prod.outlook.com (2603:10a6:20b:427::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.35; Wed, 8 Feb
 2023 09:53:17 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::a9f4:e4e9:9b9b:2dc6]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::a9f4:e4e9:9b9b:2dc6%6]) with mapi id 15.20.6064.036; Wed, 8 Feb 2023
 09:53:16 +0000
Message-ID: <1392834b-f94f-7e25-2187-4f4e7b6ec7d8@suse.com>
Date: Wed, 8 Feb 2023 10:51:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-US
To: rpalethorpe@suse.de
References: <20220816113142.25638-1-andrea.cervesato@suse.com>
 <20220816113142.25638-3-andrea.cervesato@suse.com> <87r0ym9868.fsf@suse.de>
In-Reply-To: <87r0ym9868.fsf@suse.de>
X-ClientProxiedBy: FR0P281CA0113.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::13) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB6797:EE_|AS8PR04MB8612:EE_
X-MS-Office365-Filtering-Correlation-Id: cc68ae5b-db52-4357-ab8c-08db09ba4d33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: odrMQKq/7SwfxHuy0a8Tu9XzL9WI9yU/m+elhNs2iH7kSTGAT296RtNwbHxxhuoq+9ZQinsvpYqMDwoO92R9bT2mqJU85CDi18ik6THsYIqqEBsxEoLuSrPkCjYJqnHuzrKihR5qzGCF9Jjpnk4BE+GM+wIX10duipkOkX1jlZQFw7+99HIoht7AUSQCS7UX/BgTj5J0mwLFRODyckApw0uRxjhCqT+e9zMJG2kPeznGKgZfVyBdM4DLKeFIvUDhaGGd/rutg+7SnbU+SR36nk38WEtVudG1b0UeizP+Kk5LGM3aun86PCJ6wTt2hBnkgkMOymX1NVHMwkUv1JTiTCjk2ELr5oMonGHf2Mqw/xrs3xhD/Zlf3q+Ye5ORDf/uyjaGSLF5RbkfoXpSEQutC72RDyKq9HJNi0E6EG/m/TKu+C1tm4Ri5VE/NUAZrh31zIlwznTt2SXFI76g6pfSJFAjDtNKnZU18dMbKsO/2QsLxj7zJH+dSmFDpjrBOsMlCTACRJvX2O7bNwAPdONbx0Gbf61Lc0wEmVhdb1iNWacI/lc9pfyXs/FuJYgTwi6CD6BRYPCf1kUNMtYbv25KizuCKAL/oT99M6P3syP2YXFKdlfEC/dWB+1watFuROytBSvlHLgbNl/e1MkIWDHhNGLZalI1Cw8Y1mYGiuyk6nSi67P2SKwUpm7fbJbuOh0j+UkCQCbgr46lDy2+MxPlrdkXmVSquUaemyPACZU4Jy6t5MCGwgaYkIvMeTBll4P3xpvQrYeXX06NJJBQTj0JdA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(346002)(39860400002)(376002)(366004)(396003)(136003)(451199018)(2906002)(31686004)(66899018)(44832011)(30864003)(36756003)(5660300002)(8936002)(41300700001)(83380400001)(66476007)(6916009)(66556008)(66946007)(2616005)(4326008)(316002)(6512007)(86362001)(186003)(53546011)(6506007)(8676002)(31696002)(38100700002)(478600001)(26005)(6486002)(2004002)(21314003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czAyVHZSQS90Rkt6Z1N1L3ErTFgrT1RJNW9hblZlYloyaWFyNGljd0lnb0Jh?=
 =?utf-8?B?TnNZZ2d0L3l3WVFRSGlpeXMySTdCTG54aUppZy9UbU92Qkl0OExnNzFNY2Nr?=
 =?utf-8?B?QWhxSmhDMnlqYWdNMlJodnN6ZTBKMHRHdlBTdkJFblI1eEsxRHlKaGlsQ050?=
 =?utf-8?B?bWlBeWJmWjVBTU9RdUZhY05PaWNWcmJBV3RNS1RaWVRSai9SVXJSM2ZEdjcw?=
 =?utf-8?B?YU5RS3BrdHptWTFLeVpJV2Q3aGh1VkU0ZnlKYXh6ZFRkcEN4cEl0Y3BMb3hk?=
 =?utf-8?B?RzI2WndTRnJTRUxSNFJtdFRrc0x4NGJqU0xWeTA5MU85Q1NjS1YwbXZWV1Vy?=
 =?utf-8?B?SGcxQ24rVHlzVmxJVjlvWjkyb3RhQnJmM0RFeVZEMmM3RFdQbmt6VlA5VGJT?=
 =?utf-8?B?S0tUQUJOaWo3N3I5U2poalZsUUxKYzJEM2JwdlFtV3Nmc0dmWCsvSStaZ2t6?=
 =?utf-8?B?cUE5SXlxK3hiMGtBb21qcTgxRlBBVnpoS0s5WXhDa1dSR0Q1anVQcEVkVVc4?=
 =?utf-8?B?RS9hUHpzWE9tSW5qQ0owNGYxMlY2OEN5ODd4Rk1DMGdZZlR4cHlUckt0akdK?=
 =?utf-8?B?OVNJaTFYVWQ2Y2tRV1lycytvaE1FRnFtNzViVDZYaUFmTFZNSm5YaDYzbU9E?=
 =?utf-8?B?SjhBSUx4M0JreGhoQnJKWjlpVjBQZk5vaXhkc2NJS0NZWDlOWXI4WUw3SUdJ?=
 =?utf-8?B?ZjB5czZEblQ1ZFYvelQ3RXVjRDM5UjJjTlJNODd6NzYvTE1KY1cwdWJpTEpG?=
 =?utf-8?B?VDhtZ0d6OTBVMFZTdXRNZ01JYkM3b1ZNK0ZoYlF4QmVUU2lZSnlmVk5saGgx?=
 =?utf-8?B?bzd5UDNHd3lCRktDVjBkK1VYOUsvaVYwaXI0UjdYbUpuSlpUNEdPVzBmaFpw?=
 =?utf-8?B?OEJaWU5Udnd5dmFYUG9HZ09KWkcrZnhpM0JPRE9OVDZNSkI1ZGpWRDJpS2Ri?=
 =?utf-8?B?VU40TzZRak1oSGxjaGdDS1R1QUZScCthaFhqeWtsaUVCTDdUQnloZ3RmYThn?=
 =?utf-8?B?TWhKNzJBWXdEemNpRXhIS1pHVW1KU3FpSm5hNm13RmlreUMyQlB4NXZRK204?=
 =?utf-8?B?Nmw3eS9WcG1yNHVTRTNWYUQ2ZGxuN0hYL0thYWhIbzA1bnNsSkl5M0UyUEJY?=
 =?utf-8?B?Q0tLK2pUN3BKRk55RE5MZDBjTDNkTkFjRi81bmR1R3d3ZVd6ZzFRTWRkeklD?=
 =?utf-8?B?eDJHVlpPSEo4QlVRNHU1QjU0MXhNNlNrQW85SzZKSGpCbUR6azBMc096Q2xt?=
 =?utf-8?B?RHlrZ3BPM0ZZUmk2OGo3NTBnSHB0WXFPalB5dkdrYmRIaXBNMzZpUHVoaWhH?=
 =?utf-8?B?ODFMcjNFNmYrRUpvQjVLR2ozczYydEZuVjdhL2VpTzcwNmFXaTFQUFptNEc2?=
 =?utf-8?B?YWV0WXVQdWkydHgxbStDRjRQQjFwT0RuamEzbFBCZk1FVGVCOU96SVg2bHFW?=
 =?utf-8?B?SUFKRHBRYzczNXRjeWN4UUEvcElYMlA5QVJEbkZJTG02OWRUNDRYWnRRUUFT?=
 =?utf-8?B?N3B6TnhMTkVEYmF4RDQ0ajRmd0hYSGRDUzNMVTRtRzJ4WG1UUFQ5RGF0eDNR?=
 =?utf-8?B?d0lEOEtvbjFvcTdWbmhJNmd3VlJQekZ0YW5HS0dRV3VtNEpTNHJpanc0Mzhz?=
 =?utf-8?B?QU1oZHhKY3BBcWlxNE5TWTZLZlhncS91dk53bE10MHBGM1hWNnBBY0h5Q0hO?=
 =?utf-8?B?WENYOE9mYkxnWDRRekRKUEV6WG4wTE9OOTdHZ2h4YUpBWmltWHRRUHJSQ2VG?=
 =?utf-8?B?dmVuajhIQWRGVGtHWm5MS1NNdEYzM0NSeXJjaWxXZXg2QVBpaW5WTENXRnEy?=
 =?utf-8?B?UldOcVdwUm9ialpKYlhSUE5pUW5GUy9Nei9Fdm45SGVHVDh0T3Q2eCtZZnRJ?=
 =?utf-8?B?R3Awd2Fuc2NacTBQa0hLTURZV2l4UktZc05VMVdkZDRYdHZvZ3lKQVo0Mld1?=
 =?utf-8?B?SGJjOUVzaXNTNWxYYXdqTTZRWjBmWU90b2RDdTBlNzFaQndPZ2sveEZ3UGNj?=
 =?utf-8?B?enBqNTBzTjlPTGhrY3A4cFlHNFgrYTdaeG0za2kwOEVBRzB3Mm9HdEJWS1hp?=
 =?utf-8?B?Y28wc0RTT1habVZUa1lmR2libEhlL3FINEdVT2FlSGdkZUFuTXcySFNPWEJh?=
 =?utf-8?B?eGhNM0hlWVc1RlZOQmU3WUluZ25sSlgrNUh0dHk3VUxUZnczTUcrWVduRDEw?=
 =?utf-8?B?SFE9PQ==?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc68ae5b-db52-4357-ab8c-08db09ba4d33
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2023 09:53:16.8261 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8vVKoIhKHMf6nrKwj5MSts01xzKXZND1FRHr05gFstYmyQGITbxAjJfB/vK7Oz3KXTGOZuo7rI2RzUthwBN1puQAqV/YCAOkh9Ry3I8RDR8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8612
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
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
We need to unlink the msg when test is iterated multiple times. In case 
there's not msg, syscall will return ENOENT and that's why there's no 
check for it.
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
>
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
