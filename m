Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AC5AC43334
	for <ltp@archiver.kernel.org>; Wed,  6 Jul 2022 09:15:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4171C3CA1D5
	for <ltp@archiver.kernel.org>; Wed,  6 Jul 2022 11:15:11 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 35DCA3C98D3
 for <ltp@lists.linux.it>; Wed,  6 Jul 2022 11:15:00 +0200 (CEST)
Received: from esa5.fujitsucc.c3s2.iphmx.com (esa5.fujitsucc.c3s2.iphmx.com
 [68.232.159.76])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 541FE600858
 for <ltp@lists.linux.it>; Wed,  6 Jul 2022 11:14:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1657098900; x=1688634900;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=XOKlAl3NEnZozasfjofnAlp+pEdJSsztWyGDU4swqEM=;
 b=umbNhhwpIaok3fgAu0W13Q66CAWiXHGBQvK2Y0iXZimhPAzmn8Q4+Eo4
 NXLs3EnzmZAGV90L50W8Gbu2O27eN0QIMyJyAxmyXoTXXxFWJVPxycSPx
 Jg//Cl5BdJ6XEST9KD64CYYoS+fJxa01SZsTa1JGzwbfaDgdnu/y+TOoS
 oJ8i8lSGvPFdIIaI9Sh0D8LboRH/jvoHYlEYm511XY+BhBaZBtf1IBFLy
 dwV8q9nxa55SI2t4UhvsvRZopaUX98h6bdwMfWKZI8OBmmHjQV7Y9pXT7
 nQ29tiMCth6u+kKvm49cTW4nukta4r5CTEzK4VIgttcYG+X7vyKaQSj+T Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="59915413"
X-IronPort-AV: E=Sophos;i="5.92,249,1650898800"; d="scan'208";a="59915413"
Received: from mail-os0jpn01lp2112.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.112])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jul 2022 18:14:58 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KYxjfF9HiiqNorAPTDDP3h8q9ijX4t7TD+bp/z38g+Dn7JK+nIIHUgium2GQGFG66XpZItwtnMArKyebj+/7l36JSTyj92AV8TNN1vm8weZtLBI3ywjqNlh2YOQV5rxo+moHievUFc34cOCrip6REkRntfryz6FppqvYQCuORSixO6qgH9OIkjYSgCiBbQ19NjM3ETNih2nODWMNY4A9YjC2jof9a5gND9mIK5h26W32emZxmu2m95ZpntKA5f/SKYTxFaLzNy9kSH2Jv2W/cvsqBPlyz9MJYhyJ5gvVEdbaH6DE42Z8/HiYjG6cTZBSqk6fJtl4cKmfpKdBUh/G3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XOKlAl3NEnZozasfjofnAlp+pEdJSsztWyGDU4swqEM=;
 b=SNYjUGLx1t3vHnMRW3bcVxgNOWCjt1iXD1NM5Sr2Z6cX+CmXPTVNCxOKMXdjTDTxx6p0WscBBkA2Yx4BjTuHd4hYZ2M/wvgIttTZPY/HF51ddMBHMcjp591HxNF4eqTAb0OvTOyJfRbzWgEm/eHGoV+78rwSxvR06JGLGaFRXH+cSD71n5tP+GElr4MmcnZNeETYH0NBsY3NH+ydRjPJsdV8HzlzJYcyDgbT7EHNFyXmavbVY6AhU7Q7tBCEiku8iRRDWBLguheNGRDRK7/5XHjX9d+3y5irSnYRDEteBjfXMECxE/FQVHX0EWHPd/nLqb9PBiETUgN9Y99lj9SmXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XOKlAl3NEnZozasfjofnAlp+pEdJSsztWyGDU4swqEM=;
 b=NF4TZtZsBkaAfBV8w35D0qQjpQ7ZS9XyAFSVBdjP3A0AC6rZ9bdaN718fqs+DZdarEfxqQBvRQgMNsv9MvHKY5+IOvt9gZr8sQYSTfTrGuwcS76+aNHEJ/fcZ0To5FnCsSCC/p5EKJTCAGm3BFKBMhnjDyfBL5+xwGKRfsW0XTs=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by OSZPR01MB9614.jpnprd01.prod.outlook.com (2603:1096:604:1d9::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.15; Wed, 6 Jul
 2022 09:14:56 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::fd30:6d2d:85fb:8160]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::fd30:6d2d:85fb:8160%5]) with mapi id 15.20.5395.021; Wed, 6 Jul 2022
 09:14:55 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Martin Doucha <mdoucha@suse.cz>
Thread-Topic: [LTP] [PATCH] msgget03: Set custom queue limit
Thread-Index: AQHYj5uUqfGXFFBeIEi+uggLwTpEEK1xI4OA
Date: Wed, 6 Jul 2022 09:14:55 +0000
Message-ID: <62C560D5.7080209@fujitsu.com>
References: <20220704114523.10409-1-mdoucha@suse.cz>
In-Reply-To: <20220704114523.10409-1-mdoucha@suse.cz>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1c839fa0-1bc5-4c03-15df-08da5f2ffe31
x-ms-traffictypediagnostic: OSZPR01MB9614:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: epubTTLD6qxvgD5c3O8C1c+BtsOC5103FxvAn1N0/TME9gKO4Pf3Jaj9QKR6tdOa6qpirAikrNpP7u9b4wnGkNk0054LwcJBQ1K1eKBB3FKjk0WxEa79kKuiiNUKvcIbhQvsBmiteHyS78fnuvdY1M/SWbvpcAFPfTjGQE3ZUfqYoH7/oH94HCSCUzfIJLgYF+LhV5f8aJZoh69a/GcOI0OEwA8cAIwr8Xa4nQNw4rXPus5xGVurEeVKMjjz0tbvoOaU5wVLg0yjPjD6fSAGL6EMnihJHKYuFeMOn0Eh4bzIS3YdBxIUeIju7Mua/LY8UQ0m/i/reOJPvn/o7FVNQMDWEJSAHgXCFam3nqASX+58zWz0SqPCOciUlJQgbdYQRt/7GstPtXf2WJOSRtwqdd6QQLYZiBVP0gKb6XLr8pZpshukmay7ztMFg3GXs7mtCYN8VTGQc0j5HFWBV6xD4DlTmi8kLOb8fqltL9SY8pOjISeLpY+MZiks7VOFkkzMCSsOuDU8HdZ9Tfmkdz3TDRm7icW0eT2H/Vq7CJIr5T76VmnB3BtDeiMpElDBhfr7zaFlE8E40rb4ASVwFswwmh7H4nM4Xgil9c3Lj/n8CRIm4VqxrgY7wSwBVVZCCmlCNilt1JXYLHSovwIMXcj1CgY1BTNvrUoyGBtoyUkRIcoFETR//z7wM0XiZUvgLkgJrRR12IaoQyilDh7GoXlJEvvWXu5vcC/wCeC4oRHHToYEM97wLxHO0jMWbU+oe5QTG7syT+s/DwKAfWh04Ov6epdkXWUsysNsDL5L4C+sa4a9LpUraZCvnmnt7+uoXMJ+
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(39860400002)(346002)(366004)(396003)(136003)(2906002)(41300700001)(2616005)(38100700002)(316002)(36756003)(87266011)(85182001)(6916009)(6506007)(6512007)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(8676002)(4326008)(71200400001)(33656002)(86362001)(478600001)(186003)(83380400001)(91956017)(82960400001)(122000001)(38070700005)(26005)(6486002)(8936002)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?LzFqM3RDTFlxYXlPSHoxSkR5MnNPS3hBUWhjcDl5Y0RrcGg1MzNCVjJTTGhk?=
 =?gb2312?B?RWVUK0RIR0JOR1N1b051N3hLcStjOWt5STR2NVdKd3hyYTV6Y2JOL2UxcEM2?=
 =?gb2312?B?M2JlZTJRQnZaQ3I3WUtnWlpyOGRxY3FRWkFZMmFLenp0dXdKdUh2Sk9rVHly?=
 =?gb2312?B?Zm1pckFqRDUxcXhPb1d0SGtXUzV3WGNuOUhiRTk2dkwzTWpsUWtpcTkzVDYx?=
 =?gb2312?B?L3pWVmxScmRmNkRZNVNhY3EwN2pmNXBudU9RRjVwZTkvdngyMUZnOVdlU3Zs?=
 =?gb2312?B?aCtDd2tlUmZvOWpEZkJNUjFrMEtXSUNJeWtPaWppMUp4bTJBcC9mdkhvWjVF?=
 =?gb2312?B?QTRWQm9XL2NmQjhiR1NaKzhnbDFmR1llRzFFYW5MUktzZTZpV2svR3NTRkdX?=
 =?gb2312?B?bXZVc3FKWDd1dERyR1NabEVMZHlpdmNoMHAwQVZER3ZMd1JTVVE5aVpJaDhr?=
 =?gb2312?B?dHJVa2tRdVI3ekw4Y2FVbVlsKytoNDE4Z3lyS0JkNnRZaTBiNDRIdldpdlVF?=
 =?gb2312?B?Y0JkWU9ZVEJZS3NMRXNBc3BvRDJmSHZ2UlEwd0pNK2czZnczUzE4YWlnY1Bm?=
 =?gb2312?B?SDFtYVlKUGM1Z3ZIUGtUY0N5N005YWh4WXRRRE5vTkZRT1NLU1E1Ty9UaEtF?=
 =?gb2312?B?Y2EzZWc2MlJzTFNzcVdtQ0ZBWER2Ujl0MzVkRWR4ZC9XZGcvZ3NLYWZrR1dL?=
 =?gb2312?B?cVdoSmJld0h0Z0dFaVFYVUJSWlBKR1U4SFJGRFFKZjBBS2JSQ2Q0c2xGSHVZ?=
 =?gb2312?B?UUNDaXpGZjdjV1JFWUpTZW1KeDRlTVFVRUdJM2pyS25NaW8zKzF2ZzQ5cktO?=
 =?gb2312?B?M1NBbVJQaXJvN3Rha0xsMHk0OC9xek54QjNtWVloY0hURGNmQm4waDI3UnZj?=
 =?gb2312?B?OFc4T05mQjVTaUlnODhGVHVmaDN4Vmx4OVEvVnowT0tqYlBEWU1ubmwydGN0?=
 =?gb2312?B?VWw2TUVjL25wbVpMQ1JITFlkdWxHZEc4V0VuNzVBV1ZCTWZ1VGhEMU13WHJX?=
 =?gb2312?B?ZlF5Qi91a1RmYlBOQnFBQk44NW5lU1NROW45dXNHTEZaTjV1V0YrMTA5VmNs?=
 =?gb2312?B?dDBHVUtZMzJIR0k3VkdSMlB1aXFCMExseWR0c1VWeWVOcjcvek40eVcyL1c3?=
 =?gb2312?B?dGd5M1VxL1J4Y2szVHVqd2dLekRoekZnbkxBcmRKZEZvRWFpK1NjWjFQeFll?=
 =?gb2312?B?bytJZFQ2TDZKeWt1bmE1Wm5kcnB3VlJWaW1mL0ZIK1MrQ242NmFpbmJhVTRF?=
 =?gb2312?B?aFJjMnhXMDlmblJYeHNKS2lMYWNvMjl5NlBNWDl6U2pwTFVBajZXU0pMMkNM?=
 =?gb2312?B?a3pzYzFURnhWdnAzQklaK2cyS3NHQVpGR3ROMWo0OUNHSHk3WDB1WW9YdExk?=
 =?gb2312?B?YWxmOFpTOGNSYjRGUnpoRjlTbjFaYjN0MmxnYksyUGk1MnZvZW5TQ2tFRDZF?=
 =?gb2312?B?MkN3L0lGSzBRQnVjSDVtQktZYTd4U3k4ak53enhzak1UOVhZU3R1akJGU0t4?=
 =?gb2312?B?Syt6VU0wZEhTTS9EM0VoOHY2V2l6d01Wa1FKM0F6b1pHcjlrNlY5YTJqMUFW?=
 =?gb2312?B?NUUvWjZIeW11MXJCYjI5SEx1dGx1U3pGbjNGcWE2cnBqS1g3NEc1Z2lWK1Rm?=
 =?gb2312?B?S2dkcmRhUGk1bXMzcHlBcmZnRzlQb0hiMThLQlhxSndpZURHS2FNSjlUd2Z6?=
 =?gb2312?B?eDBXOFcyWUt6Y1F0cTN6dU15eG5RWU5lMkw0VHBoT29mbGJjUnU4RFZMSU5i?=
 =?gb2312?B?cXNIYXM0NE51UFNUeTE1ZkM5YzFWRklLY1ByS1h1OVp1WmtZVTJIdlFvZHQz?=
 =?gb2312?B?bXNwajZTOEl0NzNPbDFkTDNNLzcwNWE3aFVIVmFRNlFjMTdJcTZpdnREaC84?=
 =?gb2312?B?Y2JKdDc3MTQ3VmQ3dk1YKys4YUUzNXdXMzBaNFdNbjdhaVFYUDJCOHlGWHkz?=
 =?gb2312?B?RzdXdVhrVWoyNFhnYjJqUThRYk5Lb0JuZUlMb3ZIWTJPYWxiUUUxSTNlZ09y?=
 =?gb2312?B?Tk85bmF0ZXd2K3Z6bXRKd1g5c0Ywc2VVZHpNclFvRUQzdDlZT2NyK2lRWG1B?=
 =?gb2312?B?K00wZitoclh3ME9ja29kTGo3ejh6MkdPc1lZclRMVTJVcTBJM0pLUkw0cGdB?=
 =?gb2312?B?a2J5QlRhdjJLOEtBdGhIYUQ4Rnl4cDZEV29MNWFTZ05ZU2JuTjlZcVo0QnhL?=
 =?gb2312?B?anc9PQ==?=
Content-ID: <D4339382481CD048ABF2BBDE2E8BA697@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c839fa0-1bc5-4c03-15df-08da5f2ffe31
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2022 09:14:55.8765 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: syYQJW4cmxItqRVGXzac+Wr5aytFLR9rn59bP+GRjLQ1s+OO/5ZweZOSUEwYNsWIWSXbujx0QLjRNRxqU76780iHTUdlEeHYQlJc0LPKYUg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB9614
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] msgget03: Set custom queue limit
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Martin

I don't have objection for this patch.

But I think using system custom max value is more meaningful. How about
setting timeout to 5min, I think it is enough.

Also shmget03 uses same logic, so I guess we need to modify it too.

Best Regards
Yang Xu
> The runtime limit patchset has reduced default test timeout to 30 seconds
> which is not enough for msgget03 on some archs. Set custom queue count
> limit to make the test faster.
>
> Signed-off-by: Martin Doucha<mdoucha@suse.cz>
> ---
>   testcases/kernel/syscalls/ipc/msgget/msgget03.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/ipc/msgget/msgget03.c b/testcases/kernel/syscalls/ipc/msgget/msgget03.c
> index 711886e17..2257ae0f9 100644
> --- a/testcases/kernel/syscalls/ipc/msgget/msgget03.c
> +++ b/testcases/kernel/syscalls/ipc/msgget/msgget03.c
> @@ -41,7 +41,8 @@ static void setup(void)
>   	tst_res(TINFO, "Current environment %d message queues are already in use",
>   		used_cnt);
>
> -	SAFE_FILE_SCANF("/proc/sys/kernel/msgmni", "%i",&maxmsgs);
> +	maxmsgs = used_cnt + 32;
> +	SAFE_FILE_PRINTF("/proc/sys/kernel/msgmni", "%i", maxmsgs);
>
>   	queues = SAFE_MALLOC((maxmsgs - used_cnt) * sizeof(int));
>
> @@ -73,5 +74,9 @@ static struct tst_test test = {
>   	.needs_tmpdir = 1,
>   	.setup = setup,
>   	.cleanup = cleanup,
> -	.test_all = verify_msgget
> +	.test_all = verify_msgget,
> +	.save_restore = (const struct tst_path_val[]){
> +		{"/proc/sys/kernel/msgmni", NULL},
> +		{}
> +	}
>   };

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
