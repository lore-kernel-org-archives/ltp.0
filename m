Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A51E9C3ABC3
	for <ltp@archiver.kernel.org>; Mon, 12 May 2025 18:06:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6FEC93CC2C0
	for <ltp@archiver.kernel.org>; Mon, 12 May 2025 20:06:37 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6A1863CA013
 for <ltp@lists.linux.it>; Mon, 12 May 2025 20:06:19 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 7C5E91400984
 for <ltp@lists.linux.it>; Mon, 12 May 2025 20:06:18 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7AE6C21187;
 Mon, 12 May 2025 18:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1747073176;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c4UTRlgJQsnAZlFLOZ05ycxxhqDvbvRMJ6WJg5N7vKQ=;
 b=VY7//lsGBlMdTrZxw8tn6Nt9JHOcgknxKE2wVuG+tbtIRbwuKb4OZIPaIEBZJpHGBekWWv
 4R3Yl9hHSg7RWkIkpocUtNd+Gzz4PhN8SEdUnZULTl624sRGgN/3TD6o7C0D8KX+hj1yAB
 jLi0h4bDWC76XFcxPhwn3ORLGiZdGPc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1747073176;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c4UTRlgJQsnAZlFLOZ05ycxxhqDvbvRMJ6WJg5N7vKQ=;
 b=Wgk3W6YK28u6VdVol/oQOoniZ1PwyzjOhEdAHI3OZuCInOYCfLpGA1NtuTSq8jDzn+LeBP
 ICloNlT9m1eaqyDA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="VY7//lsG";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Wgk3W6YK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1747073176;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c4UTRlgJQsnAZlFLOZ05ycxxhqDvbvRMJ6WJg5N7vKQ=;
 b=VY7//lsGBlMdTrZxw8tn6Nt9JHOcgknxKE2wVuG+tbtIRbwuKb4OZIPaIEBZJpHGBekWWv
 4R3Yl9hHSg7RWkIkpocUtNd+Gzz4PhN8SEdUnZULTl624sRGgN/3TD6o7C0D8KX+hj1yAB
 jLi0h4bDWC76XFcxPhwn3ORLGiZdGPc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1747073176;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c4UTRlgJQsnAZlFLOZ05ycxxhqDvbvRMJ6WJg5N7vKQ=;
 b=Wgk3W6YK28u6VdVol/oQOoniZ1PwyzjOhEdAHI3OZuCInOYCfLpGA1NtuTSq8jDzn+LeBP
 ICloNlT9m1eaqyDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6A0271397F;
 Mon, 12 May 2025 18:06:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 53eJGJc4ImgtfwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 12 May 2025 18:06:15 +0000
Date: Mon, 12 May 2025 20:06:05 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20250512180605.GA337908@pevik>
References: <20250509092813.12860-1-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250509092813.12860-1-chrubis@suse.cz>
X-Rspamd-Queue-Id: 7AE6C21187
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; REPLYTO_EQ_FROM(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:email,suse.cz:replyto,suse.cz:dkim];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] lib: tst_test: Add reproducible output.
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
Cc: valgrind-developers@lists.sourceforge.net, Mark Wielaard <mark@klomp.org>,
 Martin Cermak <mcermak@redhat.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

> This commit adds an environment variable LTP_REPRODUCIBLE_OUTPUT that
> when set skips printing parts of the test messages that may contain data
> that differ on subsequent runs (e.g. pids).

> With this you can run a test twice under a different conditions and
> check if the test codeflow was identical by simply doing diff of the
> outputs from the two runs.

LGTM, thanks!
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Could you please add before the commit the variable to
print_help() and to the docs doc/users/setup_tests.rst?

I suggest the diff below, which also sort the entries (ideally it'd be
separated, but it's before the release, feel free to do it).

> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> Suggested-by: Martin Doucha <mdoucha@suse.cz>
> CC: valgrind-developers@lists.sourceforge.net
> ---
>  lib/tst_test.c | 7 +++++++
>  1 file changed, 7 insertions(+)

> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index 2bb4519dd..f14627544 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -64,6 +64,7 @@ static int mntpoint_mounted;
>  static int ovl_mounted;
>  static struct timespec tst_start_time; /* valid only for test pid */
>  static int tdebug;
> +static int reproducible_output;

>  struct results {
>  	int passed;
> @@ -312,6 +313,9 @@ static void print_result(const char *file, const int lineno, int ttype,
>  	str += ret;
>  	size -= ret;

> +	if (reproducible_output)
> +		goto print;
> +
>  	ssize = size - 2;
>  	ret = vsnprintf(str, size, fmt, va);
>  	str += MIN(ret, ssize);
> @@ -329,6 +333,7 @@ static void print_result(const char *file, const int lineno, int ttype,
>  				"Next message is too long and truncated:");
>  	}

> +print:
>  	snprintf(str, size, "\n");

>  	/* we might be called from signal handler, so use write() */
> @@ -1312,6 +1317,8 @@ static void do_setup(int argc, char *argv[])
>  	if (tst_test->supported_archs && !tst_is_on_arch(tst_test->supported_archs))
>  		tst_brk(TCONF, "This arch '%s' is not supported for test!", tst_arch.name);

> +	reproducible_output = !!getenv("LTP_REPRODUCIBLE_OUTPUT");

LTP_COLORIZE_OUTPUT allows more complicated setup (y/1 always, n/0: never),
but any value here enables the feature (e.g. LTP_COLORIZE_OUTPUT=0).
This would be nice to unify, but I'm ok to ignore it as it's before release.

> +
>  	assert_test_fn();

>  	TCID = tid = get_tid(argv);

Adding docs (+ sort variables while at it).

Kind regards,
Petr

+++ doc/users/setup_tests.rst
@@ -49,11 +49,12 @@ users.
    * - LTP_DEV_FS_TYPE
      - Filesystem used for testing (default: ``ext2``).
 
-   * - LTP_TIMEOUT_MUL
-     - Multiplies timeout, must be number >= 0.1 (> 1 is useful for slow
-       machines to avoid unexpected timeout). It's mainly for shell API, which
-       does not have LTP_RUNTIME_MUL. In C API it scales the default 30 sec
-       safety margin, probably LTP_RUNTIME_MUL should be used instead.
+   * - LTP_IMA_LOAD_POLICY
+     - Load IMA example policy, see :master:`testcases/kernel/security/integrity/ima/README.md`.
+
+   * - LTP_REPRODUCIBLE_OUTPUT
+     - Dischard the actual content of the messages printed by the test
+       (suitable for a reproducible output).
 
    * - LTP_RUNTIME_MUL
      - Multiplies maximal test iteration runtime. Tests that run for more than a
@@ -61,8 +62,11 @@ users.
        both up and down with this multiplier. This is not yet implemented in the
        shell API.
 
-   * - LTP_IMA_LOAD_POLICY
-     - Load IMA example policy, see :master:`testcases/kernel/security/integrity/ima/README.md`.
+   * - LTP_TIMEOUT_MUL
+     - Multiplies timeout, must be number >= 0.1 (> 1 is useful for slow
+       machines to avoid unexpected timeout). It's mainly for shell API, which
+       does not have LTP_RUNTIME_MUL. In C API it scales the default 30 sec
+       safety margin, probably LTP_RUNTIME_MUL should be used instead.
 
    * - LTP_VIRT_OVERRIDE
      - Overrides virtual machine detection in the test library. Setting it to
diff --git lib/tst_test.c lib/tst_test.c
index f14627544f..a014ddc278 100644
--- lib/tst_test.c
+++ lib/tst_test.c
@@ -613,9 +613,10 @@ static void print_help(void)
 	fprintf(stderr, "LTP_COLORIZE_OUTPUT  Force colorized output behaviour (y/1 always, n/0: never)\n");
 	fprintf(stderr, "LTP_DEV              Path to the block device to be used (for .needs_device)\n");
 	fprintf(stderr, "LTP_DEV_FS_TYPE      Filesystem used for testing (default: %s)\n", DEFAULT_FS_TYPE);
+	fprintf(stderr, "LTP_REPRODUCIBLE_OUTPUT      Dischard the actual content of the messages printed by the test\n");
+	fprintf(stderr, "LTP_RUNTIME_MUL      Runtime multiplier (must be a number >=1)\n");
 	fprintf(stderr, "LTP_SINGLE_FS_TYPE   Testing only - specifies filesystem instead all supported (for .all_filesystems)\n");
 	fprintf(stderr, "LTP_TIMEOUT_MUL      Timeout multiplier (must be a number >=1)\n");
-	fprintf(stderr, "LTP_RUNTIME_MUL      Runtime multiplier (must be a number >=1)\n");
 	fprintf(stderr, "LTP_VIRT_OVERRIDE    Overrides virtual machine detection (values: \"\"|kvm|microsoft|xen|zvm)\n");
 	fprintf(stderr, "TMPDIR               Base directory for template directory (for .needs_tmpdir, default: %s)\n", TEMPDIR);
 	fprintf(stderr, "\n");

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
