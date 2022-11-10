Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6ECCC433FE
	for <ltp@archiver.kernel.org>; Thu, 10 Nov 2022 09:19:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6C4793CD631
	for <ltp@archiver.kernel.org>; Thu, 10 Nov 2022 10:19:11 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 194663CA9A3
 for <ltp@lists.linux.it>; Thu, 10 Nov 2022 10:19:00 +0100 (CET)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-eopbgr60067.outbound.protection.outlook.com [40.107.6.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D6D291A010F4
 for <ltp@lists.linux.it>; Thu, 10 Nov 2022 10:18:58 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hEhZzGZfOdiebZyvBPN+Kg1dX5AjzN2WtRlq7qHRA+tdMnqbrWxU3ziZuFnfx3h+gnEjisfzAkqGey00+UekBeXxv8XxNg+sjJXkVhChROW9joTiKJPyawDsMI+Ls1GPkFFO2cLFNDHZJmGeLwfoRHrOvEgLr3tKVTDagFbqL5Qe3gIaCifxDFeYZ/4b1SPIGl52tB13ewDNXDVgDfmMdjMjCfLMV9dCABmsf5oszjhLlsoAsvd5TN2zbUnvC+qFAOZhMJ5ZN8A5pQKHf3PW2ggRDlMtq2oCDuW7Zwut/d6kaaBF4Inzywthfo4zxFJg2AimEiyeHzXH8Igc5ybxHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g346hAa59i4U3im9q8BcVbRDGb2QlHuWgJCin7OQ+CI=;
 b=JQ5N+UhaTEgkdDd/eNWidPVNopKaLAKBrH85GMUn8sjy2BqH+dlAQz6ZVSbp6ApRx+zvzeoKTx7DzM/Lhxy95rIt5wrrdC+JpAinpMJjJ3v1iKrarjgpGkc4GFMfJyLEhVrIqLi4HixqgH4JqkrJXi2J0w/skrKlsTfLpVjAZDpokaKYEX1WV0d9AQ102HTBf5Lf2AQwSEaXCKH8BfHqzP+qgbJJaPnsyLV64tPMBULRsbEvIYtShFxScbDUAwmE0ggb5YPZUP68v6vu63ZIDYXsyCjMdriGJSKyJPI3rZl98omgJJCYNubBFx5SzR5IM6vEwV9IUSN5ClgR1BGYOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g346hAa59i4U3im9q8BcVbRDGb2QlHuWgJCin7OQ+CI=;
 b=5Ux3wBBqPnaF0FGFwaMJ1Bgv3txjtuwJ4aoJr/ExnT4ql8yTlA7zLan2wbguPENtmLWNMfcFP0sP2E4AxsTdD5MmprioSiQJ+NalIQOx3IqAazNRxCHMy0fduWIds+itdbf71BfJOu2fDXktGTSfYvqguWFH8vglaPjCPEkGYF8llwt6kuosyt5PFsIY1vHqJpKabPCXQrKf07lDvIH66wKyGCJwpLwrBbZMzlKAPJsDfBeiUcA1SgXxK6q6IVwdYr/9RcEKs2SgbvvIjaGWUADPDI3wJf3/Eog3pFEtyufTene3Z1gEt2Ksjhsrw8X83pfc3c10eWA2ZimcNOqoMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by PAXPR04MB8800.eurprd04.prod.outlook.com (2603:10a6:102:20f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Thu, 10 Nov
 2022 09:18:56 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::252e:5914:3caf:6257]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::252e:5914:3caf:6257%4]) with mapi id 15.20.5791.027; Thu, 10 Nov 2022
 09:18:56 +0000
Message-ID: <f603b575-cfce-bb09-a8ae-ccb1c00f5a24@suse.com>
Date: Thu, 10 Nov 2022 10:17:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
To: Li Wang <liwang@redhat.com>
References: <20221107110123.16369-1-andrea.cervesato@suse.com>
 <CAEemH2fjCBfO3KP1Z7j1fsJde9izthzV2S-zPLiKaT8bAhhTUg@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAEemH2fjCBfO3KP1Z7j1fsJde9izthzV2S-zPLiKaT8bAhhTUg@mail.gmail.com>
X-ClientProxiedBy: FR3P281CA0074.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::12) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB6797:EE_|PAXPR04MB8800:EE_
X-MS-Office365-Filtering-Correlation-Id: 410d8bd1-6d18-4100-d80f-08dac2fc97bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1ZaF7BmZhGzzBv43levkeMXbPrE8PmsoourTfKSSkNvcqo0LccV4WvmndWDCSZ29j2DrmpIAFpPEFe9JvHRkgV1oWHwzxCwJNaAek9uwW8HOhjWTTUwiBevTp0HAEwfDRaADqBfadEAl7oY0NiTcOs6XvTuM3CYLcLlnNEPoMCD+4ETRyqNyRxMNQPAMk12k2IPp5gOtMtnOfMnAaK1jPnGGnD5UOkDNi9TGIWOW9TLa3MGr5ACeX+vDBnndb2lQtvXxw3ltRl6eqxYENuJUQR/o4hP1Dd5npIzlBlS1wTBEPzQfG0mixzMcjs3wifdeVGwuBarBxvS8KrduY1pEcKClr2Eu3BbB3TViJKKtmxzc/KRA//VHWVwCZ0bd/P3IB3+RsGY0P6cx6iP3x6VM2bThWowWhS7XB7AAvyD82LX4IJz9c3Fwf3ht9V7WX+JXfmifLTL2vWBSfHo8TnXh4LPVc55NNDqYL4KIzVHJqKwVRHkMFlEngxWdm3s4HQaIg0fND8UQZXyxkNawmq+d4eBsRJtpoLiQc6teswoe4GSZqpDuKNglEWyojFTk+egd9O5v6G6ZoWd6bg7g6yOG2fHMOgGDxAxoGpttk4a3pt0YoykcpM+nOTcELKd6QrwZOO5iHEz54ENqUguya0thP59Klzl4+ReRw1y22uze4/JwRYhmbFUGuXxL9tkgb+VyulI+5geiKMUUyFR2gPkWqwf6sCmOJ8gq6W8c+4iyb4aGWwmU1GHMZz9YVENGTQoisaj41uzbeTfLYYG97FlbwuBeziaPPrexQdSwFjO/RQ5rrI64yhR6o/gadQT5u8Zh
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(396003)(39860400002)(376002)(136003)(346002)(366004)(451199015)(38100700002)(2906002)(44832011)(86362001)(31696002)(166002)(4326008)(6506007)(6666004)(26005)(2616005)(53546011)(478600001)(33964004)(6512007)(316002)(66556008)(6916009)(966005)(8676002)(66476007)(6486002)(54906003)(8936002)(66946007)(5660300002)(186003)(36756003)(83380400001)(41300700001)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dzJVbTNDbnhrYmlLQzVGaVlwOUtjTkNyQmtkQUM1bDhMTDhlZSt0djlaSE5U?=
 =?utf-8?B?SXp5bEgwbXpCVjNoUmRxNC8xenFYblNZS2U2cEpqZkJTU2NNQTZ5UVdPbThV?=
 =?utf-8?B?NkNJQmFNM2svbVBTK1lQRGFUUFVybC9SYnI4SGVXL0xKazJqV0RkYjMvaVhI?=
 =?utf-8?B?Z1kwNE5jREdCUEVzUm1URHdjVVdmT0RLVUttT3BYUkZva1QrNDhiSlBFSDlr?=
 =?utf-8?B?cWFwQlhUZ3RCYUJybnZGcmpaN0U2QjBwR2JQdXNMZCtQTEdGUXNvRjZIYjdX?=
 =?utf-8?B?SFFGZHdYbkhZbVZrVmJxQkR5WW5hcE1JeTVLK0dZM0xBVWM3Y2VBYXkxai9K?=
 =?utf-8?B?ZXREa3JaZ0ZYOFl4NkRjUXlWMSs3bTdWZGJCRjNNNVRmTTlIN25vZEo3Skh0?=
 =?utf-8?B?WVpTZDUrWElPVk53aVE5dEFTVjN1YVF1MlhmekxiS0ZCNnZnMDhvYkVKRUh2?=
 =?utf-8?B?ZTdmbXoya044Mld0dXYvNUZEQTlDbFoxeVFCNjRyeUNRakgycEpTeS9vdTlX?=
 =?utf-8?B?amVhTkJZZzlsci9yR0ZZZi9SbTlGalhNL1dENE9mTTNBb2hQaHg5MDE4TjB1?=
 =?utf-8?B?UzRmV3o2OEtsVGVSbGthckRCcWltOFA2dmJFeExGbkM4anpmeGZEVmZnZ0Vn?=
 =?utf-8?B?WnpNRTBteUJrNENneFNMYUt6OURUODRZaUtYWEY1SVJZaUl2RnZPNng4Wkh0?=
 =?utf-8?B?SmNkc0Roc0tIaEMrTjhHbjZxYy8vM2NtdUs3Nk1ObjlLTmZJQWgwWk1DVnVz?=
 =?utf-8?B?RG1SS2xCSSt2Y2IySmNBbVBrMlZzc3pLdFg0SjBpOWo2OUVDUWhTbXYrY0JP?=
 =?utf-8?B?ZjZ6NWdGSVozclJsUGRrMXZ5K05YQ0lET1ltVWs0ZHlkZzJwUFBTMm1TQmEw?=
 =?utf-8?B?OVJXQ0NTL3djTnhxS21tYU5QbTVDL2RmYjI0VG43UVY4ZHZva0hMNllucWFH?=
 =?utf-8?B?Ky85dHIwRjljcm43elRTNk4xRWRIemUzZDJMTHA3cEpMR01SSnMwUG52dG52?=
 =?utf-8?B?bTEyZEJVWENvYVFFbHk3Mm85UEYwaTdkMlk1L1UzUU1RUDF1Nk5vTmsySlVZ?=
 =?utf-8?B?Nnc3VVUxZy9EODlMRVR6MmN5dVgvMEwvR2dGZThNNnRqTkxTREtuWWxESDg0?=
 =?utf-8?B?dHFEWXRqMHJ6NHpoRWdnMnpPcnNRRXFZK0J5dFdkVGpxMXlDQnd2TE5uaGY0?=
 =?utf-8?B?M1pOL1pkODJHT2RlU2lLSGpMVUxKNUVZTi9tQUVtSFZkNW9Nb2N5eklKOGZT?=
 =?utf-8?B?YlUwTjdmRWVRQXVydVErLzVxRW10dStGU3ZXcmhmb2NLc0E5ekZUVUJCQzRl?=
 =?utf-8?B?WFBHYzNNSE50dVcvNXdad0sxMFF3TSs5OTJsUVU2cjF0SU95N2ZVckFuUWJP?=
 =?utf-8?B?d0JEaGdFUWlkaU1IY3Fqam1qYXg3U21mSlhFVVNHbTBPRERkZmZsb3hNS05T?=
 =?utf-8?B?VkJVbmVleW9mNWZUSlIrNEo0dHdHaUlVVGJ2YW81c1lSd0o2M1FNM0RoSUdV?=
 =?utf-8?B?Z3lreER0RVF2U1VyZzJWKytxRm9ldHZsT05OaUp6L3R4akRCK3pmQS9QRldK?=
 =?utf-8?B?Y0tYT3J1RmtkRVdaUFNKbDFvME1hU0UxQzZORXArVm5UNTU0R285YzZxaUVY?=
 =?utf-8?B?WWc1WEpNemgzaHlWVlRZaElaUi9aT0FsSnpMMWFHMmxPK3NKdmNHcmlWWEUx?=
 =?utf-8?B?MjdYdlA2d0JvMFJKTmFsTE9GOCtEcHRJbGF5Y0pnZjR5SkNaV0F6MEc2UjNz?=
 =?utf-8?B?dXV6eWRNV2YvcG5QL2k0YkE4YVpKMXExRTlRSGQ5VVUrWlZHb3BsZFZPbm5X?=
 =?utf-8?B?aWJ2Unh2Y3g0YWsyU3B6NU5rR2ExZVI5NmowTW9sRmJBNk9tUk5EUW93bkJZ?=
 =?utf-8?B?R0RwOHY1Ykk0R01BbkdwNFAyaG5XTkp0VGdUbkVNNVQ1TWNsenZQRnJyRkFL?=
 =?utf-8?B?UlcxbG5ObjAyWHZkVTdZMG4vQUlLWXZpYklvQ0VKanZEL2t5UUczelZ1eFZp?=
 =?utf-8?B?alFrYWo5aUgvdS9aVk5GcHZzZVpnOHFPeGJWYXdXdDVBam12MC8rZlJvdGZj?=
 =?utf-8?B?ZFphVFdBWVF6eWMzQVhQcGQyZm8vSWZ0eFhSbEpxeFFBK1NhdnE1ZzAvTm5M?=
 =?utf-8?B?MjNFOWcreUhGazNFWlZqakZFU093U29lSFltYUd2R0RlQUZQcGJNRFdaaE5h?=
 =?utf-8?B?MHc9PQ==?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 410d8bd1-6d18-4100-d80f-08dac2fc97bc
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2022 09:18:56.1504 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X4tmK7xUPmsQ27E/Bxu+WNS0BtOJO2ERdiHeBROldjRU26ANbKhd4crwBZpmjylCm8+BY6bLAt3WCDcIqmxjgEJv/AduMSbGHZ8PjL4fCI8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8800
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Correctly check setitimer params in setitimer01
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
Content-Type: multipart/mixed; boundary="===============1745271462=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1745271462==
Content-Type: multipart/alternative;
 boundary="------------sjUVQfcc03pAhsRvxRwhjm8F"
Content-Language: en-US

--------------sjUVQfcc03pAhsRvxRwhjm8F
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi!

On 11/10/22 08:01, Li Wang wrote:
> Hi Andrea,
>
> On Mon, Nov 7, 2022 at 7:03 PM Andrea Cervesato via ltp 
> <ltp@lists.linux.it> wrote:
>
>     We use CLOCK_MONOTONIC_COARSE as our time resolution for checking
>     setitimer counter boundaries.
>
>     Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
>     ---
>     Switching to CLOCK_MONOTONIC_COARSE for setitimer time resolution.
>
>      .../kernel/syscalls/setitimer/setitimer01.c   | 33
>     +++++++++++--------
>      1 file changed, 19 insertions(+), 14 deletions(-)
>
>     diff --git a/testcases/kernel/syscalls/setitimer/setitimer01.c
>     b/testcases/kernel/syscalls/setitimer/setitimer01.c
>     index eb62f02c6..5c880c6ef 100644
>     --- a/testcases/kernel/syscalls/setitimer/setitimer01.c
>     +++ b/testcases/kernel/syscalls/setitimer/setitimer01.c
>     @@ -8,7 +8,7 @@
>      /*\
>       * [Description]
>       *
>     - * Spawn a child and verify that setitimer() syscall passes, and
>     it ends up
>     + * Spawn a child, verify that setitimer() syscall passes and it
>     ends up
>       * counting inside expected boundaries. Then verify from the
>     parent that our
>       * syscall sent the correct signal to the child.
>       */
>     @@ -22,7 +22,8 @@
>      #include "tst_safe_clocks.h"
>
>      static struct itimerval *value, *ovalue;
>     -static unsigned long time_step;
>     +static long time_step;
>     +static long time_count;
>
>      static struct tcase {
>             int which;
>     @@ -56,7 +57,6 @@ static void verify_setitimer(unsigned int i)
>      {
>             pid_t pid;
>             int status;
>     -       int usec = 3 * time_step;
>             struct tcase *tc = &tcases[i];
>
>             pid = SAFE_FORK();
>     @@ -66,7 +66,7 @@ static void verify_setitimer(unsigned int i)
>
>                     tst_no_corefile(0);
>
>     -               set_setitimer_value(usec, 0);
>     +               set_setitimer_value(time_count, 0);
>                     TST_EXP_PASS(sys_setitimer(tc->which, value, NULL));
>
>                     set_setitimer_value(5 * time_step, 7 * time_step);
>
>
> Maybe we can use 'time_count' instead of 'time_step' as well.
>
This is needed if we want to check when setitimer syscall overrides 
value/ovalue on failure. We always expect time_count to be set in this case.

>     @@ -76,7 +76,7 @@ static void verify_setitimer(unsigned int i)
>                             ovalue->it_value.tv_sec,
>                             ovalue->it_value.tv_usec);
>
>     -               if (ovalue->it_value.tv_sec != 0 ||
>     ovalue->it_value.tv_usec > usec)
>     +               if (ovalue->it_value.tv_sec != 0 ||
>     ovalue->it_value.tv_usec > time_count + time_step)
>
>
> This is not correct for 'ITIMER_REAL', kernel does _not_
> add that one jiffy when using high resolution. I'd suggest
> taking reference to Martin's code in the last email thread.
>
> And, I also think we'd better insert code comments here to
> briefly declare why need to add the time_step for the result
> (of ITIMER_VIRTUAL/ITIMER_PROF) comparison, otherwise,
> people who are not familiar with this test will be confused.
Sure, I agree this this
>
>                             tst_res(TFAIL, "Ending counters are out of
>     range");
>
>                     for (;;)
>     @@ -93,24 +93,29 @@ static void verify_setitimer(unsigned int i)
>
>      static void setup(void)
>      {
>     -       struct timespec res;
>     +       struct timespec time_res;
>
>     -       SAFE_CLOCK_GETRES(CLOCK_MONOTONIC, &res);
>     +       SAFE_CLOCK_GETRES(CLOCK_MONOTONIC_COARSE, &time_res);
>
>
> And here require code comments on why we choose to
> use CLOCK_MONOTONIC_COARSE.
>
>
>     -       time_step = res.tv_nsec / 1000;
>     -       if (time_step < 10000)
>     -               time_step = 10000;
>     +       time_step = time_res.tv_nsec / 1000;
>     +       if (time_step <= 0)
>     +               time_step = 1000;
>
>     -       tst_res(TINFO, "clock resolution: %luns, time step: %luus",
>     -               res.tv_nsec,
>     -               time_step);
>     +       time_count = 3 * time_step;
>     +
>     +       tst_res(TINFO, "clock resolution: %luns, "
>     +               "time step: %luus, "
>     +               "time count: %luus",
>     +               time_res.tv_nsec,
>     +               time_step,
>     +               time_count);
>      }
>
>      static struct tst_test test = {
>             .tcnt = ARRAY_SIZE(tcases),
>             .forks_child = 1,
>     -       .test = verify_setitimer,
>             .setup = setup,
>     +       .test = verify_setitimer,
>             .bufs = (struct tst_buffers[]) {
>                     {&value,  .size = sizeof(struct itimerval)},
>                     {&ovalue, .size = sizeof(struct itimerval)},
>     -- 
>     2.35.3
>
>
>     -- 
>     Mailing list info: https://lists.linux.it/listinfo/ltp
>
>
>
> -- 
> Regards,
> Li Wang

Andrea

--------------sjUVQfcc03pAhsRvxRwhjm8F
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">Hi!</div>
    <div class="moz-cite-prefix"><br>
    </div>
    <div class="moz-cite-prefix">On 11/10/22 08:01, Li Wang wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:CAEemH2fjCBfO3KP1Z7j1fsJde9izthzV2S-zPLiKaT8bAhhTUg@mail.gmail.com">
      
      <div dir="ltr">
        <div dir="ltr">
          <div class="gmail_default" style="font-size:small">Hi&nbsp;Andrea,</div>
        </div>
        <br>
        <div class="gmail_quote">
          <div dir="ltr" class="gmail_attr">On Mon, Nov 7, 2022 at 7:03
            PM Andrea Cervesato via ltp &lt;<a href="mailto:ltp@lists.linux.it" target="_blank" moz-do-not-send="true" class="moz-txt-link-freetext">ltp@lists.linux.it</a>&gt;
            wrote:<br>
          </div>
          <blockquote class="gmail_quote" style="margin:0px 0px 0px
            0.8ex;border-left:1px solid
            rgb(204,204,204);padding-left:1ex">We use
            CLOCK_MONOTONIC_COARSE as our time resolution for checking<br>
            setitimer counter boundaries.<br>
            <br>
            Signed-off-by: Andrea Cervesato &lt;<a href="mailto:andrea.cervesato@suse.com" target="_blank" moz-do-not-send="true" class="moz-txt-link-freetext">andrea.cervesato@suse.com</a>&gt;<br>
            ---<br>
            Switching to CLOCK_MONOTONIC_COARSE for setitimer time
            resolution.<br>
            <br>
            &nbsp;.../kernel/syscalls/setitimer/setitimer01.c&nbsp; &nbsp;| 33
            +++++++++++--------<br>
            &nbsp;1 file changed, 19 insertions(+), 14 deletions(-)<br>
            <br>
            diff --git
            a/testcases/kernel/syscalls/setitimer/setitimer01.c
            b/testcases/kernel/syscalls/setitimer/setitimer01.c<br>
            index eb62f02c6..5c880c6ef 100644<br>
            --- a/testcases/kernel/syscalls/setitimer/setitimer01.c<br>
            +++ b/testcases/kernel/syscalls/setitimer/setitimer01.c<br>
            @@ -8,7 +8,7 @@<br>
            &nbsp;/*\<br>
            &nbsp; * [Description]<br>
            &nbsp; *<br>
            - * Spawn a child and verify that setitimer() syscall
            passes, and it ends up<br>
            + * Spawn a child, verify that setitimer() syscall passes
            and it ends up<br>
            &nbsp; * counting inside expected boundaries. Then verify from
            the parent that our<br>
            &nbsp; * syscall sent the correct signal to the child.<br>
            &nbsp; */<br>
            @@ -22,7 +22,8 @@<br>
            &nbsp;#include &quot;tst_safe_clocks.h&quot;<br>
            <br>
            &nbsp;static struct itimerval *value, *ovalue;<br>
            -static unsigned long time_step;<br>
            +static long time_step;<br>
            +static long time_count;<br>
            <br>
            &nbsp;static struct tcase {<br>
            &nbsp; &nbsp; &nbsp; &nbsp; int which;<br>
            @@ -56,7 +57,6 @@ static void verify_setitimer(unsigned int
            i)<br>
            &nbsp;{<br>
            &nbsp; &nbsp; &nbsp; &nbsp; pid_t pid;<br>
            &nbsp; &nbsp; &nbsp; &nbsp; int status;<br>
            -&nbsp; &nbsp; &nbsp; &nbsp;int usec = 3 * time_step;<br>
            &nbsp; &nbsp; &nbsp; &nbsp; struct tcase *tc = &amp;tcases[i];<br>
            <br>
            &nbsp; &nbsp; &nbsp; &nbsp; pid = SAFE_FORK();<br>
            @@ -66,7 +66,7 @@ static void verify_setitimer(unsigned int
            i)<br>
            <br>
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; tst_no_corefile(0);<br>
            <br>
            -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;set_setitimer_value(usec, 0);<br>
            +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;set_setitimer_value(time_count, 0);<br>
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; TST_EXP_PASS(sys_setitimer(tc-&gt;which,
            value, NULL));<br>
            <br>
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; set_setitimer_value(5 * time_step, 7 *
            time_step);<br>
          </blockquote>
          <div><br>
          </div>
          <div>
            <div class="gmail_default" style="font-size:small">Maybe we
              can use 'time_count' instead of 'time_step' as well.</div>
            <br>
          </div>
        </div>
      </div>
    </blockquote>
    <p>This is needed if we want to check when setitimer syscall
      overrides value/ovalue on failure. We always expect time_count to
      be set in this case.<br>
    </p>
    <blockquote type="cite" cite="mid:CAEemH2fjCBfO3KP1Z7j1fsJde9izthzV2S-zPLiKaT8bAhhTUg@mail.gmail.com">
      <div dir="ltr">
        <div class="gmail_quote">
          <div>&nbsp;</div>
          <blockquote class="gmail_quote" style="margin:0px 0px 0px
            0.8ex;border-left:1px solid
            rgb(204,204,204);padding-left:1ex">
            @@ -76,7 +76,7 @@ static void verify_setitimer(unsigned int
            i)<br>
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ovalue-&gt;it_value.tv_sec,<br>
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ovalue-&gt;it_value.tv_usec);<br>
            <br>
            -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if (ovalue-&gt;it_value.tv_sec != 0 ||
            ovalue-&gt;it_value.tv_usec &gt; usec)<br>
            +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if (ovalue-&gt;it_value.tv_sec != 0 ||
            ovalue-&gt;it_value.tv_usec &gt; time_count + time_step)<br>
          </blockquote>
          <div><br>
          </div>
          <div>
            <div class="gmail_default" style="font-size:small">This is
              not correct for 'ITIMER_REAL', kernel does _not_</div>
            <div class="gmail_default" style="font-size:small">add that
              one jiffy when using high resolution. I'd suggest</div>
            <div class="gmail_default" style="font-size:small">taking
              reference to Martin's&nbsp;code in the last email thread.</div>
            <br>
          </div>
          <div>
            <div class="gmail_default" style="font-size:small">And, I
              also think we'd better insert code comments here to</div>
            <div class="gmail_default" style="font-size:small">briefly
              declare why need to add the time_step for the result&nbsp;</div>
            <div class="gmail_default" style="font-size:small">(of
              ITIMER_VIRTUAL/ITIMER_PROF) comparison,&nbsp;otherwise,&nbsp;</div>
            <div class="gmail_default" style="font-size:small">people
              who are not familiar with this test will be confused.</div>
          </div>
        </div>
      </div>
    </blockquote>
    Sure, I agree this this<br>
    <blockquote type="cite" cite="mid:CAEemH2fjCBfO3KP1Z7j1fsJde9izthzV2S-zPLiKaT8bAhhTUg@mail.gmail.com">
      <div dir="ltr">
        <div class="gmail_quote">
          <div><br>
          </div>
          <div>&nbsp;</div>
          <blockquote class="gmail_quote" style="margin:0px 0px 0px
            0.8ex;border-left:1px solid
            rgb(204,204,204);padding-left:1ex">
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; tst_res(TFAIL, &quot;Ending counters are
            out of range&quot;);<br>
            <br>
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; for (;;)<br>
            @@ -93,24 +93,29 @@ static void verify_setitimer(unsigned
            int i)<br>
            <br>
            &nbsp;static void setup(void)<br>
            &nbsp;{<br>
            -&nbsp; &nbsp; &nbsp; &nbsp;struct timespec res;<br>
            +&nbsp; &nbsp; &nbsp; &nbsp;struct timespec time_res;<br>
            <br>
            -&nbsp; &nbsp; &nbsp; &nbsp;SAFE_CLOCK_GETRES(CLOCK_MONOTONIC, &amp;res);<br>
            +&nbsp; &nbsp; &nbsp; &nbsp;SAFE_CLOCK_GETRES(CLOCK_MONOTONIC_COARSE,
            &amp;time_res);<br>
          </blockquote>
          <div><br>
          </div>
          <div>
            <div class="gmail_default" style="font-size:small">And here
              require code comments on why we choose to</div>
            <div class="gmail_default" style="font-size:small">use
              CLOCK_MONOTONIC_COARSE.</div>
          </div>
          <div class="gmail_default" style="font-size:small"><br>
          </div>
          <div>&nbsp;</div>
          <blockquote class="gmail_quote" style="margin:0px 0px 0px
            0.8ex;border-left:1px solid
            rgb(204,204,204);padding-left:1ex">
            <br>
            -&nbsp; &nbsp; &nbsp; &nbsp;time_step = res.tv_nsec / 1000;<br>
            -&nbsp; &nbsp; &nbsp; &nbsp;if (time_step &lt; 10000)<br>
            -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;time_step = 10000;<br>
            +&nbsp; &nbsp; &nbsp; &nbsp;time_step = time_res.tv_nsec / 1000;<br>
            +&nbsp; &nbsp; &nbsp; &nbsp;if (time_step &lt;= 0)<br>
            +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;time_step = 1000;<br>
            <br>
            -&nbsp; &nbsp; &nbsp; &nbsp;tst_res(TINFO, &quot;clock resolution: %luns, time step:
            %luus&quot;,<br>
            -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;res.tv_nsec,<br>
            -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;time_step);<br>
            +&nbsp; &nbsp; &nbsp; &nbsp;time_count = 3 * time_step;<br>
            +<br>
            +&nbsp; &nbsp; &nbsp; &nbsp;tst_res(TINFO, &quot;clock resolution: %luns, &quot;<br>
            +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&quot;time step: %luus, &quot;<br>
            +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&quot;time count: %luus&quot;,<br>
            +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;time_res.tv_nsec,<br>
            +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;time_step,<br>
            +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;time_count);<br>
            &nbsp;}<br>
            <br>
            &nbsp;static struct tst_test test = {<br>
            &nbsp; &nbsp; &nbsp; &nbsp; .tcnt = ARRAY_SIZE(tcases),<br>
            &nbsp; &nbsp; &nbsp; &nbsp; .forks_child = 1,<br>
            -&nbsp; &nbsp; &nbsp; &nbsp;.test = verify_setitimer,<br>
            &nbsp; &nbsp; &nbsp; &nbsp; .setup = setup,<br>
            +&nbsp; &nbsp; &nbsp; &nbsp;.test = verify_setitimer,<br>
            &nbsp; &nbsp; &nbsp; &nbsp; .bufs = (struct tst_buffers[]) {<br>
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; {&amp;value,&nbsp; .size = sizeof(struct
            itimerval)},<br>
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; {&amp;ovalue, .size = sizeof(struct
            itimerval)},<br>
            -- <br>
            2.35.3<br>
            <br>
            <br>
            -- <br>
            Mailing list info: <a href="https://lists.linux.it/listinfo/ltp" rel="noreferrer" target="_blank" moz-do-not-send="true" class="moz-txt-link-freetext">https://lists.linux.it/listinfo/ltp</a><br>
            <br>
          </blockquote>
        </div>
        <br clear="all">
        <div><br>
        </div>
        -- <br>
        <div dir="ltr">
          <div dir="ltr">
            <div>Regards,<br>
            </div>
            <div>Li Wang<br>
            </div>
          </div>
        </div>
      </div>
    </blockquote>
    <p>Andrea<br>
    </p>
  </body>
</html>

--------------sjUVQfcc03pAhsRvxRwhjm8F--

--===============1745271462==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1745271462==--
