Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B57AC6FA8F
	for <ltp@archiver.kernel.org>; Tue, 29 Aug 2023 23:26:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 324EA3CC621
	for <ltp@archiver.kernel.org>; Wed, 30 Aug 2023 01:26:52 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4B78F3C88DB
 for <ltp@lists.linux.it>; Wed, 30 Aug 2023 01:26:41 +0200 (CEST)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on2061a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaf::61a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 41B991A00FBC
 for <ltp@lists.linux.it>; Wed, 30 Aug 2023 01:26:40 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kpJ0YpClF+T+fKN4M5vSbWILxRkWW4b96+PIKO6nlt45/xcjhB+ous+n+CPj+ZIixSBpFFr1FEzmYbgqsgWcH4EwIZAoVmG2t1L4kCtumkVdGlxqLzTBfjc/lM/7XRNQydX/yqYgmL6C/Ob5epmvwpeXYikJWrtiUcWYF58iUeMSouZr679YDoM44CTloyc3tXVBIpGvkXceu0H7D6Vu+zZEuSsz9Z+oey9CukS3t/4j34QkUW5hH1+3lPWfmrWDhmypnZYG3tprqHnqRQYR18Cx2F37tQ9XT2HmBDuftD5Npyx8r8QWyXcWHlGZK0vTHt0KGctYJ8CWoEgWpSv52g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IPIbvOFUm6llW0LgAI8xBTI2W8QyFcVYr+QjUb3x7ys=;
 b=IP37XbpTPWqGBWKzZNal0XCbNK1kI9PokKJUwMZH/UkdX7O5G/A9Og2QC4ae5ohXHWzvPO3f3+DY5SXcms6d3+Yu8kAxzPAzxtUC4PJpa0uB+2V+fiZKyAVX2LAQREC7i2f3Lpvt2POLw8LfU0YA/C350IQVPBK70o4YRmTEMN4tFXZZZz6B9QEUBXSzUBdlaowQUXlCTAvjA7ISYu6s7AqggHZxxNyorwdp3GzySABxD2oLW08duKanKOq46gSvF4Zd9kbVCosQPErI3E57ZWOOirDe4oD7uBIYUYSmu+8KMe4xAZJTcHsJJPXoqpVn8qnPfSRkkYOPRj4OhDA1vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IPIbvOFUm6llW0LgAI8xBTI2W8QyFcVYr+QjUb3x7ys=;
 b=MUZNm/RSRRjEDqejdNznNmbMNnfmk0yp/zrABXha2GLcQpYZeBXQAF60839ZlSSYbZdBaNJAfHLuphbwh4wfBj1DBQyoCB7vnpFaffcacN6bJ2N2lchZZgHwh3xDPq6YVHQeI9n6vcGpxIi/B4ZAMiLjmJI6IGDPHNKzTyNZWcIeysRosm4JhwQZLaMDHaGGPH6h9aZmTXN7oN4TKbFNlolShYeNkh9/uD5fpSyn9pFSsR25D+JWcJHToVxPzucBJClLExbjwpQJQE5gxHSMrqSQ6mOwiFNyswPxzXcvYidSxiRbpdeBhFFmvhlB4ttnZtfiUbe/01LZKXEJLti7Iw==
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com (2603:10a6:20b:3f6::21)
 by PR3PR04MB7289.eurprd04.prod.outlook.com (2603:10a6:102:8a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Tue, 29 Aug
 2023 23:26:38 +0000
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::41dd:e42:e86b:c92f]) by AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::41dd:e42:e86b:c92f%4]) with mapi id 15.20.6699.035; Tue, 29 Aug 2023
 23:26:38 +0000
To: "rpalethorpe@suse.de" <rpalethorpe@suse.de>
Thread-Topic: [LTP] [PATCH v5] clone3: Add clone3's clone_args cgroup
Thread-Index: AQHZiLhRUoiM2ie1S0WIs9zT7ZQsk6/7boAAgAcfiBA=
Date: Tue, 29 Aug 2023 23:26:38 +0000
Message-ID: <AS8PR04MB81996C1CBF8578041D265E9FDEE7A@AS8PR04MB8199.eurprd04.prod.outlook.com>
References: <20230509003148.16094-1-wegao@suse.com>
 <20230517120827.9350-1-wegao@suse.com> <875y53bcs8.fsf@suse.de>
In-Reply-To: <875y53bcs8.fsf@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8199:EE_|PR3PR04MB7289:EE_
x-ms-office365-filtering-correlation-id: 648491c6-4e81-4c5a-44b4-08dba8e76490
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cXU4zvOnIm3wrhApOoDFkZFxKMJ/YbfHxZV+2APCoLptvGlDHO63ScjfGfn3vGeETA0VplWJe0q3GdPKIhVnMX77e0qtrVVTAUkwt6BwnVwSavogO1Wk33ORjSDwf2qOENBsrCsrGxedCVKuxfjRMofDu/J+AQsVxbOwnZ6UJ+w5gpWd0IQOP8/NANkMCnvUVPVFDRFdtvjBjl12MLmVDYBVSFt0fosH74JrE/qp7LVWkMbXVT7BZ5N7xm0KAwveht7xM62AOd11YXV4O++MZA8ILhMJvUMqFCQgFOcOrCC1V6X99PEYne7M69NFBRvJDKEj62JC9KTKce1NrTqYQ/dX30H4asiST9zrpuGhgSIVU/rjY8gVcTzMIkeZ6gxKdKs+J1shGcd+VyQOJREXeJtq4wu9ARlf5OZyKzajL/95qlJbU7NKFhF47/pzNTefiOT+jhOS7M7+5dKbwLdTyI/fbP5WUXVSswiUP8yMXZvcTxa8cZxaOcn5hZAfInCFiK7afeciHSgX8fbbkp5/yzblSINYQziYhNpKnJf4Eb0S9/zRKKIPCHPi7FAyGe3nzemmUsYQ1drd/ObvlmjN6sAkWP3uRkkVgnYn+iDNcAyeZHEPk/EGIsNiU1bpmQ6H
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8199.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(39860400002)(366004)(136003)(396003)(346002)(1800799009)(451199024)(186009)(71200400001)(7696005)(9686003)(6506007)(8936002)(33656002)(86362001)(38070700005)(38100700002)(122000001)(55016003)(2906002)(26005)(53546011)(478600001)(83380400001)(6916009)(4326008)(52536014)(8676002)(66556008)(66946007)(76116006)(5660300002)(66476007)(41300700001)(66446008)(64756008)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VuNsZcRvErEY/b1bVyUdcWNS1Wmmy8IasM+YHwVnrZQZs7nQUh+GIplpunD9?=
 =?us-ascii?Q?tU02K+uMVtu7vQHTl+YD3uH4ku+5+E3fpO44MLoEgnLuu8oGn+Sq6bFtENq5?=
 =?us-ascii?Q?jJ27gNECdXEagFIg9gTvf/qFEGCr9ALqfvETrDZrPvt6mozFr+iiKdEAyIQ7?=
 =?us-ascii?Q?e04AX2uy64NtspwbefOr/GJ92ibuTaTsOpxCOl9mOw4R+mjM57Uq9YqzYEwO?=
 =?us-ascii?Q?ysjGdtg3BV6LE7UtbysZUPfLaHR7/BoqWAkVDDYqP2i+yS7b4hVLM8F8V1JZ?=
 =?us-ascii?Q?ZUvGQP5ta9m1E9nyWfLnAe8tm+4L84G3vobz78RhJX2gaPAfPO6bMZNZaFT+?=
 =?us-ascii?Q?4YtGfTheJiSkNLOlqf1TazpeuFK+iKpAQPcTE3rmxO3dPhdfsbZ6VuhcYOiB?=
 =?us-ascii?Q?gM8pdUui+/d9jPqmVA/AAGiZtWEZ8KNkR0dEz6JubKNSKzXg48mFOZ2jH1Hj?=
 =?us-ascii?Q?CXYZP95BItVa3ghnXFAbHoLnW/RLVKDmBNTtuOR9ybGe5m1T0Nl7NJgWUjjD?=
 =?us-ascii?Q?pk++TK9XDZvyJNF+hLeMzNBYt3Fd0TOA/AFuh+81yUMVBOWsTNbMUIcz4b0T?=
 =?us-ascii?Q?p+0JZmEDjN7PdDro6g2fxXtQYZmTU6UAmAopYy9x7n2T7JYM1xy/9DvPwiRH?=
 =?us-ascii?Q?uJiROwkJ21NuxgaqQZtySgAfQRRksH8OS0iGIZWQmvDcJVBR5B6r2bc9QfPo?=
 =?us-ascii?Q?h7h+xYxkXU+zfpV9oo1im8+axkePe//OUSg5rpiq0mPPwuBbpkFjzb9zulF3?=
 =?us-ascii?Q?pa0dcAnb0NC24/gg7z1iA8vFpPPn6MFhUBvzvGKZx/nNoiu8krpEMtGB56Gb?=
 =?us-ascii?Q?arqprLSGadh6JRTs6Ydhl/voHWRGr//hHiQB4U0i8s/+8irvt2OvC9ri8REK?=
 =?us-ascii?Q?MbLW7he0DpTErzFmYZofs7VgmmST0zFsA1ZtBIGo50edo21lsiPiECZAcdWk?=
 =?us-ascii?Q?V0aPF8erSPVDtSIuZG7ItlVbm0em91J1OnBDcRpDohi1+a7Hqu5/v8+1Th4z?=
 =?us-ascii?Q?FBkrpYuLOSXItiTRvctRhYMRdyuoqSiYTd17DytV8Gi0vy6ZcAOcLuzkjq8t?=
 =?us-ascii?Q?qip5X07L+uIuN5HIlzy4/GDqqxxBrXC2UcZu57vSAyoeR8CPaKlI9xm0naqR?=
 =?us-ascii?Q?DB1itl7cZYjPYXxbhBSyGcZ7ZpdWtTfYGTH4LJ7pvGBmJrFIMU1Vo4GORl3q?=
 =?us-ascii?Q?BBQdUK6spcVG041tsvoJkIqQlPH5OdQesyNsiNbKsKGNgnmsB/q6Uy8XeOHe?=
 =?us-ascii?Q?PSUbrGKt/c+uEuyLEX+rBRwD0Cxe60GNXE6eXHQHr15ZK+Zqr0FwUirO5qt1?=
 =?us-ascii?Q?uFRcVNzOQXKbZEYiCSliY2cIa2jtJRghWxb6eNp9/V/aMZc3yejmnnB+aePM?=
 =?us-ascii?Q?uE6EJ7Sf/Mh/2rzMB5uYl+bYCf2UrMzg2BH7xDd6lRe/wWeCKVy36aiXpzMW?=
 =?us-ascii?Q?WJIiRvVAEITh2MtTzc9rDtIWAiKBMviSowFOaW3aJqSChTMYcLZn2CxS/tRW?=
 =?us-ascii?Q?rDTWEW7+NeCCO43oT3v35wns3l6rOSCGE3Jk4UHqpibuJZEa3FKSlABVAdgC?=
 =?us-ascii?Q?LuY0L7IQOCU7iOhhkfo=3D?=
MIME-Version: 1.0
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8199.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 648491c6-4e81-4c5a-44b4-08dba8e76490
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2023 23:26:38.0957 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y2fO+POnlvP/Tu5agVzfowLm4YH6mw+F+AVJTB6lWKCtHECQ6wv19Oi5A/9lDKqq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7289
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5] clone3: Add clone3's clone_args cgroup
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Richard

Thanks for your review. I flag my comments in former email start with [GW].

Thanks.
Regards
Gao Wei


-----Original Message-----
From: Richard Palethorpe <rpalethorpe@suse.de> 
Sent: Friday, August 25, 2023 6:36 PM
To: Wei Gao <wegao@suse.com>
Cc: ltp@lists.linux.it
Subject: Re: [LTP] [PATCH v5] clone3: Add clone3's clone_args cgroup

Hello,

Wei Gao via ltp <ltp@lists.linux.it> writes:

> Signed-off-by: Wei Gao <wegao@suse.com>
> ---
>  include/lapi/sched.h                        |   8 ++
>  include/tst_cgroup.h                        |   4 +
>  include/tst_clone.h                         |   1 +
>  lib/tst_cgroup.c                            |   9 ++
>  lib/tst_clone.c                             |   1 +
>  runtest/syscalls                            |   1 +
>  testcases/kernel/syscalls/clone3/.gitignore |   1 +
>  testcases/kernel/syscalls/clone3/clone303.c | 101 
> ++++++++++++++++++++
>  8 files changed, 126 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/clone3/clone303.c
>
> diff --git a/include/lapi/sched.h b/include/lapi/sched.h index 
> 1065665d1..ac766efc5 100644
> --- a/include/lapi/sched.h
> +++ b/include/lapi/sched.h
> @@ -13,6 +13,7 @@
>  #include <inttypes.h>
>  #include "config.h"
>  #include "lapi/syscalls.h"
> +#include "lapi/sched.h"
>  
>  struct sched_attr {
>  	uint32_t size;
> @@ -54,6 +55,9 @@ struct clone_args {
>  	uint64_t __attribute__((aligned(8))) stack;
>  	uint64_t __attribute__((aligned(8))) stack_size;
>  	uint64_t __attribute__((aligned(8))) tls;
> +	uint64_t __attribute__((aligned(8))) set_tid;
> +	uint64_t __attribute__((aligned(8))) set_tid_size;
> +	uint64_t __attribute__((aligned(8))) cgroup;
>  };
>  
>  static inline int clone3(struct clone_args *args, size_t size) @@ 
> -133,4 +137,8 @@ static inline int getcpu(unsigned *cpu, unsigned *node)
>  # define CLONE_NEWTIME		0x00000080
>  #endif
>  
> +#ifndef CLONE_INTO_CGROUP
> +# define CLONE_INTO_CGROUP 0x200000000ULL #endif
> +
>  #endif /* LAPI_SCHED_H__ */
> diff --git a/include/tst_cgroup.h b/include/tst_cgroup.h index 
> 2826ddad1..be14d07c6 100644
> --- a/include/tst_cgroup.h
> +++ b/include/tst_cgroup.h
> @@ -157,6 +157,10 @@ const char *
>  tst_cg_group_name(const struct tst_cg_group *const cg)
>  		      __attribute__ ((nonnull, warn_unused_result));
>  
> +/* This call returns a fd pointing to a v2 directory */ int 
> +tst_cg_group_unified_dir_fd(const struct tst_cg_group *const cg)
> +		      __attribute__ ((nonnull, warn_unused_result));
> +
>  /* Remove a descendant CGroup */
>  struct tst_cg_group *
>  tst_cg_group_rm(struct tst_cg_group *const cg) diff --git 
> a/include/tst_clone.h b/include/tst_clone.h index 9ffdc68d1..7b278dfa7 
> 100644
> --- a/include/tst_clone.h
> +++ b/include/tst_clone.h
> @@ -11,6 +11,7 @@
>  struct tst_clone_args {
>  	uint64_t flags;
>  	uint64_t exit_signal;
> +	uint64_t cgroup;

This is not used in the test being added so I will not merge it because I don't want to do any more work than necessary (I would still merge the rest of the test, but there is another issue below). The reason is because it may cause some test which does use tst_clone_args to fail because it increases the struct size. If some other test does not initialise the members correctly we may start sending uninitialised data to the kernel.

In general I don't want to add anything which isn't immediately necessary without having to think about any potential problems it could cause.

[GW]:  The point of this case is test cgroup parameter, if you remove this then following error will happen:
tst_clone.c:18:21: error: 'const struct tst_clone_args' has no member named 'cgroup'
   .cgroup = tst_args->cgroup,


>  };
>  
>  /* clone3 with fallbacks to clone when possible. Be aware that it 
> diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c index 
> 274c73fea..43055e8cf 100644
> --- a/lib/tst_cgroup.c
> +++ b/lib/tst_cgroup.c
> @@ -1112,6 +1112,15 @@ const char *tst_cg_group_name(const struct tst_cg_group *const cg)
>  	return cg->group_name;
>  }
>  
> +int tst_cg_group_unified_dir_fd(const struct tst_cg_group *const cg) 
> +{
> +	for (int i = 0; cg->dirs[i]; i++) {
> +		if (cg->dirs[i]->dir_root->ver == TST_CG_V2)
> +			return cg->dirs[i]->dir_fd;

The loop is unecessary; cg->dirs_by_ctrl[0] is always the V2 directory if it exists.

[GW]: I have updated and sent new Patch

Otherwise the test LGTM. I'll set to changes requested in patchwork.

--
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
