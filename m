Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63661CD4F54
	for <ltp@archiver.kernel.org>; Wed, 27 May 2026 05:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1779858517; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=EC6mxuElGjqG1H5MM849uD/khyUEkWnUEXAY0HvCrTE=;
 b=VEkGAOe1aUA0f9EjeoALmv4hLUy/WKnTEq7dM56cZy5oFuPQ6Q/KQgOR82IotjxslL8pp
 8TUhADZ5cRFLWlFEEON5RRUvzRMgN3HOWrBOsCxUllfbFz0QYU760PPJ0QL2RKDAkb+WGpH
 Hm8twJWG6H5hjdeNkUSW/auWBVeSMr4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 443E13C71E0
	for <ltp@archiver.kernel.org>; Wed, 27 May 2026 07:08:37 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 28FDA3C5E23
 for <ltp@lists.linux.it>; Wed, 27 May 2026 07:08:13 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 46ED4600A08
 for <ltp@lists.linux.it>; Wed, 27 May 2026 07:08:13 +0200 (CEST)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-43d73422431so7981658f8f.2
 for <ltp@lists.linux.it>; Tue, 26 May 2026 22:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1779858492; x=1780463292; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=j0gba58rBQ0vTexI/P5+rj/2iLGyGrGGOxNSeFoi33I=;
 b=CSMmO4GMmeBhSQsZXDIcB9BfEaHHhf9hZ+EwSaSkIpIPT1uK5KMbRXGTaRu2LMD+Dy
 WHjmA3pgRjkFQZa8+abdZcCo7bDs5MaNCq5IDpSG61INVGnmt2+X8Ke+f62YRTxoKzHY
 c0lepQUejMbzmmJZ7nX2juHOKBWrZunqM483wvlI7CYEUW6ebFTLWaQrtGRS3gm+4ZEa
 fQKxwvIhonOAd8a6D9vol/6bCkoeaHJqqBt8kJ+GeXPsgtZ56O2uHBoz9ykUQ4yuycEw
 zHtjusXoavVYyHHdLQn/nKChuQvKgQazgMMoTgrFYkOXghuylkomBxyUpStx/owX9xjb
 xkTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779858492; x=1780463292;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j0gba58rBQ0vTexI/P5+rj/2iLGyGrGGOxNSeFoi33I=;
 b=UzATWUCAJ2Re5ggf9RV18xiw+ojv7aay9hFYkMMfEEJRdy1+wMvF7h3qTKADg4qGbW
 6h5mL9Vf2csRQxGqQ43RrJ+AoteBxbKH1Ca2g9BP3KYZdDYUSPyh6pV+QMlkIEuCEJir
 NErQvXSd5EuCQd+sd0/+X37UEEgC+DS4rskieS0FrrvmrN/xwAfj+l9QGRMQd5vzpi0w
 CKgrR5UbPY8f7HkuLE/FEp3za4O24jMvbjsvoE0RA3X8fetpvZmSyaYISdDheZ6hKWSC
 u9Wa0rq9dDUrUJsnB6+TlyKlURfzeKwpzF9hauut5/TBufTGRFnmDr1uo6LhWBuIaF/W
 jrxg==
X-Gm-Message-State: AOJu0Yy/XWKYvYkESmSHAvSVsEqcJRDw6VsM3ke/2Wk4GoLHCkAs3LZK
 XltOodrY8Pl39JqdWW531agPXUFFpmVUpfM4QEMHmbgYWDTzRx/ROsTOZynSWIy9eg==
X-Gm-Gg: Acq92OF6qCP9blBpLkrqWHHJqmuIPg6ydd+gqsGVw6kUz3f51wVKZW7XdLL2rDxEfUB
 X6gJh65b8s31jbbHlafHJOmU78M5Y7fVXMc9Qobpop8s8Zw73h2xvLIKl55hkMbCrsOnAZJHnFF
 Qi1tDu6POe76bZ8FMcTeDkC228f8pzakujhu+vvR/+V1AOPKxYHgpkYtnRl1/sALQdyXdNi9mQx
 nk1iXeZyhj0s7yF4TtS8EijWcNaMAmTGy0DiZ0oNxni9f5bIEmGugZceIaUw1FVHcFWr/WuBTQu
 DiIfkrqlOZfN4wTSXaE5njpGs1i5NYQOL20PAMOCuE1GSXKvM8TtZTRisyRwW/iayd5rtPxF/X4
 9/I7yU2QB+YfZgpUYY0rHBPT523Bk1qKRhCxNA+Jl3cSczv2BJyAHrzxTwKfWzUwEMQPSUjJjxU
 tEDgRXI/w75AtKu1BHCaIB8ifRHy5IzWpnQ3zzRM7A
X-Received: by 2002:a05:6000:480f:b0:45e:779a:302f with SMTP id
 ffacd0b85a97d-45eb36910f5mr34778455f8f.14.1779858492543; 
 Tue, 26 May 2026 22:08:12 -0700 (PDT)
Received: from autotest-wegao.qe.prg2.suse.org
 ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45edb5b2bbfsm3578765f8f.32.2026.05.26.22.08.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 22:08:12 -0700 (PDT)
Date: Wed, 27 May 2026 05:08:10 +0000
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ahZ8OiX2UHj02IML@autotest-wegao.qe.prg2.suse.org>
References: <20260526083650.14036-1-wegao@suse.com>
 <20260526141054.GA175193@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260526141054.GA175193@pevik>
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] min_free_kbytes: Handle transient memory drops
 in check_monitor
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

On Tue, May 26, 2026 at 04:10:54PM +0200, Petr Vorel wrote:
> Hi Wei,
> 
> > High memory pressure can cause MemFree to temporarily drop below the
> > min_free_kbytes threshold before the kernel reclaimer can catch up.
> > This results in intermittent test failures, particularly observed on
> > openQA aarch64 machines.
> 
> > Implement a 1-second grace period with exponential backoff polling
> > (from 1ms up to 512ms) in check_monitor() to allow the kernel time to
> > reclaim memory.
> 
> > Also the global 'end' flag is reset for multi-iteration
> > support (-i).
> IMHO this is not needed. Is it just wrong AI hint or you really spot it's
> needed?
Yes, reset 'end' flag is not needed, AI indeed complain wrong hint
firstly and later take this as defence programing.
> 
> > Signed-off-by: Wei Gao <wegao@suse.com>
> > ---
> >  .../kernel/mem/tunable/min_free_kbytes.c      | 36 +++++++++++++------
> >  1 file changed, 26 insertions(+), 10 deletions(-)
> 
> > diff --git a/testcases/kernel/mem/tunable/min_free_kbytes.c b/testcases/kernel/mem/tunable/min_free_kbytes.c
> > index a62e4ae9d..59ba6a9e1 100644
> > --- a/testcases/kernel/mem/tunable/min_free_kbytes.c
> > +++ b/testcases/kernel/mem/tunable/min_free_kbytes.c
> > @@ -1,6 +1,6 @@
> >  // SPDX-License-Identifier: GPL-2.0-or-later
> >  /*
> > - * Copyright (c) Linux Test Project, 2012-2025
> > + * Copyright (c) Linux Test Project, 2012-2026
> >   * Copyright (C) 2012-2017  Red Hat, Inc.
> >   */
> 
> > @@ -53,6 +53,8 @@ static void min_free_kbytes_test(void)
> >  	int pid, status;
> >  	struct sigaction sa;
> 
> > +	end = 0;
> Why I think it's not needed? Here you're in the parent. But the value is changed
> only in child (forked process), they run in a separate memory spaces (change in
> child is not visible for the parent).
> 
> In patch without it + updated commit message you may add:
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> 
> > +
> >  	sa.sa_handler = sighandler;
> >  	if (sigemptyset(&sa.sa_mask) < 0)
> >  		tst_brk(TBROK | TERRNO, "sigemptyset");
> > @@ -140,14 +142,13 @@ static void test_tune(unsigned long overcommit_policy)
> >  		} else {
> >  			if (WIFEXITED(status)) {
> >  				if (WEXITSTATUS(status) != 0) {
> > -					tst_res(TFAIL, "child unexpectedly "
> > -						 "failed: %d", status);
> > +					tst_res(TFAIL, "child unexpectedly failed: %d",
> > +						status);
> >  				}
> >  			} else if (!WIFSIGNALED(status) ||
> >  				   WTERMSIG(status) != SIGKILL) {
> > -				tst_res(TFAIL,
> > -					 "child unexpectedly failed: %d",
> > -					 status);
> > +				tst_res(TFAIL, "child unexpectedly failed: %d",
> > +					status);
> >  			}
> Unrelated cleanup, but thanks.
> 
> >  		}
> >  	}
> > @@ -183,18 +184,33 @@ static void check_monitor(void)
> >  {
> >  	unsigned long tune;
> >  	unsigned long memfree;
> > +	int i;
> 
> >  	while (!end) {
> >  		memfree = SAFE_READ_MEMINFO("MemFree:");
> >  		tune = TST_SYS_CONF_LONG_GET(MIN_FREE_KBYTES);
> 
> >  		if (memfree < tune) {
> > -			tst_res(TINFO, "MemFree is %lu kB, "
> > -				 "min_free_kbytes is %lu kB", memfree, tune);
> > -			tst_res(TFAIL, "MemFree < min_free_kbytes");
> > +			/*
> > +			 * Give it some time to reclaim. The kernel should keep
> > +			 * MemFree above min_free_kbytes, but transient drops
> > +			 * are possible under high pressure.
> > +			 */
> > +			for (i = 1; i < 1024; i *= 2) {
> > +				usleep(i * 1000);
> > +				memfree = SAFE_READ_MEMINFO("MemFree:");
> > +				if (memfree >= tune)
> > +					break;
> > +			}
> > +
> > +			if (memfree < tune) {
> > +				tst_res(TINFO, "MemFree is %lu kB, min_free_kbytes is %lu kB",
> > +					memfree, tune);
> > +				tst_res(TFAIL, "MemFree < min_free_kbytes");
> > +			}
> >  		}
> 
> > -		sleep(2);
> > +		usleep(100000);
> >  	}
> >  }

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
