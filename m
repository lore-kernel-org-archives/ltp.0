Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 392BBC4707B
	for <ltp@archiver.kernel.org>; Thu, 11 Jan 2024 08:30:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AEBCB3CE41F
	for <ltp@archiver.kernel.org>; Thu, 11 Jan 2024 09:30:49 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CBF693C8B1F
 for <ltp@lists.linux.it>; Thu, 11 Jan 2024 09:30:33 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=198.175.65.10; helo=mgamail.intel.com;
 envelope-from=pengfei.xu@intel.com; receiver=lists.linux.it)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 8BF2E602571
 for <ltp@lists.linux.it>; Thu, 11 Jan 2024 09:30:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1704961832; x=1736497832;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=J/1r9N+StyQNMWfWgySHe+Beki9K2rD3/A8wbB0hLlA=;
 b=i13rFvhO8lEUeTmU29hMFAMZ0nAF7Z3nRq3UCo2rMmbyP8beMEord+xk
 7lnaQKwQgKC0zJNd/+G+B+4jt6o0xJM7oNiOCTKNYHpxNRNHyAJzmeAmp
 +SZ83USRQBCj+1Yn31+U1q0Y7rRMtHMJRGCQjAtBvF61+E0e8pfyJD39d
 odKQrJUEoznnqWZP9THSlw/XMPrU6WxYusX4sqhagPcR4DlX2LGqEFubV
 dqvVH+HqR4sLN4hpOJLbu8Crn7GIr7RSVofga7zyNr3D4eZz+PXLi6Cvl
 DX0lt49zb9zZCSWImUUeXBnGYOlAmgGVHCdHwCAt9tZ/92BTG3IwcxOXu A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="12134481"
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; d="scan'208";a="12134481"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jan 2024 00:30:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="732138833"
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; d="scan'208";a="732138833"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 11 Jan 2024 00:30:23 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Jan 2024 00:30:22 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 11 Jan 2024 00:30:22 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 11 Jan 2024 00:30:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dCc4ucEDerXX2Oe1qA9uzS2SvNqdjeRXsYa5+xZiDAADgaQb3UnmY5c8FWOb/EN19LGwX2/gOrnp8pCC0LPO+6sIIE8t2+t+X2qU7KQ1AU8M9iDjbf4fzxF6Y27eKXtljAKDnAG8Clr7N96y/Mq6ktXQl4nPtB97pwYL6IbGnQEMYK2mbC0x4MC1wLrZkT1HB/96sxgGmmNRA5zkQXwLsof9D8NGLaXVpK+9o8uqXFbVi4+w/binU4rhaclHjWEF3jeSegzR21hmE1OzpWuPTTQtbHePkgjbVIL3hpuR/ac4BUAeCFua7H1AhoUK6oIPbpbh5G4wFDWUrlcBiywXQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NDhzyrQ0LLt5Nw8VVXIb8XNKfoBqsF+abHJYzsKEOOQ=;
 b=aCq/mWS1pXSkIZq2BRsdOz5ZF797gKZCMu6+/iUEwLs2XCm2gNqQ+fmH1W9fwoCOlCmuvBXVjvnCpZ6wQF+ZCo8kYPfL30Igw1TwatarCtKXMso/V0rMXrXvlwjZDZD/b0CHsl0tdWCEC0E83dfOqmLDnfuAKWlWzWq+D7DHTy9JXvnniguvEX9akO4TQPbWhHhHexZHETgjRUirlGMXwb6r+DbHdKXjCsn6N25c88S5aUnpTR8MzH/txP9PywHxNbyN1arkpturS9ksmF24WJsNsGO00iHJTlBdQoWx0wf58up0gpmNMWXuv2FYuaDPMT6NMcH+T9wx2Qdndo3/CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by CH3PR11MB7203.namprd11.prod.outlook.com (2603:10b6:610:148::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.24; Thu, 11 Jan
 2024 08:30:20 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::25c4:9c11:c628:1283]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::25c4:9c11:c628:1283%4]) with mapi id 15.20.7181.015; Thu, 11 Jan 2024
 08:30:20 +0000
Date: Thu, 11 Jan 2024 16:24:52 +0800
From: Pengfei Xu <pengfei.xu@intel.com>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZZ+l1Dl0vSFl/qRr@xpf.sh.intel.com>
References: <cover.1704868967.git.pengfei.xu@intel.com>
 <f60daf00d0de49e54a5389c73c90994e7711a7d1.1704868967.git.pengfei.xu@intel.com>
 <20240110175931.GA1766165@pevik>
 <ZZ9aR/SEWl57q6aR@xpf.sh.intel.com>
 <20240111082549.GA1856272@pevik>
Content-Disposition: inline
In-Reply-To: <20240111082549.GA1856272@pevik>
X-ClientProxiedBy: SGXP274CA0013.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::25)
 To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|CH3PR11MB7203:EE_
X-MS-Office365-Filtering-Correlation-Id: d8807c09-9827-4289-c568-08dc127f8c3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hxa5TVqLNvQcBRp9nT7gEXWtt9Mt0ry/idZgfO3ESvH0hlaMJcBbr3FvBxgmW1F0H8mM5vtT1r3DGkl/7hWAbBr4nOSHX+wro57pXapoTfwM84mJNlTm4JBucHsqHzU12tp6JdCQbXwhCBRfzDHg+SZsu9OY7PRqBCjiS5kJY4P34722GnYDhVypY1hOb/seT2bIlfuMeiY/aELlSmTdrokQNYIzQiXgo/K1PbQEH0L3UJkbCPXDI2hT98I0pK+qpkSspk7Hwjwn4DOB/XzJ90gMDyImBp3U9kwXm53mhSGsS/GyAbuyDoYQKShdNT6IMRatG/0J5e31rga1a44kExhe9gHc1YA2SrGiVUr+YIa7MxzTF6rPBEQrc2WHOlsw98vT79Zsv0M8tzRstnZLTn340GFcyfriSbrCJS2D81xIWlFycGiA4IJLywtPBFzpIDR83RkOZNhmDJy1RO20ykguzbuVhcpyWzOTIAOJju3a5s6DIIyFn+nJMISEF8X1h89vROQIixlP435uYEMxgwecUDIE+4TdPtDX0pCPz419ooIvkMULpT4JNKFSqfmL8ASRVfN8polUu5BseOQ9wQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB4839.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(366004)(136003)(396003)(376002)(346002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(38100700002)(6486002)(966005)(8676002)(54906003)(66556008)(66476007)(44832011)(4326008)(8936002)(6916009)(316002)(66946007)(478600001)(82960400001)(53546011)(26005)(6512007)(86362001)(6506007)(6666004)(2906002)(5660300002)(41300700001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tqpBBL1YLod+VJryzhJt3igjO/bHzxJsoHmIQJcAMq2XcqpYTnVLzeyAZjXX?=
 =?us-ascii?Q?+EhEgRCV2WEd+95LlPmqGDHRfPWK3u82mvjzffQZAF/uaA9HnniO1fn/jFz8?=
 =?us-ascii?Q?nf65/fIZTELWiFrzWr/N5cMJAkSxEr9iAkwbZpG3TU9dxrFRuC+cvGfQRH5H?=
 =?us-ascii?Q?udZSVbqO3ft51bSo42j+sUDae9+pFiUnWeTmEdPi2DnmVVKywUJgjyxC/EF5?=
 =?us-ascii?Q?xMD6a/EM9OBjfhoE9PURAHEOlH1CDUFeRYZVPxw2HgvijTRv+T3BokYK2kov?=
 =?us-ascii?Q?v8RKN0cATxAUyDbcpfOIqdUDQs2AKrUOGgfP0k4AdC9851B986y3sdazaurZ?=
 =?us-ascii?Q?6WXmGaE/EwUFsrFQVZCWVpN1j5//PEgwr1BMtKRwIGF1+Gx7O1lyHqNApcE3?=
 =?us-ascii?Q?cBVXfAIeCPCbQeMw2a3/jxUN9y1/dfV23+OPwrULtVwBIrx4tmpUBDkmPBpL?=
 =?us-ascii?Q?L9hWI/3HbRfO0szGgRhcf3AFCc7Bou8ZBAAQP4zoccp8t6d/Y+VpAvpyYR2D?=
 =?us-ascii?Q?nFkquJKcHW2wmbpyqPt1JalsadUEYuL4hq5FS1TQaIy/OoIkS1FrNDQOTkYp?=
 =?us-ascii?Q?sk3Xw6tVGVySw8t6odMbx901kxrmVjDwbljrnVEI8nPkp5UufM4j3FAgahji?=
 =?us-ascii?Q?AjIiImv41VK2HJ/rhNA0dP+31IhtRKlbLN3+bcvfsI8u7KBOXOTMrliqizE2?=
 =?us-ascii?Q?KRT0k6MTBjUUE3t3eOG9fZvln+lsMd/cNC3VkJWoXnkSYmtS5Msm9AvOZpL7?=
 =?us-ascii?Q?BGtwAYfw+K9yrM6qfiGcQagGv3oayiTe7sg1yH3OGxDyUjLOmpOpRpOkHSAh?=
 =?us-ascii?Q?UObN/mMvetgC6FniQYfip4/n1d+ZGT+VC3I3Zz//F0YoJAd/Bp+fXcyQSG2X?=
 =?us-ascii?Q?96mcWjNAOfErLZav39GWGRDL54hA6be7FPuDtudfFRIDf0sOdaJwEo+3S+UX?=
 =?us-ascii?Q?nw1eBgOpEmsPG1CAThcpT1OfS7e7qveQNlpZ+4OtDCLDED4Ux+D4n9+/CAei?=
 =?us-ascii?Q?zbroB8bfkOUNOMHU7zoXjb0Ty7bW8tRZ7mcPn0RPD1jL3Y7Smf2sq9LyEShw?=
 =?us-ascii?Q?Z4UxJMuRklBwyjz0O8LezhVqrY0S54/rRL7+5GY/CYHIkB6gKkXFaTxKmrOO?=
 =?us-ascii?Q?xqYVDjT9suOsWvVz5EZvFlnRgVpuIanB2PFR9PKnnifZn5JfW7QI7oTlYM/G?=
 =?us-ascii?Q?UAA68yNHcc/2Ng4jRa3+BOa5YcJXI+tszdJd61bfnupJm0/DAwT0eGr1hsGU?=
 =?us-ascii?Q?k5I0Jg+cm48Ep3DbsFyFhu3m7hdSt55efET7/u1h+5/ShGULfQ5PjZtweTFG?=
 =?us-ascii?Q?zk7LpXXB10w4W0fSNqr7fndWFvKkpyJ4lVd0Tq7wLLq5N3OQPc/fCe2l9zNp?=
 =?us-ascii?Q?GIcnRG7OD+16r2NeWTkCBFmLlEfZd0ifCQ1lhXQ9Z/VJi6akeAXsfwJo5dw0?=
 =?us-ascii?Q?RAaK/RqwuZALxqUWIxx0Irmr6duORuarNzZ7hExjdvEOcA185hJUAxgYUygb?=
 =?us-ascii?Q?hiwtWOrNh521NLovU6sZ8L+bkijP9AmVEtsZ2bkPn6/LN5I/FP4ExZdeUhbx?=
 =?us-ascii?Q?4GzynQNvPvNnY97KDqiYlLW926P75yo4Ap3bqqhl?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d8807c09-9827-4289-c568-08dc127f8c3e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 08:30:20.3955 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: etPSU4p4T01iRzOWIXQGLkFukI5x0Qsw43us1C8ouzdCnrWciD8i5zI7XeJlcQHqmX7h4XHiezxLJ5RvYrGRMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7203
X-OriginatorOrg: intel.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
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

On 2024-01-11 at 09:25:49 +0100, Petr Vorel wrote:
> > Hi Petr,
> 
> > On 2024-01-10 at 18:59:31 +0100, Petr Vorel wrote:
> > > Hi Xu,
> 
> > > Good catch, merged.
> 
> > > BTW any change how to trigger autoload of dns_resolver ?
> 
> > > # ./keyctl05
> > > ...
> > > keyctl05.c:99: TCONF: kernel doesn't support key type 'dns_resolver'
> > > ...
> 
> > > # modprobe dns_resolver
> > > # ./keyctl05
> > > ...
> > > keyctl05.c:143: TPASS: updating 'dns_resolver' key expectedly failed with EOPNOTSUPP
> > > ...
> 
> > > We consider modprobe as the last result.
> 
> > Yes, it needs to load dns_resolver module to test it.
> > Or set kconfig CONFIG_DNS_RESOLVER=y.
> 
> Well, that would not work for kernels in linux distros.
> Therefore I'll send a patch to add modprobe functionality.

  Ah, ok, yes, it's better to check the module before the test.

> 
> > Due to the bundary issue fixed patch as follows, I will send another patch to
> > set to 6 bytes coming data for add_key syscall for passed boundary checking:
> > https://lore.kernel.org/all/1784441.1704907412@warthog.procyon.org.uk/
> 
> Thank you!
> 
> FYI we're planning LTP release in the end of month, it'd be great if you send
> patch soon so that fix is included.

Thanks for your info, and here is the link for new patch:
https://lore.kernel.org/ltp/48efcb1293a682182fc5db23f01be7af2889e26c.1704949719.git.pengfei.xu@intel.com/T/#u

Thanks!

> 
> Kind regards,
> Petr
> 
> > BR,
> > Thanks!
> 
> 
> > > Kind regards,
> > > Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
