Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34186C04FFE
	for <ltp@archiver.kernel.org>; Sat, 11 May 2024 08:51:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 57DBC3CE71B
	for <ltp@archiver.kernel.org>; Sat, 11 May 2024 10:51:52 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 469703CE550
 for <ltp@lists.linux.it>; Sat, 11 May 2024 10:51:34 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=192.198.163.7; helo=mgamail.intel.com;
 envelope-from=yujie.liu@intel.com; receiver=lists.linux.it)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 39E671A01233
 for <ltp@lists.linux.it>; Sat, 11 May 2024 10:51:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715417494; x=1746953494;
 h=date:from:to:cc:subject:message-id:mime-version;
 bh=PAzUnIN+fGxtnnpHUyacJNqekU48uMOsy6iJE19AlN4=;
 b=lx7P8WySZOZZNI2+XUHFFKZFIlmC6A4R+wr1K85tKS6b5Bdh6RFGjwGL
 D+xKMZ3UckwZcm/spKmF1qtOAvG7Fk6rmjXTB00ilZ5MP/Yiv0oORFErP
 c19KnL0xtc7rERqfNn0Ouzr3aDkOx7jIOpJrGZk3/06sKfxPFn9HgBoJu
 6ZLHjEVRo9ClR0o15XpdEuyIdVwRQBVelTKxnaxAz5t0zQTtDnmpKAJnd
 O8HtboAGXxmPbWC71xSq6sgTupEpclhzyDh4F1fplASxUfllebBPRrWje
 o3EEoAoK2qfOG0P0b/S1AGle4azsLwCzEtBaRWUKVBKZSXs8NLo7UWpMQ A==;
X-CSE-ConnectionGUID: NkyUBDpAQ4WK7jhGQ4wg9A==
X-CSE-MsgGUID: ztOLHnfGSCWhaU8mIfazlQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11069"; a="36794136"
X-IronPort-AV: E=Sophos;i="6.08,153,1712646000"; d="scan'208";a="36794136"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 May 2024 01:51:28 -0700
X-CSE-ConnectionGUID: oJA9TxaGQ+ixfywod25pQg==
X-CSE-MsgGUID: QwCyPwadQ1+K4ICY4u1dew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,153,1712646000"; d="scan'208";a="29891919"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 11 May 2024 01:51:28 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 11 May 2024 01:51:27 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 11 May 2024 01:51:27 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sat, 11 May 2024 01:51:27 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sat, 11 May 2024 01:51:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oBRvIYtL9WW4CTWNcVD4Xl3QtBuqOaQ3KMis2dcxQsZjh+qItQGC7HivmwNlm5vzA/0n7frOpplPSfirVU+0gVMWhIkkegEvOjY+eMevJ8Z6vC5smLAB/ymFPYulPx+6t4zJ9RolNtrdbjTbRR9nqRIsZTtRHF4IL+fWM0XDy1JW6B4Qy749Z0LrFA/L2p72h4zR6V5zY0aJ9unl9JBWjcbMiT/IhOk5zu+I2/3MotQkxEKeSJaVvsMTNVjxnHYTcI6u+CY+idloXz+sgluVxK9XUW4LqJLJhBryQKkY4Om1jQDxLk8ukL2OVgDHnTKWpJmdl+7TynHoz2CXvcWW0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3xwezEJAXHKOQuFm9FAf6Vfk8FSC3HRp2HbrbFOVaog=;
 b=CEGgwQTZY0wyJDXC9/f9Fsa5iCYK9mNSuC2KovOr5A6zC9FGGEJyVMujfOPTID99GmljBFwO4VDoHtWHxrW6bz4HuAQ4xwbvsqX9Uriife5OJyLRctxgUDjpyQ+SrvLZqsJEvmoRAJvJTucOYhWLwAVfMQaV5WX+qNdKoX3vZgartVZyefsS9v4dDoowgtgrUdIEov5ySblTsTS5zNyU7leMAXMEfZzofLu3UaHSJGNT4ufx2DL6AmBuf/nAzpc8psPadKqWpRQ7tPhjFq6oOS/7F8jsYhIVN2g/9wJfWNdy3kPMAp+Aur/jG+9+vAQR0efoh81nW47K3AzSXGrUuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8393.namprd11.prod.outlook.com (2603:10b6:806:373::21)
 by SA2PR11MB5116.namprd11.prod.outlook.com (2603:10b6:806:fa::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.47; Sat, 11 May
 2024 08:51:24 +0000
Received: from SA1PR11MB8393.namprd11.prod.outlook.com
 ([fe80::1835:328e:6bb5:3a45]) by SA1PR11MB8393.namprd11.prod.outlook.com
 ([fe80::1835:328e:6bb5:3a45%5]) with mapi id 15.20.7544.049; Sat, 11 May 2024
 08:51:24 +0000
Date: Sat, 11 May 2024 16:51:21 +0800
From: kernel test robot <yujie.liu@intel.com>
To: Luis Chamberlain <mcgrof@kernel.org>
Message-ID: <202405111644.40d50350-lkp@intel.com>
Content-Disposition: inline
X-ClientProxiedBy: SG2PR02CA0013.apcprd02.prod.outlook.com
 (2603:1096:3:17::25) To SA1PR11MB8393.namprd11.prod.outlook.com
 (2603:10b6:806:373::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8393:EE_|SA2PR11MB5116:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d721a12-68ba-41fe-ad8a-08dc719789b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TqgmLEbBbt0F19Fol/FLy8GUs0rgfBZYjQOi7Nb7LvHZqPHEVTYbsnaIiZuU?=
 =?us-ascii?Q?a0tvmUH7Eznph0aob499RQ7kWdrrKyTR7f/AQo7PIodPTHY5KkRsu6GNKfkT?=
 =?us-ascii?Q?rH+qv9u9yMZdw2cxOaz2ucsSG+6IaJN02w3ntbec+dYOXf7oyCzKNUBnuJ4U?=
 =?us-ascii?Q?+rTi+/djGRqe3NRKlj3/oGlR+57W3SqBgDWDw6am6P6gsR5ddX7hDQptBPZG?=
 =?us-ascii?Q?QbH/kg7K7Ynljrd6OzY67hf3NKh9iwX3sEzTNyAErNUn4udruzzphohNTYBN?=
 =?us-ascii?Q?qxotkWz9jBxuIucWClG+riLiuzqK43WOIwRlffVKv9Jpq1zbFNGXGOkzyHit?=
 =?us-ascii?Q?havhqzswBqsSK+VvJlo3dAKhHfu+DFf3QWxK+RwpGmsmQa8Zeur8VR01inWQ?=
 =?us-ascii?Q?wVlFXRpArONYEdNbjsgjQbNgoDtB8hISs2wLH3yv3t1Ljl97//HF1EFaq4db?=
 =?us-ascii?Q?6JV+oG/Bo4aD7aNh5z4qineMo++QbWiNMdjVYjWKSm6ZivH9slHpGKhNQcKy?=
 =?us-ascii?Q?1+KntzK+lySzGGuNXHyrU4jHKikiVIYpKwsLRyK4amE7yEEFDjSPvQdeX1on?=
 =?us-ascii?Q?2co/+BIBH7PGvcT5maBA6BA6Knn5azSzFznKWv79dZzJaLM+0c8tDjHkG/PW?=
 =?us-ascii?Q?vZ62/9oZ8n3Ia8XKr6ADuhSo/cwnxlRFtNFqTFwV3E7zoJCTu+0MMNlmDiXF?=
 =?us-ascii?Q?fCj5KN1nhmemZkQa/VhoSDIJh32EUUx6dWIbbqjc2pUorZaH362V4IZqc4Zj?=
 =?us-ascii?Q?NTHY4LKseyM4zRm6PLgdAegO7OEZWSlM0+PoHLBaiShf3MYGARIIT3PB26Dj?=
 =?us-ascii?Q?7kif+5XrN5+0oNudgIUzBQz296f2y70CRcd3PFZcGPjm9Ru2dodYkGuuxpWa?=
 =?us-ascii?Q?wBdyEBkP9NO9ll2cOb4BHy92Kixx41JLtlQZRXtmyT1txA15BO7vIi/79JC3?=
 =?us-ascii?Q?TLnF7QRVBF8KKCJKaBMSFTTLF2oQQOdMc6gQDST5IF98ptACZcfFR3lrD7jh?=
 =?us-ascii?Q?cY+OYCF/0cYBIUA6By5cxK5gEPQdlwZ44fLVoWV67bqGiE2u7YtWo3tjktEt?=
 =?us-ascii?Q?fV62g9f8gJMyy+8tJ8NYGJAFom2qp3piMVx3cjU7b0kDt34dWgA6KS1bxHpY?=
 =?us-ascii?Q?yupHbsODDeEQ5xAtRvYF8XX1kycchYeJn9xei5Qn0wv+8bdPa8cF2Fwdp3WI?=
 =?us-ascii?Q?eGyS83D16blq/kgKp0/4jNQDS2ETIytd9gRfDp+4NSLHkD/7dIq/uCjHFP4?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR11MB8393.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OMOBJHvXZKLXAqlXqWIgmpxnoWwgWGyYVybc5ZJr3uzqLKv2gNGKkkstrn4R?=
 =?us-ascii?Q?e+QpHUvjpCBF9lk6C7PaND0WXNVCd5oirBq91dHbZ7Pt/FqggYrZktMyGWgr?=
 =?us-ascii?Q?5inJnXQZZhy2jWVHDrwfKFjXM9SnS/X4UE83G0ELtEnDO4MLr3bNwwsooV5h?=
 =?us-ascii?Q?Mq44N/uCgDNLJc1yLRTfDOIDeKO82C42NQqth9HVH8v9T4JNP8UFmqv5v+1m?=
 =?us-ascii?Q?nvhAIu6EYXBunp3HgY0/KOlrH5JiuZkJ86/+IqxiwU1Db8zzcaHKw+C8nA4I?=
 =?us-ascii?Q?35mQBAPIaJSazsgRaZV7UvQjEYcAIJZrNC18xlz3Il3E9uViOU9kjuavP3XR?=
 =?us-ascii?Q?mtmliQqN0oRLWNih9ZByHoyiem7v9zLK3RW6Q922GpNDXKvH25pdjedTpPQm?=
 =?us-ascii?Q?n19hb3KqWzHioBylWEFdhyiTQJ+4i3dW0KCCQQByVnN8/HoklO3N3DM9QcyQ?=
 =?us-ascii?Q?4gU0OgcLLAhHaknqnzBq99azOscCr4zoyGumkCIocLYcqKaeOB7Wg4+HBzRp?=
 =?us-ascii?Q?kFKz0KZx5dJJTdkWlEmVSREVavhFmYoXVQiLL+G9BhbL61uQIr6Q5yiEFB30?=
 =?us-ascii?Q?kWV9uwU8pQIwQAKArDfArApupxwOYHlDIY01oy5VVaMJOkruPyO3ijpuJVFd?=
 =?us-ascii?Q?4djsCQ0ARbTbSb79CgP+W2dF4HEMfrQ0JPhzZ+KU6L2lWDEPROxwKUFodrsj?=
 =?us-ascii?Q?F65eGR9vr2c2VmgGPY7HqmL3KZ3TYqM2YdyO016HHg1erOf8D0F7d06fkmVS?=
 =?us-ascii?Q?Rqzq6CWxnm5m3idYnGfpZGoXQGTxHymzoeJtmXKsStf9ANushS2PiNe+P4OB?=
 =?us-ascii?Q?KqJj6ZtzOUjOY8DCxDD4WSV6CW+uRjUmekv5GhHajZ7i3fz11GVfQWpoCsla?=
 =?us-ascii?Q?SqsiviLF35i2T7Nc07cqyY7RMKjR7WwWAjI27EPf4s3KCQWeFZeaCLPI0bTy?=
 =?us-ascii?Q?WjJNpHNyYZmDMLXwGuBeJ1FPrLD9ek9vZtgF1N/UUtoPAzSaamPRKg2NE5BW?=
 =?us-ascii?Q?qO6AthrPSFO+3JeVH3bE4SAMOd8feGmQTPAPU483LH0p0ejTuOxRsgB47+zz?=
 =?us-ascii?Q?4E59A+cV7qDJ/hMpMEOQXpGcy2H9sySucLsSaD9cVNnggJgjKCXaXC/oXZGU?=
 =?us-ascii?Q?QCD6FqR2P3LySYKotLQVtLepTwiTFxat7s2sWnw/tRKnnsR9F/2N41uE8rFf?=
 =?us-ascii?Q?9S0P4BoQ8bQ/2mPGN5mRMpdl3tAsAbVbGkBUBdZI8BWkj0vZDx/rpRNqR2WX?=
 =?us-ascii?Q?rnHJTjD3ryOAB45w4S9Gxji5V+nlQEfTIsvLC43vdyXhZX9uupCbBWFj+DpY?=
 =?us-ascii?Q?FcNTBiC4U0xWFu7NqJTue77tnon2NZlP1982klP7iNv9NK7PBbUHiFQkFsbQ?=
 =?us-ascii?Q?ezkQC8R9LexkNrrbBf60Q6ISBG4s/6GnHvqL7B+Mxa8AfrIgXsz2IjqS7uLC?=
 =?us-ascii?Q?b6lK1QIa+DeFsfIGfmOADoZpTnxKoidR3X5LJwsahJGYXN6MWK3DAyNCtZYx?=
 =?us-ascii?Q?4XhxJfMjWVuPwyag61gCkBSQTMS6Akb4ue/jfi8hxEE3P+lLEZCEyzY7jfru?=
 =?us-ascii?Q?eJxHxiRt1/f/fsAFrJJPvTnSFyyOrV4I7MCIyBsO?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d721a12-68ba-41fe-ad8a-08dc719789b0
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8393.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2024 08:51:24.5289 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yjDPxQNWE+LE5Kxv+KSi5pYkalZwQofH11rApXUkoOuiqPi/2BvLWmM+VA6GIMiLZre+Oty42oCl6WGqFS7xpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5116
X-OriginatorOrg: intel.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [mcgrof:20240502-large-block-minorder-ignore-debugfs] [mm]
 98bf6a5549: dmesg.BUG:Bad_rss-counter_state_mm:#type:MM_FILEPAGES_val
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
Cc: Pankaj Raghav <p.raghav@samsung.com>, lkp@intel.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, oe-lkp@lists.linux.dev,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

kernel test robot noticed "dmesg.BUG:Bad_rss-counter_state_mm:#type:MM_FILEPAGES_val" on:

commit: 98bf6a554986e068b9c94dfe8d8004cbe22cee96 ("mm: split a folio in minimum folio order chunks")
https://git.kernel.org/cgit/linux/kernel/git/mcgrof/linux.git 20240502-large-block-minorder-ignore-debugfs

in testcase: ltp
version: ltp-x86_64-14c1f76-1_20240508
with following parameters:

	disk: 1HDD
	test: mm-00

compiler: gcc-13
test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-7700 CPU @ 3.60GHz (Kaby Lake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <yujie.liu@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202405111644.40d50350-lkp@intel.com


[  612.787878][  T361] <<<test_start>>>
[  612.794124][  T361] tag=ksm01 stime=1715338753
[  612.801061][  T361] cmdline="ksm01"
[  612.806948][  T361] contacts=""
[  612.812510][  T361] analysis=exit
[  612.818328][  T361] <<<test_output>>>
[  612.825279][  T361] tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
[  612.836222][  T361] tst_test.c:1730: TINFO: LTP version: 20240129-247-g6052dca5d
...
[  617.229304][  T361] mem.c:320: TFAIL: child 2 has c at 2,1,672162.
[  617.239393][  T361] mem.c:320: TFAIL: child 2 has c at 2,1,672163.
[  617.245639][ T3313] BUG: Bad rss-counter state mm:000000005a9ef575 type:MM_FILEPAGES val:-1
[  617.256353][ T3313] BUG: Bad rss-counter state mm:000000005a9ef575 type:MM_ANONPAGES val:1
[  617.262328][  T360] BUG: Bad rss-counter state mm:0000000093b60f35 type:MM_FILEPAGES val:-1
[  617.262332][  T360] BUG: Bad rss-counter state mm:0000000093b60f35 type:MM_ANONPAGES val:1


[  607.433779][  T361] <<<test_start>>>
[  607.440371][  T361] tag=mmap10_4 stime=1715338751
[  607.447741][  T361] cmdline="mmap10 -a -s -i 60"
[  607.454734][  T361] contacts=""
[  607.460279][  T361] analysis=exit
[  607.466110][  T361] <<<test_output>>>
...
[  610.420345][  T361] mmap10      0  TINFO  :  start tests.
[  610.428698][  T361] mmap10      0  TINFO  :  add to KSM regions.
[  610.437665][  T361] mmap10      0  TINFO  :  use anonymous pages.
[  610.446601][  T361] mmap10      0  TINFO  :  start tests.
[  610.452887][   T79] ------------[ cut here ]------------
[  610.454940][  T361] mmap10      0  TINFO  :  add to KSM regions.
[ 610.459504][ T79] WARNING: CPU: 7 PID: 79 at mm/gup.c:229 try_grab_page (mm/gup.c:229 (discriminator 1))
[  610.473307][   T79] Modules linked in: btrfs blake2b_generic xor intel_rapl_msr intel_rapl_common zstd_compress x86_pkg_temp_thermal intel_powerclamp coretemp raid6_pq kvm_intel libcrc32c i915 kvm sd_mod t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 crct10dif_pclmul drm_buddy crc32_pclmul intel_gtt crc32c_intel sg ghash_clmulni_intel drm_display_helper sha512_ssse3 ttm rapl drm_kms_helper ahci wmi_bmof mei_wdt libahci video intel_cstate ipmi_devintf ipmi_msghandler intel_uncore i2c_designware_platform i2c_i801 mei_me libata idma64 i2c_designware_core i2c_smbus mei wmi pinctrl_sunrisepoint acpi_pad binfmt_misc fuse loop drm dm_mod ip_tables
[  610.532426][   T79] CPU: 7 PID: 79 Comm: ksmd Tainted: G S                 6.9.0-rc6-00008-g98bf6a554986 #1
[  610.532430][   T79] Hardware name: Dell Inc. OptiPlex 7050/062KRH, BIOS 1.2.0 12/22/2016
[ 610.548196][ T79] RIP: 0010:try_grab_page (mm/gup.c:229 (discriminator 1))
[ 610.548201][ T79] Code: 40 f6 c5 01 0f 84 1a fe ff ff 48 83 ed 01 e9 14 fe ff ff be 04 00 00 00 4c 89 e7 e8 ad 01 14 00 f0 41 ff 04 24 e9 67 ff ff ff <0f> 0b b8 f4 ff ff ff 5b 5d 41 5c 41 5d c3 cc cc cc cc e8 8c 01 14
All code
========
   0:   40 f6 c5 01             test   $0x1,%bpl
   4:   0f 84 1a fe ff ff       je     0xfffffffffffffe24
   a:   48 83 ed 01             sub    $0x1,%rbp
   e:   e9 14 fe ff ff          jmp    0xfffffffffffffe27
  13:   be 04 00 00 00          mov    $0x4,%esi
  18:   4c 89 e7                mov    %r12,%rdi
  1b:   e8 ad 01 14 00          call   0x1401cd
  20:   f0 41 ff 04 24          lock incl (%r12)
  25:   e9 67 ff ff ff          jmp    0xffffffffffffff91
  2a:*  0f 0b                   ud2             <-- trapping instruction
  2c:   b8 f4 ff ff ff          mov    $0xfffffff4,%eax
  31:   5b                      pop    %rbx
  32:   5d                      pop    %rbp
  33:   41 5c                   pop    %r12
  35:   41 5d                   pop    %r13
  37:   c3                      ret
  38:   cc                      int3
  39:   cc                      int3
  3a:   cc                      int3
  3b:   cc                      int3
  3c:   e8                      .byte 0xe8
  3d:   8c 01                   mov    %es,(%rcx)
  3f:   14                      .byte 0x14

Code starting with the faulting instruction
===========================================
   0:   0f 0b                   ud2
   2:   b8 f4 ff ff ff          mov    $0xfffffff4,%eax
   7:   5b                      pop    %rbx
   8:   5d                      pop    %rbp
   9:   41 5c                   pop    %r12
   b:   41 5d                   pop    %r13
   d:   c3                      ret
   e:   cc                      int3
   f:   cc                      int3
  10:   cc                      int3
  11:   cc                      int3
  12:   e8                      .byte 0xe8
  13:   8c 01                   mov    %es,(%rcx)
  15:   14                      .byte 0x14
[  610.558435][   T79] RSP: 0018:ffffc900005f7a98 EFLAGS: 00010246
[  610.558438][   T79] RAX: 0000000000000000 RBX: ffffea0005300740 RCX: ffffffff8193b8eb
[  610.558440][   T79] RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffffea0005300774
[  610.583027][   T79] RBP: ffffea0005300740 R08: 0000000000000000 R09: fffff94000a600ee
[  610.583029][   T79] R10: ffffea0005300777 R11: ffffc900005f7d60 R12: ffffea0005300774
[  610.583046][   T79] R13: 0000000000000002 R14: 0000000000000002 R15: ffffea0005300740
[  610.583048][   T79] FS:  0000000000000000(0000) GS:ffff888769b80000(0000) knlGS:0000000000000000
[  610.583049][   T79] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  610.583051][   T79] CR2: 000055e715c96510 CR3: 000000081a85a001 CR4: 00000000003706f0
[  610.594321][   T79] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  610.594323][   T79] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  610.594324][   T79] Call Trace:
[  610.594326][   T79]  <TASK>
[ 610.609918][ T79] ? __warn (kernel/panic.c:694)
[ 610.609922][ T79] ? try_grab_page (mm/gup.c:229 (discriminator 1))
[ 610.619897][ T79] ? report_bug (lib/bug.c:180 lib/bug.c:219)
[ 610.619901][ T79] ? handle_bug (arch/x86/kernel/traps.c:239 (discriminator 1))
[ 610.635497][ T79] ? exc_invalid_op (arch/x86/kernel/traps.c:260 (discriminator 1))
[ 610.635500][ T79] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:621)
[ 610.635504][ T79] ? try_grab_page (arch/x86/include/asm/atomic.h:23 include/linux/atomic/atomic-arch-fallback.h:457 include/linux/atomic/atomic-instrumented.h:33 include/linux/page_ref.h:67 include/linux/page_ref.h:89 mm/gup.c:229)
[ 610.650665][ T79] ? try_grab_page (mm/gup.c:229 (discriminator 1))
[ 610.650669][ T79] ? try_grab_page (arch/x86/include/asm/atomic.h:23 include/linux/atomic/atomic-arch-fallback.h:457 include/linux/atomic/atomic-instrumented.h:33 include/linux/page_ref.h:67 include/linux/page_ref.h:89 mm/gup.c:229)
[ 610.664447][ T79] follow_page_pte (mm/gup.c:652 (discriminator 1))
[ 610.664451][ T79] ? __pfx_follow_page_pte (mm/gup.c:582)
[ 610.680047][ T79] ? replace_page (include/linux/mmu_notifier.h:486 (discriminator 1) mm/ksm.c:1461 (discriminator 1))
[ 610.680050][ T79] follow_pmd_mask+0x1cb/0xa20
[ 610.685963][ T79] ? __pfx_follow_pmd_mask+0x10/0x10
[ 610.685967][ T79] ? __pfx___might_resched (kernel/sched/core.c:10152)
[ 610.692052][ T79] follow_page (mm/gup.c:854)
[ 610.692055][ T79] ? __pfx_follow_page (mm/gup.c:839)
[ 610.692058][ T79] scan_get_next_rmap_item (mm/ksm.c:2651)
[ 610.702738][ T79] ? __pfx_scan_get_next_rmap_item (mm/ksm.c:2563)
[ 610.702742][ T79] ? __pfx___might_resched (kernel/sched/core.c:10152)
[ 610.702744][ T79] ksm_scan_thread (mm/ksm.c:2754 mm/ksm.c:2780)
[  610.707751][  T361] mmap10      0  TINFO  :  start tests.
[ 610.711264][ T79] ? __pfx_ksm_scan_thread (mm/ksm.c:2770)
[ 610.711266][ T79] ? _raw_spin_lock_irqsave (arch/x86/include/asm/atomic.h:115 (discriminator 4) include/linux/atomic/atomic-arch-fallback.h:2170 (discriminator 4) include/linux/atomic/atomic-instrumented.h:1302 (discriminator 4) include/asm-generic/qspinlock.h:111 (discriminator 4) include/linux/spinlock.h:187 (discriminator 4) include/linux/spinlock_api_smp.h:111 (discriminator 4) kernel/locking/spinlock.c:162 (discriminator 4))
[ 610.711270][ T79] ? __pfx__raw_spin_lock_irqsave (kernel/locking/spinlock.c:161)
[ 610.717969][ T79] ? __pfx_autoremove_wake_function (kernel/sched/wait.c:383)
[ 610.717972][ T79] ? __kthread_parkme (arch/x86/include/asm/bitops.h:206 (discriminator 1) arch/x86/include/asm/bitops.h:238 (discriminator 1) include/asm-generic/bitops/instrumented-non-atomic.h:142 (discriminator 1) kernel/kthread.c:280 (discriminator 1))
[ 610.727352][ T79] ? __pfx_ksm_scan_thread (mm/ksm.c:2770)
[ 610.727354][ T79] kthread (kernel/kthread.c:388)
[ 610.727357][ T79] ? __pfx_kthread (kernel/kthread.c:341)
[ 610.737340][ T79] ret_from_fork (arch/x86/kernel/process.c:153)
[ 610.744033][ T79] ? __pfx_kthread (kernel/kthread.c:341)
[ 610.753753][ T79] ret_from_fork_asm (arch/x86/entry/entry_64.S:257)
[  610.764252][   T79]  </TASK>
[  610.771633][   T79] ---[ end trace 0000000000000000 ]---


The kernel config is available at:
https://download.01.org/0day-ci/archive/20240511/202405111644.40d50350-lkp@intel.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
