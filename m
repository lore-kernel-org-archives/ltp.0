Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E938C433EF
	for <ltp@archiver.kernel.org>; Sun, 30 Jan 2022 02:25:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AF8613C9791
	for <ltp@archiver.kernel.org>; Sun, 30 Jan 2022 03:25:12 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 76AB73C2BBC
 for <ltp@lists.linux.it>; Sun, 30 Jan 2022 03:25:02 +0100 (CET)
Received: from esa1.fujitsucc.c3s2.iphmx.com (esa1.fujitsucc.c3s2.iphmx.com
 [68.232.152.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A85CA14004F9
 for <ltp@lists.linux.it>; Sun, 30 Jan 2022 03:25:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1643509501; x=1675045501;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=wCKbwzHkt2Q3uMrgkASN0Ek3ZHfnsPX+8ezg0bT88ss=;
 b=cKBRR17WnqwfWdsCtd1DWoBFyCNTpLpHyjwZurKgMWdSWwvxG9Qcbd+r
 ofafWV8A26JY/2vbRlTyB/Vx2l1PI7yo+ax39fwqD8sJ/rcGKsiCye0Fs
 A0jMdPHRG0FlOfVQw2TBypt4X/yYmI8ejo2m0PyTpYY7yicaWuQwShcae
 kUiN25o8rgqJJtc68bNFvyiGTQF01b2uIeBbM3K8la3B6RL0mzFr4bC07
 ioRNUEXUIQMkCLAcJrGrtdAyCg8rSNZ4t/MWRSjv21bR1WG2C00ur+INm
 se2jPGZ98mWhbB6R2Oqe57JFjZ5oW3aBBscxyMXcTf3fw+Z4gr+IaqZ0k A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10242"; a="56855002"
X-IronPort-AV: E=Sophos;i="5.88,327,1635174000"; d="scan'208";a="56855002"
Received: from mail-os0jpn01lp2106.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.106])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jan 2022 11:24:57 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ykx7ISExnZgd1AZM01ex1YzO2pdgUuyn1P6mFmpEoI15njYqsqqxQHk3VhKNVifDiXKMSHi/OXuKQq7lD19qMoni/MgzCGXvQLWAZProlHnD5nuSNImeBR7gCP6xyj3xTaPTDO6tcry+LGU+fVM+CkBkNPa3vRr1fGpbvr+wmqmVMuqigz+8c1W4TfRhQ7rwPcFD/RPy/i6fS+Lv+jiPh0oXyRX48BYldU47G+bJ/81j5r5jJLuM9ga/sk+K+Lzm2CE6lvLdvRETXOrJWIH8QYFa+rPATLsHqX5TaHGQTrCCiCqbJ5Gvq88PM2THHXRPgTYopPhHzhnNBSZmRcBTlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wCKbwzHkt2Q3uMrgkASN0Ek3ZHfnsPX+8ezg0bT88ss=;
 b=QjB+uehKR8WjMr5F1U4B2f63ClDzyoHzfX0UQQAYDqtJcXQmOXjiaZ151JRngP5a/iFrQr08wGiIH48hN3exzvYA7qBo23E4xPftWE5ujUDQ2La2hEQzaV1OTp9EE+oCKeCNde0lOn6sou7Fl25d4mNhvbpGv63LafNo5PiWeJiAAOav+u4gYizqmS3tcDbIjVwOgDnS+KyPBFuQStFpHVn0lp2R6Yv388/ttg63eKvC8ps32PDXPacCk9GBXYuVYsqJSi6KX/9Z1vuwBVLHcZ6Dw+0xh6J7xe/NBDlFvsugUHshrtqefgIVkq1QNIPLYA8sNlnAQwdHwRlO6dovgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wCKbwzHkt2Q3uMrgkASN0Ek3ZHfnsPX+8ezg0bT88ss=;
 b=U3QQUlRt9NJDIzsZU0+l1rVS9t8/kMHFQDxRH1n7q6Ds08aMvcG0E41oURnNd++UF7r4Uu/rSIP/hn/GenPqayC+ntppoTSK/FkXXyydBxGBFV9Hg5f8s487aea9vx2I/CyWQjFK0gcNORi3rg+FZA6e9antSO2r0rjUnagMNyg=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by TYWPR01MB9324.jpnprd01.prod.outlook.com (2603:1096:400:1a1::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.18; Sun, 30 Jan
 2022 02:24:54 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::787f:42c2:70b:1fd7]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::787f:42c2:70b:1fd7%3]) with mapi id 15.20.4930.020; Sun, 30 Jan 2022
 02:24:54 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Cyril Hrubis <chrubis@suse.cz>
Thread-Topic: [LTP] [PATCH] sysctl/sysctl03: Test whether return EINVAL when
 passing negative value
Thread-Index: AQHYFAsBzD4q5lzw6kiQL7vggZ+7mKx4PGQAgAKc3gA=
Date: Sun, 30 Jan 2022 02:24:54 +0000
Message-ID: <61F5F724.9020700@fujitsu.com>
References: <1643349071-2164-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <YfPGDmF0UFFjeABu@yuki>
In-Reply-To: <YfPGDmF0UFFjeABu@yuki>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2367851f-cdf4-42f5-65d9-08d9e397b395
x-ms-traffictypediagnostic: TYWPR01MB9324:EE_
x-microsoft-antispam-prvs: <TYWPR01MB9324D379BD71816B09A52FCFFD249@TYWPR01MB9324.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: keftuX07wsn8hyz2fX3bo3aTcSiLHATJ/BHGNDiJkLhWauRnUrRFjf+eI9JcmoqTo28TC26ZYGEc0Zdpt+V8AUS2cKznHAzIx7pqrxwCd83AYbp4ee+gy4L3ilXDO/2Rv1esh8BHjqjm0mh3O2zYvltqnl/nMHf2sLblz2Ki7FTunyViLQ5sO5i8BkfOm5EWfRYFK3wRY5ncssBmHetpgB5sO94h4Lkip05s5mhW40c0r9rylGzUD645oQg6KIWzmSOo8gfiiSchKhvK4JBF7dAhIss64RO4/KZcDBzJegDaoV/CJorCHPjQ7MiA2o1aGclZSbfMBEfEY2D0RwK3yY2o/IRKXFbAtgYf3znG3Psj1l2Ut7YbCL5wmolRQJgVDfxVrJttHZnT93cezg408qCNiNhdZjIKkF3auU22wHPspn1ifkAZ7v3F4KC8MlPPCmB5+cPaAdiLMJxX6qYdNNMJ5wwWtmCvl0wFt83Wl13hqoGDFfOcCNNDHvqfXsNcbFNlikfH7OH3weOdFSfu3IyZHOmRem7zkEoLJAy88j/YPdE2VKX2huT6xFS9l0EOTDxNASqDEYPjQhy7s6hItDc/s5mGnAt8Dwb8raBF4u9hippc21EghMxjvZWswaY+uWyZHhI1GO/jfFDb7wo2+9cQYFcZjwE6qpVY0k7uVPxoxNsMNSxDN1sPxg/ElqLgcT6M6M62de8b31TOt4DQSw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(85182001)(316002)(2616005)(36756003)(83380400001)(38070700005)(6512007)(6916009)(5660300002)(26005)(186003)(86362001)(38100700002)(64756008)(87266011)(6486002)(4326008)(2906002)(6506007)(66946007)(71200400001)(82960400001)(66476007)(66556008)(66446008)(76116006)(508600001)(8936002)(8676002)(33656002)(122000001)(91956017)(20210929001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?c0pBbGg4UWtJNXE5MFprcFY4Q3ZPZzVxUmUrQzFXSnBFSzBVeGFnb05kSmto?=
 =?gb2312?B?cFlaYU9oQTdvTC84eC9QM3RiYzdIOW9CZ1lvbmIyQzZHSElEOGRHL2tjb1FY?=
 =?gb2312?B?RGhsVUhLTWVHcVVKUDhUcStsQjQ4S2thVDJBSHJ3VVF5K0svVUMzR1FndjAv?=
 =?gb2312?B?bWdITTFsaUdzZXcycUhVOEJleEJPMnV0cnF2SHEzQ0RXdFBtUHdGYW9iYVp0?=
 =?gb2312?B?N3h4aHAwdXZiTlp4eXBWdVBqU0JrQ2lib0FGcUxLS2NSUFU5VUJmSzZFQ1RM?=
 =?gb2312?B?amlMSlM5bWdUMVVCY3VCY05JYjdwcklmeGRvZlNGbk53YStoMW40QzU1Wmo5?=
 =?gb2312?B?UWYvM3lVYzdxZnl4L2lFOWJLMEpMUVlPTkJPRmhWYlo1VUlmTGY0V2ZaemFE?=
 =?gb2312?B?OGFJMG4xSXcwamNtUW1NUHlFK2hlZnVsbk1zL0VnOEVOZEgwbll3Y1BuTllE?=
 =?gb2312?B?anljRHBJblpnNjlxNHlmWkxVY0U0ZGsyeSsvV3Zxcis0V1RsQ2VvSDV2VlJL?=
 =?gb2312?B?cUdwazV6L3hBQTRxVGhYMVhlSlVaMVQ0T3o3dGNjQlJIdGxXTzJXM0k1Yk1R?=
 =?gb2312?B?ZmZSdlVPcWhJNDZFYmVWSWREUnFWOEt6eHVCdGVsS1g2UkxRUU4vV0RWV3RH?=
 =?gb2312?B?dzMxbFl6aHBFVG0wekJJd2RuZ2dEL2xncm5UNkU1SEhFU3ZpM0g1NG52S05M?=
 =?gb2312?B?TzJyVzNNcEQ2TWNiVnlhanM2eU5Ed0NVd3FYMlZyZHdaa2VqWFZNK3dyRDZR?=
 =?gb2312?B?UmU4SjFJa2t2cVJLVExoYmpBMDhKejB4OTJNWWJSU0VsVlhwajBlUU9lRzRC?=
 =?gb2312?B?dlRRVjhXMWJwblk4RlBBRDVoMlM2bWlPUFp0WUJSekFSdjZxSGdQd2dvdU0w?=
 =?gb2312?B?THBPVjVGdVNBUERQblgrSUptSGxERGg5dG8xeVhwY0ZoQXdtc2RsV1R5ZWty?=
 =?gb2312?B?c0g0SUdXT2x4dHBHYkJLUmt2SDdFMjVoU1lsQ0Nxc1ZhcyszMkx5UFZXbmd0?=
 =?gb2312?B?U3NoWmQrTldmRXYxamNYSXB6OWpYcEhSR2ZBRWNBd0o0Q2ZYeUxsaTQ5U1V0?=
 =?gb2312?B?Ty9JL0hzTllwcklhclg5b0twTVVkMm55UzNRTkphNW9VRVJaWDJIUzgrTFJs?=
 =?gb2312?B?WFVpRWc2V3V4RDk4YVNKbGZHbHN3SGJBS0FVWTJ4a0hvSGM0bHl0eWhzaHF4?=
 =?gb2312?B?cU9QRGNvdk9ndHFWdTJ2TGtxUVAzMEFjZnFGOGI2aEVrdmYxcjVPMjY2VWNN?=
 =?gb2312?B?OTJQYVVpenpNQjJLR0ZGK3Y1ZzB1Slp1WFptdnBXUlZRQUU5OUJiWEJJQktz?=
 =?gb2312?B?Nm1BS0Ftd0I1Mmx2R25pdjUySFo5VktKMTNqTkdNV2xJSFZqK0JWdnB3elF5?=
 =?gb2312?B?cUFndmFubDdHWTJVbzQ1NFdkS2pqMGFoZURXbDJQbXFNelRvSnAwNDhFK1Y2?=
 =?gb2312?B?RlF4ZG9hY0dQYlQwYTgxUVcvbWUrRlk4OC85NlRUUGlQdGI3OFp0ZWowalEv?=
 =?gb2312?B?b1VLVWFIbkNXcWlmT2ljeENKWk9CUFRXNXl0QTQ0YjVvTVlodWF5OVptdWoz?=
 =?gb2312?B?ZnQxVmx3K21iQ2Mzd0d1N2JNWmpLeHg3V0xRdThEOGQxMWdJdHBLMjJFeU9t?=
 =?gb2312?B?ZE51ZFlVWHp0ZGxadnIyZmlKazJ4cGNFVWlCZDJ0Mnl2cGVRMXdtUzB6Y1lo?=
 =?gb2312?B?WDczeU8xQ0xaZGxaejJMR1dvNXVYRDVMYzRLQmZ4MFd4dC9tcG94V2gvZ1RU?=
 =?gb2312?B?M0M5NkNXOWRSV1JIL2Z2R2hWL3B0VFBYdjRUVVRYS2p1Tk01ejdWV2ZFYmds?=
 =?gb2312?B?V21JbmVKaHFEYnB6UTBVRjR0MStLeS8zM2FsVk8wY0pibmVIK0owakwyZGVV?=
 =?gb2312?B?MGpQKy9qb0F4RU5naXc0UkwwMjBldVdNTXNVVDNQS2JmaUlTS29TNDZ2OTV4?=
 =?gb2312?B?TXFwZWIvUDBxc0U5UTg4NUVtZHBhaXR5bHVkRGFkTG5ucU1EYlJjUGY2OE5K?=
 =?gb2312?B?VTR4SXNxeGdRWERCeFVzdG56OXhVUUdIUGJReGRSNFhTWm1vK0pYb1YrcHp5?=
 =?gb2312?B?SldpNkQ1REhZcnBFY1BxVXBhT3E3dnRxcDkwT0YrVWJaTkdEZ2tGNjBjNFlu?=
 =?gb2312?B?Qklsd3NQUlJVcHVRc2hQTGlGcmkvM0dUNnVUVzRpZ3QwNG5CeVBGbjNrZ1hW?=
 =?gb2312?B?SDdZSllYNGpoOHIwWDREb3ZadWdWMzlrWW1TMzYxM3p3TmdHS3d6OGZPRTlE?=
 =?gb2312?Q?8I4IEVeUp6Wzqz5JRSNXbmAgXgHlbjF9n8uCopr7XU=3D?=
Content-ID: <3786EBC03DA49A4F8ABCE97F71BCDA24@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2367851f-cdf4-42f5-65d9-08d9e397b395
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2022 02:24:54.1490 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1XE+xMCWvIcaIgXkQZ1tRGfQhMPKNUt1IMl8t7RfpqL85/zKQBvke/S12wsCt3BLmhDSAvRWwXCOJupJ3dng5MXagXkuBlYDH2qW/iBRp3c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9324
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] sysctl/sysctl03: Test whether return EINVAL when
 passing negative value
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

Hi Cyril
> Hi!
>> +#!/bin/sh
>> +# SPDX-License-Identifier: GPL-2.0-or-later
>> +# Copyright (c) 2022 FUJITSU LIMITED. All rights reserved.
>> +# Author: Yang Xu<xuyang2018.jy@fujitsu.com>
>> +#
>> +# When we pass a negative value to the proc_doulongvec_minmax() function,
>> +# the function should return EINVAL and the corresponding interface value
>> +# does not change.
>> +#
>> +# It is also a regression test for
>> +# commit 1622ed7d0743 ("sysctl: returns -EINVAL when a negative value is passed
>> +# to proc_doulongvec_minmax").
>> +#
>> +# Use fs.epoll.max_user_watches interface to test this.
>> +
>> +TST_TESTFUNC=do_test
>> +TST_SETUP=setup
>> +TST_NEEDS_ROOT=1
>> +TST_NEEDS_CMDS="sysctl"
>> +TST_NEEDS_KCONFIGS="CONFIG_SYSCTL=y, CONFIG_PROC_FS=y, CONFIG_INOTIFY_USER=y"
>> +sys_name="fs.epoll.max_user_watches"
>> +sys_file="/proc/sys/fs/epoll/max_user_watches"
>> +
>> +. tst_test.sh
>> +
>> +setup()
>> +{
>> +	orig_value=$(cat "$sys_file")
>> +}
>> +
>> +do_test()
>> +{
>> +	tst_res TINFO "trying to set $sys_name=-1"
>> +
>> +	sysctl -w -q $sys_name=-1 2>&1 | grep -q "Invalid argument"
>> +
>> +	if [ $? -eq 0 ]; then
>> +		tst_res TPASS "sysctl returns EINVAL when passing a negative value"
>> +	else
>> +		tst_res TFAIL "sysctl doesn't return EINVAL when passing a negative value"
>> +	fi
>> +
>> +	new_value=$(cat "$sys_file")
>> +	if [ $orig_value -eq $new_value ]; then
>> +		tst_res TPASS "the interface value doesn't change when passing a negative value"
>> +	else
>> +		tst_res TFAIL "the interface value changes when passing a negative value"
>> +		sysctl -w -q $sys_name=$orig_value
>> +	fi
>> +}
>> +
>> +tst_run
>
> I'm just wondering if this wouldn't be actually easier as a C test. I
> bet that simple write() to the sys_file would work exactly the same and
> we wouldn't depend on sysctl being present on the system.
If using C program, it seems not have a suitable place to put this test 
case. Do you have some advise?

Best Regards
Yang Xu
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
