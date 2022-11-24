Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0BD2C43219
	for <ltp@archiver.kernel.org>; Thu, 24 Nov 2022 11:58:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ADAB03CC92C
	for <ltp@archiver.kernel.org>; Thu, 24 Nov 2022 12:58:21 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8FBDC3C0123
 for <ltp@lists.linux.it>; Thu, 24 Nov 2022 12:58:11 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 067DF1A0088A
 for <ltp@lists.linux.it>; Thu, 24 Nov 2022 12:58:10 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0F66B1F750;
 Thu, 24 Nov 2022 11:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1669291090; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SntoOQfq2O1dANJcRM+0i83FwWQwRK9U7keGdJsgyRA=;
 b=d4P3VbVOunJnKmfWhy2lqigEfeEfxjacmCBE+D6VQC8+z7TEw1pZdOBN1x75xv0xVHYkTE
 wwLbTpitIabPZ+Do6VG7CN8ACrh5sO3938Tx3G5Y6zA8Pxu1aL/YVooGa0Mf8xFTe6VMve
 zpwOVnObQCtWRMoDoj5iprhe543b3A0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1669291090;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SntoOQfq2O1dANJcRM+0i83FwWQwRK9U7keGdJsgyRA=;
 b=46a7ZUe+kq8TKQN0/zA0xvJ99mvNAyFB24tDxH6PvFnVh5au64mEcwwbmRrTL1fSXr64ge
 tly8A9ri29BXaKCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E95D413B4F;
 Thu, 24 Nov 2022 11:58:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id KsMMOFFcf2OicQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 24 Nov 2022 11:58:09 +0000
Date: Thu, 24 Nov 2022 12:59:32 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Tarun Sahu <tsahu@linux.ibm.com>
Message-ID: <Y39cpPahJWYvQ4cT@yuki>
References: <20221120191533.164848-1-tsahu@linux.ibm.com>
 <20221120191533.164848-5-tsahu@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221120191533.164848-5-tsahu@linux.ibm.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 4/7] Hugetlb: Safe macro for posix_fadvise call
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
Cc: sbhat@linux.ibm.com, aneesh.kumar@linux.ibm.com, geetika@linux.ibm.com,
 vaibhav@linux.ibm.com, ltp@lists.linux.it, mike.kravetz@oracle.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
>  include/tst_safe_macros.h | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
> index 81c4b0844..4965e44d0 100644
> --- a/include/tst_safe_macros.h
> +++ b/include/tst_safe_macros.h
> @@ -298,6 +298,23 @@ static inline int safe_ftruncate(const char *file, const int lineno,
>  #define SAFE_FTRUNCATE(fd, length) \
>  	safe_ftruncate(__FILE__, __LINE__, (fd), (length))
>  
> +static inline int safe_posix_fadvise(const char *file, const int lineno,
> +                                int fd, off_t offset, off_t len, int advice)
> +{
> +	int rval;
> +
> +	rval = posix_fadvise(fd, offset, len, advice);
> +
> +	if (rval)
> +		tst_brk_(file, lineno, TBROK | TERRNO,
> +			"posix_fadvise(%d,%ld,%ld,%d) failed",
> +			fd, (long)offset, (long)len, advice);

I did a closer look at the posix_fadvise() manual and it returns an
error in case of a failure, so the TERRNO is wrong here since that
would print whatever was the last error stored in there.

So we either have to do errno = rval; in the if (rval) branch or use
tst_strerrno() to print the errno ourselves.

Looking at the code we have the safe_pthread.c does use tst_strerrno()
to print the error, so I would be inclined to do so here as well.

Also LKML coding style prefers curly braces around multiline blocks, so
I would enclose the multiline tst_brk_() into curly braces, but that is
very minor.

> +	return rval;
> +}
> +#define SAFE_POSIX_FADVISE(fd, offset, len, advice) \
> +	safe_posix_fadvise(__FILE__, __LINE__, (fd), (offset), (len), (advice))
> +
>  static inline int safe_truncate(const char *file, const int lineno,
>                                  const char *path, off_t length)
>  {
> -- 
> 2.31.1
> 

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
