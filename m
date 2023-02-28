Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 483B8C64EC7
	for <ltp@archiver.kernel.org>; Tue, 28 Feb 2023 09:08:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 59AF93CBB80
	for <ltp@archiver.kernel.org>; Tue, 28 Feb 2023 10:08:50 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2819A3C01AA
 for <ltp@lists.linux.it>; Tue, 28 Feb 2023 10:08:39 +0100 (CET)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on0618.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1f::618])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 5570A10000F6
 for <ltp@lists.linux.it>; Tue, 28 Feb 2023 10:08:38 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RMpnYkaemkOeGXzYfb7DuNMEq4NpIQahmWRmlQEWSfwSqInMDCpeJDpSxTZnM5S6w7v47rR2pwUbviztc3VJg/mCHU3lgAxBSuJGmu7DRQoCUT1FK9PBzI5qNeEEuW6J7gOSzbI115tG9B6Pqan06VqQ9CfZQu2s6+NoVJzaJd2GhIMudmpt/wBPIWmm/iLhW44lfjtT6ATQoktP+4tG+weKP6WRdkHsq28neHPEmlF/Nec6V1jvCTeJF4IL/2ccP4hDhiq7sQu9WfBmd3bpQuD+EpJvlvFZID94QvMdnr0ljMrqP7IPT+5xv7HJtnTqDIj8gYn8gSHAj+wuA1y8AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VF8bkHHWmzQsy0mVw/ffrgMJlX2VUEgGV6Hz4UnEVhg=;
 b=RL9D0xlVzeuaUD0YU1SD6CvAJ1Pr4RfDGC37guzaJ49qGDYjwwRyccY44rjix0wBQUaH0yX69XWoOeYuV+5Epe1QDSePZzHBXv6f4tLm5xSaOA/6aWBOWX7HdACmjgC/S1aTLVQ1oOeqeQ+opjfIawhqLaU3n9Guf4M79DRdR21x2LAAMC1oC2Brg94GW2GANJPRcm3zpFTdU0cSgD7blAlvVqc7Sbrw+RaLOfG0maDUSvginWdiyK88RrHNBvt4D+f0CkkOMUNW+GCtSr8igNv/4+Aivm+GbS0hqNLR9FRBShVIm875yLVQ+AIehaW7OMycUdPKiuYwkLj6iAuPNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VF8bkHHWmzQsy0mVw/ffrgMJlX2VUEgGV6Hz4UnEVhg=;
 b=cxWlE5YH2Lh5x0+lnXjoG3L/uUMD6tqDW6r8Gwd+wWSDrnTILWz4IsusXa8iKVl+j9gtFSmeVdurUeI1yxAcUSP+SqM+cvANeZanfY/rf51d3g1l6rXf1JXam3Btjamf5njYLrYkVu90F38/oUJAIrFyleLC2tIZSHe9l2y2JbWuR0jW87ndRxgdv78HpmvZ+bgauQ9wZ1qCvmsMIgbEvjVYt+b8zlrr0gQ30huI2CLOxGJrnBvdOzE+nDhk0Z9+oB0tNxRzflhZ3LE1Qqc+73Mqti5Ruo2YyUxZU5JAfX8VJmmlnJBnY6FZEouc5yByRppjhSOswG8eY1dxNKSnGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by DBBPR04MB7755.eurprd04.prod.outlook.com (2603:10a6:10:1e7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Tue, 28 Feb
 2023 09:08:37 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::e6db:281a:b03d:39ca]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::e6db:281a:b03d:39ca%3]) with mapi id 15.20.6134.030; Tue, 28 Feb 2023
 09:08:36 +0000
Message-ID: <13c9ecd8-48d7-dccc-a3b7-ec934e2f1369@suse.com>
Date: Tue, 28 Feb 2023 10:06:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
To: ltp@lists.linux.it
References: <1677573864-5319-1-git-send-email-xuyang2018.jy@fujitsu.com>
Content-Language: en-US
In-Reply-To: <1677573864-5319-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-ClientProxiedBy: FR3P281CA0203.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::11) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB6797:EE_|DBBPR04MB7755:EE_
X-MS-Office365-Filtering-Correlation-Id: d0c963f4-b0ed-4737-214c-08db196b5ffb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fwSBMHL9erifxu+CL4qwB4efNOcv1K9gCNsR+3Yn4T/52fhAgZE0rfzFjVZf0q6kFwSZKTWGBXXQ9arFaKzqt1TN81+fXEPaUMVOPKIxJViGFCuJVMNJnJQ6N3ebnfDZkjRpsto759EmDzfK1S945YHtWcTnWNImp7Qode/udn28Pce9u8ky3/YBmZ7h8egoKqcrtrBetcbxuQpZsv5JiRjbmbBF4B0mNuiwddVr0tLLXVj+n7U9TWwJOedDwzIkiObtiO5v9M6WutyutSXJdXf9hYpVCE6Qfpc6T7bCSpml1n6H+p32C1VGsUBj8ZvxaVXpsldyd7Sl+sTFVlA9GlyoLghx23bVmkChuzYXYv7hyR4kHQfwnAxKgV0fFOo4csD4KzbyZ/FkFWDlDbUVNXGOsFs90fq9t/xlRtGeHQLoP8QbDZ+tHBzX6C8ifTml/eHNstajkaG7xjGm2M04YY2fVISDTMUw+0sjYtyNHoIdA00AkyxsbWRcXG0NZc1vqXVOq9plSs9K0rFcuHg9+aLqRRDkzgXV+jBvvK5aVGtGIU4mktFqkfSQAJNBpB3MiP1lEEUK44ZKkuAQTxhzF1BU0+lTVIGKAqTpquZ1JPQ+oWyF4r7HqWdkEHXf4H7k1ilM91YydZkBjmzv4LK31qaKiI5SjnQFz+aX7QdTRh5i4WrwLzv7hjhlCI9eELp4DD+jTpqEOpt42LGeMyvya5S+DyXHguPgXiG+GZYy3Bw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(136003)(346002)(376002)(396003)(366004)(39860400002)(451199018)(31686004)(83380400001)(316002)(36756003)(6916009)(8676002)(38100700002)(6512007)(478600001)(2616005)(186003)(26005)(6666004)(2906002)(6506007)(53546011)(6486002)(5660300002)(66476007)(31696002)(66946007)(66556008)(44832011)(8936002)(86362001)(41300700001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cXpBVmxsU2NNdjI5dU5oV283OUppNkpNa2w2dGpZbkJ5RE5acTZIRmIwWlVM?=
 =?utf-8?B?SldxalZsbTRPYU1WOTJpRnZmdk1VcUdOL1pnaVptNGM1SnUxS2FPNUh4enpH?=
 =?utf-8?B?cHZMU0o5RVlUalVQN2drTVNTek53NVRoM1pVeVBRZUczeis4czRJN3YydlN4?=
 =?utf-8?B?VWplWWI5S09kZkxYeTVlZ3YwZldsSk5LVXRDUUdTamJVSitmK2tXUi9PdFM4?=
 =?utf-8?B?YzhDK0xyOWdtN1Fpb0tqbWZtYzFrYWdTZU1XOE02RFl0NHNicTRjZFVBekcy?=
 =?utf-8?B?UFBraXlOd1RxWGNGUmswMXQ3VFA5NlpRWDVHSmpuRWQ5L0twOTZ4UTBmbGk5?=
 =?utf-8?B?cVBVRGh4OHgxc2dwMnFnS1VLR3FyK2RGNXZnR2I5dkE5Z0VldE9UdHBPbDF6?=
 =?utf-8?B?VnI1c2JoODJHRy91SUVxdExpSEFsNlFYSmc5L3I4R1hsbE4vVTBQSjZWQ3Uz?=
 =?utf-8?B?WWh1ZXFNaklwOUNEbkRSNTRNck1NSFgzdU81OU9GRGpEUzhIUEtaRjA3Ym50?=
 =?utf-8?B?SEJCcXdiZkN6ZWdEdHhaV284TXU2ZkVaYXhUUk8zVDRLczROSldPYXh0NXk4?=
 =?utf-8?B?NWhENU9NcGF3MG5XWGR0N3pwSnB0NnJlMUFoclJyWkRGQy9nTmZBcmFVZHRT?=
 =?utf-8?B?SWZHSkp6MDk2UzJtTS9DYkJ3aEl0RnZZbXRJSEtTcTdqWkUvdDlvekZYKytt?=
 =?utf-8?B?UEF0YmFBKzZnOXlkWUtiK29NK3I1VFk2RWhTUE94OGNYK3V6TTM0bkV6N0Rn?=
 =?utf-8?B?V3JZbmtSbXBOUGpxM0V4Z3UvRGI0RnJ3YzlvT1VtUW8ycTc3T3cvT3NXMHB5?=
 =?utf-8?B?cnJ1aVdtbTFSWFZSdnl5MjA5bTF6WE1FN0ZkalhBajAzRVhjK3pWVzNLYjJU?=
 =?utf-8?B?RlRSUTQzYUViYTdDOS90YkhvZHU1R1JNZ25vanVwbGZWQXp6azZmTnhtYmJ5?=
 =?utf-8?B?eXNVbG5aWFBlTFgwN05XK3k4bnUwQkR3UlFubW9GSEM5MTNUNG1nblVpY1R6?=
 =?utf-8?B?WTVzOUx0L3NwV252V0lMaFQ0a0tHbk5RQjM5ckxtYmx3SzYxWm1GVnFGSm0r?=
 =?utf-8?B?eWE2QStoWXQvZHdvWW9aODNXWmRpcVdkb2liRjlxUjEwSnRJREJoNG1qKzRT?=
 =?utf-8?B?d1NPNFhTWHlMbUV3ZmxFbFFycHkwQ0Y5SUZmQUFpUk1mdDU4ai9qYy9JYjdL?=
 =?utf-8?B?Wnl5VE90OTRKVHdEcTVRSHorbCthM2pEeVZ6WnNpVEdPTVVmdjlrRWxBWG01?=
 =?utf-8?B?UVRiTTBFZVpGbnJrZU9PdU1uRXVHVzJOeXB2Z0xod2lNTlF2RFloWEVVazla?=
 =?utf-8?B?eDZweUZTSytVU1dhTm9iQkxVN2ExQ1Zid2FLbGI5bGN2REhFSFZFS2hiTXdE?=
 =?utf-8?B?RE1ERkdNR1ZnMTByNndyN3pBWVpRdzlnZ292emtpZDlKSm5WS3hydWFPd1hO?=
 =?utf-8?B?anliNTJ4eWJjNXBYcXV4M1p2TVpyT2FWTUNqU1V3Y3M4YXlLczFSKzB1RnpT?=
 =?utf-8?B?SXJIMFExR2pEYkd5WlVZZG91V3NQMFlHN3N2TnJrSGNVRU91dWhzUDY1bnlO?=
 =?utf-8?B?TnM5K0U0L20zYlptUEkvNnU1VWRQTkpGMXFnM3BXSDdEcUF0L1RqaklFNm5M?=
 =?utf-8?B?SHp6ck11ek5PT0xmbStMQjR6c1h0eVVXMGlFdm5vNkdwQkVBVEJLOENVMUtD?=
 =?utf-8?B?Q1k5T3pRQUJEZHFEQkp3Uy9WN0xWb3Y5NlcrNUJWYkNjT0VOMmY5MVdWMTRm?=
 =?utf-8?B?aWp3U0U1R1U1L1JJVmpvTEtzeVViai9QSm1VK0xXdm9zZ0hYK05oM1JHYWh4?=
 =?utf-8?B?Qm5aVXdJWjdDSlJ6RTBPK1FLTHphd0JCbDVPUVc1b2JLcUhyUXRJVXJqRExq?=
 =?utf-8?B?WnI4ZENTTWxuc3FlalNxNUVLdTE5aFljWFUyM1FMUlkxZDA0MFpDdTZlb3R1?=
 =?utf-8?B?QjRmcGtQNlpOQ3ZUN2tGRksrMmtqN2RHSVZ4RUxEeUZSUk9hYS9rUElzQ3d1?=
 =?utf-8?B?ZUZTSDlmSFB2T2wwUUNhV28zYnV2WCtzZXlJemYrZ0MxNzNJNERJbjFQcTVl?=
 =?utf-8?B?ZXh1c0xZcFBwdjJsVEViMDhydU5rdjA2QmV0NWhYUzl3dXVOcGpyblpRdjlv?=
 =?utf-8?B?Y3NyL25QSnRHMjFFZkI1NVZ1dDdDOUZpY05kYUZRcHVGUnBWS1FoMGZER3c3?=
 =?utf-8?B?RUE9PQ==?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0c963f4-b0ed-4737-214c-08db196b5ffb
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2023 09:08:36.7109 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JYKx4xOK+QHHVhBGv432yscRd8UsGx3WTIp971lPW6POgJikCAKBOT4gjbNGaeFnCntxHy5QY21xI8v2uWe98QigM4cTuBVXWoKndqwDePI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7755
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] containers/utsname04: don't use TST_EXP_EQ_LI for
 tst_clone
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

On 2/28/23 09:44, Yang Xu wrote:

> For old kernel that doesn't support clone3, tst_clone returns
it would be nice to add unsupported kernel version inside patch comment 
(in this case, anything below 5.3).
> -2 instead of -1. So we can't use TST_EXP_EQ_LI api.
>
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
>   testcases/kernel/containers/utsname/utsname04.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/testcases/kernel/containers/utsname/utsname04.c b/testcases/kernel/containers/utsname/utsname04.c
> index e8d636d0d..1adc4542c 100644
> --- a/testcases/kernel/containers/utsname/utsname04.c
> +++ b/testcases/kernel/containers/utsname/utsname04.c
> @@ -22,6 +22,7 @@ static void run(void)
>   {
>   	const struct tst_clone_args cargs = { CLONE_NEWUTS, SIGCHLD };
>   	struct passwd *pw;
> +	pid_t pid;
>   
>   	tst_res(TINFO, "Dropping root privileges");
>   
> @@ -29,7 +30,11 @@ static void run(void)
>   	SAFE_SETRESUID(pw->pw_uid, pw->pw_uid, pw->pw_uid);
>   
>   	if (!str_op || !strcmp(str_op, "clone")) {
> -		TST_EXP_EQ_LI(tst_clone(&cargs), -1);

Did you try this?

TST_EXP_FAIL(tst_clone(&cargs), EPERM);

> +		pid = tst_clone(&cargs);
> +		if (pid == -1 || pid == -2)
> +			tst_res(TPASS, "clone() returns an expected value %d", pid);
> +		else
> +			tst_res(TFAIL, "clone() returns an unexpected value %d", pid);
>   		TST_EXP_PASS(errno == EPERM);
>   	} else {
>   		if (!SAFE_FORK()) {

Regards,
Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
