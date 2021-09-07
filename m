Return-Path: <SRS0=89zk=N5=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92983C433F5
	for <ltp@archiver.kernel.org>; Tue,  7 Sep 2021 09:36:44 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3FED60E94
	for <ltp@archiver.kernel.org>; Tue,  7 Sep 2021 09:36:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E3FED60E94
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4FA713C708B
	for <ltp@archiver.kernel.org>; Tue,  7 Sep 2021 11:36:42 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E013F3C222D
 for <ltp@lists.linux.it>; Tue,  7 Sep 2021 11:36:31 +0200 (CEST)
Received: from esa18.fujitsucc.c3s2.iphmx.com (esa18.fujitsucc.c3s2.iphmx.com
 [216.71.158.38])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C05A41000364
 for <ltp@lists.linux.it>; Tue,  7 Sep 2021 11:36:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1631007391; x=1662543391;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=8XZSiRxpxZk5WF1uhylGYwtWs/uSk3W+Ce7Li/e4jQc=;
 b=QuhlNF0OrL58Xr9T8OlpZwpqoffqer/ryiI5q25G4RmUu/8m25p9v6SZ
 mEqVg0TVOC9GQo7Ke21KvcQX/KGTkAT3YtxtIDLkMeEGtX5F8dGNd9dxZ
 fcPY8g814PekuEuoM4f2Tjp7waOyrgqO6VfpQn7ou8Zkh8d+r7A3Ea7a5
 q7P4QvbpGtqoWF5a0ddhHAuU6OAWyMW2+RUIq6/yux03ppwXaqisaQ31z
 dL77SEUDrsiZaA/ph4RP/xjU1u/WNgu1XzaMxb66kJo3dYBjHsvksdaLe
 0NYhunfJrhOMwbiGlLFqMRApxyz/tYvzD+TVTz9ke5vVZDYZ17PI+6rVX A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10099"; a="39330589"
X-IronPort-AV: E=Sophos;i="5.85,274,1624287600"; d="scan'208";a="39330589"
Received: from mail-os2jpn01lp2057.outbound.protection.outlook.com (HELO
 JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.57])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Sep 2021 18:36:29 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ThwmC6zmK90bqDwuGetwAz6xywzPjlF3ODwiAQjGcKKuUwev9qWG+ECo4Z8WSIt/H0AJDzUPmAoFdpA11bNt/i0Sr11+vrBnuZIaZnkIYZCFLspefGrJDWij7XebBkAhwFGtZBmIN/DqlYB5QchU1roHLv2YMf62xRFJsOU40KhWpTzo25KfaclVeFN1f7n5f/ZPbxipSDYcU8L1Ev71CR9cwTEbs+AQ1g05/5yFItQ6ejDCe6Y9ezjRgyddEz677371ZrzK2Y8bj1xTWWMihZHjizZiDBRVCtM3vgjNXJ+MkVp/zYhIwMfp3vRbbdK8i7H4PI27w6YqyWlLlALfFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=8XZSiRxpxZk5WF1uhylGYwtWs/uSk3W+Ce7Li/e4jQc=;
 b=JaUe6lfvy5ouUg7+vHw0urmKVCCCU/Sl8WDgkONJw/59GygRb+6O/R1AianUUSb/OYXBtVNiyUiqNH6kvxcSYBzpr1wXvedjZSdRwrKa5qu7iazoOVYVgiN0uCpGrNecjIIG3FQq43phH+K8ZQPjR7JfiM/11IPIxwphD3Ww7TDnCo7YCUYjftjH0yFoRW477Uf0cF+v0SkMB31N1+6nE+JqSDy8COhl5reUGzlHakckSxpwdwJYVdmSOgE9LZu7lOmEcLgp2K9aAe7dyOWBwGZWSiV+F82RsFVBYfxj/h38KTQj80EpMPE8Mp42NbJvOdvMaUuQbpOPQ7Tiuzjz1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8XZSiRxpxZk5WF1uhylGYwtWs/uSk3W+Ce7Li/e4jQc=;
 b=n7fVmOQAwCD8TMResPfC+7deHb4tEeA+RI8fgsdSSwj/JErMjB+wOpLQMk+6KFPo/EkCQMuCPt4Oo9aywZKfoA8jk9a0P3Ua1pSLb5ApbDoN/bvB+nNLk2RttEUHhOixyZKkvdVQG7sVeVhjfzrp9tOlGU/wyplh/iLLUhmjrjI=
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com (2603:1096:400:98::6)
 by TYAPR01MB5850.jpnprd01.prod.outlook.com (2603:1096:404:8056::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Tue, 7 Sep
 2021 09:36:25 +0000
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::783d:cf1b:a4b9:5791]) by TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::783d:cf1b:a4b9:5791%6]) with mapi id 15.20.4478.026; Tue, 7 Sep 2021
 09:36:25 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: QI Fuli <fukuri.sai@gmail.com>
Thread-Topic: [LTP] [PATCH 4/5] syscalls/dup2/dup204: Convert dup204 to the
 new API
Thread-Index: AQHXn/Ike3N1LUOBGEWIkgHoC1EPIauYV7SA
Date: Tue, 7 Sep 2021 09:36:24 +0000
Message-ID: <6137328D.5020009@fujitsu.com>
References: <20210902115849.72382-1-qi.fuli@fujitsu.com>
 <20210902115849.72382-5-qi.fuli@fujitsu.com>
In-Reply-To: <20210902115849.72382-5-qi.fuli@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 315c9762-2390-4e6d-51e7-08d971e2f5d1
x-ms-traffictypediagnostic: TYAPR01MB5850:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYAPR01MB585076B681DEF8935F006212FDD39@TYAPR01MB5850.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DCrfP1P9aWiZGL4U4ea0lyUB7MSdGP+fWHu22fv+5MIsFxVhSfg0Z8CZkRn22Lc9z4QajcROxsacY3R6k0lwx0aJpsdJMh+MSfEiJAGC9Y1gvlCxKyfZSOHyCRvxMhs/wpbJzhHfo5R+eWa5PHxOYeROKH8l37C68YI/lElOak0yMbo3TWZssTE5DLCraJqPavrZlYBc8Xjufhf1yqaNP3fnoZQcKGV3JdSp+KTyuCo2CoT/kpxx2xK6ENgWn7L6ZUGbwW6VgAt7hfLPQpoHbRnBx4AeMC8HohcaoedUlbnH9Auvxu+VSLBSerJd185hnPRK7zpyytkfOzWX+HVKnbSEVilh4tfBWsiafXGGHrr0EAqfdTsPJ2/o0tcQz7QRzI3ykPEG0gVstiJ/+s/flghf8hP9QPpQPVRHQNKoj+b/OMr0/FNdTOPn4Uh2UZAjTTxgX2uOINIdg3wIoMq7PFKuHmwDW0PYSurdCkLvCVGuEKW/PUOx9c6y+604PdPIgBeefKduciIKXTIK+/kOd5DVHRCLOhsmSKa3LNYIV2At/Vbdd5qVmK0/Br65/Sx5/vqtuHCVi6kiZC4i56ezpYCc0g41ReVBCP1IfI9IS4Z5nklZIPu3TTrPiBLeMjUBfFWRVVbzyMoukvRGxU/ih3IwG91WIsE58vu5ydG29CG04Vk9rVHMvykkOLlsdBr9G7ByN3pHHqorAwlm/LIQGAslSRmMu8Sz12A0dY7800A=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB6544.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(376002)(346002)(39860400002)(136003)(66556008)(64756008)(66446008)(66476007)(87266011)(316002)(85182001)(54906003)(8676002)(71200400001)(33656002)(66946007)(122000001)(4326008)(91956017)(8936002)(76116006)(38100700002)(83380400001)(478600001)(2616005)(2906002)(86362001)(6486002)(38070700005)(5660300002)(6916009)(6512007)(26005)(6506007)(107886003)(36756003)(186003)(2004002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?WjR1L1lPUTRqWCt1MzZrWXlRWHNldU1RYkRHVlc2WFZSL3loSWtHeVpNd3Rw?=
 =?gb2312?B?SlNTbjBxRTl2dEU0T1pYUnc2b1htMWdLY3pkeUZGalJ6dnBKSmoyT1I3TUxi?=
 =?gb2312?B?eUxRSFdlZnNJV3VkRmhvMmp6YzVyVURBbVZqVEhTV0xuSWhTRXNFYS8wdVEw?=
 =?gb2312?B?N1FDMmo3VktZRUVGNmpJdUl4Tlk0ZC9XZ3EwdldmWGFBR0JmWlYzTldNV1Az?=
 =?gb2312?B?YjAydkdTWEVhZlpablgyaDgvdTRHaHFwZ1lLRG9rRUdrR2hVanphSE5KZkdR?=
 =?gb2312?B?TTFWMjhiRExXQTRTZXJBdlQyN2FZRUZheG8xRTk3VE1VblNUOTdOKzNDdzdR?=
 =?gb2312?B?d0JtdERpYkVSNWQ2WlhlK3NwclBtVmFCeTk1Z2ZvRllwcVNoOWpWRVJjUit0?=
 =?gb2312?B?K1g3ejN6bGZ2TjFGNERJMjUzL2NrMTN1WHpuL3VoN2szbGx4Wks1M2FOZHBX?=
 =?gb2312?B?czNIcVpLRzBlMnZORjhZTlR1TzJ0SkdwRXpVOFZFdGhYdTNXNjU0OFBkUDlT?=
 =?gb2312?B?dUErWC9RbXBNb25XZjYreDZsUTlmWENIU043WmlSWVNrUmoyckQ3bGZIejZE?=
 =?gb2312?B?VCs4RXZKOWNqVGlhZG9iZmlMTE5EZGF4eWxlNzFTUnpSMmhjNW5vR0dlLyts?=
 =?gb2312?B?ZkE0a1J5Z1A1ekp0RGVIWGY0cFhHWlZ0S3JmVlZML1pIQUVMa2JyR2F5TlRG?=
 =?gb2312?B?NHdGUmZ5MmpmNHFGWXV3VnJCSmxWWlIzOERONTJiOE02UEdiMVJnUjNqandX?=
 =?gb2312?B?WWpJMXdtUVBKMlQ1bFFPNDloWTVOb29QVTVoSjVMVktuaWJORWs5c2FXUUxN?=
 =?gb2312?B?cW1scjdybGxxa3ppTGFjeHlQSTZNQ3lQS0N3R1ZKcTludUF3YzNpdGpnUzlz?=
 =?gb2312?B?WnpqREZHY3lqcXFyNElvdTIwK1Q2ZmNOcEV0NUwwZHl3cHJhakNjejlmeVlv?=
 =?gb2312?B?VUwzVENBa092dGExVDdpWVI2Ym9WMjM1eFZHTDBBK2JXUVpUZlJKTzZlSE5u?=
 =?gb2312?B?ZnRhUFBKMUQ2L2JadXkwYlhRRHljMzZ5ZjZiRFdNUnBNVEZJN21Zc0RLQThN?=
 =?gb2312?B?Z2piQ01vT2o1K0hXcFZwZ3V6cmlUTlQxZ3BoeEdpTlRTOHJ2dVlMS1FJS3VL?=
 =?gb2312?B?WWQyNkhoenAvNkp3REdqM1puSFJESVlEWTFlTVIweDF4MnYzUDFjNms2MmYv?=
 =?gb2312?B?OWEyRE5MREg2ZEE3RlVTd0w0NkR6RmIrR0lieWh1Yml0V3RYaTdiakIvK0lQ?=
 =?gb2312?B?NGVxRDdWSUsxQUp1c1pRay9mYmpGdHBtL3NLS0doV1dsUzRQbUliYUt3ZGtr?=
 =?gb2312?B?anhZQWIzOXc2MVJiOXlraVcyRm5Wb3RRZTdiQmdpaWlpZ3hZRU5Jbnh1NGVz?=
 =?gb2312?B?b2wzaDM3RS8rUFRjT1piVlN3T2YvZnF5a25jNFFmY3JyeDZTWFc2Y2FvcmVk?=
 =?gb2312?B?NHgvWTZOR3dyWG11dTd2SkF0TGlndnRVSGxTV3dJSmw5MTNZcjdXelBnMFBm?=
 =?gb2312?B?eFdnakNvOXBQV1I1RSs1MUk4N2Q4S1BIc213VWEwdzRRUFd5S1hVVlVYM2hl?=
 =?gb2312?B?eG93d2cwT3ZXZEN2aSs2bVEwdFJvaThIcncyUXh5aDltNWlJTnR0ME9NeFRx?=
 =?gb2312?B?Z055aWxVMThrajMyN05WU0dIRnpQUVVBUllwOUhGZzhEMFNYbGNMM2VwYWVk?=
 =?gb2312?B?Zll1OHZDcm81R3ppWUNXZmMrZ25taUJxdTFSQWdZMEdiSWVEak9aaHFCQ1I0?=
 =?gb2312?B?T0hqZDBMeVRDYVZ6dXU2OFNXZzZOK0ZrRXhxTkcxS0NkbG1aaTlzUm01dyts?=
 =?gb2312?B?cjNveTNXR1RBaGFPOTlvUT09?=
Content-ID: <B66783D40F45954D9988D677FA9E6097@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6544.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 315c9762-2390-4e6d-51e7-08d971e2f5d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2021 09:36:24.8736 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ypo5lx4GeGJX84KCt3oHrJUL1PtKh+T2cArcTSDpCsHJMFBTjS5CfZ2VWP/X8OM4giHyCTe0pXKGdtBejaGk9BkpEPZ3EwG2EtBdGdxdnbI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5850
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 4/5] syscalls/dup2/dup204: Convert dup204 to the
 new API
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
Cc: "qi.fuli@fujitsu.com" <qi.fuli@fujitsu.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
Message-ID: <20210907093624.YUVbyPQgI0fPR9fQCdoz-VuIBM2UtirOGBYSqmEyc5A@z>

Hi Qi

I think we can merge this case into dup202 directly.
So dup202 not only check modes doesn't change but also check inode 
number doesn't change.

Best Regards
Yang Xu
> From: QI Fuli<qi.fuli@fujitsu.com>
>
> Signed-off-by: QI Fuli<qi.fuli@fujitsu.com>
> ---
>   testcases/kernel/syscalls/dup2/dup204.c | 135 ++++++------------------
>   1 file changed, 35 insertions(+), 100 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/dup2/dup204.c b/testcases/kernel/syscalls/dup2/dup204.c
> index a357bc17e..3fd6b0832 100644
> --- a/testcases/kernel/syscalls/dup2/dup204.c
> +++ b/testcases/kernel/syscalls/dup2/dup204.c
> @@ -1,118 +1,25 @@
> -/*
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
> - */
> +// SPDX-License-Identifier: GPL-2.0-or-later
>
>   /*
> - * NAME
> - *	dup204.c
> + * Copyright (c) International Business Machines  Corp., 2001
>    *
> - * DESCRIPTION
> + * DESCRIPTION:
>    *	Testcase to check the basic functionality of dup2(2).
> - *
> - * ALGORITHM
> - *	attempt to call dup2() on read/write ends of a pipe
> - *
> - * USAGE:<for command-line>
> - *  dup204 [-c n] [-f] [-i n] [-I x] [-P x] [-t]
> - *     where,  -c n : Run n copies concurrently.
> - *             -f   : Turn off functionality Testing.
> - *             -i n : Execute test n times.
> - *             -I x : Execute test for x seconds.
> - *             -P x : Pause for x seconds between iterations.
> - *             -t   : Turn on syscall timing.
> - *
> - * RESTRICTION
> - *	NONE
>    */
>
>   #ifndef _GNU_SOURCE
>   #define _GNU_SOURCE
>   #endif
> -#include<sys/types.h>
> -#include<fcntl.h>
> -#include<sys/stat.h>
> -#include<errno.h>
> -#include<signal.h>
> -#include<string.h>
> -#include "test.h"
> -#include "safe_macros.h"
> -
> -void setup();
> -void cleanup();
> -
> -char *TCID = "dup204";
> -int TST_TOTAL = 2;
> +#include "tst_test.h"
> +#include "tst_safe_macros.h"
>
>   int fd[2];
>   int nfd[2];
>
> -int main(int ac, char **av)
> -{
> -	int lc;
> -	int i;
> -	struct stat oldbuf, newbuf;
> -
> -	tst_parse_opts(ac, av, NULL, NULL);
> -
> -	setup();
> -
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -
> -		tst_count = 0;
> -
> -		/* loop through the test cases */
> -		for (i = 0; i<  TST_TOTAL; i++) {
> -			TEST(dup2(fd[i], nfd[i]));
> -
> -			if (TEST_RETURN == -1) {
> -				tst_resm(TFAIL, "call failed unexpectedly");
> -				continue;
> -			}
> -
> -			SAFE_FSTAT(cleanup, fd[i],&oldbuf);
> -			SAFE_FSTAT(cleanup, nfd[i],&newbuf);
> -
> -			if (oldbuf.st_ino != newbuf.st_ino)
> -				tst_resm(TFAIL, "original and duped "
> -					 "inodes do not match");
> -			else
> -				tst_resm(TPASS, "original and duped "
> -					 "inodes are the same");
> -
> -			SAFE_CLOSE(cleanup, TEST_RETURN);
> -		}
> -	}
> -
> -	cleanup();
> -	tst_exit();
> -}
> -
>   void setup(void)
>   {
>   	fd[0] = -1;
> -
> -	tst_sig(FORK, DEF_HANDLER, cleanup);
> -
> -	TEST_PAUSE;
> -
> -	tst_tmpdir();
> -
> -	SAFE_PIPE(cleanup, fd);
> +	SAFE_PIPE(fd);
>   }
>
>   void cleanup(void)
> @@ -123,6 +30,34 @@ void cleanup(void)
>   		close(fd[i]);
>   		close(nfd[i]);
>   	}
> +}
> +
> +static void run(unsigned int i)
> +{
> +	struct stat oldbuf, newbuf;
> +
> +	TEST(dup2(fd[i], nfd[i]));
>
> -	tst_rmdir();
> +	if (TST_RET == -1) {
> +		tst_res(TFAIL, "call failed unexpectedly");
> +		return;
> +	}
> +
> +	SAFE_FSTAT(fd[i],&oldbuf);
> +	SAFE_FSTAT(nfd[i],&newbuf);
> +
> +	if (oldbuf.st_ino != newbuf.st_ino)
> +		tst_res(TFAIL, "original and duped inodes do not match");
> +	else
> +		tst_res(TPASS, "original and duped inodes are the same");
> +
> +	SAFE_CLOSE(TST_RET);
>   }
> +
> +static struct tst_test test = {
> +	.needs_tmpdir = 1,
> +	.tcnt = 2,
> +	.test = run,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +};

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
