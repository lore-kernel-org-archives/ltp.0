Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DD59E9370C
	for <ltp@archiver.kernel.org>; Thu,  5 Oct 2023 11:57:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 835A23CDAB5
	for <ltp@archiver.kernel.org>; Thu,  5 Oct 2023 13:57:50 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 708A73C267C
 for <ltp@lists.linux.it>; Thu,  5 Oct 2023 13:57:40 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::627])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 113A91BB9FCC
 for <ltp@lists.linux.it>; Thu,  5 Oct 2023 13:57:39 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WC4IP0grssT/xiUdI1qod5z9iQ7EBYlcPBri+Ep8dZWTQZCM46xDWyawBGDGBApcmUfy49BfDZjoLoaPO4miwbvLTdJY2lIkYQS1NUFAA15DYxTBHx17e2pPfcE0yanTBnTn7lcuhakq/v3Y8+fhbt/DfFHCHT/NFr9cBIlUSmpP4OBJXmaLL2uESsMDS9hHAL+yJDFvg3o1Lx2YV39vHSzcFIqIpybMqLbzLCr3N0vkEdAshvJlNSOSDWsrDCccJzjyfsagM6jDVTmcmH4ENi2/iywmGuk0IyLZKNZhuBxv4+DrPPcGL2C8IQC7bT0DJ/KUkvJrVB0irYFHH8QQZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vZvz4F40IPYDO1S6gTrmsnRgo8ZUx3X7cFel4d8UrDc=;
 b=MIj8I8RlpnmGCDv6d9q0MbmehnXAnRvj3kc+NmHxJz8dM56XutMzsxwKAWwSmNSBU/pDE3IJWHYMb5a8bCfhDqF4WMLcU2mJbl+zGApfI6Qjkvf+vJxWROyzit8AvAWjKcrolWQqO+UuAyGA6ixWGCERmGJvgBe74bB27nGccQR7uWuTNfhXofDm1Pfz229iOf1wYHbxydlWYt50Y/9GtQmMT0L7KCbq+3leC5dVMo/O8e1ZXfaUMD6vlTa1X+KB5qklJx8Y0UK3k8kG4YShqv9lOpWBpOMyEywfoIak0EbWrsHjS+vCOtSzizEA50mnvRtDIgbRe/1pOEFfDfZvgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vZvz4F40IPYDO1S6gTrmsnRgo8ZUx3X7cFel4d8UrDc=;
 b=pnofwwD8WHnU78QLfuKFUsBNv8RgaIpfsUx/SCuW+tQMFfwpjtJl+bZfgdec38JoZvid3wAsDHGcrA8ZI3WJsoIVztMVP468aZ2JO97bDfIlYJp5RBwGT90IzYJOKw7pujQ+I935OAdBbxC78A4hXKkzBEc3FSMgXCKU8xVm1d1MFh04uUOw7XyT5IqgRDPA05wpMzsOnHOUM3u+InxWPAxyZ9iECcGcHMcYJmW4/EZB6F2+E701NfHKtHo1DCjOeuwFPifxVZXscey1wk0y4MmxmGed/W+/oH7nMHhPaB4FiF50EWODvpjwNUNeTaGDMmnmdEqyJV+6IvlKuj4uSg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by AM7PR04MB7016.eurprd04.prod.outlook.com (2603:10a6:20b:11e::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Thu, 5 Oct
 2023 11:57:35 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::4f58:e0be:dd19:58ed]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::4f58:e0be:dd19:58ed%6]) with mapi id 15.20.6838.030; Thu, 5 Oct 2023
 11:57:35 +0000
Message-ID: <a379dd67-e786-41b9-91d0-5606cd67d419@suse.com>
Date: Thu, 5 Oct 2023 13:57:33 +0200
User-Agent: Mozilla Thunderbird
To: rpalethorpe@suse.de, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20230905114157.4190-1-andrea.cervesato@suse.de>
 <20230905114157.4190-2-andrea.cervesato@suse.de> <87mswx1lul.fsf@suse.de>
Content-Language: en-US
In-Reply-To: <87mswx1lul.fsf@suse.de>
X-ClientProxiedBy: FR0P281CA0149.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::16) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB6797:EE_|AM7PR04MB7016:EE_
X-MS-Office365-Filtering-Correlation-Id: 3498527b-7138-4ff1-c41e-08dbc59a4366
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CbB/1qJM0eiPA92qg4LtpjZk297OZq04ouSzg7ASq6kAJIht8pJ1DlrPuDImNXLkuUiOR3vaCqrh3dwNT9oz4XtGOhAG0nGPUVWVVmKr3VmxbPmT4MxRHeG6OiY0nbjy7SiyIVlC1WPIDHTrEubY+8K8wc2Hgj3V/3bpm/nHIIfhqq1L9WXDcd1xEQPetODyx4vYN5Ss4o/EdjJGVGsPVlNu8f6p8dx1NbXY8OxlI5biINVpAocKMCyDI+YoY7FEgFx+EvC8yG3ghtDte+9Yjt2d9GyLm7nnRjruq8S1+gZJuF2oY+XxMIo0DcRGr6kSnzQHCnBHuGF7X9+SZYo9dzkQUsbZKWv0z3KNzPA47hAuClFHDZLkcNPxtd19EC4rxN6oidptUoKy9T+/spbb830qX2bh19ruayBLjjgvMqCEkiJRXy6gt03EA7z3wNWobayBGQ52QD1zwsc96B5aLLTychyKrzqVTxSAdIsO3O6pmujM/A1fw5bhvtQlKWh+omM6UUs53/8sT+BJru5PFQylO54Bd7TgvFADMEPxPi3lEcgMcqz+ZCAaFX1AcnMm8DGcwkNHeTeo2HIXM860FnE34U9vL3nFc94IWWo3I0SWXxs48Bu4DCz6I8+tV7cSK+d16tEoCK1jSDN7KKv68R+lgwFrBfa3voR5/3mNxG8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(366004)(376002)(346002)(396003)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(31686004)(6506007)(478600001)(53546011)(6486002)(6512007)(66476007)(38100700002)(31696002)(86362001)(2906002)(6916009)(66556008)(4326008)(44832011)(83380400001)(2616005)(26005)(36756003)(66946007)(8936002)(8676002)(41300700001)(316002)(5660300002)(2004002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEQ1RENoa2lCSUhpdm9ZYlAzb0F0SWpyRXFVNDlxRE5YeldLMHM1RUJ1TERW?=
 =?utf-8?B?eWdKSW9DMUpaWjM1anNEVWhjSnR6UXQ0dzNBMlRhUWZXdFBHZExJV055bUNM?=
 =?utf-8?B?aHl4akNuVHpmL0djTi9Bb2JKVGxCMDlLdGQ0aWppSlJjR0tmL0dWUlkrZzlp?=
 =?utf-8?B?SFZrTG42alVySXdkU1huUDNZRW9Cbkg1SXBoYVNVQWl4QTV0NXZpckNySTVM?=
 =?utf-8?B?MUF1a1ZUaFJlOTg2dGtucHlSU1k5Q0NXTTNZc3VzNEN3Z3MycHg4cXNvVGFs?=
 =?utf-8?B?b1BPanpzNkNxTzF4RDN0aUVUNkNxVHhDdVpUTnliaGIwdytXRmxXd2N3UkxQ?=
 =?utf-8?B?cmlBWW1MV2VMY0FMMzBTRHRxVDQxYWkrTktCRUdhZDNCZGJxd2dQRWFzd1Fy?=
 =?utf-8?B?OTI3S1JSS2xVZWRjeHppRXp4MzhiUkJCckJkTlZYV2lTbG9UeWNpdDNybkVl?=
 =?utf-8?B?MGU0OE9COWRUaEN5dWIxK2R1NWJNTGY4dHFVMVc2MlpHVGFFeGZRdy8zaWJS?=
 =?utf-8?B?dGw5cDNhcWFKY1I3K3duekpVUVN2dnJmR24yMUNZTmJzSFJERXNNQjgrNWVo?=
 =?utf-8?B?MFB3OUdYMlVScEFhNHYyQTI3QzBVaHdDeWREODJpQWo1cW1yVnNvYjU5Vyt4?=
 =?utf-8?B?cEhEc0JRNGVMWk9ZTCttYlJOUWk5eUhhRUwrQUJmTFRxRDdwM1ZoN2kyZGFk?=
 =?utf-8?B?QnBpWjh5cUowZkZUUWNQa2dyOWZsOGZIOU94SDkzZzVJb1FNamhpVityV3Fr?=
 =?utf-8?B?YytMSDFRdVFIZCtOSGltMmVwemJDNWo1SG5aQXhROEpsNy9aZUYvZGl4dThC?=
 =?utf-8?B?NEtkY0hnNUNLM2xvbTJnU0x1ZG9iWHR0MTNKLzBROVJ2dlhaeVdLbjRiekJu?=
 =?utf-8?B?Z3hlMEJiNTZ2OWRsNkMwZWFzNUlMM1o4Q2ZyamYrRjU1WGRDTXJKSHlYT3po?=
 =?utf-8?B?K25LazA1Q0kwMzlycUJhbjJXOXdkYUVxZWlQcDdsQkFTeVcvbVpTZnB6K25h?=
 =?utf-8?B?VXQxRElycnFiUXhsK0g2M1B0ZUxsMk1TRlkzdEpIT1NJZlQyU2lhaTIxa0dX?=
 =?utf-8?B?UHQzRnFhbFkyeUxONUR2ZEdYeEZYcTBnakFsblhWQ1JOMXlTMHVTNGxWRkZr?=
 =?utf-8?B?VU16b21RS3JhY1FNTFUyWEsvd0FoaFRnWjZITVlMUjBCRVhSOFZBQTVzOEwr?=
 =?utf-8?B?SWpRV2JRTjdHMlBBOWhUbEFSelFjM1lhMEdkeEtTWTFMWEwwU2VUTi92TlhX?=
 =?utf-8?B?dnFnQjFyNUFsRkxvZHRKdjljcVB2STZuUm1zVGIrY0VLRWRWaTJ2RFB0RVdQ?=
 =?utf-8?B?dG8zSjRvRTRoeDhMMEoyaEc2RFpqajVsbDhSV0xndUJDMlJnaitLazlIZzgw?=
 =?utf-8?B?UmUrY2NqQXo1NW9ySnJYbjE3QkJIZGo2LytzenBpVXFVenRZbDBKVFJPT29W?=
 =?utf-8?B?WG5SN2ZQa1lmSld2dENMS1g4NkJiOGxyUllVSDJPdGFmKzNnbGlnR29lRjFa?=
 =?utf-8?B?YWhlTmNwM0cyR3pJSytydVoyZWpMNkh2OWZycmRtNzIyUlBUZ3ZkY2xEb2Zl?=
 =?utf-8?B?VXNZeWZ5TXFKditEZkVHc0xPUlUwOTJiMHlkKzh6MldjbGtSb0x5L3BYeUxY?=
 =?utf-8?B?a2owcVplMkJXSEpzVjkyTVFDYTNiNFpSU01meTVjSHdJRDhQVi9XSTdLR1d0?=
 =?utf-8?B?NUFiYXdMS0V3eWtISkJiTmN3TzNmc0tSc1o4S1FtM01TMmZ3SVlLaGZzMTVw?=
 =?utf-8?B?eGI1MVR1NUV4Qmt4OWNQVzhmZDJxUnM1STlpbVVsYmFXd1FCSkxyVzkxNHdH?=
 =?utf-8?B?QnFMSmtjcE1yTEdNekpNMzgrZU5iQ2xndGdDZjdzTEFOc2NDTWlvVURiT1gv?=
 =?utf-8?B?MlBSdXN3aHdFUjdmTjUxOWV1TDMwUVdpcUxHRWhudTR4MFhjVXRNWFFvZ1Vs?=
 =?utf-8?B?cEhLMHU4K25TeUhBYzI0Ym9DRGROOTdCbEVucGdJQnBjd3NBVzdrQTdHeXFk?=
 =?utf-8?B?cUp0MU9nTUFOSXhZaFZ5VHBRMjBPZ3dsZk4rWVVIYjltbE1zYXV2bENpT0lQ?=
 =?utf-8?B?YUtLT0JOdlFuY2tCRU01NXFrOXAxT3dNWjYwdnBoTGp0aStvMjZyRlhLL2tI?=
 =?utf-8?B?VjZkMkRvV2dnZFNSUXJGVUI1MEwxUHQzUmNEN1BkY05Pa0k1YVZkK1gwcTIx?=
 =?utf-8?B?UFE9PQ==?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3498527b-7138-4ff1-c41e-08dbc59a4366
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 11:57:35.2658 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gNO74BsH2jyrcgoaKtMWAaiZ8oz2iClL9b+ruzdUhSvRqIVY6MgXyMoaK4TPJ9frcfOxfOHbxlp2yU2FNWA12Zlnouw8ZLZ6aNeojOIfetg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7016
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 1/2] Rewrite gettid01 test
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

On 10/5/23 10:50, Richard Palethorpe wrote:
> Hello,
>
> Andrea Cervesato <andrea.cervesato@suse.de> writes:
>
>> From: Andrea Cervesato <andrea.cervesato@suse.com>
>>
>> The old test wasn't doing anything meaningful, but just checking
>> gettid() syscall was working. In this test we checks if gettid() is
>> working and if PID differs from its return value.
>>
>> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
>> ---
>>   testcases/kernel/syscalls/gettid/gettid01.c | 102 +++-----------------
>>   1 file changed, 14 insertions(+), 88 deletions(-)
>>
>> diff --git a/testcases/kernel/syscalls/gettid/gettid01.c b/testcases/kernel/syscalls/gettid/gettid01.c
>> index 7e5b6b175..3ee139d5f 100644
>> --- a/testcases/kernel/syscalls/gettid/gettid01.c
>> +++ b/testcases/kernel/syscalls/gettid/gettid01.c
>> @@ -1,96 +1,22 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>>   /*
>> - * Crackerjack Project
>> - *
>> - * Copyright (C) 2007-2008, Hitachi, Ltd.
>> - * Author(s): Takahiro Yasui <takahiro.yasui.mp@hitachi.com>,
>> - *            Yumiko Sugita <yumiko.sugita.yf@hitachi.com>,
>> - *            Satoshi Fujiwara <sa-fuji@sdl.hitachi.co.jp>
>> - *
>> - * This program is free software; you can redistribute it and/or
>> - * modify it under the terms of the GNU General Public License
>> - * as published by the Free Software Foundation; either version 2
>> - * of the License, or (at your option) any later version.
>> - *
>> - * This program is distributed in the hope that it will be useful,
>> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> - * GNU General Public License for more details.
>> - *
>> - * You should have received a copy of the GNU General Public License
>> - * along with this program; if not, write to the Free Software
>> - * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
>> - *
>> - * $Id: gettid01.c,v 1.5 2009/10/26 14:55:47 subrata_modak Exp $
>> + * Copyright (C) 2023 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
>> + */
>> +/*\
>> + * [Description]
>>    *
>> + * This test checks if parent pid is equal to tid in single-threaded
>> + * application.
>>    */
>>   
>> -/* Porting from Crackerjack to LTP is done
>> -   by Masatake YAMATO <yamato@redhat.com> */
>> -
>> -#include <sys/types.h>
>> -#include <linux/unistd.h>
>> -#include <errno.h>
>> -
>> -#include "test.h"
>> -
>> -void setup();
>> -void cleanup();
>> +#include "tst_test.h"
>> +#include "lapi/syscalls.h"
>>   
>> -char *TCID = "gettid01";
>> -
>> -int TST_TOTAL = 1;
>> -
>> -pid_t my_gettid(void)
>> +static void run(void)
>>   {
>> -	return (pid_t) syscall(__NR_gettid);
>> +	TST_EXP_EQ_LI(getpid(), tst_syscall(__NR_gettid));
> Perhaps this is nit picking, but this assumes libc didn't put us in a
> thread or just caches the wrong value in getpid. So it is more a test of
> libc than the kernel.
I understand the cache part. Probably we need to call 
tst_syscall(__NR_getpid) instead of getpid(), but I don't get the thread 
part. Is it possible that libc moves test function inside a thread?
> Is there some other way we could check that the main test process is not
> a thread? There could be some file in proc I guess. Then we are
> comparing information from multiple sources and it should all align.
>
> Also getpid could be called directly avoiding libc.
>
>>   }
>>   
>> -int main(int ac, char **av)
>> -{
>> -	int lc;
>> -
>> -	tst_parse_opts(ac, av, NULL, NULL);
>> -
>> -	setup();
>> -
>> -	/*
>> -	 * The following loop checks looping state if -c option given
>> -	 */
>> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
>> -
>> -		tst_count = 0;
>> -
>> -		TEST(my_gettid());
>> -
>> -		if (TEST_RETURN == -1) {
>> -			tst_resm(TFAIL, "gettid() Failed, errno=%d: %s",
>> -				 TEST_ERRNO, strerror(TEST_ERRNO));
>> -		} else {
>> -			tst_resm(TPASS, "gettid() returned %ld",
>> -				 TEST_RETURN);
>> -		}
>> -	}
>> -
>> -	cleanup();
>> -	tst_exit();
>> -}
>> -
>> -/*
>> - * setup() - performs all ONE TIME setup for this test.
>> - */
>> -void setup(void)
>> -{
>> -
>> -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
>> -
>> -	TEST_PAUSE;
>> -
>> -}
>> -
>> -/*
>> - * cleanup() - performs all ONE TIME cleanup for this test at
>> - *		completion or premature exit.
>> - */
>> -void cleanup(void)
>> -{
>> -}
>> +static struct tst_test test = {
>> +	.test_all = run,
>> +};
>> -- 
>> 2.35.3
>
Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
