Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7287CFC267
	for <ltp@archiver.kernel.org>; Fri, 21 Nov 2025 11:48:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 21D8C3CEF2D
	for <ltp@archiver.kernel.org>; Fri, 21 Nov 2025 12:48:06 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D86B23C9B22
 for <ltp@lists.linux.it>; Fri, 21 Nov 2025 12:47:49 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 48C72200A10
 for <ltp@lists.linux.it>; Fri, 21 Nov 2025 12:47:49 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CD2BB21274;
 Fri, 21 Nov 2025 11:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1763725668; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0tX60fRzQi65/nLya9fKfDMLT2A0MBrr+n0pRZbiQi4=;
 b=nuGhHOwv7mglqGavtWyPcKQtzSMNSgC+6IcCQwdiGnQsTiCRHa7qjbupLlzx96Jc3oF9O1
 YWcRPHgKd83k+aVFBE6PKTI9sh1r2mUgXsMFJ1CQaJwrRDzLey/W/jXiDgqWamS/RFYwG5
 NaDIiTnLSqVzwq7Hse0UU50lEmphVuU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1763725668;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0tX60fRzQi65/nLya9fKfDMLT2A0MBrr+n0pRZbiQi4=;
 b=gqKNuyIhZHswAuWoPTMTvPcozotow6aHFw5nWzx+r4jNcDR0r3Mv8NBn5QIwjvWV/7tXrr
 ysw0XboBwJmxMWBw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=wYskQk4I;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=3DTh03HV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1763725667; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0tX60fRzQi65/nLya9fKfDMLT2A0MBrr+n0pRZbiQi4=;
 b=wYskQk4IkWGNEmcsxVLr69Yc4XwQWb7KGvdrMeSHTTxBF/3xoKC/mvUOu8kxOogpplR7zi
 rV5cmI8qXjKkke45etSO7nED8MCgsayuCauiACx3HKEu1wUiAhr3qY7Y865vU3YE905tML
 8zl7Z5x1wMqhsVViYvSOG3udqJ9y3pc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1763725667;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0tX60fRzQi65/nLya9fKfDMLT2A0MBrr+n0pRZbiQi4=;
 b=3DTh03HV+M4Y2gjB0zyp2rdTkjVbrOg6EZnSD4MCXRMy4pl0vIw2CCKwgA2pncxwbE/ke9
 4x00HaCJdnYqVoAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BD9663EA61;
 Fri, 21 Nov 2025 11:47:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id zYJXLWNRIGm2dwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 21 Nov 2025 11:47:47 +0000
Date: Fri, 21 Nov 2025 12:48:31 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <aSBRj8vrMh4TJKbq@yuki.lan>
References: <20251120163550.333241-1-pvorel@suse.cz>
 <aSBBzVaq4gJ6JfrK@yuki.lan> <20251121104506.GA25561@pevik>
 <aSBQDg8PRXFK8GxB@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aSBQDg8PRXFK8GxB@yuki.lan>
X-Rspamd-Queue-Id: CD2BB21274
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 RCPT_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+];
 URIBL_BLOCKED(0.00)[suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,yuki.lan:mid];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim]
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] readahead02: Sleep 1.5 msec to fix problem on
 bare metal
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
> diff --git a/testcases/kernel/syscalls/readahead/readahead02.c b/testcases/kernel/syscalls/readahead/readahead02.c
> index f007db187..a2118c5ab 100644
> --- a/testcases/kernel/syscalls/readahead/readahead02.c
> +++ b/testcases/kernel/syscalls/readahead/readahead02.c
> @@ -39,6 +39,7 @@ static char testfile[PATH_MAX] = "testfile";
>  #define MEMINFO_FNAME "/proc/meminfo"
>  #define PROC_IO_FNAME "/proc/self/io"
>  #define DEFAULT_FILESIZE (64 * 1024 * 1024)
> +#define SHORT_SLEEP_US 5000
 
>  static size_t testfile_size = DEFAULT_FILESIZE;
>  static char *opt_fsizestr;
> @@ -173,6 +174,38 @@ static int read_testfile(struct tcase *tc, int do_readahead,
> 
>                         i++;
>                         offset += readahead_length;
> +
> +                       /*
> +                        * We assume that the worst case I/O speed is around
> +                        * 5MB/s which is roughly 5 bytes per 1 us, which gives
> +                        * us upper bound for retries that is readahead_size/(5
> +                        * SHORT_SLEEP_US).
> +                        *
> +                        * We also monitor the cache size increases before and
> +                        * after the sleep. With the same assumption about the
> +                        * speed we are supposed to read at least 5 * SHORT_SLEEP_US
> +                        * during that time. That amound is genreally quite close
> +                        * a page size so that we just assume
                                                               ^
			    that we sould continue as long as the cache
			    increases.
> +                        *
> +                        * Of course all of this is inprecise on multitasking
> +                        * OS however even on a system where there are several
> +                        * processes figthing for I/O this loop will wait as
> +                        * long a cache is increasing which will gives us high
> +                        * chance of waiting for the readahead to happen.
> +                        */
> +                       int retries = readahead_size / (5 * SHORT_SLEEP_US);
> +                       unsigned long cached_prev, cached_cur = get_cached_size();
> +
> +                       do {
> +                               usleep(SHORT_SLEEP_US);
> +
> +                               cached_prev = cached_cur;
> +                               cached_cur = get_cached_size();
> +
> +                               if (cached_cur <= cached_prev)
> +                                       break;
> +                       } while (retries-- > 0);
> +
>                 } while ((size_t)offset < fsize);
>                 tst_res(TINFO, "readahead calls made: %zu", i);
>                 *cached = get_cached_size();

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
