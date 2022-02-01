Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC2EBC433F5
	for <ltp@archiver.kernel.org>; Tue,  1 Feb 2022 09:27:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0B2613C9858
	for <ltp@archiver.kernel.org>; Tue,  1 Feb 2022 10:27:29 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EE5A53C980D
 for <ltp@lists.linux.it>; Tue,  1 Feb 2022 10:27:19 +0100 (CET)
Received: from de-smtp-delivery-102.mimecast.com
 (de-smtp-delivery-102.mimecast.com [194.104.111.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 1230520074D
 for <ltp@lists.linux.it>; Tue,  1 Feb 2022 10:27:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com;
 s=mimecast20200619; t=1643707638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mqxJOk78OKCpr9QppKFctPwP9hchFa2Lc89mgkG2EAQ=;
 b=BpNQvqWSNe4oUrzLetVRlvzqrNlL5FoCbSMODHq/VMWtHBNk78OPZi3wBXEAOlyY5hpZ7B
 +UHGdhZXVxyiD7r9mW/HCNEyt2ltf3l54QH4HzY0/k8IjOq9WlA2TkfeToEa5YPD0eOlPK
 v4GITAR8RqA7nClbOG2rfKZ434cgtbg=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2107.outbound.protection.outlook.com [104.47.17.107]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-16-3A8ux_jcO3G3XYVePfqLtg-1; Tue, 01 Feb 2022 10:27:17 +0100
X-MC-Unique: 3A8ux_jcO3G3XYVePfqLtg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J0ZX526u8LHO5B/r8ZUTSKJdD7Fdk/o0c4GqJZBHhrpJBUMEsdHx1aJOMi85tbMI27T+y2wzdGOl31RiluE13OgbyPiwRODjPZZ20oQLysQZXc2fFsl0yxyX+o8gSC9gk+hAd6eATWg9O2r2yRZ0ZvRh6l3eUDnF1uiq+xl39vClJGuXqTvAedVcUEKtiTdfVoNn2VB8Feho1QKQrYmWR0FrkBVzGgOdmzz1J3tqa/u4XvlwirMv6RE6phpWh95yjZ7pCcJRH3rze0wr0Z5mpd1CDBW6gzz7eZ3qIJibaCt0C3WspQkP1LYZckQQ51r0cQDnT5p1OludLPVuA0LvKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mqxJOk78OKCpr9QppKFctPwP9hchFa2Lc89mgkG2EAQ=;
 b=IILVWG2aTWzBaiFjCLSFVgm/cZfMQ+ot7Es0LQW+E0D+1oMNvQvXiyvFyUWQbhXcIGRgmixoN117z7sp0+iTh+UAiYbDPQ6ONT9nkMTgXlowhVHgUvyIBXNm4pxcTJOFxq4MgEqLVX3xxmreRufKgQNYQryWJE4qc/d2v6tFkrdLAc4JO9dyWdGLkMuVILQ6azf+s6EVAjJhXfMr987902QOy7nybP4dcIPGclikeXR2ctxYPtigKBEDQWBXWdDzwCzeInqdpzGfZcV5AenKdbobNuxVI7AZhRZsWwQZQ6sOqCKzr+iIvjeHfZ2j0w4fctT+XPYnhnVB6kzYUgllcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by AS8PR04MB8514.eurprd04.prod.outlook.com (2603:10a6:20b:341::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.21; Tue, 1 Feb
 2022 09:27:15 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::a895:c953:d25b:32c7]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::a895:c953:d25b:32c7%7]) with mapi id 15.20.4930.022; Tue, 1 Feb 2022
 09:27:14 +0000
Message-ID: <da73971c-8eee-5ba5-7e6c-8896f51b294a@suse.com>
Date: Tue, 1 Feb 2022 10:27:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To: Cyril Hrubis <chrubis@suse.cz>
References: <20211216093115.23982-1-andrea.cervesato@suse.com>
 <YfgL37etm9C5/Bte@yuki>
In-Reply-To: <YfgL37etm9C5/Bte@yuki>
X-ClientProxiedBy: AS8PR04CA0054.eurprd04.prod.outlook.com
 (2603:10a6:20b:312::29) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 347bd095-c191-49e2-53f0-08d9e5650874
X-MS-TrafficTypeDiagnostic: AS8PR04MB8514:EE_
X-Microsoft-Antispam-PRVS: <AS8PR04MB851403540CA081976EEFF767F8269@AS8PR04MB8514.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LxzVX3xRFPXbagGKbq4u4Et8k7lJFVVbSlskTtb54J6TMFgf2v3mjoJuimkDMvN9AV7G8ETCnzAPTRrYeiSnF2FzM+T5Uw3AXdGsetMrrlE39Up9T0PP3NlHPh1sz2um6G6MLn5cBS0BV0QKZOpzDmRa2U2WaXdFmwXQ+DlFuWGLcrl3GvrhgZv0fdZa3TinJMt1dTRBlDBXnNL1ZY/67e5/3/RSqzW7BOhr96Qs1uVyhhxHsXTWwGhssXRWybbKsNQSFant9GCfrrXOveF++akKJV0PfsoT96bSubsyTUwODGnhP8rdH0fXHW4iDHYr+rQGtmzAmKt/pLid7/UM7WdSYHk+SAsqGbme9gRuA2oP61bPTBbHtcT86yLgfNlZGqaiAvQ16Gs5VOOpWXuozo/zOiuTJ7zPSj1brJW0QeE+kiUo6Fxz/BBxfY2w2N5Fn/xDlAhurhGHK6Q9uwoDEFKWGRc/t/p5UTdZJq3KyPWeyb6IJDq7n1RfebjhKisk7snvSWgguW86ZgWDcFRW8cjJXYE8rI2SLaXCepZdrdxRP7j3om8528Tn5mIKIF5lpUwfauVo5uX5h+RTZAtThgXB8y7n46kiADPoCd/ul8aJuP75Y8xwjRZ/mJ0k4KpGE+HFwRNj4JycUu8bp7hyKjBBftNhu1uUXTbqph1O8jVnmED+O+PwYC+MG/im9jrBVl1USC+aWsHSh6sj1eCksifv0wKfGT7rijR+YYgmOpCPDEemZjBvDX7/yCB4QrQojnRLeZTP9Ie2Q9Hsf00aDA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(8936002)(8676002)(4326008)(2906002)(86362001)(83380400001)(31696002)(66556008)(66946007)(66476007)(38100700002)(6506007)(44832011)(6512007)(53546011)(26005)(6486002)(36756003)(5660300002)(508600001)(186003)(31686004)(2616005)(316002)(33964004)(6916009)(131093003)(43740500002)(45980500001)(20210929001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WEs0TW1vaEZhbHlhaGpqNkZnanhZSHhNOEtmanFHaXBVcU8xOXBEcmRBU0Jw?=
 =?utf-8?B?R1JhcDlvMGtnNkRyQVh1ZC9RdEU3YXZoL2VHWk5aRlJiN3oyZkNPZTNad2NH?=
 =?utf-8?B?Y3JTVjcwcHRLZFRxK2MrMThETU1Fb005a2dwR3NEd2htZE1vcGhzK2dxRGli?=
 =?utf-8?B?bmc3UFh0OGJnaHlYV2ZzVXo5UnNqNnpSUEJpYktlRUd1NDA5VnpISm9ybnFP?=
 =?utf-8?B?VFNzQko5QjI0SGNGU0Vab3htU0ppcVUxM3RCYXJoYlJTNWExVnhyelRUamMv?=
 =?utf-8?B?azJzTjBmc1RaMFczelUwaFdhREZTeUtTYVNVZnhaRCsxbkJQemx0TExpUGFV?=
 =?utf-8?B?RHZKZ1VIOCtMU0t3NzlBU3cyMGkxQUVZZStCVU5UaFVUNDlCc21uRFpMNjBM?=
 =?utf-8?B?Y1JVNDRqRWNDaFdHNEtiK25VRXRKY1V2WVhuWmVFa0EzTUZucHdMcS9NT0ZB?=
 =?utf-8?B?Y2tKbDNPWTJ6V0NqZ0Z6U3RGOS9JM1RXMTZMOHF4ZnczYXhhK3Y1QklCdjdD?=
 =?utf-8?B?V2ptVkRtRUxZTHRsd2wyOUxLQTVKTFgya1UrUUErUXhhWHRPNFp3SW43MlZ2?=
 =?utf-8?B?WHhMRW01Y0lveUwvSm9VMGRnc1J2OFBxbW1BWGVWNSt2ZHdMWDV3blFQbmU3?=
 =?utf-8?B?bEJMM0NNYWw3WEFjZGpldkV3a2tkalZjcWpQOGJJNDFCOFhGVXhFWG5Fdzdy?=
 =?utf-8?B?L0lqVnZOcWFhMzByUERuTXg2LzllMHlzcnh5UTVsb3ZjbW1LS1J4S0ZKa1FN?=
 =?utf-8?B?U3hEbmlSejdhL2o1aG1Kek5uVnlrVGhaSEFyZU55RWZ4b0Z0TmRPWmkvQzBB?=
 =?utf-8?B?SGxXTVhIckMvaTRjSFZXR3FWUW16L2xxMWpYSmsxWHJPUHUyQks2b3ZxM040?=
 =?utf-8?B?Q1ZMaVhJR3lNVEozcmpXSVlCYkVNRlo1aXRGc0p6UngvcFBZdlErSG9ET0lv?=
 =?utf-8?B?V3Q2aHZwYWJTKzRCQ3FDczMzUXBBN3VoQVEwTUFNQU12bkJDdE9rRm43Q0ZC?=
 =?utf-8?B?Q215eERFRFl0bUlOTnlWcGU2T0wyVW5yallOR3E1a04zekdtSFBYMytHUmpX?=
 =?utf-8?B?ZmVqVXNrTzVzaFFHOVFNcW1adlgvdUtqRjN2YU5VUDh6UGNuVjEvUE9iMldP?=
 =?utf-8?B?bjFlZFJTVUdPUDBZdCtIWVZtbzJva0dQN1FYb203WFVaUTdmUTdHUnNhNUF1?=
 =?utf-8?B?NjRtUVFxb09Ka1hKcFpYVm9oT2pRdGthZGVCVjZkeWNNaGticVZrK2kvTFli?=
 =?utf-8?B?aW14M0U3YUZuNkQyL01FOUdieVVxTE5yYmwwUHl3ZmZGZnR2Y2QwTXVWeml3?=
 =?utf-8?B?aVZGUWxreDgxbk1Qclh1ZjRWSSt4TjZLZTlTMG9XZks5eWRIRVpiVlBTQkRZ?=
 =?utf-8?B?d0FsTDRBTW1XRTNkRzB3REU2NGIzY3JkMWd0TVVieHB6YTIvNnVjbm0vRENV?=
 =?utf-8?B?N1hmVlczczQzRnRSb0V0TENjcG5IU3ZFNHJWbmJOR2NaUEpjZlRwSEdNQmdJ?=
 =?utf-8?B?dnF1UXpSbnhoOGhndHZMRFk0RXZpUXl4Z250SENab01SNFp6Q01tQUx5UXlS?=
 =?utf-8?B?YjJPT0k3K0JWVjlyQXEzbEJrYVlmZVV6TjJyd3ROcDlsTlE3bHN3NDhKcTBE?=
 =?utf-8?B?cExIb1RkTVgxQ2RuRUtlTzJmMTN4Z3J0b2pWb1A4VzBmYTNrbGowdDh6NSsz?=
 =?utf-8?B?a0EvK1VRVHJWTHlGemx5TkQ1MHRDZ0JHNnR5ZmZBVXhYOU13dGNPZlMwSFJv?=
 =?utf-8?B?UWRPczA1bnF1d0w1MzRjd21IQlZPTnRJeFdWNHJSeTU3Q3RMZWtiejVKZ0k3?=
 =?utf-8?B?WmZ3d0N3cGpFN1pUMlExeTVWV0dEYi9SblJtWW1aZ0orNUFIY1dYMnlHTlFR?=
 =?utf-8?B?WjNIKzZpNzR5czErUTdNUjZiZUlISnlnU1d3Y2pPajNFWWV3MGY4ME85OWJD?=
 =?utf-8?B?QndydjhrWVZxUUNKanRScHM5NXZ6bHRLU0ZmU1V3RUZpaVo4ckdqYTl0TWZ0?=
 =?utf-8?B?djJnbzN4MWlVNElua2lhYzRkRTgrdk9aVld3TzJLWmNsRmF0RkUvUU54QmM5?=
 =?utf-8?B?MEJldko1WFlLdUhoWlpCT0VzdG1vWnM4YXQrUDY2SVVIYWltRG5wMzdzeTZO?=
 =?utf-8?B?ekFpejIwZjByaDcvbXU3cXZpMnZISVl6ZkRZZForQ1lBK2lpLzRzVm82RDJI?=
 =?utf-8?B?VElIUlNYTFQ2WHBENVlnRlFzVk5oaUY2TVQzcmx6OW9rMmQ1bHRRV0o2RVFr?=
 =?utf-8?B?YlZsWWU2NzcvR0d5QkQrUHhTNUpBPT0=?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 347bd095-c191-49e2-53f0-08d9e5650874
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2022 09:27:14.7653 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 48DxSnqHAdrqMaNWxAWi8SY/lih+57LNQdPUokhgtsohW3l7utLuxE+xAyfvB/OwgRfG1PCPawekblfVuR78Rfa0bHbQCpUpnsTuaEwpKuY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8514
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Check for maximum available pids in
 dio_sparse.c
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
Content-Type: multipart/mixed; boundary="===============1419663056=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1419663056==
Content-Type: multipart/alternative;
 boundary="------------Gijsdvi1Lx4LUXS82ZMKM3dS"
Content-Language: en-US

--------------Gijsdvi1Lx4LUXS82ZMKM3dS
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi!

On 1/31/22 17:18, Cyril Hrubis wrote:
> Hi!
>>   static void setup(void)
>>   {
>>   	struct stat sb;
>> +	int max_pids;
>>   
>>   	numchildren = 1000;
>>   	writesize = 1024;
>> @@ -69,6 +70,13 @@ static void setup(void)
>>   	if (tst_parse_int(str_numchildren, &numchildren, 1, INT_MAX))
>>   		tst_brk(TBROK, "Invalid number of children '%s'", str_numchildren);
>>   
>> +	max_pids = tst_get_free_pids();
>> +	if (numchildren > max_pids) {
>> +		numchildren = max_pids;
>> +
>> +		tst_res(TCONF, "Number of children reduced to %d due to system limitations", numchildren);
>                            ^
> 			  If we are going to limit the number of
> 			  children this should be TINFO
>
> And if we are going to skip the test it should be tst_brk(TCONF, ...)
>
> Either way tst_res(TCONF, ...) does not make much sense in this case.
>
>> +	}
> I guess that we should do a similar check in all the io tests that fork
> children, so we may as well put it into some kind of library function.
Yes, this can be done in another patch for all the tests
> Maybe just the common.h with something as:
>
> static inline void check_children(unsigned int numchildren)
> {
> 	if (numchildren > tst_get_free_pids)
> 		tst_brk(TCONF, "....");
> }
>
> or:
>
> static inline void check_children(unsigned int *numchilren)
> {
> 	...
> }
>
> In case that we want to print the info message and modify the value.
>
>>   	if (tst_parse_filesize(str_writesize, &writesize, 1, LLONG_MAX))
>>   		tst_brk(TBROK, "Invalid write blocks size '%s'", str_writesize);
>>   
>> @@ -129,10 +137,10 @@ static struct tst_test test = {
>>   	.needs_tmpdir = 1,
>>   	.forks_child = 1,
>>   	.options = (struct tst_option[]) {
>> -		{"n:", &str_numchildren, "Number of threads (default 1000)"},
>> -		{"w:", &str_writesize, "Size of writing blocks (default 1K)"},
>> -		{"s:", &str_filesize, "Size of file (default 100M)"},
>> -		{"o:", &str_offset, "File offset (default 0)"},
>> -		{}
>> +		{"n:", &str_numchildren, "-n\t Number of threads (default 1000)"},
>> +		{"w:", &str_writesize, "-w\t Size of writing blocks (default 1K)"},
>> +		{"s:", &str_filesize, "-s\t Size of file (default 100M)"},
>> +		{"o:", &str_offset, "-o\t File offset (default 0)"},
>> +		{},
> This part is certainly wrong.
>
--------------Gijsdvi1Lx4LUXS82ZMKM3dS
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><font size="4">Hi!</font><br>
    </p>
    <div class="moz-cite-prefix">On 1/31/22 17:18, Cyril Hrubis wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:YfgL37etm9C5%2FBte@yuki">
      <pre class="moz-quote-pre" wrap="">Hi!
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap=""> static void setup(void)
 {
 	struct stat sb;
+	int max_pids;
 
 	numchildren = 1000;
 	writesize = 1024;
@@ -69,6 +70,13 @@ static void setup(void)
 	if (tst_parse_int(str_numchildren, &amp;numchildren, 1, INT_MAX))
 		tst_brk(TBROK, &quot;Invalid number of children '%s'&quot;, str_numchildren);
 
+	max_pids = tst_get_free_pids();
+	if (numchildren &gt; max_pids) {
+		numchildren = max_pids;
+
+		tst_res(TCONF, &quot;Number of children reduced to %d due to system limitations&quot;, numchildren);
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">                          ^
			  If we are going to limit the number of
			  children this should be TINFO

And if we are going to skip the test it should be tst_brk(TCONF, ...)

Either way tst_res(TCONF, ...) does not make much sense in this case.

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">+	}
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
I guess that we should do a similar check in all the io tests that fork
children, so we may as well put it into some kind of library function.
</pre>
    </blockquote>
    Yes, this can be done in another patch for all the tests<br>
    <blockquote type="cite" cite="mid:YfgL37etm9C5%2FBte@yuki">
      <pre class="moz-quote-pre" wrap="">
Maybe just the common.h with something as:

static inline void check_children(unsigned int numchildren)
{
	if (numchildren &gt; tst_get_free_pids)
		tst_brk(TCONF, &quot;....&quot;);
}

or:

static inline void check_children(unsigned int *numchilren)
{
	...
}

In case that we want to print the info message and modify the value.

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap=""> 	if (tst_parse_filesize(str_writesize, &amp;writesize, 1, LLONG_MAX))
 		tst_brk(TBROK, &quot;Invalid write blocks size '%s'&quot;, str_writesize);
 
@@ -129,10 +137,10 @@ static struct tst_test test = {
 	.needs_tmpdir = 1,
 	.forks_child = 1,
 	.options = (struct tst_option[]) {
-		{&quot;n:&quot;, &amp;str_numchildren, &quot;Number of threads (default 1000)&quot;},
-		{&quot;w:&quot;, &amp;str_writesize, &quot;Size of writing blocks (default 1K)&quot;},
-		{&quot;s:&quot;, &amp;str_filesize, &quot;Size of file (default 100M)&quot;},
-		{&quot;o:&quot;, &amp;str_offset, &quot;File offset (default 0)&quot;},
-		{}
+		{&quot;n:&quot;, &amp;str_numchildren, &quot;-n\t Number of threads (default 1000)&quot;},
+		{&quot;w:&quot;, &amp;str_writesize, &quot;-w\t Size of writing blocks (default 1K)&quot;},
+		{&quot;s:&quot;, &amp;str_filesize, &quot;-s\t Size of file (default 100M)&quot;},
+		{&quot;o:&quot;, &amp;str_offset, &quot;-o\t File offset (default 0)&quot;},
+		{},
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
This part is certainly wrong.

</pre>
    </blockquote>
  </body>
</html>

--------------Gijsdvi1Lx4LUXS82ZMKM3dS--


--===============1419663056==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1419663056==--

