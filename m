Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEA50C369A5
	for <ltp@archiver.kernel.org>; Wed,  9 Apr 2025 06:41:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CABD23CB3EF
	for <ltp@archiver.kernel.org>; Wed,  9 Apr 2025 08:41:56 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A5B373C9AB7
 for <ltp@lists.linux.it>; Wed,  9 Apr 2025 08:41:39 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=uniontech.com (client-ip=54.206.16.166; helo=smtpbgau1.qq.com;
 envelope-from=lufei@uniontech.com; receiver=lists.linux.it)
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 6197B1A0065B
 for <ltp@lists.linux.it>; Wed,  9 Apr 2025 08:41:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
 s=onoh2408; t=1744180891;
 bh=CoDAr+YoNgJUBUbAPNGvCm0gwUYBwP4WU0Uk6rN9VKs=;
 h=Date:From:To:Subject:Message-ID:MIME-Version;
 b=hCYsp764DsM5MTiO4kGUimas+E/vhvRLAyb89itn+EyHutiyXeg0nD2Bb5b+oqpR2
 BIQZu8J4wRJgFaWidZHh3Dbg3tiFhqTFWC+mR5hHJxPz06QZWONy6EYzUGbRbuRNbs
 p8JE7cdr82IHuAl9wL5Y8XFPCWXw7Tszcwo7Hr88=
X-QQ-mid: izesmtpsz20t1744180889tfa7ac3
X-QQ-Originating-IP: To5G0KssW50htqW8jl1tm34E2C9Ap+eR1Bz8xKAbliI=
Received: from rocky ( [125.76.217.162]) by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 09 Apr 2025 14:41:26 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16235443171166151805
Date: Wed, 9 Apr 2025 14:41:25 +0800
From: Lu Fei <lufei@uniontech.com>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <A72C8C5EE58EBAD0+Z/YWlRZxk8yr5yXM@rocky>
References: <20250314044257.1673303-1-lufei@uniontech.com>
 <Z-u7yYJpTBG8Hi6A@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Z-u7yYJpTBG8Hi6A@yuki.lan>
X-QQ-SENDSIZE: 520
Feedback-ID: izesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-0
X-QQ-XMAILINFO: MDqtQ4jGWXAG7Zd+gfrNScabFyFDjc/H0igcjMnXyEGqTPARJxjK7Xte
 tOcslGW6uluhrjg5ldDoyGqm4vBYO1LkPCHw0bwnGCtsBghoz++j/RQ24chgX6i4ApU7XD4
 E8KoO/6bLi+NIOULcbMGuJlyzXtCbIPgI3x/w4+72nA9sVMfV6f+FPO2fmWvKEAWc31w4Mt
 698iuSftuldi+4Z3X3nY0XN0kGymnD8PQkNjKso+wrZEoc5M1xYtFzlwSwcdwF7abi54Ihg
 1/NxNV37/56AVoPLcGCML910LctNDuX/4oPTjnn32e1choperwGY4AsbDLeXSK9ViVfsB2g
 Us8S/FUphmCO4jCTQoXhnGcCCXso89kK78PGGdczi0RmytrtOBxgFvwGba4lmhvMSN340G1
 Xu3fbcldsT8MrfGSxT/xn4f5jlUqjMHsVjuicYEypfUNOXehff1qPIhO8jNaBossqVB8Fls
 oR4UmH2xrjila9Jg9oECY4BAkSAr63wh/Tf5KRmsXANMyvjuBI6HwEh1KRe/5asddRp+JOW
 Bbocg6ea2radzSOsdfafHj3P2bTLm39Tho96+nwJ9WVvpvWx5m8WxUBanx3+OgieQq5NDO9
 gYw5vRcpZhlfnEk1RAWT0IUoLMCyk85rnnLmJ4aaFkCCXk0Udp9kT/oFXfD9B1vshMhz7Nj
 AZLKwi09rvfXEd3/rHyxH9sOBNb0lOsS2jPzLQaLTiLzQ8z8KpDbUs+HZHAi1Kd8FEsfhPH
 R9JbPxc3BQTnfoG5UGnP+UblsHItSrCjFy4UyN1y4cYzmdsUvoqbjHKcDJb8uoe9CkEPKTE
 lLtypjz7WfUfXMTtXgjc1JDByLUn+UovYczzx9CWLuWqKiKI7Kr7aXKEtBpFWEiNB9ygIUs
 QcBDBlUMKNOkIppEgv2OCNL9rSIQHsC3QR5dhK+Y4paxOFbthPTBM34vDk9brk7IRoeQzhX
 ofZpB2pRolZMa1E+TH4+RD/cqQn5O4+J3jqY=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] unshare03: using soft limit of NOFILE
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
Cc: ltp <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi, Cyril

Thanks very much for the smart suggestion. I'll submit a v2 patch.

On Tue, Apr 01, 2025 at 12:11:21PM +0200, Cyril Hrubis wrote:
> Hi!
> > I think it's safer to set NOFILE increasing from soft limit than from
> > hard limit.
> > 
> > Hard limit may lead to dup2 ENOMEM error which bring the result to
> > TBROK on little memory machine. (e.g. 2GB memory in my situation, hard
> > limit in /proc/sys/fs/nr_open come out to be 1073741816)
> > 
> > Signed-off-by: lufei <lufei@uniontech.com>
> > ---
> >  testcases/kernel/syscalls/unshare/unshare03.c | 14 ++++++--------
> >  1 file changed, 6 insertions(+), 8 deletions(-)
> > 
> > diff --git a/testcases/kernel/syscalls/unshare/unshare03.c b/testcases/kernel/syscalls/unshare/unshare03.c
> > index 7c5e71c4e..bb568264c 100644
> > --- a/testcases/kernel/syscalls/unshare/unshare03.c
> > +++ b/testcases/kernel/syscalls/unshare/unshare03.c
> > @@ -24,7 +24,7 @@
> >  
> >  static void run(void)
> >  {
> > -	int nr_open;
> > +	int rlim_max;
> >  	int nr_limit;
> >  	struct rlimit rlimit;
> >  	struct tst_clone_args args = {
> > @@ -32,14 +32,12 @@ static void run(void)
> >  		.exit_signal = SIGCHLD,
> >  	};
> >  
> > -	SAFE_FILE_SCANF(FS_NR_OPEN, "%d", &nr_open);
> > -	tst_res(TDEBUG, "Maximum number of file descriptors: %d", nr_open);
> > +	SAFE_GETRLIMIT(RLIMIT_NOFILE, &rlimit);
> > +	rlim_max = rlimit.rlim_max;
> >  
> > -	nr_limit = nr_open + NR_OPEN_LIMIT;
> > +	nr_limit = rlim_max + NR_OPEN_LIMIT;
> >  	SAFE_FILE_PRINTF(FS_NR_OPEN, "%d", nr_limit);
> >  
> > -	SAFE_GETRLIMIT(RLIMIT_NOFILE, &rlimit);
> > -
> >  	rlimit.rlim_cur = nr_limit;
> >  	rlimit.rlim_max = nr_limit;
> >  
> > @@ -47,10 +45,10 @@ static void run(void)
> >  	tst_res(TDEBUG, "Set new maximum number of file descriptors to : %d",
> >  		nr_limit);
> >  
> > -	SAFE_DUP2(2, nr_open + NR_OPEN_DUP);
> > +	SAFE_DUP2(2, rlim_max + NR_OPEN_DUP);
> >  
> >  	if (!SAFE_CLONE(&args)) {
> > -		SAFE_FILE_PRINTF(FS_NR_OPEN, "%d", nr_open);
> > +		SAFE_FILE_PRINTF(FS_NR_OPEN, "%d", rlim_max);
> >  		TST_EXP_FAIL(unshare(CLONE_FILES), EMFILE);
> >  		exit(0);
> >  	}
> 
> Why do we bother with reading the /rpoc/sys/fs/nr_open file? All that we
> need to to do is to dup() a file descriptor and tnen set the nr_open
> limit to fd - 2. And if we do so we can drop the rlimit that increases
> the limit so that it's greater than nr_open as well.
> 
> -- 
> Cyril Hrubis
> chrubis@suse.cz
> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
