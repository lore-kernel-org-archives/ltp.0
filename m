Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00853C35FFC
	for <ltp@archiver.kernel.org>; Tue, 25 Mar 2025 06:53:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 457B43C933A
	for <ltp@archiver.kernel.org>; Tue, 25 Mar 2025 07:53:34 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5932B3C19FD
 for <ltp@lists.linux.it>; Tue, 25 Mar 2025 07:53:15 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=198.175.65.15; helo=mgamail.intel.com;
 envelope-from=oliver.sang@intel.com; receiver=lists.linux.it)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id DE9CB10002B2
 for <ltp@lists.linux.it>; Tue, 25 Mar 2025 07:53:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742885593; x=1774421593;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=fBVuD4HDVRkHwtZaq/khXQN64vv8Xceh8+0qJh1zA1g=;
 b=Wxh8x1oJXESl7h105ntjLICMdyO1ISV3d7SzGs/Zg3KNM+QV4+j/X/v2
 BUO3qa20H86lxDTCGCXz9kDsJlgKoAiimS7HRt5Ua9aAEz2+ijPs6M/wF
 0vbcE5YZRBrU80Kkyr77067o6spTjDlLoOKekCNs12uwSwYes0g2O3KVA
 SDZOhaM0kFHPAHaSmQIcMOFyuSRqdR+vCBGBmZ6WgtpWdYFlDiOffKBix
 vi9czKHjISPbm7GIB6c/VNEHD+HtuHJLo9UmX2Xs1WeelBdnLmpV21PY8
 39dH3A/Muk3bYktsZdBgMEm9TnGu4sdro6Dq7TYos+HSnna98vLKweSuo w==;
X-CSE-ConnectionGUID: vOMMgqttQfKywegL/Vl5mA==
X-CSE-MsgGUID: TWz7oGrYRKupGmv8xa54eQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11383"; a="47771223"
X-IronPort-AV: E=Sophos;i="6.14,274,1736841600"; 
 d="xz'341?scan'341,208,341";a="47771223"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Mar 2025 23:53:06 -0700
X-CSE-ConnectionGUID: 0QTJ52T1RfOkUtDTgAesiA==
X-CSE-MsgGUID: Hynqela+RN6S0BcWrdh3Rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,274,1736841600"; 
 d="xz'341?scan'341,208,341";a="129340448"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Mar 2025 23:53:05 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 24 Mar 2025 23:53:05 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 24 Mar 2025 23:53:05 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 24 Mar 2025 23:53:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jvxjugHKzlw+gQiecKvEoUlpvjZTQdwxD1I4dTSxU297Ot0F83azHgjbrk8HUfa784Ff0zGOOePQvRd8zIWh6Lb/sI55zWRQ98rIfXD9DLoP26O0sTIvq9ZvHQld+maA41RlS2sTQydEH9CAhVst0/5aMuDKavSQFVkAcrrxA6v4FQaP7wkq7K55szrBdnRZ0EpGzxkPInV9N9Bniqi5chQPPZayD7z1gwzRwL6NPd3pnR1TfBTgyeXn7YwFS1yI6/CGAINZlKPEffpLzufZVAnPWhZvQubolbTn08ScERT/HHXk+tMdtTFr+LBf0ReJTzw0NDi+QWgolOOb9mhj4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ws8wT9Nou4IRoxJVUkrfayk4+Jx8wwegxEyhYEFP6No=;
 b=TMLzKxBXwBEghPt85CnZF3yyr06/9l9w1FL72D7cShkvMwpca1LsE9ArNP+QJBhWve3qBwGVxHHRO/YNn34JBUi/pUHYcrYNh5XOoH6rZJZpuRaq4RMKX6Z6mb3YQxdyXsU8FM4hX5s9+kL/00njDxaO8GDKfuCR+/+Le3SFJw5aFkK2PdaX5+R+2b+R1NYuR8UiVE8uVwQWvZ06pkDkjKae9dOzE96mf/YXQZ9Meu4eyu+w0WhMsYtwyj4tYHj+1VucpDm34N6Mm59cbLT4wmhFhS5fDWnW+Jg2oam0/yHjkp4FO8fUdcEUYXdKXhhDMDff46UpJr0+bc3z/huCOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CH3PR11MB7322.namprd11.prod.outlook.com (2603:10b6:610:14a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 06:53:01 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%4]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 06:53:01 +0000
Date: Tue, 25 Mar 2025 14:52:49 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Luis Chamberlain <mcgrof@kernel.org>
Message-ID: <Z+JSwb8BT0tZrSrx@xsang-OptiPlex-9020>
References: <Z9mFKa3p5P9TBSTQ@casper.infradead.org>
 <Z9n_Iu6W40ZNnKwT@bombadil.infradead.org>
 <Z9oy3i3n_HKFu1M1@casper.infradead.org>
 <Z9r27eUk993BNWTX@bombadil.infradead.org>
 <Z9sYGccL4TocoITf@bombadil.infradead.org>
 <Z9sZ5_lJzTwGShQT@casper.infradead.org>
 <Z9wF57eEBR-42K9a@bombadil.infradead.org>
 <20250322231440.GA1894930@cmpxchg.org>
 <Z99dk_ZMNRFgaaH8@bombadil.infradead.org>
 <Z9-zL3pRpCHm5a0w@bombadil.infradead.org>
In-Reply-To: <Z9-zL3pRpCHm5a0w@bombadil.infradead.org>
X-ClientProxiedBy: SI2PR01CA0048.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::17) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CH3PR11MB7322:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ff5413c-7c01-48aa-a09b-08dd6b69af4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|4053099003; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?v6/OJTRyrYCSoJadOk01QrliVKIMwswTRC+4oirgdRhG3JBE1fbjCrfueOm8?=
 =?us-ascii?Q?Hw+45lDe6MxakxE6K4h6oQE6545uOyBFpCPf9oNecpj/gAceDgx4P5MMrZB8?=
 =?us-ascii?Q?iKuZCZ1m4TMPrnuJDDHkpllJucz5qjbekkNpTE4xMmPXUH2U84hk3aFU+3US?=
 =?us-ascii?Q?T1cXaD2vlDy4m3uDKB8/FSqP77oh4uIpH6DZok7fDASi55itp2pW74vJ/sPj?=
 =?us-ascii?Q?iy/0QKU3INW0f0k629LMXbboOvdOEWH73yYWzexJaGPcU1nhWYPf4BoZza/f?=
 =?us-ascii?Q?9xF3wf9AjJGXap20UWwwAYKWHnHWNV3dM1GxgMO2ugdNy4dyiriDI26RVA5A?=
 =?us-ascii?Q?2PSyvmEVllvZ10bfgAubbau6muXm5OJrPz6HEzj3IeaU33CDrsZt7Bq2OJOr?=
 =?us-ascii?Q?oPed+hLdAN5jZJu9Ec7CTP7H4LMP7yf/UBVqAKtg9Vkl2WSJCHigpz2BSwvq?=
 =?us-ascii?Q?8lMabyRcXzXqydNhMX7c4p3Fki0ETyJzzif+uLXelhHuQdDpt9g4Qd8XlI6I?=
 =?us-ascii?Q?bSyuPUjapYG+s4trnmJfQNGaufAf4XXIxJEVeNkq7z2/XTnkdcYsJ7OyAno4?=
 =?us-ascii?Q?F0YRyD/MPVpPblSjscLmwzchjQ0Zjb9ZaT+93akhaxid1zrPymuscgwqvKso?=
 =?us-ascii?Q?LEsasp+sYWy9HcQziEnW/1yMNvwDY3rRUW52GzcnvOyQvb99ez9E55sjeSUq?=
 =?us-ascii?Q?CDXXhHvVn5l4ExE8C04o0VLcJT+nysn1xHTFbdFdQ5kvjyJQz+T04jdP3LBC?=
 =?us-ascii?Q?8QfoH5fsflXXInxi+5EHP4LqsFHnrjapKA3mdiX8P+23krT13YzT/Um+iXC/?=
 =?us-ascii?Q?o029bqpCHpABupYNF1/G5gCg+oerjfmpMuML6wsVSlm5nC64neIv5+AhbXcC?=
 =?us-ascii?Q?GlXC3AZeH/12thqXVQyT9eKaUkNx52TBMewcDAz7S7faVzx7qjZNbrXpHd6r?=
 =?us-ascii?Q?8nDJXAFHpzPB2K4T9aWQ7IBljpTl52BLPxxNZSv3o5QmJsf/pcSbNbYLOavO?=
 =?us-ascii?Q?fa8EA+tHFXvCmI1Q0uDJYq97AQeTPX1JQW+FyBK5Ci/EMKASK9s9cdpVPRnZ?=
 =?us-ascii?Q?WRX+1XrfNieaerudfCtFu16vOG1npoZDCjNJuwvnpQFclCN9yaV2yiK1xDFO?=
 =?us-ascii?Q?RVqTXAE3SMqPk4S5PwgygNJRXa3b4iUbkWfqvRILUTCtbspDI7JvozmJkj4a?=
 =?us-ascii?Q?jNxOHmDUXzofPXBhU349NqV7TFQJnUruBMZZDzTtc5t7RP4oKJRZ2SBFNtau?=
 =?us-ascii?Q?oQPyqYBncVYuRe3zwgEhjIbZbRxOlt6j7Bx3f5/+oBukw0TcE/uKR9gdN9GH?=
 =?us-ascii?Q?C9KzMGxh0TajaZWSM6QIOWhaDJUs0DteW9o6RXsKUmkMld8wz1rJU6y21O5c?=
 =?us-ascii?Q?jnoSYKI1sn1ix1haOlANkteeGeug?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR11MB8603.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(4053099003); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bHlEuQp9Y/L8TP9eWs7wXXWQua3J3svEvgYXgZM6Mv7CMnUMNZvou/kftIXY?=
 =?us-ascii?Q?wR0IIKO59qqPkROZ/QieFppHdpoozGO/g8oGCvQ66Fepn/Q3koJdPp2M3GNL?=
 =?us-ascii?Q?SZuD/ef2t2bMXmKGwa/YdO0PD5VrW0//L62qbg0leVhbbUCXHXt8LIPcinBX?=
 =?us-ascii?Q?pJRv1b82d52RpVZ8WFbP18jelp1cwENwbtYIgLJJdZtORxoWaqvmO1p2inin?=
 =?us-ascii?Q?a+Xkm41MhF3v05ImI6n65RmcrI1RD6R8rVl8QgacyBmD4n/Z/NMI1fBbKOlq?=
 =?us-ascii?Q?LzQMyEa9z6J9p7Bybnklb22tLB8JU4Ip2+9OCwc+IjOzDWs0137aczA5wNFS?=
 =?us-ascii?Q?hw1GAwjOVtRxizvPXQ2HRbKwd4j2TpDXdbEefxA3B5q49juW9u/4N7zln3Ju?=
 =?us-ascii?Q?UzawVE52cD1tAegwwcC0BvrZs1F2EdfKjNZED0bC1LVfHJpTdCUs5bApHp+U?=
 =?us-ascii?Q?Rw/BCPKpt/DajhtcvlDEvomG2blk8HtGgk7L5Q5kjiuL51OVVlP0/Z73OAqd?=
 =?us-ascii?Q?XpIvvhnsj9k/Y14yyf7clsOU+9Q3b5bN8BDUCdV99t3qTqJRzXvCsZKSvzFx?=
 =?us-ascii?Q?TyEXK37YYv7nmrVxFPDYt+UDjRfpue7Ejm7H3oGrqVR1pn60MUzlW5PKE2B5?=
 =?us-ascii?Q?uILmGxIsrNuqHM5PHTwtW3ZpdbNTzAVr/6p0KWb5gGY2gZbAneyQKwQExX+i?=
 =?us-ascii?Q?iXgqs7GgYq4BCupi+sl41WhwRZ3mUFxaz2gjLarSZLQzv1WEJN0Wpz2q3sx+?=
 =?us-ascii?Q?jgzK11Pwfo0K6Uf9rpeZh18EEf6J3xK0Mxwka1rqQuKlSQI8BwbK5LFVJ1Hj?=
 =?us-ascii?Q?UvsOeZV0ez3xWEMGxlpornEAsysV9yYLLVT6SwcqizI+M7QX+RcBMgU5yFO1?=
 =?us-ascii?Q?7EcwalV64XLJOdh97AnowW4N7jGruUDUmqlW6FAM8kvUKOmb3Afrf9niWdHm?=
 =?us-ascii?Q?ZRuxHncGXejQGr03RiCMZgzkwCAghoYsREvDLJE3Vfy0oTVgeHisRa4AwA4Z?=
 =?us-ascii?Q?dgnCceu16zZFbc4+pPIpy9gw6/xnMF4ZbBboEYUp8/h6Q+C35C5HXj9ZRP1i?=
 =?us-ascii?Q?Ax6Y6oIo80oM1oKxhTLVqbmIHj/rjo7YlSFCeXohgMG7MxZlFhphMLyiWPbI?=
 =?us-ascii?Q?jecFAWEyvST/avDj70fJ2eBZwG+DDYFjEEdHyoPoRkiDs2Bms6FffEU4oS5e?=
 =?us-ascii?Q?0aCFPN7zD4fR0tc+hS2iaFxsT1IDNYqG6aICjP8OjwVtv4UwrmqcXA5KIn9D?=
 =?us-ascii?Q?vo8Xh4G42tvP+TxvoQi2dVPJUa1N3hlgm9epe719w9zcYP3FsreX1Hij822p?=
 =?us-ascii?Q?zSymlCFyFzUXwOlvTsijvO2GgCAox21JhdCtLmHPSpdOgILhxPn2lEiBV5K0?=
 =?us-ascii?Q?BmImsFPyuDV93lZ7Hpr+0P7EAnOAwer/BJIOy77CXdoM93cFEehz51NbIfCV?=
 =?us-ascii?Q?xzkKkUv16qxmAD+TVzLo7TYVQr/iCCniC3UZ7HirA53LCUNoHY2bBJ7gmQob?=
 =?us-ascii?Q?QekcRLeFPIsFIBWQjW85PIibv/9of9p8BH+d/qdB6j9YFgXvsSqUgb8LYE49?=
 =?us-ascii?Q?00fozVOUL6fkWnX/CyQQJLAFBxW+Ww1pB8dHxmw8wF5yVBxkyEZ1G8j5KSQg?=
 =?us-ascii?Q?ow=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ff5413c-7c01-48aa-a09b-08dd6b69af4d
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 06:53:01.6631 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HSTuR26lu/aLMsjGk6eHv2vwlDKYpQ+2h0NXyskoqZ1z3GdGwVu3N8WW2hDC083+flsDiL7kRXk2csh5DqQfOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7322
X-OriginatorOrg: intel.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Content-Disposition: inline
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [linux-next:master] [block/bdev] 3c20917120:
 BUG:sleeping_function_called_from_invalid_context_at_mm/util.c
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
Cc: Pankaj Raghav <p.raghav@samsung.com>, Daniel Gomez <da.gomez@samsung.com>,
 Christian Brauner <brauner@kernel.org>, David Bueso <dave@stgolabs.net>,
 Jan Kara <jack@suse.cz>, lkp@intel.com, David Hildenbrand <david@redhat.com>,
 Alistair Popple <apopple@nvidia.com>, Matthew Wilcox <willy@infradead.org>,
 linux-block@vger.kernel.org, linux-mm@kvack.org, oliver.sang@intel.com,
 Hannes Reinecke <hare@suse.de>, John Garry <john.g.garry@oracle.com>,
 Johannes Weiner <hannes@cmpxchg.org>, oe-lkp@lists.linux.dev,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

hi, Luis,

On Sun, Mar 23, 2025 at 12:07:27AM -0700, Luis Chamberlain wrote:
> On Sat, Mar 22, 2025 at 06:02:13PM -0700, Luis Chamberlain wrote:
> > On Sat, Mar 22, 2025 at 07:14:40PM -0400, Johannes Weiner wrote:
> > > Hey Luis,
> > > 
> > > This looks like the same issue the bot reported here:
> > > 
> > > https://lore.kernel.org/all/20250321135524.GA1888695@cmpxchg.org/
> > > 
> > > There is a fix for it queued in next-20250318 and later. Could you
> > > please double check with your reproducer against a more recent next?
> > 
> > Confirmed, at least it's been 30 minutes and no crashes now where as
> > before it would crash in 1 minute. I'll let it soak for 2.5 hours in
> > the hopes I can trigger the warning originally reported by this thread.
> > 
> > Even though from code inspection I see how the kernel warning would
> > trigger I just want to force trigger it on a test, and I can't yet.
> 
> Survied 5 hours now. This certainly fixed that crash.
> 
> As for the kernel warning, I can't yet reproduce that, so trying to
> run generic/750 forever and looping
> ./testcases/kernel/syscalls/close_range/close_range01
> and yet nothing.
> 
> Oliver can you reproduce the kernel warning on next-20250321 ?

the issue still exists on
9388ec571cb1ad (tag: next-20250321, linux-next/master) Add linux-next specific files for 20250321

but randomly (reproduced 7 times in 12 runs, then ltp.close_range01 also failed.
on another 5 times, the issue cannot be reproduced then ltp.close_range01 pass)

one dmesg is attached FYI.

kern  :err   : [  215.378500] BUG: sleeping function called from invalid context at mm/util.c:743
kern  :err   : [  215.386652] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 52, name: kcompactd0
kern  :err   : [  215.395438] preempt_count: 1, expected: 0
kern  :err   : [  215.400216] RCU nest depth: 0, expected: 0
kern  :warn  : [  215.405081] CPU: 0 UID: 0 PID: 52 Comm: kcompactd0 Tainted: G S                  6.14.0-rc7-next-20250321 #1 PREEMPT(voluntary) 
kern  :warn  : [  215.405095] Tainted: [S]=CPU_OUT_OF_SPEC
kern  :warn  : [  215.405097] Hardware name: Hewlett-Packard HP Pro 3340 MT/17A1, BIOS 8.07 01/24/2013
kern  :warn  : [  215.405101] Call Trace:
kern  :warn  : [  215.405104]  <TASK>
kern  :warn  : [  215.405107]  dump_stack_lvl+0x4f/0x70
kern  :warn  : [  215.405118]  __might_resched+0x2c6/0x450
kern  :warn  : [  215.405128]  folio_mc_copy+0xca/0x1f0
kern  :warn  : [  215.405137]  ? _raw_spin_lock+0x80/0xe0
kern  :warn  : [  215.405145]  __migrate_folio+0x117/0x2e0
kern  :warn  : [  215.405154]  __buffer_migrate_folio+0x563/0x670
kern  :warn  : [  215.405161]  move_to_new_folio+0xf5/0x410
kern  :warn  : [  215.405168]  migrate_folio_move+0x210/0x770
kern  :warn  : [  215.405173]  ? __pfx_compaction_free+0x10/0x10
kern  :warn  : [  215.405181]  ? __pfx_migrate_folio_move+0x10/0x10
kern  :warn  : [  215.405187]  ? compaction_alloc_noprof+0x441/0x720
kern  :warn  : [  215.405195]  ? __pfx_compaction_alloc+0x10/0x10
kern  :warn  : [  215.405202]  ? __pfx_compaction_free+0x10/0x10
kern  :warn  : [  215.405208]  ? __pfx_compaction_free+0x10/0x10
kern  :warn  : [  215.405213]  ? migrate_folio_unmap+0x329/0x890
kern  :warn  : [  215.405221]  migrate_pages_batch+0xe67/0x1800
kern  :warn  : [  215.405227]  ? __pfx_compaction_free+0x10/0x10
kern  :warn  : [  215.405236]  ? __pfx_migrate_pages_batch+0x10/0x10
kern  :warn  : [  215.405243]  ? pick_next_task_fair+0x304/0xba0
kern  :warn  : [  215.405253]  ? finish_task_switch+0x155/0x750
kern  :warn  : [  215.405260]  ? __switch_to+0x5ba/0x1020
kern  :warn  : [  215.405268]  migrate_pages_sync+0x10b/0x8e0
kern  :warn  : [  215.405275]  ? __pfx_compaction_alloc+0x10/0x10
kern  :warn  : [  215.405281]  ? __pfx_compaction_free+0x10/0x10
kern  :warn  : [  215.405289]  ? __pfx_migrate_pages_sync+0x10/0x10
kern  :warn  : [  215.405295]  ? set_pfnblock_flags_mask+0x178/0x220
kern  :warn  : [  215.405303]  ? __pfx_lru_gen_del_folio+0x10/0x10
kern  :warn  : [  215.405310]  ? __pfx_compaction_alloc+0x10/0x10
kern  :warn  : [  215.405316]  ? __pfx_compaction_free+0x10/0x10
kern  :warn  : [  215.405323]  migrate_pages+0x842/0xe30
kern  :warn  : [  215.405331]  ? __pfx_compaction_alloc+0x10/0x10
kern  :warn  : [  215.405337]  ? __pfx_compaction_free+0x10/0x10
kern  :warn  : [  215.405345]  ? __pfx_migrate_pages+0x10/0x10
kern  :warn  : [  215.405351]  ? __compact_finished+0x91b/0xbd0
kern  :warn  : [  215.405359]  ? isolate_migratepages+0x32d/0xbd0
kern  :warn  : [  215.405367]  compact_zone+0x9df/0x16c0
kern  :warn  : [  215.405377]  ? __pfx_compact_zone+0x10/0x10
kern  :warn  : [  215.405383]  ? _raw_spin_lock_irqsave+0x86/0xe0
kern  :warn  : [  215.405390]  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
kern  :warn  : [  215.405397]  compact_node+0x158/0x250
kern  :warn  : [  215.405405]  ? __pfx_compact_node+0x10/0x10
kern  :warn  : [  215.405416]  ? __pfx_extfrag_for_order+0x10/0x10
kern  :warn  : [  215.405425]  ? __pfx_mutex_unlock+0x10/0x10
kern  :warn  : [  215.405432]  ? finish_wait+0xd1/0x280
kern  :warn  : [  215.405441]  kcompactd+0x5d0/0xa30
kern  :warn  : [  215.405450]  ? __pfx_kcompactd+0x10/0x10
kern  :warn  : [  215.405456]  ? _raw_spin_lock_irqsave+0x86/0xe0
kern  :warn  : [  215.405462]  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
kern  :warn  : [  215.405469]  ? __pfx_autoremove_wake_function+0x10/0x10
kern  :warn  : [  215.405477]  ? __kthread_parkme+0xba/0x1e0
kern  :warn  : [  215.405485]  ? __pfx_kcompactd+0x10/0x10
kern  :warn  : [  215.405492]  kthread+0x3a0/0x770
kern  :warn  : [  215.405498]  ? __pfx_kthread+0x10/0x10
kern  :warn  : [  215.405504]  ? __pfx_kthread+0x10/0x10
kern  :warn  : [  215.405510]  ret_from_fork+0x30/0x70
kern  :warn  : [  215.405516]  ? __pfx_kthread+0x10/0x10
kern  :warn  : [  215.405521]  ret_from_fork_asm+0x1a/0x30
kern  :warn  : [  215.405530]  </TASK>
user  :notice: [  216.962224] Modules Loaded         netconsole btrfs blake2b_generic xor zstd_compress raid6_pq snd_hda_codec_realtek snd_hda_codec_generic snd_hda_scodec_component intel_rapl_msr intel_rapl_common x86_pkg_temp_thermal intel_powerclamp coretemp i915 sd_mod sg kvm_intel intel_gtt ipmi_devintf ipmi_msghandler cec kvm drm_buddy snd_hda_intel snd_intel_dspcfg ttm snd_intel_sdw_acpi ghash_clmulni_intel drm_display_helper snd_hda_codec rapl drm_client_lib intel_cstate snd_hda_core drm_kms_helper ahci snd_hwdep libahci snd_pcm wmi_bmof mei_me video intel_uncore mei lpc_ich libata snd_timer pcspkr snd i2c_i801 i2c_smbus soundcore wmi binfmt_misc loop drm fuse dm_mod ip_tables


> 
>   Luis

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
