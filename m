Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57F8FC3DA59
	for <ltp@archiver.kernel.org>; Tue, 16 Jul 2024 04:26:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4636D3D1A60
	for <ltp@archiver.kernel.org>; Tue, 16 Jul 2024 06:26:23 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4DDCA3CDE69
 for <ltp@lists.linux.it>; Tue, 16 Jul 2024 06:26:04 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=toshiba.co.jp (client-ip=210.130.202.131;
 helo=mo-csw.securemx.jp; envelope-from=nobuhiro1.iwamatsu@toshiba.co.jp;
 receiver=lists.linux.it)
Received: from mo-csw.securemx.jp (mo-csw1120.securemx.jp [210.130.202.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 00CDD6008C0
 for <ltp@lists.linux.it>; Tue, 16 Jul 2024 06:25:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toshiba.co.jp;
 h=From:To:CC
 :Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
 key2.smx; t=1721103952; x=1722313552;
 bh=E4NIeG4iufdtfKj+pmFSCwE3zfSO4YCHJ+KWbYW
 bAa0=; b=mZgUR5HbnDSpNRX+nQotd4s2DW4tW3CnZnxLnqmueaE2z+Q35XaOmk0TaNboc1Z5cmxFl
 dwT8CS/eSXJHEPoRObK6ygzIw+A0KSXvQk6LpmQjgZLjcidexiSQbNL/bF/O5gcq0iOuTwpYAh8DG
 lmcMSc55sRJio7/XN3tjfaGXApNHtGkTrRA/HpKCuAkPjkq90GicznDwqDQ3ONKNQd2t6bqKikaO0
 76rpy44CM0qELeR4ELSKTBnEL+WEgy+1JO7qmMTPEQ/AJMlxvWtqXFIoM21JkEXUi9/2EmWQxKK32
 9uMlJ0O/oWGcb3gu7Xu0uPSpvIotdmCRlqGbPIbjRQ==;
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 46G4Ppx73747460;
 Tue, 16 Jul 2024 13:25:51 +0900
X-Iguazu-Qid: 2rWgU4KG4aRdWykVve
X-Iguazu-QSIG: v=2; s=0; t=1721103951; q=2rWgU4KG4aRdWykVve;
 m=shp7cj2Bo+4+LYxS39TxG8fldI3nye26V9rF24zgN0c=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
 by relay.securemx.jp (mx-mr1123) id 46G4PoJn038235
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 16 Jul 2024 13:25:50 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gJneRsVhIpyf2Z/Uw0zA5GAaagxR+SiHBWFjUw2RjxmUW9GFMttKjkU4wv/R+nY1kc6mGeRec9rc1Ji5x5KNYhfR6eb6Sv1fba2fcDdBTbXACrNymfATPjsHQEprwCRKf2bT43YHet1AlwOfsBl62jOX3u+0qdXkCdS5jWG+fUK16NcTEcW0lgDt74tDjfx5jjs9ALzSR5zKi/8EgVGAcPP1xaiUY5+8Sa8bdtAH7oajMORkrSqRhXihDywGes//ys2ZfIYwU9c5dP42WApGotF46zNLToLScDZs3phThAr3gF/CG3DIeX361hkGSBWQ4jEyFhVaXpsf9epJ+W57OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E4NIeG4iufdtfKj+pmFSCwE3zfSO4YCHJ+KWbYWbAa0=;
 b=P04jcf5YIk8kPPbUi/zfxd6Kzvkl9pi3yHLRdYohWUQkdkVJCJ84gOAMnaTIfvJxwkbQH7ORmG+IT+bUCygJg178O7TYCmbo3c4TPKwhQMz7vwCdeiqxhEYbM1WNfq0nHdPh2+kyVAN4QCk3o4RVDB0pU5XgmuPKnISy0BR7clbBsmDDDWpZv5QCtUUQm2U3/fkUoYiU0gxkRP54A2/g44kV0T6YbL7Npd/D9imsrGbR4cZIvgBXKz2t4QC0LkPTICblE8H7Cvb1Kp7elbS+VkBPYABYq33yRIVHhL39npQOOQ4WrKZrskkSfBA1LVoUxX9OKqe4qDcFZ7i/cKNLSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <edliaw@google.com>
Thread-Topic: [LTP] [PATCH] lib: tst_fd: Add kernel version check to
 memfd_secret
Thread-Index: AQHawVxjuX99tooiv0ut5Yo6NW/jt7HSFDkAgArWOgCAFqjfAIAFMIhw
Date: Tue, 16 Jul 2024 04:25:47 +0000
X-TSB-HOP2: ON
Message-ID: <OS0PR01MB63882847F6B096C696DBD17692A22@OS0PR01MB6388.jpnprd01.prod.outlook.com>
References: <1718700544-17304-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
 <20240621110924.GA672386@pevik>
 <OS3PR01MB6391B5AD36997AB801C0E06A92D02@OS3PR01MB6391.jpnprd01.prod.outlook.com>
 <CAG4es9U42+AvgM2upLfuKjKzBySZ3y9kLRkGr=sngYw_uBBMNg@mail.gmail.com>
In-Reply-To: <CAG4es9U42+AvgM2upLfuKjKzBySZ3y9kLRkGr=sngYw_uBBMNg@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6388:EE_|TYWPR01MB8493:EE_
x-ms-office365-filtering-correlation-id: cb38f0da-4972-4657-7e03-08dca54f5e1a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?UVk3K0UyenJFWWg4UDRrN2lDL0dHOUNuZjVDOXF3VWVMMm05N1BZSGNZQ3Yr?=
 =?utf-8?B?MzZjL3JFak44YjNxN3lJVzhldjdEWjRvd2hzbHVXZmJXb3hLWEs2UlJPa1dT?=
 =?utf-8?B?ZGJpZ200Z2hmSGxTSFdXTUF5QnFCU0s4b2dlOHdLOVc0dndLN3JPT2ozeExT?=
 =?utf-8?B?bi9kVnBUZHJYelJKQjIwVjhwT0ZMdllkSFBtcU5yWkJuMDBicHFUWkJZYk9I?=
 =?utf-8?B?TmR1QjlNUkJUUWpSeXBRd1hucXBCUHlNM1dDWjFXRzlPRjEwWXFiNkhZdDVE?=
 =?utf-8?B?c0QzaExnRGFORmZtVHZRWFByU1RHMFlvVG5DOWdGb016emNHV2Y3Sm5GUUlh?=
 =?utf-8?B?QkJmNm5yQnBrUXRYdThMVkpVTzVwc2k4OTdyWThQTkJvcCtHWDdDN28wbkl1?=
 =?utf-8?B?V2xwWG41NzZqMUh2WkNWUTVMdU0zbG5JS1B3NE9SVk5ObktBU3hqM1JXZlN4?=
 =?utf-8?B?R0lObGlpS1hZUktwUDkzcHcrREtyMjFSR2pnREtDS3d5RWZZcXNIcTA4dDBa?=
 =?utf-8?B?ODFPTkpSZVBZQ09Yc1lHbXM4VjdaVWJIa2lWTkhlYklRdnZ4cUZGcndtZXVB?=
 =?utf-8?B?SHdmeVRmUGNJQmozY014ZmVJdEorUnp2TTI0UWgxNDFkK2hnRUcwOXhZVU9k?=
 =?utf-8?B?UWdpd2MzcjF6RzBoNGlwSm9WK0l4dEdpcTR2UkpRNG83bjVvTDc4V0V1RUQz?=
 =?utf-8?B?N29ZcnA4N1h2VGY3aWRDSzJmUjI0RjQ0WSsvSUFTMTNtYlZhbEUrRTZabjUy?=
 =?utf-8?B?cUVnRzFnclYwbUFFejFYTVNuL1VmWWdrZStVWG5sbWJUVGZNM2NDVXN3SzZV?=
 =?utf-8?B?LzhJVzNoSEppa0JaS1RYVTBKaFczdDdxVlJKZHNvRmR0YVBCRWJJc0pTK09z?=
 =?utf-8?B?Njc4RVNyMlRHMWttbGRZN28xQWdNTUo2Wm5Jc1NaR1lmRFBzZmwrbmg2M3FR?=
 =?utf-8?B?SHl0dnpjbTUvY01VdXZhTUsxS0RwVFlndG02Sk1HNjQwMG5lL09MM2tiZHlB?=
 =?utf-8?B?U1VlVE91SXg5NHBuaGRaSEZPK2VwYi8zTEg2YjVoUGV1dC9IUEZ3a3I5dHB4?=
 =?utf-8?B?WGFmOGZmUnNpUEtOdXFRbXpycjFyblBvdXpycmw1Q3BlcFNma285OE5scFZr?=
 =?utf-8?B?WFdzby8xbElVb2MrUXhlQW85SmJXRGRiRWtQTHBQSmxGa2JLM2hXT1F2YXRn?=
 =?utf-8?B?a0lZWSsyLzQ2TFZtS2wrZUIzRFdOaHUzRWdSMXRITFZVVlJldHdlVlpKZ1Av?=
 =?utf-8?B?N3ZiU2sxaStuTVB3cUg0eVVqRXVwQ2MwTzFFcjZqd2cwaUxIM29pZm15anp0?=
 =?utf-8?B?NXlMYzRkbXkvblVCUVlmMjJVWm53YWJKaTVxMzV0K3ZOdmkybWx4cnVEeE12?=
 =?utf-8?B?Zm9ZYmVFNUlmYmpacG0yM2pyeXI2Qy81TWNlOEVVTEJFSW0vVkVDVmJ2dHVE?=
 =?utf-8?B?UFdRUDl4YzlwSzJwNHpNbXllbnJQUEU0cWxQcEJsWW1tOUtjR3hPYlQza3FX?=
 =?utf-8?B?ODJmTnJ1Sk9zbFJCeHNNRDlJeXlxeGtRYk04MzVBOWpHK2xQVmNJL0R4OHpW?=
 =?utf-8?B?WUVNazNVWklGM3NlYjA2U0RadEFNdlBnNFhSbzBGSCtIdmlBUUxRaElHVGpa?=
 =?utf-8?B?Vk1Mc0g2QUZqVXJWUjdIR0djOExYcmJ0QUgrZXZaQzhKWVRaMXVMR0tsSDBE?=
 =?utf-8?B?RmpvSlhtSERLanNFUVpRSlIzT1lJZlhPUkZ6YnZQL2dLODVTYUtJVjNXaVI4?=
 =?utf-8?B?SnFDY1djbk5jdmNpVW9KZDJoMm5LRVBPRzBUOER5MmEyMjlUSmJQQU1SVEND?=
 =?utf-8?Q?6GkLd3BBzXkldmckzP00TRzN7xst3imYFJpJw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:ja; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS0PR01MB6388.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WVFRUkxQMWRoaDZ5cmNPb001VXlEemdDS0ZVckNSb24wUmdrZEZ4KzNpaDB2?=
 =?utf-8?B?b3JkVkV4VVFBdEQzVTNla2wwS2UvanVpZUpsVU0zVko3NE1NNTNFekxscVlm?=
 =?utf-8?B?MnIwb1RFWnlGTE5TQnlpalZmRlFxd2E4M1lkQTdDczBPY0xtZEkwcTVaYUhM?=
 =?utf-8?B?QjVtdnluUGVwWWd4ZWF3eFRjRnhyajNhd3ZNVzJVS0V2WHNLMlFMN0NaTjZx?=
 =?utf-8?B?Y1Y3Ri9qbWxyMVcxZzREYjM1RHFMVVZKRkxsUWx2eHdoNkpTZ1IrRTdhLzVU?=
 =?utf-8?B?RDgxdEgzQml4TEo5V3g5MVRWZFVRb0Y2dkoraXE3c3pISEV4YVVVbHNZSyt1?=
 =?utf-8?B?Rlp4ZFhKOFB4aHpESi9oQ1A0N3JDTE45RjQrTWQzdmNST2ZPbDVPSWVtOFpj?=
 =?utf-8?B?a01tZnA1Yjd4Mmk0M2d1WkJtWTB0RFViNG9ya0dQSlhYLzZyWjQ2MjdvUUNN?=
 =?utf-8?B?UllnM25LZjFXbDZhcjk5eDFnTTlPV2VSOVZBdmJJMzVJVEcreWcrclF5TG9v?=
 =?utf-8?B?cGVtUWdxYkVMYmZ2NElzYW5iK0dOV2VITEF2NkRHaU44YldOTGllTFN2TkdI?=
 =?utf-8?B?NlpOUHZzYUJKWkkyd09zejUrNHBSRzZKeFFueGxNTGJTKytISTRBWlRWQ1hY?=
 =?utf-8?B?WFpDOWVPWnNNeW14UnFtYXdDYUloNHVVTlBxRzllVUVmR0tocER5WkhFcmdr?=
 =?utf-8?B?dHh1L043TzUrbTZhOC95S2JSVldXTnRBWUZtQVVPRFg1QXRUQnhvMGVzRVhn?=
 =?utf-8?B?elVNUUJncXQxb0tWRlhDLzBQSjl3OVFHZU9zclYrOExFRkNzdDlGMUtDbEZN?=
 =?utf-8?B?TWdwOS9HRzZnZTRZMVA1bG1oekF5d1oyTExrN08wNjJtK2ZqVTNKUkI1Tmh5?=
 =?utf-8?B?ekdsNjRTK3Y1Wnkvdk5SekVYamFmYWdKRFNYdExKK3VyZXFaWkZ5bVgzZEh4?=
 =?utf-8?B?My94dWo4WCtySS93REpJbDl3VWV1cGt4SWpHNmFyZ1RSRittc0tibWlGQkh6?=
 =?utf-8?B?N0QrRDJOWG9TbTE2WE1XcVpkWi9WMStLTnVqUG00Q3NsWEVjbjNXb213MUV2?=
 =?utf-8?B?VTQwSituTWtzZkMzSWE3dENTOFQwMkxhK0dXcGZsT1J1R2hKYWQ1Rzllaita?=
 =?utf-8?B?aWFnWXNSNUhHN004ZjQ1TXkycUNLUTJYbDdJTEVsRy9CRm5aZTNRbzE2TmVu?=
 =?utf-8?B?bURYSG9rVjVqZVQyRUJnUlB1OUF5eU1RZGlPSTk4cStSK3Z6UXAyMUJvV3hi?=
 =?utf-8?B?V3Vxbm1MOC80NFZkMWt1enpzd291TEF6cjNEY0xOZW5aMjR6ZWgydk1mQVc5?=
 =?utf-8?B?UVluNlZzYlA1d1hmRE8wRjhUZnlzRHJnMms0bThNbXB1ZVNKM3NxNS9ndVpT?=
 =?utf-8?B?MDltTUdmN2ErcU5JSnNLVTQwbWY3cGpmaG54Q0VEMXFjRXc2VVRlQy9SVU1H?=
 =?utf-8?B?c1ZTWnZETEZnZjBtL3pDdzl3UXdOVGtVWU45eGhzcklmUmwxSm5UQmRZWE1w?=
 =?utf-8?B?alhBeDAxQW83UVk3TE1qbG1BUmRTU2lHNTIyOVQzRmtMSE1PMXdjUDFvVFlS?=
 =?utf-8?B?TTdXbGdJVVE1WXh5UWxydk1oWkVLVmlZdzJiblBGTW50dTB3UVU0b2M2cXNw?=
 =?utf-8?B?TS9MQ0RlQlNQY3BuR3lveWlkeVF6Uis1b1ZEdDhUK2Fxb1c5WWNKcXF1QWNW?=
 =?utf-8?B?TStqMFY2cVVNbG1oUGZQT0x5a1hoK2FDQ1FoNkJ6WStwb05jaGVTVkF6MnV2?=
 =?utf-8?B?allRcXFoWUhzdlJjdWd5REtNdU8xZE5NeXBZNGtqMVBsYWFpdzJqK2draEg2?=
 =?utf-8?B?UXlBaGxyVURsQjNaZmtZRW9Pd3gwOHlRYWFPN0d5MEhKTzhGQ2d2UnMxYXJB?=
 =?utf-8?B?aGxIa0EwUGtLUGxnOFdCc2JKcmh3N0kzbUpmWDVoMnhSSTFxVm1OVWVrcHcr?=
 =?utf-8?B?OFVlbkxSdVMrdXB6VWZhbVhSZkxRdzVqL25SV0l4cEszcEJTZTRHVWQwdUZk?=
 =?utf-8?B?Sml3aGFubTNOVENlS2FNc08rNkV2NXVPbjJjK2hEUFFsVmtHNHBSNFU5ck9B?=
 =?utf-8?B?dDRxaHhiY2J3T0cwNmNnM1k1ZWQ5WHcxdW1rcmRYOXQ3ZEN5cm14MVRWSUdt?=
 =?utf-8?B?dGFHTW10OHhyYjJ4d211UFcvdFVBK0pNNUtyaXVzeXgwU0lQckFpVlZFZ1pL?=
 =?utf-8?B?RGc9PQ==?=
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6388.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb38f0da-4972-4657-7e03-08dca54f5e1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2024 04:25:47.9362 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MAiACmgY2Zc5ooNZIkQzH78m97ED2Kga0f0edjMjljeHyAfCnCufI/vLk2Kx84iHPUfw8eNKK9fABbW4vs8h4kOWzMpKm19z0ToztiWfDFDqiV2GFBUJECtdwfV4Yg4l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8493
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib: tst_fd: Add kernel version check to
 memfd_secret
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgRWR3YXJkLA0KDQpTb3JyeSBmb3IgdGhlIGxhdGUgcmVwbHkuIEFuZCB0aGFua3MgZm9yIHlv
dXIgdXBkYXRlIQ0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEVkd2Fy
ZCBMaWF3IDxlZGxpYXdAZ29vZ2xlLmNvbT4NCj4gU2VudDogU2F0dXJkYXksIEp1bHkgMTMsIDIw
MjQgMzo0MSBBTQ0KPiBUbzogaXdhbWF0c3Ugbm9idWhpcm8o5bKp5p2+IOS/oea0iyDil4vvvKTv
vKnvvLTvvKPilqHvvKTvvKnvvLTil4vvvK/vvLPvvLQpDQo+IDxub2J1aGlybzEuaXdhbWF0c3VA
dG9zaGliYS5jby5qcD4NCj4gQ2M6IHB2b3JlbEBzdXNlLmN6OyBsdHBAbGlzdHMubGludXguaXQN
Cj4gU3ViamVjdDogUmU6IFtMVFBdIFtQQVRDSF0gbGliOiB0c3RfZmQ6IEFkZCBrZXJuZWwgdmVy
c2lvbiBjaGVjayB0bw0KPiBtZW1mZF9zZWNyZXQNCj4gDQoNCj4gPg0KPiA+IE9LLCBJIHdpbGwg
Y3JlYXRlIGEgdjIgcGF0Y2ggYmFzZWQgb24gdGhhdCBzdWdnZXN0aW9uLg0KPiANCj4gQSB2ZW5k
b3Igb24gYXJtMzIgcmFuIGludG8gdGhpcyBpc3N1ZUkgYW5kIEkgZGlkbid0IHNlZSBhIHYyIHN1
Ym1pdHRlZCB5ZXQsIHNvIEkNCj4gc2VudA0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9sdHAv
MjAyNDA3MTEwMDQyMjAuMTMzODA4Ni0yLWVkbGlhd0Bnb29nbGUuY29tLw0KPiB3aGljaCBpcyB3
b3JraW5nIGZvciBtZTsgZG8geW91IG1pbmQgdGVzdGluZyBpdD8uDQoNClllcywgSSBoYXZlIGNv
bmZpcm1lZCB0aGF0IHRoaXMgcGF0Y2ggZml4ZXMgdGhlIHByb2JsZW0uDQpUaGFuayB5b3UgdmVy
eSBtdWNoIQ0KDQpCZXN0IHJlZ2FyZHMsDQogIE5vYnVoaXJvDQoKLS0gCk1haWxpbmcgbGlzdCBp
bmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
