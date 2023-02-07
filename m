Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BA34C636CD
	for <ltp@archiver.kernel.org>; Tue,  7 Feb 2023 10:27:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6B9383CC235
	for <ltp@archiver.kernel.org>; Tue,  7 Feb 2023 11:27:04 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 273563CB14E
 for <ltp@lists.linux.it>; Tue,  7 Feb 2023 11:26:52 +0100 (CET)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04on0628.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0e::628])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 75A1E1400C48
 for <ltp@lists.linux.it>; Tue,  7 Feb 2023 11:26:51 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eei2B5DsjIBKEkffsww+41I/wlPKJvrh3m0IeTJBWXEpvYgJRboa+jif3Diml6TU9iK5+dR79L2ArEgUR+zgkb+WGs75gH/KkNuB0FtPGWJ5AhoYBjKtMNw2mh4LmRxpPvj50oVHD/TIUY8qbn2X4CdMPf3ZwC7QYSaJdjPvEYN/geEht+D4K9CZptW2qUFcZ21UYEK3CJ+v7oxBGg4XqkhsWiBmHAJd9XBZOhYF8bic3O1644zaLG/6cMuKTOMmTkZ9B71ZWGnNCji83ZHHM+rLyVfLEZwJOkIGPqQCI0DJLnmbNAcxbkXTG/QhZktkNyNh9cRNyJFj2Bato7dqcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6xp+LyWqlsgWik8SBHzM+eDfgMJlreminTH6xRYDZCU=;
 b=Wba/XuCz5lcyJuF8SUwbBDTxPb//H5sOBFIXnT96e6IcQYtQZpPUJW9cOZyIok05dPwdY1V7TpcumdMOiyeroGQHekGalsRDUmyC27zl488aGxkHl/oV0NGB1SDhAAdTwDSff3XsiwsQUiq/d2WNgCtQScyCklnOD3LZOAW6Bgzmm5Cqbnho+dUBcFuUFTxRfY6BDrnXoQ2kcWIsog+4hJCi7L8RFhRhtzTkX6iPfhjPHBxRDIQkD6aM2N8LO50InGWNuMkSYSzieSUnm/b1gM4n+2NTdXNa5UxwipTLa50DNV1MIYjPA6QjAYT+Q7FWryiAHOsrN3ZIzEwOKLkqyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6xp+LyWqlsgWik8SBHzM+eDfgMJlreminTH6xRYDZCU=;
 b=CF04SkZah3N+lELD4JyfkHAdzUY2NFyVvCskQcgIVFcIByGsfUIe1A0LUHU+Z7I0bC2TAHSo/fYeyfOCeJmQt0eEH4NzEILuIpTvnVHnH3LrQ+xmkDNKZDGuMSlQy92fi7PHxKbUyHrOMi8qFJ/psfPADmreYvy9sR1GiYuiVEd+zPG10OWel5g2jMWI+hgF7QClITUTdpHe4h1KDvmu+hDODMX6a54/MfL8vURLbIyoGp1B4Yx/iRFCpRtlPmhKwHwjOobM/WLiXhAJft+kdW1Y52YQwlY/7GuCDZbrQBB81DUAdbl2iD6irJhLAvwhrwahtUDvBP6DiGNw9Jd8LA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by PAXPR04MB9489.eurprd04.prod.outlook.com (2603:10a6:102:2c1::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27; Tue, 7 Feb
 2023 10:26:50 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::a9f4:e4e9:9b9b:2dc6]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::a9f4:e4e9:9b9b:2dc6%6]) with mapi id 15.20.6064.036; Tue, 7 Feb 2023
 10:26:49 +0000
Message-ID: <f0c71f61-a0e2-ac62-b338-2a06c4d951be@suse.com>
Date: Tue, 7 Feb 2023 11:24:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
To: rpalethorpe@suse.de
References: <20220805091315.26835-1-andrea.cervesato@suse.com>
 <874jwa8ywj.fsf@suse.de>
Content-Language: en-US
In-Reply-To: <874jwa8ywj.fsf@suse.de>
X-ClientProxiedBy: FR3P281CA0139.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::13) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB6797:EE_|PAXPR04MB9489:EE_
X-MS-Office365-Filtering-Correlation-Id: 17a706ff-7241-4c47-5c7c-08db08f5d28e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bVR76xCWhO14lip2i74d8EmUXvG3IIwPWSHOSQxzEGClaHtWjoonMEzJEQrpb0frK0IY6RBMmRPNbfQqbx7Y9XiM+amA9MhvlQ9peRiY4hpn4/97lncklaDbZBWMSdXyF3KVOpjRist7NUazFQ1aZJQZLa68EnKP1idebpkOJ/JeK5KTiwpEoNwq8corBgoIzZgy3VJJZP8B9pHu5h8gbsnXMDBEJQKB4+85SIwlk2VfC6zWOxmrMXn0P68/uWS20lI6i0iuHUsJgbKUJPLxsEO9/Ah/IexK7R2ZW+vdVvu8Wwedp1u3NOAMX+OAA6oVXXCmVqxwyGWyW1hO81SmMFFo5mAQ9S5umHxEPX8mlaNP5Bp3cyGK4XGlhatiQ8fAL93lMn8ZlxPmqXJCWnvk2dRohLj00bRGD3HWVsOLvy/XZo9NSWXUHckRrJdz741uBOuulSBQoaIOGuXHeCfes7Zv0HqYbM/rVxNEC3pPCjdFQioH3of8qSGxE9zxH+eUcntryfc/OBcHPfKMCOJIZbmQZXwMNV1r+RDTw10dSnEk4FmXY7EhuXydjpuLZNExcJY493DLptEErTOmhs0wzP6b7s+51cQyenottZNu6eJF+AQj26gbiBgWSIohCjktfdwvtonWRQcdZJS51qy9JiFg1tgyKlwjCICVn2KlBVDGUYot4E9iklH1PwtfSJyBy7xOoikFYyXu+t7HxQ7aCMm9GUBssh3iF5oLObJ/Zw0f+kRyl0FCvHsjTe56R129lUupx7Ifgrh8oDBvd9saPA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(346002)(366004)(376002)(39860400002)(136003)(396003)(451199018)(44832011)(26005)(41300700001)(186003)(6506007)(31686004)(36756003)(53546011)(2616005)(38100700002)(6512007)(30864003)(66476007)(8936002)(2906002)(316002)(66556008)(83380400001)(66946007)(86362001)(5660300002)(8676002)(6916009)(4326008)(31696002)(6486002)(478600001)(2004002)(21314003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHk2RWIxTVZSaTQ5cm1peVVSSGwxR1dMQkFxaGVOUGxMRXhSd25EZDFVb01x?=
 =?utf-8?B?RlJyTXRrUE9kMWZpOHkvSWZ6dThXdHBBNVBHQktlaE1OT3c0WFB1OWFjUUhK?=
 =?utf-8?B?MzBpWEJmRWVWcE5xeUU0ZHp2QlZSczZlWnJzanlibTJnbDlHQ3g4aUhyZm9H?=
 =?utf-8?B?aGlMdytlM2tOMjNFdmV6RHk3eXFIN0VwUmViT0RPdnZjeXd2QTZkS2R6ZWQr?=
 =?utf-8?B?VDlqeDB3TURDN0tOL1Y5L0hJUFB2TDlvVkNkZ1ZIVUhhOWRkNjZUWlpaYUdi?=
 =?utf-8?B?V3NXWisyOWZSVVpCaGNFcUVWTlRyaDVZb3dTWTdUTk5qS3JNMkZLYzl2VEtq?=
 =?utf-8?B?LzNTL2lSV3U3ci9HZGJLQktUTllQOFNhckNVWHh1N2tYRUNkRHVXWkRDYkNR?=
 =?utf-8?B?Vko5NW4rYkxJYjVSbTE0ZGhtNC9MVFVVcXV6ZkFHeGdlZHpGKzlpR0hCODhi?=
 =?utf-8?B?TmhQeTZJYURpMWZjdVJLWnVZL0t0allOTkQxM0xkMEdVYnpGc3hpaDBXVFpI?=
 =?utf-8?B?NXVZSFR4a1lYdHBSVWR2TGhUaHlZeWdGZFV4TnJJSkZyZDVxTkRWMEtyd2ZF?=
 =?utf-8?B?TVo4b1RtRTdwWHViZVFTTStFU3FmYVFJSHk1M1Zlc0Z4SHUwcjZMZHRMVEFy?=
 =?utf-8?B?UFoxTGJYQmxxcGF3TTc4eEhKU09USGQ4VW5TMmVPYVJ1dkZvem8vZTZWS2I0?=
 =?utf-8?B?VXZwa0pRRmQwMDV4UEo3SlhHYVhVbktuc2ZuUjZwd0xZaHJ2eDdicjF2ZDhu?=
 =?utf-8?B?M3BnWWRsODNMaktSc2VYMjQwZnA2Uy9YV09GRTMrODZOZ3hGc2V4WUpqQk1j?=
 =?utf-8?B?R25uQUduRC9ZamtuUm13TVZpN3F2cTBwTm5LQ3BiME9jMkFBOGtFeTZwd0hF?=
 =?utf-8?B?Q3N5SHJRdHlzNmxoTTFGL2pqN0xudVpVMUNpU0YvYXZZcWxVeWhYdTFqNWRu?=
 =?utf-8?B?b3NoN3hoanpablVOako1RmlYazBvV3dnaG5nakN2N0MrdisvbFg5eDhQdk5m?=
 =?utf-8?B?WHpidjlicnlpLzJQeGZIRWlVVDVjRUlXL2hDdTYyT1dpU2p2MUREUlIrekw5?=
 =?utf-8?B?NzJqdlAzaG9QVFlUeldJZ2ZBK3VlQmtZanYvRlI3ZGRzM2crQjIwaEZLMC9N?=
 =?utf-8?B?WHk5bU1VUUQwZm5mM2NEUmIyN1VvT0g0U2taNGNRWjZSczFIcmU1ZUxzeWdE?=
 =?utf-8?B?REx0NUhLNGV6di9LOHRPMWpKZ2NxYXpJVG5WUFlBcjlKUnYrdmY1RnZrZlhB?=
 =?utf-8?B?RGFkMExYc05zYXlGdiswSGtEQWZDdE02NlM1cHc2Umd3QnJ4dEg4akh4dExQ?=
 =?utf-8?B?NVdkVkMxNlRKSDh6Q0xva2NZMHF1ZXZkK1JUVW9vSUZLa05KS0VRRDl4dWRQ?=
 =?utf-8?B?WFlpditiK3VQWEI2akhHQlZnM2MvblhwUkR5bkhneksrcDdTbktjQm5UNlRt?=
 =?utf-8?B?dlBHWXZYLzZGV0NvYVV6SGRCUlRYeTE2U1VvczRRWDJhbVoxcTVBOG55NWJ0?=
 =?utf-8?B?WHJmZzNZY2o3YmV6bVR1MFk1R3Z1ZWd4aHhuZ0xQK2JYTnNDMW5OY0FZQVR3?=
 =?utf-8?B?UkEvY1FoTENzb3FZQ0o0MjIvQkt2SFZrbDFGREpiV0pnYjNZckd4b3lPVm5q?=
 =?utf-8?B?UFJ5ODRNeDdPNGFjbXdseXp2QW11cmRaWFlxZDJ2RE8zQklIV0tYdW42cFJr?=
 =?utf-8?B?NkIvOHdULzF6NnY0dC9YSmhHUWt0SzlPdC82aG1DZ1RQczhzckRrNUtlVEZK?=
 =?utf-8?B?a0UvZjgxcWxiZmVGenpTRndwb0EzTnNGT2l1RjNKUUNVeXJQL2NEVENoWHM1?=
 =?utf-8?B?K2tOREFLVWJtK0dBalBsMWRhaEs3eDlId0JzTW5heVpnNEk0VEE4U04wNEdq?=
 =?utf-8?B?MDIyNm5BWDdiaWhtUUxiSE5SZFg4M0srUjQ5cWd6aVpZVkhjZkE3ODcwbDRW?=
 =?utf-8?B?clhJRXlGT25RTFRkZDdrcTRZdmoxUmZkdnk0UkhhWit0YnhzSjdKd2FmNzFE?=
 =?utf-8?B?TkFaSUF4aVFpem1FRmxSSVp3U0tnUzVYZjdrd29pek9Ib204a2dpQVAzVllU?=
 =?utf-8?B?TXVGdzRGdXhPbE9PV2dSV3VVYlZnd3lCQW1BY2UvTkc0VUtTRy9uaDIvZkhO?=
 =?utf-8?B?aEVXK0kvTDFnL1hnQkNFajVOOEVGWTA2S0NoTHJFemRhUC9NS1psdGxZeVZ5?=
 =?utf-8?B?emc9PQ==?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17a706ff-7241-4c47-5c7c-08db08f5d28e
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2023 10:26:49.8267 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WxNqUlng40GJDWcwubymNLUSHbYu9aAKjAXcxSmOu2t2eV/8LP83jZb9ic7t+eQHrq5JGmUIhj8v8YYEpO1vpLW3jZj3wPXrOf49C7vAWtU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9489
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Refactor pidns05 test using new LTP API
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

Can we merge this patch anyway? ltp_clone should be added after with a 
single patch.

Andrea

On 10/11/22 11:56, Richard Palethorpe wrote:
> Hello,
>
> Andrea Cervesato via ltp <ltp@lists.linux.it> writes:
>
>> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
>> ---
>>   testcases/kernel/containers/pidns/pidns05.c | 288 ++++++--------------
>>   1 file changed, 78 insertions(+), 210 deletions(-)
>>
>> diff --git a/testcases/kernel/containers/pidns/pidns05.c b/testcases/kernel/containers/pidns/pidns05.c
>> index 79e146e36..1c588991b 100644
>> --- a/testcases/kernel/containers/pidns/pidns05.c
>> +++ b/testcases/kernel/containers/pidns/pidns05.c
>> @@ -1,256 +1,124 @@
>> +// SPDX-License-Identifier: GPL-2.0
>>   /*
>> -* Copyright (c) International Business Machines Corp., 2007
>> -* This program is free software; you can redistribute it and/or modify
>> -* it under the terms of the GNU General Public License as published by
>> -* the Free Software Foundation; either version 2 of the License, or
>> -* (at your option) any later version.
>> -* This program is distributed in the hope that it will be useful
>> -* but WITHOUT ANY WARRANTY; without even the implied warranty of
>> -* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See
>> -* the GNU General Public License for more details.
>> -* You should have received a copy of the GNU General Public License
>> -* along with this program; if not, write to the Free Software
>> -* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
>> -*
>> -***************************************************************************
>> -*
>> -* Assertion:
>> -*   a) Create a  container.
>> -*   b) Create many levels of child containers inside this container.
>> -*   c) Now do kill -9 init , outside of the container.
>> -*   d) This should kill all the child containers.
>> -*      (containers created at the level below)
>> -*
>> -* Description:
>> -* 1. Parent process clone a process with flag CLONE_NEWPID
>> -* 2. The container will recursively loop and creates 4 more containers.
>> -* 3. All the container init's  goes into sleep(), waiting to be terminated.
>> -* 4. The parent process will kill child[3] by passing SIGKILL
>> -* 5. Now parent process, verifies the child containers 4 & 5 are destroyed.
>> -* 6. If they are killed then
>> -*	Test passed
>> -*  else Test failed.
>> -*
>> -* Test Name: pidns05
>> -*
>> -* History:
>> -*
>> -* FLAG DATE		NAME				DESCRIPTION
>> -* 31/10/08  Veerendra C <vechandr@in.ibm.com>	Verifies killing of NestedCont's
>> -*
>> -*******************************************************************************/
>> -#define _GNU_SOURCE 1
>> + * Copyright (c) International Business Machines Corp., 2007
>> + *		08/10/08 Veerendra C <vechandr@in.ibm.com>
>> + * Copyright (C) 2022 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
>> + */
>> +
>> +/*\
>> + * [Description]
>> + *
>> + * Clone a process with CLONE_NEWPID flag and create many levels of child
>> + * containers. Then kill container init process from parent and check if all
>> + * containers have been killed.
>> + */
>> +
>>   #include <sys/wait.h>
>> -#include <assert.h>
>> -#include <stdio.h>
>> -#include <stdlib.h>
>> -#include <unistd.h>
>> -#include <string.h>
>> -#include <errno.h>
>> -#include "pidns_helper.h"
>> -#include "test.h"
>> -#include "safe_macros.h"
>> +#include "tst_test.h"
>> +#include "lapi/namespaces_constants.h"
>>   
>> -#define INIT_PID	1
>> -#define CINIT_PID	1
>> -#define PARENT_PID	0
>>   #define MAX_DEPTH	5
>>   
>> -char *TCID = "pidns05";
>> -int TST_TOTAL = 1;
>> -int fd[2];
>> +static pid_t pid_max;
>>   
>> -int max_pid(void)
>> +static int child_func(void *arg)
>>   {
>> -	FILE *fp;
>>   	int ret;
>> +	int *level;
>> +	pid_t cpid, ppid;
>> +
>> +	cpid = getpid();
>> +	ppid = getppid();
>>   
>> -	fp = fopen("/proc/sys/kernel/pid_max", "r");
>> -	if (fp != NULL) {
>> -		fscanf(fp, "%d", &ret);
>> -		fclose(fp);
>> -	} else {
>> -		tst_resm(TBROK, "Cannot open /proc/sys/kernel/pid_max");
>> -		ret = -1;
>> +	if (cpid != 1 || ppid != 0) {
>> +		tst_res(TFAIL, "Got unexpected result of cpid=%d ppid=%d", cpid, ppid);
>> +		return 1;
>>   	}
>> -	return ret;
>> +
>> +	level = (int *)arg;
>> +
>> +	if (*level >= MAX_DEPTH) {
>> +		TST_CHECKPOINT_WAKE(0);
>> +		return 0;
>> +	}
>> +
>> +	(*level)++;
>> +
>> +	ret = ltp_clone_quick(CLONE_NEWPID | SIGCHLD, child_func,
>> level);
> Again, ltp_clone should be converted to tst_clone.
>
>> +	if (ret < 0)
>> +		tst_brk(TBROK | TERRNO, "clone failed");
>> +
>> +	pause();
>> +
>> +	return 0;
>>   }
>>   
>> -/* find_cinit_pids() iteratively finds the pid's having same PGID as its parent.
>> - * Input parameter - Accepts pointer to pid_t : To copy the pid's matching.
>> - * Returns - the number of pids matched.
>> -*/
>> -int find_cinit_pids(pid_t * pids)
>> +static int find_cinit_pids(pid_t *pids)
>>   {
>> -	int next = 0, pid_max, i;
>> +	int i;
>> +	int next = 0;
>>   	pid_t parentpid, pgid, pgid2;
>>   
>> -	pid_max = max_pid();
>>   	parentpid = getpid();
>>   	pgid = getpgid(parentpid);
>>   
>> -	/* The loop breaks, when the loop counter reaches the parentpid value */
>> -	for (i = parentpid + 1; i != parentpid; i++) {
>> -		if (i > pid_max)
>> -			i = 2;
>> -
>> +	for (i = parentpid + 1; i < pid_max; i++) {
>>   		pgid2 = getpgid(i);
>> +
>>   		if (pgid2 == pgid) {
>>   			pids[next] = i;
>>   			next++;
>>   		}
>>   	}
>> +
>>   	return next;
>>   }
>>   
>> -/*
>> -* create_nested_container() Recursively create MAX_DEPTH nested containers
>> -*/
>> -int create_nested_container(void *vtest)
>> +static void setup(void)
>>   {
>> -	int exit_val;
>> -	int ret, count, *level;
>> -	pid_t cpid, ppid;
>> -	cpid = getpid();
>> -	ppid = getppid();
>> -	char mesg[] = "Nested Containers are created";
>> -
>> -	level = (int *)vtest;
>> -	count = *level;
>> -
>> -	/* Child process closes up read side of pipe */
>> -	close(fd[0]);
>> -
>> -	/* Comparing the values to make sure pidns is created correctly */
>> -	if (cpid != CINIT_PID || ppid != PARENT_PID) {
>> -		printf("Got unexpected cpid and/or ppid (cpid=%d ppid=%d)\n",
>> -		       cpid, ppid);
>> -		exit_val = 1;
>> -	}
>> -	if (count > 1) {
>> -		count--;
>> -		ret = do_clone_unshare_test(T_CLONE, CLONE_NEWPID,
>> -					    create_nested_container,
>> -					    (void *)&count);
>> -		if (ret == -1) {
>> -			printf("clone failed; errno = %d : %s\n",
>> -			       ret, strerror(ret));
>> -			exit_val = 1;
>> -		} else
>> -			exit_val = 0;
>> -	} else {
>> -		/* Sending mesg, 'Nested containers created' through the pipe */
>> -		write(fd[1], mesg, (strlen(mesg) + 1));
>> -		exit_val = 0;
>> -	}
>> -
>> -	close(fd[1]);
>> -	pause();
>> -
>> -	return exit_val;
>> +	SAFE_FILE_SCANF("/proc/sys/kernel/pid_max", "%d\n", &pid_max);
>>   }
>>   
>> -void kill_nested_containers()
>> +static void run(void)
>>   {
>> -	int orig_count, new_count, status = 0, i;
>> +	int ret, i;
>> +	int status;
>> +	int children;
>> +	int level = 0;
>>   	pid_t pids[MAX_DEPTH];
>>   	pid_t pids_new[MAX_DEPTH];
>>   
>> -	orig_count = find_cinit_pids(pids);
>> -	kill(pids[MAX_DEPTH - 3], SIGKILL);
>> -	sleep(1);
>> -
>> -	/* After killing child container, getting the New PID list */
>> -	new_count = find_cinit_pids(pids_new);
>> +	ret = ltp_clone_quick(CLONE_NEWPID | SIGCHLD, child_func, &level);
>> +	if (ret < 0)
>> +		tst_brk(TBROK | TERRNO, "clone failed");
>>   
>> -	/* Verifying that the child containers were destroyed when parent is killed */
>> -	if (orig_count - 2 != new_count)
>> -		status = -1;
>> +	TST_CHECKPOINT_WAIT(0);
>>   
>> -	for (i = 0; i < new_count; i++) {
>> -		if (pids[i] != pids_new[i])
>> -			status = -1;
>> -	}
>> +	find_cinit_pids(pids);
>>   
>> -	if (status == 0)
>> -		tst_resm(TPASS, "The number of containers killed are %d",
>> -			 orig_count - new_count);
>> -	else
>> -		tst_resm(TFAIL, "Failed to kill the sub-containers of "
>> -			 "the container %d", pids[MAX_DEPTH - 3]);
>> -
>> -	/* Loops through the containers created to exit from sleep() */
>> -	for (i = 0; i < MAX_DEPTH; i++) {
>> -		kill(pids[i], SIGKILL);
>> -		waitpid(pids[i], &status, 0);
>> -	}
>> -}
>> +	SAFE_KILL(pids[0], SIGKILL);
>>   
>> -static void setup(void)
>> -{
>> -	tst_require_root();
>> -	check_newpid();
>> -}
>> +	TST_RETRY_FUNC(waitpid(0, &status, WNOHANG), TST_RETVAL_NOTNULL);
>>   
>> -int main(void)
>> -{
>> -	int ret, nbytes, status;
>> -	char readbuffer[80];
>> -	pid_t pid, pgid;
>> -	int count = MAX_DEPTH;
>> +	children = find_cinit_pids(pids_new);
>>   
>> -	setup();
>> +	if (children > 0) {
>> +		tst_res(TFAIL, "%d children left after sending SIGKILL", children);
>>   
>> -	/*
>> -	 * XXX (garrcoop): why in the hell is this fork-wait written this way?
>> -	 * This doesn't add up with the pattern used for the rest of the tests,
>> -	 * so I'm pretty damn sure this test is written incorrectly.
>> -	 */
>> -	pid = fork();
>> -	if (pid == -1) {
>> -		tst_brkm(TBROK | TERRNO, NULL, "fork failed");
>> -	} else if (pid != 0) {
>> -		/*
>> -		 * NOTE: use waitpid so that we know we're waiting for the
>> -		 * _top-level_ child instead of a spawned subcontainer.
>> -		 *
>> -		 * XXX (garrcoop): Might want to mask SIGCHLD in the top-level
>> -		 * child too, or not *shrugs*.
>> -		 */
>> -		if (waitpid(pid, &status, 0) == -1) {
>> -			perror("wait failed");
>> +		for (i = 0; i < MAX_DEPTH; i++) {
>> +			kill(pids[i], SIGKILL);
>> +			waitpid(pids[i], &status, 0);
>>   		}
>> -		if (WIFEXITED(status))
>> -			exit(WEXITSTATUS(status));
>> -		else
>> -			exit(status);
>> -	}
>>   
>> -	/* To make all the containers share the same PGID as its parent */
>> -	setpgid(0, 0);
>> -
>> -	pid = getpid();
>> -	pgid = getpgid(pid);
>> -	SAFE_PIPE(NULL, fd);
>> -
>> -	TEST(do_clone_unshare_test(T_CLONE, CLONE_NEWPID,
>> -				   create_nested_container, (void *)&count));
>> -	if (TEST_RETURN == -1) {
>> -		tst_brkm(TFAIL | TTERRNO, NULL, "clone failed");
>> +		return;
>>   	}
>>   
>> -	close(fd[1]);
>> -	/* Waiting for the MAX_DEPTH number of containers to be created */
>> -	nbytes = read(fd[0], readbuffer, sizeof(readbuffer));
>> -	close(fd[0]);
>> -	if (nbytes > 0)
>> -		tst_resm(TINFO, " %d %s", MAX_DEPTH, readbuffer);
>> -	else
>> -		tst_brkm(TFAIL, NULL, "unable to create %d containers",
>> -			 MAX_DEPTH);
>> -
>> -	/* Kill the container created */
>> -	kill_nested_containers();
>> -
>> -	tst_exit();
>> +	tst_res(TPASS, "No children left after sending SIGKILL to the first child");
>>   }
>> +
>> +static struct tst_test test = {
>> +	.test_all = run,
>> +	.setup = setup,
>> +	.needs_root = 1,
>> +	.needs_checkpoints = 1,
>> +};
>> -- 
>> 2.35.3
>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
