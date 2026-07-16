Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D82FDC44501
	for <ltp@archiver.kernel.org>; Thu, 16 Jul 2026 01:23:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AD9943E99DC
	for <ltp@archiver.kernel.org>; Thu, 16 Jul 2026 03:23:20 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 258043E2CB2
 for <ltp@lists.linux.it>; Thu, 16 Jul 2026 03:23:00 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 2CC90600746
 for <ltp@lists.linux.it>; Thu, 16 Jul 2026 03:22:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784164979; x=1815700979;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=cJWtDeXb5V4rqOYClLTeSduo04W3fWUr0NLcNo4REos=;
 b=TLksABkyvIc6n0k0Mo+MFCxqkb36oKTcFD+O0uikA4ZPtCzdzhASGxy4
 VlfSqm9Advm/Yu4GHQJXNhPp7GVkMvhBOHeKqkcWTpzzZ9cT5rJ6pMalm
 pHRUhaAGVEz5BVsqpis1JzkwNuoES6c4BMSeAJqpjnF4tzx/OI96wU1CH
 3BksovOKmRIhu1a/3rIM79/TQBFlN32a5xSlE1oCDIoOugPeVq9fbYO8W
 I/Aw9x/9MxsPucDHBgz8PvnUYTLdO17tguZ9BbHv76EgDHz2UsylS4xth
 SQCgHe+0ul3nDiU5GNPqixsEEpW+V9WA5iBvw4MFGoXt7SwYlPloNy6qB w==;
X-CSE-ConnectionGUID: ENWn46BxSAuR/838XX65aA==
X-CSE-MsgGUID: ZZXoTjbXT4i/yEQPS4jcmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="95170812"
X-IronPort-AV: E=Sophos;i="6.25,166,1779174000"; d="scan'208";a="95170812"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2026 18:22:53 -0700
X-CSE-ConnectionGUID: pkU3FUWXRHaI5W46mwUQsQ==
X-CSE-MsgGUID: REcP6lncSY2D59KFeLno9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,166,1779174000"; d="scan'208";a="256404197"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2026 18:22:53 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 15 Jul 2026 18:22:52 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 15 Jul 2026 18:22:52 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.16) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 15 Jul 2026 18:22:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ss3bAs1YVXDP8WxaOwk7NTheyXi53RgpTfh/keifhXDtAsW54RfmesghhhdLqJZ3HmKVqf9I3LUsgmXACym7uEjgHphHID1oSHa2ufc3eZOiuRaoTOzDjZdarhfGhjsyi13Ka+hj1Bxersn/Z9X4WpqX7lAGqt9EQRzGpb09O66TfrM25IXdJvhRH/0+cTouGno6byUKfzbzYCnjohH6oq1xmz1t8OHaCj5XZw5CMmZcxHX86uQ5LnqKF9PgIi8+2AVY0ZN5HquSOq+SkVUI1Lt8LErbM73sesd2DjDKtIIcXXj2r1Pvy7o2KCkDn1t0auGEu7R7xxAAbXTzfPvDeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QITe8mcKxDGrLMsa5P4ImXZqUIdmR1/vu9F9jEVFyoU=;
 b=CVDbt/LYdRB9G6Ucji+2snDS45IJR4z7WWKJ0+JsQnizCc2Hvcbq3GhkZP5ojd309vKpXpDU6zirdNBsTOYDNHJqqEM4x0qq61bbF6UqsQ9o2s145nTXk11+LpIgTweaFE/Ycdl1rOxPNny+0sQH9zVnh8tIwHaWf5EXB99zOegSgAVuk0QaqGWmCChHKsYVTswFPJytetbGGgGjwrAZKvZSWuZ3DHgcRCPsUb6XqAZ1dk0RT66Bsd9KxSgbUPZi03X3ldMn+loThFYz13zROEabxTXisf8gXQeyyW42MdJStVHOL1jwfZDXUHjin+KW55Br/C22V8eCV8K+a9j5aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7)
 by SN7PR11MB6703.namprd11.prod.outlook.com (2603:10b6:806:268::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Thu, 16 Jul
 2026 01:22:47 +0000
Received: from PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707]) by PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707%5]) with mapi id 15.21.0223.008; Thu, 16 Jul 2026
 01:22:47 +0000
Date: Thu, 16 Jul 2026 09:22:35 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Message-ID: <algyW7c79Vl1Ilq2@xsang-OptiPlex-9020>
References: <202607151550.5d829a99-lkp@intel.com>
 <1ecf0eb8-17ef-4f9c-ba87-da69d207e4d4@tu-dortmund.de>
Content-Disposition: inline
In-Reply-To: <1ecf0eb8-17ef-4f9c-ba87-da69d207e4d4@tu-dortmund.de>
X-ClientProxiedBy: KU0P306CA0052.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:28::8) To PH0PR11MB5832.namprd11.prod.outlook.com
 (2603:10b6:510:141::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5832:EE_|SN7PR11MB6703:EE_
X-MS-Office365-Filtering-Correlation-Id: e7e57f20-04df-4a1a-001e-08dee2d8be97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|23010399003|1800799024|366016|22082099003|18002099003|4143699003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: BfqT8v5QqUvpV8vsOvVuXibJ97Rc7vP2rxB9ScZoU6DzWDA+EmtSlU8QfuXTct9crzo/EiqGHT69cn493i4wUPJMGqynnQugxFOT+tuqihTMUXhGlsZkanHfessC3w4TX16xvqSSFcagCRe7v7t9pD4zmdUa0CQE4+dX7NmCFEqGQOW0Skt62uC+fOys8SPapoqN3pzU8caJzWByzmRKVCP/9wDw4yMfMe6gBtNtb+Ih4yItYpIgotjw3AlmFveluE6AHXrtswRRfiYbKhjJCSlMiUOAcPrBHI8IoxdsYR2Jy2T2alI4nNl99AY0OIHK1megY6kVJRueVrB3bo9hYg8Y6UazWOkcE+3KsIMwlBll7/lFeTOrNtAitdQdfV6JSrXAQ+eB/Edgb/vy0vvbZJpcNQBmsKIxje6FYHr93KiAOc2X3wOVNnmxggXu3rYfDkNTROBpFvXPmP5U0qVUD7GCyD81+0AigcogWcaVinP4GsWUTUee3mqGNHBQUVPkma8kguL5pmiqyanTDNNDNmVLPWhVy6tVFtHWE5hISjTqQdEOzZulA/vNuBWqTO/cooqnnAkSvxAqU6GPeqZd+7QaPvT57l5MmtjFSA+XmAhDcPRKLypFlKg4kcEaYvVo
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB5832.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(22082099003)(18002099003)(4143699003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9caDBpouZ06RV6BKTb8R3sURQxELFk3PNnFv/Cw1Sy5noqG+wsKBsq/qFoFY?=
 =?us-ascii?Q?pynFWPkYYzaUUfWbmmyEqLJNZHxwdmsJVYwdWSCGjL0Fy3AlVjdQ2ichkvYZ?=
 =?us-ascii?Q?wKYJHr0TI3wkm6r6ckF/t0wc/dR/Y2hTK6yosswVdMl28JthAiafa9f7bt04?=
 =?us-ascii?Q?HZSmbNQLaebB3ETGv9MVYgXw0huCso16VmGbeokrRUSDzWgPpdN9f1aa1Exk?=
 =?us-ascii?Q?KnFaG3Xy3ii3Jew+ie5RC0jU0fG5ZytRTxYgzLG6o/3NdeYOMHm7tcLl0Cy7?=
 =?us-ascii?Q?wRlCMwqmhcRuSAM6cC3kdgBBDXsYZSS+2yTRh2L9onBtk4zzUOfXgBz81fEo?=
 =?us-ascii?Q?AGJ384JJTmSvL7HKy2Yvjl7z/kwLcpabdykpRrmKHstwwfUpQZ38jgWYdZqj?=
 =?us-ascii?Q?FgH3VtIuQNkHmZY7GHumiS8OMkG+VF69RSBni17Y0GNwBo1Vp3vqY0irwclu?=
 =?us-ascii?Q?hrtxjjQ8yZNFOTnxjYc7nFJUg8AD0fD3Mo8ePHlLsN/LjC+nn1dQrgQEX5IY?=
 =?us-ascii?Q?5YdpOG4BLs2g94bAcsnHu5YkB8V5tpK0qbw2szEe4jRn6WYdHFsZ5OiIHAYI?=
 =?us-ascii?Q?eCRAIHe4jpw6yVjvf41cNWGlfB748NprSmdGbXBbUYo+wjnywZZeMz1+lS0x?=
 =?us-ascii?Q?i/C9ffJY59n3OMXbP9FmA8Bjfm8kPxczZV+UFqbd/tmNyLEo48A4AS8bsGwD?=
 =?us-ascii?Q?YeRxkUCyDL9d39MKM/5VqS6cDUFn0OGZUPH0QgqrG445GKaAqrBnT7reCVr0?=
 =?us-ascii?Q?aUubeesYKsySwmx8G9GWxGNnkvW9p9LkjNUWz1s7O4Eu4d+ehE8bwYPNsKQS?=
 =?us-ascii?Q?Kene9NcIijEXwls89V9B/Tpj5NWdXwgD3quSdXEd41YE4qDliJcILhluZj8D?=
 =?us-ascii?Q?Ohh/HlylQL+yFvISLu7bK1O+s+GQuqEMFsHYybZjZZdKS/siqTFTggALzsAn?=
 =?us-ascii?Q?caowEUbj25ODV6MGcO/P2ifUjCxxYeJNBEgFIqvZOoStZABbQph42cAEDD/7?=
 =?us-ascii?Q?t3ZoeTK6zU3AmepDunPf4ldaPa3W3Ex87Gmj8m7EYoSTEbeO4OVuny/Ecaqh?=
 =?us-ascii?Q?gj4ITxKwblsgeo4EzSlazgtKkTyA42h0l42fLfQGevuX8AHuwVDlzEnkzly7?=
 =?us-ascii?Q?ZmqsKxRPHT+C2pPDmB1mJamC6xHYD+wMGf/CiR+DlN8C8FviPOGXP6cCpPer?=
 =?us-ascii?Q?0Hmenac7qJasDD51bOWTBfsoZRS3Kk6YL1vEyO+Y/bE+Fqi85eMMsR4uXL3G?=
 =?us-ascii?Q?LFnuDMfKZqjNoUabjisvHAhvHpOj5UXTJcSLHdEi1pFznbsFF9jLotnrzEl1?=
 =?us-ascii?Q?BRHtxtS97KJ7y0FPv5YttI/B2mFBtWtBi9dvATwZcT4Md1MpVUBOJZTaOAZg?=
 =?us-ascii?Q?l1LC9GzoCelmWNyr+zGgOZhgTH5s6DTp7Oz+ZLdLd+Eq5b7yxlJ/4ALm55fM?=
 =?us-ascii?Q?4morJpwk44VLGVOmPF32A19+SrwzcCQ8xoUKStj8GESqkzWds2vIUmTfyWXs?=
 =?us-ascii?Q?FF0igl3F7DqN5boCrq1BBNvuRhwSzXbYpiCjPnr3UE43Ysi7hRdzUXJ6ve5E?=
 =?us-ascii?Q?SRlJqJB3vi144vAXwxO2oNbu6B5hmCyEbp9Cp6ud2zSFwfTmHZsFOLbXOkuL?=
 =?us-ascii?Q?viBaFEe6+KITpdzI2rgqsU/GjpbAdeSk+JKUaPx96FCLSrxQT/OslzMP9MdN?=
 =?us-ascii?Q?kdUQTtZi91O4CIWq++RqhKO59kz5JiqNgqDPW/1+ZFr4nzKsdPrlsLoTB6T4?=
 =?us-ascii?Q?oozdZdYldQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: d17A5b7Le+h5eQbGbBgL5XKNWngZfgoxTrFM6kIYm6jaxltNKpFbhJ4TNzh93WHw5Lhz7jMzOZaMF0whtM84ATS/yUE20PN4zHjKBv4SfL2o26/prv94Lh0NZeTWDE5RYyXKngMGZ1c9L9xa6LrAn+OuEZYKOWlRGNimNOafL+/cgjM+TXRLaSZEn9dgUq0SDAqihngqo3h7zZcmI/EMhTG/pWSRjKsdE4tcyV4EE4F9NggxEtNGelJtUHkpyx/J6MR5OhavA40OURnLmByeJvyyXL7BAYZoaSbIlc4px5SIshmMQbapOWoS3Qzh48aloS+mgof6FYNgqiWXUd1fwQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: e7e57f20-04df-4a1a-001e-08dee2d8be97
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5832.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 01:22:47.4138 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qOEptO739PP8YJbZXAZ/F10P2vavdBfDkE7sSo50m4vOXYyy02vTvV4W1hObbU+HbMlyi5qKcHVbJ1faNKIAew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6703
X-OriginatorOrg: intel.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH net v3] tun/tap & vhost-net: make qdisc
 backpressure opt-in via IFF_BACKPRESSURE
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
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, lkp@intel.com,
 Brett Sheffield <brett@librecast.net>, "Michael S .
 Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jason Wang <jasowangio@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 oliver.sang@intel.com, Simon Horman <horms@kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>, oe-lkp@lists.linux.dev, Jakub
 Kicinski <kuba@kernel.org>, Tim Gebauer <tim.gebauer@tu-dortmund.de>,
 Paolo Abeni <pabeni@redhat.com>, "David
 S . Miller" <davem@davemloft.net>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

hi, Simon Schippers,

On Wed, Jul 15, 2026 at 04:32:26PM +0200, Simon Schippers wrote:
> On 7/15/26 16:01, kernel test robot wrote:
> > 
> > 
> > Hello,
> > 
> > kernel test robot noticed "ltp.ioctl03.fail" on:
> 
> ioctl03.c does not know about IFF_BACKPRESSURE which is introduced here,
> consequently it fails.
> See [1] where it compares TUN features with known_flags.

thanks a lot for information!

> 
> Thanks.
> 
> [1] Link: https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/syscalls/ioctl/ioctl03.c#L82
> 

[...]

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
