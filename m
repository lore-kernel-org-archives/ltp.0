Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1E51C46CD2
	for <ltp@archiver.kernel.org>; Tue, 23 Jan 2024 01:29:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E1AAE3CE3AF
	for <ltp@archiver.kernel.org>; Tue, 23 Jan 2024 02:29:31 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 60C193CC987
 for <ltp@lists.linux.it>; Tue, 23 Jan 2024 02:29:12 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=192.198.163.10; helo=mgamail.intel.com;
 envelope-from=pengfei.xu@intel.com; receiver=lists.linux.it)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id AB5C960096B
 for <ltp@lists.linux.it>; Tue, 23 Jan 2024 02:29:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1705973351; x=1737509351;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=wf53HYRGhBu15oZhI7gm2cqu6W8dmG5qijb/LshXF0o=;
 b=HLr1aoIgyUhfCpDxOn8qZvnifsBFYhrXURI2N/1C+VUI+JBODOT16Rin
 a0p6OuC4qd0NqhJuLQsV8BUdnNg6YvjzQZ7ZuzqzT7hHMs1Fwn6MUhPF4
 30BBIHCyQ0WG1qEgHKkoJsQOF1FeR+FB5jBRkXGDpaq8sT6LP/8QRP6iB
 Qfm9Jw6afJaGq16EhgIg+Y7lXSHkgu/K6KM0ZnLAOAvOuNNmHaG01L1Ps
 SG3weocKtFGjo5bhs5ual2/gq0DkLmwWU9hGqeUZy4raVw1V51mbMacMY
 /AdI6ciEU713PxMzlv4oZr/Z/k0ZJCtm7d9eO8BsMUUqM8pK8LtnWXjb9 g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="8777243"
X-IronPort-AV: E=Sophos;i="6.05,212,1701158400"; 
   d="scan'208";a="8777243"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jan 2024 17:29:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="958942803"
X-IronPort-AV: E=Sophos;i="6.05,212,1701158400"; d="scan'208";a="958942803"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 22 Jan 2024 17:29:06 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Jan 2024 17:29:05 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Jan 2024 17:29:05 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 22 Jan 2024 17:29:05 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 22 Jan 2024 17:29:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FSJ7r1IbuUUqhwZ0l7agdzBv7mYYgYFaHVAr6VPIvXyJLbug17Hzims4ROLlAbeOb7VT0dNWdp4lE8mBza4PgYrjV1NXB4WLZZ37F/JL0zvlnWRgscwiEUH3FM7YnukNWNmmJiqMSFvNECkJtoPofhGMZ0pEtii63Ufe6LucvGDpRoNLC+QV8m9eS5AVQ2QUlbqA9ojB1UQguT0dVv3Kj9b+G9HHLaf8em4HPsnEOrDtWUSZ7LV2bjqq2uFa+85yUmc/aOQ0GAZY3ny12Sy4xFLCHrvciMcPxGU4CFWVqiIifC13Ji2eKVxDe57Iu9S+n/f9iej1zff66CWY4RKbqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r7Re2sKmKpfIxZ+wCc8VeSuYM3NB4+OlMeue0dx7TJ4=;
 b=Lo242r4+2rfMye4k9iX0p33SEShgywprRZbSg1lALWF68UofM2/WiYv3C48tWza6GR1069LY8cAwmcxSgjpHCW9n4PkMVXSX/rC0psBmnSDdyQzJVDwG8VM7peGGVxfTXzdqUU86sBB8wdoItHIKqz2DOPDjrvTfm/4ahjw64hMUP6vi/ckUq5TTHd+pFv80N3H91MiyDvALPVpLUpTs1aNE7BDuvrh3W2kDCAuFRDkJO+Q786kbllIXaJRs78HL+SRsYGGPmSkWP6X4RFsorKVxFv9o1ctlKEtASNJKFCo2RO5oiXdTsrkyxL3ZL9PTZ6SMd3h3SOJ0PJhGguQaFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by MW3PR11MB4650.namprd11.prod.outlook.com (2603:10b6:303:54::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.34; Tue, 23 Jan
 2024 01:29:01 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::8cc7:6be8:dd32:a9e5]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::8cc7:6be8:dd32:a9e5%4]) with mapi id 15.20.7202.034; Tue, 23 Jan 2024
 01:29:00 +0000
Date: Tue, 23 Jan 2024 09:23:38 +0800
From: Pengfei Xu <pengfei.xu@intel.com>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Za8VGs4SDvKc0Xf8@xpf.sh.intel.com>
References: <cover.1704949719.git.pengfei.xu@intel.com>
 <48efcb1293a682182fc5db23f01be7af2889e26c.1704949719.git.pengfei.xu@intel.com>
 <20240111100949.GA1895489@pevik>
 <ZZ/eCt9jeCNYMMff@xpf.sh.intel.com> <20240122182228.GA111853@pevik>
Content-Disposition: inline
In-Reply-To: <20240122182228.GA111853@pevik>
X-ClientProxiedBy: SI1PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::19) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|MW3PR11MB4650:EE_
X-MS-Office365-Filtering-Correlation-Id: f2185030-6a77-4456-bd45-08dc1bb2ad69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c5wXvB9EkISkFrnw+N+KLov0BovzOj7uozyLZMRumY/sRYelbbHBjbFD30HXiyu1xvn0LWPfzh0xdLR6WjpXTrf5lyQ1yhc2BlU4E3jw4ElSnWsVek4ETtwgGdDeDXncX/45ieX9ZGD3KazDfd+S7HfuOQb59dLx9MAzNOVvQXtNNCg9ym206TIb17jisiiWJyz2SYxGTff1SllJiZAyXZEHTxmAdtkugjTm05HUol7oAAcWTth8YYelo3zORnhi/eXysBJ/PY9LPhZ+Oui0k88cuEbxRo7lryhEZKdVTZ0O1QFbRZcnVdmo1FZHBaNvc+0lFFrpg01S8ZKYfBLtrufikBCl7DQQ9yVpemE95peBoSjOx34Vt7zjzVbDchj2Gm9aZmow9dHKo0bESQfdEwSSw2rbVmOuvWqWnwe9XP+kzheDuwNEd5pY3v9TRJ0ZwAtMHFVb1SfwpXfHJ9Rnzf7FuHgi2bUY7K9RF28OyDHPe1L1cVLElr9JubL11nwAUKMLKg53fZ6t45P+zrUHdm4sWmwVIzlh+4omKupXzRI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB4839.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(39860400002)(376002)(366004)(396003)(136003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(6666004)(26005)(107886003)(6506007)(6512007)(53546011)(5660300002)(478600001)(2906002)(4744005)(44832011)(41300700001)(66556008)(6486002)(966005)(4326008)(316002)(6916009)(8676002)(66946007)(66476007)(8936002)(86362001)(38100700002)(82960400001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9OBZTBXQNWbQu2fN9xWIrhrx/yj96A+7j3OpxlZhGf8yGZyMhO66ZRMFLuXG?=
 =?us-ascii?Q?DxgUWM3GYVeqbtYIqcCX5yUTYnxSL6ggn+RGbmip35R9j2VI0e8GNEFZm3j/?=
 =?us-ascii?Q?4IpLm7yCgPsPBrPCbvmv4jGWWWRUr26/8/qn5ksCKoJCzH4DSJRUARHl3xZo?=
 =?us-ascii?Q?bZKFZAIrXCPGdTWWi48MLleA4qZ06E6w0riFfE9NjXWSQgPwGH49yoUBMc8g?=
 =?us-ascii?Q?9M7ZzLIslGI5YFDOJtD6jDjEHQ/F3ITvnsqaUZ1EgJRjL34OMIHLwvtxp7OA?=
 =?us-ascii?Q?R7NdyrECdaIUT6Jx5cXse/ACljOGKm4lK+wta0ziSwhARPJ1ul+fwIsz42F7?=
 =?us-ascii?Q?WkmbR43C2FmPO+vfnKhWC6lTP36rxw76jZHoViXDyM+5YsOiv0ygGQpbK1ee?=
 =?us-ascii?Q?qpETjfCK1E4GjY9EXKja6DYz+UIGThD+D6K2MKRg494h9JJCLXkquhovYUK4?=
 =?us-ascii?Q?KixRX5DMv0oPW84DD85/1qjQRgunzWNwD1SntTIKF/DacZ+XalreZB7MnBma?=
 =?us-ascii?Q?ktLNk/EeK2UQiD49ydd31JIjGoOgPyxTG6GS69zpRkkE+YbmtVcpn0TKXZkP?=
 =?us-ascii?Q?npOU/MhSceOjUSgLASfuWWwlLX7gfIR7LZakU1KLBEBQfVSrtBeyMxoL4QvR?=
 =?us-ascii?Q?VPfLmHYbRVaTw9Zo8OhKS+YABq+G5h3drAGPUJARAWbG41DReVB7aGdVehg9?=
 =?us-ascii?Q?T5RhZ56Evh+w/naJPXfdegIsqvEjpQahffN+L1nqUHeTEeAtkxOznH/VFE+Q?=
 =?us-ascii?Q?i/N8TfX8nj3NWzIXh/vEOqND6JDBJQXJ7JxLvo9ol+VaoR02Yb7zxdTdkFmc?=
 =?us-ascii?Q?oLxLg7ZtvMKcH/XfYjCxatIVedRqIW0nGg0+Gnfv5z3zaVV+h7Cwc/gZ6Yff?=
 =?us-ascii?Q?nfnW/+0LSFmSmZhgYeV8e4OwoIm75CI5rgdaR8uLMz3EVnW0qVZqmlwy5Dv0?=
 =?us-ascii?Q?zqsgDDoyTDibuLuMA2B8EQMq2Jz+KsGiIUDLSPo6FEQkq73qi9s2bbweOQBv?=
 =?us-ascii?Q?+DXmWN54lnxmO6rTMnaj+uf3Iq2qBw3PNJhNXF+MGHoUmkMhXlqszBedJ58M?=
 =?us-ascii?Q?FTugTWzKuX5izJtG0UuPpBxysMBieWyr6N6Dn8yeBHWmVMkeUvvxgo3kjgfr?=
 =?us-ascii?Q?kv2a6GO1+cglWSybyFeQTjmrAHNDsqiZ7ue0O4Z+YqoGNx6yWNV/XUaRaxQy?=
 =?us-ascii?Q?skxaMt5Zi1CdXPqpcr4yo5xFtzGTi9Rr+OgJW+fT8C89nUcBEjzFuD9zCxsL?=
 =?us-ascii?Q?qf5l/scIc8s4EGHgJm9MUF+OWWIk1CojjFtqJEpBdZxoSrXSLhxHVO26ZZHX?=
 =?us-ascii?Q?PnGziTBJ46epkFRweyhc25s82KLoT+OIvUQIhvFoDJ2/alDaCpjKtmwOmd3J?=
 =?us-ascii?Q?Z64FRWTgTY8DcIdjVyItgzecbYMMVQB1qOxhQCq06N2cJ4/mIZeMm4GoBJd6?=
 =?us-ascii?Q?jikUTM6pMzXTFF+FStLtuLkE/eUJJJKmZebLTN+MCVqhYG/9k/lbRbq6Cob1?=
 =?us-ascii?Q?9ycNgj4hDpC0R1H3slFnwWSH5lrJgCbrGRDu0u6SoC5cPsIoahvMwqC5A95z?=
 =?us-ascii?Q?oX3jA3vn6u96S5yATpN9Whro6dKFpLHkNm0Q8aW2?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f2185030-6a77-4456-bd45-08dc1bb2ad69
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 01:29:00.8742 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LCf8g8LoWchLLJdff2uvaBD42bjPyUX67jfeuPG46IZBMoIAAKoa7m8bpNooipnH7nV+q5xz3GtRRkKP04HPUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4650
X-OriginatorOrg: intel.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 1/1] keyctl05: improve the dns_res_payload for
 boundary testing
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

On 2024-01-22 at 19:22:28 +0100, Petr Vorel wrote:
> Hi Xu, all,
> 
> fix will be backported to stable series: 6.7, 6.6, 6.1, 5.15 and 5.10,
> it's not applicable to 4.19 and 5.4 stable).
> 
> Therefore merged. Thanks!

Great, thank you for your info and remind in community:
https://lore.kernel.org/all/CA+icZUUc_0M_6JU3dZzVqrUUrWJceY1uD8dO2yFMCwtHtkaa_Q@mail.gmail.com/

Best Regards,
Thanks!

> 
> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
