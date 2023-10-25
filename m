Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D90AC25B48
	for <ltp@archiver.kernel.org>; Wed, 25 Oct 2023 01:33:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 267DB3CECA4
	for <ltp@archiver.kernel.org>; Wed, 25 Oct 2023 03:33:04 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 330553CCD5C
 for <ltp@lists.linux.it>; Wed, 25 Oct 2023 03:32:52 +0200 (CEST)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com
 [205.220.178.238])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id CD28760034E
 for <ltp@lists.linux.it>; Wed, 25 Oct 2023 03:32:49 +0200 (CEST)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
 by mx0a-0064b401.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 39P1UmBS021829
 for <ltp@lists.linux.it>; Wed, 25 Oct 2023 01:32:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
 h=from:to:subject:date:message-id:references:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 PPS06212021; bh=WALUiL8mU/7zDGbHTgCvIY5MuAMKdEHdx2wU46E12i0=; b=
 B1pvlsOB98Kq8wGOillDuVRx8z8JpG/oVxGgTbubh//yHvIqZbJlmRn6MeRN1oNG
 pbgyzwMxpasA20v4MrrIUR26ABIvOvKmePPajqEF6rZQeoKk8bFQHbcQL4d7y987
 QTxTHRJ7KAOHb1yAZSRI1m5GDTBYOOkMClFCLX8uSaUvtyi3k37KBzMYl1Qnwfo/
 L6Mf7080LLat6uHzw/vAzQumh3zz+JPyn1SzqPlPNRQwiRhxXuEhcuUWnXh+IUdg
 4RrpsuxGmOarQ08fVkRI3FEobJ11zhR8feGGsbN/xhSLjN8uuAa3HaDXFqbgCnMd
 L1lx7bVEGjnQuQOYZ5r4cQ==
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
 by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3tv3ux419e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Wed, 25 Oct 2023 01:32:47 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=McSmanCs0ol/l0FMUsXSTVKbA1C4WH8qyKsjt4k4xMl7f9RJKWZiCcqh7RQCX+9rQZM1dnIwjemldLo3j9OAryPq8ZtwingQh5VM/OGQhptS+C4jWOAodexFuXU1c3Hh7XegyLsFIIJYnXkBqHOR8uZDrmFSaDdCufDiUmhdQ+JhqEbBu9kh6jKzQ0ChbslGnd7t5SKt0SQzn7KeqiYqqY09S1RBygO01hYUaz2raer9Ln3TGWGQWJrZJIyoAD3EP/fRiHyZ5BS+h1pmJBaROYKSzzhHDIJVk9R0SSVWSlM4fO0LKWQEhoxIlEFxtRA+LTAleluD2FDiM2csCkbzog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WALUiL8mU/7zDGbHTgCvIY5MuAMKdEHdx2wU46E12i0=;
 b=IhWaHq6030J6VbSuebhIRgOZqxnBHjXYDutYYMBWVOlX65b2pelWc2GVq0A3hZYwsPBTZKEMmZ5fVyPH9pOp2e9tOO/nOBzoerejPuCGSFsuawb5kO51gevIN5mFmcWdQXStDFdvdDUtWd2ki+x4UZ3Cj0t0ekUlFQUVeP7HFAiGHMwnYRlJabXgobJWrtFfEmS2QSL5jJYxLTbYzFpxh1wgKVAMV+Gj/g+Szvv0GQHh+naUeGV8H5wzJM9ZjDI5ITY9W6GD43uB6dUA/IhcJubb/RkByKI6QxIspLRmcZpXVpLXZZl2VC4UsJsdnvDbYIWEMQ8OjcnZGKjmX1q25A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO1PR11MB4979.namprd11.prod.outlook.com (2603:10b6:303:99::16)
 by PH0PR11MB5807.namprd11.prod.outlook.com (2603:10b6:510:140::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 01:32:42 +0000
Received: from CO1PR11MB4979.namprd11.prod.outlook.com
 ([fe80::9f52:2999:c2f5:729e]) by CO1PR11MB4979.namprd11.prod.outlook.com
 ([fe80::9f52:2999:c2f5:729e%4]) with mapi id 15.20.6933.019; Wed, 25 Oct 2023
 01:32:42 +0000
To: "ltp@lists.linux.it" <ltp@lists.linux.it>
Thread-Topic: [LTP][PATCH v2 0/1] enable fsx-linux.c running on VxWorks user
 space and add measurement of execution time
Thread-Index: AQHaAWU+3R30nePdj0+TUAngbPqiELBZwoGg
Date: Wed, 25 Oct 2023 01:32:41 +0000
Message-ID: <CO1PR11MB4979DDFD87F04B88FE28AB7B95DEA@CO1PR11MB4979.namprd11.prod.outlook.com>
References: <20231018014832.1632063-1-Xin.Wang@windriver.com>
In-Reply-To: <20231018014832.1632063-1-Xin.Wang@windriver.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4979:EE_|PH0PR11MB5807:EE_
x-ms-office365-filtering-correlation-id: 24a24cd0-fd86-4deb-4b24-08dbd4fa4828
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L2K0oi6yx5M1ixxO6joIEaXy8aE9m+0OG1P+EexzWKlYgzvyaJ6/evmz0z9uJjWgaRPHs2xQv2RUzb3IujSzMlxKEksXYqtFWZBpS7+CrIheBZsgiqTT3tDPr3ZG/clJIKpjnZqfw+0UFlk1IAgk05dBKZnXkXWDFNoBo8nYpMV+2Jyqn/8WfLUWEd3XNFyJMXeMr2uexs9IGBOdVeP97z6flc9CkgyBlz4zpMQSrelcTjJcU6PFRa2cSkUVE+AzmzF4siNN77PX2dwiqzzPMi07cZ25p/IcNFb5vVyiEZILYpQa/cXRzRT74WMoYqnGf72NpG53kjt7YscQEMgvQgMone77ivT7tKZLj+3i2cBTup4sJxhW5DMS0N+0G6Ed40Hztr4DxcWO7qqDCtPZ1nr2GSwra1jTei5w+y2OHpuytgDoXS3FoLzoS3wh4fZj79Zbiydg/qsaBZHj4Pirdj2wwTVi5QbcxDKIjZ1SxNLUgPoTUfCkMwhuqJz73+UsgUwPQW2COstBf4HHf6h4SpdAoHu3DKHWeVVenO59seGMJuo0Y3ce+5z7VGYRYPVltHdl7FEr2ujnTTGFa0WY7j8B2CTs/zbAHXcS22aK6b3x55Ed88kWtD8IrODUAhqJ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4979.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(6029001)(39850400004)(346002)(376002)(136003)(396003)(366004)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(83380400001)(8936002)(55016003)(71200400001)(4744005)(76116006)(7696005)(86362001)(66946007)(66556008)(66476007)(41300700001)(64756008)(66446008)(6916009)(316002)(478600001)(6506007)(9686003)(5660300002)(33656002)(52536014)(26005)(2906002)(38100700002)(122000001)(8676002)(38070700009);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QnJNVVh5ZlVPbENXVHZHSitaVjFRc3NLZXdDdjR1aC85amdVVmlsYk55dlNK?=
 =?utf-8?B?YUZiM3luT0Uvc0t5SzVKd25sMGxHL2xKSUdZcjdLR084MFRGYVpEalZTRzNZ?=
 =?utf-8?B?VWlDQ2NaQ3hQNkVtZTlKcklHSWQxbXR2Tk5yeTd1SkNXTlJNck93MUU5VzIx?=
 =?utf-8?B?Z1gxdnR3N0xpUlovellqREt1OC83dm9HUEtldytMQ2NOSm50SnpLM0xNNTZt?=
 =?utf-8?B?cWVBTTJEUzk5aFBPMWRZa05ua2pJWk5EZVJjOGF4UkRYbXdPT2JBajhMZkN6?=
 =?utf-8?B?dVk5c0ppY2ErbjNQcXZpY2pOd214cExDdUNXSXpZUlAyRmEwVitqNGRTVCtM?=
 =?utf-8?B?WkJONHVlTkc5b0dERTlhMmM5eDMrNjFkcXk5ZU8xYmFPcDJneFNxeTBka1Ur?=
 =?utf-8?B?UmdnNFpXY1ZQM2Z2M3BVcHZ1N0tIMkNXUFlGZDNsd2ltUzdmb0htazd0Ulhl?=
 =?utf-8?B?M0tmUEtwNmx0VHR3a3ByWnlLYkFSVmFDbHZiSjBlOCtVU245ZjhzcVdjei9F?=
 =?utf-8?B?ZjNaVU9wZ3RCdWVmSmd1MkNwSFNJZlIwd2hCOUVNWGpmUStRSDZsblhtSnMr?=
 =?utf-8?B?T2dnQTlPTlJtcitreXhIbUtPS2hremtCNG4xNHpXZkFpRHFFNDlPbnYxVmVa?=
 =?utf-8?B?QW1zUDdoOXQ5ckxYYTMzYW1QRVBrblZVK0VDeE5wdnppbW5yV1NOYm1DTERQ?=
 =?utf-8?B?Vm5FRXgzS1NpK2h1VnZic3ROTW9HWk1NT0R6bC83QVVLVUxMeWg2OFZaTEtn?=
 =?utf-8?B?Und2a0RsNWxDUjYzY1hsb3Y1YkdDNWlCR3c4VktXUXVXUFRJUjUvZDZMOUpM?=
 =?utf-8?B?WUR2Z014aFpndS9YZzBHTFZhRUJQZFF2VFIyMzROcVZ3TlB0RzRDSm11aVU4?=
 =?utf-8?B?SGR4cUpXUVMrYWJiNmpUb2YvQm9MUVd2Q1Z4QmNVM3VCM3RHb3k0RFE1UkZ2?=
 =?utf-8?B?ZE1YT1JxUStNWEU0NVFEd0JRa2dZUXFXL0cwNnhTUG8xUkhLeXZlemluR2FO?=
 =?utf-8?B?VjFHazBTNXB1c0wvQ0R0dTZSSlFqbnhydlBaZGxxWGRIZXFsRmhUSGtlaHZs?=
 =?utf-8?B?cTdqOFNnTlc5UldVckNSMkZmbnJKeGJUM1JxOGJpQ1Q3aFRObGZVVEs5Umx5?=
 =?utf-8?B?aU1wY2xWUU5GWFg2SlVrYjEzdEJsbHpvRy9RRkJEa2xYMDdUVnVHWjU1OVhH?=
 =?utf-8?B?akh5NmhnZHZhWU1uejZOZ2hmMjkxaTg5eUNCc24xTHpVRUdaejRkUzErMlp0?=
 =?utf-8?B?Z2wvdWxzR3FIY2ZyM2xaVXlKVEpnOEp0R2ZER0RKdHp5UngrVXFnMS80THZk?=
 =?utf-8?B?YXBPaHVGUEZCM2J0MHI1ZXUrNC8wTVRIbXZrVWZFbWg3K2dpckxoUW9wTG1r?=
 =?utf-8?B?WW9TSzFRalRudkxUTUpvQldyZFZNT2RoNDJhUVlDWG1tZWQ2c3gydGtyQ3VE?=
 =?utf-8?B?a1JOTkR1Y3h6SitUOXJzaTYwdGlMTEswSzZtMjJYWlZJazE2TWJRMkRpNjM1?=
 =?utf-8?B?SFZndnFhSzNhNWpKT2RVSm1TR0QrbDUrVzNXRk5SejlrcU5DaGVFS1ZzdGFV?=
 =?utf-8?B?M2ZaUm9lMENzcllYT2VMallUdXZoWTVVNy9tc0RtV0JJUjVCc3d4YXVQYThi?=
 =?utf-8?B?Y3N4YU56V082bWttTm1ETFpqNnZUYytRMFNZYXM4TnVFN3ptNWFzWjZva2pS?=
 =?utf-8?B?K2VDZ3F3R0JSWDl2dThFY0t1R2ZRUS9PZDIxL0EyRjhzS0YwdGlmZkZVUjRM?=
 =?utf-8?B?VG5jZ2d6dXY3dXNIbnU1RW9BUFVZU3IvNXVvRlc1aHNiZmlpRzd4aEhWRUFE?=
 =?utf-8?B?b250UDBzRlRKUzlYWnRmb1U0WUwzRVZHdVUzcW8yVnFnRWNJNXo5ZHFRZ2Jo?=
 =?utf-8?B?d3V6WUh6dThtVG9zc0RFd1h4M1J0Z1ZaZ1Zjb3lpM2hRUXZvaUxlQUo1eENR?=
 =?utf-8?B?TUQzZVMxVU5zMlpxWThqbDRQZXd1YnVNN0NEUXBETXRpRklCSDNrL0t5Mi95?=
 =?utf-8?B?ZTl3WFAwNi9HLzBaKzNBUWF3SkI3cGtnMmc0WVFrNUFnWkV4Q21XMGp4dEk2?=
 =?utf-8?B?cEJ2Y1RRRlNWeHBBOW0yTitGUzJzaTYyNW44Uk5DZ0FnQVBSbXY5MG5YYTZN?=
 =?utf-8?Q?KaU7dIFzSHlBnEZGMV3TUIBDg?=
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4979.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24a24cd0-fd86-4deb-4b24-08dbd4fa4828
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2023 01:32:42.0395 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rC6ATcoq9BnSnP7QFRvFm02N0++UmP3r4Pn95DGuIBp5sfyITWQvvFIGxEEJqDtYA7hyh35mVUPUpLP7kPNQmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5807
X-Proofpoint-ORIG-GUID: -0efTvU5e5lWvs7acts6UPkxlNQG4UQL
X-Proofpoint-GUID: -0efTvU5e5lWvs7acts6UPkxlNQG4UQL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-25_01,2023-10-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 mlxlogscore=744
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 lowpriorityscore=0 mlxscore=0 impostorscore=0 clxscore=1015 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2310170000 definitions=main-2310250011
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 0/1] enable fsx-linux.c running on VxWorks user
 space and add measurement of execution time
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
From: "Wang, Xin via ltp" <ltp@lists.linux.it>
Reply-To: "Wang, Xin" <Xin.Wang@windriver.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGVsbG8sDQo+IEhpLA0KPiBDb3VsZCBJIHByb3ZpZGUgdGhlIHBhdGNoIGJlZm9yZSBmc3gtbGlu
dXggcmV3cml0dGVuIHNpbmNlIHRoZSByZXdyaXRlIHN0aWxsIG5lZWQNCj4gYSBmZXcgbW9udGhz
PyBUaGVuIFZ4V29ya3MgdXNlcnMgY291bGQgZ2V0IGEgc3BlY2lmaWMgdmVyc2lvbiBvZiBmc3gt
bGludXggZm9yDQo+IHRlc3RpbmcuDQo+IEFmdGVyIGZzeC1saW51eC5jIGlzIHJld3JpdHRlbiwg
SSB3aWxsIHNlbmQgYSBuZXcgc3VwcG9ydCBwYXRjaCBmb3IgVnhXb3Jrcy4gSXQNCj4gbWF5IGFs
c28gdGFrZSBzb21lIHRpbWUgYmVjYXVzZSBWeFdvcmtzIGRvZXNu4oCZdCBzdXBwb3J0IGJ1aWxk
aW5nIExUUCBBUEkNCj4gbGlicmFyeSBub3cuDQo+IFBsZWFzZSBjb25zaWRlciB0aGlzIHdheSBh
bmQgcmV2aWV3IG15IHBhdGNoLiBUaGFua3MuDQo+IA0KPiBSZWdhcmRzLA0KPiBYaW4NCj4gDQo+
IFhpbiBXYW5nICgxKToNCj4gICBlbmFibGUgZnN4LWxpbnV4LmMgcnVubmluZyBvbiBWeFdvcmtz
IHVzZXIgc3BhY2UgYW5kIGFkZCBtZWFzdXJlbWVudA0KPiAgICAgb2YgZXhlY3V0aW9uIHRpbWUN
Cj4gDQo+ICB0ZXN0Y2FzZXMva2VybmVsL2ZzL2ZzeC1saW51eC9NYWtlZmlsZSAgICB8ICAzICst
DQo+ICB0ZXN0Y2FzZXMva2VybmVsL2ZzL2ZzeC1saW51eC9mc3gtbGludXguYyB8IDUzICsrKysr
KysrKysrKysrKysrKysrLS0tDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDUwIGluc2VydGlvbnMoKyks
IDYgZGVsZXRpb25zKC0pDQo+IA0KPiAtLQ0KDQpBbnkgY29tbWVudHMgZm9yIHRoaXMgcGF0Y2g/
DQoNClJlZ2FyZHMsDQpYaW4NCg0KPiAyLjM0LjENCg0KCi0tIApNYWlsaW5nIGxpc3QgaW5mbzog
aHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
