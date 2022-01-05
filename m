Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61376C433F5
	for <ltp@archiver.kernel.org>; Wed,  5 Jan 2022 14:39:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 522A03C9223
	for <ltp@archiver.kernel.org>; Wed,  5 Jan 2022 15:39:49 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AC0933C222E
 for <ltp@lists.linux.it>; Wed,  5 Jan 2022 15:39:39 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 25FB81A008AC
 for <ltp@lists.linux.it>; Wed,  5 Jan 2022 15:39:38 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 19EE51F37B;
 Wed,  5 Jan 2022 14:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1641393578; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jcujYBeqogZ9aMnIwWSludxAmQpGGqMazQwbgSt36Jk=;
 b=p0f1/x+/44B+18t9YijWZor48/sWehF51MArMixhAJ8NjWh/7P7HC0lE+7/wOjv21rinNQ
 1JyPtdD+v5DxTbuuRa2sqjfbhxbLGexfe4CWmfm+kRWTutg3lXWyHaBLAObwaDyAKKY0zk
 7uDMMuqqBEhN2SGgmB0m1CWK6w0+suc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1641393578;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jcujYBeqogZ9aMnIwWSludxAmQpGGqMazQwbgSt36Jk=;
 b=vXXJVb/wChv6XQ5xGhtzIw8UrpqKs4mX0G3xSuguNaq3gxvLMGbM7tvgHVI6EuO/HZR9Rk
 KNYU3EfCjZZVIaCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 05B3B13BE7;
 Wed,  5 Jan 2022 14:39:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Bis0O6mt1WHeVgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 05 Jan 2022 14:39:37 +0000
Date: Wed, 5 Jan 2022 15:41:08 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <YdWuBJ2vF9N8zCWQ@yuki>
References: <20211222192604.16839-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211222192604.16839-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/2] tst_af_alg: Moving tst_res(TCONF) to
 tst_have_alg()
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
> +bool tst_have_alg(const char *algtype, const char *algname)
> +{
> +	int ret;
> +
> +	ret = tst_try_alg(algtype, algname);
> +
> +	switch (ret) {
> +	case 0:
> +		return true;
> +	case ENOENT:
> +		tst_res(TCONF, "kernel doesn't have %s algorithm '%s'",
> +			algtype, algname);
> +		return false;
> +	default:
> +		errno = ret;
> +		tst_brk(TBROK | TERRNO,
> +			"unexpected error binding AF_ALG socket to %s algorithm '%s'",
> +			algtype, algname);
> +		return false;
> +	break;

This break is useless, otherwise:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
