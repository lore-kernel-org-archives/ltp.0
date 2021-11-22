Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69CEAC433F5
	for <ltp@archiver.kernel.org>; Mon, 22 Nov 2021 14:16:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 446C83C8DC3
	for <ltp@archiver.kernel.org>; Mon, 22 Nov 2021 15:16:54 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DAD3F3C0D0B
 for <ltp@lists.linux.it>; Mon, 22 Nov 2021 15:16:43 +0100 (CET)
Received: from IND01-BO1-obe.outbound.protection.outlook.com
 (mail-bo1ind01on0714.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fea5::714])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 87B1B2000DE
 for <ltp@lists.linux.it>; Mon, 22 Nov 2021 15:16:42 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hy4JMEGOrOjSrkKX3PpOKDLLJVFRFKDEwYj5Ggxn0SGWhsKUCI80QeaFLygyDjnE91j3r6CHgfi5TlnQn2ixMW9hmkylga0E+2OSzA9IH+Vr/MsX/OKTif8NX2SwICdevh4hzrOq9AgjiGH0hXtYvE5ANKHKbtdliRVhOAmmk43l/c/ZqNu9pAA2qnFEMzrHPI9Xll4sF1R5l7XA1oX2kJyUZxroxfRpRKaU5yuNaADFbAKYkGM53seHt9CPrHGLMJmZlqP+rAeyXVdqdt7GMg3qI1fbxsofTV/aJD3wkrFN9FbD6EEmDNVAl/GpBXdlpKO9W6LBUqtq8bYXVqBxaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W8AvOHxIkFc5SCz22na0xWuXfd/ijBhp1dqlg7tJzBA=;
 b=DKUw4a5vEjEjbzoTN1d284m3+2BVz96EkuNa5CD1Nq7wYQuyzD/C7xH1q8/Uj70I0eFeE5iie3QhkVBv1KXmY0P4J1qx4wS6Q+QkyEuvHB98YH0GfCn1Dgwydgc0GiC/I4mWyK9V5aw/oZXsFlklxkUF6QCXobI0ez1HGJcagxvuYvqo149LC/nu/O+kCvWPNyjw/54N2J7zr+J5xhVvVFfSEGuYAC+jUMCHwUFSp6ULQXbKu4p/N+G/RV5GtU2OWcKZBLT1QAQGnUeTEAnilqm5Hkzv+BG7Q+fxaQVp8TYa9kRjeoiGQ0Dm0oZae0aJ+MBG9DDQ2dxdZ5MLjwHUmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=exaleapsemi.com; dmarc=pass action=none
 header.from=exaleapsemi.com; dkim=pass header.d=exaleapsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=exaleapsemi.onmicrosoft.com; s=selector2-exaleapsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W8AvOHxIkFc5SCz22na0xWuXfd/ijBhp1dqlg7tJzBA=;
 b=cAEd8wL3Sel96EOkZHNVsIvfPy+thA5VsT6nhycldwWSBcFBITH5ko6+hLAQAE6cHqss7ZLRJmDSusEd4P18R8irgkgllNKNXg/06SxA+hj7+Zmmf2IzIp8ub15X2yp1sZ9kP8qeF8R70WkCBVZuCHGKij7QK3QETmT2yYqODTk=
Received: from BM1PR01MB4628.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b01:a::17)
 by BMXPR01MB2184.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:2f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.21; Mon, 22 Nov
 2021 14:16:39 +0000
Received: from BM1PR01MB4628.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::a999:37c9:727e:fc3d]) by BM1PR01MB4628.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::a999:37c9:727e:fc3d%2]) with mapi id 15.20.4713.024; Mon, 22 Nov 2021
 14:16:39 +0000
From: "Ankita Anil  Kulkarni" <Ankita.AN@exaleapsemi.com>
To: "ltp@lists.linux.it" <ltp@lists.linux.it>
Thread-Topic: Netns tests failure
Thread-Index: AQHX36pfw+Dqw4kVMESobnKb+BBtjg==
Date: Mon, 22 Nov 2021 14:16:39 +0000
Message-ID: <BM1PR01MB46281E563C5D07544F965202FA9F9@BM1PR01MB4628.INDPRD01.PROD.OUTLOOK.COM>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 8cc6609a-eb39-d13e-1a38-41757f027544
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=exaleapsemi.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9629ed4d-05e8-4012-fca5-08d9adc2b335
x-ms-traffictypediagnostic: BMXPR01MB2184:
x-microsoft-antispam-prvs: <BMXPR01MB218460CD24AD60508A2179A3FA9F9@BMXPR01MB2184.INDPRD01.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +1bOH00DVMs+JHW6v0Xfpy1DdGCMUFb2VXzQb67kiRdMY67VNbhYADoYFmQPjMsOgxwDnOqA0wmjsWrdy96PtJZ2d71tpqaO8qivmlx7kceyZH7DdjA6K4+6Lc8tHixkBWGZZ8B1fPLTCE+T6IrtnkXmHpS0AYoDIUTQv1O/9ujNaIMJH9INn52xITLMFBIuxsPNq8k6BF+ILivg4nyqXL+hTvkWluPFaOeMUXeqtJrKwXTLqh6zRGn8YkjVIGS9OePiuYpfHfiRWmYWWvb0gFKqYPc1KyeYPrYc4ON1271ryGsXwFzaogC3wIh0ASEpMFv5OZwt6DBp5F+/+AMMYMFYSQ/HooEitSRkmykwoHC3cw0FRtxQ0LAqB5B+SBiKP9QZxBt1A5j/oQ7sIWoS3W/uBb/wJMMjhQXKP+mDw/HvWVy9XpL5oAS1ufMsm2DEnN+WLsvYZCckdQ5+vcwFUYXTQTRoRq1c94MvXhLyrdSDnzo+6s6xxKnVYHIn3VEpLvpHaG3RG6TZUbAYXvMa1JFCgdb50AxtsT6XNygYLdx0NUN658Cd13S/6fVlC7Q/VvGBODJAexK5KJkRt8CWnsf+3/n5bP4mgdZLia4rchLph8FL57bwCeEt9Vc46K3cRXjp48KE9V+W40gi2YHOgSRw3i0MTNSl3gL5qOmeIaDFtqnhTHceM6DCvOke8JDa0tuOBdZaAg7J5ZZwBzkjCg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BM1PR01MB4628.INDPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(366004)(396003)(376002)(346002)(39830400003)(136003)(316002)(3480700007)(33656002)(7116003)(9686003)(5660300002)(6506007)(71200400001)(76116006)(186003)(6916009)(52536014)(2906002)(8676002)(91956017)(8936002)(66946007)(38100700002)(122000001)(508600001)(55016002)(38070700005)(86362001)(19627405001)(7696005)(66476007)(66446008)(64756008)(66556008)(83380400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MzdXMDBPdDNYaDA4eHZPTWlTVmVUamRKSWVKTGdlM0N4MTE1Zk5rRjhYd29F?=
 =?utf-8?B?Zkw4ak5POVM1dXJ2bUZ1eVlLV1BYS1ZoTTlSZi9RcXM1MmF0NTBQU3MzSmkr?=
 =?utf-8?B?RFFTNlhkR0FHbHJFckgzSDhIcnZVQkhLK3UzTXluK3VINnphcURHcFlDZDVS?=
 =?utf-8?B?R2JoTVB2SXhkZ25hMXFOUW10SENGL3IwNG85Q21lR3JFaU4xRklxK3lzbEFP?=
 =?utf-8?B?K002Tm0vbSt5UmV4UUJzNFFaSElqTFNjKzlXM3Z3MUlpWkxmQ1FCb3pwRzB4?=
 =?utf-8?B?dVpWVnFsS0taSnd3Z0VZY2NDT2FTbHhla1pLNFR1SWxLYXZUOFhIY09WT214?=
 =?utf-8?B?dTc1VkhyelZpSVcxeHZSTENsTDRBUGRpOVdYTlJxcnJZOTgwazhKeUNxZG9l?=
 =?utf-8?B?azFBdFRIN1RNUUNwelhFM3k1aGE0M1gybVlhZVNiZFdCN1JiWHowL1lSN1h0?=
 =?utf-8?B?aVRUeTNnc2lnb1RBb2FMUlpzUFNyQUdjbWIxZS85akpocTRDOGp5Qkd1eG5O?=
 =?utf-8?B?Sk9RRmpJelFsbkFQWTd3TEp1U3Y1bTlscjhJWGpFSFdPRTNkN2RnSmJXT2lL?=
 =?utf-8?B?eG9ZalhZUVRYK2lCVkF2ZXlRdld2dUh4NVhwOE90Q2FPbmNHT1UrRS93ZDZk?=
 =?utf-8?B?L0F2aTFodE1ONVo5ZVo2QTdsbEF0MzYwVDB4T3dkNktPVUM3K1hERUY4Qndv?=
 =?utf-8?B?RlZSWi9tNDB6SmRybklXNXRFWGdjbTFHaEdWT214blovbjl3Z0I2M3VsUFNM?=
 =?utf-8?B?UnJ1d3ArR3NjNDRJZEZLRDVpSThLcTdkZGl1dFBVY3dCWE9Dbno5SDZydi9m?=
 =?utf-8?B?M1o4eFpqVXh5MnRGZ21LTm1CNzc1SWh2NXh2cmJCcXYwR0RoNUcvSEExMTJr?=
 =?utf-8?B?VWo2V1JCNnRVQ2F0aURsT21PMXlqSTZaRkE1MXAvQldSS2hVMlN2ei9UbVg0?=
 =?utf-8?B?Y3dkNjlEeFpvNkNucTJTaUR3MmVoRnd0UHZWNUVPYmhkczFEZHNzSW5yVCt4?=
 =?utf-8?B?dHpSS3dwdDBKYVI5SXh4eUdZR1EzangyOW5MajZBbS9SOC90dmVTUy91MFBt?=
 =?utf-8?B?VEdOYjM5WjIwMU9GM2d3bUZJNGNSZXAyVVBiTU9tRHMyd3YrbzVrM1dtL0dp?=
 =?utf-8?B?alJZVWRkd0NJK1hqUEV5dk1kakdjODdHWEt0VXhSK2p5bmRIOHpZM0JjT0Z4?=
 =?utf-8?B?dzdCT2R0cEdIQnJkSmx3cE9zSVo1aXYvaERkaWdobFcxbWs1SVpUUm8rUU90?=
 =?utf-8?B?UDFDUnNoeFYwVFI0QnFpNHNHYm4rTFpvSUhFNlJnVC9oMWxob3pMaFpEc1hO?=
 =?utf-8?B?amV5eE0rL29uQk8vSTFHUGVRNGlBWjBuQ1VwWk5rM1NUZVBTeGNGS1BVdjQ3?=
 =?utf-8?B?cVNOaXdoK2llT0dDRGVtKzljdzRPTzdoWGJDK1lSbmdlekc5SkdJc3BQYW9D?=
 =?utf-8?B?bGNjQXdTYkxya3Q3RnFMZXBhWlNjak9jRm1uWGVmYVR0NTRyNTl2a2wrZmNG?=
 =?utf-8?B?Sk5Id3c2bXJyWHFMT0g4SFZld0NEUW13eWQrd3QwZTdRd2dweDk4VFU2bTJG?=
 =?utf-8?B?RnZGeFU1TUxNS2NOZE9XbElMS0l6c2NOOUZBMXhUOXFEQURpMlhDUDBPUkF4?=
 =?utf-8?B?YlFDR3ZIajNPaXJNVXptTXJPMXBWN2hjYjhsb3J1NEhMUm9nMlFORFhqTFM2?=
 =?utf-8?B?aC9NS2FvTzBxOFpuUldiZ0htczdIdlJ2Qm0zejFER1JCcUJrQ2wyenRURlFD?=
 =?utf-8?B?UmUxaXllU1ZnRXVNTk5EdGlSREl2UFZoQU81V1ZJcDh5RGhENDlhTFJmMG9C?=
 =?utf-8?B?a0MyaU9BTHl4R09HUGdlRUVaYUludVk1NXIzTXdITjZURUNqK2FVT1VvdW4r?=
 =?utf-8?B?dXpXb1JXNlNaU0RjSktPbHJhK0hNOG02ZysvVnZGZ0R4czczdXF3YVUxRElo?=
 =?utf-8?B?YllOT0FTTWhmLzlnSEdGWkVDa0ZSdzJnTzU2WXNzTmpscEQydUo5NlNoc3Iz?=
 =?utf-8?B?a1YzZk5WVU9uUjU0MWhCQjVMc3JVQVlxelBzTlpSbGNFM0pVMjhaUXRYYi90?=
 =?utf-8?B?cGtJK0RyU0tTbko2dml3dnpkZHBjZmdXYVE2NkV3eDhKWWhIMjkvb0RGbUY5?=
 =?utf-8?B?U1V1R2YrMS95ZVU4eHZUVEJpVTlOMnUzNCsxLzY2cWtLVmtQRWdDQ2liM2dX?=
 =?utf-8?B?aGpKYlByTWFDbGJvdXp5bTZGU0xqUlM2cXZ2UkZNeFR1UFU3N0l1VE5saElj?=
 =?utf-8?B?aHBiZ1pXa3c0NFJ4b2NsQ1dyYWJ2N2g0bkhYY0lSMDlPZDZvMzV6UzhxQlRF?=
 =?utf-8?B?L1NJcTZnbHZsc1Evb0J1dFlla2xGWXJQRDlYRmxheVZQMzhEUFVKUT09?=
MIME-Version: 1.0
X-OriginatorOrg: exaleapsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BM1PR01MB4628.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 9629ed4d-05e8-4012-fca5-08d9adc2b335
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2021 14:16:39.1186 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 34df156e-9bc4-4450-9e80-487c0e7f9471
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2ib6AwslWy9Xla2WWXENQ32Eqe5rYB43IhLbwezequa4i/iaMtWiR/Z7wsOYE4pLjahyvGffCy+aQj1TxZ5M9RkuqsLWwar4Wx4fgic4jog=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BMXPR01MB2184
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] Netns tests failure
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
Content-Type: multipart/mixed; boundary="===============1003046096=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1003046096==
Content-Language: en-GB
Content-Type: multipart/alternative;
	boundary="_000_BM1PR01MB46281E563C5D07544F965202FA9F9BM1PR01MB4628INDP_"

--_000_BM1PR01MB46281E563C5D07544F965202FA9F9BM1PR01MB4628INDP_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQpJIGFtIGV4ZWN1dGluZyBuZXRucyB0ZXN0cyBvbiBGVTc0MChSSVNDVikgZm9yIHlvY3Rv
IGxpbnV4IGtlcm5lbCA1LjEwLjQxLg0KTGlzdCBvZiBmYWlsdXJlczoNCm5ldG5zX2JyZWFrbnNf
aXBfaXB2NF9pb2N0bA0KbmV0bnNfYnJlYWtuc19pcF9pcHY0X25ldGxpbmsNCm5ldG5zX2JyZWFr
bnNfaXBfaXB2Nl9pb2N0bA0KbmV0bnNfYnJlYWtuc19pcF9pcHY2X25ldGxpbmsNCm5ldG5zX2Jy
ZWFrbnNfbnNfZXhlY19pcHY0X2lvY3RsDQpuZXRuc19icmVha25zX25zX2V4ZWNfaXB2NF9uZXRs
aW5rDQpuZXRuc19icmVha25zX25zX2V4ZWNfaXB2Nl9pb2N0bA0KbmV0bnNfYnJlYWtuc19uc19l
eGVjX2lwdjZfbmV0bGluaw0KbmV0bnNfY29tbV9pcF9pcHY0X2lvY3RsDQpuZXRuc19jb21tX2lw
X2lwdjRfbmV0bGluaw0KbmV0bnNfY29tbV9pcF9pcHY2X2lvY3RsDQpuZXRuc19jb21tX2lwX2lw
djZfbmV0bGluaw0KbmV0bnNfY29tbV9uc19leGVjX2lwdjRfaW9jdGwNCm5ldG5zX2NvbW1fbnNf
ZXhlY19pcHY0X25ldGxpbmsNCm5ldG5zX2NvbW1fbnNfZXhlY19pcHY2X2lvY3RsDQpuZXRuc19j
b21tX25zX2V4ZWNfaXB2Nl9uZXRsaW5rDQrigItJIGVuYWJsZWQgZm9sbG93aW5nIGtlcm5lbCBj
b25maWd1cmF0aW9uczoNCkNPTkZJR19EVU1NWT1tDQpDT05GSUdfVkVUSD1tDQpDT05GSUdfVFVO
PXkNCkNPTkZJR19UQVA9eQ0KQ09ORklHX01BQ1ZMQU49eQ0KQ09ORklHX05FVF9JUF9UVU5ORUw9
eQ0KQ09ORklHX05FVF9DT1JFPXkNCkNPTkZJR19ORVRfTlNIPW0NCkNPTkZJR19WWExBTj15DQpD
T05GSUdfVFVOX1ZORVRfQ1JPU1NfTEU9eQ0KQ09ORklHX05FVERFVklDRVM9eQ0KQ09ORklHX05F
VF9OUz15DQpDT05GSUdfTkVUTEFCRUw9eQ0KQ09ORklHX1ZFVEg9eQ0KQ09ORklHX05FVExBQkVM
PXkNCkNPTkZJR19ORVQ9eQ0KQ09ORklHX05FVF9JUF9UVU5ORUw9eQ0K4oCLV2hhdCBjb3VsZCBi
ZSB0aGUgcmVhc29uIG9mIGZhaWx1cmU/DQpIb3cgZG8gSSBwcm9jZWVkIG9uIHRoaXMgaXNzdWU/
DQoNClRCUk9LOiB1bmFibGUgdG8gY3JlYXRlIHZldGggcGFpciBkZXZpY2VzDQppcDogY2FuJ3Qg
ZmluZCBkZXZpY2UgJ3ZldGgwJw0KDQpUQlJPSzogZG9uJ3Qgb2J0YWluIHZhbGlkIGlwcm91dGUg
dmVyc2lvbg0KDQoNClRoYW5rcywNCkFua2l0YSBLdWxrYXJuaQ0K

--_000_BM1PR01MB46281E563C5D07544F965202FA9F9BM1PR01MB4628INDP_
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: base64

PGh0bWw+DQo8aGVhZD4NCjxtZXRhIGh0dHAtZXF1aXY9IkNvbnRlbnQtVHlwZSIgY29udGVudD0i
dGV4dC9odG1sOyBjaGFyc2V0PXV0Zi04Ij4NCjxzdHlsZSB0eXBlPSJ0ZXh0L2NzcyIgc3R5bGU9
ImRpc3BsYXk6bm9uZTsiPiBQIHttYXJnaW4tdG9wOjA7bWFyZ2luLWJvdHRvbTowO30gPC9zdHls
ZT4NCjwvaGVhZD4NCjxib2R5IGRpcj0ibHRyIj4NCjxkaXYgc3R5bGU9ImZvbnQtZmFtaWx5OiBD
YWxpYnJpLCBBcmlhbCwgSGVsdmV0aWNhLCBzYW5zLXNlcmlmOyBmb250LXNpemU6IDEycHQ7IGNv
bG9yOiByZ2IoMCwgMCwgMCk7Ij4NCkhpLDwvZGl2Pg0KPGRpdiBzdHlsZT0iZm9udC1mYW1pbHk6
IENhbGlicmksIEFyaWFsLCBIZWx2ZXRpY2EsIHNhbnMtc2VyaWY7IGZvbnQtc2l6ZTogMTJwdDsg
Y29sb3I6IHJnYigwLCAwLCAwKTsiPg0KSSBhbSBleGVjdXRpbmcgbmV0bnMgdGVzdHMgb24gRlU3
NDAoUklTQ1YpIGZvciB5b2N0byBsaW51eCBrZXJuZWwgNS4xMC40MS48L2Rpdj4NCjxkaXYgc3R5
bGU9ImZvbnQtZmFtaWx5OiBDYWxpYnJpLCBBcmlhbCwgSGVsdmV0aWNhLCBzYW5zLXNlcmlmOyBm
b250LXNpemU6IDEycHQ7IGNvbG9yOiByZ2IoMCwgMCwgMCk7Ij4NCjxiPkxpc3Qgb2YgZmFpbHVy
ZXM6PC9iPjwvZGl2Pg0KPGRpdiBzdHlsZT0iZm9udC1mYW1pbHk6IENhbGlicmksIEFyaWFsLCBI
ZWx2ZXRpY2EsIHNhbnMtc2VyaWY7IGZvbnQtc2l6ZTogMTJwdDsgY29sb3I6IHJnYigwLCAwLCAw
KTsiPg0KPGJsb2NrcXVvdGUgc3R5bGU9ImJvcmRlci1jb2xvcjogcmdiKDIwMCwgMjAwLCAyMDAp
OyBib3JkZXItbGVmdDogM3B4IHNvbGlkIHJnYigyMDAsIDIwMCwgMjAwKTsgcGFkZGluZy1sZWZ0
OiAxZXg7IG1hcmdpbi1sZWZ0OiAwLjhleDsgY29sb3I6IHJnYigxMDIsIDEwMiwgMTAyKTsiIGl0
ZW1zY29wZT0iIiBpdGVtdHlwZT0iaHR0cHM6Ly9zY2hlbWFzLm1pY3Jvc29mdC5jb20vUXVvdGVk
VGV4dCI+DQpuZXRuc19icmVha25zX2lwX2lwdjRfaW9jdGwNCjxkaXY+bmV0bnNfYnJlYWtuc19p
cF9pcHY0X25ldGxpbms8L2Rpdj4NCjxkaXY+bmV0bnNfYnJlYWtuc19pcF9pcHY2X2lvY3RsPC9k
aXY+DQo8ZGl2Pm5ldG5zX2JyZWFrbnNfaXBfaXB2Nl9uZXRsaW5rPC9kaXY+DQo8ZGl2Pm5ldG5z
X2JyZWFrbnNfbnNfZXhlY19pcHY0X2lvY3RsPC9kaXY+DQo8ZGl2Pm5ldG5zX2JyZWFrbnNfbnNf
ZXhlY19pcHY0X25ldGxpbms8L2Rpdj4NCjxkaXY+bmV0bnNfYnJlYWtuc19uc19leGVjX2lwdjZf
aW9jdGw8L2Rpdj4NCjxkaXY+bmV0bnNfYnJlYWtuc19uc19leGVjX2lwdjZfbmV0bGluazwvZGl2
Pg0KPGRpdj5uZXRuc19jb21tX2lwX2lwdjRfaW9jdGw8L2Rpdj4NCjxkaXY+bmV0bnNfY29tbV9p
cF9pcHY0X25ldGxpbms8L2Rpdj4NCjxkaXY+bmV0bnNfY29tbV9pcF9pcHY2X2lvY3RsPC9kaXY+
DQo8ZGl2Pm5ldG5zX2NvbW1faXBfaXB2Nl9uZXRsaW5rPC9kaXY+DQo8ZGl2Pm5ldG5zX2NvbW1f
bnNfZXhlY19pcHY0X2lvY3RsPC9kaXY+DQo8ZGl2Pm5ldG5zX2NvbW1fbnNfZXhlY19pcHY0X25l
dGxpbms8L2Rpdj4NCjxkaXY+bmV0bnNfY29tbV9uc19leGVjX2lwdjZfaW9jdGw8L2Rpdj4NCjxk
aXY+bmV0bnNfY29tbV9uc19leGVjX2lwdjZfbmV0bGluazxicj4NCjwvZGl2Pg0KPC9ibG9ja3F1
b3RlPg0KPGRpdj48c3BhbiBzdHlsZT0iZm9udC1mYW1pbHk6IENhbGlicmksIEFyaWFsLCBIZWx2
ZXRpY2EsIHNhbnMtc2VyaWY7IGZvbnQtc2l6ZTogMTJwdDsgY29sb3I6IHJnYigwLCAwLCAwKTsi
PuKAi0kgZW5hYmxlZCBmb2xsb3dpbmcga2VybmVsIGNvbmZpZ3VyYXRpb25zOjwvc3Bhbj48L2Rp
dj4NCjxkaXY+DQo8YmxvY2txdW90ZSBzdHlsZT0iYm9yZGVyLWNvbG9yOiByZ2IoMjAwLCAyMDAs
IDIwMCk7IGJvcmRlci1sZWZ0OiAzcHggc29saWQgcmdiKDIwMCwgMjAwLCAyMDApOyBwYWRkaW5n
LWxlZnQ6IDFleDsgbWFyZ2luLWxlZnQ6IDAuOGV4OyBjb2xvcjogcmdiKDEwMiwgMTAyLCAxMDIp
OyIgaXRlbXNjb3BlPSIiIGl0ZW10eXBlPSJodHRwczovL3NjaGVtYXMubWljcm9zb2Z0LmNvbS9R
dW90ZWRUZXh0Ij4NCjxzcGFuIHN0eWxlPSJmb250LWZhbWlseTogQ2FsaWJyaSwgQXJpYWwsIEhl
bHZldGljYSwgc2Fucy1zZXJpZjsgZm9udC1zaXplOiAxMHB0OyBjb2xvcjogcmdiKDAsIDAsIDAp
OyI+Q09ORklHX0RVTU1ZPW08L3NwYW4+PHNwYW4gc3R5bGU9ImZvbnQtZmFtaWx5OiBDYWxpYnJp
LCBBcmlhbCwgSGVsdmV0aWNhLCBzYW5zLXNlcmlmOyBmb250LXNpemU6IDEycHQ7IGNvbG9yOiBy
Z2IoMCwgMCwgMCk7Ij4NCjxkaXY+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZTogMTBwdDsiPkNPTkZJ
R19WRVRIPW08L3NwYW4+PC9kaXY+DQo8ZGl2PjxzcGFuIHN0eWxlPSJmb250LXNpemU6IDEwcHQ7
Ij5DT05GSUdfVFVOPXk8L3NwYW4+PC9kaXY+DQo8ZGl2PjxzcGFuIHN0eWxlPSJmb250LXNpemU6
IDEwcHQ7Ij5DT05GSUdfVEFQPXk8L3NwYW4+PC9kaXY+DQo8ZGl2PjxzcGFuIHN0eWxlPSJmb250
LXNpemU6IDEwcHQ7Ij5DT05GSUdfTUFDVkxBTj15PC9zcGFuPjwvZGl2Pg0KPGRpdj48c3BhbiBz
dHlsZT0iZm9udC1zaXplOiAxMHB0OyI+Q09ORklHX05FVF9JUF9UVU5ORUw9eTwvc3Bhbj48L2Rp
dj4NCjxkaXY+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZTogMTBwdDsiPkNPTkZJR19ORVRfQ09SRT15
PC9zcGFuPjwvZGl2Pg0KPGRpdj48c3BhbiBzdHlsZT0iZm9udC1zaXplOiAxMHB0OyI+Q09ORklH
X05FVF9OU0g9bTwvc3Bhbj48L2Rpdj4NCjxkaXY+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZTogMTBw
dDsiPkNPTkZJR19WWExBTj15PC9zcGFuPjwvZGl2Pg0KPGRpdj48c3BhbiBzdHlsZT0iZm9udC1z
aXplOiAxMHB0OyI+Q09ORklHX1RVTl9WTkVUX0NST1NTX0xFPXk8L3NwYW4+PC9kaXY+DQo8ZGl2
PjxzcGFuIHN0eWxlPSJmb250LXNpemU6IDEwcHQ7Ij5DT05GSUdfTkVUREVWSUNFUz15PC9zcGFu
PjwvZGl2Pg0KPGRpdj48c3BhbiBzdHlsZT0iZm9udC1zaXplOiAxMHB0OyI+Q09ORklHX05FVF9O
Uz15PC9zcGFuPjwvZGl2Pg0KPGRpdj48c3BhbiBzdHlsZT0iZm9udC1zaXplOiAxMHB0OyI+Q09O
RklHX05FVExBQkVMPXk8L3NwYW4+PC9kaXY+DQo8ZGl2PjxzcGFuIHN0eWxlPSJmb250LXNpemU6
IDEwcHQ7Ij5DT05GSUdfVkVUSD15PC9zcGFuPjwvZGl2Pg0KPGRpdj48c3BhbiBzdHlsZT0iZm9u
dC1zaXplOiAxMHB0OyI+Q09ORklHX05FVExBQkVMPXk8L3NwYW4+PC9kaXY+DQo8ZGl2PjxzcGFu
IHN0eWxlPSJmb250LXNpemU6IDEwcHQ7Ij5DT05GSUdfTkVUPXk8L3NwYW4+PC9kaXY+DQo8L3Nw
YW4+DQo8ZGl2PjxzcGFuIHN0eWxlPSJmb250LWZhbWlseTogQ2FsaWJyaSwgQXJpYWwsIEhlbHZl
dGljYSwgc2Fucy1zZXJpZjsgZm9udC1zaXplOiAxMHB0OyBjb2xvcjogcmdiKDAsIDAsIDApOyI+
Q09ORklHX05FVF9JUF9UVU5ORUw9eTwvc3Bhbj48YnI+DQo8L2Rpdj4NCjwvYmxvY2txdW90ZT4N
CjxkaXY+PHNwYW4gc3R5bGU9ImZvbnQtZmFtaWx5OiBDYWxpYnJpLCBBcmlhbCwgSGVsdmV0aWNh
LCBzYW5zLXNlcmlmOyBmb250LXNpemU6IDEycHQ7IGNvbG9yOiByZ2IoMCwgMCwgMCk7Ij7igItX
aGF0IGNvdWxkIGJlIHRoZSByZWFzb24gb2YgZmFpbHVyZT88L3NwYW4+PC9kaXY+DQo8ZGl2Pjxz
cGFuIHN0eWxlPSJmb250LWZhbWlseTogQ2FsaWJyaSwgQXJpYWwsIEhlbHZldGljYSwgc2Fucy1z
ZXJpZjsgZm9udC1zaXplOiAxMnB0OyBjb2xvcjogcmdiKDAsIDAsIDApOyI+SG93IGRvIEkgcHJv
Y2VlZCBvbiB0aGlzIGlzc3VlPzwvc3Bhbj48L2Rpdj4NCjxkaXY+PHNwYW4gc3R5bGU9ImZvbnQt
ZmFtaWx5OiBDYWxpYnJpLCBBcmlhbCwgSGVsdmV0aWNhLCBzYW5zLXNlcmlmOyBmb250LXNpemU6
IDEycHQ7IGNvbG9yOiByZ2IoMCwgMCwgMCk7Ij48YnI+DQo8L3NwYW4+PC9kaXY+DQo8ZGl2Pjxz
cGFuIHN0eWxlPSJmb250LWZhbWlseTogQ2FsaWJyaSwgQXJpYWwsIEhlbHZldGljYSwgc2Fucy1z
ZXJpZjsgZm9udC1zaXplOiAxMnB0OyBjb2xvcjogcmdiKDAsIDAsIDApOyI+VEJST0s6IHVuYWJs
ZSB0byBjcmVhdGUgdmV0aCBwYWlyIGRldmljZXM8YnI+DQo8c3Bhbj5pcDogY2FuJ3QgZmluZCBk
ZXZpY2UgJ3ZldGgwJzwvc3Bhbj48YnI+DQo8L3NwYW4+PC9kaXY+DQo8ZGl2PjxzcGFuIHN0eWxl
PSJmb250LWZhbWlseTogQ2FsaWJyaSwgQXJpYWwsIEhlbHZldGljYSwgc2Fucy1zZXJpZjsgZm9u
dC1zaXplOiAxMnB0OyBjb2xvcjogcmdiKDAsIDAsIDApOyI+PGJyPg0KPC9zcGFuPjwvZGl2Pg0K
PGRpdj48c3BhbiBzdHlsZT0iZm9udC1mYW1pbHk6IENhbGlicmksIEFyaWFsLCBIZWx2ZXRpY2Es
IHNhbnMtc2VyaWY7IGZvbnQtc2l6ZTogMTJwdDsgY29sb3I6IHJnYigwLCAwLCAwKTsiPlRCUk9L
OiBkb24ndCBvYnRhaW4gdmFsaWQgaXByb3V0ZSB2ZXJzaW9uPGJyPg0KPC9zcGFuPjwvZGl2Pg0K
PGRpdj48c3BhbiBzdHlsZT0iZm9udC1mYW1pbHk6IENhbGlicmksIEFyaWFsLCBIZWx2ZXRpY2Es
IHNhbnMtc2VyaWY7IGZvbnQtc2l6ZTogMTJwdDsgY29sb3I6IHJnYigwLCAwLCAwKTsiPjxicj4N
Cjwvc3Bhbj48L2Rpdj4NCjxkaXY+PHNwYW4gc3R5bGU9ImZvbnQtZmFtaWx5OiBDYWxpYnJpLCBB
cmlhbCwgSGVsdmV0aWNhLCBzYW5zLXNlcmlmOyBmb250LXNpemU6IDEycHQ7IGNvbG9yOiByZ2Io
MCwgMCwgMCk7Ij48YnI+DQo8L3NwYW4+PC9kaXY+DQo8ZGl2PjxzcGFuIHN0eWxlPSJmb250LWZh
bWlseTogQ2FsaWJyaSwgQXJpYWwsIEhlbHZldGljYSwgc2Fucy1zZXJpZjsgZm9udC1zaXplOiAx
MnB0OyBjb2xvcjogcmdiKDAsIDAsIDApOyI+VGhhbmtzLDwvc3Bhbj48L2Rpdj4NCjxkaXY+PHNw
YW4gc3R5bGU9ImZvbnQtZmFtaWx5OiBDYWxpYnJpLCBBcmlhbCwgSGVsdmV0aWNhLCBzYW5zLXNl
cmlmOyBmb250LXNpemU6IDEycHQ7IGNvbG9yOiByZ2IoMCwgMCwgMCk7Ij5BbmtpdGEgS3Vsa2Fy
bmk8YnI+DQo8L3NwYW4+PC9kaXY+DQo8L2Rpdj4NCjwvZGl2Pg0KPC9ib2R5Pg0KPC9odG1sPg0K

--_000_BM1PR01MB46281E563C5D07544F965202FA9F9BM1PR01MB4628INDP_--

--===============1003046096==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1003046096==--
