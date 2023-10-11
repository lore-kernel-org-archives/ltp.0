Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9E92CD6E45
	for <ltp@archiver.kernel.org>; Wed, 11 Oct 2023 08:54:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E2E2E3CD646
	for <ltp@archiver.kernel.org>; Wed, 11 Oct 2023 10:54:25 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0D9623C8B01
 for <ltp@lists.linux.it>; Wed, 11 Oct 2023 10:54:14 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7d00::61d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 700151A05C6A
 for <ltp@lists.linux.it>; Wed, 11 Oct 2023 10:54:13 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M+OHL4kUoHdOYRLDTHEVl3a+VTMIC48ilRa365CMdi/d4hkDsSTKNDyGgxgIOEVTYPPal1L4Gttu8spqsZDQLC/oUYiAX44K6Jc9mA4IPNGIEB1RQ92LiDXUQB2C3wG5hTyJITkaXuh+A9q7ew5F5osh0ndBZRrNLyxc1WeG9p6/XIdXfNGSUuDr9eyD9vQisVl7SHD5xh9J+LFDtS6mOBvL3xFR5sZIjhj/sMJeAfGwy52uWGLsjEKtm52QXZGAuTf+4EuarPFgdJJrYDA08Lh6w1fx5Myr0P8hFLZtybyNay0djz/p97sF6MFoCRVniRxWyzF89GxWBBiG7P0Upw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=COUp80HgQGbYjAYtTq+H9wtrskX7qz8Z+r7l9jGm3Oo=;
 b=g3zvthvK4BS3zLCFWK6I+yrAuW9F+l6/prtBVUZDpZnNdsEUPtP4PFYGjwQmwc2gmUj7OGUlUxib+EV/aUOGOqhi6n24OC0g4LTlCy7WjX6nJN7Omdq9s/qGJwCxt/mDASkABGHk0R3HGOfddN/RVL+MquRvRT291hEVP7sa52Xc/Bds+2k125FRgCeHlxT4vO+GoWMUQm/SvXX0Yw/EdBo3LP4jNa1LaldBZQXUXP1t9AStOLs0sIorqcDlujNBQ1W+ELCxgY324/RXL8S3T9XvOpsgFOB9P3ObYxsabMGRmzO7jAYg9uiOW9aARw1ml76zVZaiZIh5IbMAPiPjyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=COUp80HgQGbYjAYtTq+H9wtrskX7qz8Z+r7l9jGm3Oo=;
 b=aflRsMglsYF6rTnGrEmEBphFjBDpR6eTLawVUo/DDxtTseyIH0dkPyGdiNjEFCPaxqvU76lpfTwPoqPPfYj8LxabqomYgt+AP/6HBgH7wvYmaMFpXw5RhB5qliORje+qtXoTxbXm42TsoYnqjg9xN8Cvr0dOcb45n+zpnU2nmtRdQ1N8qPW84OMUaQAqurtA43hPlIBW0ZbJsGrN1EH9xirhShpyaogYmQNfq0s1WkMXqfCBqWeGggzXfm7Of3h0X9x9WPTHELFOJM3701kcWlATs6vBZ9yIrMHMKRkoWSzs4fRxDdTEP1EwC7Hj5f20DWwii42ZWl1TRQe74zqxlg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by AS5PR04MB9828.eurprd04.prod.outlook.com (2603:10a6:20b:678::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.45; Wed, 11 Oct
 2023 08:54:11 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::4f58:e0be:dd19:58ed]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::4f58:e0be:dd19:58ed%7]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 08:54:11 +0000
Message-ID: <30ac1949-383f-435e-8cff-fbba05d7d011@suse.com>
Date: Wed, 11 Oct 2023 10:54:09 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: ltp@lists.linux.it
References: <20231011025323.1558560-1-Xin.Wang@windriver.com>
 <ZSZhNWqK-MvqWHHA@yuki>
In-Reply-To: <ZSZhNWqK-MvqWHHA@yuki>
X-ClientProxiedBy: VE1PR08CA0029.eurprd08.prod.outlook.com
 (2603:10a6:803:104::42) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB6797:EE_|AS5PR04MB9828:EE_
X-MS-Office365-Filtering-Correlation-Id: adecece5-acad-452b-3527-08dbca37a2fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ispd6uiRL23JsWcUuZLvIVjUJwVfj0yGuCxcE/evPFZLQgL5d/6x9dCqxC94N9lkvb2D2JDirMwt1tSFvx7fkKBV+xKvKTuNqj3mMysPqAwKRaom+HV4sxvLTJpAMe9BpQnJRQ3U3NY6xCszjnUOdMYfH0D0S5S1+ABKW98RCPvYKwLZ482d6iByrWuqpE4wWzLBcyLt1NeMZWKdkOeoTU3uVDqAem0ko27ymH9TgW6wyzQf3u4P0Ko0+s8NIvHRFHmlKGIrPrNPxDLYEGEy3I/QZBlAgIJiZARyIBTfdBLOaEmIaTxldDHLE+R2f/53Dq1pXA7ZxZAFoTJJUhl82lkEq22q44IXJaK3vkPxLWUPiAAeZ2LNKSaaypE+NOo+sMYlKFtXpZmPwbQKNkSWdmdvmMUKf285SAWT0tL3tfw93Syck2ygkp6I5x+7cvmsXuBlp2DO+cVOaEkfe/q9583OQnkigTLve7or/mT52tei4/8N5VmzD7pqw30uINpk7UV8vYPpW12n1tGJrO2va66B/klBpPWHDUxtkOy6R0DK8FmzxUZ8LNAsuiixFK/Xzb5SwlH3X0dzOZUvAtpbRmkw1eROsFg7PMKIZruQ3pXJ8re2ITzSLmWSRUQ1xWX4/kS1BRRt1EZNPcRnAZOFlg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(6029001)(346002)(396003)(39860400002)(376002)(136003)(366004)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(36756003)(31686004)(53546011)(83380400001)(26005)(2616005)(38100700002)(8676002)(8936002)(6506007)(6512007)(6486002)(478600001)(966005)(2906002)(86362001)(31696002)(5660300002)(316002)(41300700001)(66556008)(44832011)(66476007)(66946007)(6916009)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amZJTUI4ZXQrTC9DSXFnL3VydzJ2ZWd6YU9FNUNkQ1laZ09YaGtKVmEwbXpS?=
 =?utf-8?B?a2tNRm91TmgzK1RvaWlsRVFFR2R5Uyt0ZGxZTzdORjdMU25xMVZjWC9OaTFP?=
 =?utf-8?B?aTAxbW1aNjEvUUh0U2xqUXV3bzN4cFR6OFlFcTlUVkxnQ0NKVHhZWW1namEv?=
 =?utf-8?B?SUFyZUNJcnA3ME04L2NnR2dIOVNOWml1LzB0MVhUdW1RSStMTG03YXp5RkpF?=
 =?utf-8?B?RTM4ZCszcFZKSVgwYVowekJPVDRJZXJBMEdJRTJwM0ZETU05TG9YR0MzT3hI?=
 =?utf-8?B?VHFldUtuZDBmdC9jSXJTUzBTc1VQc3dseGZLc1FzbldwckhqSVE1M0pPeUNs?=
 =?utf-8?B?OEV1RjVaWDA0eFdFUmlMQjlyWjJwcjFOLzRmUlc1WXVOR0tXNGpVdFRTUWhj?=
 =?utf-8?B?SXBPZXBiKzlMS2ZvYTVKaWR3Mi9CalIrcmlZQzFtNlIvcWZDVHFSZGl3eGNI?=
 =?utf-8?B?SU04ZU9Dbk9QY214T0M1b0RseFJ4OEZwSEtXZWRtUWZlVmhZa2hVZGxtZkIx?=
 =?utf-8?B?WHY5YVFIS05rRW9iNFQ1eE5mNUdoNkNDekRSNnlrd0l0NkdoWkllR0R0Z1VO?=
 =?utf-8?B?RlBndUplWENOMS9VTlhtQStJdHNsdkI5dEszT1FIY3Z5ZlpMeFBEMWJmYUpl?=
 =?utf-8?B?OVd1d1haZEZ3Q2pSWFdXdk5KWlJaUUtRbHhzZDEvbnVqeEMxdTR5RjBZbVo0?=
 =?utf-8?B?d1g1SE9pVXlCdzhweGJOZVRlUVJzNXNjeEFualpDcUZaaVdZUzlLWnBBcE1x?=
 =?utf-8?B?SnpsZU9QTzNpQUhqaFA2dnVMcHJxbkpPZS9oK1FialZqVUlKcGQ1OG4zK0Jv?=
 =?utf-8?B?N21BUEpkd01aWHZmQXk5b2g1Z1NKZHVJcnE2UnB2S0puSmxCOG1wRVV4SW8r?=
 =?utf-8?B?dW1BTU9sc0FadmJPeVBnQVBIUVdNN2hCbE0vQm9XdjMrTHljZkhSWWJUMkp2?=
 =?utf-8?B?SDlTZ0FQd1VGK2YyYXQxU0pFVGUxNHFPbDZrS0o2M3puVTBSTlRGbGl4cjAv?=
 =?utf-8?B?WG1GMHg0RVJNUnMwWDdJYkhNS2dCZlFWSVJjQ2VUSjBNelZyTnM4ZGExeUxn?=
 =?utf-8?B?TEhtVkxsUVNtUTRLRlJOeE5udVB2bXpHZ2JPWXJQczRyMUhlc2tVdU1McGNI?=
 =?utf-8?B?Y0NvN1J6dlAwUXFZTTB6N2ZUOGhScEdpV1dHaFlzZHcwcGhmQkFlQUQ2eFpl?=
 =?utf-8?B?bWM5MUZrNVZnY0tlSE01SDJ5YWl5dUQwYmJnQlVpWHJzV01VYi9jYnE2RTl6?=
 =?utf-8?B?NmxDMlpXeFcyOGRtbmhvbi9WOTFLQnNFSzhydSt1NGphYU9DbG5EWVhwWFRL?=
 =?utf-8?B?K291aGlGQUxsVlp4MStCdy9BYm9sRUxsVGFEdDZvR2lzSE1najd6bGRIQjNp?=
 =?utf-8?B?MWhTT0p5QkxpN0RvVDgzVUhIUjdzZm9HSmZrUzhoQWJ3RjA2QUZxOTdJbkEv?=
 =?utf-8?B?bEU0UHQ3eGE2WkdyT2wrcmlUMFlVU2xzMmpKaFA2bWZXOHRJWmRWbEVIbGFk?=
 =?utf-8?B?NDhnWGRLN2xFaFpuYWFlUEozZkROY01WY3Z6YjhhaEd6elBHaG44QkdJWnlo?=
 =?utf-8?B?RzdRaHkwbm9QRE5PNElBR3dGOFdEU2E2WVdoMDRaMmdGd0ljM2I0Smx5cjRq?=
 =?utf-8?B?RVZCOWFiQ1BoWXcwYlpVb2lpblRKUVJYNzloNjRyNVpnZTBPZEFSY0lhc1VN?=
 =?utf-8?B?QnZnVTVGWVJ2ZGNDbmlhL1JLYXZSWHRoTWxEd2hQR3dRekNvVG5mbzlxUWNu?=
 =?utf-8?B?T3Yzb21BS2R6a2RMeUpTMGd3QjY3V05GVVBtaTZRclc1WVQyYjNDWXdTRS8x?=
 =?utf-8?B?V2M2empidEJTT2tueVVadXlOMGdyLy9aMU9hMVpmV0lJRVdacVphSHJmOGsy?=
 =?utf-8?B?eHdEU3NUeXd4UVM1S3pUSTdHZ29hMUo1aEEzaXFGWTdiV2FrZkcrYVo5aGpX?=
 =?utf-8?B?UW1KQjVZNW5SaEp2MWVMUFp2ODREUlV2Q0p5MmZXRGxKRzRCYjJvQUlBWFZ6?=
 =?utf-8?B?bmYySDN5S09kNElTaXZEdWh6U2NkUHAvbEtoTTgwM0tqVE1nTnRYM0haMUpu?=
 =?utf-8?B?RC9JUXhiZEJrcjhHMEt0MVNXbXladit6cHphQnNPaWxYM0MzSVhzMzgzSktH?=
 =?utf-8?B?TW1LUnB2OGVxZVRrMjdyYklQYWlCNWJLUDE0ekFyOHN4MGY2R0lMTzE4aGMy?=
 =?utf-8?B?N1E9PQ==?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adecece5-acad-452b-3527-08dbca37a2fa
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 08:54:11.0967 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h5zb4zoeShazYgaG7UZY3imRfQkW3w3hDWl0zKkpbRrjU+yNyo2wYMAm3aF2kRPfQKBV5zVdN6qY4NjLO5Fe+zcHkhzErwYFFbVs9aY9dIQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9828
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] enable fsx-linux.c running on VxWorks user space
 and add measurement of execution time
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

Hi,

On 10/11/23 10:47, Cyril Hrubis wrote:
> Hi!
>> I come from Wind River. We and our customers used fsx-linux for file
>> system testing on VxWorks user space and total execution time also
>> received more attention in the testing.  So I upstream the change of
>> VxWorks compatibility parts on this patch, wish to enlarge the test
>> support of fsx-linux.  There is a point need to explain, because
>> current VxWorks doesn't support CLOCK_MONOTONIC_RAW , CLOCK_MONOTONIC
>> is still used by VxWorks when calling clock_gettime.  When
>> CLOCK_MONOTONIC_RAW is support by VxWorks in the future, this part
>> will be removed.
> Actually Andrea started to clean up and rewrite the test so that it uses
> LTP API and he will send a patch soon, can you please send a new patch
> once that rewrite is finished?

My 2 cents: I would go the other way around, since I'm busy with 
different things and it won't be available that soon.

> A few comments below.
>
>> Signed-off-by: Xin.Wang@windriver.com
>> ---
>>   testcases/kernel/fs/fsx-linux/fsx-linux.c | 44 ++++++++++++++++++++---
>>   1 file changed, 40 insertions(+), 4 deletions(-)
>>
>> diff --git a/testcases/kernel/fs/fsx-linux/fsx-linux.c b/testcases/kernel/fs/fsx-linux/fsx-linux.c
>> index 64c27a0f5..2064fac16 100644
>> --- a/testcases/kernel/fs/fsx-linux/fsx-linux.c
>> +++ b/testcases/kernel/fs/fsx-linux/fsx-linux.c
>> @@ -39,8 +39,10 @@
>>   
>>   #include <sys/types.h>
>>   #include <sys/stat.h>
>> -#if defined(_UWIN) || defined(__linux__)
>> +#if defined(_UWIN) || defined(__linux__) || defined(__VXWORKS__)
>> +#if !defined(__VXWORKS__)
>>   #include <sys/param.h>
>> +#endif
>>   #include <limits.h>
>>   #include <time.h>
>>   #include <string.h>
>> @@ -849,7 +851,12 @@ void domapwrite(unsigned offset, unsigned size)
>>   		gettimeofday(&t, NULL);
>>   		prt("       %lu.%06lu memcpy done\n", t.tv_sec, t.tv_usec);
>>   	}
>> -	if (msync(p, map_size, 0) != 0) {
>> +#ifdef MS_SYNC
>> +	if (msync(p, map_size, MS_SYNC) != 0)
>> +#else
>> +	if (msync(p, map_size, 0) != 0)
>> +#endif
> It would be better to define MS_SYNC to 0 on VXWORKS instead.
>
>> +	{
>>   		prterr("domapwrite: msync");
>>   		report_failure(203);
>>   	}
>> @@ -1115,11 +1122,16 @@ int main(int argc, char **argv)
>>   	int i, style, ch;
>>   	char *endp;
>>   	int dirpath = 0;
>> -
>> +	struct timespec time_start, time_end, time_diff;
>> +	
>>   	goodfile[0] = 0;
>>   	logfile[0] = 0;
>>   
>> +#if defined(__VXWORKS__)
>> +	page_size = (int)sysconf(_SC_PAGESIZE);
> We can just use sysconf() everywhere instead.
>
>> +#else
>>   	page_size = getpagesize();
>> +#endif
>>   	page_mask = page_size - 1;
>>   
>>   	setvbuf(stdout, NULL, _IOLBF, 0);	/* line buffered stdout */
>> @@ -1267,9 +1279,12 @@ int main(int argc, char **argv)
>>   	signal(SIGUSR1, cleanup);
>>   	signal(SIGUSR2, cleanup);
>>   
>> +#if defined(__VXWORKS__)
>> +	srand(seed);
>> +#else
>>   	initstate(seed, state, 256);
>>   	setstate(state);
>> -
>> +#endif
>>   	open_test_files(argv, argc);
>>   
>>   	strncat(goodfile, dirpath ? basename(fname) : fname, 256);
>> @@ -1336,12 +1351,33 @@ int main(int argc, char **argv)
>>   	} else
>>   		check_trunc_hack();
>>   
>> +#if defined(__VXWORKS__)
>> +	clock_gettime(CLOCK_MONOTONIC, &time_start);
>> +#else
>> +	clock_gettime(CLOCK_MONOTONIC_RAW, &time_start);
>> +#endif
> And here it would be cleaner to define the clock to use instead of
> ifdefing each clock_gettime call. I.e.:
>
> #if defined(__VXWORKS__)
> # define CLOCK_ID CLOCK_MONOTONIC
> #else
> # define CLOCK_ID CLOCK_MONOTONIC_RAW
> #endif
>
>>   	while (numops == -1 || numops--)
>>   		test();
>>   
>>   	close_test_files();
>> +#if defined(__VXWORKS__)
>> +	clock_gettime(CLOCK_MONOTONIC, &time_end);
>> +#else
>> +	clock_gettime(CLOCK_MONOTONIC_RAW, &time_end);
>> +#endif
>> +
>>   	prt("All operations completed A-OK!\n");
>>   
>> +	if (time_end.tv_nsec < time_start.tv_nsec) {
>> +		time_end.tv_nsec += 1000000000;
>> +		time_end.tv_sec -= 1;
>> +	}
>> +	time_diff.tv_sec = time_end.tv_sec - time_start.tv_sec;
>> +	time_diff.tv_nsec = time_end.tv_nsec - time_start.tv_nsec;
> LTP has functions for operations with timespec, here you should use
> tst_timespec_diff()
>
>> +	prt("Elapsed Test Time %lu.%09lu\n",
>> +        (unsigned long)time_diff.tv_sec, time_diff.tv_nsec);
>> +	
>>   	if (tf_buf)
>>   		free(tf_buf);
>>   
>> -- 
>> 2.34.1
>>
>>
>> -- 
>> Mailing list info: https://lists.linux.it/listinfo/ltp

The whole CLOCK_MONOTONIC_RAW problem is mostly related with test 
logging messages, which is something we will get rid in the fsx-linux 
rewrite.

Regards,
Andrea Cervesato


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
