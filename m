Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99DB4C00140
	for <ltp@archiver.kernel.org>; Tue,  2 Aug 2022 14:30:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 728F23C2FF1
	for <ltp@archiver.kernel.org>; Tue,  2 Aug 2022 16:30:54 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A1FB03C2FF1
 for <ltp@lists.linux.it>; Tue,  2 Aug 2022 16:30:43 +0200 (CEST)
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr30070.outbound.protection.outlook.com [40.107.3.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 25E886008E7
 for <ltp@lists.linux.it>; Tue,  2 Aug 2022 16:30:43 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mUBhqYo39wjKzNtia2rynfWCaLIIwOIJuGDmhQn3I0JCETJqw8qfUCkKps9nBwCvyGoIHJeeRQHWq5/FCBeuD36fe3EkpeoKNd3Y0gO1105dF3ZizLa6OZuL5d3beEF/SX2FyFIqURKKYuex6Xfvaho3wZs4QFh0yqT/1xDsVRfFQAUVzukKFi3uUK2cgXmawo9gGLP6BKqDvNGz41XnyUR7EcY3wWFnTdHMDTCgsZoYvTAwpFrBb089g48vlHJaWkC899hjHSLNIgzefAeCi8siE0dzHHNijsr2WH/5ERQ/z8lDKMX4U+fE2pM1gc9WOMl0v16ah9A3CyvoLRkxFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VR3IuQ+l7xYhb6hSig+w9wfbdXf22v3kHiKJG47jikM=;
 b=lV0NAy2AW9Qe/GOezHIkjJozyVhJYwN7YO6I22+h5C1zzjjsoUCwOwTe/wjUIPV0DnBg4IgfkVAzvHjMy48xaAGf21G3i/h0XNUorP4Zxqc9iEA4DFwl+mfZpyrt86Qiq/QOGMYm2uOgbuwI9aEmUex9RG+M4Q0iuz9Yv3wodo4to/XFrZM+hmPzzFaYsQJBZIesrgLcmJ853Dx2JXvi3gcTWLpDFXdTQnF3upr/9G3KNjC6pr/e1CUQVh4r+AIYUxMXhzUy+7U+QWGb0+Oz/8tBffMa49Z73a0p2Skvi/da8Y2MFHH6GviQIqNoSi3nP/qmp74qrzrOdu6jFA7dRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VR3IuQ+l7xYhb6hSig+w9wfbdXf22v3kHiKJG47jikM=;
 b=CUCS/nQ+t9EdJeusL2tFREfkz5n6G1EmfDgh1u7Q2YaD8LDo7G2dyppsy4Lbt+yIYGj2SlXmw2euMHvOn7MvOK30Y3iWCgKr+bh5FndevaZyeaPJ9osputhPxwqRb3ZzVnGG24RICj0klveP3XFdDDXCpzC2KKDtj4jzVlSCtbLmBw7SkfNlstR9W+JTDr0hWfwNM8GvoISutx9SkLzYV7PPhNrfeeT+dqmkt9+0SKVcTr98koJIZNcyz8fniQR8lDQ3+83b60IKBd7vmkXGx7A9jqCWE9xv9NtYZI5Akt9uh1E8qKXdJx6lTV34vW0UEj5z/EIFaoLiSofsPWOMfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by AM6PR04MB6357.eurprd04.prod.outlook.com (2603:10a6:20b:fa::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Tue, 2 Aug
 2022 14:30:41 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::c3:d917:fe7a:451b]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::c3:d917:fe7a:451b%5]) with mapi id 15.20.5482.016; Tue, 2 Aug 2022
 14:30:41 +0000
Message-ID: <ed588853-5772-5acf-9cc2-4e79e3805d6a@suse.com>
Date: Tue, 2 Aug 2022 16:30:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To: Cyril Hrubis <chrubis@suse.cz>
References: <20220801151408.15947-1-andrea.cervesato@suse.com>
 <Yukh3EQSm57ak0o+@yuki> <d0cf0e1f-8e0c-127c-b613-ac8b3bd99ad6@suse.com>
 <Yuk1BC/gsYb8tzBh@yuki>
In-Reply-To: <Yuk1BC/gsYb8tzBh@yuki>
X-ClientProxiedBy: FR3P281CA0107.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::17) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f14137af-70a2-4e2c-85d7-08da74939391
X-MS-TrafficTypeDiagnostic: AM6PR04MB6357:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /Ze9Hzj9X7WByqvIA4ZCLb28nqkekfl98KG15q8HoXZBDTpXB2/y0nOGj7gmfvPNkvUEflQMeYRPBW0cfaKHRXw1+RdKLSRi+lDHVr0XygePZkiIp27HhUE0LaSJDCbEIVFG4CRQbf3A5M2XTVv6cLWzvglBXl3vyC7GdQkuRpNDJw1IImd/5xc2ZXKcuYfj46ReevU9g98kNAMcerjheHb0qRf1gFsq5PCUxb3rBe0xHNGFXeoyD3o6qX7OszFuYrDJzZ1G+GfNx7cD24aY9cDjPZohaeL5MZgzhRmmD2KkIzNu2nBBheQ257ZiNa6KCBBhBBbF1IIE1GL9RTbPzC8M1KXyMSgp3xEDgJ0BWAME3uEvjc7zXRarCB4DxlLAtbi7ruce8bmnNIFsFYrIPE9DqW9czMzQoSnRtGIq1UgEgPkmBKLvvBiUy8CmXT4wlVFcT39lWvCwVi/GuYx9iQLohtRh6vf/zEhgPkJ7HBF6KX7vx6gVSAEpS/H/xI38u+ZFgMChcy+27UTkR4MSYjqi9xOJUHSuQz0+GYqXOZy+MO8wN62Vvjcbsn6LfiWPe1hcIaCaKst2V+VALuwQ1XjTKtPfqOgox2Y3aB1I6QA6aem8mhBWjrN4qAAG+VbryBkuJBe6+R6QZGEFKKeXRLTbRr2z9w5YWrWRZWlsuRH9s/dZC68EffVsAEAreaSZj+3KIwMU0T2MfW5MUERiMayzFgdlztY2ba+a5Bhd+e+MF90UVvpwVjRjScNjLbsA6tLblDOzYdmtf9oChlj+56SK4Vt0KA21N6H7XmXaQId6MfV5nsFEV8SsGexEp+HoK0cdJUzXV8onLH3Qnys24Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(136003)(366004)(346002)(39860400002)(396003)(376002)(4744005)(66946007)(66476007)(4326008)(66556008)(8676002)(44832011)(6486002)(8936002)(5660300002)(2616005)(478600001)(6512007)(26005)(186003)(31696002)(6666004)(86362001)(38100700002)(31686004)(316002)(6916009)(36756003)(6506007)(2906002)(53546011)(41300700001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmVETklIZFFTSERpSU5FSFROZnR4S0RTS0VTd0puR2xKOHlkMXJnck5ac09X?=
 =?utf-8?B?UW1qOURKNHlBL2puaHVuNWtUM3VUYldyYnE5bzM3YytoQkpJMXpkT09wd2pL?=
 =?utf-8?B?RmVVKzNWTS9ocTFGdWpocnc1d0NXd0E3WGkyRkQ2RjlGaWpYbE1NNUtXTXNq?=
 =?utf-8?B?QmFjeWdNY3AxYkltYSs4a3o2Um5pMCtMQ3ZIc3BuMHc0eW9idG1yNzJ4MFdr?=
 =?utf-8?B?eUo2UmVtY1ptSEhYbFY1VmJwL2ozWFhDa2liempPRUJRT1FxWnJLTlIwbU9q?=
 =?utf-8?B?L3piTUV3N2RnWTZ3UFQvdUs5QTUvRW5nNHVPdWtUZFpnVSs0TFQ2MnBaOElj?=
 =?utf-8?B?dFBkcll2Mk1DenQ1SU9NYVFqR2hJb0YraFNjY3UwUkhxK29CMDlPSklReUNM?=
 =?utf-8?B?TTZITW9lWWRSUUVlUnJ6Mk9Mc1lvZjR0MVQzOHExS0xucVYvVXpNQThtTW95?=
 =?utf-8?B?bkp0OXFQNkJReUk2TUxsM3lva3I5cHNhWHNXeDFQdnlzeHl6eTNKbTJaTC93?=
 =?utf-8?B?bDVreXAzZVd2NzdXYVJJK0s0VS8xOTZxakZNUVp2dXVQTlpoeVRCZjh2WHJr?=
 =?utf-8?B?aWdyTjBqU3cvK2NwL1h6QTl3WVNIMHAycXJYaks0TE5EOGVhNStwOGkwQ3cr?=
 =?utf-8?B?aUdGa3Q1YklvWlFkc00xVDVXUHJRUi95bWpiZS93dGRkTjVCTFlzbHJXZFNK?=
 =?utf-8?B?Wk5TYTJxRG94Q2oxVnR1Z2JXRmlzTmZCdFZ6UzBRK0NKTGorUjdvUTc1U0hy?=
 =?utf-8?B?Qk5yd1dVUXVYbHE3ZmNDSlg5T1NxQm9PbHlja3lmZ3lpajNybWhoQ0p1eVZU?=
 =?utf-8?B?bjFhbEZPZzNRRWdmS2IvR3NkWmxHRzlVTnVaNUtFa1AzNnp1dUdTSW01OERa?=
 =?utf-8?B?ZXRiSk5YN285VjNFOVVNalR4ZFJiU2R0SmhLVTRPMGVSRXVBT09xTzVSZEZr?=
 =?utf-8?B?T2VjenRGV0RlNnpkT1BqcWZNbzg3bC9zd1d4OVp1b0IrYkNjN3VUS3BOeElS?=
 =?utf-8?B?U05tMXVRWS9mN0ZOaFVEQ3lTdnJEeVBRZXh0cUxGbnJaSDVkNnBpcEliaHlX?=
 =?utf-8?B?VVRsNVREVGdMWnR3dFFmdTRhaU1NdFJLeFFCNlZmd2Juc0hXOTlSYVhBVlk2?=
 =?utf-8?B?ZC9uZklNRWxwbHhydjRnZjV4REllUVZsL24weFl4d2p4NGI1a2pLYTBVTjRD?=
 =?utf-8?B?ZjZuQVhUVUV0aXJSamorQ25rcVB0Y1BwcVZjQUN2bitOYnBVWkdmTXkzT0tn?=
 =?utf-8?B?NzlCcDltazR1MkN6dFhYb1hDK25scFRYbGQzZnJzRUdTQTAybFNhaFc3QTZw?=
 =?utf-8?B?R1l1NFlsdXIxYjdaSTZPMUdmWEhDeEhQdjlXYUZzTDZ0RDU2VGhvZWNoRTdQ?=
 =?utf-8?B?VjZTU1IycmtEdjhaYlZxUmNjS0U4S2tNUmtZdlJEdzJjakhtSkFZWTlZK2lt?=
 =?utf-8?B?MFdaR1JwUmJySm1haEtvU0pxMDNmVEhCOWxtMHgxV2s3ems2NnZuV2VhTVRN?=
 =?utf-8?B?c1FvZ2xBVk41b0dBQng4MjRLWEhqRjlpR2lhVmlTMzFreGsySWxVSE1pb3l3?=
 =?utf-8?B?TS82RFJrQ0o3NjlkK0dIYUZobzVVRkprd2FPVEhYekxxRkg3akFQQVlEVlRz?=
 =?utf-8?B?STlhQ0VYcUFSTkNNOXV4czhCWld2RExoRlZuTTZEZFRMUzNPRUw0OFh0RXdq?=
 =?utf-8?B?MmdmQTJLdkhUcTJOMHZ4dnV4M1AyYUF6VG5VZXRHUlViK1JtV01HMjQzSFM5?=
 =?utf-8?B?TjRiNDVQeitXVUp3L2xYVU1pTy96S0p2bWpRdHFUQjNJSDc5RW1DcmkrMlRV?=
 =?utf-8?B?ZG5ZMkhTTW1uOSt2bVk1Q2lWeVg3ZERCaC85cHVCMWREQTlYM2x2M0FoUlo5?=
 =?utf-8?B?WUJMWUxpc0hiU0p4S0dGQlVhb3FJUkUrRDBvVXdZNXplVFNTTmNhQ0xLdDJ0?=
 =?utf-8?B?Rmgvblk0WVVROStFMnBKWktWY1U4Y2xGSXJKbFJZZyswNDBobS9qOEFJNUhr?=
 =?utf-8?B?QXhFZy9yU09zMzRTbTE4OVpQSE5md0xHTEVJWHpvZmYwd0ZrV3ZSSjF5dlZF?=
 =?utf-8?B?NE5HbWpIUC81MGdZS1o5bjVxUkJabmdaSnlOQ2dIOFIrNGRRbFpMaTRvNnRF?=
 =?utf-8?B?UFlxQWxMcFU5dXI4MHA5bjZFdGF4aVFBYzFka3d1eDE1K1JGZS9BeFF3YWVh?=
 =?utf-8?B?dEE9PQ==?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f14137af-70a2-4e2c-85d7-08da74939391
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2022 14:30:41.2242 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v3WuA86cQ+5oJidxmXxDVd9dmef6NGi3hHhzB3ny0T6iF7Nofxim4WRdbwwAC6vtF03kEBMiTDTS9wJizSv52xzMKkfo9RSMCasdXKRdsBI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6357
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Refactor aiocp using new LTP API
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

On 8/2/22 16:30, Cyril Hrubis wrote:
> Hi!
>> I think that check doesn't make much sense and we probably should stuck
>> to "n = aionum - busy",
>> since that's the value we always need to allocate since became free in
>> the previous loop iteration.
> I guess MIN(aionum-busy, tocopy) or something like this since we want to
> avoid schedulling reads past the end of the file.
>
>>>> +	aio_blksize = 64 * 1024;
>>>> +	filesize = 1 * 1024 * 1024;
>>>> +	aionum = 16;
>>>> +	srcflags = O_RDONLY;
>>>> +	dstflags = O_WRONLY;
>>> Can we just initialize the globals directly instead of here in the test
>>> setup()?
>> In the last ltp-aiodio tests, we decided to initialize global variables
>> inside setup().
> Wasn't it exactly the other way around?
>
Sorry, you are right. Got confused.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
