Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81ED6EB64DA
	for <ltp@archiver.kernel.org>; Thu, 20 Jul 2023 15:26:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 11ACB3CE971
	for <ltp@archiver.kernel.org>; Thu, 20 Jul 2023 17:26:32 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EA90C3C95DA
 for <ltp@lists.linux.it>; Thu, 20 Jul 2023 17:26:12 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 333771A008B3
 for <ltp@lists.linux.it>; Thu, 20 Jul 2023 17:26:11 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6EDF822C87;
 Thu, 20 Jul 2023 15:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1689866771; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=os2/UX6RWBmaalzGPizDxE4Zis33bWdYoQyKDyAKgPk=;
 b=3KBAni0wGNGyTJMkcXKkYo3fSfz/ovtfVthvX7L2ULfwTZ3zbtf6k3mWe14EVVGz1xdA/3
 QGjMUr1luzy8e9MwoYAa1iddQicqnP5Gd93QPfe3VSmlYU/qx0IdL6KuoZWPpn4jm1ZtqE
 hUjc4G6SfZqyNgm5W0lryhey17QFQGw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1689866771;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=os2/UX6RWBmaalzGPizDxE4Zis33bWdYoQyKDyAKgPk=;
 b=7z7qqCrvPH8ByOhjP1yG9HS9bPFOn8EkO0JzTe4yZBsXH5dKx6AwgI/SuIUlw3Z9zViG9l
 SqWsDTDv77OHFrCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 58B4A133DD;
 Thu, 20 Jul 2023 15:26:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Xl3GFBNSuWQ8FgAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Thu, 20 Jul 2023 15:26:11 +0000
Message-ID: <92c457da-9b02-88ae-62e4-9a2be155e6cb@suse.cz>
Date: Thu, 20 Jul 2023 17:26:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
References: <20230720150206.1338520-1-pvorel@suse.cz>
 <20230720150206.1338520-4-pvorel@suse.cz>
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <20230720150206.1338520-4-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/4] {delete, finit,
 init}_module0[1-3]: Skip on SecureBoot
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

Hi,

On 20. 07. 23 17:02, Petr Vorel wrote:
> Enabled SecureBoot requires signed modules (regardless lockdown state).
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>   .../syscalls/delete_module/delete_module01.c    |  2 ++
>   .../syscalls/delete_module/delete_module03.c    |  2 ++
>   .../syscalls/finit_module/finit_module01.c      |  2 ++
>   .../syscalls/finit_module/finit_module02.c      | 17 +++++++++++++----
>   .../kernel/syscalls/init_module/init_module01.c |  2 ++
>   .../kernel/syscalls/init_module/init_module02.c | 16 ++++++++++++----
>   6 files changed, 33 insertions(+), 8 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/delete_module/delete_module01.c b/testcases/kernel/syscalls/delete_module/delete_module01.c
> index 6ecd2cad1..08597cfd6 100644
> --- a/testcases/kernel/syscalls/delete_module/delete_module01.c
> +++ b/testcases/kernel/syscalls/delete_module/delete_module01.c
> @@ -52,6 +52,8 @@ static struct tst_test test = {
>   	.needs_root = 1,
>   	/* lockdown requires signed modules */
>   	.skip_in_lockdown = 1,
> +	/* SecureBoot requires signed modules */

Nit: the two comments could be merged into one.

> +	.skip_in_secureboot = 1,
>   	.cleanup = cleanup,
>   	.test_all = do_delete_module,
>   };
> diff --git a/testcases/kernel/syscalls/delete_module/delete_module03.c b/testcases/kernel/syscalls/delete_module/delete_module03.c
> index 863d36188..a4b5108f0 100644
> --- a/testcases/kernel/syscalls/delete_module/delete_module03.c
> +++ b/testcases/kernel/syscalls/delete_module/delete_module03.c
> @@ -74,6 +74,8 @@ static struct tst_test test = {
>   	.needs_root = 1,
>   	/* lockdown requires signed modules */
>   	.skip_in_lockdown = 1,
> +	/* SecureBoot requires signed modules */
> +	.skip_in_secureboot = 1,
>   	.setup = setup,
>   	.cleanup = cleanup,
>   	.test_all = do_delete_module,
> diff --git a/testcases/kernel/syscalls/finit_module/finit_module01.c b/testcases/kernel/syscalls/finit_module/finit_module01.c
> index f960b2e40..660b567f5 100644
> --- a/testcases/kernel/syscalls/finit_module/finit_module01.c
> +++ b/testcases/kernel/syscalls/finit_module/finit_module01.c
> @@ -51,4 +51,6 @@ static struct tst_test test = {
>   	.needs_root = 1,
>   	/* lockdown requires signed modules */
>   	.skip_in_lockdown = 1,
> +	/* SecureBoot requires signed modules */
> +	.skip_in_secureboot = 1,
>   };
> diff --git a/testcases/kernel/syscalls/finit_module/finit_module02.c b/testcases/kernel/syscalls/finit_module/finit_module02.c
> index a7434de7d..4f5962829 100644
> --- a/testcases/kernel/syscalls/finit_module/finit_module02.c
> +++ b/testcases/kernel/syscalls/finit_module/finit_module02.c
> @@ -25,7 +25,7 @@
>   static char *mod_path;
>   
>   static int fd, fd_zero, fd_invalid = -1, fd_dir;
> -static int kernel_lockdown;
> +static int kernel_lockdown, secure_boot;
>   
>   static struct tst_cap cap_req = TST_CAP(TST_CAP_REQ, CAP_SYS_MODULE);
>   static struct tst_cap cap_drop = TST_CAP(TST_CAP_DROP, CAP_SYS_MODULE);
> @@ -84,6 +84,8 @@ static void setup(void)
>   	tst_module_exists(MODULE_NAME, &mod_path);
>   
>   	kernel_lockdown = tst_lockdown_enabled();
> +	secure_boot = tst_secureboot_enabled();
> +
>   	SAFE_MKDIR(TEST_DIR, 0700);
>   	fd_dir = SAFE_OPEN(TEST_DIR, O_DIRECTORY);
>   
> @@ -102,9 +104,16 @@ static void run(unsigned int n)
>   {
>   	struct tcase *tc = &tcases[n];
>   
> -	if (tc->skip_in_lockdown && kernel_lockdown) {
> -		tst_res(TCONF, "Kernel is locked down, skipping %s", tc->name);
> -		return;
> +	if (tc->skip_in_lockdown) {
> +		if (secure_boot) {
> +			tst_res(TCONF, "SecureBoot enabled, skipping %s", tc->name);
> +			return;
> +		}
> +
> +		if (kernel_lockdown) {
> +			tst_res(TCONF, "Kernel is locked down, skipping %s", tc->name);
> +			return;
> +		}

It'd be better to just change the original TCONF message to something 
like "Cannot load unsigned modules, skipping %s". Adding a TINFO message 
"Lockdown on/off" to tst_lockdown_enabled() would provide the 
explanation why.

>   	}
>   
>   	fd = SAFE_OPEN(mod_path, tc->open_flags);
> diff --git a/testcases/kernel/syscalls/init_module/init_module01.c b/testcases/kernel/syscalls/init_module/init_module01.c
> index 79e567cd6..80b2b77cc 100644
> --- a/testcases/kernel/syscalls/init_module/init_module01.c
> +++ b/testcases/kernel/syscalls/init_module/init_module01.c
> @@ -55,4 +55,6 @@ static struct tst_test test = {
>   	.needs_root = 1,
>   	/* lockdown requires signed modules */
>   	.skip_in_lockdown = 1,
> +	/* SecureBoot requires signed modules */
> +	.skip_in_secureboot = 1,
>   };
> diff --git a/testcases/kernel/syscalls/init_module/init_module02.c b/testcases/kernel/syscalls/init_module/init_module02.c
> index ad6569a06..4acbfbcd1 100644
> --- a/testcases/kernel/syscalls/init_module/init_module02.c
> +++ b/testcases/kernel/syscalls/init_module/init_module02.c
> @@ -22,7 +22,7 @@
>   #define MODULE_NAME	"init_module.ko"
>   
>   static unsigned long size, zero_size;
> -static int kernel_lockdown;
> +static int kernel_lockdown, secure_boot;
>   static void *buf, *faulty_buf, *null_buf;
>   
>   static struct tst_cap cap_req = TST_CAP(TST_CAP_REQ, CAP_SYS_MODULE);
> @@ -54,6 +54,7 @@ static void setup(void)
>   	tst_module_exists(MODULE_NAME, NULL);
>   
>   	kernel_lockdown = tst_lockdown_enabled();
> +	secure_boot = tst_secureboot_enabled();
>   	fd = SAFE_OPEN(MODULE_NAME, O_RDONLY|O_CLOEXEC);
>   	SAFE_FSTAT(fd, &sb);
>   	size = sb.st_size;
> @@ -67,9 +68,16 @@ static void run(unsigned int n)
>   {
>   	struct tcase *tc = &tcases[n];
>   
> -	if (tc->skip_in_lockdown && kernel_lockdown) {
> -		tst_res(TCONF, "Kernel is locked down, skipping %s", tc->name);
> -		return;
> +	if (tc->skip_in_lockdown) {
> +		if (secure_boot) {
> +			tst_res(TCONF, "SecureBoot enabled, skipping %s", tc->name);
> +			return;
> +		}
> +
> +		if (kernel_lockdown) {
> +			tst_res(TCONF, "Kernel is locked down, skipping %s", tc->name);
> +			return;
> +		}

Same here.

>   	}
>   
>   	if (tc->cap)

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
