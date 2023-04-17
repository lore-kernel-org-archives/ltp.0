Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7711BC77B72
	for <ltp@archiver.kernel.org>; Mon, 17 Apr 2023 08:16:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 231953CC161
	for <ltp@archiver.kernel.org>; Mon, 17 Apr 2023 10:16:53 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 69FB93CB3FF
 for <ltp@lists.linux.it>; Mon, 17 Apr 2023 10:16:41 +0200 (CEST)
Received: from esa2.fujitsucc.c3s2.iphmx.com (esa2.fujitsucc.c3s2.iphmx.com
 [68.232.152.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 8BD71600684
 for <ltp@lists.linux.it>; Mon, 17 Apr 2023 10:16:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1681719401; x=1713255401;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=W8TR9KZYvl5028cwdJr3Vx9JBA1JURJRY0bEDxjwj0U=;
 b=NJBGUdnt75x5JG4d/MvuZhuow4Y8MZelAu7qG3WQinbZU501ZSogrpi6
 JGBJZWdlwruJvmX7vO88ui29C3IHQ0vccnfpSCNSG2tNYP13QUChbAwpr
 Bo+B2cD6LIIwopqnfAK85UG6/GtflhhkXgHe42QBOAxRsnx/wK2qU3ISf
 xnq2sEUtdCmN/yp1QVgYZGM7QQMqRsXf4aKllw7wpYhVqzWyt4VoULhru
 9mBFVLhUjaW/6P4KS01FtiljNC/hcRmTBaUHJfdmlGqeXD2zo/DoLvNxz
 IpBuleLovcxp3c+2S5YRM+YJE6kOssi7wpT8Pj1radw4gFhr6x1VqNgfe w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="90451384"
X-IronPort-AV: E=Sophos;i="5.99,203,1677510000"; d="scan'208";a="90451384"
Received: from mail-tycjpn01lp2170.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.170])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Apr 2023 17:16:39 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mAh+L+dCERJz3F35nFC5j4X5vL/vWUgYmIMAPmIpy2RZGjmv9SJOGXb5CU8hGuCnFJqb52e/uj+5TOSEZRRDj3mdns6tZIP6eeffbnYcqBGVnxIyw9XPLz5B0+BkmJsS//Q4R4V2BvwTvMm81uPQhxjRj8R+6CK+GG/XTR9sKLIoecGbwAESJ9DiZHYcerfD578vJjIeMaRNJlyUJ+8dk+MnoTWsuavwLbx4S8/2kzyqWBE+7QwAyHqI4vsxONM819t0whBpzLQpsZQ6WW0E8sfloMiN5L8utfTtsDVJQyF+LsKH8iPdSZEXLMFRWkauoMXiPDnpOC6kk5yKr05Myw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W8TR9KZYvl5028cwdJr3Vx9JBA1JURJRY0bEDxjwj0U=;
 b=SousVsoHzzRmR3pZu6v4h8rBy5YqlCBceQUsQi2PsHWoVLPR04FEawsGB9ZUim/j56JcSXM0Sj2FNgU9sA/dvxqd2ifgsTctzVCe7p+7BB05zYuuPJvDOtEUvu+aRbv3fzmHnPPKXPBHnKKqv8KNx+2J5xd9x5lTw6RUGWNEdP0OWsRku2h4VJcNtqJuUuPKqGnIhgrwuXytEbw1vSuPj82bxUNk2mGR47JRQFmp21SS1XQVWHc/6JEG4wjMBQ5XjCcJTcJ+TQCtdScSFIRfwhE3rt/AnwE3npiTLgMWVq3Dxxk6dWcwAVXjkH9+WrjpwwNoevj1gzaD4b/fdZJgxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB10725.jpnprd01.prod.outlook.com (2603:1096:400:2a5::7)
 by TYBPR01MB5422.jpnprd01.prod.outlook.com (2603:1096:404:802a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Mon, 17 Apr
 2023 08:16:36 +0000
Received: from TYWPR01MB10725.jpnprd01.prod.outlook.com
 ([fe80::1eae:326d:abf5:e4e1]) by TYWPR01MB10725.jpnprd01.prod.outlook.com
 ([fe80::1eae:326d:abf5:e4e1%5]) with mapi id 15.20.6298.045; Mon, 17 Apr 2023
 08:16:36 +0000
From: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
To: Li Wang <liwang@redhat.com>
Thread-Topic: [LTP] [PATCH 4/4] ipc/semget05: Convert into new api
Thread-Index: AQHZWvWcTmNnUGgH/0O8zGM0wwd/Sq8pI8MAgAFJRICABIikgIAAWXYAgAAEzAA=
Date: Mon, 17 Apr 2023 08:16:35 +0000
Message-ID: <81c43832-a258-40d8-ea52-f4c097ef712e@fujitsu.com>
References: <1679293822-19378-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1679293822-19378-4-git-send-email-xuyang2018.jy@fujitsu.com>
 <CAEemH2eTxhuQ+5YGMVbQwf9ZY1ttOHZxCySux-s0sDjXvhC4zw@mail.gmail.com>
 <c35fc5da-d420-7cb2-88a9-6327b46ed738@fujitsu.com>
 <9ff1f71c-9f21-e7ad-bfb7-c552306892d1@fujitsu.com>
 <CAEemH2fN=JANooAt6u5wHJxZDDM5KpHDvQWcDHh90neP8odT=g@mail.gmail.com>
In-Reply-To: <CAEemH2fN=JANooAt6u5wHJxZDDM5KpHDvQWcDHh90neP8odT=g@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB10725:EE_|TYBPR01MB5422:EE_
x-ms-office365-filtering-correlation-id: de2b563b-3ba3-4ddc-2e61-08db3f1c0fd3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U/npdBkwKShpee81NNNmF84y20QsbwS7MW1tbsVIKmEp005XxAH5GnhgjtldVWmnJn7FnI3ouV5ErWFCZhpUXCXlKngGUmFO1Z5I3/1WDSbNQ8Tc98baovszKgfhIgH92umFKPGBvOMuBGEiCgIz7//DDfjgnhQOFapLwcB+r2envGBuEsridFuhPKCKL8kJ/b99BuEsqYy6LaN0aAbNeYfADWZSgZyNdn/2RX1v+j5HAGHxEzsnKwxrfmWlWxC2SNImGTOLvk0dpukc4CNHMQrai5gNXiniSdyOAe9kj7hWZYBZgfi3segdjapEeW258yGDrUlw0kNj7LcXyjHVq3zf2FOCQneeSbSlSNCpkbTbHZjZUyU0Ps4kSSlmVcSOsqYqnXHk1n9SUQkLT+w5CD3PNoS0PwQqN2akVia9bCI14AgJNk1fdIRoXZws/tE/yIPiVsb4GOZA1+ujYyH4KYsZmEdBxbR8iEiwVm0K9dqB/2bsk4dgP79xFH2KHJmJL8ug0i/WXZKGfwzi1pUvtcydEPlhlkzmKSezObbN4gwu/nBbBpXWToc7+NtGI3/RUquchefWAUszkrZMZgU16EmQhGF7up7fSktX4D2EujBEi2+Egt0/I4bJPrAZhqqOtVloqqXodffDO9bfQ1o0kcEtQG2XpMG4nId2VpF8EJ+FpEK2dbUAcD4s5Vj7adIQ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYWPR01MB10725.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(39860400002)(366004)(451199021)(1590799018)(5660300002)(2616005)(86362001)(31696002)(53546011)(186003)(26005)(6506007)(6512007)(122000001)(82960400001)(38100700002)(38070700005)(8676002)(8936002)(478600001)(71200400001)(6486002)(316002)(41300700001)(85182001)(91956017)(76116006)(36756003)(64756008)(66446008)(66476007)(66556008)(4326008)(6916009)(66946007)(31686004)(1580799015)(2906002)(4744005)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aDRwNmQxRm1PcWNFMHhQY1BXUTg4NHNJemFYMjJRbFRaemFNN2E4UWF3bXlJ?=
 =?utf-8?B?UHorUmhWdjZwc3hFd2pTR3JKYTRjREozTytFdnZvR0RiRmtwdHVXY2t0U3Jj?=
 =?utf-8?B?U0g3eUloVmxiUUNrcEFPODJ5bW5FSHNvbkxKZDlUY29VSEkxREhGYWtnSktT?=
 =?utf-8?B?elhlRHdMN1NOMjZtdGRnOU1vUWl0M0lQenltQjlvTmtkMWVHajBpb1p6enpN?=
 =?utf-8?B?cTlPemRxSlF0N2FjNGVidzZuMmoxRm1ZYnlESkhxREZ6d1VwYzZmSXMrVSt2?=
 =?utf-8?B?OTJyaVdkN0JFWUowOHVPZ1g1YTZaQkQ2UmR0bklUOEJIaGZUMTA4N1hmRTJE?=
 =?utf-8?B?TjczRUtlcEdPSTBFN0RUVGxxVmxEMFJRWXJYVGFmTTRwbjFQckxEQ0NtbVNZ?=
 =?utf-8?B?N2NpNG8zeVdKcTI5TDdrcGgvUDJNc1B1MlNyMC9Vbk9ONXRKV011SEV1Ykpm?=
 =?utf-8?B?NTh2N3NKRyt1Rm1zOFJ3WVNEa2tUM2JvZGdsQUZQeDlHMzROSTdoVGZmWWhD?=
 =?utf-8?B?ZUlTbGVMdCt2T2M5dUxIS1g0YVlXUTZGY1BLN0JHMjBmbnNtUko2ajdZbFFa?=
 =?utf-8?B?cFg0UTl6RjVuWHcxYXFWczdQdDZOVFM1bVFqYzZvRFFEUTBBSW5oYkVuM2po?=
 =?utf-8?B?UUlKN1FSekVxMDZIR0QxTHhldjk5Z3ZZc0xQbHFXamkvdVdWdFFkRFp4MzFW?=
 =?utf-8?B?ZUg4SkhSQm9QbHVqWlVzVnVydFFEYWJDME11Q2ZBM0dJNjRRMktRQ01teWI0?=
 =?utf-8?B?WTM4bUs1L0xRMk5yYlJ1K2t0aFJHUmhMN0dBZXdudFdCa0x5a0lyNUF3eDJ6?=
 =?utf-8?B?MGFrc0tTeXh0SGE2OXJaUTZHazdZS2xkcWI5TTZiWHRtVi8yc3N1bVQwc1RV?=
 =?utf-8?B?TVZjalpiTi8vYVdNQ3BSRVJqYXVhQ1U3eGs3MlorY3VRZWhOOHg2aXI5MzA0?=
 =?utf-8?B?V2hVWmMweXdmRmdtSnBtWEtSVXdlQ2pHbjMybnh1b0I1UkFyQUwyUXJBVmhu?=
 =?utf-8?B?TUZaUzc2NzBkQTFEN0VvNEVlemRpc0ZOWU5MMDQyWFpQdXNOQmVtK1hXS3pI?=
 =?utf-8?B?TWcveGJad3pHREx3WXc5NUZSeWxYZ2xCbzlWY2RPSklTQjJ0UEsxZkJjWXlR?=
 =?utf-8?B?bFNvQWZtM1NrUEYxWThETUVkdGI0S0NxSnU1c0tISVBTTzA5Vnh4UkJQb3l3?=
 =?utf-8?B?cGxHbDVvN0JMbEdIN3dxdzdpWkZYdmhlZVVhOVhmR05yZXdxSDNsRkZFVytC?=
 =?utf-8?B?UVIxOUhXcTFDemRYMExpdzhXVnJSM2dBSlUrUjNKcTE0NHFodFNQSm1TTDJP?=
 =?utf-8?B?THhyU24zcFpqdGE0T2NaTVVTU1hRRDlmUVdEREJJWnluVmFOZm5rWk9kWFpR?=
 =?utf-8?B?b1llcHlJZ0piRmlvOXhMS3BIZDhSeDU2NXVzMDNZU0NZcjFyakJMWXl1ZWxm?=
 =?utf-8?B?dXJuQWdOcWo5MjJ1dUx2MkRtWk8wQjBGWTZiYXdiQkdDbUlWanFiZTBYTHVT?=
 =?utf-8?B?YmpqNFN3eldIbVRmVzRTbkM1dCtVa2w2ZHpvOFJ0ZGdFQ0tsTFFPZWtGREFP?=
 =?utf-8?B?bzhKSEZvYTdSand4U1YrYVNDOFY5dzhSS3g1Q2lGVXp2NUlrem5RdzEvRVBx?=
 =?utf-8?B?S1ZDNk9xNEkvMU9qSG1aK3RFaU1mMTByTXJld3FmK0ttKzlyVUtVVW5aSzl2?=
 =?utf-8?B?YnpnVHdjNE1sM3lEOFpna1BVWVQvNmVqTUpLYUh2blF1OEZ3ZndRdXVhczdP?=
 =?utf-8?B?Z05pNithRUVma1doV0wzZnFsMFlaKzJITVN1bUswQnVHbFAvajk0cy9sSko2?=
 =?utf-8?B?bTZuSGV5bTY0UVEyemZXUXVOZ2JSODl6Z0Q0QVhFSktPdGoyYVUzc21yd0pI?=
 =?utf-8?B?eXJIRERBanVtSk9LNlFKUVVDZWNIdXU0MDJ5T3VxYUVOTW4vM1BMblVKZDJN?=
 =?utf-8?B?dmw5WFVvYXhGL1M0OHFseTZJNVRIREFCdS9VVmNxWVIzdERldmhuRnlQaXlS?=
 =?utf-8?B?NWJ1YW1IRWFLdDA5ZWw4eitBNnprUEJsSDc3WkhkVUJqeXd1Vy92M3p6ZUQ5?=
 =?utf-8?B?Vm51TEwxS2hnWW9sb0ZYRlc3a0ZtYm41anlTMExiRUlBZUx3NVpLUU15UFRU?=
 =?utf-8?B?N1JTam8ybWFpMWYrdkVXT0xSeXpkMjRKZzQzRlFUWStaM1lrcGJYL2kxSW1t?=
 =?utf-8?B?cFE9PQ==?=
Content-ID: <8CB729FC57274B42A084369553042C1B@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: GeRl58oFZ9cYSeTnycqlgVyS0vF9+PgtRug6zDV0KSpV84D/qM6lR6CIlPfFpgtRTuqoOPLHhYFWM0RNeIZWCEjG17ZxCSBvHwKMJEnn7wi83565MTXDDphADroPKGc3FWLnwFB2BtAZSSWXSFrYIrJz2SQnug2MXroy1kzlstItbtra9oWnshnp9zfLKlfjbuBhJk0QSVZdgYWDGonMaQ1zY7OYrS+3xYIpS4pwi5d3yVKcpdMtzpFSu5vfLXB+pkgyRg4LFiVg6DcQF4YiIz7Qyw4n8N8X6W51JG5gpB2nCJbxGhLMT8iOp+vWIB478c+ygn3vvBIXIG8UaiOvaGb2ki/1UP9uFm6TIn8BZC8hujDUwBm78EBF6StU0Ebu4ZZGEytWRebmPEhnZFUZEBTaBL8ZCtbx2Nvtkbed2rDZ3Xn8ReQyZCKHYFAPCq4mxMIu3sPUrMOkznoKXl3FiGHaktCz3ZGjuXw5bgApHQu5Cmu74pDhEUUyUc3+UciPo5P04tiyqVlPBcUje6TwG1sT/SJ3swMqtvAqb1h11ibEB3/lHUqxHsETYbXt32B4n9SE48vlGA3Jrh/sZ+7vCZMu5QAoZCUwJbdLfWnO+Q39FJBjg3qPol9GcsnO4TE1AXzmernyrWRmhiRF/rw7P2lLRrj0U0VZU1RV04NC2J0Q+hp/N06uf7Igt4+tigfwl6gwjIe/chVTjpAZp0SBWpPqea6oCDkKSs/3Xxnl8USAmNVPlJwC3U0MtODKnCURSnJwx5EtXjkERWVYVC97n6kUuGUG/zzon8LeB6LWKY4=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB10725.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de2b563b-3ba3-4ddc-2e61-08db3f1c0fd3
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2023 08:16:35.9218 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CrwJitX6Kbyb6sAHCmwJVuCw2vg7I5MgNJRtwfa6i5AyIu7gl4tKYN/tq2cCx8zVzZZB9fs0Lc5eLjVrlwfa737bfUloWyMZoix7ZV06mVo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYBPR01MB5422
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 4/4] ipc/semget05: Convert into new api
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SEkgTGkNCg0KPiANCj4gDQo+IE9uIE1vbiwgQXByIDE3LCAyMDIzIGF0IDEwOjQw4oCvQU0gWWFu
ZyBYdSAoRnVqaXRzdSkgDQo+IDx4dXlhbmcyMDE4Lmp5QGZ1aml0c3UuY29tIDxtYWlsdG86eHV5
YW5nMjAxOC5qeUBmdWppdHN1LmNvbT4+IHdyb3RlOg0KPiANCj4gICAgIEhJIExpDQo+IA0KPiAg
ICAgSSBtZXJnZWQgdGhpcyBwYXRjaCBpbnRvIG15IG93biBsdHAgZm9yaywgc28geW91IGNhbiBy
ZXZpZXcgdGhpcyBwYXRjaA0KPiAgICAgb24gbXkgbHRwIGZvcmsuDQo+IA0KPiANCj4gWWVzLCB0
aGUgcGF0Y2ggbG9va3MgZ29vZCwgZmVlbCBmcmVlIGFkZCBteSByZXZpZXdkLWJ5IGFuZCBwdXNo
Lg0KPiANCj4gUmV2aWV3ZWQtYnk6IExpIFdhbmcgPGxpd2FuZ0ByZWRoYXQuY29tIDxtYWlsdG86
bGl3YW5nQHJlZGhhdC5jb20+Pg0KDQpUaGFua3MsIG1lcmdlZCENCg0KQmVzdCBSZWdhcmRzDQpZ
YW5nIFh1DQo+IA0KPiANCj4gLS0gDQo+IFJlZ2FyZHMsDQo+IExpIFdhbmcKCi0tIApNYWlsaW5n
IGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
