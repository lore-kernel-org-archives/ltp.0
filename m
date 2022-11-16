Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ED93C433FE
	for <ltp@archiver.kernel.org>; Wed, 16 Nov 2022 02:17:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 813383CD1AA
	for <ltp@archiver.kernel.org>; Wed, 16 Nov 2022 03:17:14 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CED233CA330
 for <ltp@lists.linux.it>; Wed, 16 Nov 2022 03:17:02 +0100 (CET)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id AB85560096E
 for <ltp@lists.linux.it>; Wed, 16 Nov 2022 03:16:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1668565019; x=1700101019;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=sw+Xc76dhFOrY+5r1dTZct4BqCcxn53jYhqHa6ogNLM=;
 b=UPTh7LOEsEnzq3mHXw1Rc1+SqTFCQZoGrhg1E7pZI6BJJKLBR+IjrD3J
 lulp8zciccwjAmuDeGryyhfWH3SPjpQsUKbOlL+yO+L3wxn8OuDuVXSVO
 QlxtLQZ3QoxFycG3wwOWr8fMKbQUTFoJ/w1iMnVWBMLC/NNOAcqZeERP6
 xMYA+QDcpFRmQPyRdpwQ4KfVBZT4v+zfohkOCdfyPgo/SpMi5M8aic/w+
 Sb3UjmNbtyX+/SNUeYvXmmc8pxXUPzALDGvGa9lVl37osz+Ye7vb0AAC6
 rltTTmaMd1u7Bo1eHkuZjTj3KgbdEqRdMMHP+kXFdeDs7E2yvgyIB9/Bw g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="299951299"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; d="scan'208";a="299951299"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Nov 2022 18:16:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="884202050"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; d="scan'208";a="884202050"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by fmsmga006.fm.intel.com with ESMTP; 15 Nov 2022 18:16:55 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 15 Nov 2022 18:16:54 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 15 Nov 2022 18:16:54 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 15 Nov 2022 18:16:54 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.43) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 15 Nov 2022 18:16:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LELnH4iImoWqffB605oyO0viVev64+GdL/iH5yisE7S+Q5tuBe59qfaA9MzZCnCV0JnvqvDBfTVqkr0EBLo+37Dss8t8xqAEZmM9kfoR/EfJxtyYLahtVijuFDvraWtFGmqrGyT9frN068LBYkv+x689C9PEf3qz5pqKuGwv95C9YLekm8FPgxMqmoZjc8nd6I+1fI1YHjz7WAExuJWfZu17+QW8Zeu2RWU2S7VSUTKk+Px9P8GRxyb9Jxb2F2F/77O+qNW6MXWQgiQQyIIzBEKHr5CL6uahI3mWSKU7Xocve8hspsyV/FSEKLlSq4Z1Xx6AmXvN2BV/ZMfwANWhSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fb+Bm4lVoNbhZe5cr3PyYcwV8UxJFekU2jivMaDEwOo=;
 b=Fho46yOey0BMhrb++5W+kkjPnBU8hOsvHKwf4+wlb9Oh0LlLbB/004K5IOSxAbF++k1ym0A5ouPvrcIz3L/ef9xzizgzkvSIBffkv82SYaU93X/DgfFvhLm4YuS9XnoEQc+WeGmoBD48KhXW7CRGWJDHRqUuNfLLnyz1PPUtv4abll6T2VimJo5+o4qTk1Z2QTTneH71Q66S2IjSfdqEFZ2dEjUNI8pC/iGyCzEV1U7oqOtXzsbtdPr3Yp7g3CVXAIAUhBTXPNUCZF2fT/pM4HRPX7QDocIFjmCM9z6ylNx7fD2txhd3KnZ09QXHKtZbyobU/yvTzau8hlBd3k8fTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by DM4PR11MB5440.namprd11.prod.outlook.com (2603:10b6:5:39c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Wed, 16 Nov
 2022 02:16:52 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::78af:67f1:f3ad:a5]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::78af:67f1:f3ad:a5%5]) with mapi id 15.20.5813.018; Wed, 16 Nov 2022
 02:16:52 +0000
Date: Wed, 16 Nov 2022 10:17:14 +0800
From: Pengfei Xu <pengfei.xu@intel.com>
To: Jan Kara <jack@suse.cz>
Message-ID: <Y3RIKsBUx+KiH4lD@xpf.sh.intel.com>
References: <20221115123721.12176-1-jack@suse.cz>
 <20221115124741.14400-3-jack@suse.cz>
Content-Disposition: inline
In-Reply-To: <20221115124741.14400-3-jack@suse.cz>
X-ClientProxiedBy: SGBP274CA0008.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::20)
 To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|DM4PR11MB5440:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a32d83f-b579-4fb6-6897-08dac7789fd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qK0eBhKeI169JH9zFyM/oLbWHBxbwO1qOaiHyrSqPYJL322kt3lhW8/7wuYee+wv65EAZFVpZhs/p9BlQQ5G/t6QlIDu9S3q8ghjo2ZeuHKBVz3mel+bmM7WODTQ7SeBS1SMdUqPO2tC6aP2ZcLQzKV3DFlo4zpUm/t5pqoFqooIOvFqZFefYMxDkyvBLdHirg6XyeDFxMbeGwf5oJyg57bvRWAUCYxrfYaPteaRXnrFGyfYtgMH7UlPkbwlwNpwOewLyYtU2gztzQN+5vPcztyykM8JbR6JSdRAAX+CTu1WhtTwjfoPDSkpQU0V7uQu0izx4oNmTTI5YxAmyz8NCBYiRtD9IOd7USgitdDp3N9LJuwji5DzAKBTu6cwefEChl/bQG3wHgv6EaIb9HO0vqQqvsys3kazGIzClRowEzZaVYgAd+oR7GMr8NUuxJr1T3QJSw9fue24ibaGUpxrL5OLGbX9XAcPZ08hWjoNSshUat2LqdFPILJAtJPVlIvEDBdP4QITHeANsTe6maTsgkvOYTkPQkwgEjgUKeReh4A+EUf8gqK/BXCvLO7HqLwzaL75RpvkKp1YhABDcsKy/E4sDt+L41roQGZ2F/pK7f1weg07HM1u7DxmOmEBVHjt8Ylo33hO4WyZrjaRFe2RE3lj+mUlmiT96mev6oMHeIhFVAyW8rQvMMCBI8wHhCjZT6nAYaE/kcYZS5vfFQMePdHnbyOvp37+yowEBW88+g47xk5C35XK1Dz+dbX97OcuuMBwOahc364hKHk/NJu4PQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB4839.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(376002)(346002)(39860400002)(396003)(136003)(366004)(451199015)(316002)(53546011)(8936002)(8676002)(186003)(6486002)(4326008)(66476007)(66946007)(66556008)(6506007)(5660300002)(83380400001)(26005)(6512007)(41300700001)(82960400001)(38100700002)(6916009)(478600001)(86362001)(44832011)(6666004)(4001150100001)(2906002)(67856001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?x1f7U+5K2lTzjv/brtz1u24eR2PqvVlUu4csxSQvOt03ev7+mpEJoT1w5msC?=
 =?us-ascii?Q?MBnEjkv6M4TP4iIRf5yQVE3H80lL0CtQzIECrp9a8MdO5T0RDCWW0brDoTAG?=
 =?us-ascii?Q?QIicvylo1XMZ+zUjTVkFQS5tRR8kTfTEHd+oFEuzYbA5GbJVy1mIN20l6udP?=
 =?us-ascii?Q?zml8gvzkxPKCzNDG2/vw3BLqk0IsyM8CzHHjBljV0bh1C55A0Kh5TEaHnf9w?=
 =?us-ascii?Q?0hfiOi/sXyWzK2Z6XWUZtXS18py3tbSDR8T98UywZReoXlYViuE53/G6pKOJ?=
 =?us-ascii?Q?zuWppxjICaI5Efy0DEQZALcWqHpMq83tlsc1b3tA2SVDtsXyU6ovDmANmcqW?=
 =?us-ascii?Q?B2tQ0hgxDvbqibKffEe/GAeA27tpKXuaA2OY5Z2muQhaKzgYyIRbwX8ajJGG?=
 =?us-ascii?Q?Vlu7T2bAuIhWr71BiGYJaOCFQHe7Wrv7aQENphWjGuG/83TXp2ApU88AtWEy?=
 =?us-ascii?Q?LH304il4/pzy3/Dk9xamCtj7waOeQZCsL6rFO/QgL+4Sr5MOXPd6IONHEKNM?=
 =?us-ascii?Q?q8fGwhJ/4ITWVUHdWtJWvpp193wtIGfsTL6zIrcbC1W9CYVrZn7ZuEbB+gTt?=
 =?us-ascii?Q?uDC3YenrJnPJQeHDXW3CCvJ1CCz9pkvDTRa3Nv+D0KU0yXcEsnW2yQHbqwk7?=
 =?us-ascii?Q?eZObqjg0bUK0GgEdRAPPLwFQrppc09ny80qdSplc7fFyYyScVSB84WRu6qm2?=
 =?us-ascii?Q?+oNSxPg67gFTxZTp4q4hD2EdF/4fsj5ehA4LESgcb3ooUgydUgjaUQEsBRMN?=
 =?us-ascii?Q?XGqYZZ+ia2K6LPe7RSnBfJ8ShvhPlwskI9UwQDdArYqmfqXcdoFiwlmECOp4?=
 =?us-ascii?Q?X7mWF6ieJgDlTSAXJhfNR3nk1jeCA+vt3M5QFBIzAjZi/oKty8m9vG5iyPb3?=
 =?us-ascii?Q?J+n8A665T+EEA8cWZEKqLMRlZokHD07HFSWAbGE8NYpbFWAZhCab3asEr2Jo?=
 =?us-ascii?Q?eU+pAUNrYtUHAzd7zOrSqD+b93vi7IuI6ezNloruEFZhJsfldcM/N4gTuUcl?=
 =?us-ascii?Q?31oqCTXHWTJKermvuzUmz2ennWYC+2eQxHMTile5aRXpIeNeTuEHHanv7V1i?=
 =?us-ascii?Q?wMzF6eXwTvMP8KjjZFG2esXxD24mlm86eSZrTTxySZsDV/8cv8P2XDlyBx5K?=
 =?us-ascii?Q?xUwQ9b3eTWYc4ds6+/S5BA9VJI+Tr5r6eb7R/IUsMaUOyAlAoAnkjwUxf/px?=
 =?us-ascii?Q?L0Q9iByGv4Xn8yQH83SWEXon9mXjlR2g4RVDQm5OkTXw0xs9JgI2eRqvOfAt?=
 =?us-ascii?Q?dyo4sEzr4xyqR1i+LgvbN+zQoKEiJhCQnG1qDo5dx/7BRKfBmG+s5rMHNQ8m?=
 =?us-ascii?Q?c60ddTyzF/JFJJ+VmaJyyKklaKgEU+EWgYTUGmy8k2zsahG+360JWnpYPX18?=
 =?us-ascii?Q?3Mx0gqThL/ma9HqnQFDkNelrAYBL29wBOw63fPEz5gerX5+i3OICZmPwkQL5?=
 =?us-ascii?Q?5jfHGgpK/9T2xZ/1dT18QEyPMMpeAzrXBzNK/6FRwRsTfBhbZm1H+HNP649B?=
 =?us-ascii?Q?Cu6ZMK5axsajZrPI4LVyZ4Uv7fYD5p5Xb2F/zxJcnCp6JiQZ04KhjGQfY8tZ?=
 =?us-ascii?Q?k9n5dZ56q2haPsWdVE4hIwhUZn12hYqNobURz90SErw6Hfd7AqvkNOfT0DZH?=
 =?us-ascii?Q?Fw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a32d83f-b579-4fb6-6897-08dac7789fd2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 02:16:52.1777 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mpHehF3vgtfRGZfYwykZpeuA2NYKovfm4OHzCcQrB4qkWLYeFKhHA1w5gg4c4K1EOh9WKBOSkE59eSKn2Y1Qlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5440
X-OriginatorOrg: intel.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/3] fanotify10: Make evictable marks tests more
 reliable
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Jan Kara,

On 2022-11-15 at 13:47:38 +0100, Jan Kara wrote:
> Tests verifying that evictable inode marks don't pin inodes in memory
> are unreliable because slab shrinking (triggered by drop_caches) does
> not reliably evict inodes - dentries have to take round through the LRU
> list and only then get reclaimed and inodes get unpinned and then inodes
> have to be rotated through their LRU list to get reclaimed. If there are
> not enough freed entries while shrinking other slab caches, drop_caches
> will abort attempts to reclaim slab before inodes get evicted.
> 
> Tweak evictable marks tests to use more files and marks in parallel and
> just verify that some (at least half) of the marks got evicted. This
> should be more tolerant to random fluctuation in slab reclaim
> efficiency.
> 
If possible, could you add the Tested-by tag:
Tested-by: Pengfei Xu <pengfei.xu@intel.com>

Thanks!
BR.

> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  .../kernel/syscalls/fanotify/fanotify10.c     | 62 ++++++++++++++++---
>  1 file changed, 52 insertions(+), 10 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify10.c b/testcases/kernel/syscalls/fanotify/fanotify10.c
> index e19bd907470f..cfbf4c31dd08 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify10.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify10.c
> @@ -86,7 +86,10 @@ static int ignore_mark_unsupported;
>  #define TEST_APP "fanotify_child"
>  #define TEST_APP2 "fanotify_child2"
>  #define DIR_PATH MOUNT_PATH"/"DIR_NAME
> +#define DIR_PATH_MULTI DIR_PATH"%d"
>  #define FILE_PATH DIR_PATH"/"FILE_NAME
> +#define FILE_PATH_MULTI FILE_PATH"%d"
> +#define FILE_PATH_MULTIDIR DIR_PATH_MULTI"/"FILE_NAME
>  #define FILE2_PATH DIR_PATH"/"FILE2_NAME
>  #define SUBDIR_PATH DIR_PATH"/"SUBDIR_NAME
>  #define FILE_EXEC_PATH MOUNT_PATH"/"TEST_APP
> @@ -104,6 +107,7 @@ static int old_cache_pressure;
>  static pid_t child_pid;
>  static int bind_mount_created;
>  static unsigned int num_classes = NUM_CLASSES;
> +static int max_file_multi;
>  
>  enum {
>  	FANOTIFY_INODE,
> @@ -378,9 +382,11 @@ static struct tcase {
>  		.tname = "don't ignore mount events created on file with evicted ignore mark",
>  		.mark_path_fmt = MOUNT_PATH,
>  		.mark_type = FANOTIFY_MOUNT,
> -		.ignore_path_fmt = FILE_PATH,
> +		.ignore_path_cnt = 16,
> +		.ignore_path_fmt = FILE_PATH_MULTI,
>  		.ignore_mark_type = FANOTIFY_EVICTABLE,
> -		.event_path_fmt = FILE_PATH,
> +		.event_path_cnt = 16,
> +		.event_path_fmt = FILE_PATH_MULTI,
>  		.expected_mask_with_ignore = FAN_OPEN,
>  		.expected_mask_without_ignore = FAN_OPEN
>  	},
> @@ -388,9 +394,11 @@ static struct tcase {
>  		.tname = "don't ignore fs events created on a file with evicted ignore mark",
>  		.mark_path_fmt = MOUNT_PATH,
>  		.mark_type = FANOTIFY_FILESYSTEM,
> -		.ignore_path_fmt = FILE_PATH,
> +		.ignore_path_cnt = 16,
> +		.ignore_path_fmt = FILE_PATH_MULTI,
>  		.ignore_mark_type = FANOTIFY_EVICTABLE,
> -		.event_path_fmt = FILE_PATH,
> +		.event_path_cnt = 16,
> +		.event_path_fmt = FILE_PATH_MULTI,
>  		.expected_mask_with_ignore = FAN_OPEN,
>  		.expected_mask_without_ignore = FAN_OPEN
>  	},
> @@ -398,10 +406,12 @@ static struct tcase {
>  		.tname = "don't ignore mount events created inside a parent with evicted ignore mark",
>  		.mark_path_fmt = MOUNT_PATH,
>  		.mark_type = FANOTIFY_MOUNT,
> -		.ignore_path_fmt = DIR_PATH,
> +		.ignore_path_cnt = 16,
> +		.ignore_path_fmt = DIR_PATH_MULTI,
>  		.ignore_mark_type = FANOTIFY_EVICTABLE,
>  		.ignored_flags = FAN_EVENT_ON_CHILD,
> -		.event_path_fmt = FILE_PATH,
> +		.event_path_cnt = 16,
> +		.event_path_fmt = FILE_PATH_MULTIDIR,
>  		.expected_mask_with_ignore = FAN_OPEN,
>  		.expected_mask_without_ignore = FAN_OPEN
>  	},
> @@ -409,10 +419,12 @@ static struct tcase {
>  		.tname = "don't ignore fs events created inside a parent with evicted ignore mark",
>  		.mark_path_fmt = MOUNT_PATH,
>  		.mark_type = FANOTIFY_FILESYSTEM,
> -		.ignore_path_fmt = DIR_PATH,
> +		.ignore_path_cnt = 16,
> +		.ignore_path_fmt = DIR_PATH_MULTI,
>  		.ignore_mark_type = FANOTIFY_EVICTABLE,
>  		.ignored_flags = FAN_EVENT_ON_CHILD,
> -		.event_path_fmt = FILE_PATH,
> +		.event_path_cnt = 16,
> +		.event_path_fmt = FILE_PATH_MULTIDIR,
>  		.expected_mask_with_ignore = FAN_OPEN,
>  		.expected_mask_without_ignore = FAN_OPEN
>  	},
> @@ -864,6 +876,8 @@ cleanup:
>  
>  static void setup(void)
>  {
> +	int i;
> +
>  	exec_events_unsupported = fanotify_events_supported_by_kernel(FAN_OPEN_EXEC,
>  								      FAN_CLASS_CONTENT, 0);
>  	filesystem_mark_unsupported = fanotify_mark_supported_by_kernel(FAN_MARK_FILESYSTEM);
> @@ -880,7 +894,24 @@ static void setup(void)
>  	SAFE_MKDIR(DIR_PATH, 0755);
>  	SAFE_MKDIR(SUBDIR_PATH, 0755);
>  	SAFE_FILE_PRINTF(FILE_PATH, "1");
> -	SAFE_FILE_PRINTF(FILE2_PATH, "1");
> +	for (i = 0; i < (int)(sizeof(tcases)/sizeof(tcases[0])); i++) {
> +		if (tcases[i].mark_path_cnt > max_file_multi)
> +			max_file_multi = tcases[i].mark_path_cnt;
> +		if (tcases[i].ignore_path_cnt > max_file_multi)
> +			max_file_multi = tcases[i].ignore_path_cnt;
> +		if (tcases[i].event_path_cnt > max_file_multi)
> +			max_file_multi = tcases[i].event_path_cnt;
> +	}
> +	for (i = 0; i < max_file_multi; i++) {
> +		char path[PATH_MAX];
> +
> +		sprintf(path, FILE_PATH_MULTI, i);
> +		SAFE_FILE_PRINTF(path, "1");
> +		sprintf(path, DIR_PATH_MULTI, i);
> +		SAFE_MKDIR(path, 0755);
> +		sprintf(path, FILE_PATH_MULTIDIR, i);
> +		SAFE_FILE_PRINTF(path, "1");
> +	}
>  
>  	SAFE_CP(TEST_APP, FILE_EXEC_PATH);
>  	SAFE_CP(TEST_APP, FILE2_EXEC_PATH);
> @@ -896,6 +927,8 @@ static void setup(void)
>  
>  static void cleanup(void)
>  {
> +	int i;
> +
>  	cleanup_fanotify_groups();
>  
>  	if (bind_mount_created)
> @@ -903,8 +936,17 @@ static void cleanup(void)
>  
>  	SAFE_FILE_PRINTF(CACHE_PRESSURE_FILE, "%d", old_cache_pressure);
>  
> +	for (i = 0; i < max_file_multi; i++) {
> +		char path[PATH_MAX];
> +
> +		sprintf(path, FILE_PATH_MULTIDIR, i);
> +		SAFE_UNLINK(path);
> +		sprintf(path, DIR_PATH_MULTI, i);
> +		SAFE_RMDIR(path);
> +		sprintf(path, FILE_PATH_MULTI, i);
> +		SAFE_UNLINK(path);
> +	}
>  	SAFE_UNLINK(FILE_PATH);
> -	SAFE_UNLINK(FILE2_PATH);
>  	SAFE_RMDIR(SUBDIR_PATH);
>  	SAFE_RMDIR(DIR_PATH);
>  	SAFE_RMDIR(MNT2_PATH);
> -- 
> 2.35.3
> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
