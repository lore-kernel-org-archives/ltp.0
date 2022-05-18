Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62B29C433EF
	for <ltp@archiver.kernel.org>; Wed, 18 May 2022 14:16:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D95E73CAAAC
	for <ltp@archiver.kernel.org>; Wed, 18 May 2022 16:16:50 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7BE2B3CAA93
 for <ltp@lists.linux.it>; Wed, 18 May 2022 16:16:39 +0200 (CEST)
Received: from esa4.fujitsucc.c3s2.iphmx.com (esa4.fujitsucc.c3s2.iphmx.com
 [68.232.151.214])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 612C460091C
 for <ltp@lists.linux.it>; Wed, 18 May 2022 16:16:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1652883399; x=1684419399;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=v2ZexEeOqbaX2xaNu0qEWuz95VvevQgSC4jRARcRTvQ=;
 b=BHeW7HEVs4aHq8q6oAgEBXYPpdwYfGXhlewZb+46Sgsrtx+AESAZrR9g
 06GCda5CzNqhMB8Gl2Qn7KDK6H5dkvHJSRwyjTEaDZkWiCO5ajINGehS1
 NjdejHg4es3GzYBYwO/Z/5cMvOyqdBblSAlv86h9x/9ox2JhFuOQSa8wj
 PbOXqYtybuGxd7rJPAAxKYRyL9ZlY8U+HPZbniT//+feGIkDWm/zFETJx
 0AXAmSoEWY3L11joGxEAevWQiSwOUxBmswziqKiG/oQ2eojsK3czIJtIC
 YWAQywnMLdDGoXWy5HDWr59TCP5bQkfnJqhcjJMM124GGITdCr4kfjYW8 g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10350"; a="63976544"
X-IronPort-AV: E=Sophos;i="5.91,235,1647270000"; d="scan'208";a="63976544"
Received: from mail-tycjpn01lp2177.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.177])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2022 23:16:36 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=knMr6NSkuQn4AZgAtTWuUZFFE+S7oaSYMtwFTHLEM4SwTZ2sv1AFAX5M98E38Xcge074EJtj56dg88HQWfNHCyiVv/t+/GJGkh0Mp544DUWzuCOku4PrqXFVFfcR+UgrAGVGUIqoj6gW4WPLRwX7RYhBHMN5+zu5NiB1FqmW2G90wrraDBWewfu0HsB/c727PuphTo+JE7fSox8MzR9zUBb55ykjBmF3edPB8z46G7qZGZYT2yN/qYe4FFHft9Q5K3bC9raY65Y7bJ/yM5sW+ZYbzZpvr0hfwxJSF54rC89+mN/aORGBt2l/9kYiOxSIQM+tgw2cYkOGS51r3luIRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v2ZexEeOqbaX2xaNu0qEWuz95VvevQgSC4jRARcRTvQ=;
 b=MpmiicmzQY9RZwN/+xveEMTslvMq6Yh0eiYWVZD+qJhihsKqhblAa/GUXSE3HLDU1ZpmYgTh9tkEMCHO3WRupP/Ro7QPr0li38GWjq2ViwW4JR6PE5wvxN9ketngVPeywkY7VVE2Pud6IAfQcbKih5wYd7nKIs4fY6L6C12gaEztX73pW/L86OQkO9Z8Kwddtv8AJVHmHQ/7/lZ+lukvweUzJ/bs5bzqzfC8Mv9AMWIncgEWyfaSvRcjCO/7n1ORth/nGwgQDK58KZekddsO8qU0ozDZfrzbhV8r0uAvbbcsU3r11QEvH/uomgQD2iNADfs5MdDquTl3NSCWnK2YRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v2ZexEeOqbaX2xaNu0qEWuz95VvevQgSC4jRARcRTvQ=;
 b=rE83NHVRjH7+4U6dvgo1bvD62H+G/zyOmFdRizlwINNXafz3q9peolJvVGIzYotHFIe1GctfhiBBwSMcIuTgqzd83FIM0gxzwOZBrG6zWG5CP1cMBDcLia5AGxb/uxMHL8JA3UCB909Fg0y+4T/ey6Ir43yT2F1uNGmPugyyNlQ=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by OSAPR01MB2180.jpnprd01.prod.outlook.com (2603:1096:603:19::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Wed, 18 May
 2022 14:16:33 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::5df8:2861:34f:f50d]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::5df8:2861:34f:f50d%6]) with mapi id 15.20.5273.015; Wed, 18 May 2022
 14:16:33 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH v5] syscalls/mount_setattr01: Add basic functional
 test
Thread-Index: AQHYWu1OuBhzDFDM90eIffCZ7rrHJa0kcuWAgABr+4A=
Date: Wed, 18 May 2022 14:16:33 +0000
Message-ID: <62850DFF.8030607@fujitsu.com>
References: <20220428104642.110-1-chenhx.fnst@fujitsu.com>
 <YoSzazXY+BRhAPmc@pevik>
In-Reply-To: <YoSzazXY+BRhAPmc@pevik>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d8edc948-5bcd-4527-61a8-08da38d902c3
x-ms-traffictypediagnostic: OSAPR01MB2180:EE_
x-microsoft-antispam-prvs: <OSAPR01MB21805E513AA5B5AA79C2DF99FDD19@OSAPR01MB2180.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3cp65W+qcoL8imkHV6IfiZ8xD3obMk+4gVGqQPs8e1EudscrdLzFxjgekG8MlaBxxIwEmpzN91P5M2CHvwrYWwVt+v+WUHcWUjZWlcZeTzXxGqoKT/aYvjoDT50xrO7j9S+QjF08ikVs3XabUfIAB2LA+x/rBiHOv7izbrIFg9xMhOoGItUP2Uyxna/lea/I3mc0LCwYxPdqjYwBScedAotatZcEaWyhPPY4bg75fS9YG5zn+bqtXEtkLRF/D+eLoeVJH8yPK6nskDC90OYEpP0mGSZqPUIlICqMHzlbEQ2kAoGsVwQU47sh81DKuwXYFxRtQ7G6bmnDaNL8ZJ6bUnfEnYpWrCFDNwnAKOtkuStXcO7Zskz4PEtMqwhAUUzEvZmozTLSHSVU9G4/RrmZqbRRmMyBBKf+hLALVu5JUNHh3MKCOtOFSIxa7hDO7IlH9ugr0uQc8eUBlfFgad4elRcJlhN1z2c7AVPcKZeT0FoSQgKHP2PsKjVOZcLEb0wTs0F8piRdh+sH48wm6Ifxbk+OOoayBE9iTg9LI9/zSe5Pmu8U56ybavUy9FD+1wFzrZabCDAv+tAg7yaEWMBfTT0ejus6v1o8aHQJKhHOgNZopMfuYOMQVTvDgaYhpKzl7lLlYGMgoBK1fxqOrHMznFAryKMxVHSRz3fkccjPtpOJAgeJyxtxTpEM8G2MHAb95UuLVEj9pueu7kGZRnmoVQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(85182001)(186003)(8936002)(38100700002)(38070700005)(36756003)(87266011)(5660300002)(2906002)(508600001)(54906003)(122000001)(76116006)(6512007)(66446008)(64756008)(66476007)(316002)(26005)(6916009)(33656002)(83380400001)(2616005)(66556008)(4326008)(8676002)(86362001)(71200400001)(82960400001)(6506007)(6486002)(66946007)(91956017);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?U1NLL0RiTGxOa0dHOEFUa3pZZkc2aGhjbW95UHdoTEQrV2wrdytCeDZ6T2pZ?=
 =?gb2312?B?L3lDMkpRTVY3d3FOWUZDbitIVm9vUEFpdGRMTDcwYkZpa1VHTjUxM29SMExW?=
 =?gb2312?B?dGI3NUsxU1J5N3RSbWJxOHFLU3dvb1V3UlVvZGlGTWg0N1k5dkZXMEUrNmdu?=
 =?gb2312?B?c01vZStMZzRMUldiK3FjQVl6NTh2azE3MUNoWkJQbFNMT0w4NGxVNWprcUpa?=
 =?gb2312?B?K1B1Y2g4WFpRcmVlMUZLelhvVE04WjNjdXNCaWcva01xTGlmNjZrNFpCSWI1?=
 =?gb2312?B?bEdRVFh6TGVoMU1MbjJrcjYwYjNQaTY0dnlaMzlnRm14bG55TEkxQjhielEx?=
 =?gb2312?B?MFkwYm94YTk0TlFqcWtLbklvVGJ6MHZUTndhOTVSYTRQV1lhOGIxQ2l2RXN4?=
 =?gb2312?B?RDdsTXVqaUxnR2tPekw0eVdRdVpBMjRqVHg1Y1hHTlJ1ZmNCRGk1eVFFeUFV?=
 =?gb2312?B?eENhZ283MysyS082b1ZVQzcxU08weWhXUjNBQUFoZjNaTHhhcjhQRCtIYllP?=
 =?gb2312?B?TXM5bU9JWG1mQ3pXeE44cWN5MCttT2FROXViWEk3NWZUblR5aDR6eStMYndH?=
 =?gb2312?B?enMxVzY1Ty9uclUwa290bDYzNkY2bStwTHJNUytNR3BXcXN3K0hSNFlnQi9x?=
 =?gb2312?B?YWZ5WEgzdjZzWGFYYUxjMlhsNjhrKzNlVUlqNWpCYlorWFVtTEtaV01saDc5?=
 =?gb2312?B?YVExUWlpTFVkVFdqVkNRUHNCZ0ExUHpXaSt0WlJRSUMvUkFkMUw2UEt2Wlp5?=
 =?gb2312?B?UjdzcUVRM3l2elFta2xSMDQ5YVFuNmF1a0JtcTFSSFI1Z2RrVFlqcFRQVGU3?=
 =?gb2312?B?emxPaG44ZWdyMERiOFVtNEtUMVlxUVk0Ky9HcERxMEJmNFA4TzRZOW11RGEz?=
 =?gb2312?B?TlhIL3BkSFAyM0R0ZGtOTFVkYVBvbUhTUElGd0dnUEVFNU9CVzNSTWxJSS82?=
 =?gb2312?B?dkVRZmFzUzhzSHVWdFJDa1R2UGdsaGY2NDdENnVDQWl6MXNmQTY0Uzl3RkRH?=
 =?gb2312?B?WWdVTnQyMjBkcEs3WnIrV056Z0dzdkppbVEzaUg2OE4zNEFZOU85eFlBYTFJ?=
 =?gb2312?B?R0pOUmlRM2hZZEVySmJ4Q2liTVFmNDRtUkRmbllscWRubDUvVnNKY3prS3dj?=
 =?gb2312?B?L0hncjU2QUJhV1hBU2JMMVhILzhVZFZ0YjBLS3B0eWNpREJpOWVZRzRTa1Iy?=
 =?gb2312?B?MFVYTW5LdWdoRG91KzNSd1dQOGtFTUg3UDYwanowVmlpNDhEbWYzN1Y0VnVN?=
 =?gb2312?B?ck1zdUlzRDVzOFEyNlRvQjdXWnQ5NGpnM2Q2dXl3aURwcE5ER1JSZ2U2djdI?=
 =?gb2312?B?QS91L0k0ODVmN01OZUN1SWxUYzJYaE1QUFBBendKdXJHdk9aQzRzTGZSTnZR?=
 =?gb2312?B?dmxLYnZhbDRodWxCSUpZbDdOR1pSMmszRDM2U3BwVDNYa3BoUDEzcWFYYUdt?=
 =?gb2312?B?MWxmZkQrdVduTm9qeGNMazJDVy9KcUxkVHlxNWFxMmxEU2NTc3diMnA3c3Vy?=
 =?gb2312?B?S0h5MlAwdWs3eDFBSDluZmhwTUpNQkVRRzVJT1c5bEkwdUtIemVSOWprRDd4?=
 =?gb2312?B?UXpvZmZJcXYxMTVjK1dhalhNSlBZbllLWjNDYkFzSXRXZGxXYkhWU3JWcXQz?=
 =?gb2312?B?RmpveEM1dnhGTEtYZ3hVTlNrS2x1bW52NXVFM3RmSExNQkNUVlJwM2VVcWJF?=
 =?gb2312?B?dy9HUnNmeGlaOWZoZ0xEWTVDa3dLUUVJNTA1YnFEMGVhN1hLOVkxMFZzVmZN?=
 =?gb2312?B?Yk9LQ2FBc2ZRUThxOFBHYnpJRVVkVkJwUHl5NkE5YWpiTjRRNUxxcy91SlRt?=
 =?gb2312?B?S1pZYURVVy9aUVFiUjV5Nm5GMnN6QVozSFJMYjA2YVFiTVpSRU1UcHRXQkJ2?=
 =?gb2312?B?NTNmNks2NFFCT3hKZ05vVGNDMDUyRkNjTGQ1ejduQWlHOCtyYmxFd3I2V2RF?=
 =?gb2312?B?dURvcHNXMG0zU3N1QzB4MWpUZUZBY1I3SlZmNUU2TU0yb1dCYkxCZUlwNTBB?=
 =?gb2312?B?VXNuVXN3b0JsR2tjenF0QS9DK2FLbDhuQytKWG5VaWdJSVIzRlJrazFKNXAv?=
 =?gb2312?B?ZVRNWGRGSGhZZzljSUNFK2FEMkRMeTk2SzVnSFVrNWdoN2ZYMDkzdnJSbDM2?=
 =?gb2312?B?cUp1VklBbzZ1T3lCVkJkcGxXYXZvdHZaWk1lWmFqMS9Sblh1RUtpVDEwZ1o2?=
 =?gb2312?B?RVl1OVFhOTdmVXFSeGtEMWdYUnF6T3NjbU5uYzE5S3ZoTSt5cXN6NjlKOHpT?=
 =?gb2312?B?OTNsWXQrYndsMFlOSmJFVTFCWVNST1JmVnRSODAwTG9jVThoUmEvdmNWREk2?=
 =?gb2312?B?YmxpN1RyNkJmZ1ZsQ2VFNHhuN1U4YXZUQ0dEanJuN2FiMVZlMnU0OEpaUzBD?=
 =?gb2312?Q?UAJBLBXFVW1qQEDc=3D?=
Content-ID: <855BE80A59F0B74FA0EFE7330DE6616E@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8edc948-5bcd-4527-61a8-08da38d902c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2022 14:16:33.1607 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PtJhrXKVQts6W9J93Djq/GogmSEB8TVfORKwN2y8C/Gv1SFf3X3Xq8xOwma454PmbOj55s9D7Cm3vo9VTBlWc74BskabQ4dZq8H+wjqMMiQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB2180
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5] syscalls/mount_setattr01: Add basic functional
 test
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
> Hi Chen, Dai,
>
> ...
>> +static void setup(void)
>> +{
>> +	fsopen_supported_by_kernel();
>> +	struct stat st = {0};
>> +
>> +	if (stat(OT_MNTPOINT,&st) == -1)
>> +		SAFE_MKDIR(OT_MNTPOINT, 0777);
>> +}
>> +
>> +static void run(unsigned int n)
>> +{
>> +	struct tcase *tc =&tcases[n];
>> +	struct mount_attr attr = {
>> +		.attr_set = tc->mount_attrs,
>> +	};
>> +	struct statvfs buf;
>> +
>> +	TST_EXP_FD_SILENT(open_tree(AT_FDCWD, MNTPOINT, AT_EMPTY_PATH |
>> +		AT_SYMLINK_NOFOLLOW | OPEN_TREE_CLOEXEC | OPEN_TREE_CLONE));
>> +	if (!TST_PASS)
>> +		return;
>> +
>> +	otfd = (int)TST_RET;
>> +
>> +	TST_EXP_PASS_SILENT(mount_setattr(otfd, "", AT_EMPTY_PATH,&attr, sizeof(attr)),
>> +		"%s set", tc->name);
>> +	if (!TST_PASS)
>> +		goto out1;
>> +
>> +	TST_EXP_PASS_SILENT(move_mount(otfd, "", AT_FDCWD, OT_MNTPOINT, MOVE_MOUNT_F_EMPTY_PATH));
>> +	if (!TST_PASS)
>> +		goto out1;
>> +	mount_flag = 1;
>> +	SAFE_CLOSE(otfd);
>> +
>> +	TST_EXP_PASS_SILENT(statvfs(OT_MNTPOINT,&buf), "statvfs sucess");
>> +	if (!TST_PASS)
>> +		goto out2;
>> +
>> +	if (buf.f_flag&  tc->expect_attrs)
>> +		tst_res(TPASS, "%s is actually set as expected", tc->name);
>> +	else
>> +		tst_res(TFAIL, "%s is not actually set as expected", tc->name);
>> +
>> +	goto out2;
>> +
>> +out1:
>> +	SAFE_CLOSE(otfd);
>> +out2:
>> +	mount_flag = 0;
>> +	SAFE_UMOUNT(OT_MNTPOINT);
> mount_flag needs to be checked before otherwise if it fails on:
> TST_EXP_PASS_SILENT(mount_setattr(otfd, "", AT_EMPTY_PATH,&attr, sizeof(attr)),
> 		"%s set", tc->name);
>
> It tries to umount() not yet mounted filesystem:
>
> mount_setattr01.c:109: TPASS: MOUNT_ATTR_RDONLY is actually set as expected
> mount_setattr01.c:109: TPASS: MOUNT_ATTR_NOSUID is actually set as expected
> mount_setattr01.c:109: TPASS: MOUNT_ATTR_NODEV is actually set as expected
> mount_setattr01.c:109: TPASS: MOUNT_ATTR_NOEXEC is actually set as expected
> mount_setattr01.c:93: TFAIL: MOUNT_ATTR_NOSYMFOLLOW set failed: EINVAL (22)
> tst_device.c:394: TWARN: umount('ot_mntpoint') failed with EINVAL
> mount_setattr01.c:119: TBROK: umount(ot_mntpoint) failed: EINVAL (22)
>
> Because we mount later than opening otfd with open_tree() but need to close otfd
> before umount() we cannot depend only on labels.
>
> Thus I suggest to have this cleanup code:
>
> out1:
> 	SAFE_CLOSE(otfd);
> out2:
> 	if (mount_flag)
> 		SAFE_UMOUNT(OT_MNTPOINT);
>
> 	mount_flag = 0;
>
> If Cyril is ok with this I'd merge it before release.
> (I tested it on various systems, found only this issue.)
This fix is obviously correct. Since I have reviewed this patch in 
internal, you can also add my reviewed-by for this patch.

ps: I think we should also check functionality like mount03 did instead 
of just check flag.

Best Regards
Yang Xu
>
> Kind regards,
> Petr
>
> +++ testcases/kernel/syscalls/mount_setattr/mount_setattr01.c
> @@ -115,8 +115,10 @@ static void run(unsigned int n)
>   out1:
>   	SAFE_CLOSE(otfd);
>   out2:
> +	if (mount_flag)
> +		SAFE_UMOUNT(OT_MNTPOINT);
> +
>   	mount_flag = 0;
> -	SAFE_UMOUNT(OT_MNTPOINT);
>   }
>
>   static struct tst_test test = {
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
