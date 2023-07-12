Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06B79EB64DC
	for <ltp@archiver.kernel.org>; Wed, 12 Jul 2023 02:02:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DEFC23CED39
	for <ltp@archiver.kernel.org>; Wed, 12 Jul 2023 04:02:12 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 99F9E3CB4DB
 for <ltp@lists.linux.it>; Wed, 12 Jul 2023 04:02:01 +0200 (CEST)
Received: from esa18.fujitsucc.c3s2.iphmx.com (esa18.fujitsucc.c3s2.iphmx.com
 [216.71.158.38])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id CBDDB100054D
 for <ltp@lists.linux.it>; Wed, 12 Jul 2023 04:02:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1689127322; x=1720663322;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=M0XSC/5fBsekXMxjD5DfIZJoEgVyotAenh36A9w0OKE=;
 b=fN32xaR3Awj7FMb6jDtHsL6PXn+SkkTOmHmDNCNatKdsYz68Jmo4w1Rj
 ui/YuuzATLW51cMlavL9xdU3VbWdeR3zMnFXmkkvIxY6MS8fjI5HFZIeC
 JeVF9wwL7eNQeshIHhZhbDYSIr00nNvx5k7ia7BJMLtQWbbaQ4Es6DF4T
 KwMmv1xJQsKEUtWY3jroIUT2gGIQGSFaLWW5Yv3A4LjfGxRIVfXr5D1+u
 VO56wdYO6StFoJDDkfySrD+npjD9/snVDGlcUUMtO8abhZkoHsJqqK1/6
 ldowaCGEn+Zo1kQGGXBOga8M+ZeuKB1gtk9S8tnLyOL5AOezekw4HeUxl A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="92248054"
X-IronPort-AV: E=Sophos;i="6.01,198,1684767600"; d="scan'208";a="92248054"
Received: from mail-tycjpn01lp2173.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.173])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jul 2023 11:01:58 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tdnl1o3i3St6xSHDrveQF0gxB4ObCz2oTcUFeEImXA570JkHjebiSqOwth3FQunVmBQY43nXfgAJ0qRbmYrRh9qW66M/CqQg4tkzJYEyiu9e+pAhYavs18PMBHdcH+Wcy7mZ4i8RUsOu/vrPM8nG7lOYyKO6e2SfVmeYR4EEnxHL4S/Av3dcep65tXMP+Qph6WMUAkxHX+uaXtLa74+9c3hMt3C2TCr2P9l2loHtrnJ8VXYHkaOi40IqQBqCX5d5tSToL6V7T+WxqsJwpJoiKlR8yWxqfyBy4j+AUU0Pv3l1miaMjkVstx3FHoZbK3rpYWjeWKkAI4j82eZr1piAKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M0XSC/5fBsekXMxjD5DfIZJoEgVyotAenh36A9w0OKE=;
 b=T66OuwqylCYRZJLSlczey+ecmYYrcKaiVvntq8dLER9C62+Xiawb+drF60M9zKsQEUPVD6stnnl0Aso03niLUTdYuYnYEx/XN1bTDaEFTaioEm8GBJBgI2785bLLSkW6QTEH45qL/+5i7jxFkqMQWG/wWSXY9naMrSpjK+Gw+xaJ4cTVA5YZi+vTML3UdIXe6SQZ/kTaK3ZabpKoh2CxkXhJOnKuC/ueFyAJirYIghySUrL2ayIU8l9reVd8Ytt4LdysGC9WINH8psDtv0rV5TXQOM0QJXaD3oRZ32oISi9s1E4Dx4OcKFe3TIP2MaRoemXMItTRFd4EMCDSeP53qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYCPR01MB10712.jpnprd01.prod.outlook.com (2603:1096:400:294::9)
 by TYCPR01MB8391.jpnprd01.prod.outlook.com (2603:1096:400:151::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 02:01:54 +0000
Received: from TYCPR01MB10712.jpnprd01.prod.outlook.com
 ([fe80::d91e:3d2b:3e7d:4074]) by TYCPR01MB10712.jpnprd01.prod.outlook.com
 ([fe80::d91e:3d2b:3e7d:4074%4]) with mapi id 15.20.6588.017; Wed, 12 Jul 2023
 02:01:53 +0000
From: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [PATCH v2 2/2] syscalls/geteuid02: Convert into new api
Thread-Index: AQHZr/F769iwEuzPuEWcz3Amv2DFx6+uA28AgAdmVAA=
Date: Wed, 12 Jul 2023 02:01:53 +0000
Message-ID: <11e524a2-c775-b68e-aa05-29b50fe6e38b@fujitsu.com>
References: <1688637954-17765-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1688637954-17765-2-git-send-email-xuyang2018.jy@fujitsu.com>
 <20230707090148.GC571797@pevik>
In-Reply-To: <20230707090148.GC571797@pevik>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB10712:EE_|TYCPR01MB8391:EE_
x-ms-office365-filtering-correlation-id: bcb817a4-278d-41ff-c541-08db827bf6c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /aUrn5pj93WTaM3jIcIo9kTe6JG2TciGyv17GZAUQTTG5ytLWJRO4UsFh4/VCQn3K84MXgJjBIH3QdnJctFKaLKss4UrLJlZM8Zpp7wANmsINODpp3m4UbZN1waxxBE/SikkFAgnq+VyNmjG416Izw2L8glhz7DCVJ02Mg4op8muHSu6xRYNvSJOhuJ4v2wZAFjkWmmhsloylb9fCxCUGDdgGNJ+ZEXRjjhXirEFMuWeZfxanCuCfyvsjCnf8+qUB0JGEdp7UNmNvxHLfWhKtrhqr2HgsNxtsFB1XlTkaKDJ27wlfcuTnlTne7+WBCm7/i1P7pircbbZdFh31Z/QDsSqQ2rpgMSJnK0Xr1b+1pP/znMTSdpizS4rovqORWGL3kS4HYsND/Bqi2KxBJ+WZ+/f/p++ZAV6s1/ondnwE25ezSXwJ5yeAzFcxBLz3I3m3truOamUiRPHkXBsGnQK1RmLISEamYjdKzI4ldDfeRIpQellG0gPOIJy+3xCxURrZTmwrYUAcr3Lnr2ZjYva8fSDJtMnxes8aum6j51JDhqJ6YDz/X6ZsfWSiNTgSx1E9jDCIrQmm/QkEoK0ldLCMEE5Ijz/vxcggtzIuzFNORCH+JpwS3CtHp5Q9zzlECQn5kMoaDm/3CoA9heFjmGOvmG1MfEmObIfMpqL7QKKn1zYo56p8E3fQqL9XyHDT2IH
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB10712.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(366004)(136003)(39860400002)(376002)(396003)(451199021)(1590799018)(2906002)(122000001)(6512007)(82960400001)(38100700002)(83380400001)(2616005)(186003)(26005)(86362001)(31696002)(6506007)(5660300002)(38070700005)(8936002)(8676002)(36756003)(85182001)(6486002)(71200400001)(478600001)(41300700001)(66556008)(66946007)(66446008)(66476007)(91956017)(76116006)(64756008)(316002)(4326008)(6916009)(31686004)(1580799015)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MFhRTVhpcWwvK21abWxPWWpVNTQycVUzQ2JTekJGSURaV3lxQ2VJSEFCSi9w?=
 =?utf-8?B?UzFORUVUa0JnMWJSYnRJbHU0WVFRRjk3c2hsZmtVMVFIbUZuTjVnaEJvYy9B?=
 =?utf-8?B?UW5DakFBa0FpbnE4b3ROcmVWakNHRjJZaTYxWlE1Ny9Vc2M3cUgyUmNVd25S?=
 =?utf-8?B?N1JCYXlLZHZpRnFjek8vYmErelFVWmQ0RnpXTndTU0JZMEJ3TzFZcEdxTU1k?=
 =?utf-8?B?T04yMGRWdUFzUTZYS1BPa21meTZPZzJvZHo1TktQcHkxSno1TU0yamRHYUh2?=
 =?utf-8?B?OGJyemgrMWNvWHBWTjQzcUpZNkNWajgwejhUWGRsOWhkcVpObEozT3lpYlpV?=
 =?utf-8?B?eVhBbGRrWFc4Ym9CK2VJbGZvMVlCSGFocndmcUh2Z0FSU2szNXU0VHlZZHc2?=
 =?utf-8?B?TitudDhxb0ZoTjREL05MQ1BiL2NHWTFudzFsK0tGVXpiQ1RTdVJ0eE1mTkFm?=
 =?utf-8?B?WFUwM09zSElvZkhzbm0zZkU2WUVTSXlKREt4NzFNdVlWNUhnekNJSHQ1UmtK?=
 =?utf-8?B?dnkzdFB5ZHFUc1F2YUtybWNpVUZuSzhDWlFiOFI4VG0wNmpMejFrNFdkNTg5?=
 =?utf-8?B?Mzlyd0xQMUZGT1l6Rm8ycUg5OGkrSWVCUHNJU2k0aTA2NU1OYU9sd1UwWlVz?=
 =?utf-8?B?TVFWeklFZDR6QWFqd01taVFDVERaOU9UbWg4WmM4TnRNZDkwL3hrakU2VFEx?=
 =?utf-8?B?R1dhSThGSXpzN0xNMjhDcThkRHJKMjE2YnVOclBzNytmNVhiYkRia2hoWStS?=
 =?utf-8?B?bXdEZTZVV0V4MWRnNG15ajFRSDZMQWZScW40cFd2THp4a1dGWVpuTVluWXNM?=
 =?utf-8?B?RTUzWFgydi9EWCtmWDZybmRyZ0NQeDQ4bkpORXovcC8yWWJZbmhmTFhveUxU?=
 =?utf-8?B?U2FkWVRQK1RmVW5rd0V3SmMzd0VSRUREMkpIOUIxUlN4Q090L2ttc1RnYWdH?=
 =?utf-8?B?c2lCTGEyaU4yQUVSMWhqaUMydkRnbEFDNDBDL3NYckJmdmo3NU9ZZFRPb0xI?=
 =?utf-8?B?eGFsd29ucngxaHFGdEJML0dXdkQwazlEOUVVM3lkSDFVM1V0KzRzOGNuQUxu?=
 =?utf-8?B?K3FudVJZNzVXZnJHMzU2UjcwK0ZVZ3ZJN0RoMTFKZlVOR0w3V25UaStWZHlB?=
 =?utf-8?B?QTZldEYzd3oxY3NjVGUrQkE1aDkwWXk3V3hQZ1M0L29hU3hCWi9Pd2RQMVkz?=
 =?utf-8?B?VzBwSjhDNkp0NmoxbHpPMVFLTHJKQ0x2Q1pIVWhjc3NLWTJaKzRPaG9XQzZW?=
 =?utf-8?B?WjFBd2QyZi85UTljamc0R2ZrWCtqWlFEUmtuQVpxWFlVUFV3bTJlVFRKVFJF?=
 =?utf-8?B?WitUZ3dNVkVBVUw0VGhwVWhGNkduL1JoK1UxL0hkbmJwWTN3by9sUVlnWFlr?=
 =?utf-8?B?blhzWG9FcmIxaWNhKzBrV3I0RTRQOCtYZi9vVE43TDVlT1dQbTNCUGMzRkxt?=
 =?utf-8?B?U0l0cmszS2RZSmo5aFJOckU3dmd2RE1yMGNjYlVmdzV2bjR6dkFWK1orUmtZ?=
 =?utf-8?B?MGx0ZVVlRWM5bFhHSExMTHZEM1RQM1phNkhvVDJTb29UZ2syTkhQYjVadVdv?=
 =?utf-8?B?R3QzT3lPR1lPUlg3UnltRHFERU1CQXhIZnNxSEJBa05EL0EyQS9EeFB6UElt?=
 =?utf-8?B?Y2tickQ0QlNmY3VVN213ZjZzYWVrbXNCYVYrblkvUEltWDZVMnpib2tWUnVj?=
 =?utf-8?B?U3NSdGRKb1pNVEtTbFhCMmFiRVZtOXZrSU9GZ1pkczJlYWg2ZWw2QUJQMGo3?=
 =?utf-8?B?d3dxK1VIdUJsemR3WTR6MnhHRlM5clVkREQwK3VSTU5GTVBQRXdCeDZYc2dQ?=
 =?utf-8?B?d0RaNmRXMFFyUnA0OWphSlhmT1VGQkhiMzFPbTV4NTNoNXRlSUkzUHcxeHBH?=
 =?utf-8?B?WUtMVXBYblNPV2M4MWJzc3lIOC9pUG41M3V6ckRQamw0RjhOSVNoMjNEemlH?=
 =?utf-8?B?Zm8yQWVqVkdIdjU3SFIyVmZCQ3hXQWxSSXhmeXBZRUpudjdHSXIxWTljZXN5?=
 =?utf-8?B?dUlBclpETnhRRUh3NWVsMVRQUkU2MXovMDY4OUx4TUlNc0FKeUd5clg4Ylpn?=
 =?utf-8?B?WmxxM3B6TU5FWVhuSmQ1SDBYbFc2dFdKZXJrSm1NK3g0VnZWUmE4TjZMTzlU?=
 =?utf-8?B?RDlHMGhha3pDcmUzQlVwQWgwM0Mwb1RlSlEzZGF6OGdnR0p4U3M4Yzk2OHo4?=
 =?utf-8?B?NEE9PQ==?=
Content-ID: <47B07D5F6C932546BAE0DB1A3C6ABDFE@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: RMrIaSYloegkHZqXAwkvlMcrMR3tnLb+9PuGQ88MzaWW7icnxVGbyJxaTKbWz6oJHlt/pbNswfmpuUp50ugpy6Rc4W4T49gwt7tZrfnGstffYoUgFLFqUs4OJrLjJj/Z2E2eXOmbHQC6dVaQpTV9UtiU2onjOhMaJeMHwCr/aTYD3x4A61/nzMTpkGQzSe2NU3/4cZOKghreabmtED4hUoQ1bEZMrpvDYAZj1Rk0AQW7QhV+hBdIiWqtEHTj3tFVr1FSqxr2AlJfvofuU5AflfVGbOJj6uY8Wf7Cwb7Lwig6UeAwJA9kh8wmI77yDnEZZezUFN86019uoiBE52DFPN9fHdbu8wxvysBsFNPoV+XTb6kEhYckxV1zDgX2jX3PmhOjGtYuosCAQQLC6UNTxFqaUa1RL3j8w7lnt5D6oosysLNjtxyK7ZKVgvtIjKrDoAJEHz7xpwGOv19uFGTMyJJrphPc1HwjFdbejAd8tMDtWZrO8ul80O0oIsETrWSYn2LOZKinZWL6RHMzUiY5JJLJzdOKGV7VaPXXIO7be4haKKw5K1uZqgE8M2JyP0Ivuf9jQOPWUugiNtlinmXwRF5w/2J4+gX+cy4A/tVUH1M7YgNfAuseYp4JiUh/0ypNpBxStYer+oQVND2NF/0JIs/HlnJ0zmPcOFUZwPCZNrHOSp8I2wRTZSd+5iE19mIQcAtBZDQk9hpimlwX/Grib0Rxjm++J8NYQCs3pwIRugvy5vKQY/4+DPd4IkmKXH6t4GKnz9SUURNqq0lqW4apKw3ba0Qj9iH8u2QsCAnSbXI=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10712.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcb817a4-278d-41ff-c541-08db827bf6c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2023 02:01:53.5227 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3JGdyzeTfPD8Glb/szEET50IyUPbLu1itVL6ht2KE1UhsLNlRDCw/ff9bV/8x7aEtdvgzdekuviTYEvBEJ8PmQfY75OEaYKwaONKRkltJrs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8391
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/2] syscalls/geteuid02: Convert into new api
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

Hi Petr,

> Hi Xu,
> 
>> -		if (pwent == NULL)
>> -			tst_resm(TFAIL | TERRNO, "getpwuid failed");
>> -
>> -		UID16_CHECK(pwent->pw_uid, geteuid, cleanup);
> Don't we need to use UID16_CHECK()? In the new API version from
> compat_tst_16.h
> 
 >
Previously, the EUID was obtained from the return value of getpwuid()
and compared with the return value of geteuid() to check for a match.
This approach seemed more like a test of getpwuid() rather than testing 
geteuid() itself.

EUID is stored in /proc/self/status, and we can directly obtain it for 
comparison with the return from geteuid().

Best Regards
Yang Xu

> Kind regards,
> Petr
> 
>> -		if (pwent->pw_uid != TEST_RETURN)
>> -			tst_resm(TFAIL, "getpwuid value, %d, "
>> -				 "does not match geteuid "
>> -				 "value, %ld", pwent->pw_uid,
>> -				 TEST_RETURN);
>> -		else
>> -			tst_resm(TPASS, "values from geteuid "
>> -				 "and getpwuid match");
>> -	}
> ...
>> +	TST_EXP_EXPR(TST_RET == uid[1],
>> +		     "geteuid() ret %ld == /proc/self/status EUID: %ld",
>> +		     TST_RET, uid[1]);
>>   }
> 
>> +static struct tst_test test = {
>> +	.test_all = verify_geteuid,
>> +};

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
