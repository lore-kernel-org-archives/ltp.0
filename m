Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE545C433FE
	for <ltp@archiver.kernel.org>; Mon, 10 Oct 2022 07:11:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2AA9A3CAE51
	for <ltp@archiver.kernel.org>; Mon, 10 Oct 2022 09:11:00 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 379C03C1509
 for <ltp@lists.linux.it>; Mon, 10 Oct 2022 09:10:50 +0200 (CEST)
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-eopbgr50074.outbound.protection.outlook.com [40.107.5.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 84A251400BDC
 for <ltp@lists.linux.it>; Mon, 10 Oct 2022 09:10:49 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hEXiibg4dhHH/M4W6trpoOURCYNA2n4lpMlyVpr36A+cGpo1O0woqA0KeTOAHRZCLmCI1ItcOFl8KaDfOm0Siycl7DZSduCN5I2X4XajChfIjowbaqRccMdMFC8m7vnyNurwKtbLBZ4fvbvyoOct1iFg0VoALU83Wrt/Jo2DgVcs8Arw2XF52XOyLZcVrxws12GzTkujxlfj+782d7/J3js+Lewswd/9EGDV8YOhPTq0ts4sDm3Sjg/0izT/IO/U5mxyM5eZsE8eZhGjG2vfQLfU80jgVaCmeMQWuNu/0eEtIsNmKIwPCvz3N4w7gl7D0UcxhBrfKtRX5fkWddFTHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XE4Aq5xZGXiKHt/qpCl7yymy3TP/Tqu/sdiVLkzjie0=;
 b=IopcsdX2Vyd8zWA4mzKO0BEdaYDAz0d76V9QYzjFKyMfFVmd+a2+DufiX4nM5C4d4uHrmltPQpa8nAiH0mJbo+ceLlzkWm1+0DBu75LvTdwSFO7hC2gwUnB03gNHmTPVW8+ECsg0lX8wKmblXwSD0oIGYlvJG8cRBcrMTQUhRxejPLiE95QtgxMnJl/ssfpfGMS0IJKCMW/kvkxxJ6HMxpMX0mcu+v0/6pCUCGWKBf7b+oDGGr7syUx3eO71GczjGcJ1iIHb96G+KhZ2Ja/EW9GQxKrK6rwRRAdI9UiL5P2rKfNpY4WXle2zTCJagmj5Cw5I9ssRnb5Wq8/CciHV8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XE4Aq5xZGXiKHt/qpCl7yymy3TP/Tqu/sdiVLkzjie0=;
 b=pFOwvd7zY/UjieR5OjtdFI3osuzOt93PmqymIXqO45uGzxqPbw7o+50vruSnQGNxCOiaCENT4s9j3yXg5nBLnt+zEmmUP19B6L5jVDBkRLUb2mDdenkPIPtvXyAF7b5JsQzo+LWsd/hKr/8xxe+/piXx7wADxQPUzsMbl0zFcIRHHzZcFPGTY7Prg9EjWFXP4VybqPtNGg9kuffm3V+wP3crmhr0T5NCYS2fG5JBjU6x8ryavubIJ5BjX17MEbzC7RNsjAZgyac+rK5lHl5dFc8duocsZPknpOgyb3zA6V+f5/gxccrn5gpPqHroiHAuahv0zM4g7t4WChnCX9GKfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by AS8PR04MB9079.eurprd04.prod.outlook.com (2603:10a6:20b:446::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Mon, 10 Oct
 2022 07:10:48 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::70f1:c68e:b73f:d399]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::70f1:c68e:b73f:d399%6]) with mapi id 15.20.5709.015; Mon, 10 Oct 2022
 07:10:47 +0000
Message-ID: <742e1e6f-0dec-44ca-cb23-416a62dd2724@suse.com>
Date: Mon, 10 Oct 2022 09:09:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
To: Avinesh Kumar <akumar@suse.de>, ltp@lists.linux.it
References: <20221007083406.16036-1-andrea.cervesato@suse.com>
 <8145468.T7Z3S40VBb@localhost>
Content-Language: en-US
In-Reply-To: <8145468.T7Z3S40VBb@localhost>
X-ClientProxiedBy: FR3P281CA0073.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::17) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB6797:EE_|AS8PR04MB9079:EE_
X-MS-Office365-Filtering-Correlation-Id: 88495a79-680c-4b6a-922d-08daaa8e8e51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2fjuKJbxJ2JRwAQZ8Fds0xpVYbns2zPkwKZG299GfywfXzNWlRob46EvhoUXZf0rFIV2zvtcQKIeLPn5aW+glW8VyshFkoKTUbLXF8ZLdKQCq1xxJBptehxaHG5KIITuqeSFlak9mOb+5mP6UquUztXI/nbWimrG9wJKeu82D7SWIqDifP2h+9GW4zBAobXFo9tn4XT4MNbhQhrf2uQXyfYHAXmk7xsffGgepMJwNu7mHXxgOjamHd+k/qShcnUxV7GNftJAIUuqqre6dC3UI2GlwxJz2JWLnZ1s2TYnurw1WJH885JiuSL2U0+tW96vh9+jzRvNoy+CY8bFvx5VLbdp8SrOUG3L2WUp55eW2lzp1rHjIofN78a0pC106YcxFj8sD4par6iQg3sTu8vaEFNImtlSQ4IV5r+G7s5QWwwSXPiEnYJu+3Qap2odinYBSTwPd8CTMcXqSMRQsKNAqXYIgDJs5Tfr1pjdWiyy6GF1aF27vn4rlUU1ysXdhFmILCjw9fOARY/i6Xh5b0N7sH0veywDfC6dbIwPvyOMSJPdFRgS7zKB0pLJ0hXJxYw0i0J1O5gKZBuTZOdKGUBzuXkChxDCsqnB/YpA7ATJFbR9xNnKaglHFf3hihaN4G5wjkKe3D/IYh9DPv6Qu3Pf28A4lxVGgIG46DnLSe44tMDAQQmZcIueHiCSeSItsl3c6FtPrGEG12AGgGPW2qYehWSblmoo86KUkwmW2zSE4DBsk4H8mBz90sVGlHreVxfrh3oZi7k5XFoOkHpCqlt/pvaww3UmteF9TX6g3C/dlLI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(376002)(39860400002)(366004)(346002)(396003)(136003)(451199015)(316002)(478600001)(2906002)(41300700001)(86362001)(5660300002)(36756003)(31686004)(66946007)(66556008)(8676002)(6486002)(31696002)(66476007)(6666004)(6506007)(26005)(6512007)(2616005)(8936002)(53546011)(44832011)(38100700002)(186003)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wk5PcU9DR0RLb0ZKaElmS3BpTmQrZXJNNGliTFFFSXNKUVVTYXFpeHNyZmlU?=
 =?utf-8?B?U09qUGdWK2VNMHRXaFFMdWxFMU13S2RkS1BqaEU2KzlDK1A4VENVMFhOU2xx?=
 =?utf-8?B?L0RUaXJiK0l4a0NiQTBjZXVPb0h4NGdaTTAzcTU1UXpRdUd4MmJVa2hjUE9a?=
 =?utf-8?B?ejJJUGtRamU3dVVjTFZ1WktYZmV3dVVObUk5YjlETnNOWW1pQUJHNnc3MDNi?=
 =?utf-8?B?RVlwcnZUUU5zUUwrRTFJQWNta0xMUkdjcGRHMktHUlhXTEVQVGtxNTBUNUps?=
 =?utf-8?B?bk82ejdud2JvWDJ4Z0wxQXRXQUplRFhlVmtCeSs2MVFBSUtsVlhjLzViQk1r?=
 =?utf-8?B?UkQwZ1VaNXZyTFl4aDV4aWU5U2VIR2ZUandkb3BLeDRTRmJRUXREaGZBU0x5?=
 =?utf-8?B?UnVFRUlPR20wQ3IraXAwKzRMcDNEVGNZSWF5ei9Xa3lxMTI2MVcxR3ozK3Jm?=
 =?utf-8?B?MHVtdWtqeHFOMU41N1Z3MGQ0QTkxM0dFT1AwTnJISzBnd2UydlpBSTFCM0NI?=
 =?utf-8?B?R0ExSmwrL2ljUTRTMytIVWtJdjIwRkZuM1BzUUVxZFBZYXpKa1pWL0p4QkdH?=
 =?utf-8?B?Q1dJWkFCdS9NeU80TGdaM3cwM3RhdVRiNnJaMnYwRFlpMkErTUlxZXFQQk5R?=
 =?utf-8?B?aFFLUzBaS0JvbSs2dG13eEtPdTR3YjE4V1hUYU5rWWpiSDBhSHZvbzFlRzhz?=
 =?utf-8?B?N0pqREFlcE01QldINjN4ZFFZS0FjajVEYUw0ZFQyM2JXa3NyajJVcnZ6SndH?=
 =?utf-8?B?NkxkcC9YRUhHSTVwOEhSa1hZTXd5Uko2MGRrZ0hEL0oxRmFZSjZRQUtZQUNQ?=
 =?utf-8?B?QlYxQ2JUVjBueHhoZXJDM2IvendkTFZScE5ab1F0emExam5FZzVDZytvUWxV?=
 =?utf-8?B?c0kxM0U5eE1NdkRwS2pkNEdBZExhVjVmazg0Z2VPQzRER3J0ZnNWNDlxb05I?=
 =?utf-8?B?Q2JPZFZLRGhrK1VLdWJnS2F2RmN1Uk1PMENPMG9mK3Vmc0FHQ3F3Zm53bVVk?=
 =?utf-8?B?MDJwaUZGOHdqNlJnZ21hQWttR3BqOHhBUXdRanJSU2xFczZ4a0RyZjZtVkd6?=
 =?utf-8?B?NEhUWHdHOXJCbzVlVnB1ZlNxK3cyU25uSjVVY00rZFlCUVRDK1JNUXlLUisw?=
 =?utf-8?B?T3FwajZIbDRlWUk3Uyt3eUdibGpXQUhSekY0WHFBNFlqa3pocUh1MXNEM2tI?=
 =?utf-8?B?SWpyNEh0N0M0V1hmOENJZ3RoWnkzZUFwSXRvZ1FIMGlNRHhNMjRUNUJHWStq?=
 =?utf-8?B?V28rOWtmQ05rQW5pTmVCNzhnQzN4VStWT0JkSkh5bUVUUkdQQWZSTFFjWVFt?=
 =?utf-8?B?RXBBKyttbWNYVkg2MlBRelVROGJaZXcycmhTanpLa00rTzIwK0tpTXhJZ0hF?=
 =?utf-8?B?ZlhSUkdLdkEyazF0dzFES0lvelZTL0grMWZsMkR0R1F5NmdjNW1nNDRsbUVm?=
 =?utf-8?B?STVzWlRMUzVRWTBZSmtadXlkRUFrMUdja1dydTNDS1pNY0JqbVdsUk5RU2NW?=
 =?utf-8?B?bDUxaHNydmcvdkRVVU8xU3M3djdFNXFQRVlTaTY1aUlFM2hHYnhzYVA2dkNy?=
 =?utf-8?B?cWZ6VHc5ZTZMczJKZ1o2eklqUFVJQXRSZXV1am5XOTdGeUR4L0hvSmVaTXhC?=
 =?utf-8?B?anNHUTBwMFV5Ull6WExZQUFVdy9zTW1Tbml6WVVKaFlmZVhBZ0dNSGNyQlpG?=
 =?utf-8?B?bkJIWFlGOTR3eFpnbE4zQURveWRzeXdJc1Bpb29JaFJBc0JicDZCNW8wOXZ0?=
 =?utf-8?B?Y2UvUjlBSmd4c0JpdFJLVWRNQUNjQW8vbHVpVi90em9VdWRNYlVpZEJtcmF4?=
 =?utf-8?B?RU1nMWU4bFpUa1JRdVN3eXpneTYwYnAxSFF6Y3ZNdUFKcnFIWjQyUWVCS09w?=
 =?utf-8?B?cXFoSmtYWUdlR1dDbjNTbnJOZWdRL3pMZEQ4clpCQVhTSlNhdEhPRlhYcmRq?=
 =?utf-8?B?emhGRis4NVJWTHpxWkxqbllmZWlWRTJXOW5EcTdkWGwxaVZRVFpLMDRwcWZq?=
 =?utf-8?B?TFhzb2tUOTlDODFURStMYzZnSGhsUVR2T0lxaTBnNC8rMllET2F5TjNkZE4x?=
 =?utf-8?B?WTdHZ09WQk51UzZWWmlTR2NDcHQwTjlxdDhRdFluTDkrbkRtdW9wa1RaVlVF?=
 =?utf-8?Q?iHgySrZJA++m8kQDd2WNoqXwX?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88495a79-680c-4b6a-922d-08daaa8e8e51
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2022 07:10:47.8634 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QB64KuhyDHC0EEKpxg444394r1ADtJPK78wwftwLW1H0uvlKPc69zLzUuNnr5Xl4ElGZiVAGqtZoRXgfgkFOeBBoBqQkw0KecKBndCH5k6g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9079
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Add epoll_create1_03 test
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Avinesh,

as I mentioned in the previous message, this patch has to be ignored.

Andrea

On 10/10/22 08:23, Avinesh Kumar wrote:
> Hi Andrea,
>
> On Friday, October 7, 2022 2:04:06 PM IST Andrea Cervesato via ltp wrote:
>> The test verifies epoll_create1 will raises EMFILE when
>> /proc/sys/fs/epoll/max_user_watches is reached.
>>
>> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
>> ---
>>   .../syscalls/epoll_create1/epoll_create1_03.c | 34 +++++++++++++++++++
>>   1 file changed, 34 insertions(+)
>>   create mode 100644 testcases/kernel/syscalls/epoll_create1/epoll_create1_03.c
>>
>> diff --git a/testcases/kernel/syscalls/epoll_create1/epoll_create1_03.c b/testcases/kernel/syscalls/epoll_create1/epoll_create1_03.c
>> new file mode 100644
>> index 000000000..7f51edf7a
>> --- /dev/null
>> +++ b/testcases/kernel/syscalls/epoll_create1/epoll_create1_03.c
>> @@ -0,0 +1,34 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (C) 2022 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
>> + */
>> +
>> +/*\
>> + * [Description]
>> + *
>> + * Verify that epoll_create1 returns -1 and set errno to EMFILE when maximum
>> + * number of epoll watchers is reached.
>> + */
>> +
>> +#include <sys/epoll.h>
>> +
>> +#include "tst_test.h"
>> +#include "lapi/epoll.h"
>> +#include "lapi/syscalls.h"
>> +
>> +static void run(void)
>> +{
>> +	int i, max_inst;
>> +
>> +	SAFE_FILE_LINES_SCANF("/proc/sys/fs/epoll/max_user_watches", "%d", &max_inst);
>> +
>> +	for (i = 0; i < max_inst; i++)
>> +		TST_EXP_PASS_SILENT(epoll_create1(0) == 0);
> I don't think this is correct,
> epoll_create1(0) will return a file descriptor (a nonnegative integer).
> And IIUC, TST_EXP_PASS* macros take a function call only and not a compare statement.
>
>> +
>> +	TST_EXP_FAIL(epoll_create1(0), EMFILE);
>> +}
>> +
>> +static struct tst_test test = {
>> +	.min_kver = "2.6.27",
>> +	.test_all = run,
>> +};
>>
> Also,
> Test reports TBROK if run for more than one iteration -
> $ ./epoll_create1_03 -i2
> tst_test.c:1526: TINFO: Timeout per run is 0h 00m 30s
> epoll_create1_03.c:28: TPASS: epoll_create1(0) : EMFILE (24)
> epoll_create1_03.c:23: TBROK: Failed to open FILE '/proc/sys/fs/epoll/max_user_watches' for reading: EMFILE (24)
>
>
> Kind Regards,
> Avinesh
>
>
>
>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
