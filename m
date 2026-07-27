Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CEF8C53200
	for <ltp@archiver.kernel.org>; Mon, 27 Jul 2026 02:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1785119234; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=lYPyDiKiP3clTaDSV++O/9v/FKIc5eGdDiCt0ZAezek=;
 b=PM7DuZdMpFefIeBv3Q5U+VyjwBP3qh+phELQFXwsDUhFljvZ6xafIhjuA9b7OMoQlTmMF
 jv+rKlJWoPKL3P78eUBmMaYMmCh9jcLq8P5JQo1KKp9u4WehlLHiBkGSHfjGJU3zkz9a+pQ
 +uUlMJv0eNEJPDGCkyVkvoIIk3pBCnU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6639C3E1BDB
	for <ltp@archiver.kernel.org>; Mon, 27 Jul 2026 04:27:14 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 793BD3C2A5A
 for <ltp@lists.linux.it>; Mon, 27 Jul 2026 04:26:54 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id BD65C60056A
 for <ltp@lists.linux.it>; Mon, 27 Jul 2026 04:26:53 +0200 (CEST)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-493f6de72faso18261805e9.0
 for <ltp@lists.linux.it>; Sun, 26 Jul 2026 19:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1785119213; x=1785724013; darn=lists.linux.it;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:to:from:date:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9P70xtExkT7jD8yJi+nkUlRtnACnYSLWERU1BKq4ysI=;
 b=Of/Xg/TFznGDDlbM56t2njLUCzgyB9cgzxltm8ZgnGlPvlnIQLAaTc6q7qjPkmRQtO
 +UEStUiyOu3z0R/RySt0GNGSN6Y7Z/IkZb5DR1QombgMV+hA03HaWK4K+7/yfc4llXML
 5oPGhibrIL6N6fhmJh3K/Nrz2QCG+fPQQdMrnTs+tIpG07TNqYi+WVs61uK4Spt1ko7J
 KnMWtaJ/DDQuf9kVLrXD/NPBq3hErVbL1JOhwizn1/PKMwiTQdy0LrrBPEadkL9A9AFk
 oLaO+Arc2hAqrNcKAGMVsnSS5hevmBocmIQfH5zzH0Hmilx59E70P5D9je3QG4nxmDCM
 Zbyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785119213; x=1785724013;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9P70xtExkT7jD8yJi+nkUlRtnACnYSLWERU1BKq4ysI=;
 b=icarRsrtSs2eKretrN0XC0kwow/HYDPkGGp0gGfKojH3ht06DVteWW+UkTnSJreg/4
 U8QI511RqYJsyfU2gVMNrcSoiI3Xgh1HcP50XsUUsnpXbo81AOrggoMYnk5huTfHA03d
 bQ2upnj/Z0SiBzTI6KKADSMUnIV9rNxL9/t8pn8caFB93kzxQyOxfk4W62QWiahOLAiV
 rBlMSw+/GImAfH+ooDe3Y2V7SnjnLFd8P2BjkkV8nNpR3kL5sedqCpYw2qKS1X0nglSj
 Wy6Bi7+3n+Cmplf6LoCJliAEZWG632TlB4NF8OkltKX/L61wJ3kYTQ5DsNWl/Tdp49Ot
 cSkA==
X-Gm-Message-State: AOJu0YwMy4BxAxnojVvliU/PK6NlKW6TOhWnsj8xvGvaxJtjVZz8V23/
 Z89z2prZG8VZr5oXXnnkFF7D1/gtNnNRUWrEVbmXgJOAMEX6OyCP1seZKKraPbmcG+z4yvjJzlH
 PgcU=
X-Gm-Gg: AR+sD12g0zDCCDh+9rohYppbyof8EL9j/lUOb5sz6r6j5OwxNFXpLfZWI2DJlov8mVX
 k8x1oEWZle4WnOini4Uy/Uuy8VhlWSR54Fzstrvzm47ApjV/i8qFLHzA6gPraIjCusDFpwz+rBe
 qvytp+m/+ZMiOB/bFZlfQviXlO2TY1Q5fcfwgblBn03g/B9Dovi0hY3lmIP7bF+/kZ8TjH4flhW
 FM4sJDDbljjAjWpPRIB1A0f/mzDVbGJeUn5f42SvdbI/9qj4fewv0K0ZIqMKTBGMvapnSYxvskD
 edk86AFQStVO9EOeXWuZEHxutz9E28/1uXkPH+n9ywsV9KQEcq5Au/mCcdL6DBBKJee/TQ2mCBN
 a0A+o5EfkD8Gi/Edb4lKwpedzrom5NWfR8KL5J0/UPqWedWh620DHrbIojD988T83DXI66Yaa7U
 5aUyw1CczZipG13jPCALI=
X-Received: by 2002:a05:600c:3508:b0:495:5d6d:9cc1 with SMTP id
 5b1f17b1804b1-496b5ab04d0mr82764905e9.0.1785119213124; 
 Sun, 26 Jul 2026 19:26:53 -0700 (PDT)
Received: from autotest-wegao.qe.prg2.suse.org
 ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4957f9b8b67sm228824385e9.4.2026.07.26.19.26.52
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jul 2026 19:26:52 -0700 (PDT)
Date: Mon, 27 Jul 2026 02:26:51 +0000
To: ltp@lists.linux.it
Message-ID: <ambB60YU5s8sdlkZ@autotest-wegao.qe.prg2.suse.org>
References: <20260723075319.4920-1-wegao@suse.com>
 <20260723094647.5051-1-wegao@suse.com> <amMqy0LXX7LFurPo@linux.dev>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <amMqy0LXX7LFurPo@linux.dev>
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] madvise09: Scale cgroup memory/swap limits
 dynamically with page size
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Fri, Jul 24, 2026 at 05:05:15PM +0800, Li Wang wrote:
> Wei Gao via ltp wrote:
> 
> > +	mem_limit = 16 * PAGES * page_size;
> > +	swap_limit = 2 * mem_limit;
> > +
> 
> > +	if (swap_accounting_enabled && (tst_available_swap() < swap_limit / 1024)) {
> > +		tst_brk(TCONF, "System needs at least %lldMB free swap to run this test",
> > +			swap_limit / TST_MB);
> 
> I suspect this available swap size comparison is duplicated with
> .min_swap_avail, and perhaps we can remove BASE_SWAP_LIMIT and
> .min_swap_avail from the test directly.
Thanks, new patch sent.
> 
> >  static struct tst_test test = {
> > @@ -291,6 +301,6 @@ static struct tst_test test = {
> >  	.test_all = run,
> >  	.needs_root = 1,
> >  	.forks_child = 1,
> 
> > -	.min_swap_avail = SWAP_LIMIT / TST_MB,
> > +	.min_swap_avail = BASE_SWAP_LIMIT / TST_MB,
> 
> -- 
> Regards,
> Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
