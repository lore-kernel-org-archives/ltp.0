Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A3D9C433EF
	for <ltp@archiver.kernel.org>; Mon,  6 Dec 2021 06:09:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7D3C03C1C82
	for <ltp@archiver.kernel.org>; Mon,  6 Dec 2021 07:09:52 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F3E9C3C0480
 for <ltp@lists.linux.it>; Mon,  6 Dec 2021 07:09:42 +0100 (CET)
Received: from esa12.fujitsucc.c3s2.iphmx.com (esa12.fujitsucc.c3s2.iphmx.com
 [216.71.156.125])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D76B460084A
 for <ltp@lists.linux.it>; Mon,  6 Dec 2021 07:09:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1638770982; x=1670306982;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=QujIFy++wvozX9aJNZuakQci9W8wbdpUYuyDQ3e+xIQ=;
 b=IG4SHgYJFBVSkxwkC3zFAx3KjOX/0TQz3c9aVJwGZowzrzMrM1mxH2Qf
 9s7uPv7IQ4OC24ksoLxn7nwq9wr+9e86aziN0nmMXrN1Y3ZztG6ypd5Q1
 MxI0vbLulZ+NekFfpGGsp4/1K4plZJNkDw9iFgvto2rJWMNNs4QHFKHkr
 bc/NMx2VUrtJCgiIa64nlmS47WhZhuhXTKoCF7xFfIN2/9FaPsZAmWoui
 gL0/PGQsEByqbsvUaFTuI0YkrXXLdoGQif/HsKk/uVOL5ZZeA+CU1rfrL
 ajyfLskU4QCZKaC4k9bX6lxLLHDj6nwcbxCPq/kvHlYzoBmm6CGVVRgd7 A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10189"; a="45409289"
X-IronPort-AV: E=Sophos;i="5.87,290,1631545200"; d="scan'208";a="45409289"
Received: from mail-os0jpn01lp2108.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.108])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Dec 2021 15:09:40 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NPgDAnmirHc1LCdPoXH0/JpUs6GBIthgm3GQbLF8UOKIRWTf/ms7Nl2lWm8FUz23Vqk0IWhkcyLBHgKIFPlXJ056XjFvocsaa9qdgjiYIfSU+1h9QGclgjBK/hf7eYV0lwsQ2iY8zndi0vrT5A0dpawfwv8ivhThkcHLtgR4bpeqmPC95pKKDw+HMsaoOfZIlmNovdvoNbh+xCfUxkKRB3q5MOMFFg/wZrsAiS70+O7mlXGNnvf0YAowIJmKtRryhe/L28189/lZX3zIvKEpngktbetQvYfZd4t6HeAlgS6JTdzzYTu0eEBYJOz7bZxcZbLttQmQJYKtzmEjc/ethw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QujIFy++wvozX9aJNZuakQci9W8wbdpUYuyDQ3e+xIQ=;
 b=R5qie0X4oZKhQ3jFgpqfjuTodv64Wfi1jHLiaV8ziRQucI+Lx1tMR52SdBwBFRkDTGUnG4v/t6Qx36MKYu/3HrG5RQY6zptSK3/MoijRxiOlWcMoAehlHlqQtP0JDujciVs2VgA0by53PNYgXD6Kmtt1sSNBuONWvxv/nHlptrAjIDtC0+KW9ezXmJe3Fuzv4HnsC8GFORnLZRFUiysaFkI2XkJ4dg87FjOfgJRzlhzuI8Te1k1/UTOsBMLgOBjRtZE176aUyVK5cViWEAKlQxK9W5IZdszB7UcFpuqZ41UDamZ8rokm6UCz/AcHBLcz2pYr0nSKq/3FbGElQYKsIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QujIFy++wvozX9aJNZuakQci9W8wbdpUYuyDQ3e+xIQ=;
 b=lWRM9v6EGPLtPTs6wgykImB5HMhcrgk49rgAHmsZYkXdCqLmzF8qDQ3XFj6T1HPUeQWVMePVnc4hSmWrbKxQH4gEepl80ADV9W76TsFkBZlTlmOnD13rSAPfJu5XW89yvaT9Jc92u1QkAnKifdmPSg6UhvRY6hbO5j3DVZ8dtcQ=
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com (2603:1096:400:98::6)
 by TYAPR01MB5755.jpnprd01.prod.outlook.com (2603:1096:404:8054::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Mon, 6 Dec
 2021 06:09:36 +0000
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::4997:e3e6:6502:9100]) by TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::4997:e3e6:6502:9100%9]) with mapi id 15.20.4755.021; Mon, 6 Dec 2021
 06:09:35 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: "daisl.fnst@fujitsu.com" <daisl.fnst@fujitsu.com>
Thread-Topic: [LTP] [PATCH 2/2] syscalls/fcntl13: Convert to new API
Thread-Index: AQHX6B4XqdyqMXJCNkSqIv8rySFBV6wk/36A
Date: Mon, 6 Dec 2021 06:09:35 +0000
Message-ID: <61ADA929.3030401@fujitsu.com>
References: <1638566204-6212-1-git-send-email-daisl.fnst@fujitsu.com>
 <1638566204-6212-2-git-send-email-daisl.fnst@fujitsu.com>
In-Reply-To: <1638566204-6212-2-git-send-email-daisl.fnst@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 10e7e4dd-19bc-4d41-8a1e-08d9b87efaa4
x-ms-traffictypediagnostic: TYAPR01MB5755:
x-microsoft-antispam-prvs: <TYAPR01MB575528CD900BE81813FD100FFD6D9@TYAPR01MB5755.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RoYEuRD45dT/EMePIgLi5bRwFPOCB9sihrLoD8dH7Tsg31iCVQwU0QzjTAXae91fSndNeVokUFarKL910SkXCqfwHYhPq9SMM57mNmQkqyYGuTPk74uaI34sokpFzg1f0sfzX+LyBEhEJVcYtPpIYhsefZhsuUPM+YfE0z+SfinS6N7tVeJSlvCxp9RdlZ+SsqR+1c8h6zmHDoDSsAlKBJRsPFsjMXdpYy+ahPvGBp3K+oSVpIZNZ+bmDga9qDihrqH3f8P9M0F3TI2s5Zm4mPS2CtMZpDpWlIqv3+9krdGA/rVPqNA73ZI2PjAcxF9SAFRc6l3g/Uo6kK+PO52RBvuqguNt9ZPo5c+1W7GCN1sjydkj7AxwzYtpF8OFkeP4pT/WAhumjtKcP9CEJJFRIy+fy0R7Yyc5gAeCl901RXLjCd1tDUuJr5BimgmUmYmm4Hlhe8NLp4AHBFEhqN1M+LyGvdyanodm0O+cpcu6IPyp3+hLV69mb5IJQ/1pOFpnV70WXyZhzJ3lCK/c6xi6bTEiUk2tJmGxUHjvkjodou/JoogdTR6CfAAUWN3EWsW1UhBu4t8879cYM5TMYOQdXp9VTk8fBWDfM+l4mLoEzO4xmpDBzPmiRITDJ58GiHEYVXTbyDeBwLeseLX1gILEYg2mrL/Gn22EmeB8Q0QsiKCAwGsplUxn6rAp9nCouAl65G/iyaqrXCNqBaXs3efmFBqk1MKjjYgTyZvhaYdiM8s=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB6544.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8936002)(64756008)(66446008)(6486002)(5660300002)(87266011)(37006003)(508600001)(36756003)(6506007)(71200400001)(38070700005)(6512007)(85182001)(66556008)(8676002)(66476007)(91956017)(76116006)(316002)(2906002)(122000001)(86362001)(38100700002)(186003)(6862004)(6636002)(4326008)(26005)(2616005)(66946007)(33656002)(83380400001)(82960400001)(2004002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?SEVOV1pzUkZETE5GSEpteFV1d3E1REorM2l2elVvOFY3SndJdUd5MEdEdW0y?=
 =?gb2312?B?TGFyUkdTMVlYM1pjVy9YMnRQVlZjVUYyVWpaYjg1R3dJcURmNmJPbnZFNTFm?=
 =?gb2312?B?WmlXV25VeDVWNGNIRCtibmVieUJncjdRS2JpUS9GQ1N3MkxaZXhZYXI0cWhZ?=
 =?gb2312?B?TzhKNnNQSFZnSGdKU1BjY3Z4dnRTdmRlSzNwYjh2alMvOCtjWFBzT2pVM1VG?=
 =?gb2312?B?cjRGczNmbmdhbTVhb1FySmJQYXE5eHVqR1F4Q1JWSm5QMC92OFdOcUFOZEFS?=
 =?gb2312?B?clJnblRlenRZUmZvUHIzc2lvckozRHh1NXg4MHhvQlhQT2ZMbHl0SnhmSW10?=
 =?gb2312?B?RUJ3akc1d3piTEVNNDlnKzhCWTcwMFJEcGhvdXlIZVN3MGJaRDdSZElDcVo5?=
 =?gb2312?B?eXN3Y3ZiSERhdk5hbXBiL0RTZ1AxL2tVQUE3alNiaVdPc3FRR1dpMmJDZy9i?=
 =?gb2312?B?dUhDL3BZTlVmalBiaXNzTHp2Ky9saFUvMHVqL0NUQ0RzSnhXcC9jK2R4ekM4?=
 =?gb2312?B?N0xkcGk3bzhMS1l4QmtqTXlrWUVqbW0xSTZkODJmcmdYSUoydU9rYWc0TkNv?=
 =?gb2312?B?UjBsMVg1eXl4dllGRXFSeGNhQzJWZXI0OXZ4cHpzZVRXL2dxYmxWck1xSGo1?=
 =?gb2312?B?QXdFMmN6Mndia2ZpRG54LzdSN1BBRXV3cEU3ME9hM1p0cFgwMEJsVFAzclkw?=
 =?gb2312?B?VkEzRUwvaTdVT2tmUGVqT0JtYnhOVlpJbXFteFhDNXluV1YvZkJEdGU5cFdN?=
 =?gb2312?B?UGhrWTdPdFY5bVprby9nV1NnWG9qRkdmRjg2NTlxbXVwMmxIUytnU3R1OFZz?=
 =?gb2312?B?WTNOZDh5bVUxN1ZGdXJuZEw5ZTU1NDVTZjZNN1VDclZObk9VY1lVMjErME5Z?=
 =?gb2312?B?aXlqK1IrcXNtdUQvZ2xXc3ROVUxtUkpXSFJMaFFRUFZVRGJWeWp2TzhFSWhH?=
 =?gb2312?B?V0JDMlAyakcvVU1sTHdLd1J1UXFvMnh0cWQyOHpoYThhMldwRkRJVHhTS0k5?=
 =?gb2312?B?M2FPR0ExSkg2UGp4a1FMYUpkdU1iYlhNa3YrbSsvU0dkWi9wd0lHdnM3ZVRE?=
 =?gb2312?B?amF3bjV5N0dsaVZBUzU4dVM3ZUZTeDJOeGo5ZXdPU21aa2pDRGFyd0FZYU5C?=
 =?gb2312?B?UU5rcFZGVm5mTUs2WGdTaDFrNHc2OTFxTHU3YS95K2JQTHY2TXYrakdsOW5R?=
 =?gb2312?B?alBMY3VDTEVGbFhPNU5QeE1NS3BmZHN4em5HVVcxTHUwWHpxTGNrSDhKTEtH?=
 =?gb2312?B?NlB3dVRrZlYxK2t6YkxkU0lwVE5sdlA3UEpocXdFUmFCeWtpcjJCakl0ejlR?=
 =?gb2312?B?c0RsSUE3Uy9wMU8zeVBmaVdHSFVzMlR6NlJnL2lwOG4yaDFHc25vNmtYUXJP?=
 =?gb2312?B?M3hUMm5ZTytsV29lNlZwTW1sdG40LzVCNWpsUXg3OWtIWVhucDlMOHVVVVpI?=
 =?gb2312?B?ZkkrSVkxL09Xenk0dkNSMWZTU21lbTFXR0ZIZTErSlU1cUJ2ekhSRkhPTkJw?=
 =?gb2312?B?aHhnZ1pMV3VXWW1XWGU5OEM0c2ZFSzdMZ1FENHVML0hkL1hqU256VUtqdVVO?=
 =?gb2312?B?WFozcEFyYnYxaHNvNk9idU1La1hmUFdPS0ZhcXRqZkJiUHZYTksyNlZNUGlZ?=
 =?gb2312?B?SnB6cUlKNnhJaEZTZVlTejBwR3FyK2dLeVIyOEFtR0pkSU1WMFlXWXEvRk5s?=
 =?gb2312?B?dW5VMlVjRnN0cE1tbGNMRDZFZTlRd01iTUUwMy95RjZ5Q3lvTFFxREdLNmo4?=
 =?gb2312?B?M3RvY3ViYVpNRlk3MnU4L044Smc1Tm0zWmlSdFAxV05XczE1Syt4ZGxVWm04?=
 =?gb2312?B?eXBwRVZ6dE5IZEFPTG5GcmY0USsySWo3SThTU0RNVkFiZU9WRGJaTFNzc0R2?=
 =?gb2312?B?cGdEcFdFb2FkMGdNbXExUXZ2c29Ma3pCSEx5eHI2UXE1ZmIrREdJVGIwTWpy?=
 =?gb2312?B?M3NmL2YwTjNVSEg1Z1ZvTWlQbDIzSVg1Q1BGNERnTWd4K3dIUWhUbUNXQWFF?=
 =?gb2312?B?YUxuVlVUZ3BiSGxsdGwwN0hwdGtvUHpydDdRS091S2pMUnpoMGYrZVhKdGFT?=
 =?gb2312?B?cG1Zb2xiY294aCt1RWVKWWxJQXRoaHVWUit5dlhuakVBTW8wUk1DODA2aVBp?=
 =?gb2312?B?emhkYmtpdnBveTdUaXVuRllqQVJkbGp6ZUtFOTM1a0UzTnBsdjJONWtLRWRo?=
 =?gb2312?B?WGtlS1pSbFR1N3JYQWgxRy9qMmx6aSszV2VodEhVK2FTeDlRL1NUNStpVDEw?=
 =?gb2312?Q?+RHUHXab6hP72w2xrdDQ9DpgC+9O6iDuDiClJrfTcU=3D?=
Content-ID: <E8D5C5021D830545B31BEBDC0C21D290@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6544.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10e7e4dd-19bc-4d41-8a1e-08d9b87efaa4
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2021 06:09:35.8828 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iZPkSptnuBLwVo6gOhdGKKQEtKW6o9Ov+AluLU2jT8ZD81lvDcT/tpfhofvRyx8fv8nmykZWxpsldmMRPcaZdGh1YHabqjFrJI9W5wpCl/0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5755
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] syscalls/fcntl13: Convert to new API
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

Hi Dai

I do some minor changes and pushed, thanks.

1) fix description
2) fix TST_EXP_FAIL2 usage
3) remove useless DATA macro


Best Regards
Yang Xu

> 1) use TST_EXP_FAIL2 macro
> 2) remove uclinux code
> 3) remove duplicate cases
>
> Signed-off-by: Dai Shili<daisl.fnst@fujitsu.com>
> ---
>   testcases/kernel/syscalls/fcntl/fcntl13.c | 160 +++++++++---------------------
>   1 file changed, 48 insertions(+), 112 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/fcntl/fcntl13.c b/testcases/kernel/syscalls/fcntl/fcntl13.c
> index dae4c37..33c4460 100644
> --- a/testcases/kernel/syscalls/fcntl/fcntl13.c
> +++ b/testcases/kernel/syscalls/fcntl/fcntl13.c
> @@ -1,127 +1,63 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>   /*
> - *
> - *   Copyright (c) International Business Machines  Corp., 2001
> - *
> - *   This program is free software;  you can redistribute it and/or modify
> - *   it under the terms of the GNU General Public License as published by
> - *   the Free Software Foundation; either version 2 of the License, or
> - *   (at your option) any later version.
> - *
> - *   This program is distributed in the hope that it will be useful,
> - *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
> - *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> - *   the GNU General Public License for more details.
> - *
> - *   You should have received a copy of the GNU General Public License
> - *   along with this program;  if not, write to the Free Software
> - *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> + * Copyright (c) Linux Test Project, 2021
> + * Copyright (c) International Business Machines  Corp., 2001
> + * 07/2001 Ported by Wayne Boyer
>    */
>
> -/*
> - * NAME
> - *	fcntl13.c
> - *
> - * DESCRIPTION
> - *	Testcase to test that fcntl() sets errno correctly.
> +/*\
> + * [Description]
>    *
> - * USAGE
> - *	fcntl13
> + * Tests basic error handling of the fcntl syscall.
>    *
> - * HISTORY
> - *	07/2001 Ported by Wayne Boyer
> - *
> - * RESTRICTIONS
> - *	NONE
> + * - EFAULT when cmd argument is F_SETLK and the data pointed to by arg is not valid
> + * - EINVAL when cmd argument is not recognized by this kernel
> + * - EINVAL when cmd argument is F_GETLK, F_SETLK, or F_SETLKW and fd does not support locking
> + * - EBADF when fd refers to an invalid file descriptor
>    */
>
>   #include<fcntl.h>
> -#include<errno.h>
> -#include "test.h"
> -
> -#define F_BADCMD 99999
> -
> -char *TCID = "fcntl13";
> -int TST_TOTAL = 1;
> -
> -void setup(void);
> -
> -int main(int ac, char **av)
> +#include "tst_test.h"
> +
> +#define F_BADCMD 999
> +#define DATA    "ABCDEFGHIJ"
> +
> +static struct flock flock;
> +
> +static struct tcase {
> +	int fd;
> +	int cmd;
> +	struct flock *flock;
> +	char *desc;
> +	int exp_errno;
> +} tcases[] = {
> +	{1, F_SETLK, NULL, "F_SETLK", EFAULT},
> +	{1, F_BADCMD,&flock, "F_BADCMD", EINVAL},
> +	{1, F_SETLK,&flock,  "F_SETLK", EINVAL},
> +	{-1, F_GETLK,&flock, "F_GETLK", EBADF}
> +};
> +
> +static void verify_fcntl(unsigned int n)
>   {
> -	int lc;
> -
> -	struct flock flock;
> +	struct tcase *tc =&tcases[n];
>
> -	tst_parse_opts(ac, av, NULL, NULL);
> +	if (!tc->flock)
> +		tc->flock = tst_get_bad_addr(NULL);
>
> -	setup();
> -
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -		tst_count = 0;
> -
> -		if (fcntl(1, F_BADCMD, 1) != -1)
> -			tst_resm(TFAIL, "fcntl(2) failed to FAIL");
> -		else if (errno != EINVAL)
> -			tst_resm(TFAIL, "Expected EINVAL got %d", errno);
> -		else
> -			tst_resm(TPASS, "got EINVAL");
> -
> -#ifndef UCLINUX
> -		if (fcntl(1, F_SETLK, (void *)-1) != -1) {
> -			tst_resm(TFAIL, "F_SETLK: fcntl(2) failed to FAIL");
> -		} else if (errno != EFAULT) {
> -			tst_resm(TFAIL, "F_SETLK: Expected EFAULT got %d",
> -				 errno);
> -		} else {
> -			tst_resm(TPASS, "F_SETLK: got EFAULT");
> -		}
> -
> -		if (fcntl(1, F_SETLKW, (void *)-1) != -1) {
> -			tst_resm(TFAIL, "F_SETLKW: fcntl(2) failed to FAIL");
> -		} else if (errno != EFAULT) {
> -			tst_resm(TFAIL, "F_SETLKW: Expected EFAULT got %d",
> -				 errno);
> -		} else {
> -			tst_resm(TPASS, "F_SETLKW: got EFAULT");
> -		}
> -
> -		if (fcntl(1, F_GETLK, (void *)-1) != -1) {
> -			tst_resm(TFAIL, "F_GETLK: fcntl(2) failed to FAIL");
> -		} else if (errno != EFAULT) {
> -			tst_resm(TFAIL, "F_GETLK: Expected EFAULT got %d",
> -				 errno);
> -		} else {
> -			tst_resm(TPASS, "F_GETLK: got EFAULT");
> -		}
> -
> -#else
> -		tst_resm(TCONF, "Skip EFAULT on uClinux");
> -#endif
> -		flock.l_whence = -1;
> -		flock.l_type = F_WRLCK;
> -		flock.l_start = 0L;
> -		flock.l_len = 0L;
> -
> -		if (fcntl(1, F_SETLK,&flock) != -1)
> -			tst_resm(TFAIL, "fcntl(2) failed to FAIL");
> -		else if (errno != EINVAL)
> -			tst_resm(TFAIL, "Expected EINVAL, got %d", errno);
> -		else
> -			tst_resm(TPASS, "got EINVAL");
> -
> -		if (fcntl(-1, F_GETLK,&flock) != -1)
> -			tst_resm(TFAIL, "fcntl(2) failed to FAIL");
> -		else if (errno != EBADF)
> -			tst_resm(TFAIL, "Expected EBADF, got %d", errno);
> -		else
> -			tst_resm(TPASS, "got EBADFD");
> -	}
> -
> -	tst_exit();
> +	TST_EXP_FAIL2(fcntl(tc->fd, tc->cmd, tc->flock), tc->exp_errno,
> +		"fcntl(%d, %s, %d)", tc->fd, tc->desc, tc->exp_errno);
>   }
>
> -void setup(void)
> +static void setup(void)
>   {
> -	tst_sig(NOFORK, DEF_HANDLER, NULL);
> -
> -	TEST_PAUSE;
> +	flock.l_whence = -1;
> +	flock.l_type = F_WRLCK;
> +	flock.l_start = 0L;
> +	flock.l_len = 0L;
>   }
> +
> +static struct tst_test test = {
> +	.setup = setup,
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.test = verify_fcntl,
> +};

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
