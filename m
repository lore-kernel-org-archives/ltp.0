Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D990BC4345F
	for <ltp@archiver.kernel.org>; Thu, 18 Apr 2024 16:35:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2ADB93CFBF8
	for <ltp@archiver.kernel.org>; Thu, 18 Apr 2024 18:35:22 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2C21A3CFAA3
 for <ltp@lists.linux.it>; Thu, 18 Apr 2024 18:35:07 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 792B860345C
 for <ltp@lists.linux.it>; Thu, 18 Apr 2024 18:35:05 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 618A63515C;
 Thu, 18 Apr 2024 16:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1713458105; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rIIpsrFOIU6xWrb+nkjLcQUnTBbiJs0QMAkwRqMjNqc=;
 b=vHeqB1PDt9iOI6463NX4oVaemk+8bUhPTwkpFlDPO5lqJJ8TtLNnIFlknD4nWKrgiDC0kD
 dIsnbzcnTJYjepsCVLmLh3cOVyF+GWVtUUHimv1EaVm72WUV4EY7NdSmX0z0Q1bGZU/XWj
 fmxGLqqiXox5L4fI5iWOiyi5Rba1neo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1713458105;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rIIpsrFOIU6xWrb+nkjLcQUnTBbiJs0QMAkwRqMjNqc=;
 b=t+GVvdCGLwR6kDtkOfMcUPLwWa1Hdb5exl6haiBxU+1PV0vI8eBb9XeZpC/lbCHjXz7tW0
 mqiq/PXFB4Ql0WDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1713458105; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rIIpsrFOIU6xWrb+nkjLcQUnTBbiJs0QMAkwRqMjNqc=;
 b=vHeqB1PDt9iOI6463NX4oVaemk+8bUhPTwkpFlDPO5lqJJ8TtLNnIFlknD4nWKrgiDC0kD
 dIsnbzcnTJYjepsCVLmLh3cOVyF+GWVtUUHimv1EaVm72WUV4EY7NdSmX0z0Q1bGZU/XWj
 fmxGLqqiXox5L4fI5iWOiyi5Rba1neo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1713458105;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rIIpsrFOIU6xWrb+nkjLcQUnTBbiJs0QMAkwRqMjNqc=;
 b=t+GVvdCGLwR6kDtkOfMcUPLwWa1Hdb5exl6haiBxU+1PV0vI8eBb9XeZpC/lbCHjXz7tW0
 mqiq/PXFB4Ql0WDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4F9BC13687;
 Thu, 18 Apr 2024 16:35:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id weOHErlLIWbMTwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 18 Apr 2024 16:35:05 +0000
Date: Thu, 18 Apr 2024 18:34:18 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <ZiFLikOzOFDwfR2d@yuki>
References: <20240418071422.10221-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240418071422.10221-1-wegao@suse.com>
X-Spamd-Result: default: False [-7.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_SOME(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_THREE(0.00)[3];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url, suse.com:email,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns, suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] swapping01.c: Add sleeps in the loop that
 dirties the memory
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
Cc: vbabka@suse.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> https://bugzilla.suse.com/show_bug.cgi?id=1217850#c34

If I'm counting right this is 10ms * 1024 which is 10s, I would be
happier with 1ms sleep instead. Or if we did 10ms sleep once every 10
memsets() instead.

Also since this was proposed by Vlastimil in the bugzilla he should
ideally give his ack here as well (now in CC).

> Signed-off-by: Wei Gao <wegao@suse.com>
> ---
>  testcases/kernel/mem/swapping/swapping01.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/mem/swapping/swapping01.c b/testcases/kernel/mem/swapping/swapping01.c
> index a0030a75f..338881c8e 100644
> --- a/testcases/kernel/mem/swapping/swapping01.c
> +++ b/testcases/kernel/mem/swapping/swapping01.c
> @@ -47,6 +47,7 @@
>  #define COE_DELTA       1
>  /* will try to alloc 1.3 * phy_mem */
>  #define COE_SLIGHT_OVER 0.3
> +#define MEM_SIZE 1024 * 1024
>  
>  static void init_meminfo(void);
>  static void do_alloc(int allow_raise);
> @@ -101,6 +102,13 @@ static void init_meminfo(void)
>  				swap_free_init, mem_over_max);
>  }
>  
> +static void memset_blocks(char *ptr, int mem_count, int sleep_time_ms) {
> +	for (int i = 0; i < mem_count / 1024; i++) {
> +		memset(ptr + (i * MEM_SIZE), 1, MEM_SIZE);
> +		usleep(sleep_time_ms * 1000);
> +	}
> +}
> +
>  static void do_alloc(int allow_raise)
>  {
>  	long mem_count;
> @@ -115,7 +123,7 @@ static void do_alloc(int allow_raise)
>  	if (allow_raise == 1)
>  		tst_res(TINFO, "try to allocate: %ld MB", mem_count / 1024);
>  	s = SAFE_MALLOC(mem_count * 1024);
> -	memset(s, 1, mem_count * 1024);
> +	memset_blocks(s, mem_count, 10);
>  
>  	if ((allow_raise == 1) && (raise(SIGSTOP) == -1)) {
>  		tst_res(TINFO, "memory allocated: %ld MB", mem_count / 1024);
> -- 
> 2.35.3
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
