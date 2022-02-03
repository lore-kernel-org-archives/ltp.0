Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F735C433EF
	for <ltp@archiver.kernel.org>; Thu,  3 Feb 2022 09:38:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 82E8E3C9A4D
	for <ltp@archiver.kernel.org>; Thu,  3 Feb 2022 10:38:03 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B2F253C95EF
 for <ltp@lists.linux.it>; Thu,  3 Feb 2022 10:37:54 +0100 (CET)
Received: from de-smtp-delivery-102.mimecast.com
 (de-smtp-delivery-102.mimecast.com [194.104.109.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 04B821A00CAE
 for <ltp@lists.linux.it>; Thu,  3 Feb 2022 10:37:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com;
 s=mimecast20200619; t=1643881073;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tGg9SSPOifqX7TfErcuJPF9f/tgWJSihEDm/WmU0lYY=;
 b=nACqY137RT6zwOrPBUBMjL88QL+oaLjPZQweaJhDi8A29+aJlaaJybPs91GVcGZq5UduGu
 favFamkHUapCaZVkCnxUytcV9SN+mhZDRcPg4O/xck9LZ9N8+ChzKzruP0o6JrqlnH00C/
 VlbrbhX33qF4QEjTLU4mPQu1b8QHEqs=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2105.outbound.protection.outlook.com [104.47.18.105]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-5-GV8rrIBfN9SGLSHHUF8wXw-1; Thu, 03 Feb 2022 10:37:52 +0100
X-MC-Unique: GV8rrIBfN9SGLSHHUF8wXw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k6AG0WqCQBaAV0ED15jFBHkiH+bFyl6s0XwZqSBC6U6Kb2wMjdVm9XHGlyXY3hOVrU3uJn17RGZ+b16NCdkPu9nL4Qt89xUfEP5h/UfBgyWAdCW8iZ0VtXslqhydOBRCH70dwuRR6zrqNuV3t3qL/9C+zwfXVCGw1EoGU9ia64NKNG+Zm6sZNvdQWe3ORrhyQasMgxvbtcOs5GRC6bayAgfAERr+S6V9wWu09KTy0duro3vtnfXwl3EVa7B22lFJ3YSmX9OYs33XfHfZoMFJDq9gX06pi2q9lza25DDlf3YsuMDnR4Z21ESJxbAPqlQuQQWmplsWDGA667WydZO8ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tGg9SSPOifqX7TfErcuJPF9f/tgWJSihEDm/WmU0lYY=;
 b=ny0elEKiYQmHMQbVOoEasiutDWYu5iYT3agNnAbgzc9AEmmXUX/bFu6RmtBICjxc6ZRgxWLPbhFkpg3fJsT+DaVmiVjeJVouVvT4Uf3MuTaVWfmzfSlAHJvi/H4iCH4vdtp0Yxof5I80RLMNnbSvV+S0glsrQ1xKoleJgU+i7PiXXFYYfp4lMMFCHcIyJd53d4nYtwU06qbD/QUtZum2ILKBQc5+xwzquuHCIy4srwAYQB423uZEy+q/bQvW8zZrvBsC1RN0wjWwUtVYHDDY2SADFEg+/VdaCXObTGDm2pXXcKmsZlwE1DPBTlnrE1Cm0ga2+WVvlfVObSE/7OVlHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by VI1PR04MB5838.eurprd04.prod.outlook.com (2603:10a6:803:ea::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Thu, 3 Feb
 2022 09:37:50 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::69ee:ea32:8cf8:2e02]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::69ee:ea32:8cf8:2e02%4]) with mapi id 15.20.4951.012; Thu, 3 Feb 2022
 09:37:50 +0000
Message-ID: <692e3994-ef2b-3a9a-c4e2-118304cad3a0@suse.com>
Date: Thu, 3 Feb 2022 10:37:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Content-Language: en-US
To: rpalethorpe@suse.de, Petr Vorel <pvorel@suse.cz>
References: <20220201142230.20243-1-andrea.cervesato@suse.de>
 <Yfo5P7ZZI33xz+6K@pevik> <8735l0y07y.fsf@suse.de>
 <1fbbeba9-aa4e-81b3-0b56-c92b9b7d8356@suse.com>
In-Reply-To: <1fbbeba9-aa4e-81b3-0b56-c92b9b7d8356@suse.com>
X-ClientProxiedBy: AS8PR05CA0029.eurprd05.prod.outlook.com
 (2603:10a6:20b:311::34) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f8ecfb5d-6f96-416a-844f-08d9e6f8d7fb
X-MS-TrafficTypeDiagnostic: VI1PR04MB5838:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB5838397417E507F1ADE30F4EF8289@VI1PR04MB5838.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: noMaTiUufOUyZ5hmqvnoaiUlg9cKvXUM/6owx4df15euhfuTvL6QOk+ViDGUE5zCmB2LLrKsaTO8O1NtXwYzS1bf8dc2eEfXPMZESN/4b66y5PdltY6OGqa7D80tCZ4vboofmxBI1CDuFrI9FQzFEiuP7RNyFPtoOZWBg4PaxmmDeIM8yPfNytBTepiDO8QNqHzZzofOJ+ufjS2daLCI/z46hJR/3hqiQ2sh1l8eMLHAh724DLPV189f0BkBILqjra7ELY/U8NFDlCuwlu4T0p8f+TjM/9udUEMUewNf91Y9Srlm6f1ci2jIc+4ss6ejx4yT2qs8LZBGmOgh2wS83K883tQFF3WIgmgOs1F7oVcz+4IY2yM3SaxaY6gp5fQcKC9mwNhRqEyi8aSx+BnIXUGcZUFs4Bhtx0YifNtgUU3sebnriN7AF+K0oPzn5XPYRidGHYZmX8fToDhjsS+whzJnNve98DywXKiLVggqcgFqAL3XDlDc8Y9Hdw2EWhsf8c1hud9IZn/V2jKYQAQRwXfzjagEqq5Qv3ybVGSXLRaV6rp3ZvwLceLXkUu6OiaV8K7ZxRihU97sdQmJnD3Sfq6bJLIiv/JedXg3Fh+fNA28C0IyEYMSNFk/Ao2kMq3kEh/fzH3QOy5FBVK6Lc7Ozbqy6KiiCcC8FwUe5hDuYDEibRPhibAzrJEFsQwczdNeMzoGKHk+wimqnbyAwaF+5F7go5atisi/+PzD40sxqKKUzJtRXrwsrkZJjElD/JTUeVu/8pSTL3XfddyavH1MRAsPJKRSRjE9wbMrKd5OnQ7ySyzisrC683dY8axBamn6oynmyDW6EiSQs7d6SKekwrAtGrkyfAxSTfx67AR2Eow=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(83380400001)(5660300002)(2906002)(26005)(186003)(44832011)(31686004)(36756003)(4326008)(508600001)(166002)(966005)(6486002)(6512007)(8936002)(8676002)(6916009)(66556008)(66476007)(66946007)(2616005)(316002)(53546011)(54906003)(31696002)(6506007)(38100700002)(86362001)(33964004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUJXTWtvSDhYeVdvdDFRNkJhNThnSUpwd0lzVW5YVDM3ZlVpZ1JTTjB5Y3hL?=
 =?utf-8?B?UkZWYVFsY1hSb29qNWZwOHpQOUQwZDJPVCt3bmlJSStSdktUNU9WcXVPU056?=
 =?utf-8?B?RWRJUTdTamJxMHZFdGdYQXR6S203MVRzVkFrNS9xMVRBR2FuRE1OU2lPT1VH?=
 =?utf-8?B?RHZrdHVOcVNJY3RBZkpZVzZxK0twaGJva3BML3h5NDVZMXQ0cEU0ZjR3L1Zz?=
 =?utf-8?B?Z1MyZ01td2lyZ2h5eXRTaW9zRkUzTFl2bUVtWjg4SnlHT0dmOG9YMWtXUnAz?=
 =?utf-8?B?N3ZQNXRWd2djZFQrYUN5VW1BVlljeVZaUUxBMjJBdC8wUXVCL1NQZUFJODFj?=
 =?utf-8?B?SFJ5ZUJhRkk5YkV2QVFBZGFiTWxQenQrWGJpOW9pMEk3YU1saVM2Y3Y0aW1X?=
 =?utf-8?B?YWdqNXBYVThZTFhUWjdJeHVUcXZvYkNWVTJsWUhOZy9ReW5wN3ZLYW95ZWM3?=
 =?utf-8?B?WlF2ZVVMelpsU25yVEpNNGg3NnE1SGovcXQrR3dOMEpScWZyRHpqdjVyOE5p?=
 =?utf-8?B?bGNlcVFDbnpBRzVyUVlDUDYvT3Q0dkY4SWxUc1czYkdqVjY1ajRTcFZONVAz?=
 =?utf-8?B?TzExWXMvbUJVaGJpZmhxVTJrR00vK3UxUEhpdWZPbmR5QXlHaUVJVCsyazQ0?=
 =?utf-8?B?cnJFazdxU3lkS1ZnMTdKWlJHWWx4SlVWUUZpdExxeGZPVkFGZkNFOGJNazEz?=
 =?utf-8?B?YVJPVUhjMHdSMUx1NnlHUzRnTDBnQ2k1WnpFSmZRS2FMN2czV01JL3R1dGVp?=
 =?utf-8?B?YXpod21BdzFvanVMQWhHeEptVXR5ekVUaVZaUzlWL2JvMGV2c3FkcXlyaXlo?=
 =?utf-8?B?VjB6Z282b1hDdWxicFV2ejZLTVUvZlIwUWpnLzk4aFlDbFVhQ1JnYUVqYXdy?=
 =?utf-8?B?UlU1MVhNenZkM1lLdVhvQW4xZDl6OWFtVmZPVG9pd0FRTTVNV1F2TlRtcEk2?=
 =?utf-8?B?R1J3WXVDZFdMVGl1NVQ0bENnVFdTUzVoMjdybXFKQmE3TmJicjVpVWExVlBN?=
 =?utf-8?B?eEJHWXA2QU50NVNKS3pXbm1Cb01DTG1mczlUNlZqbVA3VmViSGI5WmcxTnVy?=
 =?utf-8?B?MW9ONFFvK09tNjRoRDRtZXpscEs3TUNIRTMwUlZ6dXNMRk1uUFV4WFNSNWpJ?=
 =?utf-8?B?NmJ5dFBDQzhINjR4Rmw4WjVBRFJ2Q1hjOWZmbWk3ellLZHpHQ29jQ1FUbnU5?=
 =?utf-8?B?QnRTdGw2RkxNNUV3cW9HR21jUXpjVzlhbzVydnprYytScFpRY3M4UU1lNWxN?=
 =?utf-8?B?UmlEK1V0V0swVUVoakJTTm1nSmM5R08xY1M5YVN6M2NKS2RISUtaMFdHeDZM?=
 =?utf-8?B?c0ZKcE44SytLNTVlWFF1Qjd0UDNlYmxmaVJTalNwRzlOTDhHV2tDZDZHN1hP?=
 =?utf-8?B?QndxOUtGTHBjTEtOZlpTcW1XdERWMHYvSGs3U2hsVUdTOUZmN2JwMXdmWDJK?=
 =?utf-8?B?OGJaSXBsbEZGVDVwUkxiYVhKR1hPMW5yajF3c3JVSXNJQnR5ZVE3cE1OTXRP?=
 =?utf-8?B?MVlPZkJONG9YcEJNN2FBUlhEc1ZhOXBIM3JlWU9zUnFPL0tPUmJseWhEZzBS?=
 =?utf-8?B?OXFkK2RMTkxIT2d2L0tkOFYzYnJCS25qelFmSXlCb25PMDJBK1o4WkpveHNr?=
 =?utf-8?B?cll3UFhCZUxZak8xbXo4OVJkY3hDbjZkL0FENURCMDJZcTU4NllGZ3libTZ1?=
 =?utf-8?B?c3hQbFhNQXlMMG5qVzZ1dVRqRmpzNG5kSFlsVmdpaG1iK2wwdmxkVG5laC9M?=
 =?utf-8?B?aWJ5aWZyWmc2WXhsc1dlQ3pxSTlJNUpHdTdnbGdIN3lQQlU3bnVZckZjbmtx?=
 =?utf-8?B?elpDQkIxcFlXcUxoSGJWVlN5TDE3cjdxMGhSaDJhWDRSVWtHQ1JHMVhhL29l?=
 =?utf-8?B?WC9WZ2FZUmp6RzQ1YXhKcC9QdlpOeVc1ZHE5eU81MmVFVW9sNWdNdHVyUGs3?=
 =?utf-8?B?cWRBM2QrTHJQYkJXRmx0MnhuTDZVSkxJRmE4V0JJcHY4MEpvbEd6TnpoeVlG?=
 =?utf-8?B?MWt2eXNPTXI1UUMrc2JQaTI1dEN4R1dXSkcyMjQ4Qmc2c0k5OFkrRWw0ZUg0?=
 =?utf-8?B?aGFWaGh1b041ZHEycGU5dTdtSUV5dXpmWXNUcjZ1NHNWV1RFUDkwbEZndGFy?=
 =?utf-8?B?ajFhaEV3MUtqQ283aDlBYzd4bFJhU29EYldTM2wyOXJ2Q1BzQk44cWl6UFFl?=
 =?utf-8?B?OHpodXFFNk9DNmNWdU11bkZwZkQ5RW0yTTdOZGtJc0lwMFV4UjkzcnI4YWhi?=
 =?utf-8?B?STdHOXFBTTFtUW9IY1h6bW9uOFRBPT0=?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8ecfb5d-6f96-416a-844f-08d9e6f8d7fb
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2022 09:37:50.0592 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pzn3knLMFUdsWqERZP/UpnX4dq9PlmKDVJ/wO8tANjQJCHv3e6s/cNucUuu7UvguLB2pSTv4zzkI7nyuEAPr1XsmVigHi2HcI8ccDw02mME=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5838
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Extract libclone from
 testcases/kernel/containers
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
Content-Type: multipart/mixed; boundary="===============0076477192=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0076477192==
Content-Type: multipart/alternative;
 boundary="------------azFPqnbZte1cfx0LKwLZcVhF"
Content-Language: en-US

--------------azFPqnbZte1cfx0LKwLZcVhF
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

an update about the last comments: the unshared clone is only used by 
mountns tests suite, so we can add that to the common utilities and get 
back to tst_clone for the other testing suites. I'm going to do that.

Andrea

On 2/3/22 10:22, Andrea Cervesato wrote:
>
> Hi!
>
> On 2/3/22 06:31, Richard Palethorpe wrote:
>> Hello,
>>
>> Petr Vorel<pvorel@suse.cz>  writes:
>>
>>> Hi Andrea,
>>>
>>> [ Cc Richie, Li ]
>>> https://lore.kernel.org/ltp/20220201142230.20243-1-andrea.cervesato@suse.de/
>>>
>>>> libclone has been added to the libs folder and updated with the new
>>>> LTP API. This library will be used by containers tests, which will be
>>>> updated to the new LTP API as well.
>>> I suppose you want to use it for containers (still use legacy API), which
>>> already use it. I remember Richie not considering libclone.h as a good source
>>> and suggesting to use SAFE_CLONE() for simple cases.
>>>
>>> https://lore.kernel.org/ltp/878s7k59tk.fsf@suse.de/
>>>
>>> We probably need some wrapper for containers, but we should recheck, whether
>>> we want to take a different approach. Code in the functions is really a bit weird.
>>>
>> Yeah tst_clone.{c,h} is the new library which uses clone3 + a
>> compatability layer if clone3 is not available. This avoids reinventing
>> a cloning API to some extent because the clone3 interface is nice IMO.
>>
>> Also IMO tests should be rewritten to use tst_clone, I just haven't had
>> chance to do that.
> libclone does also a several other things, such as executing a process 
> under unshared namespace and that is used by mountns testcases. So 
> maybe we can just call it in an another way or find a way to recycle 
> the libclone code.
>> BTW we need to test cloning into a CGroup, so I'll probably add that
>> soon.
>>
--------------azFPqnbZte1cfx0LKwLZcVhF
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><font size="4">Hi,</font></p>
    <p><font size="4">an update about the last comments: the unshared
        clone is only used by mountns tests suite, so we can add that to
        the common utilities and get back to tst_clone for the other
        testing suites. I'm going to do that.</font></p>
    <p><font size="4">Andrea<br>
      </font></p>
    <div class="moz-cite-prefix">On 2/3/22 10:22, Andrea Cervesato
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:1fbbeba9-aa4e-81b3-0b56-c92b9b7d8356@suse.com">
      
      <p><font size="4">Hi!</font><br>
      </p>
      <div class="moz-cite-prefix">On 2/3/22 06:31, Richard Palethorpe
        wrote:<br>
      </div>
      <blockquote type="cite" cite="mid:8735l0y07y.fsf@suse.de">
        <pre class="moz-quote-pre" wrap="">Hello,

Petr Vorel <a class="moz-txt-link-rfc2396E" href="mailto:pvorel@suse.cz" moz-do-not-send="true">&lt;pvorel@suse.cz&gt;</a> writes:

</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">Hi Andrea,

[ Cc Richie, Li ]
<a class="moz-txt-link-freetext" href="https://lore.kernel.org/ltp/20220201142230.20243-1-andrea.cervesato@suse.de/" moz-do-not-send="true">https://lore.kernel.org/ltp/20220201142230.20243-1-andrea.cervesato@suse.de/</a>

</pre>
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">libclone has been added to the libs folder and updated with the new
LTP API. This library will be used by containers tests, which will be
updated to the new LTP API as well.
</pre>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">I suppose you want to use it for containers (still use legacy API), which
already use it. I remember Richie not considering libclone.h as a good source
and suggesting to use SAFE_CLONE() for simple cases.

<a class="moz-txt-link-freetext" href="https://lore.kernel.org/ltp/878s7k59tk.fsf@suse.de/" moz-do-not-send="true">https://lore.kernel.org/ltp/878s7k59tk.fsf@suse.de/</a>

We probably need some wrapper for containers, but we should recheck, whether
we want to take a different approach. Code in the functions is really a bit weird.

</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">Yeah tst_clone.{c,h} is the new library which uses clone3 + a
compatability layer if clone3 is not available. This avoids reinventing
a cloning API to some extent because the clone3 interface is nice IMO.

Also IMO tests should be rewritten to use tst_clone, I just haven't had
chance to do that.
</pre>
      </blockquote>
      libclone does also a several other things, such as executing a
      process under unshared namespace and that is used by mountns
      testcases. So maybe we can just call it in an another way or find
      a way to recycle the libclone code.<br>
      <blockquote type="cite" cite="mid:8735l0y07y.fsf@suse.de">
        <pre class="moz-quote-pre" wrap="">BTW we need to test cloning into a CGroup, so I'll probably add that
soon.

</pre>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------azFPqnbZte1cfx0LKwLZcVhF--


--===============0076477192==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0076477192==--

