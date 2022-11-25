Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92AD3C4332F
	for <ltp@archiver.kernel.org>; Fri, 25 Nov 2022 14:01:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6AA2D3CC917
	for <ltp@archiver.kernel.org>; Fri, 25 Nov 2022 15:01:03 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 975693C8524
 for <ltp@lists.linux.it>; Fri, 25 Nov 2022 15:00:51 +0100 (CET)
Received: from thsbbfxrt01p.thalesgroup.com (thsbbfxrt01p.thalesgroup.com
 [192.54.144.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 9D8FB200DCA
 for <ltp@lists.linux.it>; Fri, 25 Nov 2022 15:00:50 +0100 (CET)
Received: from thsbbfxrt01p.thalesgroup.com (localhost [127.0.0.1])
 by localhost (Postfix) with SMTP id 4NJc2n6bYZz45HW
 for <ltp@lists.linux.it>; Fri, 25 Nov 2022 15:00:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thalesgroup.com;
 s=xrt20181201; t=1669384849;
 bh=XBxJ72FEr+rAN318i4wtzhYH/Xy1efYsEnStKSXc0l4=;
 h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
 MIME-Version:From;
 b=v+cPHHMTUOdZrW7nOxHCkanaER3/EIz4ggdXy4WeUFh9gPhYNq0KIxXSfHE9ARsi0
 zoUMKvxVmfCRA5Lym/DMVhGrWosmTqdQp6kPSPlD65Kx9dt9Y8WRLnTGD6ozlBpsTR
 awpuyeAXwUgt/Ln6q5wusAMqYVeETfe47mMgqXX/E8Lxzg/B06Pm/7h+VwDQZwmPLf
 hkOCBVCB70E6XZid7p7vYqtUR/8hFIUmmqM4PJruZab+IPSP1X8T0cWaH4UA8duI33
 0ce8jomP3/EZTdLkYixkiL6Lz2VxzAXovY/MlB0J4EqZRD7Smgap3x7oK4H1ImsFR4
 UZTbtiGS0AMkw==
Authentication-Results: thsbbfxss02p.thalesgroup.com; dkim=pass (1024-bit key;
 unprotected) header.d=thalesgroup.onmicrosoft.com
 header.i=@thalesgroup.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-thalesgroup-onmicrosoft-com header.b=CN2PNQUI; 
 dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iKWozWK+jmaVugsG97Fwt6FGLhiy1I4pAkvRnusy0/0O4/w6QwAzJNOCHJqpZ3jULPrZGSFyVy7nJfD2Rh/hQJc45xnFs1hyzRMt/r4mlA2NSDx495b4StOYnm9qdP8kUEc/Copog0xVnJM2JlSLOvZAXRbDfwloFe2xpgl+uUr0/yBEHNNpfNKRF26zpuMJLUsImc/myp8N1YUW37PYIFdlds3T3H77Ysj0hswOJj+Qb/wU3SmNsC9LskHnpvY2klxI9xfBfECeQqqEDDu4BILWMvVRDGjnhUa9E+jwwk+P06qV/o6QVQDjpRV7b3pJ6Nv4MybC24CIS0sov31ZHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XBxJ72FEr+rAN318i4wtzhYH/Xy1efYsEnStKSXc0l4=;
 b=O67O+7D4kqFzYqPo0+oomvM1vA2x2wa+UARfRZjuwE34zDmJEjZdqapGt52FqPf3RxdLZTea3XoDWAoFC8a2+LII90tLY9zkJETQcxMdQ94qNw8IXM1kK+uzs0xleFN4Rt3K+cpxHKF5bAaJX2ZEKt1RlmdzxOncDB0YT29S7y28KKcVc72faqyzLKA9boEDR97hao7cXSA+eNfuyKnGSzqVD6YVS7bwfob0UOTtGluxBSyW5RhjXgz6UAgPhV40yUkIewhQJgLxj9c6mUCiugNfu49iUDO//1ZgI/RvO7gbutyR5euf4yTzsOJ7ECvJAxnOq8tPwF9aMo1Wcct2Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=thalesgroup.com; dmarc=pass action=none
 header.from=thalesgroup.com; dkim=pass header.d=thalesgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thalesgroup.onmicrosoft.com; s=selector2-thalesgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XBxJ72FEr+rAN318i4wtzhYH/Xy1efYsEnStKSXc0l4=;
 b=CN2PNQUImedXE7Ns0cmbLCSYSbN00MKB7ug6udkm/Y0EvnoFzUjBJ+JexrA8ZkINjowzipLztOdYVegbBzn63oa+0LbHdJf8Ez8E79YoYYRj4BuI1hItId3pv1PDjhg5zKbxFNSQ7unzLMNZxMKp+Ca+mfepR4figDkndLDQEW0=
To: "ltp@lists.linux.it" <ltp@lists.linux.it>
Thread-Topic: [LTP] Need info on LTP tests that use /dev/loop mount device.
Thread-Index: Adj+iMU9fJ1gBi/0Soy30UMN7rFgYAAAhZHAACoYYgAAADl63wAKjouwAF3hx2A=
Date: Fri, 25 Nov 2022 14:00:46 +0000
Message-ID: <MR1P264MB3953102D31E45C35E8E34B1EA80E9@MR1P264MB3953.FRAP264.PROD.OUTLOOK.COM>
References: <MR1P264MB3953913324A116A1E9CADE40A80D9@MR1P264MB3953.FRAP264.PROD.OUTLOOK.COM>
 <Y34Ldi2CIHPYc8Hk@pevik>
 <MR1P264MB395376B3E3DAAA7E33BE24B5A80C9@MR1P264MB3953.FRAP264.PROD.OUTLOOK.COM>
 <MR1P264MB3233CF6C132C977798EB16819F0C9@MR1P264MB3233.FRAP264.PROD.OUTLOOK.COM>
In-Reply-To: <MR1P264MB3233CF6C132C977798EB16819F0C9@MR1P264MB3233.FRAP264.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=thalesgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MR1P264MB3953:EE_|PR1P264MB1999:EE_
x-ms-office365-filtering-correlation-id: 5c602441-3a97-49f2-6f6c-08daceed739b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bccqHMm5ADQiJrMozATy5InAo3xATouSDMoznxY60/2W+podaZTaaYyE3IZ/NabOD2wdxpiMYpZ3+/n/XamtYH7OTB7kuCZqo2Ii3NpM6Qd/VpWZpZ43/AQyZ/0PGd2eXkMB1YdGvre4wWlnn8LIJprBbiCcp6eecN7vLJCDQr3imzIRD+XqS2tnLLXULHZQS6yvLwk4odAtpecREn2dq+pUL66ePIkCOX40+TRmdEeAtregae6pWbeDpGI18fQeeMJFbsNFU/1AhfFXAgNacem1+6UUP3ZMZ3wcAxF7LhSQFA1xsSDT6aPg40+2S+VDWPNm4+cEZv18ph8Voh5hMi/bWoZ//+a4Znr9KEUo1FUgBYpJN6N6H/MoxmXNbuQMagmz88QbEdSLs9YIaXMRTcI2GEyFaXdud8ouKvHSEhyf0Ltl27sW3sWEmaez84JOo4zNSn0oV0V3zwcT2iAA7Hr2NYecSIqvtHEPOBXw78VqJYliuR0rvPkOXfFHnYbg+9igfyBG+bDhq2MqDkDrGw46CHmQoqRMVLFHbKRVr5n+6qE8IVUkSBVwJyf5j8nY3U9j7EHR7GSaIoCPTdw43Q51udh1vMZVj/VaroLOLZFqXK22gVw0jbYuQsNjVkzdbiix4hg7QxEbZ+GxRol9U+Cb6Oa631PUn9xnaQ40av8A/ZjAOqGMaCuk7FdQc6eEd/5W9PyXkU2WmTfulaE8h42D0zGJUBqjuPBz0UqBjxpG2AjFHUTRRroES1tcvO9QATMW8HP3ynlozHU5tTUZFw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MR1P264MB3953.FRAP264.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(346002)(396003)(39860400002)(366004)(376002)(451199015)(83380400001)(86362001)(6506007)(6916009)(7696005)(107886003)(966005)(71200400001)(166002)(38070700005)(33656002)(55016003)(9686003)(38100700002)(122000001)(82960400001)(186003)(64756008)(5660300002)(8936002)(52536014)(66556008)(316002)(55236004)(53546011)(26005)(478600001)(66476007)(66946007)(66446008)(76116006)(8676002)(41300700001)(2906002)(4326008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HzyFSvLPhHV5nY+ejWsRAQbA4LL4D8KoSAogy4NZphKjlEdkME/PxxfE70Io?=
 =?us-ascii?Q?7mYnfLW3qKH07xIZ0A51dpkc89HKArDYgxi6/V6zhpJ+6TpM1CaA22NR5Kh5?=
 =?us-ascii?Q?GcQ/kCYnMRsLqg18VoHwSfdoIo52qzkoZhMNvfs9ePRATIGKixt4RdbuFZOl?=
 =?us-ascii?Q?Uj668WhLg0Ooy0QlNxUzb5OVT72rvk6A4qEuUlDtaJQbDTuNmRzgSbohktcA?=
 =?us-ascii?Q?u8x9b100Xv5/vnidNF4zLwcD7ia148QFdmXKANlwSjd+EFsx9bJ5EchORsTZ?=
 =?us-ascii?Q?2Sw9aEGsRCHzjxv1ef4LWG10q/kwaO1l8frGv2pJvHGQXsNTPK8lqjLHLJtK?=
 =?us-ascii?Q?6VQsuI8yegiq8IlDO3LiAGl12XYbjcZ/wx9D6FJ/LXWuo4bHcdMakxeLTJ6x?=
 =?us-ascii?Q?/HKDJJmma6cGcQvb+4OE/OHNiMTIVVXkakzdvN31n+FzUqvW7eZpME9UenEs?=
 =?us-ascii?Q?29vO7QBGYjSufYpjs4hOjynwNZbMOWmo9kHT55AEl2UOgRiSA0+zTh9uOG8i?=
 =?us-ascii?Q?W04d8Rm+Ek8KLo7I4bLpRsTHEg1iAa9xeeKTHloL+MUBLiSeKjmmFw8ymbwF?=
 =?us-ascii?Q?rzHnR1IWl1EnrWgJa+NNLp1zMzVunWagFmRU6UoQp14mNXHa7Yd8ZXdZjJQe?=
 =?us-ascii?Q?hYrHlxOgCOmRxi2OpC+u6tb3N3wGZLQWF0wvH8ykf7ZDdOBIWlC7eyR1NfzA?=
 =?us-ascii?Q?yyot8A0a3B1hjM77BSgCXY1s/O7b9FK1dILbv16tpAGoI9GVVXQrzQKIGSuy?=
 =?us-ascii?Q?xSiTHEb26MxUAlXSrHUwZ0op1PGLyC7bFlDQkrcSkwN+Yh4cYQb4149vKYK1?=
 =?us-ascii?Q?Xvs3eNr7/Qul7zU7NE4r8tweDKCtsrd1bw5D/TAVAVt/f9rcdMibefgvn7wW?=
 =?us-ascii?Q?hbhFWf4TcT5ld8eihKDNxZ53cp6Lo2FLn7woLqzBNCOHXRLw4WDBoeGZoA+E?=
 =?us-ascii?Q?0UAoDa0g1rd5ErDxKqGgT+bfFHsUv/VopuItSphFZ0w8OfQUmDAZDxC1kIAh?=
 =?us-ascii?Q?aqLNv08x2Uh0RVOqI0DDShVFVHvMJa5MYUji0AnttN4+Dtg7MixQzBLlIm/H?=
 =?us-ascii?Q?yJw9v3MHhkKw0WAKKMe8shWjvgWmr+7IoDbbaqfzZXgTG4uY/YMgfOAC5tYk?=
 =?us-ascii?Q?afEdrtpwnSVYd/ubIbTXtZYpENMslmlUJ6woEXnjW/Nj5GrsGmRR1Erxt1Xm?=
 =?us-ascii?Q?Fjo2+2uBeLTMwd8Fs64cF4AJVvRUI8T234553zqfzSHOXuqWfo69r+6c/RaG?=
 =?us-ascii?Q?gwmuFaLM/cqbzwRBLKP1fHWH/PLGLTbcWdNZUT+tSRjo6Xs3KbbY8q6r7zAH?=
 =?us-ascii?Q?XpvZNY9HxJaA9wmdPqjkUUvXZQslbE7FGiPzUSV+01vmT2zojyjLiFD22wSv?=
 =?us-ascii?Q?fg2hcZkUmnXKU+BSO2eSMOkKv0B1vVf8za6GAWyQ0UoIvk+NW0fF7K1iMdzX?=
 =?us-ascii?Q?fAwdW9c1ALUKYgtYkfLZeKTl0AWAs157VOPyO+tYFCZ1LtKb9s615Wk8q8zv?=
 =?us-ascii?Q?vLkVW6gRjloBF/FLoBug16mdB/fxbi6EKwumfNPmw8oiO+5PpViULW9fkoEH?=
 =?us-ascii?Q?5JtP2c9+aWAk/iSR7UDz+ua4Uia0jm7p7POZ9QRPEQHicFqC5zH70h+N5Cq0?=
 =?us-ascii?Q?2g=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: Thalesgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MR1P264MB3953.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c602441-3a97-49f2-6f6c-08daceed739b
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2022 14:00:46.8171 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6e603289-5e46-4e26-ac7c-03a85420a9a5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zuj6AZkk8V3gArqhzKomtPH4OqCzqVB/U0AfXT3sMvxH3d/zZxKDWRYcj/IBDPH5tcYh4oZH59d/jpp1GqlII40lpHUJ9OfqcHDacrT7TJI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1P264MB1999
X-PMX-Version: 6.4.8.2820816, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2022.11.25.135416, AntiVirus-Engine: 5.95.0,
 AntiVirus-Data: 2022.11.25.5950001
X-Sophos-SenderHistory: ip=104.47.24.107, fs=565057, da=118099379, mc=16489,
 sc=6, hc=16483, sp=0, fso=117395716, re=142, sd=0, hd=30
X-PMX-Spam: Gauge=X, Probability=10%, Report='
 TO_IN_SUBJECT 0.5, HTML_70_90 0.1, SUPERLONG_LINE 0.05,
 BODYTEXTH_SIZE_10000_LESS 0, BODYTEXTH_SIZE_3000_MORE 0,
 BODYTEXTP_SIZE_3000_LESS 0, DKIM_SIGNATURE 0, DQ_S_H 0, HREF_LABEL_TEXT_ONLY 0,
 IN_REP_TO 0, KNOWN_MTA_TFX 0, LEGITIMATE_SIGNS 0, MSG_THREAD 0, REFERENCES 0,
 SPF_SOFTFAIL 0, SUSP_DH_NEG 0, SXL_IP_TFX_WM 0, URI_WITH_PATH_ONLY 0,
 WEBMAIL_SOURCE 0, __ANY_URI 0, __ARCAUTH_DKIM_PASSED 0,
 __ARCAUTH_DMARC_PASSED 0, __ARCAUTH_PASSED 0, __ARC_SEAL_MICROSOFT 0,
 __ARC_SIGNATURE_MICROSOFT 0, __AUTH_RES_DKIM_PASS 0, __BODY_TEXT_X4 0,
 __BOUNCE_CHALLENGE_SUBJ 0, __BOUNCE_NDR_SUBJ_EXEMPT 0, __CC_NAME 0,
 __CC_NAME_DIFF_FROM_ACC 0, __CC_REAL_NAMES 0, __CP_URI_IN_BODY 0, __CT 0,
 __CTYPE_HAS_BOUNDARY 0, __CTYPE_MULTIPART 0, __CTYPE_MULTIPART_ALT 0,
 __DQ_IP_FSO_LARGE 0, __DQ_NEG_DOMAIN 0, __DQ_NEG_HEUR 0, __DQ_NEG_IP 0,
 __DQ_S_HIST_1 0, __DQ_S_IP_1MO 0, __DQ_S_IP_HD_10_P 0, __DQ_S_IP_MC_100_P 0, 
 __DQ_S_IP_MC_10_P 0, __DQ_S_IP_MC_1K_P 0, __DQ_S_IP_MC_1_P 0,
 __DQ_S_IP_MC_5_P 0, __DQ_S_IP_RE_100_P 0, __DQ_S_IP_SC_1_P 0,
 __DQ_S_IP_SC_5_P 0, __DQ_S_IP_SP_0_P 0, __FRAUD_MONEY_CURRENCY 0,
 __FRAUD_MONEY_CURRENCY_DOLLAR 0, __FROM_DOMAIN_IN_ANY_CC1 0,
 __FROM_DOMAIN_IN_RCPT 0, __FUR_HEADER 0, __FUR_RDNS_OUTLOOK 0, __HAS_CC_HDR 0,
 __HAS_FROM 0, __HAS_HTML 0, __HAS_MSGID 0, __HAS_REFERENCES 0,
 __HAS_X_FF_ASR 0, __HAS_X_FF_ASR_CAT 0, __HAS_X_FF_ASR_SFV 0,
 __HREF_LABEL_TEXT 0, __HREF_LABEL_URI 0, __HTML_AHREF_TAG 0,
 __HTML_FONT_BLUE 0, __HTML_HREF_TAG_X2 0, __HTML_TAG_CENTER 0,
 __HTML_TAG_DIV 0, __HTTPS_URI 0, __IN_REP_TO 0, __MAIL_CHAIN 0, __MIME_HTML 0,
 __MIME_TEXT_H 0, __MIME_TEXT_H1 0, __MIME_TEXT_H2 0, __MIME_TEXT_P 0,
 __MIME_TEXT_P1 0, __MIME_TEXT_P2 0, __MIME_VERSION 0, __MULTIPLE_URI_HTML 0,
 __MULTIPLE_URI_TEXT 0, __RDNS_WEBMAIL 0, __REFERENCES 0, __SANE_MSGID 0, 
 __STYLE_RATWARE_NEG 0, __STYLE_TAG 0, __SUBJ_ALPHA_NEGATE 0, __SUBJ_REPLY 0,
 __TAG_EXISTS_HTML 0, __TO_IN_SUBJECT2 0, __TO_MALFORMED_2 0, __TO_NAME 0,
 __TO_NO_NAME 0, __URI_HAS_HYPHEN_USC 0, __URI_IN_BODY 0, __URI_MAILTO 0,
 __URI_NOT_IMG 0, __URI_NO_WWW 0, __URI_NS , __URI_WITH_PATH 0,
 __X_FF_ASR_SCL_NSP 0, __X_FF_ASR_SFV_NSPM 0'
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Need info on LTP tests that use /dev/loop mount device.
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
From: SANDUR Suresh via ltp <ltp@lists.linux.it>
Reply-To: SANDUR Suresh <suresh-s.sandur@thalesgroup.com>
Cc: GUPTA Davender <davender.gupta@thalesgroup.com>
Content-Type: multipart/mixed; boundary="===============1504191231=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1504191231==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MR1P264MB3953102D31E45C35E8E34B1EA80E9MR1P264MB3953FRAP_"

--_000_MR1P264MB3953102D31E45C35E8E34B1EA80E9MR1P264MB3953FRAP_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Thanks for the message Petr.

A follow-up question. Why only some tests have the all_filesystems flag ena=
bled? Why not for all tests?

regards,
Suresh

________________________________
From: Petr Vorel <pvorel@suse.cz<mailto:pvorel@suse.cz>>
Sent: Wednesday, November 23, 2022 5:30 PM
To: SANDUR Suresh <suresh-s.sandur@thalesgroup.com<mailto:suresh-s.sandur@t=
halesgroup.com>>
Cc: ltp@lists.linux.it<mailto:ltp@lists.linux.it> <ltp@lists.linux.it<mailt=
o:ltp@lists.linux.it>>
Subject: Re: [LTP] Need info on LTP tests that use /dev/loop mount device.

Hi Suresh,

> Hello,

> I am trying to understand the test cases that use the /dev/loop* device. =
For example the following tests use the loop device:

> chmod06, chown04, chown04_16, create06, fallocate04, fallocate05 and fset=
xattr01

> What is the purpose of using the /dev/loop device? Is it to test some fea=
ture of the FS which cannot be done with the currently mounted FS? For exam=
ple, execute the testcase on a RO filesystem? Are there any others? I am no=
t sure about this, but does LTP also do something like mount the loop devic=
e and put different FS, like ext2, ext3, ext4, xfs on the loop device and r=
un the same testcase?

/dev/loop is used for .all_filesystems to run the test on various filesyste=
ms
(btrfs, exfat, ext2, ext3, fuse, ntfs, vfat, tmpfs, xfs). But you could pas=
s a
real device via environment variable $LTP_DEV.

https://github.com/linux-test-project/ltp/wiki/C-Test-API#115-testing-with-=
a-block-device
https://github.com/linux-test-project/ltp/wiki/C-Test-API#113-filesystem-ty=
pe-detection-and-skiplist

Kind regards,
Petr

> regards,
> Suresh

--_000_MR1P264MB3953102D31E45C35E8E34B1EA80E9MR1P264MB3953FRAP_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman",serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
p.msonormal0, li.msonormal0, div.msonormal0
	{mso-style-name:msonormal;
	mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	font-size:12.0pt;
	font-family:"Times New Roman",serif;}
span.EmailStyle18
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:#1F497D;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:#1F497D;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">Thanks for the message=
 Petr.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D"><o:p>&nbsp;</o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">A follow-up question. =
Why only some tests have the all_filesystems flag enabled? Why not for all =
tests?<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D"><o:p>&nbsp;</o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">regards,<o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">Suresh<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal" align=3D"center" style=3D"text-align:center"><span s=
tyle=3D"color:#1F497D"><o:p>&nbsp;</o:p></span></p>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif;color:black">From:</span></b><span style=3D"font-=
size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black"> Petr V=
orel &lt;<a href=3D"mailto:pvorel@suse.cz">pvorel@suse.cz</a>&gt;<br>
<b>Sent:</b> Wednesday, November 23, 2022 5:30 PM<br>
<b>To:</b> SANDUR Suresh &lt;<a href=3D"mailto:suresh-s.sandur@thalesgroup.=
com">suresh-s.sandur@thalesgroup.com</a>&gt;<br>
<b>Cc:</b> <a href=3D"mailto:ltp@lists.linux.it">ltp@lists.linux.it</a> &lt=
;<a href=3D"mailto:ltp@lists.linux.it">ltp@lists.linux.it</a>&gt;<br>
<b>Subject:</b> Re: [LTP] Need info on LTP tests that use /dev/loop mount d=
evice.</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Hi Suresh,<br>
<br>
&gt; Hello,<br>
<br>
&gt; I am trying to understand the test cases that use the /dev/loop* devic=
e. For example the following tests use the loop device:<br>
<br>
&gt; chmod06, chown04, chown04_16, create06, fallocate04, fallocate05 and f=
setxattr01<br>
<br>
&gt; What is the purpose of using the /dev/loop device? Is it to test some =
feature of the FS which cannot be done with the currently mounted FS? For e=
xample, execute the testcase on a RO filesystem? Are there any others? I am=
 not sure about this, but does LTP
 also do something like mount the loop device and put different FS, like ex=
t2, ext3, ext4, xfs on the loop device and run the same testcase?<br>
<br>
/dev/loop is used for .all_filesystems to run the test on various filesyste=
ms<br>
(btrfs, exfat, ext2, ext3, fuse, ntfs, vfat, tmpfs, xfs). But you could pas=
s a<br>
real device via environment variable $LTP_DEV.<br>
<br>
<a href=3D"https://github.com/linux-test-project/ltp/wiki/C-Test-API#115-te=
sting-with-a-block-device">https://github.com/linux-test-project/ltp/wiki/C=
-Test-API#115-testing-with-a-block-device</a><br>
<a href=3D"https://github.com/linux-test-project/ltp/wiki/C-Test-API#113-fi=
lesystem-type-detection-and-skiplist">https://github.com/linux-test-project=
/ltp/wiki/C-Test-API#113-filesystem-type-detection-and-skiplist</a><br>
<br>
Kind regards,<br>
Petr<br>
<br>
&gt; regards,<br>
&gt; Suresh<o:p></o:p></span></p>
</div>
</div>
</div>
</body>
</html>

--_000_MR1P264MB3953102D31E45C35E8E34B1EA80E9MR1P264MB3953FRAP_--

--===============1504191231==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1504191231==--
