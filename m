Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3CC2C433EF
	for <ltp@archiver.kernel.org>; Fri,  8 Apr 2022 12:46:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 853D83CA511
	for <ltp@archiver.kernel.org>; Fri,  8 Apr 2022 14:46:56 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 71CD83CA4E0
 for <ltp@lists.linux.it>; Fri,  8 Apr 2022 14:46:45 +0200 (CEST)
Received: from de-smtp-delivery-102.mimecast.com
 (de-smtp-delivery-102.mimecast.com [194.104.111.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A95DC1000D55
 for <ltp@lists.linux.it>; Fri,  8 Apr 2022 14:46:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com;
 s=mimecast20200619; t=1649422003;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GwbaJDxmtX1gwKX6AgmZJSCaGABqaGp3onIZiX/We9Q=;
 b=XGNBAZajDpjt2KJmYlQAfx/EuBw0Jt3wXYGHyxeaxKdiIIVgNbijQja5nq9YJadi3P/lk/
 0bqw6iTyvRemKUUbLukRpKVzPyKv23bgYXOHrzNOjJOhX1PsMu/fzDHjoS3U27tXASeZlj
 wwSIxQ8LzR5KIgqPYrzrv+2iHm2zdCw=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2110.outbound.protection.outlook.com [104.47.17.110]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-18-UeLSQhmMM1OdzTR4kFJmYQ-1; Fri, 08 Apr 2022 14:46:42 +0200
X-MC-Unique: UeLSQhmMM1OdzTR4kFJmYQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cH31f2FXRCI/K7egaoRsGsZPrcArqXmX7bi03pNDOf0c1vV9hc2OHrFVXopwd8VwqZeYl4XBsSBP6DeO0n1EZmvJA/uL4DTTNPFNaQLZD3LkIaxzPS0SjamdLVxa8QCKCaQlkooGWeSrYshuFCKCq0vMVyQsXnba7oJBA20ubwcsgzzXoyjL/Ng2Q6OaYk8C2obOTMAwOiNWfYYbGxXNlWP8RHckGihSB+jW2i4IIYUPUZGzDxjFld1kbCzqr9KVuALzvlJ1eFgzHRIua+5yn4/De0y0i25QABP+3P06aWbtg/m1wvwRBeJDBnWxeUGJGVpVB6wPP0h6Upt9mjX6sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GwbaJDxmtX1gwKX6AgmZJSCaGABqaGp3onIZiX/We9Q=;
 b=T5gwsyEDwCjaggJsAedOIjYHIvWrs+BLQLxrJ3EtVn+ykWkGWMta82m52RxzG0y1TZUDYTghN7aIo+SBy8VtAOXkoXkl5eGt5ItfBNJf5EKnkpviKGkfYQiw4zFcrmSyI2Nin17+dH5qSAXRzAwbdoCZ9fNBJBsKfWLwVjrgoizb4gCI2h8Rx7qAzDVbbw/qJ73+v+HoK2OMVIIWOIfuvUsY+Dv0eVQXGdWSKlLBFiZ+6ZVyVoAHgx4jDE1XcRHJpJPCxE566B0vAi1xgxR6WaHRSc04foZGH0/Auq/u1NVPxqnHhKWNRscFEq8hO56Hl55D3MbaQQIIeDy0g1WQ0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by AM6PR04MB5526.eurprd04.prod.outlook.com (2603:10a6:20b:9b::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.19; Fri, 8 Apr
 2022 12:46:40 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::1504:3316:3ce:7b0f]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::1504:3316:3ce:7b0f%5]) with mapi id 15.20.5144.022; Fri, 8 Apr 2022
 12:46:40 +0000
Message-ID: <2b8ce3be-a5da-8555-65d3-31765a0c766f@suse.com>
Date: Fri, 8 Apr 2022 14:46:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To: Zhao Gongyi <zhaogongyi@huawei.com>, ltp@lists.linux.it
References: <20220408091733.15323-1-zhaogongyi@huawei.com>
In-Reply-To: <20220408091733.15323-1-zhaogongyi@huawei.com>
X-ClientProxiedBy: AM5PR0601CA0048.eurprd06.prod.outlook.com
 (2603:10a6:203:68::34) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b74c181-38b1-4c61-2517-08da195dd392
X-MS-TrafficTypeDiagnostic: AM6PR04MB5526:EE_
X-Microsoft-Antispam-PRVS: <AM6PR04MB5526115A92EA3CBDDE70083CF8E99@AM6PR04MB5526.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: crK9nbNacDXBKlctNH/DNGdiHdSWqS8u0Cgl83ZnMnCwuWSEs56CygI1bcYpxxkZ9QqVrfKujjgA7kE6HI60GtkJklGkQ6PdOsP4+sIKquqkPJ9AWBIgK7DkRZL8EnWAaiKM/ZavQrK5H7o2JHoycSMsZi9cMOPCinkIN5qcFzn2NA6KFrIUhEtO0vDl4Ti6APzovqFyaUA3U6a/ISlffI5V7yC38/tetAlXUH6QQVAgyWYt2rQrBcf47SZa1hm7lfIlNTxZ364581HLphxGo9/zjeGy52YxGeG1fLCqGI81YesnCHo8aOwTumavk043E3PBy2SBGvQvtQfCHTyL7+F9TC7aFKeuNiMK29BydAUfWkulgQWOoyQMEHtmc7g7sRA9ISmpowxTUV14v2Lo14mKPYANDC+S8Uflo1x6VFJ+dnn6C7GVF6dwTNmEB5j1lZUkTU1f8rWUOTCVQStpIz7QYQu/MVKaX6YjI0bpjZ2WFnGE/SuelWaA+ixLdEOnvfk9L/e/pBJSplVpvfkl/HhPyGmosjBECtp7TJiRMlaIG95WhCZHhsjC0hSYkuZXtF3IcsocWxaLy+cmKBOG1/r+lk7KpaVqjmJbqUOapsSNt5UNX56JlnNiv+PROwfa78fhmc0KYjj/6x3gfapUixUzUXxAjr3wTcFXU4ZVv8xJp62MS5KJdMMgrKXPW6VT8ED8LgekuljMVg5XrM+4MZSGCbkvvfcTOiC/xSeSufdrWvCB7N1YbEaswV7IEaJlbVdrrtUQfTp2urbmJgvihu+e02UwahmVUZnGqNjqTzpsUwSGVMwEocjlChF3qABE
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(966005)(166002)(53546011)(33964004)(8936002)(2906002)(6506007)(31696002)(5660300002)(186003)(508600001)(26005)(6486002)(86362001)(44832011)(6512007)(316002)(31686004)(2616005)(38100700002)(36756003)(8676002)(21615005)(66946007)(83380400001)(66476007)(66556008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVlqeXVsY0dRN0k1YWtuZ0NmeTFZZkdrcDc2NXZCMG1MczBkaldiYjI4RjR5?=
 =?utf-8?B?TTdxUHh2aDQyYi9BUGR5blJkRlFYM1NJd3JPRjRaV1NndG5uNy9UNkVrZjFF?=
 =?utf-8?B?Rk9hcmFlSVF4S08vZ0ZBLzBYTDFIZ0REcFlvTEdzUDhJazhqT05SSnpUOVlR?=
 =?utf-8?B?bE5lMFB2QjhwK1F1eUsxcmVWYklrMzJ4VnpsNTRjcFF1eTNnTk9LMDlpYkc2?=
 =?utf-8?B?KzJ1Mkc4dTFVSXkwS0hqT0NKa3h1dEtpbjc4ajZ3bnF1Yk5pZnJseXlKODZy?=
 =?utf-8?B?NzJsRkNmbWM3aUJmYk1hZWZuT3k2RCtOaGRQbklMUENTUG45TVhQbmlHaFEv?=
 =?utf-8?B?OGZGUHNlUGVralFBSDhHcUVyQUNKc2p3YVM1MjBwZnpLcVR0VkNDbE4zc1Yz?=
 =?utf-8?B?Ym03b2dabTNpNjRiNWVyamswcjVFRURiY2ZXUmorakptZHR5NVRTOGRFZ09D?=
 =?utf-8?B?bDJOSFhjd0I0bFBxTm9CSS9HNSsvb20yRjdnUzUyK3pkVVpWeEhCQzgxL3J5?=
 =?utf-8?B?ZTVCZWswRDZibGoxVk5mVWVldThjTUpJTVlJRm9TSkJxYmszUnlXUDE3emxD?=
 =?utf-8?B?NVhmUkE2UFQ2anNCN0c4Wm02eU56RWhxSVRJNlBiVUpBUXh5ckVaQ2kwYXRs?=
 =?utf-8?B?N3V1bnFkTnVjbmZNQkN0YnRKQ1E4NVExT3NlTGlOY21QQUw0K0loNGhvWlJM?=
 =?utf-8?B?VXRacUQxSUpvSUJSRnFiVmcwNUVGN0MxcU4xaVlNMGh5SjBlVjZ1VGFta3VJ?=
 =?utf-8?B?Uk9kaDdLak4rYVR4Uk91YnZLMjFNTGpEL0EzYWdYeVE1TFcyMXg3WFkrQi9C?=
 =?utf-8?B?ZWN4UC8zMTl5TmdjMm9nVlVxVlRlUkxZOG45V1drZ2ZxaDM1VDIydmY5WDZM?=
 =?utf-8?B?aHAxOUpYRzZHRjBtWDZKYVRRSXVKeWNwOVZTcmZmNXFrRnpYdGdXV2lXaXFm?=
 =?utf-8?B?NHZaT2Ezbmd2Z0l5aFZNbHZKeHB0Z0k5aitkcXNTYkhnTHg5Y3VxWDc5RFZk?=
 =?utf-8?B?dHRmTDVzM3kvWWQrS1VER2N5K2MyL2Y4d0FVSkFPdENBZmhMa1ZlS2t4MXBu?=
 =?utf-8?B?Y0NXTUtCdUZONjZQTjV5TEluRFZaMGgzZnpmN3hyN0NPY1g3c3l4TTRnVnJX?=
 =?utf-8?B?bVFMRDFGTVJ1aTBuR0xidmJNR3BRVzdIeFBjWEhsNWx2dUNFd0NMN1B6ODBp?=
 =?utf-8?B?eU9BVUZlUlZ3SXF3N2ZtZVNVaU9KcnJzNFVnbXkxQUJ0RzVUeUErS1lTbXdJ?=
 =?utf-8?B?cFZjaXA5VmpkTjlpazErZWhnMW1mZlFXZkYrWXowUmJ4NVFIakNMbTJsamNH?=
 =?utf-8?B?ajdUSGVOMVRjTVhDeGFkWWhaVFRCcFVDR05PdTFWQ0lrREcwK3VhQXZ0dWhH?=
 =?utf-8?B?d0Y0WURqU0hFL1pKMGpRVFNCWFFnNUtZR2RhVTdGa3FDT1pkRndGcTIxYTE4?=
 =?utf-8?B?NHdRbExmQkNKYm9HN0x2L0F1a0dRNDVhSjYyZ1h3RzdZbmZGTWZkc3BuWDdo?=
 =?utf-8?B?RmNpMWM5THhFV0FvRURLWkk0ek5iR2MzMlZ3TGdQOE5oUVlIK0gveTVQWFVO?=
 =?utf-8?B?aERXVGl1L25DSXoxOFVWbnBLV1JzR3FJOWFpcENMZEZRckd6VXhUY3crNXZZ?=
 =?utf-8?B?L1R5bTVrckZjWlNpd2hHMFB3QjNPVkxsV2k2WFhrZzB3S3JycXNUakxGTFUv?=
 =?utf-8?B?cU1qV0ZoL0E0Q2dpTU5EdkVkakxqb1hrNlZtZmt3bVdWUTJiRCttMDhMQnl6?=
 =?utf-8?B?OXRXeldFcHhRREFaUzFTUm14VC9VWWlOVk0zT1pSb21jMFh1NXRuTFZMWVVw?=
 =?utf-8?B?SS9VUEU2dzlCOXd1OVU2bTNXWDgxUmxkbjYzNHYyM0swcy9lRUhReHY5YUsx?=
 =?utf-8?B?ZDB6bGovUzRsRStsd0gvMEhhVTNqcFNiSVVWWlQrWEZxQ3NKa1A4cXRNblAx?=
 =?utf-8?B?RU5Nbjg5ZmtDc2xHWFZMNldkeGp5VU8yWFNSTE5DV1dEbHkyUUYycE9sZlFx?=
 =?utf-8?B?dkcvMnJvUVg2b081L0IvMlpBRkdvUjE4c0dFYWlhMUhaZHdscVFaU0c1M1U5?=
 =?utf-8?B?TUp5MXBBM0JRZG5NRHFtY1dSM0o1MWFqTzBiSUdOemtjVHdCNjg0elJnT1hU?=
 =?utf-8?B?aVBHbktYVFBkOXkxUER0V3IzUEMyNnM2R2R3OXBLSzJleis5OEY1SldKTFRj?=
 =?utf-8?B?bE5rQ0NqNmVQRjJXRktEdVpFVk1MSVNkZXl3MjVIUnVQVGZhM25MR1RyajQ0?=
 =?utf-8?B?a1ArekpBNHNZbkxmWXJuK1ptRjc3NnM0K2s3UzRDVlJXRmhDNm5idE8xSjZn?=
 =?utf-8?B?Zm5aUnBDK1Fpa3Z0MjVubzUrbGNKaWIwOWY0SkYzQWQvSXJZTmx6R1VTTi9K?=
 =?utf-8?Q?c1hKt5EDPaw7AD6k=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b74c181-38b1-4c61-2517-08da195dd392
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2022 12:46:40.0131 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wqNLubzWsle3baaIkUtckPbBrGrrJZL96kUdKH7lFMnShv7MDxydZPhr7CS0iqL/fdt5vNOs6XmaF9bMfH9jgEY8u8ZyQkckipTcR2HX/QM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5526
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] futex_waitv01: Add test verifies EINVAL for
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
Content-Type: multipart/mixed; boundary="===============0850640124=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0850640124==
Content-Type: multipart/alternative;
 boundary="------------rLfYP8H7GaeUh98SVmAo5mIi"
Content-Language: en-US

--------------rLfYP8H7GaeUh98SVmAo5mIi
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi!

It looks good, +1

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.de>


On 4/8/22 11:17, Zhao Gongyi via ltp wrote:
> Add test verifies EINVAL for invalid nr_futexes according to
> https://www.kernel.org/doc/html/latest/userspace-api/futex2.html.
>
> Signed-off-by: Zhao Gongyi<zhaogongyi@huawei.com>
> ---
> v1->v2: Check also lower bound that suggested by Andrea Cervesato
>
>   testcases/kernel/syscalls/futex/futex_waitv01.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
>
> diff --git a/testcases/kernel/syscalls/futex/futex_waitv01.c b/testcases/kernel/syscalls/futex/futex_waitv01.c
> index 601fee8df..721852750 100644
> --- a/testcases/kernel/syscalls/futex/futex_waitv01.c
> +++ b/testcases/kernel/syscalls/futex/futex_waitv01.c
> @@ -98,6 +98,19 @@ static void test_invalid_clockid(void)
>   		     "futex_waitv invalid clockid");
>   }
>
> +static void test_invalid_nr_futex(void)
> +{
> +	struct timespec to;
> +	init_waitv();
> +	init_timeout(&to);
> +
> +	/* Valid nr_futexes is [1, 128] */
> +	TST_EXP_FAIL(futex_waitv(waitv, 129, 0, &to, CLOCK_REALTIME), EINVAL,
> +		     "futex_waitv invalid nr_futexes");
> +	TST_EXP_FAIL(futex_waitv(waitv, 0, 0, &to, CLOCK_REALTIME), EINVAL,
> +		     "futex_waitv invalid nr_futexes");
> +}
> +
>   static void run(void)
>   {
>   	test_invalid_flags();
> @@ -105,6 +118,7 @@ static void run(void)
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
--------------rLfYP8H7GaeUh98SVmAo5mIi
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><font size="4">Hi!</font></p>
    <p><font size="4">It looks good, +1<br>
      </font></p>
    <p><font size="4">Reviewed-by: Andrea Cervesato
        <a class="moz-txt-link-rfc2396E" href="mailto:andrea.cervesato@suse.de">&lt;andrea.cervesato@suse.de&gt;</a></font></p>
    <div class="moz-cite-prefix"><br>
    </div>
    <div class="moz-cite-prefix">On 4/8/22 11:17, Zhao Gongyi via ltp
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20220408091733.15323-1-zhaogongyi@huawei.com">
      <pre class="moz-quote-pre" wrap="">Add test verifies EINVAL for invalid nr_futexes according to
<a class="moz-txt-link-freetext" href="https://www.kernel.org/doc/html/latest/userspace-api/futex2.html">https://www.kernel.org/doc/html/latest/userspace-api/futex2.html</a>.

Signed-off-by: Zhao Gongyi <a class="moz-txt-link-rfc2396E" href="mailto:zhaogongyi@huawei.com">&lt;zhaogongyi@huawei.com&gt;</a>
---
v1-&gt;v2: Check also lower bound that suggested by Andrea Cervesato

 testcases/kernel/syscalls/futex/futex_waitv01.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/testcases/kernel/syscalls/futex/futex_waitv01.c b/testcases/kernel/syscalls/futex/futex_waitv01.c
index 601fee8df..721852750 100644
--- a/testcases/kernel/syscalls/futex/futex_waitv01.c
+++ b/testcases/kernel/syscalls/futex/futex_waitv01.c
@@ -98,6 +98,19 @@ static void test_invalid_clockid(void)
 		     &quot;futex_waitv invalid clockid&quot;);
 }

+static void test_invalid_nr_futex(void)
+{
+	struct timespec to;
+	init_waitv();
+	init_timeout(&amp;to);
+
+	/* Valid nr_futexes is [1, 128] */
+	TST_EXP_FAIL(futex_waitv(waitv, 129, 0, &amp;to, CLOCK_REALTIME), EINVAL,
+		     &quot;futex_waitv invalid nr_futexes&quot;);
+	TST_EXP_FAIL(futex_waitv(waitv, 0, 0, &amp;to, CLOCK_REALTIME), EINVAL,
+		     &quot;futex_waitv invalid nr_futexes&quot;);
+}
+
 static void run(void)
 {
 	test_invalid_flags();
@@ -105,6 +118,7 @@ static void run(void)
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
  </body>
</html>

--------------rLfYP8H7GaeUh98SVmAo5mIi--


--===============0850640124==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0850640124==--

