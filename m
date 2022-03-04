Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFD39C433F5
	for <ltp@archiver.kernel.org>; Fri,  4 Mar 2022 01:35:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A65063CA35E
	for <ltp@archiver.kernel.org>; Fri,  4 Mar 2022 02:35:37 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 31B753C9600
 for <ltp@lists.linux.it>; Fri,  4 Mar 2022 02:35:27 +0100 (CET)
Received: from esa12.fujitsucc.c3s2.iphmx.com (esa12.fujitsucc.c3s2.iphmx.com
 [216.71.156.125])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id B440C1A00484
 for <ltp@lists.linux.it>; Fri,  4 Mar 2022 02:35:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1646357727; x=1677893727;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=qnF3l8ubieNJ+6xXctGJBqh3fsIecnrPpGYuxwDfjbs=;
 b=DmCxkD750nQBV4nzZmG8bS7YUMe6C0FowNIwGT5lrXRZx50EUC1s3joJ
 hAZO/kjozhyguQZXNj2JbZ44OOAxYBVGeHn3Ana3WhZSkkDuROFXFxMmn
 fVkhAtIAEMIpcFpk8fgbHH+oVFXAaYuo9ozuzNHzFAQ9zRhhuuMCBcT0s
 XoNKvQ41JtXS89wiMeHrnBICgLpJ+WcpghTGmDoS3cv5YlFDe1yT2H+z2
 zBR9hqSNiY3s71wPS9mHc4JZsSzOS7s9/KbWtdlRuWXRpyo0IoaqkmyQE
 VRpLhFjHimD6IlmcbNwcqnoQqWs0rC8wkvv2LGcDaEl5iYh9Mex8X/n3R A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10275"; a="51139470"
X-IronPort-AV: E=Sophos;i="5.90,153,1643641200"; d="scan'208";a="51139470"
Received: from mail-tycjpn01lp2175.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.175])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2022 10:35:25 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mTGhHAM9jYtXzwXinJEVYuP4kpwzdh0O+oUbS5luHM6RW0ucKgva7dFNRRQ0VU/YVMyrUqyMQzhDDiqwq5hmpSXqYKcOSxcBrMwVGkhM9etNa1a2mOrRbw963cVTniTaHtKnukxKji5PQdhyVRwtcsx4FhhFdecK2FdA0uNGld2QhABI2LqOsX62lcIK93iiDPYKFjEf6FwjBh+uvZ9x24WZnEJLSbCEpt7biCGzVEseuFoWu2SgiaMe6B5g9PIalrY6pmK+7Ima6TD+EOfbGstvErw5HEywzdF3ZU+g1A8xmaqE5OOE/PNhhiOrR/17wzxaBB1N2s4750zzZ8F/jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qnF3l8ubieNJ+6xXctGJBqh3fsIecnrPpGYuxwDfjbs=;
 b=OMBhYU4c6h9WfTBd3Rts3ZScn/IrO/am8TfRINM+9vnNoBbstK+9sIBAEFW7FgvnFZSp5SpB44jAJyKGbSVNeuxmZNklNR71QbYscacvrGWlLkTeyd1HokO2VIY0sW34t/PkiqfEFKXTvvHWo43/6ecWUfWXnwyqo4+98mW+FIFp6HgfoKmBS2vkRksHgJV8sxxE5o4WvYOU5j0lBTZe79dZTkNmjS+Hzz5BsP6BzBxXDo3u9znkM7g5TsowupRBjXsn4MivXUON2R1BXAO+A45B+Gp/crZTRTB2bkS98TkzXZMMGgUPl++a9UMB6CVuwBoOK2FhUS7ouPHVD+zV5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qnF3l8ubieNJ+6xXctGJBqh3fsIecnrPpGYuxwDfjbs=;
 b=D3LxbGy7LkZTpVRL5mCRvAzZYvvsKPXKQa9FemvUa+9sUbmyAPykD50OdvyV6O9YlhyQZdMbsf8M03GZcGnyTHLNY0mI4HsYJN4/jsOu7V5DlsqA/WKdAXf6XPuZYF65IIADEoRDgO7FAda5weduPlPQ+f3Woijutva29EwW3TU=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by OS3PR01MB9639.jpnprd01.prod.outlook.com (2603:1096:604:1cf::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Fri, 4 Mar
 2022 01:35:21 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::dd2e:e671:b3d5:d354]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::dd2e:e671:b3d5:d354%5]) with mapi id 15.20.5038.016; Fri, 4 Mar 2022
 01:35:21 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Martin Doucha <mdoucha@suse.cz>
Thread-Topic: [PATCH 1/3] quotactl06: Replace tst_brk(TFAIL) with TBROK
Thread-Index: AQHYLxPGIxtQyyjR8UaRxBAckCxFMayuclMA
Date: Fri, 4 Mar 2022 01:35:20 +0000
Message-ID: <62216D10.9060409@fujitsu.com>
References: <20220303153131.3372-1-mdoucha@suse.cz>
In-Reply-To: <20220303153131.3372-1-mdoucha@suse.cz>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 529f3e67-5513-4b39-c1dc-08d9fd7f3f15
x-ms-traffictypediagnostic: OS3PR01MB9639:EE_
x-microsoft-antispam-prvs: <OS3PR01MB9639894C15C9ECDE3D444E86FD059@OS3PR01MB9639.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q6KZ5xoSsfjUAulo5g1PQLGRELy1f39HkRF+Cj205l0hqp0oGhPLBeNEnXgYLwYJCiAwWJJk1dOFx/B/vGHd/yKv81L4TPSJf+sPzLgsNwIqe+IYRerUrwD+FTSsJBqxpakATkjlltx+z7UsMTdA0k3u20ZcHtO78YkfTgBApIPjkMZ0KQ3vlGoZf3R3LDJYyPcdYzWTx3Wzxf0Bnple8mlFeBNS1LEyAC5L/EwMzsQYGkG5/1edv9JNStzbvTeb4jsQHZ3r6SLR2EBUFkjUQH1BBg7IzVk8DbskS/hPhfFIenGDiUBNy52v9ij7XU30M+Pr9lEEzIyNEzh9qj2wjhyvIclTtYUsIMM5NFLOq7YjhCZ03R9O3tutlOkeUriYqaGV98Ow+ZqBeqGUETCqDToc7gutvHBnzTB2ebkz3KxP7DBJJxxYMk7MEaLNTTnSYfx406kCVRWAG+/wk5KGPE+m82OSIPftHlsVFJugjmjnm8kCHc0p0R5VsJ8V42G7PCLmUEXytbOSZqLucEqkNjqBWKeOf/ums601aMcofHxnx1g6bMMFYYiOcp7sdD9VrY4qvOniQK62C+X7BVUSkdnkNT/9BfX7D5blOOaSjRgoq8WJkGW2hmPGh+LMIYUfb/uSvth9JgLS1ovCDjEfcsgEcj9mDpjKoxuFUTdUXSyT8fvDn/1xA2/l3STna7C0sLJQke6ILcr5UShX3vWEzw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(71200400001)(38070700005)(508600001)(86362001)(38100700002)(8676002)(76116006)(64756008)(66946007)(66446008)(66476007)(66556008)(2616005)(91956017)(316002)(122000001)(6916009)(6506007)(85182001)(6486002)(82960400001)(4744005)(6512007)(26005)(186003)(15650500001)(2906002)(87266011)(33656002)(5660300002)(8936002)(83380400001)(4326008)(36756003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?SjNudFZxS2dvcHBhRHUvQ3JPSS95L1FqTWJMWnNNMUtWZ1VBeVR6QWVHbC9W?=
 =?gb2312?B?d3lQUjZLVGRkaGNmUjZ3ajNha2NBTHY0QlZDT1ZSaVdyZGlrbEZkYkEzV0JT?=
 =?gb2312?B?ejRXMWZHUFMyQ0dJWGV6S0Yzais5U05LNHIzSFhucVdTa1pKT091TGxnaFpi?=
 =?gb2312?B?MS9qb05WVDErOWVoU0dqaDNDdFFYUnhCKy9HaWViQTMwd1FzVmxkTTZ2VEp2?=
 =?gb2312?B?NlZacThJem1rMjBEQXB1VlI4MzNneERSSFVWMTk2d1M0bFNWTGNHM2s0MUVL?=
 =?gb2312?B?R0dRWHhtV21FNktQRnp2THlCMUQ2bkdiTUVjd2pMamY1c2Q3NFJTMkF4cDdh?=
 =?gb2312?B?M21OQXJnbnVHeWZOczZ4K3krQ3hwU2dDaEFHaC9aZDdBNUV2QndQV2dEZE9S?=
 =?gb2312?B?YXhsb1FSUFVvNW9zRjV4VjlmbWtaK2pBMWxZekwrSXFIU1h6VzlVRnpNYUVO?=
 =?gb2312?B?a1NlT04vbGxQMXUxVjNvckY1bVp2NE8yVk54K1R5WXQ2ZmpuVjFMYzFlOUov?=
 =?gb2312?B?K1dkUmYxSGhLTm50SFZZcEpHdjNaUnNvZVdHdUNmTmZORTFnbTM2ZGZKc0ll?=
 =?gb2312?B?aDdITklWSzd6MmROVGZBZHNRVGRIc29VZm16bi9RMlpocXlMR0ljell3YW14?=
 =?gb2312?B?Sm5oWGhCYzdYaTFHQTJTY2xJV0tlWDV6VEJ0cDVjSkZFTGVScVp4djcyMWJS?=
 =?gb2312?B?bHloRWN4Y2EwMm5DT2xuVFdEWVJLdUlvajRCM1JyeWkyb3RXS250cm9BV3NL?=
 =?gb2312?B?dGIyaHcvbElVWVJGVmNaSDlmYW1TdXZnS0N1TDhLWVk2RlYvTE1FS0FDeCtp?=
 =?gb2312?B?NGRFWWNjUUJ1VHNMMWRpVjV2QjlwZWYyVVVFWG5CK2loczBsTHNoOEJoVkxR?=
 =?gb2312?B?OHkzelZJajgxeUhjWWUyTzZSeGptcSt0SEk1YmY4U0NuT05HZmlERWIxR0p6?=
 =?gb2312?B?VmRub3Bqd3FNclZ4NTFSM0JUNlFRWlNWdTlwS1ZVeVZyL0k4bUZVUGxzNTJQ?=
 =?gb2312?B?YlZlZE5NWE5UOUcvS051RUp1eDNwY2Y4eFN5VXVML3RiOFlhVURmZEJkMlQy?=
 =?gb2312?B?TGtyQVZvSVNXSEE1bWhnZVQ3c2g4ZENEVDBqaE9kamtmd1VtVkl1R0hGMHFT?=
 =?gb2312?B?T1NWZ0p1SzJBTzJCNk04YU5Kdkc1eXBVUTQzeTZQeDZncjR0cDdacG1Pd0RL?=
 =?gb2312?B?RENJN0FQR25LWWl6U2FLYzdiOUFVc3BDL29Zd0tCdWV3MEpkNG5PcHpjK2Y3?=
 =?gb2312?B?ancvNTFJTHljeVhLMnQwSCtoSW9LTVhEQXlRWW5KbDlkMmlBcVc1dW1NKzRD?=
 =?gb2312?B?eElSbG5NR29lYVFhMVowNmllSm1mcUQvam5GOXdQc2dhbjR1NU11Z3g5QjhL?=
 =?gb2312?B?MHZlTlk5bSs5c0M5enc0MHdsUnpXTTFYRjZyVTlHS2dDbVdBOWVHQ2tlNWQ3?=
 =?gb2312?B?TVR4RGZ5RTF3d0g2SHVtOVN0MnhVdm9kaEd0MG40MmNtaWhqNEFvdE4zbmFF?=
 =?gb2312?B?eE9xT1RIck1TN2lvMm9EU0lzQ0FRdEpzV0FTYnRQS0pjL2gwNDRYVkd5UGVm?=
 =?gb2312?B?RThTOGtiVm1BaGp5NGFsOE8yZ3phRDJNT0ZIVGpCUVdNYUVJY3JFWjNVLy8v?=
 =?gb2312?B?WGF4MTJjUE9SUVc0M1hmUUpxVEFJM0tCREE3Q3NGdXRNdlhBdXppczlHQ1dz?=
 =?gb2312?B?L2hoSFNER1d0WGc1QmJSRmFRZEJpQXRjZFNHWENSZWtWUXB5YlFIOWY3M3No?=
 =?gb2312?B?VDBtSyt0alRVK0pZKzlkejJjb3FrL1Rhb0RmcE1IWjRJMVRjNUQyNU9EL2M4?=
 =?gb2312?B?K1puOGZxUjZMaHZ0UEpXQ2Q3K1hKcTM1T3VsM3N4RmdUMi9CaWlpQm9icm5r?=
 =?gb2312?B?bVZKUjVjREtZRFJvS01KRkxUZGhCR1RnZC9saFpDSmZ6MUtFamxzT2xKSWxx?=
 =?gb2312?B?YXZReG1xNE14ZmRYaGVGZnNTaSs0VVhjN2J0aSt4eDJlZVRoNzRrcGZPK1RV?=
 =?gb2312?B?UDFsWjZyYXdCT1NNclJZMlM2VkFjQUZXT3VDWTRGWTFFZE1iNGlCOUdrNmVO?=
 =?gb2312?B?UmwzQWx0VklRdHc1dHpJTHl2R3I0OXRqZ281MnNWa3czK2lydTZKQWxsYWho?=
 =?gb2312?B?SEZza1c1MlNwZjY3aHJYcUNUdnFRRmlwMnZwS3RTMnFTVitkSEpnVDQ3UCti?=
 =?gb2312?B?eTJQSWxlM2wzYmtDdkJUTmZpdzVZSS92YVg0TWlQaTdlTUVNUndjMEZqTzA4?=
 =?gb2312?Q?LXHi48q3Ru2V90s+B6MohD4sc2wWEqar9eUUnX4Ulo=3D?=
Content-ID: <0E76388F42A4384A9CC1D70BD91B155F@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 529f3e67-5513-4b39-c1dc-08d9fd7f3f15
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2022 01:35:21.0075 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ycfvLsebFjcW934niZJXiN3QGX0UgSSK/lIFTSR8je06ETVENYzt3Y0IhRogfXoX9KEwyMPuDwspCgturzzFE3JZBiThCzhVsuKlL98t+HY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9639
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/3] quotactl06: Replace tst_brk(TFAIL) with TBROK
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

Looks good to me,
Reviewed-by: Yang Xu <xuyang2018.jy@fujitsu.com>

Also, quotactl01 also use this similar code, I guess we can also replace
it. It seems we miss SAFE_ACCESS macro, we can add this macro and use it
in all similar code.

Best Regards
Yang Xu
> Signed-off-by: Martin Doucha<mdoucha@suse.cz>
> ---
>   testcases/kernel/syscalls/quotactl/quotactl06.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/syscalls/quotactl/quotactl06.c b/testcases/kernel/syscalls/quotactl/quotactl06.c
> index 4fb198268..ca81a742f 100644
> --- a/testcases/kernel/syscalls/quotactl/quotactl06.c
> +++ b/testcases/kernel/syscalls/quotactl/quotactl06.c
> @@ -178,7 +178,7 @@ static void setup(void)
>   	set_dqmax.dqb_bsoftlimit = tst_variant ? 0x20000000000000 : 0x100000000;
> 
>   	if (access(USRPATH, F_OK) == -1)
> -		tst_brk(TFAIL | TERRNO, "user quotafile didn't exist");
> +		tst_brk(TBROK | TERRNO, "user quotafile didn't exist");
> 
>   	tst_require_quota_support(tst_device->dev, fmt_id, usrpath);
> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
