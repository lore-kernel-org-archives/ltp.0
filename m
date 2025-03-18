Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C97AFC282EC
	for <ltp@archiver.kernel.org>; Tue, 18 Mar 2025 05:29:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AD8693CAB9D
	for <ltp@archiver.kernel.org>; Tue, 18 Mar 2025 06:29:02 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2FD793C2163
 for <ltp@lists.linux.it>; Tue, 18 Mar 2025 06:28:42 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=198.175.65.19; helo=mgamail.intel.com;
 envelope-from=oliver.sang@intel.com; receiver=lists.linux.it)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 9A10E10009A4
 for <ltp@lists.linux.it>; Tue, 18 Mar 2025 06:28:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742275721; x=1773811721;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=QhB639BmFCKJtp+aDE5VlVc3qBeywZp+IoEelsAFbuU=;
 b=Qc8t1lxqmnls5x4RZsajmlXG0XccbPuX7NRScIGBwI2Pb1QNZA77ZUm6
 zZ2D7D0tE5E+m3W5Hupc7HEARIqzK/f5dIir17VubYT57tCAOuksSTXny
 eDL3CaBBI/Te9vWzxvUNOxu2lRz1cTCRKy8usB9dLwPKD41A1jL7zeJ3k
 lm30xGlR6CwxEzGmHLljYrRuECqTdU86lyL60xcSOxTuPvIiATZo3dU2p
 ujIeSd71YcFMK0RgDmdTQuwpeW38zsHZF6lrZB2a8mFxEcx1lB5ylZqh6
 tf0G3P3YJUoOlKeFanCfvMkhfPNQ4qpn2jJXY3TOJnXHSZ7Dq8XC9f2z2 A==;
X-CSE-ConnectionGUID: eD6czslVQx+6UFr1Z5809A==
X-CSE-MsgGUID: cD7dbNjDTu6FyYbEB829hg==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="43261482"
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; 
 d="xz'341?scan'341,208,341";a="43261482"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2025 22:28:34 -0700
X-CSE-ConnectionGUID: JGE88BncSomptMfmDmzKTg==
X-CSE-MsgGUID: WfrRYnR4SMG+nwjQ8S7t2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; 
 d="xz'341?scan'341,208,341";a="121883979"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 17 Mar 2025 22:28:34 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 17 Mar 2025 22:28:33 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 17 Mar 2025 22:28:33 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 17 Mar 2025 22:28:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CRVhWY6ao08v462EAegewFpr4nQOyxcomYt+bCUlkJXJbBk1n76/QiqqRvTEK4is8BH9pvQXXvS3VPunaV+mz4FcTEPWOz1SiP+b4Q/YHr+gV9M+PojzIG8ZAXG1/y8UHVcp1xWCKKuJjB4lhFMqvVJPBy5922KBF5vxSaitTUGSwKLxvygq3CANNJc6kRb9bpDop5eKB1GXWvhJau4+iCwijIoWmqcY84E7MywYSxKY2QtLMDZPNIPyVTFnby5NZJ4ml7UBBvNkcyjLQMi5iujITMapGe74TJtHbaSONPfQ4NhnOFoZUPOCpHIp8WxSyWWpu5f9lOc/oLH6rdKHzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J7WGNVDpex1BGC9ojWj5wjhQMDfAXWMN8WLOJQcd75g=;
 b=BGudENnh35Xz3X1uwJ3X6I6kFxJIwhRRfgrmRP4FG4Jh/sRkFtl3TQ4EApowb5+E1M1/4vuUu8bIfmYBMNPpitIL/22F70N5Of2vFulDG/E8mN6Aamrfs/8DoT211VPC/fHqIlSVL1zNdwre9TS0J1Q2fcCliXGRguW1B9DWQtLaeKyRu1QNDDN8DUO/4f+cN5qbs6mS47B8zaLLR8tTu5rPbCNtWWdjeUiPeYECkAFXEEm4MUoGO7ExGZF9lxSds7oQ/3z2W9QrQFZ0YDiLrROu2/e0VtYmhf7M9nPoAV//vqEAgr73voRopwJI06fWO5Zr2HxzKF787PMt/s5d7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by IA1PR11MB7197.namprd11.prod.outlook.com (2603:10b6:208:41a::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 05:28:30 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%4]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 05:28:30 +0000
Date: Tue, 18 Mar 2025 13:28:20 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Christian Brauner <brauner@kernel.org>
Message-ID: <Z9kEdPLNT8SOyOQT@xsang-OptiPlex-9020>
References: <202503101536.27099c77-lkp@intel.com>
 <20250311-testphasen-behelfen-09b950bbecbf@brauner>
In-Reply-To: <20250311-testphasen-behelfen-09b950bbecbf@brauner>
X-ClientProxiedBy: SI2P153CA0014.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::6)
 To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|IA1PR11MB7197:EE_
X-MS-Office365-Filtering-Correlation-Id: b3e90c43-7ce8-47fb-6849-08dd65ddb7a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|4053099003;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BOYYXRzymVP3pIsGsk6w+1TiVZ5ldgkwQlc1ogIh+kkojy6Fwfkp+j8M2nZE?=
 =?us-ascii?Q?VbqxEPd7b3E2xrT8pk/o7+/NBFrVl6VklbplK+WSG4gMxBci2cXWw/8JU7SH?=
 =?us-ascii?Q?e0gzVPsO8RXkirNB82fkUsCrFyhK6qkVviYcNl3gUX6XZu+42Pe9cmmo0bVU?=
 =?us-ascii?Q?PBYEkBUvsvbYgNRIB1mMGOvCfEPRkheNyBa0MzbwxlIRtzGaLBvJjpIk5Mh+?=
 =?us-ascii?Q?One0GWrR66lUzmeBbnSHXldtnxy8YcpxRQ5kEgtAsEwjGw0eNvAFvUnQxedj?=
 =?us-ascii?Q?FOKGRPuc5muzd5kU/hO82sZDLebx6HsmcU5BFtFoJ9T/lLMOcdtjo8b9b02d?=
 =?us-ascii?Q?mw+ZfK+26nIunO3GiDUj+S+gJhcGwWKb590qdDBKagxShrHDpX/rqQpunHsI?=
 =?us-ascii?Q?gKsr0GuBNFCWakrr8nagfPNBAq+Kn4VRUz/Lb3OKw9AFhEbYNjOJf7BqlaUN?=
 =?us-ascii?Q?kp118cZDc4r8dz02Cjzk0H52JEBgdunXcjVIIuxyfHduCk/POfIs2Akvxyd9?=
 =?us-ascii?Q?zlO58ig/DzRtLe27GO/PalPJOVe9ciHwLc/iuxo8/KEQBObk9B2mO5gZrbYK?=
 =?us-ascii?Q?oZJoXkWiFtLFgzzjA2HImbJAkiORSNMKH0DHAB3bij1XRsYCyytQiVUFw54Q?=
 =?us-ascii?Q?LSK4yZB/liLl7lsf2CnIsksJWLGJdPk9/YVmh2Zh0xmKn2sDLTPU2yzkQINT?=
 =?us-ascii?Q?g5m6dmsf6x+3kkqiUHXT6EgiSw8z4Zhmvfcysv5BpfgHVVNylg4U57fD6tu0?=
 =?us-ascii?Q?Ey0LjjBlYu5NbjeImJiGflbg3B2Yv/OAG3oPpKM7wlwAERDU2reN+VAporNG?=
 =?us-ascii?Q?hcSEBT5oYFwuvW+BTQHF6+M92uMZHfzvaOsP4FRrYDodJA+RQSM39t+oKs0u?=
 =?us-ascii?Q?D4702XEQ77P/JmjX3f0nEj98/Ot5PUBk72YprePYO/h44DLhmpH+9zt9k4Aa?=
 =?us-ascii?Q?ePnV2HAyWk2oiEcaByBpZlXeY+z6AT52OHoNuH6KlV7Tr+K9OJThhrR+yPs+?=
 =?us-ascii?Q?AKhwFqIlJpzxVOm31WPmwbpCoicdn9Ry/gNHIMPzsH2EuO+LxEwCrHO28fdn?=
 =?us-ascii?Q?xDtu28kJcMOZebqMj7EFVVp5BdFZ9lj81W2mY42YRz7K40le6tgVtyI18ise?=
 =?us-ascii?Q?c5IHn+t0ve1UY8sLuCzJUnI4bQfzNNM2JgONtCBfjaasv/oJRjuyZpznUJcQ?=
 =?us-ascii?Q?c8gAc/St3pflEGBNn7BGUlitjnv4NPUiyIlb8Kp3GJWClGE7hZLHDrCr1VCA?=
 =?us-ascii?Q?sZmBwdhO8OkNK+UF3vazb8G261fEL06/pYIEmwQc+WJYW8luVGbKRd7Qnp7Z?=
 =?us-ascii?Q?YEq9JfC17VFSByh2x01I77k8mFZgcFUVmXCDZrZ439TLtg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR11MB8603.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(4053099003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7G39DNyQSDxde4L3I9+qWHDcrvGmzLcoHQxSXOyac934EUua9XEefzExGPo/?=
 =?us-ascii?Q?jKcNhO8aT55H0MxhJiopPneIKuxDsALCz1ORad2evhvQvz9QQT9rVRUrVECB?=
 =?us-ascii?Q?E0fJvzAd35UwlpMflGYIgKv16VQVoMKNzZ5vacwu2d30fByM2DYrvg2bHkCk?=
 =?us-ascii?Q?gDHpajjX+BDzqSh+Kochr+9445Kqs7+AiD0/pZtTQcWo7MAOqP5OPua077wF?=
 =?us-ascii?Q?lIoHjk6HLPTMIM5PfI+2ag97uHY9XF/Zd6yYq4AfytFn18U7TCiNaBNK5Qp3?=
 =?us-ascii?Q?5roBsJGKQujotiBm+wxhda0KaSOocXCD+WnRScLpojx65H7t3cNk1EBoC5Se?=
 =?us-ascii?Q?qVdhsFEcpKaQpQHyXpsHmJamR6CPJBtf4Xb8iJJm/RZH8DzWEuz+bKVS3fJb?=
 =?us-ascii?Q?omS5c7BaMOaXbiPOBIYapnrRVM0nXfdNK0kxyzXJWcbu/GBh+o4BlVnrZAqy?=
 =?us-ascii?Q?Cdl9XzP3Jo+fVG3Eu1OJLiYRRjrA0BANKZP9cNfuHUA8J4FYsNPqYqbJOxFm?=
 =?us-ascii?Q?pTK7Vusjp/jlmi9rXQqAgBDcKzkqQOoNoORdcsBXDqfP3bqiDazwyivHvIUC?=
 =?us-ascii?Q?CtH6sSvio09agr0QEzLEsajXTjNkoe2m7VAUaF9LfdjxA37xNmpCA4X96us+?=
 =?us-ascii?Q?HL7O+XhOBekspLSiqWHmI9Zn2XnZQJIRU1DWYhiEdLz9v31lbPH1I6xbgcy/?=
 =?us-ascii?Q?Fxc4LVshHu1BA/OvXqB8NLFjJb27RcuO10TRF7jxz/f318LaySSKuXxb6iCK?=
 =?us-ascii?Q?2IRHuL3NrkfPAxLLbqBiKgShRAb1zVeHa9bzucPNrrbt/Zra3yK7P+qg2wmP?=
 =?us-ascii?Q?xgw33u8/s/ESEmE57wD0Il+b2xdZmEGBczm0eOI/I9h34xuLWcFdF5ce8Wx7?=
 =?us-ascii?Q?teepFX3K65ldXAGw8Dd+fH04qfOeg57sImO0OB5wscEsn9viKTGN/qYoM0QT?=
 =?us-ascii?Q?pJAgOsV7af63HotlG0a7LlZ9NJP/bNhrC4M3qjgw4Xo/dKnspXv9Q2yCNviX?=
 =?us-ascii?Q?YQZEs/AygJ1U/fhu/7GEhcR0EgxdPBeHzOkob3TIqJJGbhZ0ZIrgKzlXw+Fa?=
 =?us-ascii?Q?8OIuHllUUKXnmtIQ47XU80cg91JkMr29R/488ABFRYBkGqHtHHFTMCThrDIB?=
 =?us-ascii?Q?LhG7EwNvY8tGQqmIOi3sPxIoZbynpue9Q9KkaMxAwUgi2ECSffn1bV2Di1w4?=
 =?us-ascii?Q?DEbIKunyLqBpZkdMXrVmSgwA0DthP4bG99VD5EX//kbF7zBMYm/9GHewH8py?=
 =?us-ascii?Q?KAM/XKJmaxzigimHsPhFZ2ww2Gdk65+jdjiQJxFVLszqCwn/VofvIneDZ2no?=
 =?us-ascii?Q?dVoNoK6X11VzbmCkppqSkPmK7JkZ3pHnrJ0hmv+vkffGK1ITPZQnaQQeVPKl?=
 =?us-ascii?Q?MyGbNvArtO5fRXXrIOoFgWku+2WIIYiZFb+V6PZJc9I5DXNGT9sOdcnNfdiY?=
 =?us-ascii?Q?H2TUnf0YE5oIOJi3hRc9fgt6qohGalEwXKsrWfSE5Yh9Dlm12UVyla1YkPfh?=
 =?us-ascii?Q?gd4thATR/Ncccbln2oEKlaPg+YMrB966IAgMtOUKQ3mPGGKSr8Js8cEASkLR?=
 =?us-ascii?Q?9wN3qzIBHG7pRixzOmxuxE1AR/hrCX5zCiXSFtshaVMUMnq35c0+55UMq1IU?=
 =?us-ascii?Q?VA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b3e90c43-7ce8-47fb-6849-08dd65ddb7a7
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 05:28:30.3809 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KxVSeyI7qIkMaZGEIUIM1zYFAfaMgJqvDGIc7G4fc5SzHvhiTUfpXGhwduF0ZW//HBBvvwCi1HTTH7C5RF9rYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7197
X-OriginatorOrg: intel.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Content-Disposition: inline
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [linux-next:master] [block/bdev] 3c20917120:
 BUG:sleeping_function_called_from_invalid_context_at_mm/util.c
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
Cc: lkp@intel.com, John Garry <john.g.garry@oracle.com>,
 "Matthew Wilcox \(Oracle\)" <willy@infradead.org>, linux-block@vger.kernel.org,
 Luis Chamberlain <mcgrof@kernel.org>, oliver.sang@intel.com,
 Hannes Reinecke <hare@suse.de>, oe-lkp@lists.linux.dev, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

hi, Christian Brauner,

On Tue, Mar 11, 2025 at 01:10:43PM +0100, Christian Brauner wrote:
> On Mon, Mar 10, 2025 at 03:43:49PM +0800, kernel test robot wrote:
> > 
> > 
> > Hello,
> > 
> > kernel test robot noticed "BUG:sleeping_function_called_from_invalid_context_at_mm/util.c" on:
> > 
> > commit: 3c20917120ce61f2a123ca0810293872f4c6b5a4 ("block/bdev: enable large folio support for large logical block sizes")
> > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> 
> Is this also already fixed by:
> 
> commit a64e5a596067 ("bdev: add back PAGE_SIZE block size validation for sb_set_blocksize()")
> 
> ?

sorry for late.

commit a64e5a596067 cannot fix the issue. one dmesg is attached FYI.

we also tried to check linux-next/master tip, but neither below one can boot
successfully in our env which we need further check.

da920b7df70177 (tag: next-20250314, linux-next/master) Add linux-next specific files for 20250314

e94bd4ec45ac1 (tag: next-20250317, linux-next/master) Add linux-next specific files for 20250317

so we are not sure the status of latest linux-next/master.

if you want us to check other commit or other patches, please let us know. thanks!

> 
> > 
> > in testcase: ltp
> > version: ltp-x86_64-0f9d817a3-1_20250222
> > with following parameters:
> > 
> > 	disk: 1HDD
> > 	fs: btrfs
> > 	test: syscalls-04/close_range01
> > 
> > 
> > 
> > config: x86_64-rhel-9.4-ltp
> > compiler: gcc-12
> > test machine: 4 threads 1 sockets Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz (Ivy Bridge) with 8G memory
> > 
> > (please refer to attached dmesg/kmsg for entire log/backtrace)
> > 
> > 
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > | Closes: https://lore.kernel.org/oe-lkp/202503101536.27099c77-lkp@intel.com
> > 
> > 
> > [  218.427851][   T51] BUG: sleeping function called from invalid context at mm/util.c:901
> > [  218.435981][   T51] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 51, name: kcompactd0
> > [  218.444773][   T51] preempt_count: 1, expected: 0
> > [  218.449601][   T51] RCU nest depth: 0, expected: 0
> > [  218.454476][   T51] CPU: 2 UID: 0 PID: 51 Comm: kcompactd0 Tainted: G S                 6.14.0-rc1-00006-g3c20917120ce #1
> > [  218.454486][   T51] Tainted: [S]=CPU_OUT_OF_SPEC
> > [  218.454488][   T51] Hardware name: Hewlett-Packard HP Pro 3340 MT/17A1, BIOS 8.07 01/24/2013
> > [  218.454492][   T51] Call Trace:
> > [  218.454495][   T51]  <TASK>
> > [ 218.454498][ T51] dump_stack_lvl (lib/dump_stack.c:123 (discriminator 1)) 
> > [ 218.454508][ T51] __might_resched (kernel/sched/core.c:8767) 
> > [ 218.454517][ T51] folio_mc_copy (include/linux/sched.h:2072 mm/util.c:901) 
> > [ 218.454525][ T51] ? _raw_spin_lock (arch/x86/include/asm/atomic.h:107 include/linux/atomic/atomic-arch-fallback.h:2170 include/linux/atomic/atomic-instrumented.h:1302 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187 include/linux/spinlock_api_smp.h:134 kernel/locking/spinlock.c:154) 
> > [ 218.454532][ T51] __migrate_folio+0x11a/0x2d0 
> > [ 218.454541][ T51] __buffer_migrate_folio (mm/migrate.c:945 mm/migrate.c:876) 
> > [ 218.454548][ T51] move_to_new_folio (mm/migrate.c:1080) 
> > [ 218.454555][ T51] migrate_folio_move (mm/migrate.c:1360) 
> > [ 218.454562][ T51] ? __pfx_compaction_free (mm/compaction.c:1892) 
> > [ 218.454572][ T51] ? __pfx_migrate_folio_move (mm/migrate.c:1349) 
> > [ 218.454578][ T51] ? compaction_alloc_noprof (arch/x86/include/asm/bitops.h:206 arch/x86/include/asm/bitops.h:238 include/asm-generic/bitops/instrumented-non-atomic.h:142 include/linux/page-flags.h:829 include/linux/page-flags.h:850 mm/internal.h:711 mm/compaction.c:1878) 
> > [ 218.454587][ T51] ? __pfx_compaction_alloc (mm/compaction.c:1882) 
> > [ 218.454594][ T51] ? __pfx_compaction_free (mm/compaction.c:1892) 
> > [ 218.454601][ T51] ? __pfx_compaction_free (mm/compaction.c:1892) 
> > [ 218.454607][ T51] ? migrate_folio_unmap (arch/x86/include/asm/atomic.h:23 include/linux/atomic/atomic-arch-fallback.h:457 include/linux/atomic/atomic-instrumented.h:33 include/linux/mm.h:1257 include/linux/mm.h:1273 mm/migrate.c:1324) 
> > [ 218.454614][ T51] migrate_pages_batch (mm/migrate.c:1721 mm/migrate.c:1959) 
> > [ 218.454621][ T51] ? __pfx_compaction_free (mm/compaction.c:1892) 
> > [ 218.454631][ T51] ? __pfx_migrate_pages_batch (mm/migrate.c:1779) 
> > [ 218.454638][ T51] ? cgroup_rstat_updated (kernel/cgroup/rstat.c:45 kernel/cgroup/rstat.c:101) 
> > [ 218.454648][ T51] migrate_pages_sync (mm/migrate.c:1992) 
> > [ 218.454656][ T51] ? __pfx_compaction_alloc (mm/compaction.c:1882) 
> > [ 218.454662][ T51] ? __pfx_compaction_free (mm/compaction.c:1892) 
> > [ 218.454669][ T51] ? lru_gen_del_folio (include/linux/list.h:215 include/linux/list.h:229 include/linux/mm_inline.h:300) 
> > [ 218.454677][ T51] ? __pfx_migrate_pages_sync (mm/migrate.c:1982) 
> > [ 218.454683][ T51] ? set_pfnblock_flags_mask (mm/page_alloc.c:415 (discriminator 14)) 
> > [ 218.454691][ T51] ? __pfx_lru_gen_del_folio (include/linux/mm_inline.h:284) 
> > [ 218.454699][ T51] ? __pfx_compaction_alloc (mm/compaction.c:1882) 
> > [ 218.454705][ T51] ? __pfx_compaction_free (mm/compaction.c:1892) 
> > [ 218.454713][ T51] migrate_pages (mm/migrate.c:2098) 
> > [ 218.454720][ T51] ? __pfx_compaction_alloc (mm/compaction.c:1882) 
> > [ 218.454726][ T51] ? __pfx_compaction_free (mm/compaction.c:1892) 
> > [ 218.454733][ T51] ? __pfx_buffer_migrate_folio_norefs (mm/migrate.c:936) 
> > [ 218.454740][ T51] ? __pfx_migrate_pages (mm/migrate.c:2057) 
> > [ 218.454748][ T51] ? isolate_migratepages (mm/compaction.c:2167) 
> > [ 218.454757][ T51] compact_zone (mm/compaction.c:2667) 
> > [ 218.454767][ T51] ? __pfx_compact_zone (mm/compaction.c:2529) 
> > [ 218.454774][ T51] ? _raw_spin_lock_irqsave (arch/x86/include/asm/atomic.h:107 include/linux/atomic/atomic-arch-fallback.h:2170 include/linux/atomic/atomic-instrumented.h:1302 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187 include/linux/spinlock_api_smp.h:111 kernel/locking/spinlock.c:162) 
> > [ 218.454780][ T51] ? __pfx__raw_spin_lock_irqsave (kernel/locking/spinlock.c:161) 
> > [ 218.454788][ T51] compact_node (mm/compaction.c:2934) 
> > [ 218.454795][ T51] ? __pfx_compact_node (mm/compaction.c:2910) 
> > [ 218.454807][ T51] ? __pfx_extfrag_for_order (mm/vmstat.c:1138) 
> > [ 218.454814][ T51] ? __pfx_mutex_unlock (kernel/locking/mutex.c:518) 
> > [ 218.454822][ T51] ? finish_wait (include/linux/list.h:215 include/linux/list.h:287 kernel/sched/wait.c:376) 
> > [ 218.454831][ T51] kcompactd (mm/compaction.c:2235 mm/compaction.c:3227) 
> > [ 218.454839][ T51] ? __pfx_kcompactd (mm/compaction.c:3179) 
> > [ 218.454846][ T51] ? _raw_spin_lock_irqsave (arch/x86/include/asm/atomic.h:107 include/linux/atomic/atomic-arch-fallback.h:2170 include/linux/atomic/atomic-instrumented.h:1302 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187 include/linux/spinlock_api_smp.h:111 kernel/locking/spinlock.c:162) 
> > [ 218.454852][ T51] ? __pfx__raw_spin_lock_irqsave (kernel/locking/spinlock.c:161) 
> > [ 218.454858][ T51] ? __pfx_autoremove_wake_function (kernel/sched/wait.c:383) 
> > [ 218.454867][ T51] ? __kthread_parkme (arch/x86/include/asm/bitops.h:206 arch/x86/include/asm/bitops.h:238 include/asm-generic/bitops/instrumented-non-atomic.h:142 kernel/kthread.c:291) 
> > [ 218.454874][ T51] ? __pfx_kcompactd (mm/compaction.c:3179) 
> > [ 218.454880][ T51] kthread (kernel/kthread.c:464) 
> > [ 218.454887][ T51] ? __pfx_kthread (kernel/kthread.c:413) 
> > [ 218.454895][ T51] ? __pfx_kthread (kernel/kthread.c:413) 
> > [ 218.454902][ T51] ret_from_fork (arch/x86/kernel/process.c:154) 
> > [ 218.454910][ T51] ? __pfx_kthread (kernel/kthread.c:413) 
> > [ 218.454915][ T51] ret_from_fork_asm (arch/x86/entry/entry_64.S:257) 
> > [  218.454924][   T51]  </TASK>
> > 
> > 
> > The kernel config and materials to reproduce are available at:
> > https://download.01.org/0day-ci/archive/20250310/202503101536.27099c77-lkp@intel.com
> > 
> > 
> > 
> > -- 
> > 0-DAY CI Kernel Test Service
> > https://github.com/intel/lkp-tests/wiki
> > 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
