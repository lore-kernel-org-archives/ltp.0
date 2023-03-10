Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FCB5C6FA99
	for <ltp@archiver.kernel.org>; Fri, 10 Mar 2023 18:11:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B15873CD82A
	for <ltp@archiver.kernel.org>; Fri, 10 Mar 2023 19:11:42 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7E5A73C9ADC
 for <ltp@lists.linux.it>; Fri, 10 Mar 2023 19:11:30 +0100 (CET)
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com
 [185.183.30.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 00D32100117F
 for <ltp@lists.linux.it>; Fri, 10 Mar 2023 19:11:28 +0100 (CET)
Received: from pps.filterd (m0209322.ppops.net [127.0.0.1])
 by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 32AI0YKX023252; Fri, 10 Mar 2023 18:11:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=S1;
 bh=PnoY9lMX/DzlIBWiFG/pYisj4d18c5uCoEhq4C2Sr+M=;
 b=d5QoYF15ewmYGvppT1+NgV311R1L+mYMv0df3VBCibesOG1CynJWlu6szw0EDfsadze+
 xdeZ/H3IJxyK9B/VlmUtom2gCTPqOBxCmPBYrmosL/wwEQVbdvxhN9GOPtf2HoIXGGHr
 bobyz7L5TnrolClvQOA1cQTMdxyDMQ2UdV42JRhYrejomFCUaCQmkSmqibLWpA70+fED
 T+9W3p7baXTOwx+7vdRv/iLr4Dji0DQxgJrYUEq2D0hn/7hgktk5A4j0Z4dRVaBWmLyu
 NUABiv1MlrjdWBH1IsYmKOW1cEriAPETy9YfbpIwP4npkDpMRkvoRmq1PhIATAyWyoI6 3g== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
 by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3p6g62ty8b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 10 Mar 2023 18:11:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CFl+HTCnV1RPu+xqXat1RQylNN4EgxoebtyT8hVWP0dK2vAs0wLykiop374AryR8kv6Djhv1l9NQPMMEYVYV2+xDCxH+YNHFyQoEe42By0bMHy0FYLRTaRZiZmWcbVSygC31HqUY7Dfhv/te9cZUrH5oN7B/oci0jGWQXOHWZnb6lU/gHx8w7+e4zqUYuXLRC59YF03GWRULY1oa852kkWmxSwugzDQ9g/ZX2Klm0zo8T61atWqNTti1/ou2lNUTtpa5oppXEYhv1jQIn3/0oCBMn91icoQ1Rnz99Gu+4gXqG/rUAYavg7wKvkMeZmA0whSnD/bvfKxZh99PTRj1gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PnoY9lMX/DzlIBWiFG/pYisj4d18c5uCoEhq4C2Sr+M=;
 b=Amw6+0kbxbU+ks7s/xlSTlRhKbD4N0OQd0cZWgg3/a1qDOSvukeRYE4KK1+LCV2KYPwokhfUG/STBlUJ04hD00Drbadz5CuCY1Onl7vIg8HKGn4/04uqMqF3RdlNlNpq4TmZti9bqye02BU1R2aFbsBuQP0eFr9tO3dcdoa/NARAZ6YaxWMJRa7SXL250V8SC6AKLZ06YPmQymqzRN2h2VRlvNVWBt+Ht0pRhmPru97SrVkk6zci49mhLi3JgyTSUsg+AkRhDQja4b2kW1GmBKVvY7bbbCzT6vxsCfHGotrvMSTcW4v2PS4O2pFvfpIkFqKLA3N4y0w3J1Re5F4V5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from BYAPR13MB2503.namprd13.prod.outlook.com (2603:10b6:a02:cd::33)
 by BN0PR13MB4741.namprd13.prod.outlook.com (2603:10b6:408:115::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 18:11:21 +0000
Received: from BYAPR13MB2503.namprd13.prod.outlook.com
 ([fe80::f41f:44f5:862f:410b]) by BYAPR13MB2503.namprd13.prod.outlook.com
 ([fe80::f41f:44f5:862f:410b%4]) with mapi id 15.20.6178.017; Fri, 10 Mar 2023
 18:11:21 +0000
From: "Bird, Tim" <Tim.Bird@sony.com>
To: Petr Vorel <pvorel@suse.cz>, "ltp@lists.linux.it" <ltp@lists.linux.it>
Thread-Topic: [LTP] [PATCH 1/1] ns_ifmove.c: Rewrite to new API
Thread-Index: AQHZUpfHes8yRfVkpUquOIPjrjQ+Ja7zT/EwgABQQgCAAEbhgIAAaqxA
Date: Fri, 10 Mar 2023 18:11:21 +0000
Message-ID: <BYAPR13MB2503C9BF7ED9D78FAD55E6FEFDBA9@BYAPR13MB2503.namprd13.prod.outlook.com>
References: <20230309145917.26846-1-pvorel@suse.cz>
 <BYAPR13MB2503F6AE85D17F078B806C0AFDBA9@BYAPR13MB2503.namprd13.prod.outlook.com>
 <20230310073406.GB2216@pevik> <20230310114747.GA5055@pevik>
In-Reply-To: <20230310114747.GA5055@pevik>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR13MB2503:EE_|BN0PR13MB4741:EE_
x-ms-office365-filtering-correlation-id: 7da9da77-6147-4b30-e928-08db2192da46
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FQxLm3daPQazpL+9K6CLz7fVB0o63JUeNvbeZ8YQzc6Xy10dRsXsNhDJ6gm07GTj0zpWtW8cTlnnjOpXgoPJDRpXcR81BVUy8Wxq6ISIYahsGwN/ImZs63VMFfwZOCPP0xSEEGweSSyXPdHd5V91cZ4ueG/yWdqNKPXjv6RBJftkVz1KlZ0p2P/9/0q57cHPvn9SbVVObRTnjIRpz9vEaq22lOsfGtHpHxl3wbfv3V6ZfkIJkNEiJylZVQ4WEuwbCsgsG7Q9f7Q/gZUiQw5xyAuOoPpf6vG4veTirsfi2YBzFScbz8+a3ZsrAG1GNCdtxOvnc6t6a7JbLlbIRHe2tL1aDDVrXcsiM6QkOKT07T9Dwi/2zWWpQnX5BIJCh6lBPD4VVKLg0ycYcbH5R2LKh08Szn42lNrMsrXD8cyTa+q3Zx31zbi2+EV6AGz7bph8qZpcCdqie/3Hh7ehOUBxpmNm1iF5jTHjSdfkrb/4OIZ8wHy33Q2xnnr/BuOlq7+Vt+/xD2fMyLoiLVlq3DiC2GPGyXNOqJ7gMeNdHRmF6ba/s2jcFH5AJqlXKdqqmz9BvhRqMYKkmQX3iUgme7yrLJc1xcFo5owx+3xL+tFXizX1gxXqKxq6fi/r3S87iAui752bQ7/3pAmVizrh6MpNONnC3IS6ZaI3C+TL3buWtn2L0orabI7FNT3r+cXvmDwL4BMM9Ik9SPmbSXcyk/xyxQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR13MB2503.namprd13.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(366004)(346002)(136003)(396003)(376002)(451199018)(5660300002)(83380400001)(66946007)(7696005)(41300700001)(6506007)(71200400001)(186003)(26005)(9686003)(76116006)(4326008)(38070700005)(478600001)(316002)(52536014)(66556008)(33656002)(55016003)(66446008)(8936002)(8676002)(66476007)(64756008)(86362001)(110136005)(38100700002)(122000001)(82960400001)(2906002)(2004002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7UGiSL/vggPcQJnqMZhxSfm31r+bldmfbPmp+rQIJDkguQZm0Npgzbx9mNd9?=
 =?us-ascii?Q?h6wAYw66j+uYGCminzg5peNmw+0lZ1S2TJwwFnt0TIdwis0VDCP26yRforg6?=
 =?us-ascii?Q?0fF2SWTDjhcM3qFaQHsvYczwpETkl2DIYg7YSyBGgZRu6DHL52UMlJ9Luadt?=
 =?us-ascii?Q?FwP3OiHcViBrKJTrXvSsVfKUyejgsZYE/Sd3kWjCz6v9Vl4lbW5+EWMOHIwX?=
 =?us-ascii?Q?KM+ysT8Lrrzb6jAfLlZCCrxbnXBMBM4Ut5pn0jqtqZUD5e+vi/1oz7a13Wpi?=
 =?us-ascii?Q?4+IJ87cEmnZw8HyyR8/EYxXyM2hpkqaR2w9H8T4xHykED3JX5oLYqk04vpBm?=
 =?us-ascii?Q?Z7xTeKXrQQWM8VcpahivKEPQn0/E0Ou9riLrbLUyTu18mPHNdvPI1iTgjnmi?=
 =?us-ascii?Q?8n7SA/H1UJc62S++e166RoIdcUFthmmqZyCG3ToBHvPB4SXZoLgGcto0nhRd?=
 =?us-ascii?Q?v3kyymlzpbQ3UPuyQiIBFZS6QtNnpP0ehozrE2ex9X4hYN0aIsqFSrvzkdMa?=
 =?us-ascii?Q?zHF5h7+9Rrm0s0jDclGgQxTxHhhz25aCQwGpvv1sUWwodlYEC2shzqn5Ax8R?=
 =?us-ascii?Q?F9e5RmXby9dE+IF2iL+CeHD1Gt/c7wDFL8boa1BQOuNrV4GL4SYoQf0qtZpL?=
 =?us-ascii?Q?OFE3EjQWZW5NPtDEIv5zuUnKFCc4ISkUzMoDlt7h8Hjd+QoLTG7eOLJNoeJB?=
 =?us-ascii?Q?KEtulq/jMx2tBaW0uMy5gx2omVn+3g7i6yLEGkv19R4kzDApPfvQSyfw36E3?=
 =?us-ascii?Q?PM1DOe8xUNDlJ+EiFCtHNLmAA3gDAP3LhB/QNkmUkpRTrirsfzzewjsL4/37?=
 =?us-ascii?Q?rdUAyUIbPKNv0OQq1B4T2qQTw60NAClJdPQrPnAWOgCCaRtN9O/tfI0bLBjD?=
 =?us-ascii?Q?InU4VUt7ZwJKUr4CsVGPxmgx7dr+N5f8BiuXP+e1q2wFVKhOJkYx7YGuNbE8?=
 =?us-ascii?Q?yTNq4WdHw5g1cSzTpVoDCeVCqnApCvt7maHQCSyjAKPb+rc/wffjAspey+IN?=
 =?us-ascii?Q?tfG1QBfskfxEuPC1s0pdNq5W1nTwAxxeh1rwHtgLQev4/OAIqL4gswz4yJ9o?=
 =?us-ascii?Q?+2fKEAlF4lhvSb4yrdhi2CVtPJrgYJDQP8JPb1L3Wx/zEN+sjD9x3FO6uxbM?=
 =?us-ascii?Q?nRiXxy3rDhpW9uke5DxvG7o4UBOH//5dSm7WFdr6fndjB2i2kdlBN7oWC6v4?=
 =?us-ascii?Q?Djdt0tL4b36pH2YLpYftm20eafFvL3rYH6+GH30/6Chc6NNXjXmXLYZNJyk/?=
 =?us-ascii?Q?kEsmUd1A2CS9N9I33NSOdHfn2wdK+7ooMmOXB38l+aQiumFjs0+/L46VoH88?=
 =?us-ascii?Q?H13MkEZxMSELGzWyVIGszYO2CCmpSiafGJdClePmiuumuqZsQCqXI1167qTU?=
 =?us-ascii?Q?qJ6ld1KH4gL+1UBayQYyZZOU4xi+7WhYHaDaeeSDQIQll2X+P7HiSWoqTjTu?=
 =?us-ascii?Q?as0I+5O0+lEMLXtDMcUCH7MSwQ5OI9NVKR1kU4EyrAcJPgRyNVN6KmrsTZ6T?=
 =?us-ascii?Q?yfJzN8/gUiwD6OYG0iY/fyHgRyJhhKNWdgvmuPnf+0L4iJ7hGsZM/3jMcE+M?=
 =?us-ascii?Q?vs/fUiEJfrGxAh2eFcVdwM8722W2Pus/SPXmuU9R?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: izP/LyOWZLO0+hCb9HvHd6ctVSxLI0zBVlM2wvgaDO4YB5GYzFyy/oTPC35E/f5fL+S5hmiuXsjbeWDQpDXWJhmO1qN4av5PnHAGmP6kHiq8PqCbe/g69uCMF1mrXptfyQDEW4156rRBE/NKbuDz8E5eudH03InyfZJctBynXgQyHA8S2m+lO2PlzwdoosuAm2ykMQf8DaTidWLX9NFQDjmwq3FQRVh69IKDj3VPMSIr+cVkxLrs4BzVgeSCmwc1fsbfL53f8W/2mHkbJEFAT1bdXhGqDBKXFT/XPRKux6NAT++nnTAaV70VfXRFRdcFv3vOUSD7kZixVBzIfQqYwXWO2dQnXunIMMSNg9yPDwfevy+gbKJ0Y+EslI+pM5qL8h18UBRi/xSbjvHoUPIz55Cr+WNesnlFitMhrrGtJZ00d21YilRwDAROtAl5c7MD8idMuqJYINp5UmBbvlqVLLeaB0LG3XTCwjuXSjoR2Q3B+H5g9wNH9vX6y44kDhsxLxgf3Qitdn+08+xB7UywhVzsdvfnrUa2nirvU14BkTVRYcKa+VnqKopNHyJ52kKSq12iVFL3IxyaEQRAaYZk58vVMl4B3Ngv9je9B5NgxakymWP8D8WXajt6KCy3zzMDvi2iW2YZ/eCFmcfOAdm6qfl29eYL1JYgkrBwPGBVOz11mPPT0KpeXz0czN2MPc+NUdnQVq73GWtbHQr88AvwynSdSP8yt0lqvywcaGvPQRDEgXbbaPH2uuWuCOtWqy52E6lL2gqkItzRR7DX2vZCVslOwvGxL5hQIIetz4CEhEUNdKv+bv7/vAX4usonZ6zDaQpRfRicY9jQRFwGebnxbA==
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR13MB2503.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7da9da77-6147-4b30-e928-08db2192da46
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2023 18:11:21.3923 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nlLw/8LYD6c1PLrd3iTSfj89Wzhfl6BxlbHJeR3nmUh0UTqbTasQMaeUbV8sAV2NT3HLj14s/kDi8D5cD++0pA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR13MB4741
X-Proofpoint-GUID: Q9kQI3tAoHLRGfRPXDy4ptpgub80XkNT
X-Proofpoint-ORIG-GUID: Q9kQI3tAoHLRGfRPXDy4ptpgub80XkNT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Sony-Outbound-GUID: Q9kQI3tAoHLRGfRPXDy4ptpgub80XkNT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-10_08,2023-03-10_01,2023-02-09_01
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
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
Cc: Matus Marhefka <mmarhefk@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> -----Original Message-----
> From: Petr Vorel <pvorel@suse.cz>
> 
> Hi all,
> 
> > Hi Tim,
> 
> > > > +++ b/testcases/kernel/containers/share/ns_ifmove.c
> > > > @@ -1,43 +1,31 @@
> > > > +// SPDX-License-Identifier: GPL-2.0-or-later
> 
> > > I don't see "or later" anywhere in the license header that was removed.
> 
> > > Is this the correct SPDX license identifier?
> > > Maybe it should be 'GPL-2.0-only'
> > Good catch, thank you!
> 
> FYI I contacted Matus Marhefka privately and got his ack:
> 
> 	I am not on that mailing list anymore. Anyway, feel free to re-license any
> 	of my tests to GPL-v2+, you have my agreement :)
> 
> => going to use the original version.

Sounds good.  You may want to note this authorization to change the
license, in the commit message for this patch.
  -- Tim

> 
> Kind regards,
> Petr
> 
> > Kind regards,
> > Petr
> 
> > >  -- Tim
> 
> > > >  /* Copyright (c) 2015 Red Hat, Inc.
> > > > - *
> > > > - * This program is free software: you can redistribute it and/or modify
> > > > - * it under the terms of version 2 the GNU General Public License as
> > > > - * published by the Free Software Foundation.
> > > > - *
> > > > - * This program is distributed in the hope that it will be useful,
> > > > - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > > > - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > > > - * GNU General Public License for more details.
> > > > - *
> > > > - * You should have received a copy of the GNU General Public License
> > > > - * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> > > > - *
> > > > + * Copyright (c) Linux Test Project, 2015-2022
> > > > + * Copyright (c) 2023 Petr Vorel <pvorel@suse.cz>
> > > >   * Written by Matus Marhefka <mmarhefk@redhat.com>
> > > > + */

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
