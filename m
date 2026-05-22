Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4760CD5BAB
	for <ltp@archiver.kernel.org>; Fri, 22 May 2026 01:55:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8EC373CD53E
	for <ltp@archiver.kernel.org>; Fri, 22 May 2026 03:55:21 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 750AD3CD45C
 for <ltp@lists.linux.it>; Fri, 22 May 2026 03:55:00 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 1A7CC2002A1
 for <ltp@lists.linux.it>; Fri, 22 May 2026 03:54:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779414899; x=1810950899;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=L25ROA2m2qxvxQICZu2FdNWhgAxk6xGxSZZ6ntmqp8I=;
 b=gLX1dya0oKFnaBIv9Q/Y7ij6SCjLxRmqwyTH0bSn/M64B10jUU1qWeo9
 ZEBzCWENA3KYoQsBLMi/ldwIHhHR5f95o9Q23IG32maQIj0msEbME18Wv
 hgx3YwerbR/Sj4ffFK26/zzgNO7L0NKuzk0L5k1Fpc9vdUI5sa7B8Bl/2
 kbS7nNx6xbBbGkGfK0GnDgmGRILce84L+LERhMFg1P+CLQzzfoL39rrxp
 ut1b9YOk7GxRZeoZInokr9qfImmFdOKjwQwk1JJ66HsNnt8KonjnEpkQ/
 UHCNd1O1aoRXi6riIFKm0Wb16+onQLTibXiO7/dglQsJJE95x5atMTmtx A==;
X-CSE-ConnectionGUID: Zkc7FoMgQZu70RfirQB8Hw==
X-CSE-MsgGUID: Gc07bFxYRMCuTDkVIPtddg==
X-IronPort-AV: E=McAfee;i="6800,10657,11793"; a="79493813"
X-IronPort-AV: E=Sophos;i="6.24,161,1774335600"; d="scan'208";a="79493813"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2026 18:54:56 -0700
X-CSE-ConnectionGUID: VdjpTI3vTjSXtFtZ6QCcFw==
X-CSE-MsgGUID: 3fWwAPAuR5qLsGB6VFLjpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,161,1774335600"; d="scan'208";a="264549264"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2026 18:54:55 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 21 May 2026 18:54:55 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 21 May 2026 18:54:55 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.44) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 21 May 2026 18:54:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A9Vl3u5z1lIoLxGjS4YxbSMJuveWofMdFLTYa2yLCWlQ6cScynvE5Xeqwz0F5C7GMkoTWZf1cIOcF59NZBvBNGjvxxSKXpW5AdFy6WD2nST/lWC1iN1lwYsF4uwodqfbakC2mfd6G2QZ2A9DPTkcPjNizsMo9FvY/O4vd1nsr+sOohLekaJVh7GuInbQh+W6dp4liymdDYmQmpNXjumWwJkSZGX+GP1tWY8a9YWBIirlIJF775/PigPIQ9RRvQhDlRaTMxuUIP7uiKoDmPXz0scugrVx2KsikAt9YdHXZQQPIaNo+Sfmb/3YyPpMnz6b+sVfX8JXvqMkRd5VGIkg4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BOKxIGgeRtnW9+Nd8vCyIPzD8S+xx7SXHG/XLjxyExw=;
 b=ISlbB2fdPRqWok2F7VTmixkhZ8XayqZtmG5bW826lAzUHZH530F6Elr/i46qANvzR84Ph9/v/Ia5HcbqAfkUmNShP8BkPJLj5uRf0ax5UEHgq5VVrDDdoS0Vv7VoQHlDXsR3A+EzVDeahzYqFqU/CEWtZziWX6gUxQ7PVAXOmkhtrg1zp2NY0bjXn3A9yfuP4R67e7/hDFiWNgKXrShUOSwaev3+rY8eAotRoGTpAKZFzifngoyFHUYEx6bP3N40iuuIj21ja3IJIG+jOu0s24VFzId9lH/f2NDu/qxqNL78bpbPVjUsFppuqJYxx39UmQpKNDKy3KBqXb0we7MLog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7)
 by CH0PR11MB8190.namprd11.prod.outlook.com (2603:10b6:610:188::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 01:54:51 +0000
Received: from PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707]) by PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707%3]) with mapi id 15.21.0025.020; Fri, 22 May 2026
 01:54:50 +0000
Date: Fri, 22 May 2026 09:54:42 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Message-ID: <ag+3YgTltgXdb4Ha@xsang-OptiPlex-9020>
References: <202605211529.6ba1b4ff-lkp@intel.com>
 <e43a6e6a-da4b-4b69-add1-2bcb33cbb0d7@paulmck-laptop>
Content-Disposition: inline
In-Reply-To: <e43a6e6a-da4b-4b69-add1-2bcb33cbb0d7@paulmck-laptop>
X-ClientProxiedBy: TP0P295CA0036.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:4::15) To PH0PR11MB5832.namprd11.prod.outlook.com
 (2603:10b6:510:141::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5832:EE_|CH0PR11MB8190:EE_
X-MS-Office365-Filtering-Correlation-Id: df85128c-bb27-4ba4-71ba-08deb7a51c0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|18002099003|56012099003|22082099003|11063799006|5023799004|6133799003|4143699003;
X-Microsoft-Antispam-Message-Info: uxL/VbqLmZgNqtus/wLMqnAOAGqV0idYSN72UOGAbQ8NoKVCYqI4iPSjps8HJ3BOvDky9fDXqzq2/KjFPG1OjKhcjm6t5l2Il0UtOr60XUUe8ddFL48harzYY+jvJKqP0d70FtUuoIFVBKI0170jYEDTIwmaESCe8t17QJ8ktVR52y1z/LUMPLFJZ8BZ5/AHnkjlXXsQYnGtiT719Ds3K/3YAx5joMW9QtR7fOlGht/q561dwfMibLFjoJ8cbPFh3LI5jLnG72g5752PWW+sT5lriaGBF+7IwkNY5TwcNUPO1L+PLOCsPKUNKgCVrPPYLZqWXXtDMaht54y2EjIjiHqpG26b5eAi4ZjQ00sjmxaoK7LlNtnQej6JbBkdrCwgbyEn1Guqt1XE1J/foMQFCV9OJdVvIh9pLD9WFnMyTmEbjLYmidIhFYdA07x3VdUjVDdamx3ndUhDM1QiNB1eHnH4MfNW9ooLkf6lTAnbWhgfwNHmzpHlBJrFPjcS2Q5zM6+Y+LmA6Ct4duay8+OQUAjh4yFZDaMI1Nll8mAmfGSazs6k2c81gOvG4HMKY/XP74vi7hLUicXlXlTBiNTHmu5QlIkH727hrTBq86Sy+pEvRgFfojND7PN36777XowL5TQMGUKhwaJm63h047uxvhRjC/j4Wc6yb5msjQEYGq700/cad88PUdCfJSz/F/hi
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB5832.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(56012099003)(22082099003)(11063799006)(5023799004)(6133799003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Y1NGJzaAyXauD/pRdGYTeN3R2NVlg0UJw/DAzO0nGwVHAnDu/j1rZlISni42?=
 =?us-ascii?Q?dKDzJb1uHPUnyntufe7KGZISWRn9hDfMr1b9+Z1Yc6ktplPybPdefP37bmFA?=
 =?us-ascii?Q?43hDGD8gTQeYL8wAnr9Ecqp5bIkVlRLclwyoJp9xYHfHqtbu7AH1rZ3b2Idz?=
 =?us-ascii?Q?2G0MlOMhclmg6xdRlt0FhW1TeU35jgiNl5kCQlyzGhqkFEeu582je+p7JjqX?=
 =?us-ascii?Q?Cv6H81lM8RAz7aDTLuOLbs3qaqUlRZGOCsWA3dXfpUHkVYSLfljDSt/i+GY2?=
 =?us-ascii?Q?xOKzVhklB7IuulKFPtnVSuQEx0asMRWxdo2oWXCU/nufqRK6haVBucYLXO2h?=
 =?us-ascii?Q?HMwOnqba/RKkWD+iqdOdcVbqaqWm20Cs0sGrq0pjNbeDy3i0MHhbQHf69gza?=
 =?us-ascii?Q?vF9lPa4YAgMxiVYZVOF5WicZrMDm/bl24HjdEIWU4H1eHPt5szQ8hDcYxfXq?=
 =?us-ascii?Q?NIeowhJr8c1dhQUt2CX9OS58HXqV//KdOs5dqFBahleSgkrdAeBROigbOtKS?=
 =?us-ascii?Q?0/nrX23aeIh24EfB6OzSxLNRF/MDczw83SCwmyFxE+mlPX+W58hYssuOEs3h?=
 =?us-ascii?Q?1QbuMQazL8N48BND5QSTv8hMSlcuo+kE4UuQFlrLA/Rqdj4TUsbc/fxJCz+0?=
 =?us-ascii?Q?dpkWJxqVHA2oYuNeeG5Pptx1QQaau4ZiOSKmPCdS7erqixiFBAZwR8yDJZak?=
 =?us-ascii?Q?HSIFWmsPJwgHGegM2uwKc5sueJy8RkoHgG5wCpuWZcXMgOBH/IyYHpRwS5Sl?=
 =?us-ascii?Q?lCdy5f6UJc8YFeIajdMh0Mse5j3HClUeBJs/cPeDp/ifsWCsXp/TVC/1D54b?=
 =?us-ascii?Q?Gqi/W5U+2ZYpyluyGhDHLrXSNMx8SXxOu6D0I0ftJF3USHVdSxrxqwlBGF0R?=
 =?us-ascii?Q?5+zsbC/ScyKtr43Ay3c+iHUytebJ/Sv/eJVk2BQ0cwxmecOLAW/1IqLuxb27?=
 =?us-ascii?Q?rA7zcLiY0LvYIH710obMjBiGusEZX/NDFTd1y73BOqMLkZUWHftC6eOtgiN2?=
 =?us-ascii?Q?YvCIEiVHl2Itiuho4FPLb8aGOMBcnXUeRsl8N5y4ogRQ+6Sq5p4UzSgIBTO1?=
 =?us-ascii?Q?FcZgH0H0fAdiwbuVADAQwYrY8WvAWhpjjG+uaarH+uVj32aP0S/y/jY21qJE?=
 =?us-ascii?Q?jRzG4EAIWAKO+dRdEqnG1ZxK3EexJ87u7F52MaaKrn+/Q+CcMEl0iYntdK/F?=
 =?us-ascii?Q?yNlunD/g2qicJtjAjLuEsCWjT1s6qTyTFPDPyTAebgFzyZGhDex+QBPi3GMN?=
 =?us-ascii?Q?qIqzjIIdt056d6lb0YfMZHm14/jiz2SEypHnkD2CbGEOF0UR7PAdB2opj/Pb?=
 =?us-ascii?Q?N+ueMx00ovDreteN8zo6coQVuKiuhy40WO6xPwkthpNTyAN8cdo4jDBj8/I5?=
 =?us-ascii?Q?x+JYOwBuBKnIkJEHxzfFE7U3Oybl2eqyr9FQybiulFC9S6YR8UG0BrgdfhHd?=
 =?us-ascii?Q?PJiCX24bsIcF82mszAtVxjnxPFqFrpRU/y7dotzkibo947+tWdtY42I29wnG?=
 =?us-ascii?Q?Z/vEi2cD8qHLESUrFs3+Qlukd6a/tc9HVdWXFlO7ZlRjCH3UEPI4xqyrAyEC?=
 =?us-ascii?Q?6IxVcAhEBYiH6GLBKDElOE+VETa1auDTmK52zYE7ppDjG8pCk7I+i2QLX+10?=
 =?us-ascii?Q?2lMy1o6AM8Cs6SIKUQ/4syv5OJ6QjTH1anNrFMhDT1Yn1aBTmPUXXeDl/nB/?=
 =?us-ascii?Q?UcNUX3LO07tk3k25Y531FUhrKdRFi0hfC0h+kDEBj/1kpqknVMlaNUpGjskt?=
 =?us-ascii?Q?yJZUz0U9KA=3D=3D?=
X-Exchange-RoutingPolicyChecked: I3pVwjhV4hqNijhF0Jdfs2tA5A0Vui/sqcz288M7kf3PMRH/Wm4DLhhAl+75NnDmzaMUqKO6s92TAXaxnhV9vOCtQHawxX66Jl7ZoRrwzFYBTwHhJjuBPr9B+PIg0+zehn6QbG0kDMoiiRAdwHGJ8rQUqIkzfZ69geZA2xSWMFCHBeStym+EX4yApAVdFq1QyDeK1krzKT5Qfoujwampm/BoF3LZy8EcVV4T2MwvJPeK+xf9qZndH8YzykbgQaCUFI7bsxkY9Ab159cww6VkumB4Pz5uebRDNy6pO6li5YkUuZKpGY34L1aAk+zr20yVwBcRHcaQKZx9azNyAVcb8g==
X-MS-Exchange-CrossTenant-Network-Message-Id: df85128c-bb27-4ba4-71ba-08deb7a51c0d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5832.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 01:54:50.4356 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X3D/LZu9sWnLfSSWjC0Dvh+bX7eXdwu/jwFbu/JltyDAtnc0LYcitOgbk7SwpV0Gg3MqXNvI59/L48+TN2lJeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8190
X-OriginatorOrg: intel.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [paulmckrcu:dev.2026.05.07a] [rcutorture] c2e6a63ac1:
 RIP:rcu_torture_irq[rcutorture]
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
Cc: oe-lkp@lists.linux.dev, oliver.sang@intel.com, lkp@intel.com,
 ltp@lists.linux.it, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

hi, Paul,

On Thu, May 21, 2026 at 08:55:53AM -0700, Paul E. McKenney wrote:

[...]

> 
> This should be fixed in branch dev.2026.05.19a.  The problem was that
> I forgot that smp_call_function_single() handlers can be invoked from
> the idle loop instead of from an actual hardware interrupt handler.
> 
> The devil truly is in the details!  ;-)

thanks a lot for information!

> 
> 							Thanx, Paul
> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
