Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7831CC433F5
	for <ltp@archiver.kernel.org>; Fri, 28 Jan 2022 13:31:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8F8B93C9765
	for <ltp@archiver.kernel.org>; Fri, 28 Jan 2022 14:31:04 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 598DD3C9120
 for <ltp@lists.linux.it>; Fri, 28 Jan 2022 14:30:47 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 0621D14010D4
 for <ltp@lists.linux.it>; Fri, 28 Jan 2022 14:30:46 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 28A95210FE;
 Fri, 28 Jan 2022 13:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1643376646; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yI4S91kwChKoRuMPJNR8i4IqqAprjk7MFYPSYyGrohU=;
 b=mW9RFY4+tQen1Ouy7LHF7a8Q22Sag//8cYCEPArQXVdAF2/FXHNriWOad3pd7pIIIdevPo
 lQwT6HmPYCVzNMN/5/HUaW8XQ6IOhLztP0bx4sDqXLT26nbIRVr5kL34sR3VolTemBZEUz
 e6QkvFV+1yxuBWBeyOGobPtWPK7dqd4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1643376646;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yI4S91kwChKoRuMPJNR8i4IqqAprjk7MFYPSYyGrohU=;
 b=77LEiaAfjDKx/pZgJNsBh7pQWjCG+/1lRWhYQ4Yvc66Fe7/8uFnU9Wum6CEszzNP9Ps5bQ
 RTrCGOhMNKgCXcBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 140DB13AAE;
 Fri, 28 Jan 2022 13:30:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id w2QBAwbw82FQAgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 28 Jan 2022 13:30:46 +0000
Date: Fri, 28 Jan 2022 14:32:38 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <YfPwdgiq7MDM7E8a@yuki>
References: <20220125144043.31798-1-pvorel@suse.cz>
 <20220125144043.31798-2-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220125144043.31798-2-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/4] lapi/sched.h: Add include <sched.h>
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> We including headers in lapi headers instead of depending headers are
> included in tests which use lapi headers.

-ENOPARSE

The patch itself looks good though.

So maybe this should be something as:

Include <sched.h> and "lapi/syscalls.h" in "lapi/sched.h" instead of the
tests.

> Also remove redundant include lapi/syscalls.h from tests which use
> lapi/sched.h (included in lapi/sched.h).
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> New in v2
> 
>  include/lapi/sched.h                                      | 3 ++-
>  testcases/kernel/syscalls/kcmp/kcmp03.c                   | 1 -
>  testcases/kernel/syscalls/sched_getattr/sched_getattr01.c | 2 --
>  testcases/kernel/syscalls/sched_getattr/sched_getattr02.c | 2 --
>  testcases/kernel/syscalls/sched_setattr/sched_setattr01.c | 1 -
>  5 files changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/include/lapi/sched.h b/include/lapi/sched.h
> index 036edd51d1..2fc32a38ca 100644
> --- a/include/lapi/sched.h
> +++ b/include/lapi/sched.h
> @@ -6,9 +6,10 @@
>  #ifndef LAPI_SCHED_H__
>  #define LAPI_SCHED_H__
>  
> -#include "lapi/syscalls.h"
> +#include <sched.h>
>  #include <stdint.h>
>  #include <inttypes.h>
> +#include "lapi/syscalls.h"
>  
>  struct sched_attr {
>  	uint32_t size;
> diff --git a/testcases/kernel/syscalls/kcmp/kcmp03.c b/testcases/kernel/syscalls/kcmp/kcmp03.c
> index 30ac3ec9db..df8633c5fc 100644
> --- a/testcases/kernel/syscalls/kcmp/kcmp03.c
> +++ b/testcases/kernel/syscalls/kcmp/kcmp03.c
> @@ -18,7 +18,6 @@
>  
>  #include <errno.h>
>  #include <stdlib.h>
> -#include <sched.h>
>  #include <sys/wait.h>
>  #include "tst_test.h"
>  #include "kcmp.h"
> diff --git a/testcases/kernel/syscalls/sched_getattr/sched_getattr01.c b/testcases/kernel/syscalls/sched_getattr/sched_getattr01.c
> index 2a2c13a40f..0ffbce9c8d 100644
> --- a/testcases/kernel/syscalls/sched_getattr/sched_getattr01.c
> +++ b/testcases/kernel/syscalls/sched_getattr/sched_getattr01.c
> @@ -22,11 +22,9 @@
>  #include <linux/types.h>
>  #include <sys/syscall.h>
>  #include <pthread.h>
> -#include <sched.h>
>  #include <errno.h>
>  
>  #include "test.h"
> -#include "lapi/syscalls.h"
>  #include "lapi/sched.h"
>  
>  char *TCID = "sched_getattr01";
> diff --git a/testcases/kernel/syscalls/sched_getattr/sched_getattr02.c b/testcases/kernel/syscalls/sched_getattr/sched_getattr02.c
> index 2d7e15a470..9f4a09f88f 100644
> --- a/testcases/kernel/syscalls/sched_getattr/sched_getattr02.c
> +++ b/testcases/kernel/syscalls/sched_getattr/sched_getattr02.c
> @@ -31,11 +31,9 @@
>  #include <linux/types.h>
>  #include <sys/syscall.h>
>  #include <pthread.h>
> -#include <sched.h>
>  #include <errno.h>
>  
>  #include "test.h"
> -#include "lapi/syscalls.h"
>  #include "lapi/sched.h"
>  
>  char *TCID = "sched_getattr02";
> diff --git a/testcases/kernel/syscalls/sched_setattr/sched_setattr01.c b/testcases/kernel/syscalls/sched_setattr/sched_setattr01.c
> index 37ca56a0aa..82156b95cb 100644
> --- a/testcases/kernel/syscalls/sched_setattr/sched_setattr01.c
> +++ b/testcases/kernel/syscalls/sched_setattr/sched_setattr01.c
> @@ -29,7 +29,6 @@
>  #include <linux/types.h>
>  #include <sys/syscall.h>
>  #include <pthread.h>
> -#include <sched.h>
>  #include <errno.h>
>  
>  #include "test.h"
> -- 
> 2.34.1
> 

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
