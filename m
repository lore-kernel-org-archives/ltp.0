Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68A6EC433F5
	for <ltp@archiver.kernel.org>; Mon, 13 Dec 2021 09:09:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6127E3C8997
	for <ltp@archiver.kernel.org>; Mon, 13 Dec 2021 10:09:25 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 97F043C136F
 for <ltp@lists.linux.it>; Mon, 13 Dec 2021 10:09:15 +0100 (CET)
Received: from esa20.fujitsucc.c3s2.iphmx.com (esa20.fujitsucc.c3s2.iphmx.com
 [216.71.158.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 4A891600211
 for <ltp@lists.linux.it>; Mon, 13 Dec 2021 10:09:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1639386555; x=1670922555;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=JhVqiA4ernrcwVgWxM3dcXOFU8//y1/Iqjbtgk5OtFY=;
 b=KS53uyuFijJwDwM4zSNhPVgoPbpPJ8mrbu4p0wu63f78LgiK5i1r4x5E
 KvNV+4pK/3wlqQZ7Sf9EL2PLv+m7SLzNtF8DQmlj7OPFY8hVz6E34ASW0
 4SGQ8nE37HxgYaedJlqye/ObJGA6fazfaC93G+a///xkJJByEdWhKAzIR
 JOkY7J4aURlG6HI1SrkGYOaJ1CgLsI/SEyRktYslgjzQUOuyzx6zvZxtH
 Ne6sgA2WBxIlA2DVEbyP4pjW0rl9FMVscngIAUri4tDPu/CabuUr0CJ76
 iHusk1tMlvBh7+i9Z1n2UuLAKH32erQb+OlmFUgLaHdnuv6pzHPMqe3vc g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10196"; a="45720260"
X-IronPort-AV: E=Sophos;i="5.88,202,1635174000"; d="scan'208";a="45720260"
Received: from mail-tycjpn01lp2168.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.168])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Dec 2021 18:09:13 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=go6lkFveR6oqq3A9S1IZ7oH/ryc5JnQD1Sb7z2makiR2htCokSgYg3Rv+JG86QdsiTFn24y3BOeO2DSEB1c/ctZwpEAUeEtRSChH3u5Wgt5OaRkBevwRPjCLP6v//kTIu4kVrWsfhyN7Xxf2UQc/iV8fpVF28LaxwTgQ0Q0Ml3QABcpHklT+7cO+aA6fC1h4IC1THnVvNaHHAhGQAfCu4KtqEg1fYjtpMQxILTWpx/5DXt/nWi6DKnNKbORhBkZs/BtePtZZ67OcWWgwlfpvRWxyrVj2O7j/wv360ChzCl+k70KBTljpdPTaxfgh+MVRbXeOR1spw9qDXY3vg4IYSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JhVqiA4ernrcwVgWxM3dcXOFU8//y1/Iqjbtgk5OtFY=;
 b=iEqNehLccatxWH3uA+Q15YWRQnAVkCX2prRPqJbyvE5DbXZjZxRd2h77fAbrGPfF2S1qVE88ls9DdxlbLwvLyg+1xjINGughrlW6N3fFZ5JiRbhRcor16W/xSRf5iljjcqooaxIz+3gdYm7dW51FQWHjZ5Lrg3lXTeBx9RRj0QglVRScP0UXF3WfT3YYeTvNvfhyLEickmh9IV9b20XohnYPBOwMlHBFUyyTsl2G+fyI9cQkCORG5f+ZXcggni1Ynd5SFHltkBP/3tTBPwms4xa4ml8ViG+3Ld0HBUiSw34SlmnPoLaDy1b0174oeNWL+uLBgHCavqp0Y14tAFZ94A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JhVqiA4ernrcwVgWxM3dcXOFU8//y1/Iqjbtgk5OtFY=;
 b=NS3v8LqUGI/883OauK29wK9PTNPOJJUw240WNvfvqDxhrb3g53TRvTk19Q2nNbDrirp76MM3p+XUW6NuZwTP56eADKZKX3zcSO5GDKqD20DgFTzGaTGuTnlUEuLq/XvTAXPAW9esQ4wY1XwkRPtY1a0ACDeCMypuqThn0JQD90c=
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com (2603:1096:400:98::6)
 by TYAPR01MB6009.jpnprd01.prod.outlook.com (2603:1096:402:37::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.16; Mon, 13 Dec
 2021 09:09:09 +0000
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::4997:e3e6:6502:9100]) by TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::4997:e3e6:6502:9100%9]) with mapi id 15.20.4778.017; Mon, 13 Dec 2021
 09:09:09 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Cyril Hrubis <chrubis@suse.cz>
Thread-Topic: [LTP] [PATCH 1/1] doc/maintainer: Add policy for new
 functionality
Thread-Index: AQHX7cxL3/vKL+jM9UKzrOykb1Qn76wwGWcAgAAMRYCAAAEdAA==
Date: Mon, 13 Dec 2021 09:09:09 +0000
Message-ID: <61B70DE2.4040402@fujitsu.com>
References: <20211210134556.26091-1-pvorel@suse.cz> <87tufcao8l.fsf@suse.de>
 <YbcM8xKx7G0KQxWU@yuki>
In-Reply-To: <YbcM8xKx7G0KQxWU@yuki>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f2ab2650-5c77-4bf5-acbb-08d9be183922
x-ms-traffictypediagnostic: TYAPR01MB6009:EE_
x-microsoft-antispam-prvs: <TYAPR01MB600900851FBFBEFAB6D5A257FD749@TYAPR01MB6009.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AZwNlWDFzVuKPH1vjgOsSoCP3F3Jf/r0Vwve7BOV/34bZCqUQIz9t73BnyQ5Ymt4coPEYk7lVCJtMwYA9dDvYxIITwis5iyvhzmVNPJ1IPs9b3dYtuwt3lAnbP9Zv/3a675VoAs+xSdzozGDzcFa7wNwbmZxA/SqCiOz5jV9h5R8mJm4DZodEzSF13+zh+yPzf3IxiiXRHpZ3kTrbRZ+FqMTzTr4YV+P4OUauLgwdHtMtuJ+HmXJPdSnuUnOC8t4OUb+WK/aLByIyRp744znaj36sKvVz5StWUeax14NzEzQNd24mNKPPcoM3MyhUOj9f4rhOcLygGDojbU0PVBNvaotrBtPtTqCSDJYoc1AhgUOkI+Ny2pSZirR4Cl0FRLqtlyrSWKXtDgUCB5oyu+CFYdv239ql5cnWcdVENxlj1jrP5DROc2C1Q9y0yh9jpx97wCwM8LAsBnTUaGFAxxy1S8QwGqHc9aLCx9vRu4lsWE05RLDcGlnN7yfi7ghiHbqJpbQxWV3jKFByi05Jj/SM+TyPOEhMj9660TvBaEYmpmCNNAT7uqBgc8MzyaogJUnRYe6ubF4pA/ORKhKGK31bvlD2pdom8VWOomM0STlPzpMmD6aKbSsY0NrehHDqavM7k8zO91O0ePwOmO07LituCoHLKtGWMd6IkpUqn1Vp9mYcduZDcE3T2TIoGESFPlBIg40TvnEbhu2UMiZl5R1IA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB6544.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2906002)(8676002)(316002)(38070700005)(26005)(6506007)(66946007)(64756008)(86362001)(85182001)(8936002)(6486002)(54906003)(36756003)(6512007)(6916009)(66476007)(122000001)(83380400001)(186003)(66446008)(82960400001)(91956017)(76116006)(66556008)(5660300002)(33656002)(508600001)(38100700002)(87266011)(4326008)(71200400001)(2616005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?a0ttSmswYkJyNk5rR2l2Z2pMMzYvOUtsbnBLQ1N6b2loKzYxNzhVOHcxNGtS?=
 =?gb2312?B?eVMvY3B0ejY2OHF6Z1pHRVgzZmd2SDJZMDFnaDRwM0dibGZEZDZ3YmdkSC9E?=
 =?gb2312?B?K1BScmt3YkcwdjBkSC9PaXJiNnlERS9uSXZER2VWdDNCMEh0ejMxclU3SGhZ?=
 =?gb2312?B?OERneVV5MzA0Mk9vOFhoODV2Vm04cFZFTDZGdzZXeVBXZFJFSDBTc3p1OHBP?=
 =?gb2312?B?VWVZZlZOLzZBVHFyamFDdG41RTZNUlluR1l2eXhBMlE3dHB4aE1RMkZMblRv?=
 =?gb2312?B?MjgvL1JZeFc2em1aRklKRkFtV012OEJ3RzZmZmxtTFhhU2Zid1FPaVpjR3Jq?=
 =?gb2312?B?YVpLQnZ1OFJzRmJES1VDNmQ4UUhxVGYvaWpyY2NKVTYzOUYxUXdFM2U4NThx?=
 =?gb2312?B?TTY5Q3ladzFOT0U1TXNpTFRnbll2RkNndm1JLzRqVHN4SUFGSTZ3bUNSNUFG?=
 =?gb2312?B?VVZGQmJJai84Qk9TRkxCNVNTeEF3MTd1emdHR2ZWOGtVNVVSRHBTaEJQckps?=
 =?gb2312?B?eEdoRU04d1FLbHpxNDhNTjFsVVhVODNickZIM0pqd3J5M05JZ1ZZTXBidU1j?=
 =?gb2312?B?RUNFaHNhUS9xbnVvVEZFMDluQXUzTVRiMDc5c1VmTlVQbWFhNVg0cjB1QjVj?=
 =?gb2312?B?T0dDUll2WGZEMXBmRVBSeUZBa2RsQ0h2WTVVL3J3SGtPcU5FOUJJQWdNb2Fr?=
 =?gb2312?B?UGVQNUFtclNTakdxNC9XUDJxS21NOExBNXNpd0xyZzNocU81SmlkQzhYL1Vx?=
 =?gb2312?B?dG9xTHVRNWFmWUNrTjlNdDhCRFRrSmE5aFhmVnlWR0xVdkFObHhvVnU5Q2lF?=
 =?gb2312?B?eWRyenJrTW8vam0rSUpLUllLWHFQM3FaOHM2UUtUT3FGVndRSTZLT0RuemdC?=
 =?gb2312?B?UU5tbHJLT01JMFJud0pFckVZaTBDN2laL21YZG41NGVjcXBBZWlQS3lpU3pD?=
 =?gb2312?B?YzhQLzNodE5RM3NiREViM2NabXdXcFYwU3o1WlN6d3JjUlZlV1JHU1BtVVNu?=
 =?gb2312?B?dEN4V01sWTFYZGpacUVpYVAzK0VGdjdmd1dEOW1qTVJiZWdPc0VBa0wrRnJ5?=
 =?gb2312?B?VW1UZjJyS1NqWGxnd0RCdEJYNnFZVTl3MWQ4Rm9iWWVvNlhXRncwL1NTQmxj?=
 =?gb2312?B?L3ZsTUszMUhQZy9BTFJvUU90TE9aYkx0RFd3SW9LVnE4c251cUJ6LzM3Yi9E?=
 =?gb2312?B?d1BFOFYybHZWZi9yeGhlaDNmZ0NNY2ZRUnQ5ZUpxQ3Z0SytZaVBZUDZIMnZq?=
 =?gb2312?B?OW5rMzNyWkdXWFVOK3R0NmNmREJCQWswRFhFaElDb0RUbXE0OUFmQnluVnlj?=
 =?gb2312?B?d2xpTkV0UTd6Zm51bTl5cDV6U3dFN0VtTWw2UUdGZ1JwWE9oY2Z6ZHlPOWcv?=
 =?gb2312?B?Qk5HZ1dBVzh0OUN4Smt4Z04weTBCVHJPQjFXRXlyVnNVL0xjTzZNaXZGVWh3?=
 =?gb2312?B?ZmNWd0FwL0oyZEZQd2tQWk45bnhjQnFIdkRXV00yTFJ2NC9KSGU3WmJib2Jx?=
 =?gb2312?B?cmQ0ZWtoRXk0SHFNWHlVN2R1bnNScU1TNHVVS20xWXpnMDdnTTFSUkRhTGZm?=
 =?gb2312?B?R3AvMlRDVUtReG5NWmpnVk9JeWltYjR0dmwyVm5hTW9lSGttQ3VCb2FaY00r?=
 =?gb2312?B?NFdvcnNmLzgwSkhIVmxDUlVRRVZuTWJZeXJWK2N4QTNIWmJMZ3R5VEdxSW1L?=
 =?gb2312?B?Z1d0K3FZQm1KSDBqVDh4WFVpOE90ZXg2d1RBSXg3MjdHZ3hUZnZreUJiSGRD?=
 =?gb2312?B?OFNLZXp4aVBPUDkyaisrTDRXbVF5UEZEUVhRNk00cmZ4R2NUUnJPYXdoRVZJ?=
 =?gb2312?B?QXdCNkVuN09XWUJvMzhQK04rc0czZDRiL1ZYMExUNSszMFBBbHpkT00xWWln?=
 =?gb2312?B?SEM2dnp4d1E4RUlnWVJkdEdpZHlRMEJpWjZrYkhaZm4yaTV5SS9KS0JQVC9W?=
 =?gb2312?B?Q08xMHFncWZNeW5kNGNsbWpXYkpFT0VtZlhJNk84UDVCRjN2ZjgvRDZ4Rldz?=
 =?gb2312?B?ZEU0QlFGK2hRN0NJSklOc3NZUGlQQUY2NHVrblJmN0gvVHdvL0F0MGd3TWVs?=
 =?gb2312?B?dkFwd29ENFBLQVNVNTlFdU91ejZqL1hiU00rNElNaGJzcThhbm1NWDJ1Q2pO?=
 =?gb2312?B?d3VNaU5uQzNHOW5Kc1BsdC9VditLQ0Q5THY2cTE4aFhPOEZpc1lDYTY0SDh1?=
 =?gb2312?B?OFMxWHBLLzkyZHkxdG11Rkx5S2F1ZkRWS2c2VEVGdUlFR3hLZytxT3ZGQ0du?=
 =?gb2312?Q?yni4zPBz3pp6ludUo0pvWiv87Y4HTIdNOi6ya+Cm1c=3D?=
Content-ID: <0D6284A1C1FCCC49AAB5E9635C49448C@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6544.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2ab2650-5c77-4bf5-acbb-08d9be183922
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2021 09:09:09.5537 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r0NHYKHFuP4XT3kWEQBaPVdNEH/4gj+7sZm14/5/FjdZVaqa88F4W3m9hT7+TKyPcOBBjCWuJRFJrtjomKvnmHjCo0iK9SDBIOfwvuZUvKo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB6009
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] doc/maintainer: Add policy for new
 functionality
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

Hi!
> Hi!
>>> +* Tests for new functionality in mainline kernel should be merged after final
>>> +  release of kernel which contains that functionality (it's not enough when the
>>> +  feature gets into rc1, because it can be reverted in later rc if
>>> problematic).
>>
>> What is the concern? All I can see is that we merge a test which is for
>> a feature that is never included
>
> Not only that, the interface may change subtly.
>
>> The issue is we may forget to merge patch sets for features which are
>> included (a far worse result). It's more stuff waiting around in the
>> queue. At the least we should have a procedure for tracking them (like
>> tagging github issues for review at each mainline release).
>>
>> If a test requires a kernel config which doesn't exist in mainline we
>> could also look for that automatically.
>
> The main issue is that if we happen to release LTP meanwhile with a test
> for a syscall that didn't get included in the mainline in the end we
> have released LTP that is supposed to be stable and the test will start
> to fail when the syscall number is allocated for something else which
> will happen sooner or later.
I know a example that is quotactl_path syscall.
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
