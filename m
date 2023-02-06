Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99E77C05027
	for <ltp@archiver.kernel.org>; Mon,  6 Feb 2023 10:38:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9317D3CC24C
	for <ltp@archiver.kernel.org>; Mon,  6 Feb 2023 11:38:48 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 941913C2730
 for <ltp@lists.linux.it>; Mon,  6 Feb 2023 11:38:38 +0100 (CET)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on2060a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe16::60a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A16B6100094B
 for <ltp@lists.linux.it>; Mon,  6 Feb 2023 11:38:37 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NWLmTuyg0/Zy78+cni+TBRHt4JxZiJjh/NFXf/bgbuyCi/luRsD43MpSJlgwElaJyJkdrRsb3aCes5pkEAawegSuErSq76IPg/iy1fuJdcFPkf/S31+FAqoBe7PSwJwEPeuHMXHB/jNepgK1ZNQPz/VPpaHmx44m646bchCiuXtVsbxfW3Fnk6054xQf43rw3wS8agSUTtfaAd51AEpwXAEgkHXD1jw1v6MElqbww49+2TtxDu2NCGqLlfVhyKXAQftyKaRoXM+FAWMhYOl4ecWRtsimr11Uxj5AK8G4bidH9KGU57mfpeyhy5GpgOiRVh4vEVMHRKXnl1onjuOtBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZjvZqjnpjstBMZRLeUAM0XLfd2LVOG4VkTurAAGIL8M=;
 b=LZiaLR/hir2IQMlsyYpGZD7DWQjlM+d8bZh6XzLzT8gId6i6lf96Kke1fpg1UB00JwZOLqvJrUv9/8ITNfGWx2zCkU4ehOELpIhKArmMzjRxmt4pN/zbRBZQEnApZQCC7+Mss/S17QT5YY0aAL6N4eXSxnxGFHL/mq6zajcT/0ZqWlZ/6FpYvwgP/BP5nRHEUnKhoZCm3NPttCgPtsJwvOxa7axyfe1sTejFpqodkPKMoV7CcZDsX/cRSaYKl9r4k+JYlL9lM/8p448WHGqR/rBCXzo2TAixbJTyrP1mX75v+wOEns90PXj8QENXJy/4Qe1JE+irz5+VgxMffHT5eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZjvZqjnpjstBMZRLeUAM0XLfd2LVOG4VkTurAAGIL8M=;
 b=IJ8zd8BVixUpFMqVw2D+YjMI9mx1ctfsZHwYGaPoRnXefTwkHJy8yFsCnZDCmG6dkPRsVyeEv1IuEh15erv9vvhwstHaxdStbtBLhCVFjxoQMtjmLKWEtkVzDXLeF57m2jJRaTN2wXIcjRhhVST9FhSWRJpSIUdh5y08LQ99Yf+LXUOPZMbOe65iA4p48vdob0epoqhaaNLDiWfu97fjpfns9FI+ftwjdewMdHh0jEY1XrIP1Q4BSn3jwkZfP4CJLgbNrmd8bjbC8F1s7NzfPNyBeod/ogqtTsIugI3T3B7ekKK+jFUZKdoiPgYc6j1apIUmPtpAyh/vwXOstdA6YA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS4PR04MB9433.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::14)
 by DBBPR04MB8025.eurprd04.prod.outlook.com (2603:10a6:10:1e4::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Mon, 6 Feb
 2023 10:38:35 +0000
Received: from AS4PR04MB9433.eurprd04.prod.outlook.com
 ([fe80::7f5d:f7d9:47b1:cc2e]) by AS4PR04MB9433.eurprd04.prod.outlook.com
 ([fe80::7f5d:f7d9:47b1:cc2e%3]) with mapi id 15.20.6064.022; Mon, 6 Feb 2023
 10:38:35 +0000
Date: Mon, 6 Feb 2023 05:38:18 -0500
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Y+DYmkBnv/NQK8gZ@aa>
References: <20230129115021.25778-1-wegao@suse.com>
 <Y9pf5075zsuAhznN@pevik>
Content-Disposition: inline
In-Reply-To: <Y9pf5075zsuAhznN@pevik>
X-ClientProxiedBy: TYCP286CA0211.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c5::14) To AS4PR04MB9433.eurprd04.prod.outlook.com
 (2603:10a6:20b:4e9::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9433:EE_|DBBPR04MB8025:EE_
X-MS-Office365-Filtering-Correlation-Id: 8eb9da6d-e846-4371-b813-08db082e4c71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZCsapAI6jUhNJajqJsIzlxvJRVCl/Jj8vIpSSeZUCmWBc/JtIFlEprCHes4cpOJBHgkAAUbACILhjh8PbHdryxW9o7oyG4hiXEu/QWIW56ij6sNRTHHieobKY+mD2uYLDonR6s8lgcgWE5gGN5IGo3lnpbji4yi1OmxZfKbgtqZIUFeCgPj0AIcWClwopJ/VgeHcM+/NiNiUq83f8eV5qhf9Awuds3sE9KRreCZXqZ/RJdw4rSJ23kc0187LoHYQAfEJ14jQ73K9S78sOhRUGDAp5RqTtrKvLGJXEsG3nMY6DMtleYDWUlnNEkZfEIcuWALEhnV3BqQBCv4KXR8swTL/wxr1JmiCNEGuabu2UU32CHvF57Hc/2ND63qDlE7rw3bP08w6YWfvpi4QFNfykEDUeLs4H44Tl5KFmCrcaF7VuL3xAGowsZaU6r24fEAw4mbI7nXHTsxdx7XLbGnY3EcFwviRp+U1gbndSHoM6IC2b6UF7AYJeyFkjCLdAkf+qJFRTv+9NVU3WqSy+sRCC7Q8mnmqoCdN8Ioa/9PoSaYqq2ulcMTzRHxntrHPfM3tA43VDLt5YtfuT3zqVU9PkCB8jA52zxcHVZ71oi7LHTboX5hFmSmfNGNgncnWEFN2/IHaH6f9xIqMtnaZ7ymjv40Dwx6aZ5aCxZJJY1yTWHETuo3YjPoJAqOOqBKVXodHrKwPRHVnJsEw9wZu5FvydQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR04MB9433.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(7916004)(376002)(346002)(136003)(366004)(396003)(39860400002)(451199018)(38100700002)(41300700001)(66556008)(66476007)(316002)(6916009)(8676002)(66946007)(8936002)(4326008)(86362001)(33716001)(6666004)(9686003)(6512007)(186003)(26005)(6506007)(966005)(5660300002)(6486002)(83380400001)(2906002)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?F7iJXsGKy5RwjaIpmxRWzdaI1BGPhQGd2krhkS4eCAmUsYt1YlU5SbY5L5MN?=
 =?us-ascii?Q?3KlwkEoVVRAl0diWK8PIjJKl8J0zJ7n1+eorUHUIAAYPsG8SLAekb8jy5c3x?=
 =?us-ascii?Q?THtm6+mf1dJvrhJxcnglNAwgOOoTHdcgpq+XqulnLZwoWoAVzIVBd7EAqDCO?=
 =?us-ascii?Q?WaYLgpiT1uBYC4QvDvbE9KM/Sj6yOl3aR+qsycBR5NJ6SEAdBxiSWkBgeCDf?=
 =?us-ascii?Q?NsNyb2fmP/MJq+5BZODV6wDsRMz5YpZou/qXeNpbHfizQ3x9cXYCGRAf8NH8?=
 =?us-ascii?Q?41baKA+L6o1Xb60B4JP5UFW/xFe/HjTZ9zyv5ERo9fn5WlnABiPaPbW4wee7?=
 =?us-ascii?Q?bk/NexQeJERFU9IQaSZD2igXjxAkHOkJA0cww8+08TiCzRilSuaBtyPdxHRb?=
 =?us-ascii?Q?rYo3o1K1BPZ8RlRRl5YGf4T/Hrr3wy6dYmyrMWHvl58Jx9k6fOY736MzDF18?=
 =?us-ascii?Q?9nTdtcOEF5t7O7ywg6lrWfHCssdVL9kD45Tv4jSqEEF4Mm7u0c3lAqs8e3Lh?=
 =?us-ascii?Q?eCWXmETTzhbqiZ3UjP4S4Oiu3HQkd3rCYP5dBddYiEzpqbAgjHIUJMfmIkW6?=
 =?us-ascii?Q?LRg7WMrstxQUzKRcRXaFiD0BvoBzWH/nzQZy1NLrMuJ0FrTzPFjyK7DZCSnN?=
 =?us-ascii?Q?qITXCrF6RFLdcFgz7AC2nO8Qhq2aVCm27TNGSpAH96uMzjwqQAqo0QYS8ut2?=
 =?us-ascii?Q?lSFWq+QuBoxvYbBmKftF88pBtXx7dA9UQgmroFax2LNPWbX6Okc4/0OXqo+s?=
 =?us-ascii?Q?VENyLS68D4PGSI0xqjvKebkco/HX2d//3miqC/YPWE26gb0SNkSQypoxTDp/?=
 =?us-ascii?Q?ckm2Jakul0GRlniJ8KyAFVa473SBI/Bf2aUczTrg3VVq8jZFOZbjWQGj0g+n?=
 =?us-ascii?Q?P4Dx1E0nuiSzm8S9C66o/dRctFRZ3QP3jqW0u0DMtos1UyS+1F0VdiUtLbGI?=
 =?us-ascii?Q?37cE9wumIHSHFQza7KwNZiUoSUZ3SIBbXcfJDTljQNgflZlypn1gZMjISTc7?=
 =?us-ascii?Q?d1hjDvf4Z0nsHZ1sGPApgBPmfmBHOtkxO/6lyMnSn0htY5eJLrmwUoF+QqZ+?=
 =?us-ascii?Q?04I1xkiplxS+bp0IJj29Qhao5+wxlMilu8hYiZEVvz891uL5GNL1dNM0QGij?=
 =?us-ascii?Q?ic5PDGwSW4HcmEIFhNLW+j5mD5ihI9zSzS447CHbju5hSS+BHrAqFjGnjp4z?=
 =?us-ascii?Q?QkTDHld/nr3Vk/hBWV6KBoNv+Rzf/SfLIx48wrw9X8Bo5E3M6/JR9ITYBYRK?=
 =?us-ascii?Q?t9sehiSRLOEfpxIBhJ9SpzV0UCmsr1A8x/YhZlDI1y6/nQqovWTMomM92q8d?=
 =?us-ascii?Q?fNu5cQERTslof0nqX6Rs8YH8e/p3GzgN0vfLeb0XoFXZtj04oEKCg1YVa6C2?=
 =?us-ascii?Q?3rBzQHfRHp+AoxJ3c7mswCyXSJbo+ofgo0RIvwtXvYxP+dYav6r+ouV1Mvem?=
 =?us-ascii?Q?xtHmgj72ORPe7HeE06NQMRp1Gw6ihaqmsm9hb+PifqTqIkhlFLA/xTnG2lXR?=
 =?us-ascii?Q?+NjaapPQ04p9FVSV+3z6cD22CiLbZHYhyGdW5P1dq9vVlmt3HIlW0xliDvlD?=
 =?us-ascii?Q?gsKyS68TWUFUTk/3bovGjvioD4N6IWvqg8ubfv1S?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eb9da6d-e846-4371-b813-08db082e4c71
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9433.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 10:38:34.9908 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aPSBowoJpb5Ok8NpX/zJdOmq+tUzBQAWReTBDnlm/mnQdkGzXx3oqHrnUkD61e7z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB8025
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] fsconfig: New case cover CVE-2022-0185
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, Feb 01, 2023 at 01:49:43PM +0100, Petr Vorel wrote:
> Hi Wei,
> 
> ...
> > +++ b/include/lapi/fsmount.h
> > @@ -11,12 +11,15 @@
> >  #include "config.h"
> >  #include <sys/syscall.h>
> >  #include <sys/types.h>
> > -#include <sys/mount.h>
> 
> >  #ifndef HAVE_FSOPEN
> >  # ifdef HAVE_LINUX_MOUNT_H
> >  #  include <linux/mount.h>
> > +# else
> > +#  include <sys/mount.h>
> >  # endif
> > +#else
> > +# include <sys/mount.h>
> >  #endif
> Does <linux/mount.h> conflicts with <sys/mount.h>? Or why is this needed?
> 
> >  #include "lapi/fcntl.h"
> > diff --git a/runtest/syscalls b/runtest/syscalls
> > index ae37a1192..b4cde8071 100644
> > --- a/runtest/syscalls
> > +++ b/runtest/syscalls
> > @@ -383,6 +383,7 @@ fremovexattr02 fremovexattr02
> 
> >  fsconfig01 fsconfig01
> >  fsconfig02 fsconfig02
> > +fsconfig03 fsconfig03
> 
> NOTE: you also need to add a new record in testcases/kernel/syscalls/fsconfig/.gitignore.
> 
> > diff --git a/testcases/kernel/syscalls/fsconfig/fsconfig03.c b/testcases/kernel/syscalls/fsconfig/fsconfig03.c
> > new file mode 100644
> > index 000000000..e076c2f09
> > --- /dev/null
> > +++ b/testcases/kernel/syscalls/fsconfig/fsconfig03.c
> > @@ -0,0 +1,58 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Copyright (c) 2023 Wei Gao <wegao@suse.com>
> > + */
> > +
> > +/*\
> NOTE, there should be docparse label:
>  * [Description]
> > + * Test add some coverage to CVE-2022-0185.
> > + * Try to trigger a crash.
> > + * References links:
> > + * https://www.openwall.com/lists/oss-security/2022/01/25/14
> > + * https://github.com/Crusaders-of-Rust/CVE-2022-0185
> > + */
> > +
> > +#include "tst_test.h"
> > +#include "lapi/fsmount.h"
> > +
> > +#define MNTPOINT	"mntpoint"
> > +
> > +static int fd = -1;
> > +
> > +static void setup(void)
> > +{
> > +	fsopen_supported_by_kernel();
> > +
> > +	TEST(fd = fsopen(tst_device->fs_type, 0));
> > +	if (fd == -1)
> > +		tst_brk(TBROK | TTERRNO, "fsopen() failed");
> Sooner or later we should add SAFE_FSOPEN(), but that can wait.
> 
> > +
> > +}
> > +
> > +static void cleanup(void)
> > +{
> > +	if (fd != -1)
> > +		SAFE_CLOSE(fd);
> > +}
> > +
> > +static void run(void)
> > +{
> > +	char *val = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA";
> > +
> > +	for (unsigned int i = 0; i < 2; i++) {
> > +		TEST(fsconfig(fd, FSCONFIG_SET_STRING, "\x00", val, 0));
> > +		if (TST_RET == -1)
> > +			tst_brk(TFAIL | TTERRNO, "fsconfig(FSCONFIG_SET_STRING) failed");
> TST_EXP_PASS() or other could here be used (it should be changes also in fsconfig01.c).
> 
> Hm, there is a kernel fix from 5.17 [1]. But test fails when I run it on 6.2.0-rc5:
> 
> tst_supported_fs_types.c:165: TINFO: Skipping FUSE based ntfs as requested by the test
> tst_supported_fs_types.c:157: TINFO: Skipping tmpfs as requested by the test
> tst_test.c:1634: TINFO: === Testing on ext3 ===
> tst_test.c:1093: TINFO: Formatting /dev/loop0 with ext3 opts='' extra opts=''
> mke2fs 1.46.5 (30-Dec-2021)
> fsconfig03.c:44: TFAIL: fsconfig(FSCONFIG_SET_STRING) failed: EINVAL (22)
> 
> Isn't it the opposite: we expect to fail, thus TST_EXP_FAIL() should here be
> used?
> 
I have not test on 6.2.0 kernel, i need reproduce this firstly.
> > +	}
> > +	tst_res(TPASS, "Try fsconfig overflow on %s done!", tst_device->fs_type);
> > +}
> > +
> > +static struct tst_test test = {
> > +	.test_all = run,
> > +	.setup = setup,
> > +	.cleanup = cleanup,
> > +	.needs_root = 1,
> > +	.format_device = 1,
> > +	.mntpoint = MNTPOINT,
> > +	.all_filesystems = 1,
> > +	.skip_filesystems = (const char *const []){"fuse", "ext2", "xfs", "tmpfs", NULL},
> 
> I wonder why this is should not be run on XFS and ext2.
ext2: this if failed on one of my specific machine, so normally this should run.
xfs: this always error happen with error code "TFAIL: fsconfig(FSCONFIG_SET_STRING) failed: EINVAL (22)", i 
need debug kernel to check what's happen.
> 
> Also, while we have CVE and kernel fix [1], it should be marked in struct tst_test:
> 
> 	.tags = (const struct tst_tag[]) {
> 		{"linux-git", "722d94847de2"},
> 		{"CVE", "2020-29373"},
> 		{"CVE", "2022-0185"},
> 		{}
> 	}
> 
> Kind regards,
> Petr
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=722d94847de2
> 
> 
> > +};

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
