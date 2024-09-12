Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB110EED617
	for <ltp@archiver.kernel.org>; Thu, 12 Sep 2024 16:29:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 219863C26E1
	for <ltp@archiver.kernel.org>; Thu, 12 Sep 2024 18:29:41 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4F7D83C232A
 for <ltp@lists.linux.it>; Thu, 12 Sep 2024 18:29:24 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 3822A14000B5
 for <ltp@lists.linux.it>; Thu, 12 Sep 2024 18:29:23 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 27D0B21AF8;
 Thu, 12 Sep 2024 16:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1726158563; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cjBM95docv1pJ7K59MziJWeZioE0UP2ciqoDTj95Olw=;
 b=n0znT9eu/p8bM2CjHHurqhHSYdUtatG2Bmx6f7swYsOo7ZhD93OFu5haL8Urnb23rlOu3n
 YgPUBLmpM4mt3Z8b701ebuapixlla55TlwNjFFhuRHtLNg00dAi1C96//PEDYKe/Ub7Yhw
 43CRJ+ujXizEQ0jlXTzivhWE8FPVW3E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1726158563;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cjBM95docv1pJ7K59MziJWeZioE0UP2ciqoDTj95Olw=;
 b=HRPT+kVA6XqTYBl7PkR1PHER6ISqGxUGE6v5PDB5V3ej5AigJA1GUKfoQZJdTrvCyAO7vd
 BHXFhVS9X36gwPCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1726158562; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cjBM95docv1pJ7K59MziJWeZioE0UP2ciqoDTj95Olw=;
 b=vBxdZSEhBBzStwuOXOs4CCe3lRCW3lSzzxUCof2tPkEQWL07rrIXB+3yQC+fap62PCi7gG
 8vyOlJv7kJ8hfEqZ4Xze1ZRgaHE+tlR4H4gI3nGm47kC4NtSa1YfrMB3qUIpSKPAN3xK6h
 aVZh3Pwzz0E6MxbA5k9meSYpympIaq4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1726158562;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cjBM95docv1pJ7K59MziJWeZioE0UP2ciqoDTj95Olw=;
 b=cO1lrLpl2U/D+Plty9hoqFxoVCbNQ/SrqjgMlmpTuKTa3XJIlb03KK4XIV820K6x42ITuZ
 CZ+bdQBMYg5LE0CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0E61913AD8;
 Thu, 12 Sep 2024 16:29:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 3hi6AeIW42YOKwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 12 Sep 2024 16:29:22 +0000
Date: Thu, 12 Sep 2024 18:28:01 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <ZuMWkXlr5XPzosn3@yuki.lan>
References: <20240812-process_mrelease-v2-0-e61249986a0a@suse.com>
 <20240812-process_mrelease-v2-2-e61249986a0a@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240812-process_mrelease-v2-2-e61249986a0a@suse.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email, yuki.lan:mid,
 imap1.dmz-prg2.suse.org:helo, linux.it:url]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/3] Add process_mrelease01 test
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
Cc: Michal Hocko <mhocko@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> +static void run(void)
> +{
> +	int ret;
> +	int pidfd;
> +	int status;
> +	pid_t pid;
> +	int restart;
> +
> +	for (mem_size = CHUNK; mem_size < MAX_SIZE_MB; mem_size += CHUNK) {
> +		restart = 0;
> +
> +		pid = SAFE_FORK();
> +		if (!pid) {
> +			do_child(mem_size);
> +			exit(0);
> +		}
> +
> +		TST_CHECKPOINT_WAIT(0);
> +
> +		tst_disable_oom_protection(pid);
> +
> +		if (!memory_is_mapped(pid, *mem_addr, *mem_addr + mem_size)) {
> +			tst_res(TFAIL, "Memory is not mapped");
> +			break;
> +		}
> +
> +		pidfd = SAFE_PIDFD_OPEN(pid, 0);
> +
> +		tst_res(TINFO, "Parent: killing child with PID=%d", pid);
> +
> +		SAFE_KILL(pid, SIGKILL);
> +
> +		ret = tst_syscall(__NR_process_mrelease, pidfd, 0);
> +		if (ret == -1) {
> +			if (errno == ESRCH) {
> +				tst_res(TINFO, "Parent: child terminated before "
> +					"process_mrelease(). Increase memory size and "
> +					"restart test");
> +
> +				restart = 1;

Does this even happen? I suppose that until the child has been waited
for you shouldn't get ESRCH at all. The memory may be freed
asynchronously but the pidfd is valid until we do waitpid, at least
that's what the description says:

https://lore.kernel.org/linux-mm/20210902220029.bfau3YxNP%25akpm@linux-foundation.org/

But selftest seems to do the same loop on ESRCH so either the test or
the documentation is wrong.

Michal any idea which is correct?

> +			} else {
> +				tst_res(TFAIL | TERRNO, "process_mrelease(%d,0) error", pidfd);
> +			}
> +		} else {
> +			int timeout_ms = 1000;
> +
> +			tst_res(TPASS, "process_mrelease(%d,0) passed", pidfd);
> +
> +			while (memory_is_mapped(pid, *mem_addr, *mem_addr + mem_size) &&
> +				timeout_ms--)
> +				usleep(1000);
> +
> +			if (memory_is_mapped(pid, *mem_addr, *mem_addr + mem_size))
> +				tst_res(TFAIL, "Memory is still mapped inside child memory");
> +			else
> +				tst_res(TPASS, "Memory has been released");

As far as I understand this this will likely pass even without the
process_mrelease() call since the process address space is being teared
down anyways. But I do not have an idea how to make things better. I
guess that if we wanted to know for sure we would have to run some
complex statistics with and without the syscall and compare the
timings...


> +		}
> +
> +		SAFE_WAITPID(-1, &status, 0);
> +		SAFE_CLOSE(pidfd);
> +
> +		if (!restart)
> +			break;
> +	}
> +}
> +
> +static void setup(void)
> +{
> +	mem_addr = SAFE_MMAP(NULL,
> +		sizeof(unsigned long),
> +		PROT_READ | PROT_WRITE,
> +		MAP_SHARED | MAP_ANON,
> +		0, 0);
> +}
> +
> +static void cleanup(void)
> +{
> +	if (mem_addr)
> +		SAFE_MUNMAP(mem_addr, sizeof(unsigned long));
> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.needs_root = 1,
> +	.forks_child = 1,
> +	.min_kver = "5.15",
> +	.needs_checkpoints = 1,
> +};
> 
> -- 
> 2.43.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
