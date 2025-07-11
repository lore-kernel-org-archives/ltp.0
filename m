Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 480DDC83F1A
	for <ltp@archiver.kernel.org>; Fri, 11 Jul 2025 15:31:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8D2463CB2BB
	for <ltp@archiver.kernel.org>; Fri, 11 Jul 2025 17:31:55 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F2A313CB072
 for <ltp@lists.linux.it>; Fri, 11 Jul 2025 17:31:39 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 69EE9600914
 for <ltp@lists.linux.it>; Fri, 11 Jul 2025 17:31:37 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 75978211AB;
 Fri, 11 Jul 2025 15:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1752247895; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bINHW27BU71K79kYZD+FKYSHuHCR2GRcdpRIRIP1774=;
 b=ZIwLVC3zGf93zJ3OlESE4I4VVaDi03P5Be/bSewF/j/o23wTX2W+kp8XNUsMz2tOpkPE6X
 MEoP8PKwfJA4wF+esaoTquOfUfjfK4KO8W9DEAGbrlmmxFOLxttU4d8qafLhgK5qXKx2ZJ
 /Wq2tgxs7tlOT9YZrNGV8tMNh6qlUFY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1752247895;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bINHW27BU71K79kYZD+FKYSHuHCR2GRcdpRIRIP1774=;
 b=zuI+sBHF9iB7kgP8YC3QRv7QpOQEYimG0iQPzgtMlUeyUaKUAmzmdFrsZdbo6YlfPhbSAY
 TM930rKRTP5MZIDQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=c4rQpiTj;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=oZoAbmLf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1752247894; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bINHW27BU71K79kYZD+FKYSHuHCR2GRcdpRIRIP1774=;
 b=c4rQpiTjx6yTG3yAT/oMyrx6ZMNNgItFXqspmjuiwAo7P5JfLntJr7HCndvlRxcUolZldP
 gcfVAAPM8jqhFvJiJQyXglcqqUTiqsrdW9UpChnG81q1qDq8I9dSKh2j+VCg/x8Bo21tYM
 BOtIIEI9PciDmyMtFNuz90RR059xBYU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1752247894;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bINHW27BU71K79kYZD+FKYSHuHCR2GRcdpRIRIP1774=;
 b=oZoAbmLf0WEmBDKzHXqTjRMWgMLBrOA5vkp0ZzraMjQpkSZtqwBNnG4i0Sq3Pfgjoa0Fiq
 qLAMEaGNLYUvykBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 630C61388B;
 Fri, 11 Jul 2025 15:31:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uFfFF1YucWgUaAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 11 Jul 2025 15:31:34 +0000
Date: Fri, 11 Jul 2025 17:32:05 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: jiaying.song.cn@windriver.com
Message-ID: <aHEudV9Fk4lQJEWs@yuki.lan>
References: <20250428073811.133441-1-jiaying.song.cn@windriver.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250428073811.133441-1-jiaying.song.cn@windriver.com>
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MISSING_XM_UA(0.00)[];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_NONE(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: 75978211AB
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/stime: Fix Time Overflow for 2038
 Problem on 32-bit Systems
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
> Signed-off-by: Jiaying Song <jiaying.song.cn@windriver.com>
> ---
>  testcases/kernel/syscalls/stime/stime01.c   | 10 +++++-----
>  testcases/kernel/syscalls/stime/stime_var.h |  4 ++--
>  2 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/stime/stime01.c b/testcases/kernel/syscalls/stime/stime01.c
> index 82a340258..9e909d7ca 100644
> --- a/testcases/kernel/syscalls/stime/stime01.c
> +++ b/testcases/kernel/syscalls/stime/stime01.c
> @@ -33,7 +33,7 @@ static void run(void)
>  	new_time = real_time_tv.tv_sec + 30;
>  
>  	if (do_stime(&new_time) < 0) {
> -		tst_res(TFAIL | TERRNO, "stime(%ld) failed", new_time);
> +		tst_res(TFAIL | TERRNO, "stime(%jd) failed", (intmax_t)new_time);
>  		return;
>  	}
>  
> @@ -43,12 +43,12 @@ static void run(void)
>  	switch (pres_time_tv.tv_sec - new_time) {
>  	case 0:
>  	case 1:
> -		tst_res(TINFO, "pt.tv_sec: %ld", pres_time_tv.tv_sec);
> -		tst_res(TPASS, "system time was set to %ld", new_time);
> +		tst_res(TINFO, "pt.tv_sec: %jd", (intmax_t)pres_time_tv.tv_sec);
> +		tst_res(TPASS, "system time was set to %jd", (intmax_t)new_time);
>  	break;
>  	default:
> -		tst_res(TFAIL, "system time not set to %ld (got: %ld)",
> -			new_time, pres_time_tv.tv_sec);
> +		tst_res(TFAIL, "system time not set to %jd (got: %jd)",
> +			(intmax_t)new_time, (intmax_t)pres_time_tv.tv_sec);
>  	}
>  }
>  
> diff --git a/testcases/kernel/syscalls/stime/stime_var.h b/testcases/kernel/syscalls/stime/stime_var.h
> index 708b80573..326240972 100644
> --- a/testcases/kernel/syscalls/stime/stime_var.h
> +++ b/testcases/kernel/syscalls/stime/stime_var.h
> @@ -27,12 +27,12 @@ static int do_stime(time_t *ntime)
>  	case 1:
>  		return tst_syscall(__NR_stime, ntime);
>  	case 2: {
> -		struct __kernel_old_timeval tv;
> +		struct timeval tv;
>  
>  		tv.tv_sec = *ntime;
>  		tv.tv_usec = 0;
>  
> -		return tst_syscall(__NR_settimeofday, &tv, (struct timezone *) 0);
> +		return settimeofday(&tv, (struct timezone *) 0);

The point of this code is to call all possible kernel variants, so we
cant just change it like this.

I guess that the easiest fix is to set the new_time to a fixed value
that is not going to overflow.

Something like:

diff --git a/testcases/kernel/syscalls/stime/stime01.c b/testcases/kernel/syscalls/stime/stime01.c
index 82a340258..12b7ccb39 100644
--- a/testcases/kernel/syscalls/stime/stime01.c
+++ b/testcases/kernel/syscalls/stime/stime01.c
@@ -20,17 +20,12 @@
 #include "tst_test.h"
 #include "stime_var.h"

-static struct timeval real_time_tv;
-
 static void run(void)
 {
        time_t new_time;
        struct timeval pres_time_tv;

-       if (gettimeofday(&real_time_tv, NULL) < 0)
-               tst_brk(TBROK | TERRNO, "gettimeofday() failed");
-
-       new_time = real_time_tv.tv_sec + 30;
+       new_time = 1752247867;

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
