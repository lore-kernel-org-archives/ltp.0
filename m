Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 912F0C4345F
	for <ltp@archiver.kernel.org>; Thu,  2 May 2024 10:32:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D6BC23CC1EF
	for <ltp@archiver.kernel.org>; Thu,  2 May 2024 12:32:19 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 829273C9D84
 for <ltp@lists.linux.it>; Thu,  2 May 2024 12:32:04 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A115B60A768
 for <ltp@lists.linux.it>; Thu,  2 May 2024 12:32:03 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A0D521FBEF;
 Thu,  2 May 2024 10:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1714645922; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FmDue4XQCNnWZq+ZSoPyd9njTjVdM68tY0YHJNDQBUo=;
 b=nlKupzW5l+Myhx8yUuWxzC+c41Nh8H9mJs2YVpjhyTdoYDJF7IeUUo2GvrJdYNPkMEN+l3
 p91KcptbEtY2fdoLTD6uv8f/Q9rh4r/ma95aCG+htgMe2gl/imLgJcqL8bZZ0UjPNd/OPS
 AA9Dhva+tTydxDaqzMXqc3Lc/MW/NfU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1714645922;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FmDue4XQCNnWZq+ZSoPyd9njTjVdM68tY0YHJNDQBUo=;
 b=ZiwoLXWPjs3jVUMFyd+e3x2Zjv/eSxtpnXnYILwS1Q3GrftzwstkQmPenwdXXCCgI7Tjvb
 pFysSnxZmY+8s6AQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=nlKupzW5;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ZiwoLXWP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1714645922; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FmDue4XQCNnWZq+ZSoPyd9njTjVdM68tY0YHJNDQBUo=;
 b=nlKupzW5l+Myhx8yUuWxzC+c41Nh8H9mJs2YVpjhyTdoYDJF7IeUUo2GvrJdYNPkMEN+l3
 p91KcptbEtY2fdoLTD6uv8f/Q9rh4r/ma95aCG+htgMe2gl/imLgJcqL8bZZ0UjPNd/OPS
 AA9Dhva+tTydxDaqzMXqc3Lc/MW/NfU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1714645922;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FmDue4XQCNnWZq+ZSoPyd9njTjVdM68tY0YHJNDQBUo=;
 b=ZiwoLXWPjs3jVUMFyd+e3x2Zjv/eSxtpnXnYILwS1Q3GrftzwstkQmPenwdXXCCgI7Tjvb
 pFysSnxZmY+8s6AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8EAAB1386E;
 Thu,  2 May 2024 10:32:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oM2NIqJrM2blEAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 02 May 2024 10:32:02 +0000
Date: Thu, 2 May 2024 12:31:13 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <ZjNrcYM8Rb8NTieO@yuki>
References: <20240430052845.31039-1-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240430052845.31039-1-liwang@redhat.com>
X-Spamd-Result: default: False [-4.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_TWO(0.00)[2];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:email];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: A0D521FBEF
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] lib: add SAFE_CALLOC macro
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
> diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
> index 53aceb5ca..f228b99e1 100644
> --- a/include/tst_safe_macros.h
> +++ b/include/tst_safe_macros.h
> @@ -75,6 +75,11 @@ int safe_dup2(const char *file, const int lineno, int oldfd, int newfd);
>  #define SAFE_MALLOC(size) \
>  	safe_malloc(__FILE__, __LINE__, NULL, (size))
>  
> +void *safe_calloc(const char *file, const int lineno, size_t nmemb, size_t size);
> +
> +#define SAFE_CALLOC(nmemb, size) \
> +	safe_calloc(__FILE__, __LINE__, (nmemb), (size))
> +
>  void *safe_realloc(const char *file, const int lineno, void *ptr, size_t size);
>  
>  #define SAFE_REALLOC(ptr, size) \
> diff --git a/lib/tst_safe_macros.c b/lib/tst_safe_macros.c
> index c6e6b15dc..40fdaca76 100644
> --- a/lib/tst_safe_macros.c
> +++ b/lib/tst_safe_macros.c
> @@ -9,6 +9,7 @@
>  #include <stdlib.h>
>  #include <errno.h>
>  #include <sched.h>
> +#include <malloc.h>

calloc() should be included from stdlib.h as far as I can tell malloc.h
is needed for mallopt() and such.

>  #include <sys/ptrace.h>
>  #include "config.h"
>  #ifdef HAVE_SYS_FANOTIFY_H
> @@ -546,6 +547,20 @@ int safe_dup2(const char *file, const int lineno, int oldfd, int newfd)
>  	return rval;
>  }
>  
> +void *safe_calloc(const char *file, const int lineno, size_t nmemb, size_t size)
> +{
> +	void *rval;
> +
> +	rval = calloc(nmemb, size);
> +
> +	if (rval == NULL) {
> +		tst_brk_(file, lineno, TBROK | TERRNO,
> +			"calloc(%zu, %zu) failed", nmemb, size);
> +	}
> +
> +	return rval;
> +}


Otherwise it looks good.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
