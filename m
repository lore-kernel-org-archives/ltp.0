Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CCE1C433F5
	for <ltp@archiver.kernel.org>; Thu,  9 Dec 2021 09:43:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A808A3C8131
	for <ltp@archiver.kernel.org>; Thu,  9 Dec 2021 10:43:18 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 012EF3C013D
 for <ltp@lists.linux.it>; Thu,  9 Dec 2021 10:43:08 +0100 (CET)
Received: from esa1.fujitsucc.c3s2.iphmx.com (esa1.fujitsucc.c3s2.iphmx.com
 [68.232.152.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id BAAD7140121C
 for <ltp@lists.linux.it>; Thu,  9 Dec 2021 10:43:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1639042984; x=1670578984;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=3qEEnj8vNgpzCsFhk/STVN8wfm9KppFeUQ8xyI18iEM=;
 b=Ip5IyLQWi6kZN9W9zGRCSGnpmw4aMY2OYlTikYSq0bxx5de51/3nA3Az
 1qPpId1GYm4EZL/ztGnNf+yKSAUG49XD89isJHh7LND9nilC12twywxsF
 n9c6BsyTJdeBMxKWuVF3YFX+oxnAJzIwZ2YJdOpeL9QMatiwzCvQRK0Ry
 f+Mll2TAZQvT4QwbdjdPwo4CAsiv1yNqwARif6whklyvczxMlRey1PCWX
 j31Cnwc7X+MuGhLQT7B8uHrrdD9zJKsX55N8H4vtXKnkQ1nW67/S7FReL
 WLaWbpbDpj1o0g8L/5IMD/mRX2CfIF+hNbBab8CRbHkYNpYRsXgnzXEvV Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10192"; a="53732882"
X-IronPort-AV: E=Sophos;i="5.88,192,1635174000"; d="scan'208";a="53732882"
Received: from mail-tycjpn01lp2170.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.170])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Dec 2021 18:43:02 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e1Pu4pmHjPHtNi9iCaLClSUsLt8EltFmUEwl+Bh6BkDN+SrpNQCz6PWwkk+MgNnZAqLEh4B+RflfGI35mLBGW6PleLermZbkfgEgjjFfcCmvpI98YoDUbUj4lq6JSc0eav1vHCF5T0bbtH6iLK8Uv8hTkIsKt67Cp7FUip6HcUQK8UoD5id0PWty+H5uVQxJcb1+VYl+vt8f2KFSAKhuznOV5KeNL49t6kt9lJjlguQHukCclV/oL+GVs0ikNkOHO1IbKSjPi8cOmyLlhuPuVI0Zy8Y0khdIAeg/lFJdloLG9DD/6eLZH1mbSSR/kYjxMoeuJ3o6+mou9vsu+Kdvvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3qEEnj8vNgpzCsFhk/STVN8wfm9KppFeUQ8xyI18iEM=;
 b=WTUXsvlQKtrfWNA163B3fdG2iq0ohppMHf0oYYF3QNEuDUDnKObcjnvG5vY4fnzpYgvdfmfm2pbzpUuH9sozBOrwKyyrTshlcU393J4o2A2Ma+4Cje0D2SlA8L5+pp5xLqYNcl6ARQjyMQi3oLiG9vky+eAKUJ3p8z/CDO6W452GEv/xWeqCIKZn6HhM9ilzHiY9wBo5Ur1FFDTsXTnG2BbTFlX48iElIgPb9iuJryuGVljwh5y+CEKI41NtR+XQSIL8Cz0ULNhbd2IQAnE1T514HcLoqbmrR5tpySm/QCEX4aUf1lrnATSO7DaKOG/CdrMwPXwatQVMGz+7oLYvzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3qEEnj8vNgpzCsFhk/STVN8wfm9KppFeUQ8xyI18iEM=;
 b=l9TP2L57cIjiD25KVVlTjiX2ppcVsHyzx6the1ioz4oQifDXWiwYS0DmnomXovCDcTg6rWpP1FhCk7zfRiBvRoq9fyalhgL5L0Jt95GJnqa4fSI/bU79UNiu/iekU8rv+nv2zQR1Ac88Ptq9neLHhGT+UcSa1WOCBfEaqhT5wWU=
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com (2603:1096:400:98::6)
 by TY2PR01MB4779.jpnprd01.prod.outlook.com (2603:1096:404:111::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Thu, 9 Dec
 2021 09:42:58 +0000
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::4997:e3e6:6502:9100]) by TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::4997:e3e6:6502:9100%9]) with mapi id 15.20.4755.024; Thu, 9 Dec 2021
 09:42:58 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH 1/1] m4: Fix warnings
Thread-Index: AQHX7A1WNYswYxFMLkSONkR1aD2tA6wp6l4A
Date: Thu, 9 Dec 2021 09:42:58 +0000
Message-ID: <61B1CFC8.6060305@fujitsu.com>
References: <20211208082625.26324-1-pvorel@suse.cz>
In-Reply-To: <20211208082625.26324-1-pvorel@suse.cz>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 85f7bb26-dbe7-4af2-6417-08d9baf848d1
x-ms-traffictypediagnostic: TY2PR01MB4779:EE_
x-microsoft-antispam-prvs: <TY2PR01MB47798C71B1C3C4C5E50DCCD3FD709@TY2PR01MB4779.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:332;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8jTapvMaRRhPm1mTlhBbnYekmQ6c/947m+l0xmWhZZxrejlav/2Y6xAMxK7Lu5DoeBLiSkO7IXhTtLgPr1XEwKGZV8E0ox5RY8z1pcK+Wf6EviWPkfLrAVRWMahWZUzXlI7eC/IvnjQV4QYIoKwYihIOLxqegpJTQYv+zFUwI+m2ALY0fhLNQOUqxb0X4u7fFpNy4g+e0efjTKVo1tkK5/waQ1EBMZhV1zplqtVduz2wOe821XWAdHc+dXuez7YDKXVWWrQwoZLAM0aWc0Hirp+lKuK3Ghan9OWjo2s+HiDXW6TuOWrj8sUQyWYeDxHJwYxSxgUhBzOlZ9mQCQvyZLh7BGtSfPppZq0u5gKARThZAKVqbXhha1mnZLpE/INgDIBDepmgIH/qtmNbu0fmOecuXXvZTErQ7yeZNrUUWRqjt7bpvS/LadV/p1uSYKGgakwhM6FCqqCsRX/wlckW/Kdla7kjZJuSsK8cXsCyVFdqvW09ETk4VdSuj9GCYY88sYVVSKMfwwBGiiyzXHOU776V5WjWxAmFO2tkHhfrDnwnDhd4Ff8xQtyiKeDGhTRVhKFNm2a4j1u1Uq9X4S83YcztDVAamsJ76RzlxZ/hOxspvzhS4ETN/LFYc/2x4v7whub7b1wrFKexwYkxiqMdXS2516i3K3w7lU01Gecjbe2abCE0VYN8Ops2XRck+WAQdXA8mNxmqHr4emk1QqABs+9hv7eBGReMSsUmzInirceD5Qas1lVtS/ReWZBJbpWbI3aihTJfFcMofXxKy6095WnzG5MgdLJd4v3S6rq46IXjQwVBklou/5DmtXTgciu+tV/8q9fZ0HLxnpFSa8pfSA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB6544.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(316002)(91956017)(508600001)(6512007)(66476007)(87266011)(8676002)(85182001)(66556008)(6506007)(26005)(64756008)(6486002)(8936002)(186003)(966005)(76116006)(36756003)(66446008)(38070700005)(2616005)(66946007)(82960400001)(83380400001)(38100700002)(6916009)(122000001)(33656002)(86362001)(2906002)(30864003)(5660300002)(4326008)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?VnpCYkFoajVoU2hhS0cvUmxvbTlUMitpUU1DS2NCVzYwVnB6dmhESXlJeXpt?=
 =?gb2312?B?MkpyVExqMHZIUTFvUTVqQmdIZ296N0RpMTVWbDNjSjMwOFczbjdTcjJBbFQr?=
 =?gb2312?B?WE9sYmpTSERTdFE1SStTNnhWdExUNnVERm1UTklMbGRhS3h1VWtoWnRxbGc2?=
 =?gb2312?B?Wk1hOHNmTzY0Zk5zeThZMkdtYWs5SXhzVXBpaVpnaXV6NDk3a2VsY25FYkQv?=
 =?gb2312?B?bjZGc0pQWlVteHZQY3Fvdlpqb2lQUk5xdHpYV0MwS0JmTWlMQ1JEcnFISHYy?=
 =?gb2312?B?VzBtNG9jUEVOK2krT215Wjg0cTRIeEdqYmVNYnJXMWplTUJXUzlESGFSMWgx?=
 =?gb2312?B?eVBPMnl6Y2FsNFlCQkpEQjZFZ0ZFbUVRRU14QnU5SU0remNBcTVrRlJ3azZx?=
 =?gb2312?B?clpuUUtlRFdsc2FXelFHdzRidWZuV2pZT3N0UVJPRG1XM2ZDLy9qVSt4TDh1?=
 =?gb2312?B?MU9UV2czOThRUTgxVS9iYnJMQThMUjViTk0xVnpUL1pzZXNYN0pDQjlOR0o4?=
 =?gb2312?B?WGJQdVUrZnU4ZUJHdWVhQk9WbzFKbFdJenlSVW1XbEJOS2dBeUpmOTZHUzJK?=
 =?gb2312?B?NDhGZkpsbnpTVVNzZ3BibXVWQTEvNUdBZFNLTEVKUzUyMWRJay9QdEhubmo2?=
 =?gb2312?B?a24wOXVYU2pRRTlhaHgvQ2l2UXB2dGpCREJHSm5lNGJuNXdYOERXdGU2TGVz?=
 =?gb2312?B?TCtqZ3o1eER2Z3ppUUdtUDNwSDExSzlURXcvcWhWY2FFcktYVitWSldKcHBG?=
 =?gb2312?B?cXF5QnQ1L3lPVnBQVVR1c2N6UG40a0I2anFJanc3ZE5Nd3ZFNHdmUE11R1p1?=
 =?gb2312?B?S1A2MklUMllHNkxZOW11N3p3TU4zcUpXTlhmMythUWlHcktWYjErUEtTMDdk?=
 =?gb2312?B?NCtyMEFPVXIzWmdPR0plVk9qS1BUd05GOURjQlY5ejV3UWw0dmhGTzF0bmxT?=
 =?gb2312?B?R0dJYXpnRlo4STh6TDVmWXJNTmVJYmZhWnJGYWZFVTdqN2grRG9rN2lyMXdv?=
 =?gb2312?B?bkRGK3FLeHdUWVp3L0pmeWw3MVFDWCs5MkszYlliUlRMUTZuQWgwU3RJTmsz?=
 =?gb2312?B?MjVPOG9nemRWRUZ0MElYRDc2aTR4QmZOYXRZRVNtU3lGendyUmwvNFNFSnBN?=
 =?gb2312?B?NktBMkpBUWk3WnJJM3pqc0V6d0d2dStZdDE3ZEV5TTJyNjZoR1lUVHdCcG1V?=
 =?gb2312?B?YXVCYi9ZK1BwdXVkUDVtOVdCNXBicFFyckNrL2Z1cFJ0Und0M2t2Q2JHWkdC?=
 =?gb2312?B?UUY0MmFXaTZsYmk5UGN1MnpENTVXa29MTnVLd0Fhcmc0TWNEcmVqM2g3ZDRK?=
 =?gb2312?B?OXU5UnBOY3NXRXU0TkdhVDE1QWZuUmM5eVNSOGU5M0VOZ0phV1ZMOHFIMXBS?=
 =?gb2312?B?QVlaOTVkdnNPeDd2dy8xek5Cbmp1enBPc2pYWFBiK3d2V1NBSTVoT3gwNDJw?=
 =?gb2312?B?YUFIMFdaY0h4blRZeU1hSUJPKytzU2VMWXAyeXMrL2JrRnBZMDZTSWtuaE9P?=
 =?gb2312?B?Z3huZkhkd0ZvNTUrc29neFozR0p2T3pIaUU2Z0x1YXFyVlMvZFl4VDAxNDVE?=
 =?gb2312?B?Rm1rL3BGNE0yOG1iY2h0YXBaYnBmZEc4TFA2a3lGVU83bnVxWWlhTjR0MTNq?=
 =?gb2312?B?UHcxeFZGQmtuL2YrZ2R3YWs0VGsxZDlZTlJrYzVYR0N3emRNcXRQdS8xOW9o?=
 =?gb2312?B?dERNaTI1SUxTOFFJU0Q5SDgvVnQxOU9UQllZeVRsMGxuRWhWbmJobzZ1QmVF?=
 =?gb2312?B?VUdCdWJzKzZoS0dTZjZ3OHNYR3FJWXFoZng1aWprU2M4anl5dEhLdEpoZTJq?=
 =?gb2312?B?Y3VJMEU2a2FlZ2FVMEtNV0s0b2l6Y3FjMHB4U3d2ek9iekREM2VrTVFsVzNm?=
 =?gb2312?B?NSt2cC9OYm9kQW1uQzBiOHlkY1lCQ29MbXBSTFpKekpWZ3FaS2JaSENnVVhm?=
 =?gb2312?B?MHVHSHFEbzNscEFHdUlnSWZHZVFvSnZnb1lPS0J4WmlaRktjL3lXSkdIQ3BX?=
 =?gb2312?B?Z0tjcEs5Y1U0Z0krRWd5ODJCQ1NDVTRJQm1BMUhlYkU4dURGS3UxQ1lmWjcx?=
 =?gb2312?B?TXBrS2pIUTRnUndhcGZzaDhiZ1hrVjBHc3VxY2JKSGFWQ3F0NzBURjgxa2ln?=
 =?gb2312?B?akRmTmJnT1pGM1NESitFSWl2c1dKQjduNzJrLzNMOHB2L0VQY3J4aXUzTEhr?=
 =?gb2312?B?amhlRjY2RWZuSGlDbE9tMldvNVRFWGs0TkdFMmFWakdIS0NQQjc4dE4zNFp2?=
 =?gb2312?Q?TwAUt+XR31SSY/fAib2jHE31MtMJxmeMZwCLzycNFs=3D?=
Content-ID: <F5C071FFFA5ADD4B835721E5F3F73348@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6544.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85f7bb26-dbe7-4af2-6417-08d9baf848d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2021 09:42:58.5117 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qGBR0oc9i3XeHbSGdYoqOoXciP1G54t8AX24EmwdDqLBGlXUG86tVrjA+1y+Iq4B8IqatBI3uGAgm63eJFqWUAAjVtMmpPO56S+LpkG0gr0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB4779
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] m4: Fix warnings
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

Hi Petr


> from autoconf 2.71:
>
> * s/AC_HELP_STRING/AS_HELP_STRING/
>
> Similar replace was done in autoconf commit 5958ce17 ("*
> doc/autoconf.texi: Replace AC_HELP_STRING AS_HELP_STRING.")
> from 2.58.
>
> * s/AC_TRY_LINK/AC_COMPILE_IFELSE([AC_LANG_PROGRAM/
   * s/AC_TRY_LINK/AC_LINK_IFELSE([AC_LANG_PROGRAM/
   * s/AC_TRY_COMPILE/AC_COMPILE_IFELSE([AC_LANG_PROGRAM/
>
> Similar replace was done in autoconf commit ede91cff ("Modernize
> AC_EXEEXT and AC_OBJEXT. Now work with other languages than C and C++.")
> from 2.50.
>
> * s/AC_PROG_LEX/AC_PROG_LEX(yywrap)
> yywrap argument introduced in 46f384f8 ("Revert to 2.69-compatible
> behavior in AC_PROG_LEX (#110346)") from 2.70, but using is is
> compatible on older releases (tested on 2.63).

>
> Therefore keep requiring 2.61. Tested on 2.63 (SLES 11 and CentOS 6 both
> don't even compile as unsupported, thus we could bump version to 2.63).
>
> Signed-off-by: Petr Vorel<pvorel@suse.cz>
> ---
> Tested:
> https://github.com/pevik/ltp/actions/runs/1553085898
>
> Kind regards,
> Petr
>
>   configure.ac                       | 26 +++++++++++++-------------
>   m4/ltp-clone7args.m4               |  8 +++-----
>   m4/ltp-eventfd.m4                  |  8 +++-----
>   m4/ltp-kernel_devel.m4             |  6 +++---
>   m4/ltp-mremap_fixed.m4             |  6 +++---
>   m4/ltp-perf_event_open.m4          |  8 +++-----
>   testcases/realtime/m4/check.m4     |  6 +++---
>   testcases/realtime/m4/ltp-exp10.m4 |  8 +++-----
>   8 files changed, 34 insertions(+), 42 deletions(-)
>
> diff --git a/configure.ac b/configure.ac
> index 063a8a9d1..366429b64 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -24,7 +24,7 @@ AC_PROG_CC
>   # 2.62.
>   AC_DEFUN([AC_PROG_AR], [AC_CHECK_TOOL(AR, ar, :)])
>   AC_PROG_AR
> -AC_PROG_LEX
> +AC_PROG_LEX(yywrap)
 From this autoconf commit message, If $1 is `yywrap',
and we don't find a library that provides yywrap, we fail.

I see other projects that they use AC_PROG_LEX(yywrap) or 
AC_PROG_LEX(noyywrap), but don't get why.

[1]https://github.com/search?q=%E2%80%9DAC_PROG_LEX%28yywrap%29%E2%80%9C&type=commits

Best Regards
Yang Xu

>   AC_PROG_RANLIB
>   AC_DEFUN([AC_PROG_STRIP], [AC_CHECK_TOOL(STRIP, strip, :)])
>   AC_PROG_STRIP
> @@ -216,7 +216,7 @@ AC_CHECK_TYPES([struct xt_entry_match, struct xt_entry_target],,,[
>
>   # Bash
>   AC_ARG_WITH([bash],
> -  [AC_HELP_STRING([--with-bash],
> +  [AS_HELP_STRING([--with-bash],
>       [have the Bourne Again Shell interpreter])],
>     [with_bash=$withval],
>     [with_bash=no]
> @@ -229,24 +229,24 @@ fi
>
>   # metadata
>   AC_ARG_ENABLE([metadata],
> -  [AC_HELP_STRING([--disable-metadata],
> +  [AS_HELP_STRING([--disable-metadata],
>   	[Disable metadata generation (both HTML and PDF, default no)])],
>     [], [enable_metadata=yes]
>   )
>   AC_ARG_ENABLE([metadata_html],
> -  [AC_HELP_STRING([--disable-metadata-html],
> +  [AS_HELP_STRING([--disable-metadata-html],
>   	[Disable metadata HTML generation (default no)])],
>     [], [enable_metadata_html=yes]
>   )
>
>   AC_ARG_ENABLE([metadata_pdf],
> -  [AC_HELP_STRING([--enable-metadata-pdf],
> +  [AS_HELP_STRING([--enable-metadata-pdf],
>   	[Enable metadata PDF generation (default no)])],
>     [], [enable_metadata_pdf=no]
>   )
>
>   AC_ARG_WITH([metadata_generator],
> -  [AC_HELP_STRING([--with-metadata-generator=asciidoc|asciidoctor],
> +  [AS_HELP_STRING([--with-metadata-generator=asciidoc|asciidoctor],
>   	[Specify metadata generator to use (default autodetect)])],
>     [with_metadata_generator=$withval],
>     [with_metadata_generator=detect]
> @@ -256,7 +256,7 @@ LTP_DOCPARSE
>
>   # Expect
>   AC_ARG_WITH([expect],
> -  [AC_HELP_STRING([--with-expect],
> +  [AS_HELP_STRING([--with-expect],
>       [have the Tcl/expect library])],
>     [with_expect=$withval],
>     [with_expect=no]
> @@ -269,7 +269,7 @@ fi
>
>   # Numa
>   AC_ARG_WITH([numa],
> -  AC_HELP_STRING([--without-numa],
> +  AS_HELP_STRING([--without-numa],
>       [without numa support]),
>     [with_numa=$withval],
>     [with_numa=yes]
> @@ -277,7 +277,7 @@ AC_ARG_WITH([numa],
>
>   # Perl
>   AC_ARG_WITH([perl],
> -  [AC_HELP_STRING([--with-perl],
> +  [AS_HELP_STRING([--with-perl],
>       [have a perl interpreter])],
>     [with_perl=$withval],
>     [with_perl=no]
> @@ -290,7 +290,7 @@ fi
>
>   # Python
>   AC_ARG_WITH([python],
> -  [AC_HELP_STRING([--with-python],
> +  [AS_HELP_STRING([--with-python],
>       [have a python interpreter])],
>     [with_python=$withval],
>     [with_python=no]
> @@ -303,7 +303,7 @@ fi
>
>   # TI RPC
>   AC_ARG_WITH([tirpc],
> -  AC_HELP_STRING([--without-tirpc],
> +  AS_HELP_STRING([--without-tirpc],
>       [without libtirpc support]),
>     [with_tirpc=$withval],
>     [with_tirpc=yes]
> @@ -313,7 +313,7 @@ AC_ARG_WITH([tirpc],
>   # Testsuites knobs
>
>   AC_ARG_WITH([open-posix-testsuite],
> -  [AC_HELP_STRING([--with-open-posix-testsuite],
> +  [AS_HELP_STRING([--with-open-posix-testsuite],
>       [compile and install the open posix testsuite])],
>     [with_open_posix_testsuite=$withval],
>     [with_open_posix_testsuite=no]
> @@ -326,7 +326,7 @@ fi
>
>   # TODO: testcases/realtime requires bash and python.
>   AC_ARG_WITH([realtime-testsuite],
> -  [AC_HELP_STRING([--with-realtime-testsuite],
> +  [AS_HELP_STRING([--with-realtime-testsuite],
>       [compile and install the realtime testsuite])],
>     [with_realtime_testsuite=$withval],
>     [with_realtime_testsuite=no]
> diff --git a/m4/ltp-clone7args.m4 b/m4/ltp-clone7args.m4
> index ab55c1e33..4962789e5 100644
> --- a/m4/ltp-clone7args.m4
> +++ b/m4/ltp-clone7args.m4
> @@ -5,13 +5,11 @@ AC_DEFUN([LTP_CHECK_CLONE_SUPPORTS_7_ARGS],[
>   AH_TEMPLATE(CLONE_SUPPORTS_7_ARGS,
>   [Define to 1 if clone() supports 7 arguments.])
>   AC_MSG_CHECKING([if clone() supports 7 args])
> -AC_TRY_LINK([#define _GNU_SOURCE
> +AC_LINK_IFELSE([AC_LANG_PROGRAM([[#define _GNU_SOURCE
>   		#include<sched.h>
> -		#include<stdlib.h>],
> -		[
> +		#include<stdlib.h>]], [[
>   		#ifndef __ia64__
>   		clone(NULL, NULL, 0, NULL, NULL, NULL, NULL);
>   		#endif
> -		],
> -		AC_DEFINE(CLONE_SUPPORTS_7_ARGS) AC_MSG_RESULT(yes), AC_MSG_RESULT(no))
> +		]])],[AC_DEFINE(CLONE_SUPPORTS_7_ARGS) AC_MSG_RESULT(yes)],[AC_MSG_RESULT(no)])
>   ])
> diff --git a/m4/ltp-eventfd.m4 b/m4/ltp-eventfd.m4
> index 5d729a33d..580df00a3 100644
> --- a/m4/ltp-eventfd.m4
> +++ b/m4/ltp-eventfd.m4
> @@ -12,12 +12,10 @@ AC_DEFUN([LTP_CHECK_SYSCALL_EVENTFD], [
>   		AC_SUBST(AIO_LIBS, "-laio")
>
>   		AC_MSG_CHECKING([io_set_eventfd is defined in aio library or aio header])
> -		AC_TRY_LINK([#include<stdio.h>
> +		AC_LINK_IFELSE([AC_LANG_PROGRAM([[#include<stdio.h>
>                                #include<libaio.h>
> -		            ],
> -		            [io_set_eventfd(NULL, 0); return 0;],
> +		            ]], [[io_set_eventfd(NULL, 0); return 0;]])],
>   		            [AC_DEFINE(HAVE_IO_SET_EVENTFD, 1, [Define to 1 if you have `io_set_eventfd' function.])
> -						AC_MSG_RESULT(yes)],
> -		            [AC_MSG_RESULT(no)])
> +						AC_MSG_RESULT(yes)],[AC_MSG_RESULT(no)])
>   	fi
>   ])
> diff --git a/m4/ltp-kernel_devel.m4 b/m4/ltp-kernel_devel.m4
> index 8a0598e5a..d46d54775 100644
> --- a/m4/ltp-kernel_devel.m4
> +++ b/m4/ltp-kernel_devel.m4
> @@ -9,7 +9,7 @@ AC_DEFUN([LTP_CHECK_KERNEL_DEVEL],[
>   AC_MSG_CHECKING([for kernel-devel])
>   AC_ARG_WITH(
>   	[linux-version],
> -	[AC_HELP_STRING([--with-linux-version=VERSION],
> +	[AS_HELP_STRING([--with-linux-version=VERSION],
>   			[specify the Linux version to build modules for])],
>   	[LINUX_VERSION="${withval}"],
>   	AS_IF([test "$cross_compiling" = "no"],
> @@ -18,7 +18,7 @@ AC_ARG_WITH(
>   AC_SUBST(LINUX_VERSION)
>
>   AC_ARG_WITH([linux-dir],
> -	[AC_HELP_STRING([--with-linux-dir=DIR],
> +	[AS_HELP_STRING([--with-linux-dir=DIR],
>   			[specify path to kernel-devel directory])],
>   	[LINUX_DIR="${withval}"],
>   	AS_IF([test -n "$LINUX_VERSION"],
> @@ -44,7 +44,7 @@ AC_MSG_RESULT([$WITH_MODULES])
>
>   AC_ARG_WITH(
>   	[modules],
> -	[AC_HELP_STRING([--without-modules],
> +	[AS_HELP_STRING([--without-modules],
>   			[disable auto-building kernel modules])],
>   			[WITH_MODULES="no"],
>   			[])
> diff --git a/m4/ltp-mremap_fixed.m4 b/m4/ltp-mremap_fixed.m4
> index 66548b82b..ff2696909 100644
> --- a/m4/ltp-mremap_fixed.m4
> +++ b/m4/ltp-mremap_fixed.m4
> @@ -6,7 +6,7 @@ AC_DEFUN([LTP_CHECK_MREMAP_FIXED],[
>   AH_TEMPLATE(HAVE_MREMAP_FIXED,
>   [Define to 1 if you have MREMAP_FIXED in<sys/mman.h>.])
>   AC_MSG_CHECKING([for MREMAP_FIXED in<sys/mman.h>])
> -AC_TRY_COMPILE([#define _GNU_SOURCE
> -                #include<sys/mman.h>], [int flags = MREMAP_FIXED;],
> -               AC_DEFINE(HAVE_MREMAP_FIXED) AC_MSG_RESULT(yes), AC_MSG_RESULT(no))
> +AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[#define _GNU_SOURCE
> +                #include<sys/mman.h>]], [[int flags = MREMAP_FIXED;]])],
> +                [AC_DEFINE(HAVE_MREMAP_FIXED) AC_MSG_RESULT(yes)],[AC_MSG_RESULT(no)])
>   ])
> diff --git a/m4/ltp-perf_event_open.m4 b/m4/ltp-perf_event_open.m4
> index 6966cf270..4a488ffa3 100644
> --- a/m4/ltp-perf_event_open.m4
> +++ b/m4/ltp-perf_event_open.m4
> @@ -7,10 +7,8 @@ AC_DEFUN([LTP_CHECK_SYSCALL_PERF_EVENT_OPEN],[
>   AH_TEMPLATE(HAVE_PERF_EVENT_ATTR,
>   [Define to 1 if you have struct perf_event_attr])
>   AC_MSG_CHECKING([for perf_event_attr in linux/perf_event.h])
> -AC_TRY_COMPILE([#include<unistd.h>
> -		#include<linux/perf_event.h>],
> -		[
> +AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[#include<unistd.h>
> +		#include<linux/perf_event.h>]], [[
>   			struct perf_event_attr pe;
> -		],
> -		AC_DEFINE(HAVE_PERF_EVENT_ATTR) AC_MSG_RESULT(yes), AC_MSG_RESULT(no))
> +		]])],[AC_DEFINE(HAVE_PERF_EVENT_ATTR) AC_MSG_RESULT(yes)],[AC_MSG_RESULT(no)])
>   ])
> diff --git a/testcases/realtime/m4/check.m4 b/testcases/realtime/m4/check.m4
> index e60ae1928..d04a2cc73 100644
> --- a/testcases/realtime/m4/check.m4
> +++ b/testcases/realtime/m4/check.m4
> @@ -1,10 +1,10 @@
>   AC_DEFUN([REALTIME_CHECK_PRIO_INHERIT],[
>   AC_MSG_CHECKING([for PTHREAD_PRIO_INHERIT])
> -AC_TRY_COMPILE([
> -#include<pthread.h>],[int main(void) {
> +AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[
> +#include<pthread.h>]], [[int main(void) {
>   	pthread_mutexattr_t attr;
>   	return pthread_mutexattr_setprotocol(&attr, PTHREAD_PRIO_INHERIT);
> -}],[has_priority_inherit="yes"],[])
> +}]])],[has_priority_inherit="yes"],[])
>   if test "x$has_priority_inherit" = "xyes" ; then
>   	AC_DEFINE(HAS_PRIORITY_INHERIT,1,[Define to 1 if you have PTHREAD_PRIO_INHERIT])
>   	AC_MSG_RESULT(yes)
> diff --git a/testcases/realtime/m4/ltp-exp10.m4 b/testcases/realtime/m4/ltp-exp10.m4
> index 3d2320a20..625175c31 100644
> --- a/testcases/realtime/m4/ltp-exp10.m4
> +++ b/testcases/realtime/m4/ltp-exp10.m4
> @@ -26,12 +26,10 @@ AH_TEMPLATE(HAVE_EXP10,
>   AC_MSG_CHECKING([for exp10])
>   backup_ldlibs="$LIBS"
>   LIBS+=" -lm"
> -AC_TRY_LINK([#define _GNU_SOURCE
> -             #include<math.h>],
> -            [
> +AC_LINK_IFELSE([AC_LANG_PROGRAM([[#define _GNU_SOURCE
> +             #include<math.h>]], [[
>                volatile float val;
>                exp10(val);
> -            ],
> -             AC_DEFINE(HAVE_EXP10) AC_MSG_RESULT(yes), AC_MSG_RESULT(no))
> +            ]])],[AC_DEFINE(HAVE_EXP10) AC_MSG_RESULT(yes)],[AC_MSG_RESULT(no)])
>   LIBS="$backup_ldlibs"
>   ])

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
