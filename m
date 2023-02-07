Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1250FC636CD
	for <ltp@archiver.kernel.org>; Tue,  7 Feb 2023 11:49:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 674213CD0EC
	for <ltp@archiver.kernel.org>; Tue,  7 Feb 2023 12:49:07 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2D5E73C6A9F
 for <ltp@lists.linux.it>; Tue,  7 Feb 2023 12:48:56 +0100 (CET)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20602.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe16::602])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id DDEC76008EF
 for <ltp@lists.linux.it>; Tue,  7 Feb 2023 12:48:54 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oX10uOqJIqPzRaQez4fUzl6HQfvqSEDIR1Zf8GEGDQWVahBj8MuR87rJ5sc+uLoreBiKdZKPD52BoMSRE0gpbcNY5QXbS6fvNcnm2/K2B/csMgqCzbv4quSFRi1KwQZwEEQeqHxCyTpb2F2tN1Upe9vt4UczkdPe34yvJHg/scZXGINu4nldMmgh7AD/NhZxBS2Ogz482c0ZHgx6lDJHJyUzDR7s/OxjgB6dvRNWIKNsB/+0j+4CcGNJgv5Ig4iWCpe1VFhgWWW+tzJM6g3v2sqQwqPPwkm0qsj4zqVHpaz80q6If35Pb7lNJwy7spkykqMA9GK+4t9m1XERJfO08w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+odnf3g5aiibSjS7Q7wRFGRuPf9y8hHER6KngrT9yb0=;
 b=nobyaktMRHv5UrNSC11XJobiXTflkCS0bYI/fLFdlHg85ivYe6w3jNO4yTnTN8jFA2Yct8Z79mU36m5+b3lYFKx2LiWRIvVJ6LwmnlWFfkgPDXPEPvxrfBN5Q5Sy68C9VyuzIyC21QoPOwSQnGGx9XJqdl8AKjZRtipVrRsCNdRp6PfVqZihpuXHqW/3hJYTdJ70vJ40MX878LIEcDA4vXfTLHhDuRhJX9HnHrGO2vcbiBA2ggLH6tG5p+SsX7YfYOQ4UVhEPiumPqwgI6DGa79caYe10sirdduTmTACjlsgpZz3X6Xtff8P3hrQEDA6bECfX5hVtZMMtltU45F6rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+odnf3g5aiibSjS7Q7wRFGRuPf9y8hHER6KngrT9yb0=;
 b=v61Pf6XS66dQG9cW0ieyAPaoaFoCu1yqGATkSrV108GkK0kPD0HVUVUO9c8v0682HV0RFbOVrV7oDG0FQ6bOsh/YpPKm23ip3tqKmKA4gUaSH0r9Tjz7yg5Z5Z4jWKcSdZ/CTqSMSqS3G/U1nZvYgaxGEbmdCUd5fkM/HPbiuEveHBclJxP24FNANY+KOpYEJynoDQg+EHBQ6myiEUFKzjV6OqrPcWS3gyjTcOT5em8Rj8v5KgLNxq8yD3Tj7Ouk1y1QbSJai+rslzbVWXMFwerdnduhG/YFFu+8jwySGBp5OxtinZlHd/FqkCDbQ8zCvS+RyIa1/c/Kd9q5i+grfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by AS8PR04MB8705.eurprd04.prod.outlook.com (2603:10a6:20b:428::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Tue, 7 Feb
 2023 11:48:51 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::a9f4:e4e9:9b9b:2dc6]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::a9f4:e4e9:9b9b:2dc6%6]) with mapi id 15.20.6064.036; Tue, 7 Feb 2023
 11:48:51 +0000
Message-ID: <ff9f7650-de66-1e42-d97e-7b02417cfe4a@suse.com>
Date: Tue, 7 Feb 2023 12:46:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-US
To: rpalethorpe@suse.de
References: <20220805091315.26835-1-andrea.cervesato@suse.com>
 <874jwa8ywj.fsf@suse.de> <f0c71f61-a0e2-ac62-b338-2a06c4d951be@suse.com>
 <87ilgdivdf.fsf@suse.de>
In-Reply-To: <87ilgdivdf.fsf@suse.de>
X-ClientProxiedBy: FR2P281CA0032.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::19) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB6797:EE_|AS8PR04MB8705:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e1b1d35-7cbc-4c15-cf19-08db0901481b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GXXwvrL5qOv+80veKQBj2042TCpX2qD/QPs/rxNhqvqy5IKtHdDV/imfC+DeBwPLwvO/vp6b2HNKQzU+4UpBcSmYSlz2yC59m2Avtpk1ksUDvZUA0URZtVpErn7UBRQ2UyNDsZp14O87p2dPoswdowmBna/noAmix5gLqlmOt0HCcCV3+jDIOhFvJlixyTKzJxp4MFd2yU+/JzOL3XJcvEtIayDeBtif9o/FUDhgCVRAb7m7YfHaWzRjNobZLWK6+vOMHgC0K5Yt0zfkwvZde9O/4F/lmfJVWsDn60Gy1yxtfbNpHqNi2zv3zD/FM1xdpSq45J5zV0DB2xL9Z7dxx2epBiSfukM1Gwul6UUAx31GUouLhUvf81BQ6LQ9PthfI6dsvs1vrI+81nHh9NJnxVf3kJ5+Intqv9EhZYplyIul2O3pCv6f5R00Sv01+c9WwqqkDrkG2S10LhBI5RxOl7WFAtL1mLXb8RKeYGOiokMGNbrrNEE50kqqZxB+/9e2kLEJBVFWi9pJMmpGgpR6FS+Uogs+s9bp6eCIFg9CHedAdqLBw1yX2JCiVowLJTCgEVviO2nsnr9i8PTFoXcPpqvR5zQYCo9owv8Wkx62f1sIbEs9rpQCelGG9a7Wnx/zhcLg+qsNwFiEFNTkXXt5tz1L3TrzMaYDlMTwuLIJdkO75IH2Hi24jJFWmDYHBeYMVRaE/hCz27AJ8aT++/qvjiNDrGiuemQHRkr32xas3a6zMl/3UHl6gfEjGvknhdH9k7WzXbQ5fNZENtk7Ix4bUw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(136003)(396003)(346002)(39860400002)(376002)(366004)(451199018)(36756003)(316002)(6512007)(31686004)(31696002)(86362001)(6506007)(186003)(26005)(66476007)(30864003)(41300700001)(66556008)(4326008)(8676002)(5660300002)(6916009)(2906002)(2616005)(44832011)(478600001)(53546011)(6486002)(38100700002)(66946007)(8936002)(83380400001)(21314003)(2004002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVFYQmdiaS9ic3lsWndic2hoQ2ZTd0cvQitMenpBcEdSTnY3bW1TZFoxTzB5?=
 =?utf-8?B?ZXdmcHN4elJxTytvSEJXdHAxaElaZkIvZmZLKzJPdzd3a3pHTzJwM1VqYmhL?=
 =?utf-8?B?N2FsSzVybzc3QitYZ3hNZEU5NUdEY1daazJEUFFNbUdUMUpXMW1vSGVEdGlY?=
 =?utf-8?B?OTFuYXJ3Wi9icXArY2xmaDRIdlN6ZmhRRTY2UzNFMjhHN2ttOGNHWmJUcTRx?=
 =?utf-8?B?OVZUZkZKT0ZEV0JWcVdHNDN0cG95REJWQW9JaXhQNGlCMFpma3dhby9NM2RE?=
 =?utf-8?B?azFpRCt6QlZmT2NneUVSU2h2YzB6K3RsSEc5TGRNK3VLdmVyZ3RnZkpoa2Iw?=
 =?utf-8?B?K0xEKzJJb09DTHRuSHppT2pEald0Z2x5enpqTW02R2E3Y1MxdFVNelc2SGZq?=
 =?utf-8?B?VzRVM3B1UHFDdVF2K0ZNRXROd040KzV5Q1R0SUdXcWxQUG1Cb0Q0eDlYTXlo?=
 =?utf-8?B?WVdiWTJnUXdmcU90YlpVN2RsUjh6Tm9mZG5wbWlsRVUwUXZRbUpkaVB3bGpO?=
 =?utf-8?B?b1lEU0x6KzBaMFVKNFBkQWV5N09qVm8xNitPQjRSTEN4UUlleTRIbE94NDhw?=
 =?utf-8?B?TmZEdHdVcDNCUjZ3R2g2dnhSRWpDMlloT05KWFBBWHVDU1NDejErQStDSjhX?=
 =?utf-8?B?RkU0dkM4aHI5S2s1TjVpKzN0NTd1amtobnd1emVrbUpDZDRsWWh5WGJyVlY3?=
 =?utf-8?B?N3JJYlBLT3pyeXo4dFFJZFIybUtZbDlwSWdhL1NxQTQzc00wME9XMWZ4YXBJ?=
 =?utf-8?B?UVM3UzFrV3FiZzcwZElxelpDMyt5YmJiNHp2S0UyWkRQZEhCOFpGc0V3aTFr?=
 =?utf-8?B?SVN2YVlITkJtWCs0aEd5ZTRCV2xaNWNNQndZNTlaY05lNHZVcDFDVzJMSy82?=
 =?utf-8?B?Uk1EbnlDRXRKaXd4aXRKOXRId294TUZPWDNCZjdFbFMyQmJ2T0sxTWRoRFJ4?=
 =?utf-8?B?Z21IOXFja2lmZ2ZXeXlvZkIvWXFjMEFIQ2VIcUpOOFRkT1RsUEtLVXpSeWRH?=
 =?utf-8?B?dnMybHZhNzFpVkRMUldXa2hKNEkvelovdk1xV2h1U0hjaEtPOXBwTnh2aFZa?=
 =?utf-8?B?USs1SlBWQ1FjNENwcGVJQVQrSlRXbE5pS3cyQWZCRWFEZjhXbDhqaXBMQTdB?=
 =?utf-8?B?TWZseTYzdDZoWGFDN3hpUEVzUWVFSFRFN3VNaGF3QkZaajRsZEpXYXBJV2JC?=
 =?utf-8?B?SW5VdGRpd2RsTVY5akorK0VzdjRJQjVmaEdMeC93OUthcWNpNFpzL3Q4VzBN?=
 =?utf-8?B?SndMalRaTGl1M2EydTExbzNwWUxOS0xUdlRyWmo0anF3dU1sN0JYeXp0Wk84?=
 =?utf-8?B?QjRFQm5GVTY0SUVodVBlU0NnMDJiTEgrdSsvRU5jSVliNWRuazA4QnU0aFpH?=
 =?utf-8?B?NGtqeXdJdmpDWVRCY3Y5TWRUdlNwVG1VamxmcUV1ZmtOT3h2Tm9hYTBzSTJm?=
 =?utf-8?B?M3N3U1NoVGl2ZHo2WTEvTEdPNi9xaHN3NVJVbHl3NVRGVURwb1BJVVN4MUxn?=
 =?utf-8?B?MG02UnRJY0Z5dlBwUUtwWnZKYVRHdjVSeDllamFOZFQxZThEd2RjYWZXa1A1?=
 =?utf-8?B?QkM1T3pySTF3Y2FZcmhKSWxkc3RUUlhBYXFvUVZtWG5odWVEQUxMNWsyWXBB?=
 =?utf-8?B?NS9aYUVQLzQ2WVNEbDFDSER0ckI1c09WQ3E5R0FXTEZKUlhwc1JQY20vZlRT?=
 =?utf-8?B?a1lQY1I5VlZzSWJzLzF2eldwSU9PZCtNT2JIbDJiMUMwYnh6NlVDckJJZjlO?=
 =?utf-8?B?VC9TMVQ2QjFKajQ5NXJSZ3l0emxxQ0VZOHFiZWFjcnVrRXNMV2NKZ3BPTkx6?=
 =?utf-8?B?ay9Fd1FJWW0rK3k1UDJyNkhBcTBOUHF6TG1vL2J0RmVTbkFXTlNyYzA1M0JO?=
 =?utf-8?B?aVI1TkRES2pyTnFLWmVxc2ZBNW1BSUtsMVZWc2Nka0oxa3JFYnBVMTdVOXB5?=
 =?utf-8?B?M0FSMjM5aExVWUduUnkvQlowbGJhZ2wraEVHNU54Zkp1ZG5VaUhVdUhEbEg0?=
 =?utf-8?B?czFoSzhmY0hHd1cwSndJZWh6TFN0RjZrV3hlWkF6QUpUM0Y0V3ArdVpxQ05S?=
 =?utf-8?B?dWF1eWI1eGQ2R2xmM3hyeG5acmpwVmFQY2JhV2FkQTlUSnIvUzh5YURLRVJv?=
 =?utf-8?B?M3R3dWZNVGxrRFdJVVRNVkxuc1lZSE9vL3dtQ1V6RkY1M3EyQ0F3aDAzNDNO?=
 =?utf-8?B?TVE9PQ==?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e1b1d35-7cbc-4c15-cf19-08db0901481b
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2023 11:48:51.4487 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dqwp9tArS7X7dSmyuFNdhzz9YHGsNA9fnFV+DNTo0bCtQ2a8G2p7/szSMeD/A44tBlir7yHW5lEmCrOuOB9V+ZOMbnKjzcBuUZDaY9A0BCw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8705
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
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

Hi,

On 2/7/23 11:51, Richard Palethorpe wrote:
> Hello,
>
> Andrea Cervesato <andrea.cervesato@suse.com> writes:
>
>> Hi!
>>
>> Can we merge this patch anyway? ltp_clone should be added after with a
>> single patch.
> I started work on an update to tst_clone so that it can replace most
> intances of ltp_clone. However it appears that it can already replace
> most instances of ltp_clone_quick.
>
> AFAICT all you need to do is get rid of child_func and use tst_clone
> like fork.
>
> I don't remember if there is anything else in this patch that needs
> reviewing, so there is no guarantee that when I look at this again it
> will get merged.
>
> So I don't see any advantage to deferring the change to tst_clone.

I sent a v2, please take a look at that one. I can start using tst_clone 
for the next reviews if needed.

>> Andrea
>>
>> On 10/11/22 11:56, Richard Palethorpe wrote:
>>> Hello,
>>>
>>> Andrea Cervesato via ltp <ltp@lists.linux.it> writes:
>>>
>>>> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
>>>> ---
>>>>    testcases/kernel/containers/pidns/pidns05.c | 288 ++++++--------------
>>>>    1 file changed, 78 insertions(+), 210 deletions(-)
>>>>
>>>> diff --git a/testcases/kernel/containers/pidns/pidns05.c b/testcases/kernel/containers/pidns/pidns05.c
>>>> index 79e146e36..1c588991b 100644
>>>> --- a/testcases/kernel/containers/pidns/pidns05.c
>>>> +++ b/testcases/kernel/containers/pidns/pidns05.c
>>>> @@ -1,256 +1,124 @@
>>>> +// SPDX-License-Identifier: GPL-2.0
>>>>    /*
>>>> -* Copyright (c) International Business Machines Corp., 2007
>>>> -* This program is free software; you can redistribute it and/or modify
>>>> -* it under the terms of the GNU General Public License as published by
>>>> -* the Free Software Foundation; either version 2 of the License, or
>>>> -* (at your option) any later version.
>>>> -* This program is distributed in the hope that it will be useful
>>>> -* but WITHOUT ANY WARRANTY; without even the implied warranty of
>>>> -* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See
>>>> -* the GNU General Public License for more details.
>>>> -* You should have received a copy of the GNU General Public License
>>>> -* along with this program; if not, write to the Free Software
>>>> -* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
>>>> -*
>>>> -***************************************************************************
>>>> -*
>>>> -* Assertion:
>>>> -*   a) Create a  container.
>>>> -*   b) Create many levels of child containers inside this container.
>>>> -*   c) Now do kill -9 init , outside of the container.
>>>> -*   d) This should kill all the child containers.
>>>> -*      (containers created at the level below)
>>>> -*
>>>> -* Description:
>>>> -* 1. Parent process clone a process with flag CLONE_NEWPID
>>>> -* 2. The container will recursively loop and creates 4 more containers.
>>>> -* 3. All the container init's  goes into sleep(), waiting to be terminated.
>>>> -* 4. The parent process will kill child[3] by passing SIGKILL
>>>> -* 5. Now parent process, verifies the child containers 4 & 5 are destroyed.
>>>> -* 6. If they are killed then
>>>> -*	Test passed
>>>> -*  else Test failed.
>>>> -*
>>>> -* Test Name: pidns05
>>>> -*
>>>> -* History:
>>>> -*
>>>> -* FLAG DATE		NAME				DESCRIPTION
>>>> -* 31/10/08  Veerendra C <vechandr@in.ibm.com>	Verifies killing of NestedCont's
>>>> -*
>>>> -*******************************************************************************/
>>>> -#define _GNU_SOURCE 1
>>>> + * Copyright (c) International Business Machines Corp., 2007
>>>> + *		08/10/08 Veerendra C <vechandr@in.ibm.com>
>>>> + * Copyright (C) 2022 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
>>>> + */
>>>> +
>>>> +/*\
>>>> + * [Description]
>>>> + *
>>>> + * Clone a process with CLONE_NEWPID flag and create many levels of child
>>>> + * containers. Then kill container init process from parent and check if all
>>>> + * containers have been killed.
>>>> + */
>>>> +
>>>>    #include <sys/wait.h>
>>>> -#include <assert.h>
>>>> -#include <stdio.h>
>>>> -#include <stdlib.h>
>>>> -#include <unistd.h>
>>>> -#include <string.h>
>>>> -#include <errno.h>
>>>> -#include "pidns_helper.h"
>>>> -#include "test.h"
>>>> -#include "safe_macros.h"
>>>> +#include "tst_test.h"
>>>> +#include "lapi/namespaces_constants.h"
>>>>    -#define INIT_PID	1
>>>> -#define CINIT_PID	1
>>>> -#define PARENT_PID	0
>>>>    #define MAX_DEPTH	5
>>>>    -char *TCID = "pidns05";
>>>> -int TST_TOTAL = 1;
>>>> -int fd[2];
>>>> +static pid_t pid_max;
>>>>    -int max_pid(void)
>>>> +static int child_func(void *arg)
>>>>    {
>>>> -	FILE *fp;
>>>>    	int ret;
>>>> +	int *level;
>>>> +	pid_t cpid, ppid;
>>>> +
>>>> +	cpid = getpid();
>>>> +	ppid = getppid();
>>>>    -	fp = fopen("/proc/sys/kernel/pid_max", "r");
>>>> -	if (fp != NULL) {
>>>> -		fscanf(fp, "%d", &ret);
>>>> -		fclose(fp);
>>>> -	} else {
>>>> -		tst_resm(TBROK, "Cannot open /proc/sys/kernel/pid_max");
>>>> -		ret = -1;
>>>> +	if (cpid != 1 || ppid != 0) {
>>>> +		tst_res(TFAIL, "Got unexpected result of cpid=%d ppid=%d", cpid, ppid);
>>>> +		return 1;
>>>>    	}
>>>> -	return ret;
>>>> +
>>>> +	level = (int *)arg;
>>>> +
>>>> +	if (*level >= MAX_DEPTH) {
>>>> +		TST_CHECKPOINT_WAKE(0);
>>>> +		return 0;
>>>> +	}
>>>> +
>>>> +	(*level)++;
>>>> +
>>>> +	ret = ltp_clone_quick(CLONE_NEWPID | SIGCHLD, child_func,
>>>> level);
>>> Again, ltp_clone should be converted to tst_clone.
>>>
>>>> +	if (ret < 0)
>>>> +		tst_brk(TBROK | TERRNO, "clone failed");
>>>> +
>>>> +	pause();
>>>> +
>>>> +	return 0;
>>>>    }
>>>>    -/* find_cinit_pids() iteratively finds the pid's having same
>>>> PGID as its parent.
>>>> - * Input parameter - Accepts pointer to pid_t : To copy the pid's matching.
>>>> - * Returns - the number of pids matched.
>>>> -*/
>>>> -int find_cinit_pids(pid_t * pids)
>>>> +static int find_cinit_pids(pid_t *pids)
>>>>    {
>>>> -	int next = 0, pid_max, i;
>>>> +	int i;
>>>> +	int next = 0;
>>>>    	pid_t parentpid, pgid, pgid2;
>>>>    -	pid_max = max_pid();
>>>>    	parentpid = getpid();
>>>>    	pgid = getpgid(parentpid);
>>>>    -	/* The loop breaks, when the loop counter reaches the
>>>> parentpid value */
>>>> -	for (i = parentpid + 1; i != parentpid; i++) {
>>>> -		if (i > pid_max)
>>>> -			i = 2;
>>>> -
>>>> +	for (i = parentpid + 1; i < pid_max; i++) {
>>>>    		pgid2 = getpgid(i);
>>>> +
>>>>    		if (pgid2 == pgid) {
>>>>    			pids[next] = i;
>>>>    			next++;
>>>>    		}
>>>>    	}
>>>> +
>>>>    	return next;
>>>>    }
>>>>    -/*
>>>> -* create_nested_container() Recursively create MAX_DEPTH nested containers
>>>> -*/
>>>> -int create_nested_container(void *vtest)
>>>> +static void setup(void)
>>>>    {
>>>> -	int exit_val;
>>>> -	int ret, count, *level;
>>>> -	pid_t cpid, ppid;
>>>> -	cpid = getpid();
>>>> -	ppid = getppid();
>>>> -	char mesg[] = "Nested Containers are created";
>>>> -
>>>> -	level = (int *)vtest;
>>>> -	count = *level;
>>>> -
>>>> -	/* Child process closes up read side of pipe */
>>>> -	close(fd[0]);
>>>> -
>>>> -	/* Comparing the values to make sure pidns is created correctly */
>>>> -	if (cpid != CINIT_PID || ppid != PARENT_PID) {
>>>> -		printf("Got unexpected cpid and/or ppid (cpid=%d ppid=%d)\n",
>>>> -		       cpid, ppid);
>>>> -		exit_val = 1;
>>>> -	}
>>>> -	if (count > 1) {
>>>> -		count--;
>>>> -		ret = do_clone_unshare_test(T_CLONE, CLONE_NEWPID,
>>>> -					    create_nested_container,
>>>> -					    (void *)&count);
>>>> -		if (ret == -1) {
>>>> -			printf("clone failed; errno = %d : %s\n",
>>>> -			       ret, strerror(ret));
>>>> -			exit_val = 1;
>>>> -		} else
>>>> -			exit_val = 0;
>>>> -	} else {
>>>> -		/* Sending mesg, 'Nested containers created' through the pipe */
>>>> -		write(fd[1], mesg, (strlen(mesg) + 1));
>>>> -		exit_val = 0;
>>>> -	}
>>>> -
>>>> -	close(fd[1]);
>>>> -	pause();
>>>> -
>>>> -	return exit_val;
>>>> +	SAFE_FILE_SCANF("/proc/sys/kernel/pid_max", "%d\n", &pid_max);
>>>>    }
>>>>    -void kill_nested_containers()
>>>> +static void run(void)
>>>>    {
>>>> -	int orig_count, new_count, status = 0, i;
>>>> +	int ret, i;
>>>> +	int status;
>>>> +	int children;
>>>> +	int level = 0;
>>>>    	pid_t pids[MAX_DEPTH];
>>>>    	pid_t pids_new[MAX_DEPTH];
>>>>    -	orig_count = find_cinit_pids(pids);
>>>> -	kill(pids[MAX_DEPTH - 3], SIGKILL);
>>>> -	sleep(1);
>>>> -
>>>> -	/* After killing child container, getting the New PID list */
>>>> -	new_count = find_cinit_pids(pids_new);
>>>> +	ret = ltp_clone_quick(CLONE_NEWPID | SIGCHLD, child_func, &level);
>>>> +	if (ret < 0)
>>>> +		tst_brk(TBROK | TERRNO, "clone failed");
>>>>    -	/* Verifying that the child containers were destroyed when
>>>> parent is killed */
>>>> -	if (orig_count - 2 != new_count)
>>>> -		status = -1;
>>>> +	TST_CHECKPOINT_WAIT(0);
>>>>    -	for (i = 0; i < new_count; i++) {
>>>> -		if (pids[i] != pids_new[i])
>>>> -			status = -1;
>>>> -	}
>>>> +	find_cinit_pids(pids);
>>>>    -	if (status == 0)
>>>> -		tst_resm(TPASS, "The number of containers killed are %d",
>>>> -			 orig_count - new_count);
>>>> -	else
>>>> -		tst_resm(TFAIL, "Failed to kill the sub-containers of "
>>>> -			 "the container %d", pids[MAX_DEPTH - 3]);
>>>> -
>>>> -	/* Loops through the containers created to exit from sleep() */
>>>> -	for (i = 0; i < MAX_DEPTH; i++) {
>>>> -		kill(pids[i], SIGKILL);
>>>> -		waitpid(pids[i], &status, 0);
>>>> -	}
>>>> -}
>>>> +	SAFE_KILL(pids[0], SIGKILL);
>>>>    -static void setup(void)
>>>> -{
>>>> -	tst_require_root();
>>>> -	check_newpid();
>>>> -}
>>>> +	TST_RETRY_FUNC(waitpid(0, &status, WNOHANG), TST_RETVAL_NOTNULL);
>>>>    -int main(void)
>>>> -{
>>>> -	int ret, nbytes, status;
>>>> -	char readbuffer[80];
>>>> -	pid_t pid, pgid;
>>>> -	int count = MAX_DEPTH;
>>>> +	children = find_cinit_pids(pids_new);
>>>>    -	setup();
>>>> +	if (children > 0) {
>>>> +		tst_res(TFAIL, "%d children left after sending SIGKILL", children);
>>>>    -	/*
>>>> -	 * XXX (garrcoop): why in the hell is this fork-wait written this way?
>>>> -	 * This doesn't add up with the pattern used for the rest of the tests,
>>>> -	 * so I'm pretty damn sure this test is written incorrectly.
>>>> -	 */
>>>> -	pid = fork();
>>>> -	if (pid == -1) {
>>>> -		tst_brkm(TBROK | TERRNO, NULL, "fork failed");
>>>> -	} else if (pid != 0) {
>>>> -		/*
>>>> -		 * NOTE: use waitpid so that we know we're waiting for the
>>>> -		 * _top-level_ child instead of a spawned subcontainer.
>>>> -		 *
>>>> -		 * XXX (garrcoop): Might want to mask SIGCHLD in the top-level
>>>> -		 * child too, or not *shrugs*.
>>>> -		 */
>>>> -		if (waitpid(pid, &status, 0) == -1) {
>>>> -			perror("wait failed");
>>>> +		for (i = 0; i < MAX_DEPTH; i++) {
>>>> +			kill(pids[i], SIGKILL);
>>>> +			waitpid(pids[i], &status, 0);
>>>>    		}
>>>> -		if (WIFEXITED(status))
>>>> -			exit(WEXITSTATUS(status));
>>>> -		else
>>>> -			exit(status);
>>>> -	}
>>>>    -	/* To make all the containers share the same PGID as its
>>>> parent */
>>>> -	setpgid(0, 0);
>>>> -
>>>> -	pid = getpid();
>>>> -	pgid = getpgid(pid);
>>>> -	SAFE_PIPE(NULL, fd);
>>>> -
>>>> -	TEST(do_clone_unshare_test(T_CLONE, CLONE_NEWPID,
>>>> -				   create_nested_container, (void *)&count));
>>>> -	if (TEST_RETURN == -1) {
>>>> -		tst_brkm(TFAIL | TTERRNO, NULL, "clone failed");
>>>> +		return;
>>>>    	}
>>>>    -	close(fd[1]);
>>>> -	/* Waiting for the MAX_DEPTH number of containers to be created */
>>>> -	nbytes = read(fd[0], readbuffer, sizeof(readbuffer));
>>>> -	close(fd[0]);
>>>> -	if (nbytes > 0)
>>>> -		tst_resm(TINFO, " %d %s", MAX_DEPTH, readbuffer);
>>>> -	else
>>>> -		tst_brkm(TFAIL, NULL, "unable to create %d containers",
>>>> -			 MAX_DEPTH);
>>>> -
>>>> -	/* Kill the container created */
>>>> -	kill_nested_containers();
>>>> -
>>>> -	tst_exit();
>>>> +	tst_res(TPASS, "No children left after sending SIGKILL to the first child");
>>>>    }
>>>> +
>>>> +static struct tst_test test = {
>>>> +	.test_all = run,
>>>> +	.setup = setup,
>>>> +	.needs_root = 1,
>>>> +	.needs_checkpoints = 1,
>>>> +};
>>>> -- 2.35.3
>
Andrea Cervesato


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
