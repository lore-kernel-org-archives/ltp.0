Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DA6DC38A2D
	for <ltp@archiver.kernel.org>; Wed, 26 Oct 2022 07:52:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BFFE93CA7AF
	for <ltp@archiver.kernel.org>; Wed, 26 Oct 2022 09:52:18 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A6ADF3C4FA0
 for <ltp@lists.linux.it>; Wed, 26 Oct 2022 09:52:07 +0200 (CEST)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-eopbgr60081.outbound.protection.outlook.com [40.107.6.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 20EFA1400DAA
 for <ltp@lists.linux.it>; Wed, 26 Oct 2022 09:52:06 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mAooRAHMR0cyf9eXyWnQcN0lt3WUeWu74PhVm6d68x1wnJ08mszNpUt5prbeOWfcUbvq+vy16aTLYMBbVGyvuMeBuwmg9o3vLGTK+xpF4huhM2470IsEAaUHKnS3z/acqlYZVpYgwsALweUbdgZeeFP3OxIg4mJ4+Z/pui0Or+AdI1BhgVFa8fP7L8PIpbgvABLcZKASuFfBmkewNMNbbc3EyLx0NQI8lg3QcS0bhlSnk/I0ZRSK84ZC54qX0ZZ8ScIUYwErYML7gGysrLJ1oXgSVPbZW7dIbGi7nSAusdMKTgBy+5YkmBUu2mYEROjkoDdi20t2YAVE4Ets9I/Wiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6AHT7fm1VIrsEI4woF/lJlAQzHP48woLc+CAVGKT07o=;
 b=AAjhWfepb41nxR0xQ9NjIe8QREStQvY+RYm7m9+nWWtNIWNXZQ9SvKnxpye/AVLgsQhE2JcNp85Rj4nhHPW9wMTezI/erW/42oPIq0+NKk0/R7pmveX6xcm5wz7H/P6MqeI1KXeCLTQ6Bj281APA0qnxOjyz4A3mqsWNL1bWAwhayBjbQUrQc7mO3xSkJvIS1lQpS8rXCVxgDURjWJaxcFnDcPkqQHs3mtbdK4blX2a/UQ0mHSM8g8mHOxOTa1JKDf+1jhFINq7xRV6xuCr17kGFi1sWPnGTgJbgU0hAjCeF9+Ira5mWW4GxCXR26eWd+opZRXeP9zwzRv46KNZ2Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6AHT7fm1VIrsEI4woF/lJlAQzHP48woLc+CAVGKT07o=;
 b=ZVSgOrPy0Jh3JAxcyb14yT3YOzxfuJvoxdm9pHgwpNokUaFsC43OSHE+Nogb09jul602q59CMXWoM+dWRq1BB6wicV48u4iIXbmC0xPtb/NB1jpoaYwan5SXSyHfNhc6HEqOCpfkT3rwiyJY4vXECOi5WW53BDOrUvrMv2gkYkgQNPFJ7Pa4rp9X1ESbcBWx6tPDsioiNETmyfxwRlYeNGLQrX2krnEboQLc4Nw+5K1/Eg5ZJStr9GpCsWxB9n6BBYFTmrFXhjOKl2kwhX3BVY3YGRAneBv1d293U8JRRGPdg8v/My8VNCgJSA6hDb0kNz3R411YsBMOGI2eWZ8lQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by AS4PR04MB9266.eurprd04.prod.outlook.com (2603:10a6:20b:4e1::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Wed, 26 Oct
 2022 07:52:02 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::252e:5914:3caf:6257]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::252e:5914:3caf:6257%4]) with mapi id 15.20.5746.028; Wed, 26 Oct 2022
 07:52:01 +0000
Message-ID: <8afb9e23-4489-9e7a-07d7-0924d567ce35@suse.com>
Date: Wed, 26 Oct 2022 09:50:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
To: rpalethorpe@suse.de
References: <20221006110642.12410-1-andrea.cervesato@suse.com>
 <20221006110642.12410-4-andrea.cervesato@suse.com> <87a65tjp22.fsf@suse.de>
Content-Language: en-US
In-Reply-To: <87a65tjp22.fsf@suse.de>
X-ClientProxiedBy: FR0P281CA0039.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::22) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB6797:EE_|AS4PR04MB9266:EE_
X-MS-Office365-Filtering-Correlation-Id: ad8860a2-810c-4350-74f9-08dab726f7a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u9+FFTCQXaOTm4ualH2oVZQINgLmJJNtQr1GleZQJsZzzikZWGIs5gedvnNTiBpAp31Zn0Hj6K9Rk1yioZcIcFrdsvOh2M8mc1AfIo9tWg/HVe5/aheGjSORzCCwBiS4FgGvHR+uL59wAGxebMJoOLsfawqshoGPIr333XUgxELHra7YfSTeZZQ9GmtZNleuG2VYUh2EDdGupW5CKQ/SJEUuM2V80LLx4ZBdxPQzcKXF/NZunF/80rDT4wkYPZ0jJefktBcwRwMYgqcZI45QOU82a9nuiCVCkkBKuJuHdIS1OsFF1TITCU/wwJQtNOy5BLHaD5I0DG18HHPglDCB+rEZP4perI1ByhVbpKUjLbNg2/Tx16/l5LUHfS8nVLUYjNITfXislGL0k7FEEo5cOmZyNUwuS/00ctHxhsKJbwf81eY1IWg3ueIJB9GDZM/U1PMlQ61QxmldJVLaNc4pIYHIERxBqWm+fw21mms2RC1xAQpIcCwk93hOR/yW/GqEx+bYASR6AghAMk8CLHn8Jv7RsiKBRHEM+2irsjCXSR9pY9jQa0opgQ8FWRbIOY9xNdrSNl2Z8DBOnpScvR8m5IvKhQVwDCDbuQv0G85x5EaxwLkDrHaeJsq5w0dUlbPb+k4fULVoUN0DmtLc61j0lBkPDOGqMyrjLjm6fFL1cTWxwRh/eOPZUtcFRepm4nAxw1q05JhwFrzi7tyR/tSIKLnL3FBGHYrQwGMuqK0ECdKjqPXY5OT6QXc5xibTo1TrcXEBT6wz+3d2g/B3V9HDKZOXGB0qDjTursb+5CEHQSc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(136003)(346002)(39860400002)(376002)(366004)(396003)(451199015)(186003)(26005)(6506007)(6512007)(53546011)(86362001)(6666004)(316002)(66476007)(66946007)(6916009)(66556008)(5660300002)(8676002)(478600001)(41300700001)(8936002)(2906002)(31686004)(4326008)(2616005)(44832011)(31696002)(36756003)(6486002)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Um1teXZUNUFoalZUUzJ5d004WEdibTFRTFdCSk9yYjhTN0p0Ui92bFExbzZH?=
 =?utf-8?B?SUhmRTZVc3g2a2p3cUdwVGRvNHN5Z3A3Wnh6VDFDT3ZkWVFsNmptUW5ERGdq?=
 =?utf-8?B?bGVwbzMwQkJTanJnUEw1UXhmUW1lRUR1SGtKelJ2b2ZibEMrSWFUN1h5SzlD?=
 =?utf-8?B?dWdEcTZzQkgzeko4aXRtdmNyOE5uMmdBMzlZdmZWK3NMV1RQMzZnVk9BV3lC?=
 =?utf-8?B?aHFNdisyemtDby9ROTFvODFlZUpvVk1qRXIvWGlzTGlZZllObGw2b0J2L0or?=
 =?utf-8?B?QVBueEdFZmNQZkpsV0tJYzYzbEo1b2gwVWdhMldmTm9nY0kvYm91UDVSSnpN?=
 =?utf-8?B?TmFCT1E1bnJkRDBGbDNPOUx5ZTZSWEpVUUdPdWU3RDBxSHFlKy9UL1I3QStF?=
 =?utf-8?B?cUNhcmpBc095a29oNXZFQ2lFN053WElpNHZ5akNrTGN4Uy9IZTc4NWVLQks5?=
 =?utf-8?B?TEpoS0tJa1lrbitiLzl5OThtWldHdldLamt6M081cHJXMnhBajU5b1ZpMnU1?=
 =?utf-8?B?YlJJeUdOci9tNUEvZkwzalJEZjlVMDB6VUxGNTJYa0xIZGdYZ0JtZ1F4OGtH?=
 =?utf-8?B?bUQ1TW9qVENUclFhelpvWk1MUzF4dEhOeCtVVEZnYzRVQ09GQm5oZUJjZUhJ?=
 =?utf-8?B?QzZZV01QMURLc21mS3ovQ0xvNkw3bEhsNjUwRnY1NGs4RFd1elJkazE1a1c4?=
 =?utf-8?B?L3VuR1NSTzF4VkkyNHE2Rm9mbkppZGpWWUcvK1phT2FwVGhHQk1aSUxHaTFa?=
 =?utf-8?B?S2NKV2pjN05XUXNjM2kwN1FDR1QwRGVRVjd4MGFLazdMQ1B4eCtmWUNqcG8x?=
 =?utf-8?B?cGZldkNWRkJvMFFyb1BLWFlmbWNmZkxKbk5FRXFnRGZCVEYvcDdBMEg0UmN1?=
 =?utf-8?B?cmRVNnlIRDBPYXlsYUpkS0RTd2xaTktUb21iVm1xZDB6M3hGMGl6SDY1UVJj?=
 =?utf-8?B?Q1lzaHdvaGtrZDJmRllXRUwxNENmL2NGTy95ZUlVT3pLZ2I1cVNhVk45Mkpl?=
 =?utf-8?B?NVAvazFKRVByRFJCNi9hLzVCZUg0ZzVzdTBsVXBjVDhoeWx5M05sTHBNZHB2?=
 =?utf-8?B?cnBONVV0eVU3NE5MRGh0SE4zNVlISUlzOTRnSGR6bUdHaEJQQVBNNFNuVjU1?=
 =?utf-8?B?UVFtYkVnRjZHSUlHNlFaelFXRzBBazZ6a0p0UEdxYjNpaXJCaDVGRkI5bWJP?=
 =?utf-8?B?cXg4UW10SzMxZUxYeFdsYVhzWjNIbHZQdTFNYkpxdzBHSXY5K1F5dFIzM25v?=
 =?utf-8?B?bUN3N0pOS25ENkpaaDdQd1EybTltZ24zVVdwZnlsczVWYk5jdlBRd1dnRm5m?=
 =?utf-8?B?bUM2U3NCbGxQQ01FT1JRdURCb2tyd3BhOUdlZ3gwYjd6ZlVuSVBpRGpwTzNF?=
 =?utf-8?B?QWs3S1JubXVzWnFkYytibWg0WGdrTWhIaVoxNHFaSXhUT3hMTlUyazExdEVG?=
 =?utf-8?B?SzBlM2g5QkJLQkIwT2JDQkxPa1N4Snh6UkFIaU5iQVJCL3BXbXRzaUhwTG0y?=
 =?utf-8?B?bDhvY1YyQUlUMFVqVXp5SS9kbEJNbG05ZVRLVGlJWi91NmxYMVlnRjYxVHRs?=
 =?utf-8?B?SlFFNHpkdS9hU0ozdmNCNEp0b3VJY2MrMktOdSttMGFQQ21XNEVZcGlBWTBN?=
 =?utf-8?B?dVBZb0xpZi8wTk5lOUVTL1RPdDMzTkZtS0JjdnFPUExSNDlDVWxCVHdPdDJU?=
 =?utf-8?B?YmprS2VnRGRERi8xSEo3TTlGbjZIYXNRcGNtakhhNGVLUkxnV0lpdWF2U3Zw?=
 =?utf-8?B?WFk1VVlmTGJLeFRDL0w4TjVXN1ZZWGp4R3hYSmtDbkl4dEFqbSt4ZTBBemZI?=
 =?utf-8?B?VDhiYkxqTVFOcWlGRUsyM2R4U0cvMVFkKytUbEdXRERvTktHKzIwRlFFYVJ2?=
 =?utf-8?B?RE9iV2ZrM0d5NkEyR2xzdm45cVBPN3V4Y1BKUHVFUEt5SlZYUy80c052M2Jx?=
 =?utf-8?B?VUQrc044SkJnOExXOS9FdGk5cHZOT2VOd080QktkcC9lVjRlRnZCdkxWVHAz?=
 =?utf-8?B?eUZqazE2bDRiai9hZUo4bm1TUFNPbFA5TTNGYmhwU0JPRkQzTWF4bWtzS2V5?=
 =?utf-8?B?b2EzNU9RWldoNXRZd2hsNG1hdDRmV1VJWElqdTJGaTZZa0FTYW85UFEvbmhZ?=
 =?utf-8?B?ODhSZmR2eFdxYlkrbUJpbnZmTVBBZlRzOGd0dUZjYWdiVXA3VWxyeTdMMXcz?=
 =?utf-8?B?QXc9PQ==?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad8860a2-810c-4350-74f9-08dab726f7a5
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2022 07:52:01.9364 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ysgUvqRlQwdgja++kinYrHAgt5l1OM0pjak4CA+1SB1twI8sT2SDmtD+lJ/Ru7qxU/801F+329cfRJB8uTBfkcjd2wkcetVlWSDr4yzBAfQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9266
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 2/3] Add process_madvise02 test
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

On 10/18/22 14:24, Richard Palethorpe wrote:
> Hello,
>
> Looks like largely the same problems as with the previous test. Let's
> get that one merged then lessons learned from that can be applied to
> this.
Besides the "memory.high" change I see a big difference from MADV_COLD 
test. That is MADV_PAGEOUT will swap pages when advice is applied and so 
it's easier to check if advice worked properly or not.
> Andrea Cervesato via ltp <ltp@lists.linux.it> writes:
>
>> Test for checking MADV_PAGEOUT functionality over anonymous memory in
>> process_madvise syscall.
>>
>> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
>> ---
>>   testcases/kernel/syscalls/cma/.gitignore      |   1 +
>>   .../kernel/syscalls/cma/process_madvise02.c   | 128 ++++++++++++++++++
>>   2 files changed, 129 insertions(+)
>>   create mode 100644 testcases/kernel/syscalls/cma/process_madvise02.c
>>
>> diff --git a/testcases/kernel/syscalls/cma/.gitignore b/testcases/kernel/syscalls/cma/.gitignore
>> index 846704294..47ae3e445 100644
>> --- a/testcases/kernel/syscalls/cma/.gitignore
>> +++ b/testcases/kernel/syscalls/cma/.gitignore
>> @@ -3,3 +3,4 @@
>>   /process_vm_readv03
>>   /process_vm_writev02
>>   /process_madvise01
>> +/process_madvise02
>> diff --git a/testcases/kernel/syscalls/cma/process_madvise02.c b/testcases/kernel/syscalls/cma/process_madvise02.c
>> new file mode 100644
>> index 000000000..9f42dd48a
>> --- /dev/null
>> +++ b/testcases/kernel/syscalls/cma/process_madvise02.c
>> @@ -0,0 +1,128 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (C) 2022 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
>> + */
>> +
>> +/*\
>> + * [Description]
>> + *
>> + * Spawn child inside cgroup and set max memory. Allocate anonymous memory
>> + * pages inside child and reclaim it with MADV_PAGEOUT. Then check if memory
>> + * pages have been swapped out.
>> + *
>> + * The advice might be ignored for some pages in the range when it is
>> + * not applicable, so test passes if swap memory increases after
>> + * reclaiming memory with MADV_PAGEOUT.
>> + */
>> +
>> +#define _GNU_SOURCE
>> +
>> +#include <sys/mman.h>
>> +#include "tst_test.h"
>> +#include "lapi/mmap.h"
>> +#include "lapi/syscalls.h"
>> +#include "cma.h"
>> +
>> +#define MEM_CHILD	(10 * 1024 * 1024)
>> +
>> +static void **data_ptr;
>> +
>> +static void child_alloc(void)
>> +{
>> +	char *ptr;
>> +	int freed = 1;
>> +	struct addr_mapping map_before;
>> +	struct addr_mapping map_after;
>> +
>> +	tst_res(TINFO, "Allocate memory");
>> +
>> +	*data_ptr = SAFE_MMAP(NULL, MEM_CHILD,
>> +			PROT_READ | PROT_WRITE,
>> +			MAP_SHARED | MAP_ANONYMOUS, -1, 0);
>> +	memset(*data_ptr, 'a', MEM_CHILD);
>> +
>> +	read_address_mapping((unsigned long)*data_ptr, &map_before);
>> +
>> +	TST_CHECKPOINT_WAKE_AND_WAIT(0);
>> +
>> +	for (ptr = *data_ptr; *ptr != '\0'; ptr++) {
>> +		if (*ptr == 'a') {
>> +			freed = 0;
>> +			break;
>> +		}
>> +	}
>> +
>> +	if (freed) {
>> +		tst_res(TFAIL, "Memory has been freed");
>> +		return;
>> +	}
>> +
>> +	read_address_mapping((unsigned long)*data_ptr, &map_after);
>> +
>> +	SAFE_MUNMAP(*data_ptr, MEM_CHILD);
>> +	*data_ptr = NULL;
>> +
>> +	if (map_before.swap < map_after.swap)
>> +		tst_res(TPASS, "Memory has been swapped out");
>> +	else
>> +		tst_res(TFAIL, "Swap memory has decreased");
>> +}
>> +
>> +static void setup(void)
>> +{
>> +	data_ptr = SAFE_MMAP(NULL, sizeof(void *),
>> +			PROT_READ | PROT_WRITE,
>> +			MAP_SHARED | MAP_ANONYMOUS, -1, 0);
>> +}
>> +
>> +static void cleanup(void)
>> +{
>> +	if (*data_ptr)
>> +		SAFE_MUNMAP(*data_ptr, MEM_CHILD);
>> +
>> +	if (data_ptr)
>> +		SAFE_MUNMAP(data_ptr, sizeof(void *));
>> +}
>> +
>> +static void run(void)
>> +{
>> +	int ret;
>> +	int pidfd;
>> +	pid_t pid_alloc;
>> +	struct iovec vec;
>> +
>> +	pid_alloc = SAFE_FORK();
>> +	if (!pid_alloc) {
>> +		child_alloc();
>> +		return;
>> +	}
>> +
>> +	TST_CHECKPOINT_WAIT(0);
>> +
>> +	tst_res(TINFO, "Apply MADV_PAGEOUT advise rule");
>> +
>> +	pidfd = SAFE_PIDFD_OPEN(pid_alloc, 0);
>> +
>> +	vec.iov_base = *data_ptr;
>> +	vec.iov_len = MEM_CHILD;
>> +
>> +	ret = tst_syscall(__NR_process_madvise, pidfd, &vec, 1UL,
>> +			MADV_PAGEOUT, 0UL);
>> +
>> +	if (ret == -1)
>> +		tst_brk(TBROK | TERRNO, "process_madvise failed");
>> +
>> +	if (ret != MEM_CHILD)
>> +		tst_brk(TBROK, "process_madvise reclaimed only %d bytes", ret);
>> +
>> +	TST_CHECKPOINT_WAKE(0);
>> +}
>> +
>> +static struct tst_test test = {
>> +	.setup = setup,
>> +	.cleanup = cleanup,
>> +	.test_all = run,
>> +	.forks_child = 1,
>> +	.min_kver = "5.10",
>> +	.needs_checkpoints = 1,
>> +};
>> -- 
>> 2.35.3
>
Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
