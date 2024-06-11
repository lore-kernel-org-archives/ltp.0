Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82EECC25B76
	for <ltp@archiver.kernel.org>; Tue, 11 Jun 2024 13:51:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F239B3D0B64
	for <ltp@archiver.kernel.org>; Tue, 11 Jun 2024 15:51:05 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A50F33C9430
 for <ltp@lists.linux.it>; Tue, 11 Jun 2024 15:50:49 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=192.198.163.15; helo=mgamail.intel.com;
 envelope-from=oliver.sang@intel.com; receiver=lists.linux.it)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 6B20B200748
 for <ltp@lists.linux.it>; Tue, 11 Jun 2024 15:50:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1718113848; x=1749649848;
 h=date:from:to:cc:subject:message-id:in-reply-to: mime-version;
 bh=rJhnh/RBeNw6Joppz7ThC6mDDDZ6iaKNhUKEORZd41g=;
 b=nHVxqBWwRAAMXYRaoMh9g41BqvsN2J78XqT4bfNIymtu7bTuV4AVBUy7
 h5vS5SO+4fvSAywXKq8qUFZBw4h0h8tLrNaccRiwF/xZd6AtPkZRPX1im
 m3f7YJDiYJ1dPycSSti6BaM024ZWWrWbfo6wFslK+laSz8hq/dDcqVIni
 L1z7tP319x1D4oNpZYad/gz7gPuVDF8gvYqeIOyOUp+6gq0UQT6OhC0BW
 UcOGEt+evH0tlgYsq94GfstXY20IoBQCuetFWKzmeA1OwIIvFSNCSoLlK
 9U9ZIFXAd5FXMShca+3ooRYlyG63ry648cI0uFTwHTMgdGq5sEZgz4zok w==;
X-CSE-ConnectionGUID: oKtmTfRSQgqskIf+610vlA==
X-CSE-MsgGUID: kT0eJdgNSzuSzhcgsV7B6g==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="14993716"
X-IronPort-AV: E=Sophos;i="6.08,230,1712646000"; d="scan'208";a="14993716"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jun 2024 06:50:42 -0700
X-CSE-ConnectionGUID: 1mN/Yp45TVyapzy/DBcTrw==
X-CSE-MsgGUID: vWJwa7kuRUutMDJp1q2yTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,230,1712646000"; d="scan'208";a="44568088"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 11 Jun 2024 06:50:42 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 11 Jun 2024 06:50:41 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 11 Jun 2024 06:50:41 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 11 Jun 2024 06:50:41 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 11 Jun 2024 06:50:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bfO0iLD4kE1JNUapAWtJq6Zanf4A4CEEVatzAmCXsuHLVCSLf1BVfUnIG3qfe0x7vWvkLOsPpPmj2pHAyEP17SKa8Dj61dJbBBaqB93pVH8+9C4iqYCZIOp+mi9KU782oQVCBJZa7Vl4th3b5j9Xblj4pdYl19j6cAV/0S7+h5tjDREGMPEX7OpglEf3DuGrgUFFuUr+5FZq47jJ5lu28vsC8EagWwtgx0oXG26M7CD3cM7Yq2DjQfrha0ilFU/nqqZ/hLi/UbJRINKEzCHQYQ+P6fYoWKr+8to7GHBAh0nIIdVtf+v3iPlKQSyaKrVJ+z1QttASREd0+CQFei0D1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vfun9WWeTjw0plRpG/7riLWzIPtXn+AT0rxVOD12geA=;
 b=mdfFDI84qskCvyJsGlh26XDnTwTiOfOzU2VADiB/bJHS9sqyqFobyohcwkZysTx/jY5/Tbj7XpYFr7Uxmflna+xpybLARUMHcR0aSfwwy9Nc9kk+ENSkedaNE8Q1YMQ6v5lj+kuCa3Rua51KG/ys8xB0CDuok31/Bz88sQ/VfU9aSvuAPBM7nP55QE0Eg/cu5BuSQCcAJUTfMIDZrt+uGOAr33MGwLgebWVaA6ScYcYK5ySue7+5krwnjkFIyB2ZRW3JWw+NG1y23Bf1sbh2IF0cyhs05sFI2Uwbc8/UYGcppfNfZ9QAaZk/J/VRMORmtofhQbVu3fkJbY3DVUGjYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DM6PR11MB4674.namprd11.prod.outlook.com (2603:10b6:5:2a0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Tue, 11 Jun
 2024 13:50:33 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%2]) with mapi id 15.20.7633.037; Tue, 11 Jun 2024
 13:50:33 +0000
Date: Tue, 11 Jun 2024 21:50:24 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Kundan Kumar <kundan.kumar@samsung.com>
Message-ID: <202406111633.69b1950e-lkp@intel.com>
Content-Disposition: inline
In-Reply-To: <20240605092455.20435-2-kundan.kumar@samsung.com>
X-ClientProxiedBy: TYAPR03CA0006.apcprd03.prod.outlook.com
 (2603:1096:404:14::18) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DM6PR11MB4674:EE_
X-MS-Office365-Filtering-Correlation-Id: 637d4935-4238-4378-0b76-08dc8a1d76f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005|7416005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fXTsQEk4L0Lsx1XJyZxqYACsQnf1ofQ5SNbfI4XxqbmJCYw6D2QuulhBfMDo?=
 =?us-ascii?Q?w0nswKXbSHREpliXn20hNxr9igjiYGwJSNQwQwySeSCyTOAp748hBih8nqvp?=
 =?us-ascii?Q?Vj+Ybjlxt2lS8bIbXNIOydKaUIL4M7rL7xy3yXKQqp1RPeNI8Uqux3yiUmAS?=
 =?us-ascii?Q?qt+YGFpR4of47UQ42T7EPcALTDrDHJdsqdqFucdoEsYMKKyP07XGA6MpnjeY?=
 =?us-ascii?Q?GosnnAkThwJ+RbE2CL2Z6Y5CDMsGAY80f8ji6bOmYZHvDOoMJHn4s2vGFuKy?=
 =?us-ascii?Q?DjOzR8qzrQ1mkt88UP75703r7LuoUGny/razagiBVMr95zqqXi+tQQwa9XmD?=
 =?us-ascii?Q?QA0ZagEIixNgGXb4oFW56zZHzKISBocPX+6WnPjZ2eoHPpfDT4Sb7mkIAXoD?=
 =?us-ascii?Q?Rt7rETVZup7a0W6uOGAfNAI6tV8w9C7NcuXNL4NlMsiQMnGJdvJ+Blb/83oS?=
 =?us-ascii?Q?YedpDoXt6tuNj1Aw7VP51Y/OXbx3GOfOmejL82OQ8I/Wzid6W7GOCUBx+rtO?=
 =?us-ascii?Q?HxVh+/xce8Av3ca2hmCxxuOiIkoodXWiCEn5s3TB8HLiqsECejadxtsRn2UK?=
 =?us-ascii?Q?Yj64vEeAW90QelNOv2I40ZdbpEFXJbJYYph+ioiRuhcExs5NeEuvSy+PoW1r?=
 =?us-ascii?Q?kpU1dQxgCx/Kb8ziPxd27QtwcQEGbVPvl11T8qJrB0AmjxPMu4vQTaTjHzT1?=
 =?us-ascii?Q?TXupw/w1b2JTHXkHNN8WC9JTcrpG5FnsspNO1gVFWNv9qnqlxb0cEwKmvWfn?=
 =?us-ascii?Q?LGbhY6bjFy7cjyI9itT4WnT4JTlPpntCYBsroulim+seTrUsj09EIWlS3sjX?=
 =?us-ascii?Q?UjmhkkyGsTLEW0RmJSYyfQGHExJNtXuq9vwTJvzHXi0wofl3AOod1wkYk4Qj?=
 =?us-ascii?Q?VF/8QssDmeP3DTmOqY1/9PoggrobdSdzM2kbVYlzfRl8FM1RBWL45GCt7viu?=
 =?us-ascii?Q?dsUpoCp9Zx4VdVE+wkVbr1/VTG7DjC+u+wOG/VbYwJqvH/UZvU5LuLwFpMYr?=
 =?us-ascii?Q?y87zzyEedb/7ftvF1Y1hF5BFh40ugSzL1DcvUeCWbribiL5vSx22ayDznt89?=
 =?us-ascii?Q?xkXiGRyp8sMPrtG7gsOsFd9YI8PtnJrSYNV+76A7ehNdYP0PQ78+vOn1vE15?=
 =?us-ascii?Q?S1vP3rCGZZV7d5+eibel7fvS7FC/zE2kyfu7ACKf0EukJQFNHtSXA3ZQmSBG?=
 =?us-ascii?Q?bDC+meAU04e5SH64jNsvAj9YEFXYpkhhttzE9s1sXoMAbET2Lb582059hIEZ?=
 =?us-ascii?Q?tsHRgM/2CoD64ydwPp29OM3lZFUTqT/mOgEqTGWidw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR11MB8603.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005)(7416005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0SqKrrRdEAwEvF4bwK4dWwRjVQ4OOlT0xHPeUjltScUZFg0rxBJUMuoAeius?=
 =?us-ascii?Q?cu7cELroCmJe9T0s9cYq5SB1sECXukn2Ga+P5l+DOorDYC8whuMcrIK1P6BE?=
 =?us-ascii?Q?ol2h/Dop5JLgeFaXyv9WfBl7ltmsnF6XzYtNnnGFlcMWhCmztq9RBkoO4+M7?=
 =?us-ascii?Q?ypkXKJml7GCE6z3ocunPQEn9LMuMAcwm8gHC8ucWV12DarqheuAGwmAOdF40?=
 =?us-ascii?Q?M/ALijXkUoesgcIN7052FOLH9B2fdwlMOjTMD1CmGY/JpVOfh5wyWGrIaXiB?=
 =?us-ascii?Q?66gkr1n6+C2eNsinpvAfN+m6Do+qDzaEaNLCe7B+Q1cGAURyWJ7IpSUh0CeI?=
 =?us-ascii?Q?5qWRaG2F5VkUCsIgaPSKApHQ075jR5NU27IPlH/2inrC8zTSpb71Uxy+xekw?=
 =?us-ascii?Q?bpcZ2AlbTKz57fq/etnadI8N2NVijgRtxrDuolaFI3I2hGRz1VYJtb1U/SXh?=
 =?us-ascii?Q?dT52j9AJevEjHr1T8VECHOE1Kfv6qaoD1ICtPxvP8Mg5VgvCo4S96TeTTFjP?=
 =?us-ascii?Q?UeNTsu+eQqmKBDsWKmI3WDtUobgu+fh03LRcvtsm3VVUy7nZ4PQRCVAi9rCV?=
 =?us-ascii?Q?u0vJGUElWbExhiDzsZAqmD9tEhvVx0Q8LWlzhKQfY0SEyl4d+I/g7d43P2Yv?=
 =?us-ascii?Q?UcdQC2re31esC3rs6Ex5AWFtk2k+vfP/+s9L7EjBKQi/BWNxNazuZX96oQZS?=
 =?us-ascii?Q?obMqfDpsfkTTTNTa4cpFtO3C3mjWgCWeAgc+/rObiFGq/Ivc+9mfmNzXnWwo?=
 =?us-ascii?Q?TaisYBfg2oC4O3wiWa4quj8JThSWpRDI9659agybx0Ra8GUTBFz8nuGQYzu8?=
 =?us-ascii?Q?SEetAVgZ1j+6LSmDcInUz8bkhzsIVs9mzNcZSOuiCDzJlITJX0nzTzUwNToV?=
 =?us-ascii?Q?0hYFoqo3C4BzpsGcCqyJqKWekJgazIJNGY3zC6oyEM3XWI4tJNMdhTbJiht0?=
 =?us-ascii?Q?xQ4MJFEOZUocaVLJgkZUpHgY4suWmOjP7VeOhzOIypueW4oGd/HPfc/EmcKu?=
 =?us-ascii?Q?qvhVn4U/sgDtjc6lYD9gUBYy4H3kZ0kGZ0J+MQdwDO0/IKr9/QMfBAL2pGsV?=
 =?us-ascii?Q?GhD5k4JGioY/UigfSxuuSCEDNkvFVL45s4Bg01rwaLvpBJ9vw8uLEwc9+QGl?=
 =?us-ascii?Q?fmYO34HJWhjyJdQClKxXY/LicC57tqRaO3wLeYkBYf4XHZaHye7dHa6bGYLd?=
 =?us-ascii?Q?6dGaT5N7Ht9AkNRVeOQL4zBlJWpLvXi80TvYgEMs6yTWWIkLFkKo+wvj2cSk?=
 =?us-ascii?Q?lKP3SmwFFOWDPDiLFqwmZmgTJp+Jyr3rY0mHytjhWSfBUjKR9unwa7xYyc/J?=
 =?us-ascii?Q?iIjlhCfsWJocaKCFcrrPzGmIp097emN1gjIKiugPX/OmHYosbzDb1EDhIJw+?=
 =?us-ascii?Q?meoyYvvuZMTRsmtjy+c/c8VgIKVwblS2GVQSjNKf6Zmx6GnLG5/XeifLb6gn?=
 =?us-ascii?Q?0awCD7usIIeNPY9JGVpn5gASpxQdSD3jmRAuKIomXak6WN2xaAf0kBJ7y2t+?=
 =?us-ascii?Q?/Knj3JmOHpLrOB51P5xiLDkr7nGCdtTf9AySOhkN20VkOkU5NBwe7sD7ZaVJ?=
 =?us-ascii?Q?QyQF0xmc1Lv6h8UlTuVqEKH1sMCe9u+lC2iU4r1izUm1s3pNtohduDeOjNtv?=
 =?us-ascii?Q?7Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 637d4935-4238-4378-0b76-08dc8a1d76f2
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 13:50:33.5942 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MwylruIALKlHsIcYnMJOvMI+dPzhURwzN0+5g43YHXNkBHDuT7UNd4x01kqnda76BGacLF7gqlPaACbfk0WEjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4674
X-OriginatorOrg: intel.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 1/2] block: add folio awareness instead of
 looping through pages
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
Cc: axboe@kernel.dk, lkp@intel.com, joshi.k@samsung.com, gost.dev@samsung.com,
 anuj20.g@samsung.com, willy@infradead.org, nj.shetty@samsung.com,
 linux-block@vger.kernel.org, kbusch@kernel.org, mcgrof@kernel.org,
 oliver.sang@intel.com, oe-lkp@lists.linux.dev,
 Kundan Kumar <kundan.kumar@samsung.com>, hch@lst.de, ltp@lists.linux.it,
 c.gameti@samsung.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>



Hello,

kernel test robot noticed "WARNING:at_lib/iov_iter.c:#iov_iter_revert" on:

commit: d245fbe9b4ca466a625094e538ce363e4dbfde94 ("[PATCH v4 1/2] block: add folio awareness instead of looping through pages")
url: https://github.com/intel-lab-lkp/linux/commits/Kundan-Kumar/block-add-folio-awareness-instead-of-looping-through-pages/20240605-182718
base: https://git.kernel.org/cgit/linux/kernel/git/axboe/linux-block.git for-next
patch link: https://lore.kernel.org/all/20240605092455.20435-2-kundan.kumar@samsung.com/
patch subject: [PATCH v4 1/2] block: add folio awareness instead of looping through pages

in testcase: ltp
version: ltp-x86_64-14c1f76-1_20240608
with following parameters:

	test: lvm.local-00



compiler: gcc-13
test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-7700 CPU @ 3.60GHz (Kaby Lake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202406111633.69b1950e-lkp@intel.com



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240611/202406111633.69b1950e-lkp@intel.com


[  130.031598][ T3261] ------------[ cut here ]------------
[  130.037219][ T3261] WARNING: CPU: 3 PID: 3261 at lib/iov_iter.c:552 iov_iter_revert+0x1e7/0x250
[  130.045995][ T3261] Modules linked in: vfat fat xfs ext2 btrfs blake2b_generic xor zstd_compress raid6_pq libcrc32c intel_rapl_msr intel_rapl_common x86_pkg_temp_thermal sd_mod intel_powerclamp t10_pi coretemp crc64_rocksoft_generic crc64_rocksoft crc64 kvm_intel sg ipmi_devintf ipmi_msghandler i915 kvm crct10dif_pclmul drm_buddy crc32_pclmul intel_gtt crc32c_intel ghash_clmulni_intel drm_display_helper sha512_ssse3 mei_wdt ttm rapl drm_kms_helper wmi_bmof ahci mei_me libahci video intel_cstate i2c_designware_platform i2c_designware_core intel_uncore idma64 i2c_i801 libata mei i2c_smbus pinctrl_sunrisepoint wmi acpi_pad binfmt_misc fuse loop drm dm_mod ip_tables
[  130.104614][ T3261] CPU: 3 PID: 3261 Comm: pvcreate Tainted: G S                 6.10.0-rc1-00017-gd245fbe9b4ca #1
[  130.114995][ T3261] Hardware name: Dell Inc. OptiPlex 7050/062KRH, BIOS 1.2.0 12/22/2016
[  130.123127][ T3261] RIP: 0010:iov_iter_revert+0x1e7/0x250
[  130.128576][ T3261] Code: 48 89 f8 48 c1 e8 03 42 0f b6 04 30 84 c0 74 04 3c 03 7e 31 8b 45 08 49 83 c4 01 4d 89 65 20 48 39 d8 72 d1 49 89 6d 10 eb 89 <0f> 0b eb 8c 4c 89 ef e8 ed 5b 6a ff e9 74 fe ff ff e8 73 5c 6a ff
[  130.148044][ T3261] RSP: 0018:ffffc90000f4f8e8 EFLAGS: 00010286
[  130.154025][ T3261] RAX: 0000000000000000 RBX: fffffffffffff200 RCX: 1ffff1103df41cfd
[  130.161898][ T3261] RDX: 1ffff1103df41d04 RSI: fffffffffffff200 RDI: ffffc90000f4fbf0
[  130.169767][ T3261] RBP: 0000000000000002 R08: 0000000000099000 R09: 0000000000001200
[  130.177636][ T3261] R10: 0000000000000002 R11: ffffea000f6a0000 R12: dffffc0000000000
[  130.185502][ T3261] R13: ffff8881efa0e7c0 R14: ffffc90000f4fbf0 R15: fffffffffffff200
[  130.193371][ T3261] FS:  00007fc2df84fd40(0000) GS:ffff88876c180000(0000) knlGS:0000000000000000
[  130.202190][ T3261] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  130.208672][ T3261] CR2: 000055bf19c62500 CR3: 0000000807f5c001 CR4: 00000000003706f0
[  130.216537][ T3261] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  130.224413][ T3261] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  130.232292][ T3261] Call Trace:
[  130.235486][ T3261]  <TASK>
[  130.238335][ T3261]  ? __warn+0xcc/0x260
[  130.242311][ T3261]  ? iov_iter_revert+0x1e7/0x250
[  130.247138][ T3261]  ? report_bug+0x261/0x2c0
[  130.251500][ T3261]  ? handle_bug+0x6d/0x90
[  130.255683][ T3261]  ? exc_invalid_op+0x17/0x40
[  130.260210][ T3261]  ? asm_exc_invalid_op+0x1a/0x20
[  130.265085][ T3261]  ? iov_iter_revert+0x1e7/0x250
[  130.269887][ T3261]  __bio_iov_iter_get_pages+0x868/0xcb0
[  130.275282][ T3261]  ? bio_associate_blkg_from_css+0x2f5/0xbb0
[  130.281111][ T3261]  ? __pfx___bio_iov_iter_get_pages+0x10/0x10
[  130.287021][ T3261]  ? bio_init+0x34a/0x5c0
[  130.291199][ T3261]  ? bio_alloc_bioset+0x28f/0x950
[  130.296073][ T3261]  bio_iov_iter_get_pages+0xb6/0x470
[  130.301205][ T3261]  __blkdev_direct_IO_async+0x3be/0x7f0
[  130.306597][ T3261]  ? blkdev_direct_IO+0x1d7/0x310
[  130.311467][ T3261]  blkdev_write_iter+0x5cd/0xac0
[  130.316254][ T3261]  aio_write+0x344/0x730
[  130.320346][ T3261]  ? __pfx_aio_write+0x10/0x10
[  130.324961][ T3261]  ? _raw_spin_lock_irqsave+0x8b/0xf0
[  130.330182][ T3261]  ? io_submit_one+0x213/0x9a0
[  130.334794][ T3261]  io_submit_one+0x213/0x9a0
[  130.339231][ T3261]  ? __pfx_io_submit_one+0x10/0x10
[  130.344190][ T3261]  ? __pfx___might_resched+0x10/0x10
[  130.349319][ T3261]  __x64_sys_io_submit+0x167/0x380
[  130.354279][ T3261]  ? __pfx___x64_sys_io_submit+0x10/0x10
[  130.359762][ T3261]  ? fpregs_restore_userregs+0xe3/0x1f0
[  130.365153][ T3261]  do_syscall_64+0x5f/0x170
[  130.369506][ T3261]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  130.375243][ T3261] RIP: 0033:0x7fc2dfd41719
[  130.379508][ T3261] Code: 08 89 e8 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d b7 06 0d 00 f7 d8 64 89 01 48
[  130.398931][ T3261] RSP: 002b:00007ffc819ab548 EFLAGS: 00000246 ORIG_RAX: 00000000000000d1
[  130.407175][ T3261] RAX: ffffffffffffffda RBX: 00007fc2df84fb10 RCX: 00007fc2dfd41719
[  130.414988][ T3261] RDX: 00007ffc819ab5f0 RSI: 0000000000000001 RDI: 00007fc2e00cf000
[  130.422803][ T3261] RBP: 00007fc2e00cf000 R08: 00007ffc819ab490 R09: 0000000000000008
[  130.430616][ T3261] R10: 000055bf19955608 R11: 0000000000000246 R12: 0000000000000001
[  130.438425][ T3261] R13: 0000000000000002 R14: 00007ffc819ab5f0 R15: 00007fc2e010e020
[  130.446238][ T3261]  </TASK>
[  130.449114][ T3261] ---[ end trace 0000000000000000 ]---
[  130.455322][ T3261] ------------[ cut here ]------------
[  130.460954][ T3261] WARNING: CPU: 7 PID: 3261 at lib/iov_iter.c:552 iov_iter_revert+0x1e7/0x250

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
