Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 142CFC43334
	for <ltp@archiver.kernel.org>; Mon, 18 Jul 2022 09:56:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1FC4D3C94F7
	for <ltp@archiver.kernel.org>; Mon, 18 Jul 2022 11:56:44 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DE9933C9408
 for <ltp@lists.linux.it>; Mon, 18 Jul 2022 11:56:33 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 8E1D210007C0
 for <ltp@lists.linux.it>; Mon, 18 Jul 2022 11:56:32 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C5C122098E;
 Mon, 18 Jul 2022 09:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1658138191; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DKCDM+ITA+dnw3i+z0DGlv9SUUlrIm+MECaN6dovwqk=;
 b=RdXoOJB5YCLoL4aNFnay5ZQXVu3UTqv6/wsY/f0N5g7AVjlsH5ZsrNGTQmBgN0+UA0+slv
 BSj9GfDZzLXdmDjKXdJDmvAF5MWoA9Fh3/ncKfihpSyl1wcUue2vXiMX/kH3xD1t1v/u7b
 UB+pzvh4aEOFyA6BNx9LBoZSpAmKoo4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1658138191;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DKCDM+ITA+dnw3i+z0DGlv9SUUlrIm+MECaN6dovwqk=;
 b=omv9UpB6tpr7zk5Gco0FvHScfv3fOZhwxYIII/nYIEQm6LXMHWPhhkchJZB7cWnrAdKb7Y
 nPlxDLCx3HnGtfBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B412013A37;
 Mon, 18 Jul 2022 09:56:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id gJWuKk8u1WKlPQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 18 Jul 2022 09:56:31 +0000
Date: Mon, 18 Jul 2022 11:58:26 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Zhao Gongyi <zhaogongyi@huawei.com>
Message-ID: <YtUuwlgaFxufhSjY@yuki>
References: <20220702024428.207153-1-zhaogongyi@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220702024428.207153-1-zhaogongyi@huawei.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] syscalls/nice05: Add testcase for nice()
 syscall
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
> +static void verify_nice(void)
> +{
> +	intptr_t nice_inc_high = -1;
> +	intptr_t nice_inc_low = -2;
> +	char buf[4096] = {0};
> +	float sum_exec_runtime[2];
> +	pthread_t nice_low, nice_high;
> +	pid_t pid;
> +
> +	pid = SAFE_FORK();
> +	if (!pid) {
> +		TEST(pthread_barrier_init(&barrier, NULL, 3));
> +		if (TST_RET != 0) {
> +			tst_brk(TBROK | TTERRNO,
> +				"pthread_barrier_init() failed");
> +		}
> +
> +		SAFE_PTHREAD_CREATE(&nice_high, NULL, nice_high_thread,
> +			(void *)nice_inc_high);
> +		SAFE_PTHREAD_CREATE(&nice_low, NULL, nice_low_thread,
> +			(void *)nice_inc_low);
> +
> +		TEST(pthread_barrier_wait(&barrier));
> +		if (TST_RET != 0 && TST_RET != PTHREAD_BARRIER_SERIAL_THREAD) {
> +			tst_brk(TBROK | TTERRNO,
> +				"pthread_barrier_wait() failed");
> +		}
> +
> +		while (1)
> +			pause();
> +	}
> +
> +	sleep(tst_remaining_runtime());
> +	SAFE_KILL(pid, SIGSTOP);
> +
> +	sprintf(buf, "/proc/%d/sched", child_tid[0]);
> +	SAFE_FILE_SCANF(buf, "%*s %*s %*s %*s %*s"
> +			"%*s %*s %*f %*s %*s %*f %*s %*s %f",
> +			&sum_exec_runtime[0]);
> +
> +	sprintf(buf, "/proc/%d/sched", child_tid[1]);
> +	SAFE_FILE_SCANF(buf, "%*s %*s %*s %*s %*s"
> +			"%*s %*s %*f %*s %*s %*f %*s %*s %f",
> +			&sum_exec_runtime[1]);

The /proc/$PID/sched file is unfortunatelly only present if
CONFIG_SCHED_DEBUG was set in the kernel, which is not always the case,
and the test TBROKs on some of my testing targets.

Thinking of alternatives we can probably do clock_getcpuclockid() for
the threads and read the counters with clock_gettime().

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
