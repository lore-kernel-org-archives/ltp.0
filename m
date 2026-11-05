Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5630606A326
	for <ltp@archiver.kernel.org>; Thu,  5 Nov 2026 10:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=a30eWHDE;
	dkim=fail reason="signature verification failed" header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=YAG+fRQ+;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=a30eWHDE;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=YAG+fRQ+
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7FC533CDF13
	for <ltp@archiver.kernel.org>; Thu,  5 Nov 2026 11:33:54 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D8DA33C2171
 for <ltp@lists.linux.it>; Thu,  5 Nov 2026 11:33:37 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 8A531200063
 for <ltp@lists.linux.it>; Thu,  5 Nov 2026 11:33:36 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 33C5E1F750;
 Thu,  5 Nov 2026 10:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1793874815; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ejRVUBDmb1/fBg0daEo1TuQcxMf2Lwo5fKOwUlAixDk=;
 b=a30eWHDEeFHcpf4FcjyjjuocPDK1BXceQGaPvubYDfo0nducnPDI2YDJNfbI4uIjwvsN+o
 8kvt+6JqjfJuLiyS6YwFSLSBHH7+YbpZvRyPYCfC/BN3t6w1rv+J2mmcRVlKmXrOxXRuIo
 lhSirQQvZLruHwhO0pN7gKesTSO04Ss=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1793874815;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ejRVUBDmb1/fBg0daEo1TuQcxMf2Lwo5fKOwUlAixDk=;
 b=YAG+fRQ+9Tdw3iiw6fwurljO5ilFXzHJwWGS2tkI4BxEfQz0JPSfCTe35BWVi4SM/KyP9+
 tKHLx27DaFvgxSAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1793874815; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ejRVUBDmb1/fBg0daEo1TuQcxMf2Lwo5fKOwUlAixDk=;
 b=a30eWHDEeFHcpf4FcjyjjuocPDK1BXceQGaPvubYDfo0nducnPDI2YDJNfbI4uIjwvsN+o
 8kvt+6JqjfJuLiyS6YwFSLSBHH7+YbpZvRyPYCfC/BN3t6w1rv+J2mmcRVlKmXrOxXRuIo
 lhSirQQvZLruHwhO0pN7gKesTSO04Ss=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1793874815;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ejRVUBDmb1/fBg0daEo1TuQcxMf2Lwo5fKOwUlAixDk=;
 b=YAG+fRQ+9Tdw3iiw6fwurljO5ilFXzHJwWGS2tkI4BxEfQz0JPSfCTe35BWVi4SM/KyP9+
 tKHLx27DaFvgxSAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 055E0133F6;
 Thu,  5 Nov 2026 10:33:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ygPDM35b7GrbLgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 05 Nov 2026 10:33:35 +0000
Date: Thu, 5 Nov 2026 11:33:51 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <auxbj8043hAPYz-A@yuki.lan>
References: <20261104164638.407069-1-sbertram@redhat.com>
 <20261104183259.423259-1-pvorel@suse.cz>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261104183259.423259-1-pvorel@suse.cz>
X-Spam-Level: 
X-Spamd-Result: default: False [-17.30 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 REPLY(-4.00)[]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Spam-Score: -17.30
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] accept03/tst_fd: Harden parallel runs against
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: Stephen Bertram <sbertram@redhat.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> commit fa68043e5948ff1b8cb2c647d309ccf4808e23d7
> Author: Petr Vorel <pvorel@suse.cz>
> Date:   2026-11-04 18:34:06 +0100
> 
>     tst_fd: Add check for missing .needs_tmpdir
> 
>     Signed-off-by: Petr Vorel <pvorel@suse.cz>
> 
> diff --git lib/tst_fd.c lib/tst_fd.c
> index 6538a098c7..05e1bbe8b0 100644
> --- lib/tst_fd.c
> +++ lib/tst_fd.c
> @@ -22,6 +22,8 @@
>  #include "lapi/bpf.h"
>  #include "lapi/fsmount.h"
>  
> +#include "tso_tmpdir.h"
> +
>  #include "tst_fd.h"
>  
>  struct tst_fd_desc {
> @@ -30,8 +32,17 @@ struct tst_fd_desc {
>  	const char *desc;
>  };
>  
> +static void require_tmpdir(struct tst_fd *fd)
> +{
> +	if (!tst_tmpdir_created()) {
> +		tst_brk(TBROK, "%s fd requires .needs_tmpdir = 1",
> +			tst_fd_desc(fd));
> +	}
> +}
> +
>  static void open_file(struct tst_fd *fd)
>  {
> +	require_tmpdir(fd);
>  	fd->fd = SAFE_OPEN("fd_file", O_RDWR | O_CREAT, 0666);
>  	SAFE_UNLINK("fd_file");
>  }
> @@ -40,6 +51,7 @@ static void open_path(struct tst_fd *fd)
>  {
>  	int tfd;
>  
> +	require_tmpdir(fd);
>  	tfd = SAFE_CREAT("fd_file", 0666);
>  	SAFE_CLOSE(tfd);
>  
> @@ -50,6 +62,7 @@ static void open_path(struct tst_fd *fd)
>  
>  static void open_dir(struct tst_fd *fd)
>  {
> +	require_tmpdir(fd);
>  	SAFE_MKDIR("fd_dir", 0700);
>  	fd->fd = SAFE_OPEN("fd_dir", O_DIRECTORY);
>  	SAFE_RMDIR("fd_dir");

This approach looks good to me.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
