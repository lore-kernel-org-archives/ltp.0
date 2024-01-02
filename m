Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B81EC47074
	for <ltp@archiver.kernel.org>; Tue,  2 Jan 2024 02:07:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7E7353CE966
	for <ltp@archiver.kernel.org>; Tue,  2 Jan 2024 03:07:43 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F2DD33C12D3
 for <ltp@lists.linux.it>; Tue,  2 Jan 2024 03:07:32 +0100 (CET)
Received: from esa6.fujitsucc.c3s2.iphmx.com (esa6.fujitsucc.c3s2.iphmx.com
 [68.232.159.83])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5C18D600117
 for <ltp@lists.linux.it>; Tue,  2 Jan 2024 03:07:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1704161251; x=1735697251;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-id:content-transfer-encoding:mime-version;
 bh=q3HNFBheA+oqJVqiKbi4VE+EXINOILp0J7+DnOT17E0=;
 b=A8cNHkIHHc5kZVRRv4ESoyK7/YQzGJHJ+JLt16vkogL1wnQj5dQSAjpg
 7iivkDgghy3EE6h5sKeg52NY7qAnkHkR2/mZd7Y13Wpi2qFezD4Gv5Y11
 t6k01SPI5dUkHgYlMiQYLfAB79ntCRoLEUMxjquUUIFwGIGxMdSSTGNpW
 OoOtZvSVyeXHOWcKRMWuVJpNlOuKBvgd0LoEs365bsY1mb837mdg8F6Xj
 LJKjn8cbbcaKVRomnjsxFJubjI5LzEd//DO+RODs3cQ8H4Vrd+h93IezM
 TVr8ay+5Iy0Hi/K7ie2NtaxrWZZhRtYIHOz2UzqWIb5SeXK9GjJwoQNWX w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10940"; a="107156223"
X-IronPort-AV: E=Sophos;i="6.04,324,1695654000"; d="scan'208";a="107156223"
Received: from mail-os0jpn01lp2104.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.104])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jan 2024 11:07:28 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PQ9qs3Q16DswnE1ZwFkNaPNw4/vypyHGUEvLJwbRx3FCg8lAuByMqhQhL3SFwNB3j+J5hNEljYF/6/sP6DBXQ5G3jFqZMfwNhHEnmN5lQaHpgBctUIYDOY+Bzzurc1PyB+3ikAVzMTdqnDk+CoMT3yNyVwcQIwV0vgn4rr09lA2gRsB5k0zFyV7qR4wL+S/cUzEUSwdi9ghDq0E7/OOCvErtiVM6NyrZ7KXtgMiFLZHX3eM1kLrunktlJ6ccj/yMQHUB5xAzl/GUYp8rKcVqBcK7xEZ8h76CQ2zQWVLPilBj96Zir96gPF6eoZ5luIl2m7FfSY4qEfch/zWIqv145A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q3HNFBheA+oqJVqiKbi4VE+EXINOILp0J7+DnOT17E0=;
 b=PFpYHGkPQebN7GlPftKZaAR3MHJ0bFr1aeupb4NkxjsAwBlP6BjRdgQPPkUoDofJS7RLv4YyC5rpVdqFoEIzXQqrllTwCfs3PI1oTFinJkFgGuFbAGt/G37ov0KoHmYgHa3KEcrC9kFDlyAC99FDwWvvk4jiviguOCRkuQ5+adDBYOgbDcJnGRIlmsS9ELSLrte5MnIqtGMg4RvaAw7dWE3WDoaDxt4mBgue6C2BdPkvstPASAAWB61I2IFnzBqVdMfeAaFKj/Q5+39Fc5AL9KhEtpGAvH/n9CeLbSS5QiruU/zMoxgCIQqQnkAbiZOHIbx8rkZqr9PInLmWFjhp0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11839.jpnprd01.prod.outlook.com (2603:1096:604:23b::8)
 by OSZPR01MB8895.jpnprd01.prod.outlook.com (2603:1096:604:15a::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.12; Tue, 2 Jan
 2024 02:07:24 +0000
Received: from OS7PR01MB11839.jpnprd01.prod.outlook.com
 ([fe80::6f9:cd05:b0e5:6601]) by OS7PR01MB11839.jpnprd01.prod.outlook.com
 ([fe80::6f9:cd05:b0e5:6601%7]) with mapi id 15.20.7159.010; Tue, 2 Jan 2024
 02:07:24 +0000
From: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
To: "ltp@lists.linux.it" <ltp@lists.linux.it>
Thread-Topic: [PATCH v2 1/7] libltpswap: Add get_maxswapfiles api
Thread-Index: AQHaNKPTinv6Kk26kEuKJySucEdLHbDF15AA
Date: Tue, 2 Jan 2024 02:07:24 +0000
Message-ID: <8ae1e1a1-e9cd-4dbd-a6b3-5ff15539f570@fujitsu.com>
References: <20231205061639.68656-3-xuyang2018.jy@fujitsu.com>
 <20231222050006.148845-1-xuyang2018.jy@fujitsu.com>
In-Reply-To: <20231222050006.148845-1-xuyang2018.jy@fujitsu.com>
Accept-Language: ja-JP, zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11839:EE_|OSZPR01MB8895:EE_
x-ms-office365-filtering-correlation-id: 437f9d98-8b32-42be-8b9b-08dc0b378fae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kxo1rbDXmOL5KywW4nRq1wkzzMJn9/6mrHXvGntBik1Me5dJyfqfWYqbozVdg5EIl1FVkUZEuQkfCtEmryhyOaep11jj3cLATCnpB6L7yFmqKTbJ52tTxn+SzhSt/h0ExtKCbyBuw5gA2bfB73WBw7ibAwV4d9HrSjLAxh1Un01lKmFVtT7lLlX+ZDsJztY/PGyMGRCeCDZq6E0+IUXw63ZU1lO8xyNwAuC9jHM3le5TnUDvi0ASiRvOkyu9Y0eX2rF+vDrQdv0kUrNnPB4nFU9a0wNDA7sde3pMIsyPg0t9Ubu0eXCFC4UVNSeqOI0nMt4zC80rkYd8LN5KXgXWC8zAb8y3PngXStQQaAXFuYftCeKf6JMJ+10c6urnO2+Q0XDg9lEL1LJJCF8dzYJRF2+e5FcFsckqN4iF+wH1ud2SbVZvbJNtYdv5xwF7JV8ziVM++xe5NJRfypOUxpKUuvxz2gJF3CEFDyMbowBxvx3mEedWzyTlxSj9WdFLVmQ9Y7ekO7W4WQrbSTBCs+JVFok6RypzKhC8GuEquu193EmtLsBdVGfKgGnTi0g3/lD4tKlrfop488EEWiyzcTb55QPVS0Huydw95QWNXPKpgW6AjjxpdMmZ/j+D8gSa5NBqvlTTpvA1xBB5Vk7SgPfxCl9jSoyQw5zX8+8B3VJu60g=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS7PR01MB11839.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(366004)(346002)(376002)(396003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(1590799021)(38100700002)(122000001)(1580799018)(82960400001)(38070700009)(85182001)(36756003)(31686004)(31696002)(86362001)(2616005)(26005)(6512007)(6506007)(71200400001)(478600001)(6486002)(316002)(8936002)(8676002)(83380400001)(66946007)(91956017)(76116006)(66446008)(64756008)(6916009)(66556008)(66476007)(41300700001)(5660300002)(2906002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RmhjWGpVd2NGdVR3eDBacXFPdmtGcmMyYTIrNUpGSlozZGdVeTBjRWkwQUJv?=
 =?utf-8?B?SG4xcEY3V05YR1E2OW9xaWR2MnhTelR1N1RVMlBjYnlhcm5vNXZ3aytoUUZH?=
 =?utf-8?B?dlUzSmRwSStYSjhsRldDRjZ5SHhrenRXZHAxQTVBcVg1dkd6dUZkaWcxc0dO?=
 =?utf-8?B?NjZ5elFlSGczdmgyL0dRQ1EwYVUrMXpYcmR2Qi9ZWXBpcTlvdnBaQ2Z2SXRk?=
 =?utf-8?B?anlSTktJSUNpYzZmcVRSQkNHVzRXZUZnVlNMRUFEZTViSG1RVjNZL1dmSjBk?=
 =?utf-8?B?UWtBbEFJTVhPOWJwcGRLL2FqWmRuaU15WTkvMDZ1WGRZVlgvdmIrNTE0V3Qx?=
 =?utf-8?B?dHI4Yk1xcXJKNk5RSzI5S1BmbVhMNUVlWWFrTFI1M3VRb0RSM1c5Rk9NeE5Y?=
 =?utf-8?B?YmRFeVltWEtFZzVsdXpTQWhIV01yMC8vZ3dybUtQY1ZRbURBL1VzQmJFK1VM?=
 =?utf-8?B?VHVRd0U2REZuZlZ3N1AwK0Q3TmRDcmc1dTVObGo3ejRiSmxEeHZwc1FzYlhW?=
 =?utf-8?B?cXc5MlRhMFF4MytuT1FuZklDNG1RLzZNU20wQ1puRzF4MmMrQmJ5UFdNZ3hi?=
 =?utf-8?B?dUVualBhcmtEcmVHdUUzYU5oMGF0ak4zYVlvWGFVbFlXYWh6a21LZUZLaUZG?=
 =?utf-8?B?V21pYkc0UGk4QTR4NEt6dWZFQ2xvV0pMZmc5YWdwRWZQV1VSZWtxL3pUYlp2?=
 =?utf-8?B?M0tqVlNGeUtCR3FpM0E3cmlieFY0eDlrMEtuak5DcFAvV1RqRXZmU2ZWQlJH?=
 =?utf-8?B?VDFHalpNbzFMc09ZeGs0M3VqNW14UGtHNnZHVDZ0TGIzOGdMVUZiYTY5OUQ0?=
 =?utf-8?B?djRHczMwaUVMSGFyYmtCcUVPa2JsVE1lMng0cy92dFQ1Z0R1V1JZZXliTncy?=
 =?utf-8?B?emV6YkxyaVJQQnNNUlByYjFkQ2JBb0xrNmNqT2RDWFYrNGFXaGlDcVFiaUxC?=
 =?utf-8?B?MHFLbkRLSGxMQkt2QnVBQjd2bFcwT0RrZGRIc1A2dCtlN2xjNEd3NUVwWHNK?=
 =?utf-8?B?aEV6dGZ1dFE0UWJZMEhmSGtBTHdDb0VLOGV6V3NjOXZQc2VqeVpwS1lvbmhz?=
 =?utf-8?B?bjI4b0ZGTHNGVEQ4anJkRmxYaXNxc3BjbGgrN283cVZ3cGo1WjFXUDlQQVBX?=
 =?utf-8?B?aXk2aTJwbGd3RHVMMko5b3dmSUlzOCtMZERHYWc2aXMxaGFBRS9FT2N3NmxG?=
 =?utf-8?B?Y2d3T25vTXplVElqdmp2bEN1UWFNcGJHd1JCanQyMk0vTUpXUUE3OHhCS1Fi?=
 =?utf-8?B?cGVXNTdIOFd6Umkvb29ibTNxelZYc3ZmSTM0VWVvZEtnbU5NL2w5cWwzRWRn?=
 =?utf-8?B?ait5dFdScks0cHo5MDRBemtic0VRYjJiTUxVVWFkMTJYZDNnczdjb2hDajZm?=
 =?utf-8?B?bkdTQjFDNG5jSXc0eEVnTmVLcURNWGI0bGdFbnBsNDZrRHcrVWprclF5NldG?=
 =?utf-8?B?RGFDdTZ4azl4WlI4Q2ZhNWxMU0ErMXNVWXZoZUkySWdHRHFVRndXb0h5cUZq?=
 =?utf-8?B?blFvdnRudDlYVisvSXAzS0twNjExSHp3K0QwWHdmMkpNenNjdWFVb3B3MFU4?=
 =?utf-8?B?RCthVlo0U2k3ZTRFSzIvelN3OENSNlgremV3MkhZdGMvVXc2UVRaUFhxRFBz?=
 =?utf-8?B?b3dxUWViUzZWbFY3aDI0TGFJVEYrbFYvNFJZNk9vVzB6N1J5a295anA2TmZu?=
 =?utf-8?B?R3JWaE1sU2hvY2ZqaWF0eHFjZTNzZUFWMG54cGYvbkpWNFFtNkZVejRFZ2dS?=
 =?utf-8?B?SWs5WllhWFZKcThKeTd5QkpjWWptSnZhUi9FTEZtOHZPYWxkZENaMllsUEdU?=
 =?utf-8?B?TWczcVNhY3pyaU9FclA3YjdCK2NjM0IzV2JDbnYzOUtnMmxySGdsRGhSQU11?=
 =?utf-8?B?QUd5eGtiYlBkN1RwZDhhWEtrbFBzMnlLbUFZbEZYTXQzN3d1cGh0Y2RyL3ZG?=
 =?utf-8?B?NFQvOTVwdFM0aS9sS0pEMngwOXFsSFhLYWpBampicDFwRVRxcE9HeUVZbTY4?=
 =?utf-8?B?NG5oKzNvWWxFUHJremxEeW52dW5EczRYVVM2YkxRb2x2dnI2Z3NWSCtlbkQ5?=
 =?utf-8?B?ZGo1S2xUVzlLNm92QXRFa1UrUFJweWpWUVpFcmhoTS9BeUFSdGhKc0t2RHJk?=
 =?utf-8?B?QUFQdGhRK0h6WVpXZFpadU51cVNBZzZ3Z1JuSmdtVUo5dndVdEpTbFBDd3hS?=
 =?utf-8?B?S3c9PQ==?=
Content-ID: <CA6906418F362F4E9A6BF6E539631AD0@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: nEvNTdMQVj6RoLumNEzWiznsK0ex4Pt4aZ5d17sTl7JrWdRu4Sk/NzbTHxYfwrQNyoNSHhlVccAsDaiQYxirVPfQWOYXi0HwRtscfNB4Q3ZrgutQZutTnSoVzbGbuaSEW9gqcFdkzlhWOeno+mdz7sfHdeS87h0Bg+bCEDBU/jeybiJ2yZio5sv3wqaOqIYIP17du5Xp3t1oErmlI8oOF/6d0VyNCh0MXH9XBM1xjOBsJMAbSecjdLvBZsqxUw6BvSXQKx10weeqjG/TWXfefQFeIul699fRKaOl6VZnGO8BjQfqUrgfLbsekb2h5xTaRf7ffGEpM1mWAbvlnTsz8Xph4p7ucTg+AjqADIrd0WUKhKx7wy9CSzHIR75BwhKdx1kvgLtT/dQsQVGXCohcaEjlR/MgWCw6UjFl9CWiof1Y3tH2+190jJoltLl3hepv7hivWcf+wgYNhKKOk8IsYLpVLFQ3j64po2edBD9wB2pD7Bv14oYLoAdMrYX9+ka3b4tV96c1CFMPhQwP4Irn4bsvcxdclT1+ykz3m5Lh56xqsmAlJOHslRORkSWzg+FWUhjQ/9Bjldu8Rs6NhE1NcrmSf/xC3rJngigzsAmSnbj/mTEMQTO5al8CFeNUiBPK
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11839.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 437f9d98-8b32-42be-8b9b-08dc0b378fae
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jan 2024 02:07:24.0925 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TuUZ0F1ZLA4atTloWfygg2P4/nDUM+VpFOn/m+0Ig5wGpQpFSMb5p2kAi7s/D5k+tD4EVcmqvSbBy34kV8W1zHLXIGcQpMGmLXUGliliOvs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8895
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/7] libltpswap: Add get_maxswapfiles api
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgYWxsLA0KDQpQaW5nDQoNCkJlc3QgUmVnYXJkc++8jA0KWWFuZyBYdQ0KDQo+IEN1cnJlbnQs
IHRoZSBrZXJuZWwgY29uc3RhbnQgTUFYX1NXQVBGSUxFUyB2YWx1ZSBpcyBjYWxjdWxhdGVkIGFz
IGJlbG93DQo+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAvLyNpZmRl
ZiBDT05GSUdfREVWSUNFX1BSSVZBVEUNCj4gLy8jZGVmaW5lIFNXUF9ERVZJQ0VfTlVNIDQNCj4g
Ly8jZWxzZQ0KPiAvLyNkZWZpbmUgU1dQX0RFVklDRV9OVU0gMA0KPiAvLyNlbmRpZg0KPiANCj4g
Ly8jaWZkZWYgQ09ORklHX01JR1JBVElPTg0KPiAvLyNkZWZpbmUgU1dQX01JR1JBVElPTl9OVU0g
Mw0KPiAvLyNlbHNlDQo+IC8vI2RlZmluZSBTV1BfTUlHUkFUSU9OX05VTSAwDQo+IA0KPiAvLyNp
ZmRlZiBDT05GSUdfTUVNT1JZX0ZBSUxVUkUNCj4gLy8jZGVmaW5lIFNXUF9IV1BPSVNPTl9OVU0g
MQ0KPiAvLyNlbHNlDQo+IC8vI2RlZmluZSBTV1BfSFdQT0lTT05fTlVNIDANCj4gLy8jZW5kaWYN
Cj4gDQo+IC8vI2RlZmluZSBTV1BfUFRFX01BUktFUl9OVU0gMQ0KPiAvLyNkZWZpbmUgTUFYX1NX
QVBGSUxFU19TSElGVCAgIDUNCj4gDQo+IC8vI2RlZmluZSBNQVhfU1dBUEZJTEVTIFwNCj4gLy8g
ICAgICAoKDEgPDwgTUFYX1NXQVBGSUxFU19TSElGVCkgLSBTV1BfREVWSUNFX05VTSAtIFwNCj4g
Ly8gICAgICBTV1BfTUlHUkFUSU9OX05VTSAtIFNXUF9IV1BPSVNPTl9OVU0gLSBcDQo+IC8vICAg
ICAgU1dQX1BURV9NQVJLRVJfTlVNKQ0KPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0NCj4gDQo+IEFsc28sIG1hbi1wYWdlcyBtaXNzZWQgc29tZXRoaW5nIGFmdGVyIDUuMTQg
a2VybmVsLiBJIGhhdmUgc2VudCB0d28gcGF0Y2hlc1sxXVsyXSB0bw0KPiBhZGQgaXQuIFRoZSBr
ZXJuZWwgcGF0Y2hlcyBtb2RpZnkgdGhpcyBrZXJuZWwgY29uc3RhbnQgaW5bM11bNF1bNV1bNl0u
DQo+IA0KPiBbMV1odHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vZG9jcy9tYW4tcGFnZXMv
bWFuLXBhZ2VzLmdpdC9jb21taXQvP2lkPTI2ZjNlYzc0ZQ0KPiBbMl1odHRwczovL2dpdC5rZXJu
ZWwub3JnL3B1Yi9zY20vZG9jcy9tYW4tcGFnZXMvbWFuLXBhZ2VzLmdpdC9jb21taXQvP2lkPTZi
ZjM5MzdmYw0KPiBbM11odHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVs
L2dpdC90b3J2YWxkcy9saW51eC5naXQvY29tbWl0L2luY2x1ZGUvbGludXgvc3dhcC5oP2lkPTUw
NDJkYjQzY2MNCj4gWzRdaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5l
bC9naXQvdG9ydmFsZHMvbGludXguZ2l0L2NvbW1pdC9pbmNsdWRlL2xpbnV4L3N3YXAuaD9pZD1i
NzU2YTNiNWUNCj4gWzVdaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5l
bC9naXQvdG9ydmFsZHMvbGludXguZ2l0L2NvbW1pdC9pbmNsdWRlL2xpbnV4L3N3YXAuaD9pZD02
NzlkMTAzMzENCj4gWzZdaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5l
bC9naXQvdG9ydmFsZHMvbGludXguZ2l0L2NvbW1pdC9pbmNsdWRlL2xpbnV4L3N3YXAuaD9pZD02
YzI4NzYwNWYNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFlhbmcgWHUgPHh1eWFuZzIwMTguanlAZnVq
aXRzdS5jb20+DQo+IC0tLQ0KPiAgIGluY2x1ZGUvbGlic3dhcC5oICAgICAgICAgfCAgNiArKysr
KysNCj4gICBsaWJzL2xpYmx0cHN3YXAvbGlic3dhcC5jIHwgNDQgKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrDQo+ICAgMiBmaWxlcyBjaGFuZ2VkLCA1MCBpbnNlcnRpb25z
KCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saWJzd2FwLmggYi9pbmNsdWRlL2xpYnN3
YXAuaA0KPiBpbmRleCBkNGI1MzAxYTUuLjJjYWIxMDQ3ZCAxMDA2NDQNCj4gLS0tIGEvaW5jbHVk
ZS9saWJzd2FwLmgNCj4gKysrIGIvaW5jbHVkZS9saWJzd2FwLmgNCj4gQEAgLTIxLDQgKzIxLDEw
IEBAIGludCBtYWtlX3N3YXBmaWxlKGNvbnN0IGNoYXIgKnN3YXBmaWxlLCBpbnQgc2FmZSk7DQo+
ICAgICogd2UgYXJlIHRlc3Rpbmcgb24uDQo+ICAgICovDQo+ICAgdm9pZCBpc19zd2FwX3N1cHBv
cnRlZChjb25zdCBjaGFyICpmaWxlbmFtZSk7DQo+ICsNCj4gKy8qDQo+ICsgKiBHZXQga2VybmVs
IGNvbnN0YW50IE1BWF9TV0FQRklMRVMgdmFsdWUNCj4gKyAqLw0KPiArdW5zaWduZWQgaW50IGdl
dF9tYXhzd2FwZmlsZXModm9pZCk7DQo+ICsNCj4gICAjZW5kaWYgLyogX19MSUJTV0FQX0hfXyAq
Lw0KPiBkaWZmIC0tZ2l0IGEvbGlicy9saWJsdHBzd2FwL2xpYnN3YXAuYyBiL2xpYnMvbGlibHRw
c3dhcC9saWJzd2FwLmMNCj4gaW5kZXggZDAxNDMyNWU1Li42NThlY2VkZTcgMTAwNjQ0DQo+IC0t
LSBhL2xpYnMvbGlibHRwc3dhcC9saWJzd2FwLmMNCj4gKysrIGIvbGlicy9saWJsdHBzd2FwL2xp
YnN3YXAuYw0KPiBAQCAtMTEsNiArMTEsOCBAQA0KPiAgICNpbmNsdWRlICJ0c3RfdGVzdC5oIg0K
PiAgICNpbmNsdWRlICJsaWJzd2FwLmgiDQo+ICAgI2luY2x1ZGUgImxhcGkvc3lzY2FsbHMuaCIN
Cj4gKyNpbmNsdWRlICJ0c3Rfa2NvbmZpZy5oIg0KPiArI2luY2x1ZGUgInRzdF9zYWZlX3N0ZGlv
LmgiDQo+ICAgDQo+ICAgLyoNCj4gICAgKiBNYWtlIGEgc3dhcCBmaWxlDQo+IEBAIC02NSwzICs2
Nyw0NSBAQCB2b2lkIGlzX3N3YXBfc3VwcG9ydGVkKGNvbnN0IGNoYXIgKmZpbGVuYW1lKQ0KPiAg
IAlpZiAoVFNUX1JFVCA9PSAtMSkNCj4gICAJCXRzdF9icmsoVEZBSUwgfCBUVEVSUk5PLCAic3dh
cG9mZiBvbiAlcyBmYWlsZWQiLCBmc3R5cGUpOw0KPiAgIH0NCj4gKw0KPiArLyoNCj4gKyAqIEdl
dCBrZXJuZWwgY29uc3RhbnQgTUFYX1NXQVBGSUxFUyB2YWx1ZQ0KPiArICovDQo+ICt1bnNpZ25l
ZCBpbnQgZ2V0X21heHN3YXBmaWxlcyh2b2lkKQ0KPiArew0KPiArCXVuc2lnbmVkIGludCBtYXhf
c3dhcGZpbGUgPSAzMjsNCj4gKwl1bnNpZ25lZCBpbnQgc3dwX21pZ3JhdGlvbl9udW0gPSAwLCBz
d3BfaHdwb2lzb25fbnVtID0gMCwgc3dwX2RldmljZV9udW0gPSAwLCBzd3BfcHRlX21hcmtlcl9u
dW0gPSAwOw0KPiArCXN0cnVjdCB0c3Rfa2NvbmZpZ192YXIgbWlncmF0aW9uX2tjb25maWcgPSBU
U1RfS0NPTkZJR19JTklUKCJDT05GSUdfTUlHUkFUSU9OIik7DQo+ICsJc3RydWN0IHRzdF9rY29u
ZmlnX3ZhciBtZW1vcnlfa2NvbmZpZyA9IFRTVF9LQ09ORklHX0lOSVQoIkNPTkZJR19NRU1PUllf
RkFJTFVSRSIpOw0KPiArCXN0cnVjdCB0c3Rfa2NvbmZpZ192YXIgZGV2aWNlX2tjb25maWcgPSBU
U1RfS0NPTkZJR19JTklUKCJDT05GSUdfREVWSUNFX1BSSVZBVEUiKTsNCj4gKwlzdHJ1Y3QgdHN0
X2tjb25maWdfdmFyIG1hcmtlcl9rY29uZmlnID0gVFNUX0tDT05GSUdfSU5JVCgiQ09ORklHX1BU
RV9NQVJLRVIiKTsNCj4gKw0KPiArCXRzdF9rY29uZmlnX3JlYWQoJm1pZ3JhdGlvbl9rY29uZmln
LCAxKTsNCj4gKwl0c3Rfa2NvbmZpZ19yZWFkKCZtZW1vcnlfa2NvbmZpZywgMSk7DQo+ICsJdHN0
X2tjb25maWdfcmVhZCgmZGV2aWNlX2tjb25maWcsIDEpOw0KPiArCXRzdF9rY29uZmlnX3JlYWQo
Jm1hcmtlcl9rY29uZmlnLCAxKTsNCj4gKw0KPiArCWlmIChtaWdyYXRpb25fa2NvbmZpZy5jaG9p
Y2UgPT0gJ3knKSB7DQo+ICsJCWlmICh0c3Rfa3ZlcmNtcCg1LCAxOSwgMCkgPCAwKQ0KPiArCQkJ
c3dwX21pZ3JhdGlvbl9udW0gPSAyOw0KPiArCQllbHNlDQo+ICsJCQlzd3BfbWlncmF0aW9uX251
bSA9IDM7DQo+ICsJfQ0KPiArDQo+ICsJaWYgKG1lbW9yeV9rY29uZmlnLmNob2ljZSA9PSAneScp
DQo+ICsJCXN3cF9od3BvaXNvbl9udW0gPSAxOw0KPiArDQo+ICsJaWYgKGRldmljZV9rY29uZmln
LmNob2ljZSA9PSAneScpIHsNCj4gKwkJaWYgKHRzdF9rdmVyY21wKDQsIDE0LCAwKSA+PSAwKQ0K
PiArCQkJc3dwX2RldmljZV9udW0gPSAyOw0KPiArCQlpZiAodHN0X2t2ZXJjbXAoNSwgMTQsIDAp
ID49IDApDQo+ICsJCQlzd3BfZGV2aWNlX251bSA9IDQ7DQo+ICsJfQ0KPiArDQo+ICsJaWYgKG1h
cmtlcl9rY29uZmlnLmNob2ljZSA9PSAneScpIHsNCj4gKwkJaWYgKHRzdF9rdmVyY21wKDUsIDE5
LCAwKSA+PSAwKQ0KPiArCQkJc3dwX3B0ZV9tYXJrZXJfbnVtID0gMTsNCj4gKwl9DQo+ICsNCj4g
KwlyZXR1cm4gbWF4X3N3YXBmaWxlIC0gc3dwX21pZ3JhdGlvbl9udW0gLSBzd3BfaHdwb2lzb25f
bnVtIC0gc3dwX2RldmljZV9udW0gLSBzd3BfcHRlX21hcmtlcl9udW07DQo+ICt9CgotLSAKTWFp
bGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
