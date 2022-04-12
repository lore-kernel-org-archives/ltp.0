Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42F3FC433F5
	for <ltp@archiver.kernel.org>; Tue, 12 Apr 2022 12:45:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 476863CA545
	for <ltp@archiver.kernel.org>; Tue, 12 Apr 2022 14:45:22 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6766F3CA49D
 for <ltp@lists.linux.it>; Tue, 12 Apr 2022 14:45:10 +0200 (CEST)
Received: from de-smtp-delivery-102.mimecast.com
 (de-smtp-delivery-102.mimecast.com [194.104.109.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id B95031A00889
 for <ltp@lists.linux.it>; Tue, 12 Apr 2022 14:45:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com;
 s=mimecast20200619; t=1649767508;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XgSYiVGXVVVmW5wizqND/+JCdXOOmGnsvpPLYxdeNDI=;
 b=ReYTF090uznrV54tNTZag5gfjJmaCQHkuAx9kNkIOe+W7GFKtE6r2uYBuC4twpkWWzC7i8
 03WqFl+sydi8T8WZjZidIQ0jNVqDl38Jhso2gr4/yUgZjwM3V4O4+GoN6VXW9J4/ITfvce
 7B6eT97d2sDfHZQo3AohQNNHOoF+iyU=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2058.outbound.protection.outlook.com [104.47.13.58]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-9-VIq9cdjENbG85TLf5Tm67g-2; Tue, 12 Apr 2022 14:45:07 +0200
X-MC-Unique: VIq9cdjENbG85TLf5Tm67g-2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=frdONKtyHH7pqUdUWHjT983QQiTtuf/thdMbzRhJpou0qbvOf90rQNlhzOxttAHrO0oB265We4KptOYqOGsYkGyUQrb0pqv6ZcjSqlaJ/uQcMXL9e93AXRFPIk3dzOOR3fanQCHezx9k64U4g57uOVdzN7WkHppdAqL/s1434APokdduvb2Ruk5fDhVJwwZj0w7KtlPUirFqKX9uf1bp/dnoD/OuMzHpupUEbMdGxYwo0df28ky8yp9qjxAmRl5YbIw8MhKx0CtS9rHY30AbtzwAtEJpyVH4TbW1vNcnfEvcyRyOo4NUAKUZcId0pHeY3kxE0tvtpW3YcEbfE8hdrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XgSYiVGXVVVmW5wizqND/+JCdXOOmGnsvpPLYxdeNDI=;
 b=cN3nXavuGzv5sfuyx4RBUU/HLxU27Z5dSQ2r32iVdJML2zeKjpUB0wCmxZhdmvKNVcjC6HnAeiU3vtlnIzN8tw9b/khtWIYFSHpuKAQyPJEaunvHmI7Apb/HqkdzRHH1Q0SlIOOBP5KlKsjhBEUS327ppgMGo6ko7SUJv5YZ4nFMFOdDGvR1z/B7oFTmryZOTasp81zTGDw/M1ITw5/aj2fyziJILGikvH85FLqPIp0eic/m3cjJYHz8vCABgPvsiMXCL61fw5OLqtPCcIbDZCzVj+DrpgnYxY/asqGYjNsm51N6qpcr25eDUScNl5UXVg+6mjYsNyI+i+nxrxwhKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by DB6PR0401MB2375.eurprd04.prod.outlook.com (2603:10a6:4:4a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.30; Tue, 12 Apr
 2022 12:45:04 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::1504:3316:3ce:7b0f]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::1504:3316:3ce:7b0f%5]) with mapi id 15.20.5144.030; Tue, 12 Apr 2022
 12:45:04 +0000
Message-ID: <b886f571-6f5f-3521-fdc0-d1239eeacbe3@suse.com>
Date: Tue, 12 Apr 2022 14:45:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>, pvorel <pvorel@suse.de>
References: <20220330090817.21950-1-andrea.cervesato@suse.de>
 <1faf27214b18ef9d3237734388342308@suse.de> <YkVIXjarbhum1eux@pevik>
In-Reply-To: <YkVIXjarbhum1eux@pevik>
X-ClientProxiedBy: AS8PR07CA0044.eurprd07.prod.outlook.com
 (2603:10a6:20b:459::17) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 486beace-f24a-4150-dbed-08da1c82445c
X-MS-TrafficTypeDiagnostic: DB6PR0401MB2375:EE_
X-Microsoft-Antispam-PRVS: <DB6PR0401MB237574F9C78A4E55A8E2B074F8ED9@DB6PR0401MB2375.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bUMCNGDHmDl97ih4Q4SbgBneWfLbNg/z1X3s2UfsWBrVcmadvXajfv/+CA75nTcGoh+qEnkaj//sJs7NOtngtQ3A3skIj28qPhDJvMe4aUoqZ0RCA7Wa84yAvizN2BiJicVlQe6xww3OWfQq2pWDEIyv1GXMzJMrs/gJdqD+hALVD8W5NW8gazwoKrjeUpX4OH1DwUdO9xgqg8wUorZAB7TB3WdpYL5Ce/UHc8NOiq8N7wzcbnetlqblNqS+2aH6EAv9nuFWwQ90bKjmQVUPiZqQHSSZnIUZOSeRaIqbnVJsDPuzXZyLAbJ2IS4ij0xGNRcre8bn+U3wmqMpzK+mdSqSgWWWN4CANHfVNsJFvnkF7L8yTI+qMNd2ZLGyyWBI+deDb7tJb4dsugE6Ancpj7rQmWrm79MAeydYwcGTfOZwA5MVZEOX7qti1fk3lyKur6GIznf/c3vdf0mqEwICObMf8B4ijdoewfQr/6gqPxs9oOkM+BSBg8T8PkK8gXTYifLyQAwHbJTiIdd60U94kQ24g4bpweQQ9xevCYNvC3bZjaRZxCm9VsoxMDsCW3P9YrX1gjP7QfUqlkzqjbfInHrLoaDlCqHjubzAqSISpr/QunVtzjjK8RVlEva5s08hFbr1g+7/CEj5lAm7T3/I3hRwnnVIikVu7K+evJxTtd16ZwHwa3mSA/b2QkKtFEpCLTmVUZNu9gmZkpBBnVeHOHIfsDi7KpDbOU96xH5Ftf0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(2906002)(26005)(186003)(6666004)(86362001)(44832011)(5660300002)(6512007)(316002)(2616005)(66476007)(66946007)(15650500001)(6506007)(8676002)(6486002)(8936002)(66556008)(33964004)(53546011)(4326008)(38100700002)(31686004)(110136005)(54906003)(36756003)(83380400001)(508600001)(31696002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDR6R3MwdWdtd1h2c3BpcHZWRUNsOUZ2bnhjNjRyT2R4OEpZemdCUktINkVG?=
 =?utf-8?B?NmlIMGpzMG1VU0RWNWx0Tk8xaDVKeXUzdTM1STl0KzFLVGtPK25Kc2EzeUQ3?=
 =?utf-8?B?MEhsL3JITnl5UXU5QWN0N1h4OWJHeFkySHIyWEh6czQ4R0poZmJhYjd0cTNL?=
 =?utf-8?B?Mmp5cGlodWdpZlF3ZEtmREFjK3JoakxMZFpQc3FCRHV5UVZQUmFJTzdTMGV1?=
 =?utf-8?B?dkdnTHAvTGxYOEJudmdVdGJmZWhDNW9QbGNnc3g2UlFRdlBLOHBYc1pHV0VV?=
 =?utf-8?B?cGt3Q1RnRWcwQTZNVjdwSmVoTmF1MG16eTBuQjFSYmdMYmlJK1dpSFR3T0do?=
 =?utf-8?B?LzFUT2FrTnF6bTVpT0NwdzlnYmNJeldTc01mK1FZNkQ5a2dGNzVYcEpLdTAw?=
 =?utf-8?B?RFVMTEt4UjVvWTN0RklqU1BSZ1F0M1EwSTJRMGxxOVZzN0lpSHpuazlLdGF6?=
 =?utf-8?B?ekJ4b0VUeE1tOEc5a1BsTlM2d0R6OGtsanA0UWV1dWx3RFBjQTB2Y2ZxNWxL?=
 =?utf-8?B?djJIUVVIY2ZOZTRyeFY0NHQwTDJ3MUpMSWlYdWhMelk2WjJ5eGxjWitJSDdS?=
 =?utf-8?B?dytwaHVMZkFmaGtSekxNdTRRcytoc3lrOWJ5cmlKb1BvcWtiQWJhdVNXanRF?=
 =?utf-8?B?dTBLTHFiQ0lRWFlvQ3ZOYUxydGVnd1gyRm5CaEpRcjlIeVEwSmtMQnJDc2lI?=
 =?utf-8?B?UnFFYmoyZW9GVE14bzNqb1ptUCs0NHQ2dVRvOHNXazBseWtVeWlneDNkYTBl?=
 =?utf-8?B?ZTJjalA3cGhUcXI4YnpTM3FDZnczWnRxSkt1b2FwbFlqT0lPNlE4UUErMzZZ?=
 =?utf-8?B?UHVCa2Rxamh6WmhGNnNpMVhnd0VMSjZ6a0k1bmdXaHdEeVVxTm5GeTdMSWx1?=
 =?utf-8?B?VjdGU1Q0S2o4cnkrdWJUcG4wcXcvSXZpbnVwRkhwSmZhekhYaGp5NHppZXRs?=
 =?utf-8?B?bUwybmNJelpvVGNDNC9yeVdhSllmYWhYUFNVR3J2alJsbENYWU5tNmlwVm9u?=
 =?utf-8?B?WU5JWlk1Z3QwMjVWR0djeDNCQmhQOCtvZzRYSjhMSVFpU1cvTWJFclJuZWh4?=
 =?utf-8?B?YmMralJyZjU3VlJ6SUhoUDVOVGNiWnJKMmlQTjc1cXhqbTN2QUpLNWIwaDJq?=
 =?utf-8?B?b0gzSnJGUUdZQXdMemZLU1hQUUg2WHZzMk5lcVp6K1NuVHF1NVFjNnFnMk56?=
 =?utf-8?B?Rm01QTBlcXlCSTVvd1VRN3BCS3gyOVZDNmtVeGRJSmZBWWYyTUlHN0QvOVht?=
 =?utf-8?B?NWNKcTV4U3pocXY2bWVNY0JLaEZsSGxCOHlmcGVZVmRZc09qeE5MWkUyWElJ?=
 =?utf-8?B?Vk9YZCtQckhmd1Q5Y295QUducDlwMnpsZHNoc3oyb1A0VE9YdEFFLy9DRy9t?=
 =?utf-8?B?MnlkRHNZd3RxNFp4c202cUxQM3Jxb2VKMThYNUNNd3VKMmMvTHdFQnQ3WGNu?=
 =?utf-8?B?VXNEM25SamVlMCt1RWExMlIvKzh3eVRGSVlqV0VJa3dHRGVJQnFJSHRyMFg0?=
 =?utf-8?B?VHFqVnVLQXpiNnVGYUxGeVBvV1pMUTU3NEEvaytUYjJOeTloNm14WEw0dkRZ?=
 =?utf-8?B?Skl0U2RZMFRpQWFBdEhqNjNmZ0szTEVIeGRoR3FJMEVRUFNUM2xiZklXSmto?=
 =?utf-8?B?MEFSQjJVODBwRUxvdnVjbXNXaHNZT0VpWEFRQ2VKZlIxTVBPamZucldqVnNC?=
 =?utf-8?B?Y0ZMRk0rWnNNV05YemhQOE9Cem5FSjFOQ0VIY2sxRjA1SFVNczVla1NRZzZm?=
 =?utf-8?B?aEZzUHROeFNEeWdwWTMrN0pTUkJFbWx4MjdUay80WjNiYTVSTERVYThxZnlY?=
 =?utf-8?B?Zzc0ZVpYYmVPMmloVjdzTDVQWmgvTVZIZnQzUTBlc1ZyazIzRTcwUjR1MUky?=
 =?utf-8?B?MmJyL0NDTXpza0ZIZ051cHUvcFJwTDBNdzA4VnkvNHRLUWxWcDBNM3JmaTVW?=
 =?utf-8?B?WlZCeHcyd1BLS1FnYW10U2M2cXd6SHd5Z0oydVhIdXNSWDl6OW9Dcmh2Q2pJ?=
 =?utf-8?B?dlFUd0pwZS9kRGt1SzNXZDZkaEY2M2tyZGtMTmFndDlodnhmTTBhS2pNK3BB?=
 =?utf-8?B?a2tOalhFTWs0cVg2MWFWS1Z0enZNWnowNjJneWFhcThZQm9JajVoOTJjWlB5?=
 =?utf-8?B?R05pd0VqYUVqV3N6MGQ2Y3podmlKYUhkSE5uTUFHRFowUFU2UWdhU3FLaXBk?=
 =?utf-8?B?ZGp1UGZUNGE5ZmxkMnJJRkVkNmozamM1WWRWN1FJaVZlclVLa2hrSHQyUW5p?=
 =?utf-8?B?UXlkS2xIZVkrRnRuR215MW01a0t1NFVwYkVCV1h2Y01URGdBdHZGMTlYTVBj?=
 =?utf-8?B?MzdDUHpUdmF2Q2ZwcEpDeCthU1hUOFJNa2t6UituOFlveUlkVHJoUTFPVzVx?=
 =?utf-8?Q?H04gy6woqiihL0Fo=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 486beace-f24a-4150-dbed-08da1c82445c
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2022 12:45:04.5858 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4hy3zNEjocM+YvefLJ8izLB5lbwm5f6rEHYT5uR70F5MMmVKIdyKsTVxLEeoy9KBOwJM/py7A+x44f2VvML2Vq2N4rSUiblbOyTQMb6o2kc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2375
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Fix wqueue09 according with 5.17 kernel updates
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
Content-Type: multipart/mixed; boundary="===============0784555304=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0784555304==
Content-Type: multipart/alternative;
 boundary="------------pm1OJxhB5RMxDUi9SFyoH6FQ"
Content-Language: en-US

--------------pm1OJxhB5RMxDUi9SFyoH6FQ
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Petr,

I guess the bug coming out from older versions of the kernel is related 
with kernel patch 3b4c0371928c17af03e8397ac842346624017ce6 and the way 
watch_queue was implemented.

Probably test was finding a kernel bug which is now solved with that 
patch and, with a proper wqueue09 implementation, this bug is not 
showing anymore with high -i values. Please check the latest version of 
the wqueue09 patch that I've sent.

Andrea

On 3/31/22 08:21, Petr Vorel wrote:
> Hi all,
>
>> Hi Andrea,
>> On 2022-03-30 11:08, Andrea Cervesato wrote:
>>> This patch fixes also the issue of loosing events on big number of
>>> iterations
>>> such as -i 1000.
>> Unfortunately when testing on machine with older kernel (older Tumbleweed
>> with
>> 5.9.1-1-default) it still blocks and then timeout:
>> wqueue09.c:52: TPASS: Meta loss notification received
>> common.h:134: TINFO: Reading watch queue events
> FYI on long enough -i (513 in my case)
> buf_len = SAFE_READ(0, fd, buffer, sizeof(buffer));
>
> This is regardless kernel version (tested on Tumbleweed 5.17.0-3.g6cba016-default
> and SLES 5.14.21) => easily reproducible.
>
> NOTE: keyctl() return value is always 0.
>
> Also not sure why we are not revoking key any more (removed in this patchset).
>
> Kind regards,
> Petr
>
>> NOTE: I haven't tested it on 5.17 yet.
>> Kind regards,
>> Petr
--------------pm1OJxhB5RMxDUi9SFyoH6FQ
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><font size="4">Hi Petr,</font></p>
    <p><font size="4">I guess the bug coming out from older versions of
        the kernel is related with kernel patch
        3b4c0371928c17af03e8397ac842346624017ce6 and the way watch_queue
        was implemented.</font></p>
    <p><font size="4">Probably test was finding a kernel bug which is
        now solved with that patch and, with a proper wqueue09
        implementation, this bug is not showing anymore with high -i
        values. Please check the latest version of the wqueue09 patch
        that I've sent.<br>
      </font></p>
    <p><font size="4">Andrea<br>
      </font></p>
    <div class="moz-cite-prefix">On 3/31/22 08:21, Petr Vorel wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:YkVIXjarbhum1eux@pevik">
      <pre class="moz-quote-pre" wrap="">Hi all,

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">Hi Andrea,
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">On 2022-03-30 11:08, Andrea Cervesato wrote:
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
</pre>
      <blockquote type="cite">
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">This patch fixes also the issue of loosing events on big number of
iterations
such as -i 1000.
</pre>
        </blockquote>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">Unfortunately when testing on machine with older kernel (older Tumbleweed
with
5.9.1-1-default) it still blocks and then timeout:
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">wqueue09.c:52: TPASS: Meta loss notification received
common.h:134: TINFO: Reading watch queue events
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
FYI on long enough -i (513 in my case)
buf_len = SAFE_READ(0, fd, buffer, sizeof(buffer));

This is regardless kernel version (tested on Tumbleweed 5.17.0-3.g6cba016-default
and SLES 5.14.21) =&gt; easily reproducible.

NOTE: keyctl() return value is always 0.

Also not sure why we are not revoking key any more (removed in this patchset).

Kind regards,
Petr

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">NOTE: I haven't tested it on 5.17 yet.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">Kind regards,
Petr
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
</pre>
    </blockquote>
  </body>
</html>

--------------pm1OJxhB5RMxDUi9SFyoH6FQ--


--===============0784555304==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0784555304==--

