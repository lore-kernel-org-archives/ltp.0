Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A775C54FB9
	for <ltp@archiver.kernel.org>; Thu, 16 Nov 2023 14:44:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DB2643CE3CC
	for <ltp@archiver.kernel.org>; Thu, 16 Nov 2023 15:44:15 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6E3E53CD0DE
 for <ltp@lists.linux.it>; Thu, 16 Nov 2023 15:44:05 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20609.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7d00::609])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E6CEE14010E4
 for <ltp@lists.linux.it>; Thu, 16 Nov 2023 15:44:03 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AhZNdqxo85To0DG6VGUpkvQik3hlMt6/XqixvTZnjEmGBputPh3uYaL/1HzAq9AERfw5c1WW0K54SMXC1rxrGhUV2DIqIxk4VmXmI+ef7sNvCCc8+zynpb7716kflg7Mq3ORCfy0JcIkpSNA9aYEHmJoj5k/URmQlgWo2qEPK7jw4ezl4ADfFcHVuoQxKDQIXRZorjw20epQdQkcnQ3WlDQt2ID4yoJVh2YVTdkqi6nRAjIbW18a8NUYrYdkfE7fEF+kNMwvtDassfemGwpyxJr/UeowDKW99+t2DkZTy3NTx9JAe1ZDv0FGsK+0vgNvKrM/xV83xOgCLj5IIae9sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q03XGfrEqHm9qiiyn3H6IcUC+OqjD7HUq6mD2ps8Oos=;
 b=kjXFE9tRJfgQ1oh3mvGRn+PGJH+T9XhhFnHbgKXordM2gpM7AxgCXtNSonsgFXVzF0glFNruZ5ChkLH/0IzTkl7XVLb+oeNTYwIFK1krZUa6kpOpIAqClr2dCVIBJEHUxVZoyR8tNV8XWcR0PaMHIXkDP2BC5F0mbW1i1oHrfgOyqg4z20nB7RZlz+673icJakfuYQz84JuQzC/Gzzt6RyXCjQZz6HQ8t5zZNbT/xUTsT2lhcLUWX2QqpFgyuVuA6kIvgHTAuRbXMbrtT8aUZ2B0paAyboxh/dlPV1Me3TNZHape8BROk0zSu97qLIysmSylV3cj8BH/FqvKrNKwHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q03XGfrEqHm9qiiyn3H6IcUC+OqjD7HUq6mD2ps8Oos=;
 b=f/a5YRn3666O5Hzh5YvXRKgF4XkqOMiCYgFXdxVT0NuEvga+ZQoBi6RdjO1FiK7lEGq4cJuB1qPdIhZzhM7KCm6Mqc+v8mJE6lywmL9/phmDft6I1LzMR+ls+1z7ytYrkXqtH06U4/4xJBPlI/WmREei2IUiqOS0Vk1fWDqxjMsC0nRkFm2S/saiSsv+HG9pPM/eG2GS5xJ9aBOJ9e0WS+ByuGGeQKS16R07n8wOJTzYwbmLT3Mbe+ZupQ94uwPQci4EY4sUiuSxqNPalMvcOkIelozaC04wui757dvs4qEVFOGpbTVCMW/21zvKZWL5qLeiCw8uS1wCYHGIIncsXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by PAXPR04MB9279.eurprd04.prod.outlook.com (2603:10a6:102:2b7::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.9; Thu, 16 Nov
 2023 14:43:59 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::37d3:a796:d252:be6c]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::37d3:a796:d252:be6c%4]) with mapi id 15.20.7002.012; Thu, 16 Nov 2023
 14:43:59 +0000
Message-ID: <b49fe5e0-cb11-453b-a89f-5fc5b6db8bb6@suse.com>
Date: Thu, 16 Nov 2023 15:43:57 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: rpalethorpe@suse.de, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20230911094043.25511-1-andrea.cervesato@suse.de>
 <87edhrvx3r.fsf@suse.de>
In-Reply-To: <87edhrvx3r.fsf@suse.de>
X-ClientProxiedBy: FR3P281CA0207.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::12) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB6797:EE_|PAXPR04MB9279:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f0b7157-ae3b-4e26-0090-08dbe6b277fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wc3y7XdFNthG4I2LUltbU28skvenQEtsOKiSp8dnE0J9rQB9NE4Crr98wTynVjkXXPOg379nhQpute/I6Xet3TxGHxlvOeA342G77wxAzx9tOhorj5Jzw33yBFOJE0+zeALQqoLXuPuYu+LwC1O89G5WD/8vg2Bl7rTnH3ATgGqQtldSGTfww6PQkNORhWAXWpG7doPlcCJyjpwVjkwkMrZ2VLJUVpj92PqyGWufxAZjzGuMw8RczpoyUtSMO277YeqZpA1SUqnvr+tVpSPo8vaAtp2jyhMjS2IbEDE9qr94S55602dnczdS0nirCZrr84ygJ5bhnKlgSizfCPJf+3UzShEqWwYkfn2EYfXx8oKESzb0lV60gx2YUuBraZPszamheZSGK2NO4ShoRjSrkkL+to5khxnkFZEH8Ggu4+uCmI9cWQA4+bPmA0Z/lOjaDXuSlkWfcOu46p80sVlIffDodAEIoaLxo6nLjeSrV2pnD4KnxBfjAXbZobH4EA9O3Oc+SYdNLrRDuRZk67DmO8T6fB9rTdiaD3yeeClFfFNbqh0mDQOED/4qiW/dYShUy0QadTaoFFqlLWBOj1zC1ZCUk1EEMTWUhBv585Hzw2TDPZeZBbdKFfmnMsgp6B3ssv8EtXp1Q9npwAT4iJlRD8cAoJqp72JbJ8rs/irY7AI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(366004)(376002)(396003)(136003)(39860400002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(6916009)(6512007)(316002)(36756003)(66946007)(66556008)(66476007)(26005)(2616005)(6486002)(478600001)(6506007)(53546011)(31696002)(5660300002)(86362001)(38100700002)(2906002)(31686004)(83380400001)(41300700001)(8936002)(44832011)(4326008)(8676002)(2004002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2hpZ2w2Unc0UWl0MGsvS1pmY2szdHlENFEzcmtKR3ZqYUs1d01Xdk1GaXBY?=
 =?utf-8?B?Tm9CVlhmL1BWQ2Y1akJXcEFNZ3JpMitOdFNsT1JiV0dBNHNzSXlYQSt3cTgx?=
 =?utf-8?B?ZWp6NzgzQlhBWWJNemNiUkdMang0TktnYUgxMG85bkZvZzg4MFRjenFiNUdj?=
 =?utf-8?B?eFRJU09Xc3RhVTRmZGxkdE9sUGZHSDliTUpJS1RDUWdBWHNLZnkvTlRRMGEr?=
 =?utf-8?B?dytxMWttMVZmRWZpY3hiTXorelhzY1ZwcVkweENqTFUwZTFKbSsvVkJwSDlZ?=
 =?utf-8?B?WlpaSlFJekVqbjVkZE9Xa0FTN3JhdmV1cUJpUW9GaFRpTnpxU0NDbS9SbzFw?=
 =?utf-8?B?RzJHOFZiUlRzN3pVOFJ5Smw4QUhSUE1VeHVrbVJRN2x5TEl2V1pZeW94LzF6?=
 =?utf-8?B?RXNjNzdmcmlKV25BWE0xTFB1S25HdkFKaTR0cUlIeXlhclNsVzA2WWdOUEFa?=
 =?utf-8?B?YzI1ZnlxNlZtcmhiK0dWWVJuSzYxcE85bHAzTUJiTlhKdGIwWGFlQWRnNERz?=
 =?utf-8?B?a1VoaWl3SlVPVXl3Mkk2S1NWODVIWGpRRzlDNmJ2cnIxYW5HelZuVmlhbjFU?=
 =?utf-8?B?eS8waXdJeVR2RVRwTUN1U3FidTBHQnB1ZFYxU1JZNGttY3VGbHBYWFg1dWpp?=
 =?utf-8?B?ZElqUGNuaFp4a0hZZlNBeGdpSkVRa1YraXoxcFlHVW1kVDUyZU1FK2E1Q2lF?=
 =?utf-8?B?RGNhb0FEMDgvQnJ0M3IzNmxyZmV0bHd2RWxXWWlIV05reUdDVE5tTWxiL3RT?=
 =?utf-8?B?Vll1b2VMREU5Uk1UNVNPK3dMVUZIaEQ1NzhwcS93d1luNXkyUjNibDJKaUlF?=
 =?utf-8?B?bmJiZnRpWFZIaTM1OXU0aWhUVVJCeForRlBWVnhqSklCQlFUN2RvOE1sekVy?=
 =?utf-8?B?enhrMlhHNSthZitDWE1BdlphMU1qcDlnemlvaFdnUmZVRXY3YkZvaWl3aHht?=
 =?utf-8?B?SWx0V1FaUXZDcEpqUnhvQUIzR3JaMG5yblNJRzdKZWFSNUF4Uml2cjlzalI2?=
 =?utf-8?B?UE9KWFVSNjdXZUVQa2d2ZjdHYWxySVdiNzRFTk11VzFlWUc5M3U2NTFqeGF5?=
 =?utf-8?B?TzJqM1RLSTJOR1NlOGhaUXVDTlNqcm50d1hPMS9STWVnQjdVMHBwSlZkTWR2?=
 =?utf-8?B?ZzBZalhzVUhvYjhnK1NLdmVzbCtaeWFDR092Ly9BcTJRYnkrazJ1NUNtTG96?=
 =?utf-8?B?TkRxcGx4eXBhN04vdmd2T3cyTFE5OEphdXpPMmtZWDI4aE1YaU1JTzBURHlx?=
 =?utf-8?B?QnJ4cmVZK20zbTY4QU9EUThpcEJqK29td2ljcS9ZRFh0T0tUMVJTWDFMZWZi?=
 =?utf-8?B?NHY1Sm8yYUFOMFFPaHZOYVNRQ21JVWs4RC9WZllIVkU2MmxMckYxUUdNNHIz?=
 =?utf-8?B?eERNdGVld0EzaXptTHlMMDVVRmo4RTUyaFlyS1VHSTdDdkYvQllJSjZ0Zzhv?=
 =?utf-8?B?QnlWSENCRElSSHRDVFVKN2VzbjFoKzhsUUpwbWxPbUF1Q29ZOUh0T0I0V3Ri?=
 =?utf-8?B?Z092MktmcWwreWppb1JNdC9IaUtGdXBNamFlU096cEs1Q1RIeUhZOEFkVjFw?=
 =?utf-8?B?Nnh5VGVyWnltNE11Nnk3NUYzejdRSmRtVlBmTXF1WHRUYkIyVXhvZHcwK2Nl?=
 =?utf-8?B?RVEvNjEwUkVJYVV0QUFHUWUxcUNaNGxaOGhWY0kzNWlVUm00ZGIwL0ZUTU9y?=
 =?utf-8?B?YWJ3aSt6UHo4VkVSRUNLYjJacFpJNThidTRNZDVjV0xUalk2ZnkvTEVSQmJw?=
 =?utf-8?B?Zy9MNDFBcEtGSm8vb1p2eXRDbmNxNGdRVlFOczVqM0RNQ1BLbllmK3FCTFdM?=
 =?utf-8?B?WmN1V0FTZlFhckJPK3VEbmJ0SzFIOHU5THp1Zkd1SmoyQWhpR256emhkekZX?=
 =?utf-8?B?UjRvQUpXU1hlK0lURnZtNjhMSXlYdERxSEZ1TzJBcGdFbldna3M5c3RyQ3ls?=
 =?utf-8?B?ZTZVQ2xON3dmTlNIWTM5Q2VzendOUjVZZ3dtR3lMZG5YaGg2c01KRFJrYmZW?=
 =?utf-8?B?ekpuSWxGZ3NQQktxODBxTTArUnNMVXRJdE01R084NzNKNjVHMk9UdkdjL2Jx?=
 =?utf-8?B?YkhRUUFTRlF0U2NqYU9BNXY3UFFBbXk3V0ZhSHBsakRWOHI2cW5walRNRU8w?=
 =?utf-8?B?TkJSVGlXVERVVERTVVEvRmIwTjh0dk90VHVBbjZMdWJPeFRjcnhBbXNMMVBF?=
 =?utf-8?B?WVE9PQ==?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f0b7157-ae3b-4e26-0090-08dbe6b277fb
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 14:43:59.6746 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z3p3jg+hUspdbQEQNDcgHBirB3GHhOfEJ5qu6uai3ZpwLyzfGPECdN4clEvSdFfoQv3uWKFViBPkPHcQahchSzhKCrP5uuAF46BxgTTCbXg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9279
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Refactor getdtablesize01 using new LTP API
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

On 10/19/23 09:53, Richard Palethorpe wrote:
> Hello,
>
> Andrea Cervesato <andrea.cervesato@suse.de> writes:
>
>> From: Andrea Cervesato <andrea.cervesato@suse.com>
>>
>> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
>> ---
>>   .../syscalls/getdtablesize/getdtablesize01.c  | 146 +++++++-----------
>>   1 file changed, 52 insertions(+), 94 deletions(-)
>>
>> diff --git a/testcases/kernel/syscalls/getdtablesize/getdtablesize01.c b/testcases/kernel/syscalls/getdtablesize/getdtablesize01.c
>> index d25cac261..80321e24f 100644
>> --- a/testcases/kernel/syscalls/getdtablesize/getdtablesize01.c
>> +++ b/testcases/kernel/syscalls/getdtablesize/getdtablesize01.c
>> @@ -1,119 +1,77 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>>   /*
>>    * Copyright (c) International Business Machines  Corp., 2005
>>    * Copyright (c) Wipro Technologies Ltd, 2005.  All Rights Reserved.
>> - *
>> - * This program is free software; you can redistribute it and/or modify it
>> - * under the terms of version 2 of the GNU General Public License as
>> - * published by the Free Software Foundation.
>> - *
>> - * This program is distributed in the hope that it would be useful, but
>> - * WITHOUT ANY WARRANTY; without even the implied warranty of
>> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
>> - *
>> - * You should have received a copy of the GNU General Public License along
>> - * with this program; if not, write the Free Software Foundation, Inc.,
>> - * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
>> - *
>> + *     Prashant P Yendigeri <prashant.yendigeri@wipro.com>
>> + *     Robbie Williamson <robbiew@us.ibm.com>
>> + * Copyright (C) 2023 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
>>    */
>> -/**********************************************************
>> - *
>> - *    TEST IDENTIFIER   : getdtablesize01
>> - *
>> - *    EXECUTED BY       : root / superuser
>> - *
>> - *    TEST TITLE        : Basic tests for getdtablesize01(2)
>> - *
>> - *    TEST CASE TOTAL   : 1
>> - *
>> - *    AUTHOR            : Prashant P Yendigeri
>> - *                        <prashant.yendigeri@wipro.com>
>> - *                        Robbie Williamson
>> - *                        <robbiew@us.ibm.com>
>> - *
>> - *    DESCRIPTION
>> - *      This is a Phase I test for the getdtablesize01(2) system call.
>> - *      It is intended to provide a limited exposure of the system
>> call.
> It seems this test has been broken for a long time unless I am
> mistaken. glibc does not call the actual syscall, it calls
> prlimit. Which has different behaviour (see below).
>
>> - *
>> - **********************************************************/
>>   
>> -#include <stdio.h>
>> -#include <errno.h>
>> -#include <sys/types.h>
>> -#include <sys/stat.h>
>> -#include <fcntl.h>
>> -#include <sys/time.h>
>> -#include <sys/resource.h>
>> -#include <unistd.h>
>> -#include "test.h"
>> +/*\
>> + * [Description]
>> + *
>> + * This test verifies that getdtablesize() syscall returns the right max number
>> + * of files which can be opened by a process. We test this in 2 ways: firstly by
>> + * comparing its return value with RLIMIT_NOFILE, secondly by opening as many
>> + * files as possible and then checking when open() raises EMFILE.
>> + */
>>   
>> -void setup();
>> -void cleanup();
>> +#include <stdlib.h>
>> +#include "tst_test.h"
>>   
>> -char *TCID = "getdtablesize01";
>> -int TST_TOTAL = 1;
>> +#define FILENAME "rofile"
>>   
>> -int main(void)
>> +static void run(void)
>>   {
>> -	int table_size, fd = 0, count = 0;
>> -	int max_val_opfiles;
>> +	int *fds;
>> +	int overfd;
>> +	int open_files;
>>   	struct rlimit rlp;
>>   
>> -	setup();
>> -	table_size = getdtablesize();
>> -	getrlimit(RLIMIT_NOFILE, &rlp);
>> -	max_val_opfiles = (rlim_t) rlp.rlim_cur;
>> -
>> -	tst_resm(TINFO,
>> -		 "Maximum number of files a process can have opened is %d",
>> -		 table_size);
>> -	tst_resm(TINFO,
>> -		 "Checking with the value returned by getrlimit...RLIMIT_NOFILE");
>> -
>> -	if (table_size == max_val_opfiles)
>> -		tst_resm(TPASS, "got correct dtablesize, value is %d",
>> -			 max_val_opfiles);
>> -	else {
>> -		tst_resm(TFAIL, "got incorrect table size, value is %d",
>> -			 max_val_opfiles);
>> -		cleanup();
>> -	}
>> +	SAFE_GETRLIMIT(RLIMIT_NOFILE, &rlp);
>> +
>> +	TST_EXP_EQ_LI(getdtablesize(), rlp.rlim_cur);
> The actual syscall may not be equal to the prlimit AFAICT (this can be
> tested using the prlimit command).
>
> The table size can be set with a system wide sysctl /proc/sys/fs/nr_open
> defined in fs/file_table.c. This is used to set the initial prlimit, but
> can be reduced.
>
>> +
>> +	tst_res(TINFO, "Start opening as many files as possible");
>> +
>> +	overfd = rlp.rlim_cur + 5;
>>   
>> -	tst_resm(TINFO,
>> -		 "Checking Max num of files that can be opened by a process.Should be: RLIMIT_NOFILE - 1");
>> -	for (;;) {
>> -		fd = open("/etc/hosts", O_RDONLY);
>> +	fds = (int *)SAFE_MALLOC(overfd * sizeof(int));
>>   
>> -		if (fd == -1)
>> +	for (open_files = 0; open_files < overfd; open_files++) {
>> +		TEST(open(FILENAME, O_RDONLY));
>> +
>> +		if (TST_RET == -1 && TST_ERR == EMFILE) {
> This could also fail with ENOMEM at least. Especially in a memcg and
> arch with large page sizes if there are any page sized allocations.
>
> Perhaps on some FS there would be other limits as well, resulting in a
> different error, but you can ignore that for now if you want.
>
>> +			tst_res(TINFO, "Reached max amount of open files per process");
>>   			break;
>> -		count = fd;
>> +		}
>>   
>> -#ifdef DEBUG
>> -		printf("Opened file num %d\n", fd);
>> -#endif
>> +		fds[open_files] = TST_RET;
>>   	}
>>   
>> -//Now the max files opened should be RLIMIT_NOFILE - 1 , why ? read getdtablesize man page
>> +	--open_files;
>>   
>> -	if (count > 0)
>> -		close(count);
>> -	if (count == (max_val_opfiles - 1))
>> -		tst_resm(TPASS, "%d = %d", count, (max_val_opfiles - 1));
>> -	else if (fd < 0 && errno == ENFILE)
>> -		tst_brkm(TCONF, cleanup, "Reached maximum number of open files for the system");
>> -	else
>> -		tst_resm(TFAIL, "%d != %d", count, (max_val_opfiles - 1));
>> +	tst_res(TINFO, "Opened %d files", open_files);
>>   
>> -	cleanup();
>> -	tst_exit();
>> -}
>> +	for (int i = 0; i <= open_files; i++)
>> +		SAFE_CLOSE(fds[i]);
>>   
>> -void setup(void)
>> -{
>> -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
>> +	free(fds);
>>   
>> -	TEST_PAUSE;
>> +	TST_EXP_EXPR(getdtablesize() >= open_files,
>> +		"max amount of open files per process hasn't been overflowed");
>>   }
>>   
>> -void cleanup(void)
>> +static void setup(void)
>>   {
>> +	int fd;
>> +
>> +	fd = SAFE_CREAT(FILENAME, 0644);
>> +	SAFE_CLOSE(fd);
>>   }
>> +
>> +static struct tst_test test = {
>> +	.test_all = run,
>> +	.setup = setup,
>> +	.needs_tmpdir = 1,
> This tests the underlying file system to some extent, so we should test
> all available file systems.
>
>> +};
>> -- 
>> 2.35.3
>
I think we can just remove this test, since the syscall number is not 
even defined in the kernel and glibc only use prlimit. I don't know, 
what do you think?


Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
