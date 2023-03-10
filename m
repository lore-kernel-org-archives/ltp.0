Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FFBEC64EC4
	for <ltp@archiver.kernel.org>; Fri, 10 Mar 2023 02:55:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 234163CD916
	for <ltp@archiver.kernel.org>; Fri, 10 Mar 2023 03:55:20 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 25B723CB7F0
 for <ltp@lists.linux.it>; Fri, 10 Mar 2023 03:55:07 +0100 (CET)
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com
 [185.183.30.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 783C01400E70
 for <ltp@lists.linux.it>; Fri, 10 Mar 2023 03:55:04 +0100 (CET)
Received: from pps.filterd (m0209321.ppops.net [127.0.0.1])
 by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 329Mj1JE020907; Fri, 10 Mar 2023 02:55:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com;
 h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=S1;
 bh=0jm0ffz4jxDDYezhB3tHjycYJUA5D3aIj3ob21yf9F8=;
 b=mUUIqO2uFiuhw+SXNqIukf64S9bo0Bac58bnqRqw8QDiJj4M0n8McMXT+r9yr1xhnMVH
 I4VNG7MGoXwdGI8InbrE9nCDL55PCYC/afT+4Qs86I9AUs8LeMfMcPWmZXDru6hnAjWx
 Z4JsCW1VEreKTCXSvHMzqxelK0r5CixsEijIqFhf0r1g42q+PGu6roJweDz3RiWGvwOh
 HxpFQxRWAFx3vAHnBKlcn86A0coshDbY3kRgAdYyFV8GWIfAX+ShLpA+L8RnDhGxpSis
 jZ+ctI6sSOR6F3N2ZF8vqPeIXeTqRBEl6vDRkb/9ckE0+eyl/P4dw/QfU0NcLXri93bx 8g== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
 by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3p6fkqaa35-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 10 Mar 2023 02:55:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hU66dvMa3guZCf7eX7dInJ5DKJGdYcLrM6MzhxHtBlmX8bMZQIqW8QKMQaR9mSh223qUkvL+NiccnR3L1LBhnfZaogfFjbChnZ5ZHM0XJdCbma/U6S30gSqoq0JXPfM/4BaAolDFz++zCBCdTKg366S/tyHcp/kgBpLdaTcCJOew8TDkUdF9vCh32W7tXgPuOPncS9glOQHCaXhKi6dLRrBY0HARwzAD8AQDODxoKDXWYEx640BINYewwh+3Q+0AVWPm6rbhYjNYyLbxsDiPYATGJCKyWBQzyfgFs36DuikofCLFSqrAphp2ouiRFXMr32cx52wFVCrVNutrcCVPTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RpYIUoxcPdExq6tzNOFxlGoplMuYw+hWJEnkSkLLOrw=;
 b=lvSGWWSuXzRxWbPiAeBFv51lzkAs3eg0QZvj9AGiPu6LQaT0US9TOT0jCsBypdJ2x6NyisViJfA3SHgLX4Tpy7OuQx+B2Dp7Rs8WMQ356bLtdbh63BcBQ1PSsgnEIToH9qTDbicBRHDyVsYkQYLkB5nRdN1XaWpT/R3G8IwxFy4zA4/uYTwVtdY/bfnbFWVKFYIl4CkWI7ghMIDhRvDMjWbrKW8yO4h/VZOy91/ekx8eqUrYFiJ4FSWPNoQi9wKrBYRmIHopMrDuQhA2btgAZm2jFbPYE6k1KAtyLcFbZovuaBOv9p/H9Oh3mELnbM6sBKRx8tzJQbzc8bHFJZUT3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from BYAPR13MB2503.namprd13.prod.outlook.com (2603:10b6:a02:cd::33)
 by MN2PR13MB3927.namprd13.prod.outlook.com (2603:10b6:208:260::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 02:54:58 +0000
Received: from BYAPR13MB2503.namprd13.prod.outlook.com
 ([fe80::f41f:44f5:862f:410b]) by BYAPR13MB2503.namprd13.prod.outlook.com
 ([fe80::f41f:44f5:862f:410b%4]) with mapi id 15.20.6178.017; Fri, 10 Mar 2023
 02:54:58 +0000
From: "Bird, Tim" <Tim.Bird@sony.com>
To: Petr Vorel <pvorel@suse.cz>, "ltp@lists.linux.it" <ltp@lists.linux.it>
Thread-Topic: [LTP] [PATCH 1/1] ns_ifmove.c: Rewrite to new API
Thread-Index: AQHZUpfHes8yRfVkpUquOIPjrjQ+Ja7zT/Ew
Date: Fri, 10 Mar 2023 02:54:58 +0000
Message-ID: <BYAPR13MB2503F6AE85D17F078B806C0AFDBA9@BYAPR13MB2503.namprd13.prod.outlook.com>
References: <20230309145917.26846-1-pvorel@suse.cz>
In-Reply-To: <20230309145917.26846-1-pvorel@suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR13MB2503:EE_|MN2PR13MB3927:EE_
x-ms-office365-filtering-correlation-id: 02e62d50-00f6-4fdf-fc3b-08db2112d5ae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sXEVCarD2bHCWx+l+jE/Tc8jh9AHAmlsmy7dG6keQerdH2LbEt2xBKP1Z+KKuGQehcsrYY/p4aDAPg6sLVEVt9ai/1Vjq2lpZ3XKM7a53rrQSkdWHPxw4bXwbejdKRfaxrkjrsnMCQtqZZDPwco9xtaow0U6dkLO1JGj2eLwTLQpr6N8ZiEU4qhN6vXcM86IgFWXlUj/4WLe7fUqLsUcraeGWPeWD5WS4hsMNdjaS3FKVj2znfICV7VOgrJVnYj1Fw+pC/OHHXCBCrIsw+cs22vguw6sKuwsjv6KQMCrRZvNvKEHROIy/iN9GmV0L+S/fMjAoBTt3fp3VxnnIkxks33EAX8JLcEtT+J/sWcOsdBRsS608I7X3O0dDkU7s82Y1CTtV5fxbyC2FcQPwJ0gFwwtHfuUxHaUm/KVLWy8tGWoRco7RkRQsGaoH8FCh3YyELnn7EOCdDDvcE+364Ck3MdByEHmnCc0Feaw5jWPKK1S/yfl/5Cqbob68Q4oBuFA1MCMb7Zza3O1InkU8qrVuYK1TRuWiM9Aw4pETX9yaS4URx2j59Yq+sRipPt7A7s2hltFRWKG7qpQ6EJylPqeNg6G85ZQ1CflDyrCr6WhDV8XDhwUVkTBsAJB5GfAwC5cATe03U7M3hYLLcdO+5ySie5nAd52oTUBvAkt21O6RyDqQ+XcW2/ct1r93bH6NHSLXfGMTjLI9XZDN36q6vldvNaJyBipXgCrPPwOUitDqRePyjRdh0SqOsgvXWglb5iD
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR13MB2503.namprd13.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(366004)(346002)(39860400002)(396003)(136003)(376002)(451199018)(33656002)(110136005)(966005)(52536014)(71200400001)(7696005)(5660300002)(66476007)(2906002)(64756008)(8936002)(76116006)(8676002)(66946007)(66556008)(66446008)(41300700001)(316002)(55016003)(82960400001)(26005)(122000001)(186003)(38070700005)(86362001)(9686003)(53546011)(478600001)(83380400001)(6506007)(38100700002)(2004002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0vbZajlZiKCxjn9OBs+dR9xtbyvAFRtxzDSJmD9fuJwOyIO8QwAT9l/OAE5v?=
 =?us-ascii?Q?m31eNcyeAnIM2NgdPpIAjtcPqx7nltHbQmfQwqYM4XWnoTNxFfjwRAbytJNc?=
 =?us-ascii?Q?mukghLk79QNCXAml69L7j76xRqsMUAbunaCMRcJBwe06jT+NXeiz7pNtesRb?=
 =?us-ascii?Q?cUrS++jECvrI6x3AWMwb8E3V6Pn1kjqm3uezcGz90JrFMiHBvjzjcTYvANXP?=
 =?us-ascii?Q?pgxB0pErTNvAhEdeTLwSYeh1jqDGJQHYAdbWylbHNzi+Uk3+0HtqbhcyNjM9?=
 =?us-ascii?Q?ImcKW6MnM5zcWtrLSuNWofL7YZ51o10gds8MI5RFP974BWpzUFYyTmYb5ws0?=
 =?us-ascii?Q?iqRTV8UcBijsZa2sUfywLqV7wdoAm9nZIeiBJ0JohwS4h9NnZ6HYy87ROcn3?=
 =?us-ascii?Q?1IgAHje4TczNdwvSoj4sy3mUDBxYIpqmNqxomuyOu23kU2Ftqa8rGjoYdiuP?=
 =?us-ascii?Q?CAKK6nqNSVWYmYg+cY96qaRchfUAvml1WKgTxrlxRJzu457dQY0xCnWFzMo+?=
 =?us-ascii?Q?ZZqfHG3bFgfGE0fhxHhTLSRkN7uisxNHkpZRy573hUoYltdaP7IjDu7ya0VU?=
 =?us-ascii?Q?dicuAZ5p276LeCjMqUXpBvGmiyDNacf54plYr0VyqUjJqL5UI79eR/ysk9TF?=
 =?us-ascii?Q?hBeAyTsJTGQ0nb+Qsgyjvw/CNa/oLmVxIgkeba8/RD/rdpcctDfAXmZyq8pe?=
 =?us-ascii?Q?YWPDbIyIRALVc1cyswqs+7EJi4M1RoZ9VXXf143pb+pOMY2QplGb12W+n8Fz?=
 =?us-ascii?Q?VfnqCZeWpbwswWywogPPx4rdYWVcR5vOyHMXOXlqo3VwL1WkvDjJ0cXx3M0Z?=
 =?us-ascii?Q?Up3gPeLP6R+wuc7yTNpQjjBi6/G5ziI7yFvRf8G0g7tocIzj+3FLld2wgaDj?=
 =?us-ascii?Q?u1rbn84cTENTi0/HC7YbJQW8NivT8gzgxAeAYzQYeKGomFcSgI3+E1TsI7k1?=
 =?us-ascii?Q?1si91Ja+wmq2oRZgeb91ophk4/wAb+weO/xEqqrc5lhx/G1Fo6EEjRZ60qYe?=
 =?us-ascii?Q?0+Xshhjuq6+ys9YNoqKZ/kA41ehu/rR3B7Y9PGJ8zLeDxQgeB2rX8BRfyipp?=
 =?us-ascii?Q?391bsNeIE4qjm+xTom5+eMr3q3LPTDT/xAVfhVVXX4nUq2l2bh3tYlVzFFJD?=
 =?us-ascii?Q?8xlfCZcefRBzBtLZoQq5uBaK7DCFJw4w+u4NCUonlK/fp+w1RNX2viDWwNbP?=
 =?us-ascii?Q?RUJMU3D0+9KeNNZTzcQf3HRjAeh7GE5hRRnxu7ruZEGGu48EbyHDBk/CbwVs?=
 =?us-ascii?Q?eVyiYE99d/c1F8mGsZ6HNmmnAyZjciXC4ErYkUtIFeuMKnzw5T5mcXyQgdwg?=
 =?us-ascii?Q?MaRCh+lNTPhy6HinZTVUCB/KD+zlSkpdx6dRaQko15YqS6QeyVNv6/RaXTyN?=
 =?us-ascii?Q?L8HrjQNXJShBnjzLHvBPQ5hZKokxvhv3lAfsi3Wn10Z8gfo2GtFRNlRIElhB?=
 =?us-ascii?Q?fnFRvl/pv2fcp7v/bEyVntFN2oSswhETjS7LBtpV3yXs8VvZBF4FhdMd4hf0?=
 =?us-ascii?Q?RA7xaHiqpQNDgn2GPvBtAlfNTo7hOnuTGAnD4aGbA+7XWxNH3IUIHjftNPaD?=
 =?us-ascii?Q?X8jdksobh/jdIPLOftavuMGiwoPMvQTcSL2wa+2j?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: EZciOVpZUNHzNKr+Mk4ui8VYn55tADz1+h4yxt7xBw16YDns6CmT+MzYxAKg/CSNsPr6mGEe5ikpoEKFtB/hgPe2qOzcESqLsBfwERbNI8St5tafb4hHVGGnPP22YJ3fIlULUATzotQEueEpP4LpqRXhNF77ncRmRErnTZkJsVr+d5Qb15DPAf6uCD6o170uPLzXtxmZimDnDUaTPVTMLpL9kEtKw84KyJGHn0yez8zUq33WE8VvjOk5frgWS88HZC7+dZL3c2/zyv+3ogXI0bsX6Z+AKGJk+fdq1F+quPAOkrxoC4I2QFy7/OVlNE1SG60nWtoiCGJoK/ZboTVMo3xjNCzgalS2OgHP2quLAMeEa33D4ab6AWLLNghBxvwkuwWYcD1u0zD+mprA6kIGLZ/+6ZwA3lEoWBYEg3RSvciyY9BeAOc2QUvZ97cjOK2p1TTZnCGfbOXGhGn68VN8jo7jzJgLA74JZs/ofY/jhh+gonxImmW9ZZyQEYNzhCt0EIOIxmuBjRNuEtruYxseok0ZTkzIjBE3ZcTV86DLmBCbO/OdEOlO5CQaZKpPM/h0vogpYSoey5boS2M/J++GUOvneaKQGEkwiacyFGzTo0pfbzECh/U+LteDCw4c3nonlGGz/wmJ64rrsCpa8lGd9vGQSBl8YBUk2CqVFC2Psy7MTbT5gWXDy3Nlcmd0HEBMDXt5daXHmTCOLJ/Fgn4QyXy7irbWsjyEAWcj4U/p11yGb/dOL4LaIysWtSK0KXU22Rv1bA4cMr3mJkuuiiZdXPRhcz92nYPemLH/NDM2cN0=
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR13MB2503.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02e62d50-00f6-4fdf-fc3b-08db2112d5ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2023 02:54:58.0887 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XJqIEmcvUY9m5KLyIZWUvvmi350jAuAH4jStc85iWDQwWI+cBxvZ989T+pNp4XZB/H7IlZMRTVMAWutqzusYBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3927
X-Proofpoint-ORIG-GUID: DjIFkOg5Xx2YImXPOdILweJzlvqY3G2r
X-Proofpoint-GUID: DjIFkOg5Xx2YImXPOdILweJzlvqY3G2r
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Sony-Outbound-GUID: DjIFkOg5Xx2YImXPOdILweJzlvqY3G2r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-09_14,2023-03-09_01,2023-02-09_01
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] ns_ifmove.c: Rewrite to new API
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



> -----Original Message-----
> From: ltp <ltp-bounces+tim.bird=sony.com@lists.linux.it> On Behalf Of Petr Vorel
> Sent: Thursday, March 9, 2023 7:59 AM
> To: ltp@lists.linux.it
> Subject: [LTP] [PATCH 1/1] ns_ifmove.c: Rewrite to new API
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  testcases/kernel/containers/share/ns_ifmove.c | 98 ++++++-------------
>  1 file changed, 28 insertions(+), 70 deletions(-)
> 
> diff --git a/testcases/kernel/containers/share/ns_ifmove.c b/testcases/kernel/containers/share/ns_ifmove.c
> index 12642c6f4..60dda94d3 100644
> --- a/testcases/kernel/containers/share/ns_ifmove.c
> +++ b/testcases/kernel/containers/share/ns_ifmove.c
> @@ -1,43 +1,31 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later

I don't see "or later" anywhere in the license header that was removed.

Is this the correct SPDX license identifier?
Maybe it should be 'GPL-2.0-only'
 -- Tim

>  /* Copyright (c) 2015 Red Hat, Inc.
> - *
> - * This program is free software: you can redistribute it and/or modify
> - * it under the terms of version 2 the GNU General Public License as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> - *
> + * Copyright (c) Linux Test Project, 2015-2022
> + * Copyright (c) 2023 Petr Vorel <pvorel@suse.cz>
>   * Written by Matus Marhefka <mmarhefk@redhat.com>
> + */
> +
> +/*\
> + * [Description]
>   *
> - ***********************************************************************
>   * Moves a network interface to the namespace of a process specified by a PID.
> - *
>   */
> 
> -#define _GNU_SOURCE
> -#include <stdlib.h>
> -#include <string.h>
> -#include <errno.h>
> -#include <unistd.h>
> -#include <asm/types.h>
> -#include <sys/socket.h>
> -#include <linux/rtnetlink.h>
> -#include <sys/ioctl.h>
> -#include <linux/if.h>
> -#include <net/ethernet.h>
> -#include <arpa/inet.h>
> -#include "test.h"
> -
>  #include "config.h"
> 
> -char *TCID = "ns_ifmove";
> +#define TST_NO_DEFAULT_MAIN
> +#include "tst_test.h"
> +#include "tst_safe_macros.h"
> +#include "tst_safe_net.h"
> +
> +#include <linux/if.h>
> +#include <linux/rtnetlink.h>
> +#include <net/ethernet.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> 
> -#if HAVE_DECL_IFLA_NET_NS_PID
> +#ifdef HAVE_DECL_IFLA_NET_NS_PID
> 
>  struct {
>  	struct nlmsghdr nh;
> @@ -55,50 +43,28 @@ int get_intf_index_from_name(const char *intf_name)
>  	strncpy(ifr.ifr_name, intf_name, sizeof(ifr.ifr_name) - 1);
>  	ifr.ifr_name[sizeof(ifr.ifr_name)-1] = '\0';
> 
> -	sock_fd = socket(PF_PACKET, SOCK_RAW, htons(ETH_P_ALL));
> -	if (sock_fd == -1) {
> -		tst_resm(TINFO | TERRNO, "socket");
> -		return -1;
> -	}
> +	sock_fd = SAFE_SOCKET(PF_PACKET, SOCK_RAW, htons(ETH_P_ALL));
> 
> -	/* gets interface index */
> -	if (ioctl(sock_fd, SIOCGIFINDEX, &ifr) == -1) {
> -		tst_resm(TINFO | TERRNO, "ioctl");
> -		close(sock_fd);
> -		return -1;
> -	}
> +	/* interface index */
> +	SAFE_IOCTL(sock_fd, SIOCGIFINDEX, &ifr);
> +	SAFE_CLOSE(sock_fd);
> 
> -	close(sock_fd);
>  	return ifr.ifr_ifindex;
>  }
> 
> -/*
> - * ./ns_ifmove <INTERFACE_NAME> <NAMESPACE_PID>
> - */
>  int main(int argc, char **argv)
>  {
>  	struct rtattr *rta;
>  	int intf_index, pid, rtnetlink_socket;
> 
>  	if (argc != 3) {
> -		tst_resm(TINFO, "%s <INTERFACE_NAME> <NAMESPACE_PID>",
> -			 argv[0]);
> +		printf("ns_ifmove <INTERFACE_NAME> <NAMESPACE_PID>\n");
>  		return 1;
>  	}
> 
>  	intf_index = get_intf_index_from_name(argv[1]);
> -	if (intf_index == -1) {
> -		tst_resm(TINFO , "unable to get interface index");
> -		return 1;
> -	}
> -
>  	pid = atoi(argv[2]);
> -
> -	rtnetlink_socket = socket(AF_NETLINK, SOCK_DGRAM, NETLINK_ROUTE);
> -	if (rtnetlink_socket == -1) {
> -		tst_resm(TINFO | TERRNO, "socket");
> -		return 1;
> -	}
> +	rtnetlink_socket = SAFE_SOCKET(AF_NETLINK, SOCK_DGRAM, NETLINK_ROUTE);
> 
>  	memset(&req, 0, sizeof(req));
>  	req.nh.nlmsg_len = NLMSG_LENGTH(sizeof(struct ifinfomsg));
> @@ -115,20 +81,12 @@ int main(int argc, char **argv)
>  		RTA_LENGTH(sizeof(pid));
>  	memcpy(RTA_DATA(rta), &pid, sizeof(pid));
> 
> -	if (send(rtnetlink_socket, &req, req.nh.nlmsg_len, 0) == -1) {
> -		tst_resm(TINFO | TERRNO, "send");
> -		return 1;
> -	}
> +	SAFE_SEND(1, rtnetlink_socket, &req, req.nh.nlmsg_len, 0);
> +	SAFE_CLOSE(rtnetlink_socket);
> 
> -	close(rtnetlink_socket);
>  	return 0;
>  }
> 
>  #else
> -
> -int main(void)
> -{
> -	tst_brkm(TCONF, NULL, "IFLA_NET_NS_PID not defined in linux/if_link.h");
> -}
> -
> +	TST_TEST_TCONF("IFLA_NET_NS_PID not defined in linux/if_link.h");
>  #endif
> --
> 2.39.2
> 
> 
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
