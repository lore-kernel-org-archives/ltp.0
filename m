Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DDE4C7618D
	for <ltp@archiver.kernel.org>; Thu,  6 Apr 2023 05:36:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A44B63CC74F
	for <ltp@archiver.kernel.org>; Thu,  6 Apr 2023 07:36:27 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2124A3C00D1
 for <ltp@lists.linux.it>; Thu,  6 Apr 2023 07:36:15 +0200 (CEST)
Received: from esa20.fujitsucc.c3s2.iphmx.com (esa20.fujitsucc.c3s2.iphmx.com
 [216.71.158.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 2B82B1000A43
 for <ltp@lists.linux.it>; Thu,  6 Apr 2023 07:36:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1680759375; x=1712295375;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=Z7UUM1ARzDbnEPmv7NneARg1AwbMVriVFZ3pf49zFsI=;
 b=kDRt0saBFYWiN+T1qzNhwZq2nX1DIi3UwtPhcu4xk87AS1wNbKdc542Y
 i1D101WTwXnjjOiGUMvOMNi0NFNnpWDVyaQwyqY8AFmaaVktTps4zmftf
 YoqCS9iwSMYi1rJQJMHBzpNUPaWwpG4VdhDzYFN42jau/iDUsYxU2Q1OZ
 IVx0Rn7Lk2xLRJ81ULOO531vQKQwMtz13JT4CG2XO6gNOGSyxteYkax72
 Wmbqm8giIim3QAJ3nt0ur3iSEoG/iRvQuy7dJtxav4+6rNFHscmMwJQJe
 vlYcpkytD9ZpyzudJ6mQtR4HgETTEG4TUBqTIyIPHVkv5xmNwYExxDyZX Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="81175702"
X-IronPort-AV: E=Sophos;i="5.98,322,1673881200"; d="scan'208";a="81175702"
Received: from mail-tycjpn01lp2172.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.172])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Apr 2023 14:36:13 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eFEXPcJ1zh0/pYPrVCPVVKni8ol3nhiNBYIOgJGfapHUxKGD3OzADKPs1crYMnFySMASc3rxjIMWjbyB9JcumBQ9GlIwtIggnBXh9lw8u9syRKp3s/bU/YTc8neGKOOzNYNRdizv2IjRZCMN218Ip+xw9TvB9ejYlhrHVjLWJR4S/Ktf1nhPjxnhsj28jLY578I8JNQi2WvPuCsb+L/2gLkj+YfPbTZ6cdk+8rtS2XKqQE2IU+eIJ5tf/tplv3jORLyq1nvD02nsOXwRZeXd11Cmvq9foDQ5elXqCNLrkqMUk8N5tVkoi/Gu9B8pxZgpMSkAk6T7pstqP44sf6Zj3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z7UUM1ARzDbnEPmv7NneARg1AwbMVriVFZ3pf49zFsI=;
 b=IVWFWByKWOH++SOBGJEvuKfIPW08ggmSLug1GzaTNzDiLPi6qG252ANmRkECApg9voZZKvOWXr++SKIbCG4qJhBmSJ6OqlLdEoFwZqQx3nEhvbM0Q+f1DBg0FGbOC4wtWgg7M7le64B4iAzPbtMW3z9hdl27i+52393t6QvwE/UzURBiWqnwKv142ovrOmKr9tYd07gfCB9OToNJ1NZg3v0cCeb6vfR9zvfKmbfau6zHchZfKneOZGUL/5HpLcrb7g62Lveptguk5AOSnL6Qe5axgdMB/5KQb1iqSr0H5bN9TngrX4RGTqMPxce3FE+6qy0IpK0jRUavOVy6HmbJgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB8313.jpnprd01.prod.outlook.com (2603:1096:400:166::9)
 by OS7PR01MB12009.jpnprd01.prod.outlook.com (2603:1096:604:23f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Thu, 6 Apr
 2023 05:36:09 +0000
Received: from TYWPR01MB8313.jpnprd01.prod.outlook.com
 ([fe80::b09b:8bce:a0d9:d3dd]) by TYWPR01MB8313.jpnprd01.prod.outlook.com
 ([fe80::b09b:8bce:a0d9:d3dd%5]) with mapi id 15.20.6254.035; Thu, 6 Apr 2023
 05:36:09 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Eric Biggers <ebiggers@kernel.org>
Thread-Topic: [LTP] [PATCH v3 3/4] syscalls/statx11: Add basic test for
 STATX_DIOALIGN on block device
Thread-Index: AQHZZsd03dWC9gsqmUGo2s8XSTtCb68bs9kAgAIHOoCAAAq9gA==
Date: Thu, 6 Apr 2023 05:36:09 +0000
Message-ID: <35812be0-b96c-103c-1ff4-ae96432fface@fujitsu.com>
References: <ZCsHKmFrUdBw3xEw@gmail.com>
 <1680593430-14728-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1680593430-14728-3-git-send-email-xuyang2018.jy@fujitsu.com>
 <20230404215918.GA1893@sol.localdomain>
 <100fb209-5cd8-2c92-b82f-8a241d4dcb61@fujitsu.com>
In-Reply-To: <100fb209-5cd8-2c92-b82f-8a241d4dcb61@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8313:EE_|OS7PR01MB12009:EE_
x-ms-office365-filtering-correlation-id: cb1b4c9a-6c51-4cda-527c-08db3660d391
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qXmJSqSC0POZh4ldFnnM6uLihXubWPuBe8+Iyf6jruIxMGoH12bgT7W4iD1CiSZpJAYfNpDqaTbAfU96HZUtzyhXLQH6cbAiieML8OM17NNs3Bw/p2gi93A65ELGVkmwy9thmWngmQCcj7jViw3/uIHPJzirh8x0S7bcq+wblOUAJ7RAa3cWhLRa3eDlDSx8qPz8MQYqD59HWJkyP1BJFNKplNR0GYSkve+aaPHL42G3ybiQk3Ih1GBdUCYLptZCMj6zQi/l9VNjYML/hCWXGTgUsP6b2gW9bFS4Rq/oGjEXxK9pl5Q14NigyJEO0tz2QDgsHIQKelftksV3+z216cXdHNSTpAWpqSo4ZbygXxSToNVnIupE9W+pxO3gf4ede8DyLc1kCdcaJMQjIWKt/9NbbRD0A9ul9PAOE3IYxN10tDBZZH3Byz9jwhmcWKsrS9hf9YmNJ5gtpwkGj4qRF+b53/vHT1yR8AMImCyHcrcU7jyE7ZzrmV6ckwSrMEkcT0LDuu5udniC3GEXG5lC6rEsvrT0sBwoVO2+5pDhaYE0EIHv/YfG6sjdNAaVT0Vt4M98NYEZfJTNkeGgQM14e8mNKrKKGwJvmM9U4ZqOMBToA1Tk98k0rHbq7s6WzApebIbxzy1VDIcjklPR2auAHG8SWed+xlvv4YBnAvUygJsy7fC5It5QQJdzLvk2wqIE
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYWPR01MB8313.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(136003)(366004)(39860400002)(396003)(451199021)(1590799018)(478600001)(5660300002)(26005)(8936002)(1580799015)(2616005)(6506007)(6512007)(6486002)(186003)(4326008)(71200400001)(82960400001)(31696002)(8676002)(6916009)(85182001)(122000001)(41300700001)(31686004)(38070700005)(36756003)(86362001)(91956017)(66946007)(76116006)(83380400001)(64756008)(66556008)(66446008)(66476007)(316002)(38100700002)(2906002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bmlHc2U3TkFENkVxL29sVEVwVkZ3MFQ5cFhkWXUyOEEwZFVhZ0krWkRDbGdR?=
 =?utf-8?B?NVNJRVZkNFNzOUhRTWExNWZzMktEUDk4NzZKODdCZTR3Snh1WGFXSDFEMlRx?=
 =?utf-8?B?MXFlTC9RMnRSZmlta0Z1L3VHeGUvcDFITUY2Zk5seTFNdTNHdXppdzlkd21C?=
 =?utf-8?B?SjhnWHg3ZitXOWk5U25PKzA0alhkRUpCOUo0OU8zcnZEWi9zTEozcDdza2ZN?=
 =?utf-8?B?VUVZd09CMjkxNFR5RnFyamZwU2Z1K0g1dWladU90UElaQnhUNkFyMVRNQnFj?=
 =?utf-8?B?YmVhcm10b2lGSm1kajJxYy9vSWk4OHlQMVEwQW5lbmNSeG9MREk2eWtpMTR6?=
 =?utf-8?B?VHZPMlFvWC9ld0J1UXhRM3dZUUtQd09UVTl4RmdjeTdoaDlIaGxHRVB6Tlpx?=
 =?utf-8?B?czZuR01BSVVVQ2xWMGNEZ2FPLzVWOGYzWFBxNmh6aStmbWxESis0RHQzT3Zq?=
 =?utf-8?B?REVPMkF1YTNHYVQ4ZlcrbXZTbUYycjZVWlZheVM2cmlQYmRGa1ZEcmgyaE5U?=
 =?utf-8?B?T0ZaVVYvZzFBOUwyZGkrN01vYU1OeTlnRC9Db3lpU21KVTYwUmtSOUI0WDZy?=
 =?utf-8?B?WDJXbE5STHVrRURzUjZaTm9JZktMQ0EwZWw2cGRVSVBIMHZ4ZnA5d3VIYWRs?=
 =?utf-8?B?OFBnUit6ZDkrNUwzZG1ucHV1K2lzSHN6WVlaZ2p0MHhBUHJ5NmZaUmFRSEJw?=
 =?utf-8?B?QS9UVVVRK3dmWlR2RzVNMHUwL0VWRURabmxHZmc4RnN6bVlRdjEyMHhaSjU0?=
 =?utf-8?B?LzZad1RNSDlGSWIwelZoUFl3a3lETFhNMTVzVjJ3OXlFRTZ3MUFobm5UN3Ny?=
 =?utf-8?B?WHNVTGpOVUdQa2ZxWks2cFRTdkl5ck1VTWJCK3R5V0FCUUsvQXVkQXdWRVdn?=
 =?utf-8?B?K2IwSUJFbU5XSkpFMnExb1ZaR0dnRFpBNnhvNHRjV0NuZGhYODdxeTF5NWUy?=
 =?utf-8?B?N1pFNlkxa045WHZNeVU1MStOME5IcFNVa3FZQTdCUEVhdEN1ZmtnRGIvdm44?=
 =?utf-8?B?TmZwZWJaSFpHMFdmZW1jK1BycXMrYlNxbFFRSVdNZUN2cWFxdmZuelJWaHQ1?=
 =?utf-8?B?eEI0NitMa1RkZ2l6WityRDNGVGQyd0REWEhyWVhuUXlTYWVZOVVmcUYydU9w?=
 =?utf-8?B?ekEwVHRtUWwyMWV0L0o1MVFrTVFGN1BHK1VLdlQrZVBhMVlReVpSUis5MWtM?=
 =?utf-8?B?YituZG50bmJEczhmblB1clRrQlExQ3FONFhNcmNLQ00zYXZaaW55aHB2Ymkr?=
 =?utf-8?B?WUllNVlHdWYvbCszamEyeWNMeVd2dzc3VHNhbkNyeVpUNzJLb3V4d0l2dExH?=
 =?utf-8?B?d3k4NDl6aFpvVmg5Z2ttemloS0FjQzhJRzNtTXpyekFnR1ZlLzBXT1ZxNDhs?=
 =?utf-8?B?NlpwakJPRWZ5MUdudmJ4QUx5d2YwT2Zkc2xJYVkyQ1hBandrVUhQS2NlUU51?=
 =?utf-8?B?Y3FkdW1sdGVLUkpTRkZpaGVHOG5mbjFTYUxjVFFUM1BLU2srRlZadE1VdkpL?=
 =?utf-8?B?NWt5UlBGSE12UWE0U2g5L2t2ZFJ2dGhWQmN1bEF6WmNGNk80aDArQWhJMDAx?=
 =?utf-8?B?ejBjSzEzS3Q1K0l6NDFaRStJcVJnQit1eGhEZW9ES3p0T2hQRnZvYTk0R2Rp?=
 =?utf-8?B?RFUwakpKcGFKbHRnWWE4cUxERXF1Q1B3OE4wb0toM0FLaWE1Tk96YU5KL3Y2?=
 =?utf-8?B?NHo1QlFJcWlCTmFKR0xRS2pTeHFHdnh6eG9MMnpFbFZ6M0luNk42UVQ4SXJj?=
 =?utf-8?B?OUp6WGRKT2p2MDBHdmN1TUxFTzNsbXlMc05GenZWTFhFOGdtcnBWbUY1Y29q?=
 =?utf-8?B?azYrY3FSUXlmRlNOMWplMi92VlZCNjNJUXZPMnNONEhnbXVMWllVd0F0K0tp?=
 =?utf-8?B?dktrTVdpT054T1F1MGtSYjltVWR4TEdpZ2tpV014eUgrSVdHYndoSVJ6Z3dF?=
 =?utf-8?B?NStNejdxaWZjaTNOT1IwMW1TbGhyWFExa3hYclJ0R0Y4ZkhiSllVcGhNb09h?=
 =?utf-8?B?TXlyMHhIVW9qQ3FTWlJlQldGbWFKU1ZtSVVybllEbzljVE54Y3QwdWw5M3gw?=
 =?utf-8?B?cTcwNGZCNHp4bUs1bXVUdXRUNzJ6ZzN1bytDUEVCT1I2M005eCtidHRvcytZ?=
 =?utf-8?B?M0VkMGR0NkVtN0RweEVWbE9MR3RpTzFOLzllbitKV0J0cWJMcGI1OWtLTmtL?=
 =?utf-8?B?emc9PQ==?=
Content-ID: <8B5F853D9B7DEF4E8C76D3D6E64FB654@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: XKr7n859i/KN7bu0ooSU6JoES+QpiDBdov0TlBKbNF8DAabExS2SKNZUm0yX5J7sA7QiRtafrLchVVgJck/WhgDZUN46yAsElj9WTBIaPVgqsVuOrytQR5PcJEJKkRa3N0V6mi1GDq6HKaezZZgpCDGKyNIuJ3nni4b5zFOHu+UatSOxeN6wRgvGhLLlMDgHBVmLwWj7Wwzeoov2tvEIWxhK4NSUPu93w0OUzx64skd2fJiL1iO9NqZhLaUPoeDfD4801lPA780ppORGsSn/EOuhGcIs6TQnR130Kf2vk6N7jquKRf8fOyz6VlSNAG1HDut0Dm0dPgZN3uXcptBAnp0O/Qv1kecsU8VrLRCF1XLeX/Va6kFCDv1aDld0IoHpF9zoZzmr9gTipSB+yR1ccgBPjKr05PUxYUKXEX3tIcooUMUtUn/A/nExBc19JlU7NmogwPhruj1IQb00wGy38bDKKcFls5gI7kt8SaLaE9h1uzsV83FF4UCIiO0AkF4zJ3NtKn/BYo5pcKa/Xtkh3d7ywU36v7MxvXqtRCv0cqZdH9zS8VxU2LHNf77YhQ/E7HfMRxpiievLDZj3sldAAj482bCXmJrflHruhdvb34Qt29mJAzPat1C6sbro1AJBzlQZHdU0GN5l+P1tDZDxKSgBrqtTJqEn2rirB1+SlCHHu0alZyKsAA8DHQjp1xA6cdvtVM9W2Pb/t+68+OclnCCiHnQH8tRJ/BY2pV4fgVJnmvgdrIyUL2wNGwAFviYDugdEXkkQWbDVzFmp120oi0dVM5hTxEtxb/fiGMuuKLQ=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8313.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb1b4c9a-6c51-4cda-527c-08db3660d391
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2023 05:36:09.7237 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BaX147FeSogLmrHmXZ088pOIvSqui3e7VnBoNIsSmCOFvLAeEt2XZESFpq51fJYpAJ4RgveTX4ea6KZ32NswtDfUQkk1onHffrxnk4ISG+E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB12009
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 3/4] syscalls/statx11: Add basic test for
 STATX_DIOALIGN on block device
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


Hi Eric>
> 
> on 2023/04/05 5:59, Eric Biggers wrote:
> 
>> Hi Yang,
>>
>> On Tue, Apr 04, 2023 at 03:30:29PM +0800, Yang Xu wrote:
>>> +	/*
>>> +	 * This test is tightly coupled to the kernel's current DIO restrictions
>>> +	 * on block devices. The general rule of DIO needing to be aligned to the
>>> +	 * block device's logical block size was recently relaxed to allow user buffers
>>
>> Please don't use the word "recently" in code comments like this.  It is vague,
>> and what is "recent" now will no longer be recent in the future.
> 
> OK.
>>
>>> +
>>> +	TST_EXP_PASS(statx(AT_FDCWD, tst_device->dev, 0, 0, &buf),
>>> +		"statx(AT_FDCWD, %s, 0, STATX_DIOALIGN, &buf)", tst_device->dev);
>>> +	TST_EXP_EQ_LU(buf.stx_dio_mem_align, 0);
>>> +	TST_EXP_EQ_LU(buf.stx_dio_offset_align, 0);
>>
>> Like I mentioned on patch 2, this is not a valid test case because the contract
>> of statx() allows it to return information that wasn't explicitly requested.
> 
> OK. Will remove.
>>
>>> +static void setup(void)
>>> +{
>>> +	char *dev_name;
>>> +	int dev_fd;
>>> +
>>> +	dev_fd = SAFE_OPEN(tst_device->dev, O_RDWR);
>>> +	SAFE_IOCTL(dev_fd, BLKSSZGET, &logical_sector_size);
>>> +	SAFE_CLOSE(dev_fd);
>>> +
>>> +	if (logical_sector_size <= 0)
>>> +		tst_brk(TBROK, "BLKSSZGET returned invalid block size %i", logical_sector_size);
>>> +
>>> +	dev_name = basename((char *)tst_device->dev);
>>> +	sprintf(sys_bdev_lgs_path, "/sys/block/%s/queue/logical_block_size", dev_name);
>>> +	while (access(sys_bdev_lgs_path, F_OK) != 0) {
>>> +		dev_name[strlen(dev_name)-1] = '\0';
>>> +		sprintf(sys_bdev_lgs_path, "/sys/block/%s/queue/logical_block_size", dev_name);
>>> +	}
>>
>> What does "lgs" stand for?
> 
> lgs->logical_block_size, will use more meaningful variable name.
> 
>>
>> Why are both BLKSSZGET and /sys/block/%s/queue/logical_block_size being used?
>> Don't they provide exactly the same information?
> 
> Yes, they provide same info, I will only test for sys file instead of ioctl.
>>
>>> +	if (access(sys_bdev_dma_path, F_OK) != 0)
>>> +		tst_brk(TCONF, "dma_alignment syfsfile doesn't exist");
>>> +}
>>
>> syfsfile => sysfs file
> 
> Good catch.
>>
>>> +static void cleanup(void)
>>> +{
>>> +	if (fd > -1)
>>> +		SAFE_CLOSE(fd);
>>> +}
>>
>> What is the purpose of the 'fd' variable?
> 
> Sorry, I copy code from statx10.c, will remove.
>>
>>> +static struct tst_test test = {
>>> +	.test_all = verify_statx,
>>> +	.setup = setup,
>>> +	.cleanup = cleanup,
>>> +	.needs_root = 1,
>>> +	.needs_device = 1,
>>> +};
>>
>> Why does this test need root?
> 
> I remember I have removed this, will remove.

I almost forgot that /dev/loop-control needs root, otherwise will meet 
EACCES error

tst_device.c:108: TINFO: Not allowed to open /dev/loop-control. Are you 
root?: EACCES (13)
tst_device.c:147: TINFO: No free devices found
tst_device.c:354: TBROK: Failed to acquire device

Best Regards
Yang Xu
> 
> 
> Best Regards
> Yang Xu
>>
>> - Eric
> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
