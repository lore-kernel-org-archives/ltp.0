Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16C48C433F5
	for <ltp@archiver.kernel.org>; Fri, 21 Jan 2022 14:18:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 67EB83C96F4
	for <ltp@archiver.kernel.org>; Fri, 21 Jan 2022 15:18:16 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 35FAB3C0DEA
 for <ltp@lists.linux.it>; Fri, 21 Jan 2022 15:18:06 +0100 (CET)
Received: from de-smtp-delivery-102.mimecast.com
 (de-smtp-delivery-102.mimecast.com [194.104.109.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 2EF9560135B
 for <ltp@lists.linux.it>; Fri, 21 Jan 2022 15:18:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com;
 s=mimecast20200619; t=1642774685;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hpmMqN1dpW++g6luncOMCMWfqoTcFbFr0Z04PpQXgxM=;
 b=Yr1IAmpPkYWIOyvkUsnG/IX916JtzOAq9DVsY8U5xWnOc6hX9J7EUnRAalyrsw/VjzAA+G
 DCOnRx1gJhI4uuR8O1K3wVblVrUA2lSyeOUNgpb8KagMBILWeaGaLXsCc/aROCUcBdQhe2
 wOCQYDmDdIifb/Yx22vB47HIgygF7vQ=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2053.outbound.protection.outlook.com [104.47.12.53]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-41-i7S1QtFaNf6UAFAG2aBW0g-1; Fri, 21 Jan 2022 15:18:04 +0100
X-MC-Unique: i7S1QtFaNf6UAFAG2aBW0g-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DbuZOlbtdebGbggvIJgGjNGptQZd4TjGnbpc+FDiPRv6plERirI1ZaUzKrOMUZ3Xbguj5t5vAqHNw3Or2BAuk3QXmkeicYg9GS5J4Uv1XxbxNCHueqkjMvYLqRn5PXF8EoVl2OQyQl5tvaAUF2u5WxqrlGHBbQPAhCxVqwkqm/7A4IYt3KU5c0vZDo8DUD6mPrdgky8+46BavKiRLOW61FuzRsEmJc5diE1vIks1JF92IpCrQZfPnkuSkKyfsdL94w3Qfo0w9MWJwKvHUJiFuxUqj2tEI19qoGgjR7aL5X1ZbP69B5IUGvO91A4vMY7ljffZcn9DfGWrh22R0PvrIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hpmMqN1dpW++g6luncOMCMWfqoTcFbFr0Z04PpQXgxM=;
 b=D+XnF/hbdxwg30lfNmJ41ucrerPMwZ52XKqbmxScxyTZkJg3S7RPQFotup2x/gE5Mk72g1sj1r7SMTyqyOfjBxKp8RZ5Cc/twQpKHqmutxvi4y+rgQbOc9MuUdqmzlbn11f3zbIoa7coJnPnymfyHviiDkFkSQF8pS99xG+V8ga7+FmG0heiP9FwRiU2hLpk5/ZhaAR7jCttohNbD9VvBnYGMv6T39JA/+g0rgwjO5e9g16lapMPb+sujFXl5dH7qrcaodYClQjC1QThPvc6dc9mMB6fCDmoyL2vwAPbK+7p63lMYNMOTtuZBBIZk928++WM/kSxEWTUYKajZXfj5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM0PR04MB6788.eurprd04.prod.outlook.com (2603:10a6:208:18e::20)
 by PAXPR04MB8767.eurprd04.prod.outlook.com (2603:10a6:102:20e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Fri, 21 Jan
 2022 14:18:02 +0000
Received: from AM0PR04MB6788.eurprd04.prod.outlook.com
 ([fe80::1c48:b656:15bb:a794]) by AM0PR04MB6788.eurprd04.prod.outlook.com
 ([fe80::1c48:b656:15bb:a794%7]) with mapi id 15.20.4909.012; Fri, 21 Jan 2022
 14:18:02 +0000
Message-ID: <dd67770b-3c70-7403-e643-6332881d1a40@suse.com>
Date: Fri, 21 Jan 2022 15:17:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
References: <20220121134052.30048-1-pvorel@suse.cz>
 <20220121134052.30048-2-pvorel@suse.cz>
In-Reply-To: <20220121134052.30048-2-pvorel@suse.cz>
X-ClientProxiedBy: AS9PR06CA0066.eurprd06.prod.outlook.com
 (2603:10a6:20b:464::11) To AM0PR04MB6788.eurprd04.prod.outlook.com
 (2603:10a6:208:18e::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 82183f06-356f-48c7-92d8-08d9dce8d5b2
X-MS-TrafficTypeDiagnostic: PAXPR04MB8767:EE_
X-Microsoft-Antispam-PRVS: <PAXPR04MB8767F1647FB704EF86515295F85B9@PAXPR04MB8767.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ouD64hAOQIM6qv1WxF4EHP7I7LZvxHbhZ+3os3LtFYTWAumPS1gFPEeNtOkIR8rmljigKyyIja8OBzcOWowePpNt+IlYvg7ePzX04b9yuZzGzIJgI91h4HMhOB3OpgayU69/9DoDCNNClrRqYDwtUVBBwft8zymjVy4ptVetNYjZ55SzplJI96fyd2wo2fT19QKFnOEsyGiupxnB8tJc5BXCdnrF272/vBFHmDpZcwKTk1nNtwAQlvqvUhn1z0xh25S6ZZ/tTx9cIRVVCRxDQlY7n3dc0Nwm4zjdlDCFTxNAREgovIQ78n3+Za6A8Sa9hFmMoZDslzUb1DwRbqjcwI38IigF4EcOt8ji9Tfcjs1p/Gsy8ndxGZ0LuSytk6+wejHCwDbYwn6bDKg16iA7+wVY4i+szjKv9qRlmT8SVryN5LOKQSW0V2/hNGL15mWdZat4GSnq64uYPeMgd6mByt4EDYVe93xlKrdFxqog1jHMe68BaJWUpOiPpMK8UfwBPm8l+dYgp/jG6u7H9FTn2TcVIYpRzGmIeP4KyeVdLfvwTUl5azb/MaGwqPr5h+kbRLARySk+RafPWZL+fqTXcLDtLSgr+ACAAbL2zK7aapjG/10KHoHRDRCHrg3Z265nfAMzxp9DLn675aTYODOV0GkovjB1BPELFK3ojXMZnHYfiVM2gRZjM+uVCGTYZLlfn2RrIwcGtNIWhZ20z/29YB59Ak8bsLiYL15sIgX1AyQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB6788.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(2616005)(5660300002)(4326008)(6486002)(44832011)(38100700002)(8936002)(66946007)(2906002)(186003)(66556008)(66476007)(53546011)(6506007)(33964004)(54906003)(6512007)(316002)(8676002)(26005)(86362001)(31696002)(31686004)(6666004)(508600001)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXoyRHczbTFML3NTQW9vLzg0dElzS2kvZGxieU5VNWgxZzQ4bDVSVzRSdnVY?=
 =?utf-8?B?MzJnYTRweEU3Q2F6ZU05MnhTa2luaGVESUptRmsxWUwwZFRoeXBSeFdmZG03?=
 =?utf-8?B?Mk81azA4NC9Bek4rRCtHR0s1OVMybmhsNUdqYkFvb2hYRk9QRHZvVy9LbWNl?=
 =?utf-8?B?ZGJDZTlzQ0NlRllZaEtpS1VDM2UrUzlha3NkdVJvbXZYQi9vbEU0RGpadE1i?=
 =?utf-8?B?dHlob1ZHUGlrRG5hcWJ5RXhCdHNSSnlaUnlBamQxR1RMMzdlOG02WVJjL2hS?=
 =?utf-8?B?WHNnWlFOc2hOUFBodSt5UmtvR2xRZHcwa2pOR25lRWorekZVTU9vcEZrVENM?=
 =?utf-8?B?R2l4Mk9ISkZPUTF4cVNMYjZoTjJGRDhzMXFjdVAxT2wrWmlRMDdnTTRIVTZN?=
 =?utf-8?B?UERtVXAzZkwwOG8yMDc1b2ZDOU9JV1BJeW1IWm5pLzk0TzhTeGduY0I4QUFW?=
 =?utf-8?B?ZHJLUGZQS0xYZlp2ZTVHTkxLdkN4eTVKTElESk9LSkRNWUxKdFFNSEM2SlVD?=
 =?utf-8?B?Uyt2VEVUQmpDR0dTYXNtc2ViYzNMN1ExS3JFM0t2SzJVSjBnbUhFbEhPOE95?=
 =?utf-8?B?MXVwbk5Vc0Rsc0Z3Q1VNOWdGM0QwWldqMjJpKzcxMFI3cVB4SXF6c3gvVWFP?=
 =?utf-8?B?WkJCdk43RSsrV2U3Szlab0c2a0JRS0VEa0V6WmRYdWdEelU4Q2YxbytOSjJv?=
 =?utf-8?B?QnlnMHhyb1RzTm1wd05BWnlvQ2pTcnVXVzh2a05BTWZ0ZFh4MU96ZDB3SUt3?=
 =?utf-8?B?cGtzNGZLQ1A4dHhURFF1QWVvZlpoZEpuQXVDVFJ5cmRGWkNJcVBMMjFpVEE0?=
 =?utf-8?B?QmVUM2ZqNVhGWTRCV2xzZTVqVzJ3MFZ3RTlaZ1RIUFl6NFc3Zk9iOHIyeXkr?=
 =?utf-8?B?TWlidU5yTTg4OXV1SDdUU2lrc01yR3lQUDVxMGNKVkpremdtYXJBVGFMOVNK?=
 =?utf-8?B?dHNnS3ZqMnpRckhhdnFDYXFWbXpTMXlZWlZoUnlHM2JIYmJreTlrRkZJMnhS?=
 =?utf-8?B?VEoxanJ3bEY2OVc2OTdLNFRLaFk3ME4wZHA5ZHZRZnVZbmlpRTllWVhXekZ5?=
 =?utf-8?B?WHBsSENoUkhXZlhLWnRKU0YxVXk0bmtjeTlGUWJZOUFjNzA4Zmx4M0M0d0sy?=
 =?utf-8?B?WXpQckJtRzhEaytQaUxGc1QwaklZSStENDc1R3Q2NE5HYWhsRnlLNXRJc1FK?=
 =?utf-8?B?VEZoTnNWNFljc2NZR0Y1eE94RFcrWVRZZ1ZNZHFUcmcwZW5QZitaWlhvclY2?=
 =?utf-8?B?TDhNMEF4T1EzNGFqSVFhK0s4MUJiVUd0a1EraXBrTDVjd21zYWNha1hoWWxG?=
 =?utf-8?B?S2NMN3dhdG9KMm12M0RrTkZISHU1dXZRTm9tOUkxeWNhbVBsOVhMTFRtb210?=
 =?utf-8?B?d3Z6dno2Mk1wWTlXbTNpYXdNaU55MUNTQ1FQZkJSZzVEUzJuOEZyNjhxTUNM?=
 =?utf-8?B?S1I2V2RNYjlRbVhSdHV4R2EvZ0VteWFoY1A5TnJlaG1oYjV2QjJ2MWFJaWhL?=
 =?utf-8?B?SjlkSnJDRXZneGU3V3JuakJWT0VXcnVFRStXbEFHUVEyRmNaempwMUUvTldC?=
 =?utf-8?B?d1pLZHpVemlJTm82ZU9RaDVGMDVIY1hsRTJWLy9NV2lsQXdNUWlJbUNacmNz?=
 =?utf-8?B?SVVMNFVZMjBnTERxSjA3TXpDZk8vYVBnTVB1S2NDeUd6QlUxenU2eEFRSE51?=
 =?utf-8?B?MXUrdXR1ZnRVc2RQWHF1dzErSGZYTG1iRm1tY29IeW9PS1N5blRJajN4V3RD?=
 =?utf-8?B?MHpQaXFxZHRybmRXODBLem9INTI0TGJoNG5JZ3ozL1V5OCttbmpVK0tFT2xq?=
 =?utf-8?B?WjRrNU9vU1YySWdCNzJ3NVoxeHpLVGFSNEVxUGxPT3MxcXFqTFoyV3hZcDBl?=
 =?utf-8?B?RkltZFRneDFKdXkvaEw1UFpFQVhLaUk4S3ZKVGUxSi9KcmpFZC82ZW1BNWZV?=
 =?utf-8?B?NXgzUVMrWnczemNxK0hSeFdOSUowaWtNQ0JydStuN201VCtoRUt1RUlRR2dD?=
 =?utf-8?B?akl4K1hMRTc0UHVGbFlMUHZUZ1Z4WHZYdmxOV3cxeURiRFZEWlBXOGc0SGJU?=
 =?utf-8?B?Ykx0a1c3Y05xM1VGbXprdEdkMmFWMDZWMFF4WWtGSDA2ZUUxSVhIUDdWRC94?=
 =?utf-8?B?aDRBZ0JBTmNQSTE4SlpMdkI1czBCN1psSnNHbWR3dFdiN1JEL3d6SHhML1dL?=
 =?utf-8?B?UEdnRVQ1WVZYMDIvRUViU0ZOL3BxOEhnVk1wQmZSYXF4UjByZDVZbndoYkhk?=
 =?utf-8?B?NThTcVVSTTJja21Mb2IrbFZWOEN3PT0=?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82183f06-356f-48c7-92d8-08d9dce8d5b2
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6788.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2022 14:18:02.7127 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jzDneZ4aPIUCvrLRQp/LDDJhmhLbcGxhWqCQQqw+HVFt7uLE+GaVAtY5W4cHWiyQLMzGv981PRCtPqsnSAfa7bQcAA4+1t4v6mYA3TxeuW8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8767
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [v2 PATCH 2/2] dio_sparse: Set timeout 30 min
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
Content-Type: multipart/mixed; boundary="===============1271688460=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1271688460==
Content-Type: multipart/alternative;
 boundary="------------W02zh0BtD0whYoENV3v0KclZ"
Content-Language: en-US

--------------W02zh0BtD0whYoENV3v0KclZ
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

On 1/21/22 14:40, Petr Vorel wrote:
> Originally only ADSP075 failed (dio_sparse  -w 518192k -s 518192k -n 1000)
> but just in case increase timeout for all newly rewritten tests.
>
> Signed-off-by: Petr Vorel<pvorel@suse.cz>
> ---
> Changes v1->v2:
> Prolong the timeout only for dio_sparse (Martin)
>
> Kind regards,
> Petr
>
>   testcases/kernel/io/ltp-aiodio/dio_sparse.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/testcases/kernel/io/ltp-aiodio/dio_sparse.c b/testcases/kernel/io/ltp-aiodio/dio_sparse.c
> index 39fc895d65..0039daa8d1 100644
> --- a/testcases/kernel/io/ltp-aiodio/dio_sparse.c
> +++ b/testcases/kernel/io/ltp-aiodio/dio_sparse.c
> @@ -135,4 +135,5 @@ static struct tst_test test = {
>   		"tmpfs",
>   		NULL
>   	},
> +	.timeout = 1800,
>   };
--------------W02zh0BtD0whYoENV3v0KclZ
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><font size="4">Hi,</font></p>
    <p><font size="4">Reviewed-by: Andrea Cervesato
        <a class="moz-txt-link-rfc2396E" href="mailto:andrea.cervesato@suse.com">&lt;andrea.cervesato@suse.com&gt;</a></font><br>
    </p>
    <div class="moz-cite-prefix">On 1/21/22 14:40, Petr Vorel wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20220121134052.30048-2-pvorel@suse.cz">
      <pre class="moz-quote-pre" wrap="">Originally only ADSP075 failed (dio_sparse  -w 518192k -s 518192k -n 1000)
but just in case increase timeout for all newly rewritten tests.

Signed-off-by: Petr Vorel <a class="moz-txt-link-rfc2396E" href="mailto:pvorel@suse.cz">&lt;pvorel@suse.cz&gt;</a>
---
Changes v1-&gt;v2:
Prolong the timeout only for dio_sparse (Martin)

Kind regards,
Petr

 testcases/kernel/io/ltp-aiodio/dio_sparse.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/io/ltp-aiodio/dio_sparse.c b/testcases/kernel/io/ltp-aiodio/dio_sparse.c
index 39fc895d65..0039daa8d1 100644
--- a/testcases/kernel/io/ltp-aiodio/dio_sparse.c
+++ b/testcases/kernel/io/ltp-aiodio/dio_sparse.c
@@ -135,4 +135,5 @@ static struct tst_test test = {
 		&quot;tmpfs&quot;,
 		NULL
 	},
+	.timeout = 1800,
 };
</pre>
    </blockquote>
  </body>
</html>

--------------W02zh0BtD0whYoENV3v0KclZ--


--===============1271688460==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1271688460==--

