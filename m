Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 619B5F9935A
	for <ltp@archiver.kernel.org>; Thu, 23 Apr 2026 09:39:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2299E3E5386
	for <ltp@archiver.kernel.org>; Thu, 23 Apr 2026 11:39:04 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CC9133E20E6
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 11:38:46 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1C4D01400C63
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 11:38:45 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 05DEB6A833;
 Thu, 23 Apr 2026 09:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776937124;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fKV3cC7KXgTS/rShapIoS9W5XxfyG+eYv3AIQfHKPgY=;
 b=ac5cU2/2bUUuNWsYT00eJ5XxSrsmsSM1mGJyAQMfW2MUqA73l/QUSxD1IfzxlxaSK8oPfO
 VS2a5cmW7/mRhdzn9BGNpi4kJwt8YZMdwQnfjuJ10RA+xOo37Wa+CoqcJUKtGtmr0sQbxP
 hspEPsrGyrtT8lmmIzjuk1afjxBTHSI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776937124;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fKV3cC7KXgTS/rShapIoS9W5XxfyG+eYv3AIQfHKPgY=;
 b=jpI0Bd71nYnkrwMP7adKht1Td9zSV1pj5m5UvyBzrJFzaY4Mhf27jW7IuXesRb+Niw4HN1
 7y1MWXfThAaGz2DQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776937124;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fKV3cC7KXgTS/rShapIoS9W5XxfyG+eYv3AIQfHKPgY=;
 b=ac5cU2/2bUUuNWsYT00eJ5XxSrsmsSM1mGJyAQMfW2MUqA73l/QUSxD1IfzxlxaSK8oPfO
 VS2a5cmW7/mRhdzn9BGNpi4kJwt8YZMdwQnfjuJ10RA+xOo37Wa+CoqcJUKtGtmr0sQbxP
 hspEPsrGyrtT8lmmIzjuk1afjxBTHSI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776937124;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fKV3cC7KXgTS/rShapIoS9W5XxfyG+eYv3AIQfHKPgY=;
 b=jpI0Bd71nYnkrwMP7adKht1Td9zSV1pj5m5UvyBzrJFzaY4Mhf27jW7IuXesRb+Niw4HN1
 7y1MWXfThAaGz2DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B71ED593A3;
 Thu, 23 Apr 2026 09:38:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 3uFpK6Po6Wk/PQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 23 Apr 2026 09:38:43 +0000
Date: Thu, 23 Apr 2026 11:38:34 +0200
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Message-ID: <20260423093834.GA664424@pevik>
References: <20260423084123.657690-1-pvorel@suse.cz>
 <20260423084123.657690-6-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260423084123.657690-6-pvorel@suse.cz>
X-Spamd-Result: default: False [-2.00 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TAGGED_RCPT(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_TLS_ALL(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 RCPT_COUNT_FIVE(0.00)[6]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[suse.cz,gmail.com,suse.com,redhat.com,lists.sourceforge.net];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.cz:email];
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 5/6] lib: Merge functionality of LTP_QUIET into
 LTP_REPRODUCIBLE_OUTPUT
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
Cc: valgrind-developers@lists.sourceforge.net,
 Martin Cermak <mcermak@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

[ Cc valgrind-developers ML, which I should have done when sending the patchset ].

Kind regards,
Petr

> LTP_REPRODUCIBLE_OUTPUT=1 environment variable was added in 5894abc5f to
> help valgrind to use LTP for testing. It discards the actual content of
> the messages printed by the test (removes everything after printing
> TINFO/TPASS/TFAIL/... flag).

> Later LTP_QUIET=1 was added which suppresses printing TCONF, TINFO, and
> TDEBUG messages.

> Valgrind project uses both variables but no need to handle them
> separately. Therefore merge functionality of LTP_QUIET into
> LTP_REPRODUCIBLE_OUTPUT.

> LTP_QUIET was not even documented in HTML doc.

> Also fix help description, because TWARN was not skipped, although doc
> claimed to do.

> Implements: https://github.com/linux-test-project/ltp/issues/1306
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Changes v4->v5:
> * Remove wrongly stated TWARN (error on code on master)
> * Fix missing new lines in help (AI)
> * Use single fprintf (Li)

>  doc/users/setup_tests.rst |  5 +++--
>  lib/tst_test.c            | 16 +++++-----------
>  2 files changed, 8 insertions(+), 13 deletions(-)

> diff --git a/doc/users/setup_tests.rst b/doc/users/setup_tests.rst
> index 6f1d996e18..491a5b003a 100644
> --- a/doc/users/setup_tests.rst
> +++ b/doc/users/setup_tests.rst
> @@ -43,8 +43,9 @@ users.
>         Shell language: ``TST_NEEDS_DEVICE=1``.

>     * - LTP_REPRODUCIBLE_OUTPUT
> -     - When set to ``1`` or ``y`` discards the actual content of the messages
> -       printed by the test (suitable for a reproducible output).
> +     - When set to ``1`` or ``y`` uppress printing TCONF, TINFO and TDEBUG
> +       messages and discards the actual content of the other messages printed
> +       by the test (suitable for a reproducible output).

>     * - LTP_SINGLE_FS_TYPE
>       - Specifies single filesystem to run the test on instead all supported
> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index 12f7489d4e..a0b55049ff 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -68,7 +68,6 @@ static int iterations = 1;
>  static float duration = -1;
>  static float timeout_mul = -1;
>  static int reproducible_output;
> -static int quiet_output;

>  struct context {
>  	int32_t lib_pid;
> @@ -307,7 +306,7 @@ static void print_result(const char *file, const int lineno, int ttype,
>  		res = "TBROK";
>  	break;
>  	case TCONF:
> -		if (quiet_output)
> +		if (reproducible_output)
>  			return;
>  		res = "TCONF";
>  	break;
> @@ -315,12 +314,12 @@ static void print_result(const char *file, const int lineno, int ttype,
>  		res = "TWARN";
>  	break;
>  	case TINFO:
> -		if (quiet_output)
> +		if (reproducible_output)
>  			return;
>  		res = "TINFO";
>  	break;
>  	case TDEBUG:
> -		if (quiet_output)
> +		if (reproducible_output)
>  			return;
>  		res = "TDEBUG";
>  	break;
> @@ -676,8 +675,8 @@ static void print_help(void)
>  	fprintf(stderr, "LTP_DEV                  Path to the block device to be used (for .needs_device)\n");
>  	fprintf(stderr, "LTP_DEV_FS_TYPE          Filesystem used for testing (default: %s)\n", DEFAULT_FS_TYPE);
>  	fprintf(stderr, "LTP_DEBUG                Print debug messages (set 1(y) or 2)\n");
> -	fprintf(stderr, "LTP_REPRODUCIBLE_OUTPUT  Values 1 or y discard the actual content of the messages printed by the test\n");
> -	fprintf(stderr, "LTP_QUIET                Values 1 or y will suppress printing TCONF, TWARN, TINFO, and TDEBUG messages\n");
> +	fprintf(stderr, "LTP_REPRODUCIBLE_OUTPUT  Values 1 or y suppress printing TCONF, TINFO and TDEBUG messages and\n"
> +			"                         discards the actual content of all other messages\n");
>  	fprintf(stderr, "LTP_SINGLE_FS_TYPE       Specifies filesystem instead all supported (for .all_filesystems)\n");
>  	fprintf(stderr, "LTP_FORCE_SINGLE_FS_TYPE Testing only. The same as LTP_SINGLE_FS_TYPE but ignores test skiplist.\n");
>  	fprintf(stderr, "LTP_TIMEOUT_MUL          Timeout multiplier (must be a number >=1)\n");
> @@ -1398,7 +1397,6 @@ static void do_setup(int argc, char *argv[])
>  {
>  	char *tdebug_env = getenv("LTP_DEBUG");
>  	char *reproducible_env = getenv("LTP_REPRODUCIBLE_OUTPUT");
> -	char *quiet_env = getenv("LTP_QUIET");

>  	if (!tst_test)
>  		tst_brk(TBROK, "No tests to run");
> @@ -1429,10 +1427,6 @@ static void do_setup(int argc, char *argv[])
>  	    (!strcmp(reproducible_env, "1") || !strcmp(reproducible_env, "y")))
>  		reproducible_output = 1;

> -	if (quiet_env &&
> -	    (!strcmp(quiet_env, "1") || !strcmp(quiet_env, "y")))
> -		quiet_output = 1;
> -
>  	assert_test_fn();

>  	TCID = tcid = get_tcid(argv);

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
