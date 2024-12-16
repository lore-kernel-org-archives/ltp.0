Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BFE0E77180
	for <ltp@archiver.kernel.org>; Mon, 16 Dec 2024 13:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1734354478; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=OCPQx+FRqytatyhUeITrhy4HbTC5xdckgny2YtVTVEY=;
 b=h0eOG3lnIoUSRKCSmhV4SSYQY7AEnlky5IF+DzNq7z0Vta8CXr14SpiDoZlFu5zHfTQzq
 Xy5jjj9sKNQkYfga7wyKY/SruSy7rCYmujMO/sNnhoJb7nXAiXbm/B458IG0fH2nbMgqogP
 ULudmUmmLZuqTOqLQEHBu2eQNPavqJ8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E3B1B3EBDEC
	for <ltp@archiver.kernel.org>; Mon, 16 Dec 2024 14:07:58 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C560C3E763B
 for <ltp@lists.linux.it>; Mon, 16 Dec 2024 14:07:36 +0100 (CET)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id F254314088C0
 for <ltp@lists.linux.it>; Mon, 16 Dec 2024 14:07:35 +0100 (CET)
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-37ed3bd6114so1974833f8f.2
 for <ltp@lists.linux.it>; Mon, 16 Dec 2024 05:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1734354455; x=1734959255; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Ap8QNwFL97XpT2reZhaDbSweepOTYLvNujxG6phN2Uc=;
 b=WGGLmrdrNB4vZCh2gLCLW/dOdSxJq5poZ+TK6EpcKkRE5qXGDYm1jbfLyu6kXuRfqa
 WTcRh6tSF5UYy7F+0ml8QdVSBzbv785HvmPbX4r5Mjv6OGf3py4Em11D6+qOehAL3kNt
 O+bi82840+EfMhx2+yJZmBK66UzJM8M2GwmJvx+c3jSr2g9M6hXf86lcfh/3YLgqwv0e
 ump1Z7c21aZFRNzgyJV3k2t+7n4vkxYFm1tpxR7hhnxc2pH8Q0u+kSTrJeJ/DXE5a+iG
 OHMplRWC4bxC8lm9V8MspJH3cUOfo0ku/Vxcf3FNwpXLKEGUvOOy3ha4uUdWrwN25oOB
 lwzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734354455; x=1734959255;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ap8QNwFL97XpT2reZhaDbSweepOTYLvNujxG6phN2Uc=;
 b=dcETWLmQZXzeiLZc+TyG74C6Kv2tU+Z33OTm7SAYprgkMVWuJTMSPy8pzFdSARxZcU
 TjYZm6WYPlr58L1PqR+qoKW/UyQkg0R/UPabYRj03IVPiM1xYQRwrEn8i0kYLgUTpFvt
 KtMxwAorYQlHcED1mDJsEM3KpRbGOzy3wDTe4fdkTLM2NNRq0/Dai0flLbjNEAJRHBMU
 3cBMZiUqLsy2bq3pZE+iI2acne6sTdruzckhOqNBpmbChXPWeRZCw5QfU64TWELKJVDZ
 dcbkLfOB/Si25FXGax0SCfWhPvEWg9Jku9oZabsb+uurk2gD2T7RL+t7JpHxVFkSacL1
 9DJQ==
X-Gm-Message-State: AOJu0YwhxpwBkf8F/Ny06zyB9+Q7cqC7dNIrwU4jCquxCp5MHefh+i5K
 N/JPLgkjRGRZZGGHnroI7I2Cx8Rj/V4HFByeOP5wAFxVpx+hVXryAq0SAcmf0mw=
X-Gm-Gg: ASbGncuYuDbF8di2pdGJo8GM4SCTTXPAvXceLmNzkHcIpt8xG7qvQxf5tz7Iw3tmB/x
 9jlGPuc+IEf5DpZTZkPqxWAUOLOemXxDt0kIzczwuNjRjWFgW+htVmEnhk1zIqZpRNjywQ7gxYH
 aY4fTk6UEwouHweYqUSIgXCc/tEzh52809njqHKxG/HM3VA4WRK/k4XBFrP5PJBLan9PiRDuPCv
 ZOlzsij7+CfQp9JIOIDSQCAiEzv6Si2gxNPTkieyEY=
X-Google-Smtp-Source: AGHT+IEcMZflWPQ5unpBxSvT18Rx9/RX+nSFcDjD/7bcvuztdiEVkdz92M+FbEVt98rsLghcwBDgyw==
X-Received: by 2002:a5d:47a2:0:b0:385:eecb:6f02 with SMTP id
 ffacd0b85a97d-38880ad97cfmr9134893f8f.28.1734354455330; 
 Mon, 16 Dec 2024 05:07:35 -0800 (PST)
Received: from localhost ([177.95.19.124]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-218a1e500a2sm41783435ad.118.2024.12.16.05.07.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2024 05:07:34 -0800 (PST)
Date: Mon, 16 Dec 2024 10:07:31 -0300
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <2ztzjoopewh4usb464x2c34iva6oof6u7wx5myhfeq3v5qlmxn@hh5xzkfc65vf>
References: <20241212-convert_mmap01-v6-1-d186b68c3f09@suse.com>
 <20241216130150.GA589341@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241216130150.GA589341@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6] mmap01: Convert to new API
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

On 16 Dec 24 14:01, Petr Vorel wrote:
> Hi Ricardo,
> 
> generally LGTM, with minor comments below (only relevant is SAFE_MSYNC()).
> 
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> 
> ...
> > +++ b/testcases/kernel/syscalls/mmap/mmap01.c
> > @@ -1,194 +1,145 @@
> 
> > -/*
> > - * Test Description:
> > - *  Verify that, mmap() succeeds when used to map a file where size of the
> > - *  file is not a multiple of the page size, the memory area beyond the end
> > - *  of the file to the end of the page is accessible. Also, verify that
> > - *  this area is all zeroed and the modifications done to this area are
> > - *  not written to the file.
> > +/*\
> > + * [Description]
> >   *
> > - * Expected Result:
> > - *  mmap() should succeed returning the address of the mapped region.
> > - *  The memory area beyond the end of file to the end of page should be
> > - *  filled with zero.
> > - *  The changes beyond the end of file should not get written to the file.
> > + * Verify that mmap() succeeds when used to map a file where size of the
> > + * file is not a multiple of the page size, the memory area beyond the end
> > + * of the file to the end of the page is accessible. Also, verify that
> > + * this area is all zeroed and the modifications done to this area are
> > + * not written to the file.
> nit: Slightly hard to read, but I'm not able to suggest any improvement.
> >   *
> > - * HISTORY
> > - *	07/2001 Ported by Wayne Boyer
> > + * mmap() should succeed returning the address of the mapped region.
> > + * The memory area beyond the end of file to the end of page should be
> > + * filled with zero.
> nit: FYI this new line has no effect for docparse formatting (html/pdf formatting).
> If you want to have separate paragraph, it needs to be extra blank space.
> I would just continue the sentence in previous paragaraph.
> > + * The changes beyond the end of file should not get written to the file.
> >   */
> 
> > +#include "tst_test.h"
> > +
> > +#define TEMPFILE "mmapfile"
> > +#define STRING "hello world\n"
> 
> ...
> 
> static void check_file(void)
> {
> 	...
> 	for (i = 0; i < buf_len; i++)
> 		if (buf[i] == 'X' || buf[i] == 'Y' || buf[i] == 'Z')
> 			break;
> 
> 	if (i == buf_len)
> 		tst_res(TPASS, "Functionality of mmap() successful");
> very nit: IMHO that mmap() works is detectable from TPASS. I like when TPASS
> describe what was the evaluation, maybe something like "pattern found in the file" ?
> 	else
> 		tst_res(TFAIL, "Specified pattern found in file");
> 	SAFE_CLOSE(fildes);
> }
> 
> > -	page_sz = getpagesize();
> > +static void run(void)
> > +{
> > +	pid_t pid;
> > +
> > +	set_file();
> > +
> > +	addr = SAFE_MMAP(NULL, page_sz, PROT_READ | PROT_WRITE,
> > +			 MAP_FILE | MAP_SHARED, fildes, 0);
> > +
> > +	/*
> > +	 * Check if mapped memory area beyond EOF are zeros and changes beyond
> > +	 * EOF are not written to file.
> > +	 */
> > +	if (memcmp(&addr[file_sz], dummy, page_sz - file_sz))
> > +		tst_brk(TFAIL, "mapped memory area contains invalid data");
> > +
> > +	/*
> > +	 * Initialize memory beyond file size
> > +	 */
> > +	addr[file_sz] = 'X';
> > +	addr[file_sz + 1] = 'Y';
> > +	addr[file_sz + 2] = 'Z';
> > +
> > +	/*
> > +	 * Synchronize the mapped memory region with the file.
> > +	 */
> > +	if (msync(addr, page_sz, MS_SYNC) != 0) {
> > +		tst_res(TFAIL | TERRNO, "failed to synchronize mapped file");
> > +		return;
> I would use here SAFE_MSYNC().

Indeed! From now on I'll always check for SAFE_* :)

Thanks for the review, I'll push a new revision addressing your points.

-	Ricardo.


> > +	}
> 
> > -	/* Allocate and initialize dummy string of system page size bytes */
> > -	if ((dummy = calloc(page_sz, sizeof(char))) == NULL) {
> > -		tst_brkm(TFAIL, cleanup, "calloc failed (dummy)");
> > +	/*
> > +	 * Now, search for the pattern 'XYZ' in the temporary file.
> > +	 * The pattern should not be found and the return value should be 1.
> > +	 */
> > +	pid = SAFE_FORK();
> > +	if (!pid) {
> nit: pid is not needed, how about use SAFE_FORK() directly?
> if (!SAFE_FORK()) {
> 
> > +		check_file();
> > +		SAFE_MUNMAP(addr, page_sz);
> > +		exit(0);
> >  	}
> ...
> 
> > +static void setup(void)
> > +{
> > +	page_sz = getpagesize();
> > +
> > +	/* Allocate and initialize dummy string of system page size bytes */
> > +	dummy = SAFE_CALLOC(page_sz, sizeof(char));
> nit: sizeof(char) is always guaranteed to be 1, I would use:
> 
> 	dummy = SAFE_CALLOC(page_sz, 1);
> 
> The rest LGTM.
> 
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> 
> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
