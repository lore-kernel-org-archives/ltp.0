Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8A81C25B78
	for <ltp@archiver.kernel.org>; Tue, 28 May 2024 07:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1716883084; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=6fFgi9a2DsMCjzB105R7XylS/IuG+aU+KZLDdeyZbgw=;
 b=CL9VfoXjTX3l3noyTyYzmrNREOdQznnpaqHbwS2T6Ib1UwEJll0gPlQ2wHekdxP1WeBfQ
 AT9iuQ7kuKuN3Pq9frAccZD87Ldvws0KkzuumqzZ4CeyQIAxqigMR5bvep53idmivukwA2D
 Mt3P5NPABFbce5m5+Z5EmY6hXuACeHE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 29D643D0485
	for <ltp@archiver.kernel.org>; Tue, 28 May 2024 09:58:04 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7BC073C286E
 for <ltp@lists.linux.it>; Tue, 28 May 2024 09:57:42 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B9E6A201746
 for <ltp@lists.linux.it>; Tue, 28 May 2024 09:57:41 +0200 (CEST)
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5755fafa5a7so615128a12.1
 for <ltp@lists.linux.it>; Tue, 28 May 2024 00:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1716883061; x=1717487861; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=SCzvrJRtAoJCdhx3WaTZs6QJvRBJ91ruUIvom732FTY=;
 b=PPYgg4imE0GLWa2e6HG5kW60QMEsHGGuvHfwy8dC8z+t4kN8SsHujQnQdusA79+Nh8
 UVQuN2SgBD8L/Mli+AK8nEC/P1ffnOwbuzIJhamdDbRhG76xprSj9qe+VTnmHGupU6Pj
 HZSpKVoF4RO4xfJ05AoDP8gmzI6eNRlGOv/5jnf1os5L5NcIPKijvqXr8+mLUVhhY//w
 wEWhTXrj3v4ry4rXYFdHkxSj/oqdvuAUW7zCvL/5+qECZNJKagku0p00w5aLuIJHiW4Y
 t1bi9gocSe8vNGCgXyKHkcO/qcQl62TWS15g9JUBsy7hsPfqgkXmoMAKBNFsm7Hr63R1
 VE4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716883061; x=1717487861;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SCzvrJRtAoJCdhx3WaTZs6QJvRBJ91ruUIvom732FTY=;
 b=OQbA7XJ5K6/kkv+JxtEik8jpGbZ5RGUYIjpvnE2dNyi6xigWbpGnSbHxvhDMhLKoE1
 3mEsdV+IVSrMZBoVPUV0OoBpEGf8CpfmDRw96oktNFbges2t81erpZI/hIJSj59o3Lty
 NfpIgqUFIZ2skT219kdRP486ND5/CFVAXIz9ekuIqw7QYLp7BH+2p4VDD99ckAxMNRUR
 LjmptSzgVny2tpvIyz+fAYtZVmF94ynx1bAgVkXlgDrIs+VCiRkfOzQArK7Ob7nWhTof
 2yvJjmxdO+i4LlW+yXv0/v93XX3SxC1rhhi9mJgTJAYG8QnFHJ+LDbJQDJ/xosoF5u/n
 CkyA==
X-Gm-Message-State: AOJu0YwCkr0eurgdpa9nw8MsqTRtjEZNLYscimmtTF3ksnL7w/C/jn+f
 snUTpmJ14I06aodaR2elD/M6cWzmyPXADlKdvgvv3n8VrW8rx0qRjp4kLEaUYDR3xTYdwR9XS40
 =
X-Google-Smtp-Source: AGHT+IHlchI6D2YxZPex6CwtHM/gLnFqYy45wCUg3lnMoFWVGlYwPitvpJev6skYEiHZleI1Vlwt2g==
X-Received: by 2002:a50:aa96:0:b0:578:ac24:7f77 with SMTP id
 4fb4d7f45d1cf-578ac33c7damr4644067a12.16.1716883061177; 
 Tue, 28 May 2024 00:57:41 -0700 (PDT)
Received: from wegao.118.84.169 ([2a07:de40:b240:0:dc1a:df90:dc1a:df90])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-578523d3967sm6980521a12.42.2024.05.28.00.57.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 00:57:40 -0700 (PDT)
Date: Tue, 28 May 2024 03:57:30 -0400
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZlWOanW7suKrYJsu@wegao.118.84.169>
References: <20240527063346.289771-1-pvorel@suse.cz>
 <20240527063346.289771-3-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240527063346.289771-3-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 02/15] recv{, from,
 msg}01: Remove kernel >= 3.17 check
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

On Mon, May 27, 2024 at 08:33:33AM +0200, Petr Vorel wrote:
> Since 9e9654cf2 LTP supports kernel >= 4.4.
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
Reviewed-by: Wei Gao <wegao@suse.com>
> ---
>  testcases/kernel/syscalls/recv/recv01.c         | 8 --------
>  testcases/kernel/syscalls/recvfrom/recvfrom01.c | 8 --------
>  testcases/kernel/syscalls/recvmsg/recvmsg01.c   | 7 -------
>  3 files changed, 23 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/recv/recv01.c b/testcases/kernel/syscalls/recv/recv01.c
> index d71243c30..bb2578355 100644
> --- a/testcases/kernel/syscalls/recv/recv01.c
> +++ b/testcases/kernel/syscalls/recv/recv01.c
> @@ -113,14 +113,6 @@ int main(int argc, char *argv[])
>  	for (lc = 0; TEST_LOOPING(lc); ++lc) {
>  		tst_count = 0;
>  		for (testno = 0; testno < TST_TOTAL; ++testno) {
> -			if ((tst_kvercmp(3, 17, 0) < 0)
> -			    && (tdat[testno].flags & MSG_ERRQUEUE)
> -			    && (tdat[testno].type & SOCK_STREAM)) {
> -				tst_resm(TCONF, "skip MSG_ERRQUEUE test, "
> -						"it's supported from 3.17");
> -				continue;
> -			}
> -
>  			tdat[testno].setup();
>  			TEST(recv(s, tdat[testno].buf, tdat[testno].buflen,
>  				  tdat[testno].flags));
> diff --git a/testcases/kernel/syscalls/recvfrom/recvfrom01.c b/testcases/kernel/syscalls/recvfrom/recvfrom01.c
> index f26f85688..6ce9f1bde 100644
> --- a/testcases/kernel/syscalls/recvfrom/recvfrom01.c
> +++ b/testcases/kernel/syscalls/recvfrom/recvfrom01.c
> @@ -137,14 +137,6 @@ int main(int argc, char *argv[])
>  	for (lc = 0; TEST_LOOPING(lc); ++lc) {
>  		tst_count = 0;
>  		for (testno = 0; testno < TST_TOTAL; ++testno) {
> -			if ((tst_kvercmp(3, 17, 0) < 0)
> -			    && (tdat[testno].flags & MSG_ERRQUEUE)
> -			    && (tdat[testno].type & SOCK_STREAM)) {
> -				tst_resm(TCONF, "skip MSG_ERRQUEUE test, "
> -						"it's supported from 3.17");
> -				continue;
> -			}
> -
>  			tdat[testno].setup();
>  			TEST(recvfrom(s, tdat[testno].buf, tdat[testno].buflen,
>  				      tdat[testno].flags, tdat[testno].from,
> diff --git a/testcases/kernel/syscalls/recvmsg/recvmsg01.c b/testcases/kernel/syscalls/recvmsg/recvmsg01.c
> index 80c1b3aa9..a265bc3bd 100644
> --- a/testcases/kernel/syscalls/recvmsg/recvmsg01.c
> +++ b/testcases/kernel/syscalls/recvmsg/recvmsg01.c
> @@ -220,13 +220,6 @@ static void run(unsigned int n)
>  	struct tcase *tc = &tcases[n];
>  	int ret = tc->exp_errno ? -1 : 0;
>  
> -	if ((tst_kvercmp(3, 17, 0) < 0)
> -			&& (tc->flags & MSG_ERRQUEUE)
> -			&& (tc->type & SOCK_STREAM)) {
> -		tst_res(TCONF, "MSG_ERRQUEUE requires kernel >= 3.17");
> -		return;
> -	}
> -
>  	setup_all();
>  	tc->setup(n);
>  
> -- 
> 2.43.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
