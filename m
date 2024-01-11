Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26DF2C47077
	for <ltp@archiver.kernel.org>; Thu, 11 Jan 2024 12:30:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8050F3CE435
	for <ltp@archiver.kernel.org>; Thu, 11 Jan 2024 13:30:37 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BBBB13C768C
 for <ltp@lists.linux.it>; Thu, 11 Jan 2024 13:30:21 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=192.55.52.88; helo=mgamail.intel.com;
 envelope-from=pengfei.xu@intel.com; receiver=lists.linux.it)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id CA1F6201748
 for <ltp@lists.linux.it>; Thu, 11 Jan 2024 13:30:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1704976219; x=1736512219;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=PkoQckG9EE9YWO+UzSPHZO7Y0024ih/94zEXOumSrk4=;
 b=dy3pT9BR6wo2RJMBrxj1m7tM9/M+xE2Z9fSiZLtTfgT50euJo/qfANcr
 wpDOasiH8usHBZV8c2wja/KBI+Xd8H5apPM6OUTYKu594L8+XF9BgEN9K
 PpghWnbalgWLbDKnS0WvGDvk57813WLHiZP7M9VdTHRtEm/+1WEPWKW/W
 QlER5iHR9LeGxGMY6ywtlfcP4YAkrz5rvpLVz7u4he3zSLSlCUq4kTk6J
 69orz3o7XvJrz1LrJAPJDE2CZRtsGk58AqePORZI4eZdaOl8CQcpoy0hf
 Dv1K32+60ctDHy1SThsmzOyg8+xx1zxkhcd91GHkzlmSidyYEIZcxB2PH w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="430011230"
X-IronPort-AV: E=Sophos;i="6.04,186,1695711600"; d="scan'208";a="430011230"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jan 2024 04:30:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,186,1695711600"; d="scan'208";a="24317437"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 11 Jan 2024 04:30:11 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Jan 2024 04:30:11 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 11 Jan 2024 04:30:11 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 11 Jan 2024 04:30:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f+00kCUuoLkdFzKmX0MkSsq8hzSwD+mgxMa9AUlXSCoA2i0IZ4lJ6M+Jxco04y8hFPP7gNwVIQBReyn1rWjmn/t6VLHZKhYJg1MVQEQiAhkCP2XC/D1ZMSO47FEHk95HnJEkaWd4lcTsCuMg6Vy4xd1gh/CMULp4B1iROYli1d2sg84ek4fjNcTrsXL2IVbuavT3obzXM8ZvEantSXdFcqOfVjXCjoBrOnKYkICBzEKCfk2/gEFzsMXEroZJx9sAYItn0JzfBwaRusw6jgNW31O93HSBlmRSnPx0dzMcS70qJklX0ilbwwM2CiBZsz4qS8Q1paECkmQAZvX7kj6UOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lKleGb2uPvz8nT5+dt1g3yjgJRVKBYJBQrrG11wigbA=;
 b=Quydv0OedvCz6YmBC+0jxumUizFnANKmfGEePRWS3xJdYjkOxFHofZhXAjvMM+YC9AV7W61n86X7FAawD+neHAXjFBUUbl8JCHpMHzDMmoqN0OMAchi4VXRljCDZXnkDD+WeztlMblNh9NrdMxm/pUDYoCknRwFO+tv11n28u/frbHAviBPfWor2t9mH8wPctkVaD4RHqTPnldwNdLLo9mWxIgLn/6YhQtN6D8FKQTENLVRXasxdBvxl4zvz6fGcQlSsqZRtcC9hISEvc+62bpHzf3qGPUhSGhyVQLwDxi4Gd6v00chOt5Yvq43dyQyrDQGF0ep1V08KMsjWDg2cLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by SA1PR11MB8447.namprd11.prod.outlook.com (2603:10b6:806:3ac::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Thu, 11 Jan
 2024 12:30:08 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::25c4:9c11:c628:1283]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::25c4:9c11:c628:1283%4]) with mapi id 15.20.7181.015; Thu, 11 Jan 2024
 12:30:08 +0000
Date: Thu, 11 Jan 2024 20:24:42 +0800
From: Pengfei Xu <pengfei.xu@intel.com>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZZ/eCt9jeCNYMMff@xpf.sh.intel.com>
References: <cover.1704949719.git.pengfei.xu@intel.com>
 <48efcb1293a682182fc5db23f01be7af2889e26c.1704949719.git.pengfei.xu@intel.com>
 <20240111100949.GA1895489@pevik>
Content-Disposition: inline
In-Reply-To: <20240111100949.GA1895489@pevik>
X-ClientProxiedBy: TY2PR02CA0066.apcprd02.prod.outlook.com
 (2603:1096:404:e2::30) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|SA1PR11MB8447:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e38541e-8906-4c6d-a59f-08dc12a10c64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lzl6LbfFydquvBJhIOXRgXA7LzRn66ezR8VPw2bNTVsnpIIFvWhORDzpPJnkraty2IUixelb/YFoJ72c0Zvgn2SnlCXibmYBKs4N0pfC000PwhUwhoSEvzJ+aeJtkunkAaUPyyztpcDoD1PQ4h7kA5ZVThaoBUzsZxnFx9ype18qGrHIar2rNPpP7Jll4AkXg9f698Lr8Xs3DSiiehbt6SztXPB+PtcBbuFmZ8KpYxqdMdHokVXAewmwhAxQ2sxbqMYPISwTU7FyJtB4G9Bog67nK145DrYjwDKoupgq91RnuP1jP8855ZggbIqGqIIL3g/bxHbgBFy9pAJS0BIg5tjrt2nCS9UmDMcxcu80WcMnZxnKdoJvOkfrK3JmdyXDgM33QjLtbJTI4h4pk+5pRkixkurIIgdtIO8+GnL+YUk9WcCzOUsy16jEWWmtA74VSkp0MqjGG/RIyZgOnEieArRBWVSONn3mNegbo/6uiDB2vejYyT+G30s6X/KFOXniUREyW1kwzzgFkhxvquRYv7O50U7AXS0A3IhYFtvWSalhMCUDRXjhfDraom3u0p7TJ6I3MKyoxGl2dETbkJliFw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB4839.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(39860400002)(376002)(396003)(136003)(366004)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(2906002)(107886003)(26005)(66476007)(6486002)(66946007)(41300700001)(86362001)(66556008)(82960400001)(4326008)(6512007)(83380400001)(53546011)(6666004)(6506007)(966005)(44832011)(6916009)(5660300002)(478600001)(316002)(8936002)(8676002)(38100700002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CEc0zgaNNpX28Q2/ZJlF9ryU3pgxg4lDdlfgXFpZZFtFZHchoU6DPb3vppvT?=
 =?us-ascii?Q?/C9e7q3+ZjVT46n0kyvGi3l2oVhLkVdl859ZlNwQtjwGR1+m056SjckIwyWn?=
 =?us-ascii?Q?MsUHY9wkLHdyZ4IVrYcHLXG8fU21AeEVzJOh/bqbVW7WwDYUpCTgVADrbqCo?=
 =?us-ascii?Q?kjiD2Nhp/L8UUjulZXs08HdOUrrcsGC73AiPTa/F36E3/ve9rwpEOfS3HeUt?=
 =?us-ascii?Q?2nwmeMOdPRLrFUdc6n9QBtEZtOpgpPxLhm5JJF65rqOR/QS69YaWQtx+wyTs?=
 =?us-ascii?Q?YI9plLa6yyC49zFosuWUoPhZamMxTOXpIWb7iXNmDxlTiQBLWkq3Sblm8AyQ?=
 =?us-ascii?Q?8VkqD4kWZEgPw8wQTk6zsw5KfKs+jm3FvJCm4htg/35aG3emK1g9AWJo4Z2a?=
 =?us-ascii?Q?xrjTYLLybFO+Aca1qEoKxBG6/OxK3MNnPvwLSqJvQKfJRs8blYahbQWK5weZ?=
 =?us-ascii?Q?wkESEWvTE7lnNvFyfqe+3dtO4fAvZNzHONmWaUgRLUoYx+IuGpsUkCQFWUEy?=
 =?us-ascii?Q?AFXBoK0NXKCrOCNEcXBfj9YKdDLP6cJ2J5ZgrGBCzQTP2WinBcFl4BfP4rUi?=
 =?us-ascii?Q?M7xMh6xhSt4ErRC2TQ0Iu5Q88F0ksWb7l2Y8zhlPeaDcg1z48FTECrvcu4vR?=
 =?us-ascii?Q?sSfci1mdR4FkgFojsaMO1+iC+gIfrNRTWbD3R1+4/FxH0j3TkTD29Dvm6oAi?=
 =?us-ascii?Q?8URq+rihFN2Yq4Jl92nU1fz9NfqeS6pAri9+ACK9J+sns91kOqVUSKCIK+y9?=
 =?us-ascii?Q?3oi+YMWaOw9VOU2AaxtcXpTUndGulaECPZ/gGCiAAE2uLdsLamK4Ihn5SZfo?=
 =?us-ascii?Q?zCNMx3tCSb9+9kiw5vMEtguinXGEX+NoWkD45CBG3he42GnbSlaUVr9KJPRG?=
 =?us-ascii?Q?Anlc5nDY91n2R7/RKdvd3XMPe6RNdCOBjTX4uJRRQaIPaEdGittK7JVxfTTG?=
 =?us-ascii?Q?4sN3Bx4+O/QKsemdnks3/X0GjcONB7ieRYyVR0Oi4BIvkaBUyXUOk5dDuWjj?=
 =?us-ascii?Q?oNKBiz0jgnIL+8m5ARidryoJFsQIpiFsE1e8ehCVqMq+pyXuIF0dBaEdfTkQ?=
 =?us-ascii?Q?7PILb7gPrXZKJ32fGoLrNdU6CLPmqZxKmKqLDHyR1aEob6PLrmH7AtIPMGO2?=
 =?us-ascii?Q?en+veRVbajOPuDu+09ud7kMn3zQvhQ8uACqntpyeUttJu4Koa6UHBDn5Pmkr?=
 =?us-ascii?Q?yeBECkYyaWNguI5Qb1UVIOsRJ+U6NzrPCyADb1wCizDQta3zCdUEeMSuIZFq?=
 =?us-ascii?Q?H01h7tDj0/HZVolGTEHIzVzIdz78npfAWxbJEtj5d/R7paoZzZj8EzHeAtDP?=
 =?us-ascii?Q?ELHlEQZbEeJRhVPelzRw5xM6ptUUczTTZfdqRjCewO3szSRPVdnC2JlKDYYd?=
 =?us-ascii?Q?eP9r8lHMC9P64UcxA2wiYPz1D7GjCxMpHn2McGqb8agh23flC+U2VTqjUTuE?=
 =?us-ascii?Q?8o19iyT/e/28YuXov6Q2LHDxExzoU1n0eYzx32Q3KBJmgUOzaOTr1YZcaxbQ?=
 =?us-ascii?Q?7qFy2mEik5QE2z6OGzr+biz7z88XZBFdBOxuZzVieMnQTJqtKlM/SvBorpLw?=
 =?us-ascii?Q?ekCWOR6n7immMFmlVlDtzEPgM5QNImizo91XUPg4?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e38541e-8906-4c6d-a59f-08dc12a10c64
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 12:30:08.7913 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CgBj6J8LFVXtDzcFsDBl3D1yC1F1sUw4Su46DZIvdRmCOarLclgaAhfzBMguRWPKXAOxkDIY2zVYy1xdiOQnqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8447
X-OriginatorOrg: intel.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 1/1] keyctl05: improve the dns_res_payload for
 boundary testing
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
Cc: Heng Su <heng.su@intel.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

On 2024-01-11 at 11:09:49 +0100, Petr Vorel wrote:
> Hi Xu,
> 
> > Because the following patch will fix the add_key syscall incoming data boundary
> > size issue, 6 bytes incoming data should pass:
> > https://lore.kernel.org/all/1784441.1704907412@warthog.procyon.org.uk/
> >  -> https://lore.kernel.org/all/1850031.1704921100@warthog.procyon.org.uk/
> > In order to test above boundary incoming data size, change the dns_res_payload
> > size.
> 
> I'm sorry, I was faster and just fixed \ myself.
> Rebasing is trivial, but there was missing commit (already merged and other
> things). Thus I have sent v2 under your name (which I actually forget to mark
> as v2 :().
> 
> https://lore.kernel.org/ltp/20240111100636.1897637-1-pvorel@suse.cz/
> https://patchwork.ozlabs.org/project/ltp/patch/20240111100636.1897637-1-pvorel@suse.cz/
> 
> Can you please have a look on it?

Yes, it's better to add the linux-git acc657692aed and it looks good.
Thanks for your improvment!

Best Regards,
Thanks!

> 
> Kind regards,
> Petr
> 
> > Signed-off-by: Pengfei Xu <pengfei.xu@intel.com>
> > ---
> >  testcases/kernel/syscalls/keyctl/keyctl05.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> > diff --git a/testcases/kernel/syscalls/keyctl/keyctl05.c b/testcases/kernel/syscalls/keyctl/keyctl05.c
> > index 90cf1ef06..50e78853c 100644
> > --- a/testcases/kernel/syscalls/keyctl/keyctl05.c
> > +++ b/testcases/kernel/syscalls/keyctl/keyctl05.c
> > @@ -199,11 +199,11 @@ static void do_test(unsigned int i)
> >  	 * We need to pass check in dns_resolver_preparse(),
> >  	 * give it dummy server list request.
> >  	 * From v6.7-rc8 commit 1997b3cb4217b09e49659b634c94da47f0340409:
> > -	 * the incoming data for add_key syscall should be larger than 6 bytes,
> > -	 * because struct dns_server_list_v1_header without body is 6 bytes.
> > +	 * the incoming data for add_key syscall should be not less than 6
> > +	 * bytes, because struct dns_server_list_v1_header is 6 bytes.
> > +	 * The minimum payload will be tested here for boundary testing.
> >  	 */
> > -	static char dns_res_payload[] = { 0x00, 0x00, 0x01, 0xff, 0x00, \
> > -					  0x00, 0x00 };
> > +	static char dns_res_payload[] = { 0x00, 0x00, 0x01, 0xff, 0x00, 0x00 };
> 
> >  	switch (i) {
> >  	case 0:

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
