Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25100606A31A
	for <ltp@archiver.kernel.org>; Fri, 23 Oct 2026 02:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=EWwUWSj9;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=frFptw7F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1792723508; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=Dz9E3Vtv9AZwpax6exYmIr21EkPw5Gmt66C29RKZto4=;
 b=EWwUWSj94KSMnAC0h/gx6iBTSAkmUlvhqRKXNuP78+Fa1+Nd0kbgYWnK5dF8yYDGCX83j
 +1x8jWmypM4xi/cCUBbT5GDxGNGo0m4JVXR2YtZgEbKpiDchgv0yMgwdSnwAvlX4QABgSl9
 NKpArKiTSM3Y6nvtRUPP9WFVyeOaui0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E26773E60E2
	for <ltp@archiver.kernel.org>; Fri, 23 Oct 2026 04:45:08 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 97C523E6A4C
 for <ltp@lists.linux.it>; Fri, 23 Oct 2026 04:44:42 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 0F7961001148
 for <ltp@lists.linux.it>; Fri, 23 Oct 2026 04:44:42 +0200 (CEST)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4a20c923847so3169535e9.0
 for <ltp@lists.linux.it>; Thu, 22 Oct 2026 19:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1792723481; x=1793328281; darn=lists.linux.it;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2oJzHkbUmy86M5RmQMbKtJx1PrxM6B4xJa+H7wp1+gY=;
 b=frFptw7FjQk3yIVKZh7vLZTLlp+M3l0c+L17uTvELnV2asVgJhbl0eUCVjEgHLjKBL
 Ajkt0k3sK5sH24zUimxit+xgtDyA+kJjK0AMWPRPDYDfSDo7/jHEb5DZOZ9O4Hum0xvz
 x/d+AI/4KMCe0grsmJphKiE0U4jBlbXPielqv1FzfLibStwJd5usT4mc/JPnxmLC3L5Z
 NvkjjAWBo/BqQC+EVlD5CtyynZddp8t4EjdXwmJBmy2JNHqVDygeZvnlcNeKfeuEJNJw
 nRPwDnOrtOR+DV69ib6FxHItN9wxsHI83Tn5Aenl7WF6DosGkA1KQXRfNOXWPh6eoPFw
 YwzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792723481; x=1793328281;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2oJzHkbUmy86M5RmQMbKtJx1PrxM6B4xJa+H7wp1+gY=;
 b=aoRLUz+oHW3xiT8wORrriGwenkQU7W/d8fDalLosF09Oxg0OByldCfwRqxIen0miIT
 ojjZP0NzAykv52opjSM8DuuZFHFLcufQKf5spJcKLiU+e7edQ4J7DLSaP9nL31W3Pd6B
 VBNLp/vS2KTMOx1+6id98q+eUPcdzUC3OguuhD5/lpgLmMLMo/WaND6FoiecYs/St9nL
 4xLTGwffR2YlsnBC8rOPQOOBjpj1+uXrri9mkKk6a22ftW6KjmGbot0gAJreHjSGSp2p
 H2RslwntDaGd/gPVSoMEhzH5OsBgvDaEpjpRTp0IZjmzBSFnfvVYr4rMncIv5IVv56cV
 7ABA==
X-Gm-Message-State: AFq9FYISJMZ1OEYrWugl353BmL2m0LT0yEORadw7sToVuyBjah/c+oey
 g0IsSr0nxj1bDhTZdx/VPTV84nzXUZEWxH//DeU2pbF8Xj74MRJPImvW+yVl4IMYjw==
X-Gm-Gg: AYBFou2oy5jJmrx++z4d97x4oNOSCmLVyOEN+/6gaHBrrVCS1C+1jU4PqJsi5RHZFGP
 Ebsmf4mhmJzdVKdTjSL41mBvKLzpAm98PvKypexBGAfAa0hUOy040mSz1QpVhyQs9FvrQlYUTXR
 Ta9SKmfBP+ELzbRuygeP6aj9fDrWBqY4ch9YBbhUKbi9sB6G4HrDRAo7y/pX2lcGpsP+/e/s1j8
 IDtwWT8dibCQPLs2nM8U98ntexqSZ0uwB5I/Z3S1gSw24yCGSsoBiAHhj43ulRhJBqS7SNzkDvz
 BdezQq1Bw+cyW5ZQbrCkYyJt3eYVLRstXw5tDuKS9G1+xl3eL/Q9+OlDGEd83v6B2Outvyj0CAS
 Qm2SjUxLsvdsib74awE7HgjNi25koieRirF7NF5VGS4nLVQC2XQ4IEQpbdO5fpufH7ceo/HVsRJ
 tbdaIX1gtF9D+HX8OUBa9TvkfSQam7XChjv0XlrpVnSOztFa2Ipox+iglvnAXQn+NsyBcJwYANU
 NvSTOopFDIJsfbuBnqQnmKXnUOzFut5gsyvvbUPs+Of/H0Ot2KwCmgFhG8MTBVSOIfIgF3AaIx3
 tU75qeLEmTqCu15uVoQUqPvx+ZNyxzv5YGhCH1QyxMQG053BzwH8MXsuSy4qxCDvelr9Xuj3XYc
 =
X-Received: by 2002:a05:600c:83c9:b0:4a1:7ba9:da2c with SMTP id
 5b1f17b1804b1-4a211ef7beamr12437825e9.25.1792723481433; 
 Thu, 22 Oct 2026 19:44:41 -0700 (PDT)
Received: from autotest-wegao.qe.prg2.suse.org
 ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a210299910sm39299985e9.1.2026.10.22.19.44.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 19:44:41 -0700 (PDT)
Date: Fri, 23 Oct 2026 02:44:39 +0000
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <atrKF8w-0-2RMPSe@autotest-wegao.qe.prg2.suse.org>
References: <20261022022824.19735-1-wegao@suse.com>
 <20261022022824.19735-2-wegao@suse.com>
 <20261022152542.GA405225@pevik> <20261022153249.GB405225@pevik>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261022153249.GB405225@pevik>
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v16 1/2] lib: New library function tst_get_free_uid
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: Martin Doucha <martin.doucha@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, Oct 22, 2026 at 05:32:49PM +0200, Petr Vorel wrote:
> > Hi Wei,
> 
> > > +uid_t tst_get_free_uid_(const char *file, const int lineno, uid_t skip);
> > > +
> > > +/**
> > > + * tst_get_free_uid() - Find a UID not assigned to any user.
> > > + * @skip: UID value to skip (pass 0 to skip none).
> > > + *
> > > + * Scans the password database for the first unused UID starting
> > > + * from 1, skipping @skip. Calls tst_brk(TBROK) if no free UID
> > > + * is found or a lookup error occurs.
> > > + *
> > > + * Return: An unused uid_t value.
> > > + */
> > > +#define tst_get_free_uid(skip) tst_get_free_uid_(__FILE__, __LINE__, (skip))
> > > +
> > >  /*
> > >   * Find unassigned gid. The skip argument can be used to ignore e.g. the main
> > >   * group of a specific user in case it's not listed in the group file. If you
> > > diff --git a/lib/tst_uid.c b/lib/tst_uid.c
> > > index b0b087362..47c267bc4 100644
> > > --- a/lib/tst_uid.c
> > > +++ b/lib/tst_uid.c
> > > @@ -5,6 +5,7 @@
> 
> > >  #include <sys/types.h>
> > >  #include <grp.h>
> > > +#include <pwd.h>
> > >  #include <errno.h>
> 
> > >  #define TST_NO_DEFAULT_MAIN
> > > @@ -12,6 +13,33 @@
> > >  #include "tst_uid.h"
> 
> > >  #define MAX_GID 32767
> > > +#define MAX_UID 32767
> > > +
> > > +uid_t tst_get_free_uid_(const char *file, const int lineno, uid_t skip)
> > > +{
> > > +	uid_t ret;
> > > +
> > > +	for (ret = 1; ret < MAX_UID; ret++) {
> > > +		if (ret == skip)
> > > +			continue;
> > > +
> > > +		errno = 0;
> > > +		if (getpwuid(ret))
> > > +			continue;
> 
> 
> > If you don't mind I'd prefer to use the same approach which is on
> > tst_get_free_gid_(), e.g. set errno first:
> 
> > 	errno = 0;
> 
> > 	for (ret = 1; ret < MAX_UID; ret++) {
> > 		if (ret == skip || getpwuid(ret))
> > 			continue;
> 
> > Reviewed-by: Petr Vorel <pvorel@suse.cz>
> 
> > Other than that LGTM.
> 
> > Cc Martin in case he wants to add his ack before I merge.
> 
> > Kind regards,
> > Petr
> 
> > > +
> > > +		if (errno == 0 || errno == ENOENT || errno == ESRCH) {
> > > +			tst_res_(file, lineno, TINFO,
> Actually also here TERRNO probably makes sense.
> 
> I suggest to merge with following diff:
Thanks. That's ok for me, will use your suggest on next patch once Martin give feedback.
> 
> +++ lib/tst_uid.c
> @@ -19,16 +19,14 @@ uid_t tst_get_free_uid_(const char *file, const int lineno, uid_t skip)
>  {
>  	uid_t ret;
>  
> -	for (ret = 1; ret < MAX_UID; ret++) {
> -		if (ret == skip)
> -			continue;
> +	errno = 0;
>  
> -		errno = 0;
> -		if (getpwuid(ret))
> +	for (ret = 1; ret < MAX_UID; ret++) {
> +		if (ret == skip || getpwuid(ret))
>  			continue;
>  
>  		if (errno == 0 || errno == ENOENT || errno == ESRCH) {
> -			tst_res_(file, lineno, TINFO,
> +			tst_res_(file, lineno, TINFO | TERRNO,
>  				"Found unused UID %d", (int)ret);
>  			return ret;
>  		}

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
