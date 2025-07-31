Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0F60C87FC9
	for <ltp@archiver.kernel.org>; Thu, 31 Jul 2025 01:46:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B39763CBC31
	for <ltp@archiver.kernel.org>; Thu, 31 Jul 2025 03:46:35 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 568753C078E
 for <ltp@lists.linux.it>; Thu, 31 Jul 2025 03:46:14 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 9787414000E8
 for <ltp@lists.linux.it>; Thu, 31 Jul 2025 03:46:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753926371; x=1785462371;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=CPyfrplJvYXzQqU1sxm+UqKNSpJNb5bEZTh/Udxd3BU=;
 b=II0zI3+t9UYD+CCjEXcTW35k5CKWSiX91ZvpMKplNTk8bzwPxGMviBvz
 AWjiow98zVWw1Zdnp6J05OHWwl97zfgPZgbVwY5diz7WLVJbUneleglbS
 9aFnYlwwJrZYycU4QmH4xYPLjiKwSj+yobxLg0l1D6ohqktidxMEGqLqy
 azxCjLPjXCzN3evT/DSJPdyQyzbEscOGlLs20TlfUdf3B4To1Yhr4GwuC
 kPIcHF3Ayit6mICM7X9ii0XM3q6DbN8D+FDMS5NEcc1yJYcyQgUTKy/Rl
 kkn2I66DNl4wna9wTvZ09ftPRPci+OXcZnUv9YRB70vvo3Cd/uG645ivU Q==;
X-CSE-ConnectionGUID: AKizcU4mS8GoR170I8fRlA==
X-CSE-MsgGUID: M+jvz2W5QumTVP+vUZQQbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11507"; a="59885389"
X-IronPort-AV: E=Sophos;i="6.16,353,1744095600"; 
 d="xz'341?scan'341,208,341";a="59885389"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2025 18:45:58 -0700
X-CSE-ConnectionGUID: Ax56/D4fRiOpcWLpI7PQSg==
X-CSE-MsgGUID: Oe7En+XRQ9GWtC2u2Kk4qg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,353,1744095600"; 
 d="xz'341?scan'341,208,341";a="163586513"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2025 18:41:05 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 30 Jul 2025 18:41:04 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 30 Jul 2025 18:41:04 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (40.107.95.42) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 30 Jul 2025 18:41:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B4rBXbQC2TGjChXr8zAKy9XQpcQf00bS82dC6Vs8Q3AsZ+dbE5GqTLbK9TNnd/1ERC/8Q3eCHjDjUbpscbhK8KIOn44FOm78POBdXURjS6qhWs0ZYRwwrgdXBlNkuyCjr5Q8Y8E2MUEtkP5yCzWbJzbssiKuAIaExwmPW33H47j6qlG7MPkbRXWokm9UY2MYVt7DfmttSdYjgLrO3GjocLhok7vvEcT0hm3iUoo9MaE3R0v2oOr+7HRMjQMByQMpSYNkjRCZd6Z7/UTV62rPy4a6wwlD+h/uXPIEBuSjdxvoYkvl8cAqCVO/UOs2SBzHJwAoDgjI4ppsCayMuOpLGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NivLhVznuUp8WsrfutvltLgAJOj4/nIxYUa9JJKGxnk=;
 b=kkO6+uIcAOEVy+upzu0cwpePL43fpCBAZBZcXTLcMT4vBJl7xjcgN353p7WyeQVovyZMGaHKeNCBu1Q08UfwUpzulJ1Ycl8wJQmHGJ40EMDdROAfVTP5wbyoy2du5Uf0HE8JldGJbi88LEofZt0uYCT/s0rqBrA0Q0HqD8ZwRv1kimt0CsQadq2/rNEF9i8bv0UALEX4suvXuvt8+WudZ/tddDHCLwZSHdOCrNwDpcIqVoprc9+ciUsrqbmSU2FPU4OcqKiPA9UDcb4U0hpV6leM+ri7e1a9gsnVc/wve5bmvDhDoiU6F32cTf8vkcT6r6HdvggU5cbvGMWNEKGEBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by IA3PR11MB9157.namprd11.prod.outlook.com (2603:10b6:208:57b::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Thu, 31 Jul
 2025 01:40:39 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8964.026; Thu, 31 Jul 2025
 01:40:39 +0000
Date: Thu, 31 Jul 2025 09:40:26 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
Message-ID: <aIrJipeLsGUM92+R@xsang-OptiPlex-9020>
References: <202507231021.dcf24373-lkp@intel.com> <87a54usty4.ffs@tglx>
 <aINKAQt3qcj2s38N@xsang-OptiPlex-9020> <87seikp94v.ffs@tglx>
 <aIgUUhKWesDpM0BJ@xsang-OptiPlex-9020> <87wm7ro3r7.ffs@tglx>
In-Reply-To: <87wm7ro3r7.ffs@tglx>
X-ClientProxiedBy: SG2PR02CA0137.apcprd02.prod.outlook.com
 (2603:1096:4:188::17) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|IA3PR11MB9157:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a573846-e4ec-45ea-188d-08ddcfd33f81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|4053099003;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QS6AsPD88veH0xeZEuJ75+q2SJEhCIrD91dBGhCy4s36mdZpmQxn5RoCFwBb?=
 =?us-ascii?Q?H5FQIly3pgD3+eUQCx4R6mrTHBxyORPQ3mVBeXsV+nWr1rp/JGHnlJEiLDfo?=
 =?us-ascii?Q?TlFGv2Uzwbrt3q9HHcGqeBiLITNTFCZh8Fac4L6frSmWZ1+HTXiD7l5EmOiq?=
 =?us-ascii?Q?0LPGOHfspAPzU+OonkDgnSwUIxSi8jyjO3MOO5/+rZgBsrrTED3ZReAQdKAf?=
 =?us-ascii?Q?edxRfaQnCsdNr6bHw3xqlzaz4BIkBtXh3Ie9ZXn1wRSnYX+sKnFS6EhVJq3M?=
 =?us-ascii?Q?hbETsWSH25yG+6IRk3QNwTn+xHV+mJ3ze2Ri7WOL5APxdPwJmbWJ6a2OlqD2?=
 =?us-ascii?Q?nNSh+oipj6Fttri+hrVsPmX8UtPb1lozobCKahiLmPpzaHaiSDl9q3a54d1d?=
 =?us-ascii?Q?D3ipKTsuQaNVa+8wN4StWTvOT1U6l/TE2x+TCa8R7oiFrqK/t7IAXaZdS4pS?=
 =?us-ascii?Q?lMTU0iO5KIAr4ZfMKbVL1ao7M3re+RPjqdfYQhmEC1QgkZ1aq4hRJL6kEX1C?=
 =?us-ascii?Q?djz+ju5skdi7pebQc2L9dOF3wOoQZqV69Hb+z54ROqOqS01EoPmCU4+EvMYJ?=
 =?us-ascii?Q?H5K50erdI7vWJgsihq7FCoaINyYHopJIVCBeOgJ3VSyFgCkK2EeaA15za9y7?=
 =?us-ascii?Q?dBEnns/HoIJfP05JbyJJ6Oj+nV2QTlaBPtvstfdShx++sr/SvRyIoNiFBw/z?=
 =?us-ascii?Q?CDN6pXvESozjlBRVjArCbGNePBKNHnYK0vGvSHQNlFxOsI5u/f3neUKPC0Od?=
 =?us-ascii?Q?k+pKrvaAta5aqoz+kA9klDDIc6by8xzVjUetmAuQnviLoIzgpESwHc/mk9YS?=
 =?us-ascii?Q?awzrm10h0HNWnEVRnG9/V07SnAG3sYUIox3InUdcJfoeY012r0gs+8i+b/w7?=
 =?us-ascii?Q?lhJethxbhZOv7fK1+fuskmh9KvSo4eGgIrROlypDoFZBhYIKqz1V6/8WtUoG?=
 =?us-ascii?Q?UCxDfa0crUUejBkCyCCa8ZA7qjwnsN+tplg0H9rUKjr+Bq6O/4Pnc7HBA0kQ?=
 =?us-ascii?Q?3sFDEu3QakLRwkKgLLDxIVoUPpVW3FsBbmIoZPx5ZJefVaN70D7C8QYS1laE?=
 =?us-ascii?Q?QrweNjHP6WWkw2+IwkZdRoQDwOpFyUiUViudCRzFnNvcRAnsiFqbj6m3ntFZ?=
 =?us-ascii?Q?LfvO87UTbRJsg2zAZljaWdSD+hLSEVkY6QAjJfBxDTDdE4LPOue7jGzAoCle?=
 =?us-ascii?Q?ULOUlLM6wwsO4zF/bAJ7HvPyybtDWwT6Ej/W6owgBvFg+bAu7eHMpJZWR4sv?=
 =?us-ascii?Q?NX6yAxc2ghJPkToszlib18a+UaQ5fwubSerXUF1GSn73BpysM+i9vIBHtjGu?=
 =?us-ascii?Q?sTszJ/OPxjkgbqRX4K4e6B9eZ4qPGhYyigxizhglkNWd5PEFGu4IFhxWHqoM?=
 =?us-ascii?Q?6dff64S4p6wfWatPkkD7PtKgvNksuTwOOb8rxqlX22nzCfXF6qPeUlmCWD+V?=
 =?us-ascii?Q?3hZmhmAMzp8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR11MB8603.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(4053099003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+zBocOBOWr/wUtz3D8ngOCldWwxxVyeemiGt8Cizyxf1t4iipEIv7e/33CCF?=
 =?us-ascii?Q?EBDEDUnic7lXxLCV/0CS+et2LOz6S63zT+QIjrI/HW1pzjWyQ7YTGIFUQ/WJ?=
 =?us-ascii?Q?rkrbVmb8US33DxurGcwwG4PA251wGGKGreB088M+IZILnK9fXbe44blWdJ6p?=
 =?us-ascii?Q?RFrj7NC+Lie0nquGhA+IFiyeIlLupJvriWqu8IH4xRa9dOzKoSTdgD86cQPX?=
 =?us-ascii?Q?KsjUW66u3JEwS9is+GzqHbCjYecBMEw75aYk1CTgCoyXnCsXsRGu/OLqGWWf?=
 =?us-ascii?Q?MbJ9qwBnZlXor7zlggg4EitkCGWwEdGACmCsqau2fa4hFrbh81o/rGION/7e?=
 =?us-ascii?Q?/CbXCmdhuyWEgGzygB+MH59F2N2WM8XOav38mZeOq9O7HbDKjaCGHRoN0r4T?=
 =?us-ascii?Q?pNGMlhIwVv8lXNC5SZBxGMZkRbCQ2Q9UMGdaBibnillTLwLSECtsrZNVrx2E?=
 =?us-ascii?Q?UE3AmfTnp6HPdpbNou58sMRrqZzvgOGHLB85YvDGONvhZFyNdtG0pa7wGtxn?=
 =?us-ascii?Q?sQfE/tRewhpVuYSovgNy0doY5H2TswJi7qhPqt7nEv7g/i8cZWiTr2SCPXFa?=
 =?us-ascii?Q?ta3pHEzdJ1sTx2Bv9SXSImbNNqb9sDil935DuXN7zsJhpFoXPjLv2QaANGu0?=
 =?us-ascii?Q?um8x3tZJWPfJdRFeCG8nnE3nH7Y8KAGV+/Cll7hriD3P+6JQIwlAqDv2AHR3?=
 =?us-ascii?Q?QNMuPEL75gtXHEIwiFihXxQpTUNTuG+BzRYN2svUX6ih2wqWhh/2ynq25fvJ?=
 =?us-ascii?Q?DzSrvtBHFG9o1AaTP107K5tntXxmYNOpfxv5CmyPmYTsMs63DdnZPKHOXrPh?=
 =?us-ascii?Q?nP2JYRFL4KCMMK/hzX9cxmYhW8P2UKOtQwnzm4995hrocZ/uRRRiPpOIG0HA?=
 =?us-ascii?Q?sVHYsfqtmD3Vzv3KoLuiGw7iqQAUneKD4gkRNzamQ/Fo+p9lZeS0lZTnYhCF?=
 =?us-ascii?Q?e0JhmyrTWnhePePPp9aNMdFT7b8gfmAvF0KsN18QS7gq1sqvHfsNG77lDTjE?=
 =?us-ascii?Q?HmxBlFsHIzA8ozTemrvkteR4T34iHofuVLWfwZfUFlEFrGTURqSMrZSw/aoW?=
 =?us-ascii?Q?9qwL5fr0qfmJQvvtRwcroj8PDzg7uDmnmSq2ymdomAygCIOhINuBfbOrtoN4?=
 =?us-ascii?Q?79J7w/VMUkuCsrgxD+rw+boKtS5gc7x5PIdlx82N589RWJW+VqMatXgXOpQa?=
 =?us-ascii?Q?CByDm91W2YYDNemKOPl6oOUIjeqkso+YZvDPS8co8zBWbfVBOaE23tnfTwc/?=
 =?us-ascii?Q?SudlIw4GAedfZukFNyqiy75zCMLJjtcArlfdYKdgzqfEBSMLzOYReB7Pir5K?=
 =?us-ascii?Q?DHIJGTZaZq0iA/chSu2+LIs2MJ4fkEVNjXihoWTQyg9Q1slSMFR89L2o0xQ+?=
 =?us-ascii?Q?SqYfcXjhCctw0/ErrWZXwXgMCkuSKstSou1RS0yR2AI5hneAfp3Xar6HZn3k?=
 =?us-ascii?Q?Vg9uzQdE0X5kyIF8cRBG8LdcSfi+M5UIwZBQbwR/3V33pYdvr/scsJfCfbyO?=
 =?us-ascii?Q?c0K7xwPwnEQtGVWKRuFnHegM/hj7NUcmtgG39YcsHlQwyHb2/6J+KeP736Pa?=
 =?us-ascii?Q?xuzQhAFbxIA/OwNAze5aZ579bNEJrSBOyBh9ZRfF6+zhMvNn2yGkXFOJLnG5?=
 =?us-ascii?Q?YQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a573846-e4ec-45ea-188d-08ddcfd33f81
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2025 01:40:39.0870 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YbYF4GMTdHPgE6GBS1WClFbW6bsZZv+2gGPO4tZ4zRLto58kR0BnsxuNxfhCHKkhRMhsHtR41VaM9X1V75cxuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9157
X-OriginatorOrg: intel.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Content-Disposition: inline
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [tip:locking/futex] [futex] 56180dd20c:
 BUG:sleeping_function_called_from_invalid_context_at_kernel/nsproxy.c
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
Cc: lkp@intel.com, Peter Zijlstra <peterz@infradead.org>, Sebastian
 Andrzej Siewior <bigeasy@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, oliver.sang@intel.com,
 oe-lkp@lists.linux.dev, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

hi, Thomas Gleixner,

On Tue, Jul 29, 2025 at 09:27:56AM +0200, Thomas Gleixner wrote:
> Oliver!
> 
> On Tue, Jul 29 2025 at 08:22, Oliver Sang wrote:
> > On Fri, Jul 25, 2025 at 05:45:04PM +0200, Thomas Gleixner wrote:
> >> Can you please enable CONFIG_PREEMPT_TRACER and add
> >> 
> >> 'trace_event=preemptirq:preempt_disable,preemptirq:preempt_enable ftrace_dump_on_oops'
> >> 
> >> to the kernel command line. The latter will dump the recorded
> >> preempt_enable/disable events and we can pinpoint the function which is
> >> responsible for that.
> >
> > the config with CONFIG_PREEMPT_TRACER enabled is attached as
> > config-6.16.0-rc5-00002-g56180dd20c19
> >
> > by this config, we still see random
> > WARNING:at_kernel/sched/core.c:#preempt_count_sub
> ...
> > but bot seems not be able to capture other new dmesg stats.
> 
> Ah. The tracer does not dump on warnings by default. You need
> 'panic_on_warn' on the command line as well. Forgot about that earlier.

attached one dmesg FYI.

> 
> Thanks,
> 
>         tglx
> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
