Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE77EC7EE22
	for <ltp@archiver.kernel.org>; Wed, 10 May 2023 09:58:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8AF223CD6CD
	for <ltp@archiver.kernel.org>; Wed, 10 May 2023 11:58:40 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9BB863C994F
 for <ltp@lists.linux.it>; Wed, 10 May 2023 11:58:29 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::61d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 7080D200772
 for <ltp@lists.linux.it>; Wed, 10 May 2023 11:58:28 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sswm3fSlUCagoMVRCk2bEXXZNZWOMJ8fGIFTET4bY0GHb2n/63zVR/nF1rGma9JZ4Pg63gMUcoOfPqkrfW7sbF/3vW90K3Gi9JS2FVyt4zDC7wWR9aR1wcJN8BLZDADb0OTg6a0dd6WBBJwb18qlrDw1edB9YR+TNLIq9sik3/SYgNKIhnzHtKMygZfbhPMZQY7fGpGr1VG4cuMF9zQ0J/wqpiBiCIDuDPkuojCadWMaoIPosDD0S/b5I5EmX18ZYwVZtjYTWgLmMaWI2aAvDJgD8yjz0r9jGYQlinMqZZZaNAa0TD+aW2SsQ9Ap11pFIkXxpvDtzUdSrXuL3IpIlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BFf8x97Q1muS1GK8yk6hlEo0h0p9KjTlmAcgVrThFFI=;
 b=ObUZdVwD9Cqn93w02k+FcrSTcTI3W2Nnu7IK1Nkz7LsOeZO0b0oJ/5/TeHtk6KezE7sDueybxCOhGMD1SdW1+Eoy298E3iPuyxWupymZlN2mbSE+ArDsoeiLQsQnPgB4GHfzSOqSLEcLlCgapPLsioD+UfflViyMAeIllRWg/tHeYYcz5BLRzzzMNQnWOrMcf2sjrkhiDvOwRhARcnrnW6OuuX2tNQmAFQ5En6mmVIqjjQPipAkXVubxChMRZ9B3lBK7uCRxxWwKQGogZ3WEzCEEw88y3BLfGi+mLWLDhGpJBINRnKLpfrQRWzzW5mQOVpS5FG0d/k109O14A8DfLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BFf8x97Q1muS1GK8yk6hlEo0h0p9KjTlmAcgVrThFFI=;
 b=U/RDesduxRW0usO+TxOu4FLTRRC9vVAIS1oTjJiVsf7A1/0pNZiqv2p3GJZ9oIbmxrONKP0siqkdTpQiiRfwnlB1UlITa1YDIsXVZCTAJA3zBg9EaFVoqtRDe33ZjuNJSIRtsR0AM7RfOn71lCXykp+QAohzEya8vHxJkmSqCcEweCsLv8jk/XLw3rlnIroxH+arket7PGyL4w8Sg9pjjfyFgf9As6KUCSr/HmuXXWzaiFUjj/H7WSCjPeV5e18tB9gi6UA1LFWiJGB6Q4b4F+kVx+WW8Ja2fCumjsL2SmLo503IXHq+tCi+AwNsdEL3V/BTN8pZbCRrGdjErTHRlg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by AM8PR04MB7251.eurprd04.prod.outlook.com (2603:10a6:20b:1d2::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Wed, 10 May
 2023 09:58:25 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::54ce:4ff6:8295:1c06]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::54ce:4ff6:8295:1c06%4]) with mapi id 15.20.6363.033; Wed, 10 May 2023
 09:58:25 +0000
Message-ID: <806cb14c-39a3-9914-2424-a5873d523962@suse.com>
Date: Wed, 10 May 2023 11:56:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20230307124708.27280-1-andrea.cervesato@suse.de>
 <20230307124708.27280-2-andrea.cervesato@suse.de>
 <20230323111718.GH405493@pevik>
In-Reply-To: <20230323111718.GH405493@pevik>
X-ClientProxiedBy: FR0P281CA0138.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::7) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB6797:EE_|AM8PR04MB7251:EE_
X-MS-Office365-Filtering-Correlation-Id: 196d2d19-1640-4cda-0672-08db513d18e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZtcMN+PNtQ8RaiggwipDSQN8Y2mFoy7NLBrzz0lhontK0wmQqem/uUspswZLasV39pOXOPwilEqhxzaHpG+l5X5AkygNpH6KeQXFKK9yx/CZZCaZWrtDM06p+5+2jotl9hxgtSmxzMc3x54cZWiKVcCYSD4o2FXRowNjUmvR0gT39Koe1jeNcAHSiql3MZ88rl4+PzjpZ2uWQlBpU64jH+/mBmwH1tzX3D5Q7fj1Wy3g9eKwQzKbYgtGKQAFWjL6q0iJSLUocT8MRMbZWNqrXP7XSX3BNTiKPSPJuHPHp8qadvEEOYF/fFG7PsO+COQIv4ZC170BfhtAma7GeGkrjvxR53sQtHiKSmrnKcl5BnkPpyZnm0zHqQb8TOyX65NLXql2TS7FQHpq1UuVNnPnYGnhMEJ1/V4+4V9bpwn8dP4sj0tqFBAPwCHam130DMKnMMqXxyPejrEm5aE9RL3k55fjiZeaYW+LGM8N3oOOtc2Fn/IybeEZ/Vr9jWhacNrYTLh+312RAGOQ/FzEPpl0iriMy4cmtJcH8tRWXEmb+srzVf3JKSD5pvbMtrhxx0gBmEiEye22BzjnWZA6txOqaT/ffKwHIH7JGFR6cE4XxHpJ8Er8FHBeD7u/wTJMQkSpvNgun83V4xlk835kNBOKdQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(346002)(366004)(136003)(396003)(39860400002)(376002)(451199021)(86362001)(31696002)(36756003)(6666004)(316002)(110136005)(66946007)(6486002)(4326008)(66476007)(66556008)(478600001)(44832011)(8676002)(41300700001)(8936002)(5660300002)(2906002)(38100700002)(186003)(6512007)(6506007)(53546011)(26005)(83380400001)(2616005)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWRwUlU4QzIwU0tPVFNhNE16dkRpL3pYVUF1Skl5dkdyL2VGa3dwZ0lzWTlm?=
 =?utf-8?B?R0VIOW9LdDFGMkMvUXpKYm9Kd0ZueHp0SVc1NWowL3VJOVFGTEllVEs3K283?=
 =?utf-8?B?YTNSSTNOS0N6Mmx4TFJYaldUbFhPbFRYSkdEUk1IU2UvVnF2cXBFVjhaNHlJ?=
 =?utf-8?B?eVhEVitaYXN5RXRvTk5ZY3dNTjUyMlZRYkZpbTRMYzNsR2hFRk5rbkNmSk5X?=
 =?utf-8?B?djdrU1UzZVFVd0tZdjA5MXdUUDQ3TktQY1NicWo2a1dKbDJERjNsTHU4WEFk?=
 =?utf-8?B?eUtqUGhQNWY3SCt4bHF0d3NHL0Rqbi91WW0wb2x4cUNSOXkwWXJvdk1CL08r?=
 =?utf-8?B?RlJPbjNpOFBqL1Vld2dzNVh6emU2WStkZG5vTFkzdEpIeUJUYmVYUDZaK3Nq?=
 =?utf-8?B?bzFVZjZtaDN6bjdIQmsyMEVmUzU4N1kyck1XOWJJV3RSRmZyWkxZM3krOHVT?=
 =?utf-8?B?UlZZei9RTDluVVpueXF6Rm1hL21OUEJOM3dxSlg0NlJwelF0STczWGg3bzFt?=
 =?utf-8?B?eGJJbW9oMHFETmNEUWc3VlBMTW5sb3daU1k1eEVDMlNDL0VybjJ6SDlEdWpV?=
 =?utf-8?B?V1hvQXIwbHhVMWluTDZHNG13YlB3SGQ2cWw5cmg2TVJQZHlhWTVYeEdxZE1w?=
 =?utf-8?B?K3R2Zm9jZE5zRjZmOTdpblNkY1VJcy92S3Z6VWtqQTF2OGFiYytIRlNBYkZw?=
 =?utf-8?B?RkVYOVpQQ1UxekQ5Vk0vak1vNlYxL25qbDRFemgwcVRZN2Zpb01LVlpWVGZD?=
 =?utf-8?B?R2pGaWNVYlVqNkMwYTJRUmNnRUxZRi9LaTZoZ1UxZmZOaCtOL1BEbXF1dGs5?=
 =?utf-8?B?N2diRXE1dTFZOEpObm5JTkpFaGZ0M0V0eFZ2SzYxeDBVdnpYLzBxSnQ3eGpW?=
 =?utf-8?B?b3QyN1RDZ0R3WjVnNEovUUNCN2FmcnVQSUw1NEdOaWNHUy8wSTJEa0R3d0lz?=
 =?utf-8?B?QWRJZzYzSzdORys1QnQ2OEdFMVJ3eWp0V1BFeFQyNEF2UjZNZlJWR20rOVB5?=
 =?utf-8?B?L2w3cUEyWUVGcmdRaWM4WGN4WEV2UDRDdVlWdEFhVHNiRm1MajlCM2owOVA5?=
 =?utf-8?B?a3pMWGRROWpGK1VORkw2NmFVdHlqaHBwSXBkS1JuT2liSWNJWjUvc0g2cFgw?=
 =?utf-8?B?TDkvbWVrQ054SDl4VjhxSDFrdTNpbExWeXcrekt0cHIweXVhdnViQmtCSXdq?=
 =?utf-8?B?U3ZKSW1ZRi81bnZEeGcwOUVjbnNic3JkYi83Z3RxZzFmM3l0VGZ3SGM2VDJq?=
 =?utf-8?B?M21yWFRwbGszbU9DWWxsdWFVa2lqZSs2Qm1YaGUzOHpyU1FlNGZ1WnVHSGpQ?=
 =?utf-8?B?QXUrTlg2Q2Rtc2hKbk16clFJbzY0KzRUUHJiWnV4ak9WN2lCVnNFeUwzNGFt?=
 =?utf-8?B?aENyKzBOeUJ4UVgxT1dtNFBDQWd5Snh3QklJMkRpbmlkUlhiV2M0VmZoRXRZ?=
 =?utf-8?B?a0dBNGNDdGtGUFZVRUpacWpxSWU2bGE4V3ZJMHZ6Wk9ac0ZtSnFuTzE1QXUr?=
 =?utf-8?B?NE9PcU9saW9OOFVaQys2VlFucjlFUS9mdDJqMlQzOGo4VE5GSkJBL2M0aVFT?=
 =?utf-8?B?ZWpqTms1WEJMMDczN25tdHZzMmJyZWtHZ3FJU1NlN2hsSmp0d3VkbEZ4dGNy?=
 =?utf-8?B?OTNsc2cvYnhkKzBpT21kYlhaaXBWOGZHdnNmTlJCa3YrSHdXVGU3MW1kRHRz?=
 =?utf-8?B?bE5seEYyaHhTYWxIM0dKRmlzNmhodk9CRGVtcjdVUEZiUnIwd3d5emJWaFlN?=
 =?utf-8?B?ekhhaGZUalF3N3duRUpGc3dNaHdOMDhZZ2hZbWJ2ZjF1MzlWdEhQQitEKzdo?=
 =?utf-8?B?QnlqdGFDNjNNNkxHdE9VYTlBcGU5ODhaa1N6QUxlZGpxOVhVOUVVMHB2M2hQ?=
 =?utf-8?B?QjBZUUVQN1FxTXZvQ2NUUXlDbmNXN3FpNlNBNkdPeGJMQ1dJRUlMUU55cVFS?=
 =?utf-8?B?VHdrMlE3RjJqTGJXci85TmRGeVhBeTRBRGVEaTBWZXFDM3NUUzBWZXlNajFY?=
 =?utf-8?B?QjA1aUltMWV6Y2VEME5SekViMEpQUGxkYWt6VncwUFIvbm5laFRVeDY2bjdn?=
 =?utf-8?B?RXRZNU9raFJDQWxLbUhGYWc5ZlNpQW83b0J5bzRlZEpVV2JINHdENHlsa2hm?=
 =?utf-8?B?c3ZneTk0MEgySE9yQjJkcXJ3bUFhVXZlT09UV1VZQVJHUUxVenVURDVMejNK?=
 =?utf-8?B?Tmc9PQ==?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 196d2d19-1640-4cda-0672-08db513d18e1
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 09:58:25.6456 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OzzQ1PM2Qq7Me2zRghjyiLZH3Qn0NPBWAEaWCADAMWu6JYG3lvPIlPZH/J0StueTqW4DJjeyB/te9F50486C1FruXpbqIWqEc6yORzIWgB4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7251
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6 1/6] Refactor mqns_01 using new LTP API
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

On 3/23/23 12:17, Petr Vorel wrote:
> Hi Andrea,
>
>> +++ b/runtest/containers
>> @@ -16,7 +16,8 @@ pidns31 pidns31
>>   pidns32 pidns32
>>   mqns_01 mqns_01
> Also, if anybody run this tests without params, it's actually not testing
> unshade as it was before (i.e. the default case is doing something different,
> than the main purpose of the test).
It's now testing also the plain process test case. All namespaces tests 
which have this testcase, "unshare" variant is set via option. If no 
options are given, then plain process is created.
>
>> -mqns_01_clone mqns_01 -clone
>> +mqns_01_clone mqns_01 -m clone
>> +mqns_01_unshare mqns_01 -m unshare
> BTW I'm verbose on changes during rewrite, I'd notice the fact that one extra
> run, which tests just fork (i.e. case where pass - the opposite is expected).
>
>
>> +++ b/testcases/kernel/containers/mqns/mqns_01.c
>> +/*\
>> + * [Description]
>> + *
>> + * Create a mqueue inside the parent and check if it can be accessed from
>> + * the child namespace.
> Actually my previous note "verify if cannot" is invalid, when -m is not set
> (fork call).  Again, I'd mention it here.
>
> ...
>> +		if (!SAFE_CLONE(&clone_args)) {
>> +			TST_EXP_FAIL(mq_open(MQNAME, O_RDONLY), ENOENT);
>> +			return;
>> +		}
>> +	} else if (str_op && !strcmp(str_op, "unshare")) {
>> +		tst_res(TINFO, "Spawning unshared process");
>> +
>> +		if (!SAFE_FORK()) {
>> +			SAFE_UNSHARE(CLONE_NEWIPC);
>> +			TST_EXP_FAIL(mq_open(MQNAME, O_RDONLY), ENOENT);
>> +			return;
>>   		}
>>   	} else {
>> -		if (write(p2[1], "exists", strlen("exists") + 1) < 0) {
>> -			perror("write(p2[1], \"exists\", 7) failed");
>> -			exit(1);
>> -		} else if (mq_close(mqd) < 0) {
>> -			perror("mq_close(mqd) failed");
>> -			exit(1);
>> +		tst_res(TINFO, "Spawning plain process");
>> +
>> +		if (!SAFE_FORK()) {
>> +			TST_EXP_POSITIVE(mq_open(MQNAME, O_RDONLY));
> nit: shouldn't this be TST_EXP_FD() (no real change, just extra "fd" being printed.

mq_open doesn't create a FD, but a queue identifier.


> Kind regards,
> Petr

Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
