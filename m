Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA386C47089
	for <ltp@archiver.kernel.org>; Mon,  5 Dec 2022 08:25:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DCCD23CC1F6
	for <ltp@archiver.kernel.org>; Mon,  5 Dec 2022 09:25:39 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0CAE43CC1E0
 for <ltp@lists.linux.it>; Mon,  5 Dec 2022 09:25:25 +0100 (CET)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04on0628.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0d::628])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1BB3514D933E
 for <ltp@lists.linux.it>; Mon,  5 Dec 2022 09:25:24 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BCh8jViJujoSVdUnH/UN/bfqNkG7eQG16hL3mEFIjXrFQ+KLMZp11qMWTFKYW7sHjRx2n+LSYp6+ih6exF0wfj2u/v4Tb2pWhfTe7ZN40zmpVJ011cwzANyTn42IFooCrJU7NOGIfLWjx/VgNXeYmiGRdbz6+SiF8hoePp9v62OmB2W9p4d/5XQ4wGAXG+jh4PvQjCCRwRGJnxLRDjiYgfAQMjQYayOS87r9x8T77M1pmn3NFlFtZ/WN4hgMIm9qDeNzbk4PIlY2B2s7LoFwq3szIhAnWMoBbGfWnoOE4ZP3btqhr/vRc5ukOgl3xp++UezvyFEmf2bcFN5CXFZyXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ma/reYOZBUkEpf+Zb6bLaGO42ZVrseDquudz4G14Dns=;
 b=fWWxd9IK2QgFG9FfL2Bj32+FiRVEWj71s/npY7DB/ylkpPYdAPvETLwL8ZLI0I6ukA+7diRqEkderWuTA/4+I8QyLYjBBNCBCzzMMMM1pNvuw4KBSPByQoJgmhnnaSvRtgDr5tTL476PATyRCxllF48zSQlxq3hdZt18mBxVCAlJYfXzp5WkEq2Z/YtMCU5dsuL3KORgMEsXSVSebPEadLFH5lHIU1jpzd5ofxy5fD05hauZfQdLdjGY9K+BYb6gOVQk3D1QM1Al0GZ5jM7f4MEJsVNvGBflu4Qn3eoSsrcDkrHGTXa6n+uXEO2yIMoZVOFGXceqSmBC8g38Kpb37A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ma/reYOZBUkEpf+Zb6bLaGO42ZVrseDquudz4G14Dns=;
 b=ux7YJ68Alyc9BcJBpHaZADfuF4dyaxruubSbdLnhtbAwt+WCVmkoeiVz9sThbWAmKkmyQ7+7/gzNZca3M2GGBWy3eN7azCFs9i2YsBfUDPkRfaNdayzr/TD0YYq5Nt65Emwfc578hKDTHrryu390A0zh3KNeAkrWgNi5LiiByjvmGoWB640gh/ttD++kNx8B3Bvb+OR25trENOOvpXlH/cprvb/W6x6hG5qbr5iUq2p/TMvu2GifJeTlEU/mlRMj9s2D8D9dHzkHhEFW7jL/7GoR9kQi4kxuclUF71BigrWlqvdZbzFEvmbI+zcYbW4zwkoK/BdqQoShPpC6hcYbtg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by PAXPR04MB9325.eurprd04.prod.outlook.com (2603:10a6:102:2b9::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.11; Mon, 5 Dec
 2022 08:25:22 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::2cd1:e5df:c85c:7e2]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::2cd1:e5df:c85c:7e2%7]) with mapi id 15.20.5880.014; Mon, 5 Dec 2022
 08:25:22 +0000
Message-ID: <32dc63af-0d95-31cc-4dcc-9b2d89d74edd@suse.com>
Date: Mon, 5 Dec 2022 09:23:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
To: Petr Vorel <pvorel@suse.cz>
References: <20221202103011.12206-1-andrea.cervesato@suse.com>
 <Y4oFOSgPd+2lxVWx@pevik>
Content-Language: en-US
In-Reply-To: <Y4oFOSgPd+2lxVWx@pevik>
X-ClientProxiedBy: ZR0P278CA0058.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:21::9) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB6797:EE_|PAXPR04MB9325:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a0ce161-30bf-463a-e630-08dad69a4060
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YAVsEQvY+XlcwzWrqdeRglhYTpgaOM+PCbYPj1CvFobWr3gfc9kFci6Do+Me8wlqe8UIu89R0DJHcy1rKOlA7hdeoiGAXlXquhsvrSBN2Mk3BSut50bk2N+dMO/CAolsugSLKHEuLXqci9JL8kizrx5a++3SaasOU2cBH0/gGsgSIqHp8RU6bi8JasPWwVVt3BMWEjhUhk4iKkcPP9m7/p4v6clsikIhzNrvgeju7PinLdCiXFs32X1+ck9REu0+TV+CZeBh3U3d3w/s0H4ylAhLTtVUD9fv9o+XJM7t2YxGneEuH0P9Yc/0/xPLzeWFojUKXWHrG30XYUTCU2bFl+kq6LqUC+gTHSYLhKfkAVuY1tbr+l/D+rrHlC/h4qssEsGhqsPHBDpQmJWfIv4uAjfUQ2uzQN4im2YmE6vJi0nNgrhLxxnIJDzwXaYNPSmTa/bBJ4VzaiwnKBXCixWuiqVENDCl1INzkDMGDbtME6DiV0x3WA6fx3bp5b0yG5qQXbOm33Zt7dMQNsVwgsYt7WQUqkmOxnaGOFrRrA7dYOGMxtj92hvWevqmTu0ZkKbE6ZelODPpr5AX+UKWdt6US7bar6cE8N57Cm2Q3uT7LXlR4nyvTFb+18xBwUMxx/0BLiOshXACOTiYbAht7J/7wSuN0cXbj2JSzPpewyM2culgYDpULh0tRwKn60b9wvGObQU9qrYk/6vorwGhaSZcjwvKJyd725JWeB/sieJUuYwvdX7dQ5PjEm96AZQ/yx6X1rd+Py/BXqI8a+9P9KMle28j9/5yHzdBLXJdIjyLX5A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(136003)(366004)(396003)(39860400002)(346002)(376002)(451199015)(66946007)(2906002)(4326008)(66556008)(66476007)(8676002)(316002)(8936002)(5660300002)(186003)(26005)(83380400001)(2616005)(6512007)(36756003)(41300700001)(6916009)(44832011)(38100700002)(53546011)(31696002)(31686004)(6506007)(6486002)(966005)(478600001)(6666004)(86362001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QkpTSE1xRjFkOWFuSEJTWFM0LzVuVGc0L0N5M1hVcVNXWHhOOFNuQnBjdzJG?=
 =?utf-8?B?dVlFOWNBcWNKVmRHcHgra3RKWld3QnNjcG1DdEFLRUJ6SDdrQlBWQjhoL3dn?=
 =?utf-8?B?alEreDRONFQ3Z3ZpREZyMTY3Q0YreGx4UHZNK0ROb2g2dUtjcjhNNE1rRnFs?=
 =?utf-8?B?L3UxUjllaUxtUW14L1JlM2xacWVNdkZzaDFWNDU5VDRoVk9wT0EyMzRTSmJN?=
 =?utf-8?B?SlpGRnRXdDBvV0k3bG00VkNNemJXK3A2REltY0ZjcDdzY2NyeCtNZWhYTEEx?=
 =?utf-8?B?YTZHbWFrNjlXaVRkdUpVSDVnR2RTYlJCSmNuWVlBVEJDZXZEWnd1M25YSEln?=
 =?utf-8?B?YktXalI3cmRoRkhnYlBYR1Q0K3R4MG1XcEdZTTd2WURtMkQyWHNhV2tpSXEr?=
 =?utf-8?B?b2QyMkZ5T3V0N1hTTE91c1JyUHFpRlNUbjV1N2R3cXRveVYvNzNwQ3g2b1ZD?=
 =?utf-8?B?Z09FU1NjZ3RKOWsrN3luUmJLeXpmajY2OWVQeFpoZmxNL2k2NC9kczJoa3pn?=
 =?utf-8?B?V3RJZW85RGxtMDg2enVqMU5xMExVQzMwT0VvcEVCY3JDUldlN29od1Fmanlq?=
 =?utf-8?B?ZEh6VFBCeXJRZjBVSlJEQmpkd1dJNkQ2SkExZy9tUDIyb0kxYTdEM0hsYS9h?=
 =?utf-8?B?NEF4dEhSUW1DcElXblVrb2VERk9GY0grQU9mUnNvRGJxRlhUNkx0V2trbk1W?=
 =?utf-8?B?Nm9BMHZIT0lhcFR4cTVCVCtlU3pIQ2Y4Um5MUkRyUGM5aUU5Zm9uNGNTNnMz?=
 =?utf-8?B?c1VKbXpheGx2RW5MRE8zb0N1NXpsd0IrUDE2WEZpZ1pHejcyWFlaVWVwSld5?=
 =?utf-8?B?d01HWkw2aUVXRXJQV3NCYWR6RDdhSUtEUGVTaTdUVCtLT1cyWU5scm12bFFP?=
 =?utf-8?B?SHJUcmdLSnR4aGVYei8xam1HdVFkMlFhZWh1V28rWmNwREc3VnFZaU12RWls?=
 =?utf-8?B?bWpyWjZZb29kMDJzNmxTcjl6MEJzL1IwZkF0N3J4UTNNZ01xTm1UVlk2NTVM?=
 =?utf-8?B?WmI5TXJGRElsZSs0UzhyU05wakNWNHY1RENvMGRTekl2Qkw1SVZBZldLd0Rl?=
 =?utf-8?B?VGhXbVlmbThWRU8vbVA3cGNydjkwSXVqeEJiSHhVRmFTZzZXbW5kSDdWYVY5?=
 =?utf-8?B?SFlkRU5uKzZzZkdQQVJWN3dNVHliMmIySkJUYzFVNVZEdU1MUE1oVGx2Qk9R?=
 =?utf-8?B?NnViN0RQVk1WTmxmM0EwODFUcXpLNkJBWnBzY1B5T1FEQktKNk5aNVpQMmtK?=
 =?utf-8?B?aFhjVnRvYWRidHltRFBpRGFoRjlnd3ZlSVQyM3ErS2xHeEFqVDJNbzBjM3Uw?=
 =?utf-8?B?YTBjS20vejJIVzhid0F5bGRoaWxKQ1NLWWsvZk9uN3FFRGUzOGd3MnlORjRt?=
 =?utf-8?B?LzF1VlRxeUtweHMwd3Y1TXJybTFvMmFscXpsbUgwMjNiMFJUWHV5Qy9oTTE2?=
 =?utf-8?B?NWdjZC9ZM3BDSkpBTXR4enNQMWJiQWtvMGQ0TGJyMUZia01ueVVFMmNhQ09C?=
 =?utf-8?B?VVlPZktFOWJDN0NuQjFab2ZoZjJUcU9QSTVjTlI0U2YrUitSdU9oaVJpK3V3?=
 =?utf-8?B?SE1hZVhndzIrK1JUVnlESG9GMHdhRFYyVENteGVwVWwvTlRIN2RKL3M5cDJ6?=
 =?utf-8?B?eXlsRURWUXNEMXhqUnpQVUxaYVpKVktJVUxlTE5FNWNwblgvRHNjNE1sRTFm?=
 =?utf-8?B?eWJoNzlDM2I4YXRrY0VYQjZSTkM1dG9JTElMTlFhS2NOTkVQZGI5U3lIblVZ?=
 =?utf-8?B?NTVlODIwdFBKUHZUdnpxbmg1bUw2WHJDWktmYi8xYThPdXJFdnE4cnBVRFFy?=
 =?utf-8?B?WkVTakdPU2FKSFRyNk5UbkF0OEl2QnVCcWF1aTNhaXhhdHhubGlBbXpZNklk?=
 =?utf-8?B?NjFVMWNON0VKWGRzUndkWGdMdytteVVtZTBZUHBPSm9vZWFXODB1UXNPNm9J?=
 =?utf-8?B?YXhJWFBMS3MvZHdKc2IwR0taeWhSQnZIOHhEUzI3bG9OVG84RmpIZEN5Zmgx?=
 =?utf-8?B?Qi9zYzRURUNla2NxcW1iaVZidkVoZ3p5MHVuMjNMR3lxekhSOTNzSzNCY05x?=
 =?utf-8?B?RUg2UW55Qm5FV2RDMUJJQnE5T1cwSnNZejhORnhZR2l4WE5lMmZZdVdhdjhI?=
 =?utf-8?B?dU9jQm1WMjFiOW8rM1FQQ0IzbTdLMStUaEcyQll3V3ZiNVZ3SEoyWklTTTBo?=
 =?utf-8?B?cUE9PQ==?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a0ce161-30bf-463a-e630-08dad69a4060
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2022 08:25:22.1621 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C4nbfakI4BBmvouHg1COqr8jr05bn7O6PfUOF5NitDzcYesYQhR6mYcAvKGv8GqaSRdkVSsJi0o/jSgQgXYy2/hcd65vMi2RDHCqLZ+lh+U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9325
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Add runltp-ng to upstream
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

Hi Petr,

On 12/2/22 15:01, Petr Vorel wrote:
> Hi Andrea,
>
>> runltp-ng is the next generation runner for Linux Testing Project and it
>> will replace the current obsolete runltp script in the next future.
>> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
>> ---
>>   .gitmodules     | 3 +++
>>   tools/runltp-ng | 1 +
>>   2 files changed, 4 insertions(+)
>>   create mode 160000 tools/runltp-ng
>> diff --git a/.gitmodules b/.gitmodules
>> index a3c34af4b..e85fc6279 100644
>> --- a/.gitmodules
>> +++ b/.gitmodules
>> @@ -4,3 +4,6 @@
>>   [submodule "tools/sparse/sparse-src"]
>>   	path = tools/sparse/sparse-src
>>   	url = git://git.kernel.org/pub/scm/devel/sparse/sparse.git
>> +[submodule "tools/runltp-ng"]
>> +	path = tools/runltp-ng
>> +	url = https://github.com/acerv/runltp-ng
>> diff --git a/tools/runltp-ng b/tools/runltp-ng
>> new file mode 160000
>> index 000000000..b08471158
>> --- /dev/null
>> +++ b/tools/runltp-ng
>> @@ -0,0 +1 @@
>> +Subproject commit b0847115891bd3dddbe920a716342917e7088379
> Thank you for this submission! Finally we get close to adding runltp-ng :).
>
> I've tested runltp-ng separately last few weeks, next week I'll do more testing
> of b0847115891bd3dddbe920a716342917e7088379. BTW there are 2 more commits in
> your master.
>
> The integration: What I can see now is that it requires to run "git submodule
> update --init" by user. Looking at tools/sparse/Makefile. sparse is specific
> (not needed unless make check is evoked), therefore sparse is not installed if
> not needed (make in tools/ does not init the submodule).
>
> Maybe we could add in tools/Makefile add:
> git submodule update --init runltp-ng/
> That would update only runltp-ng submodule.

Yes, submodules are not intuitive and it would be better to add code 
inside the LTP upstream.

> I suppose there is a reason to deliver the tool separately (without LTP),
> e.g. separate development or used on systems, which use LTP built into distro
> package (we already use it in SUSE this way). In that case I'd be for moving the
> repo to LTP github (https://github.com/linux-test-project/runltp-ng).
>
> We could also add it directly to LTP git repository (no submodule), because also
> for the above case (packaging) is a simple solution using just single
> repository: there could be two separated packages: ltp and runltp-ng.
>
> Otherwise to be part of LTP git repository
> add code directly to tools/runltp-ng/.
As far as I know, community wanted runltp-ng to be part of LTP, but at 
this stage it's probably too early (?).
> Kind regards,
> Petr

Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
