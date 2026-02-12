Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A8B3EE3697
	for <ltp@archiver.kernel.org>; Thu, 12 Feb 2026 15:18:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6CAE43CF3E2
	for <ltp@archiver.kernel.org>; Thu, 12 Feb 2026 16:18:19 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E50A93C7024
 for <ltp@lists.linux.it>; Thu, 12 Feb 2026 16:17:59 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C480F20009B
 for <ltp@lists.linux.it>; Thu, 12 Feb 2026 16:17:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770909479; x=1802445479;
 h=date:from:to:cc:subject:message-id:
 content-transfer-encoding:mime-version;
 bh=UuQiCoFGrvcxEtb82a8gC+GbeK/LWn0f5UlPSQHEFn8=;
 b=S46DpQ/VNXDxG39Nd7J74hcD5eXpagdSYS9WJ+bW2IU6JuWod0XjkFqv
 MGjlwszLbN1eKKclKgj3Yx23W9pPMeSklItJOS/ZDFL1QQ/0RWLv8cPMv
 Gmix8IILsf49eH3ZCflnFv3Qszf+oh/7VbmMP2dMqK0lhd+hd1Gw8RF4S
 7/juDKqrVEHN7yCZnjzl+WiPrTDLNhso4o1b1L1+cTV+Z3zpUxqA3+/+T
 jwgebQ6e1Fp5xRjSA8c0kE2/qAq8Mr+54uu1nGzIDthUa8WqPx9OtFMRY
 3X1UeQKZsjXflWDOXU3FndU17HWsEOOOa4uunf+DNspwA1ZxYQsq3U+nx g==;
X-CSE-ConnectionGUID: aggW1QNNTy+FbJUynW7u3w==
X-CSE-MsgGUID: Y4s8iqicRyWUT/UJKgY5eg==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="71977697"
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; d="scan'208";a="71977697"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Feb 2026 07:17:55 -0800
X-CSE-ConnectionGUID: 8vrrsqR4TJmgpkuecvVaaw==
X-CSE-MsgGUID: P0Gi1chETWehNfledr4hgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; d="scan'208";a="217588375"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Feb 2026 07:17:54 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 12 Feb 2026 07:17:54 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 12 Feb 2026 07:17:54 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.36) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 12 Feb 2026 07:17:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZIdXz/rDugg/EdCVE4SFbHWLDCa3a4Y9jYeb4iu8q7ckj7O8YZ9y91IHCfPlvEchTSwdoiRBHsO0nw8GvInmY2zwz5bDL3kqgIun/SETveFBjevqAGIiBrOOha7/gI7VD7Ca7TWLBd4EGAVb/YSdgypi6e60yiW5upgZFWFifWg7wvf9aLfWJcryRbFXhRYFw4VtebXO4SxyKDHFtqqsxvqbMfwQKzQlHN70fmGpQSoEcDMrOEdXpX2RJ0ZLWtZiHwJxP+Dmvd1hTyJLhNnt1Lt+rgyWUwjUDLnyw0bo54HJJe8HnShIVLXH+BHFo8x9gQLYy8Nctcu4IfjJbIogQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ev4ERQIE499TJakUynp7Z+rEEFw+pxqkCXSiEfC9Nj8=;
 b=NBgEx+l2jqRH03mJMwz3FjIsV92P1Mw/lMF++Yy4E5uuy+xWzq63js1Tg2C98O/FV5Zgcddv+8WviDGwq5zLSiU4bd/CjsKsolR0EHkyajibjqn/XkWeqrsZR85MA1sLygYgDxBUFpGAnWGAJpGDWLBAfj4vaE3qgPs9GgjPlZmi5SCSTZ9MIQilG0a4kSxfAjv+uZFQGK07Sp+QTuTxVRy1Al8iG44xP5GBfmXLS2tIQrzte9qx3HaHdQ2vVvUDOeesAoSnSKmYm0WyBlqCGtWff3ibw4FUyHdRDLBzB9Jb7uHNNlCFZLgScqyYV5Ro5lMShg361il0RkWQqSFGWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SJ0PR11MB8294.namprd11.prod.outlook.com (2603:10b6:a03:478::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Thu, 12 Feb
 2026 15:17:41 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::e4de:b1d:5557:7257]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::e4de:b1d:5557:7257%5]) with mapi id 15.20.9611.012; Thu, 12 Feb 2026
 15:17:40 +0000
Date: Thu, 12 Feb 2026 23:17:32 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Christian Brauner <brauner@kernel.org>
Message-ID: <202602122354.412c5e65-lkp@intel.com>
Content-Disposition: inline
User-Agent: s-nail v14.9.25
X-ClientProxiedBy: SI2P153CA0027.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::22) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SJ0PR11MB8294:EE_
X-MS-Office365-Filtering-Correlation-Id: 24cbf959-d8fb-4f48-329d-08de6a49dd0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Y+R5jZNL3x5i4lLnc5egL99OdeZtESo7fOK6ZCfgL/jVMRLly91IHkWevEBn?=
 =?us-ascii?Q?s1v4ho8jqADEnFfId+evcMBWQECksFztl6AVEU0l1JMFhvOQI7FjxMbRGyL6?=
 =?us-ascii?Q?CE3vXrERmDJAArV/2e7TaRJRTu7iMQcivxC7M3fPbglUeHxaNuZZpojyflsi?=
 =?us-ascii?Q?kjWsOI8Z7o4jejZrJvyiUm0RBM2YIDbyAqMJHb8gWe+MFrewC7IzPw7NHvAf?=
 =?us-ascii?Q?2alnPMwANzoYyBG949ArM0caktCvs+7Il0YG8rMYchE06CVUx9JmnWpMkE2O?=
 =?us-ascii?Q?wUF0fiQOyXESBxYxTgC7X+YNOLPJivxJilicfl3L15Fw93Je23u3JlRZ7YNK?=
 =?us-ascii?Q?JsuoEoLGNFb4H86RwJBHeCxzH4iTpg9dlXNvM/M7fu8ZapO8EtNDsVY97gP9?=
 =?us-ascii?Q?x4eVK2cbbbMkvUSDaBENqiwf9tFoSEC8wpq2TvyHCtOA+gRXhQ0qJEZJfUWz?=
 =?us-ascii?Q?QAm1hZ0KL+oHtB+bi1Xe+XiTSFHUYKDNgZrfe7kvnDXOv3tcCubLyzzStUoW?=
 =?us-ascii?Q?ndXHcrzTjmBtnQAIDzUi5EtdNFuZhMTa+0NVb/Dc4vE82M3mt+/hznzM6x9Y?=
 =?us-ascii?Q?LIQ09UaUYbeR91woc8WJuHuEXq7V69S0VBVBWrCVj21JybcBtYq83K++khdD?=
 =?us-ascii?Q?JB/ZrXe8lWZ1PhhHuXETfxuc4VvUedvO67EvIFdBXv3bp13mRjKDcJgAz2GD?=
 =?us-ascii?Q?EJGFOZTvFZ+7dR4gtj8YaYOXxEZVLeTX8oKSskh0ZxK+r+k3RSiVFhHY/mlq?=
 =?us-ascii?Q?i5lZDZ/Wxz+XuCV1HGClHAWvFE6DbjQUkvevRP/fn+WT2mXPIWGwYhTUo4X8?=
 =?us-ascii?Q?Om4r0MsttTVrXk1LLw2uk9hMv2G0bLAp34Y9wCFPGZdMcHdhWLjMtYX32udH?=
 =?us-ascii?Q?7aEW2tpJGUbp7jmKAbGaHjKBpu1UTCUIL/y+PNQPQZmj+TjN/934CFTrCcO4?=
 =?us-ascii?Q?B2X2WZVKAzVszLEZ+3/s4ZbapagnvISt9sc+aX/E3ngklpZdQVIoOGsAuWWM?=
 =?us-ascii?Q?YnS1322Q8UKGjvBNCUTP1LP36gpRrZskp5PbLFqrV1o0xhZz9FUhKf1kqGVW?=
 =?us-ascii?Q?aR1OxLNd/+KHb+wQlXe/LOh8XJpbNQ9y2cTjSI0iYQUpz6hWLD+D+obEhEL0?=
 =?us-ascii?Q?dnykR9ynhARpTrxXXvqnJijKY/BmIPAjhMGBNAk+e4NWG050ungG3q8CWgSy?=
 =?us-ascii?Q?iTWdMEBanVrXT32WIbbBYbLSutFZwJ2UTDQxzmvwPpQT1FTMXkRya4LxER4y?=
 =?us-ascii?Q?BTDmMQ+doycUw27Mh9cg17oRD/xvlvS5MtCrx4wbq7sfl1nbXDOhNgaF2VQZ?=
 =?us-ascii?Q?89EPy+HyC/58dU4BddJXwGpGZn0RxK8defrMhBhmSDZ5opNN1NTvIA7CMCe5?=
 =?us-ascii?Q?+L0ESm9mXgDgxScVyovv/t3jmCJB91iLbCyi8Q+IGi/JOr4ok9+Z1dLOI3a9?=
 =?us-ascii?Q?+UXEDGDSkm4qY4QQVHVEDEmDpdPHTSXCk9mHnuvzEQpnhyRLMRbixOGB3Yf3?=
 =?us-ascii?Q?lS/fs621RHotKZvY7QGIWG4G3YFybBS1vLbyTfDC0YA6l5vSrUcIEzsabRnH?=
 =?us-ascii?Q?MJHmRlnbHb7+nAofp2YJXsxVbsenUesyhJm1++1P?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR11MB8603.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/480ZTEj9ZIvQTUlohqOw+WMlLGsRAiOSqKFIKFpkTsrZhbzEqSuyi6VJE2p?=
 =?us-ascii?Q?LY4h1lH5PL3dNbqihCKmxFs6Hg8YKhHvxx8mh59u3HeSkM0EEyHG5rdz4K6a?=
 =?us-ascii?Q?dB4YADMh43T9dTA+gxd6w2ztv/ok+61zEGBVTs7EsTQdFdMBBtVzVywS0k5z?=
 =?us-ascii?Q?D86Oq9pckz4qqHBvKvaWFcpRBsOh93UvGtdLTfUlzIB31Uqo1NxxGaVWtSq9?=
 =?us-ascii?Q?ZdkwSoK2bLGhmnE6tFE15C/sPcCsEk1ZkafiTG0pV1b2acuAYazesRg51GYA?=
 =?us-ascii?Q?++0a3WyXDxFJpsZhPu36sydI2qdFw7n/mqlCL87WChlGtGZyr4rbJCYO9ImS?=
 =?us-ascii?Q?XeY0pI2sUasqGb9SYbBzAF/JOiYyB1NZbTtQ8xCZQ6qi47EE01SRgWJX/7VE?=
 =?us-ascii?Q?gE+FLjVn9xQXyR33P8XY5Zz4vVFFd2Jf6SY18/s+RrpvQrvX6IOb91hJZNO+?=
 =?us-ascii?Q?sFgw5CVyNDQPPLJrLkRkSBIRLHhzdMLdLb+Wep867aEHp4BcmOnH2HH8ILtV?=
 =?us-ascii?Q?S0SdBSjT1J79TBc35DuQjTOB/4+GX0ScqrrmlU4oPwztVlUkYs4jz0kkGyB9?=
 =?us-ascii?Q?jad28Osf+365y584H+C1GC0uKnG0HxgdPQ2PYMFmGAqW1Z2XF4QdRYG0AfO8?=
 =?us-ascii?Q?KPssfGRDJUcKBosNTMdHvWei/4Zq+4+NwUBg6wcO8SSWLbMmyGzULcPLcAPl?=
 =?us-ascii?Q?Bbl9X7AvdOYpACaLa65r+oA86cUDmB2f9Q5TziYAKmy5ZbA1UlZHYnS3wTaT?=
 =?us-ascii?Q?ximq5nY5txzHVzj0C5ozgaiTcyYJ0tABUh10JJEVCKUxHBGZpUDteu4BDyHS?=
 =?us-ascii?Q?h6WwXLxDW3KA/5XFj5YDKNNRgeDv/tZ35aCfW14EE+/stb5X+xeDuiHqA7gR?=
 =?us-ascii?Q?viEqX70uW3WfA0ZY80x2TR1za88+jJlcmP9YW1C7CEfWzf1hJaBXrXzxRzdw?=
 =?us-ascii?Q?AxkTRNBDl+EGja5GM62JBq/0WDZBuzEBIBChhxIa4Q0EFvdnMaEYRnkupVID?=
 =?us-ascii?Q?X6EVwgcNwxsTA4RZ2rM/g9npGBSou6pbhY+/aOeJzn/feBp9vOGEJB6n7J8C?=
 =?us-ascii?Q?PpgZ1TwmQFkMkzVocxQykeaGVMu42E+eMbMNa0KT1bZf6w3kqER+0KGF6gVy?=
 =?us-ascii?Q?vCp9MXRgF23xQhws/6hFxKR5xNeFSygj3nf54PirJ7X9JdYds+VWCvWFc4gh?=
 =?us-ascii?Q?2XsuRMM70JvpWROVlUIc1h/prTK1GDsJPJ3yGd28NrqdJAw/sSabRerKndyq?=
 =?us-ascii?Q?RgXycthV5CxbjOAEA3flyu7r61NioHR1uP4teN4i1mu0YI+wqaPfKJk7+lWs?=
 =?us-ascii?Q?FBxy/YbWCoM+vJQXzKfWTG5Vu8a3YGlPsYO7TOrOmnlvOHBDsh4WMvQEkyLg?=
 =?us-ascii?Q?6RYrxw5MO7oEznPgwJNlW4y7P9u/OArAbvUh7G1Q8GH1Ym3QtWgNF1JjoaOi?=
 =?us-ascii?Q?z3UdiGYWJjekoA10v3A95nM2oL1d0sGhPwtsCSQ3glGlNLCr6b1UGOB5PfOc?=
 =?us-ascii?Q?jDfiK76Z9pILNzXKbmXeIGOaqNCeSJBWe2UK4RY9VYeMg90j4b9WHWNtzRL1?=
 =?us-ascii?Q?5XDmAiMxA1qrWEPfTAhkyuDsoFwpMgk9oC6LRUZTau7Vge4RMPUJabr9goC4?=
 =?us-ascii?Q?b6jTY/lS7lv4htx8udJoXjn+2BIuv5QChmF6kHwQQFbGrs0dc9PGU0pjV+UI?=
 =?us-ascii?Q?v1o2OGQHIcdEXs3884Cu0TxtPKZxWhCeeah1dM8VVHmOmvRwOvaSNvvMRmvx?=
 =?us-ascii?Q?kJvV5SFIMA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 24cbf959-d8fb-4f48-329d-08de6a49dd0b
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 15:17:40.8182 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z3yk7R1ii7FH4YjXP1qVFiiYzmfM9ssUe2QkJnj73mYRPpquzAwcDANQO9YtZur26SBZ3GVInTWB41LOmulvdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB8294
X-OriginatorOrg: intel.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [linux-next:master] [mount]  4f5ba37ddc: ltp.fsmount02.fail
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
Cc: lkp@intel.com, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 oliver.sang@intel.com, oe-lkp@lists.linux.dev, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>



Hello,

kernel test robot noticed "ltp.fsmount02.fail" on:

commit: 4f5ba37ddcdf5eaac2408178050183345d56b2d3 ("mount: add FSMOUNT_NAMESPACE")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master fd9678829d6dd0c10fde080b536abf4b1121c346]

in testcase: ltp
version: 
with following parameters:

	disk: 1SSD
	fs: f2fs
	test: syscalls-01/fsmount02


config: x86_64-rhel-9.4-ltp
compiler: gcc-14
test machine: 4 threads 1 sockets Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz (Ivy Bridge) with 8G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202602122354.412c5e65-lkp@intel.com


2026-02-10 23:32:32 export LTP_RUNTIME_MUL=2
2026-02-10 23:32:32 export LTPROOT=/lkp/benchmarks/ltp
2026-02-10 23:32:32 kirk -U ltp -f temp_single_test --env TMPDIR=/fs/sda1/tmpdir
Host information

	Hostname:   lkp-ivb-d04
	Python:     3.13.5 (main, Jun 25 2025, 18:55:22) [GCC 14.2.0]
	Directory:  /tmp/kirk.root/tmpcy80fcz_

Connecting to SUT: default

Starting suite: temp_single_test
---------------------------------
[1;37mfsmount02: [0m[1;31mfail[0m | [1;33mtainted[0m  (2.116s)
                                                                                                                                
Execution time: 2.187s

	Suite:       temp_single_test
	Total runs:  1
	Runtime:     2.116s
	Passed:      16
	Failed:      8
	Skipped:     0
	Broken:      0
	Warnings:    0
	Kernel:      Linux 6.19.0-rc1-00011-g4f5ba37ddcdf #1 SMP PREEMPT_DYNAMIC Sun Feb  8 10:38:35 CST 2026
	Machine:     unknown
	Arch:        x86_64
	RAM:         6899608 kB
	Swap:        0 kB
	Distro:      debian 13

Disconnecting from SUT: default
Session stopped



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260212/202602122354.412c5e65-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
