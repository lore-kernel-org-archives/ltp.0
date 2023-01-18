Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18BEBC00A5A
	for <ltp@archiver.kernel.org>; Wed, 18 Jan 2023 03:37:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C74D73CD99B
	for <ltp@archiver.kernel.org>; Wed, 18 Jan 2023 04:37:21 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 761EA3C21B7
 for <ltp@lists.linux.it>; Wed, 18 Jan 2023 04:37:10 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2059.outbound.protection.outlook.com [40.107.20.59])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 8DC5D200924
 for <ltp@lists.linux.it>; Wed, 18 Jan 2023 04:37:09 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cmSRHtE/4PWcuoO5a3k5Qfw0uKQ/fI1i7Ane481wZrjw+N9iq9sjExG/KjM8K7tJYQAcXhnq6qsD51vteco+RJI1apuDLAmZwwcK4h/ep3wJpIeH/5+OvYCVTnJpXMJvuJsB6GTdBpq6Ws26Kx4s6esmOwL/+2HzI36t1SzWZtEdFnpI8ljPOlTRTTqn9FpTvxmb7YIUR4XNYLhe3uTljdXxRwAD6JKlyZQ1LwvcLd36RTAQNrhbcPJAHGAZqFPTDVGpx9HFPiWQNs96jnPaxqsbWrVLRJd9vwrlPuiVVanzahb0R1qezf3N7IhdkeE/bl5a9IiX9FNRz/adh+6EwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i0pjZnqjIoazfrXa+VsGcBGaAnuVdlaHBAKRmNuGSHc=;
 b=dqgMu8VkyogJBZ4Xx1JEUfsMAumTjV8mvi0ya0tdoK+t3bmrnxegs0oiGgTn1GxZlGbff7Mtg77+XFppGtPzBz1R6HLqkn5P10hv+XXrOjQhEIswL1MY+uQi3taR+cwbjqB5YUwRtgos/J3milTg4aQ9nEG1psFA9LspdVjolNOZpvv1xIFxAK0dAH9Qz9ORHwPobtvXAQrYjQ9+bZbJBj+dvmgbJVly38sG73qVKb3z7LcHmDRss2+3uRMAai+7Sl11T0wDcWJIOR7z+jrgBqKgnf4KD5E7VHLzaChlrHa/imsPPgkPw5+vhhTLdLTXAl5Za6OscWiQ8bb05RiuXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i0pjZnqjIoazfrXa+VsGcBGaAnuVdlaHBAKRmNuGSHc=;
 b=A1X/PuVAC7sN7CNUK4ZxWnqol42/rK6AuC5/dbE7PEVkAC9KP7AkQYcwvqk2B2vnvo164tG34ai0Qrx4CPGNMfc6BGQ5JUCayMOsXIXVeqQePu4SBd/PFeHwcHRW+bzWNkTvz4Wi2zPGqzblVGmXzIv2qwNSSF/jMSIFmrO13c+MZDG2ROxe1kJrdK6oYyBYPds9UQNvIcoZCDpqplhTA2hwYTnNKPBkI1zBhOBp47aCaP70bvIoyFkFWzgSK3D3vOnHSnla2gPH90qcqSLf8xEpC0jh8kYUv245OX/6d2Pxu7WCFpudOk5T4nnBrjlPH2Zvnzhjm+KyKKLTdJDnpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS4PR04MB9433.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::14)
 by DBBPR04MB8028.eurprd04.prod.outlook.com (2603:10a6:10:1e0::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Wed, 18 Jan
 2023 03:37:07 +0000
Received: from AS4PR04MB9433.eurprd04.prod.outlook.com
 ([fe80::7f5d:f7d9:47b1:cc2e]) by AS4PR04MB9433.eurprd04.prod.outlook.com
 ([fe80::7f5d:f7d9:47b1:cc2e%4]) with mapi id 15.20.5986.019; Wed, 18 Jan 2023
 03:37:07 +0000
Date: Tue, 17 Jan 2023 22:36:55 -0500
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <Y8dpV7bZw5gKuCHF@aa>
References: <20230116084802.6510-1-wegao@suse.com>
 <20230116111749.18865-1-wegao@suse.com> <Y8VUWX54JpVqGloP@yuki>
Content-Disposition: inline
In-Reply-To: <Y8VUWX54JpVqGloP@yuki>
X-ClientProxiedBy: TYCP301CA0037.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:380::9) To AS4PR04MB9433.eurprd04.prod.outlook.com
 (2603:10a6:20b:4e9::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9433:EE_|DBBPR04MB8028:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fd0531a-71b8-43a0-9ff6-08daf90545dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wUV6YGEvRe68csyhIYhOzG5Gg1G4AKAqM49f7LNGa2rYdu9nDrQD8V7Q8OjkMQGvD4GC2rZZUIxc/w30dXFzdWxIWEpTnmrBpwpYKIz6QWBZLzyyKk69zo/iDMvoAiixzjAy9OcY/fJiJMa2JtHO/vwUYZ5slLA9N89P8Pq/xuNeMRgcumtaQacIqrkojSUw3f6bPueXPe+DdPV1a1ieSDjqnMbv6wmdLo5RLy6NbE5OL3L3/UBgrtK7ShJjtjGQHdyl4Inazwij8X7vcYk3PcTSaMZhMwCV54vG+vE7+SEB+Q5arpgK5E5MZ9D6WifzvHvv6VMitEXdBAfFeu1b3Gf6sXCb8DStoRDbRnksTpKtAb3nPIlCgAPPZzhZKuFIu9vQOvpox8S4FYkQ6wivZdDhGLpr96a3Ah5ggZmRMJLkBCXfbv7/21PW1RbYECxbVDDXW7poj2HEp39yUV4baD0OKRL0icl/HTj18TdmQi3yTRB2NYxMABhrltO76RW1jgV19Uyb8Ui/rr42vzeU6nPs1jBEdfqzdpoTcRgk4yG3VrkkitiT5hY+Ctj77+qoYFdfJfnfq/f8r9Ezpbt0wdhFWfrxOAPaZjwnSe8odQX7b6Y757g6hx55P3Cnv2gf
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR04MB9433.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(7916004)(396003)(346002)(136003)(366004)(39860400002)(376002)(451199015)(41300700001)(8936002)(316002)(19627235002)(4326008)(66946007)(6916009)(66476007)(66556008)(8676002)(33716001)(86362001)(2906002)(5660300002)(83380400001)(6506007)(9686003)(26005)(6512007)(186003)(6486002)(478600001)(38100700002)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8KtpvhFajbsPtZZg/VM3XyLNUg30gZEhv1cREtk2ulRhaorkxibruLESzri7?=
 =?us-ascii?Q?ZKQIB6FEKK4WNmxe1Vbx6Nb5i5DdFXZNXQvLgBFtkpJsDWv98prJ4KJL/wtM?=
 =?us-ascii?Q?fCL8bHScHKjGpRjZzNwOvlPHwbnwfeMH3entRqPDs3ApsOIOWj51QVsh4Tbv?=
 =?us-ascii?Q?a3NtM8JIao+8iq8OwiKdrIi0F8zXItNXGNEtIGrPE1cF/TScyZupml3zmq5L?=
 =?us-ascii?Q?csTAKklGkurdkEROSN3vUd1HaqY5zxWz8OkJbn2t545wSqIf3CNrmvz78PwB?=
 =?us-ascii?Q?CtSqzpf8uZQc7Xh12KR1DbEcxDX1T94F9HR0+hEYttAZPAhLaKUv+/vhsuPy?=
 =?us-ascii?Q?nM9/PrptVlmc0fD0UMf841sVqBtbtgN7jvR1BU4y9U71ZZnjIU31jk+C5wRz?=
 =?us-ascii?Q?G4R4lDoFw74imZYM+qDTlmWnB87Lz/owGeO6RA3lf75d30wTGdzOqH/EzXxn?=
 =?us-ascii?Q?hLedRpD2tMmRfR9sYucxyJRp6GRLyQwTZHKJ9p5+kr3WjtPY61aJiYw74pI1?=
 =?us-ascii?Q?T3M6yuNCrcsAoTIEgRuNuA2S2+M5MJAYSI1YGDzlII8s+WIp4i4b2U1qhJO9?=
 =?us-ascii?Q?m9/dr0Ju0RqV6ud04ay7MQiKq6jcyAikrJryDCqXnfxhNOl82xJvFRc3UQSz?=
 =?us-ascii?Q?DlBWorFHY1azVYRXGpoI4ZxFJW7pOHT5JbgC3UF2JJa5XBftsbFsfWMq0pUa?=
 =?us-ascii?Q?iLP35qs6SS6jdHeF6UngLrBMpgE11DQBT/OO/Pwo6EOaIC5EtPpR9JUhhR6t?=
 =?us-ascii?Q?RwiynZLxomlXkTIqR7ylkcSCKg7n+hYpZt3ttnmGQM/DkZoaRyY3HhWIT5NW?=
 =?us-ascii?Q?gYboggxuPk3wGm0PUe0yDh5uWRzjptInxeqSXWPIi1RV+QOK32NnFQGdmjS6?=
 =?us-ascii?Q?tJ21aAWFbQQsaw6R2ltEK4bppHKgPN7aJrjL3wHWbsaj9FA29AiN+71pOX+d?=
 =?us-ascii?Q?5Z1ZvsKUBIUfhAaNT4fN/hZ2tWlynWEesZVHysZHZwd/7HB/SZxmjl8g237T?=
 =?us-ascii?Q?OCYACy4ZR5gv360OXyN2ifcAf129WO2bQqJ+Rjs2+GXC4iDuK+YAM2lQWdPB?=
 =?us-ascii?Q?GX4TvU+xYwxZHN3jcBmrGfapkvPXG8xLJEej31fqNWgbkfR6YS8YvQuI2Syu?=
 =?us-ascii?Q?4KpQAqC7ZFpEkOyEv/pU3DppoQ3WOXHVOIx6bNZx3Mlm3O7t1JrkgKMg8nBJ?=
 =?us-ascii?Q?g4jrIXprPUbL53E3z4yUCQTDI+xR6seK9ShuP7w2ojd9MwNufDVj6+zyVD4i?=
 =?us-ascii?Q?usfT0FzTzQIVHIaTTWFwi/38j7rB45zC/ZUk2LCKxARonLMAWEecoghvtZ3A?=
 =?us-ascii?Q?nYpo69znNh0BS4gIXorCjB1Li2xFUOXwlYONKdfFIubN0z7Kvv8EtH0wEsey?=
 =?us-ascii?Q?CgL5F0R01Ii3VGGn8y2ViEqPczShCT0eBGP5fR+bZVFv7z/UJdsuwq+xOIzT?=
 =?us-ascii?Q?6WkQi8igza7jlWEb18LbilYtsuOeOmNolgelCnmmRSFDzLSBfDcLZcuWae4l?=
 =?us-ascii?Q?PUM/3YG+zphoJLhc55kQChAwNAkWYGsCQ1rJfsdJ8w1rozPnhv6YXADHDwm9?=
 =?us-ascii?Q?WpKgDOxikSIR3iMR8wk=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fd0531a-71b8-43a0-9ff6-08daf90545dc
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9433.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 03:37:07.0304 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NpZC3g4C8mVyW9nkKdLtQSHOWPzTZd1WDeCYzw3pX2jxB92U40gRxMOBN932MK7c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB8028
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] readahead02.c: Fix check input fsize
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

On Mon, Jan 16, 2023 at 02:42:49PM +0100, Cyril Hrubis wrote:
> Hi!
> > diff --git a/include/tst_device.h b/include/tst_device.h
> > index 977427f1c..f03f17f7d 100644
> > --- a/include/tst_device.h
> > +++ b/include/tst_device.h
> > @@ -6,6 +6,8 @@
> >  #ifndef TST_DEVICE_H__
> >  #define TST_DEVICE_H__
> >  
> > +#define DEV_SIZE_MB 300u
> > +
> >  #include <unistd.h>
> >  #include <stdint.h>
> >  #include <sys/stat.h>
> > @@ -49,7 +51,7 @@ int tst_clear_device(const char *dev);
> >   * free loopdev). If path is non-NULL, it will be filled with free loopdev path.
> >   *
> >   */
> > -int tst_find_free_loopdev(const char *path, size_t path_len);
> > +int tst_find_free_loopdev(char *path, size_t path_len);
> >  
> >  /*
> >   * Attaches a file to a loop device.
> > diff --git a/lib/tst_device.c b/lib/tst_device.c
> > index 48d7e3ab6..b098fc80b 100644
> > --- a/lib/tst_device.c
> > +++ b/lib/tst_device.c
> > @@ -38,6 +38,7 @@
> >  #include "lapi/syscalls.h"
> >  #include "test.h"
> >  #include "safe_macros.h"
> > +#include "tst_device.h"
> >  
> >  #ifndef LOOP_CTL_GET_FREE
> >  # define LOOP_CTL_GET_FREE 0x4C82
> > @@ -46,7 +47,6 @@
> >  #define LOOP_CONTROL_FILE "/dev/loop-control"
> >  
> >  #define DEV_FILE "test_dev.img"
> > -#define DEV_SIZE_MB 300u
> >  #define UUID_STR_SZ 37
> >  #define UUID_FMT "%02x%02x%02x%02x-%02x%02x-%02x%02x-%02x%02x-%02x%02x%02x%02x%02x%02x"
> 
> These changes are useless now.
ack
> 
> > diff --git a/testcases/kernel/syscalls/readahead/readahead02.c b/testcases/kernel/syscalls/readahead/readahead02.c
> > index 7acf4bb18..5989c7cbf 100644
> > --- a/testcases/kernel/syscalls/readahead/readahead02.c
> > +++ b/testcases/kernel/syscalls/readahead/readahead02.c
> > @@ -33,6 +33,7 @@
> >  #include "tst_test.h"
> >  #include "tst_timer.h"
> >  #include "lapi/syscalls.h"
> > +#include "tst_device.h"
> >  
> >  static char testfile[PATH_MAX] = "testfile";
> >  #define DROP_CACHES_FNAME "/proc/sys/vm/drop_caches"
> > @@ -366,11 +367,24 @@ static void setup_readahead_length(void)
> >  
> >  static void setup(void)
> >  {
> > -	if (opt_fsizestr) {
> > -		testfile_size = SAFE_STRTOL(opt_fsizestr, 1, INT_MAX);
> > -		tst_set_max_runtime(1 + testfile_size / (DEFAULT_FILESIZE/32));
> > +	/*
> > +	 * Acutaly dev size will reduced after create filesystem,
> > +	 * so use dev_szie * 0.8 as dev real usage size, test case will
> > +	 * create two files within dev so we need div 2 get max file size
> > +	 */
> > +	size_t fsize_max = tst_device->size * 0.8 / 2 * 1024 * 1024;
> 
> I'm not entirely sure about the * 0.8 here. I suppose that we need some
> space for metadata and some manipulation space but 20% is probably way
> to much. What motivation is behind the exact number here?
> 

Acutaly dev size will reduced after create filesystem, for example
system set default dev size is 300M but acutal dev size is 280M

"df -h" example resulst in case dev size = 300M:
/dev/loop1      280M  272M     0 100% /tmp/LTP_reaNP2ElW/mntpoint

Around 7% space loss so we use dev_szie * 0.9 as dev real usage size
Test case will create two files within dev so we need div 2 to get
max file size

> > +	/* At least two pagesize for test case */
> > +	pagesize = getpagesize();
> > +	size_t fsize_min = pagesize * 2;
> > +
> > +	if (tst_parse_filesize(opt_fsizestr, (long long *)&testfile_size, fsize_min, fsize_max)) {
>                                               ^
> 					      This is wrong, as long as
> 					      size of size_t and long
> 					      long is different it will
> 					      either corrupt memory or
> 					      crash.
> 
> The testfile_size has to be defined long long there is no way around it.
ack
> 
> > +		tst_set_max_runtime(1 + DEFAULT_FILESIZE / (DEFAULT_FILESIZE/32));
> 
> Why do we even bother with setting runtime if we are doing
> tst_brk(TBROK, ...) on the next line?
ack
> 
> > +		tst_brk(TBROK, "invalid initial filesize '%s'", opt_fsizestr);
>                                              ^
> 					I do not understand what
> 					'initial' means in this context.
> >  	}
> >  
> > +	tst_set_max_runtime(1 + testfile_size / (DEFAULT_FILESIZE/32));
> > +
> >  	if (access(PROC_IO_FNAME, F_OK))
> >  		tst_brk(TCONF, "Requires " PROC_IO_FNAME);
> >  
> > @@ -380,7 +394,6 @@ static void setup(void)
> >  	/* check if readahead is supported */
> >  	tst_syscall(__NR_readahead, 0, 0, 0);
> >  
> > -	pagesize = getpagesize();
> >  
> >  	setup_readahead_length();
> >  	tst_res(TINFO, "readahead length: %d", readahead_length);
> > -- 
> > 2.35.3
> > 
> 
> -- 
> Cyril Hrubis
> chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
