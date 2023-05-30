Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B246C7EE23
	for <ltp@archiver.kernel.org>; Tue, 30 May 2023 05:52:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 610C23CCFA8
	for <ltp@archiver.kernel.org>; Tue, 30 May 2023 07:52:52 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7FD0B3C9F11
 for <ltp@lists.linux.it>; Tue, 30 May 2023 07:52:39 +0200 (CEST)
Received: from esa13.fujitsucc.c3s2.iphmx.com (esa13.fujitsucc.c3s2.iphmx.com
 [68.232.156.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 2175C60081A
 for <ltp@lists.linux.it>; Tue, 30 May 2023 07:52:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1685425958; x=1716961958;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=joVyNar4y1OjQlfjJOS/xPxhUq/n0YDx/nyZnMcdOSA=;
 b=qzTU26QmvoIaaG10b41RGdcORj+kjtpLb8p01WsN/TcOPEW4jVwoLpkg
 5GlFLp12S7KWe7oy+OBislEbvTcSq0HV1IIQ3WbkZYVw0B7cG3C43QShd
 uIS1vZtkuXWXCzvPK6V7++LRsD7E1mn3QqBkdOk+LePRroXLXVvi8vyRi
 9SWER4Q97hWKP9HHHZZhR8ygo6NR5v/plN64NMORxr+e2h13uAzG37GWw
 E4wVWcPv+bkEyzhDbzA0yHz3OSB3W1E/ggWMdXmkLJ/Ibn80z1b2NoIBG
 VZw21C5Tjsg0okbSy5e9PpNtJGMeQ7xg/JyvYt0MkJAEzeTk8mctzO1pX w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="85375170"
X-IronPort-AV: E=Sophos;i="6.00,203,1681138800"; d="scan'208";a="85375170"
Received: from mail-os0jpn01lp2107.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.107])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 May 2023 14:52:35 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lUKUnZBaT+lNAscxosl8q0iRRRnjO+p2Kya7QQdjJbEbM7MGJXbsgeUta2GrKFKUvk3gFMcTmGhedJ+gNzucUueJhovzoc5KD4JSlloigI266cFxwce44VivWZLHYV3K9mUmOIBi7WieFSD+rDjMx0QsbYuH1j2enAbQFYPVz+I8E+PSRYn+9XsBCd0vQqjpS3A6o3fivK/CbBZ2YyHnuWn80cB7alUaaxQk4oY1TtUPMFz8wjEdwmzPwMXvxDDl3h7w4Nn4i2luJ9efG1MzaKsNcE729BC2tlQSlCq3BZjzX0oraehR6TBgFch3/hJbnqFQpo7DJzHda40vEw2WsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joVyNar4y1OjQlfjJOS/xPxhUq/n0YDx/nyZnMcdOSA=;
 b=Mp6aOm9YpolyILZC8agTOjIELmaqHd+NZiZ3idNZEsOpKjlnGEezXLy2j5JYM7eDWVpvwXaXHHScUf7Hd5GDP1x0W38ksqAR12VdZuxYndSRmvGl/QsrP4pUr9b9EfZoPFjRzVmCCUcmUOC+gD3XQ7MLk06UODx8seB4gRGR/yRYNTFK9Pl6VHe3ZAeOgIOggVdkO/579Xwn1CFHhECvToR7hdOKPtR2wt7uR6tnvD17kaOiYpcGSsl+5XB/06q/BxdPkxMDq6gSNCkxzba7H+B7RfqtaFp7Q3KoRRb13FpNyRMXrBh6zJAIwnZE/k1hOCckZNL4ACd9FBLZX8A+5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB10725.jpnprd01.prod.outlook.com (2603:1096:400:2a5::7)
 by OS3PR01MB8397.jpnprd01.prod.outlook.com (2603:1096:604:190::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 05:52:31 +0000
Received: from TYWPR01MB10725.jpnprd01.prod.outlook.com
 ([fe80::1eae:326d:abf5:e4e1]) by TYWPR01MB10725.jpnprd01.prod.outlook.com
 ([fe80::1eae:326d:abf5:e4e1%6]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 05:52:31 +0000
From: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH] syscalls/statx12: Add basic test for
 STATX_ATTR_MOUNT_ROOT flag
Thread-Index: AQHZjJIV6twYozJWYEO5v0CAkhASs69xkw8AgADJpAA=
Date: Tue, 30 May 2023 05:52:31 +0000
Message-ID: <6390f43b-178d-f01d-70f0-6ce2832a6889@fujitsu.com>
References: <1684748642-6373-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <20230529175048.GA2021@pevik>
In-Reply-To: <20230529175048.GA2021@pevik>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB10725:EE_|OS3PR01MB8397:EE_
x-ms-office365-filtering-correlation-id: adb5328b-6864-47dd-0810-08db60d20f25
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mruSyLOMdxM1vYTaopo0KGcL1riUC+6GzQh2psCpdHKDvqzTRMq9AfzKUbrGvJhs2PpMSOeVVjbkTScYTfIxlxGtsQ7ImJcdNrI4fBUXUEt5Swy2LRviaId0BX5yvGzjnMwFC19/WTFmX+FJYDUBVmAXr8oRyckxJoe+5935pbt/rHav0GN9OVYnNE0BeKuS49vmPlfsCEq87eJDgXJBS4hzT+xJX6Wj0sYnYRUG2Q3dt8VIic5NLKvoc6wH0WfhTU3Qu21FNdQnns4zMejkjK5W/GrxB7s7A9SYHtnqCLy1+rUy7qcDLiTOcf1P7TyE9a0yhfT+D9fvpxeuoDUj/sEmtwspYJpNpUgGLAawIobkHgZ28tEXF1en9TA+8CMSCbJBmyGCWFdcxqJ797Nm8lWTKqpidFxoGX+ANZnupEZc7vvFoPxuDqsOC1FX0BcyVykFeSyWGosUSzuvOG69uIWAIcB/haJuO6CoViyqcw4hfTYgvnlB+n++hi4y/F0oTS+puTvZZkGYT6sZlsfXvkp4u5bkZ65Ewi5HqVIDEwhjdxFmu5ds28MJ28H4WxnvDY9qJig/oEneAteuZSx8lPYcbNt/40+HJ13SRlgy/auIEqMinlofPPmobATqKuB+j0vjPGtNm/XDmqK2XfcrflvDKzzMEBUETma+cKH65KtXqLTLWmxG7bfKS+F6Kph/
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYWPR01MB10725.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(376002)(366004)(39860400002)(396003)(1590799018)(451199021)(1580799015)(71200400001)(478600001)(8936002)(5660300002)(8676002)(85182001)(36756003)(38070700005)(2906002)(31696002)(86362001)(82960400001)(66556008)(4326008)(6916009)(66946007)(66446008)(122000001)(66476007)(76116006)(64756008)(316002)(91956017)(38100700002)(41300700001)(2616005)(186003)(6512007)(6506007)(26005)(6486002)(31686004)(83380400001)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VGxuMS8rRzU3bWkyRno1bzl0dnVHdjh3U04vQjNrdHA3ankwVkxCOVhDL0U3?=
 =?utf-8?B?bXRkQmt5YnFlbzRjRGMrYnRRdnJLaE0xb09uVXd6Yzh1azNhem5BVTBqbDAr?=
 =?utf-8?B?VWRCRXZYK2xpUW16cWFRb1Y3Y0hnR0NzN3daNUhPOWd5WG1WMW5QZzFhOGdD?=
 =?utf-8?B?alloYUR5K1RuZ3NlaklVS3R0d3JXWFZrcUlOdTFIMzdHRWV3MmN4V09xV3U2?=
 =?utf-8?B?SXZ1eitvWWpjUFFOYnpPeHA1QUFCUFVoVW5RYWpNV2ltNEN5VlhPT3NveGFt?=
 =?utf-8?B?cVlqMUszWkppRFl3c0tlcTFqUThaQXpDZ3hZMkp3N1B4dlo0UnJVbWFtQUly?=
 =?utf-8?B?blFSdi9SdEJBOE91Si8ydjNFWW5qa0V6RkVCVmtFbktmUFFQK0R5Qk1tR0Vk?=
 =?utf-8?B?Szl1WDJZTkdieVBGRjVDVys5WlprUDlxNVpwSnZueWZGc3N4SXpmRmFmWDF5?=
 =?utf-8?B?TW82OXViRVJKRnZXbEF0VHV0U1RmckthZ2hSRFNyeUkrMVFCaHRHRGQvZ0FR?=
 =?utf-8?B?OU1mSVVKU3ZVazZEcmlHRmxXeGpkREVSN1dHTGtqbG5rSW9ISXlLWDk4WE8z?=
 =?utf-8?B?ZmsrRjZ4Z3FqWEhQcGZQNDNOb05RQmVTd01Tb0l4WjdrdWNPL29IT2RiSERQ?=
 =?utf-8?B?Z2U0MUYxS3ZXS0xwSnpNSEMxYVh3RldxMmovVTFGNHZRQS9rdWh2OTh5V2VL?=
 =?utf-8?B?NTlBaEpJMmp3MGlpemFEdEN3QjV3eXZ6eFNOcFBhcUdxOHdCYzdva3VxeDVy?=
 =?utf-8?B?TVo5WXB0V0Ircnh3dFoycWdqVXJpdVovUFVZYTNpZ3pDMy8vWFpONGJtZk9r?=
 =?utf-8?B?bVBISUVvTFBqZkkxL09kbU4yakk3aFpNcjFlY0FqK2t0aCtJNWMxM2NXbVB3?=
 =?utf-8?B?eTYvNjRROVhuL0ZCdW80UkwrUnJ5dWQwNFFHTzRTMWJ4TlRhejFPcFd6YnNJ?=
 =?utf-8?B?enZBdUZXS3BxaFdXcmEvaXZmMW1nQUNKckxBRjlGTXFDL0VJd2ZFK0tVU1pi?=
 =?utf-8?B?K2ZteTJUSGM4YUFHZUZ2QTJvVzVnemxzencwam01RGNlblRwTzk3bzV6emJ6?=
 =?utf-8?B?eW1vZVBPV0tEVklhNVk2S1ZwU2dHS245elVDd1VOK3NxZ3JFbTFmWkJweStm?=
 =?utf-8?B?RUhzT3BnMldlZVBVTkhORmMyU1htYjBienJQU0Y3Qy9vSjdQTFBnem1LWTdV?=
 =?utf-8?B?UUVHQldkN2NHYThEd3FhK3FZRTFwMlltSEhzdkZpYURVQ0l2U2VXN1FnYmZq?=
 =?utf-8?B?cUlPNWNCUmdrWTd2c01WZjJVYXU0Q0ZjMjdCNmtuMDN3Mk4xSHN1RFJ0cFd5?=
 =?utf-8?B?aDlKTzZlQ2xvNnhEbklPOUFGclMrMC9PdlZHVmFQaGExTDE2TDlicHc2ZGU5?=
 =?utf-8?B?aGJHaVhvMWNwelZUUWl4OVFtNTBWbGN1cFlQK3FhVzRJMFNGSUE1VlExamg4?=
 =?utf-8?B?UWxXcGFMUGovaWN5MitBdzdvcU5oaTZ3UGZldXVDNnNPMkJaaFdCZEg4aUMv?=
 =?utf-8?B?RmY4WjhZeWh3cmRzcERwT00xdmJ4b2ppWmVNc1RNT3BrU29BV0tLSUxRNWFJ?=
 =?utf-8?B?aHNQT2RGZkd4QldjWXBMdnVTazRkTXoydnR3VTl0WkJ6dDFPTWhpUGNJdEN0?=
 =?utf-8?B?eWY2Q2psOHByZDV3Y3J5UDFITzFhSFZmTW5OTHNwSURMS0RpK1ZZTzBKMUVs?=
 =?utf-8?B?d1h6WTJ1L2pJZTdhNnkrVXRoOExhOGg2bVFjRkkvVy9STW1LcU5ZWlh5MzFj?=
 =?utf-8?B?azVoc0RtdEYramtTSDlUVUJZWVVWWEc5c0xXLzJPZEdZaHRYWFhOZkdWRHVP?=
 =?utf-8?B?RU5qcnlURG1YanIranFLdkM4RWVoVGhHNVJGVXBkQ09MakRCYTNIUWtzZzJh?=
 =?utf-8?B?NWNFVDhNa1Z1TEVSa1UybGxrbDRsYURCaWtsZStNSXc4Z25QaXlNQmpGdlpm?=
 =?utf-8?B?MHNVVjdTS0gwN3dOZFgzZXl6OFgyb3hVT3EzRG1QVlJuR1Jmay9CUlZSU1Vh?=
 =?utf-8?B?MTdOaVJIcktycVNtTUZFLzVIcjlHMS9Db2tUb1NKZmh1YlRTakRRU3I0ZGQ1?=
 =?utf-8?B?RUpta0pjSTJNRkxQV1grVHVocHpVUzQwVnZ2dmZqd2ZDcDdsN01wajByUGhm?=
 =?utf-8?B?Rkk3N3ZRL0pyVTA1MGV6UUVvNXhyMTlSSGNWTm5vSHJMTHEveHQzWjkxbmtU?=
 =?utf-8?B?cUE9PQ==?=
Content-ID: <A399D6B5EBA1144FB37234AA2E3D3ED5@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: BLInxd2/6+LH1Pwx+N86kSpSiP/jmD5MiYkCfiyKANGnzkQv2yQfa6bq4ATK95p5t4dFSJud9hTbONTtO1LVRDJFPqfqmaRuRUz6HZTQDdcPwFKjEJT8XRz3t+vJNqJiwFDjiKRYWvOUSOoSYb0vL+JmKORsUSkij4jUzB1PcU3eeeYCqWWgO7TevVOH4pPB/KPs9n6ORZfWHap2MYA4cVAO3BsM7Zz/1zX7FeuDxQhzJX1frR4rux/B+9UqLEOGAEt4Tq5ICLaeP+yUKk7tfEWCZfgO+OZSGlrmfLKVcDjDseqtkEG5UgUy1icRC5Uw/ZTPcZBkR/tCMZ4EDBH0TLzOV+lYwO00UES/ttFWf1M7X7STzX5E/8DNr/oN3ErJ6uoQpY7hWM3q/K8QWsFiMTmgv5gunv8hdE0+MN0ewMRDoo+64P9kR2IsN9SmzHxZ4VYIGVs8dNLb431bEuu+WoPxARxYk4XU+OljQXbpcPc+NEzn8xIdDauxUZvp88Zw7TiSLpaq0QkKOp3el6CwZ5siQAVq0+KR+2CfIgjgoC8GDXD44gs1Os2TNgIIPQZUfa/Va1qgxqX+LvnfFQA5MdmL+zaybxOBDVyIprbwIH0C5VFu6bpLV5kTFn8/3ssSNp5aOA8yAYlcZ5MaqpF3xYVx8VqQ8NwfAlmQuFpyuZuui3lleWBo1tN2Xmz1H6x7YreznWnduCEMmR8VC5fMSwpP2hOnb9qtdM9GfEzIWUm3ICYdN/IzwA3x9NYQef09JPH58zSIC2/fR/GGirUT5++fns042trP1quVX6avW3Q=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB10725.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adb5328b-6864-47dd-0810-08db60d20f25
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2023 05:52:31.5948 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DA5jwfXJ2+kJoQVxZdQkY6U4L7s860uUvBv7SRn/D54yF0Q0xp02nqA1j4o+p16AuzoEzoZKh2nM6XVSiG1utpM/YwRYyzr4msRZnfLbZF8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8397
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/statx12: Add basic test for
 STATX_ATTR_MOUNT_ROOT flag
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

Hi Petr


> Hi Xu,
> 
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> Tested-by: Petr Vorel <pvorel@suse.cz>
> 
> I tested it on recent kernel 6.3.1 and very old kernel 3.16.0.
> Works as expected.
> 
> 
>> This flag was introduced since kernel 5.10 and was used to indicates
> 
> 80340fe3605c ("statx: add mount_root") was released in v5.8. Unless you refer to
> something different, please update it here.
# git tag --contains 80340fe3
Oh, sorry, I used the following command to search and miss v5.8
v5.10
v5.10-rc1
v5.10-rc2
v5.10-rc3
v5.10-rc4
v5.10-rc5
v5.10-rc6
v5.10-rc7
v5.11
v5.11-rc1
v5.11-rc2
v5.11-rc3
v5.11-rc4
v5.11-rc5
v5.11-rc6
v5.11-rc7
v5.12
v5.12-rc1
v5.12-rc1-dontuse
v5.12-rc2
v5.12-rc3
v5.12-rc4
v5.12-rc5
v5.12-rc6
v5.12-rc7
....
v5.8-rc1

> 
>> whether the path or fd refers to the root of a mount or not.
> 
>> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
>> ---
>>   include/lapi/stat.h                        |   4 +
>>   runtest/syscalls                           |   1 +
>>   testcases/kernel/syscalls/statx/.gitignore |   1 +
>>   testcases/kernel/syscalls/statx/statx12.c  | 101 +++++++++++++++++++++
>>   4 files changed, 107 insertions(+)
>>   create mode 100644 testcases/kernel/syscalls/statx/statx12.c
> 
>> diff --git a/include/lapi/stat.h b/include/lapi/stat.h
>> index c7e6fdac0..3606c9eb0 100644
>> --- a/include/lapi/stat.h
>> +++ b/include/lapi/stat.h
>> @@ -221,6 +221,10 @@ static inline int statx(int dirfd, const char *pathname, unsigned int flags,
>>   # define STATX_ATTR_AUTOMOUNT	0x00001000
>>   #endif
> 
>> +#ifndef STATX_ATTR_MOUNT_ROOT
>> +# define STATX_ATTR_MOUNT_ROOT	0x00002000
>> +#endif
>> +
>>   #ifndef STATX_ATTR_VERITY
>>   # define STATX_ATTR_VERITY	0x00100000
>>   #endif
>> diff --git a/runtest/syscalls b/runtest/syscalls
>> index e5ad2c2f9..0c1993421 100644
>> --- a/runtest/syscalls
>> +++ b/runtest/syscalls
>> @@ -1767,6 +1767,7 @@ statx08 statx08
>>   statx09 statx09
>>   statx10 statx10
>>   statx11 statx11
>> +statx12 statx12
> 
>>   membarrier01 membarrier01
> 
>> diff --git a/testcases/kernel/syscalls/statx/.gitignore b/testcases/kernel/syscalls/statx/.gitignore
>> index 48ac4078b..f6a423eed 100644
>> --- a/testcases/kernel/syscalls/statx/.gitignore
>> +++ b/testcases/kernel/syscalls/statx/.gitignore
>> @@ -9,3 +9,4 @@
>>   /statx09
>>   /statx10
>>   /statx11
>> +/statx12
>> diff --git a/testcases/kernel/syscalls/statx/statx12.c b/testcases/kernel/syscalls/statx/statx12.c
>> new file mode 100644
>> index 000000000..ae6bbb1e2
>> --- /dev/null
>> +++ b/testcases/kernel/syscalls/statx/statx12.c
>> @@ -0,0 +1,101 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (c) 2023 FUJITSU LIMITED. All rights reserved.
>> + * Author: Yang Xu <xuyang2018.jy@fujitsu.com>
>> + */
>> +
>> +/*\
>> + * [Description]
>> + *
>> + * It is a basic test for STATX_ATTR_MOUNT_ROOT flag.
>> + *
>> + * This flag indicates whether the path or fd refers to the root of a mount
>> + * or not.
>> + *
>> + * Minimum Linux version required is v5.10.
> And here as well.

Yes.
>> + */
>> +
>> +#define _GNU_SOURCE
>> +#include <sys/types.h>
>> +#include <sys/mount.h>
> Do we need these two for anything?
I guess we can remove them.
> 
>> +#include <unistd.h>
>> +#include <stdlib.h>
>> +#include <stdbool.h>
>> +#include <stdio.h>
>> +#include "tst_test.h"
>> +#include "lapi/stat.h"
>> +
>> +#define MNTPOINT "mntpoint"
>> +#define TESTFILE MNTPOINT"/testfile"
>> +
>> +static int dir_fd = -1, file_fd = -1;
>> +
>> +static struct tcase {
>> +	const char *path;
>> +	int mnt_root;
>> +	int flag;
> Since you're already using <stdbool.h>, mnt_root and flag could be bool.

Yes.
>> +	int *fd;
>> +} tcases[] = {
>> +	{MNTPOINT, 1, 1, &dir_fd},
>> +	{MNTPOINT, 1, 0, &dir_fd},
>> +	{TESTFILE, 0, 1, &file_fd},
>> +	{TESTFILE, 0, 0, &file_fd}
> I'd even consider replacing int flag in struct with counted from n:
> 
> static struct tcase {
> 	const char *path;
> 	bool mnt_root;
> 	int *fd;
> } tcases[] = {
> 	{MNTPOINT, 1, &dir_fd},
> 	{TESTFILE, 0, &file_fd}
> };
> 
> static void verify_statx(unsigned int n)
> {
> 	struct tcase *tc = &tcases[n/2];
> 	struct statx buf;
> 	bool flag = n % 2;
> 
> 	if (flag) {
> 		tst_res(TINFO, "Testing %s with STATX_ATTR_MOUNT_ROOT by fd",
> 				tc->path);
> 		TST_EXP_PASS_SILENT(statx(*tc->fd, "", AT_EMPTY_PATH, 0, &buf));
> 	} else {
> 		tst_res(TINFO, "Testing %s with STATX_ATTR_MOUNT_ROOT by path",
> 				tc->path);
> 
> 		TST_EXP_PASS_SILENT(statx(AT_FDCWD, tc->path, 0, 0, &buf));
> 	}
> 	...
> 
> static struct tst_test test = {
> 	...
> 	.tcnt = 2* ARRAY_SIZE(tcases)
> 
> 
>> +};
>> +
>> +static void verify_statx(unsigned int n)
>> +{
>> +	struct tcase *tc = &tcases[n];
>> +	struct statx buf;
>> +
>> +	if (tc->flag) {
>> +		tst_res(TINFO, "Testing %s with STATX_ATTR_MOUNT_ROOT by path",
>> +				tc->path);
>> +
>> +		TST_EXP_PASS_SILENT(statx(AT_FDCWD, tc->path, 0, 0, &buf),
>> +			"statx(AT_FDCWD, %s, 0, 0, &buf)", tc->path);
> nit: I wonder if we need to duplicate the call in string, just to get tc->path,
> which we have printed in TINFO above. Wouldn't be enough just:
> 		TST_EXP_PASS_SILENT(statx(AT_FDCWD, tc->path, 0, 0, &buf));

Sound reasonable.
> 
>> +	} else {
>> +		tst_res(TINFO, "Testing %s with STATX_ATTR_MOUNT_ROOT by fd",
>> +				tc->path);
>> +		TST_EXP_PASS_SILENT(statx(*tc->fd, "", AT_EMPTY_PATH, 0, &buf),
>> +			"statx(%d, "", 0, 0, &buf)", *tc->fd);
> Well, here you probably meant
> 		TST_EXP_PASS_SILENT(statx(*tc->fd, "", AT_EMPTY_PATH, 0, &buf),
> 			"statx(%d, \"\", 0, 0, &buf)", *tc->fd);
> checkpatch.pl (via make check-statx12) warns about it (slightly cryptic):
> statx12.c:60: WARNING: Consecutive strings are generally better as a single string
> TODO: this is the second thing which should be fixed before merge.

Sound reasonable.
> 
> But again, I'd go just for:
> 		TST_EXP_PASS_SILENT(statx(*tc->fd, "", AT_EMPTY_PATH, 0, &buf));

OK.
>> +	}
>> +
>> +	if (!(buf.stx_attributes_mask & STATX_ATTR_MOUNT_ROOT)) {
>> +		tst_res(TCONF, "Filesystem does not support STATX_ATTR_MOUNT_ROOT");
>> +		return;
>> +	}
>> +
>> +	if (buf.stx_attributes & STATX_ATTR_MOUNT_ROOT) {
>> +		tst_res(tc->mnt_root ? TPASS : TFAIL,
>> +			"STATX_ATTR_MOUNT_ROOT flag is set");
>> +	} else {
>> +		tst_res(tc->mnt_root ? TFAIL : TPASS,
>> +			"STATX_ATTR_MOUNT_ROOT flag is not set");
>> +	}
>> +}
>> +
>> +static void setup(void)
>> +{
>> +	SAFE_CREAT(TESTFILE, 0755);
>> +	dir_fd = SAFE_OPEN(MNTPOINT, O_DIRECTORY);
>> +	file_fd = SAFE_OPEN(TESTFILE, O_RDWR);
>> +}
>> +
>> +static void cleanup(void)
>> +{
>> +	if (dir_fd > -1)
>> +		SAFE_CLOSE(dir_fd);
> nit: Here could be empty line (readability).
>> +	if (file_fd > -1)
>> +		SAFE_CLOSE(file_fd);
>> +}
>> +
>> +static struct tst_test test = {
>> +	.test = verify_statx,
>> +	.setup = setup,
>> +	.cleanup = cleanup,
>> +	.mntpoint = MNTPOINT,
>> +	.mount_device = 1,
>> +	.all_filesystems = 1,
>> +	.needs_root = 1,
>> +	.tcnt = ARRAY_SIZE(tcases)
>> +};
> 
> All my suggestion (ok to ignore).

I agree with your all suggestion.

Best Regards
Yang Xu
> 
> Kind regards,
> Petr
> 
> diff --git testcases/kernel/syscalls/statx/statx12.c testcases/kernel/syscalls/statx/statx12.c
> index 40367c8b1..6b76b6e49 100644
> --- testcases/kernel/syscalls/statx/statx12.c
> +++ testcases/kernel/syscalls/statx/statx12.c
> @@ -12,12 +12,10 @@
>    * This flag indicates whether the path or fd refers to the root of a mount
>    * or not.
>    *
> - * Minimum Linux version required is v5.10.
> + * Minimum Linux version required is v5.8.
>    */
>   
>   #define _GNU_SOURCE
> -#include <sys/types.h>
> -#include <sys/mount.h>
>   #include <unistd.h>
>   #include <stdlib.h>
>   #include <stdbool.h>
> @@ -32,32 +30,27 @@ static int dir_fd = -1, file_fd = -1;
>   
>   static struct tcase {
>   	const char *path;
> -	int mnt_root;
> -	int flag;
> +	bool mnt_root;
>   	int *fd;
>   } tcases[] = {
> -	{MNTPOINT, 1, 1, &dir_fd},
> -	{MNTPOINT, 1, 0, &dir_fd},
> -	{TESTFILE, 0, 1, &file_fd},
> -	{TESTFILE, 0, 0, &file_fd}
> +	{MNTPOINT, 1, &dir_fd},
> +	{TESTFILE, 0, &file_fd}
>   };
>   
>   static void verify_statx(unsigned int n)
>   {
> -	struct tcase *tc = &tcases[n];
> +	struct tcase *tc = &tcases[n/2];
>   	struct statx buf;
> +	bool flag = n % 2;
>   
> -	if (tc->flag) {
> -		tst_res(TINFO, "Testing %s with STATX_ATTR_MOUNT_ROOT by path",
> +	if (flag) {
> +		tst_res(TINFO, "Testing %s with STATX_ATTR_MOUNT_ROOT by fd",
>   				tc->path);
> -
> -		TST_EXP_PASS_SILENT(statx(AT_FDCWD, tc->path, 0, 0, &buf),
> -			"statx(AT_FDCWD, %s, 0, 0, &buf)", tc->path);
> +		TST_EXP_PASS_SILENT(statx(*tc->fd, "", AT_EMPTY_PATH, 0, &buf));
>   	} else {
> -		tst_res(TINFO, "Testing %s with STATX_ATTR_MOUNT_ROOT by fd",
> +		tst_res(TINFO, "Testing %s with STATX_ATTR_MOUNT_ROOT by path",
>   				tc->path);
> -		TST_EXP_PASS_SILENT(statx(*tc->fd, "", AT_EMPTY_PATH, 0, &buf),
> -			"statx(%d, "", 0, 0, &buf)", *tc->fd);
> +		TST_EXP_PASS_SILENT(statx(AT_FDCWD, tc->path, 0, 0, &buf));
>   	}
>   
>   	if (!(buf.stx_attributes_mask & STATX_ATTR_MOUNT_ROOT)) {
> @@ -85,6 +78,7 @@ static void cleanup(void)
>   {
>   	if (dir_fd > -1)
>   		SAFE_CLOSE(dir_fd);
> +
>   	if (file_fd > -1)
>   		SAFE_CLOSE(file_fd);
>   }
> @@ -97,5 +91,5 @@ static struct tst_test test = {
>   	.mount_device = 1,
>   	.all_filesystems = 1,
>   	.needs_root = 1,
> -	.tcnt = ARRAY_SIZE(tcases)
> +	.tcnt = 2* ARRAY_SIZE(tcases)
>   };

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
