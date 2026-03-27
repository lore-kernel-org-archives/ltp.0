Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47900F532CC
	for <ltp@archiver.kernel.org>; Fri, 27 Mar 2026 03:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1774583498; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=J3YFH3mAws4OPIgQg3t0TTxngZ5G9wWd4ci5oqfnxyA=;
 b=ecWjYIVcEZ+ltVzX86vausdQ61H7A1EA9L7NkIZR7638PYFTyfVeLD/Yjdiwe/caMyyAB
 aXEJZHkP5sNSqFF2mqb7Bj7ej2Xihoq4iwURRxt/nR/bbRxGlVKQOIbfa0HJDg9fqzI+ccy
 CCEaBoc0rU6sr44nhhXE9rw19ATFxVc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BBB313D9E8C
	for <ltp@archiver.kernel.org>; Fri, 27 Mar 2026 04:51:38 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0E6FD3D75B8
 for <ltp@lists.linux.it>; Fri, 27 Mar 2026 04:51:15 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 5DCAA1400DB9
 for <ltp@lists.linux.it>; Fri, 27 Mar 2026 04:51:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774583473;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7VY8GypBJCuxlk6XI79yxW2L6Su1Zah8FwxW8D+JGLA=;
 b=bdYrFAF2Sf/3ZT6oQ+OFusVB0TCozIdH7MMv3QgM/LexpGzQ8/aneZHVIzs1u9OjQHsT4g
 iJ7XUyDTS0c0R4UOIl2gb9h+jP04p7EVun3VLlsJ5upP7ESFTnC0voJGblqzUzOby3rLTM
 n1KcGR3gv9DtDG7ce1AkE1tDT0u07uA=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-lEdERUEEOuCjrQXEAQGV1w-1; Thu, 26 Mar 2026 23:51:11 -0400
X-MC-Unique: lEdERUEEOuCjrQXEAQGV1w-1
X-Mimecast-MFC-AGG-ID: lEdERUEEOuCjrQXEAQGV1w_1774583470
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-358e95e81aeso5314152a91.0
 for <ltp@lists.linux.it>; Thu, 26 Mar 2026 20:51:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774583469; x=1775188269;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7VY8GypBJCuxlk6XI79yxW2L6Su1Zah8FwxW8D+JGLA=;
 b=WxFCOJ/TuYTd2+kO72BLss6ri5yo9u+ug42EwNAvfgYhO2uioh+wVOOYPtDX/dvRVA
 rcHoT6LTGuq1TktbjvSlMOMThQKphvcXGvBcypuzaV2+kSFdK2gybyUsPzjtVU2ldZeI
 OynNkuEAeX1m+i1ytW23xY6K1J/wgGPr/aCerM54m6nPAcnnB0O+IxGaTinI4JCDRMoc
 Ppe9OKraDCuvdRQLiBZddjZVZl6ZQFRDWYL/LmmBHEkBYeBO2mGrcS+HMWZIWR2HEY2o
 ATzg/jfhhynKG0po2a7EtJyXbzcqP577KI9mtU0oOoSphIJpbyG1peKCEwmMrdG68oFd
 rIDA==
X-Gm-Message-State: AOJu0Yy+18P1ibBKWaF+VXtlv1T+0UY97i4rW6LHJrQ8kbOH6WElqzNH
 Y3QP3ZY6JWAbU5UMrqSnGJy83KEmj6n099F4COQ5gak/O9xP1bDJ38b73mvyeaivth68FEWBg0/
 lloAPToguic9ibIP+nuJxAjIBrakUB5oHn3B2CeW6O+425qSjteJlliMrJIC4
X-Gm-Gg: ATEYQzwdUy5OmG+NQ5PK5pX0eRbQFcbVd54EQAqJ9ZI/jU+HNfYZd0cxYAjixRgAYmj
 3ueGqQAb+U+C5GOFtzhEtRZa5kbSOw1DreA6RU6dFoQojUAnOQIy/LckBrf2kZl+l7KQA+Qc3i3
 3gIOcJxu/fpSEcPuz+C4hl+0F8KGbk2xiowvbt/byy935uveYA4EXuwawngaJxbg3oikxWgK0iY
 aEyKu0ArrWqhP12o0cgYYpeU+CjCChXF2NLADvdNtuLiBby7OhITKeYM7UZ2bk9CqiRWQvQ7Ptk
 hHdm6/UZuKWhHMn0z6H/GC7FyUbUY6Sxnfr3lx6qqmW5bSsBUasw5krRVzpFUre72j59y2bORoI
 QbGJ0hLGUv22Zc6zW4g==
X-Received: by 2002:a17:90b:380d:b0:359:f3b1:6811 with SMTP id
 98e67ed59e1d1-35c2ff08081mr1032737a91.1.1774583469226; 
 Thu, 26 Mar 2026 20:51:09 -0700 (PDT)
X-Received: by 2002:a17:90b:380d:b0:359:f3b1:6811 with SMTP id
 98e67ed59e1d1-35c2ff08081mr1032721a91.1.1774583468764; 
 Thu, 26 Mar 2026 20:51:08 -0700 (PDT)
Received: from redhat.com ([209.132.188.88]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b0bc79c471sm46644515ad.22.2026.03.26.20.51.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 20:51:08 -0700 (PDT)
Date: Fri, 27 Mar 2026 11:51:06 +0800
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <acX-qoCubANAhZWu@redhat.com>
References: <20260326170435.22566-1-pvorel@suse.cz>
 <20260326170435.22566-2-pvorel@suse.cz>
MIME-Version: 1.0
In-Reply-To: <20260326170435.22566-2-pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9s3Mhyq5gyQkMnSe15M0vy5U5sCtOxL0h17xbRKPdkY_1774583470
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/3] lib: Ignore empty LTP_ENABLE_DEBUG
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
From: Li Wang via ltp <ltp@lists.linux.it>
Reply-To: Li Wang <liwang@redhat.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, Mar 26, 2026 at 06:04:33PM +0100, Petr Vorel wrote:
> Empty LTP_ENABLE_DEBUG environment variable should be just ignored.
> 
> This fixes warning:
> LTP_ENABLE_DEBUG= ./test05
> tst_test.c:1454: TWARN: Invalid LTP_ENABLE_DEBUG value:
> 
> Fixes: e434de62b4 ("lib: Extend LTP_ENABLE_DEBUG to support verbosity levels")
> Signed-off-by: Petr Vorel <pvorel@suse.cz>

Reviewed-by: Li Wang <liwang@redhat.com>

> ---
>  lib/tst_test.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index 2d62ab164d..4a22f2e477 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -1445,13 +1445,13 @@ static void do_setup(int argc, char *argv[])
>  
>  	parse_opts(argc, argv);
>  
> -	if (tdebug_env && !context->tdebug) {
> +	if (tdebug_env && tdebug_env[0] != '\0' && !context->tdebug) {

Or, more shorten:

    if (tdebug_env && *tdebug_env && !context->tdebug) {

-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
