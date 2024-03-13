Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF5E6C54791
	for <ltp@archiver.kernel.org>; Wed, 13 Mar 2024 10:00:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 795373CFD1F
	for <ltp@archiver.kernel.org>; Wed, 13 Mar 2024 11:00:35 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3C2A63CE78D
 for <ltp@lists.linux.it>; Wed, 13 Mar 2024 11:00:18 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B6D9261023A
 for <ltp@lists.linux.it>; Wed, 13 Mar 2024 11:00:17 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E3BD81F7BF;
 Wed, 13 Mar 2024 10:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1710324016; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0PXUuLx2D6G1Z3XIu34LDF8BsHnKvCgtLS8BckjRu+0=;
 b=KLP6NPBuOubwYCTaLpubizeKBWe4oeDjwgfqF4frm2S/Xqa20pvhklDYlrHnndJWDl7gqK
 2bewUORomER5wbs+j008Am12gCMqwamHlPMkwA8PsDWl1Ykq/GNqNj7Q7mFUErnwDQnuX6
 zejQW4+yVUpC/b0rGrwYyFgIIiWyQHU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1710324016;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0PXUuLx2D6G1Z3XIu34LDF8BsHnKvCgtLS8BckjRu+0=;
 b=Bpxi02+UkBUpyeIhrJTXQfc77Fcy7yOhFtBuwoXsQqRK9HqXVqSpwXGys5cle+cVBfxsqf
 3TUZE9d/IBcDX5Ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1710324014; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0PXUuLx2D6G1Z3XIu34LDF8BsHnKvCgtLS8BckjRu+0=;
 b=ahgMdJeCnM+5qI5vCNqGtw6vNrUAZS7InaW3yQ14YaA11g3elf0iOAKsepyKT6OK30TLJk
 6Tp5Wub1xza3ukDSzjnq2xS8dWLBB8gGaIgsrd6xdgz0Bsocnwvb1yFXmzRZIZMWE+hhNn
 yFtA0a9656K19VVNR401CWyVS7vq+Qc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1710324014;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0PXUuLx2D6G1Z3XIu34LDF8BsHnKvCgtLS8BckjRu+0=;
 b=M/1AHwpJDEZHD4qmQKLuj9tHrcEDqK6Ljej1BryfDt2DAIxOBb6qGIbeydMETxaDqsGRgn
 xyj625A8k2p4y+Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B4B351397F;
 Wed, 13 Mar 2024 10:00:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id LBfPKi558WWcAQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 13 Mar 2024 10:00:14 +0000
Date: Wed, 13 Mar 2024 10:57:57 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <ZfF4pc0rWhXENvm2@rei>
References: <20240313092331.18069-1-andrea.cervesato@suse.de>
 <20240313092331.18069-3-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240313092331.18069-3-andrea.cervesato@suse.de>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-3.80 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; REPLY(-4.00)[];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[linux.it:url,suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.20)[71.44%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 2/3] Print prot flag when SAFE_MMAP() fails
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
>  include/tst_safe_macros.h | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
> index 15f914619..63ad46b85 100644
> --- a/include/tst_safe_macros.h
> +++ b/include/tst_safe_macros.h
> @@ -304,12 +304,18 @@ static inline void *safe_mmap(const char *file, const int lineno,
>                                int prot, int flags, int fd, off_t offset)
>  {
>  	void *rval;
> +	char *prot_buf;

Shouldn't we add the TDEBUG message here?

>  	rval = mmap(addr, length, prot, flags, fd, offset);
>  	if (rval == MAP_FAILED) {
> +		prot_buf = (char*) safe_malloc(file, lineno, 0, 512);
> +		prot_to_str(prot, prot_buf);
> +
>  		tst_brk_(file, lineno, TBROK | TERRNO,
> -			"mmap(%p,%zu,%d,%d,%d,%ld) failed",
> -			addr, length, prot, flags, fd, (long) offset);
> +			"mmap(%p,%zu,%s(%x),%d,%d,%ld) failed",
> +			addr, length, prot_buf, prot, flags, fd, (long) offset);
> +
> +		free(prot_buf);

This is fine as long as we switch to an on the stack array.

>  	}
>  
>  	return rval;
> -- 
> 2.35.3
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
