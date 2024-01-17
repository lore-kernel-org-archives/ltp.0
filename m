Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FA6BC47DA7
	for <ltp@archiver.kernel.org>; Wed, 17 Jan 2024 08:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1705478873; h=date : to :
 message-id : references : in-reply-to : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=HidRJG8mJpJ9W7lx5Bc5nZ+kbgzqp6OKNtNSj2K/MrA=;
 b=U5JsR4hXoBg/a8PF8W6eNef+WLfr8wPN5kI3deQ6VFlNkQb8/ktL4XmhTtsI11oZSiDBe
 nhsLouIcAnAl8v+92KxPpYf9uqG0g7YK9GiRWKaQXcdjYpkTvH4OKUlXKEsjoRN8Gvzg2VN
 tN4AP7DZ/IDa4uLnnuTsXguULVljUWk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 94EE43CE2F7
	for <ltp@archiver.kernel.org>; Wed, 17 Jan 2024 09:07:53 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AB01D3CC96D
 for <ltp@lists.linux.it>; Wed, 17 Jan 2024 09:07:31 +0100 (CET)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A20EB600FE3
 for <ltp@lists.linux.it>; Wed, 17 Jan 2024 09:07:30 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EX3ET7YgfYTvb4e09Szg4bdu7BbWkeMavjYHcn0SwDqTXEg49Mv10VsLFAZ4LPRZq6Y2IuAFZiUI8B4cudl0btr5z3/qLeLIWCGv+BD78rS+1E2ozrtPaMAIHqW4dJo+TQBtTv7g5SGr4J7JXEu6dTOHqDD0OM9G0UryR7FBKJHqtxV+p+WqKpNA8/VeZkxIb+C+UYYtS/eKZfIwDoeNUMSfq56nyoTakLS349CP6/ljdPHk2/MS0MQYr9BSgryu1n6aisdfcpdsC3gls7mdLv3kcmg/MyJZjWrKC5urPYpgXN8Ongm+mRKrOLPjpa/m6P0gVszTTYaO3Mnozs98Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kL/XSWVdLopcxkttBecBZ/5FtzDzwM1VxFWheWdcizw=;
 b=DMimcCTLf6DHAY+Ayln9JZt8vaDJt8btTfWxjAJ0jaGgpo8CH9sdbsqQ2Ks/Z3DndXvgo4ZLLejmFY3tWP5gpRcTjE4Naqb/xvERV8YAx9B76M3DhTFb4EpatC4S0aXM54Rgm537CUTQLHZAYX5LwxcFiV4Nfwz0pfKWcWHiu+GB/PjJgp2c93IWmJO28KCIB4U+1nRYeqPBBhmJUKUdXpZ2ZERKLzMiYOz2sVopJDU/kZ972XvNCx96TQtTyDFWyNE73Am5oIX+DIUEtsqumoMd+diF3lH+yrq6aMtEnW6fypH7dxDMVZH2ZerPkyzuoYFhRxUZLFRAUa0MSE0Wvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kL/XSWVdLopcxkttBecBZ/5FtzDzwM1VxFWheWdcizw=;
 b=W8baKdppnjXxXWoC1ktlObxoRYcCaPBOAtOUC3ENmX9CapEQKeOqJIZei5L0AM4g1Hc22OFmuv1eb/YfFDrvwlu+c1GxEMFqjfH2pVAbAqKG7Ffus/G7UphBWBDuZ5wsSVVlYZGQVZSoH1R3OHKfp89WgQ/P3Lb58UIHK1drjc/YvbC/8sj5CkiE33Rp3AZ2LtciuAVH28k5U3EE++kLin/aVdCivPRxonp2kpBXlDTEfVbBYkQCPtCKXafrnoHHS02Lv7c4lG/TXmpjAQLRPTwHojxHFM+yCJQmJfinPhHWR6ocEihbb8GVa/lizlG8s5jYiAPsQWXKUnBTxEttCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com (2603:10a6:20b:3f6::21)
 by PA4PR04MB8061.eurprd04.prod.outlook.com (2603:10a6:102:bb::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.28; Wed, 17 Jan
 2024 08:07:27 +0000
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::80ed:f1d1:a471:ee74]) by AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::80ed:f1d1:a471:ee74%4]) with mapi id 15.20.7202.020; Wed, 17 Jan 2024
 08:07:27 +0000
Date: Wed, 17 Jan 2024 03:07:18 -0500
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZaeKtqtQV1ObshCT@wegao>
References: <20240111012650.9731-1-wegao@suse.com>
 <20240116174926.GA2617288@pevik>
Content-Disposition: inline
In-Reply-To: <20240116174926.GA2617288@pevik>
X-ClientProxiedBy: TYCPR01CA0149.jpnprd01.prod.outlook.com
 (2603:1096:400:2b7::9) To AS8PR04MB8199.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8199:EE_|PA4PR04MB8061:EE_
X-MS-Office365-Filtering-Correlation-Id: 654a2a6c-f3e5-455f-f31f-08dc17335869
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /DraLkuNCB70/Yihdn1T357LnIj7jIsy05CBLREiMvdp6AyUTUE98p142gDV8UaJhJCUuWWUAy9JoQ41BPAyh7hQH6fX+8O0AM+KoVg5uO6MmSQRxbUXXGU+ljfIner9FZqyh8lZVv4+sPj8PqIc6/kulfRlFlbjvIwjv+EmYvew3RUyq4AWotcNS6JxliLgDF9k7XD5awedcGGSd4lWZ7P3QZ/Aiqj4vj3w0CrbY0/ET+Xk4meKnI6iFJG3ky4AcvYRddGHz9MoBy5IyMRu3KNFMZV3w+GPnykn5JbJqxPi4DqC7IGsn8IgFwFnb3WI0CBsp1gXO3jxDYV+Ofppr9LY8uk1+fHrVHatWjMTSx7oRavJp5fKmVmL+fQLJ2/dW5Bj/1+tkaxYPQaYOJgLQx95D0YmKG12zxM0sCyCWr7qbEc10xJXItSk4nTn8DOgfaJ+9JYJOMfnD2V/aAEPljKeO6TzlWoGWUl1ihVZyL0cpYPtLdXZLAnmZpEtNfOcWyXB2IXrwZb/f49/BZCjBaWo/GTblwcP/1JehnCTQzE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8199.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(7916004)(39850400004)(396003)(346002)(136003)(366004)(376002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(8676002)(4326008)(8936002)(5660300002)(66946007)(6916009)(66556008)(66476007)(316002)(2906002)(26005)(86362001)(9686003)(6506007)(966005)(6486002)(6512007)(478600001)(6666004)(33716001)(41300700001)(38100700002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4rXpqLrrtZJxmikK8SmN2dM5DhyPpAyiobpjNd8gTodejAf6Ix9ZwtpsX3sC?=
 =?us-ascii?Q?8lc1n2GWTooW0i8pR7H3IvZfzb60kK//2KthpFX/kIGKslrcSLxLjg/2cMkR?=
 =?us-ascii?Q?3VMt38ofdU365/2aa9XoxGDKspYBh1qHz1CHRLG2CZgbApB51p/dJpKvIwXQ?=
 =?us-ascii?Q?iOGL1jtaVdw2TyxuUbZn4YwqDwY6ersV61j+TQ+SQvp/upPzPcVzw4vZ8hZ7?=
 =?us-ascii?Q?NoLwulVyqnX5BaytmT7sCEr+VK3vtSABrWyUqNqR5pXtDsBUynT5du+aQnq5?=
 =?us-ascii?Q?8qeOhpPsngX/fnfqLDsSjeMUyEDjDSIoIuRIgWXxMSzsi6Zo2zX29L6PXtwG?=
 =?us-ascii?Q?HQYah836SCwpZBJyBnSAuJxf1WbbSTA2JVtes5z6L8wC3IPkrL70y26ROe3u?=
 =?us-ascii?Q?psJCXOyuXspcLCfeSBCO8evXcQU5gnoTBnBffBh+ymDQlsLeIZbdRM+bNR07?=
 =?us-ascii?Q?WV9wG0JNs5gHOnKwaauPOExSksaIQrAWgtDpQzvEf3vitI+3uUX7N/VlmD8L?=
 =?us-ascii?Q?o8yJtPrZDfSjb0NxxeOzRhqQIlOpC242U0R2+JkanHiz4QKCfgUEs1qO1s6f?=
 =?us-ascii?Q?qKVNgvRh9W+WKGn8Ih/yg+a9NmfbJDEMg7bvabSCMV2ThccZTm6A1tZ9Fn3q?=
 =?us-ascii?Q?ELE7O4+Byd5qKj43iaF0syvkQAcoJ4D6UgtZ2ggpnxB8nhaV7igJW/hi1L1a?=
 =?us-ascii?Q?TQcjWVQasGNM+jhSAsZCK5s0vXTj6/ocbcLzGmHNgvI/n6se1wxodZa5Ra8s?=
 =?us-ascii?Q?GBLtfBvAcso5rp6KV4K5iUfSiA7XgeQzDUDvfuHxp/OArqFr4FFoPA9bEHzS?=
 =?us-ascii?Q?SsTUsS85JkfeR/EHvrMblDiJ1zmsEO8flYuU72/ep+bn1Jfou69vexXrw2Ar?=
 =?us-ascii?Q?dhR/76iIdcN1nLHFiRX7I102MXeJyKWiQ2WVmUd4VO0H90yAt68pZerOFbQN?=
 =?us-ascii?Q?CQu/lxyj3YVnLCsamMDnXLX76cgDGhJCjDSsmAsna8HZ54QGeku18TRJ0VQy?=
 =?us-ascii?Q?46EHLQe0KJR31FWddZ0YROXhZa1hD6hOl8m0Y24ICAvXf6AaPX0KolOc58eU?=
 =?us-ascii?Q?ni80kGdADDpLA7952+dHA7XyRnU0VoTBNQri35Pcw7/O337cJDhyVAwxBl1E?=
 =?us-ascii?Q?HLx9/spGZZR3huEeMSChiYEogmIUYN6s4a+W0LGSVIVjnE2gDOV/37cPduD4?=
 =?us-ascii?Q?e3M2Z1BV9C6T7udH7yEgJn+OPyz7pYuBzSVo+ot4/ld5N2txJgUnznSwWuqS?=
 =?us-ascii?Q?MCljMvVa3P2gXKBUL+vLBv92YUIuE2DalSzmOGika2ph83aSIB7JwPSft0/4?=
 =?us-ascii?Q?RfEmXYV4/0sD2HR6pvVooh7SRG1a3v+Ne58lQ9HPEzzWkGf6/ZiyNK1PQ62c?=
 =?us-ascii?Q?AGXwXOBeCpyUM0tyIdIAT72KNelnSwEMOurif98DMpYME0i12uieFut4ZaOh?=
 =?us-ascii?Q?Iflf+/+DyPEnD/MdOKjMQjWYO5o5BNfzaltygWs9179pdqXTapoM95UoSAEY?=
 =?us-ascii?Q?nym40Y1X9do8vYOoUz15GLwYvT5Yz+zEGeKL0U5y6ZZHgSlGaMBmBaFZ2YBY?=
 =?us-ascii?Q?m138EJouQgwDHXdX/RQ=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 654a2a6c-f3e5-455f-f31f-08dc17335869
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8199.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 08:07:27.6644 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gLg7Os0XcjxLLTtYSGvPmjweQ2MN7wDM5eci1+pfR/CPBp7KqqFwLoIH+JDTNvto
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8061
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Add TST_EXP_FAIL_PTR
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

On Tue, Jan 16, 2024 at 06:49:26PM +0100, Petr Vorel wrote:
> Hi Wei,
> 
> > Signed-off-by: Wei Gao <wegao@suse.com>
> > ---
> >  include/tst_test_macros.h | 28 ++++++++++++++++++++++++++++
> >  1 file changed, 28 insertions(+)
> 
> > This is draft patch and should rebase after following patch merge.
> > https://patchwork.ozlabs.org/project/ltp/patch/20240103115700.14585-1-chrubis@suse.cz/
> 
> Patch was accepted, please rebase. Also, please add at least one test which
> uses it.
> 
> Also, I wonder if we need TST_EXP_PASS_PTR().
Sure, i can create another patch for TST_EXP_PASS_PTR.
> 
> > diff --git a/include/tst_test_macros.h b/include/tst_test_macros.h
> > index 3f4f9f11d..6e45e0b27 100644
> > --- a/include/tst_test_macros.h
> > +++ b/include/tst_test_macros.h
> > @@ -212,6 +212,26 @@ extern void *TST_RET_PTR;
> >  		}                                                              \
> >  	} while (0)
> 
> > +#define TST_EXP_FAIL_SILENT_PTR_(SCALL, SSCALL, ERRNO, ...)             \
> > +	do {                                                                   \
> > +		TESTPTR(SCALL);                                                   \
> > +		                                                               \
> > +		TST_PASS = 0;                                                  \
> > +		                                                               \
> > +		if (TST_RET_PTR) {                                               \
> > +			TST_MSG_(TFAIL, " succeeded", SSCALL, ##__VA_ARGS__);  \
> > +		        break;                                                 \
> > +		}                                                              \
> > +		                                                               \
> > +		if (TST_ERR == (ERRNO)) {                                      \
> > +			TST_PASS = 1;                                          \
> > +		} else {                                                       \
> > +			TST_MSGP_(TFAIL | TTERRNO, " expected %s",             \
> > +				  tst_strerrno(ERRNO),                         \
> > +				  SSCALL, ##__VA_ARGS__);                      \
> > +		}                                                              \
> 
> Maybe follow the pattern of already used tests (break saves else clause)?
>  		if (TST_ERR != (ERRNO)) {                                      \
> 			TST_MSGP_(TFAIL | TTERRNO, " expected %s",             \
> 				  tst_strerrno(ERRNO),                         \
> 				  SSCALL, ##__VA_ARGS__);                      \
> 			break;                                                 \
> 		}                                                              \
>                                                                                \
> 		TST_PASS = 1;                                                  \
> 
> 
> > +	} while (0)
> > +

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
