Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33D5AC00140
	for <ltp@archiver.kernel.org>; Mon, 15 Aug 2022 03:18:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DFE0B3C95EF
	for <ltp@archiver.kernel.org>; Mon, 15 Aug 2022 05:18:15 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 538943C0134
 for <ltp@lists.linux.it>; Mon, 15 Aug 2022 05:18:05 +0200 (CEST)
Received: from esa20.fujitsucc.c3s2.iphmx.com (esa20.fujitsucc.c3s2.iphmx.com
 [216.71.158.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 352AB60068D
 for <ltp@lists.linux.it>; Mon, 15 Aug 2022 05:18:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1660533482; x=1692069482;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=LFSS+FTaLvQ5VpThN2fX33i5vxsXCkbo+ZI7wV06SeQ=;
 b=h9IpZ/j37f+3Sl59jJt7ojqmEaRd3ks0FRf4UyYfqj1xRiOjmJ3JTPYI
 uaI34gopfX5OyOBVKsBhItUg9jTm9EopO8BmmwmyeoaO7AQy7q/U7cCsP
 wqagB1dUkFDuU17WO0sK93rLOM5ZW08iaeKMQbN0UpEHPj6U/hoCQnMfG
 QLQ+cRZWvMgmLPWmqP0FU+w/BcrrhYjwRCYuLExrRfr13cVbWTzCLhGCt
 8cM9RLkPsfQWIGD/cdlOW/b747sG5yHe5PRi6zhNZckShp3qspJBnBKxl
 c7VEM0xy6ZVzSXnSsXF0qvBopOhP9DcfrE0UU3SAZy+1Z8OVakRlpxSj5 g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10439"; a="62643001"
X-IronPort-AV: E=Sophos;i="5.93,237,1654527600"; d="scan'208";a="62643001"
Received: from mail-tycjpn01lp2168.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.168])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Aug 2022 12:18:00 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lgv8eK7+QmBlmrshHxdsp/K7Ymc6UP2zn6v/cuUBjUnfrLXC1h27UwKJkiSSa9vqVAkRa2Fzx9+Qt+bUHaRmpscHsimkjWDnsS490M1rubnXwz7NzZYc8Uy481lJmY0wX7JEa0pvKV1Sx6CfvhjcWwHa7Ddfs5Si1jp8kypechIa981TFfT31kZ14CGp/ebjErJavrUeOVIYsY6BkDTDbuEDwdTbhXC3ScGZxQ8OAZfueBH9eLLZFIwmnQsuKPhwWGodX5jUS5Pl2I0lKqHvgncLUI9W3SO6aA+aJiupExklEk3Ajckhul6VsahQ9eq1q4xnNmGvdUnoRqLHPJ6a8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LFSS+FTaLvQ5VpThN2fX33i5vxsXCkbo+ZI7wV06SeQ=;
 b=mYbKTvZ8utj1OaBSj4nEf/jrFr2aLE39/ZO7vi27w95vLsBMf+tXNBLo38ejXXStpuxEhOcKMAVI8moynzIVbSYO8gk10wM6ox1DfQq+bUitNcNIMK6qFLqO0xuRrznrgYUe6AFrMuVy+E2GpZX+KjZeWUNCDiI2NrG4FczoRxBNrHZqXlhLB/9lI2NAysXjTigJLPHCOxbipkMUzmfjaYnaqy/xt1F+JuCuV8mgBv8gEDesVJ9asGiEvsiOdhvQ8hi4lq+vzVrcRT3Fw/huWQlibBIpch4V5kFuk6mDSnWgWZHubbsgHzo8r2EqwML+dH1nswLJfa3Jzeh/+OqQLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by TYAPR01MB6490.jpnprd01.prod.outlook.com (2603:1096:400:94::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Mon, 15 Aug
 2022 03:17:57 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::2440:60cd:7bc9:5d48]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::2440:60cd:7bc9:5d48%2]) with mapi id 15.20.5504.027; Mon, 15 Aug 2022
 03:17:57 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH v3 1/2] tst_test_macros.h: Add TST_EXP_EQ_STR
Thread-Index: AQHYrYpZODrk27bwVkGwRDio8hPe662vYSCA
Date: Mon, 15 Aug 2022 03:17:57 +0000
Message-ID: <a61939bf-d51c-6251-7c80-20b9f7465527@fujitsu.com>
References: <20220811135731.2228-1-pvorel@suse.cz>
 <20220811135731.2228-2-pvorel@suse.cz>
In-Reply-To: <20220811135731.2228-2-pvorel@suse.cz>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a1a1cf73-82fb-49da-7491-08da7e6cc067
x-ms-traffictypediagnostic: TYAPR01MB6490:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rju+3dPvd898n8m0uMxplcQfPTRMbfPkV9oLf8A6CwIna0B5Hl0AuabxM+YjIlu5SCIi+Ydrg4+tOcqNAZ8YWqlV8Wz92Fc0/UryPPqKUdVHzWrtYGRPu0B1fSyP9AXVP4sr6F9xW6VQ5p4MZqHJm52ftrIyjQ90O7NjfurPEhRL4J+t7cDsR54RT6sUdEDDagwssFZULOaMJwj5MeWqyTy4deDDipL+DLA4zQvYf5ROit3axW3Irb2z/kTw3h9Ejw+Gu5OycXaUibGeKJFItACoHFzBIKdlKlQUMPV9453pTmNsuA9ZBSebMBhRPW7WQooZ39HCV/jdxiqFhk9Ni3uLYtqrWl/ROD77ZTB3JMPN2XclNrbV8J9jsirRyXDoPZNzDfU8ssTbDQp9YG2ZjrMaTskIDRTz3l7/5hSeP5CQMNQdk192wZ7JtByV5m8zwHinloUJzMUepAFKQ2o3ciMxhtHqFYIoTSvEBDX+PoU6Z+wmpFiN79Clio++gZBYzLJDytJZQuv78ufJ8gOv5m/zi+ERn04Fqo8224pzw+A6vqgJ2aJUYPcUDxcc2P20CNAHtzCEPl1qxs8Q/DnfnUTYH8GLVacwdDiBat6ERWtjJNjrUXwm7OMftZeYQcvaK+3cFjVbznSIMeiIqId3xh/xWsgfirtXLXmMxPdHm3UNfFUYKygh1G7EnY0kYteA3RJK1FKN+hy3f9564XKvldcnxWR5jDBijGEXEfP8Vqi81skamLRXRj19YTfLqAVtKwIoSSLDrHMUwDLfvLUWwu8KU6qjzUxkeqP0PmZo88a6illgDnacCDzoCMY9nBi+DBz01Vq64/Ot4kGJ2Jh4JG0tItmAxIHFsDjekNKVJOk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(346002)(39860400002)(396003)(376002)(136003)(6486002)(4744005)(76116006)(31696002)(4326008)(2906002)(86362001)(64756008)(122000001)(8936002)(71200400001)(38100700002)(8676002)(66946007)(91956017)(5660300002)(66446008)(66476007)(1580799003)(66556008)(316002)(82960400001)(38070700005)(85182001)(6916009)(6506007)(36756003)(186003)(41300700001)(31686004)(6512007)(2616005)(478600001)(26005)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ekZHSE14U1N1cmtDUjh6ZUs0dWJadkVaSE9nVXBhcTVzYy9BbW1jMGo0a1l6?=
 =?utf-8?B?OUIrbk5OYzlYS0RlVXQvKzNkeEcvZllkQkNHUlZoak5oSE5LOHo3VjI0SmFU?=
 =?utf-8?B?QkxZSE9JOGlCOVkwbGU2WkhkMHhLYzVUK2tZUDIxMk1pU25KMkplNW92QStr?=
 =?utf-8?B?L3E1STVBSW51RWZTTXVjU3pDNUhQNzQ1cVlGL2Q3Q1IzY0dWV2dXY3pTVDl0?=
 =?utf-8?B?WUFzSDlFZVlrdS9qczVsRE5kU1dwbjZOYU9vVENpa2loMHNyNGs0THY3RDA0?=
 =?utf-8?B?UmVuY3g5K2tUK0VUTnZ0L1h3QSszRWtTTjV3NC9hYVJEYWkxNFdBai9IcU5L?=
 =?utf-8?B?N3JncUEyMnZJc05mNDhORkNaS2JwWFZMSUlFZ1lLT2JGMEovb0RycGZSQ2hZ?=
 =?utf-8?B?eE9JZDh6bHEya2dJbzNLS3RtSUY5UWpiRUt6R29sN2hRenRDaVlWa1Y4L2dJ?=
 =?utf-8?B?NlVYbHQ3cnNpYllaVXVXRUYwNWhYTlR6citOMlhBNStpOGFMRmlQQWR3b1Ez?=
 =?utf-8?B?Yy9WdTFSMDJZaUJKYzdObG9JNU4vNHNZOUJjdFB1QjE1Wmx6YTVLQkZKdnB1?=
 =?utf-8?B?Q1ZYZFpiL0lYMGRYR3NjbHdVM1JoVDd6NFV6T1Nlb0d2SFlubzJzbFY0Zzd3?=
 =?utf-8?B?OWd2S1dsK1pma2ZCdDM3RXlzOWVDTWhUUFNKb3MyanJxT1NGZmJid1lNOEtL?=
 =?utf-8?B?RHNUU3AyTUQ0MVdvd0p5R2ZVcVZ3eVJvRk5jd1FLYTNvWWxTeXNXM3BXT0xU?=
 =?utf-8?B?a1dvaEh0cmJMRFUvUGpVSmduM3Mxc2pLRlFFWGVMK0pWS1pHRWlDbnZmTGN0?=
 =?utf-8?B?WDFvOGw2aWdPUG1GZ2NqN3Y4NTVDUy95OXhPa3ovaTZhbXZadmxTY3QxSHd2?=
 =?utf-8?B?azhHSGFTN3pWOWZZcUZqNnE0VkNNdWwyUWgvRFRCUDlHMkZ6Q2YxZlhWTFJo?=
 =?utf-8?B?WUd5a3FGUlNkb1NROUpIOFhaUEoyVHRWNHJ6RDgzS2luRmRiUmt4NWduRWVv?=
 =?utf-8?B?eVlUOE5ZQjFkT1lEc1NyVENDeUZUbmtLNVZFM0JQNGxFTXA0VURpb1VuWmtr?=
 =?utf-8?B?VVRNWnZib1pWdHBFYVBYN01FWitmT0ZXaTlGN0FYTlpSMHNjaFNtbEo0OVd6?=
 =?utf-8?B?RkNvdVRPaHM1U1ZuVmFvRVM2ZXc3bjViUGZZVmt4Y0RFWXozcjcwZmd2b2Uw?=
 =?utf-8?B?MkNIMkJ4NVpZc2RldFlra05NSno4VTZjYzl4eDIzemdyaUFiMUVrRkV2SnMv?=
 =?utf-8?B?aTVCRUpGQ0lYdTJCK2QvSzRpVVYyUWN5QUlSNTBzRVp1SkNrTWxvTzQyZEk2?=
 =?utf-8?B?bnN0d3BieXFjQzY3bjc1NkRCZmhkaHM0RFlYc3g1ZDZWRmtEWkh4YzNyRWtz?=
 =?utf-8?B?WlVXdjRlZ1ZxNkJIL1Jhb2lRYldyZCtlSGR4amZPamxtb3hQczZYbWRMT1p1?=
 =?utf-8?B?QS8zclRVKzFweUhpZUdqTENyUzM1RytuU0RFK2s3U3l6QTd6WmRlR2cwbEEy?=
 =?utf-8?B?QnJaaHZLSkZ2c1ljNUpkcnYycXlzNnh5bFFxYnl4RzEyWkJ3MWlQYW5rbnI0?=
 =?utf-8?B?QlZObFhzL1V4SENVR2RvaER2K1ZRTmhpRHpYMXNnTVh3ajZtOEU5RnlZM2FK?=
 =?utf-8?B?cmZGdVI2MENqVENiWk9oZ1lVazBSOEFvNXJaZmpNV2VsT1hXQlZaKzdKcGJR?=
 =?utf-8?B?OUJ4NE5WWTRlMHFSZTMwcXlTM3RFalRUNXJpd1A5TnFzT3ZFNnJtK2dWUllK?=
 =?utf-8?B?VTJCK3d3UlRTb0htZmRUN0V5K3BHejBFVlpYajk0VGJHV0dXRkV4TFFwWnps?=
 =?utf-8?B?ZnYxTzlFQmVENDIyUTZhbUNPZm9VWk4vdURCQVdWV3oyRDk5dEkyUnRlRUpM?=
 =?utf-8?B?WWVZRzI1M25DZjF6YTlncGFNQ0x3REpRWlZMTXVWNXRRTVFLMHk3WktyQVZw?=
 =?utf-8?B?RitPWC9WNHdNN2cwNDh0ckxMNThmOWpSbGZJOTlucDJZRldPbEtxcjVEcTlz?=
 =?utf-8?B?STZhUzFXSFpvTVhoWWhnUHhMVUNWNzNEdlc1R0ZYYTUxL280ZGU0RE9CNGxD?=
 =?utf-8?B?TVBjMnJyYnA1aFVVYkdnUUtwRTNyWnhHUlV6Q0JOcWVQOUVuMUZTM1ZUMit5?=
 =?utf-8?B?aHBaeWMvKzFuRG1ZNC9HRjR4L29WU3Z6bmJRbDhrbElQeE9ZN0ZzSVFaVk9O?=
 =?utf-8?B?YWc9PQ==?=
Content-ID: <769F8FB03782B5498581028568241918@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ycWkbd8a/wdmtGMiWXykacrM/FUK0M96jYG8ttMiUFuA/wFj9Qf//SWNczDAshbNi/goI/zHY/XuOv42D7HMBLEb8aGUKDNqHH88kyJf6Rtq11Jf8vN2KVzZSa/O4d2fSx9sb1o5IU1Hpgi1+XPAeV2N+jnviU8L6C5ci3XRPnd25riphj7hzfhFLy+I5yXd7wDNvPKC1aMNBVfuEQ/CV80BBpGhdn2e0FUzDNZWB7dhHmUwJ/gT0rozo6RMccardvDHPHiuryml8riJ/uPjU4ki0e+mvvbkxOc61CjC/aRNt3tC/47v+IJk3wwcCy3Xnh8ioQm3Os/6PcjnYjetm+Ng1sOUJwmV09fp9hz9EUrCdu4L5qS0fahXL2U328U3dFa6U6R9Hdy8grZSO/kO5kxL62iZYlsijeI6qHm+vVYCw1Yjb60je3weYnHZJ0ASJsO4B7au2HwCO6OMU8dNd+cDCBdIUtLYF5rUV/S92dUTHqBaC3h0HRfYvi83MmRmMmYXWhQ+qMjisPaj4+qvFmpGttPEblo6d3KI1t5wQb1i0F0FCcoX653XoWtolmHzjB883sxCntbt69E4x9M/u5q+dt+EB5qcIwHHvjCfU8ncSGRi45nJeGd3WFQV1rm/ipksonaqj/aSaj1cIkQ8mPWyjnz2AT5kpVL59WGylJa11G9WfXvP9VIoI9mEFXJAlxFQIEPJfNoDuU+s1VhUO0rrIrn8ik045BSkLLLxmVYEy/GjLbQYthJz0ZfgCALD
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1a1cf73-82fb-49da-7491-08da7e6cc067
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2022 03:17:57.5763 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WZnqWnLOV6VZWppf9vfJr1q9en0eB4JCEqtFlCyN48oQVRSJrkC9lcTUx/CnSmuvkfogPO3MS20vBYUpqfY1FETXO507jSxK6PcDGrdIM+A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB6490
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/2] tst_test_macros.h: Add TST_EXP_EQ_STR
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr

Looks good to me,
Reviewed-by: Yang Xu <xuyang2018.jy@fujitsu.com>

Best Regards
Yang Xu
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> new in v3
> 
>   include/tst_test_macros.h | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/include/tst_test_macros.h b/include/tst_test_macros.h
> index c8f7825c4..8cc959243 100644
> --- a/include/tst_test_macros.h
> +++ b/include/tst_test_macros.h
> @@ -242,4 +242,14 @@ extern void *TST_RET_PTR;
>   #define TST_EXP_EQ_SSZ(VAL_A, VAL_B) \
>   		TST_EXP_EQ_(VAL_A, #VAL_A, VAL_B, #VAL_B, ssize_t, "%zi")
>   
> +#define TST_EXP_EQ_STR(STR_A, STR_B) do {\
> +	if (strcmp(STR_A, STR_B)) { \
> +		tst_res_(__FILE__, __LINE__, TFAIL, \
> +			"'%s' != '%s'", STR_A, STR_B); \
> +	} else { \
> +		tst_res_(__FILE__, __LINE__, TPASS, \
> +			"'%s' == '%s'", STR_A, STR_B); \
> +	} \
> +} while (0)
> +
>   #endif	/* TST_TEST_MACROS_H__ */

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
