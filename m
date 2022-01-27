Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 263B6C433F5
	for <ltp@archiver.kernel.org>; Thu, 27 Jan 2022 09:46:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1D7D73C9742
	for <ltp@archiver.kernel.org>; Thu, 27 Jan 2022 10:45:58 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 514ED3C8CF5
 for <ltp@lists.linux.it>; Thu, 27 Jan 2022 10:45:47 +0100 (CET)
Received: from de-smtp-delivery-102.mimecast.com
 (de-smtp-delivery-102.mimecast.com [194.104.111.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 787D86006D7
 for <ltp@lists.linux.it>; Thu, 27 Jan 2022 10:45:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com;
 s=mimecast20200619; t=1643276745;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lXIMZiyuMSTn/+79mXZ6md6oaImTAc838+Py5i5AMbU=;
 b=hjVumrVwCxGHnvcVj5eVUjLHBvTQ0RdtEpWmeeiCRB6lzrwG6wASeivBmshPmAeoNYCAxL
 e9f1AHH6q9WGIX5kOuRW/k0kGPqwGAn+0KJduji1EDli3JJFLWHSuvkv/u2y6p4kA3yj5u
 W2w/LPUlyY4pZ5ket+pHd/xJ73PySng=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2176.outbound.protection.outlook.com [104.47.17.176]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-24-vbcJvEKuNoiCUPzFovFUBg-1; Thu, 27 Jan 2022 10:45:44 +0100
X-MC-Unique: vbcJvEKuNoiCUPzFovFUBg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P1QECLzXqTeXdsbGqioKm3X6THrKZT6Nk+o5L9cRSS+Dw9qTrvwmbCMG8p0MS7fQl35Vt9isipoLAGPotAZ7qix3yCEexHT+3HBS1VBjBPg2GkAW6KBYq7nnGBn8txNJ43ZSq6RfO87rbaJYfFFOWvDXU2nxeT7mNLcihJw5hCKyk+lZkRcQ9IxnhwX5xJ+vUezWnPHFE4931alLiZNYAQSK0SkgbvieALWlfKiGIqQEzbWE9xejygtX5Km0/qZEzbPySRWqT34o8YhjyqJUf5gdSmZRsjr81V/+f01BA61aRGY4erAB2CFHyKjlsQhOfd+rom4an5cxpfBp/Gt3uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lXIMZiyuMSTn/+79mXZ6md6oaImTAc838+Py5i5AMbU=;
 b=nh8hh22DLWMCW8Y3eoIg4bTOVBsmqYv+5+TjLBkEJscwUDaRaJQccX3lk/DG9W1oadvb40ox8b2TZ0nVUsMP5/iV6QJCwoSapt8BSPXKfm7NA+RnNtxudyEBqRtwpG26mucUY3vjHaM/X09bl/GgI19QS+ulzILq1CROWVoBrH/5g28ExXZsbLJynivxVX0hjR4BIc4x+LGUj8bUBXgS6WMw64YHKOythDcMLF93QPTToBrypkWBz1imz8aCe4ijR0/YI4IcyvdFTLUZS2VynuAN+sFUvNbvIBYIzKoQDTzBxWJBNpfPa4WjSeLaiCCqL4Z/70GXwAgYH/Ee04RLfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by AM6PR04MB4936.eurprd04.prod.outlook.com (2603:10a6:20b:8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Thu, 27 Jan
 2022 09:45:42 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::a895:c953:d25b:32c7]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::a895:c953:d25b:32c7%5]) with mapi id 15.20.4930.017; Thu, 27 Jan 2022
 09:45:42 +0000
Message-ID: <ea123d89-8710-3901-4f30-500b84971235@suse.com>
Date: Thu, 27 Jan 2022 10:45:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To: Jan Stancek <jstancek@redhat.com>,
 Andrea Cervesato <andrea.cervesato@suse.de>
References: <20220126140520.15904-1-andrea.cervesato@suse.de>
 <CAASaF6yH_ToYj0-OVWTi-iHStrY3m-YQbB0Kczo4v-Y8Y_dQfQ@mail.gmail.com>
In-Reply-To: <CAASaF6yH_ToYj0-OVWTi-iHStrY3m-YQbB0Kczo4v-Y8Y_dQfQ@mail.gmail.com>
X-ClientProxiedBy: AM6P191CA0011.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:209:8b::24) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a288b23-1080-4816-d33f-08d9e179c89f
X-MS-TrafficTypeDiagnostic: AM6PR04MB4936:EE_
X-Microsoft-Antispam-PRVS: <AM6PR04MB4936AA9FCBBDD11B6DE2B954F8219@AM6PR04MB4936.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1443;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Alf5TSQfihdy2Rfyvl7nUWLghFU2q3InpGF2RbEUbkWdhXUf1NRx23Q+hSvHDAV9iNdc1QSby6GhU7oJuswz2lzIXAMW9FPZBSDqIgMBZRLIHotdaUrbm0XjFcfBatK0YenWHvaVUyoZFPXu01UxGsz/F1sluBx6n9BB3tEA9gZXRGPtyXEVYw5yAcB7y9OAQJui++hKcRtAc8WIDXxEo+b4zyK50ECn5IZT3ogx+FiKyV1IWOBj68ytM1M7MDopQqxDpf4pEI+EEBqL4IsPPxLN5GKjUimLhFEGWj+yzGmLNMf/NOjsh8UIGtwPMfHoBLp5Lv2UM9paYmlxOvO1bubEtSLe8jIAhIp0NfbwoOMGSCmDsTP7gEXE9X5ydvEkj7OBuRLRZbnlO8x03KgxG+/ETScUZwLJPGEnmb3xmag7cJZlbM4JL4dTvxn9quGULMrGPzCSonH/ZrTiTOm8PYdAzVtKbLlnz+Cx0j3mGRPiIIx5Bgljb513fUu4zkerEDKmHIIvj0EQ6V1xoG66KPv96HUyoIhxi/+3Fptj2VY2DBjJLy5FU9y1XVmjTVwYrNTy2xpvHqFzl1Ijppmuddgg3Eg/pCNFO3F1XRy++uEC/iQwvQuojk4itur6FxfrX+AftCBgtG1m+Nfi95wubu7gsyCBBVv0VxWiu4wIhWG//Y1vidY0N0JYucoOH6kbXCvPvBib63oCXT6950xnu8I1GcEaVf5dkk5BrH+Ziqc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(31686004)(33964004)(6512007)(2616005)(6506007)(186003)(31696002)(26005)(86362001)(6486002)(508600001)(53546011)(66476007)(36756003)(44832011)(8936002)(8676002)(66946007)(66556008)(316002)(5660300002)(110136005)(4326008)(38100700002)(2906002)(45980500001)(43740500002)(20210929001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b29jVnkxKyt5bE1YZGZ0bGdKc2oydlBacG0rRm0xem1lemRQRmplTGR3VUIw?=
 =?utf-8?B?OEF0MEY0MG1malpSQXBxUmR6cFNyZ3VoNzZiZEFBaFRkWmVJcmJIaVJ6ZFU5?=
 =?utf-8?B?RDY0d2tuWmdDNkpxQXZaZCsrRWxXdkhNZ3VtcFFRU2JsQmQ1YWhBb0pmWjZQ?=
 =?utf-8?B?WTd6ODF4UktzK1psaHNuRTJvTkxZWDNHMUtiYzhFR1IxaThGcHo4RGJlS0Q2?=
 =?utf-8?B?MWJ5c09KWkw5YkdKVDhXeFErMk1Fcng3VFcwTkUzYnNrOVZCUE1HdU54ZEtL?=
 =?utf-8?B?UnF4M3ZvTDdTK0pVLzIySHhBcDlXbGlNK0hLTEdoMWo5T3BTcnJqTnkwZ05D?=
 =?utf-8?B?T1hHTElncFJuNUljZGxobFo2WEFxUVBiVUtHZmpTeHErK2VaWThONVFBTTBS?=
 =?utf-8?B?bHFFSnJCLzFRcFN2TjBETGdjRFNNTnFIb0FyT09FdkxJQ3pLeVdxVUxkMUFk?=
 =?utf-8?B?SlJFazVLNG1vQmFlMGZnWVFvTUJneUd1UUNQT01hRzBaLzVEaUF5L002czRp?=
 =?utf-8?B?MTk5V1NKeHA1RHRlRi95WnNuOWtZYkM4a1d5TXB0VjZvRE14ZVJLdmx0azBu?=
 =?utf-8?B?UC9VZlJaeFN1cGUxQnhoSERET3ptVi9rWWE1VHVwZVFNUFAwdjE1VjNaK0lK?=
 =?utf-8?B?REd0OXlJVi8vdjBWTnVyYTlVMWlJb1NGMy9RWkRhcytHT1UydzVwSUhCWDlS?=
 =?utf-8?B?UlV0YTl6bVJURExlZk5GTVlINzRPdEx3USt0Zk56Q29KVlUveDIxOVVyaGR1?=
 =?utf-8?B?VmdHaGtEQzNmbTV3a1Iyck9iUFk0WGxzRTQrTldNelFBZFlCYTcrRGF6TjRY?=
 =?utf-8?B?RFlmKzhEZHZDMVlsTWQ5VUQreDQyRG5rUG50cVhMNjdCbE1udGM5NFNBenpo?=
 =?utf-8?B?dm10Q2kxaHR5NzhSRW1HTWxkSzBsN0VaRUdER09yWFJaL0JjL0kvMm5DdHlK?=
 =?utf-8?B?dDBQbzUwZDBINlNBcDkrWjRDQUpMVnZBblNoTkgxNWszRW95TGR5SGNPeUNT?=
 =?utf-8?B?cGZia3Vydm1TeE1uZUhZVlBUcnNydTc4OHRQQjVQWDdCZW1GUGk4bkJsQ1Vl?=
 =?utf-8?B?TkZNaXlyOUpINzU5TjFxZmJHU01OQnkzZ3BnVHMxS3lLYWJvVlBkNW9jRmg3?=
 =?utf-8?B?Q090dTFabXNtV3hXUFVjSC9takVqR2dUY0E2bWhBYXZKM3lRQm1Zck1KRWxD?=
 =?utf-8?B?VmtWZXp3Wi9UcGRJQ3MvaXJQZWNyUUVGcm5oUm1PUXhORkF4OVE2VURzb1Fa?=
 =?utf-8?B?eEV6dkltMTM3eHAxYnBkcEVUUjhad3RuL1U3QURLOE1XWFlnMzVEWFR1RkJS?=
 =?utf-8?B?UVFOdFNpWmpOZG1Fam9aZFM3MENJVVJ1dUNBYytPSEp6b2czeStiYXJnQUtu?=
 =?utf-8?B?Vno3WURnRDRHZFgxLzVrSVA3bDN2SlY5dWMrSXRIbU9yQ2xIUVBqVEdoZWpT?=
 =?utf-8?B?SE1SYmh0MDY0dmY3Tnd2V3lGRHpBWE5tNDZtL1F2ZkNQU1dYYmIyMXBmQS9q?=
 =?utf-8?B?NElhTW9rYm9haGtUVHdTUEdaNUw5c3U0b01Kb20vck5xdE1WRGtnOXUzcFRU?=
 =?utf-8?B?UWVzaFJWeW1SOERoVkhYanEwQS9lMTdybmczS2gzU2JWUUhNNlBLL21KWXQz?=
 =?utf-8?B?UVJTMHRSeDcxQUFacUpNQWtqa0w5Kys4OU00WVVxelpCbGt6OU14QmVna2tE?=
 =?utf-8?B?VXZWL1ZabUE5STNTRmN4Q05JQTdCSjN4dU1HVmRxOFliQ1JTVUZQZlVrVmgw?=
 =?utf-8?B?UHF0QVJac0xXbXQyMDdXcVd3b3dpTXFHRzNhTU1LRjYzMzJYb29abGlHMFlZ?=
 =?utf-8?B?aGs3eEt2WlJ5VWFWQ0lydGlSdWwvdHRFZkVVU1dESlhNTXloQ0dheUVCcTlL?=
 =?utf-8?B?TDdsc1EzdXRudVE0TlI4WkE3WlJUYmRqbFFHeElpSDRGSWJNRHJNYW9nTDR1?=
 =?utf-8?B?QXh6dFhOTG01cHNZaEtKR01hbDVaa1A4REFxNk5xL2JQZ1BzVUtTc1NQZ0hh?=
 =?utf-8?B?NjJuSndJL2ZYZlA0Y1pvbVRTdDlFRUk5azZmdllsUGpjK3g1ZVE2VkVvdFdy?=
 =?utf-8?B?bGpnRENIQU5tS1VQamJrK2oyL0RVWHZPMytIaHBPZG9NaVpzMUNkWjRsMnN3?=
 =?utf-8?B?S1VTL2toTnErMlJ4WFBJMUdBeFFha3VHTkQwbGFUQVl2QTVJa2ZRdHZ6MVly?=
 =?utf-8?B?QUIvRHVvTlRnK3l0bXgybUFZVUVTeVBXU1A4eHNUbFR2amNsTi9FY3dQZTk0?=
 =?utf-8?B?YkFMT2IwOE5kbUp1YS83VW5NVTh3PT0=?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a288b23-1080-4816-d33f-08d9e179c89f
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 09:45:42.5032 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yBev/Ex7DSPzWhbYEv+1wqmaJsHVaf3Zti1PGihC3PL11JJrLjNNZ6zabvF49K6slXrTRZRX7HixQBM3BNv+pyO61HogoIYmwkfLoM+Zs30=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4936
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Rewrite process_vm_readv03.c test with new LTP
 API
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: multipart/mixed; boundary="===============1830236827=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1830236827==
Content-Type: multipart/alternative;
 boundary="------------dqkGEtkBPOvPMNQqCvNtzzhH"
Content-Language: en-US

--------------dqkGEtkBPOvPMNQqCvNtzzhH
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi!

that is definetly an error I made during patch re-write. Gonna fix it

On 1/27/22 10:38, Jan Stancek wrote:
> On Wed, Jan 26, 2022 at 3:05 PM Andrea Cervesato
> <andrea.cervesato@suse.de>  wrote:
> <snip>
>
>> -static void child_alloc(int *bufsz_arr)
>> +static void child_alloc(const int *sizes, int nr_iovecs)
>>   {
>>          char **foo;
>>          int i, j;
>> -       char buf[BUFSIZ];
>>          long count;
>>
>> -       foo = SAFE_MALLOC(tst_exit, nr_iovecs * sizeof(char *));
>> +       foo = SAFE_MALLOC(nr_iovecs * sizeof(int *));
> Overall conversion looks good to me, but why this change from "char *"
> to "int *"
> when foo is char **?
>
--------------dqkGEtkBPOvPMNQqCvNtzzhH
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><font size="4">Hi!</font></p>
    <p><font size="4">that is definetly an error I made during patch
        re-write. Gonna fix it</font><br>
    </p>
    <div class="moz-cite-prefix">On 1/27/22 10:38, Jan Stancek wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:CAASaF6yH_ToYj0-OVWTi-iHStrY3m-YQbB0Kczo4v-Y8Y_dQfQ@mail.gmail.com">
      <pre class="moz-quote-pre" wrap="">On Wed, Jan 26, 2022 at 3:05 PM Andrea Cervesato
<a class="moz-txt-link-rfc2396E" href="mailto:andrea.cervesato@suse.de">&lt;andrea.cervesato@suse.de&gt;</a> wrote:
&lt;snip&gt;

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
-static void child_alloc(int *bufsz_arr)
+static void child_alloc(const int *sizes, int nr_iovecs)
 {
        char **foo;
        int i, j;
-       char buf[BUFSIZ];
        long count;

-       foo = SAFE_MALLOC(tst_exit, nr_iovecs * sizeof(char *));
+       foo = SAFE_MALLOC(nr_iovecs * sizeof(int *));
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Overall conversion looks good to me, but why this change from &quot;char *&quot;
to &quot;int *&quot;
when foo is char **?

</pre>
    </blockquote>
  </body>
</html>

--------------dqkGEtkBPOvPMNQqCvNtzzhH--


--===============1830236827==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1830236827==--

