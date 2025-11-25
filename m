Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BB04CFD36C
	for <ltp@archiver.kernel.org>; Tue, 25 Nov 2025 04:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1764045594; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=Md+v8aqdd/xYFWb5JkXwUtE5/mWB/PUT4rxjovEZjvc=;
 b=CaZjTMf7YHtONMzN21YixhbBKJrR6EC1FWnmU5hC/nObg0hBOvjxpcRjW1oWv7sMQq8nE
 Fkv3+HZPzgtTpIcIlpkbevaa2XkP2TU1eevglq52auMClkgf+pBBUktMDfCtiT9zWHqowP1
 yPefN2LAcdzXvmz5InQZqv8c0OL1a9Y=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A27063CB254
	for <ltp@archiver.kernel.org>; Tue, 25 Nov 2025 05:39:54 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D378C3C56DC
 for <ltp@lists.linux.it>; Tue, 25 Nov 2025 05:39:32 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5A4C9600837
 for <ltp@lists.linux.it>; Tue, 25 Nov 2025 05:39:32 +0100 (CET)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4779cb0a33fso48930265e9.0
 for <ltp@lists.linux.it>; Mon, 24 Nov 2025 20:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1764045572; x=1764650372; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=gOW6zvxwoq0kScbhbyqS4cQC4KVgDNm1ewd3x4Uv41Y=;
 b=as/mJecLFhtHbA1ZovmvOL2q8ntHDzxXeBBfs10g1lxzgBj9jjD0C1AYh5i7pnivXL
 bIIYfNDPKSwv8cROq17mO2qBuuFifz2fIyyelBRRQttUAGuFIfjgobx/pDHEAa13uj8W
 zyBdHk81gkKn2CUBmDZQ7WJqoyix5kJ7wGu/LL2h6fbj5e9rIyDNL914g66CQvHd5CWZ
 4Sdlp4moHMCtuzxyG0/V2hrtb/lVb7nhWtslqG4aSRNnxVNnJNXa1PHpzlH/R3Hd7U9H
 ZKNcWNf2xXYaeD5h/yG/9Iq+D4E3KLwYitzBulh1Cd0N6lEBiljG6cw+IXa6kIjGj11x
 YBxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764045572; x=1764650372;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gOW6zvxwoq0kScbhbyqS4cQC4KVgDNm1ewd3x4Uv41Y=;
 b=a9iglBwton6XgNvUcjGwOHW0pxOjb20S7tk8HwUlxwjQfgaVp8lxBBwbCN/4AVlhj2
 8pEe30ecKWvNllB7h+yl9wb27T4azVZjv68n1axNcbmqwsUwh6z5pX7DzubxPVG49ldg
 OWMgPCx0SjitQTPTtY/87U3SkESQvkXwJTmCS58j8yhsmttShsAnUDsv4s3q/gmnm274
 LZvf7sO4j8Y7zyOkl3keCrv8pJpS1b6xZsXzZUaVz4Ec7BETDA7Rz4c2j3YAGfhzW6Pi
 jf/zmmx/aInbqFehz2c4bCtCh44p1UgbwLZA1vdiJhqUsU84iPUr89SPQU3JSdvhI19b
 upsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDiyiEkkZOgZLty6S/nx//z6JqQIVvhAFBnP5W4GGL3IjN/SH9YJd9ltsMRD5b9GdAhXg=@lists.linux.it
X-Gm-Message-State: AOJu0Yye5TGHs0vbsvZMkIBs7xXfKiT7lmbEBJejOVqPIzlu9WsaaCFD
 kAdIaFdpqr6AEgFG1EPSIoLbQyqX0c+gwWxwLknzVmVG66Gsy/aNXeSPP0ScNa0zmQ==
X-Gm-Gg: ASbGnct2ylNdYPi/zKSYznxdzkwQ0u3sAyY21ftATTQRCNTqkg348V1RfMXHv+vzeUj
 kpyNMV97m6ECZ1Hos4+VDCJ8blpFgyn5H1yONZEhsAnd3l/0rIqcXjbnOZKmBo9hLKPaRxSsAyW
 g6upifsTPx9k/woBbjG4knlJVF8N/1V0e4259qFMMjzMPkjm8AsE/rkLvQsfdc4qj4A29d/S/lZ
 BK+rGvWnGajwjE25zTxZqcuTECq9oLbZzbn+ER9RU7rBZCLKUKOT/uDGnVCkYlfu31G9mygf7s8
 Ojk/toiJnkNeZ+gwWoqUHXYQ7khExjN4FoaGaxxGvkLavGDjTmV2QUctbTsMsnOSjJFGzquXGov
 HR5MEZqcRngIR1NJBV0YgnrlECaVkeULyC3xh+f2srxQQU2flmeLyIJ5kmlSB3/rMMJ7dOGvGvy
 bVuLHXtKt074tLqqAdsKRC9HPHbO/YNdVBCFmcpxg=
X-Google-Smtp-Source: AGHT+IFHHwtWPv9boAunS89Q+AOsw0M3jxbMFbkQdbdVcZMpuJMDnuicziYQAnOrgNvr9/jb1eXqww==
X-Received: by 2002:a05:600c:1994:b0:46f:c55a:5a8d with SMTP id
 5b1f17b1804b1-477c0176437mr145244965e9.4.1764045571732; 
 Mon, 24 Nov 2025 20:39:31 -0800 (PST)
Received: from autotest-wegao.qe.prg2.suse.org
 ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477bf3aef57sm218140835e9.11.2025.11.24.20.39.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Nov 2025 20:39:31 -0800 (PST)
Date: Tue, 25 Nov 2025 04:39:29 +0000
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <aSUzAZtr4eKO3HDb@autotest-wegao.qe.prg2.suse.org>
References: <20250521141655.3202240-1-wegao@suse.com>
 <20250523210950.1019560-1-wegao@suse.com>
 <aRXtUIlkNP3aDReN@yuki.lan> <20251114085856.GA43654@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251114085856.GA43654@pevik>
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
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

On Fri, Nov 14, 2025 at 09:58:56AM +0100, Petr Vorel wrote:
> Hi all,
> 
> ...
> > > @@ -192,63 +253,36 @@ static int purge_dir(const char *path, char **errptr)
> > >  	return ret_val;
> > >  }
> 
> > Again, there shouldn't be two function for the same job. There should be
> > only purge_dirat() and the tst_purge_dir() should call purge_dirat()
> > with AT_FDCWD as the dirfd.
> 
> +1. That is what I meant by "it'd be nice if we could use only rmobjat()" in v1.
> 
> > >  	} else {
> > > -		if (unlink(obj) < 0) {
> > > +		if (unlinkat(dir_fd, obj, 0) < 0) {
> > >  			if (errmsg != NULL) {
> > > -				sprintf(err_msg,
> > > -					"unlink(%s) failed; errno=%d: %s", obj,
> > > +				snprintf(err_msg, sizeof(err_msg),
> > > +					"unlinkat(%s) failed; errno=%d: %s", obj,
> > >  					errno, tst_strerrno(errno));
> > >  				*errmsg = err_msg;
> > >  			}
> > > @@ -305,7 +339,7 @@ void tst_tmpdir(void)
> > >  		tst_resm(TERRNO, "%s: chdir(%s) failed", __func__, TESTDIR);
> 
> > >  		/* Try to remove the directory */
> > > -		if (rmobj(TESTDIR, &errmsg) == -1) {
> > > +		if (rmobjat(0, TESTDIR, &errmsg) == -1) {
> > >  			tst_resm(TWARN, "%s: rmobj(%s) failed: %s",
> > >  				 __func__, TESTDIR, errmsg);
> > >  		}
> > > @@ -343,7 +377,7 @@ void tst_rmdir(void)
> > >  	/*
> > >  	 * Attempt to remove the "TESTDIR" directory, using rmobj().
> > >  	 */
> > > -	if (rmobj(TESTDIR, &errmsg) == -1) {
> > > +	if (rmobjat(0, TESTDIR, &errmsg) == -1) {
> > >  		tst_resm(TWARN, "%s: rmobj(%s) failed: %s",
> > >  			 __func__, TESTDIR, errmsg);
> > >  	}
> 
> > We should pass AT_FDCWD to the two rmobjat() here since it's possible to
> > pass relative path in the TMPDIR environment variable. Otherwise the
> > code will not work with e.g. TMPDIR="." ./test_foo
> 
> Very good catch. BTW we expect TMPDIR to be correct - without double quotes and
> trailing '/' which are example for shell tests which lead to failures in LTP
> NFS tests. That was fixed in:
> 
> 273c497935 ("tst_test.sh: Remove possible double/trailing slashes from TMPDIR")
> 
> Wouldn't be better just to normalize relative TMPDIR to absolute path? Simple
> realpath() would do the job, right?
> 
> e.g. this patch "swapon03: Remove grep dependency" [1] + fix attempt to swapoff
> leftover from previous run (when one does ctrl+C in previous run) expect that
> TMPDIR is absolute. I'll note it below the patch that either we change
> lib/tst_tmpdir.c to convert relative to absolute, or swapon03.c test needs to do
> it itself. I would prefer lib/tst_tmpdir.c do the job including normalizing the
> path (more tests will benefit/need it).
Also i guess we need use another patch for this?
> 
> Kind regards,
> Petr
> 
> [1] https://lore.kernel.org/ltp/20251106163500.1063704-6-pvorel@suse.cz/
> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
