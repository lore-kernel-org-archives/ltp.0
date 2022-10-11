Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FC2DC433F5
	for <ltp@archiver.kernel.org>; Tue, 11 Oct 2022 09:44:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BAA143CAEA1
	for <ltp@archiver.kernel.org>; Tue, 11 Oct 2022 11:44:05 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5E8CE3CAE81
 for <ltp@lists.linux.it>; Tue, 11 Oct 2022 11:43:55 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2081.outbound.protection.outlook.com [40.107.22.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A1BFB1A009A1
 for <ltp@lists.linux.it>; Tue, 11 Oct 2022 11:43:54 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f1Qwe9Dl4cHqoTc6ovpykcTrPHoxNtEFW4QreRtJrajM7GuJXKc4vCZApKkHXUxuXEpFQrjFtdeROZ6xQlCMtew0jUJ+oOmF6ZjkmJwFAdS5UQQVyMsQErpTYfZW6l8739YofHd1g69EuBuKPeeCtgnpC/hYrtSBMJVPaH1IW+rii6XoiNlL7dQnCZW6nJKVaB5rvCPuSFPoIcjh8cg4fpjlRV2OSyTZJUzBqe73E8LKC76vWEFNdZ9gbIp36grRloRCoQUUCjT45boD9ucJ0i+znxuOPiy74MffPqsTDApahWHvL4XH+iX8VQPDECDNqhZwF1I3723P+HoxmGL+2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JZClXFPtuT9zY16FbP/MiQpC/H0qVgP0Xxbo65K07Sw=;
 b=jhsEQ78XvfLY83sVHkp4IlGXQIo0k7N+zu4tqG33wfolwEkUDdoF9yjbf28Iw5hVtoW5F78RoW+iAQR9EpvvaFWsbqiWvDTF7EJXMiiiqC0YHsCS87QQM4tRsnZZEqR7V3Cy16Bm+SIwVkXp5vhhFtt+knVmQeASdJs/gDyB1vPS6ZQ5+yvovaVSHTVKlEEWMbNPxzLQ/sGERMlyRLR3R33JdA5mrCNUGyv+TKSCgFUOP20yR5lFxmyinM2jX6vcc94t+AQzdTbAclZfWc8CrWYozXMyN+44prugo4ffcDatl7ON5X3lyRHWEzgNompV6n5HVkwXkrZRN/8a+yQdig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JZClXFPtuT9zY16FbP/MiQpC/H0qVgP0Xxbo65K07Sw=;
 b=ODarMzMapdMUJ+9HatWfbcR9agaxN3hwa17OP0dOIhqwiVlJ5RMt3/SBCzjQk69IxQgg8KTlg0gL1aJx6wk454BtMcHya0w6KaYRA7RvxBBINIj+uIThvCaV0t6eENMTXvkYz5ugYOl1oHm00hUk20qK/eGtYfLU3CC67qGtAbB4+7lSrliuOZng5MuMpnY3mZv32/1PdFxUDjd70H0bLMdscIFhpglyq5tGoDJRaR/bjNvTfL7R4OciRkZJ1P1uhhoYBiiGDxXcOHu86jIFMoCVxu33AT0EZFXfMCha30kZs9h6wMxSNPKb6X18J4flvAonP54WAQmt7yFuOL7Ltw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by AM7PR04MB6869.eurprd04.prod.outlook.com (2603:10a6:20b:dc::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Tue, 11 Oct
 2022 09:43:53 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::70f1:c68e:b73f:d399]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::70f1:c68e:b73f:d399%6]) with mapi id 15.20.5709.019; Tue, 11 Oct 2022
 09:43:53 +0000
Message-ID: <f072f40a-476d-f07c-a79f-d453a2436bc6@suse.com>
Date: Tue, 11 Oct 2022 11:42:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Content-Language: en-US
To: rpalethorpe@suse.de
References: <20220722120501.28670-1-andrea.cervesato@suse.com>
 <20220722120501.28670-3-andrea.cervesato@suse.com> <87r11nw0qv.fsf@suse.de>
 <945eb0ee-b346-5729-3dda-4bff39bb52d9@suse.com> <87fsha2lge.fsf@suse.de>
 <87czay90fl.fsf@suse.de>
In-Reply-To: <87czay90fl.fsf@suse.de>
X-ClientProxiedBy: AS9PR06CA0186.eurprd06.prod.outlook.com
 (2603:10a6:20b:45d::33) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB6797:EE_|AM7PR04MB6869:EE_
X-MS-Office365-Filtering-Correlation-Id: 261173b1-92aa-42d2-03f3-08daab6d1bdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BNdO42W67rWl6RxMZCRZTmbzvh8+IDX/iNEyPX/jyh3uOGueGveEqQRSiT8Lg3rrrWBkdbfdvQy4YS4HofR+sKSev8vX5tnGEND5UAEMaiMIfIdQaMOizfCIleEiWA7dkmJ0auYKd+wXQe8zC5vbZzTciHgL1eJpU+7nl1ZdDQZ+pNUj0oQXNopZdIzWSM4mxcoJ0dTf/5qtLmb1yJ1l7O2Z2L66U60of0CVeI3stCtAdEk5t1q7aR9Df6l806qAGnEGwUV53Jtoaq5EK9RCcCcaxccvYmSpRfad0QX5d2xEJM1IoO0wFSTeANF6Iavh0iyypNYDs1q22vJj3RCWs13iE2xtJXyXfoFTH9TApbrFaNSwX1fjW9IcPZiL19OVbAlWr8h5L5FTXjCgb4yffY9MtOXAXW2jfcbhRvoPWnXsQ6ZWxyK2bsicuqBsvWtpP7ESm1tBVZfn56EATSwDHbwhcRXG0KjgKUSgQfSS25QseME2bB/LwDM1ShOL18d9LG0J9VQ2Eq+ETIlw4VAxP7OdTnWIJJS/Oh/x9i/Q/1zOcMioV/w4TzGKFBJMjh44g84UdBNhyBT8j6Vx8nHdF5Kb3V39jByV0WoAAL1ChaSuTlrWzcuuPv/byHadfaLLkr7l4/H2EDZ+26gkCBxoCulSBdKHKcwwk9Z/HmXFcbhTHLq6iJNyY1CCHEIZqUruIRHXUMx/5VxozeLhlTZVrUeKCHTM/+VXF4i7xuA8Q3+QSCW9JK+kABc8/KA2ds6eBMeeCLqWiRmx2lsU6mKRgmzyTUKHwoaRX3tvUUX7ww8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(136003)(346002)(376002)(396003)(39850400004)(366004)(451199015)(66556008)(4326008)(2906002)(6512007)(41300700001)(66476007)(8676002)(66946007)(2616005)(186003)(86362001)(83380400001)(31696002)(36756003)(8936002)(44832011)(5660300002)(6666004)(6506007)(38100700002)(6486002)(53546011)(478600001)(316002)(6916009)(26005)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K1pJMzBMR1VYbzROR3pIUE9lVktiM3FOQitRd0RWaEljMytadGNsZ2ZFY212?=
 =?utf-8?B?ZktkYXpxd2VQVnBJelgxZXJ0VmZHdll3bldmdlRtRDVwZTJ6MHZoZWZuNUVU?=
 =?utf-8?B?cTkxajloeFQycE5GcDVIWDR5ZE81QS9lVks0c1dwbEdJdmM3YkJFSVBneGxv?=
 =?utf-8?B?bURqSW11bUpwWkNhMUIrV2pxRG90U05EaThVdDhLdTh2TzVmdWVIckJOZkFN?=
 =?utf-8?B?NGtwVEFFbk40MldtQUEzYThJcjMrNk1UMDZqaUhpYkJiSDNpaEpVZlRkQ0Ru?=
 =?utf-8?B?U2VzL3htdkwxcTFMQkN5YkNIZytHSDRkOUY4Ny9uY29mUldHbEs1V3c3elBn?=
 =?utf-8?B?djgxalNqSnR0L1FxcWZJQ29JaXlWMktEYWlhaCswTVhFL1BkNVR4MjUrSDlV?=
 =?utf-8?B?K0JnTzJUVDBDeGw3bTMwSUR5UVljd1dNcHVVN0QyT016V2VET3Bxd0xyeHVa?=
 =?utf-8?B?cGwzdEJyaEF6VzVxckx4b0xBU2p6TnRnVGdac1NjMTF0RFZ4QnVEUDBwVTd2?=
 =?utf-8?B?a1plalo2WWlidlVDWlY3QjJMUGYyZG42Y0xOQitHdXJ0VzNldjZVYnUxWldR?=
 =?utf-8?B?aEkzSG5IdklDQVdmcjFaYmVmZTdQOVhkSDlpZGthS0tIU2o3MW5DMzl5S0ky?=
 =?utf-8?B?Tmt4VWNMa2ZSdlNHeTFqeDJIOGIxYzByN0tCR0RkRURTMm0zVWtvSHovM0kr?=
 =?utf-8?B?cEdxeDBmekFuZlRYcTlWK0dGcTNHa3hHTnRSVHpDeStveGRacCtZN2dCNUky?=
 =?utf-8?B?L1dCOEZ0VmFMNmlaUGpDNThyb3Y3UysrSm5KVDNUNlpjMG1WVWNQVkE1N1FW?=
 =?utf-8?B?Lzh0SHJEZGZpSVVDYS9JNXN1QVhSQ3hMRmFMMFB5dk9LM0tmSFhHbURsTDlG?=
 =?utf-8?B?b0Nxd094RllIaVExUHJ6VFhHMjkvYnR6anRQcGI4Z29wV1BsblpTTkY2eWtr?=
 =?utf-8?B?Y2xvVkJjY0RnQWtCWnlFNThueUhJVWx1T0lSVGljY3VJNnJFZmtZQU1zY2Fu?=
 =?utf-8?B?eTR0Q21IakNnZnBLZW5HaUFhY3QvdDlRYkZWVU42OU00b2xXL3VwZjdBd20x?=
 =?utf-8?B?RmVoTTd2bnhaNkZuNkxKTnluR2VRd0dyRXZ0OHJpd2Q0em0rWFNSdGYrZE9m?=
 =?utf-8?B?bkhzSEloZ2xBc2JienhScVNOU2cxVVJSa25uVVA4TG80MGFtc280cjFrK2Ez?=
 =?utf-8?B?akRpMkgySjZRQ283YW9HLzI0aURwYm02VTlRbmp5VFZhbzVzekp0Snplanl1?=
 =?utf-8?B?ZzZ3c29rTldzb21QR1VqZ0VMUXo1R0VZTWJGa2lEUlIzamQvQi9nUFM3NCtE?=
 =?utf-8?B?T21iOEV4VkEyOHhzaXg1bjl5Vk1ySXg4bm5SaGVTMUM0dFVqeFVTUmJzUHZP?=
 =?utf-8?B?dGZaWHdLL09hbU12TnpGREl1SFZyVFd0UGkvNkNtWHZFNTg1Vk45SThYa2NB?=
 =?utf-8?B?M2gyWjhmRmt2TktaTzFDQnQ5cmlJc2Fkc3duUXY3bWJjUWVWNjEyUHlPZWVR?=
 =?utf-8?B?MFlCcXFWdDRFWFlpWTlycm8yV3VkSWZ1L1dYRGJ0d0daSHFaTHNXOHN2Tndl?=
 =?utf-8?B?RC92cklLaVQ2YmowKzBMeFVXa2dOTmtwNzlmbEVhRTlvMXN4cnZkeGJLTmN0?=
 =?utf-8?B?TjdoZFZLVW5WTkdITUJpZ1ZsOG9PMGVhTzVHUWZCdmp2UVJ3YVB6ZFdIZlhl?=
 =?utf-8?B?bTNFMno5ME5Tb2x5ZGIyMDRSNXRVekNzS0Q0YktIMFJrSG94MUtvOEJMelB2?=
 =?utf-8?B?a0xJREpxbzZibThXOW9kcnRIL2ZSTEE1OWxPNDB6dEROcXdMUmJVMmxvTzVt?=
 =?utf-8?B?TE85MlNmeXZTWkZFUjRwZzFQMVJQL3dOeGNnbVJCVDlGQXVmSlk5SDJOWE5J?=
 =?utf-8?B?L01oczZlWmVocnZHSXc4YmhMU0JKUDRxTEhSZzJJM1BiSk14MGFPVnhTM1VU?=
 =?utf-8?B?MjU4N1FqbDhOUVFSZWVpTXFaM0xpTnkrTW5zVEdqcjh3b0ZKd1F5T0NTOVE1?=
 =?utf-8?B?cFl5TUtGRVNpNllGVUdOSUNKYUNPanJZNUh4MlJoN1lXc1NoYWZRUFR5akFC?=
 =?utf-8?B?ZTZMMWJMc3R4djBWRXM2cU1YZ3NLbGZ5Snp0MHZFeFFxWE9yYTdmYUFudU9x?=
 =?utf-8?Q?LDjC0DDuEQ0/7k58DZRoeuxbZ?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 261173b1-92aa-42d2-03f3-08daab6d1bdd
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2022 09:43:53.4381 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: //9yQm8HkpMaAMbOIRvAc+YKK66EyMkS+YMtb/FO55jjiXJewlF79fJlO/mFNRpkHkS8vGNqqqJuhHYPiG3vbsdvuFYpffXhstHju7VjE5k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6869
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/7] Refactor mqns_01 using new LTP API
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

Hi

Are we sure that we don't need this modification before adding 
tst_clone? We can add the patch and then starting to think how to 
replace tst_clone_quick with tst_clone in all tests.

Andrea

On 10/11/22 11:17, Richard Palethorpe wrote:
> Hello,
>
> Richard Palethorpe <rpalethorpe@suse.de> writes:
>
>> Hello,
>>
>> Andrea Cervesato <andrea.cervesato@suse.com> writes:
>>
>>> Hi!
>>>
>>> On 8/11/22 11:53, Richard Palethorpe wrote:
>>>> Hello,
>>>>
>>>> Andrea Cervesato via ltp <ltp@lists.linux.it> writes:
>>>>
>>>>> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
>>>>> ---
>>>>>    runtest/containers                         |   3 +-
>>>>>    testcases/kernel/containers/mqns/common.h  | 101 +++++++++++
>>>>>    testcases/kernel/containers/mqns/mqns_01.c | 193 +++++++--------------
>>>>>    3 files changed, 166 insertions(+), 131 deletions(-)
>>>>>    create mode 100644 testcases/kernel/containers/mqns/common.h
>>>>>
>>>>> diff --git a/runtest/containers b/runtest/containers
>>>>> index 2637b62fe..863a964ad 100644
>>>>> --- a/runtest/containers
>>>>> +++ b/runtest/containers
>>>>> @@ -16,7 +16,8 @@ pidns31 pidns31
>>>>>    pidns32 pidns32
>>>>>      mqns_01 mqns_01
>>>>> -mqns_01_clone mqns_01 -clone
>>>>> +mqns_01_clone mqns_01 -m clone
>>>>> +mqns_01_unshare mqns_01 -m unshare
>>>>>    mqns_02 mqns_02
>>>>>    mqns_02_clone mqns_02 -clone
>>>>>    mqns_03 mqns_03
>>>>> diff --git a/testcases/kernel/containers/mqns/common.h b/testcases/kernel/containers/mqns/common.h
>>>>> new file mode 100644
>>>>> index 000000000..92a77b566
>>>>> --- /dev/null
>>>>> +++ b/testcases/kernel/containers/mqns/common.h
>>>>> @@ -0,0 +1,101 @@
>>>>> +// SPDX-License-Identifier: GPL-2.0-or-later
>>>>> +/*
>>>>> + * Copyright (C) 2022 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
>>>>> + */
>>>>> +
>>>>> +#ifndef MQNS_H
>>>>> +#define MQNS_H
>>>>> +
>>>>> +#include <stdlib.h>
>>>>> +#include "lapi/namespaces_constants.h"
>>>>> +#include "tst_test.h"
>>>>> +#include "tst_safe_posix_ipc.h"
>>>>> +
>>>>> +enum {
>>>>> +	T_CLONE,
>>>>> +	T_UNSHARE,
>>>>> +	T_NONE,
>>>>> +};
>>>>> +
>>>>> +static int dummy_child1(void *v)
>>>>> +{
>>>>> +	(void)v;
>>>>> +	return 0;
>>>>> +}
>>>>> +
>>>>> +static inline void check_newipc(void)
>>>>> +{
>>>>> +	int pid, status;
>>>>> +
>>>>> +	pid = ltp_clone_quick(CLONE_NEWIPC | SIGCHLD, dummy_child1,
>>>>>    NULL);
>>>> ltp_clone_quick is still part of the old API and only uses clone2. I
>>>> think it should be replaced with tst_clone. This may require extending
>>>> tst_clone. In fact we probably need a test variant to switch between the
>>>> clone2 and clone3 syscalls when using tst_clone.
>>>>
>>>> I'll leave it to you whether you want to try that and rebase this patch
>>>> set on it.
>>>>
>>> I see ltp_clone_quick as wrapper of ltp_clone, since it's using
>>> ltp_alloc_stack without calling it explicitly all the times before
>>> ltp_clone.
>> ltp_clone is also part of the old API. At some point we should remove
>> that.
> I'm marking this as changes requested. tst_clone should be made to
> support this scenario.
>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
