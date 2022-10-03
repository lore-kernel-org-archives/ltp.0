Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3455BC433FE
	for <ltp@archiver.kernel.org>; Mon,  3 Oct 2022 13:15:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1AE713C8779
	for <ltp@archiver.kernel.org>; Mon,  3 Oct 2022 15:15:03 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1E4C03C55EE
 for <ltp@lists.linux.it>; Mon,  3 Oct 2022 15:14:54 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 48B71200258
 for <ltp@lists.linux.it>; Mon,  3 Oct 2022 15:14:52 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 10C4D1F93B;
 Mon,  3 Oct 2022 13:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1664802891; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DZLCybC/rXaM9foBnFXsZHfvJBL9Uf3V8nC7smrJ9Tg=;
 b=A2i0s02BMj0UX2prlAdvHzbpO7AjWM2pLZmyZ6FsYQh4XVsBkdl7VAX1DBSGXbdDLm5B7s
 5Tx3f99z70TLSz4o+Afj+bFnJMvhapVnO4aW0uvW9lrHBBqC9YG3LrcCBbnzbM7aWEhqXC
 mzboq4c9htyivfuu8rbsCQtrUOxIVGc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1664802891;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DZLCybC/rXaM9foBnFXsZHfvJBL9Uf3V8nC7smrJ9Tg=;
 b=tww4nd266qiyNW4Xupzj1uTH6YLoNSnUNK+sWruB3VD61N4gYszOohD6/grjKrnbheEaUL
 8keU3oYMWLBc4MAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F09731332F;
 Mon,  3 Oct 2022 13:14:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id R2mXOUrgOmMaTQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 03 Oct 2022 13:14:50 +0000
Date: Mon, 3 Oct 2022 15:16:41 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Jan Stancek <jstancek@redhat.com>
Message-ID: <YzrguY3J3YLJhU//@yuki>
References: <43d65409eb3290b09e1c3a21cb0dc079c5f4849c.1664801307.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <43d65409eb3290b09e1c3a21cb0dc079c5f4849c.1664801307.git.jstancek@redhat.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/3] lib: introduce safe_write_fully()
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
> In case there is a short (but otherwise successful) write(),
> safe_write_fully() repeats write() and attempts to resume
> with the remainder of the buffer.
> 
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>  include/tst_safe_macros.h |  5 +++++
>  lib/tst_safe_macros.c     | 19 +++++++++++++++++++
>  2 files changed, 24 insertions(+)
> 
> diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
> index 81c4b0844267..caee0e9cf842 100644
> --- a/include/tst_safe_macros.h
> +++ b/include/tst_safe_macros.h
> @@ -645,4 +645,9 @@ int safe_sysinfo(const char *file, const int lineno, struct sysinfo *info);
>  #define SAFE_SYSINFO(info) \
>  	safe_sysinfo(__FILE__, __LINE__, (info))
>  
> +ssize_t safe_write_fully(const char *file, const int lineno,
> +	int fildes, const void *buf, size_t nbyte);
> +#define SAFE_WRITE_FULLY(fildes, buf, nbyte) \
> +	safe_write_fully(__FILE__, __LINE__, (fildes), (buf), (nbyte))

We already have a flag for SAFE_WRITE() to fail/not-fail on partial
write, what about turning that into three way switch?

Something as:

enum safe_write_opts {
	SAFE_WRITE_PARTIAL = 0,
	SAFE_WRITE_FULL = 1,
	SAFE_WRITE_RETRY = 2,
};

Or maybe just rename the SAFE_WRITE_FULLY() to SAFE_WRITE_RETRY().

>  #endif /* SAFE_MACROS_H__ */
> diff --git a/lib/tst_safe_macros.c b/lib/tst_safe_macros.c
> index c4cdc87e7346..e4d4ef4269a4 100644
> --- a/lib/tst_safe_macros.c
> +++ b/lib/tst_safe_macros.c
> @@ -591,3 +591,22 @@ void safe_cmd(const char *file, const int lineno, const char *const argv[],
>  		tst_brk_(file, lineno, TBROK, "%s failed (%d)", argv[0], rval);
>  	}
>  }
> +
> +ssize_t safe_write_fully(const char *file, const int lineno,
> +	int fildes, const void *buf, size_t nbyte)
> +{
> +	ssize_t rval;
> +	size_t len = nbyte;
> +
> +	do {
> +		rval = write(fildes, buf, len);
> +		if (rval == -1) {
> +			tst_brk_(file, lineno, TBROK | TERRNO,
> +				"write(%d,%p,%zu) failed", fildes, buf, len);

I guess that we may print potentionally confusing output here since we
modify the buf and len in the loop. I guess that we should store the buf
pointer at the start just for a case of this message and use the nbyte
and possibly write how many bytes we have managed to write before the
failure.

> +		}
> +		buf += rval;
> +		len -= rval;
> +	} while (len > 0);
> +
> +	return nbyte;
> +}
> -- 
> 2.27.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
