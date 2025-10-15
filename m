Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13F7CCCD194
	for <ltp@archiver.kernel.org>; Wed, 15 Oct 2025 15:00:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8BBBE3CED66
	for <ltp@archiver.kernel.org>; Wed, 15 Oct 2025 17:00:32 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 53FAB3CED26
 for <ltp@lists.linux.it>; Wed, 15 Oct 2025 17:00:16 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id EB6C5600BB9
 for <ltp@lists.linux.it>; Wed, 15 Oct 2025 17:00:15 +0200 (CEST)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-46e384dfde0so68153755e9.2
 for <ltp@lists.linux.it>; Wed, 15 Oct 2025 08:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760540415; x=1761145215; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Fj/YJs79C9A7+BXS5gs9kbo/SiSelT/8YXKJWpgoQSI=;
 b=SQszpZQzC5mIS8lQTgwWcR4Hu9B6PfVxiHeUHK4/nqW7HRGO5QyxMxz169JBOon3Qc
 FVroKhm1kFa6pNUTscKMmWDh5LVz5OcD9TTVuFZBePMLmDRtkrnvI8+wzEzEo1LOSLUW
 dPYcN4Utuqk8FOsYM0mcaiQpvnUSIaYmsVTEWf1WZ1wxsmX5UFX4T2Co3KwHaIXTXXwo
 q+M3R5e00JNzElMcAlKYFA9kVZQQ2EoDRyGS3Fz6vk7fCJSMEdpmEqvsk6+M2p/GpYWh
 hI6OHk0V08iC9oPOPUV127HqVgTVv1iGiDY76mZReEcyc+sgQFp0aBHLFi0J4DxOttvL
 TJig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760540415; x=1761145215;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fj/YJs79C9A7+BXS5gs9kbo/SiSelT/8YXKJWpgoQSI=;
 b=baVNXl6mtYsGCaCXE8lxU+b+m36we/LcUBi4CHdwnSvI0wIbkxqGkfDjXStYOFTSei
 VOwng/KvRQzWHRvMqevTsYHdikPQKypQYpyHDKFcjvoFu7Hz6IBc2bgX77PMbbRKAkqd
 GSOBl/q4NQZEdehddV54HG+cUsNWxXYSrqb/QMpk4MJ8/qZsqIJjHjrRoeospBacdTE0
 NfY86ELJpNIkWXIcaU01zuC4yZspZ1XjS9+qkbMJsRFR1oKiprgzz0ql1veEB1H+6ohk
 M8dGlNacqteB/8CPV2zSVG8wskD1o4IWVyu/6ixvLBreSwPtjhHmRJeTOrIL4vBw3tuA
 6MzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOu4SZWhwuOzKa91QGcThY7vJd3qdqJrF+qMZxmxJj6jxYCcnGOSZGKgUl3F3rinxDzy0=@lists.linux.it
X-Gm-Message-State: AOJu0YxzlPuun+Myz1AFSsx1b4lv/01o5gpx+e1AnKPXUfPAxGsiN+xJ
 PywjU4yLiUGpnd2gAR1X23OcX/ufYFLR4wMINxqUuqXunYSjyfH2m3wnLTd/AWd36ZA=
X-Gm-Gg: ASbGncvWFob/TRkMYwwIhRdyIqwg6vQY84q3KiBMjhtr3kfgn8s6c4pPMGDXiS4Vo3z
 Px0A8iZO0TieJgJ9IZ6NRnX8fWv08X+LXK7NRpNL+/8fVYzZhwTFZWYg1OMQlkK9ZA1/N5jAhwm
 d2HntYFEBzUnBd7RxYxa+eq8/NvJ/zQ6baWcXU54oGeFpAsZmkjYMB3YOH10fnVbefswkGVNbiw
 nocWLkW6eBo2Q4MqAKQb2G9EyptxaOvVPWLigXzd0/V5TAs7sfQrvjc1jHsDaUSKY589CFW70Z+
 ZB/EO86txDISYt+udKYJWWG5kUlHOR6k01TGK6dY1n8QED1WIcNE9ubzKkufoqgPa0pGUFGwhZO
 a4Xh+KLf661dxx521C2xXofSVUtlWIkjKJzBKfeKYVTJQFfSxTvc=
X-Google-Smtp-Source: AGHT+IFTHHmY0rckqJAZ0d0heU4feWXmYlfjR1/4XvkDqgncexcPomkT3HCwt/QeGuSpP8nr2FQf6g==
X-Received: by 2002:a05:600c:3f08:b0:46e:4b42:1dbe with SMTP id
 5b1f17b1804b1-46fa9b075f3mr235127655e9.32.1760540415247; 
 Wed, 15 Oct 2025 08:00:15 -0700 (PDT)
Received: from localhost ([196.207.164.177])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-426ce589a21sm30296201f8f.23.2025.10.15.08.00.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 08:00:14 -0700 (PDT)
Date: Wed, 15 Oct 2025 18:00:10 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <aO-2-tN418z9wDKm@stanley.mountain>
References: <20251015101533.30220-1-ben.copeland@linaro.org>
 <20251015144247.GB220875@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251015144247.GB220875@pevik>
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] overcommit_memory: Fix integer overflow and
 32-bit limits
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
Cc: arnd@arndb.de, lkft-triage@lists.linaro.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, Oct 15, 2025 at 04:42:47PM +0200, Petr Vorel wrote:
> > The overcommit test uses sum_total, the sum (memory and swap) to test
> > the overcommit settings.
> 
> > This fixes two problems on 32-bit systems. The first is seen with a
> > integer overflow can occur when calculating sum_total * 2, if the
> > sum_total is larger than 2GB. The second is limited virtual address
> 
> You still mention GB ...
> 

Yep.  It is GB.

> > space (2-3GB) means the test can fail from address space exhaustion
> > before overcommit has been tested.
> 
> > Now the test runs correctly on low-memory 32-bit systems while avoiding
> > both the overflow bug and virtual address space issues.
> 
> > Signed-off-by: Ben Copeland <ben.copeland@linaro.org>
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > Reviewed-by: Petr Vorel <pvorel@suse.cz>
> > ---
> >  .../kernel/mem/tunable/overcommit_memory.c    | 33 +++++++++++++++----
> >  1 file changed, 27 insertions(+), 6 deletions(-)
> 
> > diff --git a/testcases/kernel/mem/tunable/overcommit_memory.c b/testcases/kernel/mem/tunable/overcommit_memory.c
> > index 9b2cb479d..7ff5a98d0 100644
> > --- a/testcases/kernel/mem/tunable/overcommit_memory.c
> > +++ b/testcases/kernel/mem/tunable/overcommit_memory.c
> > @@ -131,24 +131,45 @@ static void overcommit_memory_test(void)
> >  	TST_SYS_CONF_LONG_SET(OVERCOMMIT_MEMORY, 2, 1);
> 
> >  	update_mem_commit();
> > -	alloc_and_check(commit_left * 2, EXPECT_FAIL);
> > -	alloc_and_check(commit_limit + total_batch_size, EXPECT_FAIL);
> > +	/* Skip tests that would overflow or exceed 32-bit address space */
> > +	if (tst_kernel_bits() == 64 || (unsigned long)commit_left <= TST_GB / TST_KB) {
> 
> ... but TST_GB / TST_KB is actually MB (you could use TST_MB).
> 

The sizes in this test are measured in KB, so it's 1GB but measured in
terms of KB not bytes.  Using TST_MB would work mathematically but it's
misleading.

regards,
dan carpenter


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
