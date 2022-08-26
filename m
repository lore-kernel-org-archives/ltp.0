Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E5E5ECAAD2
	for <ltp@archiver.kernel.org>; Fri, 26 Aug 2022 08:41:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 02BD13CA49E
	for <ltp@archiver.kernel.org>; Fri, 26 Aug 2022 10:41:21 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1C1A43C7CB4
 for <ltp@lists.linux.it>; Fri, 26 Aug 2022 10:41:10 +0200 (CEST)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-eopbgr80087.outbound.protection.outlook.com [40.107.8.87])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D6E42600122
 for <ltp@lists.linux.it>; Fri, 26 Aug 2022 10:41:09 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RNIUm2MM/vtQo+PK24b9BbX7RA1hylyZ9xkZJZxLkuHMVQ1f0zH81bYPwcrtrccRGlqgJg+IigSoR2hrwpwxpzxmwmFiILDW1A12eTMSz2UZ485xh4c+XxMzD6Y7P2xE1324u4hUTfDbRUs8q9l5/tuShib6aLvEzZtxk4SUwRyoXNekqnh2pq2IP9TdsPkqt/DCnyq1zgOHB5zShvw0VS8rJBX95jZ4vKSRlUbEoBhuC33jW7T2jwtt0QGZVWXDoN6pnC/EnlBFZLivyELssP/V5xY1wTYqqik53QMf3/u6v8uLXE/RLcMuRjIEUa4QyIopDqI8pbn0phFM/wc0NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v/fmhp9grxpMw2E9HezL6uI/j3xI3GutJJzvn137Rak=;
 b=mzPQWak9qo75depMAQ+kjW9tFMP5Hk1OoaYARMcRDVc7wYH8h7RUazAH91jxAxGoDLzUBVlCiDipbpCEvsNsXHf+8PdaJTPgQaJIQ4RZKERZ/kAMCJm4PcHta0J4vN8CCfHYGtbAQyTzRIu7dqf0nE0o+7bWagNaaXhrdMJKccCsjSVNfW+XQUIPDFNVmrv4+1aJ57dmX+JD4U2oArjvUEXYj4fk59EUl3L6Q17LGuDQalulBC2BT5WRSUcs0/S3kfOtaz5anU2C9SDVN5np2rlP1IGJxXYaksrkOouWKV2lCG0w5ObpM0A8234GJId3FXCGxj4r88cZU+Bod+gHjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v/fmhp9grxpMw2E9HezL6uI/j3xI3GutJJzvn137Rak=;
 b=MFMay/Q9D+PqBcXSPZpd8lfb6QQatDtDXOMPRxnNAeGzXdcaCcjmfIRsYCRj9NeQfvIyl2x1uiv90Eo0S2GlqRIyWekJTciqID6qSCLXxbpjTqGLW7BjVTtt9Wj8WOItxndH49BOPaq/SlIUWBHcS9g++7hG3RfGe9JtS8TsZ9t2f8Q/jRdAM7aO2JYV+Kzkng06PU6G8rPRvYeZDN/u/x0x9bXw7Dg/CbHdOYt958+MWQhl52kND4boMavpwSisKOq6Rpwd4M7ZJ+KnRGrWrtqQ6lPaNhs5fuS4FtkSTR9oi7AGoz6K43PSzazevOENl9i9JD35XKXwQk2zmBXK1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by AM9PR04MB8649.eurprd04.prod.outlook.com (2603:10a6:20b:43c::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.16; Fri, 26 Aug
 2022 08:41:08 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::c3:d917:fe7a:451b]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::c3:d917:fe7a:451b%5]) with mapi id 15.20.5566.016; Fri, 26 Aug 2022
 08:41:08 +0000
Message-ID: <d64a2ccf-ee24-d4cf-17a7-bd32556a9570@suse.com>
Date: Fri, 26 Aug 2022 10:40:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Content-Language: en-US
To: rpalethorpe@suse.de
References: <20220824124017.14286-1-andrea.cervesato@suse.com>
 <87bks71nwg.fsf@suse.de>
In-Reply-To: <87bks71nwg.fsf@suse.de>
X-ClientProxiedBy: FR3P281CA0018.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::11) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a1b82be9-bca3-4d18-d580-08da873eb871
X-MS-TrafficTypeDiagnostic: AM9PR04MB8649:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xg78R577NTRha+kuwAdiXkkzFxdfUFPWf7KSqDXdb65g6MRzxt/AaL8GxorWCBKLtctrunH1X1KzcyNT6EA2eb0Uzh5tL2bIWwV0VPnDoxtJnbiRVxGklKoatvYXP2aGCjCBwTOkXtLBPrqAvAUyHyV4o6vu2RX4dN3K6/0DfhUl9e2NwtANnmw+TPLUYhdgktAljiBeY3C/BujAYzjqBI6iw4Yw99jBzBhb52S7xIx4rt3WW7KhPmp85zvveY9w2KLQUn3QMHm9dHlPP94LSBlueDWcUtMZDaYff73YNdORCGzGgNJAa3Z1/rkesajqgyoyctLQYN7XYS/0wqHj6B0/7FyxDe2n+gomp7JtGPakLQVm1EI+lFTeJz0ojig/XusvwxOCxQDUYEBEv716qHuhjSkhKRJwhmFpRNS7ayW6KBjEs8itmBnDTsfoPdPdc4B1Ehmg60quf83UATSA4YZ1YiR8y66G1CHOZ5b66VAeG0n2biFhaaV2Q30ZE+v2gDtAQJf666i4rLmyuJ9mquSEg7k19F2gTXlGtmD96CID8lh1dc+4oxHVubkNPZB/XWdlrudrMkPdfsk5rc6IH0XhyjXO15uMDv3k285C5f0jWZDDpaUCNcBEAbonzwThy2VzOYhZOP0QqAk+NufYDCWXeM5FfEqj/FdN+uSf5tR2G91DJWkBPy/vBw+IyC+D5wUeDD54pt9nBSjrP+Ll3NP7eQzqu9u5ppKqPeijULUeob+uF6sRoOl5gC/k59uZWtaCQfp4CoXvg1rsJhv5fi9Hw1//U919djG4vrRY87k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(136003)(346002)(39860400002)(376002)(366004)(396003)(2616005)(6916009)(186003)(316002)(31686004)(36756003)(6506007)(53546011)(6512007)(2906002)(44832011)(6666004)(26005)(31696002)(86362001)(66476007)(41300700001)(6486002)(4326008)(8936002)(5660300002)(38100700002)(8676002)(66946007)(66556008)(478600001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QlNicFBJbGthZ09pQ2l5TmU3TkhkU2dEazFyYzJvb2kyL1hKSjJ5TGw0QXRs?=
 =?utf-8?B?aEV5bWxXUEFqbGd5UUp4aXB6aWhTOURYU3ZzS0E1U0c0NmdYaXYzUFExRjho?=
 =?utf-8?B?M1RpSjJJU0VyRFBaRHMwTGJHWXI1b09xRERjeUpMZ2lYdFNBTFhDUnVxQzN5?=
 =?utf-8?B?MHlnK2UzdDF2U3pyODZtSjNIRDYxY2RVOFpPeUc4RW5YTnhTZjViNlVLUG1q?=
 =?utf-8?B?SjFMZHJVMnZka1V2dFBOaVNLL3g4cG5qSnVZOWVYemZYck9IeUYrbCtXUGNo?=
 =?utf-8?B?SzIwc1pSSjRXbDJXT2p0Mk5sRERjeVR3dUk5VG1Gays4K0U5N2RmTFBsdHZB?=
 =?utf-8?B?Q2xoODJEY0s0TDRJaC9NU0dHaUJTZ1ZkZkE1bTJienV6NTUvalMxWURQUHFl?=
 =?utf-8?B?QmJFSkJPaG9XdkdEd2p6YTc1WVBWd1g2UHl3S21nL0JyUUVzR3hlMlhOUnBH?=
 =?utf-8?B?aTBkd1MzSzZQZFdqWlI2dnJqaGFxUzhSRHpkcEI3V0ZZUUEvTXJwUnRSWUlw?=
 =?utf-8?B?T1FNQTBOcWNrSy94MER2VnBtb2UvODJXcWV3NlF6eTg2TmU5K0JIZXh1K29s?=
 =?utf-8?B?bWpDMHowRmVGckxReVczU29RSmtLb0Q2Mm1yNnBnRjZHU3EzdTlicEF6Zk5p?=
 =?utf-8?B?cURtbWpJVFZBK0NhYW13MVkwTnRVZU5UV25uQ3R4VmxrSUJ0R2gzS0d5ZVRE?=
 =?utf-8?B?VGY4MzdYWmpwS0YxTlAwWkpzd3dWZmp5VzVsMzRWVEJIc0xlUGxKdHVOVmxN?=
 =?utf-8?B?NllFQjNQZHlCWDFBVklPTXFrai9XQ3BDSHhNSzRScC9HQmVIUzBFWUg0NnVz?=
 =?utf-8?B?cHcyNmlNSjQyV0JmVFE5TEZ5RERUSzFpKy9nS3dEeDlOZW9tZlgrMWlVWVlZ?=
 =?utf-8?B?UGJpZERVMWt2aVVBMWZycHArK0hvNXdXUjhUcDZuTnlWalF6L3NFcDdRR0hK?=
 =?utf-8?B?cXZrMkM1aHNjb2Q4L0l4RTYvVUhDYmJiODN6dElneGdJelNrcG01VXJQY2sz?=
 =?utf-8?B?bEZJOW10R2NOdFlmV3VEYkxHK2lETHpqa1Q5UXVnaXo1cmV2NDZoaTFob0Qy?=
 =?utf-8?B?SmFRYit3bzEza0FGWjVMbUdKL01tUCt3b1BWVi8wWnpFR0tCdkpFU0V4K01j?=
 =?utf-8?B?M3pZN1p3b21YUDRCcnZ4akQyQy93eXNiWkJGZlhheUI2TWtTc1lyUk1kQ2pO?=
 =?utf-8?B?YnBjTkYvVDJHNnJiL3VGN2g4ZmZXdjEzWER4Z09UK01odHZvdDgxUEJ6S29J?=
 =?utf-8?B?OEN2WDVTK2syMFF5YktZSUxQS0JkUDBSK3p5c2g1OGR2cG9wVmdHcnNLTXBL?=
 =?utf-8?B?UFE1TnRjWFJsS0NNZ2ZzaFVxYWtETUpPNDhERjBBUHdoSXh2ZEhEeFdzU0hS?=
 =?utf-8?B?VFQyOWJJTmRKUEUrTmhYMEgzTXcvd0krQlR4d0h5TWxOWm9sb2xnVzJlU2JH?=
 =?utf-8?B?bzdqd3VoVjZWM1pqeHR3ZS9acXNzak1jMVZLdkt5OFF1aUl6dk5hWm12VUs3?=
 =?utf-8?B?L21jMmh1UUNIZ1pzM1dnakRrVlFJZ3BrK2diYTdHb2tmalgveEptMzFFY2pE?=
 =?utf-8?B?RGhKU0NWVWxMem1CMmxQNUZOWWMrM0orV3RPUEFGV2FoSmdsRWE2eVNJeUVG?=
 =?utf-8?B?ejI2K0tpNi8yWWRHVmthRURkQ1g0Z0h3cnVZRk9MVVZvZVZPUHhjSHpvb0dw?=
 =?utf-8?B?SGhDSlRUUk5wUG5PY1FEKzNlR2NsWGt5YlUvL1Z5VERMeklBcnZ5ZG1YSVpx?=
 =?utf-8?B?YnNOSkRKQ3RUbkxSL1RnRUpaQWRCSWNtZUVUcmlTVXJXYzNhenZuSi8raWFQ?=
 =?utf-8?B?a1FEVUpKbjVpKzg3L1NBWjhlZUxJd3VtNUZoRnVnbGR0Nk0vY0I4N3Q2UFk5?=
 =?utf-8?B?VWY4ZnAwbnhGTXVUdlc2dnpUeVVJdkZHa3Rwait6bTRnSmFPSlJveCtkQmRY?=
 =?utf-8?B?cjZ0aURjMmU5MUJjQTFmMTVDTmZQR1FrSTV6WjI4MHk4VzhNOWdyU2oxUmth?=
 =?utf-8?B?VmFrcTVrK0dYanBvaXU2alloV0EzQUFjREFlcENtdXc1aXNydXgrS2dSWTJp?=
 =?utf-8?B?ZXBUVDhveFJLUjBOMzl5U1dUUDB1cjJlWHpWRlhvdVU3ZGd4YzVodGNvUExZ?=
 =?utf-8?B?eWtOWVBEOFVTK3ZpZE1TQkswMVBIMGJ4YTdjK1hXVThGMlA2MVA3RHpuTlJQ?=
 =?utf-8?B?U1E9PQ==?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1b82be9-bca3-4d18-d580-08da873eb871
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2022 08:41:07.9317 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lYr4occYeJKbimqF1uhiElJNUIfoJFoTNKChwQm0nr/WG3kIbQttbOnNW6kVJsQBBMMpjoSlx0VgquDG9/b/ngWUxgbHdIw1BC1beWqMDh0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8649
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Rewrite process_vm01 test using new LTP API
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

On 8/26/22 09:04, Richard Palethorpe wrote:
> Hello,
>
> Andrea Cervesato via ltp <ltp@lists.linux.it> writes:
>
>> -static void cma_test_invalid_perm(void)
>> +static void test_invalid_perm(void)
>>   {
>>   	char nobody_uid[] = "nobody";
>>   	struct passwd *ltpuser;
>> -	int status;
>>   	struct process_vm_params *params;
>>   	pid_t child_pid;
>>   	pid_t parent_pid;
>> -	int ret = 0;
>> +	int status;
>> +
>> +	tst_res(TINFO, "Testing invalid permissions on given PID");
>>   
>> -	tst_resm(TINFO, "test_invalid_perm");
>>   	parent_pid = getpid();
>> -	child_pid = fork();
>> -	switch (child_pid) {
>> -	case -1:
>> -		tst_brkm(TBROK | TERRNO, cleanup, "fork");
>> -		break;
>> -	case 0:
>> -		ltpuser = getpwnam(nobody_uid);
>> -		if (ltpuser == NULL)
>> -			tst_brkm(TBROK | TERRNO, NULL, "getpwnam failed");
>> -		SAFE_SETUID(NULL, ltpuser->pw_uid);
>> -
>> -		params = cma_alloc_sane_params();
>> +	child_pid = SAFE_FORK();
>> +	if (!child_pid) {
>> +		ltpuser = SAFE_GETPWNAM(nobody_uid);
>> +		SAFE_SETUID(ltpuser->pw_uid);
>> +
>> +		params = alloc_params();
>>   		params->pid = parent_pid;
>> -		cma_test_params(params);
>> -		ret |= cma_check_ret(-1, TEST_RETURN);
>> -		ret |= cma_check_errno(EPERM);
>> -		cma_free_params(params);
>> -		exit(ret);
>> -	default:
>> -		SAFE_WAITPID(cleanup, child_pid, &status, 0);
>> -		if (!WIFEXITED(status) || WEXITSTATUS(status) != 0)
>> -			tst_resm(TFAIL, "child returns %d", status);
>> +		test_params(params);
>> +		TST_EXP_EQ_LI(TST_RET, -1);
>> +		check_errno(EPERM);
>> +		free_params(params);
>> +		return;
>>   	}
>> +
>> +	SAFE_WAITPID(child_pid, &status, 0);
> We want to use tst_reap_children() here which will check the exit
> status.
>
> In fact, if SAFE_WAITPID is removed altogether then the exit status will
> be checked automatically at the end of the test when the lib calls
> reap_children.
>
> Otherwise LGTM!
>
Isn't tst_reap_childread() already called at the end of the test_all 
function? (tst_test.c:1354)

Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
