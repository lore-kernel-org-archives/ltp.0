Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36DF1D6B6CE
	for <ltp@archiver.kernel.org>; Wed, 30 Oct 2024 19:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1730317060; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=tth0ZqFs6KE4ZWAd8jPBfPDuXOVdOMFBRDGE2bG1LwQ=;
 b=XX62A44DtslDhwSV+fEKQh9HectGDsTHNNzUWbZLZ3nZrVgWV8JhHOIdCyR1eIHHMrTL5
 716ACMFsQtjS1padP77OeD4qyrd8yzwfgGOoTRKw+Dgaiz5Zaf/ZEsG5PVYWllijEUL32qq
 V2K90Ze9T0eKdQLMT9Lk11n44E1eNc0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 43DA33CB628
	for <ltp@archiver.kernel.org>; Wed, 30 Oct 2024 20:37:40 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E2E6C3CB533
 for <ltp@lists.linux.it>; Wed, 30 Oct 2024 20:37:19 +0100 (CET)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 55DC366B1F8
 for <ltp@lists.linux.it>; Wed, 30 Oct 2024 20:37:18 +0100 (CET)
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-539e7e73740so191845e87.3
 for <ltp@lists.linux.it>; Wed, 30 Oct 2024 12:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1730317037; x=1730921837; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8gJ2+hdMjuQ0By9O036qtrMAQSnOtbM6GPYS2Zvgxnw=;
 b=bedE4QZ/g+PkYGnjim5UzlU4WxVt51gomPSUd/MPAYYcGn8tvIGkxjKsTcoFlsSdi1
 IvEVjAgDSnWI7LgTOmEw1RZXEgXGonsdN84iK0iKC31NWEeyxMTXYc0tTAu6uUwnXaT3
 kHeDOzG/3YdIZp0+7PDhmiIQSv9iTewVxNHIkaJcslUNBojZNZjHtzSwJtkylAULB2mU
 z1lTx+BoytwbOa7744ko/pNdGBMsgC2WJQ4dpM3jJYBEGgptGKQ9c6nMjeRqpC5Q3WeX
 wFi0gLPaq/qIJxUoUDNDIY3N5oxfXPV7BVjHWsktoDBSrW2Zm5PfeIGYywdpNVF7MXwh
 UOdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730317037; x=1730921837;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8gJ2+hdMjuQ0By9O036qtrMAQSnOtbM6GPYS2Zvgxnw=;
 b=dYFTwJJG4NvO91asZ+rNeWLdZXm7GBM21MyihOP55rmFMXYVoccQdA/RGbNoTfpO4f
 aNLdda4ryD+KcqJJfh+PimZ5OO3QiYX/wMeGtdhz9x2HrD4Zrmgg39bqS3eO8qlBe7B4
 O/LwOa5uqtCf6NMSRfsJgF9I+DWN4DL/5+gC4C/SXadjSkx7m0ZBLE1+94io/6Jd2gQh
 KrrtdX1IKElu1ERkDUGPqOLeran8waGMf6TNRjrjE1UxP447T7Yn56ebDwob6b3D/ynT
 deiz7wKABI79Af6KlMgYd1sxFyOgU+pEIQV5ohINSQ+2G+oLdDBeq1C9tnzf6TXEQBsG
 QvdQ==
X-Gm-Message-State: AOJu0Yxd5gV+0JnnVi2QiQQmw57GVC3fzJi5EnVNcUA+licbZgV/hT8N
 SDqATcY3v0gm6eLvKmPbSgxHUCAxflnPEG7954jIe8bh902d+g5YyMKte1U4Lkw=
X-Google-Smtp-Source: AGHT+IF5qwLqXqeCgxFAr0kpzqHEB9Msa8mZvzZyAiTengCH76MBwnzXlGvZXdzsyUKzwZMtORFZuQ==
X-Received: by 2002:a05:6512:33c5:b0:539:d428:fbf2 with SMTP id
 2adb3069b0e04-53b7ecdebbcmr3056342e87.13.1730317037296; 
 Wed, 30 Oct 2024 12:37:17 -0700 (PDT)
Received: from localhost ([179.228.213.26]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-210bc02ee38sm84803745ad.215.2024.10.30.12.37.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Oct 2024 12:37:16 -0700 (PDT)
Date: Wed, 30 Oct 2024 16:37:13 -0300
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <jhkmveftgys6xqoksbk6jfjxexfejhi4qtcxggca5n2egjsuig@wfm3gy6edcuf>
References: <20241025-convert_mmap14-v1-1-6ba672485028@suse.com>
 <20241030162114.GA935480@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241030162114.GA935480@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] mmap14: Convert to new API
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
From: "Ricardo B. Marliere via ltp" <ltp@lists.linux.it>
Reply-To: "Ricardo B. Marliere" <rbm@suse.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr!

On 30 Oct 24 17:21, Petr Vorel wrote:
> Hi Ricardo,
> 
> very nice, few minor things below.
> 
> > Signed-off-by: Ricardo B. Marliere <rbm@suse.com>
> > ---
> >  testcases/kernel/syscalls/mmap/mmap14.c | 97 ++++++++++-----------------------
> >  1 file changed, 30 insertions(+), 67 deletions(-)
> 
> > diff --git a/testcases/kernel/syscalls/mmap/mmap14.c b/testcases/kernel/syscalls/mmap/mmap14.c
> > index 31632601bbed85b60f1dfee7044bf961b1f2a756..63a2f9e4cab2f7ab12b1ad982bc690f9fabcc252 100644
> > --- a/testcases/kernel/syscalls/mmap/mmap14.c
> > +++ b/testcases/kernel/syscalls/mmap/mmap14.c
> > @@ -1,22 +1,12 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> >  /*
> >   * Copyright (c) 2013 FNST, DAN LI <li.dan@cn.fujitsu.com>
> >   *
> nit: blank space above (ideally to remove). You could also add your/SUSE/LTP copyright.
> 
> > - * This program is free software;  you can redistribute it and/or modify
> > - * it under the terms of the GNU General Public License as published by
> > - * the Free Software Foundation; either version 2 of the License, or
> > - * (at your option) any later version.
> > - *
> > - * This program is distributed in the hope that it will be useful,
> > - * but WITHOUT ANY WARRANTY;  without even the implied warranty of
> > - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> > - * the GNU General Public License for more details.
> > - *
> > - * You should have received a copy of the GNU General Public License
> > - * along with this program;  if not, write to the Free Software
> > - * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> >   */
> 
> > -/*
> > +/*\
> > + * [Description]
> > + *
> >   * Test Description:
> >   *  Verify MAP_LOCKED works fine.
> >   *  "Lock the pages of the mapped region into memory in the manner of mlock(2)."
> 
> I would use something like:
> 
> /*\
>  * [Description]
>  *
>  * Verify basic functionality of mmap(2) with MAP_LOCKED.
>  *
>  * mmap(2) should succeed returning the address of the mapped region,
>  * and this region should be locked into memory.
>  */
> 
> Also, having more than one space after '*' causes different formatting in
> auto-generated doc (it will become <pre>...</pre>)
> You can see it if you have asciidoctor (or asciidoc) installed and run
> 
> cd metadata && make
> resulting docs is in ../docparse/*.html
> 
> We publish the docs in releases, e.g.:
> https://github.com/linux-test-project/ltp/releases/download/20240930/metadata.20240930.html

Nice!

> 
> > @@ -28,65 +18,45 @@
> >  #include <stdio.h>
> >  #include <sys/mman.h>
> 
> > -#include "test.h"
> > +#include "tst_test.h"
> 
> >  #define TEMPFILE        "mmapfile"
> >  #define MMAPSIZE        (1UL<<20)
> >  #define LINELEN         256
> 
> > -char *TCID = "mmap14";
> > -int TST_TOTAL = 1;
> > -
> >  static char *addr;
> 
> >  static void getvmlck(unsigned int *lock_sz);
> Ideally you just move getvmlck() code above instead using function signature.
> 
> > +static void run(unsigned int n)
> 
> Here n is unused. That's why you should use void
> 
> static void run(void)
> 
> And below in the struct tst_test test just:
> 	.test_all = run,
> 
> See our old doc (not yet converted to the new format):
> https://github.com/linux-test-project/ltp/blob/master/doc/old/C-Test-API.asciidoc#11-basic-test-structure
> 
> >  {
> >  	unsigned int sz_before;
> >  	unsigned int sz_after;
> >  	unsigned int sz_ch;
> 
> > -		addr = mmap(NULL, MMAPSIZE, PROT_READ | PROT_WRITE,
> > -			    MAP_PRIVATE | MAP_LOCKED | MAP_ANONYMOUS,
> > -			    -1, 0);
> > +	addr = mmap(NULL, MMAPSIZE, PROT_READ | PROT_WRITE,
> > +			MAP_PRIVATE | MAP_LOCKED | MAP_ANONYMOUS,
> > +			-1, 0);
> very nit (just formatting - feel free to reformat the old test):
> 
> 	addr = mmap(NULL, MMAPSIZE, PROT_READ | PROT_WRITE,
> 			MAP_PRIVATE | MAP_LOCKED | MAP_ANONYMOUS, -1, 0);
> 
> > -		if (addr == MAP_FAILED) {
> > -			tst_resm(TFAIL | TERRNO, "mmap of %s failed", TEMPFILE);
> > -			continue;
> > -		}
> > +	if (addr == MAP_FAILED)
> > +		tst_res(TFAIL | TERRNO, "mmap of %s failed", TEMPFILE);
> You need to have return here (like in mmap05.c) to skip the rest of the test.
> In the old API this was achieved by continue.
> 
> > -		getvmlck(&sz_after);
> > +	getvmlck(&sz_after);
> 
> > -		sz_ch = sz_after - sz_before;
> > -		if (sz_ch == MMAPSIZE / 1024) {
> > -			tst_resm(TPASS, "Functionality of mmap() "
> > -					"successful");
> > -		} else {
> > -			tst_resm(TFAIL, "Expected %luK locked, "
> > -					"get %uK locked",
> > -					MMAPSIZE / 1024, sz_ch);
> > -		}
> > -
> > -		if (munmap(addr, MMAPSIZE) != 0)
> > -			tst_brkm(TFAIL | TERRNO, NULL, "munmap failed");
> > +	sz_ch = sz_after - sz_before;
> > +	if (sz_ch == MMAPSIZE / 1024) {
> > +		tst_res(TPASS, "Functionality of mmap() "
> > +				"successful");
> This is not much useful information. Also IMHO it's better to avoid splitting
> string (not ideal for grepping)
> 
> > +	} else {
> > +		tst_res(TFAIL, "Expected %luK locked, "
> > +				"get %uK locked",
> > +				MMAPSIZE / 1024, sz_ch);
> >  	}
> 
> Maybe something like:
> 	if (sz_ch == MMAPSIZE / 1024) {
> 		tst_res(TPASS, "mmap() locked %uK", sz_ch);
> 	} else {
> 		tst_res(TFAIL, "Expected %luK locked, get %uK locked",
> 				MMAPSIZE / 1024, sz_ch);
> 	}
> 
> > +	if (munmap(addr, MMAPSIZE) != 0)
> > +		tst_res(TFAIL | TERRNO, "munmap failed");
> The above should be replaced with:
> 
> 	SAFE_MUNMAP((char *)addr, sz_ch);
> 
> >  }
> 
> >  void getvmlck(unsigned int *lock_sz)
> Here is missing static.
> 
> > @@ -97,7 +67,7 @@ void getvmlck(unsigned int *lock_sz)
> 
> >  	fstatus = fopen("/proc/self/status", "r");
> 
> Please, use here:
> 
> 	fstatus = SAFE_FOPEN("/proc/self/status", "r");
> (it needs #include "tst_safe_stdio.h")

Ah, makes sense.

> 
> See old (not yet converted docs):
> https://github.com/linux-test-project/ltp/blob/master/doc/old/C-Test-API.asciidoc#a-word-about-the-cleanup-callback
> 
> Or in our old tutorial (already converted to the new API):
> https://linux-test-project.readthedocs.io/en/latest/developers/test_case_tutorial.html
> 
> >  	if (fstatus == NULL)
> > -		tst_brkm(TFAIL | TERRNO, NULL, "Open dev status failed");
> > +		tst_res(TFAIL | TERRNO, "Open dev status failed");
> Then the check above is not needed. Also beware, tst_brk() (or tst_brkm()) quits
> testing. But tst_res() usually not (tst_res(TBROK, ...) still quits testing, but
> that's kind of misusing the API), thus you changed a test workflow.

Ouch, indeed..

> 
> >  	while (fgets(line, LINELEN, fstatus) != NULL)
> >  		if (strstr(line, "VmLck") != NULL)
> > @@ -105,20 +75,13 @@ void getvmlck(unsigned int *lock_sz)
> 
> >  	ret = sscanf(line, "%*[^0-9]%d%*[^0-9]", lock_sz);
> >  	if (ret != 1)
> > -		tst_brkm(TFAIL | TERRNO, NULL, "Get lock size failed");
> > +		tst_res(TFAIL | TERRNO, "Get lock size failed");
> Again, SAFE_SSCANF() instead of check, also remember tst_brk() tst_res() difference.
> int ret is then not needed.
> 
> Also, we usually use in tests SAFE_FCLOSE(fstatus) instead of fclose(fstatus)
> (it checks the return value and yells if unexpected).
> 
> ...
> > +	.needs_root = 1,
> 
> As I noted above, instead of these two:
> > +	.test = run,
> > +	.tcnt = 1,
> 
> please use just:
> .test_all = run,
> 
> If you want, I can merge with the following diff below
> (+ the copyright you prefer me to add).
> Or just send another version.

Many thanks for reviewing and guidance. I'll make sure to properly read
the documentation for next time so as to avoid wasting review cycles :)

I'll send a v2.

> 
> Kind regards,
> Petr
> 
> +++ testcases/kernel/syscalls/mmap/mmap14.c
> @@ -1,23 +1,20 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
>  /*
>   * Copyright (c) 2013 FNST, DAN LI <li.dan@cn.fujitsu.com>
> - *
>   */
>  
>  /*\
>   * [Description]
>   *
> - * Test Description:
> - *  Verify MAP_LOCKED works fine.
> - *  "Lock the pages of the mapped region into memory in the manner of mlock(2)."
> + * Verify basic functionality of mmap(2) with MAP_LOCKED.
>   *
> - * Expected Result:
> - *  mmap() should succeed returning the address of the mapped region,
> - *  and this region should be locked into memory.
> + * mmap(2) should succeed returning the address of the mapped region,
> + * and this region should be locked into memory.
>   */
> +
>  #include <stdio.h>
>  #include <sys/mman.h>
> -
> +#include "tst_safe_stdio.h"
>  #include "tst_test.h"
>  
>  #define TEMPFILE        "mmapfile"
> @@ -26,9 +23,23 @@
>  
>  static char *addr;
>  
> -static void getvmlck(unsigned int *lock_sz);
> +static void getvmlck(unsigned int *lock_sz)
> +{
> +	char line[LINELEN];
> +	FILE *fstatus = NULL;
> +
> +	fstatus = SAFE_FOPEN("/proc/self/status", "r");
> +
> +	while (fgets(line, LINELEN, fstatus) != NULL)
> +		if (strstr(line, "VmLck") != NULL)
> +			break;
> +
> +	SAFE_SSCANF(line, "%*[^0-9]%d%*[^0-9]", lock_sz);
> +
> +	SAFE_FCLOSE(fstatus);
> +}
>  
> -static void run(unsigned int n)
> +static void run(void)
>  {
>  	unsigned int sz_before;
>  	unsigned int sz_after;
> @@ -37,8 +48,7 @@ static void run(unsigned int n)
>  	getvmlck(&sz_before);
>  
>  	addr = mmap(NULL, MMAPSIZE, PROT_READ | PROT_WRITE,
> -			MAP_PRIVATE | MAP_LOCKED | MAP_ANONYMOUS,
> -			-1, 0);
> +			MAP_PRIVATE | MAP_LOCKED | MAP_ANONYMOUS, -1, 0);
>  
>  	if (addr == MAP_FAILED)
>  		tst_res(TFAIL | TERRNO, "mmap of %s failed", TEMPFILE);
> @@ -47,41 +57,16 @@ static void run(unsigned int n)
>  
>  	sz_ch = sz_after - sz_before;
>  	if (sz_ch == MMAPSIZE / 1024) {
> -		tst_res(TPASS, "Functionality of mmap() "
> -				"successful");
> +		tst_res(TPASS, "mmap() locked %uK", sz_ch);
>  	} else {
> -		tst_res(TFAIL, "Expected %luK locked, "
> -				"get %uK locked",
> +		tst_res(TFAIL, "Expected %luK locked, get %uK locked",
>  				MMAPSIZE / 1024, sz_ch);
>  	}
>  
> -	if (munmap(addr, MMAPSIZE) != 0)
> -		tst_res(TFAIL | TERRNO, "munmap failed");
> -}
> -
> -void getvmlck(unsigned int *lock_sz)
> -{
> -	int ret;
> -	char line[LINELEN];
> -	FILE *fstatus = NULL;
> -
> -	fstatus = fopen("/proc/self/status", "r");
> -	if (fstatus == NULL)
> -		tst_res(TFAIL | TERRNO, "Open dev status failed");
> -
> -	while (fgets(line, LINELEN, fstatus) != NULL)
> -		if (strstr(line, "VmLck") != NULL)
> -			break;
> -
> -	ret = sscanf(line, "%*[^0-9]%d%*[^0-9]", lock_sz);
> -	if (ret != 1)
> -		tst_res(TFAIL | TERRNO, "Get lock size failed");
> -
> -	fclose(fstatus);
> +	SAFE_MUNMAP((char *)addr, sz_ch);
>  }
>  
>  static struct tst_test test = {
>  	.needs_root = 1,
> -	.test = run,
> -	.tcnt = 1,
> +	.test_all = run,
>  };

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
