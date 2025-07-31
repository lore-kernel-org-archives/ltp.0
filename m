Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 846E2C83F17
	for <ltp@archiver.kernel.org>; Thu, 31 Jul 2025 07:18:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EC9713CBC31
	for <ltp@archiver.kernel.org>; Thu, 31 Jul 2025 09:18:52 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1D0063C2593
 for <ltp@lists.linux.it>; Thu, 31 Jul 2025 09:18:35 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id BC19B1000A0D
 for <ltp@lists.linux.it>; Thu, 31 Jul 2025 09:18:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753946314; x=1785482314;
 h=date:from:to:cc:subject:message-id:in-reply-to: mime-version;
 bh=G5Ayk2HlXMsJpkGln7c11vWq2HbsrFSdnw6Lf33jGJw=;
 b=PKuwv2pfXBRXOfJR7rtyGqo5PneQdgiNX8BmDzBmV8k0o30R+xVTcPE8
 QjiP16zXBzc3sOs5JNZkoNt5rgIYPZ+P5/3NU9ea3oKzWqlMHbaly60VK
 2zekXmwWMiAeAwHAoelaFPv86eo0RqQXtMOtWRmcEzDDc1n9yt919Zem+
 0X/o6Wi/KDxfMMfJ1yls75tV8oa3/9++FRnn6FKKjXri6LN2s3r4Ga6ns
 XWcP25qa6SI1J/fGxR/rKAzbZ5V1fYJH/mJwxci75B4JLtLW2hn8RhlSG
 uS9DvveBtk9CuRvX7f2foOgfQYCSyRC0TtkJLwQruloi5C1gErcYbF7SI Q==;
X-CSE-ConnectionGUID: vjgpC6ALSDKkXO68X2EjzA==
X-CSE-MsgGUID: sPdLel1bQbKgjFgtGg2PHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11507"; a="56145150"
X-IronPort-AV: E=Sophos;i="6.16,353,1744095600"; d="scan'208";a="56145150"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jul 2025 00:18:21 -0700
X-CSE-ConnectionGUID: lBD2KzPFRnmVyvkKkkQoGw==
X-CSE-MsgGUID: oblytpz3Q0+Wvkf4Z0E8Qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,353,1744095600"; d="scan'208";a="163981134"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jul 2025 00:18:20 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 31 Jul 2025 00:18:20 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 31 Jul 2025 00:18:20 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.45)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 31 Jul 2025 00:18:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rGOsHYZpjxOq8lOA72stv4ifivYj8RnMGsxfszz2cBtdXC7dUPkyQtAq6Scw00f0QRBRdZI0dDCiMHEZSrJsUSLzObtmudbr8p7msGYv+B+r6MvPvysgJzPqt1JASn0we9d+RNN13OS633dP6N7zXfoMC/tkm4TW7EcLjUihJ6eIf24t62vBLk5UYjTShSLBtoQ1R6Z/zvr5D98PJTnl+h1q28hbasnNtubZFkbCzs8+bv+G3sPHy9UZMM5/1Qom7h9WidS95q5Uomzs93aApCFozXM0ukJxtiDAG7XvkKrrm+DfgqZWla0v8GiM751CS4F88r0Plumo1QbD2ZfRfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JZmy+BYZ1jG2zTB/T/g9CM4OTmMFRZv5ISlxbWpJPIM=;
 b=dfjJeDQ8krVlwTZ/TUmDycSWvTh1WofUk4O22o+QvUm8vRfUxj2WMpFGxUCAv4X/2q+HqeC8yIgD7MrfrfI7GRl0b5j7RdvYBKbKm4YonoMNc6zd2dAb8ySa72IH3RLzjOE+HxsXEvzcxhG1UozKn9ieRCZyY0u8hv5dN1CQNLpzsal5nVmDQukPY0tFqCTCJ2JzF3v0RiC482EiFVo5P5S7CnhaDZ0Rct1XgPdWwA+VzbPvtNIe/m5kyLCTq4EpXP5kmRiXOoENk8VREhuNDC9oQfToNqNbvCpzCDTgE1tkX6PVObE7NjJnoc6bCcKFh0Ay7ahhapeuIasrRI4Ebg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by BY1PR11MB8055.namprd11.prod.outlook.com (2603:10b6:a03:530::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Thu, 31 Jul
 2025 07:18:04 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8989.013; Thu, 31 Jul 2025
 07:18:04 +0000
Date: Thu, 31 Jul 2025 15:17:53 +0800
From: kernel test robot <oliver.sang@intel.com>
To: <nicolas.bouchinet@oss.cyber.gouv.fr>
Message-ID: <202507310843.52fb528f-lkp@intel.com>
Content-Disposition: inline
In-Reply-To: <20250718-yama_fix-v1-1-a51455359e67@ssi.gouv.fr>
X-ClientProxiedBy: SI2PR06CA0009.apcprd06.prod.outlook.com
 (2603:1096:4:186::17) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|BY1PR11MB8055:EE_
X-MS-Office365-Filtering-Correlation-Id: 825d2a0f-ecc3-4641-0fd2-08ddd00263e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?j9jumlYJhHX9M8RgBFhHmfcKpP4G8AGpQ/fN+zlqpYhBeE4OxQQSI50iaZx0?=
 =?us-ascii?Q?cmoDCfeiYg+uTQEJ/LMhpLIjfF7xbt3yp2OFqB7g4BnGwZ26yW4XWFOZ+ta/?=
 =?us-ascii?Q?QHO2WGbQXaLzt/VOolYRopyRoZkgurASQLmRyjs2bh4h5xtoTEIGyfCtspNw?=
 =?us-ascii?Q?waTqL5mXG+xgHiiugrZPBGJNuMr7tW7anAxQCO0mJWlmvHejDb3brrkAeez3?=
 =?us-ascii?Q?Ez4DHbsOC1v3Ji58VexNAAtl4s0h6fuNpZbXjftUeAZHO7Pr4dfguh8B48kA?=
 =?us-ascii?Q?TXp4c8wBS4Pvi2LSZKPCcng2HsJNAZD1peISgy7w/SUCjFV0xevsDkN1AT/e?=
 =?us-ascii?Q?t2Jx4SfV//28Dy377Ux3Ow3qWNKI1CPTrvPbs3uJozdZWgHR+BXZb5JujTkQ?=
 =?us-ascii?Q?99YMPl8lNR5uBxL5xvFv+oVSVBTVvO4L0g/0c2F3iUDtdcCIMDZQchQ3eYZk?=
 =?us-ascii?Q?Rm72zRETBZsP1IYHShbI7DX10npvcOJM8HpUkf4w3Ae2VKxmqIpQBPhZOo4N?=
 =?us-ascii?Q?GST4kBGOxQc9VguVbEUQlkLpnHkv2WE8qxhY70Sf6h6REHJZcIRnSQ+o+PA9?=
 =?us-ascii?Q?h8We+wM8edBNGUqjZtJPG9VEF7IwDWfSMUnrztw7AGe0iBuoh7SS7JHOjuTl?=
 =?us-ascii?Q?T6afELwlVOIhxzGABeCaysWq60yGZe3e+5V15NUyaY9BCDqPi5Tl8mNBYv1P?=
 =?us-ascii?Q?RH2jcKq7i/EyVeTOtr5KrQbnrGCVXV/EalmtPcbDEdob5cJGvZO5KqKQmauV?=
 =?us-ascii?Q?oBJPGiBNX71OmT8DS9KQeBanTgAQuUkB9Czf+MCluNM3dnEM10MhABU0SlQs?=
 =?us-ascii?Q?oXN/Kr26sXZ4NV9XMD53Jf2o0TGrKQaIFMo4GQ4FAxE8VG+1459d9qU60SXj?=
 =?us-ascii?Q?5troZY1CtjeAChD/usyc0VbQrbNaZ+F0Ocke0yv/uxf/knE10sS3ze3J0Kxe?=
 =?us-ascii?Q?qNtqnmW6W2N1rkxFm321Hul7oIuWFIV6hVUB6kMRIJKLmixK9E29Z7x/arlI?=
 =?us-ascii?Q?tAfwo/49jRIS+UK+O/EMndi/hB4AOowuVMcnbxzKzcmzmEUKu8qoPxUm/lMS?=
 =?us-ascii?Q?tJy6KaNqPTymFnhoOEa0x9U1ZsOxeEjKC6EI8QWUaneRUAkMydBpicyCQf0h?=
 =?us-ascii?Q?68oQxPHMw7YMjXMQLHb9j3j76L2mPxDHqGgw5OUppQWVzRrYypvGwfdiy6Ql?=
 =?us-ascii?Q?gQPdoxu5x2YX41YLRhXG2qgrK30RBXV0QLAgNTYcgo7eRolS66grH0Z3ECSs?=
 =?us-ascii?Q?O4saVPLrY/ISxINDqBiwc8glj9io8fKtz+kU+GPE/uLKHOHMlrOHIFhLY3Fw?=
 =?us-ascii?Q?XZSnFcTWQoZJ3XY5uSyFV0M8Lsmr0S76TBrq2RGnlRkYujJncLcxMrDRV0M0?=
 =?us-ascii?Q?kEu/+6h/AxRyQrlame3qOFyG68NQ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR11MB8603.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NbUvpipxgmqrjPdQOPDAjua8j5z45Zy3QY3zUps4V3Zi4XA6itO9fpL73d8k?=
 =?us-ascii?Q?8r0MdAAytr2uYH2AHl8rVI2UySHxamCcT5CFJGuB0QWOKPTSGzDNm1tgJhIB?=
 =?us-ascii?Q?3xn6z4Uyupjp36rFOtt3wmxfnCx6+6sChYYZ3vv7M/5MdFa3vXB4CgnlTM6z?=
 =?us-ascii?Q?hl3OxDvfZvtp5yAZUUS5+OfQhanJWWoJaL0GvUMRzHGJQOWqN/O18HkOP1yc?=
 =?us-ascii?Q?NgNdxP+e07LY/a79YY5fAGz41YB+bwjE2SbC1q57B6rs/2QGhYFLrrSZztXb?=
 =?us-ascii?Q?3x1VWsFoJ90lFOyMtXNjd0B2pUzy/L86jAQmlvZUE53B+OrcWZxyF+XmfNN6?=
 =?us-ascii?Q?eOy6xvGFZNtQ8841ULU4Aq3+HxHOUoRGb06oeyxqKT5+TPDmvzKdmPJ5+WbG?=
 =?us-ascii?Q?T+3ajoSc71nR69xaO5/jCHO35NNuUtqs37aBOx/MNk6PVwvyJAGTX9Or/krD?=
 =?us-ascii?Q?Ed5s9DTnpYj3xx1HsEvtToG3M7axGVnURArhLjz6Kzr8hC98g/MHMERdWOUu?=
 =?us-ascii?Q?ngSyO7T1t/s4DmJgsfLQ/RMj/AibjhuJF+ReW0XOfivW0ZZQSZt6iirdj7IU?=
 =?us-ascii?Q?b91rqBdgOOXMthKJXiEK1iYUMbvkFJAbxRloWzVgnc5RjUaq8m7E+UhIb2i8?=
 =?us-ascii?Q?CMTJhTwb7gmZDQXrAOz9JhpjidCxI/JOtA9bE09QqJbza3lFWrCAas8uU0sH?=
 =?us-ascii?Q?OTfbZKlSC5/Rt/ffda0gh6Q1DCPelbf6jIgojl5ZfyFXRsd3tACvGLwXeisv?=
 =?us-ascii?Q?Xsc039u8Ow7f/6jhlYkGSC15BXtTTZJqjSrX5FIYEIG2mSWskKKVvev37ikj?=
 =?us-ascii?Q?GskYIT8dF1X7i8ROi+0DlxotfGw7YQEtRuBnhJ40QeBIjXYXfydNRseY0X/r?=
 =?us-ascii?Q?jOt/+kvsh2L06mggNjo4fOy3UP60I7xyV6ADdNJIlEaazLia3sgoiQ+Nm+Td?=
 =?us-ascii?Q?yd6CT2vHNzZCxeJmI7pHLE2tDhq58sXxW553MgSmXKhbX+WxvP369b62RCEf?=
 =?us-ascii?Q?r9wBgujwNCoSqQSI3Rym28vPPpMbd8+n+vqTDJAnp+P4JrLVTaUpfTIPwF06?=
 =?us-ascii?Q?dtXPUBNygJj3vbx0w41sUPrT4juGjSJUW28MSZ1dYjIq3K+2nk938kHiNUJ7?=
 =?us-ascii?Q?/pjDbocuPcA+BFjQzqqWgtv+GyqmdQ7PvrqiRFTVKouWpwShaRV7Wt7by+R0?=
 =?us-ascii?Q?jsdlXkz/bZ6ob+w5M0T+sWjvtDkSa3jyySarvvxM75r5XzrrQhtCoq43juHD?=
 =?us-ascii?Q?TlHzTQrRCB80qB3PPpQcE7/ZbM568aM0rHnFil5YPp+n+qXQxSrLhBx0u6Is?=
 =?us-ascii?Q?Cqy9F731d4+BFXJEwrYx7Atx39Cxh7SpLd3ovBZprxPHa1LsmPW4nsV+KqNa?=
 =?us-ascii?Q?17uYqIAJU3iGJt2EgXEUjrJC/ka8zO/KS/EdzowZaZwF4fl8O028ka3yAAeG?=
 =?us-ascii?Q?Zvf/pIrgImVCSb9AZlobgW9OGJZAP44P5owSjwcXZvoYGjuiPybF6paQcTpE?=
 =?us-ascii?Q?rszqTLRD/tL8SCB5yXVxrWeBVbvfIroD8lRwkc8ExkVSYn+viwR4kKkyZUZr?=
 =?us-ascii?Q?bA8wJRQnsGDxJx5OJaKXma9ugDHsg01daQADf1gmr6eeR/QPE1dvn8ft7Epf?=
 =?us-ascii?Q?aQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 825d2a0f-ecc3-4641-0fd2-08ddd00263e4
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2025 07:18:04.4085 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5xhiZhTieTZhXjaXh+t6iXIFgQ7KGx+0bItymuS/QV8YRjVTvmf9tVhiw5f5KL3Jm23Hgu7xe5Pj4YAnndHFwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8055
X-OriginatorOrg: intel.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lsm: yama: Check for PTRACE_MODE_READ_FSCREDS
 access
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
Cc: lkp@intel.com, Kees Cook <kees@kernel.org>,
 Olivier Bal-Petre <olivier.bal-petre@oss.cyber.gouv.fr>,
 James Morris <jmorris@namei.org>, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org,
 Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>, oliver.sang@intel.com,
 oe-lkp@lists.linux.dev, "Serge E. Hallyn" <serge@hallyn.com>,
 ltp@lists.linux.it, Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>


Hello,

kernel test robot noticed "ltp.migrate_pages02.fail" on:

commit: 0d6496041d407998103595db3dc42240f124a7f1 ("[PATCH] lsm: yama: Check for PTRACE_MODE_READ_FSCREDS access")
url: https://github.com/intel-lab-lkp/linux/commits/nicolas-bouchinet-oss-cyber-gouv-fr/lsm-yama-Check-for-PTRACE_MODE_READ_FSCREDS-access/20250718-164849
patch link: https://lore.kernel.org/all/20250718-yama_fix-v1-1-a51455359e67@ssi.gouv.fr/
patch subject: [PATCH] lsm: yama: Check for PTRACE_MODE_READ_FSCREDS access

in testcase: ltp
version: ltp-x86_64-0e4be9201-1_20250726
with following parameters:

	test: numa/migrate_pages02



config: x86_64-rhel-9.4-ltp
compiler: gcc-12
test machine: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480+ (Sapphire Rapids) with 256G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202507310843.52fb528f-lkp@intel.com



Running tests.......
<<<test_start>>>
tag=migrate_pages02 stime=1753707486
cmdline="migrate_pages02"
contacts=""
analysis=exit
<<<test_output>>>
tst_tmpdir.c:316: TINFO: Using /tmp/ltp-5PDNJlpHwH/LTP_mig4NxxK0 as tmpdir (tmpfs filesystem)
tst_test.c:2004: TINFO: LTP version: 20250530-108-g0e4be9201
tst_test.c:2007: TINFO: Tested kernel: 6.16.0-rc2-00013-g0d6496041d40 #1 SMP PREEMPT_DYNAMIC Mon Jul 28 20:46:21 CST 2025 x86_64
tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
tst_kconfig.c:676: TINFO: CONFIG_KASAN kernel option detected which might slow the execution
tst_test.c:1825: TINFO: Overall timeout per run is 0h 02m 00s
migrate_pages02.c:313: TINFO: Using nodes: 0 1
migrate_pages02.c:143: TINFO: current_process, cap_sys_nice: 1
migrate_pages02.c:147: TINFO: private anonymous: 0x7f1006150000
migrate_pages02.c:75: TINFO: pid(6801) migrate pid 0 to node -> 1
migrate_pages02.c:96: TINFO: migrate_pages could not migrate all pages, not migrated: 452
migrate_pages02.c:125: TPASS: pid(6801) addr 0x7f1006150000 is on expected node: 1
migrate_pages02.c:75: TINFO: pid(6801) migrate pid 0 to node -> 0
migrate_pages02.c:125: TPASS: pid(6801) addr 0x7f1006150000 is on expected node: 0
migrate_pages02.c:159: TINFO: shared anonymous: 0x7f1006150000
migrate_pages02.c:75: TINFO: pid(6801) migrate pid 0 to node -> 1
migrate_pages02.c:96: TINFO: migrate_pages could not migrate all pages, not migrated: 452
migrate_pages02.c:125: TPASS: pid(6801) addr 0x7f1006150000 is on expected node: 1
migrate_pages02.c:167: TINFO: child shared anonymous, cap_sys_nice: 1
migrate_pages02.c:75: TINFO: pid(6803) migrate pid 0 to node -> 0
migrate_pages02.c:125: TPASS: pid(6803) addr 0x7f100614f000 is on expected node: 0
migrate_pages02.c:125: TPASS: pid(6801) addr 0x7f1006150000 is on expected node: 0
migrate_pages02.c:143: TINFO: current_process, cap_sys_nice: 0
migrate_pages02.c:147: TINFO: private anonymous: 0x7f1006150000
migrate_pages02.c:75: TINFO: pid(6801) migrate pid 0 to node -> 1
migrate_pages02.c:96: TINFO: migrate_pages could not migrate all pages, not migrated: 452
migrate_pages02.c:125: TPASS: pid(6801) addr 0x7f1006150000 is on expected node: 1
migrate_pages02.c:75: TINFO: pid(6801) migrate pid 0 to node -> 0
migrate_pages02.c:125: TPASS: pid(6801) addr 0x7f1006150000 is on expected node: 0
migrate_pages02.c:159: TINFO: shared anonymous: 0x7f1006150000
migrate_pages02.c:75: TINFO: pid(6801) migrate pid 0 to node -> 1
migrate_pages02.c:96: TINFO: migrate_pages could not migrate all pages, not migrated: 452
migrate_pages02.c:125: TPASS: pid(6801) addr 0x7f1006150000 is on expected node: 1
migrate_pages02.c:167: TINFO: child shared anonymous, cap_sys_nice: 0
migrate_pages02.c:75: TINFO: pid(6804) migrate pid 0 to node -> 0
migrate_pages02.c:125: TPASS: pid(6804) addr 0x7f100614f000 is on expected node: 0
migrate_pages02.c:125: TPASS: pid(6801) addr 0x7f1006150000 is on expected node: 1
migrate_pages02.c:200: TINFO: other_process, cap_sys_nice: 1
migrate_pages02.c:75: TINFO: pid(6805) migrate pid 0 to node -> 0
migrate_pages02.c:125: TPASS: pid(6805) addr 0x7f1006150000 is on expected node: 0
migrate_pages02.c:75: TINFO: pid(6806) migrate pid 6805 to node -> 1
migrate_pages02.c:96: TINFO: migrate_pages could not migrate all pages, not migrated: 362
migrate_pages02.c:125: TPASS: pid(6805) addr 0x7f1006150000 is on expected node: 1
migrate_pages02.c:200: TINFO: other_process, cap_sys_nice: 0
migrate_pages02.c:75: TINFO: pid(6807) migrate pid 0 to node -> 0
migrate_pages02.c:125: TPASS: pid(6807) addr 0x7f1006150000 is on expected node: 0
migrate_pages02.c:75: TINFO: pid(6808) migrate pid 6807 to node -> 1
migrate_pages02.c:92: TFAIL: migrate_pages failed ret: -1, : EPERM (1)
migrate_pages02.c:55: TINFO: mem_stats pid: 6807, node: 1
Name:	migrate_pages02
Umask:	0000
State:	S (sleeping)
Tgid:	6807
Ngid:	0
Pid:	6807
PPid:	6801
TracerPid:	0
Uid:	65534	65534	65534	65534
Gid:	0	0	0	0
FDSize:	64
Groups:	 
NStgid:	6807
NSpid:	6807
NSpgid:	6801
NSsid:	2420
Kthread:	0
VmPeak:	    2868 kB
VmSize:	    2868 kB
VmLck:	       0 kB
VmPin:	       0 kB
VmHWM:	       0 kB
VmRSS:	       0 kB
RssAnon:	       0 kB
RssFile:	       0 kB
RssShmem:	       0 kB
VmData:	     348 kB
VmStk:	     136 kB
VmExe:	     132 kB
VmLib:	    1548 kB
VmPTE:	      48 kB
VmSwap:	       0 kB
HugetlbPages:	       0 kB
CoreDumping:	0
THP_enabled:	1
untag_mask:	0xffffffffffffffff
Threads:	1
SigQ:	0/444866
SigPnd:	0000000000000000
ShdPnd:	0000000000000000
SigBlk:	0000000000000000
SigIgn:	0000000000000004
SigCgt:	0000000000000000
CapInh:	0000000000000000
CapPrm:	0000000000000000
CapEff:	0000000000000000
CapBnd:	000001ffffffffff
CapAmb:	0000000000000000
NoNewPrivs:	0
Seccomp:	0
Seccomp_filters:	0
Speculation_Store_Bypass:	thread vulnerable
SpeculationIndirectBranch:	conditional enabled
Cpus_allowed:	ffffffff,ffffffff,ffffffff,ffffffff,ffffffff,ffffffff,ffffffff
Cpus_allowed_list:	0-223
Mems_allowed:	00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000003
Mems_allowed_list:	0-1
voluntary_ctxt_switches:	5
nonvoluntary_ctxt_switches:	0
cat: /proc/6807/numa_maps: Permission denied
migrate_pages02.c:65: TINFO: Node id: 1, size: 117471789056, free: 106811031552
migrate_pages02.c:129: TFAIL: pid(6807) addr 0x7f1006150000 not on expected node: 0 , expected 1
migrate_pages02.c:55: TINFO: mem_stats pid: 6807, node: 1
Name:	migrate_pages02
Umask:	0000
State:	S (sleeping)
Tgid:	6807
Ngid:	0
Pid:	6807
PPid:	6801
TracerPid:	0
Uid:	65534	65534	65534	65534
Gid:	0	0	0	0
FDSize:	64
Groups:	 
NStgid:	6807
NSpid:	6807
NSpgid:	6801
NSsid:	2420
Kthread:	0
VmPeak:	    2904 kB
VmSize:	    2868 kB
VmLck:	       0 kB
VmPin:	       0 kB
VmHWM:	       0 kB
VmRSS:	       0 kB
RssAnon:	       0 kB
RssFile:	       0 kB
RssShmem:	       0 kB
VmData:	     348 kB
VmStk:	     136 kB
VmExe:	     132 kB
VmLib:	    1548 kB
VmPTE:	      48 kB
VmSwap:	       0 kB
HugetlbPages:	       0 kB
CoreDumping:	0
THP_enabled:	1
untag_mask:	0xffffffffffffffff
Threads:	1
SigQ:	0/444866
SigPnd:	0000000000000000
ShdPnd:	0000000000000000
SigBlk:	0000000000010000
SigIgn:	0000000000000006
SigCgt:	0000000000000000
CapInh:	0000000000000000
CapPrm:	0000000000000000
CapEff:	0000000000000000
CapBnd:	000001ffffffffff
CapAmb:	0000000000000000
NoNewPrivs:	0
Seccomp:	0
Seccomp_filters:	0
Speculation_Store_Bypass:	thread vulnerable
SpeculationIndirectBranch:	conditional enabled
Cpus_allowed:	ffffffff,ffffffff,ffffffff,ffffffff,ffffffff,ffffffff,ffffffff
Cpus_allowed_list:	0-223
Mems_allowed:	00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000003
Mems_allowed_list:	0-1
voluntary_ctxt_switches:	7
nonvoluntary_ctxt_switches:	0
cat: /proc/6807/numa_maps: Permission denied
migrate_pages02.c:65: TINFO: Node id: 1, size: 117471789056, free: 106811031552

Summary:
passed   13
failed   2
broken   0
skipped  0
warnings 0
incrementing stop
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=1 corefile=no
cutime=0 cstime=11
<<<test_end>>>
INFO: ltp-pan reported some tests FAIL
LTP Version: 20250530-108-g0e4be9201

       ###############################################################

            Done executing testcases.
            LTP Version:  20250530-108-g0e4be9201
       ###############################################################




The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250731/202507310843.52fb528f-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
