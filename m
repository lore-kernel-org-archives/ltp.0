Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9770CC05027
	for <ltp@archiver.kernel.org>; Fri, 20 Jan 2023 11:02:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1920B3CB448
	for <ltp@archiver.kernel.org>; Fri, 20 Jan 2023 12:02:00 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 174DF3C21B7
 for <ltp@lists.linux.it>; Fri, 20 Jan 2023 12:01:48 +0100 (CET)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on2061.outbound.protection.outlook.com [40.107.241.61])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E8E00600F74
 for <ltp@lists.linux.it>; Fri, 20 Jan 2023 12:01:47 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oP0gMnt2EXJqY09jsLId6dLhI5B5dvBN10lOMP0mDZY2grUeysIN2HtlUbmbjKXJPpbn3IjxTQW06MSzuPG954lLZ++uu2URuo1lUZ5PTlcX7P+uqfg/zfIn0HgiTJKJjpcVVzCHrHlF7plB3vQpKTxSkvs2hWwP361g+DGoubFmgXP4nOHVzTMTKQ0S/sLUdXGdJ6LM5r5Mv/SYUNh2ObfAdZJ97JmPqJ3Q+CN06qdO6g2d9ZZbj20RtlHE20WHXisTX4M8dN8fDN07MI7UpSW4svYwsAfTs0xFdb5vZQ5Nf8XfstmdRQVIoJo4/+MlRTIh4D1m+z6CPpTisOB6NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e9xL/RNcAob7NB8jKzddC1u9SRtcwD0BN4OzW/B4xNY=;
 b=ClFGrRFqKt924FzgkAyF/KVrSTnBIiH09tL/K39/q/LbDFUVIFy19caYSWzAEXvaDXk8Oy3ogBD2eMfoK1ye1O7cARirknSlW+Er5W7s7cIky4Cwdxl8NVT7N+hRbtI5dVFR+NbFR6iNMqMLcq1VJPpXFA5lFAmK/LF3C9mmUxYrIBhb7TqEZE1hiGwBquJ+5VMBXvigngAhR5K+/O1+6lFH615JqTmkjyg2NN4ABiEkwmakBp1LZegWmAzvkmsm3xzKKqHeLGCoQaQnCMBbhNGBMAOQSVsbuF/OdAUFHIqQAW4gZ19ZbM4tam6tMr8VBRDXCpNG8zZTQQnW6Q8nNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e9xL/RNcAob7NB8jKzddC1u9SRtcwD0BN4OzW/B4xNY=;
 b=v6jMS32fLk9Y1UGKgKATWmvzv6Y5Km+rp2LAgF1dDzbInWcnXCyZ+XAFUeMoFaEjXfTE08u6FRz3YYSiZMNZ45hawcq4xAPPI85ZIuKhw9w8KSfHKr1+cJXFcGyKimDIH6i3s//vEwlBxPZzVBtP/cHUqVDSBYYA/1ZoZ3yTEbc69THlSkzPCDW3StlDZx/yPprTL0AXr/NP12OQviYY+oO6BtrpiUiG3vFyq8bwYNMuQXbrcgeFTL23Xut2YhhLnTDir4TcoZ7HCe/Lyz2MgooKpvNsAN73SqRpwE3L2sXvu5i4wfuC5BOQOTT0xM8Y8gC+M3wFcGRdqZVBIo/Z2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS4PR04MB9433.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::14)
 by DU0PR04MB9346.eurprd04.prod.outlook.com (2603:10a6:10:356::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Fri, 20 Jan
 2023 11:01:46 +0000
Received: from AS4PR04MB9433.eurprd04.prod.outlook.com
 ([fe80::7f5d:f7d9:47b1:cc2e]) by AS4PR04MB9433.eurprd04.prod.outlook.com
 ([fe80::7f5d:f7d9:47b1:cc2e%4]) with mapi id 15.20.6002.025; Fri, 20 Jan 2023
 11:01:46 +0000
Date: Fri, 20 Jan 2023 06:01:35 -0500
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Y8p0jyFVMXe8Y3w9@aa>
References: <20230117040132.5245-1-wegao@suse.com> <Y8ZdSla1SoyThtBj@pevik>
 <Y8Zg+PIzLUySx2BI@aa> <Y8pTE3I38qTV2Kez@pevik>
Content-Disposition: inline
In-Reply-To: <Y8pTE3I38qTV2Kez@pevik>
X-ClientProxiedBy: TYCP286CA0103.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b4::16) To AS4PR04MB9433.eurprd04.prod.outlook.com
 (2603:10a6:20b:4e9::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9433:EE_|DU0PR04MB9346:EE_
X-MS-Office365-Filtering-Correlation-Id: 10bb50b4-7348-4e49-e422-08dafad5b8d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dt5CiPDLPEg2DQCWxx3BdyPazwTBy/3kWau/5POh6U2pJhokmAT/EEhV5t0kUlCVo4E1MIfbtht4ggKeGPc/WjwlnvO852RkZsOoR+zTwK1ytgx0EQcb52P8MGyCgpK9SRrcBOGZlhSj3E3f4PbqkOa1RR905ojz8V+9LzHBlr/k22r1XTS/4tbAUt9YVq4Kw/KR3DgAKLIZGQrioP+RZk7Bo3PUPKrf30RMMXvbf13Dr1A7Rq7D/d5Kpb4fspx0mMdjQePWsc3VH+2YPTpuOhmfNoH1lwctp5Fyi940kzWv8uCFZ3NWx5NbTKxuzY5uQrBegY6qUHPgcjffzFenJv1eHLFj/qJGHZL2bbn7Ey70JGyTSXujfr/tcTKMkaLjw4rvLsKzvg6/GKEZ7g5YJXTC6vFRZg4/5Wy97lT21gfyDe1ks+xfxZMt68MmZtivaFoskFdAWEKq6aET7nxSNhxI5GpfwNqQDGPUDuduk+3+2bpN8lO6sSoFNtdkfctiyIxGLFoV9Y0g/BOkT3+CLa61WOb+YGHWY0+gADjPZDvLtvBYVLLLvBiX98gZGjK6Ptfb49H/KxmI5g0im+Jsvx6J2Q/dfky1jW52UpYq4zuPV++yRnzRicrFfZ0Z1Ktjc07Cu1yyJaBeNUk/Bff4cNdFH9RUM+cJrkKKLM3UeGsE8R7hHdIRHgT2edPGFldJaK82eB9Ic3pPN+lw3enPHi64dx/f3i7fek0iTxiSP5A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR04MB9433.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(7916004)(136003)(39860400002)(396003)(346002)(366004)(376002)(451199015)(33716001)(8936002)(9686003)(66946007)(41300700001)(66476007)(66556008)(8676002)(186003)(6512007)(6916009)(86362001)(26005)(4326008)(5660300002)(83380400001)(316002)(6506007)(6486002)(6666004)(2906002)(38100700002)(966005)(478600001)(21314003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jBYpZ7HvrgnlOW0vHK025SAMxmf/6ddy4oI5g40XxatteQEItMxLmJwMC2wf?=
 =?us-ascii?Q?x/v3WqEPiyd1CEMpY3UTcxnbJjbkT8Ta3npSeigjNKpzSU5nlvVVpcxOSarF?=
 =?us-ascii?Q?yufOs48hRjNexXYT9J16sy5gMivozN3gRx+ibZh8fKSxcq3ww3aku3EVBnEh?=
 =?us-ascii?Q?zYv7I074kGLg1I7UEzDmZsoTJPSRhG7oo3N1wy3Q+zP7EjRGyVQj5Clb3uN2?=
 =?us-ascii?Q?2lCNhIzmMMQiKwhs1sk8IIgH03TSz6/Ypt6egQStHnb/Y9qKvfvaO15DjGYj?=
 =?us-ascii?Q?zOGVSJxVgekEYdK8tvqBHzvJ3En1K5ZvbLgM2HW0HcCJJJBWbRlHtoavN5h6?=
 =?us-ascii?Q?vPZuFyoYm1xAVaq8x5PcwzlJJmFdZP2AKz8EMGuoKZMwHidQ/wvJb+aG/7kf?=
 =?us-ascii?Q?1mx7AGu6RkNVWdaQ8Z/f4E8+WbPFYjtCqvHZvnkzsT2bYFEWjb1w7VlK5Ujx?=
 =?us-ascii?Q?cUEmrYz9Xb9PWfbxpqRuK9dmQFOX5d8koaZOfffYA91WYNTV3aey0ede2vsz?=
 =?us-ascii?Q?VM9lmBLdRQ46BIlB3YbhW8bjlLMe9A9soeY8QbgPtqgn41mTK62kLZmzGt9/?=
 =?us-ascii?Q?KcyauMIP5vg3tbHtWVKRwV66MJBd5eFL6ayBY/QQyVD12bIKRf7askJvJW4l?=
 =?us-ascii?Q?n/dHAm9HGMBrktTz2oOVWGyy0R4ZPuyvPk/7yXKtaZ3niaamvPZuAodMv6mH?=
 =?us-ascii?Q?4cZ1uAr54e5Jxi8wOWwlgXVMdc59ElhO15ss/4rR2E1j9exzISp/wrh+7lpz?=
 =?us-ascii?Q?awyHACfyowZfGvW+UIJvBGDLexloDX2cSA9tzmGMIRL0TdoIvoZzI7JFYhTf?=
 =?us-ascii?Q?/SbuyjYAzXixKNnDdgRd0Ys7KOcJa3eyEcLtWHToVWJ386rmpxoeNK515Fey?=
 =?us-ascii?Q?OdF5GPSm/odWYyKLW27gAL4v3nnvuHAHTauISKAxKvRLUszr+79vmqhe3WF6?=
 =?us-ascii?Q?pA2YrHIXEBvILIC4tGg9qwOZVrv9mWGzjALBmg8QPW20r5BueXMLYBj2JGa3?=
 =?us-ascii?Q?FXZNS5aOs14VKrEwYp1djI0PPy81fNziu0p5W/bFKrHnE8902BjKjotrQ1Bw?=
 =?us-ascii?Q?GFIgdVMPqcLXH5PpAnVFnMTamOwlBnjrlz164oOttlxr0KpPq50w7dstKjGP?=
 =?us-ascii?Q?lZKpVZFV7Fdr1qimKjDp/UeYhOKMstGOQlDcYoGVPC/65BHQ9CnT7/HHrKKj?=
 =?us-ascii?Q?pIBsfa2NHPtv4g8N7Nn8Bc7+nOK+PSdPVVq7MeMkdCr6UPX5VuOt2NONtfpg?=
 =?us-ascii?Q?C8fP1TsU7BhBkp7KcciUdtp0Ps1Igi3toO3QnZj0j3hmvHxJoltT5iSxomwT?=
 =?us-ascii?Q?Ka8QASe6IIDnI5qq5F7YRILf0HL4sLwVkdpSFit/oMgJnKoETvE1i35m7JCN?=
 =?us-ascii?Q?0ZiAibJmuTplFJNMjMtglf57YHlfNmL+CKM/oOlwxZ+xoGkbt1y5AXCnsQRz?=
 =?us-ascii?Q?hVIOZfkvmZ+qV18uYMG2jVln+S5l6CPS5Rn/4qy7d42xjbxPUIS/RO+rBAD7?=
 =?us-ascii?Q?gVWIIyXEIVtKtj6nmrP13QQGDHl7wWNmIDJTc9eWgJBZSLCnKnrFM8lxzRu5?=
 =?us-ascii?Q?SEl2Smyv81KUOup4vKY=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10bb50b4-7348-4e49-e422-08dafad5b8d3
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9433.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 11:01:46.4874 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3gApPEcuzYcG3kG6QdbfAUfvmHGLkwIOUf8XgjBCoA6idb5osHmNl0NYaRX9b0tg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9346
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] tst_net.sh: Add more tst_require_cmds check
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

On Fri, Jan 20, 2023 at 09:38:43AM +0100, Petr Vorel wrote:
> > On Tue, Jan 17, 2023 at 09:33:14AM +0100, Petr Vorel wrote:
> > > Hi Wei,
> 
> > > > More strict check for ns_xxx etc will help avoid following issue:
> > > > https://github.com/linux-test-project/ltp/issues/991
> 
> > > > Signed-off-by: Wei Gao <wegao@suse.com>
> > > > Suggested-by: Petr Vorel <pvorel@suse.cz>
> > > > ---
> > > >  testcases/lib/tst_net.sh | 2 ++
> > > >  1 file changed, 2 insertions(+)
> 
> > > > diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
> > > > index ceb45c98d..ec915ad74 100644
> > > > --- a/testcases/lib/tst_net.sh
> > > > +++ b/testcases/lib/tst_net.sh
> > > > @@ -205,6 +205,7 @@ tst_rhost_run()
> > > >  	sh_cmd="$pre_cmd $cmd $post_cmd"
> 
> > > >  	if [ -n "${TST_USE_NETNS:-}" ]; then
> > > > +		tst_require_cmds ip ns_create ns_exec ns_ifmove
> > > Why this? none of these commands is used here.
> > This line is the key to avoid wrong configuration(such as add ip inteface etc..) continue even ns_xxx not exist,
> > you can check following code, line 222 will execute ns_xxx with error but not exit test immediately, so if we add 
> > require_cmds here then we can avoid it. (line 222 $rcmd will contain command ns_xxx)
> 
> >  218                 tst_res_ TINFO "tst_rhost_run: cmd: $cmd"
> >  219                 tst_res_ TINFO "$use: $rcmd \"$sh_cmd\" $out 2>&1"
> >  220         fi
> >  221
> >  222         output=$($rcmd "$sh_cmd" $out 2>&1 || echo 'RTERR')
> >  223
> >  224         echo "$output" | grep -q 'RTERR$' && ret=1
> >  225         if [ $ret -eq 1 ]; then
> 
> Long time ago the first run code for netns was init_ltp_netspace.
> I added IPv6 check quite recently. (I originally submitted it as run after, but
> in the end it is run before it.)
> I need to have a deeper look how tst_net_detect_ipv6 rhost works, calling
> tst_rhost_run before init_ltp_netspace should not work (interfaces aren't
> configured yet).
> 
> But even if "ip ns_create ns_exec ns_ifmove" are needed to be checked to fix
> tst_rhost_run (not yet convinced), why to check them each time tst_rhost_run is
> called? It should be checked before first tst_rhost_run call to avoid useless
> repeating.

tst_rhost_run already be called everywhere so if you need check before call tst_rhost_run, means lot of place/cases maybe need review and update. 

Furthermore, check each time in tst_rhost_run can make this function more robust, the 
old code also do tst_require_cmds if go ssh logic in line 211 for example.

 205         sh_cmd="$pre_cmd $cmd $post_cmd"
 206
 207         if [ -n "${TST_USE_NETNS:-}" ]; then
 208                 use="NETNS"
 209                 rcmd="$LTP_NETNS sh -c"
 210         else
 211                 tst_require_cmds ssh
 212                 use="SSH"
 213                 rcmd="ssh -nq $user@$RHOST"
 214         fi



> 
> Kind regards,
> Petr
> 
> > > >  		use="NETNS"
> > > >  		rcmd="$LTP_NETNS sh -c"
> > > >  	else
> > > > @@ -1006,6 +1007,7 @@ IPV6_RHOST="${IPV6_RHOST:-fd00:1:1:1::1/64}"
> > > >  # tst_net_iface_prefix -h
> > > >  # tst_net_vars -h
> > > >  if [ -z "$_tst_net_parse_variables" ]; then
> > > > +	tst_require_cmds tst_net_ip_prefix
> > > This is correct.
> 
> > > Kind regards,
> > > Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
