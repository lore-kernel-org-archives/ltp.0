Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8E1606A31B
	for <ltp@archiver.kernel.org>; Fri, 23 Oct 2026 02:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=YPU7n6Uu;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=AarDez4V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1792723636; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=cJSJSTN0RSI9AjZjjpSqn/4raJxiSNji+JBUrAegq90=;
 b=YPU7n6Uumys4dFOYmbj0rbSjLL0V+aM8F3xYYwyS32GYiCR1vLBA00hj3d2KjdkLQu31+
 8QCWeoPOjVTRNnlfpli6vx5En9tp+NIaQIYEQzptpfKjWOb2417lud2TbV34mfwH4nFKfCN
 qT1ZdBrkXiDfLnFmCetsKZgFeuAy82s=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D77733E60E2
	for <ltp@archiver.kernel.org>; Fri, 23 Oct 2026 04:47:16 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0E0283CFD68
 for <ltp@lists.linux.it>; Fri, 23 Oct 2026 04:46:56 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 36659140138F
 for <ltp@lists.linux.it>; Fri, 23 Oct 2026 04:46:56 +0200 (CEST)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4956869750eso2338945e9.2
 for <ltp@lists.linux.it>; Thu, 22 Oct 2026 19:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1792723615; x=1793328415; darn=lists.linux.it;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tvWaopbu1gnznTd5jWTga/ATmUSYsprijURaYfTJ6OU=;
 b=AarDez4V/3Do20SbOHzCfy0NYWARw6YitZ85tZXwkJ8OkAy26ySebpbXYyrR0/ZELj
 lGVasF3D8q5wV7BUGTlaXoPH5lUShMhTbSnCyi/DK/8wxapW+a17xSjs6Ck7Zz4h48Z7
 GUF246Ah+d+tgKf0e3XTpNVBuNq6s832Bg4+pqq29dMzvsShQkaGvyC92qk8ALIHT0mu
 elFBH3mY2EHBk7qaERBW9wa+j0UwxAU44Wf+X/FlD+j9RuGX0rMnFbFWP6n+2LEq/xtK
 tfsFQgIMTLY9ZYNF8Ej0v4JLaIduVbIG6erEuXUiJ5xN6BbFBD6wUcSFHz4JlW17Cylp
 jiAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792723615; x=1793328415;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tvWaopbu1gnznTd5jWTga/ATmUSYsprijURaYfTJ6OU=;
 b=hPpA6K8SEWWOZX0lIbFjWv283nz9AvtJV/gTHqVeenkXnBoXwgUCyghvM+WD35fprl
 XlMlkAbJ1RCc8CK+V6eyckzuravxMe26rJBmHP4RTKF70MOHlv2T67MM+0x1NdzayOkb
 5dXLdfFx4anx9WUAFf7hMr2ylIWrMOBbGep3lwkZHFwbV+1VClDaGK/j5/iKmJEEhWEx
 nd9YKDqQZjF3xsHt7mEtEmXEmLsVlbnHcPIZfZM2VQ4bj1ELThLdZWesh7lg73xAXD5j
 j9yTn/4i1tZmoweg0EU+00Wwy49dEyEEINQ0Ig3cBfRwBiQwfuqsp38BY0+8xmx4wV4i
 aliQ==
X-Gm-Message-State: AFq9FYJI2ujFqJm1VjfXhl4GiwaywfZnIsWSxYfnJUGQFdU4ZhxgrUPt
 A8I0D3xb7+0zlJsugz4o3TmfPnvyNpEw1jOKEwqhJ0rYkC0LWDSiB+Oh3BZH6jPojA==
X-Gm-Gg: AYBFou0t+y9wXfISS09vE3Q2z+RUyykBLMC0+3H79OfzO/Wjwmy7bRygNTIbK5oQppc
 OHcNZ8ej6HwWgvAl0ebhC3gO97LnGRcUZPJ8EVAxmBiHVvxPUMtGMADEHyX38Qn4qJyXwGPBF9v
 By2JayGPfTewZyn0FUpa7VifuLLKByPhzt039Wk8CY6tBtjJsCqtVVpyo6sN8bnSoXCkn0q8nri
 df0ZydT63ozaTWA+/MJdHuX4jJUa1wvND7c9cBPLuBHOLxCjGlUnSvfN1+HW38hne+w937VSOM5
 7ytVEUZdEmJ8WYYlIYRZugeEykhwNNKdJI4He4xRBXLV/8aDXDxU9fxgQO+jQeRqJsE7y/ufnDQ
 SDSyeLuV6RED7BXjlNmTCoA1mK3y/w0aOFyl4e89C+MeKn9J28RKuSvauaAZq4roO2Nx6Db9G4z
 NEet6HevXoXBwkpWOgmRTj1Y6xLqRsIA05JcVz5SBDeb4iHXotK7QBgWFFDMAJluYzWaKd23DpA
 ZFVoj2LYx0PbCGUi9h+TiEjTgIjV9LRuqon9ZO3nAhTlMBjfpVnD11wQdkiNqjfntwPYKt/QjY0
 mGHo2aecqW7FHNVZv5daKOy8qpwnYmjrHCu9h1/V9IS/U8ZzoXPFmA==
X-Received: by 2002:a05:600c:608c:b0:4a2:167a:c939 with SMTP id
 5b1f17b1804b1-4a2167acd9bmr100815e9.21.1792723615561; 
 Thu, 22 Oct 2026 19:46:55 -0700 (PDT)
Received: from autotest-wegao.qe.prg2.suse.org
 ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a21555d543sm4369185e9.4.2026.10.22.19.46.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 19:46:55 -0700 (PDT)
Date: Fri, 23 Oct 2026 02:46:53 +0000
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <atrKnXXqaislOimV@autotest-wegao.qe.prg2.suse.org>
References: <20261022022824.19735-1-wegao@suse.com>
 <20261022022824.19735-3-wegao@suse.com>
 <20261022154436.GA419745@pevik>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261022154436.GA419745@pevik>
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v16 2/2] open16: allow restricted O_CREAT of FIFOs
 and regular files
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, Oct 22, 2026 at 05:44:36PM +0200, Petr Vorel wrote:
> Hi Wei,
> 
> ...
> > +static void verify_open(unsigned int n)
> > +{
> > +	struct tcase *tc = &tcases[n];
> > +
> > +	SAFE_FILE_PRINTF(PATH_FS_PROTECTED_REGULAR, "%u", n);
> > +	SAFE_FILE_PRINTF(PATH_FS_PROTECTED_FIFOS, "%u", n);
> > +
> > +	if (tc->owner_uid != (uid_t)-1 || tc->use_nobody_gid) {
> > +		gid_t gid = tc->use_nobody_gid ? gid1 : 0;
> > +
> > +		SAFE_CHOWN(DIR, tc->owner_uid, gid);
> > +	}
> > +
> > +	if (tc->dir_mode)
> > +		SAFE_CHMOD(DIR, tc->dir_mode);
> > +
> > +	if (SAFE_FORK())
> > +		return;
> > +
> > +	SAFE_SETGID(gid1);
> > +	SAFE_SETUID(uid2);
> > +
> > +	TST_EXP_FD_OR_FAIL(openat(dir_fd, TEST_FILE, O_RDWR | O_CREAT, 0777),
> > +			   tc->exp_errno, "openat %s (sysctl_val=%u)", TEST_FILE, n);
> > +	if (TST_RET != -1)
> > +		SAFE_CLOSE(TST_RET);
> > +
> > +	TST_EXP_FD_OR_FAIL(open(TEST_FIFO_PATH, O_RDWR | O_CREAT, 0777),
> > +			   tc->exp_errno, "open %s (sysctl_val=%u)", TEST_FIFO, n);
> > +	if (TST_RET != -1)
> > +		SAFE_CLOSE(TST_RET);
> > +
> > +	exit(0);
> 
> Do we need this explicit exit?
Yes i think exit(0) is necessary because only the child process reaches this point.
> 
> The rest LGTM.
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> 
> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
