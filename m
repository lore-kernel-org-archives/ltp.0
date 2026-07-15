Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBE01C44501
	for <ltp@archiver.kernel.org>; Wed, 15 Jul 2026 14:02:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 325513E1E71
	for <ltp@archiver.kernel.org>; Wed, 15 Jul 2026 16:02:24 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 570E03E1DE7
 for <ltp@lists.linux.it>; Wed, 15 Jul 2026 16:02:04 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 951BD200275
 for <ltp@lists.linux.it>; Wed, 15 Jul 2026 16:02:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784124123; x=1815660123;
 h=date:from:to:cc:subject:message-id:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=18FR2DfnavlH2oMS2wMtMgwbRwD5l4WH3PADGXkkgdY=;
 b=iQyGLoTYFqL2NPTeXZyeKjZEPdkT9yLiFAkApeg7SbNVYWJmwjxHdbv6
 7bgf5liExPLf5KO7qWyNS4gOKOFfmtFswZMC0lPbYBbtBAGnbVTOm5kqg
 BUQlp1Pwi5IIWT7EpQ5M7qalAXPnnVsuRSw+suoVh5GN/uuo/B7zmzmh2
 Gy3wR6DNbYFUTcxntdIWDBBft0c2NSEyQ87hMJCvFCLBGZO+yCnZj+XNN
 p/o3tbQ1wQNXh8fMb5xVztLRZHcTp5zcI+Pls/g4JuFnmTmizcYeCML0Z
 6MyFv1R2jDRahi91WYMg7KSeOz8vWY9rvuoPLlswCHmSkFhCEuMThnHYx g==;
X-CSE-ConnectionGUID: OGJkz3brSNKoWd+KEzG0xQ==
X-CSE-MsgGUID: oWvkfBRnSvmHv9lKgTwUQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="110308310"
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; d="scan'208";a="110308310"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2026 07:02:00 -0700
X-CSE-ConnectionGUID: fvdB+zDvRKuENylLbJhw4A==
X-CSE-MsgGUID: mxekyEneTdyaBkyFxccL1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; d="scan'208";a="256838720"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2026 07:02:00 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 15 Jul 2026 07:01:59 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 15 Jul 2026 07:01:59 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.8) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 15 Jul 2026 07:01:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AV7fI4YZCG/8jiIgPB7oUxKNGoH0dneWUYk6P2J0BAsagSs35zt+YkzKfYr9g2nObF1oO4Lct+0pDP1QMUd3yo737WbWCQ/gFs/RcYU3m9Q7CzgJo/zmSCCDejsnI+Tqa3yicTR84IvPFFW7GA6azuF0bp9nj2LBpQY30X6XDyCcFu8W/rKRj3SBkmwvaemv0jcScJ/PjwbvATy9SxZKYN2E1LcocMTebr3VihWM8g/sZQ8Z3r5z+YGQ6wpt6ZHmqh1w/NqiYz5vZlKZo/xxPsrcAVl8/tK2YhaAmfWZApoR1JSLuT4sdhh3ZR1mfv6OcIHEtoS1JxKYcNQyZrZHwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=72bN5xV89slNbpV7FUIlhTqFL+ItGocxiaUQnxZtmTM=;
 b=fzJ8A/4KZEM5pvvywBCBYd2kg3fMdX79P8NErzUZ35plPzV5BDm6sPpA59IadgBdqe6Uw5/LTpKvhQHFuByDNeFaT4fLsITmrZf8clDTYnVXKJwy9g/F25d6HYVtsB/hVSlzzBJb8IlN5A+nnSSI7xBceE2EJhsN+bNy9HfoTwiUWa5+ET5szoYYu+l5J2yFVAlpq24WQkzlhvFsZjt1dsQqMR1hqdo6BQpVCczj0Q8CdK5dvfcB8BuSzl4fNWH1eCtAOuZ6llJ/JVLUnnxBU0c2XIbRRP+Pf8GXAO3+EdkJoXrgfjUAMVDLlCe4nP+7rBWjY/RJLyGszPmPm8P1HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7)
 by DS4PPF30373102B.namprd11.prod.outlook.com (2603:10b6:f:fc02::1b)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Wed, 15 Jul
 2026 14:01:54 +0000
Received: from PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707]) by PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707%5]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 14:01:54 +0000
Date: Wed, 15 Jul 2026 22:01:46 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Message-ID: <202607151550.5d829a99-lkp@intel.com>
Content-Disposition: inline
In-Reply-To: <20260709095511.168235-1-simon.schippers@tu-dortmund.de>
X-ClientProxiedBy: TPYP295CA0014.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:9::20) To PH0PR11MB5832.namprd11.prod.outlook.com
 (2603:10b6:510:141::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5832:EE_|DS4PPF30373102B:EE_
X-MS-Office365-Filtering-Correlation-Id: f2734fed-ffc8-41ff-80be-08dee279a0a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|1800799024|366016|11063799006|3023799007|10067099003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: l0HsLtiHMGP8zahRzmUHuTemNOLnlPPAy4FitUNp2oOsKwxfwq8vDLXEVcK+xiaum1jWS/quGAGFyEiQ4lBKsn2igOmggu3V4gw2vJockm5SVQoM3uxyqM7DtMUACSnsdWt8PNxYv8cE3ZQvJBE/Z6rv8Kb6EYQCoCGvOl76HYW50DnlK+1OmPMLVsR2d1Zmn92rf8su60jZ0CSDCFsl8PAEx8YjLeqpMD+2HLRDEZ+z7IqlPSBf1yGff3F+aj3oToESslbn/ev4PpgUVg7vEp2TxFjnsdRJK21mX7qRpSIZHVuAg21o8WepBsK/FU8rR4ffNtpyE5gz/FRxshIsgRXltYN88ZVjt5kzKzA5FS00h2MFp37uVmAXwORIPT47tJZKkj+0JXqNNaYKHsMzcDpD0KAccR+uDalKgPllSRj421JeX+lDan+HJsiKeI04pGi4nsylxS/YBVEgMmsdiUEEAngLLdkWkSfLAcjS0CHJKyMfj+TENNpE7Nbz2RpO7tvpPevPae5I7zwDJ9ObWgwEP6F273BmfdhUqoI373mj6O4I9xDiZ3ksNOIRczaiCHzbepdupa6MPv15wh79LGxH+funikWvzP2oyM1DqFRLwFWxtENLnYrvOdO4+2DQ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB5832.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(11063799006)(3023799007)(10067099003)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NnNVWVA1UU9iT3BINXFiRkpoNTBBMmFJYnZpSlFZbDBneWNFZXBRNEVxaWZE?=
 =?utf-8?B?dGlnb21RWFdLR1hFc0xCRGpISkxUK3JFWUJuQW8yV2t4aCszMzljeGVsWnow?=
 =?utf-8?B?Qm8venlFZ2REQUROK1ducko1aDJ3d2dQdUQ5aVJaRDhnREd1NVRrcUV5OWRi?=
 =?utf-8?B?RlgyRWVaUWxCRmdQWmRMdjEyUDN1d1QzN3VaKzc3TkNXdVA5SEFxS2JKZlVY?=
 =?utf-8?B?Y3VIU0pYRi96WkNvdHVHTzVoRFZnWnBnL3BBRXVNSVYrQk1qTU5NRVZZazV3?=
 =?utf-8?B?NmlJR1VhckRienoxKzlNcDFiU3NCRGVZUmF6TFFtOE91cmNHMjQ3YkJNY0ZT?=
 =?utf-8?B?Y0dNMFFzelR1c3ZFQTlvK21tSUxTSVM0bWNqcWhqb1hlSTE1WmdaR3JvdFNE?=
 =?utf-8?B?VWhhRVBGK0hVSzQzR1NZQ1ZNOXZtWkNiTGcyQzdlaUJNbFBKRTk2RFVzeHVr?=
 =?utf-8?B?MzVSWmh4WTMyM1luOThHVHJyTUxXcExMa29NdkF6cDhjNXFPME1udzYraHFw?=
 =?utf-8?B?d3U4UFJSTEFKUm5DdnpPN01sMjFoT0g1eGFKbnlxdUFRdldJSUNidksxRThE?=
 =?utf-8?B?VGthaHlaTm91bUs0VEpsMXRxSUlLRXlwZk5Fd20rK2NZLytSZklCRW9wb0JN?=
 =?utf-8?B?cHJKVlcrOU9uTStjUFRwcDZwMUFVTHRUL0FlNTFPcGN0ekY0RXJha1QwRVVm?=
 =?utf-8?B?dG1nYlNxeHpMR0hlVm44bXBrYUtXUVRwSTlpMlZFSGxMMjhiUWNKMXJJL251?=
 =?utf-8?B?OWVyVjEyWDBySnZNTFhtRWRMSDhaK1ErS1JFcTRrcG42aVZYY3RQVnpleE03?=
 =?utf-8?B?WGR4alZqUVZhVXFlVzZtNU8vUUhxUDhORHpMSG03M210dmpDSFgwR29EenBZ?=
 =?utf-8?B?SFp3VFRPcFZwUE4wTS94eURaYUpEM3RRWTBkQ2NSM3NKaUtyRmZFci8wZVVO?=
 =?utf-8?B?UlhvblNoYW9jaXJrSEtBclFkZm5kWEtET2JzekZCMXBXSW0wcTRxcjJSd1FQ?=
 =?utf-8?B?M0xud3RrTHFuczNzRnVNZkRBSTZIMEJYUnh2YUhERWNoMlNPYzVBcUVuM3Ur?=
 =?utf-8?B?Mk1tNmFXeFovRkhEV1VsQSt0ZWRiQ1NjL1ptRDNvQ2Z3NHY0MzFOdWNjY1Y5?=
 =?utf-8?B?aUg0OXYxb1h2T2NwVlhmSkRIRUtpREJvWVNGVEFJNGxtZjFUek5qN0N5cFUw?=
 =?utf-8?B?ZHNFbElUL0p1NnpzNXIwUjBBOGdFQVVDd2ZTY2pncHRpNmpXemFYT1BRakhY?=
 =?utf-8?B?L1pOMVR4SzdhUlVNYXJ5dzMwajBOUlp3L1FBbXpHLy9zWHhya2dHZWNacmlK?=
 =?utf-8?B?eFBDZDFIaWl5aW80VFB0cy8rekZSbEkwdUY5anN2eklOOTZxcHhkcm5SZjJK?=
 =?utf-8?B?cVJYMFoydUZYY1lWNVk2aXNhK29aOTE3WlNpenBiekRJeFhkZTBnQ3IzbU1n?=
 =?utf-8?B?UXVtYVdWd1N6OU9aVHVCMGlyZnh5eTUrRFJqanUrazBud20vMjE2UFFSNlVC?=
 =?utf-8?B?MC80NWc2RjRGd0ZjdWs4WFMwQTYzV1BRQWd1STlHaFpIZm8rR0c4M0JYMFBF?=
 =?utf-8?B?bktTQWI5b2FEcHBwTXpxekYzN1VsbmtQMWMyNnF4MS9ydkVUL28vamRRTXZ4?=
 =?utf-8?B?TFZDeHF3WW9DMDlBbWJFWi9FQ0hXbnZMMnB3cUc1aG1LTVFxNmplVlRTcU9U?=
 =?utf-8?B?dE40Yy9RckNHVGFjVUxlZWtmOWN2VEN0RUZ1Z0RaZElueGtHOURzZUJidkN0?=
 =?utf-8?B?RVluem1HVjhsbTNjSXc5dVB2RFdrRVBsWjR1SE4zN2RlL3VTN0NkTTZRRUMz?=
 =?utf-8?B?TGlvbkpGYWFYRWcvOVZhS3I2NThzeW9XRzJ5RUk1ODB2Uml4eEFOYitwMjJz?=
 =?utf-8?B?bGMxYjJSR0ZnOCt3clA4a0QvNVJweXIrK1FRdmVpb1VHSzVoTTNtc2tNRUlM?=
 =?utf-8?B?RHdMS2ZmTVluN2RkZ0FXTjVGS3ByMVNDa3V4MnFkcTV3TnViQ3RyeGtkc3dw?=
 =?utf-8?B?REpTNmRSQkZHVWlReWlEQTMwb2xVdmIySCtCWVpmMTVrVzRkejFVOCsxWDc3?=
 =?utf-8?B?Y0xMK0ozRWFjNFVSbm9OUDJJV250QkN3NEVvME85cVRWRHkzWG4xSGI5a3Uw?=
 =?utf-8?B?eG9JVTFHck9JYXlaYnZNWWF4UDV5TW96RXQ2NFJXOWYvM1lkTENlWTdrUVky?=
 =?utf-8?B?RFJ6UHdiU3hQSDRkQUM3UmpDeWVrVFlrMnllTG9QYmxDbDIvdDY2THNwMVhZ?=
 =?utf-8?B?ejBIYStFRHdqNFJhOENJSTU1RnhOaXI1WG93Nm5GMmJ3TVJ0dlIvNmhvK0Yv?=
 =?utf-8?B?N1dwWXduajJCSzZrbXVkVFVMVXdVSHR6ekpQQ2NUdTkvWkpnN1k2QT09?=
X-Exchange-RoutingPolicyChecked: QaXk7rAkvCkJKWCFT8E0Z+2MmBwLtKf5GFwCSUhAjHRXYyJD4PN2UKz4vnIrTkmmLhWt/FCFYmNT/jnZ9O/j4sePklwaDtmsRc2JBEJDWuupNNsjXqmbTH4l7VlMiX+u8NtCH691WMIpEStIUSVE+hMMY/ghJZOyu/Akcj0RU82X45NO/NxkWgjFBuZvayYGFpts8l1BFUzOWp6yiZiyUIr8gEJpdRipmuGA/CnP0MV9+KkR3AM+eH8YCOISFDzcmmEnS/HRH8cHQJszblLcPLkZJf2a6VRB7/QYgz7rMttbBVvkQ49O5x6sGCoFCCZ4zbNhLscQiGT36qxhU8bF4A==
X-MS-Exchange-CrossTenant-Network-Message-Id: f2734fed-ffc8-41ff-80be-08dee279a0a3
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5832.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 14:01:54.8359 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aw2uYEkV1Rh3ak0x2WKenmSoVb0u8mpxdjxbmfNWZlNETGZD/s06joowL8WmFYL6V3tQ1/TT7YI6seiKVfdgLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF30373102B
X-OriginatorOrg: intel.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH net v3] tun/tap & vhost-net: make qdisc
 backpressure opt-in via IFF_BACKPRESSURE
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
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, lkp@intel.com,
 Brett Sheffield <brett@librecast.net>, "Michael S .
 Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jason Wang <jasowangio@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 Simon Schippers <simon.schippers@tu-dortmund.de>, oliver.sang@intel.com,
 Simon Horman <horms@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
 oe-lkp@lists.linux.dev, Jakub
 Kicinski <kuba@kernel.org>, Tim Gebauer <tim.gebauer@tu-dortmund.de>,
 Paolo Abeni <pabeni@redhat.com>, "David
 S . Miller" <davem@davemloft.net>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

CgpIZWxsbywKCmtlcm5lbCB0ZXN0IHJvYm90IG5vdGljZWQgImx0cC5pb2N0bDAzLmZhaWwiIG9u
OgoKY29tbWl0OiAwOTE1NGZmMjA3MmUzNmI4NmJhMmQ5MmQ0MzZiN2YyN2RmMTUzZWQxICgiW1BB
VENIIG5ldCB2M10gdHVuL3RhcCAmIHZob3N0LW5ldDogbWFrZSBxZGlzYyBiYWNrcHJlc3N1cmUg
b3B0LWluIHZpYSBJRkZfQkFDS1BSRVNTVVJFIikKdXJsOiBodHRwczovL2dpdGh1Yi5jb20vaW50
ZWwtbGFiLWxrcC9saW51eC9jb21taXRzL1NpbW9uLVNjaGlwcGVycy90dW4tdGFwLXZob3N0LW5l
dC1tYWtlLXFkaXNjLWJhY2twcmVzc3VyZS1vcHQtaW4tdmlhLUlGRl9CQUNLUFJFU1NVUkUvMjAy
NjA3MDktMTgxMjM0CmJhc2U6IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvY2dpdC9saW51eC9rZXJu
ZWwvZ2l0L2RhdmVtL25ldC5naXQgZmFiYjg4MWRmMzIyZGEyNTQ0MmY5OGQyM2Y1ZmEzNzFlM2M3
OGVjNApwYXRjaCBsaW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNjA3MDkwOTU1
MTEuMTY4MjM1LTEtc2ltb24uc2NoaXBwZXJzQHR1LWRvcnRtdW5kLmRlLwpwYXRjaCBzdWJqZWN0
OiBbUEFUQ0ggbmV0IHYzXSB0dW4vdGFwICYgdmhvc3QtbmV0OiBtYWtlIHFkaXNjIGJhY2twcmVz
c3VyZSBvcHQtaW4gdmlhIElGRl9CQUNLUFJFU1NVUkUKCmluIHRlc3RjYXNlOiBsdHAKdmVyc2lv
bjogCndpdGggZm9sbG93aW5nIHBhcmFtZXRlcnM6CgoJZGlzazogMUhERAoJZnM6IGV4dDQKCXRl
c3Q6IHN5c2NhbGxzLTAzCgoKCmNvbmZpZzogeDg2XzY0LXJoZWwtOS40LWx0cApjb21waWxlcjog
Z2NjLTE0CnRlc3QgbWFjaGluZTogNCB0aHJlYWRzIDEgc29ja2V0cyBJbnRlbChSKSBDb3JlKFRN
KSBpMy0zMjIwIENQVSBAIDMuMzBHSHogKEl2eSBCcmlkZ2UpIHdpdGggOEcgbWVtb3J5CgoocGxl
YXNlIHJlZmVyIHRvIGF0dGFjaGVkIGRtZXNnL2ttc2cgZm9yIGVudGlyZSBsb2cvYmFja3RyYWNl
KQoKCgpJZiB5b3UgZml4IHRoZSBpc3N1ZSBpbiBhIHNlcGFyYXRlIHBhdGNoL2NvbW1pdCAoaS5l
LiBub3QganVzdCBhIG5ldyB2ZXJzaW9uIG9mCnRoZSBzYW1lIHBhdGNoL2NvbW1pdCksIGtpbmRs
eSBhZGQgZm9sbG93aW5nIHRhZ3MKfCBSZXBvcnRlZC1ieToga2VybmVsIHRlc3Qgcm9ib3QgPG9s
aXZlci5zYW5nQGludGVsLmNvbT4KfCBDbG9zZXM6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL29l
LWxrcC8yMDI2MDcxNTE1NTAuNWQ4MjlhOTktbGtwQGludGVsLmNvbQoKCi4uLi4KChtbMTszN21n
ZXR1aWQwMzogG1swbRtbMTszMm1wYXNzG1swbSAgKDAuMDI4cykKG1sxOzM3bWlvY3RsMDM6IBtb
MG0bWzE7MzFtZmFpbBtbMG0gICgwLjA0N3MpICAgICA8LS0tLS0KG1sxOzM3bWlvY3RsMDU6IBtb
MG0bWzE7MzJtcGFzcxtbMG0gICgwLjQ3MXMpCgouLi4uCgpFeGVjdXRpb24gdGltZTogM20gMzVz
CgpEaXNjb25uZWN0aW5nIGZyb20gU1VUOiBkZWZhdWx0CgpUYXJnZXQgaW5mb3JtYXRpb24K4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSACktlcm5l
bDogICBMaW51eCA3LjIuMC1yYzErICMxIFNNUCBQUkVFTVBUX0RZTkFNSUMgU3VuIEp1bCAxMiAw
NzoyNTozOCBDU1QgMjAyNgpDbWRsaW5lOiAgaXA9Ojo6OmxrcC1pdmItZDA0OjpkaGNwCiAgICAg
ICAgICByb290PS9kZXYvcmFtMAogICAgICAgICAgUkVTVUxUX1JPT1Q9L3Jlc3VsdC9sdHAvMUhE
RC1leHQ0LXN5c2NhbGxzLTAzL2xrcC1pdmItZDA0L2RlYmlhbi0xMy14ODZfNjQtMjAyNTA5MDIu
Y2d6L3g4Nl82NC1yaGVsLTkuNC1sdHAvZ2NjLTE0LzA5MTU0ZmYyMDcyZTM2Yjg2YmEyZDkyZDQz
NmI3ZjI3ZGYxNTNlZDEvMAogICAgICAgICAgQk9PVF9JTUFHRT0vcGtnL2xpbnV4L3g4Nl82NC1y
aGVsLTkuNC1sdHAvZ2NjLTE0LzA5MTU0ZmYyMDcyZTM2Yjg2YmEyZDkyZDQzNmI3ZjI3ZGYxNTNl
ZDEvdm1saW51ei03LjIuMC1yYzErCiAgICAgICAgICBicmFuY2g9bGludXgtZGV2ZWwvZGV2ZWwt
aG91cmx5LTIwMjYwNzA5LTE5MDc1OQogICAgICAgICAgam9iPS9sa3Avam9icy9zY2hlZHVsZWQv
bGtwLWl2Yi1kMDQvbHRwLTFIREQtZXh0NC1zeXNjYWxscy0wMy1kZWJpYW4tMTMteDg2XzY0LTIw
MjUwOTAyLmNnei0wOTE1NGZmMjA3MmUtMjAyNjA3MTItMTk2NDktdGM4YnU2LTAueWFtbAogICAg
ICAgICAgdXNlcj1sa3AKICAgICAgICAgIEFSQ0g9eDg2XzY0CiAgICAgICAgICBrY29uZmlnPXg4
Nl82NC1yaGVsLTkuNC1sdHAKICAgICAgICAgIGNvbW1pdD0wOTE1NGZmMjA3MmUzNmI4NmJhMmQ5
MmQ0MzZiN2YyN2RmMTUzZWQxCiAgICAgICAgICBpbnRyZW1hcD1wb3N0ZWRfbXNpCiAgICAgICAg
ICBtYXhfdXB0aW1lPTcyMDAKICAgICAgICAgIExLUF9TRVJWRVI9aW50ZXJuYWwtbGtwLXNlcnZl
cgogICAgICAgICAgbm9rYXNscgogICAgICAgICAgc2VsaW51eD0wCiAgICAgICAgICBkZWJ1Zwog
ICAgICAgICAgYXBpYz1kZWJ1ZwogICAgICAgICAgc3lzcnFfYWx3YXlzX2VuYWJsZWQKICAgICAg
ICAgIHJjdXBkYXRlLnJjdV9jcHVfc3RhbGxfdGltZW91dD0xMDAKICAgICAgICAgIG5ldC5pZm5h
bWVzPTAKICAgICAgICAgIHByaW50ay5kZXZrbXNnPW9uCiAgICAgICAgICBwYW5pYz0tMQogICAg
ICAgICAgc29mdGxvY2t1cF9wYW5pYz0xCiAgICAgICAgICBubWlfd2F0Y2hkb2c9cGFuaWMKICAg
ICAgICAgIG9vcHM9cGFuaWMKICAgICAgICAgIGxvYWRfcmFtZGlzaz0yCiAgICAgICAgICBwcm9t
cHRfcmFtZGlzaz0wCiAgICAgICAgICBkcmJkLm1pbm9yX2NvdW50PTgKICAgICAgICAgIHN5c3Rl
bWQubG9nX2xldmVsPWVycgogICAgICAgICAgaWdub3JlX2xvZ2xldmVsCiAgICAgICAgICBjb25z
b2xlPXR0eTAKICAgICAgICAgIGVhcmx5cHJpbnRrPXR0eVMwLDExNTIwMAogICAgICAgICAgY29u
c29sZT10dHlTMCwxMTUyMDAKICAgICAgICAgIHZnYT1ub3JtYWwKICAgICAgICAgIHJ3CiAgICAg
ICAgICBrZWVwX2luaXRyZHM9L29zaW1hZ2UvcGtnL2RlYmlhbi0xMy14ODZfNjQtMjAyNTA5MDIu
Y2d6L2x0cC14ODZfNjQtZWQyNzU4MTIyLTFfMjAyNjA3MTEuY2d6CiAgICAgICAgICBhY3BpX3Jz
ZHA9MHgwMDBmMDQ5MApNYWNoaW5lOiAgdW5rbm93bgpBcmNoOiAgICAgeDg2XzY0ClJBTTogICAg
ICA2ODk1NTk2IGtCClN3YXA6ICAgICAwIGtCCkRpc3RybzogICBkZWJpYW4gMTMKCuKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgAogICAgICBURVNUIFNVTU1BUlkK4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSAClN1aXRlOiAgIHN5c2Nh
bGxzLTAzClJ1bnRpbWU6IDNtIDI0cwpSdW5zOiAgICAxODMKClJlc3VsdHM6CiAgICBQYXNzZWQ6
ICAgMjE0NAogICAgRmFpbGVkOiAgIDEKICAgIEJyb2tlbjogICAwCiAgICBTa2lwcGVkOiAgMjIy
CiAgICBXYXJuaW5nczogMAoKG1sxOzMxbUZhaWx1cmVzOhtbMG0KICAgIOKAoiBpb2N0bDAzCgoK
ClRoZSBrZXJuZWwgY29uZmlnIGFuZCBtYXRlcmlhbHMgdG8gcmVwcm9kdWNlIGFyZSBhdmFpbGFi
bGUgYXQ6Cmh0dHBzOi8vZG93bmxvYWQuMDEub3JnLzBkYXktY2kvYXJjaGl2ZS8yMDI2MDcxNS8y
MDI2MDcxNTE1NTAuNWQ4MjlhOTktbGtwQGludGVsLmNvbQoKCgotLSAKMC1EQVkgQ0kgS2VybmVs
IFRlc3QgU2VydmljZQpodHRwczovL2dpdGh1Yi5jb20vaW50ZWwvbGtwLXRlc3RzL3dpa2kKCgot
LSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRw
Cg==
