Return-Path: <SRS0=zuCx=QD=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A1FCC433EF
	for <ltp@archiver.kernel.org>; Tue, 16 Nov 2021 09:20:36 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83DF861B27
	for <ltp@archiver.kernel.org>; Tue, 16 Nov 2021 09:20:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 83DF861B27
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3FEE93C7CBA
	for <ltp@archiver.kernel.org>; Tue, 16 Nov 2021 10:20:33 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2895E3C0595
 for <ltp@lists.linux.it>; Tue, 16 Nov 2021 10:20:23 +0100 (CET)
Received: from esa16.fujitsucc.c3s2.iphmx.com (esa16.fujitsucc.c3s2.iphmx.com
 [216.71.158.33])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 711151A0121D
 for <ltp@lists.linux.it>; Tue, 16 Nov 2021 10:20:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1637054422; x=1668590422;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=GDJC5Gd+QBwumpacQuPTxyze8zb0XF/MVazFf9PRSYE=;
 b=vHwi+soHZW0XjVqRcBgbUWXQM0dYQKAwDKFL/KFYtAekS9L3VJHGIKjI
 OCbwC2azfKuQmpODnOkoW3P0jG5r0Mx0Cw10uWZ2UD3b8YiuSLPRG7RRX
 QuGQsp6wESihrHnJGFE1Ff8Q2DUdD+8lHL4KDBW5moVw0HIqxxChC3WfH
 02AWLBA1g4DWRK4FIZfekK/rcAQeXRaKNipQHxyXmsEdJCoHm6k5moKyp
 wVUEaVELtndhPfgm6ztrgL0sBT+1IfAmhzjkqhgE247ni6Lxxwvg6/sC2
 0TbPFTXLwyTUINgv241Cr+lPPfyt/w1lzoIEOqNIF6v2WRfXeTr8w56E9 g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10169"; a="43671701"
X-IronPort-AV: E=Sophos;i="5.87,238,1631545200"; d="scan'208";a="43671701"
Received: from mail-os2jpn01lp2054.outbound.protection.outlook.com (HELO
 JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.54])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2021 18:20:19 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S80wuQj46aRcU3XVag2hBNf+VoqCKgRPop4hU97Rromf0uNLExcDZrXa/UDcVbOAtH+W8WsSVEobICa4VNeh5kjxxNpRZjYFGcAoSGBmoEB+ncqBimgAKpeGtUNoqwCgA6NpNQEoyngJfXb6yJCayjk/sn9gM2SLcKL7pXcAcKao2X8MgGz2CIw48svXjJ+v0FTBsbxwHcd36xQ4PC6weztb3dPRPA+OrUO8xzOefNAwHbqMTNV09sLlfPB3VRrXPpsnNnMZW3BN0Ab91/SDQJUG6r9zXD0M2btk4YqhS93Up7m/EdslNx/Ra4Fc8st4mqn/MrxZ5yD17G87iHQ2XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GDJC5Gd+QBwumpacQuPTxyze8zb0XF/MVazFf9PRSYE=;
 b=MPS5CCY71i8lVp07GWIZeuLYeJe13TgGIUHZQJ6ikwIBKAM87TOKg/j1Ss5hkWeHBhsRMyNc0QScbndRc7FigJcHKz/Cx1LkOIzg073GStFQ0KavQc+TdI7HXi4fujszsG1ejGDJrkduRMKNdcbgY6zXtItqpAIPERbWRfR8eWBsPL7tK4XQ7bAaUv+b3Giw/tazHhMr4GYGWBjWTWSGGBoMUxui+lW2ujbFPRAkzbUBtrFwsVjz3ofQGBHL5vM4mbsMnDhkPth6DBQ1b8FPMKcCaGN0dw4uTMIeaNeJUejZ0oeXwKKn+YJkKjZfsNqDwHXfTQPh+TRBlBCQdeKD5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GDJC5Gd+QBwumpacQuPTxyze8zb0XF/MVazFf9PRSYE=;
 b=bCzUhngVhiK2jxxW7Z+10neZR5s2zz9YAUvj+TmVk8wX60fKNE8d8YrPysjbS8/4Pi+0Ec7tgzjDBYhx+EJwiHAWSG8i3ko7eOnKXFVg5p8l/+i32QcaI9G7a9rCu5Jtg0HtoVTWaAH70v5neqW8fU4n0fhGMPL6XjSVIe+MqfQ=
Received: from OS3PR01MB7705.jpnprd01.prod.outlook.com (2603:1096:604:17c::12)
 by OSAPR01MB7325.jpnprd01.prod.outlook.com (2603:1096:604:11c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.20; Tue, 16 Nov
 2021 09:20:16 +0000
Received: from OS3PR01MB7705.jpnprd01.prod.outlook.com
 ([fe80::f435:c43f:4ecd:969e]) by OS3PR01MB7705.jpnprd01.prod.outlook.com
 ([fe80::f435:c43f:4ecd:969e%3]) with mapi id 15.20.4690.027; Tue, 16 Nov 2021
 09:20:16 +0000
From: "suy.fnst@fujitsu.com" <suy.fnst@fujitsu.com>
To: Alexey Kodanev <aleksei.kodanev@bell-sw.com>, "ltp@lists.linux.it"
 <ltp@lists.linux.it>
Thread-Topic: [PATCH 2/2] lib/tst_net.sh: disable ipv6_dad work on test
 interfaces
Thread-Index: AQHXqJyRN5lje66RH0uMWx295ZNi5qwGQvPn
Date: Tue, 16 Nov 2021 09:20:16 +0000
Message-ID: <OS3PR01MB7705E6C426E51AB12A085D7789999@OS3PR01MB7705.jpnprd01.prod.outlook.com>
References: <20210913123935.10761-1-aleksei.kodanev@bell-sw.com>
 <20210913123935.10761-2-aleksei.kodanev@bell-sw.com>
In-Reply-To: <20210913123935.10761-2-aleksei.kodanev@bell-sw.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: e58f9dee-15a6-ff9a-a1e1-7c0ecde23963
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 037663a7-4c1c-4b38-1b25-08d9a8e24d33
x-ms-traffictypediagnostic: OSAPR01MB7325:
x-microsoft-antispam-prvs: <OSAPR01MB73250AE47D48C4767E504EE489999@OSAPR01MB7325.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: djAS7szUroDdm7CYeNJW3jwqdkFu9Ylz9Lsb8B8hXN5RDz5xTa+VSBRb45AxqPDIAI2sHFo8TmfPI+OdQztrLQiCmNsKpMxybcTIFFDLFrSapahip7cpXmuBn3t/JjMY65Jh381+gvsic97ikEgQyosn4Djh8/4Jf39pw7B2KdE66didk5I4nysV/m5aimMGjWzM2spN9+dHtZhH0j2NgBQyUNmmFJaQpYLh01Yu+816WX0LDaqC5UTdCHBnw+ERXaWS1oJbue3JkiIMMV3XGWL49W1N8SZJqPjQ2i+UazYKAlDyakTy2HBpSlacj34wEPDm/ZigZkBDVpvXEDKyYhnRVkcmGVV0tz2YFLcAM6pG0JfAaD36AJl8KqFqGdrGrW5BZBui8Nyvmx9eU2K86HOIhU5W1PmfI49UpKdYhmqeBWzscw5pplcajWgzGDdzY3DscA5V6GqxqTQwprjvVJP7i0JZPZl7sRXWYYMdqTfX/jsDY3wGT9mpkyQHez3OGBYDKeIIwh54wq99vRA4jFHvvirbRYw7zfsZz2KpnJJjUZ4gJStwLAX0eLuuAUhVj5XG9pTIVH+sG/x20BEUTWJUhiYEuWc0rYMbNXCzJ9tPVW/V0m/BJVDlsUsgz+AuqIN/ykEPYMaXQQQRW+ibUvOX/8a0ygCNcRuDyeNn7tsWDp2xrJI01em9+KI1Tn4OXvB0EgFFZrpuDrtlifxEge3432wRulgzitDrmkSS/8WyNuLOCjovvm9EHTTrUmwnSRwW6eK7pZLUWlek5mNYa9xRRENVU2ULd3jsi/M/Uk8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS3PR01MB7705.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(316002)(52536014)(82960400001)(85182001)(91956017)(66946007)(76116006)(508600001)(110136005)(64756008)(66556008)(66476007)(7696005)(186003)(38070700005)(66446008)(71200400001)(55016002)(26005)(966005)(9686003)(53546011)(6506007)(2906002)(38100700002)(83380400001)(122000001)(8936002)(33656002)(5660300002)(8676002)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?L2dRVGQvTUVsUm5YYzlaOGFmVy9oYUkrd1E5ZXM2TWNkeHhwU3dLWlRjUzBG?=
 =?gb2312?B?STlkWGJQUjBVSzZNcm80c2FxMVhtQW91cWxYYTljZ2hQOVc0Q3FpelluUkVH?=
 =?gb2312?B?Yk8rZlp6WklKd0hwaTQvV0NQTlpPaHlkb0xxOTFvRFNZWTNBS2g0enhQZEg3?=
 =?gb2312?B?MDNQdDQzTHJOcDZ5YlYxVlFTTnJuUTJzajljY0RqK0RndkhpVGVQaXZ4NzR2?=
 =?gb2312?B?Ti9TVFRvTFFlbHFnVHBnclI3dkRKelplUTYrK1RNYjRJd1ZnQSs2OTh2cysx?=
 =?gb2312?B?TDJJclhkbkJnMit3dGdyZmx5cWM5aUQ4Vmg1NktCcWNOanExdG1nMm1Na1VW?=
 =?gb2312?B?VitNWVBCa004R1hzTWFHVXFDVDYrRzNzVW4wSFJFVW5RNFhXQlFoZDR2akFS?=
 =?gb2312?B?Ynk3M29pL1dsck1SdkprQ0lYcmxabHhhQ2sxOXdHcnd6aFM2TGJRL0JOMFdr?=
 =?gb2312?B?K05zcmhqV055WlprL0pWMUxSMEFuOUxHblZpTGZZOThwbHc1QWF3NFowNHNM?=
 =?gb2312?B?RmFpUWhnWVBiV1B4UkFyUTFvbG9GQUNGSzJIYVN1U2l0VjNrdFZrWlFKNjM1?=
 =?gb2312?B?RDVLdVlqcUJSeWNFNnNhRGFUOXdmeTBxVTF4Y05DMVNBNm1UN1JaRFQrbTM1?=
 =?gb2312?B?ZjAvWDV0VnRkL1FxdFFoeHVlYU1LT2NMR1crT1d2djVrNUc2WFYrbGp3Mk9u?=
 =?gb2312?B?V2JwYkx6MnFxUWtZNWZLajBpMFI4TXRoNmNVMWx1TThlQmFyem1zenZHMzBO?=
 =?gb2312?B?WVNCbnp1a0dWUjdhRDYwaUpjL1NWOTlxMC9OdkNQeXVmVlFZdjEvMGZPZ1Vj?=
 =?gb2312?B?VUFIc2pxanJrM0FnUktsUFRkallZY0VyUEFPaDh2VEJuVzc2ZjErc05EMkc3?=
 =?gb2312?B?MmkwVWZhTzVkQWd2VDA0cFpzRGs0OUlBc2Urd2NCNXR2TkxpY3dkMkRWNlV3?=
 =?gb2312?B?U2FSUFUrTVRvdUNHRVp5QXpFUkJkbk81dy9LSERCTGF6WWs0NzIydjRnSmlZ?=
 =?gb2312?B?UEtLS1hJT1JwVVdNbm54VWg2Q3pIK2s4R01pN2hpeHVvMGVTV042TG9vSmlp?=
 =?gb2312?B?aUoxTXlvQ29mdjRHeXRBaHpBMWpiWDRnbzJadVovaTk2Q01BZk5wWGN6bGdj?=
 =?gb2312?B?Vk01cmczdkNYemc3bUc5YjBvMUE1NzRyL2h1L2RxVlliTmd5cFpHa2tjYURm?=
 =?gb2312?B?TWdYTzB3Q2lvU3BzWkhjb3VzZUFIellKa2NLTFN2WUFxL24xSjdCY2NqUFlu?=
 =?gb2312?B?R1BCUHFCN1RLYjQyWW9Rc2ErT1N5WlNwRXFDRW5IRU5qaVJhcHlsaEZLMG1J?=
 =?gb2312?B?UEpLTHZuR1hhOU1ZR3ZYOVJYcW9JbjFaOExLMXBLdy9nK0pTeEN6NmV1Mkx0?=
 =?gb2312?B?SmFhbmkxMTdRYVM2THUrSlNvUWF1azRnQ3Z3amNreGVqcCtJNkxqZWdHblNt?=
 =?gb2312?B?K0tSZkpGL3pNTDVudEpWajh2dTNYRStZWXVQV291a2lCQlJSV3FyOEhpMVc0?=
 =?gb2312?B?OFhlMXJJTEZSTDVoK290Y3g0NWlDK1ZtenZSWEZvbGwxRUxhTmg4Tkg3Vk1B?=
 =?gb2312?B?Y0pHcWFLT3UwNDhvaWprd08xajByU0hqWTgvYU01eEptb3NOQmkwaThVY2JQ?=
 =?gb2312?B?TlRIRXN6VjV3ZWRNbkdrN3lITUxiUDZad3grMFFOS3JBK29JQS91Z0dYbmM5?=
 =?gb2312?B?Ly92bDJMUFZqTmo2c0dzSHBpcnVoWDVpWUtVdFBJc2lTdzVuQ3p0MkhiYUFL?=
 =?gb2312?B?SWc5c1RjZ29OUXE0Zk83K3dFRDVUUFZYb0dwSUVkT2RaOVJnbFNqcDlHajRM?=
 =?gb2312?B?TzdNN3c5WGV2VzVNYytoZU5OYXhuS3Nud0xsS0NiRHo2dzQ1RUU2WlduQzlh?=
 =?gb2312?B?azVISlI1VFBKRnlUaWVtNmMyN0ZXV0E4TEdBRWIraUJxREYza0c0VUNXcWZn?=
 =?gb2312?B?MXJiaE0vZE9DVWQ2M3MrV1l4LzRyWVFqaDYvbXVQeEpYbkl3WXhQaFFFWHB1?=
 =?gb2312?B?by9jeGV4NGUxcGRRcUtjSU9xZStXS3hBWGUvRkFIYlljd1RMdVFFU05wVlo4?=
 =?gb2312?B?UDhjMGxabTlVYkhZUXhKb3p2clpNRnpCeGwrN1l2VkdRSnFqUVZnY3hHZ2Zh?=
 =?gb2312?B?QXFwSTBjTkl4UTQ2aVc3R2dHUCtBMzZNeFNJR1lmdE5zZ3BlU2JhTFF4dzJS?=
 =?gb2312?B?cmc9PQ==?=
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB7705.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 037663a7-4c1c-4b38-1b25-08d9a8e24d33
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2021 09:20:16.0368 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mPIcY50AsWgbHoXSlBRvPYPUVq5PwQCM1k01CH4D2AMxpU40RwVaX5rRP0lza5jNxDzbCmv0cOTh1M4AyYcsmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB7325
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] lib/tst_net.sh: disable ipv6_dad work on test
 interfaces
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
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGksCiAgT2J2aW91c2x5IGBzeXNjdGwgLXF3IG5ldC5pcHY2LmNvbmYuJGlmYWNlLmFjY2VwdF9k
YWQ9MGAgd291bGQgZmFpbGVkIGlmIGlwdjYgaXMgb2ZmLgpJdCBjYXVzZWQgZmFpbHVyZXMgb2Yg
dGVzdHMgd2hlbiBpcHY2IGlzIG9mZiBpbiBvdXIgaW50ZXJuYWwgZW52aXJvbm1lbnQuCiAgTm8g
bWVhbiB0byBibGFtZSB0aGUgY29tbWl0LCBqdXN0IHJlcG9ydCB0aGUgaXNzdWUgOiApCgpUaGFu
a3MsClN1CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkZyb206IEFs
ZXhleSBLb2RhbmV2IDxhbGVrc2VpLmtvZGFuZXZAYmVsbC1zdy5jb20+ClNlbnQ6IE1vbmRheSwg
U2VwdGVtYmVyIDEzLCAyMDIxIDIwOjM5ClRvOiBsdHBAbGlzdHMubGludXguaXQKQ2M6IEFsZXhl
eSBLb2RhbmV2OyBTdSwgWXVlL8vVINS9ClN1YmplY3Q6IFtQQVRDSCAyLzJdIGxpYi90c3RfbmV0
LnNoOiBkaXNhYmxlIGlwdjZfZGFkIHdvcmsgb24gdGVzdCBpbnRlcmZhY2VzCgpUbyBmaXggaW50
ZXJtaXR0ZW50IGlzc3VlcyB3aXRoIHBpbmcgKGluIGZsb29kIG1vZGUpIFsxXSB0ZXN0cwphZnRl
ciBpbml0aWFsIHRlc3QgaW50ZXJmYWNlcyBzZXR1cC4KCldlJ3JlIGFscmVhZHkgYWRkaW5nIElQ
djYgYWRkcmVzc2VzIHdpdGggbm9kYWQgb3B0aW9uLCBidXQgaXQKc2hvdWxkIGRpc2FibGUgaXB2
Nl9kYWQgZm9yIGxpbmstbG9jYWwgYWRkcmVzc2VzIHRvbywgc28gdGhhdAp0aGV5IGFyZSBmdWxs
eSBmdW5jdGlvbmFsIHdoZW4gdGVzdHMgc3RhcnQgdG8gdXNlIHRoZW0uCgpJdCBjb3VsZCBhbHNv
IGJlIHRzdF93YWl0X2lwdjZfZGFkKCksIGJ1dCBpdCBzbG93cyBkb3duIGEgdGVzdApzZXR1cC4K
ClsxXTogaHR0cHM6Ly9naXRodWIuY29tL2lwdXRpbHMvaXB1dGlscy9pc3N1ZXMvMzAwCgpUZXN0
ZWQtYnk6IFN1IFl1ZSA8c3V5LmZuc3RAZnVqaXRzdS5jb20+ClNpZ25lZC1vZmYtYnk6IEFsZXhl
eSBLb2RhbmV2IDxhbGVrc2VpLmtvZGFuZXZAYmVsbC1zdy5jb20+Ci0tLQogdGVzdGNhc2VzL2xp
Yi90c3RfbmV0LnNoIHwgMiArKwogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQoKZGlm
ZiAtLWdpdCBhL3Rlc3RjYXNlcy9saWIvdHN0X25ldC5zaCBiL3Rlc3RjYXNlcy9saWIvdHN0X25l
dC5zaAppbmRleCA3ZjJhMWJhYjMuLjg5ZDRjNzllYyAxMDA2NDQKLS0tIGEvdGVzdGNhc2VzL2xp
Yi90c3RfbmV0LnNoCisrKyBiL3Rlc3RjYXNlcy9saWIvdHN0X25ldC5zaApAQCAtNTE3LDYgKzUx
Nyw3IEBAIHRzdF9pbml0X2lmYWNlKCkKICAgICAgICAgICAgICAgIGlwIGxpbmsgc2V0ICRpZmFj
ZSBkb3duIHx8IHJldHVybiAkPwogICAgICAgICAgICAgICAgaXAgcm91dGUgZmx1c2ggZGV2ICRp
ZmFjZSB8fCByZXR1cm4gJD8KICAgICAgICAgICAgICAgIGlwIGFkZHIgZmx1c2ggZGV2ICRpZmFj
ZSB8fCByZXR1cm4gJD8KKyAgICAgICAgICAgICAgIHN5c2N0bCAtcXcgbmV0LmlwdjYuY29uZi4k
aWZhY2UuYWNjZXB0X2RhZD0wIHx8IHJldHVybiAkPwogICAgICAgICAgICAgICAgaXAgbGluayBz
ZXQgJGlmYWNlIHVwCiAgICAgICAgICAgICAgICByZXR1cm4gJD8KICAgICAgICBmaQpAQCAtNTI4
LDYgKzUyOSw3IEBAIHRzdF9pbml0X2lmYWNlKCkKICAgICAgICB0c3Rfcmhvc3RfcnVuIC1jICJp
cCBsaW5rIHNldCAkaWZhY2UgZG93biIgfHwgcmV0dXJuICQ/CiAgICAgICAgdHN0X3Job3N0X3J1
biAtYyAiaXAgcm91dGUgZmx1c2ggZGV2ICRpZmFjZSIgfHwgcmV0dXJuICQ/CiAgICAgICAgdHN0
X3Job3N0X3J1biAtYyAiaXAgYWRkciBmbHVzaCBkZXYgJGlmYWNlIiB8fCByZXR1cm4gJD8KKyAg
ICAgICB0c3Rfcmhvc3RfcnVuIC1jICJzeXNjdGwgLXF3IG5ldC5pcHY2LmNvbmYuJGlmYWNlLmFj
Y2VwdF9kYWQ9MCIgfHwgcmV0dXJuICQ/CiAgICAgICAgdHN0X3Job3N0X3J1biAtYyAiaXAgbGlu
ayBzZXQgJGlmYWNlIHVwIgogfQoKLS0KMi4yNS4xCgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBo
dHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
