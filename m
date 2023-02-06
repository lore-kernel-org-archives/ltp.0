Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD2B1C05027
	for <ltp@archiver.kernel.org>; Tue,  7 Feb 2023 00:47:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7F86E3CC266
	for <ltp@archiver.kernel.org>; Tue,  7 Feb 2023 01:47:26 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1A7173C7835
 for <ltp@lists.linux.it>; Tue,  7 Feb 2023 01:47:14 +0100 (CET)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04on060a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0c::60a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C52722009A2
 for <ltp@lists.linux.it>; Tue,  7 Feb 2023 01:47:13 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JrD6/ljGX/BkzJJLiXrmNAU+qwuljh8z4JQQAONeppbo8rGXw7uWDxvLg25uPJ1K/hZQ5/BBwyLuJs+RG/rMji2wWI48pMgYk73t2gDO3CSaxsspsabMCkwQruhrpTJSXr4Lbd4Mw1o1V0sG3XUSOLSOh8pq68tce8dQB/FQv+oUH/E7kxmBWpfB+YZT44+LmdL+bHNQsqelyOJn380MZOvXS7J6y2OlGVqjHDCIGACJnYewCFavDRd1wrfteuUYKeMZhDyLtGy5VB3npbzZNWKQvveSoryDAdLlS3PEn9+tzTMC4+PmNzp7eyZxmGAh7mMJCG0lAoOWWbjDevbGgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h+4rss5xhSOzDJKEChbVN3kBsQHaXgLp3z0gj4ldk7w=;
 b=grtzOlpAjOhZt1qHFSmCNqfaaTmbLzd3ghLblLxqUcwOHWi0s4oWn4xsFQOu86+czwL2Vm42FlwtK5XWdnZUaCBaqp1OJIXck0DyUhzlyS76+vxWl5hjlhsnI0xdh1SjPYLH9oLaOBHg80N1/Y4C1PDhnxdkbGgseEDlUKfIGBklMEfElgWFrF+baEa9WablTXn143ZyCQb4vswlJmXc1pZVO6LdGbmaDtVM7tYT8maiMaNY1ukaEacBOankaxa+c0P41i2zgDI96An+dTvpyUgr2SUMj4CT/n5YrviPRK7qzkC3Zpy9eCVa5M9+vrTGo+CiUlduOK5MPnpt2z7TLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h+4rss5xhSOzDJKEChbVN3kBsQHaXgLp3z0gj4ldk7w=;
 b=MX5KB3tJt/CJdR8s4DJ+xXNYyYPNl/whpJu8ophWil27vZNefH4n1LbAI1tXnJNQBMuJVs3oFX9/uBQOvv1xrurQOM/XLJo5BtqiLIBFnj+JUfYyCSgZTcSlEBHUqnqUKWaGmHXG2m45nit1kpFovsf1cMNNhYbQJgK9Q+XAyXUnIrf6qsVWUk6Q/XkUFm5P2tCtnO/aNCsRCl2+TrIT4Ya5gGkSBczdR1DR7k46WXYp0E1nr1cjqUUv5YKQcwYkhti+yebX8Gt5dZcHLty+n/Zd+5s5vMTp2zXaiYabdIH74inY6REl7QZwIsA/I5zfrCQ1Khsi7YvWhVBCkXEc4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS4PR04MB9433.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::14)
 by PR3PR04MB7211.eurprd04.prod.outlook.com (2603:10a6:102:93::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.36; Tue, 7 Feb
 2023 00:47:11 +0000
Received: from AS4PR04MB9433.eurprd04.prod.outlook.com
 ([fe80::7f5d:f7d9:47b1:cc2e]) by AS4PR04MB9433.eurprd04.prod.outlook.com
 ([fe80::7f5d:f7d9:47b1:cc2e%3]) with mapi id 15.20.6064.022; Tue, 7 Feb 2023
 00:47:11 +0000
Date: Mon, 6 Feb 2023 11:42:52 -0500
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Y+EkZg0oHW6L0N3z@aa>
References: <20230129115021.25778-1-wegao@suse.com> <Y9pf5075zsuAhznN@pevik>
 <Y+DYmkBnv/NQK8gZ@aa>
Content-Disposition: inline
In-Reply-To: <Y+DYmkBnv/NQK8gZ@aa>
X-ClientProxiedBy: TYWP286CA0025.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:262::13) To AS4PR04MB9433.eurprd04.prod.outlook.com
 (2603:10a6:20b:4e9::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9433:EE_|PR3PR04MB7211:EE_
X-MS-Office365-Filtering-Correlation-Id: bfdb2528-fa84-441a-139e-08db08a4d8c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NOHjNApKDJYEg0MJRpsC2SVl+3e5CH25qE8Bd9DMrbaw4WwyvJbj2MO7Z95JdRJTqR+MIhKTkuBQFE+jaRj0J8W8/52SadaXNjObMNp2uGUM0ztN06AaNsSR6VdCEdiHHk9h1S9Q45ZQg3t0ZkBAZhxqq86QCwapfwi0NPwdiCExbMiff8VVA0ocoPgVnw1FHIIi2rCC/lwa7boHev+NThJbVFK+YIErn1tqgELnHU6nqR3+zf6jtUIFZBiFTwEuRmNRWsRPpWj7d4Vsggg0CVWxPS68DZDd8RpNhKaHp3lYztkrzjbyjz2bueklKeyi7iOpkrXK60VCFagvtlTPVPJ1z2okKixM8VSrbYyi/lQrESX8CXYZTjV3GdyALxkW0R1oIoW+rs7KxyG71MJFqZ5nw6syDdRXRBzQDBX9YI7Z2diqEgd0DmZq3EyvNiBFI0MBuWka++zbvJhU0VGcYx7AuItYcCyu336xaK0A2LZzJYR6FwqXU+Dum2U9dEmS8AQipWrNS0iLySWAQbS/nWvpD0Il3u6PKl9UhNCYcfl1P4/bpFRyxdod8YL+5RJluLkWYC+WFxbqFvXKLD7Wlfne5d2ufV0oQ+C4vBsKdgv4UqDFGKclCHJLfLeZgIF1/3SpsQUnz/fulWkC196fdKoJZ8CpuJ1QmNUiCBcvwpnK2tUNxey2jaxnVozmsAivbBgT2aes6xEmYnU4zij6jVFMsv9Eheb3B41wGe/pYurMSpp26Z/WguUvyutqDBJw
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR04MB9433.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(7916004)(346002)(376002)(366004)(39860400002)(136003)(396003)(451199018)(2906002)(8676002)(4326008)(38100700002)(66946007)(66476007)(83380400001)(66556008)(6916009)(8936002)(86362001)(41300700001)(5660300002)(316002)(6512007)(9686003)(26005)(6506007)(33716001)(6666004)(6486002)(478600001)(186003)(966005)(67856001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?me9dP2Rn6Harw6UqNoK+31PeCaaO4GPEqdLIw9OF/QliJ9KdYxgHguWZdmTl?=
 =?us-ascii?Q?PmQn1+47/1eYNH0jpi2wx2o5t9sOjGYkXXKrIKFtPKPWlyZJeQxvh7U22XVF?=
 =?us-ascii?Q?p9lR5OWr09gon5uSlhU1d9vmbCDZOUbSc1I0dN7NdkMY2rizuBT2AggtF1qs?=
 =?us-ascii?Q?VJvO6Down1TH+wu+IWsmBkpaGxIFeM2fCG0CTaUA3P1r5/5KpR6/us4HABpF?=
 =?us-ascii?Q?qiov+yfZTMnL2H7JFz0/fvBpyx4LLtxg31uKa0Xq6YYaaQdhTV08Y84kknwL?=
 =?us-ascii?Q?OFNaeHW6lm7uk5vSz6rjhu5Q4Z5A1U2qEvWKenHNhvCO5+MZ6vrvCg74oW2G?=
 =?us-ascii?Q?+Zu42D4ZdBkkPPQZtdwhVc5hilKIpeStSdghXE+zAZHlubTtNvgG1emTsjpW?=
 =?us-ascii?Q?8RQySyG347Jla0nD96SvtlSLWdBASsAKlAdqo80zU5H6B0vYT8xBxLIPYDJP?=
 =?us-ascii?Q?chj1yjbcHDI2KoO/GMjoO+S8Mo37rk2tTbcRT8UR84R4Bsnoz2+R1QvEOHiE?=
 =?us-ascii?Q?lKw9hFT3YHEgV4vrvNYFu+vUM8H7hdrrqF64jqcraOiX3Mvu4ogmjkd/AoqZ?=
 =?us-ascii?Q?VubCuXCu9TeX4Hz7SZ8ex1TVmt/z9fePZPpiqHwwkvEME41U7dzjxEl/YCzO?=
 =?us-ascii?Q?d9BlU4eAJBxpZJ4HUGUzcDM4WWyen7e/kfCfs8rsZDMMSir4Dk3ePnGG0sdn?=
 =?us-ascii?Q?1AivVmd0Ojo9SzwCuwR5mQIuR8inreQRtjPhELXvHZ9nJnB/TRpzJAWsrxXr?=
 =?us-ascii?Q?A4FoKxnVOTjRLzNspV9J3Fyw25DRleTra/ILAxt/qaFYcHvnt+EWgPkLYklW?=
 =?us-ascii?Q?yibnEnc3girL3JNZB9h9N6oyG7A+9/OzPJoTgIcapFw/GlOe35/SzhBYmJDS?=
 =?us-ascii?Q?auqlb3xF9JJ7KlMrxtTnHXjmQ6DtnW41Vw8Fk/c3ntfVbiLbgB8w5kwRI4xY?=
 =?us-ascii?Q?TbmNSOGHm6jNkWq46PZ3bTefxESQD6HbZnYX8ZjcMv+LClGeJchjvLrfZrUD?=
 =?us-ascii?Q?h9lPqUO9IgC3+DWqfRRaDg4OTqU7j31C3/TNQ65ZS8LdAYfCpma11C2fzqPi?=
 =?us-ascii?Q?4oRkXj0jRgUKDHBCOFZ15xnAZXFu91SlEo0fTSzQZ9rqA1pKreNYs58X+Mcc?=
 =?us-ascii?Q?+2O995GFv3juAVROjj7hEJV84c7psEmkcnK6IQfbaR1ZP+vhkphmqDEF9rcX?=
 =?us-ascii?Q?KeXVhEzwP8K5sPwMXY7kBMvh0INPN61R8iTp2x3tmllXHNeK+bHaA8zFqt91?=
 =?us-ascii?Q?SLy/5idoZvI+AkiGnNk0S+kGslMOOrj0Um9kP/enTJms1Z7sbnAUTyUwBYpC?=
 =?us-ascii?Q?u/DOAril/rZL2VQZay6rKe8KU4ylsd2L6L2mmxlAiOD+msYZgenB/TKHTiJW?=
 =?us-ascii?Q?7OJwSNeQRsU5dip+4YfCxtH38vzPHJwAgVCPxVRyqJaVSR72/KW6/8pOAbU7?=
 =?us-ascii?Q?ulbMwNfZ5hqySLey5fy9P5NVOl8WHYhtCYY2J5sv+BuKkYtdD+S/2AHYpq5h?=
 =?us-ascii?Q?VryjZBYtPraVZus6RID6y5rFGk9ZMr6kXOe8PrQh3VVdl+o2nn8QLg7md3AD?=
 =?us-ascii?Q?SGpul3LqMmMa5DaaUCEY/tjQMM4yCVsZ7KcoSrJ2?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfdb2528-fa84-441a-139e-08db08a4d8c5
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9433.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2023 00:47:11.2509 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J2voU/8brd23wpzN6Y3kLdKP9TZqYVECgvmiwxW7J3J3V9cNCFwTSD+d16ENRJ0l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7211
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
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

On Mon, Feb 06, 2023 at 05:38:18AM -0500, Wei Gao via ltp wrote:
> On Wed, Feb 01, 2023 at 01:49:43PM +0100, Petr Vorel wrote:
> > Hi Wei,
> > 
> > ...
> > > +++ b/include/lapi/fsmount.h
> > > @@ -11,12 +11,15 @@
> > >  #include "config.h"
> > >  #include <sys/syscall.h>
> > >  #include <sys/types.h>
> > > -#include <sys/mount.h>
> > 
> > >  #ifndef HAVE_FSOPEN
> > >  # ifdef HAVE_LINUX_MOUNT_H
> > >  #  include <linux/mount.h>
> > > +# else
> > > +#  include <sys/mount.h>
> > >  # endif
> > > +#else
> > > +# include <sys/mount.h>
> > >  #endif
> > Does <linux/mount.h> conflicts with <sys/mount.h>? Or why is this needed?
> > 
> > >  #include "lapi/fcntl.h"
> > > diff --git a/runtest/syscalls b/runtest/syscalls
> > > index ae37a1192..b4cde8071 100644
> > > --- a/runtest/syscalls
> > > +++ b/runtest/syscalls
> > > @@ -383,6 +383,7 @@ fremovexattr02 fremovexattr02
> > 
> > >  fsconfig01 fsconfig01
> > >  fsconfig02 fsconfig02
> > > +fsconfig03 fsconfig03
> > 
> > NOTE: you also need to add a new record in testcases/kernel/syscalls/fsconfig/.gitignore.
> > 
> > > diff --git a/testcases/kernel/syscalls/fsconfig/fsconfig03.c b/testcases/kernel/syscalls/fsconfig/fsconfig03.c
> > > new file mode 100644
> > > index 000000000..e076c2f09
> > > --- /dev/null
> > > +++ b/testcases/kernel/syscalls/fsconfig/fsconfig03.c
> > > @@ -0,0 +1,58 @@
> > > +// SPDX-License-Identifier: GPL-2.0-or-later
> > > +/*
> > > + * Copyright (c) 2023 Wei Gao <wegao@suse.com>
> > > + */
> > > +
> > > +/*\
> > NOTE, there should be docparse label:
> >  * [Description]
> > > + * Test add some coverage to CVE-2022-0185.
> > > + * Try to trigger a crash.
> > > + * References links:
> > > + * https://www.openwall.com/lists/oss-security/2022/01/25/14
> > > + * https://github.com/Crusaders-of-Rust/CVE-2022-0185
> > > + */
> > > +
> > > +#include "tst_test.h"
> > > +#include "lapi/fsmount.h"
> > > +
> > > +#define MNTPOINT	"mntpoint"
> > > +
> > > +static int fd = -1;
> > > +
> > > +static void setup(void)
> > > +{
> > > +	fsopen_supported_by_kernel();
> > > +
> > > +	TEST(fd = fsopen(tst_device->fs_type, 0));
> > > +	if (fd == -1)
> > > +		tst_brk(TBROK | TTERRNO, "fsopen() failed");
> > Sooner or later we should add SAFE_FSOPEN(), but that can wait.
> > 
> > > +
> > > +}
> > > +
> > > +static void cleanup(void)
> > > +{
> > > +	if (fd != -1)
> > > +		SAFE_CLOSE(fd);
> > > +}
> > > +
> > > +static void run(void)
> > > +{
> > > +	char *val = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA";
> > > +
> > > +	for (unsigned int i = 0; i < 2; i++) {
> > > +		TEST(fsconfig(fd, FSCONFIG_SET_STRING, "\x00", val, 0));
> > > +		if (TST_RET == -1)
> > > +			tst_brk(TFAIL | TTERRNO, "fsconfig(FSCONFIG_SET_STRING) failed");
> > TST_EXP_PASS() or other could here be used (it should be changes also in fsconfig01.c).
> > 
> > Hm, there is a kernel fix from 5.17 [1]. But test fails when I run it on 6.2.0-rc5:
> > 
> > tst_supported_fs_types.c:165: TINFO: Skipping FUSE based ntfs as requested by the test
> > tst_supported_fs_types.c:157: TINFO: Skipping tmpfs as requested by the test
> > tst_test.c:1634: TINFO: === Testing on ext3 ===
> > tst_test.c:1093: TINFO: Formatting /dev/loop0 with ext3 opts='' extra opts=''
> > mke2fs 1.46.5 (30-Dec-2021)
> > fsconfig03.c:44: TFAIL: fsconfig(FSCONFIG_SET_STRING) failed: EINVAL (22)
> > 
> > Isn't it the opposite: we expect to fail, thus TST_EXP_FAIL() should here be
> > used?
> > 
> I have not test on 6.2.0 kernel, i need reproduce this firstly.
> > > +	}
> > > +	tst_res(TPASS, "Try fsconfig overflow on %s done!", tst_device->fs_type);
> > > +}
> > > +
> > > +static struct tst_test test = {
> > > +	.test_all = run,
> > > +	.setup = setup,
> > > +	.cleanup = cleanup,
> > > +	.needs_root = 1,
> > > +	.format_device = 1,
> > > +	.mntpoint = MNTPOINT,
> > > +	.all_filesystems = 1,
> > > +	.skip_filesystems = (const char *const []){"fuse", "ext2", "xfs", "tmpfs", NULL},
> > 
> > I wonder why this is should not be run on XFS and ext2.
> ext2: this if failed on one of my specific machine, so normally this should run.
> xfs: this always error happen with error code "TFAIL: fsconfig(FSCONFIG_SET_STRING) failed: EINVAL (22)", i 
> need debug kernel to check what's happen.

Update xfs investigation progress:
After some debug check ths kernel file system code, i found xfs ONLY can accept key which defined in xfs_fs_parameters, so
EINVAL returned.

===xfs kernel logic tracking detail start ===

SYSCALL_DEFINE5(fsconfig   fs/fsopen.c
	vfs_fsconfig_locked
		vfs_parse_fs_param
				ret = fc->ops->parse_param(fc, param);  // this is xfs_fs_parse_param				
					xfs_fs_parse_param
						fs_parse 
							__fs_parse
		
103     int __fs_parse(struct p_log *log,
104                  const struct fs_parameter_spec *desc,
105                  struct fs_parameter *param,
106                  struct fs_parse_result *result)
107     {
108             const struct fs_parameter_spec *p;
109
110             result->uint_64 = 0;
111
(gdb) l
112             p = fs_lookup_key(desc, param, &result->negated);
113             if (!p)
114                     return -ENOPARAM;   <==== this error


static const struct fs_parameter_spec xfs_fs_parameters[] = {
        fsparam_u32("logbufs",          Opt_logbufs),
        fsparam_string("logbsize",      Opt_logbsize),
        fsparam_string("logdev",        Opt_logdev),  <=== ONLY can accept this table as KEY!!
        fsparam_string("rtdev",         Opt_rtdev),
        fsparam_flag("wsync",           Opt_wsync),

===xfs kernel logic tracking detail end===

> > 
> > Also, while we have CVE and kernel fix [1], it should be marked in struct tst_test:
> > 
> > 	.tags = (const struct tst_tag[]) {
> > 		{"linux-git", "722d94847de2"},
> > 		{"CVE", "2020-29373"},
> > 		{"CVE", "2022-0185"},
> > 		{}
> > 	}
> > 
> > Kind regards,
> > Petr
> > 
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=722d94847de2
> > 
> > 
> > > +};
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
