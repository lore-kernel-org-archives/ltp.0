Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9394FE8180C
	for <ltp@archiver.kernel.org>; Tue, 26 Sep 2023 01:56:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 549223CE218
	for <ltp@archiver.kernel.org>; Tue, 26 Sep 2023 03:56:41 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F3C0F3C9446
 for <ltp@lists.linux.it>; Tue, 26 Sep 2023 03:56:28 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8A6E314001E3
 for <ltp@lists.linux.it>; Tue, 26 Sep 2023 03:56:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1695693385; x=1727229385;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=bDxo79vISUGmqilgGArHT37rFEIyYaJ5H8wiQ9yrBIs=;
 b=d40YhYYZ1GZ1G9XZGKwfdG7lT3H15VmTDd3O1roVM80gqonF1aLEHutC
 Dy85T+dPfquNid4Fnn1l0ITIu2pL4dE4f6UYRkxjoPhQRI02+tM1givOF
 K6LBvYKD5gwphTnwXPWSoSb/n1QYdA/+LiEq6Ync59YLEH5UpxD5TYO4j
 1pOqvtOEdjQMZfcwP2WxwkE2Clj/sYhjUb0MFx+RuqHBUczrSn6IGWqO9
 7U1P6gWeQBZm4L+n6SoR3boDMvVHAbiz9l0S3qNjel5Mz2hfhrYDul9PX
 ijihwKXfWeLjSjUS0JPKFpFceJqCPgH2UPNWsqfUUcq0MppxBMqOIUyUd A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="384236160"
X-IronPort-AV: E=Sophos;i="6.03,176,1694761200"; d="scan'208";a="384236160"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2023 18:56:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="818860785"
X-IronPort-AV: E=Sophos;i="6.03,176,1694761200"; d="scan'208";a="818860785"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 25 Sep 2023 18:56:17 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 25 Sep 2023 18:56:16 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 25 Sep 2023 18:56:15 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 25 Sep 2023 18:56:15 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.47) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 25 Sep 2023 18:56:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nEeelnw7wNBrMyWJjnZTGzecDMtEOmCGqSzKHqmW+3ceG7HPiZnA5GQCfHebH+1KPd0il9ucbphbtGNnaXD6jizqozclN6CSo445R+RAhqNCbcJ1b4oB2ZgmRmgl8F6cO9uCnJUDsFd0SRR+k/Lc+7cmNx/fZZLj/qTs5zEPeBWvfvQkiZ0S/vD8GD0xYxBp/+EDTw5SuVxBONhklZsjBagne8CPpLmFEYGVyYXkYM+1VUf6+w/ID7g70YNsXMf5p2eT3mqFiIEDaKLRzJxwOncewlJbJplYIq+hOTZmXDZh9LeH+cqFO+A3dGJot2HW7XE/KQ3LVlQ9t1Rhe6uuoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TCnYwu7tE65Tl4cWOCZi49pD5Wp52dVT3fn9hffWcYM=;
 b=bvBb+wEUEey3hRTWC/IZwiR31IxYRTQ78c07MNvNOm1SRQX44y/qK21LdS9w2eQzGtkcQAO4VQ/JGrADa//s1optIP0g/qmyaJEKVZKCNfcT0Lfpks01LIO6cYt+fRZNdHFTe87nUZ2JV/a7giUELmMMzdBkIf9Z2BXWmeNeHKo7ALOlKEZXbcvh+w61bAd7COGES59HwFaBWy6raZRV51+Zcfme3bLjYVykQhNyDamTpJY28tQlOCplDkTKr9CyVjfENzB26YbXT/CYAtzagMXr+asfwB7qd0ohjy5XPzFLXC2DOKh+w+u2SB2S5hHjfl0h0KOd8N1kMCFCsPUOtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by SA3PR11MB7553.namprd11.prod.outlook.com (2603:10b6:806:316::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 26 Sep
 2023 01:56:13 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924%4]) with mapi id 15.20.6813.017; Tue, 26 Sep 2023
 01:56:13 +0000
Date: Tue, 26 Sep 2023 09:56:02 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <ZRI6MsKeEgDnsyTo@xsang-OptiPlex-9020>
References: <ZQ1Z_JHMPE3hrzv5@yuki>
 <CAD_8n+ShV=HJuk5v-JeYU1f+MAq1nDz9GqVmbfK9NpNThRjzSg@mail.gmail.com>
 <CAOQ4uxjnCdAeWe3W4mp=DwgL49Vwp_FVx4S_V33A3-JLtzJb-g@mail.gmail.com>
 <ZQ75JynY8Y2DqaHD@casper.infradead.org>
 <CAOQ4uxjOGqWFdS4rU8u9TuLMLJafqMUsQUD3ToY3L9bOsfGibg@mail.gmail.com>
 <CAD_8n+SNKww4VwLRsBdOg+aBc7pNzZhmW9TPcj9472_MjGhWyg@mail.gmail.com>
 <CAOQ4uxjM8YTA9DjT5nYW1RBZReLjtLV6ZS3LNOOrgCRQcR2F9A@mail.gmail.com>
 <CAOQ4uxjmyfKmOxP0MZQPfu8PL3KjLeC=HwgEACo21MJg-6rD7g@mail.gmail.com>
 <ZRBHSACF5NdZoQwx@casper.infradead.org>
 <CAOQ4uxjmoY_Pu_JiY9U1TAa=Tz1Mta3aH=wwn192GOfRuvLJQw@mail.gmail.com>
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjmoY_Pu_JiY9U1TAa=Tz1Mta3aH=wwn192GOfRuvLJQw@mail.gmail.com>
X-ClientProxiedBy: SI2PR02CA0006.apcprd02.prod.outlook.com
 (2603:1096:4:194::8) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|SA3PR11MB7553:EE_
X-MS-Office365-Filtering-Correlation-Id: 6126c56d-3f04-41ed-937f-08dbbe33c379
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AbpKzNbHT2lCKWcTL9fVhZWcYQx5ocytSnI+MawxK/IXD9ww6s2feAqs+2hKUPrwYXs3ZdG9vsyrw//1w1jY0GMlQVlr+kDRkSI91DJi6Ow503PXYSqdUvVojImuOUOx0FrYqf1tmQU3rdW1kXpxi35SHLIP/t7999SNkFzSr+yKoYT+emuyDA4YUf/jF52GhVEAp/wYrtpP4dzg5YIitQ/OM7YrM/s06DeQ5/1DDS3W/oSxf6qAlj0qldN/XLG88DZVY6pf0ww9h9NkImKpB4Ij4U2LkqXVSsX2d+XlGksebrc7oERwo/EAhxEHmAQmhTvg/3O/WY9v2noDkRYivztMJK6+iPUYqhxPaFRs6xBaKZVDsolIVWFE4aqowuzoSfuQ1Pc2mdTAnN0g286xOvu3exJ3qpMmaspbkDjPQr6FRQOcJXk8N1bGsalZsztHfB5JnjnoQVIBy5fr8U576I0wLFgTChiM4p9nk2KnTZsRoAFrh2l2/5CimoynaYwi0LUSjpqdNC7IBtKqbzxuJcIWRuqG+vmSmLhBBuZwPT8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB6779.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(7916004)(376002)(136003)(366004)(396003)(39860400002)(346002)(230922051799003)(451199024)(186009)(1800799009)(41300700001)(316002)(8676002)(54906003)(66556008)(66946007)(66476007)(6916009)(7416002)(6512007)(9686003)(8936002)(2906002)(4326008)(44832011)(478600001)(6666004)(26005)(6486002)(38100700002)(6506007)(53546011)(83380400001)(5660300002)(966005)(107886003)(86362001)(82960400001)(33716001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmlMQ3o4QmtPNVhwUVk0Rk1yZ2lqU1pIZjBqbnVnOUJJUVhPL01UUU1SNmw2?=
 =?utf-8?B?dU9ZRjNobC80d2VTV3hRQkFxS2JBdk40UXk5SjB6MThWcWFqdDBuRlYvb1l6?=
 =?utf-8?B?K1lOMEhwTXVuYlArZHlLNzgrcVcweHBSZGJ3R3UwVXBJUEZDWXY5eTlvQmVW?=
 =?utf-8?B?YnRabDNtQWxBOFFqS0dkdHpXOEppSlZqclNQMC83TkVDSC92SitlU3k2SHpm?=
 =?utf-8?B?b2pUUHVJSjdXb0tyV1hWUHFGbnZiK21WN2dBUTJIZFdBMGJWSnFvcUk0YVB2?=
 =?utf-8?B?aS9FaWdSUkw0SGYzU3ZFM2RnU2taZ0pyRWw1WklvVFhIUnhObnZyWGJtZ1RI?=
 =?utf-8?B?TXhXcHl3QTVwRnNvNU1QMEhya0lqaHFuSDRITHg3bVJNMFc5cFNWTXhaV29M?=
 =?utf-8?B?aXJ5b0ZlQktnVjZTMWZ1VERrTE85UWJzTXNRcDczMkN2Z21pSmxac2UrNmtF?=
 =?utf-8?B?NFpLSk03cUdHRmJjUEFPd0wxc09zcnlGZW5GL0pmd1gzaXlJN0hZUUhua0gy?=
 =?utf-8?B?RHAvV2tyZmRWK2FRamdSYVpBd212WTFNdllhczdIMUVxVUltTlBpUjNmQk1r?=
 =?utf-8?B?N3dzMnBwenhLWkJOeWhnZ05IcndtL21aZ2lUUzFtQUVoOXA1QWRSSHdOaldv?=
 =?utf-8?B?OGVWS29maTR2eDh4T1FEU2JnR05ES2dzdVQ3TDcrdjcxUktNeURFYUZNR1R0?=
 =?utf-8?B?WlZnNUxhajFUeGJsVHpvbU82cG41Z1hmeXBqTm45d0N1M2d1N08wTkk1SWpv?=
 =?utf-8?B?TmdJbFF4bmgwd1R1OHNKRjR6L2p2Y00zc3kzK2lJVDNpMWFUZHd4VWQrWjFF?=
 =?utf-8?B?WUpWbVhnRFNLT1NMR1lLNXVFWCsvQ1l5YnhoWGZrQmZvMldMYUhKdkF4NU5K?=
 =?utf-8?B?UWZZeU05azVpMTBnVGR3c1dXOTFTUmFvbFprS0dzc2hkclE5ay9pUE92TnJD?=
 =?utf-8?B?aWRGeXVpR2hKSkdERzhTNno0M1RweWUrdzFXRUdTYWd5R2NkT2hhaXE5ZFlo?=
 =?utf-8?B?S241a3dzWndsYlBJbWV3cmlQeUpFOWdXRjZXeU1LSkI2K3MwUXQyZmpOMkYr?=
 =?utf-8?B?SWhoY081TjhRcGJnQkhGNXF5TnBDcERSYlJkT2VoaE9XM3IxUXFNWHdpQVVT?=
 =?utf-8?B?U0lGMENNc3dQWk1oRC9tWVFsZ3lnK3JzUmx2ckZVaWo1T1Evam1vdm1ZYWQ5?=
 =?utf-8?B?bFNmc1FCbzdpOEhvTHdJM0t0a1VHK1FYU01QalFCZXZBd1NNZG1Ed204cjJq?=
 =?utf-8?B?d3NQY2hVOC9MV2Juek9jSDFmOUJiTE5oZzlNYVdvS2pnS2dEdWFJbVM5VEJP?=
 =?utf-8?B?Z0tXYk5MbHhsWmowa3Zhd2hqQVpHbVF2empjT1lvRTBFR3VWdkR2dTNTOTdO?=
 =?utf-8?B?ZW1mVmV3b0lyMCtaVWJHMk1rMHF6Z0s2VFZySHJFa0x2eXRvSEY3akpBT3NM?=
 =?utf-8?B?UnlMYmdmR0RDbFN2aWViemhqMDc3TkFRVmNUSHlNWTJjcEU2TkFDWk0zdWpX?=
 =?utf-8?B?NkpFY1RuMXgrcGpiekEyUHBJM01Qclc5ZzVjSTF6ZEFySDBGcms5VlZzUDBu?=
 =?utf-8?B?dkF3SUZzc3BCdTFvQjdadUUxdXlIbWN1eXNjU1U5eDFtemV3ak1wbWN3NVFN?=
 =?utf-8?B?cnRETWZlMTJDeGk3Z2c2Vmh4ZTFob0J4V2UyOTZRL1RGek1oQ3hNUmFVTVQ2?=
 =?utf-8?B?TlNmbG5JM3dISXNZdjZkZzFldHBIR3RJaGhyZ1NmeWdCbEVlN2pSc0k2aGJK?=
 =?utf-8?B?bmJBc2lJV2xOVzQyQU9GUGVNZmZOdk1LaHRRVllQT2kvTnMvOWxEbGl2VFJS?=
 =?utf-8?B?ZnJ6ZWp1Z1J3MkVPOStBUWVYeXRWcnVveTZxS3MzMlRFV0FpSmo4NHNIcDFF?=
 =?utf-8?B?SXFlUWd2QmVBWkJ3RmtHcFcrVnlSNGdJc05nejhaU21NZERsVkMyOXRDb2g5?=
 =?utf-8?B?emJtVU4wM2RIYitSNW4vcDFaRVkrbkwyaTFoWlRoQVVSVmpLRExvb3ZyVXFG?=
 =?utf-8?B?d3ZCdFpWUHJPak1SbkQ0cXpybmxoZjZaQTZTRHZ6aHREM09ab3p5YUxycVIv?=
 =?utf-8?B?Z2xObVhMaVhpOWttMVRNNVE2YjIxdDN6T0U5aHJkcm0wVU1uRWJkLzJYOEQ4?=
 =?utf-8?B?ZG0yWm9QOHZqOUNmR0JWcmY2eEFXNk1OYkdRek1SeXlKVEl1akw0ckU0WXA3?=
 =?utf-8?B?dnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6126c56d-3f04-41ed-937f-08dbbe33c379
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 01:56:13.6235 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LFWIBm6vkirgqwsKUPjaO9K5iYd86aoaUqvecKG2B8TVsGIvUCCqQUmnWxaQ+jQyXdNLYo+uHh4I9I609Py2qQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7553
X-OriginatorOrg: intel.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] vfs: fix readahead(2) on block devices
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
Cc: mszeredi@redhat.com, brauner@kernel.org, Jan Kara <jack@suse.cz>,
 lkp@intel.com, Matthew Wilcox <willy@infradead.org>, oe-lkp@lists.linux.dev,
 oliver.sang@intel.com, viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
 Reuben Hawkins <reubenhwk@gmail.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

aGkgQW1pciwKCk9uIFN1biwgU2VwIDI0LCAyMDIzIGF0IDA2OjMyOjMwUE0gKzAzMDAsIEFtaXIg
R29sZHN0ZWluIHdyb3RlOgo+IE9uIFN1biwgU2VwIDI0LCAyMDIzIGF0IDU6MjfigK9QTSBNYXR0
aGV3IFdpbGNveCA8d2lsbHlAaW5mcmFkZWFkLm9yZz4gd3JvdGU6Cj4gPgo+ID4gT24gU3VuLCBT
ZXAgMjQsIDIwMjMgYXQgMDI6NDc6NDJQTSArMDMwMCwgQW1pciBHb2xkc3RlaW4gd3JvdGU6Cj4g
PiA+IFNpbmNlIHlvdSBqb2luZWQgdGhlIGRpc2N1c3Npb24sIHlvdSBoYXZlIHRoZSBvcHBvcnR1
bml0eSB0byBhZ3JlZSBvcgo+ID4gPiBkaXNhZ3JlZSB3aXRoIG91ciBkZWNpc2lvbiB0byBjaGFu
Z2UgcmVhZGFoZWFkKCkgdG8gRVNQSVBFLgo+ID4gPiBKdWRnaW5nICBieSB5b3VyIGNpdGluZyBv
ZiBsc2VlayBhbmQgcG9zaXhfZmFkdmlzZSBzdGFuZGFyZCwKPiA+ID4gSSBhc3N1bWUgdGhhdCB5
b3Ugd2lsbCBiZSBvbiBib2FyZD8KPiA+Cj4gPiBJJ20gZmluZSB3aXRoIHJldHVybmluZyBFU1BJ
UEUgKGl0J3MgbGlrZSBFTk9UVFkgaW4gYSBzZW5zZSkuICBidXQKPiA+IHRoYXQncyBub3Qgd2hh
dCBrYnVpbGQgcmVwb3J0ZWQ6Cj4gCj4ga2J1aWxkIHJlcG9ydCBpcyBmcm9tIHYxIHBhdGNoIHRo
YXQgd2FzIHBvc3RlZCB0byB0aGUgbGlzdAo+IHRoaXMgaXMgbm90IHRoZSBwYXRjaCAodjIpIHRo
YXQgaXMgYXBwbGllZCB0byB2ZnMubWlzYwo+IGFuZCBoYXMgYmVlbiBpbiBsaW51eC1uZXh0IGZv
ciBhIGZldyBkYXlzLgo+IAo+IE9saXZlciwKPiAKPiBDYW4geW91IHNheSB0aGUgZmFpbHVyZSAo
b24gc29ja2V0KSBpcyByZXByb2R1Y2VkIG9uCj4gaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIv
c2NtL2xpbnV4L2tlcm5lbC9naXQvdmZzL3Zmcy5naXQgdmZzLm1pc2M/Cj4gCj4gSSB3b3VsZCBl
eHBlY3QgdGhlIHBpcGUgdGVzdCB0byBmYWlsIGZvciBnZXR0aW5nIEVTUElQRQo+IGJ1dCBhY2Nv
cmRpbmcgdG8gUmV1YmVuIHRoZSBzb2NrZXQgdGVzdCBkb2VzIG5vdCBmYWlsLgoKSSB0ZXN0ZWQg
b24gdGhpcyBjb21taXQ6CjE1ZDQwMDBiOTM1MzkgKGJyYXVuZXItdmZzL3Zmcy5taXNjKSB2ZnM6
IGZpeCByZWFkYWhlYWQoMikgb24gYmxvY2sgZGV2aWNlcwoKYmVsb3cgaXMgdGhlIHRlc3Qgb3V0
cHV0OgoKPDw8dGVzdF9vdXRwdXQ+Pj4KdHN0X3Rlc3QuYzoxNTU4OiBUSU5GTzogVGltZW91dCBw
ZXIgcnVuIGlzIDBoIDAybSAzMHMKcmVhZGFoZWFkMDEuYzozNjogVElORk86IHRlc3RfYmFkX2Zk
IC0xCnJlYWRhaGVhZDAxLmM6Mzc6IFRQQVNTOiByZWFkYWhlYWQoLTEsIDAsIGdldHBhZ2VzaXpl
KCkpIDogRUJBREYgKDkpCnJlYWRhaGVhZDAxLmM6Mzk6IFRJTkZPOiB0ZXN0X2JhZF9mZCBPX1dS
T05MWQpyZWFkYWhlYWQwMS5jOjQ1OiBUUEFTUzogcmVhZGFoZWFkKGZkLCAwLCBnZXRwYWdlc2l6
ZSgpKSA6IEVCQURGICg5KQpyZWFkYWhlYWQwMS5jOjU0OiBUSU5GTzogdGVzdF9pbnZhbGlkX2Zk
IHBpcGUKcmVhZGFoZWFkMDEuYzo1NjogVEZBSUw6IHJlYWRhaGVhZChmZFswXSwgMCwgZ2V0cGFn
ZXNpemUoKSkgZXhwZWN0ZWQgRUlOVkFMOiBFU1BJUEUgKDI5KQpyZWFkYWhlYWQwMS5jOjYwOiBU
SU5GTzogdGVzdF9pbnZhbGlkX2ZkIHNvY2tldApyZWFkYWhlYWQwMS5jOjYyOiBURkFJTDogcmVh
ZGFoZWFkKGZkWzBdLCAwLCBnZXRwYWdlc2l6ZSgpKSBzdWNjZWVkZWQKClN1bW1hcnk6CnBhc3Nl
ZCAgIDIKZmFpbGVkICAgMgpicm9rZW4gICAwCnNraXBwZWQgIDAKd2FybmluZ3MgMAoKCkJUVywg
SSBub3RpY2VkIHRoZSBicmFuY2ggdXBkYXRlZCwgbm93OgplOTE2OGI2ODAwZWNkIChicmF1bmVy
LXZmcy92ZnMubWlzYykgdmZzOiBmaXggcmVhZGFoZWFkKDIpIG9uIGJsb2NrIGRldmljZXMKCnRo
b3VnaCB0aGUgcGF0Y2gtaWQgYXJlIHNhbWUuIGRvIHlvdSB3YW50IHVzIHRvIHRlc3QgaXQgYWdh
aW4/Cgo+IAo+ID4KPiA+IHJlYWRhaGVhZDAxLmM6NjI6IFRGQUlMOiByZWFkYWhlYWQoZmRbMF0s
IDAsIGdldHBhZ2VzaXplKCkpIHN1Y2NlZWRlZAo+ID4KPiA+IDYxOiAgICAgZmRbMF0gPSBTQUZF
X1NPQ0tFVChBRl9JTkVULCBTT0NLX1NUUkVBTSwgMCk7Cj4gPiA2MjogICAgIFRTVF9FWFBfRkFJ
TChyZWFkYWhlYWQoZmRbMF0sIDAsIGdldHBhZ2VzaXplKCkpLCBFSU5WQUwpOwo+ID4KPiA+IEkg
dGhpbmsgTFRQIHdvdWxkIHJlcG9ydCAnd3JvbmcgZXJyb3IgY29kZScgcmF0aGVyIHRoYW4gJ3N1
Y2NlZWRlZCcKPiA+IGlmIGl0IHdlcmUgcmV0dXJuaW5nIEVTUElQRS4KPiA+Cj4gPiBJJ20gbm90
IE9LIHdpdGggcmVhZGFoZWFkKCkgc3VjY2VlZGluZyBvbiBhIHNvY2tldC4KPiAKPiBBZ3JlZS4g
UmV1YmVuIHJlcG9ydGVkIHRoYXQgdGhpcyBkb2VzIG5vdCBoYXBwZW4gb24gdjIKPiBhbHRob3Vn
aCBJIGNhbm5vdCBleHBsYWluIHdoeSBpdCB3YXMgcmVwb3J0ZWQgb24gdjEuLi4KPiAKPiA+IEkg
dGhpbmsgdGhhdCBzaG91bGQKPiA+IGFsc28gcmV0dXJuIEVTUElQRS4gIEkgdGhpbmsgcG9zaXhf
ZmFkdmlzZSgpIHNob3VsZCByZXR1cm4gRVNQSVBFIG9uIGEKPiA+IHNvY2tldCB0b28sIGJ1dCBy
ZXBvcnRpbmcgYnVncyB0byB0aGUgQXVzdGluIEdyb3VwIHNlZW1zIHF1aXRlIHBhaW5mdWwuCj4g
PiBQZXJoYXBzIHNvbWVib2R5IGhhcyBiZWVuIHRocm91Z2ggdGhpcyBwcm9jZXNzIGFuZCBjYW4g
ZG8gdGhhdCBmb3IgdXM/Cj4gPgo+IAo+IFRoaXMgaXMgUmV1YmVuJ3MgZmlyc3Qga2VybmVsIHBh
dGNoLgo+IExldCdzIGFncmVlIHRoYXQgY2hhbmdpbmcgdGhlIHN0YW5kYXJkIG9mIHBvc2l4X2Zh
ZHZpc2UoKSBmb3Igc29ja2V0IGlzCj4gYmV5b25kIHRoZSBzY29wZSBvZiBoaXMgY29udHJpYnV0
aW9uIDopCj4gCj4gVGhhbmtzLAo+IEFtaXIuCj4gCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0
dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
