Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A433EE57EF
	for <ltp@archiver.kernel.org>; Fri,  8 Sep 2023 10:26:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A7D023CC271
	for <ltp@archiver.kernel.org>; Fri,  8 Sep 2023 12:26:15 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C304A3CB504
 for <ltp@lists.linux.it>; Fri,  8 Sep 2023 12:26:03 +0200 (CEST)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04on0600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0d::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id BD2D51A05C8B
 for <ltp@lists.linux.it>; Fri,  8 Sep 2023 12:26:02 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gvl9hTQRmkPQr+cX62UfxflibkPA8bRY8wMmm3fFkxZWfDKCEoiw+lzW/MAE2j+Xiveho8PbElksPMaHhbHIzaph9l76O5DRyZGNpFPPUFzSGOA3rDiG+azzVn5nZiVg8Y8LXdWzEpiSIb/m41dRe6GaRMZo62DioEI6d1aSNcoOCzbK0xKtkkFmZ9ovTaDdaY9Ss2pY+ZgflOEyMFxbpf7HsEmJT1+f9nddYKWqMJEjyjHyiN0NCNtUNbjMxSboaILjGyrJ6SYjye6Ub93Ct+FLty27LC5UKiD4vJIe231qap6Vh8JwSl4bT5WsqgAkrpIwgC1UipgikO+Ihv+QZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V2/Q+YDzuCB40/LqWI6UFjUTzKzkCgyHThN92mVva0g=;
 b=HO2mdzqkclfW+CWsQPSVWUObftYxQHYJLMmLG9aBoElZ+sAA5yjLYef3NobkqXZGLTpNS5un/EtQrGAP7vgACModInwUbG6NvPizeZCo/lh9jztfo/EaUKSlxcIPv78EDITxCdK0nx7/GYc6F5XnvW5aqe+aCk4+PS9okp9y2xQwDH+wdcvqLtTRplXE6rf9Qr9UeAUynUDArarfWwnUZLcla2TCt+klcXOAzO//QYOpDM/0HvMnoAg4mNb3P4d8aIT7wvOu55XIvdgDX003Q1qrkOJYlb2T6peyGCnwYqerHilTC+NLxkWUfFmO6FUybVQvXKE0Izm+Sm4LzdBRsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V2/Q+YDzuCB40/LqWI6UFjUTzKzkCgyHThN92mVva0g=;
 b=RaHyPyzL/e8vuDRhd3R3tiKFo27e0AOINwkQOznQ6l/UqsP8iI+BlixMTB43FdtXuzE9DIIulqZPFYyx0ypd0eQnLBPlJPmq1YE7h6PHfO+nc0Yr0Ru1M5yhZTWASZgsR+/yRev4r/pmwc4H8wU1H20KjH5EfZD8P/fVQwhxAYGS9moF/nBl9UNAULnGkR6qgMrs/rpHWXnX7Pz0qoyynd4BuPUhx2Mdn4wwZEXw846I0bhC3peth/dL97/u3As9Jf+66ITEVfTzmmSmQmmbfUf1oNxyhE8XMW2C5wP6nUlr/yfzTuRXaFH4psz+Q50D2swjL7F/t1YlFB1RsyIBvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by DBBPR04MB7834.eurprd04.prod.outlook.com (2603:10a6:10:1ee::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Fri, 8 Sep
 2023 10:26:00 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::c33:be0b:88be:b96e]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::c33:be0b:88be:b96e%4]) with mapi id 15.20.6745.030; Fri, 8 Sep 2023
 10:26:00 +0000
Message-ID: <b4ea8307-aa90-4b12-b5b8-bfbd2a3eb3b8@suse.com>
Date: Fri, 8 Sep 2023 12:25:58 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: rpalethorpe@suse.de, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20230831104242.27156-1-andrea.cervesato@suse.de>
 <20230831104242.27156-3-andrea.cervesato@suse.de> <87zg1xgg2y.fsf@suse.de>
In-Reply-To: <87zg1xgg2y.fsf@suse.de>
X-ClientProxiedBy: FR2P281CA0163.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::6) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB6797:EE_|DBBPR04MB7834:EE_
X-MS-Office365-Filtering-Correlation-Id: 14a22659-b6b6-4a59-de89-08dbb055ff3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XvxmZsHfhj54anJDD1KTXCaXPFzyLFrmUpKHVfuvRnH6MMiQs81eNgty/wkr+ThhnG7W8ErQYMbv5iOMbhy6KGA90u3VKNofXwrGWkiOqHajFS8ulX2doSpjVcCspm1+eU80tzVc8qazKwED4AHgNlo8Dkv93BU9C63EwfOh6ghwkHBhC7o7LITAWp25tibr4qFDzIvyJTpRfPbo6aRbxvaWlc7N3+JvfYuge8LYnNy8qynyZrKKXjAeLggBZOuZFjqpJBiT48bz3noHqV/U4o0jvymW8uNV9Lb3KOxRRV8nigZeSp8IZOqu6X8tpKerzDcS+ZD92+1H5h7TvxZ7y45OFsl+d/5+LFzi+m77QGZOEFh1kq2Hd3Zvli58SjN6LvuAMOxwGFO8Ay7wjVNJzPDrf/fAenBL/goanigccXqKIJ38qalSqUstw9/XqhG0/8uO221gc0jvz+BrEGOfpdQcZo5mGt9TESH79YiMKhzKgj/jZn/DQ670WOzoLnFz4qiAKx8BNJVgaGDOilyjV3ATtS+grjpRGyU28shCt2SBun2LDTRTBywmG/bgV34UaNTKnYrd+NAp5gl0I8/yT06kiM0go+GSThzh1VeRjgsEae9WZMpJfiY+j8R+fPlhDABoVBGehOyMEsbpIpUI7Hfq62eHo9bFyOCIdk8iUbo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(376002)(346002)(396003)(366004)(186009)(1800799009)(451199024)(6486002)(6506007)(53546011)(6512007)(478600001)(83380400001)(26005)(2616005)(2906002)(6916009)(66556008)(66476007)(66946007)(316002)(44832011)(5660300002)(8676002)(41300700001)(4326008)(8936002)(36756003)(31696002)(86362001)(38100700002)(31686004)(2004002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eHdLbTNRNE9VNmJhVlBmMG9LMG1sZTVSQW9KR2ZMRCsxbDl0ZXNOaEo5MzZR?=
 =?utf-8?B?U085alVybEhWZXRqSGlQTnF1QU9Pb0V3bW9PbUU0VmI3SU5RYjdCVmVjbjc4?=
 =?utf-8?B?ZjVBeEdyelZLY1B3S0laV1J0QmE1UmdJVTNwTENsYWVVc3JhTk4ySEJhSk1p?=
 =?utf-8?B?RXpNZ3RFV3RVQVc4c2d1N3NRcm9zRjUvczhRNFlKRXB4azRNRlZWNi9yYyt5?=
 =?utf-8?B?R3ZCZitJUElCTlBSL0RCbG1rQ05QUWFKT0VkZ1dPUzNzR1krUUJOZWxIQkdu?=
 =?utf-8?B?UUVRT0k3Y053dUFRdzlNNlpMcGlPcGpUeHhtTFQ4ZGhhRi9hTWVoc3lzWlpx?=
 =?utf-8?B?cUF6RlF2dTMySSswMWVkZm1NbVNUTmxRaTJpbUV6YjdmV2dJRU9PaEowbG5O?=
 =?utf-8?B?a3pweVk1TWlMTjNXV09xU2Y3UUV5Z05jL0NxWU5WaklVbFV1L2QrVlJjNGJy?=
 =?utf-8?B?RTZMY0JpNHUwS2RId29wZ3VBZDh3bTczOHRKOXRNb0RCeGtNM01wVTBoZ0pN?=
 =?utf-8?B?T1NXMUxxWStsNjdtTzNIclM4MTNyaklqNlNoZVBhQTJFVzdEQWIzTEgya24v?=
 =?utf-8?B?aHQrK0RSZGsrMkZ6NGd3L2FtWW5pUlVFVjJPS1RzajRlRzBhRWswUDdUWWQ2?=
 =?utf-8?B?dmtHa1B1SUxJL0pxbFBRTTZZazR4eUJwOTduNjlpS1RaNVQvUThiTURvQ0xk?=
 =?utf-8?B?TjBoY0hnYnVKUFR5SFgxUDBoemdHVGlvdWpEMU1keEJMRVhieExiWlRpK1dX?=
 =?utf-8?B?TFRjOTRsRWRCWUdWVnptTDI4YmlaVFprSkI0WnFJdk04Z0o0VW1jbEJlSU9Z?=
 =?utf-8?B?TkpNemVLUUFFaHZtVUdnWklhSXlwanZHNFhBdVJEcm5kMGhSMHVjVGhnNXRI?=
 =?utf-8?B?dWlycWJGd1V5WHdaRU9nanRVZCtKT3N5M29KSHIrd3pUVklBMUVXQnc1M1ZW?=
 =?utf-8?B?ZXhoUzMzSjFXdmhXUm1RbUZXcVBaU3FaT2hidzRjTjU0SWpvaDhxdUo1cHho?=
 =?utf-8?B?WnZoNCtXMnI2cmRwVHA1VkRtbW5lRzhCNnJTd1pOS05EVTd6MUFYS2pMZmgz?=
 =?utf-8?B?RlZoTEJWZzgvZGFTMzFZekl0UlNHOUJ6M2pXdlloQlkwYUtrQkRKd2F6djcz?=
 =?utf-8?B?eTRCdGFteEtkRXIrbHRINlFxYTVvZVpUNGJTZEVRbmczVWpYSTRjNWwxdVUy?=
 =?utf-8?B?YUUyRDF6MXlPRHp6alVDUkRaT0RFazdnL0Ixd29RUmJRbm5nUUY0QTdpL3Fn?=
 =?utf-8?B?U2ZsQm1qTEJzUk1zbmJhSHdwR0tSSlFCamc1VkFnV0tBbmVVWUxsMndqOUJs?=
 =?utf-8?B?TUk2VWo2bUlhWEI1RlhteW02bWFDVUQvQWpqUG1FZkt1NVZRa3NhMVc3TTN0?=
 =?utf-8?B?U1hETzRIQWlFUVBIOW51MGZoRXlGSjEyYmtETUxPa3prbUQxTS9wOHNYSk8z?=
 =?utf-8?B?WlVWT045dEl6UG05dVBXc0RPTFl5SU9oODErVitUdVV2cGxIVWhqM2JURXAz?=
 =?utf-8?B?aHdwTkdrUVYwY1k3UlRPWHFWWVhFeFI4RFBFL1VNSkhIaGU0ODJNSmd6VlBw?=
 =?utf-8?B?VTA5Y0U2TU54WTNsZW5Yb2RrcCtlNDdKb2VJTk84ZDVteVo5SENjd25oK2Rz?=
 =?utf-8?B?d3pjVnJEeUxydklNN2FpNElMblk0Uk8xSk9kSnk1cDJORm5WZDhkWUl3MEtQ?=
 =?utf-8?B?disxdElNRXdKN1Q2SFZkVTM4b3BjTmppOVo3SWJOQkZHdnVmOFNKbi9HSFBB?=
 =?utf-8?B?TWtjMWZtTW15cDZwcmFGc1VPSmpIc1FKMzE2YlZMenppNkRCV0xYbUphNmlH?=
 =?utf-8?B?NUUySGpZZFZ6OUpOVGtKenRQOWRXOERKTjVRazFhL01aT0NXeUhYSXE3YzVR?=
 =?utf-8?B?dUVMa1hOdk9nNVFtV1hTS25tVGJGZ21MQ3NaeFpZQkNUcUF6SlBEWkZuVVZp?=
 =?utf-8?B?alJnam5WSjdoNURNMm5XM0p6dGdkb29lWm1qSTlVWTNRR3A5WmtDSXQ0bnV0?=
 =?utf-8?B?a3ByWWw5N1V5Q3YwNVNqK01HNmEyUmV5bUhRVTR5QzQxc2VXR2Q1ZGhzRlBQ?=
 =?utf-8?B?em1IWnVRMkx4dzMzUUtxaDZMRWlBdC9oZmF4WUpRQk5MakFTVW9vdldZbU9o?=
 =?utf-8?B?RlkrNTZGQ0w3ZXordGQ2U1VHYWt6VEMvSVNjSlMraUlBaFZWaXVHSHdqcCto?=
 =?utf-8?B?TEE9PQ==?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14a22659-b6b6-4a59-de89-08dbb055ff3b
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 10:26:00.5112 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mw1Pt6zxZFLXOssnCFdzw/VLZGZWN3HwxzRhVPztjT5pcfXUdiFHzX7TMjsEIyIqbZTHRAD3u1dykNAIjT8zHeHtZTjASfmWMaH1aPEPTJg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7834
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 2/2] Refactor getegid02 using new LTP API
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

I think you can push both getegid01 and getegid02 together, as Cyril 
mentioned in the getegid01 review.
Sorry, it was indeed better to create a patch set for this.

Thanks!
Andrea Cervesato

On 9/8/23 11:37, Richard Palethorpe wrote:
> Hello,
>
> Looks good, I guess you will make changes to the first one and resend?
>
> Reviewed-by: Richard Palethorpe <rpalethorpe@suse.com>
>
> Andrea Cervesato <andrea.cervesato@suse.de> writes:
>
>> From: Andrea Cervesato <andrea.cervesato@suse.com>
>>
>> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
>> ---
>>   testcases/kernel/syscalls/getegid/getegid02.c | 93 +++++--------------
>>   1 file changed, 21 insertions(+), 72 deletions(-)
>>
>> diff --git a/testcases/kernel/syscalls/getegid/getegid02.c b/testcases/kernel/syscalls/getegid/getegid02.c
>> index 60f09501e..2f64bd869 100644
>> --- a/testcases/kernel/syscalls/getegid/getegid02.c
>> +++ b/testcases/kernel/syscalls/getegid/getegid02.c
>> @@ -1,90 +1,39 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>>   /*
>> - * Copyright (c) International Business Machines  Corp., 2001
>> - *  Ported by Wayne Boyer
>> - *
>> - * This program is free software;  you can redistribute it and/or modify
>> - * it under the terms of the GNU General Public License as published by
>> - * the Free Software Foundation; either version 2 of the License, or
>> - * (at your option) any later version.
>> - *
>> - * This program is distributed in the hope that it will be useful,
>> - * but WITHOUT ANY WARRANTY;  without even the implied warranty of
>> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
>> - * the GNU General Public License for more details.
>> - *
>> - * You should have received a copy of the GNU General Public License
>> - * along with this program;  if not, write to the Free Software
>> - * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
>> + * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
>> + *   William Roske, Dave Fenner
>> + * Copyright (C) 2023 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
>>    */
>>   
>> -/*
>> - * Testcase to check the basic functionality of getegid().
>> +/*\
>> + * [Description]
>>    *
>> - * For functionality test the return value from getegid() is compared to passwd
>> - * entry.
>> + * This test checks if getegid() returns the same effective group given by
>> + * passwd entry via getpwuid().
>>    */
>>   
>>   #include <pwd.h>
>> -#include <errno.h>
>> -
>> -#include "test.h"
>> -#include "compat_16.h"
>>   
>> -static void cleanup(void);
>> -static void setup(void);
>> +#include "tst_test.h"
>> +#include "compat_tst_16.h"
>>   
>> -TCID_DEFINE(getegid02);
>> -int TST_TOTAL = 1;
>> -
>> -int main(int ac, char **av)
>> +static void run(void)
>>   {
>> -	int lc;
>>   	uid_t euid;
>> +	gid_t egid;
>>   	struct passwd *pwent;
>>   
>> -	tst_parse_opts(ac, av, NULL, NULL);
>> -
>> -	setup();
>> -
>> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
>> -		tst_count = 0;
>> -
>> -		TEST(GETEGID(cleanup));
>> +	UID16_CHECK((euid = geteuid()), "geteuid");
>>   
>> -		if (TEST_RETURN < 0) {
>> -			tst_brkm(TBROK, cleanup, "This should never happen");
>> -		}
>> +	pwent = getpwuid(euid);
>> +	if (!pwent)
>> +		tst_brk(TBROK | TERRNO, "getpwuid() error");
>>   
>> -		euid = geteuid();
>> -		pwent = getpwuid(euid);
>> +	GID16_CHECK((egid = getegid()), "getegid");
>>   
>> -		if (pwent == NULL)
>> -			tst_brkm(TBROK, cleanup, "geteuid() returned "
>> -				 "unexpected value %d", euid);
>> -
>> -		GID16_CHECK(pwent->pw_gid, getegid, cleanup);
>> -
>> -		if (pwent->pw_gid != TEST_RETURN) {
>> -			tst_resm(TFAIL, "getegid() return value"
>> -				 " %ld unexpected - expected %d",
>> -				 TEST_RETURN, pwent->pw_gid);
>> -		} else {
>> -			tst_resm(TPASS,
>> -				 "effective group id %ld "
>> -				 "is correct", TEST_RETURN);
>> -		}
>> -	}
>> -
>> -	cleanup();
>> -	tst_exit();
>> -}
>> -
>> -static void setup(void)
>> -{
>> -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
>> -	TEST_PAUSE;
>> +	TST_EXP_EQ_LI(pwent->pw_gid, egid);
>>   }
>>   
>> -static void cleanup(void)
>> -{
>> -}
>> +static struct tst_test test = {
>> +	.test_all = run,
>> +};
>> -- 
>> 2.35.3
>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
