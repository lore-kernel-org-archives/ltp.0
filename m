Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CA3BC7115B
	for <ltp@archiver.kernel.org>; Mon, 23 Jun 2025 14:43:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 27A0F3CC791
	for <ltp@archiver.kernel.org>; Mon, 23 Jun 2025 16:43:11 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 312653CBDD2
 for <ltp@lists.linux.it>; Mon, 23 Jun 2025 16:42:53 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 76DCD1A00818
 for <ltp@lists.linux.it>; Mon, 23 Jun 2025 16:42:51 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7E2A71F454;
 Mon, 23 Jun 2025 14:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1750689770; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=14cF90DuB9JQzLT+iPFSZphnMVvuAbC/RwYQJI7ugJI=;
 b=MW8PEnJ1S6rjaR6mB8dWs3yc0d5YZdQUPokVqxLfm7DG1txgZ2LDm+BKENJ5m16CcARCTE
 SgEctTgjKLTNGAmV4QqF9/DHWIA3LxKixnwr+La1QcwbTdsABRQ/BiE+e4S0iMV/oRydi0
 vzdMbvuif1qkJIwNDb4GaKRApeKf14s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1750689770;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=14cF90DuB9JQzLT+iPFSZphnMVvuAbC/RwYQJI7ugJI=;
 b=77ARj+GGjjjdnD5VBqOTG9dPzjwaajth9oEovRpiwpJ+o25gn+LFaQfl63GNweQ+fgyfCh
 FAnBWbTS2hv4VBBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1750689770; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=14cF90DuB9JQzLT+iPFSZphnMVvuAbC/RwYQJI7ugJI=;
 b=MW8PEnJ1S6rjaR6mB8dWs3yc0d5YZdQUPokVqxLfm7DG1txgZ2LDm+BKENJ5m16CcARCTE
 SgEctTgjKLTNGAmV4QqF9/DHWIA3LxKixnwr+La1QcwbTdsABRQ/BiE+e4S0iMV/oRydi0
 vzdMbvuif1qkJIwNDb4GaKRApeKf14s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1750689770;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=14cF90DuB9JQzLT+iPFSZphnMVvuAbC/RwYQJI7ugJI=;
 b=77ARj+GGjjjdnD5VBqOTG9dPzjwaajth9oEovRpiwpJ+o25gn+LFaQfl63GNweQ+fgyfCh
 FAnBWbTS2hv4VBBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 614DF13485;
 Mon, 23 Jun 2025 14:42:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id AcCpFupnWWjIaAAAD6G6ig
 (envelope-from <mdoucha@suse.cz>); Mon, 23 Jun 2025 14:42:50 +0000
Message-ID: <88edd5e6-326b-42c0-abe4-207b6b8cb3e1@suse.cz>
Date: Mon, 23 Jun 2025 16:42:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Li Wang <liwang@redhat.com>, ltp@lists.linux.it
References: <20250623140210.32347-1-liwang@redhat.com>
Content-Language: en-US
From: Martin Doucha <mdoucha@suse.cz>
Autocrypt: addr=mdoucha@suse.cz; keydata=
 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 ag==
In-Reply-To: <20250623140210.32347-1-liwang@redhat.com>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid]
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] tst_test: Add min_runtime to control lower
 bound of scaled runtime
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

On 23. 06. 25 16:02, Li Wang wrote:
> When LTP_RUNTIME_MUL is set to a value < 1.0 (commonly in CI or fast test
> modes), the effective runtime of tests may be scaled down too aggressively.
> For some tests especially those relying on probabilistic triggers or sampling
> (e.g., fuzzy sync, CVE stress loops, long fault injection), this can result in
> too few iterations or missed conditions, leading to unreliable results.
> 
> This patch introduces a new field: .min_runtime;
> 
> If set, this specifies the minimum allowed runtime (in seconds) after applying
> the LTP_RUNTIME_MUL scaling factor. The final runtime is calculated as:
> 
>    MAX(runtime * LTP_RUNTIME_MUL, min_runtime)
> 
> If min_runtime is not set, a default minimum of 1 second is enforced.
> 
> This approach replaces the need for special flags such as
> TST_NO_FRAC_RUNTIME_MUL and provides a more systematic, flexible solution.
> 
> The following tests are updated to set .min_runtime:
>    - preadv203
>    - cve-2016-7117
>    - tst_fuzzy_sync01
>    - tst_fuzzy_sync02
> 
> Suggested-by: Martin Doucha <mdoucha@suse.cz>
> Signed-off-by: Li Wang <liwang@redhat.com>
> Cc: Ian Wienand <iwienand@redhat.com>
> ---
> 
> Notes:
>      v1 --> v2:
>      	* replace the .flags by a new min_runtime filed
>      	* set 1 second as the default minimal runtime regardless
>      	  LTP_RUNTIME_MUL value
> 
>   include/tst_test.h                            |  9 +++++++++
>   lib/newlib_tests/tst_fuzzy_sync01.c           |  2 +-
>   lib/newlib_tests/tst_fuzzy_sync02.c           |  2 +-
>   lib/tst_test.c                                | 11 +++++++++--
>   testcases/cve/cve-2016-7117.c                 |  2 +-
>   testcases/kernel/syscalls/preadv2/preadv203.c |  2 +-
>   6 files changed, 22 insertions(+), 6 deletions(-)
> 
> diff --git a/include/tst_test.h b/include/tst_test.h
> index 6fd8cbae3..9c21c1728 100644
> --- a/include/tst_test.h
> +++ b/include/tst_test.h
> @@ -460,6 +460,14 @@ struct tst_fs {
>    *           (e.g., TIMEOUT_MUL), ensuring consistent test duration across
>    *           different environments (e.g., debug vs. stock kernels).
>    *
> + * @min_runtime: Optional lower bound (in seconds) applied after runtime is
> + *           scaled by LTP_RUNTIME_MUL. If the scaled runtime is smaller
> + *           than this value, it will be clamped up to min_runtime.
> + *           This is useful for tests that require a minimum execution
> + *           time to gather sufficient samples or trigger events (e.g.,
> + *           probabilistic or fuzzy synchronization tests).
> + *           If not set, a default minimum of 1 second is enforced.
> + *
>    * @setup: Setup callback is called once at the start of the test in order to
>    *         prepare the test environment.
>    *
> @@ -584,6 +592,7 @@ struct tst_fs {
>   
>   	int timeout;
>   	int runtime;
> +	int min_runtime;
>   
>   	void (*setup)(void);
>   	void (*cleanup)(void);
> diff --git a/lib/newlib_tests/tst_fuzzy_sync01.c b/lib/newlib_tests/tst_fuzzy_sync01.c
> index b1390f460..16f30de57 100644
> --- a/lib/newlib_tests/tst_fuzzy_sync01.c
> +++ b/lib/newlib_tests/tst_fuzzy_sync01.c
> @@ -246,5 +246,5 @@ static struct tst_test test = {
>   	.test = run,
>   	.setup = setup,
>   	.cleanup = cleanup,
> -	.runtime = 150,
> +	.min_runtime = 150,

Lib tests don't need .min_runtime unless you specifically want to test 
that LTP_RUNTIME_MUL gets handled correctly.

>   };
> diff --git a/lib/newlib_tests/tst_fuzzy_sync02.c b/lib/newlib_tests/tst_fuzzy_sync02.c
> index bc079f6ff..3b0fb8a9b 100644
> --- a/lib/newlib_tests/tst_fuzzy_sync02.c
> +++ b/lib/newlib_tests/tst_fuzzy_sync02.c
> @@ -223,5 +223,5 @@ static struct tst_test test = {
>   	.test = run,
>   	.setup = setup,
>   	.cleanup = cleanup,
> -	.runtime = 150,
> +	.min_runtime = 150,
>   };
> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index 495e022f7..75a78be9a 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -627,10 +627,14 @@ static void parse_mul(float *mul, const char *env_name, float min, float max)
>   static int multiply_runtime(unsigned int runtime)
>   {
>   	static float runtime_mul = -1;
> +	int min_runtime = 1;
> +
> +	if (tst_test->min_runtime)
> +		min_runtime = MAX(1, tst_test->min_runtime);
>   
>   	parse_mul(&runtime_mul, "LTP_RUNTIME_MUL", 0.0099, 100);
>   
> -	return runtime * runtime_mul;
> +	return MAX(runtime * runtime_mul, min_runtime);
>   }
>   
>   static struct option {
> @@ -662,7 +666,7 @@ static void print_help(void)
>   	fprintf(stderr, "LTP_SINGLE_FS_TYPE       Specifies filesystem instead all supported (for .all_filesystems)\n");
>   	fprintf(stderr, "LTP_FORCE_SINGLE_FS_TYPE Testing only. The same as LTP_SINGLE_FS_TYPE but ignores test skiplist.\n");
>   	fprintf(stderr, "LTP_TIMEOUT_MUL          Timeout multiplier (must be a number >=1)\n");
> -	fprintf(stderr, "LTP_RUNTIME_MUL          Runtime multiplier (must be a number >=1)\n");
> +	fprintf(stderr, "LTP_RUNTIME_MUL          Runtime multiplier (must be a number >0)\n");
>   	fprintf(stderr, "LTP_VIRT_OVERRIDE        Overrides virtual machine detection (values: \"\"|kvm|microsoft|xen|zvm)\n");
>   	fprintf(stderr, "TMPDIR                   Base directory for template directory (for .needs_tmpdir, default: %s)\n", TEMPDIR);
>   	fprintf(stderr, "\n");
> @@ -1996,6 +2000,9 @@ void tst_run_tcases(int argc, char *argv[], struct tst_test *self)
>   	uname(&uval);
>   	tst_res(TINFO, "Tested kernel: %s %s %s", uval.release, uval.version, uval.machine);
>   
> +	if (tst_test->min_runtime)
> +		tst_test->runtime =tst_test->min_runtime;

If .runtime is set, .min_runtime should not override it. Setting 
.runtime < .min_runtime should trigger TBROK during lib setup.

> +
>   	if (tst_test->runtime)
>   		context->runtime = multiply_runtime(tst_test->runtime);
>   
> diff --git a/testcases/cve/cve-2016-7117.c b/testcases/cve/cve-2016-7117.c
> index dbec2b28b..8c488f447 100644
> --- a/testcases/cve/cve-2016-7117.c
> +++ b/testcases/cve/cve-2016-7117.c
> @@ -151,7 +151,7 @@ static struct tst_test test = {
>   	.test_all = run,
>   	.setup = setup,
>   	.cleanup = cleanup,
> -	.runtime = 60,
> +	.min_runtime = 60,

The .runtime value in fuzzy_sync tests is calibrated to reliably 
reproduce the bug. You can usually set much smaller .min_runtime based 
on how long it takes to run 1024 iterations of the fuzzy loop, with some 
safety margin (x2?).

>   	.tags = (const struct tst_tag[]) {
>   		{"linux-git", "34b88a68f26a"},
>   		{"CVE", "2016-7117"},
> diff --git a/testcases/kernel/syscalls/preadv2/preadv203.c b/testcases/kernel/syscalls/preadv2/preadv203.c
> index 72a35d3ab..472543e5c 100644
> --- a/testcases/kernel/syscalls/preadv2/preadv203.c
> +++ b/testcases/kernel/syscalls/preadv2/preadv203.c
> @@ -278,6 +278,6 @@ static struct tst_test test = {
>   	.mntpoint = MNTPOINT,
>   	.mount_device = 1,
>   	.all_filesystems = 1,
> -	.runtime = 60,
> +	.min_runtime = 60,
>   	.needs_root = 1,
>   };


-- 
Martin Doucha   mdoucha@suse.cz
SW Quality Engineer
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
