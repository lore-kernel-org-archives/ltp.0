Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B9C4C4332F
	for <ltp@archiver.kernel.org>; Tue, 12 Dec 2023 17:29:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 04FB13CF73F
	for <ltp@archiver.kernel.org>; Tue, 12 Dec 2023 18:29:47 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 814C43CBDE7
 for <ltp@lists.linux.it>; Tue, 12 Dec 2023 18:29:36 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 4EAAA1A0BC56
 for <ltp@lists.linux.it>; Tue, 12 Dec 2023 18:29:34 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2C6711FB82;
 Tue, 12 Dec 2023 17:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1702402172;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9LD9O/Fg0SxYuMyCJ1kD37M+8ldiZiQo1eRECHUEbyA=;
 b=T6wE0VFGpXoZEshIMCMDNdjOqCH/lCwk8GTgyaisHisv/DrAyTjqd7ASTt1Rnh7Z0xf2kN
 4MgGLt06xdhv4V3vOgsQkMKK4YadlB8fKfWJQznLFMi3hr3ZLXUcc6XUzLfjX6Bqs5BXGJ
 aXnskdQgoU13qHBafpRQ5INlgcYcnWk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1702402172;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9LD9O/Fg0SxYuMyCJ1kD37M+8ldiZiQo1eRECHUEbyA=;
 b=GDDKtlWZBmV03/zQLAH5BQ0yh3r9N4WLwXHsm2CeGpFAKVmJjJxUrj97ULIqwiLI6Px0Zt
 n7OynOfml7W4jcBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1702402172;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9LD9O/Fg0SxYuMyCJ1kD37M+8ldiZiQo1eRECHUEbyA=;
 b=T6wE0VFGpXoZEshIMCMDNdjOqCH/lCwk8GTgyaisHisv/DrAyTjqd7ASTt1Rnh7Z0xf2kN
 4MgGLt06xdhv4V3vOgsQkMKK4YadlB8fKfWJQznLFMi3hr3ZLXUcc6XUzLfjX6Bqs5BXGJ
 aXnskdQgoU13qHBafpRQ5INlgcYcnWk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1702402172;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9LD9O/Fg0SxYuMyCJ1kD37M+8ldiZiQo1eRECHUEbyA=;
 b=GDDKtlWZBmV03/zQLAH5BQ0yh3r9N4WLwXHsm2CeGpFAKVmJjJxUrj97ULIqwiLI6Px0Zt
 n7OynOfml7W4jcBQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 410BF132DC;
 Tue, 12 Dec 2023 17:29:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id JWJNCHuYeGV/CwAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Tue, 12 Dec 2023 17:29:31 +0000
Date: Tue, 12 Dec 2023 18:29:29 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20231212172929.GA629121@pevik>
References: <20231210094339.26971-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231210094339.26971-1-wegao@suse.com>
X-Spamd-Bar: ++
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=T6wE0VFG;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=GDDKtlWZ;
 dmarc=none;
 spf=softfail (smtp-out2.suse.de: 2a07:de40:b281:104:10:150:64:98 is neither
 permitted nor denied by domain of pvorel@suse.cz)
 smtp.mailfrom=pvorel@suse.cz
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [2.49 / 50.00];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
 TO_DN_SOME(0.00)[]; R_SPF_SOFTFAIL(4.60)[~all];
 RCVD_COUNT_THREE(0.00)[3]; DKIM_TRACE(0.00)[suse.cz:+];
 MX_GOOD(-0.01)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; BAYES_HAM(-3.00)[100.00%];
 ARC_NA(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DMARC_NA(1.20)[suse.cz]; NEURAL_SPAM_SHORT(0.20)[0.068];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]
X-Rspamd-Queue-Id: 2C6711FB82
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] swapping01.c: Reporting /proc/meminfo before
 test and at the moment of the failure
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

Hi Wei,

nit: the subject is:
"swapping01.c: Reporting /proc/meminfo before test and at the moment of the failure"

This is way too long, please make it shorter (it should be up to 72 chars),
you can write more at other lines (not everything have to be on the subject).

> Signed-off-by: Wei Gao <wegao@suse.com>
> ---
>  testcases/kernel/mem/swapping/swapping01.c | 24 +++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)

> diff --git a/testcases/kernel/mem/swapping/swapping01.c b/testcases/kernel/mem/swapping/swapping01.c
> index fc225e4a6..07d89f44b 100644
> --- a/testcases/kernel/mem/swapping/swapping01.c
> +++ b/testcases/kernel/mem/swapping/swapping01.c
> @@ -60,6 +60,17 @@ static long mem_over_max;
>  static pid_t pid;
>  static unsigned int start_runtime;

NOTE: we have tst_available_mem() and tst_available_swap() in
lib/tst_memutils.c. Wouldn't be they enough? Or other line from /proc/meminfo
(new function would need to be added)? I'm not sure myself.

Also, is it really needed to print both /proc/meminfo and /proc/PID/status?
And if it's needed, why other testcases/kernel/mem/ tests don't need it?
Notes below are if we decide that we want this (I'd like to hear others).

> +static void print_meminfo(char *path)

You use print_meminfo() for printing /proc/meminfo and /proc/PID/status.
Instead, there could be a generic function safe_print_file(char *path) either in
safe_macros.c or tst_print_file(char *path) in tst_safe_file_at.c (I slightly
prefer the first, there is a mess with files in lib/*.c, there are way too many
files with just few functions).
The function would also print TINFO message which file is printing.

And then, in lib/tst_memutils.c would be tst_print_meminfo() which would call
safe_print_file("/proc/meminfo") and tst_print_status(pid_t pid), which would do
sprintf(proc_status_path, "/proc/%d/status", pid) and call safe_print_file()
with the result.

NOTE: you need to add also function signature to corresponding include/*.h file.
This should be done as a separate commit, using function in swapping01.c would
be as a separate commit.

> +{
> +	FILE *file;
> +	char line[PATH_MAX];
> +
> +	file = SAFE_FOPEN(path, "r");
> +	while (fgets(line, sizeof(line), file))
> +		tst_res(TINFO, "%s", line);
> +	SAFE_FCLOSE(file);
> +}
> +
>  static void test_swapping(void)
>  {
>  #ifdef TST_ABI32
> @@ -84,6 +95,8 @@ static void test_swapping(void)
>  	switch (pid = SAFE_FORK()) {
>  	case 0:
>  		do_alloc(0);
> +		tst_res(TINFO, "Meminfo before check:");
IMHO this TINFO should be removed (TINFO in the printing function is enough).

> +		print_meminfo("/proc/meminfo");


>  		do_alloc(1);
>  		exit(0);
>  	default:
> @@ -108,9 +121,11 @@ static void do_alloc(int allow_raise)
>  	long mem_count;
>  	void *s;

> -	if (allow_raise == 1)
> +	if (allow_raise == 1) {
> +		init_meminfo();
Why this? You haven't mentioned it in the commit message.

>  		tst_res(TINFO, "available physical memory: %ld MB",
>  				mem_available_init / 1024);
> +	}
...

>  	swapped = SAFE_READ_PROC_STATUS(pid, "VmSwap:");
>  	if (swapped > mem_over_max) {
> +		tst_res(TINFO, "Heavy swapping detected, print meminfo:");
Again, I'd prefer generic message in print_meminfo() (on a single place).
IMHO it will be obvious that first print is before test and the second after.

Kind regards,
Petr
> +		print_meminfo("/proc/meminfo");
> +		tst_res(TINFO, "Heavy swapping detected, print proc status:");
> +		sprintf(proc_status_path, "/proc/%d/status", pid);
> +		print_meminfo(proc_status_path);
>  		kill(pid, SIGCONT);
>  		tst_brk(TFAIL, "heavy swapping detected: "
>  				"%ld MB swapped.", swapped / 1024);

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
