Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BC1AC4332F
	for <ltp@archiver.kernel.org>; Thu,  9 Nov 2023 02:47:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 184183CE843
	for <ltp@archiver.kernel.org>; Thu,  9 Nov 2023 03:47:00 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5E6BC3C8AD2
 for <ltp@lists.linux.it>; Thu,  9 Nov 2023 03:46:48 +0100 (CET)
Received: from esa14.fujitsucc.c3s2.iphmx.com (esa14.fujitsucc.c3s2.iphmx.com
 [68.232.156.101])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 377702348CB
 for <ltp@lists.linux.it>; Thu,  9 Nov 2023 03:46:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1699498007; x=1731034007;
 h=from:to:subject:date:message-id:references:in-reply-to:
 mime-version; bh=uZWEUa9GgFroKUWDTSjGRkCGpC4I7O/NapLjVnYdDg4=;
 b=lSyHhKxfA2F0kjrTpuBl5IsiTMtvX15bY7+yVAgH/w8BtzBcY8vTsUT2
 HWcfozuicWLitoF4wo+xZdfU48CuBtc0rsacicOtlgUkGdL6wOHFIe06s
 0VQcP/D9+MyStE2fq0ZireXDNKb1f8mq27BID6eku6qEO+YFUzAvLbtFZ
 PP86nXeV33EUcn/t606xlgp8TKOs4kFj8eBCX8IuxhPUJ9GRLb86K7nG3
 CUzWGa2lYBTSgSz8ued03Lhhczn5nBr6BArlAGz7TsYMpOV0pYQR3iB41
 AVXfLXhYdI16bHi8ybzA3sKUUF0vlrPtgggwoHVYR5HqMSlBQ6U5rFNFF w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="101561526"
X-IronPort-AV: E=Sophos;i="6.03,288,1694703600"; 
 d="scan'208,217";a="101561526"
Received: from mail-os0jpn01lp2105.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.105])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2023 11:46:32 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TBPRZiMdO3ceuWADr906qiOcga+/dDc0pCoHpETL4VvkOUt7UpVgzS9r4CI1x8O00dWsPfy2mtXc+OzsEfwCr2qwRkDxYYI6zebEmZAedpSr3O/O/bMyXrt0rJbVabfW5a/YUA/GQcy4QD4/DJ44AIWCpZHiktZHgx+uPwRVyXh3P0XfeKySxsAObvSPdjgU03ABOdYQOMVCXRuD8LEESmgrmAM4Im9cy4/jPdjcQI8DvO5Mjai607bDMQsWN6Xd74aNIxSH66WX96DQY3sF6wdInC7fQOlY2SVrdgvXDIXraK9iqR1rg9KNJiVtjYIvdEBZ0FWOolQ1VdQ6ik2RmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uZWEUa9GgFroKUWDTSjGRkCGpC4I7O/NapLjVnYdDg4=;
 b=lsbjmW+SlT5rp4BX8azdHj4bhvtpqJpg5MrTkB7Ach75PNIml3rOQiXRl1bwpfnm0FQbXSozZMgScdGr+QbLYobdFeP7MB/b3SJV+cyQIBWQbr1qElTr1/5ZCPnztyCSsfIrRpIiZlxsvRuLpw/5Zl+jjUfaHJ8Oz1gGa7qRkl6Mw7Tii0SslHbkBDlbqZX5zrzgT5YCh8ak3G+uLnTS4W5UBtC+nbyauWJMslX72ztl1xVh9wyUq5srOPVgnsTSXOtsUAl6qdhdb9tGycXPH6P2+IOcYZ4qN2k0u6YtGdOSb+ONiM6Ass9L4YqdaXHXzGPPG94KqiIHdJaNTuAnbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11839.jpnprd01.prod.outlook.com (2603:1096:604:23b::8)
 by TYTPR01MB10955.jpnprd01.prod.outlook.com (2603:1096:400:39d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Thu, 9 Nov
 2023 02:46:28 +0000
Received: from OS7PR01MB11839.jpnprd01.prod.outlook.com
 ([fe80::6cc3:e6ca:7c96:ba7d]) by OS7PR01MB11839.jpnprd01.prod.outlook.com
 ([fe80::6cc3:e6ca:7c96:ba7d%5]) with mapi id 15.20.6977.018; Thu, 9 Nov 2023
 02:46:28 +0000
From: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
To: "ltp@lists.linux.it" <ltp@lists.linux.it>
Thread-Topic: [PATCH] syscalls/link03: Remove this case
Thread-Index: AQHaEWmfHoSj2rXvtkO7JTrxRdmf7rBxSkET
Date: Thu, 9 Nov 2023 02:46:28 +0000
Message-ID: <OS7PR01MB11839F04EE1677BD9D02FE123FDAFA@OS7PR01MB11839.jpnprd01.prod.outlook.com>
References: <20231107110018.68128-1-xuyang2018.jy@fujitsu.com>
In-Reply-To: <20231107110018.68128-1-xuyang2018.jy@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=True;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2023-11-09T02:46:26.945Z;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11839:EE_|TYTPR01MB10955:EE_
x-ms-office365-filtering-correlation-id: 3e3712d5-4bca-4ccd-b7f2-08dbe0ce12b6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MrDpW0neQXDII3QPbeZ17vvlrfWbJygUgWSX50MeQuc+c7jCT/+I22P21hUCKRHMvQvHl6EpIg053As9Qcy+L9fAiv3EAws7urIJt7am9msMDnG1fOmn1e/HHHV7VhO7sAiXO+duDNhrYYOXANvp1c1y/Jbrd/KWIWQ+FUyqe02/jUl9DXJfriAl/tIwG9HFQ01QbmLPIcSAHDCqziH2y/eErxHnBYYcijMWMnbJHkFcshFbUxtFSL+lg49/kUtOHHmGv+HB2Vn3FPK/70eBf8Au+43bZmzi1mRRvguwUeVbWcFora9VaKBWzwVittfrcp08g3wZG9p5KVl91pmsSUbecKiOSoYbMVvXASHTH0fOXnzVNch6VCo6ZDE0GnvU8gvWuxkw1VrWVYpDARC+70O8qZheJMxCsChpmJsYgEHyQtCrDYeZWMnOPplHPO52+87L/N21unvOvVdlWsAwXr486y4tFxMHRGurOlUy4fzR7ceFyhRhXdB7po9IFZU04TyjHOljhOnosyub95s7EdiDUQG2LgCS0tue9UUiFTzjsrGT4UVFI1Mo6+JVPKnMMr9mVzGXRSg8FBX0Une4qDHhHCMDbRhlKFnjAApqnqB4IKdokhvsgGdi7TiuHyiHZo7dfLaTyahWAxsuQdwjtw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS7PR01MB11839.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(346002)(396003)(376002)(136003)(366004)(230922051799003)(451199024)(1590799021)(1800799009)(64100799003)(186009)(2906002)(33656002)(7696005)(41300700001)(66476007)(66946007)(6916009)(66556008)(316002)(478600001)(66446008)(38100700002)(85182001)(52536014)(8936002)(55016003)(8676002)(76116006)(91956017)(38070700009)(5660300002)(86362001)(19627405001)(64756008)(83380400001)(122000001)(6506007)(71200400001)(82960400001)(26005)(1580799018)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?WjJzdm1zckVPQ1MzOGJmNWdOd3pycHppTXNXWlNCVlZybDgyWStIZ2xMWFBI?=
 =?gb2312?B?aUczaTZCSVYrRXJQOU5EMFJ6K21iMEhlMnF5RHBIT3VCdEdpcTMyczhxR2w1?=
 =?gb2312?B?QVNVMnp1V1VKU0xWWmdhenViUGZoRERnUW5SUEhOV2xCVDJFcVZYYmRJNFdK?=
 =?gb2312?B?UHBkWmJYTk5jbGpUbnFnR1AvNFU3WGtoV09WeE1PbExpZk9Jb20rcUN2SnBo?=
 =?gb2312?B?V0t3Tmw1ZzFVVTFHMjNkVFdFQm84WDZkQ0NyNUw3U0FEd0tVc2RMQSt2N3pp?=
 =?gb2312?B?eTdlQmhQaGNaRzgwMk9FQldCT0VVUHVTMTJnZG5oK2MvVGRaekV4bWFYWW9P?=
 =?gb2312?B?ZEw1c3A3RDVkczVrMkU3Q1E0NEN4R05abnFaVWg3VkQ0eit2SzErWDdIUmxK?=
 =?gb2312?B?dDE2d3p6MHJHaFA5QmxiRmZjV25EQ0grNFlhRTV6MlFKbFZRWUtKZ2dENktR?=
 =?gb2312?B?VG9sb0lrVDdTTGxVYjNVRWtneUZuWUxySnB2UDRQRHRIR00rK1JhK2NLYVJa?=
 =?gb2312?B?OVZnTFNONzZDbnc4bzk4SzArb1NObDkyTXdHTTFaQUtOeS9SVU1RM3pkNnhP?=
 =?gb2312?B?aWxZWXl3amdoKzJzZWxBdDdqcUd2dTcyUDVGUmxVS3ZmN1A1NlQrU0JqVmo1?=
 =?gb2312?B?WE5rc3luM2ZDTlJSSW0yd2d2d2ExVGcxUzNnNnh0L2pleElwOFVxS095UDdu?=
 =?gb2312?B?eDQwdHljUGRkS3hKZlJDdDNvcjB6aWFuRSt3cFJ0elFxYnpSRUU3akUyY1oy?=
 =?gb2312?B?TDVBaUZIQ0JWNkE1VmdCN0ozeER5V0pUTElWRngySFNiTStTQmZHNmRZL1k4?=
 =?gb2312?B?b2dHZUFMazFoT2dyb25PbktMbTRpTVdxbGhaNEF1QlVBQ3phSGJialVpMkRm?=
 =?gb2312?B?OGZZVUxoTHc2d0NYRzRoL0NnOURUaHI5SkNBejRVTklIamEzVDRRcXA2WVdz?=
 =?gb2312?B?NTRnZXE3Z3B6ZWVBd1NRb0ZJT2ZCaDd2b3FabXo3MWVGU3ZQcXFCZE5oSzI1?=
 =?gb2312?B?NWNuQmtWVjQwTDV2dE55ODlxTDNCaGlnblhBcWI1TWF5NXliUHliSHVjNmR3?=
 =?gb2312?B?REJwOU1UR1psN1FML2x0Vi9lT29WOElGand3SmZDaFRuaXZLcTRVbWlVcEVO?=
 =?gb2312?B?RGFNVkRxajI5dVVEdW04em9DVnNwcllpeW9OdXdPRkJSVWdVWWdBcHJteW1E?=
 =?gb2312?B?RFFkUG9OZ1V2ZFc5MjhPK011dE1hU3dTbGxHZXZ2Z1EydlBocWFqV2dBQXpx?=
 =?gb2312?B?L05sWitDdXJnQ2pMaC9aQ21mV2QxSmloRGNXbFFaWC9EUEtkR3k3VlRtT3Aw?=
 =?gb2312?B?SmlUNERvU0dUUGxjYnoyajc3dzJXVitobVl6VEpPMVZnWExORUNTNks4Zktu?=
 =?gb2312?B?ZUFGWXkvRFkyKyttdzVWdWdPaXhKbXFmNkJxY252QkszN1ZOQ0ttWDRxbHpQ?=
 =?gb2312?B?V1RpNkc0RTNick91RVl5UHAxZHRJMVFzWDJndnl4MjVNRVVvYmZKbVVEUDNk?=
 =?gb2312?B?bEVQbXE2RkxOOG5RTXZhZE1PZTl2QVhGOXR5Q0wyMUJNQWYzWWJwcEMzVE04?=
 =?gb2312?B?Y3FDWVRzRkZta3F1eFVKRmtZTldxQ3VHT1IrZmk4ZjZNUFBhcEZzOUdEVlNP?=
 =?gb2312?B?dUM2M2EvNng1ejVYVGtFaFZRaDdLWUlpSkRUV2l6Mk1pUkt5Y2tyWS9RM3ZX?=
 =?gb2312?B?SmVuYXZDaVRjVTV6TGYvSlJkT2R5UjN0UDZhZ002QThKaTg0L2ljcHF6eDQw?=
 =?gb2312?B?dzhaTG1jY2FLWm13V1Yvdmg1T0hFWFJFdGozaDlZdEFybWtxb1pGYlZYbnFy?=
 =?gb2312?B?QXMxVUlpTFBPaXJ6T3RHVmcrL0FnR2xjbFZ4TWNydTBteUxOYXUxRDV5ZGdI?=
 =?gb2312?B?T1QzR0dNaW4wQkFPb2g3TWlHb0dpenQzdk8yL0VaNWdxazBndXYzSXgybEtu?=
 =?gb2312?B?YVdHaVZOdDZ0bEs1VlhSbFZuNkE0NW9nRGtVY0lNbjJNMmJpMHJ0OHg3UmtU?=
 =?gb2312?B?dXFDUDZyNmdWZGNiN1krRVBDT0hKdWNYRG9GTFRhTDFmRFBLVXMwckRCbndV?=
 =?gb2312?B?ZkFRWU53MXFFbS9hb1hoMVFrc251ZWRMS3dWenEyVUcrMU9PSGNmMlk2dVhZ?=
 =?gb2312?Q?gmZGUZGb3JrtPZdUd24WZR580?=
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: KaESkxzJR2X2WtFY9H90XTeCAnlCPzUKUNCD3mhCh7HvmM+rcJMKteza+WfNYr3XEE/BspdV9aeI4iT3+zbdSyyxAmYAsWkcOU8d7z4bT2SDaJml48HYmnLB8o1LF/0bskL71A98PqQpvBSNrczXj8DyMFZ8SuSnae7849+EbdgXOwyjAIixL0+VH+5XZm25YNwA29ILpr7OFVW+tEs1BBkeeET3TFu749twcxhfHXnMk+gKCnZVqyvH515L1NTvE8camws385V4J65UDQn0Y9uBDJtAyY71EYbVO3ckXuRZYmYCgN7eu0Fnq2JdS8Kb8gZm0Km/nlOq7ZZ8FGzrgMP5BWyImXCrrDsoeCP1NHDZilNjyKV6RYdaUyT8Pv1A7psW9HEZgZg6gJqsW9dTvefzBZxPUi80KO8F+y25PQ/9mW3gadAr5t8bmbswdutnXmCxkKFqQfG7Ppi3I0xzA10lVbDmv+fY9scwzq9b8rFn6MeBiuk8irvgS8DoyBA52NFNyp6heB079PuzRZc0O3tzZlrMekVTJtlHLyXVSfbgXQRhlO+OMk2GDor5LQnVMZMo/52xhxsAI4yPmak7ejJID4zPWicXIx8GpXTAw9xlLaYmYawgg9aRnIbPeX1cfiGqr1Pf/6krhq/yMtZc+fvb2kr1ZjXYQW5S/rVH4WdT/aUvTbgwMkrebgZSI409q3NfhCVTzUxLCfk3M2CyWCBBF6t+eGn++Nr3zFZZTtaKOlJEpXcuxtYmDd9InlqKb1KtiZc7ckMV1NDHDTYxNw==
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11839.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e3712d5-4bca-4ccd-b7f2-08dbe0ce12b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2023 02:46:28.4679 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3U99pkIgNiQtt623KT2vIBHcULA1kbbeSlCKgkLJYCPS4ZQ0wvdHXc5DqnD34uP3xeUe1110ZtG56jXYBi8/K/+9MX3nCSiTdNxT4Q9mFUw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYTPR01MB10955
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] syscalls/link03: Remove this case
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

I'm sorry, I forgot to remove the settings in runtest/syscalls and.gitignore as well.

Best Regards,
Yang Xu

>I've noticed that the test objectives of link03 and link05 are very similar,
>and the description of link05's test has no relevance to the test code.
>Therefore, I think we can simply remove link03 and update the test description
>of link05 to replace link03.

>Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
>---
 >testcases/kernel/syscalls/link/link03.c | 167 ------------------------
 >1 file changed, 167 deletions(-)
 >delete mode 100644 testcases/kernel/syscalls/link/link03.c

>diff --git a/testcases/kernel/syscalls/link/link03.c b/testcases/kernel/syscalls/link/link03.c
>deleted file mode 100644
>index 1f45240ae..000000000
>--- a/testcases/kernel/syscalls/link/link03.c
>+++ /dev/null
>@@ -1,167 +0,0 @@
>-/*
>- * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
>- *  AUTHOR             : Richard Logan
>- *  CO-PILOT           : William Roske
>- * Copyright (c) 2014 Cyril Hrubis <chrubis@suse.cz>
...
>-static void cleanup(void)
>-{
>-       tst_rmdir();
>-}
>--
>2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
