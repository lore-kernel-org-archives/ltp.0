Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17F29C77B7C
	for <ltp@archiver.kernel.org>; Thu, 11 May 2023 06:42:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B954A3CB4AD
	for <ltp@archiver.kernel.org>; Thu, 11 May 2023 08:42:23 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1332D3C86E0
 for <ltp@lists.linux.it>; Thu, 11 May 2023 08:42:12 +0200 (CEST)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 6E6BA1A009AD
 for <ltp@lists.linux.it>; Thu, 11 May 2023 08:42:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1683787330; x=1715323330;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=FZ2PDMfgxMvypFMUWoZ6REBNny83JmudwYD/DItVXxc=;
 b=UEaGq0Y/V1WXhVJF2Ij3XA0bexspGWzwFcAp3kx1eMSklJ7E0vxJK2tx
 kbGTPEGty2tRf5sxjvb6TW4YxZX640c/EFnm0M/uZGe5laDQQO8GNO0IK
 7JBbk0SrqJHX5TkkuOHwimZ0he+ztdgiOtZYiCLvNxvlcbPvRY1Ndci7B
 760K7WvVXKsqYlrolGUzu1EJhMYmQo87nvRIHqmmSFeEzRM14vKTvkuWF
 5SpAEYLvtlwCchQSnIBLbAy2xtFamk5Z6pkv4E2EHnCopEPl5tEC0WJnh
 EHquTT91qqDRqBGsID8+f1LohDf2eA+mf6cCI3NvGZqxQBwfiye/ArBQj w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="330035601"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; d="scan'208";a="330035601"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 May 2023 23:41:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="699589200"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; d="scan'208";a="699589200"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orsmga002.jf.intel.com with ESMTP; 10 May 2023 23:41:51 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 10 May 2023 23:41:51 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 10 May 2023 23:41:51 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.109)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 10 May 2023 23:41:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VywGEy28qsaamLUpk279WSMkPvRxs95DXPe3UT7K/4wHKUvYW+TGUmdq+fuDQpQPm0Js03KvU7R7k4V5QuWGBDA/EibDkVhw4KNFyOAsXk8/zx2B3lhlMWe2Rv0vnEzobuZcUSGfHBCwHDQkKXFnatqXmTxlx2MeL/0DURCcEmwr6soK0iK4/xaY2oxuGS8ZRoQDu5xvo/V3Y8ox0qFA2QDMJSLq6aJTPqrRXR0DmxdAUAHDymtwG3ZBcQuc0k/BMoUjiFAyhcdhqK1YQAEDHGUos9R/lZHmMRAXZWgIlDQuJP9MGGxPk15lsPfdAGLIBTSQ1CUxOhV1LB+KFaNTAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lLW455RiZipfUCDH0Ih/dwAS8ct4UhBhyIZOimHaGfw=;
 b=ZxHUJjpwz3H9M2jYNxLI7snDGz1troDc+4wNSdgwv0PFiOL/VHT+HEOIRDVlUmla7zPl4aHzrkmki3oe7+SauFTtvLmCjP86tVIXNmvnN7GnH5tdp2XanO4iAGuSG0v6BrH8XQDVl/0Skp803WwcSJcOiz4mVYlfU6hFSuUXD24XLUpv+SsMkZmRTJirIoAVQ2enNIZ7vohOV+BnXPXUCPFm16r0EAJq/POYZGYs7TVNMjHRRL2mGr8fM/u6txaTl+hwsnyPirxMp4EeQZqskPBvtBSJXQDbOF6yXkOfbgdIVsuooKGgG3gZpjWd3sdaDO3HYPRHI/K6nsjstLgZfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by MN2PR11MB4567.namprd11.prod.outlook.com (2603:10b6:208:26d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Thu, 11 May
 2023 06:41:43 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::ae77:4253:55ab:a570]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::ae77:4253:55ab:a570%3]) with mapi id 15.20.6363.033; Thu, 11 May 2023
 06:41:43 +0000
Date: Thu, 11 May 2023 14:43:37 +0800
From: Pengfei Xu <pengfei.xu@intel.com>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <ZFyOmTPHVgRL2TdA@xpf.sh.intel.com>
References: <cover.1683274510.git.pengfei.xu@intel.com>
 <efa47acd652c93a54fb66e17183524b54e561533.1683274510.git.pengfei.xu@intel.com>
 <ZFo1hUZCCXbfhEXY@yuki> <ZFpTIVcGoMTKyRCD@xpf.sh.intel.com>
 <ZFpUW8OAYPVViMBv@yuki> <ZFpYNARm7y4b2QBl@xpf.sh.intel.com>
 <ZFu2TXDwVRfe8RNj@yuki>
Content-Disposition: inline
In-Reply-To: <ZFu2TXDwVRfe8RNj@yuki>
X-ClientProxiedBy: SG2PR03CA0113.apcprd03.prod.outlook.com
 (2603:1096:4:91::17) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|MN2PR11MB4567:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d73fc39-a802-4f0e-4bce-08db51eac8bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6bJ9ikZYByK3hv2MEZJTFxY8gkaxfhYdit9e/SjjO9gbvRJ0rGDHvKiFSo0ZPvvhaZIbAyYwORw7T87TqmBRCt66vhe/Qn1jlasf8uZo7nr5U36LogSUDi96dSOeswgk6tj2BxZT6dpEyi1vMz0rXRaZn5erVVLLoj1HvCdDcgAw+WbC6/+Hz8BYmQHm/70NRJ2ugf0lsa2VYu5ZP9zeCqm0p5nLb7PgXUuMxYOT8yMrODhDbBsBRfzaDyX34ADz711tlvdyx740GdvWXhNRFGnNnuFOjTBd75xS1PsH2TFsZbt0uHgpTHwTeLCCuOEnpB9KemSS8rzn2GVaNQIwo4XCqRVRnyyGfI4zkbZ5GsHpJNIeST/Z9K0P6WApP/M/aioccZVveKwiegiKqZieQ9HNmhL/nXGafgsXMNyK5NFnQR+9sB3DqMa2QXPuKTjyuh1v9LZf+JXWw8h2CjJW6P8EYZ5b8vElYz5VoZIpF14eLg0zcyibY8UdDYMBz3UsZez8C6tDN3xlBZvtq7EpNGK4kabbXWNuRtfDlPX85DfZRd+Ido4f9XR/UrYzu8af
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB4839.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39860400002)(366004)(396003)(136003)(346002)(376002)(451199021)(478600001)(86362001)(6486002)(6506007)(26005)(6666004)(6512007)(66946007)(66556008)(6916009)(82960400001)(316002)(4326008)(186003)(53546011)(66476007)(38100700002)(41300700001)(5660300002)(8676002)(8936002)(44832011)(4744005)(2906002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YKAtrPup0Lt0JEWgrvqtFblgbNSq5aWx3KHmB0rzzSUNDdqg8FUPZYjdI+d0?=
 =?us-ascii?Q?t0pR2OpJ1ioK2LsKHrUO7dFIwZ/zkFtg0b14kfSU398jx0tdtY9CYVfytpD3?=
 =?us-ascii?Q?Wqa6dLXUmfv8uxbkbkxQF5Z/E6aEL0qQg1hTNT7cWC3m1tVQRA06LMv6MXhK?=
 =?us-ascii?Q?2b5nZeQ8NWR7hsRtfhZD/toANZPQfcrU9T0XDrQCzKECRFybC5hOk2kpcKLF?=
 =?us-ascii?Q?MASY4+cHQhkYFgmdlB1+G/chmmlOYDwjIk/qeaX6YfL9sptHbvmqskqybA0y?=
 =?us-ascii?Q?ZuAz+D3pSavKOCUxWo6N/d94w+JlcmxOtn+81jJ82bH364DJY4SKobgklp/j?=
 =?us-ascii?Q?16lvdzizXGvvbRacPUTD2hsLgaafFITlNGpyzorMOunfojnkHbYViObzGm9+?=
 =?us-ascii?Q?Nsx7eMdNvWORCA8TqGangeDafOAwaVbUWdmt5i7jLLuZz0YqFTgXY9T0G/pl?=
 =?us-ascii?Q?v852l4YarB6OSow8RK38nEFmM92Kzc+vwm3Qp+vrFfa52qjIsMpRp4pAqyiK?=
 =?us-ascii?Q?VqBmLNOuT0c6fL5kJbU1UhEr2V8AJofhAP/ztq55YcuGxNZ5dGeTNYw12cjl?=
 =?us-ascii?Q?3EJf9Tf5A89ybEEDdL56I53G9ffKJnGjCt8imlgBj0g7naerOhkWtGBDsMv6?=
 =?us-ascii?Q?W2baJX3tl6zIJwY/YT4l7SpezO3shPiE3/iVsaYMaE3CcI9sDhwd/wuUnjZW?=
 =?us-ascii?Q?YZFmvMRfRvQLDBfYbL2g/AfGgd13RAFuE2wQ/BZ/y6HB9tfYSkHWWHHVtLZL?=
 =?us-ascii?Q?IBnDsLjiGhHvmvykYXNXRWaOd1yQEcJuWN4R7Yom4KYHe2Q9PsYRae/EwYa8?=
 =?us-ascii?Q?AFokJ1SHy+7215Mz4nOIy2LmM4OSFfBvbWU60pn5JWiBZHLWT+xKE68nmkqk?=
 =?us-ascii?Q?o7AgZg2hB8ro8WcFB5+lt/Pa0Ruy0LeQ9vlsags1kj6ovIjIpNvgRyZwunYA?=
 =?us-ascii?Q?cXcjl+X8rLyFhKUi+PV+zOyIavBNPp7z11NUiYuN5Gvfz6kI12LJPvewxHEF?=
 =?us-ascii?Q?7BWMMoLtqL45/eV9vxC8J+7EY4F8ynnlR5xrYq2c+ZFe61DiYBiR+iP8deQU?=
 =?us-ascii?Q?H2K3rZ+gwprTctja9m/Q9L7ho2b88W4CbsnqhUA/QOKtfXcnBSTM/Nzy6TVM?=
 =?us-ascii?Q?pbk16oYv3dpd25jZ8BycsTBI+TuwFLZloSM34EXWg3coegMd/aP6jlvVrokf?=
 =?us-ascii?Q?/ICJ5nkchyR1Im6+Z2lDemwZN4N9rBp0VpfM5zQVSw7u0xHd1p7yZoSLltNP?=
 =?us-ascii?Q?a6VthO1XrzPfZbgobR78w/fhgJ2VlSIxdxzvMWhB8GvVr5See9PNq+7xSyy0?=
 =?us-ascii?Q?RgMMAgtqUTR1Z4BSyhF5uIdP+N8ZJFC+nfufywFSpFjyFJ6j3pB4bnJR5WKC?=
 =?us-ascii?Q?igeO6jcAGJaPH1b20lkB6WStLozruyMkJPQJSoSup6E6jQ5rG2jBStosDuyi?=
 =?us-ascii?Q?Ama8zknQbFtsFkyL3FpqavM/8DGpHmdE7r5HYmeU2rd8CVBoD7/w2YJBa03X?=
 =?us-ascii?Q?arbnWJ3VBhss6gjrSf6adQrsjnpbgDHpFKEntxRuyNH1oZP6E0g6q4TJLzXq?=
 =?us-ascii?Q?bHt8Pcmhrj2qdpBRwxuPPT/dEJtHAHS0HmNJ2pK51cd/RZCfpvLwK+jTqSUA?=
 =?us-ascii?Q?vw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d73fc39-a802-4f0e-4bce-08db51eac8bd
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 06:41:43.7149 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G9KDEWdc2AQzUMAJOUZt4w+z+uyK5atFnXOqkpMAVkYfamwGqHJIAlGdNYZUrOzB9gVgozbw58U9rwsITYoHDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4567
X-OriginatorOrg: intel.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 1/1] libs: libltpnuma: Fix one fake failure
 when CXL(Compute eXpress Link) node memory is not used
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
Cc: Heng Su <heng.su@intel.com>, rpalethorpe@suse.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 2023-05-10 at 17:20:45 +0200, Cyril Hrubis wrote:
> Hi!
> >   Yes, below patch works well and as expected for all nodes memory check now.
> > 
> >   Below way is better and correct.
> 
> I've pushed these changes along with your description, thanks!

  LGTM, it's great! I'm glad that this issue was fixed.

  Thanks!
  BR.
> 
> -- 
> Cyril Hrubis
> chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
