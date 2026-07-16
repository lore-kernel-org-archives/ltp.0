Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73A63C44501
	for <ltp@archiver.kernel.org>; Thu, 16 Jul 2026 10:59:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 075463E5618
	for <ltp@archiver.kernel.org>; Thu, 16 Jul 2026 12:59:22 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CC4C13E5615
 for <ltp@lists.linux.it>; Thu, 16 Jul 2026 12:58:52 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 8F75D1A0042A
 for <ltp@lists.linux.it>; Thu, 16 Jul 2026 12:58:51 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7879578905;
 Thu, 16 Jul 2026 10:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1784199530;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X1GbL6hGFJDxsQW0WW2SVA1/ZYvE4t/DwiVqTJQ5Yas=;
 b=p+PeqpBObt87eWbqyb39JfPZGcCHOMkvWjK4ox1TYCa+9AANyLDq8IB8Y50zorclMmeRUo
 zSWhZifiiyJfnLosZgcTKyPd8KdAYJI0HRGIrMrhUZXV3Bvb4N63hUnrpJ72OEE+pkrEWQ
 ZFcvwZydDD3sP8ZwVeJpAEvZSH4PfKk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1784199530;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X1GbL6hGFJDxsQW0WW2SVA1/ZYvE4t/DwiVqTJQ5Yas=;
 b=wZ2Vu9FReoKrvkPElSUvzgqWYfqAuPKJ+SqnLNfMHB8uwk6/KDy22SHsgKzIOE3CvXO6O9
 86If6mcaZJOtPHAg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=p+PeqpBO;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=wZ2Vu9FR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1784199530;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X1GbL6hGFJDxsQW0WW2SVA1/ZYvE4t/DwiVqTJQ5Yas=;
 b=p+PeqpBObt87eWbqyb39JfPZGcCHOMkvWjK4ox1TYCa+9AANyLDq8IB8Y50zorclMmeRUo
 zSWhZifiiyJfnLosZgcTKyPd8KdAYJI0HRGIrMrhUZXV3Bvb4N63hUnrpJ72OEE+pkrEWQ
 ZFcvwZydDD3sP8ZwVeJpAEvZSH4PfKk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1784199530;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X1GbL6hGFJDxsQW0WW2SVA1/ZYvE4t/DwiVqTJQ5Yas=;
 b=wZ2Vu9FReoKrvkPElSUvzgqWYfqAuPKJ+SqnLNfMHB8uwk6/KDy22SHsgKzIOE3CvXO6O9
 86If6mcaZJOtPHAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B2B2B779AD;
 Thu, 16 Jul 2026 10:58:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Di3AIGm5WGodcAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 16 Jul 2026 10:58:49 +0000
Date: Thu, 16 Jul 2026 12:58:46 +0200
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Message-ID: <20260716105846.GA263840@pevik>
References: <20260716105344.263649-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260716105344.263649-1-pvorel@suse.cz>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.21 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 ARC_NA(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,suse.cz:replyto,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[suse.cz,gmail.com,suse.com];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TAGGED_RCPT(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 7879578905
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] submodules: Move from git:// to https://
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

> git:// protocol is insecure and unreliable. LTP package build times to
> times fails:

>     $ git clone git://git.kernel.org/pub/scm/devel/sparse/sparse.git
>     fatal: unable to connect to git.kernel.org:

Actually the problem is permanent:

git.kernel.org[0: 172.105.64.184]: errno=Connection refused
git.kernel.org[1: 2a01:7e01:e001:937:0:1991:8:25]: errno=Network is unreachable

We should merge this fix to get working modules.

Kind regards,
Petr

> Use https:// for all submodules (change for sparse and mce-test).

> Reported-by: Petr Cervinka <pcervinka@suse.com>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  .gitmodules | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

> diff --git a/.gitmodules b/.gitmodules
> index a1ac4b1b87..3f36667a3a 100644
> --- a/.gitmodules
> +++ b/.gitmodules
> @@ -1,9 +1,9 @@
>  [submodule "testcases/kernel/mce-test"]
>  	path = testcases/kernel/mce-test
> -	url = git://git.kernel.org/pub/scm/linux/kernel/git/gong.chen/mce-test.git
> +	url = https://git.kernel.org/pub/scm/linux/kernel/git/gong.chen/mce-test.git
>  [submodule "tools/sparse/sparse-src"]
>  	path = tools/sparse/sparse-src
> -	url = git://git.kernel.org/pub/scm/devel/sparse/sparse.git
> +	url = https://git.kernel.org/pub/scm/devel/sparse/sparse.git
>  [submodule "tools/ltx/ltx-src"]
>  	path = tools/ltx/ltx-src
>  	url = https://github.com/linux-test-project/ltx.git

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
