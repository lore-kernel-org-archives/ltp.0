Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 836C5CD1284
	for <ltp@archiver.kernel.org>; Thu, 28 Mar 2024 17:23:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A7DD03C2DFC
	for <ltp@archiver.kernel.org>; Thu, 28 Mar 2024 18:23:55 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9FF953C03F4
 for <ltp@lists.linux.it>; Thu, 28 Mar 2024 18:23:40 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id DD2B67A628C
 for <ltp@lists.linux.it>; Thu, 28 Mar 2024 18:23:39 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3A94C341C7;
 Thu, 28 Mar 2024 17:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1711646618; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vfDzeMn+NDglLg2ckOd6r5ZChX553MJ5WaURujYTxT0=;
 b=lmX4cpEgAeyzJJvkw0brI3FBxpxO//DfR0jkxV3tbbieSRnWzqLdsot1nSozTPeAuekA9q
 GPpmIVqOto8HpNbdzOeckdfUKsT7r4YubXBg083sfMXvTV5VbjllQL7ZsL+EAaWIjIRykC
 z0JEVhAo04OWb61VwjmYwGknprsTMm8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1711646618;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vfDzeMn+NDglLg2ckOd6r5ZChX553MJ5WaURujYTxT0=;
 b=NHMTJvtwWRORcb0AOaL96p08kbCzcw5WitOHFJkRqkZMDOzoAI4boK7D5LpuDu7/PtEGjE
 s7hfhc4VED78V+CQ==
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 24D7D13A94;
 Thu, 28 Mar 2024 17:23:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap2.dmz-prg2.suse.org with ESMTPSA id qp+yCJqnBWZlCwAAn2gu4w
 (envelope-from <chrubis@suse.cz>); Thu, 28 Mar 2024 17:23:38 +0000
Date: Thu, 28 Mar 2024 18:22:48 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Hui Min Mina Chou <minachou@andestech.com>
Message-ID: <ZgWnaDxy2JWU-gMB@yuki>
References: <20240328084000.320291-1-minachou@andestech.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240328084000.320291-1-minachou@andestech.com>
X-Spamd-Result: default: False [-1.64 / 50.00]; BAYES_HAM(-1.84)[94.08%];
 MID_RHS_NOT_FQDN(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:rdns,
 imap2.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] waitid10: Set the core dump file location to
 temporary directory
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
Cc: tim609@andestech.com, cynthia@andestech.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Reference to madvise08, set the core dump file location to
> temporary directory, and restore default value after testing.
> 
>  # ./waitid10
>  tst_buffers.c:56: TINFO: Test is using guarded buffers
>  tst_test.c:1709: TINFO: LTP version: 20240129-45-g69537563d16a
>  tst_test.c:1593: TINFO: Timeout per run is 0h 05m 00s
>  waitid10.c:60: TINFO: Temporary core pattern is '/tmp/LTP_waiTF0QR3/core'
>  waitid10.c:73: TINFO: Raising RLIMIT_CORE rlim_cur=0 -> 0
>  waitid10.c:38: TPASS: waitid(P_ALL, 0, infop, WEXITED) passed
>  waitid10.c:39: TPASS: infop->si_pid == pidchild (304)
>  waitid10.c:40: TPASS: infop->si_status == SIGFPE (8)
>  waitid10.c:41: TPASS: infop->si_signo == SIGCHLD (17)
>  waitid10.c:44: TPASS: infop->si_code == CLD_DUMPED (3)

This description is missing the main point, that is why is this change
needed.

> Signed-off-by: Hui Min Mina Chou <minachou@andestech.com>
> ---
>  testcases/kernel/syscalls/waitid/waitid10.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/syscalls/waitid/waitid10.c b/testcases/kernel/syscalls/waitid/waitid10.c
> index e55e88c2325e..3e48f52d0ea8 100644
> --- a/testcases/kernel/syscalls/waitid/waitid10.c
> +++ b/testcases/kernel/syscalls/waitid/waitid10.c
> @@ -16,6 +16,8 @@
>  #include <sys/prctl.h>
>  #include "tst_test.h"
>  
> +#define CORE_PATTERN "/proc/sys/kernel/core_pattern"
> +
>  static siginfo_t *infop;
>  static int core_dumps = 1;
>  
> @@ -48,9 +50,16 @@ static void setup(void)
>  {
>  	struct rlimit rlim;
>  	char c;
> +	char cwd[1024];
> +	char tmpcpattern[1048];
>  
>  	SAFE_GETRLIMIT(RLIMIT_CORE, &rlim);
> -	SAFE_FILE_SCANF("/proc/sys/kernel/core_pattern", "%c", &c);
> +
> +	SAFE_GETCWD(cwd, sizeof(cwd));
> +	snprintf(tmpcpattern, sizeof(tmpcpattern), "%s/core", cwd);
> +	tst_res(TINFO, "Temporary core pattern is '%s'", tmpcpattern);
> +	SAFE_FILE_PRINTF(CORE_PATTERN, "%s", tmpcpattern);
> +	SAFE_FILE_SCANF(CORE_PATTERN, "%c", &c);

Also why has to be the pattern absolute path?

If this is really needed we can as well do:

	.needs_tmpdir = 1,
	.save_restore = (const struct tst_path_val[]) {
		{CORE_PATTERN, "./core", TST_SR_TCONF},
		{}
	},

And be done with it.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
