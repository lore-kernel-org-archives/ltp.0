Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B757ECD9BF
	for <ltp@archiver.kernel.org>; Fri,  6 Feb 2026 02:52:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D26833CE6EF
	for <ltp@archiver.kernel.org>; Fri,  6 Feb 2026 03:52:03 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F09913CD31E
 for <ltp@lists.linux.it>; Fri,  6 Feb 2026 03:51:44 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8412C140020B
 for <ltp@lists.linux.it>; Fri,  6 Feb 2026 03:51:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770346303; x=1801882303;
 h=date:from:to:cc:subject:message-id:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=HSUcStNSiag2fSLOrSgVQs3wghId4T9TVnBDD5NQlOc=;
 b=K1qjN3T2JNfCoigcxrZxjHI1sq9Y93L+MhXPPOIEtrjjiTUJyAHu0wN5
 U4Y8iN/dDl5YmL0hQBgnZjVyUp2ZDqRF+8/vqyqt+qhx22MP4x8MPwTfr
 VlhD66m6heW0M07VMfxdsASrEMo0e3xBlf6IvSxBQe7YkmnIaMPB7fHfS
 hIxsrwCFkjIX1QXhpqQOPH4LLnzrbWCSyycbkDOP0zqtStgcR9HkEJS1w
 H/nXtpeDKd1hWuv/NnBimbc2i9buWsEJh5W0qMym32kD4y7U0wRpQP8Gj
 wZAGDWd5p2xR04CtiIqiaFVMxfcNWVg7UBflXVPuNaPm3MHPGJ2rx3ged Q==;
X-CSE-ConnectionGUID: 9xXmUqURT+GE4JiMZH5cXg==
X-CSE-MsgGUID: M31IjOtASlKRdxbXRx21SQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11692"; a="82669100"
X-IronPort-AV: E=Sophos;i="6.21,275,1763452800"; d="scan'208";a="82669100"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Feb 2026 18:51:37 -0800
X-CSE-ConnectionGUID: 9CbMuVfYRtqo7G66w6STaA==
X-CSE-MsgGUID: ZRZnRI72SQmsyR904ss7Vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,275,1763452800"; d="scan'208";a="241265690"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Feb 2026 18:51:36 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 5 Feb 2026 18:51:36 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 5 Feb 2026 18:51:36 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.57) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 5 Feb 2026 18:51:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YZ1XRo9W7hYQUvlQZOVg3fbYQ+FgVF86+7hiX9susHzwHpyYRK87g+SSmxjynl9be0lweqAuXJfYKvPTyiO3S0G2p+73YauxFc2A4+FFp1G6HAC+bpHmaijTdXx3v0dmlm0RI9VcJo74EF0coZB3OtISO+xNuG8vpeu2MhZGLp3zVQ+Jyct8wAYZSTv/Rnn+pALhkBA8CH5+ocdovHjKVP+TyaVAOUt9T6YuAa4qiGyNbBa9uGV2KDLCzq7juw1Ju9//tesvGVYSdPCGVqqj+Kde25hKzErSbSVlmxCPbsqp+WjTa2d+bxvvgdl7SJtdxdej6LR9sTQxVQ1tHrx3kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AzUFvYZS9pkC28oOFnT4wNYAB8yev2lLFkeJI1FClxM=;
 b=iRlX6IVAPFtgytlMgXqRNbFrMWF0Wp3WaWNj3up2uCBcNKcW5bDH7ev7HUnlS9wOJN0vmLpbsaE8E01qeNfTvmM4GWbx1K96hukh2EZQ5pl+L0C6zaLW46A4OJEPnrxsQ8fVhZxnZYMn/JUD34jX//gMLE0IHqyBjrUnz0amk0MorI73khdrH+FdqFG4ZK2sbtUipd052JUAOQDoyK6zSML6/rPIqmek3GVvoOhqk6uJH6iFnBv9BixldETlTTC+5lNMxRIybZGFLqkcFJX9zLPAofuQ1goyD3TnvCDli0lCjG8Tbh9vGD/TJKkf/BQHiWZDxiWDG+yavmfug96TIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SN7PR11MB6727.namprd11.prod.outlook.com (2603:10b6:806:265::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Fri, 6 Feb
 2026 02:51:33 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::e4de:b1d:5557:7257]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::e4de:b1d:5557:7257%5]) with mapi id 15.20.9587.010; Fri, 6 Feb 2026
 02:51:33 +0000
Date: Fri, 6 Feb 2026 10:51:24 +0800
From: kernel test robot <oliver.sang@intel.com>
To: <luca.boccassi@gmail.com>
Message-ID: <202602061056.b94e9170-lkp@intel.com>
Content-Disposition: inline
In-Reply-To: <20260127225209.2293342-1-luca.boccassi@gmail.com>
X-ClientProxiedBy: KUZPR01CA0029.apcprd01.prod.exchangelabs.com
 (2603:1096:d10:26::11) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SN7PR11MB6727:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fc9421e-04cb-419b-87da-08de652aa2c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hDmXdUJhr0YzHjp7K8yvJPxb1NT70HMgP26WeZoXr26TzK06Fv4wd6fTeXkX?=
 =?us-ascii?Q?kP6FQCVtq9mAL2+dR8ZjnQNfZIg9DhNCn9V0ivLEwkeOsHLp3Svg1KCmw3km?=
 =?us-ascii?Q?VxoGn7AKRWjEbTi6Xa5a/bnYh82szdhUq9oFPiH3lLRiq1qYSV593Y6P4huw?=
 =?us-ascii?Q?xazldjTyyWatF5nHxNGWMqewd5wloJngWT3Xi3yh8lXkS2hes+yxhEvtPkSK?=
 =?us-ascii?Q?eaUr8aEkecsAYq0Vk/wGln74pJLoDPgl6cUoCvmiDD2yimJ0CBhNfaAIfRWS?=
 =?us-ascii?Q?c0tCIaODgIShiEXaaD6axslYN+skw6SL16dtBfUDPDa1+NhV2l+eV1QVW1rw?=
 =?us-ascii?Q?CtWZ6lye1xBnBsmXNIq70xQBSaTmLrfwVpUSuESkJOQuuEKAwId+6vCNrrwG?=
 =?us-ascii?Q?pmg/Er/qD3lgkmSBPcLcaZh5pDoqVXLpv1qN4tjphfDKLZYg2WpC0ymoeJL2?=
 =?us-ascii?Q?bUrIk5HLA7xmD339wt5gsGIjEvDrwCPW/jmMXpDseM2XhWUlfPQackwYNGu/?=
 =?us-ascii?Q?q5xujbNninWQtgsH2ZkQPvw0JyAaiE2HkRHqr0hfR6rLS9mXot3Ftn3lhPl7?=
 =?us-ascii?Q?QgfHQJbcfez/Gdg9/D1yn9EKoGDvrwCVWEnvmhfehdmbLeyVNdthPPupFeFC?=
 =?us-ascii?Q?Uw5J1HwkxIm9OPh8CE+mj0tSJLMx+g1e/qpungq+a7JB6Jt5ZETMs9gWTFDZ?=
 =?us-ascii?Q?kdC48p4RIlem9uDXE5aQXFyrlbQK2lE5x1VJsiW4gfQzFrMFXDYtOwfBnt7z?=
 =?us-ascii?Q?zUtlb9jQ5M1CGE3HPSNpSNzItAflcvfYPB1vc0/14R/0+mBGZQ4MIU8SUC2r?=
 =?us-ascii?Q?6G5e8igGFFY6EP36eSsUmH+9MBLWXhz+ARM0JJh8FejtMhtkdqlLLHwPtgzI?=
 =?us-ascii?Q?O4L/TVyvQjn+gF1iroPYEB2AurzOtkwKqQZo3m96MaorEMeLJkQ6KcrGPA9n?=
 =?us-ascii?Q?Y3fL1RVQUWyQaGUE8IAF1yVr1qIrtNZD7iuOdGz0KMazR/y4GyxkThpSHtdw?=
 =?us-ascii?Q?0MmgdMdooKDIcLO0VqzTspFaUYggZ3U2QVTjd4vXnXBUL+pUF7/so/lQj7cp?=
 =?us-ascii?Q?cqCCYOc5r9g4qoY7MGyw+kMU6JFNO9PzJSRPRncCM37nhYRreFJGh435CFHy?=
 =?us-ascii?Q?+yvpu3kx3T1fjke5K/KFnA4Mk6zrd6G/igTB0l5uKfJQHVvLbDQTrMwSxTwG?=
 =?us-ascii?Q?jk6f+HiqAwC60oqlBUWNJfLnoRFqlt3CjxQRMHmMFU92txvDg7nA5fjZJtfI?=
 =?us-ascii?Q?W0uwomH3V7m6AdwDN/uNXui0Wmtv0CWAJ4FTAXv0Gjbgz+zMhbl0JCbkaiqk?=
 =?us-ascii?Q?nCmenc4GStuknzyOMK3pkQoN638XdpTvpjZrFfFMznv93UsqyW3Bii4CbR6E?=
 =?us-ascii?Q?TGjwrYusSpSYDGs5BXOwPphRpvi9LIDPhEhygEAQbhdzBhI5nSnNMGIsaRTg?=
 =?us-ascii?Q?3mC+6UcLdkwCQnMD8oisT5DT240lY/UaHLUWtL4AyMToXMJJfCvKlLrGGUKd?=
 =?us-ascii?Q?q1KSXtAefP/ah9zP3rZ2H6TnrGwc4NyXg5Sh?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR11MB8603.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dutrUNTCMevqN4F/AVK2g33TxPLA+zqKDyoneNMYwnTi5vdy9yfOei7MyScI?=
 =?us-ascii?Q?2bd1tha/MiskfZSMgfAZWRJ6Qz+9LxZqipENwXY6p1irOFs+ZfKNcDFlWjPm?=
 =?us-ascii?Q?jZk/l7GZUtzwBcfMsFGf2ajsIzg3AgjNpokoGMnB76AFOGhRTtk1Ey/V2zTv?=
 =?us-ascii?Q?w7R9LwFTzEop98rjGVy+4+WRPgHeKeBHz/E+o2EmM3way9nOWFGvpWjZZChQ?=
 =?us-ascii?Q?1HEJUcomxjgPKdr/jxVF+tG7ziXXNdVCI85jb5OOcROxlbO8etMxN65e204m?=
 =?us-ascii?Q?T2kceQtarMkQbV3uGWX59KUkxvqXR+weW5LZzfDDC5JmsQvbBAT6RD0P7fnL?=
 =?us-ascii?Q?r00RyMdatUSWO4cPTc0BrF4lL7N40WF6bv0/sWeNUlBvDAPgKHU7jJM5vluc?=
 =?us-ascii?Q?VxB89+8v9TMTdNDzGzRvT9ooRVkefk1aQwJZZAQT67uvDMw7y438Wa2jt6Kk?=
 =?us-ascii?Q?rWVx02f4bGMHmTfta1+5/4CvuYEIVlOkPIcEuHpcsB4kzOr6xPja/7LSWlSr?=
 =?us-ascii?Q?HM7T+rgD5RVwHErffjmW1L9W0qV59E/zPCyAnV10VT8+2TZ0sF0UV5L2zhBZ?=
 =?us-ascii?Q?iqUQo43x3DHsQ80yrO+qQMSF50nrxsK0xnwexr6qkBdOq+ti7k3ADxXNjECb?=
 =?us-ascii?Q?pHhqtE9OIP/ZvERDeBGG6ks7vjiNJwT8qRqqoGSpjS1IlQr4SbZft//Rnj9H?=
 =?us-ascii?Q?mFSGPjrUTkzRVDyvGcY4gg9LRrIPhO851fDSfjPMLFKSzA1OKVWHy8bBmnhD?=
 =?us-ascii?Q?zY52nf2m9TLC4W9R8L6kRiaWWrljnt7o63jKdnzoNJz7VQHS/r5ObFH6CKaR?=
 =?us-ascii?Q?OQY77Xt8FiQ53I3pNM9v9J7y/jfd3qcpo7aQYTEs4kR4Y/wQGITE9ghPaU9r?=
 =?us-ascii?Q?6XJUvByIN3/DIjFdG3M6Qz5YgKHmmdxMb9FCMsPGZgX1Dlt5oy+K9mTwjnvj?=
 =?us-ascii?Q?vhMC/l/ASHdNfwlVYYHWJsyeMzrZ/XWj+pBxjjD2ozVXXO9wcrQS6xh9a6Lh?=
 =?us-ascii?Q?FI3seT/WAF4oDimK8mJlq5ALGLCu9mBa+o4Oxl+8wPDlkMrxgH5MQnORpI2C?=
 =?us-ascii?Q?FSLtx4Fn6iZm0m7OaieCVCFpi94UHnYtGodchHJ4MkTKGfTccgSc6jXcNZTZ?=
 =?us-ascii?Q?z2APEq1EaGl5OCsutZlI4Gzb7CmxDp7eQVWF1v0VGJQY70GHCF+fxy2vZDxJ?=
 =?us-ascii?Q?IPwITS682FtCcG730468iit/dyjeHOzGDc+LCXJ9utxCzmWWOMWF7VmAVkOo?=
 =?us-ascii?Q?/s1Z3meO/Xn+ZnTCuMuRORSYnDQaJHYlR8XBN8bGdztDBE+AmnYDBOKv23T9?=
 =?us-ascii?Q?M2ShJcEp5ctt8WWEkTMyC3lxXuRySHVmfI1ti8HTothkdfbLEKNENGIxP0AT?=
 =?us-ascii?Q?+ZCzbhjtxhds/4TyOpuLWeS0xmURHm9H10pLXjmXG9DdJJ+Bg674xUIlOlRr?=
 =?us-ascii?Q?HTJL2HSCoav8LRmV7TinLLowIZSUyqrqPjhVngtOuhoa+5adehmL961rx5NE?=
 =?us-ascii?Q?3og29WolvxlCDBCfwX4J96iXjEZrB2IXJ+dUUTCNAa/pmlt5ZGfA7BVHj2RI?=
 =?us-ascii?Q?ZVRy6Qmk7VLrMvEfnSZC0ulPKmSKmfGOlHi5soo0iC4Ni0H/66LivYZDlKGo?=
 =?us-ascii?Q?2URmPDaopzfSxEN/3KZMDYyvetQ/hSkcSFbzTZiAgSUTPCaUMWRGJMOi4WuQ?=
 =?us-ascii?Q?FfQO2FUZN6yeIsKi8gPAifupvpBcydBknkemI5+ix5c0WxZtYRmMgqYurk9W?=
 =?us-ascii?Q?7OLJ5PVFIQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fc9421e-04cb-419b-87da-08de652aa2c9
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 02:51:33.2908 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7sH8rHa5nFikJaN7YTwEYP/6nvNOSpx0WZf10TY0gcuEjK6o9K417KfZisPkNyBpE9BQIGGUq7TFLAqbNY1NzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6727
X-OriginatorOrg: intel.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] pidfs: return -EREMOTE when PIDFD_GET_INFO is
 called on another ns
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
Cc: lkp@intel.com, linux-fsdevel@vger.kernel.org, oliver.sang@intel.com,
 ltp@lists.linux.it, oe-lkp@lists.linux.dev, christian@brauner.io
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>



Hello,

kernel test robot noticed "ltp.ioctl_pidfd06.fail" on:

commit: 16cc0cf19e0b75a336cbf619d208e22b351bd430 ("[PATCH] pidfs: return -EREMOTE when PIDFD_GET_INFO is called on another ns")
url: https://github.com/intel-lab-lkp/linux/commits/luca-boccassi-gmail-com/pidfs-return-EREMOTE-when-PIDFD_GET_INFO-is-called-on-another-ns/20260128-065425
base: https://git.kernel.org/cgit/linux/kernel/git/vfs/vfs.git vfs.all
patch link: https://lore.kernel.org/all/20260127225209.2293342-1-luca.boccassi@gmail.com/
patch subject: [PATCH] pidfs: return -EREMOTE when PIDFD_GET_INFO is called on another ns

in testcase: ltp
version: 
with following parameters:

	disk: 1SSD
	fs: btrfs
	test: syscalls-00/ioctl_pidfd06



config: x86_64-rhel-9.4-ltp
compiler: gcc-14
test machine: 4 threads 1 sockets Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz (Ivy Bridge) with 8G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202602061056.b94e9170-lkp@intel.com


2026-02-03 16:33:15 kirk -U ltp -f temp_single_test --env TMPDIR=/fs/sdb1/tmpdir
Host information

	Hostname:   lkp-ivb-d04
	Python:     3.13.5 (main, Jun 25 2025, 18:55:22) [GCC 14.2.0]
	Directory:  /tmp/kirk.root/tmppqdrj0by

Connecting to SUT: default

Starting suite: temp_single_test
---------------------------------
[1;37mioctl_pidfd06: [0m[1;31mfail[0m | [1;33mtainted[0m  (0.034s)
                                                                                                                                
Execution time: 0.100s

	Suite:       temp_single_test
	Total runs:  1
	Runtime:     0.034s
	Passed:      0
	Failed:      1
	Skipped:     0
	Broken:      0
	Warnings:    0
	Kernel:      Linux 6.19.0-rc5-00159-g16cc0cf19e0b #1 SMP PREEMPT_DYNAMIC Tue Feb  3 23:56:34 CST 2026
	Machine:     unknown
	Arch:        x86_64
	RAM:         6899592 kB
	Swap:        0 kB
	Distro:      debian 13

Disconnecting from SUT: default
Session stopped



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260206/202602061056.b94e9170-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
