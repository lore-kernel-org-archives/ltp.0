Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE3A5E743D3
	for <ltp@archiver.kernel.org>; Fri, 29 Sep 2023 00:49:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CD4F13CF8C9
	for <ltp@archiver.kernel.org>; Fri, 29 Sep 2023 02:49:33 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 92CED3CC398
 for <ltp@lists.linux.it>; Fri, 29 Sep 2023 02:49:23 +0200 (CEST)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on0611.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe02::611])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B03451000977
 for <ltp@lists.linux.it>; Fri, 29 Sep 2023 02:49:22 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MsNJkXu/0axyl64WWVy4yILqlWAnvMl0RW3cvq/Da5pq3cei6A7F84MhuGbtZ0KvfevD8R/boUJ7nvMHGM3Mg9663LqrdGmkQK1GXjOsXX89fv3p5/hhIB2Im3uPd7zdrBvV0zUS6iDmzZIGXCmuWzF4NPGDShD2oTpXhfEKU+5PNRs+0Td26+Jf+ivQVZeVtR17LuD8M83bLHd2I8vYkYhfXXfSewVkkmihDGt6zFfToSlzySOqXWD0bo5zfkGvk+zdSrvh9KSwWk6TX/32cE2pmL5gpGadnFXdTK/VxB23p0uLGuQsRx1cyLZ4vgP7/FvDaewy6BLzux2r9FHO/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=spzmHb3WR4Z0UkrUla+P7QdrIj+3ndePJLsVj1+cvhc=;
 b=H2aPR5nXonRmc7iQBW1JkngteqX9XoiCZoVUO06/Hf4YCVRLCS3ZT5lMUkD4sGo9jZsKNtiEbAn0eoyoIy5j8KcLGU/wHM+d09Gi4q9ahqmP76DfAWwO2Chcn9ExS6Or+R+tc4FiILAiXlxGrrfRcZWljGQt5aLubCG/b+HDyOQkSOLbrOrMxc79K5h+/tS21oTo5M0l7D0t7l0256qkcP9QyYPnm8xdSpa1lPZCyEBN/naTj7JpfiNQarNRivuLNcee6JcET1qarDPSRTyLVc+fF85ar1Wzo/3HyfkEao9Zi9vERoaJ0M3E4J3DbL0v7PCfHeYB7g0noP6wDVBICQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=spzmHb3WR4Z0UkrUla+P7QdrIj+3ndePJLsVj1+cvhc=;
 b=r4bGHrY2JjpMBBHeOoJv1/oEwkQjoCVyvfjkGvvWrrKJvHJBG1X+OWUmjVFfzzfmLIhnDJFKKolzGn75gMr69Xef8xo6wV8g0Ux296MugRU4sCpax8I3w7kL9rxJZKIt4xcKhpNXvQJe8S1OKO32iBiMlbJKV1pNaaTxjNnSaHnte2xN4homv/5xl5gG8LwiX6fqkFBSEgzeQPSXynHIGMLwTDUi0wzhLFHZxMdMxpQ2lnOfyfOAE6WOuXtLWPIHlnOzL9JN9JdDZIda/O+7C0BkKlQDEkwpVNwHtmRNhU/Mplk8EDVLWX8i8o/cgKXvYHUm2cjiFwtAPkaz8tjIoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com (2603:10a6:20b:3f6::21)
 by PAWPR04MB9806.eurprd04.prod.outlook.com (2603:10a6:102:389::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Fri, 29 Sep
 2023 00:49:20 +0000
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::41dd:e42:e86b:c92f]) by AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::41dd:e42:e86b:c92f%4]) with mapi id 15.20.6838.016; Fri, 29 Sep 2023
 00:49:19 +0000
Date: Thu, 28 Sep 2023 20:49:14 -0400
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZRYfCogLjl0vBdm2@wegao>
References: <20230928010808.15862-1-wegao@suse.com>
 <20230928084408.21125-1-wegao@suse.com>
 <20230928175529.GB307171@pevik>
Content-Disposition: inline
In-Reply-To: <20230928175529.GB307171@pevik>
X-ClientProxiedBy: FR0P281CA0111.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::12) To AS8PR04MB8199.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8199:EE_|PAWPR04MB9806:EE_
X-MS-Office365-Filtering-Correlation-Id: 38e69df8-5458-465b-20d1-08dbc085ea45
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KJjfAFJnuLJznnwJQbCqdWPV/xvekn6LoVKV9aZkZH13hqmEOD7Zil99uRYrZxLFHFOMwYFO/73xDG1Ot4MDdcLswuOEy/dR7tSl+Rp3/y5pEOLSiK0daSfvS8kD90BcjXRw4D+cvYYrUyYuUYGCk1x1nADJvLNp3WMg4mmRncALNX6Ic81fRlG2Lx+iAEXBfnyAOYzP2BdNE3AnvW1jfC3dFn1RRrSYrVO8dQYriThvOw8jSjn7aHcspMZBSiCSx4gkQMCa1+CGs10GdAMbceeng5ekZVmAxmzKCcmdOajaL89WXAJQICNdqrz7lRNVjhzclIyDkea7sPvo2x+Wbk9shWvVBCRedBIjSZ+CSFdK80+7Ku0PrcbKzQMqEyMp0F9wGXueOLzm7NT02gUrglsqI+n55WyO94e3avdjKkAG+d0tADlGRlxkwAWVgNlf5iwuMYRsrDMH2/qtZZvDIjsFYOnzAu7Ikw84auGMgE49rii7ju0mTzspJt/2kp2C6PjELoo1RA4FNZZCkp7xq1r+vs2RN/TzNWE8caTMqdI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8199.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(7916004)(376002)(396003)(366004)(346002)(39860400002)(136003)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(6512007)(6506007)(9686003)(6486002)(2906002)(86362001)(966005)(6666004)(478600001)(8936002)(8676002)(4326008)(38100700002)(33716001)(5660300002)(41300700001)(26005)(316002)(83380400001)(6916009)(107886003)(66476007)(66946007)(66556008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HHCCa6Oeev8EnqtqqT2DxbC6jG/vWpkzw6wV7gG3fXWDq8Q0PJ5hCbDzFq3b?=
 =?us-ascii?Q?v3VSOsWS5dJbvECR0+aIM5PLNGXXEA70wJ/QSQlY+ZPcOvXLfdknIoA0G6GG?=
 =?us-ascii?Q?OGzk80px3D3bwKgS10BRWnl8Q4a6wstc2HRXN9wJ34sEH9x7MKoTrXzpexDh?=
 =?us-ascii?Q?JMSbJLEIYa70ERvWrklWTbfU4iBrI6PLt/WwiJPshC3aU6LzGD7g5EgZXp2M?=
 =?us-ascii?Q?LhxZCJ7OwD/BhmRB6JHRO0BmhqtzqIvG1T1lHny3U27mnaJ++fxoRnvCskRK?=
 =?us-ascii?Q?Ppqtf2sBPPdJr0FfdRK1Qqu4xYSEnIadk8oZeBegrzO4c73FIuZUW+aU3yoB?=
 =?us-ascii?Q?kC11vgfPvH6t8AmUWpuYxJE0F27H89gRJorxQBctOC8NnVAYfGeCQZAkF4lq?=
 =?us-ascii?Q?n/U4TyilO7GjNZkkD6Gg/qeYdyLfYAuB4qyWsMFksBil5s7Vt9+xx9uZrZ26?=
 =?us-ascii?Q?Zfk4vwwWqte/hUaRboEpKSvyElmbq46pYnB1+rsiMyT6Zz8CaUq+2M0t/2wV?=
 =?us-ascii?Q?gdx3Q7G9cSTPaMLm9bU1okEs1Ti0PQUzr9vKJ9dg1QPLjesEAEada0w15bIF?=
 =?us-ascii?Q?Ea3hKYIYoMguyd6eZ2iepLu8boSuYNog38RQhpdFQ+K3wxLQnooJHmjrYNA+?=
 =?us-ascii?Q?XQyHN+mFlUsojhQPYJDZ1iAtuG9of7cyoKeVehoYuU6eLrAXG6hu1S24rpFu?=
 =?us-ascii?Q?Bm5r5hVqW+wTZXt4GlZXmIS6fPiD1jFgr/NyfFOYRpNjHseIJXXkrD3+L08S?=
 =?us-ascii?Q?IppF+zjXAXBVZfSR1t7c9/dzna6YYY51FAyMG72ISor+Qtpn1gcAyia4VBdc?=
 =?us-ascii?Q?hEJOVTu6B54BmmAwC8Fwo4D1xq5pJo0E+jBJloYZZdYXakt2ObrOqFvgWfmc?=
 =?us-ascii?Q?/o842nCbv3Dnspo5pzg9WTcuR/1EzYClst7Ofnvt/gE/n4JTl7KudUdLPwfs?=
 =?us-ascii?Q?8oMJD0klHsVrjW+a81c6017USBdSsfrlilGwnFL3jLzhIcSlOdVR21GvbikO?=
 =?us-ascii?Q?cco6uInj/I7nhkW1zvsvb14ZUWMkJCGzDMu6GFWV0L4EzPNkljxj847tuZaj?=
 =?us-ascii?Q?OAy/77AkgsaFSMoKRcaTIPhBkIwAqh8I1RQnojUKNBNfHX7LPlKdEVRlWp2a?=
 =?us-ascii?Q?z+h+mZ8P5j3WcRlqdhYJkEla4lhbVdfQnnI6WZIFW14rei6U5m97G+w4tjZK?=
 =?us-ascii?Q?Gz16AU2UuqNRh9diknXPcSMI7TjfVEkdwtkf6BlVDlKEOGrK/pdZ2+dmMXwP?=
 =?us-ascii?Q?st7kRwZC9lZDjzR3/ypps6d3kjqzD2blwmKg13G17UWU0BXRaCvajJOnbIF1?=
 =?us-ascii?Q?v1EZIE1FpRBrY1+qRIqJFWneMnMZJ9dMKWjwzEU8zLhhFeE5rvCZb9heNkqq?=
 =?us-ascii?Q?e7JgSWw+9LCKh8ItfCQvSSerZci7FPvWyLVb2WXEdCoxLbBf2eo9ORq+gRv7?=
 =?us-ascii?Q?1regyOs/kbTYQNyMTQlQlosxH1hYwOQqTTBgNmrsLbMN73b4zGurZKnL8h5j?=
 =?us-ascii?Q?tIlmgFIzgE1CjYlPdhWxs+wzDls9DORQ8pz7w5KB0YmMZhIE9JzVAU5SFver?=
 =?us-ascii?Q?mT/CbtcC46ID5Y+2ta1PKimwtjVc0BhMzwGHTPDD?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38e69df8-5458-465b-20d1-08dbc085ea45
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8199.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 00:49:19.9398 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YpYXlV1p8e6UNKrwWbA3cUpMUEsODml8moDWyLsyX4B48rO4JppUbtZhTO83Un7z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9806
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] getcwd01: Use syscall directly check invalid
 argument
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, Sep 28, 2023 at 07:55:29PM +0200, Petr Vorel wrote:
> Hi Wei,
> 
> Yes, syscall(__NR_getcwd, ...) is way much better than #ifdef __GLIBC__ in v2.
> 
> > Related issue: https://github.com/linux-test-project/ltp/issues/1084
> This should be Fixes: #1084
> 
> 
> > Signed-off-by: Wei Gao <wegao@suse.com>
> > ---
> >  testcases/kernel/syscalls/getcwd/getcwd01.c | 23 +++++++++++----------
> >  1 file changed, 12 insertions(+), 11 deletions(-)
> 
> > diff --git a/testcases/kernel/syscalls/getcwd/getcwd01.c b/testcases/kernel/syscalls/getcwd/getcwd01.c
> > index 65d827873..d47174ffc 100644
> > --- a/testcases/kernel/syscalls/getcwd/getcwd01.c
> > +++ b/testcases/kernel/syscalls/getcwd/getcwd01.c
> > @@ -14,8 +14,8 @@
> >   *
> >   * Expected Result:
> >   * 1) getcwd(2) should return NULL and set errno to EFAULT.
> > - * 2) getcwd(2) should return NULL and set errno to ENOMEM.
> > - * 3) getcwd(2) should return NULL and set errno to EINVAL.
> > + * 2) getcwd(2) should return NULL and set errno to EFAULT.
> > + * 3) getcwd(2) should return NULL and set errno to ERANGE.
> >   * 4) getcwd(2) should return NULL and set errno to ERANGE.
> >   * 5) getcwd(2) should return NULL and set errno to ERANGE.
> >   *
> > @@ -24,6 +24,7 @@
> >  #include <errno.h>
> >  #include <unistd.h>
> >  #include <limits.h>
> > +#include "lapi/syscalls.h"
> >  #include "tst_test.h"
> 
> >  static char buffer[5];
> > @@ -34,32 +35,32 @@ static struct t_case {
> >  	int exp_err;
> >  } tcases[] = {
> >  	{(void *)-1, PATH_MAX, EFAULT},
> > -	{NULL, (size_t)-1, ENOMEM},
> > -	{buffer, 0, EINVAL},
> > +	{NULL, (size_t)-1, EFAULT},
> > +	{buffer, 0, ERANGE},
> >  	{buffer, 1, ERANGE},
> >  	{NULL, 1, ERANGE}
> >  };
> 
> > +
> >  static void verify_getcwd(unsigned int n)
> >  {
> >  	struct t_case *tc = &tcases[n];
> > -	char *res;
> > +	int res;
> 
> >  	errno = 0;
> > -	res = getcwd(tc->buf, tc->size);
> > -	TST_ERR = errno;
> > -	if (res) {
> > +	res = syscall(__NR_getcwd, tc->buf, tc->size);
> > +	if (!res) {
> >  		tst_res(TFAIL, "getcwd() succeeded unexpectedly");
> >  		return;
> >  	}
> 
> > -	if (TST_ERR != tc->exp_err) {
> > -		tst_res(TFAIL | TTERRNO, "getcwd() failed unexpectedly, expected %s",
> > +	if (errno != tc->exp_err) {
> > +		tst_res(TFAIL, "getcwd() failed unexpectedly, expected %s",
> Hm, macros in tst_test_macros.h does not support char * (getcwd() returns NULL
> on failure. I wonder if we want to add TST_EXP_FAIL3(), or maybe macro with a
> better name (TST_EXP_FAIL_STR()).
This case we can use TST_EXP_FAIL2 since syscall for __NR_getcwd will return the length of the buffer filled
instead of char *.

Yes, we are missing macros to support char *, i think i can create one in another patch.

> 
> Kind regards,
> Petr
> 
> >  			tst_strerrno(tc->exp_err));
> >  		return;
> >  	}
> 
> > -	tst_res(TPASS | TTERRNO, "getcwd() failed as expected");
> > +	tst_res(TPASS, "getcwd() failed as expected");
> >  }

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
