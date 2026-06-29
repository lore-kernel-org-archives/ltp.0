Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04EBFC43458
	for <ltp@archiver.kernel.org>; Mon, 29 Jun 2026 08:46:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 070293E4BF4
	for <ltp@archiver.kernel.org>; Mon, 29 Jun 2026 10:46:36 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1F62F3D7220
 for <ltp@lists.linux.it>; Mon, 29 Jun 2026 10:46:19 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 1583360068A
 for <ltp@lists.linux.it>; Mon, 29 Jun 2026 10:46:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782722778; x=1814258778;
 h=date:from:to:cc:subject:message-id:
 content-transfer-encoding:mime-version;
 bh=lGGxIsBGp3p5gRZgvUKrKl/gGxlUaxlcmWUHO4vrB6M=;
 b=Z5eUvDAA9kBv0GujwuWNZv84otexs2Xp+y4PL0rEBzmQA88DdKmC2Dnk
 FGxorsMmVwld4p9P4ohVk8DpgC+n/vGIIuuxOTAnb8ZAY250KsIEz2Uy7
 SPAuGUlDpEOvbWh+bAoz3YpEQctOTOvaLLmBrLFx+t9ZBNB5fXymHHB0t
 9WU3ApYwxfGx0jQEKHo4fX/6AqcOO2zxw6sqdlD2+X7rrma7ikVxDJnFw
 vGwE1TJJmwRNIhNIHYjI+35m0fK0SSXH5w4ecTtSsv3lBvDmiKuLQd9UQ
 leN8nf9oYLa6e9+JE0YQXT64qup9CpUEdqXUeCg3eVXI5vM3wX9OvtbMP A==;
X-CSE-ConnectionGUID: RNJWW+aeTpqHbrjvcrebXw==
X-CSE-MsgGUID: U6bcShwXRfG1SOcVU+JPhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11831"; a="108946129"
X-IronPort-AV: E=Sophos;i="6.24,231,1774335600"; d="scan'208";a="108946129"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jun 2026 01:46:09 -0700
X-CSE-ConnectionGUID: voWCFmfkTNCB/G+1KmXxbQ==
X-CSE-MsgGUID: vkVHmWHOSi2z4Z/GygY1/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,231,1774335600"; d="scan'208";a="252537529"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jun 2026 01:46:09 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 29 Jun 2026 01:46:08 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 29 Jun 2026 01:46:08 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.21) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 29 Jun 2026 01:46:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lQSvcTGeBeMFqKpBLXmPHqvo5nyLfhZ0Hsb91WGcWak22yL+0/kLl1M3pC83W/ZU05I4ZYEs7m93Vxk3oBbBo1Qb6REiFkrDJwf8iS/qM/ss0kgO1BaejSqbQyc6tyW11m3Q8w1aThYZu+qvCPM0MKQCRjakk4ww5JvTmp0G2QRWSpyjHVNug+vXiJiPS+UHufucYTgKWj/rds3WS3eVnPiopEtTZ6evOURP05rf+rp8w+pSS3aP6BV/KTrWwogF42/q1TxLByBCviUg72Kie+f+wYx8M4mAaKhGROEzp/+4BdXcz/OcbQh0v9Peh5oxZCXaDP00PqwvW/7MD6TzGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DIr9goKhFWmZbiUzU5dbrzSyhrKWcWzrJihbPs/Qu5g=;
 b=E35bD1f6FIlN3ox4FV7SIuxEwXMr7AcXVjHuj0+xbiUFipl0W5musxA1eP3yR7ClrSMw2Cy6TUQF56XrEho5ikckcI5ASEVh7D5ibu7gZBgStzetUddwWPZoF9OOmuUeC2gEV9P9czIWkKJ33SHvjGUoFKhLoOKLQz+IdCB9O7emoxZzfxKWXyQ/JIEPK+ZjKO9xvemh9LFE/MaRxkF22FH0brPzJNU5IG7KbVygGQveSHt5vay0n6usYh1Wf5UPS3RvIhr0aIIkHbkX6L41MJC/SH0LibAC+TbHvmkCW+2ztVHwkzxYC0tv3a81578Q3cxfcfMR8o7KCuI6pDrzTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7)
 by SN7PR11MB7115.namprd11.prod.outlook.com (2603:10b6:806:29a::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 08:46:05 +0000
Received: from PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707]) by PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707%5]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 08:46:05 +0000
Date: Mon, 29 Jun 2026 16:45:58 +0800
From: kernel test robot <oliver.sang@intel.com>
To: AnonymeMeow <anonymemeow@gmail.com>
Message-ID: <202606291514.594c4370-lkp@intel.com>
Content-Disposition: inline
User-Agent: s-nail v14.9.25
X-ClientProxiedBy: TP0P295CA0059.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:3::12) To PH0PR11MB5832.namprd11.prod.outlook.com
 (2603:10b6:510:141::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5832:EE_|SN7PR11MB7115:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c37ad7e-e081-4f3f-dbac-08ded5badb3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|3023799007|11063799006|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: 7SQNVFEZEE/Oh+PIvoM3RQbDY6cyzmKU15MqSOdwOscuCsHI7dQDYTyoWjtZ0rk+iuNB3eai7c/dFirKml3hytpNZH5xbdh7m9VUMBuUlEOtUOxlHm2KKUSTHFHvhqTO1/xswQ5Pm83eJshae5s/9A5sBYfsTWmHRKiY4Lu3+K+UyOLMoYe5eHA7wHH2FC+a9PKSO+9EZ1rwYaWps9kmvFfNJPZkoZHkWec+F/PDCFENX/b8oHiFxUi7axuyTL20BGgntatzFqz0LUrS4gzcpdxDJajup0VE8jcw1pc7F+Mmdi42ds+sG6wiq5N7Mftk/lhAKxT8ThL/WTo+Kqp2qM84/7E3C6GqQt7fhLUL30Wl+y4wVwH6T11N10H0vzkS+M8v9PMZopkHZW3QXodsvYlCzobpo6lCB2atRdluIkkgguITRiUpbfxxN2mMRiIsoBTQVOMht6JpT2iXCewuWuRPmathYhBuGGIsQKrhAMF+pdhTFWDQv4HqBXsxuf6YqLaooYKaSEwaxnAEsPI4c7mTyYtCaAKfyiLpn7Vh3CCnCUA70JzqRZHkDQmibXOSmrJOTFc1pPDhHC9ZqlCVg65YTvW2UccdkUK3K7GrxKFIyTlZZzxmw3Um0MPm9nFF
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB5832.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(3023799007)(11063799006)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MUEzS245QVduQnowdXJKYW1TQ0xSZE5oYkZNY2cyT2owM2hwSTB0blUrc0ll?=
 =?utf-8?B?Miswb0hGUnA2Wm5NTHhXVGJIL2tlQmlGd2V0bzdueTZDbk5HUVpUckhHTGtY?=
 =?utf-8?B?bUFWaExrZWRpUUNCL0E1eG13d3Q1Vithb0YxcW5SREk3bDRUOUphYlJPSll6?=
 =?utf-8?B?U3RMKzhsNmhLM0M4OVA0OFFjYi84WFFRQ0JuU242Y3dLVUZGWkFSY25KVmk4?=
 =?utf-8?B?MllKT0RLZGNGVEJVRmNlZkxhd1drR0s1bk5XNTRTTXkyV3VXYnZ3UDRwaXNL?=
 =?utf-8?B?YnNqa0tNdFFuMWJFVDM3VmRySUtlMWx1dXhFaS9PS1AySENXd0VKTkxkQk1F?=
 =?utf-8?B?RXFzTjhFZERaWHlDTW1pMlprMzIzV0JmcmM5aFBNSkljRWNhV2NKZUd2TUNx?=
 =?utf-8?B?eURUNmY3UjlvMVRGTmFEVHF6OVRseGt3SUhCRnZBQml5ZDdtZklSSzd3OTc2?=
 =?utf-8?B?ZGYxVDlUeUV0Yk43N2YvM1NXUTBSRjd3a1BBNVJkcU83aTJmdkhZdnNpbC83?=
 =?utf-8?B?aDlsbmNRWm5ubFNqeHJ4bjlHR2M1RHRaOW1wYXJDSEZHcjdZZTA5cjNhRDVI?=
 =?utf-8?B?QWFCOFdRVmJKVm4wRUxKeGMrSEE5OCswWFVvL0w2SVMwUWRyWXBiZUVPdHZk?=
 =?utf-8?B?WXp2VFg2a0tkMzRGcElqbXF3ZnRoZytVV2tEazZ6VVRra2FuTzIvNkx1OW1i?=
 =?utf-8?B?aVc0TzJ1MnR1RVlKNHFaN3hZQlFZcEgrWEh2NlZLQjhXWGJNalhCaXY0QWx4?=
 =?utf-8?B?OWNUb2tjSmY2WVpPZGZuQVp0SUhIdmlhTHNkc1dtbjBadndPc3VQdWFWVDMz?=
 =?utf-8?B?WEFJQ21Nd0E0aEFaNkx3RnNBVUs3ZXlQMWtzdnMxSjZCSXNNRk9HVUFMVWZT?=
 =?utf-8?B?RlpROVMvMnRydzNvNGRxb3ZuTGpLRUVwbko1a3Y2RWg1R3VNVHoxZ2ZJOUdx?=
 =?utf-8?B?dHM1U2xVRTdqSVVsVXd2cU1oT0ljTUNQQ2lSQWxZRTJSUDB6VHhJRWp0Umwv?=
 =?utf-8?B?OFNSRzU2Nm41ZGxydU1xbTE4SGJmM3RIaHlYaUVEWXpsNjRReElEOHpxVDFD?=
 =?utf-8?B?VXNVWUgwdGFjSGk1OGt4ckVCNEl6bDU0bVh0VFpEYTAwWVNia2xxZFh1eDZ2?=
 =?utf-8?B?dysrZVJrOFpnV3I4NkJyeTQrWmU3bkk4M25qYWZHbVhjTXltcFdiNnFmN0xy?=
 =?utf-8?B?RXlvdFVPdys0bDYyRHNXcDZOV2xrVUxxUUQ2YVZXeGs5TmxvUm91eFpURElo?=
 =?utf-8?B?S201cUFmS1p3SzBtNkRhRkRTMHkrUm5KM3lyaDF4ZXpHcURpa3J5cW9WbFEr?=
 =?utf-8?B?K0tIaVorZDN6VE5ES3poTHBUV21OTGRBdXJmUE1oY3FnTC93UWhMNlpJbVRC?=
 =?utf-8?B?a2ZGUGZnYzU1TnVGVFUzaUJYWUc0b0lwTnFvNFRCQ1JHeURCOHEvbHZrdHo2?=
 =?utf-8?B?YmVCaW92QkhiVHNwU3QyWndHQVFFMDdrMFQvdWUxc004bFBLQ040V21DVGV5?=
 =?utf-8?B?bGljNWY5NW5URmFUNTQ2WE5wZzcwZ1FCdjQvck9NdWpOWHBNWFdUSDIzRWZs?=
 =?utf-8?B?ZnIvNnlZTi9RMXY0eHhtUCtQODBranNYWExpTzlYTE1ieHhVb2loM0RqbW1r?=
 =?utf-8?B?RDFsckJHRkR4SjhjZHVKR3B5dWVaakF5cFpMbUlDYjk2eHBMTXFXVkJmUUQz?=
 =?utf-8?B?QVErOTJKblpaMXZlbkh6VlYxNzF4NlFuWWhMOG5WeUFuSlA4SG0waTdncitZ?=
 =?utf-8?B?NWZjOEpVMyt3Q051RXkwMktKRFZvMUZqOVVPSEROTis0VTRDcUxBQzRiSGR5?=
 =?utf-8?B?WEZiSWFXU1VreForZERKM2Fub05vT0pKdS96Y09UdjI5dHN0aWlhT01hVlc0?=
 =?utf-8?B?Qm5nNVlyMmdZekIwM0YzcVAxbUI4RyszZGFXZjF1YTVtalhnS3gzV0F6ZjFU?=
 =?utf-8?B?ZzFYUFJMd203N3hjWGtCTlZna3RrdUJtUUxzbFM2NW4zdnpsdmMxZXVLOHlW?=
 =?utf-8?B?LzZMaFNhNXl0RitxZm81ckdTVkhQcFlWZjRwSGpGWjBGYnZ5VDFFNXBGVk5n?=
 =?utf-8?B?d2E0UTUxMkhnUU9qVVJOTUc3aHJNNml5cnFQSHJrQzhwV3BtVTRMZ0NhMWdk?=
 =?utf-8?B?czA2NFB6Ri91d2xLUUpKdFpLN2xzSC9UTEpCKzFubVFpektCc3VpK3hZQVU5?=
 =?utf-8?B?Y2RidytwaTZXRk9OOEM4YjlOZmFYNEZXdjh1czRMRlpjaG8wU3h5Z1lKYWFR?=
 =?utf-8?B?cUtWQ3pIOHB3cE5zK0hsSlExTm84OFJmajFXcHZSRzhjbU5xUk1mdmJRaXN1?=
 =?utf-8?B?WkRnd2xrQzlaV04xOWhZM0RFUStKOTdiN3lWbGx2M1prMC8zRGliUT09?=
X-Exchange-RoutingPolicyChecked: KCSYIQJcFR8Sz2R/UaY5h6OuJf3CSXaOAB6BUH46NeQjXOD7aTrIbUD2tSh0fJ3n069nlMGqSToxCkDYQk9dJoDAromZPG5Gj/Z/RT0LKvhPntpHBCxJ/OcXthnnDQgmUG4WP3+ac19YKZNeNG4fF5N6chZ9TJwUls6aYcrvGJLA8mnuv67AgkEk8/St+I5R7XUalf7tTfFrV1k8F4cIMzsFwDg/waov1/uofCw/ElCKVM3e2icFBvgSnG/EhOnl/5cMYdVLGt93DKQlpgHL1/sFu1KQ3uF+8O8WL6NdvQakW1a1/hNL7SyuMfJXJYl78m9VyNbbiSnFHxY6WtAdRA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c37ad7e-e081-4f3f-dbac-08ded5badb3c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5832.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 08:46:05.3056 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +G/kjv5NJhpN9Jmb3lvoEl3v6QBJYtyyt6uudUBcfi0q7XcK91NqZATN+SiMvlswvHliQY59OZ2VOynOgkzflw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7115
X-OriginatorOrg: intel.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [linus:master] [fanotify]  82c6dd2047: ltp.fanotify21.fail
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
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 lkp@intel.com, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 oliver.sang@intel.com, oe-lkp@lists.linux.dev, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

CgpIZWxsbywKCmtlcm5lbCB0ZXN0IHJvYm90IG5vdGljZWQgImx0cC5mYW5vdGlmeTIxLmZhaWwi
IG9uOgoKY29tbWl0OiA4MmM2ZGQyMDQ3OWJiNmE5NjI1ZTFkNjNhNjUwYzNiZTg4NjVlMmRiICgi
ZmFub3RpZnk6IGFsbG93IHJlcG9ydGluZyBwaWRmZHMgZm9yIHJlYXBlZCB0YXNrcyIpCmh0dHBz
Oi8vZ2l0Lmtlcm5lbC5vcmcvY2dpdC9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4Lmdp
dCBtYXN0ZXIKClt0ZXN0IGZhaWxlZCBvbiBsaW51cy9tYXN0ZXIgICAgICA1YTY2OTAwYWZiZDZi
MmEwNjNlZWJhZDM1Mjk0MDM4YTY1NGRlMmIwXQpbdGVzdCBmYWlsZWQgb24gbGludXgtbmV4dC9t
YXN0ZXIgM2Q1NjcwZDY3MmFlMDhiOGM1MzRiN2JlZWQ2ZjU3YzhiNDRlN2I0M10KCmluIHRlc3Rj
YXNlOiBsdHAKdmVyc2lvbjogCndpdGggZm9sbG93aW5nIHBhcmFtZXRlcnM6CgoJZGlzazogMUhE
RAoJZnM6IHhmcwoJdGVzdDogc3lzY2FsbHMtMDAKCgoKY29uZmlnOiB4ODZfNjQtcmhlbC05LjQt
bHRwCmNvbXBpbGVyOiBnY2MtMTQKdGVzdCBtYWNoaW5lOiA0IHRocmVhZHMgMSBzb2NrZXRzIElu
dGVsKFIpIENvcmUoVE0pIGkzLTMyMjAgQ1BVIEAgMy4zMEdIeiAoSXZ5IEJyaWRnZSkgd2l0aCA4
RyBtZW1vcnkKCihwbGVhc2UgcmVmZXIgdG8gYXR0YWNoZWQgZG1lc2cva21zZyBmb3IgZW50aXJl
IGxvZy9iYWNrdHJhY2UpCgoKCklmIHlvdSBmaXggdGhlIGlzc3VlIGluIGEgc2VwYXJhdGUgcGF0
Y2gvY29tbWl0IChpLmUuIG5vdCBqdXN0IGEgbmV3IHZlcnNpb24gb2YKdGhlIHNhbWUgcGF0Y2gv
Y29tbWl0KSwga2luZGx5IGFkZCBmb2xsb3dpbmcgdGFncwp8IFJlcG9ydGVkLWJ5OiBrZXJuZWwg
dGVzdCByb2JvdCA8b2xpdmVyLnNhbmdAaW50ZWwuY29tPgp8IENsb3NlczogaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvb2UtbGtwLzIwMjYwNjI5MTUxNC41OTRjNDM3MC1sa3BAaW50ZWwuY29tCgoK
G1sxOzM3bWZhbm90aWZ5MTU6IBtbMG0bWzE7MzZtc2tpcBtbMG0gfCAbWzE7MzNtdGFpbnRlZBtb
MG0gICgxMi41ODVzKQobWzE7MzdtZmFub3RpZnkyMTogG1swbRtbMTszMW1mYWlsG1swbSB8IBtb
MTszM210YWludGVkG1swbSAgKDI1LjQzOHMpICAgIDwtLS0tLS0KG1sxOzM3bWlvcHJpb19zZXQw
MjogG1swbRtbMTszMm1wYXNzG1swbSB8IBtbMTszM210YWludGVkG1swbSAgKDAuMDM3cykKCgou
Li4KCgpFeGVjdXRpb24gdGltZTogOW0gMjlzCgpEaXNjb25uZWN0aW5nIGZyb20gU1VUOiBkZWZh
dWx0CgpUYXJnZXQgaW5mb3JtYXRpb24K4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSACktlcm5lbDogICBMaW51eCA3LjEuMC1yYzMrICMxIFNNUCBQ
UkVFTVBUX0RZTkFNSUMgRnJpIEp1biAyNiAyMDowNTozNCBDU1QgMjAyNgpDbWRsaW5lOiAgaXA9
Ojo6OmxrcC1pdmItZDA0OjpkaGNwCiAgICAgICAgICByb290PS9kZXYvcmFtMAogICAgICAgICAg
UkVTVUxUX1JPT1Q9L3Jlc3VsdC9sdHAvMUhERC14ZnMtc3lzY2FsbHMtMDAvbGtwLWl2Yi1kMDQv
ZGViaWFuLTEzLXg4Nl82NC0yMDI1MDkwMi5jZ3oveDg2XzY0LXJoZWwtOS40LWx0cC9nY2MtMTQv
ODJjNmRkMjA0NzliYjZhOTYyNWUxZDYzYTY1MGMzYmU4ODY1ZTJkYi8wCiAgICAgICAgICBCT09U
X0lNQUdFPS9wa2cvbGludXgveDg2XzY0LXJoZWwtOS40LWx0cC9nY2MtMTQvODJjNmRkMjA0Nzli
YjZhOTYyNWUxZDYzYTY1MGMzYmU4ODY1ZTJkYi92bWxpbnV6LTcuMS4wLXJjMysKICAgICAgICAg
IGJyYW5jaD1saW51eC1uZXh0L21hc3RlcgogICAgICAgICAgam9iPS9sa3Avam9icy9zY2hlZHVs
ZWQvbGtwLWl2Yi1kMDQvbHRwLTFIREQteGZzLXN5c2NhbGxzLTAwLWRlYmlhbi0xMy14ODZfNjQt
MjAyNTA5MDIuY2d6LTgyYzZkZDIwNDc5Yi0yMDI2MDYyNi0xMTMyMC1wNWc4MDQtMC55YW1sCiAg
ICAgICAgICB1c2VyPWxrcAogICAgICAgICAgQVJDSD14ODZfNjQKICAgICAgICAgIGtjb25maWc9
eDg2XzY0LXJoZWwtOS40LWx0cAogICAgICAgICAgY29tbWl0PTgyYzZkZDIwNDc5YmI2YTk2MjVl
MWQ2M2E2NTBjM2JlODg2NWUyZGIKICAgICAgICAgIGludHJlbWFwPXBvc3RlZF9tc2kKICAgICAg
ICAgIG1heF91cHRpbWU9NzIwMAogICAgICAgICAgTEtQX1NFUlZFUj1pbnRlcm5hbC1sa3Atc2Vy
dmVyCiAgICAgICAgICBub2thc2xyCiAgICAgICAgICBzZWxpbnV4PTAKICAgICAgICAgIGRlYnVn
CiAgICAgICAgICBhcGljPWRlYnVnCiAgICAgICAgICBzeXNycV9hbHdheXNfZW5hYmxlZAogICAg
ICAgICAgcmN1cGRhdGUucmN1X2NwdV9zdGFsbF90aW1lb3V0PTEwMAogICAgICAgICAgbmV0Lmlm
bmFtZXM9MAogICAgICAgICAgcHJpbnRrLmRldmttc2c9b24KICAgICAgICAgIHBhbmljPS0xCiAg
ICAgICAgICBzb2Z0bG9ja3VwX3BhbmljPTEKICAgICAgICAgIG5taV93YXRjaGRvZz1wYW5pYwog
ICAgICAgICAgb29wcz1wYW5pYwogICAgICAgICAgbG9hZF9yYW1kaXNrPTIKICAgICAgICAgIHBy
b21wdF9yYW1kaXNrPTAKICAgICAgICAgIGRyYmQubWlub3JfY291bnQ9OAogICAgICAgICAgc3lz
dGVtZC5sb2dfbGV2ZWw9ZXJyCiAgICAgICAgICBpZ25vcmVfbG9nbGV2ZWwKICAgICAgICAgIGNv
bnNvbGU9dHR5MAogICAgICAgICAgZWFybHlwcmludGs9dHR5UzAsMTE1MjAwCiAgICAgICAgICBj
b25zb2xlPXR0eVMwLDExNTIwMAogICAgICAgICAgdmdhPW5vcm1hbAogICAgICAgICAgcncKICAg
ICAgICAgIGtlZXBfaW5pdHJkcz0vb3NpbWFnZS9wa2cvZGViaWFuLTEzLXg4Nl82NC0yMDI1MDkw
Mi5jZ3ovbHRwLXg4Nl82NC01Y2NmODE2ZjUtMV8yMDI2MDUzMS5jZ3oKTWFjaGluZTogIHVua25v
d24KQXJjaDogICAgIHg4Nl82NApSQU06ICAgICAgNjg5ODM2NCBrQgpTd2FwOiAgICAgMCBrQgpE
aXN0cm86ICAgZGViaWFuIDEzCgrilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDi
lIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIAKICAgICAgVEVTVCBTVU1NQVJZCuKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgApTdWl0ZTogICBzeXNjYWxscy0wMApSdW50aW1lOiA5bSAxNXMKUnVuczog
ICAgMTg4CgpSZXN1bHRzOgogICAgUGFzc2VkOiAgIDIzMzkKICAgIEZhaWxlZDogICAxOAogICAg
QnJva2VuOiAgIDAKICAgIFNraXBwZWQ6ICA0NQogICAgV2FybmluZ3M6IDAKChtbMTszMW1GYWls
dXJlczobWzBtCiAgICDigKIgZmFub3RpZnkyMQoKU2Vzc2lvbiBzdG9wcGVkCi90bXAva2lyay5y
b290L2xhdGVzdCBpcyBub3QgZm91bmQKCgoKVGhlIGtlcm5lbCBjb25maWcgYW5kIG1hdGVyaWFs
cyB0byByZXByb2R1Y2UgYXJlIGF2YWlsYWJsZSBhdDoKaHR0cHM6Ly9kb3dubG9hZC4wMS5vcmcv
MGRheS1jaS9hcmNoaXZlLzIwMjYwNjI5LzIwMjYwNjI5MTUxNC41OTRjNDM3MC1sa3BAaW50ZWwu
Y29tCgoKCi0tIAowLURBWSBDSSBLZXJuZWwgVGVzdCBTZXJ2aWNlCmh0dHBzOi8vZ2l0aHViLmNv
bS9pbnRlbC9sa3AtdGVzdHMvd2lraQoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9s
aXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
