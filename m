Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CBD5CFA76E
	for <ltp@archiver.kernel.org>; Fri, 21 Nov 2025 10:40:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1F3BA3CE112
	for <ltp@archiver.kernel.org>; Fri, 21 Nov 2025 11:40:45 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B1E193C753D
 for <ltp@lists.linux.it>; Fri, 21 Nov 2025 11:40:27 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 0911910009BB
 for <ltp@lists.linux.it>; Fri, 21 Nov 2025 11:40:26 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6AE4020F6B;
 Fri, 21 Nov 2025 10:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1763721625; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9UDiZaSMSrQYPWvzB1CmYpBWvniTufbKll07Pi3OQX8=;
 b=GcbOkSJ/eaYca+HB62781E2G+P0SJ8zQCbkWtzVJpp26a3ihZgbgcSYQvCoTf6HHAmWZB1
 4cJ8xX/T6+jwHjQpebpszBLxZsQ1XnDpuGFiU5jrXN8B1b8PCz627k5ROmgUw5qkpUWtC5
 DTYra4RN7Q0hIpoDFEDMbG3cq1tSVN4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1763721625;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9UDiZaSMSrQYPWvzB1CmYpBWvniTufbKll07Pi3OQX8=;
 b=qaoedqzULckefAk8Xh8cSvBWXzpDUG3BXH1+wNmwfKHSRit2UnP4mDuzYJc7d61UwTSUX2
 l9z48hfJcxeOPuCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1763721625; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9UDiZaSMSrQYPWvzB1CmYpBWvniTufbKll07Pi3OQX8=;
 b=GcbOkSJ/eaYca+HB62781E2G+P0SJ8zQCbkWtzVJpp26a3ihZgbgcSYQvCoTf6HHAmWZB1
 4cJ8xX/T6+jwHjQpebpszBLxZsQ1XnDpuGFiU5jrXN8B1b8PCz627k5ROmgUw5qkpUWtC5
 DTYra4RN7Q0hIpoDFEDMbG3cq1tSVN4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1763721625;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9UDiZaSMSrQYPWvzB1CmYpBWvniTufbKll07Pi3OQX8=;
 b=qaoedqzULckefAk8Xh8cSvBWXzpDUG3BXH1+wNmwfKHSRit2UnP4mDuzYJc7d61UwTSUX2
 l9z48hfJcxeOPuCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5A1F03EA61;
 Fri, 21 Nov 2025 10:40:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kn43FZlBIGmyNwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 21 Nov 2025 10:40:25 +0000
Date: Fri, 21 Nov 2025 11:41:17 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <aSBBzVaq4gJ6JfrK@yuki.lan>
References: <20251120163550.333241-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251120163550.333241-1-pvorel@suse.cz>
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
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
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
> This fixes ppc64le bare metal. It looks like kernel needs some time to
> update counters.

In this case I think that something is needed for the kernel to actually
do some readahead. The readahead() syscall is supposed to initiate
readahead but kernel will need some time for the actual readahead to
happen. And how much time will depend on the I/O speed and saturation of
the I/O bus/disk.

Adding a short sleep is a good start. However I'm afraid that we will
need a bit more complex solution to this problem. Maybe do a short
sleep, check the cache size and if it increased more than some
threshold, sleep again.

Something as:

	int retries = MAX_RETRIES;
	unsigned long cached_prev, cached_cur = get_cached_size();

	do {
		usleep(SHORT_SLEEP);

		cached_prev = cached_cur;
		cached_cur = get_cached_size();

		if (cached_cur < cached_prev)
			break;

		if (cached_cur-cached_prev < CACHE_INC_THRESHOLD)
			break;

	} while (retries-- > 0);

> Suggested-by: Cyril Hrubis <chrubis@suse.cz>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  testcases/kernel/syscalls/readahead/readahead02.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/testcases/kernel/syscalls/readahead/readahead02.c b/testcases/kernel/syscalls/readahead/readahead02.c
> index f007db187e..05537ca991 100644
> --- a/testcases/kernel/syscalls/readahead/readahead02.c
> +++ b/testcases/kernel/syscalls/readahead/readahead02.c
> @@ -173,6 +173,7 @@ static int read_testfile(struct tcase *tc, int do_readahead,
>  
>  			i++;
>  			offset += readahead_length;
> +			usleep(1500);
>  		} while ((size_t)offset < fsize);
>  		tst_res(TINFO, "readahead calls made: %zu", i);
>  		*cached = get_cached_size();
> -- 
> 2.51.0
> 

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
