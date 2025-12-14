Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A2CED5B160
	for <ltp@archiver.kernel.org>; Sun, 14 Dec 2025 01:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1765677268; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=XKmaM5/tTE+WU333wOtFdg3nGQa2qC0/hq03pPgyUA0=;
 b=RTaEESPqBJwBAQ9GNZXmm/SmhZNw82p94XGygE+53jN6/5YkL/+hrng6i+mGUxlqf5An3
 A74+qsafMVVmQRH8uxmOac5IaB0uEDWkbOR4gix6BIIjBGgSfyHH9HpnGwMuiDGzqoGWdrk
 8iDdYUjjBSjb/Vf8xXakytiInedZnq8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 58E033CF231
	for <ltp@archiver.kernel.org>; Sun, 14 Dec 2025 02:54:28 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8A5213CA807
 for <ltp@lists.linux.it>; Sun, 14 Dec 2025 02:54:06 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 14C521A00346
 for <ltp@lists.linux.it>; Sun, 14 Dec 2025 02:54:04 +0100 (CET)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-477b5e0323bso9988845e9.0
 for <ltp@lists.linux.it>; Sat, 13 Dec 2025 17:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1765677244; x=1766282044; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2I/dnyE8Ok5d8GMkUjX/DzVPZO1qOJQDQvxIunQTjh4=;
 b=ghNPTxMYpyEs5wM60YkPrz4xoDcK4swcRiNnOxcCL88F4ibSwRdZ2EeDWxUSId3Eyj
 vgurQzwXbZ9RjNHZd6WXLsID8tSOpLy5rtslVfisAelDGeyvbT426JU9wZLHfewtOCgN
 lW5FiN/j5/IG8ItFw3GsNKy9A0knpYCylqmfXxAexJFVWh6MQMUh3T3GNQ3BpCxDndAP
 hncoybxKZDZ1DwGIAu9HN/mjAMIyHmEqzfR5f3+Vw1ZOAxcHrP2CKEgGIwBYlMn0joOe
 2HNoxIfIlDaYjbjwW/i7jW7KG7avikWIvIWcHar7YpM/ZZSouiwwHU7x8rOJwXNWb6re
 U+qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765677244; x=1766282044;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2I/dnyE8Ok5d8GMkUjX/DzVPZO1qOJQDQvxIunQTjh4=;
 b=KPCMd1Hc9mSkBB0SnHKNbqTlXj25ToUbY+5t/5sXh4NC1+kGa7NsUKeiz7Pf5IT6+F
 zXmQfw1k1uTjy5ElbK+iu+2MntKAV6jmyDxZKs868FQJ2Crs1BeoCgWWdVJ2tcO32m9H
 9bJGqheZ7pIx6EVBqlLKxw/zT7C2c/ou3xq+YhVPdZVvafky/mnyGqgtnYvks41tEaM/
 AqypbH4qZ4Zd/oSi9gk9/9Ork2GVY0ijyK6HYWw3GScnfalQ0Q0L3lKuG532xhqNKEwk
 bUI8E/lmbQTav3BuK2Iq2hJPbjGDQHjg9guTnOCKNyHauuStiF+Vl2OeOYUvdZPxabYt
 LOkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWE4DkVczzloxJX/6uewK4L72eaxegNDzQ/fIbETQFv+AayoLlQeh5Utdewyp68YZ9Yy/8=@lists.linux.it
X-Gm-Message-State: AOJu0YyuhgNsTTAANk1k//NnA82JzVoaKOa4uIcQCguQfB2csF8CaLMN
 BriyHVnKOjQb+WNrXTksZBPsrRqsaUscvbh8FR6sa5PjpzDGaE1xtkjdC+sDrdEqpg==
X-Gm-Gg: AY/fxX6FQgu3KadZvBh3T8JIg7o4vu9+YwvfNaUvEAF37cp3/eZZ5lzLeUIVmZhmIwI
 84oAjS6EHMZU80FzdvV3VHP+fHIOKKzcCyhWhTIJGte3WKMaxmbl3k3C+RtASiUDP8i66Dc6I4a
 /qHT5n9UWkD1Tt9AwD6smlUpcV4HaQGi5SEnf3pwiC0owpPadpJy5DpRH6J5OKG2IsRRwExIxYB
 b+izcxzx8gBOIcQ/wLDqrpxGjrXe3m253dac3dAr/NS8m3HlmHBRbpGeUbsgG8tMrz+ygxNjvyH
 69KPo4S0qYsMdLEioKgLpcpXz4ErTgV1zCzg1ne56PzGg0uBGmtuNE9TXkeHhAa3VYI8K7NUD6G
 AkbWDNpNO2KDZjZyLF9mwlXSLvFhuQ09BwhRXVTvTRmFkiKTQh7IFOIC6/Kqa3CjFTTU7Jkl6it
 0bh6JZOQd2+F1oohg1rQ2fo4Aim8Ou
X-Google-Smtp-Source: AGHT+IEVr7dPEfOiB97Jk7lqS6Q8jeCYTNk6dfvcm6r6RXX5QgCkcljlODUCjU4fCBVg5I9Kq6VEGg==
X-Received: by 2002:a05:6000:2dc5:b0:430:f2ee:b21f with SMTP id
 ffacd0b85a97d-430f2eeb6c5mr3189282f8f.22.1765677244259; 
 Sat, 13 Dec 2025 17:54:04 -0800 (PST)
Received: from autotest-wegao.qe.prg2.suse.org
 ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-430f42a3290sm4907115f8f.17.2025.12.13.17.54.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Dec 2025 17:54:03 -0800 (PST)
Date: Sun, 14 Dec 2025 01:54:02 +0000
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <aT4Yus2DHhcH4nCZ@autotest-wegao.qe.prg2.suse.org>
References: <20251211015915.1086-1-wegao@suse.com>
 <20251212115244.2027-1-wegao@suse.com>
 <20251212122827.GC125889@pevik> <aTwREz2-YroAAyl_@yuki.lan>
 <20251212142045.GD125889@pevik> <20251212151156.GF125889@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251212151156.GF125889@pevik>
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5] listmount04.c: Update case support
 mnt_id_req.mnt_ns_fd
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

On Fri, Dec 12, 2025 at 04:11:56PM +0100, Petr Vorel wrote:
> > > Hi!
> > > > > -#ifndef HAVE_STRUCT_MNT_ID_REQ
> > > > > -struct mnt_id_req {
> > > > > +struct mnt_id_req_fallback {
> > > > >  	uint32_t size;
> > > > > -	uint32_t spare;
> > > > > +	uint32_t mnt_ns_fd;
> > > > >  	uint64_t mnt_id;
> > > > >  	uint64_t param;
> > > > >  	uint64_t mnt_ns_id;
> > > > >  };
> > > > > +
> > > > > +#if !defined(HAVE_STRUCT_MNT_ID_REQ) || !HAVE_STRUCT_MNT_ID_REQ_MNT_NS_FD
> > > > Shouldn't be !HAVE_STRUCT_MNT_ID_REQ_MNT_NS_FD
> > > > !defined(HAVE_STRUCT_MNT_ID_REQ_MNT_NS_FD) ?
> 
> > > > Also, this patchset introduces compilation error on old systems:
> 
> > > > In file included from listmount03.c:13:0:
> > > > listmount.h:20:4: error: 'struct mnt_id_req' has no member named 'mnt_id'
> > > >    .mnt_id = mnt_id,
> 
> > > > Obviously some definition is wrong.
> 
> > > That looks like we need configure check for mnt_id too however that
> > > happens in a different test.
> 
> > Yes:
> 
> Actually no, the problem was that typedef expects using pointer.
> And we now need to use it in all tests, therefore listmount.h needs to be
> updated.
> 
> Below is diff (without handling different errno).
> 
> Kind regards,
> Petr
> 
> diff --git configure.ac configure.ac
> index fcff907991..2866ee981d 100644
> --- configure.ac
> +++ configure.ac
> @@ -172,6 +172,9 @@ AC_CHECK_FUNCS_ONCE([ \
>  ])
>  AC_CHECK_FUNCS(mkdtemp,[],AC_MSG_ERROR(mkdtemp() not found!))
>  
> +# Defined in <linux/mount.h>, but include/lapi/mount.h includes <sys/mount.h> */
> +AC_CHECK_MEMBERS([struct mnt_id_req.mnt_ns_fd],,,[#include <sys/mount.h>])
> +
>  AC_CHECK_MEMBERS([struct fanotify_event_info_fid.fsid.__val],,,[#include <sys/fanotify.h>])
>  AC_CHECK_MEMBERS([struct perf_event_mmap_page.aux_head],,,[#include <linux/perf_event.h>])
>  AC_CHECK_MEMBERS([struct sigaction.sa_sigaction],[],[],[#include <signal.h>])
> @@ -261,9 +264,6 @@ AC_CHECK_TYPES([struct mount_attr],,,[
>  AC_CHECK_TYPES([struct cachestat_range],,,[#include <sys/mman.h>])
>  AC_CHECK_TYPES([struct cachestat],,,[#include <sys/mman.h>])
>  
> -# Defined in <linux/mount.h>, but include/lapi/mount.h includes <sys/mount.h> */
> -AC_CHECK_TYPES([struct mnt_id_req],,,[#include <sys/mount.h>])
> -AC_CHECK_MEMBERS([struct mnt_id_req.mnt_ns_fd],,,[#include <sys/mount.h>])
>  AC_CHECK_TYPES([struct statmount],,,[#include <sys/mount.h>])
>  AC_CHECK_MEMBERS([struct statmount.mnt_ns_id],,,[#include <unistd.h>
>  #include <linux/mount.h>])
> diff --git include/lapi/mount.h include/lapi/mount.h
> index 7b1c4ca0fe..5d9ccde28d 100644
> --- include/lapi/mount.h
> +++ include/lapi/mount.h
> @@ -53,7 +53,7 @@ struct mnt_id_req_fallback {
>  	uint64_t mnt_ns_id;
>  };
>  
> -#if !defined(HAVE_STRUCT_MNT_ID_REQ) || !HAVE_STRUCT_MNT_ID_REQ_MNT_NS_FD
> +#ifndef HAVE_STRUCT_MNT_ID_REQ_MNT_NS_ID
>  typedef struct mnt_id_req_fallback mnt_id_req;
>  #else
>  typedef struct mnt_id_req mnt_id_req;
> diff --git testcases/kernel/syscalls/listmount/listmount.h testcases/kernel/syscalls/listmount/listmount.h
> index aad927f714..74f334c74e 100644
> --- testcases/kernel/syscalls/listmount/listmount.h
> +++ testcases/kernel/syscalls/listmount/listmount.h
> @@ -8,6 +8,7 @@
>  
>  #define _GNU_SOURCE
>  
> +#include "config.h"
>  #include "tst_test.h"
>  #include "lapi/mount.h"
>  #include "lapi/syscalls.h"
> @@ -15,11 +16,10 @@
>  static inline ssize_t listmount(uint64_t mnt_id, uint64_t last_mnt_id,
>  			 uint64_t list[], size_t num, unsigned int flags)
>  {
> -	struct mnt_id_req req = {
> -		.size = MNT_ID_REQ_SIZE_VER0,
> -		.mnt_id = mnt_id,
> -		.param = last_mnt_id,
> -	};
> +	mnt_id_req *req = NULL;
> +	req->size = MNT_ID_REQ_SIZE_VER0;
> +	req->mnt_id = mnt_id;
> +	req->param = last_mnt_id;
>  
>  	return tst_syscall(__NR_listmount, &req, list, num, flags);
Thanks for such detail feedback, will sent next patch.
I guess we need s/&req/req/,
or i think simple s/struct mnt_id_req/mnt_id_req/ more better.
>  }

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
