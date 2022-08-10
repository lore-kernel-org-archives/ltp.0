Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A95EC00140
	for <ltp@archiver.kernel.org>; Wed, 10 Aug 2022 12:29:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 11A283C94B0
	for <ltp@archiver.kernel.org>; Wed, 10 Aug 2022 14:29:22 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CDD0A3C1BEA
 for <ltp@lists.linux.it>; Wed, 10 Aug 2022 14:29:10 +0200 (CEST)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on2074.outbound.protection.outlook.com [40.107.104.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 889301A009BC
 for <ltp@lists.linux.it>; Wed, 10 Aug 2022 14:29:09 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hq8gs9GHsnIu0aHzqWTtMBAd0zMaAgQyBQTHu8ilfdAKY56lj99uVQZ+YMzYECC/19zVH7x8JlAt/3pNsaDHbyIuT7c/0sOL+6wl8XL2Cvmh4oMDr1nWyJwG3fAWowg7ZZB8WOuGZf+KQSkUnxAycsmI5FZtazPZqJpPBav1Q1ftUaDR9+k7QpDMCtWnH4szPAoWE6PBWfw4dpJhPXcdWn63/358g3C2YGFvwEm/UhNzh4WR4T9lCVIaK2D9sgoCNG1FyeNSo8tfusn/8U652N1/pYgDah8/PnPFIVDdwbePObTAIce1pMWVANrHmav6R52OW/8lcTTJ+untap9pnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+T+dNH6TXuJhauZbK4BFvgpDSri5LYbK8TLL2RBM8Jc=;
 b=MLbbQqudjh2tjkTmEpRytGLY7w5GoVWhmp0YGQFZ4Wm6nnuIqU8Gym1ptcaB9I2WDQ7JMbV8dJa0I2dawvb9kGfPfbh1odGbubMC9RCSQ6cvzxjwePx5ilsX/9XmBZyukhxvZcOp2xZOPbx4Qonq666XHd9tJDUaLRHtKhMDbrb8pMk3y2ItavUTz4sDKOfRZM2yK4L2BPFr3uoc2quBOwOOvsx8cxw9EOTPmg0jSgYeviHcfJM9Og3nLtDttZC5cQeg4E8m4ap65CU229N1KUa6+BfRpQ6gxHGnMLIB5RfRlPZ/9rkgpPHyVo6jGclpyAu1ErX5/ilCAJlY52LyuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+T+dNH6TXuJhauZbK4BFvgpDSri5LYbK8TLL2RBM8Jc=;
 b=GA3mMCGEBukv6xJngB75r5X43mI1YSORx1g7uLgKm1ampea8a7tEFC31SsVyyGVomny4yFwplqYR/HtuaXbCnsZ/SresTmMj+qvEyV2aYvjyMtIY6fkwifsjIng32tSanm7X5bHvhED9vkt9/b4QY1QWkaabA16wVNmktO5H42g32zW8l6WMC9bOwWCDtJy28/KA6pZALnlzQ5Jt6GwEDt+2ipAD/DUdAm4i9zL7/7KpKi2hGuwiF1B5XlblEcXN7NDw7nWBadaLxwvODLIdGPqkuKRGeXzK0IYI9KaqwKXV+YjO66rEPTXxACvG/McDCz+jJgaZ1l0aKwPr7drlIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by AM0PR04MB4980.eurprd04.prod.outlook.com (2603:10a6:208:c3::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Wed, 10 Aug
 2022 12:29:07 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::c3:d917:fe7a:451b]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::c3:d917:fe7a:451b%6]) with mapi id 15.20.5525.011; Wed, 10 Aug 2022
 12:29:07 +0000
Message-ID: <ade189ba-4211-99a8-d5e6-c99b1950e21b@suse.com>
Date: Wed, 10 Aug 2022 14:28:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To: Cyril Hrubis <chrubis@suse.cz>
References: <20220810092804.5771-1-andrea.cervesato@suse.com>
 <YvOKbt1urOeVwQ57@yuki>
In-Reply-To: <YvOKbt1urOeVwQ57@yuki>
X-ClientProxiedBy: AS9PR07CA0022.eurprd07.prod.outlook.com
 (2603:10a6:20b:46c::34) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ced5867a-dafa-4c12-6cd1-08da7acbeb3b
X-MS-TrafficTypeDiagnostic: AM0PR04MB4980:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nlPkASIGbhcFwP4vpPU+Ogp869wyQaKmnt2JwG80v4fsOXT5eFIr7rAdPqP8A6ok2enLV5JT3o87NJ0SVN6nFbaSNoedR5u5LGvGsVkTlrmgbKsp2N5N6bQchdYaXEu49WxwOYwF9/3RUAOAMH/F1gk3xTXk7DZXMbFRs0u3AHoWMMqMXQvnSOKiZU+Dj3dmpSbKMv1WBgLUHztNSYpf399L7bgWhduXcBVTCNSDgWaSMuhIQIP83FL1o0pCk1/R+r5kSm5O0ztT115VgDhRX8Vcso+xJ2dsIWOezty93jWH9/TUstLtP+nJtsNYHiVfbIYXGr48P4BLyfeboBHCM6Imwm7yqZVeIPwiklqL5ZTMoDMLMe2SrzNnbkDXTV8BowiKIsjtICHTowGOGtSeeYvhVo0XMERLdaf1vudzdIaj5M6/JveNoDZi4dXio/7xULglZvbp7kfB/UT5DHw+ukfiyk6gfMH0ct3ETifj1NtPWfceHbbEFLqTPTcrl8QzaDeltvUr2jAiA5FcILI3r5MP8+gH64mXtBinAd7RnDOFVBh5iy2mqN28mxCshZxVCVoUnOvEdd6tbZPuJDGDSmtCjsVzrpFfjer3d20Y7uee40KVWBavfhJzZxp0AE5GciCtrIWgTGwBNmJ5L/7w2CseJwpROdu3m6DRFDWZhFj8BCqMH7rqY2HSSg/8K+OoFJs/Mley6GRsKAoMja+s+fEVkJTZXoMg0BUuKzNu4tF0GlSYgjFOe/qjWZDtVA7UiOb/paMSB/EE2PtZYummdW/QppJFmmegrhP7+WyjtIP7zaksoIcVUx7BcYVEoshz
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(39860400002)(396003)(346002)(376002)(136003)(366004)(2906002)(5660300002)(8936002)(44832011)(26005)(31696002)(86362001)(53546011)(186003)(2616005)(478600001)(6506007)(6512007)(6666004)(41300700001)(83380400001)(316002)(38100700002)(4326008)(8676002)(31686004)(66476007)(6916009)(66556008)(66946007)(6486002)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1F5VkxlcTY2aStsc1l3MS9vOFVybEFucWljdlZmMmFzOVhDU1RJWjFIdlRl?=
 =?utf-8?B?OHFud0hJZFZib2RLMS9DcGQxd1NiZVhpNXdZR3AxamhwQVg1UEk3d1R6VEho?=
 =?utf-8?B?MDMvQlVJdHZrVTJ5d0QrZlNYQVJtd3RQRXo2MVk0b2RmdzdaTHJXNkdoVUVH?=
 =?utf-8?B?Ykt3WmprYnBLbUZlSzQ4dDhycDUwYTNCc2s0UXY4UXFCb1hmWERmWmFBMkRB?=
 =?utf-8?B?a2NLZk1GRklSdmRFTzZPdG9PSFhhNnduOXFFZWRaT1EyN011d1J3OU1SYlRT?=
 =?utf-8?B?dDcxdHFuNlVWeC9sTUp0c1QvMkxQcWNnSmVkU1k4eU1yWHN2R3RIajFyRU5C?=
 =?utf-8?B?ODdqVXNFWUlYdXB6RllEdG53MFFwd3pVMTRwdENtR0c4S0xMUWNtMW94YUpR?=
 =?utf-8?B?Z3FMZ3MzNTlPWDN1WUROWXg4TUhCOXJrVER4MUJzaDQwR20yTUZ3WkdXUWlR?=
 =?utf-8?B?QnlGTS9tNk9VMjJiTFQ0enYwTWw4VDEvbzBONTNTa1pwZ00zMDBDeTIzTE92?=
 =?utf-8?B?Z295eWZYWGIreDZRYSt1ZFBoNmsrRGpETFdtWis5OUhUdHF3NElqZ3FTOEFr?=
 =?utf-8?B?Wng1bi9GSStwTnRsSHBsUWs4QUNMbUZENElURVBkbjZ1ZzJYWDJyZWpYQXdD?=
 =?utf-8?B?b2dtRkxCMmtZc1pTR01RQm93RDZUeU8yVktMZHhLRUwwZ243SGVHOHpiTjhT?=
 =?utf-8?B?TGJDU2hicDRVeG9HUFo1S3kxL1B6NEpuVm1pc2FDZjduNzVDZExka2s0NVcr?=
 =?utf-8?B?VGtGcnFmalF3TW5FaTBuSkg1UW9PWE51dndnaGtlOGlQSmIxdlM3amlaYy9a?=
 =?utf-8?B?QW1iSXE5TVBtT2RwdWVTSVllbFBiZE5yNDJlNERCNTV0dzlJekMzamxyU2da?=
 =?utf-8?B?LzkwT3lKbDdHTmcyMnN5WVV0bktibWV1bUxlTm8xam5mWnZpTHVSOXlhWC9Y?=
 =?utf-8?B?QlhHRE9SankzRUxoT1k0MFZCeFR1STdOYzVZT25TQVJ4U0tVa3BxTG9VclNu?=
 =?utf-8?B?MU9mQ2xDR2Fsa1djMXgzQ2dqR3FFOWc0NUEzWFo3QWFIQnZaQkxZaTRnai9m?=
 =?utf-8?B?d201SDEwUkRsMmx6b2YvQlRSYkFINnhXTFpxTG5xbEQ0U041c21ybGZIckxY?=
 =?utf-8?B?QTlnZHoySlhzV1JBK0JrYkRkVmc1U0pTTGVLNGlwMm1wNnVtSlpGQXJMVm9T?=
 =?utf-8?B?SmF4K1EzNGlTMnZsK3FuTmdMSFNTYWRPaGhURThhY2dkVmdrcWZQMGxkTksz?=
 =?utf-8?B?Y1Rra0ZGcURzVVJlMnRrWThoTDVHSTZGRFpuc1FkR2ZWc1BHRXZPSEZhVHhX?=
 =?utf-8?B?WEppSEZFTGo0cU1zUEYxRE00dldYR21weUVTM1lPeFpYZUdka1RDcnJpdzRx?=
 =?utf-8?B?WFo4TURUVkpzd01LWXRjUFBTdWRVcy9rUS83ZGhCcnhvTWRWQ0tZbWhlMW9P?=
 =?utf-8?B?bkpHbmhyMkdBdGJyazFyU3BXVHlXckxhZHppZVczS0NHMUsxZjQyOHpMZDg5?=
 =?utf-8?B?bUJGOERnZ0tNZXBNS2tJSHlDRFRLRHorWSthUDRJcU9jYTUzeUxmZmlSM3Va?=
 =?utf-8?B?dDFBVlVNUzVyVWdhOGJLZGlXK0tkQ2xSaUx4eitSc2o3QXZEUUJNL2o4azVD?=
 =?utf-8?B?RlBCQk92RzkzMzRvbmR2NnB4eTNJQUR4YVZMbDRwbjBGNHpMUy8vTVAzVk1M?=
 =?utf-8?B?bS9obTI5OEx3VFpkam9qcU1sc1ZvbzA1MnpoTENxcnpmWjFkSEsxYVlrMHpa?=
 =?utf-8?B?MXVXR3dUSmJLTWJJU2cyZ0VmaVZxWlVUTnFpL1lNd2w1b2F3cG45UUdER3Zi?=
 =?utf-8?B?aUZlMlR2RlpSZzF2ZVY3c0J3ZC91Nk1MN3gxRzhsYjFLVzc4dFJQWkhGYjdo?=
 =?utf-8?B?R1VReXJCT3hCazAwb3Z0UUlSeHkvTnE4cTF0NEdpVFBLSmJJcURBTlYzQjJX?=
 =?utf-8?B?dUg1UVQwT2poejR6UThIVS8rbGJQSkdYZU1NdzVvaG94VVIzZm9sMTRRcDRa?=
 =?utf-8?B?d2JpRnV0RHZGSm93VEgyZzVIanJ3QWdqT3kwL0ZOeW4rOVhTckltUXBsOFBa?=
 =?utf-8?B?V2c4TXlaTTdmM3NxSVJhcE9sR3FDNk5taFlTY3VtOENpWG9jdUxFSC9xSE8w?=
 =?utf-8?B?cStiS1BqNVZUZ1dJQnhzK1BVTWU3UG01MHNkbzdoOEFHYUI4eDAwN2dDNitn?=
 =?utf-8?B?Zmc9PQ==?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ced5867a-dafa-4c12-6cd1-08da7acbeb3b
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2022 12:29:07.1086 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d2w42Jmy3ezqjfZNV2GgQDWcNMpynOYGLZMhJqo8kUihhk7LRZaFvttacuBJ9rmla5MuH0YThskKCHdv3nnWsre8we+fQB7Xl/V8scOgVY8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4980
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6] Refactor aiocp using new LTP API
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

Hi Cyril,

On 8/10/22 12:37, Cyril Hrubis wrote:
> Hi!
> The runtime changes do not unfortunatelly work as expected.
>
> First of all we have to check for the runtime in the function that
> prepares the file with a random data, since that is quite slow as well.
> Since that is done from the test setup it actually runs in a separate
> runtime window so I would do just:
>
> diff --git a/testcases/kernel/io/ltp-aiodio/aiocp.c b/testcases/kernel/io/ltp-aiodio/aiocp.c
> index 816407284..2b34d8bbe 100644
> --- a/testcases/kernel/io/ltp-aiodio/aiocp.c
> +++ b/testcases/kernel/io/ltp-aiodio/aiocp.c
> @@ -66,6 +66,9 @@ static void fill_with_rand_data(int fd, long long size)
>          srand(time(NULL));
>
>          while (i < size) {
> +               if (!tst_remaining_runtime())
> +                       tst_brk(TCONF, "Out of runtime!");
> +
>                  for (j = 0; j < bufsize; j++) {
>                          buf[j] = (rand() % (upper - lower + 1)) + lower;
>                          i++;
>
> Also the rand() function is way to slow, it's almost 10x faster for
> 500MB buffer if you move the buffer intialization out of the loop, i.e.
> initialize the buffer with random data once and then write it over and
> over.
Yes, we can reduce the amount of time to generate file (especially if 
it's really big), but I wouldn't
introduce any repetition because we would like to check that file has 
been copied properly during
callbacks which are asynchronous by definition.
>
> Then again we would have to check in the async_run() otherwise we will
> keep pushing new read request over and over until the queue has
> finished.
>
> Lastly we silently skip the check and report PASS when we are out of
> runtime, that's not nice. I would be inclined to report TCONF if we end
> up out of time before we managed to check that the data was copied
> correctly. That wouldn't provide people with a false security.
>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
