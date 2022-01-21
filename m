Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9CEEC433F5
	for <ltp@archiver.kernel.org>; Fri, 21 Jan 2022 11:12:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ED2A23C9715
	for <ltp@archiver.kernel.org>; Fri, 21 Jan 2022 12:12:39 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 93C8C3C0C9F
 for <ltp@lists.linux.it>; Fri, 21 Jan 2022 12:12:29 +0100 (CET)
Received: from de-smtp-delivery-102.mimecast.com
 (de-smtp-delivery-102.mimecast.com [194.104.109.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 4928A1400551
 for <ltp@lists.linux.it>; Fri, 21 Jan 2022 12:12:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com;
 s=mimecast20200619; t=1642763547;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SBS9tnlHsPUArghgiV/ZzaiZ2gMq6cT+yf6LvKpuFh0=;
 b=l9GcKs3+vW49fNkZzPZIDZsFlaAoa7n+d9Vt/JrcwufNqMp1IBJpkuxnVs0Avbz1vSmaLm
 brcGxJXdyBim6IdM31dfdM1RuV1UD4QpvBzEheYLEZ+fc48MPy8hE3q3DnUIF89sUjOcf5
 Ooyjt8dVKQmFZuZAEuW9BTRygBbIYxc=
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur02lp2053.outbound.protection.outlook.com [104.47.6.53]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-15--rfuuB8XMwiKXKC0Q31GiA-1; Fri, 21 Jan 2022 12:12:26 +0100
X-MC-Unique: -rfuuB8XMwiKXKC0Q31GiA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PqTcAH95A9qizguIm9U5Nspepn4MkIQG4BX4Hl2rahzp7jYtzr/JC/qG8uRJKqTMZ4JotzIy8qgI5ipeaV4OFSdLxLnIRsvOthdel1ih5udw9gyEiKvnyW8So/7xrztvZMPoYyQuGKrm9fgIV1C3vlKJnBL61HApmFohB/IwPDCfkJBDfuZ2ShyD0svw/9yfjdT13z4ZpVvrQJngDj3fTDSeh+r3v5HeNBKHvrZQ63sISW2ZQRkwLF4hqFdAq4sq9FocjIPrVLoOlMeS/lL1qKH/sLJY80p7QrzsnvqrUsESF+piQcscPTaAqyF1oVc6pCcuoNCX9t6OKK7AQ3Hb5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SBS9tnlHsPUArghgiV/ZzaiZ2gMq6cT+yf6LvKpuFh0=;
 b=e7fuv8ueKi0WVfdtqBRpRv9x8SR07QOsxFzeRN2FyPIGuMbSHBxOUa+QjnSyhrP8+UyYvMcO298SiiNCNgjJv2fcJuM+15QobfdJawfHwGvbzVN+VwrZFyoAfoDs9xm/DYjIRI9mdsRpbTSjRqEvvPkqS1lb7nDcYwiAusxEzHXcx9CXQp2//v69i5ByTjbPoFJevXq83NlCNAF3okg9JO5ropfVQ7gElyygUjjD2GzB0PWCmK4rMMu+8D+5JhMewF2LFS1Y5WuoelN6lfcKvNelj4VE25xx3KoNcLwr3MMqYuWipVr8GOL09OvBlDjS7ol3GTxWiF+vCfmGMk38Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM0PR04MB6788.eurprd04.prod.outlook.com (2603:10a6:208:18e::20)
 by VI1PR04MB5454.eurprd04.prod.outlook.com (2603:10a6:803:d1::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.12; Fri, 21 Jan
 2022 11:12:25 +0000
Received: from AM0PR04MB6788.eurprd04.prod.outlook.com
 ([fe80::1c48:b656:15bb:a794]) by AM0PR04MB6788.eurprd04.prod.outlook.com
 ([fe80::1c48:b656:15bb:a794%7]) with mapi id 15.20.4909.012; Fri, 21 Jan 2022
 11:12:25 +0000
Message-ID: <dc5905ef-feb8-b1e5-df7e-bc34b804629d@suse.com>
Date: Fri, 21 Jan 2022 12:12:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
References: <20220121100604.1072-1-pvorel@suse.cz> <YeqIB+Y4rO2XK57i@pevik>
In-Reply-To: <YeqIB+Y4rO2XK57i@pevik>
X-ClientProxiedBy: AS8PR04CA0191.eurprd04.prod.outlook.com
 (2603:10a6:20b:2f3::16) To AM0PR04MB6788.eurprd04.prod.outlook.com
 (2603:10a6:208:18e::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 00177fb8-c40f-4aa2-c6aa-08d9dccee721
X-MS-TrafficTypeDiagnostic: VI1PR04MB5454:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB5454E4CBC0A40A296C800591F85B9@VI1PR04MB5454.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I4sFp7UMr3Lj602pOTNBhVUeDOV4czr3XfFiqcsvWVw5PI8pQdnUI9VwKV55RVpLdS6pGuQtCjcFNKZ2LWdhL9rRhh2dsERS/W/U6pkysQoVjApGpLRhzAue1SaVtG36uHECYe4FistgE2Y6J9KfagY7wHpyK1xfRrRV8OW7xid9JfG0cDCqQD3HIz2phyWdg3ICYMzWoNtbBHLZQrTJKOjih8QfO4dw/fY7playrVd73y9gQb50bhGpgDYkEbhS0ZquAu45bRboAOjXtWwsUmpoBNc2CK/PA0TkvnQPI331XRYPlRd3o28/nNuqVMYnYLD+fbv7UPc6LHrVf3fZljrKda1JwdLWbIgJYJVD3b4+a4ZUVIN2YykaWWKtr/SkIVOe7Fx1TPj8kqPjeY8a8qQpB/c8m2TcmM4eX418nh+iMuHZsU3qa/WOl6z2LF0ddU+d3kHF21R4vhLcLU+nec92o4vmZAo5jwUuCsIDrPiyYlGUBz8spYY7LDx1sH8NNDrKLRgQcW1BID+BpEJP4bFdV2g2oOKdEjTvJyxsaz1K+AYti2UC5bClc26vg7YjHGM4fZhxZjvcxnm0JBH92RMqFIOE90+hQYrho5ejTM5IeaCaESd750a2OAYBg+Iz1eAmu5pkyQ9lufOqBiGAt7q/YmxDwdPaL/4rupn6iRp8l5tOgfKyG9WGyEY+nBsCrzJg9CdEUviCRPPy4KlorUBXoUEOwP9sBGIokFSDo97BtkPYAbVs8w0gbcm23Yun
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB6788.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(186003)(508600001)(8676002)(4326008)(6506007)(31696002)(86362001)(54906003)(6512007)(8936002)(53546011)(6486002)(316002)(5660300002)(44832011)(66556008)(38100700002)(31686004)(26005)(36756003)(2616005)(83380400001)(33964004)(66946007)(66476007)(2906002)(17423001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TitVRkp4WWdXVWpOdjJncGdTU0ZNNkhHemFrSHJidHdMRVM5K2pjeXcrYXFi?=
 =?utf-8?B?RHBBNnBFRFFDSDVrc05pUVM5ZWs0LytmQmxmRUFFcWtqMGJQSmRadVFtNTJa?=
 =?utf-8?B?ZlBUVmtDOHlwQkRTUm5kODZTRUxMQUE3cjZzSG45OTM0bndaTmFGcWxkNm1w?=
 =?utf-8?B?Ym4xSHRHTExJZVlDaElEYmZCc25xNXdFTWxJYWtGdjlaVlBGR29uRjM3VGJN?=
 =?utf-8?B?Mk8zRE95WXkvVm42Y1NPNU5icFZOaFEzOUdhbWpkdHoxcXBudXFGc2k1cHo1?=
 =?utf-8?B?ZVZsUDV0NUNUVkJycGMzUm9mZFduR01UZFNhK0Nha1FQeS95OVFCTTNUazBl?=
 =?utf-8?B?eVFSQ2c1TmQ2Vlh4OW5LaFFOanVYa0MrTTB1WWw2WVYxRkFIOXBLY2t4SFYx?=
 =?utf-8?B?emtBTW5qWG1FQmIrd1hzSEpFK0FoK3dST2FRcjcySUF2aEZyT09yTzRsb1p6?=
 =?utf-8?B?cjZybEw5QXJ5L09wcVpKL1l6M3B4SWNaMzBZTlo4Q3NKcGdGbnpUTkpCM2Ju?=
 =?utf-8?B?Z3dlSXRwQXZtOGQ3N2tlWXNTTmxtZXNOR0xxcUplQUtUclI4K0J3LzNJZlR3?=
 =?utf-8?B?WG55L3hwMUsxeHM5QVlrVGxaTFdrRGRNQ2x3REZ4VmlCVTBORGc2b1ZFcGpj?=
 =?utf-8?B?bU1ONHNNVk5SdmdsVUhRak5KZUdBOHlYSEE5eXllVVF3TlB1MlAxMmxpMWhQ?=
 =?utf-8?B?VUNmMXFYcmZRTm1DUDBIUko1YXQ5b3QwbHhoSDVHT01JdytZK1ozVnpRak1R?=
 =?utf-8?B?Yjd6Vmc3eWY0VEVza0RyRWxjbmVsMDlQeG5neU9JQ09YZmEwZUhRWEs3V1Rt?=
 =?utf-8?B?YWE2d2E5UkJRM1hETm9CL3RCS1E2S2h3bVhLeHZNY2JuTjRXQ2pHVUZMQVZW?=
 =?utf-8?B?bkNHaC9JUjBpc3pJbmVDT1k2QW5EdmFxZ1JhWE1yZU5jOUZ0citueXJNY0ly?=
 =?utf-8?B?SkdxcTQwOXFQNS8wbUFrZy95RTI3K2hHYnZqbmJrd0tZZ2Y1MnFwUUthajVn?=
 =?utf-8?B?Y2JId0Q4MTV0anFIN3RjRDdyNk9LeHNlY2VDcGZXazhYSis5ait1aDZ5QzNt?=
 =?utf-8?B?Sm9FSUx3SldZNWR6Z28yZXRQNHFuVHBFWFRpVEd3S1pWUzJ5T3hCNGs1MFJQ?=
 =?utf-8?B?bmNZOFh4V1UxMmQ5aTNYKzVrK25ucmhIKy9Iem84aHRjeUlzRjhQN3RDT0Vx?=
 =?utf-8?B?c3Y0TnQzTHFMdFY3Wm0zN0lYRXpsb0hxMTZFTkhZMWFQQTkvOTcxRWE0eEY2?=
 =?utf-8?B?YkNEMlZreFRkUEJqYUJVQnhmRXNCdWFGRUM1anhpK2JDOXJROVlVOWZsLzlu?=
 =?utf-8?B?QWZ5UWVlNmtBUTB4SElkOEpOSmZqb0xmY08yOWlSY280WkhHNGxFUVlQOHlZ?=
 =?utf-8?B?WnBKL3N1NzhJQXhkMTVRQmhoYy9JNnNtTVl2ejFkaTZKUUFKTDhuaEZkT0NS?=
 =?utf-8?B?TnRYL2tZM0JQbUp5UnVXVkhIUTJUSy9yOEpmWW0rTU9HRzRxbEJLOG90b25t?=
 =?utf-8?B?R1R0QktXTlh1S2RTYXcwS1hGT2NibDJjczFGUE1ITmk3TGk1am9kYXNqd3Jv?=
 =?utf-8?B?MXJ4WGFHUUxzdDR6QWJUUzlucHVEcXlpU3RDQkp3MTc2ZlZuWndSZVVDNHJV?=
 =?utf-8?B?VDRGUldzSDhzSVc2b2dtTVR4L0VGakRZczBURlJhR1RqQ2c0bW11cm9ocVdh?=
 =?utf-8?B?ZXE1SjNoM1JrUjhUemhXSHJMeEVCclJENE9QK1FRQjFIWFNvRGl3VEtNaUxt?=
 =?utf-8?B?RUJQTkVvczdhZUE1S1pQQTRyNkkvdGRZdURpOW1leFNRMit0RHZEWFlmK1dB?=
 =?utf-8?B?RFJscU5QeWJEUWlCZ2Y2OUVOeUkzeHU5RStEblk4WU81YnpZQkhXMmpPUkEv?=
 =?utf-8?B?MXBveHhOQ293YUpmWnR1bDYvNEovQ3BxazdGNm9hMEN3Tm5CeTRBQlR1cmV0?=
 =?utf-8?B?YVllRkluNU5NR1RsVDRhNkVmSVpUNWNHUFJlWERvVS9ETzJIUzl4eWFUK00r?=
 =?utf-8?B?UGxqNWFnSDF1Wm8wcFFQSHZPU2V1NWRlZEQ2OVV5Mzhrb3NOQUdSTzVoalZr?=
 =?utf-8?B?MTRuOVJRRTBmQjZZZm5MZktwTjNRMWdOMjduVVNlOHZ2cy9LZC90VFhBNHk5?=
 =?utf-8?B?Q096dWRPbmZzWjFKUXE0cThLSFgxRThjcGlVVG1MSlJZcW1zYlFxRG16NXR2?=
 =?utf-8?B?NjFBblFZMndnbEdiM2VYa25DcjBqZ1dtYzZCNEphN1BXQzM0YkZNYW9EbWZG?=
 =?utf-8?B?dGIyMG5taE5rcWV1UTJWSTJtN3pRPT0=?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00177fb8-c40f-4aa2-c6aa-08d9dccee721
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6788.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2022 11:12:24.9697 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n4E5pYWvncBtVlQdfVf/8VFb2aJZjVC5FciyT/+amijtbs9R+eDKgPYmizjOQtORpTGgJp+wyl/b+cZaImId0SZ+Au0H/NHu06gMqwszgYs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5454
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] aiodio: Skip tests on tmpfs
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
Content-Type: multipart/mixed; boundary="===============0315926512=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0315926512==
Content-Type: multipart/alternative;
 boundary="------------JbeI4FY4maUjhuuSD1kJxyJo"
Content-Language: en-US

--------------JbeI4FY4maUjhuuSD1kJxyJo
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi!

On 1/21/22 11:16, Petr Vorel wrote:
> Hi all,
>
> [Cc Li ]
>
>> tmpfs does not support it.
> Verifying with .all_filesystems, that only tmpfs is problematic
> - tested on exfat, ntfs over FUSE, vfat (common linux filesystems obviously work)
>
> That's why I avoided opening file with O_DIRECT in setup().
>
> BTW I wonder what is the reason of duplicate entries in ltp-aiodio.part4?
> i.e. dio_sparse, aiodio_append, dio_append, dio_truncate...
> To create bigger load?

To duplicate entries in ltp-aiodio.part4 doesn't make much sense and I 
perfectly agree with you. Once the aiodio testing suite is finished, we 
do need to change runtest file in order to have multiple scenarios with 
different files/buffers size with a different number of sub-processes.

>
> IMHO it'd make sense to run at least one test on .all_filesystems to check more
> filesystems (dio_append seems to be quick), but I wouldn't done it when there
> are duplicate entries.
>
> Kind regards,
> Petr
>
--------------JbeI4FY4maUjhuuSD1kJxyJo
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><font size="4">Hi!</font><br>
    </p>
    <div class="moz-cite-prefix">On 1/21/22 11:16, Petr Vorel wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:YeqIB+Y4rO2XK57i@pevik">
      <pre class="moz-quote-pre" wrap="">Hi all,

[Cc Li ]

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">tmpfs does not support it.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">Verifying with .all_filesystems, that only tmpfs is problematic
- tested on exfat, ntfs over FUSE, vfat (common linux filesystems obviously work)

That's why I avoided opening file with O_DIRECT in setup().

BTW I wonder what is the reason of duplicate entries in ltp-aiodio.part4?
i.e. dio_sparse, aiodio_append, dio_append, dio_truncate...
To create bigger load?</pre>
    </blockquote>
    <p>To duplicate entries in ltp-aiodio.part4 doesn't make much sense
      and I perfectly agree with you. Once the aiodio testing suite is
      finished, we do need to change runtest file in order to have
      multiple scenarios with different files/buffers size with a
      different number of sub-processes.<br>
    </p>
    <blockquote type="cite" cite="mid:YeqIB+Y4rO2XK57i@pevik">
      <pre class="moz-quote-pre" wrap="">

IMHO it'd make sense to run at least one test on .all_filesystems to check more
filesystems (dio_append seems to be quick), but I wouldn't done it when there
are duplicate entries.

Kind regards,
Petr

</pre>
    </blockquote>
  </body>
</html>

--------------JbeI4FY4maUjhuuSD1kJxyJo--


--===============0315926512==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0315926512==--

