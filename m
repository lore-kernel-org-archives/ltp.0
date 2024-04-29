Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DEC8C4345F
	for <ltp@archiver.kernel.org>; Mon, 29 Apr 2024 09:18:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 817D13D03DA
	for <ltp@archiver.kernel.org>; Mon, 29 Apr 2024 11:18:37 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6F8643C62EE
 for <ltp@lists.linux.it>; Mon, 29 Apr 2024 11:18:22 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A19FF204B54
 for <ltp@lists.linux.it>; Mon, 29 Apr 2024 11:18:20 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7A12B2041F;
 Mon, 29 Apr 2024 09:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1714382299; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eiXFPu/MhkfMAAnj5QGad2fghlX+iJrV6K0tOioZrNw=;
 b=bLR3KTUyDsEKi9f6EvnPlEzQKZXuBajVc/AhcHgbwezgroeH/nBAOIzZiMaG1qFAY1gX40
 njt0FnXEOqFlbDfKklf8NdPL8a/PK9AgoC+Zv95yd2rj2Z+NlUznCfbFDu5hC3+tio8rU2
 nt5Lk5lGemNYvXtmbRN0asl4lH/U7DQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1714382299;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eiXFPu/MhkfMAAnj5QGad2fghlX+iJrV6K0tOioZrNw=;
 b=pebJ8acNNpXzU5tuorLLzfY6YEHrW+rlZ6GFhq+mLpt+ZiE5JZfDnp8CZD51KY+tsC9TmX
 zxzSXtNnDma+JyDQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=hARk6Xvp;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=qqobzeka
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1714382298; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eiXFPu/MhkfMAAnj5QGad2fghlX+iJrV6K0tOioZrNw=;
 b=hARk6XvpzrP7gTKj99PwFc5eBxuuDfowPE52mk4NOt1sKSQ/TQO/8Ht+VDK0R4hoTXugz7
 JsjNBpPVi6QoSoYu9tn0YCGxhYkMlGF97ngumRvJQiyyvmiRN+yS3TdJCeN2CIJosQanrD
 s5JtHdzXCLI1HUJOACHUqlgmA0vrrCw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1714382298;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eiXFPu/MhkfMAAnj5QGad2fghlX+iJrV6K0tOioZrNw=;
 b=qqobzekaMCjHMGwTF7jnn/3swG2LMZ51AmWalvlTq3DTXtCnd5m3012Rn5j+3LcS+aFKK4
 C+pQp/GsDqalqGCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 61764138A7;
 Mon, 29 Apr 2024 09:18:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 5cDYFtplL2Z8HAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 29 Apr 2024 09:18:18 +0000
Date: Mon, 29 Apr 2024 11:17:23 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: John Stultz <jstultz@google.com>
Message-ID: <Zi9lo1ubVkGJHzrF@yuki>
References: <20240423225821.4003538-1-jstultz@google.com>
 <20240423225821.4003538-7-jstultz@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240423225821.4003538-7-jstultz@google.com>
X-Spamd-Result: default: False [-4.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 MISSING_XM_UA(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim, suse.cz:email,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns, linux.it:url]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 7A12B2041F
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 6/6] sched_football: Add trace_marker messages if
 we're tracing
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
Cc: kernel-team@android.com, Darren Hart <darren@os.amperecomputing.com>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Cc: kernel-team@android.com
> Cc: Darren Hart <darren@os.amperecomputing.com>
> Signed-off-by: John Stultz <jstultz@google.com>
> ---
>  .../realtime/func/sched_football/sched_football.c    | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/testcases/realtime/func/sched_football/sched_football.c b/testcases/realtime/func/sched_football/sched_football.c
> index 45fbf6766..ca44584b0 100644
> --- a/testcases/realtime/func/sched_football/sched_football.c
> +++ b/testcases/realtime/func/sched_football/sched_football.c
> @@ -67,6 +67,7 @@
>  #include <pthread.h>
>  #include <sched.h>
>  #include <errno.h>
> +#include <fcntl.h>
>  #include <sys/syscall.h>
>  #include <unistd.h>
>  #include <sys/prctl.h>
> @@ -167,10 +168,14 @@ void *thread_offense(void *arg)
>  	return NULL;
>  }
>  
> +#define BUF_LEN 256
>  int referee(int game_length)
>  {
>  	struct timeval start, now;
> +	char buf[BUF_LEN];
>  	int final_ball;
> +	int fd = open("/sys/kernel/tracing/trace_marker", O_RDWR, 0);
> +	int ret;
>  
>  	prctl(PR_SET_NAME, "referee", 0, 0, 0);
>  	printf("Game On (%d seconds)!\n", game_length);
> @@ -178,14 +183,19 @@ int referee(int game_length)
>  	gettimeofday(&start, NULL);
>  	now = start;
>  
> +	sprintf(buf, "I|%i|Game_Started!\n", getpid());
>  	/* Start the game! */
>  	atomic_set(0, &the_ball);
> -
> +	if (fd > 0)
> +		ret = write(fd, buf, strnlen(buf, BUF_LEN));
>  	/* Watch the game */
>  	while ((now.tv_sec - start.tv_sec) < game_length) {
>  		sleep(1);
>  		gettimeofday(&now, NULL);
>  	}
> +	sprintf(buf, "I|%i|Game_Over!\n", getpid());
> +	if (fd > 0)
> +		ret = write(fd, buf, strnlen(buf, BUF_LEN));

I know that we havre only two usages now, but it would be a bit cleaner
and readable to have a function to print the messages, e.g.

static void tracer_write(const char *msg);

And we would do:

	tracer_write("Game_Started!");

It would be a good idea to add the test name to the message as well,
maybe as:

	sprintf(buf, "sched_football|%i|%s\n", getpid(), msg);

>  	final_ball = atomic_get(&the_ball);
>  	/* Blow the whistle */
>  	printf("Game Over!\n");
> -- 
> 2.44.0.769.g3c40516874-goog
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
