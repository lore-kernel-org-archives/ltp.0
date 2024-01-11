Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30537C4707C
	for <ltp@archiver.kernel.org>; Thu, 11 Jan 2024 03:08:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 808993CF7EE
	for <ltp@archiver.kernel.org>; Thu, 11 Jan 2024 04:08:37 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E8D853C8603
 for <ltp@lists.linux.it>; Thu, 11 Jan 2024 04:08:21 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=192.198.163.8; helo=mgamail.intel.com;
 envelope-from=pengfei.xu@intel.com; receiver=lists.linux.it)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 12A086007A1
 for <ltp@lists.linux.it>; Thu, 11 Jan 2024 04:08:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1704942499; x=1736478499;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=13UPmDcXm5mj2wiWiOATZXKhIaBYhutpH6EVahcfjPk=;
 b=FuBgg+Vm/GKjMbnqxMvnc8dL3uZuv7uYyZlsUHWiG3v49tZNkXmuas2g
 bxOt/kO61NugebQbSJ8eNGY5dRnV7jdRII3r9HiLu5BZrmJLOJYnqLSki
 90X/J5cv1+kk7KvuQcc/flVCheAU/9vYGQtiliictru/UzGJMH9+/MTIr
 zIVkmZdLvOgd/Dg1Yn2oBKWcCth1dd7iEOGUbX39n5LjPA1ihOSEez89J
 Q2HuCHz4VcHbuOBakS9deopRMGEFDotss6d3ptw2PuwoExVljJtjcoT2v
 k/VhOLqYOF105IcoOPYJA2ALzIZsULPf9cIs2IxA9gtFNKz5O3/2aKFiJ A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="12211094"
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; d="scan'208";a="12211094"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jan 2024 19:08:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="1029380649"
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; d="scan'208";a="1029380649"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 10 Jan 2024 19:08:16 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 10 Jan 2024 19:08:15 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 10 Jan 2024 19:08:14 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 10 Jan 2024 19:08:14 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 10 Jan 2024 19:08:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m4H4xWksOOVawxyntKhNYWYIHjw0Ft1HxtZxWU7dCTB/d3idYImwtfN4dI3gPiJTU11kra6up149TCBBzFIp6r+gmC+yYvJ4mtCRpE383e+sFHkpKO4RM3XEVEaDjKQr+n8grZ5ZgAxrilT82okjxb8VIuAAQSWfN6K+dO9cjrvHMa5DQwCyHcavPyuysaltTpb1xbsnyvPL35ErksZb0/oWNdrs+ypSeo81G+FyWQj1LJ8z528EKj6m9jO/NqAd2Nd+rB/+cZvrfdHKFd7p9hse80GjPXkemhbAv60qZe5GikKZiI2Q5XT1RmAvwXKgP0mmH24IsVeBgZ6BqdOiRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BFbfVldCIXjP7uqhNlIerirFPMU44R9ooEoWX6Ej71Y=;
 b=ZSCTt28uK7kkbNWP533LW1y44CSaYSm2W1u7DDiYDvl4JDF21K92Ffsj/D8WCFnkrL2R97of29irLQSAA3tLR5s6lowpEuiDdbEKZvE1NtMk+gyu8ubb7DqGSXZEFY+q2Pzfwsz2yzgmvOBkBDx1Z1hT1biy8HmejH8IcuGun1wqYRbYNe6hAjeOsuLQrOJXQUqq5VK9yRr9JuBFvV/vBGn9rkqZwXeq5PdzGDZ6F1A+L9b7CrpnC3OTD/VBcAZZv96hCjiieFdtA4oEcYyC/Z/7waqYSWo8egop7fJrs7oHZ2Qc1Jwss9iKqsoL3yrtloRBkZM4wOmI+VwOwmY43Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by BL1PR11MB5365.namprd11.prod.outlook.com (2603:10b6:208:308::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18; Thu, 11 Jan
 2024 03:08:00 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::25c4:9c11:c628:1283]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::25c4:9c11:c628:1283%4]) with mapi id 15.20.7181.015; Thu, 11 Jan 2024
 03:07:59 +0000
Date: Thu, 11 Jan 2024 11:02:31 +0800
From: Pengfei Xu <pengfei.xu@intel.com>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZZ9aR/SEWl57q6aR@xpf.sh.intel.com>
References: <cover.1704868967.git.pengfei.xu@intel.com>
 <f60daf00d0de49e54a5389c73c90994e7711a7d1.1704868967.git.pengfei.xu@intel.com>
 <20240110175931.GA1766165@pevik>
Content-Disposition: inline
In-Reply-To: <20240110175931.GA1766165@pevik>
X-ClientProxiedBy: SG2PR03CA0093.apcprd03.prod.outlook.com
 (2603:1096:4:7c::21) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|BL1PR11MB5365:EE_
X-MS-Office365-Filtering-Correlation-Id: 31f0e205-c5d1-4e57-bc24-08dc1252844a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ANAbquhG58/MXvYCKJt3zsp6lDKX32OAF0WjTQofUqRAQcyQd3vdGkEE13hEDBf46pShUjXHSQF+ONYYs/OobH23DK9nWqW40DPqGiobKz9T/ojvT074ruHaJcoRe8k9Ix39ndxq7QoldcOm14dsrU4pzBF2NZbx4ozZHrKTQAwClG75gBQLnlwFAMh9o57fJHHX2X7j56IvxG6EeEtJzK3XlXSvtzB+5dl79sfR8FqZn9p9M8WuucT6e1igKai8+RUOhnorDkX64j8jv3/VTN23Asu/fw73UDI+Z34Q5xypdiioFixUXKPQP2jjGpDzO8XGzI631jR63bEvmlM1d36dBiBwybYi7rAPhmuwPgDhuG2XEwhnQ6z5pmvl9eTU0tG7YB0So44+VHdvjP7/sc8iTZ9KjWJ+pXyIE20Z2Dy6iS0O4LHLt74SYng8Desq9D075kk3q7dqyEcCiPM4tdAjNq9Hsyy+ZHqw5leBcR4N5zWNk51JSrdQR8edE6nqr0jlnAnz7VqR/7T/D8N0d6uHiC09J0ztDw5wM/fYifk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB4839.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(39860400002)(396003)(346002)(366004)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(4326008)(5660300002)(44832011)(2906002)(38100700002)(8936002)(8676002)(4744005)(41300700001)(82960400001)(86362001)(107886003)(6666004)(478600001)(6486002)(53546011)(6512007)(66556008)(6506007)(26005)(966005)(6916009)(66946007)(316002)(66476007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l8Kif0NX4I7QDurkJFvFHUcVKHAsgtAZ3ElkazMJslNY/PvNuIFwbcXdfEH3?=
 =?us-ascii?Q?L3n+EJ/3Zgg/ZFc++VltQZDBnExfIdt1t9+/zrXzC86AXQnjqW5/y+R0Ndgx?=
 =?us-ascii?Q?Aq5wrL2pJBRP7NAKbxmh2+FxDcmAF8SGT0nJ9lpeSV9oJRDgNi8TRT8dPC2H?=
 =?us-ascii?Q?LjmCyr2jC5jFsj+Cl2Vwb46thyGZsMP0D1zt5WJ4eJJZVbJvyncpj+4EmqLg?=
 =?us-ascii?Q?bwfS4pbOkE+VmBG2JxwyjkSbCuljYM2gT7g6FB22oo9wlwsmCy+7ILQG8MwM?=
 =?us-ascii?Q?h881zlH+CFaTws0/jCmUiJXEdURz6mZsPmTxIFfFDSckZ03urSt+RZ7aBXKF?=
 =?us-ascii?Q?C1RjElkgjMZJIHlTdo/VMGU4XRDx/qUTdZHqWYkCwTGeZaSkUfjuxayKs67I?=
 =?us-ascii?Q?yZcWZcJ9QKrcbP26+JNG+/nTqmJBmUUThOKyWSfNMXO5Yvz/day+hzpPuDJl?=
 =?us-ascii?Q?2ROkGeYMo8ZfmA4DMPUuyWzzxXXZQ92LCPenjDPcp4pnwrHnd8zhoYUCxv2q?=
 =?us-ascii?Q?XHeDQNfZz141oI7es/TPdN9v5oQMTLJTjTLRJivovSRffMfupz5M1hfqj4N3?=
 =?us-ascii?Q?qiEddxRnVVPouqQSDSeyVoPNKPaYpnZegWK5yu+ldVVam+UQhjdJTtAkAYwr?=
 =?us-ascii?Q?G2DM41ZVmgtzFxDf6SK4FpFpdiN2PWCjKchZt0vDCjXMGbb0lt+qRMPlAykw?=
 =?us-ascii?Q?fHHxmtpHo3IZJzCNbosEAgqA2ZVEjNfv9efZW4J9Tc5wxCn+Dod5M+UdHOWj?=
 =?us-ascii?Q?+SWpl+56+ZuNW96o0Pob5kepmyx8pyMopx0xBPzepyuTtoTQXMMtpKs2FqDG?=
 =?us-ascii?Q?zwrLzX/obicvK19mOxRDEuRBKsf0RfJovvj4cM0Fc4Fo5/OdXIYabuSlleSV?=
 =?us-ascii?Q?PpPaH+5xTpIWMAGNUpDVvsqIBqXsywKAG6+OJ+Sd6cFxM9MAZtJKbgKQe1Ou?=
 =?us-ascii?Q?3rDhMN2lK0VLEUpI6I5uHE7mbsDWPfiTsx8haLM5GyFyBRuYwkOx+c0CMDb8?=
 =?us-ascii?Q?B851Z3eR9670MSt6QoU65VtX/LlczweHPaqLJTuaU9/AufwYT6PTHJyxgX/U?=
 =?us-ascii?Q?d0lZhIxof769+GlZh6LKFZ2nwRdkh7BUKKhyjHNRbG7rVQur6a8ZndMaw99S?=
 =?us-ascii?Q?cCoQL7CMVwIzV0zR9slaxfk5GlSlouFnot7i63CAgfdS8qpxEf7WqPH3UroG?=
 =?us-ascii?Q?DecJfIrKiDK0Yy3Bcu4i3Zj0ytndz5T3/gdwqZQ0YJ0wbbIxb2XRn1h74tEy?=
 =?us-ascii?Q?+aDe3TarZlZAHhz8UVXm/2QDmnctl6LGAZbilMxwnkkgIPU+8vIncSXsD/7j?=
 =?us-ascii?Q?j03tkCrtt0IN/wkrOpbcPnjPaYWdSPwLqepSXF2FcMYCqAl3ydOqh9TcppXp?=
 =?us-ascii?Q?NK/CKK0CCL7WhR4/O5vdAThTJFqWFnCvaiKP2t+DxsQsgg8hEHkRRKMyEfNh?=
 =?us-ascii?Q?BDA5U/dTcUc/8nRxirJxEqOycLmawJxE+rxaMTM0MgtZg7NeROdDWAD/PLll?=
 =?us-ascii?Q?cdTzrh12npTedxkVkrvi0IhEWkuYT1KogOSBVpWp/XBLsNrxvFnKUpQFCZoh?=
 =?us-ascii?Q?XrbDU0aQl/shW2es/LNLRiseKfePPvqHDSWnwurx?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 31f0e205-c5d1-4e57-bc24-08dc1252844a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 03:07:59.7556 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OSAtHY7oHR+Oht+EfN0xIzu16cCmBzsf3my3BVRds88mIvT4rtSlZm2hkUtbK1PvJjVcWsWlwZTBu7LvknsEwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5365
X-OriginatorOrg: intel.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 1/1] keyctl05: increase dns_res_payload data
 due to kernel code changes
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
Cc: Heng Su <heng.su@intel.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

On 2024-01-10 at 18:59:31 +0100, Petr Vorel wrote:
> Hi Xu,
> 
> Good catch, merged.
> 
> BTW any change how to trigger autoload of dns_resolver ?
> 
> # ./keyctl05
> ...
> keyctl05.c:99: TCONF: kernel doesn't support key type 'dns_resolver'
> ...
> 
> # modprobe dns_resolver
> # ./keyctl05
> ...
> keyctl05.c:143: TPASS: updating 'dns_resolver' key expectedly failed with EOPNOTSUPP
> ...
> 
> We consider modprobe as the last result.

Yes, it needs to load dns_resolver module to test it.
Or set kconfig CONFIG_DNS_RESOLVER=y.

Due to the bundary issue fixed patch as follows, I will send another patch to
set to 6 bytes coming data for add_key syscall for passed boundary checking:
https://lore.kernel.org/all/1784441.1704907412@warthog.procyon.org.uk/

BR,
Thanks!

> 
> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
