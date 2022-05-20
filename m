Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A47B6C433F5
	for <ltp@archiver.kernel.org>; Fri, 20 May 2022 08:10:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9276E3CAAF5
	for <ltp@archiver.kernel.org>; Fri, 20 May 2022 10:10:27 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 528DB3C21CE
 for <ltp@lists.linux.it>; Fri, 20 May 2022 10:10:17 +0200 (CEST)
Received: from de-smtp-delivery-102.mimecast.com
 (de-smtp-delivery-102.mimecast.com [194.104.109.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 8C424600435
 for <ltp@lists.linux.it>; Fri, 20 May 2022 10:10:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com;
 s=mimecast20200619; t=1653034215;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=idRIauaRqj0NgDUBYcqW1OjE8MXasEhVC2TG9m2WOJ8=;
 b=SPf/JGgsWdrBUu+Zhqd2vkSwZZO09uSCozCYJz6B/ymMchcra3K7N+C3xZdagOCdtRFxPT
 xBgbpQeuVxmw85AmCm+pclNA4OqxPkKsEWNGoL4gSGwLYPmpsqnz089P7S3hj9uum0vvF8
 v+F668QHR1GV5tfJA0di/SdgvHrHKss=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2111.outbound.protection.outlook.com [104.47.17.111]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-41-ITldWiHbNjCgQPEUCWyCYA-1; Fri, 20 May 2022 10:10:13 +0200
X-MC-Unique: ITldWiHbNjCgQPEUCWyCYA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DxbLe9GQwYtYPytBwQDAkTPazBO2uxayMd+BiuFJ1KYXHX7cmiAcfmOnIWGg3M4lH8rvjHh2M9Ty3jYOxf/FqiRvI8AAdJGpWZXTPtdWPO/PoIKk/9RZRvoyPMednYlFWLVnixwJ8b1fEyGaQwCNsCqDLOJ1//BCalcXVoTIRoRazTUH1MqNdBhwmDNl9/NozVI1KrJlQmHxH52uJ6K7RlA02qEfxyoe+ZbvfMqA+HrT+H7aFQd0tYPO67S86yVQRCEIoD8TwK+IGD+tAyD3otSzd00iOtS04XLQUP1TmpQAhAAaxuOYgzKAFpTH5f1hudsqeEkFczemFnD9ccXEag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=idRIauaRqj0NgDUBYcqW1OjE8MXasEhVC2TG9m2WOJ8=;
 b=DEi5EW27gOthd5u2p9mkmmdFR9RCHpw25w/YZTYrQXf5cCq2HtkzZQHdmVaCDhs29mGSKO7AC3daRUu0p+NFnCYHyTWsuk8CrfyKpXIbGelNEaeeBFNuGVXig4x1Pr0Wg5WEKtBomZ53fi72mTgthawzlST6CekvoXbhEOcLO9du6cyQb+lQhKwq4KkQEd1QE+Qu/FIbS2s+lfkOwuwHPfPX2Jq9o85toRz1RH5pA9WksOweKYisspK1JMFCBzr0W+7XkL3Za4Kab94xNmIoGIg8C9lGgSCoxzSKjh2+TWXjGBC7o9uUPWsvAqsZE8nGsuol/kPjioak0owyFA6voA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by AS8PR04MB7560.eurprd04.prod.outlook.com (2603:10a6:20b:29d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.17; Fri, 20 May
 2022 08:10:12 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::1d3e:8add:7f5b:df25]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::1d3e:8add:7f5b:df25%9]) with mapi id 15.20.5273.017; Fri, 20 May 2022
 08:10:12 +0000
Message-ID: <f42c535f-119e-a0c2-88c0-496b44ce8867@suse.com>
Date: Fri, 20 May 2022 10:10:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20220519174151.14114-1-andrea.cervesato@suse.de>
 <YodDo1PKnlGhTNgv@pevik>
In-Reply-To: <YodDo1PKnlGhTNgv@pevik>
X-ClientProxiedBy: AS9PR05CA0011.eurprd05.prod.outlook.com
 (2603:10a6:20b:488::19) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e82d17c8-c7cf-4919-aa19-08da3a382998
X-MS-TrafficTypeDiagnostic: AS8PR04MB7560:EE_
X-Microsoft-Antispam-PRVS: <AS8PR04MB75600E7E1B94D5A1070B65BBF8D39@AS8PR04MB7560.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K2v4R1WC3PdEHE7ETz9RCtXz4H4UtxpARdqxByypN5Eq+LQDjC/80DYhqe3zxoIFF8EEgIEIFg1KA/CPeylhIZ7d6pYSbkW4zrjGXeRRt7fNXG0STmPqzjwJwfI+zEot1yPnOw1Ge934phhrZ/1vd4aPlupCik9kcVraRDtMGQzEH3a6rhwtTNMx0Xj98C9/VtiIyHeE6r5jEEg1uetX0rGuPaLgWgeUwvbFybKHbuKTHMr1tL0q01cDZ+efFJG42wF0aQlNvCucZeMPH1gkYJ6eS7/1b0t4mEM0C8xWrxRA2zhicnNYrfKjdkNiQlYQtQXBD3RixlOotcYSlvlfHMYINgfod5/kn0ehDApJ8vnFVJShkKJyYaYrnO9oaKwNBp6ycIuzFTezXrUQzf7r411W6XBaX0go2rpge/4Dgnq2wi3uZ3Ts+AwuL/l/L2PIWLpIRX4BctvcppWI1/bsAELNO5zdKtEruu6AFTiMTHJYNkfsSxPo41e9vyg19nESPLds+ltG9yKQWQdvgKVv5dSwdObRETkj3ev/sio3gzanFAqzRoBbgdf1BNriczBPCwTzm0EGAz0sC6oT7CucSgl8jst0w2ZY5T4GYvE+T7Hesn/NqJ1QDcA0lo2sRtC6AYu+vJc4SfJ/FcDn5GkrgSpmKljI+tQJ65+/SwpTO0E0LuRlq0LCk4k/YBTaE62VeC1PlJl3m1JnZIj683D27Of0lfKz8UcJfQ7qLjUdQ8E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(66476007)(2906002)(54906003)(110136005)(38100700002)(66946007)(5660300002)(66556008)(4326008)(8936002)(86362001)(316002)(44832011)(31696002)(8676002)(6666004)(6486002)(2616005)(33964004)(6506007)(186003)(53546011)(508600001)(6512007)(26005)(31686004)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3ZBRS9JWTlmNGRPbkdFZE5PZm5BcU5hVy9RWDBwbkwyZnpNV2ExZU43VmhW?=
 =?utf-8?B?VUtSQk8vSVgzODZPRUdkVlQreCtvV3lYUDNMMHltSTFwcjA5RDA1M0RUZVBX?=
 =?utf-8?B?b2IxTHIwUGZCVEgyQjdpTkRRcWZvN0NsekJsM1V6QUR1QXcwTFYvQUNzOThZ?=
 =?utf-8?B?b0M1c2NTOGR1T1NoOWIzK3Y0MWNKQWFSQXQ3eEVWejJWNUd2UEJEaGE3Q2dG?=
 =?utf-8?B?VzFBV0tXNEhrdUJTbTVrdkdoVHQxcm0wbW5WQ2IxM2o3dnNxdGlITG9ZWlBo?=
 =?utf-8?B?S01DV3hxYno2cmkyWHJTb0N3amg0NDMzamRWUTVsTTRYaGV6bkhsaE9UeFc0?=
 =?utf-8?B?WC9MeWRaNjB1QTlSMGFPMlNBVWRVbG5tSk5veW04M01hS29lTG1QOWdGbkc0?=
 =?utf-8?B?OTk4eUVEam54UE9mWjZiZEp4YTRKZ1hCQU44RUVHSTA5Tk4rRVJvZWtBY24y?=
 =?utf-8?B?R0dNanBsREhKSDhGMnRzbkFBSzNvQWRoQkNLL012Y2hwSnZ0dUF5dTBmZWNx?=
 =?utf-8?B?OUpmV0Y0bXJxUG9pYnlNK0NYUVc0Q29wUVBGR25mbm1YNGhFek5WUjQrc0o3?=
 =?utf-8?B?ZHBodk94bUVwczVFT3pwZ2RxL3lRdWlhejR0aTd2dXVMaTNFa1ZKZXlQSEtr?=
 =?utf-8?B?WW5zU2RKU2Z6MFRiSlZkbmxVTjB0OWRVYmxJbkxsdGRlYjF2MUVJWWEzUElk?=
 =?utf-8?B?R1BZWmFMVitqQmhCMGtPQmhjSDB4eFBEb3ZGVURBM0RzRGJhaGJ1Wkcwcjl1?=
 =?utf-8?B?THFuV0NMTE95RmVMVFJVSnF3enF4bndrbG83SzZiaTFLVjN3dzhUTWw2amkz?=
 =?utf-8?B?ZC8vb0h5TnV5eXJLV1lXVzZzRFdHUUdQcmJOT1ZHNVFWK3ZmdEppaE9IUmUx?=
 =?utf-8?B?SUVyWUJHZkd1NFZpdTg1Q3o4bWVGSG5ZU20rbnMrUitDQ2FacVBsNEZWSGFr?=
 =?utf-8?B?VzlIRlBWVGF5NjJOU1BTOEUvOXpnSUdjL3JkMFJpeE1UdGpzZmErTWlWaGhG?=
 =?utf-8?B?WHBKMGtsOHlTeVVjOXZmWS9hVHZuTXQ1bkJ5VzNOY0tjcE9FMkp2eStRL2Ev?=
 =?utf-8?B?dVExcnEyNTltNldCNDF2OUNTV2lWYi9CZ1gvM0hET0x2MzJ4N2M0Nm83Sk5D?=
 =?utf-8?B?U1M0dU94aW9Dd3pqNzZCN3lpaGFOcXZIRkZheWlPQVE5Z29wSXNmejFBUEVQ?=
 =?utf-8?B?bG0zNnE4dUJmQVRqNTB1WElxWGtpRC91QTd4TnZTQzBNTEZmQnBwZkFrTEc5?=
 =?utf-8?B?c2k4M1ZhUmtWWEVDNjltZVNqSkdOQ0pqWTA1RisvYlNqOXphbEZWVFN6WDV6?=
 =?utf-8?B?U0c2UXVSSHJwYkVVRWdyMDI4eEpOTEZlbmhmUi9ydFM3eEljcnVwcEpJK25W?=
 =?utf-8?B?MTFPK2JmZjhMcEFFT2twcGtHRmZkc3RGV3E1d0tSQ2RHc3hVWU1nQ2Z5RmN2?=
 =?utf-8?B?dU1KQXpzYUY0ZW9zb29ycmJOcTBXV1lidGoyb3ZHaXNna1YwN1k3Ui9YMVdn?=
 =?utf-8?B?KzI2UUg1NHBwMDJOc3pqTmFpeXpzc3RQbENUbk9iSFBjZTVad0Z4TU94SWJT?=
 =?utf-8?B?a2Q3YkZYbUdiWkZzVkNpSFpkWEdFbFB5TnlyVk1BQm5Zd0s2MWJIelF3Tysx?=
 =?utf-8?B?VHJOOWNqaE03WVM0L1hSS1NabGpLOHM4NEVEdWpab0kzVnZpM3A1c3lsSXJF?=
 =?utf-8?B?d3h0UXQwcmFiK2NPU3RhNmN4Z2pxc0VMcnJHS2xHOTFQRWlZTTFZaEZqWitu?=
 =?utf-8?B?M1l3bEtlNE5lTFB2WG1WU3RlM3dKdzhKQyt5T2pLYklYajF4cFEwUzdxcE1l?=
 =?utf-8?B?ZC9BYm5sc2t5azFJVlZRZmF2R09TbWNDZnhYUmlrcmJKdkY3a1pJaktudjQ4?=
 =?utf-8?B?MXhiQUJrMTljWFBLNVdHWGUvd05tcTAyQlNqR0NnY1YzRHB5LzhTQm5VU1VC?=
 =?utf-8?B?RGxibWNFdkJTSjBUWk1jWTJSTHZONFZYcnlIZjVsWm5ubSs2eWNEaHZ4ZlBl?=
 =?utf-8?B?cFVmb0RmTjNrcjhabUZXbjhxdHA5U2NYS0JmYm0vbXZIREk4QTQxUmdtZktG?=
 =?utf-8?B?NTRqMmhSK3NoaXpIRnY0U2tYZEtuRkF6WDNaN1NJdmxsMnRoOFpSa3FkY1Z5?=
 =?utf-8?B?YTI0T1RMaDlJR2U2cEFyOENHZDJqNWU3SVVoME1Ed080bk1rTXlPeVpuNmg4?=
 =?utf-8?B?alhKUVNjZjVEdWh0b1BGQ1pDZjg3V3k0SzJNMmsvT3ZleGxpNXNGdFN6Z0tD?=
 =?utf-8?B?cGhVRlQyNHBqeFl2NGJWdFlHVFlKSCtUeFBqNytGVkszT3R3TnhKaHlQTlNE?=
 =?utf-8?B?OTRSSjliT1o3L0hmb1RlM2pvN3cwcWNkcktaekxwY25KUWIvUEYremQxemFB?=
 =?utf-8?Q?enjZ7zCCrpposKz4=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e82d17c8-c7cf-4919-aa19-08da3a382998
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2022 08:10:11.8372 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /JukMJcvl+xT1cFcZnzpckBin4S8CTplaBvY459ahWhGqhFO7xOgog1mclv+pgHCX8W9H7I65a8tTZUnOUON7+ZFriP7rX71z5qmWkOLa1c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7560
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Fix ltp-aiodio tests failing on s390
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
Content-Type: multipart/mixed; boundary="===============1645605885=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1645605885==
Content-Type: multipart/alternative;
 boundary="------------Gv0GpJJIEBhTjsYJpz00oaHY"
Content-Language: en-US

--------------Gv0GpJJIEBhTjsYJpz00oaHY
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Petr,

that was missing from the previous implementation indeed. Something that was checked in the other tests, but not this one. Probably because it's also the older test we refactor in the aiodio testing suite. It seems related to the bug and the volatile variable, so I added it as well.

Andrea

On 5/20/22 09:30, Petr Vorel wrote:
> Hi Andrea,
>
>> --- a/testcases/kernel/io/ltp-aiodio/dio_append.c
>> +++ b/testcases/kernel/io/ltp-aiodio/dio_append.c
>> @@ -19,7 +19,7 @@
>>  #include "tst_test.h"
>>  #include "common.h"
>> -static int *run_child;
>> +static volatile int *run_child;
>>  static char *str_numchildren;
>>  static char *str_writesize;
>> @@ -49,7 +49,10 @@ static void setup(void)
>>  static void cleanup(void)
>>  {
>> -	SAFE_MUNMAP(run_child, sizeof(int));
>> +	if (run_child) {
>> +		*run_child = 0;
>> +		SAFE_MUNMAP((void *)run_child, sizeof(int));
>> +	}
> nit: This looks like unrelated, right? If yes it could be in separate commit.
> But I'm ok to merge it in single commit.
>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>
> Kind regards,
> Petr
>
--------------Gv0GpJJIEBhTjsYJpz00oaHY
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><font size="4">Hi Petr,</font></p>
    <p><font size="4">that was missing from the previous implementation
        indeed. Something that was checked in the other tests, but not
        this one. Probably because it's also the older test we refactor
        in the aiodio testing suite. It seems related to the bug and the
        volatile variable, so I added it as well.<br>
      </font></p>
    <p><font size="4">Andrea</font><br>
    </p>
    <div class="moz-cite-prefix">On 5/20/22 09:30, Petr Vorel wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:YodDo1PKnlGhTNgv@pevik">
      <pre class="moz-quote-pre" wrap="">Hi Andrea,

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">--- a/testcases/kernel/io/ltp-aiodio/dio_append.c
+++ b/testcases/kernel/io/ltp-aiodio/dio_append.c
@@ -19,7 +19,7 @@
 #include &quot;tst_test.h&quot;
 #include &quot;common.h&quot;
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">-static int *run_child;
+static volatile int *run_child;
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap=""> static char *str_numchildren;
 static char *str_writesize;
@@ -49,7 +49,10 @@ static void setup(void)
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap=""> static void cleanup(void)
 {
-	SAFE_MUNMAP(run_child, sizeof(int));
+	if (run_child) {
+		*run_child = 0;
+		SAFE_MUNMAP((void *)run_child, sizeof(int));
+	}
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">nit: This looks like unrelated, right? If yes it could be in separate commit.
But I'm ok to merge it in single commit.

Reviewed-by: Petr Vorel <a class="moz-txt-link-rfc2396E" href="mailto:pvorel@suse.cz">&lt;pvorel@suse.cz&gt;</a>

Kind regards,
Petr

</pre>
    </blockquote>
  </body>
</html>

--------------Gv0GpJJIEBhTjsYJpz00oaHY--


--===============1645605885==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1645605885==--

