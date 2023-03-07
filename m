Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B984C678D5
	for <ltp@archiver.kernel.org>; Tue,  7 Mar 2023 15:06:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3C1543CDA1F
	for <ltp@archiver.kernel.org>; Tue,  7 Mar 2023 16:06:24 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CE5703C27D9
 for <ltp@lists.linux.it>; Tue,  7 Mar 2023 16:06:13 +0100 (CET)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on2060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe13::60e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id EDF23600972
 for <ltp@lists.linux.it>; Tue,  7 Mar 2023 16:06:12 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NNN4Q/6rHYapKvu7JT9CG0o4d2sDAJD11pXCLC8e/Fs1Fe15suYuSMCQnQ3qTAkbGYdoVGitFtCHmdQqlCfI1HlsBsIVBiNESsGJVFDrkAHtPoTzYmCVJ6qT8M3Zu8F+BZpiTZCem5WQI20BsAV96SSZP2llzM2bqD3I0afHeFsM1/KEoFaLZujmn7ACv1ljJ7pDeUrigesaqQqfXNTknILqVUZ2/pjCIapQd8vxe10Z0qpV8rdPB36g5vcm+8aPnVDUi9vO/8mE8rhxwFHMslN8zraAEunVsPhCuJ9T7C2AB4QAaj1oht/JdZLULZZ565+7PLd0hTlPrHE18VNnzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+0/OlJxxKnEkPULlUpVE11gvVF71T3s/ZCXfbNaPE2A=;
 b=JL38/71/t5SGQsv9XUfQUViqxwqMQAoXHDjK5xKKb9eJhhCmkm8wz+sUs33C7ZsDAL4qJA4lcObtmQVljVEOmhbhTPiH6sIySJ2hBVuc4soRFEb4AI6kdivfVMO/O0llWVeDk6RGgX9lSQ3oxQ8tTTfTMdvlQUT+ubvda4wxKu8cohnh9zKFgVYICGZSbOpDYz21ixWXUu640gII9sQG5Ck8v0CviVMQbiIFC/kQ4s6HbrGm6CtASqjEizAeCmNSTF2ICLpkCU+fmaok8zst7bf1THLaMFALtJRJmayuptc4mKL2vB88fW2QyJlx6Cwvz/H93JbeuQO7+hwqnbBV7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+0/OlJxxKnEkPULlUpVE11gvVF71T3s/ZCXfbNaPE2A=;
 b=ztMJ1p7SPxbX/mZNjs3UQ4vuZ+HIjHeKv6uHei0P082IHWLcfDE+8D1oMzKWiifYSAtpMjVU0REZNTqfmnhk5x8CzUWf5Pv5zYfPKyil2HLzjG3PvhJOWQAzUkRoHISggj9/9hD4Mslpb4qc0G1uD2AW2soZQ48arS4aCD8nQNxzettXkf4/B62XNEJ1vxeg8US2MIlzJv9bmjX2/qJ9dkOnP9awLVRuZ/Lje2mQ5uN3CIniD02ak9EWdoGjvFM1/4cIZg0CgZceVy3/nxGMjn5vfDd0dD9/5e0b09Sz/a2rtHV5M/mI01PEbX8uOeLBRYtHesSZIXyJ9PFl8OXxrQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by PR3PR04MB7227.eurprd04.prod.outlook.com (2603:10a6:102:82::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.25; Tue, 7 Mar
 2023 15:06:11 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::e6db:281a:b03d:39ca]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::e6db:281a:b03d:39ca%4]) with mapi id 15.20.6156.029; Tue, 7 Mar 2023
 15:06:11 +0000
Message-ID: <8b56ae42-fca7-0538-99b6-a641f89cd7fe@suse.com>
Date: Tue, 7 Mar 2023 16:04:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
References: <20230303160312.329575-1-pvorel@suse.cz>
 <20230307150440.GA2490@pevik>
In-Reply-To: <20230307150440.GA2490@pevik>
X-ClientProxiedBy: FR2P281CA0069.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::10) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB6797:EE_|PR3PR04MB7227:EE_
X-MS-Office365-Filtering-Correlation-Id: 537e6663-ba56-4af8-b611-08db1f1d7c98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7sy54AkvhMbQePhGJKaDQOrC2FEBNDbrFUnfEyzUZimW0aqqmG4U4wy0S41zlaT0H45zaTdYuVBNa61p0Z2f3eURHYc11amuFj5MH1oLoPdcyAzTU+Z8XHIpGXGszBxAhiNScetQ4q84bsAIpbZdJYt4fLEkDRyEM1BKVdp5Dujmr2DlnEQDD744zzcqkTuE1UMNFgqh8M0tVJ02fqWyw+SyB/ztVft7/P19nsc2o863GI9wTwahhUPFPlHdisgjjMY+rzu4MK5dYoJyPab2WYYnbUhfS95ZltXjLHj0HlZwCj1T1IpyfgO/Y/ce6+ZPVO4aHalGFTQ5h2/fV9D9i6plHzqU0HqorJG648tGQZQHXbJ+QMd9KeZKo1Y7petvcWMxkZLqPN/elqSyWlS2LwgMSmmylTSXJlRlSoGEZv0BSJ6sC1chmIR3vaNz8/1Td2HOWZ9oJoMs4ZNL+NUWiBBAyl6OciSfzQKDmQUcrY/AUitsomnxZro1uTo0I7TxR6JVfNwxeTs1Mjo4XEXFBXgDm9QdWD/BtJejnwPeUjPaeyBGvkGNYB9ukh4OVhKxQz2NvECDH/W/ba3zMEKx9ufGlSFpKNnDgAl1+GrzglwrdpRKWYN+Y7SsgZCdpVekXDk8wPBskQ7/4gUwVqTuGmkygQQaT6v9RCUzdj4a7JVTYlBxZt4X0a2TnKgt5yT6PY2sWYTefSDrC8n8qU6Lv/a8T0SBVKpfrIKOKJ2ejlc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(346002)(376002)(136003)(396003)(366004)(39860400002)(451199018)(66476007)(66946007)(4326008)(8676002)(66556008)(31696002)(316002)(86362001)(186003)(38100700002)(26005)(36756003)(558084003)(6666004)(6486002)(6506007)(53546011)(478600001)(6512007)(2616005)(8936002)(44832011)(2906002)(5660300002)(31686004)(41300700001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UGlRNW1odUp3RjBpMkhpV2U3Q3hGRTA5ZjZwQ3RiUDNiMmpzMVN3V0FsUzRW?=
 =?utf-8?B?dHZoOEJGb01TSXFHL09oODB1T21vU3dPb01md24rR0xBeVFvM1BTRHV6SkFw?=
 =?utf-8?B?dGlEUlVVR1dkQVdkMzBvN2Y2Q0J2WUNIU3d2OUYxa0I5Nm01Vy9xTGw2MFJ0?=
 =?utf-8?B?cWl0alM5a1Z1Q3FLMnFiOUFnVXE0T3dRSWJld1pWWHEwRktWdlkxWmRZK05s?=
 =?utf-8?B?d2YwZVlaMHY5NGpCWFFSN3RxZ3JLb0VRKys4N1JVWlFrSXM2Q1dEQ3RsNy9x?=
 =?utf-8?B?T1lCSC9YMlFWTDcvRkRxS1JXc1ozM2htdXR1QXJFNk9FVlRIVXBJYnNzNStG?=
 =?utf-8?B?ODZkRktnMUhrQjMwV1ZCUk5XZVRidTAycEhlVGRqcGhjSkJucW8vek5BMUox?=
 =?utf-8?B?OS9oRkxHSjdWVUFVVkpCUDk2UFRld25mTEdOUEpXR2tTY0NKZm45NXRQTnAr?=
 =?utf-8?B?aWJFKzlGSXh2UTM3TTF4UG9xMitBSlgxS25ZVTVhOUZaMDY1V3R2UzIxWHVU?=
 =?utf-8?B?Z1Y1dnd6TjNCTVVma2c2aXpxYW1KaGlQNHIxQitPcm1pQ01Ga2ZoYXV2MFRv?=
 =?utf-8?B?cG9GRThsZEx2ZWlCbmQvQWxhK0ZhOElvNFhobjRlbHI2RFlqcHFYQ0l0Q1FS?=
 =?utf-8?B?RkE3RjVhalFEbTZSK3prVVRaNkhEZHZMeVhmN3pTMzd5MUorUXRtS1hqSWtG?=
 =?utf-8?B?bFp0UFFFTWFmekJKWUVzTm53WEFDTGQzK0ZIUWpXblM0QTJDN3RiMnZIY1BB?=
 =?utf-8?B?NjBBcEd5QWRBZVkyR09uVnlGNnR4V1NGVnNCbmhpSmFTTXVyUWliY0RkRFhO?=
 =?utf-8?B?ZUxVSmsxUkFxQnFFVHNvNVFqY0xtWFpiR2J0NGUxajMzOU9MK2RKOVgyNnh6?=
 =?utf-8?B?M3YwTU9WWnd4OEdPY2ZpSVN1TXMwMXhpZ09kN09Ba2JleWVWQUJjc3NaSE1o?=
 =?utf-8?B?MEFCTWdSVGZEQms1WUxXZnZheC9XWThzOW5uMDlzTFlENjRWTlNNdCtGZnNN?=
 =?utf-8?B?azlKS0kvMFdBbXRtRXE5dDNIYmJ6KzYwazhRQUg2c3B4YUZ5MXQ2blBiWXFC?=
 =?utf-8?B?TFkvTXdLek1pSDZPWW9EbnJyZXRuZXhEajJUV2VUMzIzZjJRQ0JET1EwZ2xz?=
 =?utf-8?B?VWp0MGJyaUkvcGo2UVFvcjZDemsyckEzL2dPK05rMDRVUjB0a0V4b2xRMGdL?=
 =?utf-8?B?akpERmk2ZDcxcTNtc2JGWi8yRmJQbzJoS1VzRkp1MGIrZ21FUStZUDNaR29E?=
 =?utf-8?B?ZHpnb1dYVE45RkdoUXU0OWtNNFZHaUFtR2FIb0tnWGFJZWdUY3ZsQXJsdnVw?=
 =?utf-8?B?Z1BkTGZMU1BsQnpoZmNTMisxN2hzeUxLdlZEdG5ITTI4NXh5K0FoL0szUmYz?=
 =?utf-8?B?djdLaGd3Uzg2YjJDWFRqQitIYVBnL0ZZWjRocjlLSmVicHpueE5acU0vWkFh?=
 =?utf-8?B?UDJpSThqaGJESkJ6MFdTOUg2T0dLZytWS3hxWnQydHhnaFpNNytMblJUQjBP?=
 =?utf-8?B?d25vTVRrTE5jNTF6R3NyMm1wVmxYUU1xcnpkdTFjNDFKOGQ2ajR5M041NDFu?=
 =?utf-8?B?bXNiMDJUZ2EvUmFWeTJLVFVNcGZsc0QzSXJpelViUlRWU01VYkFQZmVFYXJU?=
 =?utf-8?B?Z01TTXhkditJQzFnTXB2aUlyWk1aWmJhYUhya3I1YVZwVjY4U2FRMlVBT1lW?=
 =?utf-8?B?UlRFL01pWENHeHBIeW96SGRQWXUrQ0JLMWFhd3JrOHVFVjlLc1F3U2c1NFhC?=
 =?utf-8?B?RGpnNS93cTJoZmc4dkxqY2tZVFNWN0dEcWhTUU9Fcnk2eVVmVEY5R0dHODd5?=
 =?utf-8?B?a1ZWckhpN0s0bWVaOWZvaXZSTFd5UXZZMFl2VjQ3TDYwckRJclI3VGJycWwv?=
 =?utf-8?B?ZUJqeXBJNWZta0FEOUhaRUFQRWp5NitpL2ZySi9NeFp5V25tMUJOdlVqTlRy?=
 =?utf-8?B?Qm52RzBId0xSc1RjamcyeHc4OU05aS9HWW9jcVRYQkNCM2lOUXdpWWRBeHBD?=
 =?utf-8?B?NUlqUkVDZ2hFbUVjeGx0ZkhwQ3h5NFZoUHpUVEdaRWc0YmVaWjk0V1FjemRZ?=
 =?utf-8?B?dExDb2NsMWFjdUZwT29IbUtFMnJyaHZEQ3ErQS9pbHdjL0JhSmJQbE00ODJr?=
 =?utf-8?B?NE96Snp5bDlTWkF5b0NQa24vTW9CVWlBSnJ2bmVRMDBKUzJrRlcrenFWM0p2?=
 =?utf-8?B?ckE9PQ==?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 537e6663-ba56-4af8-b611-08db1f1d7c98
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2023 15:06:10.9671 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AXMMlzr3lTSzYN746xZI89YeKy1nZ9deFSO1PzgdmLyaDoo89KNQZZaLFPL8FhmOH6F/tNDKfEw0UOktUSOHBcBGy7lJjFv7kjw9QnVYNSI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7227
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] ns_exec: Move to testcases/lib/
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

Hi Petr,

On 3/7/23 16:04, Petr Vorel wrote:
> Hi,
>
> wrong patch - both ns_create.c and ns_exec.c use ns_common.h
> => ns_create.c needs to be rewritten first.
You can find the ns_create patch in the list
> Kind regards,
> Petr

Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
