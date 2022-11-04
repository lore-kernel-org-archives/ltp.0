Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46C2FC433FE
	for <ltp@archiver.kernel.org>; Fri,  4 Nov 2022 12:11:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9EA783C0321
	for <ltp@archiver.kernel.org>; Fri,  4 Nov 2022 13:11:44 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 642EB3CB49F
 for <ltp@lists.linux.it>; Fri,  4 Nov 2022 13:06:19 +0100 (CET)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-eopbgr150043.outbound.protection.outlook.com [40.107.15.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B13831000F59
 for <ltp@lists.linux.it>; Fri,  4 Nov 2022 09:20:13 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BdE/uwPLmhdLtsJXfalNgF3jBOb8BNBz/r/ukdy8R4Ya+XggBe7MG7bROcpDB1DRI4qLWKcSaF5qj22tOoZDK+aTCezQ1wxBCalxBRNflc1xl/rulwr47Dhc7ptVPc55HOcsjbPJ0QA+BIqiET8wwaxnq9buo8XOm4ejeCYr4R2CxFDkK0I7Xk+/kIibTPGg0Ymg5KQZnN5V/sVm9OwTlLZtYafuluRFWK2ZOzkU+JbIffkZMUCXJUBHBboR4rxkrSOJpcnRhmLo9gKGs4PtQ6W2TPhaL+PED7XZO+2QrmwT2D+Bu/kkcu4cT2BnRJHrLbwcnj4j3wXf6dOtbcQUXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o8mOEyhvZUCYdHwCMSxKPb2AISRz+5FdAK22PTS2g2Q=;
 b=VBwcI9wW5V64PbG7kMpmmHWlB6olnzU5JHCNY1PHrYX4j/y6y4x1D8B6BdbtEKMHptlqg+NFnK8w7skg/EGPaxXCXI3SykMDxD3KDjClcEqZhpFW9Azdk7ucIf9eKKx2l91WS2Z8HysUHDJJjCzT1FWQGUNlKGhQ5p6DbGEfvoy2PRUHDcQJUOXidTm7p7N5JqEvuUuj12ZSdlT5KmSc5q8+6Uq/qD4+1BTJ6WFQvngQuV+s43tKLyszymRVtxcC/FQr5V8CfiT5yA5Im26GA7nDwgKD/ffZT6tb4aI08XNanZ+kC7eiewuwDoGflSjECbNBnFi9s8Mhg9QiT0HkJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o8mOEyhvZUCYdHwCMSxKPb2AISRz+5FdAK22PTS2g2Q=;
 b=pvuQcD3VA5h5iL9K3elgYYhftazmDaxgPm+z3xlsfNWNo1iK2QZ8HujSFwDwhqlC4ugqkqoQQhAy0hoRirCHavzd0PJxpsjx1UFPDT8MuXWowV8iPIwdULqNQ0B+iS0FQF536AQVDmOjU7epRt1UHqmjo8/ZomTApNj6vRLS4KT9CAzxTm7kC8s/A7cQtIUyRLR8kZQKq0TfYiNnFF50PvySRNQ8JnI7HRTwCFOXrWfGzVkZrmEiFbOeTfGccGCQINCi8qPgdJ9XnJa3bBds8f5h8e5quWnTSGDesy/xd7QqUgF15zs8z9c1YrMyqVuBXGnOGSV+f1mtK6N+f4/LWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by PAXPR04MB8685.eurprd04.prod.outlook.com (2603:10a6:102:21c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.20; Fri, 4 Nov
 2022 08:20:11 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::252e:5914:3caf:6257]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::252e:5914:3caf:6257%5]) with mapi id 15.20.5769.019; Fri, 4 Nov 2022
 08:20:11 +0000
Message-ID: <49f3f56b-a2a0-0680-7c7e-8082b637be9c@suse.com>
Date: Fri, 4 Nov 2022 09:18:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
To: Li Wang <liwang@redhat.com>
References: <20221102145935.24738-1-andrea.cervesato@suse.com>
 <CAEemH2ePDmJf-Mq=gk8MX+J7tP-qkGrvqxRL-Ri_k8QjZd842g@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAEemH2ePDmJf-Mq=gk8MX+J7tP-qkGrvqxRL-Ri_k8QjZd842g@mail.gmail.com>
X-ClientProxiedBy: FR3P281CA0014.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::7) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB6797:EE_|PAXPR04MB8685:EE_
X-MS-Office365-Filtering-Correlation-Id: e1b59f7f-136a-4d76-01cd-08dabe3d646b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2j+YVDsaZKWrwgyLMZoxRsFtfCGuWh4ZkfR8Rfcs3SbjAE89RkLDLYUCOy2mReb0sZ62n+RnF0ji6m32T26QzZXzb7JltDMkj1qtm6adUL6rKoIo0JhviHiYkWXABmInoCIPcEcePJTG+MLT/y1gWsDeQYltO/v+sYpPSlBXmGKOT6Dc1OYhG9rTNHwzzCfu074Q+kw1BJoVkcxeXY22Z/8EH6ss6mOozmM1FtigAJTITYpEBHRMb3xoyErxDkE/ryngcBi9T6mfQN/v7BqsM7GhfnGF4dWcPLjurxohpfRa9I3yiuEYkh4q0dR2R/k/t8+TZrqmd4J6XOvM4BaYzWq/eLvWPZOzzkNRrYRKmzlxeutYhbFFECZOiifE3sj6QqhwlI9wcW0nHGMDWnAw07lQHooupGZfPHAY2BBttC8djkf8JhiyRP8t+3ME4YWlbRINEdzFpxymMXz6coyVLHFMbWuLb9baRyItHz/o8r+zy/SIAfsS7razMS54H7F/sSLu7tDqFwB/lqeAQJIN81gm1rSPFBKYo5RzwC1V4vI4k16Z1PB24FaEKM922sW4fv8XIx+OkzzzKaPCzjBbnATaLs0vz/w3ToxlyqkYh190KAlatw63iqyvlak0xb4xnhnujloz5xES26OoedAr991zzRJ5P4ytSYJiwFu2x8vtwP0LNVfoxtVFEmnq9n3+sofTtbcQQakDNvFzTJ3viTmFhge7Gt/5BEGAY8DqqIel3XoU1w5arXjnUbmp/AKDSPhwXgMr9rkjKTGsz4npqJcmYZTXrga5PSepq0DcQyQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(346002)(39860400002)(366004)(396003)(136003)(376002)(451199015)(8676002)(36756003)(66476007)(31696002)(316002)(83380400001)(6486002)(44832011)(33964004)(478600001)(6506007)(2906002)(6666004)(38100700002)(6916009)(4326008)(66946007)(5660300002)(8936002)(41300700001)(54906003)(66556008)(53546011)(2616005)(26005)(186003)(6512007)(31686004)(86362001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUdVVVBCZ094ZVAvVC80dFhPQ1FsWG45NFJGOExORUtUUThyY3ZRd3VRcXJB?=
 =?utf-8?B?NWtCUDRDRmJxNTR5UitaY1pHT01CazVrYnJMbiszV2lsSEtDOVExcFU5WHY5?=
 =?utf-8?B?ajRTUTQ2U0M5aUtBa2xacHp3SnRzRDN6OEs0S1E2WFZ4SGE0ZGJmY0toNGxk?=
 =?utf-8?B?NGllRzdhcENCY25qM3dZSi81aFVvSWpwZVJoYWxVaGJONjZ4SlNucjRmU3RL?=
 =?utf-8?B?TURFd0pvWkNCMlh6SDN0ZTF1d1dtRmFLNGcxVHdYaUpKV1AvNW90NmpCR05m?=
 =?utf-8?B?Y1BvbWthcjlEMTVOUlkrblJUaFJJMC9oaW5KaHpPWW9pRGhyTUJBcmhWRHJC?=
 =?utf-8?B?OGE0eEQyTmRGWFM3K2prQjZ1bjVyd0pOZHVocUwrVUpyVVNSQlIrYzhQbkkr?=
 =?utf-8?B?U0g5a2RQdWZmME56aFJNSXRKaFZrc1JnS1ZBRnl4OWFXbERFOFpSekxMM2dB?=
 =?utf-8?B?T3BmOHNmZlVNNlZKeEVnWFRqMXFuYXRGSG1nRkI0TFFaOHFDMUVFOVRQazBY?=
 =?utf-8?B?ZkRUZGR4S2gzMk5CV2k3MHM1bG1HVEszMGpPcjA4TDZWNnErNU5NTG9hMW1H?=
 =?utf-8?B?cGFpcys1RTZQVDRBT3ZYMUFNS0dMbFRtUStNUTJuZTIrUzkzTjZhZ3QzK1hE?=
 =?utf-8?B?VXhCa2JVbDN3bXg3eEl6RWxSUnIyUGhFM0VnWWFLVy9DR0l2dEphMG55MXBs?=
 =?utf-8?B?bG5SUTFxMVdNenZkb2NLNUx2dmN3U0ZURS9CK3k2aWlQY1ZIaUV2LzBaR0Uz?=
 =?utf-8?B?c2ovdnVOajhlR3UvYlJmdXhLTnpsTW9Za0FzZU1RQm9nRUVaSjFab3haVENX?=
 =?utf-8?B?WWV0WURxTFoyckV5bEpxRGFpMlFsQjJGMS9DWXk2OUswTnRXb2Jvc2JDWXJT?=
 =?utf-8?B?bXUyTWszRmZKSTkrNDlOZGVaYTJ3K0F1bFVQRXExSjFScFBwcTdxZHZlaE9w?=
 =?utf-8?B?UjFqNkNIZ2tqaXJXNHBaRkRIS2pMb2NGaTgwRXVCdlpWKzlZRDloSFAzOGtZ?=
 =?utf-8?B?VTBRbitaUTlmMU8yU1Ric1BBZENybldqeUFKN3JYTEFXOTBqOHcyaUEzWXVV?=
 =?utf-8?B?dW1RbFlQOEJ6SEFUTmE0NWk3L3dBYWFsaGdRUWIrLzhnU0lCZ2NNQ01PRWg3?=
 =?utf-8?B?UlBUK0xTQm1VdGExU1VkTjYxdmxNRFE1S044a29xM1ZjTUUwVEV5aTNidnNF?=
 =?utf-8?B?Mzc0c0xBU3FCZW1oUUNuWUdhNmlWVkF1bUZCWXdlNkpNZ0xDcGgyR1VxQk9G?=
 =?utf-8?B?VXEyM0xoRklZMUp0TXdvQ1daRmRCbnQ3RlNuYTY5K3VBbUZEUzNlY1g1eis1?=
 =?utf-8?B?QkJLTXFPaWVjZFZicjF0Sjc5dmg3YWdvbFpOYkRld2lKMitDdUlZVTlEVmpZ?=
 =?utf-8?B?RHM4VyszMkpoQnRxNWhLVWFoTWdITkdZdlJMOGFzMk9GMkpIcm5LcEhkMEc2?=
 =?utf-8?B?bjF6UHFTNVRUYmVablN6SnorUUVpOVYycjBqcTkzdmlOckROUlE0L2tLbGpI?=
 =?utf-8?B?ZGdFdUllekxQa3I1T0dHbkdIeVFoekFOR0JLWXFKYkdTTUl2RGQybXBPdUdM?=
 =?utf-8?B?RFZWTmJBS1gxc3hQM2J0WTJ5UEN0VjlKNWQrWFArR2J2TUNweEp5dnF5RFBk?=
 =?utf-8?B?RkFYdVFJcmpkNjNsUmRWVjFDVURFWmhWSnlJVldWZHMwQi93M0M2RFgwaU5Y?=
 =?utf-8?B?NThUeUZ2c1daZ00xZGNnNjVoUkFqUlQvK1c2NldwMG1EQm1wTFRxaGtwZHc1?=
 =?utf-8?B?VzZLRTBmSFAwUGdnb2VCdWh0K29WWWpWVVFNTWFiOTJRQ2wrT09OdzVncUJl?=
 =?utf-8?B?NmtrYms5VjQvZFBKOVNrN0FrQWVCeldublN1MU94MWpLKzJ6b2l6L1lVQ2ll?=
 =?utf-8?B?c2dtVVc0MEttNENWalNzY0JoWnhydGEvOWE5ZzhBTlUxNEEwcjNwdkQzZkRI?=
 =?utf-8?B?WkVacXI2WWZ2MGpPYkhhNVJXRXFSVjU3NVVGT3l1UjFQZDllVEdPTWNZMUtX?=
 =?utf-8?B?d2t1QURrdyt3c0k5THJwcEl6TkNIWS9QaE9FRDYrV0JXd3MwMFhxUGJPTVlu?=
 =?utf-8?B?TUhDbmVRNldoVXdUZWdhcU5YOFNPRkx5SzF3d09jMm85ZUpUalpQK2VNNFpK?=
 =?utf-8?B?b25LNm00bVRLVzZJbXVwQUJZVTV1dm9lTk1xVFdtWERLUXJZbjZwdnNqMUVJ?=
 =?utf-8?B?Mnc9PQ==?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1b59f7f-136a-4d76-01cd-08dabe3d646b
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2022 08:20:11.5238 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bEeJ4Hn2Zs4W8OtRVy5+Zrio3x8B7L8HaEBWzESlzmuJ6G9210hF41gCFiKTMu9JfLbdla1Pbhwu5a+yQTx2PKsRfDf3zloI/ibvR/oenSY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8685
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Correctly check setitimer params in setitimer01
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
Content-Type: multipart/mixed; boundary="===============1882216055=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1882216055==
Content-Type: multipart/alternative;
 boundary="------------x10Q3tDs46Va1obJYcFZmwMJ"
Content-Language: en-US

--------------x10Q3tDs46Va1obJYcFZmwMJ
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi!

On 11/4/22 07:48, Li Wang wrote:
> Hi Andrea,
>
> Andrea Cervesato via ltp <ltp@lists.linux.it> wrote:
>
>     Last test rewrite didn't consider the right expected boundaries when
>     setitimer syscall was tested. We also introduced counter times as
>     multiple of clock resolution, to avoid kernel rounding during
>     setitimer
>     counter increase.
>
>
> Good catch, but I'm afraid this can not solve the problem thoroughly.
> According failure log on "ITIMER_VIRTUAL/PROF" with running this patch.:
>
> setitimer01.c:64: TINFO: tc->which = ITIMER_VIRTUAL
> setitimer01.c:69: TPASS: sys_setitimer(tc->which, value, NULL) passed
> setitimer01.c:72: TPASS: sys_setitimer(tc->which, value, ovalue) passed
> setitimer01.c:76: TINFO: tv_sec=0, tv_usec=31000
> setitimer01.c:79: TFAIL: Ending counters are out of range
> setitimer01.c:88: TPASS: Child received signal: SIGVTALRM
>
> setitimer01.c:64: TINFO: tc->which = ITIMER_PROF
> setitimer01.c:69: TPASS: sys_setitimer(tc->which, value, NULL) passed
> setitimer01.c:72: TPASS: sys_setitimer(tc->which, value, ovalue) passed
> setitimer01.c:76: TINFO: tv_sec=0, tv_usec=31000
> setitimer01.c:79: TFAIL: Ending counters are out of range
> setitimer01.c:88: TPASS: Child received signal: SIGPROF
>
> It seems the tv_usec always increase 1000us, I highly suspect
> this increase comes from kernel function set_cpu_itimer() that
> explicitly add TICK_NSEC when 'nval' is larger than zero:
>
> $ cat kernel/time/itimer.c -n
>    ...
>    168 static void set_cpu_itimer(struct task_struct *tsk, unsigned 
> int clock_id,
>    169                 const struct itimerspec64 *const value,
>    170                 struct itimerspec64 *const ovalue)
>    171 {
>                    ...
>    182          if (oval || nval) {
>    183                  if (nval > 0)
>    184                          nval += TICK_NSEC;
>    185                  set_process_cpu_timer(tsk, clock_id, &nval, 
> &oval);
>    186          }
>    187          ...
>    198 }
>
Yes, you caught the reason why VIRTUAL/PROF tests are not passing. 
CLOCK_MONOTONIC_COARSE is probably used because setitimer takes in 
consideration context switch from kernel to user space while counting. 
To use CLOCK_MONOTONIC_COARSE for VIRTUAL/PROF is probably the way to go.

> To verify my guess, I do a modification based on your patch and
> then easily get the result in pass.
>
> --- a/testcases/kernel/syscalls/setitimer/setitimer01.c
> +++ b/testcases/kernel/syscalls/setitimer/setitimer01.c
> @@ -76,7 +76,7 @@ static void verify_setitimer(unsigned int i)
>                         ovalue->it_value.tv_sec,
>                         ovalue->it_value.tv_usec);
>
> -               if (ovalue->it_value.tv_sec != 0 || 
> ovalue->it_value.tv_usec > usec)
> +               if (ovalue->it_value.tv_sec != 0 || 
> ovalue->it_value.tv_usec - time_step > usec)
>                         tst_res(TFAIL, "Ending counters are out of 
> range");
>
>                 for (;;)
> @@ -98,8 +98,8 @@ static void setup(void)
>         SAFE_CLOCK_GETRES(CLOCK_MONOTONIC, &res);
>
>         time_step = res.tv_nsec / 1000;
> -       if (time_step < 10000)
> -               time_step = 10000;
> +       if (time_step < 1000)
> +               time_step = 1000;
>
>         tst_res(TINFO, "clock resolution: %luns, time step: %luus",
>                 res.tv_nsec,
>
> But after trying this with my RasberryPi4, it fails again with an increase
> 4000us each time. So it might related to the system use different time
> resolutions. When I shift to use `CLOCK_MONOTONIC_COARSE`
> then test gets passed on all my platforms.
>
> Any comments?
>
>
> ----------CLOCK_MONOTONIC-------------
> setitimer01.c:65: TINFO: tc->which = ITIMER_VIRTUAL
> setitimer01.c:70: TPASS: sys_setitimer(tc->which, value, NULL) passed
> setitimer01.c:73: TPASS: sys_setitimer(tc->which, value, ovalue) passed
> setitimer01.c:77: TINFO: tv_sec=0, tv_usec=7000
> setitimer01.c:80: TFAIL: Ending counters are out of range
>
> -----------CLOCK_MONOTONIC_COARSE-------
> setitimer01.c:65: TINFO: tc->which = ITIMER_VIRTUAL
> setitimer01.c:70: TPASS: sys_setitimer(tc->which, value, NULL) passed
> setitimer01.c:73: TPASS: sys_setitimer(tc->which, value, ovalue) passed
> setitimer01.c:77: TINFO: tv_sec=0, tv_usec=16000
> setitimer01.c:89: TPASS: Child received signal: SIGVTALRM
>
> # lscpu
> Architecture:        aarch64
> Byte Order:          Little Endian
> CPU(s):              4
> On-line CPU(s) list: 0-3
> Thread(s) per core:  1
> Core(s) per cluster: 4
> Socket(s):           -
> Cluster(s):          1
> Vendor ID:           ARM
> Model:               3
> Model name:          Cortex-A72
> Stepping:            r0p3
> CPU max MHz:         1500.0000
> CPU min MHz:         600.0000
> BogoMIPS:            108.00
> Flags:               fp asimd evtstrm crc32 cpuid
>
> -- 
> Regards,
> Li Wang

Andrea

--------------x10Q3tDs46Va1obJYcFZmwMJ
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">Hi!</div>
    <div class="moz-cite-prefix"><br>
    </div>
    <div class="moz-cite-prefix">On 11/4/22 07:48, Li Wang wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:CAEemH2ePDmJf-Mq=gk8MX+J7tP-qkGrvqxRL-Ri_k8QjZd842g@mail.gmail.com">
      
      <div dir="ltr">
        <div dir="ltr">
          <div class="gmail_default" style="font-size:small">Hi&nbsp;Andrea,</div>
        </div>
        <br>
        <div class="gmail_quote">
          <div dir="ltr" class="gmail_attr">Andrea Cervesato via ltp
            &lt;<a href="mailto:ltp@lists.linux.it" target="_blank" moz-do-not-send="true" class="moz-txt-link-freetext">ltp@lists.linux.it</a>&gt;
            wrote:<br>
          </div>
          <div dir="ltr" class="gmail_attr"><br>
          </div>
          <blockquote class="gmail_quote" style="margin:0px 0px 0px
            0.8ex;border-left:1px solid
            rgb(204,204,204);padding-left:1ex">Last test rewrite didn't
            consider the right expected boundaries when<br>
            setitimer syscall was tested. We also introduced counter
            times as<br>
            multiple of clock resolution, to avoid kernel rounding
            during setitimer<br>
            counter increase.<br>
          </blockquote>
          <div><br>
          </div>
          <div>
            <div class="gmail_default" style="font-size:small">Good
              catch, but I'm afraid this can not solve the problem
              thoroughly.</div>
            <div class="gmail_default" style="font-size:small">According
              failure log on &quot;ITIMER_VIRTUAL/PROF&quot; with running this
              patch.:</div>
            <div class="gmail_default" style="font-size:small"><br>
            </div>
            <div class="gmail_default" style="font-size:small">setitimer01.c:64:
              TINFO: tc-&gt;which = ITIMER_VIRTUAL<br>
              setitimer01.c:69: TPASS: sys_setitimer(tc-&gt;which,
              value, NULL) passed<br>
              setitimer01.c:72: TPASS: sys_setitimer(tc-&gt;which,
              value, ovalue) passed<br>
              setitimer01.c:76: TINFO: tv_sec=0, tv_usec=31000<br>
              setitimer01.c:79: TFAIL: Ending counters are out of range</div>
            <div class="gmail_default" style="font-size:small">setitimer01.c:88:
              TPASS: Child received signal: SIGVTALRM</div>
            <div class="gmail_default" style="font-size:small"><br>
              setitimer01.c:64: TINFO: tc-&gt;which = ITIMER_PROF<br>
              setitimer01.c:69: TPASS: sys_setitimer(tc-&gt;which,
              value, NULL) passed<br>
              setitimer01.c:72: TPASS: sys_setitimer(tc-&gt;which,
              value, ovalue) passed<br>
              setitimer01.c:76: TINFO: tv_sec=0, tv_usec=31000<br>
              setitimer01.c:79: TFAIL: Ending counters are out of range</div>
            <div class="gmail_default" style="font-size:small">setitimer01.c:88:
              TPASS: Child received signal: SIGPROF<br>
            </div>
            <div class="gmail_default" style="font-size:small"><br>
            </div>
            <div class="gmail_default" style="font-size:small">It seems
              the tv_usec always increase 1000us, I highly suspect</div>
            <div class="gmail_default" style="font-size:small">this
              increase comes from kernel function set_cpu_itimer() that</div>
            <div class="gmail_default" style="font-size:small">explicitly
              add TICK_NSEC when 'nval' is larger than zero:</div>
            <br>
          </div>
          <div>
            <div class="gmail_default" style="font-size:small">$ cat
              kernel/time/itimer.c -n</div>
            <div class="gmail_default" style="font-size:small">&nbsp; &nbsp;...</div>
            <div class="gmail_default" style="font-size:small">&nbsp; &nbsp;168
              static void set_cpu_itimer(struct task_struct *tsk,
              unsigned int clock_id,<br>
              &nbsp; &nbsp;169&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;const struct itimerspec64 *const
              value,<br>
              &nbsp; &nbsp;170&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;struct itimerspec64 *const ovalue)<br>
              &nbsp; &nbsp;171 {<br>
              &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;...<br>
              &nbsp; &nbsp;182&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if (oval || nval) {<br>
              &nbsp; &nbsp;183&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if (nval &gt; 0)<br>
              &nbsp; &nbsp;184&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;nval += TICK_NSEC;<br>
              &nbsp; &nbsp;185&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; set_process_cpu_timer(tsk,
              clock_id, &amp;nval, &amp;oval);<br>
              &nbsp; &nbsp;186&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; }<br>
              &nbsp; &nbsp;187&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ...<br>
              &nbsp; &nbsp;198 }<br>
            </div>
            <div class="gmail_default" style="font-size:small"><br>
            </div>
          </div>
        </div>
      </div>
    </blockquote>
    <p>Yes, you caught the reason why VIRTUAL/PROF tests are not
      passing. CLOCK_MONOTONIC_COARSE is probably used because setitimer
      takes in consideration context switch from kernel to user space
      while counting. To use CLOCK_MONOTONIC_COARSE for VIRTUAL/PROF is
      probably the way to go.<br>
    </p>
    <blockquote type="cite" cite="mid:CAEemH2ePDmJf-Mq=gk8MX+J7tP-qkGrvqxRL-Ri_k8QjZd842g@mail.gmail.com">
      <div dir="ltr">
        <div class="gmail_quote">
          <div class="gmail_default" style="font-size:small">To verify
            my guess, I do a modification based on your patch and</div>
          <div class="gmail_default" style="font-size:small">then easily
            get the result in pass.</div>
          <div class="gmail_default" style="font-size:small"><br>
          </div>
          <div class="gmail_default" style="font-size:small">---
            a/testcases/kernel/syscalls/setitimer/setitimer01.c<br>
            +++ b/testcases/kernel/syscalls/setitimer/setitimer01.c<br>
            @@ -76,7 +76,7 @@ static void verify_setitimer(unsigned int
            i)<br>
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ovalue-&gt;it_value.tv_sec,<br>
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ovalue-&gt;it_value.tv_usec);<br>
            &nbsp;<br>
            - &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if (ovalue-&gt;it_value.tv_sec != 0 ||
            ovalue-&gt;it_value.tv_usec &gt; usec)<br>
            + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if (ovalue-&gt;it_value.tv_sec != 0 ||
            ovalue-&gt;it_value.tv_usec - time_step &gt; usec)<br>
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; tst_res(TFAIL, &quot;Ending counters are
            out of range&quot;);<br>
            &nbsp;<br>
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; for (;;)<br>
            @@ -98,8 +98,8 @@ static void setup(void)<br>
            &nbsp; &nbsp; &nbsp; &nbsp; SAFE_CLOCK_GETRES(CLOCK_MONOTONIC, &amp;res);<br>
            &nbsp;<br>
            &nbsp; &nbsp; &nbsp; &nbsp; time_step = res.tv_nsec / 1000;<br>
            - &nbsp; &nbsp; &nbsp; if (time_step &lt; 10000)<br>
            - &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; time_step = 10000;<br>
            + &nbsp; &nbsp; &nbsp; if (time_step &lt; 1000)<br>
            + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; time_step = 1000;<br>
            &nbsp;<br>
            &nbsp; &nbsp; &nbsp; &nbsp; tst_res(TINFO, &quot;clock resolution: %luns, time step:
            %luus&quot;,<br>
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; res.tv_nsec,<br>
          </div>
          <div>&nbsp;</div>
        </div>
        <div><br>
        </div>
        <div>
          <div class="gmail_default" style="font-size:small">But after
            trying this with my RasberryPi4, it fails again with an
            increase</div>
          <div class="gmail_default" style="font-size:small">4000us each
            time. So it might related to the system use different&nbsp;time</div>
          <div class="gmail_default" style="font-size:small">resolutions.
            When I shift to use `CLOCK_MONOTONIC_COARSE`</div>
        </div>
        <div class="gmail_default" style="font-size:small">then test
          gets passed on all my platforms.</div>
        <div class="gmail_default" style="font-size:small"><br>
        </div>
        <div class="gmail_default" style="font-size:small">Any comments?</div>
        <div class="gmail_default" style="font-size:small"><br>
        </div>
        <div><br>
        </div>
        <div>
          <div class="gmail_default" style="font-size:small">----------CLOCK_MONOTONIC-------------</div>
        </div>
        <div>
          <div class="gmail_default" style="font-size:small">setitimer01.c:65:
            TINFO: tc-&gt;which = ITIMER_VIRTUAL<br>
            setitimer01.c:70: TPASS: sys_setitimer(tc-&gt;which, value,
            NULL) passed<br>
            setitimer01.c:73: TPASS: sys_setitimer(tc-&gt;which, value,
            ovalue) passed<br>
            setitimer01.c:77: TINFO: tv_sec=0, tv_usec=7000<br>
            setitimer01.c:80: TFAIL: Ending counters are out of range</div>
          <br>
          <div class="gmail_default" style="font-size:small">-----------CLOCK_MONOTONIC_COARSE-------</div>
        </div>
        <div>
          <div class="gmail_default" style="font-size:small">setitimer01.c:65:
            TINFO: tc-&gt;which = ITIMER_VIRTUAL<br>
            setitimer01.c:70: TPASS: sys_setitimer(tc-&gt;which, value,
            NULL) passed<br>
            setitimer01.c:73: TPASS: sys_setitimer(tc-&gt;which, value,
            ovalue) passed<br>
            setitimer01.c:77: TINFO: tv_sec=0, tv_usec=16000<br>
            setitimer01.c:89: TPASS: Child received signal: SIGVTALRM<br>
          </div>
          <div class="gmail_default" style="font-size:small"><br>
          </div>
          <div class="gmail_default" style="font-size:small"># lscpu <br>
            Architecture: &nbsp; &nbsp; &nbsp; &nbsp;aarch64<br>
            Byte Order: &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Little Endian<br>
            CPU(s): &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;4<br>
            On-line CPU(s) list: 0-3<br>
            Thread(s) per core: &nbsp;1<br>
            Core(s) per cluster: 4<br>
            Socket(s): &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; -<br>
            Cluster(s): &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;1<br>
            Vendor ID: &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ARM<br>
            Model: &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 3<br>
            Model name: &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Cortex-A72<br>
            Stepping: &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;r0p3<br>
            CPU max MHz: &nbsp; &nbsp; &nbsp; &nbsp; 1500.0000<br>
            CPU min MHz: &nbsp; &nbsp; &nbsp; &nbsp; 600.0000<br>
            BogoMIPS: &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;108.00<br>
            Flags: &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; fp asimd evtstrm crc32 cpuid<br>
          </div>
          <br>
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

--------------x10Q3tDs46Va1obJYcFZmwMJ--

--===============1882216055==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1882216055==--
