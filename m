Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01CC5CD5BB1
	for <ltp@archiver.kernel.org>; Tue, 26 May 2026 16:10:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8627E3C5F08
	for <ltp@archiver.kernel.org>; Tue, 26 May 2026 18:10:04 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 52B223C0D0D
 for <ltp@lists.linux.it>; Tue, 26 May 2026 18:09:46 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C37AB20035F
 for <ltp@lists.linux.it>; Tue, 26 May 2026 18:09:45 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2C3B56AE3F;
 Tue, 26 May 2026 16:09:45 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1CECD5A2BC;
 Tue, 26 May 2026 16:09:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id rD4nBsnFFWrxEwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 26 May 2026 16:09:45 +0000
Date: Tue, 26 May 2026 18:09:38 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Jan Polensky <japo@linux.ibm.com>
Message-ID: <ahXFwvzP7slVTA4C@yuki.lan>
References: <20260526150813.201280-1-japo@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260526150813.201280-1-japo@linux.ibm.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Queue-Id: 2C3B56AE3F
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 1/1] thp04: Skip when FOLL_FORCE writes are
 disabled
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
> CONFIG_PROC_MEM_NO_FORCE or proc_mem_force_write=0 as a security
> hardening measure.

Looking at the recent kernel commit the default changed from
CONFIG_PROC_MEM_ALWAYS_FORCE to CONFIG_PROC_MEM_FORCE_PTRACE recently
(599bbba5a "proc: make PROC_MEM_FORCE_PTRACE the Kconfig default"). That
means that the test can probably be adjusted to ptrace() itself from a
separate thread that runs the test and it should work with the new
upstream defaults.

> On such systems, thp04 fails with EIO during the /proc/self/mem write.
> This is expected kernel behavior, not a real test failure.
> 
> Add a pre-flight write check in setup() and return TCONF on EIO, with
> an explanation that FOLL_FORCE writes are disabled by kernel hardening.
> 
> This makes thp04 skip on hardened systems instead of reporting a false
> failure.
> 
> Signed-off-by: Jan Polensky <japo@linux.ibm.com>
> ---
>  testcases/kernel/mem/thp/thp04.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/testcases/kernel/mem/thp/thp04.c b/testcases/kernel/mem/thp/thp04.c
> index 16d766c349b7..a5748c09cb70 100644
> --- a/testcases/kernel/mem/thp/thp04.c
> +++ b/testcases/kernel/mem/thp/thp04.c
> @@ -73,6 +73,7 @@ static void *alloc_zero_page(void *baseaddr)
>  static void setup(void)
>  {
>  	size_t i;
> +	int test_val = 0;
>  
>  	thp_size = tst_get_hugepage_size();
>  
> @@ -93,6 +94,28 @@ static void setup(void)
>  	writefd = SAFE_OPEN("/proc/self/mem", O_RDWR);
>  	readfd = SAFE_OPEN("/proc/self/mem", O_RDWR);
>  
> +	/*
> +	 * Test if /proc/self/mem write with FOLL_FORCE works. Since kernel commit
> +	 * 41e8149c8892 ("proc: add config & param to block forcing mem writes")
> +	 * (Aug 2024), writes can be blocked by CONFIG_PROC_MEM_NO_FORCE or
> +	 * proc_mem_force_write=0 boot param.
> +	 */
> +	TEST(lseek(writefd, (off_t)write_ptr, SEEK_SET));
> +	if (TST_RET == -1)
> +		tst_brk(TBROK | TTERRNO, "lseek on /proc/self/mem failed");
> +
> +	TEST(write(writefd, &test_val, sizeof(test_val)));
> +	if (TST_RET == -1) {
> +		if (TST_ERR == EIO) {
> +			tst_brk(TCONF,
> +				"/proc/self/mem write with FOLL_FORCE is disabled. "
> +				"This is a kernel security feature (commit 41e8149c8892). "
> +				"To enable: boot with proc_mem_force_write=1 or "

AFAIK there is no proc_mem_force_write there seems to be
proc_mem.force_override that can be set to "always", "ptrace", and
"never" though.

Also LTP has /proc/cmdline and kernel .config parsers hence we can be
smarter that this and actually detect the configuration.

Something as:

        static struct tst_kcmdline_var vars[] = {
                TST_KCMDLINE_INIT("proc_mem.force_override"),
        };

        tst_kcmdline_parse(params, ARRAY_SIZE(vars));

	if (vars[0].found && strcmp(vars[0].value, "always"))
		tst_brk(TCONF, "Writes to /proc/$pid/mem disabled on kernel cmdline");
	else
		tst_brk(TCONF, "Writes to /proc/$pid/mem disabled in kernel .config")

> +				"rebuild kernel with CONFIG_PROC_MEM_FORCE_WRITE=y");
> +		}
> +		tst_brk(TBROK | TTERRNO, "test write to /proc/self/mem failed");
> +	}
> +
>  	fzsync_pair.exec_loops = 100000;
>  	tst_fzsync_pair_init(&fzsync_pair);
>  }
> -- 
> 2.54.0
> 

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
