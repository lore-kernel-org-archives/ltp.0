Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32CBF1091901
	for <ltp@archiver.kernel.org>; Thu, 19 Mar 2026 17:39:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 610863E30C1
	for <ltp@archiver.kernel.org>; Thu, 19 Mar 2026 18:39:21 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CB8D33E2726
 for <ltp@lists.linux.it>; Thu, 19 Mar 2026 18:39:01 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 2DAE96009F7
 for <ltp@lists.linux.it>; Thu, 19 Mar 2026 18:39:01 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EC6A04D2A7;
 Thu, 19 Mar 2026 17:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1773941940; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iJVRl1LSY6LyqHHjBzviQ+rqrM0dZnIiBNfJkI1SHnA=;
 b=V//lRj+2/nw78ydHmkiv/k5rG3furLuc6hInZS5ez8gZAmS33Xn7Tj6+n2BzNEj64xlxRu
 Ty0RGcmpwV2Lk0TJGUoEAqoU8j5AA+sD+NSUXFr1VXV144zOV6YPEx1q/TKAVLzQEhvj9f
 /f/1oGx3ei+vFcUI2qJkIWCITlw6c30=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1773941940;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iJVRl1LSY6LyqHHjBzviQ+rqrM0dZnIiBNfJkI1SHnA=;
 b=RnyBy9e52cE9Jn8gdhRAuiz/v2K0Akj9DQemwZSIzoUrPkBaDDbZ2EBwaLSr1AL6ILve8o
 KeWkJlBIH1mEJKCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1773941939; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iJVRl1LSY6LyqHHjBzviQ+rqrM0dZnIiBNfJkI1SHnA=;
 b=xwhl0MUfjNgqErg45KQgYxnOmM2otxZiEDDrLqdYiMdQtezXRu5ORmQh9bjMaZMGodfqFS
 5c1RfN1ZMYCyPDFb3needVMI0IUUfRsbFP/4Hb4rKKYj36Qqoax0vtmxsEwgD5+pMiX+Wq
 su8LzdtgkOZ782z5s8Evrl1meAk8QVU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1773941939;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iJVRl1LSY6LyqHHjBzviQ+rqrM0dZnIiBNfJkI1SHnA=;
 b=nYW69KYlcgykx/Ms7wKoGYQMiGs6UTcM7cks/pwYOR4fI3wKqMu+6cJ5D+HMKC6wOW8ukK
 a8DhySflnfIOlNBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E00A84273B;
 Thu, 19 Mar 2026 17:38:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0tWvNrM0vGmIQAAAD6G6ig
 (envelope-from <jack@suse.cz>); Thu, 19 Mar 2026 17:38:59 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id 8FEACA0AFD; Thu, 19 Mar 2026 18:38:55 +0100 (CET)
Date: Thu, 19 Mar 2026 18:38:55 +0100
From: Jan Kara <jack@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <dmkwc4ptx6qfc5qmn3q3grvaqm6venpwzywzj6vktrsap6ejt4@mooynm5u6z7k>
References: <20260319160318.6867-1-chrubis@suse.cz>
 <20260319160318.6867-2-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260319160318.6867-2-chrubis@suse.cz>
X-Spamd-Result: default: False [-7.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MISSING_XM_UA(0.00)[];
 ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_SOME(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCVD_COUNT_THREE(0.00)[3];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 URIBL_BLOCKED(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo,suse.com:email];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_LAST(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] runtest/ltp-aidio.part4: Remove dio_sparse
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu 19-03-26 17:03:17, Cyril Hrubis wrote:
> After a discussion we agreed that there is a sufficient coverage for
> dio_sparse in ltp-aiodio.part2 already. There is no point in running
> these tests again in part4.
> 
> CC: Jan Kara <jack@suse.cz>
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  runtest/ltp-aiodio.part4 | 32 --------------------------------
>  1 file changed, 32 deletions(-)
> 
> diff --git a/runtest/ltp-aiodio.part4 b/runtest/ltp-aiodio.part4
> index de00b8a78..5d3028bf5 100644
> --- a/runtest/ltp-aiodio.part4
> +++ b/runtest/ltp-aiodio.part4
> @@ -1,38 +1,6 @@
>  aio01 aio01
>  aio02 aio02
>  
> -#Running dio_sparse & dirty tests
> -DI000 dirty
> -DS000 dio_sparse
> -DI001 dirty
> -DS001 dio_sparse
> -DI002 dirty
> -DS002 dio_sparse
> -DI003 dirty
> -DS003 dio_sparse
> -DI004 dirty
> -DS004 dio_sparse
> -DI005 dirty
> -DS005 dio_sparse
> -DI006 dirty
> -DS006 dio_sparse
> -DI007 dirty
> -DS007 dio_sparse
> -DI008 dirty
> -DS008 dio_sparse
> -DI009 dirty
> -DS009 dio_sparse
> -#iteration on dio_sparse
> -DIO00 dio_sparse
> -DIO01 dio_sparse
> -DIO02 dio_sparse
> -DIO03 dio_sparse
> -DIO04 dio_sparse
> -DIO05 dio_sparse
> -DIO06 dio_sparse
> -DIO07 dio_sparse
> -DIO08 dio_sparse
> -DIO09 dio_sparse
>  #Running aiodio_append
>  AD000 aiodio_append
>  AD001 aiodio_append
> -- 
> 2.52.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
