Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93BB5C433F5
	for <ltp@archiver.kernel.org>; Fri, 25 Mar 2022 08:58:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 67F913C93CA
	for <ltp@archiver.kernel.org>; Fri, 25 Mar 2022 09:58:54 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BB25E3C280F
 for <ltp@lists.linux.it>; Fri, 25 Mar 2022 09:58:41 +0100 (CET)
Received: from de-smtp-delivery-102.mimecast.com
 (de-smtp-delivery-102.mimecast.com [194.104.111.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 8E4FE600F4D
 for <ltp@lists.linux.it>; Fri, 25 Mar 2022 09:58:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com;
 s=mimecast20200619; t=1648198719;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FdQ08h6kDzoImPwTwRO/Pw2O0RB21TBVgK8XwHJVVWg=;
 b=VzP2f3bRJQ6rsbnhdfUmpIozjZehWHlkL+7STEEItthn5kht360rQIn9ToG9jH+4amgTDL
 Lr5xNtvMBQExD1WwhXHjBBnRlTqRwK2e/4goMRraOBrKcZ5Vrn8vS5meLgI8e4rTbALJFm
 flTU8IrYA/Hdv4oBer9OFetOnbBqO18=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2108.outbound.protection.outlook.com [104.47.17.108]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-40-eCkpFg4PNEuKcS1MIk8qhQ-1; Fri, 25 Mar 2022 09:58:38 +0100
X-MC-Unique: eCkpFg4PNEuKcS1MIk8qhQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cV8YF4GoVpLnUbf8egBhd0TZJ1wH2G0+dTGZaxr+HewLLWuGy4W0D9Ti6mYmSYoYDodzY0WONCtJt0VYPIkni7N6L5uaVoQkAZpECf5X1C6HwYFwIRvmV0h46Yo756nbEeZcvgH/Ze4wUJUwXNHlSFJbVmYPENsWxXNZZBWmAcOrit93uU7gbr7/Gr/s+joDbaRkXaysk8UIaDLVgKLJ186V913OqIZMgcTEqRNNNB6mBRO/NJd9nxp7IePFOlW8AiNwMOg/pCfoL0U9Yx6cYgbTvBaKOnEz0+6uk5C5CvOfSGnACeePrSyM9liu77YYeFaUcaGhQG/jxAUWuyWwYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FdQ08h6kDzoImPwTwRO/Pw2O0RB21TBVgK8XwHJVVWg=;
 b=OtHg78M5eP8Tm3ZCi5TY39QxtrbSqRHF+gjw//1T1+4LyFUsP5rJXMJJoE2n3pI62S+4m9d9yyfCcknXghQzgpjZTQMdEY2yXIOinhNvzRVC50SK4aWHTvTyvN/whrZS8Dfr6uMrGn3Qy6EWwLhG3SntZ0dx8bT8UzwOlaortNngVKJE5LPo9SG3MO03yJFKDUPSQBfj7L0w53RX5NeyPZG/rBDNBIC1g4BTmABf5HFNlpkaKOujtRRBk3Wqa91A3qNrPcMklF3QdsC7RyI0YxvlhQJDFvWiXuWcyK9NAfLXi0ULrvMiwULc317xZ60zfptvlacDF2t42en6aibhhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by VI1PR04MB7165.eurprd04.prod.outlook.com (2603:10a6:800:125::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Fri, 25 Mar
 2022 08:58:36 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::416d:72a9:694f:f1b3]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::416d:72a9:694f:f1b3%9]) with mapi id 15.20.5102.019; Fri, 25 Mar 2022
 08:58:36 +0000
Message-ID: <3bcea917-5ac1-d50c-2123-38cd4f76f169@suse.com>
Date: Fri, 25 Mar 2022 09:58:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20220315122351.8556-1-andrea.cervesato@suse.de>
 <20220315122351.8556-9-andrea.cervesato@suse.de> <Yj1s2cKWf7oNwSVR@pevik>
In-Reply-To: <Yj1s2cKWf7oNwSVR@pevik>
X-ClientProxiedBy: AS8PR05CA0026.eurprd05.prod.outlook.com
 (2603:10a6:20b:311::31) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 35e57233-c0da-4fba-557a-08da0e3da5e3
X-MS-TrafficTypeDiagnostic: VI1PR04MB7165:EE_
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-Microsoft-Antispam-PRVS: <VI1PR04MB71653EBB0BAE29408294DA36F81A9@VI1PR04MB7165.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IZbKOmEB0+cg5CDjX/5PkKcbgjLe/lok1uBIeiPavcdTyvRGmqh/sFVFQcIhj5KnMSsVWCmYCOjHzDzppK33GKuy+R9ER7AwAN39VRw+Rxt+dz0iHedfA1eH6o5pj3S48gXF1d056vwxnW8XSUJewJmdwEbSWXbvlWRJwH3t3aS8jlRNjXtNAQsl/DAUgfAPEaTibYApzoKJgvv/BdLCehUOaT6Dic3t8yKokMk/mpmNqP8RzmHN6N98QC8Te9dcz3aUYwt7eue/IZ3TdSH5mEZrDbQ7bsHEMaCoaKBK1I6U/h++HlzoU0+bP3X0YBJV7pvE2fyMUXCTNiEy5zrG9kwNsoNB6hz0V6aYd4Q7ahQnW5nzzQir1ZvBr4tJF6SPX9Kng3+1RX26ehIHbptk8gsBApEMAa/H62Y/g7x5YKYf+NpSdo8AWQ3dqmH2nDEjSpzYBvZFB6N8v8+CoZul+kdbPTNjAvG3rdmNil8uFmhE9/S8+4H2Q8qTRcrcgAXm8R/FNLSn1VtlflTS8dvKiXcQ9yg5S5wj87/05/SOSSLcIjfxbFYjzkvh3UHI2cFkMJEbeZhXiOiYkYiOcUqva2zHMKzP6fh+Xxt3NOW8soA6xiPujvGJG0HUfZFfXvaCvOz+g4NVvAy2f4/YeBG/Y9B1lFDRpAgqE9X995J7KDI0Wb7rkRf6SRE/yPBKy+jVZWnHEu5UJcPDXt/+m1Vt6LKuou/f+kcBrT/zM4ugBW8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(8676002)(4326008)(66946007)(66556008)(66476007)(316002)(53546011)(107886003)(83380400001)(31696002)(86362001)(5660300002)(36756003)(31686004)(6512007)(110136005)(508600001)(6486002)(8936002)(44832011)(186003)(38100700002)(2616005)(26005)(2906002)(6506007)(33964004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGlzUGRSOXFXSnpHYWhnTXpiRGZ3K3pFbmxrL1VOanByamF5dkJCRUs5MGlT?=
 =?utf-8?B?bXJsS3NKQTN4aDYwK1IrdDRIQ0tMMTJOL0dOeWxOeVhZT2V0NDZrV2hHWUZG?=
 =?utf-8?B?Q1hibDlKMStSM0tpQUloY1B1eTFlLzk4Q2JRUXRzQVRzVWlaS2tDYjcwQVlK?=
 =?utf-8?B?R05HSkljMGp6dWRtN1haRHlTMEphT3pZODhlQzdQMXRpUzR1d1p4eERraCt5?=
 =?utf-8?B?bURVclVpcnEyeVFLcDdRRk9ib2NjQXNEZU0rYmpXUTNBWmVvMUVzMlRHR3E4?=
 =?utf-8?B?V3dwb1hWbGlZVFpGeWpzUHdNWWhiR2VZWG9UN0hHMWFtSW1qWWxyZ3N4Q0hE?=
 =?utf-8?B?bUt4OXUvVTgzVXA1QVVQNzNqNWVWZE02NFgrdGs3dHlZaWVIbHErTlJEcHUy?=
 =?utf-8?B?NWtwU2p1L2g2TWNBL2xteWhMUU9rdkdwN3ZXazFGT1E0VDJlTENRd3BqSEhv?=
 =?utf-8?B?eUE5YlFUT2tPQUxlZ3AyREd4eHhkOE1OTTRTa0FxSTZ6Wk93cnIzeFluaFdi?=
 =?utf-8?B?cC81aDMvNmZoS1JhSVZpaEZzS2NtQWNHWkNWZFI0OUhJVEM4b09FcE96MlNU?=
 =?utf-8?B?VzJMd1RWVEFPK1hWZkdpajQ4NjA3WmEvWVlPNmgyVUZSNHViTkw1QzlvMUp1?=
 =?utf-8?B?ejFPZG9rS01NcGZJMjk5eGNseHhJL3B2bnJHeGVxTzZEMGFQNktsejRYOVJU?=
 =?utf-8?B?YXJJaEhiaXhPekVFUWFLNStoSzZhSUJVVnJiL3FXWWdHejA4c2VKWkZvVTI4?=
 =?utf-8?B?WWY2dVNLQXhhd1VTKzdQZDZGM1pZelFWc05VRmZJdHRHa3EvRkFiZzlsdmZS?=
 =?utf-8?B?K29EajN1STVpN0NKVGo3eHg1SWg5V0JaVE9kQWdEeGxzenh2SUt2ZkdaWlVv?=
 =?utf-8?B?SXA5b2h6K2V0cHZhZ3JQNGxjZ1FaV2UwdWVwa2Vud3k4NTN2N0lkdjZRb1ZJ?=
 =?utf-8?B?ZUVhcStqdVJXUWRnREZZc3loRlBzTkFHUUhIdzB2aUV0bW1qaWV3YmJpczBC?=
 =?utf-8?B?dUxSd3JNTXlpditJRXlNdGxHeDAwMm1SOVVjVXVkTjdoM0hWa0VyT2xUc2wz?=
 =?utf-8?B?cUxiMWJEOW96L1NCdjZjMDlhQXY1NlJoeVJDVnpUc3ptcE56c3R1Y3Zpa1BU?=
 =?utf-8?B?M0tkUDlNYlVaWTZhaXMrM2VSRFJqRmlsVmE5SkVuUngxRGtDdUJUYlc1UDFw?=
 =?utf-8?B?S213N0ViOU0wWTgzRnNGWUhlSWg4Y2NsdFU3ZVNNRkFiM2lIbUVIQVZ3elZk?=
 =?utf-8?B?Ujh5Wmp4UWN4Y1AyWERMdlVVQmxVRklEbVpiTXl5Vk5kcVFTU1VVdUJaNXVM?=
 =?utf-8?B?OFN5elY2cEpBVXBGY0kxZjMxbklCY01IdmZXUk9VdTduWE5UVm04YWlNd04y?=
 =?utf-8?B?bDlxWWNBKytuK2pyTjYwbFg2RXVnM2gvbTZzK2c4RHo1VWl4aTU5YnFhdlQ1?=
 =?utf-8?B?NWk5d3RxSHcrSzNBRktkNFQ5VnhUa2xWRnBiNVAzYW1VZFhkNEh4NUdrbENN?=
 =?utf-8?B?ZFBheSt2QWdXOTFQc2s0VzRxbWNia1V3L2w3aFNmVlQzZzRnaTQ2c0NNa0x6?=
 =?utf-8?B?dXNiN0dSVDQ2MmZIaWhoQjNEdWpBdWZMU0pmN1IxTFRXRnhCMjZjY09pbjFp?=
 =?utf-8?B?R21zait5VXIyMVFZYk5iaU5Qc20vaDJ2UzhOUmpZMzVWNGNKNGF2QWNKM3BM?=
 =?utf-8?B?eWJFeU8wRDdOV1psWUxmOWdQQ24xM1l3UFBRMS9WaXBMZjlyQkhCUjdXUXNi?=
 =?utf-8?B?Sk53S25wSVNyeVYvUk5LeGNac3VqcUtON0gzZTljR21LU2xuWVpGODV1b1c3?=
 =?utf-8?B?TmJNNHYvREdVNnRhbk5xK3FIRm1vOHRCY0VsUmxkY0E1QXVBWVAxUG9WbVZ4?=
 =?utf-8?B?ZzRvTGlPSCs1WXQyTGhyZDRHYW1hcEpSb3hFeEdIVXpPbTFnaUZ5QU9VdjBD?=
 =?utf-8?B?SlMyTE0rZHhWSWYvdFRiY2R0cFdONnV3bXhNS1l0ckFYUDhNYUVuS3N4ZjI2?=
 =?utf-8?B?RzY0MzBmdzc4K3JTbGpjYzJXOVVNYUE4cHlWZFZtMGlvMk94Q0xLUHd0NSsx?=
 =?utf-8?B?bzZpNzUzMXUrVGFwZ3ZFS3J3VVBqT1FEcnhMWHdDbkR0VkxtOGZGcTBtTVQw?=
 =?utf-8?B?S2VWVG0yc3Fqa1F4c3dWckFMeUFWOG8zbHdJbjBROVZEcHRWWFE4YVNRc1dn?=
 =?utf-8?B?cjFsT1JKZHJsVTE0STdjWXJRcVdPSnh4NnBVNkFyRW1yY3k0dDN0NVJIeVVC?=
 =?utf-8?B?QXNiaTd4SjhZY0svQmdDYVVOdnRNTWJORkpNditzOUZkTUZ3MDg5SE5GcXhS?=
 =?utf-8?B?NW1Kd3AvQjUzRVlFMmU0cHVZODk0Y2JkUFpyNXdQZmE1Z3R1cllZcWtBZWdk?=
 =?utf-8?Q?MStJ5gKaHnoNRr3c=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35e57233-c0da-4fba-557a-08da0e3da5e3
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2022 08:58:36.6373 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zG0cxg2tqMDgXmm+bJLCxqMg81hMOYT1A9f2mIK3XKdfTxv5LEuOkvi9vCK5SniSlnO5360r0SIRr5+ph1fGEpjfdKdJWKDkrYifYIhT6eE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7165
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 8/8] Rewrite userns08.c using new LTP API
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
Cc: rpalethorpe@suse.com, ltp@lists.linux.it
Content-Type: multipart/mixed; boundary="===============0943207696=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0943207696==
Content-Type: multipart/alternative;
 boundary="------------IKSv2oEw81ra0H0NNUYRx1dS"
Content-Language: en-US

--------------IKSv2oEw81ra0H0NNUYRx1dS
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Petr,

I think this patch can be avoided at this point

Andrea

On 3/25/22 08:18, Petr Vorel wrote:
> Hi Andrea,
>
> [Cc Richie]
>
> This subject: "Rewrite userns08.c using new LTP API" is misleading,
> userns08.c was already using new API.
>
> You're:
> * s/tst_res/tst_brk/ (that would deserve explanation why)
> * removing tst_reap_children()
> * changing formatting (some of them create too long lines)
>
> ...
>>   static pid_t clone_newuser(void)
>>   {
>> -	const struct tst_clone_args cargs = {
>> -		CLONE_NEWUSER,
>> -		SIGCHLD
>> -	};
>> +	const struct tst_clone_args cargs = { CLONE_NEWUSER, SIGCHLD };
>>   	return SAFE_CLONE(&cargs);
>>   }
>> -static void write_mapping(const pid_t proc_in_ns,
>> -			  const char *const id_mapping)
>> +static void write_mapping(const pid_t proc_in_ns, const char *const id_mapping)
>>   {
>>   	char proc_path[PATH_MAX];
>>   	int proc_dir;
>> @@ -61,11 +58,11 @@ static void write_mapping(const pid_t proc_in_ns,
>>   static void ns_level2(void)
>>   {
>>   	if (prctl(PR_SET_DUMPABLE, 1, 0, 0, 0))
>> -		tst_res(TINFO | TERRNO, "Failed to set dumpable flag");
>> +		tst_brk(TBROK | TTERRNO, "Failed to set dumpable flag");
> Not sure which one is correct (whether tst_res or tst_brk).
> But TTERRNO is obviously wrong, that's for using TEST(). Here should remain
> TERRNO.
>
>> +
>>   	TST_CHECKPOINT_WAKE_AND_WAIT(1);
>> -	TST_EXP_FAIL(open("restricted", O_WRONLY), EACCES,
>> -		     "Denied write access to ./restricted");
>> +	TST_EXP_FAIL(open("restricted", O_WRONLY), EACCES, "Denied write access to ./restricted");
> I'd keep this one.
>
>>   	exit(0);
>>   }
>> @@ -89,7 +86,6 @@ static void ns_level1(void)
>>   	write_mapping(level2_proc, map_over_5);
>>   	TST_CHECKPOINT_WAKE(1);
>> -	tst_reap_children();
> Well, test works without it, but not really sure if it can be removed.
>
> Kind regards,
> Petr
>
>>   	exit(0);
>>   }
>> @@ -111,7 +107,6 @@ static void run(void)
>>   	write_mapping(level1_proc, "0 100000 1000");
>>   	TST_CHECKPOINT_WAKE(0);
>> -	tst_reap_children();
--------------IKSv2oEw81ra0H0NNUYRx1dS
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><font size="4">Hi Petr,</font></p>
    <p><font size="4">I think this patch can be avoided at this point<br>
      </font></p>
    <p><font size="4">Andrea</font><br>
    </p>
    <div class="moz-cite-prefix">On 3/25/22 08:18, Petr Vorel wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:Yj1s2cKWf7oNwSVR@pevik">
      <pre class="moz-quote-pre" wrap="">Hi Andrea,

[Cc Richie]

This subject: &quot;Rewrite userns08.c using new LTP API&quot; is misleading,
userns08.c was already using new API.

You're:
* s/tst_res/tst_brk/ (that would deserve explanation why)
* removing tst_reap_children()
* changing formatting (some of them create too long lines)

...
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap=""> static pid_t clone_newuser(void)
 {
-	const struct tst_clone_args cargs = {
-		CLONE_NEWUSER,
-		SIGCHLD
-	};
+	const struct tst_clone_args cargs = { CLONE_NEWUSER, SIGCHLD };
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap=""> 	return SAFE_CLONE(&amp;cargs);
 }
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">-static void write_mapping(const pid_t proc_in_ns,
-			  const char *const id_mapping)
+static void write_mapping(const pid_t proc_in_ns, const char *const id_mapping)
 {
 	char proc_path[PATH_MAX];
 	int proc_dir;
@@ -61,11 +58,11 @@ static void write_mapping(const pid_t proc_in_ns,
 static void ns_level2(void)
 {
 	if (prctl(PR_SET_DUMPABLE, 1, 0, 0, 0))
-		tst_res(TINFO | TERRNO, &quot;Failed to set dumpable flag&quot;);
+		tst_brk(TBROK | TTERRNO, &quot;Failed to set dumpable flag&quot;);
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">Not sure which one is correct (whether tst_res or tst_brk).
But TTERRNO is obviously wrong, that's for using TEST(). Here should remain
TERRNO.

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">+
 	TST_CHECKPOINT_WAKE_AND_WAIT(1);
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">-	TST_EXP_FAIL(open(&quot;restricted&quot;, O_WRONLY), EACCES,
-		     &quot;Denied write access to ./restricted&quot;);
+	TST_EXP_FAIL(open(&quot;restricted&quot;, O_WRONLY), EACCES, &quot;Denied write access to ./restricted&quot;);
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
I'd keep this one.

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap=""> 	exit(0);
 }
@@ -89,7 +86,6 @@ static void ns_level1(void)
 	write_mapping(level2_proc, map_over_5);
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap=""> 	TST_CHECKPOINT_WAKE(1);
-	tst_reap_children();
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">Well, test works without it, but not really sure if it can be removed.

Kind regards,
Petr

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap=""> 	exit(0);
 }
@@ -111,7 +107,6 @@ static void run(void)
 	write_mapping(level1_proc, &quot;0 100000 1000&quot;);
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap=""> 	TST_CHECKPOINT_WAKE(0);
-	tst_reap_children();
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
</pre>
    </blockquote>
  </body>
</html>

--------------IKSv2oEw81ra0H0NNUYRx1dS--


--===============0943207696==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0943207696==--

