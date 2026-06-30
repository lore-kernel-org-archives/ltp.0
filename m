Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 342B7C43458
	for <ltp@archiver.kernel.org>; Tue, 30 Jun 2026 05:19:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A8A153E4ABE
	for <ltp@archiver.kernel.org>; Tue, 30 Jun 2026 07:19:33 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ADD263C2780
 for <ltp@lists.linux.it>; Tue, 30 Jun 2026 07:19:18 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 0C74D1A0109A
 for <ltp@lists.linux.it>; Tue, 30 Jun 2026 07:19:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782796757; x=1814332757;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=xoZpO3Nn9Xz6NEookp+SLXEVkAGySq94mDDdZS9j5mU=;
 b=SwYzTw3deMS1Qjtv6tQKp+2xUFjf+Tv2Yk8pUs0US39KL+a2Vnr3azvS
 GWecVd4SBAh8RrhIEhcmx5FhXhF4WwxGoxa/OsuT0tvYIx94wZB1xCx3f
 2Wckeccc1mTYbMwVVv1+gtk52Yzyiq/vnyF3YNa3lfcUpriN6sJFdfXnu
 DSY0CRNKR8y/doPc7sTOCpt2z/6zmbPfD9RfNXcJPZ6ZpUBS1WYquThmJ
 WVIWEGA/6dAGhMyWsGz7gXjaO1AkTM+j8fIf/5ExAd7/YQuUvS1+zy5qL
 W0Ot6BICNdVetxbi1Yc/5H9s3aHS4RzEoH9sQRDeum41L+2y71MEMsjke Q==;
X-CSE-ConnectionGUID: wlQB5qHuQZ2+TVNVuc2ZVw==
X-CSE-MsgGUID: NkPTaedKTjeowcz83RBXyw==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="94883747"
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; d="scan'208";a="94883747"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jun 2026 22:19:11 -0700
X-CSE-ConnectionGUID: PXLBMhfpTUSYlrcYMLPCBQ==
X-CSE-MsgGUID: yhdxkHjMQGyLdNzlT+MuRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; d="scan'208";a="252304937"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jun 2026 22:19:11 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 29 Jun 2026 22:19:10 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 29 Jun 2026 22:19:10 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.41) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 29 Jun 2026 22:19:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=loWwHxlnluw0x0QpSSrfwlWDzNpyvQ6GMuEjOq9AZgV7qMwbf5Qowzpzu11YymvpN6fHLa2O1jO/7kcCrFknI++B6f36NdOPFHZVPOOX5K1xlwvcxw3JMNDRrU/kDrBnXl5wTVFqeqFqL4IColVpY2qJEjI6qVuxpdSIEZtrKSIG5rzn7bSRI5qOH/5pVENc7BZS9esockmYzJPX4IxQfgddRBM2g5RhuKCocs4M1TrZuCnbhB5LPi/Dt+M+UdAusMH4WMHLrXBxCEA97cWNR2AoJ/wu4VBauzch2EvN5G8hVVGw5cDDykaDB3gbGF/+oqxJOs4DKP5yGL5iXemVTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ieSHzdnRi3grpeGmjHj1k5KnI0IKjvLLfrGQo3EaKpw=;
 b=xnhdF4OT3/5RMzGyc9kRpq9Nsy0p8rd/4yU2eojjbcye1vka+bh8YVvy+1oxWVReNPjlBrzMeftQeOKqCQJ+McjfrsU8Qsc98Ahfq5CO+JQoyOZv6ltH2WpfM469YuBfEOwQL7Ap8p53YpOC7m47PRvEr4UHYzw9fml4E9HI6xLfm97Id3Efl8lItJAjz9Dll6LVqLr2QEww7JR/KnCkfzay10VW/mST02JAyYJ7PbWAl19oHd+0CqU+ZwBxCZKm6AytC8EQkMZjUQHDs9j02qqJMrkEAfVsE8mAGNo0ZPSkPCEd+Chjq+1puNpQnz9gZ6JVu1dylmEufaOzlcAP+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7)
 by PH0PR11MB5078.namprd11.prod.outlook.com (2603:10b6:510:3e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 05:19:03 +0000
Received: from PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707]) by PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707%5]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 05:19:03 +0000
Date: Tue, 30 Jun 2026 13:18:54 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Jan Kara <jack@suse.cz>
Message-ID: <akNRvmJdCKALZbo6@xsang-OptiPlex-9020>
References: <202606291514.594c4370-lkp@intel.com>
 <qvbzvyoqab7c4g6jh2rezvdemqed7omco4qgvdq3elwbrlaffn@thrhz2uqtgqt>
Content-Disposition: inline
In-Reply-To: <qvbzvyoqab7c4g6jh2rezvdemqed7omco4qgvdq3elwbrlaffn@thrhz2uqtgqt>
X-ClientProxiedBy: SI2P153CA0029.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::16) To PH0PR11MB5832.namprd11.prod.outlook.com
 (2603:10b6:510:141::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5832:EE_|PH0PR11MB5078:EE_
X-MS-Office365-Filtering-Correlation-Id: f67042e4-3a55-4563-95bf-08ded66718bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|11063799006|22082099003|18002099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: 8ubpTWR+EozEXBAL9QwcbLJwnnWiXO+bxMOuVRlUYMb83yWJ7o4+JJFf07/vVduPjeFHeB0iyOSY7ukOdkWmi+4jE3/rF2mQxqxz/mi8pG6kWn5zOuk6MP82sF7jN6mpOmSHDAZ3qBRspm8q2dSF36QRxsIj7uTUTMdlDjrrfy56Vy92lFhCGWWEseLo4TsQ62iqxV70uH9+9xNgZJf20R+PZfiR/yQkpzIAIqy0eAjxAD6NW/hZ7xnCOvgQJ7BFluzux8HXGZtWk9OrnHsQ0m7WSPK51P3OuWNcw42C2EfKxNXCQKdQnJoIzmQnx1YaYBtHFEGHpQ6It6DyOFkv35WecsavG+B1DPWYP2QGmK5zg+imDYch/8+GUlEKADTHdgVXwhk3ibaW9Ltdt173AJTZucUEXB1Uj6q/BeLzzrk3A7JVJBuPFdJlNqqrP5prEjH/xRjRr9slAGrJ7SjM2s8+qNnetVH7Lh4bZUS8857/4F1Yxg6FYdRXZxlqhD1T8A20185rJPXQ288TqBiiadvvqnJuGYY8ibIhqZu/N2IFTwPYULIkslbk5GPs0e2ziiwGP/fPHgWx+zUAqcL1k64V8biRB3tebpl/7swvYWUcRWgVtNcfcH6l5XDeSL1Bmvxj1WXKQSRrDUNV7Lu/6VWApmjGWjZ2irr9lq6yjhE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB5832.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(11063799006)(22082099003)(18002099003)(56012099006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NsFE26PWJ4mayiSR+0pp4i1NZNaudzR3pMpPVIgt2Gjr/tT2VPtNtO1o0uE/?=
 =?us-ascii?Q?HnJrjnZbSHdDY2lhuw+A3yIem04K4DhIpQhT3kNoAE2hPYdJOyZRTIrNGtFu?=
 =?us-ascii?Q?/uCHLM2QAQI4WwXfe8aSSS2cDyvY94Zku2uo3gOQ+wTUfcQSDMIE34rDgWTL?=
 =?us-ascii?Q?678k+egWyY9YBqyAk+pKrn8WWfsnYESTP5wAAqXpse/NZnYQ4m2VVawE7akR?=
 =?us-ascii?Q?igX770Z3PP+fgYhXCwoMuRvN6+A1HypEO4F/gltDVdeWGSpNJUddGQJaYbhL?=
 =?us-ascii?Q?ijafMH8lAfTg3bAqS1ddE1zIGF9xZInGEo/9h+yPJs4bbSpQbO15beYXuAPY?=
 =?us-ascii?Q?IE6UeJ3TmpdKPFJXH7XGPu4kk+NwuSW32SReNOX7qsrPuLvL0IBQTb5hyqpL?=
 =?us-ascii?Q?YrFKiXTZnsDEeDsKwS7Yg4vTKgokhpDoDEf3QxyE/D547ZsmAE44HS9YOc8d?=
 =?us-ascii?Q?NmmRum1OxYc5Y7BdvjFJiqIFgviqUHd9BTxT8mVBoCxmmPNDTnRS67Zw+koC?=
 =?us-ascii?Q?9opxqa4NFgiMZFQCr6Xzg2lj5n5pgc+UPHk+sHh8dEhY57/W8SJ19aidHnuG?=
 =?us-ascii?Q?RLmpKXchbmMrSWiHoFNvuR7+v1yehICcxOvzZ+LL+h8QXrvOEHJQCimfvAnk?=
 =?us-ascii?Q?uAEUv7i3C4lp6sEG/CRMoNMbGGV0TYJKodyBOAblYWE4SR1o6MZzgNL1we9v?=
 =?us-ascii?Q?SJdMcp6sMeMdAw6aL88gix0UifxCSfDpJviGJTbIzzIVx5RbK5P/gaSijxtI?=
 =?us-ascii?Q?dYmMSWipQzDPSDr/HSCyOF0T6WrJL80IDJ0DQtU7S0B6RSXyHYSnYY/ncvhX?=
 =?us-ascii?Q?DWOW4wnqfo7+uxHjDjE41TXMf6TKYVoFf2HBbcRd5Ozefk1r3y0GeNsbAZsu?=
 =?us-ascii?Q?n3WP8AYay2q3zxIEVddJtYZy5M9TmkpXkgU9f2dxOS+Y67J+Zvug0nlthWA4?=
 =?us-ascii?Q?mnQh7p0To7EHFMxdPuXzVgQ8OFG6qB0LZHmSkc44pP1Z6yXYL+r6U57m4EeW?=
 =?us-ascii?Q?Na8VLgZtTPk8ODMqFOHc789W+MkElzKwjPQ6fCcbe9LrBKGKOQt5uCXK16Ub?=
 =?us-ascii?Q?WL7XR9c61sRXHW0FOso+iapuzvBtjRaGUUlZN/w5OHPm4V7kjE14dldJN2rF?=
 =?us-ascii?Q?ilfNohzRpWEcfY4j0dqWxI6FAWMKzMswfurCB6KFENEHk1FtnCHUALbGU9K6?=
 =?us-ascii?Q?S9EZkVcZ36cEAeUVLEd3WIJaCtJZ1swM4+oTWvf1DuYK5zy5eWDKf/UlV4U7?=
 =?us-ascii?Q?8fpsDjtuyRoaUsor8EhodzZ53Pc7fd0y8BQtMh2GDfp7lepiYfztS5VkBwN/?=
 =?us-ascii?Q?n/KGLagXRSlxAmIz12XRLNf4Dv673Kf//2VdjQyF9Zelf5GfEve0RO53xwhB?=
 =?us-ascii?Q?EeHjwl3kGsev0XpQej4O/uloTuQXD/Euplm4ijeuSwYtp8UHv+TUNtho+0xG?=
 =?us-ascii?Q?5qCKI8iHxwhQ0byXx+XJbNo20E/K50ckkj8rmPgVgGsb91KHw5DVTpHw5Tu3?=
 =?us-ascii?Q?2ySzmNlZd4twRkMfOcHqle3IOdpIqOiwLzbmr+u7XkXn/fxlPF+XE0brWKg8?=
 =?us-ascii?Q?wRWCvG66xia9ZUE5pcvTFdSaengR/K9W1JkcSsxYNZAqA/YEzUUZ5yYqhPqG?=
 =?us-ascii?Q?PIO9usIRigcVA2sqyau9HDXiyqHRpdD6XG5Pz+VCcUf4Df5lg/dGU3rQQRgB?=
 =?us-ascii?Q?Oes/DXNAo/CjKhG2deZ1lDDKqzbUBpCseUNIzeSdQXJY46jw9sTFHDWSO5jw?=
 =?us-ascii?Q?QLg3DK4CUg=3D=3D?=
X-Exchange-RoutingPolicyChecked: N1+eFOuru1N7+o5kw0UaRcJhwe33zVTL61hoGte4D15qfvzYOfFt46wy1/RCDRmE2aGg2RDYaTGmRd/Wi6YNsNCbGm7zfypRl07n3qDJVQHceeg2t5IEC/CueY2lQuu1kNp6Lo5lO28xdiWAxLsm4SBd4JLkksMi4dSrEe09cVRAeMQyHV3ULlkyZI+pE3J4QXsLP3yL9POIe/EcPZwWv5gkMcmF7JpwimsijuYL9xvMkaPoYF4/G7Ql2V5MpU2XolPBp4ub+CSZstt1ZihgWkoH+K3ERswV1zzoNieZszpAjrFyGdSfvZWddddbw4AiZWgN1CWEqx84TQYFA9u9wA==
X-MS-Exchange-CrossTenant-Network-Message-Id: f67042e4-3a55-4563-95bf-08ded66718bc
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5832.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 05:19:02.6699 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4wrQgcNkf7W6SB/Sc0Ac9SH2B4aobPVV+lK5JNZcSl/9A2WQNI119LyQ/EKmkW9UUpcWejJwHY6+qhdL7RAYYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5078
X-OriginatorOrg: intel.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [linus:master] [fanotify] 82c6dd2047: ltp.fanotify21.fail
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
Cc: Christian Brauner <brauner@kernel.org>, lkp@intel.com,
 linux-kernel@vger.kernel.org, AnonymeMeow <anonymemeow@gmail.com>,
 linux-fsdevel@vger.kernel.org, oliver.sang@intel.com, oe-lkp@lists.linux.dev,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

hi, Jan Kara,

On Mon, Jun 29, 2026 at 11:36:25AM +0200, Jan Kara wrote:
> On Mon 29-06-26 16:45:58, kernel test robot wrote:
> > kernel test robot noticed "ltp.fanotify21.fail" on:
> > 
> > commit: 82c6dd20479bb6a9625e1d63a650c3be8865e2db ("fanotify: allow reporting pidfds for reaped tasks")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> FWIW this is expected failure. Patch to fix fanotify21 to accept success
> in this test was submitted to LTP.

thanks a lot for information!


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
