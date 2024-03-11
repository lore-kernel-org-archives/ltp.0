Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBC99C5475B
	for <ltp@archiver.kernel.org>; Mon, 11 Mar 2024 12:27:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 71E213CFD77
	for <ltp@archiver.kernel.org>; Mon, 11 Mar 2024 13:27:28 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ECF2D3CE84D
 for <ltp@lists.linux.it>; Mon, 11 Mar 2024 13:27:13 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id CA9062009E7
 for <ltp@lists.linux.it>; Mon, 11 Mar 2024 13:27:12 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 46F9F34C2D;
 Mon, 11 Mar 2024 12:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1710160030;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KQmVQpRK7uh/tlW+fqpzD0NVSqie2m/MfILCmvGL7lo=;
 b=0g8TjMGj7uaPKbA7vbU8tZ2XvCthSZkzPAH2mfCbygH2zDWpHAinwKnXRWNbEdsk6iDKGo
 0Ms4Cv5ZSY/BevreBdE4ujgN5qrndpPFrLB69YyjR+I2lMswXapJ5l071zcJhccYKrOoHP
 12vRY6MxJjSjX3rbADQZJndc6EKLLoI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1710160030;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KQmVQpRK7uh/tlW+fqpzD0NVSqie2m/MfILCmvGL7lo=;
 b=U1Kf7jSTz4czo22qUjGmxvR34aExJI9a0Imq9gAFKy5YXXb152qiJcKDJY7pGg+LijZs1l
 n30I5MHO7UYRJNDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1710160030;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KQmVQpRK7uh/tlW+fqpzD0NVSqie2m/MfILCmvGL7lo=;
 b=0g8TjMGj7uaPKbA7vbU8tZ2XvCthSZkzPAH2mfCbygH2zDWpHAinwKnXRWNbEdsk6iDKGo
 0Ms4Cv5ZSY/BevreBdE4ujgN5qrndpPFrLB69YyjR+I2lMswXapJ5l071zcJhccYKrOoHP
 12vRY6MxJjSjX3rbADQZJndc6EKLLoI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1710160030;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KQmVQpRK7uh/tlW+fqpzD0NVSqie2m/MfILCmvGL7lo=;
 b=U1Kf7jSTz4czo22qUjGmxvR34aExJI9a0Imq9gAFKy5YXXb152qiJcKDJY7pGg+LijZs1l
 n30I5MHO7UYRJNDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 27FAF136BA;
 Mon, 11 Mar 2024 12:27:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id j19jCJ747mVGQwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 11 Mar 2024 12:27:10 +0000
Date: Mon, 11 Mar 2024 13:27:04 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20240311122704.GB402014@pevik>
References: <20240309090113.3121235-1-liwang@redhat.com>
 <20240309090113.3121235-2-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240309090113.3121235-2-liwang@redhat.com>
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=0g8TjMGj;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=U1Kf7jST
X-Spamd-Result: default: False [-2.51 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Queue-Id: 46F9F34C2D
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/3] kconfig: add funtion to parse /proc/cmdline
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

Hi Li,

It looks to me you introduced new warnings, could you please fix them before
merged?
tst_kconfig.c:398: ERROR: code indent should use tabs where possible
tst_kconfig.c:398: WARNING: please, no spaces at the start of a line
tst_kconfig.c:570: ERROR: open brace '{' following function definitions go on the next line
tst_kconfig.c:600: ERROR: trailing statements should be on next line

Also nits (to be changed before merge) below.

> A new structure tst_kcmdline_var is defined to hold a command-line
> argument's key and a fixed-size value. Furthermore, function
> tst_kcmdline_parse is added to the corresponding .c file, which
> reads from /proc/cmdline, parses the command-line arguments, and
> populates the tst_kcmdline_var array with the obtained key-value
> pairs, ensuring safe file operations and buffer size checks.

> Signed-off-by: Li Wang <liwang@redhat.com>
> ---
>  include/tst_kconfig.h | 23 ++++++++++++++++++++++
>  lib/tst_kconfig.c     | 45 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 68 insertions(+)

> diff --git a/include/tst_kconfig.h b/include/tst_kconfig.h
> index 8b24a8380..a8cbfb786 100644
> --- a/include/tst_kconfig.h
> +++ b/include/tst_kconfig.h
> @@ -64,4 +64,27 @@ void tst_kconfig_read(struct tst_kconfig_var vars[], size_t vars_len);
>   */
>  int tst_kconfig_check(const char *const kconfigs[]);

> +/**
> + * Macro to initialize a tst_kcmdline_var structure with a specified parameter
> + * name and an empty value. This is useful for setting up an array of parameter
> + * structures before parsing the actual command-line arguments.
> + */
> +#define TST_KCMDLINE_INIT(paraname) { \
> +	.key = paraname, \
> +	.value = "" \
> +}
> +
> +/* Structure for storing command-line parameter key and its corresponding value */
nit: I guess /** is for autogenerated docs (maybe Andrea uses it one day with
sphinx :). Therefore maybe here also /* ? Also missing dot at the end of the
sentence.

> +struct tst_kcmdline_var {
> +	const char *key;
> +	char value[128];
> +};
> +
> +/**
> + * Parses command-line parameters from /proc/cmdline and stores them in params array
> + * params: The array of tst_kcmdline_var structures to be filled with parsed key-value pairs
nit: @param params, missing dot at the end of the sentence.
> + * params_len: The length of the params array, indicating how many parameters to parse
nit: @param params_len, missing dot at the end of the sentence.
> + */
> +void tst_kcmdline_parse(struct tst_kcmdline_var params[], size_t params_len);
> +
>  #endif	/* TST_KCONFIG_H__ */
> diff --git a/lib/tst_kconfig.c b/lib/tst_kconfig.c
> index 595ea4b09..c200dd261 100644
> --- a/lib/tst_kconfig.c
> +++ b/lib/tst_kconfig.c
> @@ -14,6 +14,7 @@
>  #include "tst_private.h"
>  #include "tst_kconfig.h"
>  #include "tst_bool_expr.h"
> +#include "tst_safe_stdio.h"

>  static int kconfig_skip_check(void)
>  {
> @@ -565,3 +566,47 @@ char tst_kconfig_get(const char *confname)

>  	return var.choice;
>  }
> +
> +void tst_kcmdline_parse(struct tst_kcmdline_var params[], size_t params_len) {
> +	char buf[128];
> +	size_t buf_pos = 0, i;
> +	int var_id = -1, c;
> +
> +	FILE *f = SAFE_FOPEN("/proc/cmdline", "r");
> +
> +	while ((c = fgetc(f)) != EOF) {
I hope fgetc() does not explode on ppc64le the same way as it did on
libs/libltpswap/libswap.c (see 6f82542fc ("libswap.c: Improve calculate swap dev
number")), where for some reason fgets() had to be used. But here it's actually
processing chars, not just counting EOF, so it should be ok. I'll try to retest it,
but please have look as well.

> +		switch (c) {
> +		case '=':
> +			buf[buf_pos] = '\0';
> +			for (i = 0; i < params_len; i++) {
> +				if (strcmp(buf, params[i].key) == 0)
> +					var_id = (int)i;
> +			}
> +
> +			buf_pos = 0;
> +		break;
> +		case ' ':
> +		case '\n':
> +			buf[buf_pos] = '\0';
> +			if (var_id >= 0 && var_id < (int)params_len)
> +				strcpy(params[var_id].value, buf);
> +
> +			var_id = -1;
> +			buf_pos = 0;
> +		break;
> +		default:
> +			if (buf_pos + 1  >= sizeof(buf)) {
> +				tst_res(TWARN, "Buffer overflowed while parsing /proc/cmdline");
> +				while ((c = fgetc(f)) != EOF && c != ' ' && c != '\n');
> +
> +				var_id = -1;
> +				buf_pos = 0;
> +			}
> +
> +			buf[buf_pos++] = (char)c;
> +		break;
> +		}
> +	}

LGTM.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

BTW it would be great to add a test for this functionality (there are
already some tests in lib/newlib_tests/test_kconfig*.c).

Kind regards,
Petr

> +
> +	SAFE_FCLOSE(f);
> +}

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
