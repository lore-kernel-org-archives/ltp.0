Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42CE7C77B60
	for <ltp@archiver.kernel.org>; Sun, 30 Apr 2023 23:40:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 92D5E3CD957
	for <ltp@archiver.kernel.org>; Mon,  1 May 2023 01:40:15 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1262D3CB1C6
 for <ltp@lists.linux.it>; Mon,  1 May 2023 01:40:03 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20629.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1b::629])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C6B5D600728
 for <ltp@lists.linux.it>; Mon,  1 May 2023 01:40:02 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HiwS64yR09bkGJSMY8y+4SNpjRLQTPR8dU4tx3iR1XJ2p1QfCwqwAd0Jh9xhS7OUWX/vABip8C5yb2dPS1jcMdX7za0thA8kwSqe9/kOk1WukSYI1/TGjQyD5mUbj6FsnvoIpWHkeN7YAbkyfAvqSjqM8+1bPo/upSE/8+Yd48qxV9f+SN+JQznjlAYc3yRFhFDRtnd3h5m6qcv6ollN5w3Wva8HPx6ERpiApUiDpb8AD3jCHS47+x0XBUxWYflJL8QH3cNBRkYXRpNIhUUt1EWvwGZoVbpBNCJs/XLIv9l4KSIloEBYQ3vVr9ii3HCAkIpt9riiSu4YdGVEpDRhrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1nVjux1Lg9IP0WX9kNu7l4thlBMCwWLYK7eO9qYHXMM=;
 b=LwlNO28PQh1ua6WsQEgC8ELmoGZDSlipAxZVdyNb3HYdYyKKIrYx84WdCI959+x90SYIlUbpM3Ixq1oB7835xd+zXxdzj8XAqhUJoGuadaeK7L3sc8fu47Ysy+IzijBhYV4S8rLd32Z34S4l2yaUfWP4iPDHI1FiED3Jcqrfw15RZzA97fEfuwzq+ruds6n8O59KmBGi24XQ+Do++dF0VSNtr9AUfQ9tJ/1fg1bvE7+bU02/AWO6AUAO2APcWh2Rv3rR8+YfQq8DAsp+mCOwRZ7I2mgZGVClRT7AymqpQxS02lj0sO6ZIKUl8RcmJUaWAmquimaF81e4D1YBumC7eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1nVjux1Lg9IP0WX9kNu7l4thlBMCwWLYK7eO9qYHXMM=;
 b=P/NUr+wNPCS2cUgZpcv/4YeTfsljiZqXfmv4AnBXVkNHTRiP1GmEcsFJGNVFIEnGgVS4VOM89mYKwGYYPuAJT+HMDTkf68ewNubO7Dwc0ojJCE4OSXegxTIY/LM5znnoILXDMx5lykuud2dtpDMYsHwaWmTMWbbTR+ZPzZhJBhXYQBF4txkaCY6qzRavA9eUoU6woP1/i6hP7T3Mn673TEA+FW1JwZoCsX5GF24ZHomq5q83XKEYXqhAG5d8j5tLz8gyJJySFxOMQhVwv24xj6CHVB17pEWXemMI9Osqh43yQ8VzUQgIsqazV7MWKd8aidW3h16DtPneO3S0XuaYrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from PAXPR04MB9060.eurprd04.prod.outlook.com (2603:10a6:102:223::9)
 by PAXPR04MB9643.eurprd04.prod.outlook.com (2603:10a6:102:241::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.28; Sun, 30 Apr
 2023 23:40:00 +0000
Received: from PAXPR04MB9060.eurprd04.prod.outlook.com
 ([fe80::a656:3be6:2b0d:cf80]) by PAXPR04MB9060.eurprd04.prod.outlook.com
 ([fe80::a656:3be6:2b0d:cf80%7]) with mapi id 15.20.6340.030; Sun, 30 Apr 2023
 23:40:00 +0000
Date: Sun, 30 Apr 2023 19:39:53 -0400
To: Li Wang <liwang@redhat.com>
Message-ID: <ZE78SYst3WSp2spS@localhost>
References: <20230428101038.7253-1-wegao@suse.com>
 <20230430074811.29555-1-wegao@suse.com>
 <20230430074811.29555-2-wegao@suse.com>
 <CAEemH2cK60iL2cxeJQVfAwcqmhtmdA5=L25M5QEreMmp74-gCA@mail.gmail.com>
Content-Disposition: inline
In-Reply-To: <CAEemH2cK60iL2cxeJQVfAwcqmhtmdA5=L25M5QEreMmp74-gCA@mail.gmail.com>
X-ClientProxiedBy: FR0P281CA0170.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::8) To PAXPR04MB9060.eurprd04.prod.outlook.com
 (2603:10a6:102:223::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9060:EE_|PAXPR04MB9643:EE_
X-MS-Office365-Filtering-Correlation-Id: b5641232-568e-4e24-8c95-08db49d43620
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kh9wtB3bpQkICTg+YGVMZU9vtsowRQUD/v0ETflJthh//azAHimuH1jjdX0ScC4XnNoEbyZRT5DeNugF++h5qOOmAhatVlA0OaVPGKoQ2gUPkZpeDao+bmLfwBj1FOGTK94pec1gEeV+Lsg2uUB9bEsPSOYaiSOppwiaoXAgcF27/GHYrzmh3zJvmuY7qmfGnqfoVc5kB/MmhvHv4d8NPVsocghQ6k2cdEggFcNa/g4D80swlnkxNcRzyKudheIoJVxs/w2Ppc7nRnWPoi/Jn472HNK9xSJAbo4Ep/a4VPnCVyNAqM64LJomuML67TwcRx29Pf7zktFE2WloLMUMomWLMMBCDWrEFberBrBSv5mEbq0Ia7eYFUAFAEm4LqtgDgOhSZwOfGfYAhTV2F35cN4/WSyWm6TVk9ip+zdXkWufJCY/7b0K0eO5qEBgyEh4dOEQCHJdPmlQ+Pyhf05RC9rTFhbdojBMxEbx+js8WgcdxnU7PmVb0AdP0O9KsGopnDcqZ6T1E7xO/112Rei+XIcA3LDED78uH3iz6QiZUUxXxTc6rk3D8/tVunEGO5aO
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9060.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(7916004)(39850400004)(396003)(136003)(346002)(376002)(366004)(451199021)(33716001)(316002)(9686003)(6512007)(6506007)(26005)(186003)(41300700001)(66476007)(478600001)(54906003)(66556008)(66946007)(4326008)(6486002)(6666004)(6916009)(38100700002)(4744005)(2906002)(86362001)(5660300002)(8676002)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XyuaTTusAYFCxBAwvbYHJWRVIiyyggn4UmkxEOhQ4ruPQu0FGbYKw+oRx8bF?=
 =?us-ascii?Q?jTOgj0uUl7bdu0DzzeUKj+R6282EG6OrjwMOZCQXy996ATmNyqf4RhlQ+u+f?=
 =?us-ascii?Q?cCcXMDe35Sif/QExwZQaGPGaymf5t5OAKNf3uh+xv6+ecvGWJhR7Im3QXpV7?=
 =?us-ascii?Q?ZYPCw37l6K1Ldm4tK0di4ZVGmn1UdNU29cQOhswTyLVC+UVgvyqMvYH5oafD?=
 =?us-ascii?Q?b16pReQP6ik8jWlWhvrtHKf5IIFB7trfMUYqiUab7BngvmmfqsDifJiW7K9Q?=
 =?us-ascii?Q?GY0qjXg/u1FwMyhxSpRsIRy5NPUVi1vHGFw+bvX0/3meIY+bxmQMDCeMUZ5U?=
 =?us-ascii?Q?GcKXHdPoOqyc5FjcQj3P87NbOi3IEtHimNWSzEK+9uFJnxZAUFuYGMbe3T5F?=
 =?us-ascii?Q?suVZpn5lZK2XtLN6/tcnoRS0N+bAEid9JxO7SfFtQYhuyZZRxb14eSg6NpGE?=
 =?us-ascii?Q?pgkff2kWyNiTts75TRVEL/eJwFi4646W7fe7+HTmy9eUvXgR7n6DX2uuat5H?=
 =?us-ascii?Q?HxPnYyXgKN3HCmWdu2Hr9dtjQU9HNd+fxn/tsTc5rJ5sM81QjqqqMb8NWcjE?=
 =?us-ascii?Q?QhTpsW/c0qjEsN0ZwVQtG28DhtAd0DgC1D+Y6yHJXwxWFW7IQFG6Wx7uSW7i?=
 =?us-ascii?Q?LGAh2Rtbr5uidM2T/xw28uw8vfv+UjfbyKHNca2MFJhsxbFV8zXMg3nuuMif?=
 =?us-ascii?Q?25rEklbfrdUS7AHwKlzHRBMap9payCXzb90RPCCbsYO+uQYrCSZrRbnAibHZ?=
 =?us-ascii?Q?iphEheXw5ElaxiAZN2om7dv+wuAXcOc5kdOnkxzF/I63IDIvKNWWF09DoWd8?=
 =?us-ascii?Q?YHlnb2dnmFUV5CIQYWRkufc9Jz1SZLAdkdFjNwqaEmNN/jx/aFZQhuVy5JSN?=
 =?us-ascii?Q?IkFKprAgnc0jeYRFaEt6TAJnBhP0sFDHW/6MrGp2+z9uYffneSB+9U9Ht++N?=
 =?us-ascii?Q?xiSkMR1GNqZFg+wut0QMLluIlaeAPmBMftR5JzcPbVDA64tVZsizZrweVFKD?=
 =?us-ascii?Q?oEyt/cscktD1fWrRED/hS9PkKtQovyyNpz/vTXh/HITEEMd/yy5rCKjWrwqn?=
 =?us-ascii?Q?q6Lh9SQzXxW0dtwPkOeQFkelZvPhW6/VFVbhB8rlkc1oaeqOUd2/9+l3pn5g?=
 =?us-ascii?Q?Tvk14wn/uQtG+KZsXdW1+AU+qMOyXCKcBzaPwXlvi7IgWTOBG8ScDncMXAAI?=
 =?us-ascii?Q?8UGu2T/EoalvvtSPR+dv9nJ6iDl5gIKU31qbvC6eczEyIOvwG8TpChw9lScN?=
 =?us-ascii?Q?pMVWrOEjcmMQP+Fhc2T+f+foezHF/hhaiQ0lVzTsby4RCLAno4E4Qffi4VR6?=
 =?us-ascii?Q?YXKcDXgJsJna93Bnr7CpJEl91oTBKrZyhxH8H9UUBbNuSpVWd/LbucraNpJG?=
 =?us-ascii?Q?D0zl+s+7vwUP7ucmlzvEERTv/JhGrikpRi2asbJowgYTUSd7p7Uk2x+iwpXW?=
 =?us-ascii?Q?qy2AXUFHMsQKYLG/SCdIRVNFCawuPEFtz8cn8J4CFssSbg44CbTF789JaZQi?=
 =?us-ascii?Q?nEZG+q/ebZLMpk/y2992NOKEVcCCMjbqWRBRgrhq6eSaX353Tepd1HIA+lfv?=
 =?us-ascii?Q?XNgYAYQw3OYYTan3OyI=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5641232-568e-4e24-8c95-08db49d43620
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9060.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2023 23:39:59.6734 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qu5Pn1jgWPMZMbYKVVz+4fKVA3CWkMt5C/s1ULb7FA5oLz+dlhFy48ck2jYZkFcR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9643
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v12 1/2] tst_cgroup.c: Add a cgroup base controller
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

On Sun, Apr 30, 2023 at 09:44:08PM +0800, Li Wang wrote:
> Hi Wei,
> 
> Seems we have to skip the cgroup.subtree_control cleanup
> process inside tst_cg_cleanup(), otherwise, test complains that
> there is error operation in line#1020 if the unified cgroup-V2
> was mounted by LTP.
> 
> (no need to resend another patch, someone who merge this can help fix.)
Thanks a lot :)
> 
> --- a/lib/tst_cgroup.c
> +++ b/lib/tst_cgroup.c
> @@ -1012,7 +1012,8 @@ void tst_cg_cleanup(void)
>         }
> 
>         for_each_ctrl(ctrl) {
> -               if (!cgroup_ctrl_on_v2(ctrl) ||
> !ctrl->ctrl_root->we_mounted_it)
> +               if (!cgroup_ctrl_on_v2(ctrl) ||
> !ctrl->ctrl_root->we_mounted_it
> +                               || !strcmp(ctrl->ctrl_name, "base"))
>                         continue;
> 
>                 SAFE_FILE_PRINTFAT(ctrl->ctrl_root->mnt_dir.dir_fd,
> 
> With above fix:
> Reviewed-by: Li Wang <liwang@redhat.com>
> 
> 
> -- 
> Regards,
> Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
