Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3580EC7EE23
	for <ltp@archiver.kernel.org>; Fri,  2 Jun 2023 03:13:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2D08C3CFC95
	for <ltp@archiver.kernel.org>; Fri,  2 Jun 2023 05:13:50 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8408F3CD47A
 for <ltp@lists.linux.it>; Fri,  2 Jun 2023 05:13:33 +0200 (CEST)
Received: from esa19.fujitsucc.c3s2.iphmx.com (esa19.fujitsucc.c3s2.iphmx.com
 [216.71.158.62])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C03671A00924
 for <ltp@lists.linux.it>; Fri,  2 Jun 2023 05:13:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1685675611; x=1717211611;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=XCVrQViJX8ht8WqRTJWR75ZzTcrlryKJvbHldpG3JW8=;
 b=hkKkb01WlNHHDGACeFevzf99mAMa2v9zj7BPODO9P+IaiSJ0megnlPqb
 5LBOiiS3tLgSP2QfUs52Xq4liPtZG5S6DfWKPLKECI62oHLVF5xCf6Dz+
 Iq2vZxewiyh+szpp0upYmdrR9ZzJMA7jDjaub41r4320iFFrk9BhYIGV1
 z32WNEmjMYRm5V55zfMAnnutc104svCeZXKGxg2JxWPXG4A40PZOx/d9t
 w95XE1KRyYBHlBP3oNnPDmmaZqMIXMkbNMRDYq903MbxI3e/jwR3PQeC5
 /m1DGaEqxMneUwt3TKZYJbVS7PkNLlBG6tkMpCKxFPi+BRA+QL2wFcMuo g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="85670102"
X-IronPort-AV: E=Sophos;i="6.00,211,1681138800"; d="scan'208";a="85670102"
Received: from mail-tycjpn01lp2175.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.175])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2023 12:13:28 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j4hL2NkwetKlD9/X9wPQEKDsc8byBR1WJ2DX+hQ2bSuQqO+ejyj6EH2ZrDjtPUlfPV3YLi/XssJBGQJkkRfOYilyxW3j4aebIyDd6hogugyOiBvJavXUhdXk7k1bCJ0X26T7y4/AKqRGihtvXSOs69OAFzp55/Nhf4/UZASj+F+YpLJ7m8xu7YTPPFpXEWFMDopl1xPmDr4mssWWhplPT7V2SBkwY0lWcFdogE8b6PNuwmFWK430HFDESk1TqbMVi2D8Iv8EeSB9iZAlCrJa0h7PcEnNFmN53TlwfDjHE9VLdAaDFWZjl9UaEYhHWRR+FUvcaTb4/hL9kVnZIakM1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XCVrQViJX8ht8WqRTJWR75ZzTcrlryKJvbHldpG3JW8=;
 b=LpA4+TGRvfzaUOH1dNEByaKbI5GSpyxt/5mTni8MwmDXY9CZcqR9DZqi6mxy5pWAPoOSfeyHiKjJAe2pTHmYblDQdhAa2BlH/kP1lK9wSMSbQy3+I+SqICd/Kai3jmeSINiaWgrGllX8ALTC//F3htfPgOzmfakeiAVQaNLr9GYqNAN5x/XyFpw9bSDAjNdlK625CmkzvnItuCJBVwVPFbauW22rpN0wXUIVf6QIGeBqwfOWS9ZaYc8Z6DS4lwKR9fDGeJ5ZrkpWfkFkKEjaeZOzvccP14Gedq8tm3IbZyFuj8b7B8Xo3lOn2qhZNy/UxZ7tzSp0tTeQE5MZGZO+xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB10725.jpnprd01.prod.outlook.com (2603:1096:400:2a5::7)
 by TYWPR01MB8824.jpnprd01.prod.outlook.com (2603:1096:400:16e::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Fri, 2 Jun
 2023 03:13:25 +0000
Received: from TYWPR01MB10725.jpnprd01.prod.outlook.com
 ([fe80::1eae:326d:abf5:e4e1]) by TYWPR01MB10725.jpnprd01.prod.outlook.com
 ([fe80::1eae:326d:abf5:e4e1%3]) with mapi id 15.20.6455.024; Fri, 2 Jun 2023
 03:13:25 +0000
From: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH] syscalls/statx12: Add basic test for
 STATX_ATTR_MOUNT_ROOT flag
Thread-Index: AQHZjJIV6twYozJWYEO5v0CAkhASs69xkw8AgADJpACABIqJgA==
Date: Fri, 2 Jun 2023 03:13:25 +0000
Message-ID: <696c04fd-652c-e2fc-c586-70862f80b7ab@fujitsu.com>
References: <1684748642-6373-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <20230529175048.GA2021@pevik>
 <6390f43b-178d-f01d-70f0-6ce2832a6889@fujitsu.com>
In-Reply-To: <6390f43b-178d-f01d-70f0-6ce2832a6889@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB10725:EE_|TYWPR01MB8824:EE_
x-ms-office365-filtering-correlation-id: cf01afd1-4e96-409f-d97c-08db63175454
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JsuuTYLnAC4oqx1bSjyM1mw7qQJppP11mdkLpGOYLAysz8s7nmr5kU+YKLgSx/8L/n0/+lqdQwz5SBkjMA1XI4/22ayteRM9wXcaWMJfxF09XGbKq78Gug9vLhk36ZGdlAAp5iqK9//Ur1ZeRtjdf3lRl1DJDRV2qfBWiJgO/Y0KfTqrxyuFzW291WW2XltZJwHC8bNHn5t57LupoicqphO1WvWrO7c1Zrs8za0d4ZMS5RDU7kyQ/la2oQ7v4IkDSglKq8HKaLASygVC5WI66NLurS5uTWlcGLyARfAQGdgONlzKVHXS3USuaoViNIK7qwEShNc/v1zf3zODK5JM7OEVzEdoqPl4wwXO/iJ2qp6q+WEdpcV6oumpEGjCFKImsBEqx0WxSRrcOdhN1pckvIale+pKlPTyQ64ixa3DMBCTZz6GDJWzvuGT+1wEWTwxrUPtbDqCLyCMWmoG4tkVTCLUdRMoKxZb9vm8omhqphXSEWEBZ+/rksUEqxRBSeEw6g1QP1VPpDe+t/fPlXD8oTnJ3GxcAOULfg1zlzENFJ9nWOBPQgddfPgTGHpPg3UjfkmRSOU8bhMCs6y3wG7riGNikUQbvylDoo/0smL1pc9ewlgMyn0qweUheWywFJ6URxWPy7DESERYYK93rchVAjYlDrUkY/hXSGNcW2iyVwkQy8WWvz5Ex5f18hxjVWXB
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYWPR01MB10725.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(39860400002)(136003)(346002)(396003)(376002)(451199021)(1590799018)(91956017)(66476007)(66446008)(4326008)(6916009)(66946007)(31686004)(76116006)(5660300002)(8936002)(66556008)(316002)(64756008)(41300700001)(1580799015)(2906002)(8676002)(71200400001)(478600001)(6486002)(6506007)(6512007)(83380400001)(2616005)(186003)(26005)(36756003)(85182001)(122000001)(82960400001)(86362001)(38100700002)(38070700005)(31696002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZjRLMWdab0ZWbjcyZEg5dzNncFNjZUV5WjI4WUtzc2xhWGlDRDJHeStmdU01?=
 =?utf-8?B?ZFQ3MnRBN0VxSEFlaXRhWXBRRWVucTU1aERrVWoxT3lnTy9oa0Q2WWNVanJz?=
 =?utf-8?B?S2hRV0tNaVNYTGRiOFllaTlXNkdLSlg2cXFaL0s2cktWNEhPRHZVTG9GZVpQ?=
 =?utf-8?B?RTYrV1EzbUFTUjhxWmpwOVNZaHg5OFZJUmVaOTA1MjllVDVJaXZpMjMrT0cv?=
 =?utf-8?B?M2NzWmR0N1ZyYzV0bDJ5NEtpTzRxVEQrUnp4WmRvV0t2SVRTdXczTjRydHpw?=
 =?utf-8?B?RjhpcVpFNnV2L0hnZVFmVFRxYmcrMStEWjcvWGpBbWFPeG8wRmN5Qm9adDB5?=
 =?utf-8?B?aUh6YnZ5V3c5MkM3d1J5Wm9KUlVYNHUrVlZlR3ZDTEFtUEt6bld3NjBpZWdR?=
 =?utf-8?B?dlo5K3dxUE9zcm01YjRLTk4xYWVkclZhVFpzK0FxZWNZQ1lSM2VlN2ZYWklS?=
 =?utf-8?B?Z2NEV3FXSEVIS2k3NnZOQzgvaEx1MEtiWEtlZUdpYmVLWjNPaEdxcVZZbmJD?=
 =?utf-8?B?ZjNVeThPdEE0TU40dkJ1Mm9iazRWS25QWldneSt4WTRyR2U3d0RHOXhXTDFX?=
 =?utf-8?B?WVlPUXJBVXRWTDhJZ2pRSThtN3Jpc1hvTDdjVE0yQUJXY1FyZkQ2NVJCUC9j?=
 =?utf-8?B?RTd4a0F4T3VsOWdkLzVmdnpYZEdWR3hORmhmazNObmx4VzJWVjQyWTkvTWw3?=
 =?utf-8?B?ZFZjY20ramVYM0o2Q01vRDNqRnJoVVJxZVQ3VkpPMTFETXJVZEx6UUVvVFJz?=
 =?utf-8?B?RzFwRnI0Qm0zRzZITWRDWGFLYllIU1FRYXlBT1BocjFBTmpqUjF1NTV3Q3hp?=
 =?utf-8?B?ZXRwcHQ2QzNULzM3djQ2V2NTRngwbTFsSit5RlVTZFd4VS9SZklsM0Y5K1Qy?=
 =?utf-8?B?aGNVWlJOa1BjY1VnRW93RllXNXFsUkxsVmZvMFlPUU0yVDBNbzc4K2FJdWlk?=
 =?utf-8?B?bm5XQ3VCWjZuRklrYmNseWI4T3IvT3k0ZUtkQXRDSk1MdW10VmgzNnd2UjE1?=
 =?utf-8?B?ZlBNU2Z5VG4rcUJTVE9BTm9ZTll5b3VkSkhUc20vV0QzSkNqUnJCUUlGTFdz?=
 =?utf-8?B?N0UzTHp1emZwOGpvdjVRVXcwKzZWbTJHZ0I5a2tYaGpEMHFHQUlONmE5b2N0?=
 =?utf-8?B?cnBZUXRoZmxGNFpVelFKOGpCN2dqT2lDaENhTzdvU09YTjFyKzgvMmQ4eU9M?=
 =?utf-8?B?c1pJUFNXaElYWXdSNGVHSk5CT3hYY2hJZVNYb3VMdXBxVE43L0xaYXU5MW16?=
 =?utf-8?B?aHdicE9FNXFYTGZvQjQ0d3gxcm42b0hoMlJWOFN1cFpZZzhDMEtNcnlRN3Yy?=
 =?utf-8?B?VllQbDdDeHVnd2tJaHJhV0U5SFg2LzlkV0txelljYzhERllFbm5Yc1F4K3Bl?=
 =?utf-8?B?L2NFZXcwRXoyVXFCYlpaZ2NialFDcHVMQkU2d0E2eEJndGhySEVQdjluUC9h?=
 =?utf-8?B?U0FYQVFNNnZJb1dJdDhLT0JZbVNCNkwyVU1iOUtxSTNEYzlXcURPNEk1RmpJ?=
 =?utf-8?B?SWZRcDNLdHdtYU1KUjZRZ2ovb2lrR1UvNm9Iam5XNWVMSWdwdGNCVzZjT2Vs?=
 =?utf-8?B?aStQY2oxd1cvRUVKY0lSOHpOOUY2c3U3UXQ4V3BUMEFLV0p6TE9MWnZXM1Uz?=
 =?utf-8?B?WkhGVVlja0NIajcyTVNTZjlId2w5MTVkUVMzZGNqVjhid0IrVzFadGtHdkYr?=
 =?utf-8?B?bklteEc0dDBMSkxrbEpOY2FJU295bGcxRVpvT29ZYnMwS2JUL3pVaWcvYmto?=
 =?utf-8?B?b2UrVkxua01iejF4RERueWlOZllZTHJTd0FkbjFTbW5IQUY0QnZDc05oMkFj?=
 =?utf-8?B?MTEyL2kreld4NUVuWmxFM1h2dTdES3RleGtqZ3dPRjZrZkdXNTNra3oxenc4?=
 =?utf-8?B?dmxBakFRVys5eWVrWHo1WEsxQVJuR1VqRVpvRy9WVkVuNU9UWjVVQ2d1N2h5?=
 =?utf-8?B?UkFMVmFEU1IvcDhKb0g4SmxkaUlFZjZzWDFhWm4xb1U3RytmaEx6WWFrODU4?=
 =?utf-8?B?WVk4RFphb2pKeEpwc0lvQ2ZTL0dWWUt1RmwxWDY3NFc5cEhKaGlISTZEaXVH?=
 =?utf-8?B?dE5NNmN2NThUTlJxWlpjbXdJbnNKZHdVNlZiTEpJWmRGNEgzaTloOUdxUm1u?=
 =?utf-8?B?RGFFUjVsdWUyQjZpNmo5MlFxV28yUERYZnZma1JaRmlZU1cvajZadUY2alpC?=
 =?utf-8?B?VkE9PQ==?=
Content-ID: <F4A3B5D8CE92404EBACCDC281695C3EE@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: gd4UHq2kRS5sUCXhWNgP9KLFEKy5KfN51yocyg6v7CNGMVSv5WGFh6B7Tw9JYyLHaw+0lxbwMkSMMV3WV+gFih6vsLvl3v5mPgANaIXKH03iZncW8NAUuNsP/4LEO5MJBjnESIf4VTVZ9dvdYz3w5QdB5Yj72K2dxNW/2k5Cy+6KiorbVElOVGJ6mdPc+QlsWpuzDz3yuPGXcV89IKvku9spoJ/cCw0pPiUxcAO4FH4ycYrGr7gHib+7OPRqw0GntYJ29eXua4Q78wEDR78/OQxbNAYJAqJxrOvD8SDU4d4RZc5o9q3kIHkgtr4rDmhiNK1X290OrTxpmMAevU6JbdJEL/6P/Ms4BrbckJJgVxteGKPKsLZ//7/Ylq7eWYYsracKy3PkuYr8gwFQKDaIglkVL/lNcMnTWCa34KJwE8asQc8bd9pFnhjRjLPmg+a5SMz6EzqFnMLKLJZXK881Fd+9KF5r7gaVkPv0PHGQvegn7tDf48Sm866NMCUE+jtcgzc1QMFVA47M/OxQABAt+FpzrcaB/bpJevnj45EimUdAtaEDSzuTRBPPJozN441MWe1yp+WmQ+zZC2oAkn8gi+j0bcg7cT8FxoXyDJxOIx4LD3aVg5E7xZ3BI0XlSMGe5bbFtv3M2m1hJxp911hjJv2IIbZH6ubt6tEZadq043du5bnIDFHyU8RUuBgYCy6G1foL0lyhlujSush+GlA3FYlsCM+pYcGMVVJfHvbuNLr0P8K+4AkW+ZM5D0hn6lrbpQxICZ0kseJPoPU3JqSJmgHinYSFFoHZMLNm2yP4INM=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB10725.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf01afd1-4e96-409f-d97c-08db63175454
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2023 03:13:25.3000 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gmVhRkMYz/RCASqrbEGKxJ+HZX94yqAQHQjSDjIJSq/rQzpeWMEkmIB0qA45sbhxWG3SGwZ1NbiWAxoQ4Awrb/TLX9hsVN2Gg6agfHHeF1k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8824
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
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

Should I send a v2 patch for this, or you merged the modified patch 
directly.


Best Regards
Yang Xu
> Hi Petr
> 
> 
>> Hi Xu,
>>
>> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>> Tested-by: Petr Vorel <pvorel@suse.cz>
>>
>> I tested it on recent kernel 6.3.1 and very old kernel 3.16.0.
>> Works as expected.
>>
>>
>>> This flag was introduced since kernel 5.10 and was used to indicates
>>
>> 80340fe3605c ("statx: add mount_root") was released in v5.8. Unless you refer to
>> something different, please update it here.
> # git tag --contains 80340fe3
> Oh, sorry, I used the following command to search and miss v5.8
> v5.10
> v5.10-rc1
> v5.10-rc2
> v5.10-rc3
> v5.10-rc4
> v5.10-rc5
> v5.10-rc6
> v5.10-rc7
> v5.11
> v5.11-rc1
> v5.11-rc2
> v5.11-rc3
> v5.11-rc4
> v5.11-rc5
> v5.11-rc6
> v5.11-rc7
> v5.12
> v5.12-rc1
> v5.12-rc1-dontuse
> v5.12-rc2
> v5.12-rc3
> v5.12-rc4
> v5.12-rc5
> v5.12-rc6
> v5.12-rc7
> ....
> v5.8-rc1
> 
>>
>>> whether the path or fd refers to the root of a mount or not.
>>
>>> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
>>> ---
>>>    include/lapi/stat.h                        |   4 +
>>>    runtest/syscalls                           |   1 +
>>>    testcases/kernel/syscalls/statx/.gitignore |   1 +
>>>    testcases/kernel/syscalls/statx/statx12.c  | 101 +++++++++++++++++++++
>>>    4 files changed, 107 insertions(+)
>>>    create mode 100644 testcases/kernel/syscalls/statx/statx12.c
>>
>>> diff --git a/include/lapi/stat.h b/include/lapi/stat.h
>>> index c7e6fdac0..3606c9eb0 100644
>>> --- a/include/lapi/stat.h
>>> +++ b/include/lapi/stat.h
>>> @@ -221,6 +221,10 @@ static inline int statx(int dirfd, const char *pathname, unsigned int flags,
>>>    # define STATX_ATTR_AUTOMOUNT	0x00001000
>>>    #endif
>>
>>> +#ifndef STATX_ATTR_MOUNT_ROOT
>>> +# define STATX_ATTR_MOUNT_ROOT	0x00002000
>>> +#endif
>>> +
>>>    #ifndef STATX_ATTR_VERITY
>>>    # define STATX_ATTR_VERITY	0x00100000
>>>    #endif
>>> diff --git a/runtest/syscalls b/runtest/syscalls
>>> index e5ad2c2f9..0c1993421 100644
>>> --- a/runtest/syscalls
>>> +++ b/runtest/syscalls
>>> @@ -1767,6 +1767,7 @@ statx08 statx08
>>>    statx09 statx09
>>>    statx10 statx10
>>>    statx11 statx11
>>> +statx12 statx12
>>
>>>    membarrier01 membarrier01
>>
>>> diff --git a/testcases/kernel/syscalls/statx/.gitignore b/testcases/kernel/syscalls/statx/.gitignore
>>> index 48ac4078b..f6a423eed 100644
>>> --- a/testcases/kernel/syscalls/statx/.gitignore
>>> +++ b/testcases/kernel/syscalls/statx/.gitignore
>>> @@ -9,3 +9,4 @@
>>>    /statx09
>>>    /statx10
>>>    /statx11
>>> +/statx12
>>> diff --git a/testcases/kernel/syscalls/statx/statx12.c b/testcases/kernel/syscalls/statx/statx12.c
>>> new file mode 100644
>>> index 000000000..ae6bbb1e2
>>> --- /dev/null
>>> +++ b/testcases/kernel/syscalls/statx/statx12.c
>>> @@ -0,0 +1,101 @@
>>> +// SPDX-License-Identifier: GPL-2.0-or-later
>>> +/*
>>> + * Copyright (c) 2023 FUJITSU LIMITED. All rights reserved.
>>> + * Author: Yang Xu <xuyang2018.jy@fujitsu.com>
>>> + */
>>> +
>>> +/*\
>>> + * [Description]
>>> + *
>>> + * It is a basic test for STATX_ATTR_MOUNT_ROOT flag.
>>> + *
>>> + * This flag indicates whether the path or fd refers to the root of a mount
>>> + * or not.
>>> + *
>>> + * Minimum Linux version required is v5.10.
>> And here as well.
> 
> Yes.
>>> + */
>>> +
>>> +#define _GNU_SOURCE
>>> +#include <sys/types.h>
>>> +#include <sys/mount.h>
>> Do we need these two for anything?
> I guess we can remove them.
>>
>>> +#include <unistd.h>
>>> +#include <stdlib.h>
>>> +#include <stdbool.h>
>>> +#include <stdio.h>
>>> +#include "tst_test.h"
>>> +#include "lapi/stat.h"
>>> +
>>> +#define MNTPOINT "mntpoint"
>>> +#define TESTFILE MNTPOINT"/testfile"
>>> +
>>> +static int dir_fd = -1, file_fd = -1;
>>> +
>>> +static struct tcase {
>>> +	const char *path;
>>> +	int mnt_root;
>>> +	int flag;
>> Since you're already using <stdbool.h>, mnt_root and flag could be bool.
> 
> Yes.
>>> +	int *fd;
>>> +} tcases[] = {
>>> +	{MNTPOINT, 1, 1, &dir_fd},
>>> +	{MNTPOINT, 1, 0, &dir_fd},
>>> +	{TESTFILE, 0, 1, &file_fd},
>>> +	{TESTFILE, 0, 0, &file_fd}
>> I'd even consider replacing int flag in struct with counted from n:
>>
>> static struct tcase {
>> 	const char *path;
>> 	bool mnt_root;
>> 	int *fd;
>> } tcases[] = {
>> 	{MNTPOINT, 1, &dir_fd},
>> 	{TESTFILE, 0, &file_fd}
>> };
>>
>> static void verify_statx(unsigned int n)
>> {
>> 	struct tcase *tc = &tcases[n/2];
>> 	struct statx buf;
>> 	bool flag = n % 2;
>>
>> 	if (flag) {
>> 		tst_res(TINFO, "Testing %s with STATX_ATTR_MOUNT_ROOT by fd",
>> 				tc->path);
>> 		TST_EXP_PASS_SILENT(statx(*tc->fd, "", AT_EMPTY_PATH, 0, &buf));
>> 	} else {
>> 		tst_res(TINFO, "Testing %s with STATX_ATTR_MOUNT_ROOT by path",
>> 				tc->path);
>>
>> 		TST_EXP_PASS_SILENT(statx(AT_FDCWD, tc->path, 0, 0, &buf));
>> 	}
>> 	...
>>
>> static struct tst_test test = {
>> 	...
>> 	.tcnt = 2* ARRAY_SIZE(tcases)
>>
>>
>>> +};
>>> +
>>> +static void verify_statx(unsigned int n)
>>> +{
>>> +	struct tcase *tc = &tcases[n];
>>> +	struct statx buf;
>>> +
>>> +	if (tc->flag) {
>>> +		tst_res(TINFO, "Testing %s with STATX_ATTR_MOUNT_ROOT by path",
>>> +				tc->path);
>>> +
>>> +		TST_EXP_PASS_SILENT(statx(AT_FDCWD, tc->path, 0, 0, &buf),
>>> +			"statx(AT_FDCWD, %s, 0, 0, &buf)", tc->path);
>> nit: I wonder if we need to duplicate the call in string, just to get tc->path,
>> which we have printed in TINFO above. Wouldn't be enough just:
>> 		TST_EXP_PASS_SILENT(statx(AT_FDCWD, tc->path, 0, 0, &buf));
> 
> Sound reasonable.
>>
>>> +	} else {
>>> +		tst_res(TINFO, "Testing %s with STATX_ATTR_MOUNT_ROOT by fd",
>>> +				tc->path);
>>> +		TST_EXP_PASS_SILENT(statx(*tc->fd, "", AT_EMPTY_PATH, 0, &buf),
>>> +			"statx(%d, "", 0, 0, &buf)", *tc->fd);
>> Well, here you probably meant
>> 		TST_EXP_PASS_SILENT(statx(*tc->fd, "", AT_EMPTY_PATH, 0, &buf),
>> 			"statx(%d, \"\", 0, 0, &buf)", *tc->fd);
>> checkpatch.pl (via make check-statx12) warns about it (slightly cryptic):
>> statx12.c:60: WARNING: Consecutive strings are generally better as a single string
>> TODO: this is the second thing which should be fixed before merge.
> 
> Sound reasonable.
>>
>> But again, I'd go just for:
>> 		TST_EXP_PASS_SILENT(statx(*tc->fd, "", AT_EMPTY_PATH, 0, &buf));
> 
> OK.
>>> +	}
>>> +
>>> +	if (!(buf.stx_attributes_mask & STATX_ATTR_MOUNT_ROOT)) {
>>> +		tst_res(TCONF, "Filesystem does not support STATX_ATTR_MOUNT_ROOT");
>>> +		return;
>>> +	}
>>> +
>>> +	if (buf.stx_attributes & STATX_ATTR_MOUNT_ROOT) {
>>> +		tst_res(tc->mnt_root ? TPASS : TFAIL,
>>> +			"STATX_ATTR_MOUNT_ROOT flag is set");
>>> +	} else {
>>> +		tst_res(tc->mnt_root ? TFAIL : TPASS,
>>> +			"STATX_ATTR_MOUNT_ROOT flag is not set");
>>> +	}
>>> +}
>>> +
>>> +static void setup(void)
>>> +{
>>> +	SAFE_CREAT(TESTFILE, 0755);
>>> +	dir_fd = SAFE_OPEN(MNTPOINT, O_DIRECTORY);
>>> +	file_fd = SAFE_OPEN(TESTFILE, O_RDWR);
>>> +}
>>> +
>>> +static void cleanup(void)
>>> +{
>>> +	if (dir_fd > -1)
>>> +		SAFE_CLOSE(dir_fd);
>> nit: Here could be empty line (readability).
>>> +	if (file_fd > -1)
>>> +		SAFE_CLOSE(file_fd);
>>> +}
>>> +
>>> +static struct tst_test test = {
>>> +	.test = verify_statx,
>>> +	.setup = setup,
>>> +	.cleanup = cleanup,
>>> +	.mntpoint = MNTPOINT,
>>> +	.mount_device = 1,
>>> +	.all_filesystems = 1,
>>> +	.needs_root = 1,
>>> +	.tcnt = ARRAY_SIZE(tcases)
>>> +};
>>
>> All my suggestion (ok to ignore).
> 
> I agree with your all suggestion.
> 
> Best Regards
> Yang Xu
>>
>> Kind regards,
>> Petr
>>
>> diff --git testcases/kernel/syscalls/statx/statx12.c testcases/kernel/syscalls/statx/statx12.c
>> index 40367c8b1..6b76b6e49 100644
>> --- testcases/kernel/syscalls/statx/statx12.c
>> +++ testcases/kernel/syscalls/statx/statx12.c
>> @@ -12,12 +12,10 @@
>>     * This flag indicates whether the path or fd refers to the root of a mount
>>     * or not.
>>     *
>> - * Minimum Linux version required is v5.10.
>> + * Minimum Linux version required is v5.8.
>>     */
>>    
>>    #define _GNU_SOURCE
>> -#include <sys/types.h>
>> -#include <sys/mount.h>
>>    #include <unistd.h>
>>    #include <stdlib.h>
>>    #include <stdbool.h>
>> @@ -32,32 +30,27 @@ static int dir_fd = -1, file_fd = -1;
>>    
>>    static struct tcase {
>>    	const char *path;
>> -	int mnt_root;
>> -	int flag;
>> +	bool mnt_root;
>>    	int *fd;
>>    } tcases[] = {
>> -	{MNTPOINT, 1, 1, &dir_fd},
>> -	{MNTPOINT, 1, 0, &dir_fd},
>> -	{TESTFILE, 0, 1, &file_fd},
>> -	{TESTFILE, 0, 0, &file_fd}
>> +	{MNTPOINT, 1, &dir_fd},
>> +	{TESTFILE, 0, &file_fd}
>>    };
>>    
>>    static void verify_statx(unsigned int n)
>>    {
>> -	struct tcase *tc = &tcases[n];
>> +	struct tcase *tc = &tcases[n/2];
>>    	struct statx buf;
>> +	bool flag = n % 2;
>>    
>> -	if (tc->flag) {
>> -		tst_res(TINFO, "Testing %s with STATX_ATTR_MOUNT_ROOT by path",
>> +	if (flag) {
>> +		tst_res(TINFO, "Testing %s with STATX_ATTR_MOUNT_ROOT by fd",
>>    				tc->path);
>> -
>> -		TST_EXP_PASS_SILENT(statx(AT_FDCWD, tc->path, 0, 0, &buf),
>> -			"statx(AT_FDCWD, %s, 0, 0, &buf)", tc->path);
>> +		TST_EXP_PASS_SILENT(statx(*tc->fd, "", AT_EMPTY_PATH, 0, &buf));
>>    	} else {
>> -		tst_res(TINFO, "Testing %s with STATX_ATTR_MOUNT_ROOT by fd",
>> +		tst_res(TINFO, "Testing %s with STATX_ATTR_MOUNT_ROOT by path",
>>    				tc->path);
>> -		TST_EXP_PASS_SILENT(statx(*tc->fd, "", AT_EMPTY_PATH, 0, &buf),
>> -			"statx(%d, "", 0, 0, &buf)", *tc->fd);
>> +		TST_EXP_PASS_SILENT(statx(AT_FDCWD, tc->path, 0, 0, &buf));
>>    	}
>>    
>>    	if (!(buf.stx_attributes_mask & STATX_ATTR_MOUNT_ROOT)) {
>> @@ -85,6 +78,7 @@ static void cleanup(void)
>>    {
>>    	if (dir_fd > -1)
>>    		SAFE_CLOSE(dir_fd);
>> +
>>    	if (file_fd > -1)
>>    		SAFE_CLOSE(file_fd);
>>    }
>> @@ -97,5 +91,5 @@ static struct tst_test test = {
>>    	.mount_device = 1,
>>    	.all_filesystems = 1,
>>    	.needs_root = 1,
>> -	.tcnt = ARRAY_SIZE(tcases)
>> +	.tcnt = 2* ARRAY_SIZE(tcases)
>>    };
> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
