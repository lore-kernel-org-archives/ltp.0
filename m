Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85F78C4332F
	for <ltp@archiver.kernel.org>; Wed, 12 Oct 2022 01:33:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E65F23CAEC8
	for <ltp@archiver.kernel.org>; Wed, 12 Oct 2022 03:33:50 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 76CE33C3030
 for <ltp@lists.linux.it>; Wed, 12 Oct 2022 03:33:38 +0200 (CEST)
Received: from esa14.fujitsucc.c3s2.iphmx.com (esa14.fujitsucc.c3s2.iphmx.com
 [68.232.156.101])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id DD0481A0080C
 for <ltp@lists.linux.it>; Wed, 12 Oct 2022 03:33:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1665538417; x=1697074417;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-id:content-transfer-encoding:mime-version;
 bh=2tJenwjpi+MIGqRJmdHSKAU2cZNTn9AIsKnMIWEws6k=;
 b=Yf7MwPe8vTyQXuUNtrd6JGgyQ0UhzBFw7MSYvPaQ+UbZgRntP2j/wlmZ
 BnP1l4wCJwd9No1PYcvBEHFbCxOAyQJXmzB3NZv6eE3mpIxSOCzM5qJei
 6L0Ry8jbiPTTfxIOYcfXpoTfFCaiWkm8AEMgSmbsfak7949PxLdz1J5oF
 xnIGyhX8FO6ilfiMuGo+PKVioNkk+CjF+KXYO/PdCd8ajvN78egmj0OpU
 aBmAUdBzA6uE18DBij+D92gJ0SXmPxv8JMt/r8FoVJwlWBZ1VeN8qzXeM
 8/C+9DRXrvr66qUSwncupWC0WXpMCTQRk5dpPHuRHDL/NGHGKSSbYq6cO g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10497"; a="67047830"
X-IronPort-AV: E=Sophos;i="5.95,177,1661785200"; d="scan'208";a="67047830"
Received: from mail-os0jpn01lp2105.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.105])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2022 10:33:33 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WpHemayLWvDX0FbIRSedmF0x9g00liy9ZBiDQklscjlXcLAnjqmmzr6u1Pk0/LdLg2mCMBgOZ7nqeEKgAwBQJ4os26Rt6VIlcjk9EEWWff+lBGQLV1tOeljk8BmTAnssjpmi9R9qYKCoFZYdnQM1xgIxXKpMql1VEk6yaJK/sle5u3Hwx0KTnGCu/PenBraMqmsj7EmXzK8R58C5MkMqJZXkLGKOtwELJv1LS9vgZJob8xCaKRHumGwt7tgypasAjjWDuojDuczav4dtQW7AvoBNO8nASg1UWHWEDdjXxng3W/ZOZFcqtRQv6lo3ldNMD9x2oJmVWsbbudUq3+P0AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2tJenwjpi+MIGqRJmdHSKAU2cZNTn9AIsKnMIWEws6k=;
 b=hUhGQQi/np5TDVU8zDY753v0MpTVSP77uNOxs74S4/tqomWmNh1dpvzLBf4TiL8lRSZtbcfyEu/Cxho9AAqR0m/rAy4BJcvqmhEQdU5g3swO1duPyeBprJ5adJ+9Wc1WYt3uWOIu2a0wGV3u30BXmHXeFYdcj5kbcT5HG3sxFF4FtQQQsZFjW41IYbcHXMLSLNKfY6+agdvGd3R1q3kXyKhmRWi4sQx/53qLTyzSBQVtzXs4TX3lX6shhtEwK6kUFG4XHB1pGlaS1e7fGEbr+ir9whPW+iJsPv+Mwh3KqhElelhekz2IVIp1USJcb9sY8yGPUJRmBJiioCyvwJqtyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by OS3PR01MB8635.jpnprd01.prod.outlook.com (2603:1096:604:19b::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Wed, 12 Oct
 2022 01:33:29 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::c4fe:de8c:66e8:5c93]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::c4fe:de8c:66e8:5c93%6]) with mapi id 15.20.5709.021; Wed, 12 Oct 2022
 01:33:29 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Zhao Gongyi <zhaogongyi@huawei.com>, "ltp@lists.linux.it"
 <ltp@lists.linux.it>
Thread-Topic: [LTP][PATCH v2] syscalls/add_key05: Add userdel and groupdel
 before useradd
Thread-Index: AQHY3XAAYwJVLboC3U2sgsP+HbfAnq4KC1UA
Date: Wed, 12 Oct 2022 01:33:29 +0000
Message-ID: <f5314f7d-7018-70e8-6d56-6b7d4be850c2@fujitsu.com>
References: <20221011124630.62647-1-zhaogongyi@huawei.com>
In-Reply-To: <20221011124630.62647-1-zhaogongyi@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB4427:EE_|OS3PR01MB8635:EE_
x-ms-office365-filtering-correlation-id: b795aabb-050b-416c-cee1-08daabf1c422
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0sopnH/TAl9jM9aolRGBtHGGkYMy4+MbPs8yWfDMXXhpzvqBjU4PFYAuevK+s7+wWy9u0yG+DF35WYU71oQJwZ1peWFuVW2ock2ru1KcclRK8wfIWmkJyW8nWRDgRXfby9vpbe5D7MfAVdi0kHVV8RIDceUev+qZDNCLm2K8cfhaGqC/lLH72qzxi72RXLJPNrFRt/mDP+IqgWJLsG1eyWsv7sFHXXi5QF8nh55V+zor8pSVxgvY4VXiWLyLniC+VSXNlq9Xj/wBPCXB98RX9157Qkf+QRBjpBtu9QLlxv+xZL/eGVMrEWkwwvkH5QVdCVzmT8jSNNpXaR7V8YIWmLKdsveBQ/Q0KzlyP9C4Go2rrZTXE0uYHWoZAcAwfJXJlh2UAB6mcgBgEJmL8nmwR25MFgUwzR69TYYRIWLYQJPwu1qQN+fQT8/tX4epFTg0x8W4uwMzeGN7n2txqzK/YrHjhE1H1BM5Jog5HJx7i/POwckOyg2GeXYJYSF6UbBKxFlMzmSVE+wxhic7YqHlVfJvsiKi2DuTOJ/luw9nA7hOoDn0+sBArKNnAlmjFO/PGfKWB1Qk2gEqniqW3XDnG5ZpfY0xAoPdteL0C21aBzkHMIbm4J3jm4USmgAXc1jb8AamX4EOQztYarU784aYYmO8VD9TP9szlfhQ5wLxK1FXaMg6J/16ZZsxmrsW8BdvFL3Nv0ym31sf2GE02V3BXNOJmKkNgzHyyTj99oKglBaVndMDTM6GlKC0XQ8X9P4PB0sIWs6jeq4SLDEQX8U9mBZA+zV18wQfTtb0XwpTOsHliEGi4mzD1EhUQGpAm7h8AQRJ9jCFvikW/Ch8A4KCiw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(136003)(396003)(39860400002)(346002)(376002)(1590799012)(451199015)(1580799009)(66476007)(66556008)(6506007)(76116006)(6512007)(26005)(66946007)(31686004)(66446008)(8676002)(64756008)(91956017)(8936002)(41300700001)(85182001)(36756003)(122000001)(478600001)(316002)(2616005)(110136005)(38100700002)(38070700005)(31696002)(186003)(86362001)(5660300002)(6486002)(82960400001)(71200400001)(2906002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aENCako4Z3pyK3dobVdtSnF2WUJxMXZjRDRJQkFxc3J3NUlMbGtaK08rdHpk?=
 =?utf-8?B?TlJuN1g2MDZaRmxUTVJYcE5WdE5Wc2IwdlM5bWVsUHU0aHlaaGsrWEYxTm1a?=
 =?utf-8?B?alNHQ1lqR2NFVzF5NHJ0aUdPMElid1NObnlJT1UzcGd1RFBLbmF2SEtib3NP?=
 =?utf-8?B?ME1BOS9mMUo0VEFYT2dCcjdFNWNzU0lkU3ZmcE95UTBhdzRRWkd6Zngrb3Bh?=
 =?utf-8?B?L1AyVGVMaXBjR3ZYd0hIYWlTalZLcFZhSlU5TW1ndHJDaGZmUFZRRTlYYWVz?=
 =?utf-8?B?bjJUbU96MGpybDNYcENUVnpzS3FQUHV4TGNwVHl4ZkFlRTdNb3FjVEhKOS8w?=
 =?utf-8?B?M2IyYnZkSElKMWZUbGpXNlpDa3JadHpFMmwyQzF5TkpCcXJ3WkRQYkU4OCtu?=
 =?utf-8?B?cVpIS0hRanRGSE1TVTh4UWVFZEFBd1NmMGdoSm55UnJWb1JYbkhUMUtzanVy?=
 =?utf-8?B?Q3BXVlJnOW9ENlhubEN0cTlQWDBqS0QrZG81MXVHN3AwRVRmbUZNUzFSNmV4?=
 =?utf-8?B?RFpKVW1qb01FYTdXL3RFQmZ5VHFNWWdDWWJzbk9FNXpud0U1Yjdlb0VLRWx6?=
 =?utf-8?B?VlZ3SDhSUTYwN3g4a08yV1h2cCtiNE1IaXVDVENReGFSTlZuYm11bGhLUm05?=
 =?utf-8?B?TGF2THk2UlJCSHlKVUtlM2dBbEZ2VVprNkpyZ2JlZURvN1FDWGEyNDRhSlh5?=
 =?utf-8?B?V1pFc1gwa1VNc1NrOHZWTFp2L29JWklNRlhLVGpiNjlYMWY3a2xoUnFSRVBt?=
 =?utf-8?B?b3pPemNJQlZ4SzNSdTN0SEp2cHFsVlc0SjJZRnBtNUFUUEZQaCtzOW1Pa2dr?=
 =?utf-8?B?NW9DQ0R2aUVldGlrazdQVk0yeGJmMEFVRjJLUjNiMTJCc0JFQkRhWWgxWHJ3?=
 =?utf-8?B?VXJjckNsdTFJUkhKY3ZTUDdibGpJUU9nd2RNWURuZFVmNlZTY3BCU0IwbCtY?=
 =?utf-8?B?VUtzaGQ5ZUhUbW1MY0Z5Q09GSThVYkg4WitQbzJ0clZrZ2tLYkhaVTlkWnd1?=
 =?utf-8?B?NGhPYVk2em92c3E1bFNWdHAxS3pHT1IxZTJsS3ZVSzBkWDVkTWdhdFZ4dWF2?=
 =?utf-8?B?SUpja3dROGVkckZ3YnBEN1krczAyaFhKUE9NNzdKck1UOGRjb0pIMk40cExF?=
 =?utf-8?B?U2V0U0pNWTdBY1F6U3lPa3JBZzJWY09nWld0bEpVSC84YS92dXAwSTBuaUZM?=
 =?utf-8?B?K2hva3huL0xMNzdncTJmOVQ5bVEwb0VZRGF5dWJ4RWNMY09XWklaeU5NOWUw?=
 =?utf-8?B?MVExNkgvNXBnSENvZG1MbUdnUjZ4T2x6akVINWQ0anRXdHNQSWdLWlV5c3J3?=
 =?utf-8?B?ZWlsVEVjU0FncDNCQkFhajNibjg1QmlkQXllMmdjVWhBOE40UG55Yk9sZkV6?=
 =?utf-8?B?NzJGYXAvcGJWQ3pJMTNheTJncW1KOTRBazVKREFFTCsycVpUUTM1cHU3b3Nm?=
 =?utf-8?B?QkhhdmJydmc5bDMxU3NmYTEzWHRxZEpaWDU3U1pWTkN5SkhMQXdETm9HdVNP?=
 =?utf-8?B?aTEzSDF5THNVbitHR3d5M2FEUitGNVJjazhjQ1hmSFc4cFRRT2UxT3RUMzF6?=
 =?utf-8?B?c2Vjdk0xWjFUQVQrMlI4U1BYWDlzL3p3QXB4amRjTzU4Q0xuWWVmY1MzRTNj?=
 =?utf-8?B?QzR5dkFQQ1VLbWRtZHk5QTFDT20ra3BqY3lGVjcyZnNiWkRKUmJYaUJuM0tQ?=
 =?utf-8?B?ZDdKL01Ub0dIbHVZQlFZMTk3aTIrcG9WeFgvenpxaU9Pby9QQ2NtUzJoaVZX?=
 =?utf-8?B?dy9kbkdPNFUwcSt4T2VrQ3RhYWhROG50d2ttRkZocHFIRkRkekV3VEdWWjc4?=
 =?utf-8?B?ekNsRmNqa21CTERCaDJTU2FNblIyenB5cDI2NzZDZlZXSE1CeHJid2hhcEoz?=
 =?utf-8?B?dm82d1lUOFJGR1lLY3dKMThnblpsNElpR1puOHNYRWVSQWJJRVlqbmx6bkc1?=
 =?utf-8?B?Z1FSTk5HZnFUR2traDl2a2h1MHBFeU9oVkpoeS9ZOGpCYXM1RzFXN2J6M2NS?=
 =?utf-8?B?OTdnMkMxRDExQ2NqcU1kZmJEUmo4Yzd6c09ZZENGcVZlZ3JyWmdJbzNrSkdu?=
 =?utf-8?B?YVJGSUNTM0FhK3R6VjZOM0hFMFVNcWR4WWxnYmo0aFNTQmlvenVPQmtvekNu?=
 =?utf-8?B?WFdwZWxRWTlzaUJmVEVCZWRreDRQOElIQWJrMGg0d1dSSU5FL0dmWmw3dDE5?=
 =?utf-8?B?emc9PQ==?=
Content-ID: <469B8099D9542748A0BE0665662B8118@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b795aabb-050b-416c-cee1-08daabf1c422
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2022 01:33:29.1961 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ltoyr12WIc866zCqJDQlMhat/QnGdAL2I9MAkxJjhEMzI/s0xXzd6FgaBJu+B7SJIVRJjv0qqgq8tzdsj6Ly8O4O8U7GcOTncxBtoBNM5wU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8635
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] syscalls/add_key05: Add userdel and groupdel
 before useradd
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

Hi Zhao


> If the test exit abnormal, some user/group will be left, and the
> next running of the test will fail and report:
> 
>    tst_buffers.c:55: TINFO: Test is using guarded buffers
>    tst_test.c:1526: TINFO: Timeout per run is 0h 00m 30s
>    useradd: group ltp_add_key05_0 exists - if you want to add this user to that group, use -g.
>    add_key05.c:41: TBROK: useradd failed (9)
>    userdel: user 'ltp_add_key05_0' does not exist
>    add_key05.c:56: TWARN: 'userdel -r ltp_add_key05_0' failed: ENOENT (2)
> 
> Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
> ---
>   testcases/kernel/syscalls/add_key/add_key05.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/testcases/kernel/syscalls/add_key/add_key05.c b/testcases/kernel/syscalls/add_key/add_key05.c
> index 71a88d1a8..e8d249040 100644
> --- a/testcases/kernel/syscalls/add_key/add_key05.c
> +++ b/testcases/kernel/syscalls/add_key/add_key05.c
> @@ -34,10 +34,15 @@ static void add_user(char n)
>   {
>   	char username[] = "ltp_add_key05_n";
>   	const char *const cmd_useradd[] = {"useradd", username, NULL};
> +	const char *const cmd_userdel[] = {"userdel", "-r", username, NULL};
> +	const char *const cmd_groupdel[] = {"groupdel", username, NULL};
>   	struct passwd *pw;
> 
>   	username[sizeof(username) - 2] = '0' + n;
> 
> +	tst_cmd(cmd_userdel, NULL, "/dev/null", TST_CMD_PASS_RETVAL);

I do a test on my system
#useradd test
#userdel -r test
#groupdel test
groupdel: group 'test' does not exist

so I guess we can only using cmd_userdel is enough because it seems 
userdel will remove the corresponding group.


Best Regards
Yang Xu
> +	tst_cmd(cmd_groupdel, NULL, "/dev/null", TST_CMD_PASS_RETVAL);
> +
>   	SAFE_CMD(cmd_useradd, NULL, NULL);
>   	pw = SAFE_GETPWNAM(username);
>   	ltpuser[(unsigned int)n] = pw->pw_uid;
> --
> 2.17.1
> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
