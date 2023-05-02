Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CB3DC77B7E
	for <ltp@archiver.kernel.org>; Tue,  2 May 2023 11:53:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0203A3CD919
	for <ltp@archiver.kernel.org>; Tue,  2 May 2023 13:53:21 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 394733CB8B8
 for <ltp@lists.linux.it>; Tue,  2 May 2023 13:53:11 +0200 (CEST)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04on0607.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0e::607])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 8ACE8600127
 for <ltp@lists.linux.it>; Tue,  2 May 2023 13:53:10 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MojAyz5TZnZ6kqIOzw1JDcPy81XddcWCyU1DM5MyL8um8nQBPnxdUHkpu5ICSM47S0/HObzbxVlsOtLWIGuWZBFw3XNUP7XojDtY8YNxdh7+/ogaFV/agk6QbteIcXo18jdjDPEu3MBSGrJm1ad072HC/5q+leekGaHtvHdgySvMVd6b+aQjOiqES+oIdfoQiVsQ45LhjasK7MrVdDW49F5z7R/H3wPM03iOqXcHVN0edgijzzkqtByyN2iMA8ql/y0ywQpRnuH+H3wiN3xdQCG39Biv2uFtDIwyqZ5sySqlSzlcT0AiPdzyRjF9pszl4dNTJeAOR45ykQgSj84s5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EQZu6xhksYP5D1zu8iWOh9Wj9Y2V4+P+U6EgHbkUZnc=;
 b=cdNByCF54EMWm3uT0q+hyDS7FksrGv4q0PBftmmGGUwcjOavCNBv3TVj9C9lA2PUq2MzT8woZctG4TRHG85bAVKH3GUTGp+SraAoi1pjA2QBSsK1hNYuhvdoUVYdgL79edfKfqhZTuYaSSVcEUlFSVh4DI5TKkn4V9HSRkhd7wxw43OzDaEFky5oYL3DYvnLWUEHGygC6HuAYxTlNBsDbfJTrLrRK9Fsuq5yrL/FYqLOHYDlNVzluaZT4qRxLowuD0KKZJYWeCGaNxckYx/rY4YLTTxZVTTyPuC6M7HnPlKbHY3qfTFyCtLyZvtfLcbBCsrgjjxuIaDGKP4r+kymKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EQZu6xhksYP5D1zu8iWOh9Wj9Y2V4+P+U6EgHbkUZnc=;
 b=hL5mOdXkXUe9uW/ilBa9cnsfILsl3cpE+MD3ord9c8KIofuBXclLyMgVsY9TyhjShUjhL2rxz8/8L8An+56zQeJmLGN5RmKPb1CqkV7MbNctY58K52nEcLj1votimeUK/8HxbqtfxY9mtwjigZogHVdVG8saK9lpIL8DM1DZj+uSDOeiGyblG0QS6Pi2/Hi5UfJpsmCKnb/nm7DBaae+44cNvKHDStxjT509pCEIluD7I4y+C/Fjg5B6V1TSFo+9T+LKZSnGZMUH/PcqEwdCclJ3gV5fpkf1I7cEMSPQ3G6iq0uTuwo+cRC0IEJMloKdR/zaVqt/fTR2W3SZHFHWSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from PAXPR04MB9060.eurprd04.prod.outlook.com (2603:10a6:102:223::9)
 by DU2PR04MB8725.eurprd04.prod.outlook.com (2603:10a6:10:2dc::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Tue, 2 May
 2023 11:53:09 +0000
Received: from PAXPR04MB9060.eurprd04.prod.outlook.com
 ([fe80::a656:3be6:2b0d:cf80]) by PAXPR04MB9060.eurprd04.prod.outlook.com
 ([fe80::a656:3be6:2b0d:cf80%7]) with mapi id 15.20.6340.031; Tue, 2 May 2023
 11:53:09 +0000
Date: Tue, 2 May 2023 07:53:03 -0400
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZFD5n4x6fdNkMuyj@localhost>
References: <20230424103056.6017-1-wegao@suse.com>
 <20230430060419.12045-1-wegao@suse.com>
 <20230502103248.GB3631203@pevik>
Content-Disposition: inline
In-Reply-To: <20230502103248.GB3631203@pevik>
X-ClientProxiedBy: FR2P281CA0011.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::21) To PAXPR04MB9060.eurprd04.prod.outlook.com
 (2603:10a6:102:223::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9060:EE_|DU2PR04MB8725:EE_
X-MS-Office365-Filtering-Correlation-Id: a5c1b4ce-6e9a-426b-2b1d-08db4b03cc3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7guS7DHIQjlwrGS3cZanKVw3txnMwjrE9Ubszm9MV2Wjxnv/+97JhL9ZbCETf9a0m2Wn9LzwOQ4rFLh/vAODKC0nXn7g9YU4Iqo6vXthZWoPvX7zHzShoFVsB7KOxZ0VV0ijgnjqLi7OD3SOXqKGplqOZBTiuxS1ybsp5zzul1ZwtfzmcnFwhfuQ2NoRKSgBWq5KuKulLyAXSPH1IENRN7JwQ4I4SvTglzTeEyo6/xP8zRt2l0Uj3c59DTHXG3YOxpMV4qrF94o6D9gwMUeeB2eVQaUqgheReVE4viYD7hxWvu56PH04TiROdvPJkzVym3lslcxKM7ZduE4I5OxMiCou0C1F8UABQaGsBVCOJbJ6PyQUV+tyGjCHCfdmsZhvOWburHjZZlw+Y9hrw3htMZCbRduSi+M+kh/F2t6GSs/mMY2a1UQ3vE9t1WDWuqrxLURPEnFroSYLlZAJODa8xlMlsY4WRbJ/v7omTx+ALKV5vbFVoK4choP/mha50rpW4wcJHIzrxuHKm/KvWIGRVzQDlquHxS6sy4B6QcvuiKxj2fTk0y/GGyZqaQIXKMRU
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9060.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(7916004)(346002)(376002)(39850400004)(396003)(136003)(366004)(451199021)(86362001)(5660300002)(38100700002)(8936002)(8676002)(41300700001)(316002)(66476007)(66556008)(66946007)(6916009)(4326008)(4744005)(2906002)(6666004)(6486002)(186003)(9686003)(33716001)(6512007)(6506007)(26005)(83380400001)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?s8q4y4yhtTdByPyhvrxoFJ38pE58u0Cvweu084FJ3LKEwf3II6m1Wx4PXkrs?=
 =?us-ascii?Q?Lz6mVfXNB5v8Nm8Pzfy33RkcglrUGCvy469FGP9JtvGC+HsqKBXL6Uk8GO3l?=
 =?us-ascii?Q?9EHJREdyQX0WlE904wf9AkHAZ79In91b96xB64Sjs7FBYI3jCeVd8zNtU9NQ?=
 =?us-ascii?Q?JWJ2BDM2zXg+PQwZKBusvKxwPbCDBiBqgtcQ35kzz3mWSqJ4UT2knZgE6Ia0?=
 =?us-ascii?Q?I0fx5iB5+jJlpKXZnyz6ti7XFCenMisCl+yUDEVVfxEcEy1h+d6EZvd9Lqf1?=
 =?us-ascii?Q?RU0uHqKxP/c4qUcVz46On/JwaJMv5hQDqDVs9PmdGI0QlMCVPqs4zbBZLNMF?=
 =?us-ascii?Q?dEb09St3dSz2HlCE8pzfDeXiFSOJKhhGn6NO2n4ihuyu6DEU49KDP8mUDApY?=
 =?us-ascii?Q?UD6UQt9hg/kO8PH9PEYzQ9C2EyAnXDz97B/X+zVgYkPGHMPdTas9J0K8k+m/?=
 =?us-ascii?Q?IJ5ZMY7wHwz9HJh7Jd+HHS2tYDyGK7eKs2cJH2yc/RIetEwCxQnFH5xaRU+C?=
 =?us-ascii?Q?uxlq/eXcJnKkWBBmt7fdZ1hRMnDJsOCE8QXe9uBUt2YSVtVcMs6gNyhWG5n7?=
 =?us-ascii?Q?fGaCu8innwmt/JjEDZmaEmywGK/uSbqVaKKXLFaobjXohZk+4R+EtxVkcMRb?=
 =?us-ascii?Q?JTbSawe70hrR8ACQoPY9ec3n28YlxxBthHf+UnRHLJ4sMlp75xtY0zu9IgwU?=
 =?us-ascii?Q?C56BQiNzc11y7R8AlhlvxxeXz3ftRBL8XpWStYsDAMZmAtdfkpHQbr2sQN4p?=
 =?us-ascii?Q?RjyyyQxXjA9VsqmvN+arSKD369JJHFpEFwMD6gV/a2P02WV/x3EWqE+hLLIO?=
 =?us-ascii?Q?Cw0BbxdRjQtsx3SF3OQXbyUkrrDvUK9Vzrf7eVJADZvaiU0wZ9ogKImi8600?=
 =?us-ascii?Q?O7zZhk52qwyeJJ+5UoHyp62e5XwIC5HVvRX7/R0yN8nDVBK4ZY2O2KLedPpR?=
 =?us-ascii?Q?918qW+m2x8v6UnaJcxKYNNT0YsMnQYDK+oWBZReCt4N0ONNTzqJy1VHXTSCf?=
 =?us-ascii?Q?KDLiYw5zjdMu6k5qBW0fmkfq3L2xyXwmJJStwDpGCxs8iLy/zuA47kx2MatG?=
 =?us-ascii?Q?OvIur5kI4pc3nfkC5XgDwd63zaF5TDAT3L9HqgBO5vUtedcSXgZpQmqa3/nQ?=
 =?us-ascii?Q?SngfRJzaFa88fABStWdsWHWQgcLQkwIiETtNmKfXj/pMReOmsGle5pB/ZF7o?=
 =?us-ascii?Q?VaJs0QUYsUDIk7flMbYjghtwVq50G4SnwcHVTJXM6dmTKWhb5iz9h/3nSq6t?=
 =?us-ascii?Q?PUgaYbWudbMpyR9CZupfaonMIBdtq9g7OhmEnSaLWyBZGZL1GGy6qmgxd2Ei?=
 =?us-ascii?Q?Ulb3W37O47aaJpl1Zxu45AHplUKtHM3yjM9wBJ9ZD1rfOk+3nZEeDpQr/5L7?=
 =?us-ascii?Q?QEMzytBOssZJx0UzWXhRNx6ZBdWc4iWxKnAkjYFq+k+eNDH3LhlKa4VuEOtf?=
 =?us-ascii?Q?VFVn572FYxmksib8Hol5OT+3p7pOPzojipJxaD847uAM5y86mSxrs+W6MD07?=
 =?us-ascii?Q?g5FOM3nmhpRLx2cH1UVYVcmV+KWFOmyfHPozyscn5HBWsXsy081TfBOdiUeK?=
 =?us-ascii?Q?bvnMwpyJYsurVsEIjmg=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5c1b4ce-6e9a-426b-2b1d-08db4b03cc3a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9060.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2023 11:53:08.8637 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iYEz03NbAcW+XMB3WVfLHYKznYvJJUmnkNxv0AHjaTKIf0pHFucNAUAdZfo3L3GZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8725
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] recvmsg01: Refactor using new LTP API
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

On Tue, May 02, 2023 at 12:32:48PM +0200, Petr Vorel wrote:
> Hi Wei,
> 
> Signed-off-by: Wei Gao <wegao@suse.com>
> you started to omit your Signed-off-by: tag.
> I'll add it for you, but please try to remember it next time.
Sorry for my careless. Will double check next time, thanks a lot!

> 
> Kind regards,
> Petr
> 
> > ---
> >  testcases/kernel/syscalls/recvmsg/recvmsg01.c | 717 +++++++++---------
> >  1 file changed, 345 insertions(+), 372 deletions(-)
> 
> > diff --git a/testcases/kernel/syscalls/recvmsg/recvmsg01.c b/testcases/kernel/syscalls/recvmsg/recvmsg01.c
> ...

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
