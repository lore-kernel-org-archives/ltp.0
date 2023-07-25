Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B279C0015E
	for <ltp@archiver.kernel.org>; Tue, 25 Jul 2023 09:46:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AB4A73CB1BF
	for <ltp@archiver.kernel.org>; Tue, 25 Jul 2023 11:46:12 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3985C3C8B57
 for <ltp@lists.linux.it>; Tue, 25 Jul 2023 11:46:01 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 93A0B1400FB3
 for <ltp@lists.linux.it>; Tue, 25 Jul 2023 11:46:00 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 79E052232D;
 Tue, 25 Jul 2023 09:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1690278359;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sRRsK0MWZsgGPwAvMJrAlC4S25ExnpBdzjBg+/x4oVY=;
 b=fDqhegi5v3sh98SyVXiSB69C8muXFml6npJ9o5Sph4NoEbBSqkbKY9Rn2r7z+rQYahU64l
 hKZlj62ecQLlXcOs/3KMkO4C87wcYJsZv6yAJio1hZ/NTWGox5fgGlGSdPB/b/j6Td7fDj
 UtHZQlhxvf18dukWUWVK+rmx9w/YbI4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1690278359;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sRRsK0MWZsgGPwAvMJrAlC4S25ExnpBdzjBg+/x4oVY=;
 b=A0Aewd3GJOCQWaRE1SrqYv5c6rDe3OFcE6lW7o9RnGmfzCO/aTqX6lpFg6kFarXaZ9PRWM
 cx8e7GHwJDLPxhDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 532FE13487;
 Tue, 25 Jul 2023 09:45:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id M629EteZv2RBZAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 25 Jul 2023 09:45:59 +0000
Date: Tue, 25 Jul 2023 11:45:57 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Avinesh Kumar <akumar@suse.de>
Message-ID: <20230725094557.GA1629064@pevik>
References: <20230722134949.15684-1-akumar@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230722134949.15684-1-akumar@suse.de>
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/pipe07: Rewrite the test using new LTP
 API
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Avinesh,

generally LGTM, thank you.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

BTW it's funny that when run with valgrind, it fails because valgrind opens some
file descriptors:

$ valgrind ./pipe07
...
pipe07.c:45: TINFO: getdtablesize() = 1024
pipe07.c:49: TINFO: open fds before pipe() calls: 10
pipe07.c:54: TINFO: expected max fds to be opened by pipe(): 1014
==1629480== Warning: invalid file descriptor 1030 in syscall pipe2()
pipe07.c:69: TPASS: errno == EMFILE (24)
pipe07.c:70: TFAIL: exp_num_pipe_fds (1014) != num_pipe_fds (1020)

> +static void record_open_fds(void)
nit: num_opened_fds is used only in setup(), I'd personally return int
and store variable in setup().

>  {
> +	DIR *dir;
> +	struct dirent *ent;
> +	int fd;

> -	min = getdtablesize() - rec_fds_max;
> +	dir = SAFE_OPENDIR("/proc/self/fd");
...

> +static void run(void)
>  {
...
> +	do {
> +		TEST(pipe(fds));
> +		if (TST_RET != -1) {
nit: wouldn't be safer to use: if (!TST_RET) (i.e. for TST_RET == 0)
(we check that return on error is exactly -1, not > 0)

Kind regards,
Petr

> +			pipe_fds[num_pipe_fds++] = fds[0];
> +			pipe_fds[num_pipe_fds++] = fds[1];
>  		}
> +	} while (TST_RET != -1);

...

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
