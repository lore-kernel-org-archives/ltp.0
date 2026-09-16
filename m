Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2FB8C982CC
	for <ltp@archiver.kernel.org>; Wed, 16 Sep 2026 15:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1789574353; h=to : date :
 message-id : references : in-reply-to : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=7SRE3a8m3RlqGMgas2VrnwgoXliLCWiqTE06rzlPeeI=;
 b=IiDIXz0NJcsZSbz/r+ES00pllEPKqWIsrkW+lnR9APSbo2oYmkio/drDC2JC7gfRXDrDY
 vw+WQ1eT1CVA6YpyQADvbui2SiYdFAJD/B3YjddSgN9OlvIB9nrvL1DIuJO82RCGkIyX2Sr
 je0U8rKBEB8VypPS03LqzxLqSYjVNVo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C47023E8C4C
	for <ltp@archiver.kernel.org>; Wed, 16 Sep 2026 17:59:13 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C57A33E69D6
 for <ltp@lists.linux.it>; Wed, 16 Sep 2026 17:58:52 +0200 (CEST)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazlp170120007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c101::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits)
 server-digest SHA256) (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C5E452009FB
 for <ltp@lists.linux.it>; Wed, 16 Sep 2026 17:58:51 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rqztn4K916Y8d0Ig82oLrAE2aNOgFt+o0X2wzFUcnGrJqvmFaPH5+Szq+wJXggk6Qt/Fus8wy56oqyb51L2gg2Ihp1eb3zuOhl6kUtV5E47rvLZQVUyO1JveZThTV4+5ajivdIlTZ0f02dRJo4LRd17KCrpTXxdh/mkABs5nQFewYMtifvsZNj8Y3yFiVm3JzbJb5hacjKbvwWSxFxuLD7H2iIeTBdGby1nOY6WgDDWuamDiEpkp/44Kdy7oIKWC7rxc2RQh8TgJE7nLMgFeY7ri3E1A/3VmPHpuVVadflYOiWJqVYgfRr4BnISuX8FN6BFPcUd4Ma86ZOCYCzQsCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1fJaiVcygIq8dRbMadTtkkxlZVu+8qF+95/nsXoWLQM=;
 b=w7LkLwjgNaDnxJs46qdspU6bILz+Lb/sWntKnQusNwZWbc5AN1GXSHGyCLVDjJShedN3NNxAEFpLGqfNFjLgwIX7uQGJNJn1rLfOL19noRrFz7TVmtr5UEsYETcz2vepzsRjFqx2uKmnoBWJszcrcP+Cx0p/OxC9oHZidGoJ+lV5fzELApP7p2ME3UxnrcEYizYtRdCQruEaq6tED5jPALf4PC9x4Ft4+D5PCWRH/6uJCx5fz1f/Ni4P05GtlyqT8wmRFv09kh54CVoWX3o9kX/M2FFazNV6NbNvNfc1pHJx12zYf9nEidr4oKbrpUrETNdp5uz119R7nG5Z3WpA7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1fJaiVcygIq8dRbMadTtkkxlZVu+8qF+95/nsXoWLQM=;
 b=dlyt6n2Z9KdKVEVZQzA4+mIyGW6Afjhhm4XuJmzIjFTr9/FXFTPfgYxaVbTlhxW8Q/d2P8s7t/zedY5iWACUJZvaxWcbKlXnVimElQfbgY3puNneKfN+Vn70vBIEvYz7A+I8OWH8OLNvlWJT7BHzkJ9J6LCEgtFEzyhqo2IYGVZ7T8tQUuidyv8MtfetRpPCi93Rq+2KPqNYQK05s/hgGt+3Gg0YoKxNZ/SrluhibjizM4+7u1/EIGI/xLWNBaYxZGhKOlte49X9RHppivAkzLdXIz4tqj2KWAzCtcoFLKVMDNFX+aChD3002EN5mQAgjJwosW1+TU7IM4/psMeJRg==
Received: from DM6PR12MB4028.namprd12.prod.outlook.com (2603:10b6:5:1ce::29)
 by DM6PR12MB4170.namprd12.prod.outlook.com (2603:10b6:5:219::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 15:58:42 +0000
Received: from DM6PR12MB4028.namprd12.prod.outlook.com
 ([fe80::90c9:9291:d4fa:8e8e]) by DM6PR12MB4028.namprd12.prod.outlook.com
 ([fe80::90c9:9291:d4fa:8e8e%3]) with mapi id 15.21.0406.007; Wed, 16 Sep 2026
 15:58:42 +0000
To: Cyril Hrubis <chrubis@suse.cz>
Thread-Topic: [PATCH v2] getrusage03: account for percpu RSS counter batching
Thread-Index: AQHdRSb29hOWxjZSj0WzKMsMoSO+KrbRWtt2
Date: Wed, 16 Sep 2026 15:58:41 +0000
Message-ID: <DM6PR12MB40280BDE504322942351D8F5C2B92@DM6PR12MB4028.namprd12.prod.outlook.com>
References: <apgVur5s_potD6ND@yuki.lan>
 <20260902160113.1207205-1-nirmoyd@nvidia.com> <aqlkQAUnD06oQ5KR@yuki.lan>
In-Reply-To: <aqlkQAUnD06oQ5KR@yuki.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-reactions: allow
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4028:EE_|DM6PR12MB4170:EE_
x-ms-office365-filtering-correlation-id: 909aa217-b005-4071-548c-08df140b6156
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|56012099006|22082099003|18002099003|4133799003|13003099007|8096899003|38070700021|10067099003|4143699003|11063799006;
x-microsoft-antispam-message-info: h9nEPcRtdNEDTmhnGaW3gp4iTQXo2iHw2ZHr/ko25LksfonJ69cMKMBruX4STMehAB9jD9Jg1BOakhdBgCNSseh/0SOVraClK/2MstIHu4x/6pXKVXVvCKD0rfA/cUIZ7UWY7R2N/88MMTSnKzp1OUaQ+rY2vjaAw5lctLfFdzhlNwJz896MMG2GEc5QbLBbCalIZ8iyUs7qvdAviMVdS+bCLvNyWb4y9M+FmShRpuHjiLz0EWe4Q7qtf8RW4k7GtTZjjpLZnrY2QHOpnKE37PpBtJfFpdBYn1Z6vGL3FzDByH+RxRUyQlTUjuIaEqjdMNg9DwleSX3Jq7yIN1+z/+uUN6GsN4yK2ymI5IHq2X21+kIXcgFtRFcHpw2dWpKMkaxM1o76suRha6Vewi3J8JdoxXtTFcLRzYWIMEBGmeHYvvLN9XJAkgftD08Q8xK9D9BynOyKsJvK4BzEwkOPXtVZJSMagtanNrxlD0+qi4fUYUxXAmODqYJwwn9onHMR16GOI0gqNWiBuFgHQSL4KoaOe1m4juRQsYB9KeQ+JEINSY9Jsy1tEMWyygp/AwFuVpuCDE6qjwtcaXemaJEhuli+ctDwJcBXXaNPSVmvZ+w62NMymQiE2Ecl24rhTQNiV/1oZO2u3Y/629E3d99ZU9oSTuFTNoFMCMez11jALlThCf2YWaMCWpJ17H7BlNAQsqCFu6ha6ShG6KmFd9P6C8/BkEkiXSPRRArHM/60dTc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4028.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(56012099006)(22082099003)(18002099003)(4133799003)(13003099007)(8096899003)(38070700021)(10067099003)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?JfneOFN/OEHc3t15BoWbOs5VVJg8Pk56eLqdnb9juwkVl5ZPkiT/8GFl?=
 =?Windows-1252?Q?h8V1Y1+WF3NdUTecbBKYyfnq5J6xCuNUa3eX1tGNk7EH7d1FZOcM2Sva?=
 =?Windows-1252?Q?8dHOCvGD2Cnf5CsIWMsusM+1/JkjJ0/2TwvAdbI5y4CEiiu9jg9tTW77?=
 =?Windows-1252?Q?ibFebAAvA9P2bMmDdPZArlwM9tRofE8rgF8uw2hMJC4T78cho5hk5xZD?=
 =?Windows-1252?Q?02CShSCrohMK6kBMuFJCgA+Q0JurmRE0cUYvV0T8x4s5WnNGtZAAgBgZ?=
 =?Windows-1252?Q?mR7lxf6XKpdjacTaV37ScHMH+Q6qva732opT65pEUEebiYsxLGMHM/IN?=
 =?Windows-1252?Q?8NyYrESmONBFo23RvpLR1YeG1DCwqq3RBFu2wJoRQGwd4kFEZOGgKX8+?=
 =?Windows-1252?Q?8XwtWTTUoh3jCgJTo2hJlcTxkDqdxlJNDT56+Grr07MbOCmRPc1OBcV7?=
 =?Windows-1252?Q?cqmMeHxTLBosis3q/HQ/JQTjWDrmAY9neM1SpM4YTTrspUm8oG0VuBVi?=
 =?Windows-1252?Q?da7FP4esf6931X2hk0X8yPvnRxbQoPJtmS1YVBgNtV2NpcEs4eLaZFB0?=
 =?Windows-1252?Q?FkD41sbagI68P+awPnKATriFQP/0OMgqRNy4NdZA1ZsoFA6NWbg5CdDe?=
 =?Windows-1252?Q?bPjEYseskcXwApOtI/VxihApXklknsFxexj0zzds3d1Cqx0qMmbM56Q1?=
 =?Windows-1252?Q?VmkWAgW1/q54I8z/MxUJ8feNOtD7mjqFgwtXCSSbP6SlA5ryRH91dsRX?=
 =?Windows-1252?Q?8DG06T79rcoKo5yCRf4eXb14eiqut+ckpvKD2fTq8RrYcDfglZgsroe6?=
 =?Windows-1252?Q?/SdlPBylLUgZyszmt9YU0MUo3UculWccxfQiHSLzyGln+Y7VAVlBsshR?=
 =?Windows-1252?Q?brPoQXHXtOL4/JHXNTtkLkMF2bRv/yMT+qxDmlyT5BIxxFaJgAqt9Mmc?=
 =?Windows-1252?Q?3qzeVUlCocCr98j9334jM+SafJLN9lk8YryPvIz9rShMLg39M/9Hjp9B?=
 =?Windows-1252?Q?6vQryGY5zgiV9SFn8YBFjq1PeTNFoNzhuDsPn6TdxS4tcF48jkZL0VuS?=
 =?Windows-1252?Q?387fs1LuPvq4smNwGPozyRZkXsPzHNvDJcvHjqjaCxvYr+HaJCehWGd2?=
 =?Windows-1252?Q?7avoeoaJ7UPEZNCwViLOeIzmg4FHI0A7ytz8VWJz65Lfqi3G416Excbb?=
 =?Windows-1252?Q?2Uj/Yjsemn/8AaceuH4BvWQFsOlKcjxEjtGFK48bmy0Jz+v7qV3JpbZ2?=
 =?Windows-1252?Q?pqz0mT7k+U9cCJlUQRZEca4Z2XoF2lHTbNU+zYklgKftlXuUCOsg6rfK?=
 =?Windows-1252?Q?u63Cu9V2WYjCVCtzgFacjMXXN7eoFscm5FCdhZTul37/vmltNqHzZpoU?=
 =?Windows-1252?Q?lLsf92hzySoUTCc8MoTy5nfMX/OK3aqZRZb04k+tgb8CFUlZ+hfRMnx5?=
 =?Windows-1252?Q?Bm5sT7yQB6dD8Ur9cTX4zz98dI07HTxGpLtIex6mkh016DgngzBYoEk3?=
 =?Windows-1252?Q?Z4ljrpP2FICrvKkWBftnP5pgLkcoXZwA6lObOnI52Eg/14vxeE5GQJpi?=
 =?Windows-1252?Q?+X8lM0fykZnsVt7pfJL1h2518ej4UeLBIzye83jQ6si2dYMPUlkDK9hI?=
 =?Windows-1252?Q?6NTjJpa6KH6AAfQ5wxUW5Jm+IYOY2UM31oE2DTYPSCm8i+eDlZjvJDQM?=
 =?Windows-1252?Q?egmUjiQGDjMARDY74k7NpcjZabzG2ih9laIjg1lTFkZ7FX9fORZ1oWXl?=
 =?Windows-1252?Q?WvhNNAF/aNTVqnu6uVNwwrWOiG8tlD8T9XiokzglBVrsOmOj0OLyYDgr?=
 =?Windows-1252?Q?SR+ApUSXqSLBMM63PY6o7o5WVGhU5/+CCeFIajNT2zjZv1WV/NM1ejQO?=
 =?Windows-1252?Q?SQYkxkrhgr72MQ=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4028.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 909aa217-b005-4071-548c-08df140b6156
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2026 15:58:41.9794 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3QwUj/lmpeyrVaG8UD8hdoKFRbFBN2jEFR+HaGlY32x53bf1n2gFDNb0XLyDjY1dsUJPLEazujnfi0M7iKnQGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4170
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2] getrusage03: account for percpu RSS counter
 batching
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
From: Nirmoy Das via ltp <ltp@lists.linux.it>
Reply-To: Nirmoy Das <nirmoyd@nvidia.com>
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

I tested Jan=92s patch on a machine  with 352 online CPUs and 64 KiB pages.=
 Pinning was confirmed, but both the
baseline and Jan=92s patch failed 10/10 runs:

child.children =3D 270336, expected 307200

Pinning keeps the allocation updates on one CPU, but get_mm_counter()
still reads only the global count. One batch here is
max(32, 352 * 2) =3D 704 pages, or 45056 KiB. The 36864 KiB shortfall
fits within that batch but exceeds the existing 20480 KiB DELTA_MAX.

I also tested a small follow-up that increases only the lower allowance
for the 100, 300 and 400 MiB checks. It passed 10/10 runs, with all nine
subtests passing each time.

I will send this follow-up once Jan=92s patch is merged.

Regards,
Nirmoy

From: Cyril Hrubis <chrubis@suse.cz>
Date: Tuesday, 15. September 2026 at 17:29
To: Nirmoy Das <nirmoyd@nvidia.com>
Cc: ltp@lists.linux.it <ltp@lists.linux.it>; Jan Stancek <jstancek@redhat.c=
om>
Subject: Re: [PATCH v2] getrusage03: account for percpu RSS counter batching

[You don't often get email from chrubis@suse.cz. Learn why this is importan=
t at https://aka.ms/LearnAboutSenderIdentification ]

Hi!
> diff --git a/testcases/kernel/syscalls/getrusage/getrusage03.c b/testcase=
s/kernel/syscalls/getrusage/getrusage03.c
> index a2cdd6158..38a100576 100644
> --- a/testcases/kernel/syscalls/getrusage/getrusage03.c
> +++ b/testcases/kernel/syscalls/getrusage/getrusage03.c
> @@ -13,9 +13,13 @@
>   * this program.
>   */
>
> +#define _GNU_SOURCE
>  #include <stdlib.h>
>  #include <stdio.h>
>
> +#include "lapi/cpuset.h"
> +#include "tst_safe_stdio.h"
> +#include "tst_cpu.h"
>  #include "tst_test.h"
>  #include "getrusage03.h"
>
> @@ -23,12 +27,99 @@
>
>  static struct rusage ru;
>  static long maxrss_init;
> +static long lower_allowance;
>
>  static const char *const resource[] =3D {
>       TESTBIN,
>       NULL,
>  };
>
> +static long count_online_cpus(void)
> +{
> +     FILE *fp =3D SAFE_FOPEN("/proc/stat", "r");
> +     char line[BUFSIZ];
> +     long count =3D 0;
> +
> +     while (fgets(line, sizeof(line), fp)) {
> +             if (line[0] =3D=3D 'c' && line[1] =3D=3D 'p' && line[2] =3D=
=3D 'u' &&
> +                 line[3] >=3D '0' && line[3] <=3D '9')
> +                     count++;
> +     }
> +
> +     if (ferror(fp))
> +             tst_brk(TBROK | TERRNO, "fgets(/proc/stat)");
> +
> +     SAFE_FCLOSE(fp);
> +
> +     if (!count)
> +             tst_brk(TBROK, "No online CPUs found in /proc/stat");
> +
> +     return count;
> +}
> +
> +static void pin_to_cpu(void)
> +{
> +     long ncpus =3D tst_ncpus_max();
> +     size_t size =3D CPU_ALLOC_SIZE(ncpus);
> +     cpu_set_t *mask =3D CPU_ALLOC(ncpus);
> +     int cpu =3D -1;
> +
> +     if (!mask)
> +             tst_brk(TBROK | TERRNO, "CPU_ALLOC()");
> +
> +     CPU_ZERO_S(size, mask);
> +     if (sched_getaffinity(0, size, mask) < 0) {
> +             CPU_FREE(mask);
> +             tst_brk(TBROK | TERRNO, "sched_getaffinity()");
> +     }
> +
> +     for (long i =3D 0; i < ncpus; i++) {
> +             if (CPU_ISSET_S((int)i, size, mask)) {
> +                     cpu =3D (int)i;
> +                     break;
> +             }
> +     }
> +
> +     if (cpu < 0) {
> +             CPU_FREE(mask);
> +             tst_brk(TBROK, "sched_getaffinity() returned an empty CPU m=
ask");
> +     }
> +
> +     CPU_ZERO_S(size, mask);
> +     CPU_SET_S(cpu, size, mask);
> +     if (sched_setaffinity(0, size, mask) < 0) {
> +             CPU_FREE(mask);
> +             tst_brk(TBROK | TERRNO, "sched_setaffinity()");
> +     }
> +
> +     CPU_FREE(mask);
> +}
> +
> +static void setup(void)
> +{
> +     long online_cpus =3D count_online_cpus();
> +     long batch =3D MAX(32L, online_cpus * 2);
> +     long page_size =3D SAFE_SYSCONF(_SC_PAGESIZE);
> +     long batch_kib =3D batch * page_size / 1024;
> +
> +     lower_allowance =3D MAX(20 * 1024L, batch_kib);
> +     if (lower_allowance >=3D 102400L)
> +             tst_brk(TCONF, "Per-CPU RSS allowance is too large: %li KiB=
",
> +                     lower_allowance);

As long as we pin to a single CPU the whole batch accounting shouldn't
be needed.

FYI Jan send a similar patch that just pins the process to a single CPU:

https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpatchwo=
rk.kernel.org%2Fproject%2Fltp%2Fpatch%2Fa308e12198ce96305761a009858fa4a80c9=
1f932.1788518850.git.jstancek%40redhat.com%2F&data=3D05%7C02%7Cnirmoyd%40nv=
idia.com%7C5c88fc4e5490430569b008df133e14f3%7C43083d15727340c1b7db39efd9ccc=
17a%7C0%7C0%7C639250829531773556%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOn=
RydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%=
7C0%7C%7C%7C&sdata=3DqOkWQ7VsVwFS38S1zQgxue5eo8kNqUJ%2BEHl4rN80qIQ%3D&reser=
ved=3D0<https://patchwork.kernel.org/project/ltp/patch/a308e12198ce96305761=
a009858fa4a80c91f932.1788518850.git.jstancek@redhat.com/>

As far as I can tell that should be enough to fix the test.

--
Cyril Hrubis
chrubis@suse.cz

-- =

Mailing list info: https://lists.linux.it/listinfo/ltp
