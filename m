Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A761BCDB474
	for <ltp@archiver.kernel.org>; Mon, 16 Oct 2023 23:53:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4AA453CFE6D
	for <ltp@archiver.kernel.org>; Tue, 17 Oct 2023 01:53:02 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 033883C8B16
 for <ltp@lists.linux.it>; Tue, 17 Oct 2023 01:52:50 +0200 (CEST)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04on061c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0c::61c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 78192600BBD
 for <ltp@lists.linux.it>; Tue, 17 Oct 2023 01:52:49 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dzp25jSeh3bZOj8ogElmj/ts5XZTRJnWbojxRXp3e+oBi038PuYScmGAxCfyidTPtMxY4ZQ2vRGXe3L4I94px1WOlYryqOAC1DPdLclTP8WztWFsdLBuBGc91TmOuIXPM5d1xgMFtiTVJQitkhM83dz1hG8R0SBQ0XrbqfPGevaWpH600yHEoA/e4RgUTxYEP0j9WC6HvTJkwobhQ2dYDiQHQ72GWMK9dJ6u2Ek7g/Rhc1Ktw33pfQGpcbMIdiAyZaLUzqtjzpe2PE2Bey1HDVzSWisMtwb7e3qX4VDZAotuwtSr208kkhnZfdF88yQuee2ebNGfBywL9NR4kwq7iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BOtke+z8NUDNHj6jMGaUuVJRA3alU90IqNiKgkYhUPU=;
 b=BiEzI15EimZom6P9Rtv+I86UV0qPV6twKejxHTv2/aVZkstUyjhClltGXE27hlEdx/QaIYXZwzQzGOhwmGqcxhR826rL8WtX6jKJzcaSP/6D4JzWtgoT053LYKxLmk1z7ARbJYAS65Vjd6Dyee9NMo+tzw0FvuZm1NrpXgwTqCMDDj32wgRQc1Lgj3HrfpOWp1tw3EYWa1RekiSLs8VM2qWsLdedkh1IIvK28K7OSn9Oi6G5ekwIZepUDuhKluqPocTtADvZVoElUZoafRBq6w+QzDQlRCol+Lhzj9jtdsNcA2CLU3TXvFeJN/CvAFHopPvVNaJXeFY0BfeScLMXyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BOtke+z8NUDNHj6jMGaUuVJRA3alU90IqNiKgkYhUPU=;
 b=cOU1A+lR/hnckqb/d1EJk5FBWC7lJ44Jrq9DxUBqAPSv1BZ3o/NfSwwBYoWznt1EmtNFBVwDlRZ+WESeV0r2LqGNLQ4LaspSj9CByB3B/tlSj2SyPdqor1alowo8y4Zaadp7SNG2rplh8cD+QOiDt4ISdYfw8LBPtfmVranajULcOtHq13VkAQRuq6vgzhtnFT803ByqG2XexI2S2MO6PkHLPRmWWOJvgRevH7GNaZVMZMPynTPRCRyM040LSrEL/zpLhJAgLzOBP49BlYYhl2oAVt6GExM7izlX0ZT+XlCQAnUy9vvJMf6LquPubbPAFPtINpD7873akFFu5a51dw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com (2603:10a6:20b:3f6::21)
 by DBAPR04MB7319.eurprd04.prod.outlook.com (2603:10a6:10:1ac::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34; Mon, 16 Oct
 2023 23:52:47 +0000
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::fad0:efdb:766:75a]) by AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::fad0:efdb:766:75a%4]) with mapi id 15.20.6886.034; Mon, 16 Oct 2023
 23:52:46 +0000
Date: Mon, 16 Oct 2023 19:52:37 -0400
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <ZS3Mxa4yz94vu05V@wegao>
References: <20231012111333.32004-1-wegao@suse.com>
 <20231012112548.6887-1-wegao@suse.com> <ZSf9IdW9ciTDjkFm@yuki>
 <ZSoMsDNyf4Y+w8d3@wegao> <ZS1bjvd84DVj9hUX@yuki>
Content-Disposition: inline
In-Reply-To: <ZS1bjvd84DVj9hUX@yuki>
X-ClientProxiedBy: CY8PR10CA0026.namprd10.prod.outlook.com
 (2603:10b6:930:4b::29) To AS8PR04MB8199.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8199:EE_|DBAPR04MB7319:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c7c28ef-fd58-4e7d-30db-08dbcea2ff13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f0th37J0o/9yXvaQyfdMUOmYjerXhpUK6dztu0SuVGT/IEa1LXFscy/BjdF57cAZfI0ucCZVP9DCPZTnd9bU5wyNFMmMDaZnT2J7TdT4ZwxIF2Hq1pxegoNjqrwytfuWVg2n4sabeQkuPqSllJcRhqFNktm4ZCwfAvMD15v9QIMtf+uHorEahArm/MRx+QSpZhexeb3yc/yWeHoSn3g4xprjw0afgqNGAVCw5rGVbqEK7m1l7N2hzJrkhMG98tK3l4bRrpXJ5ojV/ZLhZ2olKE42cWHMnKURx9rxa8+IYqmUYq6dYKKCZf8srFT66hXwcmOlrJpAevAgWCUtvz/wjuIJtv16KTMMpcEKvp5GH1if2ydLoMzZ3ZuHLf+x3EIn7kL49eecG9FzbN8+jV2CdINArlw+4qCoFU+Y2eWh/ezgFpygW7QGldfz13rfFwfDapYoaC6W04+55MLoKx0/t02QBLXQzYBcRjqlTgFtThkiuNpLTJjRpa2cpBG51XLyu9Vc1yvydom3mQ23zziH9CK9r1KI1OPOD4LAViPYadb3NXonuWN2FNvpLPMvAoY6
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8199.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(7916004)(346002)(366004)(396003)(376002)(39860400002)(136003)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(26005)(41300700001)(66946007)(66476007)(66556008)(38100700002)(86362001)(316002)(6512007)(6916009)(33716001)(6506007)(6666004)(9686003)(6486002)(478600001)(8676002)(4326008)(8936002)(5660300002)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oifgn6pFQBff6HcRahSz9ZFNIaZn8OEcBJ77S9q3iT8mMTD/exUaM2bd7AII?=
 =?us-ascii?Q?wQkDAQrzm5epqNRfngoO443gInNF02g5J+SN+rlQu0VPK5pMt7ri62d634EI?=
 =?us-ascii?Q?36zmcmrTK06HGFc41romOUvWz8aT/VsII15GbR6GlsrlXUYPi+83FylS+b/s?=
 =?us-ascii?Q?azqauhXvQ98W9vr1wvEv4oWAmjZxxmShDkLmEc+WJjX+Z7q8k4FvpYRPh1ub?=
 =?us-ascii?Q?LuSNzxXH89GjAd4YBhYFw5NY5TQtbARfGjSZAdq5cN8qO6WiKxOdBfLrqN2B?=
 =?us-ascii?Q?tIDTJZgVJ+LpkJwsSBLehQGOTZlAwuQz5uwV8tGzFTUfi5aGrVO70M69Ebdq?=
 =?us-ascii?Q?pacs956I2JmTyLniAXBbeLUQcVznQrnEmDTTgDYnYQd1vFC9S2/CHnFvUAi5?=
 =?us-ascii?Q?fxoFqrocaSHTLr42rKx21LUBuJBYWO/bePrxIzSE7/DZMSS7abhgx/akbyuv?=
 =?us-ascii?Q?ZeeB9TkXPqjF3PBk3Df9D70mL9vmZ/aI6hLTwGwpI6xds8nsoiF+SNB7i+dh?=
 =?us-ascii?Q?DFbx1uNRghuyQXK3GpyjQ7XGsuZKKWuXeCW91hl2RMEkECLl75wx5onwyHPk?=
 =?us-ascii?Q?1s5vKKzQ/U62iPSihv8a9R0p7zqFdR2FrqG2oVrVcglnu2KfqmClk9obp3oO?=
 =?us-ascii?Q?mEdM87er5rbcppY0M1uDKgxsq038ox5OcEqewWTeg/yl7BY1HTC/Gwpa7Ca2?=
 =?us-ascii?Q?CoQ1/l2GvI+hENMATNvE1Hc/VBSatDsfnG9EQLIfBXETUqotq2IgRbQPaQOb?=
 =?us-ascii?Q?ARxSShW+K9i1d9kJbXLvTRL98nmcCz3mMDohW8bErtkTfajGEDq134soYhNt?=
 =?us-ascii?Q?47vYiZ0kc1A577Afhhyei9TGt7tlqyz8h0vabBwvgLVtPrrt5NSiramhCpL4?=
 =?us-ascii?Q?GDe06t6qFk7Q0jlGBUrHsidfXflb0U37MhiIJIXy67qRLuFMWfoavqIGthG4?=
 =?us-ascii?Q?k0bRJxpjNY2aR+JzFAFet1otwogNA92TjBrcZmyHxSNljgyYY4zqGIFHzfwM?=
 =?us-ascii?Q?FoxQnQ2V9t7YxKO8U99rXrRhHjoJjyBuOOwLHcTZFHmq5f8yj6s73mtT3oau?=
 =?us-ascii?Q?B0073aDr3ArFY2Y5dd2mCopQ5YJrhwHQNqAdVQ4T78wzfzVZnxSqblhwoqZt?=
 =?us-ascii?Q?SEIG5jbGsz52OQ0kIx5VdwJjPzoUBtX5X5lRibHbNsnY+HZu5dDTCLTa2sgw?=
 =?us-ascii?Q?NuQydTg8O688IUC/C9VcAzPigw2rAsrxVut3S4f70xgl2O9Qvcn3h1gXO0sL?=
 =?us-ascii?Q?npVBIHE/0ATloXIVkXU2MvwFdkwMzrq477B1T2qHXiBHay2yVH+rcRFYOElT?=
 =?us-ascii?Q?xLvsdSd1IkEl5Dse6AWL2v8C5swMp6Tagys5ydiPkjjCJZlm52OghCaQ5tg0?=
 =?us-ascii?Q?aLnTPUI73YUj+xcNmso7IVULpvOqoD9s4Lw7ygwgq4TNh8XVg3GnJuAlEM3I?=
 =?us-ascii?Q?tf2liPZnV/PXVwgTjGxf4lwpALKN8FwmAo/2+mEzWKD5ehq1RD4X5kGlpPpd?=
 =?us-ascii?Q?W9XcRcc/SuMIs6H4YrcPDuC54tgF7iE2PegE/aAYSZC5WZUELJsLFGNyxANg?=
 =?us-ascii?Q?E1PdJX//QN2BPDnw85Q=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c7c28ef-fd58-4e7d-30db-08dbcea2ff13
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8199.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 23:52:46.4018 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LsB7/asgS+5ZU7lf5h3tLgVjFRtffb30esvyfoWWFz0DO6CyZFjU6KEUV5HBEbLz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7319
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Add test for UI_GET_NAME ioctl
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

On Mon, Oct 16, 2023 at 05:49:34PM +0200, Cyril Hrubis wrote:
> Hi!
> > > > +static int check_ui_get_sysname_ioctl(int fd)
> > > > +{
> > > > +	char name[256];
> > > > +
> > > > +	SAFE_IOCTL(NULL, fd, UI_GET_SYSNAME(sizeof(name)), name, NULL);
> > > > +
> > > > +	DIR *test_dir;
> > > > +
> > > > +	struct dirent *ent;
> > > > +
> > > > +	test_dir = SAFE_OPENDIR(NULL, "/sys/devices/virtual/input/");
> > > > +
> > > > +	while ((ent = SAFE_READDIR(NULL, test_dir))) {
> > > > +		if (!strcmp(ent->d_name, name))
> > > > +			return 1;
> > > > +		else
> > > > +			continue;
> > > > +	}
> > > 
> > > Why do we loop over the directory here? Can't we just directly check
> > > that the path /sys/devices/virtual/input/$name/ exists?
> > > 
> > > I guess that we can as well read the
> > > /sys/devices/virtual/input/$name/dev and match that against fstat() on
> > > the fd.
> > Seems no dev node can be found under /sys/devices/virtual/input/$name/.
> > 
> > ll /sys/devices/virtual/input/input13/
> > total 0
> > drwxr-xr-x 2 root root    0 Oct 13 21:32 capabilities
> > drwxr-xr-x 3 root root    0 Oct 13 21:32 event8
> > drwxr-xr-x 2 root root    0 Oct 13 21:32 id
> > -rw-r--r-- 1 root root 4.0K Oct 13 21:33 inhibited
> > -r--r--r-- 1 root root 4.0K Oct 13 21:33 modalias
> > drwxr-xr-x 3 root root    0 Oct 13 21:32 mouse3
> > -r--r--r-- 1 root root 4.0K Oct 13 21:32 name
> > -r--r--r-- 1 root root 4.0K Oct 13 21:32 phys
> > drwxr-xr-x 2 root root    0 Oct 13 21:33 power
> > -r--r--r-- 1 root root 4.0K Oct 13 21:32 properties
> > lrwxrwxrwx 1 root root    0 Oct 13 21:32 subsystem -> ../../../../class/input
> > -rw-r--r-- 1 root root 4.0K Oct 13 21:32 uevent
> > -r--r--r-- 1 root root 4.0K Oct 13 21:33 uniq
> 
> Ah, right, it's under the event8 directory in this case. I guess that we
> can match name againts the VIRTUAL_DEVICE string instead.
Yes, in v3 patch i start match name againts the VIRTUAL_DEVICE.
Thanks for the suggestion.
> 
> -- 
> Cyril Hrubis
> chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
