Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8156BC433EF
	for <ltp@archiver.kernel.org>; Fri, 21 Jan 2022 09:02:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 798223C96E4
	for <ltp@archiver.kernel.org>; Fri, 21 Jan 2022 10:02:25 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 69DC43C9232
 for <ltp@lists.linux.it>; Fri, 21 Jan 2022 10:02:15 +0100 (CET)
Received: from de-smtp-delivery-102.mimecast.com
 (de-smtp-delivery-102.mimecast.com [194.104.109.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 6B1011A01142
 for <ltp@lists.linux.it>; Fri, 21 Jan 2022 10:02:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com;
 s=mimecast20200619; t=1642755733;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dfLu79EoHHG7aVgDLmsAtj3+hd+fG0bmhhvkn/ukBlY=;
 b=XBOSXnRRqNkJFQJViJY72E10m6A/IdE6abECPw8e0lUbggQ+rcdJWsYZmTtB1Sg4PfelkO
 2iUBCjvwHFhVwCJV/mqRZPq2KmQ1UZo9KF6MhIAEtmxJpZcRrTkoaJkGVN1p0uOi9sOIhz
 1lHYcJBkyOF/xfSR3QXm30jv16tn5Yw=
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur03lp2058.outbound.protection.outlook.com [104.47.9.58]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-27-1h2ruljXOY6R4Pif4_UNcw-1; Fri, 21 Jan 2022 10:02:12 +0100
X-MC-Unique: 1h2ruljXOY6R4Pif4_UNcw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HUcYT9VIXkeMSQdnzz9plK5Stt2yAnzFmK59Pa6LljQute9vH4wbV3ZeeojQhri3riGpCnHEn5iqdbMs9EdYXXbVSgYBUhZPyIWX9WyDzfRV9OmjFsLqjYUw/Mh3rE+wRMscUpfQmyzQ8UlmmyMxB81NnKG/7uFs1/x2+I59X2TYmB6IwoFQkPFsL1WXo61akivWn8LWf+m5Fhc0Dtuxqcwi33CnnTRt4zhwMtdRZzrmwdfxJvnIrAbT2u6JDUgNowKiOAeW/0WqWvSVROgmXJbp36SvPfGHLhTFv9iR6UQxZtMU3v1w1kArz6cEX8nxg0jgp9mvDOJU5yZpapryrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dfLu79EoHHG7aVgDLmsAtj3+hd+fG0bmhhvkn/ukBlY=;
 b=YNmewUuHGbiQbD6iNF6fot8MYr9NYIzymRJD97ByHTefuugiNuuKGSVgWLGRMX7hbqUN/CzbcI5ZTj/hWNC3OLD5F76Iq8ZPKk5aiRj4jNi6LmunuR1u6QbrGhivp5br8MjTdds+98Xgg0lv352sfOKvirmfNST7hqbvYzfEvYVsWFMvWOolHwrFapiDvN6+2lO6TEcPIAttbPAZcDanmQXeflj7ihJI81siq7DS4bYDRxkz3YJhialfvoGSUbhOxAavFh7vHhy/IVmaaWfHJ2YEeM+yIPsx56cXKuB6+obi9tyEI4mUj+rew6B0/J48ASCfMzttpwLnG+vs6KQ1+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM0PR04MB6788.eurprd04.prod.outlook.com (2603:10a6:208:18e::20)
 by AM0PR0402MB3348.eurprd04.prod.outlook.com (2603:10a6:208:24::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Fri, 21 Jan
 2022 09:02:10 +0000
Received: from AM0PR04MB6788.eurprd04.prod.outlook.com
 ([fe80::1c48:b656:15bb:a794]) by AM0PR04MB6788.eurprd04.prod.outlook.com
 ([fe80::1c48:b656:15bb:a794%7]) with mapi id 15.20.4909.012; Fri, 21 Jan 2022
 09:02:10 +0000
Message-ID: <28386d51-a60b-b0f5-5a18-776629a1c361@suse.com>
Date: Fri, 21 Jan 2022 10:02:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To: Cyril Hrubis <chrubis@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20220120150421.26639-1-andrea.cervesato@suse.de>
 <YemAQcXuJMGLh/kc@yuki>
In-Reply-To: <YemAQcXuJMGLh/kc@yuki>
X-ClientProxiedBy: AS9P194CA0007.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:20b:46d::21) To AM0PR04MB6788.eurprd04.prod.outlook.com
 (2603:10a6:208:18e::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d270c54c-aead-4e29-2d8e-08d9dcbcb56d
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3348:EE_
X-Microsoft-Antispam-PRVS: <AM0PR0402MB3348B08064A5FC618E4D79D9F85B9@AM0PR0402MB3348.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m3mXLznzemV2c/y+AFYQzO5fZoukryVdf6WEjnb+xoWBAHcwtjTUgsu7YnLsdA3O5wToBlIRheUJe/KClo1COKrqjd3+SyNCxHIm6MsyoICL6xe4Ve0TvyMAZ8xTyRTVo6jTU1jrnX/Pdn6FwBVi9Mm5GhsHE5mUleiqPRYUewuKkx3mrOc1SDXw60rDc7sRlpeXrawfh4dJ9qjrEbcjDzmIe8Dx3HlSUBuLxM2vgqXhNtoQcYArqjkT6ypsGvsgfjANpWTSYWUzo39pZ7XdeIeMZ2LRdQy7OflBaDw1nOtF3wCFqoLJWqf2CKhbq2PplPQJGpV3CCTD7yGz9PCBU+A4boLw5vzxUac4llrxZNuMGnnKvxN7/JO1EShWPmQHe7ttIEN4YuRS+98VX8Zm5qEP9NSYfuOp2UA0pW/ffwZ94yyRDotW14Yvq5nxHqCggdS31G4DACltnoKps1gTLkRNP34r1eH6bfOa1rntvTS3qgWbHhtStyUszviLkQufSeJVSfyQsN/WUq9yd/EOuE2fqzhglBWt2ld7CHtj3cFQL0I08dqmnGOQt/BilJWnrG6rKqdtTwGO1TLZJhOVYIgpOtSmoYOyMG67yFvrrwaqdnq2zsntbn+2pWSUZsQgluwK+lNMLMnthcOTAZsBLMpKxAOmmz7YcW9kW4tfGvyeZmyhL1qvICQOzBkxE2+vVdJyP0LErDEWYval6DyV6XzvuC2XkzK1u25oBUaSLI8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB6788.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(38100700002)(4326008)(66946007)(110136005)(31686004)(66556008)(66476007)(33964004)(83380400001)(6486002)(8676002)(53546011)(26005)(44832011)(508600001)(6512007)(8936002)(2616005)(6506007)(86362001)(186003)(2906002)(36756003)(31696002)(316002)(5660300002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3k0ZHFmaHgzVGVQK0ZDWDJGWi8zV3hhWnoreFEvYmxFT3JvSFlsOWpjSnpT?=
 =?utf-8?B?bllFMmdRbkJzOXpMaHlGdVZpZ3o2RHY0ZVRTa1RnVnBycjV1ZTZxdlBNMWh4?=
 =?utf-8?B?L1JxSHZwTnhvWFVuWnMvcUg3YmQxMWw0Q29kYTZPTFNsLzlDWFVHaWJLMGtn?=
 =?utf-8?B?aUN1M0NMVXhTeXdEdVFZRW8zMjcyU3haV0VKN0k2R1R5aGpvQnlCalByT1Vj?=
 =?utf-8?B?K1JvUFJ6dlEzYU4ra0VkODBjU0pxU3I5bVBJaG0vcDNPcE9oWFFYYmlzaVha?=
 =?utf-8?B?VExiUmlHaUN1cTJ5czBGSHIrSXhvTUhlbGE2QTdINGRxbDNqOWczeXQzL3M0?=
 =?utf-8?B?bmdHZ09ERlo5aE4rbmRQK2dJMmQzbG43bm91Y2VuTWFXYmJwbnNPV2Q1b1ln?=
 =?utf-8?B?WUNOS3E0V0E0T01jc0NQRzI2b1VWMFZEWERaVU04Skl2NzBoUE04cFh4anFX?=
 =?utf-8?B?Wm4xbWFmMGtDK1ZIWUd4aXJqYy9hU2hlU2g5U3lyVDFGMk85Z3AyaVZGU2R0?=
 =?utf-8?B?UzZKMHdOWDdFcjlFRmk4dUNmSC9yOG5CUGR3SUtIeXVHckVjMGpydzVlN09P?=
 =?utf-8?B?U2preEloeExRY2ZwL0s4WngwVnMvZ0xUeWZvK1EydFFiSTJQY2tGYm9tMnBn?=
 =?utf-8?B?K3luWWVmMmlIRi9VUGxISDI1ck92Rmp6WDd3UU91bVIyTytVVU0ya0lpMWJI?=
 =?utf-8?B?VzZuaUZQeS9XUGxSL29YSGdJMHB0ejF6UE4vV2JUdmpSczdHSjh1SFJBUStZ?=
 =?utf-8?B?U2NyUjlHamthRmd2NzZyL1E0c2FzWjd1bkNBWHNBQi9idFlBY3JidkNoSU9q?=
 =?utf-8?B?M0lEUHNWTGwrenA4RTZ0OFVHa0duajJPV0EvYyttNi9DYXcwcFFNdC9BWWNS?=
 =?utf-8?B?T2RaOHhxRkNEdk9vaHkzcjQyQUY5NUZMSXlVcVA1c0NQTE9qM1Q5T2c1TFV5?=
 =?utf-8?B?WEc3Tm8zZmhSbllMNlBpekxhZE1FMkVqSXdsNlpMVklBa2hIRlQzakhLSmdm?=
 =?utf-8?B?WUJWWjg2MHRVS3F0SFYreTlXWHJPbDdoVlBoNVFpdjFIa1VIVUpmbHV5OXU5?=
 =?utf-8?B?ZE5lSnZidzg2eUpBMzc5NThacy92WnNSUjV5NmZNd2x6WjZ0a2ZJQUxNL2tj?=
 =?utf-8?B?ZFdPU3k2Zm1kWVZFSXprWThhN0FRVGdqSmZNd2pTSHd5cnIvb3Bna3U0UmVu?=
 =?utf-8?B?TlQwdTBrcXVpeHQvSnVBN0FpdlQ0VkZXaG5sSXZ0L0dWUW1ibTZKSHZzVTI0?=
 =?utf-8?B?NEtINlVnL0ViOGVET3ZMU0tHQWtTOVh0bnJVVWdscHFGb0VmNDZjVDExdW9D?=
 =?utf-8?B?VzlubysxSW80emdXRHp4VGJQVGEzOW1yejNUbHFKemsrcyswMytDVUxKWU1X?=
 =?utf-8?B?VnRUNVNJNlBpdFdFOHhaUHNWQnA5QjNlSDRidFhkVnJlaFBHUm9hNnJSK05V?=
 =?utf-8?B?VWxCN3RUb21FQy95QmZDY0pxSnhNTU9RdmVNZTlxNFZjSW80emhXbWdyODUx?=
 =?utf-8?B?cURjd09DNjlsWVJydVJTNC9xZTh6akcvT2kvSFljbkp2cVVocU54Y2JSZlMr?=
 =?utf-8?B?TEdoWnQ3RCtRTnJmcjRFZmJLaDdiQ1VtMmMvcUplRkFuQ2p4TzlOTHM2b1Nk?=
 =?utf-8?B?dzVDNkwwU1ZOYUYzc0M5bWxTcDJ4Q1p1ZUhESHA3ZTBDRkVXMWd1Vzd2MUZh?=
 =?utf-8?B?MXhTK3UyRlFhSjhlNzRJN2QyQm91VmQ5dzFHcTNzeHFQSWdkNzhadUhnM0FX?=
 =?utf-8?B?RjN6dVZacVpOTDZ1NHZjT0o5VmlIN1ltMmxZcjZrdnU5WVVvN1lUL0pEa1NF?=
 =?utf-8?B?d1VUdmUzVHNpNXJmVDJkNHkxdE0wYmhPMEJCZldLelhyTThCZ3hBUHRBeWNN?=
 =?utf-8?B?MjV4ZERWa1hpSUZ2UHFzcGF5aXN4bzZPVnVQTGxHUzRLbyt0OXdzTVFOSWZL?=
 =?utf-8?B?TEMrL3kyNjVpVmk4WW1VZ294NzV2SURZbXVyS3dQSWczTXFscXJwUGd1STRG?=
 =?utf-8?B?bkdzU3o3OHJ6NzdpK21zck81eFJJRjQ2Ym1qbHM0Qk5mYlZiVXJ6SFRIU21m?=
 =?utf-8?B?dzBuN1ltcm4zN09HSlYrRVVvZ0c3NkFaa3hEZTViZzIzR29uMVM0MFh0Wkhi?=
 =?utf-8?B?KzQxdG4wa28ydWZXUzRKc0FpaXlTOXVSQmVkbXRWYTlGMytwemJzUTFPZWsw?=
 =?utf-8?B?ZGgyU0JiVTJUM3Y4czBHbkpYWWhUa2c4T1Bad05ZSGFUbElwdjJFdjhxWTVE?=
 =?utf-8?B?N2xLYkN2QjQxVUlZektBVVNVUmZBPT0=?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d270c54c-aead-4e29-2d8e-08d9dcbcb56d
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6788.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2022 09:02:10.6512 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lz8QMIOdP8IwJc8MO/9nLq3kMWVvm6we+20patW98qf0XWN4dr1BfC6C/cTBPqCYVmkwHvSH6bI4kKsqLcLjvujcysCyq1aq+gC5V4KmxiM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3348
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Reduce needed memory by the dio_read test
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
Content-Type: multipart/mixed; boundary="===============0022575334=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0022575334==
Content-Type: multipart/alternative;
 boundary="------------y7cq6R7Bmb5xSkGHAcUT6C2B"
Content-Language: en-US

--------------y7cq6R7Bmb5xSkGHAcUT6C2B
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi!

By changing the file size to 32M, test requires 2 minutes to complete on 
my machine using ~51MB memory allocation for 100 threads. We can go for 
it. I'll also write a little explanation to the patch.

Andrea

On 1/20/22 16:31, Cyril Hrubis wrote:
> Hi!
>> Signed-off-by: Andrea Cervesato<andrea.cervesato@suse.de>
>> ---
>>   runtest/ltp-aiodio.part4 | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/runtest/ltp-aiodio.part4 b/runtest/ltp-aiodio.part4
>> index fc1e1d479..8c10f67fb 100644
>> --- a/runtest/ltp-aiodio.part4
>> +++ b/runtest/ltp-aiodio.part4
>> @@ -62,7 +62,7 @@ DIT002 dio_truncate
>>   #Running read_checkzero
>>   #gread_checkzero
>>   #Running dio_read
>> -DOR000 dio_read -n 1 -i 100
>> -DOR001 dio_read -n 10 -i 30
>> -DOR002 dio_read -n 20 -i 15
>> -DOR003 dio_read -n 100 -i 4
>> +DOR000 dio_read -n 1 -i 100 -r 512k -w 512k -s 5M
>> +DOR001 dio_read -n 10 -i 30 -r 512k -w 512k -s 5M
>> +DOR002 dio_read -n 20 -i 15 -r 512k -w 512k -s 5M
>> +DOR003 dio_read -n 100 -i 4 -r 512k -w 512k -s 5M
> Limiting the child buffer to 512k makes sense, at least in the cases
> where n > 1 as by default the child allocates 32MB buffer, with 100
> children that makes up to ~3GB. Also this really should have been in the
> patch description, which should really describe why the changes have
> been done.
>
> But I'm not sure about the -s 5M part, the file size was always 128MB
> before and reducing it to 5M sounds like too much. On my machine that
> reduces the testing time from about one minute to a few seconds, that sounds
> like change that is too radical without further explanation. If we want
> to run the test with smaller file size I would go for 64M, that reduces
> the runtime to half without reducing the changes for triggering a bug
> too much.
>
--------------y7cq6R7Bmb5xSkGHAcUT6C2B
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><font size="4">Hi!</font></p>
    <p><font size="4">By changing the file size to 32M, test requires 2
        minutes to complete on my machine using ~51MB memory allocation
        for 100 threads. We can go for it. I'll also write a little
        explanation to the patch.<br>
      </font></p>
    <p><font size="4">Andrea<br>
      </font></p>
    <div class="moz-cite-prefix">On 1/20/22 16:31, Cyril Hrubis wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:YemAQcXuJMGLh%2Fkc@yuki">
      <pre class="moz-quote-pre" wrap="">Hi!
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">Signed-off-by: Andrea Cervesato <a class="moz-txt-link-rfc2396E" href="mailto:andrea.cervesato@suse.de">&lt;andrea.cervesato@suse.de&gt;</a>
---
 runtest/ltp-aiodio.part4 | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/runtest/ltp-aiodio.part4 b/runtest/ltp-aiodio.part4
index fc1e1d479..8c10f67fb 100644
--- a/runtest/ltp-aiodio.part4
+++ b/runtest/ltp-aiodio.part4
@@ -62,7 +62,7 @@ DIT002 dio_truncate
 #Running read_checkzero
 #gread_checkzero
 #Running dio_read
-DOR000 dio_read -n 1 -i 100
-DOR001 dio_read -n 10 -i 30
-DOR002 dio_read -n 20 -i 15
-DOR003 dio_read -n 100 -i 4
+DOR000 dio_read -n 1 -i 100 -r 512k -w 512k -s 5M
+DOR001 dio_read -n 10 -i 30 -r 512k -w 512k -s 5M
+DOR002 dio_read -n 20 -i 15 -r 512k -w 512k -s 5M
+DOR003 dio_read -n 100 -i 4 -r 512k -w 512k -s 5M
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Limiting the child buffer to 512k makes sense, at least in the cases
where n &gt; 1 as by default the child allocates 32MB buffer, with 100
children that makes up to ~3GB. Also this really should have been in the
patch description, which should really describe why the changes have
been done.

But I'm not sure about the -s 5M part, the file size was always 128MB
before and reducing it to 5M sounds like too much. On my machine that
reduces the testing time from about one minute to a few seconds, that sounds
like change that is too radical without further explanation. If we want
to run the test with smaller file size I would go for 64M, that reduces
the runtime to half without reducing the changes for triggering a bug
too much.

</pre>
    </blockquote>
  </body>
</html>

--------------y7cq6R7Bmb5xSkGHAcUT6C2B--


--===============0022575334==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0022575334==--

