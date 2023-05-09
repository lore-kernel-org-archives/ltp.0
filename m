Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4464C7EE24
	for <ltp@archiver.kernel.org>; Tue,  9 May 2023 14:25:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F29A23CD740
	for <ltp@archiver.kernel.org>; Tue,  9 May 2023 16:25:26 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5202B3C25BE
 for <ltp@lists.linux.it>; Tue,  9 May 2023 16:25:15 +0200 (CEST)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C3E84600541
 for <ltp@lists.linux.it>; Tue,  9 May 2023 16:25:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1683642313; x=1715178313;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=RQw5Y2RQ0HtV6mmSpShUS3oUoVFmqU6+MO4bnqWuOEI=;
 b=iGLi6P367zxKozq+IBKdl7SqKkVFELvAwQI3KjaUE6E0Q805Mnh0jvjD
 QpN9rTPQT5yZfQ3vJTB1hSe5VBWn/I6bXGNkB2DKu8Y9EujFmXOsV/sfc
 x6fXXfhjLryoNOxgd/EUoWPCDXtys7gjBN8HYAt1RPSF+Zt9x8A1acL+o
 Vnyy2iPBrLTbCqeQ1I841qmg1hdjLEaIoD5jxnY7wL9i5g9XY9Z1Fbo9h
 ewwCjz1Y4oPgifhwXVIWRgfZgu3eveFp0IjW+gpQbWMrHxr4eyHyqgQEV
 Nu3kqVyCxKL04lGSUxkok87G0WUPzeGmahpL0U9fNylLtIQcuemIRNLGU w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10705"; a="339170139"
X-IronPort-AV: E=Sophos;i="5.99,262,1677571200"; d="scan'208";a="339170139"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 May 2023 07:25:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10705"; a="768513108"
X-IronPort-AV: E=Sophos;i="5.99,262,1677571200"; d="scan'208";a="768513108"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by fmsmga004.fm.intel.com with ESMTP; 09 May 2023 07:25:09 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 9 May 2023 07:25:09 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 9 May 2023 07:25:09 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 9 May 2023 07:25:09 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.105)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 9 May 2023 07:25:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lA2WL9IVb6iugfHwu/UkrI61Ovv/BLixpg6w0/5XTHd9PSfb2Aelc9+QiNgS9J4WDqjaYs2OnKmpGXgnbc+RpfXQ2bCAabp98Of8xExKvbnke32rTcKJJ8HONw1Ao8SEWFiu/aB+3sL4QBa6n8IghvXDvFH1AvkFpzI7VXJZ6qs1uVQBX5wkDGvPI+jqaj50NqztFD2jEYu9e6eUjwss73a0KcyX4WoMH0sHVVOIGbRohOlVvy1JJPXfQyDGFEMgv+fzQl4ngVb9DbUajiYvmKPfP/ORA2fZ7v2OYknG7Iq2heC+T4ZMBPAW6iULpjLeknoiDqCboxrD03EQ/hZKJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KR6TDg8zPAI3rzeqBr5HUYpCV9ShyGiqwvXjwGOv2QM=;
 b=XEW8ok/Bv1neeMKeCYENs5yWKzI9GNaDqaNKFQAlpcvsYIoiCsMPoE7CDB7knhJL/dkvOSbn8ydvuAQFGXvho9dNm+Xs/erL/69WUJnb9whjeTP2ad9w/XAItUquHEsJQGXmJPVybq6G/k5vdkpABCPqAYo3ssvnBEw1G13CV9tTVQYIJ3K6XQ9FKwkEexmnRhfqA5pd8ifkeli00FIt4dl3K7wqrm9wTHMRJHXaTMHIDKdIm8rKF1NZJpZETDdx+yeVsCUS2iy+UwxUCIG6X10jzuWbOEDfjwtzmTm268GYPNIn9XrCUKwGTuI5VNt6aE/OPtWClvWopIn0DW3wJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by BL1PR11MB5555.namprd11.prod.outlook.com (2603:10b6:208:317::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Tue, 9 May
 2023 14:25:07 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::ae77:4253:55ab:a570]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::ae77:4253:55ab:a570%3]) with mapi id 15.20.6363.033; Tue, 9 May 2023
 14:25:07 +0000
Date: Tue, 9 May 2023 22:27:00 +0800
From: Pengfei Xu <pengfei.xu@intel.com>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <ZFpYNARm7y4b2QBl@xpf.sh.intel.com>
References: <cover.1683274510.git.pengfei.xu@intel.com>
 <efa47acd652c93a54fb66e17183524b54e561533.1683274510.git.pengfei.xu@intel.com>
 <ZFo1hUZCCXbfhEXY@yuki> <ZFpTIVcGoMTKyRCD@xpf.sh.intel.com>
 <ZFpUW8OAYPVViMBv@yuki>
Content-Disposition: inline
In-Reply-To: <ZFpUW8OAYPVViMBv@yuki>
X-ClientProxiedBy: SGBP274CA0009.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::21)
 To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|BL1PR11MB5555:EE_
X-MS-Office365-Filtering-Correlation-Id: c7edad5a-9355-4690-8dfc-08db50993006
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EDTgkEBKD47ZnO0mzNzUG1gkTaSc++DeV+eEO6CBKYIh55PyFiR8sBrpVhowwy5uGpo7yFRsdKy5ri2MyFPoEGZzNe3gQ/xgvRXzW82FZJ7XRB8dX7ge9rfswrEOtDWDM9pL4f6R+/GszuRx4tLydKs7qGsNplx+1nTmv4NqR8Kdo+WiFHAbGTbSNASIsEPBLGKsTIR8wlIHHOYXDlGtRWHSc0qF4+h33u+VMoWAYkGHDeXj+Bl4NlnlD/CZzjEUGWMbVz9ysQaIf/0IXP+ovKNuDiFcK3Q1bo+OtpuPKGZ7troPa0RUnATbAwAZbtF8UbKccNSCzH1jHHGPO1F5gnA4FdVgPiZn8BoTLhEYSfc/1TUmDOO1xr5p+CykmI17eZSrgoj2mxjnZnTIhZvUHmOenwUIhcTnK3sHVIxbl+uCK4T3jCWXjjGsz6wm2DBH1bPTD4SNul+6TXMvKZMihzgVn2P4U2mfdcimeC5WFDl8P9BXp89+U3n00kNxcDSbbvSJZfjMaYOsqt26v/btno9rS048t8U4v84YdtUkDQ39Rmgy5qzJr+fr8nUwHcSz
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB4839.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(376002)(366004)(346002)(396003)(39860400002)(136003)(451199021)(66946007)(478600001)(6916009)(4326008)(66556008)(66476007)(44832011)(8936002)(8676002)(5660300002)(26005)(316002)(6486002)(41300700001)(6666004)(6506007)(6512007)(53546011)(2906002)(83380400001)(186003)(82960400001)(86362001)(38100700002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enczN0luS2ZuRDFjUmU0dWJSaVlQY2hIdTZDbEdBMGpLeVNXNE5GMk9hUHpH?=
 =?utf-8?B?WUJFY0lrVDNDQmFOVDhaOWQwMHZxdUcxNllWYkQ5MmxWQmxTNmRPS3dYamQw?=
 =?utf-8?B?SUpMTmpvVDl0eTlwdHB6TXFSWVk3d2RreVJ3aEZ0UFhhMzVMTlE5SWplU3p4?=
 =?utf-8?B?M3RmQ3Q5bExPUzJpUFFEVGxiZ0xSbHpIWXlYVm0ydWxHSlpsRGhsaTFpZW42?=
 =?utf-8?B?YU5TNDZFN1VSakdkTEdFeGdrdGZPYU9ZOFNwN21iNWZlR0lsMnE4YTVEbzVB?=
 =?utf-8?B?bk5pSkJySThCWkpCdTNqQWpUMTBQcFJvK1UreVV2MUlFYzRUbU5IbGl6K3pS?=
 =?utf-8?B?S21Od0FsQUhmZDE5TVZyWitNYjhRKzIvTW53ZnU2M1dhWHVhaThyTkd0SWFl?=
 =?utf-8?B?OWx0ZE1SVEE2TlZrVjRrT2xXWk00Vk1DaE42MFhWTHcxcTZmWlczMnFVTDN2?=
 =?utf-8?B?SHdUMWxPei9ZM29mMHRSRDREQ0hOZ0xNelFoNzBjVVJiUGlEK1IweFd3MnQy?=
 =?utf-8?B?b2dOcE1XZzdmaEp6Y0Z1RGVCNEU3L3laVXhaZ3EzQ2ZZb0dTdUtIeWRLRGgw?=
 =?utf-8?B?czVrVklWaXFRNW1JOHN4R3VkRmJ3TklrdWZiVVdPd0tEVHV5SUtYbndzWDh0?=
 =?utf-8?B?ak00UE51U1RrV2lrOEgzaXZNOVd3S0hBU0VzSGIvdE9SeW9JOTBIMVRiTmlU?=
 =?utf-8?B?MnpiK2Q5YW5maEJjcm1GMy95Sno4Rlg4NUUyMndrUTFUVmlhdVdmWHo5WVpP?=
 =?utf-8?B?WFBHREJoTndoR0pndFhPVzJ5Y0JqbTdvWmtVRUR3VFRPdDc5NVdTWFBvRE1I?=
 =?utf-8?B?NklocjJiQXRWUWViS2QvdWZPcDU4RVIwc096YzVEUEFuRm90dDRaNlBRMDNM?=
 =?utf-8?B?dUJCQU8rR1VsZ21HUXlzZS9mRmZwMEdQLzQ2YTlrZFJMUFk2Uk1tRWdCbVdK?=
 =?utf-8?B?RElPalhxR29DaFlKc2ozS3R5RHlRSHNYZVpXc0NjSHp4MnhaV0V1cTBvYXNB?=
 =?utf-8?B?VVZNRHZ4SFpRY0R1Z2FIcU0yaVN6alpRVTdOVVl2R1p3b21HSk92MWFFV1A3?=
 =?utf-8?B?bDA1Y3o0dExRajNUN2hjc2xrUWJYMm5PNXUyZk9sSS9hZUg3ejBWZWovNTZD?=
 =?utf-8?B?SmFTcTdMMU82Q1h2WlZiRFl6TC93cjAxaFVpUDdjVGM5cHdpN3pIdnZ3VFNV?=
 =?utf-8?B?N3pQajY1NWwwdkZyUmRTMjVZYlJ3MHVzNzRlRG1DeEZhQytJVm94VE52UlVy?=
 =?utf-8?B?N3hEdlp4TnpLZkNIZ3VzMXB6QXo2VmlRdGhjcnYyZHhrUVVXb1J0UVNrd2Fz?=
 =?utf-8?B?ZnNyWDU5ZHRVczgwTHc1ZDduWFFud1lxRkdtalU2QVp2bWw0SndtbVJ2WEZH?=
 =?utf-8?B?clJGUzNGZWhDTys1WTllb01vZVRucGZIMGFsN0crUFdqVEFYWnRwZnJ2M2Q5?=
 =?utf-8?B?aXZPOEJTdnVkcTNGMlBEZmVNYWFOamdxZHkxWHpFZ0pFcUJoenhrT1VpUTlX?=
 =?utf-8?B?b3BEcGhUbUtFUnY3bEo4azRJSCtsTFJodG1OZGx3N0ZtMjBOUitNSU80UCtE?=
 =?utf-8?B?cUw0NHVncWx2cTJuNGplSi9XZ0lTaVVVWEVPTDlxNHlVZGIzUjBHdXdWWm5m?=
 =?utf-8?B?MGdRakxPdzlIaFNjaXI2NDVBOXlob0Q5VjU1SEhRYUZETk1xamJjMk9pM0VL?=
 =?utf-8?B?amd3b1IvUkdONk1SajF2bnlIQWFqVVpBYmVNY0JRWWx4NU5sMm45eHNHWjJT?=
 =?utf-8?B?UHU3dXByMXhoN0dkME5VQUdjd0FHNklkSmJtVzJsS0tuc3N2NStQVVY1Ymo5?=
 =?utf-8?B?RnFyVXBHUHdRUStpNXc4MlkwZ2JaQ3ZybmQ0VWtjWFJ6VzlFZk9mNHZzNmlI?=
 =?utf-8?B?WkFlYmQ5TkxiTWpDTTRPdjNjWDhXc1Y5K0hQRUtJQk9GQmtTTE1XeGdMTDdU?=
 =?utf-8?B?YVdCMlhvSHUwTmM0ZXBia045ZndEK2VpVEQ5aWp2OGg1SFRISmtwZzIwckNL?=
 =?utf-8?B?Zm9BbEIwUzBVTThVby9ZVlgxazNWanlTMDhSUGE1blBURDU2SmQwUVVMT3hw?=
 =?utf-8?B?THROMVlXQ2tMSy9VWElrb21qQzJMS1JqRFhTbUg1MzIxV0M1WElKcXUzZFBK?=
 =?utf-8?B?bFNERlgzZEh2dXVwUmIyT3ZZNGdiZXp4NWQranZ1dVM3OTY5VFlSWldJNkFC?=
 =?utf-8?B?MEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c7edad5a-9355-4690-8dfc-08db50993006
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 14:25:07.0206 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NG2ZMjX4XiPCsBKlaIYE7itJlmLAjMO72PEwUosjMNdd3Z2ZwLOv1twZ8Yab9UEsuYmYOZSw0hDGI6WVb8++Dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5555
X-OriginatorOrg: intel.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgQ3lyaWwsCgpPbiAyMDIzLTA1LTA5IGF0IDE2OjEwOjM1ICswMjAwLCBDeXJpbCBIcnViaXMg
d3JvdGU6Cj4gSGkhCj4gPiAjIC4vZ2V0X21lbXBvbGljeTAxCj4gPiB0c3RfdGVzdC5jOjE1NjA6
IFRJTkZPOiBUaW1lb3V0IHBlciBydW4gaXMgMGggMDBtIDMwcwo+ID4gdHN0X251bWEuYzoyMDg6
IFRJTkZPOiBGb3VuZCAzIE5VTUEgbWVtb3J5IG5vZGVzCj4gPiB0c3RfbnVtYS5jOjE2MjogVFdB
Uk46IEZhaWVsZCB0byBwYXJzZSAnL3N5cy9kZXZpY2VzL3N5c3RlbS9ub2RlL25vZGUwL21lbWlu
Zm8nIE1lbVVzZWQ6NjUyMjAyOTIKPiA+IHRzdF9udW1hLmM6MTYyOiBUV0FSTjogRmFpZWxkIHRv
IHBhcnNlICcvc3lzL2RldmljZXMvc3lzdGVtL25vZGUvbm9kZTEvbWVtaW5mbycgTWVtVXNlZDo2
NTE2Nzc4NAo+ID4gdHN0X251bWEuYzoxNjI6IFRXQVJOOiBGYWllbGQgdG8gcGFyc2UgJy9zeXMv
ZGV2aWNlcy9zeXN0ZW0vbm9kZS9ub2RlMi9tZW1pbmZvJyBNZW1Vc2VkOjQxOTQzMDQKPiA+IGdl
dF9tZW1wb2xpY3kwMS5jOjE0OTogVENPTkY6IHRlc3QgcmVxdWlyZXMgYXQgbGVhc3Qgb25lIE5V
TUEgbWVtb3J5IG5vZGUKPiA+IE5vZGUgMCBhbmQgMSBjb3VsZCBub3QgYmUgdGVzdGVkIHdpdGgg
Zm9sbG93IHBhdGNoIGluc3RhbGxlZCwgc2VlbXMgd2hlbgo+ID4gbm9kZTIvbWVtaW5mbyAiTWVt
VXNlZDogMCLvvIxzc2NhbmYoIi4uLiVsaSIsICZ2YWwpIHdpbGwgcmV0dXJuIDAgaWYgb25seSAw
IHZhbHVlCj4gPiB3aWxsIGJlIHNjYW5lZCwgYW5kIHRoZSB3aGlsZSBsb29wIHdpbGwgc2NhbiB0
aGUgY2hhciBvbmUgYnkgb25lIGFuZCBpbXBhY3QgYWxsCj4gPiBvdGhlciBub2RlIG1lbWluZm8g
c2NhbiByZXN1bHQsIGl0J3Mgc3RyYW5nZS4KPiA+IAo+ID4gSWYgdXNlZCBteSBwYXRjaCwgSSBk
aWRuJ3QgbWVldCB0aGlzIGlzc3VlLgo+IAo+IEFoLCByaWdodCB0aGUgZmlsZSBpcyBtdWx0aWxp
bmUgYW5kIHdlIG1hdGNoIG9ubHkgb25lIG9mIHRoZSBsaW5lcyBwZXIKPiBpdGVyYXRpb24uLi4K
PiAKPiBUaGVuIHdlIG5lZWQ6Cj4gCiAgWWVzLCBiZWxvdyBwYXRjaCB3b3JrcyB3ZWxsIGFuZCBh
cyBleHBlY3RlZCBmb3IgYWxsIG5vZGVzIG1lbW9yeSBjaGVjayBub3cuCgogIEJlbG93IHdheSBp
cyBiZXR0ZXIgYW5kIGNvcnJlY3QuCgogIFRoYW5rcyEKICBCUi4KCj4gZGlmZiAtLWdpdCBhL2xp
YnMvbGlibHRwbnVtYS90c3RfbnVtYS5jIGIvbGlicy9saWJsdHBudW1hL3RzdF9udW1hLmMKPiBp
bmRleCBlZjRjOGU4NzkuLmMzMjk3MDEzYiAxMDA2NDQKPiAtLS0gYS9saWJzL2xpYmx0cG51bWEv
dHN0X251bWEuYwo+ICsrKyBiL2xpYnMvbGlibHRwbnVtYS90c3RfbnVtYS5jCj4gQEAgLTEyNyw4
ICsxMjcsOCBAQCBzdGF0aWMgaW50IG5vZGVfaGFzX2Vub3VnaF9tZW1vcnkoaW50IG5vZGUsIHNp
emVfdCBtaW5fa2IpCj4gIHsKPiAgICAgICAgIGNoYXIgcGF0aFsxMDI0XTsKPiAgICAgICAgIGNo
YXIgYnVmWzEwMjRdOwo+IC0gICAgICAgbG9uZyBtZW1fdG90YWwgPSAwOwo+IC0gICAgICAgbG9u
ZyBtZW1fdXNlZCA9IDA7Cj4gKyAgICAgICBsb25nIG1lbV90b3RhbCA9IC0xOwo+ICsgICAgICAg
bG9uZyBtZW1fdXNlZCA9IC0xOwo+ICAgICAgICAgbG9uZyBmaWxlX3BhZ2VzID0gMDsKPiAgICAg
ICAgIGxvbmcgbWVtX2F2YWlsOwo+IAo+IEBAIC0xNjEsNyArMTYxLDcgQEAgc3RhdGljIGludCBu
b2RlX2hhc19lbm91Z2hfbWVtb3J5KGludCBub2RlLCBzaXplX3QgbWluX2tiKQo+IAo+ICAgICAg
ICAgZmNsb3NlKGZwKTsKPiAKPiAtICAgICAgIGlmICghbWVtX3RvdGFsIHx8ICFtZW1fdXNlZCkg
ewo+ICsgICAgICAgaWYgKG1lbV90b3RhbCA9PSAtMSB8fCBtZW1fdXNlZCA9PSAtMSkgewo+ICAg
ICAgICAgICAgICAgICB0c3RfcmVzKFRXQVJOLCAiRmFpbGVkIHRvIHBhcnNlICclcyciLCBwYXRo
KTsKPiAgICAgICAgICAgICAgICAgcmV0dXJuIDA7Cj4gICAgICAgICB9Cj4gCj4gLS0gCj4gQ3ly
aWwgSHJ1YmlzCj4gY2hydWJpc0BzdXNlLmN6CgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBz
Oi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
