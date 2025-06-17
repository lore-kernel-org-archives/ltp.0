Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD01AC71136
	for <ltp@archiver.kernel.org>; Tue, 17 Jun 2025 12:18:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0AC2B3CC21E
	for <ltp@archiver.kernel.org>; Tue, 17 Jun 2025 14:18:43 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CE1EB3C9D27
 for <ltp@lists.linux.it>; Tue, 17 Jun 2025 14:18:24 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 0B7191A001FE
 for <ltp@lists.linux.it>; Tue, 17 Jun 2025 14:18:23 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2F8322116E;
 Tue, 17 Jun 2025 12:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1750162703; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LsBYwI0Io4JmRFx6DWAcvTdD169CTPBbGt7zcM9N/nQ=;
 b=l66ax0UnT/d9PvhQUUhzSkzsxja350HdSOkrb9gsc+vknPjWAJtNeQdsJNiJWcgToLbOWp
 NoU4kHqdOn+8dWbm+9hN3QWGR8O0ARwlj6p8UMlEZhavWwI2CisgpLJwKXfd1EVotL7pBd
 zKdHpXg57C0U4A9ubNWTWQaX6v4QpnY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1750162703;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LsBYwI0Io4JmRFx6DWAcvTdD169CTPBbGt7zcM9N/nQ=;
 b=ignSvfvnZ5E0UNfuL+G0XKhnMfSBLP05QM21m5f10TusBWfVNbxqm7dxfKT1QohMmutJIW
 B6gl+6U5o8eLowDA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=l66ax0Un;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ignSvfvn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1750162703; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LsBYwI0Io4JmRFx6DWAcvTdD169CTPBbGt7zcM9N/nQ=;
 b=l66ax0UnT/d9PvhQUUhzSkzsxja350HdSOkrb9gsc+vknPjWAJtNeQdsJNiJWcgToLbOWp
 NoU4kHqdOn+8dWbm+9hN3QWGR8O0ARwlj6p8UMlEZhavWwI2CisgpLJwKXfd1EVotL7pBd
 zKdHpXg57C0U4A9ubNWTWQaX6v4QpnY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1750162703;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LsBYwI0Io4JmRFx6DWAcvTdD169CTPBbGt7zcM9N/nQ=;
 b=ignSvfvnZ5E0UNfuL+G0XKhnMfSBLP05QM21m5f10TusBWfVNbxqm7dxfKT1QohMmutJIW
 B6gl+6U5o8eLowDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 216C113AE2;
 Tue, 17 Jun 2025 12:18:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 1gBuBw9dUWi+PwAAD6G6ig
 (envelope-from <akumar@suse.de>); Tue, 17 Jun 2025 12:18:23 +0000
From: Avinesh Kumar <akumar@suse.de>
To: Li Wang <liwang@redhat.com>
Date: Tue, 17 Jun 2025 14:18:22 +0200
Message-ID: <6179048.lOV4Wx5bFT@thinkpad>
In-Reply-To: <20250616102619.54254-2-liwang@redhat.com>
References: <20250616102619.54254-1-liwang@redhat.com>
 <20250616102619.54254-2-liwang@redhat.com>
MIME-Version: 1.0
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 2F8322116E
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 CTE_CASE(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:email];
 DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/3] shell/lib: refactor checkpoint with shared
 path for exec() support
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

Hi Li,

Thank you for this refactoring and fixing the pec test regression,
I tested this patchset.

Tested-by: Avinesh Kumar <akumar@suse.de>


Regards,
Avinesh

On Monday, June 16, 2025 12:26:17 PM CEST Li Wang via ltp wrote:
> This patch refactors shell checkpoint mechanism to support exec()
> based process synchronization by introducing support for a shared
> futex region via a configurable path.
> 
> Key changes:
> 
>  - Introduce LTP_IPC_PATH environment variable to specify the futex
>    shared memory file used for checkpoint synchronization.
>  - Add magic header "LTPM" to validate the shared memory file content.
>  - Add checkpoint_reinit() to re-attach futex mapping for wait/wake
>    operations in exec()'ed processes.
>  - Update tst_checkpoint CLI tool to support "init", "wait", and "wake"
>    commands with a unified interface.
> 
> Signed-off-by: Li Wang <liwang@redhat.com>
> ---
>  include/tst_checkpoint_fn.h    | 20 +++++++++-
>  lib/tst_checkpoint.c           | 70 +++++++++++++++++++++++-----------
>  testcases/lib/tst_checkpoint.c | 27 +++++++------
>  testcases/lib/tst_test.sh      |  2 +
>  4 files changed, 83 insertions(+), 36 deletions(-)
> 
> diff --git a/include/tst_checkpoint_fn.h b/include/tst_checkpoint_fn.h
> index 3a010d616..209296fe0 100644
> --- a/include/tst_checkpoint_fn.h
> +++ b/include/tst_checkpoint_fn.h
> @@ -6,13 +6,29 @@
>  #define TST_CHECKPOINT_FN__
>  
>  /*
> - * Checkpoint initializaton, must be done first.
> + * Checkpoint initialization.
>   *
> - * NOTE: tst_tmpdir() must be called beforehand.
> + * This function sets up the shared memory region used for process
> + * synchronization via futexes. It must be called before any checkpoint
> + * operations such as tst_checkpoint_wait() or tst_checkpoint_wake().
>   */
>  void tst_checkpoint_init(const char *file, const int lineno,
>  			 void (*cleanup_fn)(void));
>  
> +/*
> + * Checkpoint reinitialization.
> + *
> + * This function re-attaches to an existing shared memory checkpoint region
> + * pointed to by the LTP_IPC_PATH environment variable. It is typically used
> + * in child processes (e.g., shell scripts) to synchronize with the main test.
> + *
> + * The function verifies the magic header in the shared memory file and maps
> + * the futex array into memory. It must be called before using checkpoint
> + * operations in a process that did not perform the original initialization.
> + */
> +void tst_checkpoint_reinit(const char *file, const int lineno,
> +			   void (*cleanup_fn)(void));
> +
>  /*
>   * Waits for wakeup.
>   *
> diff --git a/lib/tst_checkpoint.c b/lib/tst_checkpoint.c
> index 6a294b28b..5efbf98d2 100644
> --- a/lib/tst_checkpoint.c
> +++ b/lib/tst_checkpoint.c
> @@ -38,8 +38,9 @@ unsigned int tst_max_futexes;
>  void tst_checkpoint_init(const char *file, const int lineno,
>                           void (*cleanup_fn)(void))
>  {
> +	char *path = getenv("LTP_IPC_PATH");
> +	size_t page_size = getpagesize();
>  	int fd;
> -	unsigned int page_size;
>  
>  	if (tst_futexes) {
>  		tst_brkm_(file, lineno, TBROK, cleanup_fn,
> @@ -47,35 +48,58 @@ void tst_checkpoint_init(const char *file, const int lineno,
>  		return;
>  	}
>  
> -	/*
> -	 * The parent test process is responsible for creating the temporary
> -	 * directory and therefore must pass non-zero cleanup (to remove the
> -	 * directory if something went wrong).
> -	 *
> -	 * We cannot do this check unconditionally because if we need to init
> -	 * the checkpoint from a binary that was started by exec() the
> -	 * tst_tmpdir_created() will return false because the tmpdir was
> -	 * created by parent. In this case we expect the subprogram can call
> -	 * the init as a first function with NULL as cleanup function.
> -	 */
> -	if (cleanup_fn && !tst_tmpdir_created()) {
> -		tst_brkm_(file, lineno, TBROK, cleanup_fn,
> -			"You have to create test temporary directory "
> -			"first (call tst_tmpdir())");
> -		return;
> +	if (!path) {
> +		char *tmp_path = NULL;
> +
> +		if (!tst_tmpdir_created())
> +			tst_tmpdir();
> +
> +		safe_asprintf(__FILE__, __LINE__, cleanup_fn, &tmp_path,
> +				"%s/ltp_checkpoint", tst_get_tmpdir());
> +		path = tmp_path;
>  	}
>  
> -	page_size = getpagesize();
> +	fd = SAFE_OPEN(cleanup_fn, path, O_RDWR | O_CREAT, 0666);
> +	SAFE_WRITE(cleanup_fn, 1, fd, "LTPM", 4);
> +
> +	tst_futexes = SAFE_MMAP(cleanup_fn, NULL, page_size,
> +				PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
> +
> +	tst_futexes = (futex_t *)((char *)tst_futexes + 4);
> +	tst_max_futexes = (page_size - 4) / sizeof(futex_t);
> +
> +	SAFE_CLOSE(cleanup_fn, fd);
> +}
> +
> +void tst_checkpoint_reinit(const char *file, const int lineno,
> +			   void (*cleanup_fn)(void))
> +{
> +	const char *path = getenv("LTP_IPC_PATH");
> +	size_t page_size = getpagesize();
> +	int fd;
>  
> -	fd = SAFE_OPEN(cleanup_fn, "checkpoint_futex_base_file",
> -	               O_RDWR | O_CREAT, 0666);
> +	if (!path) {
> +		tst_brkm_(file, lineno, TBROK, cleanup_fn,
> +				"LTP_IPC_PATH is not defined");
> +	}
>  
> -	SAFE_FTRUNCATE(cleanup_fn, fd, page_size);
> +	if (access(path, F_OK)) {
> +		tst_brkm_(file, lineno, TBROK, cleanup_fn,
> +				"File %s does not exist!", path);
> +	}
>  
> +	fd = SAFE_OPEN(cleanup_fn, path, O_RDWR);
>  	tst_futexes = SAFE_MMAP(cleanup_fn, NULL, page_size,
> -	                    PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
> +			PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
> +
> +	char *ptr = (char *)tst_futexes;
> +	if (memcmp(ptr, "LTPM", 4) != 0) {
> +		tst_brkm_(file, lineno, TBROK, cleanup_fn,
> +				"Invalid shared memory region (bad magic)");
> +	}
>  
> -	tst_max_futexes = page_size / sizeof(uint32_t);
> +	tst_futexes = (futex_t *)((char *)tst_futexes + 4);
> +	tst_max_futexes = (page_size - 4) / sizeof(futex_t);
>  
>  	SAFE_CLOSE(cleanup_fn, fd);
>  }
> diff --git a/testcases/lib/tst_checkpoint.c b/testcases/lib/tst_checkpoint.c
> index c70c4e8e5..35a0c0dfa 100644
> --- a/testcases/lib/tst_checkpoint.c
> +++ b/testcases/lib/tst_checkpoint.c
> @@ -9,11 +9,14 @@
>  #include <stdlib.h>
>  #define TST_NO_DEFAULT_MAIN
>  #include "tst_test.h"
> +#include "tst_checkpoint.h"
>  
>  static void print_help(void)
>  {
> -	printf("Usage: tst_checkpoint wait TIMEOUT ID\n");
> +	printf("Usage: tst_checkpoint init\n");
> +	printf("   or: tst_checkpoint wait TIMEOUT ID\n");
>  	printf("   or: tst_checkpoint wake TIMEOUT ID NR_WAKE\n");
> +	printf("Arguments:\n");
>  	printf("       TIMEOUT - timeout in ms\n");
>  	printf("       ID - checkpoint id\n");
>  	printf("       NR_WAKE - number of processes to wake up\n");
> @@ -43,8 +46,13 @@ int main(int argc, char *argv[])
>  	int ret;
>  	int type;
>  
> -	if (argc < 3)
> -		goto help;
> +	if (!strcmp(argv[1], "init")) {
> +		if (argc != 2)
> +			goto help;
> +
> +		tst_checkpoint_init(__FILE__, __LINE__, NULL);
> +		return 0;
> +	}
>  
>  	if (!strcmp(argv[1], "wait")) {
>  		type = 0;
> @@ -70,17 +78,14 @@ int main(int argc, char *argv[])
>  		goto help;
>  	}
>  
> -	tst_reinit();
> +	tst_checkpoint_reinit(__FILE__, __LINE__, NULL);
>  
> -	if (type)
> -		ret = tst_checkpoint_wake(id, nr_wake, timeout);
> -	else
> +	if (type == 0)
>  		ret = tst_checkpoint_wait(id, timeout);
> -
> -	if (ret)
> -		return 1;
>  	else
> -		return 0;
> +		ret = tst_checkpoint_wake(id, nr_wake, timeout);
> +
> +	return ret ? 1 : 0;
>  
>  help:
>  	print_help();
> diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
> index c32bd8b19..e5e76067b 100644
> --- a/testcases/lib/tst_test.sh
> +++ b/testcases/lib/tst_test.sh
> @@ -629,6 +629,8 @@ _tst_init_checkpoints()
>  	ROD_SILENT dd if=/dev/zero of="$LTP_IPC_PATH" bs="$pagesize" count=1
>  	ROD_SILENT chmod 600 "$LTP_IPC_PATH"
>  	export LTP_IPC_PATH
> +
> +	tst_checkpoint init
>  }
>  
>  _prepare_device()
> 





-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
