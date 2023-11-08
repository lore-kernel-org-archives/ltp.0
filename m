Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3657C4332F
	for <ltp@archiver.kernel.org>; Wed,  8 Nov 2023 10:44:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EE0AE3CE7F2
	for <ltp@archiver.kernel.org>; Wed,  8 Nov 2023 11:44:24 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8A45E3CA094
 for <ltp@lists.linux.it>; Wed,  8 Nov 2023 11:44:12 +0100 (CET)
Received: from esa5.fujitsucc.c3s2.iphmx.com (esa5.fujitsucc.c3s2.iphmx.com
 [68.232.159.76])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id BD3181000230
 for <ltp@lists.linux.it>; Wed,  8 Nov 2023 11:44:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1699440251; x=1730976251;
 h=from:to:subject:date:message-id:references:in-reply-to:
 mime-version; bh=LKft9q6qwpiLlyls7nrQuh44olYENEeorVeXrNGSTgc=;
 b=d53lS4nK+N2N0qAFqrXtEcfaCyskxMTdDXRn35t74eYrUDwchyXPPNG7
 vqU2d/g2l464eGuYDWvLagJlFp0h7RbQScE6M+binshy2tCrS5tP3EqHv
 6RoKI18mfLL76OfZGxLJ72C374tfIs3F9mzRBlue5qUzmHZE9Wx9VV0Mm
 267Z5qqZqhdtLDJ62WRVXswho493uG5/eROWI88B88If4PhmE7zT5KUG6
 PY+bxIsdSfyxp4k3SRC6E0gYElJIPbUTIHVfY/VF6cLZ33h3ByKI3DRBl
 vbBIIOtQTde3Vcyr8tZcw5v91j4Bk0HxKmOo5x2eShNMyF6Sx9X5WPxKB g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="102148359"
X-IronPort-AV: E=Sophos;i="6.03,286,1694703600"; 
 d="scan'208,217";a="102148359"
Received: from mail-os0jpn01lp2104.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.104])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Nov 2023 19:43:50 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k1dIhOdhpJ+37GFC6YvnsBYuJd0zfSICgBYkgRphalz6A/uQJMlji5PWP4eESHqk1kqOlmhuezrZd66q0x4ov96pR4AcB5RxrUpIYZeY9DTb4/8JUZJYDt9tz00R4iPYOgwwYyWlOTIOls0Sd6SbFSu1cZMTxLpPsgq/X5k9IR7Df1SdwM9wj4MPZ2Ci1yx2Ea+IthSsRwmwt7eWdKLieknEivsnNoCBskWLQtsJXy8railChlmx05VQOBqw5qyzmAFULPbSZYnOErMkiOaYjzeqYxHiiOFcxrhV40YuF0r6EPJeLN9mXWceI6lnsmf2Ceworw4IDC0bO3y3n2sB0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LKft9q6qwpiLlyls7nrQuh44olYENEeorVeXrNGSTgc=;
 b=AI7poy8EfO5Q2I3epn5MWDydGj9JCbEDLTaFXNusOQHDuxn3p1UcVyZKAHgHrX5BI8F6YzHENCO1KnBxHtR652JVMxsH9VXE9sGJDeCELyj6M67oM0iWRvPUDNH9rO3NZBwQgDx5/j9zzSyRUw6270zFoTsRDcBgEy7M62gMPAkmfkXsWMdPTLm+9g2UVLmGLl6pC8Iw5Uia3Fj7ctIySYiOcrskPK/NP2rtLvr40T4xcvQ295h+/DmqGtNbgoDVczZCdsfqzUOAA78vIlFmUc1cwa+JH9F8UEJi0tawulEQvd16uUUH6oSdWfgHMz5BmcHIjqryJ4HJA8wwA5t1TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB11829.jpnprd01.prod.outlook.com (2603:1096:400:400::6)
 by TYCPR01MB11372.jpnprd01.prod.outlook.com (2603:1096:400:3c0::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18; Wed, 8 Nov
 2023 10:43:47 +0000
Received: from TYWPR01MB11829.jpnprd01.prod.outlook.com
 ([fe80::ac5b:bf7a:d029:19f]) by TYWPR01MB11829.jpnprd01.prod.outlook.com
 ([fe80::ac5b:bf7a:d029:19f%7]) with mapi id 15.20.6977.018; Wed, 8 Nov 2023
 10:43:47 +0000
From: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
To: "ltp@lists.linux.it" <ltp@lists.linux.it>
Thread-Topic: [PATCH] swapon02: Simplify code, add copyright, modify docparse
Thread-Index: AQHaAlggSd/vck6ELUmBAWPIwy5hALBwW2n8
Date: Wed, 8 Nov 2023 10:43:46 +0000
Message-ID: <TYWPR01MB11829389879FEAE3AE05C1132FDA8A@TYWPR01MB11829.jpnprd01.prod.outlook.com>
References: <1697698029-31949-1-git-send-email-xuyang2018.jy@fujitsu.com>
In-Reply-To: <1697698029-31949-1-git-send-email-xuyang2018.jy@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=True;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2023-11-08T10:43:45.579Z;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB11829:EE_|TYCPR01MB11372:EE_
x-ms-office365-filtering-correlation-id: 5042cd95-41bb-4c5b-eb58-08dbe0479633
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R3haeMwI6cnKn9VUW5S/XpzqKj41PA73xn3h7O93nvi3WMWWMJGDalsyhpBq2nJairmrjOdmJEyn+CWnIBnks7UlsiYqdiVKPLnYDAzWAhJc3Vq+AGrGItgA08ImXHJxShXvoWZapySHdj/t6r0ZByRFsd5A0D7Ls4K+9iE7JbVWqEf0D0NXWx2vL6VRfQHm4JCQ6v6qXTypWYnyomvwFTOlcdrlu/ncUF+TL7hOACNg1j59baebBHKDhSes3iEBtSPODWjRSJPsbH/wx9+UUnP1YL3qoylssPzgQeYDv5rx73GXqF1fTzTKEysnZLx5R9e6FtDYsGWSVunhob18jhMQ8lpC1VqS7q8k9VWsn7yIlKF/AAaikgztsCcG7KqFpe2wXkS72nJ2Vy6S5D7RXmeoFZMKanacFCwp41tIcQLjUhMu2o0X4Hbek4nalsFoHVkt6GH8kQYpBU8FHttu1JeBZbjdqCa6djD4fdxF1waFyu1qtjzJEkEUaJGBk8mtuMMXC/UuADy1CsYEHnsy/cJQPwiD4dQswYJohp8w1CRBStboJpHsPRMRFM6hrTRa7fQaTiQYgdof8KE0o55pg+eUnC2lKW1fm6iHZuVBG1ualOTIFkJhStvP3sw7yjx4nTZzZk8kmj8hGIgu1sr3oQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYWPR01MB11829.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(396003)(136003)(39860400002)(376002)(346002)(230922051799003)(451199024)(186009)(1590799021)(1800799009)(64100799003)(76116006)(91956017)(66556008)(66476007)(66446008)(66946007)(64756008)(8676002)(8936002)(478600001)(52536014)(6916009)(316002)(38100700002)(122000001)(5660300002)(19627405001)(55016003)(82960400001)(83380400001)(1580799018)(4744005)(2906002)(26005)(41300700001)(86362001)(33656002)(85182001)(9686003)(38070700009)(71200400001)(7696005)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?VjRoQlNHbFhMaVRBcUJ3RWsxdE13aG5EL3A1WGJUaWFIMGhMbVByNUljNUFt?=
 =?gb2312?B?UGtHT2w1ZitWeUdaTEhPMGZxSDZzK21LTXhXOFRYQjgwNzZVZGhrVFk5bjBw?=
 =?gb2312?B?UWdRT0xXV0JBTU53UUVVSis0bkxXS3VkM2hwU3hBendOSXUyZkxPUVBzM2Vh?=
 =?gb2312?B?RmpGdE5tYzhLN1RTZUJ0NjBnSjFLaWtOTzdSRFE2aVVyZHF6eHQxZ3lXZVVs?=
 =?gb2312?B?OG1Dd1g3dzFzdmFZbTVMbW5ZcW1zeXRaTXcrQnZZcUlzVGRGNEcwZkVrdzBx?=
 =?gb2312?B?QXdtaDBibUpIWFdocmw3U2FwWkNIejdvZ2hMdFk2Y0xEclBGamFidjVINVpN?=
 =?gb2312?B?RnIxWXc3WHV6RnY3Vm9WMUQ2a1dDbWQyZkpVNW84MGxqb3V0ZmcwNHBJMTZj?=
 =?gb2312?B?NkdLamNwTDY4QzkyU1RrUXFaY0w3NU5CdVJMdU0vajIrSWVPcTF2a21PQ0Ey?=
 =?gb2312?B?N25TTkFUV1NjUU42K1NMSTh5V2pmaHRwTlhzWHEyV3l6M3VhRzJlS29QRHp5?=
 =?gb2312?B?akt4K2RaWkE4ZzNOaVpzQ2dQcEhGd0xPZmpuWXJPclFoZExLcHozRk1lTDR3?=
 =?gb2312?B?UTFMWXc4bGJJbEJtTVJuTlI1em8xL1cxR1pKWHdJaTgydm14dXk1a2xacmxh?=
 =?gb2312?B?ejh4emZCNDArV0crdjgyb0JMYVZsdk4ya0FaOW5QMVpNaHkvVDA2RmdrVDAy?=
 =?gb2312?B?Q3VIc1NNamhpU1hvQjFXeGUxOGhUVTk5dkRLKzVQNzhiS2oxbXlhOXBVWGli?=
 =?gb2312?B?cEl1V2N0cnlFR21sM2w2WGhKZlBKWXBRdzdaZkhYWkxiQmQ2QmcxSXlxMlVI?=
 =?gb2312?B?ZHFBNW56enRjVnFlZXQwL3BCMGZrdzcvRm04Y0hmUmNIQWI2WWRLNzZzbFY1?=
 =?gb2312?B?U2ZJYXlZTi9KajVjVllCZ2UyTUJPUEYwenBpNThVdlBKK0VBWDV5Q1NvT0pY?=
 =?gb2312?B?TVNKNmkwYzNRekJMTDcxZS9NK0FxMGVKSWdTQ2R6ZDZnS01GTitRWDBBR1ZY?=
 =?gb2312?B?Wm5oRWdjY2hueUdiTDJWYXZJUDR1ZWdiczJxakpGV205M0crSlVISHI5QU40?=
 =?gb2312?B?MlVXY0poSlpucmpMNERzbWNQS2xvaEV5bDRYcXplRkhQNVkydVBWUjNhMEJG?=
 =?gb2312?B?Q3dHeVJlYUJrV1dtdjlSaEJIMlRtdlFHdk5rMURHQnI2YWE4Y095VXJEOFZ1?=
 =?gb2312?B?S2JSYlNQQ0Z3SlZDYTd2dGhOL1J0L1RzbHRDaEdrVVRSR2MvSzNyaldwZnJ2?=
 =?gb2312?B?NkxrUTZqc3Zpb2cwSzc4MkdFZmFKS1ZvUTRhN2RIVmhSVVhqODZqU1hFZnNK?=
 =?gb2312?B?enpzUmVWN2dDQWpMU3NRaHNPUi9SQzh4dGdhUlIweHpFaGRucmNiSE1oMHEr?=
 =?gb2312?B?emVBMzNwOERsTHlJNHpxUWN5dGZ0a2xXK09vVjRpZlo5bVplaTRHNlErNDhH?=
 =?gb2312?B?MFo5dVZrUTBKRlpWcWd0aDN5bXFxNmZSNGR5NW43SzlNNFlvZ1dMR1VtV1pq?=
 =?gb2312?B?Tkpic3dFRW9ZalljUVhGbUF4RDlRWUNZQ2pSL29OdUJVazhQVFRLTUY5ZUxt?=
 =?gb2312?B?eFdhTWQ0SU9iayt2ZXV3Mkora1V5REJYczBUUURtL3gxeTRnYkdHNkpWRnVn?=
 =?gb2312?B?NWRaUHFEYm9Mckl4VDhGSXRIK1ZtaDh1dGhDMm1JRU9UeSt2QmpIRDl1dzFl?=
 =?gb2312?B?dTJncWhQT3Q3am1jeTlxR2xOVEhKcmhodzhSZTFwaFkyd1JMM0lhL0FGcExh?=
 =?gb2312?B?MytDSzhNUmp2TU1xUmNvR0UzN1EyU0lhSEZnUzUrOVp3NThnYjhBaUJrM0xr?=
 =?gb2312?B?cmJhT0Z1N3I1TW9hR3kzYmxISno4a1g1dExvaEJIZzgzdlRPNGZxRGNNWDcr?=
 =?gb2312?B?MFVHYlZSNkF0ZHFKQUNjbXB0QjREVDF1bTZVZFBaelhPS1FvdEZTdEZBY3VJ?=
 =?gb2312?B?Q3g3NGJvWjFlZFVJVi8rd3lUb0J0UTBTa0pwZTJHZklJdVYwUTQ1dWY2OEJR?=
 =?gb2312?B?VkJ0SWJWckpRQWVIOVNlUzBHeVBUSStUVFJLdmQwZWFxSnVxRWw5dUtuYXY0?=
 =?gb2312?B?M1dLeDA5blpxaThsTkk4bjhGZTlkQnNnQ0dWNStyamhkY2lYdXJqMHM0NjVi?=
 =?gb2312?Q?LDJ00WeUCBEbn9FjV8XcoefRJ?=
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: RY61i0Z01Von/f4bx4J8pTkQ+8yh5o9jpmxnGpLo0ku9iJMmsNvmVxFNWDMrrYUfl0evaQ57USWkPbp+eNgT/hjN9iJiCJx73XFoABiShsqHZyt5iPhBICsTs0G6UiVQLrb0PV/wREjQxAybIEk3tJFhF4fECHwXABzusfxByidZdANjeNn0GHhotH76exAJAlb5Y232m9AjZInQx81pjSU7EQ9e/CPdS++s/ti2AlJaPoArpsX+3LkXec/KaEWj5dkYcXjS9czoC9j4DopHsrLKh0gbLWj2oeHV6aQtKU3Ivo2gNoKKi9GFECzmYYUyVe6yT+zNyd7Z5xiHzsntFd4m216Z3f2rqfEmUhdPwZO/aRVIoDNjt6srEnl+9tmhTWbRQC8qbxugzUcgF1Yzg5MJ8EpaWtJRHMPD1z+Kvj10tKaSNMv0s5lhzaC1MG9CRZOEVcG+P76OLv/LV/YLlBKSHarS4S3d/MGNEtDDVNcwlr4jqLCxCR7b7pWc7GaWxC/LkBxJxEOaWQZKomrNxmo+bgNrHKrYOTwB/TjCHyp6zTIub54xQjrDsfmsGwhSPWDzgFAHvlVvoP+rPgJvTN5OEyTgcwBy9TClF+EOqYn06vCbYRas4x3ZDFr9CQ0l4jnauxmnUaYES3D57b2JYbzVoU72rhFEuAHherdw+1O0ei3whgSDJvmuaj+42RtpYbuG/gmnvHzbVj+VArD6ipZGjrM35Gb/fUmLKwe1tQ6EtxNExC2zLpDdls7mmWFt0IJvazOTfGFKl9ReSjPHfA==
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB11829.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5042cd95-41bb-4c5b-eb58-08dbe0479633
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2023 10:43:47.0032 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QfCuQPvYIcMXYaJj9dxZsrHlLodFujRyqBGQAAHJLD0A1Q6ZIJya9MmkbknhCV0brVQDOxTfmWw2mzLa4C/oUhMnSJcScazzoM7ux1jOblk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11372
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] swapon02: Simplify code, add copyright,
 modify docparse
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi

Ping

Best Regards,
Yang Xu

>Simplify permission-related test code, making structures look simpler

>Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
>---
>testcases/kernel/syscalls/swapon/swapon02.c | 57 +++++++--------------
>1 file changed, 18 insertions(+), 39 deletions(-)

>diff --git a/testcases/kernel/syscalls/swapon/swapon02.c b/testcases/kernel/syscalls/swapon/swapon02.c
>index d34c17a80..2c9e39986 100644
>--- a/testcases/kernel/syscalls/swapon/swapon02.c
>+++ b/testcases/kernel/syscalls/swapon/swapon02.c



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
