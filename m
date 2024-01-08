Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A69AC3DA6E
	for <ltp@archiver.kernel.org>; Mon,  8 Jan 2024 11:48:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 955623CE53E
	for <ltp@archiver.kernel.org>; Mon,  8 Jan 2024 12:48:44 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7548B3CD615
 for <ltp@lists.linux.it>; Mon,  8 Jan 2024 12:48:27 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 907A3100204D
 for <ltp@lists.linux.it>; Mon,  8 Jan 2024 12:47:45 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8448621F9A;
 Mon,  8 Jan 2024 11:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704714464;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HfJPs+kxrjgIAEMFxnf/gjwMC7uX2upBTglLju1IVKU=;
 b=BROR1prhTxAFsJT9Q1n1dTIRhMCUrJTuWYqRNUkhcc0mEwuZlpUMHfp1dpDEaM6/6//28M
 YVPD9phTNQxSTCoI+UmJiI8KZTYMWIJddu2J7Eh498V+bHHA5cWo2tPKGL0pto8JXlw4xE
 PdKWORU5xMJmpsf8JJaI2uNr5UXte7s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704714464;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HfJPs+kxrjgIAEMFxnf/gjwMC7uX2upBTglLju1IVKU=;
 b=0geJfiohGqQ4dWJN9e78BE1orG1jBKqLCMW90nyRzmOnHfGAB3Q69YWKiQ9VQPGcTn4ayv
 A0JUf2y88Owu6PBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704714464;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HfJPs+kxrjgIAEMFxnf/gjwMC7uX2upBTglLju1IVKU=;
 b=BROR1prhTxAFsJT9Q1n1dTIRhMCUrJTuWYqRNUkhcc0mEwuZlpUMHfp1dpDEaM6/6//28M
 YVPD9phTNQxSTCoI+UmJiI8KZTYMWIJddu2J7Eh498V+bHHA5cWo2tPKGL0pto8JXlw4xE
 PdKWORU5xMJmpsf8JJaI2uNr5UXte7s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704714464;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HfJPs+kxrjgIAEMFxnf/gjwMC7uX2upBTglLju1IVKU=;
 b=0geJfiohGqQ4dWJN9e78BE1orG1jBKqLCMW90nyRzmOnHfGAB3Q69YWKiQ9VQPGcTn4ayv
 A0JUf2y88Owu6PBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5BA5D13496;
 Mon,  8 Jan 2024 11:47:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mZuyFODgm2X7UwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 08 Jan 2024 11:47:44 +0000
Date: Mon, 8 Jan 2024 12:47:38 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20240108114738.GC1565258@pevik>
References: <20231021122958.13458-1-wegao@suse.com>
 <20231025083706.13767-1-wegao@suse.com>
 <20231025083706.13767-2-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231025083706.13767-2-wegao@suse.com>
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=BROR1prh;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=0geJfioh
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.71 / 50.00];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_TRACE(0.00)[suse.cz:+]; MX_GOOD(-0.01)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; BAYES_HAM(-3.00)[100.00%];
 ARC_NA(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]
X-Rspamd-Queue-Id: 8448621F9A
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] lib: Add .ulimit
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

Hi Wei, Cyril,

> Fixs: #530
> Signed-off-by: Wei Gao <wegao@suse.com>
> ---
>  include/tst_test.h | 14 ++++++++++++++
>  lib/tst_test.c     | 28 ++++++++++++++++++++++++++++
>  2 files changed, 42 insertions(+)

> diff --git a/include/tst_test.h b/include/tst_test.h
> index 75c2109b9..dcdbc71d7 100644
> --- a/include/tst_test.h
> +++ b/include/tst_test.h
> @@ -15,6 +15,7 @@
>  #include <limits.h>
>  #include <string.h>
>  #include <errno.h>
> +#include <sys/resource.h>

>  #include "tst_common.h"
>  #include "tst_res_flags.h"
> @@ -148,6 +149,11 @@ extern unsigned int tst_variant;

>  #define TST_UNLIMITED_RUNTIME (-1)

> +struct tst_ulimit_val {
> +	int resource;
> +	rlim_t rlim_cur;
> +};
> +
>  struct tst_test {
>  	/* number of tests available in test() function */
>  	unsigned int tcnt;
> @@ -306,6 +312,11 @@ struct tst_test {
>  	 */
>  	const struct tst_path_val *save_restore;

> +	/*
> +	 * {NULL, NULL} terminated array of (ulimit resource type and value)
> +	 */
> +	const struct tst_ulimit_val *ulimit;
> +
>  	/*
>  	 * NULL terminated array of kernel config options required for the
>  	 * test.
> @@ -392,6 +403,9 @@ int tst_validate_children_(const char *file, const int lineno,
>  #define tst_validate_children(child_count) \
>  	tst_validate_children_(__FILE__, __LINE__, (child_count))

> +#define tst_set_ulimit(conf) \
> +	tst_set_ulimit_(__FILE__, __LINE__, (conf))
> +
>  #ifndef TST_NO_DEFAULT_MAIN

>  static struct tst_test test;
> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index 2e58cad33..59eeda7e7 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -1129,6 +1129,25 @@ static void do_cgroup_requires(void)
>  	tst_cg_init();
>  }

This patch requires manual adjustments (it does not apply to the master any more).

Also, this should be documented in doc/C-Test-API.asciidoc.

> +void tst_set_ulimit_(const char *file, const int lineno, const struct tst_ulimit_val *conf)
$ cd lib && make check-tst_test
...
tst_test.c:1150:13: warning: LTP-003: Symbol 'tst_set_ulimit_' has the LTP public library prefix, but is static (private).

If we want to use also in the tests (like tst_validate_children), the function
signature should be also in the header, e.g.:

include/tst_test.h
...
void tst_set_ulimit_(const char *file, const int lineno, const struct tst_ulimit_val *conf);
#define tst_set_ulimit(conf) \
	tst_set_ulimit_(__FILE__, __LINE__, (conf))

And, because offered to use in th tests, the function would deserve 1) comment
in include/tst_test.h.

But because tst_set_ulimit_() is just a wrapper over safe_setrlimit(), I don't
think it's needed to be called in the tests directly. Therefore the
#define tst_set_ulimit(conf) definition in the header is IMHO not needed
and tst_set_ulimit_() in lib/tst_test.c could be tst_set_ulimit() (without
underscore) and with static keyword.

> +{
> +	struct rlimit rlim;
> +
> +	SAFE_GETRLIMIT(conf->resource, &rlim);
When function has file and line, you want to use it for all library functions,
thus:
	safe_getrlimit(file, lineno, conf->resource, &rlim);

NOTE: some functions in tst_test.c calls SAFE_() macros, which is wrong. I'll
send patch after this is fixed.

> +
> +	if (conf->rlim_cur > rlim.rlim_max) {
> +		rlim.rlim_max = conf->rlim_cur;
> +		rlim.rlim_cur = conf->rlim_cur;
> +	} else {
> +		rlim.rlim_cur = conf->rlim_cur;
> +	}

rlim.rlim_cur is set twice, why not just:

	rlim.rlim_cur = conf->rlim_cur;

	if (conf->rlim_cur > rlim.rlim_max)
		rlim.rlim_max = conf->rlim_cur;

> +
> +	tst_res_(file, lineno, TINFO, "Set ulimit resource:%d rlim_cur:%lu rlim_max:%lu",
nit: space after ':' helps readability:
> +		conf->resource, rlim.rlim_cur, rlim.rlim_max);
> +
> +	safe_setrlimit(file, lineno, conf->resource, &rlim);
> +}
> +
>  static void do_setup(int argc, char *argv[])
>  {
>  	if (!tst_test)
> @@ -1227,6 +1246,15 @@ static void do_setup(int argc, char *argv[])
>  		}
>  	}

> +	if (tst_test->ulimit) {
> +		const struct tst_ulimit_val *pvl = tst_test->ulimit;
> +
> +		while (pvl->resource) {
> +			tst_set_ulimit(pvl);
> +			pvl++;
> +		}
> +	}
> +
>  	if (tst_test->mntpoint)
>  		SAFE_MKDIR(tst_test->mntpoint, 0777);

I suggest to merge with following changes.
@Cyril: feel free to improve the description.

diff --git doc/C-Test-API.asciidoc doc/C-Test-API.asciidoc
index db16be36e..c42a9754c 100644
--- doc/C-Test-API.asciidoc
+++ doc/C-Test-API.asciidoc
@@ -2426,6 +2426,24 @@ Test can be skipped on various conditions: on enabled SecureBoot
 ('.skip_in_secureboot = 1'), lockdown ('.skip_in_lockdown = 1') or in 32-bit
 compat mode ('.skip_in_compat = 1').
 
+1.43 Set resource limits
+~~~~~~~~~~~~~~~~~~~~~~~~
+
+'.ulimit' allows to set resource limits on particular resource. NOTE: It sets 'rlim_cur'
+only if it's higher than 'rlim_cur'.
+
+[source,c]
+-------------------------------------------------------------------------------
+#include "tst_test.h"
+
+static struct tst_test test = {
+	...
+	.ulimit = (const struct tst_ulimit_val[]) {
+		{RLIMIT_STACK, RLIM_INFINITY},
+		{}
+	},
+};
+
 2. Common problems
 ------------------
 
diff --git include/tst_test.h include/tst_test.h
index bbcfb308d..42c348906 100644
--- include/tst_test.h
+++ include/tst_test.h
@@ -314,7 +314,7 @@ struct tst_test {
 	const struct tst_path_val *save_restore;
 
 	/*
-	 * {NULL, NULL} terminated array of (ulimit resource type and value)
+	 * {} terminated array of ulimit resource type and value.
 	 */
 	const struct tst_ulimit_val *ulimit;
 
@@ -404,9 +404,6 @@ int tst_validate_children_(const char *file, const int lineno,
 #define tst_validate_children(child_count) \
 	tst_validate_children_(__FILE__, __LINE__, (child_count))
 
-#define tst_set_ulimit(conf) \
-	tst_set_ulimit_(__FILE__, __LINE__, (conf))
-
 #ifndef TST_NO_DEFAULT_MAIN
 
 static struct tst_test test;
diff --git lib/tst_test.c lib/tst_test.c
index d2f967ade..6c81b9b02 100644
--- lib/tst_test.c
+++ lib/tst_test.c
@@ -1147,20 +1147,24 @@ static void do_cgroup_requires(void)
 	tst_cg_init();
 }
 
-void tst_set_ulimit_(const char *file, const int lineno, const struct tst_ulimit_val *conf)
+#define tst_set_ulimit(conf) \
+	tst_set_ulimit_(__FILE__, __LINE__, (conf))
+
+/*
+ * Set resource limits.
+ */
+static void tst_set_ulimit_(const char *file, const int lineno, const struct tst_ulimit_val *conf)
 {
 	struct rlimit rlim;
 
-	SAFE_GETRLIMIT(conf->resource, &rlim);
+	safe_getrlimit(file, lineno, conf->resource, &rlim);
 
-	if (conf->rlim_cur > rlim.rlim_max) {
+	rlim.rlim_cur = conf->rlim_cur;
+
+	if (conf->rlim_cur > rlim.rlim_max)
 		rlim.rlim_max = conf->rlim_cur;
-		rlim.rlim_cur = conf->rlim_cur;
-	} else {
-		rlim.rlim_cur = conf->rlim_cur;
-	}
 
-	tst_res_(file, lineno, TINFO, "Set ulimit resource:%d rlim_cur:%lu rlim_max:%lu",
+	tst_res_(file, lineno, TINFO, "Set ulimit resource: %d rlim_cur: %lu rlim_max: %lu",
 		conf->resource, rlim.rlim_cur, rlim.rlim_max);
 
 	safe_setrlimit(file, lineno, conf->resource, &rlim);

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
