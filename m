Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AAC4C36008
	for <ltp@archiver.kernel.org>; Tue,  1 Apr 2025 07:16:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8B21B3CB001
	for <ltp@archiver.kernel.org>; Tue,  1 Apr 2025 09:16:10 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B39523C29A4
 for <ltp@lists.linux.it>; Tue,  1 Apr 2025 09:15:54 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id CE2711400510
 for <ltp@lists.linux.it>; Tue,  1 Apr 2025 09:15:53 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C9D232118A;
 Tue,  1 Apr 2025 07:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1743491753;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NcGEbgcAPjmCENqjJSxD4H//YwMnkbXXcFPu+EehW0M=;
 b=gQHkZupV00iqKwwcu4iJaM/m0izmHXhb6IAdDZtwOP6gUX8svpu6pOBNGy0tJM0AtzD7wb
 Rkhcf6Q8756Xgc9YJU/lzsLVuIbVCMjU52jDLr6jyDoj+QNGL+w4X8gj3hRGHUZAFwhkj3
 QAZlZIJ2g+dW3yOjvE9yrqgNYwSUgyA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1743491753;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NcGEbgcAPjmCENqjJSxD4H//YwMnkbXXcFPu+EehW0M=;
 b=NTl13zXWVg5LuEQgzYLwrhDp4PueYA7OKdIqny8P14yjDniE+iBtw+9aFnfm30tyVPckb2
 R2T8TH8NTrzUv+AA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=pno8bxzL;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=KTokt8vo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1743491752;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NcGEbgcAPjmCENqjJSxD4H//YwMnkbXXcFPu+EehW0M=;
 b=pno8bxzLd3FZEQuw/UL92Euuh+GJo0c2UTS0IsCenn7Sv4CfxhhEEb26IV5Z72NxPc9HOg
 Lsb3bcssBnu1CLo1Z5ZAXWM1c/+dA6cXuFr+8OgviMmSHFFfOgpzRo4NF8xMt8v4XDBlWH
 ok9MewppzBGgYiQhhOAXcyE3GyqcNII=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1743491752;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NcGEbgcAPjmCENqjJSxD4H//YwMnkbXXcFPu+EehW0M=;
 b=KTokt8vo3hJ1BkXaG1bHFtx2Bd3V4/B/m6SqKTgMSisCriv4AOQQ+UTXMdSXfC49Xk2rAo
 V0dIahgVDThQuoCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4309313691;
 Tue,  1 Apr 2025 07:15:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id NoTQDKiS62dRUQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 01 Apr 2025 07:15:52 +0000
Date: Tue, 1 Apr 2025 09:15:50 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Dan Carpenter <dan.carpenter@linaro.org>
Message-ID: <20250401071550.GA299271@pevik>
References: <Z-pP_i-Iq4PSjoT3@stanley.mountain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Z-pP_i-Iq4PSjoT3@stanley.mountain>
X-Rspamd-Queue-Id: C9D232118A
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; ARC_NA(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_FIVE(0.00)[6];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] pty: Update slave device permission check to allow 0600
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

Hi all,

> Systemd changed the default permissions for PTY slave devices from 0620
> to 0600 in response to CVE-2024-28085.  Allow either 0620 or 0600 as
> valid permissions.

Thanks, merged!

Kind regards,
Petr

> Link: https://security-tracker.debian.org/tracker/CVE-2024-28085
> Link: https://github.com/systemd/systemd/commit/a4d18914751e687c9e44f22fe4e5f95b843a45c8
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> Tested-by: Anders Roxell <anders.roxell@linaro.org>

> diff --git a/testcases/kernel/pty/common.h b/testcases/kernel/pty/common.h
> index 51760b1d39fa..7cda16096d4d 100644
> --- a/testcases/kernel/pty/common.h
> +++ b/testcases/kernel/pty/common.h
> @@ -54,7 +54,8 @@ static inline int open_slave(const int masterfd)
>  			st.st_uid, uid);
>  	}

> -	if (st.st_mode != (S_IFCHR | 0620)) {
> +	if (st.st_mode != (S_IFCHR | 0620) &&
> +	    st.st_mode != (S_IFCHR | 0600)) {
>  		tst_brk(TBROK, "unexpected slave device permission: %o",
>  			st.st_mode);
>  	}

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
