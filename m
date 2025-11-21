Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD10BCFC267
	for <ltp@archiver.kernel.org>; Fri, 21 Nov 2025 11:41:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4C81A3CF308
	for <ltp@archiver.kernel.org>; Fri, 21 Nov 2025 12:41:36 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 080353CCCB7
 for <ltp@lists.linux.it>; Fri, 21 Nov 2025 12:41:19 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4C56F602198
 for <ltp@lists.linux.it>; Fri, 21 Nov 2025 12:41:19 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 89EED20F81;
 Fri, 21 Nov 2025 11:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1763725278; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AVI8QgR5NmsFvmOOn0lw62vy40p6htD7R/4kg+N9WII=;
 b=1XXKYQkeblPmGC1Jjbscgf8CsiVNxXgATosK/IIGhrpS9ugNSayqCjUd2Wm0s6bP8BWWy5
 KI22xBP0XA33qI57/5Foh/TDgwM8iedjoV5S5N8CuKxLzFoM/nx+tNW1TbythuFUs6mEq1
 XfyAH2C0kR5GKvUVnECWNRVGeJkoUIw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1763725278;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AVI8QgR5NmsFvmOOn0lw62vy40p6htD7R/4kg+N9WII=;
 b=N7oTe18BZSfT4CsStwpFEzj8JmTu8iEzZZukMv5bdXV+Bp8+nMi9EDWTBRnCwPy9GCJqV2
 /cgy5Q7ZkcA3UhCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1763725278; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AVI8QgR5NmsFvmOOn0lw62vy40p6htD7R/4kg+N9WII=;
 b=1XXKYQkeblPmGC1Jjbscgf8CsiVNxXgATosK/IIGhrpS9ugNSayqCjUd2Wm0s6bP8BWWy5
 KI22xBP0XA33qI57/5Foh/TDgwM8iedjoV5S5N8CuKxLzFoM/nx+tNW1TbythuFUs6mEq1
 XfyAH2C0kR5GKvUVnECWNRVGeJkoUIw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1763725278;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AVI8QgR5NmsFvmOOn0lw62vy40p6htD7R/4kg+N9WII=;
 b=N7oTe18BZSfT4CsStwpFEzj8JmTu8iEzZZukMv5bdXV+Bp8+nMi9EDWTBRnCwPy9GCJqV2
 /cgy5Q7ZkcA3UhCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 75C8C3EA61;
 Fri, 21 Nov 2025 11:41:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QpR/Gt5PIGlWcQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 21 Nov 2025 11:41:18 +0000
Date: Fri, 21 Nov 2025 12:42:06 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <aSBQDg8PRXFK8GxB@yuki.lan>
References: <20251120163550.333241-1-pvorel@suse.cz>
 <aSBBzVaq4gJ6JfrK@yuki.lan> <20251121104506.GA25561@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251121104506.GA25561@pevik>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
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
> > Adding a short sleep is a good start. However I'm afraid that we will
> > need a bit more complex solution to this problem. Maybe do a short
> > sleep, check the cache size and if it increased more than some
> > threshold, sleep again.
> 
> > Something as:
> 
> > 	int retries = MAX_RETRIES;
> > 	unsigned long cached_prev, cached_cur = get_cached_size();
> 
> > 	do {
> > 		usleep(SHORT_SLEEP);
> 
> > 		cached_prev = cached_cur;
> > 		cached_cur = get_cached_size();
> 
> > 		if (cached_cur < cached_prev)
> > 			break;
> 
> > 		if (cached_cur-cached_prev < CACHE_INC_THRESHOLD)
> > 			break;
> 
> > 	} while (retries-- > 0);
> 
> Yeah, few loops with shorter usleep() and proactive checking is for sure way
> better than single usleep(). Will you please have time to send the above as a
> patch? I'll test it for you.

The hard part is tuning the constants right.

If we assume that on the slowest low end device we would get around
5MB/s (that's how slow SD card in RPi can apparently be
https://elinux.org/RPi_SD_cards#SD_card_performance)
If we allow this to be a bit less precise we can assume that the speed is
5 bytes per 1 us (since USEC_PER_SEC / BYTES_IN_MB is roughtly 1).

From that the number of retries should be the readahead_size / (5*SHORT_SLEEP)
and I would put the short sleep somewhere around the
a few miliseconds range, that would mean that the number of retries
would end up between thousand and hundred when readahead_size is in
megabytes. This also means that we can assume that the minimal size to
be read in one loop is 5 * SLEEP_SIZE bytes. However with SLEEP_TIME in
a few milisecond range the minimal number of bytes is in the range of a
few pages so I guess that we can settle for running the loop for as long
as the cache increases.

So I suppose that we want something as:

diff --git a/testcases/kernel/syscalls/readahead/readahead02.c b/testcases/kernel/syscalls/readahead/readahead02.c
index f007db187..a2118c5ab 100644
--- a/testcases/kernel/syscalls/readahead/readahead02.c
+++ b/testcases/kernel/syscalls/readahead/readahead02.c
@@ -39,6 +39,7 @@ static char testfile[PATH_MAX] = "testfile";
 #define MEMINFO_FNAME "/proc/meminfo"
 #define PROC_IO_FNAME "/proc/self/io"
 #define DEFAULT_FILESIZE (64 * 1024 * 1024)
+#define SHORT_SLEEP_US 5000

 static size_t testfile_size = DEFAULT_FILESIZE;
 static char *opt_fsizestr;
@@ -173,6 +174,38 @@ static int read_testfile(struct tcase *tc, int do_readahead,

                        i++;
                        offset += readahead_length;
+
+                       /*
+                        * We assume that the worst case I/O speed is around
+                        * 5MB/s which is roughly 5 bytes per 1 us, which gives
+                        * us upper bound for retries that is readahead_size/(5
+                        * SHORT_SLEEP_US).
+                        *
+                        * We also monitor the cache size increases before and
+                        * after the sleep. With the same assumption about the
+                        * speed we are supposed to read at least 5 * SHORT_SLEEP_US
+                        * during that time. That amound is genreally quite close
+                        * a page size so that we just assume
+                        *
+                        * Of course all of this is inprecise on multitasking
+                        * OS however even on a system where there are several
+                        * processes figthing for I/O this loop will wait as
+                        * long a cache is increasing which will gives us high
+                        * chance of waiting for the readahead to happen.
+                        */
+                       int retries = readahead_size / (5 * SHORT_SLEEP_US);
+                       unsigned long cached_prev, cached_cur = get_cached_size();
+
+                       do {
+                               usleep(SHORT_SLEEP_US);
+
+                               cached_prev = cached_cur;
+                               cached_cur = get_cached_size();
+
+                               if (cached_cur <= cached_prev)
+                                       break;
+                       } while (retries-- > 0);
+
                } while ((size_t)offset < fsize);
                tst_res(TINFO, "readahead calls made: %zu", i);
                *cached = get_cached_size();


Li, Jan what do you think?

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
