Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CF9BC61DA4
	for <ltp@archiver.kernel.org>; Wed, 15 Mar 2023 09:10:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AD7653CD490
	for <ltp@archiver.kernel.org>; Wed, 15 Mar 2023 10:10:30 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2942E3C54D5
 for <ltp@lists.linux.it>; Wed, 15 Mar 2023 10:10:19 +0100 (CET)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04on0630.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0d::630])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 024536002C2
 for <ltp@lists.linux.it>; Wed, 15 Mar 2023 10:10:18 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nSxRkwj/vWUU91YpI9n/XOhIE+hS4abkPT9WN0AAPNpeDF17S/C64iGQlhASxP72/PE9IfkbdkJiZZI226hewiwtdQMCGIWT3o0l6YsDwRTlaueogFcxE007B0PVksg6g97OSV+rKZkCRJLJ53vjcpsnkvtDuHc7bc/4Ap7D80dSEXb4HSImGsgxTrABt0MzM30R7S+X0kdMel2c1B9hKvJuxUYYSZVPf/tHwFfVPcn1RJ6fNRKEvoJ6TYgGLsgmZZED9OQcZuuZFLVjlWOKOQa3/jJXfmc7tbJU9E8DQJI1LHlDWxlnCRuix3rWARI01ZT0hfLrf0ezeRGsrwY8qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fNVbioYqn0GExEqkQIULN0JFHiH/0fFjqqXUF6SGzYA=;
 b=cg8bTLB1IxHYJA0GEx2X6H6OAx3/pwpqF8EFxa0MD6qDP4EtDsU3JeRvKEL9eQ60mBW5MPnA1yK47qkxE9xNil+llyszja1smYPV2elRynAM5ashnKrMmrytYcrJ4xD0aH51pb/jQy0dNO6fIyGBOZgLNFvl0v6Tva1LEqCEnLGeTsO70nzlB/wWRps/w4ThgeCK0a9KXb1wHSjndYMKxO3JQpOYRjHdvzLDtkrSOZ6dUVIPgaH2xhs1WKbyDp/nES878EO2RGF8B7kI91/oT5eKwRMLKwdQBFZwIvW9nq7NskSThI6xJUllGLgK88iNkv+QRCz+on7ZHVzmXVJpdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fNVbioYqn0GExEqkQIULN0JFHiH/0fFjqqXUF6SGzYA=;
 b=zABejpe+E8IZaEfbnMgkAWPRrKBE4aSCBb1CZb3oF8DgcZs9R5K7OA3X3vh9P8XzAgLaHBPX+65llT3Ipu8uiJceAzEwW+TcCObzdZkhlMphTNBpFGzmZ/qRLKcbV+XIfYsUXTnIvinfhk0jPi9tiQ87RMwM8w/Sndb2/oeyPP+HhmCM+hv7yoxSw9Q9Wta6tTAAMHww5F474OlWnaeN9JF6YZYontL9wTUyDtgegsdsH8Y9o9x5TWvf8qomtRc+iKHpHPHOggW70n13bZEl87p1zeVXayIyecbuMNjLcSwTjpH+RXlk/vQMVsbEOsaEP2JPrEqv+eq9rt7zgziyyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by VI1PR04MB7165.eurprd04.prod.outlook.com (2603:10a6:800:125::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Wed, 15 Mar
 2023 09:10:16 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::e6db:281a:b03d:39ca]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::e6db:281a:b03d:39ca%8]) with mapi id 15.20.6178.029; Wed, 15 Mar 2023
 09:10:15 +0000
Message-ID: <2d3f7d41-2ee3-7945-dc77-627ae9ecc69d@suse.com>
Date: Wed, 15 Mar 2023 10:08:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To: Wei Gao <wegao@suse.com>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20230308132335.29621-1-andrea.cervesato@suse.de>
 <20230308132335.29621-2-andrea.cervesato@suse.de>
 <20230314234000.GA10628@localhost>
In-Reply-To: <20230314234000.GA10628@localhost>
X-ClientProxiedBy: FR0P281CA0111.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::12) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB6797:EE_|VI1PR04MB7165:EE_
X-MS-Office365-Filtering-Correlation-Id: 0673c861-b331-4e04-7cab-08db25351730
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QAhgeeO+QGs3YC3LT66EviQCyzVzTdAg7aLsAlr6GACmp5qu/mLtJr7ZnEJlkqVWKxrDCXVQX7qCca9QHpOiTf9UG2MYENKt/wgPF/AXMSj0GISBpZBRxQKwcdEk2lF0s/EuTNBVNVo/zqpjzhbbLdldhHKsJ1A6aTPSROvX8pvCAanbzJxTbXzocodSBmkyj7w8AzkABicZJMLuMXvAUHcycB5O1pXRHhNBsTgghCn0N4DgSP/qqBI0pdLc5zAXTCWlb6LLmjyuxvPYz2qM2mYUOBeywBwxmngOUoqU7JAYA0HU0pFs0Ff+MqFsmB4fm7bxzPuy6OI/w2t6/l20leLKRcNsABpjy4Mi9J2+CX77R+oAWxx/G3cXXgKxMnKaTF0i/C7akhVpwhcAVUCMuvbHNAvXyoTjvflQDZpWj0B159i+vSrv9QsbYXuM7zjOXs1nEfyxbsOFM8YPAlBhw/GCap46+/65X4KfjjQWPhhsEa1rDSj3FSKwvpCaRDUl+dC9F/zOSpDnQnSo1xXX1TSaFEQgD8x3NR7xW+FndIbqGVfxU3zckymwlpgvmUG+46x3zkFH7ym9BLx30pVLBhfK0a2PoyFwHR64IDs6/I5J1Sr2mydJrJtArCKdP+6TEEDZZeDckqFqYKbdprXbz2g+4RqutJnk5bak0N/uDznklm3dh6O+ictn/GDrnHUjojuuMkANLHFIOSzIzifLt0VUiHhc5oUSVbgT2VEpYZA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(396003)(346002)(39860400002)(136003)(366004)(376002)(451199018)(36756003)(316002)(110136005)(478600001)(6486002)(4326008)(8936002)(41300700001)(5660300002)(2906002)(66946007)(8676002)(66556008)(44832011)(66476007)(31696002)(38100700002)(2616005)(6666004)(6512007)(26005)(53546011)(6506007)(186003)(83380400001)(86362001)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWpsTnJTS2xWWXAxN1pjeXhpcEpQckpvTWRsbXlEbHVHckNXWWI5b3NoYm5Q?=
 =?utf-8?B?M2dNY2tqWDN1QlJOVHdsaEY3dHFVSUZKNzlMNXZjWUkybURyZkliYlRCK2NJ?=
 =?utf-8?B?Tk0xNXVaazBoVEIzU1lVaHFtb1RPdnZ4d0U1d01RSk9nRi9KdlRUM2ltbE93?=
 =?utf-8?B?TldiL05McXBWdmw4Mk9WdUtKMkQ5NXFqS1pwY3VKaWNHNlJydFErQlBKNEJm?=
 =?utf-8?B?MGg3OUFrMDZwdTNYRWptYVd4ZThRdi9pa1VBb3pCUzA0eVFNeitEQmljMnpI?=
 =?utf-8?B?ckozbnB6dmh4OWtYWGtNeFE4NWd6T0JaNGtYeFRabzVMV1ZXeW5SaDZBSkJC?=
 =?utf-8?B?UGZBL3ZvS3ZYY1JBNmZ4bG5WdlhFeTVvUEVkUWtIQ3l6amxaelpWWHFncjdz?=
 =?utf-8?B?bDNrUlNoU2YwelFrckxwZjB1ZkpSWmJHRUtzTGZTRVRkRTVPQStHbDNYRjh6?=
 =?utf-8?B?dTJsNDdINFJPdzFnWHFaM253TUhPcWVHcnRCa1dlU1VXanNvSjFPK1pMWUth?=
 =?utf-8?B?eUNGTUswdlhTdDBxbGMveUJqZm0yWmoxQzhGdmtBNWVKbmR5c0J1TkhzTjlM?=
 =?utf-8?B?SnhvQlBZTkt2a1FoczIvOHpkeldEbW9WMEdWOHBIeTVBZjV2YXVzdEsxS2lZ?=
 =?utf-8?B?MHJZZ00rYk50b0ZFMFlIUGdrVFV1RUxBYW9hbDl2ajdTbVN1S2dHZU12Ym1C?=
 =?utf-8?B?TUQzRnR5eHFkWWY1UlFyWnBNc3hBZFY5OXNqeUJQdUt1V1Nzb1lPc09HMXht?=
 =?utf-8?B?Z2hqd3ZjUm9rY0dnRjRGUllEQk9FMEFnRFlWWFg4Q29rR1JyR3dJeFJZR2NN?=
 =?utf-8?B?WExSS0ZDYTRaOCtmVjQ4UzVlOExDSExjQVBFMDRqT1B4Zkl2dGd0ZDE4bUky?=
 =?utf-8?B?emt1cnl1SFdOcW01VzlNc0JJdldidG9hS1Z4cVZ6OWxWYzVVTEg5c1I5eWdD?=
 =?utf-8?B?UjVGUEtjN2hkN3ZLWG9YcG9LY0lybHJHSXV2ZUVKMkRJdTNXWG8xbVRXSTJS?=
 =?utf-8?B?NXY1TVp4Zkl4bTJtc1c0MFFWUUNZWFZENzFWbTQrazlFZit1TURjY1pIc2hS?=
 =?utf-8?B?bzlkVnRhcFFneU53Y0x2eXBvNlppOEZ4MDFLTmc1SFhxaUhYN2hEOSt3bG9Z?=
 =?utf-8?B?bmJxcTVjZjM4MkJrb2hqUlU4d1B2TUgrYXp4eDg0ZmZGU3dDVDMzTTBmSmhs?=
 =?utf-8?B?NGcybWd0eWlhVXFWMWc3VlRaUEVpd1czMjlZRldNUFVUcGJXSFNkY3UxcERX?=
 =?utf-8?B?bTlNdU1wMEgyK2R6dDFKRE1PTDFwUDBSR2tZT0NYQWdZaFhpa2JYNWJlcCt4?=
 =?utf-8?B?aU5XVzJsVVhCVTdaOXpzcTJoRzc3VDI1VlNoQm9WbWFSMi8xTTFRRnpHdUhH?=
 =?utf-8?B?cXltclQvZHpLbWhITHZzSnB4ckNyZ0FQa1NOVGVRL2J3QnN3ZVM4ZFRNR2pL?=
 =?utf-8?B?MnQ1QWtZUElvaDF0dFh4Unpla1hjS2FRNEw1QUx4SjJGZTBOcVlvQVNTR0NC?=
 =?utf-8?B?S0tOVmlYQlQzdTA0MmVCRkpadHBXNHU1VVRVdysrWmpGUFU4Mk1WYzZ3SThu?=
 =?utf-8?B?WXBkaHZTdENrSlJ6RStuWDhFdm9ROUhaNmJkMjZpdXIycEhEWmZBeHhUeVBZ?=
 =?utf-8?B?UFI4cHAwRzVkUWNvSml5cU42T1pjeC9jZEZGeTVQZlp1NnRMQmIzMTNLcEVI?=
 =?utf-8?B?WnJSVzlGTlNZRGtwU2dKOE50dXBZR2FBSm5razFINlhCQUgvWm9Vak5VdFA4?=
 =?utf-8?B?c0JobzlXN3czcjV4alUxMkpIUmprb0NzdGMxMmNudDduaFowR05KeGFrWEdR?=
 =?utf-8?B?NkRaWDlEN2tseWc5VG9oSGhyMjVjcHRrcDJrMzZNK3A1VWJ1cjRQQTRjWDYw?=
 =?utf-8?B?dlpsOTNyeUJtRVQzU1ZKQjNnbXdWS01YWjhJelJJaW1tbW1YbEkyUCttaVNk?=
 =?utf-8?B?ZjZyK00xUERERmZhUjBtNmtmcXdJVFhzNUFJMjEvMWRIcS9LRlZuRXRiakpQ?=
 =?utf-8?B?SnNIZTgyZHU3Y2lZQWRXb2dFZkNQcllKWElUWDd3OExGQjh6QW12Uld2VThQ?=
 =?utf-8?B?TlJpSTVKaWVneURXb0ZjWXliZDZVUWpsYWs4NDJxTWd2bXN4dzFCLzJuc2wz?=
 =?utf-8?B?MzNOczFEMjdtd1VnZUluZ0pMUmdCYmhsMitFRFBRdUVLYm9LQnk3dFhrdUJC?=
 =?utf-8?B?WlE9PQ==?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0673c861-b331-4e04-7cab-08db25351730
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2023 09:10:15.7479 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Dw4IbMNGCjQ/r2nd29BftQ3ht9lJa6AH4RYBjVM+79lYTXpmltsXhmsU3+HxjIH678yw+Wlxam4l4SFsSfnC8MXnsFkmwEA56ZW9j2cjR0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7165
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 1/3] Rewrite eventfd2_01 test using new LTP API
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

On 3/15/23 00:40, Wei Gao wrote:
> On Wed, Mar 08, 2023 at 02:23:33PM +0100, Andrea Cervesato wrote:
>> From: Andrea Cervesato <andrea.cervesato@suse.com>
>>
>> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
>> ---
>>   testcases/kernel/syscalls/eventfd2/eventfd2.h |  18 +++
>>   .../kernel/syscalls/eventfd2/eventfd2_01.c    | 148 ++++--------------
>>   2 files changed, 51 insertions(+), 115 deletions(-)
>>   create mode 100644 testcases/kernel/syscalls/eventfd2/eventfd2.h
>>
>> diff --git a/testcases/kernel/syscalls/eventfd2/eventfd2.h b/testcases/kernel/syscalls/eventfd2/eventfd2.h
>> new file mode 100644
>> index 000000000..5350820b8
>> --- /dev/null
>> +++ b/testcases/kernel/syscalls/eventfd2/eventfd2.h
>> @@ -0,0 +1,18 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (C) 2023 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
>> + */
>> +
>> +#include "tst_test.h"
>> +#include "lapi/syscalls.h"
>> +
>> +static inline int eventfd2(unsigned int count, unsigned int flags)
>> +{
>> +	int ret;
>> +
>> +	ret = tst_syscall(__NR_eventfd2, count, flags);
>> +	if (ret == -1)
>> +		tst_brk(TBROK | TERRNO, "eventfd2");
>> +
>> +	return ret;
>> +}
> Normally we need put file or store this file into some lib directory?

Common pattern is usually to add a header file (if needed) with the name 
of the testing suite in the folder name of that suite.

Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
