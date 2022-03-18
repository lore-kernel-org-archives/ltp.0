Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44E7EC433EF
	for <ltp@archiver.kernel.org>; Fri, 18 Mar 2022 01:37:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 03CC63C944E
	for <ltp@archiver.kernel.org>; Fri, 18 Mar 2022 02:37:43 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DE92A3C217A
 for <ltp@lists.linux.it>; Fri, 18 Mar 2022 02:37:31 +0100 (CET)
Received: from esa20.fujitsucc.c3s2.iphmx.com (esa20.fujitsucc.c3s2.iphmx.com
 [216.71.158.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C5619600879
 for <ltp@lists.linux.it>; Fri, 18 Mar 2022 02:37:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1647567451; x=1679103451;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=tX8vhu0vOyQ/4HqmzIZ6slgG61S5FkpViZUXEBpoApY=;
 b=Ux6OwjyfiPO0a/urqsEAMAT/qdEDd34gCKVlXYmPEiHlnYFwhSVqBhZ9
 TC5ApOORbxaqz34AGgqF++m78ipcyONuIIptoHRDMTw6u0HLASBRIaGX5
 +kZGrDNKgPTycdHZOl9gvp6TjayhuUKlh48aYa/9crTo1oFGPxFO7aYT+
 XGlpd8p7813Omgv2hRmC+fdSXbCkEISMYNVFbVdBP4ugDq0ka21TS8fig
 F6Mm2lerGinXcrlfhKwMSnrnuG0kXNv3ZO2kHhYhgji59syOkcs6PTIdN
 4wtbzY0f00Du7SkhDx3Sr1K56nwuZRtv5ZoAtiyI5oqbxzDPB5RvQBXfD A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="51995008"
X-IronPort-AV: E=Sophos;i="5.90,190,1643641200"; d="scan'208";a="51995008"
Received: from mail-tycjpn01lp2168.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.168])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2022 10:37:29 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bJtd5s+EY2lfzDC8EQsV7MrUDhwxdB00SOoL3KNkBdJZtjwAJaGEI1ZKoCpWkYgVZ9wme9Lv26padTBbQ/IeNmFJL9EU7JpsGJDtPUcuaqHB2ZsmIzcPzHbJGhzTvufFInrwAZrlTiSIqvDEMwUBNIbD4ZmFq+TwGckkQGUMhMMBgdhB8zE0/CEvzAA8Z9r90cZ85E4+tm3VSqpKyMDXQpbDGTSZRLV+4JE+Kw7KFFxfxTod2gcWmKBlH4yM0l/jcrGKXOkJAr8HyrCNVK++JlNKdOj8CQ2kdL42aKD+ikgXwnXChYEJeGlT8uUL5T4qmovMtU9pwO2Wd5IaKixOqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tX8vhu0vOyQ/4HqmzIZ6slgG61S5FkpViZUXEBpoApY=;
 b=D07GiuOEUdBJyQaYiNlsz2hoPVbqrGj7m+l7StVfdMjOzf/br6YBAL3VNIR+UNJ8U38uRdjSfvj5rsckJKUlyw9vpFd2jOvFhguUVah6X+020Ri2YdAb9HM6F8aNw85xlbjKeNhhuHPwtAPM0BMdxQDFPNsM/gvO+CLN4Yj/xJXt6Y98HqSgWG/7z4sjShzOWQGK646XdfqePJQHKq9G4qIySe7I2tT4D8/CVcuvAC/cFzaFKsV3T3giNWMUg/7iybz/8Lyqfh5ghacmRnEfDNAf+8PHUsSRc/cw3RbqojiREOV1EMu+Wz6OUkDo5PmJNtJt7T/HgCDfZcbKVQfzBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tX8vhu0vOyQ/4HqmzIZ6slgG61S5FkpViZUXEBpoApY=;
 b=Q6hxVYC7PMqJ7qWMVF/7+5YY8KUdHF+EKKKnFFrAGQJzi7pzHwvWcihVedS/HXgg2wn+qn3oc3oBluQFhbnhYe3FFnikwJDj8IwTn5ECeSFkjBep0lJXFcFHHLErN/gPHqupKSkK2/GEw6JWooGVJoY5m0yoVrNbRir9z12asnU=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by TY1PR01MB1785.jpnprd01.prod.outlook.com (2603:1096:403:7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Fri, 18 Mar
 2022 01:37:25 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::dd2e:e671:b3d5:d354]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::dd2e:e671:b3d5:d354%6]) with mapi id 15.20.5081.018; Fri, 18 Mar 2022
 01:37:25 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [PATCH 2/2] syscalls/quotactl: Remove tst_require_quota_support
Thread-Index: AQHYOPk7keNGtecogk6z0v5th8tiSazDnSKAgADCkIA=
Date: Fri, 18 Mar 2022 01:37:25 +0000
Message-ID: <6233E281.9050706@fujitsu.com>
References: <1647401546-2898-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1647401546-2898-2-git-send-email-xuyang2018.jy@fujitsu.com>
 <YjM/S/DdU1lhhhgI@pevik>
In-Reply-To: <YjM/S/DdU1lhhhgI@pevik>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e5fd27bc-d829-4b39-5dd6-08da087fdafa
x-ms-traffictypediagnostic: TY1PR01MB1785:EE_
x-microsoft-antispam-prvs: <TY1PR01MB17857428325ED82507E48C35FD139@TY1PR01MB1785.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bzK9DM+n0us97R5sDV0aaZEhy96XCxJBT1Z/Tb40xrsw8DzMHrGiqc7neLRF9iOoufWwd4DEdTGVyM1IhvPd546HTOlfe9WckFHzi55awKM5CzEZttSLRgokWvvpyWOzSCgpiDYmKPkq/hLGOiAWd0k5bK5RtY+ByZ10Z0UyZtl4m/RhGsz0dpboOl9yTL7qf19MyoFlSuvTftL2O/VNxBEPv0rFkXiuduvM517HrpHXToQCcAceV4S+AssEh8ZvFKkWQ5wfucaHJV7u8WEWQNAqy5NO2ibV5oUSAxy6uUoMu3fOmzd7C1/j9V9iiwBTj4RVlEsEcEmM1cmfKF2984/X8zTef4hN8d8inMAuvv/jhvCU9z3uEUz+iBtDWgb+v1ruNsADve2fQkDzK3lhzkTYgcmLDrkO34HKB5QiZW2meF0DpDN4UD4ptCNLLyzYQ22bqp8Lg+QVB+vk83//ZRaRKu1hwr5uRqj4pfgGnFQDjAdMsWSDd9m+GdQfwl5A5SyKVWzoy2SstRvSfocbcGfJ7fwZrid5KWbTV4ccY4Vkb2casSkFDEwhlmHA4Z2jZlxhnOh6JVbcKD5pGfrg0Jh1IwdwL60bO2dUq9USUvh6HjAUUsjzh1c65UjIcIU7luKbZZZzsWWrwDI2SJwYRJkif59SvZvBa1Xfnm2N6v0zG9pR9heLupiQh3NzMBDLFuLqQ9NA5XbxAP/hbucVaQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(86362001)(8936002)(33656002)(38100700002)(2906002)(316002)(82960400001)(122000001)(54906003)(6512007)(6916009)(2616005)(186003)(26005)(508600001)(38070700005)(87266011)(6506007)(71200400001)(66946007)(66446008)(66476007)(76116006)(91956017)(8676002)(64756008)(4326008)(83380400001)(85182001)(36756003)(5660300002)(6486002)(66556008)(15650500001)(4744005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?dVVvYktPY05BcVgrZGd4OHovVVF4L1BVQmMzWjlBWnUzVEVSUENsb0l4Y01r?=
 =?gb2312?B?aGxMNEQxRjk0d1U5cUo4YWtIS0tEb0NhZXNUL1Y1bHhQQ1A3VmVJVXdSTHlP?=
 =?gb2312?B?ODhhdUxxWnNMYVdGMTRqbUh0WEphVWxaWEYwNlBybVJhbW8rZmFkODcxK1B2?=
 =?gb2312?B?aGNpOEd2ZFNEVzlySFlTV09MTGdCNkxPcWY4ejdrcmlsZzEvb0VMclhGOWMx?=
 =?gb2312?B?cStzbEFrR3B4ek0xcG1wb01YdllERnIrYVRGblVBeGNXbEdqUC9UNlJ6OGRD?=
 =?gb2312?B?T0lUMDhwY3FNcGJlYzhHRXUrMjdQSFQ4YmYzWExwVDJVWGt5QkZnMzdwMXBz?=
 =?gb2312?B?cFJiaFg1V3V1SnFHdHliWC81NFlFUEdGZGx5ZjgvR3dmdHRJTWtjUTBBSWkr?=
 =?gb2312?B?aWF5RUpFc1M2K05qL2FJYW92RlNUb29oNGJveC9UWUJaNHc1emt0eTZ3K3Rx?=
 =?gb2312?B?TURwaGhNdkdPOFNvdW5LR3NHWmM1cWNMb2Rid0phMEJDL01HSHgrN1ZEdzNN?=
 =?gb2312?B?MUpHY2JZaHNNQ05zOUw2ZXZCWkFKb1A5R3Fwb1N1R2RGY0dkUDRnSGV0VjhV?=
 =?gb2312?B?T255bkovUE10NlBDMGNSRlFZblRPNzZVam9QUjcwOVh3dmVwaEFqR3YxamNC?=
 =?gb2312?B?akNBWGQrYlVCK1l2NzRMN1cwdDM1dzMwVkVCVlROTUlwMGdnZ3NzZXVzSUNU?=
 =?gb2312?B?aS9ydExGTXVKR3QxOW9FUktnWGJZVkNpZXFXZHFWM0NPcDNMSzNaNlh0UUNi?=
 =?gb2312?B?UWdrcE00cEZLTkgwRGNnYjY0Q3dhTHB5aXVTWlZ0UGlCRzlMWmFNN2dTdUVI?=
 =?gb2312?B?dzZvalJqNjRJTkh2U3FjUTZoeFZsNU14MFdqa3hoY3Q2enZ4dzA2KzBVYTlh?=
 =?gb2312?B?V25ZQ2VIbkwyWjY2L2srdlJQSVhMRjFMaEJHUm1lVzllczFXNzB5K1VvRkVn?=
 =?gb2312?B?ZEpxajdGUVRpWHhBSzFoRlJQRFBQNWh2TjNHdnhndzBGS29Dd1Urb0s1dHFj?=
 =?gb2312?B?TVZlazJuS1gyWW9adWpxSXNRT3BFMzRTV2s4MHdqY0hFcElmNFo4a0ZTY3lB?=
 =?gb2312?B?VTlpSFlmYTFDMGgrVHhpYms2M2pGWFJRMzhwZ0pwWUF1RW1GanZPbC8rNUhk?=
 =?gb2312?B?TUNMQTF2L0JEdVpEdjB3ZWxLM3lXcmFzNzI4azdUdzhtU29wU3QxYldCNnFj?=
 =?gb2312?B?TGFQd3lhbGkxZ054Tjlsb2N2UEpBVlBJMFRjcDdTQ004QmNad2s0UDdMV3ly?=
 =?gb2312?B?MlRVeWRlMlFuQUNDSjVGeFRweGpWcHJkbFp1eGRyd0ZlTU1OQ3pVc2hHbHpQ?=
 =?gb2312?B?VWN2ak93QUtwYTIzVG00dlRXcnRrSGNvbnh0UHk2SHJ0a3BRRFI1SnhGT05r?=
 =?gb2312?B?V3ljVUZ3cEgvQlI4WTNpeWUxS0o4UHIvVzZhSEkvQ205SlNiQ05lbkxYY0M5?=
 =?gb2312?B?ZU4wMnlXTHJrZzluMjUybVBJaTB1OElOKzhYcHpONEFBN2xOYUhSQTZpWDR5?=
 =?gb2312?B?NHlGWjFTcTZpQ25IWjhNMmdrT3VEWm1vdXcydHljQXdiTU5SUGJYUmZMdDJx?=
 =?gb2312?B?Q3FhWU81cG9JbUt3Y3crNWZJUU5yL0kyVGhNYXAxZTNmSVhQWHFBUTFHTjdl?=
 =?gb2312?B?ZVpjMXpSRG55UU5xTllCWWM3NDcvbEZJTmZCTG5raCtTd3dMWEFpTTN0bUR2?=
 =?gb2312?B?dk9MS0NHbzF5VXRITXN1TWwxd3FKZ0tzWGg5MkhsK2pvZzRxcXJ4clFEUHNt?=
 =?gb2312?B?VzgwSE84d2FvTTVDdyswcDRUaE13aEMrMWNVRk9XV1JHRU9laFM2R1Mwb3lF?=
 =?gb2312?B?V0p4WCs5aFVtTFMwS1hpUjdVc0JqcU5TMHBkMlhTWjFMWW9ZSzIwSWxoMTE3?=
 =?gb2312?B?aUdVUHJkUWJGanVWVTBTMmJRR0pVSmZTSFBHQnJMTTJGSjFTMlE5ZTZBam1L?=
 =?gb2312?B?WmppZEgxQzFabzI4YXprUjZUODl3UFRLd0Zrdzl5aFp2Q25YeTVydzhPR3V0?=
 =?gb2312?Q?sv4sHrHPv64KZKsmlMH44s5QDiVhm0=3D?=
Content-ID: <53D72677F69BA94EA5E5CC0289E991E7@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5fd27bc-d829-4b39-5dd6-08da087fdafa
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2022 01:37:25.3118 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kTnXkvOHx2NA2PiV3Q/ObyJ0Z5EWkOvg52YFOnjARnIBI+MsfRS1kcnozVmJQvxoIoVzUbId8U7NmB+VWtgNtTq4z0SZnq7TgwTDui+Yxl4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1785
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] syscalls/quotactl: Remove
 tst_require_quota_support
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>,
 "martin.doucha@suse.com" <martin.doucha@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr
> Hi Xu,
>
> Reviewed-by: Petr Vorel<pvorel@suse.cz>
>
>> Since we have check quota support on ext4/xfs by using needs_drivers or
>> needs_kconfigs, we don't need this api any more.
>
> nit: maybe also mention it effectively reverts 4aab31e4c7 and ed1885e0e2?
> And that 57d05ce21f (the commit which made these checks redundant)?
Of course, I modified commit message and pushed. Thanks.

Best Regards
Yang Xu
>
> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
