Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9494BC53219
	for <ltp@archiver.kernel.org>; Tue, 28 Jul 2026 14:01:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 20BF43E7495
	for <ltp@archiver.kernel.org>; Tue, 28 Jul 2026 16:01:04 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D64DE3E6291
 for <ltp@lists.linux.it>; Tue, 28 Jul 2026 16:00:47 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 3AD8F2009AB
 for <ltp@lists.linux.it>; Tue, 28 Jul 2026 16:00:44 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9FEF73E02;
 Tue, 28 Jul 2026 14:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785247239;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4tDy07CXV4lyXj98AuQrtAem7tJLpz4I2VsijQgoOlE=;
 b=fferoTKiJAO/2C6b0LVorrz2wmERMFw9r7SG5DfpVrn4AAs8hiRkTuymTQI/gHieQmbUmE
 xrUoqRWgh6TbRKn80YZRLno6nQhaA8VMQsd5QsAc7QTSfTh+Kc6D0WNkRLT1a3xR6nGEWW
 hrLtFjPgmDozcefcJrwhO9aYoZQW3zE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785247239;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4tDy07CXV4lyXj98AuQrtAem7tJLpz4I2VsijQgoOlE=;
 b=h8aqa5QJ/Z8w82KZTnSxWdWGoXqKL2E5Eiz958sQkQpxHeWn/yQKO7MqmqgJJV6AfYOxdc
 7m8LoqBsX4Y7NLDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785247235;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4tDy07CXV4lyXj98AuQrtAem7tJLpz4I2VsijQgoOlE=;
 b=dESHprUYRJpXwZjcShjVen9f1yfxKOWjYzQLpImX1v4LuMGCsb0A5mM2MIDGewhYZzZwYT
 j0DZrBmTUALYW9g5Rn8D8pi/Yl96JZrUWVpSCpnHZMpugQpPenZesHy9lK80n2hZhEbio5
 CiDXR60KPH19AZufzvREpoGWus6MlFc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785247235;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4tDy07CXV4lyXj98AuQrtAem7tJLpz4I2VsijQgoOlE=;
 b=VKYmKGynk5GvE8G7LS6fqwP5A7T7IxUNkq06hItXokOYEN7rt8rYd0JxrLaAdiJK/Guu3W
 JQOi+1vQdqhWeMBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7ED44779B1;
 Tue, 28 Jul 2026 14:00:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id utUXHQO2aGrGeAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 28 Jul 2026 14:00:35 +0000
Date: Tue, 28 Jul 2026 16:00:25 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20260728140025.GC1128467@pevik>
References: <20260717-fix_core_library-v1-0-c575fcbb2cb3@suse.com>
 <20260717-fix_core_library-v1-2-c575fcbb2cb3@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260717-fix_core_library-v1-2-c575fcbb2cb3@suse.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_TLS_ALL(0.00)[]; ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:email,suse.com:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] lib: Close directory fd on ENOSPC in
 tst_fill_fs
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea,

> The directory descriptor opened at the top of the function was leaked
> when openat() failed with ENOSPC and the function returned early. Close
> it before returning.

> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  lib/tst_fill_fs.c | 1 +
>  1 file changed, 1 insertion(+)

> diff --git a/lib/tst_fill_fs.c b/lib/tst_fill_fs.c
> index c62d48e289965d59ef6c877870c6047bbecb33da..b1e48fdeea6ab00848aab482fd3899fc6f6ce23c 100644
> --- a/lib/tst_fill_fs.c
> +++ b/lib/tst_fill_fs.c
> @@ -91,6 +91,7 @@ static void fill_flat_vec(const char *path, int verbose)
>  	if (fd == -1) {
>  		if (errno == ENOSPC) {
>  			tst_res(TINFO | TERRNO, "openat()");
> +			SAFE_CLOSE(dir);
Good catch!
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr
>  			return;
>  		}

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
