Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D051EC54EBE
	for <ltp@archiver.kernel.org>; Tue, 17 Jan 2023 02:23:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 09AC93CC8FF
	for <ltp@archiver.kernel.org>; Tue, 17 Jan 2023 03:23:11 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D35BE3CB4CC
 for <ltp@lists.linux.it>; Tue, 17 Jan 2023 03:22:59 +0100 (CET)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on2046.outbound.protection.outlook.com [40.107.105.46])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 91AAE100094B
 for <ltp@lists.linux.it>; Tue, 17 Jan 2023 03:22:58 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VyHungSWOqZa8bRwAXgf5XhUtMVvHi+MY7+midVN2vlrexkR+WRkTNQT4+UjUdg39lIxHGAy+T77o6QH3SpzdQ/7l+toutanHr8w3jz2yQk1fsvhi3wLyPH5ACliJyy/+3vmPugClSL7WxiFcJCPkluwsKh4x6LiFoo/njdLIcx3BLd3QQ7Ksp5w79z+h3N+4bZj9Peh9fqAoni/xN8KVSU6eFfWBnXPstPuJFSyFDcwadB1FsJnRE/ScGvWVFqQwLKIla6zV6LTUhCH/0w6Xirurbv866VEa03dIKvYdPJkZqV7d+D5AWLyzSRvqRdaLcwMdygq5D/dv+9PsIF+/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pp/R9rj3irBeLpTl9U+LUwR2zsBaKzQgks67SRKCRM8=;
 b=oTRA89P1RyjaS3rET2MHJJPWmkv0lpss/Bug+GQdV/nQOUblXwfEeGQiYtcm4lodpXcu2x8fC2vnRylMDfSTxE4mQ25e2ogb18/MX1Axts2VcllMbgCLxS7q9xuNa3frYLQX2N/hzFDCJM+wZUVtb1ftp1Xwd8tF5FYZoTyWO9zgPCR9EDUvo6/zv4dlV2o8l2SQXCqYHmEUYlMjVzKvD4yT9jPVmABXnPfiRjYZwR/SZ+zCHyQLW1Qgu3MUTcUp833/HjNGf6dpTHJd4WTAjyAgRCFeyqbMNHuHA8EkHXZF997i2DTK6nsuUQ+k0OR3UatJSCQa15SL9ExN/5cvuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pp/R9rj3irBeLpTl9U+LUwR2zsBaKzQgks67SRKCRM8=;
 b=oEalaCSQN6H4Ed5ySSZUsECZtox5wQz7J8z+Kx5FPmuLPZDKnHVmnfmG2xroAyE2AhiIR2OiqL4FG5ReMeg9pd6ayMGOoYi7MKjsTSrBp9xz53cXO48bjMKF/pSGuIpAzY4z/FcspmnqgRSw2zpoCLpu/4VSh96J9liaRH7JYhjurozFatAqilolIzg9VAGg/nGD2dakvDtQnE1yV4O9g/2GJBnH+2EVMo2e102G59YnJq7Bxq6d5Z9Nbtv88eAzYSfG3ulJcazRh6eU3JJGNs51I8j+0ELELrjh//eQg6nPn5l5hzfWFiD7PuTiZ3K9RO2PnIvftB30qRsdXQ5sCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS4PR04MB9433.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::14)
 by AM9PR04MB8857.eurprd04.prod.outlook.com (2603:10a6:20b:408::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Tue, 17 Jan
 2023 02:22:56 +0000
Received: from AS4PR04MB9433.eurprd04.prod.outlook.com
 ([fe80::7f5d:f7d9:47b1:cc2e]) by AS4PR04MB9433.eurprd04.prod.outlook.com
 ([fe80::7f5d:f7d9:47b1:cc2e%4]) with mapi id 15.20.5986.019; Tue, 17 Jan 2023
 02:22:56 +0000
Date: Mon, 16 Jan 2023 21:22:45 -0500
To: Richard Palethorpe <rpalethorpe@suse.de>
Message-ID: <20230117021631.GA20825@aa>
References: <20230116074101.1264-1-wegao@suse.com>
 <87fscawlku.fsf@suse.de>
Content-Disposition: inline
In-Reply-To: <87fscawlku.fsf@suse.de>
X-ClientProxiedBy: TYBP286CA0016.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:ce::28) To AS4PR04MB9433.eurprd04.prod.outlook.com
 (2603:10a6:20b:4e9::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9433:EE_|AM9PR04MB8857:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a3e4ee9-a82b-4706-f3e8-08daf831be90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N6n7qKiFGIqAgMAAawtrKkxEXWzuLHvj7zO+sxCzRvG1bNH+E2tfmvbYs9bRfbNqG4480w0nsmkYueCLk7BlwKbsP1sTsQtv/LyDE/PmG0NKTLTnQQuzh5JC1pswl+4qPg92JDSm96orPscJNMmL5VChWxyiP194AmdD/rw70hO8Zrq1gybWAJkZMWKnwH2dftEYIF8QuRJzZU9xGTqaK8XZab1zu6NFiMSUTEv4sFapOz9XE1fzOXf2LXsqDELTp4ien+nm0ZTv38jycNS6LI+U6V/AUIUwwuA7bDpH+a6uYUV1Pfh30h2JTPrgTdJ7Tnd9pG6/bhzq/7LbOd0p9dlo26dxRx2FP1pfV2jCt1CLYw+kPIwKKd58/ko4aKwS518Px9payZ3xU2dlgBXFdK8gm4OVU4InmoxI2Q+9KN/47jcV1KV6YWTmKAUcCHTnrY4/wUfrB52iPTuVHJd/ya9LLkUGJVCwJbyliS6ZCNPb3ewoX2sqZuRv3ecyjXgoaSemaoCyWnSHL3h10PtRQ9QXEzjkCM36idO6yNdENK74tmkloGwu3iyLYXuekdvI2u9lK81XKL1Ap2sabjGFND/7J2Xt0gL1ch19KPI/vAQbCqFQyEyN5IWFC5r2TTLX6SFEzGBtUaJPYHiTTC1jNlxaYADkq9SUdXEGYvrwTWI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR04MB9433.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(7916004)(396003)(346002)(366004)(376002)(39860400002)(136003)(451199015)(2906002)(4326008)(6916009)(8676002)(33656002)(66946007)(66556008)(66476007)(41300700001)(26005)(186003)(6512007)(9686003)(33716001)(6666004)(6506007)(1076003)(83380400001)(86362001)(316002)(478600001)(38100700002)(966005)(6486002)(8936002)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Sgcs8KOq7uELm2+Uw96jobSpr6ZWt036MpXbqZVe+NCLIN+xUry37w4NqF5F?=
 =?us-ascii?Q?ksSpU4GhsdmlAuIZClJPh/+2Lbky+GOb7hWuKb9YIvFx/D/CUzS6H5cw2FYA?=
 =?us-ascii?Q?aUdXJmsiRL4p/JEYlUWb6PWbBQFDUHkURN8DHkbTKqVytTSjSaUz5XemPLav?=
 =?us-ascii?Q?+I0xiIYvQy3bmv4WhAsw4uHTCBNPffa4whFY1cnl4L2MdpXpl/wknzRVsraE?=
 =?us-ascii?Q?aCzJbx9h+9SXFyD5+V8GQimQGC5TNhewIYk5GYQbI76XMOrTZzNV6RdZ4I/x?=
 =?us-ascii?Q?sKlcBNo8RQNGcJ1sQ9GTWlTlt4CY3e29KomX7oCQwtB+G1SehtMYA07j0N99?=
 =?us-ascii?Q?uPMYJnfK1ob/4urZgbrQRbgZ2YYQlHdNRZZceTtKyAt27Fkgnng4zLWoWhvg?=
 =?us-ascii?Q?3q6TR3Xph7Eph86dMfIeXMgB3YuHXaEhOKiQrN0k7iIfS2iFyF6tsXuC8XTp?=
 =?us-ascii?Q?MEXHOU5J19SQmp5cDjCEAdl26fIYPf3Qmapx/coqZfweNOJo1fwWtKx8Jjpj?=
 =?us-ascii?Q?H3Kea8WM+axr5PyELEKhkAwJtYhHY/2DYBCev77eBenv9hAvzyh55xceLDzC?=
 =?us-ascii?Q?EDOLClP/kVW0ULP9p/PCiw8RxoTUNhXYD3kP9xz5kQ4pTunIMN5Ski5e9B4L?=
 =?us-ascii?Q?gwAr8/ONUk5IxSPZKrUVr6n1JXOEaTmZJEnhdR9hD71LLOz0ijT/Hab974jH?=
 =?us-ascii?Q?9sWdRZJQGKL/eIbPlurg57BoNGuYUTCaVh2k0CU58Kua6Vosdfu/G88Dl3Ti?=
 =?us-ascii?Q?NIWadDFGyY158i2qejMU1v4erkjjUcZyKZLqxPqrM4LfTHYfrK/EKKvvCzhL?=
 =?us-ascii?Q?qGWf7dqIb4en0P4d5R278xemRIhAZ4DY4MPSxl4r/l5+OUJelqZgZQ7GD8X+?=
 =?us-ascii?Q?IWs+k7HsX0Gv4prVPFhWXugBjbE5sg/9QlBwdWEkYndUPQ5S7EBvOdMA+j6I?=
 =?us-ascii?Q?uktldrZAiDJr9hOQDsS38ehD/Ft42+qPMIXGHezxfpNJExdK1I/BWdnLNtpu?=
 =?us-ascii?Q?CXBxUoOHlU4+bZHbyMVWUVy87Cs/nmdu2P4EzGLKkGCioWYf+7KBXndiPVV1?=
 =?us-ascii?Q?s7/X5dJ+pBi96udc6TGDc+VCyvEyU5h1vOhoAPkvz3GxFa7EH6gExX3M5jXZ?=
 =?us-ascii?Q?N8PKew+oT8NpiTV0ZexQ5qhlaiw/+6GrcPRjX+pBsNqRMb8wS3GjV6ufKivS?=
 =?us-ascii?Q?kFaru2xWJwhONmsrSZrC6I/QK2o9mmaHfO8ugvnSDlDh3OzDPVTORdHyGEys?=
 =?us-ascii?Q?ZNU0AM7vKZVRVyBST4pbYfvL16aXg995X9xMnlF38cCjuF8UbcKpYRiiOrpJ?=
 =?us-ascii?Q?JdjOZwVN5UV7alF33OXSP3mXHoIX3Rcl3jifYiYoWdilvap7IhYFED7E+LTy?=
 =?us-ascii?Q?rQ/P2gUkHZD1Ba58fU4eb0xmI3YRgRAeoTszXX9SGHJS88m6uAlZreY58kbr?=
 =?us-ascii?Q?Vp8wM4OsV9h34lEFstb2wsKR72kfkaG5PH5qlNHRu5n7XUrr/EWJ9sLHP2iS?=
 =?us-ascii?Q?VUE+KbO2UcaWfF3a1qP/UtNiGCgz9FFsn6LC7hO8imf9Zw2/g7qYN1oQB+73?=
 =?us-ascii?Q?ZTeBaCukDOcw6a8DIso=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a3e4ee9-a82b-4706-f3e8-08daf831be90
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9433.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 02:22:56.3102 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gCTiw6IFlVyGnd15xPM2z/3lnwt5xTpRpYD3NoNZEssza4mYo39hqOTde6lFdiCD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8857
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] readahead02.c: Use fsync instead of sync
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

On Mon, Jan 16, 2023 at 03:08:44PM +0000, Richard Palethorpe wrote:
> Hello,
> 
> Wei Gao via ltp <ltp@lists.linux.it> writes:
> 
> > Use fsync on test file instead of sync should faster than syncing
> > whole system.
> 
> The test completes in less than a second in OpenQA. We don't want to
> risk introducing a regression or spend time reviewing changes unless the
> performance improvement solves a timeout.
> 
> I suggest you convert dup06 to the new API (for example) or investigate
> a test failure.
> 
The motivation of this change is base on the https://github.com/linux-test-project/ltp/issues/972
which give following suggestion:
"As we run the test inside a loop device I guess that we can also 
sync and drop caches just for the device, which should be faster 
than syncing and dropping the whole system. Possibly we just need 
to umount it and mount it again."

But currently i can not find any API to sync and drop caches just 
ONLY for device, so base my view just replace sync whole 
system to single file also can make a small help.

> >
> > Signed-off-by: Wei Gao <wegao@suse.com>
> > ---
> >  .../kernel/syscalls/readahead/readahead02.c     | 17 +++++++++++++----
> >  1 file changed, 13 insertions(+), 4 deletions(-)
> >
> > diff --git a/testcases/kernel/syscalls/readahead/readahead02.c b/testcases/kernel/syscalls/readahead/readahead02.c
> > index 7acf4bb18..e04046bc3 100644
> > --- a/testcases/kernel/syscalls/readahead/readahead02.c
> > +++ b/testcases/kernel/syscalls/readahead/readahead02.c
> > @@ -99,6 +99,17 @@ static void drop_caches(void)
> >  	SAFE_FILE_PRINTF(DROP_CACHES_FNAME, "1");
> >  }
> >  
> > +static void sync_drop_caches(void)
> > +{
> > +	int fd;
> > +
> > +	fd  = SAFE_OPEN(testfile, O_RDONLY);
> > +	if (fsync(fd) == -1)
> > +		tst_brk(TBROK | TERRNO, "fsync()");
> > +	SAFE_CLOSE(fd);
> > +	drop_caches();
> > +}
> > +
> >  static unsigned long get_bytes_read(void)
> >  {
> >  	unsigned long ret;
> > @@ -233,8 +244,7 @@ static void test_readahead(unsigned int n)
> >  	read_testfile(tc, 0, testfile, testfile_size, &read_bytes, &usec,
> >  		      &cached);
> >  	cached_high = get_cached_size();
> > -	sync();
> > -	drop_caches();
> > +	sync_drop_caches();
> >  	cached_low = get_cached_size();
> >  	cached_max = MAX(cached_max, cached_high - cached_low);
> >  
> > @@ -246,8 +256,7 @@ static void test_readahead(unsigned int n)
> >  	else
> >  		cached = 0;
> >  
> > -	sync();
> > -	drop_caches();
> > +	sync_drop_caches();
> >  	cached_low = get_cached_size();
> >  	tst_res(TINFO, "read_testfile(1)");
> >  	ret = read_testfile(tc, 1, testfile, testfile_size, &read_bytes_ra,
> > -- 
> > 2.35.3
> 
> 
> -- 
> Thank you,
> Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
