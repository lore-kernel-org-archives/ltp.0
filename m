Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFD77C4321E
	for <ltp@archiver.kernel.org>; Thu,  1 Dec 2022 02:59:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E3AB73CC561
	for <ltp@archiver.kernel.org>; Thu,  1 Dec 2022 03:59:34 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ECC033CA9B6
 for <ltp@lists.linux.it>; Thu,  1 Dec 2022 03:59:24 +0100 (CET)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9B183600832
 for <ltp@lists.linux.it>; Thu,  1 Dec 2022 03:59:23 +0100 (CET)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.53])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NN13z0lL9zmWKp
 for <ltp@lists.linux.it>; Thu,  1 Dec 2022 10:58:39 +0800 (CST)
Received: from canpemm500005.china.huawei.com (7.192.104.229) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 1 Dec 2022 10:59:20 +0800
Received: from canpemm500005.china.huawei.com ([7.192.104.229]) by
 canpemm500005.china.huawei.com ([7.192.104.229]) with mapi id 15.01.2375.031; 
 Thu, 1 Dec 2022 10:59:20 +0800
To: Cyril Hrubis <chrubis@suse.cz>
Thread-Topic: [LTP] [PATCH 2/2] lib: Replace atoi/atof with
 SAFE_STRTOL/SAFE_STRTOF
Thread-Index: AdkFMOQ3vouZgYbgrUGoilFIOgYtkg==
Date: Thu, 1 Dec 2022 02:59:20 +0000
Message-ID: <92f26cd27f14427db5853e3d2f497050@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.67.110.209]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] lib: Replace atoi/atof with
 SAFE_STRTOL/SAFE_STRTOF
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
From: zhaogongyi via ltp <ltp@lists.linux.it>
Reply-To: zhaogongyi <zhaogongyi@huawei.com>
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

> 
> On Wed, Nov 30, 2022 at 10:19:01AM +0800, Zhao Gongyi via ltp wrote:
> > Replace atoi/atof with SAFE_STRTOL/SAFE_STRTOF in parse_opts(), it is
> > hoped to deal with the abnormal input.
> >
> > Modify the requirement iterations range from '>= 0' to '> 0', when
> > iterations' value equal to 0, the test will not run.
> >
> > Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
> > ---
> >  lib/tst_test.c | 8 +++-----
> >  1 file changed, 3 insertions(+), 5 deletions(-)
> >
> > diff --git a/lib/tst_test.c b/lib/tst_test.c index
> > b62559d75..254229d96 100644
> > --- a/lib/tst_test.c
> > +++ b/lib/tst_test.c
> > @@ -677,15 +677,13 @@ static void parse_opts(int argc, char *argv[])
> >  			print_test_tags();
> >  			exit(0);
> >  		case 'i':
> > -			iterations = atoi(optarg);
> > -			if (iterations < 0)
> > -				tst_brk(TBROK, "Number of iterations (-i) must be >=
> 0");
> > +			iterations = SAFE_STRTOL(optarg, 1, INT_MAX);
> >  		break;
> >  		case 'I':
> >  			if (tst_test->max_runtime > 0)
> > -				tst_test->max_runtime = atoi(optarg);
> > +				tst_test->max_runtime = SAFE_STRTOL(optarg, 1,
> INT_MAX);
> >  			else
> > -				duration = atof(optarg);
> > +				duration = SAFE_STRTOF(optarg);
> 
> Shouldn't we limit the duration to positive numbers here as well?
> 
> I guess that we should add min and max option to the SAFE_STRTOF() and
> call the conversion with SAFE_STRTOF(optarg, 0.1, HUGE_VALF); here
> instead.

Agree, it is better to add range checking for SAFE_STRTOF, I have resubmit a new patch to fix it, please see: https://patchwork.ozlabs.org/project/ltp/patch/20221201025141.71227-3-zhaogongyi@huawei.com/

Regards,
Gongyi


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
