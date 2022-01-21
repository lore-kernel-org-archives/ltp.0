Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AC4AC433EF
	for <ltp@archiver.kernel.org>; Fri, 21 Jan 2022 14:30:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 76ACB3C9708
	for <ltp@archiver.kernel.org>; Fri, 21 Jan 2022 15:30:08 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5C0073C96C2
 for <ltp@lists.linux.it>; Fri, 21 Jan 2022 15:29:59 +0100 (CET)
Received: from de-smtp-delivery-102.mimecast.com
 (de-smtp-delivery-102.mimecast.com [194.104.109.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 8AC43600D2F
 for <ltp@lists.linux.it>; Fri, 21 Jan 2022 15:29:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com;
 s=mimecast20200619; t=1642775397;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rYCezJTPi3iXaZhzk4hDNcpECMkbH7h70OetEjvgKZI=;
 b=M3fbwtznuCYzZUjDGdCV77FOqPtf+B8EsqVbPTS4kzneoouDQkdZ6bM2XF/fQPe9HkOb2j
 l/oACgy9atKaPH/PNP3eGFQm0+mRvUA/IVHCQchP/umoYF5RDko/O/AUNYmRJz8Xy13Wgx
 pLk9uEyUIwH7ekZ8Vv7dsCAOmsyF9LI=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2170.outbound.protection.outlook.com [104.47.17.170]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-27-tbo0ItQDMbaOGJr-BsCYjA-1; Fri, 21 Jan 2022 15:29:56 +0100
X-MC-Unique: tbo0ItQDMbaOGJr-BsCYjA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J5ebhb8QesW/6S2Ms2M8bcOVS7RDLqz03kciu/T42pVcvEIjw4sElkRPKcVZZ/5Npyo6w9kVAbyNwbSR9bZ2OVyd0dCJrY/QvyTx+e56mYoIawltirYQ+NVeILel6fZpIBZkDFbUdQdLOYg0inZDMeTqRYXGt7vlgTML0BysP5Cp2uGSDeFYzdxVnl/r79wJNzBKWmHXkHRLVzeElU6DhHidbDSkAekKBH/SVCRlHWZ3YISfTJsQkKsZGsZDc4UVjOqhadccLERx1TjCpvAV7Stqi+8Hj8JcdkU6+VYHNkC08EhzRm07BoZ7muwjUPLt09dcORGaTrVIvV7LcmqFuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rYCezJTPi3iXaZhzk4hDNcpECMkbH7h70OetEjvgKZI=;
 b=jZBEwPibNg/tY6wVqZ2IXxOQcaKA72lqahEf5lOFatcUOVsIJSznqbreG+ft6PyFeFx/Olc4K5VBx7Fd/biflBBuolgV1mnVnQl7RoYvuL3g1QknxDLjDsSX7YpO3CQ4i3qN4lLYCWuYS6NsaBLnuWvHTrxzr5yvRQKwm92y9MzlBh1EtTZvrGrSGLXDxcTtw9VPBaOmYNYgfU0PEQ2hE5gv+25TEWWQq6bbp+6PEjPrxSnWiHWG6Xyt+9s3tolFBZs1yGkvsbRN5RKAv2r0aBeuK0QCZSHzxMHzsBFOz4upbHjPdxWZiA6CkPTUdh+8zr/kxIFOmZhjJ1d8Q3TTgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM0PR04MB6788.eurprd04.prod.outlook.com (2603:10a6:208:18e::20)
 by AS8PR04MB7719.eurprd04.prod.outlook.com (2603:10a6:20b:29a::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Fri, 21 Jan
 2022 14:29:55 +0000
Received: from AM0PR04MB6788.eurprd04.prod.outlook.com
 ([fe80::1c48:b656:15bb:a794]) by AM0PR04MB6788.eurprd04.prod.outlook.com
 ([fe80::1c48:b656:15bb:a794%7]) with mapi id 15.20.4909.012; Fri, 21 Jan 2022
 14:29:53 +0000
Message-ID: <790735e3-6062-abcc-4358-71cd0fe34c0b@suse.com>
Date: Fri, 21 Jan 2022 15:29:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
References: <20220121134052.30048-1-pvorel@suse.cz>
In-Reply-To: <20220121134052.30048-1-pvorel@suse.cz>
X-ClientProxiedBy: AM6P193CA0117.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:85::22) To AM0PR04MB6788.eurprd04.prod.outlook.com
 (2603:10a6:208:18e::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d018eee-0e4c-4f05-4ecb-08d9dcea7d7a
X-MS-TrafficTypeDiagnostic: AS8PR04MB7719:EE_
X-Microsoft-Antispam-PRVS: <AS8PR04MB77191E7779FA3577A3674E7CF85B9@AS8PR04MB7719.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:121;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pxWAcA+CoxKOnzzOkVPUe5Po9ddrjG5R/lXFhJZ6hHfK/599XoAa3AYo6wGSXID79msY1f2lbCDphnbEThlbnf86zNpgyVSOvSbz2YerHzY4Imga5yyRT2SoXzCEAf1t6ZZzdoLx0M8CJ9uVoeLpaP91qruLjnWjllyVRc3TCNN2056GtPU78/A7N+tjAx4qswtA7SpLIld0JddhsKF7z4Aaem8BG46l/sM0fX32wL57eYtq0DhjlEYg4L1ZXzziXD3NluoA540NPXO5CkIP3DveFG04blZlRpu5o2V2DxSBoABLGi/XQ61rMib5zM/G0U9Bu6ezFUU4dqSmYWNYOmFNBgEJA2/CPg99JIrso0tuSuffWWDaU1YAu6MKH+9bWEPIAtIdtp8eWh67R12M1qUYj7KSymYI16mBqAoFdn67dPe+aATpTKpKwBSavZZHVMZ+lgjJ+8c2wgFbcrNwFedHhEwcvzl9mW2fHBc3sgUI1kwCMgHyhPGA/nFqgyIK+J+PWtSyXJ9EkBn2Zlqvn0IHAEVbpUS1SQ3KCuoPt5ij2wPftwla1j9AYU/3RDo0IaeY6m1Rp7Bkc+kpEnbBl7+Akq0dchKHZ+x2wvzR557pjbicRkWc65ouFi4YYTEjsM5+nJ/6smnkPNq1CuuoZ9o9KRQ22y83eG4s4MALps5vhfKCmrFTTMFq2wO0Uuts9DJHgp0uTC1GtwbLulDhDvlEQhjt9Vdjf2iIKrUYtoi+8ULr5v6qrPmUyg3NKD/uL6DPmJWKy1+kFLqUCvnU2w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB6788.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(38100700002)(66946007)(4326008)(316002)(66476007)(66556008)(31686004)(83380400001)(6486002)(53546011)(26005)(44832011)(508600001)(6512007)(8936002)(2616005)(8676002)(6506007)(6666004)(86362001)(186003)(2906002)(36756003)(31696002)(54906003)(5660300002)(17423001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZjluRVlsZ3NMQnBXNGRSQ1N5b0k4ZmtxcW80RFUxVFllbXBaYk5XdEJibE1Y?=
 =?utf-8?B?U2VMaXdVWjgzOS9CS0JLamlQWVVqMWFpNUQwbDRiWCtPZ3lzN1pUcmJtblFq?=
 =?utf-8?B?WEU1bWNENXh2NTNtVWJ2MjN3WHhwZUZRYUxBSWJ4djFkS2NPZFRKbUovUTdQ?=
 =?utf-8?B?eU14STRIN0xXS3JwMzR3QmllblZ0aHVRUUJEWGJNUnpiNGU3UlNya1FTMU56?=
 =?utf-8?B?WExQUlpYWkZUclo2Q2l5a1lESDFFWTI3Ync2dy9pOE1EdGZ0c3FORVVTTFRJ?=
 =?utf-8?B?RW5yWU13SE5aR3JFUkQ3c0ZVcFpFMENHTGxUZUMzYjMrQ25QZjVqcWRvNEJX?=
 =?utf-8?B?NWN3dEk4RS8yTDNqdnllUWM1QTdCVFo0U2dXd09tOVpFR09ueWlUTVpZUFdG?=
 =?utf-8?B?ZTNKZ1BvY0VoSzUyZk5McmwzVzlyYkI1MHYyaUlRTzdEdXFxcnRuWjhxQWFN?=
 =?utf-8?B?ZG9KMjhNamhsMWx5ZVBUVWFKeW5uUTBZZmp0TDVKWGNkNWM2Y2Y1UGxLNmlM?=
 =?utf-8?B?TERWYlIwWkcwb01QdnBHNnJBY25YOURkcjhzK3pvOG0wT0VzMUJPR3BnR0JK?=
 =?utf-8?B?RCtGZWJ0alVWNG50MHBPbXFPZngvYnJYeW9lRmxKN2lKTHAyWUo2bXI3K0pz?=
 =?utf-8?B?aGZzRFArdVUvdUJDUjg0c2ZkS1pxMGszNzFZU2ZwWUZOV2N3d3FibGlXMmtm?=
 =?utf-8?B?Qkh3OWxSUEkzWTJ3ZzhOYzhyQm5vZHhRSklxckpsVnA0QzBsRXZpd3FvVVR2?=
 =?utf-8?B?YzhMbk5RN3dpeXp0c2o1NGM4WWwxcXptN3g5dzZvb0RKbGZabjgzRkhuMWJF?=
 =?utf-8?B?a2g1OU5hSVJvN3VmU2lZRExjN3Iyblp5SEJSZnU5ckRLKytHbjNUL0VmTXJ3?=
 =?utf-8?B?eEMvTkU2by9zODN5ZVRIaFdqOG1lTWNWaDFJZGhsMDA2YnBmK0FlcTljZ3NQ?=
 =?utf-8?B?YTN3STNVNU5yRm1OeXdOangwc0lwNWh6eVR4QUxsNEZZQ0cwendNazl6Q2No?=
 =?utf-8?B?MjhWZi84MlVycTFaNU9RazRBZmYvVVdTbUJwZjlYK1dUeWxYRmd6R1BTU2M4?=
 =?utf-8?B?WTVJaExXaVVma0RraFdOZlNMT3NaS0h3TllUWkU0TGJ6MHdiMVdpR2ZLNVJ4?=
 =?utf-8?B?aXV5TzAyZDVndStSUjZUdTBTL09MNjE5NEpEcmI2UVQvRi9RT0FhdU9yRG80?=
 =?utf-8?B?SFQzZS9lU3Zab3lvRzRkSVlSeVJPZ3Vwd0VvcXZEcXhtNE56aTM5bVhTWjFZ?=
 =?utf-8?B?WDZOQjBhTVB3MDQ5L0UvNGROSXE1NWY3UDduTzBZUXJlN2tVcWtkQjJlbEZv?=
 =?utf-8?B?ZEhTT0FjMCtkMmZwdlN3VGYrdkI2c3hHNnNkU0Z1RVRNdEZCZy9GUmxyVkxZ?=
 =?utf-8?B?cWNHR09MdDRZYVNXa2pmTUNTUTFLYzRvcGhsZ1NqbGNyU3o4NTgrOExiQy9M?=
 =?utf-8?B?NEZjK0RXM0pzMHpieTZNU2MraHk0TXdFT2VtZWVHWEJ5MjYwamw4QU8zUXFz?=
 =?utf-8?B?UlpxbUdDb1J4NU9oSjZLeUw4ODlPVHZDRWZITU8yT1c5L1crL1NuQlpKOXd3?=
 =?utf-8?B?d3hyR0JVR2dZWnAwOUZrUmZjVmp6b3JXdUlUMUZmaEJtWXBBMG9XUmVXMXR1?=
 =?utf-8?B?ZVcvNVVNVW44NS9MK2lTZlBqQnpJL21HK2tBSjE1enV4YnhleXJCSFhHRXdy?=
 =?utf-8?B?SnJSblZXMk43eVlRNWhNc0tvejFEUTBsTHdXNnVBd1YyMmVhNVJMSjBrRVVZ?=
 =?utf-8?B?ZnRmYm5QblhVUGhHL0Mxd0NiSmZway9YZHNCbkJSc1I2UDh2WGJ6NHI5ZE14?=
 =?utf-8?B?aHV3eEl5NlBwQk1Ncm13SUdXTFhCN3kxV1V0YWo1Mks4aGFvOXYzWC95ckk1?=
 =?utf-8?B?Z0RyN0c1UGR6cG1PSk90ZitZVTVhR2V4MkNBOHBPQkM2a0N0MGU1Vno0QytD?=
 =?utf-8?B?S01HY0hoaDRDTk5mWERnVlV1SFRIRUdPZUd5UWF3NEhlTldjNEF5Y0NKRlc4?=
 =?utf-8?B?WUJNM1d6SEVvSm9QNnQybG9Wbis2K0IwTm45Nmwzb0tLYWZXR0ZTZUl4Vi8x?=
 =?utf-8?B?dTFGUXROeXIweklZNnd1WjFOTVJIQUhIV2lGMDNHUk1VRm9LU1pzZ2hxZDdo?=
 =?utf-8?B?RE83b3RBUDhUL3VyMVBIcHR3QUlaWkJoSmllTHFGWk0xM1hjVHpEVytxeGxI?=
 =?utf-8?B?VElxcXVuV012OUcwVXE2bTJZenBOamxKS0NMLytkS00rNTdjYkViR3UvWito?=
 =?utf-8?B?bGxxc2Z5dlYyWjZWK2t1RHlJcXlBPT0=?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d018eee-0e4c-4f05-4ecb-08d9dcea7d7a
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6788.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2022 14:29:53.6667 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LptUacBVCB9MZks9Bf1MDPdbjOjyaRWPmGAzTp3QsAmlBLF9Xye7n6wIAVW9d+MfkjXUxuuIi5oxSnCriob6hIZ6ucqBPSGq8CRqEV102vk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7719
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [v2 PATCH 1/2] aiodio: Skip tests on tmpfs
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

Acked-by: Andrea Cervesato <andrea.cervesato@suse.com>

On 1/21/22 14:40, Petr Vorel wrote:
> tmpfs does not support O_DIRECT.
>
> Used only on newly rewritten tests (old are currently using hardcoded
> paths in the runtest files).
>
> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
> Reviewed-by: Martin Doucha <mdoucha@suse.cz>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Changes v1->v2:
> Fix commit message.
>
> Kind regards,
> Petr
>
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


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
