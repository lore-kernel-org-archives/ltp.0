Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6089AC25B0C
	for <ltp@archiver.kernel.org>; Mon,  8 Aug 2022 09:03:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B6BCD3C94EA
	for <ltp@archiver.kernel.org>; Mon,  8 Aug 2022 11:03:02 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 43A333C06EC
 for <ltp@lists.linux.it>; Mon,  8 Aug 2022 11:02:50 +0200 (CEST)
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr30042.outbound.protection.outlook.com [40.107.3.42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 58F0E1A00664
 for <ltp@lists.linux.it>; Mon,  8 Aug 2022 11:02:49 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UkKcC0hAub11Lq4wKK+nqbjZz8XtZ7g0McsMSvs8jnJ/tVRpxkZ2RcshAdV9CrKeojUpKY7fehJYroTynTuFZAf5shCUNT/jaXqXNWhWEe2cVzBEQk2jleODJHVgeCZKhww3HXlShecVvhyenMMQb+rm+GNj5CtETNqWgaSbo6Mq8oEeX7COse/IxQHXW9tQXilDtEad34VaEfQaFXXFg3MLYb8Yz5e3F5DRXfOzmGHReo6nUnIagGcI/nwf6w2QeYjNhUnaGRKRs+GzER2X62Zu+uli7tgR8xLKLdepL+UAWE/SXx5NJljsIk+AulXzDfeG4zwQLNunFOqosZHwSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=erjf3KCbWdvkMGIgOKqwbzeiytfnzDZH7Mf+VMYTQWw=;
 b=g2qWCZ8gpFl6+4FEhnINCH/NqXvkkMexvWaWJjASVKW17eDCCuq9jnplrBfCKUZxMWtVkZzTcBjln8ft5eGAYSrbYYlxJDUzwzFcL+3Au96QnC2o4euPUNR6g4xSu4VdLfHdkd2g2uFQf1tRe/1zeaVEd+5fVc01R9E6HcqzK2SmycP6wRbGAcyKzudIbYIUKnQh7XztSf5otmGHULRm88tuzhAiYVnnI2AmHmPlx7BrpiX9BP3/L4/n7dYWEWj7P+isTKdyzYfkeJY3avaABzJsytspBxWhJuWxYc+nJNnxtIdbKJ49TN/FBL8j7BDYuNjEPt6z8Eb5bJ/tt2WE2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=erjf3KCbWdvkMGIgOKqwbzeiytfnzDZH7Mf+VMYTQWw=;
 b=B9SUqb/xIQ5as28BE7w5KdFFnANWIWQFiK0VsoaC/hicIGc3hHR1onJ4GXbEY0SYY2H9IHpbvwOdOIxAEykOHz6MJv5SowjCQTUpX8L3OVrf7CW5PCUlKaPOSAbeLMUH9bMfPOcvVdlOCSvx4h+1XQx6TZmXgk0hLgGrBYdBviXVYUZYGFf79lNEeTquGRZx4FLtW6p+FYitbxwyLxMIMITeOPAz1nTMzOEVgMLjrAEeoHQmUHGAL1q/0ntEE3BN8t/Eqdgh+ulGQm5oLMswa7qI9qdp7KuK+GVf+xt2KKTlI/BGORihVNgxFFTg3mB+9eDtnuzhrirMe5VVXHQapg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by AM9PR04MB8842.eurprd04.prod.outlook.com (2603:10a6:20b:409::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.20; Mon, 8 Aug
 2022 09:02:48 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::c3:d917:fe7a:451b]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::c3:d917:fe7a:451b%6]) with mapi id 15.20.5504.020; Mon, 8 Aug 2022
 09:02:47 +0000
Message-ID: <8c2298c3-0838-de6a-e76a-927e554d6035@suse.com>
Date: Mon, 8 Aug 2022 11:02:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To: "Chen, Zion" <zion.chen01@sap.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
References: <VI1PR02MB61896EFAC4D92D36C0723295EA639@VI1PR02MB6189.eurprd02.prod.outlook.com>
In-Reply-To: <VI1PR02MB61896EFAC4D92D36C0723295EA639@VI1PR02MB6189.eurprd02.prod.outlook.com>
X-ClientProxiedBy: FR3P281CA0068.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::15) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f968735e-e4a4-4ad9-7a05-08da791cc3c1
X-MS-TrafficTypeDiagnostic: AM9PR04MB8842:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jHXH8vRFQSveh5zjzHXNTrVA+tBJ/XAlateNGrTC9Ua0r4HMGvTCjwCUTCVLm8YeP4fy2jUbHMPBfpRe7gIEhbZtMhYMsLhUL94NxWeKOpAMHLq5Nxoh8Yn6PMDCD0Ss1rmWznKAvi+1CpBt2I6S8CIO6EGmTkgCX9uuQn6E/JxktA1heA+uBwaHPAsKNKb06PWhaEHEv3IB3sQz6iWLbaoPmMB9C1PHiHbKmp/22A+SFosaDO8GB6APgaaXCb8hRlPnHj0mUJyG0FRniPdAVNkMGk8Wz/DXJd89jihbTTzV6h4SNtU0fs98bl/hTRS3Gaym/IAI1v3gVvPUXflA91MLM2qdZLY8GXrejJSx1/vCn+UWCXqdDwm2N0NQ7XVAOz4tJHGGvpPB43wFB/6H36xh4RzePosFLsyfb/C8UN1rYvOrbd0gt9zpWFTPmdUXCnZQGS7yFief5pONCWZLGM6JeLixVRwWFbzAWvOygZXKmuz17Vx7zQFgcjEJMBsaMatG3Mo1tDAAWWvTScgj/sQqi/mrgOZjz6R/xu8W8TdLsOtI6K41BYCu/mtktndwUGIuPJoTmBa1uL/fTztOGrKFo7k6hNna0BikSI/Fx7D9BhCutNcjPQExZtQgS2m2NHCKsbHtIfFkyk48Vr2tZ6yBAUBuK3a6xnkPHTTwoSz2IRIF3oKaK9ad/hi1pFtZe4T5DP/xHVFqwaPWk6zarr6brj7mE83CEG9G0wT6/3A43KhNJJXgJ6hb99QglFjjfeyvC2Cby4iFyFDEdwxQiS9RO3ZwgkhlbQ3HzMyoqQhacx74916keIeCEXCGShJdKOQd0wmbYwYuHF7JuPn7fLfJWjTZB5c39rB/bwfaCS8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(366004)(136003)(396003)(39860400002)(376002)(346002)(6506007)(38100700002)(33964004)(53546011)(41300700001)(6666004)(166002)(44832011)(2906002)(2616005)(186003)(6512007)(26005)(316002)(110136005)(31696002)(36756003)(8676002)(66476007)(66556008)(66946007)(31686004)(86362001)(966005)(6486002)(5660300002)(478600001)(8936002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDhqMkpndzNmaFBiZFdNQ3dFNVdDZzFmRkQ0WGlYMWEyT2pqSzRxNHVtRGpq?=
 =?utf-8?B?QXZPZUFMYVFoaDBKSWowQ2pKWU01U1ZNUVRGWCt5Tlh1WFBoUGpoc0Y5cjEw?=
 =?utf-8?B?R0RZUHFreFB2dUVoRGhmdU9MOGtkSW1UMm5Rc1N2VW55dDBMbkVQRGVUTS9t?=
 =?utf-8?B?dVdJdkhyZHdNdGo5dkZBVzhHMWtRSm5ZSjBjR2xzeTdFQ0RTZDFnZDFNMFRl?=
 =?utf-8?B?d0FIbTlSTWRydklldzVBQ3ZObTM3K0dFelZpb3NHZllZcjhidkVxaktKZXEz?=
 =?utf-8?B?VjJCZEFxcnJMSDVoZ2xaMHlUUkdHNDFaSnZrOWxucGQ5Y1hCbXBvcDB1NEph?=
 =?utf-8?B?N2xONWdkS1dFV01sUGd2eGhkODM5UVVwWnBDVW1Lb2NmTzc0LzNPRUtJN25q?=
 =?utf-8?B?U2syejV1OXlVT0VtZFJrdFJYZUxDY1pncnJQaHd3U3hITDFBTy9NaUNMeHRk?=
 =?utf-8?B?TkRSeHVUTVA2bkNLdUlrckZxajBkYit0M2cwZy9Sd3J4WlA4NkNUQzZqQnNG?=
 =?utf-8?B?Y01sdEc3aGszNDJtUjV3Z2gwZklQaWV0engvRHNVKzl5Nm1SdFNRd2hZOEFt?=
 =?utf-8?B?Yzg2bWNkQ0cwT2JxR0tLWjZlbmljT1JGUHN5M0FiYk1BU3BNTXhkYVRpcmhM?=
 =?utf-8?B?V0lWWXgrTTFRQWxLVGFkT3d5ZndnQnhNOFZPeWphSnFYcEwzQnJOTDZaQ0dR?=
 =?utf-8?B?WGptU1I4ZHVaK2FKYXhVT0oyZCsxclFpSXV0Z1I4SUVjRXA0ZHovVEhES3VW?=
 =?utf-8?B?V24wYkdOWmtBdU1qdElhQ1NPMGpEVXNHeThZS0pBd3NwTjdvdFRLR1NjQ3Rq?=
 =?utf-8?B?ODYwaTNWbFZaRmNmVjVhZFBkcTVyMlE2VC8xQkpBb3BVLzk0eFhxQVk0TlF3?=
 =?utf-8?B?OW1jbzBGN0w3RzBWclJzUGhsV21YOElseEdNZ1ZoWG1ydWtrcTk0Ly8rN09E?=
 =?utf-8?B?bXhud01oeStneEgvTzZFVE1KNkF0SE9FbG5WUjFjdjQrU0tVc0svU0p3YnRv?=
 =?utf-8?B?N1hvRVJ3Y2lCcmRqS2Zsc1VwRkVqa2c1WWxNNEdvaHRzclhWa3ZZdUZjVytK?=
 =?utf-8?B?eGFrZ3lzMXRuMityM2pTdFQ1Ym5UVlVMUTd0enJnVWM3eEdMZzBlSmQ2Q0VD?=
 =?utf-8?B?b0FQbHN0dVp6bGJWZ1lmZWxkM1ZCUWFxMXJPcm9LL2NRNnovYUdCWENVd0s5?=
 =?utf-8?B?cFhCVmlGUHV1V2FrVS9rL0pvM3NYbDVtaUQyL0VXbDVsSHlKNzU3UForSXgw?=
 =?utf-8?B?c1dZUmlPbXI2TlNFNkoyY2Y2Si9HM3lsN2NVUEE0bzloWW5QK3B1bzhzcnFl?=
 =?utf-8?B?SVU1c3R0SWFoMGhVV3RsZWluZnhxdjkvWWQyQnlHZ0hFQmF0Y2VDazRLSEQy?=
 =?utf-8?B?d2JMMHo4SWQyM2txNnFrS1RaUVh0RzI3MUc1bVh2YnlWNTBIU1UyWllwbFdj?=
 =?utf-8?B?V2RlVDFIb2JiWjc2andHczUrZmFMQkgvK2ZmaXhuOWg0Y3JPQ1NLYVp0NEJN?=
 =?utf-8?B?NjhuK3c2OUlYcTZZZ0FNcmdJVmg1RG54RS9kbnoyb3BzNitUdGN6WDJ5ZFBH?=
 =?utf-8?B?Q0hTakFsWXNGT1NtVEhQRkhnZmFEWDJzVGJPMEhQUFp0MHNDb2xaT0VOeGlu?=
 =?utf-8?B?Y0Vjdkx1YTU4TWJNRUs4czlURVkyZGJlZlMxTy9abG1XdmdTTkdDbW42M0FD?=
 =?utf-8?B?c2psZXltV3oxNTVmaXBvUC9UVy9KNW96WVgzUDg5MUFZUVFnZ2tTZWpMOUFG?=
 =?utf-8?B?d1hhS2l2Y3hBWmxNLytXWmpzSkVlR0t0K0NNOFBPbUFLS2o4aitCWFFPdjQx?=
 =?utf-8?B?c0t6TXhvZ3RDMy9taHA3cklGb3FORFFVZS9Gc2YxdmJObjUyNnFXMEt2ZDRs?=
 =?utf-8?B?R0hvL3dYVGpmOWFBcmVoUjZ2ZFBZZXdWdG5CRHhZOWpsekhYaFVFMzBDdG1l?=
 =?utf-8?B?S0VLNnhlMXNOV1N2SUY5OGlIV1dmNmI4SVJ5RDN6QUhaMmFXNUcxQnp3cVY5?=
 =?utf-8?B?Z2lFRGtRYWpPZVZmZ3NMdmNSaERRQ1FCWEtFdjNCWXNkMG81QkU0QzQzWjFI?=
 =?utf-8?B?Nmorem1PVG10WSt2cWRyRHZpbDdWb0pVWTd2MUx2bjJLaFhHUEI5R01ieGla?=
 =?utf-8?B?WmRUTmwzeDVUbG5rTDNOTE9wRWlPYkNMMTkyYlpJcjlpZUx0bEZkVmZXWThy?=
 =?utf-8?B?dWc9PQ==?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f968735e-e4a4-4ad9-7a05-08da791cc3c1
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2022 09:02:47.7565 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t5K61QFvaisXGr+KSs8lqB/IaM89pqwmcLZE2nDvMlfPJbl0tbmkpfO/ENl4caIrnQFbatzIzpRzeCJ8zuPWOwSQIgJnUYfzGskYj3yFx+I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8842
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Duration run time of each benchmark
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
Content-Type: multipart/mixed; boundary="===============1360121243=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1360121243==
Content-Type: multipart/alternative;
 boundary="------------Rz7MMEmoXi0jASh91EmBWJJA"
Content-Language: en-US

--------------Rz7MMEmoXi0jASh91EmBWJJA
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi!

We are currently working on a new LTP runner which is the future 
replacement of the runltp script written in bash: 
https://github.com/acerv/runltp-ng
The new runner is written in python 3.7+ and it supports duration time 
between tests. At the moment, it considers execution time of a single 
test binary,
not the duration time of specific TPASS/TFAIL results as you might 
expect, also because the old format is still supported and it doesn't 
give this possibility.

If you don't need to have duration time of specific TPASS/TFAIL , 
runltp-ng might be the #1 choice for you, since it also implements a 
JSON report file which
can be parsed easily to obtain the results.

The runltp-ng source code is open and available to everyone, so feel 
free to help and give any feedback if needed!

Regards,
Andrea

On 8/8/22 10:17, Chen, Zion via ltp wrote:
>
> Hello Linux Test Project
>
> We are in SAP using your ltp benchmark in our linux machine. We are 
> looking in the results file after the run is finish and we want to 
> know the duration time of each sub-test.
>
> Can you point me how to do it? How to find the duration time of each 
> sub-test?
>
> Regards,
>
> Zion
>
>

--------------Rz7MMEmoXi0jASh91EmBWJJA
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">
      <div class="moz-cite-prefix">Hi!</div>
      <div class="moz-cite-prefix"><br>
      </div>
      <div class="moz-cite-prefix">We are currently working on a new LTP
        runner which is the future replacement of the runltp script
        written in bash: <a class="moz-txt-link-freetext" href="https://github.com/acerv/runltp-ng">https://github.com/acerv/runltp-ng</a><br>
      </div>
      <div class="moz-cite-prefix">The new runner is written in python
        3.7+ and it supports duration time between tests. At the moment,
        it considers execution time of a single test binary,</div>
      <div class="moz-cite-prefix">not the duration time of specific
        TPASS/TFAIL results as you might expect, also because the old
        format is still supported and it doesn't give this possibility.</div>
      <div class="moz-cite-prefix"><br>
      </div>
      <div class="moz-cite-prefix">If you don't need to have duration
        time of specific TPASS/TFAIL , runltp-ng might be the #1 choice
        for you, since it also implements a JSON report file which</div>
      <div class="moz-cite-prefix">can be parsed easily to obtain the
        results.</div>
      <div class="moz-cite-prefix"><br>
      </div>
      <div class="moz-cite-prefix">The runltp-ng source code is open and
        available to everyone, so feel free to help and give any
        feedback if needed!<br>
      </div>
      <div class="moz-cite-prefix"><br>
      </div>
      <div class="moz-cite-prefix">Regards,</div>
      <div class="moz-cite-prefix">Andrea</div>
      <div class="moz-cite-prefix"><br>
      </div>
    </div>
    <div class="moz-cite-prefix">On 8/8/22 10:17, Chen, Zion via ltp
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:VI1PR02MB61896EFAC4D92D36C0723295EA639@VI1PR02MB6189.eurprd02.prod.outlook.com">
      
      <meta name="Generator" content="Microsoft Word 15 (filtered
        medium)">
      <style>@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-fareast-language:EN-US;}span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;
	mso-fareast-language:EN-US;}div.WordSection1
	{page:WordSection1;}</style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext="edit">
<o:idmap v:ext="edit" data="1" />
</o:shapelayout></xml><![endif]-->
      <div class="WordSection1">
        <p class="MsoNormal"><span lang="EN-US">Hello Linux Test Project<o:p></o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US"><o:p>&nbsp;</o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US">We are in SAP using your
            ltp benchmark in our linux machine. We are looking in the
            results file after the run is finish and we want to know the
            duration time of each sub-test.<o:p></o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US">Can you point me how to
            do it? How to find the duration time of each sub-test?<o:p></o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US"><o:p>&nbsp;</o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US">Regards,<o:p></o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US">Zion <o:p></o:p></span></p>
      </div>
      <br>
      <fieldset class="moz-mime-attachment-header"></fieldset>
      <pre class="moz-quote-pre" wrap="">
</pre>
    </blockquote>
    <p><br>
    </p>
  </body>
</html>

--------------Rz7MMEmoXi0jASh91EmBWJJA--

--===============1360121243==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1360121243==--
