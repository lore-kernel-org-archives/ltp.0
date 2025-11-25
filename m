Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F45ACFD364
	for <ltp@archiver.kernel.org>; Tue, 25 Nov 2025 04:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1764045413; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=K3kD0757vNwbtC+gplV0cc8xvFgi9EarxZaADxqVXc4=;
 b=HGu6kPu7mlgxyM1BdVZNKPwFkaJ7n1tA06vuQE1QJX9xO2HIa71KexOdIHvnfNUvIZScK
 FknJJCbICVLEGKUWQ7AqV/5Qj1LiTWzKTsmPElJWbRGhdMXHy5WjBoMlESAldtefeBHtz2E
 8N65EK6I7QfavUT1X4KkikLO6V1uG38=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3211D3CAEFD
	for <ltp@archiver.kernel.org>; Tue, 25 Nov 2025 05:36:53 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 629DA3C56DC
 for <ltp@lists.linux.it>; Tue, 25 Nov 2025 05:36:31 +0100 (CET)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 9732E100094B
 for <ltp@lists.linux.it>; Tue, 25 Nov 2025 05:36:25 +0100 (CET)
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-42b47f662a0so2627923f8f.0
 for <ltp@lists.linux.it>; Mon, 24 Nov 2025 20:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1764045385; x=1764650185; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+2qkTV+nNm9roSvshhtqcm5teMU+BJUa4bRa9rM7kK0=;
 b=cCZOTUhqXz8MPfVJHZHPHxbLU1CN2/A0PursIMELFiZ8A/qbIzN4aqsLkTgA3hnjEN
 Wc4F5Uh4zfdaYzKrMbmzMtCwSQlxs9AeUEaEgOmTe7szrJyPUWnXac07SIeL+MQDi7Dl
 VWZg11RgkeErl0Nbc42kwlUBWFjJy7I9wqvNdV9XjRr4z/PiIO1N2YritRLhggMBGp9c
 LIbs5T3lAttFMEms7JMTYNKBxXwZj2XaQPXFMGf7DUxbFAoZkgpP2o3vLk4hn+csOlDy
 yW3nPFwUoqzRELk+8b4Vq4vfV3EYGyEzP/pK7NUKjch5GhYW44igFDo5zJT8Y4iNj2FC
 7QfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764045385; x=1764650185;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+2qkTV+nNm9roSvshhtqcm5teMU+BJUa4bRa9rM7kK0=;
 b=J4AkllKe9OfAT7o3FT30xwk4soHLNJRw0QiBx29sDKVfkfxdHQIPhlsOVm+52ToEIs
 p9Ipxed3QF6w7mkhdokkZwhfqk4EDqO9FNrlapEIMZtpx1BzGTgQSC2hGr4nsXFn2Wm0
 PkwPr5rmjTf99rRdKFwBP7D94Wcd28LEW8WIBrR2A3sPNSwVruYJgJlY4zEyJN0N7R/x
 qlKoAYDFFnGxHvLBz/FFmwND4gZnDLkIL8RBVHc5LvPqYvA/BuQhXmYMSsm2X/QSUSFT
 rFdyX+Eq4/g3Zt86TUzxUMgX65h2H1+bHXwkzgyy23bz/pnU9MHwq+FFavzEDeQrnSqv
 QUfQ==
X-Gm-Message-State: AOJu0YzC0MXIcYZp7R9yI3WBnsXEzoicjx/oj4BvQM3F6GHeb1fxFunn
 qYyycZDgqyVPMYM4edrSQX+zMrT3hLhChFnu6g7mrZjJZAWRph/u/MkxvW5mRqf8Sw==
X-Gm-Gg: ASbGnct192SDTo2HgFQnEcqXra3VpIZ9DklaTU2wmHAMEtuIimOaapRIX8liFvIA7lY
 +6bnMWx3AYV3ZrRb4MUySDyIHzf5O/UaeDIHawx8l50ebBCUHC/6XRz6egvJR0fqpt4dYvl3uQg
 tqBuxcy+DJquv1BCsNRkj1oRtkuUfDHvbeGPQWZu6PqjbhSOs4+9sOA0tzupv0noacw2wXsFweI
 8jhBjwjkn0wqPAPrtytYUopKF6Trx2Ol3xVxAYFsg+yjMXJJbB5p78YC2z0LgkeaNE4O/5VenWm
 DBJMp3Lsfvgu7J1AYVwEmX0IQHkHBIH8i4WWmaH8OxrCHG9jsmPNQ3CL0By0hWBRs7OJ+hJeaii
 D4OwVrVEiytFhlG7Fo+zgu8fcW/jQZ37prhzPQZtrtnjCVQJ/Wd1Dz8VsEWusam+JwG54qe0HPC
 4kJOhNOY+N/EYUDKBS9D+33KHx3rdP
X-Google-Smtp-Source: AGHT+IGDLAM8UHSinJslQc65mXsIFdygw5U6xar4bRvLj+axs1KVW2Ha7ja7soZCPAkSBnDPaerE3Q==
X-Received: by 2002:a5d:584b:0:b0:429:ca7f:8d6f with SMTP id
 ffacd0b85a97d-42cc135bc3dmr15849840f8f.15.1764045384988; 
 Mon, 24 Nov 2025 20:36:24 -0800 (PST)
Received: from autotest-wegao.qe.prg2.suse.org
 ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7fd8d97sm31371413f8f.42.2025.11.24.20.36.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Nov 2025 20:36:24 -0800 (PST)
Date: Tue, 25 Nov 2025 04:36:22 +0000
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <aSUyRl7ck5MyjqhY@autotest-wegao.qe.prg2.suse.org>
References: <20250521141655.3202240-1-wegao@suse.com>
 <20250523210950.1019560-1-wegao@suse.com>
 <aRXtUIlkNP3aDReN@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aRXtUIlkNP3aDReN@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] tst_tmpdir: Fix buffer overflow in tst_tmpdir.c
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

On Thu, Nov 13, 2025 at 03:38:08PM +0100, Cyril Hrubis wrote:
> Hi!
> > Using sprintf without length checking in tst_tmpdir may lead to buffer overflow.
> > So in this patch use openat() instead of open().
> > 
> > Fixes: https://github.com/linux-test-project/ltp/issues/1241
> > Suggested-by: Cyril Hrubis <chrubis@suse.cz>
> > Signed-off-by: Wei Gao <wegao@suse.com>
> 
> >  	} else {
> > -		if (unlink(obj) < 0) {
> > +		if (unlinkat(dir_fd, obj, 0) < 0) {
> >  			if (errmsg != NULL) {
> > -				sprintf(err_msg,
> > -					"unlink(%s) failed; errno=%d: %s", obj,
> > +				snprintf(err_msg, sizeof(err_msg),
> > +					"unlinkat(%s) failed; errno=%d: %s", obj,
> >  					errno, tst_strerrno(errno));
> >  				*errmsg = err_msg;
> >  			}
> > @@ -305,7 +339,7 @@ void tst_tmpdir(void)
> >  		tst_resm(TERRNO, "%s: chdir(%s) failed", __func__, TESTDIR);
> >  
> >  		/* Try to remove the directory */
> > -		if (rmobj(TESTDIR, &errmsg) == -1) {
> > +		if (rmobjat(0, TESTDIR, &errmsg) == -1) {
> >  			tst_resm(TWARN, "%s: rmobj(%s) failed: %s",
> >  				 __func__, TESTDIR, errmsg);
> >  		}
> > @@ -343,7 +377,7 @@ void tst_rmdir(void)
> >  	/*
> >  	 * Attempt to remove the "TESTDIR" directory, using rmobj().
> >  	 */
> > -	if (rmobj(TESTDIR, &errmsg) == -1) {
> > +	if (rmobjat(0, TESTDIR, &errmsg) == -1) {
> >  		tst_resm(TWARN, "%s: rmobj(%s) failed: %s",
> >  			 __func__, TESTDIR, errmsg);
> >  	}
> 
> We should pass AT_FDCWD to the two rmobjat() here since it's possible to
> pass relative path in the TMPDIR environment variable. Otherwise the
> code will not work with e.g. TMPDIR="." ./test_foo
> 

My test show we never support TMPDIR=".", following error will show:
tst_tmpdir.c:135: TBROK: You must specify an absolute pathname for environment variable TMPDIR
I guess we need another patch enable this.

> -- 
> Cyril Hrubis
> chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
