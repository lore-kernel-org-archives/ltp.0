Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C636C433EF
	for <ltp@archiver.kernel.org>; Mon, 10 Jan 2022 06:38:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7A48E3C937D
	for <ltp@archiver.kernel.org>; Mon, 10 Jan 2022 07:37:59 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2BC9B3C6AAF
 for <ltp@lists.linux.it>; Mon, 10 Jan 2022 07:37:49 +0100 (CET)
Received: from esa6.fujitsucc.c3s2.iphmx.com (esa6.fujitsucc.c3s2.iphmx.com
 [68.232.159.83])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 68C551400123
 for <ltp@lists.linux.it>; Mon, 10 Jan 2022 07:37:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1641796669; x=1673332669;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=szO3chWCF+HUPpSKunkFYNsKqzOFEAH2AOSE2R2+0IM=;
 b=Oxm/QRdYKrtDmVwyAmxPHBy8FvgGXtNkeIcrjpSnAxArDwFbs7AQYI1l
 lcxH/37SRW1zS8fbrqbMrCGs8uGcnlldWIX7FttKR/ortVKHiUO0nabrV
 d+3t5m4XGqIFzMejSaUtQ8RBS2XaKMqA27IGPmd6QbAsdQ1IohZEwiAAR
 Fr6R7JTQnzJPg3a93aR58XtwfYl1Xcoz60Eod6Z4e4G2IEKk1AOLzhMRN
 gVl2FQ4twrNSgvvDXe2S4eCiKGFw75wWpgs1KunefZk8cRu4nFwME6L1X
 IIxxE0EZVPGLlkIzd4bJyapsAFNOIC8+uhn4lv8p/lAtQVZGG48jhdc4h Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10222"; a="47306669"
X-IronPort-AV: E=Sophos;i="5.88,276,1635174000"; d="scan'208";a="47306669"
Received: from mail-tycjpn01lp2175.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.175])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jan 2022 15:37:47 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bx82MS1OZ6I4o1Qo9S6sC4KxIbFsGeCRxdqmyGZBxDkLO0upJxTd01FA29mXfPHEbWMQoE9sqZVL5wvenebwBiSnTU1UsKD13Za4Dm8Jw6blXescClcxoGlTzS8AQo1m8atTiTJGrSX/gi2M19Z7Git6cgxwMWvaGqmyi5BtVLsGrqQrUOzVtJ2g5h2po+miro/87LF8dnOdFzyDa6L7vaIpIpntt0B+doDedaqCaJ+kG5q0Rod8/RoclA/GcUac2nvXHxXPa0L/h0VCSPwVHRvtx2niuCrtNfWivOKdTgBcHIi27n5iaG2uXOlaR5wZzMxuzzEqTyd7aliASKaJzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=szO3chWCF+HUPpSKunkFYNsKqzOFEAH2AOSE2R2+0IM=;
 b=FTRcqY2q1mT2QvIQtZsZFV+qMMF0xXZCMf2kVpvCRHps2IXd4rk0ZL4/OLyZ+FTIE13hSXqdc5/ptozrUY+Rrz9jjrgE+GZTmTAnThb+g+Rx7BDZJffWYE/r5Rb/gv6z3UhdJ+qH0/aCwLenh98RqEKuMz0PrF30cNBKpwvxUKb4hVgCMjTvAPQEL03SozVE51c35vIkha1/f22TVhcBa5kQgnynTSM8FK1H3FgiOASr4RKbwOz4OCAh5UrsqLgpXf2nBA6g6c1Q3SvAOFtlaURdb8WONy2PYZtqPwKL8v4lpqK+tfEZmFbv25VyDbkrPUCM8lGkZhL/hV3oyuD4Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=szO3chWCF+HUPpSKunkFYNsKqzOFEAH2AOSE2R2+0IM=;
 b=Au1NV6F2BOuJRDTVmbi0lFm584eMrJHLzZvGmON+VMRMGLJGdeV1VQsVeHhNNeDCvBLhIbUT+Y15l6p2naewrPhCJe4iMI3vUsKByr4Nl0STXMZxfnj4VZmv5c7mYFZZDuscr2HqcNFo/2UWN5HjbRKg1ktRctfUn+s2Vq8LSNI=
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com (2603:1096:400:98::6)
 by TYAPR01MB4493.jpnprd01.prod.outlook.com (2603:1096:404:11f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Mon, 10 Jan
 2022 06:37:43 +0000
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::9486:fa6e:4ac9:802b]) by TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::9486:fa6e:4ac9:802b%4]) with mapi id 15.20.4867.011; Mon, 10 Jan 2022
 06:37:43 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Cyril Hrubis <chrubis@suse.cz>
Thread-Topic: [LTP] [PATCH v4 1/6] syscalls/quotactl08: Test quoatctl01 but
 quota info hidden in filesystem
Thread-Index: AQHX7/LHkAfOKvGU/ky0NkV6iB5JYKxXwGIAgAQ5FAA=
Date: Mon, 10 Jan 2022 06:37:43 +0000
Message-ID: <61DBD466.3050303@fujitsu.com>
References: <YY0o7jAxgIHvmczq@yuki>
 <1639380414-24390-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <YdhJhtWIYUjWdeAk@yuki>
In-Reply-To: <YdhJhtWIYUjWdeAk@yuki>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: efdf4c9d-99ec-46b9-1c1d-08d9d403b4ee
x-ms-traffictypediagnostic: TYAPR01MB4493:EE_
x-microsoft-antispam-prvs: <TYAPR01MB44935B02676B8C2FC8FD4A8CFD509@TYAPR01MB4493.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: izQly6EwhgAP73Y9yOE1cKtSPWw4Ld+R+v8V2Bmx2j0x50MOhISuMkKG4iPLX6qpHlaq/izmbGcbjCLN3aDRVILnPWlm7+N42AjBh1wq0BLp7QU7Wt7yJcYphYhJqon8XFKNVXSxhwM+XhVa+WT0GqCipTaQnLv0M65wC6LU7PemAPiZCH4DHj+8ouChh3CgVB5RIwKXKWombnFU2Fbs/+b84oivvZuy8xb31o2f5eYWJOOu9EVcBU7jpn2Ko4biBsZczMb3SKbF/kkrkU/YFvyj0zA50EK3AwyIWf/745PirWBYi7fUvI3viOqbXIO+YTb2SitKHklosYy13uyRtdP5UlsgRtOJIRDbPk7pfo5gJg53dqoubQ439hTy+F6SGGAbN+c+zrFbDIKAeB+aRszgPbyt1WcB60bKlGuuIXKYeC3cx26wnaj1298E2zwxssCsCxzRwv/qUn4WEfhe6OZFF5mR/2fXZOJ3Yjj/GWOdIP9iVfvNX4v6OQE/QP2JTujLBqxKNpn/wfyKSzBhDbJKAMo3qM8chOrLrc+n2z+e2xN1jYVyLF/973wf2Sz+KIfMnTIkJ2qohtcGD58yALxiTqAxMXeuGqLBJwqC0rGWdj6nBF2C3eufhGnNhKU0PxffnHd8hf4je3sBZYJ/27k6HI8UEeaPGaaclnY2aa6mkmWUqseIv+zsewfgDilOwkAZvUnQEAUIDaGWrZUQnw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB6544.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66446008)(91956017)(186003)(82960400001)(2616005)(66946007)(508600001)(6916009)(8936002)(66476007)(64756008)(6512007)(66556008)(4326008)(85182001)(6486002)(86362001)(36756003)(38070700005)(76116006)(6506007)(71200400001)(26005)(15650500001)(5660300002)(316002)(122000001)(38100700002)(87266011)(2906002)(33656002)(83380400001)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?R1B3YWxnU0M0VGJjQ3Eyc0J5eEt3QUtHMkI3WmI5UkEveEMyUzFnT3lzOXhD?=
 =?gb2312?B?dCswVDdlV0dTMkFkRGJlb1VWalhoeHhIdDVkRERZUFhnM3ZZbDJja004QnpZ?=
 =?gb2312?B?aFYzNlJsQmd1VThwM3NzdjRRa1haU09LR09FOFB3MXJBdk1MYXpLWTBVaG9B?=
 =?gb2312?B?Mmk1RUVOWDdicWJmaDZJblJnaEx0eERveXh2dmpwR0ZJcDZ6YTZhbEg1YTYv?=
 =?gb2312?B?Y3g4MlhqUVRYazhIYzNlVHhQT0JFRmpRM3FQMDkxVHRwY2ViZ0tVZjVKcXZ5?=
 =?gb2312?B?SnM0YVhlMmcza1dGRTZyOVZJSmFzY1creXFZUlF6RGs0NXRxWkdNdEJsaTRC?=
 =?gb2312?B?WHRKbWNUVFZ2RW8xbUpkbEkrQWRtVjl3cUVYV0ZsV0ZxMitwdGV1WFh2VU15?=
 =?gb2312?B?TVdLbGcxSDR4V1FtOFBHQ01oVEpDblpHc0hVb3pobmVua1VoeVlxVkxwWnJI?=
 =?gb2312?B?Tit5MjVnSmVmZHBwb1ZzTVU2MlhZQ0ZZdCtUTUpCWUloRkswQXBncGRiUVRw?=
 =?gb2312?B?OUI5bldhaE14N2hkQ2xHS29Ub3hhZlNGYTU4ZW1QVzZTbDAxeHdWb3FPK3J1?=
 =?gb2312?B?TDVkSTE4S2U4WHh0NGNYRnREWFhLZ0UyZmZHNXZla0VHa3FiRkc0VVd5RE13?=
 =?gb2312?B?c3JvM0cvQUN4NDkzWkVQejhLcitGdTRPZUNuaStXUnJwL1pmMGxmNlRQdFQv?=
 =?gb2312?B?WVJvWmRYREhtK3VxLzhrTUNyTWh3YWJhWXdEMXRRQ0xYakdwcmVRYXhTNDgr?=
 =?gb2312?B?WER1Ti9uU1lHelJienJrMnQycUNLTE4rOVc5VlhPNzJaZ3E2MjQvemlUUmlk?=
 =?gb2312?B?dlFNVWZ1amx3dlJxRStOYWJpWWZoNDF1TlNZc0VRRHVpZ0lIQzdiVk5TSlB4?=
 =?gb2312?B?eDJPQXZkWWY4dHZLejNsRHYwS3FGblFmaHdUcE4zZmI0alVBa2Fkcllrd2M0?=
 =?gb2312?B?d3NXOUhKSzRzVFVkWStFT2hWNkRyZjRLcll2VzNOK1RONWcxUW1OSjdXNFF5?=
 =?gb2312?B?U1RNY1lYaStPVnBlVzZxeXJXM0hBYnRha056eThRUEJYZ0l0NE9sQTFLdDZH?=
 =?gb2312?B?aGtyblpmQXZnMVBieDNJRTFkT1RSTHdxQU90VFFvSlB1VjcyRTdTcDI3M2xW?=
 =?gb2312?B?NmlkOVJjUzhTQU1uRGMrYzl4M3ZIOWtXWTE5QjFXVG9tZDJrdGtEK2tYMW1U?=
 =?gb2312?B?eE1IVDNzZTUvRGZpZlJiUmI0bC93cjJabVpncHc1MHpuRjBiRzAyblFwcnRJ?=
 =?gb2312?B?TktGblZvZlpQUDJxaHRwMy9ISnhvRENJMkEzV0JrYWRKY2cwQlYrdGFRU0FB?=
 =?gb2312?B?K2JKUnkyVmU2SmVHN1FsbUJRUVNocDZjRVJwY0o3T0lHNjRCNTM5L3NVN0JM?=
 =?gb2312?B?QnBvclZQbEhTRXMzYkZrN3VVdHU4a0dBUWpWZGRNTUVrY0VGc01Pem4vQTJ1?=
 =?gb2312?B?STZheGFZQjRCd1NyanlsTVZuU3RZVEVWQnROZ3FDR2k3Mlg4Ny9SNzBpRWZp?=
 =?gb2312?B?M1ZDYUszQk9pVEFoRjF6bDQraEpZeGJveGdwU3k0cUFjd041RWVmaC93NnY2?=
 =?gb2312?B?elkrU3BKMWpwTXdVN3BEVEdHNTJkL0ZtcmZ0T1pWWFRIM0dDQzhOWG5mc1U2?=
 =?gb2312?B?QWc3T0NTbkpkYis2TWZZR1pjZmlCMDMxZFlXYmVJMDY4S3hxNXNqdDJFOWx0?=
 =?gb2312?B?dm5JbnBXYVFTSHpvTnJzYzRGcEZLd1FNVjZRSmMycjNzc1RsamFzekxqNU04?=
 =?gb2312?B?dzQ3VC9yNEFLY05sb0FWZE5hT0FpWXVDOWRCTFVIODBWeThMeWJTaGV5bjd3?=
 =?gb2312?B?YkNTNEVLVHQ5bTEvTG9Ha3pBakpIRjhIeUZlb1lMMzdrSEF6bGNyQWVyVno0?=
 =?gb2312?B?Y213cjZzTDV6b2o1VVk5d1ltOHJUWkExQjhhbmtnbzFhSzd0akNJMWpmdlJJ?=
 =?gb2312?B?V2tLcVdZYnhVdUNvYnRjb284cURudlNrL2p2RStIb0xxY3RwVFVPYitGR0Zv?=
 =?gb2312?B?TGRtdUZ3QVExNDJSRTIvZkM1bWVhNnZnVmM5TEYvT3N0WTJXcVc2bkMzWEJq?=
 =?gb2312?B?T1owMlpRYmhzeExIZ21OczhvVENrbmtiTmg3RUZ0cWZmU3c0c2d0QlI3TXJZ?=
 =?gb2312?B?c1pBaExwa2FreTNmbC9RdUVteXVVU3Vwd004Y1lYWTZNOU9ucm5NWms3Q0w1?=
 =?gb2312?B?azJSMXNIQTU4RkVDOXRxSXNWK2R6NklvV2lieXpyYitjNmp6MGJuZzhJZDE3?=
 =?gb2312?Q?IwKZL6GMSyiGeyYYYOWz6IgzzK/jRE8tBiB/zfxRjM=3D?=
Content-ID: <829350D06BCB1946A1D1FC82C77E4B92@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6544.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efdf4c9d-99ec-46b9-1c1d-08d9d403b4ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2022 06:37:43.4348 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yz2+DH8AC5/hfLTJNU756ZXC8nlaMVi4097ATpJFRcHGL9WPcnzDI2CiSJVzj1NKr0OJ7RRG1/n/eOJk2ywKC4b7spmt7iaHVLi0b55YBDI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB4493
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 1/6] syscalls/quotactl08: Test quoatctl01 but
 quota info hidden in filesystem
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
>> +static void verify_quota(unsigned int n)
>> +{
>> +	struct tcase *tc =&tcases[n];
>> +
>> +	res_dq.dqb_bsoftlimit = 0;
>> +	res_qf.dqi_igrace = 0;
>> +	fmt_buf = 0;
>> +	res_ndq.dqb_id = -1;
>> +
>> +	tst_res(TINFO, "Test #%d: %s", n, tc->tname);
>> +	if ((tc->cmd == QCMD(Q_GETNEXTQUOTA, USRQUOTA) ||
>> +		tc->cmd == QCMD(Q_GETNEXTQUOTA, GRPQUOTA))&&
>> +		getnextquota_nsup) {
>> +		tst_res(TCONF, "current system doesn't support this cmd");
>                                                                  ^
> 								Can we
> 								print
> 								tc->des
> 								here?
Yes.
>> +		return;
>> +	}
>> +	TEST(do_quotactl(fd, tc->cmd, tst_device->dev, *tc->id, tc->addr));
>> +	if (TST_RET == -1) {
>> +		tst_res(TFAIL | TTERRNO, "quotactl failed to %s", tc->des);
>> +		return;
>> +	}
>
> And this can be TST_EXP_PASS_SILENT() followed by if (!TST_PASS) return;
>
> The difference is that the TST_EXP* macros are more comprehensive if
> there is a bug in kernel that makes quotaclt() return a possitive number
> on success this test would still succeed while the macro will fail it.
Yes. But it seems all quotactl cases have this problem(ie quotactl01.c), 
so I plan to merge this first. Then make use of TST_EXP* macro for all 
quotactl cases in a separate patch.

What do you think about this?

Best Regards
Yang Xu
>
>
> Other than these two minor issues:
>
> Reviewed-by: Cyril Hrubis<chrubis@suse.cz>
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
