Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7A37CA5FA5
	for <ltp@archiver.kernel.org>; Tue, 29 Sep 2026 14:22:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 101F13E57E7
	for <ltp@archiver.kernel.org>; Tue, 29 Sep 2026 16:22:26 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ED2813E4C18
 for <ltp@lists.linux.it>; Tue, 29 Sep 2026 16:22:08 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 52E711000D38
 for <ltp@lists.linux.it>; Tue, 29 Sep 2026 16:22:08 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 02A171F76B;
 Tue, 29 Sep 2026 14:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790691723;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z7/+8IfMaShqTewOVJ3HmmpV8km075cR/avsTO3d8Mc=;
 b=MbYI2cGsg8FxYyfb/Se5OPHAnUIcbxPWY+TBPnxegAwi4pPLDC77ATj7BLxA+EjhvYUrb/
 CfSPDrBNE4aKV/AXa1hiN+GmuRk5mXrBL8P544o3tLpkdsVo420HjZhj2vTI8qJzuGmheS
 OjSHoJh08tvvOWY/OQOWCdT/XifSvVA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790691723;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z7/+8IfMaShqTewOVJ3HmmpV8km075cR/avsTO3d8Mc=;
 b=AejsAT7ZL5LZV27rRsgj5wZcQzqQYVzdfKu3ju5IXYIA6IU23upcC/BsIGh4RyyQY9h165
 O4vFmTjnsdbVmlDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790691719;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z7/+8IfMaShqTewOVJ3HmmpV8km075cR/avsTO3d8Mc=;
 b=jnNhyd54xsRxvFx06TqCycjeG4SwA+wldGrXGetOzUOybpcUByGH53lPcXCp6xmhyzCCp8
 ndJIFobYfUw3AS/SvrGM0o69UDW0LpPbYpGQtoT0bucTzgEuxR/T4I3rVTD8jkSpH3wf7D
 x3oGpA6Un37U5Y8hCPVIyLhxkZUnn+o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790691719;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z7/+8IfMaShqTewOVJ3HmmpV8km075cR/avsTO3d8Mc=;
 b=cfMge6UruUJFeT1/q0W19iq7IWl+c0DVeMB14Brv8txr40xeES1ShcZ1k1u+ZK96PVipRH
 NLcrCN61O8xXZ9AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AB76B133F1;
 Tue, 29 Sep 2026 14:21:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id RJK1GYbJu2rfVwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 29 Sep 2026 14:21:58 +0000
Date: Tue, 29 Sep 2026 16:21:56 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Anders Roxell <anders.roxell@linaro.org>
Message-ID: <20260929142156.GB2462033@pevik>
References: <20260929084253.3093742-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260929084253.3093742-1-anders.roxell@linaro.org>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,linaro.org:email];
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] tst_clone: Fix child detection on sparc
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

Hi Anders,

> On sparc the clone syscall does not return 0 in the child. It returns
> the parent pid, so the child thinks it is the parent.

So, somebody still test sparc :). Before applying a workaround few questions.

I suppose this is because we did not updated our syscalls numbers.


I send a patch which regenerated syscall numbers to have clone3 on sparc (both
32 and 64 bit) v7.0:

$ include/lapi/syscalls/generate_arch.sh ../linux

Can you please verify it works with clone3()? It was added this year in v7.0 in
2153b2e8917b7 ("sparc: Add architecture support for clone3")

Do we care about the past?

Kind regards,
Petr

> Save the pid before the clone and compare it after.

> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>  lib/tst_clone.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

> diff --git a/lib/tst_clone.c b/lib/tst_clone.c
> index 296cd40ac0a0..d7f005a2d2a5 100644
> --- a/lib/tst_clone.c
> +++ b/lib/tst_clone.c
> @@ -20,6 +20,9 @@ pid_t tst_clone(const struct tst_clone_args *tst_args)
>  	};
>  	int flags;
>  	pid_t pid = -1;
> +#ifdef __sparc__
> +	pid_t parent_pid = tst_getpid();
> +#endif

>  	tst_flush();

> @@ -44,5 +47,10 @@ pid_t tst_clone(const struct tst_clone_args *tst_args)
>  	if (pid == -1)
>  		return -2;

> +#ifdef __sparc__
> +	if (pid == parent_pid)
> +		pid = 0;
> +#endif
> +
>  	return pid;
>  }

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
