Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33902E91261
	for <ltp@archiver.kernel.org>; Thu,  5 Feb 2026 06:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1770271754; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=ANMSjOCgxGjSeCsxnblf6R3hdWDSjIh4Cm2z5LqZ9Fg=;
 b=N4djdP0tvBfkiLIKxQxMYQn0r9Ql2ip70jFCKibA5lOMuH5dSF+mnlKpS6IgOwgBV8wp1
 56P+RPSgIdYlll1bfffQV/D89y/oVlJcXKl0OlSQEvwLk/TTCEGl3D661GbHH65pX0U2/xv
 itKvGAO+uCWhWJ0n7DeDYEdp1NY1Hqg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A1A873CE2D9
	for <ltp@archiver.kernel.org>; Thu,  5 Feb 2026 07:09:14 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D9C493C246E
 for <ltp@lists.linux.it>; Thu,  5 Feb 2026 07:08:50 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 3EAD52002D1
 for <ltp@lists.linux.it>; Thu,  5 Feb 2026 07:08:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770271728;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vcdJznLOd6W54Ut+FcnciDFRewuG7ArGScBTq5fLgIk=;
 b=U47a+YIU0DjzbRR9hCwJ9opLHuU2QBoYzRjDwZrfDVeL7U9RZQY/B5jp6O701/p0BC5kvN
 reHI5KLV9J1aQkscrX7f25Vss9ISu3Nq8uhjT3Ba2VCMC7S53EvtOgMtbXW1OusndZo3HU
 GrXovKwtDT03xAHI1Z6GhNWomDAi2Z8=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-fqbsuCZDOk6bOn_9jvuMhg-1; Thu, 05 Feb 2026 01:08:47 -0500
X-MC-Unique: fqbsuCZDOk6bOn_9jvuMhg-1
X-Mimecast-MFC-AGG-ID: fqbsuCZDOk6bOn_9jvuMhg_1770271726
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-34c48a76e75so614934a91.1
 for <ltp@lists.linux.it>; Wed, 04 Feb 2026 22:08:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770271726; x=1770876526;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vcdJznLOd6W54Ut+FcnciDFRewuG7ArGScBTq5fLgIk=;
 b=p3x1PAXKqmuzjpOHlrWJnmYVBfhrT/189AL7RSpmNY/Dy/AxAhLBIxSFxaBVG4gs9F
 jGIQsEKQXI1lcbVRqHrEe+vUNo7ixCtjsqNXWtxGK0vbGyxROrsGs3xJHRkI2JCXm2U6
 UMd9LXZgh7Xx3k7GOweDkQJonBDNYVVmnx81UBWd4/AyVA+awBk4fN1UcFKJDxjh2zrE
 AR9UqInKtw+lVgV8t6s9V/Uss3SISLymG1LZXOLiVnu/P2Spj+bS+0kuxVwG5PJTFvW5
 fLWdRn7XhjxQgO5HB8E7BLN816bmhn6LxCsBx6M/SIKEgdlJWXAv244mq4a7IPG47t+3
 Mbjg==
X-Gm-Message-State: AOJu0YyG9VRruscI+QmFvgGLY8Rih3kjLqzIDlielSslRT8aaLVJLfgS
 RkkVMK7k6vezsaO/3Uo2xbvoGcI2seVpA7+XMUCwzWn5aLJwcghmqTwEgpGkQ2uNeSRvcR3FBvs
 4RVhXFlYEbRPecAwvNL5hJ5lOkHzSSRweyfhV6s7vSCpQMtMoR3o7
X-Gm-Gg: AZuq6aIAhCcPv9V0Lrjxbz57IwjfmyYIAyUl+WbrwhHyDdw83FslmHEc3GIy4Zmv6Gg
 eki3CNx+v1mu3Zxm9qJ4eSsDk46fN6uY2WDwo6DccyWea5PCuDB6Y5k94sN1UzWkHUnU+m0nX1v
 aOmTeR7SyY48aTRMhh4gfX0lZDu7QEsuEP3Xo2zfBv5uF9GE2NizLD8OY8/EzP8Ic++h4ySgTTx
 8n3IwTfsf5jdVzF6/wn2FlDnoIDLkJ45mx2VEfiL5Q4sJmiCpKuEBOVmzgM3jfRvk081p4W7H6r
 gshPLz2x4/tiQz42pXjc8L10iKZG6yN+bo3Db+/kNFc5j5LYuoyQJNVIsh8rlZLCGtPMnFaF00m
 DGuMB
X-Received: by 2002:a17:90b:4c51:b0:354:9b9b:54da with SMTP id
 98e67ed59e1d1-3549b9b5549mr1494394a91.14.1770271726148; 
 Wed, 04 Feb 2026 22:08:46 -0800 (PST)
X-Received: by 2002:a17:90b:4c51:b0:354:9b9b:54da with SMTP id
 98e67ed59e1d1-3549b9b5549mr1494373a91.14.1770271725745; 
 Wed, 04 Feb 2026 22:08:45 -0800 (PST)
Received: from redhat.com ([209.132.188.88]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35489313becsm2273419a91.5.2026.02.04.22.08.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 22:08:45 -0800 (PST)
Date: Thu, 5 Feb 2026 14:08:42 +0800
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <aYQz6gN7WvJbSg1k@redhat.com>
References: <20260204124323.244578-1-pvorel@suse.cz>
MIME-Version: 1.0
In-Reply-To: <20260204124323.244578-1-pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8ipg1p9_R8_KbU-zHU72tPnR_rjtBiFUt3-affEwNZc_1770271726
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] openat2: Move includes to lapi, remove _GNU_SOURCE
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
From: Li Wang via ltp <ltp@lists.linux.it>
Reply-To: Li Wang <liwang@redhat.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, Feb 04, 2026 at 01:43:23PM +0100, Petr Vorel wrote:
> Improve 767b3e519e. struct open_how is also used in lapi/openat2.h,
> which is used by all openat2*.c tests.  Therefore move <fcntl.h> to the
> lapi header (and use lapi/fcntl.h instead).
> 
> Also remove _GNU_SOURCE which should not be needed.
> 
> While at it, move include "config.h" to the top.
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Hi Li,
> 
> my points from the original patchset why not use _GNU_SOURCE:
> 
> glibc test tst-openat2.c [1] which includes <fcntl.h>, uses struct

Interesting, I haven't figure out why it can be built within glibc itself.

> open_how and test openat2() does not define it. Neither openat2() nor
> struct open_how [2] are guarded by #ifdef __USE_GNU.
>  
> O_DIRECTORY is guarded by #ifdef __USE_XOPEN2K8 but this should be safe as we
> compile with -std=gnu99.

In glibc-2.43, things have changed, only define __USE_GNU can contain the
<bits/openat2.h> header file, that's why after applying this patch still
fails to complie on Fedora-Rawhide.

<fcntl.h> -> <bits/fcntl.h> -> <bits/fcntl-linux.h> -> <bits/openat2.h>

 # cat bits/fcntl-linux.h

 396 #ifdef __USE_GNU
     ...
 473 #include <bits/openat2.h>
  
 489 #endif	/* use GNU */

See: https://github.com/bminor/glibc/commit/0f0a5cd338998f4b603f52f3ce2163df0db7b814#diff-a4fc1e1b56b60a2598e320a232e6f631d08e0dafcfe3dd9607dde4bc8ee31eb8R473

-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
