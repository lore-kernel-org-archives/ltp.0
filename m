Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C70ECD2CE17
	for <ltp@archiver.kernel.org>; Wed, 10 Dec 2025 08:38:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E3B593C9412
	for <ltp@archiver.kernel.org>; Wed, 10 Dec 2025 09:38:38 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7D8F73C82D2
 for <ltp@lists.linux.it>; Wed, 10 Dec 2025 09:38:22 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 016D320005E
 for <ltp@lists.linux.it>; Wed, 10 Dec 2025 09:38:21 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3E5AE5BDEB;
 Wed, 10 Dec 2025 08:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1765355901;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y9Rk5jpHM7qbhDxFkdCv5dgQC1WZAf/ex2j9Ge1DH2Y=;
 b=bmPu/PLItDOBi6p+kIE+M/gWMKB3pVTrAXzVW05VIx6Gu4FwtiKQ4ZuaRAyJw1hBkXVjdZ
 JUGv12Iu3Fm6uBjXrDfgwWkvT4ksLZCzglzC3oOy/W74T+qfrGCGRT758VLnKnsvxaJf5Q
 s1YpkT8YOddTK/1hootO29AkCarzvys=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1765355901;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y9Rk5jpHM7qbhDxFkdCv5dgQC1WZAf/ex2j9Ge1DH2Y=;
 b=3TdXS6Ti5nVcXC+8oQ9gFfT62pqs+ukYGoyeht0mWNutOp5TivGTQarXzIEnEM2YjQrdw4
 N//vwo+gsvG/eCBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1765355901;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y9Rk5jpHM7qbhDxFkdCv5dgQC1WZAf/ex2j9Ge1DH2Y=;
 b=bmPu/PLItDOBi6p+kIE+M/gWMKB3pVTrAXzVW05VIx6Gu4FwtiKQ4ZuaRAyJw1hBkXVjdZ
 JUGv12Iu3Fm6uBjXrDfgwWkvT4ksLZCzglzC3oOy/W74T+qfrGCGRT758VLnKnsvxaJf5Q
 s1YpkT8YOddTK/1hootO29AkCarzvys=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1765355901;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y9Rk5jpHM7qbhDxFkdCv5dgQC1WZAf/ex2j9Ge1DH2Y=;
 b=3TdXS6Ti5nVcXC+8oQ9gFfT62pqs+ukYGoyeht0mWNutOp5TivGTQarXzIEnEM2YjQrdw4
 N//vwo+gsvG/eCBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B0FEF3EA63;
 Wed, 10 Dec 2025 08:38:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id awSKJXwxOWmSIgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 10 Dec 2025 08:38:20 +0000
Date: Wed, 10 Dec 2025 09:38:18 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20251210083818.GA34390@pevik>
References: <20251209004242.31774-1-wegao@suse.com>
 <20251210061957.32631-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251210061957.32631-1-wegao@suse.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.991]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.cz:email];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] listmount04.c: Update case support
 mnt_id_req.mnt_ns_fd
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

Hi Wei,

> Kernel change from v6.18-rc7 lead test case failure with following error message:
> listmount04.c:128: TFAIL: invalid mnt_id_req.spare expected EINVAL: EBADF (9)

>  		.req_usage = 1,
> @@ -122,7 +136,17 @@ static void run(unsigned int n)
>  		req->mnt_id = tc->mnt_id;
>  		req->param = tc->param;
>  		req->size = tc->size;
> -		req->spare = tc->spare;
> +#ifdef HAVE_STRUCT_MNT_ID_REQ_MNT_NS_FD
> +		if ((tst_kvercmp(6, 18, 0)) >= 0)
> +			req->mnt_ns_fd = tc->mnt_ns_fd;
> +		else
> +			tst_brk(TCONF, "Skipping test, kernel version should > 6.18");
nit: "should be >= " (missing "be" and "=").

OK, for insufficient kernel version only first test (which does not set
.req_usage) will be run.

> +#else
> +		if ((tst_kvercmp(6, 18, 0)) >= 0)
> +			tst_brk(TCONF, "Skipping test, kernel version should < 6.18");
nit: "should be" (missing "be").

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Thanks!

Kind regards,
Petr
> +		else
> +			req->spare = tc->spare;
> +#endif
>  	}

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
