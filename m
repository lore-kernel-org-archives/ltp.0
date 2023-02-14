Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4240C05027
	for <ltp@archiver.kernel.org>; Tue, 14 Feb 2023 10:51:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5C0643CBF51
	for <ltp@archiver.kernel.org>; Tue, 14 Feb 2023 11:51:12 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 03D693CB4DB
 for <ltp@lists.linux.it>; Tue, 14 Feb 2023 11:51:01 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id DAAEC1A000BB
 for <ltp@lists.linux.it>; Tue, 14 Feb 2023 11:51:00 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0DAB8219C0;
 Tue, 14 Feb 2023 10:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1676371860; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mIeQdcnJup7b92+O6lDBeThiIAUxxriNfj/orQiP93k=;
 b=iXc4UeReRunkhDc3SQHhE/ZTjZS4Cj6UPpv9EJrRELxJoHIajYGQhJxmF6IzBNoKTS3mqX
 TCSpCN2jPy+kZz4C8pbLodHfpvXcT+gBFnhVGvY7qwYUVfv63jmJmwyQEgECm4uivACjCR
 hwJgBZ5Mgm5/zkPblASq4yZQ67kw8D4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1676371860;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mIeQdcnJup7b92+O6lDBeThiIAUxxriNfj/orQiP93k=;
 b=Quz+i5BFjjsy8+6lyoDz+EWiln8eMOg9gHENiIziAzP60mUAUCPOIxSLmEWz6v4nMReKCy
 JwpPMaJqbcvdJ/BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E741B138E3;
 Tue, 14 Feb 2023 10:50:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id B6QZOJNn62OlawAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 14 Feb 2023 10:50:59 +0000
Date: Tue, 14 Feb 2023 11:52:26 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.com>
Message-ID: <Y+tn6kLC3cj+YqVl@yuki>
References: <20230214095027.9614-1-rpalethorpe@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230214095027.9614-1-rpalethorpe@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib/tst_safe_posix_ipc: Use %zu to format size_t
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
This would classify as obviously correct, so you could have just pushed
the patch and then send it as FYI to the list with [COMMITED] in the
subject.

Anyways:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

> ---
>  include/tst_safe_posix_ipc.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/tst_safe_posix_ipc.h b/include/tst_safe_posix_ipc.h
> index 2d3d0928f..e7892f2af 100644
> --- a/include/tst_safe_posix_ipc.h
> +++ b/include/tst_safe_posix_ipc.h
> @@ -121,7 +121,7 @@ static inline int safe_mq_send(const char *file, const int lineno,
>  
>  	if (rval == -1) {
>  		tst_brk_(file, lineno, TBROK | TERRNO,
> -			"mq_send(%d,%s,%lu,%d) failed", mqdes, msg_ptr,
> +			"mq_send(%d,%s,%zu,%d) failed", mqdes, msg_ptr,
>  			msg_len, msg_prio);
>  	}
>  
> -- 
> 2.39.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
