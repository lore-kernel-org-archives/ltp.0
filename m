Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DB4AC433EF
	for <ltp@archiver.kernel.org>; Wed,  2 Feb 2022 06:48:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A6D793C98C8
	for <ltp@archiver.kernel.org>; Wed,  2 Feb 2022 07:48:11 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C10763C2925
 for <ltp@lists.linux.it>; Wed,  2 Feb 2022 07:47:57 +0100 (CET)
Received: from de-smtp-delivery-102.mimecast.com
 (de-smtp-delivery-102.mimecast.com [194.104.111.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id DFAA960007A
 for <ltp@lists.linux.it>; Wed,  2 Feb 2022 07:47:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com;
 s=mimecast20200619; t=1643784475;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ohrDTzeDofAjZEvB3+loT0XdjPJ14WF+aJ0xO/Tkeuc=;
 b=H28BRfj90WCOMhOTNgtmaaacdJAwYBzMAtOORwlVlSwTbqPXN1STmRKAffxFW6rFQquA9u
 c8yVmZnVmlLdr0PnOut435ypYVm0TObljX/RbNaiYajh5mWlOQWeldSwv9+YCsE+AfAVji
 k4huHXJVzZT5bMCg1/n839NFmaPd46U=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2057.outbound.protection.outlook.com [104.47.14.57]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-12-9qoeQe-zNHu2xmDKPiduiA-2; Wed, 02 Feb 2022 07:47:54 +0100
X-MC-Unique: 9qoeQe-zNHu2xmDKPiduiA-2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WMt5uCP8j2G7wGXMXUEeduEC0SviwtXhSBmGkjsi3Wtmy+l4lq/XjHVT+n56AAWk96oHERa3G0jREAGmgpCZF6x7/1M061HyRjPJYiLw1WDeu/bzh2qqbkkEDUJnZyOcU3f/WTXXrhGAQIOBYZPx1FpZh2ZiYj95c2q/djwSP4GbY/ZmdVWoOjO8N4UcsF8SSh6DLoNjP77CoZa7MEVgzchGnYBC5QDkTAwqdX8bF2I2k3nNUPSFBKlkL8H2dsww347FIC4T5Jqfd6fADTcLu5JRoLJwahf3QZCxX7r7PWQqYYLhvTb0ILfCG9r5lWJqQICaSD9uSpJgw0hLuYZDvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ohrDTzeDofAjZEvB3+loT0XdjPJ14WF+aJ0xO/Tkeuc=;
 b=dtlq0ruYPyQlV8FCNMjUGqtbylDVbgGttVdJrtnSTF2Lz5lKqHb8F1FnsTsutuTH1y7QNHSVjZNtp9BfpCXpbBQQPogSb3RCYOEkAmjrW29RuZuBpoPLEmPIjJh8fsEZAeLlyzQqTD2w0PVpr4xUzq9PBdZNgQF9qKIocN6LfZLBwFWvfk+1xuBomPcHsFEe3EzPkBhKj6zSQoPmc2uYrEPq9bIiqL/+C3yP394w1bI5KSoxNm2A77HZAONqBK84lj/WyLdmeDAB+y35jhZjbjsry5ljcLna1I1k8pzmjIXeb1UJZmqfHSXxVuxYr0yY0OJnI3LVrpO8ywKN6cdWyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by AS8PR04MB9094.eurprd04.prod.outlook.com (2603:10a6:20b:445::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Wed, 2 Feb
 2022 06:47:52 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::a895:c953:d25b:32c7]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::a895:c953:d25b:32c7%7]) with mapi id 15.20.4930.022; Wed, 2 Feb 2022
 06:47:52 +0000
Message-ID: <6d37f4f4-4057-6146-a1f7-c6cdd8a4fe01@suse.com>
Date: Wed, 2 Feb 2022 07:47:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Content-Language: en-US
To: Cyril Hrubis <chrubis@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20220119091311.22150-1-andrea.cervesato@suse.de>
 <20220119091311.22150-2-andrea.cervesato@suse.de> <YflUp+c8DQb3Qgu4@yuki>
In-Reply-To: <YflUp+c8DQb3Qgu4@yuki>
X-ClientProxiedBy: FR3P281CA0047.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::10) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5f6e535a-8e3f-4564-f007-08d9e617ef4f
X-MS-TrafficTypeDiagnostic: AS8PR04MB9094:EE_
X-Microsoft-Antispam-PRVS: <AS8PR04MB90949549EED1668066030186F8279@AS8PR04MB9094.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qgWe4WQWNtHLOnRLBgiIwLxAKHna63iuwBwJzw+Ea4Bxl5zWQChwzXKYWO3eGTXJyWsBkZWqy6mcyQ398YepirbYIeNnnVh7oIY/hOyYFnb1f8rNRg8kNLGcIVH2dU4s0Y0yclJImMU1QMWA5+BojwToGYcv6lIQLUF8S2CtwgyQ9Y/oJoiwgFsCNE1DKfYisixSSHgzNqIIEGTt1SGws3SwzF0ve/LlHNp2ODkUmrznByFX9AWWi79BcP3Pz4UQbD5zbWxouPQOrsbinleBDZvJTrk6NuczuUTid9jeKQjaYlVhmlTGrX2Ep3z64ZPHA8CFIB8A4ZRi6qsQm5JWQoICh8k//+Ar5r0sq6ZIKAdThhZlJujPAdviiGagrLvm2VuUkDM3RcJ8dYVxm6iz9dmBw4xNnmoJgccs23ugRsW90wZ9A14qG3qGUAusxukCCsrvIvMWxssiPggiYg2VEfotpJnhpNYWFmRkWGfCHKsPHnIx9FiPoVgZQyQOdW/BLpRlv+gAKwwrw+DAghCupkCPldkJjrdZ63Gv6QCOVNv1SAaq2HRo9QMxmvhDDk10pelHgWp9P0fU3FfwQD/vYkwrZqwkoROP4t5v5meZrRfZdtzfOr+eaeM1SMLhNw2Wj78+4aYTkF82Tym5qQXhEyfQUAhoF6ot+kc+W9cOCYuQ6LYx2SUzHjsrpuFckqbBUf9BaqB5TzFav4ittaHSYwEI9xIPWbumtQufMRnppEc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(6512007)(6506007)(53546011)(6666004)(33964004)(36756003)(31686004)(2906002)(44832011)(508600001)(6486002)(5660300002)(31696002)(86362001)(316002)(110136005)(2616005)(4326008)(66946007)(8676002)(38100700002)(186003)(66556008)(66476007)(8936002)(26005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2pDbkNkMmZZUlFLNVp1ck01NkwxVE5xN0ErVTJGaFZlTXREMlJHcDkycG0y?=
 =?utf-8?B?SkwwWjgycHJ0eDE5elpxa2l6Mm1FcWhuUmZNYjZieDJtUisrVUx4eEo1MVY0?=
 =?utf-8?B?aG04MTVIcFlIYlBUbTV4aWRYNlp4SFBPVDN3NGZlRkwrcUY4N1MzR0NHdVMv?=
 =?utf-8?B?Uy9STmlNa3pWOUhzZ1VJZkphTDM2OTR4OXk0aldNNWlIc0QrN1JjeHhoblJj?=
 =?utf-8?B?YnZyY3J1Qkt2SHcxTjJFWForQlB4VVkyMTNmWjB1RWRMd29kUzJucXpxcFov?=
 =?utf-8?B?bjJnMWVDNXZSRGNOOGt4MVNNaDdmck15My9qajBNSWpZM2pmeUY4RG9vVzE3?=
 =?utf-8?B?YzhpWnZMQ2MwTFlvT3VWVlY0TmlON3pnc0lzRDMzbFR2Z012UnovU0NOeFdz?=
 =?utf-8?B?aHRFQXVJeDIzcXBFazdEaTlmcDRhdklReU0zaW5OaEs2OE92UjVLd1FwaSt3?=
 =?utf-8?B?RWFNcVh6OTdOMkE2d0h2aUt2eHdnVnFjcTRPeUt4SWJVYW05Q1VnRE0vRE1i?=
 =?utf-8?B?WDdBbmJhOHc3c2tWbEtmRllOQmhrZkZ1ams5Ris3T2xPT1JtMmRyMTlCV0Ns?=
 =?utf-8?B?OWdndktlM3NPMFU5Y2R0K29BNjVLZ3QxeXB2ZzBzZ1RpanBQS0hBcEE5SVZ1?=
 =?utf-8?B?bHFBYklpbzlsTVdGaXAvMEVVd2piUUczdEpxeW1TajZmQjNDQ2s2c20xT1Mr?=
 =?utf-8?B?VDQrSis2NEx5NUFkbjFuK3ovMEN0SW5DdGU0WXpHTlFJSEM3bk1lQ1QxaG0x?=
 =?utf-8?B?ekdjYkJJSGVUSUpqQ3dHRXpPa2VXZjFrdXB2eFlwZzFWTzhKQkdKV0xXZjNn?=
 =?utf-8?B?b3pNUXpOd2JYdDJWclFwSDI1eGlqS0dCMTVCelpxSkdEdWRMOUR1WjVBeDJF?=
 =?utf-8?B?cEMxTVovWjlQa3EwR20zbEhSOVJEK0lIcll4WTNQU2VzMlZmS1pCZzBWanZH?=
 =?utf-8?B?MDUrU05scUZEK2xwOVFnUXZONW02enU4SU8rZGJPTXArSitNNW5TNk92T3A0?=
 =?utf-8?B?QlNpMkdKQnVlWnlDQXk1eUV3N0Nyak5PWWJNdXdLdUdQUEo3bEcwY0FKM3Zw?=
 =?utf-8?B?aEJwN09NdHpCUGkvdjZhSlBycUp2YUovb3BQb2l2ei9jd0NrZ3A3YkdoU3Zm?=
 =?utf-8?B?MFFQZlZqRWo0bHpFWGFONHVaaG5COENxSEk4MmRRa0d0OUd2ekdkcU1ZVEVi?=
 =?utf-8?B?OS91NnJ5WlN4bkE4R0RXVGdGQ0pZNFl6VDJsM25zeWp5VGNaUFd1VWRxVVRq?=
 =?utf-8?B?TEt0c2MwcjBEM2FGRXArR2haQ2REWFBVRDk4YlRXbFJkc1lqUG4xb3lsdVZk?=
 =?utf-8?B?eVBMb1BRR1IrY0dNYkhUcFdjQ3lzN0VqSW9zUEgveWVwdTI5WTJMQ2hkMkNW?=
 =?utf-8?B?UkJHUWVBU25Oc0VHNVNhRXFvd09kZWt4cE43SjRja25hcWNudDkwMVBSd3JH?=
 =?utf-8?B?NXVVYThSb2REMWwvMGNJN2NCNjdXSW0vL2FraU43aFgrRXhFQzFFamFPaDZC?=
 =?utf-8?B?VHprYVhmeEYwSTVBa04wTjk0Z2hTM1pJOWlFRG1FWWhYSk85OEZVMFFWcU5L?=
 =?utf-8?B?bDlKZ2taMDA3b2NITmtXRmxnekVlMVUwN0xSdi9FSE4wN1hXRVdOS1hGbEJF?=
 =?utf-8?B?MkxFVk5wVUlqOGpDMk8rMlErekN2bURGeWlJSVdqb1F6U2tKR0RwVy93Yk1o?=
 =?utf-8?B?UkZHditmODk4WGFDalhGVnNhMTZwQ3lEdGlYSnJwTVZkc080bnJ0cG1uaENH?=
 =?utf-8?B?RW12UVh3Yi8xNXYwbmtSWjBEempqcitIWUhDM0tyTkppNFNLTERzRy9vSEln?=
 =?utf-8?B?dHhxa0gxMFFIQk1ManYvNzBGQW5yMitlUnllSmtrcjBFL01EUGhJNXRNQW5F?=
 =?utf-8?B?TFlwci9Rc3E3Q0d5cHROR25yVHg3cGV6aDhVWnJFLzVORlV6UGxXTGYwY2do?=
 =?utf-8?B?ekF6Uk1oR1UzMWFzWWpNN3JhNDFZMFA5RUpMS3VCY2NOUGhQdnEzeXUvc0dO?=
 =?utf-8?B?eDg3ZTlZZy9TbXdNL3lWdnF0YTFkRGdiMUxGdmFaL2tNUkRvSWJXSzJzWHJk?=
 =?utf-8?B?bURMcVVuOUk3b2ZXdE1ybW1QWUgwMVk2amFPU0EvUk5FVjJ0K1RsMTlMU2Fz?=
 =?utf-8?B?dU44dDNvY3lYbFBrM0JBSkpQeE5PUlhOOVA5d1NWQ2tWaHhPK0hhTFh4ODd6?=
 =?utf-8?B?MUlleEFmSlRRbmZlUTY5bWdhRWt6VVlMeWNDaDhncFFGa1lwc2hrTjQvK0ZS?=
 =?utf-8?B?d2tIbUZYN29GY2RDY1V1eU9hQWhRPT0=?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f6e535a-8e3f-4564-f007-08d9e617ef4f
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2022 06:47:52.5763 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Xq9xsageIq3VxPElh0PfJag/YcbMu+adsAHCqW7tYfPEAzoDv0yevJP8kjEylT7yh3Xu/SxQuz8oMlKKgt6aBR8KSYdq06ONC+Y5LvzBE0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9094
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] Update lapi/futex.h fallback
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
Content-Type: multipart/mixed; boundary="===============0231053121=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0231053121==
Content-Type: multipart/alternative;
 boundary="------------mA40S5CT5dESBmzbPz0XtQos"
Content-Language: en-US

--------------mA40S5CT5dESBmzbPz0XtQos
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

yes that's the idea. The issue now is that imports are bad sorted after 
tst_syscall patch and I need to create a v3. Gonna send it

Andrea

On 2/1/22 16:41, Cyril Hrubis wrote:
> Hi!
>> +struct futex_test_variants futex_variants[] = {
>> +#if (__NR_futex != __LTP__NR_INVALID_SYSCALL)
>> +	{ .fntype = FUTEX_FN_FUTEX, .desc = "syscall with old kernel spec" },
>> +#endif
>> +
>> +#if (__NR_futex_time64 != __LTP__NR_INVALID_SYSCALL)
>> +	{ .fntype = FUTEX_FN_FUTEX64, .desc = "syscall time64 with kernel spec" },
>> +#endif
>> +};
> I guess that there should be a followup patch that makse use of this in
> all the futex tests, right?
>
--------------mA40S5CT5dESBmzbPz0XtQos
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><font size="4">Hi,</font></p>
    <p><font size="4">yes that's the idea. The issue now is that imports
        are bad sorted after tst_syscall patch and I need to create a
        v3. Gonna send it</font></p>
    <p><font size="4">Andrea<br>
      </font></p>
    <div class="moz-cite-prefix">On 2/1/22 16:41, Cyril Hrubis wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:YflUp+c8DQb3Qgu4@yuki">
      <pre class="moz-quote-pre" wrap="">Hi!
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">+struct futex_test_variants futex_variants[] = {
+#if (__NR_futex != __LTP__NR_INVALID_SYSCALL)
+	{ .fntype = FUTEX_FN_FUTEX, .desc = &quot;syscall with old kernel spec&quot; },
+#endif
+
+#if (__NR_futex_time64 != __LTP__NR_INVALID_SYSCALL)
+	{ .fntype = FUTEX_FN_FUTEX64, .desc = &quot;syscall time64 with kernel spec&quot; },
+#endif
+};
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
I guess that there should be a followup patch that makse use of this in
all the futex tests, right?

</pre>
    </blockquote>
  </body>
</html>

--------------mA40S5CT5dESBmzbPz0XtQos--


--===============0231053121==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0231053121==--

