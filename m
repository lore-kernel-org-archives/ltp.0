Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01C57C7EE22
	for <ltp@archiver.kernel.org>; Tue,  9 May 2023 14:04:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5DA383CD715
	for <ltp@archiver.kernel.org>; Tue,  9 May 2023 16:04:46 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 255C23CB8C3
 for <ltp@lists.linux.it>; Tue,  9 May 2023 16:04:34 +0200 (CEST)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 75E6D600786
 for <ltp@lists.linux.it>; Tue,  9 May 2023 16:04:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1683641072; x=1715177072;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=h92KebcfvXZX/0TBIKF28ufH2iRwGevzd6wzgvgoDEE=;
 b=Kbexm3Jlge1spbhQBbw8YYanSN/T+yzlSCTmm+Rl57Z4XqZSqmyIL9kJ
 77SYkXJONjdVYwrMC9/luRZl5xEIzWILCJoK4mvAv2rvFVON5Exiwb1FZ
 ZyGQdQSWI7/BaSQxCMg9oQXy8D/RqV5rW9n3Uts/F6gKwh8wgdF+kbknv
 a+MCwq5XbcYybKRvM+BN52EvhOfXSG7JEh3QLWuwBOqpJ+eCBYkJFcjoW
 DERRkN65wCj+ny6zuWQw08O18vCi3zFJlF5/Z85mIJOj83tuNt8MVuIpU
 XsILfXbpkpq8tnvtg7p+BwEMAbFXKiL8ptslTk8Zx7FU11rboCaCH1fki w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10705"; a="348766500"
X-IronPort-AV: E=Sophos;i="5.99,262,1677571200"; d="scan'208";a="348766500"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 May 2023 07:03:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10705"; a="729524003"
X-IronPort-AV: E=Sophos;i="5.99,262,1677571200"; d="scan'208";a="729524003"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by orsmga008.jf.intel.com with ESMTP; 09 May 2023 07:03:36 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 9 May 2023 07:03:35 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 9 May 2023 07:03:35 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 9 May 2023 07:03:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZeI2TVd22FYta+ydTh6kLdVJRipGgfBbGnoHGNjDoLazXXtlZlYFHt9OPvN1T5FFwXqv6mIunOiZnWs1OTY41fGi6S+jZu/RxedyXowEuYmg6JO+K0ukxQAKLQltheODZBoFu7geQsSJdUCXjyvV300qASkfub5M1RBUF7eJglw/Mm9D2SWYX3ryLxyXcwaQ5M2200BjYKz5ThWVLOZTO1isWUBdJQbk7AeP1AQjMrTCyac0cSTqvPvr8VnW0xJWtFNbgNWGbMIU7BDvO7Esp92pavBkUdnSULB8Wfx3eVBjbBBg9bVs03MzrKe7g1tAJoXMiU3MR01ByJgvT90rTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rlTO/BklNGIE0yqPaSmloyoKsmghEe4IHN0dM0ZMUSI=;
 b=Lrnbl3029ajgh12zuVHY1wRCDFff/Gzjz8+a9uxrLBTv867ZDv1Gg63Vebyq51F0re3/EaBzAmqfqB13sYE5c8qWZ9QXhpNjJbPeFeBgMPD1jVaHtv9DyPd2MVqIOi5kmBaCrJVfo4JNwPBmk5Sajz8XNZXS779TOv7lQt1b0bJeF0fCjl+4iiKrB16ej8KzAcZAajSqZH7UI1GtebNpRRXF/LBKd6VzbgI3INvKNX77QP6ZotbHtC3EvYRTGPzvUID6MNf7PHE34xswRHQSfSzmt7CC9STikRI7BQfqHRmHXmy1opx/PMMxs3y5PsIpPzaGc+kaX+zkO5XM3yiqKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by CH3PR11MB8237.namprd11.prod.outlook.com (2603:10b6:610:154::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Tue, 9 May
 2023 14:03:33 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::ae77:4253:55ab:a570]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::ae77:4253:55ab:a570%3]) with mapi id 15.20.6363.033; Tue, 9 May 2023
 14:03:32 +0000
Date: Tue, 9 May 2023 22:05:21 +0800
From: Pengfei Xu <pengfei.xu@intel.com>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <ZFpTIVcGoMTKyRCD@xpf.sh.intel.com>
References: <cover.1683274510.git.pengfei.xu@intel.com>
 <efa47acd652c93a54fb66e17183524b54e561533.1683274510.git.pengfei.xu@intel.com>
 <ZFo1hUZCCXbfhEXY@yuki>
Content-Disposition: inline
In-Reply-To: <ZFo1hUZCCXbfhEXY@yuki>
X-ClientProxiedBy: SG2PR06CA0199.apcprd06.prod.outlook.com (2603:1096:4:1::31)
 To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|CH3PR11MB8237:EE_
X-MS-Office365-Filtering-Correlation-Id: 28717f51-53fa-4044-c9ea-08db50962c2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EgQV1VSNj002YztUT7V3Syf+6h9R2eoD0AWX/OASAlZNaVdMF/HZOLIZjcdjrQmNmLHVEIVsp9qRcaDQXE4ae7ghQCYiiKhWEjHcyV1AXKUKCv7lNO/8fBjSOBljRDBLUBLdNN25Qlz2wxTXbLwifQGIRn/AbDtEIsDPn/dE3F7kpWAyIs27FbbdDJV+QS9aiXnz6MhCFTa0/mRqH/vgwfCxY/jrEbjeNtkgMz3jpWVOSB/jqFHcHuCRPGXPPq8epPzzJmEortpj0B+CmVKhDgviMb3ahcx0/fd+7cdSOQocqDHAciNG8d0+IFCeeilmHhIYDsxBYDnkcKWwVK2vKHJeiv3J7FHtUUDPzt+D6KbaeLYzBTZu7aaO+husxdRFdQdSIuaBUgOTQTnO5J4l3+a42t9rz1fnNt4245ZCUKoDsqia67JwPoDufKmpFp9tILcWS7LCz+4Yd/JnS70AaXulOifnvnadEIeS5fh1i7Yh7dotjmnE5YY0QameCT4PnoOmtPY3A0Jq7DWQoEl4C8v35amac5a9mVCrCXxMxUil7cABPHL3dwCDognGJDRz
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB4839.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39860400002)(376002)(346002)(396003)(136003)(366004)(451199021)(66556008)(86362001)(478600001)(66476007)(41300700001)(66946007)(83380400001)(6666004)(6486002)(6916009)(4326008)(316002)(8936002)(8676002)(44832011)(38100700002)(82960400001)(5660300002)(2906002)(186003)(26005)(6512007)(6506007)(53546011);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3k0d0JFT0hxeEVPaXQ2d0w0Ukd5eHlDczJZVllPZE13Rk9WOExrbUhsMnJG?=
 =?utf-8?B?YWhOU3NQbGo5OTljNEViS3NlenRkTkRGWW1Qay9mbmxvZWNBK3h3NURYWVVQ?=
 =?utf-8?B?bTZwMEdzWUhuWU5rQVU5TzAxeVViYmxPK1NnS0JGdmw0aURsTDNRRUxmT0Zs?=
 =?utf-8?B?TW9xSUxBZENYVXZ6QlBBOVdMcmNRK0VFczRFUnRnVVZtREN6STdtMFJ0U1JB?=
 =?utf-8?B?MTYwbGVQUjFzaDlEbGMvT0N4amhRTkl1UVQzcE9QekFNWlg1WWxCcjFNVHFv?=
 =?utf-8?B?ai9BclFvcmFBL2p2L1pSUXkzeTBxTWQxNGUxaGJQNVFYdHNjNEFiV0k1SHN5?=
 =?utf-8?B?bmd0eVY2WVBxTStXcGM2dUVFcmZsVzlXSHZ6bEsrZFNEaWpMdkNSSVFMTXRJ?=
 =?utf-8?B?UTZXbmUxSTlZRGhTS0hxaXFQcjc0aUsrWTd4YzBnWU45TXl0VjNVd3FTU291?=
 =?utf-8?B?ZElrRXd5eHFKZW9kc0llUUZrN0RteE0weXpaUTdtZWs0V0NkL0lSVWhXZlp0?=
 =?utf-8?B?Sll3UUdHMDFxeXFDVk95NTBoWHNlZWFmOUVWWnN0cHNMalYyZXlYK1hhWFZM?=
 =?utf-8?B?NG9Kd1ovaDdOaG81aDROR3FxNXFDYmxZZDk4bGo0dDRRdlBLMEQzckd1anhk?=
 =?utf-8?B?QjZDSDNrazMyQTJ3QS9vY2NwMHB5Z0dWVFNsUUxYbHcyNjU2MEJNVDkrV2RQ?=
 =?utf-8?B?VEVlYmJLWUFwN3BBRHZoMTNYcHdzRVVqVGhxMCtqeUhLcjBvVkQraE9uREg4?=
 =?utf-8?B?a1NQNEZEUFZObWxmYzR4Sm83Zzh4dGpWanVJSUFEWkJQbGhMaWdHVjNVdTBZ?=
 =?utf-8?B?SjRrMnlkalI0NTAxMFpoMGc2M3J1YWk2MTVlTW55ekZZWFhnWCtmYUUwZmtl?=
 =?utf-8?B?alYvbGF6S3JacDVOdGxkL1ZaVGN4Ny9MaFBTeXJyUDVHZm1pSzVpTzF0dWNQ?=
 =?utf-8?B?WnErTGwwbEhvYkV2MGVyd3NyU1NPWkcrYThFY2RwZGtWNFVaU2FaYU8vQXo4?=
 =?utf-8?B?RW1qQmdoc0hydmlDZFhiNnp0azVqVHJiRFBGRHljak92OEdSemZlQUpZY0I4?=
 =?utf-8?B?VmpuUVlmYnBhNG1QYzNRaFBvdjNZQXVWUjBrSForbWM3YXVYTGFUUURpMjVp?=
 =?utf-8?B?QXRBOU9sSUxLUEdIaFlUeDdZWHltMndkcUZoeHlLMHd1WjVGOXBhWkJySFJ5?=
 =?utf-8?B?aExZQjhQbTJDV0tRYmFRMTFQVVpNeVFjeDQvQmpjZzFMSzBaQ1hPRk5RMDRO?=
 =?utf-8?B?MGhWUGg2Ry9mMmtNQzBEd3k2a2RQZHB5TDVWQ1RocjV2Lzl4UTZjdjlwZGZF?=
 =?utf-8?B?MHJrcWRpVzNHZjBZV2FkL0MyMGpvQ2hKQ004ZDJ3djlObm1CUlplWlM0eTFK?=
 =?utf-8?B?UWk0SEFMOG5yeXk4Vk00ZTRsUm9TOE0zVjB4MUxzTjcvU1kwT1dMMVd2UzBt?=
 =?utf-8?B?dFpadkZ6dThYbnpTbDFiQnEvSStyOFU5eThUZmZGWHVJYlRPZHJOSjd3OHRI?=
 =?utf-8?B?Z3k2Uncxa1hHNDV1dGJpMExTR2liMnVBYU1obDlFbTB2TExOK2JxYmlIdFRo?=
 =?utf-8?B?SHFPaVBaYWV6WmovM1p2czVTYzMzbi9vVFFxTytZM2hEYWo1WVV3SVdTdzVD?=
 =?utf-8?B?YkxpWk5NNm9wNjViZzlSdjB1bFBydGxtWStnaVNZZE5NVkx0KzU2RVZ2a1pu?=
 =?utf-8?B?dWFvdS81STVLNlVOLzhtNjBMcHo4ZUFMVFd1YlJCRHRuUXJsYnBFLzNrMUk1?=
 =?utf-8?B?aVovb0tGTUhhQ2pTSytlNEtaNEF6L1N6cWxubDZYblp3U1pYT2tyNHd1RFYv?=
 =?utf-8?B?bnJTV2doek9xckV2eFFlcVd1bnFHdmxCbUdIanp6MG51YUp6cTFWZmRKOW13?=
 =?utf-8?B?b2RJcENiYjJIMmtINFdpaW9kSFVwUGZPZDlqZmo2S0JNM1pVMjM3SW02djdW?=
 =?utf-8?B?ZjlnUTcxVE51WlI3UTRiUmlROGRrbXJBelIyRDJBdE5FQnAvd3JCKzNGZnI4?=
 =?utf-8?B?VkpNSmJzT2NEUHZCUVdMdjdUMnhmR0RZejUxUjN1TlcxWlFuMkpZMlNkamtH?=
 =?utf-8?B?aE9TQmFNVmV3c3JROUZwam41dHhRWmgrdFd2U3ZwcUQ2K3RML1ZqckxnZ2M5?=
 =?utf-8?B?UGVvLzZWeEJHZ2JqOHE4cTQ5VkJnZTZESTBXTVhtN1FFWnBnazQ5bllXSTY2?=
 =?utf-8?B?b3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 28717f51-53fa-4044-c9ea-08db50962c2d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 14:03:32.1167 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G5M2W4igcerG4YFKR9SmMn7DAt2IFx8BsZAR0KDAHTtz1BxaQB6OFfQiM7Ne39/8cc7tCerXzu9OVUIWUWeLow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8237
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

SGkgQ3lyaWwsCgpPbiAyMDIzLTA1LTA5IGF0IDEzOjU5OjAxICswMjAwLCBDeXJpbCBIcnViaXMg
d3JvdGU6Cj4gSGkhCj4gPiAgCj4gPiAtCWlmICghbWVtX3RvdGFsIHx8ICFtZW1fdXNlZCkgewo+
ID4gLQkJdHN0X3JlcyhUV0FSTiwgIkZhaWxlZCB0byBwYXJzZSAnJXMnIiwgcGF0aCk7Cj4gPiAr
CXRzdF9yZXMoVElORk8sIk5vZGUlaTogbWVtX3RvdGFsOiVsZCBrQiwgbWVtX3VzZWQ6JWxkIGtC
Iiwgbm9kZSwKPiA+ICsJICAgICAgICBtZW1fdG90YWwsIG1lbV91c2VkKTsKPiA+ICsKPiA+ICsJ
aWYgKCFtZW1fdG90YWwpIHsKPiA+ICsJCXRzdF9yZXMoVFdBUk4sICJGYWlsZWQgdG8gcGFyc2Ug
JyVzJywgTWVtVG90YWwgaXMgMCIsIHBhdGgpOwo+ID4gIAkJcmV0dXJuIDA7Cj4gCj4gV2h5IGRv
bid0IHdlIHVzZSB0aGUgcmV0dXJuIHZhbHVlIGZyb20gdGhlIHNzY2FuZiBpbnN0ZWFkPwo+IAo+
IFdoYXQgYWJvdXQ6CiAgSSB0cmllZCBhcyBmb2xsb3c6CiMgLi9nZXRfbWVtcG9saWN5MDEKdHN0
X3Rlc3QuYzoxNTYwOiBUSU5GTzogVGltZW91dCBwZXIgcnVuIGlzIDBoIDAwbSAzMHMKdHN0X251
bWEuYzoyMDg6IFRJTkZPOiBGb3VuZCAzIE5VTUEgbWVtb3J5IG5vZGVzCnRzdF9udW1hLmM6MTYy
OiBUV0FSTjogRmFpZWxkIHRvIHBhcnNlICcvc3lzL2RldmljZXMvc3lzdGVtL25vZGUvbm9kZTAv
bWVtaW5mbycgTWVtVXNlZDo2NTIyMDI5Mgp0c3RfbnVtYS5jOjE2MjogVFdBUk46IEZhaWVsZCB0
byBwYXJzZSAnL3N5cy9kZXZpY2VzL3N5c3RlbS9ub2RlL25vZGUxL21lbWluZm8nIE1lbVVzZWQ6
NjUxNjc3ODQKdHN0X251bWEuYzoxNjI6IFRXQVJOOiBGYWllbGQgdG8gcGFyc2UgJy9zeXMvZGV2
aWNlcy9zeXN0ZW0vbm9kZS9ub2RlMi9tZW1pbmZvJyBNZW1Vc2VkOjQxOTQzMDQKZ2V0X21lbXBv
bGljeTAxLmM6MTQ5OiBUQ09ORjogdGVzdCByZXF1aXJlcyBhdCBsZWFzdCBvbmUgTlVNQSBtZW1v
cnkgbm9kZQpOb2RlIDAgYW5kIDEgY291bGQgbm90IGJlIHRlc3RlZCB3aXRoIGZvbGxvdyBwYXRj
aCBpbnN0YWxsZWQsIHNlZW1zIHdoZW4Kbm9kZTIvbWVtaW5mbyAiTWVtVXNlZDogMCLvvIxzc2Nh
bmYoIi4uLiVsaSIsICZ2YWwpIHdpbGwgcmV0dXJuIDAgaWYgb25seSAwIHZhbHVlCndpbGwgYmUg
c2NhbmVkLCBhbmQgdGhlIHdoaWxlIGxvb3Agd2lsbCBzY2FuIHRoZSBjaGFyIG9uZSBieSBvbmUg
YW5kIGltcGFjdCBhbGwKb3RoZXIgbm9kZSBtZW1pbmZvIHNjYW4gcmVzdWx0LCBpdCdzIHN0cmFu
Z2UuCgpJZiB1c2VkIG15IHBhdGNoLCBJIGRpZG4ndCBtZWV0IHRoaXMgaXNzdWUuCgpUaGFua3Mh
CkJSLgoKPiAKPiBkaWZmIC0tZ2l0IGEvbGlicy9saWJsdHBudW1hL3RzdF9udW1hLmMgYi9saWJz
L2xpYmx0cG51bWEvdHN0X251bWEuYwo+IGluZGV4IGVmNGM4ZTg3OS4uN2U3NTA0Y2FjIDEwMDY0
NAo+IC0tLSBhL2xpYnMvbGlibHRwbnVtYS90c3RfbnVtYS5jCj4gKysrIGIvbGlicy9saWJsdHBu
dW1hL3RzdF9udW1hLmMKPiBAQCAtMTQ5LDExICsxNDksMTkgQEAgc3RhdGljIGludCBub2RlX2hh
c19lbm91Z2hfbWVtb3J5KGludCBub2RlLCBzaXplX3QgbWluX2tiKQo+ICAgICAgICAgd2hpbGUg
KGZnZXRzKGJ1Ziwgc2l6ZW9mKGJ1ZiksIGZwKSkgewo+ICAgICAgICAgICAgICAgICBsb25nIHZh
bDsKPiAKPiAtICAgICAgICAgICAgICAgaWYgKHNzY2FuZihidWYsICIlKnMgJSppIE1lbVRvdGFs
OiAlbGkiLCAmdmFsKSA9PSAxKQo+ICsgICAgICAgICAgICAgICBpZiAoc3NjYW5mKGJ1ZiwgIiUq
cyAlKmkgTWVtVG90YWw6ICVsaSIsICZ2YWwpID09IDEpIHsKPiAgICAgICAgICAgICAgICAgICAg
ICAgICBtZW1fdG90YWwgPSB2YWw7Cj4gKyAgICAgICAgICAgICAgIH0gZWxzZSB7Cj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgdHN0X3JlcyhUV0FSTiwgIkZhaWVsZCB0byBwYXJzZSAnJXMnIE1l
bVRvdGFsIiwgcGF0aCk7Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIDA7Cj4gKyAg
ICAgICAgICAgICAgIH0KPiAKPiAtICAgICAgICAgICAgICAgaWYgKHNzY2FuZihidWYsICIlKnMg
JSppIE1lbVVzZWQ6ICVsaSIsICZ2YWwpID09IDEpCj4gKyAgICAgICAgICAgICAgIGlmIChzc2Nh
bmYoYnVmLCAiJSpzICUqaSBNZW1Vc2VkOiAlbGkiLCAmdmFsKSA9PSAxKSB7Cj4gICAgICAgICAg
ICAgICAgICAgICAgICAgbWVtX3VzZWQgPSB2YWw7Cj4gKyAgICAgICAgICAgICAgIH0gZWxzZSB7
Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgdHN0X3JlcyhUV0FSTiwgIkZhaWVsZCB0byBwYXJz
ZSAnJXMnIE1lbVVzZWQiLCBwYXRoKTsKPiArICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4g
MDsKPiArICAgICAgICAgICAgICAgfQo+IAo+ICAgICAgICAgICAgICAgICBpZiAoc3NjYW5mKGJ1
ZiwgIiUqcyAlKmkgRmlsZVBhZ2VzOiAlbGkiLCAmdmFsKSA9PSAxKQo+ICAgICAgICAgICAgICAg
ICAgICAgICAgIGZpbGVfcGFnZXMgPSB2YWw7Cj4gQEAgLTE2MSwxMCArMTY5LDYgQEAgc3RhdGlj
IGludCBub2RlX2hhc19lbm91Z2hfbWVtb3J5KGludCBub2RlLCBzaXplX3QgbWluX2tiKQo+IAo+
ICAgICAgICAgZmNsb3NlKGZwKTsKPiAKPiAtICAgICAgIGlmICghbWVtX3RvdGFsIHx8ICFtZW1f
dXNlZCkgewo+IC0gICAgICAgICAgICAgICB0c3RfcmVzKFRXQVJOLCAiRmFpbGVkIHRvIHBhcnNl
ICclcyciLCBwYXRoKTsKPiAtICAgICAgICAgICAgICAgcmV0dXJuIDA7Cj4gLSAgICAgICB9Cj4g
Cj4gICAgICAgICBtZW1fYXZhaWwgPSBtZW1fdG90YWwgLSBtZW1fdXNlZCArICg5ICogZmlsZV9w
YWdlcykvMTA7Cj4gCj4gCj4gLS0gCj4gQ3lyaWwgSHJ1YmlzCj4gY2hydWJpc0BzdXNlLmN6Cgot
LSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRw
Cg==
