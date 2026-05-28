Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26BF4CD5BD5
	for <ltp@archiver.kernel.org>; Thu, 28 May 2026 04:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1779943413; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=4TBYDAnJns+Kq8/5qndZiy2jCY/ljTFDLrfhFFX13U4=;
 b=eWs32/TiOmetSYZNCQU1AtEFjuIelB+xzrFngS8f50T93wJskqCr00GHltE4xYyRnJyDW
 m8rD/jxGBJq2wk8IYN80pGQ3K3gKaO6Q9m9SERUk+qEzfdjK8sMotD/QgHwYGJLsf2QOyVM
 9P4tDMQqdTXkUKO43X7vCdJaq8f3l/E=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1222C3CD53A
	for <ltp@archiver.kernel.org>; Thu, 28 May 2026 06:43:33 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4BDC63C58CC
 for <ltp@lists.linux.it>; Thu, 28 May 2026 06:43:09 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C130510001B5
 for <ltp@lists.linux.it>; Thu, 28 May 2026 06:43:08 +0200 (CEST)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4904127c32cso38772385e9.2
 for <ltp@lists.linux.it>; Wed, 27 May 2026 21:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1779943388; x=1780548188; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=w5UnpFivBOrG2RDvU81/7thK+QAemoW+0VYQsQp6Qbo=;
 b=VCyADa2SWjPh0Ogqs3AwM2Ev/px2uojfpkJjvGQVjrZQ50Jo7Da3T93GTUwixoXRWD
 Po0L885St/7Zlx9FINHpQvz9GoijQbMcggm70mZ2Yk2e6fdzMCMzHEhB16edVbX5FKsq
 JFTz4CK2cf2XJPDhhDLwJJSSWZ9MWc/SwlRnEJWOrcO0IubwuIxDN/gc7vYC68UkFqp4
 2vVDsLU+ccv2pGFfJHOq/FlLwdOE5oTL4lZeDObBUkxb8mol2mJ9i+9gCExzy5re2zv3
 Ji+kaWaH94VCirUSSt0tyedKDRum9wQGN+EmcKTy2yv1qsA3mNmMQN95aCmpkTHfbT4r
 yObQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779943388; x=1780548188;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w5UnpFivBOrG2RDvU81/7thK+QAemoW+0VYQsQp6Qbo=;
 b=ignQQxj+KMN10spXkG+ToQUGq/FTGssMFmJ1DoFb+IwBFuyEI17OX2QFFSDUhJYcWj
 //bqld1AQV8Ye6HcLjExG+OxbgvnKn0RaTQmdzJw9CtxaDrNUHOkLdJsjqYz5xMeJU6z
 YvvFyrW1k8mUmURRjMFVx54pTZ26M6qiyYhy6k7XqqDPvvXO8OvLa+SQ8dbyg7r50qRj
 DOY+JGFK5zDDXwNEh2ES/IrHL+jsdmq3/DAxKzLxqERCOtRDaBBjYdIiAY0gT4lNDCtX
 mkCVfv+0bLu7A1vqk9iIqzoB/pSnXNKnUG+VgdavU8r3AoqBjmrbmpitjYBd7ApjJvEs
 WKsg==
X-Gm-Message-State: AOJu0YwYSY2HrOmMwwCvWhjr0QK2zWx59NRCS5j1etxJ0o2RQMWVfJRI
 myCtkoSl7UaoWaEBwjvg4i/kqHzz2l+afGELG6JJB9iFGhhs96VVXhFvh5GGjJ6uJw==
X-Gm-Gg: Acq92OE6b4tVpBBcTKNZxWorsz0y8BR10DxYwZyoEZyujw8sy6FhEsjzZu+1l4e3Wmr
 iMxxDxUp1yxm3yKOz/n6gB1AMLC9AVD15b66Wb/gm3C25WCcfGdAqkH6qIbnLbkc9H4CFZ9yBpO
 l7BsummDAPuGeKDHjusY/lNiQBYZ0SxM+F/43LCefEU+d2sJ0ZWCkplpJPJTU49qHD0kRjfEFYG
 LTPEK8YmEpD4OrjXETr4jrQCXis85xG6sPU5zqaejXgqbZMipNCt4SnLx3tMgy+knzhuMV3kcuY
 wfdafl6gVvy3TzX/vbAuNu27gGn4//ah88bIscKRr8iB+TCQbyAk/UnLV5IqAjsoNpbsIAkFbEZ
 gBCVVecd3xrSpbSCKDxVghtW0PiDNTawbChjJwhdbRt9NNk/XV0QTjTCYOuloV+ZDRcOhc8EFc9
 2jXzXqjPw0ntqx2D/WxzBoVxcmDtKCo0CADtBjstlxKdUJ7tcBFB4=
X-Received: by 2002:a05:600c:4ecc:b0:48f:d5b2:7c42 with SMTP id
 5b1f17b1804b1-490426d1a21mr403484235e9.17.1779943388179; 
 Wed, 27 May 2026 21:43:08 -0700 (PDT)
Received: from autotest-wegao.qe.prg2.suse.org
 ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4908f0a39e0sm7426515e9.30.2026.05.27.21.43.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 21:43:07 -0700 (PDT)
Date: Thu, 28 May 2026 04:43:05 +0000
To: linuxtestproject.agent@gmail.com
Message-ID: <ahfH2eQUQraR3s2p@autotest-wegao.qe.prg2.suse.org>
References: <20260525090228.11895-2-wegao@suse.com>
 <20260525101254.4042-1-linuxtestproject.agent@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260525101254.4042-1-linuxtestproject.agent@gmail.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] connect01: Convert to new API
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

On Mon, May 25, 2026 at 10:12:54AM +0000, linuxtestproject.agent@gmail.com wrote:
> Hi Wei,
> 
> On Mon, 25 May 2026, Wei Gao wrote:
> > connect01: Convert to new API
> 
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> >  /*
> > - *
> > - *   Copyright (c) International Business Machines  Corp., 2001
> > + * Copyright (c) International Business Machines  Corp., 2001
> > + * Copyright (c) Linux Test Project, 2006-2024
> 
> The patch is from 2026; the LTP copyright year should be updated to 2006-2026.
> 
> > +static int sys_connect(int sockfd, const struct sockaddr *addr,
> > +	socklen_t addrlen)
> 
> Indentation regressed from two tabs to one. The continuation parameter should
> be aligned with the opening parenthesis (or at minimum two tabs to match the
> original), per kernel coding style.
> 
> > +	pid = SAFE_FORK();
> > +
> > +	if (!pid) {
> > +		int nfd = SAFE_ACCEPT(fd_server, NULL, NULL);
> > +
> > +		SAFE_CLOSE(nfd);
> > +		exit(0);
> > +	}
> > +	close(fd_server);
> 
> Use SAFE_CLOSE() here for consistency.
> 
> [...]
> 
> --- [PATCH 2/2] connect01: Add negative tests ---
> 
> > +	fd_unix_server = SAFE_SOCKET(AF_UNIX, SOCK_STREAM, 0);
> > +	SAFE_BIND(fd_unix_server, (struct sockaddr *)&sock4, sizeof(sock4));
> > +	SAFE_LISTEN(fd_unix_server, 5);
> > +
> > +	fd_unix_dgram = SAFE_SOCKET(AF_UNIX, SOCK_DGRAM, 0);
> > +	fd_unix_stream = SAFE_SOCKET(AF_UNIX, SOCK_STREAM, 0);
> > +
> > +	pw = SAFE_GETPWNAM("nobody");
> 
> The EACCES test relies on "nobody" not having write permission to SOCK_FILE.
> The socket file's permissions are umask-dependent; with umask 0000 the file
> gets mode 0777 and the test would fail spuriously. Add an explicit
> `SAFE_CHMOD(SOCK_FILE, 0700)` after the SAFE_BIND() to make this reliable.
> 
> > +	if (tc->exp_errno == EACCES) {
> > +		if (!SAFE_FORK()) {
> > +			SAFE_SETUID(pw->pw_uid);
> > +			TST_EXP_FAIL(sys_connect(*tc->fd, addr, tc->salen),
> > +				tc->exp_errno, "%s", tc->desc);
> > +			exit(0);
> > +		}
> 
> Result propagation via shared memory with .forks_child = 1 is correct, but
> the exit code is always 0 even on failure. Use `tst_exit()` or exit with the
> appropriate code so that unexpected crashes are also caught by the parent.
> Alternatively this is a style nit if tst_exit() is not the expected pattern
> here.
I think TST_EXP_FAIL already report failure so exit(0) is acceptable.
> 
> ---
> Note:
> 
> Our agent completed the review of the patch. The full review can be
> found at: https://github.com/linux-test-project/ltp-agent/actions/runs/26394925194
> 
> The agent can sometimes produce false positives although often its
> findings are genuine. If you find issues with the review, please
> comment this email or ignore the suggestions.
> 
> Regards,
> LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
