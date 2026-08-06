Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C59CC55838
	for <ltp@archiver.kernel.org>; Thu,  6 Aug 2026 07:25:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C79173E27FA
	for <ltp@archiver.kernel.org>; Thu,  6 Aug 2026 09:24:59 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E7E923C280E
 for <ltp@lists.linux.it>; Thu,  6 Aug 2026 09:24:44 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id EE5A61000343
 for <ltp@lists.linux.it>; Thu,  6 Aug 2026 09:24:43 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 16B793DF3;
 Thu,  6 Aug 2026 07:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786001079; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+G1zss8cp8ZGtkL+X4tDknCckjE/sfnCNOcOR1E/+gM=;
 b=UXBzb9OUUlPPC/v0djRYRpAbIndO7Xs97bnPNvvkfQz45S7DtnC+vHO/8ogu2AbSu8ujkW
 D09z3nCZtkZMtBbuuZyu/sWRuBT0n6hyAbLLnqAQIgm5w2C1lMo93EAtu2QgsyIPmF2bdk
 vyX2Fjc01aPd9Ez5elJ9zI9OUKTi9g0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786001079;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+G1zss8cp8ZGtkL+X4tDknCckjE/sfnCNOcOR1E/+gM=;
 b=DLXnu1Owp0wao9jnyjAvGCSeER9nNjhI2w7OarpM9tdsIH+AF+yMnaC1qYeUzJLZmCGmEc
 oTxufmcuOlJLDgDw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=wlyPb3q7;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=SHBQCJXM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786001075; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+G1zss8cp8ZGtkL+X4tDknCckjE/sfnCNOcOR1E/+gM=;
 b=wlyPb3q7qyGfnzAsr56iOieRVt1CHzEXmj5RoeEK6nDVf7uDpAgoe6Abriy3UxRbCYOpqe
 8HF28ZPAH5K1hszpmvJXV8DLLIHR2hblY5gDGKSssKf3VIUdUmHzLmtLJqQZoEf+z7oLpB
 8yuBfK0QCm7I9ra58GEpy5ZAWGStB94=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786001075;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+G1zss8cp8ZGtkL+X4tDknCckjE/sfnCNOcOR1E/+gM=;
 b=SHBQCJXM+Nl/n9RL7Yy3xI+5FC+7jLMN9EM+VQ9wcYXgwPUZbyCvCf555/r21+8SfG3BPM
 PAA+rRBVybsxJxDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 068BD779BF;
 Thu,  6 Aug 2026 07:24:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id XTarALM2dGo+LgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 06 Aug 2026 07:24:35 +0000
Date: Thu, 6 Aug 2026 09:23:27 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <anQ2b1STktuhnLrP@rei>
References: <20260805151451.648990-1-pvorel@suse.cz>
 <20260805151451.648990-10-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260805151451.648990-10-pvorel@suse.cz>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 16B793DF3
X-Spamd-Result: default: False [-4.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:email,suse.cz:dkim];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 9/9] [RFC] metaparse: Check {min,
 max}_kver validity
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
> diff --git a/metadata/Makefile b/metadata/Makefile
> index af194bcc94..9ee2441669 100644
> --- a/metadata/Makefile
> +++ b/metadata/Makefile
> @@ -3,13 +3,15 @@
>  
>  top_srcdir		?= ..
>  
> -include $(top_srcdir)/include/mk/env_pre.mk
> -include $(top_srcdir)/include/mk/functions.mk
> +include $(top_srcdir)/include/mk/testcases.mk
>  
>  MAKE_TARGETS		:= ltp.json
>  HOST_MAKE_TARGETS	:= metaparse metaparse-sh
>  INSTALL_DIR		= metadata
>  
> +metaparse: HOST_CFLAGS		+= -I$(abs_srcdir)/../include -L$(abs_builddir)/../lib
> +metaparse: HOST_LDLIBS		+= -lltp
> +
>  .PHONY: ltp.json
>  
>  ltp.json: metaparse metaparse-sh
> diff --git a/metadata/metaparse.c b/metadata/metaparse.c
> index cb141c3831..07a452a5a1 100644
> --- a/metadata/metaparse.c
> +++ b/metadata/metaparse.c
> @@ -6,6 +6,7 @@
>  
>  #define _GNU_SOURCE
>  
> +#include <assert.h>
>  #include <search.h>
>  #include <stdio.h>
>  #include <string.h>
> @@ -15,6 +16,7 @@
>  #include <errno.h>
>  
>  #include "data_storage.h"
> +#include "tst_kvercmp.h"
>  
>  #define INCLUDE_PATH_MAX 5
>  #define GROUPS_TAG "@groups"
> @@ -1372,6 +1374,37 @@ int main(int argc, char *argv[])
>  		}
>  	}
>  
> +	/* Check max_kver >= min_kver */
> +	struct data_node *max_kver = data_node_hash_get(res, "max_kver");
> +	struct data_node *min_kver = data_node_hash_get(res, "min_kver");
> +	int a1, a2, a3, b1, b2, b3;
> +
> +	if (min_kver) {
> +		assert(min_kver->type == DATA_STRING);
> +		if (tst_parse_kver(min_kver->string.val, &b1, &b2, &b3)) {
> +			fprintf(stderr, "%s: wrong min_kver: '%s'\n",
> +				argv[optind], min_kver->string.val);
> +			return 1;
> +		}
> +	}
> +
> +	if (max_kver) {
> +		assert(max_kver->type == DATA_STRING);
> +		if (tst_parse_kver(max_kver->string.val, &a1, &a2, &a3)) {
> +			fprintf(stderr, "%s: wrong max_kver: '%s'\n",
> +					argv[optind], max_kver->string.val);
> +			return 1;
> +		}
> +	}
> +
> +	if (min_kver && max_kver) {
> +		if (tst_kver_cmp(a1, a2, a3, b1, b2, b3) < 0) {
> +			fprintf(stderr, "%s: min_kver (%s) > max_kver (%s)\n",
> +					argv[optind], min_kver->string.val, max_kver->string.val);
> +			return 1;
> +		}
> +	}
> +

Andrea is working on metadata linter, that does much more than this,
e.g. checks that CVE record is valid.

This looks like a check that could be added more easily there.


-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
