Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E5B3C4321E
	for <ltp@archiver.kernel.org>; Mon,  5 Dec 2022 07:04:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 43DD13CC205
	for <ltp@archiver.kernel.org>; Mon,  5 Dec 2022 08:04:12 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 158423CA6CD
 for <ltp@lists.linux.it>; Mon,  5 Dec 2022 08:04:02 +0100 (CET)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 57A4F7F9107
 for <ltp@lists.linux.it>; Mon,  5 Dec 2022 08:04:00 +0100 (CET)
Received: from canpemm500008.china.huawei.com (unknown [172.30.72.53])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NQZJH3BCyz15N5V
 for <ltp@lists.linux.it>; Mon,  5 Dec 2022 15:03:11 +0800 (CST)
Received: from canpemm500005.china.huawei.com (7.192.104.229) by
 canpemm500008.china.huawei.com (7.192.105.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 5 Dec 2022 15:03:57 +0800
Received: from canpemm500005.china.huawei.com ([7.192.104.229]) by
 canpemm500005.china.huawei.com ([7.192.104.229]) with mapi id 15.01.2375.031; 
 Mon, 5 Dec 2022 15:03:57 +0800
To: Cyril Hrubis <chrubis@suse.cz>
Thread-Topic: [LTP] [PATCH v2 1/2] lib/safe_macros: Add SAFE_STRTOF
Thread-Index: AdkId15Jp0KGmP/JQvClShxxQUnRog==
Date: Mon, 5 Dec 2022 07:03:57 +0000
Message-ID: <ee6ea2b055eb486a851b932a3d7ae92b@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.67.110.209]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] lib/safe_macros: Add SAFE_STRTOF
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
> Hi!
> > According to man 3 strtof, it seems there are some cases like:
> >
> > 1. strtof return the converted value as normal 2. strtof return 0 when
> > no conversion is performed, and endptr == nptr:  'rval == 0'
> 
> We can ignore this case since we check that the string was consumed later
> on. That's the:
> 
> +       if (endptr == str || (*endptr != '\0' && *endptr != '\n')) {
> +               tst_brkm_(file, lineno, TBROK, cleanup_fn,
> +                       "Invalid value: '%s'", str);
> +               return 0;
> +       }
> 
> 
> > 3. strtof return HUGE_VAL or -HUGE_VAL when overflow:      '(rval ==
> HUGE_VAL) || (rval == -HUGE_VAL)'
> > 4. strtof retrun 0 and set errno to ERANGE when underflow:   'errno ==
> ERANGE'
> 
> My manual says that the value is no larger than DBL_MIN, FLT_MIN, or
> LDBL_MIN in this case. Either way I would avoid checking the returned
> value in the case errno was set.

I usually look for information here: https://pubs.opengroup.org/onlinepubs/9699919799/

> 
> > For 2, it seems need to add checking of endptr when 'rval == 0' like:
> > (rval == 0 && !strcmp(endptr, nptr)
> 
> Again, no need to check the actual return value, we can just check that the
> string was consumed, which we already do.
> 

Thanks! I have resubmit the patch as your suggestion. 

Regards,
Gongyi

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
