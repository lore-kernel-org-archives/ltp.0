Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED404C2BA1A
	for <ltp@archiver.kernel.org>; Thu, 20 Jun 2024 01:22:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3FB8D3D0DFD
	for <ltp@archiver.kernel.org>; Thu, 20 Jun 2024 03:22:56 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D88AA3C0FCD
 for <ltp@lists.linux.it>; Thu, 20 Jun 2024 03:22:36 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=toshiba.co.jp (client-ip=210.130.202.152;
 helo=mo-csw.securemx.jp; envelope-from=nobuhiro1.iwamatsu@toshiba.co.jp;
 receiver=lists.linux.it)
Received: from mo-csw.securemx.jp (mo-csw1802.securemx.jp [210.130.202.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 6BAC4200BB6
 for <ltp@lists.linux.it>; Thu, 20 Jun 2024 03:22:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toshiba.co.jp;
 h=From:To:CC
 :Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
 key2.smx; t=1718846536; x=1720056136;
 bh=su5wPKSTOLi9+wHMaYUSWXVtMvNtrTX1s/1Yx2d
 h+/A=; b=cDwqI7li6FfsbMUtQjws3tyaS+XBHRKIKCsCyXVnagASqyz0wzM/sVzYX6KPVE475pB2F
 683/lSMhTHxScDlZyLe3MXnucUMtYoalDs5sewpUVhNp2W/5Rq9f1LXLjg0Mh0/QNw2ICPnrdzOoY
 20oj2isAqVBXxmV+J69R86hb1pz2VoObTY0yEp/bnrQZzbgRc9Ct3EQ8uezb3SD+FwCOWQguFuRu0
 wD+fDjHBKed/un8g+q8jQfOdvKuZbCy5agQkhBZS4aDuAgA/OPIcPMHh55ZP5/rH9zh8e5+1NUJbi
 rBphVCB9sKMf08zzlDfKIAojIswQbcZY13rjtlC8QQ==;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 45K1MDMS2579653;
 Thu, 20 Jun 2024 10:22:16 +0900
X-Iguazu-Qid: 2yAbAhOadnRkuWOYwr
X-Iguazu-QSIG: v=2; s=0; t=1718846533; q=2yAbAhOadnRkuWOYwr;
 m=6I9cJtUGGBlbc/osdIVEa32ayejpoR7E5xydppRb3JQ=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
 by relay.securemx.jp (mx-mr1800) id 45K1MCug3938314
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 20 Jun 2024 10:22:12 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UO/3PeTOWTg63hZaiI2wk6L7d5dXfSZto49xDFY/qq9vcwicAz58R8FqbmqWAnPV+hCWZ8NnL4k3Z1aXpJeSsKkqfGttCyMpupMq2VQHHyofpOLC3LPa0B7DF5ldE8aoaYy5Um7BDs/usEhxvr+b2p7DQUGHglOsHfB3uh7QfazapiLCINp5g518DGYM32XHanqVu75i+dDsKERTiEBNOeL2AWfo98dYmruT3DY5WQVIWsrsHrWJAuk7zpK2vNPf0/UDJZAUNcCaby4OJYcga9le2QY/UUt4bx3RcySdSSY3A3vkvAyswjO0bXkKSXaPJ7QoVp7IJEh3P3f0Iwplwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=su5wPKSTOLi9+wHMaYUSWXVtMvNtrTX1s/1Yx2dh+/A=;
 b=L6HXoBY0XkIA3/ucm9oyRFf+IvaI4i0xC9YioTTFdqP3TEKonpHLsEmLzsqC5Tv6RbZtdMaykKCJ57+dLJd7CEr21pW087lLD038AcqAvP9EghGbRQiXz2vYqxUfWF8bMTdKw2T3/h9zxkt7+3BP3b62wXnO60aE1ApuTnafktqz+YQNhrpUw8N0d0rq6J+o6dGeawQ5zcgYLwL28VU5BB+DF5MctoLZLIpRS4VoVQ473oq28yQnQXg2b4LsscKDmmUzeWGgowti4NWdchbDDxF6ZLWYTV/NdyXvDMfZzO280jgtBZ+qouzm91Kij8T9ZGkegWU99o4UOtk9YqAbYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH] lib: tst_fd: Add kernel version check to
 memfd_secret
Thread-Index: AQHawVxjuX99tooiv0ut5Yo6NW/jt7HNTkYAgAE52CCAANK7AIAANp9Q
Date: Thu, 20 Jun 2024 01:22:10 +0000
X-TSB-HOP2: ON
Message-ID: <OS0PR01MB6388E3415F131E666FFC337892C82@OS0PR01MB6388.jpnprd01.prod.outlook.com>
References: <1718700544-17304-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
 <ZnFeWJJldj_ggKnq@yuki>
 <OS3PR01MB639110A9BC48CA10A9D97FEC92CF2@OS3PR01MB6391.jpnprd01.prod.outlook.com>
 <20240619173324.GA504021@pevik>
In-Reply-To: <20240619173324.GA504021@pevik>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6388:EE_|TYRPR01MB12351:EE_
x-ms-office365-filtering-correlation-id: 6cf2b399-e5fe-4d7d-8a7e-08dc90c768a2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230037|376011|366013|1800799021|38070700015;
x-microsoft-antispam-message-info: =?utf-8?B?L01HOGRhUVJ4VTdZU3lWRjdicFpNY2NPYTAzeGFXbHpDNmloQ1lKM0tZTWQ3?=
 =?utf-8?B?Nk5ZWDZTQVJyRThEVjRTOUo1bHdJOVhvQk5VU2psUlZoZTIralJmc1VQSHJm?=
 =?utf-8?B?OWNCU0ozdE1YL1VUUWhSVkpza1ViTTJMMU1UU0F1YVdmaE5TOE1KOGV4aFBw?=
 =?utf-8?B?REpJK05WUXRNV2pGSWIxRXlZTktRSXl1V1F3aUdKQ2p5K3NvbmVPUkIrRTZR?=
 =?utf-8?B?b25DbTI0VS90RUo3WCtGSU0zMFRRdkVYbklKZWtiaVQ0SWExeXQ0VmFQaHZr?=
 =?utf-8?B?eTErbUI5R3VhTlBSbHVjZnEwcUc2dVhIZjBVNGdEUitFQmJuNjhWaDFlRnlo?=
 =?utf-8?B?OWxncXZZd3RMVmFTTGRBV3pVQ05aeVFLZUpPbjJZOFJ1OGJRZzAyV3VyTTY4?=
 =?utf-8?B?dHY1UDgrZlh5cVVpZ085YUtmTDFZT1NNai9XeVhLd2VFZ3ZjSTBWM3dVeTJF?=
 =?utf-8?B?bHZTTkFTajN6c0t1WENIOU5yOGRyR3FrMXVzQzdHMCs3VURDSFg5ajBJUEhj?=
 =?utf-8?B?ejhnMVYxZ1dNMWpBd1RobTYyL05DcEpJSVM3N1lLN2QwVVVzeWZuTU11b1pK?=
 =?utf-8?B?UmtFTzVsYndwakZqQ2xVQkxzL2s0blhhVWNkRlkwa0pwc2ZpWnhNbUY5RFF6?=
 =?utf-8?B?YWFmZW55SHRCWDBhTXhua1EvMU05dmN6SFBnTnlKdlF5SGlKSkJYR1puZmxv?=
 =?utf-8?B?WjBlTU4vTnR4bmZ4Z1JLeVBrS0pTTys4THQyT0ZEK21HRXJYTGJnRjc1Y0Vs?=
 =?utf-8?B?Z1VtaDArNmozSEFEaWtEK0huUzdaNVZJeDA3a24zWXBJaERjWnJIUHFhL2c1?=
 =?utf-8?B?MGVYWUE2VnB4SVI3SHF0cEU1Mm4vZzZWb3JzbnAvZEZXSm1oL2N3bThQQmhR?=
 =?utf-8?B?VEIwZHpreDM2ZjFXZU5nK0JDZDk1RmRmVll2QmRNNkx1Mm92TmJ3eXdFV2tB?=
 =?utf-8?B?a0QrRDZQaG4wV3ZQRWE5akdvYmhmT2hiMUM0T0RqcVdpeGN6WHQvZjJOMjlI?=
 =?utf-8?B?RTIvN3FLTWN4blJWcm1zTXNLaEpVaGFoWDArNFQ2OTJiMVhJaU9PUGRXVUVT?=
 =?utf-8?B?cW1HN3hSb3I1TUNOUklvMXBzYTBtaWoxSksrTDJWMm01b2JpVUdBcThuUEhR?=
 =?utf-8?B?ZHpLN01zOG1rNHNTZkIxcmNmLzNVTFhGUWVvOTB4ZzVrYXFyR01LTHJ6TEJs?=
 =?utf-8?B?V25mNmFtWGFTUFgzVlorWFk3U1l2WjkxbnpuWlNPWlo1dzYyWS9mSkdJa3Uv?=
 =?utf-8?B?WkJSejRjd1UzcDR0YWFYQW9GY0h2ZFNtbjYxZi83TnlpeXBNVURDWnpiZG1x?=
 =?utf-8?B?RWtNRzZidTNGeDlMTWd3dUtVeW4rWTdWbk5LeFNEVVNZc2dRdUgvdHJKd2lH?=
 =?utf-8?B?SVNmN2hFN3o2TEsxN1Z3TlRaeU1oN1dhNlpNYitBeGJIQmgvSUJHbkhDa3I1?=
 =?utf-8?B?NWVhLzhNM1M2M0FlNXhZdVlCMTZhUURYT1JIendPVVg4eGFpWTFsTGoraitx?=
 =?utf-8?B?RFRYbFpwOW51VllzOHd6MG5nYUpLL1VJaDdqUGpWZjJXWk5pZ1VhYVBBaHhD?=
 =?utf-8?B?UHRmeUh3NlliZDBtamlvYmU3SEhtckVVaUFVemdMcHJ3cjRXMlQ0RjhuREFP?=
 =?utf-8?B?YXZsVVZpUXFvQlQycXBnVUpVd0luaEEyQWlYeSs5aGV2MW14dVE1RUZya081?=
 =?utf-8?B?ZytFblFSYzE1anI0Ykw1TENMbE5ZcEVSUG1wQ3dpRHorall4LzNtbW54YVM1?=
 =?utf-8?Q?GVa1zihaYdotqIPoFOcNHn8Wr7Xwr5uzud/nApp?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:ja; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS0PR01MB6388.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(376011)(366013)(1800799021)(38070700015); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YnRYOWkvTFM1ZUFMZ0piY1JmVEhYR3hINXRDM3hGRnZUeDVOam5YYkNmZVQx?=
 =?utf-8?B?ajJGbUx6OVFzczZqS3cralF3WHZORnViMWMzTTFYakJxbytROE9OYjFZTThy?=
 =?utf-8?B?bHRDWFdmdFJFaWZxdTk4aXNtaEdPMXE2aTFjTGNjclZwMHdFWTVpYVViczUr?=
 =?utf-8?B?end1UFdDclJWcTNkZmxhNFIrdklxaEF0WWVNRUpSTGNnM05pRmJGdkl4cmRa?=
 =?utf-8?B?bXhvd1VBNmN0dktJbzBVaDl4eUs0ekgrdDI1NE9UNVRsb2dUK01rQjdOY2dV?=
 =?utf-8?B?MEhhZzJ2K3M5R0RmS29Xa2lCZW5YMTRGdjVzeFZaNXVtUTUvcnlJVkpBQUxB?=
 =?utf-8?B?aTdzb05jVXRSUGpOSnBSRUdOYW14UEtlVUE5YWQxSkhxM05Jb2JUV2Z5aXgx?=
 =?utf-8?B?MmpOdHgveVQwU2dOYWZ3RGN2MmVrekR1Uld0YWw4alRHYTFLT1VEaDZSd3Yy?=
 =?utf-8?B?VFpCdVNKVGUvemlZUFNuUjJqQ04yNmEzRWFPdit2VlNZS3hOMDFaaTBHbG5D?=
 =?utf-8?B?b2ExRkhMUmRmZFhnOTNpMmViWjNUa2Ywd0YwWlM4WEgvZnd0dXhJbVN6SDRt?=
 =?utf-8?B?c1lQVDZaazlHRWRVeUIvOVp5amNGdjhHVVo4K00yZmF5bGRmeElWUmdTNnM1?=
 =?utf-8?B?NnBuWmhDZXRtTnZ5eTdrNzRub1YycEwyUWV5bUt4VlNtWnZjclJMSEp1VDBP?=
 =?utf-8?B?Q3MvUXptcWxCc1ZPMnpXQ2ttRkZHWGxnNEpJTVBwd0lhd1VVdEUxYWwrd2RP?=
 =?utf-8?B?M0VSQ0VNMDhRall1UW5XWkNRVEl0SE50b09mTjdmSjNHNUZ0M0MzM0dRWUZT?=
 =?utf-8?B?c3lOOG9tblFTNXptUWY5aDRXRk83bFpRVVhvYkZxMEVSVWtzQ3BmOGJNRW9Z?=
 =?utf-8?B?YWVZUURabFRMczFndWsrbzdrWjFzcFVNQlIyQXpmRU1kWlZscStmODlMbUdj?=
 =?utf-8?B?VlF6elZWL1dJdHhldWtPR1V4U0RCODd4UWxUU3llS3dWeDJIQnZUVURvTFJa?=
 =?utf-8?B?d3hXTUw2WDVMck9ObGFzdGJVOERucTlQN0FvK3YwMGNGWDNhUE00UGhKaDVJ?=
 =?utf-8?B?ZnF3ZWduaXNsWmFvVFhxYXZsczJiKzRsVFNVenRweHV4OUxLRGs1TUpjQ0pZ?=
 =?utf-8?B?eTBsa1RaS0pLTENjUHN5TEtuZU5NNFRmMGRUcko5ZXFtSE41cmFiNmRCSVZ4?=
 =?utf-8?B?YWh6ZUQxeTN6N2tnRUJJenE0R205YTQ3VXNaQ2tMdTJoSkJPMkpKNTNwSnNN?=
 =?utf-8?B?VEx0cDF1NytUdXMwYlJtVUhQVFFCa0gwY3FJZTduVnZaZXk4aXpkK2FDS3I1?=
 =?utf-8?B?R0dpSG95UytmTTFQVUFBWmgyN282UnRJT3U5b1BhKzNxeXVJMHpWUld1T0NE?=
 =?utf-8?B?MERzOGhWTjRXSnF2MExpN3pCK0g2cE53RERQKzhENlVPSEFpUS9BMzdIbTBL?=
 =?utf-8?B?QWlnRC9XQkNqSFRBMjFMQURzTEw1dXpsMCt3YnVhNk93aDUrRTJRU3k2VWYz?=
 =?utf-8?B?WTZUS3RrOGtWa2F5SWZ1T2NvZjNQTW1uK2Zad2tZN3VwRVBhVFAzNSt2Kzl6?=
 =?utf-8?B?U25QZWpuNlM3RGVyWEdUS1k2dVJ2RzRjb1FwV0ZPeTRHK3NJMmpUVXNKc1h1?=
 =?utf-8?B?OWRRVDJ5MUFoRURHN0RPbWV1R3V3dXpPS0hKNWpsQjVUa0NMbnFzRG1lbWR0?=
 =?utf-8?B?TVpweHNPUmVwYVFvUndGUnpxcEhDK3UzejlZaC9wcnJLcXhFcTNodXdENnJL?=
 =?utf-8?B?cGVieFcwaWl1MVdMbjk5aUxvNVo0SndEWTZVNTlxVDRZZFFCWThGTGpFSnJL?=
 =?utf-8?B?NEU2Ui9ZdVpvK25penFJdEZTVXRhSUVhVndZTDdIbXhkeEtmMGZlaE1yWE5B?=
 =?utf-8?B?ZUJyZ2RBQXVZanpYL1J1cUtQc25vZ1hONWV1MTBFanRUU3h1OE85ekJLZGZT?=
 =?utf-8?B?RjhYSm8renNSS0VlSld5ajVXS3FzYnRvQXRCOUpkM2VPMVNVMm9veWoyYktW?=
 =?utf-8?B?ZjNnTjN3RDVYazN5NjUxMEE4RC9HcDF3aThrQWVMcW9vdFhYWnpDNzB2aWZ1?=
 =?utf-8?B?UUxQMzdmWCtSK21LRDZaVkswaEloV2Z1QjVHdjcyUzlkQzRSQys2L2daWFAw?=
 =?utf-8?B?SDYwZjRLam1INHVKVHFOUEpJc2tNcXF3TnYxRjNnME9iQ2dubk9iZnBTNGNL?=
 =?utf-8?B?elE9PQ==?=
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6388.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cf2b399-e5fe-4d7d-8a7e-08dc90c768a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2024 01:22:10.8098 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0oKD9/erwvGGe7PJwCQA1WI9MzU7tLqrwekNUpU96zxtQR7DlpNleQdHraqUyxtp/dyh1r0vJ6GHcdUqulWeH2OwLp8LP5WEI0yGU3zURh1aRwunsbgxC1S3t4m3dqkl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB12351
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
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
Cc: linux-arm-kernel@lists.infradead.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

Thanks for your comment.

> > > > $ ./testcases/kernel/syscalls/accept/accept03
> > > > tst_test.c:1733: TINFO: LTP version: 20240524
> > > > tst_test.c:1617: TINFO: Timeout per run is 0h 00m 30s
> > > > accept03.c:58: TPASS: accept() on file : ENOTSOCK (88)
> > > > accept03.c:58: TPASS: accept() on O_PATH file : EBADF (9)
> > > > accept03.c:58: TPASS: accept() on directory : ENOTSOCK (88)
> > > > accept03.c:58: TPASS: accept() on /dev/zero : ENOTSOCK (88)
> > > > accept03.c:58: TPASS: accept() on /proc/self/maps : ENOTSOCK (88)
> > > > accept03.c:58: TPASS: accept() on pipe read end : ENOTSOCK (88)
> > > > accept03.c:58: TPASS: accept() on pipe write end : ENOTSOCK (88)
> > > > accept03.c:58: TPASS: accept() on epoll : ENOTSOCK (88)
> > > > accept03.c:58: TPASS: accept() on eventfd : ENOTSOCK (88)
> > > > accept03.c:58: TPASS: accept() on signalfd : ENOTSOCK (88)
> > > > accept03.c:58: TPASS: accept() on timerfd : ENOTSOCK (88)
> > > > accept03.c:58: TPASS: accept() on pidfd : ENOTSOCK (88)
> > > > tst_fd.c:151: TCONF: Skipping fanotify: ENOSYS (38)
> > > > accept03.c:58: TPASS: accept() on inotify : ENOTSOCK (88)
> > > > tst_fd.c:170: TCONF: Skipping userfaultfd: ENOSYS (38)
> > > > accept03.c:58: TPASS: accept() on perf event : ENOTSOCK (88)
> > > > accept03.c:58: TPASS: accept() on io uring : ENOTSOCK (88)
> > > > accept03.c:58: TPASS: accept() on bpf map : ENOTSOCK (88)
> > > > accept03.c:58: TPASS: accept() on fsopen : ENOTSOCK (88)
> > > > accept03.c:58: TPASS: accept() on fspick : ENOTSOCK (88)
> > > > accept03.c:58: TPASS: accept() on open_tree : EBADF (9)
> > > > accept03.c:58: TPASS: accept() on memfd : ENOTSOCK (88)
> > > > tst_test.c:1677: TBROK: Test killed by SIGILL!
> 
> > > This looks like a bug either in kernel or libc.
> 
> > This is caused by __NR_memfd_secure being defined as -1 (0xffffffff)and
> "Illegal instruction"
> > occurs when syscall() is executed. And this problem does not occur on
> x86_64.
> > I cannot decide if this is a bug or not. I can't decide if this is a
> > bug or not, because this behavior has existed for a long time.
> 
> Interesting. But it'd be good to discuss it, right? In case there is something to
> improve. Cc linux-arm-kernel ML.

Indeed, Thank you.

> 
> > > > Summary:
> > > > passed   20
> > > > failed   0
> > > > broken   1
> > > > skipped  2
> > > > warnings 0
> > > > ```
> 
> > > > Closed: #1145
> > > > Signed-off-by: Nobuhiro Iwamatsu
> > > > <nobuhiro1.iwamatsu@toshiba.co.jp>
> > > > ---
> > > >  lib/tst_fd.c | 8 ++++++++
> > > >  1 file changed, 8 insertions(+)
> 
> > > > diff --git a/lib/tst_fd.c b/lib/tst_fd.c index
> > > > 6538a098c..53f583fa0
> > > > 100644
> > > > --- a/lib/tst_fd.c
> > > > +++ b/lib/tst_fd.c
> > > > @@ -255,8 +255,16 @@ static void open_memfd(struct tst_fd *fd)
> 
> > > >  static void open_memfd_secret(struct tst_fd *fd)  {
> > > > +	if ((tst_kvercmp(5, 14, 0)) < 0) {
> > > > +		tst_res(TINFO, "accept() on %s: Linux kernel version
> is before
> > > than v5.14", tst_fd_desc(fd));
> 
> 
> > > > +		errno = ENOSYS;
> > > > +		goto skip;
> > > > +	}
> > > > +
> > > >  	fd->fd = syscall(__NR_memfd_secret, 0);
> > > > +
> > > >  	if (fd->fd < 0) {
> > > > +skip:
> > > >  		tst_res(TCONF | TERRNO,
> > > >  			"Skipping %s", tst_fd_desc(fd));
> > > >  	}
> 
> > > And this looks like you are working around the bug.
> 
> > Your point is correct...
> > I would suggest using tst_syscall() to check for syscall undefined
> > instead
> 
> Well, I guess we don't want to use tst_syscall() otherwise it would call tst_brk().
> I proposed similar patch some time ago [1], I suppose you told me privately
> exactly this.
> 
> [1]
> https://patchwork.ozlabs.org/project/ltp/patch/20240124142108.303782-1-p
> vorel@suse.cz/]

I see, I understand.

> 
> > of this modification. How about this modification?
> 
> > ```
> > --- a/lib/tst_fd.c
> > +++ b/lib/tst_fd.c
> > @@ -255,7 +255,8 @@ static void open_memfd(struct tst_fd *fd)
> 
> >  static void open_memfd_secret(struct tst_fd *fd)  {
> > -       fd->fd = syscall(__NR_memfd_secret, 0);
> > +       fd->fd = tst_syscall(__NR_memfd_secret, 0);
> >         if (fd->fd < 0) {
> >                 tst_res(TCONF | TERRNO,
> >                         "Skipping %s", tst_fd_desc(fd));
> 
> 
> Therefore how about this?
> 
> 	if ((tst_kvercmp(5, 14, 0)) < 0) {
> 		tst_res(TCONF, "accept() on %s: skipping due old kernel",
> tst_fd_desc(fd));
> 		return;
> 	}
> 

I did not explain well enough.
The memfd_secret syscall itself is supported in 5.14, but is implemented on i386, x86_64, s390, and s390x with latest kernel.
Other architectures are not supported. The above patch causes the same problem with the latest kernel.
So, I create with the following patch based on your comments. How about this?

--- a/lib/tst_fd.c
+++ b/lib/tst_fd.c
@@ -255,11 +255,20 @@ static void open_memfd(struct tst_fd *fd)

 static void open_memfd_secret(struct tst_fd *fd)
 {
+#if defined(__i386__) || defined(__x86_64__) || defined(__s390__) || defined(__s390x__)
+       if ((tst_kvercmp(5, 14, 0)) < 0) {
+               tst_res(TCONF, "%s: skipping due old kernel", tst_fd_desc(fd));
+               return;
+       }
+
        fd->fd = syscall(__NR_memfd_secret, 0);
        if (fd->fd < 0) {
                tst_res(TCONF | TERRNO,
                        "Skipping %s", tst_fd_desc(fd));
        }
+#else
+       tst_res(TCONF, "%s not supported on this architecture", tst_fd_desc(fd));
+#endif
 }

 static struct tst_fd_desc fd_desc[] = {
@@ -287,7 +296,7 @@ static struct tst_fd_desc fd_desc[] = {
        [TST_FD_FSPICK] = {.open_fd = open_fspick, .desc = "fspick"},
        [TST_FD_OPEN_TREE] = {.open_fd = open_open_tree, .desc = "open_tree"},
        [TST_FD_MEMFD] = {.open_fd = open_memfd, .desc = "memfd"},
-       [TST_FD_MEMFD_SECRET] = {.open_fd = open_memfd_secret, .desc = "memfd secret"},
+       [TST_FD_MEMFD_SECRET] = {.open_fd = open_memfd_secret, .desc = "memfd_secret"},

Best regards,
  Nobuhiro

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
