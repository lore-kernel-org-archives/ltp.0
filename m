Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4E39C43334
	for <ltp@archiver.kernel.org>; Tue,  7 Jun 2022 02:15:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1C49C3C8D47
	for <ltp@archiver.kernel.org>; Tue,  7 Jun 2022 04:15:15 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2A0623C1B99
 for <ltp@lists.linux.it>; Tue,  7 Jun 2022 04:15:01 +0200 (CEST)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 983C46007B0
 for <ltp@lists.linux.it>; Tue,  7 Jun 2022 04:14:59 +0200 (CEST)
Received: from canpemm100006.china.huawei.com (unknown [172.30.72.54])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LHDRh0W4Vzcm8S
 for <ltp@lists.linux.it>; Tue,  7 Jun 2022 10:13:36 +0800 (CST)
Received: from canpemm500005.china.huawei.com (7.192.104.229) by
 canpemm100006.china.huawei.com (7.192.104.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 7 Jun 2022 10:14:54 +0800
Received: from canpemm500005.china.huawei.com ([7.192.104.229]) by
 canpemm500005.china.huawei.com ([7.192.104.229]) with mapi id 15.01.2375.024; 
 Tue, 7 Jun 2022 10:14:54 +0800
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH] tst_kvercmp.sh: strip '+' when $(EXTRAVERSION) is
 blank
Thread-Index: Adh6CNsdng1iW7IVTqiR9WjYi5/Fsw==
Date: Tue, 7 Jun 2022 02:14:54 +0000
Message-ID: <3b3bb782eec842579edb890bb7282e80@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.67.110.209]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] tst_kvercmp.sh: strip '+' when $(EXTRAVERSION) is
 blank
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

Hi Petr,

Yes, if EXTRAVERSION is set to "-*", it has been stripped, but EXTRAVERSION also can be set to blank and sources were modified without commit, In this case,
we run 'make clean' or 'make' would report error like:

./scripts/tst_kvercmp.sh: line 16: 5 * 65536 + 10 * 256 + 0+: syntax error: operand expected (error token is "+")
./scripts/tst_kvercmp.sh: line 17: [: -ge: unary operator expected
 
Best wishes,
Gongyi

> 
> Hi Zhao,
> 
> > $(EXTRAVERSION) defines an even tinier sublevel for pre-patches or
> > additional patches. It is usually some non-numeric string such as
> > "-pre4", and is often blank. When $(EXTRAVERSION) is blank, there may
> > be a extra '+' which shoud be stripped.
> ...
> >  r3=${r3%%-*}
> > +r3=${r3%%+*}
> 
> Is that '+' on kernel which sources were modified without commit?
> This can be on version with non-blank EXTRAVERSION, but in that case it's
> already removed by r3=${r3%%-*}, right?
> 
> LGTM
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> 
> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
