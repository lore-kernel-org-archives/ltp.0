Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDEEFC3ABCC
	for <ltp@archiver.kernel.org>; Tue, 13 May 2025 12:08:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F2A233CC334
	for <ltp@archiver.kernel.org>; Tue, 13 May 2025 14:08:14 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E69D13CAB8E
 for <ltp@lists.linux.it>; Tue, 13 May 2025 14:07:58 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id AA4EC6002C9
 for <ltp@lists.linux.it>; Tue, 13 May 2025 14:07:57 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B05661F786;
 Tue, 13 May 2025 12:07:56 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 982D71365D;
 Tue, 13 May 2025 12:07:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yMjiJBw2I2iAPwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 13 May 2025 12:07:56 +0000
Date: Tue, 13 May 2025 14:08:30 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <aCM2PrCrCdPqNIGc@yuki.lan>
References: <20250513050530.47541-1-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250513050530.47541-1-liwang@redhat.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: B05661F786
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] lib: initialize lib|main_pid to zero in the
 setup_ipc
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
> To get rid of failure from github CI.
> 
> CI Test Job: https://github.com/wangli5665/ltp/actions/runs/14988530205
> 
> Follow-up-fix: commit b987b8ac5 ("lib: child process exit with error due to uninitialized lib_pid")
> Signed-off-by: Li Wang <liwang@redhat.com>
> ---
>  lib/tst_test.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index b666715b9..9f11c1c47 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -59,7 +59,6 @@ static const char *tid;
>  static int iterations = 1;
>  static float duration = -1;
>  static float timeout_mul = -1;
> -static pid_t lib_pid;
>  static int mntpoint_mounted;
>  static int ovl_mounted;
>  static struct timespec tst_start_time; /* valid only for test pid */
> @@ -143,7 +142,9 @@ static void setup_ipc(void)
>  		tst_futexes = (char *)results + sizeof(struct results);
>  		tst_max_futexes = (size - sizeof(struct results))/sizeof(futex_t);
>  	}
> -	results->lib_pid = lib_pid;
> +
> +	results->lib_pid = 0;
> +	results->main_pid = 0;
>  }
>  
>  static void cleanup_ipc(void)
> @@ -394,7 +395,7 @@ void tst_vbrk_(const char *file, const int lineno, int ttype, const char *fmt,
>  	 * If tst_brk() is called from some of the C helpers even before the
>  	 * library was initialized, just exit.
>  	 */
> -	if (!results->lib_pid)
> +	if (!results || !results->lib_pid)
>  		exit(TTYPE_RESULT(ttype));
>  
>  	update_results(TTYPE_RESULT(ttype));
> @@ -1334,6 +1335,8 @@ static void do_setup(int argc, char *argv[])
>  		tst_test->forks_child = 1;
>  	}
>  
> +	setup_ipc();
> +
>  	if (tst_test->needs_kconfigs && tst_kconfig_check(tst_test->needs_kconfigs))
>  		tst_brk(TCONF, "Aborting due to unsuitable kernel config, see above!");
>  
> @@ -1393,8 +1396,6 @@ static void do_setup(int argc, char *argv[])
>  	if (tst_test->hugepages.number)
>  		tst_reserve_hugepages(&tst_test->hugepages);
>  
> -	setup_ipc();
> -

I suppose that this has to go before the tst_reserve_hugepages() so that
we have results->lib_pid defined and properly clean up after the
hugepages. However for that to work we have to set the
results->lib_pid directly in the setup_ipc().

>  	if (tst_test->bufs)
>  		tst_buffers_alloc(tst_test->bufs);
>  
> @@ -1929,10 +1930,11 @@ void tst_run_tcases(int argc, char *argv[], struct tst_test *self)
>  	unsigned int test_variants = 1;
>  	struct utsname uval;
>  
> -	lib_pid = getpid();
>  	tst_test = self;
>  
>  	do_setup(argc, argv);
> +
> +	results->lib_pid = getpid();

Setting it here is too late.

Other than that the patch looks good to me.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
