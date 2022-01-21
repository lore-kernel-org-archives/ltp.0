Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52BE8C433F5
	for <ltp@archiver.kernel.org>; Fri, 21 Jan 2022 10:32:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 588133C9424
	for <ltp@archiver.kernel.org>; Fri, 21 Jan 2022 11:32:34 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3B2C73C9424
 for <ltp@lists.linux.it>; Fri, 21 Jan 2022 11:32:25 +0100 (CET)
Received: from de-smtp-delivery-102.mimecast.com
 (de-smtp-delivery-102.mimecast.com [194.104.109.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 877BC600A55
 for <ltp@lists.linux.it>; Fri, 21 Jan 2022 11:32:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com;
 s=mimecast20200619; t=1642761143;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Sc4LENv15oi+5aag+plpGwMYHd4E4qeUGoLNRUyPKz8=;
 b=edsNowRbPAobJNLLfiEUPpaZtj6fx6xm0VVlJUIraTamKPBmuf0DTtlXSnO8Pls30OKvP0
 3k37y+WD+VKXI6QAnTeqP/E+vXPf4YUE04J8uNbgsrDxbEQqtUfDylkbeZm9Quj/UAdFFE
 1BlwiYPC4DLbMAYv9q9fF6m3T8HrEPo=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2051.outbound.protection.outlook.com [104.47.13.51]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-7-3OZ-xFJVPFGnkFGWcvonOw-1; Fri, 21 Jan 2022 11:32:22 +0100
X-MC-Unique: 3OZ-xFJVPFGnkFGWcvonOw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fFsUuQTliYv2AJ7CN9uC2+T6U54MF7A7A1AvL9WxlKCtM2mgaEuU7BUTxEC3lQB5tptuMDacCxRk31L9L9zzx9uYCro+FKeEeToRPxkvrf2c2o/cecrIP6wIUEa6WCDVjDCul4WUmB2e9tsV1lqbKJx/dq58sNOVO6zBrvq+lxM5a1v7CogWwpzChXWJEhECfaVhObGmZHq548gjtIyZrvbow8DVHxkyUQcPabHjTXcaOeFqF0EJ+sMv0bFR5mzpiiYOhwRpBDRC0LuV/d04KXQB5E8AIOWHK3pSlkasf2CwlUU6OrQQmGJB1eI/cUSYJH84u769szb2Raq0nwaRoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sc4LENv15oi+5aag+plpGwMYHd4E4qeUGoLNRUyPKz8=;
 b=MefNaEBOOczhsC/tzntvoENmjm9EFYnZ4Ko6lSBcXy0Mu1e3eIi8xam+46D2mDr1+q5ELPvH3lCEhYpe8rrn25tcfky1Jxyqebok/PhvEZuDwh25KcgC1P6LWGx30vsS3P0qxktID6LlW+NK1B3SGZjv1QgsnDPRKHE5c9D7WG3z/f3Tgp6XjIVqbodyTNVmkEcyRc9vv2ISQrdxePTU6l9POxG6con/iLFtdDCZN3lfjDgEc2shfp4lgCbuKSPglfU47NY+x6cC6Oacaem2BwdPSW7os1q6fgFDsWnab9l4baRdLOlJrcRLaO39QQFMm3ZLu2j6AWui9SWsPblhvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM0PR04MB6788.eurprd04.prod.outlook.com (2603:10a6:208:18e::20)
 by AM0PR04MB5906.eurprd04.prod.outlook.com (2603:10a6:208:130::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.12; Fri, 21 Jan
 2022 10:32:20 +0000
Received: from AM0PR04MB6788.eurprd04.prod.outlook.com
 ([fe80::1c48:b656:15bb:a794]) by AM0PR04MB6788.eurprd04.prod.outlook.com
 ([fe80::1c48:b656:15bb:a794%7]) with mapi id 15.20.4909.012; Fri, 21 Jan 2022
 10:32:20 +0000
Message-ID: <07fa4901-8384-bfb3-fcc8-eb408b120f5c@suse.com>
Date: Fri, 21 Jan 2022 11:32:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
References: <20220121100604.1072-1-pvorel@suse.cz>
In-Reply-To: <20220121100604.1072-1-pvorel@suse.cz>
X-ClientProxiedBy: AM6PR02CA0029.eurprd02.prod.outlook.com
 (2603:10a6:20b:6e::42) To AM0PR04MB6788.eurprd04.prod.outlook.com
 (2603:10a6:208:18e::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 97afce48-0063-479e-cffa-08d9dcc94df4
X-MS-TrafficTypeDiagnostic: AM0PR04MB5906:EE_
X-Microsoft-Antispam-PRVS: <AM0PR04MB59069C9A916AE65AF61294B1F85B9@AM0PR04MB5906.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:321;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SMESpMwUmjz4W7FvYHRS5kD0pov6Ju/j1UWoh+l5U55msXccusjtrMmhuCTbwT7H3N7cCCmQlCTCiyjxf8B54mdnKbgKmQbNoZOUBY1mhL2BnFvzsnSMF6YmjmKwkUtaZy/VADZ3vw+/XciTzaXjeLd1sAcDuUE6FE+MnpEzPIJlbhCucLo05UNt4tAVYbBo5NatkEhXBLXKW61KcLsh129rxmWhWkKUNQFBJyLqQqYHemJCdEAnEEBIwXqjW0MdjOKQQVnu+cuIPUV3B4nEgwKWQgUE6CWpyiZt7QkUZh1zinXol/mbx1v8zYN8ft7ZF96j08Thk7YeoH4LGaS22gQFXURXYZFRyBz8hM6Uu0IGJCOUFEYpvv0t2HAodwbPEayNj0OySrowXx/MavlnkpWQVJLS7NyX8dqxVkLwsxfrb+Q/dNUva/o/NVejw1YhqKJdWHpqU16/+ukQxsFttruRI8qoxX96MNACNIgPrRd5b2D9GmloEUvb9zT8r8NxkRBBT5Ha1b/m/jRKtOmlQNfrNnnMfOHwMO3bEtiKb/RdDTXPgiBBP1VyPuzRxSLLgj+kdOWhuUyME42x7LDtGdDIhbxuKB3NOxd72w2EZ2kgIGLO7xcpmoa+mZuET0m3MQjvxLkkyKfC+4P1r8QE0SWwEZhZ07ymHruRDXBG6ktL+OytCj4beAXT3j8OmEQVdN443cPvuMAk7GGXZq8NuwIEcvvWBWzcSvoIQrcgSyGltOXQ5enfDvRwTRnYWB/8qvZh9aOEuTs48+gCBrrErA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB6788.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(26005)(86362001)(8936002)(186003)(2616005)(316002)(4326008)(8676002)(31686004)(54906003)(31696002)(36756003)(44832011)(66946007)(2906002)(83380400001)(6512007)(66556008)(53546011)(6506007)(33964004)(5660300002)(38100700002)(508600001)(6486002)(66476007)(17423001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3lONkVlL29UQUIxK2h3OC8ybndmeFNTU3ZicDFXZUxYazFsT1YrcWVPc2Rk?=
 =?utf-8?B?QXJSMDlXeVBWRW9lQnpkZkkrbHdSeU5vL1JsZlo2STRHQWhxNzFpZUpDQzZw?=
 =?utf-8?B?N2pycmZSVmxFdXVIY3JuaFpGWXJNNkh6bFh5MUxUVGJ6QW1VTGFyMjBKQWFo?=
 =?utf-8?B?aCtjMHNTaGJMdXNEbWFBWmI5T0grbExYb3ZFRUtsNGgvZVdyUmxWTzVOdzlY?=
 =?utf-8?B?Z1h5eTBsWmJiMkVzdUpZTi9ERm4ya3pJY21qRzA5UDlPcGtuN2FxN1VKNUYx?=
 =?utf-8?B?Sm5FQjNMR2NqT28zNUZPeENLdGI0bjBra2pVU2NNd3pHOW5KMm91LzZob1JX?=
 =?utf-8?B?dHZFa3NsMlJyQzlNVTNrbHRlZjhSeHRJWEIwVGNqd3RhYVBhbTVidWYzRHBm?=
 =?utf-8?B?YTF5RnF1RHQyT0FXc015ZEl5TExlODBnUDh1ckhjMFArcVlJWFNNWlRCVU90?=
 =?utf-8?B?YUJKTmpaMkJvWVd6YVB0YWljYXU5Z2dzUFFwRmFldHNRVGpSeThFOFR5TGVP?=
 =?utf-8?B?MzEwcEhYZG1FVW84OHJBTUtCVjV0a2YvcVNZbG9rM2VQd0grVk9ZTlY5REtr?=
 =?utf-8?B?dUQwemVJd21rZG9qMTl1K2d3MVIxOXlqcmp3cnBoamJveUErd0Y2blNKMUE4?=
 =?utf-8?B?Z3JySSt5Szg3VnRNR2g1VmNjNFd0b3g0ZDB1YUVyaURPQzlqS2xsQ1lDY0Yz?=
 =?utf-8?B?bWdLSHNzOFVBb1ptRjhJc3BqNzlJZHNOMnBMM050TG1aNGx4ZEFTNUhxejdF?=
 =?utf-8?B?Ukt5SFBPQ1ZQUGJDUzUvMXVqeGRzM1Z4cHBRQXhZY0pleUhwNUxoQ0tRa0Rv?=
 =?utf-8?B?R2g2K0NMRkZwM1p2bGVNbldwZ3dUUjJUWmtnZSt1NktSd0dzNGFYMS9zYkxB?=
 =?utf-8?B?eC9UQkdNazZXa2M5d1Zkd1c2aS8yK1cxc3R4eEEvU3R1VFM1SGdMbDMyZlNG?=
 =?utf-8?B?dW1ERWN5U2NhOUFMeTZPbzhhREc4UFA4Yy91WUdiSi9BdHRHc3pMTmc3bFd1?=
 =?utf-8?B?bmN5Zzh5RGJCZmpOcGNiSHJvT1VQQllYWllScllQWk14ZkNzTFdGenZnRk9D?=
 =?utf-8?B?aGtYT0hOOElLT2pQUFV4aVNMcGl0SVlrZnhIa25LYmtSY0NubWdOTTZVK045?=
 =?utf-8?B?dU1jMSs4QUI3QW9HemdwTDZ5N2doWTJtSUFaZTJSMHpZbnVERDMzNlArTU9X?=
 =?utf-8?B?TkdEaW5YVkZJR1NTbFBUQ1FKR0lIRUVGTjNET0lISTlWVXB4RG1BV2pYa2pK?=
 =?utf-8?B?MDZoV0pxdnErc25sQWl4NDBFVnJFUXhWR0lRaXo1d0hQTWcwditBbURIcG1s?=
 =?utf-8?B?V0d0bnp2eXVHQmp3MlVnbTcvRisvbzJQNGpzc0JGTllEK0NNNk9nYWlBbDVY?=
 =?utf-8?B?OXNEeVFUa2o1OTZHaitZNkhCamJsNitEb3J4VzVaOVhnelRrS1BsWTFKWm9q?=
 =?utf-8?B?WVBGaysxR2MyR2lNRGE5R1lEQUViWTJqd3c4aWFrbDZzb1c5YndNekMwTVA3?=
 =?utf-8?B?Rk9YOU43eWZId1lsZWUwYy9WRXZ5d1F5WmtPWkl3eXhDaTYxSmxzV2hiSUpB?=
 =?utf-8?B?L1d5L2lnUW9oOGZZTFgzdE5DWTgyN2xYc2IzUFJzbWhWUXRWQ3VUL3JiVm5m?=
 =?utf-8?B?Z0p5c0t4NWNNVlppTE9iSkZnSmZqNDRIckI2ampYYzNwYjNJTnA0a3FRczRs?=
 =?utf-8?B?QkZJWkpiOU9UNHNMazVTTHBCWSsyNCtxSnZlbFI5YTJzSStkdXBCa1ZTa3BC?=
 =?utf-8?B?NE1NVW8yU2FLVlN6SVFmaEZFMmV2anhRT09HK3M1MytISmU3a2ZLcjdzVzMz?=
 =?utf-8?B?VUp4Rk8zVzc1NmMwMmR4OG1laVBDSFFXaGhqUnJ3a2VIM1o2TDRmQm1aNW91?=
 =?utf-8?B?Nm5wTTJUT2dJQ0JLTTF5ZUxaZFA4ZFFuQ2pJQ3ZYVXJkRVVQL1R2NUR3a2Vu?=
 =?utf-8?B?bmxmY2Q5NThFaDhlRCszZ2Rkd0hwT0sra3dKZkJGM2t0cjJ4S2ZJd1htYW5x?=
 =?utf-8?B?c3NYRWlhbTlhRWh6OVpzZGJLc0MzaVJsdWo4WFJSbUJqd0FXenhGYytoL09H?=
 =?utf-8?B?ek5yUnEzSVk1OXhkU3oyWHEwTVRtWVhWWDFsN0JKK09nQS8xeWdBRDBBVlFi?=
 =?utf-8?B?cjNnK1VqNXRTaDFtckFjWWlZQlFlbTFHNjEzQ1BSQkhBODRVTjc4RE44Q0xs?=
 =?utf-8?B?cnhYM252aUZ0VUJpS1R2alpJRzloTlNiTFNaMUV0M0lGWHd2cWJIUmtma1dl?=
 =?utf-8?B?NDJuMHI1WFNhVXRQMWl5dzlPWFJnPT0=?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97afce48-0063-479e-cffa-08d9dcc94df4
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6788.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2022 10:32:20.4843 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AACrqToV1gGRWEmKWfAGSCwvMwxlgBxta1vUCtLnDNBBHYpZUIxGcM1AgZQ/ncgplSA6zkpMcmAk4pR1/y/zTLtWc4vgq2ZgsErnBzF8Ue8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5906
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] aiodio: Skip tests on tmpfs
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
Content-Type: multipart/mixed; boundary="===============0657523135=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0657523135==
Content-Type: multipart/alternative;
 boundary="------------LKxYFoqqjjRTvRHde2qLAJT6"
Content-Language: en-US

--------------LKxYFoqqjjRTvRHde2qLAJT6
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi!

On 1/21/22 11:06, Petr Vorel wrote:
> tmpfs does not support it.
>
> Signed-off-by: Petr Vorel<pvorel@suse.cz>
> ---
>   testcases/kernel/io/ltp-aiodio/aiodio_append.c | 10 ++++++++--
>   testcases/kernel/io/ltp-aiodio/dio_append.c    |  4 ++++
>   testcases/kernel/io/ltp-aiodio/dio_read.c      |  4 ++++
>   testcases/kernel/io/ltp-aiodio/dio_sparse.c    | 10 ++++++++--
>   testcases/kernel/io/ltp-aiodio/dio_truncate.c  | 10 ++++++++--
>   5 files changed, 32 insertions(+), 6 deletions(-)
>
> diff --git a/testcases/kernel/io/ltp-aiodio/aiodio_append.c b/testcases/kernel/io/ltp-aiodio/aiodio_append.c
> index cb04b04a57..46cc74ee4e 100644
> --- a/testcases/kernel/io/ltp-aiodio/aiodio_append.c
> +++ b/testcases/kernel/io/ltp-aiodio/aiodio_append.c
> @@ -131,8 +131,10 @@ static void setup(void)
>   
>   static void cleanup(void)
>   {
> -	*run_child = 0;
> -	SAFE_MUNMAP(run_child, sizeof(int));
> +	if (run_child) {
> +		*run_child = 0;
> +		SAFE_MUNMAP(run_child, sizeof(int));

SAFE_MUNMAP should be called always, even if *run_child == 0 (which happens if run() completed successfully).

> +	}
>   }
>   
>   static void run(void)
> @@ -177,6 +179,10 @@ static struct tst_test test = {
>   		{"b:", &str_numaio, "Number of async IO blocks (default 16)"},
>   		{}
>   	},
> +	.skip_filesystems = (const char *[]) {
> +		"tmpfs",
> +		NULL
> +	},
>   };
>   #else
>   TST_TEST_TCONF("test requires libaio and its development packages");
> diff --git a/testcases/kernel/io/ltp-aiodio/dio_append.c b/testcases/kernel/io/ltp-aiodio/dio_append.c
> index 59fd710e70..c099793f6c 100644
> --- a/testcases/kernel/io/ltp-aiodio/dio_append.c
> +++ b/testcases/kernel/io/ltp-aiodio/dio_append.c
> @@ -93,4 +93,8 @@ static struct tst_test test = {
>   		{"c:", &str_appends, "Number of appends (default 1000)"},
>   		{}
>   	},
> +	.skip_filesystems = (const char *[]) {
> +		"tmpfs",
> +		NULL
> +	},
>   };
> diff --git a/testcases/kernel/io/ltp-aiodio/dio_read.c b/testcases/kernel/io/ltp-aiodio/dio_read.c
> index 2c2ec4bce0..67a28147fd 100644
> --- a/testcases/kernel/io/ltp-aiodio/dio_read.c
> +++ b/testcases/kernel/io/ltp-aiodio/dio_read.c
> @@ -177,4 +177,8 @@ static struct tst_test test = {
>   		{"s:", &str_filesize, "File size (default 128M)"},
>   		{}
>   	},
> +	.skip_filesystems = (const char *[]) {
> +		"tmpfs",
> +		NULL
> +	},
>   };
> diff --git a/testcases/kernel/io/ltp-aiodio/dio_sparse.c b/testcases/kernel/io/ltp-aiodio/dio_sparse.c
> index 4ee2fbab18..39fc895d65 100644
> --- a/testcases/kernel/io/ltp-aiodio/dio_sparse.c
> +++ b/testcases/kernel/io/ltp-aiodio/dio_sparse.c
> @@ -83,8 +83,10 @@ static void setup(void)
>   
>   static void cleanup(void)
>   {
> -	*run_child = 0;
> -	SAFE_MUNMAP(run_child, sizeof(int));
> +	if (run_child) {
> +		*run_child = 0;
> +		SAFE_MUNMAP(run_child, sizeof(int));
> +	}
>   }
>   
>   static void run(void)
> @@ -129,4 +131,8 @@ static struct tst_test test = {
>   		{"o:", &str_offset, "File offset (default 0)"},
>   		{}
>   	},
> +	.skip_filesystems = (const char *[]) {
> +		"tmpfs",
> +		NULL
> +	},
>   };
> diff --git a/testcases/kernel/io/ltp-aiodio/dio_truncate.c b/testcases/kernel/io/ltp-aiodio/dio_truncate.c
> index 4bf11c9588..1fbf83de06 100644
> --- a/testcases/kernel/io/ltp-aiodio/dio_truncate.c
> +++ b/testcases/kernel/io/ltp-aiodio/dio_truncate.c
> @@ -107,8 +107,10 @@ static void setup(void)
>   
>   static void cleanup(void)
>   {
> -	*run_child = 0;
> -	SAFE_MUNMAP(run_child, sizeof(int));
> +	if (run_child) {
> +		*run_child = 0;
> +		SAFE_MUNMAP(run_child, sizeof(int));
> +	}
>   }
>   
>   static void run(void)
> @@ -163,4 +165,8 @@ static struct tst_test test = {
>   		{"c:", &str_numwrites, "Number of append & truncate (default 100)"},
>   		{}
>   	},
> +	.skip_filesystems = (const char *[]) {
> +		"tmpfs",
> +		NULL
> +	},
>   };

Kind regards,

Andrea

--------------LKxYFoqqjjRTvRHde2qLAJT6
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><font size="4">Hi!</font></p>
    <div class="moz-cite-prefix">On 1/21/22 11:06, Petr Vorel wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20220121100604.1072-1-pvorel@suse.cz">
      <pre class="moz-quote-pre" wrap="">tmpfs does not support it.

Signed-off-by: Petr Vorel <a class="moz-txt-link-rfc2396E" href="mailto:pvorel@suse.cz">&lt;pvorel@suse.cz&gt;</a>
---
 testcases/kernel/io/ltp-aiodio/aiodio_append.c | 10 ++++++++--
 testcases/kernel/io/ltp-aiodio/dio_append.c    |  4 ++++
 testcases/kernel/io/ltp-aiodio/dio_read.c      |  4 ++++
 testcases/kernel/io/ltp-aiodio/dio_sparse.c    | 10 ++++++++--
 testcases/kernel/io/ltp-aiodio/dio_truncate.c  | 10 ++++++++--
 5 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/io/ltp-aiodio/aiodio_append.c b/testcases/kernel/io/ltp-aiodio/aiodio_append.c
index cb04b04a57..46cc74ee4e 100644
--- a/testcases/kernel/io/ltp-aiodio/aiodio_append.c
+++ b/testcases/kernel/io/ltp-aiodio/aiodio_append.c
@@ -131,8 +131,10 @@ static void setup(void)
 
 static void cleanup(void)
 {
-	*run_child = 0;
-	SAFE_MUNMAP(run_child, sizeof(int));
+	if (run_child) {
+		*run_child = 0;
+		SAFE_MUNMAP(run_child, sizeof(int));</pre>
    </blockquote>
    <pre class="moz-quote-pre" wrap="">SAFE_MUNMAP should be called always, even if *run_child == 0 (which happens if run() completed successfully).
</pre>
    <blockquote type="cite" cite="mid:20220121100604.1072-1-pvorel@suse.cz">
      <pre class="moz-quote-pre" wrap="">
+	}
 }
 
 static void run(void)
@@ -177,6 +179,10 @@ static struct tst_test test = {
 		{&quot;b:&quot;, &amp;str_numaio, &quot;Number of async IO blocks (default 16)&quot;},
 		{}
 	},
+	.skip_filesystems = (const char *[]) {
+		&quot;tmpfs&quot;,
+		NULL
+	},
 };
 #else
 TST_TEST_TCONF(&quot;test requires libaio and its development packages&quot;);
diff --git a/testcases/kernel/io/ltp-aiodio/dio_append.c b/testcases/kernel/io/ltp-aiodio/dio_append.c
index 59fd710e70..c099793f6c 100644
--- a/testcases/kernel/io/ltp-aiodio/dio_append.c
+++ b/testcases/kernel/io/ltp-aiodio/dio_append.c
@@ -93,4 +93,8 @@ static struct tst_test test = {
 		{&quot;c:&quot;, &amp;str_appends, &quot;Number of appends (default 1000)&quot;},
 		{}
 	},
+	.skip_filesystems = (const char *[]) {
+		&quot;tmpfs&quot;,
+		NULL
+	},
 };
diff --git a/testcases/kernel/io/ltp-aiodio/dio_read.c b/testcases/kernel/io/ltp-aiodio/dio_read.c
index 2c2ec4bce0..67a28147fd 100644
--- a/testcases/kernel/io/ltp-aiodio/dio_read.c
+++ b/testcases/kernel/io/ltp-aiodio/dio_read.c
@@ -177,4 +177,8 @@ static struct tst_test test = {
 		{&quot;s:&quot;, &amp;str_filesize, &quot;File size (default 128M)&quot;},
 		{}
 	},
+	.skip_filesystems = (const char *[]) {
+		&quot;tmpfs&quot;,
+		NULL
+	},
 };
diff --git a/testcases/kernel/io/ltp-aiodio/dio_sparse.c b/testcases/kernel/io/ltp-aiodio/dio_sparse.c
index 4ee2fbab18..39fc895d65 100644
--- a/testcases/kernel/io/ltp-aiodio/dio_sparse.c
+++ b/testcases/kernel/io/ltp-aiodio/dio_sparse.c
@@ -83,8 +83,10 @@ static void setup(void)
 
 static void cleanup(void)
 {
-	*run_child = 0;
-	SAFE_MUNMAP(run_child, sizeof(int));
+	if (run_child) {
+		*run_child = 0;
+		SAFE_MUNMAP(run_child, sizeof(int));
+	}
 }
 
 static void run(void)
@@ -129,4 +131,8 @@ static struct tst_test test = {
 		{&quot;o:&quot;, &amp;str_offset, &quot;File offset (default 0)&quot;},
 		{}
 	},
+	.skip_filesystems = (const char *[]) {
+		&quot;tmpfs&quot;,
+		NULL
+	},
 };
diff --git a/testcases/kernel/io/ltp-aiodio/dio_truncate.c b/testcases/kernel/io/ltp-aiodio/dio_truncate.c
index 4bf11c9588..1fbf83de06 100644
--- a/testcases/kernel/io/ltp-aiodio/dio_truncate.c
+++ b/testcases/kernel/io/ltp-aiodio/dio_truncate.c
@@ -107,8 +107,10 @@ static void setup(void)
 
 static void cleanup(void)
 {
-	*run_child = 0;
-	SAFE_MUNMAP(run_child, sizeof(int));
+	if (run_child) {
+		*run_child = 0;
+		SAFE_MUNMAP(run_child, sizeof(int));
+	}
 }
 
 static void run(void)
@@ -163,4 +165,8 @@ static struct tst_test test = {
 		{&quot;c:&quot;, &amp;str_numwrites, &quot;Number of append &amp; truncate (default 100)&quot;},
 		{}
 	},
+	.skip_filesystems = (const char *[]) {
+		&quot;tmpfs&quot;,
+		NULL
+	},
 };
</pre>
    </blockquote>
    <p>Kind regards,<br>
    </p>
    <p>Andrea<br>
    </p>
  </body>
</html>

--------------LKxYFoqqjjRTvRHde2qLAJT6--


--===============0657523135==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0657523135==--

