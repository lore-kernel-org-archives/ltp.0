Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62332C54788
	for <ltp@archiver.kernel.org>; Thu, 22 Feb 2024 13:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1708609097; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=XbQ1ZwyyuqCcQuaYbHlMXhfIc7PibTKslMJRLT9dMeA=;
 b=Pmq675zP580PkLE54PUQV3TeawHlU3XT6kHgCzyVhcV6lCDVuxbCr+ToogGdQRikfbIxR
 4Bj2kh4EiP/pXWYPse1bfHDfyNFxEjnZBDwOAXIRng8ox9ncMTFPP2ZWVzSHiQgXvafDwNg
 AlfNCkSvZkX5gAYdunNhdRdyvRROAi4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 835853CF179
	for <ltp@archiver.kernel.org>; Thu, 22 Feb 2024 14:38:17 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 34E3E3CEFB9
 for <ltp@lists.linux.it>; Thu, 22 Feb 2024 14:37:55 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 5A88414060D0
 for <ltp@lists.linux.it>; Thu, 22 Feb 2024 14:37:54 +0100 (CET)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-41272d42207so17591335e9.2
 for <ltp@lists.linux.it>; Thu, 22 Feb 2024 05:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1708609074; x=1709213874; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2C15EwBnKO8MvTopc6GjUoagnvdNOPrydKE0MMVNujI=;
 b=fZHp0oFbHxSCqy8XppfBVadUixn7ZA8E1plWHB/qliCfbJ/KRV74aXf5SSGmws8Dnd
 KhLsi9y7Udav4zN4sTXGYH+Lu2GHemBkOZOe63f/zXw8acn9aWPh+mXBFJvxOU7yKZ4o
 U2Fd/jOF+XRxRv2lYPTvqmcPq26SkR8myTjmAAuap4JoCJXDAfH87JzgEqu0Y1yUKjEF
 OJ5wR2JHOjUX9pu/IkBrSlDgDr8QxwjF/LA/dNPIE2xWX3YejpASoIrF6z5xoE/UVv39
 ATb3bEKzSgVTFSFKqeiQvk8FoQOrlKGx6t0GwvvBkWDby3pd7hA2SsKiYNWZ7j8Vs4R4
 fF4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708609074; x=1709213874;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2C15EwBnKO8MvTopc6GjUoagnvdNOPrydKE0MMVNujI=;
 b=LJDaozUbuZMho8A93bpcfFwi0EtjkKr/ZvuzwkC3LHEXjc1eZGMFbDZcIb3oZbQeL4
 pQoIuC85OE6hoGyZAQEAqj2YIi3xJ52Lmaz+4rpmQa9jnNkC5eKY4nkUfHjtNbX2ckfE
 N8KTzr2MSEX8B4EdBGuCfrwvWWlnDQXAK385NB3Bb/brQDZCJosc0XfgF/5CMkFOdo2I
 gSbmUd0LwuvLG607cuWFobbBTdd6yEMXt1C48myh4NfzUwMobBzHt5dhVSvpSQ7zP8ce
 UQmYUiGILrGIZJRIvc/HcFqDaxTGU3FC307I0C/JtzFQK+vY10QB8lm1hcmEOVUBqRAU
 b/aA==
X-Gm-Message-State: AOJu0YyQTpIJK+Sszchw44G8eQQikUP63evULqPeIcSVBDB/BTFiZFJ9
 yOqSIpJFZ6+Da2rxqrqbcxrs3Pj+I+/9UdvWdtw8E0sXshezCqPLPyJFMh90EF0Ubn6fMzJ+iTt
 SLw==
X-Google-Smtp-Source: AGHT+IGlPyp3uum9Cml8gidoC+mSpQuOueMuBSlr3z12xHzJNUoiuInBynnn1E8DLmrkY8PZTtjRqw==
X-Received: by 2002:adf:f98e:0:b0:33d:67f5:a3a4 with SMTP id
 f14-20020adff98e000000b0033d67f5a3a4mr6149685wrr.67.1708609073730; 
 Thu, 22 Feb 2024 05:37:53 -0800 (PST)
Received: from wegao.166.144.58 ([81.95.8.245])
 by smtp.gmail.com with ESMTPSA id
 b11-20020a05600003cb00b0033d9ac8f356sm1118542wrg.93.2024.02.22.05.37.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Feb 2024 05:37:53 -0800 (PST)
Date: Thu, 22 Feb 2024 08:37:47 -0500
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <ZddOKzhl1semChgB@wegao.166.144.58>
References: <20240222044119.28500-1-wegao@suse.com>
 <ZdcIT1WiEfV7MCQ-@rei>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZdcIT1WiEfV7MCQ-@rei>
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] swapoff01.c: Adjust blocks size base on
 pagesize
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

On Thu, Feb 22, 2024 at 09:39:43AM +0100, Cyril Hrubis wrote:
> Hi!
> > The make_swapfile function will encounter no space error if pagesize
> > is bigger then 4096, such as ppc64 system use default pagesize 65535.
>                                                                     ^
> 								 65536?
Yes
> 
> Isn't this more about Btrfs though? Looking at the make_swapfile() we do
> use statvfs to get filesystem block size and if that is Btrfs with 64k
> blocks we end up with swapfile of a size of 4GB that sounds like a bit
> too much I guess.
> 

Sorry for confusing. It should caused by block size instead of page size.
The code change should change like following, but i suppose you will not agree
on this solution, correct?

--- a/testcases/kernel/syscalls/swapoff/swapoff01.c
+++ b/testcases/kernel/syscalls/swapoff/swapoff01.c
@@ -12,6 +12,7 @@
 #include <unistd.h>
 #include <errno.h>
 #include <stdlib.h>
+#include <sys/statvfs.h>

 #include "tst_test.h"
 #include "lapi/syscalls.h"
@@ -44,8 +45,21 @@ static void setup(void)
 {
        is_swap_supported(TEST_FILE);

-       if (make_swapfile(SWAP_FILE, 65536, 1))
+       struct statvfs fs_info;
+       unsigned long blk_size;
+       if (statvfs(".", &fs_info) == -1)
+               tst_brk(TBROK, "Failed to get statvfs info");
+
+       blk_size = fs_info.f_bsize;
+
+       int blocks = 65535;
+
+       if (blk_size > 4096)
+               blocks = 65535 * 4096 / blk_size;
+
+       if (make_swapfile(SWAP_FILE, blocks, 1))
                tst_brk(TBROK, "Failed to create file for swap");
+
 }


> > Signed-off-by: Wei Gao <wegao@suse.com>
> > ---
> >  testcases/kernel/syscalls/swapoff/swapoff01.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/testcases/kernel/syscalls/swapoff/swapoff01.c b/testcases/kernel/syscalls/swapoff/swapoff01.c
> > index c303588df..71d6c6c04 100644
> > --- a/testcases/kernel/syscalls/swapoff/swapoff01.c
> > +++ b/testcases/kernel/syscalls/swapoff/swapoff01.c
> > @@ -44,7 +44,12 @@ static void setup(void)
> >  {
> >  	is_swap_supported(TEST_FILE);
> >  
> > -	if (make_swapfile(SWAP_FILE, 65536, 1))
> > +	int blocks = 65535;
> > +
> > +	if (getpagesize() > 4096)
> > +		blocks = 65535 * 4096 / getpagesize();
> > +
> > +	if (make_swapfile(SWAP_FILE, blocks, 1))
> >  		tst_brk(TBROK, "Failed to create file for swap");
> 
> 
> I do not think that this is a right solution though. Is there any reason
> why we pass number of blocks to the make_swapfile instead of megabytes?
> 
@Li Wang, could you give some clue for above question(for why pass number of blocks instead of megabytes)?

Thanks all for comments!

> >  }
> >  
> > -- 
> > 2.35.3
> > 
> > 
> > -- 
> > Mailing list info: https://lists.linux.it/listinfo/ltp
> 
> -- 
> Cyril Hrubis
> chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
