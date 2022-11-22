Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57DA5C433FE
	for <ltp@archiver.kernel.org>; Tue, 22 Nov 2022 16:00:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 838263CCAD9
	for <ltp@archiver.kernel.org>; Tue, 22 Nov 2022 17:00:19 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3C8483C06C8
 for <ltp@lists.linux.it>; Tue, 22 Nov 2022 16:56:38 +0100 (CET)
Received: from thsbbfxrt01p.thalesgroup.com (thsbbfxrt01p.thalesgroup.com
 [192.54.144.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A46A7200245
 for <ltp@lists.linux.it>; Tue, 22 Nov 2022 16:56:36 +0100 (CET)
Received: from thsbbfxrt01p.thalesgroup.com (localhost [127.0.0.1])
 by localhost (Postfix) with SMTP id 4NGpll5s4Qz45YQ
 for <ltp@lists.linux.it>; Tue, 22 Nov 2022 16:56:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thalesgroup.com;
 s=xrt20181201; t=1669132595;
 bh=/mpgFoDP0F2y9QH1+NgWP3/YTFkucr7dHvK3AeT+a6A=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:From;
 b=kn9V8nKaLLWwDufziZfxgCQ8lyHc5MyjBKb7LhHI01z2rtShGjoXl7Dyg/7/syG4O
 z1If1PvbObF8Csc9Gq0NlOzAY/pE+V++0MHUPMKuHihq/8QQRmUpf7blHGwCU8lvaX
 SQn6Zu7+NpcjmP7rQmfkUGEhItgkJiaqmSsyurSC88FRgPNUM2RDcHx4lnlF9MXaVu
 a1Zh2yhs8STMhki33cdnzC/zhgNJe0hoS7mPp0Co7Hi0uolDcW4hcaI4MzT0rKxhlP
 TDdyUCJJrdsORgTP+2XFhZmCG/XSBlYfboeqLachKJeJ2dh4eaBWgtA7XyHbS+fF0M
 Zau49YEfdmfOQ==
Authentication-Results: thsbbfxss01p.thalesgroup.com; dkim=pass (1024-bit key;
 unprotected) header.d=thalesgroup.onmicrosoft.com
 header.i=@thalesgroup.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-thalesgroup-onmicrosoft-com header.b=lzNCfqrm; 
 dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f48FPfXnDHaJFSiSUNPWc5lJLfSihVgXnA1AHRb9JHL+78ix9RMqYyJVpcPqMLrPZTT8vAsyTApnK3RPJN7Lm29gsVncAy2dEf7D2WLPvt7JIpV392ltk/7j28cxlzvb/YZhG37sgYM1vkCt38cWXni7TztKvcFWRFmjr9PLOwLBRUKflrlOsmkEmvdkrPHkhebYrzChrnpAtRFNCNIHj/ced8mFqvdkbh6wyxDUeWt1SmV0or4NkqaPif2y87/0Vp/8KI7SPbAxcv030Ol24H8gJflwrZbnh1gKHzTllc0wh2jgX2WRD373QIXLiAryAFUJjCJhgl0eb9FYueBqig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/mpgFoDP0F2y9QH1+NgWP3/YTFkucr7dHvK3AeT+a6A=;
 b=GZDw33BiaLvvwU/MGZGJ+jFiJseTwJoE0WCSNlzV1AfIVzh6P+m2A7pvj2FXw8JP43Zdzy8UOY8YUR7SM038WdqF+W0kKFkcXt3UxIPEsvfPV0tJbD13nQvAlBOu304DXHwulo67i9zfrPhZtt3+Q3u8nW/dB3VaNfBpEDkip1/7Rxqiuhcpp32pVHBMQ0pxvrmHASR9DWHdQ24c5e9uMzEAv+CK2o0BqgT9Pwy54YvmxD/AnhylyEbyS7NLSlN8koOBOt3bA2GJoOfCQX8bHfWXbqgdw46YaQdYVdKkR5R00HJGKLhD7nzJ66QOGBaKdvA+yi+2vvkMRs20qKygaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=thalesgroup.com; dmarc=pass action=none
 header.from=thalesgroup.com; dkim=pass header.d=thalesgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thalesgroup.onmicrosoft.com; s=selector2-thalesgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/mpgFoDP0F2y9QH1+NgWP3/YTFkucr7dHvK3AeT+a6A=;
 b=lzNCfqrmkST09CCnU+NEWtM0FGn8iDSfJg6zuVdHBc7l4G1Tb+WTwAFi1laVGBCg4xhIGYQqwIuEUrIxWRwbkFg4fTMOi/7aa6aTJrRuzoANcs/f06p4ybuFIOKTU/6D0IzWJP9Zsl+ag6gkXCqDbKVJuQl4YGqABgz9ReBlOoE=
To: "ltp@lists.linux.it" <ltp@lists.linux.it>
Thread-Topic: Need info on LTP tests that use /dev/loop mount device.
Thread-Index: Adj+iMU9fJ1gBi/0Soy30UMN7rFgYAAAhZHA
Date: Tue, 22 Nov 2022 15:56:33 +0000
Message-ID: <MR1P264MB3953913324A116A1E9CADE40A80D9@MR1P264MB3953.FRAP264.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=thalesgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MR1P264MB3953:EE_|PR0P264MB3189:EE_
x-ms-office365-filtering-correlation-id: f8229c74-6fc8-4323-5b4b-08dacca220e1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eFx/lu81oYw7aL2P9KwqlzYEJJsvUHlulYE9ch7zDpcJoJMFWA21fZuBFWBmOPbyBnXivLTG1funa/ZMB0vhABmyErX3XnU0QOIBcoHB8VKj6mlsKYwG8I4G89G9SJLhNc0dFjAXoMXkaKR+UfayRqxZOGXiXseeOBrxyOmUMQqpvzWps4MKb4KeMUmviHHz1+zsTomuGS/7Dyv2azFnZ4tVD26ayTaGg0HXF3aUNU1NDLPhqSmwI521ZSbWCTQtmM5Lde9kJnh/N/bGnA5RWCj+Vg1VA23+CZCnW7W0Z2jlY+KFQ/CPztWLrmRhu5JPIkXIS7qlyA96cev5zBD0e7HyhcSF6ppAhNxM5Q+rc527m62uu+qktPrfUAPfAUCJiUt7+XvLdXcIf8mfiBdHv7Tf2kduXz5EH0mxNPeG+zHt9aALp08SJk9+esgDb0RVUSCzLLmK5QiKzSWGRI6bHS0YLThKwNlvkCp9ZmtdmhyQP/GvcNICUeC0gafkOhIOQa8mHVIOYcC6p/BtTrGEE5jqGCOR16PM3HBd4dbjimo6pdT2qO2QgJrQ4gYyEp84LsDbFwCLBDurYi1KO9YDi8+lCOy8FT95UQ1XbdJoFtJgRKpj35TpcKQ0D/ciZYCOjZGuANIeyJGnJQ7jsQn9MuYiVnUW2+Fe7StutNnPK2G7Amx5oXHKbNIQdlQLxhy5cInyjvAsYfK26jm9VNH4PA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MR1P264MB3953.FRAP264.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(376002)(39860400002)(366004)(346002)(136003)(451199015)(9686003)(82960400001)(122000001)(186003)(76116006)(4744005)(55016003)(64756008)(7696005)(2906002)(26005)(38100700002)(55236004)(5660300002)(6506007)(71200400001)(52536014)(6916009)(66556008)(8676002)(478600001)(66946007)(316002)(8936002)(66446008)(41300700001)(9326002)(66476007)(33656002)(86362001)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lxrxyfWEj5XFyfNViB6rVjoDDeY7uoqA4oIFj95ldVPMRIrjgi6ru+w0DLs1?=
 =?us-ascii?Q?PP2dZcOrNAQJ37Q/uuY8UXYPBhBuSJx/82GQygLiuTCanqdaDCJFpnhVuN/r?=
 =?us-ascii?Q?Y/mwZns3wF/LQLUCcDlaUYDylb65L3wFBx9ZZDhrIkzNxHduGEqroV9Nof5G?=
 =?us-ascii?Q?dA0rXED7BPtRNlAkV0BVej4O3K2tNbMb40nCpJbTu6iADSZAfgUF2csCgMVR?=
 =?us-ascii?Q?079+wpKo0VnEbjyE2frxAvy14ZkNKkJ6TO7U7OsX8/1SmCaqFHzAMeXbrdhl?=
 =?us-ascii?Q?N/eEbX792ruitzw9mdo3NqtH40BiuzsS6HQ0+d/O1CJc++yGCB5nyEgWElPb?=
 =?us-ascii?Q?UfDMEfoSpgJmlpW0f43s5qSk0sjsJyOhcEpY3in5B6V8BFoQUjYi6CVwPI20?=
 =?us-ascii?Q?NApwMSZ7zW0VHXBEYrX/3kzllzqfG4Z8DdCPgvc/maZb321u73st8z9Upqog?=
 =?us-ascii?Q?sLEuNyY3qWslpyohKN6AAqxxLuyhWtqr9URaWzTR6baFRk31+hsCuyMSTszI?=
 =?us-ascii?Q?xjSe5294vE3NKf18Ew3jk9w5l2ujKVhNKV8M7x2bKgWAuKLxd3neJf9PkxiD?=
 =?us-ascii?Q?lVDrYdwr4eF8xP8MX7mIiOO5u0KMpVCYIH82IiQT/5FoT1cPEKvHS+QjCUsD?=
 =?us-ascii?Q?yLJLs24HpOQAZeHb8RxQI6d53CTR59QaxYS5xdcJJay2Px6YY/yfFwSVhAzE?=
 =?us-ascii?Q?Ip8O0WWVLMTXZzThyDwcAINF64eIz21aY4R4HKYeCF6n5Ivmrruv+J2SkO3O?=
 =?us-ascii?Q?SB1REjBElavsH3DJ0/QJkgdvmXTSxKKOn7QqXqTOM8eeqWTmFY7yP3i/u3xp?=
 =?us-ascii?Q?obBaEnen0vh7Yf9V9hFUsEC7T3odcWWHFNgLmYN3v8sifDu5FDbKi50G6szx?=
 =?us-ascii?Q?dgXhiVhHOKQYROzy7nBQqFX8HIfHYjX8B3FVEvnybugIn6Uo78sSWzD/r62j?=
 =?us-ascii?Q?V33OCliLCw1JW1fXdyvsaIAZ9KbAom0epNrC3pQM7SqtrppOPqcXNIJM8NGF?=
 =?us-ascii?Q?QOyrKq6BBhCEFwG4D5OF+K6cqralkuqO0OOgZimCnz4ducNp3pLfRzoQbNuZ?=
 =?us-ascii?Q?dEDnAoO6RgYEK8zpA9eY+Wm7UZgIMhXWbGdh6wBqqkjCpcMi38196ZiQh6Zh?=
 =?us-ascii?Q?ttmCuSKSbcJmOwjb8TJ1cVTurGx9XS3B/l0Ps/gZZUUsuvgNBEBdPFL9wj6z?=
 =?us-ascii?Q?OKm7c+A0wsVqpGdVdinas7Jt8bV4ns1rBF6yPoRcxUENfawmalyFM5dmTmg0?=
 =?us-ascii?Q?twmbCkttPrYtLq9xaAIqS+In1ssOdjyVZ6Xt/dLjISe5p4g8hydoAdMsO3E7?=
 =?us-ascii?Q?aDp6CCcQyg2g1fLfmIU1lGLc+Wdmadi2RJYabxtC79HsqMjA3wUeJZzz9oxZ?=
 =?us-ascii?Q?SW2otk1dD7YHVdXmhAPsyadmLfrBpfXidyWyTJJjTfuJhHSYgOxmLaf82Fn2?=
 =?us-ascii?Q?Pv73xRkApTbt09N/Y/7NMcjzfKd+hGbgxFa9PG/NXyVAIgRYfTV70f7mJR0l?=
 =?us-ascii?Q?pk1TxAzBWXpWlIDGUlxByRZ1NWUX6Z36j3qovUhT2hin9n5KeW6QsfVKIAm9?=
 =?us-ascii?Q?l6rw3UE9gV37WjHJcWIorO9LJbmQzFERRhJTGgSIYzte1mFZYKmYBbkUNbEd?=
 =?us-ascii?Q?uw=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: Thalesgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MR1P264MB3953.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f8229c74-6fc8-4323-5b4b-08dacca220e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2022 15:56:33.4598 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6e603289-5e46-4e26-ac7c-03a85420a9a5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8SkPsa9E08KSYafMAahZOz0SY5dOc3ybR8jqgi0rKqh8bOQQ6J+dsVGaabTsuFCU35Zowlo1xiyPObrcy8j/sCbbMdrC4+zH9FXqJrIMkPs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB3189
X-PMX-Version: 6.4.8.2820816, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2022.11.22.154517, AntiVirus-Engine: 5.95.0,
 AntiVirus-Data: 2022.11.22.5950001
X-Sophos-SenderHistory: ip=104.47.25.100, fs=399277, da=117847125, mc=10232,
 sc=1, hc=10231, sp=0, fso=116752868, re=133, sd=0, hd=30
X-PMX-Spam: Gauge=X, Probability=10%, Report='
 TO_IN_SUBJECT 0.5, HTML_70_90 0.1, SUPERLONG_LINE 0.05,
 BODYTEXTH_SIZE_10000_LESS 0, BODYTEXTH_SIZE_3000_MORE 0,
 BODYTEXTP_SIZE_3000_LESS 0, BODY_SIZE_4000_4999 0, BODY_SIZE_5000_LESS 0,
 BODY_SIZE_7000_LESS 0, DKIM_SIGNATURE 0, DQ_S_H 0, KNOWN_MTA_TFX 0,
 NO_CTA_FOUND 0, NO_CTA_URI_FOUND 0, NO_URI_FOUND 0, NO_URI_HTTPS 0,
 SPF_SOFTFAIL 0, SXL_IP_TFX_WM 0, WEBMAIL_SOURCE 0, __ARCAUTH_DKIM_PASSED 0,
 __ARCAUTH_DMARC_PASSED 0, __ARCAUTH_PASSED 0, __ARC_SEAL_MICROSOFT 0,
 __ARC_SIGNATURE_MICROSOFT 0, __AUTH_RES_DKIM_PASS 0, __BODY_NO_MAILTO 0,
 __BODY_TEXT_X4 0, __COURIER_PHRASE 0, __CT 0, __CTYPE_HAS_BOUNDARY 0,
 __CTYPE_MULTIPART 0, __CTYPE_MULTIPART_ALT 0, __DQ_IP_FSO_LARGE 0,
 __DQ_NEG_DOMAIN 0, __DQ_NEG_HEUR 0, __DQ_NEG_IP 0, __DQ_S_HIST_1 0,
 __DQ_S_IP_1MO 0, __DQ_S_IP_HD_10_P 0, __DQ_S_IP_MC_100_P 0,
 __DQ_S_IP_MC_10_P 0, __DQ_S_IP_MC_1K_P 0, __DQ_S_IP_MC_1_P 0,
 __DQ_S_IP_MC_5_P 0, 
 __DQ_S_IP_RE_100_P 0, __DQ_S_IP_SC_1_P 0, __DQ_S_IP_SP_0_P 0,
 __FROM_DOMAIN_NOT_IN_BODY 0, __FROM_NAME_NOT_IN_BODY 0, __FUR_HEADER 0,
 __FUR_RDNS_OUTLOOK 0, __HAS_FROM 0, __HAS_HTML 0, __HAS_MSGID 0,
 __HAS_X_FF_ASR 0, __HAS_X_FF_ASR_CAT 0, __HAS_X_FF_ASR_SFV 0, __HTML_TAG_DIV 0,
 __MIME_HTML 0, __MIME_TEXT_H 0, __MIME_TEXT_H1 0, __MIME_TEXT_H2 0,
 __MIME_TEXT_P 0, __MIME_TEXT_P1 0, __MIME_TEXT_P2 0, __MIME_VERSION 0,
 __RDNS_WEBMAIL 0, __SANE_MSGID 0, __STYLE_RATWARE_NEG 0, __STYLE_TAG 0,
 __TAG_EXISTS_HTML 0, __TO_IN_SUBJECT2 0, __TO_MALFORMED_2 0, __TO_NAME 0,
 __TO_NO_NAME 0, __URI_NO_MAILTO 0, __X_FF_ASR_SCL_NSP 0,
 __X_FF_ASR_SFV_NSPM 0'
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Tue, 22 Nov 2022 16:59:59 +0100
Subject: [LTP] Need info on LTP tests that use /dev/loop mount device.
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
Content-Type: multipart/mixed; boundary="===============2003725247=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============2003725247==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MR1P264MB3953913324A116A1E9CADE40A80D9MR1P264MB3953FRAP_"

--_000_MR1P264MB3953913324A116A1E9CADE40A80D9MR1P264MB3953FRAP_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello,

I am trying to understand the test cases that use the /dev/loop* device. Fo=
r example the following tests use the loop device:

chmod06, chown04, chown04_16, create06, fallocate04, fallocate05 and fsetxa=
ttr01

What is the purpose of using the /dev/loop device? Is it to test some featu=
re of the FS which cannot be done with the currently mounted FS? For exampl=
e, execute the testcase on a RO filesystem? Are there any others? I am not =
sure about this, but does LTP also do something like mount the loop device =
and put different FS, like ext2, ext3, ext4, xfs on the loop device and run=
 the same testcase?

regards,
Suresh


--_000_MR1P264MB3953913324A116A1E9CADE40A80D9MR1P264MB3953FRAP_
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
<style><!--
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
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
code
	{mso-style-priority:99;
	font-family:"Courier New";}
p.msonormal0, li.msonormal0, div.msonormal0
	{mso-style-name:msonormal;
	mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	font-size:12.0pt;
	font-family:"Times New Roman",serif;}
span.EmailStyle19
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.EmailStyle20
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:#1F497D;}
span.EmailStyle21
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
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span lang=3D"EN-IN">Hello,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN">I am trying to understand the t=
est cases that use the /dev/loop* device. For example the following tests u=
se the loop device:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><code><span style=3D"font-size:10.0pt">chmod06, chow=
n04, chown04_16, create06, fallocate04, fallocate05</span></code><span lang=
=3D"EN-IN"> and
</span><code><span style=3D"font-size:10.0pt">fsetxattr01<o:p></o:p></span>=
</code></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN">What is the purpose of using th=
e /dev/loop device? Is it to test some feature of the FS which cannot be do=
ne with the currently mounted FS? For example, execute the testcase on a RO=
 filesystem? Are there any others? I
 am not sure about this, but does LTP also do something like mount the loop=
 device and put different FS, like ext2, ext3, ext4, xfs on the loop device=
 and run the same testcase?<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN">regards,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN">Suresh<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN"><o:p>&nbsp;</o:p></span></p>
</div>
</body>
</html>

--_000_MR1P264MB3953913324A116A1E9CADE40A80D9MR1P264MB3953FRAP_--

--===============2003725247==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============2003725247==--
