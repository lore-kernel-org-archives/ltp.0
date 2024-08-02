Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF118C3DA49
	for <ltp@archiver.kernel.org>; Fri,  2 Aug 2024 09:55:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 235B03D1EDF
	for <ltp@archiver.kernel.org>; Fri,  2 Aug 2024 11:55:19 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AF56E3D1C3E
 for <ltp@lists.linux.it>; Fri,  2 Aug 2024 11:55:04 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 380621000DC5
 for <ltp@lists.linux.it>; Fri,  2 Aug 2024 11:55:02 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4A7F31FBA4;
 Fri,  2 Aug 2024 09:55:02 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0FCF71388E;
 Fri,  2 Aug 2024 09:55:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id araXAfasrGaUMAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 02 Aug 2024 09:55:02 +0000
Date: Fri, 2 Aug 2024 11:55:03 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20240802095503.GC1613449@pevik>
References: <20240802-fchmodat2-v5-0-bff2ec1a4f06@suse.com>
 <20240802-fchmodat2-v5-3-bff2ec1a4f06@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240802-fchmodat2-v5-3-bff2ec1a4f06@suse.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 4A7F31FBA4
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 3/5] Add fchmodat2 fallback definition
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

Hi Andrea,


>  include/lapi/stat.h | 16 ++++++++++++++++
What is the reason this to be added to include/lapi/stat.h?

It's not a general function? (otherwise tst_safe_macros.c would be more
appropriate).

And because one day it will be defined in <sys/stat.h>?

Probably ok due both reasons, but I'm just curious, also because static inline
brought various problems in the past.


>  1 file changed, 16 insertions(+)

> diff --git a/include/lapi/stat.h b/include/lapi/stat.h
> index 3606c9eb0..8e38ecfef 100644
> --- a/include/lapi/stat.h
> +++ b/include/lapi/stat.h
> @@ -229,4 +229,20 @@ static inline int statx(int dirfd, const char *pathname, unsigned int flags,
>  # define STATX_ATTR_VERITY	0x00100000
>  #endif

> +#define SAFE_FCHMODAT2(dfd, filename, mode, flags) \
> +	safe_fchmodat2(__FILE__, __LINE__, (dfd), (filename), (mode), (flags))
> +
> +static inline int safe_fchmodat2(const char *file, const int lineno,
> +		int dfd, const char *filename, mode_t mode, int flags)
> +{
> +	int ret;
> +
> +	ret = tst_syscall(__NR_fchmodat2, dfd, filename, mode, flags);
> +	if (ret == -1)
> +		tst_brk_(file, lineno, TBROK | TERRNO, "%s(%d,%s,%d,%d) error",
> +			__func__, dfd, filename, mode, flags);
> +
> +	return ret;

The code itself is obviously correct.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

> +}
> +
>  #endif /* LAPI_STAT_H__ */

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
