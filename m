Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ECDCC47077
	for <ltp@archiver.kernel.org>; Thu, 11 Jan 2024 09:17:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4BD963CD0E2
	for <ltp@archiver.kernel.org>; Thu, 11 Jan 2024 10:17:53 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8E40B3C75A3
 for <ltp@lists.linux.it>; Thu, 11 Jan 2024 10:17:37 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=198.175.65.10; helo=mgamail.intel.com;
 envelope-from=pengfei.xu@intel.com; receiver=lists.linux.it)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 92A311000F02
 for <ltp@lists.linux.it>; Thu, 11 Jan 2024 10:17:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1704964656; x=1736500656;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=/WjdWzXsCwE7UL3vvrJITspHUp3ZMXZRWdqy++KWGgc=;
 b=XOcQAamkvovHuG+8k5QQ8rQDWi/7QduBPcOI5TNUef4uPf45c+fSSbGJ
 S5GQDpPgkl6kGBhxdz6DDEe2kvL9RQ3nJJnBqhJfhR4qj1Kl4stBJ1p/y
 trElimwvLCTjR05zcdMj8s5Rfc59at/Z3rZ8avTlFfHB6JEjU8WvJ1RUb
 wDRpALLEe0ZXai/UY6+sZsBMMyYFArnUHCzC/96cQnvT5rfJTsfw9gJrx
 W06pv3BCAAehBty5GD+tNZjWSHwIuSIqgoCRoz24nq5k70B+DxuXEUoTd
 nShmnlU5WEwIRnEYQJuTFrjrbSXFPeABWBpfdbDXvHahTNLnSfvADdW7H Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="12146855"
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; d="scan'208";a="12146855"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jan 2024 01:17:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; d="scan'208";a="30934091"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 11 Jan 2024 01:17:32 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Jan 2024 01:17:31 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 11 Jan 2024 01:17:31 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 11 Jan 2024 01:17:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZO3EmPq5lOqf1kwNncCFqQawS4cwaHgl+Y/Cf7Z2cJAAAIraVBhiA75DnvFfV7GRpqDt6LvdQawPDHkOJSu8uTAktvwmtMHtTt9Jjl1f+U+1bKvqIDVsrahsqviQ55cSPKSbOfiW4sK3o7SNTCSX96KPzfPbEDzUQmhMIrkaIc1QyRzQTOWzf/kEtgKt6f1EciFQ8xtfYQWxivYA64GXOeT6FeASBtfTscpKmcpGX4ClrO1W1BgiH9YDMG7jcGUI8/NSWtVIVwbwTK3b2Ha+gDvEA65hx5mb5hzAWc0/5xUW5Xkbcn9Anw85+iBjYKYFqo1YeJz+l6LHOgWb4GRMTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RXxL6tC/HuVkSvb4NwoJ2ChV+RmIejuzO1ES2OFsDpU=;
 b=Lh2R8MG5N8kcJIKxiw+ha++M8+QdVlBPm+HgOk6rkD4uFo+oE02WZSmTMC+nYBmSbQ15zX1FrJhwrO2s/+SJCBFwOJqc8RUWFErZDuIqemR0la8B5oZeyIYW1EAaqVIL/HyhLXcPN7WU6fyX8VW3C/h0+WGLfHp63gyHL9TiPi3miQnCcNnagggYfhxOZcJ/AuU6+elHr2TazL3Oaq8jHTT1hmiMG2jD8mN3Ueb4/bIE39prubZTFRTjklfCMH9qHjtrZ2y6keFbYPPHrnl+PkrMcHdOR2c2BZucF+ZqrGBKRibpCb/3lXwn7CsaEMWG10a5lYT6MZBe+4At/mxHjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by PH0PR11MB5902.namprd11.prod.outlook.com (2603:10b6:510:14d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18; Thu, 11 Jan
 2024 09:17:30 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::25c4:9c11:c628:1283]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::25c4:9c11:c628:1283%4]) with mapi id 15.20.7181.015; Thu, 11 Jan 2024
 09:17:29 +0000
Date: Thu, 11 Jan 2024 17:12:02 +0800
From: Pengfei Xu <pengfei.xu@intel.com>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZZ+w4hTZ0F5Ypf2l@xpf.sh.intel.com>
References: <cover.1704949719.git.pengfei.xu@intel.com>
 <48efcb1293a682182fc5db23f01be7af2889e26c.1704949719.git.pengfei.xu@intel.com>
 <20240111085152.GA1859394@pevik>
Content-Disposition: inline
In-Reply-To: <20240111085152.GA1859394@pevik>
X-ClientProxiedBy: SG2PR03CA0117.apcprd03.prod.outlook.com
 (2603:1096:4:91::21) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|PH0PR11MB5902:EE_
X-MS-Office365-Filtering-Correlation-Id: 35d3a9cd-287c-4d44-ad3d-08dc128622b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dF6UsLkGKWic/jbnQyobBh2uLvXApG9EX21hiD4Lt4ak0KVY1THzy4sm+2eafDQYoO9Nk0q1F96VOCQCJ9794uTR07bLEk+hy+aNdLydSYF/L8tr0WeEBYROVCbU1D/BLeExGM4iovGqJIJYu5J4EiptS2QsE7Qp7Htv5hMu51C+nqDdxLZRSwcOLgI7eYdETCCPiQr5SZZLH5l3BDlXDTz34IYk2UTMoGQYmbSdAzcoRlnxR7OrUss8r1suHaweCofS1CDCS/R4/W7CWRvX65NqmVX5SNAOKSNXTb5dR7LOzuDxQToU/EzXAdjVQdSWjaGAjloF053NVjkJGjhoM1DRxh413Y72YyhsS7YhHl56Q/NvaDIRB7cGILOvd4ubYsURL/W4P8opaTSg4GHIp1+soi65RNNdPVPgIsswzn2QXcwfSPSm2i6pPi3opubZkZsLPUZOAuLaL2h5cKvAzssSje1xVYc3XRLS6oj/1rZl/CSWt5PhNamLigTfoK7E9m682ew+bIkn+mHFUG1TAs/KT7nPpVW0C5leGx0+jgabPJ/hKDiPC7d/1wiYEIFZO5U1XIXklabm9tGTjJGCFEpLKarhWEJ2+/fqiZHIijBOLSM97umMbUXoP7dwdt+k3lZVLAq9q1QMnRO6Y9djow==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB4839.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(39860400002)(346002)(396003)(366004)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(107886003)(26005)(6666004)(966005)(478600001)(6506007)(53546011)(6512007)(83380400001)(5660300002)(44832011)(41300700001)(4326008)(6486002)(66946007)(8936002)(6916009)(66556008)(8676002)(316002)(66476007)(2906002)(82960400001)(86362001)(38100700002)(67856001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Y71fKEDmJpEOXFxyGPcOBpaTdePUFJRj4uMlx7YTyVUyAu2kZxMbBB6kmCrY?=
 =?us-ascii?Q?pFIRO5D84zefRpPv0j/g84UTakUQygPyTxhWRhtRLlXfq/w8HTYUWwnG+KcS?=
 =?us-ascii?Q?EXQy+qqY6onbmkbG2ozqRMZkez4uDtJlJP4H9zoRePeEk9lLN3+dqwWB0sSq?=
 =?us-ascii?Q?Hq2hZzBdfTW5PeQ7N+xU1ZdhTbdwmbPNP2XCwqA5RakKl0h8uSCaYd+v9b2I?=
 =?us-ascii?Q?vBH86VHnwXjC4gHf9i29+fdrUMwAGEEftPHA67m8QhP6//j5UQhFEp66HCEk?=
 =?us-ascii?Q?etTtvxRf6Gd2xb5swjrdWt4tKaMgvfST41dBzLE5hn/zTNZDopfSkziEAYox?=
 =?us-ascii?Q?Z1/oPz2RgSPGyuQKSmCjJ7l+dIUpV+Wc+O2BiRYRIeDKltijJ7y9hu1vpsoW?=
 =?us-ascii?Q?DaCVp0NHAnec12RuKaT64oe5b7fdROKLYjILs6Av12seBTgFokGyDDuuTy1W?=
 =?us-ascii?Q?WWcs+mdO5OOiRBbdZ+j608kZVHrHwZHU2ZJnE+LbH11GaOrOp4tj5QoEamJI?=
 =?us-ascii?Q?QTjAAW+T1NI4vehzx0aJ6QGvyfbFXacHRBe0gjj9yigUOIayrCLfF7j/qBME?=
 =?us-ascii?Q?f6iUipRwcxkd8L3RuGdv1XQiIgIxFzokNKKyMpzV/gUeoF0on5FLhpH1+Z9P?=
 =?us-ascii?Q?nDrlTRgfh2ARHIlTRhMI+yTPwzXZkUioK3Vf9kkqIxGrjDnXda+gqeX0qyGn?=
 =?us-ascii?Q?ihAW8t89jr9VXqXkkipI+86uu2vaAVBT+qC03mDna1aujYA/iJQd6jtGKd0A?=
 =?us-ascii?Q?Mpfug0mT5vMehrYIlXA6vuI05iV5Yf7XbKPmqANtR2cE+cd0ryIYClIEqjyS?=
 =?us-ascii?Q?5uWw8lNKJaax4wT1eXfiTBynsGe7pzX/wSqyQr1vL4rGnLR0lC7QKMevfP1P?=
 =?us-ascii?Q?OaKpbomnk3sPt5bLIZmITuxLYw5NIwu8b7sBoIGKE2Z1t0RiRwnm7YYj3qCz?=
 =?us-ascii?Q?BaFU33uedho9Ji20Dp5UZl4qIgcg4E+Qwel5tx7rUsMq3tLEquM33XD4jMcJ?=
 =?us-ascii?Q?aDuK/i2n7PjMQN6rrBlsjgV5YUggIrx9dzF4RuL1jFclc3utXrpGdP9Dlh++?=
 =?us-ascii?Q?8u8M5MmcTRB9zzfCjHJ7s7QWRdKeMimiMbgTNnbXjL6Tbura5/RwPAZyfO3R?=
 =?us-ascii?Q?j7d311epT4/RDC1aAw4DHQFDSJfQkTT9mMas8dYlup2l88Nv95DMlSuF/SLv?=
 =?us-ascii?Q?62nD7X2QNNMNoCFO8SnzWlBxAqe2iT9rId2IGeZIZoQl2mNHhM/3cUjL0o2e?=
 =?us-ascii?Q?9HxrZPLlpW8iHTcSSpcIxGJFBv4YGCD1/MnCJrB8hVAHMXzriUjUYy4H1/eb?=
 =?us-ascii?Q?y5UZ6Ux6Vi4WTfQG1Ng2EExnIYxDQNp73JBQoectzfg/f3rtUpF1FZd+LFuq?=
 =?us-ascii?Q?pxgc5/kOQEPZybu7X4iZBpAIFfzHgDNTzFQwB40TZt0WMlhq43GtMbs+g+Ad?=
 =?us-ascii?Q?I0WVXRzK7M09ta98PQiHRHU6KmMALqG86ziShHzNY5bdspNeqECSqfypJNRG?=
 =?us-ascii?Q?tgpiOmWe/gdt0dYadYUwoHF2biph+smkad1Z7KAjYDryOppNr7nKd8bZRGXv?=
 =?us-ascii?Q?QPnOKUCB1jvNRiqfhVhV++IXII5CuSLxqa1YzukQ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 35d3a9cd-287c-4d44-ad3d-08dc128622b0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 09:17:29.8384 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nCjAacCsIhfTVvNoVAB7ONpdfUstHMF8CvRDA/NMEQtSUr/DvuIgH60xG80fAd7shqOxQv1lAqRI6w45u7XNjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5902
X-OriginatorOrg: intel.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
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

On 2024-01-11 at 09:51:52 +0100, Petr Vorel wrote:
> > Because the following patch will fix the add_key syscall incoming data boundary
> > size issue, 6 bytes incoming data should pass:
> > https://lore.kernel.org/all/1784441.1704907412@warthog.procyon.org.uk/
> >  -> https://lore.kernel.org/all/1850031.1704921100@warthog.procyon.org.uk/
> > In order to test above boundary incoming data size, change the dns_res_payload
> > size.
> 
> > Signed-off-by: Pengfei Xu <pengfei.xu@intel.com>
> > ---
> >  testcases/kernel/syscalls/keyctl/keyctl05.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> > diff --git a/testcases/kernel/syscalls/keyctl/keyctl05.c b/testcases/kernel/syscalls/keyctl/keyctl05.c
> > index 90cf1ef06..50e78853c 100644
> > --- a/testcases/kernel/syscalls/keyctl/keyctl05.c
> > +++ b/testcases/kernel/syscalls/keyctl/keyctl05.c
> > @@ -199,11 +199,11 @@ static void do_test(unsigned int i)
> >  	 * We need to pass check in dns_resolver_preparse(),
> >  	 * give it dummy server list request.
> >  	 * From v6.7-rc8 commit 1997b3cb4217b09e49659b634c94da47f0340409:
> > -	 * the incoming data for add_key syscall should be larger than 6 bytes,
> > -	 * because struct dns_server_list_v1_header without body is 6 bytes.
> > +	 * the incoming data for add_key syscall should be not less than 6
> > +	 * bytes, because struct dns_server_list_v1_header is 6 bytes.
> > +	 * The minimum payload will be tested here for boundary testing.
> >  	 */
> > -	static char dns_res_payload[] = { 0x00, 0x00, 0x01, 0xff, 0x00, \
> 
> nit (already pushed): \ is not needed for arrays.

Indeed, thanks for your remind!

Thanks!

> 
> Kind regards,
> Petr
> 
> > -					  0x00, 0x00 };
> > +	static char dns_res_payload[] = { 0x00, 0x00, 0x01, 0xff, 0x00, 0x00 };
> 
> >  	switch (i) {
> >  	case 0:

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
