Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80E22C433EF
	for <ltp@archiver.kernel.org>; Fri,  8 Apr 2022 07:54:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 29DFD3CA4F3
	for <ltp@archiver.kernel.org>; Fri,  8 Apr 2022 09:54:46 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6B9273CA4D1
 for <ltp@lists.linux.it>; Fri,  8 Apr 2022 09:54:35 +0200 (CEST)
Received: from de-smtp-delivery-102.mimecast.com
 (de-smtp-delivery-102.mimecast.com [194.104.109.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 7F9D0200C91
 for <ltp@lists.linux.it>; Fri,  8 Apr 2022 09:54:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com;
 s=mimecast20200619; t=1649404473;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0/d72aPknmSWvfidkO9Nx8ema6rMx3/1m85YYbIZB/Q=;
 b=gABrv3JHOZCfS4qWvhTelc0pflqAg2uIc3b/qycHNomjARntPgqtKehtA/zgJDe1FtESDq
 WwS3QkqlIXvQodMDkeS0qEclPNfg98UkKr3m+Bhvb3UrP4bOrz8nffs6O8bSYApVj/VITP
 oFoxRv4Zwe3vL6ruNXMWSKSAjhWawiQ=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2113.outbound.protection.outlook.com [104.47.17.113]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-41-ab8dICJkOv6-8_Uj4iDdqQ-1; Fri, 08 Apr 2022 09:54:32 +0200
X-MC-Unique: ab8dICJkOv6-8_Uj4iDdqQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ID5yxOmWosOnkh7/4YaErw1grdIUnFglODJog1PJsacLN0QeO80UGVTeWgc+pMnp50u6QXb5BROuXugu972knp6eYn0VOqQPgPYHIMHyjiHSil4w/JECOdistQA6R7dlzzOvKQdPN+GDimS/s/by0UloEoGE2pg2buVe0qM4Rs/hBiXpD+Fj7V45j8mnkWmyYCtWlo0yGnF8gCuNcwtjkkbVgWd+//ntVOMdllrRlbAtMzf2ZcVEoYPHt4RSuYOGvDNFx4S/cVz3jPBo/saxddzQ6D+K+aUsmeaAFaWFrHgox2Cn1jf5ofBgPOCoE4kvAVHIb4AC/FtSolwTl3y4jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0/d72aPknmSWvfidkO9Nx8ema6rMx3/1m85YYbIZB/Q=;
 b=RsW0/tK7jhxWf0Zcz+b8CgXFOfXPVT8Mg4EGMLJxO3g6KNJeleeK9vfTL49VrR6HnRVUoSN3w+UQi8mUddA8SkH7+VrCYWkBlYKyx6qlI58O9YNYkKTFCXpqnE3L0H24WDQ7qUtJ299rAk+UL4w20pVyjYHVEjAMavBOcakHmbM77lD9tsNFPh5UgRHC7FLVCeJAh/MXPLMQ5toV2WUIYCftA6GEw/R5/MSJ1qpGlyP9pAptVn/YJmeHJXyO1RGrIYtTadLszAOoRMmloQIeJa4Bl8aoLWXnw+VhoSawtWXHCOI9xFdA4JBFKIk0Hgo8RPavksIhjEoJ1lQ/Ksi7yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by DB7PR04MB4777.eurprd04.prod.outlook.com (2603:10a6:10:15::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22; Fri, 8 Apr
 2022 07:54:31 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::1504:3316:3ce:7b0f]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::1504:3316:3ce:7b0f%5]) with mapi id 15.20.5144.022; Fri, 8 Apr 2022
 07:54:31 +0000
Message-ID: <450ea258-adea-3df6-d929-eea45378ba51@suse.com>
Date: Fri, 8 Apr 2022 09:54:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To: ltp@lists.linux.it
References: <20220407075758.40561-1-zhaogongyi@huawei.com>
In-Reply-To: <20220407075758.40561-1-zhaogongyi@huawei.com>
X-ClientProxiedBy: AM6P191CA0100.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:209:8a::41) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 47154710-1d80-472c-67b6-08da1935037a
X-MS-TrafficTypeDiagnostic: DB7PR04MB4777:EE_
X-Microsoft-Antispam-PRVS: <DB7PR04MB477783DA4D2DD176CA37851AF8E99@DB7PR04MB4777.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kvtE7zh7IQVRIzE3UXNGZI9t+O1VKzGBdk+N6aqP8WUBnizt68NA9qM2mUWI0bDTD27qN5EgpuTrgDiA1kmRhCsaUrbE0VK66/4vkqF5+WWnSP/lcFj5MClcZ58ZqRpIDWqSvyzLw8HkUhYrh3VNV5WZmWj98W8fbe4xoRHv2Z3KKXwa1Wp/jCDBbWzbtMzyjjyGkHUXMTuAeicdfl+gc0LMIwjY4XrOzdUZVUKGbJxacGXrSwDn6h2HvzSceQLUaKiv8klpN57zN4vVHux4IgrxGNd/jXAFpu1xCM9rOYT7oD3o9Dhx1D6XCuOukXXnx8HrawRmXNtvkjKDszU3bq0SKvrKls6UsocZiIe7+CajIXfT8/ZelQcLnJvCJwQe/iXt1nAguBlwk2xxFPJf1uCWCupTgIUpgR0vwCcx7pPNmLOqzLLWojDZRtwPV/yR2xRN7ioNc7Movbr/5EMRKbsNgYmRoK5cdxJfP0HrlbmvTRJ0J9ac3dPDXR2QQEGi7X9R6hWkVvHJItUonZVPRglr37s7CRxHdfObhV+D8cgJHjsES/vkohLqLIRXTRoaCCXvbMhHp4THnZOupHdDozDo2PZ+5WI1Pe7cWizgBgrXYCeCDI6eZXplXtwJmsGee+fklpvN38YEkdzBxiH+jdmYb7cI1I5duodvqhPE0EMzdKx+RDYrUAx5KPB+BtIWHPoo5UL4goyQOKNAky0bI2SH57Fn3mE/j7QjY5HpCLmT2YP4gHdPZv7nBXBHYAaF/P4CCbn5n3eZQGU2zNPHrq4dXVaYMFci0EPufB1SHRhQoaUuOVw3MrHKYqouf8Je
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(38100700002)(8936002)(66946007)(86362001)(31696002)(53546011)(166002)(66556008)(2616005)(5660300002)(44832011)(2906002)(21615005)(6666004)(83380400001)(33964004)(8676002)(66476007)(6512007)(6506007)(186003)(508600001)(26005)(316002)(6916009)(966005)(6486002)(36756003)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0lwUjN1aUttaHpjdm1ReDN6TzhKbk5SRmNmRGJlZUZkM1hPTkxWeVpTa0pU?=
 =?utf-8?B?RWJRM3g2L3dWMEgvM3ZEYWgvM2QxcWNSZnQ2WFlrR2FFanFmbWZFMTZmMlBQ?=
 =?utf-8?B?cnEwbmN1SEFiQTE0aUpqeXJuZlJuZDV3b2JMTXVkazdNaTZ1MFZGSUtrbElK?=
 =?utf-8?B?aytVNkh4czFRT0M2dENZaHpaQ0k4cXNvK0ZNclFmTEhPOVlldld5amhZZ0ZB?=
 =?utf-8?B?WVQxb2dSZGt1SnRBT3gvaFliUjhDcXNZRnFEVDQwRGNCOGRwazNsdnB5OHR4?=
 =?utf-8?B?b29XT0s2UmZSMnlPb3Z5dDRuOVRIdkt2WnZJYVdRZGZIdUhoVGVsVzVPelJ2?=
 =?utf-8?B?M09KS0J1Nzh1NjVGbFRJc0s5QXhXTlZVQ2dqaTl6WlVIcFc2elpHNDVlRGpG?=
 =?utf-8?B?OWRGbFV1TlM1cmJzK244RERiQnJRT0NHUG9yelVsUW80UDZZcDgrUmtuTmJU?=
 =?utf-8?B?SEVVSDFYM0tQeEx1SlNzR0JUOWJVeVo0b21VMFVOOTNQdTUxd1FJSXFrdEFR?=
 =?utf-8?B?cVA3emNDQkhSMkdCVlVUNExRT3V3QTZUNjF6QVU3SkpHbk1hNC8xQkhBSml2?=
 =?utf-8?B?RnRnZWtiWFFCRkRTVStCbXR5ZWRrQS84RGkwS3hnam96cFIybHZrWHdXZjFH?=
 =?utf-8?B?UWNCMFNhdGZ6TFZvU1ZPdGFueklEN1pRbStISEZUMjBCVzNXdS9ZQXFrNXJq?=
 =?utf-8?B?ZUFmSmZiZVcyWGxOMEZoc3E5TlkvUE0wWUpyV2s4OElsSmJKVVpzMXE0cElH?=
 =?utf-8?B?Vy8rQmZEWlRyVDhrOTVZcEFKV0xRamVlbGMxQkQ4YjZFVFdqNnhtQW9HQkRP?=
 =?utf-8?B?L1pSbitKcWI3QTB0WkNnTytqeUZiN2tYWlZiRW5kRlF3aENlUzRoOUhVbjRL?=
 =?utf-8?B?YnJHTVVQQlhIUVZVRU1TSU14RnpTWUdVaFJka2lNaEo2NGlkRU1DNS96N3RL?=
 =?utf-8?B?aTJVRllPOEFRYlVFTTk5ME9KVU5SeHYycVhxeks3ZVVja2tXd1R3NTI2bW4z?=
 =?utf-8?B?UXlRVTY4cFpUWGdKRDBwUkZYMUNIVi9xQzU0Wk5MeDcweXhQeHJXaDJCQUhY?=
 =?utf-8?B?L0V6T25YOHB2cmtVUjJ0eW9GWDhyZzB3ak5uUEpGR3BpdEdjZHA1RENjMG9I?=
 =?utf-8?B?NlpqMlRlWWVpZ1VhOUFHOHF4TkdHSTY2dlZHdzVqdEx0T2xNOUI5UUJ2ai9S?=
 =?utf-8?B?bXdOc2Q4YXM5N2RhNm5KNEQ5NlZ5WkZqTFhxMGQrRGVOVkZHUWduLy9sR212?=
 =?utf-8?B?QW1HaEYrVjhvZDRMRDRTMDZ0eE1jSTZRNWhtUFZNdXBHd3d6MmpFZEJGTDNz?=
 =?utf-8?B?WWJ3SG96MjhUOUF1WnBrbVdJOUI0NEozeC9LNTNwNjFRNWgwV3lwMWxZOFpM?=
 =?utf-8?B?SGFXQnA1M2tUVEpmTlFteG93RTZYWDIyT200ZGl1YnJYWjdBTE1LTmFHRmpD?=
 =?utf-8?B?UFZHLzk1ZlVUdVpOMWxhZVlyVW5IQitwRWY1citHSko5Y3c5bXV1VTlENnJ3?=
 =?utf-8?B?SWlEZ2w1WEFGRXV2WUFrZ0o3WkM1cFVsTUdrVlU5aG1wRGRuNitaTlR0SlVs?=
 =?utf-8?B?UWhUMzkwQkQzVkVabmxNZUJlWS9odlE3UXJlQ0JXV01Ta1lCKzd2Yit5dWxR?=
 =?utf-8?B?MHVQVkdCU0tjNWtEaEZvM1p2OWhzZG1FMHZLQnpGbklDZVZvOFh4MkUxYjBy?=
 =?utf-8?B?WFlFcWVuQzA1a3dLeFNTYU1rMkdhTFEzU1Q1V0NQSVFiWE5BZm1QbmRUanZO?=
 =?utf-8?B?TFBnNzhIT0JhekE1L3RCS3hKVG13WkphNWY0dlpKdmU2ekNqaHg5eXZrWlJ5?=
 =?utf-8?B?SHlqeThxaWdRMkNPRkJtZDZXc0Q5RDVHL2E1ZzZFQmMrZi84dXZja0RQak5R?=
 =?utf-8?B?N2kyT1QzR0tQVHpHZlJhTnhmalNhNnNIZm5WdFViNCt1bUFVRHpvSjJtTEdv?=
 =?utf-8?B?NlR4RHBJelRGbjQwdXhiSVZjRkVJcWVoT1k2YURQTmlCV2VLTUh3QWxGNmZQ?=
 =?utf-8?B?UldmcWliSFFmU2ttakt5TmwvL3BHVnZaeWw0TTl5ZXRSMTNJMy9tTW9BN2Y0?=
 =?utf-8?B?YlppbGdiMEVhRXZKL3Q5N1ZGNTZxSnYzUm5ocTAveHNJbDd3bHkvSndqcWpp?=
 =?utf-8?B?KzNBOVNvRDd6Um0wbGJDVWRaMnNwd2RRRTJTaWtYVDcybWYwaFZqS3dBclJY?=
 =?utf-8?B?cmdVMTdTTTQ2cE9UMjB4Nzc5TGg3K3p1N1dGK28zQmxMTmlEb1VjanNiZEU3?=
 =?utf-8?B?TTZidk1DZFA5V2RoM2pHTHFub2F4TTdjNERqRmtFSjNxM2pOeEhqNmFMWjBu?=
 =?utf-8?B?TmJUdTJDck5hZU5hWEZtcUVYVmExYSs1b2JXOEtSK09rV0tOcVd4VVUrcHd0?=
 =?utf-8?Q?DMXliS7As4Od3slc=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47154710-1d80-472c-67b6-08da1935037a
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2022 07:54:30.9910 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qtuFCJE6YAa4wOqFva14jj0O2A/FKVZXhs2V342neOkoYChr4G8uWhjLJmIjXoui4XGFkXzK4Q0KTVQnaqz2T8ZWWkMrTDsau0jXyTmzOJo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4777
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] futex_waitv01: Add test verifies EINVAL for
 invalid nr_futexes
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
Content-Type: multipart/mixed; boundary="===============1605458611=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1605458611==
Content-Type: multipart/alternative;
 boundary="------------6goiteQikDElX1DWPaqzuiSD"
Content-Language: en-US

--------------6goiteQikDElX1DWPaqzuiSD
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi!

Thanks for the patch.

On 4/7/22 09:57, Zhao Gongyi via ltp wrote:
> Add test verifies EINVAL for invalid nr_futexes according to
> https://www.kernel.org/doc/html/latest/userspace-api/futex2.html.
>
> Signed-off-by: Zhao Gongyi<zhaogongyi@huawei.com>
> ---
>   testcases/kernel/syscalls/futex/futex_waitv01.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
>
> diff --git a/testcases/kernel/syscalls/futex/futex_waitv01.c b/testcases/kernel/syscalls/futex/futex_waitv01.c
> index 601fee8df..525420647 100644
> --- a/testcases/kernel/syscalls/futex/futex_waitv01.c
> +++ b/testcases/kernel/syscalls/futex/futex_waitv01.c
> @@ -98,6 +98,17 @@ static void test_invalid_clockid(void)
>   		     "futex_waitv invalid clockid");
>   }
>
> +static void test_invalid_nr_futex(void)
> +{
> +	struct timespec to;
> +	init_waitv();
> +	init_timeout(&to);
> +
> +	/* Valid nr_futex is [1, 128] */
> +	TST_EXP_FAIL(futex_waitv(waitv, 129, 0, &to, CLOCK_REALTIME), EINVAL,
> +		     "futex_waitv invalid nr_futex");

Can you please check also lower bound? So we'll check for 0 as well.

	TST_EXP_FAIL(futex_waitv(waitv, 0, 0, &to, CLOCK_REALTIME), EINVAL,
		     "futex_waitv invalid nr_futex");

> +}
> +
>   static void run(void)
>   {
>   	test_invalid_flags();
> @@ -105,6 +116,7 @@ static void run(void)
>   	test_null_address();
>   	test_null_waiters();
>   	test_invalid_clockid();
> +	test_invalid_nr_futex();
>   }
>
>   static struct tst_test test = {
> --
> 2.17.1
>
>
Otherwise LGTM.

Andrea Cervesato

--------------6goiteQikDElX1DWPaqzuiSD
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><font size="4">Hi!</font></p>
    <p><font size="4">Thanks for the patch.<br>
      </font></p>
    <div class="moz-cite-prefix">On 4/7/22 09:57, Zhao Gongyi via ltp
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20220407075758.40561-1-zhaogongyi@huawei.com">
      <pre class="moz-quote-pre" wrap="">Add test verifies EINVAL for invalid nr_futexes according to
<a class="moz-txt-link-freetext" href="https://www.kernel.org/doc/html/latest/userspace-api/futex2.html">https://www.kernel.org/doc/html/latest/userspace-api/futex2.html</a>.

Signed-off-by: Zhao Gongyi <a class="moz-txt-link-rfc2396E" href="mailto:zhaogongyi@huawei.com">&lt;zhaogongyi@huawei.com&gt;</a>
---
 testcases/kernel/syscalls/futex/futex_waitv01.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/testcases/kernel/syscalls/futex/futex_waitv01.c b/testcases/kernel/syscalls/futex/futex_waitv01.c
index 601fee8df..525420647 100644
--- a/testcases/kernel/syscalls/futex/futex_waitv01.c
+++ b/testcases/kernel/syscalls/futex/futex_waitv01.c
@@ -98,6 +98,17 @@ static void test_invalid_clockid(void)
 		     &quot;futex_waitv invalid clockid&quot;);
 }

+static void test_invalid_nr_futex(void)
+{
+	struct timespec to;
+	init_waitv();
+	init_timeout(&amp;to);
+
+	/* Valid nr_futex is [1, 128] */
+	TST_EXP_FAIL(futex_waitv(waitv, 129, 0, &amp;to, CLOCK_REALTIME), EINVAL,
+		     &quot;futex_waitv invalid nr_futex&quot;);</pre>
    </blockquote>
    <p>Can you please check also lower bound? So we'll check for 0 as
      well.</p>
    <pre class="moz-quote-pre" wrap="">	TST_EXP_FAIL(futex_waitv(waitv, 0, 0, &amp;to, CLOCK_REALTIME), EINVAL,
		     &quot;futex_waitv invalid nr_futex&quot;);</pre>
    <blockquote type="cite" cite="mid:20220407075758.40561-1-zhaogongyi@huawei.com">
      <pre class="moz-quote-pre" wrap="">
+}
+
 static void run(void)
 {
 	test_invalid_flags();
@@ -105,6 +116,7 @@ static void run(void)
 	test_null_address();
 	test_null_waiters();
 	test_invalid_clockid();
+	test_invalid_nr_futex();
 }

 static struct tst_test test = {
--
2.17.1


</pre>
    </blockquote>
    <p>Otherwise LGTM.</p>
    <p>Andrea Cervesato<br>
    </p>
  </body>
</html>

--------------6goiteQikDElX1DWPaqzuiSD--


--===============1605458611==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1605458611==--

