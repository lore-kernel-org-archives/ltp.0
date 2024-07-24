Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 637C5C3DA63
	for <ltp@archiver.kernel.org>; Wed, 24 Jul 2024 16:29:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 704B83D1C2B
	for <ltp@archiver.kernel.org>; Wed, 24 Jul 2024 18:29:46 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B67C43D0FA8
 for <ltp@lists.linux.it>; Wed, 24 Jul 2024 18:29:32 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E2DE2616145
 for <ltp@lists.linux.it>; Wed, 24 Jul 2024 18:29:31 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4C297219A8;
 Wed, 24 Jul 2024 16:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721838570; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fMy6ErJHStMNK+e0IAakkeeBRV7jrtYlp7zaoyJiR0g=;
 b=QNf0XqPPHfzawE9Oe6XyC67t3inY3hh5GmpCM8pX/kL40NCpJaSEzG41Do5QGAGPPuDpFR
 xwjc/fzDIQ/tieXw0vB3obk/SLKbQRyvuZBWYaFIfqvQmB3MDdMkQ17Y1GUkFEb6wdIxmH
 Ujlf60Lnz0qPUm4PIHOtej8k0CrnGtQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721838570;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fMy6ErJHStMNK+e0IAakkeeBRV7jrtYlp7zaoyJiR0g=;
 b=BEJiBwb2cPrGqr8k57inFVfV+kv+qQJJ+swbCj/DbAP1Lh9gBTLd9t7mzxad/CVPLcjsYA
 UVs65ZNg6YBw88Bg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=QNf0XqPP;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=BEJiBwb2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721838570; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fMy6ErJHStMNK+e0IAakkeeBRV7jrtYlp7zaoyJiR0g=;
 b=QNf0XqPPHfzawE9Oe6XyC67t3inY3hh5GmpCM8pX/kL40NCpJaSEzG41Do5QGAGPPuDpFR
 xwjc/fzDIQ/tieXw0vB3obk/SLKbQRyvuZBWYaFIfqvQmB3MDdMkQ17Y1GUkFEb6wdIxmH
 Ujlf60Lnz0qPUm4PIHOtej8k0CrnGtQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721838570;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fMy6ErJHStMNK+e0IAakkeeBRV7jrtYlp7zaoyJiR0g=;
 b=BEJiBwb2cPrGqr8k57inFVfV+kv+qQJJ+swbCj/DbAP1Lh9gBTLd9t7mzxad/CVPLcjsYA
 UVs65ZNg6YBw88Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 295A013411;
 Wed, 24 Jul 2024 16:29:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yFM1COoroWazSwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 24 Jul 2024 16:29:30 +0000
Date: Wed, 24 Jul 2024 18:29:00 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <ZqErzC4PMRrrk929@yuki>
References: <20240723-ioctl_ficlone-v2-0-33075bbc117f@suse.com>
 <20240723-ioctl_ficlone-v2-1-33075bbc117f@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240723-ioctl_ficlone-v2-1-33075bbc117f@suse.com>
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 4C297219A8
X-Spamd-Result: default: False [-3.81 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/7] Add fallback definitions for lapi/fs.h
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
> diff --git a/configure.ac b/configure.ac
> index 1f8796c87..4d466f052 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -177,6 +177,7 @@ AC_CHECK_TYPES([struct acct_v3],,,[#include <sys/acct.h>])
>  AC_CHECK_TYPES([struct af_alg_iv, struct sockaddr_alg],,,[# include <linux/if_alg.h>])
>  AC_CHECK_TYPES([struct fanotify_event_info_fid, struct fanotify_event_info_error,
>  		struct fanotify_event_info_header, struct fanotify_event_info_pidfd],,,[#include <sys/fanotify.h>])
> +AC_CHECK_TYPES([struct file_clone_range],,,[#include <linux/fs.h>])
>  AC_CHECK_TYPES([struct file_dedupe_range],,,[#include <linux/fs.h>])
>  
>  AC_CHECK_TYPES([struct file_handle],,,[
> diff --git a/include/lapi/fs.h b/include/lapi/fs.h
> index 635979b02..0e8d646d8 100644
> --- a/include/lapi/fs.h
> +++ b/include/lapi/fs.h
> @@ -20,6 +20,15 @@
>  #include <limits.h>
>  #include "lapi/abisize.h"
>  
> +#ifndef HAVE_FILE_CLONE_RANGE
> +struct file_clone_range {
> +	int64_t src_fd;
> +	uint64_t src_offset;
> +	uint64_t src_length;
> +	uint64_t dest_offset;
> +};
> +#endif

Sigh, this is still horribly broken even when I fixed the macro to
HAVE_STRUCT_FILE_CLONE_RANGE that is because:

commit b857f8723f30a4b9554bf6b0ff8fa52fd07e8b60
Author: Li Wang <liwang@redhat.com>
Date:   Fri Aug 5 14:34:01 2022 +0800

    lapi/fsmount: resolve conflict in different header files


However the CI seems to work fine if I remove the HAVE_MOUNT_SETATTR
check with:

 #define LAPI_FS_H__

 #include "config.h"
-#ifndef HAVE_MOUNT_SETATTR
-# ifdef HAVE_LINUX_FS_H
-#  include <linux/fs.h>
-# endif
+
+#ifdef HAVE_LINUX_FS_H
+# include <linux/fs.h>
 #endif

 #include <sys/user.h>


@Li do we still need that ifdef or can we get rid of it?

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
