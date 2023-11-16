Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6B91C54FB9
	for <ltp@archiver.kernel.org>; Thu, 16 Nov 2023 15:13:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 17EF33CE3D3
	for <ltp@archiver.kernel.org>; Thu, 16 Nov 2023 16:13:55 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B42B93CC1C9
 for <ltp@lists.linux.it>; Thu, 16 Nov 2023 16:13:43 +0100 (CET)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on0631.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1f::631])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 8E070603A21
 for <ltp@lists.linux.it>; Thu, 16 Nov 2023 16:13:42 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ncRMc3jmS4deAnMqMB4zcNnJdRNkn3M5UPjHFEMpyhKpA0oTPrs61itj/vNTEpgg7ETeWE7uF9gd/K69+DRN9L8uHtpM/91AmMtseThyuxpeJCKV6PtlT6gbkbJHB/rh/jWNC4yqvugZ8C8Yx3bchhJapUuGDK6FW1J1t3TYIFndSH/OVqo+qvJqCVt/3hcaYVGTUgPiEtjtyubr9aVbVryhOu3jpgG4AxQrz0C92O42soobnfzAQmMucR5CxumkMk1HYQ4ooM/G26e+K4p6tG0+nZQuvrzjyogpjeSi43/sS3Ve3dRB7Q8QYexwDpp98MlLcPnt191ev4gn/X8odA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G/WKYoo80wvMrfcxGggQV1unj1ZXcwdxKUsTBAqiHQM=;
 b=Pc0obzDU41AqUYu6+kK3iGGgukKxGkUyGhhWEOxZFSqYUtBX4tvmrBQAdCLauXfnTNT48VamSn4M7Lpn6whG8vcbOkdVZ9VtFSDf1p8ANcoYSTD7wh4nGgG+J7u6ICtnPZu9QbeIJ6DEOjqR0MiQ7n4NxdGJjNGiWS+X6M0lqjTo2IheD8FbRFbGC3enUUNlLN3E9dKCsYAlwON1XZRkDKasdvmpOOMZu90k71SQlCwwJPb/4iVQly4pgW8MYe/OtHkqGIVRSDuhP+rYhB9fct2b1cP/4Lv4fJ/BXyVeIpGi02/tNM2Z1BO2ifJpl3eLGO87E1eNU++wsRjIKIdynA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G/WKYoo80wvMrfcxGggQV1unj1ZXcwdxKUsTBAqiHQM=;
 b=s8X7wE6y8J5Hvuf1pzhh7bJnHX0MpmfyLWojSeiIjuGnhxpah36lxDm8LyocG/R9KbQXTNNEWeXuTrqW58pM78A0+Yp/3nA8d/nni+SgUQMUaMjK/PXtkUAnSw+287aNcMkn+ktreFHzfKo1IvKtTWl1gUHyqpWZzgmq9omoBw1CyCffXgxn3+E8m5otQrplhi+qx3C+FfQzpMMEm+LDtc4i3KbyIEEP/YWXLpaMg7kXevRHeHdt7nZU83FrYiXIHYuUn4FZV2Z2a30dI4kJF/MQs1CF0mL7p42MSbi6hlPh+3ZLEZJEQdAo0aPO7D8zeX+PiO56hOcQtqABkeDesg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by VI1PR04MB6880.eurprd04.prod.outlook.com (2603:10a6:803:130::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.8; Thu, 16 Nov
 2023 15:13:40 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::37d3:a796:d252:be6c]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::37d3:a796:d252:be6c%4]) with mapi id 15.20.7002.012; Thu, 16 Nov 2023
 15:13:40 +0000
Message-ID: <0c0b9734-c74d-4d1b-ad80-a0962314cfbf@suse.com>
Date: Thu, 16 Nov 2023 16:13:38 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Cyril Hrubis <chrubis@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20230904111940.26824-1-andrea.cervesato@suse.de>
 <ZT-19kgC8PqKMlb8@yuki>
In-Reply-To: <ZT-19kgC8PqKMlb8@yuki>
X-ClientProxiedBy: FR4P281CA0208.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::20) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB6797:EE_|VI1PR04MB6880:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e06f54c-a1db-46f7-a70c-08dbe6b69d36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JB96OhLpvpgd+F9wNXVzpNop1EHDu+xe0cfHOqbSF9JNBJMjwn47Rp1gCSEN+EyNhJlGEQGoPa4mPI4MPgrZ/7vZXcic9m93ZlnqLgHY9lb7+tqAnhfhov4fYETl/FRZ6XgPE4le8WrttS9zzxpfwTD26SEJKhv3zDuJrK3VAuYt76T7YS7gOgtWBXc3SiiI+v1HdRuhuAI1LG3BXRdAxtBTFI8IDYvLa8OW9d6JpVf7QO+eKniCJRMj7IuAHel797oGS2e8XJMIYS0L0N+ANX26vIfatAUgqWR+jTfSiMAjhGLTxJeSPyn5n3bucMq0zmvBzO8uvJ36UMDVps6QuHGFrZx6VanDnrmmWQ7zC3T3h67WZp/vFirJCp/nFBAtNZcXvqP4PmUBPn1YPR25HfAZhwrzBRGEvnPQPBHjemTFUshtsMzAQ4a1vfdJv2w64N5gL4uf8D594FPEwNR2cURoFqJ1dG94bHn7Z0cK4HqPC3zKY3iPtl7b/ereLFYwBZbVeCYPyQ35Q67bf16sLu0z/eQ0uu+NoXzHIR6e/k8A2o/dIGeWa90KyeHAKhY60JUJ2h5uhjOkD4XPMKpfM+9+RcG6qj1H5nZiS121fSZC6Op9sBqsEM6yG/v6vBTBLjwcN0Sy8AqQ0nEAfwfjHg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(39860400002)(396003)(346002)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(31696002)(86362001)(38100700002)(36756003)(2906002)(2616005)(478600001)(26005)(53546011)(6486002)(6506007)(44832011)(6512007)(8936002)(41300700001)(4326008)(31686004)(66946007)(66556008)(66476007)(316002)(110136005)(8676002)(5660300002)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmRvZGJNRVlzTm85NitBTisxZlVmZjhObUFWeFhCSXA0SFdFc0l5dGNuNHFG?=
 =?utf-8?B?ZlArY2JtTzVoS0FRVXhIY1dLOTRlTG1lTUVsMXBDcm91ckFwMEhLeG5JaC9P?=
 =?utf-8?B?R0laTXc1cWoxWmIyWHpoS3lmMmEvMkd4VCtrUnJBK2doYWFVNVJKaHZQK2VK?=
 =?utf-8?B?ZmFUMmdkbEZCYnpJcmNVZ1F5SjJxQzVqdXBkOHI2M0YzSWFhMEgrU2xVRE8r?=
 =?utf-8?B?eWNpaGpvTEVrNmJ6ODZ4NFdSNlVlR1hYRE1VOGVMd0dVR3Z1S0Z4SkJqVVpi?=
 =?utf-8?B?em1jZ2taMlFtUklueERtWm5Rb0h3ZFh4L3pPM3h0NVF3VXc3cjJjQkd3T3hH?=
 =?utf-8?B?KzNueUtkTFBBNlZpdHlSaEVjN015aFRIY09haG16UWxxaVIwWG1aUUl0VjM0?=
 =?utf-8?B?dmZYcmRPTVRNQVhwTUNna1o0UTRpZitTdEpLN1E3QUxZUHF3QzdldGk0NGhy?=
 =?utf-8?B?N0lsQnN3VzV2KzdpcjVlV1hsSkk2M1JEcTVpcG1rb3kzV1BCalZ2S0hLTTY4?=
 =?utf-8?B?QUc3WUFlZkRreGZBZmliT1Yva2pCR1ZEV0FMUzlva1Uzd3EreXdlMDBRQjNl?=
 =?utf-8?B?QkFpb1phdS9NbkJ1MW5pKzVwQWtjbWpsL3ZZeURncHVBWG01ZExvdDhrK1l6?=
 =?utf-8?B?Vm9LNHJDMndtZFVibEJ0TnFqeU05ZldNQVVYcWZVSGxIZTdTUDl5TjdHWVZG?=
 =?utf-8?B?VkVFbkh2azFoK0ZSRXdOVzJUMjQvZk1DS1R4Z3p1azh6bnlQbCsxZ1ViZUpy?=
 =?utf-8?B?bWp2ZE8wdVlrYjdSblVjY1lMMVNzZERXajNSUjd1UDVVU0RJU29ybjJLdS96?=
 =?utf-8?B?K0NEM09HR1dRZWtxdGc1VU1vR2Y4bTNQQ244MGdtL2E2dC9hNE9kbmxLWlly?=
 =?utf-8?B?UE9YaTV2Z0h0eFBjNFB1VEZXMFN5Z0luVlU0V0JSZnVheUFja3BwdmlyNDhQ?=
 =?utf-8?B?c3M0cnh0c01rNXRheENFQktvT0I4aGxoWUQwdHR1RWdGWHRrL1NWSmlmS0x2?=
 =?utf-8?B?RDlDRzZMU2pCQVQ4ekhFOVY3OVJROG1DTDlZei9WZ0w1VTdkQS9rSzlTa21C?=
 =?utf-8?B?di9aenFZNU5uSDdQcGUzM0EvOU5nWG9PNUx6bjAvU0FtaDdSdS9LM0ozbHBl?=
 =?utf-8?B?MnZpKy8yQWdpdzdiSnQ3cjk4R1ExT3UxS1cwU2NkZGxZR3ZJcHkwejNYUitB?=
 =?utf-8?B?cXV2NE5UWGdUc2hYTVNmNnl5aG9aS21ucnJEa0puOTBFTlZySEtodnpjNy9J?=
 =?utf-8?B?T1F5UlpyWHBTS0J4ekNQeGZYMFlWSlMxdnRSMTk2QXZ5ekZSYjRJSTg3Y2dx?=
 =?utf-8?B?cXhkMy9kVlJLdDIzWUJuV3ZlUGNpL3FqU0VoSTA0V3pWSjFVc2xYWHkwUmQv?=
 =?utf-8?B?dWhHSlB2cVdnMkZZWFFTTmk5ckUweDJyUFVISzVCcEc5WVVtd3BuTlhvUHQ3?=
 =?utf-8?B?dWJ5NDdTU3QwZjNlOUdYVUQwdktpOS9JakpNZG5rTm5VeURYMTBHTXZDSS9t?=
 =?utf-8?B?WjdSMFYrdEo0Z2h0M00zUEpLN2ZLc2llK20zQ1JUQjhNSGNmMSs1YWxFbGoy?=
 =?utf-8?B?Z1kvUS8vRDg4SXkrWHpnRTF0OVYyUU5jOSs4Z0Zoc3JSWU5QRkpoSDc3YlVK?=
 =?utf-8?B?L21nZjNuY1NhaWR1SDhNYys5eXpzb1c2V3QyUXBocVR4RExDZEVjN2ZtZi9t?=
 =?utf-8?B?Y2JwNWJNRkxJTDBNUDlVcXZaNFpVNUR2Q1F0TnJWbi9FKzFRc0RHQlg2WXdx?=
 =?utf-8?B?TER2Z3MwaVhraldwUEp4UER2OWpLNFJNb1FyOEY5d2pMSmhFMjU3UWdWNnFq?=
 =?utf-8?B?WEVtOWFXSC9sSURRUVZTd01QN3Y4U3hCVlBzekdMLytmSnkyRzFLOGtVTmZm?=
 =?utf-8?B?QVFtZU11M0FESXFsRi9qRWlvTC9nWTdXVUttY093VUJKYk82OVZJZEczM1lp?=
 =?utf-8?B?cnBCYmtENVBMem11cGdyWGtkUXlwdEY5aWUxRWYxcmFzVUJvdVlWRUpxUlZs?=
 =?utf-8?B?citZc1JuQVZYWEhiRmFpb2l5YXpvL09QKzBldE5jZGZwZGc1OE81T0FsYnhS?=
 =?utf-8?B?ZjRYTkYzMVlMV1RtNHJKSFZhSzdNSFdORlJybUJWRXJzanFyczUyWGFQQndK?=
 =?utf-8?B?aWVGTytYa1k0MWxnb2JLcFdkOTREOUdQS3M4TmpCdC9EdW9VSTUvSWt6SEN3?=
 =?utf-8?B?RXc9PQ==?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e06f54c-a1db-46f7-a70c-08dbe6b69d36
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 15:13:40.1423 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0bwT6icEpfG1HTJedlKS68uZGckyZhrczqaXeUXeiK3xFnQ/i/+ZRiYvlxmMrHdnz6ToM8y9EIN3w0n4hC0yiW5Eh4abM1kaKpCbRB9kkO0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6880
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Refactor timer_getoverrun test using new LTP
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
Cc: ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

On 10/30/23 14:56, Cyril Hrubis wrote:
> Hi!
>> +	switch (tst_variant) {
>> +	case 0:
>> +		SAFE_TIMER_CREATE(CLOCK_REALTIME, &ev, &timer);
>> +		TST_EXP_POSITIVE(timer_getoverrun(timer));
>> +
>> +		/* glibc causes SIGSEGV where timer_getoverrun() fails with EINVAL */
>> +#ifndef __GLIBC__
>> +		TST_EXP_FAIL(timer_getoverrun((timer_t)-1), EINVAL);
>> +#endif
> I wonder if we should even keep it here, the most likely end result is
> that we will have to add to this ifdef once other libc implementations
> attempt to interpret the id before passing it to kernel. Maybe we should
> just remove it and save our future time.
>
>> +		break;
>> +	case 1:
>> +		tst_syscall(__NR_timer_create, CLOCK_REALTIME, &ev, &timer);
>> +		TST_EXP_POSITIVE(tst_syscall(__NR_timer_getoverrun, timer));
>> +		TST_EXP_FAIL(tst_syscall(__NR_timer_getoverrun, -1), EINVAL);
> There are actually two different cases that can cause EINVAL in the
> kernel, first obvious case is that we id > INT_MAX, the second case is
> failed lookup. I suppose that the -1 gets casted to unsigned long long
> in kernel and ends up > INT_MAX.
>
> I guess to trigger the second case we can call timer_delete(timer); and
> then test it as:
> 		TST_EXP_FAIL(tst_syscall(__NR_timer_getoverrun, timer), EINVAL);
>
In this case we can just get rid of variant and go for timer_delete. 
That will also work.

Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
